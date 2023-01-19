---
layout: post
comments: true
title:  "Swift 5.7: Strings and Characters (문자열과 문자)"
date:   2016-05-29 19:45:00 +0900
categories: Swift Grammar Strings Characters
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [Strings and Characters](https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html) 부분[^Strings-and-Characters]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Strings and Characters (문자열과 문자)

_문자열 (string)_ 은, `"hello, world"` 나 `"albatross"` 같이, 연속한 문자들 입니다. 스위프트의 문자열은 `String` 타입으로 나타냅니다. `String` 의 내용물엔, `Character` 값의 집합체[^collection] 로도 포함하여, 다양한 방식으로 접근할 수 있습니다.

스위프트의 `String` 과 `Character` 타입은 코드에서, 빠르면서, 유니코드를-따르는[^unicode-compliant] 방식의 텍스트 작업을 제공합니다. 문자열 생성 및 조작 구문은 가볍고 쉽게 읽히며, 문자열 글자 값[^literals] 구문은 **C** 와 비슷합니다.[^string-literal-syntax] 문자열 이어붙이기[^concatenation] 는 `+` 연산자로 두 문자열을 조합할 정도로 간단하며, 문자열의 변경 가능성을 [^mutability] 관리하는 것도 상수나 변수 사이에 선택만 하면 되어, 그냥 스위프트의 다른 어떤 값인 것처럼 하면 됩니다. 문자열을 사용하여 상수와, 변수, 글자 값, 및 표현식을 더 긴 문자열 안에 집어 넣을 수도 있는데, 이 과정을 문자열 끼워넣기[^string-interpolation] 라고 합니다. 이는 자신만의 문자열 값을 보여주고, 저장하며, 인쇄하기 쉽게 생성하도록 합니다.

이렇게 구문이 단순함에도 불구하고, 스위프트의 `String` 타입은 빠르고, 최신인 문자열 구현입니다. 모든 문자열이 인코딩-독립적인 유니코드 문자[^encoding-independent-unicode-characters] 로 합성되어, 다양한 유니코드 표현법으로 그 문자들에 접근하는 걸 지원합니다.

> 스위프트의 `String` 타입은 **Foundation**[^Foundation] 의 `NSString` 클래스와 연동되어 있습니다. **Foundation** 은 `String` 도 확장하여 `NSString` 이 정의한 메소드도 드러냅니다. 이것은, **Foundation** 을 불러 오면, 타입 변환 없이 `String` 에서 `NSString` 메소드에 접근할 수 있다는 걸 의미합니다.
>
> `String` 을 **Foundation** 및 **Cocoa**[^Cocoa] 와 사용하기 위한 더 많은 정보는, [Bridging Between String and NSString](https://developer.apple.com/documentation/swift/string#2919514) 항목을 보기 바랍니다.

### String Literals (문자열 글자 값)

미리 정의한 `String` 값을 _문자열 글자 값 (string literals)_ 으로 코드 안에 포함할 수 있습니다. 문자열 글자 값은 일렬로 나열된 문자들을 큰 따옴표 (`"`) 로 둘러싼 겁니다.

문자열 글자 값은 상수나 변수의 초기 값으로 사용합니다:

```swift
let someString = "Some string literal value"
```

스위프트가 `someString` 상수를 `String` 타입으로 추론하는 건 문자열 글자 값으로 초기화하기 때문이라는 걸 기록하기 바랍니다.

#### Multiline String Literals (여러 줄짜리 문자열 글자 값)

여러 줄에 걸친 문자열이 필요하면, 여러 줄짜리 문자열 글자 값을 쓰는데-이는 일렬로 나열된 문자들을 세 개의 큰 따옴표로 둘러싼 겁니다:

```swift
let quotation = """
The White Rabbit put on his spectacles. "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""
```

여러 줄짜리 문자열 글자 값은 열고 닫는 따옴표 사이의 모든 줄을 포함합니다. 문자열은 여는 따옴표 (`"""`) 뒤의 첫째 줄에서 시작하고 닫는 따옴표 앞 줄에서 끝나는데, 이는 아래의 어느 문자열도 줄 끊음[^line-break] (문자)로 시작하거나 끝나지 않는다는 의미입니다:[^single-and-multiline]

```swift
let singleLineString = "These are the same."
let multilineString = """
These are the same.
"""
```

소스 코드의 여러 줄짜리 문자열 글자 값이 줄 끊음을 포함할 땐, 그 줄 끊음이 문자열 값에 나타납니다. 줄 끊음으로 소스 코드를 읽기 쉽게 하고 싶지만, 줄 끊음이 문자열 값의 일부가 되는게 싫다면, 그 줄 끝에 역 빅금 (`\`) 을 씁니다:[^backslash]

```swift
let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""
```

여러 줄짜리 문자열 글자 값이 줄 먹임[^line-feed] (문자)로 시작하거나 끝나게 하려면, 첫 번째나 마지막 줄에 텅 빈 줄을 작성합니다. 예를 들면 다음과 같습니다:

```swift
let lineBreaks = """

This string starts with a line break.
It also ends with a line break.

"""
```

여러 줄짜리 문자열은 들여쓰기해서 주위 코드와 맞출 수 있습니다. 닫는 따옴표 (`"""`) 앞의 공백은 다른 모든 줄 앞에 무시할 공백이 뭔지를 스위프트에게 말합니다. 하지만, 닫는 따옴표 앞의 것에 더해 줄 앞에 (또) 공백을 작성하면, 그 공백 _은 (is)_ 포함됩니다.

![Indentation](/assets/Swift/Swift-Programming-Language/Strings-and-Characters-indent.jpg)

위 예제에선, 여러 줄짜리 문자열 글자 값 전체에 들여쓰기가 있더라도, 문자열의 첫 번째와 마지막 줄은 공백으로 시작하지 않습니다. 중간 줄은 닫는 따옴표 (줄)보다 더 들여 썼으므로, 그 부가적인 네-칸 들여쓰기로 시작합니다.

#### Special Characters in String Literals (문자열 글자 값 안의 특수 문자)

문자열 글자 값은 다음 특수 문자들을 포함할 수 있습니다:

* (의미를) 벗어난[^escaped] 특수 문자인 `\0` (널 문자), `\\` (역 빗금), `\t` (가로 탭), `\n` (줄 먹임), `\r` (캐리지 반환)[^carriage], `\"` (큰 따옴표) 및 `\'` (작은 따옴표)
* `\u{`_n_`}` 라고 쓰는, 임의의 유니코드 크기 값[^scalar], 여기서 _n_ 은 1-8 숫자의 16진수 (유니코드는 아래의 [Unicode (유니코드)](#unicode-유니코드) 부분에서 논의함)

아래 코드는 이러한 특수 문자의 네 가지 예를 보여줍니다. `wiseWords` 상수는 벗어난 두 개의 큰 따옴표를 담고 있습니다. `dollarSign` 과, `blackHeart`, 및 `sparklingHeart` 상수는 유니코드 크기 값 양식을 실제로 보여줍니다:

```swift
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imagination is more important than knowledge" - Einstein
let dollarSign = "\u{24}"         // $, 유니코드 크기 값 U+0024
let blackHeart = "\u{2665}"       // ♥, 유니코드 크기 값 U+2665
let sparklingHeart = "\u{1F496}"  // 💖, 유니코드 크기 값 U+1F496
```

여러 줄짜리 문자열 글자 값은 한 개 대신 세 개의 큰 따옴표를 쓰기 때문에, 벗어나게[^escaping] 하지 않고도 여러 줄짜리 문자열 글자 값 안에 큰 따옴표 (`"`) 를 포함할 수 있습니다. 여러 줄짜리 문자열이 `"""` 를 텍스트로 포함하려면, 적어도 한 따옴표는 벗어나게 해야 합니다. 예를 들면 다음과 같습니다:

```swift
let threeDoubleQuotationMarks = """
Escaping the first quotation mark \"""
Escaping all three quotation mark \"\"\"
"""
```

#### Extended String Delimiters (확장한 문자열 구분자)

_확장 구분자 (extended delimiters)_ 안에 문자열 글자 값을 두면 그 효과를 불러내지 않고도 문자열 안에 특수 문자를 포함시킬 수 있습니다. 따옴표 (`"`) 안에 문자열을 두고 그걸 번호 기호 (`#`)[^number-sign] 로 둘러쌉니다. 예를 들어, 문자열 글자 값 `#"Line 1\nLine 2"#` 을 인쇄하면 두 줄에 걸쳐 문자열을 인쇄하기 보단 (벗어난) 줄 먹임 시퀀스 (`\n`)[^line-feed-escape-sequence] 자체를 인쇄합니다.

문자열 글자 값 안에서 특수 문자의 효과가 필요하면, 벗어남 문자 (`\`) 뒤에 있는 문자열에서 번호 기호의 개수를 맞추면 됩니다. 예를 들어, `#"Line 1\nLine 2"#` 라는 문자열에서 줄을 끊고 싶으면, 그 대신 `#"Line 1\#nLine 2"#` 이라고 쓸 수 있습니다. 이와 비슷하게, `###"Line 1\###nLine 2"###` 도 줄을 끊습니다.

확장 구분자로 생성한 문자열 글자 값이 여러 줄짜리 문자열 글자 값일 수도 있습니다. 확장 구분자를 사용하면 여러 줄짜리 문자열 안에 `"""` 를 텍스트로 포함시킬 수 있어, 글자 값을 끝낸다는 기본 동작을 재정의하게 됩니다. 예를 들면 다음과 같습니다:

```swift
let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#
```

### Initializing an Empty String (빈 문자열 초기화하기)

빈 `String` 값을 시작점으로 생성하여 더 긴 문자열을 제작하려면, 변수에 빈 문자열 글자 값을 할당하거나, 초기화 구문으로 새로운 `String` 인스턴스를 초기화합니다:

```swift
var emptyString = ""                // 빈 문자열 글자 값
var anotherEmptyString = String()   // 초기화 구문
// 이 두 문자열은 둘 다 비어 있으며, 서로 같은 겁니다.
```

`String` 값이 비었는지 알아내려면 `isEmpty` 불리언 속성을 검사합니다:

```swift
if emptyString.isEmpty {
  print("Nothing to see here")
}
// "Nothing to see here" 를 인쇄함
```

### String Mutability (문자열 변경 가능성)

한 특별한 `String` 이 수정 (또는 _변경-mutated_) 될 수 있는건지 지시하려면 (수정할 수 있는 거면) 변수에, (수정할 수 없는 거면) 상수에 할당하면 됩니다:

```swift
var variableString = "Horse"
variableString += " and carriage"
// variableString 은 이제 "Horse and carriage" 임

let constantString = "Highlander"
constantString += " and another Highlander"
// 이는 컴파일-시간 에러를 보고함 - 상수 문자열을 수정할 순 없음
```

> 이 접근법은 **오브젝티브-C** 및 **Cocoa** 의 문자열 변경과는 다른데, 여기선 (`NSString` 과 `NSMutableString` 이라는) 두 클래스 중 하나를 선택하여 문자열이 변경될 수 있는 건지를 지시합니다.

### Strings Are Value Types (문자열은 값 타입입니다)

스위프트의 `String` 타입은 _값 타입 (value type)_[^value-type] 입니다. 새로운 `String` 값을 생성하면, 그 `String` 을 함수나 메소드에 전달할 때나, 상수나 변수에 할당할 때, 값을 _복사 (copied)_ 합니다. 각각의 경우마다, 기존 `String` 값의 새 복사본을 생성하여, 원본 버전이 아니라, 새 복사본을 전달하거나 할당합니다. 값 타입은 [Structure and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)]({% post_url 2020-04-14-Structures-and-Classes %}#structures-and-enumerations-are-value-types-구조체와-열거체는-값-타입입니다) 에서 설명합니다.

스위프트의 복사-기본 `String` 동작은 함수나 메소드가 `String` 값을 전달할 때, 그게 어디서 왔든 상관없이, 정확한 `String` 값을 소유하는게 명확하도록 보장합니다. 자신이 직접 수정하지 않는 한 전달받은 문자열이 수정되지 않을 거라는 걸 자신할 수 있습니다.

그 속을 보면, 스위프트 컴파일러가 문자열 사용을 최적화하므로 실제 복사는 절대적으로 꼭 필요할 때만 일어납니다.[^optimize-string] 이는 문자열 작업을 값 타입으로 할 땐 항상 아주 뛰어난 성능을 가진다는 의미입니다.

### Working with Characters (문자 작업하기)

`String` 의 개별 `Character` 값에 접근하려면 `for-in` 반복문으로 문자열을 반복하면 됩니다:

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

대안으로, 단일-문자 글자 값으로 (홀로-선) 독립 `Character` 상수나 변수를 생성하려면 `Character` 타입 보조 설명[^annotation] 을 제공하면 됩나다:

```swift
let exclamationMark: Character = "!"
```

`Character` 값 배열을 초기자의 인자로 전달하여 `String` 값을 생성할 수도 있습니다:

```swift
let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)
print(catString)
// "Cat!🐱" 을 인쇄함
```

### Concatenating Strings and Characters (문자열과 문자 이어붙이기)

덧셈 연산자 (`+`) 로 `String` 값을 서로 더하(거나 _이어붙여 (concatenated)_ 서) 새로운 `String` 값을 생성할 수 있습니다:

```swift
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2
// welcome 은 이제 "hello there" 와 같음
```

덧셈 할당 연산자 (`+=`) 로 기존 `String` 변수에 `String` 값을 덧붙일 수도 있습니다:

```swift
var instruction = "look over"
instruction += string2
// instruction 은 이제 "look over there" 와 같음
```

`String` 타입의 `append()` 메소드로는 `String` 변수에 `Character` 값을 덧붙일 수 있습니다:

```swift
let exclamationMark: Character = "!"
welcome.append(exclamationMark)
// welcome 은 이제 "hello there!" 와 같음
```

> `String` 이나 `Character` 를 기존 `Character` 변수에 덧붙일 순 없는데, `Character` 값은 반드시 단일 문자만 담아야 하기 때문입니다.

여러 줄짜리 문자열 글자 값을 써서 더 긴 문자열 줄을 제작한다면, 마지막 줄을 포함한, 모든 문자열 줄이 줄 끊음으로 끝나게 하고 싶을 겁니다. 예를 들면 다음과 같습니다:

```swift
let badStart = """
one
two
"""

let end = """
three
"""

print(badStart + end)
// 두 줄로 인쇄함:
// one
// twothree

let goodStart = """
one
two

"""

print(goodStart + end)
// 세 줄로 인쇄함:
// one
// two
// three
```

위 코드에서, `badStart` 와 `end` 를 이어붙이면 두-줄짜리 문자열을 만들어 내는데, 이는 원하는 결과가 아닙니다. `badStart` 의 마지막 줄이 줄 끊음으로 끝나지 않기 때문에, 그 줄이 `end` 의 첫 번째 줄과 뭉쳐집니다. 이와 대조하여, `goodStart` 는 두 줄 모두 줄 끊음으로 끝나서, `end` 와 조합할 때의 결과가, 예상대로, 세 줄입니다.

### String Interpolation (문자열 끼워 넣기)

_문자열 끼워 넣기 (string interpolation)_ 는 문자열 글자 값 안에 상수와, 변수, 글자 값, 및 표현식을 섞어서 포함하여 새로운 `String` 값을 생성하는 방법입니다. 문자열 끼워 넣기는 한-줄짜리 및 여러 줄짜리 문자열 글자 값 둘 다에서 사용할 수 있습니다. 문자열 글자 값에 집어 넣을 각 항목은 한 쌍의 괄호로 포장한 후, 접두사로 역 빗금 (`\`) 을 둡니다:

```swift
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// message 는 "3 times 2.5 is 7.5" 임
```

위 예제에선, `\(multiplier)` 로 `multiplier` 값을 문자열 글자 값에 집어 넣습니다. 이 자리 표시자는 문자열 끼어 넣기를 평가하여 실제 문자열을 생성할 때 실제 `multiplier` 값으로 교체됩니다.

`multiplier` 값은 문자열 더 나중에 있는 더 큰 표현식[^larger-expression] 의 일부이기도 합니다. 이 표현식은 `Double(multiplier) * 2.5` 값을 계산하여 결과인 (`7.5`) 를 문자열에 집어 넣습니다. 이 경우, 문자열 글자 값 안에 표현식을 포함할 때 `\(Double(multiplier) * 2.5)` 라고 씁니다.

확장한 문자열 구분자[^extended-string-delimiters] 로 문자열을 생성하면 문자열 끼워 넣기로 취급했을 문자를 담을 수 있습니다. 예를 들면 다음과 같습니다:

```swift
print(#"Write an interpolated string in Swift using \(multiplier)."#)
// "Write an interpolated string in Swift using \(multiplier)." 를 인쇄함
```

확장 구분자를 쓴 문자열 안에서 문자열 끼워 넣기를 사용하려면, 역 빗금 뒤의 번호 기호 개수를 문자열 시작 및 끝에 있는 번호 기호 개수와 맞춥니다. 예를 들면 다음과 같습니다:

```swift
print(#"6 times 7 is \#(6 * 7)."#)
// "6 times 7 is 42." 를 인쇄함
```

> 끼워 넣을 문자열의 괄호 안에 쓴 표현식은 벗어나지 않는 역 빗금 (`\`) 이나, 캐리지 반환 (`\r`), 또는 줄 먹임 (`\n`) 을 담을 수 없습니다. 하지만, 다른 문자열 글자 값은 담을 수 있습니다.

### Unicode (유니코드)

_유니코드 (Unicode)_ 는 서로 다른 문자 체계에서 텍스트를 인코딩[^encoding] 하고, 나타내며, 가공하는 국제 표준입니다. 이는 어떤 언어든 거의 대부분의 문자를 표준 형식으로 나타낼 수 있게 하며, 텍스트 파일이나 웹 페이지 같은 외부 소스에서 그 문자를 읽고 쓸 수 있게 합니다. 이 절에서 설명하듯, 스위프트의 `String` 과 `Character` 타입 전체가 유니코드를-따릅니다.

#### Unicode Scalar Values (유니코드 크기 값)

그 속을 보면, 스위프트 고유의 `String` 타입은 _유니코드 크기 값 (Unicode scalar values)_ 으로 제작합니다. 유니코드 크기 값은 하나의 문자나 수정자[^modifier] 를 위한 유일한 21-비트 수치 값으로, `LATIN SMALL LETTER A` (`"a"`) 를 위한 `U+0061` 나, `FRONT-FACING BABY CHICK` (`"🐥"`) 을 위한 `U+1F425` 같은 겁니다.

모든 21-비트 유니코드 크기 값에 문자가 할당된 건 아니라는 걸 기록하기 바랍니다-일부 크기 값은 미래의 할당이나 **UTF-16** 인코딩 용으로 예약되어 있습니다. 문자가 할당된 크기 값엔 이름도 있는게 전형적인데, 위 예제에서 `LATIN SMALL LETTER A` 와 `FRONT-FACING BABY CHICK` 같은 겁니다.

#### Extended Grapheme Clusters (확장 자소 덩어리)

스위프트의 모든 `Character` 타입 인스턴스는 단일한 _확장 자소 덩어리 (extended grapheme cluster)_ 를 나타냅니다.[^grapheme-cluster] 확장 자소 덩어리는 일렬로 나열된 하나 이상의 유니코드 크기 값들로 (조합할 땐) 사람이-읽을 수 있는 단일 문자를 만들어 냅니다.

한 예는 이렇습니다. `é` 라는 글자[^letter] 는 단일 유니코드 크기 값 `é` (`LATIN SMALL LETTER E WITH ACUTE`, 또는 `U+00E9`) 로 나타낼 수 있습니다. 하지만, 똑같은 글자를 한  _쌍 (pair)_ 의 크기 값으로 나타낼 수도 있는데-표준 글자 `e` (`LATIN SMALL LETTER E`, 또는 `U+0065`) 와, 그 뒤의 `COMBINING ACUTE ACCENT` 크기 값 (`U+0301`)이 그것입니다. `COMBINING ACUTE ACCENT` 크기 값은 그 앞에 있는 크기 값에 시각적으로 적용하여, 유니코드-인식 텍스트-그리기 시스템이 `e` 를 `é` 로 바꿔 그리게 합니다.

두 경우 모두, 확장 자소 덩어리를 나타내는 단일 스위프트 `Character` 값으로 글자 `é` 를 나타냅니다. 첫 번째 경우엔, 덩어리에 단일 크기 값이 담겨 있으며; 두 번째 경우엔, 두 크기 값의 덩어리 입니다:

```swift
let eAcute: Character = "\u{E9}"                // é
let combinedEAcute: Character = "\u{65}\u{301}" // e 와 그 뒤의  ́
// eAcute 는 é 이고, combinedEAcute 도 é 임
```

확장 자소 덩어리는 쓰기 복잡한 수많은 문자들을 단일 `Character` 값으로 나타내는 유연한 방식입니다. 예를 들어, 대한민국의 한글 음절은 완성형 또는 조합형 시퀀스[^precomposed-decomposed-sequence] 로 나타낼 수 있습니다. 이 두 표현법 모두 스위프트에선 단일 `Character` 값으로 자격이 있습니다:

```swift
let precomposed: Character = "\u{D55C}"                 // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"  // ᄒ, ᅡ, ᆫ
// precomposed 는 '한' 이고, decomposed 도 '한' 임
```

확장 자소 덩어리는 (`COMBINING ENCLOSING CIRCLE`, 또는 `U+20DD` 같은) 테두리 표시 크기 값으로 단일 `Character` 값 부분의 다른 유니코드 크기 값들에 테두리를 칠 수 있게 합니다:

```swift
let enclosedEAcute: Character = "\u{E9}\u{20DD}"
// enclosedEAcute 은 é⃝ 임 
```

지역 지시 기호[^regional-indicator-symbols] 를 위한 유니코드 크기 값을 쌍으로 조합하여 단일 `Character` 값을 만들 수 있는데, `REGIONAL INDICATOR SYMBOL LETTER U (U+1F1FA)` 와 `REGIONAL INDICATOR SYMBOL LETTER S (U+1F1F8)` 를 조합하면 다음과 같습니다:

```swift
let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
// regionalIndicatorForUS 은 🇺🇸 임
```

### Counting Characters (문자 개수 세기)

문자열에서 `Character` 값의 개수를 가져오려면, 문자열의 `count` 속성을 사용합니다:

```swift
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")
// "unusualMenagerie has 40 characters" 를 인쇄함
```

스위프트가 `Character` 값에 확장 자소 덩어리를 사용한다는 건 문자열 이어붙이기와 수정이 문자열의 문자 개수에 영향을 항상 주진 않는다는 의미라는 걸 기록하기 바랍니다.

예를 들어, 새 문자열을 `cafe` 라는 네-글자 단어로 초기화한 다음, 문자열 끝에 `COMBINING ACUTE ACCENT` (`U+0301`) 를 덧붙이면, 결과 문자열엔 여전히 `4` 개의 문자가 있으며, 네 번재 문자는, `e` 가 아닌, `é` 가 됩니다:

```swift
var word = "cafe"
print("the number of characters in \(word) is \(word.characters.count)")
// "the number of characters in cafe is 4" 를 인쇄함

word += "\u{301}"       // COMBINING ACUTE ACCENT, U+0301

print("the number of characters in \(word) is \(word.characters.count)")
// "the number of characters in café is 4" 를 인쇄함
```

> 확장 자소 덩어리는 여러 개의 유니코드 크기 값들로 합성될 수 있습니다. 이는 서로 다른 문자들-및 똑같은 문자의 서로 다른 표현법들-이 서로 다른 메모리 저장량을 요구할 수 있다는 의미입니다. 이 때문에, 스위프트의 문자는 한 문자열 표현법 안에서 각각이 똑같은 메모리량을 차지하지 않습니다. 그 결과, 문자열 안의 문자 개수는 문자열 전체를 반복해서 확장 자소 덩어리의 경계를 결정하지 않고는 계산할 수 없습니다. 특히 더 긴 문자열 값과 작업한다면, `count` 속성이 그 문자열의 문자를 결정하기 위해선 반드시 전체 문자열의 유니코드 크기 값들을 반복해야 한다는 걸 인식하기 바랍니다.
>
> `count` 속성이 반환한 문자 개수와 동일 문자를 담은 `NSString` 의 `length` 속성이 항상 똑같은 건 아닙니다. `NSString` 의 길이는 문자열의 **UTF-16** 표현법 안의 16-비트 코드 단위[^16-bit-code-units] 개수를 기반으로 한 것이지 문자열 안의 유니코드 확장 자소 덩어리 개수가 아닙니다.

### Accessing and Modifying a String (문자열 접근하기와 수정하기)

문자열의 접근과 수정은 메소드와 속성을 통하거나, 첨자 구문을 사용해서 합니다.

#### String Indices (문자열 색인)

각각의 `String` 값엔 결합된 _색인 타입 (index type)_ 인, `String.Index` 가 있는데, 이는 문자열 안의 각 `Character` 위치에 해당합니다.

위에서 언급하듯, 서로 다른 문자마다 서로 다른 메모리 저장량을 요구할 수 있어서, 어느 한 특별한 위치에 있는 `Character` 를 결정하기 위해선, 반드시 각각의 유니코드 크기 값을 그 `String` 의 처음부터 끝까지 반복해야 합니다. 이런 이유로, 스위프트 문자열은 정수 값으로 색인할 수 없습니다.[^indexed-by-integer-values]

`startIndex` 속성을 쓰면 `String` 의 첫 번째 `Character` 위치에 접근합니다. `endIndex` 속성은 `String` 의 마지막 문자 뒤의 위치입니다. 그 결과, `endIndex` 속성은 문자열 첨자로 유효한 인자는 아닙니다. 빈 `String` 이면, `startIndex` 와 `endIndex` 가 같습니다.

주어진 색인의 앞과 뒤 색인에 접근하는데는 `String` 의 `index(before:)` 와 `index(after:)` 메소드를 사용합니다. 주어진 색인에서 더 멀리 떨어진 색인에 접근하려면, 이러한 메소드를 여러 번 호출하는 대신 `index(_:offsetBy:)` 메소드를 사용할 수 있습니다.

첨자 구문을 사용하면 한 특별한 `String` 색인의 `Character` 에 접근할 수 있습니다.[^subscript-syntax]

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

문자열 범위 밖의 색인이나 문자열 범위 밖 색인의 `Character` 에 접근하려 하면 실행 시간 에러를 발생시킬 겁니다.

```swift
// greeting[greeting.endIndex]  // 에러
// greeting.index(after: greeting.endIndex) // 에러
```

`indices` 속성을 사용하면 문자열 안에 있는 모든 개별 문자의 색인에 접근합니다.

```swift
for index in greeting.indices {
  print("\(greeting[index]) ", terminator: "")
}
// "G u t e n   T a g ! " 을 인쇄함
```

> `Collection` 프로토콜을 준수한 어떤 타입이든 `startIndex` 와 `endIndex` 속성 및 `index(before:)` 와, `index(after:)`, 및 `index(_:offsetBy:)` 메소드를 사용할 수 있습니다. 이는, 여기서 본, `String` 뿐만 아니라, `Array` 와, `Dictionary`, 및 `Set` 같은 집합체 타입[^collection] 도 포함합니다.

#### Inserting and Removing (집어넣기와 제거하기)

문자열의 지정 색인 위치에 단일 문자를 집어 넣으려면, `insert(_:at:)` 메소드를 사용하고, 지정 색인 위치에 다른 문자열의 내용물을 집어 넣으려면, `insert(contentsOf:at:)` 메소드를 사용합니다.

```swift
var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
// welcome 은 이제 "hello!" 와 같음

welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
// welcome 은 이제 "hello there!" 와 같음
```

문자열에서 지정된 색인의 단일 문자를 제거하려면, `remove(at:)` 메소드를 사용하고, 지정된 범위의 하위 문자열을 제거하려면, `removeSubrange(_:)` 메소드를 사용합니다:

```swift
welcome.remove(at: welcome.index(before: welcome.endIndex))
// welcome 은 이제 "hello there" 와 같음

let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)
// welcome 은 이제 "hello" 와 같음
```

> `RangeReplaceableCollection` 프로토콜을 준수한 어떤 타입이든 `insert(_:at:)` 과, `insert(contentsOf:at:)`, `remove(at:)`, 및 `removeSubrange(_:)` 메소드를 사용할 수 있습니다. 이는, 여기서 본, `String` 뿐만 아니라, `Array` 와, `Dictionary`, 및 `Set` 같은 집합체 타입도 포함합니다.

### Substrings (하위 문자열)

문자열에서 하위 문자열을 가질 땐-예를 들어, 첨자나 `prefix(_:)` 같은 메소드를 쓸 땐-결과가, 또 다른 문자열이 아닌, [Substring](https://developer.apple.com/documentation/swift/substring) 인스턴스입니다. 스위프트의 하위 문자열엔 문자열과 거의 똑같은 메소드가 있는데, 이는 하위 문자열 작업을 문자열 작업과 똑같은 방식으로 할 수 있다는 의미입니다. 하지만, 문자열과 달리, 문자열의 행동을 수행할 짧은 시간 동안만 하위 문자열을 사용합니다. 결과를 더 긴 시간 저장할 준비가 됐을 땐, 하위 문자열을 `String` 인스턴스로 변환합니다. 예를 들면, 다음과 같습니다:

```swift
let greeting = "Hello, world!"
let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]
// beginning 은 "Hello" 임

// 결과를 String 으로 변환하여 긴-기간 저장하도록 함
let newString = String(beginning)
```

문자열 같이, 각각의 하위 문자열엔 하위 문자열을 이룬 문자를 저장한 메모리 영역이 있습니다. 문자열과 하위 문자열이 다른 건, 성능 최적화로, 원본 문자열을 저장하는데 사용한 일부의 메모리나, 또 다른 하위 문자열을 저장하는데 사용한 일부의 메모리를 하위 문자열이 재사용할 수 있다는 겁니다. (문자열도 비슷한 최적화를 하지만, 두 문자열이 메모리를 공유한다면, 이들은 같은 겁니다.) 이런 성능 최적화가 의미하는 건 문자열 또는 하위 문자열의 수정 전까진 메모리를 복사하는데 드는 비용을 지불하지 않아도 된다는 겁니다. 위에서 언급했듯, 하위 문자열은 긴-기간 저장하는데는 적합하지 않은데-원본 문자열의 저장 공간을 재사용하기 때문에, 자신의 하위 문자열 어떤 것이든 사용하는 한 반드시 전체 원본 문자열을 메모리에 유지해야 하기 때문입니다.

위 예제에서, `greeting` 은 문자열인데, 이는 메모리 영역에 문자열을 이루는 문자들을 저장한다는 의미입니다. `beginning` 은 `greeting` 의 하위 문자열이기 때문에, `greeting` 이 사용한 메모리를 재사용합니다. 이와 대조하여, `newString` 은 문자열이라-하위 문자열로 생성할 때, 자신만의 저장 공간을 가집니다. 아래 그림은 이러한 관계를 보여줍니다:

![Indentation](/assets/Swift/Swift-Programming-Language/Strings-and-Characters-substrings.jpg)

> `String` 과 `Substring` 은 둘 다 [StringProtocol](https://developer.apple.com/documentation/swift/stringprotocol) 프로토콜을 준수하는데, 이는 문자열 조작 함수가 `StringProtocol` 값을 받는게 편리할 때가 자주 있다는 의미입니다. 그런 함수는 `String` 및 `Substring` 값 어느 것으로도 호출할 수 있습니다.

### Comparing Strings (문자열 비교하기)

스위프트는 글로 된 값을 비교하는 세 가지 방식을 제공하는데: 문자열 및 문자 같음과, 접두사 같음, 및 접미사 같음이 그것입니다.

#### String and Character Equality (문자열 및 문자 같음)

문자열 및 문자 같음은 "같음 (equal to)" 연산자 (`==`) 와 "같지 않음 (not equal to)" 연산자 (`!=`) 로 검사하며, [Comparison Operators (비교 연산자)]({% post_url 2016-04-27-Basic-Operators %}#comparison-operators-비교-연산자) 에서 설명합니다:

```swift
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
  print("These two strings are considered equal")
}
// "These two strings are considered equal." 을 인쇄함
```

두 `String` 값 (또는 두 `Character` 값) 들은 확장 자소 덩어리가 _법적으로 같다고 볼 수 있는 (canonically equivalent)_[^canonically] 거면 같다고 고려합니다. 확장 자소 덩어리가, 그 속은 서로 다른 유니코드 크기 값으로 합성한 경우라도, 언어의 의미와 나타난 모습이 똑같으면 법적으로 같은 겁니다.

예를 들어, `LATIN SMALL LETTER E WITH ACUTE` (`U+00E9`) 는 `LATIN SMALL LETTER E` (`U+0065`) 뒤에 `COMBINING ACUTE ACCENT` (`U+0301`) 가 있는 것과 법적으로 같은 겁니다. 이러한 확장 자소 덩어리는 둘 다 유효한 방식으로 문자 `é` 를 나타내서, 법적으로 같은 것으로 고려합니다:

```swift
// LATIN SMALL LETTER E WITH ACUTE 를 사용한 "Voulez-vous un café?"
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

// LATIN SMALL LETTER E 와 COMBINING ACUTE ACCENT 를 사용한 "Voulez-vous un café?"
let combinedEAccuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAccuteQuestion {
    print("These two strings are considered equal")
}
// "These two strings are considered equal" 를 인쇄함
```

거꾸로, `LATIN CAPITAL A` (`U+0041`, 또는 `"A"`), 라고 영어로 쓴 건, `CYRILLIC CAPITAL LETTER A` (`U+0410`, 또는 `"А"`), 라고 쓴 러시아어와 같다고 볼 수 _없습니다 (not)_. 문자가 비슷해 보이지만, 언어의 의미는 똑같지 않습니다:

```swift
let latinCapitalLetterA: Character = "\u{41}"

let cyrillicCapitalLetterA: Character = "\u{0410}"

if latinCapitalLetterA != cyrillicCapitalLetterA {
  print("These two characters are not equivalent")
}
// "These two characters are not equivalent" 를 인쇄함
```

> 스위프트의 문자열 및 문자 비교 연산은 지역에-민감[^locale-sensitive] 하지 않습니다.

#### Prefix and Suffix Equality (접두사 및 접미사 같음)

문자열에 한 특별한 문자열 접두사나 접미사가 있는지 검사하려면, 문자열의 `hasPrefix(_:)` 및 `hasSuffix(_:)` 메소드를 호출하는데, 이들은 둘 다 단일한 `String` 타입 인자를 취하고 불리언 값을 반환합니다.

아래 예제는 **셰익스피어** 의 _로미오와 줄리엣 (Romeo and Juliet)_ 첫 두 **막**[^acts] 의 **장**[^scene] (면) 위치를 나타내는 문자열 배열을 고려합니다:

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

`romeoAndJuliet` 배열에 `hasPrefix(_:)` 메소드를 사용하여 **희곡**[^play] 의 **제 1막** 에 있는 **장** (면) 개수를 셀 수 있습니다:

```swift
var act1SceneCount = 0

for scene in romeoAndJuliet {
  if scene.hasPrefix("Act 1") {
    act1SceneCount += 1
  }
}
print("There are \(act1SceneCount) scenes in Act 1")
// "There are 5 scenes in Act 1" 를 인쇄함
```

이와 비슷하게, `hasSuffix(_:)` 메소드로 **캐퓰렛 저택 (Capulet's mansion)**[^capulet] 과 **로렌스 수사의 작은 방 (Friar Lawrence's cell)**[^friar] 안과 그 주변에서 일어나는 **장** (면) 개수를 셀 수 있습니다:

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
// "6 mansion scenes; 2 cell scenes" 를 인쇄함
```

> [String and Character Equality (문자열 및 문자 같음)](#string-and-character-equality-문자열-및-문자-같음) 에서 설명했듯, `hasPrefix(_:)` 와 `hasSuffix(_:)` 메소드는 각 문자열의 확장 자소 덩어리 사이의 문자-마다 법적으로 같다고 볼 수 있는지 비교하는 연산을 합니다.

### Unicode Representations of Strings (문자열을 유니코드로 나타내는 법)

문서 파일이나 어떠한 다른 저장 공간에 유니코드 문자열을 쓸 땐, 그 문자열 안의 유니코드 크기 값을 유니코드에서-정의한 여러 가지 _인코딩 형식 (encording forms)_ 으로 인코딩 합니다. 각각의 형식은 문자열을 _코드 단위 (code units)_ 라는 작은 뭉치로 인코딩 합니다. 이는 (문자열을 8-비트 코드 단위로 인코딩 하는) **UTF-8** 인코딩 형식과, (문자열을 16-비트 코드 단위로 인코딩 하는) **UTF-16** 인코딩 형식, 및 (문자열을 32-비트 코드 단위로 인코딩 하는) **UTF-32** 인코딩 형식을 포함합니다.

스위프트는 유니코드로 나타낼 문자열에 여러 가지 서로 다른 접근 방식을 제공합니다. `for`-`in` 문으로 문자열을 반복하면, 개별 `Character` 값을 유니코드 확장 자소 덩어리로 접근할 수 있습니다. 이 과정은 [Working with Characters (문자 작업하기)](#working-with-characters-문자-작업하기) 에서 설명합니다.

대안으로, 유니코드를-따르는 세 개의 다른 방법으로 `String` 값에 접근합니다:

* **UTF-8** 코드 단위의 집합체 (문자열의 `utf8` 속성으로 접근함)
* **UTF-16** 코드 단위의 집합체 (문자열의 `utf16` 속성으로 접근함)
* 21-비트 유니코드 크기 값의 집합체, 문자열의 **UTF-32** 인코딩 형식과 같다고 볼 수 있음 (문자열의 `unicodeScalars` 속성으로 접근함)

아래의 각 예제는, 문자 `D` 와, `o`, `g`, (`DOUBLE EXCLAMATION MARK`, 또는 유니코드 크기 값 `U+203C` 인) `‼`, 및 (`DOG FACE`, 또는 유니코드 크기 값 `U+1F436` 인) `🐶` 문자로 이루어진, 다음 문자열을 서로 다르게 나타내는 법을 보여줍니다:

```swift
let dogString = "Dog!!🐶"
```

#### UTF-8 Representation (UTF-8 으로 나타내기)

`String` 을 **UTF-8** 으로 나타내게 접근하려면 `utf8` 속성을 반복하면 됩니다. 이 속성은 `String.UTF8View` 타입인데, 각각의 바이트가 문자열을 **UTF-8** 으로 나타낸 것인, 부호없는 8-비트 (`UInt8`) 값의 집합체입니다:

![UTF-8 representation](/assets/Swift/Swift-Programming-Language/Strings-and-Characters-UTF-8-representation.jpg)

```swift
for codeUnit in dogString.utf8 {
  print("\(codeUnit) ", terminator: "")
}
print("")
// "68 111 103 226 128 188 240 159 144 182 " 를 인쇄함
```

위 예제의, 첫 세 10진 `codeUnit` 값 (인 `68`, `111`, `103`) 은 `D` 와, `o`, 및 `g` 문자를 나타내며, 이렇게 **UTF-8** 로 나타낸 건 **ASCII** 로 나타낸 것과 똑같습니다. 그 다음 세 10진 `codeUnit` 값 (인 `226`, `128`, `188`) 은 `DOUBLE EXCLAMATION MARK` 문자를 세-바이트의 **UTF-8** 으로 나타낸 겁니다. 마지막 네 `codeUnit` 값 (인 `240`, `159`, `144`, `182`) 는 `DOG FACE` 문자를 네-바이트의 **UTF-8** 으로 나타낸 겁니다.

#### UTF-16 Representation (UTF-16 으로 나타내기)

`String` 을 **UTF-16** 으로 나타내게 접근하려면 `utf16` 속성을 반복하면 됩니다. 이 속성은 `String.UTF16View` 타입인데, 각각이 문자열을 **UTF-16** 로 나타낸 16-비트 코드 단위인, 부호없는 16-비트 (`UInt16`) 값의 집합체입니다:

![UTF-16 representation](/assets/Swift/Swift-Programming-Language/Strings-and-Characters-UTF-16-representation.jpg)

```swift
for codeUnit in dogString.utf16 {
  print("\(codeUnit) ", terminator: "")
}
print("")
// "68 111 103 8252 55357 56374 " 를 인쇄함
```

다시, 첫 세 `codeUnit` 값 (인 `68`, `111`, `103`) 은 `D` 와, `o`, 및 `g` 문자를 나타내며, 이러한 **UTF-16** 코드 단위들은 문자열을 **UTF-8** 로 나타낸 것과 값이 똑같습니다 (이 유니코드 크기 값들이 **ASCII** 문자를 나타내고 있기 때문입니다).

네 번째 `codeUnit` 값 (인 `8252`) 는 16진 값 `203C` 와 같다고 볼 수 있는 10진수로, `DOUBLE EXCLAMATION MARK` 문자의 유니코드 크기 값인 `U+203C` 를 나타냅니다. **UTF-16** 에선 이 문자를 단일 코드 단위로 나타낼 수 있습니다.

다섯 째와 여섯 째 `codeUnit` 값 (인 `55357` 와 `56374`) 는 `DOG FACE` 문자를 **UTF-16** 으로 나타낸 한 쌍의 대용품[^surrogate-pair] 입니다. 이 값들은 높은자리-대용품 값인 `U+D83D` (10진수론 `55357`) 과 낮은자리-대용품 값인 `U+DC36` (10진수론 `56374`) 입니다.

#### Unicode Scalar Representation (유니코드 크기 값으로 나타내기)

`String` 을 유니코드 크기 값으로 나타내게 접근하려면 `unicodeScalars` 속성을 반복하면 됩니다. 이 속성은 `UnicodeScalarView` 타입이며, `UnicodeScalar` 타입인 값들의 집합체입니다.

각각의 `UnicodeScalar` 엔 크기 값의 21-비트 값을 반환하는 `value` 속성이 있는데, `UInt32` 값으로 나타납니다:

![Unicode Scalar representation](/assets/Swift/Swift-Programming-Language/Strings-and-Characters-Unicode-scalar-representation.jpg)

```swift
for scalar in dogString.unicodeScalars {
  print("\(scalar.value) ", terminator: "")
}
print("")
// "68 111 103 8252 128054 " 를 인쇄함
```

첫 세 `UnicodeScalar` 값들의 `value` 속성 (인 `68`, `111`, `103`) 는 다시 한번 `D` 와, `o`, 및 `g` 문자를 나타냅니다.

네 번째 `codeUnit` 값 (인 `8252`) 는 다시 16진 값 `203C` 와 같다고 볼 수 있는 10진수로, `DOUBLE EXCLAMATION MARK` 문자의 유니코드 크기 값 `U+203C` 를 나타냅니다.

다섯 째이자 최종 `UnicodeScalar` 의 `value` 속성인, `128054` 는 16진 값 `1F436` 와 같다고 볼 수 있는 10진수로, `DOG FACE` 문자의 유니코드 크기 값 `U+1F436` 을 나타냅니다.

자신의 `value` 속성 조회의 대안으로, 문자열 끼워넣기에서 처럼, 각각의 `UnicodeScalar` 값을 써서 새로운 `String` 값을 생성할 수도 있습니다:

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

[^collection]: '집합체 (collection)' 에 대한 더 자세한 정보는, [Collection Types (집합체 타입)]({% post_url 2016-06-06-Collection-Types %}) 장을 참고하기 바랍니다.

[^literals]: '글자 값 (literals)' 은 실제 글자로 표현되는 값을 의미하며, `let a = 3.14` 에서는 `3.14` 라는 `Double` 값을 말하고, `let b = "hello"` 에서는 `"hello"` 라는 `String` 값을 말합니다. 즉, 글자 값의 타입은 그 값이 실제로 표현하는게 뭔지에 따라 추론됩니다. 글자 값에 대한 더 자세한 정보는, [Literals (글자 값)]({% post_url 2020-07-28-Lexical-Structure %}#literals-글자-값) 부분을 참고하기 바랍니다.

[^string-literal-syntax]: '문자열 글자 값 구문 (string literal syntax)' 이란 `let greeting = "hello"` 에서 `"hello"` 같은 구문을 말하며, 이게 **C** 언어와 비슷하는 의미입니다. 

[^concatenation]: '문자열 이어붙이기 (string concatenation)' 는 두 문자열을 합쳐서 하나의 문자열로 만드는 것을 말합니다. 이에 대한 더 자세한 내용은, [Concatenating Strings and Characters (문자열과 문자 이어붙이기)](#concatenating-strings-and-characters-문자열과-문자-이어붙이기) 부분을 참고하기 바랍니다.

[^string-interpolation]: '문자열 끼워넣기 (string interpolation)' 는 한 문자열 중간에 다른 문자열을 집어 넣는 방법을 말합니다. '끼워넣기 (interpolation)' 는 '보간법' 이라고도 하는데, 원래 수학 용어로 그래프 상에서 두 점 사이의 값을 근사적으로 구해서 채워넣는 방법을 말합니다. 이러한 방법을 문자열에도 적용했다고 이해하면 됩니다.

[^encoding-independent-unicode-characters]: 문자열이 인코딩-독립적인 유니코드 문자로 합성되었다는 건 `UTF-8`, `UTF-16` 등등에 상관없이 어떤 인코딩 방식으로도 문자열을 사용할 수 있게 만들어졌다는 의미입니다. 

[^Foundation]: **Foundation** 은 모든 스위프트 프로그래밍에서 사용하는 가장 기본적인 프레임웍입니다. 이에 대한 더 자세한 정보는, 애플 개발자 문서의 [Foundation](https://developer.apple.com/documentation/foundation) 항목을 참고하기 바랍니다.

[^Cocoa]: **Cocoa** 는 애플에서 만든 **macOS** 용 API 입니다. 하지만 현재 [Cocoa Fundamentals Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/WhatIsCocoa/WhatIsCocoa.html) 문서를 보면 '그만둔 문서 (Retired Document)' 라고 설명합니다. 애플에서 **M1** 맥북을 발표하는 등, **macOS** 도 **ARM** 기반이 되면서, **Cocoa** 의 비중은 계속 줄어들고 있습니다.

[^line-break]: 스위프트에서 '줄 끊음 (line break)' 문자는 사실상 '새 줄 (new line; `\n`)' 문자와 똑같습니다.

[^single-and-multiline]: 즉, 예제에 있는 `singleLineString` 과 `multilineString` 은 사실상 같은 문자열입니다. `multilineString` 은 세 개의 큰 따옴표를 사용한 문자열이지만, 실제로는 한-줄짜리 문자열과 똑같은 문자열을 담고 있습니다.

[^backslash]: 줄 끝에 '역 빗금 (backslash)' 문자가 있으면 그 다음 줄도 하나의 줄로 인식합니다.

[^line-feed]: 스위프트를 포함한 애플 운영체제에서, '줄 먹임 (line feed)', '줄 끊음 (line break)', '새 줄 (new line; 개행) 문자' 는 모두 똑같은 의미를 가집니다. 이 책에서도 세 단어를 구분없이 사용하는 경우가 종종 있습니다. 이에 대한 더 자세한 내용은, [Lexical Structure (어휘 구조)]({% post_url 2020-07-28-Lexical-Structure %}) 장의 [String Literals (문자열 글자 값)]({% post_url 2020-07-28-Lexical-Structure %}#string-literals-문자열-글자-값) 부분을 보도록 합니다.

[^escaped]: 'escape' 은 우리 말로 '벗어나다' 라는 의미인데, 프로그래밍 용어로 'escaped special characters' 라고 하면 '(본래의 의미를) 벗어나 다른 의미를 가지는 특수 문자' 입니다. 예를 들어, `n` 은 그냥 하나의 영어 문자이지만, `\n` 은 문자 본래의 의미를 벗어나서 `새로운 줄 (new line)` 이라는 의미를 가집니다. 이렇게 문자 앞에 '역 빗금 (backslash; `\`)' 를 붙여서 본래 의미를 벗어나 다른 의미를 가지게 한 문자를 '벗어난 문자 (escaped characters)' 라고 합니다.

[^carriage]: '캐리지 (carriage)' 는 원래 타자기에서 종이를 들고 움직이는 장치를 말합니다. 타자기에서 '캐리지 반환 (carriage return)' 은 이 캐리지를 다음 줄의 맨 앞으로 움직이는 동작이었습니다. 이것이 컴퓨터가 등장하면서 커서의 위치를 다음 줄의 맨 앞으로 움직이는 걸 의미하게 되었습니다.

[^scalar]: 'scalar' 는 원래 수학 용어로 '크기만을 가지는 값' 입니다. 여기서 'Unicode scalar value' 은 각각의 문자에 일대일 대응되는 '유니코드 크기 값' 을 의미합니다. 예를 들어, 문자는 `$` 는 유니코드 크기 값이 `U+0024` 에 해당합니다.

[^escaping]: 여기서 '벗어나게 (escaping)' 할 필요 없다는 말은 '역 빗금 (backslash; `\`)' 기호를 붙일 필요가 없다는 것을 의미합니다.

[^number-sign]: `#` 은 영어로는 '번호 기호 (number sign)' 라고 하는데, 우리 말로는 악보에 있는 올림표인 '샾 (sharp)' 과 비슷하게 생겨 샾 기호라고 많이 부릅니다. 하지만, 번호 기호는 실제로 샾 기호와는 유래부터 의미까지 모두 다른 것으로, 보통 임의의 숫자를 나타내는데 씁니다.

[^line-feed-escape-sequence]: '(벗어난) 줄 먹임 시퀀스 (line feed escape sequence)' 는 `\n` 문자열 그 자체를 의미합니다. `\n` 을 특수한 의미를 가진 단일 문자로 인식하는게 아니라 `\` 과 `n` 이라는 문자들의 시퀀스-즉, 일렬로 나열될 문자들-로 인식한다는 의미입니다.

[^value-type]: '값 타입 (value type)' 이라는 말은, 프로그래밍 용어에서 '깊은 복사' 와 '옅은 복사' 라는 말이 있는데, 이 중에서 복사 시의 기본 동작이 '깊은 복사' 인 타입이라고 이해할 수 있습니다.

[^optimize-string]: 이 말은 `String` 이 기본적으로는 '깊은 복사' 를 하지만, 만약 전달받은 `String` 이 상수라면, 어차피 값이 바뀌지 않으므로 최적화에 의해, 실제 복사를 안할 수도 있다는 말입니다. 하지만 이런 경우에라도 밖에서 보는 작동 방식은 동일하므로, 개발자는 `String` 이 마치 계속 '복사 (copy)' 된다고 이해하고 사용해도 문제가 없습니다.

[^annotation]: 프로그래밍 용어로 '주석 (comment)' 이란 단어를 이미 사용하고 있으므로, 타입 주석이라고 하지 않고 '타입 보조 설명 (type annotation)' 이라고 옮깁니다. 타입 보조 설명에 대한 더 자세한 정보는, [Type Annotations (타입 보조 설명)]({% post_url 2016-04-24-The-Basics %}#type-annotations-타입-보조-설명) 부분을 보도록 합니다. 

[^larger-expression]: `\(Double(multiplier) * 2.5)` 를 말합니다.

[^extended-string-delimiters]: '확장한 문자열 구분자 (Extended String Delimiters)' 에 대해서는 바로 위의 [Extended String Delimiters (확장한 문자열 구분자)](#extended-string-delimiters-확장한-문자열-구분자) 부분을 참고하기 바랍니다.

[^grapheme-cluster]: '자소 덩어리 (grapheme cluster)' 는, 예를 들어, `가` 라는 문자를 `ㄱ` 과 `ㅏ` 라는 자소가 합쳐진 하나의 자소 덩어리로 본다는 의미입니다. '확장 자소 덩어리 (extended grapheme cluster)' 는 이러한 자소 덩어리를 확장한 것을 말하는데, 이어지는 부분에서 더 자세히 설명합니다.

[^letter]: 엄밀하게 말하면, 영어로 'character' 는 한자 같은 표의 문자를, 'letter' 는 표음 문자를 의미한다고 합니다. 여기서는 각각을 '문자 (character)' 와 '글자 (letter)' 라고 옮깁니다. 

[^indexed-by-integer-values]: 예를 들어, `var myString: String` 이 있을 때, `myString[3]` 처럼 정수 색인을 써서 특정 문자에 임의 접근할 수 없다는 의미입니다.

[^subscript-syntax]: 여기서 사용하는 첨자 구문은, 배열에서 쓰는 임의 접근 방식이 아닌, 처음 또는 끝에서 시작해서 순차적으로 탐색하는 리스트 방식으로 동작합니다.

[^locale-sensitive]: '지역에 민감 (locale-sensitive) 하다' 는 건, 비교 연산을 위해 지역 정보 (locale) 객체를 요구하는 것을 의미합니다. 스위프트의 문자 비교 연산은 이러한 지역 정보 객체를 요구하지 않습니다. 이에 대한 더 자세한 정보는, [로케일이란 개념](http://apple-document.50megs.com/apple_tech_document/documentation/CoreFoundation/Conceptual/CFLocales/Articles/CFLocaleConcepts.html) 항목을 참고하기 바랍니다. (내용이 깨져 보일 때는 사파리의 **Text Encoding** 을 **Korean (Windows, DOS)** 로 설정해보기 바랍니다.)

[^canonically]: '법적으로 (canonically)' 에서 'canon' 은 원래 '교회 법' 에서 유래한 단어입니다. 'canonically' 를 '표준적으로' 라고 옮길 수도 있는데, 이 역시 교회 법이 하나의 표준 역할을 했기 때문에 가지게 된 의미입니다.

[^capulet]: '캐퓰렛 (Capulet)' 은 **로미오와 줄리엣** 에서 줄리엣의 가문 이름 (성) 입니다. 즉, 줄리엣의 본명은 줄리엣 캐퓰렛입니다.

[^friar]: '로렌스 수사 (Friar Lawrence)' 는 **로미오와 줄리엣** 에서 마시면 잠시 죽는 효과를 내는 약을 만든 사람입니다. '탁발 수사 (friar)' 는 수도사 중에서 수도원에 머무르지 않는 사람을 의미합니다.

[^16-bit-code-units]: '16-비트 코드 단위 (16-buit code units)' 에 대한 더 자세한 정보는, 본문 뒤의 [Unicode Representations of Strings (문자열을 유니코드로 나타내는 법)](#unicode-representations-of-strings-문자열을-유니코드로-나타내는-법) 부분을 참고하기 바랍니다.

[^surrogate-pair]: '한 쌍의 대용품 (surrogate pair)' 이란 유니코드에서 16-비트로 값을 표현할 수 없는 문자를 두 개의 16-비트 문자로 변환하여 한 쌍으로 문자를 나타내는 방식입니다. '한 쌍의 대용품 (surrogate pair)' 에 대한 더 자세한 내용은, 위키피디아의 [UTF-16 (영문)](https://en.wikipedia.org/wiki/UTF-16) 항목과 [UTF-16 (한글)](https://ko.wikipedia.org/wiki/UTF-16) 항목을 보도록 합니다.
