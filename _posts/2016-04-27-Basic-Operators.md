---
layout: post
comments: true
title:  "Swift 3.1: 기초 연산자 (Basic Operators)"
date:   2016-04-27 10:00:00 +0900
categories: Swift Language Grammar Basic Operators
---

> 이 글은 Swift 를 공부하기 위해 애플에서 공개한 [The Swift Programming Language (Swift 3.1)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/) 책의 [Basic Operators](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/BasicOperators.html#//apple_ref/doc/uid/TP40014097-CH6-ID60) 부분을 번역하고 주석을 달아서 정리한 글입니다. 현재는 Swift 3.1 버전에 대해서 정리되어 있습니다.

연산자는 값을 검사하고, 바꾸거나 결합하는데 사용하는 특별한 기호 또는 구절입니다. 예를 들어 덧셈 연산자 (`+`) 는 `let i = 1 + 2` 에서 보듯이 두 수를 더하고, 논리 AND 연산자 (`&&`) 는 `if enteredDoorCode && passedRetinaScan` 에서 보듯이 두 불 (Boolean) 값을 결합합니다.

Swift 는 대부분의 표준 C 연산자를 지원하면서 자주 발생하는 코딩 에러를 없애기 위해 몇가지 기능들을 향상시켰습니다. 대입 연산자는 (`=`) 는 값을 반환하지 않도록 해서 등호 연산자 (`==`) 가 있어야 할 곳에서 실수로 사용되지 않도록 해줍니다. 산술 연산자들 (`+`, `-`, `*`, `/`, `%` 등) 은 값이 넘치는 것을 감지하고 막아주는데, 이는 수를 다룰 때 결과가 예상치 못하게 타입이 허용하는 범위보다 더 작거나 크지 않도록 해 줍니다. Swift 의 넘침 (overflow) 연산자를 사용하면 값이 넘칠 수 있도록 직접 지정할 수 있습니다. 이는 [Overflow Operators]() 에서 설명하고 있습니다.

Swift 는 또 C 에서는 없는 두 개의 범위 연산자 (`a..<b` 와 `a...b`) 를 제공하는데, 이는 값의 범위를 손쉽게 표현하게 해 줍니다.

이번 장에서는 Swift 에 있는 보통의 연산자에 대해 설명합니다. [Advanced Operators]() 에서는 Swift 의 고급 연산자를 다루면서, 사용자 정의 연산자를 정의하는 방법과 사용자 정의 타입을 위한 표준 연산자를 구현하는 방법에 대해서 설명합니다.

### 용어 (Terminology)

연산자에는 단항, 이항, 삼항 연산자가 있습니다:

* 단항 연산자는 (`-a` 와 같이) 단일 대상에 대해 동작합니다. 단항 접두 연산자는 (`!b` 와 같이) 대상 바로 앞에 위치하고, 단항 접미 연산자는 (`c!` 처럼) 대상 바로 뒤에 위치합니다. [^appear]
* 이항 연산자는 (`2 + 3` 과 같이) 두 개의 대상에 대해 동작하며 두 대상 사이에 위치하므로 중위 (infix) 라고 합니다. [^infix]
* 삼항 연산자는 세 개의 대상에 대해 동작합니다. C 와 같이 Swift 에는 단 한 개의 삼항 연산자가 있는데, 삼항 조건 연산자 (`a ? b : c`) 가 바로 그것입니다.

연산자가 영향을 미치는 값을 피연산자 (operands) 라고 합니다. 가령 `1 + 2` 라는 식에서 `+` 기호는 이항 연산자이고 두 피연산자는 값 `1` 과 `2` 입니다.

### 대입 연산자 (Assignment Operator)

대입 연산자 (`a = b`) 는 `a` 의 값을 `b` 의 값으로 초기화하거나 갱신합니다:

```swift
let b = 10
var a = 5
a = b
// a 는 이제 10 이 됩니다.
```

대입의 오른쪽이 여러 값을 갖고 있는 튜플이라면, 그 요소들은 분해되어 여러 상수나 변수로 한번에 분해되어 옮겨집니다:

```swift
let (x, y) = (1, 2)
// x 는 1 이 되고 y 는 2 가 됩니다.
```

C 나 Objective-C 의 대입 연산자와는 다르게 Swift 의 대입 연산자는 리턴 값이 없습니다. 즉, 다음의 구문은 유효하지 않습니다:

```swift
if x = y {
    // x = y 구문은 리턴 값이 없기 때문에 유효하지 않습니다.
}
```

이 특성은 등호 연산자가 (`==`) 사용되어야 할 곳에 대입 연산자 (`=`) 가 실수로 사용되는 것을 막아줍니다. `if x = y` 를 유효하지 않게 만듦으로써 Swift 는 코드에서 이런 종류의 에러를 피할 수 있게 해주는 것입니다.

### 산술 연산자 (Arithmetic Operators)

Swift 모든 수치 타입에 대해 네가지 표준 산술 연산자를 지원합니다:

* 덧셈 (`+`)
* 뺄셈 (`-`)
* 곱셈 (`*`)
* 나눗셈 (`/`)

```swift
1 + 2       // 3 입니다.
5 - 3       // 2 입니다.
2 * 3       // 6 입니다.
10.0 / 2.5  // 4.0 입니다.
```

C 및 Objective-C 의 산술 연산자들과는 다르게 Swift 의 산술 연산자는 기본으로 값이 넘치는 것을 허용하지 않습니다. 값이 넘칠 수 있게 하려면 Swift 의 넘침 연산자를 (`a &+ b` 처럼) 직접 써주면 됩니다. [넘침 연산자 (Overflow Operators)]() 부분을 보도록 합니다.

덧셈 연산자는 `String` 의 연결도 지원합니다:

```swift
"hello, " + "world"  // "hello, world" 입니다.
```

#### 나머지 연산자 (Remainder Operator)

나머지 연산자 (`a % b`) 는 `a` 의 안에 몇 배의 `b` 가 들어가는지를 본 다음에 (나머지라고 하는) 남은 부분의 값을 반환합니다.

> 나머지 연산자 (`%`) 다른 언어에서는 모듈러 연산자라고도 합니다. 하지만 Swift 에서는 음수에 대한 작동 방식이 모듈러 연산이랑은 좀 달라서 엄밀히 말해 그냥 나머지입니다.

나머지 연산자가 어떻게 동작하는지 알아봅시다. `9 % 4` 를 계산하려면 먼저 얼마나 많은 `4` 가 `9` 안에 들어갈 수 있는지 봅니다:

[image](../Art/remainderInteger_2x.png)

`9` 안에는 `4` 가  2 개 들어갈 수 있으며 나머지는 `1` 입니다. (주황색으로 나타냈습니다).

Swift 에서는 다음과 같이 쓸 수 있습니다:

```swift
9 % 4    // 1 과 같습니다.
```

`a % b` 에 대한 답을 결정하려면  `%` 연산자는 다음의 식을 계산하고 `remainder` 를 그 결과로 반환합니다:

`a` = (`b` x `some multiplier`) + `remainder`

`some multiplier` 는 `a` 내부에 들어맞는 `b` 의 배수 중에서 가장 큰 수입니다.

`9` 와 `4` 를 이 식에 넣으면 다음과 같이 도출됩니다:

`9` = (`4` x `2`) + `1`

`a` 가 음수인 경우에 나머지를 구하는 방법도 같습니다:

```swift
-9 % 4   // -1 과 같습니다.
```

`-9` 와 `4` 를 식에 대입하면 다음과 같이 도출됩니다:

`-9` = (`4` x `-2`) + `-1`

나머지 값은 `-1` 로 주어집니다.

`b` 가 음수인 경우 `b` 의 부호는 무시됩니다. 이것은 `a % b` 와 `a % -b` 는 항상 같은 답을 내놓는다는 것을 의미합니다.

#### 단항 마이너스 연산자 (Unary Minus Operator)

수치 값의 부호는 단항 마이너스 연산자로 알려진 접두사 `-` 를 사용하여 전환할 수 있습니다: [^toggle]

```swift
let three = 3
let minusThree = -three       // minusThree equals -3
let plusThree = -minusThree   // plusThree equals 3, or "minus minus three"
```

단항 마이너스 연산자 (`-`) 는 빈 공간 없이 피연산자 바로 앞에 위치해야 합니다.

#### 단항 플러스 연산자 (Unary Plus Operator)

단항 플러스 연산자 (`+`) 는 아무런 변화없이 단순히 대상 값을 그대로 반환합니다:

```swift
let minusSix = -6
let alsoMinusSix = +minusSix  // alsoMinusSix 는 -6 과 같습니다.
```

단항 플러스 연산자는 실제로 아무 일도 하지 않지만, 음수에 단항 마이너스 연산자가 사용된 경우 이것을 양수에 사용하면 코드의 대칭성을 제공할 수 있습니다.

### 복합 대입 연산자 (Compound Assignment Operators)

C 처럼 Swift 는 대입 연산 (`=`) 을 다른 연산과 결합하는 복합 대입 연산자를 제공합니다. 한가지 예는 덧셈 대입 연산자 (`+=`) 입니다:

```swift
var a = 1
a += 2
// a 는  3 이 됩니다
```

`a += 2` 표현식은 `a = a + 2` 의 단축 표현입니다. 실제로 덧셈 연산과 대입 연산은 두 작업을 한 번에 수행하는 하나의 연산자로 결합됩니다.

> 복합 대입 연산자는 값을 반환하지 않습니다. 예를 들어 `let b = a += 2` 처럼 사용할 수는 없습니다.

Swift 표준 라이브러리가 제공하는 복합 대입 연산자의 전체 목록을 보려면 [Swift Standard Library Operators Reference]() 를 참고합니다.

### 비교 연산자 (Comparison Operators)

Swift 는 모든 표준 C 비교 연산자를 지원합니다:

* 등호 (`a == b`) : 같음
* 부등호 (`a != b`) : 같지 않음
* 초과 (`a > b`) : 보다 큼
* 미만 (`a < b`) : 보다 작음
* 이상 (`a >= b`) : 크거나 같음
* 이하 (`a <= b`) : 작거나 같음

> Swift 는 두 개의 동일 id 연산자 (`===` and `!==`) 도 제공하는데 이는 두 객체의 참조가 모두 같은 객체 인스턴스를 참조하고 있는지를 검사하는데 사용합니다. 더 자세한 내용은 [클래스 및 구조 타입 (Classes and Structures)]() 를 보도록 합니다.

각각의 비교 연산자는 `Bool` 값을 반환하여 그 구문이 참인지 아닌지를 나타냅니다:

```swift
1 == 1   // true because 1 is equal to 1
2 != 1   // true because 2 is not equal to 1
2 > 1    // true because 2 is greater than 1
1 < 2    // true because 1 is less than 2
1 >= 1   // true because 1 is greater than or equal to 1
2 <= 1   // false because 2 is not less than or equal to 1
```

비교 연산자는 `if` 문 같은 조건 구문에서 자주 사용됩니다:

```swift
let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}
// Prints "hello, world", because name is indeed equal to "world".
```

`if` 문에 대해 더 알고 싶으면 [Control Flow]() 를 보기 바랍니다.

튜플도 비교할 수 있는데, 서로 같은 개수의 값을 가지고 있고 각각의 값을 서로 비교할 수 있으면 가능합니다. 예를 들어 `Int` 와 `String` 모두 비교할 수 있으므로 타입이 `(Int, String)` 인 튜플도 비교할 수 있습니다. 반면에 `Bool` 은 비교할 수 없으므로 불 값을 가지고 있는 튜플은 비교할 수 없습니다.

튜플은 왼쪽에서 오른쪽으로 한번에 하나씩 두 값이 같지 않을 때까지 비교합니다. 이 짝지어진 두 값들이 비교되는데 각 비교 결과는 전체 튜플 비교의 결과를 결정합니다. 모든 요소들이 같으면 튜플 자체가 같습니다. 예를 들면 다음과 같습니다:

```swift
(1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" are not compared
(3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
(4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"
```

위의 예제의 첫번째 행에서, 왼쪽에서 오른쪽으로 비교하는 동작 방식을 볼 수 있습니다. `1` 이 `2` 보다 작기 때문에 튜플의 나머지 값과는 상관없이 `(1, "zebra")` 은 `(2, "apple")` 보다 작은 것으로 고려됩니다. `"zebra"` 가 `"apple"` 보다 작지 않은 것은 상관이 없는데, 왜냐면 비교 연산은 튜플의 첫번째 요소에서 이미 결정됐기 때문입니다. 하지만 튜플의 첫번째 요소가 같다면 두번째 요소가 비교됩니다 — 이것은 두번째와 세번째 행에서 일어나는 일입니다.

> Swift 표준 라이브러리의 튜플 비교 연산자는 7개 미만의 요소를 가진 튜플만 비교 가능합니다. 7개 이상의 요소를 가진 튜플을 비교하려면 비교 연산자를 직접 구현해야 합니다.

### 삼항 조건 연산자 (Ternary Conditional Operator)

삼항 조건 연산자는 세 부분으로 된 특수한 연산자로 `question ? answer1 : answer2` 와 같은 양식을 가집니다. `question` 이 참인지 거짓인지에 따라 두 표현식 중에서 하나를 평가하는 단축 표현식입니다. `question` 이 참이면 `answer1` 의 값을 구해서 그 값을 반환하고; 반대의 경우 `answer2` 의 값을 구해서 그 값을 반환합니다.

삼항 조건 연산자는 아래 코드가 단축된 것입니다:

```swift
if question {
    answer1
} else {
    answer2
}
```

다음은 테이블의 행 높이를 계산하는 예제입니다. 행이 헤더 (제목행) 을 가지고 있으면 내용 행보다 50 포인트가 더 높아야 하고, 헤더가 없으면 20 포인트가 더 높아야 합니다:

```swift
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight is equal to 90
```

위 예제는 다음 코드를 단축한 것입니다:

```swift
let contentHeight = 40
let hasHeader = true
let rowHeight: Int
if hasHeader {
    rowHeight = contentHeight + 50
} else {
    rowHeight = contentHeight + 20
}
// rowHeight is equal to 90
```

첫번째 예제에서 삼항 조건 연산자를 사용함을로써 한 줄의 코드로 `rowHeight` 에 올바른 값을 설정했는데, 이는 두번째 예제의 코드보다 훨씬 간결합니다.

삼항 조건 연산자는 두 표현식 중에서 어느 것을 고려할지를 정하는 코드를 아주 간결하게 만들 수 있게 합니다. 하지만 삼항 조건 연산자를 사용할 때는 주의가 필요합니다. 남용하게 되면 간결한 표현이 읽기 힘든 코드를 만들게 됩니다. 여러 개의 삼항 조건 연산자를 결합해서 하나의 복합 구문으로 만드는 것은 피하도록 합니다.

### nil 과 합쳐진 연산자 (Nil-Coalescing Operator)

nil-과 합쳐진 (nil-coalescing) 연산자 (`a ?? b`) 는 옵셔널 `a` 가 값을 가지고 있으면 감싼 것을 풀고 `a` 가 `nil` 이면 기본 값인 `b` 를 반환합니다. [^coalescing] 표현식 `a` 는 항상 옵셔널 타입입니다. 표현식 `b` 는 반드시 `a` 안에 저장되는 타입과 같아야 합니다.

nil-과 합쳐진 연산자는 아래의 코드를 줄인 것입니다:

```swift
a != nil ? a! : b
```

위의 코드는 삼항 조건 연산자와 강제 풀기 (`a!`) 를 사용하여 `a` 가 `nil` 이 아닐 때는 `a` 안의 값에 접근하고, 그렇지 않으면 `b` 를 반환합니다. nil-과 합쳐진 연산자는 이 조건 검사와 풀기 작업을 아주 우아하게 감춰서 더 간결하고 읽기 쉽도록 해 줍니다.

> `a` 의 값이 `nil` 이 아닌 경우 `b` 의 값은 평가되지 않습니다. 이를 짧은-회로 평가 라고 합니다. [^short-circuit]

아래의 예제는 nil-과 합쳐진 연산자를 사용하여 기본 색상 이름과 옵셔널인 사용자-정의 색상 이름 중에서 하나의 값을 선택합니다:

```swift
let defaultColorName = "red"
var userDefinedColorName: String?   // 기본으로 nil 이 됩니다.

var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 은 nil 이므로 colorNameToUse 는 기본인 "red" 가 됩니다.
```

`userDefinedColorName` 변수는 옵셔널 `String` 으로 정의되며 기본 값은 `nil` 입니다. `userDefinedColorName` 이 옵셔널 타입이기 때문에 nil-과 합쳐진 연산자를 사용해서 값을 검토할 수 있습니다. 위의 예제에서는 `colorNameToUse` 라는 `String` 변수의 초기 값을 결정하는데 연산자를 사용하고 있습니다. `userDefinedColorName` 이 `nil` 이므로 표현식 `userDefinedColorName ?? defaultColorName` 은 `defaultColorName` 또는 `"red"` 값을 반환합니다.

`userDefinedColorName` 에 `nil` 이 아닌 값을 할당하고 nil-과 합쳐진 연산자로 다시 검사하면, `userDefinedColorName` 로 감싼 값이 기본 값 대신에 사용됩니다:

```swift
userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 이 nil 이 아니므로 colorNameToUse 는 "green" 이 됩니다.
```

### 범위 연산자 (Range Operators)

Swift 는 두 개의 범위 연산자 (range operators) 를 갖고 있어서 값의 범위를 간단한 양식으로 나타낼 수 있습니다.

#### 닫힌 범위 연산자 (Closed Range Operator)

닫힌 범위 연산자  (`a...b`) 는 `a` 에서 `b` 까지의 범위를 정의하며 이 때 `a` 와 `b` 의 값을 포함합니다. `a` 의 값은 반드시 `b` 보다 크지 않아야 합니다.

닫힌 범위 연산자는 `for`-`in` 루프 구문과 같이 범위에 있는 모든 값을 반복해야 하는 경우에 유용합니다:

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

`for`-`in` 루프 구문에 대해 더 알고 싶으면 [Control Flow]() 를 보도록 합니다.

#### 반만-열린 범위 연산자 (Half-Open Range Operator)

반만-열린 범위 연산자 (`a..<b`) 는 `a` 에서 `b` 까지의 범위를 지정하지만 `b` 를 포함하지 않습니다. 반만-열렸다고 하는 이유가 첫 번째 값은 포함하지만 마지막 값은 포함하지 않기 때문입니다. 닫힌 범위 연산자와 마찬가지로 `a` 의 값은 `b` 보다 크면 안됩니다. 만약 `a` 의 값이 `b` 와 같으면 이 범위의 결과는 비어있게 됩니다.

반만-열린 범위가 특히 유용한 경우가 배열과 같이 0-에서 시작하는 리스트와 작업할 때인데, 리스트의 길이만큼 헤아리지만 (길이 값 자체를) 포함하지는 않을 때 유용합니다: [^zero-based-list]

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

배열은 4 개의 항목을 가지고 있지만 `0..<count` 는 반만-열린 범위이기 때문에 (배열의 마지막 항목의 인덱스인) `3` 까지만 헤아리고 있음을 주목합니다. 배열에 대해 더 알고 싶으면 [Arrays]() 를 보도록 합니다.

### 논리 연산자 (Logical Operators)

논리 연산자는 불 논리 (Boolean logic) 값인 `true` 와 `false` 를 바꾸거나 결합합니다. Swift 는 C-기반 언어에서 발견되는 세 가지 표준 논리 연산자를 지원합니다:

* 부정 (Logical NOT) (`!a`) [^logical-not]
* 논리 곱 (Logical AND) (`a && b`)
* 논리 합 (Logical OR) (`a || b`)

#### 부정 연산자 (Logical NOT Operator)

부정 (logical NOT) 연산자 (`!a`) 는 불 값을 반전하여 `true` 는 `false` 가 되고 `false` 는 `true` 가 되게 합니다.

부정 연산자는 접두 연산자라서 연산을 하려는 값의 바로 앞에 공백없이 붙여줘야 합니다. 이는 다음의 예제에서 보듯이 “`a` 가 아니면” 으로 읽을 수 있습니다:

```swift
let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}
// Prints "ACCESS DENIED"
```

`if !allowedEntry` 구절은 “허가된 입장이 아니면” 으로 읽을 수 있습니다. 이어지는 행은 “허가된 입장이 아닌” 것이 참일 때만 실행됩니다; 그것은 `allowedEntry` 가 `false` 인 경우입니다.

이 예제와 같이 불 상수 및 변수 이름을 주의깊에 선택하면 코드를 읽기 슆고 간결하게 만들 수 있으며 동시에 이중 부정 구문이나 논리 문장의 혼란을 막을 수 있습니다.

#### 논리 곱 연산자 (Logical AND Operator)

논리 곱 (logical AND) 연산자 (`a && b`) 는 논리 표현식을 만들어서 두 값이 `true` 일 때만 전체 표현식을 `true` 이 되도록 합니다.

하나라도 값이 `false` 이면 전체 표현식은 `false` 가 됩니다. 사실 첫 번째 값이 `false` 이면 두 번째 값은 평가조차 하지 않는데, 왜냐면 전체 표현식이 `true` 가 될 가능성이 없기 때문입니다. 이를 짧은-회로 평가 (short-circuit evaluation) 라고 합니다.

아래 예제에서는 두 개의 `Bool` 값을 검토하여 두 값이 모두 `true` 인 경우에만 접근을 허용합니다: [^consider]

```swift
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "ACCESS DENIED"
```

#### 논리 합 연산자 (Logical OR Operator)

논리합 (logical OR) 연산자 (`a || b`) 는 두 개의 인접한 파이프 문자들로 이루어진 중위 (infix) 연산자입니다. [^adjacent] [^infix] 이것으로 논리 표현식을 만들면 두 값 중에서 하나만 `true` 가 되면 전체 표현식이 `true` 가 되게 할 수 있습니다.

위에 있는 논리 곱 연산자와 같이 논리 합 연산자도 짧은-회로 평가를 사용해서 표현식을 검토합니다. 논리 합 표현식의 왼쪽 항이 `true` 이면 오른쪽 항은 평가를 하지 않는데, 왜냐면 나머지 부분은 전체 표현식의 결과를 변경할 수 없기 때문입니다.

아래의 예제에서는 첫 번째 `Bool` 값 (`hasDoorKey`) 은 `false` 이지만 두 번째 값 (`knowsOverridePassword`) 은 `true` 입니다. 하나의 값이 `true` 이기 때문에 전체 표현식은 `true` 가 되고 접근이 허용됩니다:

```swift
let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
```

#### 논리 연산자 결합하기 (Combining Logical Operators)

여러 개의 논리 연산자를 결합하여 더 긴 복합 표현식을 만들 수 있습니다:

```swift
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
```

이 예제에서는 `&&` 와 `||` 연산자 여러 개를 사용해서 더 긴 복합 표현식을 만들었습니다. 하지만 `&&` 와 `||` 연산자는 여전히 두 값에 대해서만 동작하므로 실제로는 좀 더 작은 세 개의 표현식이 서로 연결된 것입니다. 이 예제는 다음과 같이 이해할 수 있습니다:

올바른 도어 코드를 입력하고 망막 스캔을 통과했거나, 맞는 도어 열쇠를 가지고 있거나, 긴급 수동 암호를 알고 있으면 접근을 허용합니다.

`enteredDoorCode`, `passedRetinaScan`, 및 `hasDoorKey` 값에 따라 처음 두 개의 하위 표현식은 `false` 입니다. 하지만 긴급 수동 암호를 알고 있으므로 전체 복합 표현식은 `true` 가 됩니다.

> Swift 논리 연산자인 `&&` 와 `||` 는 왼쪽-결합 (left-associative) 인데, 이는 여러 논리 연산자를 가지는 복합 표현식이 가장 왼쪽에 있는 하위 표현식 부터 먼저 평가를 한다는 의미입니다.

#### 직접 괄호 넣기 (Explicit Parentheses)

꼭 필요하지 않더라도 가끔씩 괄호를 사용하면 복잡한 표현식의 의도를 좀 더 쉽게 이해할 수 있도록 해줍니다. 위의 도어 출입 예제의 경우, 복합 표현식의 첫 번째 부분에 괄호를 사용하면 의도를 분명히 하는데 도움이 됩니다:

```swift
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
```

괄호는 처음 두 값들이 전체 논리에서 따로 떼어내서 검토할 수 있는 부분임을 분명히 보여줍니다. 복합 표현식의 결과는 변하지 않지만 전체 구문의 의도는 더 분명하고 더 이해하기 쉽습니다. 언제나 가독성이 간단함보다 더 중요합니다; 괄호를 사용해서 의도를 분명히 하도록 하기 바랍니다.

### 원문 자료

* [Basic Operators](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/BasicOperators.html#//apple_ref/doc/uid/TP40014097-CH6-ID60) : [The Swift Programming Language (Swift 3.1)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/) 자료입니다.

### 관련 자료

* [Swift: 리눅스에서 Swift 개발 환경 구축하기](http://xho95.github.io/linux/development/swift/package/install/2017/02/19/Developing-Swift-on-Linux.html)

* [Swift 3.1: 빠르게 둘러보기 (A Swift Tour)](http://xho95.github.io/swift/language/grammar/tour/2016/04/17/A-Swift-Tour.html)
* [Swift 3.1: 기초 (The Basics)](http://xho95.github.io/swift/language/grammar/basic/2016/04/24/The-Basics.html)

### 참고 자료

[^appear]: 'appear'는 '위치하다'로 옮깁니다.

[^infix]: 'infix는 '중위' 라고 옮길 수 있는데, 많은 경우 그냥 infix 그대로 두는 것이 좋을 것 같습니다.

[^toggle]: 'toggle'은 '전환하다'라고 옮깁니다.

[^coalescing]: 'coalescing'은 여기서는 '과 합쳐진'으로 옮깁니다.

[^short-circuit]: 'short-circuit'은 '짧은-회로'라고 옮겼는데, 좀 더 생각해야 할 것 같습니다.

[^zero-based-list]: 'zero based list'에 대한 좋은 대체 말은 좀 더 생각해야할 것 같습니다. 'list' 자체도 옮길 말을 좀 더 생각해야할 것 같습니다.

[^logical-not]: 'logical NOT'을 '부정'이라고 하는데 더 좋은 말이 없을지 생각해 봅니다.

[^consider]: 여기서는 'consider'를 '검토하다'라고 옮겼습니다.

[^adjacent]: 'adjacent'는 '인접한'으로 옮깁니다.

[^infix]: 'infix'는 '중위'라고 옮기는데 좀 더 적당한 단어가 없는지 생각합니다.

[^left-associative]: 'left-associative'는 '왼쪽-결합'으로 옮깁니다.
