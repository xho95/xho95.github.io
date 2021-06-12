---
layout: post
comments: true
title:  "Swift 5.5: Concurrency (동시성)"
date:   2021-06-10 11:30:00 +0900
categories: Swift Language Grammar Concurrency
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Concurrency](https://docs.swift.org/swift-book/ReferenceManual/Statements.html) 부분[^Conccurency] 을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Concurrency (동시성)

스위프트는 비동기 코드와 병렬 코드를 구조적으로 작성하는 내장 기능을 지원합니다. _비동기 코드 (asynchronous code)_ 는, 한번에 한 조각의 프로그램만 실행하긴 하지만, 이를 매달아 멈추고 나중에 다시 시작할 수 있습니다. 프로그램의 코드를 매달아 멈추고 다시 시작하는 것은 'UI 갱신' 같은 '단기 연산' 을 하면서 동시에 네트워크 너머로 자료를 가져오거나 파일 구문을 해석하는 '장기 연산' 도 계속 진행할 수 있도록 해줍니다. _병렬 코드 (parallel code)_ 는 여러 코드 조각을 동시에 실행-예를 들어, 4-개의 코어 프로세서를 가진 컴퓨터는, 각 코어마다 하나의 임무를 실시하여, 똑같은 시간에 코드 조각 네 개를 실행-할 수 있다는 의미입니다. 병렬 및 비동기 코드를 사용하는 프로그램은 한번에 여러 개의 연산을 실시하며; 외부 시스템을 기다리는 연산을 매달아 멈추고, 이런 코드를 더 쉽게 메모리-안전한 방식으로 작성하도록 해줍니다.

병렬 및 비동기 코드에 의한 추가적인 작업 일정의 유연함에는 복잡도 증가라는 비용도 따라 옵니다. 스위프트는 약간의 컴파일-시간 검사를 할 수 있게 하여 의도를 나타내도록 해줍니다-예를 들어, '행위자' 를 사용하여 '변경 가능한 상태' 에 안전하게 접근할 수 있습니다. 하지만, 느리고 버그 있는 코드에 '동시성' 을 추가하는게 빨라지거나 올바르게 된다는 것을 보장하진 않습니다. 사실, 동시성을 추가하는 것은 심지어 코드를 더 디버그하기 어렵게 만들지도 모릅니다. 하지만, 동시성이 필요한 코드에서 스위프트의 언어-수준 동시성 지원을 사용하는 것은 컴파일 시간에 문제를 잡아내도록 스위프트가 돕는다는 의미입니다.

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

이 접근 방식에는 중요한 결점이 있는데: 

```swift
async let firstPhoto = downloadPhoto(named: photoNames[0])
async let secondPhoto = downloadPhoto(named: photoNames[1])
async let thirdPhoto = downloadPhoto(named: photoNames[2])

let photos = await [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

### Tasks and Task Groups (임무와 임무 그룹)

```swift
await withTaskGroup(of: Data.self) { taskGroup in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        taskGroup.async { await downloadPhoto(named: name) }
    }
}
```

#### Unstructured Concurrency (구조화 안된 동시성)

```swift
let newPhoto = // ... 약간의 사진 자료 ...
let handle = async {
    return await add(newPhoto, toGalleryNamed: "Spring Adventures")
}
let result = await handle.get()
```

#### Task Cancellation (임무 취소)

### Actors (행위자)

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

```swift
let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)
// "25" 를 인쇄합니다
```

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

```swift
print(logger.max)  // 에러
```

### 다음 글

[Type Casting (타입 변환) > ]({% post_url 2020-04-01-Type-Casting %})

### 참고 자료

[^Conccurency]: 원문은 [Conccurency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html) 에서 확인할 수 있습니다.

[^preemptive]: '선점 (preemptive)' 은 CPU 를 차지한 프로세스의 자원을 운영체제가 우선 순위에 따라 강제로 빼앗을 수 있는 방식을 의미합니다. '선점 (preemptive)' 에 대한 더 자세한 내용은, 위키피디아의 [Preemption (computing)](https://en.wikipedia.org/wiki/Preemption_(computing)) 항목과 [선점 스케줄링](https://ko.wikipedia.org/wiki/선점_스케줄링) 항목을 참고하기 바랍니다. 