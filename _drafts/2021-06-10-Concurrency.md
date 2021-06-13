---
layout: post
comments: true
title:  "Swift 5.5: Concurrency (동시성)"
date:   2021-06-10 11:30:00 +0900
categories: Swift Language Grammar Concurrency
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Concurrency](https://docs.swift.org/swift-book/ReferenceManual/Statements.html) 부분[^Conccurency] 을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Concurrency (동시성)

스위프트는 비동기 코드와 병렬 코드를 구조적으로 작성하는 내장 기능을 지원합니다. _비동기 코드 (asynchronous code)_ 는, 한번에 한 조각의 프로그램만 실행하긴 하지만, 이를 매달아 멈추고 나중에 다시 시작할 수 있습니다. 프로그램의 코드를 매달아 멈추고 다시 시작하는 것은 'UI 갱신' 같은 '단기 연산' 을 하면서 동시에 네트워크 너머로 자료를 가져오거나 파일 구문을 해석하는 '장기 연산' 도 계속 진행할 수 있도록 해줍니다. _병렬 코드 (parallel code)_ 는 여러 코드 조각을 동시에 실행-예를 들어, 4-개의 코어 프로세서를 가진 컴퓨터는, 각 코어마다 하나의 임무를 실시하여, 동시에 코드 조각 네 개를 실행-할 수 있다는 의미입니다. 병렬 및 비동기 코드를 사용하는 프로그램은 한번에 여러 개의 연산을 실시하며; 외부 시스템을 기다리는 연산을 매달아 멈추고, 이런 코드를 더 쉽게 메모리-안전한 방식으로 작성하도록 해줍니다.

병렬 및 비동기 코드에 의한 추가적인 작업 일정의 유연함에는 복잡도 증가라는 비용도 따라 옵니다. 스위프트는 약간의 컴파일-시간 검사를 할 수 있게 하여 의도를 나타내도록 해줍니다-예를 들어, '행위자' 를 사용하여 '변경 가능 상태' 에 안전하게 접근할 수 있습니다. 하지만, 느리고 버그 있는 코드에 '동시성' 을 추가하는게 빨라지거나 올바르게 된다는 것을 보장하진 않습니다. 사실, 동시성을 추가하는 것은 심지어 코드를 더 디버그하기 어렵게 만들지도 모릅니다. 하지만, 동시성이 필요한 코드에서 스위프트의 언어-수준 동시성 지원을 사용하는 것은 컴파일 시간에 문제를 잡아내도록 스위프트가 돕는다는 의미입니다.

이 장 나머지에서는 비동기 및 병렬 코드의 이런 일반적인 조합을 언급하는데 _동시성 (concurrency)_ 이라는 용어를 사용합니다. 

> 전에 동시성 코드를 작성해 봤으면, 쓰레드와 작업하는 것이 익숙할지 모릅니다. 스위프트의 동시성 모델은 쓰레드 위에 제작된 것이지만, 이와 직접 상호 작용하진 않습니다. 스위프트의 비동기 함수는 실행 중인 쓰레드를 포기할 수 있는데, 이는 첫 번째 함수를 차단하는 동안에 해당 쓰레드 상에서 다른 비동기 함수를 실행하도록 해줍니다. 

스위프트의 언어 지원을 사용하지 않고도 동시성 코드를 작성하는 것이 가능하긴 하지만, 그런 코드는 이해하기 더 어려운 경향이 있습니다. 예를 들어, 다음 코드는 사진 이름 목록을 내려받고, 해당 목록의 첫 번째 사진을 내려받은 다음, 그 사진을 사용자에게 보여줍니다:

```swift
listPhotos(inGallery: "Summer Vacation") { photoNames in
  let sortedNames = photoNames.sorted()
  let name = sortedNames[1]
  downloadPhoto(named: name) { photo in
    show(photo)
  }
}
```

이런 단순한 경우에서도, 연속된 '완료 처리자 (completion handlers)' 로 코드를 작성해야 하기 때문에, 중첩된 클로저를 작성하는 것으로 끝맺게 됩니다. 이런 스타일에서는, 중첩이 깊어져 복잡해지면 코드를 다루기가 급격히 더 어려워질 수 있습니다. 

### Defining and Calling Asynchronous Functions (비동기 함수 정의하기와 호출하기)

_비동기 함수 (asynchronous function)_ 또는 _비동기 메소드 (asynchronous method)_ 는 어느 정도 실행한 도중에 매달아서 멈출 수 있는 특수한 종류의 함수 또는 메소드 입니다. 이는 완료까지 실행하거나, 에러를 던지던가, 아니면 절대로 반환하지 않는, 평범한, 동기 함수 및 메소드와는 대조적입니다. 비동기 함수나 메소드도 여전히 이 세 가지 것들을 하지만, 뭔가를 기다리는 중간에 일시 정지할 수도 있습니다. 비동기 함수나 메소드 본문 안에서, 실행을 매달아 멈출 수 있는 이 자리들 각각을 표시합니다.

함수나 메소드가 비동기임을 지시하려면, '던지는 함수' 를 표시하는 `throws` 의 사용 방법과 비슷하게, 선언에서 매개 변수 뒤에 `async` 키워드를 작성합니다. 함수나 메소드가 값을 반환할 경우, `async` 를 '반환 화살표 (`->`)' 앞에 작성합니다. 예를 들어, 다음은 '전시관 (gallery)' 에서 사진의 이름을 가져올 수 있는 방법입니다:

```swift
func listPhotos(inGallery name: String) async -> [String] {
    let result = // ... 약간의 비동기 네트워크 코드 ...
    return result
}
```

'비동기' 면서 '던지기' 도 하는 함수나 메소드면, `throws` 앞에 `async` 를 작성합니다. 

비동기 메소드를 호출할 때는, 해당 메소드가 반환할 때까지 실행을 매달아 멈춥니다. 호출 앞에 `await` 를 작성하여 매달아 멈출 가능성이 있는 지점을 표시합니다. 이는 '던지는 함수' 를 호출할 때, 에러가 있으면 프로그램 흐름이 바뀔 수 있음을 표시하는, `try` 를 작성하는 것과 비슷합니다. 비동기 메소드 안에서는, _오직 (only)_ 또 다른 비동기 메소드를 호출할 때만 실행의 흐름을 매달아 멈춥니다-'매달아 멈추기 (suspension)' 는 절대로 '암시적' 이거나 '선점 (preemptive)'[^preemptive] 하지 않습니다-이는 매달아 멈출 수 있는 모든 지점을 `await` 로 표시한다는 의미입니다.

예를 들어, 아래 코드는 '전시관' 에 있는 모든 사진의 이름을 가져온 다음 첫 번째 사진을 보여줍니다:

```swift
let photoNames = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[1]
let photo = await downloadPhoto(named: name)
show(photo)
```

`listPhotos(inGallery:)` 와 `downloadPhoto(named:)` 함수 둘 다 네트워크 요청이 필요하기 때문에, 완료하려면 상대적으로 긴 시간이 걸릴 수 있습니다. 둘 다 반환 화살표 앞에 `async` 를 작성하여 비동기로 만들면 이 코드가 사진이 준비되길 기다리는 동안 앱의 나머지 코드를 계속 실행하게 해줍니다.

위 예제의 '동시성' 을 이해하는 방법으로, 다음은 한 가지 가능한 실행 순서입니다: 

1. 코드는 첫 번째 줄에서 시작하여 첫 번째 `await` 까지 실행합니다. `listPhotos(inGallery:)` 함수를 호출하고 해당 함수가 반환하길 기다리는 동안 실행을 매달아 멈춥니다. 
2. 이 코드 실행이 매달려 멈춘 동안, 동일한 프로그램의 다른 동시성 코드를 실행합니다. 예를 들어, 오래-걸리는 배경 작업 임무가 새로운 사진 전시관 목록을 계속 갱신할 수 있습니다. 해당 코드도 `await` 로 표시한, 그 다음 '매달아 멈출 지점' 까지나, 완료할 때까지 실행합니다. 
3. `listPhotos(inGallery:)` 가 반환한 후에, 이 코드는 해당 지점에서 실행을 계속 시작합니다. 이는 `photoNames` 가 반환한 값을 할당합니다. 
4. `sortedNames` 와 `name` 을 정의한 줄은 표준적인, 동기 코드입니다. 이 줄에는 `await` 로 표시한 것이 없기 때문에, '매달아 멈출 수 있는 어떤 지점' 도 없습니다.
5. 그 다음 `await` 는 `downloadPhoto(named:)` 함수에 표시합니다. 이 코드는, 다른 동시성 코드에 실행할 기회를 부여하면서, 해당 함수가 반환할 때까지 실행을 다시 일시 정지합니다. 
6. `downloadPhoto(named:)` 반환 후에, 반환 값을 `photo` 에 할당한 다음 `show(_:)` 를 호출할 때 인자로 전달합니다.

코드에서 `await` 로 표시하여 매달아 멈출 가능성 있는 지점은 비동기 함수나 메소드가 반환하길 기다리는 동안 현재 코드 조각이 일시 정지할 지도 모른다고 지시합니다. 이를 _쓰레드 양도하기 (yielding the thread)_ 라고도 하는데, 그 이면을 살펴보면, 스위프트가 현재 쓰레드에 대한 코드 실행을 매달아 멈추고 그 대신 해당 쓰레드에서 다른 코드를 실행하기 때문입니다. `await` 를 가진 코드는 실행을 매달아 멈출 수 있어야 하기 때문에, 프로그램의 정해진 자리에서만 비동기 함수나 메소드를 호출할 수 있습니다:

* 비동기 함수, 메소드, 또는 속성 본문 안의 코드
* `@main` 으로 표시한 구조체, 클래스, 또는 열거체의 정적 `main() 메소드 안의 코드
* 아래 [Unstructured Concurrency (구조화 안된 동시성)](#unstructured-concurrency-구조화-안된-동시성) 에서 보인 것처럼, '떼어 놓은 자식 임무 (detached child task)' 안의 코드

> [Task.sleep(_:)](https://developer.apple.com/documentation/swift/task/3814836-sleep) 메소드는 동시성 작업 방법을 배우기 위한 단순한 코드를 작성할 때 유용합니다. 이 메소드는 아무 것도 안하지만, 반환하기 전에 최소 주어진 나노 초의 시간만큼 기다립니다. 다음은 네트워크 연산의 기다림을 모의 실험하기 위해 `sleep()` 을 사용하는 `listPhotos(inGallery:)` 함수 버전입니다.
> 
```swift
func listPhotos(inGallery name: String) async -> [String] {
    await Task.sleep(2 * 1_000_000_000)  // 2 초
    return ["IMG001", "IMG99", "IMG0404"]
}
```

### Asynchronous Sequences (비동기 시퀀스)

이전 부분에 있는 `listPhotos(inGallery:)` 함수는, 배열의 모든 원소가 준비되면, 배열 전체를 한꺼번에 반환합니다. 또 다른 접근 방식은 _비동기 시퀀스 (asynchronous sequence)_ 를 사용하여 집합체 원소를 한번에 하나씩 기다리는 것입니다. 다음은 비동기 시퀀스에 동작을 반복하는 것을 보인 것입니다:

```swift
import Foundation

let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
    print(line)
}
```

평범한 `for`-`in` 반복문을 사용하는 대신, 위 예제는 `for` 뒤에 `await` 를 작성합니다. 비동기 함수나 메소드를 호출할 때와 같이, `await` 를 작성하는 것은 '매달아 멈출 가능성 있는 지점' 을 지시합니다. `for`-`await`-`in` 반복문은 잠재적으로, 다음 원소가 사용 가능하길 기다릴 때, 각 회차 맨 앞에서 실행을 매달아 멈춥니다.

[Sequence](https://developer.apple.com/documentation/swift/sequence) 프로토콜 준수성을 추가함으로써 자신만의 타입을 `for`-`in` 반복문에서 사용할 수 있는 것과 똑같이, [AsyncSequence](https://developer.apple.com/documentation/swift/asyncsequence) 프로토콜 준수성을 추가함으로써 자신만의 타입을 `for`-`await`-`in` 반복문에서 사용할 수 있습니다. 

### Calling Asynchronous Functions in Parallel (비동기 함수를 병렬로 호출하기)

`await` 를 가진 비동기 함수 호출은 한번에 한 조각의 코드만 실행합니다. 비동기 코드를 실행하는 동안, 호출하는 쪽은 그 다음 코드 줄을 실행하려고 이동하기 전에 해당 코드가 종료하길 기다립니다. 예를 들어, 전시관에서 처음 세 사진을 가져오기 위해, 다음 처럼 `downloadPhoto(named:)` 함수에 대한 세 개의 호출을 기다릴 수 있습니다:

```swift
let firstPhoto = await downloadPhoto(named: photoNames[0])
let secondPhoto = await downloadPhoto(named: photoNames[1])
let thirdPhoto = await downloadPhoto(named: photoNames[2])

let photos = [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

이 접근 방식에는 중요한 결점이 있는데: 내려받기가 비동기고 진행 중에 다른 작업이 발행하도록 하긴 하지만, `downloadPhoto(named:)` 호출을 한번에 하나씩만 실행한다는 것입니다. 각각의 사진은 그 다음 내려받기를 시작하기 전에 내려받기를 완료합니다. 하지만, 이 연산을 기다릴 필요는 없습니다-각각의 사진은 독립적으로, 또는 심지어 동시에, 내려받을 수 있습니다.

비동기 함수를 호출하여 이를 자기 주변 코드와 병렬로 실행하게 하려면, 상수를 정의할 때 `let` 앞에 `async` 를 작성한 다음, 매 번 상수를 사용할 때마다 `await` 를 작성합니다. 

```swift
async let firstPhoto = downloadPhoto(named: photoNames[0])
async let secondPhoto = downloadPhoto(named: photoNames[1])
async let thirdPhoto = downloadPhoto(named: photoNames[2])

let photos = await [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

이 예제에서, 세 `downloadPhoto(named:)` 호출은 모두 이전 것이 완료하길 기다리지 않고 시작합니다. 사용 가능한 시스템 자원이 충분하면, 이들을 동시에 실행합니다. 이 함수 호출 중 어느 것도 `await` 로 표시하지 않는데 함수의 결과를 기다리기 위해 코드를 매달아 멈추지 않기 때문입니다. 그 대신, `photo` 를 정의한 줄까지 실행을 계속합니다-그 시점에서, 이 비동기 호출의 결과가 프로그램에 필요하므로, 사진 세 개의 내려받기를 모두 종료할 때까지 실행을 일시 정지하기 위해 `await` 를 작성합니다. 

다음은 이 두 접근 방식 사이의 차이점을 생각하기 위한 방법입니다:

* 다음 줄의 코드가 해당 함수의 결과에 의존할 때는 `await` 를 가지고 비동기 함수를 호출합니다. 이는 순차적으로 실시하는 작업을 생성합니다.
* 코드에서 나중까지 결과가 필요하지 않을 때는 `async`-`let` 을 가지고 비동기 함수를 호출합니다. 이는 병렬로 실시할 수 있는 작업을 생성합니다.
* `await` 와 `async`-`let` 둘 다 이들을 매달아 멈출 동안 다른 코드의 실행을 허용합니다.
* 두 경우 모두, 필요하다면, 비동기 함수가 반환할 때까지, 실행을 일시 정지할 것을 지시하기 위해 '매달아 멈출 가능성 있는 지점' 을 `await` 로 표시합니다.

동일한 코드에서 이 두 접근 방식을 혼합할 수도 있습니다.

### Tasks and Task Groups (임무와 임무 그룹)

_임무 (task)_ 는 프로그램에서 비동기로 실행할 수 있는 작업의 단위입니다. 모든 비동기 코드는 어떠한 '임무' 로써 실행됩니다. 이전 부분에서 설명한 `async`-`let` 구문은 '자식 임무 (child task)' 를 생성합니다. '임무 그룹 (task group)' 을 생성하여 '자식 임무' 를 해당 그룹에 추가할 수도 있는데, 이는 '우선권 (priority)' 과 '취소 (cancellation)' 에 대한 더 많은 제어를 부여하며, 동적 개수의 임무를 생성하게 해줍니다.

'임무' 는 계층 구조로 배열됩니다. '임무 그룹' 안의 각 '임무' 는 똑같은 '부모 임무 (parent task)' 를 가지고 있으며, 각각의 '임무' 는 '자식 임무' 를 가질 수 있습니다. 임무와 임무 그룹 사이의 명시적인 관계로 인하여, 이 접근 방식을 _구조화된 동시성 (structured concurrency)_ 이라 합니다. 올바름에 대한 일부 책임을 맡아야 하긴 하지만, 임무 사이의 명시적인 부모-자식 관계는 취소 전파하기 같은 일부 동작을 스위프트가 처리하도록 해주며, 스위프트가 컴파일 시간에 일부 에러를 감지하도록 해줍니다. 

```swift
await withTaskGroup(of: Data.self) { taskGroup in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        taskGroup.async { await downloadPhoto(named: name) }
    }
}
```

'임무 그룹' 에 대한 더 많은 정보는, [TaskGroup](https://developer.apple.com/documentation/swift/taskgroup) 항목을 참고하기 바랍니다. 

#### Unstructured Concurrency (구조화 안된 동시성)

이전 부분에서 설명한 동시성의 '구조화된 (structured) 접근 방식' 에 더하여, 스위프트는 '구조화 안된 (unstructured) 동시성' 도 지원합니다. '임무 그룹' 에 있는 '임무' 와는 달리, _구조화 안된 임무 (unstructured task)_ 는 '부모 임무' 를 가지지 않습니다. '구조화 안된 임무' 를 관리하는데는 뭐가 됐든 프로그램이 필요한 방식으로 완전한 유연함을 가지지만, 올바름에 대한 책임도 완전히 책임져야 합니다. 현재 '행위자' 에서 실행할 '구조화 안된 임무' 를 생성하려면, [async(priority:operation:)](https://developer.apple.com/documentation/swift/3816404-async) 함수를 호출합니다. 현재 '행위자' 가 아닌 '구조화 안된 임무' 를 생성하려면, 특히 _떼어 놓은 임무_ 라고 더 잘 알려진, [asyncDetached(priority:operation:)](https://developer.apple.com/documentation/swift/3816406-asyncdetached) 를 호출합니다. 이 함수 둘 다 임무와 상호 작용하게 해주는-예를 들어, 결과를 기다리기 위해 또는 취소하기 위해-'임무 핸들 (task handle)' 을 반환합니다

```swift
let newPhoto = // ... 약간의 사진 자료 ...
let handle = async {
    return await add(newPhoto, toGalleryNamed: "Spring Adventures")
}
let result = await handle.get()
```

'떼어 놓은 임무' 의 관리에 대한 더 많은 정보는, [Task.Handle](https://developer.apple.com/documentation/swift/task/handle) 항목을 참고하기 바랍니다. 

#### Task Cancellation (임무 취소)

스위프트 동시성은 '협동 취소 모델 (cooperative cancellation model)' 을 사용합니다. 각각의 임무는 적절한 실행 순간에 취소됐는 지를 검사하고, 뭐가 됐든 적절한 방식으로 취소에 응답합니다. 하고 있는 작업에 따라, 이는 대체로 다음 중 하나를 의미합니다:

* `CancellationError` 같은 에러 던지기
* `nil` 또는 '빈 집합체 (collection)' 반환하기
* 부분적으로 완료한 작업 반환하기

취소를 검사하려면, '임무' 를 취소하면 `CancellationError` 를 던지는, [Task.checkCancellation()](https://developer.apple.com/documentation/swift/task/3814826-checkcancellation) 을 호출하거나, 아니면 [Task.isCancelled](https://developer.apple.com/documentation/swift/task/3814832-iscancelled) 의 값을 검사하고 자신의 코드에서 취소를 처리합니다. 예를 들어, '전시관' 에서 사진을 내려받는 임무는 '부분적인 내려받기' 는 취소하고 네트워크 연결을 닫아야 할지도 모릅니다.

수동으로 취소를 전파하려면, [Task.Handle.cancel()](https://developer.apple.com/documentation/swift/task/handle/3814781-cancel) 을 호출합니다.

### Actors (행위자)

클래스와 같이, '행위자' 는 참조 타입이므로, [Classes Are Reference Types (클래스는 참조 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#classes-are-reference-types-클래스는-참조-타입입니다) 에 있는 '값 타입' 과 '참조 타입' 의 비교는 클래스 뿐만 아니라 '행위자' 에도 적용됩니다. 클래스와 달리, '행위자' 는 '변경 가능 상태' 에 한번에 오직 한 '임무' 만 접근을 허용하며, 이는 여러 개의 임무를 가진 코드가 똑같은 행위자 인스턴스와 안전하게 상호 작용하도록 합니다. 예를 들어, 다음은 온도를 기록하는 '행위자' 입니다:

```swift
actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}
```

'행위자' 는 `actor` 키워드와, 한 쌍의 중괄호 안의 정의를 가지고 도입니다. `TemperatureLogger` 행위자에는 행위자 밖의 다른 코드가 접근할 수 있는 '속성' 을 가지며, 행위자 안에 있는 코드만 최대 값을 갱신할 수 있도록 `max` 속성을 제약합니다.

행위자의 인스턴스는 구조체 및 클래스와 똑같은 초기자 구문을 사용하여 생성합니다. 행위자의 속성이나 메소드에 접근할 때는, '잠재적으로 매달아 멈출 지점' 을 표시하기 위해 `await` 를 사용합니다-예를 들면 다음과 같습니다:

```swift
let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)
// "25" 를 인쇄합니다
```

이 예제에서, `logger.max` 로의 접근은 '매달아 멈출 가능성 있는 지점' 입니다. 왜냐면 '행위자' 는 '변경 가능 상태' 에 한번에 하나의 '임무' 만 접근을 허용하며, 또 다른 임무 코드가 이미 '기록자 (logger)' 와 상호 작용하고 있으면, 속성에 접근하길 기다리는 동안 이 코드를 매달아 멈추기 때문입니다.

이와 대조적으로, '행위자' 를 이루는 코드는 '행위자' 의 속성에 접근할 때 `await` 를 작성하지 않습니다. 예를 들어, 다음은 새로운 온도를 가지고 `TemperatureLogger` 를 갱신하는 메소드입니다:

```swift
extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}
```

`update(with:)` 메소드는 이미 행위자에서 실행하는 것이므로, `max` 같은 속성에 접근하는데 `await` 를 표시하지 않습니다. 이 메소드는 행위자가 자신의 '변경 가능 상태' 가 한번에 하나의 '임무' 와만 상호 작용을 허용하는 이유 중 하나도 보여주는데: '행위자' 의 일부 상태를 갱신하는 것은 일시적으로 '불변값 (invariants)' 을 깨뜨리기 때문입니다. `TemperatureLogger` 행위자는 온도의 목록과 최대 온도를 계속 추적하며, 새 측정 값을 기록할 때 최대 온도를 갱신합니다. 갱신하는 중간에, 새 측정 값을 덧붙인 후 `max` 를 갱신하기 전, '온도 기록자' 는 일시적으로 '일관성 없는 (inconsistent) 상태' 가 됩니다. 여러 개의 '임무' 가 동시에 똑같은 인스턴스와 상호 작용하는 것을 막는 것은 일련의 이벤트와 같은 다음 문제들을 막아줍니다:

1. 코드에서 `update(with:)` 메소드를 호출합니다. 이는 첫 번째로 `measurement` 배열을 갱신합니다.
2. 코드가 `max` 를 갱신하기 전에, 다른 곳의 코드가 '최대 값' 과 '온도 배열' 을 읽습니다.
3. `max` 를 바꿈으로써 코드가 갱신을 종료합니다.

이 경우, 다른 곳에서 실행하는 코드는 자료가 일시적으로 무효인 `update(with:)` 호출 중간에 '행위자' 접근이 끼어들었기 때문에 잘못된 정보를 읽을 것입니다. 스위프트의 '행위자' 를 사용할 때는, 자신의 상태에 대해 한번에 하나의 연산만을 허용하기 때문에, 그리고 '매달아 멈출 지점' 을 `await` 로 표시한 곳에서만 해당 코드를 방해할 수 있기 때문에, 이 문제를 막을 수 있습니다.  

`update(with:)` 는 어떤 '매달아 멈출 지점' 도 담고 있지 않기 때문에, 그 어느 코드도 갱신하는 중간에 자료에 접근할 수 없습니다.

행위자 밖에서 이 속성에, 클래스 인스턴스에서 하는 것 같이, 접근하려고 하면, 컴파일-시간 에러를 가지게 되는데; 예를 들면 다음과 같습니다:

```swift
print(logger.max)  // 에러
```

액터의 속성이 해당 액터의 격리 된 로컬 상태의 일부이기 때문에 await를 작성하지 않고 logger.max에 액세스하면 실패합니다. Swift는 액터 내부의 코드 만 액터의 로컬 상태에 액세스 할 수 있도록 보장합니다. 이 보장을 행위자 격리라고합니다.

### 다음 글

[Type Casting (타입 변환) > ]({% post_url 2020-04-01-Type-Casting %})

### 참고 자료

[^Conccurency]: 원문은 [Conccurency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html) 에서 확인할 수 있습니다.

[^preemptive]: '선점 (preemptive)' 은 CPU 를 차지한 프로세스의 자원을 운영체제가 우선 순위에 따라 강제로 빼앗을 수 있는 방식을 의미합니다. '선점 (preemptive)' 에 대한 더 자세한 내용은, 위키피디아의 [Preemption (computing)](https://en.wikipedia.org/wiki/Preemption_(computing)) 항목과 [선점 스케줄링](https://ko.wikipedia.org/wiki/선점_스케줄링) 항목을 참고하기 바랍니다. 