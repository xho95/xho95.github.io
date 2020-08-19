---
layout: post
comments: true
title:  "Swift 5.3: Declarations (선언)"
date:   2020-08-15 11:30:00 +0900
categories: Swift Language Grammar Declaration
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Declarations](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html) 부분[^Declarations]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## Declarations (선언)

_선언 (declaration)_ 은 프로그램에 새로운 이름 또는 구조물을 도입합니다. 예를 들어, 선언을 사용하여 함수와 메소드를 도입하고, 변수와 상수를 도입하며, 열거체, 구조체, 클래스, 및 프로토콜 타입을 정의합니다. 또한 선언을 사용하면 기존 '이름 있는 타입 (named type)' 의 작동 방식을 확장할 수도 있고 다른 곳에서 선언한 '기호 (symbols)' 를 프로그램으로 불러 올 수도 있습니다.

스위프트에서는, 선언과 동시에 구현 또는 초기화 된다라는 점에서 대부분의 '선언 (declarations)' 은 또한 '정의 (definitions)' 이기도 합니다. 즉, 프로토콜은 그 멤버를 구현하지 않기 때문에, 대부분의 프로토콜 멤버는 선언이기만 합니다. 편의상 그리고 스위프트에서는 그 구별이 그다지 중요하지 않기 때문에, _선언 (declarations)_ 이라는 용어로 선언과 정의를 모두 다룹니다.

> GRAMMAR OF A DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html)

### Top-Level Code (최상위-수준 코드)

스위프트 소스 파일에 있는 '최상위-수준 코드 (top-level code)' 는 '0' 개 이상의 구문, 선언, 그리고 표현식으로 구성됩니다. 기본적으로, 소스 파일의 최상위-수준에서 선언한 변수, 상수, 및 그외 '이름 있는 선언 (named declarations)' 들은 같은 모듈에 있는 모든 소스 파일의 코드에서 접근 가능합니다. 이런 기본 작동 방식을 재정의하려면, [Access Control Levels (접근 제어 수준)](#access-control-levels-접근-제어-수준) 에서 설명한 것처럼, 선언을 '접근-수준 수정자' 로 표시하면 됩니다.

'최상위-수준 코드' 에는 두 가지 종류가 있습니다: '최상위-수준 선언 (top-level declarations)' 과 '실행 가능한 최상위-수준 코드 (excutable top-level code)' 가 그것입니다. '최상위-수준 선언' 은 선언 만으로 구성되며, 모든 스위프트 소스 파일에서 허용됩니다. '실행 가능한 최상위-수준 코드' 는, 선언뿐만 아니라, 구문과 표현식도 가지고 있으며, 프로그램에 대한 최상위-수준 진입점으로만 허용됩니다.

'실행 파일 (executable)' 을 만들기 위해 컴파일하는 스위프트 코드는, 코드가 어떻게 파일과 모듈로 구성되는 지에 상관없이, 최상위-수준 진입점을 표시하는 다음의 접근 방법 중에서 최대 한 개만을 가질 수 있습니다: `main` 특성, `NSApplicationMain` 특성, `UIApplicationMain` 특성, `main.swift` 파일, 아니면 '최상위-수준 실행 가능한 코드' 를 가지고 있는 파일.

> GRAMMAR OF A TOP-LEVEL DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID352)

### Code Blocks

### Import Declaration

### Constant Declaration

### Variable Declaration (변수 선언)

_변수 선언 (variable declaration)_ 은 프로그램에 '이름 있는 변수 값 (variable named value)' 을 프로그램에 도입하는 것으로 `var` 키워드를 사용하여 선언합니다.

변수 선언은, 저장 변수 및 속성과 계산 변수 및 속성, 저장 변수 관찰자 및 저장 속성 관찰자, 그리고 정적 변수 속성을 포함하여, 서로 다른 종류의 이름 있는, 변경 가능한 값을 선언하는 여러 가지 양식을 가지고 있습니다. 어떤 양식을 사용하는게 적절한가 하는 것은 변수를 선언하는 영역이 어디인지 그리고 선언하고자 하는 변수의 종류가 무엇인지에 달려 있습니다.

> [Protocol Property Declaration (프로토콜 속성 선언)](#protocol-property-declaration-프로토콜-속성-선언) 에서 설명하는 것처럼, 프로토콜 선언 상황에서도 속성을 선언할 수 있습니다.

[Overriding (재정의하기)]({% post_url 2020-03-31-Inheritance %}#overriding-재정의하기) 에서 설명한 것처럼, 하위 클래스의 속성 선언을 `override` 선언 수정자로 표시하면 하위 클래스에서 속성을 재정의할 수 있습니다.

#### Stored Variables and Stored Variable Properties

#### Computed Variables and Computed Properties

#### Stored Variable Observers and Property Observers (저장 변수 관찰자와 속성 관찰자)

저장 변수 또는 저장 속성은 `willSet` 및 `didSet` 관찰자로 선언할 수도 있습니다. 관찰자로 선언된 저장 변수 및 저장 속성은 다음의 양식을 가집니다:

```swift
  var variable name: type = expression {
    willSet(setter name) {
      statements
    }
    didSet(setter name) {
      statements
    }
  }
```

이런 양식의 변수 선언은 전역 범위나, 함수의 지역 범위, 또는 클래스 및 구조체 선언에서 정의합니다. 이 양식의 변수 선언을 전역 범위나 함수의 지역 범위에서 선언할 때는, 이 관찰자를 _저장 변수 관찰자 (stored variable observers)_ 라고 합니다. 클래스나 구조체 선언에서 선언할 때는, 이 관찰자를 _속성 관찰자 (property observers)_ 라고 합니다.

속성 관찰자는 어떤 저장 속성에도 추가할 수 있습니다. [Overriding Property Observers (속성 관찰자 재정의하기)]({% post_url 2020-03-31-Inheritance %}#overriding-property-observers-속성-관찰자-재정의하기) 에서 설명한 것처럼, 하위 클래스에서 속성을 재정의하면 상속받은 어떤 속성에도 (저장 속성인지 계산 속성인지에 상관없이) 속성 관찰자를 추가할 수 있습니다.

초기자 _표현식 (expression)_[^expression] 은 클래스나 구조체 선언에서는 선택 사항이지만, 다른 곳에서는 필수 입니다. _타입 (type)_ 보조 설명은 초기자 _표현식 (expression)_ 으로부터 타입을 추론할 수 있을 때는 선택 사항입니다. 이 표현식은 속성의 값을 맨 처음 읽는 순간에 평가합니다. 속성의 초기 값을 읽지 않고 덮어 쓰면, 이 표현식은 속성에 값을 맨 처음 쓰는 순간 바로 전에 평가합니다.

`willSet` 및 `didSet` 관찰자는 변수나 속성의 값을 설정할 때 관찰 (하고 적절하게 응답) 하는 방법을 제공합니다. 변수나 속성을 맨 처음 초기화 할 때는 관찰자가 호출되지 않습니다. 그 대신, 초기화 상황 이외에서 값을 설정할 때만 호출됩니다.

`willSet` 관찰자는 변수나 속성의 값을 설정하기 바로 직전에 호출됩니다. 새로운 값은 `willSet` 관찰자에 상수로써 전달되므로, `willSet` 절의 구현부에서 이를 바꿀 수 없습니다. `didSet` 관찰자는 새 값을 설정한 바로 직후 호출됩니다. `willSet` 관찰자와는 대조적으로, `didSet` 관찰자에 전달된 변수나 속성의 예전 값은 아직 접근이 필요한 경우입니다. 즉, `didSet` 관찰자 구절에서 변수나 속성에 직접 값을 할당하는 경우, 직접 할당한 새 값이 방금 `willSet` 관찰자에서 전달하고 설정한 것을 대체하게 됩니다.

`willSet` 과 `didSet` 절에 있는 _설정자 이름 (setter name)_ 및 이를 감싼 괄호는 선택 사항입니다. 설정자 이름을 제공하면, 이를 `willSet` 및 `didSet` 관찰자의 매개 변수 이름으로 사용합니다. 설정자 이름을 제공하지 않으면, `willSet` 관찰자의 기본 매개 변수 이름은 `newValue` 으 되고 `didSet` 관찰자의 기본 매개 변수 이름은 `oldValue` 이 됩니다.

`willSet` 절을 제공 할 때면 `didSet` 절은 선택 사항이 됩니다. 마찬가지로, `didSet` 절을 제공 할 때면 `willSet` 절이 선택 사항이 됩니다.

`didSet` 관찰자의 본문에서 예전 값을 참조하는 경우, 예전 값을 사용 가능하게 만들기 위해, 관찰자 이전에 '획득자 (getter)' 가 호출됩니다. 다른 경우라면, 상위 클래스의 '획득자' 를 호출하지 않고 새 값을 저장합니다. 아래 예제는 상위 클래스에서 정의하고 하위 클래스에서 관찰자를 추가하여 재정의한 계산 속성을 보여줍니다:

```swift
class Superclass {
  private var xValue = 12
  var x: Int {
    get { print("Getter was called"); return xValue }
    set { print("Setter was called"); xValue = newValue }
  }
}

// 이 하위 클래스는 관찰자에서 oldValue 를 참조하지 않으므로,
// 상위 클래스의 획득자는 값을 출력하기 위해 한 번만 호출됩니다.
class New: Superclass {
  override var x: Int {
    didSet { print("New value \(x)") }
  }
}
let new = New()
new.x = 100
// "Setter was called" 를 출력합니다.
// "Getter was called" 를 출력합니다.
// "New value 100" 를 출력합니다.

// 이 하위 클래스는 관찰자에서 oldValue 를 참조하므로, 상위 클래스의 획득자는,
// 설정자 이전에 한 번, 그리고 값을 출력하기 위해 다시 한 번 호출됩니다.
class NewAndOld: Superclass {
  override var x: Int {
    didSet { print("Old value \(oldValue) - new value \(x)") }
  }
}
let newAndOld = NewAndOld()
newAndOld.x = 200
// "Getter was called" 를 출력합니다.
// "Setter was called" 를 출력합니다.
// "Getter was called" 를 출력합니다.
// "Old value 12 - new value 200" 를 출력합니다.
```

속성 관찰자에 대한 더 많은 정보와 이를 사용하는 방법에 대한 예제를 보려면, [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 를 참고하기 바랍니다.

#### Type Variable Properties

### Type Alias Delcaration

### Function Declaration

#### Parameter Names

#### In-Out Parameters

#### Special Kinds Paramters

#### Special Kinds Methods

#### Methods with Special Names

#### Throwing Functions and Nethods

#### Rethrowing Functions and Methods

#### Functions that Never return

### Enumeration Declaration

#### Enumerations with Cases of Any Type

**Enumerations with Indirection**

#### Enumerations with Cases of a Raw-Value Type

#### Accessing Enumeration Cases

### Structure Declaration

### Class Declaration

### Protocol Declaration (프로토콜 선언)

_프로토콜 선언 (protocol declaration)_ 은 프로그램에 '이름 있는 프로토콜 타입' 을 도입합니다. 프로토콜 선언은 `protocol` 키워드를 사용하여 '전역 범위 (global scope)' 에서 선언하며 다음 양식을 가집니다:

```swift
  protocol protocol name: inherited protocols {
    protocol member declarations
  }
```

프로토콜의 본문은, 이 프로토콜을 채택한 타입이면 어떤 것이든 반드시 충족해야 하는 '준수 필수 조건 (conformance requirements)' 을 설명하는, '0' 개 이상의 _프로토콜 멤버 선언 (protocol member declarations)_ 을 가집니다. 특히, 프로토콜은 '준수 타입 (conforming types)' 이 반드시 구현해야 하는 정해진 속성, 메소드, 초기자, 및 첨자 연산을 선언할 수 있습니다. 프로토콜은 또, _결합된 타입 (associated types)_ 이라는, 특수한 종류의 '타입 별명 (type aliases)' 을 선언하여, 프로토콜의 다양한 선언들 간의 관계를 지정할 수도 있습니다. 프로토콜 선언은 클래스, 구조체, 열거체, 또는 다른 프로토콜 선언을 가질 수 없습니다. _프로토콜 멤버 선언 (protocol member declarations)_ 은 아래에서 자세히 설명합니다.

프로토콜 타입은 다른 프로토콜을 어떤 개수든 상속할 수 있습니다. 프로토콜 타입이 다른 프로토콜을 상속할 때면, 이 다른 프로토콜에 있는 필수 조건들의 집합은 한데 모여서, 현재 프로토콜을 상속하는 타입이 어떤 것이든 이 모든 필수 조건들을 반드시 준수해야 합니다. 프로토콜 상속을 사용하는 방법에 대한 예제는, [Protocol Inheritance (프로토콜 상속)]({% post_url 2016-03-03-Protocols %}#protocol-inheritance-프로토콜-상속) 을 참고하기 바랍니다.

#### Protocol Property Declaration (프로토콜 속성 선언)

#### Protocol Method Declaration

#### Protocol Initializer Declaration

#### Protocol Subscript Declaration

#### Protocol Associated Type Declaration

### Initializer Declaration

#### Failable Initializers

### Deinitializer Declaration

### Extension Declaration

#### Conditional Conformance

**Overridden Requirements Aren't Used in Some Generic Contexts**

#### Protocol Conformance Must Not Be Redundant

**Resolving Explicit Redundancy**

**Resolving Implicit Redundancy**

### Subscipt Declaration

#### Type Subscript Declarations

### Operator Declaration

### Precedence Group Declaration

### Declaration Modifiers

#### Access Control Levels (접근 제어 수준)

스위프트는 다섯 가지 수준의 접근 제어를 제공합니다: '공개 (open)', '공용 (public)', '내부 (internal)', '파일 전용 (file private)', 그리고 '개인 전용 (private)' 이 그것입니다. 아래의 접근-수준 수정자 중 하나를 선언에 표시하여 그 선언의 접근 수준을 지정할 수 있습니다. 접근 제어는 [Access Control (접근 제어)]({% post_url 2020-04-28-Access-Control %}) 에서 더 자세하게 설명합니다.

`open`

선언에 이 수정자를 적용하면 해당 선언이 선언과 같은 모듈에 있는 코드에서 접근할 수도 있고 하위 클래스를 만들 수도 있다고 나타냅니다. `open` 접근-수준 수정자로 표시한 선언은 해당 선언을 가지고 있는 모듈을 불러온 모듈 내의 코드에서도 접근할 수 있고 하위 클래스를 만들 수 있습니다.

`public`

선언에 이 수정자를 적용하면 해당 선언이 선언과 같은 모듈에 있는 코드에서 접근할 수도 있고 하위 클래스를 만들 수도 있다고 나타냅니다. `public` 접근-수준 수정자로 표시한 선언은 해당 선언을 가지고 있는 모듈을 불러온 모듈 내의 코드에서도 접근할 수 있습니다. (하위 클래스를 만들 수는 없습니다.)

`internal`

선언에 이 수정자를 적용하면 해당 선언이 선언과 같은 모듈에 있는 코드에서만 접근할 수 있다고 나타냅니다. 기본적으로, 대부분의 선언은 암시적으로 `internal` 접근-수준 수정자로 표시됩니다.

`fileprivate`

선언에 이 수정자를 적용하면 해당 선언이 선언과 같은 소스 파일에 있는 코드에서만 접근할 수 있다고 나타냅니다.

`private`

선언에 이 수정자를 적용하면 해당 선언이 바로 그 선언을 둘러싼 영역 내에 있는 코드에서만 접근할 수 있다고 나타냅니다.

'접근 제어' 라는 용도를 위해서, 같은 파일에 있는 같은 타입에 대한 '익스텐션 (extensions)' 은 접근-제어 영역을 공유합니다. 확장하는 타입 역시 같은 파일에 있다면, 타입의 접근-제어 영역을 공유합니다. 타입의 선언에서 선언한 '개인 전용 (private)' 멤버는 '익스텐션' 에서 접근할 수 있으며, 한 '익스텐션' 에서 선언한 '개인 전용' 멤버는 다른 '익스텐션' 및 타입의 선언에서 접근할 수 있습니다.

위에 있는 각각의 접근-수준 수정자는, `set` 키워드를 괄호로 감싸서 구성한 (예를 들어, `private(set)` 같은), 단일 인자를 선택적으로 받을 수 있습니다. 이 형태의 접근-제어 수정자는, [Getters and Setters ('획득자' 와 '설정자')]({% post_url 2020-04-28-Access-Control %}#getters-and-setters-획득자-와-설정자) 에서 설명한 것처럼, 변수나 첨자 연산의 '설정자 (setter)' 에 대한 접근 수준을 변수나 첨자 연산 그 자체의 접근 수준보다 낮거나 같도록 지정하고 싶을 때 사용합니다.

### 참고 자료

[^Declarations]: 원문은 [Declarations](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html) 에서 확인할 수 있습니다.

[^expression]: 여기서의 '표현식 (expression)' 은 위 예제 양식에 있는 'expression' 을 말합니다. 클래스 선언이나 구조체 선언에서는 이 'expression' 부분이 없어도 된다는 말입니다.

[^type]: 여기서의 '타입 (type)' 보조 설명이란 위 에제 양식에 있는 'type' 을 말합니다. 뒤에 붙은 'expression' 을 통해 타입을 추론할 수 있는 경우 생략할 수 있는데, 스위프트에서는 거의 생략된 채로 사용합니다.
