---
layout: post
comments: true
title:  "Swift 5.2: Inheritance (상속)"
date:   2020-03-31 10:00:00 +0900
categories: Swift Language Grammar Inheritance
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html) 부분[^Inheritance]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## Inheritance (상속)

클래스는 다른 클래스의 메소드, 속성 그리고 기타 성질들을 _상속 (inherit)_ 할 수 있습니다. 한 클래스가 다른 것을 상속할 때, 상속을 받는 클래스를 _하위 클래스 (subclass)_ 라 하고, 상속을 해주는 클래스를 _상위 클래스 (superclass)_ 라고 합니다. 상속은 '클래스 (class)' 고유의 행동으로 이것이 스위프트의 다른 타입들과 차별되는 점입니다.

스위프트의 클래스는 '상위 클래스 (superclass)' 의 메소드, 속성, 그리고 첨자 연산에 접근하고 호출할 수 있으며, 그 행동을 다듬고 수정해서 해당 메소드, 속성, 그리고 첨자 연산에 대한 자기만의 '재정의 버전 (overriding version)' 을 제공할 수도 있습니다. 스위프트는 '재정의한 정의 (override definition)' 에 해당하는 상위 클래스의 정의를 검사하여 해당 '재정의 (overrides)' 가 올바른지를 확인해 줍니다.

클래스는 상속받은 속성에 '속성 관찰자 (property observers)' 도 추가할 수 있는데 이는 속성 값이 바뀔 때 알림을 받을 수 있게 해 줍니다. '속성 관찰자' 는 어떤 속성에든 추가할 수 있으며, 원래 속성이 '저장 속성 (stored property)' 이든 '계산 속성 (computed property)' 이든 상관 없습니다.

### Defining a Base Class (기본 클래스 정의하기)

어떤 클래스든 다른 클래스를 상속하지 않으면 이를 _기본 클래스 (base class)_[^base-class] 라고 합니다.

> 스위프트의 클래스는 '범용 기본 클래스 (universal base class)' 를 상속하지 않습니다. 클래스를 정의할 때 '상위 클래스' 를 지정하지 않으면 자동으로 '기본 클래스' 가 됩니다.

아래 예제는 `Vehicle` 이라는 '기본 클래스' 를 정의합니다. 이 기본 클래스는 `currentSpeed` 라는 '저장 속성 (stored property)' 을 정의하고, 기본 설정 값을 `0.0` 으로 둡니다. (추론된 속성의 타입은 `Double` 입니다) `currentSpeed` 속성의 값은 `description` 이라는 `String` 타입의 일기-전용 계산 속성에서 사용되어 차량에 대한 설명을 만들게 됩니다.

`Vehicle` 기본 클래스는 `makeNoise` 라는 메소드도 정의합니다. 이 메소드는 기본 `Vehicle` 인스턴스에서는 실제로 하는 것이 아무 것도 없지만, 나중에 `Vehicle` 의 하위 클래스에서 사용자의 목적에 맞게 바뀔 것입니다:

```swift
class Vehicle {
  var currentSpeed = 0.0
  var description: String {
    return "traveling at \(currentSpeed) miles per hour"
  }
  func makeNoise() {
    // 아무 것도 하지 않습니다 - 임의의 차량은 소음을 발생시킬 필요가 없습니다.
  }
}
```

`Vehicle` 의 새 인스턴스를 만들려면 _초기자 구문 표현 (initializer syntax)_ 을 사용하면 되며, 이는 타입 이름 뒤에 빈 괄호를 써주면 됩니다:

```swift
let someVehicle = Vehicle()
```

새 `Vehicle` 인스턴스를 만들고 나면, `description` 속성에 접근하여 차량의 현재 속도를 사람이 읽을 수 있는 형태로 출력할 수 있습니다:

```swift
print("Vehicle: \(someVehicle.description)")
// "Vehicle: traveling at 0.0 miles per hour" 를 출력합니다.
```

`Vehicle` 클래스는 임의의 차량에 공통된 성질을 정의하지만, 그 자체로는 크게 쓸모가 없습니다. 좀 더 쓸모있게 만들려면, 구체적인 차량 종류에 맞게 설명을 다듬을 필요가 있습니다.

### Subclassing (하위 클래스 만들기)

_하위 클래스 만들기 (subclassing)_ 는 기존 클래스를 기반으로 하여 새 클래스를 만드는 행동을 말합니다. '하위 클래스 (subclass)' 는 기존 클래스의 성질들을 상속한 다음, '개량 (refine)' 할 수 있습니다. 물론 하위 클래스에서 새로운 성질을 추가할 수도 있습니다.

하위 클래스가 상위 클래스를 가지고 있다고 지시하려면, 상위 클래스 앞에 하위 클래스 이름을 쓰고, 이들을 '콜론 (colon)' 으로 구분하면 됩니다:

```swift
class SomeSubclass: SomeSuperclass {
  // 여기서 하위 클래스를 정의합니다.
}
```

다음 예제는 `Vehicle` 이라는 상위 클래스로, `Bicycle` 이라는 하위 클래스를 정의합니다:

```swift
class Bicycle: Vehicle {
  var hasBasket = false
}
```

이 새로운 `Bicycle` 클래스는 `Vehicle` 의 모든 성질을 자동으로 얻으며, 이에는 `currentSpeed` 와 `description` 속성 및 `makeNoise()` 메소드 등이 있습니다.

이런 상속하는 성질들에 더하여, `Bicycle` 클래스는 새로운 '저장 속성' 인 `hasBasket` 을 정의하며, 기본 설정 값으로 `false` 를 부여합니다. (속성의 타입은 `Bool` 로 추론됩니다)

기본적으로, 새로 만들어진 `Bicycle` 인스턴스라면 어떤 것도 '바구니 (basket)' 를 가지지 않을 것입니다. 해당 인스턴스를 만들고 나면 특정 `Bicycle` 인스턴스의 `hasBasket` 속성을 `true` 로 설정하는 것이 가능합니다.

```swift
let bicycle = Bicycle()
bicycle.hasBasket = true
```

`Bicycle` 인스턴스가 상속한 `currentSpeed` 속성을 수정하는 것과, 인스턴스가 상속한 `description` 속성을 조회하는 것도 가능합니다:

```swift
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")
// "Bicycle: traveling at 15.0 miles per hour" 를 출력합니다.
```

'하위 클래스' 자체로 다시 '하위 클래스' 를 만드는 것도 가능합니다. 다음 예제는 `Bicycle` 의 하위 클래스를 만들어서 "탠덤 (tandem)" 이라는 2-인승 자전거를 만듭니다:

```swift
class Tandem: Bicycle {
  var currentNumberOfPassengers = 0
}
```

`Tandem` 은 `Bicycle` 의 모든 속성과 메소드를 상속하며, 이에 따라 `Vehicle` 의 모든 속성과 메소드 역시 상속하게 됩니다. `Tandem` 하위 클래스는 또 `currentNumberOfPassengers` 라는 새로운 '저장 속성 (stored property)' 을 추가하고 있는데, 이의 기본 설정 값은 `0` 입니다.

`Tandem` 의 인스턴스를 만들면, 새로운 속성과 상속한 속성 어떤 것이든 사용할 수 있으며, `Vehicle` 에서 상속한 읽기-전용 속성인 `description` 을 조회하는 것도 가능합니:

```swift
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
// "Tandem: traveling at 22.0 miles per hour" 를 출력합니다.
```

### Overriding (재정의하기)

'하위 클래스' 는 '인스턴스 메소드 (instance method)', '타입 메소드 (type method)', '인스턴스 속성 (instance property)', '타입 속성 (type property)', 또는 '첨자 연산 (subscript)' 을 상위 클래스에서 상속하게 놔두지 말고 따로 사용자 목적에 맞게 자신만의 구현을 제공할 수도 있습니다. 이것을 일컬어 _재정의 (overriding)_ 라고 합니다.

어떤 성질을 상속하는게 아니라 재정의하려면, 재정의할 정의 앞에 `override` 키워드를 접두사 형식으로 붙여주면 됩니다. 그렇게 하면 '재정의 (override)' 를 제공한다는 의도를 분명하게 밝힐 수 있고 또 깜박해서 해당 정의를 제공 안하는 것도 막을 수 있습니다. '재정의' 를 실수로 하게되면 예상하지 못한 동작의 원인이 되기 때문에, 코드를 컴파일할 때 `override` 키워드 없이 '재정의' 한 어떤 것도 에러로 진단합니다.

`override` 키워드는 또한 '재정의를 하는 클래스' 의 '상위 클래스' (나 그 부모 중 하나) 가 제공한 재정의에 해당하는 선언을 가지고 있는지 검사하도록 스위프트 컴파일러에게 시키는 역할도 합니다. 이런 검사를 통해 '재정의' 를 올바르게 했는지 확인할 수 있습니다.

#### Accessing Superclass Methods, Properties, and Subscripts (상위 클래스의 메소드, 속성, 그리고 첨자 연산에 접근하기)

하위 클래스에 메소드, 속성, 또는 첨자 연산의 재정의를 제공할 때, '재정의' 의 일부로 기존 상위 클래스 구현을 사용하면 유용할 때가 있습니다. 예를 들어, 기존 구현의 동작을 조금 다음거나, 기존에 상속한 변수에 수정된 값을 저장하거나 할 경우 등이 있을 수 있습니다.

이렇게 하는 것이 적절할 경우, `super` 접두사를 사용하면 메소드, 속성, 또는 첨자 연산의 '상위 클래스 버전 (superclass version)' 에 접근할 수 있습니다:

* 재정의 메소드의 구현 내에서 `super.someMethod()` 를 호출하면 `someMethod()` 라는 재정의된 메소드가 `someMethod()` 의 '상위 클래스 버전' 을 호출할 수 있습니다.
* 재정의 속성의 'getter' 나 'setter' 구현 내에서 `super.someProperty` 를 사용하면 `someProperty` 라는 재정의된 속성이 `someProperty` 의 '상위 클래스 버전' 에 접근할 수 있습니다.
* 재정의 첨자 연산의 구현 내에서 `super[someIndex]` 를 사용하면 `someIndex` 라는 재정의된 첨자 연산이 동일한 첨자 연산의 '상위 클래스 버전' 에 접근할 수 있습니다.

#### Overriding Methods (메소드 재정의하기)

상속받은 인스턴스 메소드나 상속받은 타입 메소드를 재정의하려면 하위 클래스 내에서 그 메소드의 맞춤형 구현을 제공하거나 대체 구현을 제공하면 됩니다.

다음 예제는 `Train` 이라는 `Vehicle` 의 새로운 하위 클래스를 정의하는데, 이 `Train` 은 `Vehicle` 에서 상속받은 `makeNoise()` 메소드를 재정의하고 있습니다:

```swift
class Train: Vehicle {
  override func makeNoise() {
    print("Choo Choo")
  }
}
```

`Train` 의 새 인스턴스를 만든 다음 `makeNoise()` 메소드를 호출하면, `Train` 하위 클래스 버전의 메소드가 호출되는 것을 볼 수 있습니다:

```swift
let train = Train()
train.makeNoise()
// "Choo Choo" 를 출력합니다.
```

#### Overriding Properties (속성 재정의하기)

'상속받은 인스턴스 속성' 이나 '상속받은 타입 속성' 을 재정의하려면 그 속성에 대한 'getter' 와 'setter' 를 사용자 목적에 맞게 제공하면 되는데, 이 외에도 '속성 관찰자 (property observers)' 를 추가하여 '상속하는 속성' 이 '실제 속성 값' 의 변화를 관찰하도록 할 수도 있습니다.

**Overriding Property Getters and Setters (속성의 Getters 와 Setters 재정의하기)**

사용자 정의 'getter' (그리고, 적절한 경우 'setter' 까지) 를 제공하여 상속받은 속성은 _어느 것이든 (any)_ 재정의할 수 있는데, 이 때 원 소스에서 상속받은 속성의 구현이 '저장 속성' 으로 되었든 '계산 속성' 으로 되었든 상관이 없습니다. 상속받은 속성의 본질이 '저장 속성' 인지 '계산 속성' 인지는 '하위 클래스' 에서 알 수가 없습니다-단지 이 상속받은 속성의 이름과 타입이 어떤 것인지만 알 수 있습니다. 재정의하려면 항상 그 속성의 이름과 타입 두 가지 모두 다시 반드시 알려줘야 하며, 이는 컴파일러가 이 '재정의' 에 해당하는 '상위 클래스' 의 속성을 검사하려면 이름과 타입이 같은지를 보고 검사하게 되기 때문입니다.

하위 클래스에서 속성을 재정의하면서 'getter' 와 'setter' 를 모두 제공하면 '상속받은 읽기-전용 속성 (inherited read-only property)' 을 '읽기-쓰기 혼용 속성 (read-write property)' 로 나타낼 수 있습니다. 하지만, '읽기-쓰기 혼용 속성' 을 '읽기-전용 속성' 으로 나타내는 것은 불가능 합니다.[^read-write-to-read-only]

> 속성을 '재정의' 하면서 'setter (설정자)' 를 제공하는 경우, 반드시 그 재정의를 위한 'getter (획득자)' 도 제공해야 합니다. 'overriding getter (재정의하는 획득자)' 내에서 상속받은 속성의 값을 수정하고 싶지 않을 경우, 'getter (획득자)' 에서 `super.someProperty` 를 반환함으로써 단순히 상속받은 값을 그대로 전달할 수도 있는데, 여기서 `someProperty` 가 '재정의하는' 속성의 이름입니다.

다음 예제는 `Vehicle` 의 하위 클래스로, `Car` 라는 새로운 클래스를 정의합니다. `Car` 클래스는 새로운 저장 속성인 `gear` 를 도입하여, 기본 설정 값으로 정수 `1` 을 둡니다. `Car` 클래스는 `Vehicle` 에서 상속받은 `description` 속성도 재정의하고 있는데, 이는 사용자 목적에 맞도록 현재 '기어' 를 포함하는 설명을 제공하기 위함입니다.

```swift
class Car: Vehicle {
  var gear = 1
  override var description: String {
    return super.description + " in gear \(gear)"
  }
}
```

`description` 속성의 '재정의' 는, `Vehicle` 클래스의 `description` 속성을 반환하는, `super.description` 을 호출하는 것으로 시작합니다. 이어서 `Car` 클래스 버전의 `description` 은 기존 설명 끝에 현재 '기어' 정보에 대한 몇가지 여분의 설명을 추가합니다.

`Car` 클래스의 인스턴스를 만들고 `gear` 와 `currentSpeed` 속성을 설정하고 나면, `description` 속성이 `Car` 클래스 내에 정의된 '맞춤형 설명 (tailored description)' 을 반환하는 것을 볼 수 있습니다:

```swift
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
// "Car: traveling at 25.0 miles per hour in gear 3" 를 출력합니다.
```

<p>
<strong id="overriding-property-observers-속성-관찰자-재정의하기">Overriding Property Observers (속성 관찰자 재정의하기)</strong>
</p>

'속성 재정의 (property overriding)' 를 사용하여 '상속받은 속성' 에 '속성 관찰자 (property observers)' 를 추가할 수 있습니다. 이것은 상속받은 속성의 값이 바뀔 때 알림을 받을 수 있도록 해주며, 이 때 그 속성이 원래 어떻게 구현됐는지는 상관 없습니다. '속성 관찰자 (property observers)' 에 대한 더 자세한 정보는 [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 에서 확인할 수 있습니다.

> '속성 관찰자' 를 '상속받은 상수 저장 속성 (inherited constant stored property)' 이나 '상속받은 읽기-전용 계산 속성 (inherited read-only computed properties)' 에는 추가할 수 없습니다. 이 속성들의 값은 설정 자체가 불가능하므로, '재정의' 하면서 `willSet` 이나 `didSet` 구현을 제공하는 것이 적합하지 않기 때문입니다.
>
> 동일한 하나의 속성에 대해 '재정의 설정자 (overriding setter)' 와 '재정의 속성 관찰자 (overriding property observer)' 를 동시에 제공할 수 없음에도 주목하기 바랍니다. 속성에 대해 이미 '사용자 정의 설정자 (custom setter)' 를 제공하고 있다면, 속성의 값이 바뀌는 것을 관찰하고 싶을 경우, 그 '사용자 정의 설정자 (custom setter)' 안에서 바뀔 값을 간단히 관찰하면 되기 때문입니다.

다음 예제는 `Car` 의 하위 클래스로, `AutomaticCar` 라는 새로운 클래스를 정의합니다. 이 `AutomaticCar` 클래스는 '자동 기어박스' 가 있는 자동차를 나타내며, 현재 속도를 기반으로 하여 적절한 기어를 자동으로 선택합니다:

```swift
class AutomaticCar: Car {
  override var currentSpeed: Double {
    didSet {
      gear = Int(currentSpeed / 10.0) + 1
    }
  }
}
```

`AutomaticCar` 인스턴스의 `currentSpeed` 속성을 설정할 때마다, 이 속성의 `didSet` '관찰자 (observer)' 가 새 속도에 적합하도록 인스턴스의 `gear` 속성을 설정하게 됩니다. 여기서 지정한 '속성 관찰자' 는 새 `currentSpeed` 값을 `10` 으로 나누고, 그 정수인 몫에, `1` 을 더한 값을 '기어' 로 선택합니다. 속도가 `35.0` 이면 기어는 `4` 가 됩니다:

```swift
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")
// "AutomaticCar: traveling at 35.0 miles per hour in gear 4" 를 출력합니다.
```

### Preventing Overrides (재정의 막기)

메소드, 속성, 또는 첨자 연산이 재정의 되는 것을 막고 싶으면 _final (최종)_ 이라고 표시하면 됩니다. 이렇게 하려면 메소드, 속성, 또는 첨자 연산의 '도입자 (introducer)' 키워드 앞에 `final` '수정자 (modifier)' 를 붙이면 됩니다. (가령 `final var`, `final func`, `final class func`, 그리고 `final subscript` 와 같은 식으로 하면 됩니다.)

'final (최종) 메소드', '최종 속성', 또는 '최종 첨자 연산' 을 하위 클래스에서 '재정의' 하려고 하면 '컴파일 시간에 에러 (compile-time error)' 를 띄웁니다. 클래스의 'extension (확장)' 으로 추가한 메소드, 속성, 또는 첨자 연산들도 'extension (확장)' 의 정의 안에서 'final (최종)' 으로 표시할 수 있습니다.

클래스를 정의할 때 `class` 키워드 앞에 `final` '수정자 (modifier)' 를 붙이면 (즉 `final class` 라고 하면) 전체 클래스를 'final (최종)' 으로 표시하게 됩니다. '최종 클래스 (final class)' 를 가지고 '하위 클래스' 를 만들려고 하는 어떤 짓이든 '컴파일 시간에 에러 (compile-time error)' 를 띄웁니다.

### 참고 자료

[^Inheritance]: 이 글에 대한 원문은 [Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html) 에서 확인할 수 있습니다.

[^base-class]: 어떤 프로그래밍 언어에서는 'base class' 를 'superclass' 의 의미로 사용하기도 합니다. 하지만 스위프트의 'base class (기본 클래스)' 는 'superclass (상위 클래스)' 와는 다릅니다. 스위프트에서는 '기본 클래스' 가 '상위 클래스' 일 수도 있고 아닐 수도 있으며, '상위 클래스' 도 '기본 클래스' 일 수도 있고 아닐 수도 있습니다. 스위프트의 'base class (기본 클래스)' 는 아무데서도 상속받은 것이 없는 클래스, 즉 상속 관계에서라면 자신이 상속의 출발점이 되는 클래스를 말합니다.

[^read-write-to-read-only]: 이것은 없던 기능을 추가할 수는 있지만, 원래 있던 기능을 없앨 수는 없다고 이해하면 될 것 같습니다.
