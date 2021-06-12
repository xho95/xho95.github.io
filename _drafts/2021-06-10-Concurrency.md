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



### Defining and Calling Asynchronous Functions (비동기 함수 정의하기와 호출하기)

```swift
func listPhotos(inGallery name: String) async -> [String] {
    let result = // ... 약간의 비동기 네트워크 작업 코드 ...
    return result
}
```

```swift
let photoNames = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[1]
let photo = await downloadPhoto(named: name)
show(photo)
```

```swift
func listPhotos(inGallery name: String) async -> [String] {
    await Task.sleep(2 * 1_000_000_000)  // 2 초
    return ["IMG001", "IMG99", "IMG0404"]
}
```

### Asynchronous Sequences (비동기 시퀀스)

```swift
import Foundation

let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
    print(line)
}
```

### Calling Asynchronous Functions in Parallel (비동기 함수를 병렬로 호출하기)

```swift
let firstPhoto = await downloadPhoto(named: photoNames[0])
let secondPhoto = await downloadPhoto(named: photoNames[1])
let thirdPhoto = await downloadPhoto(named: photoNames[2])

let photos = [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

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

#### Unstructured Concurrency (구조화되지 않은 동시성)

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
