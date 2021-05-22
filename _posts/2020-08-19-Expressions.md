---
layout: post
comments: true
title:  "Swift 5.4: Expressions (표현식)"
date:   2020-08-19 11:30:00 +0900
categories: Swift Language Grammar Expression
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.4)](https://docs.swift.org/swift-book/) 책의 [Expressions](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html) 부분[^Expressions]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.4: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Expressions (표현식)

스위프트에는, 네 가지 종류의 표현식인: '접두사 (prefix) 표현식', '이항 (binary) 표현식', '제1 (primary) 표현식', 및 '접미사 (postfix) 표현식' 이 있습니다. 표현식을 평가하면 값을 반환하거나, '부작용 (side effect)'[^side-effect] 을 일으키거나, 아니면 둘 다를 합니다.

'접두사 표현식' 과 '이항 표현식' 은 더 작은 표현식에 연산자를 적용하게 해줍니다. '제1 표현식' 은 개념상 가장 단순한 종류의 표현식이며, 값에 접근하는 방법을 제공합니다. '접미사 표현식' 은, 접두사 및 이항 표현식 같이, 함수 호출 및 멤버 접근 같은 '접미사' 를 사용하여 더 복잡한 표현식을 제작하게 해줍니다. 각각의 종류에 대한 표현식은 아래 부분에서 더 자세히 설명합니다.

> GRAMMAR OF AN EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html)

### Prefix Expressions (접두사 표현식)

_접두사 표현식 (prefix expressions)_ 은 '선택적인 접두사 연산자' 와 '표현식' 을 조합합니다. '접두사 연산자' 는 하나의 인자로, 뒤따라 오는 표현식을, 취합니다.

이 연산자들의 동작에 대한 정보는, [Basic Operators (기초 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 장과 [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) 장을 참고하기 바랍니다.

'스위프트 표준 라이브러리' 가 제공하는 연산자에 대한 정보는, [Operator Declarations](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 항목을 참고하기 발랍니다.

> GRAMMAR OF A PREFIX EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID384)

#### In-Out Expression (입-출력 표현식)

_입-출력 표현식 (in-out expression)_ 은 함수 호출 표현식에 '입-출력 인자' 로 전달된 변수를 표시합니다.

&nbsp;&nbsp;&nbsp;&nbsp;\&`expression-표현식`

입-출력 매개 변수에 대한 더 많은 정보와 예제를 보려면, [In-Out Parameters (입-출력 매개 변수)]({% post_url 2020-06-02-Functions %}#in-out-parameters-입-출력-매개-변수) 부분을 참고하기 바랍니다.

입-출력 표현식은, [Implicit Conversion to a Pointer Type (포인터 타입으로의 암시적인 변환)](#implicit-conversion-to-a-pointer-type-포인터-타입으로의-암시적인-변환) 부분에서 설명하는 것처럼, 포인터가 필요한 상황에서 '포인터-아닌 인자' 를 제공할 때도 사용합니다. 

> GRAMMAR OF AN IN-OUT EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID384)

#### Try Operator ('try' 연산자)

_try 표현식 (try expression)_ 은 '`try` 연산자' 와 그 뒤의 '에러를 던질 수 있는 표현식' 으로 구성합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;try `expression-표현식`

_옵셔널-try 표현식 (optional-try expression)_ 은 '`try?` 연산자' 와 그 뒤의 '에러를 던질 수 있는 표현식' 으로 구성합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;try? `expression-표현식`

_표현식 (expression)_ 이 에러를 던지지 않으면, '옵셔널-try 표현식' 의 값은 _표현식 (expression)_ 의 값을 담은 '옵셔널' 입니다. 그 외의 경우, '옵셔널-try 표현식' 의 값은 `nil` 입니다.

_강제-try 표현식 (forced-try expression)_ 은 '`try!` 연산자' 와 그 뒤의 '에러를 던질 수 있는 표현식' 으로 구성합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;try! `expression-표현식`

_표현식 (expression)_ 이 에러를 던지면, 실행 시간 에러를 만들게 됩니다.

이항 연산자의 왼-쪽 표현식을 `try`, `try?`, 또는 `try!` 로 표시할 때, 해당 연산자는 이항 표현식 전체에 적용됩니다. 그렇다 하더라도, 괄호를 사용하여 연산자의 적용 범위를 명시할 수 있습니다.

```swift
sum = try someThrowingFunction() + anotherThrowingFunction()   // 두 함수 호출에 다 try 를 적용합니다.
sum = try (someThrowingFunction() + anotherThrowingFunction()) // 두 함수 호출에 다 try 를 적용합니다.
sum = (try someThrowingFunction()) + anotherThrowingFunction() // 에러: try 를 첫 번째 함수 호출에만 적용합니다.
```

이항 연산자가 할당 연산자이거나 `try` 표현식을 괄호로 테두리 치지 않는 한, `try` 표현식이 이항 연산자의 오른-쪽에 있을 수는 없습니다.

`try`, `try?`, 그리고 `try!` 를 사용하는 방법에 대한 예제와 더 많은 정보는, [Error Handling (에러 처리)]({% post_url 2020-05-16-Error-Handling %}) 장을 참고하기 바랍니다.

> GRAMMAR OF A TRY EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID384)

### Binary Expressions (이항 표현식)

_이항 표현식 (binary expressions)_ 은 '이항 중위 연산자'[^infix-binary-operator] 와 이것이 자신의 왼쪽과 오른쪽 인자로 취하는 '표현식' 을 조합합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`left-hand argument-왼쪽 인자` `operator-연산자` `right-hand argument-오른쪽 인자`

이 연산자들의 동작에 대한 정보는, [Basic Operators (기초 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 장과 [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) 장을 참고하기 바랍니다.

'스위프트 표준 라이브러리' 가 제공하는 연산자에 대한 정보는, [Operator Declarations](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations) 항목을 참고하기 바랍니다.

> '구문 해석 (parse)' 시간에, 이항 연산자로 이루어진 표현식은 '납작한 리스트 (flat list)'[^flat-list] 로 표현됩니다. 이 '리스트 (list)' 에 '연산자 우선 순위' 를 적용하여 '트리 (tree)' 로 변형합니다. 예를 들어, `2 + 3 * 5` 라는 표현식은 초기에는 `2`, `+`, `3`, `*`, 및 `5` 라는 다섯 항목으로 된 '납작한 리스트' 라고 이해합니다. 이 가공 과정은 이를 `(2 + (3 * 5))` 라는 '트리 (tree)' 로 변형합니다.

> GRAMMAR OF A BINARY EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID385)

#### Assignment Operator (할당 연산자)

_할당 연산자 (assignment operator)_ 는 주어진 표현식에 새로운 값을 설정합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식` = `value-값`

_표현식 (expression)_ 의 값은 _값 (value)_ 을 평가하여 구한 값으로 설정합니다. _표현식 (expression)_ 이 '튜플' 이면, _값 (value)_ 은 반드시 똑같은 개수의 원소를 가진 튜플이어야 합니다. (중첩 튜플은 허용합니다.) '할당 (assignment)' 은 _값 (value)_ 의 각 부분을 이와 연관된 _표현식 (expression)_ 부분으로 수행합니다. 예를 들면 다음과 같습니다:

```swift
(a, _, (b, c)) = ("test", 9.45, (12, 3))
// a 는 "test", b 는 12, c 는 3 이고, 9.45 는 무시합니다.
```

할당 연산자는 어떤 값도 반환하지 않습니다.

> GRAMMAR OF AN ASSIGNMENT OPERATOR 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID385)

#### Ternary Conditional Operator (삼항 조건 연산자)

_삼항 조건 연산자 (ternary conditional operator)_ 는 조건의 값에 기초하여 주어진 두 값 중 하나를 평가합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`condition-조건` ? `expression used if true-true 면 사용할 표현식` : `expression used if false-false 면 사용할 표현식`

_조건 (condition)_ 평가가 `true` 면, '조건 연산자' 는 '첫 번째 표현식' 을 평가하고 그 값을 반환합니다. 그 외의 경우, '두 번째 표현식' 을 평가하고 그 값을 반환합니다. 사용하지 않은 표현식은 평가하지 않습니다.

'삼항 조건 연산자' 를 사용하는 예제는, [Ternary Conditional Operator (삼항 조건 연산자)]({% post_url 2016-04-27-Basic-Operators %}Ternary Conditional Operator (삼항 조건 연산자)) 부분을 참고하기 바랍니다.

> GRAMMAR OF A CONDITIONAL OPERATOR 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID385)

#### Type-Casting Operators (타입-변환 연산자)

'타입-변환 연산자' 는: `is` 연산자, `as` 연산자, `as?` 연산자, 그리고 `as!` 연산자 이렇게 네 개가 있습니다.

형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식` is `type-타입`
&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식` as `type-타입`
&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식` as? `type-타입`
&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식` as! `type-타입`

`is` 연산자는 _표현식 (expression)_ 을 특정 _타입 (type)_ 으로 변환할 수 있는 지를 실행 시간에 검사합니다. _표현식 (expression)_ 을 특정 타입으로 변환할 수 있으면 `true` 를 반환하고; 그 외의 경우, `false` 를 반환합니다.

`as` 연산자는, '올림 변환 (upcasting)' 이나 '연동 (bridging)' 같이, 변환이 항상 성공임을 컴파일 시간에 알고 있을 때 변환을 수행합니다. '올림 변환' 은, 중간 단계 변수의 사용 없이도, 표현식을 그 타입의 '상위 타입' 인스턴스로 사용할 수 있도록 해줍니다. 다음의 접근 방식은 '동치 (equivalent)' 입니다:

```swift
func f(_ any: Any) { print("Function for Any") }
func f(_ int: Int) { print("Function for Int") }
let x = 10
f(x)
// "Function for Int" 를 인쇄합니다.

let y: Any = x
f(y)
// "Function for Any" 를 인쇄합니다.

f(x as Any)
// "Function for Any" 를 인쇄합니다.
```

'연동' 은 새로운 인스턴스를 생성할 필요 없이도 `String` 같은 '스위프트 표준 라이브러리 타입' 의 표현식을 `NSString` 같은 그와 관련된 'Foundation' 타입[^foundation] 으로 사용할 수 있도록 해줍니다. '연동 (bridging)' 에 대한 더 많은 정보는, [Working with Foundation Types](https://developer.apple.com/documentation/swift/imported_c_and_objective-c_apis/working_with_foundation_types) 항목을 참고하기 바랍니다.

`as?` 연산자는 _표현식 (expression)_ 을 특정 _타입 (type)_ 으로 '조건부 변환' 합니다. `as?` 연산자는 특정 _타입 (type)_ 의 '옵셔널' 을 반환합니다. 실행 시간에, 변환이 성공하면, _표현식 (expression)_ 의 값을 옵셔널로 포장하고 반환하며; 그 외의 경우, 반환 값은 `nil` 입니다. 특정 _타입 (type)_ 으로의 변환이 실패라고 보증되거나 성공이라고 보증된다면, 컴파일-시간 에러를 일으킵니다.

`as!` 연산자는 _표현식 (expression)_ 을 특정 _타입 (type)_ 으로 '강제 변환' 합니다. `as!` 연산자는, 옵셔널 타입이 아니라, 특정 _타입 (type)_ 의 값을 반환합니다. 변환이 실패하면, 실행 시간 에러를 일으킵니다. `x as! T` 의 동작은 `(x as? T)!` 의 동작과 똑같습니다.

'타입 변환' 에 대한 더 많은 정보와 '타입-변환 연산자' 를 사용하는 예제는, [Type Casting (타입 변환)]({% post_url 2020-04-01-Type-Casting %}) 장을 참고하기 바랍니다.

> GRAMMAR OF A TYPE-CASTING OPERATOR 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID385)

### Primary Expressions (제1 표현식)

_제1 표현식 (primary expressions)_ 은 가장 기본적인 종류의 표현식입니다. 이들은 그 자체로 표현식으로 사용할 수 있으며, 다른 '낱말 (tokens)' 과 조합하여 '접두사 표현식 (prefix expression)', '이항 표현식 (binary expression)', '접미사 표현식 (postfix expression)' 을 만들 수도 있습니다.

> GRAMMAR OF A PRIMARY EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Literal Expression (글자 값 표현식)

_글자 값 표현식 (literal expression)_ 은 (문자열이나 수 같은) 일상적인 글자 값이나, 배열 및 딕셔너리 글자 값, '플레이그라운드 (playground) 글자 값', 아니면 다음의 '특수 글자 값 (special literals)' 중 하나로 구성됩니다:

글자 값 || 타입 || 값
---|---|---|---|---
`#file` | | `String` | |  이 값이 있는 파일의 경로
`#fileID` | | `String` | | 이 값이 있는 파일과 모듈의 이름
`#filePath` | | `String` | | 이 값이 있는 파일의 경로
`#line` | | `Int` | | 이 값이 있는 줄의 번호
`#column` | | `Int` | | 이 값이 시작하는 열의 번호
`#function` | | `String` | | 이 값이 있는 선언의 이름
`#dsohandle` | | `UnsafeRawPointer` | | 이 값이 있는 곳에서 사용중인 '동적 공유 객체 (dynamic shared object; DSO) 의 핸들 (handle)'


`#file` 의 문자열 값은, 예전의 `#filePath` 작동 방식에서 새로운 `#fileID` 작동 방식으로 '이전 (migration)' 할 수 있도록, 언어 버전에 따라 달라집니다.[^filePath-and-fildID] 현재의, `#file` 은 `#filePath` 와 같은 값을 가집니다. 미래 버전의 스위프트에서는, 그대신 `#file` 이 `#fileID` 와 같은 값을 가질 것입니다. 미래의 작동 방식을 채택하도록, `#file` 을 `#fileID` 또는 `#filePath` 로 적절하게 대체하기 바랍니다.[^file-to-filePath-and-fildID]

`#fileID` 표현식의 문자열 값은 _module/file_ 형식을 가지며, 여기서 _file_ 은 표현식이 있는 파일의 이름이고 _module_ 은 이 파일이 속해 있는 모듈의 이름입니다. `#filePath` 표현식의 문자열 값은 표현식이 있는 파일에 대한 '전체 파일-시스템 경로' 입니다. 이 두 값 모두, [Line Control Statement (라인 제어문)]({% post_url 2020-08-20-Statements %}#line-control-statement-라인-제어문) 에서 설명한 것처럼, `#sourceLocation` 으로 바꿀 수 있습니다. `#fileID` 는, `#filePath` 와는 다르게, 소스 파일에 대한 '전체 경로' 를 집어 넣지 않기 때문에, 개인 정보를 더 잘 보호하며 '컴파일된 바이너리' 의 크기를 줄여줍니다. '출하용 프로그램' 에 속하지 않는 테스트, 빌드 스크립트, 또는 그 외 다른 코드 외부에는 `#filePath` 의 사용을 피하도록 합니다.

> `#fileID` 표현식을 해석하려면, 모듈 이름은 첫 번째 빗금 (`/`) 앞을 문장으로 읽고 파일 이름은 마지막 빗금 뒤를 문장으로 읽도록 합니다. 미래에는, 문자열이, `MyModule/some/disambiguation/MyFile.swift` 처럼, '다중 빗금' 을 담고 있을 수도 있습니다.

`#function` 의 값은, 함수 내부에서는 해당 함수의 이름이 되고, 메소드 내부에서는 해당 메소드의 이름이 되며, 속성의 '획득자' 나 '설정자' 내부에서는 해당 속성의 이름이 되며, `init` 이나 `subscript` 같은 특수 멤버 내부에서는 해당 키워드의 이름이 되며, 파일의 최상위 수준에서는 현재 모듈의 이름이 됩니다.

'특수 글자 값 (special literals)' 을, 함수 또는 메소드 매개 변수의 '기본 값' 으로 사용할 때는, 호출하는 쪽에서 '기본 값 표현식' 을 평가할 때 그 값이 결정됩니다.

```swift
func logFunctionName(string: String = #function) {
  print(string)
}
func myFunction() {
  logFunctionName() // "myFunction()" 를 출력합니다.
}
```

_배열 글자 값 (array literal)_ 은 값이 '정렬되어 있는 집합체 (ordered collection)' 입니다. 형식은 다음과 같습니다:

[`value 1 (값 1)`, `value 2 (값 2)`, `...`]

배열의 마지막 표현식 뒤에는 옵션으로 쉼표를 붙여도 됩니다. 배열 글자 값의 타입은 `[T]` 인데, 여기서 `T` 는 그 안에 있는 표현식의 타입입니다. 표현식이 여러 개의 타입으로 되어 있는 경우, `T` 는 '가장 가까운 공통 상위 타입 (closest common supertype)' 입니다. '빈 배열 글자 값' 은 '빈 대괄호 쌍' 을 써서 작성하며 지정한 타입의 빈 배열을 생성하기 위해 사용합니다.

```swift
var emptyArray: [Double] = []
```

_딕셔너리 글자 값 (dictionary literal)_ 은 '키-값 쌍 (key-value pairs)' 이 '정렬되어 있지 않은 집합체 (unordered collection)' 입니다. 형식은 다음과 같습니다:

[`key 1 (키 1)`: `value 1 (값 1)`, `key 2 (키 2)`: `value 2 (값 2)`, `...`]

딕셔너리의 마지막 표현식 뒤에는 옵션으로 쉼표를 붙여도 됩니다. 딕셔너리 글자 값의 타입은 `[Key : Value]` 인데, 여기서 `Key` 는 '키 표현식 (key expressions)' 의 타입이고 `Value` 는 '값 표현식 (value expressions)' 의 타입입니다. 표현식이 여러 개의 타입으로 되어 있는 경우, `Key` 와 `Value` 는 각자의 값에 대한 '가장 가까운 공통 상위 타입' 입니다. '빈 딕셔너리 글자 값' 은 '빈 배열 글자 값' 과 구별하기 위해 '콜론이 있는 대괄호 쌍 (`[:]`)' 을 써서 작성합니다. '빈 딕셔너리 글자 값' 을 사용하여 지정한 키 타입과 값 타입으로 된 '빈 딕셔너리 글자 값' 을 생성할 수 있습니다.

```swift
var emptyDictionary: [String : Double] = [:]
```

_플레이그라운드 글자 값 (playground literal)_ 은 'Xcode (엑스코드)' 가 '프로그램 편집기' 에서 색상, 파일, 또는 이미지에 대한 '상호 작용하는 표현' 을 생성하기 위해 사용합니다. 'Xcode' 외부의 평범한 문장 속에 있는 '플레이그라운드 글자 값' 은 '특수 글자 값 구문 표현' 으로 표현됩니다.[^playground-literal]

'Xcode' 에서 '플레이그라운드 글자 값' 을 사용하는 것에 대한 정보는, 'Xcode' 도움말에 있는 [Add a color, file, or image literal](https://help.apple.com/xcode/mac/current/#/dev4c60242fc) 을 참고하기 바랍니다.

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

#### Closure Expression (클로저 표현식)

_클로저 표현식 (closure expression)_ 은, 다른 프로그래밍 언어에서 _람다 (lambda)_ 또는 _익명 함수 (anonymous function)_ 라고도 하는, 클로저를 생성합니다. 함수 선언과 마찬가지로, 클로저는 구문을 가지고 있으며, 자신을 둘러싼 영역에 있는 상수와 변수를 '붙잡습니다 (capture)'. 형식은 다음과 같습니다:

{ (`parameter-매개 변수`) -> `return type-반환 타입` in
<br />
  `statements-구문`
  <br />
}

_매개 변수 (parameter)_ 는, [Function Declaration (함수 선언)]({% post_url 2020-08-15-Declarations %}#function-declaration-함수-선언) 에서 설명한 것처럼, 함수 선언의 매개 변수와 같은 형식을 가집니다.

클로저를 더 간결하게 작성할 수 있는 여러 가지 특수한 형식들이 있습니다:

* 클로저는 매개 변수의 타입이나, 반환 타입, 또는 둘 다를 생략할 수 있습니다. 두 타입 모두와 매개 변수 이름을 생략하는 경우, 구문 앞의 `in` 키워드를 생략합니다. 생략한 타입을 추론할 수 없는 경우, 컴파일 시간 에러가 발생합니다.
* 클로저는 매개 변수의 이름을 생략할 수 있습니다. 이 매개 변수들은 이제 `$` 와 그 뒤의 위치로 구성된 암시적인 이름을 가집니다: `$1`, `$2`,  등으로 계속됩니다.
* '단일 표현식' 으로만 구성된 클로저는 해당 표현식의 값을 반환하는 것이라고 이해합니다. 해당 표현식의 내용은 주변 표현식에 대한 타입 추론을 수행 할 때도 고려됩니다.

다음의 클로저 표현식들은 '동치 (equivalent)' 입니다:

```swift
myFunction { (x: Int, y: Int) -> Int in
  return x + y
}

myFunction { x, y in
  return x + y
}

myFunction { return $0 + $1 }

myFunction { $0 + $1 }
```

함수에 대한 인자로써 클로저를 전달하는 것에 대한 정보는, [Function Call Expression (함수 호출 표현식)](#function-call-expression-함수-호출-표현식) 을 참고하기 바랍니다.

클로저 표현식은, 함수 호출에서 클로저를 곧 바로 사용할 때와 같이, 변수나 상수에 저장하지 않고도 사용할 수 있습니다. 위 코드에서 `myFunction` 에 전달된 클로저 표현식은 이러한 종류의 '곧바로 사용' 것에 대한 예제입니다. 그 결과로, 클로저 표현식이 '벗어나는 (escaping)' 지 '벗어나지 않는 (nonescaping)' 지는 표현식의 주변 상황에 달려 있는 것입니다. 클로저 표현식은 곧바로 호출되거나 벗어나지 않는 함수 인자로써 전달되는 경우 '벗어나지 않는 (nonescaping)' 것이 됩니다. 다른 경우라면, 클로저 표현식이 '벗어나는 (excaping)' 것입니다.

'벗어나는 클로저' 에 대한 더 많은 정보는, [Escaping Closures (벗어나는 클로저)]({% post_url 2020-03-03-Closures %}#escaping-closures-벗어나는-클로저) 를 참고하기 바랍니다.

<p>
<strong id="capture-lists-붙잡을-목록">Capture Lists (붙잡을 목록)</strong>
</p>

기본적으로, 클로저 표현식은 주변 영역에 있는 상수와 변수를 해당 값에 대한 '강한 참조 (strong references)' 를 사용하여 '붙잡습니다 (capture)'. _붙잡을 목록 (capture list)_ 을 사용하면 클로저가 값을 캡처하는 방법을 명시적으로 제어할 수 있습니다.

'붙잡을 목록' 은, 매개 변수 목록 앞에, 쉼표로 구분한 표현식의 목록을 대괄호로 감싸는 것으로 작성합니다. 붙잡을 목록을 사용할 경우, 반드시 `in` 키워드도 사용해야 하며, 이는 매개 변수 이름, 매개 변수 타입, 및 반환 타입을 생략하는 경우에도 그렇습니다.

붙잡을 목록에 있는 '엔트리 (entries)' 들은 클로저를 생성할 때 초기화 됩니다. 붙잡을 목록에 있는 각각의 엔트리에 대해서, 주변 영역에 있는 같은 이름을 가진 상수 또는 변수의 값에 대한 하나의 상수를 초기화 합니다. 예를 들어 아래 코드에서, `a` 는 붙잡을 목록에 포함되어 있지만 `b` 는 아니므로, 서로 다른 동작 방식을 부여합니다.

```swift
var a = 0
var b = 0
let closure = { [a] in
  print(a, b)
}

a = 10
b = 10
closure()
// "0 10" 를 출력합니다.
```

이름이 `a` 인 변수는, 주변 영역에 있는 변수와 클로저 영역에 있는 상수라는, 서로 다른 두 개로 있지만, 이름이 `b` 인 변수는 하나만 있습니다. 안쪽 영역에 있는 `a` 는 클로저를 생성할 때 바깥 영역에 있는 `a` 의 값으로 초기화 되지만, 이들 값은 어떠한 특수한 방법으로도 연결되어 있지 않습니다. 이것의 의미는 바깥 영역의 `a` 값을 바꾸는 것은 안쪽 영역의 `a` 값에는 영향을 주지 않으며, 클로저 안에 있는 `a` 를 바꾸는 것도 클로저 바깥의 `a` 값에는 영향을 주지 않는다는 것입니다. 이와는 대조적으로, 이름이 `b` 인 변수는-바깥 영역에 있는 `b`-만 단 하나 있으므로 클로저의 안쪽과 바깥에서 바꾸는 것을 양쪽 위치 모두 볼 수 있습니다.

'붙잡은 변수 (captured variable)' 타입이 '참조 의미 구조 (reference semantics)' 를 가질 때는 이것이 잘 구별되지 않습니다. 예를 들어, 아래 코드에는 이름이 `x` 인 것, 바깥 영역에 있는 변수와 안쪽 영역에 있는 상수, 이렇게 두 개 있지만, '참조 의미 구조' 로 인해서 이 둘은 같은 객체를 참조하고 있습니다.

```swift
class SimpleClass {
  var value: Int = 0
}
var x = SimpleClass()
var y = SimpleClass()
let closure = { [x] in
  print(x.value, y.value)
}

x.value = 10
y.value = 10
closure()
// "10 10" 을 출력합니다.
```

표현식 값의 타입이 클래스인 경우라면, '붙잡을 목록 (capture list)' 에 있는 표현식을 `weak` 또는 `unowned` 로 표시하여 표현식의 값을 약한 참조 또는 소유되지 않은 참조로 붙잡을 수 있습니다.[^weak-and-unowned-capture]

```swift
myFunction { print(self.title) }                    // 암시적인 강한 붙잡기 (implicit strong capture)
myFunction { [self] in print(self.title) }          // 명시적인 강한 붙잡기 (explicit strong capture)
myFunction { [weak self] in print(self!.title) }    // 약한 붙잡기 (weak capture)
myFunction { [unowned self] in print(self.title) }  // 소유되지 않게 붙잡기 (unowned capture)
```

임의의 표현식을 '붙잡을 목록' 에 있는 '이름 있는 변수' 에 연결할 수도 있습니다. 이 표현식은 클로저를 생성할 때 값을 평가하며, 값은 지정된 '강하기 (strength)'[^strength] 로 붙잡습니다. 예를 들면 다음과 같습니다:

```swift
// "self.parent" 를 "parent" 로 약하게 붙잡기
myFunction { [weak parent = self.parent] in print(parent!.title) }
```

클로저 표현식에 대한 더 많은 정보와 예제는, [Closure Expressions (클로저 표현식)]({% post_url 2020-03-03-Closures %}#closure-expressions-클로저-표현식) 을 참고하기 바랍니다. '붙잡을 목록 (capture list)' 에 대한 더 많은 정보와 예제는, [Resolving Strong Reference Cycles for Closures (클로저에 대한 강한 참조 순환 해결하기)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#resolving-strong-reference-cycles-for-closures-클로저에-대한-강한-참조-순환-해결하기) 를 참고하기 바랍니다.

> GRAMMAR OF A CLOSURE EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Implicit Member Expression (암시적인 멤버 표현식)

_암시적인 멤버 표현식 (implicit member expression)_ 은, '열거체 case 값' 이나 '타입 메소드' 같이, '타입 추론' 이 '암시 타입' 을 결정할 수 있는 상황에서, 타입의 멤버에 접근하는 단축 방식입니다. 이는 다음 형식을 가집니다:

&nbsp;&nbsp;&nbsp;&nbsp;.`member name-멤버 이름`

예를 들면 다음과 같습니다:

```swift
var x = MyEnumeration.someValue
x = .anotherValue
```

추론한 타입이 옵셔널인 경우, '암시적인 멤버 표현식' 에서 '옵셔널이-아닌 타입의 멤버' 를 사용할 수도 있습니다.

```swift
var someOptional: MyEnumeration? = .someValue
```

'암시적인 멤버 표현식' 뒤에는 [Postfix Expressions (접미사 표현식)](#postfix-expressions-접미사-표현식) 에서 나열한 '접미사 연산자' 또는 다른 '접미사 구문' 이 올 수 있습니다. 이를 _연쇄된 암시적인 멤버 표현식 (chained implicit member expression)_ 이라고 합니다. 비록 모든 '연쇄된 접미사 표현식' 들이 똑같은 타입을 가지는 것이 일반적일지라도, 유일한 필수 조건은 '연쇄된 암시적인 멤버 표현식' 전체가 상황이 암시하는 타입으로 변환 가능해야 한다는 것 뿐입니다. 특히, '암시 타입'이 옵셔널이면 '옵셔널이-아닌 타입' 의 값을 사용할 수 있으며, '암시 타입' 이 클래스 타입이면 그 하위 클래스 타입의 값을 사용할 수 있습니다. 예를 들면 다음과 같습니다:

```swift
class SomeClass {
  static var shared = SomeClass()
  static var sharedSubclass = SomeSubclass()
  var a = AnotherClass()
}
class SomeSubclass: SomeClass { }
class AnotherClass {
  static var s = SomeClass()
  func f() -> SomeClass { return AnotherClass.s }
}
let x: SomeClass = .shared.a.f()
let y: SomeClass? = .shared
let z: SomeClass = .sharedSubclass
```

위 코드에서, `x` 의 타입은 '상황이 암시하는 타입' 과 정확하게 일치하고, `y` 의 타입은 `SomeClass` 에서 `SomeClass?` 로 변환 가능하며, `z` 의 타입은 `SomeSubclass` 에서 `SomeClass` 로 변환 가능합니다.

> GRAMMAR OF A IMPLICIT MEMBER EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Parenthesized Expression (괄호 표현식)

_괄호 표현식 (parenthesized expression)_ 은 괄호로 감싼 표현식으로 구성됩니다. 표현식을 명시적으로 그룹지어서 연산의 '우선순위 (precedence)' 를 지정하기 위해 괄호를 사용할 수 있습니다. '괄호로 그룹지은 것 (grouping parentheses)' 은 표현식의 타입을 바꾸지 않습니다-예를 들어, `(1)` 의 타입은 단순히 `Int` 입니다.

> GRAMMAR OF A PARENTHESIZED MEMBER EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Tuple Expression (튜플 표현식)

_튜플 표현식 (tuple expression)_ 은 쉼표로 구분된 표현식의 목록을 괄호로 감싸서 구성합니다. 각각의 표현식은 그 앞에, 콜론 (`:`) 으로 구분된, 식별자를 선택적으로 가질 수 있습니다. 형식은 다음과 같습니다:

(`identifier 1-식별자 1`: `expression 1-표현식 1`, `identifier 2-식별자 2`: `expression 2-표현식 2`, `...`)

튜플 표현식에 있는 각각의 식별자는 튜플 표현식 영역에서 반드시 유일해야 합니다. 중첩된 튜플 표현식에서는, 중첩 수준이 같은 식별자는 반드시 유일해야 합니다. 예를 들어, `(a: 10, a: 20)` 은 같은 수준에서 이름표 `a` 가 두 번 나타나기 때문에 무효입니다. 하지만, `(a: 10, b: (a: 1, x: 2))` 는 유효합니다-비록 `a` 가 두 번 나타나지만, 바깥 튜플에서 한 번 안쪽 튜플에서 한 번 나타나고 있습니다.

튜플 표현식은 '0' 개의 표현식을 가지거나, 두 개 이상의 표현식을 가질 수 있습니다. 괄호 안에 단 하나의 표현식이 있으면 '괄호 표현식 (parenthesized expression)' 입니다.

> 스위프트에서 '빈 튜플 표현식' 과 '빈 튜플 타입' 은 둘 다 모두 `()` 라고 작성합니다. `Void` 는 `()` 에 대한 타입 별명이기 때문에, 빈 튜플 타입을 작성하기 위해 사용할 수 있습니다. 하지만, 모든 타입 별명들과 마찬가지로, `Void` 는 항상 타입입니다-이를 빈 튜플 표현식을 작성하기 위해 사용할 수는 없습니다.

> GRAMMAR OF A TUPLE EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Wildcard Expression (와일드카드 표현식)

_와일드카드 표현식 (wildcard expression)_ 은 할당 중에 값을 명시적으로 무시하기 위해 사용합니다. 예를 들어, 다음 할당은 '10' 은 `x` 에 할당하며 '20' 은 무시합니다:

```swift
(x, _) = (10, 20)
// x 는 10 이고, 20 은 무시합니다.
```

> GRAMMAR OF A WILDCARD EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Key-Path Expression (키-경로 표현식)

_키-경로 표현식 (key-path expression)_ 은 타입의 속성 또는 첨자 연산을 참조합니다. '키-경로 표현식' 은, '키-값 관찰 (key-value observing)' 같은, 동적 프로그래밍 작업에서 사용합니다. 형식은 다음과 같습니다:

\\`type name-타입 이름`.`path-경로`

_타입 이름 (type name)_ 은, `String`, `[Int]`, 또는 `Set<Int>` 같이, 어떤 '일반화 (generic)' 매개 변수를 포함한, '구체적으로 고정된 타입 (concrete type)' 의 이름입니다.

_경로 (path)_ 는 속성 이름, 첨자 연산, '옵셔널-연쇄 표현식 (optional-chaining expressions)', 및 '강제로 포장을 푸는 표현식 (foced unwrapping expressions)'[^foced-unwrapping-expressions] 으로 구성됩니다. 이러한 각각의 키-경로 성분을, 어떤 순서로도, 필요한만큼 많이 반복할 수 있습니다.

컴파일 시간에, 키-경로 표현식은 [KeyPath](https://developer.apple.com/documentation/swift/keypath) 클래스의 인스턴스로 대체됩니다.

키-경로를 사용하여 값에 접근하려면, 모든 타입에서 사용 가능한, `subscript(keyPath:)` 첨자 연산에 키 경로를 전달합니다. 예를 들면 다음과 같습니다:

```swift
struct SomeStructure {
  var someValue: Int
}

let s = SomeStructure(someValue: 12)
let pathToProperty = \SomeStructure.someValue

let value = s[keyPath: pathToProperty]
// value 는 12 입니다.
```

_타입 이름 (type name)_ 은 '타입 추론 장치 (type inference)' 가 암시된 타입을 결정할 수 있는 상황에서는 생략할 수 있습니다. 다음 코드는 `\SomeClass.someProperty` 대신 `\.someProperty` 를 사용합니다:

```swift
class SomeClass: NSObject {
  @objc dynamic var someProperty: Int
  init(someProperty: Int) {
    self.someProperty = someProperty
  }
}

let c = SomeClass(someProperty: 10)
c.observe(\.someProperty) { object, change in
  // ...
}
```

_경로 (path)_ 는 '자기 식별 키 경로 (identity key path; `\.self`)' 를 생성하기 위해 `self` 를 참조할 수 있습니다. '자기 식별 키 경로 (identity key path)' 는 전체 인스턴스를 참조하므로, 변수에 저장된 모든 데이터를 한 번에 접근해서 바꿀 수 있습니다. 예를 들면 다음과 같습니다:

```swift
var compoundValue = (a: 1, b: 2)
// compoundValue = (a: 10, b: 20) 와 '동치 (equivalent)' 입니다.
compoundValue[keyPath: \.self] = (a: 10, b: 20)
```

_경로 (path)_ 는 속성 값에 있는 속성을 참조하기 위해, 마침표로 구분된, 다중 속성 이름을 가질 수 있습니다. 다음 코드는 `OuterStructure` 타입인 `outer` 속성에 있는 `someValue` 에 접근하기 위해 '키 경로 표현식' 인 `\OuterStructure.outer.someValue` 를 사용합니다:

```swift
struct OuterStructure {
  var outer: SomeStructure
  init(someValue: Int) {
    self.outer = SomeStructure(someValue: someValue)
  }
}

let nested = OuterStructure(someValue: 24)
let nestedKeyPath = \OuterStructure.outer.someValue

let nestedValue = nested[keyPath: nestedKeyPath]
// nestedValue 는 24 입니다.
```

_경로 (path)_ 는, 첨자 연산의 매개 변수 타입이 `Hashable` 프로토콜을 준수하기만 하면, 대괄호를 사용하여 첨자 연산을 포함할 수 있습니다. 다음 예제는 배열의 두 번째 원소에 접근하기 위해 '키 경로 (key path)' 에서 첨자 연산을 사용합니다.

```swift
let greetings = ["hello", "hola", "bonjour", "안녕"]
let myGreeting = greetings[keyPath: \[String].[1]]
// myGreeting 은 'hola' 입니다.
```

첨자 연산에서 사용되는 값은 '이름 있는 값 (named value)' 또는 '글자 값 (literal)' 일 수 있습니다. '키 경로' 는 값을 '값 의미 구조 (value semantics)' 를 사용하여 붙잡습니다. 다음 코드는 '키 경로 표현식' 과 클로저 둘 다에서 변수인 `index` 를 사용하여 `greetings` 배열의 세 번째 원소에 접근합니다. `index` 를 수정하면, 키 경로 표현식은 여전히 세 번째 원소를 참조하는 반면, 클로저는 새로운 색인을 사용합니다.

```swift
var index = 2
let path = \[String].[index]
let fn: ([String]) -> String = { strings in strings[index] }

print(greetings[keyPath: path])
// "bonjour" 를 출력합니다.
print(fn(greetings))
// "bonjour" 를 출력합니다.

// 'index' 에 새 값을 설정하는 것은 'path' 에 영향을 주지 않습니다.
index += 1
print(greetings[keyPath: path])
// "bonjour" 를 출력합니다.

// 'fn' 이 'index' 를 잡아 가뒀기 때문에, 이는 새 값을 사용합니다.
print(fn(greetings))
// "안녕" 를 출력합니다.
```

_경로 (path)_ 는 '옵셔널 연쇄 (optional chaining)' 와 '강제 포장 풀기 (forced unwrapping)' 를 사용할 수 있습니다. 다음 코드는 '키 경로' 에서 옵셔널 연쇄를 사용하여 옵셔널 문자열의 속성에 접근합니다:

```swift
let firstGreeting: String? = greetings.first
print(firstGreeting?.count as Any)
// "Optional(5)" 를 출력합니다.

// 키 경로를 사용하여 같은 것을 합니다.
let count = greetings[keyPath: \[String].first?.count]
print(count as Any)
// "Optional(5)" 를 출력합니다.
```

타입 내에 깊숙이 중첩된 값에 접근하기 위해 '키 경로' 의 성분을 혼합하여 일치 여부를 맞춰볼 수 있습니다. 다음 코드는 이런 성분을 조합한 '키-경로 표현식' 을 사용하여 배열 딕셔너리의 서로 다른 값과 속성에 접근합니다.

```swift
let interestingNumbers = ["prime": [2, 3, 5, 7, 11, 13, 17],
                          "triangular": [1, 3, 6, 10, 15, 21, 28],
                          "hexagonal": [1, 6, 15, 28, 45, 66, 91]]
print(interestingNumbers[keyPath: \[String: [Int]].["prime"]] as Any)
// "Optional([2, 3, 5, 7, 11, 13, 17])" 을 출력합니다.
print(interestingNumbers[keyPath: \[String: [Int]].["prime"]![0]])
// "2" 를 출력합니다.
print(interestingNumbers[keyPath: \[String: [Int]].["hexagonal"]!.count])
// "7" 을 출력합니다.
print(interestingNumbers[keyPath: \[String: [Int]].["hexagonal"]!.count.bitWidth])
// "64" 를 출력합니다.
```

보통은 함수나 클로저를 제공하게 되는 상황에서 '키 경로 표현식' 을 사용할 수 있습니다. 특히, '근원 (root)' 타입은 `SomeType` 이면서 경로는 `Value` 타입의 값을 만드는 '키 경로 표현식' 을, `(SomeType) -> Value` 타입의 함수나 클로저 대신, 사용할 수 있습니다.

```swift
struct Task {
  var description: String
  var completed: Bool
}
var toDoList = [
  Task(description: "Practice ping-pong.", completed: false),
  Task(description: "Buy a pirate costume.", completed: true),
  Task(description: "Visit Boston in the Fall.", completed: false),
]

// 아래의 두 접근법은 모두 '동치 (equivalent)' 입니다.
let descriptions = toDoList.filter(\.completed).map(\.description)
let descriptions2 = toDoList.filter { $0.completed }.map { $0.description }
```

키 경로 식의 부작용은 어떤 것이든 표현식이 평가되는 그 시점에서만 평가됩니다. 예를 들어, 키 경로 표현식에 있는 첨자 연산에서 함수 호출을 하는 경우, 이 함수는, 키 경로를 사용하는 매 순간이 아니라, 표현식을 평가하면서 단 한번만 호출됩니다.

```swift
func makeIndex() -> Int {
  print("Made an index")
  return 0
}
// 아래 줄은 makeIndex() 를 호출합니다.
let taskKeyPath = \[Task][makeIndex()]
// "Made an index" 를 출력합니다.

// taskKeyPath 를 사용하면 makeIndex() 를 다시 호출하지 않습니다.
let someTask = toDoList[keyPath: taskKeyPath]
```

오브젝티브-C API 와 상호 작용하는 코드에서 '키 경로' 를 사용하는 방법에 대한 더 많은 정보는, [Using Objective-C Runtime Features in Swift](https://developer.apple.com/documentation/swift/using_objective-c_runtime_features_in_swift) 를 참고하기 바랍니다. '키-값 코딩 (key-value coding)' 및 '키-값 관찰 (key-value observing)' 에 대한 정보는, [Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i) 및 [Key-Value Observing Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i) 를 참고하기 바랍니다.

>> GRAMMAR OF A KEY-PATH EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Selector Expression (선택자 표현식)

_선택자 표현식 (selector expression)_ 은 오브젝티브-C 의 메소드나 속성의 '획득자 (getter)' 또는 '설정자 (setter)' 를 참조하는데 사용하는 '선택자 (selector)' 에 접근하도록 해줍니다. 형식은 다음과 같습니다:

\#selector(`method name-메소드 이름`)
<br />
\#selector(getter: `property name-속성 이름`)
<br />
\#selector(setter: `property name-속성 이름`)

_메소드 이름 (method name)_ 과 _속성 이름 (property name)_ 은 반드시 오브젝티드-C 런타임에서 사용 가능한 메소드나 속성에 대한 참조여야 합니다. 선택자 표현식의 값은 `Selector` 타입의 인스턴스입니다. 예를 들면 다음과 같습니다:

```swift
class SomeClass: NSObject {
  @objc let property: String

  @objc(doSomethingWithInt:)
  func doSomething(_ x: Int) { }

  init(property: String) {
    self.property = property
  }
}
let selectorForMethod = #selector(SomeClass.doSomething(_:))
let selectorForPropertyGetter = #selector(getter: SomeClass.property)
```

속성의 획득자 (getter) 에 대한 선택자를 생성할 때의, _속성 이름 (property name)_ 은 변수 또는 상수 속성에 대한 참조일 수 있습니다. 이와는 대조적으로, 속성의 설정자 (setter)에 대한 선택자를 생성할 때의, _속성 이름 (property name)_ 은 반드시 변수 속성에 대한 참조여야 합니다.

_메소드 이름 (method name)_ 은 그룹화를 위한 괄호와, 이름은 공유하지만 타입 서명은 서로 다른 메소드의 혼동을 막기 위한 `as` 연산자를 가질 수 있습니다. 예를 들면 다음과 같습니다:

```swift
extension SomeClass {
  @objc(doSomethingWithString:)
  func doSomething(_ x: String) { }
}
let anotherSelector = #selector(SomeClass.doSomething(_:) as (SomeClass) -> (String) -> Void)
```

선택자는, 실행 시간이 아니라, 컴파일 시간에 생성되기 때문에, 컴파일러가 메소드 또는 속성이 존재하는지 그리고 이들이 오브젝티브-C 런타임 쪽으로 노출되었는 지를 검사할 수 있습니다.

> 메소드 이름 (method name) 과 속성 이름 (property name) 은 표현식이긴 하지만, 값은 절대로 평가되지 않습니다.

오브젝티브-C API 와 상호 작용하는 선택자를 스위프트 코드에서 사용하는 것에 대한 더 많은 정보는, [Using Objective-C Runtime Features in Swift](https://developer.apple.com/documentation/swift/using_objective-c_runtime_features_in_swift) 를 참고하기 바랍니다.

> GRAMMAR OF A SELECTOR EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Key-Path String Expression (키 경로 문자열 표현식)

'키-경로 문자열 표현식 (key-path string expression)' 은, '키-값 코딩 (key-value coding)' 과 '키-값 관찰 (key-value observing)' API 를 사용하기 위해, 오브젝티브-C 에 있는 속성을 참조하는데 사용하는 문자열에 접근하도록 해줍니다. 형식은 다음과 같습니다:

\#keyPath(`property name-속성 이름`)

_속성 이름 (property name)_ 은 반드시 오브젝티브-C 런타임에서 사용 가능한 속성에 대한 참조여야 합니다. 컴파일 시간에, '키-경로 문자열 표현식' 은 '문자열 글자 값 (string literal)' 으로 대체됩니다. 예를 들면 다음과 같습니다:

```swift
class SomeClass: NSObject {
  @objc var someProperty: Int
  init(someProperty: Int) {
    self.someProperty = someProperty
  }
}

let c = SomeClass(someProperty: 12)
let keyPath = #keyPath(SomeClass.someProperty)

if let value = c.value(forKey: keyPath) {
  print(value)
}
// "12" 를 출력합니다.
```

클래스 내에서 키-경로 문자열 표현식을 사용할 때는, 해당 클래스의 속성을, 클래스 이름없이, 속성 이름만 작성하여 참조할 수 있습니다.

```swift
extension SomeClass {
  func getSomeKeyPath() -> String {
    return #keyPath(someProperty)
  }
}
print(keyPath == c.getSomeKeyPath())
// "true" 를 출력합니다.
```

키 경로 문자열은, 실행 시간이 아니라, 컴파일 시간에 생성되기 때문에, 컴파일러가 속성이 존재하는지 그리고 이 속성이 오브젝티브-C 런타임 쪽으로 노출되었는 지를 검사할 수 있습니다.

오브젝티브-C API 와 상호 작용하는 '키 경로 (key paths)' 를 스위프트 코드에서 사용하는 것에 대한 더 많은 정보는, [Using Objective-C Runtime Features in Swift](https://developer.apple.com/documentation/swift/using_objective-c_runtime_features_in_swift) 를 참고하기 바랍니다. '키-값 코딩 (key-value coding)' 및 '키-값 관찰 (key-value observing)' 에 대한 정보는, [Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i) 및 [Key-Value Observing Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i) 를 참고하기 바랍니다.

> 속성 이름 (property name) 은 표현식이지만, 절대로 값을 평가하지 않습니다.

> GRAMMAR OF A KEY-PATH STRING EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

### Postfix Expressions (접미사 표현식)

_접미사 표현식 (postfix expressions)_ 은 접미사 연산자 또는 다른 접미사 구문 표현을 표현식에 적용하여 형성합니다. 구문 표현으로는, 모든 '제1 표현식' 은 또한 '접미사 표현식' 이기도 합니다.

이 연산자들의 작동 방식에 대한 정보는, [Basic Operators (기초 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 및 [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) 를 참고하기 바랍니다.

스위프트 표준 라이브러리에서 제공하는 연산자에 대한 정보는, [Operator Declarations](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 를 참고하기 발랍니다.

> GRAMMAR OF A POSTFIX EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Function Call Expression (함수 호출 표현식)

_함수 호출 표현식 (function call expression)_ 은 함수 이름과 그 뒤에 함수 인자들을 쉼표로 구분한 목록을 괄호로 감싼 것으로 구성됩니다. '함수 호출 표현식' 은 다음과 같은 형식을 가집니다:

`function name-함수 이름`(`argument value 1-인자 값 1`, `argument value 2-인자 값 2`)

_함수 이름 (function name)_ 은 그 값이 함수 타입이라면 어떤 표현식이든 상관 없습니다.

함수 정의에서 매개 변수에 대한 이름을 포함하고 있는 경우, 함수 호출은 반드시 인자 값 앞에, 콜론 (`:`) 으로 구분된, 이름을 포함해야 합니다. 이런 종류의 '함수 호출 표현식' 은 다음과 같은 형식을 가집니다:

`function name-함수 이름`(`argument name 1-인자 이름 1`: `argument value 1-인자 값 1`, `argument name 2-인자 이름 2`: `argument value 2-인자 값 2`)

함수 호출 표현식은 닫는 괄호 바로 뒤에 '클로저 표현식' 형식인 '끝자리 클로저 (trailing closures)' 를 포함할 수 있습니다. 끝자리 클로저는 함수의 인자인 것으로 이해되며, 마지막으로 괄호로 묶인 인자 뒤에 추가됩니다. 첫 번째 '클로저 표현식' 은 이름표를 붙이지 않습니다; 추가적인 클로저 표현식은 어떤 것이든 그 앞에 '인자 이름표 (argument labels)' 를 붙입니다. 아래 예제는 끝자리 클로저 구문 표현을 사용하는 것과 사용하지 않는 서로 '동치 (version)' 인 함수 호출을 보여줍니다:

```swift
// someFunction 은 인자로 정수 하나와 클로저 하나를 받습니다.
someFunction(x: x, f: { $0 == 13 })
someFunction(x: x) { $0 == 13 }

// anotherFunction 은 인자로 정수 하나와 클로저 두 개를 받습니다.
anotherFunction(x: x, f: { $0 == 13 }, g: { print(99) })
anotherFunction(x: x) { $0 == 13 } g: { print(99) }
```

끝자리 클로저가 함수의 유일한 인자라면, 괄호를 생략할 수 있습니다.

```swift
// someMethod 는 유일한 인자로 클로저 하나를 받습니다.
myData.someMethod() { $0 == 13 }
myData.someMethod { $0 == 13 }
```

끝자리 클로저를 인자에 포함시키기 위해, 컴파일러는 다음과 같이 왼쪽에서 오른쪽으로 함수의 매개 변수를 검토합니다:

끝자리 클로저 || 매개 변수 || 행동
---|---|---|---|---
이름표 있음 | | 이름표 있음 | | 이름표가 같은 경우, 클로저는 매개 변수와 일치합니다; 다른 경우라면, 그 매개 변수는 건너 뜁니다.
이름표 있음 | | 이름표 없음 | | 그 매개 변수를 건너 뜁니다.
이름표 없음 | | 이름표 있음 또는 없음 | | 아래에서 정의한 것처럼, 매개 변수가 함수 타입과 '구조적으로 닮은 (structually resembles)' 경우, 클로저는 매개 변수와 일치합니다; 다른 경우라면, 그 매개 변수는 건너 뜁니다.

끝자리 클로저는 그와 일치하는 매개 변수에 대한 인자로 전달됩니다. 조사 과정 중에 건너 뛴 매개 변수는 전달된 인자를 가지지 않습니다-예를 들어, '기본 설정 매개 변수 (default parameter)' 를 사용할 수 있습니다. 일치하는 것을 찾은 후, 조사는 그 다음 끝자리 클로저와 그 다음 매개 변수로 계속됩니다. 일치 과정이 끝날 때는, 모든 끝자리 클로저가 반드시 일치하는 것을 가져야 합니다.

매개 변수가 입-출력 매개 변수가 아니면서, 다음 중의 하나에 해당하는 경우, 그 매개 변수는 함수 타입과 _구조적으로 닮은 (structually resembles)_ 것입니다:

* `(Bool) -> Int` 와 같이, 그 타입이 함수 타입인 매개 변수
* `@autoclosure ()-> ((Bool)-> Int)` 와 같이, 그 포장된 표현식의 타입이 함수 타입인 '자동 클로저 (autoclosure)' 매개 변수
* `((Bool) -> Int)...` 와 같이, 그 배열 원소 타입이 함수 타입인 '가변 (variadic)' 매개 변수
* `Optional<(Bool) -> Int>` 와 같이, 그 타입이 하나 이상의 옵셔널 '층 (layers)' 으로 포장된 매개 변수
* `(Optional<(Bool) -> Int>) ...` 와 같이, 그 타입이 이렇게 허용된 타입을 조합한 것인 매개 변수

끝자리 클로저가, 함수는 하니지만, 함수 타입과 '구조적으로 닮은' 타입인 매개 변수와 일치할 때, 그 클로저는 필요에 따라 '포장 (wrapped)' 됩니다. 예를 들어, 매개 변수의 타입이 옵셔널 타입인 경우, 이 클로저는 자동으로 `Optional` 로 포장됩니다.

이러한 일치 작업을 오른쪽에서 왼쪽으로 수행한-5.3 이전 스위프트 코드의 '이전 (migration)' 을 쉽게 하기 위해서, 컴파일러는 왼쪽-에서-오른쪽 그리고 오른쪽-에서-왼쪽 순서로 모두 검사합니다. 조사 방향으로 인해 다른 결과가 발생하는 경우, 예전 방식인 오른쪽-에서-왼쪽 순서를 사용하며 컴파일러가 경고를 생성합니다. 미래 버전의 스위프트는 항상 왼쪽-에서-오른쪽 순서를 사용할 것입니다.[^left-to-right]

```swift
typealias Callback = (Int) -> Int
func someFunction(firstClosure: Callback? = nil,
                  secondClosure: Callback? = nil) {
  let first = firstClosure?(10)
  let second = secondClosure?(20)
  print(first ?? "-", second ?? "-")
}

someFunction()  // "- -" 를 인쇄합니다.
someFunction { return $0 + 100 }  // 모호함 (ambiguous)
someFunction { return $0 } secondClosure: { return $0 }  // "10 20" 를 인쇄합니다.
```

위 예제에서, "모호함 (ambiguous)" 으로 표시한 함수 호출은 "- 120" 을 인쇄하고 스위프트 5.3 에서는 '컴파일러 경고' 를 일으킵니다. 미래 버전의 스위프트는 "110 -" 을 인쇄할 것입니다.

클래스, 구조체, 또는 열거체 타입은, [Methods with Special Names (특수한 이름을 가진 메소드)]({% post_url 2020-08-15-Declarations %}#methods-with-special-names-특수한-이름을-가진-메소드) 에서 설명한 것처럼, 여러 메소드 중 하나를 선언함으로써 '함수 호출 구문' 에 대한 '수월한 구문 표현 (syntatic sugar)' 을 사용하게 할 수 있습니다.

<p>
<strong id="implicit-conversion-to-a-pointer-type-포인터-타입으로의-암시적인-변환">Implicit Conversion to a Pointer Type (포인터 타입으로의 암시적인 변환)</strong>
</p>

함수 호출 표현식에서, 인자와 매개 변수가 서로 다른 타입인 경우, 컴파일러는 다음 목록에 있는 암시적인 변환 중 하나를 적용함으로써 이들의 타입을 일치하게 만들려고 합니다:

* `inout SomeType` 은 `UnsafePointer<SomeType>` 이나 `UnsafeMutablePointer<SomeType>` 이 될 수 있습니다.
* `inout Array<SomeType>` 은 `UnsafePointer<SomeType>` 이나 `UnsafeMutablePointer<SomeType>` 이 될 수 있습니다.
* `Array<SomeType>` 은 `UnsafePointer<SomeType>` 이 될 수 있습니다.
* `String` 은 `UnsafePointer<CChar>` 가 될 수 있습니다.

다음 두 '함수 호출' 은 서로 '동치 (equivalent)' 입니다:

```swift
func unsafeFunction(pointer: UnsafePointer<Int>) {
  // ...
}
var myNumber = 1234

unsafeFunction(pointer: &myNumber)
withUnsafePointer(to: myNumber) { unsafeFunction(pointer: $0) }
```

이 암시적인 변환들로 생성한 포인터는 함수 호출이 지속될 동안에만 유효합니다. 정의되지 않은 동작을 피하려면, 함수 호출이 끝난 후에는 코드가 절대로 포인터를 물고 있지 않음을 보장하기 바랍니다.

> 배열을 암시적으로 안전하지 않은 포인터로 변환할 때, 스위프트는 필요한 만큼 배열을 변환하거나 복사하여 배열 저장 공간이 딱 붙어있도록 보장해 줍니다. 예를 들어, 저장 공간에 대한 API 계약을 만들지 않은 `NSArray` 하위 클래스에서 `Array` 로 연동한 배열에 이 구문 표현을 사용할 수 있습니다. 배열의 저장 공간이 이미 딱 붙어 있어서, 암시적인 변환이 이 작업을 할 필요가 절대로 없음을 보증할 필요가 있으면, `Array` 대신 `ContiguousArray` 를 사용합니다.

`withUnsafePointer(to:)` 같은 명시적인 함수 대신 `&` 를 사용하는 것은 저-수준 C 함수 호출을, 특히 함수가 여러 포인터 인자를 취할 때, 더 이해하기 쉽도록 해줍니다. 하지만, 다른 스위프트 코드에서 함수를 호출할 때는, 안전하지 않은 API 를 명시적으로 사용하는 대신 `&` 를 사용하는 것을 피하도록 합니다.[^using-unsafe-API]

> GRAMMAR OF A FUNCTION CALL EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

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

#### Explicit Member Expression (명시적인 멤버 표현식)

_명시적인 멤버 표현식 (explicit member expression)_ 은 '이름 붙은 (named) 타입', 튜플, 또는 모듈의 멤버에 접근하게 해줍니다. 이는 항목과 멤버의 식별자 사이에 마침표 (`.`) 를 둬서 구성합니다.

`expression-표현식`.`member name-멤버 이름`

'이름 붙은 (named) 타입' 의 멤버는 타입에 대한 선언 또는 '익스텐션 (extension; 확장)' 에서 이름이 지어집니다. 예를 들면 다음과 같습니다:

```swift
class SomeClass {
  var someProperty = 42
}
let c = SomeClass()
let y = c.someProperty  // 멤버 접근
```

튜플의 멤버는 정수를 사용하여, '0' 부터 시작해서, 나타나는 순서대로 암시적으로 이름을 짓습니다. 예를 들면 다음과 같습니다:

```swift
var t = (10, 20, 30)
t.0 = t.1
// 이제 t 는 (20, 20, 30) 입니다.
```

모듈의 멤버는 해당 모듈의 '최상위 선언 (top-level declarations)' 에 접근합니다.

`dynamicMemberLookup` 특성으로 선언된 타입은, [Attributes (특성)]({% post_url 2020-08-14-Attributes %}) 에서 설명한 것처럼, 실행 시간에 조회되는 멤버를 포함합니다.

이름이 다른 것이라고는 인자 이름 뿐인 메소드들 또는 초기자들끼리 구별하려면, 인자 이름을 포함하고, 각각의 인자 이름 뒤에 콜론 (`:`) 을 붙입니다. 이름이 없는 인자에는 밑줄 (`_`) 을 작성합니다. '중복정의한 메소드 (overloaded methods)' 끼리 구별하려면, '타입 보조 설명 (type annotation)' 을 사용합니다. 예를 들면 다음과 같습니다:

```swift
class SomeClass {
  func someMethod(x: Int, y: Int) {}
  func someMethod(x: Int, z: Int) {}
  func overloadedMethod(x: Int, y: Int) {}
  func overloadedMethod(x: Int, y: Bool) {}
}
let instance = SomeClass()

let a = instance.someMethod              // 모호함
let b = instance.someMethod(x:y:)        // 모호하지 않음

let d = instance.overloadedMethod        // 모호함
let d = instance.overloadedMethod(x:y:)  // 아직 모호함
let d: (Int, Bool) -> Void  = instance.overloadedMethod(x:y:)  // 모호하지 않음
```

마침표가 줄의 시작에 있으면, '암시적인 멤버 표현식' 이 아니라, '명시적인 멤버 표현식' 인 것으로 이해합니다. 예를 들어, 아래에 나열한 것은 연쇄적인 메소드 호출을 여러 줄로 나누어서 하는 것을 보여줍니다:

```swift
let x = [10, 3, 20, 15, 4]
    .sorted()
    .filter { $0 > 5 }
    .map { $0 * 100 }
```

> GRAMMAR OF AN EXPLICIT MEMBER EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Postfix Self Expression (접미사 'self' 표현식)

접미사 `self` 표현식은 표현식 또는 타입의 이름, 바로 뒤의 `.self` 로 구성됩니다. 형식은 다음과 같습니다:

`expression`.self
<br />
`type`.self

첫 번째 형식은 _표현식 (expression)_ 의 값으로 평가됩니다. 예를 들어, `x.self` 는 `x`  라고 평가됩니다.

두 번째 형식은 _타입 (type)_ 의 값으로 평가됩니다. 타입을 값으로 접근하기 위해 이 형식을 사용합니다. 예를 들어, `SomeClass.self` 는 `SomeClass` 라는 타입 자체로 평가되기 때문에, 타입-수준의 인자를 받아 들이는 함수나 메소드에 전달할 수 있습니다.

> GRAMMAR OF A POSTFIX SELF EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Subscript Expression (첨자 연산 표현식)

_첨자 연산 표현식 (subscript expression)_ 은 연관된 첨자 연산 선언의 획득자 (getter) 와 설정자 (setter) 를 사용하는 첨자 연산 접근을 제공합니다. 형식은 다음과 같습니다:

`expression-표현식`[`index expressions-색인 표현식`]

첨자 연산 표현식의 값을 평가하기 위해서, 첨자 연산 매개 변수로 전달된 _색인 표현식 (index expressions)_ 을 써서  _표현식 (expression)_ 의 타입에 대한 '첨자 연산 획득자 (subscript getter)' 를 호출합니다. 값을 설정하기 위해서는, 같은 방식으로 '첨자 연산 설정자 (subscript setter)' 를 호출합니다.

첨자 연산 선언에 대한 정보는, [Protocol Subscript Declaration (프로토콜 첨자 연산 선언)]({% post_url 2020-08-15-Declarations %}#protocol-subscript-declaration-프로토콜-첨자-연산-선언) 를 참고하기 바랍니다.

> GRAMMAR OF A PROTOCOL SUBSCRIPT DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Forced-Value Expression (강제-값 표현식)

_강제-값 표현식 (forced-value expression)_ 은 `nil` 이 아니라고 확신하는 옵셔널 값의 포장을 풉니다. 형식은 다음과 같습니다:

`expression-표현식`!

_표현식 (expression)_ 의 값이 `nil` 이 아닌 경우라면, 옵셔널 값의 포장을 풀고 이와 관련된 옵셔널-아닌 타입으로 반환합니다. 다른 경우라면, 실행시간 에러가 발생합니다.

'강제-값 표현식' 으로 '포장이 풀린 값 (unwrapped value)' 은, 값 자체를 변경하거나, 값의 멤버 중 하나에 할당하는 것으로, 수정할 수 있습니다. 예를 들면 다음과 같습니다:

```swift
var x: Int? = 0
x! += 1
// x 는 이제 1 입니다.

var someDictionary = ["a": [1, 2, 3], "b": [10, 20]]
someDictionary["a"]![0] = 100
// someDictionary 는 이제 ["a": [100, 2, 3], "b": [10, 20]] 입니다.
```

> GRAMMAR OF A FORCED-VALUE EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Optional-Chaining Expression (옵셔널-연쇄 표현식)

_옵셔널-연쇄 표현식 (optional-chaining expression)_ 은 '접미사 표현식' 에서 옵셔널 값을 사용하기 위한 '간소화한 구문 표현 (simplified syntax)' 을 제공합니다. 형식은 다음과 같습니다:

`expression-표현식`?

'접미사 `?` 연산자' 는 표현식의 값을 바꾸지 않고도 표현식으로 '옵셔널-연쇄 표현식' 을 만듭니다.

옵셔널-연쇄 표현식은 반드시 접미사 표현식 내에서 나타내야 하는데, 이로써 접미자 표현식을 특수한 방법으로 평가하도록 합니다. 만약 옵셔널-연쇄 표현식의 값이 `nil` 이면, 접미사 표현식에 있는 다른 모든 연산을 무시하고 전체 접미사 표현식을 `nil` 로 평가합니다. 옵셔널-연쇄 표현식의 값이 `nil` 이 아니면, 옵셔널-연쇄 표현식 값의 포장을 풀어서 나머지 접미사 표현식을 평가할 때 사용합니다. 어느 경우이든, 접미사 표현식의 값은 여전히 옵셔널 타입입니다.

만약 옵셔널-연쇄 표현식을 가지고 있는 접미사 표현식이 다른 접미사 표현식 안에 중첩되어 있다면, 가장 바깥쪽 표현식만 옵셔널 타입을 반환합니다.[^outmost-expression] 아래 예제에서, `c` 가 `nil` 이 아닐 때는, 그 값의 포장을 풀어서, `.performAction()` 을 평가하는 데 사용하는 값인, `.property` 를 평가하는 데 사용합니다. 전체 표현식인 `c?.property.performAction()` 은 옵셔널 타입의 값을 가집니다.

```swift
var c: SomeClass?
var result: Bool? = c?.property.performAction()
```

다음 예제는 옵셔널 체인을 사용하지 않고 위 예제와 같은 작동을 하는 것을 보여줍니다.

```swift
var result: Bool?
if let unwrappedC = c {
    result = unwrappedC.property.performAction()
}
```

'옵셔널-연쇄 표현식' 으로 '포장이 풀린 값 (unwrapped value)' 은, 값 자체를 변경하거나, 값의 멤버 중 하나에 할당하는 것으로, 수정할 수 있습니다. 만약 옵셔널-연쇄 표현식의 값이 `nil` 이면, 할당 연산자의 오른-쪽에 있는 표현식은 평가하지 않습니다. 예를 들면 다음과 같습니다:

```swift
func someFunctionWithSideEffects() -> Int {
    return 42  // No actual side effects.
}
var someDictionary = ["a": [1, 2, 3], "b": [10, 20]]

someDictionary["not here"]?[0] = someFunctionWithSideEffects()
// someFunctionWithSideEffects is not evaluated
// someDictionary is still ["a": [1, 2, 3], "b": [10, 20]]

someDictionary["a"]?[0] = someFunctionWithSideEffects()
// someFunctionWithSideEffects is evaluated and returns 42
// someDictionary is now ["a": [42, 2, 3], "b": [10, 20]]
```

> GRAMMAR OF AN OPTIONAL-CHAINING EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

### 참고 자료

[^Expressions]: 원문은 [Expressions](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^side-effect]: 컴퓨터 용어에서 'side effect' 를 '부작용' 이라고 직역하는 것이 옳은 것인지는 잘 모르겠습니다. 위키피디아에서는 'side effect' 를 다음과 같이 설명하고 있습니다. 컴퓨터 과학에서, 연산, 함수, 또는 표현식이 'side effect' 를 가지고 있다는 것은 이들이 지역 범위 외부에 있는 상태 변수의 값을 수정하는 경우를 말하는 것으로, 즉 해당 연산의 호출 쪽에서 함수 반환이라는 '주요 효과 (main effect)' 외에 별도로 '관찰 가능한 효과' 를 가지는 것을 말합니다. 이러한 정의에 따르면, 'side effect' 를 '부작용' 이라기 보다는 '부수적인 효과' 정도로 이해해도 좋을 것입니다. 다만, 'side effect' 가 '부작용' 이라고 널리 쓰이고 있으므로, 컴퓨터 용어에서의 '부작용' 이란 의미를 앞서와 같이 이해할 수도 있을 것입니다. 보다 자세한 내용은 위키피디아의 [Side effect (computer science)](https://en.wikipedia.org/wiki/Side_effect_(computer_science)) 및 [부작용 (컴퓨터 과학)](https://ko.wikipedia.org/wiki/부작용_(컴퓨터_과학)) 항목을 참고하기 바랍니다.

[^playground-literal]: 예를 들어 '빨간색' 플레이그라운드 글자 값은 ![Playground Color](/assets/Swift/Swift-Programming-Language/Expressions-playground-literal.png){:width="100px"} 인데, 이를 복사하여 다른 편집기로 옮기면 `var color = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)` 과 같은 '특수 글자 값 구문 표현' 이 됩니다.

[^operator-declarations]: 원문 자체가 애플 개발자 사이트로 연결되는 링크로 되어 있습니다.

[^infix-binary-operator]: 이 책은 '중위 이항 연산자 (infix binary operator)' 와 '이항 중위 연산자 (binary infix operator)' 라는 말을 같이 사용하고 있는데, 편의를 위해서 '이항 중위 연산자' 로 통일하여 옮깁니다.

[^flat-list]: [.map()과 .flatMap()의 차이](https://kchanguk.tistory.com/56) 라는 글을 참고해 볼 때, '납작한 리스트 (flat list)' 는 각각의 항목이 가장 작은 단위의 단일 원소로 이루어진 '리스트' 자료 구조라고 추측할 수 있습니다.

[^foundation]: 여기서 'Foundation' 은 스위프트 프로그래밍을 하기 위해 애플에서 제공하고 있는 가장 기초가 되는 프레임웍이며, 스위프트에서는 보통 `import Foundation` 으로 불러오게 됩니다. 'Foundaton 타입' 이라면 'Foundation' 프레임웍에서 제공하고 있지만 스위프트 표준 라이브러리에 해당하는 타입은 아닌 것을 말한다고 이해할 수 있습니다.

[^mutating-method]: '값 타입 (value type)' 은 구조체와 열거체를 말하는 것이며, '변경 메소드 (mutating method)' 는 값 타입의 'self' 를 변경할 수 있는 메소드를 말합니다. 이 문장의 의미는 'self' 를 다른 인스턴스를 할당하는 것으로써 변경할 수도 있다는 의미입니다.

[^weak-and-unowned-capture]: 클로저는 클래스와 같이 '참조 타입' 이기 때문에, 클래스 안에 있는 클로저가 해당 클래스를 참조하면 '강한 참조 순환' 이 발생합니다. 이를 방지하기 위해 '약한 참조' 나 '소유되지 않은 참조' 가 필요합니다.

[^strength]: 여기서의 '강하기 (strength)' 는 'string (강한)'-'weak (약한)'-'unowned (소유되지 않은)' 등을 구분하는 말인 것으로 추측됩니다.

[^foced-unwrapping-expressions]: '강제로 포장을 푸는 표현식 (foced unwrapping expressions)' 의 정식 이름은 뒤에 나오는 [Forced-Value Expression (강제-값 표현식)](#forced-value-expression-강제-값-표현식) 인 것 같습니다.

[^outmost-expression]: 이 말은 옵셔널을 다시 옵셔널로 포장하지는 않는다는 말입니다. 좀 더 자세한 내용은 [Optional Chaining (옵셔널 연쇄)]({% post_url 2020-06-17-Optional-Chaining %}) 항목을 참고하기 바랍니다.

[^left-to-right]: 스위프트 5.3 버전 이전에 '오른쪽-에서-왼쪽' 순서를 사용한 것은 매개 변수에 '끝자리 클로저 (trailing closure)' 가 하나뿐이면서 가장 오른쪽 매개 변수로 존재 했기 때문이라고 생각됩니다. 이제 '끝자리 클로저' 가 여러 개가 될 수 있으므로 '왼쪽-에서-오른쪽' 순서를 적용한다고 볼 수 있습니다.

[^filePath-and-fildID]: `#file` 은 예전 버전에서는 '파일 및 모듈의 이름' 이었지만, 지금 버전에서는 '파일의 경로' 입니다. 이는 스위프트 5.3 에서 새로 생긴 `#fileID` 와 관련된 것으로 추측됩니다.

[^file-to-filePath-and-fildID]: 미래 버전의 스위프트에서는 `#file` 과 `#filePath` 의 역할을 확실하게 구분하려는 의도가 있는 것 같습니다. 이어지는 본문의 내용을 보면 `#filePath` 를 '출하용 프로그램' 에는 사용하지 말 것을 권하는데, 이러한 역할 구분은 '개인 정보 (privacy)' 보호 정책과도 관련이 있는 것으로 추측됩니다.

[^using-unsafe-API]: 이 말은 `&` 같은 '입-출력 매개 변수' 를 사용해서 '안전하지 않은 포인터' 로 암시적으로 변환하는 기능은 '저-수준 C 함수' 를 호출할 때만 사용하라는 의미입니다.
