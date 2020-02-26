---
layout: post
comments: true
title:  "Swift 5.2: Protocols (규칙)"
date:   2016-03-03 23:30:00 +0900
categories: Swift Language Grammar Protocol
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Protocols](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#)[^Protocols] 중에서 일부분을 정리한 글입니다.

## Protocols[^Protocol]

### Protocols as Types (프로토콜을 타입으로 사용하기)

프로토콜은 실제로는 어떤 기능 (functionality) 도 스스로 구현하지 않습니다. 그럼에도 불구하고 코드 내에서 온전한 타입인 것처럼 사용할 수 있습니다. 프로토콜을 타입인 것처럼 사용하는 것을 _실존 타입_ 이라 부르기도 하는데, 이것은 " 타입 T 는 **실** 제로 **존** 재하며, T 는 이 프로토콜을 준수한다" 는 문구에서 비롯된 것입니다.

다른 타입들이 허용되는 많은 곳에서 프로토콜을 사용할 수 있습니다. 가령 다음과 같은 곳들 입니다:

* 함수, 메소드 (method) 또는 초기자 (initializer) 의 매개 변수 타입이나 반환 타입으로써
* 상수, 변수 또는 속성 (property) 의 타입으로써
* 배열, 딕셔너리 (dictionary) 또는 다른 컨테이너 (container) 에 있는 요소 (item) 들의 타입으로써

> 프로토콜은 타입이므로 이름은 대문자로 시작합니다. (`FullyNamed` 와 `RandomNumberGenerator` 처럼요) 스위프트에 있는 다른 타입들의 이름과 맞춰야 하기 때문입니다. (`Int`, `String`, 그리고 `Double` 이 그렇습니다.)

다음은 프로토콜을 타입으로 사용하는 예입니다:

```swift
class Dice {
  let sides: Int
  let generator: RandomNumberGenerator
  init(sides: Int, generator: RandomNumberGenerator) {
    self.sides = sides
    self.generator = generator
  }
  func roll() -> Int {
    return Int(generator.random() * Double(sides)) + 1
  }
}
```

이 예제는 `Dice` 라는 새로운 클래스로 보드 게임에 사용될 n면체 주사위를 정의합니다. `Dice` 인스턴스에 있는 `sides` 라는 정수 속성은 주사위-면의 개수를 나타내며, `generator` (생성기) 라는 속성은 난수 발생기를 제공하여 '주사위 굴림 값'을 생성합니다.

`generator` 속성의 타입은 `RandomNumberGenerator` 입니다. 따라서 `RandomNumberGenerator` 프로토콜을 따른다면 어떤 타입의 인스턴스라도 설정할 수 있습니다. 이 속성에 할당하는 인스턴스로 필요한 사항은 반드시 `RandomNumberGenerator` 프로토콜을 따라야 한다는 것 한가지 뿐입니다. 타입이  `RandomNumberGenerator` 이므로, 이 프로토콜을 준수하는 모든 생성기들 (generators) 에 (공통으로) 적용되는 방식으로만, `Dice` 클래스와 `generator` 가 상호 작용할 수 있습니다. 이 말은 생성기의 실제 타입 (underlying type) 에 정의된 메소드나 속성은 사용할 수 없다는 의미입니다. 하지만 상위 클래스에서 하위 클래스로 내림 형변환 (downcast) 이 가능한 것처럼 프로토콜 타입에서 실제 타입으로 내림 형변환이 가능하긴 합니다. 이는 **Downcasting** 에서 설명합니다.

`Dice` 는 초기 상태를 설정하는 초기자 (initializer) 도 가지고 있습니다. 이 초기자는 `generator` 라는 매개 변수를 가지는데, 타입은 역시  `RandomNumberGenerator` 입니다. 이를 준수하는 타입이라면 아무 값이라도 사용하여 새 `Dice` 인스턴스를 초기화 할 수 있습니다.

`Dice` 의 인스턴스 메소드는 `roll` 한 개 뿐이며, '1' 과 '주사위-면 개수' 사이의 정수 값을 반환합니다. 이 메소드는 생성기의 `random()` 메소드를 호출하여 0.0 과 1.0 사이의 새로운 난수를 생성한 다음, 이 난수를 사용하여 올바른 범위 내에 있는 '주사위 굴림 값'을 생성합니다. `generator` 가 `RandomNumberGenerator` 를 따르고 있기 때문에, 호출할 수 있는 `random()` 메소드를 가지고 있음이 보장됩니다.

`Dice` 클래스를 사용하여 `LinearCongruentialGenerator` 인스턴스를 난수 생성기로 가지는 6면체 주사위를 만드는 방법은 다음과 같습니다:

```swift
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
  print("Random dice roll is \(d6.roll())")
}

// Random dice roll is 3
// Random dice roll is 5
// Random dice roll is 4
// Random dice roll is 5
// Random dice roll is 4
```

### Protocol Extensions (규칙 확장)

#### Adding Constraints to Protocol Extensions (규칙 확장 시에 제약 조건 추가하기)

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

[^Protocol]: Protocol 은 단어 자체로는 '규칙'이라는 의미를 갖고 있지만, 스위프트 언어에서 키워드에 해당하기 때문에, '클래스'와 같이 발음 그대로를 사용합니다. 다만 필요한 경우에 '규칙'이라는 뜻을 살려서 옮기도록 합니다.

[^Protocols]: [Protocols](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#)

[^POP]: [Protocol Oriented Programming](https://developer.apple.com/videos/play/wwdc2015/408/)

[^RayWenderlich]: [Introducing Protocol-Oriented Programming in Swift 2](https://www.raywenderlich.com/109156/introducing-protocol-oriented-programming-in-swift-2)

[^code-samples]: [Protocol extensions constraints in Swift](http://www.code-samples.ru/node/209) 예제를 작성할 때 참고한 자료 중 하나입니다. 실제 흐름만 참고한 것이지만 해당 사이트에는 다른 자료들도 많은 것 같아서 링크 기록을 남깁니다.
