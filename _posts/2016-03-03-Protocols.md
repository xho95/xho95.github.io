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

아래 예제는 `OnOffSwitch` 라는 열거체를 정의합니다. 이 열거체는, 열거체의 경우 값 `on` 과 `off` 로 나타내는, 두 상태 사이를 왔다갔다 합니다. 이 열거체의 `toggle` 구현은, `Togglable` 프로토콜의 필수 조건에 들어 맞도록, `mutating` 으로 표시합니다:

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

_위임 (delegation)_ 은 클래스나 구조체가 책임의 일부를 다른 타입의 인스턴스에게로 넘기기-또는 _위임 (delegate)_-할 수 있게 해주는 '디자인 패턴 (design pattern)' 입니다. 이 '디자인 패턴' 은 위임된 책임을 '은닉하는 (encapsulates)' 프로토콜의 정의로 구현하여, ('대리인 (delegate)'[^delegate] 이라고 하는) 준수 타입이 위임된 기능을 제공할 것을 보증합니다. 위임은 특정한 동작에 응답하기 위해서, 또는 해당 소스의 실제 타입을 알 필요 없이 외부 소스의 데이터를 조회하기 위해서, 사용할 수 있습니다.

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

### Adding Protocol Conformance with an Extension

#### Conditionally Conforming to a Protocol

#### Declaring Protocol Adoption with and Extension

### Adopting a Protocol Using a Synthesized Implementation

### Collections of Protocol Types

### Protocol Inheritance

### Class-Only Protocols (클래스-전용 프로토콜)

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

#### Providing Default Implementations (기본 구현 제공하기)

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

#### Adding Constraints to Protocol Extensions (프로토콜을 확장할 때 구속 조건 추가하기)

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

[^optional]: 여기서 'optional' 을 '선택적인' 이라고 옮겼는데, 키워드의 의미로 '옵셔널' 로 옮기고 이해해도 상관은 없습니다. 이렇게 값이 있을 수도 있고 없을 수도 있는 '선택적인' 값을 나타내기 위해 '옵셔널' 을 만든 것이라 둘 다 무방한 경우입니다.

[^linear-congruential-generator]: '선형 합동 생성기' 는 널리 알려진 '유사난수 생성기' 라고 합니다. 다만 선형 합동 생성기는 인자와 마지막으로 생성된 난수를 알면 그 뒤의 모든 난수를 예측할 수 있기 때문에 바람직한 난수 생성기는 아니라고합니다. 이에 대한 더 자세한 정보는 위키피디아의 [Linear congruential generator](https://en.wikipedia.org/wiki/Linear_congruential_generator) 와 [선형 합동 생성기](https://ko.wikipedia.org/wiki/선형_합동_생성기) 항목을 참고하기 바랍니다.

[^adopt]: 여기서 원문을 보면 '준수 (conforming)' 가 아니라 '채택 (adopt)' 이라는 단어를 사용했습니다. 스위프트 문서를 보면 '준수' 와 '채택' 은 항상 분명하게 구분하여 사용하는 것을 알 수 있습니다. 이 둘의 차이점은 이 문서의 맨 앞에 있는 [Protocols (프로토콜; 규약)](#protocols-프로토콜-규약) 부분을 참고하기 바랍니다.

[^delegate]: 여기서의 'delegate' 는 명사로써 위임된 기능을 수행하는 '대리인' 이라는 의미를 가지도록 옮겼습니다. 특별히 필요한 경우가 아니라면 그냥 '위임' 이라고 옮기도록 하겠습니다.

[^POP]: [Protocol Oriented Programming](https://developer.apple.com/videos/play/wwdc2015/408/)의 핵심이라고 할 수 있습니다. Protocol Oriented Programming 에 대해서는 [Protocol-Oriented Programming Tutorial in Swift 5.1: Getting Started](https://www.raywenderlich.com/6742901-protocol-oriented-programming-tutorial-in-swift-5-1-getting-started) 에서 더 알아볼 수 있습니다.

[^specialized]: 추가 설명이나 예제가 있으면 좋겠지만, 원문에 따로 설명된 것이 없는게 아쉽습니다. Apple Forum 의 질문 답변 중 [What does "most specialized constraints" mean?](https://forums.developer.apple.com/thread/70845) 이라는 글에 따르면, 여러 개의 '구속 조건 (constraints)' 을 동시에 만족하는 경우는 타입이 계층 관계일 때 발생하는데, '가장 세분화된 구속 조건' 을 따른다는 것은 타입의 계층 관계에서 가장 하위의 클래스를를 따른다는 의미일 것 같습니다.
