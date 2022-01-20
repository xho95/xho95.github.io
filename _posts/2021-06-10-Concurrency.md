---
layout: post
comments: true
title:  "Swift 5.5: Concurrency (동시성)"
date:   2021-06-10 11:30:00 +0900
categories: Swift Language Grammar Concurrency
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Concurrency](https://docs.swift.org/swift-book/ReferenceManual/Statements.html) 부분[^Conccurency] 을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Concurrency (동시성)

스위프트는 비동기 및 병렬 코드의 구조적 작성을 내장 지원합니다. _비동기 코드 (asynchronous code)_ 는, 한번에 프로그램 한 조각만 실행하긴 하지만, 멈췄다 나중에 다시 할 수 있습니다. 프로그램 코드를 멈추고 다시 하는 건 네트웍 너머의 자료 가져오기나 파일 구문 해석 같이 오래-걸리는 연산이 계속되는 동안 자신의 UI 갱신 같은 단-기간 연산 진행도 계속하게 해줍니다. _병렬 코드 (parallel code)_ 는 여러 코드 조각을 동시에 실행한다는-예를 들어, 4-개의 코어 프로세서를 가진 컴퓨터는, 각 코어마다 하나의 임무를 실시하여, 동시에 코드 조각 네 개를 실행할 수 있다는-의미입니다. 병렬 및 비동기 코드를 사용하는 프로그램은 한번에 여러 개의 연산을 실시하며; 외부 시스템을 기다리는 연산은 멈춰달고, 이 코드를 더 쉽게 메모리-안전한 방식으로 작성하도록 해줍니다.

병렬 및 비동기 코드로 인한 추가적인 일정 작업의 유연함에는 복잡도 증가라는 대가가 따라 옵니다. 스위프트는 약간의 컴파일-시간 검사를 하여 의도를 나타내도록 해줍니다-예를 들어, '행위자 (actors)' 를 사용하면 '변경 가능 상태 (mutable state)' 에 안전하게 접근할 수 있습니다. 하지만, 느리고 버그 있는 코드에 '동시성' 을 추가한다고 빨라지거나 올바르게 됨을 보장하진 않습니다. 사실, 동시성을 추가하는 것은 코드를 심지어 더 디버그하기 어렵게 만들지도 모릅니다. 하지만, 동시적일 필요가 있는 코드에 스위프트 언어-수준에서 지원하는 동시성을 사용하면 스위프트가 컴파일 시간에 문제를 잡아내는 것을 도울 수 있습니다.

이 장 나머지에서는 비동기 및 병렬 코드의 이런 일반적인 조합을 가리키기 위해 _동시성 (concurrency)_ 이라는 용어를 사용합니다. 

> 전에 동시성 코드를 작성해봤으면, 쓰레드와 작업하는 것이 익숙할지도 모릅니다. 스위프트의 동시성 모델은 쓰레드 상에서 제작된 것이지만, 이들과 직접 상호 작용하진 않습니다. 스위프트의 비동기 함수는 자신이 현재 실행 중인 쓰레드를 포기하여, 그 함수를 차단하는 동안에 해당 쓰레드에서 또 다른 비동기 함수를 실행하게 할 수 있습니다.

스위프트 언어의 지원을 사용하지 않고도 동시성 코드를 작성할 수 있긴 하지만, 그런 코드는 이해하기 더 어려운 경향이 있습니다. 예를 들어, 다음 코드는 사진 이름 목록을 내려받고, 해당 목록의 첫 번째 사진을 내려받아, 사용자에게 그 사진을 보여줍니다:

```swift
listPhotos(inGallery: "Summer Vacation") { photoNames in
  let sortedNames = photoNames.sorted()
  let name = sortedNames[0]
  downloadPhoto(named: name) { photo in
    show(photo)
  }
}
```

이 단순한 경우에서도, 연속된 '완료 처리자 (completion handlers)' 로 코드를 작성해야 하기 때문에, 중첩 클로저를 작성하는 것으로 끝맺습니다. 이런 스타일에서, 중첩이 깊어져 코드가 복잡해지면 다루기가 급격히 어려워질 수 있습니다. 

### Defining and Calling Asynchronous Functions (비동기 함수 정의하기와 호출하기)

_비동기 함수 (asynchronous function)_ 또는 _비동기 메소드 (asynchronous method)_ 는 어느 정도 실행한 도중에 멈춰달 수 있는 특수한 종류의 함수 또는 메소드 입니다. 이는, 완료까지 실행하거나, 에러를 던지던가, 아니면 절대로 반환하지 않는, 평범한, '동기 함수 및 메소드' 와는 대조적입니다. '비동기 함수나 메소드' 도 여전히 이 세 가지 것을 하지만, 뭔가를 기다리는 중간에 일시 정지할 수도 있습니다. '비동기 함수나 메소드' 본문 안에서, 실행을 멈춰달 수 있는 각각의 자리를 표시합니다.

함수나 메소드가 비동기임을 지시하려면, `throws` 로 '던지는 함수' 를 표시하는 것과 비슷하게, 선언의 매개 변수 뒤에 `async` 키워드를 작성합니다. 함수나 메소드가 값을 반환하면, '반환 화살표 (`->`)' 앞에 `async` 를 작성합니다. 예를 들어, 다음은 '전시관 (gallery)' 에서 사진 이름을 가져올 법한 방법입니다:

```swift
func listPhotos(inGallery name: String) async -> [String] {
    let result = // ... 약간의 비동기 네트워크 코드 ...
    return result
}
```

함수나 메소드가 '비동기' 면서 '던지기' 까지 하면, `throws` 앞에 `async` 를 작성합니다. 

비동기 메소드를 호출할 때는, 해당 메소드의 반환까지 실행을 멈춰답니다. 호출 앞에 `await` 를 작성하여 '멈춰달 수 있는 지점' 을 표시합니다. 이는 '던지는 함수' 를 호출할 때, '에러' 면 프로그램 흐름이 바뀔 수 있음을 표시하기 위해, `try` 를 작성하는 것과 비슷합니다. 비동기 메소드 안에서의, 실행 흐름은 _오직 (only)_ 또 다른 비동기 메소드를 호출할 때만 멈춰 달립니다-'멈춰달기 (suspension)' 는 절대 '암시적' 이거나 '선점 (preemptive)'[^preemptive] 이지 않습니다-이는 '멈춰달 수 있는 모든 지점' 을 `await` 로 표시한다는 의미입니다.

예를 들어, 아래 코드는 '전시관' 의 모든 '사진 (pictures)' 이름을 가져온 다음 첫 번째 사진을 보여줍니다:

```swift
let photoNames = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[0]
let photo = await downloadPhoto(named: name)
show(photo)
```

`listPhotos(inGallery:)` 와 `downloadPhoto(named:)` 함수는 둘 다 네트워크 요청이 필요하기 때문에, 완료하기까지 상대적으로 긴 시간이 걸릴 수 있습니다. 반환 화살표 앞에 `async` 를 작성하여 둘 다 비동기로 만들면 이 코드가 사진이 준비되길 기다리는 동안 나머지 앱 코드가 계속 실행하도로 해줍니다.

위 예제의 '동시적인 본성' 을 이해하기 위한, 가능한 한 가지 실행 순서는 다음과 같습니다: 

1. 첫째 줄에서 코드 실행을 시작하며 첫 번째 `await` 에 이릅니다. `listPhotos(inGallery:)` 함수를 호출하고 해당 함수의 반환을 기다리는 동안 실행을 멈춰답니다.
2. 이 코드 실행을 멈춰단 동안, 같은 프로그램 안의 일부 다른 동시성 코드를 실행합니다. 예를 들어, 아마 길게-걸리는 배후 임무가 사진 전시관의 새 목록 갱신을 계속할 수도 있습니다. 해당 코드도, `await` 로 표시한, '그 다음 멈춰달 지점' 까지, 또는 완료할 때까지 실행합니다. 
3. `listPhotos(inGallery:)` 의 반환 후, 이 코드는 해당 지점에서 시작하여 계속 실행합니다. 이는 `photoNames` 의 반환 값을 할당합니다. 
4. `sortedNames` 와 `name` 을 정의한 줄은 표준적인, '동기 코드' 입니다. 이 줄은 `await` 로 표시한 것이 없기 때문에, '멈춰달 수 있는 어떤 지점' 도 없습니다.
5. 그 다음 `await` 는 `downloadPhoto(named:)` 함수 호출을 표시합니다. 이 코드는 해당 함수가 반환할 때까지 실행을 다시 일시 정지하여, 다른 동시성 코드에 실행 기회를 부여합니다.
6. `downloadPhoto(named:)` 의 반환 후, 반환 값을 `photo` 에 할당한 다음 이를 `show(_:)` 호출 시의 인자로 전달합니다.

코드에서 `await` 로 표시하여 '멈춰달 수 있는 지점' 은 현재 코드 조각이 비동기 함수나 메소드의 반환을 기다리는 동안 일시 정지할 수 있음을 지시합니다. 이를 _쓰레드 넘겨주기 (yielding the thread)_ 라고도 하는데, 그 이면을 살펴보면, 스위프트가 현재 쓰레드에서의 코드 실행을 멈춰달고 그 대신 해당 쓰레드에서 일부 다른 코드를 실행하기 때문입니다. `await` 를 가진 코드는 실행을 멈춰달 수 있어야 하기 때문에, 프로그램의 정해진 자리에서만 비동기 함수나 메소드를 호출할 수 있습니다:

* 비동기 함수나, 메소드, 또는 속성의 본문 코드
* `@main` 으로 표시한 구조체, 클래스, 또는 열거체의 '정적 `main() 메소드' 안에 있는 코드
* 아래 [Unstructured Concurrency (구조화 안된 동시성)](#unstructured-concurrency-구조화-안된-동시성) 에 보인 것 같이, '떼어 놓은 자식 임무 (detached child task)' 안에 있는 코드

> [Task.sleep(_:)](https://developer.apple.com/documentation/swift/task/3814836-sleep) 메소드는 동시성 작동 방법을 배우기 위한 단순한 코드의 작성 시에 유용합니다. 이 메소드는 아무 것도 안하지만, 반환 전에 최소한 주어진 나노 초 만큼은 기다립니다. 다음은 `sleep()` 을 사용하여 네트워크 연산의 기다림을 모의 실험하는 버전의 `listPhotos(inGallery:)` 함수입니다.
> 
```swift
func listPhotos(inGallery name: String) async -> [String] {
  await Task.sleep(2 * 1_000_000_000)  // 2초
  return ["IMG001", "IMG99", "IMG0404"]
}
```

### Asynchronous Sequences (비동기 시퀀스)

이전 부분에 있는 `listPhotos(inGallery:)` 함수는, 모든 배열 원소가 준비되면, 배열 전체를 한꺼번에 반환합니다. 또 다른 접근 방식은 _비동기 시퀀스 (asynchronous sequence)_[^sequence] 를 사용하여 한번에 집합체 한 원소씩 기다리는 것입니다. 다음은 비동기 시퀀스의 반복 동작을 보인 것입니다:

```swift
import Foundation

let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
  print(line)
}
```

평범한 `for`-`in` 반복문을 사용하는 대신, 위 예제는 `for` 뒤에 `await` 를 작성합니다. 비동기 함수나 메소드를 호출할 때 같이, `await` 의 작성은 '멈춰달 수 있는 지점' 을 지시합니다. `for`-`await`-`in` 반복문은 각 회차 맨 앞에서, 다음 원소가 사용 가능하길 기다릴 때, 잠재적으로 실행을 멈춰답니다.

[Sequence](https://developer.apple.com/documentation/swift/sequence) 프로토콜에 대한 준수성을 추가함으로써 자신만의 타입을 `for`-`in` 반복문에서 사용할 수 있는 것과 똑같이, [AsyncSequence](https://developer.apple.com/documentation/swift/asyncsequence) 프로토콜에 대한 준수성을 추가함으로써 자신만의 타입을 `for`-`await`-`in` 반복문에서 사용할 수 있습니다. 

### Calling Asynchronous Functions in Parallel (비동기 함수를 병렬로 호출하기)

`await` 를 가지고 비동기 함수를 호출하는 것은 한번에 한 조각의 코드만 실행합니다. 비동기 코드를 실행하는 동안, 호출하는 쪽은 그 다음 코드 줄을 실행하려 이동하기 전에 해당 코드가 종료하길 기다립니다. 예를 들어, '전시관' 에서 처음 세 사진을 가져오려면, 다음 처럼 세 개의 `downloadPhoto(named:)` 함수 호출을 기다릴 수 있습니다:

```swift
let firstPhoto = await downloadPhoto(named: photoNames[0])
let secondPhoto = await downloadPhoto(named: photoNames[1])
let thirdPhoto = await downloadPhoto(named: photoNames[2])

let photos = [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

이 접근 방식에는 중요한 결점이 있는데: 내려받기가 비동기라 진행하는 동안 다른 작업이 발생하도록 하긴 하지만, `downloadPhoto(named:)` 에 대한 호출은 한번에 하나씩만 실행한다는 것입니다. 그 다음 내려받기를 시작하기 전에 각각의 사진을 완전히 내려받습니다. 하지만, 이 연산은 기다릴 필요가 없습니다-각각의 사진은 독립적으로, 또는 심지어 동시에, 내려받을 수 있습니다.

비동기 함수를 자기 주변 코드와 병렬로 실행하도록 호출하려면, 상수를 정의할 때 `let` 앞에 `async` 를 작성한 다음, 상수를 사용할 때마다 `await` 를 작성합니다. 

```swift
async let firstPhoto = downloadPhoto(named: photoNames[0])
async let secondPhoto = downloadPhoto(named: photoNames[1])
async let thirdPhoto = downloadPhoto(named: photoNames[2])

let photos = await [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

이 예제에서, `downloadPhoto(named:)` 에 대한 세 호출 모두 이전 것의 완료를 기다리지 않고 시작합니다. 사용 가능한 시스템 자원이 충분하면, 이를 동시에 실행합니다. 이 함수 호출 어느 것도 `await` 로 표시하지 않는 것은 함수 결과를 기다리려고 코드를 멈춰달지 않기 때문입니다. 그 대신, `photo` 를 정의한 줄까지 계속 실행합니다-그 지점에서, 프로그램은 이 비동기 호출 결과가 필요하므로, `await` 를 작성하여 세 사진의 내려받기를 모두 종료할 때까지 실행을 일시 정지합니다.

다음은 이 두 접근 방식의 차이점을 생각하기 위한 방법입니다:

* 다음 줄의 코드가 해당 함수의 결과에 의존할 때 `await` 를 가지고 비동기 함수를 호출합니다. 이는 순차적으로 실시하는 작업을 생성합니다.
* 나중이 될 때까지 코드에서 결과가 필요없을 때는 `async`-`let` 을 가지고 비동기 함수를 호출합니다. 이는 병렬로 실시할 수 있는 작업을 생성합니다.
* `await` 와 `async`-`let` 는 둘 다 멈춰단 동안에 다른 코드의 실행을 허용합니다.
* 두 경우 모두, 비동기 함수의 반환까지, 필요하다면, 실행을 잠시 정지할 것임을 지시하기 위해 `await` 를 '멈춰달 수 있는 지점' 에 표시합니다.

동일 코드에서 이 두 접근 방식 둘 다를 섞을 수도 있습니다.

### Tasks and Task Groups (임무와 임무 그룹)

_임무 (task)_ 는 프로그램에서 비동기로 실행할 수 있는 작업 단위입니다. 모든 비동기 코드는 어떠한 '임무' 로써 실행합니다. 이전 부분에서 설명한 `async`-`let` 구문은 '자식 (child) 임무' 를 생성합니다. '임무 그룹 (task group)' 을 생성하고 '자식 임무' 를 해당 그룹에 추가할 수도 있는데, 이는 '우선권 (priority)' 과 '취소 (cancellation)' 에 대한 더 많은 제어를 부여하고, 동적 개수의 임무를 생성하도록 해줍니다.

'임무' 는 계층 구조로 배열합니다. '임무 그룹' 에서 각각의 '임무' 는 똑같은 '부모 (parent) 임무' 를 가지며, 각각의 '임무' 가 '자식 임무' 를 가질 수도 있습니다. '임무'와 '임무 그룹' 간의 명시적인 관계 때문에, 이 접근 방식을 _구조화된 동시성 (structured concurrency)_ 이라고 합니다. 올바르게 하기 위한 약간의 책임을 맡긴 해야 하지만, 임무 간의 명시적인 부모-자식 관계는 '취소 (cancellation) 전파하기' 같은 일부 동작을 스위프트가 처리하게 해주며, 일부 에러를 스위프트가 컴파일 시간에 탐지하도록 해줍니다. 

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

이전 부분에서 설명한 '동시성에 대한 구조화된 접근 방식' 에 더하여, 스위프트는 '구조화 안된 동시성' 도 지원합니다. '임무 그룹' 의 일부분인 '임무' 와는 달리, _구조화 안된 임무 (unstructured task)_ 는 '부모 임무' 를 가지지 않습니다. '구조화 안된 임무' 는 프로그램에 필요하다면 무슨 방식으로든 관리하는 완전한 유연함을 가지지만, 올바르게 하기 위한 책임도 완전히 져야 합니다. 현재의 '행위자' 에서 실행할 '구조화 안된 임무' 를 생성하려면, [async(priority:operation:)](https://developer.apple.com/documentation/swift/3816404-async) 함수를 호출합니다. 특히 _떼어 놓은 임무 (detached task)_ 라고 더 잘 알려진, '현재의 행위자를 이루지는 않을 구조화 안된 임무' 를 생성하려면, [asyncDetached(priority:operation:)](https://developer.apple.com/documentation/swift/3816406-asyncdetached) 를 호출합니다. 이 함수 둘 다-예를 들어, 결과를 기다리거나 취소하기 위해-임무와 상호 작용하게 해주는 '임무 핸들 (task handle)' 을 반환합니다.

```swift
let newPhoto = // ... 약간의 사진 자료 ...
let handle = async {
    return await add(newPhoto, toGalleryNamed: "Spring Adventures")
}
let result = await handle.get()
```

'떼어 놓은 임무' 의 관리에 대한 더 많은 정보는, [Task](https://developer.apple.com/documentation/swift/task/) 항목을 참고하기 바랍니다. 

#### Task Cancellation (임무 취소)

스위프트 동시성은 '협동 취소 모델 (cooperative cancellation model)' 을 사용합니다. 각각의 임무는 적절한 실행 시점에 취소됐는지 검사하고, 적절한 무슨 방식으로든 취소에 응답합니다. 하고 있는 작업에 따라, 대체로 이는 다음 중 하나를 의미합니다:

* `CancellationError` 같은 에러 던지기
* `nil` 이나 '비어 있는 집합체 (collection)' 반환하기
* 부분적으로 완료한 작업 반환하기

취소 검사를 하려면, '임무' 가 취소되면 `CancellationError` 를 던지는, [Task.checkCancellation()](https://developer.apple.com/documentation/swift/task/3814826-checkcancellation) 을 호출하든지, 아니면 [Task.isCancelled](https://developer.apple.com/documentation/swift/task/3814832-iscancelled) 의 값을 검사하여 자신의 코드에서 취소 처리를 합니다. 예를 들어, '전시관에서 사진 내려받기' 같은 임무는 '부분적으로 내려받은 것' 을 삭제하고 네트워크 연결을 닫아야 할지도 모릅니다.

취소를 수동으로 전파하려면, [Task.cancel()](https://developer.apple.com/documentation/swift/task/handle/3814781-cancel) 을 호출합니다.

### Actors (행위자)

'클래스' 같이, '행위자' 는 참조 타입이므로, [Classes Are Reference Types (클래스는 참조 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#classes-are-reference-types-클래스는-참조-타입입니다) 에 있는 '값 타입과 참조 타입 비교' 는 클래스 뿐 아니라 '행위자' 에도 적용됩니다. 클래스와 달리, '행위자' 는 한번에 자신의 '변경 가능 상태' 에 오직 한 '임무' 의 접근만을 허용하며, 이는 여러 '임무' 코드가 행위자의 동일한 인스턴스와 안전하게 상호 작용하게 해줍니다. 예를 들어, 다음은 온도를 기록하는 '행위자' 입니다:

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

'행위자' 는 `actor` 키워드와, 한 쌍의 중괄호로 된 정의를 가지고 도입합니다. `TemperatureLogger` 행위자는 행위자 밖의 다른 코드가 접근할 수 있는 '속성' 도 가지며, 행위자 안의 코드만 '최대 값' 을 갱신할 수 있도록 `max` 속성도 제약합니다.

행위자의 인스턴스는 구조체 및 클래스와 똑같은 초기자 구문으로 생성합니다. 행위자의 속성이나 메소드에 접근할 때는, '잠재적으로 멈춰달 지점' 을 표시하기 위해 `await` 를 사용합니다-예를 들면 다음과 같습니다:

```swift
let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)
// "25" 를 인쇄함
```

이 예제에서는, `logger.max` 로의 접근이 '멈춰달 수 있는 지점' 입니다. 왜냐면 '행위자' 는 한번에 자신의 '변경 가능 상태' 에 오직 한 '임무' 의 접근만을 허용해서, 또 다른 '임무' 코드가 '기록자 (logger)' 와 이미 상호 작용 중이면, 속성에 접근하길 기다리면서 이 코드를 멈춰달기 때문입니다.

이와 대조적으로, '행위자' 의 일부분인 코드는 '행위자' 의 속성에 접근할 때 `await` 를 작성하지 않습니다. 예를 들어, 다음은 `TemperatureLogger` 를 새로운 온도로 갱신하는 메소드입니다:

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

`update(with:)` 메소드는 이미 행위자에서 실행 중이므로, `max` 같은 속성의 접근을 `await` 로 표시하지 않습니다. 이 메소드는 행위자가 한번에 자신의 '변경 가능 상태' 에 오직 한 '임무' 와의 상호 작용만을 허용하는 이유도 보여주는데: '행위자' 의 상태를 일부 갱신하는 것은 일시적으로 '불변 (invariants)' 을 깨뜨리기 때문입니다. `TemperatureLogger` 행위자는 온도 목록과 최대 온도를 계속 추적하고, 새 측정 값을 기록할 때 최대 온도를 갱신합니다. 갱신 중간, 새 측정 값을 덧붙인 후 `max` 를 갱신하기 전의, '온도 기록자' 는 일시적으로 '일관성 없는 (inconsistent) 상태' 입니다. 여러 '임무' 가 동시에 똑같은 인스턴스와 상호 작용하는 것을 막는 것은 다음의 일련의 이벤트와 같은 문제들을 막아줍니다:

1. 코드가 `update(with:)` 메소드를 호출합니다. 이는 먼저 `measurement` 배열을 갱신합니다.
2. 코드가 `max` 를 갱신할 수 있기 전에, 다른 곳의 코드가 '최대 값' 과 '온도 배열' 을 읽습니다.
3. 코드가 `max` 를 바꿈으로써 갱신을 종료합니다.

이 경우, 다른 곳에서 실행하는 코드는 `update(with:)` 의 호출 중간에 일시적으로 자료가 무효인 동안 끼어든 '행위자' 에 접근하기 때문에 잘못된 정보를 읽을 것입니다. 이 문제는 스위프트의 '행위자' 를 사용할 때 막을 수 있는데 왜냐면 한번에 자신의 상태에 대한 하나의 연산만을 허용하고, 해당 코드는 `await` 로 '매달아 멈출 지점' 을 표시한 자리에서만 방해받을 수 있기 때문입니다. `update(with:)` 가 어떤 '매달아 멈출 지점' 도 담고 있지 않기 때문에, 어느 코드도 갱신 중인 자료에 접근할 수 없습니다.

클래스의 인스턴스에서 처럼, 행위자 밖에서 이 속성에 접근하려고 하면, 컴파일-시간 에러를 가지게 되는데; 예를 들면 다음과 같습니다:

```swift
print(logger.max)  // 에러
```

`await` 의 작성 없이 `logger.max` 에 접근하면 실패하는데 이는 '행위자' 의 속성이 해당 행위자의 '격리된 지역 상태 (isolated local state)' 의 일부분이기 때문입니다. 스위프트는 오직 '행위자' 안의 코드만 행위자의 '지역 상태' 에 접근할 수 있다는 것을 보증합니다. 이 보증을 _행위자 격리 (actor isolation)_ 라고 합니다.

### 다음 글

[Type Casting (타입 변환) > ]({% post_url 2020-04-01-Type-Casting %})

### 참고 자료

[^Conccurency]: 원문은 [Conccurency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html) 에서 확인할 수 있습니다.

[^preemptive]: '선점 (preemptive)' 은 CPU 를 차지한 프로세스의 자원을 운영체제가 우선 순위에 따라 강제로 빼앗을 수 있는 방식을 의미합니다. '선점 (preemptive)' 에 대한 더 자세한 내용은, 위키피디아의 [Preemption (computing)](https://en.wikipedia.org/wiki/Preemption_(computing)) 항목과 [선점 스케줄링](https://ko.wikipedia.org/wiki/선점_스케줄링) 항목을 참고하기 바랍니다.

[^sequence]: '시퀀스 (sequence)' 는 '수열' 을 의미하는 수학 용어로, 자료 구조 분야에서는 '같은 타입의 값들이 순차적으로 붙어서 나열된 구조' 를 의미합니다. '시퀀스' 에 대한 더 자세한 정보는, 위키피디아의 [Sequential access](https://en.wikipedia.org/wiki/Sequential_access) 항목과 [순차 접근](https://ko.wikipedia.org/wiki/순차_접근) 항목을 참고하기 바랍니다. 
