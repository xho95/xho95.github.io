---
layout: post
comments: true
title:  "Swift 5.7: Declarations (선언)"
date:   2020-08-15 11:30:00 +0900
categories: Swift Language Grammar Declaration
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [Declarations](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html) 부분[^Declarations]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Declarations (선언)

_선언 (declaration)_ 은 프로그램에 새로운 이름이나 구조물 (construct) 을 도입합니다. 예를 들어, 선언을 사용하여 함수와 메소드를 도입하고, 변수와 상수를 도입하며, 열거체와, 구조체, 클래스, 및 프로토콜 타입을 정의합니다. 선언을 사용하면 기존 이름 붙인 타입의 동작을 확장하고 다른 곳에서 선언한 기호 (symbols) 를 자신의 프로그램 안으로 불러 올 수도 있습니다.

스위프트에선, 선언과 동시에 구현 또는 초기화한다는 점에서 대부분의 선언이 정의이기도 합니다. 그렇더라도, 프로토콜은 자신의 멤버를 구현하지 않기 때문에, 대부분의 프로토콜 멤버는 선언이기만 합니다. 편의를 위해 그리고 스위프트에선 구별이 그다지 중요하지 않기 때문에, _선언 (declarations)_ 이라는 용어가 선언과 정의 둘 다를 아우릅니다.

> GRAMMAR OF A DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html)

### Top-Level Code (최상단 코드)

스위프트 소스 파일 안의 최상단 코드는 0 개 이상의 구문과, 선언, 및 표현식으로 구성됩니다. 기본적으로, 소스 파일 최상단에 선언한 변수와, 상수, 및 그 외 이름 붙인 선언은 동일 모듈 안의 모든 소스 파일 코드에 접근 가능합니다. [Access Control Levels (접근 제어 수준)](#access-control-levels-접근-제어-수준) 에서 설명한, 접근-수준 수정자로 선언을 표시함으로써 이런 기본 동작을 재정의할 수 있습니다.

두 종류의 최상단 코드가 있는데: 최상단 선언 (top-level declarations) 과 실행 가능한 최상단 코드 (excutable top-level code) 가 그것입니다. 최상단 선언은 선언으로만 구성하며, 모든 스위프트 소스 파일에서 허용합니다. 실행 가능한 최상단 코드는, 선언만이 아니라, 구문과 표현식도 담으며, 프로그램의 최상단 진입점 (top-level entry point) 으로만 허용합니다.

실행 파일 (executable) 을 만들려고 컴파일하는 스위프트 코드는, 파일과 모듈로 어떻게 코드를 정돈하는지에 상관없이, 다음 접근법 중 최대 하나만을 담아 최상단 진입점을 표시할 수 있는데: 이에는 `main` 특성이나, `NSApplicationMain` 특성, `UIApplicationMain` 특성, `main.swift` 파일, 또는 최상단(에서) 실행 가능한 코드를 담은 파일이 그것입니다.

> GRAMMAR OF A TOP-LEVEL DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID352)

### Code Blocks (코드 블럭)

_코드 블럭 (code block)_ 은 구문을 서로 그룹묶기 위해 다양한 선언 및 제어 구조에서 사용합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;{<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

코드 블럭 안의 _구문 (statements)_ 은 선언과, 표현식, 및 다른 종류의 구문을 포함하며 소스 코드에 나타난 순서대로 실행합니다.

> GRAMMAR OF A CODE BLOCK 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID353)

### Import Declaration (불러오기 선언)

_불러오기 선언 (import declaration)_ 는 현재 파일 밖에서 선언한 기호에 접근하게 해줍니다. 기본 형식은 전체 모듈을 불러오며; `import` 키워드와 그 뒤의 모듈 이름으로 구성합니다:

&nbsp;&nbsp;&nbsp;&nbsp;import `module-모듈`

더 자세하게 제공하면 불러올 기호를 제한합니다-모듈이나 하위 모듈 안의 특정 하위 모듈이나 특정 선언을 지정할 수 있습니다. 이 자세한 형식을 사용할 땐, (선언한 모듈이 아닌) 불러온 기호만 현재 시야에서 쓸 수 있게 됩니다.ㅇ

&nbsp;&nbsp;&nbsp;&nbsp;import `import kind-불러올 종류` `module-모듈`.`symbole name-기호 이름`<br />
&nbsp;&nbsp;&nbsp;&nbsp;import `module-모듈`.`submodule-하위 모듈`

> GRAMMAR OF AN IMPORT DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID354)

### Constant Declaration (상수 선언)

_상수 선언 (constant declaration)_ 은 프로그램에 상수 이름 값을 도입합니다. 상수 선언은 `let` 키워드로 선언하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;let `constant name-상수 이름`: `type-타입` = `expression-표현식`

상수 선언은 _상수 이름 (constant name)_ 과 초기자 _표현식 (expression)_ 값 사이에 변경 불가한 연결을 정의하여; 상수 값을 설정한 후엔, 바꿀 수 없습니다. 그렇더라도, 상수를 클래스 객체로 상초기화하면, 상수 이름과 그게 참조할 수 객체 사이의 연결은 바꿀 수 없지만, 객체 그 자체는 바꿀 수 있습니다.[^immutable]

전역[^global-scope] 에서 상수를 선언할 땐, 반드시 값으로 초기화해야 합니다. 함수나 메소드에서 상수 선언을 할 땐, 값을 최초로 읽기 전에 설정한다고 보증하는 한, 나중에 초기화할 수 있습니다. 상수 값을 절대 읽지 않는다는 걸 컴파일러가 증명할 수 있으면, 아예 상수 값 설정이 필수가 아닙니다. 클래스나 구조체 선언에서 상수 선언을 할 땐, _상수 속성 (constant property)_ 이라고 고려합니다. 상수 선언은 계산 속성이 아니며 따라서 획득자나 설정자가 없습니다.

상수 선언의 _상수 이름 (constant name)_ 이 튜플 패턴이면, 튜플 안의 각 항목 이름을 초기자 _표현식 (expression)_ 안의 해당 값과 연결합니다.

```swift
let (firstNumber, secondNumber) = (10, 42)
```

이 예제에서, `firstNumber` 는 `10` 이라는 값에 '이름 붙인 상수' 이며, `secondNumber` 는 `42` 라는 값에 '이름 붙인 상수' 입니다. 두 상수 모두 이제 독립적으로 사용할 수 있습니다:

```swift
print("The first number is \(firstNumber).")
// "The first number is 10." 를 인쇄함
print("The second number is \(secondNumber).")
// "The second number is 42." 를 인쇄함
```

[Type Inference (타입 추론)]({% post_url 2020-02-20-Types %}#type-inference-타입-추론) 에서 설명한 것처럼, _상수 이름 (constant name)_ 의 타입을 추론할 수 있을 땐 (`:` _타입 (type)_ 이라는) 타입 보조 설명이 옵션입니다.

상수 타입 속성을 선언하려면, 선언에 `static` 선언 수정자를 표시합니다. 클래스의 상수 타입 속성은 항상 암시적으로 최종 (final) 이며; `class` 나 `final` 선언 수정자를 표시하여 하위 클래스 재정의를 허용하거나 불허할 수 없습니다.[^final] 타입 속성은 [Type Properties (타입 속성)]({% post_url 2020-05-30-Properties %}#type-properties-타입-속성) 에서 논의합니다.

상수에 대한 더 많은 정보와 사용 시점에 대한 본보기는, [Constants and Variables (상수와 변수)]({% post_url 2016-04-24-The-Basics %}#constants-and-variables-상수와-변수) 와 [Stored Properties (저장 속성)]({% post_url 2020-05-30-Properties %}#stored-properties-저장-속성) 부분을 보도록 합니다.

> GRAMMAR OF A CONSTANT DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID355)

### Variable Declaration (변수 선언)

_변수 선언 (variable declaration)_ 은 프로그램에 변수 이름 값을 도입하며 `var` 키워드로 선언합니다.

변수 선언은 여러 가지 형식으로 서로 다른 종류의 이름을 붙인, 변경 가능한 값을 선언하는데, 이는 저장 및 계산 변수와 속성, 저장 변수와 속성 관찰자, 및 정적 변수 속성을 포함합니다. 사용에 적절한 형식은 변수를 선언할 영역과 선언할 의도인 변수의 종류에 달려 있습니다.

> [Protocol Property Declaration (프로토콜 속성 선언)](#protocol-property-declaration-프로토콜-속성-선언) 에서 설명한 것처럼, 프로토콜 선언에서 속성을 선언할 수도 있습니다.

[Overriding (재정의하기)]({% post_url 2020-03-31-Inheritance %}#overriding-재정의하기) 에서 설명한 것처럼, 하위 클래스의 속성 선언을 `override` 선언 수정자로 표시함으로써 하위 클래스에서 속성을 재정의할 수 있습니다.

#### Stored Variables and Stored Variable Properties (저장 변수와 저장 변수 속성)

다음 형식은 저장 변수 또는 저장 변수 속성을 선언합니다:

&nbsp;&nbsp;&nbsp;&nbsp;var `variable name-변수 이름`: `type-타입` = `expression-표현식`

이 형식의 변수 선언은 전역이나, 함수 지역, 또는 클래스나 구조체 선언에서 정의합니다. 이 형식의 변수 선언을 전역이나 함수 지역에서 할 때, _저장 변수 (stored variable)_ 라고 합니다. 클래스나 구조체 선언에서 선언할 땐, _저장 변수 속성 (stored variable property)_ 이라고 합니다.

초기자 _표현식 (expression)_ 은 프로토콜 선언에 있을 수 없지만, 다른 모든 상황에서, 초기자 _표현식 (expression)_ 은 옵션입니다. 그렇더라도, 초기자 _표현식 (expression)_ 이 아무 것도 없으면, 반드시 (`:` _타입 (type)_ 이라는) 명시적 타입 보조 설명을 변수 선언에 포함해야 합니다.

상수 선언 처럼, _변수 이름 (variable name)_ 이 튜플 패턴이면, 튜플 안의 각 항목 이름을 초기자 _표현식 (expression)_ 안의 해당 값과 연결합니다.

이름이 제시하듯, 저장 변수 또는 저장 변수 속성 값은 메모리에 저장합니다.

#### Computed Variables and Computed Properties (계산 변수와 계산 속성)

다음 형식은 계산 변수 또는 계산 속성을 선언합니다:

&nbsp;&nbsp;&nbsp;&nbsp;var `variable name-변수 이름`: `type-타입` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;get {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;set (`setter name-설정자 이름`) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statement-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

이 형식의 변수 선언은 전역이나, 함수 지역, 또는 클래스나, 구조체, 열거체, 및 익스텐션 선언에서 정의합니다. 이 형식의 변수 선언을 전역이나 함수 지역에서 할 때, _계산 변수 (computed variable)_ 라고 합니다. 클래스나, 구조체, 또는 익스텐션 선언에서 할 땐, _계산 속성 (computed property)_ 이라고 합니다.

획득자 (getter) 로 값을 읽고, 설정자 (setter) 로 값을 씁니다. [Read-Only Computed Properties (읽기-전용 계산 속성)]({% post_url 2020-05-30-Properties %}#read-only-computed-properties-읽기-전용-계산-속성) 에서 설명한 것처럼, 설정자 절은 옵션이라, 획득자만 필요할 땐, 두 절 모두 생략하고 단순히 요청 값만 직접 반환할 수 있습니다. 그러나 설정자 절을 제공하면, 획득자 절도 반드시 제공해야 합니다.

_설정자 이름 (setter name)_ 과 테두리 괄호는 옵션입니다. 설정자 이름을 제공하면, 설정자의 매개 변수 이름으로 이걸 사용합니다. 설정자 이름을 제공하지 않으면, [Shorthand Setter Declaration (짧게 줄인 설정자 선언)]({% post_url 2020-05-30-Properties %}#shorthand-setter-declaration-짧게-줄인-설정자-선언) 에서 설명한 것처럼, `newValue` 가 설정자의 기본 매개 변수 이름입니다.

저장 이름 값[^stored-named-values] 및 저장 변수 속성과는 달리, 계산 이름 값 또는 계산 속성 값은 메모리에 저장하지 않습니다.

계산 속성에 대한 더 자세한 정보 및 예제를 보려면, [Computed Properties (계산 속성)]({% post_url 2020-05-30-Properties %}#computed-properties-계산-속성) 부분을 보도록 합니다.

#### Stored Variable Observers and Property Observers (저장 변수 관찰자와 속성 관찰자)

`willSet` 과 `didSet` 관찰자가 있는 저장 변수나 속성을 선언할 수도 있습니다. 관찰자가 있는 저장 변수나 속성의 선언 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;var `variable name-변수 이름`: `type-타입` = `expression-표현식` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;willSet(`setter name-설정자 이름`) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;didSet(`setter name-설정자 이름`) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

이 형식의 변수 선언은 전역이나, 함수 지역, 또는 클래스나 구조체 선언에서 정의합니다. 이 형식의 변수 선언을 전역이나 함수 지역에서 할 땐, 관찰자를 _저장 변수 관찰자 (stored variable observers)_ 라고 합니다. 클래스나 구조체 선언에서 선언할 땐, 관찰자를 _속성 관찰자 (property observers)_ 라고 합니다.

속성 관찰자는 어떤 저장 속성에든 추가할 수 있습니다. [Overriding Property Observers (속성 관찰자 재정의하기)]({% post_url 2020-03-31-Inheritance %}#overriding-property-observers-속성-관찰자-재정의하기) 에서 설명한 것처럼, 하위 클래스 안에서 속성을 재정의함으로써 (저장이든 계산이든 상관없이) 어떤 상속 속성에도 속성 관찰자를 추가할 수 있습니다.

초기자 _표현식 (expression)_[^expression] 은 클래스나 구조체 선언에서는 옵션이지만, 다른 곳에선 필수입니다. 초기자 _표현식 (expression)_ 으로 타입을 추론할 수 있을 땐 _타입 (type)_ 보조 설명이 옵션입니다. 속성 값을 최초로 읽을 때 이 표현식을 평가합니다. 속성 초기 값을 읽지 않고 덮어 쓰면, 속성에 최초로 쓰기 전 이 표현식을 평가합니다.

`willSet` 과 `didSet` 관찰자는 변수나 속성 값을 설정할 때 이를 관찰하고 (적절히 응답할) 방법을 제공합니다. 변수나 속성을 최초로 초기화할 땐 관찰자를 호출하지 않습니다. 그 대신, 초기화(인 상황) 밖에서 값을 설정할 때만 호출합니다.

`willSet` 관찰자는 변수나 속성 값 설정 직전에 호출됩니다. 새 값은 `willSet` 관찰자에 상수로 전달되어, 따라서 `willSet` 절 구현부에선 바꿀 수 없습니다. `didSet` 관찰자는 새 값 설정 직후에 호출됩니다. `willSet` 관찰자와는 대조적으로, 여전히 접근이 필요한 경우를 위해 `didSet` 관찰자에 변수나 속성의 예전 값을 전달합니다. 그렇더라도, 변수나 속성 자신의 `didSet` 관찰자 절에서 값을 할당하면, 그 할당한 새 값이 방금 전 설정하여 `willSet` 관찰자로 전달한 걸 교체할 겁니다.

`willSet` 과 `didSet` 절의 _설정자 이름 (setter name)_ 과 테두리 괄호는 옵션입니다. 설정자 이름을 제공하면, `willSet` 과 `didSet` 관찰자의 매개 변수 이름으로 이걸 사용합니다. 설정자 이름을 제공하지 않으면, `willSet` 관찰자의 기본 매개 변수 이름은 `newValue` 이고 `didSet` 관찰자의 기본 매개 변수 이름은 `oldValue` 입니다.

`willSet` 절을 제공할 뗀 `didSet` 절이 옵션입니다. 마찬가지로, `didSet` 절을 제공할 땐 `willSet` 절이 옵션입니다.

`didSet` 관찰자 본문에서 예전 값을 참조하면, 예전 값이 사용 가능헤지도록, 관찰자 전에 획득자를 호출합니다. 그 외 경우, 상위 클래스의 획득자를 호출하지 않고 새 값을 저장합니다. 아래 예제는 상위 클래스에서 정의한 계산 속성에 관찰자를 추가하도록 하위 클래스에서 재정의하는 걸 보여줍니다: 

```swift
class Superclass {
  private var xValue = 12
  var x: Int {
    get { print("Getter was called"); return xValue }
    set { print("Setter was called"); xValue = newValue }
  }
}

// 이 하위 클래스의 관찰자에선 oldValue 를 참조하지 않으므로,
// 상위 클래스 획득자를 값 인쇄 때 딱 한 번만 호출합니다.
class New: Superclass {
  override var x: Int {
    didSet { print("New value \(x)") }
  }
}
let new = New()
new.x = 100
// "Setter was called" 를 인쇄함
// "Getter was called" 를 인쇄함
// "New value 100" 를 인쇄함

// 이 하위 클래스의 관찰자에선 oldValue 를 참조하므로,
// 상위 클래스 획득자를 설정자 전에 한 번, 값 인쇄 때 다시 한 번 호출합니다.
class NewAndOld: Superclass {
  override var x: Int {
    didSet { print("Old value \(oldValue) - new value \(x)") }
  }
}
let newAndOld = NewAndOld()
newAndOld.x = 200
// "Getter was called" 를 인쇄함
// "Setter was called" 를 인쇄함
// "Getter was called" 를 인쇄함
// "Old value 12 - new value 200" 를 인쇄함
```

속성 관찰자에 대한 더 많은 정보와 사용법 예제를 보려면, [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 부분을 보도록 합니다.

#### Type Variable Properties (타입 변수 속성)

타입 변수 속성을 선언하려면, 선언에 `static` 선언 수정자를 표시합니다. 클래스에선 그 대신 타입 계산 속성[^type-computed-properties] 에 `class` 선언 수정자를 표시하여 하위 클래스에서 상위 클래스 구현을 재정의하게 할 수 있습니다. 타입 속성은 [Type Properties (타입 속성)]({% post_url 2020-05-30-Properties %}#type-properties-타입-속성) 부분에서 논의합니다.

> GRAMMAR OF A VARIABLE DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID356)

### Type Alias Declaration (타입 별명 선언)

_타입 별명 선언 (type alias declaration)_ 은 프로그램에 기존 타입의 별명을 도입합니다. 타입 별명 선언은 `typealias` 키워드로 하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;typealias `name-이름` = `existing type-기존 타입`

타입 별명의 선언 후엔, 프로그램 어디서나 _기존 타입 (existing type)_ 대신 별명 _이름 (name)_ 을 사용할 수 있습니다. _기존 타입 (existing type)_ 은 이름 붙인 타입이나 복합 타입일 수 있습니다. 타입 별명은 새로운 타입을 생성하지 않으며; 단순히 한 이름이 기존 타입을 가리키도록 합니다.

타입 별명 선언은 일반화 매개 변수[^generic] 를 사용하여 기존 일반화 타입에 이름을 줄 수 있습니다. 타입 별명은 기존 타입의 일반화 매개 변수 중 일부 또는 모두에 고정 타입[^concrete-type] 을 제공할 수 있습니다. 예를 들면 다음과 같습니다:

```swift
typealias StringDictionary<Value> = Dictionary<String, Value>

// 다음 딕셔너리들은 똑같은 타입입니다.
var dictionary1: StringDictionary<Int> = [:]
var dictionary2: Dictionary<String, Int> = [:]
```

일반화 매개 변수가 있는 타입 별명을 선언할 땐, 그 매개 변수에 대한 구속 조건과 기존 타입의 일반화 매개 변수에 대한 구속 조건이 반드시 정확히 일치해야 합니다. 예를 들면 다음과 같습니다:

```swift
typealias DictionaryOfInts<Key: Hashable> = Dictionary<Key, Int>
```

타입 별명과 기존 타입은 서로 바꿔 쓸 수 있기 때문에, 타입 별명에 추가적인 일반화 구속 조건을 도입할 순 없습니다.

타입 별명은 선언에 있는 모든 일반화 매개 변수를 생략함으로써 기존 타입의 일반화 매개 변수를 보내줄 수 있습니다. 예를 들어, 여기서 선언한 `Diccionario` 라는 타입 별명은 `Dictionary` 와 일반화 매개 변수 및 구속 조건이 똑같습니다.

```swift
typealias Diccionario = Dictionary
```

프로토콜 선언 안에선, 타입 별명이 자주 사용할 타입에 더 짧고 편리한 이름을 줄 수 있습니다. 예를 들면 다음과 같습니다:

```swift
protocol Sequence {
  associatedtype Iterator: IteratorProtocol
  typealias Element = Iterator.Element
}

func sum<T: Sequence>(_ sequence: T) -> Int where T.Element == Int {
  // ...
}
```

이 타입 별명이 없다면, `sum` 함수가 결합 타입을 `T.Element` 대신 `T.Iterator.Element` 라고 참조해야 했을 겁니다.

[Protocol Associated Type Declaration (프로토콜의 결합 타입 선언)](#protocol-associated-type-declaration-프로토콜의-결합-타입-선언) 부분도 보도록 합니다.

> GRAMMAR OF A TYPE ALIAS DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID361)

### Function Declaration (함수 선언)

_함수 선언 (function declaration)_ 은 프로그램에 함수나 메소드를 도입합니다. 클래스나, 구조체, 열거체, 또는 프로토콜 안에서 선언한 함수를 _메소드 (method)_ 라고 합니다. 함수 선언은 `func` 키워드로 하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;func `function name-함수 이름`(`parameters-매개 변수`) -> `return type-반환 타입` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

함수 반환 타입이 `Void` 면, 다음 처럼 반환 타입을 생략할 수 있습니다:

&nbsp;&nbsp;&nbsp;&nbsp;func `function name-함수 이름`(`parameters-매개 변수`) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

각각의 매개 변수 타입은 반드시 포함해야 합니다-이는 추론할 수 있는게 아닙니다. 매개 변수 타입 앞에 `inout` 을 쓰면, 함수 영역 안에서 매개 변수를 수정할 수 있습니다. 입-출력 매개 변수는, 밑의, [In-Out Parameters (입-출력 매개 변수)](#in-out-parameters-입-출력-매개-변수) 에서 자세히 논의합니다.

함수 선언 _구문 (statements)_ 이 단일 표현식만 포함하고 있으면 그 표현식 값을 반환하는 걸로 이해합니다. 표현식 타입과 함수 반환 타입이 `Void` 도 아니고 `Never` 같은 어떤 case 값도 없는 열거체가 아닐 때만 이런 암시적 반환 구문을 고려합니다.

튜플 타입을 함수의 반환 타입으로 사용하면 함수가 여러 개의 값을 반환할 수 있습니다.

함수 정의를 또 다른 함수 선언 안에 나타낼 수 있습니다.[^function-definition] 이런 종류의 함수를 _중첩 함수 (nested function)_ 라고 합니다.

입-출력 매개 변수 같이-절대 벗어나지 않는다는 걸 보증한 값 또는 벗어나지 않는 함수 인자로 전달한 값을 붙잡으면 중첩 함수가 벗어나지 않는 겁니다.[^escaping] 그 외 경우에, 중첩 함수는 벗어나는 함수입니다.

중첩 함수에 대한 논의는, [Nested Functions (중첩 함수)]({% post_url 2020-06-02-Functions %}#nested-functions-중첩-함수) 부분을 보도록 합니다.

#### Parameter Names (매개 변수 이름)

함수 매개 변수는 여러 가지 형식으로 된 각각의 매개 변수들을 쉼표로-구분한 목록입니다. 함수 호출의 인자 순서는 함수 선언의 매개 변수 순서와 반드시 일치해야 합니다. 매개 변수 목록에서 가장 단순한 요소의 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`parameter name-매개 변수 이름`: `parameter type-매개 변수 타입`

매개 변수에는, 함수 본문 안에서 사용하는, 이름뿐 아니라, 함수나 메소드 호출 때 사용하는, 인자 이름표도 있습니다. 기본적으로, 매개 변수 이름을 인자 이름표로도 사용합니다. 예를 들면 다음과 같습니다:

```swift
func f(x: Int, y: Int) -> Int { return x + y }
f(x: 1, y: 2) // x 와 y 둘 다 이름표 있음
```

인자 이름표의 기본 동작을 다음 형식 중 하나로 재정의할 수도 있습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`argument label-인자 이름표` `parameter name-매개 변수 이름`: `parameter type-매개 변수 타입`<br />
&nbsp;&nbsp;&nbsp;&nbsp;\_ `parameter name-매개 변수 이름`: `parameter type-매개 변수 타입`

매개 변수 이름 앞의 이름은 매개 변수에 명시적 인자 이름표를 주는데, 이는 매개 변수 이름과 다를 수 있습니다. 해당 인자는 함수나 메소드 호출에서 반드시 주어진 인자 이름표를 사용해야 합니다.

매개 변수 이름 앞의 밑줄 (`_`) 은 인자 이름표를 억누릅니다. 해당 인자는 함수나 메소드 호출에서 반드시 아무런 이름표가 없어야 합니다.

```swift
func repeatGreeting(_ greeting: String, count n: Int) { /* n 번 인사 합니다 */ }
repeatGreeting("Hello, world!", count: 2) //  count 엔 이름표가 있고, greeting 엔 없음
```

#### In-Out Parameters (입-출력 매개 변수)

입-출력 매개 변수는 다음 처럼 전달합니다:

1. 함수 호출 때, 인자 값을 복사합니다.
2. 함수 본문에서, 복사본을 수정합니다.
3. 함수 반환 때, 복사본 값을 원본 인자에 할당합니다.

이 동작을 _복사-입력 복사-출력 (copy-in copy-out)_ 또는 _값-결과에 의한 호출 (call by value result)_[^call-by-value-result] 이라고 합니다. 예를 들어, 계산 속성 또는 관찰자가 있는 속성을 입-출력 매개 변수로 전달할 땐, 함수 호출 시엔 획득자를 호출하고 함수 반환 시엔 설정자를 호출합니다.

최적화로써, 인자가 메모리의 물리 주소에 저장된 값일 땐, 함수 본문 안과 밖 모두에서 동일한 메모리 위치를 사용합니다.[^physical-address] (이런) 최적화 동작을 _참조에 의한 호출 (call by reference)_ 이라고 하며; 복사-입력 복사-출력 모델의 모든 필수 조건을 만족하면서도 복사라는 부담을 제거합니다.[^call-by-reference] 참조에-의한-호출 최적화에 의존하지 말고, 주어진 복사-입력 복사-출력 모델로 코드를 작성하면, 최적화가 있던 없던 올바로 동작합니다.[^optimization]

함수 안에선, 현재 영역에서 원본 값이 사용 가능하더라도, 입-출력 인자로 전달한 값엔 접근하지 않아야 합니다. 원본에 접근하면 값에 대한 동시 접근[^simultaneous-access] 이라, 스위프트의 메모리 독점권 보증[^memory-exclusivity-guarantee] 을 위반합니다. 똑같은 이유로, 여러 개의 입-출력 매개 변수에 동일한 값을 전달할 순 없습니다.

메모리 안전성과 메모리 독점권에 대한 더 많은 정보는, [Memory Safety (메모리 안전성)]({% post_url 2020-04-07-Memory-Safety %}) 장을 보도록 합니다.

입-출력 매개 변수를 붙잡는 클로저나 중첩 함수는 반드시 벗어나지 않아야 (nonescaping) 합니다. 입-출력 매개 변수를 변경 (mutating) 없이 붙잡을 필요가 있다면, 붙잡을 목록 (capture list) 을 써서 매개 변수가 변경 불가능하다는 걸 명시하고 붙잡아야 합니다.[^closure-with-inout-parameter]

```swift
func someFunction(a: inout Int) -> () -> Int {
  return { [a] in return a + 1 }
}
```

입-출력 매개 변수를 붙잡고 변경할 필요가 있다면, 함수 반환 전에 모든 변경의 종료를 보장하는 다중 쓰레드 코드 처럼, 명시적 지역 복사본 (local copy) 을 사용합니다.

```swift
func multithreadedFunction(queue: DispatchQueue, x: inout Int) {
  // 지역 복사본을 만들고 수동으로 복사하여 되돌립니다.
  var localX = x
  defer { x = localX }

  // localX 에 비동기 연산을 한 다음, 반환 전에 기다립니다.
  queue.async { someMutatingOperation(&localX) }
  queue.sync {}
}
```

입-출력 매개 변수에 대한 더 많은 논의와 예제는, [In-Out Parameters (입-출력 매개 변수)]({% post_url 2020-06-02-Functions %}#in-out-parameters-입-출력-매개-변수) 부분을 보도록 합니다.

#### Special Kinds of Parameters (특수한 종류의 매개 변수)

다음 형식을 사용하면 매개 변수를 무시하고, 가변 개수의 값을 취하며, 기본 값을 제공할 수 있습니다:

&nbsp;&nbsp;&nbsp;&nbsp;\_ : `parameter type-매개 변수 타입`<br />
&nbsp;&nbsp;&nbsp;&nbsp;`parameter name-매개 변수 이름`: `parameter type-매개 변수 타입`...<br />
&nbsp;&nbsp;&nbsp;&nbsp;`parameter name-매개 변수 이름`: `parameter type-매개 변수 타입` = `default argument value-기본 설정 인자 값`

밑줄 (`_`) 매개 변수는 명시적으로 무시하며 함수 본문 안에서 접근할 수 없습니다.

기초 타입 이름 바로 뒤에 세 점 (`...`) 이 있는 매개 변수는 가변 매개 변수라고 이해합니다. 가변 매개 변수 바로 뒤에 있는 매개 변수엔 반드시 인자 이름표가 있어야 합니다.[^variadic-label] 함수의 가변 매개 변수는 여러 개일 수 있습니다. 가변 매개 변수는 기초 타입 이름의 원소를 담은 배열로 취급합니다. 예를 들어, `Int...` 라는 가변 매개 변수는 `[Int]` 로 취급합니다. 가변 매개 변수의 사용 예는, [Variadic Parameters (가변 매개 변수)]({% post_url 2020-06-02-Functions %}#variadic-parameters-가변-매개-변수) 부분을 보도록 합니다.

자신의 타입 뒤에 같음 기호 (`=`)[^equals-sign] 와 표현식이 있는 매개 변수는 주어진 표현식에 (해당하는) 기본 값을 가진다고 이해합니다. 주어진 표현식은 함수 호출 때 평가합니다. 함수 호출 때 매개 변수를 생략하면, 기본 값을 대신 사용합니다.

```swift
func f(x: Int = 42) -> Int { return x }
f()       // 유효, 기본 값 사용
f(x: 7)   // 유효, 제공한 값 사용
f(7)      // 무효, 인자 이름표가 빠짐
```

#### Special Kinds of Methods (특수한 종류의 메소드)

`self` 를 수정하는 열거체나 구조체의 메소드엔 반드시 `mutating` 선언 수정자를 표시해야 합니다.

상위 클래스 메소드를 재정의한 메소드엔 반드시 `override` 선언 수정자를 표시해야 합니다. `override` 수정자 없이 메소드를 재정의하거나 상위 클래스 메소드를 재정의하지 않는 메소드에 `override` 수정자를 사용하면 컴파일-시간 에러입니다.

타입의 인스턴스라기 보단 타입 (자체에) 결합된 메소드는 반드시 열거체와 구조체라면 `static` 선언 수정자를, 클래스라면 `static` 이나 `class` 선언 수정자를 표시해야 합니다. `class` 선언 수정자로 표시한 클래스 타입 메소드는 하위 클래스 구현에서 재정의할 수 있으며; `class final` 이나 `static` 으로 표시한 클래스 타입 메소드는 재정의할 수 없습니다.

#### Methods with Special Names (특수한 이름의 메소드)

특수한 이름의 여러가지 메소드로 함수 호출 구문을 수월하게 할 수 있습니다. 타입에서 이 메소드 중 하나를 정의하면, 타입의 인스턴스를 함수 호출 구문에 사용할 수 있습니다. 함수 호출은 그 인스턴스의 특수 이름 메소드 중 하나를 호출하는 걸로 이해합니다.

클래스나, 구조체, 또는 열거체 타입은, [dynamicCallable (동적으로 호출 가능)]({% post_url 2020-08-14-Attributes %}#dynamiccallable-동적으로-호출-가능) 에서 설명한 것처럼, `dynamicallyCall(withArguments:)` 메소드나 `dynamicallyCall(withKeywordArguments:)` 메소드를 정의함으로써, 또는 아래 설명 처럼, 함수-처럼-호출하는 메소드를 정의함으로써, 함수 호출 구문을 지원할 수 있습니다. 타입에서 함수-처럼-호출하는 메소드와 `dynamicCallable` 특성의 메소드를 둘 다 정의하면, 어느 메소드든 사용할 수 있는 상황에선 컴파일러가 함수-처럼-호출하는 메소드에 우선권을 줍니다.

함수-처럼-호출하는 메소드의 이름은 `callAsFunction()` 이거나, 아니면 `callAsFunction(` 으로 시작하고 이름표가 있거나 없는 인자를 추가한 이름입니다-예를 들어, `callAsFunction(_:_:)` 과 `callAsFunction(something:)` 모두 함수-처럼-호출하는 메소드 이름으로 유효합니다.

다음의 함수 호출들은 서로 같은 겁니다:

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

함수-처럼-호출하는 메소드와 `dynamicCallable` 특성인 메소드 사이에는 얼마나 많은 정보를 타입 시스템에 부호화 (encode) 해서 넣을 것인지 그리고 실행 시간에 얼마나 많은 동적 동작이 가능한지에 대해서 서로 다르게 절충 (trade-offs) 합니다. 함수-처럼-호출하는 메소드를 선언할 땐, 인자의 개수와, 각각의 인자 타입과 이름표를 지정합니다. `dynamicCallable` 특성인 메소드는 인자 배열을 들고 있는데 쓸 타입만을 지정합니다.

함수-처럼-호출하는 메소드나, `dynamicCallable` 특성인 메소드를 정의한다고, 함수 호출 표현식이 아닌 곳에서 그 타입의 인스턴스를 마치 함수인 것처럼 사용할 수 있는 건 아닙니다. 예를 들면 다음과 같습니다:

```swift
let someFunction1: (Int, Int) -> Void = callable(_:scale:)  // 에러
let someFunction2: (Int, Int) -> Void = callable.callAsFunction(_:scale:)
```

[dynamicMemberLookup (동적으로 멤버 찾아보기)]({% post_url 2020-08-14-Attributes %}#dynamicmemberlookup-동적으로-멤버-찾아보기) 에서 설명한 것처럼, `subscript(dynamicMemberLookup:)` 첨자는 멤버 찾아보기 구문을 수월하게 할 수 있습니다.

#### Throwing Functions and Methods (던지는 함수와 메소드)

에러를 던질 수 있는 함수와 메소드엔 반드시 `throws` 키워드를 표시해야 합니다. 이러한 함수와 메소드를 _던지는 함수 (throwing functions)_ 와 _던지는 메소드 (throwing methods)_ 라고 합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;func `function name-함수 이름`(`parameters-매개 변수`) throws -> `return type-반환 타입` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

던지는 함수나 메소드 호출문은 반드시 `try` 나 `try!` 표현식 (즉, `try` 나 `try!` 연산자 영역) 으로 감싸야 합니다.

`throws` 키워드는 함수 타입의 일부이며, 던지지 않는 함수는 던지는 함수의 하위 타입입니다. 그 결과, 던지는 함수를 예상한 곳에서 던지지 않는 함수를 사용할 수도 있습니다.

함수가 에러를 던질 수 있는지만을 기초로 함수를 중복 정의할 순 없습니다.[^throw-overload] 그렇더라도, 함수의 _매개 변수 (parameter)_ 가 에러를 던질 수 있는지를 기초로는 함수를 중복 정의할 수 있습니다.

던지는 메소드는 던지지 않는 메소드를 재정의할 수도 없고, 던지지 않는 메소드에 대한 프로토콜 필수 조건을 던지는 메소드로 만족할 수도 없습니다. 그렇더라도, 던지지 않는 메소드는 던지는 메소드를 재정의할 수 있고, 던지는 메소드에 대한 프로토콜 필수 조건을 던지지 않는 메소드로 만족할 수도 있습니다.[^throwing-nonthrowing]

#### Rethrowing Functions and Methods (다시 던지는 함수와 메소드)

함수나 메소드를 `rethrows` 키워드로 선언하면 함수 매개 변수 중 하나가 에러를 던지는 경우에만 에러를 던진다고 지시할 수 있습니다. 이러한 함수와 메소드를 _다시 던지는 함수 (rethrowing functions)_ 와 _다시 던지는 메소드 (rethrowing methods)_ 라고 합니다. 다시 던지는 함수와 메소드엔는 반드시 적어도 하나의 던지는 함수 매개 변수가 있어야 합니다:

```swift
func someFunction(callback: () throws -> Void) rethrows {
  try callback()
}
```

다시 던지는 함수나 메소드는 `catch` 절 안에서만 `throw` 문을 담을 수 있습니다. 이는 던지는 함수 호출을 `do`-`catch` 문 안에서 하게 하고 `catch` 절의 에러 처리를 또 다른 에러를 던지는 걸로 하게 해줍니다. 이에 더해, `catch` 절은 반드시 다시 던지는 함수의 던지는 매개 변수가 던진 에러만 처리해야 합니다. 예를 들어, 다음은 `catch` 절이 `alwaysThrows()` 가 던진 에러도 처리할 것이기 때문에 무효입니다.

```swift
func alwaysThrows() throws {
  throw SomeError.error
}
func someFunction(callback: () throws -> Void) rethrows {
  do {
    try callback()
    try alwaysThrows()  // 무효, alwaysThrows() 는 던지는 매개 변수가 아님
  } catch {
    throw AnotherError.error
  }
}
```

던지는 메소드는 다시 던지는 메소드를 재정의할 수도 없고, 다시 던지는 메소드에 대한 프로토콜 필수 조건을 던지는 메소드로 만족할 수도 없습니다. 그렇더라도, 다시 던지는 메소드는 던지는 메소드를 재정의 할 수 있고, 던지는 메소드에 대한 프로토콜 필수 조건을 다시 던지는 메소드로 만족할 수도 있습니다.[^rethrowing-function]

#### Asynchronous Functions and Methods (비동기 함수와 메소드)

비동기로 실행하는 함수와 메소드엔 반드시 `async` 키워드를 표시해야 합니다. 이러한 함수와 메소드를 _비동기 함수 (asynchronous functions)_ 와 _비동기 메소드 (asynchronous methods)_ 라고 합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;func `function name-함수 이름`(`parameters-매개 변수`) async -> `return type-반환 타입` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

비동기 함수나 메소드 호출문은 반드시 `await` 표현식으로 감싸야 합니다-즉, 반드시 `await` 연산자 영역 안에 있어야 합니다. 

`async` 키워드는 함수 타입의 일부이며, 동기 함수[^synchronous-function] 는 비동기 함수의 하위 타입입니다. 그 결과, 비동기 함수를 예상한 곳에서 동기 함수를 사용할 수도 있습니다. 예를 들어, 비동기 메소드를 동기 메소드로 재정의할 수도 있고, 비동기 메소드를 요구한 프로토콜 필수 조건을 동기 메소드로 만족할 수도 있습니다. 

함수가 비동기 인지 아닌지로 함수를 중복 정의할 수 있습니다. 호출한 쪽에서, 어느 중복 정의를 사용할진 상황으로 결정하는데: 비동기 상황이면, 비동기 함수를 사용하고, 동기 상황이면, 동기 함수를 사용합니다.

비동기 메소드는 동기 메소드를 재정의할 수도 없고, 동기 메소드에 대한 프로토콜 필수 조건을 비동기 메소드로 만족할 수도 없습니다. 그렇더라도, 동기 메소드는 비동기 메소드를 재정의할 수 있고, 비동기 메소드에 대한 프로토콜 필수 조건을 동기 메소드로 만족할 수도 있습니다.

#### Functions that Never Return (절대 반환하지 않는 함수)

스위프트는 `Never` 타입을 정의하여, 자신을 호출한 쪽으로 반환하지 않는 함수나 메소드를 지시합니다. `Never` 반환 타입인 함수와 메소드를 _반환하지 않는 (nonreturning)_ 거라고 합니다. 반환하지 않는 함수와 메소드는 복구할 수 없는 에러를 일으키거나 무한정 계속하는 일렬로 나열된 작업을 시작합니다.[^indefinitely] 이는 다른 경우라면 호출 바로 뒤에 실행될 코드를 절대 실행하지 않는다는 의미입니다. 던지는 및 다시 던지는 함수는, 자신이 반환하지 않더라도, 적절한 `catch` 절로 프로그램 제어를 옮길 순 있습니다.

[Guard Statement (guard 문)]({% post_url 2020-08-20-Statements %}#guard-statement-guard-문) 에서 논의한 것처럼, 반환하지 않는 함수나 메소드를 호출하여 'guard' 문의 `else` 절로 결론지어 끝낼 수 있습니다.

반환하지 않는 메소드를 재정의할 순 있지만, 새 메소드는 반드시 자신의 반환 타입과 반환하지 않는다는 동작을 보존해야 합니다.

> GRAMMAR OF A FUNCTION DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID362)

### Enumeration Declaration (열거체 선언)

_열거체 선언 (enumeration declaration)_ 은 프로그램에 이름지은 열거체 타입을 도입합니다.

열거체 선언엔 두 개의 기초 형식이 있으며 `enum` 키워드로 선언합니다. 어느 형식의 열거체 선언 본문이든 0 개 이상의-_열거체 case (enumeration cases)_ 라는-값을 담고 있는데, 여기엔 계산 속성과, 인스턴스 메소드, 타입 메소드, 초기자, 타입 별명, 및 심지어 다른 열거체와, 구조체, 클래스, 및 행위자 선언도 포함합니다. 열거체 선언에 정리자나 프로토콜 선언을 담을 순 없습니다.

열거체 타입은 어떤 개수의 프로토콜이든 채택할 수 있지만, 클래스나, 구조체, 또는 다른 열거체를 상속할 순 없습니다.

클래스 및 구조체와는 달리, 열거체 타입엔 암시적으로 제공하는 기본 초기자가 없으며; 모든 초기자는 반드시 명시적으로 선언해야 합니다. 초기자는 열거체 안의 다른 초기자에 일을-맡길 수 있지만, 초기자가 `self` 에 열거체 case 중 하나를 할당한 후에만 초기화 과정을 완료합니다.

구조체와 같지만 클래스와는 달리, 열거체는 값 타입이며; 열거체의 인스턴스는 변수나 상수에 할당할 때나, 함수 호출의 인자로 전달할 때, 복사됩니다. 값 타입에 대한 정보는, [Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#structures-and-enumerations-are-value-types-구조체와-열거체는-값-타입입니다) 부분을 보도록 합니다.

[Extension Declaration (익스텐션 선언)](#extension-declaration-익스텐션-선언) 에서 논의한 것처럼, 익스텐션 선언으로 열거체 타입의 동작을 확장할 수 있습니다.

#### Enumerations with Cases of Any Type (어떤 타입의 case 든 가지는 열거체)

다음 형식으로 선언한 열거체 타입은 어떤 타입의 열거체 case 든 담습니다:

&nbsp;&nbsp;&nbsp;&nbsp;enum `enumeration name-열거체 이름`: `adopted protocols-채택한 프로토콜` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case `enumeration case 1-열거체 case 값 1`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case `enumeration case 2-열거체 case 값 2`(`associated value types-결합 값 타입`)<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

이런 형식으로 선언한 열거체를 다른 프로그래밍 언어에서는 _discriminated unions (차별화된 공용체)_ 라고도 합니다.

이 형식에선, 각각의 case 블럭을 `case` 키워드와 그 뒤에, 쉼표로 구분한, 하나 이상의 열거체 case 로 구성합니다. 각각의 case 이름은 반드시 유일해야 합니다. 각각의 case 가 주어진 타입의 값을 저장한다고 지정할 수도 있습니다.[^specify-store] case 이름 바로 뒤의, _결합 값 타입 (associated value types)_ 튜플 안에 이러한 타입을 지정합니다.

결합 값을 저장한 열거체 case 는 지정한 결합 값으로 열거체 인스턴스를 생성하는 함수처럼 사용할 수 있습니다. 그리고 함수인 것 같이, 열거체 case 로의 참조를 가질 수도 나중에 이를 코드에 적용할 수도 있습니다.

```swift
enum Number {
  case integer(Int)
  case real(Double)
}
let f = Number.integer
// f 는 (Int) -> Number 타입의 함수임

// f 를 적용하여 정수 값으로 Number 인스턴스 배열을 생성함
let evenInts: [Number] = [0, 2, 4, 6].map(f)
```

결합 값 타입이 있는 case 에 대한 더 많은 정보와 예제를 보려면, [Associated Values (결합 값)]({% post_url 2020-06-13-Enumerations %}#associated-values-결합-값) 부분을 보도록 합니다.

**Enumerations with Indirection (간접을 가지는 열거체)**

열거체는 재귀 구조, 즉, 결합 값이 열거체 타입 그 자체의 인스턴스인 case, 를 가질 수 있습니다.[^recursive-structure] 하지만, 열거체 타입 인스턴스는 값 의미 구조를 가지며, 이는 메모리 안에 고정 구획을 가진다는 의미입니다.[^fixed-layout] 재귀를 지원하려면, 컴파일러가 반드시 간접 계층을 집어 넣어야 합니다.[^layer-of-indirection] 

특별한 한 열거체 case 가 간접할 수 있게 하려면, 거기에 `indirect` 선언 수정자를 표시합니다. 간접 case 엔 반드시 결합 값이 있어야 합니다.

```swift
enum Tree<T> {
  case empty
  indirect case node(value: T, left: Tree, right: Tree)
}
```

결합 값이 있는 모든 열거체 case 가 간접할 수 있게 하려면, 전체 열거체에 `indirect` 수정자를 표시합니다-열거체가 `indirect` 수정자를 표시해야 할 case 를 많이 담고 있을 때 편리합니다.

`indirect` 수정자로 표시한 열거체는 결합 값이 있는 case 와 그렇지 않은 case 를 섞어서 담을 수 있습니다. 그렇더라도, `indirect` 수정자를 표시한 어떤 case 를 다시 담을 순 없습니다.

#### Enumerations with Cases of a Raw-Value Type (원시-값 타입의 case 를 가지는 열거체)

다음 형식으로 선언한 열거체 타입은 동일한 기초 타입의 열거체 case 를 담습니다:

&nbsp;&nbsp;&nbsp;&nbsp;enum `enumeration name-열거체 이름`: `raw-value type-원시-값 타입`, `adopted protocols-채택한 프로토콜` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case `enumeration case 1-열거체 case 값 1` = `원시 값 1-raw value 1`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case `enumeration case 2-열거체 case 값 2` = `원시 값 2-raw value 2`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

이 형식에선, 각각의 case 블럭을 `case` 키워드와 그 뒤에, 쉼표로 구분한, 하나 이상의 열거체 case 로 구성합니다. 첫 번째 형식의 case 와는 달리, 각각의 case 는, _원시 값 (raw value)_ 이라는, 동일한 기초 타입의, 실제 값을 가집니다. 이러한 값의 타입은 _원시-값 타입 (raw-value type)_ 에서 정하며 반드시 정수나, 부동-소수점 수, 문자열, 또는 단일 문자를 나타내야 합니다. 특히, _원시-값 타입 (raw-value type)_ 은 `Equatable` 프로토콜과 다음의 프로토콜 중 하나를 반드시 준수해야 하는데: 정수 글자 값이면 `ExpressibleByIntegerLiteral`, 부동-소수점 글자 값이면 `ExpressibleByFloatLiteral`, 어떤 개수의 문자든 담는 문자열 글자 값이면 `ExpressibleByStringLiteral`, 단 하나의 문자만 담는 문자열 글자 값이면 `ExpressibleByUnicodeScalarLiteral` 또는 `ExpressibleByExtendedGraphemeClusterLiteral` 이 그것입니다. 각각의 case 는 반드시 유일한 이름을 가지고 유일한 원시 값을 할당해야 합니다.

원시-값 타입을 `Int` 로 정했는데 case 값을 명시하지 않으면, `0`, `1`, `2`, 등의 값을 암시적으로 할당합니다. 할당 안한 각각의 `Int` 타입 case 엔 이전 case 원시 값에서 자동 증가한 원시 값을 암시적으로 할당합니다.

```swift
enum ExampleEnum: Int {
  case a, b, c = 5, d
}
```

위 예제에서, `ExampleEnum.a` 의 원시 값은 `0` 이고 `ExampleEnum.b` 값은 `1` 입니다. 그리고 `ExampleEnum.c` 값은 `5` 로 명시하여 설정했기 때문에, `ExampleEnum.d` 값은 따라서 `5` 에서 자동 증가한 `6` 입니다.

원시-값 타입을 `String` 으로 정했는데 case 값을 명시하지 않으면, 할당 안한 각각의 case 엔 그 case 이름과 똑같은 글자의 문자열을 암시적으로 할당합니다.

```swift
enum GamePlayMode: String {
  case cooperative, individual, competitive
}
```

위 예제에서, `GamePlayMode.cooperative` 의 원시 값은 `"cooperative"` 이고, `GamePlayMode.individual` 의 원시 값은 `"individual"` 이며, `GamePlayMode.competitive` 의 원시 값은 `"competitive"` 입니다.

원시-값 타입의 case 를 가진 열거체는 암시적으로, 스위프트 표준 라이브러리에서 정의한, `RawRepresentable` 프로토콜을 준수합니다. 그 결과, `rawValue` 속성과 `init?(rawValue: RawValue)` 라는 서명[^signature] 의 실패 가능 초기자를 가집니다. `ExampleEnum.b.rawValue` 처럼, `rawValue` 속성을 사용하여 열거체 case 의 원시 값에 접근할 수 있습니다. 원시 값을 사용하여 해당하는 case 를 찾을 수도 있으며, 하나가 있다면, `ExampleEnum(rawValue: 5)` 처럼, 열거체의 실패 가능 초기자를 호출하면 되는데, 이는 옵셔널 case 를 반환합니다. 원시-값 타입을 가지는 case 에 대한 더 많은 정보와 예제를 보려면, [Raw Values (원시 값)]({% post_url 2020-06-13-Enumerations %}#raw-values-원시-값) 부분을 보기 바랍니다.

#### Accessing Enumeration Cases (열거체 case 에 접근하기)

열거체 타입의 case 를 참조하려면, `EnumerationType.enumerationCase` 처럼, 점 (`.`) 구문을 사용합니다. [Enumeration Syntax (열거체 구문)]({% post_url 2020-06-13-Enumerations %}#enumeration-syntax-열거체-구문) 과 [Implicit Member Expression (암시적 멤버 표현식)]({% post_url 2020-08-19-Expressions %}#implicit-member-expression-암시적-멤버-표현식) 에서 설명한 것처럼, 열거체 타입을 추론할 수 있는 상황일 땐, 이를 생략할 수 있습니다 (점은 여전히 필수입니다).

열거체 case 의 값을 검사하려면, [Matching Enumeration Values with a Switch Statement (switch 문으로 열거체 값 맞춰보기)]({% post_url 2020-06-13-Enumerations %}#matching-enumeration-values-with-a-switch-statement-switch-문으로-열거체-값-맞춰보기) 에서 본 것처럼, `switch` 문을 사용합니다. [Enumeration Case Pattern (열거체 case 패턴)]({% post_url 2020-08-25-Patterns %}#enumeration-case-pattern-열거체-case-패턴) 에서 설명한 것처럼, 열거체 타입은 `switch` 문 case 블럭 안의 열거체 case 패턴과 패턴을-맞춰봅니다.

> GRAMMAR OF AN ENUMERATION DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID364)

### Structure Declaration (구조체 선언)

_구조체 선언 (structure declaration)_ 은 프로그램에 이름지은 구조체 타입을 도입합니다. 구조체 선언은 `struct` 키워드로 하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;struct `structure name-구조체 이름`: `adopted protocols-채택한 프로토콜` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`declarations-선언`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

구조체 본문은 0 개 이상의 _선언 (declarations)_ 을 담습니다. 이러한 _선언 (declarations)_ 은 저장 및 계산 속성 둘 다와, 타입 속성, 인스턴스 메소드, 타입 메소드, 초기자, 첨자, 타입 별명, 및 심지어 다른 구조체와, 클래스, 행위자, 및 열거체 선언을 포함할 수 있습니다. 구조체 선언에 정리자나 프로토콜 선언을 담을 순 없습니다. 다양한 종류의 선언을 포함한 구조체에 대한 논의 및 여러 가지 예제는, [Structures and Classes (구조체와 클래스)]({% post_url 2020-04-14-Structures-and-Classes %}) 장을 보기 바랍니다.

구조체 타입은 어떤 개수의 프로토콜도 채택할 수 있지만, 클래스나, 열거체, 또는 다른 구조체를 상속할 순 없습니다.

이전에 선언한 구조체로 인스턴스를 생성하는 데는 세 가지 방법이 있습니다:

* [Initializers (초기자)]({% post_url 2016-01-23-Initialization %}#initializers-초기자) 에서 설명한 처럼, 구조체 안에 선언한 초기자 중 하나를 호출합니다.
* 아무런 초기자도 선언하지 않은 경우, [Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)]({% post_url 2016-01-23-Initialization %}#memberwise-initializers-for-structure-types-구조체-타입을-위한-멤버-초기자) 에서 설명한 것처럼, 구조체의 멤버 초기자를 호출합니다.
* 아무런 초기자도 선언하지 않았으나, 구조체 선언의 모든 속성에 초기 값을 준 경우, [Default Initializers (기본 초기자)]({% post_url 2016-01-23-Initialization %}#default-initializers-기본-초기자) 에서 설명한 것처럼, 구조체의 기본 초기자를 호출합니다.

구조체에서 선언한 속성의 초기화 과정은 [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 에서 설명합니다.

[Accessing Properties (속성에 접근하기)]({% post_url 2020-04-14-Structures-and-Classes %}#accessing-properties-속성에-접근하기) 에서 설명한 것처럼, 점 (`.`) 구문으로 구조체 인스턴스의 속성에 접근할 수 있습니다.

구조체는 값 타입이며; 변수나 상수에 할당할 때, 또는 함수 호출의 인자로 전달할 때, 구조체 인스턴스가 복사됩니다. 값 타입에 대한 정보는, [Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#structures-and-enumerations-are-value-types-구조체와-열거체는-값-타입입니다) 부분을 보기 바랍니다.

[Extension Declaration (익스텐션 선언)](#extension-declaration-익스텐션-선언) 에서 논의한 것처럼, 익스텐션 선언으로 구조체 타입의 동작을 확장할 수 있습니다.

> GRAMMAR OF A STRUCTURE DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID367)

### Class Declaration (클래스 선언)

_클래스 선언 (class declaration)_ 은 프로그램에 이름지은 클래스 타입을 도입합니다. 클래스 선언은 `class` 키워드로 하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;class `class name-클래스 이름`: `superclass-상위 클래스`, `adopted protocols-채택한 프로토콜` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`declarations-선언`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

클래스 본문은 0 개 이상의 _선언 (declaration)_ 을 담습니다. 이러한 _선언 (declarations)_ 은 저장 및 계산 속성 둘 다와, 인스턴스 메소드, 타입 메소드, 초기자, 단일한 정리자, 첨자, 타입 별명, 및 심지어 다른 클래스, 구조체, 행위자, 및 열거체 선언을 포함할 수 있습니다. 클래스 선언에 프로토콜 선언을 담을 순 없습니다. 다양한 종류의 선언을 포함한 클래스에 대한 논의 및 여러 가지 예제는, [Structures and Classes (구조체와 클래스)]({% post_url 2020-04-14-Structures-and-Classes %}) 장을 보기 바랍니다.

클래스 타입은, 자신의 _상위 클래스 (superclass)_ 라는, 단 하나의 부모 클래스만 상속할 수 있지만, 프로토콜은 어떤 개수든 채택할 수 있습니다. _클래스 이름 (class anme)_ 과 콜론 뒤에 _상위 클래스 (superclass)_ 를 첫 번째로 나타내고, 그 뒤에 _채택한 프로토콜 (adopted protocols)_ 을 둡니다. 일반화 (generic) 클래스는 다른 일반화 및 일반화 아닌 클래스를 상속할 수 있지만, 일반화 아닌 (nongeneric) 클래스는 다른 일반화 아닌 클래스만 상속할 수 있습니다. 콜론 뒤에 일반화 상위 클래스 이름을 쓸 때는, 반드시 그 일반화 클래스의 전체 이름을 포함해야 해서, 일반화 매개 변수 절도 포함해야 합니다.

[Initializer Declaration (초기자 선언)](#initializer-declaration-초기자-선언) 에서 논의한 것처럼, 클래스엔 지명 초기자와 편의 초기자가 있을 수 있습니다. 클래스의 지명 초기자는 반드시 클래스가 선언한 모든 속성을 초기화해야 하며 그걸 반드시 상위 클래스의 지명 초기자 호출 전에 해야 합니다.

클래스는 상위 클래스의 속성과, 메소드, 첨자, 및 초기자를 재정의할 수 있습니다. 재정의한 속성과, 메소드, 첨자, 및 지명 초기자[^designated-initializers] 엔 반드시 `override` 선언 수정자를 표시해야 합니다.

하위 클래스가 상위 클래스 초기자를 구현하길 요구하려면, 상위 클래스 초기자에 `required` 선언 수정자를 표시합니다. 그 초기자의 하위 클래스 구현에도 반드시 `required` 선언 수정자를 표시해야 합니다.

_상위 클래스 (superclass)_ 에서 선언한 속성과 메소드를 현재 클래스가 상속하긴 하지만, _상위 클래스 (superclass)_ 에서 선언한 지명 초기자는 [Automatic Initializer Inheritance (자동적인 초기자 상속)]({% post_url 2016-01-23-Initialization %}#automatic-initializer-inheritance-자동적인-초기자-상속) 의 설명 조건과 만날 때만 하위 클래스가 상속합니다. 스위프트 클래스는 범용 기초 클래스를 상속하지 않습니다.[^universal-base-class] 

이전에 선언한 클래스로 인스턴스를 생성하는 데는 두 가지 방법이 있습니다:

* [Initializers (초기자)]({% post_url 2016-01-23-Initialization %}#initializers-초기자) 에서 설명한 것처럼, 클래스 안에 선언한 초기자 중 하나를 호출합니다.
* 아무런 초기자도 선언하지 않았으나, 클래스 선언의 모든 속성에 초기 값을 준 경우, [Default Initializers (기본 초기자)]({% post_url 2016-01-23-Initialization %}#default-initializers-기본-초기자) 에서 설명한 것처럼, 클래스의 기본 초기자를 호출합니다.

[Accessing Properties (속성에 접근하기)]({% post_url 2020-04-14-Structures-and-Classes %}#accessing-properties-속성에-접근하기) 에서 설명한 것처럼, 점 (`.`) 구문으로 클래스 인스턴스의 속성에 접근할 수 있습니다.

클래스는 참조 타입이며; 변수나 상수에 할당할 때, 또는 함수 호출의 인자로 전달할 때, 클래스 인스턴스를, 복사하기 보단, 참조합니다. 참조 타입에 대한 정보는, [Classes Are Reference Types (클래스는 참조 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#classes-are-reference-types-클래스는-참조-타입입니다) 부분을 보기 바랍니다.

[Extension Declaration (익스텐션 선언)](#extension-declaration-익스텐션-선언) 에서 논의한 것처럼, 익스텐션 선언으로 클래스 타입의 동작을 확장할 수 있습니다.

> GRAMMAR OF A CLASS DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID368)

### Actor Declaration (행위자 선언)

_행위자 선언 (actor declaration)_ 은 프로그램에 이름지은 행위자 타입을 도입합니다. 행위자 선언은 `actor` 키워드로 하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;actor `actor name-행위자 이름`: `adopted protocols-채택한 프로토콜` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`declarations-선언`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

행위자 본문은 0 개 이상의 _선언 (declarations)_ 을 담습니다. 이러한 _선언 (declarations)_ 은 저장 및 계산 속성 둘 다와, 인스턴스 메소드, 타입 메소드, 초기자, 단일한 정리자, 첨자, 타입 별명, 및 심지어 다른 클래스와, 구조체, 및 열거체 선언을 포함할 수 있습니다. 다양한 종류의 선언을 포함한 행위자에 대한 논의 및 여러 가지 예제는, [Actors (행위자)]({% post_url 2021-06-10-Concurrency %}#actors-행위자) 부분을 보기 바랍니다.

행위자 타입은 어떤 개수의 프로토콜이든 채택할 수 있지만, 클래스나, 열거체, 구조체, 또는 다른 행위자를 상속할 수 없습니다. 하지만, `@objc` 특성을 표시한 행위자는 암시적으로 `NSObjectProtocol` 프로토콜을 준수하며 오브젝티브-C 런타임에서 `NSObject` 의 하위 타입으로 드러납니다.

이전에 선언한 행위자로 인스턴스를 생성하는 데는 두 가지 방법이 있습니다:

* [Initializers (초기자)]({% post_url 2016-01-23-Initialization %}#initializers-초기자) 에서 설명한 것처럼, 행위자 안에 선언한 초기자 중 하나를 호출합니다.
* 아무런 초기자도 선언하지 않았으나, 행위자 선언의 모든 속성에 초기 값을 준 경우, [Default Initializers (기본 초기자)]({% post_url 2016-01-23-Initialization %}#default-initializers-기본-초기자) 에서 설명한 것처럼, 행위자의 기본 초기자를 호출합니다.

기본적으로, 행위자의 멤버는 그 행위자로 격리됩니다.[^isolate] 메소드 본문이나 속성 획득자 같은, 코드는 그 행위자 위에서 실행합니다. 행위자 안의 코드는 이미 동일한 행위자 위에서 실행하고 있기 때문에 서로 동기로 상호 작용할 수 있지만, 행위자 밖의 코드엔 반드시 `await` 를 표시해서 이 코드가 다른 행위자 위에서 비동기로 실행 중이라는 걸 지시해야 합니다. 키 경로 (key paths) 는 행위자의 격리 멤버를 참조할 수 없습니다. 행위자로-격리한 저장 속성을 동기 함수의 입-출력 매개 변수로 전달할 순 있지만, 비동기 함수로는 안됩니다. 

행위자는 격리 안한 멤버도 가질 수 있는데, 이들의 선언엔 `nonisolated` 키워드를 표시합니다. 격리 안한 멤버는 행위자 밖의 코드 처럼 실행하는데: 행위자의 어떤 격리 상태와도 상호 작용할 수 없으며, 호출하는 쪽에서 사용할 때 `await` 를 표시하지 않습니다.

행위자의 멤버는 그게 격리 안한 것이나 비동기인 경우에만 `@objc` 특성을 표시할 수 있습니다. 

행위자가 선언한 속성의 초기화 과정은 [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 에서 설명합니다.

[Accessing Properties (속성에 접근하기)]({% post_url 2020-04-14-Structures-and-Classes %}#accessing-properties-속성에-접근하기) 에서 설명한 것처럼, 점 (`.`) 구문으로 행위자 인스턴스의 속성에 접근할 수 있습니다.

행위자는 참조 타입이며; 변수나 상수에 할당할 때, 또는 함수 호출의 인자로 전달할 때, 행위자의 인스턴스를, 복사하기 보단, 참조합니다. 참조 타입에 대한 정보는, [Classes Are Reference Types (클래스는 참조 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#classes-are-reference-types-클래스는-참조-타입입니다) 부분을 보기 바랍니다.

[Extension Declaration (익스텐션 선언)](#extension-declaration-익스텐션-선언) 에서 논의한 것처럼, 익스텐션 선언으로 행위자 타입의 동작을 확장할 수 있습니다.

> GRAMMAR OF A ACTOR DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID648)

### Protocol Declaration (프로토콜 선언)

_프로토콜 선언 (protocol declaration)_ 은 프로그램에 이름지은 프로토콜 타입을 도입합니다. 프로토콜 선언은 `protocol` 키워드로 전역에서 선언하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;protocol `protocol name-프로토콜 이름`: `inherited protocols-상속한 프로토콜` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`protocol member declarations-프로토콜 멤버 선언`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

프로토콜 본문은 0 개 이상의 _프로토콜 멤버 선언 (protocol member declarations)_ 을 담는데, 이는 어떤 프로토콜 채택 타입이든 반드시 충족해야 할 준수 필수 조건을 설명합니다. 특히, 프로토콜은 준수 타입이 반드시 구현해야 할 특정한 속성과, 메소드, 초기자, 및 첨자를 선언할 수 있습니다. 프로토콜은, _결합 타입 (associated types)_ 이라는, 특수한 종류의 타입 별명도 선언할 수 있는데, 이것으로 프로토콜의 다양한 선언들 사이의 관계를 지정할 수 있습니다. 프로토콜 선언엔 클래스나, 구조체, 열거체, 및 다른 프로토콜 선언을 담을 수 없습니다. _프로토콜 멤버 선언 (protocol member declarations)_ 은 밑에서 자세히 논의합니다.

프로토콜 타입은 다른 프로토콜을 어떤 개수든 상속할 수 있습니다. 프로토콜 타입이 다른 프로토콜을 상속할 땐, 다른 프로토콜의 필수 조건 집합을 한군데로 모으므로 (aggregated), 현재 프로토콜을 상속한 어떤 타입이든 반드시 이 모든 필수 조건을 준수해야 합니다. 프로토콜 상속 사용법에 대한 예제는, [Protocol Inheritance (프로토콜 상속)]({% post_url 2016-03-03-Protocols %}#protocol-inheritance-프로토콜-상속) 부분을 보기 바랍니다.

> [Protocol Composition Type (프로토콜 합성 타입)]({% post_url 2020-02-20-Types %}#protocol-composition-type-프로토콜-합성-타입) 과 [Protocol Composition (프로토콜 합성)]({% post_url 2016-03-03-Protocols %}#protocol-composition-프로토콜-합성) 에서 설명한 것처럼, 프로토콜 합성 타입을 사용하여 여러 프로토콜의 준수 필수 조건을 한군데로 모을 수도 있습니다.

이전에 선언한 타입에 프로토콜 준수성을 추가하려면 그 타입의 익스텐션 선언에 프로토콜을 채택하면 됩니다. 익스텐션에선, 채택한 프로토콜의 모든 필수 조건들을 반드시 구현해야 합니다. 타입이 모든 필수 조건을 이미 구현하고 있다면, 익스텐션 선언의 본문을 비워둬도 됩니다.

기본적으로, 프로토콜을 준수하는 타입은 반드시 프로토콜 안에 선언한 모든 속성과, 메소드, 및 첨자를 구현해야 합니다. 그렇더라도, 이 프로토콜 멤버 선언에 `optional` 선언 수정자를 표시하면 준수 타입의 구현부가 옵셔널임을 지정할 수 있습니다.[^optional-member] `optional` 수정자는 `objc` 특성을 표시한 멤버와, `objc` 특성을 표시한 프로토콜의 멤버에만 적용할 수 있습니다. 그 결과, 옵셔널 멤버 필수 조건을 담은 프로토콜은 클래스 타입만이 채택하고 준수할 수 있습니다. `optional` 선언 수정자의 사용법에 대한 더 많은 정보 및 옵셔널 프로토콜 멤버에 대한 접근법-예를 들어, 준수 타입이 구현했는지 확신할 수 없을 때-에 대한 본보기는, [Optional Protocol Requirements (옵셔널 프로토콜 필수 조건)]({% post_url 2016-03-03-Protocols %}#optional-protocol-requirements-옵셔널-프로토콜-필수-조건) 부분을 보기 바랍니다.

열거체 case 는 타입 멤버의 프로토콜 필수 조건을 만족할 수 있습니다. 특히, 어떤 결합 값도 없는 열거체 case 는 `Self` 타입인 읽기-전용 타입 변수의 프로토콜 필수 조건을 만족하며, 결합 값이 있는 열거체 case 는 매개 변수와 인자 이름표가 case 의 결합 값과 일치하고 `Self` 를 반환하는 함수의 프로토콜 필수 조건을 만족합니다. 예를 들면 다음과 같습니다:

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

클래스만 프로토콜을 채택하게 제약하려면, 콜론 뒤의 _상속 프로토콜 (inherited protocols)_ 목록에 `AnyObject` 프로토콜을 포함시킵니다. 예를 들어, 다음 프로토콜은 클래스 타입만 채택할 수 있습니다:

```swift
protocol SomeProtocol: AnyObject {
  /* 프로토콜 멤버는 여기에 둠 */
}
```

`AnyObject` 필수 조건을 표시한 어떤 프로토콜을 상속한 프로토콜도 마찬가지로 클래스 타입만 채택할 수 있습니다.

> 프로토콜에 `objc` 특성을 표시하면, 그 프로토콜에 `AnyObject` 필수 조건을 암시적으로 적용하므로; `AnyObject` 필수 조건을 프로토콜에 명시할 필요가 없습니다.

프로토콜은 이름 있는 타입이며, 따라서, [Protocols as Types (타입으로써의 프로토콜)]({% post_url 2016-03-03-Protocols %}#protocols-as-types-타입으로써의-프로토콜) 에서 논의한 것처럼, 다른 이름 있는 타입과 똑같은 곳의 코드에 나타날 수 있습니다. 하지만, 프로토콜로 인스턴스를 생성할 순 없는데, 프로토콜이 자신이 지정한 필수 조건의 구현을 실제로 제공하진 않기 때문입니다.

[Delegation (맡김)]({% post_url 2016-03-03-Protocols %}#delegation-맡김) 에서 설명한 것처럼, 프로토콜을 사용하면 클래스나 구조체의 일-맡은자 (delegate) 가 어느 메소드를 구현해야 하는지를 선언할 수 있습니다.

> GRAMMAR OF A PROTOCOL DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

#### Protocol Property Declaration (프로토콜 속성 선언)

프로토콜 준수 타입이 반드시 속성을 구현해야 한다고 선언하려면 프로토콜 선언 본문 안에 _프로토콜 속성 선언 (protocol property declaration)_ 을 포함하면 됩니다. 프로토콜 속성 선언은 특수한 형식의 변수 선언입니다:

&nbsp;&nbsp;&nbsp;&nbsp;var `property name-속성 이름`: `type-타입` { get set }

다른 프로토콜 멤버 선언 처럼, 이 속성 선언은 프로토콜을 준수할 타입의 획득자 및 설정자 필수 조건만 선언합니다. 그 결과, 이를 선언한 프로토콜이 획득자와 설정자를 직접 구현하진 않습니다.

준수 타입은 다양한 방식으로 획득자 및 설정자 필수 조건을 만족할 수 있습니다. 속성 선언이 `get` 과 `set` 키워드를 둘 다 포함하면, 준수 타입이 읽기 쓰기가 둘 다 가능한 (즉, 획득자와 설정자를 둘 다 구현한) 저장 변수 속성 또는 계산 속성으로 이를 구현할 수 있습니다. 하지만, 그 속성 선언을 상수 속성 또는 읽기-전용 계산 속성으로 구현할 순 없습니다. 속성 선언이 `get` 키워드만 포함하면, 어떤 종류의 속성으로도 이를 구현할 수 있습니다. 준수 타입이 프로토콜의 속성 필수 조건을 구현하는 예제는, [Property Requirements (속성 필수 조건)]({% post_url 2016-03-03-Protocols %}#property-requirements-속성-필수-조건) 부분을 보기 바랍니다.

프로토콜 선언 안에서 타입 속성 필수 조건을 선언하려면, 속성 선언에 `static` 키워드를 표시합니다. 프로토콜을 준수하는게 구조체와 열거체면 속성을 `static` 키워드로 선언하고, 프로토콜을 준수하는게 클래스면 속성을 `static` 이나 `class` 키워드로 선언합니다. 구조체나, 열거체, 또는 클래스에 프로토콜 준수성을 추가하는 익스텐션은 자신이 확장할 타입과 똑같은 키워드를 사용합니다. 타입 속성 필수 조건에 기본 구현을 제공하는 익스텐션은 `static` 키워드를 사용합니다.

[Variable Declaration (변수 선언)](#variable-declaration-변수-선언) 부분도 보기 바랍니다.

> GRAMMAR OF A PROTOCOL PROPERTY DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

#### Protocol Method Declaration (프로토콜 메소드 선언)

프로토콜 준수 타입이 반드시 메소드를 구현해야 한다고 선언하려면 프로토콜 선언 본문 안에 프로토콜 메소드 선언을 포함하면 됩니다. 프로토콜 메소드 선언의 형식은 함수 선언과 똑같으나, 두 가지 예외가 있는데: 함수 본문을 포함하지 않고, 함수 선언 부분에서 어떤 기본 매개 변수 값도 제공할 수 없다는 것이 그것입니다. 프로토콜의 메소드 필수 조건을 구현한 준수 타입 예제는, [Method Requirements (메소드 필수 조건)]({% post_url 2016-03-03-Protocols %}#method-requirements-메소드-필수-조건) 부분을 보기 바랍니다.

프로토콜 선언 안에서 클래스 및 정적 메소드 필수 조건을 선언하려면, 메소드 선언에 `static` 선언 수정자를 표시합니다. 프로토콜을 준수하는게 구조체와 열거체면 메소드를 `static` 키워드로 선언하고, 프로토콜을 준수하는게 클래스면 메소드를 `static` 이나 `class` 키워드로 선언합니다. 구조체나, 열거체, 또는 클래스에 프로토콜 준수성을 추가하는 익스텐션은 자신이 확장할 타입과 똑같은 키워드를 사용합니다. 타입 메소드 필수 조건에 기본 구현을 제공하는 익스텐션은 `static` 키워드를 사용합니다.

[Function Declaration (함수 선언)](#function-declaration-함수-선언) 부분도 보기 바랍니다.

> GRAMMAR OF A PROTOCOL METHOD DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

#### Protocol Initializer Declaration (프로토콜 초기자 선언)

프로토콜 준수 타입이 반드시 초기자를 구현해야 한다 선언하려면 프로토콜 선언 본문 안에 프로토콜 초기자 선언을 포함하면 됩니다. 프로토콜 초기자 선언은, 초기자 본문을 포함하지 않는다는 것만 제외하면, 초기자 선언과 형식이 똑같습니다.

준수 타입이 실패하지 않는 프로토콜 초기자 필수 조건을 만족하려면 실패하지 않는 초기자나 `init!` 실패 가능 초기자를 구현하면 됩니다. 준수 타입이 실패 가능 프로토콜 초기자 필수 조건을 만족하려면 어떤 종류의 초기자든 구현하면 됩니다.

클래스가 프로토콜 초기자 필수 조건을 만족하려고 초기자를 구현할 때, 이미 `final` 선언 수정자로 표시한 클래스가 아니라면, 초기자에 반드시 `required` 선언 수정자를 표시해야 합니다.

[Initializer Declaration (초기자 선언)](#initializer-declaration-초기자-선언) 부분도 보기 바랍니다.

> GRAMMAR OF A PROTOCOL INITIALIZER DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

#### Protocol Subscript Declaration (프로토콜 첨자 선언)

프로토콜 준수 타입이 반드시 첨자를 구현해야 한다고 선언하려면 프로토콜 선언 본문 안에 프로토콜 첨자 선언을 포함하면 됩니다. 프로토콜 첨자 선언은 특수한 형식의 첨자 선언입니다:

&nbsp;&nbsp;&nbsp;&nbsp;subscript (`parameters-매개 변수`) -> `return type-반환 타입` { get set }

첨자 선언은 프로토콜을 준수하는 타입에 대한 최소한의 획득자 및 설정자 구현 필수 조건만 선언합니다. 첨자 선언이 `get` 과 `set` 키워드를 둘 다 포함하면, 준수 타입은 반드시 획득자와 설정자 절을 둘 다 구현해야 합니다. 첨자 선언이 `get` 키워드만 포함하면, 준수 타입은 _적어도 (at least)_ 획득자 절은 반드시 구현해야 하며 설정자 절 구현은 옵션으로 할 수 있습니다.

프로토콜 선언 안에서 정적 첨자 필수 조건을 선언하려면, 첨자 선언에 `static` 선언 수정자를 표시합니다. 프로토콜을 준수하는게 구조체와 열거체면 첨자를 `static` 키워드로 선언하고, 프로토콜을 준수하는게 클래스면 첨자를 `static` 이나 `class` 키워드로 선언합니다. 구조체나, 열거체, 또는 클래스에 프로토콜 준수성을 추가하는 익스텐션은 자신이 확장할 타입과 똑같은 키워드를 사용합니다. 정적 첨자 필수 조건에 기본 구현을 제공하는 익스텐션은 `static` 키워드를 사용합니다.

[Subscript Declaration (첨자 선언)](#subscript-declaration-첨자-선언) 부분도 보기 바랍니다.

> GRAMMAR OF A PROTOCOL INITIALIZER DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

#### Protocol Associated Type Declaration (프로토콜의 결합 타입 선언)

프로토콜은 `associatedtype` 키워드를 사용하여 결합 타입을 선언합니다. 결합 타입은 프로토콜 선언의 일부로 사용할 타입에 별명을 제공합니다. 결합 타입은 일반화 매개 변수 절에 있는 타입 매개 변수와 비슷하지만, 자신을 선언한 프로토콜의 `Self` 와 결합되어 있습니다. 그런 상황에선, `Self` 가 프로토콜을 준수한 최종 결과 타입 (eventual type) 을 참조합니다. 더 많은 정보와 예제는, [Associated Types (결합 타입)]({% post_url 2020-02-29-Generics %}#associated-types-결합-타입) 부분을 보기 바랍니다.

프로토콜 선언에선, 결합 타입의 재-선언 없이, 일반화 `where` 절로 다른 프로토콜에서 상속한 결합 타입에 구속 조건을 추가합니다. 예를 들어, 밑에 있는 `SubProtocol` 선언들은 서로 같은 겁니다:

```swift
protocol SomeProtocol {
  associatedtype SomeType
}

protocol SubProtocolA: SomeProtocol {
  // 이런 구문은 경고를 만듭니다.
  associatedtype SomeType: Equatable
}

// 이 구문이 더 좋습니다.
protocol SubProtocolB: SomeProtocol where SomeType: Equatable { }
```

[Type Alias Declaration (타입 별명 선언)](#type-alias-declaration-타입-별명-선언) 부분도 보기 바랍니다.

> GRAMMAR OF A PROTOCOL ASSOCIATED TYPE DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

### Initializer Declaration (초기자 선언)

_초기자 선언 (initializer declaration)_ 은 프로그램에 클래스나, 구조체, 또는 열거체의 초기자를 도입합니다. 초기자 선언은 `init` 키워드로 하며 두 가지 기초 형식이 있습니다.

구조체와, 열거체, 및 클래스 타입엔 초기자가 어떤 개수든 있을 수 있지만, 클래스 초기자들에선 규칙과 결합 동작이 다릅니다. 구조체 및 열거체와는 달리, 클래스엔 두 종류의 초기자가 있는데: [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 에서 설명한, 지명 초기자와 편의 초기자가 그것입니다.

다음 형식으론 구조체와, 열거체의 초기자, 및 클래스의 지명 초기자를 선언합니다:

&nbsp;&nbsp;&nbsp;&nbsp;init (`parameters-매개 변수`) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

클래스의 지명 초기자는 모든 클래스 속성을 직접 초기화합니다. 이는 같은 클래스에 있는 어떤 다른 초기자도 호출할 수 없으며, 클래스에 상위 클래스가 있으면, 반드시 상위 클래스 지명 초기자를 호출해야 합니다. 클래스가 상위 클래스에서 어떤 속성이든 상속했으면, 반드시 상위 클래스 지명 초기자를 호출하고 나야 현재 클래스에서 그 속성을 설정할 수 있습니다.

지명 초기자는 클래스 선언 상황에서면 선언할 수 있으므로 익스텐션 선언으로 클래스에 추가할 순 없습니다.

구조체와 열거체 안의 초기자는 선언한 다른 초기자를 호출하여 일부 또는 전체 초기화 과정을 맡길 수 있습니다.

클래스의 편의 초기자를 선언하려면, 초기자 선언에 `convenience` 선언 수정자를 표시합니다.

&nbsp;&nbsp;&nbsp;&nbsp;convenience init (`parameters-매개 변수`) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

편의 초기자는 또 다른 편의 초기자나 클래스의 지명 초기자로 초기화 과정을 맡길 수 있습니다. 그렇더라도, 초기화 과정은 반드시 지명 초기자 호출로 끝나야 궁극적으로 클래스 속성을 초기화하게 됩니다. 편의 초기자는 상위 클래스 초기자를 호출할 수 없습니다.

지명 및 편의 초기자에 `required` 선언 수정자를 표시하면 모든 하위 클래스가 초기자를 (필수로) 구현하길 요구합니다. 그 초기자의 하위 클래스 구현부에도 반드시 `required` 선언 수정자를 표시해야 합니다.

기본적으로, 상위 클래스 안에 선언한 초기자를 하위 클래스가 상속하진 않습니다. 그렇더라도, 하위 클래스가 자신의 모든 저장 속성을 기본 값으로 초기화하면서 자기 자신은 어떤 초기자도 직접 정의하지 않으면, 상위 클래스의 모든 초기자를 상속합니다. 하위 클래스가 상위 클래스의 모든 지명 초기자를 재정의하면, 상위 클래스의 편의 초기자를 상속합니다.

메소드와, 속성, 및 첨자에서 처럼, 재정의한 지명 초기자엔 `override` 선언 수정자를 표시할 필요가 있습니다.

> 초기자에 `required` 선언 수정자를 표시하면, 하위 클래스에서 필수 초기자를 재정의할 때 초기자에 `override` 수정자도 표시하지 않습니다.[^required-override]

함수와 메소드인 것 같이, 초기자도 에러를 던지거나 다시 던질 수 있습니다. 그리고 함수와 메소드인 것 같이, 초기자의 매개 변수 뒤에 `throws` 나 `rethrows` 키워드를 써서 적절한 동작을 지시합니다. 마찬가지로, 초기자는 비동기일 수 있으며, `async` 키워드로 이를 지시합니다.

다양한 타입 선언 안의 초기자 예제를 보려면, [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 를 보기 바랍니다.

#### Failable Initializers (실패 가능 초기자)

_실패 가능 초기자 (failable initializer)_ 는 초기자를 선언한 타입의 옵셔널 인스턴스나 암시적으로 포장 푸는 옵셔널 인스턴스를 만들어 내는 타입의 초기자입니다. 그 결과, 실패 가능 초기자는 `nil` 을 반환하여 초기화 실패를 지시할 수 있습니다.

옵셔널 인스턴스를 만드는 실패 가능 초기자를 선언하려면, 초기자 선언의 `init` 키워드에 물음표를 덧붙입니다 (`init?`). 암시적으로 포장 푸는 옵셔널 인스턴스를 만드는 실패 가능 초기자를 선언하려면, 그 대신 느낌표를 덧붙입니다 (`init!`). 아래 예제는 `init?` 실패 가능 초기자로 구조체의 옵셔널 인스턴스를 만드는 걸 보여줍니다.

```swift
struct SomeStruct {
  let property: String
  // 'SomeStruct' 의 옵셔널 인스턴스를 만듦
  init?(input: String) {
    if input.isEmpty {
      // 'self' 를 버리고 'nil' 을 반환함
      return nil
    }
    property = input
  }
}
```

`init?` 실패 가능 초기자는, 반드시 결과를 옵셔널로 다룬다는 것만 제외하면, 실패하지 않는 초기자 호출과 똑같은 방식으로 호출합니다.

```swift
if let actualInstance = SomeStruct(input: "Hello") {
  // 'SomeStruct' 인스턴스로 뭔가를 함
} else {
  // 'SomeStruct' 초기화가 실패하여 초기자가 'nil' 을 반환했음
}
```

실패 가능 초기자는 초기자 본문 구현부의 어떤 시점에서든 `nil` 을 반환할 수 있습니다.

실패 가능 초기자는 어떤 종류의 초기자로도 일을-맡길 수 있습니다. 실패하지 않는 초기자는 또 다른 실패하지 않는 초기자 또는 `init!` 실패 가능 초기자로 일을-맡길 수 있습니다. 실패하지 않는 초기자가 `init?` 실패 가능 초기자로 일을-맡기려면 상위 클래스 초기자의 결과를 강제-포장 풀기-예를 들어, `super.init()!` 처럼 작성-하면 됩니다.

초기화 실패는 초기자 일-맡김을 통하여 전파합니다. 특히, 실패 가능 초기자가 일을-맡긴 초기자가 실패하여 `nil` 을 반환하면, 일을-맡겼던 초기자도 실패하여 암시적으로 `nil` 을 반환합니다. 실패하지 않는 초기자가 일을-맡긴 `init!` 실패 가능 초기자가 실패하여 `nil` 을 반환하면, (마치 `!` 연산자로 `nil` 값인 옵셔널의 포장을 풀려고 한 것처럼) 실행 시간 에러가 일어납니다. 

실패 가능 지명 초기자를 하위 클래스에서 재정의하는 건 어떤 종류의 지명 초기자로도 할 수 있습니다. 실패하지 않는 지명 초기자를 하위 클래스에서 재정의하는 건 실패하지 않는 지명 초기자민 할 수 있습니다.

실패 가능 초기자에 대한 더 많은 정보와 예제를 보려면, [Failable Initializers (실패 가능 초기자)]({% post_url 2016-01-23-Initialization %}#failable-initializers-실패-가능-초기자) 부분을 보기 바랍니다.

> GRAMMAR OF AN INITIALIZER DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID375)

### Deinitializer Declaration (정리자 선언)

_정리자 선언 (deinitializer declaration)_ 은 클래스 타입의 정리자를 선언합니다. 정리자는 매개 변수를 취하지 않으며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;deinit {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

클래스 객체의 해제 직전, 더 이상 클래스 객체로의 어떤 참조도 없을 때 정리자를 자동으로 호출합니다. 정리자는 클래스 선언 본문에서만 선언할 수 있지-클래스 익스텐션에선 안되며-각 클래스마다 최대 하나만 가질 수 있습니다.

하위 클래스는 상위 클래스의 정리자를 상속하며, 하위 클래스 객체의 해제 직전 암시적으로 호출합니다. 하위 클래스 객체는 자신의 상속 사슬 안의 모든 정리자를 실행 종료할 때까지 해제되지 않습니다.

정리자는 직접 호출하지 않습니다.

클래스 선언에서의 정리자 사용법에 대한 예제는, [Deinitialization (뒷정리)]({% post_url 2017-03-03-Deinitialization %}) 를 보기 바랍니다.

> GRAMMAR OF A DEINITIALIZER DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID377)

### Extension Declaration (익스텐션 선언)

_익스텐션 선언 (extension declaration)_ 은 기존 타입의 동작을 확장하도록 합니다. 익스텐션 선언은 `extension` 키워드로 하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;extension `type name-타입 이름` where `requirements-필수 조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`declarations-선언`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

익스텐션 선언 본문은 0 개 이상의 _선언 (declarations)_ 을 담습니다. 이러한 _선언 (declarations)_ 은 계산 속성과, 계산 타입 속성, 인스턴스 메소드, 타입 메소드, 초기자, 첨자 선언, 및 심지어 클래스와, 구조체, 및 열거체 선언을 포함할 수 있습니다. 익스텐션 선언엔 정리자 및 프로토콜 선언이나, 저장 속성, 속성 관찰자, 또는 다른 익스텐션 선언을 담을 수 없습니다. 프로토콜 익스텐션 안의 선언엔 `final` 을 표시할 수 없습니다. 다양한 종류의 선언을 포함한 익스텐션에 대한 논의 및 여러 가지 예제는, [Extensions (익스텐션; 확장)]({% post_url 2016-01-19-Extensions %}) 을 보기 바랍니다.

_타입 이름 (type name)_ 이 클래스나, 구조체, 또는 열거체 타입이면, 익스텐션은 그 타입을 확장합니다. _타입 이름 (type name)_ 이 프로토콜 타입이면, 익스텐션은 그 프로토콜을 준수한 모든 타입을 확장합니다.

일반화 타입 또는 결합 타입을 가진 프로토콜을 확장하는 익스텐션 선언은 _필수 조건 (requirements)_ 을 포함할 수 있습니다. 확장한 타입 또는 확장한 프로토콜을 준수한 타입의 인스턴스가 _필수 조건 (requirements)_ 을 만족하면, 선언 안에서 지정한 동작을 인스턴스가 얻습니다.

익스텐션 선언은 초기자 선언을 담을 수 있습니다. 그렇더라도, 확장할 타입이 다른 모듈에 정의되어 있으면, 초기자 선언이 반드시 이미 그 모듈에서 정의한 초기자로 일을-맡겨야 그 타입 멤버가 제대로 초기화되는 걸 보장합니다.

기존 타입의 속성과, 메소드, 및 초기자를 그 타입의 익스텐션에서 재정의할 순 없습니다.

익스텐션 선언으로 기존 클래스나, 구조체, 또는 열거체 타입에 프로토콜 준수성을 추가하려면 _채택한 프로토콜 (adopted protocols)_ 을 지정하면 됩니다:

&nbsp;&nbsp;&nbsp;&nbsp;extension `type name-타입 이름`: `adopted protocols-채택한 프로토콜` where `requirements-필수 조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`declarations-선언`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

익스텐션 선언으로 기존 클래스에 클래스 상속성을 추가할 순 없으므로, _타입 이름 (type name)_ 과 콜론 뒤엔 프로토콜 목록만 지정할 수 있습니다.

#### Conditional Conformance (조건부 준수성)

일반화 타입이 프로토콜을 조건부로 준수하도록 확장해서, 타입의 인스턴스가 특정한 필수 조건과 만날 때만 프로토콜을 준수하게, 할 수 있습니다. 프로토콜에 조건부 준수성을 추가하려면 익스텐션 선언이 _필수 조건 (requirements)_ 을 포함하면 됩니다.

**Overridden Requirements Aren't Used in Some Generic Contexts (일부 일반화 상황에선 재정의한 필수 조건을 사용하지 않습니다)**

일부 일반화 상황에선, 프로토콜 조건부 준수성으로 동작을 획득한 타입이 그 프로토콜 필수 조건의 특수화 구현[^specialized-implementations] 을 항상 사용하는 건 아닙니다. 이 동작을 묘사하기 위해, 다음 예제는 두 프로토콜과 그 두 프로토콜을 모두 조건부로 준수하는 일반화 타입을 하나 정의합니다.

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

`Pair` 구조체는, 각자, 자신의 일반화 타입이 `Loggable` 이나 `TitledLoggable` 을 준수할 때마다 `Loggable` 과 `TitledLoggable` 을 준수합니다. 아래 예제에서, `oneAndTwo` 는 `Pair<String>` 의 인스턴스로, `TitledLoggable` 을 준수하는데 이는 `String` 이 `TitleLoggable` 을 준수하기 때문입니다. `oneAndTwo` 의 `log()` 메소드를 직접 호출할 땐, 제목 문자열을 담은 특수화 버전을 사용합니다.

```swift
let oneAndTwo = Pair(first: "one", second: "two")
oneAndTwo.log()
// "Pair of 'String': (one, two)" 를 인쇄함
```

하지만, 일반화 상황 안에서나 `Loggable` 프로토콜의 인스턴스로써 `oneAndTwo` 를 사용할 땐, 특수화 버전을 사용하지 않습니다. 스위프트는 `Pair` 가 `Loggable` 을 준수하는 데 필요한 최소 필수 조건만을 참고하여 호출할 `log()` 구현을 고릅니다. 이런 이유로, 그 대신 `Loggable` 프로토콜이 제공하는 기본 구현을 사용합니다.

```swift
func doSomething<T: Loggable>(with x: T) {
  x.log()
}
doSomething(with: oneAndTwo)
// "(one, two)" 를 인쇄함
```

`doSomething(_:)` 으로 전달한 인스턴스의 `log()` 를 호출할 땐, 기록 문자열에서 사용자가 정한 제목을 생략합니다.

#### Protocol Conformance Must Not Be Redundant (프로토콜 준수성은 반드시 남아돌아선 안됩니다)

고정 타입 (concrete type) 은 특별한 한 프로토콜을 단 한 번만 준수할 수 있습니다. 스위프트는 프로토콜 준수성이 남아도는 걸 에러로 표시합니다. 이런 종류의 에러는 두 가지 종류의 상황에서 마주칠 겁니다. 첫 번째 상황은 동일한 프로토콜을, 서로 다른 필수 조건으로, 명시적으로 여러 번 준수할 때 입니다. 두 번째 상황은 동일한 프로토콜을 암시적으로 여러 번 상속할 때 입니다. 아래 절에서 이러한 상황을 논의합니다.

**Resolving Explicit Redundancy (명시적 남아돌기 해결하기)**

고정 타입에 대한 여러 개의 익스텐션은, 익스텐션의 필수 조건이 상호 배타적 (mutually exclusive) 이더라도, 동일한 프로토콜로의 준수성을 추가할 수 없습니다. 아래 예제에서 이러한 제약을 실제로 보여줍니다. 두 개의 익스텐션 선언이 `Serializable` 프로토콜로의 조건부 준수성을 추가하려고 하는데, 하나는 원소가 `Int` 인 배열을 위해서, 다른 하나는 원소가 `String` 인 배열을 위해서입니다.

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
// 에러: 'Array<Element>' 가 'Serializable' 프로토콜을 준수하는게 남아돎
```

여러 개의 고정 타입에 기초하여 조건부 준수성을 추가할 필요가 있으면, 각각의 타입이 준수할 수 있는 새로운 프로토콜을 생성하고 조건부 준수성 선언 때 그 프로토콜을 필수 조건으로 사용합니다.

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

**Resolving Implicit Redundancy (암시적 남아돌기 해결하기)**

고정 타입이 프로토콜을 조건부로 준수할 때, 그 타입은 필수 조건이 같은 어떤 부모 프로토콜이든 암시적으로 준수합니다.

단일 부모를 상속한 두 개의 프로토콜을 조건부로 준수하는 타입이 필요하다면, 부모 프로토콜로의 준수성을 명시적으로 선언합니다. 이는 부모 프로토콜을 암시적으로 서로 다른 필수 조건으로 두 번 준수하는 걸 피하게 합니다.

다음 예제는 `Array` 의 조건부 준수성을 `Loggable` 로 명시적으로 선언하여 `TitledLoggable` 및 새로운 `MarkedLoggable` 프로토콜 둘 다에 대한 조건부 준수성을 선언할 때의 충돌을 피하게 합니다.

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

`Loggable` 로의 조건부 준수성을 명시한 익스텐션이 없다면, 다른 `Array` 익스텐션들이 이 선언을 암시적으로 생성하여, 에러가 될 것입니다:[^loggable]

```swift
extension Array: Loggable where Element: TitledLoggable { }
extension Array: Loggable where Element: MarkedLoggable { }
// 에러: 'Array<Element>' 가 'Loggable' 프로토콜을 준수하는게 남아돎
```

> GRAMMAR OF AN EXTENSION DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID378)

### Subscript Declaration (첨자 선언)

_첨자 선언 (subscript declaration)_ 은 특별한 한 타입의 객체에 첨자 지원 기능을 추가하도록 하며 전형적으로 이를 사용하여 집합체 (collection) 나, 리스트 (list), 또는 시퀀스 (sequence) 원소 접근의 편의 구문을 제공합니다. 첨자 선언은 `subscript` 키워드로 하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;subscript (`parameters-매개 변수`) -> `return type-반환 타입` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;get {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;set(`setter name-설정자 이름`) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

첨자 선언은 클래스나, 구조체, 열거체, 익스텐션, 또는 프로토콜 선언 안에서만 있을 수 있습니다.

_매개 변수 (paramter)_ 는 첨자 표현식에서 해당 타입의 원소 접근에 사용하는 하나 이상의 색인을 (예를 들어, `object[i]` 표현식의 `i` 같은 걸) 지정합니다. 원소 접근에 사용할 색인은 어떤 타입이어도 되긴 하지만, 각 매개 변수는 반드시 타입 보조 설명을 포함하여 각각의 색인 타입을 지정해야 합니다. _반환 타입 (return type)_ 은 접근할 원소의 타입을 지정합니다.

계산 속성 처럼, 첨자 선언은 접근한 원소 값의 읽기와 쓰기를 지원합니다. 획득자를 써서 값을 읽고, 설정자를 써서 값을 씁니다. 설정자 절은 옵션이며, 획득자만 필요할 땐, 두 절 모두 생략하고 단순히 요청 값을 직접 반환 할 수도 있습니다. 그렇더라도, 설정자 절을 제공한다면, 반드시 획득자 절도 제공해야 합니다.

_설정자 이름 (setter name)_ 과 테두리 괄호는 옵션입니다. 설정자 이름을 제공하면, 이를 설정자의 매개 변수 이름으로 사용합니다. 설정자 이름을 제공하지 않으면, 설정자의 기본 매개 변수 이름은 `value` 입니다. 설정자의 매개 변수 타입은 _반환 타입 (return type)_ 과 똑같습니다.

자신을 선언한 타입 안에서 첨자 선언을 중복 정의하려면, 중복 정의할 것의 _매개 변수 (paramter)_ 나 _반환 타입 (return type)_ 이 다르기만 하면 됩니다. 상위 클래스에서 상속한 첨자 선언을 재정의할 수도 있습니다. 그럴 땐, 반드시 재정의한 첨자 선언에 `override` 선언 수정자를 표시해야 합니다.

첨자 매개 변수는 함수 매개 변수와 동일한 규칙을 따르지만, 두 가지 예외가 있습니다. 기본적으로, 첨자 연산에서 쓰는 매개 변수엔, 함수와, 메소드, 및 초기자와 달리, 인자 이름표가 없습니다. 하지만, 함수와, 메소드, 및 초기자에서 쓰는 것과 똑같은 구문의 명시적 인자 이름표를 제공할 순 있습니다. 이에 더해, 첨자 연산엔 입-출력 매개 변수가 있을 수 없습니다. 첨자 연산 매개 변수는, [Special Kinds of Parameters (특수한 종류의 매개 변수)](#special-kinds-of-parameters-특수한-종류의-매개-변수) 에서 설명한 구문의, 기본 값을 가질 수 있습니다.

[Protocol Subscript Declaration (프로토콜 첨자 선언)](#protocol-subscript-declaration-프로토콜-첨자-선언) 에서 설명한 것처럼, 프로토콜 선언 안에서 첨자 연산을 선언할 수도 있습니다.

첨자에 대한 더 많은 정보 및 첨자 선언 예제를 보려면, [Subscripts (첨자)]({% post_url 2020-03-30-Subscripts %}) 를 보기 바랍니다.

#### Type Subscript Declarations (타입 첨자 선언)

첨자를, 타입의 인스턴스 보단, 타입이 드러내도록 선언하려면, 첨자 선언에 `static` 선언 수정자를 표시합니다. 클래스의 타입 계산 속성은 `class` 선언 수정자를 대신 표시하여 상위 클래스 구현을 하위 클래스가 재정의하는 걸 허용할 수 있습니다. 클래스 선언에서, `static` 키워드는 선언에 `class` 와 `final` 선언 수정자를 둘 다 표시한 것과 똑같은 효과입니다.

> GRAMMAR OF A SUBSCRIPT DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID379)

### Operator Declaration (연산자 선언)

_연산자 선언 (operator declaration)_ 은 프로그램에 새로운 중위 (infix) 나, 접두사 (prefix), 또는 접미사 (postfix) 연산자를 도입하며 `operator` 키워드로 선언합니다.

연산자는 서로 다른 세 개의 고정 위치 (fixity) 로 선언할 수 있는데: 중위 및, 접두사, 접미사가 그것입니다. 연산자의 _고정 위치 (fixity)_ 가 지정하는 건 피연산자에 대한 연산자의 상대 위치입니다.

연산자 선언은, 각각의 고정 위치마다 하나씩, 총 세 개의 기초 형식이 있습니다. 연산자 고정 위치는 연산자 선언에서 `operator` 키워드 앞에 `infix` 나, `prefix`, 또는 `postfix` 선언 수정자를 표시하여 지정합니다. 각 형식에서, 연산자 이름엔 [Operators (연산자)]({% post_url 2020-07-28-Lexical-Structure %}#operators-연산자) 에서 정의한 연산자 문자만 담을 수 있습니다.

다음 형식은 새로운 중위 연산자를 선언합니다:

&nbsp;&nbsp;&nbsp;&nbsp;infix operator `operator name-연산자 이름`: `precedence group-우선권 그룹`

_중위 연산자 (infix operator)_ 는 두 개의 피연산자 사이에 작성하는 이항 (binary) 연산자로, 익숙한 `1 + 2` 표현식 안의 덧셈 연산자 (`+`) 같은 겁니다.

중위 연산자는 옵션으로 우선 순위 그룹을 지정할 수 있습니다. 연산자의 우선 순위 그룹을 생략하면, `DefaultPrecedence` 라는, 기본 우선권 그룹을 스위프트가 사용하며, 이는 `TernaryPrecedence` 바로 위의 우선 순위를 지정합니다. 더 많은 정보는, [Precedence Group Declaration (우선 순위 그룹 선언)](#precedence-group-declaration-우선-순위-그룹-선언) 부분을 보기 바랍니다.

다음 형식은 새로운 접두사 연산자를 선언합니다:

&nbsp;&nbsp;&nbsp;&nbsp;prefix operator `operator name-연산자 이름`

_접두사 연산자 (prefix operator)_ 는 피연산자 바로 앞에 작성하는 단항 (unary) 연산자로, `!a` 표현식 안의 접두사 논리 부정 (NOT) 연산자 (`!`) 같은 겁니다.

접두사 연산자 선언은 우선 순위를 지정하지 않습니다. 접두사 연산자는 비-결합적 (nonassociative)[^nonassociative] 입니다.

다음 형식은 새로운 접미사 연산자를 선언합니다:

&nbsp;&nbsp;&nbsp;&nbsp;postfix operator `operator name-연산자 이름`

_접미사 연산자 (postfix operator)_ 는 피연산자 바로 뒤에 작성하는 단항 (unary) 연산자로, `a!` 표현식 안의 강제-포장 풀기 연산자 (`!`) 같은 겁니다.

접두사 연산자 처럼, 접미사 연산자 선언도 우선 순위를 지정하지 않습니다. 접미사 연산자는 비-결합적입니다.

새로운 연산자를 선언한 후, 연산자와 똑같은 이름의 정적 메소드를 선언하여 이를 구현합니다. 정적 메소드는 연산자가 인자로 취하는 값 타입 안의 멤버입니다-예를 들어, `Double` 과 `Int` 를 곱하는 연산자는 `Double` 이나 `Int` 구조체의 정적 메소드로 구현합니다. 접두사나 접미사 연산자를 구현할 거면, 반드시 그 메소드 선언에 해당하는 `prefix` 나 `postfix` 선언 수정자도 표시해야 합니다. 새로운 연산자의 생성 및 구현 방법에 대한 예제를 보려면, [Custom Operators (사용자 정의 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#custom-operators-사용자-정의-연산자) 부분을 보기 바랍니다.

> GRAMMAR OF AN OPERATOR DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID380)

### Precedence Group Declaration (우선 순위 그룹 선언)

_우선 순위 그룹 선언 (precedence group declaration)_ 은 프로그램에 새로운 중위 연산자 우선 순위 그룹을 도입합니다. 연산자 우선 순위는, 괄호 그룹이 없을 때, 연산자와 피연산자를 얼마나 밀접하게 연결할지 지정합니다.

우선 순위 그룹 선언의 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;precedencegroup `precedence group name-우선권 그룹 이름` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;higherThan: `lower group names-더 낮은 그룹 이름들`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;lowerThan: `higher group names-더 높은 그룹 이름들`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;associativity: `associativity-결합성`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;assignment: `assignment-할당`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

_더 낮은 그룹 이름들 (lower group names)_ 및 _더 높은 그룹 이름들 (higher group names)_ 목록은 새로운 우선 순위 그룹과 기존 우선 순위 그룹 사이의 관계를 지정합니다. `lowerThan` 우선 순위 그룹 특성은 현재 모듈 밖에서 선언한 우선 순위 그룹의 참조에만 사용할 수도 있습니다. `2 + 3 * 5` 표현식 같이, 두 연산자가 피연산자를 두고 경쟁할 때는, 상대적으로 더 높은 우선 순위의 연산자가 피연산자와 더 밀접하게 연결됩니다.

> _더 낮은 그룹 이름들 (lower group names)_ 및 _더 높은 그룹 이름들 (higher group names)_ 로 서로 관련된 우선 순위 그룹은 반드시 단일 관계 계층 (single relational hierarchy) 이어야 하지만, 선형 계층 (linear hierarchy) 을 형성하진 않아도 됩니다. 이는 상대적인 우선 순위를 정의하지 않은 우선 순위 그룹도 가능하다는 의미입니다. 이러한 우선 순위 그룹의 연산자들은 괄호 그룹 없이 서로 나란히 사용할 수 없습니다.

스위프트는 수 없이 많은 우선 순위 그룹을 정의하여 표준 라이브러리에서 제공한 연산자와 나란히 사용합니다. 예를 들어, 덧셈 (`+`) 및 뺄셈 (`-`) 연산자는 `AdditionPrecedence` 그룹에 속하고, 곱셈 (`*`) 및 나눗셈 (`/`) 연산자는 `MultiplicationPrecedence` 그룹에 속합니다. 스위프트 표준 라이브러리가 제공하는 우선 순위 그룹의 완전한 목록은, [Operator Declarations](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 항목을 보기 바랍니다.

연산자 _결합성 (associativity)_[^associativity] 은 괄호 그룹이 없을 때 동일한 우선 순위를 가진 일렬로 나열된 연산자들을 어떻게 함께 그룹지을지 지정합니다. 연산자 결합성은 `left` 나, `right`, 또는 `none` 이라는 상황에-민감한 (context-sensitive) 키워드[^context-sensitive] 중 하나를 작성하여 지정합니다-결합성을 생략하면, 기본 값은 `none` 입니다. 왼쪽-결합 (left-associative) 연산자는 왼쪽에서-오른쪽으로 그룹 짓습니다. 예를 들어, 뺄셈 연산자 (`-`) 는 왼쪽-결합이라서, 표현식 `4 - 5 - 6` 은 `(4 - 5) - 6` 으로 그룹지어 `-7` 이라고 평가합니다. 오른쪽-결합 연산자는 오른쪽에서-왼쪽으로 그룹짓고, `none` 이라는 결합성을 지정한 연산자는 아예 결합을 하지 않습니다. 동일한 우선 순위인 비-결합 연산자는 서로 인접하여 나타날 수 없습니다. 예를 들어, `<` 연산자의 결합성은 `none` 이며, 이는 `1 < 2 < 3` 같은 건 유효한 표현식은 아니라는 의미입니다.

우선 순위 그룹의 _할당 (assignment)_ 은 옵셔널 사슬을 포함한 연산에 사용할 때의 연산자 우선 순위를 지정합니다. `true` 로 설정할 땐, 옵셔널 사슬 중에 해당 우선 순위 그룹 안의 연산자가 표준 라이브러리 할당 연산자와 동일한 그룹 규칙을 사용합니다. 그 외 경우, `false` 로 설정하거나 생략할 땐, 우선 순위 그룹 안의 연산자가 할당을 하지 않는 연산자와 동일한 옵셔널 사슬 규칙을 따릅니다.

> GRAMMAR OF A PRECEDENCE GROUP DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID550)

### Declaration Modifiers (선언 수정자)

_선언 수정자 (declaration modifiers)_ 는 선언의 동작이나 의미를 수정하는 키워드 또는 상황에-민감한 키워드[^context-sensitive] 입니다. 선언 수정자는 (있다면) 선언의 특성과 선언을 도입한 키워드 사이에 적절한 키워드 또는 상황에-민감한 키워드를 작성하여 지정합니다.

`class`

&nbsp;&nbsp;&nbsp;&nbsp;이 수정자를 클래스 멤버에 적용하면 멤버가, 클래스 인스턴스의 멤버라기 보단, 클래스 그 자체의 멤버라는 걸 지시합니다. 이 수정자는 있고 `final` 수정자는 없는 상위 클래스 멤버는 하위 클래스에서 재정의할 수 있습니다.

`dynamic`

&nbsp;&nbsp;&nbsp;&nbsp;이 수정자를 적용한 어떤 클래스 멤버든 오브젝티브-C 로 나타낼 수 있습니다. 멤버 선언에 `dynamic` 수정자를 표시할 땐, 그 멤버로의 접근은 항상 오브젝티브-C 런타임을 써서 동적 급파 (dispatched) 합니다. 그 멤버러의 접근은 컴파일러가 절대 인라인 (inline; 코드 줄에 넣기) 하거나 탈-가상화 (devirtualized) 하지 않습니다.[^dynamically-dispatched]

&nbsp;&nbsp;&nbsp;&nbsp;`dynamic` 수정자로 표시한 선언은 오브젝티브-C 런타임을 써서 급파하기 때문에, 반드시 `objc` 특성을 표시해야 합니다.

`final`

&nbsp;&nbsp;&nbsp;&nbsp;이 수정자는 클래스 또는 클래스의 속성이나, 메소드, 첨자 멤버에 적용합니다. 클래스에 적용하면 클래스로 하위 클래스를 만들 수 없다는 걸 지시합니다. 클래스의 속성이나, 메소드, 첨자에 적용하면 클래스 멤버를 어떤 하위 클래스에서도 재정의할 수 없다는 걸 지시합니다. `final` 사용법의 예제는, [Preventing Overrides (재정의 막기)]({% post_url 2020-03-31-Inheritance %}#preventing-overrides-재정의-막기) 부분을 보기 바랍니다.

`lazy`

&nbsp;&nbsp;&nbsp;&nbsp;이 수정자를 클래스나 구조체의 저장 변수 속성에 적용하면, 속성에 최초로 접근할 때, 최대 한 번만 속성의 초기 값을 계산하고 저장한다는 걸 지시합니다. `lazy` 수정자의 사용법에 대한 예제는, [Lazy Stored Properties (느긋한 저장 속성)]({% post_url 2020-05-30-Properties %}#lazy-stored-properties-느긋한-저장-속성) 부분을 보기 바랍니다.

`optional`

&nbsp;&nbsp;&nbsp;&nbsp;이 수정자를 프로토콜의 속성이나, 메소드, 또는 첨자 멤버에 적용하면 준수 타입이 이러한 멤버를 구현하는 게 필수는 아니라는 걸 지시합니다.

&nbsp;&nbsp;&nbsp;&nbsp;`optional` 수정자는 `objc` 특성을 표시한 프로토콜에만 적용할 수 있습니다. 그 결과, 클래스 타입만 옵셔널 멤버 필수 조건을 담은 프로토콜을 채택하고 준수할 수 있습니다. `optional` 수정자 사용법에 대한 더 많은 정보와 옵셔널 프로토콜 멤버의 접근법에 대한 길잡이-예를 들어, 준수 타입이 구현했는지 확실하지 않을 때-는, [Optional Protocol Requirements (옵셔널 프로토콜 필수 조건)]({% post_url 2016-03-03-Protocols %}#optional-protocol-requirements-옵셔널-프로토콜-필수-조건) 부분을 보기 바랍니다.

`required`

&nbsp;&nbsp;&nbsp;&nbsp;이 수정자를 클래스의 지명 또는 편의 초기자에 적용하면 반드시 모든 하위 클래스가 그 초기자를 구현해야 한다는 걸 지시합니다. 그 초기자의 하위 클래스 구현에도 반드시 `required` 수정자를 표시해야 합니다.

`static`

&nbsp;&nbsp;&nbsp;&nbsp;이 수정자를 구조체나, 클래스, 열거체, 또는 프로토콜 멤버에 적용하면, 그 타입의 인스턴스에 대한 멤버라기 보단, 타입 (자체)의 멤버라는 걸 지시합니다. 클래스 선언 영역 안에서, 멤버 선언에 `static` 수정자를 작성하면 그 멤버 선언에 `class` 와 `final` 수정자를 작성하는 것과 똑같은 효과입니다.[^class-final] 하지만, 클래스의 상수 타입 속성은 예외인데: 여기선 `static` 이 보통의, 클래스가 아닌 의미를 가지는게 이 선언들엔 `class` 나 `final` 을 쓸 수 없기 때문입니다.

`unowned`

&nbsp;&nbsp;&nbsp;&nbsp;이 수정자를 저장 변수나, 상수, 또는 저장 속성에 적용하면 변수나 속성의 값이 객체로의 소유하지 않은 참조라는 걸 지시합니다. 객체를 해제한 후에 변수나 속성에 접근하려 하면, 실행 시간 에러가 일어납니다. 약한 참조 같이, 속성이나 값의 타입은 반드시 클래스 타입이어야 하며; 약한 참조와 달리, 옵셔널-아닌 타입입니다. `unowned` 수정자에 대한 예제 및 더 많은 정보는, [Unowned References (소유하지 않는 참조)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#unowned-references-소유하지-않는-참조) 부분을 보기 바랍니다.

`unowned(safe)`

&nbsp;&nbsp;&nbsp;&nbsp;`unowned` 의 (전체) 철자를 명시한 겁니다.[^unowned-safe]

`unowned(unsafe)`

&nbsp;&nbsp;&nbsp;&nbsp;이 수정자를 저장 변수나, 상수, 또는 저장 속성에 적용하면 변수나 속성의 값이 객체로의 소유하지 않은 참조라는 걸 지시합니다. 객체를 해제한 후에 변수나 속성에 접근하려 하면, 객체였던 메모리 장소에 접근할 건데, 이는 안전하지 않은-메모리 연산입니다. 약한 참조 같이, 속성이나 값의 타입은 반드시 클래스 타입이어야 하며; 약한 참조와 달리, 옵셔널-아닌 타입입니다. `unowned` 수정자에 대한 예제 및 더 많은 정보는, [Unowned References (소유하지 않는 참조)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#unowned-references-소유하지-않는-참조) 부분을 보기 바랍니다.

`weak`

&nbsp;&nbsp;&nbsp;&nbsp;이 수정자를 저장 변수나 저장 변수 속성에 적용하면 변수나 속성의 값이 객체로의 약한 참조라는 걸 지시합니다. 변수나 속성의 타입은 반드시 옵셔널 클래스 타입이어야 합니다. 객체를 해제한 후에 변수나 속성에 접근하면, 값이 `nil` 입니다. `weak` 수정자에 대한 예제 및 더 많은 정보는, [Weak References (약한 참조)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#weak-references-약한-참조) 부분을 보기 바랍니다.

#### Access Control Levels (접근 제어 수준)

스위프트는 다섯 가지 수준의 접근 제어를 제공하는데: 공개 (open), 공용 (public), 내부 (internal), 파일 전용 (file private), 및 개인 전용 (private) 이 그것입니다. 선언에 아래의 접근-수준 중 하나를 표시하여 선언의 접근 수준을 지정합니다. 접근 제어는 [Access Control (접근 제어)]({% post_url 2020-04-28-Access-Control %}) 에서 자세히 논합니다.

`open`

&nbsp;&nbsp;&nbsp;&nbsp;이 수정자를 선언에 적용하면 선언과 동일한 모듈 안의 코드가 선언에 접근하고 하위 클래스를 만들 수 있다는 걸 지시합니다. `open` 접근-수준 수정자를 표시한 선언은 그 선언이 담긴 모듈을 불러온 모듈 코드도 접근하고 하위 클래스를 만들 수 있습니다.

`public`

&nbsp;&nbsp;&nbsp;&nbsp;이 수정자를 선언에 적용하면 선언과 동일한 모듈 안의 코드가 선언에 접근하고 하위 클래스를 만들 수 있다는 걸 지시합니다. `public` 접근-수준 수정자를 표시한 선언은 그 선언이 담긴 모듈을 불러온 모듈 코드도 접근할 수 있습니다 (하위 클래스 만들기는 안됩니다).

`internal`

&nbsp;&nbsp;&nbsp;&nbsp;이 수정자를 선언에 적용하면 선언과 동일한 모듈 안의 코드만 선언에 접근할 수 있다는 걸 지시합니다. 기본적으로, 대부분의 선언에 `internal` 접근-수준 수정자를 암시적으로 표시합니다.

`fileprivate`

&nbsp;&nbsp;&nbsp;&nbsp;이 수정자를 선언에 적용하면 선언과 동일한 소스 파일 안의 코드만 선언에 접근할 수 있다는 걸 지시합니다.

`private`

&nbsp;&nbsp;&nbsp;&nbsp;이 수정자를 선언에 적용하면 선언을 직접 둘러싼 영역 안의 코드만 선언에 접근할 수 있다는 걸 지시합니다.

접근 제어용으론, 동일한 파일에 있는 동일한 타입의 익스텐션들은 접근-제어 영역을 공유합니다. 확장한 타입도 동일한 파일 안에 있으면, 타입의 접근-제어 영역을 공유합니다. 타입 선언 안에서 선언한 개인 전용 (private) 멤버를 익스텐션에서 접근할 수 있고, 한 익스텐션 안에서 선언한 개인 전용 멤버를 다른 익스텐션 및 타입 선언에서 접근할 수도 있습니다.

위에 있는 각각의 접근-수준 수정자는 옵션으로 단일 인자를 받는데, 이는 (예를 들어, `private(set)` 같이) `set` 키워드를 괄호로 테두리 쳐서 구성됩니다. [Getters and Setters (획득자 및 설정자)]({% post_url 2020-04-28-Access-Control %}#getters-and-setters-획득자-및-설정자) 에서 논한 것처럼, 변수나 첨자의 설정자 접근 수준이 변수나 첨자 그 자체의 접근 수준 보다 낮거나 같게 지정하고 싶을 때 이런 형식의 접근-제어 수정자를 사용합니다.

### 다음 장

[Attributes (특성) > ]({% post_url 2020-08-14-Attributes %})

### 참고 자료

[^Declarations]: 원문은 [Declarations](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html) 에서 확인할 수 있습니다.

[^immutable]: 상수는 값을 바꿀 수 없는 것인데, 클래스 같은 참조 타입은 주소가 값이기 때문에, 바꿀 수 없는 것은 주소이며, 그 주소가 가리키는 곳의 내용은 바꿀 수 있습니다.

[^global-scope]: '전역 (global scope)' 는 최상단 영역을 말하며, 사실상 프로그램의 진입점에 해당합니다.

[^final]: 이미 `final` 인 상태라서 따로 설정할 수 없습니다.

[^stored-named-values]: 본문에 있는 '저장 이름 값 (stored named values)' 은 바로 위에서 설명한 저장 변수를 의미합니다.

[^expression]: 여기서의 '표현식 (expression)' 은 위 형식의 `expression-표현식` 부분을 말합니다. 클래스나 구조체 선언에서는 이 `expression-표현식` 부분이 없어도 된다는 의미입니다.

[^type-computed-properties]: '타입 변수 속성 (type variable property)' 이 아니라, '타입 계산 속성 (type computed property)' 입니다. '타입 저장 속성 (type stored property)' 는 해당하지 않습니다. 

[^generic]: '일반화 매개 변수 (generic parameters)' 는 꺽쇠 괄호 (`<>`) 사이에 있는 매개 변수를 말합니다.

[^concrete-type]: 프로그래밍에서 '추상 타입 (abstract type)' 은 자신이 직접 인스턴스를 만들 수 없는 타입을 말합니다. 이와 반대로, 자신이 직접 인스턴스를 만들 수 있는, 추상 타입이 아닌 모든 타입을 '고정 타입 (concrete type)' 이라고 합니다. 스위프트에선 프로토콜이 추상 타입이고, 인스턴스를 만들 수 있는 다른 타입들은 모두 고정 타입니다. 고정 타입에 대한 더 자세한 내용는, 위키피디아의 [Abstract type](https://en.wikipedia.org/wiki/Abstract_type) 항목을 보도록 합니다. 추상 타입은 직접 인스턴스를 만들 순 없지만, 하나의 타입으로써 사용할 순 있는데, 이를 일컬어 실존 타입 (existential type) 이라 합니다. 실존 타입에 대한 더 자세한 내용은, [Protocols as Types (타입으로써의 프로토콜)]({% post_url 2016-03-03-Protocols %}#protocols-as-types-타입으로써의-프로토콜) 부분을 보도록 합니다.

[^function-definition]: 본문의 내용을 보면 함수 선언이란 용어와 함수 정의라는 용어를 구분 없이 사용하고 있음을 알 수 있습니다. 다만, 여기서 '함수 정의 (function definition)' 라는 용어를 사용한 건 함수 본문 전체를 강조하기 위해서 입니다.

[^escaping]: '벗어나는 것 (escaping)' 에 대한 더 자세한 내용은, [Escaping Closures (벗어나는 클로저)]({% post_url 2020-03-03-Closures %}#escaping-closures-벗어나는-클로저) 부분의 내용과 주석을 보도록 합니다.

[^call-by-value-result]: 기본적으로, '값-결과에 의한 호출 (call by value result)' 은 '값에 의한 호출 (call by value)' 과 '참조에 의한 호출 (call by reference)' 이 합쳐진 것으로 볼 수 있습니다. [프로그래밍 학습법탐구자](http://blog.daum.net/here8now/) 님의 [call by value, call by reference, call by value result, call by name](http://blog.daum.net/here8now/37) 항목에 따르면, 함수 안에서는 '값에 의한 호출 (call by value)' 처럼 동작하고, 함수 반환 시에는 '참조에 의한 호출 (call by reference)' 처럼 동작합니다. 다만, 이어지는 본문에서 설명하는 것처럼, 입-출력 매개 변수는 최적화에 의해 참조에 의한 호출 동작을 사용하기도 합니다. 즉, 스위프트의 입-출력 매개 변수는 상황에 따라 참조에 의한 호출과 값-결과에 의한 호출을 적절하게 선택하여 인자를 전달합니다.

[^physical-address]: 인자가 주소면, (설령, 주소는 복사되더라도) 값 자체는 복사되지 않고 하나로만 유지된다는 의미입니다.

[^call-by-reference]: 즉, 스위프트는 안자가 값인지 주소인지에 따라, 값에 의한 호출과 참조에 의한 호출이라는 두 가지 방식으로 입-출력 매개 변수 전달을 최적화합니다. 

[^optimization]: 입-출력 매개 변수의 최적화는 컴파일러가 컴파일 단게에서 알아서 신경쓰는 문제이므로, 개발자는 값에 의한 호출 (복사-입력 복사 출력) 방식을 사용하기만 하면 된다는 의미입니다.

[^simultaneous-access]: '동시 접근 (simulaneous access)' 을 하면 메모리 접근 충돌이 발생하게 됩니다.

[^memory-exclusivity-guarantee]: 바로 밑에 나와 있듯, 스위프트의 메모리 독점권 보증 (memory exclusivity guarantee) 에 대한 더 많은 정보는, [Memory Safety (메모리 안전성)]({% post_url 2020-04-07-Memory-Safety %}) 장을 보도록 합니다.

[^closure-with-inout-parameter]: 본문 밑에 있는 예제인 `{ [a] in return a + 1 }` 라는 클로저는 `a` 값을 변경하지 않으므로, 붙잡을 목록 `[a]` 를 써서 `a` 가 변경 불가능하다고 명시하고 나서 붙잡았습니다.

[^variadic-label]: 인자 이름표가 없으면 새로운 매개 변수가 아닌 가변 매개 변수의 한 원소라고 인식하기 때문입니다. 

[^equals-sign]: 원문에선 '같음 기호 (equals sign)' 라고 하지만, 같음 기호를 한 번만 쓰면 할당 연산자입니다. 수학적 의미의 같음은 `==` 같이 같음 기호를 두 번 연속으로 써서 나타냅니다.

[^throw-overload]: 에러를 던지는 것과 던지지 않는 것만 차이가 나고 나머지는 똑같은 함수를 둘 수는 없다는 의미입니다.

[^throwing-nonthrowing]: 던지는 함수는 에러를 던질 수도 있고 아닐 수도 있습니다. 그러므로 던지는 함수를 던지지 않는 함수로 재정의하는 건 자연스럽습니다. 하지만, 던지지 않는 함수를 던지는 함수로 재정의하면 원래 정의한 성질에 맞지 않게 됩니다.

[^rethrowing-function]: 이 설명을 보면, 다시 던지는 함수는 함수 매개 변수가 던진 에러를 다시 던진다는 걸 빼면, 함수 자체로는 에러를 던지지 않는 함수라고 할 수 있습니다.

[^synchronous-function]: 비동기 함수가 아닌 모든 함수는 '동기 함수 (synchronous functions)' 입니다.

[^indefinitely]: 사실상, 복구할 수 없는 에러가 발생하지 않는 한, 무한정 반복하는 작업을 시작합니다. 컴파일 시간엔 프로그램 종료 시점을 알 수 없으므로, `Never` 타입을 사용한다고 이해할 수 있습니다. 스위프트에선 발행자 (Publisher) 가 `Never` 타입을 사용하며, 프로그램 실행 동안 구독자 (Subscriber) 쪽으로 정보를 계속해서 보냅니다.

[^specify-store]: 본문 예제의 열거체에서 두 번째 case 가 이에 해당합니다.

[^recursive-structure]: 프로그래밍에서 '재귀 (recursion)' 란 하나의 컴퓨터 문제를 더 작은 동일 문제를 풀어서 해결해 나가는 방법입니다. 대부분의 컴퓨터 프로그래밍 언어는 하나의 함수 안에서 자기 자신을 호출함으로써 이러한 '재귀 (recursion)' 문제를 지원합니다. 재귀에 대한 더 자세한 정보는, 위키피디아의 [Recursion (computer science)](https://en.wikipedia.org/wiki/Recursion_(computer_science)) 과 [재귀 (컴퓨터 과학)](https://ko.wikipedia.org/wiki/재귀_(컴퓨터_과학)) 항목을 보기 바랍니다. 

[^fixed-layout]: 여기서 말하는 메모리 안의 고정 구획 (fixed layout) 을 보통 스택 (stack) 이라고 합니다.

[^layer-of-indirection]: 열거체 인스턴스는 값 의미 구조라 스택에 저장하므로, 한 열거체 인스턴스가 다른 인스턴스를 호출하려면, 그 인스턴스로의 참조도 따로 저장해야 합니다. 그 인스턴스로의 참조를 추가하여 저장하는 걸 '간접 계층 (layer-of-indirection) 을 집어 넣는다' 고 합니다.

[^signature]: 함수나 메소드에서 '서명 (signature) 과 이름 (name)' 의 차이점은 매개 변수의 포함 여부입니다. 이 예제의 `init(rawValue: RawValue)` 는 초기자 서명 (signature) 이라고 하고, 매개 변수 부분을 뺀 `init?` 은 초기자 이름이라고 합니다.

[^designated-initializers]: 여기서 그냥 초기자가 아니라 지명 초기자라고 한 건, 재정의할 초기자가 상위 클래스에서 지명 초기자이든 편의 초기자이든, 재정의하고 나면 무조건 지명 초기자가 되기 때문입니다.

[^universal-base-class]: '범용 기초 클래스 (universal base class)' 는 오브젝티브-C 언어의 `NSObject` 같은 클래스를 말합니다. 대부분의 OOP 클래스들은 이러한 범용 기초 클래스를 상속합니다.

[^isolate]: 이를 '행위자 격리 (actor isolation)' 이라고 하는데, 이에 대한 더 자세한 정보는 [Concurrency (동시성)]({% post_url 2021-06-10-Concurrency %}) 장의 [Actors (행위자)]({% post_url 2021-06-10-Concurrency %}#actors-행위자) 부분을 보기 바랍니다.

[^optional-member]: 프로토콜에서 선언한 필수 조건의 구현 그 자체가 옵셔널이라는 의미입니다. 즉, 프로토콜의 준수 타입이 구현을 하면 구현부가 있는 것이고, 안하면 `nil` 입니다.

[^required-override]: '필수 (required)' 라는 개념 안에 이미 '재정의 (override)' 가 들어 있기 때문에, 따로 `override` 를 작성할 필요가 없습니다.

[^specialized-implementations]: '특수화 구현 (specialized implementations)' 은 일반화 타입의 타입 매개 변수를 특수한 타입으로 고정하여, 적용 범위를 좁힌 구현을 의미합니다.

[^loggable]: 부모 프로토콜로의 준수성을 명시하면 자식 프로토콜로의 준수성으로 인하여 부모 프로토콜로의 준수성이 암시적으로 생기는 것을 막아줍니다.

[^method-with-special-anme]: 본문에서 설명하는 내용은 C++ 언어에 있는 '함수 객체 (Function Object)' 와 비슷한 내용입니다. 함수 객체에 대한 더 자세한 정보는 위키피디아의 [Function object](https://en.wikipedia.org/wiki/Function_object) 항목을 보도록 합니다.

[^nonassociative]: '비-결합적 (nonassociative)' 은 '결합성 (associativity)' 이 `none` 인 것을 말합니다. 보다 자세한 내용은, 이어지는 절인 [Precedence Group Declaration (우선 순위 그룹 선언)](#precedence-group-declaration-우선-순위-그룹-선언) 부분을 보도록 합니다.

[^associativity]: '결합성 (associativity)' 은 사실 결합 법칙이라고 옮겨도 됩니다. 다만 수학에서 말하는 결합 법칙을 'associative law' 라고 하므로 결합성이라고 옮깁니다. 

[^context-sensitive]: '상황에-민감한 키워드 (context-sensitive keywords)' 는 특수한 상황에서만 인식되는 언어 원소입니다. 상황에-민감한 키워드에 대한 더 자세한 정보는, 마이크로소프트 문서의 [Context-Sensitive Keywords](https://docs.microsoft.com/en-us/cpp/extensions/context-sensitive-keywords-cpp-component-extensions?view=msvc-160) 항목을 보기 바랍니다.

[^operator-declarations]: 원문 자체가 애플 개발자 문서의 [Operator Declarations](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations) 항목으로 연결됩니다.

[^class-final]: 즉, 클래스 선언 안에서 `static` 을 사용하면 `class` 와 `final` 을 동시에 사용하는 것과 같은 효과입니다.

[^structure-type]: 원문에서는 '구조체 타입 (structure type)' 이라고 되어 있는데, '행위자 타입 (actor type)' 의 오타라고 추측됩니다.

[^dynamically-dispatched]: '동적 급파 (dynamically dispatched)' 라는 개념은 C++ 등에서 사용하는 가상 함수 테이블 (virtual function table) 을 사용한다는 의미입니다. 가상 함수 테이블을 사용하기 때문에, 인라인이나 탈-가상화를 할 수 없습니다. 가상 함수 테이블에 대한 더 자세한 정보는, 위키피디아의 [Virtual method table](https://en.wikipedia.org/wiki/Virtual_method_table) 항목과 [가상 메소드 테이블](https://ko.wikipedia.org/wiki/가상_메소드_테이블) 항목을 보도록 합니다.  

[^unowned-safe]: 스위프트에서 `unowned` 를 사용하는 건 `unowned(safe)` 를 사용하는 것과 같은 것이고, 따로 `unowned(unsafe)` 라고 명시하지 않는 한, 항상 `unowned(safe)` 를 사용합니다.