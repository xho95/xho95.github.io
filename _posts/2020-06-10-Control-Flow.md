---
layout: post
comments: true
title:  "Swift 5.3: Control Flow (제어 흐름)"
date:   2020-06-10 10:00:00 +0900
categories: Swift Language Grammar Control-Flow For-In While Switch
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html) 부분[^Control-Flow]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 스위프트 5.3 에 대한 내용이 다시 일부 수정되어서,[^swift-update] 추가된 내용 먼저 옮기고 나머지 부분을 옮기도록 합니다. 전체 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Control Flow (제어 흐름)

스위프트는 다양한 제어 흐름 구문을 제공합니다. 여기에 포함된 것은 작업을 여러 번 수행하는 `while` 반복 구문; 정해진 조건에 따라 다른 분기에 있는 코드를 실행하는 `if`, `guard`, 및 `switch` 구문; 그리고 `break` 와 `continue` 같이 실행 흐름을 코드의 다른 지점으로 전달하는 구문입니다.

스위프트는 `for-in` 반복 구문도 제공하므로 배열, 딕셔너리, 범위, 문자열, 및 기타 '일련의 값들 (sequences)' 에 대해 동작을 쉽게 반복 적용할 수 있습니다.

스위프트의 `switch` 문은 C-계열 언어에 있는 것보다 눈에 띄게 더 강력합니다. 'case 절' 는 아주 다양한 '유형 (patterns)' 에 대해서 해당하는 것을 찾을 수 있으며, '구간 맞춰보기 (interval matches)', 튜플 맞춰보기, 그리고 지정된 타입으로의 '변환 (casts)' 기능도 포함합니다. `switch` 의 'case 절' 에 해당하는 값은 임시 상수나 변수로 연결되어서 'case 절' 본문 내에서 사용할 수 있으며, 각 'case 절' 에 `where` 절을 사용하면 찾는 조건이 복잡한 것도 표현할 수 있습니다.

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

`while` 반복문의 일반적인 형식은 다음과 같습니다:

while `condition (조건)` {<br />
  `statements (구문)`<br />
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

`repeat-while` 반복문의 일반적인 형식은 다음과 같습니다:

repeat {<br />
  `statements (구문)`<br />
} while `condition (조건)`<br />

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

스위프트는 코드에 조건 분기를 추가하기 위해 두 가지 방법을 제공합니다: `if` 문과 `switch` 문이 그것입니다. 일반적으로, 가능한 결과가 적은 단순한 조건 값을 계산할 때는 `if` 문을 사용합니다. `switch` 문은 여러 개의 순서를 가지는 좀더 복잡한 조건에 더 적합하며 '패턴 매칭 (pattern matching; 유형 맞춤)' 을 실행할 알맞은 분기를 찾는데 도움을 줄 수 있는 상황에 유용합니다.

#### If (If 문)

가장 간단한 양식의, `if` 구문은 단일한 `if` 조건을 가지고 있습니다. 이 조건이 `true` 일 때만 일정한 구문을 실행합니다.

```swift
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
}
// "It's very cold. Consider wearing a scarf." 를 출력합니다.
```

위의 예제는 온도가 '화씨 (Fahrenheit)' 32도 (물의 어는 점) 보다 낮은 지를 검사합니다. 이에 해당하면, 메시지를 출력합니다. 해당하지 않으면, 메시지를 출력하지 않으며, `if` 문의 '닫는 중괄호 (closing brace)' 뒤의 코드를 계속해서 실행합니다.

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

모든 `switch` 문은 여러 가지의 가능성 있는 '_case 절 (cases)_' 들로 구성되어 있는데, 각각은 `case` 키워드로 시작합니다. 특정한 값과 비교하는 것 외에도, 스위프트는 다양한 방법을 제공하여 각각의 'case 절' 에 보다 복잡한 '해당 유형 (matching patterns)' 을 지정할 수 있습니다. 이러한 선택 요소들은 이 장의 뒤에서 설명하도록 합니다.

`if` 문의 본문과 마찬가지로, 각각의 `case` 는 코드 실행의 분기에 해당합니다. `switch` 문은 어떤 분기를 선택해야 하는 지 확인합니다. 이러한 절차를 검토하고 있는 값의 _switching (전환; 스위칭)_ 이라고 합니다.

모든 `switch` 문은 반드시 _빠짐없이 철저해야 (exhaustive)_ 합니다. 다시 말해서, 검토 중인 타입에서 발생 가능한 모든 값은 반드시 `switch` 'case 절' 중 하나에는 들어맞아야 합니다. 발생 가능한 모든 값에 대해 'case 절' 을 제공하는 것이 적절하지 않은 경우라면, 명시적으로 말하지 않은 어떤 값도 다루도록 '기본 case 절 (default case)' 을 정의할 수도 있습니다. 이 '기본 case 절' 은 `default` 키워드로 지시하며, 반드시 항상 마지막에 나타내야 합니다.

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

`switch` 문의 첫 번째 'case 절' 은 영어 알파벳의 첫 번째 글자인, `a` 에 해당하고, 두 번째 'case 절' 은 마지막 글자인, `z` 에 해당합니다. `switch` 는 반드시, 모든 알파벳 문자 뿐만 아니라, 발생 가능한 모든 문자에 대한 'case 절' 을 가져야 하기 때문에, 이 `switch` 문은 `default` 'case 절' 를 사용하여 `a` 와 `z` 이외의 모든 문자를 맞춰봅니다. 이런 준비는 `switch` 문이 '빠짐없이 철저하도록 (exhaustive)' 보장합니다.

**No Implicit Fallthrough (암시적으로 빠져나가지 않음)**

C 와 오브젝티브-C 언어의 `switch` 문과 다른 점이라면, 스위프트의 `switch` 문은 기본적으로 각 'case 절' 을 빠져나가서 그 다음으로 넘어가지 않습니다. 그 대신, 전체 `switch` 문은, 명시적으로 `break` 문을 쓸 필요없이, 첫 번째로 해당하는 `switch` 'case 절' 을 완료하는 순간 그 즉시 실행을 종료합니다. 이것은 `switch` 문을 C 언어에 있는 것보다 더 안전하고 편하게 쓸 수 있게 하며 실수로 다른 `switch` 'case 절' 을 실행하는 것을 피하도록 해줍니다.

> 스위프트에서 `break` 는 필수적인 것은 아니지만, `break` 문을 사용하면 특정한 'case 절' 을 맞춰보거나 무시하도록 할 수 있고 아니면 해당하는 'case 절' 의 실행이 완전이 끝나기 전에 먼저 빠져 나오도록 할 수도 있습니다. 더 자세한 내용은, [Break in a Switch Statement (Switch 구문 내의 Break 문)](#break-in-a-switch-statement-switch-문-내의-break-문) 을 참고하기 바랍니다.

각 'case 절' 의 본문에는 _반드시 (must)_ 최소 하나 이상의 실행 문이 있어야 합니다. 다음 처럼 작성한 코드는 유효하지 않는데, 첫 번째 'case 절' 이 비어있기 때문입니다:

```swift
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a": // 무효, case 절이 빈 본문을 가지고 있습니다.
case "A":
  print("The letter A")
default:
  print("Not the letter A")
}
// 이렇게 하면 컴파일-시간 에러를 보고하게 됩니다.
```

C 언어의 `switch` 문과는 다르게, 이 `switch` 문은 `"a"` 와 `"A"` 둘 다를 한번에 맞춰보지 않습니다. 그 보다는, `case "a":` 에는 실행 가능한 구문이 어떤 것도 없다고 '컴파일-시간 에러 (compile-time error)' 를 보고해 버립니다. 이러한 접근 방법은 우연히 한 'case 절' 에서 다른 'case 절' 으로 빠져 나가는 것을 피하도록 해서 의도가 더 분명한 더 안전한 코드를 만들 수 있게 해줍니다.

`switch` 에서 `"a"` 와 `"A"` 둘 모두에 해당하는 단일한 'case 절' 을 만들려면, 두 값을 쉼표로 구분해서, '복합 case 절 (compound case)' 으로 병합하면 됩니다.

```swift
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a", "A":
  print("The letter A")
default:
  print("Not the letter A")
}
// "The letter A" 를 출력합니다.
```

가독성을 위해, '복합 case 절' 을 여러 줄에 나눠서 작성할 수도 있습니다. '복합 case 절' 에 대한 더 많은 정보는, [Compound Cases (복합 case 절)](#compound-cases-복합-case-절) 을 참고하기 바랍니다.

> 특정한 `switch` 'case 절' 의 끝에서는 명시적으로 빠져 나가고 싶다면, `fallthrough` 키워드를 사용하면 되는데, 이는 [Fallthrough (Fallthrough 문)](#fallthrough-fallthrough-문) 에서 설명합니다.

**Interval Matching (구간 맞춰보기)**

`switch` 'case 절' 에 있는 값은 일정 구간에 포함 되어있는 지 검사할 수 있습니다. 다음 예제는 수치 구간을 사용하여 어떤 크기의 수에 대해서도 자연-어로 헤아릴 수 있는 기능을 제공합니다:

```swift
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
  naturalCount = "no"
case 1..<5:
  naturalCount = "a few"
case 5..<12:
  naturalCount = "several"
case 12..<100:
  naturalCount = "dozens of"
case 100..<1000:
  naturalCount = "hundreds of"
default:
  naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
// "There are dozens of moons orbiting Saturn." 를 출력합니다.
```

위의 예제의, `approximateCount` 는 `switch` 문 내에서 값을 계산합니다. 각 `case` 는 이 값을 하나의 수 또는 구간과 비교합니다. `approximateCount` 의 값은 `12` 와 `100` 사이에 있으므로, `naturalCount` 에는 `"dozens of"` 라는 값을 할당하고, 실행은 `switch` 문 밖으로 전달됩니다.

**Tuples (튜플)**

'튜플 (tuple)' 을 사용하면 동일한 `switch` 문에서 여러 값을 한번에 테스트할 수 있습니다. 이 때 튜플의 각 '원소 (element)' 마다 서로 다른 값 혹은 값 구간을 테스트할 수 있습니다. 다른 방법으로는, '와일드카드 패턴 (wildcard pattern)'[^wildcard-pattern] 이라고도 하는, '밑줄 문자 (underscore character; `_`)' 를 사용하여, 발생 가능한 어떤 값도 해당하도록 할 수 있습니다.

아래 예제는, `(Int, Int)` 타입의 간단한 튜플로 표현한, (x, y) 점 하나를 받아서, 이를 예제 다음에 있는 그래프 상에서 분류합니다.

```swift
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
  print("\(somePoint) is at the origin")
case (_, 0):
  print("\(somePoint) is on the x-axis")
case (0, _):
  print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
  print("\(somePoint) is inside the box")
default:
  print("\(somePoint) is outside of the box")
}
// "(1, 1) is inside the box" 를 출력합니다.
```

![a (x, y) point with tuples](/assets/Swift/Swift-Programming-Language/Control-Flow-tuples.png)

`switch` 문은 이 점이 있는 곳이 (0, 0) 인 원점인지, 빨간색 x-축인지, 주황색 y-축인지, 중심이 원점인 파란색 4x4 상자 내부인지, 아니면 상자 외부인지를 확인합니다.

C 언어와는 달리, 스위프트에서는 여러 `switch` 'case 절' 에서 같은 값 또는 같은 값들을 검토할 수 있습니다. 실제로, 이 예제에서 '점 (0, 0)' 은 _네 가지 (four)_ 경우 모두에 다 해당할 수 있습니다. 하지만, 해당되는 것이 여러 개일 수 있는 경우, 맨 처음 해당된 'case 절' 이 항상 사용됩니다. '점 (0, 0)' 은 먼저 `case (0, 0)` 에 해당하게 되므로, 다른 모든 해당하는 'case 절' 들은 무시하게 됩니다.

**Value Bindings (값 연결)**

`switch` 'case 절' 은 해당 값이나 값들에 임시 상수 또는 임시 변수에 해당하는 이름을 지어서, 'case 절' 본문에서 사용할 수 있습니다. 이런 동작 방식을 _값 연결 (value binding)_ 라고 하는데, 이 값은 'case 절' 본문 범위 내에서 임시 상수 또는 임시 변수로 연결되기 때문입니다.

아래 예제는, `(Int, Int)` 타입의 간단한 튜플로 표현한, (x, y) 점 하나를 받아서, 이를 예제 다음에 있는 그래프 상에서 분류합니다:

```swift
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
  print("on the x-axis with an x value of \(x)")
case (0, let y):
  print("on the y-axis with a y value of \(y)")
case let (x, y):
  print("somewhere else at (\(x), \(y))")
}
// "on the x-axis with an x value of 2" 를 출력합니다.
```

![a (x, y) point with value bindings](/assets/Swift/Swift-Programming-Language/Control-Flow-value-bindings.png)

`switch` 문은 이 점이 있는 곳이 빨간색 x-축인지, 주황색 y-축인지, 아니면 (어느 축도 아닌) 다른 곳인지를 확인합니다.

세 개의 `switch` 'case 절' 은 '자리 표시용 (placeholder)' 상수인 `x` 와 `y` 를 선언하고 있는데, 이는 `anotherPoint` 에 있는 튜플 값 중 하나 또는 두 개 모두를 임시로 맡습니다. 첫 번째 'case 절' 인, `case (let x, 0)` 는, `y` 값이 `0` 이면 어떤 점에든 해당하여 그 점의 `x` 값을 임시 상수인 `x` 에 할당합니다. 마찬가지로, 두 번째 'case 절' 인, `case (0, let y)` 는, `x` 값이 `0` 이면 어떤 점에든 해당하여 그 점의 `y` 값을 임시 상수인 `y` 에 할당합니다.

임시 상수를 선언하고 나면, 이를 'case 절' 의 코드 블럭에서 사용할 수 있습니다. 여기서는, 해당 점의 '분류 (categorization)' 를 출력하는데 사용합니다.

이 `switch` 문에는 `default` 'case 절' 이 없습니다. 마지막 'case 절' 인, `case let (x, y)` 는, 어떤 값과도 맞춰질 수 있는 두 개의 '자리 표시자' 상수를 가지는 '튜플' 을 선언합니다. `anotherPoint` 는 항상 두 값을 가지고 있는 튜플이기 때문에, 이 경우 모든 가능한 남은 값들에 맞춰질 수 있어서, `switch` 문을 '빠짐없이 철저하게 (exhaustive)' 만들기 위해 `default` 'case 절' 이 필요한 건 아닙니다.

**Where (Where 절)**

`switch` 'case 절' 에서 `where` 절을 사용하면 추가적인 조건을 검사할 수 있습니다:

아래 예제는 하나의 (x, y) 점을 그 다음의 그래프 상에서 분류합니다:

```swift
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
  print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
  print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
  print("(\(x), \(y)) is just some arbitrary point")
}
// "(1, -1) is on the line x == -y" 를 출력합니다.
```

![a (x, y) point with where](/assets/Swift/Swift-Programming-Language/Control-Flow-where.png)

`switch` 문은 이 점이 있는 곳이 `x == y` 인 녹색 대각선 상인지, `x == -y` 인 보라색 대각선 상인지, 아니면 어느 쪽도 아닌지를 확인합니다.

세 개의 `switch` 'case 절' 들은 '자리 표시용 (placeholder)' 상수인 `x` 와 `y` 를 선언하고 있는데, 이는 `yetAnotherPoint` 에 있는 튜플 값 두 개 모두를 임시로 맡습니다. 이 상수는 `where` 절의 일부로 사용되어, '동적인 필터 (dynamic filter)' 를 생성합니다.

`switch` 'case 절' 은 `where` 절의 조건 값이 `true` 로 계산된 경우에만 현재의 `point` 값과 맞춰봅니다.

이전 예제에서와 같이, 마지막 'case 절' 은 모든 가능한 남은 값들에 맞춰지므로, `switch` 문을 '빠짐없이 철저하게 (exhaustive)' 만들기 위해 `default` 'case 절' 이 필요한 건 아닙니다.

<p>
<strong id="compound-cases-복합-case-절">Compound Cases (복합 case 절)</strong>
</p>

같은 본문을 공유하는 여러 'switch 문의 case 절 (switch cases)' 들은 `case` 뒤에 여러 개의 '유형 (patterns)' 을, 그 사이는 쉼표를 써서, 작성하는 것으로 복합할 수 있습니다. '유형' 중 어떤 하나에라도 해당된다면, 그 'case 절' 에 해당하는 것으로 간주합니다. '유형 (patterns)' 은, 목록이 길다면, 여러 줄에 걸쳐 작성할 수 있습니다. 예를 들면 다음과 같습니다:

```swift
let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
  print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
  print("\(someCharacter) is a consonant")
default:
  print("\(someCharacter) is not a vowel or a consonant")
}
// "e is a vowel" 를 출력합니다.
```

`switch` 문의 첫 번째 'case 절' 은 영어에 있는 다섯 개의 모든 소문자 '모음 (vowels)' 에 해당합니다. 이와 비슷하게, 두 번째 'case 절' 는 모든 영어 소문자 '자음 (consonants)' 에 해당합니다. 마지막으로, `default` 'case 절' 에는 어떤 다른 문자라도 해당됩니다.

'복합 case 절 (compound cases)' 은 '값 연결 (value bindings)' 를 포함할 수도 있습니다. '복합 case 절' 의 모든 '유형' 은 일종의 같은 '값 연결 (value bindings)' 들만 포함해야 하며, 각각의 '연결 (bindin)' 은 '복합 case 절' 에 있는 모든 '유형' 에서 같은 타입의 값만 가져와야 합니다. 이렇게 하면, '복합 case 절' 의 어느 부분이 맞춰진 것이든, 'case 절' 의 본문 코드에서 이 '연결 (bindings)' 값에 항상 접근할 수 있으며 그 값이 항상 같은 타입임을 보장하게 됩니다.

```swift
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
  print("On an axis, \(distance) from the origin")
default:
  print("Not on an axis")
}
// "On an axis, 9 from the origin" 를 출력합니다.
```

위의 `case` 는 두 개의 '유형 (patterns)' 을 가지고 있습니다: `(let distance, 0)` 은 x-축 위에 있는 점에 해당하며, `(0, let distance)` 는 y-축 위에 있는 점에 해당합니다. 두 '유형' 모두 `distance` 에 대한 '연결 (binding)' 을 포함하고 있으며 `distance` 는 두 '유형' 모두에서 하나의 '정수' 입니다-이것은 `case` 본문 코드가 `distance` 의 값에 항상 접근할 수 있음을 의미합니다.

### Control Transfer Statements (제어 전달 구문)

_제어 전달 구문 (control transfer statements)_ 은, 제어를 코드 한 곳에서 다른 곳으로 전달하여, 코드가 실행되는 순서를 바꿉니다. 스위프트는 다섯 개의 '제어 전달 구문' 을 가지고 있습니다:

* `continue`
* `break`
* `fallthrough`
* `return`
* `thorw`

`continue`, `break`, 그리고 `fallthrough` 문은 아래에서 설명합니다. `return` 문은 [Functions (함수)]({% post_url 2020-06-02-Functions %}) 에서 설명하며, `throw` 문은 [Propagating Errors Using Throwing Functions ('던지는 함수' 로 에러 전파하기)]({% post_url 2020-05-16-Error-Handling %}#propagating-errors-using-throwing-functions-던지는-함수-로-에러-전파하기) 에서 설명합니다.

#### Continue (Continue 문)

`continue` 문은 반복문에게 말해서 지금 하고 있는 것을 중지하고 해당 '반복 (loop)' 를 지나쳐서 다음 '회차 (iteration)' 의 맨 앞에서 다시 시작하도록 합니다. 이는 해당 '반복' 을 완전히 떠나지 않은 채로 "현재 '반복 회차 (loop iteration)' 에서 할 건 다했다" 라고 말하는 것입니다.

다음의 예제는 소문자로 된 문자열에서 모든 '모음 (vowels)' 과 '공백 (spaces)' 을 제거하여 '수수께끼 상태 (cryptic puzzle phrase)' 를 생성합니다:

```swift
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
  if charactersToRemove.contains(character) {
    continue
  }
  puzzleOutput.append(character)
}
print(puzzleOutput)
// "grtmndsthnklk" 를 출력합니다.
```

위의 코드는 '모음' 이나 '공백' 에 해당할 때마다 `continue` 키워드를 호출하여, '반복' 의 현재 '회차' 를 즉시 끝내고 다음 '회차' 의 시작으로 곧장 넘어갑니다.

#### Break (Break 문)

`break` 문은 '제어 흐름 구문 (control flow statement)' 전체의 실행을 그 즉시 종료합니다. `switch` 문이나 반복문의 실행을 다른 경우보다 더 일찍 끝내고 싶을 때는 `break` 문을 `switch` 문이나 반복문 안에 사용해주면 됩니다.

**Break in a Loop Statement (반복문 내의 Break 문)**

반복문 안에서 사용하는, `break` 는 반복문의 실행을 그 즉시 종료하고 '제어권 (control)' 를 반복문의 '닫는 중괄호 (closing brace; `}`)' 뒤의 코드로 전달합니다. 반복문의 현재 '회차 (iteration)' 에 있는 코드는 더 이상 실행되지 않으며, 반복문의 '회차' 도 더 이상 새로 시작하지 않습니다.

<p>
<strong id="break-in-a-switch-statement-switch-문-내의-break-문">Break in a Switch Statement (Switch 문 내의 Break 문)</strong>
</p>

`switch` 문 안에서 사용하는, `break` 는 `switch` 문의 실행을 그 즉시 종료하게 만들고 '제어권 (control)' 을 `switch` 문의 '닫는 중괄호 (`}`)' 뒤의 코드로 전달합니다.

이런 동작 방식은 `switch` 문의 하나 이상의 'case 절' 에 맞춰지도록 해서 이를 무시하는 데 사용할 수 있습니다. 스위프트의 `switch` 문은 '빠짐없이 철저해야 (exhaustive)' 하고 빈 'case 절' 을 허용하지 않기 때문에, 의도를 명시적으로 드러내기 위해 어떤 'case 절' 를 일부러 맞춰지도록 해서 무시하는 것이 필요할 때가 있습니다. 이렇게 하려면 무시하고 싶은 'case 절' 전체 본문으로 `break` 문을 써주면 됩니다. 해당 'case 절' 이 `switch` 문에 의해 맞춰지면, 'case 절' 안에 있는 `break` 문이 `switch` 문의 실행을 그 즉시 종료합니다.

> `switch` 'case 절' 이 '주석 (comment)' 만 가지고 있으면 '컴파일 시간 에러 (compile-time error)' 를 보고합니다. '주석' 은 '구문 (statements)' 이 아니며 `switch` 'case 절' 무시하도록 하지 않습니다. `switch` 'case 절' 를 무시하려면 항상 `break` 문을 사용하도록 합니다.

다음 예제는 `Character` 값을 '전환 (switch)' 하여 이것이 네 가지 언어 중 하나로 표현한 '수치 기호' 가 맞는 지를 확인합니다. 간결하게 하려고, 단일 `switch` 'case 절' 에서 여러 개의 값을 다루고 있습니다.

```swift
let numberSymbol: Character = "三"  // 중국 글자로 나타낸 3 이라는 수입니다.
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
  possibleIntegerValue = 1
case "2", "٢", "二", "๒":
  possibleIntegerValue = 2
case "3", "٣", "三", "๓":
  possibleIntegerValue = 3
case "4", "٤", "四", "๔":
  possibleIntegerValue = 4
default:
  break
}
if let integerValue = possibleIntegerValue {
  print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
  print("An integer value could not be found for \(numberSymbol).")
}
// "The integer value of 三 is 3." 를 출력합니다.
```

이 예제는 `numberSymbol` 을 검사하여 이것이 `1` 에서 `4` 에 이르는 라틴어, 아랍어, 중국어, 또는 태국어 수치 기호인지를 확인합니다. 해당하는 것을 발견하면, `switch` 문의 'case 절' 중 하나에서 `possibleIntegerValue` 라는 '옵셔널 (optional) `Int?`' 변수에 적절한 정수 값을 설정합니다.

`switch` 문의 실행을 완료한 후, 이 예제는 '옵셔널 연결 (optional binding)' 을 사용하여 값을 찾았는 지를 확인합니다. `possibleIntegerValue` 변수는 '옵셔널 타입' 이 가지는 미덕에 의해서 암시적으로 `nil` 이라는 초기 값을 가지므로, '옵셔널 연결' 이 성공하는 경우는 `switch` 문의 처음 네 'case 절' 중 하나에 의해 `possibleIntegerValue` 에 실제 값이 설정되었을 때 뿐입니다.

위 예제에서 발생 가능한 모든 `Character` 값을 나열하는 것은 실용적이지 않으므로, `default` 'case 절' 으로 해당하지 않는 모든 문자들을 처리할 수 있습니다. 이 `default` 'case 절' 은 아무런 행동을 할 필요가 없으므로, 본문으로 단일 `break` 문을 작성하면 됩니다. `default` 'case 절' 으로 맞춰지자 마자, `break` 문이 `switch` 문의 실행을 종료하고, 코드 실행은 `if let` 문부터 계속하게 됩니다.

#### Fallthrough (Fallthrough 문)

스위프트의, `switch` 문은 각각의 'case 절' 끝에서 빠져 나가서 그 다음으로 넘어가는 행동을 하지 않습니다. 다시 말해서, 가장 먼저 맞춰진 'case 절' 을 완료하자 마자 전체 `switch` 문의 실행을 완료합니다. 이와는 대조적으로, C 언어에서는 빠져 나가는 것을 막기 위해 모든 `switch` 'case 절' 끝에 명시적으로 `break` 문을 넣어주는 것이 필수입니다. 기본적으로 빠져 나가지 않도록 되어 있다는 것은 스위프트의 `switch` 문이 C 언어에 있는 것보다 좀 더 간결하고 예측 가능하다는 것을 의미하며, 그로 인해 여러 개의 `switch` 'case 절' 을 실수로 실행하게 되는 것을 피하도록 해줍니다.

C-스타일의 '빠져 나가는 (fallthrough)' 동작이 필요한 경우, 각각의 경우마다 `fallthrough` 키워드를 사용하면 이런 동작 방식을 선택할 수도 있습니다. 아래의 예제는 `fallthrough` 를 사용하여 수치 값의 글 설명을 생성합니다.

```swift
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
  description += " a prime number, and also"
  fallthrough
default:
  description += " an integer."
}
print(description)
// "The number 5 is a prime number, and also an integer." 를 출력합니다.
```

이 예제는 `description` 이라는 새로운 `String` 변수를 선언하고 초기 값을 할당합니다. 이 함수는 그 다음 `switch` 문을 사용하여 `integerToDescribe` 의 값을 검토합니다. `integerToDescribe` 의 값이 목록에 있는 '소수 (prime number)' 중 하나라면, 함수는 `description` 끝에 문장을 추가하여, 이 수가 '소수' 임을 표기합니다. 이 다음 `fallthrough` 키워드를 사용하여 `default` 'case 절' 에 까지 "빠져 들어갑니다. (fall into)" `default` 'case 절' 은 설명 끝에 약간의 부가적인 문장을 추가한 후, `switch` 문을 완료합니다.

`integerToDescribe` 의 값이 '알려진 소수' 의 목록에 있는 것이 아니라면, 첫 번째 `switch` 'case 절' 에 맞춰질 일이 전혀 없습니다. 지정된 다른 'case 절' 이 따로 없으므로, `integerToDescribe` 는 `default` 'case 절' 에 맞춰집니다.

`switch` 문의 실행이 끝난 다음에는, `print(_:separator:terminator:)` 함수를 사용하여 이 수에 대한 설명을 출력합니다. 이 예제에 있는, 수 `5` 는 '소수 (prime number)' 라고 올바르게 식별되고 있습니다.

> `fallthrough` 키워드는 '빠져 들어가서 (fall into)' 실행할 `switch` 'case 절' 에 대한 조건을 검사하지 않습니다. `fallthrough` 키워드는 단순히 코드 실행을 다음 'case 절' (또는 `default` 'case 절') 에 있는 구문으로 직접 이동하는 것으로, 이는 C 언어의 표준 `switch` 문의 동작과 같습니다.

#### Labeled Statements (이름표 달린 구문)

스위프트는, 복잡한 '제어 흐름 구조' 를 생성하기 위해 반복문과 조건문을 다른 반복문과 조건문 안에 '중첩 (nest)' 할 수 있습니다. 하지만, 반복문과 조건문 둘다 `break` 문을 사용하다보면 실행을 너무 이르게 종료할 수 있습니다. 그러므로, `break` 문이 어떤 반복문이나 어떤 조건문을 종료할 것인지를 명시하는 것이 좋을 때가 있습니다. 이와 비슷하게, '다중 중첩 반복문 (multiple nested loops)' 에서는, `continue` 문이 어떤 반복문에 적용될 지를 명시하는 것이 좋을 수 있습니다.

이런 최총 목표를 달성하기 위해, 반복 구문이나 조건 구문에 _구문 이름표 (statement label)_ 를 표시할 수 있습니다. 조건 구문에서는, 구문 이름표와 `break` 문을 같이 사용하여 '이름표 달린 구문 (labeled statement)' 의 실행을 종료할 수 있습니다. 반복 구문에서는, '이름표 달린 구문' 에 `break` 또는 `continue` 문을 같이 사용하여 '이름표 달린 구문' 의 실행을 종료하거나 계속하게 할 수 있습니다.

'이름표 달린 구문' 을 지시하려면 해당 구문의 '도입자 (introducer)' 키워드와 같은 줄에 이름표를 붙이고, 뒤에 '콜론 (colon; `:`)' 을 써주면 됩니다. 다음은 `while` 반복문에 대한 이 '구문 표현' 의 예제이며, 이 원리는 모든 반복문과 `switch` 에서도 동일합니다:

`label name (이름표의 이름)`: while `condition (조건)` {
    `statements (구문)`
}

```swift
label name: while condition {
    statements
}
```

다음 예제는 이름표 달린 `while` 반복문에 `break` 문과 `continue` 문을 사용하여 이 장 앞에서 봤던 _뱀과 사다리 (Snakes and Ladders)_ 게임을 개선한 버전입니다. 단 이번에는, 게임에 부가적인 규칙이 있습니다:

* 승리하려면, 반드시 _정확하게 (exactly)_ '정사각형 25' 에 도착해야 합니다.

특정한 '주사위 굴림 값' 이 '정사각형 25' 을 넘어서게 만들 경우, '정사각형 25' 에 정확하게 도착하는 수가 나올 때까지 반드시 다시 굴려야 합니다.

게임 판은 이전과 똑같습니다.

![snakes and ladders](/assets/Swift/Swift-Programming-Language/Control-Flow-snakes-and-ladders.jpg)

`finalSquare`, `board`,  `square`, 그리고 `diceRoll` 의 값도 이전과 똑같은 방법으로 초기화합니다:

```swift
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
```

이 버전의 게임은 `while` 반복문과 `switch` 문을 사용하여 게임 로직을 구현합니다. `while` 반복문은 `gameLoop` 라는 '구문 이름표 (statement label)' 를 가지고 자신이 '뱀과 사다리' 게임의 '주요 게임 반복문' 임을 지시합니다.

`while` 반복문의 조건은 `while square != finalSquare` 이며, 이는 반드시 정확하게 '정사각형 25' 에 도착해야 함을 반영합니다.

```swift
gameLoop: while square != finalSquare {
  diceRoll += 1
  if diceRoll == 7 { diceRoll = 1 }
  switch square + diceRoll {
  case finalSquare:
    // diceRoll will move us to the final square, so the game is over
    break gameLoop
  case let newSquare where newSquare > finalSquare:
    // diceRoll will move us beyond the final square, so roll again
    continue gameLoop
  default:
    // this is a valid move, so find out its effect
    square += diceRoll
    square += board[square]
  }
}
print("Game over!")
```

각각의 반복을 시작할 때마다 주사위를 굴립니다. 이 반복문은 참여자를 곧 바로 이동하는 대신, `switch` 문으로 이동 결과를 검토하여 이동할 수 있는 지를 먼저 확인합니다.

* '주사위 굴림 값' 이 참여자를 '최종 정사각형' 으로 이동시킨다면, 게임이 끝난 것입니다. `break gameLoop` 구문은 '제어권 (control)' 을 `while` 반복문 밖에 있는 코드의 첫 번째 줄로 전달하는데, 이는 게임을 종료합니다.
* '주사위 굴림 값' 이 참여자를 '최종 정사각형' 너머로 이동시킨다면, 이 이동은 무효한 것이며 참여자는 (주사위를) 다시 굴려야 합니다. `continue gameLoop` 구문은 현재의 `while` 반복 '회차 (iteration)' 을 종료하고 그 다음 반복 '회차' 를 시작합니다.
* 이외의 다른 모든 경우에는, '주사위 굴림 값' 이 유효합니다. 참여자는 `diceRoll` 개의 정사각형 만큼 앞으로 이동하고, 게임 로직은 뱀인지 사다리인지를 검사합니다. 이제 반복을 종료하고, '제어권 (control)' 이 `while` 조건으로 돌아와서 다른 '차례 (턴; turn)' 이 필요한지를 결정합니다.

> 위의 `break` 문에서 `gameLoop` 이름표를 사용하지 않으면, `while` 문이 아니라, `switch` 문을 중단하게 됩니다. `gameLoop` 이름표를 사용하는 것은 끝나는 제어문이 어떤 것인지를 명확하게 만들어 줍니다.
>
> 반복문의 다음 '회차 (iteration)' 로 건너뛰기 위해 `gameLoop` 이름표를 써서 `continue gameLoop` 라고 꼭 호출해야만 할 필요는 없습니다. 이 게임에는 반복문이 하나만 있어서, `continue` 문이 영향을 미칠 반복문이 어떤 것인지 모호할 일이 없습니다. 하지만, `continue` 문에 `gameLoop` 이름표를 사용한다고 문제될 건 아무 것도 없습니다. 이렇게 하면 `break` 문에 짝이 되어 일관성이 있으며 게임 로직을 좀 더 명확하게 읽고 이해하도록 도와줍니다.

### Early Exit (조기 탈출 구문)

`guard` 문은, `if` 문 처럼, '표현식 (expression)' 의 '불리언 값 (Boolean value)' 에 따라 구문을 실행합니다. `guard` 문을 사용하면 `guard` 문 이 후의 코드를 실행하려면 조건이 반드시 '참 (true)' 일 것을 요구하게 됩니다. `if` 문과는 다르게, `guard` 문에는 항상 `else` 절이 있습니다-조건이 '참 (true)' 이 아닐 경우 `else` 절 안에 있는 코드가 실행됩니다.

```swift
func greet(person: [String: String]) {
  guard let name = person["name"] else {
    return
  }

  print("Hello \(name)!")

  guard let location = person["location"] else {
    print("I hope the weather is nice near you.")
    return
  }

  print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])
// "Hello John!" 를 출력합니다.
// "I hope the weather is nice near you." 를 출력합니다.
greet(person: ["name": "Jane", "location": "Cupertino"])
// "Hello Jane!" 를 출력합니다.
// "I hope the weather is nice in Cupertino." 를 출력합니다.
```

`guard` 문의 조건에 부합하는 경우, 코드 실행은 `guard` 문의 '닫는 중괄호 뒤에서부터 계속됩니다. (`guard` 문의) 조건부에서 '옵셔널 연결 (optional binding)' 로 값을 할당한 변수나 상수는 어떤 것이든 `guard` 문이 있는 코드 블럭의 나머지 부분에서 사용할 수 있습니다.

해당 조건에 부합하지 않는 경우, `else` 분기 내의 코드를 실행합니다. 이 분기는 `guard` 문이 있는 코드 블록을 반드시 탈출하도록 '제어권 (control)' 을 전달해야 합니다. 이는 `return`, `break`, `continue`,  또는 `throw` 와 같은 '제어 전송 구문 (control transfer statement)' 으로 할 수 있으며, 아니면 아예 `fatalError(_:file:line:)` 같이, 반환을 하지 않는 함수나 메소드를 호출할 수도 있습니다.

'필수 조건 (requirements)' 에 `guard` 문을 사용하면, `if` 문으로 같은 검사를 할 때와 비교해서, 코드의 가독성이 좋아집니다. 일반적으로 실행되는 코드는 `else` 블럭을 쓰지 않고도 작성할 수 있으며, 해당 필수 조건과 이 조건을 위반했을 때 이를 처리할 코드를 나란히 배치할 수 있습니다.

### Checking API Availability (API 사용 가능성 검사하기)

스위프트는 API 사용 가능성을 검사하는 기능을 내장하고 있어서, 주어진 배포 대상에서 사용할 수 없는 API 를 우연히 사용하는 일이 없게 보장해 줍니다.

컴파일러는 SDK 에 있는 사용 가능성 정보를 사용하여 코드에서 사용한 모든 API 가 프로젝트에서 지정한 배포 대상에서 사용 가능한 지를 검증합니다. 사용할 수 없는 API 를 사용하려고 하면 스위프트가 컴파일 시간에 에러를 보고합니다.

`if` 나 `guard` 문에서 _사용 가능성 조건 (availability condition)_ 을 사용하면, 사용하려는 API 가 실행 시간에 사용 가능한 것인지에 따라, 코드 블럭을 조건부로 실행할 수 있습니다. 컴파일러는 해당 코드 블럭의 API 가 사용 가능한 지 검증할 때 '사용 가능성 조건 (availability condition)' 에 있는 정보를 사용합니다.

```swift
if #available(iOS 10, macOS 10.12, *) {
  // iOS 에서는 iOS 10 API 를 사용하고, macOS 에서는 macOS 10.12 API 를 사용합니다.
} else {
  // 이전 버전의 iOS 와 macOS API 를 사용합니다.
}
```

위의 '사용 가능성 조건' 은 iOS 의 경우, iOS 10 이상에서만 `if` 문의 본문을 실행하도록 지정하고; macOS 의 경우, macOS 10.12 이상에서만 실행하도록 지정합니다. 마지막 인자인, `*` 는 필수이며, 자신의 대상으로 지정한 `if` 본문이 실행되는 최소한의 배포 대상, 을 지정하는 것입니다.

일반적인 양식의, '사용 가능성 조건' 은 '플랫폼 이름과 버전 (platform names and versions)' 목록으로 되어 있습니다. 플랫폼 이름으로는 `iOS`, `macOS`, `watchOS`, 그리고 `tvOS` 등을 사용하며-전체 목록은, [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 을 참고하기 바랍니다. iOS 8 이나 macOS 10.10 과 같이 '주요 버전 번호 (major version numbers)' 를 지정하는 것 외에도, iOS 11.2.6 과 macOS 10.13.3 과 같이 '부가 버전 번호' 도 지정할 수 있습니다.

```swift
if #available(`platform name` `version`, `...`, *) {
    `statements to execute if the APIs are available`
} else {
    `fallback statements to execute if the APIs are unavailable`
}
```

### 참고 자료

[^Control-Flow]: 이 글에 대한 원문은 [Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^snakes-and-ladders]: '뱀과 사다리 (Snakes and Ladders)' 는 인도에서 유래하여 영국에서 만들어진 보드 게임이라고 합니다. 'Chutes and Ladders (미끄럼틀과 사다리)' 라는 이름은 이 게임을 미국 회사에서 다시 만들게 되면서 유래한 것 같습니다. 더 자세한 정보는 위키피디아의 [Snakes and Ladders](https://en.wikipedia.org/wiki/Snakes_and_Ladders) 와 [뱀과 사다리](https://ko.wikipedia.org/wiki/뱀과_사다리) 항목을 참고하기 바랍니다.

[^do-while]: 본문에서 `repeat-while` 문이 `do-while` 문과 비슷하다고 표현했는데, 사실 초창기 스위프트는 `repeat-while` 의 이름이 `do-while` 이었습니다. 그러므로 이 둘은 사실상 같은 것이라고 볼 수 있습니다. 이름을 왜 바꿨는지는 잘 모르겠습니다.

[^optional]: 여기서의 '선택 사항 (optional)' 은 스위프트의 '옵셔널 (optional)' 타입 과는 상관 없습니다. 스위프트는 일상 생활에서 쓰는 영어 단어를 키워드로 많이 사용하기 때문에 이런 경우가 종종 있습니다. '옵셔널 타입 (optional type)' 도 '값을 선택적으로 가질 수 있는 타입' 이라는 의미로 'optional' 이라는 영어 단어를 사용하는 것입니다.

[^wildcard-pattern]: 와일드카드 (wildcard)' 는 일종의 '만능 카드' 처럼 상황에 따라 어떤 값도 가질 수 있는 카드를 말합니다. '와일드카드 패턴 (wildcard pattern)' 은 특정하게 고정된 문자열만이 아니라, 조건에 부합하는 모든 문자열을 맞춰보는 '패턴' 이라고 이해할 수 있습니다. 보다 자세한 내용은 위키피디아의 [Pattern matching](https://en.wikipedia.org/wiki/Pattern_matching) 항목 중에서 'wildcard pattern' 에 해당하는 부분을 참고하기 바랍니다.
