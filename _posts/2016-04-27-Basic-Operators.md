---
layout: post
comments: true
title:  "Swift 5.7: Basic Operators (기초 연산자)"
date:   2016-04-27 10:00:00 +0900
categories: Swift Language Grammar Basic Operators
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [The Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html) 부분[^The-Basics]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Basic Operators (기초 연산자)

_연산자 (operator)_ 는 특수한 기호[^symbol] 나 구절[^phrase] 로서 값의 검사, 바꿈, 또는 조합에 사용합니다. 예를 들어, 덧셈 연산자 (`+`) 는, `let i = 1 + 2` 처럼, 두 수를 더하고, 논리 곱 (AND) 연산자 (`&&`) 는, `if enterDoorCode && passedRetinaScan` 처럼, 두 불리언 값을 조합합니다.

스위프트는 **C** 같은 언어로 이미 알고 있을 연산자를 지원하면서, 여러 가지 보유 능력을 개선하여 공통적인 코딩 에러를 없앱니다. 할당 연산자 (`=`)[^assignment] 는 값을 반환하지 않아서, 같음 연산자 (`==`)[^equal-to] 를 의도할 때 실수로 사용되는 걸 막아줍니다. (`+`,`-`, `*`, `/`, `%` 등의) 산술 연산자[^arithmetic] 는 값 넘침[^value-overflow] 을 탐지하고 이를 허용치 않아서, 저장 타입이 허용한 값 범위보다 더 커지거나 작아진 수와 작업할 때의 예상치 못한 결과를 피해줍니다. [Overflow Operator (값 넘침 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#overflow-operators-값-넘침-연산자) 에서 설명하듯, 스위프트의 값 넘침 연산자를 사용하여 값 넘침 동작을 직접 선택할 수 있습니다.

스위프트는 C 에서는 찾아볼 수 없는, 값의 범위를 표현하는 줄임말인, `a..<b` 와 `a...b` 같은, 범위 연산자[^range] 도 제공합니다.

이 장에선 일반적으로 흔한 스위프트 연산자를 설명합니다. 스위프트의 고급 연산자와, 자신만의 연산자를 정의하는 방법 및 자신만의 타입에 표준 연산자를 구현하는 방법은 [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) 에서 다룹니다.

### Terminology (용어)

연산자는 단항[^unary] 이거나, 이항[^binary], 또는 삼항[^ternary] 입니다:

* _단항 (Unary)_ 연산자는 (`-a` 같이) 단일 대상에 대한 연산입니다. 단항 _접두사 (prefix)_ 연산자는 (`!b` 같이) 자신의 대상 바로 앞에 나타나며, 단항 _접미사 (suffix)_ 연산자는 (`c!` 같이) 자신의 대상 바로 뒤에 나타납니다.
* _이항 (Binary)_ 연산자는 (`2 + 3` 같이) 두 개의 대상에 대한 연산이며 자신의 두 대상 사이에 나타나기 때문에 _infix (중위))_[^infix] 입니다.
* _삼항 (Ternary)_ 연산자는 세 개의 대상에 대한 연산입니다. **C** 같이, 스위프트에도 단 하나의 삼항 연산자만 있는데, 삼항 조건 연산자 (`a ? b : c`) 가 그것입니다.

연산자가 영향을 주는 값은 _피연산자 (operands)_ 입니다. `1 + 2` 표현식에서, `+` 기호는 중위 연산자이고 두 개의 피연산자는 `1` 과 `2` 라는 값입니다.

### Assignment Operator (할당 연산자)

_할당 연산자 (assignment operator_; `a = b`_)_ 는 `a` 값을 `b` 값으로 초기화하거나 업데이트합니다.:

```swift
let b = 10
var a = 5
a = b
// a 는 이제 10 임
```

할당 오른쪽이 튜플이라 값이 여러 개면, 한 번에 여러 개의 상수나 변수로 원소를 분해할 수 있습니다:

```swift
let (x, y) = (1, 2)
// x 는 1 과 같고, y 는 2 와 같음
```

**C** 및 **오브젝티브-C** 의 할당 연산자와 달리, 스위프트의 할당 연산자는 그 자체로 값을 반환하지 않습니다. 다음 구문은 유효하지 않습니다:[^not-valid]

```swift
if x = y {
  // x = y 가 값을 반환하지 않기 때문에, 유효하지 않습니다.
}
```

이런 특징은 실제로 의도한 건 같음 연산자 (`==`) 일 때에 할당 연산자 (`=`) 를 사용하게 되는 사고를 막아줍니다. `if x = y` 를 무효로 만듦으로써, 코드 안에서 이런 종류의 에러를 피하도록 스위프트가 도와줍니다.

### Arithmetic Operators (산술 연산자)

스위프트는 모든 수치 타입을 위한 네 개의 표준 _산술 연산자 (arithmetic operators)_ 를 지원합니다:

* 덧셈 (`+`)
* 뺄셈 (`-`)
* 곱셈 (`*`)
* 나눗셈 (`/`)

```swift
1 + 2       // 3 과 같음
5 - 3       // 2 와 같음
2 * 3       // 6 과 같음
10.0 / 2.5  // 4.0 과 같음
```

**C** 및 **오브젝티브-C** 의 산술 연산자와 달리, 스위프트의 산술 연산자는 기본적으로 값 넘침을 허용하지 않습니다. 값 넘침 동작을 직접 선택하려면 (`a &+ b` 같이) 스위프트의 값 넘침 연산자를 사용하면 됩니다. [Overflow Operator (값 넘침 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#overflow-operators-값-넘침-연산자) 부분도 보도록 합니다.

덧셈 연산자는 `String` 이어붙이기[^concatenation] 도 지원합니다:

```swift
"hello, " + "world"  // "hello, world" 와 같음
```

#### Remainder Operator (나머지 연산자)

_나머지 연산자 (remainder operator_; `a % b`_)_ 는 몇 배수의 `b` 가 `a` 안에 들어가는지 알아내고 남은 (_나머지 (remainder)_ 라는) 값을 반환합니다.

> 다른 언어에선 나머지 연산자 (`%`) 를 _모듈러 연산자 (modulo operator)_ 라고도 합니다.[^modulo-opartion] 하지만, 스위프트의 음수에 대한 이 동작은, 엄밀히 말해서, 모듈러라기 보단 나머지 연산입니다.[^remainder-vs-modulo]

나머지 연산자는 이렇게 작업합니다. `9 % 4` 를 계산하려면, 첫 번째로 `9` 안에 몇 개의 `4` 가 들어가는 지를 알아냅니다:

![Indentation](/assets/Swift/Swift-Programming-Language/Basic-Operators-remainder-operator-works.jpg)

`9` 안엔 두 개의 `4` 가 들어갈 수 있고, (주황색으로 본) 나머지는 `1` 입니다.

스위프트에선, 이를 다음 처럼 작성할 겁니다:

```swift
9 % 4    // 1 과 같음
```

`a % b` 의 답을 결정하려고, `%` 연산자는 다음 방정식을 계산하며 출력 결과로 `remainder` 를 반환합니다:

`a` = (`b` x `some multiplier`) + `remainder`

여기서 `some multiplier` 는 `a` 안에 들어갈 가장 큰 `b` 의 배수입니다.

이 방정식에 `9` 와 `4` 를 집어 넣으면 (다음이) 나옵니다:

`9` = (`4` x `2`) + `1`

`a` 가 음수 값일 때의 나머지 계산도 똑같은 방법을 적용합니다:

```swift
-9 % 4   // -1 과 같음
```

이 방정식에 `-9` 와 `4` 를 집어 넣으면 (다음이) 나옵니다:

`-9` = (`4` x `-2`) + `-1`

`-1` 을 나머지 값으로 줍니다.

`b` 가 음수면 `b` 의 부호를 무시합니다. 이는 `a % b` 와 `a % -b` 가 항상 똑같은 답을 준다는 의미입니다.

#### Unary Minus Operator (단항 음수 연산자)

수치 값 부호는 `-` 접두사로 반전할 수 있는데, 이를 _단항 음수 연산자 (unary minus operator)_ 라는 합니다:

```swift
let three = 3
let minusThree = -three       // minusThree 는 -3 과 같음
let plusThree = -minusThree   // plusThree 는 3 또는, "minus minus three" 와 같음
```

단항 음수 연산자 (`-`) 는, 어떤 공백도 없이, 자신의 연산 값 바로 앞에 붙입니다.

#### Unary Plus Operator (단항 양수 연산자)

_단항 양수 연산자 (unary plus operator_; `+`_)_ 는 단순히 자신의 연산 값을 반환하며, 어떤 바꾸지 않습니다:

```swift
let minusSix = -6
let alsoMinusSix = +minusSix  // alsoMinusSix 는 -6 과 같음
```

단항 양수 연산자는 실제로 하는게 아무 것도 없지만, 단항 음수 연산자를 음수에 쓸 때 이를 양수에 쓰면 코드에 대칭성을 제공할 수 있습니다.

### Compound Assignment Operators (복합 할당 연산자)

**C** 와 같이, 스위프트는 _복합 할당 연산자 (compound assignment operators)_ 를 제공하여 할당 (`=`) 과 다른 연산을 조합합니다. 한 가지 예는 _덧셈 할당 연산자 (addition assignment operator_; `+=`_)_ 입니다:

```swift
var a = 1
a += 2
// a 는 이제 3 과 같음
```

표현식 `a += 2` 는 `a = a + 2` 를 짧게 줄인 겁니다. 그 효과로, 덧셈과 할당을 하나의 연산자로 조합하여 두 임무를 동시에 수행합니다.

> 복합 할당 연산자는 값을 반환하지 않습니다. 예를 들어, `let b = a += 2` 라고 작성할 수 없습니다.

스위프트 표준 라이브러리에서 제공하는 연산자에 대한 정보는, [Operator Declaration (연산자 선언)](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 항목을 보도록 합니다.

### Comparison Operators (비교 연산자)

스위프트는 다음의 _비교 연산자 (comparison operators)_ 를 지원합니다:

* 같음 (`a == b`)
* 같지 않음 (`a != b`)
* 보다 큼 (`a > b`)
* 보다 작음 (`a < b`)
* 크거나 같음 (`a >= b`)
* 작거나 같음 (`a <= b`)

> 스위프트는 두 개의 _정체 식별 연산자 (identity operators_; `===` 와 `!==`_)_ 도 제공하는데, 이를 사용하여 두 객체 참조가 둘 다 똑같은 객체 인스턴스를 참조하는지 검사합니다. 더 많은 정보는, [Identity Operators (정체 식별 연산자)]({% post_url 2020-04-14-Structures-and-Classes %}#identity-operators-정체-식별-연산자) 부분을 보도록 합니다.

각각의 비교 연산자는 `Bool` 값을 반환하여 구문이 참인지 아닌지 지시합니다:

```swift
1 == 1   // 1 은 1 과 같기 때문에 참
2 != 1   // 2 는 1 과 같지 않기 때문에 참
2 > 1    // 2 는 1 보다 크기 때문에 참
1 < 2    // 1 은 2 보다 작기 때문에 참
1 >= 1   // 1 은 1 보다 크거가 같기 때문에 참
2 <= 1   // 2 는 1 보다 작거나 같지 않기 때문에 거짓
```

비교 연산자는, `if` 문 같은, 조건문에서 자주 사용합니다:

```swift
let name = "world"
if name == "world" {
  print("hello, world")
} else {
  print("I'm sorry \(name), but I don't recognize you")
}
// "hello, world" 를 인쇄하는데, name 이 진짜로 "world" 와 같기 때문임
```

`if` 문에 대한 더 많은 내용은, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 장을 보도록 합니다.

두 개의 튜플이 똑같은 타입이면서 똑같은 개수의 값이 있다면 서로 비교할 수 있습니다. 튜플 비교 연산은 왼쪽에서 오른쪽으로, 한 번에 한 값씩, 두 값이 같지 않은 걸 찾을 때까지, 비교합니다. 그렇게 두 값을 비교하며, 그 비교 연산의 결과가 전체 튜플 비교 연산의 결과를 결정합니다. 모든 원소가 같으면, 튜플 그 자체가 같습니다. 예를 들면 다음과 같습니다:

```swift
(1, "zebra") < (2, "apple")   // 1 은 2 보다 작기 때문에 참; "zebra" 와 "apple" 은 비교하지 않음
(3, "apple") < (3, "bird")    // 3 은 3 과 같고, "apple" 은 "bird" 보다 작기 때문에 참
(4, "dog") == (4, "dog")      // 4 는 4 와 같고, "dog" 은 "dog" 과 같기 때문에 참
```

위 예제의, 첫째 줄에서 왼쪽에서-오른쪽으로 비교하는 동작을 볼 수 있습니다. `1` 이 `2` 보다 작기 때문에, `(1, "zebra")` 가 `(2, "apple")` 보다 작다고 고려하며, 튜플 안의 어떤 다른 값도 상관없습니다. `"zebra"` 가 `"apple"` 보다 작지 않은 건 중요한게 아닌데, 튜플의 첫 번째 원소로 이미 비교 연산이 결정됐기 때문입니다. 하지만, 튜플의 첫 번째 원소가 똑같을 땐, 두 번째 원소 _를 (are)_ 비교합니다-둘째와 셋째 줄에서 발생한게 이겁니다.

주어진 연산자로 튜플을 비교하는 건 각자의 튜플 값 각각마다 연산자를 적용할 수 있는 경우에만 가능합니다. 예를 들어, 아래 코드에서 실제로 보여주듯, `(String, Int)` 타입인 두 튜플을 비교할 수 있는데 이는 `String` 과 `Int` 값은 둘 다 `<` 연산자로 비교할 수 있기 때문입니다. 이와 대조하여, `(String, Bool)` 타입인 두 튜플은 `<` 연산자로 비교할 수 없는데 `Bool` 값에 `<` 연산자를 적용할 수 없기 때문입니다.

```swift
("blue", -1) < ("purple", 1)        // 괜찮음, 참으로 평가함
("blue", false) < ("purple", true)  // 에러, '<' 가 불리언 값을 비교할 수 없기 때문
```

> 스위프트 표준 라이브러리는 원소가 7개 미만인 튜플의 튜플 비교 연산자만 포함합니다. 원소가 7개 이상인 튜플을 비교하려면, 반드시 비교 연산자를 직접 구현해야 합니다.

### Ternary Conditional Operator (삼항 조건 연산자)

_삼항 조건 연산자 (ternary conditional operator)_ 는 세 부분을 가진 특수한 연산자로, `question ? answer1 : answer2` 라는 형식을 취합니다. 이는 `question` 이 참인지 거짓인지에 기초하여 두 표현식 중 하나를 평가하는 줄임말입니다. `question` 이 참이면, `answer1` 을 평가한 값을 반환하며; 그 외 경우, `answer2` 를 평가한 값을 반환합니다.

삼항 조건 연산자는 아래 코드를 짧게 줄인 겁니다:

```swift
if question {
  answer1
} else {
  answer2
}
```

표의 행 높이를 계산하는, 예는 이렇습니다. 행에 제목이 있으면 행 높이가 내용 높이보다 50 포인트 더 큰게, 행에 제목이 없으면 20 포인트 더 큰게 좋습니다:

```swift
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight 는 90 과 같음
```

위 예제는 아래 코드를 짧게 줄인 겁니다:

```swift
let contentHeight = 40
let hasHeader = true
let rowHeight: Int
if hasHeader {
  rowHeight = contentHeight + 50
} else {
  rowHeight = contentHeight + 20
}
// rowHeight 는 90 과 같음
```

첫 번째 예에서 삼항 조건 연산자를 사용한 건 `rowHeight` 에 올바른 값을 설정하는 걸 단 한 줄의 코드로 할 수 있다는 의미이며, 이 코드는 두 번째 예보다 더 간결합니다.

삼항 조건 연산자는 두 표현식 중 어느 걸 고려할지 정하는데 효율적인 줄임말을 제공합니다. 하지만, 삼항 조건 연산자의 사용엔 신경쓰기 바랍니다. 간결하다고 막 쓰면 읽기-힘든 코드로 이끌 수 있습니다. 여러 개의 삼항 조건 연산자를 하나의 복합 구문으로 조합하는 건 피하도록 합니다.

### Nil-Coalescing Operator (Nil-합체 연산자)

_nil-합체 연산자 (nil-coalescing operator_; `a ?? b`_)_ 는 옵셔널 `a` 에 값이 담겼으면 포장을 풀고, `a` 가 `nil` 이면 기본 값 `b` 를 반환합니다. 표현식 `a` 는 항상 옵셔널 타입입니다. 표현식 `b` 는 반드시 `a` 안에 저장한 타입과 맞아야 합니다.

**nil**-합체 연산자는 아래 코드를 짧게 줄인 겁니다:

```swift
a != nil ? a! : b
```

위 코드는 삼항 조건 연산자와 강제 포장 풀기 (`a!`) 를 써서 `a` 가 `nil` 이 아닐 땐 `a` 안에 포장된 값에 접근하고, 그 외 경우면 `b` 를 반환합니다. **nil**-합체 연산자는 더 우아한 방식으로 이러한 조건 검사와 포장 풀기를 간결하고 쉽게 읽히는 형식 안에 감춥니다.

> `a` 값이 `nil` 이-아니면, `b` 값은 평가하지 않습니다. 이를 _단락-회로 계산 (short-circuit evaluation)_ 이라고 합니다.[^short-circuit]

아래 예제는 **nil**-합체 연산자를 써서 기본 색상 이름과 사용자가 옵션으로-정의한 색상 이름 중 하나를 선택합니다:

```swift
let defaultColorName = "red"
var userDefinedColorName: String?   // nil 이 기본임

var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 이 nil 이라서, colorNameToUse 를 "red" 로 기본 설정함
```

`userDefinedColorName` 변수는 옵셔널 `String` 으로 정의하여, 기본 값이 `nil` 입니다. `userDefinedColorName` 이 옵셔널 타입이기 때문에, **nil**-합체 연산자로 그 값을 고려할 수 있습니다. 위 예제에선, 연산자로 `colorNameToUse` 라는 `String` 변수의 초기 값을 결정합니다. `userDefinedColorName` 이 `nil` 이기 때문에, 표현식 `userDefinedColorName ?? defaultColorName` 이 `defaultColorName` 값, 또는 `"red"` 를 반환합니다.

`userDefinedColorName` 에 `nil`-아닌 값을 할당하고 다시 **nil**-합체 연산자로 검사하면, 기본 값 대신 `userDefinedColorName` 안에 포장된 값을 사용합니다:

```swift
userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 이 nil 이 아니라서, colorNameToUse 를 "green" 으로 설정함
```

### Range Operators (범위 연산자)

스위프트는 여러 가지 _범위 연산자 (range operators)_ 를 포함하는데, 이는 값의 범위를 표현하는 줄임말입니다.

#### Closed Range Operator (닫힌 범위 연산자)

_닫힌 범위 연산자 (closed range operator;_ `a...b`_)_ 는 `a` 부터 `b` 에 이르는 범위를 정의하며, `a` 및 `b` 값도 포함합니다. `a` 값은 반드시 `b` 보다 크지 않아야 합니다.

닫힌 범위 연산자는, `for`-`in` 반복문 처럼, 범위를 반복하여 모든 값을 사용하고 싶을 때 유용합니다:

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

`for-in` 반복문에 대한 더 많은 것은, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 장을 보기 바랍니다.

#### Half-Open Range Operator (반-열린 범위 연산자)

_반-열린 범위 연산자 (half-open range operator;_ `a..<b`_)_ 는 `a` 부터 `b` 에 이르는 범위를 정의하지만, `b` 는 포함하지 않습니다. _반-열린 (half-open)_ 이라고 말하는 건 첫 번째 값은 담지만, 최종 값은 아니기 때문입니다. 닫힌 범위 연산자 처럼, `a` 값은 반드시 `b` 보다 크지 않아야 합니다. `a` 값이 `b` 와 같으면, 결과 범위는 빌 (empty) 것입니다.

반-열린 범위는 배열 같이, 목록 길이까지 세는(만 이를 포함하진 않는)게 유용한, 0-기반 목록[^zero-based] 과 작업할 때 특히 더 유용합니다:

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

배열앤 네 개의 항목이 담겨 있지만, `0..<count` 는 (배열의 마지막 항목 색인인) `3` 까지만 세는데, 이는 반-열린 연산자이기 때문입니다. 배열에 대한 더 많은 것은, [Arrays (배열)]({% post_url 2016-06-06-Collection-Types %}#arrays-배열) 부분을 보기 바랍니다.

#### One-Sided Ranges (한-쪽 범위)

닫힌 범위 연산자에는 한 방향으로 가능한 멀리 계속되는 대체 형식의 범위가 있습니다-예를 들어, 어떤 범위는 배열 색인 2 부터 끝까지 모든 배열 원소를 포함합니다. 이 경우, 범위 연산자의 한 쪽 값을 생략할 수 있습니다. 이런 종류의 범위를 _한-쪽 범위 (one-sided range)_ 라고 하는데 연산자의 한 쪽에만 값이 있기 때문입니다. 예를 들면 다음과 같습니다:

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

반-열린 범위 연산자에도 자신의 최종 값만 쓰는 한-쪽 형식이 있습니다. 양 쪽 모두에 값을 포함할 때 같이, 최종 값은 범위의 일부가 아닙니다. 예를 들면 다음과 같습니다:

```swift
for name in names[..<2] {
  print(name)
}
// Anna
// Alex
```

한-쪽 범위는, 첨자만이 아니라, 다른 상황에서도 사용할 수 있습니다. 첫 번째 값을 생략한 한-쪽 범위는 반복을 할 수 없는데, 반복을 시작할 곳이 명확하지 않기 때문입니다. 최종 값을 생략한 한-쪽 범위는 반복을 _할 수 (can)_ 있습니다; 하지만, 범위가 무한정 계속되기 때문에, 반복문이 끝나는 조건을 확실하게 명시하도록 합니다. 아래 코드에서 보듯, 한-쪽 범위에 특별한 값이 담겼는지 검사할 수도 있습니다.

```swift
let range = ...5
range.contains(7)   // 거짓
range.contains(4)   // 참
range.contains(-1)  // 참
```

### Logical Operators (논리 연산자)

_논리 연산자 (logical operators)_ 는 불리언 논리 값인 `true` 와 `false` 를 수정하거나 조합합니다. 스위프트는 C-기반 언어[^c-based-languages] 에 있는 세 개의 표준 논리 연산자를 지원합니다:

* 논리 부정 (`!a`)
* 논리 곱 (`a && b`)
* 논리 합 (`a || b`)

#### Logical NOT Operator (논리 부정 연산자)

_논리 부정 연산자 (logical NOT operator;_ `!a`_)_ 는 불리언 값을 반대로 하여 `true` 는 `false` 가 되고, `false` 는 `true` 가 됩니다.

논리 부정 연산자는 접두사 연산자이며, 어떤 공백도 없이, 연산 값 바로 앞에 나타납니다. 다음 예제에서 보듯, “`a` 아님 (not `a`)” 이라고 읽을 수 있습니다:

```swift
let allowedEntry = false
if !allowedEntry {
  print("ACCESS DENIED")
}
// "ACCESS DENIED" 를 인쇄함
```

`if !allowedEntry` 라는 구절은 "진입을 허용한게 아니면 (if not allowed entry)" 라고 읽을 수 있습니다. 뒤이은 줄은 "진입을 안 허용한게" 참인; 즉, `allowedEntry` 가 `false` 인 경우에만 실행합니다.

이 예제처럼, 불리언 상수와 변수 이름은 신경써서 선택해야 코드를 쉽게 읽히고 간결하게 유지하면서, 이중 부정이나 논리 구문의 혼동도 피할 수 있습니다.

#### Logical AND Operator (논리 곱 연산자)

_논리 곱 연산자 (logical AND operator;_ `a && b`_)_ 는 두 값이 모두 반드시 `true` 여야 전체 표현식도 `true` 가 되는 논리 표현식을 생성합니다.

어느 값이든 `false` 면, 전체 표현식도 `false` 가 됩니다. 사실, _첫 번째 (first)_ 값이 `false` 면, 심지어 두 번째 값을 평가하지도 않을 건데, 전체 표현식을 `true` 로 만드는게 (이미) 불가능하기 때문입니다. 이를 _단락-회로 계산 (short-circuit evaluation)_[^short-circuit] 이라고 합니다.

다음 예제는 두 `Bool` 값을 고려하여 두 값이 다 `true` 여야만 접근을 허용합니다:

```swift
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
  print("Welcome!")
} else {
  print("ACCESS DENIED")
}
// "ACCESS DENIED" 를 인쇄함
```

#### Logical OR Operator (논리 합 연산자)

_논리 합 연산자 (logical OR operator;_ `a || b`_)_ 는 인접한 두 파이프 문자 (`|`) 로 만드는 중위 연산자입니다. 이를 써서 두 값 중 _하나 (one)_ 만 `true` 면 전체 표현식이 `true` 가 되는 논리 표현식를 생성합니다.

위의 논리 곱 연산자 같이, 논리 합 연산자도 단락-회로 계산을 써서 자신의 표현식을 고려합니다. 논리 합 표현식의 왼쪽이 `true` 면, 오른쪽은 평가하지 않는데, 전체 표현식의 결과물을 바꿀 수 없기 때문입니다.

아래 예제에선, 첫 번째 `Bool` 값 (`hasDoorKey`) 는 `false` 지만, 두 번째 값 (`knowsOverridePassword`) 는 `true` 입니다. 한 값이 `true` 기 때문에, 전체 표현식도 `true` 로 평가하여, 접근을 허용합니다:

```swift
let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
  print("Welcome!")
} else {
  print("ACCESS DENIED")
}
// "Welcome!" 을 인쇄함
```

#### Combining Logical Operators (논리 연산자 조합하기)

여러 개의 논리 연산자를 조합하여 더 긴 복합 표현식을 생성할 수 있습니다:

```swift
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
  print("Welcome!")
} else {
  print("ACCESS DENIED")
}
// "Welcome!" 을 인쇄함
```

이 예제는 여러 개의 `&&` 와 `||` 연산자를 사용하여 더 긴 복합 표현식을 생성합니다. 하지만, `&&` 및 `||` 연산자는 여전히 두 값으로만 연산하므로, 실제로 이는 세 개의 작은 표현식이 서로 사슬처럼 이어진 겁니다. 예제는 다음 처럼 읽을 수 있습니다:

올바른 출입문 코드도 입력하고 망막 조사도 통과한 경우나, 유효한 출입문 열쇠가 있는 경우, 또는 긴급 해제 비밀번호[^emergency-override-password] 를 알고 있는 경우라면, 접근을 허용합니다.

`enterDoorCode` 와, `passedRetinaScan`, 및 `hasDoorKey` 값에 기반한, 첫 두 하위 표현식은 `false` 입니다. 하지만, 긴급 해제 비밀번호를 알고 있어서, 전체 복합 표현식을 여전히 `true` 로 평가합니다.

> 스위프트의 논리 연산자 `&&` 와 `||` 는 왼쪽-결합[^left-associative] 인데, 이는 논리 연산자가 여러 개인 복합 표현식이면 가장 왼쪽의 하위 표현식을 첫 번째로 평가한다는 의미입니다.

#### Explicit Parentheses (명시적인 괄호)

엄밀히 필요한 건 아닐 때라도 괄호를 포함하여, 복잡한 표현식의 의도롤 읽기 쉽게 만드는게, 유용할 때가 있습니다. 위의 출입문 접근 예제에선, 복합 표현식 첫 번째 부분 주변에 괄호를 추가하여 의도를 명시하는게 유용합니다:

```swift
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
  print("Welcome!")
} else {
  print("ACCESS DENIED")
}
// "Welcome!" 를 인쇄함
```

괄호는 처음 두 값이 전체 논리에서 별도로 고려 가능한 상태라는 걸 명확하게 합니다. 복합 표현식의 결과물은 바뀌지 않지만, 전체 의도는 더 명확하게 읽힙니다. 쉽게 읽히는 게[^readability] 간결한 것 보다[^brevity] 항상 더 좋습니다; 의도가 명확해지게 돕는 곳이면 괄호를 사용하기 바랍니다.

### 다음 장

[Strings and Characters (문자열과 문자) > ]({% post_url 2016-05-29-Strings-and-Characters %})

### 참고 자료

[^Basic-Operators]: 원문은 [Basic Operators](https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html) 에서 확인할 수 있습니다.

[^infix]: '중위 (infix)' 는 **중** 간에 **위** 치한다는 의미입니다. 중위라는 말에 대한 더 자세한 정보는, 위키피디아의 [Infix notation](https://en.wikipedia.org/wiki/Infix_notation) 항목과 [중위 표기법](https://ko.wikipedia.org/wiki/중위_표기법) 항목을 참고하기 바랍니다.

[^modulo-opartion]: 'modulo operation (모듈러 연산)' 은 수학적으로 엄밀하게 정의한 나머지 연산입니다. 이에 대한 더 자세한 정보는, 위키피디아의 [Modulo operation](https://en.wikipedia.org/wiki/Modulo_operation) 항목을 참고하기 바랍니다. 모듈러 연산에 대한 한글 자료는 [합동 산술](https://ko.wikipedia.org/wiki/합동_산술) 항목을 참고하기 바랍니다.

[^remainder-vs-modulo]: 모듈러 연산과 나머지 연산의 차이점은 음수 연산에서 발생합니다. 이에 대한 더 자세한 정보는, **StackOverflow** 의 [What's the difference between “mod” and “remainder”?](https://stackoverflow.com/questions/13683563/whats-the-difference-between-mod-and-remainder) 항목을 참고하기 바랍니다. 

[^short-circuit]: '단락-회로 계산 (short-circuit evaluation)' 에서 단락-회로라는 건 원래 전기 공학에서 나온 개념입니다. '단락 (短絡)' 은 짧게 이어졌다는 의미며, 단락-회로는 (이론상) 무한히 짧아서 저항이 0 인 상태로 이어진 회로를 의미합니다. 저항이 0 이므로 (이론상) 무한대의 전류가 흐르며, 다른 회로 쪽으로는 전류가 흐르지 않게 됩니다. 즉, 전기 회로에서 단락-회로가 생기면 다른 곳으로 전류가 흐르지 않듯이, 단락-회로 계산은 한 곳의 계산 결과에 따라 다른 곳의 계산을 아예 하지 않는 걸 의미합니다. 컴퓨터 공학에선, 불필요한 표현식의 계산을 하지 않아 계산량을 줄일 수 있는 방식입니다. 컴퓨터 용어로 '최소 계산 (minimal evaluation)' 이라고도 하는데, 이에 대한 더 자세한 정보는, 위키피디아의 [Short-circuit evaluation](https://en.wikipedia.org/wiki/Short-circuit_evaluation) 항목을 참고하기 바랍니다.

[^zero-based]: '0-기반 목록 (zero-based lists)' 은 색인이 0 부터 시작하는 목록입니다. 0-기반 목록에 대한 더 많은 정보는, 위키피디아의 [Zero-based numbering](https://en.wikipedia.org/wiki/Zero-based_numbering) 항목을 참고하기 바랍니다.

[^left-associative]: '왼쪽-결합 (left-associative)' 는 '연산자 결합성 (operator associativity)' 의 한 가지 방식입니다. '연산자 결합성' 은 괄호 없이 묶인 연산자들이 같은 우선 순위를 가질 경우에 작동하는 방식입니다. 이에 대한 더 자세한 정보는, 위키피디아의 [Operator associativity](https://en.wikipedia.org/wiki/Operator_associativity) 항목을 참고하기 바랍니다.

[^operator-declarations]: 원문 자체가 애플 개발자 사이트의 링크로 되어 있습니다. 해당 페이지에 스위프트 표준 라이브러리가 제공하는 연산자에 대한 전체 목록이 있습니다.

[^c-based-languages]: 'C-기반 언어 (C-based languages)' 는 **C-family** (C-계열 언어) 라고도 하는데, 여기에 속한 언어 목록은 위키피디아의 [List of C-family programming languages](https://en.wikipedia.org/wiki/List_of_C-family_programming_languages) 항목에서 확인할 수 있습니다. 애플에서 만든 **오브젝티브-C** 와 **스위프트** 는 모두 **C-family** 입니다.
