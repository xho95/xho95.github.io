---
layout: post
comments: true
title:  "Swift 5.3: Declarations (선언)"
date:   2020-08-15 11:30:00 +0900
categories: Swift Language Grammar Declaration
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Declarations](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html) 부분[^Declarations]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 스위프트 5.3 에 대한 내용이 다시 일부 수정되어서,[^swift-update] 추가된 내용 먼저 옮기고 나머지 부분을 옮기도록 합니다. 전체 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Declarations (선언)

_선언 (declaration)_ 은 프로그램에 새로운 이름 또는 구조물을 도입합니다. 예를 들어, 선언을 사용하여 함수와 메소드를 도입하고, 변수와 상수를 도입하며, 열거체, 구조체, 클래스, 및 프로토콜 타입을 정의합니다. 또한 선언을 사용하면 기존 '이름 있는 타입 (named type)' 의 작동 방식을 확장할 수도 있고 다른 곳에서 선언한 '기호 (symbols)' 를 프로그램으로 불러 올 수도 있습니다.

스위프트에서는, 선언과 동시에 구현 또는 초기화 된다라는 점에서 대부분의 '선언 (declarations)' 은 또한 '정의 (definitions)' 이기도 합니다. 즉, 프로토콜은 그 멤버를 구현하지 않기 때문에, 대부분의 프로토콜 멤버는 선언이기만 합니다. 편의상 그리고 스위프트에서는 그 구별이 그다지 중요하지 않기 때문에, _선언 (declarations)_ 이라는 용어로 선언과 정의를 모두 다룹니다.

> GRAMMAR OF A DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html)

### Top-Level Code (최상위-수준 코드)

스위프트 소스 파일에 있는 '최상위-수준 코드 (top-level code)' 는 '0' 개 이상의 구문, 선언, 그리고 표현식으로 구성됩니다. 기본적으로, 소스 파일의 최상위-수준에서 선언한 변수, 상수, 및 그외 '이름 있는 선언 (named declarations)' 들은 같은 모듈에 있는 모든 소스 파일의 코드에서 접근 가능합니다. 이런 기본 작동 방식을 재정의하려면, [Access Control Levels (접근 제어 수준)](#access-control-levels-접근-제어-수준) 에서 설명한 것처럼, 선언을 '접근-수준 수정자' 로 표시하면 됩니다.

'최상위-수준 코드' 에는 두 가지 종류가 있습니다: '최상위-수준 선언 (top-level declarations)' 과 '실행 가능한 최상위-수준 코드 (excutable top-level code)' 가 그것입니다. '최상위-수준 선언' 은 선언 만으로 구성되며, 모든 스위프트 소스 파일에서 허용됩니다. '실행 가능한 최상위-수준 코드' 는, 선언뿐만 아니라, 구문과 표현식도 가지고 있으며, 프로그램에 대한 최상위-수준 진입점으로만 허용됩니다.

'실행 파일 (executable)' 을 만들기 위해 컴파일하는 스위프트 코드는, 코드가 어떻게 파일과 모듈로 구성되는 지에 상관없이, 최상위-수준 진입점을 표시하는 다음의 접근 방법 중에서 최대 한 개만을 가질 수 있습니다: `main` 특성, `NSApplicationMain` 특성, `UIApplicationMain` 특성, `main.swift` 파일, 아니면 '최상위-수준 실행 가능한 코드' 를 가지고 있는 파일.

> GRAMMAR OF A TOP-LEVEL DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID352)

### Code Blocks (코드 블럭)

코드 블럭은 다양한 선언문과 제어 구조에서 구문을 그룹화하기 위해 사용합니다. 형식은 다음과 같습니다:

{<br />
  `statements-구문`<br />
}

코드 블록 내의 _구문 (statements)_ 은 선언문, 표현식, 및 다른 종류의 구문을 포함하며 소스 코드에 있는 순서대로 실행됩니다.

> GRAMMAR OF A CODE BLOCK 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID353)

### Import Declaration (선언 불러오기)

_선언 불러오기 (import declaration)_ 는 현재 파일 밖에서 선언한 기호에 접근할 수 있도록 해줍니다. 기본 형식은 전체 모듈을 불러옵니다; 이는 `import` 키워드와 그 뒤의 모듈 이름으로 구성됩니다:

import `module-모듈`

가져올 심볼에 대한 자세한 제한을 제공하면 특정 하위 모듈이나 모듈 또는 하위 모듈 내에서 특정 선언을 지정할 수 있습니다. 이 세부 양식을 사용하면 가져온 기호 만 (이를 선언하는 모듈이 아닌) 현재 범위에서 사용할 수 있습니다.

import `import kind-불러오는 종류` `module-모듈`.`symbole name-기호 이름`<br />
import `module-모듈`.`submodule-하위 모듈`

> GRAMMAR OF AN IMPORT DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID354)

### Constant Declaration (상수 선언)

_상수 선언 (constant declaration)_ 은 '이름 있는 상수 값 (constant named value)' 을 프로그램에 도입합니다. 상수 선언은 `let` 키워드를 사용하여 선언하며 형식은 다음과 같습니다:

let `constant name-상수 이름`: `type-타입` = `expression-표현식`

상수 선언은 _상수 이름 (constant name)_ 과 초기자 _표현식 (expression)_ 의 값 사이에 '변경 불가능한 연결 (immutable binding)' 을 정의합니다; 상수의 값을 설정한 후에는, 이를 바꿀 수 없습니다. 이 말은, 상수를 클래스 객체로 초기화하면, 객체 그 자체는 바꿀 수 있지만, 상수 이름과 이를 참조하는 객체 사이의 연결은 바꿀 수 없다는 말입니다.[^immutable]

상수를 전역 범위에서 선언할 때는, 반드시 값으로 초기화 해야 합니다. 상수 선언을 함수나 메소드 안에서 한 상황일 때는, 값을 최초로 읽기 전에 값 설정을 한다는 보증만 있다면, 나중에 초기화 할 수도 있습니다. 상수 값이 절대로 읽히지 않는다는 것을 컴파일러가 증명할 수 있다면, 아예 상수에 값을 설정하는 것도 필요치 않습니다. 상수 선언을 클래스나 구조체 선언에서 한 상황일 때는, _상수 속성 (constant property)_ 으로 간주됩니다. '상수 선언' 은 '계산 속성 (computed properties)' 이 아니므로 획득자 (getter) 나 설정자 (setter) 를 가지지 않습니다.

상수 선언에서 _상수 이름 (constant name)_ 이 '튜플 패턴' 이면, 튜플에 있는 각각의 항목 이름이 '초기자 _표현식 (expression)_' 에 있는 연관된 값과 연결됩니다.

```swift
let (firstNumber, secondNumber) = (10, 42)
```

이 예제에서, `firstNumber` 는 값 `10` 에 대한 '이름 있는 상수' 이며, `secondNumber` 는 값 `42` 에 대한 '이름 있는 상수' 입니다. 두 상수 모두 이제 독립적으로 사용할 수 있습니다:

```swift
print("The first number is \(firstNumber).")
// "The first number is 10." 를 출력합니다.
print("The second number is \(secondNumber).")
// "The second number is 42." 를 출력합니다.
```

'타입 보조 설명-`:` _타입 (type)_' 은, [Type Inference (타입 추론)]({% post_url 2020-02-20-Types %}#type-inference-타입-추론) 에서 설명한 것처럼, _상수 이름 (constant name)_ 의 타입을 추론할 수 있을 때는 선택 사항입니다.

'상수 타입 속성 (constant type property)' 을 선언하려면, 선언을 `static` 선언 수정자로 표시합니다. 클래스의 '상수 타입 속성' 은 항상 암시적으로 '최종 (final)' 입니다; 하위 클래스가 재정의하는 것을 허용하거나 허용하지 않으려고 `class` 또는 `final` 선언 수정자로 표시할 수 없습니다.[^final] 타입 속성은 [Type Properties (타입 속성)]({% post_url 2020-05-30-Properties %}#type-properties-타입-속성) 에서 설명합니다.

상수에 대한 더 자세한 정보와 언제 사용하는 지에 대한 지침은, [Constants and Variables (상수와 변수)]({% post_url 2016-04-24-The-Basics %}#constants-and-variables-상수와-변수) 및 [Stored Properties (저장 속성)]({% post_url 2020-05-30-Properties %}#stored-properties-저장-속성) 을 참고하기 바랍니다.

> GRAMMAR OF A CONSTANT DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID355)

### Variable Declaration (변수 선언)

_변수 선언 (variable declaration)_ 은 프로그램에 '이름 있는 변수 값 (variable named value)' 을 프로그램에 도입하는 것으로 `var` 키워드를 사용하여 선언합니다.

변수 선언은, 저장 변수 및 속성과 계산 변수 및 속성, 저장 변수 관찰자 및 저장 속성 관찰자, 그리고 정적 변수 속성을 포함하여, 서로 다른 종류의 이름 있는, 변경 가능한 값을 선언하는 여러 가지 양식을 가지고 있습니다. 어떤 양식을 사용하는게 적절한가 하는 것은 변수를 선언하는 영역이 어디인지 그리고 선언하고자 하는 변수의 종류가 무엇인지에 달려 있습니다.

> [Protocol Property Declaration (프로토콜 속성 선언)](#protocol-property-declaration-프로토콜-속성-선언) 에서 설명하는 것처럼, 프로토콜 선언 상황에서도 속성을 선언할 수 있습니다.

[Overriding (재정의하기)]({% post_url 2020-03-31-Inheritance %}#overriding-재정의하기) 에서 설명한 것처럼, 하위 클래스의 속성 선언을 `override` 선언 수정자로 표시하면 하위 클래스에서 속성을 재정의할 수 있습니다.

#### Stored Variables and Stored Variable Properties (저장 변수와 저장 변수 속성)

다음의 형식은 '저장 변수 (stored variables)' 또는 '저장 변수 속성 (stored variable properties)'[^stored-variable-property] 을 선언합니다:

var `variable name-변수 이름`: `type-타입` = `expression-표현식`

이런 형식의 변수 선언은 '전역 범위 (global scope)' 나, 함수의 '지역 범위 (local scope)', 또는 클래스 및 구조체 선언인 상황에서 정의하게 됩니다. 이 형식의 변수 선언을 '전역 범위' 나 함수의 '지역 범위' 에서 선언할 때는, _저장 변수 (stored variable)_ 라고 합니다. 클래스나 구조체 선언인 상황에서 선언할 때는, 이를 _저장 변수 속성 (stored variable property)_ 라고 합니다.

'초기자 _표현식 (expression)_' 이 프로토콜 선언에서 있을 수는 없지만, 다른 모든 상황에서는, 초기자 _표현식 (expression)_ 이 선택 사항입니다. 이 말은, 초기자 _표현식 (expression)_ 이 아무 것도 없다면, 변수 선언은 반드시 명시적인 '타입 보조 설명-`:` _타입 (type)_' 을 포함해야 한다는 것입니다.

상수 선언에서와 마찬가지로, _변수 이름 (variable name)_ 이 '튜플 패턴' 이면, 튜플에 있는 각각의 항목 이름이 '초기자 _표현식 (expression)_' 에 있는 연관된 값과 연결됩니다.

이름으로 연상되는 것처럼, 저장 변수 또는 저장 변수 속성의 값은 메모리에 저장됩니다.

#### Computed Variables and Computed Properties (계산 변수와 계산 속성)

다음 형식은 '계산 변수 (computed variables)' 또는 '계산 속성 (computed properties)' 을 선언합니다:

var `variable name-변수 이름`: `type-타입` {<br />
  get {<br />
    `statements-구문`<br />
  }<br />
  set (`setter name-설정자 이름`) {<br />
    `statement-구문`<br />
  }<br />
}

이 형식의 변수 선언은 '전역 범위' 나, 함수의 '지역 범위' 또는, 클래스, 구조체, 열거체 및, '익스텐션 (extension; 확장)' 선언인 상황에서 정의합니다. 이 형식의 변수 선언이 '전역 범위' 나 함수의 '지역 범위' 에서 선언될 때, 이를 _계산 변수 (computed variable)_ 라고 합니다. 이를 클래스, 구조체, 또는 '익스텐션' 선언인 상황에서 선언할 때는, _계산 속성 (computed property)_ 라고 합니다.

'획득자 (getter)' 는 값을 읽는 데 사용하고, '설정자 (setter)' 는 값을 쓰는 데 사용합니다. 'setter 절' 은 선택 사항이며, 획득자만 필요할 때는, [Read-Only Computed Properties (읽기-전용 계산 속성)]({% post_url 2020-05-30-Properties %}#read-only-computed-properties-읽기-전용-계산-속성) 에서 설명한 것처럼, 두 절 모두 생략하고 요청한 값을 직접 간단히 반환할 수 있습니다. 하지만 'setter 절' 을 제공하는 경우라면, 반드시 'getter 절' 도 제공해야 합니다.

_설정자 이름 (setter name)_ 과 이를 둘러싼 괄호는 선택 사항입니다. '설정자 이름' 을 제공하면, 이를 '설정자 (setter)' 에 대한 매개 변수의 이름으로 사용합니다. '설정자 이름' 을 제공하지 않으면, [Shorthand Setter Declaration (설정자 선언의 약칭 표현)]({% post_url 2020-05-30-Properties %}#shorthand-setter-declaration-설정자-선언의-약칭-표현) 에서 설명한 것처럼, '설정자' 에 대한 '기본 설정 매개 변수 이름' 은 `newValue` 가 됩니다.

'이름 있는 저장 값'[^stored-named-values] 과 '저장 변수 속성' 과는 다르게, '이름 있는 계산 값' 의 값 또는 '계산 속성' 은 메모리에 저장되지 않습니다.

더 자세한 정보 및 계산 속성에 대한 예제는, [Computed Properties (계산 속성)]({% post_url 2020-05-30-Properties %}#computed-properties-계산-속성) 를 참고하기 바랍니다.

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

#### Type Variable Properties (타입 변수 속성)

'타입 변수 속성 (type variable property)' 을 선언하려면, 선언을 `static` 선언 수정자로 표시합니다. 클래스는 '타입 계산 속성' 을 `class` 선언 수정자로 표시하여 하위 클래스에서 상위 클래스의 구현을 재정의하도록 할 수 있습니다. 타입 속성은 [Type Properties (타입 속성)]({% post_url 2020-05-30-Properties %}#type-properties-타입-속성) 에서 논의합니다.

> GRAMMAR OF A VARIABLE DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID356)

### Type Alias Declaration (타입 별명 선언)

타입 별명 선언은 기존 타입에 대한 '이름 있는 별명' 을 프로그램에 도입합니다. 타입 별명 선언은 `typealias` 키워드를 사용하여 선언하며 다음과 같은 형식을 가집니다:

typealias `name-이름` = `existing type-기존 타입`

타입 별명을 선언한 후에는, 프로그램 어디서나 별명인 _이름 (name)_ 을 _기존 타입 (existing type)_ 대신 사용할 수 있습니다. _기존 타입 (existing type)_ '이름 있는 타입' 또는 '복합 타입 (compound type)' 일 수 있습니다. 타입 별명은 새로운 타입을 생성하는 것이 아닙니다; 이는 단순히 기존 타입을 참조하기 위한 이름을 허용하는 것입니다.

타입 별명 선언은 '제네릭 (일반화된) 매개 변수' 를 사용하여 '기존 제네릭 타입' 에 이름을 부여할 수 있습니다. 이 타입 별명은 기존 타입의 일부 또는 모든 제네릭 매개 변수에 대해서 '구체적으로 고정된 타입 (concrete type)' 을 제공할 수 있습니다. 예를 들면 다음과 같습니다:

```swift
typealias StringDictionary<Value> = Dictionary<String, Value>

// 다음의 딕셔너리들은 같은 타입입니다.
var dictionary1: StringDictionary<Int> = [:]
var dictionary2: Dictionary<String, Int> = [:]
```

타입 별명이 '제네릭 (일반화된) 매개 변수' 와 같이 선언할 때는, 해당 매개 변수의 구속 조건이 반드시 기존 타입의 제네릭 매개 변수에 대한 구속 조건과 정확하게 일치해야 합니다. 예를 들면 다음과 같습니다:

```swift
typealias DictionaryOfInts<Key: Hashable> = Dictionary<Key, Int>
```

타입 별명과 기존 타입은 서로 바꿔서 사용할 수 있어야 하기 때문에, 타입 별명이 추가적인 '제네릭 구속 조건 (generic constraints)' 을 도입할 수는 없습니다.

타입 별명은 선언에서 모든 '제네릭 매개 변수' 를 생략하는 것으로써 기존 타입의 '제네릭 매개 변수' 를 전달할 수 있습니다. 예를 들어, 아래에서 선언한 `Diccionario` 타입 별명은 `Dictionary` 와 똑같은 '제네릭 매개 변수' 와 '구속 조건' 을 가집니다.

```swift
typealias Diccionario = Dictionary
```

프로토콜 선언 내에서, 타입 별명은 자주 사용하는 타입에 대해 더 짧고 더 편리한 이름을 부여할 수 있습니다. 예를 들면 다음과 같습니다:

```swift
protocol Sequence {
  associatedtype Iterator: IteratorProtocol
  typealias Element = Iterator.Element
}

func sum<T: Sequence>(_ sequence: T) -> Int where T.Element == Int {
  // ...
}
```

이 타입 별명이 없다면, `sum` 함수는 '결합된 타입' 을 `T.Element` 가 아니라 `T.Iterator.Element` 라고 참조해야 할 것입니다.

[Protocol Associated Type Declaration (프로토콜의 결합된 타입 선언)](#protocol-associated-type-declaration-프로토콜의-결합된-타입-선언) 을 참고하기 바랍니다.

> GRAMMAR OF A TYPE ALIAS DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID361)

### Function Declaration (함수 선언)

_함수 선언 (function declaration)_ 은 함수 또는 메소드를 프로그램에 도입합니다. 클래스, 구조체, 열거체, 또는 프로토콜인 상황 속에서 선언된 함수를 _메소드 (method)_ 라고 합니다. '함수 선언' 은 `func` 키워드를 사용하여 선언하며 다음과 같은 형식을 가집니다:

func `function name-함수 이름`(`parameters-매개 변수`) -> `return type-반환 타입` {<br />
  `statements-구문`<br />
}

함수의 반환 타입이 `Void` 인 경우, 이 반환 타입은 다음처럼 생략할 수 있습니다:

func `function name-함수 이름`(`parameters-매개 변수`) {<br />
  `statements-구문`<br />
}

각각의 매개 변수에 대한 타입은 반드시 포함해야 합니다-이는 추론될 수 있는 것이 아닙니다. `inout` 을 매개 변수의 타입 앞에 작성하면, 이 매개 변수는 함수 영역 내에서 수정할 수 있게 됩니다. '입-출력 매개 변수' 는 아래의, [In-Out Parameters (입-출력 매개 변수)](#in-out-parameters-입-출력-매개-변수) 에서 자세하게 논의합니다.

그 _구문 (statements)_ 이 단일 표현식만을 포함하고 있는 함수 선언은 해당 표현식의 값을 반환하는 것으로 이해합니다. 표현식의 타입과 함수의 반환 타입이 `Void` 가 아닐 때 그리고 `Never` 처럼 어떤 'case 값' 도 가지지 않는 열거체가 아닐 때에만 이 '암시적인 반환 구문 표현 (implicit return syntax)' 이 고려됩니다.

튜플 타입을 함수의 반환 타입으로 사용하면 함수가 여러 개의 값을 반환 할 수 있습니다.

또 다른 함수 선언 안에 '함수 정의 (function definition)'[^function-definition] 가 있을 수 있습니다. 이런 종류의 함수를 _중첩 함수 (nested function)_ 라고 합니다.

중첩 함수는 in-out 매개 변수와 같이 절대 이스케이프되지 않는 값을 캡처하거나 비스 케이 핑 함수 인수로 전달되는 경우 비스 케이 핑입니다. 그렇지 않으면 중첩 된 함수는 이스케이프 함수입니다.

중첩 함수는 절대로 벗어나지 않는다는 것을 보증하는 값-가령 '입-출력 매개 변수 (in-out parameter)'-또는 '벗어나지 않는 함수 인자 (nonescaping function argument)' 로 전달한 것-을 붙잡을 경우 '벗어나지 않는 (nonescaping)' 것이 됩니다. 다른 경우라면, 중첩 함수는 '벗어나는 함수 (escaping function)' 가 됩니다.

중첩 함수에 대한 논의는, [Nested Functions (중첩 함수)]({% post_url 2020-06-02-Functions %}#nested-functions-중첩-함수) 를 참고하기 바랍니다.

#### Parameter Names (매개 변수 이름)

함수 매개 변수는 각각의 매개 변수가 여러 가지 형식 중 하나를 가지는 쉼표로-구분된 목록을 말합니다. 함수 호출에 있는 인자 순서는 반드시 함수 선언에 있는 매개 변수 순서와 일치해야 합니다. 매개 변수 목록에서 가장 단순한 '참가자 (entry)' 의 형식은 다음과 같습니다:

`parameter name-매개 변수 이름`: `parameter type-매개 변수 타입`

매개 변수는, 함수 본문에서 사용하는, 이름과 함께, 함수 또는 메소드를 호출할 때 사용하는, '인자 이름표 (argument label)' 도 가집니다. 기본적으로, 매개 변수 이름을 '인자 이름표' 로도 사용합니다. 예를 들면 다음과 같습니다:

```swift
func f(x: Int, y: Int) -> Int { return x + y }
f(x: 1, y: 2) // x 와 y 모두 이름표가 있습니다.
```

인자 이름표의 기본 작동 방식을 다음 형식 중 하나를 가지고 '재정의 (override)' 할 수 있습니다.

`argument label-인자 이름표` `parameter name-매개 변수 이름`: `parameter type-매개 변수 타입`<br />
\_ `parameter name-매개 변수 이름`: `parameter type-매개 변수 타입`

매개 변수 이름 앞에 있는 이름은, 매개 변수 이름과 다를 수 있는, 명시적인 인자 이름표를 매개 변수에 부여합니다. 이와 관련된 인자는 반드시 함수 또는 메소드 호출 시에 주어진 인자 이름표를 사용해야 합니다.

매개 변수 이름 앞에 있는 '밑줄 (`_`)' 은 '인자 이름표' 를 억제합니다. 이와 관련된 인자는 반드시 함수 또는 메소드 호출 시에 이름표를 가지지 않아야 합니다.

```swift
func repeatGreeting(_ greeting: String, count n: Int) { /* 인사를 n 번 합니다 */ }
repeatGreeting("Hello, world!", count: 2) //  count 는 이름표가 있지만, greeting 은 그렇지 않습니다.
```

#### In-Out Parameters (입-출력 매개 변수)

입-출력 매개 변수는 다음 처럼 전달됩니다:

1. 함수를 호출할 때, 인자의 값을 복사합니다.
2. 함수 본문에서, 이 복사본을 수정합니다.
3. 함수를 반환할 때, 복사본의 값을 원래 인자에 할당합니다.

이러한 작동 방식을 _복사-입력 복사-출력 (copy-in copy-out)_ 또는 _값-결과에 의한 호출 (call by value result)_[^call-by-value-result] 라고 합니다. 예를 들어, 계산 속성이나 관찰자를 가진 속성을 입-출력 매개 변수로 전달하면, 함수 호출 시에는 '획득자 (getter)' 가 호출되고 함수 반환 시에는 '설정자 (setter)' 가 호출됩니다.

최적화에 따라서, 인자가 메모리에 있는 물리적 주소에 저장된 값일 때는, 함수 본문의 내부와 외부 둘 다에서 같은 메모리 위치를 사용합니다. 이런 최적화된 작동 방식을 _참조에 의한 호출 (call by reference)_ 이라고 합니다; 이는 '복사-입력 복사-출력' 모델의 필수 조건을 모두 만족하면서 복사에 따른 부담도 제거합니다. 코드를 '복사-입력 복사-출력' 으로 주어진 모델을 사용하여 작성하면, '참조에 의한 호출' 최적화에 의존하지 않으므로, 최적화를 하든 하지 않든 올바르게 작동합니다.

함수 내에서, 원본 값이 현재 영역에서 사용 가능하더라도, '입-출력 인자' 로 전달된 값에는 접근하지 않도록 합니다. 원본에 접근하는 것은 값에 대한 동시 접근이 되어, 스위프트의 '메모리 독점권 보증 (memory exclusivity gurantee)' 을 위반합니다. 같은 이유로 인하여, 같은 값을 여러 개의 입-출력 매개 변수로 전달할 수 없습니다.

메모리 안전성 및 메모리 독점권에 대한 더 자세한 정보는, [Memory Safety (메모리 안전성)]({% post_url 2020-04-07-Memory-Safety %}) 를 참고하기 바랍니다.

입-출력 매개 변수를 붙잡는 클로저나 중첩 함수는 반드시 '벗어나지 않는 (nonescaping)' 것 이어야 합니다. 입-출력 매개 변수를 변경없이 붙잡거나 아니면 다른 코드가 바꿨는지 관찰할 필요가 있는 경우, '붙잡을 목록 (capture list)' 을 사용하여 매개 변수를 명시적으로 변경 불가능하게 붙잡아야 합니다.

```swift
func someFunction(a: inout Int) -> () -> Int {
  return { [a] in return a + 1 }
}
```

입-출력 매개 변수를 붙잡아서 변경해야할 필요가 있는 경우, 함수 반환 전에 모든 변경을 마쳤다고 보장하는 다중 쓰레드 코드 처럼, 명시적인 지역 복사본을 사용하도록 합니다:

```swift
func multithreadedFunction(queue: DispatchQueue, x: inout Int) {
  // 지역 복사본을 만들고 이를 다시 수동으로 되돌려서 복사합니다.
  var localX = x
  defer { x = localX }

  // localX 에 대한 비동기 연산을 한 후, 반환 전에 기다립니다.
  queue.async { someMutatingOperation(&localX) }
  queue.sync {}
}
```

더 많은 논의와 입-출력 매개 변수에 대한 예제는, [In-Out Parameters (입-출력 매개 변수)]({% post_url 2020-06-02-Functions %}#in-out-parameters-입-출력-매개-변수) 를 참고하기 바랍니다.

#### Special Kinds of Paramters (특수한 종류의 매개 변수)

매개 변수는, 다음의 형식을 사용하여, 무시할 수도 있고, 다양한 개수의 값을 받을 수 있으며, 기본 설정 값을 제공할 수도 있습니다:

\_ : `parameter type-매개 변수 타입`<br />
`parameter name-매개 변수 이름`: `parameter type-매개 변수 타입`...<br />
`parameter name-매개 변수 이름`: `parameter type-매개 변수 타입` = `default argument value-기본 설정 인자 값`

'밑줄 (`_`) 매개 변수' 는 명시적으로 무시되며 함수 본문에서 접근할 수 없습니다.

기본 타입 이름 바로 뒤에 세 점 (`...`) 이 있는 매개 변수는 '가변 매개 변수 (variadic parameter)' 인 것으로 이해합니다. 함수는 최대 하나의 '가변 매개 변수' 를 가질 수 있습니다. 가변 매개 변수는 기본 타입 이름의 원소를 담고 있는 배열로 취급합니다. 예를 들어, 가변 매개 변수 `Int...` 는 `[Int]` 인 것으로 취급합니다. 가변 매개 변수를 사용하는 예제에 대해서는, [Variadic Parameters (가변 매개 변수)]({% post_url 2020-06-02-Functions %}#variadic-parameters-가변-매개-변수) 를 참고하기 바랍니다.

타입 뒤에 '등호 (`=`)' 와 표현식이 있는 매개 변수는 주어진 표현식 형태의 기본 설정 값을 가진다고 이해합니다. 주어진 표현식은 함수를 호출할 때 값을 평가합니다. 함수를 호출할 때 매개 변수를 생략하면, 기본 설정 값을 대신 사용하게 됩니다.

```swift
func f(x: Int = 42) -> Int { return x }
f()       // 유효함, 기본 설정 값을 사용
f(x: 7)   // 유효함, 제공된 값을 사용
f(7)      // 무효함, 인자 이름표가 누락됨
```

#### Special Kinds of Methods (특수한 종류의 메소드)

열거체 또는 구조체의 `self` 를 수정하는 메소드는 반드시 `mutating` '선언 수정자 (declaration modifier)' 로 표시해야 합니다.

상위 클래스의 메소드를 재정의하는 메소드는 반드시 `override` '선언 수정자' 로 표시해야 합니다. 메소드를 `override` 수정자 없이 재정의 하는 것 또는 상위 클래스의 메소드를 재정의하지 않는 메소드에 `override` 수정자를 사용하는 것은 컴파일-시간에 에러가 됩니다.

타입의 인스턴스가 아닌 타입 자체와 결합된 메소드는 열거체와 구조체에서는 `static` 선언 수정자로, 클래스에 대해서는 `static` 또는 `class` 중 하나의 선언 수정자로 반드시 표시해야 합니다. `class` 선언 수정자로 표시한 클래스 타입 메소드는 하위 클래스 구현에서 재정의할 수 있습니다; `class final` 또는 `static` 으로 표시한 클래스 타입 메소드는 재정의할 수 없습니다.

#### Methods with Special Names (특수한 이름을 가진 메소드)

특수한 이름을 가지는 몇몇 메소드들은 '함수 호출 구문 표현 (function call syntax)' 이라는 '수월한 구문 표현 (syntactic sugar)' 을 사용할 수 있게 해줍니다.[^syntatic-sugar] 타입이 이 메소드 중 하나를 정의하면, 이 타입의 인스턴스는 '함수 호출 구문 표현' 에서 사용할 수 있습니다. 함수 호출은 해당 인스턴스에 있는 '특수한 이름을 가진 메소드' 들 중 하나에 대한 호출인 것으로 이해합니다.

클래스, 구조체, 또는 열거체는, [dynamicCallable (동적으로 호출 가능한)]({% post_url 2020-08-14-Attributes %}#dynamiccallable-동적으로-호출-가능한) 에서 설명한 것처럼, `dynamicallyCall(withArguments:)` 메소드나 `dynamicallyCall(withKeywordArguments:)` 메소드를 정의하는 것, 또는 아래에서 설명하는 것처럼, 함수-처럼-호출하는 메소드 (call-as-function method) 를 정의하는 것으로써, '함수 호출 구문 표현' 을 지원할 수 있습니다. 타입이 '함수-처럼-호출하는 메소드' 와 `dynamicCallable` 특성을 사용하는 메소드 중 하나를 둘 다 정의하고 있는 경우, 컴파일러는 어느 메소드도 사용할 수 있는 상황에서 '함수-처럼-호출하는 메소드 (call-as-function method)' 에 우선권을 부여합니다.

'함수-처럼-호출하는 메소드' 의 이름은 `callAsFunction()`, 또는 `callAsFunction(` 으로 시작해서 이름표가 있는 인자나 이름표가 없는 인자를 추가한 또 다른 형태의 이름입니다.-예를 들어, `callAsFunction(_:_:)` 및 `callAsFunction(something:)` 역시 '함수-처럼-호출하는 메소드' 이름으로 유효합니다.

다음의 함수 호출은 서로 '동치 (equivalent)' 입니다:

```swift
struct CallableStruct {
  var value: Int
  func callAsFunction(_ number: Int, scale: Int) {
    print(scale * (number + value))
  }
}
let callable = CallableStruct(value: 100)
callable(4, scale: 2)
callable.callAsFunction(4, scale: 2)
// 두 함수 호출 모두 208 을 출력합니다.
```

'함수-처럼-호출하는 메소드' 와 `dynamicCallable` 특성을 사용하는 메소드는 타입 시스템에 얼마나 많은 정보를 '코딩 (encode)' 하는 지와 실행 시간에 얼마나 많은 동적 동작이 가능한 지 사이에 서로 다른 모순점을 만듭니다. '함수-처럼-호출하는 메소드' 를 선언할 때는, 인자의 개수와, 각각의 인자의 타입과 이름표를 지정해야 합니다. `dynamicCallable` 특성의 메소드는 인자 배열을 쥐고 있는 데 사용되는 타입만 지정합니다.

'함수-처럼-호출하는 메소드', 또는 `dynamicCallable` 특성인 메소드를 정의하는 것은, '함수 호출 표현식' 이 아닌 어떠한 상황에서도 마치 그것이 함수인 것처럼 해당 타입의 인스턴스를 사용하도록 하는 것은 아닙니다. 예를 들면 다음과 같습니다:

```swift
let someFunction1: (Int, Int) -> Void = callable(_:scale:)  // 에러
let someFunction2: (Int, Int) -> Void = callable.callAsFunction(_:scale:)
```

`subscript(dynamicMemberLookup:)` 첨자 연산은, [dynamicMemberLookup (동적으로 멤버 찾아보기)]({% post_url 2020-08-14-Attributes %}#dynamicmemberlookup-동적으로-멤버-찾아보기) 에서 설명한 것처럼, 멤버를 찾아보기 위한 '수월한 구문 표현' 을 사용할 수 있게 해줍니다.

#### Throwing Functions and Methods (던지는 함수 및 메소드)

에러를 던질 수 있는 함수와 메소드는 반드시 `throws` 키워드로 표시해야 합니다. 이러한 함수와 메소드를 _던지는 함수 (throwing functions)_ 및 _던지는 메소드 (throwing methods)_ 라고 합니다. 형식은 다음과 같습니다:

func `function name`(`parameters`) throws -> `return type` {
<br />
    `statements`
<br />
}

던지는 함수 또는 던지는 메소드에 대한 호출은 반드시 `try` 나 `try!` 표현식 (즉, `try` 나 `try!` 연산자의 영역 안) 으로 포장돼야 합니다.

`throws` 키워드는 함수 타입의 일부이며, '던지지 않는 함수 (nonthrowing functions)' 는 '던지는 함수' 의 하위 타입입니다. 그 결과, '던지지 않는 함수' 를 '던지는 함수' 와 같은 위치에 사용할 수 있습니다.

함수가 에러를 던질 수 있는 지의 여부 만을 기준으로 하여 함수를 '중복 정의 (overload)' 할 수는 없습니다. 이 말은, 함수의 _매개 변수 (parameter)_ 가 에러를 던질 수 있는 지의 여부를 기준으로는 함수를 중복 정의할 수 있다는 말입니다.

'던지는 메소드' 는 '던지지 않는 메소드' 를 재정의할 수 없으며, '던지는 메소드' 는 '던지지 않는 메소드' 에 대한 프로토콜 필수 조건을 만족할 수 없습니다. 이 말은, '던지지 않는 메소드' 는 '던지는 메소드' 를 재정의할 수 있고, '던지지 않는 메소드' 는 '던지는 메소드' 에 대한 프로토콜 필수 조건을 만족할 수 있다는 말입니다.

#### Rethrowing Functions and Methods (다시 던지는 함수 및 메소드)

함수 또는 메소드는 함수 매개 변수 중 하나가 에러를 던지는 경우에만 에러를 던진다는 것을 나타내기 위해 `rethrows` 키워드로 선언할 수 있습니다. 이러한 함수 및 메소드를 _다시 던지는 함수 (rethrowing functions)_ 및 _다시 던지는 메소드 (rethrowing methods)_ 라고 합니다. '다시 던지는 함수' 와 '다시 던지는 메소드' 는 반드시 최소한 하나의 '던지는 함수 매개 변수 (throwing function parameter)' 를 가져야 합니다:

```swift
func someFunction(callback: () throws -> Void) rethrows {
  try callback()
}
```

다시 던지는 함수 또는 다시 던지는 메소드는 `catch` 절 안에서만 `throw` 문을 가질 수 있습니다. 이는 `do`-`catch` 구문 안에서 '던지는 함수' 를 호출하고 `catch` 절에서는 다른 에러를 던지는 것으로 에러를 처리하게 해줍니다. 여기에 더하여, `catch` 절은 반드시 '다시 던지는 함수' 의 '던지는 매개 변수'[^throwing-parameter] 중 하나에서 던지는 에러만 처리해야 합니다. 예를 들어, 다음은 `catch` 절이 `alwaysThrows()` 가 던지는 에러를 처리하게 되므로 무효입니다.

```swift
func alwaysThrows() throws {
  throw SomeError.error
}
func someFunction(callback: () throws -> Void) rethrows {
  do {
    try callback()
    try alwaysThrows()  // 무효입니다, alwaysThrows() 는 던지는 매개 변수가 아닙니다.
  } catch {
    throw AnotherError.error
  }
}
```

'던지는 메소드' 는 '다시 던지는 메소드' 를 재정의할 수 없으며, '던지는 메소드' 는 '다시 던지는 메소드' 에 대한 프로토콜 필수 조건을 만족할 수 없습니다. 이 말은, '다시 던지는 메소드' 는 '던지는 메소드' 를 재정의할 수 있으며, '다시 던지는 메소드' 는 '던지는 메소드' 에 대한 프로토콜 필수 조건을 만족할 수 있다는 말입니다.

#### Functions that Never return ('Never' 를 반환하는 함수)

스위프트는, 함수나 메소드가 호출하는 쪽으로 반환하지 않는다는 것을 지시하는, `Never` 타입을 정의하고 있습니다. `Never` 라는 반환 타입을 가지는 함수나 메소드를 _반환하지 않는 (nonreturning)_ 것이라고 합니다. '반환하지 않는 함수와 메소드' 는 복구할 수 없는 에러를 유발하거나 '무기한으로 계속되는 일련의 작업' 을 시작합니다.[^indefinitely] 이는 다른 경우라면 호출 후에 즉시 실행할 코드가 절대로 실행되지 않는다는 것을 의미합니다. '던지는 함수 (throwing function)' 및 '다시 던지는 함수 (rethrowing function)' 는, '반환하지 않는' 것이더라도, 적절한 `catch` 블럭으로 프로그램 제어를 전달할 수 있습니다.

반환하지 않는 함수 또는 반환하지 않는 메소드는, [Guard Statement ('guard' 문)]({% post_url 2020-08-20-Statements %}#guard-statement-guard-문) 에서 설명한 것처럼, 'guard 문' 의 `else` 절을 ​​끝내기 위해 호출할 수 있습니다.

반환하지 않는 메소드를 재정의할 수는 있지만, 이 새로운 메소드는 반드시 반환 타입과 '반환하지 않는' 동작 방식을 보존해야 합니다.

> GRAMMAR OF A FUNCTION DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID362)

### Enumeration Declaration (열거체 선언)

_열거체 선언 (enumeration declaration)_ 은 '이름 있는 열거체 타입' 을 프로그램에 도입합니다.

'열거체 선언' 에는 두 가지의 기본 형식이 있으며 `enum` 키워드를 사용하여 선언합니다. 어느 형식으로든 열거체를 선언하면 그 본문은 '0' 개 이상의-열거체 'case 값' 이라고 하는-값과 더불어, 계산 속성, 인스턴스 메소드, 타입 메소드, 초기자, 타입 별명, 그리고 심지어 다른 열거체, 구조체, 및 클래스 선언을 포함한, 선언들을 개수가 몇 개든 가집니다. 열거체 선언은 '정리자 (deinitializer)' 또는 '프로토콜 선언' 을 가질 수 없습니다.

열거체 타입은 어떤 개수의 프로토콜도 채택할 수 있지만, 클래스, 구조체, 또는 다른 열거체를 상속할 수는 없습니다.

클래스 및 구조체와는 다르게, 열거체 타입은 암시적으로 제공되는 '기본 설정 초기자 (default initializer)' 를 가지지 않습니다; 모든 초기자는 반드시 명시적으로 선언해야 합니다. 초기자가 열거체 내의 다른 초기자로 위임을 할 수 있지만, 초기화 과정은 초기자가 열거체 'case 값' 중 하나를 `self` 에 할당한 후에만 완료돼야 합니다.

클래스와는 다르지만 구조체와는 비슷하게, 열거체는 값 타입입니다; 열거체의 인스턴스는 변수나 상수에 할당할 때, 또는 함수 호출에 대한 인자로 전달할 때, 복사됩니다. 값 타입에 대한 정보는, [Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#structures-and-enumerations-are-value-types-구조체와-열거체는-값-타입입니다) 를 참고하기 바랍니다.

열거체 타입의 작동 방식은, [Extension Declaration (익스텐션-확장 선언)](#extension-declaration-익스텐션-확장-선언) 에서 논의한 것처럼, '익스텐션 선언 (확장 선언)' 으로 확장할 수 있습니다.

#### Enumerations with Cases of Any Type (어떤 타입이어도 되는 'case 값' 을 가지는 열거체)

다음 형식은 어떤 타입이어도 되는 열거체 'case 값' 을 가지고 있는 열거체 타입을 선언합니다:

enum `enumeration name-열거체 이름`: `adopted protocols-채택한 프로토콜` {<br />
    case `enumeration case 1-열거체 case 값 1`<br />
    case `enumeration case 2-열거체 case 값 2`(`associated value types 결합된 값의 타입`)<br />
}

이런 형식으로 선언한 열거체를 다른 프로그래밍 언어에서는 때때로 _discriminated unions (차별화된 공용체)_ 라고 합니다.

이 형식에서, 각각의 'case' 블럭은 `case` 키워드 및 그 뒤의, 쉼표로 구분된, 하나 이상의 열거체 'case 값' 으로 구성됩니다. 각 'case 값' 의 이름은 반드시 유일해야 합니다. 각 'case 값' 은 주어진 타입의 값을 저장하도록 지정할 수도 있습니다. 이런 타입은, 'case 값' 의 이름 바로 뒤에, _결합된 값의 타입 (associated value types)_ 튜플에서 지정합니다.

'결합된 값' 을 저장하는 열거체 'case 값' 은 지정된 '결합 값 (associated values)' 으로 열거체의 인스턴스를 생성하는 함수인 것처럼 사용할 수 있습니다. 그리고 함수에서와 같이, 열거체 'case 값' 에 대한 참조를 가지고 이를 이후의 코드에 적용할 수도 있습니다.

```swift
enum Number {
  case integer(Int)
  case real(Double)
}
let f = Number.integer
// f 는 타입이 (Int) -> Number 인 함수입니다.

// 정수 값으로 된 Number 인스턴스의 배열을 생성하기 위해 f 를 적용합니다.
let evenInts: [Number] = [0, 2, 4, 6].map(f)
```

더 많은 정보 및 결합된 값의 타입을 가지는 'case 값' 에 대한 예제를 보려면, [Associated Values (결합된 값)]({% post_url 2020-06-13-Enumerations %}#associated-values-결합된-값) 를 참고하기 바랍니다.

**Enumerations with Indirection ('간접 (indirection)' 을 가지는 열거체)**

열거체는 '재귀적인 구조 (recursive structure)' 를 가질 수 있는데, 그 말인즉슨, 열거체 타입 그 자체의 인스턴스이기도 한 '결합된 값' 을 가지는 'case 값' 을 가질 수 있다는 것입니다. 하지만, 열거체 타입의 인스턴스는 '값' 의미 구조를 가지며, 이는 메모리 상에서 '고정된 구획 (fixed layout)' 을 가진다는 것을 의미합니다. '재귀 (recursion)' 를 지원하기 위해서는, 컴파일러가 반드시 '간접 계층 (layer of indirection)' 을 집어 넣어야 합니다.

특정 열거체 'case 값' 이 '간접 (indirection)' 할 수 있게 하려면, 이를 `indirect` 선언 수정자로 표시합니다. 간접 'case 값' 은 반드시 '결합된 값' 을 가져야 합니다.

```swift
enum Tree<T> {
  case empty
  indirect case node(value: T, left: Tree, right: Tree)
}
```

'결합된 값' 을 가지는 모든 열거체 'case 값' 이 '간접 (indirection)' 할 수 있게 하려면, 열거체 전체를 `indirect` 수정자로 표시합니다-열거체가 `indirect` 수정자로 표시해야 하는 'case 값' 을 아주 많이 가지고 있을 때 편리합니다.

`indirect` 수정자로 표시한 열거체는 '결합된 값' 을 가지는 'case 값' 과 그렇지 않은 'case 값' 이 혼합된 것을 가질 수 있습니다. 그건 그렇고, 또한 `indirect` 수정자로 표시한 'case 값' 은 어떤 것이든 가질 수 없습니다.

#### Enumerations with Cases of a Raw-Value Type (원시-값 타입의 'case 값' 을 가지는 열거체)

다음 형식은 기본 타입이 같은 열거체 'case 값' 을 가지는 열거체 타입을 선언합니다:

enum `enumeration name-열거체 이름`: `raw-value type-원시-값 타입`, `adopted protocols-채택한 프로토콜` {<br />
    case `enumeration case 1-열거체 case 값 1` = `원시 값 1-raw value 1`<br />
    case `enumeration case 2-열거체 case 값 2` = `원시 값 2-raw value 2`<br />
}

이 형식에서, 각각의 'case' 블럭은 `case` 키워드와, 그 뒤에 하나 이상의 열거체 'case 값' 을, 쉼표로 구분한 것으로 구성됩니다. 첫 번째 형식의 'case 값' 과는 다르게, 각각의 'case 값' 은, 기본 타입이 같은, _원시 값 (raw value)_ 라고 하는, 실제의 값을 가집니다. 이 값의 타입은 _원시-값 타입 (raw-value type)_ 으로 지정하는데, 반드시 정수, 부동 소수점 수, 문자열, 또는 단일 문자를 표현해야 합니다. 특히, _원시-값 타입 (raw-value type)_ 은 `Equatable` 프로토콜과 다음 프로토콜 중 하나를 반드시 준수해야 합니다: '정수 글자 값' 일 때는 `ExpressibleByIntegerLiteral`, '부동-소수점 글자 값' 일 때는 `ExpressibleByFloatLiteral`, 어떤 개수의 문자라도 가질 수 있는 '문자열 글자 값' 일 때는 `ExpressibleByStringLiteral`, 그리고 단 하나의 문자만을 가질 수 있는 '문자열 글자 값' 일 때는 `ExpressibleByUnicodeScalarLiteral` 또는 `ExpressibleByExtendedGraphemeClusterLiteral` 입니다. 각각의 'case 값' 은 반드시 유일한 이름을 가져야 하며 유일한 원시 값을 할당해야 합니다.

원시-값 타입을 `Int` 로 지정하고서 'case 값' 을 명시적으로 할당하지 않으면, `0`, `1`, `2`, 등의 값이 암시적으로 할당됩니다. 할당되지 않은 각각의 `Int` 타입 'case 값' 은 이전 'case 값' 의 '원시 값' 에서 자동으로 증가된 '원시 값' 을 암시적으로 할당합니다.

```swift
enum ExampleEnum: Int {
  case a, b, c = 5, d
}
```

위 예제에서, `ExampleEnum.a` 의 원시 값은 `0` 이고 `ExampleEnum.b` 의 값은 `1` 입니다. 그리고 `ExampleEnum.c` 의 값을 명시적으로 `5` 로 설정했기 때문에, `ExampleEnum.d` 의 값은 `5` 에서 자동으로 증가한 `6` 가 됩니다.

원시-값 타입을 `String` 으로 지정하고서 'case 값' 을 명시적으로 할당하지 않으면, 할당되지 않은 각각의 'case 값' 은 암시적으로 해당 'case 값' 의 이름과 똑같은 문장으로 된 문자열을 할당합니다.

```swift
enum GamePlayMode: String {
  case cooperative, individual, competitive
}
```

위 예제에서, `GamePlayMode.cooperative` 의 원시 값은 `"cooperative"`, `GamePlayMode.individual` 의 원시 값은 `"individual"`, 그리고 `GamePlayMode.competitive` 의 원시 값은 `"competitive"` 입니다.

원시-값 타입의 'case 값' 을 가지는 열거체는, 스위프트 표준 라이브러리에서 정의한, `RawRepresentable` 프로토콜을 암시적으로 준수합니다. 그 결과, `rawValue` 속성과 '서명 (signature)' `init?(rawValue: RawValue)` 인 '실패 가능한 초기자 (failable initializer)' 를 가집니다.
`rawValue` 속성을 사용하면, `ExampleEnum.b.rawValue` 에서와 같이, 열거체 'case 값' 의 '원시 값' 에 접근할 수 있습니다. 원시 값과 연관되어 있는 'case 값' 이, 하나라도 있는 경우, `ExampleEnum(rawValue: 5)` 에서와 같이, 옵셔널 'case 값' 을 반환하는, 열거체의 '실패 가능한 초기자' 를 호출하여 찾을 수도 있습니다. 더 많은 정보와 원시-값 타입의 'case 값' 에 대한 예제를 보려면, [Raw Values (원시 값)]({% post_url 2020-06-13-Enumerations %}#raw-values-원시-값) 을 참고하기 바랍니다.

#### Accessing Enumeration Cases (열거체의 'case 값' 에 접근하기)

열거체 타입의 'case 값' 을 참조하려면, `EnumerationType.enumerationCase` 에서와 같이, '점 (`.`) 구문 표현' 을 사용합니다. 열거체 타입을 추론할 수 있는 상황일 때는, [Enumeration Syntax (열거체 구문 표현)]({% post_url 2020-06-13-Enumerations %}#enumeration-syntax-열거체-구문-표현) 과 [Implicit Member Expression (암시적인 멤버 표현식)]({% post_url 2020-08-19-Expressions %}#implicit-member-expression-암시적인-멤버-표현식) 에서 설명한 것처럼, 이를 생략할 수 있습니다 ('점' 은 그래도 필수입니다).

열거체 'case 값' 의 값을 검사하려면, [Matching Enumeration Values with a Switch Statement ('switch' 문으로 열거체 값 맞춰보기)]({% post_url 2020-06-13-Enumerations %}#matching-enumeration-values-with-a-switch-statement-switch-문으로-열거체-값-맞춰보기) 에서 본 것처럼, `switch` 문을 사용합니다. 열거체 타입은, [Enumeration Case Pattern (열거체 case 값 패턴)]({% post_url 2020-08-25-Patterns %}#enumeration-case-pattern-열거체-case-값-패턴) 에서 설명한 것처럼, `switch` 문의 'case 절' 블럭에 있는 '열거체 case 값 패턴' 과 유형이 일치하는 지를 맞춰보게 됩니다.

> GRAMMAR OF AN ENUMERATION DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID364)

### Structure Declaration (구조체 선언)

_구조체 선언 (structure declaration)_ 은 '이름 있는 구조체 타입' 을 프로그램에 도입합니다. 구조체 선언은 `struct` 키워드를 사용하여 선언하며 형식은 다음과 같습니다:

struct `structure name-구조체 이름`: `adopted protocols-채택한 프로토콜` {<br />
  `declarations-선언`<br />
}

구조체의 본문은 '0' 개 이상의 _선언 (declarations)_ 들을 담고 있습니다. 이 _선언 (declarations)_ 들은 저장 및 계산 속성 둘 모두와, 타입 속성, 인스턴스 메소드, 타입 메소드, 초기자, 첨자 연산, 타입 별명, 그리고 심지어 다른 구조체, 클래스, 및 열거체 선언을 포함할 수 있습니다. 구조체 선언은 '정리자 (deinitializer)' 또는 '프로토콜 선언' 을 가질 수 없습니다. 다양한 종류의 선언을 포함하고 있는 구조체에 대한 여러 가지 예제와 논의들은, [Structures and Classes (구조체와 클래스)]({% post_url 2020-04-14-Structures-and-Classes %}) 를 참고하기 바랍니다.

구조체 타입은 어떤 개수의 프로토콜이든 채택할 수 있지만, 클래스, 열거체, 또는 다른 구조체를 상속할 수는 없습니다.

이전에 선언한 구조체의 인스턴스를 생성하는 방법은 세 가지가 있습니다:

* [Initializers (초기자)]({% post_url 2016-01-23-Initialization %}#initializers-초기자) 에서 설명한 것처럼, 구조체에서 선언한 초기자 중 하나를 호출합니다.
* 선언한 초기자가 없는 경우, [Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)]({% post_url 2016-01-23-Initialization %}#memberwise-initializers-for-structure-types-구조체-타입을-위한-멤버-초기자) 에서 설명한 것처럼, 구조체의 '멤버 초기자 (memberwise initializer)' 를 호출합니다.
* 선언한 초기자가 없지만, 구조체 선언의 모든 속성에 초기 값이 주어진 경우, [Default Initializers (기본 설정 초기자)]({% post_url 2016-01-23-Initialization %}#default-initializers-기본-설정-초기자) 에서 설명한 것처럼, 구조체의 '기본 초기자 (default initializer)' 를 호출합니다.

구조체에서 선언한 속성을 초기화하는 과정은 [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 에서 설명합니다.

구조체 인스턴스의 속성은, [Accessing Properties (속성에 접근하기)]({% post_url 2020-04-14-Structures-and-Classes %}#accessing-properties-속성에-접근하기) 에서 설명한 것처럼, '점 (`.`) 구문 표현' 을 사용하여 접근할 수 있습니다.

구조체는 '값 타입' 입니다; 구조체의 인스턴스는 변수나 상수에 할당될 때, 또는 함수 호출 시에 인자로 전달될 때, 복사됩니다. 값 타입에 대한 정보는, [Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#structures-and-enumerations-are-value-types-구조체와-열거체는-값-타입입니다) 를 참고하기 바랍니다.

구조체 타입의 작동 방식은, [Extension Declaration (익스텐션-확장 선언)](#extension-declaration-익스텐션-확장-선언) 에서 논의한 것처럼, '익스텐션 (extension; 확장) 선언' 으로 확장할 수 있습니다.

> GRAMMAR OF A STRUCTURE DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID367)

### Class Declaration (클래스 선언)

_클래스 선언 (class declaration)_ 은 '이름 있는 클래스 타입' 을 프로그램에 도입합니다. '클래스 선언' 은 `class` 키워드를 사용하여 선언하며 형식은 다음과 같습니다:

class `class name-클래스 이름`: `superclass-상위 클래스`, `adopted protocols-채택한 프로토콜` {
  `declarations-선언`
}

클래스 본문은 '0' 개 이상의 _선언 (declaration)_ 들을 가지고 있습니다. 이 _선언 (declarations)_ 들은 저장 및 계산 속성 둘 모두와, 타입 속성, 인스턴스 메소드, 타입 메소드, 초기자, 단 하나의 '정리자 (deinitializer)', 첨자 연산, 타입 별명, 그리고 심지어 다른 구조체, 클래스, 및 열거체 선언을 포함할 수 있습니다. 클래스 선언은 프로토콜 선언을 가질 수 없습니다. 다양한 종류의 선언을 포함하고 있는 클래스에 대한 여러 가지 예제와 논의들은, [Structures and Classes (구조체와 클래스)]({% post_url 2020-04-14-Structures-and-Classes %}) 를 참고하기 바랍니다.

클래스 타입은, _상위 클래스 (superclass)_ 라는, 단 하나의 부모 클래스만 상속할 수 있지만, 프로토콜은 어떤 개수라도 채택할 수 있습니다. _상위 클래스 (superclass)_ 를 _클래스 이름 (class anme)_ 및 콜론 뒤에 먼저 나타내고, 이어서 _채택한 프로토콜 (adopted protocols)_ 을 뒤에 둡니다. '제네릭 (일반화된) 클래스' 는 다른 '제네릭 클래스' 및 '제네릭이 아닌 클래스' 를 상속할 수 있지만, '제네릭이 아닌 클래스' 는 다른 '제네릭이 아닌 클래스' 만 상속할 수 있습니다. 제네릭 상위 클래스의 이름을 콜론 뒤에 작성할 때는, '제네릭 매개 변수 절' 을 포함하여, 해당 제네릭 클래스의 온전한 이름을 반드시 포함해야 합니다.

[Initializer Declaration (초기자 선언)](#initializer-declaration-초기자-선언) 에서 논의한 것처럼, 클래스는 '지명 초기자' 와 '편의 초기자' 를 가질 수 있습니다. 클래스의 '지명 초기자' 는 클래스에서 선언한 모든 속성을 반드시 초기화해야 함과 동시에 이를 반드시 상위 클래스의 지명 초기자를 호출하기 전에 해야 합니다.

클래스는 상위 클래스의 속성, 메소드, 첨자 연산, 및 초기자를 '재정의 (override)' 할 수 있습니다. 재정의한 속성, 메소드, 첨자 연산, 및 지명 초기자[^designated-initializers]는 반드시 `override` 선언 수정자로 표시해야 합니다.

하위 클래스가 상위 클래스의 초기자를 필수로 구현하게 만들려면, 상위 클래스의 초기자를 `required` 선언 수정자로 표시합니다. 해당 초기자에 대한 하위 클래스의 구현 또한 반드시 `required` 선언 수정자로 표시해야 합니다.

_상위 클래스 (superclass)_ 에서 선언한 속성과 메소드를 현재 클래스에서 상속한다고 하더라도, 상위 클래스에서 선언한 '지명 초기자' 는 하위 클래스가 [Automatic Initializer Inheritance (자동적인 초기자 상속)]({% post_url 2016-01-23-Initialization %}#automatic-initializer-inheritance-자동적인-초기자-상속) 에서 설명한 조건을 만족할 때만 상속됩니다. 스위프트의 클래스는 '범용 기본 클래스 (universal base class)'[^universal-base-class] 에서 상속된 것이 아닙니다.

이전에 선언한 클래스의 인스턴스를 생성하는 방법은 두 가지가 있습니다:

* [Initializers (초기자)]({% post_url 2016-01-23-Initialization %}#initializers-초기자) 에서 설명한 것처럼, 클래스에서 선언한 초기자 중 하나를 호출합니다.
* 선언한 초기자가 없지만, 클래스 선언의 모든 속성에 초기 값이 주어진 경우, [Default Initializers (기본 설정 초기자)]({% post_url 2016-01-23-Initialization %}#default-initializers-기본-설정-초기자) 에서 설명한 것처럼, 클래스의 '기본 초기자 (default initializer)' 를 호출합니다.

클래스 인스턴스의 속성에 접근하려면, [Accessing Properties (속성에 접근하기)]({% post_url 2020-04-14-Structures-and-Classes %}#accessing-properties-속성에-접근하기) 에서 설명한 것처럼, '점 (`.`) 구문 표현' 을 사용합니다.

클래스는 '참조 타입' 입니다; 클래스의 인스턴스는, 변수나 상수에 할당될 때, 또는 함수 호출 시에 인자로 전달될 때, 복사되지 않고, 참조를 합니다. 참조 타입에 대한 정보는, [Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#structures-and-enumerations-are-value-types-구조체와-열거체는-값-타입입니다)[^reference-type] 를 참고하기 바랍니다.

클래스 타입의 작동 방식은, [Extension Declaration (익스텐션-확장 선언)](#extension-declaration-익스텐션-확장-선언) 에서 논의한 것처럼, '익스텐션 (extension; 확장) 선언' 으로 확장할 수 있습니다.

> GRAMMAR OF A CLASS DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID368)

### Protocol Declaration (프로토콜 선언)

_프로토콜 선언 (protocol declaration)_ 은 프로그램에 '이름 있는 프로토콜 타입' 을 도입합니다. 프로토콜 선언은 `protocol` 키워드를 사용하여 '전역 범위 (global scope)' 에서 선언하며 다음 양식을 가집니다:

```swift
  protocol protocol name: inherited protocols {
    protocol member declarations
  }
```

프로토콜의 본문은, 이 프로토콜을 채택한 타입이면 어떤 것이든 반드시 충족해야 하는 '준수 필수 조건 (conformance requirements)' 을 설명하는, '0' 개 이상의 _프로토콜 멤버 선언 (protocol member declarations)_ 을 가집니다. 특히, 프로토콜은 '준수 타입 (conforming types)' 이 반드시 구현해야 하는 정해진 속성, 메소드, 초기자, 및 첨자 연산을 선언할 수 있습니다. 프로토콜은 또, _결합된 타입 (associated types)_ 이라는, 특수한 종류의 '타입 별명 (type aliases)' 을 선언하여, 프로토콜의 다양한 선언들 간의 관계를 지정할 수도 있습니다. 프로토콜 선언은 클래스, 구조체, 열거체, 또는 다른 프로토콜 선언을 가질 수 없습니다. _프로토콜 멤버 선언 (protocol member declarations)_ 은 아래에서 자세히 설명합니다.

프로토콜 타입은 다른 프로토콜을 어떤 개수든 상속할 수 있습니다. 프로토콜 타입이 다른 프로토콜을 상속할 때면, 이 다른 프로토콜에 있는 필수 조건들의 집합은 한데 모여서, 현재 프로토콜을 상속하는 타입이 어떤 것이든 이 모든 필수 조건들을 반드시 준수해야 합니다. 프로토콜 상속을 사용하는 방법에 대한 예제는, [Protocol Inheritance (프로토콜 상속)]({% post_url 2016-03-03-Protocols %}#protocol-inheritance-프로토콜-상속) 을 참고하기 바랍니다.

> [Protocol Composition Type (프로토콜 합성 타입)]({% post_url 2020-02-20-Types %}#protocol-composition-type-프로토콜-합성-타입) 과 [Protocol Composition (프로토콜 합성)]({% post_url 2016-03-03-Protocols %}#protocol-composition-프로토콜-합성) 에서 설명한 것처럼, 프로토콜 합성 타입을 사용하여 다중 프로토콜의 준수 필수 조건을 한데 모으는 것도 가능합니다.

이전에 선언되어 있던 타입에 '프로토콜 준수성' 을 추가하려면 해당 타입의 '익스텐션' 선언에서 그 프로토콜을 채택하면 됩니다. 그 '익스텐션' 에서, 채택한 프로토콜의 모든 필수 조건을 반드시 구현해야 합니다. 타입이 이미 모든 필수 조건을 구현하고 있는 경우에는, '익스텐션' 선언의 본문을 비워둘 수도 있습니다.

기본적으로, 프로토콜을 준수하는 타입은 프로토콜에서 선언한 모든 속성, 메소드, 및 첨자 연산을 반드시 구현해야 합니다. 즉, 이런 프로토콜 멤버 선언을 `optional` 선언 수정자로 표시하면 '준수 타입' 에 의한 구현이 '옵셔널 (optional)' 임을 지정할 수 있습니다.[^optional-member] `optional` '수정자 (modifier)' 는 `objc` '특성 (attribute)' 으로 표시한 멤버와, `objc` 특성으로 표시한 프로토콜의 멤버에만 적용할 수 있습니다. 그 결과로, 클래스 타입만 '옵셔널 멤버 필수 조건' 을 가지는 프로토콜을 채택하고 준수할 수 있습니다. `optional` 선언 수정자를 사용하는 방법에 대한 더 자세한 정보와 옵셔널 프로토콜 멤버에 접근하는 방법-예를 들어, 준수 타입이 이를 구현했는지 확실하지 않을 때-에 대한 지침은, [Optional Protocol Requirements (옵셔널 프로토콜 필수 조건)]({% post_url 2016-03-03-Protocols %}#optional-protocol-requirements-옵셔널-프로토콜-필수-조건) 을 참고하기 바랍니다.

'열거체의 case 값' 은 타입 멤버에 대한 프로토콜 필수 조건을 만족할 수 있습니다. 특히, '결합된 값' 이 없는 '열거체 case 값' 은 `Self` 타입의 '읽기-전용 (get-only)' 타입 변수에 대한 프로토콜 필수 조건을 만족하며, '결합된 값' 이 있는 '열거체 case 값' 은 매개 변수와 인자 이름표가 'case 값' 의 '결합된 값' 에 일치하는 `Self` 를 반환하는 함수에 대한 프로토콜 필수 조건을 만족합니다. 예를 들면 다음과 같습니다:

```swift
protocol SomeProtocol {
  static var someValue: Self { get }
  static func someFunction(x: Int) -> Self
}
enum MyEnum: SomeProtocol {
  case someValue
  case someFunction(x: Int)
}
```

프로토콜의 '채택 (adoption)' 을 클래스 타입으로만 제약하려면, 콜론 뒤의 _상속받은 프로토콜 (inherited protocols)_ 목록에 `AnyObject` 프로토콜을 포함하면 됩니다. 예를 들어, 다음 프로토콜은 클래스 타입만 채택할 수 있습니다:

```swift
protocol SomeProtocol: AnyObject {
  /* 여기에 프로토콜 멤버를 둡니다 */
}
```

`AnyObject` 필수 조건으로 표시한 프로토콜을 상속한 어떤 프로토콜이든 마찬가지로 클래스 타입만 채택할 수 있습니다.

> 프로토콜을 `objc` 특성으로 표시할 경우, `AnyObject` 필수 조건이 해당 프로토콜에 암시적으로 적용됩니다; 이 프로토콜은 `AnyObject` 필수 조건을 명시적으로 표시할 필요가 없습니다.

프로토콜은 '이름 있는 타입 (named types)' 이며, 그래서 [Protocols as Types (타입으로써의 프로토콜)]({% post_url 2016-03-03-Protocols %}#protocols-as-types-타입으로써의-프로토콜) 에서 설명한 것처럼, 코드에서 다른 이름 있는 타입과 똑같은 위치에서 나타낼 수 있습니다. 하지만, 프로토콜의 인스턴스를 '생성 (construct)' 할 수는 없는데, 프로토콜은 그것이 지정한 필수 조건에 대한 구현부를 실제로 제공하는 것이 아니기 때문입니다.

프로토콜을 사용하면, [Delegation (위임)]({% post_url 2016-03-03-Protocols %}#delegation-위임) 에서 설명한 것처럼, 클래스 또는 구조체의 '대리자 (delegate)' 가 구현해야 하는 메소드를 선언할 수 있습니다.

> GRAMMAR OF A PROTOCOL DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

#### Protocol Property Declaration (프로토콜 속성 선언)

프로토콜을 준수하는 타입이 어떤 속성을 반드시 구현하도록 선언하려면 프로토콜 선언의 본문에서 _프로토콜 속성 선언 (protocol property declaration)_ 을 포함하면 됩니다. '프로토콜 속성 선언' 은 특수한 형식의 변수 선언입니다:

var `property name-속성 이름`: `type-타입` { get set }

다른 프로토콜 멤버 선언에서와 같이, 이 속성 선언들은 프로토콜을 준수하는 타입에 대한 '획득자 (getter)' 와 '설정자 (setter)' '필수 조건 (requirements)' 만을 선언합니다. 그 결과, 이를 선언한 프로토콜에서 획득자와 설정자를 직접 구현하지는 않습니다.

획득자 및 설정자 필수 조건은 '준수 타입' 에서 다양한 방식으로 만족시킬 수 있습니다. 속성 선언이 `get` 과 `set` 키워드 둘 다를 포함하고 있는 경우, '준수 타입' 은 이를 읽기와 쓰기가 모두 가능한 (즉, 획득자와 설정자 둘 모두를 구현한) 저장 변수 속성 또는 계산 속성으로 구현할 수 있습니다. 하지만, 해당 속성 선언을 상수 속성 또는 읽기-전용 계산 속성으로 구현할 수는 없습니다. 속성 선언이 `get` 키워드만을 포함하고 있는 경우, 이를 모든 종류의 속성으로 구현할 수 있습니다. 프로토콜의 속성 필수 조건을 구현하는 준수 타입에 대한 예제는, [Property Requirements (속성 필수 조건)]({% post_url 2016-03-03-Protocols %}#property-requirements-속성-필수-조건) 를 참고하기 바랍니다.

프로토콜 선언에서 '타입 속성 필수 조건' 을 선언하려면, 이 속성 선언을 `static` 키워드로 표시합니다. 이 프로토콜을 준수하는 것이 구조체와 열거체라면 속성을 `static` 키워드로 선언하고, 이 프로토콜을 준수하는 것이 클래스라면 속성을 `static` 이나 `class` 키워드 중 하나로 선언합니다. '익스텐션 (extension; 확장)' 으로 구조체, 열거체, 또는 클래스에 '프로토콜 준수성 (protocol conformance)' 을 추가하는 경우 확장하는데 사용하는 타입과 같은 키워드를 사용합니다. '타입 속성 필수 조건' 에 대한 '기본 구현' 을 제공하는 '익스텐션' 은 `static` 키워드를 사용합니다.

[Variable Declaration (변수 선언)](#variable-declaration-변수-선언) 부분도 참고하기 바랍니다.

> GRAMMAR OF A PROTOCOL PROPERTY DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

#### Protocol Method Declaration (프로토콜 메소드 선언)

프로토콜을 준수하는 타입이 어떤 메소드를 반드시 구현하도록 선언하려면 프로토콜 선언의 본문에서 '프로토콜 메소드 선언' 을 포함하면 됩니다. 프로토콜 메소드 선언은 함수 선언과 형식이 똑같지만, 두 가지 예외가 있습니다: 일단 함수 본문을 포함하지 않으며, 함수 선언에서 어떤 '기본 설정 매개 변수 값' 도 제공할 수 없습니다.  프로토콜의 '메소드 필수 조건 (method requirements)' 을 구현하는 준수 타입에 대한 예제는, [Method Requirements (메소드 필수 조건)]({% post_url 2016-03-03-Protocols %}#method-requirements-메소드-필수-조건) 을 참고하기 바랍니다.

프로토콜 선언에서 '클래스 메소드 (class method)' 나 '정적 메소드 (static method)' 필수 조건을 선언하려면, 해당 메소드 선언을 `static` 선언 수정자로 표시합니다. 이 프로토콜을 준수하는 것이 구조체와 열거체라면 메소드를 선언하면서 `static` 키워드를 사용하고, 이 프로토콜을 준수하는 것이 클래스라면 메소드를 선언하면서 `static` 이나 `class` 키워드 중 하나를 사용합니다. '익스텐션 (extension; 확장)' 으로 구조체, 열거체, 또는 클래스에 '프로토콜 준수성 (protocol conformance)' 을 추가하는 경우 확장하는데 사용하는 타입과 같은 키워드를 사용합니다. '타입 메소드 필수 조건' 에 대한 '기본 구현' 을 제공하는 '익스텐션' 은 `static` 키워드를 사용합니다.

[Function Declaration (함수 선언)](#function-declaration-함수-선언) 부분도 참고하기 바랍니다.

> GRAMMAR OF A PROTOCOL METHOD DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

#### Protocol Initializer Declaration (프로토콜 초기자 선언)

프로토콜을 준수하는 타입이 어떤 초기자를 반드시 구현하도록 선언하려면 프로토콜 선언의 본문에서 '프로토콜 초기자 선언' 을 포함하면 됩니다. '프로토콜 초기자 선언' 은, 초기자의 본문을 포함하지 않는다는 것만 제외하면, 초기자 선언과 형식이 같습니다.

준수 타입이 '실패하지 않는 프로토콜 초기자 필수 조건' 을 만족하게 하려면 '실패하지 않는 초기자 (nonfailable initializer)' 또는 `init!` 라는 '실패 가능한 초기자 (failable initializer)' 를 구현하면 됩니다. 준수 타입이 '실패 가능한 프로토콜 초기자 필수 조건' 을 만족하게 하려면 어떤 종류의 초기자라도 구현하면 됩니다.

클래스에서 프로토콜의 '초기자 필수 조건' 을 만족하기 위해 초기자를 구현할 때는, 해당 클래스를 이미 `final` 선언 수정자로 표시하지 않은 이상 그 초기자를 반드시 `required` 선언 수정자로 표시해야 합니다.

[Initializer Declaration (초기자 선언)](#initializer-declaration-초기자-선언) 부분도 참고하기 바랍니다.

> GRAMMAR OF A PROTOCOL INITIALIZER DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

#### Protocol Subscript Declaration (프로토콜 첨자 연산 선언)

프로토콜을 준수하는 타입이 어떤 '첨자 연산 (subcript)' 을 반드시 구현하도록 선언하려면 프로토콜 선언의 본문에서 '프로토콜 첨자 연산 선언' 을 포함하면 됩니다. 프로토콜 첨자 연산 선언은 은 특수한 형식의 변수 선언입니다:

subscript (`parameters-매개 변수`) -> `return type-반환 타입` { get set }

'첨자 연산 선언' 은 프로토콜을 준수하는 타입에 대한 '획득자 및 설정자의 최소 구현 필수 조건' 만 선언합니다. 만약 '첨자 연산 선언' 이 `get` 과 `set` 키워드를 둘 다 포함할 경우, 준수 타입은 '획득자 (getter) 및 설정자 (setter) 절' 둘 다를 반드시 구현해야 합니다. 첨자 연산 선언이 `get` 키워드 만을 포함할 경우, 준수 타입은 _최소한 (at least)_ '획득자 (getter) 절' 은 반드시 구현해야 하며 '설정자 (setter) 절' 은 선택해서 구현할 수 있습니다.

프로토콜 선언에서 '정적 첨자 연산 (static subscript)' 필수 조건을 선언하려면, 해당 첨자 연산 선언을 `static` 선언 수정자로 표시합니다. 이 프로토콜을 준수하는 것이 구조체와 열거체라면 첨자 연산을 선언하면서 `static` 키워드를 사용하고, 프로토콜을 준수하는 것이 클래스라면 첨자 연산을 선언하면서 `static` 이나 `class` 키워드 중 하나를 사용합니다. '익스텐션 (extension; 확장)' 으로 구조체, 열거체, 또는 클래스에 '프로토콜 준수성 (protocol conformance)' 을 추가하는 경우 확장하는데 사용하는 타입과 같은 키워드를 사용합니다. '타입 첨자 연산 필수 조건' 에 대한 '기본 구현' 을 제공하는 '익스텐션' 은 `static` 키워드를 사용합니다.

[Subscipt Declaration (첨자 연산 선언)](#subscipt-declaration-첨자-연산-선언) 부분도 참고하기 바랍니다.

> GRAMMAR OF A PROTOCOL INITIALIZER DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

#### Protocol Associated Type Declaration (프로토콜의 결합된 타입 선언)

프로토콜은 `associatedtype` 키워드를 사용하여 '결합된 타입 (associated types)' 을 선언합니다. '결합된 타입' 은 프로토콜의 선언에서 사용되는 타입을 위한 '별명 (alias)' 을 제공합니다. '결합된 타입' 은 '일반화된 (generic) 매개 변수 절' 의 '타입 매개 변수' 와 비슷하지만, 이를 선언하는 프로토콜의 `Self` 와 '결합되어 (associated)' 있습니다. 해당 상황에서, `Self` 는 프로토콜을 '최종적으로 (eventual) 준수하고 있는 타입' 을 참조합니다. 더 많은 정보와 예제는, [Associated Types (결합된 타입)]({% post_url 2020-02-29-Generics %}#associated-types-결합된-타입) 을 참고하기 바랍니다.

또 다른 프로토콜에서 상속받은 '결합된 타입' 에, '결합된 타입' 의 '재선언 (redeclaring)' 없이, '구속 조건' 을 추가하려면 프로토콜 선언에서 '일반화된 (generic) `where` 절' 을 사용하면 됩니다. 예를 들어, 아래에 있는 `SubProtocol` 선언들은 서로 '동치 (equivalent)' 입니다:

```swift
protocol SomeProtocol {
  associatedtype SomeType
}

protocol SubProtocolA: SomeProtocol {
  // 다음 구문 표현은 경고 (warning) 를 일으킵니다.
  associatedtype SomeType: Equatable
}

// 다음 구문 표현이 더 좋습니다.
protocol SubProtocolB: SomeProtocol where SomeType: Equatable { }
```

[Type Alias Declaration (타입 별명 선언)](#type-alias-declaration-타입-별명-선언) 부분도 참고하기 바랍니다.

> GRAMMAR OF A PROTOCOL ASSOCIATED TYPE DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

### Initializer Declaration (초기자 선언)

_초기자 선언 (initializer declaration)_ 은 클래스, 구조체, 또는 열거체에 대한 초기자를 프로그램에 도입합니다. '초기자 선언' 은 `init` 키워드를 사용하여 선언하며 두 가지의 기본 형식이 있습니다.

구조체, 열거체, 그리고 클래스 타입은 어떤 개수의 초기자라도 가질 수 있지만, 클래스 초기자의 경우 '규칙' 및 '결합 작동 방식' 이 다릅니다. 구조체 및 열거체와는 다르게, 클래스는 두 가지 종류의 초기자를 가집니다: '지명 초기자 (designated initializers)' 와 '편의 초기자 (convenience itnitialziers)' 가 그것으로, 이는 [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 에서 설명했습니다.

다음 형식은 구조체 및, 열거체에 대한 초기자와, 클래스에 대한 '지명 초기자' 를 선언합니다:

init (`parameters-매개 변수`) {<br />
  `statements-구문`<br />
}

클래스의 '지명 초기자' 는 직접 클래스의 모든 속성을 초기화합니다. 이는 같은 클래스에 있는 다른 어떤 초기자도 호출할 수 없으며, 클래스가 상위 클래스를 가질 경우, 상위 클래스의 '지명 초기자' 중 하나를 반드시 호출해야 합니다. 클래스가 상위 클래스에서 어떤 속성을 상속받은 경우, 이 속성들 어떤 것이든 현재 클래스에서 설정하거나 수정하기 전에 반드시 상위 클래스의 지명 초기자 중 하나를 호출해야 합니다.

지명 초기자는 클래스 선언인 상황에서만 선언할 수 있으므로 '확장 (extension) 선언' 을 사용하여 클래스에 추가될 수 없습니다.

구조체와 열거체에 있는 초기자는 선언된 다른 초기자를 호출하여 초기화 과정의 일부 또는 전체를 위임할 수 있습니다.

클래스를 위한 '편의 초기자' 를 선언하려면, 초기자 선언을 `convenience` 선언 수정자로 표시합니다.

convenience init (`parameters-매개 변수`) {<br />
  `statements-구문`<br />
}

편의 초기자는 초기화 과정을 또 다른 편의 초기자 또는 클래스의 지명 초기자 중 하나로 위임할 수 있습니다. 그건 그렇고, 초기화 과정은 궁극적으로 클래스의 속성을 초기화하는 지명 초기자를 호출하는 것으로 반드시 끝나야 합니다. 편의 초기자는 상위 클래스의 초기자를 호출할 수 없습니다.

지명 초기자와 편의 초기자를 `required` 선언 수정자로 표시하면 모든 하위 클래스가 이 초기자를 필수로 구현하도록 만들 수 있습니다. 해당 초기자의 하위 클래스 구현 역시 반드시 `required` 선언 수정자로 표시돼야 합니다.

기본적으로, 상위 클래스에서 선언된 초기자는 하위 클래스로 상속되지 않습니다. 그건 그렇고, 만약 하위 클래스가 모든 저장 속성을 기본 설정 값으로 초기화하면서 자체로는 어떤 초기자도 정의하지 않는 경우, 상위 클래스의 모든 초기자를 상속합니다. 만약 하위 클래스가 상위 클래스의 모든 지명 초기자를 재정의하는 경우, 상위 클래스의 편의 초기자를 상속합니다.

메소드, 속성, 및 첨자 연산에서 처럼, 재정의한 지명 초기자는 `override` 선언 수정자로 표시해야 합니다.

> 초기자를 `required` 선언 수정자로 표시한 경우, 이 필수 초기자를 하위 클래스에서 재정의할 때 초기자에 `override` 수정자까지 표시하지는 않습니다.

함수 및 메소드와 같이, 초기자도 에러를 던지거나 다시 던질 수 있습니다. 그리고 함수 및 메서드와 같이, 초기자의 매개 변수 뒤에 `throws` 또는 `rethrows` 키워드를 사용하여 적절한 작동 방식을 지시합니다.

다양한 타입 선언에 있는 초기자의 예제를 보려면, [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 를 참고하기 바랍니다.

#### Failable Initializers (실패 가능한 초기자)

_실패 가능한 초기자 (failable initializer)_ 는 초기자를 선언한 타입에 대한 '옵셔널 인스턴스 (optional instance)' 또는 '암시적으로 포장이 풀리는 (implicitly unwrapped) 옵셔널 인스턴스' 를 생산하는 타입의 초기자입니다. 그 결과로, '실패 가능한 초기자' 는 초기화가 실패한 것을 나타내기 위해 `nil` 을 반환할 수 있습니다.

'옵셔널 인스턴스' 를 생산하는 '실패 가능한 초기자' 를 선언하려면, 초기자 선언에 있는 `init` 키워드에 물음표를 추가합니다 (`init?`). '암시적으로 포장이 풀리는 옵셔널 인스턴스' 를 생산하는 '실패 가능한 초기자' 를 선언하려면, 느낌표를 대신 추가합니다 (`init!`). 아래 예제는 구조체에 대한 옵셔널 인스턴스를 생산하는 '`init?` 실패 가능한 초기자' 를 보여줍니다.

```swift
struct SomeStruct {
  let property: String
  // 'SomeStruct' 의 옵셔널 인스턴스를 생산합니다.
  init?(input: String) {
    if input.isEmpty {
      // 'self' 를 버리고 'nil' 을 반환합니다.
      return nil
    }
    property = input
  }
}
```

`init?` 실패 가능한 초기자는, 반드시 결과의 '옵셔널 성질 (optionality)' 을 다뤄야 한다는 것만 빼면, '실패하지 않는 초기자' 의 호출과 똑같은 방식으로 호출할 수 있숩나다.

```swift
if let actualInstance = SomeStruct(input: "Hello") {
  // 'SomeStruct' 의 인스턴스로 뭔가를 합니다.
} else {
  // 'SomeStruct' 의 초기화를 실패했으며 초기자가 'nil' 을 반환했습니다.
}
```

실패 가능한 초기자는 초기자를 구현하는 본문의 어느 시점에서도 `nil` 을 반환할 수 있습니다.

실패 가능한 초기자는 어떤 종류의 초기자로도 위임할 수 있습니다. '실패하지 않는 초기자' 는 또 다른 실패하지 않는 초기자 또는 `init!` 실패 가능한 초기자로 위임할 수 있습니다. 실패하지 않는 초기자는 상위 클래스 초기자의 결과를 '강제-포장풀기 (force-unwrapping)' 하는 것으로써 `init?` 실패 가능한 초기자로 위임할 수 있습니다-예를 들어, `super.init()!` 처럼 작성합니다.

'초기화 실패 (initialization failure)' 는 초기자 위임을 통하여 전파됩니다. 특히, '실패 가능한 초기자' 가 위임한 초기자가 실패하고 `nil` 을 반환한 경우, 이 때는 위임을 맡긴 초기자 역시 실패하고 암시적으로 `nil` 을 반환합니다. 실패하지 않는 초기자가 위임한 '`init!` 실패 가능한 초기자' 가 실패하고 `nil` 을 반환한 경우, 이 때는 실행 시간 에러가 발생합니다 (이는 `nil` 값을 가진 옵셔널의 포장을 풀려고 `!` 연산자를 사용한 것과 같습니다).

'실패 가능한 지명 초기자' 는 하위 클래스에 있는 모든 종류의 지명 초기자로 '재정의 (overridden)' 될 수 있습니다. '실패하지 않는 지명 초기자' 는 하위 클래스에 있는 '실패하지 않는 지명 초기자' 로만 재정의될 수 있습니다.

더 자세한 정보 및 실패 가능한 초기자에 대한 예제는, [Failable Initializers (실패 가능한 초기자)]({% post_url 2016-01-23-Initialization %}#failable-initializers-실패-가능한-초기자) 를 참고하기 바랍니다.

> GRAMMAR OF AN INITIALIZER DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID375)

### Deinitializer Declaration (정리자 선언)

_정리자 선언 (deinitializer declaration)_ 은 클래스 타입에 대한 '정리자' 를 선언합니다. '정리자' 는 매개 변수를 취하지 않으며 형식은 다음과 같습니다:

deinit {<br />
  `statements-구문`<br />
}

정리자는 더 이상 클래스 객체에 대한 어떤 참조도 존재하지 않을 때, 클래스 객체가 할당 해제되기 바로 직전에, 자동으로 호출됩니다. 정리자는 클래스 선언의 본문-그러나 클래스의 '익스텐션 (extension; 확장)' 은 아닌 곳-에서만 선언할 수 있으며 각 클래스마다 최대 하나만 가질 수 있습니다.

하위 클래스는 상위 클래스의 정리자를 상속받는데, 이는 하위 클래스 객체가 할당 해제되기 바로 직전에 암시적으로 호출됩니다. 하위 클래스 객체는 '상속 연쇄망 (inheritance chain)' 에 있는 모든 정리자가 실행을 마치기 전까지 할당이 해제되지 않습니다.

정리자는 직접 호출하는 것이 아닙니다.

클래스 선언에서 정리자를 사용하는 방법에 대한 예제는, [Deinitialization (객체 정리)]({% post_url 2017-03-03-Deinitialization %}) 를 참고하기 바랍니다.

> GRAMMAR OF A DEINITIALIZER DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID377)

### Extension Declaration (익스텐션-확장 선언)

_익스텐션 (확장) 선언 (extension declaration)_ 은 기존 타입의 작동 방식을 확장하도록 합니다. '익스텐션 선언' 은 `extension` 키워드를 사용하여 선언하며 형식은 다음과 같습니다:

extension `type name-타입 이름` where `requirements-필수 조건` {<br />
  `declarations-선언`<br />
}

익스텐션 선언의 본문은 '0' 개 이상의 _선언 (declarations)_ 을 가집니다. 이 _선언 (declarations)_ 들은 계산 속성, 계산 타입 속성, 인스턴스 메소드, 타입 메소드, 초기자, 첨자 연산 선언, 그리고 심지어 클래스, 구조체, 및 열거체 선언을 포함할 수 있습니다. '익스텐션 (확장) 선언' 은 정리자 또는 프로토콜 선언, 저장 속성, 속성 관찰자, 및 다른 '익스텐션 (확장) 선언' 을 가질 수 없습니다. '프로토콜 익스텐션' 에 있는 선언들은 `final` 이라고 표시할 수 없습니다. 다양한 종류의 선언을 포함하고 있는 '익스텐션 (확장)' 에 대한 논의 및 예제에 대해서는, [Extensions (익스텐션; 확장)]({% post_url 2016-01-19-Extensions %}) 을 참고하기 바랍니다.

_타입 이름 (type name)_ 이 클래스, 구조체, 또는 열거체 타입인 경우, '익스텐션' 은 해당 타입을 확장합니다. _타입 이름 (type name)_ 이 프로토콜 타입인 경우, '익스텐션' 은 해당 프로토콜을 준수하는 모든 타입을 확장합니다.

결합된 타입을 가지는 '제네릭 타입 (generic type; 일반화된 타입)' 또는 프로토콜을 확장하는 '익스텐션 선언' 은 _필수 조건 (requirements)_ 을 포함할 수 있습니다. 확장된 타입의 인스턴스 또는 확장된 프로토콜을 준수하는 타입의 인스턴스가 _필수 조건 (requirements)_ 을 만족하는 경우, 이 인스턴스는 선언에서 지정한 '작동 방식 (behavior)' 을 가지게 됩니다.

'익스텐션 선언' 은 초기자 선언을 가질 수 있습니다. 그건 그렇고, 확장하려는 타입이 다른 모듈에서 정의된 경우, 초기자 선언은 해당 타입의 멤버가 알맞게 초기화되는 것을 보장하도록 해당 모듈에서 이미 정의한 초기자로 위임을 반드시 해야 합니다.

기존 타입의 속성, 메소드, 그리고 초기자는 해당 타입의 '익스텐션' 에서 재정의할 수 없습니다.

'익스텐션 선언' 은 _채택한 프로토콜 (adopted protocols)_ 들을 지정하여 기존 클래스, 구조체, 또는 열거체에 '프로토콜 준수성 (protocol conformance)' 을 추가할 수 있습니다:

extension `type name-타입 이름`: `adopted protocols-채택한 프로토콜` where `requirements-필수 조건` {<br />
  `declarations-선언`<br />
}

'익스텐션 선언' 은 기존 클래스에 '클래스 상속' 을 추가할 수는 없으며, 따라서 _타입 이름 (type name)_ 과 콜론 뒤에 프로토콜 목록만을 지정할 수 있습니다.

#### Conditional Conformance (조건부 준수성)

일반화된 타입을 확장하면서 조건부로 프로토콜을 준수하도록 할 수 있는데, 이는 타입의 인스턴스가 정해진 필수 조건을 만날 때만 프로토콜을 준수하게 됩니다. '조건부 준수성 (conditional conformance)' 을 프로토콜에 추가하려면 '익스텐션 선언' 에 _필수 조건 (requirements)_ 을 추가하면 됩니다.

**Overridden Requirements Aren't Used in Some Generic Contexts (재정의한 필수 조건은 어떤 제네릭-일반화 상황에서는 사용되지 않습니다)**

#### Protocol Conformance Must Not Be Redundant

**Resolving Explicit Redundancy**

**Resolving Implicit Redundancy**

### Subscipt Declaration (첨자 연산 선언)

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

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^expression]: 여기서의 '표현식 (expression)' 은 위 예제 양식에 있는 'expression' 을 말합니다. 클래스 선언이나 구조체 선언에서는 이 'expression' 부분이 없어도 된다는 말입니다.

[^type]: 여기서의 '타입 (type)' 보조 설명이란 위 에제 양식에 있는 'type' 을 말합니다. 뒤에 붙은 'expression' 을 통해 타입을 추론할 수 있는 경우 생략할 수 있는데, 스위프트에서는 거의 생략된 채로 사용합니다.

[^call-by-value-result]: 기본적으로, '값-결과에 의한 호출 (call by value result)' 은 '값에 의한 호출 (call by value)' 과 '참조에 의한 호출 (call by reference)' 이 합쳐진 것으로 볼 수 있습니다. [프로그래밍 학습법탐구자](http://blog.daum.net/here8now/) 님의 [call by value, call by reference, call by value result, call by name](http://blog.daum.net/here8now/37) 항목에 따르면, 함수 안에서는 '값에 의한 호출 (call by value)' 처럼 동작하고, 함수 반환 시에는 '참조에 의한 호출 (call by reference)' 처럼 동작합니다. 다만, 본문에서 이어서 설명하는 것처럼, '값-결과에 의한 호출' 은 최적화에 따라 '참조에 의한 호출' 처럼 동작하기도 합니다. 즉, 스위프트의 '입-출력 매개 변수' 는 '참조에 의한 호출' 또는 '값-결과에 의한 호출' 을 상황에 따라 적절하게 선택해서 인자를 전달하는 것이라 볼 수 있습니다.

[^optional-member]: 여기서의 '옵셔널 (optional)' 은 '선택적' 이라는 말과 '타입이 옵셔널' 이라는 두 가지 의미를 모두 가지고 있습니다. 이는 프로토콜에서 선언한 '필수 조건' 이 구현되어 있는 지가 '옵셔널' 인 것으로 이해할 수 있습니다. 즉, 프로토콜의 준수 타입에서 구현을 했으면 그 구현체를 가지는 것이고, 구현이 되어 있지 않으면 `nil` 인 것입니다.

[^throwing-parameter]: 여기서 '던지는 매개 변수 (throwing paramter)' 는 앞서 얘기한 '던지는 함수 매개 변수 (throwing function parameter)' 를 말하는 것으로, 매개 변수가 '던지는 함수 (throwing function)' 인 것입니다.

[^immutable]: 스위프트의 '상수' 는 참조하고 있는 대상을 다른 대상을 참조하도록 바꾸는 것이 안된다는 의미라는 것을 알 수 있습니다. 이 경우 참조하고 있는 대상 자체가 바뀌는 것은 상관없습니다. 물론 이것은 'class' 같은 '참조 타입 (reference type)' 에만 해당하는 것으로 'struct' 같은 '값 타입 (value type)' 에는 해당하지 않는 이야기 입니다.

[^final]: 이미 'final' 이고 항상 'final' 이므로, 다시 'final' 로 만들거나 'final' 을 없앨 수는 없다는 의미입니다.

[^stored-variable-property]: 이 책에는 '저장 변수 속성 (stored variable property)' 이라는 말과 '변수 저장 속성 (variable stored property)' 이라는 말을 같이 사용하고 있는데, 사실 이 둘은 같은 말입니다. '저장 변수 속성' 은 '저장 변수' 중에서 '속성' 에 해당하는 것이고, '변수 저장 속성' 은 '저장 속성' 중에서 '변수' 에 해당하는 것으로, 결국 같은 것입니다.

[^stored-named-values]: 원문에서 '이름 있는 저장 값 (stored named values)' 이라는 하는 것은 '저장 변수 (stored variable)' 를 의미하고 있습니다.

[^function-definition]: 스위프트는 보통 선언-정의-초기화를 한 번에 하는 경우가 많아서 함수 선언과 함수 정의가 크게 구분되지는 않습니다. 다만 여기서 '함수 정의 (function definition)' 란 말을 사용한 것은 함수 본문 전체를 의미하기 위해서 일 것으로 추측됩니다.

[^indefinitely]: 스위프트의 `Never` 타입은 'MVVM' 의 'Publisher' 에서 사용되는 데, 이는 프로그램이 실행되는 동안 계속해서 'Subscriber' 쪽으로 정보를 보냅니다. 프로그램의 종료 시점을 컴파일 시간에 알 수 없기 때문에 `Never` 타입을 사용한다고 이해할 수 있습니다.

[^syntatic-sugar]: 여기서 설명하는 내용은 C++ 언어의 '함수 객체' 와 비슷한 개념입니다.

[^designated-initializers]: 여기서 '초기자' 가 아니라 '지명 초기자' 라고 한 것은, 재정의한 초기자가 상위 클래스에서 '지명 초기자' 이든 '편의 초기자' 이든, 재정의하고 나면 무조건 '지명 초기자' 가 되기 때문입니다.

[^universal-base-class]: '범용 기본 클래스 (universal base class)' 는 오브젝티브-C 언어의 `NSObject` 같은 클래스를 말하는 것으로 추측됩니다.

[^reference-type]: 원문 자체가 [Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#structures-and-enumerations-are-value-types-구조체와-열거체는-값-타입입니다) 를 참고하라고 되어 있는데, 내용을 보면 실제로는 [Classes Are Reference Types (클래스는 참조 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#classes-are-reference-types-클래스는-참조-타입입니다) 를 참고하는 것이 맞습니다. 원문 자체의 오류일 것으로 추측됩니다.
