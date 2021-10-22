---
layout: post
comments: true
title:  "Swift 5.5: Control Flow (제어 흐름)"
date:   2020-06-10 10:00:00 +0900
categories: Swift Language Grammar Control-Flow For-In While Switch
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html) 부분[^Control-Flow]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Control Flow (제어 흐름)

스위프트는 다양한 제어 흐름문을 제공합니다. 이는 '임무를 여러 번 수행하는 `while` 반복문; 정해진 조건을 기초로 하여 서로 다른 코드 분기를 실행하는 `if`, `guard`, 및 `switch` 문; 그리고 실행 흐름을 코드 다른 곳으로 전달하는 `break` 와 `continue` 같은 구문' 을 포함합니다.

스위프트는 '배열, 딕셔너리, 범위, 문자열, 및 그 외 다른 시퀀스 (sequences)[^sequences] 들을 쉽게 반복하도록 하는 `for`-`in` 반복문' 도 제공합니다.

스위프트의 `switch` 문은 많은 수의 'C-같은 (C-like) 언어[^C-like] 에 있는 것' 보다 더 강력합니다. 'case 절' 은, '구간 맞춤 (interval matches)', 튜플, 및  '특정 타입으로의 타입 변환 (casts)' 을 포함한, 서로 다른 수많은 '패턴 (patterns)' 과 맞춰볼 수 있습니다. `switch` 문의 case 절과 일치한 값은 'case 절 본문 안에서 사용하도록 임시 상수나 변수로 연결' 할 수도 있고, '복잡한 맞춤 (matching) 조건' 은 '각 case 절마다 `where` 절' 로 표현할 수 있습니다.

### For-In Loops (for-in 반복문)

`for`-`in` 반복문은, '배열의 항목, 수치 범위, 또는 문자열의 문자들 같은, 시퀀스 (sequences) 를 반복' 하려고 사용합니다.

다음 예제는 배열 항목에 동작을 반복하려고 `for`-`in` 반복문을 사용합니다:

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

딕셔너리의 '키-값 쌍 (key-value pairs)' 에 접근하려고 이를 반복할 수도 있습니다. 딕셔너리를 반복할 때는 딕셔너리의 각 항목을 `(key, value)` 튜플로 반환하며, `for`-`in` 반복문 본문 안에서 사용하도록 `(key, value)` 튜플 멤버를 '명시적인 이름의 상수로 분해' 할 수 있습니다. 아래 예제 코드에서, 딕셔너리 키는 `animalName` 이라는 상수로 분해하고, 딕셔너리 값은 `legCount` 라는 상수로 분해합니다.

```swift
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
  print("\(animalName)s have \(legCount) legs")
}
// cats have 4 legs
// ants have 6 legs
// spiders have 8 legs
```

`Dictionary` 의 내용물은 태생적으로 순서가 없으며[^dictionary-contents], 반복 시에 이를 가져오는 순서는 보장하지 않습니다. 특히, `Dictionary` 에 항목을 집어 넣는 순서가 반복 순서를 정의하는 것도 아닙니다. 배열과 딕셔너리에 대한 더 많은 내용은, [Collection Types (집합체 타입)]({% post_url 2016-06-06-Collection-Types %}) 장을 참고하기 바랍니다.

`for`-`in` 반복문을 '수치 범위 (numeric ranges)' 와 같이 사용할 수도 있습니다. 다음 예제는 구구단 5-단의 처음 몇 요소를 인쇄합니다:

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

반복할 '시퀀스' 는, '끝을 포함 (inclusive) 하도록, 닫힌 범위 연산자 (`...`) 로 지시한, `1` 에서 `5` 까지의 수치 범위' 입니다. `index` 값을 '범위의 첫 번째 수 (`1`) 로 설정' 하고, 반복문 안의 구문을 실행합니다. 이 경우, 반복문은, 현재 `index` 값의 구구단 5-단 요소를 인쇄하는, 하나의 구문만 담고 있습니다. 구문을 실행한 후, 범위의 두 번째 값 (`2`) 을 담도록 `index` 값을 갱신하며, `print(_:separator:terminator:)` 함수를 다시 호출합니다. 이 과정을 범위 끝에 닿을 때까지 계속합니다.

위 예제에서, `index` 는 '각각의 반복문 회차 (iteration) 시작 시에 자동으로 값을 설정하는 상수' 입니다. 그로 인해, `index` 를 사용 이전에 선언하지 않아도 됩니다. `let` 선언 키워드를 사용할 필요 없이, 단순히 반복문 선언에 포함하기만 하면, 암시적으로 선언됩니다.

'시퀀스' 에서 각각의 값이 필요하진 않는 경우, 변수 이름 자리에 '밑줄 (`_`) 을 사용' 하여 그 값을 무시할 수 있습니다.

```swift
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
  answer *= base
}
print("\(base) to the power of \(power) is \(answer)")
// "3 to the power of 10 is 59049" 를 인쇄함
```

위 예제는 수치 값 하나를 다른 수로 거듭 제곱 (이 경우는, `3` 을 `10` 제곱) 합니다. 이는, `1` 에서 시작해서 `10` 으로 끝나는 닫힌 범위를 써서, `1` 이라는 시작 값 (즉, `3` 의 `0` 제곱) 에 `3` 을, 열 번, 곱합니다. 이 계산에서는, 매 반복문 통과 시의 개별 횟수 값은 불필요합니다-단순히 올바른 횟수만큼 반복문을 실행하는 코드입니다. 반복 변수 자리에 밑줄 문자 (`_`) 를 사용하면 개별 값을 무시하도록 하며 각 반복 회차 동안 현재 값의 접근을 제공하지 않습니다.

일부 상황에서는, 두 끝점을 포함한, 닫힌 범위를 사용하지 않길 원할 지 모릅니다. 시계 면의 모든 분마다 눈금을 그리는 걸 고려해 봅시다. `0` 분에서 시작해서, `60` 개의 눈금을 그리고자 합니다. '낮은 경계 (lower bound) 값은 포함하지만 높은 경계 (upper bound) 값은 빼기' 위해 반-열린 범위 연산자 (`..<`) 를 사용합니다. '범위 (ranges)' 에 대한 더 많은 내용은, [Range Operators (범위 연산자)]({% post_url 2016-04-27-Basic-Operators %}#range-operators-범위-연산자) 부분을 참고하기 바랍니다.

```swift
let minutes = 60
for tickMark in 0..<minutes {
  // 매 분마다 눈금을 그림 (60 번) 
}
```

일부 사용자는 자신의 UI 에 눈금이 더 적은 걸 원할 지 모릅니다. `5` 분마다 눈금 하나가 있는 걸 더 좋아할 수도 있을 겁니다. 원하지 않는 눈금을 건너뛰려면 `stride(from:to:by:)` 함수를 사용합니다.

```swift
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
  // 5 분마다 눈금을 그림 (0, 5, 10, 15, ... 45, 50, 55)
}
```

`stride(from:through:by:)` 를 대신 사용하면, 닫힌 범위도 가능합니다:[^stride-to-through]

```swift
let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
  // 3 시간마다 눈금을 그림 (3, 6, 9, 12)
}
```

위 예제는 범위, 배열, 딕셔너리, 및 문자열 반복을 위해 `for`-`in` 반복문을 사용합니다. 하지만, 타입이 [Sequence](https://developer.apple.com/documentation/swift/sequence) 프로토콜을 준수하는 한, 자신만의 클래스와 집합체 타입을 포함한, _어떤 (any)_ 집합체든 이 구문으로 반복할 수 있습니다.

### While Loops (while 반복문)

`while` 반복문은 '조건이 `false` 가 될 때까지 일련의 구문 집합을 수행합니다. 이런 종류의 반복문은 '첫 번째 회차의 시작 전에 반복 횟수를 알 수 없을 때 사용하는 것' 이 최고입니다. 스위프트는 두 종류의 `while` 반복문을 제공합니다:

* `whle` 문은 반복문 통과를 시작할 때마다 조건을 평가합니다.
* `repeat`-`while` 문은 반복문 통과가 끝날 때마다 조건을 평가합니다.

#### While (while 문)

`while` 반복문은 단일 조건을 평가함으로써 시작합니다. 조건이 `true` 면, 조건이 `false` 가 될 때까지 일련의 구문 집합을 반복합니다.

다음은 `while` 반복문의 일반 형식입니다:

&nbsp;&nbsp;&nbsp;&nbsp;while `condition-조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

다음 예제는 (_미끄럼틀과 사다리 (Chutes and Ladders)_ 라고도 하는) _뱀과 사다리 (Snakes and Ladders)_[^snakes-and-ladders] 라는 간단한 게임을 합니다.

![snakes and ladders](/assets/Swift/Swift-Programming-Language/Control-Flow-snakes-and-ladders.jpg)

게임 규칙은 다음과 같습니다:

* '게임판 (board)' 에는 25 개의 정사각형이 있으며, 최종 목표는 '25 번 정사각형 위에 착륙하거나 넘어서는 것' 입니다.
* '참가자 (player)' 의 시작 사각형은, 게임판 가장 왼쪽-밑 모서리 바로 밖에 있는, “0 번 정사각형 (square zero)”[^square-zero] 입니다.
* 매 '차례 (turn)' 마다, 6-면 주사위를 굴리고, 위의 점선 화살표로 표시한 수평 경로를 따라서, 해당 수만큼 사각형을 이동합니다.
* 자기 차례인데 사다리 밑에서 끝나면, 사다리를 타고 올라갑니다.
* 자기 차례인데 뱀 머리에서 끝나면, 뱀을 따라 내려옵니다.

게임판은 `Int` 값 배열로 나타냅니다. 크기는 `finalSquare` 라는 상수에 기초하는데, 이는 배열을 초기화할 때도 그리고 예제 나중에 '승리 조건' 을 검사할 때도 사용합니다. 참가자가, "0 번 정사각형" 이라는, 게임판 밖에서 시작하기 때문에, 게임판은, `25` 가 아닌, `26` 개의 `Int` '0' 으로 초기화됩니다.

```swift
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
```

어떤 정사각형은 그 다음에 뱀과 사다리를 위해 더 지정된 값을 가지도록 설정됩니다. 사다리 받침을 가진 정사각형은 게임 판을 올라가기 위해 양수를 가지는 반면, 뱀 머리를 가진 정사각형은 게임판을 다시 내려가기 위해 음수를 가집니다.

```swift
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
```

'3 번 정사각형' 은 '11 번 정사각형' 으로 올라가도록 하는 사다리 받침을 담고 있습니다. 이를 나타내기 위해, `board[03]` 은 `+08` 인데, 이는 (`3` 과 `11` 의 차이인) 정수 값 `8` 과 '동치 (eqivalent)' 입니다. 값과 구문을 정렬하기 위해, '단항 양수 연산자 (unary plus operator; `+i`)' 를 '단항 음수 연산자 (unary minus operator; `-i`)' 와 같이 사용하였으며 `10` 보다 작은 수는 '0' 으로 채웠습니다. (꾸밈 기술은 엄밀하게 말해서 딱히 필요하진 않지만, 코드를 더 깔끔하게 만듭니다.)

```swift
var square = 0
var diceRoll = 0
while square < finalSquare {
  // 주사위를 굴립니다.
  diceRoll += 1
  if diceRoll == 7 { diceRoll = 1 }
  // 굴림 양만큼 이동합니다.
  square += diceRoll
  if square < board.count {
    // 아직도 게임 판 위라면, 뱀이나 사다리를 따라 오르 내립니다.
    square += board[square]
  }
}
print("Game over!")
```

위 예제는 아주 간단한 주사위 굴림 방식을 사용합니다. '난수 (random number)' 를 발생시키는 대신, `0` 이라는 `diceRoll` 값에서 시작합니다. 매 번 `while` 반복문을 통과할 때마다, `diceRoll` 은 하나씩 증가하며 너무 크진 않은 지를 검사합니다. 이 반환 값이 `7` 일 때마다, '주사위 굴림 (dice roll)' 이 너무 커진 것이므로 `1` 이라는 값으로 재설정됩니다. 결과는 항상 `1`, `2`, `3`, `4`, `5`, `6`, `1`, `2`, 등으로 계속되는 '일련의 `diceRoll` 값' 입니다.

주사위를 굴린 후, 참가자는 `diceRoll` 개의 정사각형 만큼 앞으로 이동합니다. '주사위 굴림' 이 '25 번 정사각형' 너머로 참가자를 이동하도록 할수도 있는데, 이 경우는 게임이 끝납니다. 이런 줄거리에 대처하기 위해, 코드는 `square` 가 `board` 배열의 `count` 속성보다 작은 지를 검사합니다. `square` 가 유효하면, `board[square]` 에 저장된 값을 현재의 `square` 값에 추가하고 사다리냐 뱀이냐에 따라 참가자를 위 아래로 이동시킵니다.

> 이러한 검사를 하지 않으면, `board[square]` 가 `board` 배열 경계 밖의 값에 접근할 수도 있는데, 이는 '실행 시간 에러' 를 일으킬 것입니다.

이제 `while` 반복문의 현재 회차 실행이 끝났으며, 반복문을 다시 실행해야 하는지 확인하기 위해 반복문의 조건을 검사합니다. 참가자가 `25` 번 정사각형 위나 그 너머로 이동했으면, 반복문의 조건은 `false` 로 평가되며 게임이 끝납니다.

`while` 반복문을 시작할 때 게임이 '얼마나 길어질지 (length)' 를 명확히 알 수 없는 상황이므로, 이 경우 `while` 반복문은 적절한 것입니다. 반복문은 특정 조건을 만족할 때까지 실행하기 때문입니다.

#### Repeat-While (repeat-while 문)

'`repeat`-`while` 반복문' 이라는, `while` 반복문의 변화 버전은, 반복문 조건을 고려하기 _전에 (before)_, 먼저 '반복문 블럭' 을 한 번 통과합니다. 그런 다음 조건이 `false` 가 될 때까지 반복문을 계속 되풀이합니다.

> 스위프트의 `repeat`-`while` 반복문은 다른 언어의 `do`-`while` 반복문과 유사한 것입니다.[^do-while]

다음은 `repeat`-`while` 반복문의 일반적인 형식입니다:

repeat {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
} while `condition-조건`<br />

다음은, `while` 반복문 대신 `repeat`-`while` 반복문으로 다시 작성한, _뱀과 사다리 (Snakes and Ladders)_ 예제입니다. `finalSquare`, `board`, `square`, 및 `diceRoll` 값은 `while` 반복문에서와 정확하게 똑같은 방식으로 초기화합니다.

```swift
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
```

이 버전의 게임에서, 반복문의 _처음 (first)_ 행동은 사다리인지 뱀인지 검사하는 것입니다. 게임판의 사다리 중 참가자를 곧바로 '25 번 정사각형' 으로 보내는 것은 없으므로, 사다리를 올라가는 것으로써 게임을 이길 수는 없습니다. 그러므로, 반복문의 처음 행동으로 뱀인지 사다리인지 검사하는 것은 안전합니다.

게임을 시작할 떄, 참가자는 “0 번 정사각형” 에 있습니다. `board[0]` 는 항상 `0` 이며 아무 영향이 없습니다.[^square-zero]

```swift
repeat {
  // 뱀인지 사다리인지에 따라 위 아래로 이동합니다.
  square += board[square]
  // 주사위를 굴립니다.
  diceRoll += 1
  if diceRoll == 7 { diceRoll = 1 }
  // 굴림 양에 따라 이동합니다.
  square += diceRoll
} while square < finalSquare
print("Game over!")
```

코드에서 뱀인지 사다리인지 검사한 후, 주사위를 굴리고 참가자를 `diceRoll` 개의 정사각형 만큼 앞으로 이동합니다. 현재 '회차' 실행은 이러면 끝납니다.

반복문의 조건 (`while square < finalSquare`) 은 이전과 똑같지만, 이번에는 반복문을 통과한 최초 실행이 _끝 (end)_ 나기 전에는 이를 평가하지 않습니다. `repeat`-`while` 반복문 구조는 이전 예제의 `while` 반복문 보다 이 게임에 더 적합합니다. 위의 `repeat`-`while` 반복문에서는, `square += board[square]` 이 항상 반복문의 `while` 조건이 `square` 가 아직 게임판 위임을 확정한 _후 그 즉시 (immediately after)_ 실행됩니다. 이런 작동 방식은 앞서 설명한 `while` 반복문 버전 게임에서 본 '배열 경계 값 검사' 의 필요성을 없앱니다.

### Conditional Statements (조건문)

정해진 조건에 따라 서로 다른 코드 부분을 실행하는 것이 유용할 때가 종종 있습니다. 에러가 발생할 때 부가적인 코드 부분을 실행하고 싶을 수도, 값이 너무 커지거나 작아지면 메시지를 보여주고 싶을 수도 있습니다. 이렇게 하기 위해, 코드 일부를 _조건문 (conditional)_ 으로 만듭니다.

스위프트는 조건 분기를 코드에 추가하는 방법을 두 가지로 제공합니다: `if` 문과 `switch` 문입니다. 전형적으로, `if` 문은 적은 결과만이 가능한 간단한 조건을 평가할 때 사용합니다. `switch` 문은 가능한 순서 조합이 여러 개인 좀 더 복잡한 조건에 더 적합하며 '패턴 맞춤 (pattern matching)' 이 실행을 위한 적절한 코드 블럭 선택을 도와줄 수 있는 상황에서 유용합니다.

#### If (if 문)

가장 간단한 형식의, `if` 문은 단일 `if` 조건을 가집니다. 이는 해당 조건이 `true` 일 때만 '일련의 구문 집합' 을 실행합니다.

```swift
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
}
// "It's very cold. Consider wearing a scarf." 를 인쇄합니다.
```

위 예제는 온도가 '화씨 (Fahrenheit)' 로 (물의 어는 점인) 32 도[^Fahrenheit-32] 이하인지 검사합니다. 그렇다면, 메시지를 인쇄합니다. 다른 경우라면, 메시지는 인쇄하지 않고, `if` 문의 '닫는 중괄호 (closing brace)' 뒤에서 코드 실행을 계속합니다.

`if` 문은, `if` 조건이 `false` 인 상황을 위해, `else clause` (else 절) 이라는, 또 다른 구문 집합을 제공할 수 있습니다. 이 구문은 `else` 키워드로 지시합니다.

```swift
temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
} else {
  print("It's not that cold. Wear a t-shirt.")
}
// "It's not that cold. Wear a t-shirt." 를 인쇄합니다.
```

이 두 분기 중 하나는 항상 실행됩니다. 온도가 '화씨 40 도' 까지 증가해서, 스카프를 두르라고 조언할 정도로 춥진 않으므로 `else` 분기가 대신 실행됩니다.

추가적인 절을 고려하기 위해 '다중 `if` 문' 을 서로 '연쇄 (chain)' 할 수 있습니다.

```swift
temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
  print("It's really warm. Don't forget to wear sunscreen.")
} else {
  print("It's not that cold. Wear a t-shirt.")
}
// "It's really warm. Don't forget to wear sunscreen." 를 인쇄합니다.
```

여기서는, 특별히 따뜻한 온도일 때 응답하기 위해 '추가적인 `if` 문' 을 더합니다. '최종 `else` 절' 은 남아서, 너무 덥지도 춥지도 않는 어떤 온도에 대해서든 응답을 인쇄합니다.

하지만, '최종 `else` 절' 은 '선택 사항 (optional)'[^optional] 으로, 조건 집합이 '완전할 (to be complete)' 필요가 없으면 이를 배제할 수 있습니다.

```swift
temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
  print("It's really warm. Don't forget to wear sunscreen.")
}
```

온도가 `if` 나 `else if` 조건을 발동시킬 만큼 너무 춥지도 덥지도 않기 때문에, 아무 메시지도 인쇄하지 않습니다.

#### Switch (switch 문)

`switch` 문은 값을 고려하여 이를 '일치 가능한 여러 패턴 (patterns)' 들과 비교합니다. 그런 다음 성공적으로 일치한 첫 번째 '패턴 (pattern)' 에 기초하여 적절한 코드 블럭을 실행합니다. `switch` 문은 '잠재적인 다중 상태' 에 응답함에 있어서 `if` 문의 대안을 제공합니다.

가장 간단한 형식의, `switch` 문은 하나의 값을 같은 타입의 하나 이상의 값과 비교합니다.

switch `some value to consider-고려할 어떤 값` {<br />
case `value 1-값 1`:<br />
&nbsp;&nbsp;&nbsp;&nbsp;`respond to value 1-값 1 에 대한 응답`<br />
case `value 2-값 2`,<br />
&nbsp;&nbsp;&nbsp;&nbsp;`value 3-값 3`:<br />
&nbsp;&nbsp;&nbsp;&nbsp;`respond to value 2 or 3-값 2 또는 3 에 대한 응답`<br />
default:<br />
&nbsp;&nbsp;&nbsp;&nbsp;`otherwise, do something else-다른 경우라면, 그 외의 어떤 것을 합니다`<br />
}

모든 `switch` 문은 '여러 가능한 _case 절 (cases)_' 로 구성되는데, 이들 각각은 `case` 키워드로 시작합니다. 특정 값을 비교하는 것에 더하여, 스위프트는 '각 case 절이 더 복잡한 맞춤 패턴 (matching patterns) 을 지정하도록 하는 여러가지 방법을 제공합니다. 이 옵션들은 이 장 나중에 설명합니다.

`if` 문의 본문과 같이, 각 `case` 절은 별도의 코드 실행 분기입니다. `switch` 문은 어느 분기를 선택해야할 지 결정합니다. 이런 절차를 고려 중인 값에 대한 _switching (스위칭; 전환)_ 이라고 합니다.

모든 `switch` 문은 반드시 _빠짐없이 철저 (exhaustive)_[^exhaustive] 해야 합니다. 즉, 고려중인 타입의 모든 가능한 값은 '`switch` 문의 case 절' 중 하나와는 반드시 일치해야 합니다. 모든 가능한 값에 대해 'case 절' 을 제공하는 것이 적절하지 않은 경우, 명시적으로 말하지 않은 어떤 값이든 다루도록 '기본 (default) case 절' 을 정의할 수 있습니다. 이 '기본 case 절' 은 `default` 키워드로 지시하며, 반드시 항상 마지막에 있어야 합니다.

다음 예제는 `someCharacter` 라는 '단일 소문자' 를 고려하기 위해 `switch` 문을 사용합니다:

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
// "The last letter of the alphabet" 를 인쇄합니다.
```

`switch` 문의 첫 번째 'case 절' 은 영어 알파벳의 첫 번째 '글자 (letter)'[^letter] 인, `a`, 와 일치하고, 두 번째 'case 절' 은 마지막 글자인, `z`, 와 일치합니다. `switch` 는 반드시, 모든 알파벳 글자에 대해서 만이 아니라, 모든 가능한 글자에 대한 'case 절' 을 가져야 하기 때문에, 이 `switch` 문은 `a` 와 `z` 가 아닌 다른 모든 '문자' 와 일치 여부를 맞춰보기 위해 '`default` case 절' 를 사용합니다. 이런 식의 '대비 (provision)' 는 `switch` 문이 '빠짐없이 철저 (exhaustive)' 하도록 보장합니다.

**No Implicit Fallthrough (암시적으로 빠져나가지 않음)**

C 와 오브젝티브-C 의 `switch` 문과는 대조적으로, 스위프트의 `switch` 문은 기본적으로 각 'case 절' 의 밑을 빠져나가서 그 다음으로 들어가지 않습니다. 그 대신, 전체 `switch` 문은, 명시적인 `break` 문을 쓸 필요없이, 처음으로 일치한 '`switch` case 절' 을 완료하는 순간 바로 실행을 종료합니다. 이는 `switch` 문을 C 에 있는 것보다 더 안전하고 쉽게 사용하게 만들며 실수로 하나 이상의 '`switch` case 절' 을 실행하는 것을 피하도록 해줍니다.

> 스위프트에서 `break` 가 필수는 아니더라도, 특정 'case 절' 과 일치시키거나 무시하기 위해 또는 해당 'case 절' 의 실행을 완료하기 전에 끊고 나오기 위해 `break` 문을 사용할 수 있습니다. 자세한 내용은, [Break in a Switch Statement (Switch 구문 내의 Break 문)](#break-in-a-switch-statement-switch-문-안의-break-문) 을 참고하기 바랍니다.

각 'case 절' 의 본문은 _반드시 (must)_ 최소 하나 이상의 실행문을 담고 있어야 합니다. 코드를 다음 처럼 작성하면 유효하지 않은데, 이는 첫 번째 'case 절' 이 비어있기 때문입니다:

```swift
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a": // 무효, case 절이 빈 본문을 가지고 있습니다.
case "A":
  print("The letter A")
default:
  print("Not the letter A")
}
// 이는 '컴파일-시간 에러' 를 보고할 것입니다.
```

C 의 `switch` 문과는 달리, 이 `switch` 문은 `"a"` 와 `"A"` 둘 모두와 일치하지 않습니다. 그 보다, `case "a":` 가 어떤 실행 가능한 구문도 담고 있지 않다는 실행-시간 에러를 보고합니다. 이런 접근 방식은 한 'case 절' 에서 다른 곳으로 예기치 않게 빠져 나가는 것을 피하며 의도가 명확한 더 안전한 코드를 만들어 줍니다.

`"a"` 와 `"A"` 둘 모두와 일치하는 단일 'case 절' 을 가진 `switch` 문을 만들려면, 두 값을, 쉼표로 구분하여, '복합 (compound) case 절' 로 조합합니다.

```swift
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a", "A":
  print("The letter A")
default:
  print("Not the letter A")
}
// "The letter A" 를 인쇄합니다.
```

가독성을 위해, '복합 case 절' 도 여러 줄에 걸쳐 작성할 수 있습니다. '복합 case 절' 에 대한 더 많은 정보는, [Compound Cases (복합 case 절)](#compound-cases-복합-case-절) 을 참고하기 바랍니다.

> 특정 '`switch` case 절' 의 끝을 명시적으로 빠져 나가려면, [Fallthrough (fallthrough 문)](#fallthrough-fallthrough-문) 에서 설명한 것처럼, `fallthrough` 키워드를 사용합니다.

**Interval Matching (구간 맞춤)**

'`switch` case 절' 의 값은 일정 '구간 (interval)' 안에 포함된 것인지 검사할 수 있습니다. 다음 예제는 어떤 크기의 수도 자연-어로 세는 기능을 제공하기 위해 '수치 구간 (number intervals)' 을 사용합니다:

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
// "There are dozens of moons orbiting Saturn." 를 인쇄합니다.
```

위 예제는, `approximateCount` 가 `switch` 문에서 평가됩니다. 각 '`case` 절' 은 값을 하나의 수 또는 구간과 비교합니다. `approximateCount` 의 값이 `12` 와 `100` 사이에 놓이기 때문에, `naturalCount` 의 값이 `"dozens of"` 로 할당된 다음, 실행이 `switch` 문 외부로 옮겨집니다.

**Tuples (튜플)**

동일한 `switch` 문에서 여러 값을 테스트하기 위해 '튜플' 을 사용할 수 있습니다. 튜플의 각 원소는 서로 다른 값 또는 서로 다른 값인 구간과 테스트할 수 있습니다. 또 다른 방법으로, 가능한 어떤 값과도 일치 여부를 맞춰보려면, '와일드카드 패턴 (wildcard pattern)'[^wildcard-pattern] 이라고도 하는, '밑줄 문자 (`_`)' 를 사용합니다.

아래 예제는, `(Int, Int)` 타입의 간단한 튜플로 표현된, (x, y) 점 하나를 받아서, 이를 예제 뒤의 그래프 상에서 분류합니다.

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
// "(1, 1) is inside the box" 를 인쇄합니다.
```

![a (x, y) point with tuples](/assets/Swift/Swift-Programming-Language/Control-Flow-tuples.png)

`switch` 문은 이 점이 '원점 (0, 0)' 위 인지, 빨간색 x-축 위인지, 주황색 y-축 위인지, 중심이 원점인 파란색 4x4 상자 내부인지, 아니면 상자 외부 인지를 결정합니다.

C 와는 달리, 스위프트는 똑같은 값이나 값들을 고려하는 '다중 `switch` case 절' 을 허용합니다. 사실상, '점 (0, 0)' 은 이 예제의 _네 (four)_ 'case 절' 모두와 일치할 수 있을 것입니다. 하지만, 여러 개가 일치 가능한 경우, 항상 맨 처음 일치한 'case 절' 을 사용합니다. '점 (0, 0)' 은 처음에 `case (0, 0)` 과 일치할 것이므로, 다른 모든 일치하는 'case 절' 을 무시할 것입니다.

**Value Bindings (값 연결)**

'`switch` case 절' 은 일치하는 값 또는 값들을, 'case 절' 의 본문에서 사용하기 위해, 임시 상수나 변수로 이름을 붙일 수 있습니다. 이 작동 방식을 _값 연결 (value binding)_ 이라고 하는데, 값이 'case 절' 본문 내의 임시 상수나 변수로 연결되기 때문입니다.

아래 예제는, `(Int, Int)` 타입의 튜플로 표현된, (x, y) 점 하나를 받아서, 뒤에 있는 그래프 상에서 분류합니다:

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
// "on the x-axis with an x value of 2" 를 인쇄합니다.
```

![a (x, y) point with value bindings](/assets/Swift/Swift-Programming-Language/Control-Flow-value-bindings.png)

`switch` 문은 이 점이 빨간색 x-축 위인지, 주황색 y-축 위인지, 아니면 (어느 축 위도 아닌) 다른 곳인지를 결정합니다.

세 '`switch` case 절' 은, 임시로 `anotherPoint` 로 부터 하나 또는 두 값 모두의 튜플 값을 취하는, '자리 표시자 (placeholder)' 상수인 `x` 와 `y` 를 선언합니다. 첫 번째 'case 절'[^the-first-case] 인, `case (let x, 0)` 는, `y` 값이 `0` 인 어떤 점과도 일치하며 그 점의 `x` 값을 임시 상수인 `x` 에 할당합니다. 비슷하게, 두 번째 'case 절' 인, `case (0, let y)` 는, `x` 값이 `0` 인 어떤 점과도 일치하며 그 점의 `y` 값을 임시 상수인 `y` 에 할당합니다.

임시 상수를 선언한 후, 이를 'case 절' 의 코드 블럭 내에서 사용할 수 있습니다. 여기서는, 점을 '분류한 것 (categorization)' 을 인쇄하는데 사용합니다.

이 `switch` 문은 '`default` case 절' 을 가지지 않습니다. '최종 case 절' 인, `case let (x, y)` 는, 어떤 값과도 일치할 수 있는 두 '자리 표시자' 상수를 가진 '튜플' 을 선언합니다. `anotherPoint` 가 항상 두 값을 가지는 튜플이라, 이 'case 절' 은 남아 있는 모든 가능한 값과 일치할 수 있기 때문에, `switch` 문을 '빠짐없이 철저하게 (exhaustive)' 만들기 위해 '`default` case 절' 이 필요하진 않습니다.

**Where (where 절)**

'`switch` case 절' 은 추가적인 조건을 검사하기 위해 '`where` 절' 을 사용할 수 있습니다.

아래 예제는 (x, y) 점을 그 뒤의 그래프 상에서 분류합니다:

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
// "(1, -1) is on the line x == -y" 를 인쇄합니다.
```

![a (x, y) point with where](/assets/Swift/Swift-Programming-Language/Control-Flow-where.png)

`switch` 문은 이 점이 `x == y` 인 녹색 대각선 위인지, `x == -y` 인 보라색 대각선 위인지, 아니면 어느 쪽도 아닌지를 결정합니다.

세 '`switch` case 절' 은, 임시로 `yetAnotherPoint` 로 부터 두 개의 튜플 값을 취하는, '자리 표시자 (placeholder)' 상수인 `x` 와 `y` 를 선언합니다. 이 상수들은, '동적 필터 (dynamic filter)' 를 생성하기 위해, `where` 절에서 사용됩니다. '`switch` case 절' 은 `where` 절의 조건이 해당 값에 대해 `true` 로 평가되는 경우에만 현재의 `point` 값과 일치합니다.

이전 예제에서 처럼, '최종 case 절' 은 남아 있는 모든 가능한 값과 일치하므로, `switch` 문을 '빠짐없이 철저하게' 만들기 위해 '`default` case 절' 이 필요하진 않습니다.

<p>
<strong id="compound-cases-복합-case-절">Compound Cases (복합 case 절)</strong>
</p>

switch 문에서 똑같은 본문을 공유하는 '다중 case 절' 은 `case` 뒤에, 각 '패턴 (patterns)' 은 쉼표로 구분하여, 여러 개의 '패턴' 을 작성함으로써 조합할 수 있습니다. '패턴' 중 어떤 것이든 일치하면, 그 'case 절' 이 일치하는 것으로 간주됩니다. '패턴' 들은 목록이 길 경우 여러 줄에 걸쳐 작성할 수 있습니다. 예를 들면 다음과 같습니다:

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
// "e is a vowel" 를 인쇄합니다.
```

`switch` 문의 첫 번째 'case 절' 은 영어에 있는 모든 다섯 개의 소문자 '모음 (vowels)' 과 일치합니다. 이와 비슷하게, 두 번째 'case 절' 은 영어의 모든 소문자 '자음 (consonants)' 과 일치합니다. 최종적으로, '`default` case 절' 은 어떤 다른 문자와도 일치합니다.[^default-case-character]

'복합 case 절' 은 '값 연결 (value bindings)' 를 포함할 수도 있습니다. '복합 case 절' 의 모든 '패턴 (patterns)' 은 똑같은 집합의 '값 연결' 을 포함해야 하며, 각 '연결 (binding)' 은 '복합 case 절' 의 모든 '패턴' 에서 같은 타입의 값만 가져야 합니다. 이는, '복합 case 절' 의 어느 부분이 일치한 것이든 상관없이, 'case 절' 의 본문 코드는 항상 '연결' 한 값에 접근할 수 있으며 그 값은 항상 똑같은 타입을 가짐을 보장합니다.

```swift
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
  print("On an axis, \(distance) from the origin")
default:
  print("Not on an axis")
}
// "On an axis, 9 from the origin" 를 인쇄합니다.
```

위의 '`case` 절' 은 두 개의 '패턴' 을 가지고 있습니다: `(let distance, 0)` 은 x-축 위의 점과 일치하며, `(0, let distance)` 는 y-축 위의 점과 일치합니다. 두 '패턴' 모두 `distance` 에 대한 '연결' 을 포함하며 `distance` 는 두 '패턴' 모두에서 '정수' 입니다-이는 '`case` 절' 의 본문 코드가 항상 `distance` 에 대한 값에 접근할 수 있음을 의미합니다.

### Control Transfer Statements (제어 전달문)

_제어 전달문 (control transfer statements)_ 은, 제어를 한 코드에서 다른 곳으로 전달함으로써, 코드를 실행하는 순서를 바꿉니다. 스위프트는 다섯 개의 '제어 전달문' 을 가집니다:

* `continue`
* `break`
* `fallthrough`
* `return`
* `thorw`

`continue`, `break`, 및 `fallthrough` 문은 아래에서 설명합니다. `return` 문은 [Functions (함수)]({% post_url 2020-06-02-Functions %}) 에서 설명하고, `throw` 문은 [Propagating Errors Using Throwing Functions ('던지는 함수' 로 에러 전파하기)]({% post_url 2020-05-16-Error-Handling %}#propagating-errors-using-throwing-functions-던지는-함수-로-에러-전파하기) 에서 설명합니다.

#### Continue (continue 문)

`continue` 문은 반복문이 지금 하고 있는 것을 멈추고 반복문을 통과하여 다음 '회차 (iteration)' 의 맨 앞에서 다시 시작하라고 말합니다. 이는 반복문을 완전히 떠나지 않은 채 "현재 '반복 회차' 에서 할 건 다했다" 라고 말하는 것입니다.

다음의 예제는 '수수께끼 문장 (cryptic puzzle phrase)' 을 생성하기 위해 소문자 문자열에서 모든 '모음 (vowels)' 과 '공백 (spaces)' 을 삭제합니다.

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
// "grtmndsthnklk" 를 인쇄합니다.
```

위 코드는 '모음' 이나 '공백' 과 일치할 때마다 `continue` 키워드를 호출하여, 반복문의 현재 '회차' 를 즉시 끝내고 다음 '회차' 시작으로 곧장 넘어 가도록 합니다.

#### Break (break 문)

`break` 문은 전체 '제어 흐름문' 의 실행을 즉시 끝냅니다. `break` 문은 `switch` 문이나 반복문의 실행을 다른 경우보다 더 일찍 끝내고 싶을 때 `switch` 문이나 반복문 안에서 사용합니다.

**Break in a Loop Statement (반복문 안의 break 문)**

반복문 안에서 사용할 때, `break` 는 반복문의 실행을 즉시 끝내며 '제어 (control)' 를 반복문의 '닫는 중괄호 (`}`)' 뒤의 코드로 전달합니다. 반복문의 현재 '회차' 에 있는 코드를 더 이상 실행하지도 않고, 반복문의 '회차' 도 더 이상 시작하지 않습니다.

<p>
<strong id="break-in-a-switch-statement-switch-문-안의-break-문">Break in a Switch Statement (switch 문 안의 break 문)</strong>
</p>

`switch` 문 안에서 사용할 때, `break` 는 `switch` 문이 실행을 즉시 끝도록 하며 '제어' 을 `switch` 문의 '닫는 중괄호 (`}`)' 뒤의 코드로 전달하도록 합니다.

이 작동 방식은 `switch` 문의 하나 이상의 'case 절' 과 일치시켜서 무시하기 위해 사용할 수 있습니다. 스위프트의 `switch` 문은 '빠짐없이 철저 (exhaustive)' 해서 빈 'case 절' 을 허용하지 않기 때문에, 의도를 명시적으로 만들기 위해서는 일부러 'case 절' 을 일치시켜서 무시하는 것이 필요할 때가 있습니다. 이를 하려면 무시하고 싶은 'case 절' 의 전체 본문을 `break` 문으로 작성하면 됩니다. 해당 'case 절' 이 `switch` 문과 일치할 때, 'case 절' 안의 `break` 문이 `switch` 문의 실행을 즉시 끝냅니다.

> '주석 (comment)' 만 담고 있는 '`switch` case 절' 은 '컴파일 시간 에러' 라고 보고합니다. '주석' 은 '구문 (statements)' 이 아니며 '`switch` case 절' 이 무시되도록 만들지 않습니다. '`switch` case 절' 를 무시하기 위해서는 항상 `break` 문을 사용합니다.

다음 예제는 `Character` 값을 '전환 (switch)' 하여 네 언어 중 하나의 '수치 기호' 로 표현된 것인지를 결정합니다. 간결함을 위해, '다중 값 (multiple values)' 을 '단일 `switch` case 절' 에서 다룹니다.

```swift
let numberSymbol: Character = "三"  // '3' 이라는 수의 중국어 기호
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
// "The integer value of 三 is 3." 를 인쇄합니다.
```

이 예제는 `numberSymbol` 을 검사하여 `1` 에서 `4` 까지의 라틴어, 아랍어, 중국어, 또는 태국어 기호인지 결정합니다. 일치한 것을 찾으면, `switch` 문의 'case 절' 증 하나가 `possibleIntegerValue` 라는 '옵셔널 `Int?`' 변수에 적절한 정수 값을 설정합니다.

`switch` 문이 실행을 완료한 후, 이 예제는 '옵셔널 연결 (optional binding)' 을 사용하여 값을 찾았는지 결정합니다. `possibleIntegerValue` 변수는 '옵셔널 타입' 인 덕에 `nil` 이라는 '암시적인 초기 값' 을 가지므로, '옵셔널 연결' 은 `switch` 문의 처음 네 'case 절' 중 하나가 `possibleIntegerValue` 에 실제 값을 설정한 경우에만 성공할 것입니다.

위 예제에서 가능한 모든 `Character` 값의 목록은 실용적이지 않기 때문에, 일치하지 않는 문자는 어떤 것이든 '`default` case 절' 이 처리합니다. 이 '`default` case 절' 은 어떤 행동도 할 필요 없으므로, 본문을 '단일 `break` 문' 으로 작성합니다. '`default` case 절' 은 일치하자 마자, `break` 문이 `switch` 문의 실행을 끝내며, 코드 실행은 `if let` 문부터 계속됩니다.

#### Fallthrough (fallthrough 문)

스위프트에서, `switch` 문은 각 'case 절' 의 끝을 빠져 나가서 그 다음으로 넘어가지 않습니다. 즉, 전체 `switch` 문은 첫 째로 일치한 'case 절' 을 완료하자 마자 실행을 완료합니다. 이와는 대조적으로, C 는 빠져 나가는 것을 막기 위해 모든 '`switch` case 절' 끝에 명시적인 `break` 문을 필수로 집어 넣어야 합니다. 기본적인 빠져 나감을 피하는 것은 스위프트의 `switch` 문이 C 에 있는 것보다 훨씬 더 간결하고 예측 가능하며, 따라서 '다중 `switch` case 절' 을 실수로 실행하는 것을 피하게 해준다는 것을 의미합니다.

C-스타일의 '빠져 나감 (fallthrough)' 작동 방식이 필요한 경우, 이 작동 방식은 각 경우마다 `fallthrough` 키워드를 작성함으로써 직접 선택할 수 있습니다. 아래 예제는 수를 설명하는 문장의 생성을 위해 `fallthrough` 를 사용합니다.

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
// "The number 5 is a prime number, and also an integer." 를 인쇄합니다.
```

이 예제는 `description` 이라는 새로운 `String` 변수를 선언하고 초기 값을 할당합니다. 그런 다음 이 함수는 `switch` 문을 사용하여 `integerToDescribe` 의 값을 고려합니다. `integerToDescribe` 의 값이 목록에 있는 '소수 (prime number)' 중 하나라면, 함수는, 이 수가 '소수' 임을 기록하기 위해, `description` 끝에 문장을 덧붙입니다. 그런 다음 '`default` case 절' 에 까지 "빠져 들기 (fall into)" 위해 `fallthrough` 키워드를 사용합니다. '`default` case 절' 은 설명 끝에 약간의 부가적인 문장을 추가한 다음, `switch` 문을 완료합니다.

`integerToDescribe` 의 값이 알고 있는 소수 목록에 있지 않으면, 첫 번째 '`switch` case 절' 과는 전혀 일치하지 않습니다. 지정한 다른 'case 절' 이 없기 때문에, `integerToDescribe` 는 '`default` case 절' 과 일치합니다.

`switch` 문의 실행을 종료한 후, `print(_:separator:terminator:)` 함수가 수의 설명을 인쇄합니다. 이 예제에서, 수 `5` 는 '소수' 라고 올바르게 식별됩니다.

> `fallthrough` 키워드는 '빠져 들어 (fall into)' 실행할 '`switch` case 절' 의 조건은 검사하지 않습니다. `fallthrough` 키워드는 단순히, C 의 표준 `swtich` 문 작동 방식에서 처럼, 코드 실행을 그 다음 'case 절' (또는 '`default` case 절') 의 구문으로 직접 이동 시킵니다.

#### Labeled Statements (이름표 구문)

스위프트는, 복잡한 '제어 흐름 구조' 를 생성하기 위해 반복문과 조건문이 다른 반복문과 조건문을 '중첩 (nest)' 할 수 있습니다. 하지만, 반복문과 조건문은 둘 다 실행을 미리 끝내기 위해 `break` 문을 사용 수 있습니다. 그러므로, `break` 문이 종료하고 싶은 반복문이나 조건문이 어느 것인지 명시하는 것이 유용할 때가 있습니다. 이와 비슷하게, '다중 중첩된 (multiple nested)' 반복문을 가진 경우, `continue` 문이 영향을 미칠 반복문이 어느 것인지 명시하는 것이 유용할 수 있습니다.

이러한 목표를 달성하기 위해, 반복문 또는 조건문에 _구문 이름표 (statement label)_ 를 표시할 수 있습니다. 조건문은, '이름표 구문 (labeled statment)' 의 실행을 끝내기 위해 '구문 이름표' 와 `break` 문을 같이 사용할 수 있습니다. 반복문은, '이름표 구문' 의 실행을 끝내거나 계속하기 위해 '구문 이름표' 와 `break` 또는 `continue` 문을 같이 사용할 수 있습니다.

'이름표 구문' 은 구문의 '도입자 (introducer)' 키워드와 같은 줄에 이름표, 및 그 뒤에 콜론을 붙여서, 지시합니다. 아래는 `while` 반복문에 대한 '구문 표현' 의 한 예제로, 이 원리는 모든 반복문과 `switch` 문에 대해서 동일합니다:

`label name-이름표 이름`: while `condition-조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
}

다음 예제는 `break` 문과 `continue` 문을 '이름표 붙인 `while` 반복문' 과 같이 사용하여 이 장 앞에서 봤던 _뱀과 사다리 (Snakes and Ladders)_ 게임을 개조한 버전입니다. 단 이번에는, 게임이 부가적인 규칙을 가집니다:

* 승리하려면, 반드시 _정확하게 (exactly)_ '25 번 정사각형' 위에 도착해야 합니다.

만약 특정 '주사위 굴림' 이 '25 번 정사각형' 을 넘어서도록 만든다면, 반드시 정확하게 '25 번 정사각형' 위에 도착하기 위한 수를 굴릴 때까지 다시 굴려야 합니다.

게임판은 이전과 똑같습니다.

![snakes and ladders](/assets/Swift/Swift-Programming-Language/Control-Flow-snakes-and-ladders.jpg)

`finalSquare`, `board`,  `square`, 및 `diceRoll` 의 값도 이전과 똑같은 방법으로 초기화합니다:

```swift
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
```

이 버전의 게임은 '게임 로직' 을 구현하기 위해 `while` 반복문과 `switch` 문을 사용합니다. `while` 반복문은 자신이 '뱀과 사다리' 게임의 '주요 게임 반복문' 임을 나타내기 위해 `gameLoop` 라는 '구문 이름표' 를 가지고 있습니다.

`while` 반복문의 조건은, 반드시 정확하게 '25 번 정사각형' 위에 도착해야 함을 반영하는, `while square != finalSquare` 입니다.

```swift
gameLoop: while square != finalSquare {
  diceRoll += 1
  if diceRoll == 7 { diceRoll = 1 }
  switch square + diceRoll {
  case finalSquare:
    // diceRoll 이 최종 정사각형으로 이동시킬 것이므로, 게임이 끝나게 됩니다.
    break gameLoop
  case let newSquare where newSquare > finalSquare:
    // diceRoll 이 최종 정사각형 너머로 이동시킬 것이므로, 다시 굴려야 합니다.
    continue gameLoop
  default:
    // 이는 유효한 이동이므로, 그 영향을 알아 냅니다.
    square += diceRoll
    square += board[square]
  }
}
print("Game over!")
```

각각의 반복을 시작할 때마다 주사위를 굴립니다. 반복문은, 참가자를 곧바로 이동하는 대신, 이동 결과를 고려해서 이동을 허용해도 되는지 결정하기 위해 `switch` 문을 사용합니다.

* 만약 '주사위 굴림 값' 이 참가자를 '최종 정사각형' 위로 이동시킨다면, 게임이 끝납니다. `break gameLoop` 문은 '제어' 를 `while` 반복문 밖의 첫 번째 코드 줄로 옮기며, 여기서 게임을 끝냅니다.
* 만약 '주사위 굴림 값' 이 참가자를 '최종 정사각형' 너머로 이동시킨다면, 이 이동은 무효이며 참가자는 주사위를 다시 굴려야 합니다. `continue gameLoop` 문은 `while` 반복문의 현재 '회차 (iteration)' 을 끝내고 그 다음 반복 '회차' 를 시작합니다.
* 그 외 다른 모든 경우의, '주사위 굴림 값' 은 유효한 이동입니다. 참가자는 `diceRoll` 개의 정사각형 만큼 앞으로 이동하고, '게임 로직' 은 뱀이든 사다리든 어떤 것이 있는지 검사합니다. 그런 다음 반복을 끝내고, 또 다른 '차례 (turn)' 가 필요한지를 결정하기 위해 '제어 (control)' 가 `while` 조건으로 반환됩니다.

> 만약 위의 `break` 문에서 `gameLoop` 라는 이름표를 사용하지 않으면, `while` 문이 아닌, `switch` 문을 끊고 나올 것입니다. `gameLoop` 라는 이름표를 사용하는 것은 종료해야 하는 제어문이 어느 것인지를 명확하게 만듭니다.
>
> 다음 반복문 '회차' 로 넘어 가려고 `continue gameLoop` 를 호출할 때 엄밀히 말해서 `gameLoop` 라는 이름표를 꼭 사용해야 하는 건 아닙니다. 이 게임에는 한 개의 반복문만 있으므로, `continue` 문이 어느 반복문에 영향을 미치는 지가 모호하지 않습니다. 하지만, `continue` 문과 `gameLoop` 이름표를 같이 사용하는 것은 문제가 전혀 없습니다. 이렇게 하는 것은 `break` 문이 이름표를 사용하는 것과 나란하여 일관성이 있으며 게임 로직을 읽고 이해하기 더 명확하게 만들도록 도와둡니다.

### Early Exit (이른 탈출문)

`guard` 문은, `if` 문 같이, 표현식의 '불리언 (Boolean) 값' 에 따라 구문을 실행합니다. `guard` 문은 `guard` 문 이후의 코드를 실행하기 위해서는 반드시 조건이 '참 (true)' 이기를 요구하기 위해 사용합니다. `if` 문과는 다르게, `guard` 문은 항상 `else` 절을 가집니다-`else` 절 안의 코드는 조건이 '참' 이 아닐 경우 실행됩니다.

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
// "Hello John!" 을 인쇄합니다.
// "I hope the weather is nice near you." 를 인쇄합니다.
greet(person: ["name": "Jane", "location": "Cupertino"])
// "Hello Jane!" 을 인쇄합니다.
// "I hope the weather is nice in Cupertino." 를 인쇄합니다.
```

`guard` 문의 조건에 부합하면, `guard` 문의 '닫는 중괄호' 뒤에서 코드 실행을 계속합니다. 조건 절에서 '옵셔널 연결 (optional binding)' 을 사용하여 값을 할당한 어떤 변수나 상수라도 `guard` 문이 있는 코드 블럭의 나머지에서 사용 가능합니다.

해당 조건에 부합하지 않으면, `else` 분기 안의 코드를 실행합니다. 해당 분기는 반드시 `guard` 문이 있는 코드 블럭을 탈출하도록 '제어 (control)' 를 옯겨야 합니다. 이는 `return`, `break`, `continue`,  또는 `throw` 같은 '제어 전달문' 으로 할 수도 있고, 아니면 `fatalError(_:file:line:)` 같은, 반환하지 않는 함수나 메소드를 호출할 수도 있습니다.

'필수 조건 (requirements)'[^requirements] 에 `guard` 문을 사용하는 것은, 같은 검사를 `if` 문으로 하는 것과 비교하여, 코드의 가독성을 향상시킵니다. 이는 전형적인 실행 코드를 '`else` 블럭' 으로 포장하지 않고도 작성하도록 해주며, 필수 조건을 위반했을 때 처리하는 코드를 필수 조건과 나란히 배치할 수 있게 해줍니다.

### Checking API Availability (API 사용 가능성 검사하기)

스위프트는 API 의 사용 가능성을 검사하는 '내장 지원 기능 (built-in support)' 을 가지고 있어서, 예기치 않게 주어진 '배포 대상 (deployment target)' 에서는 사용 불가능한 API 를 사용하진 않도록 보장합니다.

컴파일러는 코드에서 사용한 모든 API 가 프로젝트에서 지정한 '배포 대상' 에서 사용 가능한지 검증하기 위해 SDK[^SDK] 에 있는 '사용 가능성 정보' 를 사용합니다.[^availability-information] 사용 불가능한 API 를 사용하려고 하면 스위프트가 컴파일 시간에 에러를 보고합니다.

_사용 가능성 조건 (availability condition)_[^availability-condition] 은 `if` 문이나 `guard` 문 안에서, 사용하고 싶은 API 가 실행 시간에 사용 가능한지에 따라, 조건부로 코드 블럭을 실행하기 위해 사용합니다. 컴파일러는 해당 코드 블럭에 있는 API 가 사용 가능한지 검증할 때 '사용 가능성 조건' 의 정보를 사용합니다.

```swift
if #available(iOS 10, macOS 10.12, *) {
  // iOS 에서는 'iOS 10' API 를 사용하고, macOS 에서는 'macOS 10.12' API 를 사용합니다.
} else {
  // 뒤로 물러나서 이전 iOS 와 macOS API 를 사용합니다.
}
```

위 '사용 가능성 조건' 은 iOS 라면, 'iOS 10' 이후 버전에서만; macOS 라면, 'macOS 10.12' 이후 버전에서만; `if` 문의 본문을 실행하라고 지정합니다. 마지막 인자인, `*` 는, 필수로 대상에서 지정한 것은 '최소 배포 대상' 이며 그 외 어떤 '플랫폼 (platform)' 에서든 `if` 문의 본문을 실행하라고 지정하는 것입니다.

일반적인 형식의, '사용 가능성 조건' 은 '플랫폼 이름과 버전' 목록을 받아 들입니다. 플랫폼 이름은 `iOS`, `macOS`, `watchOS`, 그리고 `tvOS` 같은 것을 사용합니다-전체 목록은, [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 을 참고하기 바랍니다. 'iOS 8' 이나 'macOS 10.10' 같이 '주요 (major) 버전 번호' 를 지정하는 것에 더하여, 'iOS 11.2.6' 및 'macOS 10.13.3' 같은 '보조 (minor) 버전 번호' 도 지정할 수 있습니다.

if #available(`platform name-플랫폼 이름` `version-버전`, `...`, *) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements to execute if the APIs are available-API 가 사용 가능할 때 실행하는 구문`<br />
} else {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`fallback statements to execute if the APIs are unavailable-API 가 사용 불가능할 때 실행하는 구문`<br />
}

### 다음 장

[Functions (함수) > ]({% post_url 2020-06-02-Functions %})

### 참고 자료

[^Control-Flow]: 이 글에 대한 원문은 [Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^snakes-and-ladders]: '뱀과 사다리 (Snakes and Ladders)' 는 인도에서 유래하여 영국에서 만들어진 보드 게임이라고 합니다. 'Chutes and Ladders (미끄럼틀과 사다리)' 라는 이름은 이 게임을 미국 회사에서 다시 만들게 되면서 유래한 것 같습니다. 더 자세한 정보는 위키피디아의 [Snakes and Ladders](https://en.wikipedia.org/wiki/Snakes_and_Ladders) 와 [뱀과 사다리](https://ko.wikipedia.org/wiki/뱀과_사다리) 항목을 참고하기 바랍니다.

[^do-while]: 원문에서는 스위프트의 `repeat`-`while` 문이 다른 언어의 `do`-`while` 문과 유사하다고 했지만, 원래 스위프트도 처음에는 `do`-`while` 문을 썼었는데, `repeat`-`while` 문으로 이름이 바뀐 것입니다. 바뀐 이유는 잘 모르겠지만, [Document Revision History (문서 개정 이력)]({% post_url 2020-03-16-Document-Revision-History %}) 에 있는 [2015-09-16](#2015-09-16) 부분의 이력을 보면 대략 '스위프트 2.0' 부터 바뀐 것으로 추정됩니다.

[^optional]: 여기서의 '선택 사항 (optional)' 은 스위프트의 '옵셔널 (optional)' 타입 과는 상관이 없습니다. 스위프트는 (사실 그 보다는 '애플' 이라는 회사 자체가) 일상 생활에서 쓰는 영어 단어를 키워드로 많이 사용하기 때문에 이런 경우가 종종 있습니다. 사실 거꾸로 말해서 '옵셔널 (optional)' 타입 자체가 '값을 가지는 것이 선택 사항' 이기 때문에 붙은 이름입니다.

[^wildcard-pattern]: 와일드카드 (wildcard)' 는 일종의 '만능 카드' 처럼 상황에 따라 어떤 값도 가질 수 있는 카드를 말합니다. '와일드카드 패턴 (wildcard pattern)' 은 특정하게 고정된 문자열만이 아니라, 조건에 부합하는 모든 문자열을 맞춰보는 '패턴' 이라고 이해할 수 있습니다. 보다 자세한 내용은 위키피디아의 [Pattern matching](https://en.wikipedia.org/wiki/Pattern_matching) 항목 중에서 'wildcard pattern' 에 해당하는 부분을 참고하기 바랍니다.

[^sequences]: '시퀀스 (sequence)' 는 수학 용어로는 '수열' 을 의미하는 단어이지만, 자료 구조로는 '같은 타입의 값들이 순차적으로 붙어서 나열된 구조' 를 의미합니다. 본문에 있는 '집합체 (collection)', '리스트 (list)', '시퀀스 (sequence)' 등은 모두 알고리즘에서 사용하는 '자료 구조' 입니다. '시퀀스' 에 대한 더 자세한 정보는, 위키피디아의 [Sequential access](https://en.wikipedia.org/wiki/Sequential_access) 항목과 [순차 접근](https://ko.wikipedia.org/wiki/순차_접근) 항목을 참고하기 바랍니다. 

[^C-like]: 'C-같은 언어 (C-like languages) ' 는 [Basic Operators (기초 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 장에서 언급한 'C-에 기초한 언어 (C-based languages)' 와 같은 개념으로, 보통 'C-계열 (C-family) 언어' 라고도 합니다. 이는 역사적으로 C 언어의 영향을 받았거나 C 언어에서 파생한 언어들을 이르는 말입니다. 위키피디아의 [List of C-family programming languages](https://en.wikipedia.org/wiki/List_of_C-family_programming_languages) 항목을 보면 이런 'C-계열 언어' 들을 확인할 수 있습니다.

[^dictionary-contents]: 딕셔너리는 '내용물 (contents) 을 저장할 때 해시 함수 (hash function) 를 사용' 하기 때문에, 태생적으로 내용물의 순서를 알 수가 없습니다. 이에 대한 더 자세한 내용은, [Collection Types (집합체 타입)]({% post_url 2016-06-06-Collection-Types %}) 장의 [Hash Values for Set Types (셋 타입을 위한 해시 값)]({% post_url 2016-06-06-Collection-Types %}#hash-values-for-set-types-셋-타입을-위한-해시-값) 부분 또는 위키피디아의 [Hash function](https://en.wikipedia.org/wiki/Hash_function) 항목과 [해시 함수](https://ko.wikipedia.org/wiki/해시_함수) 항목을 참고하기 바랍니다.

[^stride-to-through]: `stride(from:to:by:)` 는 '반-열린 범위' 를 만들고, `stride(from:through:by:)` 는 '닫힌 범위' 를 만듭니다.

[^square-zero]: 게임을 시작할 때 참가자가 '0 번 정사각형' 에 있다는 말은 `square` 가 '0' 이라는 말입니다. 즉, 게임을 시작할 때는 `square < finalSquare` 조건이 항상 참이기 때문에, 이 비교를 하지 않아도 아무런 영향이 없다는 의미입니다.

[^Fahrenheit-32]: '화씨 (Fahrenheit)' 32 도는 '섭씨 (Celsius)' 0 도와 같습니다. '화-씨', '섭-씨' 에서의 '씨' 는 '김-씨', '이-씨' 할 때의 '씨 (氏)' 입니다.

[^exhaustive]: '빠짐없이 철저 (exhaustive)' 하다는 말은 바로 이어지는 문장에서도 설명하고 있듯이, `switch` 문으로 전달된 변수나 상수가 반드시 해당 `switch` 문에 있는 `case` 절에서 다뤄져야 한다는 것을 의미합니다. 스위프트 컴파일러는 `switch` 문이 '빠짐없이 철저' 하지 않으면 컴파일 시간 에러를 띄웁니다.

[^letter]: 엄밀히 말해서, 영어의 'character' 는 '표의 문자', 'letter' 는 '표음 문자' 를 의미한다고 합니다. 원문에서도 영어 알파벳에 대해서는 꾸준히 'letter' 라고 사용하고 있습니다.

[^the-first-case]: 이것도 앞서 설명한 것처럼, 영어의 'case' 가 '경우' 라는 의미이기 때문에, 영어식으로 말하면 '첫 번째 경우' 라는 자연스러운 문장이 됩니다. 프로그래밍 언어들은 대부분 예전부터 영어 문장과 유사했지만 최근의 프로그래밍 언어들은 특히 영어 문장으로써 더 자연스러워지는 추세입니다.

[^default-case-character]: 이 예제는 '`default` case 절' 을 가지고 있어야, '빠짐없이 철저 (exhaustive)' 하게 됩니다. 왜냐면, `Character` 값이 '엉어 문자' 가 아닌 다른 '유니코드 문자' 를 가질 수도 있기 때문입니다.

[^requirements]: 여기서의 '필수 조건 (requirements)' 는 `Protocol` 의 '필수 조건 (requirements)' 과 개념은 비슷하지만 용어 자체로는 다른 것입니다. 이 역시 스위프트가 일상 영어를 많이 사용하면서 일어나는 현상입니다.

[^SDK]: 'SDK' 는 '소프트웨어 개발 키트 (Software development kit)' 의 약자입니다. '엑스코드 (Xcode)' 같은 '통합 개발 환경 (IDE; Integrated Development Environment)' 과는 의미가 조금 다릅니다. '통합 개발 환경' 이 소프트웨어 개발을 한 곳에서 할 수 있게 환경을 제공하는 프로그램이라면, '소프트웨어 개발 키트' 는 개발에 필요한, 컴파일러와 패키지 등을 포함한, 실제 '도구' 들을 말합니다. 이에 대한 더 자세한 정보는 위키피디아의 [Software development kit](https://en.wikipedia.org/wiki/Software_development_kit) 항목 및 [소프트웨어 개발 키트](https://ko.wikipedia.org/wiki/소프트웨어_개발_키트) 항목을 참고하기 바랍니다.

[^availability-information]: 여기서 'SDK 에 있는 사용 가능성 정보를 사용한다' 는 말은, 예를 들어, '스위프트 4.0 용 SDK' 로 '스위프트 5.0' 에 있는 기능을 사용할 수 없는 것 처럼, 해당 SDK 에 있는 정보를 활용하여 API 의 사용 가능성을 검사한다는 의미입니다.

[^availability-condition]: '사용 가능성 조건 (avaailability condition)' 은 [Statements (구문)]({% post_url 2020-08-20-Statements %}) 에 있는 [Compiler Control Statements (컴파일러 제어문)]({% post_url 2020-08-20-Statements %}#compiler-control-statements-컴파일러-제어문) 과 비슷해 보입니다. 하지만, '컴파일러 제어문' 은 컴파일 시간에 동작하는 반면, '사용 가능성 조건' 은 '실행 시간' 에 동작한다는 점에서, 이 둘은 서로 완전히 다른 것입니다.

[^square-zero]: 즉, 게임 보드 밖의 가상의 공간에서부터 시작합니다. 윷놀이에서 말이 대기하고 있는 것과 같습니다.