---
layout: post
comments: true
title:  "Protocols (프로토콜; 규약)"
date:   2016-03-03 23:30:00 +0900
categories: Swift Language Grammar Protocol
---

{% include header_swift_book.md %}

## Protocols (프로토콜; 규약)

_프로토콜 (protocol)_[^protocol] 은 특별한 임무나 기능 조각에 알맞도록 메소드와, 속성, 및 그 외 필수 조건[^requirements] 들의 청사진[^blueprint] 을 정의합니다. 그런 다음 클래스나, 구조체, 또는 열거체가 프로토콜을 _채택 (adopt)_ 하면 그 필수 조건들을 실제로 구현할 수 있습니다. 프로토콜의 필수 조건을 만족하는 어떤 타입이든 그 프로토콜을 _따른다 (conform)_[^conform] 고 합니다.

필수 조건을 지정하여 이를 따르는 타입[^conforming-types] 이 구현하게 하는 것에 더해, 프로토콜을 확장하여 이 필수 조건의 일부를 구현하거나 따르는 타입이 활용하도록 추가적인 기능을 구현할 수도 있습니다.

### Protocol Syntax (프로토콜 구문)

프로토콜을 정의하는 방식은 클래스, 구조체, 및 열거체와 아주 비슷합니다:

```swift
protocol SomeProtocol {
  // 프로토콜 정의는 여기에 둠
}
```

자신만의 타입이 한 특별한 프로토콜을 채택한다는 걸 알리려면 정의 부분에서 프로토콜의 이름을 타입의 이름 뒤에, 콜론으로 구분하여, 두면 됩니다. 여러 개의 프로토콜을, 쉼표로 구분하여, 나열할 수도 있습니다:

```swift
struct SomeStructure: FirstProtocol, AnotherProtocol {
  // 구조체 정의는 여기에 둠
}
```

클래스에 상위 클래스가 있으면, 상위 클래스 이름을 채택한 어떤 프로토콜 보다 앞에 나열하고, 그 뒤에 쉼표를 둡니다:

```swift
class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
  // 클래스 정의는 여기에 둠
}
```

### Property Requirements (속성 필수 조건)

프로토콜은 이를 따르는 어떤 타입이든 특별한 이름과 타입의 인스턴스 속성이나 타입 속성을 제공하길 요구할 수 있습니다. 프로토콜은 속성이 저장 속성이어야 하는지 계산 속성이어야 하는지는 지정하지 않습니다-필수 속성의 이름과 타입만을 지정합니다. 프로토콜은 각각의 속성이 반드시 획득 가능해야 하는지 아니면 획득이 가능 _하면서 (and)_ 설정도 가능해야 하는지도 지정합니다.

프로토콜이 요구한 속성이 획득이 가능하면서 설정도 가능해야하면, 상수 저장 속성이나 읽기-전용 계산 속성으론 그 속성 필수 조건을 충족할 수 없습니다. 프로토콜이 요구한 속성이 획득 가능하기만 하면 되면, 어떤 종류의 속성으로도 필수 조건을 만족시킬 수 있으며, 속성이 설정 가능하기도 한게 자신의 코드에 유용하면 그러는 것도 유효합니다.

속성 필수 조건은 항상 변수 속성으로 선언하여, 접두사는 `var` 키워드가 붙습니다. 획득 가능하면서 설정도 가능한 속성을 지시하려면 자신의 타입 선언 뒤에 `{ get set }` 을 쓰면 되고, 획득 가능한 속성을 지시하려면 `{ get }` 을 쓰면 됩니다.

```swift
protocol SomeProtocol {
  var mustBeSettable: Int { get set }
  var doesNotNeedToBeSettable: Int { get }
}
```

타입 속성 필수 조건을 프로토콜에서 정의할 땐 항상 `static` 키워드를 접두사로 붙입니다. 이 규칙은 타입 속성 필수 조건이 클래스에서 구현될 때 `class` 나 `static` 키워드가 접두사도 붙을 수 있더라도 그대로 적용됩니다[^type-property-requirements]:

```swift
protocol AnotherProtocol {
  static var someTypeProperty: Int { get set }
}
```

프로코콜에 단 하나의 인스턴스 속성 필수 조건만 있는 예는 이렇습니다:

```swift
protocol FullyNamed {
  var fullName: String { get }
}
```

`FullyNamed` 프로토콜은 이를 따르는 타입이 전체 소속을 밝힌 이름[^qualified] 을 제공하길 요구합니다. 프로토콜은 이를 따르는 타입 고유의 성질에 대해서 어떤 다른 것도 지정하지 않습니다-타입 그 자체가 반드시 전체 이름을 제공할 수 있어야 한다는 것만 지정합니다. 프로토콜은 어떤 `FullyNamed` 타입이든, `String` 타입의, 획득 가능한 인스턴스 속성인 `fullName` 이 있어야 한다고 알립니다.

`FullyNamed` 프로토콜을 채택하고 준수하는 단순한 구조체의 예는 이렇습니다:

```swift
struct Person: FullyNamed {
  var fullName: String
}
let john = Person(fullName: "John Appleseed")
// john.fullName 은 "John Appleseed" 임
```

이 예제에서 정의한 `Person` 이라는 구조체는, 특정한 이름의 사람을 나타냅니다. 이는 자신의 정의 첫째 줄에서 `FullyNamed` 프로토콜을 채택한다고 알립니다.

각각의 `Person` 인스턴스엔 단 하나의 저장 속성인 `fullName` 이 있는데, 이는 `String` 타입입니다. 이게 `FullyNamed` 프로토콜에 있는 단 하나의 필수 조건과 맞으면, `Person` 이 프로토콜을 올바로 따른다는 의미입니다. (프로토콜 필수 조건을 충족하지 않으면 스위프트가 컴파일 시간에 에러를 보고합니다.)

역시 `FullyNamed` 프로토콜을 채택하고 준수하는, 더 복잡한 클래스의 예는 이렇습니다:

```swift
class Starship: FullyNamed {
  var prefix: String?
  var name: String
  init(name: String, prefix: String? = nil) {
    self.name = name
    self.prefix = prefix
  }
  var fullName: String {
    return (prefix != nil ? prefix! + " " : "") + name
  }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName 은 "USS Enterprise" 임
```

이 클래스는 `fullName` 속성 필수 조건을 우주선[^starship] 에 대한 읽기-전용 계산 속성으로 구현합니다. 각각의 `Starship` 클래스 인스턴스는 의무적인 `name` 과 옵션인 `prefix` 를 저장합니다. `fullName` 속성은 `prefix` 값이 존재하면 이를, `name` 맨 앞에 붙여서 우주선의 전체 이름을 생성합니다.

### Method Requirements (메소드 필수 조건)

프로토콜은 이를 따르는 타입이 특정한 인스턴스 메소드와 타입 메소드를 구현하길 요구할 수 있습니다. 이 메소드들을 프로토콜 정의 부분에 작성하는 방식은 보통의 인스턴스 및 타입 메소드와 정확하게 똑같지만, 중괄호나 메소드 본문은 없습니다. 가변 매개 변수도 허용하는데, 보통의 메소드와 똑같은 규칙의 영향을 받습니다. 기본 값은, 하지만, 프로토콜 정의에 있는 메소드 매개 변수에서 지정할 수 없습니다.

타입 속성 필수 조건 처럼, 타입 메소드 필수 조건을 프로토콜 안에서 정의할 땐 항상 접두사로 `static` 키워드를 붙입니다. 이는 클래스에서 타입 메소드 필수 조건을 구현할 때 접두사로 `class` 나 `static` 키워드를 붙이더라도 그렇습니다:

```swift
protocol SomeProtocol {
  static func someTypeMethod()
}
```

다음 예제는 단 하나의 인스턴스 메소드 필수 조건이 있는 프로토콜을 정의합니다:

```swift
protocol RandomNumberGenerator {
  func random() -> Double
}
```

이, `RandomNumberGenerator` 라는, 프로토콜은 이를 따르는 어떤 타입이든 `random` 이라는 인스턴스 메소드를 가지길 요구하는데, 이는 호출할 때마다 `Double` 값을 반환합니다. 프로토콜 부분에 지정되지 않았지만, 이 값은 `0.0` 부터 `1.0` 사이의 (1.0 은 포함안하는) 값이라고 가정합니다.[^random]

`RandomNumberGenerator` 프로토콜은 각각의 난수가 어떻게 발생되는 지에 대해선 어떤 가정도 하지 않습니다-단순히 새로운 난수를 발생하는 표준적인 방식을 발생기[^generator] 가 제공하길 요구할 뿐입니다.

`RandomNumberGenerator` 프로토콜을 채택하고 따르는 클래스의 구현은 이렇습니다. 이 클래스에서 구현한 건 _선형 합동 발생기 (linear congruential generator)_[^linear-congruential-generator] 라고 하는 의사 (pseudorandom) 난수 발생 알고리즘입니다:

```swift
class LinearCongruentialGenerator: RandomNumberGenerator {
  var lastRandom = 42.0
  let m = 139968.0
  let a = 3877.0
  let c = 29573.0
  func random() -> Double {
    lastRandom = ((lastRandom * a + c)
      .truncatingRemainder(dividingBy:m))
    return lastRandom / m
  }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// "Here's a random number: 0.3746499199817101" 를 인쇄함
print("And another one: \(generator.random())")
// "And another one: 0.729023776863283" 를 인쇄함
```

### Mutating Method Requirements (변경 메소드 필수 조건)

메소드가 자신이 속해 있는 인스턴스를 수정 (또는 _변경 (mutate)_ 하는게) 필요할 때가 있습니다. 값 타입 (즉, 구조체와 열거체) 의 인스턴스 메소드에서 메소드의 `func` 키워드 앞에 `mutating` 키워드를 두면 메소드가 자신이 소속된 인스턴스 및 그 인스턴스의 속성을 수정하는 걸 허용한다고 지시합니다. 이 과정은 [Modifying Value Types from Within Instance Methods (인스턴스 메소드 안에서 값 타입 수정하기)]({% link docs/swift-books/swift-programming-language/methods.md %}#modifying-value-types-from-within-instance-methods-인스턴스-메소드-안에서-값-타입-수정하기) 에서 설명합니다.

자신이 정의한 프로토콜 인스턴스 메소드 필수 조건이 그 프로토콜을 채택한 어떤 타입의 인스턴스든 변경할 의도라면, 프로토콜의 정의 부분에서 그 메소드를 `mutating` 키워드로 표시합니다. 이는 구조체와 열거체가 프로토콜을 채택하여 그 메소드 필수 조건을 만족할 수 있게 합니다.

> 프로토콜 인스턴스 메소드 필수 조건을 `mutating` 으로 표시하면, 그 메소드를 클래스에서 구현할 땐 `mutating` 키워드를 쓸 필요가 없습니다. `mutating` 키워드는 구조체와 열거체만 사용합니다.

아래 예제에서 정의한 `Togglable` 이라는 프로토콜은, 단 하나의 인스턴스 메소드 필수 조건인 `toggle` 을 정의합니다. 이름에서 제시하듯, `toggle()` 메소드의 의도는 이를 따르는 어떤 타입의 상태든 반전 (toggle) 하거나 반대로 (invert) 만드는 건데, 일반적으로 그 타입의 속성을 수정하게 됩니다.

`toggle()` 메소드는 `Togglable` 프로토콜 정의 부분에 `mutating` 키워드가 표시되어 있어서, 메소드를 호출할 때 이를 따르는 인스턴스의 상태를 변경하는게 예상된다는 걸 지시합니다:

```swift
protocol Togglable {
  mutating func toggle()
}
```

`Togglable` 프로토콜을 구조체나 열거체에서 구현할 경우, 그 구조체나 열거체가 프로토콜을 따르게 하려면 `toggle()` 메소드의 구현부에도 `mutating` 을 표시해야 합니다.

아래 예제는 `OnOffSwitch` 라는 열거체를 정의합니다. 이 열거체가 반전하는 두 상태는, 열거체 case 의 `on` 과 `off` 로 지시합니다. 열거체의 `toggle` 구현부에 `mutating` 을 표시하여, `Togglable` 프로토콜의 필수 조건과 맞춥니다:

```swift
enum OnOffSwitch: Togglable {
  case off, on
  mutating func toggle() {
    switch self {
    case .off:
      self = .on
    case .on:
      self = .off
    }
  }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
// lightSwitch 는 이제 .on 과 같음
```

### Initializer Requirements (초기자 필수 조건)

프로토콜은 이를 따르는 타입이 특정한 초기자를 구현하도록 요구할 수 있습니다. 이 초기자를 프로토콜 정의 부분에 작성하는 방식은 보통의 초기자와 정확하게 똑같지만,  중괄호나 초기자의 본문이 없습니다:

```swift
protocol SomeProtocol {
  init(someParameter: Int)
}
```

#### Class Implementation of Protocol Initializer Requirements (프로토콜 초기자 필수 조건의 클래스 구현)

프로토콜을 따르는 클래스에서의 초기자 필수 조건은 지명 초기자나 편의 초기자 중 어느 것으로도 구현할 수 있습니다. 두 경우 모두, 반드시 초기자 구현에 `required` 수정자[^required-modifier] 를 표시해야 합니다:

```swift
class SomeClass: SomeProtocol {
  required init(someParameter: Int) {
    // 초기자 구현은 여기에 둠
  }
}
```

`required` 수정자를 사용하면 이를 따르는 클래스의 모든 하위 클래스들도 초기자 필수 조건의 구현을 명시하거나 상속하게 하여, 이들도 프로토콜을 따르게 합니다.

필수 초기자[^required-initializer] 에 대한 더 많은 정보는, [Required Initializers (필수 초기자)]({% link docs/swift-books/swift-programming-language/initialization.md %}#required-initializers-필수-초기자) 부분을 보기 바랍니다.

> `final` 수정자를 표시한 클래스에선 프로토콜 초기자 필수 조건에 `required` 수정자를 표시할 필요가 없는데, 마지막 클래스로 하위 클래스를 만들 순 없기 때문입니다. `final` 수정자에 대한 더 많은 것은, [Preventing Overrides (재정의 막기)]({% link docs/swift-books/swift-programming-language/initialization.md %}#preventing-overrides-재정의-막기) 부분을 보기 바랍니다.

하위 클래스에서 상위 클래스의 지명 초기자도 재정의하면서, 그와 일치하는 프로토콜의 초기자 필수 조건도 구현한다면, 초기자 구현을 `required` 와 `override` 수정자로 둘 다 표시합니다:

```swift
protocol SomeProtocol {
  init()
}

class SomeSuperClass {
  init() {
    // 초기자 구현은 여기에 둠
  }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
  // "required" 는 SomeProtocol 따르는 것에서; "override" 는 SomeSuperClass 에서 옴
  required override init() {
    // 초기자 구현은 여기에 둠
  }
}
```

#### Failable Initializer Requirements (실패할 수 있는 초기자 필수 조건)

프로토콜은 이를 따르는 타입에 실패할 수 있는 초기자 필수 조건을 정의할 수 있으며, 이는 [Failable Initializers (실패할 수 있는 초기자)]({% link docs/swift-books/swift-programming-language/initialization.md %}#failable-initializers-실패할-수-있는-초기자) 에서 정의합니다.

실패할 수 있는 초기자 필수 조건은 이를 따르는 타입의 실패할 수 있는 또는 실패할 수 없는 초기자로 만족할 수 있습니다. 실패할 수 없는 초기자 필수 조건은 실패할 수 없는 초기자나 암시적으로 풀리는 실패할 수 있는 초기자로 만족할 수 있습니다.[^satisfied-by]

### Protocols as Types (타입으로써의 프로토콜)

프로토콜은 그 자체로는 어떤 기능도 실제로 구현하지 않습니다. 그럼에도 불구하고, 프로토콜은 코드에서 완전한 형태의 타입인 것처럼 쓸 수 있습니다. 프로토콜을 타입으로 사용하는 걸 _실존 타입 (existential type)_ 이라고 할 때가 있는데, 이는 "프로토콜을 따르는 타입 **T** 가 **실**제로 **존**재한다" 라는 구절에서 비롯한 겁니다.

프로토콜은 그 외 타입들이 허용되는 수많은 곳에서 쓸 수 있는데, 다음을 포함합니다:

* 함수나, 메소드, 또는 초기자의 매개 변수 타입이나 반환 타입으로
* 상수나, 변수, 또는 속성의 타입으로
* 배열이나, 딕셔너리, 또는 그 외 컨테이너의 항목 타입으로

> 프로토콜은 타입이기 때문에, 그 이름은 대문자로 시작하며 (`FullyNamed` 와 `RandomNumberGenerator` 같이) 스위프트의 다른 타입들 (인 `Int` 와, `String`, 및 `Double` 같은 것들) 과 이름을 맞춥니다.

프로토콜을 타입으로 사용하는 예는 이렇습니다:

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

이번 예제에서 정의한 새로운 클래스인 `Dice` 는, 보드 게임에서 쓸 n-면체 주사위를 나타냅니다. `Dice` 인스턴스에 있는 `sides` 라는 정수 속성은, 면이 얼마나 많은 지를 나타내며, `generator` 라는 속성은, 주사위 굴림 값을 생성하는 난수 발생기를 제공합니다.

`generator` 속성은`RandomNumberGenerator` 타입입니다. 그러므로, 여기엔 `RandomNumberGenerator` 프로토콜을 채택한 _어떤 (any)_ 타입의 인스턴스든 설정할 수 있습니다. 이 속성에 할당할 인스턴스는 `RandomNumberGenerator` 프로토콜을 반드시 채택[^adopt] 해야 한다는 것만 제외하면, 인스턴스에 다른 아무 것도 요구하지 않습니다. 그 타입이 `RandomNumberGenerator` 이기 때문에, `Dice` 클래스 안의 코드와 `generator` 는 이 프로토콜을 따르는 모든 발생기에 적용된 방식으로만 상호 작용할 수 있습니다. 그건 발생기 밑에 놓인 타입에서 정의한 메소드나 속성은 어떤 것도 쓸 수 없다는 의미입니다. 하지만, 프로토콜 타입을 그 밑에 놓인 타입으로 내림 변환할 수는 있는데 이는 상위 클래스를 하위 클래스로 내림 변환할 수 있는 것과 똑같은 방식으로, [Downcasting (내림 변환)]({% link docs/swift-books/swift-programming-language/type-casting.md %}#downcasting-내림-변환) 에서 논의한 것과 같습니다.

`Dice` 엔 초기자가 있어서, 초기 상태도 설정합니다. 이 초기자에 있는 `generator` 라는 매개 변수도, `RandomNumberGenerator` 타입입니다. 이를 따르는 어떤 타입의 값이든 새로운 `Dice` 인스턴스를 초기화할 때 이 매개 변수에 전달할 수 있습니다.

`Dice` 가 제공하는 단 하나의 인스턴스 메소드인, `roll` 은, **1** 과 주사위면 수 사이의 정수 값을 반환합니다. 이 메소드는 발생기의 `random()` 메소드를 호출하여 `0.0` 과 `1.0` 사이의 새로운 난수를 생성하고, 이 난수로 올바른 범위 안에 있는 주사위 굴림 값을 생성합니다. `generator` 가 `RandomNumberGenerator` 를 채택한다는 걸 알기 때문에, 호출할 `random()` 메소드가 있다는게 보증됩니다.

어떻게 `Dice` 클래스를 싸서 난수 발생기가 `LinearCongruentialGenerator` 인 6-면체 주사위를 생성할 수 있는지 그 예는 이렇습니다:

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

### Delegation (맡김)

_맡김 (delegation)_ 은 클래스나 구조체가 그 책임의 일부를 또 다른 타입의 인스턴스로 넘기거나 (_맡길 (delegate)_ 수)_ 있게 해주는 디자인 패턴[^design-pattern] 입니다. 이 디자인 패턴의 구현은 맡길 책임을 감추고 있는 프로토콜의 정의로 하며, 이를 따르는 타입 (일을-맡은자[^delegate] 라고 함) 이 자신이 맡은 기능을 제공한다는 걸 보증합니다. 맡김을 쓰면 한 특별한 행동에 응답하거나, 외부 소스의 그 밑에 놓인 타입을 모르고도 그 소스로부터 자료를 가져올 수 있습니다.

아래 예제는 주사위-기반 보드 게임에서 쓸 프로토콜을 두 개 정의합니다:

```swift
protocol DiceGame {
  var dice: Dice { get }
  func play()
}

protocol DiceGameDelegate: AnyObject {
  func gameDidStart(_ game: DiceGame)
  func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
  func gameDidEnd(_ game: DiceGame)
}
```

`DiceGame` 프로토콜은 주사위와 엮인 어떤 게임에서도 채택될 수 있는 프로토콜입니다.

`DiceGameDelegate` 프로토콜을 채택하면 `DiceGame` 의 진행 상황을 추적할 수 있습니다. 강한 참조 순환[^strong-reference-cycles] 을 막기 위해, 일을-맡은자를 약한 참조로 선언합니다. 약한 참조에 대한 정보는, [Strong Reference Cycles Between Class Instances (클래스 인스턴스 사이의 강한 참조 순환)]({% link docs/swift-books/swift-programming-language/automatic-reference-counting.md %}#strong-reference-cycles-between-class-instances-클래스-인스턴스-사이의-강한-참조-순환) 을 보기 바랍니다. 프로토콜을 클래스-전용으로 표시[^any-object] 하는 건 이 장 나중에 있는 `SnakesAndLadders` 클래스가 반드시 자신의 일을-맡은자를 약한 참조로 선언하게 해줍니다. 클래스-전용 프로토콜을 표시하려면 `AnyObject` 를 상속하면 되며 ,이는 [Class-Only Protocols (클래스-전용 프로토콜)](#class-only-protocols-클래스-전용-프로토콜) 에서 논한 것과 같습니다.

원래 [Control Flow (제어 흐름)]({% link docs/swift-books/swift-programming-language/control-flow.md %}) 에서 소개했었던 _뱀과 사다리 (Snakes and Ladders)_ 게임의 한 버전은 이렇습니다. 이 버전에서 개조한 건 주사위-굴림 값으론 `Dice` 인스턴스를 쓰고; `DiceGame` 프로토콜을 채택하며; 자신의 진행 상황은 `DiceGameDelegate` 에 알리도록 한 겁니다:

```swift
class SnakesAndLadders: DiceGame {
  let finalSquare = 25
  let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
  var square = 0
  var board: [Int]
  init() {
    board = Array(repeating: 0, count: finalSquare + 1)
    board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
    board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
  }
  weak var delegate: DiceGameDelegate?
  func play() {
    square = 0
    delegate?.gameDidStart(self)
    gameLoop: while square != finalSquare {
      let diceRoll = dice.roll()
      delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
      switch square + diceRoll {
      case finalSquare:
        break gameLoop
      case let newSquare where newSquare > finalSquare:
        continue gameLoop
      default:
        square += diceRoll
        square += board[square]
      }
    }
    delegate?.gameDidEnd(self)
  }
}
```

_뱀과 사다리 (Snakes and Ladders)_ 게임 플레이의 설명은, [Break (break 문)]({% link docs/swift-books/swift-programming-language/control-flow.md %}#break-break-문) 을 보기 바랍니다.

이 버전의 게임은 `SnakesAndLadders` 라는 클래스로 감싸여 있는데, 이는 `DiceGame` 프로토콜을 채택합니다. 이는 획득 가능한 `dice` 속성과 `play()` 메소드를 제공해야 프로토콜을 따르게 됩니다. (`dice` 속성을 상수 속성으로 선언한 건 초기화 후엔 이게 바뀔 필요가 없고, 프로토콜이 요구하는 건 획득가능만 하라는 것이기 때문입니다.)

_뱀과 사다리 (Snakes and Ladders)_ 게임판은 클래스의 `init()` 초기자에서 설정합니다. 모든 게임 논리는 프로토콜의 `play` 메소드 안으로 이동하며, 프로토콜의 필수 속성인 `dice` 로 자신의 주사위 굴림 값을 제공합니다.

`delegate` 속성이 _옵셔널 (optional)_ `DiceGameDelegate` 로 정의된 건, 이 일을-맡은자 (delegate) 가 게임 플레이에 필수인 건 아니기 때문이라는 걸, 알아두기 바랍니다. `delegate` 속성이 옵셔널 타입이기 때문에, 자동으로 초기 값이 `nil` 로 설정됩니다. 그 이후, 게임의 인스턴스를 만드는 자[^instantiator] 가 옵션으로 속성에 알맞게 일을-맡은자를 설정합니다. `DiceGameDelegate` 프로토콜이 클래스-전용이기 때문에, 일을-맡은자를 `weak` 로 선언하여 참조 순환을 막을 수 있습니다.[^weak-reference-cycles]

`DiceGameDelegate` 는 게임 진행 상황을 추적하기 위한 세 개의 메소드를 제공합니다. 이 세 메소드들은 위의 `play()` 메소드에 있는 게임 논리 안에 들어가 있어서, 새로운 게임을 시작하거나, 새로운 차례를 시작할 때, 또는 게임을 끝낼 때, 호출됩니다.

`delegate` 속성이 _옵셔널 (optional)_ `DiceGameDelegate` 이기 때문에, `play()` 메소드는 매 번 옵셔널 사슬[^optional-chaining] 을 써서 일을-맡은자의 메소드를 호출합니다. `delegate` 속성이 **nil** 이면, 이 일을-맡은자의 호출은 우아하게 실패[^gracefully-fail] 하여 에러가 없습니다. `delegate` 속성이 **nil** 이 아니면, 일을-맡은자의 메소드가 호출되며, `SnakesAndLadders` 인스턴스를 매개 변수로 전달합니다.[^snakes-and-ladders-instance]

이 다음 예제에서 보여주는 건 `DiceGameTracker` 라는 클래스로, `DiceGameDelegate` 프로토콜을 채택하고 있습니다:

```swift
class DiceGameTracker: DiceGameDelegate {
  var numberOfTurns = 0
  func gameDidStart(_ game: DiceGame) {
    numberOfTurns = 0
    if game is SnakesAndLadders {
      print("Started a new game of Snakes and Ladders")
    }
    print("The game is using a \(game.dice.sides)-sided dice")
  }
  func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
    numberOfTurns += 1
    print("Rolled a \(diceRoll)")
  }
  func gameDidEnd(_ game: DiceGame) {
    print("The game lasted for \(numberOfTurns) turns")
  }
}
```

`DiceGameTracker` 는 `DiceGameDelegate` 에 필요한 세 개의 메소드를 모두 구현합니다. 이 메소드들을 써서 게임이 진행된 턴 수를 추적합니다. 게임을 시작할 땐 `numberOfTurns` 속성을 0 으로 재설정하고, 매 번 새 턴을 시작할 때 증가시키며, 게임이 끝나면 총 턴 수를 인쇄합니다.

위에 보인 `gameDidStart(_:)` 의 구현은 `game` 매개 변수를 써서 이제 막 플레이할 게임의 소개 정보를 인쇄합니다. `game` 매개 변수의 타입은 `DiceGame` 이지, `SnakesAndLadders` 가 아니므로, `gameDidStart(_:)` 는 `DiceGame` 프로토콜 부분에서 구현된 메소드와 속성에만 접근하여 쓸 수 있습니다. 하지만, 메소드가 타입 변환을 쓰면 그 밑에 놓인 인스턴스의 타입도 여전히 조회할 수 있습니다. 이 예제에선, `game` 이 실제로 `SnakesAndLadders` 인스턴스인지 그 속을 검사하여, 그럴 경우 적절한 메시지를 인쇄합니다.

`gameDidStart(_:)` 메소드는 전달된 `game` 매개 변수의 `dice` 속성에도 접근합니다. `game` 이 `DiceGame` 프로토콜을 따른다는 걸 알고 있고, 이는 `dice` 속성이 있다는 것도 보증하기 때문에, , 무슨 종류의 게임을 플레이하든 상관없이, `gameDidStart(_:)` 메소드가 주사위의 `sides` 속성에 접근하고 인쇄하는게 가능합니다.

`DiceGameTracker` 의 실제 사용 모습은 이렇습니다:

```swift
let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()
// Started a new game of Snakes and Ladders (새로운 뱀과 사다리 게임을 시작함)
// The game is using a 6-sided dice (6-면체 주사위를 사용하는 게임임)
// Rolled a 3 (3이 나옴)
// Rolled a 5 (5가 나옴)
// Rolled a 4 (4가 나옴)
// Rolled a 5 (5가 나옴)
// The game lasted for 4 turns (게임을 4턴 동안 함)
```

### Adding Protocol Conformance with an Extension (익스텐션으로 프로토콜을 따르게 하기)

이미 있는 타입을 확장하여 새로운 프로토콜을 채택하고 따르게 할 수 있으며, 심지어 그 타입의 소스 코드에 접근할 수 없어도 그렇습니다. 익스텐션은 이미 있는 타입에 새로운 속성과, 메소드, 및 첨자를 추가할 수 있는데, 따라서 프로토콜이 강요할 수도 있는 어떤 필수 조건이든 추가하는게 가능합니다. 익스텐션에 대한 더 많은 건, [Extensions (익스텐션; 확장)]({% link docs/swift-books/swift-programming-language/extensions.md %}) 을 보기 바랍니다.

> 익스텐션에서 인스턴스의 타입이 프로토콜을 따르게 하는 걸 추가할 땐 그 타입에서 이미 있던 인스턴스들도 자동으로 프로토콜을 채택하고 따르게 됩니다.

예를 들어, 이, `TextRepresentable` 이라는 프로토콜을, 구현한 어떤 타입이든 자신을 글로 나타낼 방법을 가질 수 있습니다. 이는 그 자체의 설명일 수도, 현재 상태의 텍스트 버전일 수도 있습니다:

```swift
protocol TextRepresentable {
  var textualDescription: String { get }
}
```

위에 있는 `Dice` 클래스를 확장하여 `TextRepresentable` 을 채택하고 따르게 할 수 있습니다:

```swift
extension Dice: TextRepresentable {
  var textualDescription: String {
    return "A \(sides)-sided dice"
  }
}
```

이 익스텐션에서 새로운 프로토콜을 채택하는 방식은 마치 `Dice` 의 원본 구현에서 이를 제공했을 경우와 정확히 똑같습니다. 프로토콜 이름은 타입 이름 뒤에, 콜론으로 구분하여 제공하고, 프로토콜의 모든 필수 조건은 익스텐션의 중괄호 안에서 구현합니다.

어떤 `Dice` 인스턴스든 이제 `TextRepresentable` 로 취급할 수 있습니다:

```swift
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)
// "A 12-sided dice" 를 인쇄함
```

이와 비슷하게, `SnakesAndLadders` 게임 클래스를 확장하여 `TextRepresentable` 프로토콜을 채택하고 따르게 할 수도 있습니다:

```swift
extension SnakesAndLadders: TextRepresentable {
  var textualDescription: String {
    return "A game of Snakes and Ladders with \(finalSquare) squares"
  }
}
print(game.textualDescription)
// "A game of Snakes and Ladders with 25 squares" 를 인쇄함
```

#### Conditionally Conforming to a Protocol (조건에 따라 프로토콜 따르게 하기)

일반화 타입[^generic-type] 은, 타입의 일반화 매개 변수가 프로토콜을 따를 때 같이, 특정 조건에서만 프로토콜의 필수 조건을 만족할 수 있을 수도 있습니다. 일반화 타입이 조건에 따라 프로토콜을 따르게 하려면 타입을 확장할 때 구속 조건을 나열하면 됩니다. 채택하려는 프로토콜 이름 뒤에 이러한 구속 조건을 쓰려면 일반화 `where` 절을 쓰면 됩니다. 일반화 `where` 절에 대한 더 많은 건, [Generic Where Clauses (일반화 'where' 절)]({% link docs/swift-books/swift-programming-language/generics.md %}#generic-where-clauses-일반화-where-절) 을 보기 바랍니다.

다음 익스텐션은 `Array` 인스턴스에 저장된 원소의 타입이 `TextRepresentable` 을 따를 때마다 자신도 `TextRepresentable` 프로토콜을 따르게 합니다.[^array-element]

```swift
extension Array: TextRepresentable where Element: TextRepresentable {
  var textualDescription: String {
    let itemsAsText = self.map { $0.textualDescription }
    return "[" + itemsAsText.joined(separator: ", ") + "]"
  }
}
let myDice = [d6, d12]
print(myDice.textualDescription)
// "[A 6-sided dice, A 12-sided dice]" 를 인쇄함
```

#### Declaring Protocol Adoption with an Extension (익스텐션으로 프로토콜 채택한다고 선언하기)

타입이 이미 프로토콜의 모든 필수 조건을 따르고 있지만, 아직 그 프로토콜을 채택한다고 알리지 않았다면, 빈 익스텐션으로 그 프로토콜을 채택하게 할 수 있습니다:

```swift
struct Hamster {
  var name: String
  var textualDescription: String {
    return "A hamster named \(name)"
  }
}
extension Hamster: TextRepresentable {}
```

이제 `Hamster` 인스턴스는 `TextRepresentable` 이 필수 타입인 곳마다 쓸 수 있습니다:

```swift
let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
// "A hamster named Simon" 을 인쇄함
```

> 타입은 프로토콜의 필수 조건을 만족한다고 해서 이를 자동으로 채택하지 않습니다. 반드시 프로토콜을 채택한다는 선언을 명시해야 합니다.[^adoption]

### Adopting a Protocol Using a Synthesized Implementation (만들어져 있는 구현을 써서 프로토콜 채택하기)

스위프트는 수많은 단순한 경우에 `Equatable` 과, `Hashable`, 및 `Comparable` 프로토콜을 자동으로 따르게 할 수 있습니다. 이렇게 만들어져 있는 구현[^synthesized] 을 쓰는 건 틀에 박힌 코드를 작성하는 걸 반복하면서 직접 프로토콜의 필수 조건을 구현하지 않아도 된다는 의미입니다.

스위프트는 다음 종류의 타입에 대해 만들어져 있는 `Equatable` 구현을 제공합니다:

* 구조체에 `Equatable` 프로토콜을 따르는 저장 속성만 있음
* 열거체에 `Equatable` 프로토콜을 따르는 결합 타입[^associated-types] 만 있음
* 열거체에 아무런 결합 타입도 없음

만들어져 있는 `==` 의 구현을 받으려면, 직접 `==` 연산자를 구현하지 말고, 원본 선언을 담은 파일에서 `Equatable` 을 따른다고 선언하면 됩니다. `Equatable` 프로토콜은 `!=` 의 기본 구현도 제공합니다.

아래 예제는 3-차원 위치 벡터 `(x, y, z)` 를 위한 `Vector3D` 구조체를 정의하며, 이는 `Vector2D` 구조체와 비슷합니다. `x`, `y`, `z` 속성이 모두 `Equatable` 타입이기 때문에, `Vector3D` 는 같음 비교 연산자[^equivalence] 에 대해서 만들어져 있는 구현을 받습니다.

```swift
struct Vector3D: Equatable {
  var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
  print("These two vectors are also equivalent.")
}
// "These two vectors are also equivalent." 를 인쇄함
```

스위프트는 다음 종류의 타입에 대해 만들어져 있는 `Hashable` 구현을 제공합니다:

* 구조체에 `Hashable` 프로토콜을 따르는 저장 속성만 있음
* 열거체에 `Hashable` 프로토콜을 따르는 결합 타입만 있음
* 열거체에 아무런 결합 타입도 없음

만들어져 있는 `hash(into:)` 의 구현을 받으려면, 직접 `hash(into:)` 메소드를 구현하지 말고, 원본 선언을 담은 파일에서 `Hashable` 을 따른다고 선언하면 됩니다.

스위프트는 열거체에 원시 값[^raw-values] 이 없을 경우 만들어져 있는 `Comparable` 의 구현을 제공합니다. 열거체에 결합 타입이 있다면, 이들 모두 반드시 `Comparable` 프로토콜을 따라야 합니다. 만들어져 있는 `<` 의 구현을 받으려면, 직접 `<` 연산자를 구현하지 말고, 원본 열거체 선언을 담은 파일에서 `Comparable` 을 따른다고 선언하면 됩니다. `Comparable` 프로토콜에 있는 `<=` 와, `>`, 및 `>=` 의 기본 구현은 그 외 나머지 비교 연산자들을 제공합니다.[^remaining-comparison-operators]

아래 예제에서 정의한 `SkillLevel` 열거체에는 초급자, 중급자, 및 전문가라는 case 가 있습니다. 전문가는 자신에게 있는 별의 개수로 추가로 등급이 나뉩니다.

```swift
enum SkillLevel: Comparable {
  case beginner
  case intermediate
  case expert(stars: Int)
}
var levels = [SkillLevel.intermediate, SkillLevel.beginner,
              SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]
for level in levels.sorted() {
  print(level)
}
// "beginner" 를 인쇄함
// "intermediate" 를 인쇄함
// "expert(stars: 3)" 를 인쇄함
// "expert(stars: 5)" 를 인쇄함
```

### Collections of Protocol Types (프로토콜 타입의 집합체)

프로토콜을 배열이나 딕셔너리 같은 집합체에 저장될 타입으로 쓸 수 있는데, 이는 [Protocols as Types (타입으로써의 프로토콜)](#protocols-as-types-타입으로써의-프로토콜) 에서 언급한 바 있습니다. 이번 예제는 `TextRepresentable` 인 것들의 배열을 생성합니다:

```swift
let things: [TextRepresentable] = [game, d12, simonTheHamster]
```

이제 배열의 항목을 반복하여, 각각의 항목마다 글로 된 설명을 인쇄하는게 가능합니다:

```swift
for thing in things {
  print(thing.textualDescription)
}
// A game of Snakes and Ladders with 25 squares (정사각형 25개로 된 뱀과 사다리 게임)
// A 12-sided dice (12-면체 주사위)
// A hamster named Simon (이름이 Simon 인 햄스터)
```

`thing` 상수는 `TextRepresentable` 타입이라는 걸 알아두기 바랍니다. 이는 `Dice` 나, `DiceGame`, 또는 `Hamster` 타입인 게 아니며, 심지어 그 속의 실제 인스턴스는 이들 타입이더라도 그렇습니다. 그럼에도 불구하고, `TextRepresentable` 티입이고, `TextRepresentable` 인 어떤 것에도 `textualDescription` 속성이 있다는 걸 알기 때문에, 매 번 반복문을 통과할 때 `thing.textualDescription` 으로 접근해도 안전합니다.

### Protocol Inheritance (프로토콜 상속)

프로토콜은 다른 프로토콜을 하나 이상 _상속 (inherit)_ 할 수 있으며 자신이 상속받은 필수 조건 위에다가 필수 조건을 더 추가할 수도 있습니다. 프로토콜 상속 구문은 클래스 상속 구문과 비슷하지만, 상속할 프로토콜을, 쉼표로 구분하여, 여러 개 나열하는 옵션이 있습니다.[^multiple-inherited-protocols]:

```swift
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
  // 프로토콜 정의는 여기에 둠
}
```

위에 있는 `TextRepresentable` 프로토콜을 상속하는 프로토콜의 예는 이렇습니다:

```swift
protocol PrettyTextRepresentable: TextRepresentable {
  var prettyTextualDescription: String { get }
}
```

이 예제에서 정의한 새로운 프로토콜인, `PrettyTextRepresentable` 은, `TextRepresentable` 을 상속합니다. `PrettyTextRepresentable` 을 채택한 건 어떤 것이든 반드시 `TextRepresentable` 이 강제하는 모든 필수 조건에, _더하여 (plus)_ `PrettyTextRepresentable` 이 강제하는 추가적인 필수 조건도, 만족해야 합니다. 이 예제에서, `PrettyTextRepresentable` 이 추가하는 단 하나의 필수 조건은 `String` 을 반환하는 획득 가능 속성인 `prettyTextualDescription` 을 제공하라는 겁니다.

`SnakesAndLadders` 클래스를 확장하여 `PrettyTextRepresentable` 을 채택하고 준수하게 할 수도 있습니다:

```swift
extension SnakesAndLadders: PrettyTextRepresentable {
  var prettyTextualDescription: String {
    var output = textualDescription + ":\n"
    for index in 1...finalSquare {
      switch board[index] {
      case let ladder where ladder > 0:
        output += "▲ "
      case let snake where snake < 0:
        output += "▼ "
      default:
        output += "○ "
      }
    }
    return output
  }
}
```

이 익스텐션은 `SnakesAndLadders` 타입이 `PrettyTextRepresentable` 프로토콜을 채택한다고 알리며 이를 위해 `prettyTextualDescription` 속성의 구현을 제공합니다. `PrettyTextRepresentable` 인 어떤 것이든 반드시 `TextRepresentable` 이기도 하므로, `prettyTextualDescription` 구현은 출력 문자열의 맨 앞을 `TextRepresentable` 프로토콜에 있는 `textualDescription` 속성에 접근하는 걸로 시작합니다. 콜론 (`:`) 과 줄 끊음 (`\n`) 을 덧붙여서, 이걸로 자신을 예쁘게 설명하는 글을 시작합니다. 그런 다음 정사각형 판을 반복하면서, 각 정사각형의 내용물을 나타내는 기하학 도형을 덧붙입니다:

* 정사각형 값이 `0` 보다 크면, 사다리의 기초 부분이며, `▲` 를 나타냅니다.
* 정사각형 값이 `0` 보다 작으면, 뱀의 머리이며, `▼` 로 나타냅니다.
* 그 외의 경우, 정사각형 값은 `0` 이고, "자유로운 (free)" 정사각형이므로, `○` 로 나타냅니다.

이제 `prettyTextualDescription` 속성을 써서 어떤 `SnakesAndLadders` 인스턴스에 대해서는 이를 예쁘게 설명하는 글을 인쇄할 수 있습니다:

```swift
print(game.prettyTextualDescription)
// A game of Snakes and Ladders with 25 squares:
// ○ ○ ▲ ○ ○ ▲ ○ ○ ▲ ▲ ○ ○ ○ ▼ ○ ○ ○ ○ ▼ ○ ○ ▼ ○ ▼ ○
```

### Class-Only Protocols (클래스-전용 프로토콜)

프로토콜 채택을 클래스 타입만 하도록 (그래서 구조체나 열거체는 안되도록) 제한하려면 프로토콜의 상속 목록에 `AnyObject` 프로토콜을 추가하면 됩니다.

```swift
protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
  // 클래스-전용 프로토콜 정의는 여기에 둠
}
```

위 예제에 있는, `SomeClassOnlyProtocol` 은 클래스 타입만 채택할 수 있습니다. 구조체나 열거체를 정의하면서 `SomeClassOnlyProtocol` 을 채택하려고 하면 컴파일-시간 에러가 됩니다.

> 클래스-전용 프로토콜은 그 프로토콜의 필수 조건에서 정의한 동작이 이를 따르는 타입이 값 의미 구조 보단 참조 의미 구조를 가진다고 가정하거나 요구할 때 사용합니다. 참조와 값 의미 구조에 대한 더 많은 것들은, [Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)]({% link docs/swift-books/swift-programming-language/structures-and-classes.md %}#structures-and-enumerations-are-value-types-구조체와-열거체는-값-타입입니다) 와 [Classes Are Reference Types (클래스는 참조 타입입니다)]({% link docs/swift-books/swift-programming-language/structures-and-classes.md %}#classes-are-reference-types-클래스는-참조-타입입니다) 를 보기 바랍니다.

### Protocol Composition (프로토콜 합성)

타입이 동시에 여러 개의 프로토콜을 준수하길 요구하는 게 유용할 수 있습니다. 여러 개의 프로토콜을 단 하나의 필수 조건으로 조합하는 건 _프로토콜 합성 (protocol composition)_ 으로 할 수 있습니다. 프로토콜 합성은 마치 정의한 임시 프로토콜 안에 조합된 모든 프로토콜 필수 조건들이 있는 것처럼 동작합니다. 프로토콜 합성은 어떤 새로운 프로토콜 타입을 정의하는게 아닙니다.

프로토콜 합성의 형식은 `SomeProtocol & AnotherProtocol` 입니다. 필요한 만큼 많은 프로토콜을 나열할 수 있는데, 앤드 기호 (ampersands; `&`) 로 구분합니다. 프로토콜 목록에 더해, 프로토콜 합성은 하나의 클래스 타입을 담을 수도 있는데, 이를 써서 필수 상위 클래스도 지정할 수 있습니다.

두 개의 프로토콜인 `Named` 와 `Aged` 를 함수 매개 변수에 대한 단 하나의 프로토콜 합성으로 조합한 예는 이렇습니다:

```swift
protocol Named {
  var name: String { get }
}
protocol Aged {
  var age: Int { get }
}
struct Person: Named, Aged {
  var name: String
  var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) {
  print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)
// "Happy birthday, Malcolm, you're 21!" 를 인쇄함
```

이 예제에서, `Named` 프로토콜에는 단 하나의 필수 조건으로 획득 가능한 `String` 속성인 `name` 이 있습니다. `Aged` 프로토콜에는 단 하나의 필수 조건으로 획득 가능한 `Int` 속성인 `age` 가 있습니다. 두 프로토콜 모두 `Person` 이라는 구조체에서 채택합니다.

예제에선 `wishHappyBirthday(to:)` 라는 함수도 정의합니다. `celebrator` 매개 변수의 타입은 `Named & Aged` 인데, 이는 "`Named` 와 `Aged` 프로토콜 둘 다를 따르는 어떠한 타입" 이라는 의미입니다. 어떤 특정 타입이 함수로 전달되는 지는 중요하지 않으며, 필수 프로토콜을 둘 다 따르기만 하면 됩니다.

예제는 그런 다음 새로운 `Person` 인스턴스인 `birthdayPerson` 을 생성하고 이 새로운 인스턴스를 `wishHappyBirthday(to:)` 함수로 전달합니다. `Person` 이 두 프로토콜을 다 따르기 때문에, 이 호출이 유효하여, `wishHappyBirthday(to:)` 함수가 생일 인사말을 인쇄할 수 있습니다.

이전 예제에 있던 `Named` 프로토콜과 `Location` 클래스를 조합한 예는 이렇습니다:

```swift
class Location {
  var latitude: Double
  var longitude: Double
  init(latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }
}
class City: Location, Named {
  var name: String
  init(name: String, latitude: Double, longitude: Double) {
    self.name = name
    super.init(latitude: latitude, longitude: longitude)
  }
}
func beginConcert(in location: Location & Named) {
  print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)
// "Hello, Seattle!" 를 인쇄함
```

`beginConcert(in:)` 함수는 `Location & Named` 티입의 매개 변수를 입력 받는데, 이는 "`Location` 의 하위 클래스면서 `Named` 프로토콜을 따르는 어떤 타입" 을 의미합니다. 이 경우, `City` 는 두 필수 조건 모두 만족합니다.

`birthdayPerson` 을 `beginConcert(in:)` 함수로 전달하는 건 무효인데 이는 `Person` 이 `Location` 의 하위 클래스가 아니기 때문입니다. 마찬가지로, `Location` 의 하위 클래스를 만들면서 `Named` 프로토콜을 따르지 않으면, 그 타입의 인스턴스로 `beginConcert(in:)` 을 호출하는 것도 무효입니다.

### Checking for Protocol Conformance (프로토콜을 따르는지 검사하기)

[Type Casting (타입 변환)]({% link docs/swift-books/swift-programming-language/type-casting.md %}) 에서 설명하는 `is` 와 `as` 연산자를 쓰면 프로토콜을 따르는지 검사할 수도, 특정한 프로토콜로 변환할 수도 있습니다. 프로토콜을 검사하고 변환하는 구문은 타입을 검사하고 변환하는 걸 정확하게 똑같이 따릅니다:

* `is` 연산자는 인스턴스가 프로토콜을 따른다면 `true` 를 반환하고 그렇지 않으면 `false` 를 반환합니다.
* `as?` 버전의 내림 변환 연산자는 프로토콜 타입에 대한 옵셔널 값을 반환하는데, 인스턴스가 그 프로토콜을 따르지 않으면 이 값이 `nil` 입니다.
* `as!` 버전의 내림 변환 연산자는 강제로 프로토콜 타입으로 내림 변환하는데 내림 변환이 성공하지 않으면 실행 시간 에러를 발생시킵니다.

이번 예제에서 정의한 프로토콜인 `HasArea` 엔, 획득 가능한 `Double` 속성인 `area` 라는 단 하나의 속성 필수 조건이 있습니다:

```swift
protocol HasArea {
  var area: Double { get }
}
```

여기에 있는 두 클래스인, `Circle` 과 `Country` 는, 둘 다 `HasArea` 프로토콜을 따릅니다:

```swift
class Circle: HasArea {
  let pi = 3.1415927
  var radius: Double
  var area: Double { return pi * radius * radius }
  init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
  var area: Double
  init(area: Double) { self.area = area }
}
```

`Circle` 클래스는 `area` 속성 필수 조건을, `radius` 저장 속성에 기반한, 계산 속성으로 구현합니다. `Country` 클래스는 직접 `area` 필수 조건을 저장 속성으로 구현합니다. 두 클래스 모두 올바르게 `HasArea` 프로토콜을 따릅니다.

여기에 있는 `Animal` 이라는 클래스는, `HasArea` 프로토콜을 따르지 않습니다:

```swift
class Animal {
  var legs: Int
  init(legs: Int) { self.legs = legs }
}
```

`Circle` 과, `Country`, 및 `Animal` 클래스는 공유하는 기초 클래스[^base-class] 가 없습니다. 그럼에도 불구하고, 이 세 타입은 모두 클래스라서, 이들의 인스턴스를 써서 저장 값의 타입이 `AnyObject` 인 배열을 초기화할 수 있습니다:

```swift
let objects: [AnyObject] = [
  Circle(radius: 2.0),
  Country(area: 243_610),
  Animal(legs: 4)
]
```

`objects` 배열을 초기화하는 배열 글자 값은 반지름이 2인 `Circle` 인스턴스; 제곱 킬로미터 단위의 영국 국토 면적으로 초기화한 `Country` 인스턴스; 및 네 발 달린 `Animal` 인스턴스를 담고 있습니다.

이제 `objects` 배열을 반복하고, 배열 안의 각 객체를 검사하여 `HasArea` 프로토콜을 준수하는지 확인할 수 있습니다:

```swift
for object in objects {
  if let objectWithArea = object as? HasArea {
    print("Area is \(objectWithArea.area)")
  } else {
    print("Something that doesn't have an area")
  }
}
// Area is 12.5663708
// Area is 243610.0
// Something that doesn't have an area
```

배열 안의 객체가 `HasArea` 프로토콜을 준수할 때마다, `as?` 연산자가 반환한 옵셔널 값을 옵셔널 연결로 풀고 `objectWithArea` 라는 상수에 넣습니다. `objectWithArea` 상수의 타입이 `HasArea` 라는 걸 알아서, 타입-안전하게[^type-safe] 자신의 `area` 속성에 접근하고 인쇄할 수 있습니다.

변환 과정에서 실제 객체를 바꾸진 않는다는 걸 기억하기 바랍니다. 이들은 계속 `Circle`, `Country`, 및 `Animal` 입니다. 하지만, `objectWithArea` 상수에 저장한 시점에는, 타입이 `HasArea` 라는 것만 알아서, `area` 속성에만 접근할 수 있습니다.

### Optional Protocol Requirements (옵셔널 프로토콜 필수 조건)

프로토콜에 _옵셔널 필수 조건 (optional requirements)_ 을 정의할 수 있습니다. 이러한 필수 조건은 프로토콜을 준수한 타입이 구현하지 않아도 됩니다. 옵셔널 필수 조건은 프로토콜 정의 부분에서 `optional` 수정자 접두사를 붙입니다. 옵셔널 필수 조건이 사용 가능하므로 오브젝티브-C 와 상호 호환되는 코드를 작성할 수 있습니다. 프로토콜과 옵셔널 필수 조건은 둘 다 반드시 `@objc` 특성 [^attribute] 으로 표시해야 합니다. `@objc` 프로토콜은 오브젝티브-C 클래스 또는 다른 `@objc` 클래스를 상속한 클래스만이 채택할 수 있다는 걸 기억하기 바랍니다. 구조체나 열거체는 채택할 수 없습니다.

옵셔널 필수 조건에서 메소드나 속성을 사용할 땐, 자신의 타입이 자동으로 옵셔널이 됩니다. 예를 들어, `(Int) -> String` 타입의 메소드는 `((Int) -> String)?` 이 됩니다. 메소드의 반환 값이 아닌, 전체 함수 타입이 옵셔널로 포장된다는 걸 기억하기 바랍니다.

옵셔널 프로토콜 필수 조건을 옵셔널 사슬로 호출하면, 프로토콜을 준수한 타입이 필수 조건을 구현하지 않았을 가능성을 서술할 수 있습니다. 옵셔널 메소드의 구현을 검사하려면, `someOptionalMethod?(someArgument)` 와 같이, 호출 때 메소드 이름 뒤에 물음표를 작성하면 됩니다. 옵셔널 사슬에 대한 정보는, [Optional Chaining (옵셔널 사슬)]({% link docs/swift-books/swift-programming-language/optional-chaining.md %}) 장을 보도록 합니다.

다음 예제는 정수를-세는 `Counter` 라는 클래스를 정의하는데, 이는 외부 데이터 소스를 사용하여 자신의 증가량을 제공합니다. 이 데이터 소스는, 두 개의 옵셔널 필수 조건이 있는, `CounterDataSource` 프로토콜로 정의합니다:

```swift
@objc protocol CounterDataSource {
  @objc optional func increment(forCount count: Int) -> Int
  @objc optional var fixedIncrement: Int { get }
}
```

`CounterDataSource` 프로토콜은 `incremental(forCount:)` 라는 옵셔널 메소드 필수 조건 및 `fixedIncrement` 라는 옵셔널 속성 필수 조건을 정의합니다. 이 필수 조건들은 `Count` 인스턴스에 적절한 증가량을 제공하는 서로 다른 두 가지 방식을 데이터 소스에 정의합니다.

> 엄밀하게 말해서, _어느 (either)_ 프로토콜 필수 조건을 구현하지 않고도 `CounterDataSource` 프로토콜을 준수한 클래스를 작성할 수 있습니다. 이들은, 결국 어째 됐든, 둘 다 옵셔널입니다. 기술적으로 허용하긴 하지만, 아주 좋은 데이터 소스는 아닐겁니다.

아래에 정의한, `Counter` 클래스에는 `CounterDataSource?` 타입인 옵셔널 `dataSource` 속성이 있습니다:

```swift
class Counter {
  var count = 0
  var dataSource: CounterDataSource?
  func increment() {
    if let amount = dataSource?.increment?(forCount: count) {
      count += amount
    } else if let amount = dataSource?.fixedIncrement {
      count += amount
    }
  }
}
```

`Counter` 클래스는 자신의 현재 값을 `count` 라는 변수 속성에 저장합니다. `Counter` 클래스는 `increment` 라는 메소드도 정의하는데, 이는 메소드를 호출할 때마다 `count` 속성을 증가합니다.

`increment()` 메소드는 첫 번째로 자신의 데이터 소스에 대한 `incremental(forCount:)` 메소드 구현을 찾아서 증가량을 가져오려고 합니다. `increment()` 메소드는 옵셔널 사슬을 사용하여 `increment(forCount:)` 를 호출하려 하며, 메소드의 단일 인자로는 현재의 `count` 값을 전달합니다.

여기서 _두 (two)_ 단계의 옵셔널 사슬로 동작함을 기억하기 바랍니다. 첫 번째로, `dataSource` 가 `nil` 인게 가능하므로, `dataSource` 이름 뒤에 물음표를 둬서 `dataSource` 가 `nil` 이 아닐 때만 `incremental(forCount:)` 를 호출해야함을 지시합니다. 두 번째로, `dataSource` 가 존재 _하 (does)_ 더라도, `increment(forCount:)` 가 옵셔널 필수 조건이기 때문에, 이를 구현한다는 보증이 없습니다. 여기서, `increment(forCount:)` 를 구현하지 않았을 가능성도 옵셔널 사슬로 처리합니다. `increment(forCount:)` 호출은 `increment(forCount:)` 가 존재-즉, `nil` 아닌 경우-에만 발생합니다. 이것이 `incremental(forCount:)` 이름 뒤에도 물음표를 작성한 이유입니다.

이 두 이유 중 어느 것으로도 `increment(forCount:)` 호출이 실패할 수 있기 때문에, 호출은 _옵셔널 (optional)_ `Int` 값을 반환합니다. 이는 `CounterDataSource` 정의에서 `increment(forCount:)` 가 옵셔널-아닌 `Int` 값을 반환한다고 정의할지라도 그렇습니다. 두 개의 옵셔널 사슬 연산이, 차례로, 있을지라도, 결과는 여전히 단일 옵셔널로 포장합니다. 여러 개의 옵셔널 사슬 연산을 사용하는데 대한 더 많은 정보는, [Linking Multiple Levels of Chaining (여러 수준의 사슬 잇기)]({% link docs/swift-books/swift-programming-language/optional-chaining.md %}#linking-multiple-levels-of-chaining-여러-수준의-사슬-잇기) 를 보도록 합니다.

`increment(forCount:)` 호출 후에, 옵셔널 연결로, 반환한 옵셔널 `Int` 를 풀어서 `amount` 라는 상수에 넣습니다. 옵셔널 `Int` 가 값을 담고 있으면-즉, 일-맡은자[^delegate] 와 메소드 둘 다 존재하고, 메소드가 값을 반환한 경우면-포장 푼 `amount` 를 `count` 저장 속성에 추가하고, 증가를 완료합니다.

`increment(forCount:)` 메소드에서 값을 가져오는 게 _불 (not)_ 가능하면-`dataSource` 가 `nil` 이거나, 데이터 소스가 `increment(forCount:)` 를 구현하지 않았기 때문인데-그 땐 `increment()` 메소드가 데이터 소스의 `fixedIncrement` 속성에서 값을 대신 가져오려고 합니다. `fixedIncrement` 속성도 옵셔널 필수 조건이라서, `CounterDataSource` 프로토콜 정의 부분에서 `fixedIncrement` 를 옵셔널-아닌 `Int` 속성으로 정의할지라도, 그 값은 옵셔널 `Int` 입니다.

데이터 소스를 매 번 조회할 때마다 상수 값 `3` 을 반환하는 단순한 `CounterDataSource` 구현은 이렇습니다. 이는 옵셔널 `fixedIncrement` 속성 필수 조건을 구현함으로써 이렇게 합니다:

```swift
class ThreeSource: NSObject, CounterDataSource {
  let fixedIncrement = 3
}
```

새로운 `Counter` 인스턴스의 데이터 소스로 `ThreeSource` 인스턴스를 사용할 수 있습니다:

```swift
var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
  counter.increment()
  print(counter.count)
}
// 3
// 6
// 9
// 12
```

위 코드는 새로운 `Counter` 인스턴스를 생성하고; 새로운 `ThreeSource` 인스턴스를 자신의 데이터 소스로 설정하며; 카운터의 `increment()` 메소드를 네 번 호출합니다. 예상대로, `increment()` 의 호출마다 카운터의 `count` 속성이 3 만큼 증가합니다.

`Counter` 인스턴스가 자신의 현재 `count` 값에서 0 을 향해 위나 아래로 세는, `TowardsZeroSource` 라는 좀 더 복잡한 데이터 소스는 이렇습니다:

```swift
class TowardsZeroSource: NSObject, CounterDataSource {
  func increment(forCount count: Int) -> Int {
    if count == 0 {
      return 0
    } else if count < 0 {
      return 1
    } else {
      return -1
    }
  }
}
```

`TowardsZeroSource` 클래스는 `CounterDataSource` 프로토콜에 있는 옵셔널 `increment(forCount:)` 메소드를 구현하며 `count` 인자 값을 써서 어느 방향으로 세는지 알아냅니다. `count` 가 이미 0 이면, 메소드는 `0` 을 반환하여 더 이상 세지 말 것을 지시합니다.

기존 `Counter` 인스턴스와 `TowardsZeroSource` 인스턴스를 사용하면 `-4` 에서 0 으로 셀 수 있습니다. 카운터가 0 에 한 번 도달하고 나면, 더 이상 세지 않습니다:

```swift
counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
  counter.increment()
  print(counter.count)
}
// -3
// -2
// -1
// 0
// 0
```

### Protocol Extensions (프로토콜 익스텐션; 규약 확장)

프로토콜을 확장하면 준수 타입에 메소드, 초기자, 첨자 연산, 및 계산 속성 구현을 제공할 수 있습니다. 이는, 각 타입의 개별 준수에서 전역 함수에서 보단, 프로토콜 그 자체에서 동작을 정의하는 걸 허용합니다.

예를 들어, `RandomNumberGenerator` 프로토콜을 확장하여, `random()` 필수 메소드의 결과로 `Bool` 난수 값을 반환하는, `randomBool()` 메소드를 제공할 수 있습니다: 

```swift
extension RandomNumberGenerator {
  func randomBool() -> Bool {
    return random() > 0.5
  }
}
```

프로토콜에 대한 익스텐션을 생성함으로써, 어떤 추가 수정 없이 자동으로 모든 준수 타입이 이 메소드 구현을 얻습니다:

```swift
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// "Here's a random number: 0.3746499199817101" 를 인쇄함
print("And here's a random Boolean: \(generator.randomBool())")
// "And here's a random Boolean: true" 를 인쇄함
```

프로토콜 익스텐션은 준수 타입에 구현을 추가할 순 있지만 프로토콜을 확장하게 하거나[^protocol-extend] 또 다른 프로토콜을 상속하게 할 순 없습니다. 프로토콜 상속은 항상 프로토콜 선언 그 자체로 지정합니다.

#### Providing Default Implementations (기본 구현 제공하기)

프로토콜 익스텐션을 사용하면 그 프로토콜의 어떤 메소드나 계산 속성 필수 조건에도 기본 구현을 제공할 수 있습니다. 준수 타입이 필수 메소드나 속성에 자신만의 구현을 제공한다면, 익스텐션이 제공하는 것 대신 그 구현을 사용할 것입니다.

> 익스텐션이 기본 구현을 제공하는 프로토콜 필수 조건은 옵셔널 프로토콜 필수 조건과 서로 별개입니다. 어느 쪽도 준수 타입이 자신만의 구현을 제공하지 않아도 되지만, 기본 구현을 가진 필수 조건은 옵셔널 사슬 없이도 호출할 수 있습니다.

예를 들어, `TextRepresentable` 프로토콜을 상속한, `PrettyTextRepresentable` 프로토콜은, 단순히 `textualDescription` 속성에 접근한 결과를 반환한 걸 자신의 `prettyTextualDescription` 필수 속성 구현으로 제공할 수 있습니다:

```swift
extension PrettyTextRepresentable {
  var prettyTextualDescription: String {
    return textualDescription
  }
}
```

#### Adding Constraints to Protocol Extensions (프로토콜 익스텐션에 구속 조건 추가하기)

프로토콜 익스텐션을 정의할 때, 구속 조건을 지정하여 준수 타입이 이를 만족해야 익스텐션의 메소드와 속성을 쓸 수 있게 할 수 있습니다. 이러한 구속 조건은 확장할 프로토콜 이름 뒤에 일반화 `where` 절을 써서 작성합니다. 일반화 `where` 절에 대한 더 많은 내용은, [Generic Where Clauses (일반화 'where' 절)]({% link docs/swift-books/swift-programming-language/generic-parameters-and-arguments.md %}#generic-where-clauses-일반화-where-절) 부분을 보도록 합니다.

예를 들어, `Collection` 프로토콜에 익스텐션을 정의하면서 그 원소가 `Equatable` 프로토콜을 준수하는 어떤 집합체에 적용되게 할 수 있습니다. 표준 라이브러리의 일부인, `Equatable` 프로토콜로 집합체 원소를 구속함으로써, `==` 와 `!=` 연산자로 두 원소의 같음 (equality) 과 다름 (inequality) 을 검사할 수 있습니다.

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

`allEqual()` 메소드는 모든 집합체 원소가 같아야만 `true` 를 반환합니다.

하나는 모든 원소가 똑같고, 다른 하나는 그렇지 않은, 두 정수 배열을 고려합니다:

```swift
let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]
```

배열은 `Collection ` 을 준수하고 정수는 `Equatable` 을 준수하기 때문에[^array-and-integer], `equalNumbers` 와 `differentNumbers` 가 `allEqual()` 메소드를 사용할 수 있습니다:

```swift
print(equalNumbers.allEqual())
// "true" 를 인쇄함
print(differentNumbers.allEqual())
// "false" 를 인쇄함
```

> 준수 타입이 만족한 필수 조건이 여러 번 구속한 익스텐션꺼라서 동일한 메소드나 속성에 여러 개의 구현이 있다면, 스위프트는 가장 특수화된 구속 조건[^specialized] 에 해당하는 구현을 사용합니다.

### 다음 장

[Generics (일반화) >]({% link docs/swift-books/swift-programming-language/generics.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [Protocols](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#) 에서 볼 수 있습니다.

[^protocol]: '프로토콜 (protocol)' 은 '규약' 이라는 뜻을 가지고 있지만, 스위프트에서는 `protocol` 이라는 '키워드 (keyword)' 로도 사용됩니다. 그러므로, '익스텐션 (extension)' 이나 '클로저 (closure)' 처럼 '키워드' 로 사용될 때는 '프로토콜' 이라고 하고, 의미로 사용될 때는 '규약' 이라고 옮기도록 합니다.

[^requirements]: '필수 조건 (requirements)' 은 어떠한 타입이 프로토콜을 준수하려면 반드시 구현해야 하는 조건들을 말합니다.

[^blueprint]: '청사진 (blueprint)' 은 과거에 '제품 설계 도면' 이라는 의미로 사용하던 단어이며, 이는 설계 도면의 복사 방식이 과거에 파란색을 띄었기 때문입니다. 엑스코드 (Xcode) 아이콘을 보면 검은 망치 밑에 파란색 종이가 깔려 있는 데, 이 파란색 종이가 바로 청사진입니다. '청사진 (blueprint)' 에 대한 더 자세한 정보는, 위키피디아의 [Blueprint](https://en.wikipedia.org/wiki/Blueprint) 항목과 [청사진](https://ko.wikipedia.org/wiki/청사진) 항목을 보도록 합니다.

[^conform]: 'conform' 은 '규칙을 따른다 또는 준수한다' 정도로 옮길 수 있습니다. 본문에서 'conform' 을 명사의 형태로 사용하는 경우가 많아서 많은 경우에 '준수한다' 라고 옮기도록 합니다.

[^conforming-types]: '준수 타입 (conforming types)' 은 어떠한 프로토콜의 모든 필수 조건을 만족하는 타입을 말합니다. 모든 필수 조건을 만족한다는 건 모든 필수 조건을 실제로 구현한다는 의미입니다.

[^type-property-requirements]: 즉, 클래스의 '타입 속성 필수 조건 (type property requirements)' 은 `class` 나 `static` 을 구분할 필요 없이, 무조건 `static` 을 사용하면 됩니다.

[^qualified]: 전체 소속을 밝힌 이름은, 예를 들어, 파일 이름이라면 이름에 전체 경로가 있는 걸 말합니다. 본문 예제에선 사람이름에 성과 이름이 모두 있는 경우를 말하고 있습니다.

[^starship]: 이 예제에 있는 클래스 이름이 '우주선 (Starship)' 입니다. 참고로 예제에 있는 `ncc1701` 은 미국 유명 TV 시리즈인 **스타 트랙 (Star Trek)** 에 나오는 주인공 우주선의 제식번호 (registry) 이며, 이 우주선의 정식 이름은 **USS 엔터프라이즈 (USS Enterprise)** 입니다. 이에 대한 더 자세한 정보는, 위키피디아의 [USS Enterprise (NCC-1701)](https://en.wikipedia.org/wiki/USS_Enterprise_(NCC-1701)) 항목과 [USS 엔터프라이즈 (NCC-1701)](https://ko.wikipedia.org/wiki/USS_엔터프라이즈_(NCC-1701)) 항목을 보도록 합니다. 

[^random]: 이는 스위프트에 내장된 `random` 함수가 `0.0..<1.0` 범위의 값을 반환하기 때문입니다.

[^linear-congruential-generator]: '선형 합동 발생기' 는 널리 알려진 '유사 난수 발생기' 라고 합니다. 다만 '선형 합동 발생기' 는 인자와 마지막으로 생성한 난수를 알면 그 뒤의 모든 난수를 예측할 수 있기 때문에 바람직한 '난수 발생기' 는 아니라고 합니다. 이에 대한 더 자세한 정보는, 위키피디아의 [Linear congruential generator](https://en.wikipedia.org/wiki/Linear_congruential_generator) 와 [선형 합동 생성기](https://ko.wikipedia.org/wiki/선형_합동_생성기) 항목을 보도록 합니다. 참고로 위키피디아에서도 'generator' 를 '생성기' 라고도 하고 '발생기' 라고도 하고 있어서, 여기서는 '발생기' 라고 통일하여 옮깁니다.

[^required-modifier]: '수정자 (modifiers)' 는 선언한 것의 동작이나 의미를 수정하는 키워드입니다. 수정자에 대한 더 자세한 내용은 [Declaration Modifiers (선언 수정자)]({% link docs/swift-books/swift-programming-language/declarations.md %}#declaration-modifiers-선언-수정자) 부분을 참고하기 바랍니다.

[^required-initializer]: `required` 수정자로 표시한 초기자를 '필수 초기자 (required initializer)' 라고 한 건 준수 타입이 반드시 구현해야 하기 때문입니다.

[^satisfied-by]: 본문은 말로 설명하다 보니 굉장히 복잡해 보이는데, 키워드로 보면 `init?` 필수 조건은 `init?` 과 `init` 으로 만족할 수 있고, `init` 필수 조건은 `init` 과 `init!` 으로 만족할 수 있다는 의미입니다.

[^adopt]: 원문에서 '따름 (conforming)' 대신 '채택 (adopt)' 이란 단어를 썼습니다. 스위프트 문서에선 따르다와 채택하다라는 말을 항상 정확하게 구분하여 씁니다. 이 두 단어의 차이점은 본 글 맨 앞의 [Protocols (프로토콜; 규약)](#protocols-프로토콜-규약) 부분을 참고하기 바랍니다.

[^design-pattern]: '디자인 패턴 (design pattern)' 은 주어진 상황에 공통된 소프트웨어 문제에 대한 일반적이고, 재사용 가능한 해결책을 의미합니다. 디자인 패턴에 대한 더 자세한 정보는, 위키피디아의 [Software design pattern](https://en.wikipedia.org/wiki/Software_design_pattern) 과 [소프트웨어 디자인 패턴](https://ko.wikipedia.org/wiki/소프트웨어_디자인_패턴) 항목을 참고하기 바랍니다.

[^delegate]: 보통 '일-맡은자 (delegate)' 를 대리자라고도 합니다. '맡김 (delegation)' 에 대한 더 자세한 내용은 위키피디아의 [Delegation pattern](https://en.wikipedia.org/wiki/Delegation_pattern) 항목과, [Proxy pattern](https://en.wikipedia.org/wiki/Proxy_pattern) 항목 및 [프록시 패턴](https://ko.wikipedia.org/wiki/프록시_패턴) 항목을 보도록 합니다.

[^strong-reference-cycles]: '강한 참조 순환 (strong reference cycles)' 은 두 개의 참조 타입 인스턴스들이 서로를 참조하여 어느 것도 해제하지 못하게 하는 것을 말합니다. 강한 참조 순환에 대한 더 자세한 정보는 바로 뒤의 본문에서 설명하는, [Automatic Reference Counting (자동 참조 카운팅)]({% link docs/swift-books/swift-programming-language/automatic-reference-counting.md %}) 장의 [Strong Reference Cycles Between Class Instances (클래스 인스턴스 사이의 강한 참조 순환)]({% link docs/swift-books/swift-programming-language/automatic-reference-counting.md %}#strong-reference-cycles-between-class-instances-클래스-인스턴스-사이의-강한-참조-순환) 부분을 보도록 합니다. 

[^any-object]: 바로 뒤에서 설명하고 있듯이, `DiceGameDelegate` 프로토콜에 있는 `AnyObject` 가 이 프로토콜을 클래스-전용으로 만들어 줍니다.

[^instantiator]: '인스턴스를 만드는 자 (instantiator)' 는 코드 상에서 인스턴스를 생성하는 곳 또는 그 주체를 의미합니다. 실제 게임을 구현한다면, 일종의 `game manager` 같은 객체가 인스턴스를 생성할 텐데, 이 때 `game manager` 를 인스턴스를 만드는 자라고 할 수 있습니다.

[^weak-reference-cycles]: 이건 `DiceGameDelegate` 프로토콜과 `SnakesAndLadders` 클래스가 둘 다 참조 타입이기 때문에 발생하는 것으로, 예제에선 `weak var delegate: DiceGameDelegate?` 라고 `weak` 를 써서 참조 순환을 막고 있습니다. 둘 중 하나가 값 타입이었다면 이럴 필요가 없습니다.

[^optional-chaining]: 예제 코드에서 `gameDidStart` 함수를 호출할 때, 앞에 `delegate?` 라고 물음표를 붙여서 호출하는데, 이를 옵셔널 사슬 (optional chaining) 이라고 합니다. 옵셔널 사슬에 대한 더 자세한 정보는 [Optional Chaining (옵셔널 사슬)]({% link docs/swift-books/swift-programming-language/optional-chaining.md %}) 장을 참고하기 바랍니다.

[^gracefully-fail]: 스위프트에서 '우아하게 실패한다 (fail gracefully)' 는 건 실행-시간 에러가 발생하지 않는다는 의미입니다. 더 자세한 정보는, [Optional Chaining (옵셔널 사슬)]({% link docs/swift-books/swift-programming-language/optional-chaining.md %}) 장의 맨 앞부분에 있는 설명을 참고하기 바랍니다.

[^snakes-and-ladders-instance]: 예제 코드에서 `self` 자체가 `SnakesAndLadders` 의 인스턴스입니다.

[^array-element]: 즉, 본문 예제에서 `Array` 가 `TextRepresentable` 을 준수하는 조건은 `Array` 의 `Element` 가 `TextRepresentable` 을 준수할 때입니다.

[^adoption]: 이것이 스위프트에서 채택 (adoption) 과 따름 (conformance) 를 명확히 구분하는 이유입니다.

[^generic-type]: '일반화 타입 (generic type)' 은 어떤 타입하고도 작업할 수 있는 타입을 의미합니다. 일반화 타입에 대한 더 자세한 내용은, [Generics (일반화)]({% link docs/swift-books/swift-programming-language/generics.md %}) 장의 [Generic Types (일반화 타입)](#generic-types-일반화-타입) 부분을 보도록 합니다. 

[^synthesized]: '만들어져 있는 구현 (synthesized implementation)' 이란 스위프트 안에 이미 구현되어 있는 것으로, 예를 들어, `Equatable` 프로토콜을 채택하면 이를 따르게 하기 위한 코드를 따로 구현할 필요가 없다는 의미입니다.

[^associated-types]: '결합 타입 (associated types)' 이란 열거체에 있는 '결합 값 (associated values) 의 타입' 을 의미합니다. 열거체의 결합 값에 대한 더 많은 정보는, [Enumerations (열거체)]({% link docs/swift-books/swift-programming-language/enumerations.md %}) 장의 [Associated Values (결합 값)]({% link docs/swift-books/swift-programming-language/enumerations.md %}#associated-values-결합-값) 부분을 참고하기 바랍니다. 일반적인 의미에서의 결합 타입에 대해서는, [Generics (일반화)]({% link docs/swift-books/swift-programming-language/generics.md %}) 장의 [Associated Types (결합 타입)]({% link docs/swift-books/swift-programming-language/generics.md %}#associated-types-결합-타입) 부분도 참고하기 바랍니다.

[^equivalence]: '같음 비교 (equivalence)' 는 수학에서 말하는 동치와 같은 개념입니다. 'equivalence operators' 는 우리말로 '동등 연산자, 동치 연산자,같음 연산자' 등으로 옮길 수 있는데, 위키피디아에서 '같음 (equal to)' 을 사용하고 있어서, 같음 비교라는 말을 사용합니다. 관계 연산자에 대한 더 자세한 내용은, 위키피디아의 [Relational operator](https://en.wikipedia.org/wiki/Relational_operator) 항목과 [관계 연산자](https://ko.wikipedia.org/wiki/관계연산자) 항목을 참고하기 바랍니다.

[^raw-values]: '원시 값 (raw values)' 에 대한 더 자세한 정보는, [Enumerations (열거체)]({% link docs/swift-books/swift-programming-language/enumerations.md %}) 장에 있는 [Raw Values (원시 값)]({% link docs/swift-books/swift-programming-language/enumerations.md %}#raw-values-원시-값) 부분을 보도록 합니다.

[^remaining-comparison-operators]: 스위프트에는 `<` 연산자의 구현이 만들여져 있는 것외에도, `<=`, `>`, `>=` 연산자들에 대한 기본 구현도 제공하는데, 이 기본 구현들로 나머지 연산자들을 구현한다는 의미입니다. 즉, 만들어져 있는 `<` 연산자의 구현을 받으면, 나머지 연산자들은 구현하지 않아도 됩니다.

[^multiple-inherited-protocols]: 스위프트에서 클래스는 하나만 상속할 수 있지만, 프로토콜은 여러 개를 상속할 수 있습니다.

[^base-class]: 스위프트의 '기초 클래스 (base class)' 는 클래스 계층 구조 최상단에 위치하거나, 위치할 수 있는 클래스 입니다. 부모 클래스나 상위 클래스 중에서 가장 위에 위치하는 클래스라고 생각하면 됩니다. 기초 클래스에 대한 더 자세한 정보는, [Inheritance (상속)]({% link docs/swift-books/swift-programming-language/inheritance.md %}) 장의 [Defining a Base Class (기초 클래스 정의하기)]({% link docs/swift-books/swift-programming-language/inheritance.md %}#defining-a-base-class-기초-클래스-정의하기) 부분을 보도록 합니다.

[^type-safe]: '타입-안전 (type-safe) 하다' 는 건 '스위프트가 기본 제공하는 타입 추론 (type inference) 및 타입 검사 (type check) 기능을 사용할 수 있다' 는 의미입니다. 타입 추론 및 타입 검사에 대한 더 자세한 정보는, [The Basics (기초)]({% link docs/swift-books/swift-programming-language/the-basics.md %}) 장의 [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)]({% link docs/swift-books/swift-programming-language/the-basics.md %}#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 부분을 보도록 합니다.

[^attribute]: 스위프트의 '특성 (attribute)' 은 선언 및 타입에 추가 정보를 부여하는 도구입니다. 특성에 대한 더 자세한 정보는, [Attributes (특성)]({% link docs/swift-books/swift-programming-language/attributes.md %}) 장을 보도록 합니다.

[^protocol-extend]: '프로토콜 익스텐션으로 프로토콜을 확장할 수 없다' 는 건 '프로토콜 익스텐션으로 프로토콜에 새로운 필수 조건을 추가할 수 없다' 는 의미입니다. 프로토콜 익스텐션은 프로토콜에 새로운 필수 조건을 추가하는 것이 아니라, 기존의 필수 조건에 기본 구현을 제공하거나 새로운 기능을 추가하기 위해, 사용하는 것입니다.

[^array-and-integer]: 스위프트의 `Array` 타입은 `Collection` 프로토콜을 준수하고 `Int` 타입은 `Equatable` 을 준수하고 있다는 의미입니다.

[^specialized]: '가장 특수화된 구속 조건 (the most specialized constraints)' 은 '구속 조건 중에서 적용 범위가 가장 좁은 것' 을 말합니다. 가장 특수화된 구속 조건에 대한 더 자세한 내용은, 애플 [Developer Forums](https://developer.apple.com/forums/) 에 있는 [What does "most specialized constraints" mean?](https://forums.developer.apple.com/thread/70845) 항목을 보도록 합니다.
