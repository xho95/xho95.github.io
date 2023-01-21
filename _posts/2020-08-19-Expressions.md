---
layout: post
comments: true
title:  "Expressions (표현식)"
date:   2020-08-19 11:30:00 +0900
categories: Swift Language Grammar Expression
---

{% include header_swift_book.md %}

## Expressions (표현식)

스위프트에는, 네 종류의 표현식이 있는데: 접두사 표현식과, 중위 표현식, 으뜸 표현식[^primary-expression], 및 접미사 표현식이 그것입니다. 표현식의 평가는 값을 반환하거나, 부작용[^side-effect] 을 일으키거나, 혹은 둘 다 합니다.

접두사 및 중위 표현식은 더 작은 표현식에 연산자를 적용하게 해줍니다. 으뜸 표현식은 개념상 가장 단순한 종류의 표현식으로, 값에 접근하는 방식을 제공합니다. 접미사 표현식은, 접두사 및 중위 표현식과 마찬가지로, 함수 호출과 멤버 접근 같은 접미사를 사용하여 더 복잡한 표현식을 제작하게 해줍니다. 각 종류의 표현식은 밑의 절에서 자세하게 설명합니다.

> GRAMMAR OF AN EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html)

### Prefix Expressions (접두사 표현식)

_접두사 표현식 (prefix expressions)_ 은 옵션인 접두사 연산자와 표현식을 조합합니다. 접두사 연산자는 하나의 인자로, 자신의 뒤에 있는 표현식을, 취합니다.

이 연산자 동작에 대한 정보는, [Basic Operators (기초 연산자)]({% link docs/swift-books/swift-programming-language/basic-operators.md %}) 장과 [Advanced Operators (고급 연산자)]({% link docs/swift-books/swift-programming-language/advanced-operators.md %}) 장을 보도록 합니다.

스위프트 표준 라이브러리에서 제공하는 연산자에 대한 정보는, [Operator Declarations](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 항목을 보도록 합니다.

> GRAMMAR OF A PREFIX EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID384)

#### In-Out Expression (입-출력 표현식)

_입-출력 표현식 (in-out expression)_ 은 함수 호출 표현식에 입-출력 인자로 전달한 변수를 표시합니다.

&nbsp;&nbsp;&nbsp;&nbsp;\&`expression-표현식`

입-출력 매개 변수에 대한 더 많은 정보와 예제를 보려면, [In-Out Parameters (입-출력 매개 변수)]({% link docs/swift-books/swift-programming-language/functions.md %}#in-out-parameters-입-출력-매개-변수) 부분을 보도록 합니다.

입-출력 표현식은, [Implicit Conversion to a Pointer Type (포인터 타입으로의 암시적 변환)](#implicit-conversion-to-a-pointer-type-포인터-타입으로의-암시적-변환) 에서 설명하는 것처럼, 포인터가 필요한 상황에서 포인터-아닌 인자를 제공할 때도 사용합니다. 

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

`try` 와, `try?`, 및 `try!` 에 대한 더 많은 정보와 사용 예제를 보려면, [Error Handling (에러 처리)]({% link docs/swift-books/swift-programming-language/error-handling.md %}) 장을 보도록 합니다.

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

이 연산자 동작에 대한 정보는, [Basic Operators (기초 연산자)]({% link docs/swift-books/swift-programming-language/basic-operators.md %}) 장과 [Advanced Operators (고급 연산자)]({% link docs/swift-books/swift-programming-language/advanced-operators.md %}) 장을 보도록 합니다.

스위프트 표준 라이브러리에서 제공하는 연산자에 대한 정보는, [Operator Declarations](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 항목을 보도록 합니다.

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

삼항 조건 연산자의 사용 예제는, [Ternary Conditional Operator (삼항 조건 연산자)]({% link docs/swift-books/swift-programming-language/basic-operators.md %}Ternary Conditional Operator (삼항 조건 연산자)) 부분을 보도록 합니다.

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

연동은 새로운 인스턴스를 생성할 필요 없이 `String` 같은 스위프트 표준 라이브러리 타입의 표현식을 `NSString` 같이 그에 해당하는 파운데이션 (Foundation)[^foundation] 타입으로 사용하게 해줍니다. 연동에 대한 더 많은 정보는, [Working with Foundation Types](https://developer.apple.com/documentation/swift/imported_c_and_objective-c_apis/working_with_foundation_types) 항목을 보도록 합니다.

`as?` 연산자는 _표현식 (expression)_ 을 특정 _타입 (type)_ 으로 조건부 변환합니다. `as?` 연산자는 특정 _타입 (type)_ 에 대한 옵셔널을 반환합니다. 실행 시간에, 변환 성공하면, _표현식 (expression)_ 의 값을 옵셔널로 포장하여 반환하며; 그 외 경우, 반환 값이 `nil` 입니다. 특정 _타입 (type)_ 으로의 변환이 실패로 보증된 것 또는 성공으로 보증된 것이면, 컴파일-시간 에러가 일어납니다.

`as!` 연산자는 _표현식 (expression)_ 을 특정 _타입 (type)_ 으로 강제 변환합니다. `as!` 연산자는, 옵셔널 타입이 아닌, 특정 _타입 (type)_ 값을 반환합니다. 변환을 실패하면, 실행 시간 에러가 일어납니다. `x as! T` 는 `(x as? T)!` 와 똑같이 동작합니다.

타입 변환에 대한 더 많은 정보 및 타입-변환 연산자의 사용 예제는, [Type Casting (타입 변환)]({% link docs/swift-books/swift-programming-language/type-casting.md %}) 장을 보도록 합니다.

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

`#file` 의 문자열 값은 언어 버전에 의존하여, 예전 동작인 `#filePath` 를 새로운 동작인 `#fileID` 로 이주할 수 있게 합니다.[^filePath-and-fildID] 현재, `#file` 는 `#filePath` 값과 똑같습니다. 미래 버전의 스위프트에선, 그 대신 `#file` 가 `#fileID` 값과 똑같을 겁니다. 미래의 동작을 채택하려면, `#file` 을 `#fileID` 나 `#filePath` 로 적절하게 교체하기 바랍니다.[^file-to-filePath-and-fildID]

`#fileID` 표현식의 문자열 값은 _모듈/파일 (module/file)_ 형식인데, _파일 (file)_ 은 표현식이 있는 파일 이름이고 _모듈 (module)_ 은 이 파일이 속해 있는 모듈 이름입니다. `#filePath` 표현식의 문자열 값은 표현식이 있는 파일의 전체 파일-시스템 경로입니다. [Line Control Statement (라인 제어문)]({% link docs/swift-books/swift-programming-language/statements.md %}#line-control-statement-라인-제어문) 에서 설명한 것처럼, 이 두 값 모두 `#sourceLocation` 으로 바꿀 수 있습니다. `#filePath` 와 달리, `#fileID` 에 소스 파일의 전체 경로를 박아 넣지 않기 때문에, 개인 정보를 더 잘 보호하며 컴파일한 바이너리의 크기가 줄여듭니다. 테스트나, 빌드 스크립트, 또는 그 외 출하용 프로그램의 일부분이 아닌 코드 밖에선 `#filePath` 의 사용을 피합니다.[^shipping-program]

> `#fileID` 표현식 구문을 해석하려면, 첫 번째 빗금 (`/`) 앞의 텍스트는 모듈 이름으로 마지막 빗금 뒤의 텍스트는 파일 이름으로 읽습니다.[^first-and-last-slash] 미래에는, `MyModule/some/disambiguation/MyFile.swift` 같이, 문자열이 여러 개의 빗금을 담고 있을 지도 모릅니다.

`#function` 값은, 함수 안에선 그 함수의 이름이고, 메소드 안에선 그 메소드의 이름, 속성의 획득자나 설정자 안에선 그 속성의 이름, `init` 이나 `subscript` 같은 특수 멤버 안에선 그 키워드의 이름이며, 파일의 최상단에선 현재 모듈의 이름입니다.

함수나 메소드 매개 변수의 기본 값으로 사용할 땐, 호출한 쪽에서 기본 값 표현식을 평가할 때 특수 글자 값의 값을 결정합니다.

```swift
func logFunctionName(string: String = #function) {
  print(string)
}
func myFunction() {
  logFunctionName() // "myFunction()" 를 인쇄함
}
```

_배열 글자 값 (array literal)_ 은 순서 있는 값의 집합체 (ordered collection)[^ordered-collection] 입니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;[`value 1-값 1`, `value 2-값 2`, `...`]

배열의 마지막 표현식 뒤에 쉼표가 있어도 됩니다. 배열 글자 값은 `[T]` 타입인데, 여기서 `T` 는 그 안의 표현식 타입입니다. 표현식의 타입이 여러 개면, `T` 는 이들의 가장 가까운 공통 상위 타입 (closest common supertype) 입니다. 빈 배열 글자 값은 빈 대괄호 쌍으로 작성하며 이를 사용하면 지정된 타입의 빈 배열을 생성할 수 있습니다.

```swift
var emptyArray: [Double] = []
```

_딕셔너리 글자 값 (dictionary literal)_ 은 순서 없는 키-값 (key-value) 쌍의 집합체 (unordered collection) 입니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;[`key 1-키 1`: `value 1-값 1`, `key 2-키 2`: `value 2-값 2`, `...`]

딕셔너리의 마지막 표현식 뒤에 쉼표가 있어도 됩니다. 딕셔너리 글자 값은 `[Key : Value]` 타입인데, 여기서 `Key` 는 키 표현식의 타입이고 `Value` 는 값 표현식의 타입입니다. 표현식의 타입이 여러 개면, `Key` 와 `Value` 는 각자 값의 가장 가까운 공통 상위 타입입니다. 빈 딕셔너리 글자 값은 빈 배열 글자 값과 구별하려고 대괄호 쌍 안에 콜론 (`[:]`) 을 작성합니다. 빈 딕셔너리 글자 값을 사용하여 특정 키와 값 타입의 빈 딕셔너리 글자 값을 생성할 수 있습니다.

```swift
var emptyDictionary: [String : Double] = [:]
```

_플레이그라운드 글자 값 (playground literal)_ 은 엑스코드 (Xcode) 에서 사용하는 것으로 프로그램 편집기 안에서 색상이나, 파일, 또는 이미지를 대화형으로 나타내도록 합니다. 엑스코드 밖에 있는 평범한 텍스트에선 플레이그라운드 글자 값을 특수 글자 값 구문으로 나타냅니다.[^playground-literal]

엑스코드에서 플레이그라운드 글자 값을 사용하는 정보는, 엑스코드 도움말 (Xcode Help) 의 [Add a color, file, or image literal](https://help.apple.com/xcode/mac/current/#/dev4c60242fc) 항목을 보도록 합니다.

> GRAMMAR OF A LITERAL EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Self Expression (self 표현식)

`self` 표현식은 현재 타입 또는 자기가 있는 타입의 인스턴스를 명시적으로 참조합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;self<br />
&nbsp;&nbsp;&nbsp;&nbsp;self.`member name-멤버 이름`<br />
&nbsp;&nbsp;&nbsp;&nbsp;self [`subscript index-첨자 연산 색인`]<br />
&nbsp;&nbsp;&nbsp;&nbsp;self (`initializer arguments-초기자 인자`)<br />
&nbsp;&nbsp;&nbsp;&nbsp;self.init(`initializer arguments-초기자 인자`)

초기자나, 첨자 연산, 또는 인스턴스 메소드 안에서의, `self` 는 자기가 있는 타입의 현재 인스턴스를 참조합니다. 타입 메소드 안에서의, `self` 는 자기가 있는 현재 타입을 참조합니다.

멤버에 접근할 때 `self` 표현식으로 영역을 지정하면, 함수 매개 변수 같이, 영역에 동일한 이름의 또 다른 변수가 있을 때도 헷갈리지 않습니다. 예를 들면 다음과 같습니다:

```swift
class SomeClass {
  var greeting: String
  init(greeting: String) {
    self.greeting = greeting
  }
}
```

값 타입의 변경 메소드 안에선, 그 값 타입의 새로운 인스턴스를 `self` 에 할당할 수 있습니다.[^mutating-method] 예를 들면 다음과 같습니다:

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

_상위 클래스 표현식 (superclass expression)_ 은 클래스를 자신의 상위 클래스와 상호 작용하게 해줍니다. 형식은 다음 중 하나입니다:

&nbsp;&nbsp;&nbsp;&nbsp;super.`memeber name-멤버 이름`
&nbsp;&nbsp;&nbsp;&nbsp;super[`subscript index-첨자 연산 색인`]
&nbsp;&nbsp;&nbsp;&nbsp;super.init(`initializer arguments-초기자 인자`)

첫 번째 형식으로는 상위 클래스의 멤버에 접근합니다. 두 번째 형식으론 상위 클래스의 첨자 구현에 접근합니다. 세 번째 형식으론 상위 클래스의 초기자에 접근합니다.

하위 클래스의 멤버와, 첨자, 및 초기자 구현 안에 상위 클래스 표현식을 사용하면 자신의 상위 클래스 안의 구현을 사용할 수 있습니다.

> GRAMMAR OF A SUPERCLASS EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Closure Expression (클로저 표현식)

_클로저 표현식 (closure expression)_ 은, 다른 프로그래밍 언어에선 _람다 (lambda)_ 나 _익명 함수 (anonymous function)_ 라고도 하는, 클로저를 생성합니다. 함수 선언 같이, 클로저도 구문을 담으며, 자신을 둘러싼 영역의 상수와 변수를 붙잡습니다.[^capture] 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;{ (`parameter-매개 변수`) -> `return type-반환 타입` in<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

_매개 변수 (parameter)_ 의 형식은, [Function Declaration (함수 선언)]({% link docs/swift-books/swift-programming-language/declarations.md %}#function-declaration-함수-선언) 에서 설명한 것처럼, 함수 선언의 매개 변수와 똑같습니다.

클로저 표현식에 `throws` 나 `async` 를 써서 클로저가 던지거나 비동기라는 걸 명시합니다.

&nbsp;&nbsp;&nbsp;&nbsp;{ (`parameter-매개 변수`) async throws -> `return type-반환 타입` in<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

클로저 본문이 `try` 표현식을 포함하면, 던지는 클로저라고 이해합니다. 마찬가지로, `await` 표현식을 포함하면, 비동기라고 이해합니다. 

클로저를 더 간결하게 작성하는 여러가지 특수한 형식이 있습니다:

* 클로저는 자신의 매개 변수 타입이나, 반환 타입, 또는 둘 다 생략할 수 있습니다. 매개 변수 이름과 두 타입 모두를 생략하면, 구문 앞의 `in` 키워드도 생략합니다. 생략한 타입을 추론할 수 없으면, 컴파일-시간 에러가 일어납니다.
* 클로저는 자신의 매개 변수 이름을 생략할 수도 있습니다. 그러면 매개 변수가 `$` 뒤에 자신의 위치가 붙은 암시적 이름을 가집니다: `$0`, `$1`, `$2`, 등으로 계속됩니다.
* 단일 표현식으로만 구성한 클로저는 그 표현식 값을 반환하는 걸로 이해합니다. (이 표현식) 주위의 표현식 타입을 추론할 땐 이 표현식의 내용도 고려합니다.

다음의 클로저 표현식은 서로 같은 겁니다:

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

클로저를 함수 인자로 전달하는 정보는, [Function Call Expression (함수 호출 표현식)](#function-call-expression-함수-호출-표현식) 부분을 보도록 합니다.

함수 호출 부분에서 곧바로 클로저를 사용할 때 처럼, 변수나 상수에 저장하지 않고도 클로저를 사용할 수 있습니다. 위 코드에서 `myFunction` 에 전달한 클로저 표현식이 곧바로 사용하는 예의 한 종류입니다. 그 결과, 클로저 표현식이 벗어나는 건지 벗어나지 않는 건지는 표현식의 주위 상황에 달려 있습니다.[^escaping-or-nonescaping] 곧바로 호출하거나 벗어나지 않는 함수 인자로 전달한 클로저 표현식은 벗어나지 않는 겁니다. 그 외 경우의, 클로저 표현식은 벗어나는 겁니다.

벗어나는 클로저의 더 많은 정보는, [Escaping Closures (벗어나는 클로저)]({% link docs/swift-books/swift-programming-language/closures.md %}#escaping-closures-벗어나는-클로저) 부분을 보도록 합니다.

<p>
<strong id="capture-lists-붙잡을-목록">Capture Lists (붙잡을 목록)</strong>
</p>

기본적으로, 클로저 표현식은 자기 주위 영역의 상수와 변수 값을 강한 참조[^strong-reference] 로 붙잡습니다. _붙잡을 목록 (capture list)_ 을 사용하면 클로저에서 값을 붙잡는 방법을 명시적으로 제어할 수 있습니다.

붙잡을 목록은, 매개 변수 목록 앞에, 쉼표로-구분한 표현식 목록을 대괄호로 둘러싸서 작성합니다. 붙잡을 목록을 사용하면, 매개 변수 이름과, 매개 변수 타입, 및 반환 타입을 생략한 경우라도, 반드시 `in` 키워드를 사용해야 합니다.

붙잡을 목록 안의 요소는 클로저 생성 때 초기화합니다. 붙잡을 목록의 각 요소마다, 한 상수를 주위 영역 안의 동일 이름인 상수나 변수 값으로 초기화합니다. 아래 코드 예제에서, `a` 는 붙잡을 목록이 포함하지만 `b` 는 아니어서, 서로 다르게 동작합니다.

```swift
var a = 0
var b = 0
let closure = { [a] in
  print(a, b)
}

a = 10
b = 10
closure()
// "0 10" 를 인쇄함
```

`a` 라는 이름은, 주위 영역 안의 변수와 클로저 영역 안의 상수라는, 서로 다른 두 개가 있지만, `b` 라는 이름의 변수는 하나뿐입니다. 안쪽 영역의 `a` 는 클로저 생성 때 바깥 영역의 `a` 값으로 초기화하지만, 이러한 값은 어떤 특수한 방식으로도 연결된 게 아닙니다. 이는 바깥 영역의 `a` 값을 바꿔도 안쪽 영역의 `a` 값에 영향을 주지 않으며, 클로저 안의 `a` 를 바꿔도 클로저 밖의 `a` 값에 영향을 주지 않는다는 의미입니다. 이와 대조적으로, `b` 라는 이름의 변수는-바깥 영역의 `b` 라는-단 하나만 있어서 클로저 안팎에서 바꾸는 걸 양쪽 다 볼 수 있습니다.

붙잡은 변수의 타입이 참조 의미 구조[^reference-semantics] 를 가질 땐 이런 구별이 보이지 않습니다. 예를 들어, 아래 코드에는 바깥 영역의 변수와 안쪽 영역의 상수라는, 두 개의 `x` 가 있지만, 참조 의미 구조이기 때문에 둘 다 동일한 객체를 참조합니다.[^because-of-reference]

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
// "10 10" 을 인쇄함
```

표현식 값의 타입이 클래스면, 붙잡을 목록 안의 표현식에 `weak` 나 `unowned` 를 표시하여 표현식 값에 대한 약한 또는 소유하지 않는 참조를 붙잡을 수 있습니다.[^weak-and-unowned-capture]

```swift
myFunction { print(self.title) }                    // 암시적으로 강하게 붙잡음 (implicit strong capture)
myFunction { [self] in print(self.title) }          // 명시적으로 강하게 붙잡음 (explicit strong capture)
myFunction { [weak self] in print(self!.title) }    // 약하게 붙잡음 (weak capture)
myFunction { [unowned self] in print(self.title) }  // 소유하지 않게 붙잡음 (unowned capture)
```

붙잡을 목록에서 임의의 표현식과 이름 붙인 변수를 연결할 수도 있습니다. 클로저 생성 때 표현식을 평가하여, 지정한 강하기로 값을 붙잡습니다.[^strength] 예를 들면 다음과 같습니다:

```swift
// "self.parent" 를 "parent" 로 약하게 붙잡음
myFunction { [weak parent = self.parent] in print(parent!.title) }
```

클로저 표현식에 대한 더 많은 정보와 예제는, [Closure Expressions (클로저 표현식)]({% link docs/swift-books/swift-programming-language/closures.md %}#closure-expressions-클로저-표현식) 부분을 보도록 합니다. 붙잡을 목록에 대한 더 많은 정보와 예제는, [Resolving Strong Reference Cycles for Closures (클로저의 강한 참조 순환 해결하기)]({% link docs/swift-books/swift-programming-language/automatic-reference-counting.md %}#resolving-strong-reference-cycles-for-closures-클로저의-강한-참조-순환-해결하기) 부분을 보도록 합니다.

> GRAMMAR OF A CLOSURE EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Implicit Member Expression (암시적 멤버 표현식)

_암시적 멤버 표현식 (implicit member expression)_ 은, 열거체 case 나 타입 메소드 같이, 암시적 타입을 추론할 수 있는 상황에서, 타입 멤버에 접근하는 단축 방식입니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;.`member name-멤버 이름`

예를 들면 다음과 같습니다:

```swift
var x = MyEnumeration.someValue
x = .anotherValue
```

추론한 타입이 옵셔널이면, 암시적 멤버 표현식 안에서 옵셔널-아닌 타입의 멤버도 사용할 수 있습니다.

```swift
var someOptional: MyEnumeration? = .someValue
```

암시적 멤버 표현식 뒤엔 [Postfix Expressions (접미사 표현식)](#postfix-expressions-접미사-표현식) 에 나열된 접미사 연산자나 다른 접미사 구문이 있을 수 있습니다. 이를 _연쇄된 암시적 멤버 표현식 (chained implicit member expression)_ 이라고 합니다. 연쇄한 모든 접미사 표현식이 동일 타입을 가지는 게 흔하긴 하지만, 유일한 필수 조건은 연쇄된 암시적 멤버 표현식 전체가 자신의 암시 타입으로 변환 가능할 필요가 있다는 것뿐입니다. 특히, 암시 타입이 옵셔널이면 옵셔널-아닌 타입의 값을 사용할 수도 있고, 암시 타입이 클래스 타입이면 자신의 하위 클래스 타입 중 하나의 값을 사용할 수도 있습니다. 예를 들면 다음과 같습니다:

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

위 코드에서, `x` 의 타입은 자신의 암시 타입[^implied-type] 과 정확하게 일치하고, `y` 의 타입은 `SomeClass` 에서 `SomeClass?` 로 변환 가능하며, `z` 의 타입은 `SomeSubclass` 에서 `SomeClass` 로 변환 가능합니다.

> GRAMMAR OF A IMPLICIT MEMBER EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Parenthesized Expression (괄호 표현식)

_괄호 표현식 (parenthesized expression)_ 은 표현식을 괄호로 둘러싸서 구성합니다. 괄호를 사용하여 표현식을 명시적으로 그룹지으면 연산의 우선 순위를 지정할 수 있습니다. 괄호 그룹짓기는 표현식의 타입을 바꾸지 않습니다-예를 들어, `(1)` 의 타입은 단순히 `Int` 입니다.

> GRAMMAR OF A PARENTHESIZED MEMBER EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Tuple Expression (튜플 표현식)

_튜플 표현식 (tuple expression)_ 은 쉼표로-구분한 표현식 목록을 괄호로 둘러싸서 구성합니다. 각각의 표현식엔 옵션으로 자기 앞에, 콜론 (`:`) 으로 구분한, 식별자가 있을 수 있습니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;(`identifier 1-식별자 1`: `expression 1-표현식 1`, `identifier 2-식별자 2`: `expression 2-표현식 2`, `...`)

튜플 표현식에 있는 각각의 식별자는 튜플 표현식 영역 안에서 반드시 유일해야 합니다. 중첩 튜플 표현식에선, 동일 중첩 수준의 식별자는 반드시 유일해야 합니다. 예를 들어, `(a: 10, a: 20)` 은 무효인데 동일한 수준에 이름표 `a` 가 두 번 나타나기 때문입니다. 하지만, `(a: 10, b: (a: 1, x: 2))` 는 유효입니다-`a` 가 두 번 나타나긴 하지만, 한 번은 바깥쪽 튜플에서 한 번은 안쪽 튜플에서 나타납니다.

튜플 표현식은 0 개의 표현식을 담거나, 둘 이상의 표현식을 담을 수 있습니다. 괄호 안에 표현식이 단 하나면 괄호 표현식입니다.

> 스위프트에서 빈 튜플 표현식과 빈 튜플 타입은 둘 다 `()` 로 작성합니다. `Void` 는 `()` 의 타입 별명이기 때문에, 이걸 써서 빈 튜플 타입을 작성할 수 있습니다. 하지만, 모든 타입 별명과 마찬가지로, `Void` 는 항상 타입입니다-이를 써서 빈 튜플 표현식을 작성할 순 없습니다.[^void-vs-empty-tuple-expression]

> GRAMMAR OF A TUPLE EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Wildcard Expression (와일드카드 표현식)

_와일드카드 표현식 (wildcard expression)_ 을 사용하면 할당 중에 값을 명시적으로 무시합니다. 예를 들어, 다음 할당에선 10 은 `x` 에 할당하고 20 은 무시합니다:

```swift
(x, _) = (10, 20)
// x 는 10 이고, 20 은 무시함
```

> GRAMMAR OF A WILDCARD EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Key-Path Expression (키-경로 표현식)

_키-경로 표현식 (key-path expression)_ 은 타입의 속성이나 첨자를 참조합니다. 키-값 관찰[^key-value-observing] 같은, 동적 프로그래밍 임무에서 키-경로 표현식을 사용합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;\\`type name-타입 이름`.`path-경로`

_타입 이름 (type name)_ 은, `String` 이나, `[Int]`, 또는 `Set<Int>` 같이, 어떤 일반화 매개 변수도 포함한, 고정 타입의 이름입니다.

_경로 (path)_ 는 속성 이름과, 첨자, 옵셔널-사슬 표현식, 및 포장을 강제로 푸는 표현식으로 구성됩니다. 이 각각의 키-경로 성분은 필요한 만큼 많이, 어떤 순서로든, 반복할 수 있습니다.

컴파일 시간에, 키-경로 표현식을 [KeyPath](https://developer.apple.com/documentation/swift/keypath) 클래스의 인스턴스로 교체합니다.

키-경로로 값에 접근하려면, `subscript(keyPath:)` 첨자에 키 경로를 전달하면 되는데, 이는 모든 타입에서 사용 가능합니다. 예를 들면 다음과 같습니다:

```swift
struct SomeStructure {
  var someValue: Int
}

let s = SomeStructure(someValue: 12)
let pathToProperty = \SomeStructure.someValue

let value = s[keyPath: pathToProperty]
// value 는 12 임
```

타입 추론이 암시 타입을 결정할 수 있는 상황에선 _타입 이름 (type name)_ 을 생략할 수 있습니다. 다음 코드는 `\SomeClass.someProperty` 대신 `\.someProperty` 를 사용합니다:

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

_경로 (path)_ 는 `self` 를 참조하여 자기 식별 키 경로 (`\.self`) 를 생성할 수 있습니다. 자기 식별 키 경로는 인스턴스 전체를 참조하므로, 이를 사용하여 변수 안에 저장한 모든 데이터를 한 번만에 접근하고 바꿀 수 있습니다. 예를 들면 다음과 같습니다:

```swift
var compoundValue = (a: 1, b: 2)
// compoundValue = (a: 10, b: 20) 와 같은 것
compoundValue[keyPath: \.self] = (a: 10, b: 20)
```

_경로 (path)_ 는 여러 속성 이름을, 마침표로 구분하여, 담아, 속성 값의 속성도 참조할 수 있습니다. 다음 코드는 `\OuterStructure.outer.someValue` 키 경로 표현식을 사용하여 `OuterStructure` 타입의 `outer` 속성에 있는 `someValue` 속성에 접근합니다:

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
// nestedValue 는 24 임
```

_경로 (path)_ 는, 첨자의 매개 변수 타입이 `Hashable` 프로토콜을 준수하는 한, 대괄호를 써서 첨자를 포함할 수 있습니다. 다음 예제는 키 경로에서 첨자를 써서 배열의 두 번째 원소에 접근합니다:

```swift
let greetings = ["hello", "hola", "bonjour", "안녕"]
let myGreeting = greetings[keyPath: \[String].[1]]
// myGreeting 은 'hola' 임
```

첨자에서 사용할 수 있는 값은 이름 붙인 값 또는 글자 값입니다. 키 경로는 값 의미 구조로 값을 붙잡습니다. 이 다음 코드는 키-경로 표현식과 클로저 둘 다에서 `index` 변수로 `greetings` 배열의 세 번째 원소에 접근합니다. `index` 를 수정할 땐, 키-경로 표현식이 여전히 세 번째 원소를 참조하는 동안, 클로저는 새로운 색인을 사용합니다.

```swift
var index = 2
let path = \[String].[index]
let fn: ([String]) -> String = { strings in strings[index] }

print(greetings[keyPath: path])
// "bonjour" 를 인쇄함
print(fn(greetings))
// "bonjour" 를 인쇄함

// 'index' 에 새 값을 설정하는 건 'path' 에 영향을 주지 않음
index += 1
print(greetings[keyPath: path])
// "bonjour" 를 인쇄함

// 'fn' 이 'index' 를 닫아 버리기 때문에, 새 값을 사용함
print(fn(greetings))
// "안녕" 를 인쇄함
```

_경로 (path)_ 는 옵셔널 사슬과 강제 포장 풀기를 사용할 수 있습니다. 이 다음 코드는 키 경로에서 옵셔널 사슬를 써서 옵셔널 문자열 안의 속성에 접근합니다:

```swift
let firstGreeting: String? = greetings.first
print(firstGreeting?.count as Any)
// "Optional(5)" 를 인쇄함

// 키 경로를 써서 똑같이 합니다.
let count = greetings[keyPath: \[String].first?.count]
print(count as Any)
// "Optional(5)" 를 인쇄함
```

키 경로의 성분을 섞어서 맞춰보면 타입 안에 깊숙히 중첩된 값에 접근할 수 있습니다. 다음 코드는 이러한 성분을 조합한 키-경로 표현식을 사용하여 배열 딕셔너리의 서로 다른 값과 속성에 접근합니다.

```swift
let interestingNumbers = ["prime": [2, 3, 5, 7, 11, 13, 17],
                          "triangular": [1, 3, 6, 10, 15, 21, 28],
                          "hexagonal": [1, 6, 15, 28, 45, 66, 91]]
print(interestingNumbers[keyPath: \[String: [Int]].["prime"]] as Any)
// "Optional([2, 3, 5, 7, 11, 13, 17])" 을 인쇄함
print(interestingNumbers[keyPath: \[String: [Int]].["prime"]![0]])
// "2" 를 인쇄함
print(interestingNumbers[keyPath: \[String: [Int]].["hexagonal"]!.count])
// "7" 을 인쇄함
print(interestingNumbers[keyPath: \[String: [Int]].["hexagonal"]!.count.bitWidth])
// "64" 를 인쇄함
```

보통은 함수나 클로저를 제공할 상황에서 키 경로 표현식을 사용할 수 있습니다. 특히, `(SomeType) -> Value` 타입의 함수나 클로저 대신, 근원 타입은 `SomeType` 이고 경로는 `Value` 타입의 값을 만드는 키 경로 표현식을 사용할 수도 있습니다.

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

// 아래의 접근법은 둘 다 같은 겁니다.
let descriptions = toDoList.filter(\.completed).map(\.description)
let descriptions2 = toDoList.filter { $0.completed }.map { $0.description }
```

키 경로 표현식의 어떤 부작용이든[^side-effects] 표현식을 평가하는 시점에만 평가합니다. 예를 들어, 키 경로 표현식의 첨자 안에 함수 호출을 만들면, 표현식 평가 부분에서 단 한번만 함수를 호출하지, 키 경로를 사용할 때마다 하진 않습니다.

```swift
func makeIndex() -> Int {
  print("Made an index")
  return 0
}
// 아래 줄은 makeIndex() 를 호출함
let taskKeyPath = \[Task][makeIndex()]
// "Made an index" 를 인쇄함

// taskKeyPath 의 사용은 makeIndex() 를 다시 호출하지 않음
let someTask = toDoList[keyPath: taskKeyPath]
```

오브젝티브-C API 와 상호 작용하는 코드에서의 키 경로 사용에 대한 더 많은 정보는, [Using Objective-C Runtime Features in Swift](https://developer.apple.com/documentation/swift/using_objective-c_runtime_features_in_swift) 항목을 보도록 합니다. 키-값 코딩과 키-값 관찰에 대한 정보는, [Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i) 항목과 [Key-Value Observing Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i) 항목을 보도록 합니다.

>> GRAMMAR OF A KEY-PATH EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Selector Expression (선택자 표현식)

_선택자 표현식 (selector expression)_ 은 선택자[^selector] 에 접근해서 오브젝티브-C 의 메소드나 속성의 획득자 또는 설정자를 참조하게 해줍니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;\#selector(`method name-메소드 이름`)<br />
&nbsp;&nbsp;&nbsp;&nbsp;\#selector(getter: `property name-속성 이름`<br />
&nbsp;&nbsp;&nbsp;&nbsp;\#selector(setter: `property name-속성 이름`)

_메소드 이름 (method name)_ 과 _속성 이름 (property name)_ 은 반드시 오브젝티드-C 런타임에서 사용 가능한 메소드나 속성을 참조해야 합니다. 선택자 표현식의 값은 `Selector` 타입의 인스턴스입니다. 예를 들면 다음과 같습니다:

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

속성의 획득자를 위해 선택자를 생성할 땐, _속성 이름 (property name)_ 이 변수 또는 상수 속성의 참조일 수 있습니다. 이와 대조적으로, 속성의 설정자를 위해 선택자를 생성할 땐, _속성 이름 (property name)_ 이 반드시 변수 속성만의 참조여야 합니다.

_메소드 이름 (method name)_ 은, 이름은 공유하지만 타입 서명은 다른 메소드[^methods-type-signatures] 사이의 모호함을 없애는 `as` 연산자뿐 아니라, 그룹을 짓기 위한 괄호도 담을 수 있습니다. 예를 들면 다음과 같습니다:

```swift
extension SomeClass {
  @objc(doSomethingWithString:)
  func doSomething(_ x: String) { }
}
let anotherSelector = #selector(SomeClass.doSomething(_:) as (SomeClass) -> (String) -> Void)
```

실행 시간이 아닌, 컴파일 시간에 선택자를 생성하기 때문에, 메소드 및 속성이 존재하는지 그리고 오브젝티브-C 런타임으로 드러냈는지를 컴파일러가 검사할 수 있습니다.

> _메소드 이름 (method name)_ 과 _속성 이름 (property name)_ 은 표현식이긴 하지만, 절대로 평가하지 않습니다.

오브젝티브-C API 와 상호 작용하는 스위프트 코드에서의 선택자 사용에 대한 더 많은 정보는, [Using Objective-C Runtime Features in Swift](https://developer.apple.com/documentation/swift/using_objective-c_runtime_features_in_swift) 항목을 보도록 합니다.

> GRAMMAR OF A SELECTOR EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

#### Key-Path String Expression (키 경로 문자열 표현식)

키-경로 문자열 표현식은 문자열에 접근해서, 키-값 코딩과 키-값 관찰 API 에서 사용할, 오브젝티브-C 의 속성을 참조하게 해줍니다.[^key-path-string-expression] 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;\#keyPath(`property name-속성 이름`)

_속성 이름 (property name)_ 은 반드시 오브젝티브-C 런타임에서 사용 가능한 속성을 참조해야 합니다. 컴파일 시간에, 키-경로 문자열 표현식을 문자열 글자 값으로 교체합니다. 예를 들면 다음과 같습니다:

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
// "12" 를 인쇄함
```

클래스 안에서 키-경로 문자열 표현식을 사용할 땐, 클래스 이름 없이, 그냥 속성 이름만 작성하여 그 클래스의 속성을 참조할 수 있습니다.

```swift
extension SomeClass {
  func getSomeKeyPath() -> String {
    return #keyPath(someProperty)
  }
}
print(keyPath == c.getSomeKeyPath())
// "true" 를 인쇄함
```

실행 시간이 아닌, 컴파일 시간에 키 경로 문자열을 생성하기 때문에, 속성이 존재하는지 그리고 속성을 오브젝티브-C 런타임으로 드러냈는지를 컴파일러가 검사할 수 있습니다.

오브젝티브-C API 와 상호 작용하는 스위프트 코드에서의 키 경로 사용에 대한 더 많은 정보는, [Using Objective-C Runtime Features in Swift](https://developer.apple.com/documentation/swift/using_objective-c_runtime_features_in_swift) 항목을 보도록 합니다. 키-값 코딩과 키-값 관찰에 대한 정보는, [Key-Value Coding Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueCoding/index.html#//apple_ref/doc/uid/10000107i) 항목과 [Key-Value Observing Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html#//apple_ref/doc/uid/10000177i) 항목을 보도록 합니다.

> _속성 이름 (property name)_ 은 표현식이긴 하지만, 절대로 평가하지 않습니다.

> GRAMMAR OF A KEY-PATH STRING EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID389)

### Postfix Expressions (접미사 표현식)

_접미사 표현식 (postfix expressions)_ 은 접미사 연산자나 그 외 접미사 구문을 표현식에 적용함으로써 형성합니다. 구문상, 모든 으뜸 표현식은 접미사 표현식이기도 합니다.

이러한 연산자의 동작에 대한 정보는, [Basic Operators (기초 연산자)]({% link docs/swift-books/swift-programming-language/basic-operators.md %}) 과 [Advanced Operators (고급 연산자)]({% link docs/swift-books/swift-programming-language/advanced-operators.md %}) 장을 보도록 합니다.

스위프트 표준 라이브러리가 제공하는 연산자에 대한 정보는, [Operator Declarations](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 항목을 참고하기 발랍니다.

> GRAMMAR OF A POSTFIX EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Function Call Expression (함수 호출 표현식)

_함수 호출 표현식 (function call expression)_ 은 함수 이름과 그 뒤의 괄호 안에 넣은 쉼표로-구분한 함수 인자 목록으로 구성합니다. 함수 호출 표현식의 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`function name-함수 이름`(`argument value 1-인자 값 1`, `argument value 2-인자 값 2`)

_함수 이름 (function name)_ 은 그 값이 함수 타입인 어떤 표현식이든 될 수 있습니다.

함수 정의가 자신의 매개 변수의 이름[^argument-label] 을 포함하면, 함수 호출도 반드시 자신의 인자 값 앞에, 콜론 (`:`) 으로 구분한, 이름을 포함해야 합니다. 이런 종류의 함수 호출 표현식 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`function name-함수 이름`(`argument name 1-인자 이름 1`: `argument value 1-인자 값 1`, `argument name 2-인자 이름 2`: `argument value 2-인자 값 2`)

함수 호출 표현식은 닫는 괄호 바로 뒤에 클로저 표현식 형식의 뒤딸린 클로저 (trailing closures) 를 포함할 수 있습니다. 뒤딸린 클로저는, 괄호 안 마지막 인자 뒤에 추가된, 함수 인자로 이해합니다. 첫 번째 클로저 표현식엔 이름표를 붙이지 않으며; 추가적인 어떤 클로저 표현식이든 앞에 자신의 인자 이름표를 붙입니다. 아래 예제는 뒤딸린 클로저 구문을 사용한 것과 하지 않은 게 서로 같은 함수 호출을 보여줍니다:

```swift
// someFunction 은 하나의 정수와 하나의 클로저를 인자로 취함
someFunction(x: x, f: { $0 == 13 })
someFunction(x: x) { $0 == 13 }

// anotherFunction 은 하나의 정수와 두 개의 클로저를 인자로 취함
anotherFunction(x: x, f: { $0 == 13 }, g: { print(99) })
anotherFunction(x: x) { $0 == 13 } g: { print(99) }
```

뒤딸린 클로저가 함수의 유일한 인자면, 괄호를 생략할 수 있습니다.

```swift
// someMethod 는 하나의 클로저를 자신의 유일한 인자로 취함
myData.someMethod() { $0 == 13 }
myData.someMethod { $0 == 13 }
```

뒤딸린 클로저를 인자에 포함하려고, 다음 처럼 컴파일러가 함수 매개 변수를 왼쪽에서 오른쪽으로 검토합니다:

뒤딸린 클로저 || 매개 변수 || 행동
---|---|---|---|---
이름표 있음 | | 이름표 있음 | | 이름표가 똑같으면, 클로저가 매개 변수와 일치하며; 그 외 경우, 매개 변수를 건너 뜁니다.
이름표 있음 | | 이름표 없음 | | 매개 변수를 건너 뜁니다.
이름표 없음 | | 이름표 있거나 없음 | | 아래 정의한 것처럼, 매개 변수의 구조가 함수 타입과 닮았으면, 클로저가 매개 변수와 일치하며; 그 외 경우, 매개 변수를 건너 뜁니다.

뒤딸린 클로저는 자신과 일치한 매개 변수에 인자로 전달됩니다. 조사 과정 중에 건너 뛴 매개 변수엔 인자를 전달하지 않습니다-예를 들어, 기본 매개 변수를 사용할 수 있습니다. 일치한 걸 찾은 후, 그 다음 뒤딸린 클로저 및 그 다음 매개 변수를 계속 조사합니다. 맞춤 과정의 끝에선, 반드시 모든 뒤딸린 클로저에 일치하는 게 있어야 합니다.

매개 변수가 입-출력 매개 변수가 아니면서, 다음 중 하나라면, 매개 변수가 함수 타입과 _구조가 닮은 (structually resembles)_ 겁니다:

* `(Bool) -> Int` 같이, 타입이 함수 타입인 매개 변수
* `@autoclosure ()-> ((Bool)-> Int)` 같이, 포장한 표현식의 타입이 함수 타입인 자동 클로저 매개 변수
* `((Bool) -> Int)...` 같이, 배열 원소 타입이 함수 타입인 가변 매개 변수
* `Optional<(Bool) -> Int>` 같이, 타입이 한 겹 이상의 옵셔널로 포장된 매개 변수
* `(Optional<(Bool) -> Int>) ...` 같이, 이렇게 허용한 타입들의 조합인 매개 변수

뒤딸린 클로저가 함수 타입과 타입이 닮은 구조인 매개 변수와 일치하나, 함수는 아닐 땐, 필요에 따라 클로저를 포장합니다. 예를 들어, 매개 변수 타입이 옵셔널 타입이면, 자동으로 클로저를 `Optional` 로 포장합니다.

이런 맞춤을 오른쪽에서 왼쪽으로 한-스위프트 5.3 이전 버전의 코드를 쉽게 이전하도록, 컴파일러는 왼쪽-에서-오른쪽과 오른쪽-에서-왼쪽 순서 둘 다로 검사합니다. 조사한 방향에 따라 결과과 다르면, 예전의 오른쪽-에서-왼쪽 순서를 사용하고 컴파일러가 경고를 생성합니다. 미래 버전의 스위프트는 항상 왼쪽-에서-오른쪽 순서를 사용할 겁니다.[^left-to-right]

```swift
typealias Callback = (Int) -> Int
func someFunction(firstClosure: Callback? = nil,
                  secondClosure: Callback? = nil) {
  let first = firstClosure?(10)
  let second = secondClosure?(20)
  print(first ?? "-", second ?? "-")
}

someFunction()  // "- -" 를 인쇄함
someFunction { return $0 + 100 }  // 헷갈림
someFunction { return $0 } secondClosure: { return $0 }  // "10 20" 를 인쇄함
```

위 예제에서, "헷갈림 (ambiguous)" 으로 표시한 함수 호출은 "- 120" 을 인쇄하며 스위프트 5.3 에서 컴파일러 경고를 만듭니다. 미래 버전의 스위프트는 "110 -" 을 인쇄할 겁니다.

클래스나, 구조체, 또는 열거체 타입은, [Methods with Special Names (특수한 이름의 메소드)]({% link docs/swift-books/swift-programming-language/declarations.md %}#methods-with-special-names-특수한-이름의-메소드) 에서 설명한, 여러가지 메소드 중 하나를 선언함으로써 수월한 함수 호출 구문을 사용할 수 있습니다.

<p>
<strong id="implicit-conversion-to-a-pointer-type-포인터-타입으로의-암시적-변환">Implicit Conversion to a Pointer Type (포인터 타입으로의 암시적 변환)</strong>
</p>

함수 호출 표현식에서, 인자와 매개 변수 타입이 서로 다르면, 컴파일러는 이들의 타입을 맞춰보려고 다음 목록에 있는 암시적 변환 중 하나를 적용합니다:

* `inout SomeType` 은 `UnsafePointer<SomeType>` 이나 `UnsafeMutablePointer<SomeType>` 이 될 수 있음
* `inout Array<SomeType>` 은 `UnsafePointer<SomeType>` 이나 `UnsafeMutablePointer<SomeType>` 이 될 수 있음
* `Array<SomeType>` 은 `UnsafePointer<SomeType>` 이 될 수 있음
* `String` 은 `UnsafePointer<CChar>` 가 될 수 있음

다음의 두 함수 호출은 서로 같은 겁니다:

```swift
func unsafeFunction(pointer: UnsafePointer<Int>) {
  // ...
}
var myNumber = 1234

unsafeFunction(pointer: &myNumber)
withUnsafePointer(to: myNumber) { unsafeFunction(pointer: $0) }
```

이렇게 암시적 변환으로 생성한 포인터는 함수 호출 지속 시간에만 유효합니다. 정의안된 동작을 피하려면, 함수 호출이 끝난 후엔 코드가 절대로 포인터를 붙들고 있지 않도록 보장하기 바랍니다.

> 배열을 안전하지 않은 포인터로 암시적 변환할 때, 스위프트는 필요에 따라 배열을 변환하거나 복사함으로써 배열 저장 공간이 딱 붙어있도록 보장합니다.[^contiguous] 예를 들어, 저장 공간에 대한 API 계약이 없는 `NSArray` 하위 클래스에서 `Array` 로 연동한 배열에 이 구문을 사용할 수 있습니다. 배열 저장 공간이 이미 딱 붙어 있음을 보증해서, 암시적 변환이 절대 이 작업을 할 필요가 없다면, `Array` 대신 `ContiguousArray` 를 사용합니다.

`withUnsafePointer(to:)` 같은 명시적 함수 대신 `&` 를 사용하는 건, 특히 함수가 여러가지 포인터 인자를 취할 때의, 저-수준 C 함수 호출을 더 이해하기 쉽게 해줍니다. 하지만, 다른 스위프트 코드의 함수를 호출할 땐, 안전하지 않은 API 를 명시적으로 사용하는 대신 `&` 를 사용하는 걸 피하도록 합니다.

> GRAMMAR OF A FUNCTION CALL EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Initializer Expression (초기자 표현식)

_초기자 표현식 (initializer expression)_ 은 타입 초기자에 대한 접근을 제공합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식`.init(`initializer arguments-초기자의 인자`)

함수 호출 표현식에서 초기자 표현식을 사용하여 타입의 새로운 인스턴스를 초기화합니다. 초기자 표현식을 사용하여 상위 클래스 초기자로 일을 맡기기 (delegate) 도 합니다.

```swift
class SomeSubClass: SomeSuperClass {
    override init() {
        // 하위 클래스 초기화는 여기에 둠
        super.init()
    }
}
```

함수 같이, 초기자를 값처럼 사용할 수도 있습니다. 예를 들면 다음과 같습니다:

```swift
// 타입 보조 설명이 필요한데 String 의 초기자는 여러 개이기 때문입니다.
let initializer: (Int) -> String = String.init
let oneTwoThree = [1, 2, 3].map(initializer).reduce("", +)
print(oneTwoThree)
// "123" 을 인쇄함
```

타입 이름을 정하면, 초기자 표현식을 사용하지 않고 타입 초기자에 접근할 수 있습니다. 다른 모든 경우엔, 반드시 초기자 표현식을 사용해야 합니다.

```swift
let s1 = SomeType.init(data: 3)  // 유효함
let s2 = SomeType(data: 1)       // 역시 유효함

let s3 = type(of: someValue).init(data: 7)  // 유효함
let s4 = type(of: someValue)(data: 5)       // 에러
```

> GRAMMAR OF AN INITIALIZER EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Explicit Member Expression (명시적 멤버 표현식)

_명시적 멤버 표현식 (explicit member expression)_ 은 이름 붙인 타입이나, 튜플, 또는 모듈의 멤버에 대한 접근을 허용합니다. 이는 항목과 자신의 멤버 식별자 사이의 마침표 (`.`) 로 구성됩니다.

&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식`.`member name-멤버 이름`

이름 붙인 타입의 멤버는 타입의 선언이나 익스텐션 부분에서 이름이 붙습니다. 예를 들면 다음과 같습니다:

```swift
class SomeClass {
  var someProperty = 42
}
let c = SomeClass()
let y = c.someProperty  // 멤버 접근
```

튜플의 멤버는 암시적으로, 자신이 나타나는 순서대로, 0 부터 시작하는 정수로, 이름이 붙습니다. 예를 들면 다음과 같습니다:

```swift
var t = (10, 20, 30)
t.0 = t.1
// t 는 이제 (20, 20, 30) 임
```

모듈의 멤버는 그 모듈의 최상단 선언들에 접근합니다.

`dynamicMemberLookup` 특성으로 선언한 타입은, [Attributes (특성)]({% link docs/swift-books/swift-programming-language/attributes.md %}) 에서 설명한 것처럼, 실행 시간에 찾아 보는 멤버를 포함합니다.

이름이 다른 거라곤 자신의 인자 이름뿐인 메소드나 초기자를 구별하려면, 괄호 안에 인자 이름을 포함하고, 각각의 인자 이름 뒤에 콜론 (`:`) 을 붙입니다. 이름 없는 인자엔 밑줄 (`_`) 을 씁니다. 중복 정의한 메소드를 구별하려면, 타입 보조 설명을 사용합니다. 예를 들면 다음과 같습니다:

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

마침표가 줄 맨 앞에 나타나면, 암시적 멤버 표현식이 아닌, 명시적 멤버 표현식의 일부분으로 이해합니다. 예를 들어, 아래 나열한 건 연쇄적인 메소드 호출을 여러 줄로 쪼갠 걸 보여줍니다:

```swift
let x = [10, 3, 20, 15, 4]
    .sorted()
    .filter { $0 > 5 }
    .map { $0 * 100 }
```

이렇게 여러 줄로 연쇄한 구문을 컴파일러 제어문으로 조합하여 각각의 메소드 호출 시점을 제어할 수 있습니다. 예를 들어, 다음 코드는 iOS 에선 다른 규칙으로 걸러냅니다:

```swift
let numbers = [10, 20, 33, 43, 50]
#if os(iOS)
.filter { $0 < 40 }
#else
.filter { $0 > 25 }
#endif
```

`#if` 와, `#endif`, 및 다른 컴파일 지시자 사이에 있는, 조건부 컴파일 블럭[^conditional-compilation-block] 에 암시적 멤버 표현식 및 그 뒤의 0 개 이상의 접미사를 담아, 접미사 표현식을 형성할 수 있습니다. 또 다른 조건부 컴파일 블럭이나, 이 표현식과 블럭들을 조합한 것도 담을 수 있습니다.

최상단 코드 뿐만 아니라, 명시적 멤버 표현식을 작성할 수 있는 어떤 곳이든 이 구문을 사용할 수 있습니다.

조건부 컴파일 블럭에서, `#if` 컴파일 지시자 분기는 반드시 적어도 하나의 표현식을 담아야 합니다. 다른 분기는 비어도 됩니다. 

> GRAMMAR OF AN EXPLICIT MEMBER EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Postfix Self Expression (접미사 self 표현식)

접미사 `self` 표현식은 표현식 또는 타입 이름과, 바로 뒤의 `.self` 로, 구성됩니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`expression`.self<br />
&nbsp;&nbsp;&nbsp;&nbsp;`type`.self

첫 번째 형식은 _표현식 (expression)_ 의 값을 평가합니다. 예를 들어, `x.self` 는 `x` 를 평가합니다.

두 번째 형식은 _타입 (type)_ 의 값을 평가합니다. 타입을 값으로 접근하려면 이 형식을 사용합니다. 예를 들어, `SomeClass.self` 는 `SomeClass` 타입 그 자체라고 평가하기 때문에, 타입-수준 인자를 받아들이는 함수나 메소드에 전달할 수 있습니다.

> GRAMMAR OF A POSTFIX SELF EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Subscript Expression (첨자 표현식)

_첨자 표현식 (subscript expression)_ 은 해당 첨자 선언의 획득자와 설정자를 사용한 첨자 접근을 제공합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식`[`index expressions-색인 표현식`]

첨자 표현식의 값을 평가하려면, 첨자 매개 변수로 전달한 _색인 표현식 (index expressions)_ 으로 _표현식 (expression)_ 타입의 첨자 획득자를 호출합니다. 값을 설정하려면, 첨자 설정자를 똑같은 방식으로 호출합니다.

첨자 선언에 대한 정보는, [Protocol Subscript Declaration (프로토콜 첨자 선언)]({% link docs/swift-books/swift-programming-language/declarations.md %}#protocol-subscript-declaration-프로토콜-첨자-선언) 부분을 보도록 합니다.

> GRAMMAR OF A PROTOCOL SUBSCRIPT DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Forced-Value Expression (강제-값 표현식)

_강제-값 표현식 (forced-value expression)_ 은 `nil` 이 아닌 게 확실한 옵셔널 값의 포장을 풉니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식`!

_표현식 (expression)_ 값이 `nil` 이 아니면, 옵셔널 값의 포장을 풀고 옵셔널-아닌 해당 타입으로 반환합니다. 그 외 경우, 실행시간 에러가 일어납니다.

강제-값 표현식의 포장 푼 값은, 값 그 자체를 변경하거나, 값의 멤버 중 하나에 할당함으로써, 수정할 수 있습니다. 예를 들면 다음과 같습니다:

```swift
var x: Int? = 0
x! += 1
// x 는 이제 1 임

var someDictionary = ["a": [1, 2, 3], "b": [10, 20]]
someDictionary["a"]![0] = 100
// someDictionary 는 이제 ["a": [100, 2, 3], "b": [10, 20]] 임
```

> GRAMMAR OF A FORCED-VALUE EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

#### Optional-Chaining Expression (옵셔널-사슬 표현식)

_옵셔널-사슬 표현식 (optional-chaining expression)_ 은 접미사 표현식에서 옵셔널 값을 사용하기 위한 단순화 구문을 제공합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`expression-표현식`?

접미사 `?` 연산자는 표현식 값을 바꾸지 않고도 표현식을 옵셔널-사슬 표현식으로 만듭니다.

옵셔널-사슬 표현식은 반드시 접미사 표현식 안에 있어야 하며, 접미사 표현식을 특수한 방식으로 평가하게 합니다. 옵셔널-사슬 표현식 값이 `nil` 이면, 접미사 표현식 안의 모든 다른 연산을 무시하고 전체 접미사 표현식을 `nil` 로 평가합니다. 옵셔널-사슬 표현식 값이 `nil` 이 아니면, 옵셔널-사슬 표현식 값의 포장을 풀고 이를 써서 접미사 표현식의 나머지 부분을 평가합니다. 어느 경우든, 접미사 표현식 값은 여전히 옵셔널 타입입니다.

옵셔널-사슬 표현식을 담은 접미사 표현식이 다른 접미사 표현식 안에 중첩되어 있으면, 가장 바깥쪽 표현식만 옵셔널 타입을 반환합니다.[^outmost-expression] 아래 예제에서, `c` 가 `nil` 이 아닐 때, 값의 포장을 풀고 이를 써서 `.property` 를 평가한 후, 그 값으로 `.performAction()` 을 평가합니다. 전체 표현식 `c?.property.performAction()` 의 값은 옵셔널 타입입니다.

```swift
var c: SomeClass?
var result: Bool? = c?.property.performAction()
```

다음 예제는 위 예제 동작을 옵셔널 사슬 사용없이 (하는 걸) 보여줍니다.

```swift
var result: Bool?
if let unwrappedC = c {
    result = unwrappedC.property.performAction()
}
```

옵셔널-사슬 표현식의 포장 푼 값은, 값 그 자체를 변경하거나, 값의 멤버 중 하나에 할당함으로써, 수정할 수 있습니다. 옵셔널-사슬 표현식 값이 `nil` 이면, 할당 연산자의 오른-쪽 표현식을 평가하지 않습니다. 예를 들면 다음과 같습니다:

```swift
func someFunctionWithSideEffects() -> Int {
    return 42  // 실제 부작용은 없음.
}
var someDictionary = ["a": [1, 2, 3], "b": [10, 20]]

someDictionary["not here"]?[0] = someFunctionWithSideEffects()
// someFunctionWithSideEffects 를 평가하지 않음
// someDictionary 는 여전히 ["a": [1, 2, 3], "b": [10, 20]] 임

someDictionary["a"]?[0] = someFunctionWithSideEffects()
// someFunctionWithSideEffects 를 평가하고 42 를 반환함
// someDictionary 는 이제 ["a": [42, 2, 3], "b": [10, 20]] 임
```

> GRAMMAR OF AN OPTIONAL-CHAINING EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html#ID397)

### 다음 장

[Statements (구문) >]({% link docs/swift-books/swift-programming-language/statements.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [Expressions](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html) 에서 볼 수 있습니다.

[^primary-expression]: '으뜸 표현식 (primary expression)' 은 아래의 [Primary Expressions (으뜸 표현식)]({% link docs/swift-books/swift-programming-language/expressions.md %}#primary-expressions-으뜸-표현식) 부분에서 설명합니다.

[^side-effect]: 컴퓨터 용어에서의 '부작용 (side effect)' 은 '부수적 효과' 정도로 이해할 수 있습니다. 보다 자세한 내용은 위키피디아의 [Side effect (computer science)](https://en.wikipedia.org/wiki/Side_effect_(computer_science)) 및 [부작용 (컴퓨터 과학)](https://ko.wikipedia.org/wiki/부작용_(컴퓨터_과학)) 항목을 보도록 합니다.

[^playground-literal]: 예를 들어 '빨간색' 플레이그라운드 글자 값은 ![Playground Color](/assets/Swift/Swift-Programming-Language/Expressions-playground-literal.png){:width="100px"} 인데, 이를 복사하여 다른 편집기로 옮기면 `var color = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)` 과 같은 특수 글자 값 구문을 써서 나타냅니다.

[^operator-declarations]: 원문 자체가 애플 개발자 사이트로 연결되는 링크로 되어 있습니다.

[^flat-list]: '납작한 리스트 (flat list)' 는 차원을 축소하여 1-차원화한 리스트라고 이해할 수 있습니다.

[^upcasting]: '올림 변환 (upcasting)' 은 하위 클래스에서 상위 클래스로 형변환하는 것을 말합니다. 하위 클래스는 상위 클래스를 상속한 것이기 때문에 올림 변환은 항상 성공합니다. 

[^bridging]: '연동 (bridging)' 은 애플에서 스위프트의 자료 타입과 오브젝티브-C 의 자료 타입을 서로 호환해서 사용할 수 있도록 만든 방식입니다. 본문 뒤에 나오는 설명 처럼 연동을 사용하여 `String` 타입을 `NSString` 타입으로 변환하여 사용할 수 있습니다. 

[^foundation]: '파운데이션 (Foundation)' 은 스위프트 프로그래밍 언어의 기반을 이루는 프레임웍으로, 보통 `import Foundation` 으로 불러옵니다. 여기서 말하는 파운데이션 타입은 오브젝티브-C 와의 호환성을 위해 Foundation 프레임웍 안에 정의되어 있는 타입을 의미합니다. 

[^the-path]: `#ifle` 이 있는 곳의 파일 경로를 의미합니다.

[^dynamic-shared-object]: '동적 공유 객체 (dynamic shared object; DSO)' 는 `.dylib` 나 `.so` 같이 현재 실행 중인 동적 연결 라이브러리를 의미합니다. 이에 대한 더 자세한 내용은, 애플 개발자 문서의 [Overview of Dynamic Libraries](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/DynamicLibraries/100-Articles/OverviewOfDynamicLibraries.html) 항목을 보도록 합니다. 

[^filePath-and-fildID]: 스위프트 5.3 이전까지의 `#file` 은 그 파일의 전체 경로였는데, 앞으로는 파일과 모듈 이름으로 바뀌게 됩니다. 본문의 내용은 현재는 `#file` 이 `#filePath` 와 똑같지만, 앞으로는 `#fileID` 와 똑같아질 거라는 의미입니다.

[^file-to-filePath-and-fildID]: 미래 버전의 스위프트에선 `#file` 과 `#filePath` 를 확실하게 구분하려는 것 같습니다. 본문의 내용을 보면 `#filePath` 를 출하용 프로그램에서만 사용할 것을 권하는데, 이러한 구분은 개인 정보 보호 (privacy) 정책과도 관련있는 것 같습니다.

[^shipping-program]: 개인이 소유하거나 컴파일하여 바이너리로 변환할 게 아닌 코드엔 `#filePath` 를 사용하지 않음으로써 개인 정보를 보호할 수 있다는 의미입니다.

[^first-and-last-slash]: 현재는 `#fileID` 에 빗금이 하나 밖에 없어서 첫 번째와 마지막 빗금이 똑같지만, 미래에는 빗금이 여러 개일 수도 있으므로, 첫 번째와 마지막 빗금을 기준으로 읽을 것을 권장하고 있습니다.

[^ordered-collection]: '순서 있는 집합체 (ordered collections)' 와 '정렬된 집합체 (sorted collection)' 는 서로 다른 겁니다. 이 둘의 차이점에 대해선, 스택 오버플로우 (StackOverflow) 의 [What is the difference between an ordered and a sorted collection?](https://stackoverflow.com/questions/1084146/what-is-the-difference-between-an-ordered-and-a-sorted-collection) 항목을 보도록 합니다.

[^mutating-method]: 값 타입 (value type) 은 구조체와 열거체를 말하고, '변경 메소드 (mutating method)' 는 값 타입의 `self` 를 변경할 수 있는 메소드를 말합니다. 본문은 `self` 에 다른 인스턴스를 할당함으로써 값 타입을 변경할 수 있다는 의미입니다.

[^capture]: 클로저의 '붙잡기 (capturoing)' 에 대한 더 자세한 정보는, [Closures (클로저; 잠금 블럭)]({% link docs/swift-books/swift-programming-language/closures.md %}) 장의 [Capturing Values (값 붙잡기)]({% link docs/swift-books/swift-programming-language/closures.md %}#capturing-values-값-붙잡기) 부분을 보도록 합니다. 

[^escaping-or-nonescaping]: 클로저 표현식이 벗어나는 건지 벗어나지 않는 건지는 표현식 자체가 아니라 표현식을 호출하는 쪽에 달려 있다는 의미입니다.

[^strong-reference]: '강한 참조 (strong reference)' 에 대해서는 [Automatic Reference Counting (자동 참조 카운팅)]({% link docs/swift-books/swift-programming-language/automatic-reference-counting.md %}) 장을 보도록 합니다. 

[^reference-semantics]: '참조 의미 구조 (reference semantics)' 에 대한 더 자세한 정보는, [Classes Are Reference Types (클래스는 참조 타입입니다)]({% link docs/swift-books/swift-programming-language/structures-and-classes.md %}#classes-are-reference-types-클래스는-참조-타입입니다) 부분을 보도록 합니다.

[^because-of-reference]: `x` 가 클래스의 인스턴스라서 참조 의미 구조를 가지기 때문에 바깥 영역의 `x` 와 안쪽 영역의 `x` 가 동일한 대상을 참조합니다.

[^weak-and-unowned-capture]: 클로저와 클래스는 둘 다 참조 타입이기 때문에, 서로를 참조하면 강한 참조 순환이 발생합니다. 이를 막기 위해, 약한 참조나 소유하지 않는 참조를 사용합니다.

[^strength]: `strong` 이나, `weak`, 또는 `unowned` 로 지정한 강하기로 붙잡는다는 의미입니다.

[^implied-type]: 자신의 암시 타입은 `SomeClass` 인데, `f()` 메소드의 반환 타입이 `SomeClass` 이므로 정확하게 일치합니다.

[^void-vs-empty-tuple-expression]: 그렇기 때문에 `Void -> Void` 같은 함수 타입은 없습니다. `() -> Void` 라고 해야 합니다. 

[^key-value-observing]: '키-값 관찰 (Key-Value Observing)' 에 대한 더 자세한 정보는, 애플 개발자 문서의 [Using Key-Value Observing in Swift](https://developer.apple.com/documentation/swift/cocoa_design_patterns/using_key-value_observing_in_swift) 항목을 보도록 합니다.

[^side-effects]: 프로그래밍에서의 '부작용 (side effects)' 은 '부수적 효과' 정도의 의미입니다.

[^selector]: 오브젝티브-C 의 '선택자 (selector)' 는 오브젝티브-C 메소드 이름을 참조하는 타입입니다. 스위프트의 선택자 표현식은 이 오브젝티브-C 의 선택자에 접근하도록 해줍니다. 이에 대한 더 자세한 정보는, 애플 개발자 문서의 [Using Objective-C Runtime Features in Swift](https://developer.apple.com/documentation/swift/using-objective-c-runtime-features-in-swift) 항목을 보도록 합니다. 

[^methods-type-signatures]: '이름은 공유하지만 타입 서명은 다른 메소드' 는 '중복 정의 (overloading) 하여 함수 이름은 같지만 매개 변수 및 반환 타입을 포함한 함수의 타입 자체는 다른 메소드들' 을 말합니다.

[^key-path-string-expression]: '키-경로 문자열 표현식 (key-path string expression)' 은 '키-경로 표현식 (key-path expression)' 을 오브젝티브-C 의 속성에 사용하기 위한 방법일 것이라고 생각합니다.

[^argument-label]: 여기서 말하는 '매개 변수의 이름' 은 '인자 이름표 (argument label)' 를 의미합니다. '인자 이름표' 에 대한 더 자세한 설명은, [Function Argument Labels and Parameter Names (함수의 인자 이름표와 매개 변수 이름)]({% link docs/swift-books/swift-programming-language/functions.md %}#function-argument-labels-and-parameter-names-함수의-인자-이름표와-매개-변수-이름) 부분을 보도록 합니다. 

[^left-to-right]: 스위프트 5.3 이전 버전에서 오른쪽-에서-왼쪽 순서를 사용한 건, 예전엔 뒤딸린 클로저가 가장 오른쪽 매개 변수 하나뿐이었기 때문으로 추측합니다. 스위프트 5.3 이후 부턴 뒤 딸린 클로저가 여러 개일 수 있어서 왼쪽-에서-오른쪽 순서를 사용한다고 볼 수 있습니다.

[^contiguous]: 배열 저장 공간이 딱 붙어있다는 건 배열 전체를 메모리 안에 한 덩어리로 저장한다는 의미입니다. 이렇게 하면 배열 주소를 더하고 빼는 것으로도 배열 요소를 탐색할 수 있습니다.

[^conditional-compilation-block]: '조건부 컴파일 블럭 (Conditional Compilation Block)' 에 대한 더 자세한 내용은, [Conditional Compilation Block (조건부 컴파일 블럭)]({% link docs/swift-books/swift-programming-language/statements.md %}#conditional-compilation-block-조건부-컴파일-블럭) 부분을 보도록 합니다.

[^outmost-expression]: 옵셔널을 다시 옵셔널로 포장하지는 않는다는 의미입니다. 이에 대한 더 자세한 내용은, [Optional Chaining (옵셔널 사슬)]({% link docs/swift-books/swift-programming-language/optional-chaining.md %}) 장을 보도록 합니다.

[^using-unsafe-API]: 이 말은 `&` 같은 '입-출력 매개 변수' 를 사용해서 '안전하지 않은 포인터' 로 암시적으로 변환하는 기능은 '저-수준 C 함수' 를 호출할 때만 사용하라는 의미입니다.

