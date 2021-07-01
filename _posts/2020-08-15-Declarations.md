---
layout: post
comments: true
title:  "Swift 5.5: Declarations (선언)"
date:   2020-08-15 11:30:00 +0900
categories: Swift Language Grammar Declaration
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Declarations](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html) 부분[^Declarations]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Declarations (선언)

_선언 (declaration)_ 은 프로그램에 새로운 '이름 (name)' 이나 '구조물 (construct)' 을 도입합니다. 예를 들어, 함수와 메소드를 도입하고, 변수와 상수를 도입하며, 열거체, 구조체, 클래스, 및 프로토콜 타입을 정의하기 위해 선언을 사용합니다. 기존에 '이름 붙인 타입' 의 동작을 확장하고 다른 곳에서 선언한 '기호 (symbols)' 를 프로그램으로 불러 오기 위해 선언을 사용할 수도 있습니다.

스위프트에서, 대부분의 '선언' 은 선언되면서 동시에 구현되거나 초기화된다는 점에서 '정의 (definitions)' 이기도 합니다. 그렇다 하더라도, 프로토콜은 자신의 멤버를 구현하지 않기 때문에, 대부분의 프로토콜 멤버는 '선언' 이기만 합니다. 편의상 그리고 스위프트에서의 구별은 그다지 중요하지 않기 때문에, _선언 (declarations)_ 이라는 용어가 '선언' 과 '정의' 둘 다 다룹니다.

> GRAMMAR OF A DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html)

### Top-Level Code (최상단 코드)

스위프트 소스 파일에서 '최상단 코드 (top-level code)' 는 '0' 개 이상의 구문과, 선언, 그리고 표현식들로 구성됩니다. 기본적으로, 소스 파일의 '최상단' 에서 선언한 변수, 상수, 그리고 그 외 '이름 붙인 선언' 은 동일한 모듈의 모든 소스 파일 코드에서 접근 가능합니다. 이 기본 동작은, [Access Control Levels (접근 제어 수준)](#access-control-levels-접근-제어-수준) 에서 설명한 것처럼, '접근-수준 수정자' 로 선언을 표시함으로써 '재정의' 할 수 있습니다.

'최상단 코드' 에는: '최상단 선언 (top-level declarations)' 과 '실행 가능한 최상단 코드 (excutable top-level code)' 라는 두 종류가 있습니다. '최상단 선언' 은 선언만으로 구성하며, 모든 스위프트 소스 파일에서 허용합니다. '실행 가능한 최상단 코드' 는, '선언' 뿐만 아니라, '구문' 과 '표현식' 도 담고 있으며, 프로그램의 '최상단 진입점 (top-level entry point)' 으로만 허용됩니다.

'실행 파일 (executable)' 을 만들고자 컴파일하는 스위프트 코드는, 코드를 파일과 모듈로 정돈하는 방법과는 상관없이, '최상단 진입점' 을 표시하는: `main` 특성, `NSApplicationMain` 특성, `UIApplicationMain` 특성, `main.swift` 파일, 아니면 '실행 가능한 최상단 코드' 를 담은 파일과 같은 접근 방식 중에서 최대 하나만을 담고 있을 수 있습니다.

> GRAMMAR OF A TOP-LEVEL DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID352)

### Code Blocks (코드 블럭)

_코드 블럭 (code block)_ 은 '구문 (statements)' 을 서로 그룹짓기 위해 다양한 '선언' 과 '제어 구조' 에서 사용합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;{<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

'코드 블럭' 안의 _구문 (statements)_ 은 '선언', '표현식', 그리고 다른 종류의 '구문' 을 포함하며 소스 코드에 나타난 순서대로 실행합니다.

> GRAMMAR OF A CODE BLOCK 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID353)

### Import Declaration (선언 불러오기)

_선언 불러오기 (import declaration)_ 는 현재 파일 밖에서 선언한 '기호 (symbols)' 에 접근하게 해줍니다. '기초 형식' 은 전체 모듈을 불러오며; '`import` 키워드' 와 그 뒤의 '모듈 이름' 으로 구성합니다:

&nbsp;&nbsp;&nbsp;&nbsp;import `module-모듈`

불러올 '기호' 에 대한 더 '세부적인 제한 (detail limits)' 을 제공하면-모듈이나 하위 모듈 안의 '특정 하위 모듈' 이나 '특정 선언' 을 지정할 수 있습니다. 이 '세부 형식' 을 사용할 때는, 현재 영역에서 (선언한 모듈이 아닌) '불러온 기호' 만 사용 가능해집니다.

&nbsp;&nbsp;&nbsp;&nbsp;import `import kind-불러올 종류` `module-모듈`.`symbole name-기호 이름`<br />
&nbsp;&nbsp;&nbsp;&nbsp;import `module-모듈`.`submodule-하위 모듈`

> GRAMMAR OF AN IMPORT DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID354)

### Constant Declaration (상수 선언)

_상수 선언 (constant declaration)_ 은 '이름 붙인 상수 값' 을 프로그램에 도입합니다. 상수 선언은 `let` 키워드로 선언하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;let `constant name-상수 이름`: `type-타입` = `expression-표현식`

상수 선언은 _상수 이름 (constant name)_ 과 초기자 _표현식 (expression)_ 값 사이에 '변경 불가한 연결 (immutable binding)' 을 정의하며; 상수 값을 설정한 후에는, 바꿀 수 없습니다. 그렇다 하더라도, 상수를 클래스 객체로 초기화하면, 상수 이름과 이것이 참조하는 객체 사이의 연결을 바꿀 순 없지만, 객체 자체는 바꿀 수 있습니다.[^immutable]

상수를 '전역 (global scope)' 에서 선언할 때는, 반드시 '값' 으로 초기화해야 합니다. 상수 선언이 함수나 메소드 안에 있을 때는, 맨 처음 값을 읽기 전에 값을  설정한다는 보증을 하는 한, 나중에 초기화할 수 있습니다. 절대로 상수 값을 읽지 않음을 컴파일러가 증명할 수 있으면, 아예 상수에 값을 설정할 필요도 없습니다. 상수 선언이 클래스나 구조체 선언에 있을 때는, _상수 속성 (constant property)_ 이라고 고려합니다. 상수 선언은 '계산 속성 (computed properties)' 이 아니며 따라서 '획득자 (getter)' 나 '설정자 (setter)' 를 가지지 않습니다.

상수 선언에서 _상수 이름 (constant name)_ 이 '튜플 패턴' 이면, 튜플의 각 항목 이름이 '초기자 _표현식 (expression)_' 에 있는 '관련 값' 과 연결됩니다.

```swift
let (firstNumber, secondNumber) = (10, 42)
```

이 예제에서, `firstNumber` 는 `10` 이라는 값에 '이름 붙인 상수' 이며, `secondNumber` 는 `42` 라는 값에 '이름 붙인 상수' 입니다. 두 상수 모두 이제 독립적으로 사용할 수 있습니다:

```swift
print("The first number is \(firstNumber).")
// "The first number is 10." 를 인쇄합니다.
print("The second number is \(secondNumber).")
// "The second number is 42." 를 인쇄합니다.
```

(`:` _타입 (type)_ 형식인) '타입 보조 설명' 은, [Type Inference (타입 추론)]({% post_url 2020-02-20-Types %}#type-inference-타입-추론) 에서 설명한 것처럼, _상수 이름 (constant name)_ 의 타입을 추론할 수 있는 때는 '옵션' 입니다.

'상수 타입 속성 (constant type property)' 을 선언하려면, '`static` 선언 수정자' 로 선언을 표시합니다. 클래스의 '상수 타입 속성' 은 암시적으로 항상 '최종 (final)' 이며; 하위 클래스의 재정의를 허용 또는 불허하려고 `class` 나 `final` 선언 수정자를 표시할 수 없습니다.[^final] 타입 속성은 [Type Properties (타입 속성)]({% post_url 2020-05-30-Properties %}#type-properties-타입-속성) 에서 논의합니다.

상수에 대한 더 많은 정보 및 사용 시점에 대한 안내는, [Constants and Variables (상수와 변수)]({% post_url 2016-04-24-The-Basics %}#constants-and-variables-상수와-변수) 부분과 [Stored Properties (저장 속성)]({% post_url 2020-05-30-Properties %}#stored-properties-저장-속성) 부분을 참고하기 바랍니다.

> GRAMMAR OF A CONSTANT DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID355)

### Variable Declaration (변수 선언)

_변수 선언 (variable declaration)_ 은 '이름 붙인 변수 값' 을 프로그램에 도입하며 `var` 키워드로 선언합니다.

변수 선언은 여러가지 형식으로, '저장 및 계산 변수와 속성', '저장 변수와 속성 관찰자', 그리고 '정적 변수 속성' 을 포함한, 서로 다른 종류의 '이름 붙인, 변경 가능한 값' 을 선언합니다. 사용하기 적절한 형식은 변수를 선언하는 영역과 선언하려는 변수의 종류에 달려 있습니다.

> 속성은, [Protocol Property Declaration (프로토콜 속성 선언)](#protocol-property-declaration-프로토콜-속성-선언) 에서 설명한 것처럼, '프로토콜 선언' 에서 선언할 수도 있습니다.

하위 클래스에 있는 속성은, [Overriding (재정의하기)]({% post_url 2020-03-31-Inheritance %}#overriding-재정의하기) 에서 설명한 것처럼, 하위 클래스의 속성 선언을 '`override` 선언 수정자' 로 표시함으로써 재정의할 수 있습니다.

#### Stored Variables and Stored Variable Properties (저장 변수와 저장 변수 속성)

다음 형식은 '저장 변수' 또는 '저장 변수 속성' 을 선언합니다:

&nbsp;&nbsp;&nbsp;&nbsp;var `variable name-변수 이름`: `type-타입` = `expression-표현식`

이 형식의 변수 선언은 '전역 (global)' 이나, '함수 지역 (local)' 에서, 또는 클래스나 구조체 선언에서 정의합니다. 이 형식의 변수를 '전역' 이나 '함수 지역' 에서 선언할 때는, _저장 변수 (stored variable)_ 를 가리킵니다. 클래스나 구조체 선언에서 선언할 때는, _저장 변수 속성 (stored variable property)_ 을 가리킵니다.

'초기자 _표현식 (expression)_' 은 프로토콜 선언에 있을 순 없지만, 다른 모든 상황에서는, 초기자 _표현식 (expression)_ 이 '옵션' 입니다. 그렇다 하더라도, 초기자 _표현식 (expression)_ 이 아무 것도 없으면, 변수 선언이 반드시 '(`:` _타입 (type)_ 형식의) 명시적인 타입 보조 설명' 을 포함해야 합니다.

상수 선언에서와 마찬가지로, _변수 이름 (variable name)_ 이 '튜플 패턴' 이면, 튜플의 각 항목 이름을 '초기자 _표현식 (expression)_' 에 있는 관련 값과 연결합니다.

이름이 제시하는 것처럼, '저장 변수' 나 '저장 변수 속성' 의 값은 메모리에 저장됩니다.

#### Computed Variables and Computed Properties (계산 변수와 계산 속성)

다음 형식은 '계산 변수' 또는 '계산 속성' 을 선언합니다:

&nbsp;&nbsp;&nbsp;&nbsp;var `variable name-변수 이름`: `type-타입` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;get {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;set (`setter name-설정자 이름`) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statement-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

이 형식의 변수 선언은 '전역 ' 이나, '함수 지역' 에서, 또는 클래스, 구조체, 열거체, 및 '익스텐션 (extension)' 선언에서 정의합니다. 이 형식의 변수를 '전역' 이나 '함수 지역' 에서 선언할 때는, _계산 변수 (computed variable)_ 를 가리킵니다. 클래스나, 구조체, 또는 '익스텐션' 선언에서 선언할 때는, _계산 속성 (computed property)_ 을 가리킵니다.

'획득자 (getter)' 는 값을 읽는 데 사용하고, '설정자 (setter)' 는 값을 쓰는 데 사용합니다. '설정자 절' 은 옵션이며, '획득자' 만 필요할 때는, [Read-Only Computed Properties (읽기-전용 계산 속성)]({% post_url 2020-05-30-Properties %}#read-only-computed-properties-읽기-전용-계산-속성) 에서 설명한 것처럼, 두 '절' 다 생략하고 단순히 '요청 값' 을 직접 반환할 수 있습니다. 그러나 '설정자 절' 을 제공한다면, 반드시 '획득자 절' 도 제공해야 합니다.

_설정자 이름 (setter name)_ 과 테두리 괄호는 옵션입니다. '설정자 이름' 을 제공하면, 이를 '설정자 (setter)' 의 매개 변수 이름으로 사용합니다. '설정자 이름' 을 제공하지 않으면, [Shorthand Setter Declaration (설정자 선언의 줄임 표현)]({% post_url 2020-05-30-Properties %}#shorthand-setter-declaration-설정자-선언의-줄임-표현) 에서 설명한 것처럼, '설정자' 의 '기본 매개 변수 이름' 이 `newValue` 가 됩니다.

'이름 붙인 저장 값'[^stored-named-values] 및 '저장 변수 속성' 과 달리, '이름 붙인 계산 값' 이나 '계산 속성' 의 값은 메모리에 저장하지 않습니다.

계산 속성에 대한 더 자세한 정보와 예제를 보려면, [Computed Properties (계산 속성)]({% post_url 2020-05-30-Properties %}#computed-properties-계산-속성) 부분을 참고하기 바랍니다.

#### Stored Variable Observers and Property Observers (저장 변수 관찰자와 저장 속성 관찰자)

`willSet` 과 `didSet` 관찰자를 가진 '저장 변수나 속성' 을 선언할 수도 있습니다. 관찰자를 가진 저장 변수나 속성의 선언 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;var `variable name-변수 이름`: `type-타입` = `expression-표현식` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;willSet(`setter name-설정자 이름`) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;didSet(`setter name-설정자 이름`) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

이 형식의 변수 선언은 '전역 (global)' 이나, 함수 지역, 또는 클래스나 구조체 선언에서 정의합니다. 이 형식의 변수 선언을 '전역' 이나 '함수 지역' 에서 선언할 때의, 관찰자는 _저장 변수 관찰자 (stored variable observers)_ 를 가리킵니다. 클래스나 구조체 선언에서 선언할 때의, 관찰자는 _속성 관찰자 (property observers)_ 를 가리킵니다.

어떤 저장 속성에든 속성 관찰자를 추가할 수 있습니다. 속성 관찰자는, [Overriding Property Observers (속성 관찰자 재정의하기)]({% post_url 2020-03-31-Inheritance %}#overriding-property-observers-속성-관찰자-재정의하기) 에서 설명한 것처럼, 하위 클래스 안에서 속성을 '재정의' 함으로써 어떤 (저장 또는 계산) 상속 속성에도 추가할 수 있습니다.

초기자 _표현식 (expression)_[^expression] 은 클래스나 구조체 선언에서는 옵션이지만, 다른 곳에서는 필수입니다. _타입 (type)_ 보조 설명은 초기자 _표현식 (expression)_ 으로 타입을 추론할 수 있을 때는 옵션입니다. 이 표현식은 최초로 속성 값을 읽을 때 평가합니다. 이를 읽지 않고 속성의 초기 값을 덮어 쓰면, 이 표현식은 최초로 속성에 쓰기 전 평가합니다.

`willSet` 과 `didSet` 관찰자는 변수나 속성 값을 설정하고 있을 때 이를 관찰하고 (적절하게 응답하는) 방법을 제공합니다. 관찰자는 변수나 속성이 최초로 초기화될 때는 호출하지 않습니다. 그 대신, 초기화 밖에서 값이 설정될 때만 호출합니다.

`willSet` 관찰자는 변수나 속성 값을 설정하기 직전에 호출됩니다. 새 값은 `willSet` 관찰자에 상수로 전달되며, 따라서 `willSet` 절의 구현에서 바꿀 수 없습니다. `didSet` 관찰자는 새 값을 설정한 직후에 호출됩니다. `willSet` 관찰자와는 대조적으로, 여전히 접근이 필요한 경우를 위해 예전 변수나 속성 값을 `didSet` 관찰자에 전달합니다. 그렇다 하더라도, 자신의 '`didSet` 관찰자 절' 안에서 변수나 속성 값을 할당하면, 새로 할당한 값이 방금 설정하여 `willSet` 관찰자로 전달됐던 것을 대체할 것입니다.

`willSet` 과 `didSet` 절의 _설정자 이름 (setter name)_ 과 테두리 괄호는 옵션입니다. '설정자 이름' 을 제공하면, `willSet` 과 `didSet` 관찰자의 매개 변수 이름으로 사용합니다. '설정자 이름' 을 제공하지 않으면, `willSet` 관찰자의 '기본 매개 변수 이름' 은 `newValue` 이고 `didSet` 관찰자의 '기본 매개 변수 이름' 은 `oldValue` 입니다.

`willSet` 절을 제공할 때는 `didSet` 절이 옵션입니다. 마찬가지로, `didSet` 절을 제공할 때는 `willSet` 절이 옵션입니다.

`didSet` 관찰자 본문에서 '예전 값' 을 참조하면, '예전 값' 이 사용 가능하도록, 관찰자에 앞서 '획득자' 를 호출합니다. 그 외의 경우, 상위 클래스 '획득자' 의 호출 없이 '새 값' 을 저장합니다. 아래 예제는 상위 클래스에서 정의하고 관찰자 추가를 위해 하위 클래스에서 재정의한 계산 속성을 보여줍니다: 

```swift
class Superclass {
  private var xValue = 12
  var x: Int {
    get { print("Getter was called"); return xValue }
    set { print("Setter was called"); xValue = newValue }
  }
}

// 이 하위 클래스는 자신의 관찰자에서 oldValue 를 참조하지 않으므로,
// 상위 클래스 획득자는 값을 출력할 때 딱 한 번만 호출됩니다.
class New: Superclass {
  override var x: Int {
    didSet { print("New value \(x)") }
  }
}
let new = New()
new.x = 100
// "Setter was called" 를 인쇄합니다.
// "Getter was called" 를 인쇄합니다.
// "New value 100" 를 인쇄합니다.

// 이 하위 클래스는 자신의 관찰자에서 oldValue 를 참조하므로,
// 상위 클래스 획득자는 설정자에 앞서 한 번, 값을 출력할 때 다시 한 번 호출됩니다.
class NewAndOld: Superclass {
  override var x: Int {
    didSet { print("Old value \(oldValue) - new value \(x)") }
  }
}
let newAndOld = NewAndOld()
newAndOld.x = 200
// "Getter was called" 를 인쇄합니다.
// "Setter was called" 를 인쇄합니다.
// "Getter was called" 를 인쇄합니다.
// "Old value 12 - new value 200" 를 인쇄합니다.
```

속성 관찰자에 대한 더 많은 정보와 사용 방법에 대한 예제는, [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 부분을 참고하기 바랍니다.

#### Type Variable Properties (타입 변수 속성)

'타입 변수 속성' 을 선언하려면, '`static` 선언 수정자' 로 선언을 표시합니다. 클래스는 하위 클래스에 의한 상위 클래스 구현의 재정의를 허용하기 위해 '타입 계산 속성'[^type-computed-properties] 을 '`class` 선언 수정자' 로 대신 표시할 수 있습니다. 타입 속성은 [Type Properties (타입 속성)]({% post_url 2020-05-30-Properties %}#type-properties-타입-속성) 부분에서 논의합니다.

> GRAMMAR OF A VARIABLE DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID356)

### Type Alias Declaration (타입 별명 선언)

_타입 별명 선언 (type alias declaration)_ 은 '기존 타입에 이름 붙인 별명' 을 프로그램에 도입합니다. '타입 별명 선언' 은 `typealias` 키워드로 선언하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;typealias `name-이름` = `existing type-기존 타입`

'타입 별명' 을 선언한 후엔, 프로그램 어디서나 _기존 타입 (existing type)_ 대신 '별명 붙인 _이름 (name)_' 을 사용할 수 있습니다. _기존 타입 (existing type)_ 은 '이름 붙인 타입' 이거나 '복합 타입' 일 수 있습니다. 타입 별명은 새로운 타입을 생성하진 않으며; 단순히 기존 타입을 참조하는 이름을 허용하는 것입니다.

'타입 별명 선언' 은 '기존 일반화 타입' 에 이름을 부여하기 위해 '일반화 (generic) 매개 변수' 를 사용할 수 있습니다. 타입 별명은 기존 타입의 일부 또는 모든 '일반화 매개 변수' 에 '고정 (concrete) 타입' 을 제공할 수 있습니다. 예를 들면 다음과 같습니다:

```swift
typealias StringDictionary<Value> = Dictionary<String, Value>

// 다음 딕셔너리는 똑같은 타입입니다.
var dictionary1: StringDictionary<Int> = [:]
var dictionary2: Dictionary<String, Int> = [:]
```

'일반화 매개 변수를 가진 타입 별명' 을 선언할 때는, '해당 매개 변수에 대한 구속 조건' 이 '기존 타입의 일반화 매개 변수에 대한 구속 조건' 과 반드시 정확하게 일치해야 합니다. 예를 들면 다음과 같습니다:

```swift
typealias DictionaryOfInts<Key: Hashable> = Dictionary<Key, Int>
```

타입 별명과 기존 타입은 상호 교환해서 사용 가능해야 하기 때문에, 타입 별명에 추가적인 '일반화 구속 조건 (generic constraints)' 을 도입할 순 없습니다.

타입 별명은 '선언에 있는 모든 일반화 매개 변수를 생략함' 으로써 '기존 타입의 일반화 매개 변수' 를 발송할 수 있습니다. 예를 들어, 다음에 선언한 `Diccionario` 라는 타입 별명은 `Dictionary` 와 똑같은 '일반화 매개 변수 및 구속 조건' 을 가집니다.

```swift
typealias Diccionario = Dictionary
```

'프로토콜 선언' 안에서는, 자주 사용하는 타입에 타입 별명으로 더 짧고 편리한 이름을 줄 수 있습니다. 예를 들면 다음과 같습니다:

```swift
protocol Sequence {
  associatedtype Iterator: IteratorProtocol
  typealias Element = Iterator.Element
}

func sum<T: Sequence>(_ sequence: T) -> Int where T.Element == Int {
  // ...
}
```

이 타입 별명 없이는, `sum` 함수가 '결합 타입' 을 `T.Element` 대신 `T.Iterator.Element` 라고 참조했을 것입니다.

[Protocol Associated Type Declaration (프로토콜의 결합 타입 선언)](#protocol-associated-type-declaration-프로토콜의-결합-타입-선언) 도 참고하기 바랍니다.

> GRAMMAR OF A TYPE ALIAS DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID361)

### Function Declaration (함수 선언)

_함수 선언 (function declaration)_ 은 프로그램에 함수나 메소드를 도입합니다. 클래스, 구조체, 열거체, 또는 프로토콜에서 선언한 함수는 _메소드 (method)_ 를 가리킵니다. '함수 선언' 은 `func` 키워드로 선언하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;func `function name-함수 이름`(`parameters-매개 변수`) -> `return type-반환 타입` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

함수의 반환 타입이 `Void` 면, 반환 타입을 다음 처럼 생략할 수 있습니다:

&nbsp;&nbsp;&nbsp;&nbsp;func `function name-함수 이름`(`parameters-매개 변수`) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

각 매개 변수의 타입은 반드시 포함해야 합니다-이는 추론할 수 없습니다. 매개 변수 타입 앞에 `inout` 을 작성하면, 매개 변수를 함수 영역 안에서 수정할 수 있습니다. '입-출력 (in-out) 매개 변수' 는, 아래의, [In-Out Parameters (입-출력 매개 변수)](#in-out-parameters-입-출력-매개-변수) 에서 자세하게 논의합니다.

'함수 선언' 의 _구문 (statements)_ 이 '단일 표현식' 만 포함하고 있으면 '해당 표현식의 값' 을 반환한다고 이해합니다. 표현식의 타입과 함수의 반환 타입이 `Void` 가 아니며 `Never` 같이 '어떤 case 값도 가지지 않는 열거체' 가 아닐 때만 이 '암시적인 반환 구문' 을 고려합니다.

함수는 반환 타입으로 '튜플 타입' 을 사용하여 여러 개의 값을 반환할 수 있습니다.

'함수 정의 (function definition)'[^function-definition] 가 또 다른 '함수 선언' 안에 있을 수 있습니다. 이런 종류의 함수를 _중첩 함수 (nested function)_ 라고 합니다.

중첩 함수는-'입-출력 매개 변수' 같이-절대 벗어나지 않음을 보증한 또는 '벗어나지 않는 (nonescaping) 함수 인자' 로 전달한 값을 붙잡으면 '벗어나지 않 (nonescaping)' 습니다.[^escaping] 그 외의 경우, 중첩 함수는 '벗어나는 (escaping) 함수' 입니다.

중첩 함수에 대한 논의는, [Nested Functions (중첩 함수)]({% post_url 2020-06-02-Functions %}#nested-functions-중첩-함수) 부분을 참고하기 바랍니다.

#### Parameter Names (매개 변수 이름)

'함수 매개 변수' 는 여러 형식으로 된 각 매개 변수들을 쉼표로-구분한 목록입니다. 함수 호출에서의 인자 순서는 반드시 함수의 선언에 있는 매개 변수 순서와 일치해야 합니다. 매개 변수 목록에 있는 가장 단순한 요소의 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`parameter name-매개 변수 이름`: `parameter type-매개 변수 타입`

매개 변수는, 함수 본문 안에서 사용하는, 이름 뿐 아니라, 함수나 메소드를 호출할 때 사용하는, '인자 이름표 (argument label)' 도 가집니다. 기본적으로, 매개 변수 이름을 '인자 이름표' 로도 사용합니다. 예를 들면 다음과 같습니다:

```swift
func f(x: Int, y: Int) -> Int { return x + y }
f(x: 1, y: 2) // x 와 y 둘 다 이름표가 있습니다.
```

'인자 이름표' 에 대한 기본 동작을 다음 형식 중 하나로 '재정의 (override)' 할 수 있습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`argument label-인자 이름표` `parameter name-매개 변수 이름`: `parameter type-매개 변수 타입`<br />
&nbsp;&nbsp;&nbsp;&nbsp;\_ `parameter name-매개 변수 이름`: `parameter type-매개 변수 타입`

매개 변수 이름 앞의 이름은 매개 변수에, 매개 변수 이름과는 다를 수 있는, '명시적인 인자 이름표' 를 부여니다. 함수나 메소드 호출에서 관련 인자는 반드시 '주어진 인자 이름표' 를 사용해야 합니다.

매개 변수 이름 앞의 '밑줄 (`_`)' 은 '인자 이름표' 를 억제합니다. 함수나 메소드 호출에서 관련 인자는 반드시 이름표가 없어야 합니다.

```swift
func repeatGreeting(_ greeting: String, count n: Int) { /* 인사를 n 번 합니다 */ }
repeatGreeting("Hello, world!", count: 2) //  count 에는 이름표가 있지만, greeting 에는 없습니다.
```

#### In-Out Parameters (입-출력 매개 변수)

'입-출력 매개 변수' 는 다음 처럼 전달합니다:

1. 함수를 호출할 때, 인자 값을 복사합니다.
2. 함수 본문에서, 복사본을 수정합니다.
3. 함수를 반환할 때, 복사본의 값을 원본 인자에 할당합니다.

이런 동작을 _복사-입력 복사-출력 (copy-in copy-out)_ 또는 _값-결과에 의한 호출 (call by value result)_[^call-by-value-result] 이라고 합니다. 예를 들어, '계산 속성' 또는 '관찰자를 가진 속성' 을 '입-출력 매개 변수' 로 전달할 때, 그 '획득자 (getter)' 는 함수 호출 시에 호출하고 그 '설정자 (setter)' 는 함수 반환 시에 호출합니다.

'최적화' 로써, 인자가 메모리의 물리 주소에 저장된 값일 때는, 함수 본문 내 외부 둘 다에서 똑같은 메모리 위치를 사용합니다. 이 최적화된 동작을 _참조에 의한 호출 (call by reference)_ 이라고 하는데; 복사라는 부담을 제거하면서 '복사-입력 복사-출력 모델' 의 모든 필수 조건을 만족합니다.[^call-by-reference] '참조에-의한-호출 최적화' 에 의존하지 않고, 최적화 하든 안하든 올바르게 동작하게 하려면, 주어진 '복사-입력 복사-출력' 모델로 코드를 작성합니다.

함수 안에서는, 현재 영역에서 원본 값이 사용 가능한 경우에도, '입-출력 인자' 로 전달한 값에 접근하지 않도록 합니다. 원본에 대한 접근은, 스위프트의 '메모리 독점권 보증 (exclusivity guarantee)' 을 위반하는, '값에 대한 동시 접근 (simultaneous aceess)' 입니다. 똑같은 이유로, 동일 값을 여러 개의 '입-출력 매개 변수' 로 전달할 수 없습니다.

'메모리 안전성' 과 '메모리 독점권' 에 대한 더 많은 정보는, [Memory Safety (메모리 안전성)]({% post_url 2020-04-07-Memory-Safety %}) 장을 참고하기 바랍니다.

입-출력 매개 변수를 붙잡는 클로저나 중첩 함수는 반드시 '벗어나지 않아야 (nonescaping)' 합니다. '입-출력 매개 변수' 를 '변경 (mutating)' 없이 붙잡을 필요가 있으면, '붙잡을 목록 (capture list)' 을 사용하여 매개 변수를 명시적으로 변경 불가능하게 붙잡도록 합니다.[^closure-with-inout-parameter]

```swift
func someFunction(a: inout Int) -> () -> Int {
  return { [a] in return a + 1 }
}
```

함수 반환 전에 모든 변경이 종료됐음을 보장하는 '다중 쓰레드 코드' 에서와 같이, 입-출력 매개 변수를 붙잡아서 변경할 필요가 있으면, 명시적인 '지역 복사본 (local copy)' 을 사용합니다.

```swift
func multithreadedFunction(queue: DispatchQueue, x: inout Int) {
  // 지역 복사본을 만들고 수동 복사로-되돌립니다.
  var localX = x
  defer { x = localX }

  // localX 에 대한 비동기 연산을 한 다음, 반환 전에 기다립니다.
  queue.async { someMutatingOperation(&localX) }
  queue.sync {}
}
```

입-출력 매개 변수에 대한 더 많은 논의와 예제는, [In-Out Parameters (입-출력 매개 변수)]({% post_url 2020-06-02-Functions %}#in-out-parameters-입-출력-매개-변수) 부분을 참고하기 바랍니다.

#### Special Kinds of Parameters (특수한 종류의 매개 변수)

매개 변수는, 다음 형식을 사용하여, 무시하거나, 가변 개수의 값을 취하거나, 기본 값을 제공할 수 있습니다:

&nbsp;&nbsp;&nbsp;&nbsp;\_ : `parameter type-매개 변수 타입`<br />
&nbsp;&nbsp;&nbsp;&nbsp;`parameter name-매개 변수 이름`: `parameter type-매개 변수 타입`...<br />
&nbsp;&nbsp;&nbsp;&nbsp;`parameter name-매개 변수 이름`: `parameter type-매개 변수 타입` = `default argument value-기본 설정 인자 값`

'밑줄 (`_`) 매개 변수' 는 명시적으로 무시하는 것으로 함수 본문 안에서 접근할 수 없습니다.

'기초 타입 이름' 바로 뒤에 세 점 (`...`) 을 가진 매개 변수는 '가변 (variadic) 매개 변수' 인 것으로 이해합니다. '가변 매개 변수' 바로 뒤의 매개 변수는 '인자 이름표' 를 반드시 가져야 합니다.[^variadic-label] 함수는 여러 개의 '가변 매개 변수' 를 가질 수 있습니다. 가변 매개 변수는 '기초 타입 이름의 원소' 들을 담고 있는 배열로 취급합니다. 예를 들어, `Int...` 라는 가변 매개 변수는 `[Int]` 로 취급합니다. '가변 매개 변수' 의 사용 예제는, [Variadic Parameters (가변 매개 변수)]({% post_url 2020-06-02-Functions %}#variadic-parameters-가변-매개-변수) 부분을 참고하기 바랍니다.

자신의 타입 뒤에 '등호 (`=`) 기호와 표현식' 을 가진 매개 변수는 '표현식으로 주어진 기본 값' 을 가진다고 이해합니다. 주어진 표현식은 함수를 호출할 때 평가합니다. 함수 호출 시에 매개 변수를 생략하면, 그 대신 '기본 값' 을 사용합니다.

```swift
func f(x: Int = 42) -> Int { return x }
f()       // 유효, 기본 값 사용
f(x: 7)   // 유효, 제공힌 값 사용
f(7)      // 무효, 인자 이름표 누락
```

#### Special Kinds of Methods (특수한 종류의 메소드)

`self` 를 수정하는 열거체나 구조체의 메소드는 반드시 '`mutating` 선언 수정자 (modifier)' 로 표시해야 합니다.

상위 클래스 메소드를 재정의하는 메소드는 반드시 '`override` 선언 수정자' 로 표시해야 합니다. `override` 수정자 없이 메소드를 재정의하거나 또는 상위 클래스 메소드를 재정의하지 않는 메소드에 `override` 수정자를 사용하는 것은 '컴파일-시간 에러' 입니다.

타입의 인스턴스 보다는 타입 자체와 결합된 메소드는 열거체와 구조체라면 `static` 선언 수정자로, 클래스라면 `static` 으로나 `class` 선언 수정자로, 반드시 표시해야 합니다. '`class` 선언 수정자' 로 표시한 '클래스 타입 메소드' 는 하위 클래스 구현에서 재정의할 수 있는데; `class final` 이나 `static` 으로 표시한 '클래스 타입 메소드' 는 재정의할 수 없습니다.

#### Methods with Special Names (특수한 이름을 가진 메소드)

특수한 이름을 가진 여러 메소드는 '함수 호출 구문' 을 '수월한 구문 (syntactic sugar)' 으로 할 수 있게 합니다. 타입에서 이 메소드 중 하나를 정의하면, '함수 호출 구문' 에서 타입의 인스턴스를 사용할 수 있습니다. '함수 호출' 은 해당 인스턴스에 대한 '특수한 이름을 붙인 메소드' 중 하나를 호출하는 것이라고 이해합니다.

클래스, 구조체, 및 열거체 타입은, [dynamicCallable (동적으로 호출 가능한)]({% post_url 2020-08-14-Attributes %}#dynamiccallable-동적으로-호출-가능한) 에서 설명한 것처럼, `dynamicallyCall(withArguments:)` 메소드나 `dynamicallyCall(withKeywordArguments:)` 메소드를 정의함으로써, 또는 아래 설명하는 것처럼, '함수-처럼-호출하는 (call-as-function) 메소드' 를 정의함으로써, '함수 호출 구문' 을 지원할 수 있습니다. 타입에서 '함수-처럼-호출하는 메소드' 와 '`dynamicCallable` 특성을 사용한 메소드' 둘 다를 정의하면, 어느 메소드든 사용해도 되는 상황에서 컴파일러는 '함수-처럼-호출하는 메소드' 에 우선권을 줍니다.

'함수-처럼-호출하는 메소드' 의 이름은 `callAsFunction()` 이거나, `callAsFunction(` 으로 시작하고 이름표가 있거나 없는 인자를 추가한 또 다른 이름입니다-예를 들어, `callAsFunction(_:_:)` 과 `callAsFunction(something:)` 도 '함수-처럼-호출하는 메소드' 이름으로 유효합니다.

다음 함수 호출은 서로 '동치 (equivalent)' 입니다:

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
// 두 함수 호출 모두 208 을 인쇄합니다.
```

'함수-처럼-호출하는 메소드' 와 '`dynamicCallable` 특성의 메소드' 는 '타입 시스템에 부호화 (encode) 해서 넣을 정보량' 과 '실행 시간에 가능한 동적 동작의 크기' 사이에 '서로 다른 절충점 (trade-offs)' 을 만듭니다. '함수-처럼-호출하는 메소드' 를 선언할 땐, 인자 개수와, 각 인자의 타입과 이름표를 지정합니다. '`dynamicCallable` 특성의 메소드' 는 인자 배열을 쥐는데 사용할 타입만 지정합니다.

'함수-처럼-호출하는 메소드' 나, '`dynamicCallable` 특성의 메소드' 정의는, 마치 '함수 호출 표현식' 이 아닌 어떤 곳에서는 함수인 것처럼 해당 타입의 인스턴스를 사용하도록 해주진 않습니다. 예를 들면 다음과 같습니다:

```swift
let someFunction1: (Int, Int) -> Void = callable(_:scale:)  // 에러
let someFunction2: (Int, Int) -> Void = callable.callAsFunction(_:scale:)
```

'`subscript(dynamicMemberLookup:)` 첨자 연산' 은, [dynamicMemberLookup (동적으로 멤버 찾아보기)]({% post_url 2020-08-14-Attributes %}#dynamicmemberlookup-동적으로-멤버-찾아보기) 에서 설명한 것처럼, '멤버 찾아보기' 를 '수월한 구문' 으로 할 수 있게 합니다.

#### Throwing Functions and Methods (던지는 함수와 메소드)

에러를 던질 수 있는 함수와 메소드는 반드시 `throws` 키워드로 표시해야 합니다. 이 함수와 메소드들을 _던지는 함수 (throwing functions)_ 와 _던지는 메소드 (throwing methods)_ 라고 합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;func `function name-함수 이름`(`parameters-매개 변수`) throws -> `return type-반환 타입` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

던지는 함수나 메소드에 대한 호출은 반드시 `try` 나 `try!` 표현식으로 (즉, `try` 나 `try!` 연산자 영역 안에) 포장해야 합니다.

`throws` 키워드는 함수 타입의 일부분으로, '던지지 않는 (nonthrowing) 함수' 는 '던지는 함수' 의 하위 타입입니다. 그 결과, '던지는 것' 을 예상하는 곳에서 '던지지 않는 함수' 를 사용할 수 있습니다.

함수가 에러를 던질 수 있는지 만을 기초로 하여 함수를 '중복 정의 (overload)' 할 수는 없습니다. 그렇다 하더라도, 함수의 _매개 변수 (parameter)_ 가 에러를 던질 수 있는 지를 기초로 함수를 '중복 정의' 할 수는 있습니다.

'던지는 메소드' 는 '던지지 않는 메소드' 를 '재정의 (override)' 할 수 없으며, '던지는 메소드' 가 '던지지 않는 메소드' 에 대한 '프로토콜 필수 조건' 을 만족할 순 없습니다. 그렇다 하더라도, '던지지 않는 메소드' 는 '던지는 메소드' 를 재정의할 수 있으며, '던지지 않는 메소드' 가 '던지는 메소드' 에 대한 '프로토콜 필수 조건' 을 만족할 순 있습니다.

#### Rethrowing Functions and Methods (다시 던지는 함수와 메소드)

함수나 메소드는 자신의 함수 매개 변수가 에러를 던질 때만 에러를 던진다고 지시하기 위해 `rethrows` 키워드로 선언할 수 있습니다. 이 함수와 메소드를 _다시 던지는 함수 (rethrowing functions)_ 와 _다시 던지는 메소드 (rethrowing methods)_ 라고 합니다. '다시 던지는 함수와 메소드' 는 최소한 하나의 '던지는 함수 매개 변수' 는 반드시 가져야 합니다:

```swift
func someFunction(callback: () throws -> Void) rethrows {
  try callback()
}
```

'다시 던지는 함수나 메소드' 는 '`catch` 절' 에서만 `throw` 문을 담을 수 있습니다. 이는 `do`-`catch` 문 안에서 '던지는 함수' 를 호출하도록 그리고 다른 에러를 던짐으로써 `catch` 절이 에러를 처리하도록 해줍니다. 이에 더하여, `catch` 절은 반드시 '다시 던지는 함수' 의 '던지는 매개 변수'[^throwing-parameter] 가 던진 에러만 처리해야 합니다. 예를 들어, 다음은 `alwaysThrows()` 가 던진 에러도 `catch` 절이 처리할 것이기 때문에 무효입니다.

```swift
func alwaysThrows() throws {
  throw SomeError.error
}
func someFunction(callback: () throws -> Void) rethrows {
  do {
    try callback()
    try alwaysThrows()  // 무효, alwaysThrows() 는 '던지는 매개 변수' 가 아닙니다.
  } catch {
    throw AnotherError.error
  }
}
```

'던지는 메소드' 는 '다시 던지는 메소드' 를 재정의할 수 없으며, '던지는 메소드' 가 '다시 던지는 메소드' 에 대한 '프로토콜 필수 조건' 을 만족할 순 없습니다. 그렇다 하더라도, '다시 던지는 메소드' 는 '던지는 메소드' 를 재정의 할 수 있으며, '다시 던지는 메소드' 가 '던지는 메소드' 에 대한 '프로토콜 필수 조건' 을 만족할 순 있습니다.

#### Asynchronous Functions and Methods (비동기 함수와 메소드)

비동기로 실행하는 함수와 메소드는 반드시 `async` 키워드로 표시해야 합니다. 이 함수와 메소드를 _비동기 함수 (asynchronous functions)_ 와 _비동기 메소드 (asynchronous methods)_ 라고 합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;func `function name-함수 이름`(`parameters-매개 변수`) async -> `return type-반환 타입` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

비동기 함수나 메소드에 대한 호출은 반드시 `await` 표현식으로 포장해야 합니다-즉, 반드시 `await` 연산자 영역 안에 있어야 합니다. 

`async` 키워드는 함수 타입의 일부분으로, '동기 (synchronous) 함수' 는 '비동기 함수' 의 하위 타입입니다. 그 결과, '비동기 함수' 를 예상하는 곳에서 '동기 함수' 를 사용할 수 있습니다. 예를 들어, '비동기 메소드' 를 '동기 메소드' 로 재정의할 수 있으며, '비동기 메소드' 를 요구하는 '프로토콜 필수 조건' 을 '동기 메소드' 가 만족할 수도 있습니다. 

#### Functions that Never Return (절대 반환하지 않는 함수)

스위프트는, 호출하는 쪽으로 반환하지 않는 함수나 메소드를 지시하는, `Never` 타입을 정의합니다. `Never` 라는 반환 타입을 가진 함수와 메소드를 _반환하지 않는 (nonreturning)_ 것이라고 합니다. '반환하지 않는 함수와 메소드' 는 '복구할 수 없는 에러' 를 유발하든지 아니면 '무한정 계속되는 일련의 작업'[^indefinitely] 을 시작합니다. 이는 다른 경우라면 호출 후에 바로 실행할 코드가 절대 실행되지 않는다는 의미입니다. '던지고 함수와 다시 던지는 함수' 는, 반환하지 않을 때에도, 적절한 '`catch` 절' 로 프로그램 제어를 옮길 수 있습니다.

'반환하지 않는 함수나 메소드' 는, [Guard Statement ('guard' 문)]({% post_url 2020-08-20-Statements %}#guard-statement-guard-문) 에서 논의한 것처럼, 'guard 문의 `else` 절' 을 결론 내리고자 호출할 수 있습니다.

'반환하지 않는 메소드' 를 재정의할 순 있지만, 새로운 메소드는 반드시 '자신의 반환 타입' 과 '반환하지 않는 동작' 을 보존해야 합니다.

> GRAMMAR OF A FUNCTION DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID362)

### Enumeration Declaration (열거체 선언)

_열거체 선언 (enumeration declaration)_ 은 '이름 붙인 열거체 타입' 을 프로그램에 도입합니다.

'열거체 선언' 은 두 개의 기초 형식을 가지며 `enum` 키워드로 선언합니다. 어느 형식으로 선언한 열거체 본문이든 '0' 개 이상의-_열거체 case 값 (enumeration cases)_ 이라는-값과, 계산 속성, 인스턴스 메소드, 타입 메소드, 초기자, 타입 별명, 그리고 심지어 다른 열거체, 구조체, 클래스, 및 행위자 선언도 포함한, 어떤 개수의 선언도 담을 수 있습니다. 열거체 선언은 '정리자 (deinitializer)' 나 '프로토콜 선언' 을 담을 순 없습니다.

열거체 타입은 어떤 개수의 프로토콜도 채택할 수 있지만, 클래스, 구조체, 또는 다른 열거체를 상속할 수는 없습니다.

클래스 및 구조체와는 달리, 열거체 타입은 암시적으로 제공되는 '기본 초기자' 를 가지지 않으며; 모든 초기자는 반드시 명시적으로 선언해야 합니다. 초기자는 열거체의 다른 초기자로 '위임 (delegate)' 할 수 있지만, 초기자가 '열거체 case 값' 중 하나를 `self` 에 할당한 후에만 초기화 과정이 완료됩니다.

구조체와는 같지만 클래스와는 달리, 열거체는 '값 타입' 으로; 변수나 상수에 할당할 때나, 함수 호출의 인자로 전달할 때, 열거체의 인스턴스를 복사합니다. '값 타입' 에 대한 정보는, [Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#structures-and-enumerations-are-value-types-구조체와-열거체는-값-타입입니다) 부분을 참고하기 바랍니다.

열거체 타입의 동작은, [Extension Declaration (익스텐션 선언)](#extension-declaration-익스텐션-선언) 에서 논의한 것처럼, '익스텐션 선언' 으로 확장할 수 있습니다.

#### Enumerations with Cases of Any Type (어떤 타입이든 되는 'case 값' 을 가진 열거체)

다음 형식은 어떤 타입이든 되는 '열거체 case 값' 을 담는 '열거체 타입' 을 선언합니다:[^any-type]

&nbsp;&nbsp;&nbsp;&nbsp;enum `enumeration name-열거체 이름`: `adopted protocols-채택한 프로토콜` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case `enumeration case 1-열거체 case 값 1`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case `enumeration case 2-열거체 case 값 2`(`associated value types-결합 값 타입`)<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

이 형식으로 선언한 열거체를 다른 프로그래밍 언어에서는 _discriminated unions (차별화된 공용체)_ 라고 하기도 합니다.

이 형식에서, 각각의 'case 블럭' 은 `case` 키워드와 그 뒤에, 쉼표로 구분한, 하나 이상의 '열거체 case 값' 으로 구성합니다. 각 'case 값' 이름은 반드시 유일해야 합니다. 각 'case 값' 은 '주어진 타입의 값을 저장한다' 고 지정할 수도 있습니다. 이 타입들은, 'case 값' 이름 바로 다음의, _결합 값 타입 (associated value types)_ 튜플에서 지정합니다.

'결합 값을 저장한 열거체 case 값' 은 '지정한 결합 값을 가진 열거체 인스턴스를 생성하는 함수' 처럼 사용할 수 있습니다. 그리고 그냥 함수 같이, '열거체 case 값' 에 대한 참조를 가질 수도 코드 나중에 이를 적용할 수도 있습니다.

```swift
enum Number {
  case integer(Int)
  case real(Double)
}
let f = Number.integer
// f 는 타입이 (Int) -> Number 인 함수입니다

// 정수 값을 가진 Number 인스턴스 배열을 생성하고자 f 를 적용합니다
let evenInts: [Number] = [0, 2, 4, 6].map(f)
```

'결합 값 타입을 가진 case 값' 에 대한 더 많은 정보와 예제를 보려면, [Associated Values (결합 값)]({% post_url 2020-06-13-Enumerations %}#associated-values-결합-값) 부분을 참고하기 바랍니다.

**Enumerations with Indirection ('간접 (indirection)' 을 가지는 열거체)**

열거체는 '재귀 구조 (recursive structure)', 즉, '결합 값' 이 열거체 타입 그 자체의 인스턴스일 수 있는 'case 값' 을 가질 수 있습니다. 하지만, 열거체 타입의 인스턴스는 '값 의미 구조' 를 가지며, 이는 메모리에서 '고정된 구획 (fixed layout)' 을 가짐을 의미합니다. '재귀 (recursion)' 를 지원하려면, 컴파일러가 반드시 '간접 계층 (layer of indirection)' 을 집어 넣어야 합니다.

'특별한 열거체 case 값' 이 '간접 (indirection)' 을 할 수 있게 하려면, 이를 '`indirect` 선언 수정자' 로 표시합니다. '간접 case 값' 은 반드시 '결합 값' 을 가져야 합니다.

```swift
enum Tree<T> {
  case empty
  indirect case node(value: T, left: Tree, right: Tree)
}
```

'결합 값을 가진 열거체의 모든 case 값' 이 '간접' 을 할 수 있게 하려면, 전체 열거체를 '`indirect` 수정자' 로 표시합니다-이는 열거체가 `indirect` 수정자로 표시해야 할 'case 값' 을 아주 많이 가지고 있을 때 편리합니다.

'`indirect` 수정자로 표시한 열거체' 는 '결합 값을 가진 case 값' 과 '그렇지 않은 case 값' 을 섞어서 담을 수 있습니다. 그렇다 하더라도, '`indirect` 수정자로도 표시한 case 값' 은 어떤 것도 담을 수 없습니다.

#### Enumerations with Cases of a Raw-Value Type (원시-값 타입의 'case 값' 을 가지는 열거체)

다음 형식은 기초 타입이 똑같은 '열거체 case 값' 을 담는 열거체 타입을 선언합니다:

&nbsp;&nbsp;&nbsp;&nbsp;enum `enumeration name-열거체 이름`: `raw-value type-원시-값 타입`, `adopted protocols-채택한 프로토콜` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case `enumeration case 1-열거체 case 값 1` = `원시 값 1-raw value 1`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case `enumeration case 2-열거체 case 값 2` = `원시 값 2-raw value 2`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

이 형식에서, 각각의 'case 블럭' 은 `case` 키워드와 그 뒤에, 쉼표로 구분한, 하나 이상의 '열거체 case 값' 으로 구성합니다. 첫 번째 형식에서의 'case 값' 과는 달리, 각 'case 값' 은, 기초 타입이 똑같은, _원시 값 (raw value)_ 이라는, '실제 값' 을 가집니다. 이 값의 타입은 _원시-값 타입 (raw-value type)_ 에서 지정하며 반드시 정수, 부동 소수점 수, 문자열, 또는 단일 문자를 표현해야 합니다. 특히, _원시-값 타입 (raw-value type)_ 은 반드시 `Equatable` 프로토콜과 다음의 프로토콜들: '정수 글자 값' 이면 `ExpressibleByIntegerLiteral`, '부동-소수점 글자 값' 이면 `ExpressibleByFloatLiteral`, 어떤 개수의 문자든 담을 '문자열 글자 값' 이면 `ExpressibleByStringLiteral`, 단일 문자만 담을 '문자열 글자 값' 이면 `ExpressibleByUnicodeScalarLiteral` 또는 `ExpressibleByExtendedGraphemeClusterLiteral` 중 하나를 준수해야 합니다. 각 'case 값' 은 반드시 '유일한 이름' 을 가지며 '유일한 원시 값' 을 할당해야 합니다.

원시-값 타입을 `Int` 로 지정했는데 'case 값' 할당을 명시하지 않으면, `0`, `1`, `2`, 등의 값을 암시적으로 할당합니다. 각각의 '할당 안된 `Int` 타입 case 값' 은 '이전 case 의 원시 값' 에서 자동 증가한 '원시 값' 을 암시적으로 할당합니다.

```swift
enum ExampleEnum: Int {
  case a, b, c = 5, d
}
```

위 예제에서, `ExampleEnum.a` 의 원시 값은 `0` 이고 `ExampleEnum.b` 값은 `1` 입니다. 그리고 `ExampleEnum.c` 값은 `5` 라고 명시적으로 설정했기 때문에, `ExampleEnum.d` 의 값은 따라서 `5` 에서 자동으로 증가한 `6` 입니다.

원시-값 타입을 `String` 으로 지정했는데 'case 값' 할당을 명시하지 않으면, 각각의 '할당 안된 case 값' 은 '해당 case 이름과 똑같은 문장의 문자열' 을 암시적으로 할당합니다.

```swift
enum GamePlayMode: String {
  case cooperative, individual, competitive
}
```

위 예제에서, `GamePlayMode.cooperative` 의 원시 값은 `"cooperative"`, `GamePlayMode.individual` 의 원시 값은 `"individual"`, 그리고 `GamePlayMode.competitive` 의 원시 값은 `"competitive"` 입니다.

'원시-값 타입의 case 값' 을 가진 열거체는 암시적으로, 스위프트 표준 라이브러리에서 정의한, `RawRepresentable` 프로토콜을 준수합니다. 그 결과, '`rawValue` 속성' 과 '서명 (signature)'[^signature] 이 `init?(rawValue: RawValue)` 인 '실패 가능한 초기자 (failable initializer)' 를 가집니다. `rawValue` 속성을 사용하면, `ExampleEnum.b.rawValue` 처럼, '열거체 case 의 원시 값' 에 접근할 수 있습니다. '원시 값' 은 '관련 case 값', 이 하나 있는 경우, `ExampleEnum(rawValue: 5)` 처럼, '옵셔널 case 값' 을 반환하는, 열거체의 '실패 가능한 초기자' 를 호출함으로써, 이를 찾을 수 있습니다. '원시-값 타입을 가진 case 값' 에 대한 더 많은 정보와 예제를 보려면, [Raw Values (원시 값)]({% post_url 2020-06-13-Enumerations %}#raw-values-원시-값) 부분을 참고하기 바랍니다.

#### Accessing Enumeration Cases (열거체의 'case 값' 에 접근하기)

'열거체 타입의 case 값' 을 참조하려면, `EnumerationType.enumerationCase` 과 같은, '점 (`.`) 구문' 을 사용합니다. 열거체 타입을 추론할 수 있는 상황일 땐, [Enumeration Syntax (열거체 구문)]({% post_url 2020-06-13-Enumerations %}#enumeration-syntax-열거체-구문) 과 [Implicit Member Expression (암시적인 멤버 표현식)]({% post_url 2020-08-19-Expressions %}#implicit-member-expression-암시적인-멤버-표현식) 에서 설명한 것처럼, 생략할 수 있습니다. ('점' 은 여전히 필수입니다)

'열거체 case 의 값' 을 검사하려면, [Matching Enumeration Values with a Switch Statement ('열거체 값' 과 'switch 문' 맞춰보기)]({% post_url 2020-06-13-Enumerations %}#matching-enumeration-values-with-a-switch-statement-열거체-값-과-switch-문-맞춰보기) 에 보인 것처럼, `switch` 문을 사용합니다. 열거체 타입은, [Enumeration Case Pattern (열거체 case 유형)]({% post_url 2020-08-25-Patterns %}#enumeration-case-pattern-열거체-case-유형) 에서 설명한 것처럼, '`switch` 문의 case 블럭' 에 있는 '열거체 case 유형' 과 유형을-맞춰봅니다.

> GRAMMAR OF AN ENUMERATION DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID364)

### Structure Declaration (구조체 선언)

_구조체 선언 (structure declaration)_ 은 '이름 붙인 구조체 타입' 을 프로그램에 도입합니다. '구조체 선언' 은 `struct` 키워드로 선언하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;struct `structure name-구조체 이름`: `adopted protocols-채택한 프로토콜` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`declarations-선언`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

구조체의 본문은 0개 이상의 _선언 (declarations)_ 들을 담습니다. 이 _선언 (declarations)_ 들은 저장과 계산 속성 모두, 타입 속성, 인스턴스 메소드, 타입 메소드, 초기자, 첨자 연산, 타입 별명, 그리고 심지어 다른 구조체, 클래스, 행위자, 및 열거체 선언을 포함할 수 있습니다. 구조체 선언은 '정리자 (deinitializer)' 나 '프로토콜 선언' 을 담을 수 없습니다. 다양한 종류의 선언을 포함하고 있는 구조체에 대한 논의와 여러 예제들은, [Structures and Classes (구조체와 클래스)]({% post_url 2020-04-14-Structures-and-Classes %}) 장을 참고하기 바랍니다.

구조체 타입은 어떤 개수의 프로토콜이든 채택할 수 있지만, 클래스, 열거체, 또는 다른 구조체를 상속할 순 없습니다.

이전에 선언한 구조체의 인스턴스를 생성하는 데는 세 가지 방법이 있습니다:

* [Initializers (초기자)]({% post_url 2016-01-23-Initialization %}#initializers-초기자) 에서 설명한 것처럼, 구조체 안에 선언한 초기자 중 하나를 호출합니다.
* 선언한 초기자가 없으면, [Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)]({% post_url 2016-01-23-Initialization %}#memberwise-initializers-for-structure-types-구조체-타입을-위한-멤버-초기자) 에서 설명한 것처럼, 구조체의 '멤버 초기자' 를 호출합니다.
* 선언한 초기자는 없지만, 구조체 선언의 모든 속성에 초기 값을 줬으면, [Default Initializers (기본 초기자)]({% post_url 2016-01-23-Initialization %}#default-initializers-기본-초기자) 에서 설명한 것처럼, 구조체의 '기본 초기자' 를 호출합니다.

구조체에서 선언한 속성을 초기화하는 과정은 [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 장에서 설명합니다.

구조체 인스턴스의 속성은, [Accessing Properties (속성에 접근하기)]({% post_url 2020-04-14-Structures-and-Classes %}#accessing-properties-속성에-접근하기) 에서 설명한 것처럼, '점 (`.`) 구문' 으로 접근할 수 있습니다.

구조체는 '값 타입' 이며; 구조체 인스턴스는 변수나 상수에 할당할 때나, 함수 호출의 인자로 전달할 때, 복사됩니다. 값 타입에 대한 정보는, [Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#structures-and-enumerations-are-value-types-구조체와-열거체는-값-타입입니다) 부분을 참고하기 바랍니다.

[Extension Declaration (익스텐션 선언)](#extension-declaration-익스텐션-선언) 에서 논의한 것처럼, '익스텐션 (extension) 선언' 으로 구조체 타입의 동작을 확장할 수 있습니다.

> GRAMMAR OF A STRUCTURE DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID367)

### Class Declaration (클래스 선언)

_클래스 선언 (class declaration)_ 은 '이름 붙인 클래스 타입' 을 프로그램에 도입합니다. '클래스 선언' 은 `class` 키워드로 선언하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;class `class name-클래스 이름`: `superclass-상위 클래스`, `adopted protocols-채택한 프로토콜` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`declarations-선언`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

클래스의 본문은 0개 이상의 _선언 (declaration)_ 들을 담습니다. 이 _선언 (declarations)_ 들은 저장과 계산 속성 모두, 인스턴스 메소드, 타입 메소드, 초기자, 단일 '정리자 (deinitializer)', 첨자 연산, 타입 별명, 그리고 심지어 다른 구조체, 클래스, 행위자, 및 열거체 선언을 포함할 수 있습니다. 클래스 선언은 '프로토콜 선언' 을 담을 순 없습니다. 다양한 종류의 선언을 포함하고 있는 클래스에 대한 논의와 여러 예제들은, [Structures and Classes (구조체와 클래스)]({% post_url 2020-04-14-Structures-and-Classes %}) 장을 참고하기 바랍니다.

클래스 타입은, _상위 클래스 (superclass)_ 라는, 단 하나의 부모 클래스만을 상속할 수 있지만, 프로토콜은 어떤 개수든 채택할 수 있습니다. _클래스 이름 (class anme)_ 과 콜론 뒤에 _상위 클래스 (superclass)_ 를 최초로 나타내고, _채택한 프로토콜 (adopted protocols)_ 을 뒤에 둡니다. '일반화 (generic) 클래스' 는 다른 '일반화 및 일반화 아닌 클래스' 를 상속할 수 있지만, '일반화 아닌 (nongeneric) 클래스' 는 다른 '일반화 아닌 클래스' 만 상속할 수 있습니다. '일반화 상위 클래스' 클래스의 이름을 콜론 뒤에 작성할 때는, 반드시 '해당 일반화 클래스' 의, '일반화 매개 변수 절' 을 포함한, 전체 이름을 포함시켜야 합니다.

[Initializer Declaration (초기자 선언)](#initializer-declaration-초기자-선언) 에서 논의한 것처럼, 클래스는 '지명 (designated) 초기자' 와 '편의 (convenience) 초기자' 를 가질 수 있습니다. 클래스의 '지명 초기자' 는 클래스가 선언한 모든 속성을 반드시 초기화해야 하므로 이를 반드시 상위 클래스의 '지명 초기자' 를 호출하기 전에 해야 합니다.

클래스는 상위 클래스의 속성, 메소드, 첨자 연산, 및 초기자를 '재정의 (override)' 할 수 있습니다. 재정의한 속성, 메소드, 첨자 연산, 및 지명 초기자[^designated-initializers] 는 반드시 '`override` 선언 수정자' 로 표시해야 합니다.

하위 클래스가 상위 클래스의 초기자를 필수로 구현하도록 요구하려면, 상위 클래스의 초기자를 '`required` 선언 수정자' 로 표시합니다. '해당 초기자의 하위 클래스 구현' 도 반드시 `required` 선언 수정자로 표시해야 합니다.

_상위 클래스 (superclass)_ 에서 선언한 속성과 메소드를 현재 클래스에서 상속하긴 하지만, _상위 클래스 (superclass)_ 에서 선언한 '지명 초기자' 는 하위 클래스가 [Automatic Initializer Inheritance (자동적인 초기자 상속)]({% post_url 2016-01-23-Initialization %}#automatic-initializer-inheritance-자동적인-초기자-상속) 에서 설명한 조건과 부합할 때만 상속합니다. 스위프트 클래스는 '범용 기초 클래스 (universal base class)'[^universal-base-class] 를 상속하지 않습니다.

이전에 선언한 클래스의 인스턴스를 생성하는 데는 두 가지 방법이 있습니다:

* [Initializers (초기자)]({% post_url 2016-01-23-Initialization %}#initializers-초기자) 에서 설명한 것처럼, 클래스 안에 선언한 초기자 중 하나를 호출합니다.
* 선언한 초기자는 없지만, 클래스 선언의 모든 속성에 초기 값을 줬으면, [Default Initializers (기본 초기자)]({% post_url 2016-01-23-Initialization %}#default-initializers-기본-초기자) 에서 설명한 것처럼, 클래스의 '기본 초기자' 를 호출합니다.

클래스 인스턴스의 속성은, [Accessing Properties (속성에 접근하기)]({% post_url 2020-04-14-Structures-and-Classes %}#accessing-properties-속성에-접근하기) 에서 설명한 것처럼, '점 (`.`) 구문' 으로 접근합니다.

클래스는 '참조 타입' 이며; 클래스 인스턴스는, 변수나 상수에 할당할 때나, 함수 호출의 인자로 전달할 때, 복사 보다는, '참조' 됩니다. '참조 타입' 에 대한 정보는, [Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#structures-and-enumerations-are-value-types-구조체와-열거체는-값-타입입니다)[^reference-type] 부분을 참고하기 바랍니다.

[Extension Declaration (익스텐션 선언)](#extension-declaration-익스텐션-선언) 에서 논의한 것처럼, '익스텐션 (extension) 선언' 으로 클래스 타입의 동작을 확장할 수 있습니다.

> GRAMMAR OF A CLASS DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID368)

### Actor Declaration (행위자 선언)

_행위자 선언 (actor declaration)_ 은 '이름 붙인 행위자 타입' 을 프로그램에 도입합니다. '행위자 선언' 은 `actor` 키워드로 선언하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;actor `actor name-행위자 이름`: `adopted protocols-채택한 프로토콜` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`declarations-선언`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

'행위자' 의 본문은 0개 이상의 _선언 (declarations)_ 들을 담습니다. 이 _선언 (declarations)_ 들은 저장과 계산 속성 모두, 인스턴스 메소드, 타입 메소드, 초기자, 단일 '정리자', 첨자 연산, 타입 별명, 그리고 심지어 다른 클래스, 구조체, 및 열거체 선언을 포함할 수 있습니다. 다양한 종류의 선언을 포함하고 있는 '행위자' 에 대한 논의와 여러 예제들은, [Actors (행위자)]({% post_url 2021-06-10-Concurrency %}#actors-행위자) 부분을 참고하기 바랍니다. 

'행위자 타입' 은 어떤 개수의 프로토콜도 채택할 수 있지만, 클래스, 열거체, 구조체나, 다른 '행위자' 를 상속할 순 없습니다. 하지만, '`@objc` 특성' 으로 표시한 '행위자' 는 암시적으로 `NSObjectProtocol` 프로토콜을 준수하며 '오브젝티브-C 런타임' 에서 `NSObject` 의 하위 타입으로 노출됩니다.

이전에 선언한 '행위자' 의 인스턴스를 생성하는 데는 두 가지 방법이 있습니다:

* [Initializers (초기자)]({% post_url 2016-01-23-Initialization %}#initializers-초기자) 에서 설명한 것처럼, '행위자' 안에 선언한 초기자 중 하나를 호출합니다.
* 선언한 초기자는 없지만, 행위자 선언의 모든 속성에 초기 값을 줬으면, [Default Initializers (기본 초기자)]({% post_url 2016-01-23-Initialization %}#default-initializers-기본-초기자) 에서 설명한 것처럼, 행위자의 '기본 초기자' 를 호출합니다.

기본적으로, 행위자의 멤버는 해당 행위자로 격리됩니다.[^isolate] 메소드의 본문이나 속성의 획득자 같은, 코드는 해당 행위자 상에서 실행합니다. 행위자 안의 코드는 해당 코드가 이미 동일한 행위자 상에서 실행 중이기 때문에 이와 '동기로 (synchronously)' 상호 작용할 수 있지만, 행위자 밖의 코드는 '이 코드가 또 다른 행위자 상에서 비동기로 실행 중인 코드' 임을 지시하기 위해 반드시 `await` 로 표시해야 합니다. '키 경로 (key paths)' 는 '행위자의 격리 멤버' 를 참조할 수 없습니다. '행위자로-격리한 (actor-isolated) 저장 속성' 은 '동기 함수' 의 '입-출력 매개 변수' 로 전달할 순 있지만, '비동기 함수' 로는 안됩니다. 

행위자는 '격리 안된 멤버' 도 가질 수 있는데, 이 선언은 `nonisolated` 키워드로 표시합니다. '격리 안된 멤버' 는 행위자 밖의 코드 처럼 실행하는데: 행위자의 어떤 '격리 상태' 와도 상호 작용할 수 없고, 호출하는 쪽에서 사용할 때 `await` 를 표시하지 않습니다.

행위자 멤버는 '격리 안된 (nonisolated)' 것이나 '비동기 (asynchronous)' 인 경우에만 `@objc` 특성으로 표시할 수 있습니다. 

행위자가 선언한 속성의 초기화 과정은 [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 에서 설명합니다.

행위자 인스턴스의 속성은, [Accessing Properties (속성에 접근하기)]({% post_url 2020-04-14-Structures-and-Classes %}#accessing-properties-속성에-접근하기) 에서 설명한 것처럼, '점 (`.`) 구문' 으로 접근할 수 있습니다.

행위자는 참조 타입이며; 행위자 인스턴스는, 변수나 상수에 할당할 때나, 함수 호출의 인자로 전달할 때, 복사 보다는, '참조' 됩니다. '참조 타입' 에 대한 정보는, [Classes Are Reference Types (클래스는 참조 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#classes-are-reference-types-클래스는-참조-타입입니다) 부분을 참고하기 바랍니다.

[Extension Declaration (익스텐션 선언)](#extension-declaration-익스텐션-선언) 에서 논의한 것처럼, '익스텐션 (extension) 선언' 으로 행위자 타입의 동작을 확장할 수 있습니다.

> GRAMMAR OF A ACTOR DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID648)

### Protocol Declaration (프로토콜 선언)

_프로토콜 선언 (protocol declaration)_ 은 '이름 붙인 프로토콜 타입' 을 프로그램에 도입합니다. '프로토콜 선언' 은 '전역 (global scope)' 에서 `protocol` 키워드로 선언하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;protocol `protocol name-프로토콜 이름`: `inherited protocols-상속한 프로토콜` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`protocol member declarations-프로토콜 멤버 선언`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

프로토콜의 본문은, 프로토콜을 채택한 어떤 타입이든 반드시 충족해야 할 '준수성 필수 조건 (conformance requirements)' 을 설명하는, 0개 이상의 _프로토콜 멤버 선언 (protocol member declarations)_ 들을 담습니다. 특히, 프로토콜은 '준수 타입 (conforming types)' 이 반드시 정해진 속성, 메소드, 초기자, 및 첨자 연산을 구현해야 함을 선언할 수 있습니다. 프로토콜은, 다양한 프로토콜 선언들 사이의 관계를 지정할 수 있는, _결합 타입 (associated types)_ 이라는, 특수한 종류의 '타입 별명 (type aliases)' 도 선언할 수 있습니다. 프로토콜 선언은 클래스, 구조체, 열거체, 또는 다른 프로토콜 선언을 담을 순 없습니다. _프로토콜 멤버 선언 (protocol member declarations)_ 은 아래에서 자세히 논의합니다.

프로토콜 타입은 어떤 개수의 다른 프로토콜이든 상속할 수 있습니다. 프로토콜 타입이 다른 프로토콜을 상속할 때는, 다른 프로토콜에 있는 '필수 조건 집합' 을 '한데 모으며 (aggregated)', 현재 프로토콜을 상속한 어떤 타입이든 반드시 이 모든 필수 조건들을 준수해야 합니다. '프로토콜 상속' 의 사용 방법에 대한 예제는, [Protocol Inheritance (프로토콜 상속)]({% post_url 2016-03-03-Protocols %}#protocol-inheritance-프로토콜-상속) 부분을 참고하기 바랍니다.

> [Protocol Composition Type (프로토콜 합성 타입)]({% post_url 2020-02-20-Types %}#protocol-composition-type-프로토콜-합성-타입) 과 [Protocol Composition (프로토콜 합성)]({% post_url 2016-03-03-Protocols %}#protocol-composition-프로토콜-합성) 에서 설명한 것처럼, '프로토콜 합성 타입' 으로 '여러 프로토콜의 준수성 필수 조건' 들을 한데 모을 수도 있습니다.

해당 타입의 '익스텐션 (extension) 선언' 에서 프로토콜을 채택함으로써 이전에 선언한 타입에 '프로토콜 준수성' 을 추가할 수 있습니다. '익스텐션' 에서는, 채택한 프로토콜의 필수 조건들을 반드시 모두 구현해야 합니다. 타입이 이미 모든 필수 조건을 구현하고 있으면, '익스텐션 선언' 의 본문은 비워둘 수도 있습니다.

기본적으로, 프로토콜을 준수하는 타입은 반드시 프로토콜에서 선언한 모든 속성, 메소드, 및 첨자 연산을 구현해야 합니다. 그렇다 하더라도, 이 프로토콜 멤버 선언들을 '`optional` 선언 수정자' 로 표시하여 '준수 타입의 구현부' 가 '옵셔널 (optional)' 임을 지정할 수 있습니다.[^optional-member] '`optional` 수정자' 는 '`objc` 특성' 으로 표시한 멤버와, '`objc` 특성' 으로 표시한 프로토콜의 멤버에만 적용할 수 있습니다. 그 결과, 클래스 타입만이 '옵셔널 멤버 필수 조건' 을 가진 프로토콜을 채택하고 준수할 수 있습니다. `optional` 선언 수정자의 사용 방법에 대한 더 많은 정보와 옵셔널 프로토콜 멤버로의 접근 방법-예를 들어, '준수 타입' 의 구현 여부를 확신할 수 없을 때-에 대한 지침은, [Optional Protocol Requirements (옵셔널 프로토콜 필수 조건)]({% post_url 2016-03-03-Protocols %}#optional-protocol-requirements-옵셔널-프로토콜-필수-조건) 부분을 참고하기 바랍니다.

'열거체의 case 값' 은 '타입 멤버' 에 대한 프로토콜 필수 조건을 만족할 수 있습니다. 특히, '어떤 결합 값도 없는 열거체 case 값' 은 '`Self` 타입의 읽기-전용 타입 변수' 에 대한 프로토콜 필수 조건을 만족하며,[^enumeration-get-only] '결합 값을 가진 열거체 case 값' 은 '매개 변수와 인자 이름표가 case 의 결합 값과 일치하는 `Self` 를 반환하는 함수' 에 대한 프로토콜 필수 조건을 만족합니다.[^enumeration-function] 예를 들면 다음과 같습니다:

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

'프로토콜 채택 (adoption)' 을 클래스 타입만으로 제약하려면, 콜론 뒤의 '_상속한 프로토콜 (inherited protocols)_ 목록' 에 `AnyObject` 프로토콜을 포함합니다. 예를 들어, 다음 프로토콜은 클래스 타입만 채택할 수 있습니다:

```swift
protocol SomeProtocol: AnyObject {
  /* 프로토콜 멤버는 여기에 둡니다 */
}
```

'`AnyObject` 필수 조건으로 표시한 프로토콜' 을 상속한 어떤 프로토콜이든 마찬가지로 클래스 타입만 채택할 수 있습니다.

> 프로토콜을 `objc` 특성으로 표시하면, 해당 프로토콜에 '`AnyObject` 필수 조건' 을 암시적으로 적용하므로; 프로토콜을 `AnyObject` 필수 조건으로 명시적으로 표시할 필요가 없습니다.

프로토콜은 '이름 붙인 타입 (named types)' 이며, 따라서 [Protocols as Types (타입으로써의 프로토콜)]({% post_url 2016-03-03-Protocols %}#protocols-as-types-타입으로써의-프로토콜) 에서 논의한 것처럼, 다른 '이름 붙인 타입' 이 있을 수 있는 것과 똑같은 모든 코드 위치에 있을 수 있습니다. 하지만, 프로토콜이 지정한 필수 조건에 대한 구현을 실제로 제공하는 것은 아니기 때문에, 프로토콜의 인스턴스를 '생성 (construct)' 할 수는 없습니다.

프로토콜은, [Delegation (위임)]({% post_url 2016-03-03-Protocols %}#delegation-위임) 에서 설명한 것처럼, 클래스나 구조체의 '대리자 (delegate)' 가 구현해야 할 메소드를 선언하기 위해 사용할 수 있습니다.

> GRAMMAR OF A PROTOCOL DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

#### Protocol Property Declaration (프로토콜 속성 선언)

프로토콜은 프로토콜 선언 본문에 _프로토콜 속성 선언 (protocol property declaration)_ 을 포함함으로써 '준수 타입' 이 속성을 반드시 구현해야 한다고 선언합니다. '프로토콜 속성 선언' 은 특수한 형식의 변수 선언입니다:

var `property name-속성 이름`: `type-타입` { get set }

다른 프로토콜 멤버 선언이 그런 것처럼, 이 속성 선언은 프로토콜이 준수하는 타입에 대한 '획득자와 설정자 필수 조건 (requirements)' 만 선언합니다. 그 결과, 자신을 선언한 프로토콜에서 획득자와 설정자를 직접 구현하진 않습니다.

'준수 타입' 은 다양한 방식으로 '획득자와 설정자 필수 조건' 을 만족시킬 수 있습니다. 속성 선언이 `get` 과 `set` 키워드 둘 다를 포함하면, '준수 타입' 은 읽기 쓰기 둘 다 가능한 (즉, 획득자와 설정자 둘 다를 구현한) '저장 변수 속성' 이나 '계산 속성' 으로 구현할 수 있습니다. 하지만, 해당 속성 선언을 '상수 속성' 이나 '읽기-전용 계산 속성' 으로 구현할 순 없습니다. 속성 선언이 `get` 키워드만 포함하면, 어떤 종류의 속성으로도 구현할 수 있습니다. 프로토콜의 속성 필수 조건을 구현하는 '준수 타입' 에 대한 예제는, [Property Requirements (속성 필수 조건)]({% post_url 2016-03-03-Protocols %}#property-requirements-속성-필수-조건) 부분을 참고하기 바랍니다.

프로토콜 선언에서 '타입 속성 필수 조건' 을 선언하려면, 이 속성 선언을 `static` 키워드로 표시합니다. 이 프로토콜을 준수하는 것이 구조체와 열거체라면 속성을 `static` 키워드로 선언하고, 이 프로토콜을 준수하는 것이 클래스라면 속성을 `static` 이나 `class` 키워드 중 하나로 선언합니다. '익스텐션 (extension)' 으로 구조체, 열거체, 또는 클래스에 '프로토콜 준수성 (protocol conformance)' 을 추가하는 경우 확장하는데 사용하는 타입과 같은 키워드를 사용합니다. '타입 속성 필수 조건' 에 대한 '기본 구현' 을 제공하는 '익스텐션' 은 `static` 키워드를 사용합니다.

[Variable Declaration (변수 선언)](#variable-declaration-변수-선언) 부분도 참고하기 바랍니다.

> GRAMMAR OF A PROTOCOL PROPERTY DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

#### Protocol Method Declaration (프로토콜 메소드 선언)

프로토콜을 준수하는 타입이 어떤 메소드를 반드시 구현하도록 선언하려면 프로토콜 선언의 본문에서 '프로토콜 메소드 선언' 을 포함하면 됩니다. 프로토콜 메소드 선언은 함수 선언과 형식이 똑같지만, 두 가지 예외가 있습니다: 일단 함수 본문을 포함하지 않으며, 함수 선언에서 어떤 '기본 매개 변수 값' 도 제공할 수 없습니다.  프로토콜의 '메소드 필수 조건 (method requirements)' 을 구현하는 준수 타입에 대한 예제는, [Method Requirements (메소드 필수 조건)]({% post_url 2016-03-03-Protocols %}#method-requirements-메소드-필수-조건) 을 참고하기 바랍니다.

프로토콜 선언에서 '클래스 메소드 (class method)' 나 '정적 메소드 (static method)' 필수 조건을 선언하려면, 해당 메소드 선언을 `static` 선언 수정자로 표시합니다. 이 프로토콜을 준수하는 것이 구조체와 열거체라면 메소드를 선언하면서 `static` 키워드를 사용하고, 이 프로토콜을 준수하는 것이 클래스라면 메소드를 선언하면서 `static` 이나 `class` 키워드 중 하나를 사용합니다. '익스텐션 (extension)' 으로 구조체, 열거체, 또는 클래스에 '프로토콜 준수성 (protocol conformance)' 을 추가하는 경우 확장하는데 사용하는 타입과 같은 키워드를 사용합니다. '타입 메소드 필수 조건' 에 대한 '기본 구현' 을 제공하는 '익스텐션' 은 `static` 키워드를 사용합니다.

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

프로토콜 선언에서 '정적 첨자 연산 (static subscript)' 필수 조건을 선언하려면, 해당 첨자 연산 선언을 `static` 선언 수정자로 표시합니다. 이 프로토콜을 준수하는 것이 구조체와 열거체라면 첨자 연산을 선언하면서 `static` 키워드를 사용하고, 프로토콜을 준수하는 것이 클래스라면 첨자 연산을 선언하면서 `static` 이나 `class` 키워드 중 하나를 사용합니다. '익스텐션 (extension)' 으로 구조체, 열거체, 또는 클래스에 '프로토콜 준수성 (protocol conformance)' 을 추가하는 경우 확장하는데 사용하는 타입과 같은 키워드를 사용합니다. '타입 첨자 연산 필수 조건' 에 대한 '기본 구현' 을 제공하는 '익스텐션' 은 `static` 키워드를 사용합니다.

[Subscipt Declaration (첨자 연산 선언)](#subscipt-declaration-첨자-연산-선언) 부분도 참고하기 바랍니다.

> GRAMMAR OF A PROTOCOL INITIALIZER DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

#### Protocol Associated Type Declaration (프로토콜의 결합 타입 선언)

프로토콜은 `associatedtype` 키워드를 사용하여 '결합된 타입 (associated types)' 을 선언합니다. '결합된 타입' 은 프로토콜의 선언에서 사용되는 타입을 위한 '별명 (alias)' 을 제공합니다. '결합된 타입' 은 '일반화된 (generic) 매개 변수 절' 의 '타입 매개 변수' 와 비슷하지만, 이를 선언하는 프로토콜의 `Self` 와 '결합되어 (associated)' 있습니다. 해당 상황에서, `Self` 는 프로토콜을 '최종적으로 (eventual) 준수하고 있는 타입' 을 참조합니다. 더 많은 정보와 예제는, [Associated Types (결합 타입)]({% post_url 2020-02-29-Generics %}#associated-types-결합-타입) 을 참고하기 바랍니다.

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

편의 초기자는 초기화 과정을 또 다른 편의 초기자 또는 클래스의 지명 초기자 중 하나로 위임할 수 있습니다. 그렇다 하더라도, 초기화 과정은 궁극적으로 클래스의 속성을 초기화하는 지명 초기자를 호출하는 것으로 반드시 끝나야 합니다. 편의 초기자는 상위 클래스의 초기자를 호출할 수 없습니다.

지명 초기자와 편의 초기자를 `required` 선언 수정자로 표시하면 모든 하위 클래스가 이 초기자를 필수로 구현하도록 만들 수 있습니다. 해당 초기자의 하위 클래스 구현 역시 반드시 `required` 선언 수정자로 표시돼야 합니다.

기본적으로, 상위 클래스에서 선언된 초기자는 하위 클래스로 상속되지 않습니다. 그렇다 하더라도, 만약 하위 클래스가 모든 저장 속성을 기본 값으로 초기화하면서 자체로는 어떤 초기자도 정의하지 않는 경우, 상위 클래스의 모든 초기자를 상속합니다. 만약 하위 클래스가 상위 클래스의 모든 지명 초기자를 재정의하는 경우, 상위 클래스의 편의 초기자를 상속합니다.

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

정리자는 더 이상 클래스 객체에 대한 어떤 참조도 존재하지 않을 때, 클래스 객체가 할당 해제되기 바로 직전에, 자동으로 호출됩니다. 정리자는 클래스 선언의 본문-그러나 클래스의 '익스텐션 (extension)' 은 아닌 곳-에서만 선언할 수 있으며 각 클래스마다 최대 하나만 가질 수 있습니다.

하위 클래스는 상위 클래스의 정리자를 상속받는데, 이는 하위 클래스 객체가 할당 해제되기 바로 직전에 암시적으로 호출됩니다. 하위 클래스 객체는 '상속 연쇄망 (inheritance chain)' 에 있는 모든 정리자가 실행을 마치기 전까지 할당이 해제되지 않습니다.

정리자는 직접 호출하는 것이 아닙니다.

클래스 선언에서 정리자를 사용하는 방법에 대한 예제는, [Deinitialization (객체 정리)]({% post_url 2017-03-03-Deinitialization %}) 를 참고하기 바랍니다.

> GRAMMAR OF A DEINITIALIZER DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID377)

### Extension Declaration (익스텐션 선언)

_익스텐션 (확장) 선언 (extension declaration)_ 은 기존 타입의 작동 방식을 확장하도록 합니다. '익스텐션 선언' 은 `extension` 키워드를 사용하여 선언하며 형식은 다음과 같습니다:

extension `type name-타입 이름` where `requirements-필수 조건` {<br />
  `declarations-선언`<br />
}

익스텐션 선언의 본문은 '0' 개 이상의 _선언 (declarations)_ 을 가집니다. 이 _선언 (declarations)_ 들은 계산 속성, 계산 타입 속성, 인스턴스 메소드, 타입 메소드, 초기자, 첨자 연산 선언, 그리고 심지어 클래스, 구조체, 및 열거체 선언을 포함할 수 있습니다. '익스텐션 (extension) 선언' 은 정리자 또는 프로토콜 선언, 저장 속성, 속성 관찰자, 및 다른 '익스텐션 선언' 을 가질 수 없습니다. '프로토콜 익스텐션' 에 있는 선언들은 `final` 이라고 표시할 수 없습니다. 다양한 종류의 선언을 포함하고 있는 '익스텐션' 에 대한 논의 및 예제에 대해서는, [Extensions (익스텐션; 확장)]({% post_url 2016-01-19-Extensions %}) 을 참고하기 바랍니다.

_타입 이름 (type name)_ 이 클래스, 구조체, 또는 열거체 타입인 경우, '익스텐션' 은 해당 타입을 확장합니다. _타입 이름 (type name)_ 이 프로토콜 타입인 경우, '익스텐션' 은 해당 프로토콜을 준수하는 모든 타입을 확장합니다.

결합된 타입을 가지는 '일반화 타입' 또는 프로토콜을 확장하는 '익스텐션 선언' 은 _필수 조건 (requirements)_ 을 포함할 수 있습니다. 확장된 타입의 인스턴스 또는 확장된 프로토콜을 준수하는 타입의 인스턴스가 _필수 조건 (requirements)_ 을 만족하는 경우, 이 인스턴스는 선언에서 지정한 '작동 방식 (behavior)' 을 가지게 됩니다.

'익스텐션 선언' 은 초기자 선언을 가질 수 있습니다. 그렇다 하더라도, 확장하려는 타입이 다른 모듈에서 정의된 경우, 초기자 선언은 해당 타입의 멤버가 알맞게 초기화되는 것을 보장하도록 해당 모듈에서 이미 정의한 초기자로 위임을 반드시 해야 합니다.

기존 타입의 속성, 메소드, 그리고 초기자는 해당 타입의 '익스텐션' 에서 재정의할 수 없습니다.

'익스텐션 선언' 은 _채택한 프로토콜 (adopted protocols)_ 들을 지정하여 기존 클래스, 구조체, 또는 열거체에 '프로토콜 준수성 (protocol conformance)' 을 추가할 수 있습니다:

extension `type name-타입 이름`: `adopted protocols-채택한 프로토콜` where `requirements-필수 조건` {<br />
  `declarations-선언`<br />
}

'익스텐션 선언' 은 기존 클래스에 '클래스 상속' 을 추가할 수는 없으며, 따라서 _타입 이름 (type name)_ 과 콜론 뒤에 프로토콜 목록만을 지정할 수 있습니다.

#### Conditional Conformance (조건부 준수성)

일반화된 타입을 확장하면서 조건부로 프로토콜을 준수하도록 할 수 있는데, 이는 타입의 인스턴스가 정해진 필수 조건을 만날 때만 프로토콜을 준수하게 됩니다. '조건부 준수성 (conditional conformance)' 을 프로토콜에 추가하려면 '익스텐션 선언' 에 _필수 조건 (requirements)_ 을 추가하면 됩니다.

**Overridden Requirements Aren't Used in Some Generic Contexts (재정의된 필수 조건은 일부의 일반화 (generic) 상황에서 사용되지 않습니다)**

일부의 일반화 (generic) 상황에서, 프로토콜에 대한 '조건부 준수성' 에서 '작동 방식 (behavior)' 을 획득하는 타입이 해당 프로토콜의 필수 조건에 대한 '특수화된 구현 (specialized implementations)' 을 항상 사용하지는 않습니다. 이 작동 방식을 명확히 설명하기 위해, 다음 예제에서 두 개의 프로토콜과 이 두 프로토콜을 조건부로 준수하는 '일반화된 (generic) 타입' 을 정의합니다.

```swift
protocol Loggable {
  func log()
}
extension Loggable {
  func log() {
    print(self)
  }
}

protocol TitledLoggable: Loggable {
  static var logTitle: String { get }
}
extension TitledLoggable {
  func log() {
    print("\(Self.logTitle): \(self)")
  }
}

struct Pair<T>: CustomStringConvertible {
  let first: T
  let second: T
  var description: String {
    return "(\(first), \(second))"
  }
}

extension Pair: Loggable where T: Loggable { }
extension Pair: TitledLoggable where T: TitledLoggable {
  static var logTitle: String {
    return "Pair of '\(T.logTitle)'"
  }
}

extension String: TitledLoggable {
  static var logTitle: String {
    return "String"
  }
}
```

`Pair` 구조체는 그 일반화된 (generic) 타입이, 각각 `Loggable` 또는 `TitledLoggable` 을 준수할 때마다, `Loggable` 과 `TitledLoggable` 을 준수합니다. 아래 예제에서, `oneAndTwo` 는 `Pair<String>` 의 인스턴스로, `TitledLoggable` 을 준수하는데 이는 `String` 이 `TitleLoggable` 을 준수하기 때문입니다. `oneAndTwo` 에 대한 `log()` 메소드를 직접 호출할 때는, 제목 문자열을 가지고 있는 '특수화된 버전 (specialized version)' 이 사용됩니다.

```swift
let oneAndTwo = Pair(first: "one", second: "two")
oneAndTwo.log()
// "Pair of 'String': (one, two)" 를 출력합니다.
```

하지만, `oneAndTwo` 가 '일반화 상황 (generic context)' 에서 사용되거나 `Loggable` 프로토콜의 인스턴스로써 사용될 때는, '특수화된 버전' 이 사용되지 않습니다. 스위프트는 `Pair` 가 `Loggable` 을 준수하는 데 필요한 최소 필수 조건만을 참고하여 어떤 `log()` 구현을 호출할 지를 뽑습니다. 이러한 이유로, `Loggable` 프로토콜이 제공하는 기본 구현을 대신 사용합니다.

```swift
func doSomething<T: Loggable>(with x: T) {
  x.log()
}
doSomething(with: oneAndTwo)
// "(one, two)" 를 출력합니다.
```

`doSomething(_:)` 에 전달된 인스턴스에 대한 `log()` 를 호출할 때는, '기록된 문자열 (logged string)' 에서 '사용자 정의 제목 (customized title)' 을 생략합니다.

#### Protocol Conformance Must Not Be Redundant (프로토콜 준수는 반드시 과잉되지 않아야 합니다)

'구체적으로 고정된 타입 (concrete type)' 은 특정 프로토콜을 단 한 번만 준수할 수 있습니다. 스위프트는 과잉인 프로토콜 준수를 에러라고 표시합니다. 이런 종류의 에러는 두 가지 상황에서 마주치게 됩니다. 첫 번째 상황은 똑같은 프로토콜을 명시적으로 여러 번 준수하면서, 필수 조건은 다르게 할 때 입니다. 두 번째 상황은 똑같은 프로토콜을 암시적으로 여러 번 상속받을 때 입니다. 이 상황들은 아래 부분에서 논의합니다.

**Resolving Explicit Redundancy (명시적인 과잉 문제 해결하기)**

구체적으로 고정된 타입에 대한 '다중 확장 (extension)' 은, 그 '확장 (extension)' 의 필수 조건이 서로 배타적이더라도, 똑같은 프로토콜에 대한 준수성을 추가할 수 없습니다. 이런 제약 조건은 아래 예제에서 증명해 보입니다. 두 '확장 (extension) 선언' 은 `Serializable` 프로토콜에 조건부 준수성을 추가하려고 시도하는데, 하나는 `Int` 원소를 가지는 배열에 대한 것이고, 다른 하나는 `String` 원소를 가지는 배열에 대한 것입니다.

```swift
protocol Serializable {
  func serialize() -> Any
}

extension Array: Serializable where Element == Int {
  func serialize() -> Any {
    // 구현
  }
}
extension Array: Serializable where Element == String {
  func serialize() -> Any {
    // 구현
  }
}
// 에러: 'Array<Element>' 가 'Serializable' 프로토콜을 과잉 준수함
```

여러 개의 고정 타입을 기초로 하여 '조건부 준수성' 을 추가할 필요가 있는 경우, 각각의 타입이 준수할 수 있는 새로운 프로토콜을 생성하고 '조건부 준수성' 을 선언할 때 해당 프로토콜을 '필수 조건' 처럼 사용하면 됩니다.

```swift
protocol SerializableInArray { }
extension Int: SerializableInArray { }
extension String: SerializableInArray { }

extension Array: Serializable where Element: SerializableInArray {
  func serialize() -> Any {
    // 구현
  }
}
```

**Resolving Implicit Redundancy (암시적인 과잉 문제 해결하기)**

구체적으로 고정된 타입이 프로토콜을 조건부로 준수할 때, 해당 타입은 같은 필수 조건을 가지는 부모 프로토콜은 어떤 것이든 암시적으로 준수합니다.

단일 부모를 상속하는 두 프로토콜을 조건부로 준수하는 타입이 필요한 경우, 부모 프로토콜에 대한 준수를 명시적으로 선언합니다. 이렇게 하면 서로 다른 필수 조건을 가지는 부모 프로토콜을 암시적으로 두 번 준수하는 것을 피하게 됩니다.

다음 예제는 `TitledLoggable` 및 새로운 `MarkedLoggable` 프로토콜 둘 모두에 대한 조건부 준수성를 선언할 때의 충돌을 피하기 위해 `Loggable` 에 대한 '조건부 준수성' 을 `Array` 에 명시적으로 선언한 것입니다.

```swift
protocol MarkedLoggable: Loggable {
  func markAndLog()
}

extension MarkedLoggable {
  func markAndLog() {
    print("----------")
    log()
  }
}

extension Array: Loggable where Element: Loggable { }
extension Array: TitledLoggable where Element: TitledLoggable {
  static var logTitle: String {
    return "Array of '\(Element.logTitle)'"
  }
}
extension Array: MarkedLoggable where Element: MarkedLoggable { }
```

`Loggable` 에 대한 '조건부 준수' 를 명시적으로 선언하는 '확장 (extension)' 이 없다면, 다른 `Array` '확장 (extension)' 이 이 선언들을 암시적으로 생성하하게 될 것이고, 에러로 귀결될 것입니다:

```swift
extension Array: Loggable where Element: TitledLoggable { }
extension Array: Loggable where Element: MarkedLoggable { }
// 에러: 'Array<Element>' 가 'Loggable' 프로토콜을 과잉 준수함
```

> GRAMMAR OF AN EXTENSION DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID378)

### Subscipt Declaration (첨자 연산 선언)

_첨자 연산 선언 (subscript declaration)_ 은 특정 타입의 객체에 대한 '첨자 연산 보조 기능' 을 추가하도록 하며 이는 전통적으로 '집합체 (collection)', '리스트 (list)', 및 '수열 (sequence)' 에 있는 원소의 접근에 대한 '편의 구문 표현 (convenient syntax)' 을 제공하는데 사용합니다. '첨자 연산 선언' 은 `subscript` 키워드를 사용하여 선언하며 형식은 다음과 같습니다:

subscript (`parameters-매개 변수`) -> `return type-반환 타입` {<br />
  get {<br />
    `statements-구문`<br />
  }<br />
  set(`setter name-설정자 이름`) {<br />
    `statements-구문`<br />
  }<br />
}

'첨자 연산 선언' 은 클래스, 구조체 선언, 열거체, '확장 (extension)', 또는 '프로토콜 선언' 인 상황에서만 쓸 수 있습니다.

_'paramter-매개 변수'_ 는 '첨자 연산 표현식' 에 관련된 타입의 원소에 접근하는 색인을 하나 이상의 지정하는데 사용됩니다 (예를 들어, `object[i]` 표현식의 `i` 같은 것입니다). 원소 접근에 필요한 색인은 어떤 타입이어도 상관없지만, 각 매개 변수는 각각의 색인 타입을 지정하기 위한 '타입 보조 설명' 을 반드시 포함해야 합니다. _'return type-반환 타입'_ 은 접근하고 있는 원소의 타입을 지정합니다.

'계산 속성' 이 그런 것처럼, 첨자 연산 선언은 접근한 원소의 값에 대한 읽기와 쓰기 기능을 지원합니다. '획득자 (getter)' 는 값을 읽는 데 사용되며, '설정자 (setter)' 는 값을 쓰는 데 사용됩니다. '설정자 (setter) 절' 은 선택 사항이며, '획득자 (getter)' 만 필요할 때, 두 구절을 모두 생략하여 요청받은 값을 직접 반환 할 수도 있습니다. 그렇다 하더라도, '획득자 (setter) 절' 을 제공할 경우, 반드시 '획득자 (getter) 절' 도 제공해야 합니다.

_'setter name-설정자 이름'_ 과 이를 둘러싼 괄호는 선택 사항입니다. '설정자 이름' 을 제공하면, 이는 설정자에 대한 매개 변수 이름으로 사용됩니다 '설정자 이름' 을 제공하지 않는 경우, 설정자에 대한 '기본 설정 매개 변수 이름' 은 `value` 가 됩니다. 설정자에 대한 매개 변수의 타입은 _'return type-반환 타입'_ 과 같습니다.

첨자 연산 선언은, _'paramter-매개 변수'_ 또는 _'return type-반환 타입'_ 이 '중복 정의 (overloading)' 하려는 것과 다르기만 하다면, 자신이 선언되어 있는 타입 내에서 '중복 정의' 할 수 있습니다. 상위 클래스에서 상속받은 첨자 연산 선언을 '재정의 (override)' 할 수도 있습니다. 이렇게 할 때는, 재정의한 첨자 연산 선언을 반드시 `override` 선언 수정자로 표시해야 합니다.

'첨자 연산 매개 변수' 는 '함수 매개 변수' 와 같은 규칙을 따르지만, 두 가지 예외가 있습니다. 기본적으로, 첨자 연산에 사용되는 매개 변수는, 함수, 메소드, 및 초기자와는 다르게 '인자 이름표' 를 가지지 않습니다. 하지만, 함수, 메소드, 및 초기자가 사용하는 것과 똑같은 '구문 표현' 을 사용하여 인자 이름표를 명시적으로 제공할 수도 있습니다. 이에 더하여, 첨자 연산은 입-출력 매개 변수를 가질 수 없습니다. 첨자 연산 매개 변수는, [Special Kinds of Parameters (특수한 종류의 매개 변수)](#special-kinds-of-parameters-특수한-종류의-매개-변수) 에서 설명한 구문 표현을 사용하여, 기본 값을 가질 수 있습니다.

[Protocol Subscript Declaration (프로토콜 첨자 연산 선언)](#protocol-subscript-declaration-프로토콜-첨자-연산-선언) 에서 설명한 것처럼, 프로토콜 선언인 상황에서 첨자 연산을 선언할 수도 있습니다.

첨자 연산에 대한 더 자세한 정보 및 첨자 연산 선언에 대한 예제를 보려면, [Subscripts (첨자 연산)]({% post_url 2020-03-30-Subscripts %}) 을 참고하기 바랍니다.

#### Type Subscript Declarations (타입 첨자 연산 선언)

타입의 인스턴스가 아닌, 타입 자체가 노출하는 첨자 연산을 선언하려면, 첨자 연산 선언을 `static` 선언 수정자로 표시합니다. 클래스의 경우 하위 클래스가 상위 클래스의 구현을 재정의 할 수 있도록 하기 위하여 '타입 계산 속성' 을 `class` 선언 수정자로 대신 표시할 수 있습니다. 클래스 선언에서, `static` 키워드는 선언을 `class` 와 `final` 선언 수정자 둘 모두를 써서 표시한 것과 똑같은 효과를 가집니다.

> GRAMMAR OF A SUBSCRIPT DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID379)

### Operator Declaration (연산자 선언)

_연산자 선언 (operator declaration)_ 은 새로운 '중위 (infix) 연산자', '접두사 (prefix) 연산자', 또는 '접미사 (postfix) 연산자' 를 프로그램에 도입하며 `operator` 키워드를 사용하여 선언합니다.

세 가지의 서로 다른 '고정성 (fixity)' 에 따라 연산자를 선언할 수 있는데: '중위 (infix)', '접두사 (prefix)', 그리고 '접미사 (postfix)' 가 그것입니다. 연산자의 _고정성 (fixity)_ 은 '피연산자 (operands)' 에 대한 연산자의 '상대 위치 (relative position)' 를 지정합니다.

연산자 선언에는, 각각의 '고정성' 마다 하나씩, 총 세 개의 기본 형식이 있습니다. 연산자의 고정성을 지정하려면 연산자 선언에서 `operator` 키워드 앞을 `infix`, `prefix`, 또는 `postfix` 선언 수정자로 표시합니다. 각각의 형식에서, 연산자의 이름은 [Operators (연산자)]({% post_url 2020-07-28-Lexical-Structure %}#operators-연산자) 에서 정의한 '연산자 문자 (operator characters)' 만을 가질 수 있습니다.

다음 형식은 새로운 '중위 연산자' 를 선언합니다:

infix operator `operator name-연산자 이름`: `precedence group-우선 순위 그룹`

_중위 연산자 (infix operator)_ 는, 표현식 `1 + 2` 에 있는 친숙한 더하기 연산자 (`+`) 처럼, 두 피연산자 사이에 작성하는 '이항 연산자 (binary operator)' 입니다.

중위 연산자는 선택적으로 '우선 순위 그룹 (precedence group)' 을 지정할 수 있습니다. 만약 연산자에 대한 우선 순위 그룹을 생략할 경우, 스위프트는 '기본 우선 순위 그룹' 인, `DefaultPrecedence` 를, 사용하는데, 이는 `TernaryPrecedence` 보다 바로 한 단계 높은 우선 순위를 지정합니다. 더 자세한 정보는, [Precedence Group Declaration (우선 순위 그룹 선언)](#precedence-group-declaration-우선-순위-그룹-선언) 을 참고하기 바랍니다.

다음 형식은 새로운 '접두사 연산자' 를 선언합니다:

prefix operator `operator name-연산자 이름`

_접두사 연산자 (prefix operator)_ 는, 표현식 `!a` 에 있는 '접두사 논리 부정 연산자 (`!`)' 처럼, 피연산자 바로 앞에 작성하는 '단항 연산자 (unary operator)' 입니다.

'접두사 연산자 선언' 은 '우선 순위 수준 (predecence level)' 를 지정하지 않습니다. '접두사 연산자' 는 '비결합적 (nonassociative)'[^nonassociative] 입니다.

다음 형식은 새로운 '접미사 연산자' 를 선언합니다:

postfix operator `operator name-연산자 이름`

_접미사 연산자 (postfix operator)_ 는, 표현식 `a!` 에 있는 '강제-포장 풀기 연산자 (`!`)' 처럼, 피연산자 바로 뒤에 작성하는 '단항 연산자 (unary operator)' 입니다.

접두사 연산자에서와 같이, '접미사 연산자 선언' 은 '우선 순위 수준' 을 지정하지 않습니다. '접미사 연산자' 는 '비결합적 (nonassociative)'[^nonassociative] 입니다.

새로운 연산자를 선언한 후, 이 연산자와 같은 이름을 가지는 '정적 메소드' 를 선언하는 것으로써 이를 구현합니다. '정적 메소드' 는 연산자가 인자로 취하는 그 값의 타입 중 하나에 대한 멤버입니다-예를 들어, `Double` 에 `Int` 를 곱하는 연산자는 `Double` 또는 `Int` 구조체 중 하나에 대한 '정적 메소드' 로 구현됩니다. 접두사 연산자나 접미사 연산자를 구현하고 있는 경우, 해당 메소드 선언 역시 반드시 그와 연관된 `prefix` 또는 `postfix` 선언 수정자로 표시해야 합니다. 새로운 연산자를 생성하고 구현하는 방법에 대한 예제는, [Custom Operators (사용자 정의 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#custom-operators-사용자-정의-연산자) 를 참고하기 바랍니다.

> GRAMMAR OF AN OPERATOR DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID380)

### Precedence Group Declaration (우선 순위 그룹 선언)

_우선 순위 그룹 선언 (precedence group declaration)_ 은 '중위 연산자' 의 우선 순위에 대한 새로운 '그룹 방식 (grouping)' 을 프로그램에 도입합니다. 연산자의 우선 순위는, '괄호로 그룹지은 것 (grouping parentheses)' 이 없을 때, 연산자가 피연산자에 얼마나 꽉 연결되는 지를 지정합니다.

'우선 순위 그룹 선언' 의 형식은 다음과 같습니다:

precedencegroup `precedence group name-우선 순위 그룹 이름` {
    higherThan: `lower group names-낮아야 하는 그룹 이름`
    lowerThan: `higher group names-높아야 하는 그룹 이름`
    associativity: `associativity-결합성`
    assignment: `assignment-할당`
}

_lower group names-낮아야 하는 그룹 이름_ 과 _higher group names-높아야 하는 그룹 이름_ 목록은 기존 '우선 순위 그룹' 에 새로운 '우선 순위 그룹' 관계를 지정합니다. `lowerThan` 우선 순위 그룹 특성은 현재 모듈의 외부에서 선언한 우선 순위 그룹을 참조할 때만 사용할 수도 있습니다. `2 + 3 * 5` 라는 표현식에서 처럼, 두 연산자가 피연산자를 두고 서로 경쟁할 때, 상대적으로 더 높은 우선 순위를 가지는 연산자가 피연산자와 더 꽉 연결됩니다.

> `lower group names` 과 `higher group names` 의 사용으로 서로 관련된 우선 순위 그룹은 반드시 '단일 관계 계층 (single relational hierarchy)' 에 들어맞아야 하지만, '선형 계층 (linear hierarchy)' 을 형성해야하는 것은 아닙니다. 이는 상대적인 우선 순위가 정의되지 않은 '우선 순위 그룹' 을 가지는 것이 가능함을 의미합니다. 이러한 우선 순위 그룹에 있는 연산자들은 '괄호로 그룹지은 것' 없이 서로 나란히 사용할 수 없습니다.

스위프트는 표준 라이브러리가 제공하는 연산자와 함께 사용할 수 있는 수많은 '우선 순위 그룹' 을 정의하고 있습니다. 예를 들어, '더하기 (`+`)' 및 '빼기 (`-`)' 연산자는 `AdditionPrecedence` 그룹에 속하고, '곱하기 (`*`)' 및 '나누기 (`/`)' 연산자는 `MultiplicationPrecedence` 그룹에 속합니다. 스위프트 표준 라이브러리에서 제공하는 우선 순위 그룹의 완전한 목록은, [Operator Declarations](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 를 참고하기 바랍니다.

연산자의 _associativity-결합성_ 은 '괄호로 그룹지은 것' 이 없을 때 똑같은 우선 순위 수준을 가진 일련의 연산자들이 어떻게 서로 그룹지어져야 하는 지를 지정합니다. 연산자의 결합성은 '상황에-따른 (context-sensitive)' 키워드인 `left`, `right`, 또는 `none` 중 하나를 작성하여 지정합니다-만약 '결합성' 을 생략할 경우, 기본 값은 `none` 입니다. '왼쪽-결합 (left-associative)' 인 연산자는 '왼쪽에서 오른쪽으로 (left-to-right)' 로 그룹짓습니다. 예를 들어, 빼기 연산자 (`-`) 는 '왼쪽-결합' 이므로, 표현식 `4 - 5 - 6` 은 `(4 - 5) - 6` 으로 그룹지어 지고 값은 `-7` 이라고 평가됩니다. '오른쪽-결합' 인 연산자는 '오른쪽에서 왼쪽으로 (right-to-left)' 그룹지으며, 결합성을 `none` 으로 지정한 연산자는 어떤 것도 결합하지 않습니다. 우선 순위 수준이 같은 '비결합적 연산자 (nonassociative operators)' 는 서로 인접하여 있을 수 없습니다. 예를 들어, `<` 연산자는 `none` 이라는 '결합성' 을 가지는데, 이는 `1 < 2 < 3` 이 '유효한 표현식' 은 아님을 의미합니다.

'우선 순위 그룹' 의 _assignment-할당_ 은 연산자가 '옵셔널 연쇄 (optional chaining)' 를 포함한 연산에서 사용될 때의 우선 순위를 지정합니다. `true` 로 설정하면, 관련 우선 순위 그룹에 있는 연산자는 '옵셔널 연쇄' 중에 표준 라이브러리의 '할당 연산자' 와 똑같은 '그룹화 규칙 (grouping rules)' 을 사용합니다. 다른 경우, 즉 `false` 로 설정하거나 생략한 경우라면, 우선 순위 그룹에 있는 연산자는 할당을 수행하지 않는 연산자와 똑같은 '옵셔널 연쇄' 규칙을 따릅니다.

> GRAMMAR OF A PRECEDENCE GROUP DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID550)

### Declaration Modifiers (선언 수정자)

_선언 수정자 (declaration modifiers)_ 는 선언의 작동 방식이나 의미를 수정하는 키워드 또는 '상황에 따른 (context-sensitive)' 키워드입니다. 선언 수정자를 지정하려면 적절한 키워드 또는 '상황에 따른' 키워드를 선언의 (만약 있다면) '특성 (attribute)' 과 선언을 도입하는 키워드 사이에 작성합니다.

`class`

  이 수정자를 클래스의 멤버에 적용하면 그 멤버는, 클래스 인스턴스의 멤버가 아니라, 클래스 자체의 멤버라는 것을 지시합니다. 상위 클래스의 멤버가 이 수정자를 가지고 있으면서 `final` 수정자를 가지고 있지 않으면 하위 클래스에서 재정의할 수 있습니다.

`dynamic`

  이 수정자를 클래스의 어떤 멤버에 적용하면 오브젝티드-C 에서 표현할 수 있게 됩니다. 멤버 선언을 `dynamic` 수정자로 표시할 때, 해당 멤버에 대한 접근은 오브젝티브-C 런타임을 사용하여 항상 동적으로 '급파 (dispatched)' 됩니다. 해당 멤버에 대한 접근은 컴파일러에 의해 절대로 '인라인 (inline; 줄 내에 삽입)' 되거나 '탈가상화 (devirtualized)' 되지 않습니다.

  `dynamic` 수정자로 표시한 선언은 오브젝티브-C 런타임을 사용하여 급파되기 때문에, 반드시 `objc` 특성으로 표시해야 합니다.

`final`

  이 수정자는 클래스 또는 클래스의 속성, 메소드, 및 첨자 연산 멤버에 적용합니다. 클래스에 적용하면 그 클래스로 하위 클래스를 만들 수 없다는 것을 지시합니다. 클래스의 속성, 메소드, 및 첨자 연산에 적용하면 클래스 멤버가 어떤 하위 클래스에서도 재정의할 수 없음을 나타냅니다. `final` 특성을 사용하는 방법에 대한 예제는, [Preventing Overrides (재정의 막기)]({% post_url 2020-03-31-Inheritance %}#preventing-overrides-재정의-막기) 를 참고하기 바랍니다.

`lazy`

  이 수정자를 클래스나 구조체의 저장 변수 속성에 적용하면 그 속성의 초기 값은, 속성에 처음 접근할 때, 최대 한 번만 계산하고 저장한다는 것을 지시합니다. `lazy` 수정자를 사용하는 방법에 대한 예제는, [Lazy Stored Properties (느긋한 저장 속성)]({% post_url 2020-05-30-Properties %}#lazy-stored-properties-느긋한-저장-속성) 를 참고하기 바랍니다.

`optional`

  이 수정자를 프로토콜의 속성, 메소드, 또는 첨자 연산 멤버에 적용하면 준수하는 타입이 해당 멤버를 구현하는 것이 필수가 아님을 지시합니다.

  `optional` 수정자는 `objc` 특성으로 표시한 프로토콜에만 적용할 수 있습니다. 그 결과, 클래스 타입만이 '옵셔널 멤버 필수 조건' 을 담고 있는 프로토콜을 채택하고 준수할 수 있습니다. `optional` 수정자를 사용하는 방법에 대한 더 많은 정보와 '옵셔널 프로토콜 멤버' 의 접근 방법에 대한 길잡이-예를 들어, 준수 타입이 이들을 구현하는 것이 맞는지 확실하지 않을 때 등-은 [Optional Protocol Requirements (옵셔널 프로토콜 필수 조건)]({% post_url 2016-03-03-Protocols %}#optional-protocol-requirements-옵셔널-프로토콜-필수-조건) 을 참고하기 바랍니다.

`required`

  이 수정자를 클래스의 '지명 초기자' 및 '편의 초기자' 에 적용하면 모든 하위 클래스가 반드시 해당 초기자를 구현해야 한다는 것을 지시합니다. 해당 초기자의 하위 클래스 구현도 반드시 `required` 수정자로 표시해야 합니다.

`static`

  이 수정자를 구조체, 클래스, 열거체, 또는 프로토콜의 멤버에 적용하면 그 멤버는, 해당 타입의 인스턴스 멤버가 아니라, 타입 자체의 멤버라는 것을 지시합니다. 클래스 선언 영역에서, 멤버 선언에 `static` 수정자를 작성하면 해당 멤버 선언에 `class` 와 `final` 수정자를 작성하는 것과 똑같은 효과를 가집니다.[^class-final] 하지만, 클래스의 '상수 타입 속성' 은 예외입니다: 여기서의 `static` 은 클래스가 아닐 때의, 보통의 의미를 가지는데 왜냐면 이 선언에서는 `class` 나 `final` 을 쓸 수 없기 때문입니다.

`unowned`

  이 수정자를 저장 변수, 상수 속성, 또는 저장 속성에 적용하면 그 변수 또는 속성이 값으로 저장하고 있는 것이 객체에 대한 '소유하지 않는 참조 (unowned reference)' 라는 것을 지시합니다. 객체가 해제된 후에 변수 또는 속성에 접근하려고 하면, 실행 시간 에러가 발생합니다. '약한 참조 (weak reference)' 와 같이, 속성 또는 값의 타입은 반드시 클래스 타입이어야 합니다: '약한 참조' 와는 달리, 타입은 '옵셔널이-아닌 (non-optional)' 것입니다. `unowned` 수정자에 대한 예제 및 더 많은 정보는, [Unowned References (소유하지 않는 참조)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#unowned-references-소유하지-않는-참조) 를 참고하기 바랍니다.

`unowned(safe)`

  `unowned` 의 (전체) 철자를 명시한 것.

`unowned(unsafe)`

  이 수정자를 저장 변수, 상수 속성, 또는 저장 속성에 적용하면 그 변수 또는 속성이 값으로 저장하고 있는 것이 객체에 대한 '소유하지 않는 참조 (unowned reference)' 라는 것을 지시합니다. 객체가 해제된 후에 변수 또는 속성에 접근하려고 하면, 객체가 있던 위치의 메모리에 접근하게 되는 데, 이것이 '메모리가-안전하지 않은 (memory-unsafe)' 연산입니다. '약한 참조 (weak reference)' 와 같이, 속성 또는 값의 타입은 반드시 클래스 타입이어야 합니다: '약한 참조' 와는 달리, 타입은 '옵셔널이-아닌 (non-optional)' 것입니다. `unowned` 수정자에 대한 예제 및 더 많은 정보는, [Unowned References (소유하지 않는 참조)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#unowned-references-소유하지-않는-참조) 를 참고하기 바랍니다.

`weak`

  이 수정자를 저장 변수 또는 '저장 변수 속성' 에 적용하면 그 변수 또는 속성이 값으로 저장하고 있는 것이 객체에 대한 '약한 참조 (weak reference)' 라는 것을 지시합니다. 변수 또는 속성의 타입은 반드시 '옵셔널 클래스 타입' 이어야 합니다. 객체가 해제된 후에 변수 또는 속성에 접근하면, 그 값은 `nil` 입니다. `weak` 수정자에 대한 예제 및 더 많은 정보는, [Weak References (약한 참조)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#weak-references-약한-참조) 를 참고하기 바랍니다.

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

[^expression]: 여기서의 '표현식 (expression)' 은 위에 있는 형식의 `expression-표현식` 부분을 말합니다. 클래스나 구조체 선언에서는 이 `expression-표현식` 부분이 없어도 된다는 의미입니다.

[^type]: 여기서의 '타입 (type)' 보조 설명이란 위 에제 양식에 있는 'type' 을 말합니다. 뒤에 붙은 'expression' 을 통해 타입을 추론할 수 있는 경우 생략할 수 있는데, 스위프트에서는 거의 생략된 채로 사용합니다.

[^call-by-value-result]: 기본적으로, '값-결과에 의한 호출 (call by value result)' 은 '값에 의한 호출 (call by value)' 과 '참조에 의한 호출 (call by reference)' 이 합쳐진 것으로 볼 수 있습니다. [프로그래밍 학습법탐구자](http://blog.daum.net/here8now/) 님의 [call by value, call by reference, call by value result, call by name](http://blog.daum.net/here8now/37) 항목에 따르면, 함수 안에서는 '값에 의한 호출 (call by value)' 처럼 동작하고, 함수 반환 시에는 '참조에 의한 호출 (call by reference)' 처럼 동작합니다. 다만, 이어지는 본문에서 설명하는 것처럼, 입-출력 매개 변수는 최적화에 의해 '참조에 의한 호출' 작동 방식을 사용하기도 합니다.즉, 스위프트의 '입-출력 매개 변수' 는 상황에 따라 '참조에 의한 호출' 과 '값-결과에 의한 호출' 을 적절하게 선택해서 인자를 전달합니다.

[^call-by-reference]: 즉, 스위프트의 '입-출력 매개 변수' 는, 인자가 메모리의 물리 주소에 저장된 값일 경우, '참조에 의한 호출' 작동 방식으로 동작합니다.

[^closure-with-inout-parameter]: 아래 예제에 있는 `{ [a] in return a + 1 }` 라는 클로저는 `a` 의 값을 변경하지 않으므로, `[a]` 라는 '붙잡을 목록' 을 사용하여 `a` 를 변경 불가능하게 붙잡았습니다.

[^optional-member]: 프로토콜에서 선언한 '필수 조건' 의 구현 여부 자체가 '옵셔널' 이라는 의미입니다. 즉, 프로토콜의 준수 타입에서 구현을 했으면 구현체가 있는 것이고, 구현을 안했으면 `nil` 입니다.

[^throwing-parameter]: '던지는 매개 변수 (throwing paramter)' 는 앞에서 얘기한 '던지는 함수인 매개 변수 (throwing function parameter)' 를 의미합니다.

[^immutable]: '상수' 는 값을 바꿀 수 없는 것인데, 'class' 같은 '참조 타입 (reference type)' 은 '참조 대상의 주소' 가 값이기 때문에, '참조 대상의 내용' 은 바꿀 수 있지만, 다른 대상을 참조하도록 '참조 대상의 주소' 를 바꿀 수는 없다는 의미입니다. 

[^final]: 사실상 이미 'final' 인 상태라고 이해할 수 있습니다.

[^stored-named-values]: 원문에서 말하는 '이름 붙인 저장 값 (stored named values)' 은 '저장 변수 (stored variable)' 를 의미합니다.

[^function-definition]: 스위프트는, 이 장 첫 부분에서 설명한 것처럼, '선언-정의-초기화' 를 한 번에 하기 때문에, '함수 선언' 과 '함수 정의' 가 큰 차이가 없습니다. 다만 여기서는 '함수 본문 전체' 를 의미하기 위해 '함수 정의 (function definition)' 라는 표현을 사용했습니다.

[^indefinitely]: 스위프트의 `Never` 타입은 'MVVM' 의 'Publisher' 에서 사용하는데, 이는 프로그램을 실행하는 동안 계속해서 'Subscriber' 쪽으로 정보를 보냅니다. 컴파일 시간에는 프로그램의 종료 시점을 알 수 없으므로 `Never` 타입을 사용합니다. 즉, 'MVVM' 에서는 의도적으로 `Never` 타입을 사용하는 것입니다. 

[^method-with-special-anme]: 본문에서 설명하는 내용은 C++ 언어에 있는 '함수 객체 (Function Object)' 와 비슷한 내용입니다. '함수 객체' 에 대한 더 자세한 정보는 위키피디아의 [Function object](https://en.wikipedia.org/wiki/Function_object) 항목을 참고하기 바랍니다.

[^designated-initializers]: 여기서 '초기자' 가 아니라 '지명 초기자' 라고 한 것은, 재정의한 초기자가 상위 클래스에서 '지명 초기자' 이든 '편의 초기자' 이든, 재정의하고 나면 무조건 '지명 초기자' 가 되기 때문입니다.

[^universal-base-class]: '범용 기초 클래스 (universal base class)' 는 오브젝티브-C 언어의 `NSObject` 같은 클래스를 말합니다.

[^reference-type]: 원문 자체가 [Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#structures-and-enumerations-are-value-types-구조체와-열거체는-값-타입입니다) 를 참고하라고 되어 있는데, 내용을 보면 실제로는 [Classes Are Reference Types (클래스는 참조 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#classes-are-reference-types-클래스는-참조-타입입니다) 를 참고하는 것이 맞습니다. 원문 자체의 오류일 것으로 추측됩니다.

[^nonassociative]: '비결합적 (nonassociative)' 이라는 것은 '결합성 (associativity)' 이 `none` 인 것을 말하는 것으로 추측됩니다. 보다 자세한 내용은 이어지는 절인 [Precedence Group Declaration (우선 순위 그룹 선언)](#precedence-group-declaration-우선-순위-그룹-선언) 을 참고하기 바랍니다.

[^operator-declarations]: 원문 자체가 애플 개발자 사이트의 [Operator Declarations](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations) 항목으로 연결되어 있습니다.

[^class-final]: 즉 클래스 선언에서의 `static` 은 `class` 와 `final` 을 동시에 사용하는 것과 같은 의미입니다.

[^any-type]: 여기서의 'Any Type' 은 스위프트에 있는 '`Any` 타입' 과는 다른 의미로 사용한 것입니다.

[^enumeration-get-only]: 아래 예제의 열거체에서 `case someValue` 가 프로토콜의 `static var someValue: Self { get }` 이라는 필수 조건을 만족한다는 의미입니다.

[^enumeration-function]: 아래 예제의 열거체에서 `case someFuntion(x: Int)` 가 프로토콜의 `static func someFunction(x: Int) -> Self` 라는 필수 조건을 만족한다는 의미입니다. [Enumerations with Cases of Any Type (어떤 타입이든 되는 'case 값' 을 가진 열거체)](#enumerations-with-cases-of-any-type-어떤-타입이든-되는-case-값-을-가진-열거체) 에서 설명한 것처럼, '결합 값을 가진 열거체 case 값' 은 함수처럼 사용할 수 있기 때문입니다.

[^isolate]: 이를 '행위자 격리 (actor isolation)' 이라고 하는데, 이에 대한 더 자세한 정보는 [Concurrency (동시성)]({% post_url 2021-06-10-Concurrency %}) 장의 [Actors (행위자)]({% post_url 2021-06-10-Concurrency %}#actors-행위자) 부분을 참고하기 바랍니다. 

[^structure-type]: 원문에서는 '구조체 타입 (structure type)' 이라고 되어 있는데, '행위자 타입 (actor type)' 의 오타라고 추측됩니다.

[^type-computed-properties]: '타입 변수 속성 (type variable property)' 이 아니라, '타입 계산 속성 (type computed property)' 입니다. '타입 저장 속성 (type stored property)' 는 해당하지 않습니다. 

[^escaping]: '벗어나는 (escaping) 것' 에 대한 더 자세한 내용은, [Escaping Closures (벗어나는 클로저)]({% post_url 2020-03-03-Closures %}#escaping-closures-벗어나는-클로저) 부분에 있는 내용과 주석을 참고하기 바랍니다.

[^variadic-label]: '인자 이름표' 가 없으면 새로운 매개 변수로 인식하지 않고, 가변 매개 변수의 한 원소로 인식되기 때문입니다. 

[^signature]: 함수나 메소드에서 '서명 (signature)' 과 '이름 (name)' 의 차이점은 '매개 변수' 를 포함하는 지의 여부입니다. 이 예제에 있는 `init(rawValue: RawValue)` 는 '초기자 서명 (signature)' 이며, 매개 변수 부분을 뺀 `init?` 이 '초기자 이름' 입니다. 