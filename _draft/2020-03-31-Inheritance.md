---
layout: post
comments: true
title:  "Swift 5.2: Inheritance (상속)"
date:   2020-03-31 10:00:00 +0900
categories: Swift Language Grammar Inheritance
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html) 부분[^Inheritance]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Inheritance (상속)

클래스는 다른 클래스의 메소드, 속성 그리고 기타 성질들을 _상속 (inherit)_ 할 수 있습니다. 한 클래스가 다른 것을 상속할 때, 상속을 받는 클래스를 _하위 클래스 (subclass)_ 라 하고, 상속을 해주는 클래스를 _상위 클래스 (superclass)_ 라고 합니다. 상속은 '클래스 (class)' 고유의 행동으로 이것이 스위프트의 다른 타입들과 차별되는 점입니다.

스위프트의 클래스는 '상위 클래스 (superclass)' 의 메소드, 속성, 그리고 첨자 연산에 접근하고 호출할 수 있으며, 그 행동을 다듬고 수정해서 해당 메소드, 속성, 그리고 첨자 연산에 대한 자기만의 '재정의 버전 (overriding version)' 을 제공할 수도 있습니다. 스위프트는 '재정의한 정의 (override definition)' 에 해당하는 상위 클래스의 정의를 검사하여 해당 '재정의 (overrides)' 가 올바른지를 확인해 줍니다.

클래스는 상속받은 속성에 '속성 관찰자 (property observers)' 도 추가할 수 있는데 이는 속성 값이 바뀔 때 알림을 받을 수 있게 해 줍니다. '속성 관찰자' 는 어떤 속성에든 추가할 수 있으며, 원래 속성이 '저장 속성 (stored property)' 이든 '계산 속성 (computed property)' 이든 상관 없습니다.

### Defining a Base Class (기본 클래스 정의하기)

어떤 클래스든 다른 클래스를 상속하지 않으면 이를 _기본 클래스 (base class)_[^base-class] 라고 합니다.

> 스위프트의 클래스는 '범용 기본 클래스 (universal base class)' 를 상속하지 않습니다. 클래스를 정의할 때 '상위 클래스' 를 지정하지 않으면 자동으로 '기본 클래스' 가 됩니다.

아래 예제는 `Vehicle` 이라는 '기본 클래스' 를 정의합니다. 이 기본 클래스는 `currentSpeed` 라는 '저장 속성 (stored property)' 을 정의하고, 기본 값을 `0.0` 으로 둡니다. (추론된 속성의 타입은 `Double` 입니다) `currentSpeed` 속성의 값은 `description` 이라는 `String` 타입의 일기-전용 계산 속성에서 사용되어 차량에 대한 설명을 만들게 됩니다.

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

_하위 클래스 만들기 (subclassing)_ 는 기존 클래스를 기반으로 해서 새 클래스를 만드는 행위를 말합니다. '하위 클래스 (subclass)' 를 사용하면 기존 클래스의 성질을 상속해서, 다듬을 수 있습니다. 물론 하위 클래스에 새로운 성질을 추가할 수도 있습니다.

'하위 클래스' 가 '상위 클래스' 를 가지고 있다고 지시하려면, '상위 클래스' 앞에 '하위 클래스' 의 이름을 쓰고, 이들을 '콜론 (colon)' 으로 구분하면 됩니다:

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

이런 상속하는 성질들에 더하여, `Bicycle` 클래스는 새로운 '저장 속성' 인 `hasBasket` 을 정의하며, 기본 값으로 `false` 를 부여합니다. (속성의 타입은 `Bool` 로 추론됩니다)

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

`Tandem` 은 `Bicycle` 의 모든 속성과 메소드를 상속하며, 이에 따라 `Vehicle` 의 모든 속성과 메소드 역시 상속합니다. `Tandem` 하위 클래스는 또 `currentNumberOfPassengers` 라는 새로운 '저장 속성 (stored property)' 을 추가하고 있는데, 이의 기본 값은 `0` 입니다.

Tandem의 인스턴스를 작성하는 경우, 새 특성 및 상속 된 특성을 사용하여 Vehicle에서 상속 된 읽기 전용 설명 특성을 조회 할 수 있습니다.

### Overriding (재정의하기)

#### Accessing Superclass Methods, Properties, and Subscripts (상위 클래스의 메소드, 속성, 그리고 첨자 연산에 접근하기)

#### Overriding Methods (메소드 재정의하기)

#### Overriding Properties (속성 재정의하기)

**Overriding Property Getters and Setters (속성의 Getters 와 Setters 재정의하기)**

**Overriding Property Observers (속성 관찰자 재정의하기)**

### Preventing Overrides (재정의 금지하기)

### 참고 자료

[^Inheritance]: 이 글에 대한 원문은 [Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html) 에서 확인할 수 있습니다.

[^base-class]: 어떤 프로그래밍 언어에서는 'base class' 를 'superclass' 의 의미로 사용하기도 합니다. 하지만 스위프트의 'base class (기본 클래스)' 는 'superclass (상위 클래스)' 와는 다릅니다. 스위프트에서는 '기본 클래스' 가 '상위 클래스' 일 수도 있고 아닐 수도 있으며, '상위 클래스' 도 '기본 클래스' 일 수도 있고 아닐 수도 있습니다. 스위프트의 'base class (기본 클래스)' 는 아무데서도 상속받은 것이 없는 클래스, 즉 상속 관계에서라면 자신이 상속의 출발점이 되는 클래스를 말합니다.
