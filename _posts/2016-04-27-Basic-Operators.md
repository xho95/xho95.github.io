---
layout: post
comments: true
title:  "Swift 5.3: Basic Operators (기본 연산자)"
date:   2016-04-27 10:00:00 +0900
categories: Swift Language Grammar Basic Operators
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [The Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html) 부분[^The-Basics]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Basic Operators (기본 연산자)

_연산자 (operator)_ 는 값을 검사하거나, 바꾸며, 또는 조합하기 위해 사용하는 특수한 '기호 (symbol)' 나 '구절 (phrase)' 입니다. 예를 들어, '더하기 (addition) 연산자 (`+`)' 는, `let i = 1 + 2` 에서 처럼, 두 수를 더하고, '논리 곱 (logical AND) 연산자 (`&&`)' 는, `if enterDoorCode && passedRetinaScan` 에서 처럼, 두 '불리언 (Boolean)' 값을 조합합니다.

스위프트는 C 등의 언어를 통해 이미 알고 있을 연산자를 지원하며, 일반적인 코딩 에러를 없애기 위해 보유 능력 몇 가지를 개선했습니다. '할당 (assignment) 연산자 (`=`)' 는, '같음 (equal to) 연산자 (`==`)' 를 의도한 곳에서 실수로 사용되는 것을 막기 위해, 값을 반환하지 않습니다. '산술 (arithmetic) 연산자 (`+`,`-`, `*`, `/`, `%` 등등)' 은, 이를 저장하는 타입의 허용 범위보다 크거나 작은 값과 작업할 때의 예기치 않은 결과를 피하기 위해, '값 넘침 (value overflow)' 을 감지하고 이를 불허합니다. '값 넘침' 동작은, [Overflow Operator (값 넘침 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#overflow-operators-값-넘침-연산자) 에서 설명한 것처럼, 스위프트의 '값 넘침 (overflow) 연산자' 를 사용함으로써 직접 선택할 수 있습니다.

스위프트는 C 에는 없는 '범위 (range) 연산자' 도 제공하는데, 값의 범위를 표현하는 '줄임말 (shortcut)' 로써, `a..<b` 와 `a...b` 등이 있습니다.

이 장은 스위프트의 일반적인 연산자를 설명합니다. 스위프트의 고급 연산자는 [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) 에서 다루는데, 자신만의 연산자를 정의하는 방법과 자신만의 타입을 위해 표준 연산자를 구현하는 방법도 설명합니다.

### Terminology (용어)

연산자는 '단항 (unary)', '이항 (binary)', 또는 '삼항 (ternary)' 입니다:

* _단항 (Unary)_ 연산자는 (`-a` 처럼) 단일 대상에 작용합니다. '단항 _접두사 (prefix)_ 연산자' 는 (`!b` 처럼) 대상 바로 앞에 위치하며 , '단항 _접미사 (suffix)_ 연산자' 는 (`c!` 처럼) 대상 바로 뒤에 위치합니다.
* _이항 (Binary)_ 연산자는 (`2 + 3` 처럼) 두 개의 대상에 작용하며, 두 대상 사이에 위치하기 때문에 _infix (중위))_[^infix] 라고도 합니다.
* _삼항 (Ternary)_ 연산자는 세 개의 대상에 작용합니다. C 와 같이, 스위프트도, '삼항 조건 연산자 (`a ? b : c`)' 라는, 단 한 개의 삼항 연산자만을 가지고 있습니다.

연산자와 작용하는 값을 _피연산자 (operands)_ 라고 합니다. 표현식 `1 + 2` 에서, `+` 기호는 '이항 연산자' 이며 이의 두 '피연산자' 는 값 `1` 과 `2` 입니다.

### Assignment Operator (할당 연산자)

_할당 연산자 (assignment operator)_ (`a = b`) 는 `a` 의 값을 `b` 의 값으로 초기화하거나 '갱신 (update)' 합니다:

```swift
let b = 10
var a = 5
a = b
// a 는 이제 10 입니다.
```

할당의 오른쪽이 '다중 (multiple) 값' 을 가진 '튜플' 이면, 원소들을 한 번에 다중 상수나 변수로 분해할 수 있습니다:

```swift
let (x, y) = (1, 2)
// x 는 1 이고, y 는 2 입니다.
```

C 와 오브젝티브-C 의 할당 연산자와는 달리, 스위프트의 할당 연산자는 스스로 값을 반환하지 않습니다. 아래 구문은 유효하지 않습니다:

```swift
if x = y {
  // x = y 가 값을 반환하지 않기 때문에, 유효하지 않습니다.
}
```

이런 특징은 실제로는 '같음 연산자 (`==`)' 를 의도한 것인데 우연히 '할당 연산자 (`=`)' 가 사용되는 것을 막아줍니다. `if x = y` 를 무효하게 만듦으로써, 스위프트는 이런 종류의 에러를 피하도록 도와줍니다.

### Arithmetic Operators (산술 연산자)

스위프트는 모든 수치 타입에 대해서 네 개의 표준 _산술 연산자 (arithmetic operators)_ 를 지원합니다:

* 더하기 (`+`)
* 빼기 (`-`)
* 곱하기 (`*`)
* 나누기 (`/`)

```swift
1 + 2       // 3 과 같습니다.
5 - 3       // 2 와 같습니다.
2 * 3       // 6 과 같습니다.
10.0 / 2.5  // 4.0 과 같습니다.
```

C 와 오브젝티브-C 의 산술 연산자와는 달리, 스위프트의 산술 연산자는 기본적으로 '값 넘침 (overflow)' 을 허용하지 않습니다. 값 넘침 작동 방식은 (`a &+ b` 같은) 스위프트의 '값 넘침 연산자 (overflow operators)' 를 사용하여 직접 선택할 수 있습니다. [Overflow Operator (값 넘침 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#overflow-operators-값-넘침-연산자) 를 참고하기 바랍니다.

'더하기 (addition) 연산자' 는 '`String` 이어붙이기 (concatenation)' 도 지원합니다:

```swift
"hello, " + "world"  // "hello, world" 와 같습니다.
```

#### Remainder Operator (나머지 연산자)

_나머지 연산자 (remainder operator)_ (`a % b`) 는 `a` 를 `b` 배수 몇 개로 채울지 알아낸 다음 (_나머지 (remainder)_ 라고 하는) 남아 있는 값을 반환합니다.

> '나머지 연산자 (remainder operator; `%`)' 를 다른 언어에서는 '_모듈러 연산자 (modulo operator)_' 라고도 합니다. 하지만, 스위프트에서 음수에 대한 작동 방식은, 엄밀히 말해서, '모듈러 연산 (modulo operation)'[^modulo-opartion] 이 아니라 나머지가 맞습니다.

다음은 '나머지 연산자' 가 작동하는 방식입니다. `9 % 4` 를 계산하기 위해, 먼저 `9` 를 몇 개의 `4` 로 채울지 알아냅니다:

![Indentation](/assets/Swift/Swift-Programming-Language/Basic-Operators-remainder-operator-works.jpg)

두 개의 `4` 로 `9` 를 채울 수 있으며, 나머지는 (주황색으로 나타낸) `1` 입니다.

스위프트에서, 이는 다음처럼 작성합니다:

```
9 % 4    // 1 과 같습니다.
```

`a % b` 에 대한 답을 결정하기 위해, `%` 연산자는 다음 식을 계산하며 결과로 `remainder` 를 반환합니다:

`a` = (`b` x `some multiplier`) + `remainder`

여기서 `some multiplier` 는 `a` 내부를 채울 `b` 의 가장 큰 배수입니다.

식에 `9` 와 `4` 를 넣으면 다음 결과가 나옵니다:

`9` = (`4` x `2`) + `1`

음수인 `a` 에 대하여 나머지를 계산할 때도 같은 방법을 적용합니다:

```
-9 % 4   // -1 과 같습니다.
```

식에 `-9` 와 `4` 를 넣으면 다음 결과가 나옵니다:

`-9` = (`4` x `-2`) + `-1`

나머지 값으로 `-1` 을 줍니다.

`b` 가 음수일 땐 `b` 의 부호를 무시합니다. 이는 `a % b` 와 `a % -b` 가 항상 똑같은 답을 준다는 의미입니다.

#### Unary Minus Operator (단항 음수 연산자)

수치 값의 부호는, _단항 음수 연산자 (unary minus operator)_ 라는, `-` 접두사를 사용하여, '전환할 (toggled)' 수 있습니다:

```swift
let three = 3
let minusThree = -three       // minusThree 는 -3 과 같습니다.
let plusThree = -minusThree   // plusThree 는 3 또는, "minus minus three" 와 같습니다.
```

'단항 음수 연산자 (`-`)' 는, 어떤 공백도 없이, 작용하는 값 바로 앞에 붙입니다.

#### Unary Plus Operator (단항 양수 연산자)

_단항 양수 연산자_ (_unary plus operator;_ `+`) 는, 어떤 바뀜도 없이, 작용하는 값을 단순히 반환합니다:

```swift
let minusSix = -6
let alsoMinusSix = +minusSix  // alsoMinusSix 는 -6 과 같습니다.
```

비록 '단항 양수 연산자' 는 실제로 아무 것도 하지 않지만, 음수에 '단항 음수 연산자' 를 사용하고 있을 때 양수에 이를 사용하면 코드에 '대칭성 (symmetry)' 을 제공할 수 있습니다.

### Compound Assignment Operators (복합 할당 연산자)

C 와 같이, 스위프트는 '할당 연산 (`=`)' 을 다른 연산과 조합한 _복합 할당 연산자 (compound assignment operators)_ 를 제공합니다. 한 가지 예는 '더하기 할당 연산자 (addition assignment operator; `+=`)' 입니다:

```swift
var a = 1
a += 2
// a 는 이제 3 입니다
```

표현식 `a += 2` 는 `a = a + 2` 의 '줄임 표현 (shorthand)' 입니다. 사실상, 더하기와 할당을 한 연산자로 조합하여 두 작업을 동시에 수행합니다.

> '복합 할당 연산자' 는 값을 반환하지 않습니다. 예를 들어, `let b = a += 2` 처럼 작성할 수 없습니다.


스위프트 표준 라이브러리가 제공하는 연산자에 대한 정보는, [Operator Declaration (연산자 선언)](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 을 참고하기 바랍니다.

### Comparison Operators (비교 연산자)

스위프트는 다음의 _비교 연산자 (comparison operators)_ 를 지원합니다:

* 같음 (equal to; `a == b`)
* 같지 않음 (not equal to; `a != b`)
* 보다 큼 (greater than; `a > b`)
* 보다 작음 (less than; `a < b`)
* 크거나 같음 (greater than or equal to; `a >= b`)
* 작거나 같음 (less than or equal to; `a <= b`)

> 스위프트는 두 개의 '_식별 연산자 (identity operators)_' (`===` 와 `!==`) 도 제공하는데, 이는 두 개의 객체 참조 모두 똑같은 객체 인스턴스를 참조하는 지를 검사하는데 사용합니다. 더 자세한 정보는, [Identity Operators (식별 연산자)]({% post_url 2020-04-14-Structures-and-Classes %}#identity-operators-식별-연산자) 를 참고하기 바랍니다.

각 '비교 연산자' 는 구문이 '참 (true)' 인지의 여부를 나타내기 위해 `Bool` 값을 반환합니다:

```swift
1 == 1   // 참 (true), 1 은 1 과 같기 때문입니다.
2 != 1   // 참 (true), 2 는 1 과 같지 않기 때문입니다.
2 > 1    // 참 (true), 2 는 1 보다 크기 때문입니다.
1 < 2    // 참 (true), 1 은 2 보다 작기 때문입니다.
1 >= 1   // 참 (true), 1 은 1 보다 크거가 같기 때문입니다.
2 <= 1   // 거짓 (false), 2 는 1 보다 작거나 같지 않기 때문입니다.
```

비교 연산자는 종종, `if` 문 같은, '조건문 (conditional statements)' 에서 사용됩니다:

```swift
let name = "world"
if name == "world" {
  print("hello, world")
} else {
  print("I'm sorry \(name), but I don't recognize you")
}
// "hello, world" 를 인쇄하는데, 이는 name 이 진짜로 "world" 와 같기 때문입니다.
```

`if` 구문에 대한 더 많은 내용은, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 을 참고하기 바랍니다.

두 '튜플 (tuples)' 은 타입이 같고 값의 개수가 같은 경우 서로 비교할 수 있습니다. 튜플 비교는 왼쪽에서 오른쪽으로, 한번에 한 값씩, 두 값이 같지 않음을 찾을 때까지 비교합니다. 이 두 값들을 비교한 후, 해당 비교 연산의 결과가 전체 튜플 비교의 결과를 결정합니다. 만약 모든 원소가 같은 거라면, 튜플 자체가 같은 것입니다. 예를 들면 다음과 같습니다:

```swift
(1, "zebra") < (2, "apple")   // 참, 1 이 2 보다 작기 때문입니다; "zebra" 와 "apple" 은 비교하지 않습니다.
(3, "apple") < (3, "bird")    // 참, 3 은 3 과 같고, "apple" 은 "bird" 보다 작기 때문입니다.
(4, "dog") == (4, "dog")      // 참, 4 는 4 와 같고, "dog" 도 "dog" 과 같기 때문입니다.
```

위 예제의, 첫 번째 줄에서 비교 연산의 '왼쪽에서-오른쪽' 작동 방식을 볼 수 있습니다. `1` 이 `2` 보다 작기 때문에, 튜플의 다른 어떤 값들에도 상관없이, `(1, "zebra")` 는 `(2, "apple")` 보다 작은 것으로 간주합니다. `"zebra"` 가 `"apple"` 보다 작지 않은 건 아무 상관 없는데, 왜냐면 비교 연산이 튜플의 첫 번째 원소에 의해 이미 결정됐기 때문입니다. 하지만, 튜플의 첫 번째 원소가 같으면, 두 번째 원소들 _이 (are)_ 비교됩니다-이것이 두 번째와 세 번째 줄에서 일어난 일입니다.

튜플은 튜플 각자의 각 값마다 연산자를 적용할 수 있을 때만 주어진 연산자로 비교할 수 있습니다.

예를 들어, 아래 코드에서 증명해 보인 것처럼, `(String, Int)` 타입인 두 튜플은 비교할 수 있는데 이는 `String` 과 `Int` 값 둘 다 `<` 연산자로 비교할 수 있기 때문입니다. 이와는 대조적으로, `(String, Bool)` 타입인 두 튜플은 `<` 연산자로 비교할 수 없는데 이는 `<` 연산자를 `Bool` 값에 적용할 수 없기 때문입니다.

```swift
("blue", -1) < ("purple", 1)        // OK, 참으로 평가합니다.
("blue", false) < ("purple", true)  // 에러, '<' 가 불리언 값을 비교할 수 없기 때문입니다.
```

> 스위프트 표준 라이브러리는 7개 미만의 원소를 가진 튜플에 대한 튜플 비교 연산자를 포함하고 있습니다. 7개 이상의 원소를 가진 튜플을 비교하려면, 반드시 직접 비교 연산자를 구현해야 합니다.

### Ternary Conditional Operator (삼항 조건 연산자)

_삼항 조건 연산자 (ternary conditional operator)_ 는 세 부분을 가진 특수한 연산자로, `question ? answer1 : answer2` 라는 형식을 취합니다. 이는 `question` 이 참인지 거짓인지에 기초하여 두 표현식 중 하나를 평가하는 '줄임말 (shortcut)' 입니다. `question` 이 참이면, `answer1` 을 평가한 값을 반환하며; 다른 경우, `answer2` 를 평가한 값을 반환합니다.

'삼항 조건 연산자' 는 아래 코드의 '줄임 표현 (shorthand)' 입니다:

```swift
if question {
  answer1
} else {
  answer2
}
```

다음은, 표의 행 높이를 계산하는, 예제입니다. '행 높이' 는 그 행이 '표제 (header)' 를 가진 경우 '내용물 높이 (content height)' 보다 50 포인트 만큼 더 크며, '표제' 를 가지지 않은 경우 20 포인트 만큼 더 큽니다:

```swift
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight 는 90 입니다.
```

위 예제는 아래 코드의 '줄임 표현 (shorthand)' 입니다:

```swift
let contentHeight = 40
let hasHeader = true
let rowHeight: Int
if hasHeader {
  rowHeight = contentHeight + 50
} else {
  rowHeight = contentHeight + 20
}
// rowHeight 는 90 입니다.
```

첫 번째 예제에서 '삼항 조건 연산자' 를 사용한 건, 단 한 줄의 코드로도 `rowHeight` 에 올바른 값을 설정할 수 있음을 의미하며, 이는 두 번째 예제에서 사용한 코드보다 더 간결합니다.

삼항 조건 연산자는 두 표현식 중에서 검토할 것을 고르는데 효율적인 '줄임 표현 (shorthand)' 을 제공합니다. 하지만, 삼항 조건 연산자를 주의해서 사용하기 바랍니다. 간결하다고 너무 남용하면 이해하기-어려운 코드를 만들게 됩니다. 다중 삼항 조건 연산자를 하나의 복합 구문으로 조합하는 것은 피하도록 합니다

### Nil-Coalescing Operator (Nil-통합 연산자)

_nil-통합 연산자_ (_nil-coalescing operator;_ `a ?? b`) 는 옵셔널 `a` 가 값을 담고 있으면 포장을 풀고, `a` 가 `nil` 이면 기본 설정 값인 `b` 를 반환합니다. 표현식 `a` 는 항상 옵셔널 타입입니다. 표현식 `b` 는 반드시 `a` 에 저장된 값과 타입이 일치해야 합니다.

'nil-통합 연산자' 는 아래 코드의 '줄임 표현 (shorthand)' 입니다:

```swift
a != nil ? a! : b
```

위 코드는 '삼항 조건 연산자' 와 '강제 포장 풀기 (forced unwrapping; `a!`)' 를 사용하여 `a` 가 `nil` 이 아닐 땐 `a` 안에 포장된 값에 접근하고, 그 외 경우엔 `b` 를 반환합니다. 'nil-통합 연산자' 는 이러한 조건 검사와 포장 풀기를 간결하고 이해가 쉬운 형식 속에 은닉하는 방식의 더 우아한 방법을 제공합니다.

> `a` 의 값이 `nil` 이 아니면, `b` 의 값은 평가하지 않습니다. 이를 '_단락-회로 계산 (short-circuit evaluation)_' 이라고 합니다. [^short-circuit]

아래 예제는 '기본 색상 이름' 과 '사용자가-정의한 옵셔널 색상 이름' 중 하나를 선택하기 위해 'nil-통합 연산자' 를 사용합니다:

```swift
let defaultColorName = "red"
var userDefinedColorName: String?   // 기본 값은 nil 입니다.

var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 이 nil 이므로, colorNameToUse 는 기본 설정 값인 "red" 로 설정됩니다.
```

`userDefinedColorName` 변수를, 기본 설정 값이 `nil` 인, 옵셔널 `String` 으로 정의합니다. `userDefinedColorName` 이 옵셔널 타입이기 때문에, 값을 고려하는데 `nil-통합 연산자` 를 사용할 수 있습니다. 위 예제에서는, `colorNameToUse` 라는 `String` 변수에 대한 초기 값을 결정하기 위해 이 연산자를 사용됩니다. `userDefinedColorName` 이 `nil` 이기 때문에, `userDefinedColorName ?? defaultColorName` 라는 표현식은 `defaultColorName` 의 값인, `"red"` 를 반환합니다.

만약 `userDefinedColorName` 에 `nil` 아닌 값을 할당한 다음 'nil-통합 연산자' 검사를 다시 수행하면, 기본 설정 값 대신 `userDefinedColorName` 안에 포장된 값을 사용합니다:

```swift
userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 이 nil 이 아니므로, colorNameToUse 를 "green" 으로 설정합니다.
```

### Range Operators (범위 연산자)

스위프트는, 값의 범위를 표현하기 위한 '줄임말 (shortcuts)' 인, _범위 연산자 (range operators)_ 몇 개를 포함합니다.

#### Closed Range Operator (닫힌 범위 연산자)

'_닫힌 범위 연산자_ (_closed range operator;_ `a...b`)' 는 `a` 에서 `b` 에 이르는 범위를 정의하며, `a` 와 `b` 의 값도 포함합니다. `a` 의 값은 반드시 `b` 보다 크지 않아야 합니다.

닫힌 범위 연산자는, `for`-`in` 반복문 같이, 범위 내의 모든 값을 사용하여 동작을 반복하고 싶을 때 유용합니다:

```swift
for index in 1...5 {
  print("\(index) times 5 is \(index * 5)")
}
// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25
```

`for-in` 반복문에 대해서는, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 을 참고하기 바랍니다.

#### Half-Open Range Operator (반-열린 범위 연산자)

'_반-열린 범위 연산자_ (_half-open range operator;_ `a..<b`)' 는 `a` 에서 `b` 에 이르는 범위를 정의하지만, `b` 는 포함하지 않습니다. _반-열린 (half-open)_ 이라고 하는 것은 첫 번째 값은 담고 있지만, 최종 값은 담지 않기 때문입니다. 닫힌 범위 연산자에서와 마찬가지로, `a` 의 값은 반드시 `b` 보다 크지 않아야 합니다. `a` 의 값이 `b` 와 같으면, 이 때의 결과는 '빈 (empty) 범위' 가 될 것입니다.

'반-열린 범위' 는 배열 같이 '0-에 기초한 (zero-based)[^zero-based] 목록' 과 작업할 때 특히 더 유용하며, 이 때 목록의 길이를 (포함하지는 않으면서) 셀 때 유용합니다:

```swift
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
  print("Person \(i + 1) is called \(names[i])")
}
// Person 1 is called Anna
// Person 2 is called Alex
// Person 3 is called Brian
// Person 4 is called Jack
```

배열이 네 개의 항목을 담고 있지만, `0..<count` 는, '반-열린 연산자' 이기 때문에, (배열에 있는 마지막 항목의 색인인) `3` 까지만 셉니다. 배열에 대해서는, [Arrays (배열)]({% post_url 2016-06-06-Collection-Types %}#arrays-배열) 을 참고하기 바랍니다.

#### One-Sided Ranges (한-쪽 범위)

'닫힌 범위 연산자' 는 한쪽 방향으로 계속되는 범위-예를 들어, 2 부터 배열 끝까지 배열의 모든 원소를 포함하는 범위 등-을 위해 '또 다른 형식 (alternative form)' 을 가집니다. 이 경우, 범위 연산자의 한쪽에 있는 값을 생략할 수 있습니다. 이런 종류의 범위를 '_한-쪽 범위 (one-sided range)_' 라고 하는데 이는 연산자가 한쪽에만 값을 가지고 있기 때문입니다. 예를 들면 다음과 같습니다:

```swift
for name in names[2...] {
  print(name)
}
// Brian
// Jack

for name in names[...2] {
  print(name)
}
// Anna
// Alex
// Brian
```

'반-열린 범위 연산자' 도 최종 값만 작성하는 '한-쪽 형식 (one-sided form)' 을 가지고 있습니다. 양쪽에 값을 포함할 때와 마찬가지로, 이 최종 값은 범위의 일부가 아닙니다. 예를 들면 다음과 같습니다:

```swift
for name in names[..<2] {
  print(name)
}
// Anna
// Alex
```

'한-쪽 범위' 는, '첨자 연산 (subscript)' 뿐 아니라, 다른 상황에서도 사용할 수 있습니다. 첫 번째 값을 생략한 '한-쪽 범위' 에는 동작을 반복할 수 없는데, 반복 동작을 어디서 시작해야할 지 명확하지 않기 때문입니다. 최종 값을 생략한 '한-쪽 범위' 에는 동작을 반복 _할 수 (can)_ 있습니다; 하지만, 범위가 무한정 계속되기 때문에, 명시적인 종료 조건을 반복문에 확실히 추가해야 합니다. '한-쪽 범위' 는, 아래 코드에서 보인 것처럼, 특정 값을 담고 있는 지도 검사할 수 있습니다.

```swift
let range = ...5
range.contains(7)   // false (거짓)
range.contains(4)   // true (참)
range.contains(-1)  // true (참)
```

### Logical Operators (논리 연산자)

_논리 연산자 (logical operators)_ 는 '불리언 논리 (Boolean logic)' 값인 `true` 와 `false` 를 수정하거나 결합합니다. 스위프트는 C-기반 언어가 제공하는 세 가지 표준 논리 연산자를 지원합니다:

* Logical NOT '논리 부정' (`!a`)
* Logical AND '논리 곱' (`a && b`)
* Logical OR '논리 합' (`a || b`)

#### Logical NOT Operator (논리 부정 연산자)

_논리 부정 연산자 (logical NOT operator)_ (`!a`) 는 불리언 (Boolean) 값을 반전하므로 `true` 는 `false` 가 되고, `false` 는 `true` 가 됩니다.

'논리 부정 연산자' 는 '접두사 연산자 (prefix operator)' 라서, 연산할 값 바로 앞에 붙여주며, 공백이 있으면 안됩니다. “Not `a`” (`a` 가 아님) 이라고 읽으며, 아래에 예를 보였습니다:

```swift
let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}
// "ACCESS DENIED" 를 출력합니다.
```

`if !allowedEntry` 구절은 "허가된 입장이 아니면 (if not allowed entry)" 으로 읽을 수 있습니다. 그 다음 행은 "허가된 입장이 아니면" 이 참일 때만 실행됩니다; 그것은 곧, `allowedEntry` 가 `false` 일 때입니다.

이 예제와 같이, 불리언 (Boolean) 상수와 변수의 이름을 정할 때는 주의 깊에 선택해야 코드를 이해하기 슆고 간결하게 만들 수 있으며, 이중 부정을 하거나 논리 구문을 혼동하는 것을 막을 수 있습니다.

#### Logical AND Operator (논리 곱 연산자)

_논리 곱 연산자 (logical AND operator)_ (`a && b`) 는 두 값이 모두 `true` (참) 일 때만 전체 표현식이 `true` (참) 이 되는 '논리 표현식 (logical expressions)' 을 생성합니다.

한 값이라도 `false` 면, 전체 표현식도 `false` 가 됩니다. 사실, _첫 번째 (first)_ 값이 `false` 면, 두 번째 값은 계산조차 하지 않으며, 이는 그래봐야 전체 표현식을 `true` 로 만들 수가 없기 때문입니다. 이런 방식을 '단락-회로 계산 (short-circuit evaluation)'[^short-circuit] 이라고 합니다.

아래 예제는 두 `Bool` 값을 고려해서 두 값이 모두 `true` 일 때만 접근을 허용합니다:

```swift
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// "ACCESS DENIED" 를 출력합니다.
```

#### Logical OR Operator (논리 합 연산자)

_논리 합 연산자 (logical OR operator)_ (`a || b`) 는 두 '파이프 문자 (`|`)' 를 붙여서 만든 'infix (중위) 연산자' 입니다. 이를 사용하면 두 값 중에서 _하나 (one)_ 만 `true` (참) 이면 전체 표현식이 `true` (참) 이 되는 '논리 표현식 (logical expressions)' 를 생성할 수 있습니다.

앞서의 '논리 곱 연산자 (logical AND operator)' 와 마찬가지로, '논리 합 연산자 (logical OR operator)' 는 표현식을 계산할 때 '단락-회로 계산 (short-circuit evaluation)'[^short-circuit] 방식을 사용합니다. '논리 합 표현식 (logical OR expressions)' 의 왼쪽이 `true` 면, 오른쪽은 계산하지 않으며, 이는 전체 표현식의 결과가 달라질 일이 없기 때문입니다.

아래 예제에서, 첫 번째 `Bool` 값 (`hasDoorKey`) 은 `false` 지만, 두 번째 값 (`knowsOverridePassword`) 은 `true` 입니다. 한 값이 `true` 이므로, 전체 표현식도 `true` 로 계산하여, 접근을 허용합니다:

```swift
let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// "Welcome!" 을 출력합니다.
```

#### Combining Logical Operators (논리 연산자 결합하기)

여러 개의 논리 연산자를 결합하여 더 긴 '복합 표현식 (compound expressions)' 을 만들 수 있습니다:

```swift
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// "Welcome!" 을 출력합니다.
```

이 예제에서는 여러 개의 `&&` 와 `||` 연산자를 써서 더 긴 '복합 표현식 (compound expressions)' 을 만들었습니다. 하지만, `&&` 와 `||` 연산자는 여전히 두 값에 대해서만 동작하므로, 실제로는 세 개의 작은 식이 서로 줄줄이 이어져 있는 형태입니다. 이 예제는 다음과 같이 이해할 수 있습니다:

올바른 출입문 코드를 입력하고 망막 스캔을 통과했거나, 알맞은 출입문 키를 갖고 있거나, '비상시 수동해제 비밀번호 (emergency override password)' 를 알고 있는 경우라면, 접근을 허용합니다.

`enterDoorCode`, `passedRetinaScan` 그리고 `hasDoorKey` 의 값에 의해서, 처음 두 개의 '하위표현식 (subexpressions)' 은 `false` 입니다. 하지만, '비상시 수동해제 비밀번호' 를 알고 있으므로, 전체 복합 표현식은 여전히 `true` 가 됩니다.

> 스위프트의 논리 연산자인 `&&` 와 `||` 는 '왼쪽 우선-결합 (left-associative)'[^left-associative] 으로, 이는 여러 개의 논리 연산자를 가지는 '복합 표현식' 이 있을 때 가장 왼쪽에 있는 '하위 표현식' 부터 먼저 계산한다는 의미입니다.

#### Explicit Parentheses (괄호 명시하기)

반드시 넣어야 하는 것은 아니지만, 그래도 '괄호 (parentheses)' 를 넣어주면, 복합한 표현식의 의도를 이해하기가 훨씬 쉬어집니다. 위에 있는 '출입문 접근' 예제에서도, '복합 표현식' 의 첫 부분에 괄호를 추가하면 그 의도를 더 명확하게 알 수 있게 됩니다:

```swift
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// "Welcome!" 를 출력합니다.
```

괄호를 사용하면 처음 두 값들이 전체 논리에서 별도로 검토할 수 있음을 분명하게 보여줍니다. 복합 표현식의 결과에는 전혀 영향이 없으면서도, 전체 의도를 이해하기는 훨씬 더 쉽습니다. 가독성을 간결함보다 더 우선하기 바랍니다; 괄호가 의도를 분명히 드러내는데 도움이 된다면 사용하는 것이 좋습니다.

### 참고 자료

[^Basic-Operators]: 원문은 [Basic Operators](https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^modulo-opartion]: 'modulo operation (모듈러 연산)' 은 수학적으로 엄밀한 '나머지 연산' 과 연관있는 것 같습니다. 보다 자세한 내용은 위키피디아의 [Modulo operation](https://en.wikipedia.org/wiki/Modulo_operation) 항목을 참고하기 바랍니다. 이에 대한 한글 자료가 거의 없는 거 같은데, 한글로는 [합동 산술](https://ko.wikipedia.org/wiki/합동_산술) 부분을 보면 도움이 될 것 같습니다.

[^short-circuit]: 'short-circuit evaluation (단락-회로 계산)' 은 전기 공학에서 나온 개념인 듯 합니다. 전기 회로에서 'short-circuit (단락-회로)' 가 생기면 다른 곳으로 전류가 흐르지 않듯이, 컴퓨터 공학에서는 계산량을 줄이기 위해 불필요한 식의 계산을 하지 않는 것을 말합니다. 컴퓨터 용어로 'minimal evaluation (최소 계산)' 이라는 말도 사용하는 것 같습니다. 이에 대한 더 자세한 정보는 위키피디아의 [Short-circuit evaluation](https://en.wikipedia.org/wiki/Short-circuit_evaluation) 을 참고하기 바랍니다. (위키피디아에서 항목에 대한 번역은 아직 없는 것 같습니다.)

[^left-associative]: 'left-associative' 를 '왼쪽 우선-결합' 이라고 옮겼습니다. 이에 대한 더 자세한 정보는 위키피디아의 [Operator associativity (연산자 결합성)](https://en.wikipedia.org/wiki/Operator_associativity) 항목을 참고하기 바랍니다.

[^infix]: 'infix는 '중간에 위치' 한다는 의미로 '중위' 라고 합니다. '중위 (infix)' 라는 말에 대해서는 위키피디아의 [Infix notation](https://en.wikipedia.org/wiki/Infix_notation) 항목과 [중위 표기법](https://ko.wikipedia.org/wiki/중위_표기법) 항목을 참고하기 바랍니다.

[^operator-declarations]: 원문 자체가 애플 개발자 사이트의 링크로 되어 있습니다. 해당 페이지에 스위프트 표준 라이브러리가 제공하는 연산자에 대한 전체 목록이 있습니다.

[^zero-based]: '0-에 기초한 (zero-based) 목록' 이란 '색인 (index)' 가 '0 부터 시작하는 목록' 이라고 이해할 수 있습니다.
