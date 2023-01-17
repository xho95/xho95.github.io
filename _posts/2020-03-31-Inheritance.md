---
layout: post
pagination: 
  enabled: true
comments: true
title:  "Swift 5.7: Inheritance (상속)"
date:   2020-03-31 10:00:00 +0900
categories: Swift Language Grammar Inheritance
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html) 부분[^Inheritance]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Inheritance (상속)

클래스는 다른 클래스의 메소드, 속성, 및 다른 성질 (characteristics) 을 _상속 (inherit)_ 할 수 있습니다. 한 클래스가 다른 걸 상속할 때, 상속하는 클래스를 _하위 클래스 (subclass)_ 라고 하고, 상속을 주는 클래스를 _상위 클래스 (superclass)_ 라고 합니다. 상속은 스위프트에서 클래스와 다른 타입을 구별하는 기본 동작입니다.

스위프트 클래스는 자신의 상위 클래스에 속한 메소드, 속성, 및 첨자에 접근하여 호출할 수도 있고, 그 메소드, 속성, 및 첨자의 재정의 버전을 제공하여 동작을 개량하거나 수정할 수도 있습니다. 스위프트는 재정의한 정의와 일치하는 상위 클래스 정의가 있는지 검사함으로써 재정의가 올바르도록 도와줍니다.

클래스는 속성 값을 바꿀 때 알림을 받기 위해서 상속한 속성에 속성 관찰자를 추가할 수도 있습니다. 원본이 저장인지 계산 속성인지에 상관 없이, 어떤 속성에든 속성 관찰자를 추가할 수 있습니다.

### Defining a Base Class (기초 클래스 정의하기)

또 다른 클래스를 상속하지 않는 어떤 클래스든 _기초 클래스 (base class)_[^base-class] 라고 합니다.

> 스위프트 클래스는 '보편 기초 클래스 (universal base class)' 를 상속하지 않습니다.[^universal-base-class] 상위 클래스를 지정하지 않고 정의한 클래스는 자동으로 기초 클래스가 됩니다.

아래 예제는 `Vehicle` 이라는 기초 클래스를 정의합니다. 이 기초 클래스는 `currentSpeed` 라는 저장 속성을 정의하는데, (속성 타입은 `Double` 로 추론하고) `0.0` 이라는 기본 값을 가집니다. `currentSpeed` 속성 값은 차량 (vehicle) 설명을 생성하는 `description` 이라는 `String` (타입) 읽기-전용 계산 속성이 사용합니다.

`Vehicle` 기초 클래스는 `makeNoise` 라는 메소드도 정의합니다. 이 메소드는 실제로 기초 `Vehicle` 인스턴스에선 아무 것도 안하지만, 나중에 `Vehicle` 의 하위 클래스에서 사용자 정의할 겁니다:

```swift
class Vehicle {
  var currentSpeed = 0.0
  var description: String {
    return "traveling at \(currentSpeed) miles per hour"
  }
  func makeNoise() {
    // 아무 것도 안함 - 임의의 차량은 소음을 만들 필요가 없음
  }
}
```

타입 이름 뒤에 빈 괄호를 작성하는, _초기자 구문 (initializer syntax)_ 을 가지고 `Vehicle` 의 새 인스턴스를 생성합니다:

```swift
let someVehicle = Vehicle()
```

새 `Vehicle` 인스턴스를 생성했으면, `description` 속성에 접근하여 현재 차량 속도를 사람이-이해할 수 있게 인쇄할 수 있습니다:

```swift
print("Vehicle: \(someVehicle.description)")
// "Vehicle: traveling at 0.0 miles per hour" 를 인쇄함
```

`Vehicle` 클래스는 임의의 차량에 공통인 성질을 정의하지만, 그 자체론 별 쓸모가 없습니다. 더 유용해지려면, 더 특정한 종류의 차량을 설명하도록 개량할 필요가 있습니다.

### Subclassing (하위 클래스 만들기)

_하위 클래스 만들기 (subclassing)_ 는 기존 클래스를 기초로 새로운 클래스를 만드는 행동입니다. 하위 클래스 (subclass) 는 기존 클래스의 성질을 상속한 다음, 나중에 개량할 수 있습니다. 하위 클래스에서 새로운 성질을 추가할 수도 있습니다.

하위 클래스에 상위 클래스가 있다고 지시하려면, 상위 클래스 이름 앞에, 콜론으로 구분된, 하위 클래스 이름을 작성합니다:

```swift
class SomeSubclass: SomeSuperclass {
  // 하위 클래스 정의를 여기에 둠
}
```

다음 예제는, `Vehicle` 이라는 상위 클래스를 가진, `Bicycle` 이라는 하위 클래스를 정의합니다:

```swift
class Bicycle: Vehicle {
  var hasBasket = false
}
```

새 `Bicycle` 클래스는, `currentSpeed` 와 `description` 속성 및 `makeNoise()` 메소드 같은, `Vehicle` 의 모든 성질을 자동으로 얻습니다.

상속한 성질에 더해, `Bicycle` 클래스는, `hasBasket` 이라는, 새로운 저장 속성을 정의하는데, (속성은 `Bool` 타입으로 추론하고) `false` 라는 기본 값을 가집니다.

기본적으로, 새로 생성한 어떤 `Bicycle` 인스턴스에도 바구니 (basket) 가 없을 겁니다. 한 특별한 `Bicycle` 인스턴스의 `hasBasket` 속성은 그 인스턴스를 생성한 후 `true` 라고 설정할 수 있습니다:

```swift
let bicycle = Bicycle()
bicycle.hasBasket = true
```

`Bicycle` 인스턴스의 `currentSpeed` 상속 속성을 수정하고, 인스턴스의 `description` 상속 속성을 조회할 수도 있습니다:

```swift
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")
// "Bicycle: traveling at 15.0 miles per hour" 를 인쇄함
```

하위 클래스 그 자체도 하위 클래스를 만들 수 있습니다. 다음 예제는 "탠덤 (tandem)" 이라는 2-인승 자전거를 위해 `Bicycle` 의 하위 클래스를 생성합니다:

```swift
class Tandem: Bicycle {
  var currentNumberOfPassengers = 0
}
```

`Tandem` 은 `Bicycle` 의 모든 속성과 메소드를 상속하고, (`Bicycle` 은) 차례대로 `Vehicle` 의 모든 속성과 메소드를 상속합니다. `Tandem` 하위 클래스는, `0` 이라는 기본 값을 가지고, `currentNumberOfPassengers` 라는 새로운 저장 속성도 추가합니다.

`Tandem` 의 인스턴스를 생성하면, 자신의 새 속성이든 상속 속성이든 어떤 것과도 작업할 수 있으며, `Vehicle` 에서 상속한 읽기-전용 `description` 속성도 조회할 수 있습니다:

```swift
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
// "Tandem: traveling at 22.0 miles per hour" 를 인쇄함
```

### Overriding (재정의하기)

하위 클래스는 상위 클래스에서 상속하게 될 인스턴스 메소드, 타입 메소드, 인스턴스 속성, 타입 속성, 및 첨자에 대하여 자신만의 구현을 제공할 수 있습니다. 이를 _재정의 (overriding)_ 라고 합니다.

상속하게 될 성질을 재정의하려면, 재정의할 정의의 접두사로 `override` 키워드를 붙입니다. 그럼으로써 재정의를 제공하는 게 의도한 것이고 실수로 일치하는 정의를 제공하지 않을 것임을 분명하게 합니다. 의도하지 않은 재정의는 예상치 못한 동작을 유발할 수 있으며, `override` 키워드 없는 재정의는 어떤 것이든 코드 컴파일 때 에러로 진단합니다.

`override` 키워드는 재정의 클래스의 상위 클래스 (나 부모 클래스 하나) 가 제공한 재정의와 일치하는 선언을 가지고 있는지 스위프트 컴파일러가 즉시 검사하게 하기도 합니다. 이 검사는 재정의가 올바르도록 보장합니다.

#### Accessing Superclass Methods, Properties, and Subscripts (상위 클래스의 메소드, 속성, 및 첨자에 접근하기)

하위 클래스에서 메소드, 속성, 및 첨자를 재정의할 때, 재정의의 일부분으로써 기존 상위 클래스 구현을 사용하는 게 유용할 때가 있습니다. 예를 들어, 기존 구현의 동작을 개량하거나, 수정한 값을 기존 상속 변수에 저장할 수 있습니다.

적절한 곳에서, `super` 접두사를 사용함으로써 상위 클래스 버전의 메소드나, 속성, 또는 첨자에 접근할 수 있습니다:

* `someMethod()` 라는 이름의 재정의 메소드는 재정의 메소드 구현 안에서 `super.someMethod()` 를 호출함으로써 상위 클래스 버전의 `someMethod()` 를 호출할 수 있습니다.  
* `someProperty` 라는 재정의 속성은 재정의한 획득자나 설정자 구현 안에서 `super.someProperty` 하고 하여 상위 클래스 버전의 `someProperty` 에 접근할 수 있습니다.
* `someIndex` 의 재정의 첨자는 재정의 첨자 구현 안에서 `super[someIndex]` 라고 하여 동일 첨자의 상위 클래스 버전에 접근할 수 있습니다.

#### Overriding Methods (메소드 재정의하기)

상속한 인스턴스 메소드나 타입 메소드를 재정의하면 하위 클래스 안에서 맞춤식 또는 대체 구현을 제공할 수 있습니다.

다음 예제는 `Train` 이라는 새로운 `Vehicle` 하위 클래스를 정의하는데, 이는 `Vehicle` 에서 `Train` 이 상속한 `makeNoise()` 메소드를 재정의합니다:

```swift
class Train: Vehicle {
  override func makeNoise() {
    print("Choo Choo")
  }
}
```

새 `Train` 인스턴스를 생성하고 `makeNoise()` 메소드를 호출하면, `Train` 하위 클래스 버전의 메소드를 호출하는 걸 볼 수 있습니다:

```swift
let train = Train()
train.makeNoise()
// "Choo Choo" 를 인쇄함
```

#### Overriding Properties (속성 재정의하기)

상속한 인스턴스 속성이나 타입 속성을 재정의하면 그 속성에 자기가 정의한 획득자와 설정자를 제공하거나, 실제 속성 값이 바뀔 때 재정의 속성이 관찰할 수 있게 속성 관찰자를 추가할 수 있습니다.

<p>
<strong id="overriding-property-getters-and-setters-속성-획득자-및-설정자-재정의하기">Overriding Property Getters and Setters (속성 획득자 및 설정자 재정의하기)</strong>
</p>

상속 속성은 소스 구현이 저장인지 계산 속성인지에 상관없이, _어떤 (any)_ 상속 속성에든 사용자 정의 획득자 (및 적절하다면, 설정자) 를 제공하여 재정의할 수 있습니다. 상속한 속성의 태생이 저장인지 계산인지는 하위 클래스가 알 수 없습니다-이는 상속한 속성이 가진 정해진 이름과 타입만을 압니다. 재정의할 속성의 이름과 타입은 반드시 둘 다 정식으로 알려서, 똑같은 이름과 타입을 가진 상위 클래스 속성과 일치하는 지를 컴파일러가 검사할 수 있게 해야 합니다.

하위 클래스의 속성 재정의에서 획득자와 설정자 둘 다 제공함으로써 상속한 읽기-전용 속성이 읽기-쓰기 속성이 되도록 할 수 있습니다. 하지만, 읽기-쓰기 속성을 읽기-전용 속성이 되게 할 순 없습니다.

> 속성 재정의 부분에서 설정자를 제공할 경우, 반드시 항상 재정의에서 획득자도 제공해야 합니다. 재정의 획득자 안에서 상속한 속성 값을 수정하고 싶지 않으면, 획득자에서 `super.someProperty` 를 반환함으로써 상속 값을 단순히 통과시킬 수 있으며, 여기서 `someProperty` 는 재정의할 속성의 이름입니다.

다음 예제는, `Vehicle` 의 하위 클래스인, `Car` 라는 새로운 클래스를 정의합니다. `Car` 클래스는, 기본 값이 `1` 인, `gear` 라는 새로운 저장 속성을 도입합니다. `Car` 클래스는 `Vehicle` 에서 상속한 `description` 속성도 재정의하여, 현재 기어 (gear) 상태를 포함한 자신만의 설명을 제공합니다:

```swift
class Car: Vehicle {
  var gear = 1
  override var description: String {
    return super.description + " in gear \(gear)"
  }
}
```

`description` 속성 재정의는, `Vehicle` 클래스의 `description` 속성을 반환하는, `super.description` 호출로 시작합니다. 그런 다음 `Car` 클래스 버전의 `description` 이 설명 (description) 끝에 현재 기어에 대한 정보를 제공하는 어떠한 부가 문장을 추가합니다.

`Car` 클래스의 인스턴스를 생성하고 `gear` 와 `currentSpeed` 속성을 설정하면, `description` 속성이 `Car` 클래스 안에서 정의한 맞춤식 설명을 반환하는 걸 볼 수 있습니다:

```swift
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
// "Car: traveling at 25.0 miles per hour in gear 3" 를 인쇄함
```

<p>
<strong id="overriding-proper92ty-observers-속성-관찰자-재정의하기">Overriding Property Observers (속성 관찰자 재정의하기)</strong>
</p>

속성 재정의를 사용하면 상속한 속성에 속성 관찰자를 추가할 수 있습니다. 이는, 그 속성의 원본 구현 방법과는 상관없이, 상속한 속성 값이 바뀔 때 알림을 받을 수 있게 합니다. 속성 관찰자에 대한 더 많은 정보는, [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 부분을 보도록 합니다.

> 상속한 상수 저장 속성이나 상속한 읽기-전용 계산 속성엔 속성 관찰자를 추가할 수 없습니다. 이 속성은 값을 설정할 수 없으므로, 재정의 부분에서 `willSet` 이나 `didSet` 구현을 제공하는 게 적절하지 않습니다.
>
> 동일한 속성에 재정의 설정자 및 재정의 속성 관찰자 둘 다를 제공할 순 없다는 것도 기억하기 바랍니다. 속성 값이 바뀌는 걸 관찰하고 싶은데, 사용자 정의 설정자를 속성에 이미 제공했다면, 어떤 값 바뀜이든 사용자 정의 설정자 안에서 단순히 관찰할 수 있습니다.

다음 예제는, `Car` 의 하위 클래스인, `AutomaticCar` 라는 새로운 클래스를 정의합니다. `AutomaticCar` 클래스는, 현재 속도를 기초로 자동으로 적절한 기어를 선택하는, 자동 변속기 (gearbox) 를 가진 자동차를 나타냅니다:

```swift
class AutomaticCar: Car {
  override var currentSpeed: Double {
    didSet {
      gear = Int(currentSpeed / 10.0) + 1
    }
  }
}
```

`AutomaticCar` 인스턴스의 `currentSpeed` 속성을 설정할 때마다, 속성의 `didSet` 관찰자가 인스턴스의 `gear` 속성을 새 속도에 맞게 적절히 선택한 기어로 설정합니다. 특별히, 새 `currentSpeed` 값을 `10` 으로 나누고, 가장 가까운 정수로 내림한 후, `1` 을 더한 기어를 속성 관찰자가 선택합니다. 속도가 `35.0` 이면 기어를 `4` 로 만듭니다:

```swift
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")
// "AutomaticCar: traveling at 35.0 miles per hour in gear 4" 를 인쇄함
```

### Preventing Overrides (재정의 막기)

_최종 (final)_ 으로 표시함으로써 메소드나, 속성, 및 첨자의 재정의를 막을 수 있습니다. 이렇게 하려면 메소드나, 속성, 및 첨자의 도입자 키워드 앞에 `final` 수정자를 (`final var`, `final func`, `final class func`, 및 `final subscript` 같이) 작성하면 됩니다.

최종인 메소드나, 속성, 및 첨자를 하위 클래스에서 재정의하려는 어떤 시도도 컴파일-시간 에러라고 보고합니다. 익스텐션 (extension) 의 클래스에 추가한 메소드나, 속성, 및 첨자을 익스텐션 정의 안에서 최종이라고 표시할 수도 있습니다.

클래스 정의에 있는 `class` 키워드 앞에 `final` 수정자를 (`final class` 같이) 작성함으로써 전체 클래스를 최종으로 표시할 수 있습니다. 최종 클래스의 하위 클래스를 만들려는 어떤 시도도 컴파일-시간 에러라고 보고합니다.

### 다음 장

[Initialization (초기화) > ]({% post_url 2016-01-23-Initialization %})

### 참고 자료

[^Inheritance]: 이 글에 대한 원문은 [Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html) 에서 확인할 수 있습니다.

[^base-class]: 프로그래밍 언어마다 'base class' 라는 용어의 의미가 조금씩 다른데, 'base class' 를 '상위 클래스 (superclass)' 의 의미로 사용하는 언어도 있습니다. 하지만, 스위프트의 기초 클래스 (base class) 는 상위 클래스 (superclass) 와 의미가 조금 다릅니다. 스위프트의 기초 클래스는 상위 클래스 여부와는 상관없이, 아무 클래스도 상속하지 않는 클래스, 즉, 상속 계층이 있다면 최상단에 위치하게 되는 클래스를 의미합니다.

[^universal-base-class]: '보편 기초 클래스 (universal base class)' 는 객체 지향 프로그래밍 언어에서 모든 객체가 상속을 받아햐 하는 클래스를 말합니다. 보통 상속 계층 최상단에 위치하며 `Object` 라는 이름이 붙는 경우가 많습니다. 오브젝티브-C 언어도 `NSObject` 라는 보편 기초 클래스를 가지고 있습니다. 객체 지향 프로그래밍 언어는 이런 보편 기초 클래스를 가진 경우가 많습니다. 스위프트 클래스는 기본적으로 보편 기초 클래스를 상속하진 않지만, 오브젝티브-C 와 호환되도록 하려면, `NSObject` 라는 보편 기초 클래스를 상속해야 합니다. 클래스 앞에 `@objc` 를 붙이는 것도 `NSObject` 를 상속하게 만드는 겁니다.
