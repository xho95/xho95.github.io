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

변수 선언은, 저장 및 계산 변수와 속성, 저장 변수 및 속성 관찰자, 그리고 정적 변수 속성을 포함하여, 서로 다른 종류의 이름 있는, 변경 가능한 값을 선언하는 여러 가지 형태를 가지고 있습니다. 어떤 형태를 사용하는게 적절한가 하는 것은 변수를 선언하는 영역이 어디인지 그리고 선언하고자 하는 변수의 종류가 무엇인지에 달려 있습니다.

> [Protocol Property Declaration (프로토콜 속성 선언)](#protocol-property-declaration-프로토콜-속성-선언) 에서 설명하는 것처럼, 프로토콜 선언 상황에서도 속성을 선언할 수 있습니다.

[Overriding (재정의하기)]({% post_url 2020-03-31-Inheritance %}#overriding-재정의하기) 에서 설명한 것처럼, 하위 클래스의 속성 선언을 `override` 선언 수정자로 표시하면 하위 클래스에서 속성을 재정의할 수 있습니다.

#### Stored Variables and Stored Variable Properties

#### Computed Variables and Computed Properties

#### Stored Variable Observers and Property Observers

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

### Protocol Declaration

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

위에 있는 각각의 접근-수준 수정자는, `set` 키워드를 괄호로 감싸서 구성한 (예를 들어, `private(set)` 같은), 단일 인자를 선택적으로 받을 수 있습니다. 이 형태의 접근-제어 수정자는, [Getters and Setters ('획득자' 와 '설정자')]({% post_url 2020-04-28-Access-Control %}getters-and-setters-획득자-와-설정자) 에서 설명한 것처럼, 변수나 첨자 연산의 '설정자 (setter)' 에 대한 접근 수준을 변수나 첨자 연산 그 자체의 접근 수준보다 낮거나 같도록 지정하고 싶을 때 사용합니다.

### 참고 자료

[^Declarations]: 원문은 [Declarations](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html) 에서 확인할 수 있습니다.
