---
layout: post
title:  "Swift 문법 정리: 프로토콜 확장(Protocol Extensions)에 구속조건(Constraints) 추가하기"
date:   2016-03-03 23:30:00 +0900
categories: Swift Grammar Protocol Constraints
---

여기서는 프로토콜 확장에서 구속조건을 추가하는 방법을 알아봅니다. 관련 내용은 **The Swift Programming Language** 의 2.2 버전의 내용을 기준으로 예제를 새로 구성한 것입니다.[^Constraints]

프로토콜 확장에서 구속조건을 사용하는 것은 프로토콜 기반 프로그래밍(Protocol Oriented Programming)의 핵심 기능이라고 할 수 있습니다.[^POP], [^RayWenderlich] 앞으로 관련 내용을 습득해 가면서 계속해서 이 포스트를 업데이트할 예정입니다.


### 프로토콜 확장(Protocol Extensions)에 구속조건(Constraints) 추가하기

프로토콜 확장(Protocol Extensions)을 정의할 때는, 구속조건(Constraints)을 지정해서 프로토콜을 따르는 타입들이 조건을 만족할 때만 확장에 있는 멤버 함수들과 속성들을 사용하도록 할 수 있습니다. 이 구속조건은 프로토콜의 이름 뒤에 `where` 구절을 사용해서 붙일 수 있습니다.

예를 들면, 아래 예제와 같이 CollectionType 프로토콜에 확장을 정의할 때, 컬랙션(collection)의 요소가 Summable일 때만 적용되도록 할 수 있습니다.

```swift
protocol Summable {
  var sum: Int { get }
}

extension Summable {
  var sum: Int {
    get {
      return 0
    }
  }
}

extension Int: Summable {
  var sum: Int {
    get {
      return self.hashValue
    }
  }
}

extension CollectionType where Generator.Element: Summable {
  var sum: Int {
    let itemsSum = self.map({ $0.sum }).reduce(0, combine: +)

    return itemsSum
  }
}

let testInt = [1, 2, 3, 4, 5]

print("\(testInt.sum)")
```

위의 코드는 **The Swift Programming Language** 문서의 예제를 기반으로 직접 만들어 본 것입니다.[^code-samples]

우선 Summable이라는 프로토콜을 만들고, Int가 이 프로토콜을 따르도록 Int를 확장했습니다. 그리고 임의의 CollectionType 중에서 Element가 Summable 타입일 때만 사용할 수 있는 sum이라는 속성을 만들었습니다.

이제 위의 testInt 처럼 Summable 타입들을 가진 Collection의 경우 sum 이라는 속성을 이용해서 해당 collection들의 합을 구할 수 있습니다.

**The Swift Programming Language** 문서의 설명에 따르면, 프로토콜을 따르는 타입이 여러 확장의 요구 조건을 만족해서 같은 멤버 함수와 속성을 중복해서 제공할 경우, Swift는 가장 상세한 구속조건에 대응하는 구현을 사용한다고 합니다.


### 고찰 하기

앞으로 **The Swift Programming Language** 문서의 프로토콜 전체 내용을 옮기면서 프로토콜 기반 프로그래밍과 관련된 내용도 추가하도록 할 예정입니다.

Protocol Extensions를 프로토콜 확장이라고 옮기는 것이 맞는지 잘 모르겠습니다. Keyword는 그냥 영어를 그대로 두는 것이 더 나을거 같기도 합니다.  


### 참고 자료

[^Constraints]: [Protocol Extensions](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html#//apple_ref/doc/uid/TP40014097-CH25-ID267)

[^POP]: [Protocol Oriented Programming](https://developer.apple.com/videos/play/wwdc2015/408/)

[^RayWenderlich]: [Introducing Protocol-Oriented Programming in Swift 2](https://www.raywenderlich.com/109156/introducing-protocol-oriented-programming-in-swift-2)

[^code-samples]: [Protocol extensions constraints in Swift](http://www.code-samples.ru/node/209) 예제를 작성할 때 참고한 자료 중 하나입니다. 실제 흐름만 참고한 것이지만 해당 사이트에는 다른 자료들도 많은 것 같아서 링크 기록을 남깁니다.
