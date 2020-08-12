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

프로토콜은 준수 타입이 특정 이름과 타입을 가진 인스턴스 속성 또는 타입 속성을 제공하도록 하는 필수 조건을 만들 수 있습니다. 프로토콜은 이 속성이 저장 속성인지 계산 속성인지는 지정하지 않습니다-필수적인 속성 이름과 타입만을 지정합니다. 프로토콜은 또 각 속성이 반드시 '획득 가능 (gettable)' 한지 아니면 반드시 '획득 가능 (gettable)' _하면서 (and)_ '설정 가능 (settable)' 하기도 해야 하는 지를 지정합니다.

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

다음 예제의 프로토콜은 단일한 인스턴스 속성 필수 조건을 가지고 있습니다:

```swift
protocol FullyNamed {
  var fullName: String { get }
}
```

`FullyNamed` 프로토콜은 준수 타입이 조건에 맞는 전체 이름을 제공하기를 필수로 요구합니다. 이 프로토콜은 준수 타입의 본질에 대하여 어떤 다른 것도 지정하지 않습니다-오직 타입이 반드시 스스로 전체 이름을 제공할 수 있어야 한다는 것만 지정합니다. 이 프로토콜은 어떤 `FullyNamed` 타입이든, 타입이 `String` 인, `fullName` 이라는 획득 가능한 인스턴스 속성을 반드시 가져야 한다고 알립니다.

다음은 `FullyNamed` 프로토콜을 채택하고 준수하는 단순한 구조체에 대한 예제입니다:

```swift
struct Person: FullyNamed {
  var fullName: String
}
let john = Person(fullName: "John Appleseed")
// john.fullName 은 "John Appleseed" 입니다.
```

이 예제는, 이름이 지정된 사람을 나타내는, `Person` 이라는 구조체를 정의합니다. 이는 정의 첫 줄에서 자신이 `FullyNamed` 프로토콜을 채택하고 있음을 알립니다.

`Person` 의 각 인스턴스는, 타입이 `String` 인, `fullName` 이라는 단일한 저장 속성을 가집니다. 이는 `FullyNamed` 프로토콜의 단일한 필수 조건과 들어 맞으며, `Person` 이 프로토콜을 올바르게 준수하고 있음을 의미하게 됩니다. (스위프트는 프로토콜의 필수 조건이 충족되지 않으면 컴파일-시간 에러를 보고합니다.)

다음은, 역시 `FullyNamed` 프로토콜을 채택하고 준수하는, 좀 더 복잡한 클래스입니다:

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
// ncc1701.fullName 은 "USS Enterprise" 입니다.
```

이 클래스는 `fullName` 속성 필수 조건을 우주선에 대한 읽기-전용 계산 속성으로 구현합니다. 각 `Starship` 클래스 인스턴스는 의무적인 `name` 과 선택적인[^optional] `prefix` 를 저장합니다. `fullName` 속성은 `prefix` 값이 있다면 이것도, `name` 앞에 추가하여 우주선에 대한 전체 이름을 생성합니다.

### Method Requirements (메소드 필수 조건)

프로토콜은 지정한 인스턴스 메소드와 타입 메소드를 준수 타입이 필수로 구현하도록 요구할 수 있습니다. 이러한 메소드를 프로토콜 정의 부분에 작성하는 방법은 일반적인 인스턴스 및 타입 메소드와 정확하게 똑같지만, 중괄호 또는 메소드 본문이 없습니다. 가변 매개 변수도, 일반직인 메소드에서와 같은 규칙을 따른다는 전제하에, 허용합니다. 메소드 매개 변수에 기본 설정 값을 지정하는 것은, 하지만, 프로토콜 정의 내에서 할 수 없습니다.

타입 속성 필수 조건에서와 같이, 타입 메소드 필수 조건을 프로토콜에서 정의할 때는 `static` 키워드를 항상 접두사로 붙여야 합니다. 이는 타입 메소드 필수 조건을 클래스가 `static` 이나 `class` 를 써서 구현하게 되더라도 마찬가지입니다.

```swift
protocol SomeProtocol {
  static func someTypeMethod()
}
```

다음 예제는 단일한 인스턴스 메소드 필수 조건을 가진 프로토콜을 정의합니다:

```swift
protocol RandomNumberGenerator {
  func random() -> Double
}
```

이 프로토콜인, `RandomNumberGenerator` 는, 어떤 준수 타입이라도, 호출할 때마다 `Double` 값을 반환하는, `random` 이라는 인스턴스 메소드를 필수로 가질 것을 요구합니다. 비록 프로토콜 부분에서 지정되지 않았더라도, 이 값은 `0.0` 에서 (포함은 안되지만) `1.0` 에 이르는 수라고 가정합니다.

`RandomNumberGenerator` 프로토콜은 각각의 '난수 (random number)' 를 생성하는 방법에 대해서는 어떤 가정도 하지 않습니다-단순히 '생성기 (generator)' 가 새로운 난수를 생성하는 표준적인 방법을 필수로 제공하도록 요구할 뿐입니다.

다음은 `RandomNumberGenerator` 프로토콜을 채택하고 준수하는 클래스에 대한 구현입니다. 이 클래스는 _선형 합동 생성기 (linear congruential generator)_[^linear-congruential-generator] 라는 '의사-난수 생성기 (pseudorandom number)' 알고리즘을 구현합니다.

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
// "Here's a random number: 0.3746499199817101" 를 출력합니다.
print("And another one: \(generator.random())")
// "And another one: 0.729023776863283" 를 출력합니다.
```

### Mutating Method Requirements (변경 메소드 필수 조건)

때때로 메소드는 자신이 속해 있는 인스턴스를 수정-또는 _변경 (mutate)_-할 필요가 있습니다. 값 타입 (즉, 구조체와 열거체) 의 인스턴스 메소드에서 `mutating` 키워드를 메소드의 `func` 키워드 앞에 붙이면 이 메소드가 자신이 속한 인스턴스 및 해당 인스턴스의 모든 속성을 수정할 수 있음을 지시하는 것입니다. 이 과정은 [Modifying Value Types from Within Instance Methods (인스턴스 메소드에서 값 타입 수정하기)]({% post_url 2020-05-03-Methods %}#modifying-value-types-from-within-instance-methods-인스턴스-메소드에서-값-타입-수정하기) 에서 설명했습니다.

프로토콜을 채택하는 어떤 타입에 대해서든 인스턴스를 변경하려는 의도를 가진 '프로토콜 인스턴스 메소드 필수 조건 (protocol instance method requirements)' 을 정의하는 경우, 프로토콜을 정의할 때 이 메소드에 `mutating` 키워드를 표시하도록 합니다. 이는 구조체와 열거체가 이 프로토콜을 채택하고 해당 메소드 필수 조건을 만족할 수 있게 해줍니다.

> 프로토콜 인스턴스 메소드 필수 조건을 `mutating` 으로 표시한 경우, 해당 메소드의 구현을 클래스에서 작성할 때 `mutating` 키워드를 붙일 필요가 없습니다. `mutating` 키워드는 구조체와 열거체에서만 사용되는 것입니다.

아래 예제는, `toggle` 이라는 단일한 인스턴스 메소드 필수 조건을 정의하는, `Togglable` 이라는 프로토콜을 정의합니다. 이름으로 알 수 있듯이, `toggle()` 메소드는 어떤 준수 타입이든, 해당 타입의 속성을 수정하는 것으로써, 타입의 상태를 전환하거나 반전합니다.

`toggle()` 메소드는, 이 메소드를 호출할 때 준수 인스턴스의 상태를 변경하기를 지시하고자, `Togglable` 프로토콜 정의 부분에서 `mutating` 키워드로 표시했습니다:

```swift
protocol Togglable {
  mutating func toggle()
}
```

`Togglable` 프로토콜을 구조체나 열거체에서 구현하는 경우, `mutating` 으로 표시된 `toggle()` 메소드 구현을 제공하면 해당 구조체나 열거체가 이 프로토콜을 준수할 수 있습니다.

아래 예제는 `OnOffSwitch` 라는 열거체를 정의합니다. 이 열거체는, 열거체의 case 값 `on` 과 `off` 로 나타내는, 두 상태 사이를 왔다갔다 합니다. 이 열거체의 `toggle` 구현은, `Togglable` 프로토콜의 필수 조건에 들어 맞도록, `mutating` 으로 표시합니다:

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
// lightSwitch 는 이제 .on 입니다.
```

### Initializer Requirements (초기자 필수 조건)

프로토콜은 지정한 초기자를 준수 타입이 필수로 구현하도록 요구할 수 있습니다. 이러한 초기자를 프로토콜 정의 부분에 작성하는 방법은 일반적인 초기자와 정확하게 똑같지만, 중괄호 또는 초기자 본문은 없습니다:

```swift
protocol SomeProtocol {
  init(someParameter: Int)
}
```

#### Class Implementation of Protocol Initializer Requirements (프로토콜 초기자 필수 조건을 클래스에서 구현하기)

프로토콜 초기자 필수 조건을 준수 클래스에서 구현할 때는 지명 초기자로 해도 되고 편의 초기자로 해도 됩니다. 두 가지 경우 모두, 초기자 구현시 반드시 `required` 수정자를 표시해야 합니다:

```swift
class SomeClass: SomeProtocol {
  required init(someParameter: Int) {
    // 여기서 초기자를 구현합니다.
  }
}
```

`required` 수정자를 사용하면 준수 클래스의 모든 하위 클래스에 대해서 명시적으로든 또는 상속을 받아서든 초기자 필수 조건의 구현을 제공한다는 것을 보장해서, 하위 클래스에서도 이 프로토콜을 준수하도록 합니다.

필수 초기자에 대한 더 자세한 정보는, [Required Initializers (필수 초기자)]({% post_url 2016-01-23-Initialization %}#required-initializers-필수-초기자) 를 참고하기 바랍니다.

> `final` 수정자로 표시한 클래스에서는 프로토콜 초기자 필수 조건을 `required` 수정자로 표시할 필요가 없는데, '최종 클래스 (final class)' 는 하위 클래스를 가지지 않기 때문입니다. `final` 수정자에 대해서는, [Preventing Overrides (재정의 막기)]({% post_url 2016-01-23-Initialization %}#preventing-overrides-재정의-막기) 를 참고하기 바랍니다.

만약 하위 클래스가 상위 클래스의 지명 초기자를 재정의하면서, 프로토콜의 초기자 필수 조건에 해당하는 것도 같이 구현하는 경우라면, 해당 초기자의 구현에는 `required` 와 `override` 수정자 둘 다 표시하도록 합니다:

```swift
protocol SomeProtocol {
  init()
}

class SomeSuperClass {
  init() {
    // 여기서 초기자를 구현합니다.
  }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
  // "required" 는 SomeProtocol 을 준수하기 위함이고; "override" 는 SomeSuperClass 를 준수하기 위함입니다.
  required override init() {
    // 여기서 초기자를 구현합니다.
  }
}
```

#### Failable Initializer Requirements (실패 가능한 초기자 필수 조건)

프로토콜은, [Failable Initializers (실패 가능한 초기자)]({% post_url 2016-01-23-Initialization %}#failable-initializers-실패-가능한-초기자) 에서 정의한 것과 같이, 준수 타입에 대한 '실패 가능한 초기자 필수 조건' 을 정의할 수 있습니다.

실패 가능한 초기자 필수 조건은 준수 타입에서 '실패 가능한 초기자' 또는 '실패하지 않는 초기자' 를 써서 만족시킬 수 있습니다. 실패하지 않는 초기자 필수 조건은 '실패하지 않는 초기자' 또는 '암시적으로 포장이 풀리는 실패 가능한 초기자' 를 써서 만족시킬 수 있습니다.

### Protocols as Types (타입으로써의 프로토콜)

프로토콜은 실제로는 어떤 기능도 스스로 구현하지 않습니다. 그럼에도 불구하고, 코드에서 완전히 독립된 타입인 것처럼 사용할 수 있습니다. 프로토콜을 타입으로 사용하는 것을 _실존 타입 (existential type)_ 이라 부르곤 하는데, 이는 "타입 T 는 프로토콜을 준수하는 T 로써 실존한다 (exists)" 는 구절에서 비롯된 것입니다.

프로토콜은, 다음을 포함하여, 다른 타입이 허용되는 많은 곳에서 사용할 수 있습니다:

* 함수, 메소드, 또는 초기자의 매개 변수 타입이나 반환 타입으로
* 상수, 변수, 또는 속성의 타입으로
* 배열, '딕셔너리 (dictionary)', 또는 다른 '컨테이너 (container)' 에 속해 있는 항목의 타입으로

> 프로토콜은 타입이기 때문에, 이름은 (가령 `FullyNamed` 와 `RandomNumberGenerator` 등) 대문자로 시작하여 스위프트에 있는 다른 타입들 (가령 `Int`, `String`, 및 `Double` 등의) 이름과 맞춰지도록 합니다.

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

이 예제는, 보드 게임에 사용될 n-면체 주사위를 나타내는, `Dice` 라는 새 클래스를 정의합니다. `Dice` 인스턴스는, (주사위) 면이 몇 개인지를 나타내는, `sides` 라는 정수 속성을 가지며, '주사위 굴림 값 (dice roll values)' 을 생성하기 위한 '난수 발생기 (random number generator)' 를 제공하는, `generator` 라는 속성을 가지고 있습니다.

`generator` 속성의 타입은 `RandomNumberGenerator` 입니다. 그러므로, `RandomNumberGenerator` 프로토콜을 채택한 _어떤 (any)_ 타입의 인스턴스라도 설정할 수 있습니다.
이 속성에 할당하는 인스턴스는, 인스턴스가 `RandomNumberGenerator` 프로토콜을 반드시 채택[^adopt]해야 한다는 것만 빼면, 다른 건 아무 것도 필요하지 않습니다. 타입이 `RandomNumberGenerator` 이기 때문에, `Dice` 클래스 안의 코드는 해당 프로토콜을 준수하는 모든 '생성기 (generator)' 에 적용되는 방식인 `generator` 하고만 상호 작용합니다. 이는 생성기의 실제 타입에서 정의한 메소드나 속성은 어떤 것도 사용할 수 없다는 것을 의미합니다. 하지만, [Downcasting (내림 변환하기)]({% post_url 2020-04-01-Type-Casting %}#downcasting-내림-변환하기) 에서 설명한 것처럼, 상위 클래스를 하위 클래스로 내림 변환하는 것과 똑같은 방법으로 프로토콜 타입을 실제 타입으로 내림 변환할 수 있습니다.

`Dice` 는, 초기 상태를 설정하기 위한, 초기자도 가지고 있습니다. 이 초기자, 역시 타입이 `RandomNumberGenerator` 인, `generator` 라는 매개 변수를 가집니다. 새로운 `Dice` 인스턴스를 초기화할 때 해당 매개 변수에 어떤 준수 타입의 값이라도 전달 할 수 있습니다.

`Dice` 는, '1' 에서 '주사위-면 개수' 사이의 정수 값을 반환하는, `roll` 이라는, 인스턴스 메소드 하나를 제공합니다. 이 메소드는 생성기의 `random()` 메소드를 호출하여 `0.0` 과 `1.0` 사이의 새로운 난수를 생성하고, 이 난수를 사용하여 올바른 범위의 '주사위 굴림 값' 을 생성합니다. `generator` 가 `RandomNumberGenerator` 를 채택하는 것을 알고 있기 때문에, 호출할 `random()` 메소드가 있음이 보증된 것입니다.

다음은 `LinearCongruentialGenerator` 인스턴스를 난수 생성기로 가지는 6-면체 주사위를 어떻게 `Dice` 클래스로 생성하는 지를 보여줍니다:

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

_위임 (delegation)_ 은 클래스나 구조체가 책임의 일부를 다른 타입의 인스턴스에게로 넘기기-또는 _위임 (delegate)_-할 수 있게 해주는 '디자인 패턴 (design pattern)' 입니다. 이 '디자인 패턴' 은 위임된 책임을 '은닉하는 (encapsulates)' 프로토콜의 정의로 구현하여, ('대리자 (delegate)'[^delegate] 라고 하는) 준수 타입이 위임된 기능을 제공할 것을 보증합니다. 위임은 특정한 동작에 응답하기 위해서, 또는 해당 소스의 실제 타입을 알 필요 없이 외부 소스의 데이터를 조회하기 위해서, 사용할 수 있습니다.

아래 예제는 주사위-기반 보드 게임에서 사용할 두 개의 프로토콜을 정의합니다:

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

`DiceGame` 프로토콜은 주사위와 엮인 어떤 게임이라도 채택할 수 있는 프로토콜 입니다.

`DiceGameDelegate` 프로토콜은 `DiceGame` 의 진행 상황을 추적하기 위해 채택할 수 있습니다. 강한 참조 순환을 막기 위해, 위임은 약한 참조로 선언됩니다. 약한 참조에 대한 정보는, [Strong Reference Cycles Between Class Instances (클래스 인스턴스 사이의 강한 참조 순환)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#strong-reference-cycles-between-class-instances-클래스-인스턴스-사이의-강한-참조-순환) 을 참고하기 바랍니다. 프로토콜을 클래스-전용으로 표시하는 것[^class-only]은 이 장의 뒤에 있는 `SnakesAndLadders` 클래스가 이 위임을 반드시 약한 참조로 사용할 것을 선언하도록 합니다. 클래스-전용 프로토콜을 표시하는 방법은, [Class-Only Protocols (클래스-전용 프로토콜)](#class-only-protocols-클래스-전용-프로토콜) 에서 설명한 것처럼, `AnyObject` 를 상속하는 것입니다.

다음은 원래 [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에서 소개했었던 _뱀과 사다리 (Snakes and Ladders)_ 게임의 새로운 버전입니다. 이 버전은 주사위-굴림으로 `Dice` 인스턴스를 사용하기 위해; `DiceGame` 프로토콜을 채택하도록; 그리고 진행 상황을 `DiceGameDelegate` 에 알리기 위해; 개조된 것입니다:

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

_뱀과 사다리 (Snakes and Ladders)_ 게임 플레이에 대한 설명은, [Break (Break 문)]({% post_url 2020-06-10-Control-Flow %}#break-break-문) 을 참고하기 바랍니다.

이 버전의 게임은, `DiceGame` 프로토콜을 채택한, `SnakesAndLadders` 라는 클래스로 '포장됩니다 (wrapped up)'. 이는 프로토콜을 준수하기 위해 획득 가능한 `dice` 속성과 `play()` 메소드를 제공합니다. (`dice` 속성은 초기화 이후 바뀔 필요가 없기 때문에 상수 속성으로 선언 했으며, 프로토콜은 이것이 반드시 '획득 가능한' 것이기 만을 요구합니다.)

_뱀과 사다리 (Snakes and Ladders)_ 게임 판 설정은 클래스의 `init()` 초기자 내에서 일어납니다. 모든 게임 로직은 프로토콜의 `play` 메소드 속으로 옮겨지며, 여기서 주사위 굴림 값을 제공하는 `dice` 라는 프로토콜의 필수 속성을 사용합니다.

게임을 플레이하기 위해 '대리자 (delegate; 위임)' 가 필수인 것은 아니기 때문에, `delegate` 속성이 _옵셔널 (optional)_ `DiceGameDelegate` 로 정의된 것에 주목하기 바랍니다. 옵셔널 타입이기 때문에, `delegate` 속성은 자동으로 `nil` 이라는 초기 값으로 설정됩니다. 그 이후, '게임 인스턴스를 만드는 부분'[^instantiator] 에서 이 속성에 적절한 '대리자 (delegate)' 를 설정할 기회를 가집니다. `DiceGameDelegate` 프로토콜은 클래스-전용이기 때문에, ''대리자 (delegate)' 를 `weak` 로 선언해야 참조 순환을 막을 수 있습니다.

`DiceGameDelegate` 는 게임의 진행 상황을 추적하기 위한 세 개의 메소드를 제공합니다. 이 세 메소드는 위의 `play()` 메소드 속에 있는 게임 로직으로 편입되어, 새로운 게임이 시작할 때, 새로운 차례 (turn) 를 시작할 때, 또는 게임이 끝날 때 호출합니다.

`delegate` 속성이 _옵셔널 (optional)_ `DiceGameDelegate` 이기 때문에, `play()` 메소드는 '대리자 (delegate)' 에 대한 메소드를 호출할 때마다 '옵셔널 연쇄 (optional chaining)' 를 사용합니다. `delegate` 속성이 'nil' 인 경우, 이 '대리자 (delegate)' 호출은 에러 없이 우아하게 실패합니다. `delegate` 속성이 'nil-이 아닌' 경우, '대리자 메소드 (delegate method)' 를 호출하며, `SnakesAndLadders` 인스턴스를 매개 변수로 전달[^snakes-and-ladders-instance]합니다.

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

`DiceGameTracker` 는 `DiceGameDelegate` 이 필수로 요구하는 세 개의 메소드 모두를 구현합니다. 이 메소드를 사용하여 게임이 가지고 있는 '턴 (turn)' 수를 추적합니다. 게임이 시작되면 `numberOfTurns` 속성을 '0' 으로 재설정하며, 새 턴을 시작할 때마다 증가하고, 게임이 끝났을 때 총 '턴 (turn)' 수를 출력합니다.

위에서 본 `gameDidStart(_:)` 구현은 `game` 매개 변수를 사용하여 플레이하게 될 게임에 대한 일종의 소개 정보를 출력합니다. `game` 매개 변수의 타입은, `SnakesAndLadders`  가 아니라, `DiceGame` 이므로, `gameDidStart(_:)` 는 `DiceGame` 프로토콜 부분에서 구현된 메소드 및 속성에만 접근할 수 있고 사용할 수 있습니다. 하지만, 이 메소드는 '타입 변환 (type casting)' 을 사용하면 여전히 실제 인스턴스의 타입을 조회할 수 있습니다. 이 예제는, 그 이면을 살펴보면 `game` 이 실제로 `SnakesAndLadders` 인스턴스인지 검사해서, 그렇다면 적절한 메시지를 출력합니다.

`gameDidStart(_:)` 메소드는 전달된 `game` 매개 변수의 `dice` 속성에도 접근합니다. `game` 이 `DiceGame` 프로토콜을 준수하고 있음은 알고 있기 때문에, `dice` 속성을 가지고 있음을 보증하고 있으므로, 어떤 종류의 게임을 플레이하고 있는지 상관없이, `gameDidStart(_:)` 메소드는 주사위의 `sides` 속성에 접근해서 이를 출력할 수 있습니다.

다음은 `DiceGameTracker` 를 실제로 사용하는 방법입니다:

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
// The game lasted for 4 turns / 이 게임은 4턴 동안 지속됐습니다.
```

### Adding Protocol Conformance with an Extension (확장으로 프로토콜 준수성 추가하기)

기존 타입을 확장해서 새로운 프로토콜을 채택하고 준수하도록 만들 수 있으며, 이 때 기존 타입에 대한 소스 코드에 접근할 수 없는 경우라도 상관없습니다. '익스텐션 (extensions; 확장)' 은 기존 타입에 새로운 속성, 메소드, 그리고 첨자 연산을 추가할 수 있으며, 따라서 프로토콜이 요구하는 어떤 필수 조건이라도 추가할 수 있습니다. '익스텐션' 에 대한 더 많은 내용은, [Extensions (익스텐션; 확장)]({% post_url 2016-01-19-Extensions %}) 을 참고하기 바랍니다.

> 어떤 타입에서 이미 존재하고 있는 인스턴스는 '익스텐션' 에서 인스턴스의 타입에 '준수성 (conformance)' 이 추가되면 자동으로 해당 프로토콜을 채택하고 춘수하게 됩니다.

예를 들어, `TextRepresentable` 이라는, 이 프로토콜은 '문장 (text)' 으로 표현할 방법을 가지고 있는 어떤 타입이라도 구현할 수 있습니다. 이것은 스스로에 대한 설명일 수도 있고, 현재 상태를 문장으로 나타낸 것일 수도 있습니다:

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

이 '익스텐션 (extension)' 은 마치 `Dice` 가 원래 구현에서 부터 이를 제공한 것과 정확하게 같은 방법으로 새로운 프로토콜을 채택합니다. 이 프로토콜 이름은 타입 이름 뒤에, 콜론으로 구분하여 제공하며, '익스텐션' 의 중괄호 내에서 프로토콜의 모든 필수 조건을 구현합니다.

이제 어떤 `Dice` 인스턴스라도 `TextRepresentable` 처럼 다룰 수 있습니다:

```swift
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)
// "A 12-sided dice" 를 출력합니다.
```

이와 비슷하게, `SnakesAndLadders` 게임 클래스를 확장하여 `TextRepresentable` 프로토콜을 채택하고 준수하도록 만들 수 있습니다:

```swift
extension SnakesAndLadders: TextRepresentable {
  var textualDescription: String {
    return "A game of Snakes and Ladders with \(finalSquare) squares"
  }
}
print(game.textualDescription)
// "A game of Snakes and Ladders with 25 squares" 를 출력합니다.
```

#### Conditionally Conforming to a Protocol (조건에 따라 프로토콜 준수하기)

'일반화된 타입 (generic type; 제네릭 타입)'[^generic-type] 은, 가령 타입의 '일반화된 매개 변수 (generic parameter; 제네릭 매개 변수)'가 그 프로토콜을 준수할 때와 같이, 지정된 조건 하에서만 프로토콜의 필수 조건을 만족할 수도 있습니다. '일반화된 타입 (generic type)' 이 조건에 따라 프로토콜을 준수하도록 만들려면 타입을 확장할 때 '구속 조건 (constraints)' 을 나열하면 됩니다. 이러한 '구속 조건' 을 채택하려는 프로토콜의 이름 뒤에 나열하는 것은 '일반화된 `where` 절 (generic `where` clause)' 을 사용하여 작성합니다. '일반화된 `where` 절' 에 대한 더 자세한 내용은, [Generic Where Clauses (제네릭-일반화된 where 절)]({% post_url 2020-02-29-Generics %}#generic-where-clauses-제네릭-일반화된-where-절) 을 참고하기 바랍니다.

다음의 '익스텐션 (extension)' 은 `TextRepresentable` 을 준수하는 타입의 원소를 저장할 때마다 `Array` 인스턴스가 `TextRepresentable` 프로토콜을 준수하도록 만듭니다.

```swift
extension Array: TextRepresentable where Element: TextRepresentable {
  var textualDescription: String {
    let itemsAsText = self.map { $0.textualDescription }
    return "[" + itemsAsText.joined(separator: ", ") + "]"
  }
}
let myDice = [d6, d12]
print(myDice.textualDescription)
// "[A 6-sided dice, A 12-sided dice]" 를 출력합니다.
```

#### Declaring Protocol Adoption with and Extension (확장으로 프로토콜 채택 선언하기)

만약 타입이 이미 프로토콜의 모든 필수 조건을 준수하고 있지만, 아직 해당 프로토콜을 채택한다고 알리지 않은 경우라면, 비어 있는 '익스텐션 (extension)' 으로 그 프로토콜을 채택하게 만들 수 있습니다:

```swift
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}
```

이제 `TextRepresentable` 이 필수 타입이라고 요구하는 곳에서도 `Hamster` 의 인스턴드를 사용할 수 있습니다:

```swift
let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
// "A hamster named Simon" 를 출력합니다.
```

> 타입은 필수 조건을 만족한다고 해서 자동으로 프로토콜을 채택하는 것이 아닙니다. 그 프로토콜을 채택한다고 반드시 항상 명시적으로 선언해야 합니다.[^adoption]

### Adopting a Protocol Using a Synthesized Implementation (통합된 구현을 사용하여 프로토콜 채택하기)

스위프트는 많은 경우 `Equatable`, `Hashable`, 및 `Comparable` 에 대한 '프로토콜 준수성 (protocol conformance)' 을 자동으로 제공할 수도 있습니다. 이 '통합된 (synthesized)'[^synthesized] 구현을 사용한다는 것은 프로토콜 필수 조건을 직접 구현하기 위해 '획일적인 (bolilerplate)' 코드를 반복해서 작성할 필요가 없다는 것을 의미합니다.

스위프트는 다음과 같은 종류의 사용자 정의 타입에 대해서 `Equatable` 의 '통합된 구현' 을 제공합니다:

* `Equatable` 프로토콜을 준수하는 저장 속성 만을 가지고 있는 구조체
* `Equatable` 프로토콜을 준수하는 '결합된 타입 (associated types)' 만을 가지고 있는 열거체
* '결합된 타입 (associated types)' 을 전혀 가지고 있지 않은 열거체

`==` 의 통합된 구현을 부여 받으려면, `==` 연산자를 직접 구현하지 말고, 원래의 선언을 담고 있는 파일[^original-declaration]에서 `Equatable` 에 대한 '준수성 (conformance)' 을 선언하기 바랍니다. `Equatable` 프로토콜은 `!=` 에 대한 기본 구현을 제공합니다.

아래 예제는, `Vector2D` 구조체와 비슷하게, 3-차원 위치 벡터 `(x, y, z)` 에 대한 `Vector3D` 구조체를 정의합니다. `x`, `y`, 및 `z` 속성은 모두 `Equatable` 타입이므로, `Vector3D` 는 '같음 비교 연산자 (equivalence operators)' 에 대한 통합된 구현을 부여 받습니다.

```swift
struct Vector3D: Equatable {
  var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
  print("These two vectors are also equivalent.")
}
// "These two vectors are also equivalent." 를 출력합니다.
```

스위프트는 다음과 같은 종류의 사용자 정의 타입에 대해서 `Hashable` 의 '통합된 구현' 을 제공합니다:

* `Hashable` 프로토콜을 준수하는 저장 속성 만을 가지고 있는 구조체
* `Hashable` 프로토콜을 준수하는 '결합된 타입 (associated types)' 만을 가지고 있는 열거체
* '결합된 타입 (associated types)' 을 전혀 가지고 있지 않은 열거체

`hash(into:)` 의 통합된 구현을 부여 받으려면, `hash(into:)` 메소드를 직접 구현하지 말고, 원래의 선언을 담고 있는 파일에서 `Hashable` 에 대한 '준수성 (conformance)' 을 선언하기 바랍니다.

스위프트는 '원시 값 (raw value)' 을 가지고 있지 않은 열거체를 위해 `Comparable` 에 대한 '통합된 구현' 을 제공합니다. 만약 열거체가 '결합된 타입' 들을 가진다면, 이들은 반드시 모두 `Comparable` 프로토콜을 준수해야 합니다. `<` 의 통합된 구현을 부여 받으려면, `<` 연산자를 직접 구현하지 말고, 원래의 열거체 선언을 담고 있는 파일에서 `Comparable` 에 대한 '준수성 (conformance)' 을 선언하기 바랍니다. `<=`, `>`, 및 `>=` 에 대한 `Comparable` 프로토콜의 기본 구현은 남아 있는 비교 연산자들을 제공합니다.

아래 예제는 초보자, 중급자, 및 전문가에 대한 'case 값' 을 가지는 `SkillLevel` 열거체를 정의합니다. 전문가는 추가적으로 자신들이 보유한 별의 개수로 등급이 나뉩니다.

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
// "beginner" 를 출력합니다.
// "intermediate" 를 출력합니다.
// "expert(stars: 3)" 를 출력합니다.
// "expert(stars: 5)" 를 출력합니다.
```

### Collections of Protocol Types (프로토콜 타입의 컬렉션)

프로토콜은, [Protocols as Types (타입으로써의 프로토콜)](#protocols-as-types-타입으로써의-프로토콜) 에서 언급한 것처럼, 배열이나 딕셔너리 같은 '컬렉션 (collection; 집합체)' 내에 저장될 타입으로 사용할 수 있습니다. 다음 예제는 `TextRepresentable` (문장으로 표현할 수 있는) 것들에 대한 배열을 생성합니다:

```swift
let things: [TextRepresentable] = [game, d12, simonTheHamster]
```

이제 배열에 있는 항목들에 동작을 반복 적용시켜서, 각 항목에 대한 문장 형태의 설명을 출력할 수 있습니다:

```swift
for thing in things {
  print(thing.textualDescription)
}
// A game of Snakes and Ladders with 25 squares (25개의 정사각형을 가지는 뱀과 사다리 게임)
// A 12-sided dice (12-면체 주사위)
// A hamster named Simon (Simon 이라는 이름의 햄스터)
```

`thing` 상수의 타입은 `TextRepresentable` 임에 주목하기 바랍니다. 타입은 `Dice` 도, `DiceGame` 도, `Hamster` 도 아니며, 비록 그 이면을 살펴보면 실제 인스턴스는 이 타입들 중 하나라더라도 그렇습니다. 그럼에도 불구하고, 타입이 `TextRepresentable` 이기 때문에, 그리고 `TextRepresentable` 이면 어떤 것이든 `textualDescription` 속성을 가지고 있음을 알고 있기 때문에, 반복문을 통해서 매번 `thing.textualDescription` 에 안전하게 접근할 수 있습니다.

### Protocol Inheritance (프로토콜 상속)

프로토콜은 하나 이상의 다른 프로토콜을 _상속 (inherit)_ 할 수 있으며 상속받은 필수 조건 위에 필수 조건을 더 추가할 수도 있습니다. 프로토콜 상속을 위한 구문 표현은 클래스 상속을 위한 구문 표현과 비슷하지만, 여러 개의 상속된 프로토콜을, 쉼표로 구분하여, 나열하는 옵션을 가지고 있습니다[^multiple-inherited-protocols]:

```swift
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
  // 여기서 프로토콜을 정의합니다.
}
```

다음은 위에 있는 `TextRepresentable` 프로토콜을 상속하는 프로토콜에 대한 예제입니다:

```swift
protocol PrettyTextRepresentable: TextRepresentable {
  var prettyTextualDescription: String { get }
}
```

이 예제는, `TextRepresentable` 을 상속하는, `PrettyTextRepresentable` 이라는, 새 프로토콜을 정의합니다. `PrettyTextRepresentable` 을 채택하는 어떤 것이든 반드시 `TextRepresentable` 이 강제하는 모든 필수 조건을 만족해야 하며, 거기에 _더해서 (plus)_ `PrettyTextRepresentable` 이 강제하는 추가적인 필수 조건도 만족해야 합니다. 이 예제에서, `PrettyTextRepresentable` 은 단일한 필수 조건을 추가하여 `String` 을 반환하는 `prettyTextualDescription` 이라는 '획득 가능한 (gettable)' 속성을 제공하도록 합니다.

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

이 '익스텐션' 은 `PrettyTextRepresentable` 프로토콜을 채택하고 `SnakesAndLadders` 타입을 위해 `prettyTextualDescription` 속성에 대한 구현을 제공한다고 알립니다. `PrettyTextRepresentable` 인 것은 어떤 것이든 반드시 `TextRepresentable` 이기도 하므로, `prettyTextualDescription` 의 구현은 먼저 `TextRepresentable` 프로토콜에 있는 `textualDescription` 속성에 접근한 다음 출력 문자열을 만들기 시작합니다. 이는 '콜론' 과 '줄 끊음 (line break)' 을 추가해서, 문장 설명의 시작 부분을 예쁘게 꾸밉니다. 그런 다음 게임판 정사각형에 대한 배열에 동작을 반복 적용시켜서, 각 정사각형의 내용을 표현하는 기하학 도형을 추가합니다:

* 정사각형의 값이 `0` 보다 크다면, 사다리의 밑부분인 것이며, `▲` 로 표현합니다.
* 정사각형의 값이 `0` 보다 작다면, 뱀의 머리인 것이며, `▼` 로 표현합니다.
* 그 외의 경우, 정사각형의 값은 `0` 이고, "얽매이지 않은 (free)" 정사각형인 것이며, `○` 로 표현됩니다.

이제 `prettyTextualDescription` 속성을 사용하면 어떤 `SnakesAndLadders` 인스턴스에 대해서도 문장 설명을 예쁘게 꾸밀 수 있습니다:

```swift
print(game.prettyTextualDescription)
// A game of Snakes and Ladders with 25 squares:
// ○ ○ ▲ ○ ○ ▲ ○ ○ ▲ ▲ ○ ○ ○ ▼ ○ ○ ○ ○ ▼ ○ ○ ▼ ○ ▼ ○
```

### Class-Only Protocols (클래스-전용 프로토콜)

프로토콜의 채택을 (구조체나 열거체는 빼고) 클래스 타입에서만 되도록 제한하고 싶으면 프로토콜의 상속 목록에 `AnyObject` 프로토콜을 추가하면 됩니다.

```swift
protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
  // 여기서 클래스-전용 프로토콜을 정의합니다.
}
```

위 예제의, `SomeClassOnlyProtocol` 은 클래스 타입만 채택할 수 있습니다. 구조체나 열거체 정의에서 `SomeClassOnlyProtocol` 을 채택한다고 작성하면 '컴파일-시간 에러' 가 뜹니다.

> 클래스-전용 프로토콜을 사용하는 것은 프로토콜의 필수 조건으로 정의한 작동 방식이 가정하거나 요구하는 준수 타입이 값 의미 구조가 아니라 참조 의미 구조를 가질 때 입니다. 참조와 값 '의미 구조 (semantics)' 에 대한 더 많은 정보는, [Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#structures-and-enumerations-are-value-types-구조체와-열거체는-값-타입입니다) 와 [Classes Are Reference Types (클래스는 참조 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#classes-are-reference-types-클래스는-참조-타입입니다) 를 참고하기 바랍니다.

### Protocol Composition (프로토콜 조합)

타입이 여러 개의 프로토콜을 준수하도록 요구할 때 이를 동시에 할 수 있다면 좋을 것입니다. _프로토콜 조합 (protocol composition)_ 을 사용하면 여러 개의 프로토콜을 단일한 필수 조건으로 병합할 수 있습니다. '프로토콜 조합' 은 마치 임시 지역 프로토콜을 정의해서 조합에 있는 모든 프로토콜의 필수 조건을 병합한 것처럼 동작합니다. '프로토콜 조합' 은 어떤 새 프로토콜 타입을 정의하는 것이 아닙니다.

프로토콜 조합은 `SomeProtocol & AnotherProtocol` 과 같은 양식을 가집니다. 필요한 만큼 많은 개수의 프로토콜을, '앤드 기호 (`&`; 앰퍼샌드)' 로 구분하여, 나열할 수 있습니다. 프로토콜을 나열하는 것 외에도, 프로토콜 조합은 하나의 클래스 타입도 담을 수 있어서, 이것으로 '필수 상위 클래스 (required superclass)' 를 지정할 수 있습니다.

다음은 `Named` 와 `Aged` 라는 두 개의 프로토콜을 함수 매개 변수에 대한 단일 '프로토콜 조합 필수 조건' 으로 조합하는 예제입니다:

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
// "Happy birthday, Malcolm, you're 21!" 를 출력합니다.
```

이 예제에서, `Named` 프로토콜은 `name` 이라는 획득 가능한 `String` 속성에 대한 단일한 필수 조건을 가집니다. `Aged` 프로토콜은 `age` 라는 획득 가능한 `Int` 속성에 대한 단일 필수 조건을 가지고 있습니다. 두 프로토콜 모두 `Person` 이라는 구조체가 채택하고 있습니다.

이 예제는 `wishHappyBirthday(to:)` 라는 함수도 정의합니다. `celebrator` 매개 변수의 타입은 `Named & Aged` 인데, 이는 "`Named` 와 `Aged` 프로토콜을 모두 준수하는 어떤 타입" 을 의미합니다. 두 필수 프로토콜을 모두 준수하는 한, 어떤 타입이 함수에 전달되는 지는 별로 중요하지 않습니다.

그런 다음 이 예제는 `birthdayPerson` 이라는 새 `Person` 인스턴스를 생성하고 이 새 인스턴스를 `wishHappyBirthday(to:)` 함수로 전달합니다. `Person` 은 두 프로토콜을 모두 준수하므로, 이 호출은 유효하며, `wishHappyBirthday(to:)` 함수가 생일 인사말을 출력할 수 있습니다.

다음은 이전 예제에 있는 `Named` 프로토콜과 `Location` 클래스를 병합하는 예제입니다:

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
// "Hello, Seattle!" 를 출력합니다.
```

`beginConcert(in:)` 함수는 `Location & Named` 타입의 매개 변수를 받아 들이는데, 이는 "`Location` 의 하위 클래스이면서 `Named` 프로토콜을 준수하는 어떤 타입" 을 의미합니다. 이 경우, `City` 는 두 필수 조건을 모두 만족합니다.

`birthdayPerson` 을 `beginConcert(in:)` 함수에 전달하는 것은 무효한데 왜냐면 `Person` 이 `Location` 의 하위 클래스가 아니기 때문입니다. 이와 마찬가지로, `Named` 프로토콜을 준수하지 않는 `Location` 의 하위 클래스를 만든 경우, 이 타입의 인스턴스를 사용하여 `beginConcert(in:)` 를 호출하면 역시 무효할 것입니다.

### Checking for Protocol Conformance (프로토콜 준수성 검사하기)

[Type Casting (타입 변환)]({% post_url 2020-04-01-Type-Casting %}) 에서 설명한 `is` 와 `as` 연산자를 사용하면 프로토콜 준수성을 검사할 수 있고, 지정된 프로토콜로 변환할 수도 있습니다. 프로토콜을 검사하고 변환하는 것은 타입을 검사하고 변환하는 것과 정확하게 같은 구문 표현을 따릅니다:

* `is` 연산자는 인스턴스가 프로토콜을 준수하면 `true` 를 반환하고 그렇지 않으면 `false` 를 반환합니다.
* `as?` 버전의 '내림 변환 (downcast)' 연산자는 프로토콜 타입의 옵셔널 값을 반환하는데, 인스턴스가 해당 프로토콜을 준수하지 않을 경우 값이 `nil` 이 됩니다.
* `as!` 버전의 '내림 변환 (downcast)' 연산자는 프로토콜 타입으로 강제로 내림 변환하는데 이 내림 변환을 성공하지 못할 경우 실행 시간 에러를 발생시킵니다.

다음 예제는 `area` 라는 획득 가능한 `Double` 속성인 단일 속성 필수 조건을 가지고 있는, `HasArea` 라는 프로토콜을 정의합니다:

```swift
protocol HasArea {
  var area: Double { get }
}
```

다음은, `Circle` 과 `Country` 라는 두 클래스인데, 이 둘 모두 `HasArea` 프로토콜을 준수합니다:

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

`Circle` 클래스는, `radius` 라는 저장 속성을 기반으로, `area` 속성 필수 조건을 계산 속성으로 구현합니다. `Country` 클래스는 `area` 필수 조건을 저장 속성으로 직접 구현합니다. 두 클래스 모두 올바르게 `HasArea` 프로토콜을 준수하고 있습니다.

다음은, `Animal` 이라는 클래스인데, 이는 `HasArea` 프로토콜을 준수하지 않습니다:

```swift
class Animal {
  var legs: Int
  init(legs: Int) { self.legs = legs }
}
```

`Circle`, `Country`, 그리고 `Animal` 클래스에는 서로 공유하는 '기본 클래스 (base class)' 가 없습니다. 그럼에도 불구하고, 이들은 모두 클래스이므로, 이 세 가지 타입의 인스턴스를 모두 사용하여 `AnyObject` 타입의 값을 저장하는 배열을 초기화할 수 있습니다:

```swift
let objects: [AnyObject] = [
  Circle(radius: 2.0),
  Country(area: 243_610),
  Animal(legs: 4)
]
```

`objects` 배열은 '배열 글자 값 (array literal)' 로 초기화 되는데 `Circle` 인스턴스는 `2` 인 반지름 단위를 가지고; `Country` 인스턴스는 영국 면적을 제곱 미터로 초기화된 값이며; `Animal` 인스턴스는 네 개의 다리를 가지고 있습니다.

`objects` 배열은 이제 반복 적용해서, 배열에 있는 각 객체가 `HasArea` 프로토콜을 준수하는 있는 지 확인하는 검사를 할 수 있습니다:

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

배열에 있는 객체가 `HasArea` 프로토콜을 준수할 때마다, `as?` 연산자로 반환된 옵셔널 값은 포장이 풀리고 '옵셔널 연결 (optional binding; 옵셔널 바인딩)' 을 통해 `objectWithArea` 라는 상수에 들어가게 됩니다. `objectWithArea` 상수의 타입은 `HasArea` 임을 알고 있으므로, '타입-안전 (type-safe)'[^type-safe] 한 방식으로 `area` 속성에 접근하고 이를 출력할 수 있습니다.

'변환 과정 (casting process)' 에서 실제 객체는 바뀌지 않는다는 점에 주목하기 바랍니다. 이들은 계속해서 `Circle`, `Country`, 그리고 `Animal` 입니다. 하지만, 이들이 `objectWithArea` 라는 상수에 저장되는 시점에서, 이들이 `HasArea` 라는 것만 알게 되므로, `area` 속성에만 접근할 수 있습니다.

### Optional Protocol Requirements (옵셔널 프로토콜 필수 조건)

프로토콜에 대해서 _옵셔널 필수 조건 (optional requirements)_ 을 정의할 수 있습니다. 이 필수 조건은 프로토콜을 준수하는 타입에서 구현해야만 하는 것은 아닙니다. 옵셔널 필수 조건은 프로토콜을 정의할 때 `optional` 수정자를 접두사로 붙여줍니다. 옵셔널 필수 조건을 사용하여 오브젝티브-C 언어와 상호 호환되는 코드를 작성할 수 있습니다. 프로토콜과 옵셔널 필수 조건 모두 반드시 `@objc` '특성 (attribute)' 으로 표시해야 합니다. `@objc` 프로토콜은 오브젝티브-C 클래스 또는 다른 `@objc` 클래스를 상속하는 클래스에서만 채택할 수 있다는 점에 주목하기 바랍니다. 구조체나 열거체는 채택할 수 없습니다.

메소드와 속성을 옵셔널 필수 조건에서 사용할 때, 이들 타입은 자동으로 옵셔널이 됩니다. 예를 틀어, 타입이 `(Int) -> String` 인 메소드는 `((Int) -> String)?` 이 됩니다. 메소드의 반환 값이 아니라, 전체 함수 타입이 옵셔널로 포장된다는 것에 주목하기 바랍니다.

옵셔널 프로토콜 필수 조건은, 프로토콜을 준수하는 타입이 이 필수 조건을 구현하지 않을 가능성을 기술하기 위하여, '옵셔널 연쇄' 와 같이 사용할 수 있습니다. 옵셔널 메소드의 구현을 검사하려면 호출할 때 메소드의 이름 뒤에, `someOptionalMethod?(someArgument)` 와 같이, 물음표를 붙이면 됩니다. '옵셔널 연쇄 (optional chaining)' 에 대한 정보는, [Optional Chaining (옵셔널 체이닝; 옵셔널 연쇄)]({% post_url 2020-06-17-Optional-Chaining %}) 를 참고하기 바랍니다.

다음 예제는 `Counter` 라는 정수를-헤아리는 클래스를 정의하는데, 이는 외부 데이터 소스에서 제공하는 증가량을 사용합니다. 이 데이터 소스는, 두 개의 옵셔널 필수 조건을 가지는, `CounterDataSource` 프로토콜로 정의합니다:

```swift
@objc protocol CounterDataSource {
  @objc optional func increment(forCount count: Int) -> Int
  @objc optional var fixedIncrement: Int { get }
}
```

`CounterDataSource` 프로토콜은 `incremental(forCount:)` 라는 옵셔널 메소드 필수 조건과 `fixedIncrement` 라는 옵셔널 속성 필수 조건을 정의합니다. 이 필수 조건들은 데이터 소스가 `Counter` 인스턴스에게 적절한 증가량을 제공하도록 서로 다른 두 가지 방법을 정의합니다.

> 엄밀하게 말해서, `CounterDataSource` 프로토콜을 준수하는 사용자 정의 클래스를 작성하면서 _어느 (either)_ 프로토콜 필수 조건도 구현하지 않아도 됩니다. 결국, 둘 다 '옵셔널 (optional; 선택 사항)' 인 것입니다. 기술적으로 문제될 건 없지만, 좋은 데이터 소스라고 할 수는 없을 것입니다.

아래에서 정의된, `Counter` 클래스는, `CounterDataSource?` 타입의 옵셔널 `dataSource` 속성을 가집니다:

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

`Counter` 클래스는 현재의 값을 `count` 라는 변수 속성에 저장합니다. `Counter` 클래스는, 메소드가 호출될 때마다 `count` 속성을 증가하는, `increment` 라는 메소드도 정의합니다.

`increment()` 메소드는 먼저 증가량을 가져오기 위해 데이터 소스에서 `incremental(forCount:)` 메소드의 구현을 찾습니다. `increment()` 메소드는 '옵셔널 연쇄 (optional chaining)' 를 사용하여 `increment(forCount:)` 호출을 시도하며, 현재의 `count` 값을 이 메소드의 단일한 인자로 전달합니다.

여기서 _두 (two)_ 단계 깊이의 옵셔널 연쇄를 사용함에 주목하기 바랍니다. 첫째, `dataSource` 가 `nil` 일 수 있으므로, `dataSource` 이름 뒤에 물음표를 붙여서 `dataSource` 가 `nil` 이 아닌 경우에만 `incremental(forCount:)`  를 호출하도록 지시합니다. 둘째, 설령 `dataSource` 가 존재 _하더라도 (does)_, 이는 옵셔널 필수 조건이기 때문에, `increment(forCount:)` 를 구현했다는 보증을 할 수 없습니다. 여기서, `increment(forCount:)` 를 구현하지 않았을 가능성 또한 '옵셔널 연쇄' 로 처리합니다. `increment(forCount:)` 호출은 `increment(forCount:)` 가 존재하는 경우에만-즉, `nil` 이 아닌 경우에만-일어납니다. 이것이 `incremental(forCount:)` 이름 뒤에 물음표를 표시한 이유입니다.

`increment(forCount:)` 호출은 이 두 가지 이유로 인해 실패할 수 있기 때문에, 이 호출은 _옵셔널 (optional)_ `Int` 값을 반환합니다. 이것은 `increment(forCount:)` 가 `CounterDataSource` 의 정의에서 옵셔널이-아닌 `Int` 값을 반환하도록 정의되어 있더라도 마찬가지입니다. 비록 두 개의 옵셔널 연쇄 작업을, 하나 다음에 또 하나, 이어서 하더라도, 결과는 여전히 단일한 옵셔널로 '포장됩니다 (wrapped)'. 다중 옵셔널 연쇄 작업을 사용하는 것에 대한 더 많은 정보는, [Linking Multiple Levels of Chaining (다중 수준의 연쇄 연결하기)]({% post_url 2020-06-17-Optional-Chaining %}#linking-multiple-levels-of-chaining-다중-수준의-연쇄-연결하기) 를 참고하기 바랍니다.

`increment(forCount:)` 를 호출 한 후에는, '옵셔널 연결' 을 사용하여, 반환된 옵셔널 `Int` 의 포장을 풀고 `amount` 라는 상수에 넣습니다. 만약 옵셔널 `Int` 가 값을 담고 있으면-다시 말해, '대리자 (delegate)' 와 메소드가 모두 존재하고, 메소드가 값을 반환한 경우-포장 속의 `amount` 가 저장 속성인 `count` 가 추가되어, 증가 연산을 종료합니다.

만약 `increment(forCount:)` 메소드로부터 값을 가져오는 것이 가능하지 _않은 (not)_ 경우라면-`dataSource` 가 `nil` 이기 때문이거나, 아니면 데이터 소스가 `increment(forCount:)` 를 구현하지 않았기 때문인 경우-그러면 `increment()` 메소드는 그 대신 데이터 소스의 `fixedIncrement` 속성으로부터 값을 가져오려고 시도합니다. `fixedIncrement` 속성도 옵셔널 필수 조건이므로, 이 값은 옵셔널 `Int` 값인데, `fixedIncrement` 가 `CounterDataSource` 프로토콜 정의에서 옵셔널이-아닌 `Int` 속성으로 정의되어 있더라도 그렇습니다.

다음은 데이터 소스를 조회할 때마다 `3` 이라는 상수 값을 반환하는 간단한 `CounterDataSource` 구현입니다. 이를 위해 옵셔널 `fixedIncrement` 속성 필수 조건을 구현했습니다:

```swift
class ThreeSource: NSObject, CounterDataSource {
  let fixedIncrement = 3
}
```

`ThreeSource` 의 인스턴스를 새로운 `Counter` 인스턴스에 대한 데이터 소스로 사용할 수 있습니다:

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

위의 코드는 새로운 `Counter` 인스턴스를 생성하여; 데이터 소스를 새로운 `ThreeSource` 인스턴스로 설정하며; '카운터 (counter)' 의 `increment()` 메소드를 네 번 호출합니다. 예상 대로, 카운터의 `count` 속성은 `increment()` 를 호출할 때마다 '3' 만큼 증가합니다.

다음은 좀 더 복잡한 데이터 소스인 `TowardsZeroSource` 인데, 이는 `Counter` 인스턴스를 현재의 `count` 값에서 '0' 으로 '카운트 업 (count up)' 또는 '카운트 다운 (count down)' 하도록 합니다:

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

`TowardsZeroSource` 클래스는 `CounterDataSource` 프로토콜에 있는 옵셔널 `increment(forCount:)` 메소드를 구현하여 `count` 인자 값을 사용하여 어느 방향으로 '카운트' 할 지를 알아냅니다. 만약 `count` 가 이미 '0' 라면, 이 메소드는 `0` 을 반환하여 더 이상 '카운트' 를 하지 않아도 됨을 지시합니다.

`TowardsZeroSource` 인스턴스를 기존에 존재하던 `Counter` 인스턴스와 같이 사용하여 `-4` 에서 '0' 까지 '카운트' 할 수 있습니다. 일단 한번 '카운터' 가 '0' 에 도달하면, 더 이상 카운트되지 않습니다.

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

### Protocol Extensions (프로토콜 확장)

프로토콜을 확장하여 준수 타입의 메소드, 초기자, 첨자 연산, 및 계산 속성에 대한 구현을 제공할 수 있습니다. 이것은, 각각의 개별 준수 타입 또는 전역 함수 대신, 프로토콜 자체에서 작동 방식을 정의하도록 해줍니다.

예를 들어, `RandomNumberGenerator` 프로토콜을 확장하여, 필수 메소드인 `random()` 의 결과로 `Bool` 타입의 난수 값을 반환하는, `randomBool()` 이라는 메소드를 제공하도록 만들 수 있습니다:

```swift
extension RandomNumberGenerator {
  func randomBool() -> Bool {
    return random() > 0.5
  }
}
```

프로토콜에 대한 '익스텐션 (extension; 확장)' 을 생성하는 것으로, 모든 준수 타입들은 따로 추가적인 수정을 할 필요 없이 자동으로 해당 메소드 구현을 가지게 됩니다:

```swift
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// "Here's a random number: 0.3746499199817101" 를 출력합니다.
print("And here's a random Boolean: \(generator.randomBool())")
// "And here's a random Boolean: true" 를 출력합니다.
```

'프로토콜 확장' 은 준수 타입에 대한 구현을 추가할 수 있지만 프로토콜을 확장하거나 다른 프로토콜을 상속받도록 만들 수는 없습니다. '프로토콜 상속' 은 항상 해당 프로토콜 선언에서 직접 지정하는 것입니다.

#### Providing Default Implementations (기본 구현 제공하기)

프로토콜 확장을 사용하여 해당 프로토콜의 어떤 '메소드 필수 조건' 이나 '계산 속성 필수 조건' 에 대해서도 '기본 구현 (default implementation)' 을 제공할 수 있습니다. 만약 준수 타입이 '필수 메소드' 나 '필수 속성' 에 대한 자체 구현을 제공하는 경우, 확장에서 제공되는 것 대신 해당 구현을 사용하게 됩니다.

> 확장에서 제공되는 기본 구현을 가진 '프로토콜 필수 조건' 은 '옵셔널 프로토콜 필수 조건' 과는 다릅니다. 어느 쪽도 준수 타입이 직접 구현을 제공할 필요가 없다는 것은 같지만, 기본 구현을 가지는 '필수 조건' 은 '옵셔널 연쇄' 없이 호출할 수 있습니다.

예를 들어, `TextRepresentable` 프로토콜을 상속하는, `PrettyTextRepresentable` 프로토콜은, 필수 속성인 `prettyTextualDescription` 에 대한 기본 구현을 제공하여 `textualDescription` 속성에 접근한 결과를 단순히 반환하도록 만들 수 있습니다:

```swift
extension PrettyTextRepresentable {
  var prettyTextualDescription: String {
    return textualDescription
  }
}
```

#### Adding Constraints to Protocol Extensions (프로토콜 확장에 대한 구속 조건 추가하기)

프로토콜 확장을 정의할 때는, 확장에 있는 메소드와 속성이 사용 가능해지기 전에 준수 타입이 반드시 만족해야 할 '구속 조건 (constraints)' 을 지정할 수 있습니다. 이러한 구속 조건은 확장할 프로토콜의 이름 뒤에 일반화된 `where` 절을 붙여서 작성합니다. 일반화된 `where` 절에 대한 더 자세한 내용은 [Generic Where Clauses (일반화된 'Where' 절)]({% post_url 2017-03-16-Generic-Parameters-and-Arguments %}#generic-where-clauses-일반화된-where-절) 를 참고하기 바랍니다.[^POP]

예를 들어, `Collection` 프로토콜에 대한 확장을 정의하면서 어떤 '컬렉션 (collection)' 의 원소가 `Equatable` 프로토콜을 준수하는 경우에만 적용되도록 할 수 있습니다. '컬렉션' 의 원소를, 표준 라이브러리의 일부인, `Equatable` 프로토콜로만 구속하면, `==` 와 `!=` 연산자를 사용하여 두 원소의 '같음 (equality)' 과 '다름 (inequality)' 을 검사할 수 있습니다.

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

`allEqual()` 메소드는 컬렉션에 있는 원소가 모두 같은 경우에만 `true` 를 반환합니다.

두 개의 정수 배열이 있는데, 하나는 모든 원소가 같고, 다른 하나는 그렇지 않다고, 가정해 봅시다:

```swift
let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]
```

'배열 (arrays)' 은 `Collection `을 준수하고 '정수 (integers)' 는 `Equatable` 을 준수하고 있기 때문에, `equalNumbers` 와 `differentNumbers` 는 `allEqual()` 메소드를 사용할 수 있습니다:

```swift
print(equalNumbers.allEqual())
// "true" 를 출력합니다.
print(differentNumbers.allEqual())
// "false" 를 출력합니다.
```

> 준수 타입이 '구속 조건' 이 있는 확장 여러 개의 '필수 조건' 을 동시에 만족해서 하나의 메소드 또는 속성이 여러 개의 구현을 동시에 가지게 될 경우, 스위프트는 가장 '세분화된 구속 조건 (specialized constraints)' 과 관련된 구현을 사용합니다.

### 참고 자료

[^Protocols]: 원문은 [Protocols](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#) 에서 확인할 수 있습니다.

[^protocol]: `protocol` 은 '규약' 이라는 뜻을 갖고 있지만, 스위프트 언어에서는 '키워드 (keyword)' 로도 사용되므로, `class` 를 '클래스'라로 하듯이, 앞으로 '프로토콜' 이라고 옮기겠습니다. 다만 필요한 경우에는 '규약' 이라는 의미를 살려서 번역하도록 하겠습니다.

[^blueprint]: blueprint는 '청사진'이라는 뜻을 갖고 있는데, 이는 과거에 제품 '설계 도면' 을 복사하던 방법이 파란색을 띄었기 때문입니다. Xcode 아이콘을 보시면 항상 망치 밑에 파란색 종이가 깔려 있는 것을 볼 수 있는데, 이것이 바로 '청사진 (blueprint)' 입니다. 여기서는 제품을 제작하기 위해 필요한 밑그림의 의미로 '설계 도면' 이라고 옮기도록 하겠습니다.

[^optional]: 여기서 'optional' 을 '선택적인' 이라고 옮겼는데, 키워드의 의미로 '옵셔널' 로 옮기고 이해해도 상관은 없습니다. 이렇게 값이 있을 수도 있고 없을 수도 있는 '선택적인' 값을 나타내기 위해 '옵셔널' 을 만든 것이라 둘 다 무방한 경우입니다.

[^linear-congruential-generator]: '선형 합동 생성기' 는 널리 알려진 '유사난수 생성기' 라고 합니다. 다만 선형 합동 생성기는 인자와 마지막으로 생성된 난수를 알면 그 뒤의 모든 난수를 예측할 수 있기 때문에 바람직한 난수 생성기는 아니라고합니다. 이에 대한 더 자세한 정보는 위키피디아의 [Linear congruential generator](https://en.wikipedia.org/wiki/Linear_congruential_generator) 와 [선형 합동 생성기](https://ko.wikipedia.org/wiki/선형_합동_생성기) 항목을 참고하기 바랍니다.

[^adopt]: 여기서 원문을 보면 '준수 (conforming)' 가 아니라 '채택 (adopt)' 이라는 단어를 사용했습니다. 스위프트 문서를 보면 '준수' 와 '채택' 은 항상 분명하게 구분하여 사용하는 것을 알 수 있습니다. 이 둘의 차이점은 이 문서의 맨 앞에 있는 [Protocols (프로토콜; 규약)](#protocols-프로토콜-규약) 부분을 참고하기 바랍니다.

[^delegate]: 여기서의 'delegate' 는 명사로써 위임된 기능을 수행하는 '대리자' 라는 의미를 가집니다.

[^instantiator]: 이걸 본문에서 'instantiator' 라는 말로 표현했는데, 적당한 말이 없어서 그냥 '인스턴스를 만드는 부분' 으로 옮겼습니다. 아마도 실제 게임을 구현한다면 일종의 'game manager' 역할을 하는 것으로 게임 인스턴스를 만들 수 있을 것입니다. 그 때, 해당 'game manager' 를 'inistantiator' 라고 부르게 되는 것 같습니다.

[^snakes-and-ladders-instance]: 여기서 `SnakesAndLadders` 인스턴스를 매개 변수로 전달하는 것은 각 메소드이 호출에 있는 `self` 인자를 말합니다.

[^generic-type]: 여기서 '일반화된 타입 (generic type)' 은 프로그래밍에서 사용하는 그 '제네릭' 이 맞습니다. 영어로 '제네릭 (generic)' 자체가 '일반화되었다' 는 의미를 담고 있습니다.

[^adoption]: 이것이 스위프트에서 'adoption (채택)' 과 'conformance (준수)' 를 명확하게 구분해서 사용하는 이유일 것입니다.

[^synthesized]: 본문에서 '통합된 구현 (synthesized implementation)' 이라는 것은 스위프트 내부에 이미 구현되어 있는 것을 의미합니다. 즉 `Equatable` 프로토콜을 준수하는 코드는 우리가 따로 만들 수도 있겠지만, 스위프트가 제공하는 '통합된 구현' 을 사용하면 더 쉽게 작성할 수 있다는 의미입니다.

[^original-declaration]: 본문에서 '원래의 선언 (original declaration) 을 담고 있는 파일' 이라는 말을 사용하는 것을 볼 때, 다른 파일에서 `Equatable` 에 대한 '준수성 (conformance)' 를 작성한다고 해서 '통합된 구현' 을 사용할 수 있는 것은 아니라는 것을 추측할 수 있습니다.

[^multiple-inherited-protocols]: 스위프트에서 클래스 상속은 한 개만 되지만, 프로토콜 상속은 여러 개가 가능하다는 것을 말하는 것으로 이해하면 될 것 같습니다.

[^type-safe]: 여기서 '타입-안전한 방식 (type-safe way)' 이라는 것은, '스위프트 프로그래밍 언어' 본문에서 꽤 자주 나오는 말인데, 스위프트가 기본적으로 제공하는 '타입 추론 (type inference)' 과 '타입 검사 (type check)' 기능을 사용할 수 있다는 것을 의미합니다. 각각에 대해서는 [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)]({% post_url 2016-04-24-The-Basics %}#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 에서 설명하고 있습니다.

[^POP]: [Protocol Oriented Programming](https://developer.apple.com/videos/play/wwdc2015/408/)의 핵심이라고 할 수 있습니다. Protocol Oriented Programming 에 대해서는 [Protocol-Oriented Programming Tutorial in Swift 5.1: Getting Started](https://www.raywenderlich.com/6742901-protocol-oriented-programming-tutorial-in-swift-5-1-getting-started) 에서 더 알아볼 수 있습니다.

[^specialized]: 추가 설명이나 예제가 있으면 좋겠지만, 원문에 따로 설명된 것이 없는게 아쉽습니다. Apple Forum 의 질문 답변 중 [What does "most specialized constraints" mean?](https://forums.developer.apple.com/thread/70845) 이라는 글에 따르면, 여러 개의 '구속 조건 (constraints)' 을 동시에 만족하는 경우는 타입이 계층 관계일 때 발생하는데, '가장 세분화된 구속 조건' 을 따른다는 것은 타입의 계층 관계에서 가장 하위의 클래스를를 따른다는 의미일 것 같습니다.
