---
layout: post
comments: true
title:  "Swift 5.2: Basic Operators (기본 연산자)"
date:   2016-04-27 10:00:00 +0900
categories: Swift Language Grammar Basic Operators
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Basic Operators](https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html) 부분[^Basic-Operators]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## Basic Operators (기본 연산자)

_연산자 (operator)_ 는 값을 검사하고, 바꾸거나 결합하는 데 사용하는 특수한 기호 또는 구절을 말합니다. 예를 들어, '더하기 연산자 (`+`)' 는 `let i = 1 + 2` 에서 처럼 두 수를 더하고, '논리 곱 (logical AND) 연산자 (`&&`)' 는 `if enterDoorCode && passedRetinaScan` 에서 처럼 두 불리언 (Boolean) 값을 결합합니다.

스위프트는 C 언어에서 제공하는 거의 대부분의 표준 연산자를 지원하며서, 거기다 일반적인 코딩 에러를 없애기 위해 몇가지 기능을 개선했습니다. '할당 연산자 (`=`)' 는 값을 반환하지 않아서, '같음 연산자 (`==`)' 를 의도한 곳에서 실수로 사용되는 것을 막았습니다. 산술 연산자들 (`+`,`-`, `*`, `/`, `%` 등) 은 '값 넘침 (value overflow)' 을 감지해서 막아주기 때문에, 타입의 허용 범위보다 크거나 작아진 값을 계산하는 바람에 예상하지 못한 결과가 발생하는 것을 막아줍니다. 스위프트의 'overflow (값 넘침) 연산자' 를 사용해서 값을 넘치는 동작을 하도록 선택할 수도 있으며, 이는 [Overflow Operator (값 넘침 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#overflow-operators-값-넘침-연산자) 에서 설명합니다.

스위프트에는 C 언어에는 없는 '범위 (range) 연산자' 도 제공하는데, 가령 `a..<b` 와 `a...b` 가 있으며, 이를 쓰면 아주 간단하게 값의 범위를 표현할 수 있습니다.

이번 장은 스위프트의 일반적인 연산자에 대해 설명합니다. 스위프트의 고급 연산자는 [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) 에서 다루는데, 직접 연산자를 정의하는 방법과 자기가 만든 타입에 대한 표준 연산자 구현 방법에 대해서 설명합니다.

### Terminology (용어)

연산자에는 단항, 이항, 삼항 연산자가 있습니다:

* _단항 (Unary)_ 연산자는 (`-a` 처럼) 단일 대상에 작용합니다. '단항 _접두사 (prefix)_ 연산자' 는 (`!b` 처럼) 대상의 바로 앞에 위치하고 , '단항 _접미사 (suffix)_ 연산자' 는 (`c!` 처럼) 대상 바로 뒤에 위치합니다.
* _이항 (Binary)_ 연산자는 (`2 + 3` 처럼) 두 대상에 작용하며, 두 대상 사이에 위치하므로 _infix (중위))_ 라고 합니다. [^infix]
* _삼항 (Ternary)_ 연산자는 세 개의 대상에 작용합니다. C 언어 처럼, 스위프트도 삼항 연산자는 한 개 뿐인데, 이는 '삼항 조건 연산자 (`a ? b : c`)' 입니다.

연산자가 영향을 주는 값을 _피연산자 (operands)_ 라고 합니다. `1 + 2` 라는 식이 있을 때, `+` 기호는 '이항 연산자' 이고, 이것의 피연산자 두 개는 값 `1` 과 값 `2` 입니다.

### Assignment Operator (할당 연산자)

_할당 연산자 (assignment operator)_ (`a = b`) 는 `a` 의 값을 `b` 의 값으로 초기화하거나 갱신 (update) 합니다:

```swift
let b = 10
var a = 5
a = b
// a 는 이제 10 과 같습니다.
```

할당할 때 오른쪽이 '튜플 (tuple)' 이라 여러 값을 가지고 있을 경우, 그 요소들을 한번에 여러 개의 상수나 변수로 분해할 수 있습니다:

```swift
let (x, y) = (1, 2)
// x 는 1 과 같고, y 는 2 와 같아집니다.
```

C 언어나 오브젝티브-C 언어의 할당 연산자와는 다르게, 스위프트의 할당 연산자는 스스로 값을 반환하지 않습니다. 즉, 아래의 구문은 유효하지 않습니다:

```swift
if x = y {
    // 이것은 유효하지 않는데, x = y 는 값을 반환하지 않기 때문입니다.
}
```

이러한 특징은 실제로는 '같음 연산자 (`==`)' 를 쓰려고 했는데 우연히 '할당 연산자 (`=`)' 를 써버리는 것을 막아줍니다. `if x = y` 를 유효하지 않게 만드는 것으로써, 스위프트는 코드에서 이런 종류의 에러를 피하도록 해줍니다.

### Arithmetic Operators (산술 연산자)

스위프트는 모든 수치 타입에 대해 다음의 네 가지 표준 _산술 연산자 (arithmetic operators)_ 를 지원합니다:

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

C 언어나 오브젝티브-C 언어의 산술 연산자와는 다르게, 스위프트의 산술 연산자는 기본적으로 '값 넘침 (overflow)' 을 허용하지 않습니다. 값 넘침을 허용하려면 스위프트의 '값 넘침 연산자 (overflow operators)' 를 사용하면 됩니다. (`a &+ b` 같은 것이 있습니다.) 이에 대해서는 [Overflow Operator (값 넘침 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#overflow-operators-값-넘침-연산자) 를 보도록 합니다.

'더하기 연산자 (addition operator)' 로는 `String` 을 연결할 수도 있습니다:

```swift
"hello, " + "world"  // "hello, world" 와 같아집니다.
```

#### Remainder Operator (나머지 연산자)

_나머지 연산자 (remainder operator)_ (`a % b`) 는 `a` 안을 `b` 의 배수로 채운 다음에 그래도 남는 값을 반환합니다. (이를 _나머지 (remainder)_ 라고 합니다.)

> 다른 언어에서는 '나머지 연산자 (remainder operator)' (`%`) 를 '_모듈러 연산자 (modulo operator)_' 라고도 합니다. 하지만, 음수에 대한 연산 방식을 보면, 스위프트에서는 엄밀히 말해서, _모듈러 연산 (modulo operation)_[^modulo-opartion] 이라기 보다는 나머지라고 하는 것이 맞습니다.

이제 '나머지 연산자' 의 작동 방식을 알아봅시다. `9 % 4` 를 계산하면, 일단 `4` 의 배수로 `9` 를 채웁니다:

![Indentation](/assets/Swift/Swift-Programming-Language/Basic-Operators-remainder-operator-works.jpg)

`4` 2 개로 `9` 를 채우고 나면, 나머지는 `1` 이 됩니다. (주황색 부분입니다.)

스위프트로는, 이를 다음 처럼 작성합니다:

```
9 % 4    // 1 과 같습니다.
```

`a % b` 의 답을 결정하기 위해, '`%` 연산자' 는 다음 식을 계산한 후 그 결과로 `remainder` 를 반환합니다:

`a` = (`b` x `some multiplier`) + `remainder`

여기서 `some multiplier` 는 `a` 내부를 채울 수 있는 `b` 의 가장 큰 배수입니다.

`9` 와 `4` 를 넣으면 다음 식이 도출됩니다:

`9` = (`4` x `2`) + `1`

같은 방법으로 `a` 가 음수일 때도 나머지를 계산할 수 있습니다:

```
-9 % 4   // -1 과 같습니다.
```

`9` 와 `4` 를 넣으면 다음 식이 도출됩니다:

`-9` = (`4` x `-2`) + `-1`

주어진 식의 나머지 값은 `-1` 입니다.

여기서 `b` 가 음수 값일 때라도 `b` 의 부호를 무시합니다. 이는 `a % b` 와 `a % -b` 의 답이 항상 같다는 것을 의미합니다.

#### Unary Minus Operator (단항 음수 연산자)

수치 값의 부호를 전환하려면 접두사 `-` 를 붙이며, 이를 '_단항 음수 연산자 (unary minus operator)_' 라고 합니다.

```swift
let three = 3
let minusThree = -three       // minusThree 는 -3 과 같습니다.
let plusThree = -minusThree   // plusThree 는 3 과 같으며, "minus minus three" 라고도 합니다.
```

'단항 음수 연산자 (`-`)' 는 빈 공백없이 연산될 값 바로 앞에 위치합니다.

#### Unary Plus Operator (단항 양수 연산자)

'_단항 양수 연산자 (unary plus operator)_' (`+`) 는 단순히 연산 값을 그대로 반환하며, 어떤 변경도 하지 않습니다:

```swift
let minusSix = -6
let alsoMinusSix = +minusSix  // alsoMinusSix 는 -6 과 같습니다.
```

'단항 양수 연산자' 가 실제로 하는 일은 없지만, 이것을 양수에 사용하면 '단항 음수 연산자' 로 표현한 음수와 나란하게 코드를 배치할 수 있습니다.

### Compound Assignment Operators (복합 할당 연산자)

C 언어처럼, 스위프트는 _복합 할당 연산자 (compound assignment operators)_ 를 제공하며 이는 '할당 연산 (`=`)' 을 다른 연산과 결합합니다. 한 가지 예로는 '더하기 할당 연산자 (addition assignment operator)' (`+=`)  가 있습니다:

```swift
var a = 1
a += 2
// a 는  3 과 같습니다.
```

표현식 `a += 2` 는 `a = a + 2` 의 약칭입니다. 효과적으로, 더하기와 할당 연산을 하나의 연산자로 결합하여 한번에 두 작업을 동시에 수행합니다.

> '복합 할당 연산자' 는 값을 반환하지 않습니다. 예를 들어 `let b = a += 2` 라고 작성할 수 없습니다.


스위프트 표준 라이브러리에서 제공하는 연산자에 대한 정보는 [Operator Declaration (연산자 선언)](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations) 을 보기 바랍니다.

### Comparison Operators (비교 연산자)

스위프트는 C 언어에 있는 모든 표준 _비교 연산자 (comparison operators)_ 를 지원합니다:

* 같음 (`a == b`) - 등호
* 같지 않음 (`a != b`) - 부등호
* 보다 큼 (`a > b`)
* 보다 작음 (`a < b`)
* 크거나 같음 (`a >= b`)
* 작거나 같음 (`a <= b`)

> 스위프트는 두 개의 '_식별 연산자 (identity operators)_' (`===` 와 `!==`) 도 제공하여, 두 객체에 대한 참조 모두 동일한 객체 인스턴스를 참조하고 있는지를 검사할 수 있습니다. 더 자세한 내용은 [Identity Operators (식별 연산자)]({% post_url 2020-04-14-Structures-and-Classes %}#identity-operators-식별-연산자) 를 보기 바랍니다.

각각의 '비교 연산자' 는 `Bool` 값을 반환하여 그 구문이 참인지 아닌지를 나타냅니다:

```swift
1 == 1   // true (참), 1 은 1 과 같기 때문입니다.
2 != 1   // true (참), 2 는 1 과 같지 않기 때문입니다.
2 > 1    // true (참b, 2 는 1 보다 크기 때문입니다.
1 < 2    // true (참), 1 은 2 보다 작기 때문입니다.
1 >= 1   // true (참), 1 은 1 보다 크거가 같기 때문입니다.
2 <= 1   // false (거짓), 2 는 1 보다 작거나 같지 않기 때문입니다.
```

비교 연산자 주로 '조건 구문 (conditional statements)' 에서 사용되며, 여기에는 `if` 구문 등이 있습니다:

```swift
let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}
// "hello, world" 를 출력합니다. name 이 진짜 "world" 와 같기 때문입니다.
```

`if` 구문에 대해서는, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 을 보기 바랍니다.

두 개의 '튜플 (tuples)' 이 같은 타입에 같은 개수의 값을 가지고 있으면 서로 비교할 수 있습니다. 튜플을 비교할 때는 왼쪽에서 오른쪽으로, 한번에 한 값씩, 두 값이 같지 않을 때까지 비교합니다. 두 값을 비교하면, 이 비교의 결과가 튜플 비교 연산의 전체 결과를 결정합니다. 모든 요소가 같으면, 튜플 자체가 같은 것입니다. 예를 들면 다음과 같습니다:

```swift
(1, "zebra") < (2, "apple")   // true (참), 1 은 2 보다 작기 때문입니다; "zebra" 와 "apple" 은 서로 비교되지 않습니다.
(3, "apple") < (3, "bird")    // true (참), 3 은 3 과 같고, "apple" 은 "bird" 보다 작기 때문입니다.
(4, "dog") == (4, "dog")      // true (참), 4 는 4 와 같고, "dog" 도 "dog" 과 같기 때문입니다.
```

위 예의 첫 번째 줄에서, '왼쪽에서-오른쪽 순으로 (left-to-right)' 비교 동작이 진행되는 것을 볼 수 있습니다. `1` 이 `2` 보다 작으므로, `(1, "zebra")` 는 `(2, "apple")` 보다 작은 것으로 간주되며, 튜플의 나머지 값들은 상관이 없습니다. `"zebra"` 가 `"apple"` 보다 작지 않아도 상관이 없는 것은, 비교가 이미 튜플의 첫 번째 요소에 의해 결정되었기 때문입니다. 하지만, 튜플의 첫 번째 요소들이 같으면, 두 번째 요소들이 _이제 (are)_ 비교됩니다-두 번째 줄과 세 번째 줄에서 일어난 것이 이것입니다.

주어진 연산자로 튜플을 비교하려면 그 연산자는 해당 튜플의 각각의 값에 대해 적용할 수 있어야만 합니다.

예를 들어, 아래에 나타낸 코드처럼, 타입이 `(String, Int)` 인 두 개의 튜플을 비교할 수 있는 것은 `String` 과 `Int` 값 모두 `<` 연산자를 써서 비교할 수 있기 때문입니다. 이와는 다르게, 타입이 `(String, Bool)` 인 두 개의 튜플은 `<` 연산자로 비교할 수 없는데 이는 `<` 연산자를 `Bool` 값에 적용할 수 없기 때문입니다.

```swift
("blue", -1) < ("purple", 1)        // OK, true (참) 으로 계산됩니다.
("blue", false) < ("purple", true)  // Error, < 는 불리언 값을 비교할 수 없습니다.
```

> 스위프트 표준 라이브러리에 있는 튜플 비교 연산자는 7개 미만의 요소를 가진 튜플만 비교할 수 있습니다. 7개 이상의 요소를 가진 튜플을 비교하려면 비교 연산자를 직접 구현해야만 합니다.

### Ternary Conditional Operator (삼항 조건 연산자)

_삼항 조건 연산자 (ternary conditional operator)_ 는 세 부분으로 구성된 특수한 연산자로, 양식은 `question ? answer1 : answer2` 입니다. 이는 `question` 이 참인지 거짓인지에 따라서 두 표현식 중 하나의 값을 계산하는 '간략한 표기법 (shortcut)' 입니다. `question` 이 참이면, `answer1` 을 계산한 값을 반환하고; 그렇지 않으면, `answer2` 를 계산한 값을 반환합니다.

'삼항 조건 연산자' 는 아래 코드의 약칭에 해당합니다:

```swift
if question {
    answer1
} else {
    answer2
}
```

다음은 테이블에서 행의 높이를 계산하는 예제입니다. 행에 '헤더 (header)' 가 있으면 '행 높이 (row height)' 가 '내용물 높이 (content height)' 보다 50 포인트 만큼 더 높고, 헤더가 없으면 20 포인트 만큼 더 높습니다:

```swift
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight 는 90 과 같습니다.
```

위 예제는 아래 코드의 약칭에 해당합니다:

```swift
let contentHeight = 40
let hasHeader = true
let rowHeight: Int
if hasHeader {
    rowHeight = contentHeight + 50
} else {
    rowHeight = contentHeight + 20
}
// rowHeight 는 90 과 같습니다.
```

첫 번째 예제에서 '삼항 조건 연산자' 를 사용함으로써 `rowHeight` 의 값을 코드 한 줄로 올바르게 설정할 수 있었으며, 이는 두 번째 예제의 코드보다 훨씬 더 간결합니다.

'삼항 조건 연산자' 는 두 표현식 중 하나를 고르는 구문에 대한 효율적인 약칭을 제공합니다. 하지만, 삼항 조건 연산자는 주의해서 사용하기 바랍니다. 간결함을 추구한 나머지 너무 과용하다보면 코드를 이해하기가 어려워집니다. 여러 개의 삼항 조건 연산자 구문를 결합해서 하나의 복합 구문을 만드는 것은 피하는 것이 좋습니다.

### Nil-Coalescing Operator (Nil-통합 연산자)

_nil-통합 연산자 (nil-coalescing operator)_ (`a ?? b`) 는 옵셔널 `a` 에 값이 있으면 `a` 를 풀고, `a` 가 `nil` 이면 기본 설정 값인 `b` 를 반환합니다. 표현식 `a` 는 항상 옵셔널 타입이어야 합니다. 표현식 `b` 는 반드시 `a` 에 저장된 것과 타입이 일치해야 합니다.

'nil-통합 연산자 (nil-coalescing operator) 는 아래 코드의 약칭에 해당합니다:

```swift
a != nil ? a! : b
```

위의 코드는 '삼항 조건 연산자' 와 '강제 포장 풀기 (forced unwrapping; `a!`)' 를 사용하여 `a` 가 `nil` 이 아니면 `a` 안에 쌓여진 값에 접근하고, 그 외의 경우면 `b` 를 반환합니다. 이와 같이 'nil-통합 연산자' 가 제공하는 우아한 방법을 사용하면 조건 검사와 풀기 연산을 간결하고 이해하기 쉬운 양식으로 작성할 수 있습니다.

> `a` 의 값이 `nil` 이 아닐 경우, `b` 의 값을-계산하는 일은 일어나지 않습니다. 이를 '_단락-회로 계산 (short-circuit evaluation)_' 이라고 합니다. [^short-circuit]

아래 예제는 'nil-통합 연산자' 를 사용하여 '기본 색상 이름' 과 '사용자가 정의한 옵셔널 색상 이름' 중 하나를 선택합니다:

```swift
let defaultColorName = "red"
var userDefinedColorName: String?   // 기본으로 nil 이 됩니다.

var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 이 nil 이므로, colorNameToUse 는 기본 설정 값인 "red" 입니다.
```

`userDefinedColorName` 변수는 옵셔널 `String` 으로 정의되었으며, 기본 설정 값은 `nil` 입니다. `userDefinedColorName` 이 옵셔널 타입이므로, 해당 값에 `nil-통합 연산자` 를 적용할 수 있습니다. 위 예에서는, 이 연산자를 사용하여 `colorNameToUse` 라는 `String` 변수의 기본 설정 값을 결정합니다. `userDefinedColorName` 이 `nil` 이기 때문에, 표현식 `userDefinedColorName ?? defaultColorName` 은 `defaultColorName` 의 값을 반환하며, 이는 `"red"` 입니다.

만약 '`nil` 이 아닌 값' 을 `userDefinedColorName` 에 할당한 다음에 'nil-통합 연산자 (nil-coalescing operator)' 검사를 다시 수행하면, 기본 설정 값 대신 `userDefinedColorName` 로 감싼 값을 사용합니다:

```swift
userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 이 nil 이 아니므로, colorNameToUse 는 "green" 으로 설정됩니다.
```

### Range Operators (범위 연산자)

스위프트는 값의 범위를 간단하게 표현할 수 있는 여러 가지의 _범위 연산자 (range operators)_ 를 포함하고 있습니다.

#### Closed Range Operator (닫힌 범위 연산자)

'닫힌 범위 연산자 (closed range operator)' (`a...b`) 는 `a` 에서 `b` 에 이르는 범위를 정의하면서, `a` 와 `b` 의 값을 포함합니다. 여기서 `a` 의 값은 `b` 보다 절대로 크면 안됩니다.

'닫힌 범위 연산자' 는 범위 내에 있는 모든 값에 동작을 반복 적용할 때 유용하며, 보통 `for-in` 반복문과 같이 사용하게 됩니다:

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

'_반-열린 범위 연산자 (half-open range operator)_' (`a..<b`) 는 `a` 에서 `b` 에 이르는 범위를 정의하면서, `b` 는 포함하지 않습니다. _반-열린 (half-open)_ 이라는 말은 이것이 첫 번째 값은 갖지만, 마지막 값은 갖지 않기 때문입니다. '닫힌 범위 연산자' 와 마찬가지로, `a` 의 값은 `b` 보다 절대로 크면 안됩니다. 만약 `a` 의 값이 `b` 와 같을 경우, 그 결과는 빈 범위가 됩니다.

'반-열린 범위 연산자' 는 배열처럼 '0-시작 목록 (zero-based lists)' 과 작업할 때 특히 더 유용한데, 이는 목록 전체를 반복하면서 마지막 수를 포함하지 않기 때문입니다.

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

이 배열은 4 개의 항목을 갖지만, `0..<count` 는 (배열 마지막 요소의 색인인) `3` 까지만 헤아리며, 이는 '반-열린 연산자' 이기 때문입니다. 배열에 대해서는 [Arrays (배열)]({% post_url 2016-06-06-Collection-Types %}#arrays-배열) 을 보기 바랍니다.

#### One-Sided Ranges (한-쪽 범위)

'닫힌 범위 연산자' 는 한 방향으로 가능한 멀리 계속되는 범위를 나타낼 수 있는 '대체 양식 (alternative form)' 을 갖고 있습니다-예를 들어, 한 배열에 대해 2 에서 부터 끝까지의 모든 배열 요소를 포함하는 범위가 있을 수 있습니다. 이 경우, 범위 연산자의 한-쪽 값을 생략할 수 있습니다. 이러한 종류의 범위를 _한-쪽 범위 (one-sided range)_ 라고 부르며, 이는 연산자가 오직 한 쪽 값만을 갖고 있기 때문입니다. 예를 들면 다음과 같습니다:

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

'반-열린 범위 연산자' 도 '한-쪽 양식 (one-sided form)' 을 갖고 있지만 대신 한-쪽 값은 반드시 마지막 값이어야 합니다. 값을 양쪽에 적어줄 때와 마찬가지로, 마지막 값은 범위에 포함되지 않습니다. 예를 들면 다음과 같습니다:

```swift
for name in names[..<2] {
  print(name)
}
// Anna
// Alex
```

'한-쪽 범위 (one-sided range)' 는 '첨자 연산 (subscript)' 뿐만 아니라, 다른 곳에서도 사용할 수 있습니다. '한-쪽 범위' 가 생략한 값이 첫 번째 값이면 동작을 반복 적용시킬 수 없는데, 이는 동작을 어디서부터 반복해야할 지 명확하지 않기 때문입니다. '한-쪽 범위' 가 마지막 값을 생략했을 때는 동작을 반복 적용시키는 것이 _가능 (can)_ 합니다; 다만, 범위가 무한정 계속되므로, 반복문에 명시적으로 종료 조건을 추가해야 합니다. '한-쪽 범위' 가 특정 값을 갖고 있는지를 검사할 수도 있는데, 이는 아래 코드 처럼 하면 됩니다:

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

[^modulo-opartion]: 'modulo operation' 은 수학적으로 엄밀한 '나머지 연산' 과 연관되어 있는 것 같습니다. 보다 자세한 내용은 위키피디아의 [Modulo operation](https://en.wikipedia.org/wiki/Modulo_operation) 글을 참고하기 바랍니다. 이와 연관된 한글 자료가 거의 없는 거 같은데, 한글로는 [합동 산술](https://ko.wikipedia.org/wiki/합동_산술) 부분을 보면 도움이 될 것 같습니다.

[^short-circuit]: 'short-circuit evaluation (단락-회로 계산)' 은 전기 공학에서 나온 개념인 듯 합니다. 전기 회로에서 'short-circuit (단락-회로)' 가 생기면 다른 곳으로 전류가 흐르지 않듯이, 컴퓨터 공학에서는 계산량을 줄이기 위해 불필요한 식의 계산을 하지 않는 것을 말합니다. 컴퓨터 용어로 'minimal evaluation (최소 계산)' 이라는 말도 사용하는 것 같습니다. 이에 대한 더 자세한 정보는 위키피디아의 [Short-circuit evaluation](https://en.wikipedia.org/wiki/Short-circuit_evaluation) 을 참고하기 바랍니다. (위키피디아에서 항목에 대한 번역은 아직 없는 것 같습니다.)

[^left-associative]: 'left-associative' 를 '왼쪽 우선-결합' 이라고 옮겼습니다. 이에 대한 더 자세한 정보는 위키피디아의 [Operator associativity (연산자 결합 법칙)](https://en.wikipedia.org/wiki/Operator_associativity) 항목을 참고하기 바랍니다.
