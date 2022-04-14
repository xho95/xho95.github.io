---
layout: post
comments: true
title:  "Swift 5.5: Automatic Reference Counting (자동 참조 카운팅)"
date:   2020-06-30 10:00:00 +0900
categories: Swift Language Grammar ARC Automatic Reference Counting
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Opaque Types](https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html) 부분[^Opaque-Types]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Automatic Reference Counting (자동 참조 카운팅)

스위프트는 _자동 참조 카운팅 (Automatic Reference Counting; ARC)_ 을 사용하여 앱의 메모리 사용을 추적하고 관리합니다. 대부분의 경우, 이는 스위프트에서 메모리 관리는 "그냥 작동하는 (just works)" 것이며, 메모리 관리를 직접 생각할 필요가 없다는 의미입니다. ARC 는 클래스 인스턴스가 더 이상 필요하지 않을 때 그 인스턴스가 사용한 메모리를 자동으로 풀어줍니다.

하지만, 몇몇 경우에 ARC 는 메모리 관리를 위해 코드 간의 관계에 대한 더 많은 정보를 요구합니다. 이번 장은 그 상황들을 설명하며 ARC 가 앱의 모든 메모리를 관리하게 해주는 방법을 보입니다. 스위프트에서 ARC 를 사용하는 건 [Transitioning to ARC Release Notes](https://developer.apple.com/library/archive/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html)[^ARC-Objective-C] 에서 설명한 오브젝티브-C 에서 ARC 를 사용하는 접근법과 아주 비슷합니다.

참조 카운팅은 클래스 인스턴스에만 적용합니다.[^reference-type] 구조체와 열거체는 값 타입이지, 참조 타입이 아라서, 참조로 저장하고 전달하지 않습니다.

### How ARC Works (ARC 의 작동 방식)

새로운 클래스 인스턴스를 생성할 때마다, ARC 가 메모리 덩어리를 할당하여 그 인스턴스에 대한 정보를 저장합니다. 이 메모리는 인스턴스의 타입에 대한 정보와, 그 인스턴스와 결합된 어떤 저장 속성의 값을 함께, 쥐고 있습니다.

추가적으로, 더 이상 인스턴스가 필요없을 땐, ARC 가 그 인스턴스에서 사용한 메모리를 풀어줘서 메모리를 대신 다른 용도로 사용하게 합니다. 이는 더 이상 클래스 인스턴스가 필요하지 않을 때는 이들이 메모리 공간을 차지하게 않음을 보장합니다.

하지만, ARC 가 해제한 인스턴스가 여전히 사용 중인 거라면, 더 이상 그 인스턴스의 속성에 접근하거나, 그 인스턴스의 메소드를 호출하는 게, 가능하지 않을 겁니다. 진짜로, 인스턴스에 접근하려 하면, 앱이 십중팔구 충돌할 겁니다.

인스턴스가 아직 필요한 동안엔 사라지지 않도록 하기 위해, ARC 는 현재 얼마나 많은 속성, 상수, 및 변수가 각각의 클래스 인스턴스를 참조하고 있는지 추적합니다. ARC 는 그 인스턴스에 적어도 하나의 활동중인 참조가 존재하는 한 인스턴스를 해제하지 않을 겁니다.

이를 가능하게 하려고, 속성이나, 상수, 또는 변수에 클래스 인스턴스를 할당할 때마다, 그 속성이나, 상수, 또는 변수는 인스턴스에 대한 _강한 참조 (strong reference)_ 를 만듭니다. 참조를 "강한 (strong)" 참조라고 하는 건 그 인스턴스를 꽉 쥐고 있기 때문이며, 이 강한 참조가 남아 있는 한 해제를 허용하지 않습니다.

### ARC in Action (ARC 의 실제 사례)

자동 참조 카운팅의 작동 방법에 대한 예제는 이렇습니다. 이 예제는 `Person` 이라는 단순한 클래스로 시작하는데, 이는 `name` 이라는 상수 저장 속성[^stored-constant-property] 을 정의합니다:

```swift
class Person {
  let name: String
  init(name: String) {
    self.name = name
    print("\(name) is being initialized")
  }
  deinit {
    print("\(name) is being deinitialized")
  }
}
```

`Person` 클래스에 있는 초기자는 인스턴스의 `name` 속성을 설정하고 초기화가 진행중이라는 메시지를 인쇄합니다. `Person` 클래스에는 정리자 (deinitializer)[^deinitializer] 도 있는데 클래스 인스턴스의 해제 때 메시지를 인쇄합니다.

그 다음 코드 조각에서 정의하는 세 개의 `Person?` 타입 변수는, 뒤이은 코드 조각에 있는 새로운 `Person` 인스턴스에 대한 다중 참조[^multiple-references] 를 설정하는데 사용합니다. 이 변수들은 (`Person` 이 아닌, `Person?` 이라는) 옵셔널 타입이기 때문에, 자동으로 `nil` 값으로 초기화하며, `Person` 인스턴스를 현재는 참조하지 않습니다.

```swift
var reference1: Person?
var reference2: Person?
var reference3: Person?
```

이제 새로운 `Person` 인스턴스를 생성하여 이 세 변수 중 하나에 할당할 수 있습니다:

```swift
reference1 = Person(name: "John Appleseed")
// "John Appleseed is being initialized" 를 인쇄함
```

`Person` 클래스의 초기자를 호출하는 시점에 `"John Appleseed is being initialized"` 라는 메시지를 인쇄한다는 걸 기억하기 바랍니다. 이는 초기화가 일어났음을 확정합니다.

새로운 `Person` 인스턴스를 `reference1` 변수에 할당했기 때문에, 이제 `reference1` 에서 새 `Person` 인스턴스로의 강한 참조가 있습니다. 적어도 하나의 강한 참조가 있기 때문에, ARC 는 이 `Person` 을 메모리에 유지하며 해제되지 않도록 합니다.

동일한 `Person` 인스턴스를 두 변수에 더 할당하면, 그 인스턴스로의 강한 참조 두 개를 더 세웁니다:

```swift
reference2 = reference1
reference3 = reference1
```

이제 이 단일 `Person` 인스턴스로의 강한 참조가 _세 개 (three)_ 있습니다.

두 개의 변수에 `nil` 을 할당하여 이러한 강한 참조 중 (원본 참조를 포함한) 두 개를 끊는다면, 단일한 강한 참조가 남아 있어, `Person` 인스턴스를 해제하지 않습니다:

```swift
reference1 = nil
reference2 = nil
```

ARC는 세 번째인 최종 강한 참조를 끊기 전까지 `Person` 인스턴스를 해제하지 않는데, 그 시점에는 더 이상 `Person` 인스턴스를 사용하지 않는다는게 명확합니다:

```swift
reference3 = nil
// "John Appleseed is being deinitialized" 를 인쇄함
```

### Strong Reference Cycles Between Class Instances (클래스 인스턴스 사이의 강한 참조 순환)

위 예제에서, ARC 는 새로 생성한 `Person` 인스턴스의 참조 개수를 추적하고 더 이상 필요하지 않을 땐 그 `Person` 인스턴스를 해제하는게 가능합니다.

하지만, 작성한 코드에서 클래스 인스턴스의 강한 참조가 _절대로 (never)_ 0개가 되지 않을 가능성이 있습니다. 이는 클래스 인스턴스 두 개가 서로의 강한 참조를 쥐고 있어, 각각의 인스턴스가 다른 걸 살아있게 하면, 발생할 수 있습니다. 이를 _강한 참조 순환 (strong reference cycle)_ 이라 합니다.

강한 참조 순환을 해결하려면 클래스 사이의 일부 관계를 강한 참조 대신 약한 (weak) 또는 소유하지 않는 (unowned) 참조로 정의하면 됩니다. 이 과정은 [Resolving Strong Reference Cycles Between Class Instances (클래스 인스턴스 사이의 강한 참조 순환 해결하기)](#resolving-strong-reference-cycles-between-class-instances-클래스-인스턴스-사이의-강한-참조-순환-해결하기) 에서 설명합니다. 하지만, 강한 참조 순환의 해결 방법을 배우기 전에, 그런 순환을 유발하는 방법을 이해하는게 유용합니다.

우연히 강한 참조 순환을 생성할 수 있는 예제는 이렇습니다. 이 예제는 `Person` 과 `Apartment` 라는 두 클래스를 정의하는데, 이들은 아파트 및 거주자를 모델링합니다:

```swift
class Person {
  let name: String
  init(name: String) { self.name = name }
  var apartment: Apartment?
  deinit { print("\(name) is being deinitialized") }
}

class Apartment {
  let unit: String
  init(unit: String) { self.unit = unit }
  var tenant: Person?
  deinit { print("Apartment \(unit) is being deinitialized") }
}
```

모든 `Person` 인스턴스에는 `String` 타입의 `name` 속성과 `nil` 로 초기화한 옵셔널 `apartment` 속성이 있습니다. `apartment` 속성이 옵셔널인 건, 사람이 항상 아파트를 가지진 않기 때문입니다.

이와 비슷하게, 모든 `Apartment` 인스턴스에는 `String` 타입의 `unit` 속성과 `nil` 로 초기화한 옵셔널 `tenant` 속성이 있습니다. 입주자 (tenant) 속성이 옵셔널인 건 아파트에 입주자가 항상 있는 건 아니기 때문입니다.

이 두 클래스 모두 정리자를 정의하여, 그 클래스 인스턴스가 정리 중이라는 사실도 인쇄합니다. 이는 `Person` 과 `Apartment` 인스턴스가 예상대로 해제되는지 확인할 수 있게 합니다.

이 다음 코드 조각은 `john` 과 `unit4A` 라는 옵셔널 타입 변수를 두 개 정의하는데, 이는 밑에서 특정 `Apartment` 및 `Person` 인스턴스로 설정할 겁니다. 이 두 변수 모두, 옵셔널인 덕에, `nil` 이라는 초기 값을 가집니다:

```swift
var john: Person?
var unit4A: Apartment?
```

이제 특정한 `Person` 인스턴스 및 `Apartment` 인스턴스를 생성하고 이 새 인스턴스를 `john` 및 `unit4A` 변수에 할당할 수 있습니다:

```swift
john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
```

이 두 인스턴스를 생성하고 할당한 후의 강한 참조는 이렇게 보입니다. 이제 `john` 변수에는 새로운 `Person` 인스턴스의 강한 참조가 있고, `unit4A` 변수에는 새로운 `Apartment` 인스턴스의 강한 참조가 있습니다:

![Strong Reference Start](/assets/Swift/Swift-Programming-Language/Automatic-Reference-Counting-strong-before.jpg)

이제 두 인스턴스를 서로 이어서 사람은 아파트를 가지고, 아파트는 입주자를 가지게 할 수 있습니다. 느낌표 (`!`) 를 써서 `john` 과 `unit4A` 옵셔널 변수 안에 저장된 인스턴스의 포장을 풀어서 접근해야, 이 인스턴스의 속성을 설정할 수 있다는 걸 기억하기 바랍니다:

```swift
john!.apartment = unit4A
unit4A!.tenant = john
```

두 인스턴스를 서로 이은 후의 강한 참조는 이렇게 보입니다:

![Strong Reference](/assets/Swift/Swift-Programming-Language/Automatic-Reference-Counting-strong-reference.png)

불행하게도, 이 두 인스턴스를 잇는 건 이들 사이에 강한 참조 순환을 생성합니다. 이제 `Person` 인스턴스에는 `Apartment` 인스턴스로의 강한 참조가 있고, `Apartment` 인스턴스에는 `Person` 인스턴스로의 강한 참조가 있습니다. 그러므로, `john` 과 `unit4A` 변수가 쥐고 있는 강한 참조를 끊을 때, 참조 개수는 0 으로 떨어지지 않으며, ARC 는 인스턴스를 해제하지 않습니다:

```swift
john = nil
unit4A = nil
```

이 두 변수에 `nil` 을 설정할 땐 어느 정리자도 호출하지 않는다는 걸 기억하기 바랍니다. 강한 참조 순환은 `Person` 과 `Apartment` 인스턴스의 해제를 늘 막아서, 앱의 메모리가 새어 나가게 합니다.

`john` 과 `unit4A` 변수를 `nil` 로 설정한 후의 강한 참조는 이렇게 보입니다:

![Strong Reference Remaining](/assets/Swift/Swift-Programming-Language/Automatic-Reference-Counting-strong-remain.jpg)

`Person` 인스턴스와 `Apartment` 인스턴스 사이엔 강한 참조가 남아 있으며 끊을 수 없습니다.

### Resolving Strong Reference Cycles Between Class Instances (클래스 인스턴스 사이의 강한 참조 순환 해결하기)

클래스 타입의 속성과 작업할 때 스위프트는 두 가지 방법을 제공하여 강한 참조 순환을 해결하는데: 약한 참조와 소유하지 않는 참조가 그것입니다.

약한 및 소유하지 않는 참조는 참조 순환의 한 인스턴스가 다른 인스턴스를 강하게 쥐지 _않고 (without)_ 참조할 수 있게 합니다. 그러면 강한 참조 순환의 생성 없이 인스턴스가 서로를 참조할 수 있습니다.

다른 인스턴스의 수명이 더 짧을 때-즉, 다른 인스턴스를 먼저 해제할 수 있을 때-약한 참조를 사용합니다. 위의 `Apartment` 예제에서, 아파트 수명 중 어떠한 시점에 입주자가 없는게 가능한 건 적절하므로, 이 경우 약한 참조로 참조 순환을 끊는 게 적절합니다. 이와 대조적으로, 다른 인스턴스의 수명이 똑같거나 더 길 땐 소유하지 않는 참조를 사용합니다.

#### Weak References (약한 참조)

_약한 참조 (weak reference)_ 는 자신이 참조한 인스턴스를 강하게 쥐지 않는 참조라서, ARC 가 참조 인스턴스를 처리하는 걸 멈추지 않습니다. 이런 동작은 참조가 강한 참조 순환의 일부가 되는 걸 막습니다. 약한 참조라고 지시하려면 속성이나 변수 선언 앞에 `weak` 키워드를 두면 됩니다.

약한 참조는 자신이 참조할 인스턴스를 강하게 쥐지 않기 때문에, 여전히 약한 참조가 참조하고 있는 동안에도 그 인스턴스를 해제할 가능성이 있습니다. 그러므로, ARC 는 참조 인스턴스를 해제할 때 자동으로 약한 참조를 `nil` 로 설정합니다. 그리고, 약한 참조의 값은 실행 시간에 `nil` 로 바뀔 필요가 있기 때문에, 항상 옵셔널 타입의, 상수 보단, 변수로 선언합니다.

약한 참조 안의 값은, 다른 어떤 옵셔널 값인 것 같이, 존재를 검사할 수 있으며, 더 이상 존재하지 않는 무효한 인스턴스의 참조로 끝나는 건 절대 없을 겁니다.

> ARC 가 약한 참조를 `nil` 로 설정할 땐 속성 관찰자 (property observers)[^property-observers] 를 호출하지 않습니다.

아래 예제는 위의 `Person` 및 `Apartment` 예제와 완전히 똑같지만, 한 가지 중요한 차이점이 있습니다. 이번에는, `Apartment` 타입의 `tenat` 속성을 약한 참조로 선언한다는 겁니다:

```swift
class Person {
  let name: String
  init(name: String) { self.name = name }
  var apartment: Apartment?
  deinit { print("\(name) is being deinitialized") }
}

class Apartment {
  let unit: String
  init(unit: String) { self.unit = unit }
  weak var tenant: Person?
  deinit { print("Apartment \(unit) is being deinitialized") }
}
```

(`john` 과 `unit4A` 라는) 두 변수의 강한 참조와 두 인스턴스 사이의 연결 고리는 이전 처럼 생성합니다:

```swift
var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john
```

두 인스턴스를 서로 이은 참조는 이제 이렇게 보입니다:

![Weak Reference](/assets/Swift/Swift-Programming-Language/Automatic-Reference-Counting-weak-reference.jpg)

`Person` 인스턴스에는 여전히 `Apartment` 인스턴스로의 강한 참조가 있지만, `Apartment` 인스턴스에는 이제 `Person` 인스턴스로의 _약한 (weak)_ 참조가 있습니다. 이는 `nil` 을 설정하여 `john` 변수가 쥔 강한 참조를 끊을 때, `Person` 인스턴스로의 강한 참조는 더 이상은 없다는, 의미입니다:

```swift
john = nil
// "John Appleseed is being deinitializaed" 를 인쇄함
```

`Person` 인스턴스로의 강한 참조가 더 이상 없기 때문에, 이를 해제하고 `tenant` 속성은 `nil` 로 설정합니다:

![Weak Reference nil](/assets/Swift/Swift-Programming-Language/Automatic-Reference-Counting-weak-nil.jpg)

유일하게 남은 `Apartment` 인스턴스로의 강한 참조는 `unit4A` 변수에 있는 겁니다. _그 (that)_ 강한 참조를 끊으면, `Apartment` 인스턴스로의 강한 참조도 더 이상 없습니다:

```swift
unit4A = nil
// "Apartment 4A is being deinitialized" 를 인쇄함
```

`Apartment` 인스턴스로의 강한 참조가 더 이상 없기 때문에, 이것도 해제합니다:

![Weak Reference deallocated](/assets/Swift/Swift-Programming-Language/Automatic-Reference-Counting-weak-deallocated.jpg)

> 쓰레기 수집 (gabage collection)[^gabage-collection] 을 사용하는 시스템에선, 약한 포인터 (weak pointers) 를 사용하여 단순 임시 저장 구조 (simple caching mechanism) 을 구현할 때가 있는데 이는 강한 참조가 없는 객체는 메모리 압력 (memory pressure) 이 쓰레기 수집을 발동할 때만 해제되기 때문입니다. 하지만, ARC 에선, 마지막 강한 참조를 제거하자마자 곧바로 값을 해제하므로, 그런 용도론 약한 참조가 적합하지 않습니다.[^ARC-unsuitable-caching-mechanism]

#### Unowned References (소유하지 않는 참조)

약한 참조와 같이, _소유하지 않는 참조 (unowned reference)_ 는 자신이 참조한 인스턴스를 강하게 쥐지 않습니다. 하지만, 약한 참조와 달리, 소유하지 않는 참조는 다른 인스턴스와 수명이 똑같거나 더 길 때 사용합니다. 소유하지 않는 참조라고 지시하려면 속성이나 변수 선언 앞에 `unowned` 키워드를 두면 됩니다.

약한 참조와 달리, 소유하지 않는 참조엔 값이 항상 있을 거라고 예상합니다. 그 결과, 소유하지 않는 값으로 표시하면 이를 옵셔널로 만들지 않으며, ARC 는 소유하지 않는 참조의 값을 절대 `nil` 로 설정하지 않습니다.

> 참조가 _항상 (always)_ 해제되지 않은 인스턴스를 참조하는게 확실할 때만 소유하지 않는 참조를 사용합니다.
>
> 그 인스턴스를 해제한 후에 소유하지 않는 참조의 값에 접근하려 하면, 실행시간 에러를 가질겁니다.

다음 예제는, `Customer` 와 `CreditCard` 라는, 두 개의 클래스를 정의하는데, 이는 은행 고객 및 그 고객의 신용 카드를 모델링합니다. 이 두 클래스는 각각 다른 클래스의 인스턴스를 속성으로 저장합니다. 이 관계는 잠재적으로 강한 참조 순환을 생성할 수도 있습니다.

`Customer` 와 `CreditCard` 사이의 관계는 위에 있는 약한 참조 예제의 `Apartment` 와 `Person` 사이의 관계와 살짝 다릅니다. 이 데이터 모델에서, 고객에겐 신용 카드가 있을 수도 없을 수도 있지만, 신용 카드는 고객과 _항상 (always)_ 결합되어 있을 겁니다. `CreditCard` 인스턴스는 절대 자신이 참조한 `Customer` 보다 오래 살지 않습니다. 이를 나타내기 위해, `Customer` 클래스엔 옵셔널 `card` 속성이 있지만, `CreditCard` 클래스엔 소유하지 않는 (그리고 옵셔널-아닌) `customer` 속성이 있습니다.

더 나아가, `number` 값과 `custom` 인스턴스를 자신의 `CreditCard` 초기자에 전달해야 _만 (only)_ 새로운 `CreditCard` 인스턴스를 생성할 수 있습니다. 이는 `CreditCard` 인스턴스를 생성할 때 `CreditCard` 인스턴스와 `customer` 인스턴스가 항상 결합된다는 걸 보장합니다.

신용 카드엔 고객이 항상 있을거기 때문에, 자신의 `customer` 인스턴스를 소유하지 않는 참조로 정의하여, 강한 참조 순환을 피합니다:

```swift
class Customer {
  let name: String
  var card: CreditCard?
  init(name: String) {
    self.name = name
  }
  deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
  let number: UInt64
  unowned let customer: Customer
  init(number: UInt64, customer: Customer) {
    self.number = number
    self.customer = customer
  }
  deinit { print("Card #\(number) is being deinitialized") }
}
```

> `CreditCard` 클래스의 `number` 속성은 `Int` 보단 `UInt64` 타입으로 정의하여, `number` 속성의 용량이 32-비트 및 64-비트 시스템 양 쪽에서 16-자리 카드 번호를 저장하기에 충분히 크도록 보장합니다.

이 다음 코드 조각은 `john` 이라는 옵셔널 `Customer` 변수를 정의하는데, 이를 사용하여 특정 고객으로의 참조를 저장할 겁니다. 이 변수는, 옵셔널인 덕에, 'nil' 이라는 초기 값을 가집니다:

```swift
var john: Customer?
```

이제 `Customer` 인스턴스를 생성하고, 이를 사용하여 새로운 `CreditCard` 인스턴스를 그 고객의 `card` 속성으로 초기화하고 할당할 수 있습니다:

```swift
john = Customer(name: "John Appleseed")
john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)
```

이제 두 인스턴스를 이은 후의, 참조는 이렇게 보입니다:[^unowned-reference]

![Unowned Reference](/assets/Swift/Swift-Programming-Language/Automatic-Reference-Counting-unowned-reference.jpg)

이제 `Customer` 인스턴스엔 `CreditCard` 인스턴스로의 강한 참조가 있고, `CreditCard` 인스턴스엔 `Customer` 인스턴스로의 소유하지 않는 참조가 있습니다.

소유하지 않는 `customer` 참조 때문에, `john` 변수가 쥔 강한 참조를 끊을 때, `Customer` 인스턴스로의 강한 참조는 더 이상 없습니다:

![Unowned Reference Break](/assets/Swift/Swift-Programming-Language/Automatic-Reference-Counting-unowned-break.jpg)

`Customer` 인스턴스로의 강한 참조가 더 이상 없기 때문에, 이를 해제합니다. 이게 발생한 후엔, `CreditCard` 인스턴스로의 강한 참조도 더 이상 없으므로, 이것도 해제합니다:

```swift
john = nil
// "John Appleseed is being deinitialized" 를 인쇄함
// "Card #1234567890123456 is being deinitialized" 를 인쇄함
```

위 최종 코드 조각은 `john` 변수를 `nil` 로 설정한 후엔 `Customer` 인스턴스와 `CreditCard` 인스턴스 정리자 둘 다 자신의 "정리 (deinitialized)" 메시지를 인쇄한다는 걸 보여줍니다. 

> 위 예제는 소유하지 않는 참조를 _안전하게 (safe)_ 사용하는 방법을 보여줍니다. 스위프트는 실행 시간 안전성 검사를 못하게 할 필요가 있는 경우-예를 들어, 성능상의 이유-등을 위해 _안전하지 않게 (unsafe)_ 소유하지 않는 참조도 제공합니다. 모든 안전하지 않은 연산 처럼, 그 코드의 안전성 검사는 자신이 직접 책임져야 합니다.
>
> 안전하지 않게 소유하지 않는 참조라고 지시하려면 `unowned(unsafe)` 라고 작성하면 됩니다. 자신이 참조한 인스턴스를 해제한 후에 안전하지 않게 소유하지 않는 참조에 접근하려 하면, 프로그램은 인스턴스였던 곳의 메모리에 접근하려고 할 것인데, 이는 안전하지 않은 연산입니다.

#### Unowned Optional References (소유하지 않는 옵셔널 참조)

클래스로의 옵셔널 참조를 소유하지 않는 걸로 표시할 수 있습니다. ARC 소유권 모델 (ARC ownership model) 관점에선, 동일한 상황에서 소유하지 않는 옵셔널 참조와 약한 참조 둘 다 사용할 수 있습니다. 차이점은 소유하지 않는 옵셔널 참조를 사용할 땐, 항상 유효한 객체를 참조하고 있는지 또는 `nil` 로 설정한게 확실한지 직접 책임진다는 점입니다.

학교에서 한 특별한 학과 (department) 가 제안한 교육 과정 (courses) 을 추적하는 예제는 이렇습니다:

```swift
class Department {
  var name: String
  var courses: [Course]
  init(name: String) {
    self.name = name
    self.courses = []
  }
}

class Course {
  var name: String
  unowned var department: Department
  unowned var nextCourse: Course?
  init(name: String, in department: Department) {
    self.name = name
    self.department = department
    self.nextCourse = nil
  }
}
```

`Department` 는 학과가 제안한 각각의 교육 과정으로의 강한 참조를 유지합니다. ARC 소유권 모델에선, 학과가 자신의 교육 과정을 소유합니다. `Course` 엔 두 개의 소유하지 않는 참조가 있으며, 하나는 학과로 향하고 다른 하나는 학생이 그 다음 들어야 할 교육 과정으로 향하는데; 교육 과정은 이 두 객체 중 어느 것도 소유하지 않습니다. 모든 교육 과정은 어떠한 학과의 일부라서 `department` 속성은 옵셔널이 아닙니다. 하지만, 일부 교육 과정엔 뒤따라서 추천할 교육 과정이 없기 때문에, `nextCourse` 속성은 옵셔널입니다.

이 클래스들을 사용한 예제는 이렇습니다:

```swift
let department = Department(name: "Horticulture")

let intro = Course(name: "Survey of Plants", in: department)
let intermediate = Course(name: "Growing Common Herbs", in: department)
let advanced = Course(name: "Caring for Tropical Plants", in: department)

intro.nextCourse = intermediate
intermediate.nextCourse = advanced
department.courses = [intro, intermediate, advanced]
```

위 코드는 한 학과 및 그의 세 교육 과정을 생성합니다. 입문 (intro) 및 중급 (intermediate) 둘 다 그 다음으로 제안할 교육 과정을 자신의 `nextCourse` 속성에 저장하는데, 학생이 이걸 완료한 후에 들어야 할 교육 과정에 대한 소유하지 않는 옵셔널 참조를 유지합니다.

![Unowned Optional Reference](/assets/Swift/Swift-Programming-Language/Automatic-Reference-Counting-unowned-optional-reference.png)

'소유하지 않는 옵셔널 참조' 는 '포장한 (wraps)[^wraps] 클래스' 의 인스턴스를 강하게 쥐지 않아서, 'ARC' 가 인스턴스를 해제하는 것을 막지 않습니다. 이는, '소유하지 않는 옵셔널 참조' 가 `nil` 이 될 수 있다는 것만 제외하면, ARC 하에서 '소유하지 않는 참조' 가 하는 것과 똑같이 동작합니다.

'옵셔널-아닌 소유하지 않는 참조' 와 마찬가지로, `nextCourse` 가 항상 아직 해제되지 않은 '교과 과정' 을 참조하고 있다는 보장에 대한 책임은 직접 져야 합니다. 이 경우, 예를 들어, `department.courses` 에서 '교과' 를 삭제할 때 다른 '교과' 가 가지고 있을 수 있는 자신에 대한 참조도 제거할 필요가 있습니다.

> 옵셔널 값의 실제 타입은, 스위프트 표준 라이브러리에 있는, `Optional` 입니다. 하지만, 값 타입을 `unowned` 로 표시할 수 없다는 규칙에서 옵셔널은 예외입니다.[^unowned-exception]
>
> 클래스를 포장한 옵셔널은 '참조 카운팅' 을 사용하지 않으므로, 옵셔널에 대한 '강한 참조' 를 유지할 필요가 없습니다.

#### Unowned References and Implicitly Unwrapped Optional Properties ('소유하지 않는 참조' 와 '암시적으로 포장 푸는 옵셔널 속성')

위에 있는 '약한' 그리고 '소유하지 않는 참조' 에 대한 예제는 '강한 참조 순환' 을 끊을 필요가 있는 더 일반적인 시나리오 중 두 가지를 다루고 있습니다.

`Person` 과 `Apartment` 예제는 두 속성이, 둘 다 `nil` 을 허용하면서, '강한 참조 순환' 을 유발할 수 있는 상황을 보여줍니다. 이 시나리오에 대한 최상의 해법은 '약한 참조' 입니다.

`Customer` 와 `CreditCard` 예제는 `nil` 을 허용하는 한 속성과 `nil` 일 수 없는 또 다른 속성이 '강한 참조 순환' 유발할 수 있는 상황을 보여줍니다. 이 시나리오에 대한 최상의 해법은 '소유하지 않는 참조' 입니다.

하지만, 속성 _둘 다 (both)_ 항상 값을 가져야 하며, 초기화를 한 번 완료하고 나면 어느 속성도 `nil` 이 되면 안되는, 세 번째 시나리오도 있습니다. 이 시나리오에서는, 한 클래스에 대한 '소유하지 않는 속성' 과 다른 클래스에 대한 '암시적으로 포장 푸는 옵셔널 속성' 을 조합하는 것이 유용합니다.

이는 초기화를 한 번 하고 나면, '참조 순환' 을 피하면서도, 두 속성 모두 ('옵셔널 포장 풀기' 없이) 직접 접근할 수 있게 해줍니다. 이번 절은 그런 관계를 설정하는 방법을 보입니다.

아래 예제는, 각각 서로의 클래스 인스턴스를 저장하는, `Country` 와 `City` 라는, 두 클래스를 정의합니다. 이 '데이터 모델' 에서, 모든 국가는 반드시 항상 수도를 가지고 있으며, 모든 도시는 반드시 항상 국가에 속해 있습니다. 이를 표현하기 위해, `Country` 클래스는 `capitalCity` 속성을 가지며, `City` 클래스는 `country` 속성을 가집니다:

```swift
class Country {
  let name: String
  var capitalCity: City!
  init(name: String, capitalName: String) {
    self.name = name
    self.capitalCity = City(name: capitalName, country: self)
  }
}

class City {
  let name: String
  unowned let country: Country
  init(name: String, country: Country) {
    self.name = name
    self.country = country
  }
}
```

두 클래스 사이의 '상호 의존성 (interdependency)' 을 설정하기 위해, `City` 초기자는 `Country` 인스턴스를 취하며, 이 인스턴스를 `country` 속성에 저장합니다.

`City` 초기자는 `Country` 초기자 안에서 호출됩니다. 하지만, [Two-Phase Initialization (2-단계 초기화)]({% post_url 2016-01-23-Initialization %}#two-phase-initialization-2-단계-초기화) 에서 설명한 것처럼, `Country` 초기자는 새로운 `Country` 인스턴스를 온전히 초기화하기 전까지 `self` 를 `City` 초기자에 전달할 수 없습니다.

이 '필수 조건' 에 대처하려면, `Country` 의 `capitalCity` 속성을, (`City!` 라고) '타입 보조 설명' 끝에 느낌표를 붙여 지시하는, '암시적으로 포장을 푸는 옵셔널 속성' 으로 선언합니다. 이는 `capitalCity` 속성이, 다른 옵셔널과 똑같이, `nil` 이라는 기본 값을 가지지만, [Implicitly Unwrapped Optionals (암시적으로 포장 푸는 옵셔널)]({% post_url 2016-04-24-The-Basics %}#implicitly-unwrapped-optionals-암시적으로-포장-푸는-옵셔널) 에서 설명한 것처럼 값의 포장을 풀 필요 없이 접근할 수 있다는 의미입니다.

`capitalCity` 가 '기본 `nil` 값' 을 가지기 때문에, 새로운 `Country` 인스턴스는 `Country` 인스턴스가 초기자에서 `name` 속성을 설정하자 마자 온전히 초기화된다고 고려합니다. 이는 `name` 속성을 설정하자 마자 `Country` 초기자가 '암시적인 `self` 속성' 을 참조하고 전달하기 시작할 수 있다는 의미입니다. 그럼으로써 `Country` 초기자가 자신의 `capitalCity` 속성을 설정할 때 `City` 초기자를 위한 매개 변수로 `Country` 초기자가 `self` 를 전달할 수 있습니다.

이 모든 것은, '강한 참조 순환' 의 생성 없이, `Country` 와 `City` 인스턴스를 단일 구문으로 생성할 수 있으며, 느낌표를 사용하여 옵셔널 값의 포장을 풀 필요 없이, `capitalCity` 속성에 직접 접근할 수 있다는 것을 의미합니다:

```swift
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")
// "Canada's capital city is called Ottawa" 를 인쇄합니다.
```

위 예제에서, '암시적으로 포장을 푸는 옵셔널' 을 사용하는 것은 '2-단계 클래스 초기자' 의 모든 '필수 조건' 을 만족한다는 의미입니다. `capitalCity` 속성은 초기화를 한 번 완료하고 나면, '강한 참조 순환' 을 피하면서도, '옵셔널-아닌 값' 처럼 사용하고 접근할 수 있습니다.

### Strong Reference Cycles for Closures (클로저에 대한 강한 참조 순환)

위에서 두 클래스 인스턴스 속성이 서로에 대한 '강한 참조' 를 쥐고 있을 때 '강한 참조 순환' 이 생성될 수 있는 방법을 살펴 봤습니다. 이 강한 참조 순환을 끊기 위해 '약한 참조' 와 '소유하지 않는 참조' 를 사용하는 방법도 살펴 봤습니다.

'강한 참조 순환' 은 클로저를 클래스 인스턴스의 속성에 할당한 다음, 해당 클로저 본문에서 인스턴스를 '붙잡는 (captures)' 경우에도 일어납니다. 이 '붙잡음' 은, `self.someProperty` 같이, 클로저 본문이 인스턴스의 속성에 접근하기 때문에, 또는 `self.someMethod()` 같이, 클로저가 인스턴스에 대한 메소드를 호출하기 때문에 일어날 수도 있습니다. 어느 경우든, 이 접근은 클로저가 `self` 를 "붙잡도록 (capture)" 하여, '강한 참조 순환' 을 생성합니다.

이 '강한 참조 순환' 은 클로저가, 클래스 처럼, _참조 타입 (reference type)_ 이기 때문에 일어나는 것입니다. 클로저를 속성에 할당할 때는, 해당 클로저에 대한 _참조 (reference)_ 를 할당하고 있는 것입니다. 본질적으로, 위와 똑같은 문제-두 개의 '강한 참조' 가 서로를 살아 있게 유지한다는 것-입니다. 하지만, 이번에는, 두 클래스 인스턴스라기 보다는, 클래스 인스턴스와 클로저가 서로를 살아 있게 유지합니다.

스위프트는 이 문제에 대해, _클로저가 붙잡을 목록 (closure capture list)_ 이라는, 우아한 해법을 제공합니다. 하지만, '클로저가 붙잡을 목록' 으로 '강한 참조 순환' 을 끊는 방법을 배우기 전에, 그런 순환을 유발할 수 있는 방법을 이해햐는 것이 유용합니다.

아래 예제는 `self` 를 참조하는 클로저가 사용될 때 '강한 참조 순환' 을 생성할 수 있는 방법을 보여줍니다. 이 예제는, HTML 문서에 있는 개별 원소에 대한 간단한 모델을 제공하는, `HTMLElement` 라는 클래스를 정의합니다:

```swift
class HTMLElement {
  let name: String
  let text: String?

  lazy var asHTML: () -> String = {
    if let text = self.text {
      return "<\(self.name)>\(text)</\(self.name)>"
    } else {
      return "<\(self.name) />"
    }
  }

  init(name: String, text: String? = nil) {
    self.name = name
    self.text = text
  }

  deinit {
    print("\(name) is being deinitialized")
  }
}
```

`HTMLElement` 클래스는, '제목 원소' 일 때는 `"h1"`, '문단 원소' 일 때는 `"p"`, '줄 끊음 원소' 일 때는 `"br"` 이라고 하는, 원소 이름을 지시하는, `name` 속성을 정의합니다. `HTMLElement` 는 해당 HTML 원소 안에서 그리는 '문장 (text)' 을 표현할 문자열을 설정하기 위해 '옵셔널 `text` 속성' 도 정의합니다.

이 단순한 두 속성에 더하여, `HTMLElement` 클래스는 `asHTML` 이라는 '느긋한 (lazy) 속성'[^lazy] 도 정의합니다. 이 속성은 `name` 과 `text` 를 'HTML 문자열 조각' 으로 조합하는 클로저를 참조합니다. `asHTML` 속성은 `() -> String`, 또는 "매개 변수를 취하지 않고, `String` 값을 반환하는 함수" 타입 입니다.

기본적으로, `asHTML` 속성에는 'HTML 꼬리표 (tag)' 의 '문자열 표현' 을 반환하는 클로저를 할당합니다. 이 '꼬리표' 는 `text` 가 존재하면 '옵셔널 `text` 값' 을 담고, 존재하지 않으면 아무 내용물도 담고 있지 않습니다. '문단 원소' 일 때는, `text` 속성이 `"some text"` 인지 `nil` 인지에 따라, 클로저가 `"<p>some text</p>"` 나 `<p />` 를 반환할 것입니다.

`asHTML` 속성의 이름과 사용법은 인스턴스 메소드와 어느 정도 비슷합니다. 하지만, `asHTML` 은 '인스턴스 메소드' 보다는 '클로저 속성' 이기 때문에, 특별한 HTML 원소에 대하여 'HTML 그림 방식 (rendering)' 을 바꾸고 싶으면, `asHTML` 속성 기본 값을 '사용자 정의 클로저' 로 대체할 수 있습니다.

예를 들어, 비어 있는 'HTML 꼬리표' 를 반환하지 못하도록, `text` 속성이 `nil` 이면 기본 문장을 부여하는 클로저를 `asHTML` 속성에 설정할 수 있을 것입니다:

```swift
let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
  return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
// "<h1>some default text</h1>" 를 인쇄합니다.
```

> `asHTML` 속성은,  원소가 실제로 어떤 HTML 출력 대상에 대한 문자열 값으로 그려야 할 때에만 필요하기 때문에, '느긋한 (lazy) 속성' 이라고 선언합니다. `asHTML` 이 '느긋한 속성' 이라는 사실은, 초기화를 완료하여 `self` 가 존재함을 알기 전까지 '느긋한 속성' 에 접근하지 않을 것이기 때문에, '기본 클로저' 에서 `self` 를 참조할 수 있다는 의미입니다.s

`HTMLElement` 클래스는, `name` 인자와 (원할 경우) `text` 인자를 취하여 새로운 원소를 초기화하는, '단일 초기자' 를 제공합니다. 클래스는, `HTMLElement` 인스턴스를 해제할 때 보여줄 메시지를 인쇄하는, '정리자' 도 정의합니다:

다음은 `HTMLElement` 클래스를 사용하여 새로운 인스턴스를 생성하고 출력하는 방법입니다:

```swift
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// "<p>hello, world</p>" 를 인쇄합니다.
```

> 위에 있는 `paragraph` 변수를 _옵셔널 (optional)_ `HTMLElement` 로 정의하여, '강한 참조 순환' 이 있음을 실증하고자 아래에서 `nil` 로 설정할 수 있습니다.

불행하게도, 위에서 작성한, `HTMLElement` 클래스는 `HTMLElement` 인스턴스와 자신의 '기본 `asHTML` 값' 에 사용할 클로저 사이에 '강한 참조 순환' 을 생성합니다. 다음은 '순환' 을 보인 것입니다:

![Strong Reference Cycle with Closures](/assets/Swift/Swift-Programming-Language/Automatic-Reference-Counting-closure-strong.jpg)

인스턴스의 `asHTML` 속성은 클로저에 대한 '강한 참조' 를 쥐고 있습니다. 하지만, 클로저가 자신의 본문에서 (`self.name` 과 `self.text` 참조 방식으로) `self` 를 참조하기 때문에, 클로저는 'self' 를 _붙잡게 (capture)_ 되며, 이는 다시 `HTMLElement` 인스턴스에 대한 '강한 참조' 를 쥔다는 의미입니다. 둘 사이에 '강한 참조 순환' 을 생성합니다. (클로저의 '값 붙잡기' 에 대한 더 많은 정보는, [Capturing Values (값 붙잡기)]({% post_url 2020-03-03-Closures %}#capturing-values-값-붙잡기) 를 참고하기 바랍니다.)

> 클로저가 `self` 를 여러 번 참조할지라도, `HTMLElement` 인스턴스에 대한 '강한 참조' 하나만을 붙잡습니다.

`paragraph` 변수를 `nil` 로 설정하여 `HTMLElement` 인스턴스에 대한 '강한 참조' 를 끊는 경우, '강한 참조 순환' 때문에, `HTMLElement` 인스턴스와 클로저 어느 쪽도 해제되지 않습니다:

```swift
paragraph = nil
```

'`HTMLElement` 정리자' 에 있는 메시지는 인쇄되지 않으며, 이는 `HTMLElement` 인스턴스가 해제되지 않음을 보인다는 것을 기억하기 바랍니다.

### Resolving Strong Reference Cycles for Closures (클로저에 대한 강한 참조 순환 해결하기)

클로저와 클래스 인스턴스 사이의 '강한 참조 순환' 은 클로저의 정의에서 _붙잡을 목록 (capture list)_ 을 정의함으로써 해결합니다. '붙잡을 목록' 은 클로저의 본문에서 하나 이상의 '참조 타입' 을 붙잡을 때 사용할 규칙을 정의합니다. 두 클래스 인스턴스 사이의 '강한 참조 순환' 에서 처럼, 각각의 붙잡을 참조를 '강한 참조' 보다는 '약한 참조' 나 '소유하지 않는 참조' 로 선언합니다. '약한' 또는 '소유하지 않는 참조' 를 적절히 선택하는 것은 다른 코드들 사이의 관계에 달려 있습니다.

> 스위프트는 클로저 내에서 `self` 의 멤버를 참조할 때마다 (`someProperty` 나 `someMethod()` 보다는) `self.someProperty` 나 `self.someMethod()` 라고 작성하도록 요구합니다. 이는 실수로 `self` 를 붙잡을 가능성이 있음을 떠올리도록 도와줍니다.

#### Defining a Capture List (붙잡을 목록 정의하기)

'붙잡을 목록' 에 있는 각각의 항목은 (`self` 같은) 클래스 인스턴스나 (`delegate = self.delegate` 같은) 값으로 초기화된 변수에 대한 참조를 가진 `weak` 또는 `unowned` 키워드 '쌍 (pairing)' 입니다. 이 쌍들은, 쉼표로 구분된, 한 쌍의 대괄호 안에 작성합니다.

클로저가 매개 변수 목록과 반환 타입을 제공하는 경우 '붙잡을 목록' 을 그 앞에 둡니다:

```swift
lazy var someClosure = {
  [unowned self, weak delegate = self.delegate]
  (index: Int, stringToProcess: String) -> String in
  // 클로저 본문은 여기에 둡니다.
}
```

클로저가 매개 변수 목록이나 반환 타입을 상황으로 추론할 수 있기 때문에 지정하지 않는 경우, '붙잡을 목록' 을 클로저 맨 앞에 두며, 그 뒤로 `in` 키워드가 따라옵니다:[^capture-list-place]

```swift
lazy var someClosure = {
  [unowned self, weak delegate = self.delegate] in
  // 클로저 본문은 여기에 둡니다.
}
```

#### Weak and Unowned References ('약한 참조' 와 '소유하지 않는 참조')

클로저와 그것이 붙잡는 인스턴스가 항상 서로를 참조하며, 항상 동시에 해제될 때는, 클로저가 '소유하지 않는 참조' 로 붙잡는다고 정의합니다.

이와 대조적으로, '붙잡은 참조' 가 미래의 어느 시점에 `nil` 이 될 수도 있을 때는 '약한 참조' 로 붙잡는다고 정의합니다. '약한 참조' 는 항상 옵셔널 타입이며, 참조하는 인스턴스가 해제될 때 자동으로 `nil` 이 됩니다. 이는 클로저 본문에서 '존재 (existence)' 를 검사할 수 있게 해줍니다.[^weak-capture-nil]

> '붙잡은 참조' 가 절대로 `nil` 이 되지 않을 거라면, '약한 참조' 보다는, 항상 '소유하지 않는 참조' 로 붙잡는 것이 좋습니다.

위 [Strong Reference Cycles for Closures (클로저에 대한 강한 참조 순환)](#strong-reference-cycles-for-closures-클로저에-대한-강한-참조-순환) 의 `HTMLElement` 예제에 있는 '강한 참조 순환' 을 해결하는 데 사용하기에는 '소유하지 않는 참조' 가 적절한 방법입니다. 다음은 순환을 피하도록 `HTMLElement` 클래스를 작성하는 방법입니다:

```swift
class HTMLElement {
  let name: String
  let text: String?

  lazy var asHTML: () -> String = {
    [unowned self] in
    if let text = self.text {
      return "<\(self.name)>\(text)</\(self.name)>"
    } else {
      return "<\(self.name) />"
    }
  }

  init(name: String, text: String? = nil) {
    self.name = name
    self.text = text
  }

  deinit {
    print("\(name) is being deinitialized")
  }
}
```

이 `HTMLElement` 구현은, `asHTML` 클로저에 '붙잡을 목록' 을 추가한 것을 빼면, 이전 구현과 모든 점에서 똑같습니다. 이 경우, '붙잡을 목록' 은, "'강한 참조' 보다는 '소유하지 않는 참조' 로 'self' 를 붙잡을 것" 을 의미하는, `[unowned self]` 입니다.  

이전 처럼 `HTMLElement` 인스턴스를 생성하고 출력할 수 있습니다:

```swift
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
// "<p>hello, world</p>" 를 인쇄합니다.
```

다음은 '붙잡을 목록' 이 제자리에 있을 때의 '참조' 를 보인 것입니다:

![Resloving of Strong Reference Cycle with Closures](/assets/Swift/Swift-Programming-Language/Automatic-Reference-Counting-closure-resolved.jpg)

이번에는, 클로저가 `self` 를 '소유하지 않는 참조' 로 붙잡으며, 붙잡은 `HTMLElement` 인스턴스를 강하게 쥐지 않습니다. `paragraph` 변수에 있는 '강한 참조' 를 `nil` 로 설정하면, 아래 예제에서 정리자 메시지를 인쇄하는 것으로 볼 수 있는 것처럼, `HTMLElement` 인스턴스를 해제합니다:

```swift
paragraph = nil
// "p is being deinitialized" 를 인쇄합니다.
```

'붙잡을 목록' 에 대한 더 많은 정보는, [Capture Lists (붙잡을 목록)]({% post_url 2020-08-19-Expressions %}#capture-lists-붙잡을-목록) 를 참고하기 바랍니다.

### 다음 장

[Memory Safety (메모리 안전성) > ]({% post_url 2020-04-07-Memory-Safety %})

### 참고 자료

[^Automatic-Reference-Counting]: 이 글에 대한 원문은 [Automatic-Reference-Counting](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html) 에서 확인할 수 있습니다.

[^ARC-Objective-C]: 원문 자체가 '애플 개발자 문서' 로 가는 링크입니다. '오브젝티브-C' 개발자가 아니라면 해당 문서를 직접 볼 필요 까지는 없습니다.

[^reference-type]: '참조 카운팅 (reference counting)' 은 스위프트의 메모리 관리 방법인데, 여기서 '메모리 관리' 란 '동적 메모리를 자동으로 할당하고 해제하는 것' 을 의미합니다. 프로그래밍에서 '동적 메모리' 의 할당, 해제가 일어나는 곳을 '자유 저장 공간 (free store; 또는 heap)' 이라고 하며, '참조' 라는 말은 '자유 저장 공간' 에 할당된 메모리 영역을 '참조한다 (refer to)' 것에서 유래한 말입니다. 구조체나 열거체 같은 '값 타입 (value type)' 은 '자유 저장 공간' 이 아닌 '정적 메모리 공간' 인 '스택 (stack)' 에 생기므로 메모리 관리 대상이 아닙니다. 이에 대한 더 자세한 정보는, 위키피디아의 'Memory management' 항목에 있는 [Dynamic memory allocation](https://en.wikipedia.org/wiki/Memory_management#DYNAMIC) 부분과 [Stack-based memory allocation](https://en.wikipedia.org/wiki/Stack-based_memory_allocation) 항목을 참고하기 바랍니다.

[^stored-constant-property]: 원문은 'stored constant property' 라서 직역하면 '저장 상수 속성' 이지만, 첵의 다른 곳에서 'constant stored property' 라는 말을 더 많이 쓰고 있어서, 통일성을 위해 '상수 저장 속성' 이라고 옮깁니다. 사실 '저장 상수 속성' 이나 '상수 저장 속성' 이나 의미는 같은 것인데, 우리 말로 옮겼을 때 '상수 저장 속성' 이 좀 더 자연스럽게 느껴집니다.

[^deinitializer]: '정리자 (deinitializer)' 에 대한 더 자세한 정보는, [Deinitialization (뒷정리)]({% post_url 2017-03-03-Deinitialization %}) 장을 참고하기 바랍니다.

[^multiple-references]: 여기서 '다중 참조 (multiple references)' 는 한 인스턴스를 여러 개의 변수에서 동시에 참조하고 있는 상태를 말합니다.

[^property-observers]: '속성 관찰자 (property observers)' 에 대한 더 자세한 정보는, [Properties (속성)]({% post_url 2020-05-30-Properties %}) 장에 있는 [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 부분을 참고하기 바랍니다.

[^gabage-collection]: '쓰레기 수집 (gabage collection)' 에 대한 더 자세한 정보는, 위키피디아의 [Garbage collection (computer science)](https://en.wikipedia.org/wiki/Garbage_collection_(computer_science)) 항목과 [쓰레기 수집 (컴퓨터 과학)](https://ko.wikipedia.org/wiki/쓰레기_수집_(컴퓨터_과학)) 항목을 참고하기 바랍니다.

[^ARC-unsuitable-caching-mechanism]: ARC 에선 약한 참조를 '단순 임시 저장 구조 (simple caching mechanism)' 를 만드는 용도로는 사용하지 않는다는 의미입니다.

[^unowned-reference]: 이 그림을 보면 '소유하지 않는 참조 (unowned reference)' 라는 이름의 의미를 알 수 있습니다. 고객은 신용 카드를 소유하지만, 신용 카드는 고객을 소유하지 않습니다. 실제 세계에 빗대어 보면, 고객은 신용 카드를 바꿀 수 있지만, 신용 카드는 고객을 바꿀 수 없습니다. 그러므로, 외부에서 신용 카드를 직접 참조하는 변수도 없습니다.

[^wraps]: 여기서 '포장한다 (wrap)' 는 것은 값을 '옵셔널로 포장한다' 는 의미입니다. `let a: Int? = 1` 에서 `a` 는 `Optional<Int>` 타입인데, `1` 이라는 `Int` 값을 옵셔널로 포장하고 있는 것입니다. '옵셔널' 에 대한 더 자세한 내용은, [The Basics (기초)]({% post_url 2016-04-24-The-Basics %}) 장에 있는 [Optionals (옵셔널)]({% post_url 2016-04-24-The-Basics %}#optionals-옵셔널) 부분을 참고하기 바랍니다.

[^unowned-exception]: 원래 `unowned` 자체가 메모리 해제와 관련된 키워드이므로 '값 타입' 에서 사용할 일이 없습니다. 그래서 '값 타입을 `unowned` 로 표시할 수 없다' 는 규칙이 생겼는데, '값 타입이 옵셔널' 인 경우에는 `unowned` 로 표시할 수 있다고 해석할 수 있습니다.

[^lazy]: '느긋한 속성 (lazy property)' 에 대한 더 자세한 정보는, [Properties (속성)]({% post_url 2020-05-30-Properties %}) 장에 있는 [Lazy Stored Properties (느긋한 저장 속성)]({% post_url 2020-05-30-Properties %}#lazy-stored-properties-느긋한-저장-속성) 부분을 참고하기 바랍니다.

[^capture-list-place]: 사실 본문에 있는 두 경우 모두 '붙잡을 목록 (capture list)' 이 클로저 본문 가장 앞에 있습니다. 그러므로 '붙잡을 목록' 은 클로저 본문 맨 앞에 둔다고 생각하면 됩니다.

[^weak-capture-nil]: '약한 참조' 가 자동으로 `nil` 이 되므로, 해당 참조가 `nil` 인지를 검사하여 인스턴스가 존재하는지를 클로저 안에서도 확인할 수 있다는 의미입니다.
