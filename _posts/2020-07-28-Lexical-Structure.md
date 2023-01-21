---
layout: post
comments: true
title:  "Lexical Structure (어휘 구조)"
date:   2020-07-28 11:30:00 +0900
categories: Swift Language Grammar Reference Lexical-Structure
---

{% include header_swift_book.md %}

## Lexical Structure (어휘 구조)

스위프트의 _어휘 구조 (lexical structure)_ 는 언어의 유효 낱말[^token] 을 형성하는 일련의 문자가 뭔지를 설명합니다. 이러한 유효 낱말이 언어의 가장 낮은-수준 건축 자재를 형성하며 이를 써서 뒤이은 장의 언어 나머지 (부분)을 설명합니다. 낱말은 식별자 (identifier) 나, 키워드 (keyword), 글자 값 (literal), 또는 연산자 (operator) 로 구성합니다.

대부분의 경우, 낱말의 생성은, 밑에서 지정할 문법의 구속 조건 안에서, 스위프트 소스 파일 문자 중 입력 텍스트의 가능한 가장 긴 하위 문자열을 고려합니다. 이런 동작을 _longest match (가장 긴 일치)_ 또는 _maximal munch (최대한 잘라먹기)_[^maximal-munch] 라고 합니다.

### Whitespace and Comments (공백과 주석)

공백은: 소스 파일 안의 낱말 구분 그리고 ([Operators (연산자)](#operators-연산자) 에서 보듯) 접두사, 접미사, 및 중위 연산자 구별이라는 두 개의 용도가 있지만, 그 외 경우엔 무시합니다. 다음의 문자를 공백이라고 고려합니다: 공간 (space; U+0020), 줄 먹임 (line feed; U+000A), 캐리지 반환 (carriage return; U+000D), 가로 탭 (horizontal tab; U+0009), 세로 탭 (vertical tab; U+000B), 양식 먹임 (form feed; U+000C)[^form-feed], 및 널 문자 (null; U+0000).

주석 (comments) 은 컴파일러가 공백처럼 취급합니다. 한 줄 주석은 `//` 로 시작해서 줄 먹임 (U+000A) 이나 캐리지 반환 (U+000D) 까지 계속됩니다. 여러 줄 주석은 `/*` 로 시작해서 `*/` 로 끝납니다. 여러 줄 주석의 중첩도 허용하지만, 주석 표시는 반드시 짝이 맞아야 합니다.

[Markup Formatting Reference](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref/index.html) 에서 설명한 것처럼, 주석에 추가 양식 및 마크-업 (markup) 을 담을 수도 있습니다.

> GRAMMAR OF WHITESPACE 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID411)

### Identifiers (식별자)

_식별자 (identifiers)_ 는 A 에서 Z 까지의 대소문자, 밑줄 (`_`), 다국어 기본 평면 (Basic Multilingual Plane)[^BMP] 안의 비-조합형 영숫자 유니코드 문자 [^noncombining-alphanumeric], 또는 다국어 기본 평면 밖이면서 사용자 영역 (Private Use Area)[^PUA] 안은 아닌 문자로 시작합니다. 첫 번째 문자 뒤엔, 숫자 (digits)[^digits] 및 조합형 유니코드 문자도 허용합니다.

밑줄로 시작한 식별자는, 선언을 `public` 접근-수준 수정자로 한 경우라도, 내부 (internal) 라고 취급합니다. 이런 협약은, 어떠한 제한이 선언이 공용 (public) 이길 요구할지라도, 클라이언트가 반드시 상호 작용 또는 의존을 안해야 하는 API 를 프레임웍 제작자가 표시하게 해줍니다. 이에 더하여, 두 개의 밑줄로 시작한 식별자는 스위프트 컴파일러와 표준 라이브러리 용으로 예약되어 있습니다.

예약어를 식별자로 사용하려면, 그 앞뒤로 역따옴표 (`` ` ``)[^backticks] 을 붙입니다. 예를 들어, `class` 는 유효한 식별자가 아니지만, `` `class` `` 는 유효합니다. 역따옴표 (자체는) 식별자로 고려하지 않습니다; `` `x` `` 와 `x` 의 의미는 똑같습니다.

클로저 안에 명시적 매개 변수 이름이 없으면, 매개 변수에 암시적으로 `$0`, `$1`, `$2`, 등등의 이름을 붙입니다. 이 이름들은 클로저 영역 안에선 유효한 식별자입니다.

속성 포장의 내민 값을 가진 속성이면 컴파일러가 달러 기호 (`$`) 로 시작하는 식별자를 통합합니다.[^property-wrapper-projection] 이 식별자와 상호 작용하는 코드를 만들 순 있지만, 이 접두사의 식별자를 (직접) 선언할 순 없습니다. 더 많은 정보는, [Attributes (특성)]({% link docs/swift-books/swift-programming-language/attributes.md %}) 장의 [propertyWrapper (속성 포장)]({% link docs/swift-books/swift-programming-language/attributes.md %}#propertywrapper-속성-포장) 부분을 보도록 합니다.

> GRAMMAR OF AN IDENTIFIER 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID412)

### Keywords and Punctuation (키워드 및 문장 부호)

다음 키워드들은 예약되어 있어서, 위의 [Idenfifiers (식별자)](#idenfifiers-식별자) 에서 설명한 것처럼, 역따옴표로 벗어나지 (escaped)[^escaped] 않는 한, 식별자로 사용할 수 없습니다. `inout` 과, `var`, 및 `let` 이외의 키워드는 역따옴표로 벗어나지 않고도 함수 선언이나 함수 호출 안에서 매개 변수 이름으로 사용할 수 있습니다. 멤버 이름이 키워드와 똑같을 땐, 그 멤버 참조가 역따옴표로 벗어날 필요는 없지만, 멤버 참조와 키워드 사용이 모호할 땐 예외입니다-예를 들어, `self` 와, `Type`, 및 `Protocol` 은 명시적 멤버 표현식에선 특수한 의미가 있으므로, 그 상황에선 반드시시 역따옴표로 벗어나게 해야 합니다.

* 선언에서 사용하는 키워드: `associatedtype`, `class`, `deinit`, `enum`, `extension`, `fileprivate`, `func`, `import`, `init`, `inout`, `internal`, `let`, `open`, `operator`, `private`, `protocol`, `public`, `rethrows`, `static`, `struct`, `subscript`, `typealias`, 및 `var`.
* 구문에서 사용하는 키워드: `break`, `case`, `continue`, `default`, `defer`, `do`, `else`, `fallthrough`, `for`, `guard`, `if`, `in`, `repeat`, `return`, `switch`, `where`, 및 `while`.
* 표현식과 타입에서 사용하는 키워드: `as`, `Any`, `catch`, `false`, `is`, `nil`, `super`, `self`, `Self`, `throw`, `throws`, `true`, 및 `try`.
* 패턴 (pattern) 에서 사용하는 키워드 : `_`.
* 번호 기호 (`#`) 로 시작하는 키워드: `#available`, `#colorLiteral`, `#column`, `#else`, `#elseif`, `#endif`, `#error`, `#file`, `#filePath`, `#fileLiteral`, `#function`, `#if`, `#imageLiteral`, `#line`, `#selector`, `#sourceLocation`, 및 `#warning`.
* 특별한 상황을 위해 예약한 키워드: `associativity`, `convenience`, `dynamic`, `didSet`, `final`, `get`, `infix`, `indirect`, `lazy`, `left`, `mutating`, `none`, `nonmutating`, `optional`, `override`, `postfix`, `precedence`, `prefix`, `Protocol`, `required`, `right`, `set`, `Type`, `unowned`, `weak`, 및 `willSet`. 문법 안에서 나타난 상황 밖에선, 식별자로 사용할 수 있습니다.

다음의 낱말은 문장 부호로 예약되어 있어서 사용자 정의 연산자로 사용할 수 없습니다: `(`, `)`, `{`, `}`, `[`, `]`, `.`, `,`, `:`, `;`, `=`, `@`, `#`, (접두사 연산자로써의) `&`, `->`, `` ` ``, `?`, 및 (접미사 연산자로써의)`!`.

### Literals (글자 값)

_글자 값 (literal)_ 은, 수치 값이나 문자열 같이, 타입의 값을 소스 코드에 나타낸 겁니다.

다음은 글자 값의 예입니다:

```swift
42               // 정수 글자 값
3.14159          // 부동-소수점 글자 값
"Hello, world!"  // 문자열 글자 값
true             // 불리언 글자 값
```

글자 값 그 자체엔 타입이 없습니다. 그 대신, 글자 값 구문엔 무한한 정밀도가 있는 것처럼 해석하여 스위프트의 타입 추론 장치가 글자 값의 타입 추론을 시도 합니다. 예를 들어, `let x: Int8 = 42` 라는 선언에선, 스위프트가 명시적 타입 보조 설명[^type-annotations] (`: Int8`) 을 사용하여 정수 글자 값 `42` 의 타입이 `Int8` 이라고 추론합니다. 사용할 적합한 타입 정보가 없으면, 글자 값 타입은 스위프트 표준 라이브러리에 정의한 기본 글자 값 타입 중 하나라고 스위프트가 추론합니다. 정수 글자 값이면 기본 타입이 `Int` 고, 부동-소수점 글자 값이면 `Double`, 문자열 글자 값이면 `String`, 그리고 불리언 글자 값이면 `Bool` 입니다. 예를 들어, `let str = "Hello, world"` 라는 선언에선, 문자열 글자 값 `"Hello, world"` 의 기본 추론 타입이 `String` 입니다.

글자 값에 타입 보조 설명을 지정할 때의, 보조 설명 타입은 반드시 그 글자 값으로 인스턴스화 할 수 있는 타입이어야 합니다. 즉, 타입은 반드시 다음의 스위프트 표준 라이브러리 프로토콜 중 하나를 준수해야 합니다: 정수 글자 값은 `ExpressibleByIntegerLiteral`, 부동-소수점 글자 값은 `ExpressibleByFloatLiteral`, 문자열 글자 값은 `ExpressibleByStringLiteral`, 불리언 글자 값은 `ExpressibleByBooleanLiteral`, 단일 유니코드 크기 값만 담는 문자열 글자 값은 `ExpressibleByUnicodeScalarLiteral`, 단일한 확장 자소 덩어리 (extended grapheme cluster) 만 담는 문자열 글자 값은 `ExpressibleByExtendedGraphemeClusterLiteral` 를 준수해야 합니다. 예를 들어, `Int8` 은 `ExpressibleByIntegerLiteral` 프로토콜을 준수하며, 따라서 `let x: Int8 = 42` 라는 선언에 있는 정수 글자 값 `42` 의 타입 보조 설명으로 사용할 수 있습니다.

> GRAMMAR OF LITERAL 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID414)

#### Integer Literals (정수 글자 값)

_정수 글자 값 (integer literals)_ 은 특정한 정밀도가 없는 정수 값을 나타냅니다. 기본적으로, 정수 글자 값은 10진수로 표현하며; 대안으로 접두사를 사용하여 밑수 (base) 를 지정할 수 있습니다. 2진 글자 값은 `0b`, 8진 (octal) 글자 값은 `0o`, 그리고 16진 (hexadecimal) 글자 값은 `0x` 로 시작합니다.

10진 글자 값은 `0` 에서 `9` 까지의 숫자를 담습니다. 2진 글자 값은 `0` 과 `1` 을 담고, 8진 글자 값은 `0` 에서 `7` 까지를 담으며, 16진 글자 값' 은 `0` 에서 `9` 뿐만 아니라 `A` 에서 `F` 까지의 대문자 또는 소문자를 담습니다.

음수 글자 값을 표현하려면, `-42` 처럼, 정수 글자 값 앞에 빼기 기호 (`-`) 를 두면 됩니다.

가독성을 위해 숫자 사이에 밑줄 (`_`) 을 둘 수 있지만, (이 값은) 무시하므로 글자 값에는 영향을 주지 않습니다. 정수 글자 값은 `0` 으로 시작할 수 있는데, (이 값) 역시 무시하므로 글자 값의 밑수나 값엔 영향을 주지 않습니다.

따로 지정하지 않는 한, 정수 글자 값의 기본 추론 타입은 스위프트 표준 라이브러리 타입 `Int` 입니다. 스위프트 표준 라이브러리는, [Integers (정수)]({% link docs/swift-books/swift-programming-language/the-basics.md %}#integers-정수) 에서 설명한 것처럼, 다양한 크기의 부호 있는 정수와 부호 없는 정수도 정의합니다.

> GRAMMAR OF AN INTEGER LITERAL 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID414)

#### Floating-Point Literals (부동-소수점 글자 값)

_부동-소수점 글자 값 (floating-point literals)_ 은 특정한 정밀도가 없는 부동-소수점 값을 나타냅니다.

기본적으로, (접두사가 없는) 10진수로 부동-소수점 글자 값을 표현하지만, (`0x` 접두사가 있는) 16진수로 표현할 수도 있습니다.

10진 부동-소수점 글자 값은 일렬로 나열된 10진 숫자들과 그 뒤의 10진 분수 부분 (fraction) 혹은, 10진 지수 부분 (exponent), 또는 그 둘 다로 구성됩니다. 10진 분수 부분은 소수점 (`.`) 및 그 뒤의 일렬로 나열된 10진 숫자들로 구성됩니다. 지수 부분은 대문자 또는 소문자 `e` 접두사 및 그 뒤의 일렬로 나열된 10진 숫자들로 구성되며 `e` 앞의 값을 10의 몇 제곱해야 하는지 지시합니다. 예를 들어, `1.25e2` 는 1.25 x 10<sup>2</sup> 를 나타내며, `125.0` 라고 평가합니다. 이와 비슷하게, `1.25e-2` 는 1.25 x 10<sup>-2</sup> 를 나타내며, `0.0125` 라고 평가합니다.

16진 부동-소수점 글자 값은 `0x` 접두사와, 그 뒤에 옵션으로 16진 분수 부분 및, 그 뒤의 16진 지수 부분으로 구성됩니다. 16진 분수 부분은 소수점 및 그 뒤의 일렬로 나열된 16진 숫자들로 구성됩니다. 지수 부분은 대문자 또는 소문자 `p` 접두사 및 그 뒤의 일렬로 나열된 10진 숫자들로 구성되며 `p` 앞의 값을 2의 몇 제곱해야 하는지 지시합니다. 예를 들어, `0xFp2` 는 15 x 2<sup>2</sup> 를 나타내며, `60` 이라고 평가합니다. 이와 비슷하게, `0xFp-2` 는 15 x 2<sup>-2</sup> 를 나타내며, `3.75` 라고 평가합니다.

음수 부동-소수점 글자 값을 표현하려면, `-42.5` 처럼, 부동-소수점 글자 값 앞에 빼기 기호 (`-`) 를 두면 됩니다.

가독성을 위해 숫자 사이에 밑줄 (`_`) 을 둘 수 있지만, (이 값은) 무시므로 글자 값에는 영향을 주지 않습니다. 부동-소수점 글자 값은 `0` 으로 시작할 수 있는데, (이 값) 역시 무시하므로 글자 값의 밑수나 값엔 영향을 주지 않습니다.

따로 지정하지 않는 한, 부동-소수점 글자 값의 기본 추론 타입은 스위프트 표준 라이브리러 타입 `Double` 인데, 이는 64-비트 부동-소수점 수를 나타냅니다. 스위프트 표준 라이브러리는 `Float` 타입도 정의하는데, 이는 32-비트 부동-소수점 수를 나타냅니다.

> GRAMMAR OF AN FLOATING-POINT LITERAL 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID414)

#### String Literals (문자열 글자 값)

문자열 글자 값은 일렬로 나열된 문자들을 따옴표로 둘러싼 겁니다. 한-줄짜리 문자열 글자 값은 큰 따옴표로 둘러싸며 형식은 다음과 같습니다:

\"`characters-문자들`\"

문자열 글자 값은 벗어나지 않는 큰 따옴표 (`"`)[^unescaped] 나, 벗어나지 않는 역 빗금 (backslash; `\`), 캐리지 반환 (carriage return; `\r`), 또는 줄 먹임 (line feed; `\n`) 을 담을 수 없습니다.

여러 줄짜리 문자열 글자 값은 세 개의 큰 따옴표로 둘러싸며 형식은 다음과 같습니다:

\"\"\"<br />
`characters-문자들`<br />
\"\"\"

한-줄짜리 문자열 글자 값과 달리, 여러 줄짜리 문자열 글자 값은 벗어나지 않는 큰 따옴표 (`"`), 캐리지 반환 (`\r`), 및 줄 먹임 (`\n`) 을 담을 수 있습니다. 세 개의 벗어나지 않는 큰 따옴표를 서로 나란히 담을 순 없습니다.[^three-unescaped-double-quotation-marks]

여러 줄짜리 문자열 글자 값을 시작하는 `"""` 뒤의 줄 끊음 (line break; `\n`)[^line-break] 은 문자열의 일부가 아닙니다. 글자 값을 끝내는 `"""` 앞의 줄 끊음도 문자열의 일부가 아닙니다. 여러 줄짜리 문자열 글자 값이 줄 먹임으로 시작하거나 끝나려면, 자신의 첫 번째 또는 마지막 줄에 빈 줄을 작성합니다.[^begins-or-ends]

여러 줄짜리 문자열 글자 값은 공백 (spaces) 과 탭 (tabs) 을 어떻게 조합하든 들여쓰기 할 수 있으며; 이 들여쓰기는 문자열에 포함되지 않습니다. 글자 값을 끝내는 `"""` 가 들여쓰기를 결정하는데: 글자 값 안의 모든 비어 있지 않은 줄은 반드시 닫는 `"""` 앞에 나타낸 것과 정확하게 똑같은 들여쓰기로 시작해야 하며; 탭과 공백이 서로 변환되진 않습니다. 그 들여쓰기 뒤에 추가로 공백과 탭을 포함할 수 있으며; 이러한 공백과 탭은 문자열에 나타납니다.

여러 줄짜리 문자열 글자 값 안에 있는 줄 끊음은 줄 먹임 문자를 사용하도록 정규화합니다.[^line-break-to-line-feed] 소스 파일에 캐리지 반환과 줄 먹임이 섞여 있는 경우라도, 문자열 안의 모든 줄 끊음은 똑같을 것입니다.

여러 줄짜리 문자열 글자 값에서, 줄 끝에 역 빗금 (`\`) 을 쓰면 문자열에서 그 줄을 끊는 건 생략합니다. 역 빗금과 줄 끊음 사이의 어떤 공백이든 역시 생략합니다. 이 구문을 사용하면, 결과 문자열 값을 바꾸지 않고도, 소스 코드 안의 여러 줄짜리 문자열 글자 값을 '직접 줄 바꿈 (hard wrap)'[^hard-wrap] 할 수 있습니다.

다음의 벗어난 확장열[^escape-sequences] 을 사용하면 한-줄 및 여러 줄 형식의 문자열 글자 값 둘 다 특수 문자를 포함할 수 있습니다:

* 널 문자 (null character; `\0`)
* 역 빗금 (backslash; `\\`)
* 가로 탭 (horizontal tab; `\t`)
* 줄 먹임 (line feed; `\n`)
* 캐리지 반환 (carrige return; `\r`)
* 큰 따옴표 (double quotation mark; `\"`)
* 작은 따옴표 (single quotation mark; `\'`)
* 유니코드 크기 값 (unicode scalar; `\u{n}`), 여기서 _n_ 은 한 개에서 여덟 개까지의 숫자로 된 16진수입니다.

표현식 값을 문자열 글자 값에 집어 넣으려면 괄호 안에 표현식을 두고 앞에 역 빗금 (`\`) 을 붙이면 됩니다. 끼워 넣은 표현식[^interpolation] 은 문자열 글자 값을 담을 수 있지만, 벗어나지 않는 역 빗금이나, 캐리지 반환, 또는 줄 먹임을 담을 순 없습니다.

예를 들어, 다음의 문자열 글자 값은 모두 똑같은 값을 가집니다:

```swift
"1 2 3"
"1 2 \("3")"
"1 2 \(3)"
"1 2 \(1 + 2)"
let x = 3; "1 2 \(x)"
```

확장 구분자로 구분한 문자열은 일렬로 나열한 문자를 따옴표로 둘러싼 후 하나 이상의 번호 기호 (`#`) 로 균형을 맞춘 집합[^balanced-set] 입니다. 확장 구분자로 구분한 문자열 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;\#\"`characters-문자들`\"\#

&nbsp;&nbsp;&nbsp;&nbsp;\#\"\"\"<br />
&nbsp;&nbsp;&nbsp;&nbsp;`characters-문자들)`<br />
&nbsp;&nbsp;&nbsp;&nbsp;\"\"\"\#

확장 구분자로 구분한 문자열 안의 특수 문자는 결과 문자열 안에서 특수 문자라기 보단 보통의 문자 처럼 나타납니다. 확장 구분자를 사용하면 문자열 끼워 넣기를 생성하거나, 벗어난 문자열을 시작하는, 또는 문자열을 종결하는 것 같이, 보통이라면 특수 효과를 가질 문자로도 문자열을 생성할 수 있습니다.

다음 예제는 문자열 글자 값과 확장 구분자로 구분한 문자열이 서로 같은 문자열 값을 생성하는 걸 보여줍니다:

```swift
let string = #"\(x) \ " \u{2603}"#
let escaped = "\\(x) \\ \" \\u{2603}"
print(string)
// "\(x) \ " \u{2603}" 를 인쇄함
print(string == escaped)
// "true" 를 인쇄함
```

하나 이상의 번호 기호를 써서 확장 구분자로 구분한 문자열을 만든다면, 번호 기호 사이에 공백을 두면 안됩니다:[^more-than-one-number]

```swift
print(###"Line 1\###nLine 2"###) // 괜찮음
print(# # #"Line 1\# # #nLine 2"# # #) // 에러
```

확장 구분자로 생성한 여러 줄짜리 문자열 글자 값의 들여쓰기는 표준적인 여러 줄짜리 문자열 글자 값과 똑같습니다.

문자열 글자 값의 기본 추론 타입은 `String` 입니다. `String` 타입에 대한 더 많은 정보는, [Strings and Characters (문자열과 문자)]({% link docs/swift-books/swift-programming-language/strings-and-characters.md %}) 장과 [String](https://developer.apple.com/documentation/swift/string)[^developer-string] 항목을 보도록 합니다.

`+` 연산자로 이어붙인 문자열 글자 값은 컴파일 시간에 이어붙습니다. 예를 들어, 아래 예제의 `textA` 와 `textB` 값은 완전히 똑같습니다 (identical)-실행 시간에 이어붙이기를 하진 않습니다.

```swift
let textA = "Hello " + "world"
let textB = "Hello world"
```

> GRAMMAR OF A STRING LITERAL 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID414)

#### Regular Expression Literals (정규 표현식 글자 값)

정규 표현식 글자 값[^regular-expression] 은 일렬로 나열한 문자를 빗금 (`/`) 으로 둘러싼 것으로 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;\/`regular expression-정규 표현식`\/

정규 표현식 글자 값은 벗어나지 않은 탭이나 공백[^unescaped-tab]으로 시작해선 안되고, 벗어나지 않은 빗금 (`/`) 이나, 캐리지 반환[^carriage-return], 또는 줄 먹임[^line-feed] 문자를 담을 수도 없습니다. 

정규 표현식 안에서의, 역 빗금은, 문자열 글자 값 안에서의 벗어난 문자 같은 것 만이 아니라, 그 정규 표현식의 일부로 이해합니다. 이는 뒤에 오는 특수 문자를 글자 그대로 해석하라거나, 뒤에 오는 특수하지 않은 문자를 특수한 방식으로 해석하라고 지시합니다. 예를 들어, `/\(/` 는 단일한 왼쪽 괄호와 맞고 `/\d/` 는 한 자리 숫자와 맞습니다.

정규 표현식 글자 값을 확장 구분자로 구분한 것은 일렬로 나열한 문자를 빗금 (`/`) 으로 둘러싸고 하나 이상의 번호 기호 (`#`) 로 균형을 맞춘 집합[^balanced-set] 입니다. 정규 표현식 글자 값을 확장 구분자로 구분한 것의 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;\#\/`regular expression-정규 표현식`\/\#

&nbsp;&nbsp;&nbsp;&nbsp;\#\/
&nbsp;&nbsp;&nbsp;&nbsp;`regular expression-정규 표현식`
&nbsp;&nbsp;&nbsp;&nbsp;\/\#

정규 표현식 글자 값에 확장 구분자를 사용하면 벗어나지 않은 공백이나 탭으로 시작할 수도 있고, 벗어나지 않은 빗금 (`/`) 을 담을 수도 있으며, 여러 줄에 걸쳐 있을 수도 있습니다.[^uses-extended-delimiters] 여러 줄짜리 정규 표현식 글자 값에서, 여는 구분자는 반드시 줄 끝에 있어야 하고, 닫는 구분자는 그 자신만의 줄에 있어야 합니다.[^opening-and-closing-delimiter] 여러 줄짜리 정규 표현식 글자 값 안에서는, 확장 정규 표현식 구문을 기본적으로 쓸 수 있는데-특히, 공백은 무시하고 주석은 허용합니다.

정규 표현식 글자 값을 확장 구분자로 구분하는데 하나 이상의 번호 기호를 쓰면, 번호 기호 사이에는 공백을 두지 않습니다: 

```swift
let regex1 = ##/abc/##      // 괜찮음
let regex2 = # #/abc/# #    // 에러
```

빈 정규 표현식 글자 값을 만들 필요가 있다면, 반드시 확장 구분자 구문을 써야 합니다.

> GRAMMAR OF A REGULAR EXPRESSION LITERAL 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID414)

### Operators (연산자)

스위프트 표준 라이브러리에서 정의한 다수 연산자들의 사용법, 중 많은 것들은 [Basic Operators (기초 연산자)]({% link docs/swift-books/swift-programming-language/basic-operators.md %}) 와 [Advanced Operators (고급 연산자)]({% link docs/swift-books/swift-programming-language/advanced-operators.md %}) 에서 논의합니다. 현재 절에선 사용자 연산자를 정의할 수 있는 문자가 어떤 것인지를 설명합니다.

사용자 정의 연산자는  `/` 나, `=`, `-`, `+`, `!`, `*`, `%`, `<`, `>`, `&`, `|`, `^`, `?` 또는 `~` 라는 아스키 (ASCII) 문자 중 하나, 혹은 아래 문법에서 정의한 유니코드 문자 중 하나로 시작할 수 있습니다 (이는, 유니 코드 중에서, _수학 연산자 (Mathematical Operators)_, _잡다한 기호 (Miscellaneous Symbols)_, 및 _딩뱃 (Dingbats)_[^dingbats] 유니코드 블럭 안의 문자를 포함합니다). 첫 번째 문자 뒤엔, 조합형 유니코드 문자도 허용합니다.

점 (`.`) 으로 시작하는 사용자 연산자도 정의할 수 있습니다. 이러한 연산자는 점을 추가로 담을 수도 있습니다. 예를 들어, `.+.` 은 단일 연산자로 취급합니다. 연산자가 점으로 시작하지 않으면, 다른 어디서도 점을 담을 수 없습니다. 예를 들어, `+.+` 는 `+` 연산자 뒤에 `.+` 연산자가 있는 걸로 취급합니다.

물음표 (`?`) 가 있는 사용자 연산자를 정의할 순 있지만, 단일 물음표 문자만으로 구성할 순 없습니다.[^optional] 추가적으로, 연산자에 느낌표 (`!`) 가 있을 순 있지만, 접미사 연산자를 물음표나 느낌표로 시작할 순 없습니다.

> 낱말 `=`, `->`, `//`, `/*`, `*/`, `.` 와, 접두사 연산자 `<`, `&`, `?`, 중위 연산자 `?`, 및 접미사 연산자 `>`, `!`, `?` 는 예약되어 있습니다. 이 낱말들은 중복 정의할 수도 없고, 사용자 연산자로 사용할 수도 없습니다.

연산자 주위의 공백을 사용하여 연산자가 접두사 연산자나, 접미사 연산자, 또는 이항 연산자인지를 결정합니다. 이 동작의 규칙은 다음과 같습니다:

* 연산자 양쪽에 공백이 있거나 어느 쪽에도 없으면, 중위 연산자로 취급합니다. 한 예로, `a+++b` 와 `a +++ b` 안의 `+++` 연산자는 중위 연산자로 취급합니다.
* 연산자 왼쪽에만 공백이 있으면, 단항 접두사 연산자로 취급합니다. 한 예로, `a +++b` 안의 `+++` 연산자는 단항 접두사 연산자로 취급합니다.
* 연산자 오른쪽에만 공백이 있으면, 단항 접미사 연산자로 취급합니다. 한 예로, `a+++ b` 안의 `+++` 연산자는 단항 접미사 연산자로 취급합니다.
* 연산자 왼쪽에 공백이 없지만 바로 뒤에 점 (`.`) 이 있으면, 단항 접미사 연산자로 취급합니다. 한 예로, `a+++.b` 안의 `+++` 연산자는 단항 접미사 연산자 (`a +++ .b` 라기 보단 `a+++ .b` 라고) 취급합니다.

이러한 규칙용으로는, 연산자 앞의 `(`, `[`, `{` 문자와, 연산자 뒤의 `)`, `]`, `}` 문자, 및 `,`, `;`, `:` 문자들도 공백으로 고려합니다.

위 규칙엔 한 가지 주의할 점이 있습니다. 이미 정의된 `!` 및 `?` 연산자 왼쪽에 공백이 없으면, 오른쪽 공백과 상관없이, 접미사 연산자로 취급한다는 것입니다. `?` 을 옵셔널-사슬 연산자로 사용하려면, 반드시 왼쪽엔 공백이 없어야 합니다. 삼항 조건 (`? :`) 연산자로 사용하려면, 반드시 양쪽에 공백이 있어야 합니다.

특정한 구조에선, 맨 앞이 `<` 나 `>` 인 연산자가 두 개 이상의 낱말로 쪼개질 수 있습니다. 나머지 부분도 똑같은 식으로 취급하여 또 다시 쪼깨질 수 있습니다. 그 결과, `Dictionary<String, Array<Int>>` 같은 구조의 닫는 `>` 문자 사이에 공백을 추가해서 헷갈리지 않게 할 필요가 없습니다. 이 예제에선, 닫는 `>` 문자를 단일 낱말로 취급하여 비트 이동 `>>` 연산자로 잘못 해석할 일이 없습니다.[^misinterprete]

새로운, 사용자 연산자를 정의하는 방법을 배우려면, [Custom Operators (사용자 정의 연산자)]({% link docs/swift-books/swift-programming-language/advanced-operators.md %}#custom-operators-사용자-정의-연산자) 부분과 [Operator Declaration (연산자 선언)]({% link docs/swift-books/swift-programming-language/declarations.md %}#operator-declaration-연산자-선언) 부분을 보도록 합니다. 기존 연산자를 중복 정의하는 방법을 배우려면, [Operator Methods (연산자 메소드)]({% link docs/swift-books/swift-programming-language/closures.md %}#operator-methods-연산자-메소드) 부분을 보도록 합니다.

### 다음 장

[Types (타입) >]({% link docs/swift-books/swift-programming-language/types.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [Lexical Structure](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html) 에서 볼 수 있습니다.

[^token]: '낱말 (token)' 은 프로그래밍 언어에서 '의미를 가지는 최소 단위' 를 뜻합니다. 여기서는 'token' 을 '낱말' 이라고 옮겼는데, 스위프트에서는 'token' 을 'lexical token (lexeme-어휘소와 비슷한 개념)' 의 의미로 사용하고 있는 것 같습니다. 굳이 옮기자면 '어휘소' 나, '형태소' 라고 할 수도 있겠으나, 프로그래밍을 하는데 이 정도까지 알아야 하는 것은 아니므로, 앞으로 'token' 을 계속 '낱말' 이라고 옮기겠습니다. 'token' 에 대한 더 자세한 개념은, 위키피디아의 [Lexical analysis](https://en.wikipedia.org/wiki/Lexical_analysis) 항목 안의 [Token](https://en.wikipedia.org/wiki/Lexical_analysis#Token) 부분을 보도록 합니다.

[^maximal-munch]: '최대한 잘라먹기 (maximal munch)' 라는 용어는, [Jay Two](https://j2doll.tistory.com) 님의 [최대한 잘라먹기(Maximal Munch)와 컴파일러(Compiler)](https://j2doll.tistory.com/109) 라는 블로그 글이, 의미를 가장 잘 전달하고 있다고 생각하여, 따르기로 합니다. 'longest match' 와 'maximal munch' 에 대한 더 자세한 정보는, 위피키디아의 [Maximal munch](https://en.wikipedia.org/wiki/Maximal_munch) 항목을 보도록 합니다.

[^form-feed]: '양식 먹임 (form feed)' 이란, 화면 내용을 출력할 때, 현재 페이지를 끝내고 다음 페이지의 첫 부분부터 다시 출력하라는 것을 지시하는 문자입니다.

[^BMP]: '다국어 기본 평면 (Basic Multilingual Plane)' 이란 '유니코드 평면 (Unicode planes)' 에서 '0번 평면 (`U+0000 ~ U+FFFF`) 을 말하는 것으로, 거의 모든 근대 문자와 특수 문자를 포함합니다. '다국어 기본 평면' 에 대한 더 자세한 정보는, 위키피디아의 [Plane (Unicode)](https://en.wikipedia.org/wiki/Plane_(Unicode)) 항목과 [유니코드 평면](https://ko.wikipedia.org/wiki/유니코드_평면) 항목을 보도록 합니다.

[^noncombining-alphanumeric]: '비-조합형 영숫자 유니코드 문자 (noncombining alphanumeric Unicode character)' 에서, 비-조합형은 `é` 처럼 강세 기호 등의 문자와 조합하지 않은 문자를 의미하며, 영숫자는 수학 기호에 사용되는 그리스-라틴 문자 (Mathematical Alphanumeric Symbols) 을 의미합니다. 이에 대한 더 자세한 내용은, 위키피디아의 [Combining character](https://en.wikipedia.org/wiki/Combining_character) 항목과 [Mathematical Alphanumeric Symbols](https://en.wikipedia.org/wiki/Mathematical_Alphanumeric_Symbols) 항목을 보도록 합니다.

[^PUA]: '사용자 영역 (Private Use Area)' 은 '유니코드 평면 (Unicode planes)' 의 '15번 평면 (`F0000 ~ FFFFF`)' 과 '16번 평면 (`100000 ~ 10FFFF`)' 을 말합니다. 이에 대한 더 자세한 내용은, 위키피디아의 [Plane (Unicode)](https://en.wikipedia.org/wiki/Plane_(Unicode)) 항목과 [유니코드 평면](https://ko.wikipedia.org/wiki/유니코드_평면) 항목을 보도록 합니다.

[^digits]: 여기서의 'digits' 은 'Numerical digit' 을 의미하는 것으로, 수를 표기하기 위한 문자를 의미합니다. 더 자세한 내용은 위키피디아의 [Numerical digit](https://en.wikipedia.org/wiki/Numerical_digit) 항목과 [숫자](https://ko.wikipedia.org/wiki/숫자) 항목을 보도록 합니다.

[^backticks]: 원문에 있는 'backtics' 은 'grave accent' 라고도 하며 우리말로는 '억음 부호' 라고 합니다. 말이 어렵기 때문에, 의미 전달을 위해 '역따옴표' 라고 옮깁니다. 'grave accent' 에 대해서는 위키피디아의 [Grave accent](https://en.wikipedia.org/wiki/Grave_accent) 또는 [억음 부호](https://ko.wikipedia.org/wiki/억음_부호) 항목을 보도록 합니다.

[^property-wrapper-projection]: 본문의 의미는, 속성에 `projectedValue` 가 있으면, 스위프트가 `$<projectedValue>` 같은 구문을 자동 지원한다는 것입니다. 이에 대한 더 자세한 내용은, [Properties (속성)]({% link docs/swift-books/swift-programming-language/properties.md %}) 장의 [Projecting a Value From a Property Wrapper (속성 포장에 있는 값 내밀기)]({% link docs/swift-books/swift-programming-language/properties.md %}#projecting-a-value-from-a-property-wrapper-속성-포장에-있는-값-내밀기) 부분을 보도록 합니다. 

[^escaped]: 'escape' 는 '벗어나다' 라는 의미를 가지고 있는데, 컴퓨터 용어에서 'escape character' 라고 하면 '(본래의 의미를) 벗어나서 (다른 의미를 가지는) 문자' 라는 의미가 있습니다. 보통은 'excape character' 라고 하면 `\` 기호를 붙이는 것을 말하지만, 여기서는 `` ` `` 기호를 사용하여 '키워드' 를 마치 일반 단어처럼 사용할 수 있게 만드는 것을 의미합니다.

[^type-annotations]: '타입 보조 설명 (Type Annotations)' 에 대해서는, [The Basics (기초)]({% link docs/swift-books/swift-programming-language/the-basics.md %}) 장의 [Type Annotations (타입 보조 설명)]({% link docs/swift-books/swift-programming-language/the-basics.md %}#type-annotations-타입-보조-설명) 부분을 보도록 합니다.

[^unescaped]: 여기서 '벗어나지 않는 것' 이란, 앞서 '벗어난 (escaped) 것' 에서 설명한 것과 반대로, 문자의 본래 의미로 사용하는 것을 말합니다. 본문에서는 '문자열 글자 값' 이 '따옴표' 를 직접 담을 수 없으며, 따옴표를 문자열 글자 값에 사용하려면 `\` 를 붙여야 함을 설명하고 있습니다.

[^three-unescaped-double-quotation-marks]: 세 개의 벗어나지 않는 큰 따옴표를 서로 나란히 담을 수 없다는 건 `""""""` 처럼 큰 따옴표 여섯 개를 나란히 사용할 순 없다는 의미입니다. 이러면 `Multi-line string literal content must begin on a new line (여러 줄짜리 문자열 글자 값은 반드시 새로운 줄 문자 (\n) 로 시작해야 합니다.)` 라는 에러가 발생합니다.

[^line-break]: 이 책에서는 '줄 끊음 (line break) 과, 줄 먹임 (line feed) 및, 새 줄 (new line; 개행 문자)' 이라는 용어를 섞어 쓰는데, 셋 다 `\n` 를 의미합니다. 초창기에 컴퓨터 운영 체제마다 서로 다른 개행 문자를 사용하다 보니, 똑같은 걸 의미하는 용어가 생긴 것이 아닌가 생각합니다. 스위프트에선 '개행 문자로 줄 먹임 (line feed; LF; `\n`) 만 사용' 하는 게 표준입니다. 이에 대한 더 자세한 내용은, 위키피디아의 [Newline](https://en.wikipedia.org/wiki/Newline) 항목과 [새줄 문자](https://ko.wikipedia.org/wiki/새줄_문자) 항목을 보도록 합니다.

[^begins-or-ends]: 이 설명은 글보다 예제를 직접 보는 게 더 낫습니다. 관련 예제는, [Strings and Characters (문자열과 문자)]({% link docs/swift-books/swift-programming-language/strings-and-characters.md %}) 장의 [Multiline String Literals (여러 줄짜리 문자열 글자 값)]({% link docs/swift-books/swift-programming-language/strings-and-characters.md %}#multiline-string-literals-여러-줄짜리-문자열-글자-값) 부분에 있습니다.

[^line-break-to-line-feed]: 에전에는 프로그래머가 수동으로 줄 끊음 문자를 줄 먹임 문자로 바꿔줘야 했는데, 스위프트는 이러한 정규화 과정을 자동으로 해준다는 의미입니다.

[^hard-wrap]: 'hard wrap' 과 'sofe wrap' 은 자동 줄 바꿈과 관련된 개념으로, 실제 문자열 글자 값이 아니라, 편집기에서 문자열이 보여지는 것과 관련된 용어입니다. 직접 줄 바꿈 (hard wrap) 할 수 있다는 건, Xcode 에서 문자열 글자 값은 그대로 유지하되, 편집기에선 코드를 줄 바꿈하여 알아보기 쉽게 한다는 의미입니다. 자동 줄 바꿈에 대한 더 자세한 내용은, 위키피디아의 [Line wrap and word wrap](https://en.wikipedia.org/wiki/Line_wrap_and_word_wrap) 항목과 [자동 줄 바꿈](https://ko.wikipedia.org/wiki/자동_줄_바꿈) 항목을 보도록 합니다.

[^escape-sequences]: '벗어난 확장열 (escape sequences)' 에 대한 더 자세한 정보는, 위키피디아의 [Escape sequence](https://en.wikipedia.org/wiki/Escape_sequence) 항목과 [이스케이프 시퀀스 (확장열)](https://ko.wikipedia.org/wiki/이스케이프_시퀀스) 항목을 보도록 합니다.

[^carriage-return]: 캐리지 반환 문자는 앞 절에서 설명한 `/r` 문자를 말합니다.

[^line-feed]: 줄 먹임 문자는 앞 절에서 설명한 `/n` 문자를 말합니다.

[^balanced-set]: 여기서 말하는 '균형을 맞춘 집합' 이란, `#` 의 개수와는 상관없이, 양쪽의 `#` 개수가 똑같게 맞춘 문자 집합을 말합니다. 수학 용어인 '균형 집합 (balanced set)' 에서 파생된 용어라고 생각됩니다. 수학에서 말하는 균형 집합에 대한 정보는, 위피키디아의 [Balanced set](https://en.wikipedia.org/wiki/Balanced_set) 항목과 [균형 집합](https://ko.wikipedia.org/wiki/균형_집합) 항목을 참고하기 바립니다.

[^uses-extended-delimiters]: 본문에 나열한 것들을 하기 위해서 정규 표현식에 확장 구분자를 사용하는 것입니다.

[^opening-and-closing-delimiter]: 이는 본문의 형식에서 보돗, `#/` 과 `/#` 이 각각 그 자체로 한 줄을 차지한다는 의미입니다. 즉, 실제 정규 표현식은 `#/` 그 다음 줄부터 시작하고, `/#` 윗 줄에서 끝납니다.

[^interpolation]: 'interpolation' 은 수학에서 말하는 보간법인데, '보간' 이란 말 자체가 사이에 끼워 넣는다는 의미이므로, 수학 용어로 사용되는게 아니면 '끼워 넣기' 라고 하겠습니다. 보간법 자체에 대한 더 자세한 정보는, 위키피디아의 [Interpolation](https://en.wikipedia.org/wiki/Interpolation) 항목과 [보간법](https://ko.wikipedia.org/wiki/보간법) 항목을 보도록 합니다.

[^more-than-one-number]: 첫 번째 예제인 `print(###"Line 1\###nLine 2"###)` 는, 결과를 두 줄로 인쇄합니다. 확장 구분자로 구분한 문자열 안의 특수 문자는 보통 문자라고 인식하지만, `\###n` 처럼, 확장 구분자를 집어 넣으면 다시 특수 문자로 인식합니다.

[^developer-string]: 원문 자체가 '애플 개발자 문서' 에 대한 링크입니다. 

[^regular-expression]: '정규 표현식 (regular expression)' 은 문장 안의 검색 패턴을 지정하는 일련의 문자를 말합니다. 정규 표현식에 대한 더 자세한 정보는, 위키피디아의 [Regular expression](https://en.wikipedia.org/wiki/Regular_expression) 항목과 [정규 표현식](https://ko.wikipedia.org/wiki/정규_표현식) 항목을 참고하기 바랍니다.

[^unescaped-tab]: 즉, 정규 표현식을 공백으로 시작하면 안된다는 의미입니다.

[^dingbats]: '딩뱃 (Dingbats)' 은 조판 시에 사용하는 장식 문자나 공백을 말합니다. 이에 대한 자세한 내용은 위키피디아의 [Dingbat](https://en.wikipedia.org/wiki/Dingbat) 및 [딩뱃](https://ko.wikipedia.org/wiki/딩뱃) 항목을 보도록 합니다.

[^optional]: 단일 물음표 문자 (`?`) 는 스위프트에서 이미 '옵셔널 (optional)' 를 의미하기 때문입니다.

[^misinterprete]: `>>` 가 비트 이동 연산자라면, 연산자 양쪽이 두 개의 낱말로 쪼개질텐데, 그럴 수 없으니, 컴파일러가 `>>` 를 비트 이동 연산자로 잘못 해석할 일이 없다는 의미입니다.

