---
layout: post
comments: true
title:  "Swift 5.3: Lexical Structure (어휘 구조)"
date:   2020-07-28 11:30:00 +0900
categories: Swift Language Grammar Reference Lexical-Structure
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Lexical Structure](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html) 부분[^Lexical-Structure]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## Lexical Structure (어휘 구조)

스위프트의 _어휘 구조 (lexical structure)_ 는 언어에서 유효한 '낱말 (token)'[^token] 을 형성하는 일련의 문자들이 무엇인지를 설명합니다. 이러한 유효한 '낱말' 이 언어에서 가장 낮은-수준의 건축 자재를 형성하게 되며 이어지는 장에서 언어의 나머지 부분을 설명할 때 사용됩니다. '낱말' 에는 '식별자 (identifier)', '키워드 (keyword)', '글자 값 (literal)', 및 '연산자 (operator)' 가 있습니다.

대부분의 경우에서, 낱말이라는 것은 스위프트 소스 파일에 있는 문자에서 생기는 것인데, 아래에서 지정하는 문법의 구속 조건 하에서, 입력 문장에 있는 가능한 가장 긴 하위 문자열을 고려하여 생성됩니다. 이러한 작동 방식을 _longest match (가장 긴 맞춤)_ 또는 _maximal munch (최대한 잘라먹기)_[^maximal-munch] 라고 말합니다.

### Whitespace and Comments (공백 문자와 주석)

'공백 문자 (whitespace)' 는 두 가지 용도로 사용합니다: 소스 파일에서 '낱말 (token)' 을 구분하는 것 그리고 연산자가 접두사인지 접미사인지를 결정하도록 돕는 것 ([Operators (연산자)](#operators-연산자) 를 참고할 것) 이 그것으로, 그외의 경우에는 무시됩니다. 다음의 문자들을 '공백 문자' 라고 합니다: 공간 (space; U+0020), 줄 먹임 (line feed; U+000A), 캐리지 반환 (carriage return; U+000D), 가로 탭 (horizontal tab; U+0009), 세로 탭 (vertical tab; U+000B), 양식 먹임 (form feed; U+000C)[^form-feed], 그리고 널 문자 (null; U+0000).

'주석 (comments)' 은 컴파일러에 의해 공백처럼 처리됩니다. 한 줄짜리 주석은 `//` 로 시작해서 줄 먹임 (line feed; U+000A) 또는 캐리지 반환 (carriage return; U+000D) 에 이를 때까지 계속됩니다. 여러 줄짜리 주석은 `/*` 로 시작해서 `*/` 로 끝납니다. 여러 줄짜리 주석은 중첩해도 되지만, 주석 표시는 반드시 서로 조화돼야 합니다.

주석은 추가적인 양식과 '마크-업 (markup)' 을 가질 수 있는데, 이는 [Markup Formatting Reference](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_markup_formatting_ref/index.html) 에서 설명합니다.

> GRAMMAR OF WHITESPACE 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID411)

### Idenfifiers (식별자)

_식별자 (identifiers)_ 는 대소문자 'A' 에서 'Z', 밑줄 (`_`), '다국어 기본 평면 (Basic Multilingual Plane)'[^BMP] 에 있는 '혼합되지 않은 영숫자 유니코드 문자 (noncombining alphanumeric Unicode character)'[^noncombining-alphanumeric], 또는 '다국어 기본 평면' 외부이면서 '사용자 영역 (Private Use Area)' 에는 있지 않은 문자로 시작합니다. 첫 번째 문자 뒤에는, '숫자 (digits)'[^digits] 와 '혼합된 유니코드 문자 (combining Unicode characters)'[^combining] 도 올 수 있습니다.

'예약어 (reserved word)' 를 '식별자' 로 사용하려면, 그 앞뒤에 '역따옴표 (backticks; `` ` ``)'[^backticks] 을 붙이면 됩니다. 예를 들어, `class` 는 식별자로 유효하지 않지만, ``class`` 는 유효합니다. '역따옴표' 자체는 식별자의 일부로 간주되지 않습니다; ``x`` 와 `x` 는 같은 의미를 가집니다.

명시적인 매개 변수 이름이 없는 클로저 내에서는, 매개 변수가 `$0`, `$1`, `$2`, 등등의 이름을 암시적으로 가지게 됩니다. 이 이름들은 클로저 범위 내에서는 유효한 식별자입니다.

컴파일러는 '속성 포장 돌출부 (property wrapper projection)' 를 가지는 속성에 대해서 '달러 기호 (`$`)' 로 시작하는 식별자를 만들어서 통합합니다. 이런 식별자와 상호 작용하는 코드를 만들 수는 있지만, 이 접두사를 사용해서 식별자를 선언할 수는 없습니다. 더 자세한 정보는, [Attributes (특성)](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html) 장에 있는 [propertyWrapper (프로퍼티 래퍼; 속성 포장)](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html#ID621) 부분을 참고하기 바랍니다.

> GRAMMAR OF IDENTIFIER 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID412)

### Keywords and Punctuation (키워드와 문장 부호)

다음의 '키워드 (keywords)' 들은 예약되어 있어서, 위의 [Idenfifiers (식별자)](#idenfifiers-식별자) 에서 설명한 대로, '역따옴표 (backticks)' 로 '벗어나지 (escaped)'[^escaped] 않는 한, 식별자로 사용할 수 없습니다. `inout`, `var`, 및 `let` 이외의 키워드들은 '역따옴표' 로 '벗어나지' 않고도 함수 선언 내에서나 함수 호출 내에서 매개 변수의 이름으로 사용할 수 있습니다.

멤버와 키워드가 같은 이름을 가지고 있다 하더라도, 멤버를 참조하는 것과 키워드를 사용하는 것 사이에 모호함이 없다면, 해당 멤버에 대한 참조를 '역따옴표' 로 '벗어나게' 만들어야 할 필요는 없습니다-예를 들어, `self`, `Type`, 그리고 `Protocol` 은 '명시적인 멤버 표현식 (explicit member expression)' 에서 특수한 의미를 가지고 있으므로, 해당 상황에서는 반드시 '역따옴표' 로 '벗어나게' 만들어야 합니다.

* 선언에서 사용되는 키워드: `associatedtype`, `class`, `deinit`, `enum`, `extension`, `fileprivate`, `func`, `import`, `init`, `inout`, `internal`, `let`, `open`, `operator`, `private`, `protocol`, `public`, `rethrows`, `static`, `struct`, `subscript`, `typealias`, 및 `var`.
* 구문에서 사용되는 키워드: `break`, `case`, `continue`, `default`, `defer`, `do`, `else`, `fallthrough`, `for`, `guard`, `if`, `in`, `repeat`, `return`, `switch`, `where`, 및 `while`.
* 표현식과 타입에서 사용되는 키워드: `as`, `Any`, `catch`, `false`, `is`, `nil`, `super`, `self`, `Self`, `throw`, `throws`, `true`, 및 `try`.
* '패턴 (pattern; 유형)' 에서 사용되는 키워드 : `_`.
* '번호 기호 (number sign; `#`)' 로 시작하는 키워드: `#available`, `#colorLiteral`, `#column`, `#else`, `#elseif`, `#endif`, `#error`, `#file`, `#filePath`, `#fileLiteral`, `#function`, `#if`, `#imageLiteral`, `#line`, `#selector`, `#sourceLocation`, 및 `#warning`.
* 특정한 상황을 위해 예약되어 있는 키워드: `associativity`, `convenience`, `dynamic`, `didSet`, `final`, `get`, `infix`, `indirect`, `lazy`, `left`, `mutating`, `none`, `nonmutating`, `optional`, `override`, `postfix`, `precedence`, `prefix`, `Protocol`, `required`, `right`, `set`, `Type`, `unowned`, `weak`, 및 `willSet`. 문법 상에서 나타나야할 상황 이외의 곳에서는, 이들을 식별자로 사용할 수 있습니다.

다음의 '낱말 (tokens)' 들은 '문장 부호 (punctuation)' 로 예약되어 있어서 사용자 정의 연산자로 사용할 수 없습니다: `(`, `)`, `{`, `}`, `[`, `]`, `.`, `,`, `:`, `;`, `=`, `@`, `#`, `&` (접두사 연산자), `->`, `` ` ``, `?`, 및 `!` (접미사 연산자).

### Literals (글자 값; 리터럴)

_글자 값 (literal; 리터럴)_ 은 타입의 값을 소스 코드 상에서 표현한 것으로, 수치 값 (number) 또는 문자열 (string) 등을 말합니다.

다음은 '글자 값' 에 대한 예입니다:

```swift
42               // 정수 글자 값
3.14159          // 부동-소수점 글자 값
"Hello, world!"  // 문자열 글자 값
true             // 불리언 글자 값
```

글자 값은 그 자체로는 타입을 가지지 않습니다. 대신, '글자 값' 은 무한한 정밀도를 가진 것처럼 해석되며 스위프트의 '타입 추론 장치' 가 그 '글자 값' 에 대한 타입을 추론하려고 합니다. 예를 들어, `let x: Int8 = 42` 라고 선언하면, 스위프트는 명시적인 타입 보조 설명 (`: Int8`) 을 사용하여 정수 글자 값 `42` 가 `Int8` 타입임을 추론합니다. 사용 가능한 적합한 타입 정보가 없을 경우, 스위프트는 이 글자 값의 타입이 스위프트 표준 라이브러리에서 정의한 '기본 설정 글자 타입 (default literal types)' 중의 하나라고 추론합니다. '기본 설정 타입 (default types)' 은 정수 글자 값이면 `Int`, 부동-소수점 글자 값이면 `Double`, 문자열 글자 값이면 `String`, 그리고 불리언 글자 값이면 `Bool` 입니다. 예를 들어, `let str = "Hello, world"` 라고 선언하면, 문자열 글자 값 `"Hello, world"` 의 기본 추론 타입은 `String` 입니다.

글자 값에 대한 '타입 보조 설명 (type annotation)' 을 지정할 때는, 이 보조 설명의 타입이 반드시 글자 값으로 인스턴스를 만들 수 있는 타입이어야 합니다. 즉, 타입은 반드시 다음의 '스위프트 표준 라이브러리 프로토콜 (Swift standard library protocols)' 중 하나를 준수해야 합니다: 정수 글자 값은 `ExpressibleByIntegerLiteral`, 부동-소수점 글자 값은 `ExpressibleByFloatLiteral`, 문자열 글자 값은 `ExpressibleByStringLiteral`, 불리언 글자 값은 `ExpressibleByBooleanLiteral`, 단 하나의 유니코드 크기 값만 담고 있는 문자열 글자 값은 `ExpressibleByUnicodeScalarLiteral`, 단 하나의 '확장된 자소 덩어리 (extended grapheme cluster)' 를 담고 있는 문자열 글자 값은 `ExpressibleByExtendedGraphemeClusterLiteral` 를 준수해야 합니다. 예를 들어, `Int8` 은 `ExpressibleByIntegerLiteral` 프로토콜을 준수하므로, `let x: Int8 = 42` 선언과 같이 정수 글자 값 `42` 에 대한 '타입 보조 설명' 으로 사용할 수 있습니다.

> GRAMMAR OF LITERAL 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID414)

#### Integer Literals (정수 글자 값; 정수 리터럴)

_정수 글자 값 (integer literals)_ 은 정밀도를 지정하지 않은 정수 값을 나타냅니다. 정수 글자 값은, 기본적으로, 10진수로 표현합니다; 밑수 (base) 가 다른 경우 접두사를 사용하여 지정할 수 있습니다. '2진 글자 값 (binary literals)' 은 `0b` 로 시작하고, '8-진 글자 값 (octal literals)' 은 `0o` 로 시작하며, '16진 글자 값 (hexadecimal)' 은 `0x` 로 시작합니다.

'10진 글자 값' 은 `0` 에서 `9` 까지의 숫자를 가지고 있습니다. '2진 글자 값' 은 `0` 과 `1` 을 가지고 있고, '8진 글자 값' 은 `0` 에서 `7` 까지를 가지고 있으며, '16진 글자 값' 은 `0` 에서 `9` 까지에다가 `A` 부터 `F` 까지의 대- 또는 소문자를 가지고 있습니다.

'음수 글자 값' 은, `-42` 에서 처럼, '정수 글자 값' 에 '빼기 기호 (`-`)' 를 앞에 붙여 표현합니다.

가독성을 위해 숫자 사이에 '밑줄 (`_`)' 을 넣을 수 있지만, 이들은 무시되므로 따라서 '글자 값' 의 값에는 영향을 주지 않습니다. 정수 글자 값은 맨 앞부분을 `0` 으로 시작할 수 있지만, 이 역시 마찬가지로 무시되며 글자 값의 밑수 또는 값에 영향을 주지 않습니다.

다르게 지정하지 않는 한, 정수 글자 값의 기본 추론 타입은 스위프트 표준 라이브리러 타입인 `Int` 입니다. 스위프트 표준 라이브러리는, [Integers (정수)]({% post_url 2016-04-24-The-Basics %}#integers-정수) 에서 설명한 것처럼, 다양한 크기의 부호 있는 정수와 부호 없는 정수 역시 정의하고 있습니다.

> GRAMMAR OF AN INTEGER LITERAL 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID414)

#### Floating-Point Literals (부동-소수점 글자 값)

#### String Literals (문자열 글자 값)

### Operators (연산자)

### 참고 자료

[^Lexical-Structure]: 이 글에 대한 원문은 [Lexical Structure](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html) 에서 확인할 수 있습니다.

[^token]: 'token' 은 프로그래밍 언어에서 '의미를 가지는 최소 단위' 를 뜻합니다. 여기서는 'token' 을 '낱말' 이라고 옮겼는데, 스위프트에서는 'token' 을 'lexical token (lexeme-어휘소와 비슷한 개념)' 의 의미로 사용하고 있는 것 같습니다. 굳이 옮기자면 '어휘소', '형태소' 등등으로 할 수 있겠으나, 프로그래밍을 하는데 이 정도까지 알아야 하는 것은 아니므로 'token' 은 그냥 앞으로 '낱말' 이라고 계속 옮기겠습니다. 'token' 에 대한 더 자세한 개념은 위키피디아의 [Lexical analysis](https://en.wikipedia.org/wiki/Lexical_analysis) 항목에 있는 [Token](https://en.wikipedia.org/wiki/Lexical_analysis#Token) 부분을 참고하기 바랍니다.

[^maximal-munch]: 'maximal munch' 라는 용어를 '최대한 잘라먹기' 라고 옮긴 것은, [Jay Two](https://j2doll.tistory.com) 님의 [최대한 잘라먹기(Maximal Munch)와 컴파일러(Compiler)](https://j2doll.tistory.com/109) 라는 블로그 글을 참고한 것인데, 이 말이 의미를 가장 잘 전달하고 있다고 생각해서 저도 따르기로 했습니다. 'longest match' 와 'maximal munch' 에 대해서는 위피키디아의 [Maximal munch](https://en.wikipedia.org/wiki/Maximal_munch) 항목을 참고하기 바랍니다.

[^form-feed]: '양식 먹임 (form feed)' 이란 화면 내용을 출력할 때, 현재 페이지를 종료하고 다음 페이지의 첫 부분부터 다시 출력하라는 것을 지시하는 문자입니다.

[^BMP]: '다국어 기본 평면 (Basic Multilingual Plane)' 이란 '유니코드 평면 (Unicode planes)' 에서 '0번 평면 (`U+0000 ~ U+FFFF`) 을 말하는 것으로 여기에는 거의 모든 근대 문자와 특수 문자가 포함되어 있습니다. 더 자세한 내용은 위키피디아의 [Plane (Unicode)](https://en.wikipedia.org/wiki/Plane_(Unicode)) 및 [유니코드 평면](https://ko.wikipedia.org/wiki/유니코드_평면) 항목을 참고하기 바랍니다.

[^noncombining-alphanumeric]: '혼합되지 않은 영숫자 유니코드 문자 (noncombining alphanumeric Unicode character)' 에서 '혼합되지 않은 (noncombining)' 은 `é` 처럼 '강세' 같은 기호와 혼합되지 않은 문자라는 의미이며, '영숫자 (alphanumeric)' 란 수학 기호로 사용되는 그리스 및 라틴 문자인 'Mathematical Alphanumeric Symbols' 을 의미합니다. 더 자세한 내용은 위키피디아의 [Combining character](https://en.wikipedia.org/wiki/Combining_character) 및 [Mathematical Alphanumeric Symbols](https://en.wikipedia.org/wiki/Mathematical_Alphanumeric_Symbols) 항목을 참고하기 바랍니다.

[^digits]: 여기서의 'digits' 은 'Numerical digit' 을 의미하는 것으로, 수를 표기하기 위한 문자를 의미합니다. 더 자세한 내용은 위키피디아의 [Numerical digit](https://en.wikipedia.org/wiki/Numerical_digit) 또는 [숫자](https://ko.wikipedia.org/wiki/숫자) 항목을 참고하기 바랍니다.

[^combining]: '혼합된 유니코드 문자 (combining Unicode characters)' 란 `é` 처럼 '강세' 등의 기호와 혼합되어 있는 문자를 의미합니다. 더 자세한 내용은 위키피디아의 [Combining character](https://en.wikipedia.org/wiki/Combining_character) 항목을 참고하기 바랍니다.

[^backticks]: 'backtics' 는 'grave accent' 라고도 하며 우리말로는 실제로는 '억음 부호' 라고 합니다. 말이 어렵기 때문에 의미 전달의 편의를 위해 '역따옴표' 라고 옮깁니다. 'grave accent' 에 대해서는 위키피디아의 [Grave accent](https://en.wikipedia.org/wiki/Grave_accent) 또는 [억음 부호](https://ko.wikipedia.org/wiki/억음_부호) 항목을 참고하기 바랍니다.

[^escaped]: 'escape' 는 '벗어나다' 라는 의미를 가지고 있는데, 컴퓨터 용어에서 'escape character' 라고 하면 '(본래의 의미를) 벗어나서 (다른 의미를 가지는) 문자' 라는 의미가 있습니다. 보통은 'excape character' 라고 하면 `\` 기호를 붙이는 것을 말하지만, 여기서는 `` ` `` 기호를 사용하여 '키워드' 를 마치 일반 단어처럼 사용할 수 있게 만드는 것을 의미합니다.
