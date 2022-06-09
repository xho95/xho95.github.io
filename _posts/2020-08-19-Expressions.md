---
layout: post
comments: true
title:  "Swift 5.5: Expressions (표현식)"
date:   2020-08-19 11:30:00 +0900
categories: Swift Language Grammar Expression
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Expressions](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html) 부분[^Expressions]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Expressions (표현식)

스위프트에는, 네 종류의 표현식이 있는데: 접두사 표현식과, 중위 표현식, 으뜸 표현식[^primary-expression], 및 접미사 표현식이 그것입니다. 표현식의 평가는 값을 반환하거나, 부작용[^side-effect] 을 일으키거나, 혹은 둘 다 합니다.

접두사 및 중위 표현식은 더 작은 표현식에 연산자를 적용하게 해줍니다. 으뜸 표현식은 개념상 가장 단순한 종류의 표현식으로, 값에 접근하는 방식을 제공합니다. 접미사 표현식은, 접두사 및 중위 표현식과 마찬가지로, 함수 호출과 멤버 접근 같은 접미사를 사용하여 더 복잡한 표현식을 제작하게 해줍니다. 각 종류의 표현식은 밑의 절에서 자세하게 설명합니다.

> GRAMMAR OF AN EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html)

### Prefix Expressions (접두사 표현식)

_접두사 표현식 (prefix expressions)_ 은 옵션인 접두사 연산자와 표현식을 조합합니다. 접두사 연산자는 하나의 인자로, 자신의 뒤에 있는 표현식을, 취합니다.

이 연산자 동작에 대한 정보는, [Basic Operators (기초 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 장과 [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) 장을 참고하기 바랍니다.

스위프트 표준 라이브러리에서 제공하는 연산자에 대한 정보는, [Operator Declarations](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 항목을 참고하기 바랍니다.

> GRAMMAR OF A PREFIX EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID384)

#### In-Out Expression (입-출력 표현식)

_입-출력 표현식 (in-out expression)_ 은 함수 호출 표현식에 입-출력 인자로 전달한 변수를 표시합니다.

&nbsp;&nbsp;&nbsp;&nbsp;\&`expression-표현식`

입-출력 매개 변수에 대한 더 많은 정보와 예제를 보려면, [In-Out Parameters (입-출력 매개 변수)]({% post_url 2020-06-02-Functions %}#in-out-parameters-입-출력-매개-변수) 부분을 참고하기 바랍니다.

입-출력 표현식은, [Implicit Conversion to a Pointer Type (포인터 타입으로의 암시적인 변환)](#implicit-conversion-to-a-pointer-type-포인터-타입으로의-암시적인-변환) 에서 설명하는 것처럼, 포인터가 필요한 상황에서 포인터-아닌 인자를 제공할 때도 사용합니다. 

> GRAMMAR OF AN IN-OUT EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID384)

#### Try Operator (try 연산자)

_try 표현식 (try expression)_ 은 `try` 연산자와 그 뒤의 에러를 던질 수 있는 표현식으로 구성됩니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;try `expression-표현식`

`try` 표현식의 값은 _표현식 (expression)_ 의 값입니다.

_옵셔널-try 표현식 (optional-try expression)_ 은 `try?` 연산자와 그 뒤의 에러를 던질 수 있는 표현식으로 구성됩니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;try? `expression-표현식`

_표현식 (expression)_ 이 에러를 던지지 않으면, 옵셔널-try 표현식의 값은 _표현식 (expression)_ 의 값을 담은 옵셔널입니다. 그 외의 경우, 옵셔널-try 표현식의 값이 `nil` 입니다.

_강제-try 표현식 (forced-try expression)_ 은 `try!` 연산자와 그 뒤의 에러를 던질 수 있는 표현식으로 구성됩니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;try! `expression-표현식`

강제-try 표현식의 값은 _표현식 (expression)_ 의 값입니다. _표현식 (expression)_ 이 에러를 던지면, 실행 시간 에러를 만듭니다.

중위 연산자의 왼-쪽 표현식에 `try` 나, `try?`, 또는 `try!` 를 표시할 땐, 중위 표현식 전체에 그 연산자를 적용합니다. 그렇더라도, 괄호를 사용하면 연산자의 적용 범위을 명시할 수 있습니다.

```swift
sum = try someThrowingFunction() + anotherThrowingFunction()   // 두 함수 호출 모두에 try 를 적용함
sum = try (someThrowingFunction() + anotherThrowingFunction()) // 두 함수 호출 모두에 try 를 적용함
sum = (try someThrowingFunction()) + anotherThrowingFunction() // 에러: 첫 번째 함수 호출에만 try 를 적용함
```

중위 연산자가 할당 연산자거나 `try` 표현식에 괄호친 게 아닌 한, 중위 연산자 오른-쪽에 `try` 표현식이 나타날 순 없습니다.

표현식이 `try` 와 `await` 연산자를 둘 다 포함하면, 반드시 `try` 연산자가 먼저 나타나야 합니다. 

`try` 와, `try?`, 및 `try!` 에 대한 더 많은 정보와 사용 예제를 보려면, [Error Handling (에러 처리)]({% post_url 2020-05-16-Error-Handling %}) 장을 참고하기 바랍니다.

> GRAMMAR OF A TRY EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID384)

#### Await Operator (`await` 연산자)

_await 표현식 (await expression)_ 은 `await` 연산자와 그 뒤의 비동기 연산 결과를 사용하는 표현식으로 구성됩니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;await `expression-표현식`

`await` 표현식의 값은 _표현식 (expression)_ 의 값입니다.

`await` 로 표시한 표현식을 _잠재적인 잠시 멈춤 지점 (potential suspension point)_ 이라고 합니다. 비동기 함수 실행은 `await` 로 표시한 각각의 표현식마다 잠시 멈출 수 있습니다. 여기다, 동시적 코드 실행은 다른 어떤 지점에서도 절대 잠시 멈추지 않습니다. 이는 잠재적인 잠시 멈춤 지점 사이의 코드가 불변성 (invariants) 을 일시적으로 깨길 요구하는 상태 업데이트를 안전하게 할 수 있도록, 그 다음 잠재적인 잠시 멈춤 지점 전에 업데이트를 완료한다는, 의미입니다.

`await` 표현식은, `async(priority:operation:)` 함수에 전달하는 뒤딸린 클로저 같은, 비동기 상황 안에서만 나타날 수 있습니다. `defer` 문의 본문이나, 동기 함수 타입의 자동 클로저 안에선 나타날 수 없습니다.

중위 연산자의 왼-쪽 표현식에 `await` 연산자를 표시할 땐, 중위 표현식 전체에 그 연산자를 적용합니다. 그렇더라도, 괄호를 사용하면 연산자의 적용 범위를 명시할 수 있습니다.

```swift
// 두 함수 호출 모두에 await 를 적용함
sum = await someAsyncFunction() + anotherAsyncFunction()

// 두 함수 호출 모두에 await 를 적용함
sum = await (someAsyncFunction() + anotherAsyncFunction())

// 에러: 첫 번째 함수 호출에만 await 를 적용함
sum = (await someAsyncFunction()) + anotherAsyncFunction()
```

중위 연산자가 할당 연산자거나 `await` 표현식에 괄호친 게 아닌 한, 중위 연산자 오른-쪽에 `await` 표현식이 나타날 순 없습니다.

표현식이 `try` 와 `await` 연산자를 둘 다 포함하면, 반드시 `try` 연산자가 먼저 나타나야 합니다. 

> GRAMMAR OF A AWAIT EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID384)

### Infix Expressions (중위 표현식)

_중위 표현식 (infix expressions)_ 은 중위 이항 연산자를 왼쪽 및 오른쪽 인자로 취한 표현식과 조합합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`left-hand argument-왼쪽 인자` `operator-연산자` `right-hand argument-오른쪽 인자`

이 연산자 동작에 대한 정보는, [Basic Operators (기초 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 장과 [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) 장을 참고하기 바랍니다.

스위프트 표준 라이브러리에서 제공하는 연산자에 대한 정보는, [Operator Declarations](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 항목을 참고하기 바랍니다.

> 구문 해석 시간에, 중위 연산자로 이뤄진 표현식은 납작한 리스트 (flat list)[^flat-list] 로 나타냅니다. 이 리스트에 연산자 우선 순위를 적용함으로써 트리 (tree) 로 변형합니다. 예를 들어, 초기에는 표현식 `2 + 3 * 5` 가 `2`, `+`, `3`, `*`, 및 `5` 라는 다섯 항목으로 된 납작한 리스트라고 이해합니다. 이 후 과정에서 이를 `(2 + (3 * 5))` 라는 트리로 변형합니다.

> GRAMMAR OF A INFIX EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID385)

#### Assignment Operator (할당 연산자)

_할당 연산자 (assignment operator)_ 는 주어진 표현식에 새 값을 설정합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식` = `value-값`

_표현식 (expression)_ 의 값을 _값 (value)_ 평가로 구한 값으로 설정합니다. _표현식 (expression)_ 이 튜플이면, _값 (value)_ 도 반드시 원소 개수가 동일한 튜플이어야 합니다. (중첩 튜플은 허용합니다.) 각 부분의 _값 (value)_ 에서 해당 부분의 _표현식 (expression)_ 으로 할당을 수행합니다. 예를 들면 다음과 같습니다:

```swift
(a, _, (b, c)) = ("test", 9.45, (12, 3))
// a 는 "test", b 는 12, c 는 3 이고, 9.45 는 무시함
```

할당 연산자는 어떤 값도 반환하지 않습니다.

> GRAMMAR OF AN ASSIGNMENT OPERATOR 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID385)

#### Ternary Conditional Operator (삼항 조건 연산자)

_삼항 조건 연산자 (ternary conditional operator)_ 는 조건 값을 기초로 하여 주어진 두 값 중 하나를 평가합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`condition-조건` ? `expression used if true-true 면 사용할 표현식` : `expression used if false-false 면 사용할 표현식`

_조건 (condition)_ 평가가 `true` 면, 조건 연산자가 첫 번째 표현식을 평가하고 그 값을 반환합니다. 그 외 경우, 두 번째 표현식을 평가하고 그 값을 반환합니다. 사용하지 않는 표현식은 평가하지 않습니다.

삼항 조건 연산자의 사용 예제는, [Ternary Conditional Operator (삼항 조건 연산자)]({% post_url 2016-04-27-Basic-Operators %}Ternary Conditional Operator (삼항 조건 연산자)) 부분을 참고하기 바랍니다.

> GRAMMAR OF A CONDITIONAL OPERATOR 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID385)

#### Type-Casting Operators (타입-변환 연산자)

네 개의 타입-변환 연산자가 있는데: `is` 연산자와, `as` 연산자, `as?` 연산자, 및 `as!` 연산자가 그것입니다.

형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식` is `type-타입`
&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식` as `type-타입`
&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식` as? `type-타입`
&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식` as! `type-타입`

`is` 연산자는 실행 시간에 _표현식 (expression)_ 을 특정 _타입 (type)_ 으로 변환할 수 있는 지 검사합니다. _표현식 (expression)_ 이 특정 _타입 (type)_ 으로 변환할 수 있으면 `true` 를 반환하며; 그 외 경우, `false` 를 반환합니다.

`as` 연산자는, 올림 변환[^upcasting] 이나 연동 (bridging)[^bridging] 같이, 변환이 항상 성공함을 컴파일 시간에 알 수 있을 때 하는 변환입니다. 올림 변환은, 중간 단계의 변수를 쓰지 않고도, 표현식을 그 타입의 상위 타입 인스턴스로 사용하게 해줍니다. 다음의 접근법은 서로 같은 겁니다:

```swift
func f(_ any: Any) { print("Function for Any") }
func f(_ int: Int) { print("Function for Int") }
let x = 10
f(x)
// "Function for Int" 를 인쇄함

let y: Any = x
f(y)
// "Function for Any" 를 인쇄함

f(x as Any)
// "Function for Any" 를 인쇄함
```

연동은 새로운 인스턴스를 생성할 필요 없이 `String` 같은 스위프트 표준 라이브러리 타입의 표현식을 `NSString` 같이 그에 해당하는 파운데이션 (Foundation)[^foundation] 타입으로 사용하게 해줍니다. 연동에 대한 더 많은 정보는, [Working with Foundation Types](https://developer.apple.com/documentation/swift/imported_c_and_objective-c_apis/working_with_foundation_types) 항목을 참고하기 바랍니다.

`as?` 연산자는 _표현식 (expression)_ 을 특정 _타입 (type)_ 으로 조건부 변환합니다. `as?` 연산자는 특정 _타입 (type)_ 에 대한 옵셔널을 반환합니다. 실행 시간에, 변환 성공하면, _표현식 (expression)_ 의 값을 옵셔널로 포장하여 반환하며; 그 외 경우, 반환 값이 `nil` 입니다. 특정 _타입 (type)_ 으로의 변환이 실패로 보증된 것 또는 성공으로 보증된 것이면, 컴파일-시간 에러가 일어납니다.

`as!` 연산자는 _표현식 (expression)_ 을 특정 _타입 (type)_ 으로 강제 변환합니다. `as!` 연산자는, 옵셔널 타입이 아닌, 특정 _타입 (type)_ 값을 반환합니다. 변환을 실패하면, 실행 시간 에러가 일어납니다. `x as! T` 는 `(x as? T)!` 와 똑같이 동작합니다.

타입 변환에 대한 더 많은 정보 및 타입-변환 연산자의 사용 예제는, [Type Casting (타입 변환)]({% post_url 2020-04-01-Type-Casting %}) 장을 참고하기 바랍니다.

> GRAMMAR OF A TYPE-CASTING OPERATOR 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID385)

### Primary Expressions (으뜸 표현식)

_으뜸 표현식 (primary expressions)_ 은 가장 기초적인 종류의 표현식입니다. 그 자체로 표현식으로 사용할 수도 있고, 다른 낱말과 조합하여 접두사 표현식과, 중위 표현식, 및 접미사 표현식을 만들 수도 있습니다.

> GRAMMAR OF A PRIMARY EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Literal Expression (글자 값 표현식)

_글자 값 표현식 (literal expression)_ 은 (문자열이나 수치 값 같은) 평범한 글자 값이나, 배열 및 딕셔너리 글자 값, 플레이그라운드 (playground) 글자 값, 또는 다음의 특수 글자 값 중 하나로 구성됩니다:

글자 값 || 타입 || 값
---|---|---|---|---
`#file` | | `String` | |  이 파일의 경로[^the-path]
`#fileID` | | `String` | | 이 파일과 모듈의 이름
`#filePath` | | `String` | | 이 파일의 경로
`#line` | | `Int` | | 이 줄의 번호
`#column` | | `Int` | | 이 시작 열의 번호
`#function` | | `String` | | 이 선언의 이름
`#dsohandle` | | `UnsafeRawPointer` | | 여기서 사용하는 동적 공유 객체[^dynamic-shared-object] 의 핸들

`#file` 의 문자열 값은 언어 버전에 의존하여, 예전 동작인 `#filePath` 를 새로운 동작인 `#fileID` 로 이주할 수 있게 합니다.[^filePath-and-fildID] 현재, `#file` 는 `#filePath` 값과 똑같습니다. 미래 버전의 스위프트에선, 그 대신 `#file` 가 `#fileID` 값과 똑같을 겁니다. 미래의 동작을 채택하려면, `#file` 을 `#fileID` 나 `#filePath` 로 적절하게 대체하기 바랍니다.[^file-to-filePath-and-fildID]

`#fileID` 표현식의 문자열 값은 _모듈/파일 (module/file)_ 형식인데, _파일 (file)_ 은 표현식이 있는 파일 이름이고 _모듈 (module)_ 은 이 파일이 속해 있는 모듈 이름입니다. `#filePath` 표현식의 문자열 값은 표현식이 있는 파일에 대한 '전체 파일-시스템 경로' 입니다. 이 두 값 모두, [Line Control Statement (라인 제어문)]({% post_url 2020-08-20-Statements %}#line-control-statement-라인-제어문) 에서 설명한 것처럼, `#sourceLocation` 으로 바꿀 수 있습니다. `#fileID` 는, `#filePath` 와는 달리, 소스 파일에 대한 '전체 경로' 를 집어 넣지 않기 때문에, 더 나은 '개인 정보 보호' 를 제공하며 '컴파일한 바이너리' 의 크기를 줄여줍니다. 테스트, 빌드 스크립트, 또는 그 외 '출하용 (shipping) 프로그램' 이 아닌 코드 밖에서 `#filePath` 사용을 피하도록 합니다.

> `#fileID` 표현식의 구문을 해석하려면, 모듈 이름은 첫 번째 빗금 (`/`) 앞의 문장을 읽고 파일 이름은 마지막 빗금 뒤의 문장을 읽습니다. 미래에는, 문자열이, `MyModule/some/disambiguation/MyFile.swift` 처럼, 여러 개의 빗금을 담을 수도 있습니다.

`#function` 의 값은, 함수 안에서는 해당 함수의 이름, 메소드 안에서는 해당 메소드의 이름, 속성의 '획득자' 나 '설정자' 안에서는 해당 속성의 이름, `init` 이나 `subscript` 같은 '특수한 멤버' 안에서는 해당 키워드의 이름, 그리고 파일의 최상단에서는 현재 모듈의 이름입니다.

'특수 글자 값' 을, 함수나 메소드 매개 변수의 '기본 값' 으로 사용할 때는, 호출한 쪽에서 '기본 값 표현식' 을 평가할 때 값이 결정됩니다.

```swift
func logFunctionName(string: String = #function) {
  print(string)
}
func myFunction() {
  logFunctionName() // "myFunction()" 를 인쇄합니다.
}
```

_배열 글자 값 (array literal)_ 은 값의 '순서가 있는 집합체 (ordered collection)'[^ordered-collection] 입니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;[`value 1-값 1`, `value 2-값 2`, `...`]

배열의 마지막 표현식 뒤에는 쉼표가 있어도 됩니다. '배열 글자 값' 의 타입은 `[T]` 인데, 여기서 `T` 는 안에 있는 표현식의 타입입니다. 여러 타입의 표현식으로 된 경우, `T` 는 '가장 가까운 공통 상위 타입 (closest common supertype)' 입니다. '빈 배열 글자 값' 은 '빈 대괄호 쌍' 을 사용하여 작성하며 특정 타입의 빈 배열을 생성하기 위해 사용할 수 있습니다.

```swift
var emptyArray: [Double] = []
```

_딕셔너리 글자 값 (dictionary literal)_ 은 '키-값 쌍 (key-value pairs) 의 순서 없는 집합체 (unordered collection)' 입니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;[`key 1-키 1`: `value 1-값 1`, `key 2-키 2`: `value 2-값 2`, `...`]

딕셔너리의 마지막 표현식 뒤에는 쉼표가 있어도 됩니다. '딕셔너리 글자 값' 의 타입은 `[Key : Value]` 인데, 여기서 `Key` 는 '키 (key) 표현식' 의 타입이고 `Value` 는 '값 (value) 표현식' 의 타입입니다. 여러 타입의 표현식으로 된 경우, `Key` 와 `Value` 는 각자의 값에 대한 '가장 가까운 공통 상위 타입' 입니다. '빈 딕셔너리 글자 값' 은 '빈 배열 글자 값' 과 구별하기 위해 '대괄호 쌍 안의 콜론 (`[:]`)' 으로 작성합니다. '빈 딕셔너리 글자 값' 을 사용하여 특정 키와 값 타입을 가진 '빈 딕셔너리 글자 값' 을 생성할 수 있습니다.

```swift
var emptyDictionary: [String : Double] = [:]
```

_플레이그라운드 글자 값 (playground literal)_ 은 '프로그램 편집기' 에서 색상, 파일, 또는 이미지에 대한 '상호 작용 가능한 표현' 을 생성하고자 '엑스코드 (Xcode)' 가 사용합니다. '엑스코드' 밖의 '평범한 문장' 에 있는 '플레이그라운드 글자 값' 은 '특수 글자 값 구문' 으로 표현합니다.[^playground-literal]

'엑스코드' 에서 '플레이그라운드 글자 값' 을 사용하는 정보는, '엑스코드 도움말 (Xcode Help)' 에 있는 [Add a color, file, or image literal](https://help.apple.com/xcode/mac/current/#/dev4c60242fc) 항목을 참고하기 바랍니다.

> GRAMMAR OF A LITERAL EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Self Expression ('self' 표현식)

`self` 표현식은 자신의 현재 타입 또는 타입의 인스턴스에 대한 명시적인 참조입니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;self
<br />
&nbsp;&nbsp;&nbsp;&nbsp;self.`member name-멤버 이름`
<br />
&nbsp;&nbsp;&nbsp;&nbsp;self [`subscript index-첨자 연산 색인`]
<br />
&nbsp;&nbsp;&nbsp;&nbsp;self (`initializer arguments-초기자 인자`)
<br />
&nbsp;&nbsp;&nbsp;&nbsp;self.init(`initializer arguments-초기자 인자`)

초기자, 첨자 연산, 또는 인스턴스 메소드 안에서의, `self` 는 자신의 타입에 대한 '현재 인스턴스' 를 참조합니다. 타입 메소드 안에서의, `self` 는 자신의 '현재 타입' 을 참조합니다.

`self` 표현식은, 함수 매개 변수 같이, 영역에 똑같은 이름의 또 다른 변수가 있을 때의 모호함을 없애면서, 멤버에 접근할 때의 영역을 지정하고지 사용합니다. 예를 들면 다음과 같습니다:

```swift
class SomeClass {
  var greeting: String
  init(greeting: String) {
    self.greeting = greeting
  }
}
```

'값 타입' 의 변경 메소드 안에서는, 해당 값 타입의 새로운 인스턴스를 `self` 에 할당할 수 있습니다.[^mutating-method] 예를 들면 다음과 같습니다:

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

&nbsp;&nbsp;&nbsp;&nbsp;super.`memeber name-멤버 이름`
&nbsp;&nbsp;&nbsp;&nbsp;super[`subscript index-첨자 연산 색인`]
&nbsp;&nbsp;&nbsp;&nbsp;super.init(`initializer arguments-초기자 인자`)

첫 번째 형식은 상위 클래스의 멤버에 접근하려고 사용합니다. 두 번째 형식은 상위 클래스의 첨자 연산 구현에 접근하려고 사용합니다. 세 번째 형식은 상위 클래스의 초기자에 접근하려고 사용합니다.

하위 클래스는 자신의 상위 클래스에 있는 구현을 사용하기 위해 자신의 멤버, 첨자 연산, 그리고 초기자 구현에서 '상위 클래스 표현식' 을 사용할 수 있습니다.

> GRAMMAR OF A SUPERCLASS EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Closure Expression (클로저 표현식)

_클로저 표현식 (closure expression)_ 은, 다른 프로그래밍 언어에서는 _람다 (lambda)_ 또는 _익명 함수 (anonymous function)_ 라고도 하는, '클로저' 를 생성합니다. '함수 선언' 같이, 클로저는 구문을 담으며, 자신을 둘러싼 영역의 상수와 변수를 '붙잡습니다 (capture)'. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;{ (`parameter-매개 변수`) -> `return type-반환 타입` in<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

_매개 변수 (parameter)_ 는, [Function Declaration (함수 선언)]({% post_url 2020-08-15-Declarations %}#function-declaration-함수-선언) 에서 설명한 것처럼, 함수 선언의 매개 변수와 형식이 똑같습니다.

클로저는 더 간결하게 작성하게 하는 여러 특수 형식들이 있습니다:

* 클로저는 매개 변수의 타입이나, 반환 타입을, 또는 둘 다를 생략할 수 있습니다. 매개 변수 이름과 타입 둘 다를 생략할 경우, 구문 앞의 `in` 키워드를 생략합니다. 생략한 타입을 추론할 수 없으면, 컴파일-시간 에러를 일으킵니다.
* 클로저는 자신의 매개 변수 이름을 생략할 수도 있습니다. 그러면 매개 변수에: `$1`, `$2`, 등과 같이 `$` 뒤에 자신의 위치가 붙은 이름을 암시적으로 붙입니다.
* 단일 표현식만으로 구성한 클로저는 해당 표현식의 값을 반환한다고 이해합니다. 주위 표현식에 대한 타입 추론을 할 때 이 표현식의 내용도 고려합니다.

다음 클로저 표현식들은 '동치 (equivalent)' 입니다:

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

클로저를 함수의 인자로 전달하는 것에 대한 정보는, [Function Call Expression (함수 호출 표현식)](#function-call-expression-함수-호출-표현식) 부분을 참고하기 바랍니다.

클로저 표현식은, 함수 호출에서 클로저를 곧바로 사용할 때 처럼, 변수나 상수에 저장하지 않고도 사용할 수 있습니다. 위 코드에서 `myFunction` 에 전달한 클로저 표현식은 이 '곧바로 사용' 하는 한 예입니다. 그 결과, 클로저 표현식이 '벗어나는 (escaping)' 지 '벗어나지 않는 (nonescaping)' 지는 표현식의 주위 상황에 달려 있습니다. 곧바로 호출하거나 '벗어나지 않는 함수 인자' 로 전달한 경우의 클로저 표현식은 '벗어나지 않는' 것입니다. 그 외의 경우, 클로저 표현식은 '벗어나는' 것입니다.

'벗어나는 클로저' 에 대한 더 많은 정보는, [Escaping Closures (벗어나는 클로저)]({% post_url 2020-03-03-Closures %}#escaping-closures-벗어나는-클로저) 부분을 참고하기 바랍니다.

<p>
<strong id="capture-lists-붙잡을-목록">Capture Lists (붙잡을 목록)</strong>
</p>

기본적으로, 클로저 표현식은 주위 영역에 있는 상수와 변수를 그 값에 대한 '강한 참조 (strong references)' 로 붙잡습니다. 클로저에서 값을 붙잡을 방법을 명시적으로 제어하기 위해서 _붙잡을 목록 (capture list)_ 을 사용할 수 있습니다.

'붙잡을 목록' 은 쉼표로-구분한 표현식 목록을, 매개 변수 목록 앞에, 대괄호로 둘러싸서 작성합니다. '붙잡을 목록' 을 사용하면, 매개 변수 이름, 매개 변수 타입, 그리고 반환 타입을 생략한 경우에도, 반드시 `in` 키워드를 같이 사용해야 합니다.

'붙잡을 목록' 에 있는 '요소 (entries)' 들은 클로저를 생성할 때 초기화 됩니다. 붙잡을 목록의 각 요소마다, 주위 영역에서 똑같은 이름을 가진 상수나 변수 값에 대한 상수가 초기화 됩니다. 아래 코드 예제에서, `a` 는 '붙잡을 목록' 에 포함되지만 `b` 는 아니어서, 서로 다른 동작을 합니다.

```swift
var a = 0
var b = 0
let closure = { [a] in
  print(a, b)
}

a = 10
b = 10
closure()
// "0 10" 를 인쇄합니다.
```

`a` 라는 이름은, '주위 영역의 변수' 와 '클로저 영역의 상수' 라는, 서로 다른 두 가지가 있지만, `b` 라는 이름의 변수는 하나뿐입니다. 안쪽 영역의 `a` 는 클로저를 생성할 때 바깥 영역에 있는 `a` 값으로 초기화 되지만, 이 값들은 어떤 특수한 방식으로든 연결되지 않습니다. 이는 바깥 영역의 `a` 값을 바꿔도 안쪽 영역의 `a` 값에 영향을 주지 않으며, 클로저 안의 `a` 를 바꿔도 클로저 밖의 `a` 값에 영향을 주지 않는다는 의미입니다. 이와 대조적으로, `b` 라는 이름의 변수는-바깥 영역의 `b` 라는-하나만 있으므로 클로저 안팎에서 바뀌면 양쪽에서 다 볼 수 있습니다.

이런 구별은 '붙잡은 변수' 의 타입이 '참조 의미 구조 (reference semantics)'[^reference-semantics] 를 가질 때는 보이지 않습니다. 예를 들어, 아래 코드에는 `x` 라는 이름이, '바깥 영역의 변수' 와 '안쪽 영역의 상수' 라는, 두 가지가 있지만, '참조 의미 구조' 이기 때문에 둘 다 똑같은 객체를 참조합니다.

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
// "10 10" 을 인쇄합니다.
```

표현식 값의 타입이 클래스라면, '붙잡을 목록' 에 있는 표현식을 `weak` 나 `unowned` 로 표시하여 표현식의 값을 '약한 참조' 나 '소유하지 않는 참조' 로 붙잡을 수 있습니다.[^weak-and-unowned-capture]

```swift
myFunction { print(self.title) }                    // 암시적으로 강하게 붙잡기 (implicit strong capture)
myFunction { [self] in print(self.title) }          // 명시적으로 강하게 붙잡기 (explicit strong capture)
myFunction { [weak self] in print(self!.title) }    // 약하게 붙잡기 (weak capture)
myFunction { [unowned self] in print(self.title) }  // 소유하지 않게 붙잡기 (unowned capture)
```

'붙잡을 목록' 에서는 '임의의 표현식' 을 '이름 붙인 변수' 에 연결할 수도 있습니다. 표현식은 클로저를 생성할 때 평가하며, 값은 지정한 '강하기 (strength)'[^strength] 로 붙잡습니다. 예를 들면 다음과 같습니다:

```swift
// "self.parent" 를 "parent" 로 약하게 붙잡기
myFunction { [weak parent = self.parent] in print(parent!.title) }
```

클로저 표현식에 대한 더 많은 정보와 예제는, [Closure Expressions (클로저 표현식)]({% post_url 2020-03-03-Closures %}#closure-expressions-클로저-표현식) 부분을 참고하기 바랍니다. '붙잡을 목록 (capture list)' 에 대한 더 많은 정보와 예제는, [Resolving Strong Reference Cycles for Closures (클로저의 강한 참조 순환 해결하기)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#resolving-strong-reference-cycles-for-closures-클로저의-강한-참조-순환-해결하기) 부분을 참고하기 바랍니다.

> GRAMMAR OF A CLOSURE EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Implicit Member Expression (암시적인 멤버 표현식)

_암시적인 멤버 표현식 (implicit member expression)_ 은, '열거체 case 값' 이나 '타입 메소드' 같이, 타입 추론이 '암시 (implied) 타입' 을 결정할 수 있는 상황에서, 타입의 멤버에 접근하는 단축 방식입니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;.`member name-멤버 이름`

예를 들면 다음과 같습니다:

```swift
var x = MyEnumeration.someValue
x = .anotherValue
```

추론한 타입이 옵셔널이면, '암시적인 멤버 표현식' 에서 '옵셔널-아닌 타입' 의 멤버를 사용할 수도 있습니다.

```swift
var someOptional: MyEnumeration? = .someValue
```

'암시적인 멤버 표현식' 뒤에는 [Postfix Expressions (접미사 표현식)](#postfix-expressions-접미사-표현식) 에서 나열한 '접미사 연산자' 또는 다른 '접미사 구문' 이 따라 올 수 있습니다. 이를 _연쇄된 암시적인 멤버 표현식 (chained implicit member expression)_ 이라고 합니다. 연쇄된 모든 접미사 표현식이 똑같은 타입을 가지는 것이 흔하긴 하지만, 유일한 필수 조건은 '연쇄된 암시적인 멤버 표현식' 전체가 '자신의 상황이 암시하는 타입' 으로 변환 가능할 필요가 있다는 것 뿐입니다. 특히, '암시 타입' 이 옵셔널이면 '옵셔널-아닌 타입' 의 값을 사용할 수 있으며, '암시 타입' 이 클래스 타입이면 자신의 하위 클래스 타입 중 하나의 값을 사용할 수 있습니다. 예를 들면 다음과 같습니다:

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

위 코드에서, `x` 의 타입은 '자신의 상황이 암시하는 타입'[^implied-type] 과 정확하게 일치하고, `y` 의 타입은 `SomeClass` 에서 `SomeClass?` 로 변환 가능하며, `z` 의 타입은 `SomeSubclass` 에서 `SomeClass` 로 변환 가능합니다.

> GRAMMAR OF A IMPLICIT MEMBER EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Parenthesized Expression (괄호 표현식)

_괄호 표현식 (parenthesized expression)_ 은 괄호로 주위를 둘러싼 표현식으로 구성됩니다. 괄호를 사용하면 표현식 그룹을 명시함으로써 연산의 우선권을 지정할 수 있습니다. 괄호로 그룹짓는 것은 표현식의 타입을 바꾸지 않습니다-예를 들어, `(1)` 의 타입은 단순히 `Int` 입니다.

> GRAMMAR OF A PARENTHESIZED MEMBER EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Tuple Expression (튜플 표현식)

_튜플 표현식 (tuple expression)_ 은 쉼표로-구분한 표현식 목록을 괄호로 둘러싸서 구성합니다. 각각의 표현식은 선택 사항으로 자신의 앞에, 콜론 (`:`) 으로 구분한, 식별자를 가질 수 있습니다. 형식은 다음과 같습니다:

(`identifier 1-식별자 1`: `expression 1-표현식 1`, `identifier 2-식별자 2`: `expression 2-표현식 2`, `...`)

튜플 표현식에 있는 각 식별자는 튜플 표현식 영역에서 반드시 유일해야 합니다. '중첩된 튜플 표현식' 에서는, 중첩 수준이 똑같은 식별자는 반드시 유일해야 합니다. 예를 들어, `(a: 10, a: 20)` 은 똑같은 수준에 `a` 라는 이름표가 두 번 있기 때문에 무효입니다. 하지만, `(a: 10, b: (a: 1, x: 2))` 는-비록 `a` 가 두 번 있을지라도, 바깥 튜플에 한 번 안쪽 튜플에 한 번 있으므로-유효입니다.

튜플 표현식은 '0' 개의 표현식을 담거나, 두 개 이상의 표현식을 담을 수 있습니다. 괄호 안에 단일 표현식이 있으면 '괄호 표현식' 입니다.

> '빈 튜플 표현식' 과 '빈 튜플 타입' 은 스위프트에서 둘 다 `()` 라고 작성합니다. `Void` 는 `()` 에 대한 '타입 별명' 이기 때문에, '빈 튜플 타입' 을 작성하기 위해 이를 사용할 수 있습니다. 하지만, 모든 '타입 별명' 들 처럼, `Void` 는 항상 '타입' 입니다-'빈 튜플 표현식' 을 작성하기 위해 이를 사용할 수는 없습니다.

> GRAMMAR OF A TUPLE EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Wildcard Expression (와일드카드 표현식)

_와일드카드 표현식 (wildcard expression)_ 은 할당 중에 명시적으로 값을 무시하고자 사용합니다. 예를 들어, 다음 할당은 '10' 을 `x` 에 할당하며 '20' 은 무시합니다:

```swift
(x, _) = (10, 20)
// x 는 10 이고, 20 은 무시합니다.
```

> GRAMMAR OF A WILDCARD EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Key-Path Expression (키-경로 표현식)

_키-경로 표현식 (key-path expression)_ 은 타입의 속성이나 첨자 연산을 참조합니다. '키-경로 표현식' 은, '키-값 관찰 (observing)' 같은, 동적 프로그래밍 임무에 사용합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;\\`type name-타입 이름`.`path-경로`

_타입 이름 (type name)_ 은, `String`, `[Int]`, 또는 `Set<Int>` 같은, '일반화 (generic) 매개 변수' 를 포함한, '고정 타입' 의 이름입니다.

_경로 (path)_ 는 속성 이름, 첨자 연산, '옵셔널-연쇄 (optional-chaining) 표현식', 그리고 '강제로 포장을 푸는 (foced unwrapping) 표현식' 으로 구성됩니다. 이 각각의 '키-경로 성분' 은 필요한 만큼 많이, 어떤 순서로든, 반복할 수 있습니다.

컴파일 시간에, 키-경로 표현식은 [KeyPath](https://developer.apple.com/documentation/swift/keypath) 클래스의 인스턴스로 대체합니다.

'키-경로' 를 사용하여 값에 접근하려면, 모든 타입에서 사용 가능한, `subscript(keyPath:)` 첨자 연산에 그 '키 경로' 를 전달합니다. 예를 들면 다음과 같습니다:

```swift
struct SomeStructure {
  var someValue: Int
}

let s = SomeStructure(someValue: 12)
let pathToProperty = \SomeStructure.someValue

let value = s[keyPath: pathToProperty]
// value 는 12 입니다.
```

_타입 이름 (type name)_ 은 타입 추론이 암시 타입을 결정할 수 있는 상황이면 생략할 수 있습니다. 다음 코드는 `\SomeClass.someProperty` 대신 `\.someProperty` 를 사용합니다:

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

_경로 (path)_ 는 '자기 식별 (identity) 키 경로 (`\.self`)' 를 생성하는 `self` 를 참조할 수 있습니다. '자기 식별 키 경로' 는 인스턴스 전체를 참조하므로, 변수에 저장한 모든 데이터를 한 번에 접근하고 바꿀 수 있습니다. 예를 들면 다음과 같습니다:

```swift
var compoundValue = (a: 1, b: 2)
// compoundValue = (a: 10, b: 20) 와 '동치 (equivalent)' 임
compoundValue[keyPath: \.self] = (a: 10, b: 20)
```

_경로 (path)_ 는, 속성 값의 속성을 참조하기 위해, 마침표로 구분한, 여러 개의 속성 이름을 담을 수 있습니다. 다음 코드는 `OuterStructure` 타입의 `outer` 속성에 있는 `someValue` 속성에 접근하려고 `\OuterStructure.outer.someValue` 라는 '키 경로 표현식' 을 사용합니다:

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

_경로 (path)_ 는, 첨자 연산의 매개 변수 타입이 `Hashable` 프로토콜을 준수하면, 대괄호를 써서 첨자 연산을 포함할 수 있습니다. 다음 예제는 배열에 있는 두 번째 원소에 접근하기 위해 '키 경로' 에서 첨자 연산을 사용합니다.

```swift
let greetings = ["hello", "hola", "bonjour", "안녕"]
let myGreeting = greetings[keyPath: \[String].[1]]
// myGreeting 은 'hola' 입니다.
```

첨자 연산에서 사용하는 값은 '이름 붙인 (named) 값' 이나 '글자 값 (literal)' 일 수 있습니다. '키 경로' 는 '값 의미 구조 (value semantics)' 를 사용하여 값을 붙잡습니다. 다음 코드는 `greetings` 배열의 세 번째 원소에 접근하기 위해 키-경로 표현식과 클로저 둘 다 `index` 변수를 사용합니다. `index` 를 수정하면, 키-경로 표현식은 여전히 세 번째 원소를 참조하는 반면, 클로저는 새로운 색인을 사용합니다.

```swift
var index = 2
let path = \[String].[index]
let fn: ([String]) -> String = { strings in strings[index] }

print(greetings[keyPath: path])
// "bonjour" 를 인쇄합니다.
print(fn(greetings))
// "bonjour" 를 인쇄합니다.

// 'index' 에 새 값을 설정해도 'path' 에는 영향을 주지 않습니다.
index += 1
print(greetings[keyPath: path])
// "bonjour" 를 인쇄합니다.

// 'fn' 이 'index' 를 잡아 가두기 때문에, 새 값을 사용합니다.
print(fn(greetings))
// "안녕" 를 인쇄합니다.
```

_경로 (path)_ 는 '옵셔널 연쇄 (optional chaining)' 와 '강제 포장 풀기 (forced unwrapping)' 를 사용할 수 있습니다. 다음 코드는 옵셔널 문자열의 속성에 접근하기 위해 '키 경로' 에서 '옵셔널 연쇄' 를 사용합니다:

```swift
let firstGreeting: String? = greetings.first
print(firstGreeting?.count as Any)
// "Optional(5)" 를 인쇄합니다.

// 키 경로를 써서 똑같이 합니다.
let count = greetings[keyPath: \[String].first?.count]
print(count as Any)
// "Optional(5)" 를 인쇄합니다.
```

타입 안에 깊숙하게 중첩된 값에 접근하기 위해 '키 경로' 성분을 섞어서 일치시킬 수 있습니다. 다음 코드는 이 성분들을 조합한 '키-경로 표현식' 을 사용함으로써 배열 딕셔너리의 서로 다른 값과 속성에 접근합니다.

```swift
let interestingNumbers = ["prime": [2, 3, 5, 7, 11, 13, 17],
                          "triangular": [1, 3, 6, 10, 15, 21, 28],
                          "hexagonal": [1, 6, 15, 28, 45, 66, 91]]
print(interestingNumbers[keyPath: \[String: [Int]].["prime"]] as Any)
// "Optional([2, 3, 5, 7, 11, 13, 17])" 을 인쇄합니다.
print(interestingNumbers[keyPath: \[String: [Int]].["prime"]![0]])
// "2" 를 인쇄합니다.
print(interestingNumbers[keyPath: \[String: [Int]].["hexagonal"]!.count])
// "7" 을 인쇄합니다.
print(interestingNumbers[keyPath: \[String: [Int]].["hexagonal"]!.count.bitWidth])
// "64" 를 인쇄합니다.
```

'키 경로 표현식' 은 보통이라면 함수나 클로저를 제공할만한 상황에서 사용할 수 있습니다. 특히, '근원 (root) 타입' 은 `SomeType` 이고 경로는, `(SomeType) -> Value` 타입의 함수나 클로저 대신, `Value` 타입의 값을 만드는 '키 경로 표현식' 을 사용할 수 있습니다.

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

// 아래 접근 방식 둘 다 '동치 (equivalent)' 입니다.
let descriptions = toDoList.filter(\.completed).map(\.description)
let descriptions2 = toDoList.filter { $0.completed }.map { $0.description }
```

키 경로 표현식의 부작용이라면 표현식을 평가하는 그 시점에만 평가한다는 것입니다. 예를 들어, 키 경로 표현식에 있는 첨자 연산 안에서 함수 호출을 하면, 키 경로를 사용할 때마다가 아닌, 표현식 평가 때 단 한번만 함수를 호출합니다.

```swift
func makeIndex() -> Int {
  print("Made an index")
  return 0
}
// 아래 줄은 makeIndex() 를 호출합니다.
let taskKeyPath = \[Task][makeIndex()]
// "Made an index" 를 인쇄합니다.

// taskKeyPath 를 사용해도 makeIndex() 를 다시 호출하진 않습니다.
let someTask = toDoList[keyPath: taskKeyPath]
```

오브젝티브-C API 와 상호 작용하는 코드에서 '키 경로' 를 사용하는 것에 대한 더 많은 정보는, [Using Objective-C Runtime Features in Swift](https://developer.apple.com/documentation/swift/using_objective-c_runtime_features_in_swift) 항목을 참고하기 바랍니다. '키-값 코딩 (key-value coding)' 과 '키-값 관찰 (key-value observing)' 에 대한 정보는, [Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i) 항목과 [Key-Value Observing Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i) 항목을 참고하기 바랍니다.

>> GRAMMAR OF A KEY-PATH EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Selector Expression (선택자 표현식)

_선택자 표현식 (selector expression)_ 은 오브젝티브-C 에 있는 메소드나 속성의 '획득자 (getter)' 또는 '설정자 (setter)' 를 참조하기 위한 '선택자 (selector)' 에 접근하도록 합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;\#selector(`method name-메소드 이름`)<br />
&nbsp;&nbsp;&nbsp;&nbsp;\#selector(getter: `property name-속성 이름`<br />
&nbsp;&nbsp;&nbsp;&nbsp;\#selector(setter: `property name-속성 이름`)

_메소드 이름 (method name)_ 과 _속성 이름 (property name)_ 은 반드시 '오브젝티드-C 런타임' 에서 사용 가능한 메소드나 속성의 참조여야 합니다. '선택자 표현식' 의 값은 `Selector` 타입의 인스턴스입니다. 예를 들면 다음과 같습니다:

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

속성의 획득자를 위해 선택자를 생성할 때는, _속성 이름 (property name)_ 이 변수나 상수 속성의 참조일 수 있습니다. 이와 대조적으로, 속성의 설정자를 위해 선택자를 생성할 때는, _속성 이름 (property name)_ 이 반드시 변수 속성의 참조여야만 합니다.

_메소드 이름 (method name)_ 은, 이름은 공유하지만 '타입 서명' 은 서로 다른 메소드 사이의 모호함을 없애기 위한 `as` 연산자 뿐만 아니라, 그룹짓기를 위한 괄호도 담을 수 있습니다. 예를 들면 다음과 같습니다:

```swift
extension SomeClass {
  @objc(doSomethingWithString:)
  func doSomething(_ x: String) { }
}
let anotherSelector = #selector(SomeClass.doSomething(_:) as (SomeClass) -> (String) -> Void)
```

선택자는, 실행 시간이 아니라, 컴파일 시간에 생성하기 때문에, 컴파일러가 메소드나 속성이 존재하며 '오브젝티브-C 런타임' 으로 노출되고 있는 지를 검사할 수 있습니다.

> 비록 _메소드 이름 (method name)_ 과 _속성 이름 (property name)_ 이 '표현식' 일지라도, 이를 절대로 평가하지 않습니다.

오브젝티브-C API 와 상호 작용하는 스위프트 코드에서 선택자를 사용하는 것에 대한 더 많은 정보는, [Using Objective-C Runtime Features in Swift](https://developer.apple.com/documentation/swift/using_objective-c_runtime_features_in_swift) 항목을 참고하기 바랍니다.

> GRAMMAR OF A SELECTOR EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Key-Path String Expression (키 경로 문자열 표현식)

'키-경로 문자열 표현식' 은, '키-값 코딩 (coding)' 과 '키-값 관찰 (observing)' API 에서 사용하기 위해, 오브젝티브-C 의 속성 참조에 사용하는 문자열을 접근하도록 합니다.[^key-path-string-expression] 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;\#keyPath(`property name-속성 이름`)

_속성 이름 (property name)_ 은 반드시 '오브젝티브-C 런타임' 에서 사용 가능한 속성의 참조여야 합니다. 컴파일 시간에, '키-경로 문자열 표현식' 은 '문자열 글자 값 (literal)' 으로 대체됩니다. 예를 들면 다음과 같습니다:

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
// "12" 를 인쇄합니다.
```

클래스 안에서 '키-경로 문자열 표현식' 을 사용할 때는, 클래스 이름 없이, 속성 이름을 작성하는 것만으로도 해당 클래스의 속성을 참조할 수 있습니다.

```swift
extension SomeClass {
  func getSomeKeyPath() -> String {
    return #keyPath(someProperty)
  }
}
print(keyPath == c.getSomeKeyPath())
// "true" 를 인쇄합니다.
```

키 경로 문자열은, 실행 시간이 아니라, 컴파일 시간에 생성하기 때문에, 컴파일러가 속성이 존재하며 '오브젝티브-C 런타임' 으로 노출되고 있는 지를 검사할 수 있습니다.

오브젝티브-C API 와 상호 작용하는 스위프트 코드에서 '키 경로 (key paths)' 를 사용하는 것에 대한 더 많은 정보는, [Using Objective-C Runtime Features in Swift](https://developer.apple.com/documentation/swift/using_objective-c_runtime_features_in_swift) 항목을 참고하기 바랍니다. '키-값 코딩 (key-value coding)' 과 '키-값 관찰 (key-value observing)' 에 대한 정보는, [Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i) 항목과 [Key-Value Observing Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i) 항목을 참고하기 바랍니다.

> 비록 _속성 이름 (property name)_ 이 '표현식' 일지라도, 이를 절대로 평가하지 않습니다.

> GRAMMAR OF A KEY-PATH STRING EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

### Postfix Expressions (접미사 표현식)

_접미사 표현식 (postfix expressions)_ 은 표현식에 접미사 연산자 또는 다른 접미사 구문을 적용함으로써 형성합니다. 구문상으로, 모든 '으뜸 (primary) 표현식' 들은 또한 '접미사 표현식' 입니다.

이 연산자들의 동작에 대한 정보는, [Basic Operators (기초 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 장과 [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) 장을 참고하기 바랍니다.

스위프트 표준 라이브러리에서 제공하는 연산자에 대한 정보는, [Operator Declarations](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 항목을 참고하기 발랍니다.

> GRAMMAR OF A POSTFIX EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Function Call Expression (함수 호출 표현식)

_함수 호출 표현식 (function call expression)_ 은 '괄호 친 쉼표로-구분한 함수 인자 목록' 이 뒤따라 오는 '함수 이름' 으로 구성됩니다. '함수 호출 표현식' 의 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`function name-함수 이름`(`argument value 1-인자 값 1`, `argument value 2-인자 값 2`)

_함수 이름 (function name)_ 은 함수 타입의 값인 어떤 표현식이든 될 수 있습니다.

'함수 정의' 가 매개 변수에 대한 이름[^argument-label] 을 포함하고 있으면, '함수 호출' 도 자신의 인자 값 앞에, 콜론 (`:`) 으로 구분한, 이름을 반드시 포함해야 합니다. 이런 종류의 '함수 호출 표현식' 은 다음 형식을 가집니다:

&nbsp;&nbsp;&nbsp;&nbsp;`function name-함수 이름`(`argument name 1-인자 이름 1`: `argument value 1-인자 값 1`, `argument name 2-인자 이름 2`: `argument value 2-인자 값 2`)

'함수 호출 표현식' 은 닫는 괄호 바로 뒤에 '클로저 표현식' 형식의 '뒤에 딸린 클로저 (trailing closures)' 를 포함할 수 있습니다. 뒤에 딸린 클로저는, 마지막 괄호 친 인자 뒤에 추가한, 함수의 인자로 이해합니다. '첫 번째 클로저 표현식' 은 이름표를 붙이지 않으며; 어떤 '추가적인 클로저 표현식' 이든 앞에 '인자 이름표 (argument labels)' 를 붙입니다. 아래 예제는 '뒤에 딸린 클로저 구문을 사용한 것과 사용하지 않은 것이 서로 같은 버전의 함수 호출' 을 보여줍니다:

```swift
// someFunction 은 정수와 클로저를 인자로 취합니다.
someFunction(x: x, f: { $0 == 13 })
someFunction(x: x) { $0 == 13 }

// anotherFunction 은 정수와 두 개의 클로저를 인자로 취합니다.
anotherFunction(x: x, f: { $0 == 13 }, g: { print(99) })
anotherFunction(x: x) { $0 == 13 } g: { print(99) }
```

뒤에 딸린 클로저가 함수의 유일한 인자라면, 괄호를 생략할 수 있습니다.

```swift
// someMethod 는 클로저를 유일한 인자로 취합니다.
myData.someMethod() { $0 == 13 }
myData.someMethod { $0 == 13 }
```

뒤에 딸린 클로저를 인자에 포함시키기 위해, 컴파일러는 다음 처럼 왼쪽에서 오른쪽으로 함수 매개 변수를 검토합니다:

뒤에 딸린 클로저 || 매개 변수 || 행동
---|---|---|---|---
이름표 있음 | | 이름표 있음 | | 이름표가 똑같으면, 클로저와 매개 변수가 일치하며; 그 외 경우라면, 매개 변수를 건너 뜁니다.
이름표 있음 | | 이름표 없음 | | 매개 변수를 건너 뜁니다.
이름표 없음 | | 이름표 있거나 없음 | | 아래 정의한 것처럼, 매개 변수의 구조가 함수 타입과 닮았으면, 클로저와 매개 변수가 일치하며; 그 외 경우라면, 매개 변수를 건너 뜁니다.

뒤에 딸린 클로저는 자신과 일치하는 매개 변수의 인자로 전달됩니다. 조사하는 과정 중에 건너 뛴 매개 변수는 전달된 인자를 가지지 않습니다-예를 들어, '기본 (default) 매개 변수' 를 사용할 수 있습니다. 일치하는 것을 찾은 후에는, 그 다음 뒤에 딸린 클로저와 그 다음 매개 변수를 계속 조사합니다. 맞춰보는 과정이 끝날 때는, 모든 뒤에 딸린 클로저가 반드시 일치하는 것을 가지고 있어야 합니다.

매개 변수가 '입-출력 매개 변수' 가 아니면서, 다음 중 하나에 해당하면, 매개 변수의 _구조가 (structually)_ 함수 타입과 _닮은 (resembles)_ 것입니다:

* `(Bool) -> Int` 같이, 타입이 함수 타입인 '매개 변수'
* `@autoclosure ()-> ((Bool)-> Int)` 같이, 포장한 표현식의 타입이 함수 타입인 '자동 클로저 (autoclosure) 매개 변수'
* `((Bool) -> Int)...` 같이, 배열 원소 타입이 함수 타입인 '가변 (variadic) 매개 변수'
* `Optional<(Bool) -> Int>` 같이, 타입이 하나 이상의 옵셔널 '층 (layers)' 으로 포장된 '매개 변수'
* `(Optional<(Bool) -> Int>) ...` 같이, 이 허용된 타입들을 조합한 '매개 변수'

뒤에 딸린 클로저가 타입의 구조는 함수 타입과 닮은 매개 변수와 일치하지만, 함수는 아닐 때는, 클로저를 필요에 따라 포장합니다. 예를 들어, 매개 변수의 타입이 '옵셔널 타입' 이면, 클로저는 자동으로 `Optional` 로 포장합니다.

이런 맞춰보기 작업을 오른쪽에서 왼쪽으로 수행한-스위프트 5.3 이전 버전의 코드 '이전 (migration)' 이 쉽도록, 컴파일러는 왼쪽-에서-오른쪽 그리고 오른쪽-에서-왼쪽 순서로 둘 다 검사합니다. 조사한 방향에 따라 다른 결과를 만들어 내면, 오른쪽-에서-왼쪽 순서인 예전 방식을 사용하고 컴파일러는 경고를 발생합니다. 미래 버전의 스위프트는 항상 왼쪽-에서-오른쪽 순서를 사용할 것입니다.[^left-to-right]

```swift
typealias Callback = (Int) -> Int
func someFunction(firstClosure: Callback? = nil,
                  secondClosure: Callback? = nil) {
  let first = firstClosure?(10)
  let second = secondClosure?(20)
  print(first ?? "-", second ?? "-")
}

someFunction()  // "- -" 를 인쇄합니다.
someFunction { return $0 + 100 }  // 헷갈림
someFunction { return $0 } secondClosure: { return $0 }  // "10 20" 를 인쇄함
```

위 예제에서, "헷갈림 (ambiguous)" 이라고 표시한 함수 호출은 "- 120" 을 인쇄하며 스위프트 5.3 에선 컴파일러 경고를 만듭니다. 미래 버전의 스위프트는 "110 -" 을 인쇄할 것입니다.

클래스나, 구조체, 또는 열거체 타입은, [Methods with Special Names (특수한 이름을 가진 메소드)]({% post_url 2020-08-15-Declarations %}#methods-with-special-names-특수한-이름을-가진-메소드) 에서 설명한 것처럼, 여러가지 메소드 중 하나를 선언함으로써 '함수 호출 구문' 에 대한 '수월한 구문 (syntatic sugar)' 을 사용하도록 할 수 있습니다.

<p>
<strong id="implicit-conversion-to-a-pointer-type-포인터-타입으로의-암시적인-변환">Implicit Conversion to a Pointer Type (포인터 타입으로의 암시적인 변환)</strong>
</p>

'함수 호출 표현식' 에서, 인자와 매개 변수의 타입이 서로 다르면, 컴파일러가 다음 목록에 있는 '암시적인 변환' 중 하나를 적용함으로써 타입을 일치시키려고 합니다:

* `inout SomeType` 은 `UnsafePointer<SomeType>` 이나 `UnsafeMutablePointer<SomeType>` 이 될 수 있습니다.
* `inout Array<SomeType>` 은 `UnsafePointer<SomeType>` 이나 `UnsafeMutablePointer<SomeType>` 이 될 수 있습니다.
* `Array<SomeType>` 은 `UnsafePointer<SomeType>` 이 될 수 있습니다.
* `String` 은 `UnsafePointer<CChar>` 가 될 수 있습니다.

다음의 두 '함수 호출' 은 서로 '동치 (equivalent)' 입니다:

```swift
func unsafeFunction(pointer: UnsafePointer<Int>) {
  // ...
}
var myNumber = 1234

unsafeFunction(pointer: &myNumber)
withUnsafePointer(to: myNumber) { unsafeFunction(pointer: $0) }
```

이 '암시적인 변환' 으로 생성한 포인터는 '함수 호출' 이 지속될 동안에만 유효합니다. '정의되지 않은 동작' 을 피하려면, 함수 호출이 끝난 후에는 코드가 포인터를 절대 물고 있지 않음을 보장하기 바랍니다.

> '배열' 을 '안전하지 않은 포인터' 로 암시적으로 변환할 때, 스위프트는 필요에 따라 배열을 변환하거나 복사함으로써 배열의 저장 공간이 딱 붙어있도록 보장합니다. 예를 들어, 자신의 저장 공간에 대한 'API 계약' 을 만들지 않는 `NSArray` 하위 클래스에서 `Array` 로 연동한 배열에 이 구문을 사용할 수 있습니다. 배열의 저장 공간이 이미 딱 붙어 있음을 보증할 필요가 있어서, '암시적인 변환' 이 이 작업을 할 필요가 절대로 없을 경우, `Array` 대신 `ContiguousArray` 를 사용합니다.

`withUnsafePointer(to:)` 같은 명시적인 함수 대신 `&` 를 사용하는 것은, 특히 함수가 여러 개의 포인터 인자를 취할 때, '저-수준 C 함수' 에 대한 호출을 더 이해하기 쉽게 도와줍니다. 하지만, 다른 스위프트 코드에서 함수를 호출할 때는, '안전하지 않은 API' 의 명시적 사용 대신 `&` 를 사용하는 것을 피하기 바랍니다.

> GRAMMAR OF A FUNCTION CALL EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Initializer Expression (초기자 표현식)

_초기자 표현식 (initializer expression)_ 은 타입 초기자에 대한 접근을 제공합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식`.init(`initializer arguments-초기자의 인자`)

'초기자 표현식' 은 새로운 타입 인스턴스를 초기화하기 위해 '함수 호출 표현식' 에서 사용합니다. '초기자 표현식' 은 상위 클래스의 초기자로 '위임 (delegate)' 하기 위해 사용하기도 합니다.

```swift
class SomeSubClass: SomeSuperClass {
    override init() {
        // 하위 클래스의 초기화는 여기에 둡니다.
        super.init()
    }
}
```

함수와 같이, 초기자도 '값' 처럼 사용할 수 있습니다. 예를 들면 다음과 같습니다:

```swift
// String 에는 여러 초기자가 있기 때문에 '타입 보조 설명 (annotation)' 은 필수입니다.
let initializer: (Int) -> String = String.init
let oneTwoThree = [1, 2, 3].map(initializer).reduce("", +)
print(oneTwoThree)
// "123" 을 dlstho합니다.
```

타입에 이름을 지정하면, 초기자 표현식을 사용하지 않고도 타입의 초기자에 접근할 수 있습니다. 다른 모든 경우에는, 초기자 표현식을 반드시 사용해야 합니다.

```swift
let s1 = SomeType.init(data: 3)  // 유효
let s2 = SomeType(data: 1)       // 역시 유효

let s3 = type(of: someValue).init(data: 7)  // 유효
let s4 = type(of: someValue)(data: 5)       // 에러
```

> GRAMMAR OF AN INITIALIZER EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Explicit Member Expression (명시적인 멤버 표현식)

_명시적인 멤버 표현식 (explicit member expression)_ 은 '이름 붙인 타입 (named type)' 이나, 튜플, 또는 모듈의 멤버에 대한 접근을 허용합니다. 이는 '항목 (item)' 과 그 멤버의 '식별자 (identifier)' 사이에 있는 '마침표 (`.`)' 로 구성됩니다.

&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식`.`member name-멤버 이름`

'이름 붙인 타입' 의 멤버는 타입의 '선언' 이나 '익스텐션 (extension)' 에서 이름이 붙습니다. 예를 들면 다음과 같습니다:

```swift
class SomeClass {
  var someProperty = 42
}
let c = SomeClass()
let y = c.someProperty  // 멤버 접근
```

튜플의 멤버는 나타나는 순서대로, '0' 부터 시작하는, 정수를 사용하여 암시적인 이름이 붙습니다. 예를 들면 다음과 같습니다:

```swift
var t = (10, 20, 30)
t.0 = t.1
// 이제 t 는 (20, 20, 30) 입니다.
```

모듈의 멤버는 해당 모듈의 '최상단 선언 (top-level declarations)' 들에 접근합니다.

`dynamicMemberLookup` 특성을 가지고 선언한 타입은, [Attributes (특성)]({% post_url 2020-08-14-Attributes %}) 에서 설명한 것처럼, 실행 시간에 찾아 보는 멤버를 포함합니다.

이름이 다른 거라곤 자신의 인자 이름뿐인 메소드들끼리 또는 초기자들끼리 구별하려면, 괄호 안에 인자 이름을 포함시키고, 각 인자 이름 뒤에 '콜론 (`:`)' 을 붙입니다. 이름 없는 인자는 '밑줄 (`_`)' 을 작성합니다. '중복 정의한 (overloaded) 메소드' 들끼리 구별하려면, '타입 보조 설명 (annotation)' 을 사용합니다. 예를 들면 다음과 같습니다:

```swift
class SomeClass {
  func someMethod(x: Int, y: Int) {}
  func someMethod(x: Int, z: Int) {}
  func overloadedMethod(x: Int, y: Int) {}
  func overloadedMethod(x: Int, y: Bool) {}
}
let instance = SomeClass()

let a = instance.someMethod              // 헷갈림
let b = instance.someMethod(x:y:)        // 헷갈리지 않음

let d = instance.overloadedMethod        // 헷갈림
let d = instance.overloadedMethod(x:y:)  // 여전히 헷갈림
let d: (Int, Bool) -> Void  = instance.overloadedMethod(x:y:)  // 헷갈리지 않음
```

줄의 시작이 '마침표' 면, '암시적인 멤버 표현식' 이 아니라, '명시적인 멤버 표현식' 이라고 이해합니다. 예를 들어, 아래에 나열한 것은 여러 줄에 걸쳐 쪼개진 '연쇄적인 메소드 호출' 을 보여줍니다:

```swift
let x = [10, 3, 20, 15, 4]
    .sorted()
    .filter { $0 > 5 }
    .map { $0 * 100 }
```

> GRAMMAR OF AN EXPLICIT MEMBER EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Postfix Self Expression (접미사 'self' 표현식)

'접미사 `self` 표현식' 은, 바로 뒤에 `.self` 가 있는, 표현식이나 타입 이름으로 구성합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`expression`.self
<br />
&nbsp;&nbsp;&nbsp;&nbsp;`type`.self

첫 번째 형식은 _표현식 (expression)_ 의 값을 평가합니다. 예를 들어, `x.self` 는 `x` 를 평가합니다.

두 번째 형식은 _타입 (type)_ 의 값을 평가합니다. 이 형식은 타입을 '값' 처럼 접근하기 위해 사용합니다. 예를 들어, `SomeClass.self` 는 `SomeClass` 타입 자체를 평가하기 때문에, '타입-수준 인자' 를 받는 함수나 메소드에 전달할 수 있습니다.

> GRAMMAR OF A POSTFIX SELF EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Subscript Expression (첨자 연산 표현식)

_첨자 연산 표현식 (subscript expression)_ 은 해당 첨자 연산 선언의 획득자 (getter) 와 설정자 (setter) 를 사용한 '첨자 연산 접근' 을 제공합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식`[`index expressions-색인 표현식`]

'첨자 연산 표현식' 의 값을 평가하기 위해서는, '첨자 연산 매개 변수' 로 전달한 _색인 표현식 (index expressions)_ 을 가지고 _표현식 (expression)_ 타입을 위한 '첨자 연산 획득자' 를 호출합니다. 값을 설정하기 위해서는, 똑같은 방식으로 '첨자 연산 설정자' 를 호출합니다.

'첨자 선언' 에 대한 정보는, [Protocol Subscript Declaration (프로토콜 첨자 선언)]({% post_url 2020-08-15-Declarations %}#protocol-subscript-declaration-프로토콜-첨자-선언) 부분을 참고하기 바랍니다.

> GRAMMAR OF A PROTOCOL SUBSCRIPT DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Forced-Value Expression (강제-값 표현식)

_강제-값 표현식 (forced-value expression)_ 은 `nil` 이 아니라고 확신하는 '옵셔널 값' 의 포장을 풉니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식`!

_표현식 (expression)_ 값이 `nil` 이 아니면, '옵셔널 값' 의 포장을 풀고 이와 관련된 '옵셔널-아닌 타입' 으로 반환합니다. 그 외 경우라면, 실행시간 에러를 일으킵니다.

'강제-값 표현식' 으로 '포장을 푼 값' 은, 값 자체를 변경하거나, 값의 멤버 중 하나에 할당함으로써, 수정할 수 있습니다. 예를 들면 다음과 같습니다:

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

_옵셔널-연쇄 표현식 (optional-chaining expression)_ 은 '접미사 표현식' 에서 옵셔널 값을 사용하기 위한 '단순화 구문' 을 제공합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식`?

'접미사 `?` 연산자' 는 표현식의 값을 바꾸지 않고도 '표현식' 을 '옵셔널-연쇄 표현식' 으로 만듭니다.

'옵셔널-연쇄 표현식' 은 반드시 '접미사 표현식' 안에 있어야 하며, 이는 '접미사 표현식' 을 특수한 방식으로 평가하도록 합니다. '옵셔널-연쇄 표현식' 의 값이 `nil` 이면, 접미사 표현식에 있는 모든 다른 연산들을 무시하며 '전체 접미사 표현식' 이 `nil` 이라고 평가합니다. '옵셔널-연쇄 표현식' 의 값이 `nil` 이 아니면, 옵셔널-연쇄 표현식 값의 포장을 풀어서 접미사 표현식의 나머지를 평가하는데 사용합니다. 어느 경우든, 접미사 표현식 값은 여전히 '옵셔널 타입' 입니다.

'옵셔널-연쇄 표현식' 을 담고 있는 '접미사 표현식' 이 다른 접미사 표현식 안에 중첩되어 있으면, 가장 바깥쪽 표현식만이 '옵셔널 타입' 을 반환합니다.[^outmost-expression] 아래 예제에서, `c` 가 `nil` 이 아닐 때, 값의 포장을 풀고 `.property` 를 평가하며, 이 값을 `.performAction()` 을 평가하는 데 사용합니다. `c?.property.performAction()` 라는 전체 표현식은 '옵셔널 타입' 인 값을 가집니다.

```swift
var c: SomeClass?
var result: Bool? = c?.property.performAction()
```

다음 예제는 '옵셔널 연쇄' 없이 위 예제가 동작하는 걸 보여줍니다.

```swift
var result: Bool?
if let unwrappedC = c {
    result = unwrappedC.property.performAction()
}
```

'옵셔널-연쇄 표현식' 의 '포장을 푼 값' 은, 값 자체를 변경하거나, 값의 멤버 중 하나에 할당함으로써, 수정할 수 있습니다. '옵셔널-연쇄 표현식' 의 값이 `nil` 이면, 할당 연산자의 오른-쪽에 있는 표현식을 평가하지 않습니다. 예를 들면 다음과 같습니다:

```swift
func someFunctionWithSideEffects() -> Int {
    return 42  // 실제 부작용은 없음.
}
var someDictionary = ["a": [1, 2, 3], "b": [10, 20]]

someDictionary["not here"]?[0] = someFunctionWithSideEffects()
// someFunctionWithSideEffects 를 평가하지 않습니다
// someDictionary 는 여전히 ["a": [1, 2, 3], "b": [10, 20]] 입니다

someDictionary["a"]?[0] = someFunctionWithSideEffects()
// someFunctionWithSideEffects 를 평가하여 42 를 반환합니다
// someDictionary 는 이제 ["a": [42, 2, 3], "b": [10, 20]] 입니다
```

> GRAMMAR OF AN OPTIONAL-CHAINING EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

### 다음 장

[Statements (구문) > ]({% post_url 2020-08-20-Statements %})

### 참고 자료

[^Expressions]: 원문은 [Expressions](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^primary-expression]: '으뜸 표현식 (primary expression)' 은 아래의 [Primary Expressions (으뜸 표현식)]({% post_url 2020-08-19-Expressions %}#primary-expressions-으뜸-표현식) 부분에서 설명합니다.

[^side-effect]: 컴퓨터 용어에서의 '부작용 (side effect)' 은 '부수적 효과' 정도로 이해할 수 있습니다. 보다 자세한 내용은 위키피디아의 [Side effect (computer science)](https://en.wikipedia.org/wiki/Side_effect_(computer_science)) 및 [부작용 (컴퓨터 과학)](https://ko.wikipedia.org/wiki/부작용_(컴퓨터_과학)) 항목을 참고하기 바랍니다.


[^ordered-collection]: '순서가 있는 집합체 (ordered collections)' 는 '정렬된 집합체 (sorted collection)' 와 그 의미가 다릅니다. 이 둘의 차이점에 대해서는, '스택 오버플로우 (StackOverflow)' 의 [What is the difference between an ordered and a sorted collection?](https://stackoverflow.com/questions/1084146/what-is-the-difference-between-an-ordered-and-a-sorted-collection) 항목을 참고하기 바랍니다.

[^playground-literal]: 예를 들어 '빨간색' 플레이그라운드 글자 값은 ![Playground Color](/assets/Swift/Swift-Programming-Language/Expressions-playground-literal.png){:width="100px"} 인데, 이를 복사하여 다른 편집기로 옮기면 `var color = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)` 과 같은 '특수 글자 값 구문' 이 됩니다.

[^operator-declarations]: 원문 자체가 애플 개발자 사이트로 연결되는 링크로 되어 있습니다.

[^flat-list]: '납작한 리스트 (flat list)' 는 차원을 축소하여 1-차원화한 리스트라고 이해할 수 있습니다.

[^upcasting]: '올림 변환 (upcasting)' 은 하위 클래스에서 상위 클래스로 형변환하는 것을 말합니다. 하위 클래스는 상위 클래스를 상속한 것이기 때문에 올림 변환은 항상 성공합니다. 

[^bridging]: '연동 (bridging)' 은 애플에서 스위프트의 자료 타입과 오브젝티브-C 의 자료 타입을 서로 호환해서 사용할 수 있도록 만든 방식입니다. 본문 뒤에 나오는 설명 처럼 연동을 사용하여 `String` 타입을 `NSString` 타입으로 변환하여 사용할 수 있습니다. 

[^foundation]: '파운데이션 (Foundation)' 은 스위프트 프로그래밍 언어의 기반을 이루는 프레임웍으로, 보통 `import Foundation` 으로 불러옵니다. 여기서 말하는 파운데이션 타입은 오브젝티브-C 와의 호환성을 위해 Foundation 프레임웍 안에 정의되어 있는 타입을 의미합니다. 

[^the-path]: `#ifle` 이 있는 곳의 파일 경로를 의미합니다.

[^dynamic-shared-object]: '동적 공유 객체 (dynamic shared object; DSO)' 는 `.dylib` 나 `.so` 같이 현재 실행 중인 동적 연결 라이브러리를 의미합니다. 이에 대한 더 자세한 내용은, 애플 개발자 문서의 [Overview of Dynamic Libraries](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/DynamicLibraries/100-Articles/OverviewOfDynamicLibraries.html) 항목을 참고하기 바랍니다. 

[^filePath-and-fildID]: 스위프트 5.3 이전까지의 `#file` 은 그 파일의 전체 경로였는데, 앞으로는 파일과 모듈 이름으로 바뀌게 됩니다. 본문의 내용은 현재는 `#file` 이 `#filePath` 와 똑같지만, 앞으로는 `#fileID` 와 똑같아질 거라는 의미입니다.

[^file-to-filePath-and-fildID]: 미래 버전의 스위프트에선 `#file` 과 `#filePath` 를 확실하게 구분하려는 것 같습니다. 본문의 내용을 보면 `#filePath` 를 출하용 프로그램에서만 사용할 것을 권하는데, 이러한 구분은 개인 정보 보호 (privacy) 정책과도 관련있는 것 같습니다.

[^mutating-method]: '값 타입 (value type)' 은 구조체와 열거체를 말하는 것이며, '변경 메소드 (mutating method)' 는 값 타입의 'self' 를 변경할 수 있는 메소드를 말합니다. 이는 다른 인스턴스를 할당함으로써 `self` 를 변경할 수 있다는 의미입니다.

[^weak-and-unowned-capture]: 클로저와 클래스는 둘 다 '참조 타입' 이기 때문에, 서로를 참조하면 '강한 참조 순환' 이 발생합니다. 이를 방지하기 위해 '약한 참조' 나 '소유하지 않는 참조' 를 사용합니다.

[^strength]: 여기서 '강하기 (strength)' 는 `strong`, `weak`, `unowned` 중 하나를 의미합니다.

[^implied-type]: 여기서 '자신의 상황이 암시하는 타입' 은 `SomeClass` 인데, `f()` 메소드의 반환 타입이 `SomeClass` 이므로 정확하게 일치합니다.

[^outmost-expression]: 이는 옵셔널을 다시 옵셔널로 포장하지는 않는다는 의미입니다. 이에 대한 더 자세한 내용은, [Optional Chaining (옵셔널 사슬)]({% post_url 2020-06-17-Optional-Chaining %}) 장을 참고하기 바랍니다.

[^left-to-right]: 스위프트 5.3 이전 버전에서 '오른쪽-에서-왼쪽' 순서를 사용하는 건, 예전에는 뒤에 딸린 (trailing) 클로저가 하나뿐이이라 가장 오른쪽 매개 변수였기 때문으로 추측됩니다. 스위프트 5.3 부터 뒤에 딸린 클로저가 여러 개가 될 수 있으므로 '왼쪽-에서-오른쪽' 순서를 사용한다고 볼 수 있습니다.

[^using-unsafe-API]: 이 말은 `&` 같은 '입-출력 매개 변수' 를 사용해서 '안전하지 않은 포인터' 로 암시적으로 변환하는 기능은 '저-수준 C 함수' 를 호출할 때만 사용하라는 의미입니다.

[^reference-semantics]: '참조 의미 구조 (reference semantics)' 에 대한 더 자세한 정보는, [Classes Are Reference Types (클래스는 참조 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#classes-are-reference-types-클래스는-참조-타입입니다) 부분을 참고하기 바랍니다.

[^key-path-string-expression]: '키-값 문자열 표현식' 은 '키-값 표현식' 을 오브젝티브-C 의 속성에서 사용하기 위한 방법이라고 생각됩니다.

[^argument-label]: 여기서 말하는 '매개 변수에 대한 이름' 은 '인자 이름표 (argument label)' 를 의미합니다. '인자 이름표' 에 대한 더 자세한 설명은, [Function Argument Labels and Parameter Names (함수의 인자 이름표와 매개 변수 이름)]({% post_url 2020-06-02-Functions %}#function-argument-labels-and-parameter-names-함수의-인자-이름표와-매개-변수-이름) 부분을 참고하기 바랍니다. 