---
layout: post
comments: true
title:  "Swift 5.2: Control Flow (제어 흐름)"
date:   2020-06-02 10:00:00 +0900
categories: Swift Language Grammar Control-Flow For-In While
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html) 부분[^Control-Flow]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Control Flow (제어 흐름)

스위프트는 다양한 제어 흐름 구문을 제공합니다. 여기에 포함된 것은 작업을 여러 번 수행하는 `while` 반복 구문; 정해진 조건에 따라 다른 분기에 있는 코드를 실행하는 `if`, `guard`, 및 `switch` 구문; 그리고 `break` 와 `continue` 같이 실행 흐름을 코드의 다른 지점으로 전달하는 구문입니다.

스위프트는 `for-in` 반복 구문도 제공하므로 배열, 딕셔너리, 범위, 문자열, 및 기타 '일련의 값들 (sequences)' 에 대해 동작을 쉽게 반복 적용할 수 있습니다.

스위프트의 `switch` 문은 C-계열 언어에 있는 것보다 눈에 띄게 더 강력합니다. '경우 값 (cases)' 는 아주 다양한 '유형 (patterns)' 에 대해서 해당하는 것을 찾을 수 있으며, '구간 찾기 (interval matches)', 튜플 찾기, 그리고 지정된 타입으로의 '변환 (casts)' 기능도 포함합니다. `switch` 의 '경우 값(case)' 에 해당하는 값은 임시 상수나 변수로 연결되어서 '경우 값' 본문 내에서 사용할 수 있으며, 각 '경우 값 (case)' 에 `where` 절을 사용하면 찾는 조건이 복잡한 것도 표현할 수 있습니다.

### For-In Loops (For-In 반복문)

`for-in` 반복문을 사용하면 일련의 값들에 동작을 반복 적용할 수 있는데, 여기에는 배열의 항목, 수치 값의 범위, 또는 문자열의 문자 등이 해당합니다.

다음의 예제는 `for-in` 반복문을 사용하여 배열의 각 항목에 대해 동작을 반복 적용시킵니다:

```swift
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
  print("Hello, \(name)!")
}
// Hello, Anna!
// Hello, Alex!
// Hello, Brian!
// Hello, Jack!
```

'딕셔너리 (dictionary)' 도 '키-값 쌍 (key-value pairs)' 에 접근해서 동작을 반복 적용시킬 수 있습니다. '딕셔너리' 를 반복할 때 '딕셔너리' 에 있는 각 항목은 `(key, value)` 튜플의 형태로 반환되며, 이 `(key, value` 튜플의 멤버는 `for-in` 반복문의 본문에서 사용시 명시적인 상수 이름인 것처럼 분해할 수 있습니다. 아래 코드의 예제에서, '딕셔너리' 의 키는 `animalName` 이라는 상수로 분해되었고, '딕셔너리' 의 값은 `legCount` 라는 상수로 분해되었습니다.

```swift
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
  print("\(animalName)s have \(legCount) legs")
}
// cats have 4 legs
// ants have 6 legs
// spiders have 8 legs
```

`Dictionary` 의 내용은 그 본질상 순서가 없으며, 동작을 반복 적용하는 것이 가져오는 순서대로 라는 보장이 없습니다. 특히, `Dictionary` 에 항목을 집어 넣는 순서는 반복하는 순서와 아무 상관이 없습니다. 배열과 사전에 대한 더 많은 내용은, [Collection Types (집합체 타입)]({% post_url 2016-06-06-Collection-Types %}) 을 참고하기 바랍니다.

`for-in` 반복문은 '수치 값 범위 (numeric ranges)' 와도 같이 사용할 수 있습니다. 다음 예제는 구구단 5-단 중에서 앞부분 일부를 출력하는 것입니다:

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

반복 적용할 일련의 값들은 `1` 에서 `5` 까지의 수의 범위이며, '닫힌 범위 연산자 (closed range operator; `...`)' 를 사용하여 끝 값까지 포함하도록 했습니다. `index` 의 값은 범위의 첫 번째 수 (`1`) 로 설정된 다음, 반복문 내의 구문을 실행합니다. 이 경우, 반복문은 단 하나의 구문만 담고 있으며, 구구단 5-단 중에서 현재 `index` 값에 해당하는 항목을 출력합니다. 구문을 실행하고 난 후에, `index` 값은 범위의 두 번째 값 (`2`) 을 담도록 갱신되며, `print(_:separator:terminator:)` 함수를 다시 호출합니다. 이 과정을 범위 끝에 도달할 때까지 계속합니다.

위의 예제에서, `index` 는 반복문의 각 '회차 (iteration)' 를 시작할 때 자동으로 설정되는 상수입니다. 그로 인해, 사용 전에 `index` 를 선언할 필요가 없습니다. 단순히 반복문 선언에 포함하기만 해도 암시적으로 선언되며, `let` 선언 키워드도 필요없습니다.

일련의 값들에서 각 값이 굳이 필요없을 경우, 변수 이름 위치에 '밑줄 (underscore; `_`)' 을 사용하면 그 값을 무시할 수 있습니다.

```swift
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
  answer *= base
}
print("\(base) to the power of \(power) is \(answer)")
// "3 to the power of 10 is 59049" 를 출력합니다.
```

위의 예제는 한 수에 대한 다른 수의 거듭 제곱 (이 경우는, `3` 의 `10` 제곱) 을 계산합니다. 이는 시작 값 `1` (즉, `3` 의 `0` 제곱) 에 `3` 을, `1` 에서 시작해서 `10` 에서 끝나는 '닫힌 범위' 를 사용하여, 10 번 곱합니다. 이 계산에서, 반복문의 매 회차에서 개별 카운터 값은 필요 없습니다-코드는 단순히 반복문을 올바른 횟수만큼 실행합니다. 반복 변수 자리에 '밑줄 문자 (`_`)' 를 사용하면 개별 값을 무시하고 반복문의 각 회차에서 현재 값에 대한 접근을 제공하지 않게 합니다.

상황에 따라, 두 끝 값을 포함해야 하는, '닫힌 범위' 를 사용하고 싶지 않을 수 있습니다. 시계에서 매 분에 대한 눈금을 그린다고 해 봅시다. `60` 분에 대한 눈금은, `0` 분에서 시작하도록, 그리고 싶을 겁니다. '반-열린 범위 연산자 (half-open operator; `..<`)' 를 사용하면 '낮은 경계 값 (lower bound)' 은 포함하고 '높은 경계 값 (upper bound)' 은 포함하지 않게 할 수 있습니다. 범위에 대한 더 많은 내용은, [Range Operators (범위 연산자)]({% post_url 2016-04-27-Basic-Operators %}#range-operators-범위-연산자) 를 참고하기 바랍니다.

```swift
let minutes = 60
for tickMark in 0..<minutes {
  // 매 분에 대한 눈금 표시를 (60 번) 그립니다.
}
```

일부 사용자는 UI 에 눈금이 더 적은 것을 원할 수 있습니다. `5` 분마다 눈금이 하나씩 있는 걸 더 선호할 수도 있습니다. `stride(from:to:by:)` 함수를 사용하면 원하지 않는 눈금을 건너 뛸 수 있습니다.

```swift
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
  // 5 분마다 눈금을 (0, 5, 10, 15, ... 45, 50, 55) 그립니다.
}
```

이 대신 `stride(from:through:by:)` 를 사용하면, '닫힌 범위' 도 사용할 수 있습니다:

```swift
let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
  // 3 시간마다 눈금을 (3, 6, 9, 12) 그립니다.
}
```

### While Loops (While 반복문)

`while` 반복문은 조건이 `false` 가 될 때까지 일정한 구문들을 수행합니다. 이런 종류의 반복문이 가장 많이 사용되는 곳은 첫 번째 '회차 (iteration)' 를 시작하기 전에 반복할 횟수를 알 수 없는 곳입니다. 스위프트는 두 가지 종류의 `while` 반복문을 제공합니다:

* `whle` 문은 각각을 반복할 때 시작 위치에서 조건 값을 계산합니다.
* `repeat-while` 문은 각각을 반복할 때 종료 위치에서 조건 값을 계산합니다.

#### While (While 문)

`while` 반복문은 단일 조건의 값을 계산하는 것으로 시작합니다. 조건이 `true` 이면, 조건이 `false` 가 될 때까지 일정한 구문들을 반복합니다.

`while` 반복문의 일반적인 양식은 다음과 같습니다:

while `condition (조건)` {
  `statements (구문)`
}

```swift
while condition {
  statements
}
```

다음 예제는 _뱀과 사다리 (Snakes and Ladders)_[^snakes-and-ladders] 라는 간단한 개임을 플레이합니다. (이 게임은 _Chutes and Ladders_ (미끄럼틀과 사다리) 라고도 합니다.)

![snakes and ladders](/assets/Swift/Swift-Programming-Language/Control-Flow-snakes-and-ladders.jpg)

게임의 규칙은 다음과 같습니다:

* 게임 '판 (board)' 에는 25 개의 정사각형이 있는데, 최종 목표는 '정사각형 25' 에 도달하거나 이를 넘어가는 것입니다.
* 참여자가 출발하는 곳은 “정사각형 0 (square zero)” 인데, 이는 보드 가장 왼쪽-밑 모서리 외부에 있는 (가상의) 위치입니다.
* 매 '차례 (turn; 턴)' 마다, 6-면체 주사위를 굴려서 그 수만 큼 정사각형, 위에 점선 화살표로 지시한 수평 경로를 따라, 이동합니다.
* 자기 차례일 때 사다리 밑에 도착하게 되면, 그 사다리를 올라갑니다.
* 자기 차례일 때 뱀의 머리에 도착하, 그 뱀 밑으로 내려옵니다.

게임 판은 `Int` 값의 배열로 표현합니다. 크기는 `finalSquare` 라는 상수를 기반으로 하며, 이는 배열을 초기화하는데도 사용하고 예제 끝에서 승리 조건을 검사할 때도 사용하기도 합니다. 참여자가 시작하는 곳이, "정사각형 0" 이기 때문에, 게임 판은 `25` 개가 아니라, `26` 개의 `Int` 값 0 으로 초기화 됩니다.

```swift
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
```

그 다음 일부 정사각형들에 특정한 값을 설정하여 뱀과 사다리를 나타내도록 합니다. 사다리 받침이 있는 정사각형은 게임 판에서 위로 이동할 수 있도록 양수를 가지는 반면, 뱀의 머리가 있는 정사각형은 게임 판에서 아래로 내려가도록 음수를 가지게 됩니다.

```swift
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
```

'정사각형 3' 은 '정사각형 11' 로 올라갈 수 있는 사다리 받침을 가지고 있습니다. 이를 표현하고자, `board[03]` 는 `+08` 라고 두며, 이는 (`3` 과 `11` 의 차이인) 정수 값 `8` 과 같은 것입니다. 값과 구문을 보기 좋게 정렬하기 위해, '단항 양수 연산자 (unary plus operator; `+i`)' 를 '단항 음수 연산자 (unary minus operator; `-`)' 와 같이 사용하였으며 `10` 보다 작은 수치 값은 0 으로 채웠습니다. (문장을 꾸미는 기교는 꼭 필요한 건 아니지만, 코드를 좀 더 깔끔하게 만들어 줍니다.)

```swift
var square = 0
var diceRoll = 0
while square < finalSquare {
  // 주사위를 굴립니다.
  diceRoll += 1
  if diceRoll == 7 { diceRoll = 1 }
  // 굴린 결과 만큼 이동합니다.
  square += diceRoll
  if square < board.count {
    // 아직도 게임 판 위에 있다면, 뱀이냐 사다리냐에 따라 올라가거나 내려가도록 합니다.
    square += board[square]
  }
}
print("Game over!")
```

위의 예제는 주사위를 굴리는 방식이 매우 간단합니다. '난수 (random number)' 를 생성하는 대신, `diceRoll` 값이 `0` 인 상태에서 시작합니다. 매 번 `while` 반복문을 통과할 때마다, `diceRoll` 은 1 만큼 증가한 다음 너무 커진게 아닌지 검사합니다. `7` 을 반환할 때마다, 이 때는 '주사위 굴림 값' 이 너무 커진 것이므로 값을 `1` 로 재설정합니다. 그 결과 일련의 `diceRoll` 값은 항상 `1`, `2`, `3`, `4`, `5`, `6`, `1`, `2` 와 같이 계속됩니다.

주사위를 굴리고 나면, 참여자는 `diceRoll` 개의 정사각형 만큼 앞으로 이동합니다. '주사위 굴림 값' 이 참여자를 '정사각형 25' 너머로 이동하게 할 수도 있는데, 이 경우 게임은 끝나게 됩니다. 이런 상황을 대처하기 위해, 코드는 `square` 가 `board` 배열의 `count` 속성보다 작은 지를 검사합니다. `square` 가 유효한 경우, `board[square]` 에 저장된 값이 현재의 `square` 값에 추가되어 사다리냐 뱀이냐에 따라 참여자를 위로 이동시키기도 하고 아래로 이동시키기도 합니다.

> 이 검사를 하지 않으면, `board[square]` 이 `board` 배열의 경계를 벗어난 값에 접근하려고 할 수도 있어서, '실행시간 에러 (runtime error)' 가 발생할 수도 있습니다.

이러면 현재의 `while` 반복문 실행이 끝난 것이며, 이제 반복문을 다시 실행해야하는 지 확인하기 위해 반복문의 조건을 검사합니다. 참여자가 '정사각형 `25`' 위나 그 너머로 이동했으면, 반복문의 조건 값은 `false` 로 계산되고 게임이 끝납니다.

이 예제는 `while` 반복문이 알맞은 경우인데, 왜냐면 `while` 반복문을 시작할 때 게임 길이가 명확하지 않기 때문입니다. 이 반복문은 특정한 조건을 만족할 때까지 실행됩니다.

#### Repeat-While (Repeat-While 문)

`while` 반복문의 변형으로, `repeat-while` 반복문이 있는데, 이는 반복문의 조건을 검토하기 _전에 (before)_, 먼저 반복문 블럭을 한 번 통과하여 실행합니다. 그런 다음 조건이 `false` 가 될 때까지 반복문을 루프를 계속 '반복합니다 (repeat)'.

> 스위프트의 `repeat-while` 반복문은 다른 언어에 있는 `do-while` 반복문과 비슷합니다.[^do-while]

`repeat-while` 반복문의 일반적인 양식은 다음과 같습니다:

repeat {
  `statements (구문)`
} while `condition (조건)`
```

```swift
repeat {
  statements
} while condition
```

다음은 _뱀과 사다리 (Snakes and Ladders)_ 예제를, `while` 반복문 대신 `repeat-while` 반복문으로 다시 작성한 것입니다. `finalSquare`, `board`, `square`, 와 `diceRoll` 의 값은 `while` 반복문과 완전히 같은 방법으로 초기화됩니다.

```swift
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
```

이 버전의 게임에서, 반복문이 _처음으로 (first)_ 하는 행동은 사다리인지 뱀인지를 검사하는 것입니다. 게임 판의 사다리 중에 참여자를 곧바로 '정사각형 25' 로 보내는 것은 없어서, 사다리로 올라갔다고 게임을 이기지는 않습니다. 따라서, 반복문의 처음 행동이 뱀인지 사다리인지 검사하는 것은 안전합니다.

게임을 시작하면, 참여자는 “정사각형 0 (square zero)” 에 있습니다. `board[0]` 은 항상 `0` 이므로 아무런 영향이 없습니다.

```swift
repeat {
  // 뱀인지 사다리인지에 따라 위나 아래로 이동합니다.
  square += board[square]
  // 주사위를 굴립니다.
  diceRoll += 1
  if diceRoll == 7 { diceRoll = 1 }
  // 굴린 값에 따라 이동합니다.
  square += diceRoll
} while square < finalSquare
print("Game over!")
```

코드에서 뱀인지 사다리인지 확인한 후에는, 주사위를 굴려서 참여자를 `diceRoll` 개의 정사각형 만큼 앞으로 이동합니다. 그러면 현재의 반복문 실행이 끝나게 됩니다.

반복문의 조건 (`while square < finalSquare`) 은 이전과 동일하지만, 이번에는 반복문을 최초 실행이 _끝 (end)_ 나기 전에는 이 값을 계산하지 않습니다. 이 게임 구조에서는 `repeat-while` 반복문이 이전 예제에 있는 `while` 반복문 보다 더 적합합니다. 위 `repeat-while` 반복문에서는, 반복문의 `while` 조건이 `square` 가 여전히 게임 판 위에 있음을 확인 _하자마자 그 즉시 (immediately after)_ `square += board[square]` 를 항상 실행합니다. 이러한 동작 방식은 먼저 설명한 `while` 반복문 버전의 게임에 있던 배열의 경계 값 검사를 필요없게 만듭니다.

### Conditional Statements (조건 구문)

정해진 조건에 따라 서로 다른 코드 조각을 실행하는 것이 유용할 때가 있습니다. 에러가 발생했을 때 부가적인 코드 조각을 실행하거나, 아니면 값이 너무 크거나 작을 때 메시지를 나타내고 싶을 수도 있을 것입니다. 이렇게 하려면, 코드 일부를 _조건부 (conditional)_ 로 만들면 됩니다.

스위프트는 코드에 조건 분기를 추가하기 위해 두 가지 방법을 제공합니다: `if` 문과 `switch` 문이 그것입니다. 일반적으로, 가능한 결과가 적은 단순한 조건 값을 계산할 때는 `if` 문을 사용합니다. `switch` 문은 여러 개의 순서를 가지는 좀더 복잡한 조건에 더 적합하며 '유형 맞춰보기 (pattern matching)' 이 실행할 알맞은 분기를 찾는데 도움을 줄 수 있는 상황에 유용합니다.

#### If (If 문)

가장 간단한 양식의, `if` 구문은 단일한 `if` 조건을 가지고 있습니다. 이 조건이 `true` 일 때만 일정한 구문을 실행합니다.

```swift
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
}
// "It's very cold. Consider wearing a scarf." 를 출력합니다.
```

위의 예제는 온도가 '화씨 (Fahrenheit)' 32도 (물의 어는 점) 보다 낮은 지를 검사합니다. 이에 해당하면, 메시지를 출력합니다. 해당하지 않으면, 메시지를 출력하지 않으며, `if` 문의 '종료 중괄호 (closing brace)' 뒤의 코드를 계속해서 실행합니다.

`if` 문은, `if` 조건이 `false` 일 때의 상황을 위해서, `else clause` 이라는, 일정한 대체 구문을 제공할 수 있습니다. 이 구문은 `else` 키워드를 써서 지시합니다.

```swift
temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
} else {
  print("It's not that cold. Wear a t-shirt.")
}
// "It's not that cold. Wear a t-shirt." 를 출력합니다.
```

이 두 개의 분기 중 하나는 항상 실행됩니다. 온도가 화씨 40도 까지 올랐으므로, 더 이상 스카프를 하라고 조언할 만큼 춥지 않아서 `else` 분기를 대신 실행하게 됩니다.

여러 개의 `if` 구문을 서로 죽 이으면 추가적인 구절을 검토할 수 있습니다.

```swift
temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
  print("It's really warm. Don't forget to wear sunscreen.")
} else {
  print("It's not that cold. Wear a t-shirt.")
}
// "It's really warm. Don't forget to wear sunscreen." 를 출력합니다.
```

여기서는, 추가적인 `if` 구문을 추가하여 특별히 따뜻한 온도일 때 응답하도록 합니다. 마지막 `else` 절은 남아 있어서, 너무 덥지도 춥지도 않는 온도일 때에 대한 응답을 출력합니다.

하지만, 마지막 `else` 절은 '선택 사항 (optional)'[^optional] 이라, 일정한 조건이 '완전해야 (to be complete)' 할 필요가 없는 경우에는 이를 제외할 수 있습니다.

```swift
temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
  print("It's really warm. Don't forget to wear sunscreen.")
}
```

온도가 `if` 나 `else if` 조건을 일으킬 만큼 너무 춥지도 덥지도 않기 때문에, 아무런 메시지도 출력하지 않습니다.

#### Switch (Switch 문)

`switch` 문은 값을 검토하여 해당 가능한 여러 가지 '유형들 (patterns)' 과 비교합니다. 그런 다음, 성공적으로 들어맞는 첫 번째 '유형' 을 기반으로, 적당한 코드 블럭을 실행합니다. `switch` 문은 `if` 문의 대안으로 다양한 잠재적 상태에 대해 응답을 제공합니다.

가장 간단한 양식의, `switch` 문은 하나의 값을 같은 타입의 하나 이상의 값들과 비교하는 것입니다.

switch `some value to consider (검토할 어떤 값)` {
case `value 1 (값 1)`:
    `respond to value 1 (값 1에 대한 응답)`
case `value 2 (값 2)`,
     `value 3 (값 3)`:
    `respond to value 2 or 3 (값 2 또는 3에 대한 응답)`
default:
    `otherwise, do something else (그 외의 경우, 여기서 뭔가를 합니다)`
}

```swift
switch some value to consider {
case value 1:
    respond to value 1
case value 2,
     value 3:
    respond to value 2 or 3
default:
    otherwise, do something else
}
```

모든 `switch` 문은 여러 가지의 가능성 있는 '_경우 값 (cases)_' 들로 구성되어 있는데, 각각은 `case` 키워드로 시작합니다. 특정한 값과 비교하는 것 외에도, 스위프트는 다양한 방법을 제공하여 각각의 '경우 값 (case)' 에 보다 복잡한 '해당 유형 (matching patterns)' 을 지정할 수 있습니다. 이러한 선택 요소들은 이 장의 뒤에서 설명하도록 합니다.

`if` 문의 본문과 마찬가지로, 각각의 `case` 는 코드 실행의 분기에 해당합니다. `switch` 문은 어떤 분기를 선택해야 하는 지 결정합니다. 이러한 절차를 검토하고 있는 값의 _switching (전환; 스위칭)_ 이라고 합니다.

모든 `switch` 문은 반드시 _빠짐없이 철저해야 (exhaustive)_ 합니다. 다시 말해서, 검토 중인 타입에서 발생 가능한 모든 값은 반드시 `switch` '경우 값 (cases)' 중 하나에는 들어맞아야 합니다. 발생 가능한 모든 값에 대해 '경우 값 (case)' 을 제공하는 것이 적절하지 않은 경우라면, 명시적으로 말하지 않은 어떤 값도 다루도록 '기본 설정 경우 값 (default case)' 을 정의할 수도 있습니다. 이 '기본 설정 경우 값' 은 `default` 키워드로 지시하며, 반드시 항상 마지막에 나타내야 합니다.\

다음 예제는 `switch` 문을 사용하여 `someCharacter` 라는 단일한 소문자를 검토합니다:

```swift
let someCharacter: Character = "z"
switch someCharacter {
case "a":
  print("The first letter of the alphabet")
case "z":
  print("The last letter of the alphabet")
default:
  print("Some other character")
}
// "The last letter of the alphabet" 를 출력합니다.
```

`switch` 문의 첫 번째 '경우 값 (case)' 은 영어 알파벳의 첫 번째 글자인, `a` 에 해당하고, 두 번째 '경우 값 (case)' 은 마지막 글자인, `z` 에 해당합니다. `switch` 는 반드시, 모든 알파벳 문자 뿐만 아니라, 발생 가능한 모든 문자에 대한 '경우 값 (case)' 을 가져야 하기 때문에, 이 `switch` 문은 `default` '경우 값 (case)' 를 사용하여 `a` 와 `z` 이외의 모든 문자를 맞춰봅니다. 이런 준비는 `switch` 문이 '빠짐없이 철저하도록 (exhaustive)' 보장합니다.

**No Implicit Fallthrough (암시적으로 빠져나가지 않음)**

**Interval Matching (구간 맞춤)**

**Tuples (튜플)**

**Value Bindings (값 연결짓기)**

**Where (Where 절)**

**Compound Cases (복합 경우 값)**

### Control Transfer Statements (제어 전달 구문)

#### Continue (Continue 문)

#### Break (Break 문)

**Break in a Loop Statement (반복 구문 내의 Break 문)**

**Break in a Switch Statement (Switch 구문 내의 Break 문)**

#### Fallthrough (Fallthrough 문)

#### Labeled Statements (이름표 달린 구문)

### Early Exit (조기 탈출 구문)

### Checking API Availability (API 사용 가능 여부 검사하기)

### 참고 자료

[^Control-Flow]: 이 글에 대한 원문은 [Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html) 에서 확인할 수 있습니다.

[^snakes-and-ladders]: '뱀과 사다리 (Snakes and Ladders)' 는 인도에서 유래하여 영국에서 만들어진 보드 게임이라고 합니다. 'Chutes and Ladders (미끄럼틀과 사다리)' 라는 이름은 이 게임을 미국 회사에서 다시 만들게 되면서 유래한 것 같습니다. 더 자세한 정보는 위키피디아의 [Snakes and Ladders](https://en.wikipedia.org/wiki/Snakes_and_Ladders) 와 [뱀과 사다리](https://ko.wikipedia.org/wiki/뱀과_사다리) 항목을 참고하기 바랍니다.

[^do-while]: 본문에서 `repeat-while` 문이 `do-while` 문과 비슷하다고 표현했는데, 사실 초창기 스위프트는 `repeat-while` 의 이름이 `do-while` 이었습니다. 그러므로 이 둘은 사실상 같은 것이라고 볼 수 있습니다. 이름을 왜 바꿨는지는 잘 모르겠습니다.

[^optional]: 여기서의 '선택 사항 (optional)' 은 스위프트의 '옵셔널 (optional)' 타입 과는 상관 없습니다. 스위프트는 일상 생활에서 쓰는 영어 단어를 키워드로 많이 사용하기 때문에 이런 경우가 종종 있습니다. '옵셔널 타입 (optional type)' 도 '값을 선택적으로 가질 수 있는 타입' 이라는 의미로 'optional' 이라는 영어 단어를 사용하는 것입니다.
