---
layout: post
comments: true
title:  "Swift 5.2: Basic Operators (기본 연산자)"
date:   2016-04-27 10:00:00 +0900
categories: Swift Language Grammar Basic Operators
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Basic Operators](https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html) 부분[^Basic-Operators]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Basic Operators (기본 연산자)

_연산자 (operator)_ 는 값을 검사하고, 바꾸거나 결합하는 데 사용하는 특수한 기호 또는 구절을 말합니다. 예를 들어, '더하기 연산자 (`+`)' 는 `let i = 1 + 2` 에서 처럼 두 수를 더하고, '논리 곱 (logical AND) 연산자 (`&&`)' 는 `if enterDoorCode && passedRetinaScan` 에서 처럼 두 불린 (Boolean) 값을 결합합니다.

스위프트는 C 언어에서 제공하는 거의 대부분의 표준 연산자를 지원하며서, 거기다 일반적인 코딩 에러를 없애기 위해 몇가지 기능을 개선했습니다. '할당 연산자 (`=`)' 는 값을 반환하지 않아서, '같음 연산자 (`==`)' 를 의도한 곳에서 실수로 사용되는 것을 막았습니다. 산술 연산자들 (`+`,`-`, `*`, `/`, `%` 등) 은 '값 넘침 (value overflow)' 을 감지해서 막아주기 때문에, 타입의 허용 범위보다 크거나 작아진 값을 계산하는 바람에 예상하지 못한 결과가 발생하는 것을 막아줍니다. 스위프트의 'overflow (값 넘침) 연산자' 를 사용해서 값을 넘치는 동작을 하도록 선택할 수도 있으며, 이는 [Overflow Operator (값 넘침 연산자)](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html#ID37) 에서 설명합니다.

스위프트에는 C 언어에는 없는 '범위 (range) 연산자' 도 제공하는데, 가령 `a..<b` 와 `a...b` 가 있으며, 이를 쓰면 아주 간단하게 값의 범위를 표현할 수 있습니다.

이번 장은 스위프트의 일반적인 연산자에 대해 설명합니다. 스위프트의 고급 연산자는 [Advanced Operators (고급 연산자)](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html) 에서 다루는데, 직접 연산자를 정의하는 방법과 자기가 만든 타입에 대한 표준 연산자 구현 방법에 대해서 설명합니다.

### Terminology (용어)

연산자에는 단항, 이항, 삼항 연산자가 있습니다:

* _단항 (Unary)_ 연산자는 (`-a` 처럼) 단일 대상에 작용합니다. '단항 _접두 (prefix)_ 연산자' 는 (`!b` 처럼) 대상의 바로 앞에 위치하고 , '단항 _접미 (suffix)_ 연산자' 는 (`c!` 처럼) 대상 바로 뒤에 위치합니다.
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

C 언어나 오브젝티브-C 언어의 산술 연산자와는 다르게, 스위프트의 산술 연산자는 기본적으로 '값 넘침 (overflow)' 을 허용하지 않습니다. 값 넘침을 허용하려면 스위프트의 '값 넘침 연산자 (overflow operators)' 를 사용하면 됩니다. (`a &+ b` 같은 것이 있습니다.) 이에 대해서는 [Overflow Operator (값 넘침 연산자)](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html#ID37) 를 보도록 합니다.

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

> 스위프트는 두 개의 '_식별 연산자 (identity operators)_' (`===` 와 `!==`) 도 제공하여, 두 객체에 대한 참조 모두 동일한 객체 인스턴스를 참조하고 있는지를 검사할 수 있습니다. 더 자세한 내용은 [Identity Operators (식별 연산자)](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html#ID90) 를 보기 바랍니다.

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

`if` 구문에 대해서는, [Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html) 를 보기 바랍니다.

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
("blue", -1) < ("purple", 1)        // OK, true (참) 으로 평가합니다.
("blue", false) < ("purple", true)  // Error, < 는 불린 값을 비교할 수 없습니다.
```

> 스위프트 표준 라이브러리에 있는 튜플 비교 연산자는 7개 미만의 요소를 가진 튜플만 비교할 수 있습니다. 7개 이상의 요소를 가진 튜플을 비교하려면 비교 연산자를 직접 구현해야만 합니다.

### Ternary Conditional Operator (삼항 조건 연산자)

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

이 예제와 같이 불 상수 및 변수 이름을 주의깊에 선택하면 코드를 읽기 슆고 간결하게 만들 수 있으며 동시에 이중 부정 구문이나 논리 구문의 혼란을 막을 수 있습니다.

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

### 참고 자료

[^Basic-Operators]: 원문은 [Basic Operators](https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html) 에서 확인할 수 있습니다.

[^modulo-opartion]: 'modulo operation' 은 수학적인 엄밀한 나머지 연산과 관련된 것 같습니다. 보다 자세한 내용은 위키피디아의 [Modulo operation](https://en.wikipedia.org/wiki/Modulo_operation) 글을 참고하기 바랍니다. 이와 관련된 한글 자료가 거의 없는 거 같은데, 한글로는 [합동 산술](https://ko.wikipedia.org/wiki/합동_산술) 부분을 보면 도움이 될 것 같습니다.





[^appear]: 'appear'는 '위치하다'로 옮깁니다.

[^infix]: 'infix는 '중간에 위치' 한다는 의미에서 '중위' 라고 옮길 수 있는데, 의미가 헷갈리는 경우가 아니면 가급적 'infix' 라고 그대로 쓰도록 합니다.

[^toggle]: 'toggle'은 '전환하다'라고 옮깁니다.

[^coalescing]: 'coalescing'은 여기서는 '과 합쳐진'으로 옮깁니다.

[^short-circuit]: 'short-circuit'은 '짧은-회로'라고 옮겼는데, 좀 더 생각해야 할 것 같습니다.

[^zero-based-list]: 'zero based list'에 대한 좋은 대체 말은 좀 더 생각해야할 것 같습니다. 'list' 자체도 옮길 말을 좀 더 생각해야할 것 같습니다.

[^logical-not]: 'logical NOT'을 '부정'이라고 하는데 더 좋은 말이 없을지 생각해 봅니다.

[^consider]: 여기서는 'consider'를 '검토하다'라고 옮겼습니다.

[^adjacent]: 'adjacent'는 '인접한'으로 옮깁니다.

[^infix]: 'infix'는 '중위'라고 옮기는데 좀 더 적당한 단어가 없는지 생각합니다.

[^left-associative]: 'left-associative'는 '왼쪽-결합'으로 옮깁니다.
