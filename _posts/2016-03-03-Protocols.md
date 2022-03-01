---
layout: post
comments: true
title:  "Swift 5.5: Protocols (프로토콜; 규약)"
date:   2016-03-03 23:30:00 +0900
categories: Swift Language Grammar Protocol
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Protocols](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#) 부분[^Protocols] 을 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Protocols (프로토콜; 규약)

_프로토콜 (protocol)_[^protocol] 은 특별한 임무 또는 기능 조각에 적합한 메소드와, 속성, 및 다른 필수 조건[^requirements] 들의 청사진[^blueprint] 을 정의합니다. 그러면 클래스나, 구조체, 또는 열거체가 프로토콜을 _채택 (adopt)_ 하여 그 필수 조건들의 실제 구현을 제공할 수 있습니다. 프로토콜의 필수 조건을 만족하는 어떤 타입이든 그 프로토콜을 _준수한다 (conform)_ 고 말합니다.

준수 타입[^conforming-types] 이 반드시 구현해야 할 필수 조건의 지정에 더하여, 프로토콜을 확장하면 준수 타입이 이러한 필수 조건의 일부 또는 추가 기능의 구현이라는 이점을 취할 수 있습니다.

### Protocol Syntax (프로토콜 구문)

프로토콜은 클래스, 구조체, 및 열거체와 아주 비슷한 방식으로 정의합니다:

```swift
protocol SomeProtocol {
  // 프로토콜 정의는 여기에 둠
}
```

사용자 정의 타입은, 자신의 정의 부분에서, 타입 이름 뒤에 프로토콜 이름을, 콜론으로 구분하여, 둠으로써 한 특별한 프로토콜을 채택한다고 알립니다. 여러 개의 프로토콜을, 쉼표로 구분하여, 나열할 수도 있습니다:

```swift
struct SomeStructure: FirstProtocol, AnotherProtocol {
  // 구조체 정의는 여기에 둠
}
```

클래스에 상위 클래스가 있으면, 채택한 어떤 프로토콜들 보다 앞에 상위 클래스 이름을 나열하고, 그 뒤에 쉼표를 둡니다:

```swift
class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
  // 클래스 정의는 여기에 둠
}
```

### Property Requirements (속성 필수 조건)

프로토콜은 어떤 준수 타입이든 특별한 이름과 타입의 인스턴스 속성 및 타입 속성을 제공하도록 요구할 수 있습니다. 프로토콜은 속성이 저장 속성인지 계산 속성인지는 지정하지 않습니다-필수인 속성 이름과 타입만 지정합니다. 프로토콜은 각각의 속성이 반드시 획득 가능해야 하는지 아니면 획득 가능 _하면서 (and)_ 설정 가능해야 하는지도 지정합니다.

프로토콜이 획득 가능하면서 설정 가능한 속성을 요구하는 경우, 상수 저장 속성이나 읽기-전용 계산 속성으론 그 속성 필수 조건을 충족할 수 없습니다. 프로토콜이 획득 가능한 속성만을 요구하는 경우, 어떤 종류의 속성으로도 필수 조건을 만족할 수 있으며, 속성을 설정도 가능하게 하는게 자신의 코드에 유용하면 이러는 것도 유효합니다.

속성 필수 조건은 항상, `var` 키워드 접두사를 가진, 변수 속성으로 선언합니다. 획득 가능하면서 설정 가능한 속성은 자신의 타입 선언 뒤에 `{ get set }` 을 써서 지시하며, 획득 가능한 속성은 `{ get }` 을 써서 지시합니다.

```swift
protocol SomeProtocol {
  var mustBeSettable: Int { get set }
  var doesNotNeedToBeSettable: Int { get }
}
```

타입 속성 필수 조건을 프로토콜에서 정의할 땐 항상 `static` 키워드 접두사를 붙입니다. 이 규칙은 클래스가 구현할 때 타입 속성 필수 조건에 `class` 나 `static` 키워드 접두사를 붙일지라도 그대로 적용됩니다[^type-property-requirements]:

```swift
protocol AnotherProtocol {
  static var someTypeProperty: Int { get set }
}
```

단일한 인스턴스 속성 필수 조건을 가진 프로토콜은 이렇습니다:

```swift
protocol FullyNamed {
  var fullName: String { get }
}
```

`FullyNamed` 프로토콜은 준수 타입이 완전히 규명된 이름[^qualified] 을 제공하길 요구합니다. 프로토콜은 준수 타입에 대한 어떤 다른 본성도 지정하지 않습니다-타입 그 자체가 반드시 전체 이름을 제공할 수 있어야 한다는 것만 지정합니다. 프로토콜은 어떤 `FullyNamed` 타입이든, `fullName` 이라는, `String` 타입의, 획득 가능 인스턴스 속성을 가져야 한다고 알립니다.

`FullyNamed` 프로토콜을 채택하고 준수하는 단순한 구조체 예제는 이렇습니다:

```swift
struct Person: FullyNamed {
  var fullName: String
}
let john = Person(fullName: "John Appleseed")
// john.fullName 은 "John Appleseed" 임
```

이 예제는, 특정 이름의 사람을 나타내는, `Person` 이라는 구조체를 정의합니다. 이는 정의 첫째 줄 부분에서 `FullyNamed` 프로토콜을 채택한다고 알립니다.

각각의 `Person` 인스턴스는, `String` 타입의, `fullName` 이라는 단일 저장 속성을 가집니다. 이는 `FullyNamed` 프로토콜의 단일 필수 조건과 일치하며, `Person` 이 프로토콜을 올바로 준수한다는 의미입니다. (프로토콜 필수 조건을 충족하지 않으면 컴파일 시간에 스위프트가 에러를 보고합니다.)

역시 `FullyNamed` 프로토콜을 채택하고 준수하는, 더 복잡한 클래스는 이렇습니다:

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

이 클래스는 `fullName` 속성 필수 조건을 우주선[^starship] 의 읽기-전용 계산 속성으로 구현합니다. 각각의 `Starship` 클래스 인스턴스는 의무적인 `name` 과 옵션인 `prefix`[^optional] 를 저장합니다. `prefix` 값이 존재하면 `fullName` 속성이, `name` 맨 앞에 이를 붙여 우주선 전체 이름을 생성합니다.

### Method Requirements (메소드 필수 조건)

프로토콜은 준수 타입이 특정 인스턴스 메소드 및 타입 메소드를 구현하도록 요구할 수 있습니다. 이 메소드들은 보통의 인스턴스 및 타입 메소드와 정확히 똑같은 방식으로 프로토콜 정의 부분에 작성하지만, 중괄호나 메소드 본문이 없습니다. 보통의 메소드에서와 규칙이 동일하다는 전제로, 가변 매개 변수를 허용합니다. 하지만, 프로토콜 정의 안의 메소드 매개 변수에서 기본 값을 지정할 순 없습니다.

타입 속성 필수 조건 처럼, 프로토콜에서 타입 메소드 필수 조건을 정의할 땐 항상 `static` 키워드 접두사를 붙입니다. 타입 메소드 필수 조건을 클래스가 구현할 때 `class` 나 `static` 키워드 접두사를 붙일지라도 그렇습니다:

```swift
protocol SomeProtocol {
  static func someTypeMethod()
}
```

다음 예제는 단일 인스턴스 메소드 필수 조건을 가진 프로토콜을 정의합니다:

```swift
protocol RandomNumberGenerator {
  func random() -> Double
}
```

`RandomNumberGenerator` 라는, 이 프로토콜은 어떤 준수 타입이든 `random` 이라는 인스턴스 메소드를 가지길 요구하는데, 이는 호출할 때마다 `Double` 값을 반환합니다. 프로토콜에서 지정하지 않긴 않지만, 이 값은 `0.0` 에서 `1.0` 까지의 (1.0 을 포함하진 않는) 값이라 가정합니다.[^random]

`RandomNumberGenerator` 프로토콜은 각각의 난수 발생 방법에 대해선 어떤 가정도 하지 않습니다-단순히 새 난수 발생을 위한 표준 방식을 발생기[^generator] 가 제공하길 요구할 뿐입니다.

다음 구현은 `RandomNumberGenerator` 프로토콜을 채택하고 준수하는 클래스입니다. 이 클래스는 _선형 합동 발생기 (linear congruential generator)_[^linear-congruential-generator] 라는 의사 (pseudorandom) 난수 발생 알고리즘을 구현합니다:

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

메소드가 자신이 속한 인스턴스를 수정 (또는 _변경 (mutate)_ 하는) 것이 필요할 때가 있습니다. 값 타입의 (즉, 구조체 및 열거체의) 인스턴스 메소드면 메소드의 `func` 키워드 앞에 `mutating` 키워드를 둬서 메소드가 자신이 속한 인스턴스 및 그 인스턴스에 있는 어떤 속성의 수정이든 허용한다고 지시합니다. 이 과정은 [Modifying Value Types from Within Instance Methods (인스턴스 메소드 안에서 값 타입 수정하기)]({% post_url 2020-05-03-Methods %}#modifying-value-types-from-within-instance-methods-인스턴스-메소드-안에서-값-타입-수정하기) 에서 설명합니다.

프로토콜을 채택한 어떤 타입의 인스턴스든 변경할 의도로 프로토콜 인스턴스 메소드 필수 조건을 정의하는 거라면, 프로토콜 정의 부분에서 `mutating` 키워드로 메소드를 표시합니다. 이는 구조체 및 열거체가 프로토콜을 채택해서 그 메소드 필수 조건을 만족할 수 있게 합니다.

> 프로토콜 인스턴스 메소드 필수 조건을 `mutating` 으로 표시한 경우, 그 메소드를 클래스가 구현할 땐 `mutating` 키워드를 작성할 필요가 없습니다. `mutating` 키워드는 구조체와 열거체만 사용합니다.

아래 예제는, `toggle` 이라는 단일 인스턴스 메소드 필수 조건을 정의하는, `Togglable` 이라는 프로토콜을 정의합니다. 이름이 제시하듯, `toggle()` 메소드의 의도는, 전형적으로 그 타입의 속성을 변경함으로써, 어떤 준수 타입의 상태를 전환 (toggle) 또는 반전 (invert) 하는 겁니다.

`Togglable` 프로토콜 정의 부분에서 `toggle()` 메소드를 `mutating` 키워드로 표시하여, 메소드를 호출할 때 준수 인스턴스[^conforming-instance] 의 상태를 변경하길 예상한다고 지시합니다:

```swift
protocol Togglable {
  mutating func toggle()
}
```

구조체나 열거체가 `Togglable` 프로토콜을 구현하면, `mutating` 으로도 표시한 `toggle()` 메소드를 구현함으로써 그 구조체나 열거체가 프로토콜을 준수할 수 있습니다.

아래 예제는 `OnOffSwitch` 라는 열거체를 정의합니다. 이 열거체는, `on` 과 `off` 열거체 case 로 표시한, 두 상태 사이를 전환합니다. `Togglable` 프로토콜의 필수 조건과 일치하도록, 열거체의 `toggle` 구현에 `mutating` 을 표시합니다:

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

프로토콜은 준수 타입에게 특정 초기자의 구현을 요구할 수 있습니다. 이 초기자들은 보통의 초기자와 정확히 똑같은 방식으로 프로토콜 정의 부분에 작성하지만, 중괄호나 메소드 본문이 없습니다:

```swift
protocol SomeProtocol {
  init(someParameter: Int)
}
```

#### Class Implementation of Protocol Initializer Requirements (프로토콜 초기자 요구 조건의 클래스 구현)

준수 클래스에선 프로토콜 초기자 요구 조건을 지명 초기자나 편의 초기자 어느 거로든 구현할 수 있습니다. 두 경우 모두, 초기자 구현에 반드시 `required` 수정자[^required] 를 표시해야 합니다:

```swift
class SomeClass: SomeProtocol {
  required init(someParameter: Int) {
    // 초기자 구현은 여기에 둠
  }
}
```

`required` 수정자의 사용은 준수 클래스의 모든 하위 클래스가 초기자 요구 조건의 명시적 또는 상속 구현을 제공해서, 이들도 프로토콜을 준수하도록, 보장합니다.

필수 (required) 초기자에 대한 더 많은 정보는, [Required Initializers (필수 초기자)]({% post_url 2016-01-23-Initialization %}#required-initializers-필수-초기자) 부분을 참고하기 바랍니다.

> `final` 수정자로 표시한 클래스에서는 '프로토콜 초기자 필수 조건' 을 `required` 수정자로 표시할 필요가 없는데, 왜냐면 '최종 (final) 클래스' 는 하위 클래스를 만들 수 없기 때문입니다.[^final] `final` 수정자에 대한 더 많은 내용은, [Preventing Overrides (재정의 막기)]({% post_url 2016-01-23-Initialization %}#preventing-overrides-재정의-막기) 를 참고하기 바랍니다.

하위 클래스가 상위 클래스에 있는 '지명 초기자' 를 '재정의' 하면서, 프로토콜에서 일치하고 있는 '초기자 필수 조건' 도 구현하는 경우, 그 '초기자 구현' 은 `required` 와 `override` 수정자 둘 다 표시합니다:

```swift
protocol SomeProtocol {
  init()
}

class SomeSuperClass {
  init() {
    // 초기자 구현은 여기에 둡니다.
  }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
  // "required" 는 SomeProtocol 을 준수하기 위함; "override" 는 SomeSuperClass 를 준수하기 위함
  required override init() {
    // 초기자 구현은 여기에 둡니다.
  }
}
```

#### Failable Initializer Requirements (실패 가능 초기자 필수 조건)

프로토콜은, [Failable Initializers (실패 가능 초기자)]({% post_url 2016-01-23-Initialization %}#failable-initializers-실패-가능한-초기자) 에서 정의한 것처럼, 준수 타입을 위한 '실패 가능 초기자 필수 조건' 을 정의할 수 있습니다.

'실패 가능 초기자 필수 조건' 은 '준수 타입' 에서 '실패 가능' 또는 '실패하지 않는 초기자' 로 만족시킬 수 있습니다. '실패하지 않는 (nonfailable) 초기자 필수 조건' 은 '실패하지 않는 초기자' 또는 '암시적으로 포장 푸는 실패 가능 초기자' 로 만족시킬 수 있습니다.

### Protocols as Types (타입으로써의 프로토콜)

프로토콜 스스로는 실제로 어떤 기능도 구현하지 않습니다. 그럼에도 불구하고, 프로토콜은 온전히 독립 가능한 타입인 것처럼 코드에서 사용할 수 있습니다. 프로토콜을 타입으로 사용하는 것을 _실존 타입 (existential type)_ 이라 부를 때가 있는데, 이는 "프로토콜을 준수하는 그러한 T 가 실제로 존재한다 (exists)" 라는 구절에서 비롯한 것입니다.

다음을 포함하여, 그 외 타입들이 허용된 많은 곳에서 프로토콜을 사용할 수 있습니다:

* 함수, 메소드, 또는 초기자에 있는 '매개 변수 타입' 이나 '반환 타입' 으로써
* 상수, 변수, 또는 속성의 '타입' 으로써
* 배열, 딕셔너리, 또는 그 외 '컨테이너 (container)' 에 있는 '항목의 타입' 으로써

> 프로토콜은 타입이기 때문에, 스위프트에 있는 (`Int`, `String`, 그리고 `Double` 같은) 다른 타입의 이름과 일치하도록 (`FullyNamed` 와 `RandomNumberGenerator` 같이) 이름을 대문자로 시작합니다.

다음은 프로토콜을 타입으로 사용하는 예제입니다:

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

이 예제는, 보드 게임에서 사용할 'n-면체 주사위' 를 표현하는, `Dice` 라는 새로운 클래스를 정의합니다. `Dice` 인스턴스는, 가진 면의 개수를 표현하는, `sides` 라는 '정수 속성' 과, '주사위 굴림 값' 생성을 위한 '난수 발생기' 를 제공하는, `generator` 라는 속성을 가집니다.

`generator` 속성은 `RandomNumberGenerator` 타입입니다. 그러므로, `RandomNumberGenerator` 프로토콜을 채택한 _어떤 (any)_ 타입의 인스턴스든 설정할 수 있습니다.
이 속성에 할당하는 인스턴스는, 인스턴스가 `RandomNumberGenerator` 프로토콜을 반드시 '채택 (adopt)' 해야[^adopt] 한다는 것만 제외하면, 다른 아무 것도 필요하지 않습니다. 타입이 `RandomNumberGenerator` 이기 때문에, `Dice` 클래스 안에 있는 코드는 이 프로토콜을 준수하는 모든 '발생기 (generator)' 에 적용되는 방식으로만 `generator` 하고 상호 작용할 수 있습니다. 이는 '발생기' 의 실제 타입이 정의한 메소드나 속성은 어떤 것도 사용할 수 없다는 의미입니다. 하지만, [Downcasting (내림 변환)]({% post_url 2020-04-01-Type-Casting %}#downcasting-내림-변환) 에서 논의한 것처럼, 상위 클래스에서 하위 클래스로 내림 변환할 수 있는 것과 똑같은 방식으로 '프로토콜 타입' 을 '실제 타입' 으로 내림 변환할 수 있습니다.

`Dice` 는, 초기 상태를 설정하는, 초기자도 가지고 있습니다. 이 초기자, 역시 `RandomNumberGenerator` 타입인, `generator` 라는 매개 변수를 가집니다. 새로운 `Dice` 인스턴스를 초기화할 때, 이 매개 변수에는 어떤 '준수 타입' 의 값이든 전달 할 수 있습니다.

`Dice` 는, '1' 에서 주사위의 '면 개수' 사이의 정수 값을 반환하는, `roll` 이라는, 인스턴스 메소드를 하나 제공합니다. 이 메소드는 '발생기' 의 `random()` 메소드를 호출하여, `0.0` 과 `1.0` 사이의 새로운 난수를 생성하고, 이 난수로 올바른 범위의 '주사위 굴림 값' 을 생성합니다. `generator` 가 `RandomNumberGenerator` 를 채택하고 있기 때문에, `random()` 메소드를 가지고 호출할 수 있음이 보증된 것입니다.

다음은 `Dice` 클래스를 사용하여 '난수 발생기' 로 `LinearCongruentialGenerator` 인스턴스를 가지는 '6-면체 주사위' 를 생성하는 방법입니다:

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

### Delegation (위임)

_위임 (delegation)_ 은 클래스나 구조체가 다른 타입의 인스턴스로 책임의 일부를 넘기도록-또는 _위임 (delegate)_ 하도록- 해주는 '디자인 패턴 (design pattern)' 입니다. 이 '디자인 패턴' 은 위임한 책임을 '은닉 (encapsulates)' 하는 프로토콜을 정의해서, ('대리자 (delegate)'[^delegate] 라고 하는) '준수 타입' 이 위임된 기능을 제공하도록 보증합니다. '위임' 은 특별한 행동에 응답하거나, 해당 소스의 실제 타입을 알 필요 없이 외부 소스에서 데이터를 가져오기 위해, 사용할 수 있습니다.

아래 예제는 '주사위-기반의 보드 게임' 에서 사용할 두 개의 프로토콜을 정의합니다:

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

`DiceGame` 프로토콜은 주사위와 엮여 있는 어떤 게임이든 채택할 수 있는 프로토콜입니다.

`DiceGameDelegate` 프로토콜은 `DiceGame` 의 진행 과정을 추적하기 위해 채택할 수 있습니다. '강한 참조 순환' 을 막기 위해, '대리자 (delegates)' 는 '약한 참조' 로 선언합니다. '약한 참조' 에 대한 정보는, [Strong Reference Cycles Between Class Instances (클래스 인스턴스 사이의 강한 참조 순환)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#strong-reference-cycles-between-class-instances-클래스-인스턴스-사이의-강한-참조-순환) 을 참고하기 바랍니다. 프로토콜을 '클래스-전용' 이라고 표시하는 것은 이 장 나중에 나오는 `SnakesAndLadders` 클래스가 자신의 '대리자' 을 반드시 '약한 참조' 로 사용해야 한다고 선언하도록 합니다. 클래스-전용 프로토콜은, [Class-Only Protocols (클래스-전용 프로토콜)](#class-only-protocols-클래스-전용-프로토콜) 에서 논의한 것처럼, `AnyObject` 를 상속하는 것으로 표시합니다.

다음은 원래 [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에서 소개했던 _뱀과 사다리 (Snakes and Ladders)_ 게임의 다른 버전입니다. 이 버전은 '주사위-굴림 값' 으로 `Dice` 인스턴스를 사용하고; `DiceGame` 프로토콜을 채택하며; 자신의 진행 과정을 `DiceGameDelegate` 에 알리도록; 개조한 것입니다:

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

_뱀과 사다리 (Snakes and Ladders)_ 게임 진행 방식에 대한 설명은, [Break (break 문)]({% post_url 2020-06-10-Control-Flow %}#break-break-문) 부분을 참고하기 바랍니다.

이 버전은, `DiceGame` 프로토콜을 채택한, `SnakesAndLadders` 라는 클래스로 게임을 '포장 (wrapped up)' 합니다. 이는 프로토콜을 준수하기 위해 '획득 가능한 `dice` 속성' 과 '`play()` 메소드' 를 제공합니다. (`dice` 속성은, 초기화 후 바뀔 필요가 없으며, 프로토콜은 획득 가능하기만 하면 된다는 것을 요구하고 있기 때문에, 상수 속성으로 선언합니다.)

_뱀과 사다리 (Snakes and Ladders)_ 게임판의 설정은 클래스의 `init()` 초기자 안에서 일어납니다. 모든 게임 '논리 (logic)' 는 프로토콜의 `play` 메소드 속으로 옮겨지며, 여기서 '주사위 굴림 값' 을 제공하는 프로토콜의 '필수 `dice` 속성' 을 사용합니다.

'대리자 (delegate)' 가 게임 진행에 필수인 건 아니기 때문에, `delegate` 속성은 '_옵셔널 (optional)_ `DiceGameDelegate`' 로 정의함을 기억하기 바랍니다. `delegate` 속성은, 옵셔널 타입이기 때문에, '초기 값' 이 자동으로 `nil` 로 설정됩니다. 그 이후, 게임의 '인스턴스를 만드는 부분'[^instantiator] 이 적합한 '대리자' 를 속성에 설정할 옵션을 가지게 도비니다. `DiceGameDelegate` 프로토콜은 '클래스-전용' 이기 때문에, '참조 순환' 을 막기 위해 '대리자' 를 `weak` 라고 선언할 수 있습니다.

`DiceGameDelegate` 는 게임의 진행 과정을 추적하는 세 개의 메소드를 제공합니다. 이 세 메소드들은 위 `play()` 메소드에 있는 게임 논리에 편입되어, 새로운 게임을 시작할 때나, 새로운 '차례 (turn)' 를 시작할 때, 또는 게임이 끝날 때, 호출됩니다.

`delegate` 속성이 _옵셔널 (optional)_ `DiceGameDelegate` 이기 때문에, `play()` 메소드는 '대리자' 에 대한 메소드를 매 번 호출할 때마다 '옵셔널 연쇄 (chaining)' 를 사용합니다. `delegate` 속성이 'nil' 이면, 이 '대리자 호출' 은 에러 없이 '우아하게 실패'[^gracefully-fail] 합니다. `delegate` 속성이 'nil-이 아니' 라면, '대리자 메소드' 를 호출해서, `SnakesAndLadders` 인스턴스를 매개 변수로 전달합니다.[^snakes-and-ladders-instance]

이 다음 예제는, `DiceGameDelegate` 프로토콜을 채택하는, `DiceGameTracker` 라는 클래스를 보여줍니다:

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

`DiceGameTracker` 는 `DiceGameDelegate` 에 필수인 세 메소드를 모두 구현합니다. 이 메소드를 사용하여 게임이 취한 '차례 (turn)' 수를 추적합니다. 게임을 시작하면 `numberOfTurns` 속성을 '0' 으로 '재설정' 하고, 매 번 새로운 차례를 시작할 때 증가시키며, 게임이 끝나면 총 '차례' 수를 인쇄합니다.

위에 보인 `gameDidStart(_:)` 구현은 `game` 매개 변수를 사용하여 진행할 게임에 대한 약간의 소개 정보를 인쇄합니다. `game` 매개 변수는, `SnakesAndLadders` 가 아니라, `DiceGame` 타입이므로, `gameDidStart(_:)` 는 `DiceGame` 프로토콜로 구현된 메소드와 속성에만 접근하여 사용할 수 있습니다. 하지만, 메소드는 '타입 변환 (type casting)' 을 사용하여 여전히 실제 인스턴스의 타입을 조회할 수 있습니다. 이 예제에서는, `game` 이 실제로 `SnakesAndLadders` 인스턴스인지를 검사해서, 그게 맞다면 적절한 메시지를 인쇄합니다.

`gameDidStart(_:)` 메소드는 전달한 `game` 매개 변수의 `dice` 속성에도 접근합니다. `game` 이 `DiceGame` 프로토콜을 준수함을 알기 때문에, `dice` 속성을 가짐이 보증되므로, `gameDidStart(_:)` 메소드는, 어떤 종류의 게임을 진행하는 지에 상관없이, 주사위의 `sides` 속성에 접근하여 인쇄할 수 있습니다.

다음은 `DiceGameTracker` 의 실제 사용 방법을 보인 것입니다:

```swift
let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()
// Started a new game of Snakes and Ladders / 새로운 뱀과 사다리 게임을 시작합니다.
// The game is using a 6-sided dice / 이 게임은 6-면체 주사위를 사용합니다.
// Rolled a 3 / 3이 나왔습니다.
// Rolled a 5 / 5가 나왔습니다.
// Rolled a 4 / 4가 나왔습니다.
// Rolled a 5 / 5가 나왔습니다.
// The game lasted for 4 turns / 이 게임은 4 차례 동안 진행됐습니다.
```

### Adding Protocol Conformance with an Extension (익스텐션으로 프로토콜 준수성 추가하기)

기존 타입의 소스 코드에 접근할 수 없는 경우에도, 새로운 프로토콜을 채택하고 준수하도록 기존 타입을 확장할 수 있습니다. '익스텐션 (extension)' 은 기존 타입에 새로운 속성, 메소드, 그리고 첨자 연산을 추가할 수 있으며, 따라서 프로토콜이 요구할 수도 있는 어떤 필수 조건이든 추가할 수 있습니다. '익스텐션' 에 대한 더 많은 내용은, [Extensions (익스텐션; 확장)]({% post_url 2016-01-19-Extensions %}) 을 참고하기 바랍니다.

> '익스텐션' 에서 해당 '준수성' 을 인스턴스의 타입에 추가할 때 타입의 기존 인스턴스는 프로토콜을 자동으로 채택하고 춘수하게 됩니다.

예를 들어, `TextRepresentable` 이라는, 다음 프로토콜은 '문장' 으로 표현할 방식을 가진 어떤 타입이든 구현하게 할 수 있습니다. 이는 자신에 대한 설명일 수도, 아니면 현재 상태의 문장 버전일 수도 있습니다:

```swift
protocol TextRepresentable {
  var textualDescription: String { get }
}
```

위에 있는 `Dice` 클래스는 `TextRepresentable` 을 채택하고 준수하도록 확장할 수 있습니다:

```swift
extension Dice: TextRepresentable {
  var textualDescription: String {
    return "A \(sides)-sided dice"
  }
}
```

이 '익스텐션' 은 마치 `Dice` 가 이를 원본 구현에서 제공한 것과 정확하게 똑같은 방식으로 새로운 프로토콜을 채택합니다. 이 프로토콜 이름은, 콜론으로 구분하여, 타입 이름 뒤에 제공하며, 프로토콜의 모든 '필수 조건' 은 '익스텐션' 중괄호 안에서 제공합니다.

이제 '어떤 `Dice` 인스턴스' 든 `TextRepresentable` 처럼 취급할 수 있습니다:

```swift
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)
// "A 12-sided dice" 를 인쇄합니다.
```

이와 비슷하게, `SnakesAndLadders` 게임 클래스도 `TextRepresentable` 프로토콜을 채택하고 준수하도록 확장할 수 있습니다:

```swift
extension SnakesAndLadders: TextRepresentable {
  var textualDescription: String {
    return "A game of Snakes and Ladders with \(finalSquare) squares"
  }
}
print(game.textualDescription)
// "A game of Snakes and Ladders with 25 squares" 를 인쇄합니다.
```

#### Conditionally Conforming to a Protocol (조건에 따라 프로토콜 준수하기)

'일반화 (generic) 타입' 은, 타입의 '일반화 매개 변수' 가 프로토콜을 준수할 때와 같이, 정해진 조건 하에서만 프로토콜의 '필수 조건' 을 만족할 수도 있습니다. '일반화 타입' 은 타입을 확장할 때 '구속 조건 (constraints)' 을 나열하는 것으로써 조건에 따라 프로토콜을 준수하도록 만들 수 있습니다. 이 '구속 조건' 들은 채택하려는 프로토콜 이름 뒤에 '일반화 `where` 절' 을 작성함으로써 작성합니다. '일반화 `where` 절' 에 대한 더 자세한 내용은, [Generic Where Clauses (일반화 'where' 절)]({% post_url 2020-02-29-Generics %}#generic-where-clauses-일반화-where-절) 을 참고하기 바랍니다.

다음 '익스텐션' 은 `Array` 인스턴스가 `TextRepresentable` 을 준수하는 타입의 원소를 저장할 때마다 `TextRepresentable` 프로토콜을 준수하게 만듭니다.[^array-element]

```swift
extension Array: TextRepresentable where Element: TextRepresentable {
  var textualDescription: String {
    let itemsAsText = self.map { $0.textualDescription }
    return "[" + itemsAsText.joined(separator: ", ") + "]"
  }
}
let myDice = [d6, d12]
print(myDice.textualDescription)
// "[A 6-sided dice, A 12-sided dice]" 를 인쇄합니다.
```

#### Declaring Protocol Adoption with an Extension (확장으로 프로토콜 채택 선언하기)

타입이 이미 프로토콜의 모든 '필수 조건' 을 준수하고 있지만, 아직 해당 프로토콜을 채택한다고 알리지 않은 경우라면, 빈 '익스텐션' 으로 해당 프로토콜을 채택하도록 만들 수 있습니다:

```swift
struct Hamster {
  var name: String
  var textualDescription: String {
    return "A hamster named \(name)"
  }
}
extension Hamster: TextRepresentable {}
```

이제 `TextRepresentable` 이 필수 요구 타입인 곳마다 `Hamster` 인스턴스를 사용할 수 있습니다:

```swift
let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
// "A hamster named Simon" 을 인쇄합니다.
```

> 타입은 '필수 조건' 을 만족한다고 해서 프로토콜을 자동으로 채택하진 않습니다. 프로토콜을 채택한다고 반드시 항상 명시적으로 선언해야 합니다.[^adoption]

### Adopting a Protocol Using a Synthesized Implementation (통합된 구현을 사용하여 프로토콜 채택하기)

스위프트는 많은 단순한 경우에 `Equatable`, `Hashable`, 그리고 `Comparable` 에 대한 '프로토콜 준수성 (protocol conformance)' 을 자동으로 제공할 수 있습니다. 이 '통합된 (synthesized) 구현'[^synthesized] 을 사용한다는 것은 '프로토콜 필수 조건' 을 직접 구현하기 위해서 '반복적이고 획일적인 (bolilerplate) 코드' 를 작성하지 않아도 된다는 의미입니다.

스위프트는 다음 종류의 사용자 정의 타입에 대해서 `Equatable` 에 대한 '통합된 구현' 을 제공합니다:

* `Equatable` 프로토콜을 준수하는 '저장 속성' 만을 가진 구조체
* `Equatable` 프로토콜을 준수하는 '결합 타입'[^associated-types] 만을 가진 열거체
* '결합 타입' 을 전혀 가지고 있지 않은 열거체

`==` 에 대한 '통합된 구현' 을 부여 받으려면, `==` 연산자를 직접 구현하지 말고, '원본 선언을 담고 있는 파일' 에서 `Equatable` 을 '준수 (conformance)' 한다고 선언합니다. '`Equatable` 프로토콜' 은 `!=` 에 대한 기본 구현을 제공합니다.

아래 예제는, `Vector2D` 구조체와 비슷하게, '3-차원 위치 벡터 `(x, y, z)`' 를 위한 `Vector3D` 구조체를 정의합니다. `x`, `y`, 그리고 `z` 속성은 모두 `Equatable` 타입이기 때문에, `Vector3D` 는 '같음 비교 (equivalence)[^equivalence] 연산자' 에 대한 '통합된 구현' 을 부여 받습니다.

```swift
struct Vector3D: Equatable {
  var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
  print("These two vectors are also equivalent.")
}
// "These two vectors are also equivalent." 를 인쇄합니다.
```

스위프트는 다음 종류의 사용자 정의 타입에 대해서 `Hashable` 에 대한 '통합된 구현' 을 제공합니다:

* `Hashable` 프로토콜을 준수하는 '저장 속성' 만을 가진 구조체
* `Hashable` 프로토콜을 준수하는 '결합 타입' 만을 가진 열거체
* '결합 타입' 을 전혀 가지고 있지 않은 열거체

`hash(into:)` 에 대한 '통합된 구현' 을 부여 받으려면, `hash(into:)` 메소드를 직접 구현하지 말고, '원본 선언을 담고 있는 파일' 에서 `Hashable` 을 '준수 (conformance)' 한다고 선언합니다.

스위프트는 '원시 값'[^raw-values] 을 가지고 있지 않은 열거체를 위해 `Comparable` 에 대한 '통합된 구현' 을 제공합니다. 열거체가 '결합 타입' 을 가지고 있는 경우, 이들은 반드시 모두 `Comparable` 프로토콜을 준수해야 합니다. `<` 에 대한 '통합된 구현' 을 부여 받으려면, `<` 연산자를 직접 구현하지 말고, '원본 열거체 선언을 담은 파일' 에서 `Comparable` 을 '준수 (conformance)' 한다고 선언합니다. `<=`, `>`, 그리고 `>=` 에 대한 `Comparable` 프로토콜의 기본 구현은 남아 있는 비교 연산자들을 제공합니다.[^remaining-comparison-operators]

아래 예제는 '초보자', '중급자', 그리고 '전문가' 라는 'case 값' 을 가진 `SkillLevel` 열거체를 정의합니다. '전문가' 는 자신이 가진 별의 개수로 추가적인 등급을 나눕니다.

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
// "beginner" 를 인쇄합니다.
// "intermediate" 를 인쇄합니다.
// "expert(stars: 3)" 를 인쇄합니다.
// "expert(stars: 5)" 를 인쇄합니다.
```

### Collections of Protocol Types (프로토콜 타입의 집합체)

프로토콜은, [Protocols as Types (타입으로써의 프로토콜)](#protocols-as-types-타입으로써의-프로토콜) 에서 언급한 것처럼, 배열이나 딕셔너리 같은 '집합체 (collection)' 에 저장할 타입으로 사용할 수 있습니다. 다음 예제는 '`TextRepresentable` (문장 표현이 가능한) 것' 들의 배열을 생성합니다:

```swift
let things: [TextRepresentable] = [game, d12, simonTheHamster]
```

이제 배열에 있는 항목에 동작을 반복해서, 각 항목에 대한 문장 설명을 인쇄합니다:

```swift
for thing in things {
  print(thing.textualDescription)
}
// A game of Snakes and Ladders with 25 squares (25개의 정사각형을 가지는 뱀과 사다리 게임)
// A 12-sided dice (12-면체 주사위)
// A hamster named Simon (Simon 이라는 이름의 햄스터)
```

`thing` 상수는 `TextRepresentable` 타입 임을 기억하기 바랍니다. 타입은, 실제 그 속은 `Dice` 나, `DiceGame`, 또는 `Hamster` 타입 일지라도, 이 타입들이 아닙니다. 그럼에도 불구하고, 이는 `TextRepresentable` 타입이며, `TextRepresentable` 인 어떤 것이든 `textualDescription` 속성을 가짐을 알기 때문에, 반복문의 매 회차마다 `thing.textualDescription` 에 안전하게 접근할 수 있습니다.

### Protocol Inheritance (프로토콜 상속)

프로토콜은 하나 이상의 다른 프로토콜을 _상속 (inherit)_ 할 수 있으며 상속한 '필수 조건' 위에 다른 '필수 조건' 을 더 추가할 수 있습니다. '프로토콜 상속' 구문은 '클래스 상속' 구문과 비슷하지만, 쉼표로 구분하여, '다중 상속 프로토콜' 을 나열할 수 있습니다[^multiple-inherited-protocols]:

```swift
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
  // 프로토콜 정의는 여기에 둡니다.
}
```

다음은 위에 있는 `TextRepresentable` 프로토콜을 상속하는 프로토콜 예제입니다:

```swift
protocol PrettyTextRepresentable: TextRepresentable {
  var prettyTextualDescription: String { get }
}
```

이 예제는, `TextRepresentable` 을 상속한, `PrettyTextRepresentable` 이라는, 새로운 프로토콜을 정의합니다. `PrettyTextRepresentable` 을 채택한 어떤 것이든 `TextRepresentable` 이 강제하는 모든 '필수 조건' , 에 _더해서 (plus)_ `PrettyTextRepresentable` 이 강제하는 추가적인 '필수 조건' 도, 반드시 만족해야 합니다. 이 예제의, `PrettyTextRepresentable` 은 `String` 을 반환하는 `prettyTextualDescription` 이라는 '획득 가능한 속성' 을 제공하기 위한 단일 '필수 조건' 을 추가합니다.

`SnakesAndLadders` 클래스는 `PrettyTextRepresentable` 을 채택하고 준수하도록 확장할 수 있습니다:

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

이 '익스텐션' 은 `PrettyTextRepresentable` 프로토콜을 채택하여 `SnakesAndLadders` 타입을 위한 `prettyTextualDescription` 속성의 구현을 제공한다고 알립니다. `PrettyTextRepresentable` 인 어떤 것이든 반드시 `TextRepresentable` 이기도 하므로, `prettyTextualDescription` 구현은 `TextRepresentable` 프로토콜에 있는 `textualDescription` 속성에 먼저 접근하고나서 출력 문자열을 만들기 시작합니다. 이는 '콜론 (`:`)' 과 '줄 끊음 (`\n`)' 을 덧붙여, 문장 표현을 예쁘게 꾸미기 시작합니다. 그런 다음 게임판의 '정사각형 배열' 에 동작을 반복해서, 각 정사각형의 내용물을 표현하는 기하학 도형을 덧붙입니다:

* 정사각형의 값이 `0` 보다 크면, 사다리의 밑부분이므로, `▲` 로 표현합니다.
* 정사각형의 값이 `0` 보다 작으면, 뱀의 머리이므로, `▼` 로 표현합니다.
* 그 외의 경우, 정사각형의 값은 `0` 이고, "자유로운 (free)" 정사각형이므로, `○` 로 표현합니다.

이제 `prettyTextualDescription` 속성은 어떤 `SnakesAndLadders` 인스턴스의 '예쁘게 꾸민 문장 설명' 이라도 인쇄할 수 있습니다:

```swift
print(game.prettyTextualDescription)
// A game of Snakes and Ladders with 25 squares:
// ○ ○ ▲ ○ ○ ▲ ○ ○ ▲ ▲ ○ ○ ○ ▼ ○ ○ ○ ○ ▼ ○ ○ ▼ ○ ▼ ○
```

### Class-Only Protocols (클래스-전용 프로토콜)

'프로토콜 상속 목록'[^inheritance] 에 `AnyObject` 프로토콜을 추가함으로써 (구조체나 열거체가 아닌) 클래스 타입만 프로토콜을 '채택 (adoptation)' 하도록 제한할 수 있습니다.

```swift
protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
  // 클래스-전용 프로토콜 정의는 여기에 둡니다.
}
```

위 예제에서, `SomeClassOnlyProtocol` 은 클래스 타입만 채택할 수 있습니다. `SomeClassOnlyProtocol` 을 채택하려고 구조체나 열거체 정의를 작성하는 것은 '컴파일-시간 에러' 입니다.

> 해당 프로토콜의 '필수 조건' 에서 정의한 작동 방식이 '준수 타입' 은 '값 의미 구조' 가 아닌 '참조 의미 구조' 를 가진다고 가정하거나 요구할 때 '클래스-전용 프로토콜' 을 사용합니다. 참조와 값 '의미 구조 (semantics)' 에 대한 더 많은 내용은, [Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#structures-and-enumerations-are-value-types-구조체와-열거체는-값-타입입니다) 부분과 [Classes Are Reference Types (클래스는 참조 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#classes-are-reference-types-클래스는-참조-타입입니다) 부분을 참고하기 바랍니다.

### Protocol Composition (프로토콜 합성)

타입이 동시에 여러 개의 프로토콜을 준수하도록 요구하는 것이 유용할 수 있습니다. 여러 개의 프로토콜은 _프로토콜 합성 (protocol composition)_ 을 써서 '단일 필수 조건' 으로 조합할 수 있습니다. '프로토콜 합성' 은 마치 모든 프로토콜의 '조합된 필수 조건' 들을 '합성' 해서 가진 '임시 지역 프로토콜' 을 정의한 것처럼 작동합니다. '프로토콜 합성' 은 어떤 새로운 프로토콜 타입도 정의하지 않습니다.

'프로토콜 합성' 은 `SomeProtocol & AnotherProtocol` 과 같은 형식을 가집니다. 필요한 만큼 많은 개수의 프로토콜을, '앤드 기호 (ampersands; `&`)' 로 구분하여, 나열할 수 있습니다. 이 '프로토콜 목록' 에 더하여, '프로토콜 합성' 은, '필수 (required) 상위 클래스' 지정에 사용할 수 있는, 클래스 타입도 하나 담을 수 있습니다.

다음은 `Named` 와 `Aged` 라는 두 프로토콜을 '함수 매개 변수' 에 대한 '단일 프로토콜 합성 필수 조건' 으로 조합하는 예제입니다:

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
// "Happy birthday, Malcolm, you're 21!" 를 인쇄합니다.
```

이 예제에서, `Named` 프로토콜은 `name` 이라는 '획득 가능한 `String` 속성' 에 대한 '단일 필수 조건' 을 가집니다. `Aged` 프로토콜은 `age` 라는 '획득 가능한 `Int` 속성' 에 대한 '단일 필수 조건' 을 가집니다. 두 프로토콜 모두 `Person` 이라는 구조체가 채택합니다.

이 예제는 `wishHappyBirthday(to:)` 함수도 정의하고 있습니다. '`celebrator` 매개 변수' 의 타입은, "`Named` 와 `Aged` 프로토콜을 둘 다 준수하는 어떤 타입" 을 의미하는, `Named & Aged` 입니다. 두 '필수 프로토콜' 을 다 준수하는 한, 함수에 전달되는 특정 타입이 어느 것인지는 중요하지 않습니다.

그런 다음 이 예제는 `birthdayPerson` 이라는 새로운 `Person` 인스턴스를 생성하고 이 새로운 인스턴스를 `wishHappyBirthday(to:)` 함수에 전달합니다. `Person` 이 두 프로토콜을 다 준수하기 때문에, 이 호출은 유효해서, `wishHappyBirthday(to:)` 함수가 '생일 인사말' 을 인쇄할 수 있습니다.

다음은 이전 예제의 '`Named` 프로토콜' 을 '`Location` 클래스' 와 조합하는 예제입니다:

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
// "Hello, Seattle!" 를 인쇄합니다.
```

`beginConcert(in:)` 함수는, "`Location` 의 하위 클래스이면서 `Named` 프로토콜을 준수하는 어떤 타입" 을 의미하는, `Location & Named` 타입의 매개 변수를 취합니다. 이 경우, `City` 는 두 필수 조건을 다 만족합니다.

`birthdayPerson` 을 `beginConcert(in:)` 함수에 전달하는 것은 '무효 (invalid)' 인데 이는 `Person` 이 `Location` 의 하위 클래스가 아니기 때문입니다. 마찬가지로, `Named` 프로토콜을 준수하지 않는 `Location` 의 하위 클래스를 만들고서, 해당 타입의 인스턴스로 `beginConcert(in:)` 를 호출하는 것 역시 '무효' 입니다.

### Checking for Protocol Conformance (프로토콜 준수성 검사하기)

프로토콜을 준수하는지 검사해서, 특정한 프로토콜로 '변환 (cast)' 하기 위해, [Type Casting (타입 변환)]({% post_url 2020-04-01-Type-Casting %}) 에서 설명한 `is` 와 `as` 연산자를 사용할 수 있습니다. '프로토콜 검사 및 변환' 은 '타입 검사 및 변환' 과 정확하게 똑같은 구문을 사용합니다:

* `is` 연산자는 인스턴스가 프로토콜을 준수할 경우 `true` 를 반환하고 그렇지 않으면 `false` 를 반환합니다.
* `as?` 버전의 '내림 변환 (downcast) 연산자' 는 '프로토콜 타입' 에 대한 '옵셔널 값' 을 반환하는데, 인스턴스가 해당 프로토콜을 준수하지 않을 경우 이 값은 `nil` 입니다.
* `as!` 버전의 '내림 변환 연산자' 는 '프로토콜 타입' 으로 강제로 내림 변환을 하며 '내림 변환' 을 성공하지 못하면 '실행 시간 에러' 를 발생시킵니다.

다음 예제는 `area` 라는 '획득 가능한 `Double` 속성' 의 '단일 속성 필수 조건' 을 가진, `HasArea` 라는 프로토콜을 정의합니다:

```swift
protocol HasArea {
  var area: Double { get }
}
```

다음은, 둘 다 `HasArea` 프로토콜을 준수하는, `Circle` 과 `Country` 라는, 두 클래스입니다:

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

`Circle` 클래스는, `radius` 라는 저장 속성을 기초로, `area` 속성 필수 조건을 계산 속성으로 구현합니다. `Country` 클래스는 `area` 필수 조건을 저장 속성으로 직접 구현합니다. 두 클래스 모두 다 올바르게 `HasArea` 프로토콜을 준수합니다.

다음은, `HasArea` 프로토콜을 준수하지 않는, `Animal` 이라는 클래스입니다:

```swift
class Animal {
  var legs: Int
  init(legs: Int) { self.legs = legs }
}
```

`Circle`, `Country`, 그리고 `Animal` 클래스는 서로 공유하는 '기초 (base) 클래스'[^base-class] 가 없습니다. 그럼에도 불구하고, 모두 클래스이므로, `AnyObject` 타입인 값을 저장하는 배열의 초기화에 세 타입의 인스턴스 모두 사용 가능합니다:

```swift
let objects: [AnyObject] = [
  Circle(radius: 2.0),
  Country(area: 243_610),
  Animal(legs: 4)
]
```

`objects` 배열은 반지름이 '2' 인 `Circle` 인스턴스와; 제곱 킬로미터 단위의 영국 면적으로 초기화된 `Country` 인스턴스; 그리고 다리가 네 개인 `Animal` 인스턴스, 를 담은 '배열 글자 값 (literal)' 으로 초기화 됩니다.

이제 `objects` 배열을 반복하여, 배열에 있는 각각의 객체가 `HasArea` 프로토콜을 준수하고 있는지 확인하는 검사를 할 수 있습니다:

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

배열에 있는 객체가 `HasArea` 프로토콜을 준수할 때마다, `as?` 연산자가 반환하는 옵셔널 값을 '옵셔널 연결' 로 포장을 풀어 `objectWithArea` 라는 상수에 넣습니다. `objectWithArea` 상수의 타입이 `HasArea` 임을 알고 있으므로, `area` 속성에 '타입-안전 (type-safe)'[^type-safe] 한 방식으로 접근해서 인쇄할 수 있습니다.

'변환 (casting) 과정' 에서 실제 객체는 바뀌지 않는다는 것을 기억하기 바랍니다. 이들은 계속해서 `Circle`, `Country`, 그리고 `Animal` 입니다. 하지만, `objectWithArea` 상수에 저장하는 시점에는, `HasArea` 타입이라는 것만 알고 있으므로, `area` 속성에만 접근할 수 있습니다.

### Optional Protocol Requirements (옵셔널 프로토콜 필수 조건)

프로토콜을 위한 _옵셔널 필수 조건 (optional requirements)_ 을 정의할 수 있습니다. 이 '필수 조건' 들은 프로토콜을 준수하는 타입이 구현하지 않아도 됩니다. '옵셔널 필수 조건' 은 프로토콜 정의에서 접두사로 '`optional` 수정자' 를 붙입니다. '옵셔널 필수 조건' 은 '오브젝티브-C' 와 상호 호환되는 코드를 작성하기 위하여 사용 가능합니다. '프로토콜' 과 '옵셔널 필수 조건' 은 둘 다 반드시 '`@objc` 특성 (attribute)'[^attribute] 으로 표시해야 합니다. 오브젝티브-C 클래스나 다른 `@objc` 클래스를 상속한 클래스 만이 '`@objc` 프로토콜' 을 채택할 수 있다는 것을 기억하기 바랍니다. 구조체나 열거체가 이를 채택할 순 없습니다.

'옵셔널 필수 조건' 에서 메소드나 속성을 사용할 때, 그 타입은 자동으로 '옵셔널' 이 됩니다. 예를 들어, `(Int) -> String` 타입의 메소드는 `((Int) -> String)?` 이 됩니다. 메소드 반환 값이 아니라, '전체 함수 타입' 을 옵셔널로 포장한다는 것을 기억하기 바랍니다.

'옵셔널 프로토콜 필수 조건' 은, 프로토콜을 준수하는 타입이 필수 조건을 구현하지 않을 가능성을 밝히기 위해, '옵셔널 연쇄' 를 가지고 호출할 수 있습니다. '옵셔널 메소드' 를 구현했는 지는 호출할 때, `someOptionalMethod?(someArgument)` 같이, 메소드 이름 뒤에 물음표를 작성하여 검사합니다. '옵셔널 연쇄' 에 대한 정보는, [Optional Chaining (옵셔널 사슬)]({% post_url 2020-06-17-Optional-Chaining %}) 장을 참고하기 바랍니다.

다음 예제는, 증가량을 제공하고자 외부 데이터 소스를 사용하는, `Counter` 라는 '정수를-세는' 클래스를 정의합니다. 이 데이터 소스는, 두 개의 '옵셔널 필수 조건' 을 가진, '`CounterDataSource` 프로토콜' 에서 정의합니다:

```swift
@objc protocol CounterDataSource {
  @objc optional func increment(forCount count: Int) -> Int
  @objc optional var fixedIncrement: Int { get }
}
```

`CounterDataSource` 프로토콜은 `incremental(forCount:)` 라는 '옵셔널 메소드 필수 조건' 과 `fixedIncrement` 라는 '옵셔널 속성 필수 조건' 을 정의합니다. 이 필수 조건들은 데이터 소스가 `Count` 인스턴스에 적절한 증가량을 제공하기 위한 서로 다른 두 방식을 정의합니다.

> 엄밀하게 말해서, `CounterDataSource` 프로토콜을 준수하면서 _어느 (either)_ 프로토콜 필수 조건도 구현하지 않는 '사용자 정의 클래스' 를 작성할 수 있습니다. 결국 어째 됐든, 둘 다 '옵셔널' 입니다. 비록 기술적으론 허용될지라도, 이는 아주 좋은 데이터 소스이진 않을 것입니다.

아래에서 정의한, `Counter` 클래스는, `CounterDataSource?` 타입의 '옵셔널 `dataSource` 속성' 을 가집니다:

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

`Counter` 클래스는 현재 값을 `count` 라는 변수 속성에 저장합니다. `Counter` 클래스는, 매 번 메소드를 호출할 때마다 `count` 속성을 증가시키는, `increment` 라는 메소드도 정의합니다.

`increment()` 메소드는 증가량을 가져오기 위해 먼저 데이터 소스에 대한 `incremental(forCount:)` 메소드가 구현됐는 지를 찾으려 합니다. `increment()` 메소드는 `increment(forCount:)` 호출을 시도하기 위해 '옵셔널 연쇄' 를 사용하며, 메소드의 단일 인자로 현재의 `count` 값을 전달합니다.

여기서 _두 (two)_ 단계 수준의 '옵셔널 연쇄' 가 진행된 것을 기억하기 바랍니다. 첫 번째로, `dataSource` 가 `nil` 일 가능성이 있으므로, `dataSource` 가 `nil` 이 아닐 때만 `incremental(forCount:)` 가 호출돼야 함을 지시하도록 `dataSource` 는 이름 뒤에 물음표를 가집니다. 두 번째로, `dataSource` 가 존재 _할 (does)_ 지라도, 옵셔널 필수 조건이기 때문에, `increment(forCount:)` 를 구현한다는 보증이 없습니다. 여기서는, `increment(forCount:)` 를 구현하지 않았을 가능성도 '옵셔널 연쇄' 로 처리합니다. `increment(forCount:)` 호출은 `increment(forCount:)` 가 존재-즉, `nil` 이 아닌 경우-에만 발생합니다. 이것이 `incremental(forCount:)` 도 이름 뒤에 물음표를 작성한 이유입니다.

`increment(forCount:)` 호출은 이 두 이유 중 어느 것으로든 실패할 수 있기 때문에, '_옵셔널 (optional)_ `Int` 값' 을 반환합니다. 이는 `increment(forCount:)` 가 `CounterDataSource` 정의에서 '옵셔널-아닌 `Int` 값' 을 반환하는 것으로 정의할 지라도 그렇습니다. 두 '옵셔널 사슬' 연산이, 차례 차례, 있을지라도, 결과는 여전히 '단일 옵셔널' 로 '포장 (wrapped)' 됩니다. '여러 옵셔널 사슬 연산' 의 사용에 대한 더 많은 정보는, [Linking Multiple Levels of Chaining (여러 수준의 사슬 연결하기)]({% post_url 2020-06-17-Optional-Chaining %}#linking-multiple-levels-of-chaining-여러-수준의-사슬-연결하기) 를 참고하기 바랍니다.

`increment(forCount:)` 를 호출 한 후, '옵셔널 연결' 을 사용하여, 반환한 '옵셔널 `Int`' 의 포장을 풀고 `amount` 라는 상수에 넣습니다. 옵셔널 `Int` 가 값을 담고 있는 경우-즉, '대리자' 와 메소드가 둘 다 존재하며, 메소드가 값을 반환한 경우-포장을 푼 `amount` 가 `count` 저장 속성에 추가되고, '증가' 를 완료합니다.

`increment(forCount:)` 메소드에서 값을 가져오는 것이 가능하지 _않은 (not)_ 경우-`dataSource` 가 `nil` 이기 때문이거나, 또는 데이터 소스가 `increment(forCount:)` 를 구현하지 않은 때문인 경우-라면 그 때는 `increment()` 메소드가 데이터 소스의 `fixedIncrement` 속성에서 대신 값을 가져오려고 합니다. `fixedIncrement` 속성도 '옵셔널 필수 조건' 이므로, `fixedIncrement` 가 `CounterDataSource` 프로토콜 정의에서 '옵셔널-아닌 `Int` 속성' 으로 정의되어 있을지라도, 값은 '옵셔널 `Int`' 입니다.

다음은 조회할 때마다 데이터 소스가 `3` 이라는 상수 값을 반환하는 단순힌 `CounterDataSource` 의 구현입니다. 이는 '옵셔널 `fixedIncrement` 속성 필수 조건' 을 구현함으로써 이를 수행합니다:

```swift
class ThreeSource: NSObject, CounterDataSource {
  let fixedIncrement = 3
}
```

`ThreeSource` 의 인스턴스를 새로운 `Counter` 인스턴스를 위한 데이터 소스로 사용할 수 있습니다:

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

위 코드는 새로운 `Counter` 인스턴스를 생성하여; 데이터 소스로 새로운 `ThreeSource` 인스턴스를 설정하며; '측정기 (counter)' 의 `increment()` 메소드를 네 번 호출합니다. 예상한 것처럼, 측정기의 `count` 속성은 `increment()` 를 호출할 때마다 '3' 만큼 증가합니다.

다음은, `Counter` 인스턴스를 현재 `count` 값에서 '0' 으로 '위로 세거나 (count up)' '아래로 세는 (count down)', `TowardsZeroSource` 라는 좀 더 복잡한 데이터 소스입니다:

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

`TowardsZeroSource` 클래스는 `CounterDataSource` 프로토콜에 있는 '옵셔널 `increment(forCount:)` 메소드' 를 구현하며 어느 방향으로 '셀 (count in)' 지를 알아내기 위해 `count` 인자 값을 사용합니다. `count` 가 이미 '0' 이면, 더 이상 세지 말아야 함을 지시하기 위해 메소드가 `0` 을 반환합니다.

`-4` 에서 '0' 까지 세기 위해 기존 `Counter` 인스턴스와 `TowardsZeroSource` 의 인스턴스를 같이 사용할 수 있습니다. '측정기' 가 '0' 에 닿으면, 더 이상 세지 않습니다:

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

프로토콜은 메소드, 초기자, 첨자 연산, 그리고 계산 속성 구현을 제공하도록 '준수 타입' 을 확장할 수 있습니다. 이는, 각 타입의 개별적인 준수나 전역 함수에서 보다는, 프로토콜 스스로에 대한 작동 방식을 정의하도록 허용합니다.

예를 들어, `RandomNumberGenerator` 프로토콜은, '필수 `random()` 메소드' 의 결과를 사용하여 '`Bool` 난수 값' 을 반환하는, '`randomBool()` 메소드' 를 제공하도록 확장할 수 있습니다:

```swift
extension RandomNumberGenerator {
  func randomBool() -> Bool {
    return random() > 0.5
  }
}
```

프로토콜에 대한 '익스텐션' 을 생성함으로써, 모든 준수 타입은 어떤 추가적인 수정 없이도 이 메소드 구현을 자동으로 가지게 됩니다:

```swift
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// "Here's a random number: 0.3746499199817101" 를 인쇄합니다.
print("And here's a random Boolean: \(generator.randomBool())")
// "And here's a random Boolean: true" 를 인쇄합니다.
```

'프로토콜 익스텐션' 은 준수 타입에 구현을 추가할 순 있지만 프로토콜을 확장하도록 만들거나[^protocol-extend] 다른 프로토콜을 상속하게 할 수는 없습니다. '프로토콜 상속' 은 항상 프로토콜 선언 그 자체에서 지정합니다.

#### Providing Default Implementations (기본 구현 제공하기)

'프로토콜 익스텐션' 은 해당 프로토콜의 메소드 또는 계산 속성 '필수 조건' 에 '기본 구현' 을 제공하기 위해 사용할 수 있습니다. '준수 타입' 이 '필수 메소드' 나 '필수 속성' 에 대한 자신만의 구현을 제공할 경우, 해당 구현을 '익스텐션' 에서 제공하는 것 대신 사용할 것입니다.

> '익스텐션' 이 제공하는 '기본 구현' 을 가진 '프로토콜 필수 조건' 은 '옵셔널 프로토콜 필수 조건' 과 서로 별개의 것입니다. 비록 어느 쪽이든 준수 타입이 자신만의 구현을 직접 제공하지 않아도 될지라도, '기본 구현' 을 가진 '필수 조건' 은 '옵셔널 연쇄' 없이도 호출할 수 있습니다.

예를 들어, `TextRepresentable` 프로토콜을 상속한, `PrettyTextRepresentable` 프로토콜은, `textualDescription` 속성에 접근한 결과를 단순히 반환하도록 '필수 `prettyTextualDescription` 속성' 의 '기본 구현' 을 제공할 수 있습니다:

```swift
extension PrettyTextRepresentable {
  var prettyTextualDescription: String {
    return textualDescription
  }
}
```

#### Adding Constraints to Protocol Extensions (프로토콜 익스텐션에 구속 조건 추가하기)

'프로토콜 익스텐션' 을 정의할 때, '준수 타입' 에서 '익스텐션' 의 메소드와 속성이 사용 가능해지기 전에 반드시 만족해야 할 '구속 조건 (constraints)' 을 지정할 수 있습니다. 이 '구속 조건' 들은 확장 중인 프로토콜 이름 뒤에 '일반화된 (generic) `where` 절' 을 작성하는 것으로써 작성합니다. '일반화된 `where` 절' 에 대한 더 많은 내용은, [Generic Where Clauses (일반화 'where' 절)]({% post_url 2017-03-16-Generic-Parameters-and-Arguments %}#generic-where-clauses-일반화-where-절) 부분을 참고하기 바랍니다.

예를 들어, 그 원소가 `Equatable` 프로토콜을 준수하는 어떤 '집합체 (collection)' 에 적용할 '`Collection` 프로토콜' 의 '익스텐션' 을 정의할 수 있습니다. '집합체' 의 원소를, 표준 라이브러리의 일부인, `Equatable` 프로토콜로 '구속 (constraining)' 함으로써, 두 원소 사이의 '같음 (equality)' 과 '다름 (inequality)' 을 검사하는데 `==` 와 `!=` 연산자를 사용할 수 있게 됩니다.

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

`allEqual()` 메소드는 '집합체' 의 모든 원소가 같을 때만 `true` 를 반환합니다.

두 정수 배열에서, 하나는 모든 원소가 같고, 다른 하나는 그렇지 않은 경우를, 고려합니다:

```swift
let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]
```

'배열' 은 `Collection ` 을 준수하고 '정수' 는 `Equatable` 을 준수하기 때문에, `equalNumbers` 와 `differentNumbers` 는 `allEqual()` 메소드를 사용할 수 있습니다:

```swift
print(equalNumbers.allEqual())
// "true" 를 인쇄합니다.
print(differentNumbers.allEqual())
// "false" 를 인쇄합니다.
```

> '준수 타입' 이 '다중 구속된 익스텐션' 의 '필수 조건' 들을 만족하여 똑같은 메소드나 속성에 대한 (여러) 구현을 제공할 경우, 스위프트는 가장 '특수화된 (specialized) 구속 조건'[^specialized] 과 관련된 구현을 사용합니다.

### 다음 장

[Generics (일반화) > ]({% post_url 2020-02-29-Generics %})

### 참고 자료

[^Protocols]: 원문은 [Protocols](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#) 에서 확인할 수 있습니다.

[^protocol]: '프로토콜 (protocol)' 은 '규약' 이라는 뜻을 가지고 있지만, 스위프트에서는 `protocol` 이라는 '키워드 (keyword)' 로도 사용됩니다. 그러므로, '익스텐션 (extension)' 이나 '클로저 (closure)' 처럼 '키워드' 로 사용될 때는 '프로토콜' 이라고 하고, 의미로 사용될 때는 '규약' 이라고 옮기도록 합니다.

[^requirements]: '필수 조건 (requirements)' 은 어떠한 타입이 프로토콜을 준수하려면 반드시 구현해야 하는 조건들을 말합니다.

[^blueprint]: '청사진 (blueprint)' 은 과거에 '제품 설계 도면' 이라는 의미로 사용하던 단어이며, 이는 설계 도면의 복사 방식이 과거에 파란색을 띄었기 때문입니다. 엑스코드 (Xcode) 아이콘을 보면 검은 망치 밑에 파란색 종이가 깔려 있는 데, 이 파란색 종이가 바로 청사진입니다. '청사진 (blueprint)' 에 대한 더 자세한 정보는, 위키피디아의 [Blueprint](https://en.wikipedia.org/wiki/Blueprint) 항목과 [청사진](https://ko.wikipedia.org/wiki/청사진) 항목을 참고하기 바랍니다.

 [^conforming-types]: '준수 타입 (conforming types)' 은 어떠한 프로토콜의 모든 필수 조건을 만족하는 타입을 말합니다. 모든 필수 조건을 만족한다는 건 모든 필수 조건을 실제로 구현한다는 의미입니다.

[^type-property-requirements]: 즉, 클래스의 '타입 속성 필수 조건 (type property requirements)' 은, `class` 나 `static` 으로 구분할 필요 없이,  무조건 `static` 을 사용하면 됩니다.

[^qualified]: 스위프트에서 '규명하다 (qualify)' 는 자신의 소속을 알린다는 의미입니다.

[^starship]: 이 예제에 있는 클래스 이름이 '우주선 (Starship)' 입니다. 참고로 예제에 있는 `ncc1701` 은 미국 유명 TV 시리즈인 '스타 트랙 (Star Trek)' 에 나오는 주인공 우주선의 제식번호 (registry) 이며, 이 우주선의 정식 이름은 'USS 엔터프라이즈 (USS Enterprise)' 입니다. 이에 대한 더 자세한 정보는, 위키피디아의 [USS Enterprise (NCC-1701)](https://en.wikipedia.org/wiki/USS_Enterprise_(NCC-1701)) 항목과 [USS 엔터프라이즈 (NCC-1701)](https://ko.wikipedia.org/wiki/USS_엔터프라이즈_(NCC-1701)) 항목을 참고하기 바랍니다. 

[^optional]: 우주선에 이름은 반드시 있어야 하지만, '경칭 (prefix)' 같은 건 옵션이므로, 옵셔널 타입으로 구현하고 있습니다.

[^random]: 이는 스위프트 내장 `random` 함수가 `0.0..<1.0` 범위의 값을 반환하기 때문입니다.

[^linear-congruential-generator]: '선형 합동 발생기' 는 널리 알려진 '유사 난수 발생기' 라고 합니다. 다만 '선형 합동 발생기' 는 인자와 마지막으로 생성한 난수를 알면 그 뒤의 모든 난수를 예측할 수 있기 때문에 바람직한 '난수 발생기' 는 아니라고 합니다. 이에 대한 더 자세한 정보는, 위키피디아의 [Linear congruential generator](https://en.wikipedia.org/wiki/Linear_congruential_generator) 와 [선형 합동 생성기](https://ko.wikipedia.org/wiki/선형_합동_생성기) 항목을 참고하기 바랍니다. 참고로 위키피디아에서도 'generator' 를 '생성기' 라고도 하고 '발생기' 라고도 하고 있어서, 여기서는 '발생기' 라고 통일하여 옮깁니다.

[^required]: '수정자 (modifiers)' 는 (선언의) 동작이나 의미를 수정하는 키워드를 의미합니다. 이에 대한 더 자세한 정보는 [Declaration Modifiers (선언 수정자)]({% post_url 2020-08-15-Declarations %}#declaration-modifiers-선언-수정자) 부분을 참고하기 바랍니다. 

[^final]: 하위 클래스를 가지지 않는 최종 클래스는 해당 초기자를 하위 클래스가 필수로 구현해야 한다는 표시를 할 이유가 없습니다.

[^adopt]: 여기서 원문을 보면 '준수 (conforming)' 가 아니라 '채택 (adopt)' 이라는 단어를 사용했습니다. 스위프트 문서를 보면 '준수' 와 '채택' 은 항상 분명하게 구분하여 사용하는 것을 알 수 있습니다. 이 둘의 차이점은 이 문서의 맨 앞에 있는 [Protocols (프로토콜; 규약)](#protocols-프로토콜-규약) 부분을 참고하기 바랍니다.

[^delegate]: 사실 'delegation' 을 '위임' 이라고 한다면, 'delegate' 는 '위임자' 라고 하는 것이 좋겠지만, 일반적으로 'delegation' 은 '위임' 으로 'delegate' 는 '대리자' 라는 번역이 널리 알려져 있습니다. 이것은 원래 'delegation' 자체가 프로그래밍 용어로 사용되기 전부터 일반 용어로 '위임' 이라는 말로 사용되고 있었기 때문으로 추측됩니다. '위임 (delegation)' 에 대한 더 자세한 내용은 위키피디아의 [Delegation pattern](https://en.wikipedia.org/wiki/Delegation_pattern) 항목과, [Proxy pattern](https://en.wikipedia.org/wiki/Proxy_pattern) 항목 및 [프록시 패턴](https://ko.wikipedia.org/wiki/프록시_패턴) 항목을 참고하기 바랍니다.

[^instantiator]: 본문에서는 'instantiator' 라는 용어를 사용하고 있는데, 적당한 말이 없어서 '인스턴스를 만드는 부분' 으로 옮겼습니다. 실제 게임을 구현할 경우 일종의 'game manager' 가 '인스턴스' 를 생성할 텐데, 이 'game manager' 를 'inistantiator' 라고 부를 수 있을 것입니다.

[^gracefully-fail]: 스위프트에서 '우아하게 실패한다 (fail gracefully)' 는 말은 '실행-시간 에러' 가 발생하지 않는다는 것을 의미합니다. 보다 자세한 정보는 [Optional Chaining (옵셔널 사슬)]({% post_url 2020-06-17-Optional-Chaining %}) 장의 맨 앞부분 설명을 참고하기 바랍니다.

[^snakes-and-ladders-instance]: `SnakesAndLadders` 인스턴스를 `self` 라는 키워드를 사용하여 전달하고 있습니다.

[^array-element]: 즉, 본문 예제에서 `Array` 가 `TextRepresentable` 을 준수하는 조건은 `Array` 의 `Element` 가 `TextRepresentable` 을 준수할 때입니다.

[^adoption]: 이것이 스위프트에서 '채택 (adoption)' 이란 말과 '준수 (conformance)' 라는 말을 명확하게 구분해서 사용하는 이유일 것입니다.

[^synthesized]: 본문에서 말하는 '통합된 구현 (synthesized implementation)' 은 이미 스위프트 내부에서 구현되어 있다는 의미입니다. 즉, '`Equatable` 프로토콜' 같은 것은 스위프트 내부에 이미 구현되어 있는 것을 사용하기만 하면 됩니다.

[^associated-types]: 여기서 말하는 '결합 타입 (associated types)' 이라는 것은 열거체에 있는 '결합 값 (associated values) 의 타입' 을 의미합니다. 열거체의 '결합 값' 에 대한 더 자세한 정보는, [Enumerations (열거체)]({% post_url 2020-06-13-Enumerations %}) 장의 [Associated Values (결합 값)]({% post_url 2020-06-13-Enumerations %}#associated-values-결합-값) 부분을 참고하기 바랍니다. 일반적인 의미에서의 '결합 타입' 에 대해서는 [Generics (일반화)]({% post_url 2020-02-29-Generics %}) 장의 [Associated Types (결합 타입)]({% post_url 2020-02-29-Generics %}#associated-types-결합-타입) 부분도 참고하기 바랍니다.

[^equivalence]: '같음 비교 (equivalence)' 는 수학에서 말하는 '동치' 와 같은 개념입니다. 'equivalence operators' 는 우리말로 '동등 연산자', '동치 연산자', '같음 연산자' 등으로 옮길 수 있을텐데, 위키피디아에서 'equal to' 를 '같음' 으로 번역하고 있기 때문에, 여기서는 '같음 비교' 라는 말로 옮기도록 합니다. '관계 연산자' 들의 용어에 대해서는 위키피디아의 [Relational operator](https://en.wikipedia.org/wiki/Relational_operator) 항목과 [관계 연산자](https://ko.wikipedia.org/wiki/관계연산자) 항목을 참고하기 바랍니다.

[^raw-values]: '원시 값 (raw values)' 에 대한 더 자세한 정보는, [Enumerations (열거체)]({% post_url 2020-06-13-Enumerations %}) 장에 있는 [Raw Values (원시 값)]({% post_url 2020-06-13-Enumerations %}#raw-values-원시-값) 부분을 참고하기 바랍니다.

[^remaining-comparison-operators]: 스위프트의 '통합된 구현' 을 사용하면 `<` 연산자 외에도, '기본 구현' 된 `<=`, `>`, `>=` 연산자들을 부여 받는데, 나머지 연산자들은 이 '기본 구현' 을 통해서 구현한다는 의미입니다. 즉, `<` 연산자에 대한 '통합된 구현' 만 부여 받을 수 있다면, 어떤 연산자도 구현할 필요가 없다는 의미입니다.

[^multiple-inherited-protocols]: 스위프트에서 클래스는 하나만 상속할 수 있지만, 프로토콜은 여러 개를 준수할 수 있습니다. 스위프트에 있는 '프로토콜의 준수' 라는 개념은 C++ 에 있는 '순수 추상 클래스의 상속' 과 비슷합니다.

[^inheritance]: 여기서 '프로토콜 상속 목록 (protocol's inheritance list)' 이라는 용어를 사용한 것은 프로토콜의 '준수 (conformance)' 라는 개념이 사실상 상속과도 같은 개념이기 때문입니다.

[^base-class]: 스위프트에서 '기초 클래스 (base class)' 는 '클래스 계층 구조' 에서 최상단에 위치하는, 혹은 위치할 수 있는, 클래스를 말합니다. 기초 클래스에 대한 더 자세한 정보는, [Inheritance (상속)]({% post_url 2020-03-31-Inheritance %}) 장에 있는 [Defining a Base Class (기초 클래스 정의하기)]({% post_url 2020-03-31-Inheritance %}#defining-a-base-class-기초-클래스-정의하기) 부분을 참고하기 바랍니다.

[^type-safe]: '타입-안전한 방식 (type-safe way)' 은 스위프트에서 기본적으로 제공하는 '타입 추론 (type inference)' 과 '타입 검사 (type check)' 기능을 사용할 수 있다는 의미입니다. '타입 추론' 과 '타입 검사' 에 대한 더 자세한 정보는, [The Basics (기초)]({% post_url 2016-04-24-The-Basics %}) 장에 있는 [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)]({% post_url 2016-04-24-The-Basics %}#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 부분을 참고하기 바랍니다.

[^attribute]: 스위프트에서 '특성 (attribute)' 은 선언이나 타입에 추가적인 정보를 부여하는 도구입니다. '특성' 에 대한 더 자세한 정보는, [Attributes (특성)]({% post_url 2020-08-14-Attributes %}) 장을 참고하기 바랍니다.

[^protocol-extend]: '익스텐션 (extension)' 자체가 '확장' 이란 의미인데, '프로토콜 익스텐션' 으로 '프로토콜' 을 '확장' 할 수 없다라는 말이 이해가 안될 수도 있습니다. 여기서 말하는 '프로토콜을 확장할 수 없다' 라는 의미는 '프로토콜에 새로운 필수 조건들을 추가할 수 없다' 라는 의미입니다. '프로토콜 익스텐션' 은 프로토콜에 새로운 '필수 조건' 들을 추가하는 것이 아니라, 기존의 '필수 조건' 들에 '기본 구현' 을 제공하거나 새로운 '기능' 들을 추가하기 위해 사용하는 것입니다.

[^specialized]: '가장 특수화된 구속 조건 (the most specialized constraints)' 은 '구속 조건' 들 중에서 적용되는 범위가 가장 좁은 것을 말합니다. '가장 특수화된 구속 조건' 에 대한 더 자세한 내용은, 애플 'Developer Forums' 에 있는 [What does "most specialized constraints" mean?](https://forums.developer.apple.com/thread/70845) 항목을 참고하기 바랍니다.
