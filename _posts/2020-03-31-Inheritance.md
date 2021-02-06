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

<p>
<strong id="overriding-property-getters-and-setters-속성의-getters-와-setters-재정의하기">Overriding Property Getters and Setters (속성의 Getters 와 Setters 재정의하기)</strong>
</p>

사용자 정의 'getter' (그리고, 적절한 경우 'setter' 까지) 를 제공하여 상속받은 속성은 _어느 것이든 (any)_ 재정의할 수 있는데, 이 때 원 소스에서 상속받은 속성의 구현이 '저장 속성' 으로 되었든 '계산 속성' 으로 되었든 상관이 없습니다. 상속받은 속성의 본질이 '저장 속성' 인지 '계산 속성' 인지는 '하위 클래스' 에서 알 수가 없습니다-단지 이 상속받은 속성의 이름과 타입이 어떤 것인지만 알 수 있습니다. 재정의하려면 항상 그 속성의 이름과 타입 두 가지 모두 다시 반드시 알려줘야 하며, 이는 컴파일러가 이 '재정의' 에 해당하는 '상위 클래스' 의 속성을 검사하려면 이름과 타입이 같은지를 보고 검사하게 되기 때문입니다.

하위 클래스에서 속성을 재정의하면서 'getter' 와 'setter' 를 모두 제공하면 '상속받은 읽기-전용 속성 (inherited read-only property)' 을 '읽기-쓰기 혼용 속성 (read-write property)' 로 나타낼 수 있습니다. 하지만, '읽기-쓰기 혼용 속성' 을 '읽기-전용 속성' 으로 나타내는 것은 불가능 합니다.[^read-write-to-read-only]

> 속성을 '재정의' 하면서 'setter (설정자)' 를 제공하는 경우, 반드시 그 재정의를 위한 'getter (획득자)' 도 제공해야 합니다. 'overriding getter (재정의하는 획득자)' 내에서 상속받은 속성의 값을 수정하고 싶지 않을 경우, 'getter (획득자)' 에서 `super.someProperty` 를 반환함으로써 단순히 상속받은 값을 그대로 전달할 수도 있는데, 여기서 `someProperty` 가 '재정의하는' 속성의 이름입니다.

다음 예제는 `Vehicle` 의 하위 클래스로, `Car` 라는 새로운 클래스를 정의합니다. `Car` 클래스는 새로운 저장 속성인 `gear` 를 도입하여, 기본 값으로 정수 `1` 을 둡니다. `Car` 클래스는 `Vehicle` 에서 상속받은 `description` 속성도 재정의하고 있는데, 이는 사용자 목적에 맞도록 현재 '기어' 를 포함하는 설명을 제공하기 위함입니다.

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

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^base-class]: 'base class' 라는 용어는 프로그래밍 언어마다 의미가 조금씩 다른데, 'base class' 를 '상위 클래스 (superclass)' 의 의미로 사용하는 언어도 있습니다. 하지만, 스위프트의 '기초 클래스 (base class)' 는 '상위 클래스 (superclass)' 와는 의미가 조금 다릅니다. 스위프트의 '기초 클래스' 는 '상위 클래스' 인지 아닌지의 여부와는 상관없이, 아무 클래스도 상속하지 않는 클래스, 즉, '상속 계층' 이 있다면 자신이 상속의 출발점이 되는 클래스를 말합니다.

[^universal-base-class]: '보편적인 기초 클래스 (universal base class)' 라는 것은 많은 프로그래밍 언어들에서 `Object` 라는 이름을 가진 '상속 계층' 의 최상단에 있는 클래스를 말합니다. 오브젝티브-C 언어만 하더라도 `NSObject` 라는 '보편적인 기초 클래스' 를 가지고 있습니다. 초창기 'OOP' 언어의 프레임웍은 이런 '보편적인 기초 클래스' 를 가진 경우가 많았습니다.

[^inherit-from-a-universal-base-class]: 기본적으로, 스위프트 클래스는 '보편적인 기초 클래스' 를 상속하지 않지만, 해당 클래스를 오브젝티브-C 와 호환되게 하려면, `NSObject` 라는 '보편적인 기초 클래스' 를 상속받아야 합니다. 클래스 앞에 `@objc` 라는 '특성 (attribute)' 을 붙이는 것도 내부적으로는 `NSObject` 를 상속하도록 만드는 것입니다.

[^read-write-to-read-only]: 이것은 없던 기능을 추가할 수는 있지만, 원래 있던 기능을 없앨 수는 없다고 이해하면 될 것 같습니다.
