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

### Binary Expressions (이항 표현식)

#### Assignment Operator

#### Ternary Conditional Operator

#### Type-Casting Operators

### Primary Expressions

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

#### Self Expression

#### Superclass Expression

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
