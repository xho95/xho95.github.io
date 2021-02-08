---
layout: post
comments: true
title:  "Swift 5.3: Inheritance (상속)"
date:   2020-03-31 10:00:00 +0900
categories: Swift Language Grammar Inheritance
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html) 부분[^Inheritance]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Inheritance (상속)

클래스는 다른 클래스에서 메소드, 속성, 그리고 다른 '성질 (characteristics)' 들을 _상속 (inherit)_ 할 수 있습니다. 한 클래스가 또 다른 것을 상속할 때, 상속하는 클래스는 _하위 클래스 (subclass)_ 라고 하고, 상속을 주는 클래스는 _상위 클래스 (superclass)_ 라고 합니다. 상속은 스위프트에서 클래스를 다른 타입들과 구분짓는 기본 작동 방식입니다.

스위프트의 클래스는 '상위 클래스' 에 속한 메소드, 속성, 및 첨자 연산을 호출하고 접근할 수 있으며 작동 방식을 개량하거나 수정하기 위해 그러한 메소드, 속성, 및 첨자 연산에 대한 자신만의 '재정의 (overriding) 버전' 을 제공할 수도 있습니다. 스위프트는 '재정의한 정의' 가 '상위 클래스' 의 정의와 일치하는 지를 검사하여 자신이 '재정의' 한 것이 올바르다는 것을 보장해 줍니다.

클래스는 속성 값이 바뀔 때 알림을 받기 위하여 상속한 속성에 '속성 관찰자 (property observers)' 를 추가할 수도 있습니다. '속성 관찰자' 는, 원래가 '저장 (stored) 속성' 인지 '계산 (computed) 속성' 인지에 상관 없이, 어떤 속성에도 추가할 수 있습니다.

### Defining a Base Class (기초 클래스 정의하기)

또 다른 클래스를 상속하지 않는 클래스는 어떤 것이든 _기초 클래스 (base class)_[^base-class] 라고 합니다.

> 스위프트의 클래스는 '보편적인 기초 클래스 (universal base class)'[^universal-base-class] 를 상속하지 않습니다.[^inherit-from-a-universal-base-class] 상위 클래스를 지정하지 않고 정의한 클래스는 제작할 때 자동으로 '기초 클래스' 가 됩니다.

아래 예제는 `Vehicle` 이라는 '기초 클래스' 를 정의합니다. 이 기초 클래스는, 기본 값이 `0.0` 인 (속성 타입은 `Double` 로 추론되는), `currentSpeed` 라는 '저장 속성' 을 정의합니다. `currentSpeed` 속성의 값은 '차량 (vehicle)' 의 설명을 생성하기 위해 `description` 이라는 `String` 타입의 '읽기-전용 계산 속성' 에서 사용합니다.

`Vehicle` 기초 클래스는 `makeNoise` 라는 메소드도 정의합니다. 이 메소드는 실제로 '기초 `Vehicle` 인스턴스' 를 위해서는 어떤 것도 하지 않지만, 나중에 `Vehicle` 의 '하위 클래스' 에서 사용자화 될 것입니다:

```swift
class Vehicle {
  var currentSpeed = 0.0
  var description: String {
    return "traveling at \(currentSpeed) miles per hour"
  }
  func makeNoise() {
    // 아무 것도 안합니다 - 임의의 차량은 소음을 만들 필요가 없습니다
  }
}
```

`Vehicle` 의 새로운 인스턴스는, 타입 이름 뒤에 빈 괄호를 붙여서 작성하는, _초기자 구문 표현 (initializer syntax)_ 으로 생성합니다:

```swift
let someVehicle = Vehicle()
```

새 `Vehicle` 인스턴스를 생성했으면, 차량의 현재 속도를 사람이-이해 가능한 설명으로 인쇄하기 위해 `description` 속성에 접근할 수 있습니다:

```swift
print("Vehicle: \(someVehicle.description)")
// "Vehicle: traveling at 0.0 miles per hour" 를 인쇄합니다.
```

`Vehicle` 클래스는 임의의 차량에 '공통인 성질' 을 정의하지만, 그 자체로는 많이 사용되지 않습니다. 더 유용하게 만들려면, 특정하게 지정된 종류의 차량을 설명하도록 이를 개량할 필요가 있습니다.

### Subclassing (하위 클래스 만들기)

_하위 클래스 만들기 (subclassing)_ 는 기존 클래스를 기초로 하여 새로운 클래스를 만드는 행위입니다. '하위 클래스 (subclass)' 는 기존 클래스의 '성질 (characteristics)' 들, 나중에 개량할 수 있는 것들, 을 상속합니다. 하위 클래스에서 새로운 성질을 추가할 수도 있습니다.

하위 클래스가 상위 클래스를 가진다고 지시하려면, 하위 클래스의 이름을 상위 클래스 앞에 작성하고, '콜론 (colon)' 으로 구분합니다:

```swift
class SomeSubclass: SomeSuperclass {
  // 하위 클래스의 정의는 여기에 둡니다.
}
```

다음 예제는, 상위 클래스가 `Vehicle` 인, `Bicycle` 이라는 하위 클래스를 정의합니다:

```swift
class Bicycle: Vehicle {
  var hasBasket = false
}
```

새로운 `Bicycle` 클래스는, `currentSpeed` 와 `description` 속성 그리고 `makeNoise()` 메소드 같은, `Vehicle` 의 모든 성질들을 자동으로 가지게 됩니다.

상속한 성질들에 더하여, `Bicycle` 클래스는, 기본 값이 `false` 인 (속성이 `Bool` 타입으로 추론되는), `hasBasket` 이라는, 새로운 저장 속성을 정의합니다.

기본적으로, 새로 생성한 어떤 `Bicycle` 인스턴스도 '바구니 (basket)' 를 가지지 않을 것입니다. 해당 인스턴스가 생성된 뒤에 특정 `Bicycle` 인스턴스에 대한 `hasBasket` 속성을 `true` 로 설정할 수 있습니다.

```swift
let bicycle = Bicycle()
bicycle.hasBasket = true
```

`Bicycle` 인스턴스가 상속한 속성인 `currentSpeed` 를 수정할 수도 있으며, 인스턴스의 상속 속성인 `description` 을 조회할 수도 있습니다:

```swift
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")
// "Bicycle: traveling at 15.0 miles per hour" 를 인쇄합니다.
```

'하위 클래스' 자체도 하위 클래스를 만들 수 있습니다. 다음 예제는 "탠덤 (tandem)" 이라는 2-인승 자전거를 만들기 위해 `Bicycle` 의 하위 클래스를 생성합니다:

```swift
class Tandem: Bicycle {
  var currentNumberOfPassengers = 0
}
```

`Tandem` 은 `Bicycle` 의 모든 속성과 메소드를 상속하는데, 차례대로 `Vehicle` 의 모든 속성과 메소드도 상속합니다. `Tandem` 하위 클래스는, 기본 값이 `0` 인, `currentNumberOfPassengers` 라는 새로운 저장 속성도 추가합니다.

`Tandem` 의 인스턴스를 생성한 경우, 새로운 속성과 상속한 속성 어떤 것과도 작업할 수 있으며, `Vehicle` 에서 상속한 '읽기-전용' `description` 속성을 조회할 수도 있습니다:

```swift
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
// "Tandem: traveling at 22.0 miles per hour" 를 인쇄합니다.
```

### Overriding (재정의하기)

하위 클래스는 다른 경우라면 상위 클래스에서 상속할 인스턴스 메소드, 타입 메소드, 인스턴스 속성, 타입 속성, 또는 '첨자 연산 (subscript)' 에 대하여 자신만의 구현을 제공할 수 있습니다. 이를 _재정의 (overriding)_ 라고 합니다.

다른 경우라면 상속하게될 '성질 (characteristics)' 을 재정의하려면, 재정의할 정의에 `override` 키워드를 접두사로 붙입니다. 이렇게 하는 것은 '재정의' 의 제공이 의도한 것이고 일치한 정의가 실수로 제공안된 것은 아닌지 분명하게 밝힙니다. 실수로 재정의하는 것은 예상하지 않은 작동 방식을 유발할 수 있으며, 코드를 컴파일할 때 `override` 키워드가 없는 재정의는 어떤 것이든 에러로 진단합니다.

`override` 키워드는 '재정의한 클래스' 의 상위 클래스 (또는 부모 클래스 중 하나) 가 재정의를 위해 제공된 것과 일치하는 선언을 가지고 있음을 스위프트 컴파일러가 검사하도록 촉구합니다. 이런 검사는 재정의가 올바르게 됐음을 보장합니다.

#### Accessing Superclass Methods, Properties, and Subscripts (상위 클래스의 메소드, 속성, 그리고 첨자 연산에 접근하기)

하위 클래스를 위해 메소드, 속성, 또는 첨자 연산을 '재정의' 할 때, 기존 상위 클래스 구현을 '재정의' 의 일부로 사용하는 것이 유용할 때가 있습니다. 예를 들어, 해당 기존 구현의 작동 방식을 개량하거나, 기존에 상속한 변수에 수정된 값을 저장할 수도 있습니다.

이것이 적절한 곳에서는, `super` 접두사를 사용함으로써 상위 클래스 버전의 메소드, 속성, 또는 첨자 연산에 접근할 수 있습니다:

* `someMethod()` 라는 이름의 '재정의된 메소드' 는 '재정의하는 메소드 구현' 내에서 `super.someMethod()` 를 호출함으로써 상위 클래스 버전의 `someMethod()` 를 호출할 수 있습니다.  
* `someProperty` 라는 '재정의된 속성' 은 '재정의하는 획득자 또는 설정자 구현' 내에서 `super.someProperty` 로 상위 클래스 버전의 `someProperty` 에 접근할 수 있습니다.
* `someIndex` 에 대해서 '재정의된 첨자 연산' 은 '재정의하는 첨자 연산 구현' 내에서 `super[someIndex]` 로 동일 첨자 연산에 대한 상위 클래스 버전에 접근할 수 있습니다.

#### Overriding Methods (메소드 재정의하기)

상속한 인스턴스 메소드나 타입 메소드는 하위 클래스에서 맞춤식 구현이나 대체 구현을 제공하기 위해 메소드를 '재정의' 할 수 있습니다.

다음 예제는 `Train` 이라는 `Vehicle` 의 새로운 하위 클래스를 정의하는데, 이는 `Train` 이 `Vehicle` 에서 상속한 `makeNoise()` 메소드를 재정의합니다:

```swift
class Train: Vehicle {
  override func makeNoise() {
    print("Choo Choo")
  }
}
```

새 `Train` 인스턴스를 생성하고 `makeNoise()` 메소드를 호출하면, `Train` 하위 클래스 버전의 메소드가 호출되는 것을 볼 수 있습니다:

```swift
let train = Train()
train.makeNoise()
// "Choo Choo" 를 인쇄합니다.
```

#### Overriding Properties (속성 재정의하기)

상속한 인스턴스 속성이나 타입 속성은 해당 속성에 대해 자신만의 사용자 정의 획득자와 설정자를 제공하거나, 실제 속성 값이 바뀔 때 재정의한 속성이 관찰할 수 있도록 속성 관찰자를 추가하기 위해 '재정의' 할 수 있습니다.

<p>
<strong id="overriding-property-getters-and-setters-속성의-획득자와-설정자-재정의하기">Overriding Property Getters and Setters (속성의 획득자와 설정자 재정의하기)</strong>
</p>

상속한 속성은, 그 속성이 원래 저장 속성으로 구현됐는지 계산 속성으로 구현됐는지에 상관없이, _어떤 (any)_ 것이든 재정의를 위해 '사용자 정의 획득자' (적절한 경우, '설정자' 까지) 를 제공할 수 있습니다. 상속한 속성의 본성이 '저장' 인지 '계산' 인지는 하위 클래스에서 알 수 없습니다-단지 상속한 속성이 정해진 이름과 타입을 가진다는 것만 압니다. 재정의하는 속성의 이름과 타입은, '재정의' 와 똑같은 이름과 타입을 가진 상위 클래스 속성과 일치하는 지를 컴파일러가 검사할 수 있도록, 반드시 항상 둘 다 '분명하게 알려야 (state)' 합니다.

상속한 '읽기-전용' 속성은 하위 클래스에서 재정의하면서 획득자와 설정자 둘 다를 제공함으로써 '읽기-쓰기' 속성이 되게 할 수 있습니다. 하지만, '읽기-쓰기' 속성을 '읽기-전용' 속성이 되게 할 수는 없습니다.

> 속성을 '재정의' 하면서 '설정자' 를 제공할 경우, 반드시 해당 재정의에 대한 '획득자' 도 제공해야 합니다. '재정의하는 획득자' 에서 상속한 속성의 값을 수정하고 싶지 않은 경우, `someProperty` 가 재정의하는 속성의 이름이라면, '획득자' 에서 `super.someProperty` 를 반환함으로써 단순히 상속한 값을 그대로 전달할 수도 있습니다.

다음 예제는 `Car` 라는, `Vehicle` 의 새로운 하위 클래스를, 정의합니다. `Car` 클래스는, 기본 값이 `1` 인, `gear` 라는 새로운 저장 속성을 도입합니다. `Car` 클래스는, 현재 '기어 (gear)' 정보도 포함한 사용자 설명을 제공하기 위해, `Vehicle` 에서 상속한 `description` 속성도 재정의합니다:

```swift
class Car: Vehicle {
  var gear = 1
  override var description: String {
    return super.description + " in gear \(gear)"
  }
}
```

`description` 속성의 재정의는, `Vehicle` 클래스의 `description` 속성을 반환하는, `super.description` 을 호출하는 것으로써 시작합니다. `Car` 클래스 버전의 `description` 은 그런 다음 현재 '기어' 에 대한 정보를 제공하기 위해 기존 설명 끝에 약간의 부가적인 문장을 추가합니다.

`Car` 클래스의 인스턴스를 생성하고 `gear` 와 `currentSpeed` 속성을 설정하면, `description` 속성이 `Car` 클래스에서 정의한 '맞춤식 설명' 을 반환하는 것을 볼 수 있습니다:

```swift
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
// "Car: traveling at 25.0 miles per hour in gear 3" 를 인쇄합니다.
```

<p>
<strong id="overriding-property-observers-속성-관찰자-재정의하기">Overriding Property Observers (속성 관찰자 재정의하기)</strong>
</p>

상속한 속성에 '속성 관찰자' 를 추가하기 위해 '속성 재정의' 를 사용할 수 있습니다. 이는, 해당 속성이 원래 어떻게 구현되어 있는지에 상관없이, 상속한 속성의 값이 바뀔 때 알림을 받을 수 있게 해줍니다. '속성 관찰자' 에 대한 더 많은 정보는, [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 를 참고하기 바랍니다.

> 속성 관찰자는 상속한 '상수 저장 속성' 이나 상속한 '읽기-전용 계산 속성' 에는 추가할 수 없습니다. 이 속성들의 값은 설정할 수 없으므로, '재정의' 에서 `willSet` 또는 `didSet` 구현을 제공하는 것은 적절하지 않습니다.
>
> 똑같은 속성에 대해 '재정의 설정자' 와 '재정의 속성 관찰자' 를 둘 다 제공할 수 없다는 것도 기억하기 바랍니다. 속성의 값이 바뀌는 것을 관찰하고 싶은데, 해당 속성에서 이미 '사용자 정의 설정자' 를 제공하고 있는 경우, 단순히 '사용자 정의 설정자' 내에서 어떤 값의 바뀜이라도 관찰할 수 있습니다.

다음 예제는, `Car` 의 하위 클래스인, `AutomaticCar` 라는 새로운 클래스를 정의합니다. `AutomaticCar` 클래스는, 현재 속도를 기초로 적절한 기어를 자동으로 선택하는, '자동 변속기 (gearbox)' 를 가진 자동차를 표현합니다:

```swift
class AutomaticCar: Car {
  override var currentSpeed: Double {
    didSet {
      gear = Int(currentSpeed / 10.0) + 1
    }
  }
}
```

`AutomaticCar` 인스턴스의 `currentSpeed` 속성을 설정할 때마다, 속성의 '`didSet` 관찰자' 가 새로운 속도에 적절한 기어를 선택하도록 인스턴스의 `gear` 속성을 설정합니다. 특별히, 속성 관찰자는 새 `currentSpeed` 값을 `10` 으로 나눠서, 소수점 이하는 버린 다음, `1` 을 더한 '기어' 를 선택합니다. 속도가 `35.0` 이면 `4` 라는 기어를 `4` 내놓습니다:

```swift
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")
// "AutomaticCar: traveling at 35.0 miles per hour in gear 4" 를 인쇄합니다.
```

### Preventing Overrides (재정의 막기)

메소드, 속성, 또는 첨자 연산은 _최종 (final)_ 이라고 표시함으로써 '재정의' 되는 것을 막을 수 있습니다. 이렇게 하려면 (`final var`, `final func`, `final class func`, 및 `final subscript` 처럼) 메소드, 속성, 또는 첨자 연산의 '도입자 (introducer)' 키워드 앞에 '`final` 수정자 (modifier)' 를 작성하면 됩니다.

'최종' 메소드, 속성, 또는 첨자 연산을 재정의하려는 어떤 시도도 컴파일-시간 에러라고 보고합니다. 클래스의 '익스텐션 (extension)' 에서 추가한 메소드, 속성, 또는 첨자 연산도 '익스텐션 (extension)' 정의 내에서 '최종' 이라고 표시할 수 있습니다.

클래스 정의에 있는 `class` 키워드 앞에 '`final` 수정자' 를 (`final class` 처럼) 작성함으로써 전체 클래스를 '최종' 이라고 표시할 수 있습니다. '최종 클래스' 로 '하위 클래스' 를 만들려는 어떤 시도도 컴파일-시간 에러라고 보고합니다.

### 다음 장

[Initialization (초기화) > ]({% post_url 2016-01-23-Initialization %})

### 참고 자료

[^Inheritance]: 이 글에 대한 원문은 [Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^base-class]: 'base class' 라는 용어는 프로그래밍 언어마다 의미가 조금씩 다른데, 'base class' 를 '상위 클래스 (superclass)' 의 의미로 사용하는 언어도 있습니다. 하지만, 스위프트의 '기초 클래스 (base class)' 는 '상위 클래스 (superclass)' 와는 의미가 조금 다릅니다. 스위프트의 '기초 클래스' 는 '상위 클래스' 인지 아닌지의 여부와는 상관없이, 아무 클래스도 상속하지 않는 클래스, 즉, '상속 계층' 이 있다면 자신이 상속의 출발점이 되는 클래스를 말합니다.

[^universal-base-class]: '보편적인 기초 클래스 (universal base class)' 라는 것은 많은 프로그래밍 언어들에서 `Object` 라는 이름을 가진 '상속 계층' 의 최상단에 있는 클래스를 말합니다. 오브젝티브-C 언어만 하더라도 `NSObject` 라는 '보편적인 기초 클래스' 를 가지고 있습니다. 초창기 'OOP' 언어의 프레임웍은 이런 '보편적인 기초 클래스' 를 가진 경우가 많았습니다.

[^inherit-from-a-universal-base-class]: 기본적으로, 스위프트 클래스는 '보편적인 기초 클래스' 를 상속하지 않지만, 해당 클래스를 오브젝티브-C 와 호환되게 하려면, `NSObject` 라는 '보편적인 기초 클래스' 를 상속받아야 합니다. 클래스 앞에 `@objc` 라는 '특성 (attribute)' 을 붙이는 것도 내부적으로는 `NSObject` 를 상속하도록 만드는 것입니다.
