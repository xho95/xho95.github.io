---
layout: post
comments: true
title:  "Swift 5.5: Lexical Structure (어휘 구조)"
date:   2020-07-28 11:30:00 +0900
categories: Swift Language Grammar Reference Lexical-Structure
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Lexical Structure](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html) 부분[^Lexical-Structure]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Lexical Structure (어휘 구조)

스위프트의 _어휘 구조 (lexical structure)_ 는 언어에서 '유효한 낱말 (token)'[^token] 을 형성하는 일련의 문자들이 무엇인지를 설명합니다. 이 유효한 '낱말' 들이 언어에서 '가장 낮은-수준의 건축 자재' 를 형성하며 후속 장들에서 언어 나머지 부분을 설명하는데 사용합니다. '낱말' 은 '식별자 (identifier)', '키워드 (keyword)', '글자 값 (literal)', 및 '연산자 (operator)' 로 구성됩니다.

대부분의 경우, '낱말' 은, 아래 지정한 문법의 '구속 조건' 하에서, 스위프트 소스 파일의 입력 문장에서 '가능한 가장 긴 하위 문자열' 을 고려한 문자들로 발생합니다. 이 동작을 _longest match (가장 긴 일치)_ 또는 _maximal munch (최대한 잘라먹기)_[^maximal-munch] 라고 합니다.

### Whitespace and Comments (공백과 주석)

'공백 (whitespace)' 은 두 가지 용도: 소스 파일에 있는 '낱말' 구분하기 그리고 ([Operators (연산자)](#operators-연산자) 에서 보듯) 접두사, 접미사, 및 이항 연산자 구별하기 를 가지지만, 그 외의 경우 무시합니다. 다음 문자들을 '공백 문자' 로 고려합니다: 공간 (space; U+0020), 줄 먹임 (line feed; U+000A), 캐리지 반환 (carriage return; U+000D), 가로 탭 (horizontal tab; U+0009), 세로 탭 (vertical tab; U+000B), 양식 먹임 (form feed; U+000C)[^form-feed], 그리고 널 문자 (null; U+0000).

'주석 (comments)' 은 컴파일러가 '공백' 처럼 취급합니다. '한 줄짜리 주석' 은 `//` 로 시작하며 '줄 먹임 (U+000A)' 이나 '캐리지 반환 (U+000D)' 때까지 계속됩니다. '여러 줄짜리 주석' 은 `/*` 로 시작해서 `*/` 로 끝납니다. 여러 줄짜리 주석은 중첩을 허용하지만, 주석 표시는 반드시 균형이 맞아야 합니다.

주석은, [Markup Formatting Reference](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref/index.html) 에서 설명한 것처럼, '추가적인 양식'과 '마크-업 (markup)' 을 담을 수 있습니다.

> GRAMMAR OF WHITESPACE 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID411)

### Idenfifiers (식별자)

_식별자 (identifiers)_ 는 'A' 에서 'Z' 까지의 대소문자 , 밑줄 (`_`), '다국어 기본 평면 (Basic Multilingual Plane)'[^BMP] 에 있는 '조합하지 않은 영숫자 유니코드 문자 (noncombining alphanumeric Unicode character)'[^noncombining-alphanumeric], 또는 '다국어 기본 평면' 밖에 있으면서 '사용자 영역 (Private Use Area)'[^PUA] 안에 있지 않은 문자로 시작합니다. 첫 번째 문자 뒤로는, '숫자 (digits)'[^digits] 와 '조합한 (combining) 유니코드 문자' 도 올 수 있습니다.

'예약어 (reserved word)' 를 '식별자' 로 사용하려면, 그 앞뒤에 '역따옴표 (backticks; `` ` ``)'[^backticks] 을 붙입니다. 예를 들어, `class` 는 유효한 식별자가 아니지만, `` `class` `` 는 유효합니다. '역따옴표' 자체는 식별자로 고려하지 않습니다; `` `x` `` 와 `x` 는 똑같은 의미입니다.

'명시적인 매개 변수 이름' 을 가지지 않은 클로저 안에서는, `$0`, `$1`, `$2`, 등의 이름을 암시적으로 매개 변수에 붙입니다. 클로저 영역 안에서 이 이름들은 '유효한 식별자' 입니다.

컴파일러는 '속성 포장의 드러냄 (projection)'[^property-wrapper-projection] 을 가진 속성에 대하여 '달러 기호 (`$`) 로 시작하는 식별자' 를 만들어 통합합니다. 이 식별자와 상호 작용하는 코드를 만들 순 있지만, 해당 접두사를 가진 식별자를 선언할 순 없습니다. 더 많은 정보는, [Attributes (특성)]({% post_url 2020-08-14-Attributes %}) 장의 [propertyWrapper (속성 포장)]({% post_url 2020-08-14-Attributes %}#propertywrapper-속성-포장) 부분을 참고하기 바랍니다.

> GRAMMAR OF IDENTIFIER 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID412)

### Keywords and Punctuation (키워드와 문장 부호)

다음 '키워드 (keywords)' 들은 예약되어 있으며, 위의 [Idenfifiers (식별자)](#idenfifiers-식별자) 에서 설명한 것처럼, '역따옴표 (backticks)' 로 '벗어나지 (escaped)'[^escaped] 않는 한, 식별자로 사용할 수 없습니다. `inout`, `var`, 그리고 `let` 이외의 키워드는 함수 선언이나 함수 호출 안에서 역따옴표로 벗어나지 않고도 '매개 변수 이름' 으로 사용할 수 있습니다.

멤버가 키워드와 똑같은 이름을 가지고 있을 때는, 멤버에 대한 참조와 키워드의 사용 사이에 모호함이 있을 때를 제외하면, 해당 멤버에 대한 참조는 역따옴표로 벗어날 필요가 없습니다-예를 들어, `self`, `Type`, 그리고 `Protocol` 은 '명시적인 멤버 표현식' 에서 특수한 의미를 가지므로, 이들은 해당 상황에서 반드시 역따옴표로 벗어나야 합니다.

* 선언에서 사용하는 키워드: `associatedtype`, `class`, `deinit`, `enum`, `extension`, `fileprivate`, `func`, `import`, `init`, `inout`, `internal`, `let`, `open`, `operator`, `private`, `protocol`, `public`, `rethrows`, `static`, `struct`, `subscript`, `typealias`, 그리고 `var`.
* '구문 (statements)' 에서 사용하는 키워드: `break`, `case`, `continue`, `default`, `defer`, `do`, `else`, `fallthrough`, `for`, `guard`, `if`, `in`, `repeat`, `return`, `switch`, `where`, 그리고 `while`.
* 표현식과 타입에서 사용하는 키워드: `as`, `Any`, `catch`, `false`, `is`, `nil`, `super`, `self`, `Self`, `throw`, `throws`, `true`, 그리고 `try`.
* '패턴 (pattern)' 에서 사용하는 키워드 : `_`.
* '번호 기호 (`#`)' 로 시작하는 키워드: `#available`, `#colorLiteral`, `#column`, `#else`, `#elseif`, `#endif`, `#error`, `#file`, `#filePath`, `#fileLiteral`, `#function`, `#if`, `#imageLiteral`, `#line`, `#selector`, `#sourceLocation`, 그리고 `#warning`.
* 특별한 상황을 위해 예약한 키워드: `associativity`, `convenience`, `dynamic`, `didSet`, `final`, `get`, `infix`, `indirect`, `lazy`, `left`, `mutating`, `none`, `nonmutating`, `optional`, `override`, `postfix`, `precedence`, `prefix`, `Protocol`, `required`, `right`, `set`, `Type`, `unowned`, `weak`, 그리고 `willSet`. 문법상 나타나는 상황 밖에서, 이들을 식별자로 사용할 수 있습니다.

다음 '낱말' 들은 '문장 부호 (punctuation)' 로 예약되어 있으며 '사용자 정의 연산자' 로 사용할 수 없습니다: `(`, `)`, `{`, `}`, `[`, `]`, `.`, `,`, `:`, `;`, `=`, `@`, `#`, ('접두사 연산자' 인) `&`, `->`, `` ` ``, `?`, 및 ('접미사 연산자' 인)`!`.

### Literals (글자 값)

_글자 값 (literal)_ 은, '수' 또는 '문자열' 같은, 값의 '소스 코드 표현' 입니다.

다음은 '글자 값' 의 예입니다:

```swift
42               // 정수 글자 값
3.14159          // 부동-소수점 글자 값
"Hello, world!"  // 문자열 글자 값
true             // 불리언 글자 값
```

'글자 값' 은 그 자체로는 타입을 가지지 않습니다. 그 대신, '글자 값' 은 무한한 정밀도를 가진 것처럼 구문을 해석하며 스위프트의 '타입 추론 장치' 가 '글자 값' 에 대한 타입 추론을 시도합니다. 예를 들어, `let x: Int8 = 42` 라는 선언에서는, 스위프트는 (`: Int8`) 라는 '명시적인 타입 보조 설명'[^type-annotations] 을 사용하여 `42` 라는 정수 글자 값의 타입이 `Int8` 임을 추론합니다. 사용 가능한 '적합한 타입 정보' 가 없는 경우, 스위프트는 글자 값의 타입이 스위프트 표준 라이브러리에서 정의한 '기본 글자 값 타입' 중 하나라고 추론합니다. '기본 (default) 타입' 은 정수 글자 값이면 `Int`, 부동-소수점 글자 값이면 `Double`, 문자열 글자 값이면 `String`, 그리고 불리언 글자 값이면 `Bool` 입니다. 예를 들어, `let str = "Hello, world"` 라는 선언에서는, `"Hello, world"` 라는 문자열 글자 값의 '기본 추론 타입' 이 `String` 입니다.

글자 값에 대하여 '타입 보조 설명' 을 지정할 때, 보조 설명의 타입은 반드시 해당 글자 값으로 인스턴스를 만들 수 있는 타입이어야 합니다. 즉, 타입이 다음의 '스위프트 표준 라이브러리 프로토콜' 중 하나를 반드시 준수해야 합니다: 정수 글자 값이면 `ExpressibleByIntegerLiteral`, 부동-소수점 글자 값이면 `ExpressibleByFloatLiteral`, 문자열 글자 값이면 `ExpressibleByStringLiteral`, 불리언 글자 값이면 `ExpressibleByBooleanLiteral`, '단일 유니코드 크기 값' 만 담고 있는 문자열 글자 값이면 `ExpressibleByUnicodeScalarLiteral`, '단일 확장된 자소 덩어리 (single extended grapheme cluster)' 만 담고 있는 문자열 글자 값이면 `ExpressibleByExtendedGraphemeClusterLiteral` 를 준수해야 합니다. 예를 들어, `Int8` 은 `ExpressibleByIntegerLiteral` 프로토콜을 준수하며, 따라서 `let x: Int8 = 42` 라는 선언의 `42` 라는 정수 글자 값에 대한 '타입 보조 설명' 으로 사용할 수 있습니다.

> GRAMMAR OF LITERAL 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID414)

#### Integer Literals (정수 글자 값)

_정수 글자 값 (integer literals)_ 은 정밀도를 지정하지 않은 정수 값을 표현합니다. 기본적으로, 정수 글자 값은 10진수를 나타냅니다; '대체 밑수 (alternate base)' 는 접두사를 사용하여 지정할 수 있습니다. '2진 (binary) 글자 값' 은 `0b`, '8진 (octal) 글자 값' 은 `0o`, '16진 (hexadecimal) 글자 값' 은 `0x` 로 시작합니다.

'10진 글자 값' 은 `0` 에서 `9` 까지의 숫자를 담고 있습니다. '2진 글자 값' 은 `0` 과 `1` 을 담고 있고, '8진 글자 값' 은 `0` 에서 `7` 까지를 담고 있으며, '16진 글자 값' 은 `0` 에서 `9` 뿐만 아니라 `A` 에서 `F` 까지의 대문자 또는 소문자를 담고 있습니다.

'음수 글자 값' 은, `-42` 처럼, '정수 글자 값' 앞에 '빼기 기호 (`-`)' 를 붙여서 나타냅니다.

가독성을 위해 숫자 사이에 '밑줄 (`_`)' 을 넣을 수 있지만, (이 값은) 무시하며 따라서 '글자 값' 에는 영향을 주지 않습니다. 정수 글자 값은 `0` 을 선두로 하여 시작할 수 있지만, 이 역시 마찬가지로 무시하여 글자 값 또는 그 밑수에 영향을 주지 않습니다.

따로 지정하지 않으면, 정수 글자 값의 '기본 추론 타입' 은 스위프트 표준 라이브러리 타입 `Int` 입니다. 스위프트 표준 라이브러리는, [Integers (정수)]({% post_url 2016-04-24-The-Basics %}#integers-정수) 에서 설명한 것처럼, 다양한 크기의 부호 있는 정수와 부호 없는 정수도 정의합니다.

> GRAMMAR OF AN INTEGER LITERAL 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID414)

#### Floating-Point Literals (부동-소수점 글자 값)

_부동-소수점 글자 값 (floating-point literals)_ 은 정밀도를 지정하지 않은 부동-소수점 값을 나타냅니다.

기본적으로, 부동-소수점 글자 값은 (접두사 없는) 10진수를 나타내지만, (`0x` 접두사를 가지고) 16진수를 나타낼 수도 있습니다.

'10진 부동-소수점 글자 값' 은 '일련의 10진 숫자' 와 그 뒤의 '10진 분수 (fraction) 부분' 이나, '10진 지수 (exponent) 부분', 또는 둘 다로 구성됩니다. '10진 분수 부분' 은 '소수점 (`.`)' 과 그 뒤의 '일련의 10진 숫자' 로 구성됩니다. '지수' 는 대문자 또는 소문자 `e` 접두사와 `e` 앞의 값을 '10' 의 몇 제곱해야 하는지 지시하는 '일련의 10진 숫자' 들로 구성됩니다. 예를 들어, `1.25e2` 는, `125.0` 라고 평가하는, '1.25 x 10<sup>2</sup>' 을 표현합니다. 이와 비슷하게, `1.25e-2` 는, `0.0125` 라고 평가하는, '1.25 x 10<sup>-2</sup>' 을 표현합니다.

'16진 부동-소수점 글자 값' 은 `0x` 접두사와, 그 뒤의 선택 사항인 '16진 분수 부분', 및 '16진 지수 부분' 으로 구성됩니다. '16진 분수 부분' 은 소수점과 그 뒤의 '일련의 16진 숫자' 로 구성됩니다. '지수' 는 대문자 또는 소문자 `p` 접두사와 `p` 앞의 값을 '2' 의 몇 제곱해야 하는지 지시하는 '일련의 10진 숫자' 들로 구성됩니다. 예를 들어, `0xFp2` 는, `60` 이라고 평가하는, '15 x 2<sup>2</sup>' 를 표현합니다. 이와 비슷하게, `0xFp-2` 는, `3.75` 라고 평가하는, '15 x 2<sup>-2</sup>' 를 표현합니다.

'음의 부동-소수점 글자 값' 은, `-42.5` 처럼, '부동-소수점 글자 값' 앞에 '빼기 기호 (`-`)' 를 붙여서 나타냅니다.

가독성을 위해 숫자 사이에 '밑줄 (`_`)' 을 넣을 수 있지만, (이 값은) 무시하며 따라선 '글자 값' 에는 영향을 주지 않습니다. 부동-소수점 글자 값은 `0` 을 선두로 하여 시작할 수 있지만, 이 역시 마찬가지로 무시하여 글자 값 또는 그 밑수에 영향을 주지 않습니다.

따로 지정하지 않으면, 부동-소수점 글자 값의 '기본 추론 타입' 은, 64-비트 부동-소수점 수를 표현하는, 스위프트 표준 라이브리러 타입 `Double` 입니다. 스위프트 표준 라이브러리는, 32-비트 부동-소수점 수를 표현하는, `Float` 타입도 정의합니다.

> GRAMMAR OF AN FLOATING-POINT LITERAL 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID414)

#### String Literals (문자열 글자 값)

'문자열 글자 값' 은 따옴표로 둘러싼 '일련의 문자들' 을 말합니다. '한-줄짜리 문자열 글자 값' 은 '큰 따옴표' 로 둘러싸며 다음 형식을 가집니다:

\"`characters-문자들`\"

문자열 글자 값은 '벗어나지 않은 (unescaped)[^unescaped] 큰 따옴표 (`"`)', '벗어나지 않은 역 빗금 (backslash; `\`)', '캐리지 반환 (carriage return; `\r`)', 또는 '줄 먹임 (line feed; `\n`)' 을 담을 수 없습니다.

'여러 줄짜리 문자열 글자 값' 은 세 개의 큰 따옴표로 둘러싸며 다음 형식을 가집니다:

\"\"\"<br />
`characters-문자들`<br />
\"\"\"

한 줄짜리 문자열 글자 값과는 달리, 여러 줄짜리 문자열 글자 값은 '벗어나지 않은 큰 따옴표 (`"`)', '캐리지 반환 (`\r`)', 그리고 '줄 먹임 (`\n`)' 을 담을 수 있습니다. 세 개의 벗어나지 않은 큰 따옴표들을 서로 나란하게 담을 수는 없습니다.[^three-unescaped-double-quotation-marks]

'여러 줄짜리 문자열 글자 값' 을 시작하는 `"""` 뒤의 '줄 끊음 (line break; `\n`)'[^line-break] 은 문자열 일부가 아닙니다. '글자 값' 을 끝내는 `"""` 앞의 '줄 끊음' 도 문자열 일부가 아닙니다. '여러 줄짜리 문자열 글자 값' 을 '줄 먹임 (line feed)' 으로 시작하거나 끝나게 하려면, 첫 번째나 마지막 줄에 '빈 (blacnk) 줄' 을 작성합니다.[^begins-or-ends]

'여러 줄짜리 문자열 글자 값' 은 어떤 '공백 (spaces)' 과 '탭 (tabs)' 조합으로도 들여쓰기를 할 수 있는데; 이 '들여쓰기 (indentation)' 는 문자열에 포함되지 않습니다. 글자 값을 끝내는 `"""` 가 '들여쓰기' 를 결정합니다: 글자 값의 모든 '비어 있지 않은 (nonblank) 줄' 은 반드시 '닫는 `"""` 앞에 있는 것' 과 정확하게 똑같은 들여쓰기로 시작해야 합니다; '탭' 과 '공백' 사이의 변환은 없습니다. 해당 들여쓰기 후에 추가적인 공백과 탭을 포함할 수도 있는데; 이 공백과 탭은 문자열에 나타납니다.

'여러 줄짜리 문자열 글자 값' 에 있는 '줄 끊음 (line breaks)' 은 '줄 바꿈 (line feed) 문자' 를 사용하도록 '정규화 (normalized)' 합니다.[^line-break-to-line-feed] 소스 파일이 '캐리지 반환' 과 '줄 먹임' 을 섞어서 가지더라도, 문자열에 있는 모든 '줄 끊음' 은 다 똑같을 것입니다.

'여러 줄짜리 문자열 글자 값' 에서, 줄 끝에 '역 빗금 (`\`)' 을 작성하면 문자열에서 해당 '줄 끊음' 을 생략합니다. '역 빗금' 과 '줄 끊음' 사이의 어떤 공백이든 역시 생략합니다. 이 구문을 사용하면, 결과 문자열의 값을 바꾸지 않고도, '여러 줄짜리 문자열 글자 값' 을 소스 코드에서 '직접 줄 바꿈 (hard wrap)'[^hard-wrap] 할 수 있습니다.

'특수 (special) 문자' 들은 다음 '일련의 벗어나는 값 (escape sequences; 확장열)'[^escape-sequences] 을 사용하여 '한 줄짜리' 와 '여러 줄짜리' 형식 둘 다의 '문자열 글자 값' 에 포함할 수 있습니다:

* 널 문자 (null character; `\0`)
* 역 빗금 (backslash; `\\`)
* 가로 탭 (horizontal tab; `\t`)
* 줄 바꿈 (line feed; `\n`)
* 캐리지 반환 (carrige return; `\r`)
* 큰 따옴표 (double quotation mark; `\"`)
* 작은 따옴표 (single quotation mark; `\'`)
* 유니코드 크기 값 (unicode scalar; `\u{n}`), 여기서 _n_ 은 '한 자리에서 여덟 자리 숫자' 를 가진 16진수입니다.

표현식의 값은 '역 빗금 (`\`)' 뒤의 괄호에 표현식을 둠으로써 '문자열 글자 값' 에 집어 넣을 수 있습니다. '끼워 넣는 (interpolated) 표현식'[^interpolation] 은 문자열 글자 값을 담을 수는 있지만, '벗어나지 않은 역 빗금', '캐리지 반환', 또는 '줄 먹임' 을 담을 수는 없습니다.

예를 들어, 다음의 모든 '문자열 글자 값' 은 똑같은 값을 가집니다:

```swift
"1 2 3"
"1 2 \("3")"
"1 2 \(3)"
"1 2 \(1 + 2)"
let x = 3; "1 2 \(x)"
```

'확장된 구분자 (delimiters) 로 구분한 문자열' 은 하나 이상의 '번호 기호 (`#`)' 로 된 '균형 집합 (balanced set)'[^balanced-set] 과 따옴표로 둘러싼 '일련의 문자들' 입니다. '확장된 구분자로 구분한 문자열' 은 다음 형식을 가집니다:

&nbsp;&nbsp;&nbsp;&nbsp;\#\"`characters-문자들`\"\#

&nbsp;&nbsp;&nbsp;&nbsp;\#\"\"\"<br />
&nbsp;&nbsp;&nbsp;&nbsp;`characters-문자들)`<br />
&nbsp;&nbsp;&nbsp;&nbsp;\"\"\"\#

'확장된 구분자로 구분한 문자열' 안의 특수 문자는 특수 문자가 아니라 '보통 문자' 로 '결과 문자열' 에 나타납니다. '확장된 구분자' 를 사용하면 평범하게 '문자열 끼워 넣음 (interpolation)'[^interpolation] 의 발생, 일련의 벗어나기 시작, 또는 문자열 종결 같은, '특수 효과' 를 가질 문자들로 문자열을 생성할 수 있습니다.

다음 예제는 서로 '동치 (equivalent)' 인 문자열 값을 생성하는 '문자열 글자 값' 과 '확장된 구분자로 구분한 문자열' 을 보여줍니다:

```swift
let string = #"\(x) \ " \u{2603}"#
let escaped = "\\(x) \\ \" \\u{2603}"
print(string)
// "\(x) \ " \u{2603}" 를 인쇄합니다.
print(string == escaped)
// "true" 를 인쇄합니다.
```

'확장된 구분자로 구분한 문자열' 을 만들 때 하나 이상의 '번호 기호' 를 사용할 경우, '번호 기호' 사이에 공백을 두지 않습니다:[^more-than-one-number]

```swift
print(###"Line 1\###nLine 2"###) // OK
print(# # #"Line 1\# # #nLine 2"# # #) // Error
```

'확장된 구분자' 를 사용하여 생성한 '여러 줄짜리 문자열 글자 값' 은 표준적인 '여러 줄짜리 문자열 글자 값' 과 똑같은 '들여쓰기 필수 조건' 을 가집니다.

문자열 글자 값의 '기본 추론 타입' 은 `String` 입니다. `String` 타입에 대한 더 많은 정보는, [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) 및 [String](https://developer.apple.com/documentation/swift/string)[^developer-string] 을 참고하기 바랍니다.

`+` 연산자로 이어붙인 '문자열 글자 값' 은 '컴파일 시간' 에 이어붙습니다. 예를 들어, 아래 예제의 `textA` 와 `textB` 값은 완전히 똑같습니다-'실행 시간 이어붙임' 같은 건 없습니다.

```swift
let textA = "Hello " + "world"
let textB = "Hello world"
```

> GRAMMAR OF A STRING LITERAL 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID414)

### Operators (연산자)

스위프트 표준 라이브러리는 사용하기 위한 다수의 연산자를 정의하는데, 그 대부분은 [Basic Operators (기초 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 와 [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) 에서 논의합니다. 여기서는 '사용자 정의 연산자' 정의에 사용할 수 있는 문자가 어떤 것인지를 설명합니다. 

사용자 정의 연산자는 `/`, `=`, `-`, `+`, `!`, `*`, `%`, `<`, `>`, `&`, `|`, `^`, `?` 및 `~` 라는 'ASCII 문자' 중 하나, 또는 (다른 것들 중, _수학 연산자 (Mathematical Operators)_, _잡다한 기호 (Miscellaneous Symbols)_, 그리고 _딩뱃 (Dingbats)_[^dingbats] 유니코드 블럭 문자를 포함하여) 아래 문법에서 정의한 '유니코드 문자' 중 하나로 시작할 수 있습니다.  첫 번째 문자 다음에는, '조합형 유니코드 문자 (combining Unicode characters)' 도 허용합니다.

'점 (`.`)' 으로 시작하는 '사용자 정의 연산자' 도 정의할 수 있습니다. 이 연산자들은 추가적인 점을 담고 있을 수 있습니다. 예를 들어, `.+.` 은 단일 연산자로 취급합니다. 연산자가 '점' 으로 시작하지 않으면, 어디서도 점을 가질 수 없습니다. 예를 들어, `+.+` 는 `+` 연산자 뒤에 `.+` 연산자가 붙은 것으로 취급합니다.

'물음표 (`?`)' 를 가진 '사용자 정의 연산자' 를 정의할 순 있지만, '단일 물음표 문자' 만으로는 안됩니다.[^optional] 추가적으로, 연산자가 '느낌표 (`!`)' 를 가질 순 있지만, '접미사 (postfix) 연산자' 는 '음표나 느낌표로 시작할 수 없습니다.

> '낱말 (token)' 인 `=`, `->`, `//`, `/*`, `*/`, `.`, '접두사 (prefix) 연산자' 인 `<`, `&`, `?`, '중위 (infix) 연산자' 인 `?`, '접미사 (postfix) 연산자' 인 `>`, `!`, `?` 는 예약되어 있습니다. 이 낱말들은 '중복정의 (overloaded)' 할 수도 없고, 사용자 정의 연산자로 사용할 수도 없습니다.

연산자 주위의 '공백' 은 연산자가 '접두사 연산자' 나, '접미사 연산자', 또는 '이항 연산자' 인지를 결정하는 데 사용합니다. 이런 동작을 요약하면 다음 규칙과 같습니다:

* 연산자 양쪽에 공백이 있거나 어느 쪽에도 없으면, '이항 연산자' 로 취급합니다. 예를 들어, `a+++b` 와 `a +++ b` 에 있는 `+++` 연산자는 이항 연산자로 취급합니다.
* 연산자 왼쪽에만 공백이 있으면, '단항 접두사 (prefix unary) 연산자' 로 취급합니다. 예를 들어, `a +++b` 에 있는 `+++` 연산자는 단항 접두사 연산자로 취급합니다.
* 연산자 오른쪽에만 공백이 있으면, '단항 접미사 (postfix unary) 연산자' 로 취급합니다. 예를 들어, `a+++ b` 에 있는 `+++` 연산자는 단항 접미사 연산자로 취급합니다.
* 연산자 왼쪽에 공백은 없지만 바로 뒤에 '점 (`.`)' 이 있으면, '단항 접미사 연산자' 로 취급합니다. 예를 들어, `a+++.b` 에 있는 `+++` 연산자는 (`a +++ .b` 보다는 `a+++ .b` 라는) 단항 접미사 연산자로 취급합니다.

이 규칙용으로, 연산자 앞의 `(`, `[`, 및 `{` 문자, 연산자 뒤의 `)`, `]`, 및 `}` 문자, 그리고 `,`, `;`, 및 `:` 문자들도 '공백' 으로 고려합니다.

위 규칙에는 한 가지 '주의할 점 (caveat)' 이 있습니다. 미리 정의한 `!` 및 `?` 연산자 왼쪽에 공백이 없으면, 오른쪽에 공백이 있는 지에 관계없이, 접미사 연산자로 취급합니다. `?` 을 '옵셔널-연쇄 연산자' 로 사용하려면, 반드시 왼쪽에 공백이 없어야 합니다. '삼항 조건 (`? :`) 연산자' 로 사용하려면, 반드시 양쪽에 공백이 있어야 합니다.

정해진 구조에서, 선두가 `<` 또는 `>` 인 연산자는 둘 이상의 낱말로 쪼개질 수도 있습니다. 나머지도 똑같은 방식으로 취급하며 다시 쪼깨질 수 있습니다. 그 결과, `Dictionary<String, Array<Int>>` 같은 구조에서 '닫는 `>` 문자' 들 사이의 모호함을 없애고자 공백을 추가할 필요는 없습니다. 이 예제의, '닫는 `>` 문자' 들은 '단일 낱말' 로 취급하지 않아서 '비트 이동 `>>` 연산자' 로 잘못 해석될 일이 없습니다.

새로운, '사용자 정의 연산자' 를 정의하는 방법을 배우려면, [Custom Operators (사용자 정의 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#custom-operators-사용자-정의-연산자) 부분과 [Operator Declaration (연산자 선언)]({% post_url 2020-08-15-Declarations %}#operator-declaration-연산자-선언) 부분을 참고하기 바랍니다. 기존 연산자의 '중복 정의 (overload)' 방법을 배우려면, [Operator Methods (연산자 메소드)]({% post_url 2020-03-03-Closures %}#operator-methods-연산자-메소드) 부분을 참고하기 바랍니다.

### 다음 장

[Types (타입) > ]({% post_url 2020-02-20-Types %}) 

### 참고 자료

[^Lexical-Structure]: 이 글에 대한 원문은 [Lexical Structure](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^token]: 'token' 은 프로그래밍 언어에서 '의미를 가지는 최소 단위' 를 뜻합니다. 여기서는 'token' 을 '낱말' 이라고 옮겼는데, 스위프트에서는 'token' 을 'lexical token (lexeme-어휘소와 비슷한 개념)' 의 의미로 사용하고 있는 것 같습니다. 굳이 옮기자면 '어휘소' 나, '형태소' 라고 할 수도 있겠으나, 프로그래밍을 하는데 이 정도까지 알아야 하는 것은 아니므로, 앞으로 'token' 을 계속 '낱말' 이라고 옮기겠습니다. 'token' 에 대한 더 자세한 개념은, 위키피디아의 [Lexical analysis](https://en.wikipedia.org/wiki/Lexical_analysis) 항목에 있는 [Token](https://en.wikipedia.org/wiki/Lexical_analysis#Token) 부분을 참고하기 바랍니다.

[^maximal-munch]: 'maximal munch' 라는 용어를 '최대한 잘라먹기' 라고 옮긴 것은, [Jay Two](https://j2doll.tistory.com) 님의 [최대한 잘라먹기(Maximal Munch)와 컴파일러(Compiler)](https://j2doll.tistory.com/109) 라는 블로그 글을 참고한 것인데, 이 말이 의미를 가장 잘 전달하고 있다고 생각해서 저도 따르기로 했습니다. 'longest match' 와 'maximal munch' 에 대한 더 자세한 정보는, 위피키디아의 [Maximal munch](https://en.wikipedia.org/wiki/Maximal_munch) 항목을 참고하기 바랍니다.

[^form-feed]: '양식 먹임 (form feed)' 이란 화면 내용을 출력할 때, 현재 페이지를 종료하고 다음 페이지의 첫 부분부터 다시 출력하라는 것을 지시하는 문자입니다.

[^BMP]: '다국어 기본 평면 (Basic Multilingual Plane)' 이란 '유니코드 평면 (Unicode planes)' 에서 '0번 평면 (`U+0000 ~ U+FFFF`) 을 말하는 것으로, 거의 모든 근대 문자와 특수 문자를 포함합니다. '다국어 기본 평면' 에 대한 더 자세한 정보는, 위키피디아의 [Plane (Unicode)](https://en.wikipedia.org/wiki/Plane_(Unicode)) 항목과 [유니코드 평면](https://ko.wikipedia.org/wiki/유니코드_평면) 항목을 참고하기 바랍니다.

[^noncombining-alphanumeric]: '조합하지 않은 영숫자 유니코드 문자 (noncombining alphanumeric Unicode character)' 에서, '조합하지 않은 (noncombining)' 것이란 `é` 처럼 '강세' 기호 등과 '조합하지 않은 문자' 라는 의미이며, '영숫자 (alphanumeric)' 란 수학 기호로 사용되는 그리스 및 라틴 문자인 'Mathematical Alphanumeric Symbols' 을 의미합니다. 이에 대한 더 자세한 내용은, 위키피디아의 [Combining character](https://en.wikipedia.org/wiki/Combining_character) 항목과 [Mathematical Alphanumeric Symbols](https://en.wikipedia.org/wiki/Mathematical_Alphanumeric_Symbols) 항목을 참고하기 바랍니다.

[^PUA]: '사용자 영역 (Private Use Area)' 은 '유니코드 평면 (Unicode planes)' 의 '15번 평면 (`F0000 ~ FFFFF`)' 과 '16번 평면 (`100000 ~ 10FFFF`)' 을 말합니다. 이에 대한 더 자세한 내용은, 위키피디아의 [Plane (Unicode)](https://en.wikipedia.org/wiki/Plane_(Unicode)) 항목과 [유니코드 평면](https://ko.wikipedia.org/wiki/유니코드_평면) 항목을 참고하기 바랍니다.

[^digits]: 여기서의 'digits' 은 'Numerical digit' 을 의미하는 것으로, 수를 표기하기 위한 문자를 의미합니다. 더 자세한 내용은 위키피디아의 [Numerical digit](https://en.wikipedia.org/wiki/Numerical_digit) 항목과 [숫자](https://ko.wikipedia.org/wiki/숫자) 항목을 참고하기 바랍니다.

[^backticks]: 'backtics' 는 'grave accent' 라고도 하며 우리말로는 '억음 부호' 라고 합니다. 말이 어렵기 때문에, 의미 전달의 편의를 위해 '역따옴표' 라고 옮깁니다. 'grave accent' 에 대해서는 위키피디아의 [Grave accent](https://en.wikipedia.org/wiki/Grave_accent) 또는 [억음 부호](https://ko.wikipedia.org/wiki/억음_부호) 항목을 참고하기 바랍니다.

[^property-wrapper-projection]: '속성 포장의 드러냄 (property wrapper projection) 을 가진 속성' 은 '드러낸 값 (projectedValue) 를 가진 속성' 을 의미합니다. 본문의 내용은, 속성이 `projectedValue` 를 가지고 있을 때, `$<projectedValue>` 같은 구문을 지원한다는 의미입니다. 이에 대한 더 자세한 내용은, [Properties (속성)]({% post_url 2020-05-30-Properties %}) 장에 있는 [Projecting a Value From a Property Wrapper (속성 포장에 있는 값 드러내기)]({% post_url 2020-05-30-Properties %}#projecting-a-value-from-a-property-wrapper-속성-포장에-있는-값-드러내기) 부분을 참고하기 바랍니다. 

[^escaped]: 'escape' 는 '벗어나다' 라는 의미를 가지고 있는데, 컴퓨터 용어에서 'escape character' 라고 하면 '(본래의 의미를) 벗어나서 (다른 의미를 가지는) 문자' 라는 의미가 있습니다. 보통은 'excape character' 라고 하면 `\` 기호를 붙이는 것을 말하지만, 여기서는 `` ` `` 기호를 사용하여 '키워드' 를 마치 일반 단어처럼 사용할 수 있게 만드는 것을 의미합니다.

[^type-annotations]: '타입 보조 설명 (Type Annotations)' 에 대해서는, [The Basics (기초)]({% post_url 2016-04-24-The-Basics %}) 장의 [Type Annotations (타입 보조 설명)]({% post_url 2016-04-24-The-Basics %}#type-annotations-타입-보조-설명) 부분을 참고하기 바랍니다.

[^unescaped]: 여기서 '벗어나지 않은' 것이란, 앞서 '벗어난 (escaped) 것' 에서 설명한 것과 반대로, 문자의 본래 의미로 사용하는 것을 말합니다. 본문에서는 '문자열 글자 값' 이 '따옴표' 를 직접 담을 수 없으며, 따옴표를 문자열 글자 값에 사용하려면 `\` 를 붙여야 함을 설명하고 있습니다.

[^three-unescaped-double-quotation-marks]: '세 개의 벗어나지 않은 큰 따옴표들이 서로 나란하게 있을 수 없다는 것' 은 결국 `""""""` 처럼 큰 따옴표 여섯 개를 나란하게 사용할 수는 없다는 의미입니다. 이와 같이 하면 `Multi-line string literal content must begin on a new line (여러 줄짜리 문자열 글자 값은 반드시 새로운 줄 문자 (\n) 로 시작해야 합니다.)` 라는 에러가 발생합니다. 본문에서도 이어서 설명하지만 이 '새로운 줄 문자' 자체는 문자열의 일부가 아닙니다.

[^line-break]: 이 책에서는 '줄 끊음 (line break)', '줄 먹임 (line feed)' , '새 줄 (new line; 개행 문자)' 같은 용어를 섞어 쓰고 있는데, `\n` 라는 다 똑같은 의미를 가집니다. 컴퓨터 역사 초창기에 운영 체제별로 서로 다른 '개행 문자' 를 사용하다 보니, 하나의 의미에 대해 서로 다른 용어를 사용하게 된 것이 아닌가 추측됩니다. 스위프트에서는 '개행 문자' 로 '줄 먹임 (line feed; LF; `\n`)' 만 사용하는 것이 표준입니다. 이에 대한 더 자세한 내용은, 위키피디아의 [Newline](https://en.wikipedia.org/wiki/Newline) 항목과 [새줄 문자](https://ko.wikipedia.org/wiki/새줄_문자) 항목을 참고하기 바랍니다.

[^begins-or-ends]: 이 설명은 글로 읽는 것보다 예제를 직접 보는 것이 이해하기 쉽습니다. 관련 예제는, [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) 장의 [Multiline String Literals (여러 줄짜리 문자열 글자 값)]({% post_url 2016-05-29-Strings-and-Characters %}#multiline-string-literals-여러-줄짜리-문자열-글자-값) 부분에 있습니다.

[^line-break-to-line-feed]: 스위프트에서는 서로 다른 모든 '개행 문자' 를 자동으로 '줄 먹임 (line feed) 문자' 로 자동으로 표준화한다고 이해할 수 있습니다. 예전 프로그래밍에서는 운영체제별로 서로 다른 '개행 문자' 에 대한 처리를 프로그래머가 직접해줘야 했는데, 스위프트에서는 이러한 처리를 할 필요가 없어진 셈입니다.

[^hard-wrap]: 'hard wrap' 과 'sofe wrap' 은 '자동 줄 바꿈' 과 관련된 개념으로, 실제 문자열 글자 값이 아니라, '편집기 (editor)' 에서 문자열이 보여지는 것과 관련한 용어입니다. 이 책에서 '직접 줄 바꿈 (hard wrap) 할 수 있다' 는 것은, 실제 글자 값은 그대로 유지하면서, Xcode 에서 줄 바꿈을 써서 문자열을 알아보기 쉽게 코딩할 수 있다는 의미입니다. 자동 줄 바꿈에 대한 더 자세한 내용은 위키피디아의 [Line wrap and word wrap](https://en.wikipedia.org/wiki/Line_wrap_and_word_wrap) 항목과 [자동 줄 바꿈](https://ko.wikipedia.org/wiki/자동_줄_바꿈) 항목을 참고하기 바랍니다.

[^escape-sequences]: 'escape sequences' 및 '확장열' 에 대한 정보는 위키피디아의 [Escape sequence](https://en.wikipedia.org/wiki/Escape_sequence) 및 [확장열](https://ko.wikipedia.org/wiki/이스케이프_시퀀스) 항목을 참고하기 바랍니다.

[^balanced-set]: '균형 집합 (balanced set)' 은 수학 용어로 스칼라 값 `a` 에 대해 `aS ⊆ S` 를 만족하는 모든 집합 `S` 를 의미합니다. 이는 본문에서 말하는 '균형 집합' 이란, 개수 자체는 상관없이 양쪽에 있는 `#` 의 개수가 똑같기만 하면 된다는 의미로 추측됩니다. '균형 집합' 에 대한 더 자세한 정보는, 위피키디아의 [Balanced set](https://en.wikipedia.org/wiki/Balanced_set) 항목과 [균형 집합](https://ko.wikipedia.org/wiki/균형_집합) 항목을 참고하기 바립니다.

[^interpolation]: 'interpolation' 은 수학 용어로 '보간법' 이라는 의미인데, '보간' 이란 말 자체가 '사이에 끼워 넣는다' 는 의미이므로, 수학 용어로써의 엄밀함이 요구되지 않으면 '끼워 넣기' 라고 하겠습니다. '보간법 (interpolation)' 자체에 대한 더 자세한 정보는, 위키피디아의 [Interpolation](https://en.wikipedia.org/wiki/Interpolation) 항목과 [보간법](https://ko.wikipedia.org/wiki/보간법) 항목을 참고하기 바랍니다.

[^more-than-one-number]: 본문 예제에서 첫 번째 코드인 `print(###"Line 1\###nLine 2"###)` 는, 결과를 두 줄로 인쇄합니다. '확장된 구분자로 구분한 문자열' 안에 있는 특수 문자는 보통 문자로 인쇄하지만, 이를 다시 '특수 문자' 로 표현하려면, `\###n` 처럼, '확장된 구분자로 구분한 문자열' 을 특수 문자 사이에 넣으면 된다는 것을 알 수 있습니다.

[^developer-string]: 원문 자체가 '애플 개발자 문서' 에 대한 링크입니다. 

[^dingbats]: '딩뱃 (Dingbats)' 은 조판 시에 사용하는 장식 문자나 공백을 말합니다. 이에 대한 자세한 내용은 위키피디아의 [Dingbat](https://en.wikipedia.org/wiki/Dingbat) 및 [딩뱃](https://ko.wikipedia.org/wiki/딩뱃) 항목을 참고하기 바랍니다.

[^optional]: '단일 물음표 문자 (`?`)' 는 스위프트에서 '옵셔널 (optional)' 를 의미하기 때문입니다.
