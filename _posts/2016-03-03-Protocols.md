---
layout: post
comments: true
title:  "Swift 5.3: Protocols (프로토콜; 규약)"
date:   2016-03-03 23:30:00 +0900
categories: Swift Language Grammar Protocol
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Protocols](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#) 부분[^Protocols]을 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## Protocols (프로토콜; 규약)

_프로토콜 (protocol)_[^protocol] 은 특정한 작업 또는 기능 (functionality) 에 적합하도록 메소드 필수 조건, 속성 필수 조건, 및 그 외 기타 '필수 조건 (requirements)' 들의 '설계 도면 (blueprint)'[^blueprint] 을 정의하는 것입니다. 그 다음 이 프로토콜은 해당 필수 조건의 실제 구현을 제공하는 클래스나, 구조체, 또는 열거체에 의해 _채택 (adopt)_ 됩니다. 프로토콜의 필수 조건을 만족하는 타입은 어떤 것이든 그 프로토콜을 _준수한다 (conform)_ 고 합니다.

'준수하는 타입 (conforming type)' 이 반드시 구현해야 하는 필수 조건을 지정하는 것 외에도, 프로토콜을 확장하면 일부 필수 조건을 구현하거나 아니면 추가적인 기능을 구현해서 해당 준수 타입이 활용하도록 만들 수도 있습니다.

### Protocol Syntax (프로토콜 구문 표현)

프로토콜은 클래스, 구조체, 그리고 열거체와 아주 비슷한 방법으로 정의합니다:

```swift
protocol SomeProtocol {
  // 여기서 프로토콜을 정의합니다.
}
```

사용자 정의 타입이 특정한 프로토콜을 채택한다고 알리려면 해당 정의 부분에서, 타입 이름 뒤에, 콜론으로 구분한 다음, 프로토콜 이름을 붙이면 됩니다. 여러 개의 프로토콜을 나열 할 수 있으며, 이 때는 쉼표로 구분합니다:

```swift
struct SomeStructure: FirstProtocol, AnotherProtocol {
  // 여기서 구조체를 정의합니다.
}
```

클래스가 상위 클래스를 가지고 있는 경우, 상위 클래스를 맨 앞에 나열하며, 프로토콜은 쉼표 이후 채택하도록 합니다:

```swift
class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
  // 여기서 클래스를 정의합니다.
}
```

### Property Requirements (속성 필수 조건)

프로토콜은 어떠한 준수 타입이 특정한 이름과 타입을 가지는 인스턴스 속성이나 타입 속성을 필수로 제공하도록 요구할 수 있습니다. 프로토콜은 이 속성이 저장 속성인지 계산 속성인지는 지정하지 않습니다-필수적인 속성 이름과 타입만을 지정합니다. 프로토콜은 또 각 속성이 반드시 '획득 가능 (gettable)' 한지 아니면 반드시 '획득 가능 (gettable)' _하면서 (and)_ '설정 가능 (settable)' 하기도 해야 하는 지를 지정합니다.

만약 프로토콜의 필수 조건이 속성은 획득 가능하면서 설정도 가능해야 한다는 것이라면, 해당 속성 필수 조건을 상수 저장 속성이나 읽기-전용 계산 속성으로 충족시킬 수 없습니다. 만약 프로토콜의 필수 조건이 속성은 획득 가능하기만 하면 된다는 것이라면, 이 필수 조건은 어떤 종류의 속성으로도 만족시킬 수 있으며, 심지어 코드에서 유용하다면 이 속성을 설정도 가능하게 만들어도 상관 없습니다.

속성 필수 조건은 항상, `var` 키워드를 사용하여, 변수 속성으로 선언합니다. '획득 가능하면서 설정도 가능한 (gettable and settable)' 속성은 자신의 타입 선언 뒤에 `{ get set}` 을 써서 지시하며, '획득 가능한 (gettable)' 속성은 `{ get }` 을 써서 지시합니다.

```swift
protocol SomeProtocol {
  var mustBeSettable: Int { get set }
  var doesNotNeedToBeSettable: Int { get }
}
```

프로토콜 내에서 '타입 속성 필수 조건 (type property requirements)' 을 정의할 때는 `static` 키워드를 접두사로 항상 붙입니다. 이 규칙은 타입 속성 필수 조건을 클래스에서 구현할 때는 `class` 나 `static` 접두사가 붙게되더라도 상관없이 적용되는 것입니다:

```swift
protocol AnotherProtocol {
  static var someTypeProperty: Int { get set }
}
```

다음 예제는 단 하나의 인스턴스 속성 필수 조건을 가지고 있는 프로토콜입니다:

```swift
protocol FullyNamed {
  var fullName: String { get }
}
```

### Method Requirements (메소드 필수 조건)

### Mutating Method Requirements (변경 메소드 필수 조건)

### Initializer Requirements (초기자 필수 조건)

**Class Implementation of Protocol Initializer Requirements**

**Failable Initializer Requirements**

### Protocols as Types (타입으로써의 프로토콜)

프로토콜은 실제로는 어떤 기능도 스스로 구현하지 않습니다. 그럼에도 불구하고 코드 내에서 온전한 타입인 것처럼 사용할 수 있습니다. 프로토콜을 타입인 것처럼 사용하는 것을 _실존 타입_ 이라 부르기도 하는데, 이것은 " 타입 T 는 **실** 제로 **존** 재하며, T 는 이 프로토콜을 준수한다" 는 문구에서 비롯된 것입니다.

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

`generator` 속성의 타입은 `RandomNumberGenerator` 입니다. 따라서 `RandomNumberGenerator` 프로토콜을 따른다면 어떤 타입의 인스턴스라도 설정할 수 있습니다. 이 속성에 할당하는 인스턴스로 필요한 사항은 반드시 `RandomNumberGenerator` 프로토콜을 따라야 한다는 것 한가지 뿐입니다. 타입이  `RandomNumberGenerator` 이므로, 이 프로토콜을 준수하는 모든 생성기들 (generators) 에 (공통으로) 적용되는 방식으로만, `Dice` 클래스와 `generator` 가 상호 작용할 수 있습니다. 이 말은 생성기의 실제 타입 (underlying type) 에 정의된 메소드나 속성은 사용할 수 없다는 의미입니다. 하지만 상위 클래스에서 하위 클래스로 '내림 변환 (downcast)' 이 가능한 것처럼 프로토콜 타입에서 실제 타입으로 내림 형변환이 가능하긴 합니다. 이는 [Downcasting (내림 변환하기)]({% post_url 2020-04-01-Type-Casting %}#downcasting-내림-변환하기) 에서 설명합니다.

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

### Delegation

### Adding Protocol Conformance with an Extension

**Conditionally Conforming to a Protocol**

**Declaring Protocol Adoption with and Extension**

### Collections of Protocol Types

### Protocol Inheritance

### Class-Only Protocols

### Protocol Composition

### Checking for Protocol Conformance (프로토콜 준수 검사하기)

### Optional Protocol Requirements (옵셔널 프로토콜 필수 조건)

### Protocol Extensions (프로토콜 확장)

프로토콜은 확장해서 이를 준수하는 타입의 메소드, 초기자, '첨자 연산 (subscript), 그리고 '계산 속성 (computed property)' 에 대한 구현을 제공할 수 있습니다. 이것은, 개별 준수 타입이나 전역 함수 대신, 프로토콜 자체에서 동작을 정의할 수 있게 해줍니다.

예를 들어. `RandomNumberGenerator` 프로토콜을 확장하면 `randomBool()` 메소드를 제공하도록 해서, '필수 (required)' 메소드인 `random()` 의 결과를 가지고 `Bool` 난수 값을 반환하게 할 수도 있습니다:

```swift
extension RandomNumberGenerator {
  func randomBool() -> Bool {
    return random() > 0.5
  }
}
```

프로토콜에 확장을 만드는 것으로도 모든 준수 타입들이 자동으로 메소드의 구현부를 가지며, 따로 수정같은 것을 할 필요가 전혀 없습니다:

```swift
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.3746499199817101"
print("And here's a random Boolean: \(generator.randomBool())")
// Prints "And here's a random Boolean: true"
```
프로토콜 확장은 준수 타입에 구현을 추가 할 수는 있지만, 다른 프로토콜을 확장하거나 상속하여 또 하나의 프로토콜을 만들 수는 없습니다. 프로토콜 상속은 항상 해당 프로토콜 선언 그 자체에 한정된 것입니다.

**Providing Default Implementations (기본 구현 제공하기)**

프로토콜 확장을 사용하면 해당 프로토콜의 어떤 '메소드 필수 조건' 이나 '계산 속성 필수 조건' 에 대한 '기본 구현' 을 제공할 수 있습니다. 준수 타입이 '필수 (required)' 메소드나 속성에 대해 자체적으로 구현을 제공할 경우, 이 구현이 확장에 의해 제공된 것을 대체하여 사용됩니다.

> 확장에 의해 기본 구현이 제공되는 프로토콜 '필수 조건' 은 선택적 (optional) 프로토콜 '필수 조건' 과는 다릅니다. 준수하는 타입이 자체적으로 구현을 제공 할 필요가 없다는 것은 같지만, 기본 구현을 가지는 '필수 조건' 은 '옵셔널 연쇄 (optional chaining)' 없이 호출 할 수 있습니다.

예를 들어, `TextRepresentable` 프로토콜을 상속하는 `PrettyTextRepresentable` 프로토콜은 요구 속성인 `prettyTextualDescription` 의 기본 구현으로 간단히 `textualDescription` 속성을 반환하도록 할 수도 있습니다:

```swift
extension PrettyTextRepresentable {
  var prettyTextualDescription: String {
    return textualDescription
  }
}
```

**Adding Constraints to Protocol Extensions (프로토콜을 확장할 때 구속 조건 추가하기)**

프로토콜 확장을 정의할 때 '구속 조건 (constraints)' 을 지정해서, 조건을 만족하는 준수 타입만 확장에 있는 메소드와 속성을 사용하게 할 수 있습니다. 이 '구속 조건' 은 확장하려는 프로토콜의 이름 뒤에 일반화된 (generic) `where` 구절을 사용해서 붙입니다. 일반화된 `where` 구절에 대한 더 자세한 내용은 [Generic Where Clauses (일반화된 'Where' 구절)]({% post_url 2017-03-16-Generic-Parameters-and-Arguments %}#generic-where-clauses-일반화된-where-구절) 를 참고하기 바랍니다.[^POP]

예를 들어, `Collection` (집합체) 프로토콜을 확장하면서 각 요소가 `Equatable` 프로토콜을 준수하는 경우에만 적용되도록 할 수 있습니다. 컬렉션의 요소를 (표준 라이브러리의 일부이기도 한) `Equatable` 프로토콜로만 제약하면, `==` 와 `!=` 연산자를 사용하여 두 요소가 같은지 다른지 검사할 수 있습니다.

```swift
extension Collection where Element: Equatable {
  func allEqual() -> Bool {
    for element in self {
      if element != self.first {
        return false
      }
    }
    return true
  }
}
```

`allEqual()` 메소드는 컬렉션의 모든 요소가 같을 때만 `true` 를 반환합니다.

두 개의 정수 배열 (array) 이 있는데, 하나는 모든 요소가 같고 다른 하나는 그렇지 않다고 해 봅시다:

```swift
let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]
```

배열 (타입)은 `Collection `을 준수하고 정수 (타입)은 `Equatable` 을 준수하므로, `equalNumbers` 와 `differentNumbers` 는 `allEqual()` 메소드를 사용할 수 있습니다:

```swift
print(equalNumbers.allEqual())
// Prints "true"
print(differentNumbers.allEqual())
// Prints "false"
```

>(프로토콜을) 준수하는 타입이 '구속 조건' 이 있는 확장 여러 개의 '필수 조건' 을 동시에 만족해서 하나의 메소드 또는 속성이 여러 개의 구현을 동시에 가지게 될 경우, 스위프트는 가장 세분화된 '구속 조건' 을 따르는 구현을 사용합니다.

### 참고 자료

[^Protocols]: 원문은 [Protocols](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#) 에서 확인할 수 있습니다.

[^protocol]: `protocol` 은 '규약' 이라는 뜻을 갖고 있지만, 스위프트 언어에서는 '키워드 (keyword)' 로도 사용되므로, `class` 를 '클래스'라로 하듯이, 앞으로 '프로토콜' 이라고 옮기겠습니다. 다만 필요한 경우에는 '규약' 이라는 의미를 살려서 번역하도록 하겠습니다.

[^blueprint]: blueprint는 '청사진'이라는 뜻을 갖고 있는데, 이는 과거에 제품 '설계 도면' 을 복사하던 방법이 파란색을 띄었기 때문입니다. Xcode 아이콘을 보시면 항상 망치 밑에 파란색 종이가 깔려 있는 것을 볼 수 있는데, 이것이 바로 '청사진 (blueprint)' 입니다. 여기서는 제품을 제작하기 위해 필요한 밑그림의 의미로 '설계 도면' 이라고 옮기도록 하겠습니다.

[^POP]: [Protocol Oriented Programming](https://developer.apple.com/videos/play/wwdc2015/408/)의 핵심이라고 할 수 있습니다. Protocol Oriented Programming 에 대해서는 [Protocol-Oriented Programming Tutorial in Swift 5.1: Getting Started](https://www.raywenderlich.com/6742901-protocol-oriented-programming-tutorial-in-swift-5-1-getting-started) 에서 더 알아볼 수 있습니다.

[^specialized]: 추가 설명이나 예제가 있으면 좋겠지만, 원문에 따로 설명된 것이 없는게 아쉽습니다. Apple Forum 의 질문 답변 중 [What does "most specialized constraints" mean?](https://forums.developer.apple.com/thread/70845) 이라는 글에 따르면, 여러 개의 '구속 조건 (constraints)' 을 동시에 만족하는 경우는 타입이 계층 관계일 때 발생하는데, '가장 세분화된 구속 조건' 을 따른다는 것은 타입의 계층 관계에서 가장 하위의 클래스를를 따른다는 의미일 것 같습니다.
