---
layout: post
comments: true
title:  "Swift 5.5: Basic Operators (기초 연산자)"
date:   2016-04-27 10:00:00 +0900
categories: Swift Language Grammar Basic Operators
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [The Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html) 부분[^The-Basics]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Basic Operators (기초 연산자)

_연산자 (operator)_ 는 값의 검사, 바꿈, 및 조합에 사용하는 '특수한 기호 (symbol) 또는 구절 (phrase)' 입니다. 예를 들어, '덧셈 연산자 (`+`)' 는, `let i = 1 + 2` 처럼, 두 수를 더하며, '논리 곱 (AND) 연산자 (`&&`)' 는, `if enterDoorCode && passedRetinaScan` 처럼, 두 '불리언 (Boolean) 값' 을 조합합니다.

스위프트는 C 같은 언어를 통해 이미 알고 있을 법한 연산자를 지원하며, 공통적인 코딩 에러를 없애도록 여러 가지 보유 능력을 개선합니다. '할당 (assignment) 연산자 (`=`)' 는, '같음 (equal to) 연산자 (`==`)' 를 의도할 때 실수로 사용되는 것을 막고자, 값을 반환하지 않습니다. (`+`,`-`, `*`, `/`, `%` 등등의) '산술 (arithmetic) 연산자' 는, 저장 타입의 허용 값 범위보다 더 커지거나 작아지는 값과 작업할 때의 예상치 못한 결과를 피하고자, '값 넘침 (value overflow)' 을 탐지하고 이를 허용치 않습니다. [Overflow Operator (값 넘침 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#overflow-operators-값-넘침-연산자) 에서 설명한 것처럼, 스위프트의 '값 넘침 (overflow) 연산자' 를 사용함으로써 '값 넘침 동작' 을 직접 선택할 수도 있습니다.

스위프트는 C 에서는 찾아볼 수 없는, `a..<b` 와 `a...b` 같은, 값의 범위를 나타내는 '줄임말 (shortcut)' 인, '범위 (range) 연산자' 도 제공합니다.

이 장은 스위프트의 일반적인 연산자를 설명합니다. [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) 에서 스위프트의 고급 연산자를 다루며, 자신만의 연산자 정의와 자신만의 타입을 위한 표준 연산자 구현 방법도 설명합니다.

### Terminology (용어)

연산자는 '단항 (unary), 이항 (binary), 또는 삼항 (ternary)' 입니다:

* _단항 (Unary)_ 연산자는 (`-a` 같은) 단일 대상에 대한 연산입니다. '단항 _접두사 (prefix)_ 연산자' 는 (`!b` 같이) 자신의 대상 바로 앞에 나타나며, '단항 _접미사 (suffix)_ 연산자' 는 (`c!` 같이) 대상 바로 뒤에 나타납니다.
* _이항 (Binary)_ 연산자는 (`2 + 3` 같은) 두 개의 대상에 대한 연산이며 자신의 두 대상 사이에 나타나기 때문에 _infix (중위))_[^infix] 입니다.
* _삼항 (Ternary)_ 연산자는 세 개의 대상에 대한 연산입니다. C 같이, 스위프트도, '삼항 조건 연산자 (`a ? b : c`)' 라는, 하나의 삼항 연산자만 가집니다.

연산자가 영향을 주는 값은 _피연산자 (operands)_ 입니다. `1 + 2` 라는 표현식에서, `+` 기호는 이항 연산자이며 자신의 두 피연산자는 `1` 과 `2` 라는 값입니다.

### Assignment Operator (할당 연산자)

_할당 연산자 (assignment operator_; `a = b`_)_ 는 `a` 값을 `b` 값으로 '초기화 또는 갱신 (update)' 합니다:

```swift
let b = 10
var a = 5
a = b
// a 는 이제 10 입니다.
```

할당 오른쪽이 '여러 개의 값을 가진 튜플' 이면, 이 원소들을 여러 개의 상수나 변수로 한 번에 분해할 수 있습니다:

```swift
let (x, y) = (1, 2)
// x 는 1 이고, y 는 2 입니다.
```

C 및 오브젝티브-C 의 할당 연산자와 달리, 스위프트의 할당 연산자는 스스로 값을 반환하지 않습니다. 다음 구문은 유효하지 않습니다:

```swift
if x = y {
  // x = y 가 값을 반환하지 않기 때문에, 유효하지 않습니다.
}
```

이 특징은 '실제로는 같음 연산자 (`==`) 를 의도할 때 할당 연산자 (`=`) 를 사용하는 사고' 를 막아줍니다. 스위프트 코드는, `if x = y` 를 무효로 만듦으로써, 이런 종류의 에러를 피하도록 돕습니다.

### Arithmetic Operators (산술 연산자)

스위프트는 모든 수치 타입에 대한 네 개의 표준 _산술 연산자 (arithmetic operators)_ 를 지원합니다:

* 덧셈 (`+`)
* 뺄셈 (`-`)
* 곱셈 (`*`)
* 나눗셈 (`/`)

```swift
1 + 2       // 3 과 같습니다.
5 - 3       // 2 와 같습니다.
2 * 3       // 6 가 같습니다.
10.0 / 2.5  // 4.0 과 같습니다.
```

C 및 오브젝티브-C 의 산술 연산자와 달리, 스위프트 산술 연산자는 기본적으로 '값의 넘침 (overflow)' 을 허용하지 않습니다. 값 넘침 동작은 '(`a &+ b` 같은) 스위프트의 값 넘침 연산자를 사용함으로써 직접 선택할 수 있습니다. [Overflow Operator (값 넘침 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#overflow-operators-값-넘침-연산자) 부분도 참고하기 바랍니다.

덧셈 연산자는 '`String` 이어붙이기 (concatenation)' 도 지원합니다:

```swift
"hello, " + "world"  // "hello, world" 와 같습니다.
```

#### Remainder Operator (나머지 연산자)

_나머지 연산자 (remainder operator_; `a % b`_)_ 는 `a` 안을 몇 배수의 `b` 로 채우는 지 알아내고 남은 (_나머지 (remainder)_ 라는) 값을 반환합니다.

> 다른 언어에서는 나머지 연산자 (`%`) 를 _모듈러 연산자 (modulo operator)_ 라고도 합니다. 하지만, 스위프트 음수에 대한 이의 동작은, 엄밀히 말해서, '모듈러 (modulo) 연산'[^modulo-opartion] 이라기 보다는 나머지에 해당합니다.

다음은 나머지 연산자의 작업 방법입니다. `9 % 4` 를 계산하기 위해, 처음에 `9` 안을 몇 개의 `4` 로 채울 지를 알아냅니다:

![Indentation](/assets/Swift/Swift-Programming-Language/Basic-Operators-remainder-operator-works.jpg)

두 개의 `4` 로 `9` 를 채울 수 있고, (주황색으로 보인) 나머지는 `1` 입니다.

스위프트로, 이는 다음처럼 작성할 수 있습니다:

```
9 % 4    // 1 과 같음
```

`a % b` 에 대한 답을 결정하기 위해, `%` 연산자는 다음 방정식을 계산하고 자신의 출력 결과로 `remainder` 를 반환합니다:

`a` = (`b` x `some multiplier`) + `remainder`

여기서 `some multiplier` 는 `a` 안을 채울 `b` 의 가장 큰 배수입니다.

이 방정식에 `9` 와 `4` 를 집어 넣으면 다음을 산출합니다:

`9` = (`4` x `2`) + `1`

`a` 가 음수 값일 때의 나머지 계산에도 똑같은 방법을 적용합니다:

```
-9 % 4   // -1 과 같음
```

방정식에 `-9` 와 `4` 를 집어 넣으면 다음을 산출합니다:

`-9` = (`4` x `-2`) + `-1`

나머지 값으로 `-1` 을 줍니다.

`b` 가 음수일 때는 `b` 의 부호를 무시합니다. 이는 `a % b` 와 `a % -b` 의 답은 항상 똑같다는 의미입니다.

#### Unary Minus Operator (단항 음수 연산자)

수치 값의 부호는, _단항 음수 연산자 (unary minus operator)_ 라는, `-` 접두사로 '전환 (toggled)' 할 수 있습니다:

```swift
let three = 3
let minusThree = -three       // minusThree 는 -3 과 같음
let plusThree = -minusThree   // plusThree 는 3 또는, "minus minus three" 와 같음
```

단항 음수 연산자 (`-`) 는, 어떤 공백도 없이, 자신의 연산 값 바로 앞에 붙입니다.

#### Unary Plus Operator (단항 양수 연산자)

_단항 양수 연산자 (unary plus operator_; `+`_)_ 는, 어떤 것도 바꾸지 않고, 단순히 자신의 연산 값을 반환합니다:

```swift
let minusSix = -6
let alsoMinusSix = +minusSix  // alsoMinusSix 는 -6 과 같음
```

단항 양수 연산자는 실제로 어떤 것도 안하긴 하지만, 음수에 단항 음수 연산자를 사용할 때의 코드 대칭성을 제공하기 위해 양수에 이를 사용할 수 있습니다.

### Compound Assignment Operators (복합 할당 연산자)

C 같이, 스위프트도 할당 연산 (`=`) 을 또 다른 연산과 조합한 _복합 할당 연산자 (compound assignment operators)_ 를 제공합니다. 한 가지 예는 _덧셈 할당 연산자 (addition assignment operator_; `+=`_)_ 입니다:

```swift
var a = 1
a += 2
// a 는 이제 3 입니다
```

`a += 2` 라는 표현식은 `a = a + 2` 를 '줄인 것 (shorthand)' 입니다. 사실상, 덧셈과 할당을 한 연산자로 조합하여 동시에 두 임무 모두 수행합니다.

> 복합 할당 연산자는 값을 반환하지 않습니다. 예를 들어, `let b = a += 2` 라고 작성할 수 없습니다.


스위프트 표준 라이브러리가 제공하는 연산자에 대한 정보는, [Operator Declaration (연산자 선언)](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 항목을 참고하기 바랍니다.

### Comparison Operators (비교 연산자)

스위프트는 다음의 _비교 연산자 (comparison operators)_ 를 지원합니다:

* 같음 (equal to; `a == b`)
* 같지 않음 (not equal to; `a != b`)
* 보다 큼 (greater than; `a > b`)
* 보다 작음 (less than; `a < b`)
* 크거나 같음 (greater than or equal to; `a >= b`)
* 작거나 같음 (less than or equal to; `a <= b`)

> 스위프트는, 두 객체 참조 모두가 똑같은 객체 인스턴스를 참조하는 지 검사하는, 두 개의 _식별 연산자 (identity operators_; `===` 와 `!==`_)_ 도 제공합니다. 더 많은 정보는, [Identity Operators (식별 연산자)]({% post_url 2020-04-14-Structures-and-Classes %}#identity-operators-식별-연산자) 부분을 참고하기 바랍니다.

각각의 비교 연산자는 '구문이 참인지 아닌 지를 지시하는 `Bool` 값' 을 반환합니다:

```swift
1 == 1   // 1 은 1 과 같기 때문에 참
2 != 1   // 2 는 1 과 같지 않기 때문에 참
2 > 1    // 2 는 1 보다 크기 때문에 참
1 < 2    // 1 은 2 보다 작기 때문에 참
1 >= 1   // 1 은 1 보다 크거가 같기 때문에 참
2 <= 1   // 2 는 1 보다 작거나 같지 않기 때문에 거짓
```

비교 연산자는, `if` 문 같은, 조건 (conditional) 문에서 자주 사용합니다:

```swift
let name = "world"
if name == "world" {
  print("hello, world")
} else {
  print("I'm sorry \(name), but I don't recognize you")
}
// name 이 진짜로 "world" 와 같기 때문에, "hello, world" 를 인쇄합니다.
```

`if` 문에 대한 더 많은 것은, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 장을 참고하기 바랍니다.

두 개의 '튜플' 이 똑같은 타입과 똑같은 개수의 값을 가지고 있으면 서로 비교할 수 있습니다. 튜플은, 두 값이 같지 않음을 찾을 때까지, 한 번에 한 값씩, 왼쪽에서 오른쪽으로 비교합니다. 이 두 값들을 비교하며, 해당 비교 연산의 결과가 '전체 튜플 비교 연산의 결과를 결정' 합니다. 모든 원소가 같으면, 튜플 자체가 같습니다. 예를 들면 다음과 같습니다:

```swift
(1, "zebra") < (2, "apple")   // 1 이 2 보다 작기 때문에 참; "zebra" 와 "apple" 은 비교하지 않음
(3, "apple") < (3, "bird")    // 3 은 3 과 같고, "apple" 은 "bird" 보다 작기 때문에 참
(4, "dog") == (4, "dog")      // 4 는 4 와 같고, "dog" 은 "dog" 과 같기 때문에 참
```

위 예제의, 첫 번째 줄에서 '왼쪽에서-오른쪽 비교 동작' 을 볼 수 있습니다. `1` 이 `2` 보다 작기 때문에, 튜플의 다른 어떤 값과는 상관없이, `(1, "zebra")` 는 `(2, "apple")` 보다 작다고 고려합니다. 비교 연산이 이미 튜플의 첫 번째 원소로 결정됐기 때문에, `"zebra"` 가 `"apple"` 보다 작지 않다는 건 중요하지 않습니다. 하지만, 튜플의 첫 번째 원소가 똑같을 땐, 자신의 두 번째 원소 _를 (are)_ 비교합니다-이것이 두 번째와 세 번째 줄에서 발생한 일입니다.

튜플 각자의 각 값마다 연산자를 적용할 수 있는 경우에만 주어진 연산자로 튜플을 비교할 수 있습니다.

예를 들어, 아래 코드에서 실증하는 것처럼, `String` 과 `Int` 값 둘 다 `<` 연산자로 비교할 수 있기 때문에 `(String, Int)` 타입의 두 튜플은 비교할 수 있습니다. 이와 대조적으로, `Bool` 값에는 `<` 연산자를 적용할 수 없기 때문에 `(String, Bool)` 타입의 두 튜플은 `<` 연산자로 비교할 수 없습니다.

```swift
("blue", -1) < ("purple", 1)        // OK, 참이라고 평가합니다.
("blue", false) < ("purple", true)  // 에러, '<' 가 불리언 값을 비교할 수 없기 때문입니다.
```

> 스위프트 표준 라이브러리는 '7개 미만의 원소를 가진 튜플' 에 대한 튜플 비교 연산자를 포함합니다. 7개 이상의 원소를 가진 튜플을 비교하려면, 반드시 비교 연산자를 스스로 구현해야 합니다.

### Ternary Conditional Operator (삼항 조건 연산자)

_삼항 조건 연산자 (ternary conditional operator)_ 는, `question ? answer1 : answer2` 라는 형식을 취하는, 세 부분으로 된 특수한 연산자입니다. 이는 `question` 이 참인지 거짓인지를 기초로 '두 표현식 중 하나를 평가하는 줄임말 (shortcut)' 입니다. `question` 이 참이면, `answer1` 의 평가 값을 반환하며; 그 외의 경우, `answer2` 의 평가 값을 반환합니다.

삼항 조건 연산자는 아래 코드를 줄인 것입니다:

```swift
if question {
  answer1
} else {
  answer2
}
```

다음은, 표의 행 높이를 계산하는, 예제입니다. 행이 제목 행이면 행 높이는 '내용물 (content) 높이' 보다 50 포인트 만큼 더 크며, 제목 행이 아니면 20 포인트 만큼 더 큽니다:

```swift
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight 는 90 입니다.
```

위 예제는 아래 코드를 줄인 것입니다:

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

첫 번째 예제 처럼 삼항 조건 연산자를 사용하면, 두 번째 예제 코드보다 더 간결하게, 단 한 줄의 코드로 `rowHeight` 에 올바른 값을 설정할 수 있습니다.

삼항 조건 연산자는 '두 표현식 중 고려할 것을 정하는 효율적인 줄임 표현' 을 제공합니다. 하지만, 삼항 조건 연산자를 주의해서 사용합니다. 간결하다고 막 쓰다보면 이해하기-어려운 코드를 만들 수 있습니다. 여러 개의 삼항 조건 연산자를 하나의 복합 구문으로 조합하는 걸 피하기 바랍니다.

### Nil-Coalescing Operator (Nil-합체 연산자)

_nil-합체 연산자 (nil-coalescing operator_; `a ?? b`_)_ 는 옵셔널 `a` 가 값을 담고 있으면 포장을 풀고, `a` 가 `nil` 이면 기본 값인 `b` 를 반환합니다. 표현식 `a` 는 항상 옵셔널 타입입니다. 표현식 `b` 는 반드시 `a` 안에 저장한 타입과 일치해야 합니다.

'nil-합체 연산자' 는 아래 코드를 줄인 것입니다:

```swift
a != nil ? a! : b
```

위 코드는 '삼항 조건 연산자와 강제 포장 풀기 (`a!`) 를 사용' 하여 `a` 가 `nil` 이 아닐 땐 `a` 안의 포장 값에 접근하고, 그 외 경우엔 `b` 를 반환합니다. 'nil-합체 연산자' 는 '이런 조건 검사와 포장 풀기를 간결하고 이해 가능한 형식으로 은닉' 하는 더 우아한 방식을 제공합니다.

> `a` 가 `nil`-아닌 값이면, `b` 값을 평가하지 않습니다. 이를 _단락-회로 계산 (short-circuit evaluation)_ 이라고 합니다.[^short-circuit]

아래 예제는 'nil-합체 연산자' 로 '기본 색상 이름' 과 '사용자가 옵션으로-정의한 색상 이름' 중 하나를 선택합니다:

```swift
let defaultColorName = "red"
var userDefinedColorName: String?   // 기본은 nil 임

var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 이 nil 이므로, colorNameToUse 를 "red" 라는 기본 값으로 설정함
```

`userDefinedColorName` 변수는, `nil` 이라는 기본 값을 가진, 옵셔널 `String` 이라고 정의합니다. `userDefinedColorName` 이 옵셔널 타입이기 때문에, 값을 고려할 때 `nil-합체 연산자` 를 사용할 수 있습니다. 위 예제에서는, 연산자는 `colorNameToUse` 라는 `String` 변수의 초기 값을 결정하는데 사용합니다.`userDefinedColorName` 이 `nil` 이기 때문에, `userDefinedColorName ?? defaultColorName` 라는 표현식은 `defaultColorName` 의 값인, `"red"` 를 반환합니다.

`nil`-아닌 값을 `userDefinedColorName` 에 할당하고 nil-합체 연산자 검사를 다시 하면, `userDefinedColorName` 안의 포장 값을 기본 값 대신 사용합니다:

```swift
userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 이 nil 이 아니므로, colorNameToUse 를 "green" 으로 설정함
```

### Range Operators (범위 연산자)

스위프트는, 값의 범위를 표현하는 줄임말인, 여러 개의 _범위 연산자 (range operators)_ 를 포함합니다.

#### Closed Range Operator (닫힌 범위 연산자)

_닫힌 범위 연산자 (closed range operator;_ `a...b`_)_ 는 `a` 에서 `b` 에 이르는 범위를 정의하며, `a` 와 `b` 값도 포함합니다. `a` 값은 반드시 `b` 보다 크지 않아야 합니다.

닫힌 범위 연산자는, `for`-`in` 반복문 같이, 모든 값을 사용하고 싶은 범위를 반복할 때 유용합니다:

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

`for-in` 반복문에 대한 더 많은 것은, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 장을 참고하기 바랍니다.

#### Half-Open Range Operator (반-열린 범위 연산자)

_반-열린 범위 연산자 (half-open range operator;_ `a..<b`_)_ 는 `a` 에서 `b` 에 이르는 범위를 정의하지만, `b` 를 포함하진 않습니다. _반-열린 (half-open)_ 이라는 건 '첫 번째 값은 담지만, 최종 값은 아니기 때문' 입니다. 닫힌 범위 연산자에서 처럼, `a` 값은 반드시 `b` 보다 크지 않아야 합니다. `a` 값이 `b` 와 같으면, 결과 범위가 '빌 (empty)' 것입니다.

반-열린 범위는 배열 같이, 목록 길이를 (포함하지 않고) 세는 것이 유용한 곳에서, '기초가-0인 (zero-based)[^zero-based] 목록' 과 작업할 때 특히 더 유용합니다:

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

배열에 네 개의 항목이 담겨 있지만, `0..<count` 이, 반-열린 연산자이기 때문에, (배열의 마지막 항목 색인인) `3` 까지만 셉니다. 배열에 대한 더 많은 것은, [Arrays (배열)]({% post_url 2016-06-06-Collection-Types %}#arrays-배열) 부분을 참고하기 바랍니다.

#### One-Sided Ranges (한-쪽 범위)

닫힌 범위 연산자는 '한 쪽 방향으로 계속되는 범위-예를 들어, 색인 2 부터 배열 끝까지의 모든 배열 원소를 포함한 범위-에 대한 대안 형식' 을 가집니다. 이 경우, 범위 연산자의 한 쪽 값을 생략할 수 있습니다. 이런 종류의 범위를 _한-쪽 범위 (one-sided range)_ 라고 하는데 연산자가 한 쪽에만 값을 가지기 때문입니다. 예를 들면 다음과 같습니다:

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

반-열린 범위 연산자도 자신의 최종 값만 작성하는 '한-쪽 형식 (one-sided form)' 을 가집니다. 양 쪽에 값을 포함할 때와 같이, 최종 값은 범위의 일부분이 아닙니다. 예를 들면 다음과 같습니다:

```swift
for name in names[..<2] {
  print(name)
}
// Anna
// Alex
```

한-쪽 범위는, '첨자 연산' 뿐 아니라, 다른 상황에서도 사용할 수 있습니다. '첫 번째 값을 생략한 한-쪽 범위' 에 동작을 반복할 순 없는데, 반복을 시작할 곳이 명확하지 않기 때문입니다. '최종 값을 생략한 한-쪽 범위' 에는 동작을 반복 _할 수 (can)_ 있지만; 범위가 무한정 계속되기 때문에, 반복문에 명시적인 종료 조건을 확실히 추가하도록 합니다. 아래 코드에서 보는 것처럼, 한-쪽 범위가 특별한 값을 담고 있는 지도 검사할 수 있습니다.

```swift
let range = ...5
range.contains(7)   // 거짓
range.contains(4)   // 참
range.contains(-1)  // 참
```

### Logical Operators (논리 연산자)

_논리 연산자 (logical operators)_ 는 '`true` 와 `false` 라는 불리언 (Boolean) 논리 값' 을 수정 또는 조합합니다. 스위프트는 'C-에 기초한 언어[^c-based-languages] 의 표준 논리 연산자 세 개' 를 지원합니다:

* 논리 부정 (Logical NOT; `!a`)
* 논리 곱 (Logical AND; `a && b`)
* 논리 합 (Logical OR; `a || b`)

#### Logical NOT Operator (논리 부정 연산자)

_논리 부정 연산자 (logical NOT operator;_ `!a`_)_ 는 '불리언 값' 을 거꾸로 만들어서 `true` 는 `false` 가 되고, `false` 는 `true` 가 됩니다.

논리 부정 연산자는 '접두사 (prefix) 연산자' 이며, 어떤 공백도 없이, 자신의 연산 값 바로 앞에 나타냅니다. 이는, 다음 예제에서 보는 것처럼, “`a` 아닌 것 (not `a`)” 으로 이해할 수 있습니다:

```swift
let allowedEntry = false
if !allowedEntry {
  print("ACCESS DENIED")
}
// "ACCESS DENIED" 를 인쇄합니다.
```

`if !allowedEntry` 라는 절은 "허용된 진입이 아니면 (if not allowed entry)" 으로 이해할 수 있습니다. 뒤이은 줄은 "허용된 진입이 아닌 것" 이 참일 경우에만; 즉, `allowedEntry` 가 `false` 인 경우에만, 실행합니다.

이 예제에서 처럼, '불리언 상수와 변수 이름' 은 신경써서 선택해야, 이중 부정 또는 논리 문의 혼동을 피하면서, 코드를 이해 가능하고 간단하게 유지할 수 있습니다.

#### Logical AND Operator (논리 곱 연산자)

_논리 곱 연산자 (logical AND operator;_ `a && b`_)_ 는 '반드시 두 값 모두 `true` 여야 전체적인 표현식도 `true` 가 되는 논리 표현식 (logical expressions)' 을 생성합니다.

어느 값이든 `false` 면, 전체적인 표현식도 `false` 가 될 것입니다. 사실, _첫 번째 (first)_ 값이 `false` 면, 전체적인 표현식을 `true` 로 만드는 것이 불가능하기 때문에, 심지어 두 번째 값을 평가하지도 않을 것입니다. 이를 _단락-회로 계산 (short-circuit evaluation)_[^short-circuit] 이라고 합니다.

다음 예제는 두 `Bool` 값을 고려하여 두 값 모두 `true` 일 때만 접근을 허용합니다:

```swift
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
  print("Welcome!")
} else {
  print("ACCESS DENIED")
}
// "ACCESS DENIED" 를 인쇄합니다.
```

#### Logical OR Operator (논리 합 연산자)

'_논리 합 연산자_ (_logical OR operator;_ `a || b`)' 는 두 개의 인접한 '파이프 문자 (`|`)' 로 만든 '중위 (infix) 연산자' 입니다. 이를 사용하여 두 값 중 _하나 (one)_ 만 `true` 면 전체적인 표현식이 `true` 가 되는 '논리 표현식' 를 생성합니다.

위의 '논리 곱 연산자' 와 같이, '논리 합 (Logical OR) 연산자' 는 표현식을 고려할 때 '단락-회로 계산'[^short-circuit] 을 사용합니다. '논리 합 표현식' 의 왼쪽이 `true` 면, 오른쪽은 평가하지 않는데, 이것이 전체적인 표현식의 결과물을 바꿀 순 없기 때문입니다.

아래 예제에서, 첫 번째 `Bool` 값인 (`hasDoorKey`) 는 `false` 지만, 두 번째 값인 (`knowsOverridePassword`) 는 `true` 입니다. 한 값이 `true` 이기 때문에, 전체적인 표현식 역시 `true` 로 평가하여, 접근을 허용합니다:

```swift
let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
  print("Welcome!")
} else {
  print("ACCESS DENIED")
}
// "Welcome!" 을 인쇄합니다.
```

#### Combining Logical Operators (논리 연산자 조합하기)

여러 논리 연산자를 조합하여 더 긴 '복합 표현식 (compound expressions)' 을 생성할 수 있습니다:

```swift
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
  print("Welcome!")
} else {
  print("ACCESS DENIED")
}
// "Welcome!" 을 인쇄합니다.
```

이 예제는 더 긴 '복합 표현식' 을 생성하기 위해 여러 개의 `&&` 와 `||` 연산자를 사용합니다. 하지만, `&&` 와 `||` 연산자는 여전히 두 값에만 작용하므로, 이는 실제로 세 개의 작은 표현식이 서로 '연쇄되어 있는 (chained)' 것입니다. 이 예제는 다음 처럼 이해할 수 있습니다:

올바른 출입문 코드를 입력했고 망막 스캔도 통과한 경우, 또는 유효한 출입문 키를 가진 경우, 아니면 '비상용 수동해제 비밀번호 (emergency override password)' 를 알고 있는 경우라면, 접근을 허용하기 바랍니다.

`enterDoorCode`, `passedRetinaScan`, 그리고 `hasDoorKey` 의 값에 기초하면, 처음 두 '하위표현식 (subexpressions)' 은 `false` 입니다. 하지만, '비상용 수동해제 비밀번호' 를 알고 있으므로, 전체적인 복합 표현식은 여전히 `true` 로 평가됩니다.

> 스위프트 논리 연산자 `&&` 와 `||` 는 '왼쪽-결합 (left-associative)'[^left-associative] 인데, 이는 '다중 (multiple) 논리 연산자' 를 가진 '복합 표현식' 이 가장 왼쪽 '하위 표현식' 을 먼저 계산한다는 의미입니다.

#### Explicit Parentheses (명시적인 괄호)

꼭 필요하진 않을 때라도, 복잡한 표현식의 의도를 이해하기 더 쉽도록, '괄호 (parentheses)' 를 포함시키는 것이 유용할 때가 있습니다. 위 '출입문 접근' 예제에서, 의도를 명시적으로 만들려면 복합 표현식의 첫 번째 부분에 괄호를 추가하는 것이 좋습니다:

```swift
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
  print("Welcome!")
} else {
  print("ACCESS DENIED")
}
// "Welcome!" 를 인쇄합니다.
```

괄호는 처음 두 값이 전체적인 논리에서 '별도로 가능한 상태' 로 고려된다는 것을 명확하게 만듭니다. 복합 표현식의 출력은 바뀌지 않지만, 전체적인 의도는 더 명확해 집니다. '가독성 (readability)' 은 항상 '간결함 (brevity)' 보다 좋습니다; 의도를 명확하게 만드는데 도움이 될 때는 괄호를 사용하기 바랍니다.

### 다음 장

[Strings and Characters (문자열과 문자) > ]({% post_url 2016-05-29-Strings-and-Characters %})

### 참고 자료

[^Basic-Operators]: 원문은 [Basic Operators](https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^modulo-opartion]: 'modulo operation (모듈러 연산)' 은 '수학적으로 엄밀하게 정의한 나머지 연산' 을 의미합니다. 이에 대한 더 자세한 정보는, 위키피디아의 [Modulo operation](https://en.wikipedia.org/wiki/Modulo_operation) 항목을 참고하기 바랍니다. 이에 대한 한글 자료는 거의 없는데, [합동 산술](https://ko.wikipedia.org/wiki/합동_산술) 항목이 연관이 있는 것 같습니다.

[^short-circuit]: '단락-회로 계산 (short-circuit evaluation)' 은 전기 공학에서 나온 개념입니다. 전기 회로에서 '단락 회로 (short-circuit)' 가 생기면 다른 곳으로 전류가 흐르지 않듯이, '단락-회로 계산' 은 '컴퓨터 공학에서 계산량을 줄일 목적으로 불필요한 표현식 계산을 하지 않는 방식' 이라고 할 수 있습니다. 컴퓨터 용어로는 '최소 계산 (minimal evaluation)' 이라고도 하는데, 이에 대한 더 자세한 정보는, 위키피디아의 [Short-circuit evaluation](https://en.wikipedia.org/wiki/Short-circuit_evaluation) 항목을 참고하기 바랍니다. (아직 한글 번역은 없는 것 같습니다.)

[^left-associative]: '왼쪽-결합 (left-associative)' 는 '연산자 결합성 (operator associativity)' 의 한 가지 방식입니다. '연산자 결합성' 은 괄호 없이 묶인 연산자들이 같은 우선 순위를 가질 경우에 작동하는 방식입니다. 이에 대한 더 자세한 정보는 위키피디아의 [Operator associativity](https://en.wikipedia.org/wiki/Operator_associativity) 항목을 참고하기 바랍니다. (위키피디아에 이 항목에 대한 번역은 아직 없는 것 같습니다.)

[^infix]: 'infix' 는 '중간에 위치' 한다는 의미로 '중위' 라고 합니다. '중위 (infix)' 라는 말에 대한 더 자세한 정보는, 위키피디아의 [Infix notation](https://en.wikipedia.org/wiki/Infix_notation) 항목과 [중위 표기법](https://ko.wikipedia.org/wiki/중위_표기법) 항목을 참고하기 바랍니다.

[^operator-declarations]: 원문 자체가 애플 개발자 사이트의 링크로 되어 있습니다. 해당 페이지에 스위프트 표준 라이브러리가 제공하는 연산자에 대한 전체 목록이 있습니다.

[^zero-based]: '기초가-0인 목록 (zero-based lists)' 은 '0으로 시작하는 색인 (index) 을 가진 목록' 입니다. 이에 대한 더 많은 정보는, 위키피디아의 [Zero-based numbering](https://en.wikipedia.org/wiki/Zero-based_numbering) 항목을 참고하기 바랍니다.

[^c-based-languages]: 'C-에 기초한 언어 (C-based languages)' 는 'C-family' 라고도 하며, 여기에 속한 언어들의 목록은 위키피디아의 [List of C-family programming languages](https://en.wikipedia.org/wiki/List_of_C-family_programming_languages) 항목에서 확인할 수 있습니다. 애플에서 만든 '오브젝티브-C (Objective-C)' 와 '스위프트 (Swift)' 는 모두 'C-family' 임을 알 수 있습니다.
