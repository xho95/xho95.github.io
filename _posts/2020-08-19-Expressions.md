---
layout: post
comments: true
title:  "Swift 5.3: Expressions (표현식)"
date:   2020-08-19 11:30:00 +0900
categories: Swift Language Grammar Expression
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Expressions](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html) 부분[^Expressions]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## Expressions (표현식)

스위프트에는 네 가지 종류의 표현식이 있습니다: '접두사 표현식 (prefix expressions)', '이항 표현식 (binary expressions)', '제1 표현식 (primary expressions)', 및 '접미사 표현식 (postfix expressions)' 이 그것입니다. 표현식을 평가하는 것은 값을 반환하거나, '부작용 (side effect)'[^side-effect] 을 일으키거나, 아니면 둘 다에 해당합니다.

접두사 표현식 및 이항 표현식은 더 작은 표현식에 연산자를 적용할 수 있도록 해줍니다. '제1 표현식' 은 개념적으로 가장 간단한 종류의 표현식이며, 값에 접근하는 방법을 제공합니다. 접미사 표현식은, 접두사 표현식 및 이항 표현식 처럼, 함수 호출 및 멤버 접근 등의 접미사를 사용하여 더 복잡한 표현식을 제작하도록 해줍니다. 표현식은 각 종류별로 아래 장에서 더 자세히 설명합니다.

> GRAMMAR OF AN EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html)

### Prefix Expressions (접두사 표현식)

_접두사 표현식 (prefix expressions)_ 은 선택 사항인 접두사 연산자를 표현식과 조합합니다. '접두사 연산자 (prefix operators)' 는 하나의 인자를 취하는데, 뒤에 있는 표현식이 그것입니다.

이런 연산자의 작동 방식에 대한 정보는, [Basic Operators (기본 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 및 [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) 를 참고하기 바랍니다.

스위프트 표준 라이브러리에서 제공하는 연산자에 대한 정보는, [Operator Declarations](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 를 참고하기 발랍니다.

표준 라이브러리의 연산자에 더하여, 함수 호출 표현식에서 입-출력 인자로 전달되는 변수의 이름 바로 앞에는 `&` 를 사용합니다. 더 자세한 정보와 예제를 보려면, [In-Out Parameters (입-출력 매개 변수)]({% post_url 2020-06-02-Functions %}#in-out-parameters-입-출력-매개-변수) 를 참고하기 바랍니다.

> GRAMMAR OF A PREFIX EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID384)

#### Try Operator ('try' 연산자)

_try 표현식 (try expression)_ 은 `try` 연산자와 그 뒤에 있는 에러를 던질 수 있는 표현식으로 구성됩니다. 형식은 다음과 같습니다:

try `expression-표현식`

옵셔널-try 표현식은 `try?` 연산자와 그 뒤에 있는 에러를 던질 수 있는 표현식으로 구성됩니다. 형식은 다음과 같습니다:

try? `expression-표현식`

_표현식 (expression)_ 이 에러를 던지지 않는 경우, 옵셔널-try 표현식의 값은 _표현식 (expression)_ 의 값을 가지고 있는 옵셔널입니다. 다른 경우라면, 옵셔널-try 표현식의 값은 `nil` 입니다.

_강제-try 표현식_ 은 `try!` 연산자와 그 뒤에 있는 에러를 던질 수 있는 표현식으로 구성됩니다. 형식은 다음과 같습니다:

try! `expression-표현식`

_표현식 (expression)_ 이 에러를 던지는 경우, 실행 시간 에러를 일으킵니다.

이항 연산자의 왼-편에 있는 표현식에 `try`, `try?`, 또는 `try!` 를 표시하면, 해당 연산자가 전체 이항 표현식에 적용됩니다. 즉, 괄호를 사용하여 연산자가 적용되는 영역을 명시할 수도 있습니다.

```swift
sum = try someThrowingFunction() + anotherThrowingFunction()   // try 는 두 함수 호출 모두에 적용됩니다.
sum = try (someThrowingFunction() + anotherThrowingFunction()) // try 는 두 함수 호출 모두에 적용됩니다.
sum = (try someThrowingFunction()) + anotherThrowingFunction() // Error: try 가 첫 번째 함수 호출에만 적용되었습니다.
```

이항 연산자가 할당 연산자이거나 `try` 표현식을 괄호로 감싸지 않은 이상, `try` 표현식이 이항 연산자의 오른-편에 있을 수는 없습니다.

더 자세한 정보와 `try`, `try?`, 및 `try!` 를 사용하는 방법에 대한 예제를 보려면, [Error Handling (에러 처리)]({% post_url 2020-05-16-Error-Handling %}) 를 참고하기 바랍니다.

> GRAMMAR OF A TRY EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID384)

### Binary Expressions (이항 표현식)

_이항 표현식 (binary expressions)_ 은 '이항 중위 연산자 (infix binary operator)'[^infix-binary-operator] 와 이의 왼쪽 인자 및 오른쪽 인자로써 취하는 표현식을 조합합니다. 형식은 다음과 같습니다:

`left-hand argument-왼쪽 인자` `operator-연산자` `right-hand argument-오른쪽 인자`

이들 연산자의 작동 방식에 대한 정보는, [Basic Operators (기본 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 및 [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) 를 참고하기 바랍니다.

스위프트 표준 라이브러리에서 제공하는 연산자에 대한 정보는, [Operator Declarations](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations) 를 참고하기 바랍니다.

> 구문 해석 시간에, 이항 연산자로 이루어진 표현식은 '단순 리스트 (flat list)'[^list] 로 표현됩니다. 이 '리스트 (list)' 는 연산자 우선 순위를 적용하는 과정을 통해 '트리 (tree)' 로 변환됩니다. 예를 들어, 표현식 `2 + 3 * 5` 는 초기에 `2`, `+`, `3`, `*`, 및 `5` 라는 다섯 개의 항목을 가진 '단순 리스트' 라고 이해됩니다. 이 후 과정은 이를 `(2 + (3 * 5))` 라는 '트리 (tree)' 로 변환합니다.

> GRAMMAR OF A BINARY EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID385)

#### Assignment Operator (할당 연산자)

_할당 연산자 (assignment operator)_ 는 주어진 표현식에 새로운 값을 설정합니다. 형식은 다음과 같습니다:

`expression-표현식` = `value-값`

_표현식 (expression)_ 의 값은 _값 (value)_ 부분을 평가하여 구한 값으로 설정됩니다. _표현식 (expression)_ 이 튜플이라면, _값 (value)_ 은 반드시 원소 개수가 같은 튜플이어야 합니다. (중첩된 튜플은 허용됩니다.) 할당 작업은 _값 (value)_ 의 각 부분이 이에 연관된 _표현식 (expression)_ 의 부분으로 수행합니다. 예를 들면 다음과 같습니다:

```swift
(a, _, (b, c)) = ("test", 9.45, (12, 3))
// a 는 "test", b 는 12, c 는 3 이 되며, 9.45 는 무시됩니다.
```

할당 연산자는 어떤 값도 반환하지 않습니다.

> GRAMMAR OF AN ASSIGNMENT OPERATOR 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID385)

#### Ternary Conditional Operator (삼항 조건 연산자)

_삼항 조건 연산자 (ternary conditional operator)_ 는 조건의 값을 기반으로 하여 주어진 두 개의 값 중 하나를 평가합니다. 형식은 다음과 같습니다:

`condition-조건` ? `expression used if true-true 면 사용할 표현식` : `expression used if false-false 면 사용할 표현식`

_조건 (condition)_ 이 `true` 라고 평가되면, '조건 연산자' 는 첫 번째 표현식을 평가하여 그 값을 반환합니다. 다른 경우라면, 두 번째 표현식을 평가하여 그 값을 반환합니다. 사용되지 않은 표현식은 평가를 하지 않습니다.

삼항 조건 연산자를 사용하는 예제는, [Ternary Conditional Operator (삼항 조건 연산자)]({% post_url 2016-04-27-Basic-Operators %}Ternary Conditional Operator (삼항 조건 연산자)) 를 참고하기 바랍니다.

> GRAMMAR OF A CONDITIONAL OPERATOR 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID385)

#### Type-Casting Operators (타입-변환 연산자)

타입-변환 연산자는 네 가지가 있습니다: `is` 연산자, `as` 연산자, `as?` 연산자, 그리고 `as!` 연산자가 그것입니다.

형식은 다음과 같습니다:

`expression-표현식` is `type-타입`
`expression-표현식` as `type-타입`
`expression-표현식` as? `type-타입`
`expression-표현식` as! `type-타입`

`is` 연산자는 실행 시간에 _표현식 (expression)_ 을 지정한 _타입 (type))_ 으로 변환할 수 있는지 검사합니다. _표현식 (expression)_ 을 지정한 타입으로 변환할 수 있는 경우 `true` 를 반환합니다; 다른 경우라면, `false` 를 반환합니다.

`as` 연산자는, '올림 변환 (upcasting)' 또는 '연동 (bridging)' 같이, 항상 변환이 성공함을 컴파일 시간에 알고 있을 때 변환을 수행하는 것입니다. '올림 변환 (upcasting)' 은, 중간 단계의 변수를 사용하지 않고도, 표현식을 그것의 상위 타입의 인스턴스로 사용하게 해줍니다. 다음의 접근 방식은 '동치 (equivalent)' 입니다:

```swift
func f(_ any: Any) { print("Function for Any") }
func f(_ int: Int) { print("Function for Int") }
let x = 10
f(x)
// "Function for Int" 를 출력합니다.

let y: Any = x
f(y)
// "Function for Any" 를 출력합니다.

f(x as Any)
// "Function for Any" 를 출력합니다.
```

'연동 (bridging)' 은 새로운 인스턴스를 생성할 필요없이 `String` 같은 스위프트 표준 라이브러리 타입을 `NSString` 같은 연관된 'Foundation' 타입[^foundation] 으로 사용하게 해줍니다. '연동 (bridging)' 에 대한 더 많은 정보는, [Working with Foundation Types](https://developer.apple.com/documentation/swift/imported_c_and_objective-c_apis/working_with_foundation_types) 를 참고하기 바랍니다.

`as?` 연산자는 _표현식 (expression)_ 을 지정한 _타입 (type)_ 으로 조건부로 변환합니다. `as?` 연산자는 지정한 _타입 (type)_ 에 대한 '옵셔널' 을 반환합니다. 실행 시간에, 변환을 성공하면, _표현식 (expression)_ 의 값을 옵셔널로 포장하여 반환합니다; 다른 경우에는, `nil` 이라는 값을 반환합니다. 지정한 타입으로 변환하는 것이 실패라고 보증된 경우거나 아니면 성공이라고 보증된 경우에는, 컴파일-시간 에러가 발생합니다.

`as!` 연산자는 _표현식 (expression)_ 을 지정한 _타입 (type)_ 으로 강제 변환합니다. `as!` 연산자는, 옵셔널 타입이 아닌, 지정한 _타입 (type)_ 의 값을 반환합니다. 변환을 실패하면, 실행 시간 에러가 발생합니다. `x as! T` 의 작동 방식은 `(x as? T)!` 의 작동 방식과 같습니다.

타입 변환에 대한 더 많은 정보와 타입-변환 연산자를 사용하는 예제에 대해서는, []() 를 참고하기 바랍니다.

> GRAMMAR OF A TYPE-CASTING OPERATOR 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID385)

### Primary Expressions (제1 표현식)

_제1 표현식 (primary expressions)_ 은 가장 기본적인 종류의 표현식입니다. 이들은 그 자체로 표현식으로 사용할 수 있으며, 다른 '낱말 (tokens)' 과 조합하여 '접두사 표현식 (prefix expression)', '이항 표현식 (binary expression)', '접미사 표현식 (postfix expression)' 을 만들 수도 있습니다.

> GRAMMAR OF A PRIMARY EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Literal Expression (글자 값 표현식)

_글자 값 표현식 (literal expression)_ 은 일상적인 글자 값 (가령 문자열이나 숫자 등), 배열 또는 딕셔너리 글자 값, '플레이그라운드 글자 값 (playground literal)', 아니면 다음의 '특수 글자 값 (special literals)' 중 하나로써 구성됩니다:

글자 값 | 타입 | 값
---|---|---
`#file` | `String` |  이 값이 있는 파일 및 모듈의 이름
`#filePath` | `String` | 이 값이 있는 파일의 경로
`#line` | `Int` | 이 값이 있는 줄의 번호
`#column` | `Int` | 이 값이 시작하는 열의 번호
`#function` | `String` | 이 값이 있는 선언의 이름
`#dsohandle` | `UnsafeRawPointer` | 이 값이 있는 곳에서 사용중인 '동적 공유 객체 (dynamic shared object; DSO) 핸들 (handle)'

`#file` 표현식의 문자열 값은 _module/file_ 형식을 가지며, 여기서 _file_ 은 표현식이 있는 파일의 이름이고 _module_ 은 이 파일이 있는 모듈의 이름입니다. `#filePath` 표현식의 문자열 값은 표현식이 있는 파일에 대한 '온전한 파일-시스템 경로 (full file-system path)' 입니다. 이 두 값 모두, [Line Control Statement (라인 제어문)]({% post_url 2020-08-20-Statements %}#line-control-statement-라인-제어문) 에서 설명한 것처럼, `#sourceLocation` 로 바꿀 수 있습니다.

> `#file` 표현식을 해석하려면, 첫 번째 빗금 (`/`) 앞의 문장으로 모듈 이름을 읽고 마지막 빗금 뒤의 문장으로 파일 이름을 읽으면 됩니다. 향후, 문자열이, `MyModule/some/disambiguation/MyFile.swift` 처럼, '다중 빗금' 을 가질 수도 있습니다.

`#function` 의 값은, 함수 내부에서는 해당 함수의 이름이 되고, 메소드 내부에서는 해당 메소드의 이름이 되며, 속성 획득자 (getter) 또는 설정자 (setter) 내부에서는 해당 속성의 이름이 되고, `init` 또는 `subscript` 와 같은 특수 멤버 내부에서는 해당 키워드의 이름이 되며, 파일의 최상위 수준에서는 현재 모듈의 이름이 됩니다.

함수 매개 변수나 메소드 매개 변수의 '기본 설정 값' 으로 사용할 때의, 특수 글자 값은 호출하는 쪽에서 그 '기본 설정 값 표현식' 의 값을 평가하는 순간에 결정됩니다.

```swift
func logFunctionName(string: String = #function) {
  print(string)
}
func myFunction() {
  logFunctionName() // "myFunction()" 를 출력합니다.
}
```

_배열 글자 값 (array literal)_ 은 값들의 순서 있는 '집합체 (collection)' 입니다. 형식은 다음과 같습니다:

[`value 1 (값 1)`, `value 2 (값 2)`, `...`]

배열의 마지막 표현식 뒤에는 쉼표를 붙여도 됩니다. 배열 글자 값의 타입은 `[T]` 인데, 여기서 `T` 는 안에 있는 표현식의 타입입니다. 만약 다중 타입의 표현식들로 되어 있는 경우, `T` 는 '가장 근접한 공통 상위 타입 (closest common supertype)' 이 됩니다. '빈 배열 글자 값' 은 '빈 대괄호 쌍' 을 사용하여 작성하며 지정한 타입의 빈 배열을 생성하기 위해 사용합니다.

```swift
var emptyArray: [Double] = []
```

_딕셔너리 글자 값 (dictionary literal)_ 은 '키-값 쌍 (key-value pairs)' 의 순서 없는 '집합체' 입니다. 형식은 다음과 같습니다:

[`key 1 (키 1)`: `value 1 (값 1)`, `key 2 (키 2)`: `value 2 (값 2)`, `...`]

딕셔너리의 마지막 표현식 뒤에는 쉼표를 붙여도 됩니다. 딕셔너리 글자 값의 타입은 `[Key : Value]` 인데, 여기서 `Key` 는 '키 표현식 (key expressions)' 의 타입이고 `Value` 는 '값 표현식 (value expressions)' 의 타입입니다. 만약 다중 타입의 표현식들로 되어 있는 경우, `Key` 와 `Value` 는 각자의 값에 대한 '가장 근접한 공통 상위 타입' 이 됩니다. '빈 딕셔너리 글자 값' 은 '빈 배열 글자 값' 과 구별하기 위해 '콜론이 있는 대괄호 쌍 (`[:]`)' 을 써서 작성합니다. '빈 딕셔너리 글자 값' 을 사용하여 지정한 키 및 값 타입으로 된 빈 딕셔너리 글자 값을 생성할 수 있습니다.

```swift
var emptyDictionary: [String : Double] = [:]
```

_플레이그라운드 글자 값 (playground literal)_ 은 프로그램 편집기 내에서 상호 작용 형태로 색상, 파일, 또는 이미지 표현을 생성하기 위해 'Xcode (엑스코드)' 가 사용하는 것입니다. '플레이그라운드 글자 값' 을 Xcode 외부의 '평이한 문장' 으로 옮기면 '특수 글자 값 구문 표현' 을 사용하여 표현됩니다.[^playground-literal]

Xcode 에서 '플레이그라운드 글자 값' 을 사용하는 정보는, Xcode 도움말에 있는 [Add a color, file, or image literal](https://help.apple.com/xcode/mac/current/#/dev4c60242fc) 을 참고하기 바랍니다.

> GRAMMAR OF A LITERAL EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Self Expression ('self' 표현식)

`self` 표현식은 자기가 속한 곳의 현재 타입 또는 그 타입의 인스턴스에 대한 명시적인 참조입니다. 형식은 다음과 같습니다:

self
<br />
self.`member name-멤버 이름`
<br />
self [`subscript index-첨자 연산 색인`]
<br />
self (`initializer arguments-초기자 인자`)
<br />
self.init(`initializer arguments-초기자 인자`)

초기자, 첨자 연산, 또는 인스턴스 메소드에 있는, `self` 는 자기가 속한 곳의 타입에 대한 현재의 인스턴스를 참조합니다. 타입 메소드에 있는, `self` 는 자기가 속한 곳의 현재 타입을 참조합니다.

`self` 표현식은 멤버에 접근할 때 영역을 지정하기 위해 사용하며, 이는 영역에 함수 매개 변수 같이 같은 이름인 다른 변수가 있을 경우 모호함을 없애줍니다. 예를 들면 다음과 같습니다:

```swift
class SomeClass {
  var greeting: String
  init(greeting: String) {
    self.greeting = greeting
  }
}
```

값 타입의 변경 메소드에 있는, `self` 에는 해당 값 타입의 새로운 인스턴스를 할당할 수 있습니다.[^mutating-method] 예를 들면 다음과 같습니다:

```swift
struct Point {
  var x = 0.0, y = 0.0
  mutating func moveBy(x deltaX: Double, y deltaY: Double) {
    self = Point(x: x + deltaX, y: y + deltaY)
  }
}
```

> GRAMMAR OF A SELF EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Superclass Expression (상위 클래스 표현식)

_상위 클래스 표현식 (superclass expression)_ 은 클래스가 상위 클래스와 상호 작용하도록 해줍니다. 형식은 다음 중 하나입니다:

super.`memeber name-멤버 이름`
super[`subscript index-첨자 연산 색인`]
super.init(`initializer arguments-초기자 인자`)

첫 번째 형식은 상위 클래스의 멤버에 접근하기 위해 사용합니다. 두 번째 형식은 상위 클래스의 첨자 연산 구현에 접근하기 위해 사용합니다. 세 번째 형식은 상위 클래스의 초기자에 접근하기 위해 사용합니다.

하위 클래스는 상위 클래스에 있는 구현을 사용하기 위해 자신의 멤버, 첨자 연산, 및 초기자의 구현에서 상위 클래스 표현식을 사용할 수 있습니다.

> GRAMMAR OF A SUPERCLASS EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Closure Expression

**Capture Lists**

#### Implicit Member Expression

#### Parenthesized Expression

#### Tuple Expression

#### Wildcard Expression

#### Key-Path Expression

#### Selector Expression

#### Key-Path String Expression

### Postfix Expressions

#### Function Call Expression

#### Initializer Expression (초기자 표현식)

_초기자 표현식 (initializer expression)_ 은 타입의 초기자에 대한 접근을 제공합니다. 형식은 다음과 같습니다:

`expression-표현식`.init(`initializer arguments-초기자의 인자`)

'초기자 표현식' 을 '함수 호출 표현식' 안에서 사용하여 타입의 새로운 인스턴스를 초기화합니다. 또한 초기자 표현식을 사용하여 상위 클래스의 초기자로 위임합니다.

```swift
class SomeSubClass: SomeSuperClass {
    override init() {
        // 여기서 하위 클래스를 초기화 합니다.
        super.init()
    }
}
```

함수와 마찬가지로, 초기자를 값으로 사용할 수 있습니다. 예를 들면 다음과 같습니다:

```swift
// String 이 여러 초기자를 가지고 있기 때문에 타입 보조 설명이 필수입니다.
let initializer: (Int) -> String = String.init
let oneTwoThree = [1, 2, 3].map(initializer).reduce("", +)
print(oneTwoThree)
// "123" 을 출력합니다.
```

타입을 이름으로 지정한 경우, 초기자 표현식을 사용하지 않고도 타입의 초기자에 접근할 수 있습니다. 그 외의 다른 모든 경우에는, 반드시 초기자 표현식을 사용해야 합니다.

```swift
let s1 = SomeType.init(data: 3)  // 유효합니다.
let s2 = SomeType(data: 1)       // 역시 유효합니다.

let s3 = type(of: someValue).init(data: 7)  // 유효합니다.
let s4 = type(of: someValue)(data: 5)       // 에러입니다.
```

> GRAMMAR OF AN INITIALIZER EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Explicit Member Expression

#### Postfix Self Expression

#### Subscript Expression

#### Forced-Value Expression

#### Optional-Chaining Expression

### 참고 자료

[^Expressions]: 원문은 [Expressions](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html) 에서 확인할 수 있습니다.

[^side-effect]: 컴퓨터 용어에서 'side effect' 를 '부작용' 이라고 직역하는 것이 옳은 것인지는 잘 모르겠습니다. 위키피디아에서는 'side effect' 를 다음과 같이 설명하고 있습니다. 컴퓨터 과학에서, 연산, 함수, 또는 표현식이 'side effect' 를 가지고 있다는 것은 이들이 지역 범위 외부에 있는 상태 변수의 값을 수정하는 경우를 말하는 것으로, 즉 해당 연산의 호출 쪽에서 함수 반환이라는 '주요 효과 (main effect)' 외에 별도로 '관찰 가능한 효과' 를 가지는 것을 말합니다. 이러한 정의에 따르면, 'side effect' 를 '부작용' 이라기 보다는 '부수적인 효과' 정도로 이해해도 좋을 것입니다. 다만, 'side effect' 가 '부작용' 이라고 널리 쓰이고 있으므로, 컴퓨터 용어에서의 '부작용' 이란 의미를 앞서와 같이 이해할 수도 있을 것입니다. 보다 자세한 내용은 위키피디아의 [Side effect (computer science)](https://en.wikipedia.org/wiki/Side_effect_(computer_science)) 및 [부작용 (컴퓨터 과학)](https://ko.wikipedia.org/wiki/부작용_(컴퓨터_과학)) 항목을 참고하기 바랍니다.

[^playground-literal]: 예를 들어 '빨간색' 플레이그라운드 글자 값은 ![Playground Color](/assets/Swift/Swift-Programming-Language/Expressions-playground-literal.png){:width="100px"} 인데, 이를 복사하여 다른 편집기로 옮기면 `var color = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)` 과 같은 '특수 글자 값 구문 표현' 이 됩니다.

[^operator-declarations]: 원문 자체가 애플 개발자 사이트로 연결되는 링크로 되어 있습니다.

[^infix-binary-operator]: 이 책에서는 '중위 이항 연산자 (infix binary operator)' 와 '이항 중위 연산자 (binary infix operator)' 라는 말을 섞어 쓰고 있는데, 편의를 위해서 '이항 중위 연산자' 로 통일하여 옮기도록 합니다.

[^list]: 여기서의 '리스트 (list)' 는 '목록' 이라기 보다는 자료 구조에서의 '리스트' 이기 때문에 용어 그대로 옮기도록 합니다.

[^foundation]: 여기서 'Foundation' 은 스위프트 프로그래밍을 하기 위해 애플에서 제공하고 있는 가장 기초가 되는 프레임웍이며, 스위프트에서는 보통 `import Foundation` 으로 불러오게 됩니다. 'Foundaton 타입' 이라면 'Foundation' 프레임웍에서 제공하고 있지만 스위프트 표준 라이브러리에 해당하는 타입은 아닌 것을 말한다고 이해할 수 있습니다.

[^mutating-method]: '값 타입 (value type)' 은 구조체와 열거체를 말하는 것이며, '변경 메소드 (mutating method)' 는 값 타입의 'self' 를 변경할 수 있는 메소드를 말합니다. 이 문장의 의미는 'self' 를 다른 인스턴스를 할당하는 것으로써 변경할 수도 있다는 의미입니다.
