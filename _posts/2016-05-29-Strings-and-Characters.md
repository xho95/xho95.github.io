---
layout: post
comments: true
title:  "Swift 5.4: Strings and Characters (문자열과 문자)"
date:   2016-05-29 19:45:00 +0900
categories: Swift Grammar Strings Characters
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.4)](https://docs.swift.org/swift-book/) 책의 [Strings and Characters](https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html) 부분[^Strings-and-Characters]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.4: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Strings and Characters (문자열과 문자)

_문자열 (string)_ 은, `"hello, world"` 나 `"albatross"` 처럼, 문자들이 연속된 것입니다. 스위프트 문자열은 `String` 타입으로 표현합니다. `String` 의 '내용물 (contents)' 에는, `Character` 값의 '컬렉션 (collection)'[^collection] 을 포함한, 다양한 방법으로 접근할 수 있습니다.

스위프트의 `String` 과 `Character` 타입은 코드에서 '문장 (text)' 작업을 위한 빠르고, '유니코드를-따르는 (Unicode-compliant)' 방법을 제공합니다. 문자열 생성과 '조작 (manipulation)' 을 위한 '구문 표현 (syntax)' 은, C 와 비슷한 '문자열 글자 값 구문 표현 (string literal syntax)'[^string-literal-syntax] 을 써서, 가볍고 이해하기 쉽습니다. 문자열 '이어붙이기 (concatenation)' 는 두 문자열을 `+` 연산자로 조합하면 될 정도로 간단하며, 문자열의 '변경 가능성 (mutability)' 은, 스위프트에 있는의 다른 값들처럼, 상수나 변수를 선택하는 것으로 관리됩니다. 문자열은 상수, 변수, '글자 값 (literals)'[^literals], 및 '표현식 (expressions)' 을 더 긴 문자열에 집어 넣기 위해서도 사용할 수 있는데, 이 과정을 '문자열 보간법 (string interpolation)'[^interpolation] 이라고 합니다. 이는 표시, 저장, 인쇄를 위한 사용자 정의 문자열 값을 쉽게 생성하도록 해줍니다.

구문 표현이 간단함에도 불구하고, 스위프트의 `String` 타입은 빠르고, 최신인 문자열 구현입니다. 모든 문자열은 '인코딩-독립적인 유니코드 문자들 (encoding-independent Unicode characters)' 로 구성되며, 다양한 유니코드 표현법으로 해당 문자들에 접근하는 것을 지원합니다.

> 스위프트의 `String` 타입은 'Foundation'[^Foundation] 의 `NSString` 클래스와 '연동되어 (bridged)' 있습니다. 'Foundation' 은 `NSString` 에서 정의한 메소드를 드러내기 위해 `String` 도 확장합니다. 이는, 'Foundation' 을 '불러 오는 (import)' 경우, 해당 `NSString` 메소드를 `String` 에서 '타입 변환 (casting)' 없이 접근할 수 있다는 의미입니다.
>
> `String` 을 'Foundation' 과 'Cocoa'[^Cocoa] 와 같이 사용하기 위한 더 많은 정보는, [Bridging Between String and NSString](https://developer.apple.com/documentation/swift/string#2919514) 을 참고하기 바랍니다.

### String Literals (문자열 글자 값)

미리 정의된 `String` 값을 코드 내에 '_문자열 글자 값 (string literals)_' 으로 포함할 수 있습니다. '문자열 글자 값' 은 '큰 따옴표 (`"`)' 로 둘러싼 연속된 문자들를 말합니다.

문자열 글자 값은 상수나 변수의 '초기 값 (initial value)' 으로 사용합니다:

```swift
let someString = "Some string literal value"
```

'문자열 글자 값' 으로 초기화했기 때문에 스위프트가 `someString` 상수를 `String` 타입이라고 추론함을 기억하기 바랍니다.

#### Multiline String Literals (여러 줄짜리 문자열 글자 값)

여러 줄에 걸쳐진 문자열이 필요한 경우, 큰 따옴표 세 개로 둘러싼 연속된 문자열인-'여러 줄짜리 문자열 글자 값 (multiline string literal)' 을 사용합니다:

```swift
let quotation = """
The White Rabbit put on his spectacles. "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""
```

'여러 줄짜리 문자열 글자 값' 은 여는 따옴표와 닫는 따옴표 사이의 모든 줄을 포함합니다. 문자열은 '여는 따옴표 (`"""`)' 뒤의 첫 번째 줄에서 시작해서 '닫는 따옴표' 앞의 줄에서 끝나는데, 이는 아래 문자열 중 그 어느 것도 '줄 끊음 (line break)' 으로 시작하거나 끝나지 않음을 의미합니다:[^single-and-multiline]

```swift
let singleLineString = "These are the same."
let multilineString = """
These are the same.
"""
```

소스 코드가 '여러 줄짜리 문자열 글자 값' 안에 '줄 끊음' 을 포함할 땐, 해당 '줄 끊음' 이 문자열 값에도 나타납니다. '줄 끊음' 을 써서 소스 코드를 더 이해하기 쉽게 만들고 싶지만, '줄 끊음' 이 문자열 값 일부가 되진 않길 원하는 경우, 해당 줄 끝에 '역 빅금 (backslash; `\`)' 을 작성합니다:

```swift
let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""
```

'여러 줄짜리 문자열 글자 값' 이 '줄 끊음' 으로 시작하거나 끝나게 만들려면, 첫 번째 또는 마지막 줄에 빈 줄을 작성합니다. 예를 들면 다음과 같습니다:

```swift
let lineBreaks = """

This string starts with a line break.
It also ends with a line break.

"""
```

'여러 줄짜리 (multiline) 문자열' 은 주위 코드와 일치하도록 들여쓰기를 할 수 있습니다. '닫는 따옴표 (`"""`)' 앞의 공백은 다른 모든 줄에서 무시할 공백이 무엇인지를 스위프트에게 알리는 것입니다. 하지만, 닫는 따옴표 앞에 있는 것에 더하여 줄 앞에 공백을 작성한 경우, 그 공백 _은 (is)_ 포함됩니다.

![Indentation](/assets/Swift/Swift-Programming-Language/Strings-and-Characters-indent.jpg)

위 예제에서, '여러 줄짜리 문자열 글자 값' 전체가 들여쓰기 되었음에도 불구하고, 문자열의 첫 번째와 마지막 줄은 어떠한 공백으로도 시작하지 않습니다. 중간 줄은 닫는 따옴표보다 더 들여쓰기 되었으므로, 그 부가적인 네-칸 들여쓰기로 시작합니다.

#### Special Characters in String Literals (문자열 글자 값에 있는 특수 문자)

'문자열 글자 값' 은 다음의 특수 문자를 포함할 수 있습니다:

* (본래의 의미를) '벗어난 (escaped)[^escaped] 특수 문자' 들, `\0` (널-null 문자), `\\` (역 빗금-backslash), `\t` (가로 탭-tab), `\n` (줄 먹임-line feed)[^line-feed], `\r` (캐리지-carriage 반환), `\"` (큰 따옴표) 그리고 `\'` (작은 따옴표)
* `\u{`_n_`}` 라고 작성하는, 임의의 '유니코드 크기 값 (Unicode scalar[^scalar] value)', 여기서 _n_ 은 1-8 자리 16진수입니다. (유니코드는 아래의 [Unicode (유니코드)](#unicode-유니코드) 에서 논의합니다.)

아래 코드는 이러한 특수 문자의 네 가지 예를 보여줍니다. `wiseWords` 상수는 두 개의 '벗어난 (escaped)' 큰 따옴표를 담고 있습니다. `dollarSign`, `blackHeart`, 그리고 `sparklingHeart` 상수는 '유니코드 크기 값 양식 (Unicode scalar format)' 을 실증해 보입니다:

```swift
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imagination is more important than knowledge" - Einstein
let dollarSign = "\u{24}"         // $, 유니코드 크기 값 U+0024
let blackHeart = "\u{2665}"       // ♥, 유니코드 크기 값 U+2665
let sparklingHeart = "\u{1F496}"  // 💖, 유니코드 크기 값 U+1F496
```

'여러 줄짜리 문자열 글자 값' 은 하나가 아니라 세 개의 큰 따옴표를 사용하기 때문에, '벗어나게 (escaping)'[^escaping] 하지 않고도 '여러 줄짜리 문자열 글자 값' 안에 '큰 따옴표 (`"`)' 를 포함할 수 있습니다. '여러 줄짜리 문자열' 이 `"""` 을 '글자 (text)' 로써 포함하려면, 최소 하나 이상의 따옴표는 '벗어나야 (escape)' 합니다. 예를 들면 다음과 같습니다:

```swift
let threeDoubleQuotationMarks = """
Escaping the first quotation mark \"""
Escaping all three quotation mark \"\"\"
"""
```

#### Extended String Delimiters (확장된 문자열 구분자)

특수 문자를 효과 발현 없이 문자열에 포함시키기 위해 '문자열 글자 값' 을 '_확장된 구분자 (extended delimiters)_' 내에 위치시킬 수 있습니다. 문자열을 따옴표 (`"`) 안에 위치시키고 이를 '번호 기호 (number signs; `#`)'[^number-sign] 로 감쌉니다. 예를 들어, '문자열 글자 값' `#"Line 1\nLine 2"#` 를 인쇄하면 문자열을 두 줄로 인쇄하지 않고 '줄 먹임으로 벗어나도록 나열한 것 (line feed escape sequence; `\n`)'[^line-feed-escape-sequence] 을 인쇄합니다.

'문자열 글자 값' 에 있는 문자의 특수 효과가 필요한 경우, '벗어나는 문자 (escape character; `\`)' 뒤의 문자에 '번호 기호' 개수를 일치 시킵니다. 예를 들어, 문자열이 `#"Line 1\nLine 2"#` 인데 줄을 끊고 싶으면, `#"Line 1\#nLine 2"#` 를 대신 사용하면 됩니다. 비슷하게, `###"Line 1\###nLine 2"###` 도 줄을 끊습니다.

'확장된 구분자' 로 생성한 '문자열 글자 값' 도 '여러 줄짜리 문자열 글자 값' 일 수 있습니다. '여러 줄짜리 문자열' 에 `"""` 을, 문자열을 끝낸다는 기본 작동 방식을 재정의하여, '글자 (text)' 로써 포함시키기 위해 '확장된 구분자' 를 사용할 수 있습니다. 예를 들면 다음과 같습니다:

```
let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#
```

### Initializing an Empty String (빈 문자열 초기화하기)

긴 문자열 제작을 시작하기 위해 먼저 빈 `String` 값을 생성하려면, 변수에 '빈 문자열 글자 값 (empty string literal)' 을 할당하거나, 아니면 '초기화 구문 표현 (initializer syntax)' 으로 새로운 `String` 인스턴스를 초기화합니다:

```swift
var emptyString = ""                // 빈 문자열 글자 값 (empty string literal)
var anotherEmptyString = String()   // 초기화 구문 표현 (initializer syntax)
// 이 두 문자열은 모두 빈 것이며, 서로 '동치 (equivalent)' 입니다.
```

`String` 값이 비어 있는 지는 '불리언 (Boolean)' 속성인 `isEmpty` 를 검사하여 알아냅니다:

```swift
if emptyString.isEmpty {
  print("Nothing to see here")
}
// "Nothing to see here" 를 인쇄합니다.
```

### String Mutability (문자열 변경 가능성)

특정 `String` 이 수정 (또는 _변경-mutated_) 가능한지의 여부는, 이를 변수에 할당하거나 (이 경우 수정할 수 있음), 아니면 상수에 할당하는 것 (이 경우 수정할 수 없음) 으로, 지시합니다:

```swift
var variableString = "Horse"
variableString += " and carriage"
// variableString 은 이제 "Horse and carriage" 입니다.

let constantString = "Highlander"
constantString += " and another Highlander"
// 이것은 컴파일-시간 에러를 보고합니다-상수 문자열은 수정할 수 없습니다 (a constant string cannot be modified)
```

> 이런 접근 방식은 '오브젝티브-C' 와 'Cocoa' 의 문자열 '변경 방식 (mutation)' 과는 다른데, 이들은 문자열이 변경 가능함을 지시하기 위해 (`NSString` 와 `NSMutableString` 라는) 두 클래스 중 하나를 선택합니다.

### Strings Are Value Types (문자열은 값 타입입니다)

스위프트의 `String` 타입은 '_값 타입 (value type)_'[^value-type] 입니다. 새로운 `String` 값을 생성하면, 해당 `String` 값은, 함수나 메소드에 전달될 때나 상수나 변수에 할당될 때, _복사 (copied)_ 됩니다. 각 경우마다, 기존 `String` 값의 새로운 복사본이 생성되며, 원래 버전이 아니라, 이 새로운 복사본을 전달하거나 할당합니다. 값 타입은 [Structure and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#structures-and-enumerations-are-value-types-구조체와-열거체는-값-타입입니다) 에서 설명합니다.

스위프트 `String` 의 '기본적으로-복사하는 (copy-by-default)' 작동 방식은 함수나 메소드가 `String` 값을 전달할 때, 이것이 어디서 왔든 상관없이, 정확한 `String` 값을 명확하게 가지도록 보장합니다. 전달받은 문자열은 직접 수정하지 않는한 수정되지 않을 것임을 확신할 수 있습니다.

그 이면을 살펴보면, 스위프트 컴파일러는 문자열 사용법을 최적화해서 실제 복사는 꼭 필요할 때만 일어납니다.[^optimize-string] 이는 값 타입인 문자열과 작업할 때도 항상 뛰어난 성능을 얻는다는 의미입니다.

### Working with Characters (문자 다루기)

`String` 의 개별 `Character` 값은 `for-in` 반복문으로 문자열에 '동작을 반복하는 것 (interating over)' 으로 접근할 수 있습니다:

```swift
for character in "Dog!🐶" {
    print(character)
}
// D
// o
// g
// !
// 🐶
```

`for-in` 반복문은 [For-In Loops (For-In 반복문)]({% post_url 2020-06-10-Control-Flow %}#for-in-loops-for-in-반복문) 에서 설명합니다.

또 다른 방법으로, `Character` '타입 보조 설명 (type annotation)'[^annotation] 을 제공하는 것으로 '단일-문자 문자열 글자 값 (single-character string literal)' 으로부터 독립된 `Character` 상수나 변수를 생성할 수 있습니다:

```swift
let exclamationMark: Character = "!"
```

`String` 값은 `Character` 값의 배열을 초기자의 인자로 전달하는 것으로써 생성할 수 있습니다:

```swift
let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)
print(catString)
// "Cat!🐱" 을 인쇄합니다.
```

### Concatenating Strings and Characters (문자열과 문자 이어붙이기)

`String` 값은 새로운 `String` 값을 생성하기 위해 '더하기 연산자 (`+`)' 로 서로 더하거나- _이어붙일 (concatenated)_-수 있습니다:

```swift
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2
// welcome 은 이제 "hello there" 입니다.
```

`String` 값을 기존 `String` 변수에 '더하기 할당 연산자 (`+=`)' 로 덧붙일 수도 있습니다:

```swift
var instruction = "look over"
instruction += string2
// instruction 은 이제 "look over there" 입니다.
```

`Character` 값은 `String` 변수에 `String` 타입의 `append()` 메소드로 덧붙일 수 있습니다:

```swift
let exclamationMark: Character = "!"
welcome.append(exclamationMark)
// welcome 은 이제 "hello there!" 입니다.
```

> `String` 이나 `Character` 를 기존 `Character` 변수에 덧붙일 수는 없는데, `Character` 값은 반드시 단일 문자만 담을 수 있기 때문입니다.

더 긴 줄의 문자열을 제작하기 위해 '여러 줄짜리 문자열 글자 값' 을 사용 중인 경우, 마지막 줄을 포함한, 문자열의 모든 줄이 '줄 끊음 (line break)' 으로 끝나길 원할 것입니다. 예를 들면 다음과 같습니다:

```swift
let basStart = """
one
two
"""

let end = """
three
"""

print(basStart + end)
// 다음의 두 줄을 출력합니다:
// one
// twothree

let goodStart = """
one
two

"""

print(goodStart + end)
// 다음의 세 줄을 출력합니다:
// one
// two
// three
```

위 코드에서, `badStart` 와 `end` 를 이어붙이면 두-줄짜리 문자열을 내놓는데, 이는 원하는 결과가 아닙니다. `badStart` 의 마지막 줄이 '줄 끊음' 으로 끝나지 않기 때문에, 해당 줄이 `end` 의 첫 번째 줄과 뭉쳐집니다. 이와는 대조적으로, `goodStart` 의 두 줄은 모두 '줄 끊음' 으로 끝나므로, `end` 와 조합할 때, 예상대로, 결과가 세 줄이 됩니다.

### String Interpolation (문자열 보간법)

_문자열 보간법 (string interpolation)_ 은 '문자열 글자 값' 안에 상수, 변수, 글자 값, 그리고 표현식의 값을 포함시켜 섞음으로써 새로운 `String` 값을 생성하는 방법입니다. 문자열 보간법은 '한-줄짜리' 와 '여러 줄짜리' 문자열 글자 값 둘 모두에서 사용할 수 있습니다. 문자열 글자 값 안에 집어 넣을 각 항목은 괄호 쌍으로 포장하고, '역 빗금 (backslash; `\`)' 접두사를 붙입니다:

```swift
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// message 는 "3 times 2.5 is 7.5" 입니다.
```

위 예제에서, `multiplier` 의 값은 문자열 글자 값 안에 `\(multiplier)` 라고 집어 넣습니다. 이 '자리 표시자 (placeholder)' 는 실제 문자열을 생성하기 위해 문자열 보간법을 평가할 때 `multiplier` 의 실제 값으로 대체됩니다.

`multiplier` 의 값은 문자열 뒤에 있는 '더 큰 표현식' 의 일부이기도 합니다. 이 표현식은 `Double(multiplier) * 2.5` 의 값을 계산하고 결과인 (`7.5`) 를 문자열에 집어 넣습니다. 이 경우, 문자열 글자 값 안에 포함될 때의 표현식은 `\(Double(multiplier) * 2.5)` 라고 작성합니다.

다른 경우라면 문자열 보간법으로 취급될 문자를 담고 있는 문자열을 생성하기 위해 '확장된 문자열 구분자 (extended string delimiters)' 를 사용할 수 있습니다. 예를 들면 다음과 같습니다:

```swift
print(#"Write an interpolated string in Swift using \(multiplier)."#)
// "Write an interpolated string in Swift using \(multiplier)." 를 인쇄합니다.
```

'확장된 구분자' 를 사용하는 문자열에서 '문자열 보간법' 을 사용하려면, '역 빗금 (backslash)' 뒤의 '번호 기호' 개수를 문자열 시작과 끝에 있는 '번호 기호' 개수와 일치시키면 됩니다. 예를 들면 다음과 같습니다:

```swift
print(#"6 times 7 is \#(6 * 7)."#)
"6 times 7 is 42." 를 출력합니다.
```

> 보간된 문자열 내의 괄호 안에서 작성한 표현식은 '벗어나지 않은 역 빗금 (unescaped backslash; `\`)', 캐리지 반환 (`\r`), 또는 '줄 먹임 (`\n`)' 을 담을 수 없습니다. 하지만, 다른 '문자열 글자 값' 들은 담을 수 있습니다.

### Unicode (유니코드)

_유니코드 (Unicode)_ 는 서로 다른 '문자 체계 (writing system)' 에서 문장을 '부호화 (encoding)' 하고, 표현하며, 가공하기 위한 국제 표준입니다. 이는 어떤 언어에 대해서든 거의 대부분의 문자를 표준화된 형식으로 표현하고, '텍스트 파일' 이나 웹 페이지 같은 외부 소스에서 해당 문자를 읽고 쓸 수 있도록 해줍니다. 스위프트의 `String` 과 `Character` 타입은, 이번 부분에서 설명하는 것처럼, 온전히 '유니코드를-따르고 (Unicode-compliant)' 있습니다.

#### Unicode Scalar Values (유니코드 크기 값)

그 이면을 살펴보면, 스위프트 그 자체의 `String` 타입은 _유니코드 크기 값 (Unicode scalar values)_ 으로 제작되어 있습니다. '유니코드 크기 값' 은 하나의 문자 또는 '수정자 (modifier)' 에 대한 '유일한 21-비트 수' 로, 가령 `U+0061` 은 `LATIN SMALL LETTER A` (`"a"`) 에, `U+1F425` 는 `FRONT-FACING BABY CHICK` (`"🐥"`) 에 대한 것입니다.

모든 21-비트 '유니코드 크기 값' 이 문자에 할당된 것은 아님을 기억하기 바랍니다-어떤 크기 값은 미래의 할당을 위해서 또는 'UTF-16 부호화 (encoding)' 에서 사용하기 위해서 예약되어 있습니다. 문자에 할당되어 있는 '크기 값' 은 전형적으로, 위 예제의 `LATIN SMALL LETTER A` 와 `FRONT-FACING BABY CHICK` 같이, 이름도 가지고 있습니다.

#### Extended Grapheme Clusters (확장된 자소 덩어리)

스위프트의 모든 `Character` 타입 인스턴스는 단 하나의 '_확장된 자소 덩어리 (extended grapheme cluster)_' 를 표현합니다.[^extended-grapheme-cluster] '확장된 자소 덩어리' 는 하나 이상의 유니코드 크기 값이 나열된 것으로 (조합하면) 사람이-이해할 수 있는 단일한 문자를 만들어 냅니다.

예를 들어 보겠습니다. '문자 (letter)'[^letter] `é` 는 단일 유니코드 크기 값 `é` (`LATIN SMALL LETTER E WITH ACUTE` 및, `U+00E9`) 로 표현할 수 있습니다. 하지만, 똑같은 문자를 한 _쌍 (pair)_ 의 '크기 값'-표준 문자 `e` (`LATIN SMALL LETTER E` 및, `U+0065`) 와, 그 뒤의 `COMBINING ACUTE ACCENT` 크기 값 (`U+0301`)-으로 표현할 수도 있습니다. `COMBINING ACUTE ACCENT` 크기 값은, '유니코드를-인식하는 글자-그리기 시스템' 이 이를 그릴 때 `e` 를 `é` 로 바꾸도록, 자기 앞의 크기 값에 시각적으로 적용됩니다.

두 경우 모두, 문자 `é` 는 하나의 '확장된 자소 덩어리' 를 표현하는 '단일 스위프트 `Character` 값' 으로 표현됩니다. 첫 번째 경우엔, '덩어리 (cluster)' 가 단일 크기 값을 담고 있으며; 두 번째 경우, 이는 두 크기 값의 '덩어리' 입니다:

```swift
let eAcute: Character = "\u{E9}"                // é
let combinedEAcute: Character = "\u{65}\u{301}" // e 와 그 뒤의  ́
// eAcute 는 é 이고, combinedEAcute 도 é 입니다.
```

'확장된 자소 덩어리' 는 '쓰는 방법이 많고 복잡한 문자 (many complex script characters)' 를 단일 `Character` 값으로 표현하는 유연한 방법입니다. 예를 들어, '한글' 에서 '한국어 음절' 은 '완성형 (precomposed)' 또는 '조합형 (decomposed)' 어느 것으로도 표현할 수 있습니다. 이 두 표현법 모두 스위프트에서 '단일 `Character` 값' 으로 인정합니다:

```swift
let precomposed: Character = "\u{D55C}"                 // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"  // ᄒ, ᅡ, ᆫ
// precomposed 는 '한' 이고, decomposed 도 '한' 입니다.
```

'확장된 자소 덩어리' 는 (`COMBINING ENCLOSING CIRCLE` 및, `U+20DD` 같은) 테두리 표시를 위한 크기 값으로 다른 유니코드 크기 값에 테두리를 쳐서 단일 `Character` 값을 만들게 해줍니다.

```swift
let enclosedEAcute: Character = "\u{E9}\u{20DD}"
// enclosedEAcute 은 é⃝ 입니다.
```

'지역 지시 기호 (regional indicator symbols)' 에 대한 유니코드 크기 값은 서로 쌍으로 조합하여 단일 `Character` 값을 만들 수 있는데, 가령 `REGIONAL INDICATOR SYMBOL LETTER U (U+1F1FA)` 와 `REGIONAL INDICATOR SYMBOL LETTER S (U+1F1F8)` 의 조합은 다음과 같습니다:

```swift
let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
// regionalIndicatorForUS 은 🇺🇸 입니다.
```

### Counting Characters (문자 개수 세기)

문자열에서 `Character` 값의 개수를 가져오려면, 문자열의 `count` 속성을 사용합니다:

```swift
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")
// "unusualMenagerie has 40 characters" 를 인쇄합니다.
```

스위프트의 `Character` 값에 '확장된 자소 덩어리' 를 사용함으로 인해 문자열 이어붙이기와 수정이 문자열의 글자 개수에 항상 영향을 주지는 않는다는 점을 기억하기 바랍니다.

예를 들어, 새로운 문자열을 네-글자 단어인 `cafe` 로 초기화하고 나서, 문자열 끝에 `COMBINING ACUTE ACCENT` (`U+0301`) 를 덧붙인 경우, 네 번째 문자로, `e` 대신, `é` 를 가진, 결과 문자열은 여전히 `4` 라는 글자 개수를 가질 것입니다:

```swift
var word = "cafe"
print("the number of characters in \(word) is \(word.characters.count)")
// "the number of characters in cafe is 4" 를 인쇄합니다.

word += "\u{301}"       // COMBINING ACUTE ACCENT, U+0301

print("the number of characters in \(word) is \(word.characters.count)")
// "the number of characters in café is 4" 를 인쇄합니다.
```

> '확장된 자소 덩어리' 는 '다중 유니코드 크기 값' 으로 구성될 수 있습니다. 이는 서로 다른 문자들-및 같은 문자에 대한 서로 다른 표현법들-은 저장을 위해 서로 다른 크기의 메모리가 필수일 수 있다는 것을 의미합니다. 이 때문에, 스위프트의 문자는 문자열 표현 내에서 각각이 같은 크기의 메모리를 차지하지 않습니다. 그 결과, 문자열의 글자 개수는 '확장된 자소 덩어리' 의 경계를 결정하기 위해 문자열 전체에 동작을 반복해야만 계산할 수 있습니다. 특별히 긴 문자열과 작업할 경우, `count` 속성이 해당 문자열의 글자를 결정하기 위해서는 반드시 전체 문자열의 유니코드 크기 값에 동작을 반복해야 함을 깨달아야 합니다.
>
> `count` 속성이 반환하는 글자 개수는 똑같은 문자를 담은 `NSString` 의 `length` 속성과 항상 같지는 않습니다. `NSString` 의 '길이' 는 문자열 내의 유니코드 식의 '확장된 자소 덩어리' 개수가 아니라 문자열의 UTF-16 표현법 내의 '16-비트 코드 단위'[^16-bit-code-units] 의 개수에 기초한 것입니다.

### Accessing and Modifying a String (문자열에 접근하고 수정하기)

문자열은 메소드와 속성, 또는 '첨자 연산 구문 표현 (subscript syntax)' 을 사용하여 접근하고 수정합니다.

#### String Indices (문자열 색인)

각 `String` 값은 '결합된 _색인 타입 (index type)_ 인', `String.Index` 을 가지고 있는데, 이는 문자열에 있는 각 `Character` 의 위치와 관련되어 있습니다.

위에서 언급한 것처럼, 서로 다른 문자들은 저장을 위해 서로 다른 크기의 메모리가 필수일 수 있으므로, 특정 위치의 `Character` 가 어는 것인지를 결정하려면, 반드시 해당 `String` 의 처음부터 끝까지 각 '유니코드 크기 값' 에 동작을 반복해야 합니다. 이런 이유로, 스위프트 문자열의 정수 값으로 색인될 수 없습니다.[^indexed-by-integer-values]

`String` 의 첫 번째 `Character` 위치에 접근하려면 `startIndex` 속성을 사용합니다. `endIndex` 속성은 `String` 에 있는 마지막 문자 다음 위치입니다. 그 결과, `endIndex` 속성은 문자열의 '첨자 연산' 에 대한 인자로 유효하지 않습니다. `String` 이 비어있으면, `startIndex` 와 `endIndex` 가 같습니다.

`String` 의 `index(before:)` 와 `index(after:)` 메소드를 사용하여 주어진 색인 전후의 색인에 접근합니다. 주어진 색인에서 멀리 떨어진 색인에 접근하려면, 이러한 메소드를 여러 번 호출하는 대신 `index(_:offsetBy:)` 메소드를 사용할 수 있습니다.

특정 `String` 색인에 있는 `Character` 에 접근하기 위해 '첨자 연산 구문 표현' 을 사용할 수 있습니다.[^particular-index]

```swift
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]
// a
```

문자열 범위 밖의 색인 또는 문자열 범위 밖의 색인에 있는 `Character` 에 접근하려는 것은 '실행 시간 에러' 를 일으킬 것입니다.

```swift
// greeting[greeting.endIndex]  // 에러
// greeting.index(after: greeting.endIndex) // 에러
```

문자열에 있는 모든 개별 문자의 색인에 접근하려면 `indices` 속성을 사용합니다.

```swift
for index in greeting.indices {
  print("\(greeting[index]) ", terminator: "")
}
// "G u t e n   T a g ! " 를 인쇄합니다.
```

> `startIndex` 와 `endIndex` 속성들 그리고 `index(before:)`, `index(after:)`, 및 `index(_:offsetBy:)` 메소드는 `Collection` 프로토콜을 준수하는 어떤 타입에서도 사용할 수 있습니다. 이는, 여기서 보인, `String` 뿐만 아니라 `Array`, `Dictionary`, 및 `Set` 같은 컬렉션 타입을 포함합니다.

#### Inserting and Removing (집어 넣기와 제거하기)

단일 문자를 문자열의 지정된 색인에 집어 넣으려면, `insert(_:at:)` 메소드를 사용하고, 다른 문자열의 '내용물 (contents)' 을 지정된 색인에 집어 넣으려면, `insert(contentsOf:at:)` 메소드를 사용합니다.

```swift
var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
// welcome 은 이제 "hello!" 입니다.

welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
// welcome 은 이제 "hello there!" 입니다.
```

단일 문자를 문자열의 지정된 색인에서 제거하려면, `remove(at:)` 메소드를 사용하고, 지정된 범위의 '하위 문자열 (substring)' 을 제거하려면, `removeSubrange(_:)` 메소드를 사용합니다:

```swift
welcome.remove(at: welcome.index(before: welcome.endIndex))
// welcome 은 이제 "hello there" 입니다.

let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)
// welcome 은 이제 "hello" 입니다.
```

> `insert(_:at:)`, `insert(contentsOf:at:)`, `remove(at:)`, 그리고 `removeSubrange(_:)` 메소드는 `RangeReplaceableCollection` 프로토콜을 준수하는 어떤 타입에서도 사용할 수 있습니다. 이는, 여기서 보인, `String` 뿐만 아니라 `Array`, `Dictionary`, 및 `Set` 같은 컬렉션 타입을 포함합니다.

### Substrings (하위 문자열)

문자열에서 '하위 문자열 (substring)' 을 가져올 때-예를 들어, '첨자 연산' 이나 `prefix(_:)` 같은 메소드를 사용하는 경우-결과는, 또 하나의 문자열이 아니라, [Substring](https://developer.apple.com/documentation/swift/substring) 의 인스턴스입니다. 스위프트의 '하위 문자열' 은 문자열과 거의 똑같은 메소드를 가지는데, 이는 문자열을 작업할 때와 똑같은 방식으로 하위 문자열과 작업할 수 있다는 것을 의미합니다. 하지만, 문자열과는 달리, 하위 문자열은 문자열 작업을 하는 짧은 시간 동안에만 사용합니다. 결과를 더 오랫동안 저장할 준비가 됐을 때, 하위 문자열을 `String` 의 인스턴스로 변환합니다. 예를 들면 다음과 같습니다:

```swift
let greeting = "Hello, world!"
let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]
// beginning 은 "Hello" 입니다.

// 오랜-기간 저장하기 위해 결과를 String 으로 변환합니다.
let newString = String(beginning)
```

문자열과 같이, 각 하위 문자열은 하위 문자열을 이루는 문자들이 저장된 메모리 영역을 가지고 있습니다. 문자열과 하위 문자열의 차이점은 하위 문자열의 경우, 성능 최적화로 의해, 원래의 문자열을 저장하고자 사용하는 메모리, 또는 다른 하위 문자열을 저장하고자 사용하는 메모리를 재사용할 수 있다는 것입니다. (문자열도 비슷한 최적화를 하지만, 두 문자열이 메모리를 할 때, 이들은 똑같은 것입니다.) 이런 성능 최적화는 문자열이나 하위 문자열 중 하나를 수정하기 전까지 메모리 복사를 위한 성능 비용을 지불하지 않아도 된다는 것을 의미합니다. 위에서 언급한 것처럼, 하위 문자열은 '오랜-기간 저장 (long-term storage)' 하는 데는 적합하지 않습니다-왜냐면 이는 원래 문자열의 저장 공간을 재사용하므로, 하위 문자열 중 어떤 것이든 사용 중이라면 반드시 원래 문자열 전체를 메모리에 유지해야 하기 때문입니다.

위 예제에서, `greeting` 은 문자열인데, 이는 문자열을 이루는 문자들이 저장된 메모리 영역을 가지고 있음을 의미합니다. `beginning` 은 `greeting` 의 하위 문자열이기 때문에, 이는 `greeting` 이 사용하는 메모리를 재사용합니다. 이와는 대조적으로, `newString` 은 문자열입니다-하위 문자열을 써서 생성할 때, 이는 자신만의 저장 공간을 가지게 됩니다. 아래 그림은 이러한 관계를 보여줍니다:

![Indentation](/assets/Swift/Swift-Programming-Language/Strings-and-Characters-substrings.jpg)

> `String` 과 `Substring` 은 둘 다 [StringProtocol](https://developer.apple.com/documentation/swift/stringprotocol) 프로토콜을 준수하는데, 이는 '문자열 조작 (string-manipulation) 함수' 의 경우 `StringProtocol` 값을 받는 것이 대체로 편리하다는 것을 의미합니다. 그런 함수는 `String` 이나 `Substring` 값 어느 것으로도 호출할 수 있습니다.

### Comparing Strings (문자열 비교하기)

스위프트는 '문장 형태의 (textual) 값' 을 비교하는 세 가지 방법을 제공합니다: '문자열과 문자의 같음 비교 (string and character equality)', '접두사 같음 비교 (prefix equality)', '접미사 같음 비교 (suffix equality)' 이 그것입니다.

#### String and Character Equality (문자열과 문자의 같음 비교)

'문자열과 문자의 같음 비교' 는, [Comparison Operators (비교 연산자)]({% post_url 2016-04-27-Basic-Operators %}#comparison-operators-비교-연산자) 에서 설명한 것처럼, "같음 (equal to)" 연산자 (`==`) 와 "같지 않음 (not equal to)" 연산자 (`!=`) 로 검사합니다:

```swift
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
  print("These two strings are considered equal")
}
// "These two strings are considered equal." 을 인쇄합니다.
```

두 `String` 값들 (또는 두 `Character` 값들) 은 그들의 '확장된 자소 덩어리' 가 '_법적으로 동치 (canonically equivalent)_'[^canonically] 이면 같다고 간주합니다. 확장된 자소 덩어리는 그들이, 심지어 그 이면에서는 서로 다른 '유니코드 크기 값' 으로 구성되었다 할지라도, '언어적으로 (linguistic)' 같은 의미와 형태를 가지면 '법적으로 동치' 입니다.

예를 들어, `LATIN SMALL LETTER E WITH ACUTE` (`U+00E9`) 는 `LATIN SMALL LETTER E` (`U+0065`) 뒤에 `COMBINING ACUTE ACCENT` (`U+0301`) 가 붙은 것과 '법적으로 동치' 입니다. 이 두 '확장된 자소 덩어리' 모두 문자 `é` 를 표현하는 방식으로 유효하므로, 이들은 '법적으로 동치' 라고 간주할 수 있습니다:

```swift
// "Voulez-vous un café?" 가 LATIN SMALL LETTER E WITH ACUTE 를 사용한 경우
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

// "Voulez-vous un café?" 가 LATIN SMALL LETTER E 와 COMBINING ACUTE ACCENT 를 사용한 경우
let combinedEAccuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAccuteQuestion {
    print("These two strings are considered equal")
}
// "These two strings are considered equal" 를 인쇄합니다.
```

거꾸로 말해서, 영어에서 사용된, `LATIN CAPITAL A` (`U+0041`, 또는 `"A"`) 는, 러시아어에서 사용된, `CYRILLIC CAPITAL LETTER A` (`U+0410`, 또는 `"А"`) 와 동치가 _아닙니다 (not)_. 이 문자들은 보기에는 비슷하지만, 언어적으로 같은 의미를 가지지 않습니다:

```swift
let latinCapitalLetterA: Character = "\u{41}"

let cyrillicCapitalLetterA: Character = "\u{0410}"

if latinCapitalLetterA != cyrillicCapitalLetterA {
  print("These two characters are not equivalent")
}
// "These two characters are not equivalent" 를 인쇄합니다.
```

> 스위프트의 문자열과 문자 비교 연산은 '지역에-민감 (locale-sensitive)'[^locale-sensitive] 하지 않습니다.

#### Prefix and Suffix Equality (접두사와 접미사의 같음 비교)

문자열이 특정 문자열의 접두사나 접미사를 가지고 있는지 검사하려면, 문자열의 `hasPrefix(_:)` 와 `hasSuffix(_:)` 메소드를 호출하는데, 이 둘 모두 `String` 타입의 단일 인자를 취하고 '불리언 (Boolean)' 값을 반환합니다.

아래 예제는 셰익스피어의 _로미오와 줄리엣 (Romeo and Juliet)_ 에 있는 첫 두 '막 (acts)' 의 각 '장(면; scene)' 을 표현하는 문자열 배열을 고려합니다:

```swift
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]
```

`hasPrefix(_:)` 메소드를 `romeoAndJuliet` 배열에 사용하면 '희곡 (play)' 의 '제 1막' 에 있는 '장(면)' 의 수를 셀 수 있습니다:

```swift
var act1SceneCount = 0

for scene in romeoAndJuliet {
  if scene.hasPrefix("Act 1") {
    act1SceneCount += 1
  }
}
print("There are \(act1SceneCount) scenes in Act 1")
// "There are 5 scenes in Act 1" 를 인쇄합니다.
```

이와 비슷하게, `hasSuffix(_:)` 메소드를 사용하면 '캐퓰렛 저택 (Capulet's mansion)'[^capulet] 과 '로렌스 수사의 작은 방 (Friar Lawrence's cell)'[^friar] 인 곳 또는 이 곳 주변에서 일어나는 '장(면)' 의 수를 셀 수 있습니다.:

```swift
var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
  if scene.hasSuffix("Capulet's mansion") {
    mansionCount += 1
  } else if scene.hasSuffix("Friar Lawrence's cell") {
    cellCount += 1
  }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
// "6 mansion scenes; 2 cell scenes" 를 인쇄합니다.
```

> `hasPrefix(_:)` 와 `hasSuffix(_:)` 메소드는 각 문자열에 있는 '확장된 자소 덩어리' 사이를, [String and Character Equality (문자열과 문자의 같음 비교)](#string-and-character-equality-문자열과-문자의-같음-비교) 에서 설명한 것처럼, 문자와 문자끼리 법적 동치인지를 비교하여 수행합니다.

### Unicode Representations of Strings (문자열의 유니코드 표현법)

유니코드 문자열이 문서 파일이나 다른 저장 공간에 작성되어 있을 때, 해당 문자열에 있는 '유니코드 크기 값' 은 유니코드에서-정의한 여러 가지 '_인코딩 형식 (encording forms)_' 중 하나로 '인코딩 (encoding; 복호화)' 되어 있습니다. 각 형식은 문자열을 '_코드 단위 (code units)_' 라는 작은 조각으로 '인코딩' 합니다. 이는 (문자열을 8-비트 '코드 단위' 로 인코딩하는) 'UTF-8' 인코딩 형식 , (문자열을 16-비트 '코드 단위' 로 인코딩하는) 'UTF-16' 인코딩 형식 , 그리고 (문자열을 32-비트 '코드 단위' 로 인코딩하는) 'UTF-32' 인코딩 형식을 포함합니다.

스위프트는 문자열의 '유니코드 표현법' 에 접근하는 여러 가지 방법을 제공합니다. 문자열은, 개별 `Character` 값을 '유니코드 방식의 '확장된 자소 덩어리' 로 접근하기 위해, `for`-`in` 구문으로 동작을 반복할 수 있습니다. 이 과정은 [Working with Characters (문자 다루기)](#working-with-characters-문자-다루기) 에서 설명했습니다.

또 다른 방법으로, 세 가지 다른 '유니코드를-따르는 표현법 (Unicode-compliant representations)' 으로 `String` 값에 접근합니다:

* UTF-8 코드 단위의 '집합체 (collection)' (문자열의 `utf8` 속성으로 접근함)
* UTF-16 코드 단위의 집합체 (문자열의 `utf16` 속성으로 접근함)
* 문자열의 UTF-32 인코딩 형식과 동치인, 21-비트 유니코드 크기 값의 집합체 (문자열의 `unicodeScalars` 속성으로 접근함)

아래의 각 예제는, 문자 `D`, `o`, `g`, `‼` (`DOUBLE EXCLAMATION MARK`, 또는 유니코드 크기 값 `U+203C`), 그리고 `🐶` 문자 (`DOG FACE`, 또는 유니코드 크기 값 `U+1F436`) 로 이루어진, 다음 문자열의 서로 다른 표현법을 보여줍니다:

```swift
let dogString = "Dog!!🐶"
```

#### UTF-8 Representation (UTF-8 표현법)

`String` 의 'UTF-8 표현법' 에는 `utf8` 속성에 동작을 반복함으로써 접근할 수 있습니다. 이 속성의 타입은 `String.UTF8View` 이며, 이는, 문자열의 UTF-8 표현법에 있는 각 바이트 하나가, 부호없는 8-비트 (`UInt8`) 인 값들의 '집합체 (collection)' 입니다:

![UTF-8 representation](/assets/Swift/Swift-Programming-Language/Strings-and-Characters-UTF-8-representation.jpg)

```swift
for codeUnit in dogString.utf8 {
  print("\(codeUnit) ", terminator: "")
}
print("")
// "68 111 103 226 128 188 240 159 144 182 " 를 인쇄합니다.
```

위 예제에서, 처음 세 10-진 `codeUnit` 값 (`68`, `111`, `103`) 들은, 'UTF-8 표현법' 이 'ASCII 표현법' 과 똑같이, 문자 `D`, `o`, 그리고 `g` 를 표현합니다. 그 다음 세 10-진 `codeUnit` 값 (`226`, `128`, `188`) 들은 `DOUBLE EXCLAMATION MARK` 문자의 3-바이트 짜리 'UTF-8 표현법' 입니다. 마지막 네 `codeUnit` 값 (`240`, `159`, `144`, `182`) 들은 `DOG FACE` 문자의 4-바이트 짜리 'UTF-8 표현법' 입니다.

#### UTF-16 Representation (UTF-16 표현법)

`String` 의 'UTF-16 표현법' 에는 `utf16` 속성에 동작을 반복함으로써 접근할 수 있습니다. 이 속성의 타입은 `String.UTF16View` 이며, 이는, 문자열의 UTF-16 표현법에 있는 각 16-비트 코드 유닛 하나가, 부호없는 16-비트 (`UInt16`) 인 값들의 '집합체 (collection)' 입니다:

![UTF-16 representation](/assets/Swift/Swift-Programming-Language/Strings-and-Characters-UTF-16-representation.jpg)

```swift
for codeUnit in dogString.utf16 {
  print("\(codeUnit) ", terminator: "")
}
print("")
// "68 111 103 8252 55357 56374 " 를 인쇄합니다.
```

또다시, 처음 세 `codeUnit` 값 (`68`, `111`, `103`) 들은 문자 `D`, `o`, 그리고 `g` 를 표현하는데, 이 'UTF-16 코드 단위' 들은 문자열의 'UTF-8 표현법' 에 있는 것과 똑같은 값을 가집니다 ('유니코드 크기 값' 들이 'ASCII 문자' 를 표현하기 때문입니다).

네 번째 `codeUnit` 값 (`8252`) 은 16-진 값 `203C` 와 동치인 10-진 값으로, 이는 `DOUBLE EXCLAMATION MARK` 문자에 대한 '유니코드 크기 값' `U+203C` 를 표현합니다. 이 문자는 'UTF-16' 에서는 단일 '코드 단위' 로 표현할 수 있습니다.

다섯 번째와 여섯 번째 `codeUnit` 값 (`55357` 와 `56374`) 들은 `DOG FACE` 문자에 대한 'UTF-16 대용 쌍 (surrogate pair)[^surrogate-pair] 표현법' 입니다. 이 값들은 (10-진 값이 `55357` 인) '높은자리-대용 값' `U+D83D` 와 (10-진 값이 `56374` 인) '낮은자리-대용 값' `U+DC36` 입니다.

#### Unicode Scalar Representation ('유니코드 크기 값' 표현법)

`String` 값의 '유니코드 크기 값 표현법' 에는 `unicodeScalars` 속성에 동작을 반복함으로써 접근할 수 있습니다. 이 속성의 타입은 `UnicodeScalarView` 이며, 이는 타입이 `UnicodeScalar` 인 값들의 '집합체 (collection)' 입니다.

각 `UnicodeScalar` 는 '크기 값 (scalar)' 의, `UInt32` 값 내에 표현된, 21-비트 값을 반환하는 `value` 속성을 가집니다:

![Unicode Scalar representation](/assets/Swift/Swift-Programming-Language/Strings-and-Characters-Unicode-scalar-representation.jpg)

```swift
for scalar in dogString.unicodeScalars {
  print("\(scalar.value) ", terminator: "")
}
print("")
// "68 111 103 8252 128054 " 를 인쇄합니다.
```

처음 세 `UnicodeScalar` 값 (`68`, `111`, `103`) 들에 대한 `value` 속성은 다시 한번 문자 `D`, `o`, 그리고 `g` 를 표현합니다.

네 번째 `codeUnit` 값 (`8252`) 은 또다시 16-진 값 `203C` 와 동치인 10-진 값이며, 이는 `DOUBLE EXCLAMATION MARK` 문자에 대한 '유니코드 크기 값' `U+203C` 를 표현합니다.

다섯 번째이자 최종인 `UnicodeScalar` 의 `value` 속성, `128054`, 는 16-진 값 `1F436` 와 동치인 10-진 값으로, `DOG FACE` 문자에 대한 '유니코드 크기 값' `U+1F436` 을 표현합니다.

이 `value` 속성의 조회를 대신하여, 각 `UnicodeScalar` 값 자체도 새로운 `String` 값을 생성하기 위해, '문자열 보간법' 에서 처럼, 사용할 수 있습니다:

```swift
for scalar in dogString.unicodeScalars {
    print("\(scalar) ")
}
// D
// o
// g
// ‼
// 🐶
```

### 다음 장

[Collection Types (집합체 타입) > ]({% post_url 2016-06-06-Collection-Types %})

### 참고 자료

[^Strings-and-Characters]: 원문은 [Strings and Characters](https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^collection]: '컬렉션 (collection)' 은 스위프트에서 특정한 값들의 집합을 묘사하는 '집합체' 타입입니다. 보다 자세한 내용은 [Collection Types (집합체 타입)]({% post_url 2016-06-06-Collection-Types %}) 을 참고하기 바랍니다.

[^string-literal-syntax]: '문자열 글자 값 구문 표현 (string literal syntax)' 은 말이 길지만 개념은 아주 간단합니다. `let greeting = "hello"` 와 같은 문장에서 `"hello"` 가 바로 '문자열 글자 값 구문 표현 (string literal syntax)' 입니다. 원문은 이 '문자열 글자 값 구문 표현' 이 C 와 비슷하는 의미입니다. '글자 값 (literal)' 에 대한 더 자세한 내용은, 바로 아래에 있는 '글자 값 (literals) 에 대한 주석'[^literals] 또는 [Literals (글자 값)]({% post_url 2020-07-28-Lexical-Structure %}#literals-글자-값) 항목을 참고하기 바랍니다.

[^literals]: 여기서 '글자 값 (literals)' 는 '글자로 표현된 실제 값' 을 의미하며, `let a = 3.14` 에서는 `3.14` 라는 `Double` 값이 되고, `let b = "hello"` 에서는 `"hello"` 라는 `String` 값이 됩니다. 즉 '글자 값 (literals)' 에서 값의 타입은 그 값이 실제로 표현하는 것이 무엇인지에 따라 달라집니다.

[^interpolation]: '보간법 (interpolation)' 은 원래 수학 용어로 그래프 상에서 두 점 사이의 값을 근사적으로 구해서 채워넣는 방법을 말합니다. 'string interpolation' 은 굳이 직역하면 '문자열 삽입법' 등으로 옮길 수 있겠지만, 'interpolation' 은 원래부터 '보간법' 이라는 말로 많이 사용하고 있으므로 그대로 '보간법' 을 사용하도록 합니다. '문자열 보간법' 은 한 문자열 중간에 다른 값을 문자열의 형태로 집어넣는 것으로 이해할 수 있습니다.

[^escaped]: 'escaped' 는 우리 말로 '벗어난' 을 의미하는 단어인데, 프로그래밍에서 'escaped special characters' 라고 하면 '(본래의 의미를) 벗어나서 다른 의미를 가지게된 특수 문자' 라는 의미가 됩니다. 예를 들어 `n` 이라고 하면, 그냥 하나의 영어 문자가 되지만, `\n` 이라고 하면 본래의 영어 단어의 의미를 벗어나서, `new line (feed)` 이라는 새로운 의미를 가지게 됩니다. 이렇게 문자 앞에 '역 빗금 (backslash; `\`)' 를 붙여서 '본래 의미를 벗어난 다른 의미를 가지는 문자' 를 일컬어 'escaped characters' 라고 합니다.

[^scalar]: 'scalar' 는 원래 수학 용어로 '크기만을 가지는 값' 입니다. 여기서 'Unicode scalar value' 은 각각의 문자에 일대일 대응되는 '유니코드 크기 값' 을 의미합니다. 예를 들어, 문자는 `$` 는 유니코드 크기 값이 `U+0024` 에 해당합니다.

[^escaping]: 여기서 'escaping' 할 필요 없다는 말은 '역 빗금 (backslash; `\`)' 기호를 붙일 필요가 없다는 것을 의미합니다.

[^number-sign]: '#' 은 영어로 'number sign' 이라고 하는데, 보통 우리 말로는 '샾 기호' 라고 알려져 있습니다. 하지만 실제 샾 기호와는 다르며 하나의 숫자를 의미합니다. 여기서는 '번호 기호' 라고 옮기도록 합니다.

[^value-type]: '값 타입 (value type)' 이라는 말은, 프로그래밍 용어에서 '깊은 복사' 와 '옅은 복사' 라는 말이 있는데, 이 중에서 복사 시의 기본 동작이 '깊은 복사' 인 타입이라고 이해할 수 있습니다.

[^optimize-string]: 이 말은 기본적으로 `String` 은 '깊은 복사' 를 하지만, 만약 전달받은 `String` 이 상수라면, 어차피 값이 바뀌지 않으므로 최적화에 의해, 실제 복사를 안할 수도 있다는 말입니다. 하지만 이런 경우에라도 밖에서 보는 작동 방식은 동일하므로, 개발자는 `String` 이 마치 계속 '복사 (copy)' 된다고 이해하고 사용해도 문제가 없습니다.

[^annotation]: '주석' 은 프로그래밍 분야에서 'comment' 를 의미하므로, 'annotation' 을 '보조 설명' 이라고 옮깁니다. 스위프트의 '타입 보조 설명 (type annotation)' 은 `let a: Int = 10` 에서 타입을 지정하는 `Int` 를 말하는 것입니다.

[^extended-grapheme-cluster]: 하나의 문자가 '자소 덩어리' 라는 말은, `가` 라는 하나의 문자가 `ㄱ` 과 `ㅏ` 라는 자소들의 덩어리로 이루어졌다는 것을 의미합니다. '확장된 자소 덩어리' 에 대한 개념은 좀 더 아래의 본문에 `한` 이라는 글자로 설명되어 있습니다.

[^locale-sensitive]: '지역에-민감 (locale-sensitive)' 하다는 말은, [로케일이란 개념](http://apple-document.50megs.com/apple_tech_document/documentation/CoreFoundation/Conceptual/CFLocales/Articles/CFLocaleConcepts.html) 항목에 따르면, 비교 연산을 수행하기 위해 '지역 정보 (locale) 객체' 를 요구하는 것을 말한다고 합니다. 보다 자세한 내용은 해당 링크의 내용을 참고하기 바랍니다.

[^line-feed]: 스위프트 (라기 보다는 애플 운영체제) 에서 '줄 먹임 (line feed)', '줄 끊음 (line break)', '새 줄 (new line; 개행)' 문자는 셋 다 똑같은 의미를 가지고 있습니다. 이에 대해서는 [Lexical Structure (어휘 구조)]({% post_url 2020-07-28-Lexical-Structure %}) 의 [String Literals (문자열 글자 값)]({% post_url 2020-07-28-Lexical-Structure %}#string-literals-문자열-글자-값) 부분에서 좀 더 자세히 다루고 있습니다.

[^line-feed-escape-sequence]: '줄 먹임으로 벗어나도록 나열한 것 (line feed escape sequence)' 은 말 그대로 `\n` 문자열 자체를 의미합니다. `\n` 을 '줄 먹임' 문자로 인식하는 것이 아니라 `\` 과 `n` 문자가 나열된 것으로 인식한다는 의미입니다.

[^Foundation]: 'Foundation (기반)' 은 모든 스위프트 프로그래밍에서 사용하는 기본 프레임웍으로 `import Foundation` 으로 불러옵니다. 이에 대한 더 자세한 내용은, 애플 문서의 [Foundation](https://developer.apple.com/documentation/foundation) 항목을 참고하기 바랍니다.

[^Cocoa]: 'Cocoa (코코아)' 는 'macOS' 를 위해 애플에서 만든 API 입니다. 하지만 현재 [Cocoa Fundamentals Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/WhatIsCocoa/WhatIsCocoa.html) 문서를 보면 '그만둔 문서 (Retired Document)' 라는 설명이 나옵니다. 최근 'M1' 을 사용한 맥을 발표했으므로, 'macOS' 도 'ARM' 기반이 될 것이라, 'Cocoa (코코아)' 의 비중은 더 줄어들 것입니다.

[^single-and-multiline]: 이 말은 예제에 있는 `singleLineString` 과 `multilineString` 이 사실상 같은 것이라는 의미입니다. `multilineString` 은 큰 따옴표 세 개를 사용했지만, 한-줄짜리 문자열만 담고 있으므로, 여기서는 두 문자열이 똑같은 상태입니다.

[^letter]: 이 책에서는 '문자' 를 'character' 와 'letter' 두 개의 단어로 사용하고 있는데, 엄밀하게 말해서 'character' 는 한자 같은 '표의 문자' 를, 'letter' 는 '표음 문자' 를 의미한다고 합니다. 하지만, 여기서는 둘 다 같은 '문자' 라고 옮기도록 합니다.

[^indexed-by-integer-values]: '정수 값으로 색인될 수 없다' 는 말은 `var myString: String` 이라는 값이 있을 때, `myString[3]` 처럼 정수 색인으로 '임의 접근 (random access)' 할 수 없다는 의미로 추측됩니다. 이어지는 설명을 볼 때, 스위프트의 `String` 은 '배열 (스위프트의 `Array` 컬렉션이 아닌 자료구조로써의 배열)' 이 아니라 '리스트 (역시 'SwiftUI' 의 리스트뷰가 아닌 자료구조로써의 리스트)' 로 구현되었음을 알 수 있습니다.

[^particular-index]: 여기서 사용하는 '첨자 연산 구문 표현' 은 '배열' 자료구조에서 사용하는 '임의 접근 (random access)' 과는 다른 것입니다. 항상 처음과 끝에서 시작해서 순차적으로 탐색해 가는 '리스트' 자료구조 처럼 동작하는 것입니다.

[^canonically]: '법적으로 (canonically)' 에서 'canon' 은 원래 '교회 법' 에서 유래한 단어입니다. 'canonically' 는 '표준적으로' 라고 옮길 수도 있는데, 이 역시 '교회 법' 이 하나의 '표준' 이기 때문에 유래한 의미입니다.

[^capulet]: '캐퓰렛 (Capulet)' 은 '로미오와 줄리엣' 에서 줄리엣의 성 (가문 이름) 입니다. 즉, 줄리엣의 본명이 '줄리엣 캐퓰렛' 입니다.

[^friar]: '로렌스 수사 (Friar Lawrence)' 는 '로미오와 줄리엣' 에서 마시면 잠시동안 죽는 듯한 약을 만든 사람입니다. 'friar' 는 '탁발 수사' 라는 의미로 '수도사' 중에서 수도원에 머무르지 않는 이들을 의미한다고 합니다.

[^16-bit-code-units]: '16-비트 코드 단위 (16-buit code units)' 가 무엇인지에 대해서는 아래의 [Unicode Representations of Strings (문자열의 유니코드 표현법)](#unicode-representations-of-strings-문자열의-유니코드-표현법) 부분을 참고하기 바랍니다.

[^surrogate-pair]: '대용 쌍 (surrogate pair)' 는 유니코드에서 16-비트로 값을 표현할 수 없는 문자들을 두 개의 16-비트 문자로 변환하여 한 쌍으로써 문자를 나타내는 방식을 말합니다. 보다 자세한 내용은 위키피디아의 [UTF-16 (영문)](https://en.wikipedia.org/wiki/UTF-16) 항목과 [UTF-16 (한글)](https://ko.wikipedia.org/wiki/UTF-16) 항목을 참고하기 바랍니다.
