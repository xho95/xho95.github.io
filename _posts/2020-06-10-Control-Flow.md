---
layout: post
comments: true
title:  "Swift 5.7: Control Flow (제어 흐름)"
date:   2020-06-10 10:00:00 +0900
categories: Swift Language Grammar Control-Flow For-In While Switch
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html) 부분[^Control-Flow]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Control Flow (제어 흐름)

스위프트는 다양한 제어 흐름문을 제공합니다. 여기엔 한 임무를 여러 번 수행하는 `while` 반복문; 특정 조건에 기반하여 서로 다른 코드 분기를 실행하는 `if` 와, `guard`, 및 `switch` 문; 그리고 실행 흐름을 또 다른 코드 지점으로 전달하는 `break` 와 `continue` 같은 구문을 포함합니다.

스위프트는 `for`-`in` 반복문도 제공하여 배열과, 딕셔너리, 범위, 문자열, 및 기타 다른 시퀀스[^sequences] 들도 쉽게 반복하도록 합니다.

스위프트의 `switch` 문은 **C**-같은 언어[^C-like] 에 있는 수많은 비슷한 것들보다 더 꽤 강력합니다. case 절은 수많은 서로 다른  패턴들[^patterns] 과 맞춰볼 수 있으며, 이는 구간 맞춤[^interval-matches] 과, 튜플, 및 정해진 타입으로의 변환[^casts] 도 포함합니다. `switch` 문 case 에 맞는 값은 임시 상수나 변수로 연결되어 case 본문 안에서 사용할 수도 있고, 각각의 case 에서 `where` 절로 복잡한 맞춤 조건을 표현할 수도 있습니다.

### For-In Loops (for-in 반복문)

`for`-`in` 반복문을 사용하여, 배열 항목이나, 수치 범위, 또는 문자열의 문자 같은, 시퀀스[^sequences] 를 반복합니다.

다음 예제는 `for`-`in` 반복문으로 배열 안의 항목을 반복합니다:

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

딕셔너리를 반복하여 그것의 키-값 쌍[^key-value-pairs] 에 접근할 수도 있습니다. 딕셔너리를 반복할 땐 딕셔너리 각각의 항목을 `(key, value)` 튜플로 반환하며, `(key, value)` 튜플의 멤버를 이름이 명시된 상수로 분해하여 `for`-`in` 반복문 본문 안에서 사용할 수도 있습니다. 아래 예제 코드는, 딕셔너리 키를 `animalName` 이라는 상수로 분해하고, 딕셔너리 값은 `legCount` 라는 상수로 분해합니다.

```swift
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
  print("\(animalName)s have \(legCount) legs")
}
// cats have 4 legs
// ants have 6 legs
// spiders have 8 legs
```

`Dictionary` 의 내용물은 날 때부터 순서가 없으며[^dictionary-contents], 이를 반복하는 건 가져올 순서를 보증하지 않습니다.[^not-guarantee-the-order] 특히, `Dictionary` 에 항목을 집어 넣는 순서가 반복할 순서를 정하는 것도 아닙니다. 배열과 딕셔너리에 대한 더 많은 건, [Collection Types (집합체 타입)]({% post_url 2016-06-06-Collection-Types %}) 을 보기 바랍니다.

`for`-`in` 반복문을 수치 범위에 사용할 수도 있습니다. 다음 예제는 구구단 5-단의 첫 몇몇 요소를 인쇄합니다:

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

반복할 시퀀스는 `1` 부터 `5` 까지의 수치 범위로, 끝을 포함 (inclusive)[^inclusive] 하도록, 닫힌 범위 연산자 (`...`) 를 사용하여 지시합니다. `index` 값을 범위의 첫 번째 수 (`1`) 로 설정하고, 반복문 안의 구문을 실행합니다. 이 경우, 반복문엔 하나의 구문만 담겨 있는데, 이는 구구단 5-단의 현재 `index` 값에 있는 요소를 인쇄합니다. 구문을 실행 후에, `index` 값을 업데이트하여 범위의 두 번째 값 (`2`) 을 담고, 다시 `print(_:separator:terminator:)` 함수를 호출합니다. 범위의 끝에 닿을 때까지 이 과정을 계속합니다.

위 예제에서, `index` 는 반복문의 매 회차 [^iteration] 시작 시에 자동으로 값이 설정되는 상수입니다. 그로 인해, `index` 를 사용 전에 선언하지 않아도 됩니다. 단순히 이를 반복문 선언에 포함하면 암시적으로 선언되어, `let` 선언 키워드를 쓸 필요가 없습니다.

시퀀스에서 각각의 값들이 필요한게 아니면, 변수 이름 자리에 밑줄 (`_`) 을 써서 값을 무시할 수 있습니다.

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

위 예제는 한 수치 값을 다른 걸로 거듭 제곱합니다 (이 경우는, `3` 의 `10` 제곱). `1` 이라는 시작 값에 (즉, `3` 의 `0` 제곱에) `3` 을, `1` 로 시작해서 `10` 으로 끝나는 닫힌 범위로, 열 번, 곱합니다. 이 계산에선, 매 반복문을 통과할 때의 개별 횟수 값이 불필요합니다-단순히 올바른 횟수만큼 반복문을 실행하면 되는 코드입니다. 반복 변수 자리에 밑줄 문자 (`_`) 를 쓰면 개별 값을 무시하고 각각의 반복 회차 동안 현재 값으로의 접근을 제공하지 않습니다.

일부 상황에선, 두 끝점을 모두 포함한, 닫힌 범위를 쓰고 싶지 않을 지도 모릅니다. 시계의 모든 분마다 눈금을 그린다고 고려해 봅니다. `0` 분에서 시작하는, `60` 개의 눈금을 그리고 싶습니다. 반-열린 범위 연산자 (`..<`) 를 써서 낮은 경계 값[^lower-bound] 은 포함하되 높은 경계 값[^upper-bound] 은 그러지 않아야 합니다. 범위에 대한 더 많은 건, [Range Operators (범위 연산자)]({% post_url 2016-04-27-Basic-Operators %}#range-operators-범위-연산자) 부분을 보기 바랍니다.

```swift
let minutes = 60
for tickMark in 0..<minutes {
  // 각 분마다 (60 번) 눈금을 그림
}
```

일부 사용자는 자신의 **UI** 에 눈금이 더 적길 원할지 모릅니다. `5` 분마다 눈금이 하나 있는 걸 더 좋아할 수도 있습니다. `stride(from:to:by:)` 함수를 써서 원하지 않는 눈금을 건너뜁니다.

```swift
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
  // 5 분마다 눈금을 그림 (0, 5, 10, 15, ... 45, 50, 55)
}
```

닫힌 범위도 가능한데, `stride(from:through:by:)` 를 대신 사용하면 됩니다:[^stride-to-through]

```swift
let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
  // 3 시간마다 눈금을 그림 (3, 6, 9, 12)
}
```

위 예제는 `for`-`in` 반복문으로 범위와, 배열, 딕셔너리, 및 문자열을 반복합니다. 하지만, 자신만의 클래스 및 집합체 타입을 포함하여, _어떤 (any)_ 집합체든 이 구문으로 반복할 수 있는데, 그 타입이 [Sequence](https://developer.apple.com/documentation/swift/sequence) 프로토콜을 준수하기만 하면 됩니다.

### While Loops (while 반복문)

`while` 반복문은 조건이 `false` 가 될 때까지 구문 집합을 수행합니다. 이런 종류의 반복문은 첫 반복을 시작하기 전에 반복할 횟수를 알 수 없을 때 사용하는게 최고입니다. 스위프트는 두 종류의 `while` 반복문을 제공합니다:

* `whle` 문은 각각의 반복문 통과를 시작할 때 자신의 조건을 평가합니다.
* `repeat`-`while` 문은 각각의 반복문 통과가 끝날 때 자신의 조건을 평가합니다.

#### While (while 문)

`while` 반복문은 단일 조건을 평가하는 것으로 시작합니다. 조건이 `true` 면, 조건이 `false` 가 될 때까지 구문 집합을 되풀이합니다.

`while` 반복문의 일반 형식은 이렇습니다:

&nbsp;&nbsp;&nbsp;&nbsp;while `condition-조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

다음 예제는 (_미끄럼틀과 사다리 (Chutes and Ladders)_ 라고도 하는) 단순한 게임인 _뱀과 사다리 (Snakes and Ladders)_[^snakes-and-ladders] 를 플레이합니다.

![snakes and ladders](/assets/Swift/Swift-Programming-Language/Control-Flow-snakes-and-ladders.jpg)

게임 규칙은 다음과 같습니다:

* 게임판 (board) 엔 25개의 정사각형이 있고, 목표는 25번 정사각형에 착륙하거나 이를 넘는 겁니다.
* 참가자 (player) 가 시작하는 사각형은 “0번 정사각형”[^square-zero] 인데, 이는 게임판 왼쪽-밑 모서리 바로 밖에 있습니다.
* 각각의 차례 (turn) 마다, 6-면 주사위를 굴리고 그 수 만큼 이동하는데, 위에서 점선 화살표로 표시한 수평 경로를 따라갑니다.
* 자기 차례에서 끝난 지점이 사다리 밑이면, 그 사다리를 타고 올라갑니다.
* 자기 차례에서 끝난 지점이 뱀의 머리면, 그 뱀을 따라 내려옵니다.

게임판은 `Int` 값 배열로 나타냅니다. 크기는 `finalSquare` 라는 상수에 기반하며, 이를 써서 배열도 초기화하고 예제 나중에 승리 조건도 검사합니다. 참가자가 게임판 밖인, "0번 정사각형" 에서 시작하기 때문에, `25` 가 아닌, `26` 개의 0 `Int` 값으로 게임판을 초기화합니다. 

```swift
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
```

그런 다음 일부 정사각형엔 뱀과 사다리에서 지정한 값을 더 설정합니다. 사다리의 받침이 있는 정사각형엔 게임판을 올라가도록 양수가 있는 반면, 뱀 머리가 있는 정사각형엔 게임판을 다시 내려가도록 음수가 있습니다.

```swift
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
```

3번 정사각형에 담긴 사다리 밑받침은 11번 정사각형으로 올라가게 합니다. 이를 나타내고자, `board[03]` 은 `+08` 과 같은데, 이는 (`3` 과 `11` 의 차이인) 정수 값 `8` 과 같은 겁니다. 값과 구문이 가지런하게, 단항 양수 연산자 (`+i`) 를 단항 음수 연산자 (`-i`) 와 같이 명시하며 `10` 보다 작은 수는 0 을 덧댔습니다. (엄밀하게 말해서 꾸밀 필요는 없지만, 코드를 더 깔끔하게 합니다.)

```swift
var square = 0
var diceRoll = 0
while square < finalSquare {
  // 주사위를 굴림
  diceRoll += 1
  if diceRoll == 7 { diceRoll = 1 }
  // 굴린 양만큼 이동함
  square += diceRoll
  if square < board.count {
    // 여전히 게임판 위면, 뱀 또는 사다리를 따라 오르내림
    square += board[square]
  }
}
print("Game over!")
```

위 예제는 아주 단순한 방법으로 주사위를 굴립니다. 난수를 발생하는 대신, `diceRoll` 값을 `0` 으로 시작합니다. 각각의 `while` 반복문 통과 시에, `diceRoll` 을 하나씩 증가한 다음 너무 커진 건 아닌지 검사합니다. 이 반환 값이 `7` 과 같을 때마다, 주사위 굴림 값이 너무 커진 거라서 값을 `1` 로 재설정합니다. 결과는 일렬로 나열된 `diceRoll` 값으로 항상 `1`, `2`, `3`, `4`, `5`, `6`, `1`, `2`, 등으로 계속됩니다.

주사위 굴림 후, 참가자는 `diceRoll` 개의 정사각형만큼 앞으로 이동합니다. 주사위 굴림 값이 참가자를 25번 정사각형 너머로 이동시킬 수도 있는데, 이 경우 게임이 끝납니다. 이런 시나리오에 대처하고자, `square` 가 `board` 배열 안의 `count` 속성보다 작은지를 코드가 검사합니다. `square` 가 유효면, `board[square]` 에 저장한 값을 현재 `square` 값에 더하여 사다리든 뱀이든 참가자를 위나 아래로 이동합니다.

> 이 검사를 하지 않으면, `board[square]` 가 `board` 배열 경계 밖에 있는 값에 접근하려고 할 지도 모르는데, 이는 실행 시간 에러를 발생시킬 겁니다.

그런 다음 현재의 `while` 반복문 실행을 끝내고, 반복 조건을 검사하여 반복문을 다시 실행할지 확인합니다. 참가자가 `25`번 정사각형 위로나 그 너머로 이동하면, 반복 조건을 `false` 로 평가하여 게임을 끝냅니다.

이 경우엔 `while` 반복문이 적절한데, `while` 반복문을 시작할 때 게임 길이가 명확하지 않기 때문입니다. 그 대신, 한 특별한 조건을 만족할 때까지 반복문을 실행합니다.

#### Repeat-While (repeat-while 문)

`while` 반복문의 변화 버전인, `repeat`-`while` 반복문은, 반복 조건을 고려하기 _전에 (before)_, 첫 번째로 단 한 번 반복 블럭을 통과합니다. 그런 다음 조건이 `false` 가 될 때까지 반복문을 계속 되풀이합니다.

> 스위프트의 `repeat`-`while` 반복문은 다른 언어의 `do`-`while` 반복문과 유사합니다.[^do-while]

`repeat`-`while` 반복문의 일반 형식은 이렇습니다:

&nbsp;&nbsp;&nbsp;&nbsp;repeat {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;} while `condition-조건`<br />

`while` 반복문 대신 `repeat`-`while` 반복문으로 다시 작성한, _뱀과 사다리 (Snakes and Ladders)_ 예제는 이렇습니다. `finalSquare` 와, `board`, `square`, 및 `diceRoll` 값의 초기화 방식은 `while` 반복문에서와 정확히 똑같습니다.

```swift
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
```

이 버전의 게임에서, 반복문의 _첫 (first)_ 행동은 사다리인지 뱀인지 검사하는 겁니다. 게임판의 사다리 중에 참가자를 곧바로 25번 정사각형으로 가져오는 건 없으므로, 사다리를 올라가는 걸로 게임을 이기는 건 불가능합니다. 따라서, 뱀인지 사다리인지 검사하는게 반복문의 첫 번째 행동이라도 안전합니다.

게임을 시작할 때, 참가자는 “0번 정사각형” 에 있습니다. `board[0]` 는 항상 `0` 과 같고 아무런 효과도 없습니다.[^no-effect]

```swift
repeat {
  // 뱀 또는 사다리를 따라 오르내림
  square += board[square]
  // 주사위를 굴림
  diceRoll += 1
  if diceRoll == 7 { diceRoll = 1 }
  // 굴림 양만큼 이동함
  square += diceRoll
} while square < finalSquare
print("Game over!")
```

뱀인지 사다리인지 검사한 후, 주사위를 굴리고 `diceRoll` 정사각형 만큼 참가자가 앞으로 이동합니다. 그런 다음 현재 반복의 실행을 끝냅니다.

반복 조건 (`while square < finalSquare`) 은 이전과 똑같지만, 이번엔 첫 번째 실행의 반복문 통과가 _끝 (end)_ 날 때까지 평가를 안합니다. 이 게임에선 `repeat`-`while` 반복문 구조가 이전의 `while` 반복문 예제보다 더 적합합니다. 위의 `repeat`-`while` 반복문에선, 항상 반복문의 `while` 조건이 `square` 가 여전히 게임판 위에 있다는 걸 확정한 _바로 뒤에 (immediately after)_ `square += board[square]` 를 실행합니다. 이 동작은 앞서 설명한 `while` 반복문 버전 게임에서 본 배열 경계 검사를 할 필요를 제거합니다.[^array-bounds-check]

### Conditional Statements (조건문)

특정 조건을 기반으로 서로 다른 코드를 실행하는게 종종 유용합니다. 에러가 났을 때 부가적인 코드를 실행하고, 값이 너무 커지거나 작아질 때 메시지를 보여주고 싶을지도 모릅니다. 이렇게 하려면, 자신의 코드 일부를 _조건문 (conditional)_ 으로 만듭니다.

스위프트는 두 가지 방식으로 코드에 조건 분기를 추가합니다: `if` 문과 `switch` 문이 그것입니다. 전형적으로, `if` 문으론 몇몇 결과만 가능한 단순한 조건을 평가합니다. `switch` 문은 여러 순서 조합이 가능한 더 복잡한 조건에 적합하며 실행하기 적절한 코드 분기를 선택하는데 패턴 맞춤[^pattern-matching] 이 도움이 되는 상황에서 유용합니다.

#### If (if 문)

가장 단순한 형식의, `if` 문엔 단 하나의 `if` 조건만 있습니다. 이는 그 조건이 `true` 일 때만 구문 집합을 실행합니다.

```swift
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
}
// "It's very cold. Consider wearing a scarf." 를 인쇄함
```

위 예제는 온도가 화씨 32도[^Fahrenheit-32] 이하 (물의 어는점) 인지를 검사합니다. 그렇다면, 메시지를 인쇄합니다. 그 외 라면, 아무런 메시지도 인쇄하지 않고, `if` 문의 닫는 중괄호 뒤에서 코드 실행을 계속합니다.

`if` 문은, `if` 조건이 `false` 일 때의 상황을 위해, _else 절 (else clause)_ 이라는, 대안 구문 집합을 제공할 수 있습니다. 이 구문은 `else` 키워드로 지시합니다.

```swift
temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
} else {
  print("It's not that cold. Wear a t-shirt.")
}
// "It's not that cold. Wear a t-shirt." 를 인쇄함
```

항상 이 두 분기 중 하나를 실행합니다. 온도가 화씨 40도까지 증가했기 때문에, 더 이상 스카프를 하라고 조언할 만큼 춥진 않아서 `else` 분기를 대신 발생시킵니다.

여러 개의 `if` 문을 사슬처럼 이어서 추가 구절을 고려할 수 있습니다.

```swift
temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
  print("It's really warm. Don't forget to wear sunscreen.")
} else {
  print("It's not that cold. Wear a t-shirt.")
}
// "It's really warm. Don't forget to wear sunscreen." 를 인쇄함
```

여기선, 추가로 `if` 문을 더하여 특별히 더 따뜻한 온도일 때도 응답합니다. 최종 `else` 절은 남아 있어서, 너무 덥지도 춥지도 않은 어떤 온도의 응답이든 인쇄합니다.

하지만, 최종 `else` 절은 옵션[^optional] 이라, 조건 집합을 완료할 필요가 없으면 없어도 됩니다.

```swift
temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
  print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
  print("It's really warm. Don't forget to wear sunscreen.")
}
```

온도가 `if` 나 `else if` 조건을 발생시킬 만큼 너무 춥지도 덥지도 않기 때문에, 아무런 메시지도 인쇄하지 않습니다.

#### Switch (switch 문)

`switch` 문은 하나의 값을 고려하며 이를 가능한 여러 가지 패턴과 맞춰보고 비교합니다. 그런 다음, 첫 번째로 맞는게 성공한 패턴을 기반으로, 적절한 코드 블럭을 실행합니다. `switch` 문은 `if` 문의 대안으로 여러 개일 수도 있는 상태에 대한 응답을 제공합니다.

가장 단순한 형식의, `switch` 문은 하나의 값을 하나 이상의 동일한 타입의 값들과 비교합니다.

&nbsp;&nbsp;&nbsp;&nbsp;switch `some value to consider-고려할 값` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;case `value 1-값 1`:<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`respond to value 1-값 1 의 응답`<br />
&nbsp;&nbsp;&nbsp;&nbsp;case `value 2-값 2`,<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`value 3-값 3`:<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`respond to value 2 or 3-값 2 또는 3 의 응답`<br />
&nbsp;&nbsp;&nbsp;&nbsp;default:<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`otherwise, do something else-그 외 경우, 다른 걸 합니다`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

모든 `switch` 문은 여러 개의 가능한 _case 절 (cases)_ 로 구성되며, 이들 각각은 `case` 키워드로 시작합니다. 정해진 값과 비교하는 것에 더하여, 스위프트는 여러 가지 방식으로 각각의 case 에 더 복잡하게 맞춰볼 패턴도 지정합니다. 이 옵션들은 이 장 나중에 설명합니다.

`if` 문의 본문 같이, 각각의 `case` 는 별도로 실행되는 코드 분기입니다. `switch` 문은 어느 분기를 선택하는게 좋은지 결정합니다. 이 절차를 고려 중인 값의 _전환 (switching)_ 이라고 합니다.

모든 `switch` 문은 반드시 _다 써버려야 (exhaustive)_ 합니다.[^exhaustive] 즉, 고려 중인 타입으로 가능한 모든 값은 반드시 `switch` 문의 한 case 와 맞아야 합니다. 가능한 모든 값에 case 를 제공하는 게 적절치 않다면, 기본 case 를 정의하여 명시 안한 어떤 값이든 다루게 할 수 있습니다. 이 기본 case 는 `default` 키워드로 지시하며, 반드시 항상 마지막에 나타나야 합니다.

다음 예제는 `switch` 문을 써서 `someCharacter` 라는 단일한 소문자를 고려합니다:

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
// "The last letter of the alphabet" 를 인쇄함
```

`switch` 문의 첫 번째 case 와 맞는 건 영어 알파벳 첫 글자[^letter] 인, `a` 이고, 두 번째 case 와 맞는 건 마지막 글자인, `z` 입니다. `switch` 엔, 모든 알파벳 문자만이 아닌, 가능한 모든 문자에 대한 case 가 있어야 하기 때문에, 이 `switch` 문은 `default` case 를 써서 `a` 와 `z` 이외의 모든 문자를 맞춰봅니다. 이걸 제공하면 `switch` 문이 다 써버리는 걸 보장합니다.

**No Implicit Fallthrough (암시적으로 빠져나가지 않음)**

**C** 와 **오브젝티브-C** 의 `switch` 문과 대조하여, 기본적으로 스위프트의 `switch` 문은 각각의 case 밑을 빠져나가 그 다음 걸로 들어가지 않습니다. 그 대신, 명시적 `break` 문의 요구 없이도, 첫 번째로 맞은 `switch` case 를 완료하자마자 곧, 전체 `switch` 문의 실행을 종료합니다. 이는 **C** 의 `switch` 문 보다 더 안전하고 쉽게 쓸 수 있게 하며 실수로 하나 보다 많은 `switch` case 를 실행하는 것도 피해줍니다.

> 스위프트에서 `break` 가 필수는 아니지만, `break` 문을 사용하면 한 특별한 case 와 맞춰봐서 무시할 수도 있고 또는 맞는 case 의 실행이 완료되기 전에 그 case 를 끊고 나올 수 있습니다. 자세한 건, [Break in a Switch Statement (Switch 문의 Break)](#break-in-a-switch-statement-switch-문의-break) 을 보기 바랍니다.

각각의 case 본문엔 _반드시 (must)_ 적어도 하나의 실행문이 담겨 있어야 합니다. 다음 코드처럼 쓰면 무효인데, 첫 번째 case 가 비어 있기 때문입니다:

```swift
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a": // 무효, case 본문이 비었음
case "A":
  print("The letter A")
default:
  print("Not the letter A")
}
// 이는 컴파일-시간 에러를 보고할 겁니다.
```

**C** 의 `switch` 문과 달리, 이 `switch` 문은 `"a"` 및 `"A"` 둘 다와 맞지 않습니다. 그 보다, `case "a":` 에 어떤 실행문도 담겨 있지 않다는 실행-시간 에러를 보고합니다. 이런 접근법은 한 case 에서 다른 곳으로 빠져나가는 사고를 피해주며 의도가 명확한 더 안전한 코드를 만듭니다.

`switch` 문의 단일 case 로 `"a"` 와 `"A"` 둘 다와 맞게 하려면, 두 값을 복합 case 로 조합하며, 값들을 쉼표로 구분합니다.

```swift
let anotherCharacter: Character = "a"
switch anotherCharacter {
case "a", "A":
  print("The letter A")
default:
  print("Not the letter A")
}
// "The letter A" 를 인쇄함
```

읽기 쉽도록, 복합 case 도 여러 줄에 걸쳐 작성할 수 있습니다. 복합 case 에 대한 더 많은 정보는, [Compound Cases (복합 case 절)](#compound-cases-복합-case-절) 을 보기 바랍니다.

> 한 특별한 `switch` case 끝에서 빠져 나가는 걸 명시하려면, [Fallthrough (fallthrough 문)](#fallthrough-fallthrough-문) 에서 설명한, `fallthrough` 키워드를 사용합니다.

**Interval Matching (구간 맞춤)**

`switch` case 절에서 '값이 일정 구간 (interval) 에 포함되는 지를 검사' 할 수 있습니다. 다음 예제는 '수치 구간 (number intervals)' 을 사용하여 어떤 크기의 수든 자연-어로 세는 기능을 제공합니다:

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
// "There are dozens of moons orbiting Saturn." 를 인쇄함
```

위 예제의, `switch` 문은 `approximateCount` 를 평가합니다. 각각의 `case` 절은 해당 값을 하나의 수나 구간과 비교합니다. `approximateCount` 값은 `12` 와 `100` 사이에 있기 때문에, `naturalCount` 에 `"dozens of"` 라는 값을 할당하고, 실행을 `switch` 문 밖으로 옮깁니다.

**Tuples (튜플)**

튜플을 사용하면 동일한 `switch` 문에서 여러 개의 값을 테스트할 수 있습니다. 각각의 튜플 원소를 서로 다른 값 또는 구간과 테스트할 수 있습니다. 대안으로, '밑줄 문자 (`_`) 를 쓰면, 가능한 어떤 값과도 일치' 하게 되는데, 이를 '와일드카드 패턴 (wildcard pattern)'[^wildcard-pattern] 이라고 합니다.

아래 예제는, `(Int, Int)` 라는 단순한 튜플 타입으로 표현한, (x, y) 점을 취하여, 이를 예제 뒤의 그래프에 분류합니다.

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
// "(1, 1) is inside the box" 를 인쇄함
```

![a (x, y) point with tuples](/assets/Swift/Swift-Programming-Language/Control-Flow-tuples.png)

`switch` 문은 '해당 점이 원점 (0, 0) 인지, 빨간색 x-축 위인 지, 주황색 y-축 위인 지, 중심이 원점인 파란색 4x4 상자 안인 지, 아니면 상자 밖인 지' 를 결정합니다.

C 와 달리, 스위프트는 '똑같은 값 또는 값들을 고려하는 여러 개의 `switch` case 절' 을 허용합니다. 사실, 점 (0, 0) 은 이 예제의 '모든 _네 (four)_ case 절' 과 일치할 수 있습니다. 하지만, 여러 개가 일치 가능하면, 항상 첫 번째로 일치한 case 절을 사용합니다. 점 (0, 0) 은 `case (0, 0)` 과 첫 번째로 일치할 것이므로, 일치하는 다른 모든 case 절을 무시할 것입니다.

**Value Bindings (값 연결)**

`switch` case 절은 '일치하는 값 또는 값들에, case 절 본문에서 사용할, 임시 상수나 변수로 이름' 지을 수 있습니다. 이런 동작을 _값 연결 (value binding)_ 이라고 하는데, 이는 case 절 본문 안의 임시 상수나 변수에 값을 연결하기 때문입니다.

아래 예제는, `(Int, Int)` 라는 튜플 타입으로 표현한, (x, y) 점을 취하여, 이를 뒤의 그래프에 분류합니다:

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
// "on the x-axis with an x value of 2" 를 인쇄함
```

![a (x, y) point with value bindings](/assets/Swift/Swift-Programming-Language/Control-Flow-value-bindings.png)

`switch` 문은 해당 점이 빨간색 x-축 위인지, 주황색 y-축 위인지, 아니면 (어느 축도 아닌) 다른 곳인지 결정합니다.

세 `switch` case 절은, `anotherPoint` 에서 튜플 값 하나 또는 둘 다를 임시로 취하는, 자리 표시용 상수 `x` 와 `y` 를 선언합니다. 첫 번째 case 절인, `case (let x, 0)` 는, `y` 값이 `0` 인 어떤 점이든 일치하며 그 점의 `x` 값을 임시 상수 `x` 에 할당합니다. 이와 비슷하게, 두 번째 case 절인, `case (0, let y)` 는, `x` 값이 `0` 인 어떤 점이든 일치하며 그 점의 `y` 값을 임시 상수 `y` 에 할당합니다.

임시 상수의 선언 후엔, 이를 case 절 코드 블럭 안에서 사용할 수 있습니다. 여기선, '점의 범주' 를 인쇄하는데 사용합니다.

이 `switch` 문엔 `default` case 절이 없습니다. 최종 case 절인, `case let (x, y)` 는, '어떤 값이든 일치 가능한 두 개의 자리 표시용 상수를 가진 튜플' 을 선언합니다. `anotherPoint` 는 항상 두 값을 가진 튜플이기 때문에, 이 case 절은 남아 있는 가능한 모든 값과 일치하며, `switch` 문을 다 써버리게 만드는 `default` case 절이 필요 없습니다.

**Where (where 절)**

`switch` case 절에 `where` 절을 사용하면 추가 조건을 검사할 수 있습니다.

아래 예제는 뒤의 그래프에 (x, y) 점을 분류합니다:

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
// "(1, -1) is on the line x == -y" 를 인쇄함
```

![a (x, y) point with where](/assets/Swift/Swift-Programming-Language/Control-Flow-where.png)

`switch` 문은 해당 점이 `x == y` 인 녹색 대각선 위인지, `x == -y` 인 보라색 대각선 위인지, 아니면 어느 쪽도 아닌지 결정합니다.

세 `switch` case 절은, `yetAnotherPoint` 에서 튜플 값 두 개를 임시로 취하는, 자리 표시용 상수 `x` 와 `y` 를 선언합니다. 이 상수는, 동적 필터를 생성하는, `where` 절에서 사용합니다. `switch` case 절은 해당 값의 `where` 절 조건 평가가 `true` 인 경우에만 현재 `point` 값과 일치합니다.

이전 예제 처럼, 최종 case 절은 남아 있는 가능한 모든 값과 일치하므로, `switch` 문을 다 써버리게 만드는 `default` case 절이 필요 없습니다.

<p>
<strong id="compound-cases-복합-case-절">Compound Cases (복합 case 절)</strong>
</p>

'switch 문에서 동일한 본문을 공유하는 여러 개의 case 절' 은 `case` 뒤에 , 각 패턴 사이에 쉼표를 둔, 여러가지 패턴을 작성함으로써 조합할 수 있습니다. 패턴 중 어떤 것이든 일치하면, 그 case 절은 일치하는 것으로 고려합니다. 목록이 길면 패턴을 여러 줄로 작성할 수 있습니다. 예를 들면 다음과 같습니다:

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
// "e is a vowel" 를 인쇄함
```

`switch` 문의 첫 번째 case 절은 영어의 모든 '모음 (vowels) 소문자' 다섯 개와 일치합니다. 이와 비슷하게, 두 번째 case 절은 영어의 '모든 자음 (consonants) 소문자' 와 일치합니다. 최종적으로, `default` case 절은 다른 어떤 문자든 일치합니다.[^default-case-character]

복합 case 절은 '값 연결 (value bindings) 을 포함' 할 수도 있습니다. 복합 case 절의 모든 패턴은 동일한 값 연결 집합을 포함해야 하며, 각각의 연결 (binding) 은 모든 복합 case 절 패턴에서 똑같은 타입의 값을 가져야 합니다. 이는, 복합 case 절의 어느 부분이 일치하든 간에, case 절 본문 코드가 연결 값에 항상 접근할 수 있고 값의 타입이 항상 똑같도록, 보장합니다.

```swift
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
  print("On an axis, \(distance) from the origin")
default:
  print("Not on an axis")
}
// "On an axis, 9 from the origin" 를 인쇄함
```

위 `case` 절은: x-축 상의 점과 일치하는 `(let distance, 0)` 와 y-축 상의 점과 일치하는 `(0, let distance)` 라는 두 개의 패턴을 가집니다. 두 패턴 모두 `distance` 와의 연결을 포함하며 두 패턴 모두에서 `distance` 는 정수입니다-이는 `case` 절 본문 코드가 `distance` 값에 항상 접근할 수 있음을 의미합니다.

### Control Transfer Statements (제어 전달문)

_제어 전달문 (control transfer statements)_ 은, 제어를 코드 한 곳에서 다른 곳으로 전달하여, 코드 실행 순서를 바꿉니다. 스위프트에는 다섯 개의 제어 전달문이 있습니다:

* `continue`
* `break`
* `fallthrough`
* `return`
* `thorw`

`continue`, `break`, 및 `fallthrough` 문은 아래에서 설명합니다. `return` 문은 [Functions (함수)]({% post_url 2020-06-02-Functions %}) 에서, `throw` 문은 [Propagating Errors Using Throwing Functions (던지는 함수로 에러 전파하기)]({% post_url 2020-05-16-Error-Handling %}#propagating-errors-using-throwing-functions-던지는-함수로-에러-전파하기) 에서 설명합니다.

#### Continue (continue 문)

`continue` 문은 반복문에게 '지금 하고 있는 것을 멈추고 반복문을 통과하여 다음 회차 맨 앞에서 다시 시작하라' 고 말합니다. 이는 반복문을 완전히 떠나지 않고도 "현재 반복 회차에서 할 건 다했다" 고 말합니다.

다음 예제는 '수수께끼 구절 (cryptic puzzle phrase) 생성을 위해 소문자 문자열에서 모든 모음과 공백을 제거' 합니다:

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
// "grtmndsthnklk" 를 인쇄함
```

위 코드는 모음이나 공백과 일치할 때마다 `continue` 키워드를 호출하여, 반복문 현재 회차를 곧바로 끝내고 다음 회차 시작으로 곧장 뛰어 넘도록 합니다.

#### Break (break 문)

`break` 문은 곧바로 전체 제어 흐름문 실행을 끝냅니다. `switch` 문이나 반복문 실행을 다른 경우보다 더 일찍 종결하고 싶을 때 `switch` 문이나 반복문 안에 `break` 문을 사용할 수 있습니다.

**Break in a Loop Statement (반복문 안의 break 문)**

반복문 안에서 사용할 땐, `break` 가 반복문 실행을 곧바로 끝내고 제어를 반복문 닫는 중괄호 (`}`) 뒤의 코드로 옮깁니다. 더 이상 반복문의 현재 회차 코드를 실행하지도, 반복문 회차를 시작하지도 않습니다.

<p>
<strong id="break-in-a-switch-statement-switch-문의-break">Break in a Switch Statement (switch 문의 break)</strong>
</p>

`switch` 문 안에서 사용할 땐, `break` 가 `switch` 문 실행을 곧바로 끝내고 제어를 `switch` 문 닫는 중괄호 (`}`) 뒤의 코드로 옮기도록 합니다.

이런 동작을 사용하면 `switch` 문에 있는 하나 이상의 case 절을 일치시켜서 무시할 수 있습니다. 스위프트의 `switch` 문은 다 써버려야 하고 빈 case 절을 허용하지 않기 때문에, 의도를 명시하기 위해선 일부러 case 절을 일치시키고 무시하는 게 필요할 때가 있습니다. 이를 하려면 무시하려는 case 절 전체 본문을 `break` 문으로 작성하면 됩니다. `switch` 문이 해당 case 절과 일치할 때, case 절 안의 `break` 문이 `switch` 문 실행을 곧바로 끝냅니다.

> 주석만 담은 `switch` case 절은 컴파일-시간 에러를 보고합니다. 주석은 구문이 아니며 `switch` case 절을 무시하도록 유발하지 않습니다. `switch` case 절을 무시하려면 항상 `break` 문을 사용합니다.

다음 예제는 `Character` 값에 대한 '전환 (switch)' 으로 네 개 중 어느 언어로 나타낸 숫자인지를 결정합니다. 간결함을 위해, 단일 `switch` case 절에서 여러 개의 값을 다룹니다.

```swift
let numberSymbol: Character = "三"  // 숫자 3 의 중국어 기호
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
// "The integer value of 三 is 3." 를 인쇄함
```

이 예제는 `numberSymbol` 이 라틴어, 아랍어, 중국어, 또는 태국어 기호로 된 `1` 에서 `4` 까지의 숫자인지 결정하기 위해 검사합니다. 일치한 걸 찾으면, `switch` 문 case 절 하나가 `possibleIntegerValue` 라는 옵셔널 `Int?` 변수에 적절한 정수 값을 설정합니다.

`switch` 문 실행을 완료한 후, 예제는 옵셔널 연결 (optional binding) 을 사용하여 값을 찾았는지 결정합니다. `possibleIntegerValue` 변수는 옵셔널 타입인 덕에 `nil` 이라는 암시적인 초기 값을 가지므로, `switch` 문의 처음 네 case 절 중 하나가 `possibleIntegerValue` 에 실제 값을 설정한 경우에만 옵셔널 연결이 성공할 것입니다.

위 예제에서 가능한 모든 `Character` 값을 나열하는 건 현실적이지 않기 때문에, `default` case 절로 일치하지 않은 어떤 문자든 처리합니다. 이 `default` case 절은 어떤 행동도 할 필요가 없으므로, 단일 `break` 문으로 본문을 작성합니다. `default` case 절과 일치하자마자 곧, `break` 문이 `switch` 문 실행을 끝내며, `if let` 문부터 코드 실행을 계속합니다.

#### Fallthrough (fallthrough 문)

스위프트의, `switch` 문은 각각의 case 절 밑을 빠져나가 다음으로 들어가지 않습니다. 즉, 첫 번째로 일치한 case 절을 완료하자마자 전체 `switch` 문 실행을 완료합니다. 이와 대조적으로, C 는 모든 `switch` case 절 끝에 빠져 나가는 걸 막기 위한 명시적인 `break` 문을 집어 넣을 걸 요구합니다. 기본적인 빠져 나감을 피한다는 건 스위프트 `switch` 문이 C 에 있는 것보다 훨씬 더 간결하고 예측 가능하며, 따라서 여러 개의 `switch` case 절을 실수로 실행하는 걸 피하게 해준다는 의미입니다.

C-스타일의 빠져 나감 (fallthrough) 동작이 필요하면, 각각의 경우마다 `fallthrough` 키워드로 이 동작을 직접 선택할 수 있습니다. 아래 예제는 수치 값을 설명하는 문장을 생성하기 위해 `fallthrough` 를 사용합니다.

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
// "The number 5 is a prime number, and also an integer." 를 인쇄함
```

이 예제는 `description` 이라는 새로운 `String` 변수를 선언하고 여기에 초기 값을 할당합니다. 그런 다음 `switch` 문을 사용하여 `integerToDescribe` 값을 고려합니다. `integerToDescribe` 값이 목록에 있는 소수 (prime number) 중 하나면, 수치 값이 소수임을 표기하기 위해, `description` 끝에 문장을 덧붙입니다. 그런 다음 `default` case 절 까지 마저 "빠져 들기 (fall into)" 위해 `fallthrough` 키워드를 사용합니다. `default` case 절은 설명 끝에 부가적인 문장을 추가하고, `switch` 문을 완료합니다.

`integerToDescribe` 값이 목록에 있는 소수가 아닌 한, 첫 번째 `switch` case 절과는 아예 일치하지 않습니다. 지정한 다른 case 절이 없기 때문에, `integerToDescribe` 는 `default` case 절과 일치합니다.

`switch` 문 실행을 종료한 후, `print(_:separator:terminator:)` 함수를 사용하여 수치 값 설명을 인쇄합니다. 이 예제는, 수 `5` 가 소수라고 올바로 식별합니다.

> `fallthrough` 키워드는 빠져 들어 실행할 `switch` case 절 조건을 검사하진 않습니다. `fallthrough` 키워드는, C 표준 `swtich` 문 동작 처럼, 단순히 코드 실행이 그 다음 case 절 (또는 `default` case 절) 블럭으로 직접 이동하도록 합니다.

#### Labeled Statements (이름표 구문)

스위프트에서, 반복문과 조건문을 다른 반복문과 조건문 안에 중첩하면 복잡한 제어 흐름 구조를 생성할 수 있습니다. 하지만, 반복문과 조건문 둘 다 `break` 문을 사용하면 실행이 성급하게 끝날 수 있습니다. 그러므로, `break` 문이 어느 반복문 또는 조건문을 종료할 지 명시하는 게 유용할 때가 있습니다. 이와 비슷하게, 여러 번 중첩된 반복문이 있다면, `continue` 문이 어느 반복문에 영향을 줄 지 명시하는 게 유용할 수 있습니다.

이 목표를 달성하고자, 반복문이나 조건문에 _구문 이름표 (statement label)_ 를 표시할 수 있습니다. 조건문에선, 이름표 구문의 실행을 끝내기 위해 '`break` 문을 가진 구문 이름표' 를 사용할 수 있습니다. 반복문에선, 이름표 구문의 실행을 끝내거나 계속하기 위해 '`break` 또는 `continue` 문을 가진 구문 이름표' 를 사용할 수 있습니다.

이름표 구문은 '구문 도입자 (introducer) 키워드와 동일한 줄에 이름표를 두고, 뒤에 콜론을 붙임' 으로써, 지시합니다. 다음은 `while` 반복문을 위한 이 구문 예제이지만, 원리는 모든 반복문과 `switch` 문에서 똑같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;`label name-이름표 이름`: while `condition-조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

다음 예제는 이 장 앞에 봤던 _뱀과 사다리 (Snakes and Ladders)_ 게임을 '이름표 붙인 `while` 반복문을 가진 `break` 문과 `continue` 문을 사용' 하여 개조한 버전입니다. 단 이번에는, 게임에 부가적인 규칙이 있습니다:

* 승리하려면, 반드시 25번 정사각형에 _정확하게 (exactly)_ 착륙해야 합니다.

특정 주사위 굴림 값이 25번 정사각형을 넘어가게 하면, 반드시 25번 정사각형에 착륙할 정확한 수를 굴릴 때까지 다시 굴려야 합니다.

게임판은 이전과 똑같습니다.

![snakes and ladders](/assets/Swift/Swift-Programming-Language/Control-Flow-snakes-and-ladders.jpg)

`finalSquare`, `board`, `square`, 및 `diceRoll` 값도 이전과 똑같이 초기화합니다:

```swift
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
```

이 버전의 게임은 게임 로직을 구현하기 위해 `while` 반복문과 `switch` 문을 사용합니다. `while` 반복문은 자신이 뱀과 사다리 게임의 주요 게임 반복문임을 지시하도록 `gameLoop` 라는 구문 이름표를 가집니다.

`while` 반복문 조건은, 반드시 정확하게 25번 정사각형에 착륙해야 함을 반영한, `while square != finalSquare` 입니다.

```swift
gameLoop: while square != finalSquare {
  diceRoll += 1
  if diceRoll == 7 { diceRoll = 1 }
  switch square + diceRoll {
  case finalSquare:
    // diceRoll 이 최종 정사각형으로 이동시킬 것이므로, 게임이 끝남
    break gameLoop
  case let newSquare where newSquare > finalSquare:
    // diceRoll 이 최종 정사각형 너머로 이동시킬 것이므로, 다시 굴림
    continue gameLoop
  default:
    // 이는 유효한 이동이므로, 자신의 효과를 찾아냄
    square += diceRoll
    square += board[square]
  }
}
print("Game over!")
```

주사위는 각각의 반복을 시작할 때 굴립니다. 참가자를 곧바로 이동하기 보단, 이동 결과를 고려하여 이동해도 되는지 결정하고자 반복문이 `switch` 문을 사용합니다:

* 주사위 굴림 값이 참가자를 최종 정사각형으로 이동시킬거면, 게임이 끝납니다. `break gameLoop` 문은 `while` 반복문 밖의 첫째 줄 코드로 제어를 옮겨서, 게임을 끝냅니다.
* 주사위 굴림 값이 참가자를 최종 정사각형 _너머로 (beyond)_ 이동시킬거면, 이동은 무효이며 참가자가 주사위를 다시 굴려야 합니다. `continue gameLoop` 문은 현재 `while` 반복 회차를 끝내고 그 다음 반복 회차를 시작합니다.
* 다른 모든 경우의, 주사위 굴림 값은 유효한 이동입니다. 참가자는 `diceRoll` 개의 정사각형만큼 앞으로 이동하며, 게임 로직이 어떤 뱀이든 사다리든 검사합니다. 그러면 반복을 끝내고, 또 다른 차례 (turn) 가 필요한지 정하고자 제어를 `while` 조건으로 반환합니다.

> 위의 `break` 문이 `gameLoop` 이름표를 사용하지 않았으면, `while` 문이 아닌, `switch` 문을 끊고 나왔을 것입니다. `gameLoop` 이름표를 사용하면 어느 제어문을 종료할 지 명확해집니다.
>
> 엄밀하게 말해서 그 다음 반복 회차로 넘어 가려고 `continue gameLoop` 를 호출할 때는 `gameLoop` 이름표를 사용하는 게 반드시 필요한 건 아닙니다. 게임에 반복문은 한 개만 있으며, 따라서 `continue` 문이 어느 반복문에 영향을 줄 지가 모호하지 않습니다. 하지만, `gameLoop` 이름표를 가지고 `continue` 문을 사용하는 건 해가 없습니다. 그럼으로써 `break` 문과 나란히 사용하는 이름표와 일관성이 있으며 게임 로직을 더 명확하게 읽고 이해하도록 돕습니다.

### Early Exit (때 이른 탈출문)

`guard` 문은, `if` 문 같이, 표현식의 불리언 값에 의존하여 구문을 실행합니다. `guard` 문은 `guard` 문 뒤의 코드를 실행하기 위해선 조건이 반드시 참이길 요구하고자 사용합니다. `if` 문과 달리, `guard` 문에는 항상 `else` 절이 있습니다-조건이 참이 아니면 `else` 절 안의 코드를 실행합니다.

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
// "Hello John!" 을 인쇄함
// "I hope the weather is nice near you." 를 인쇄함
greet(person: ["name": "Jane", "location": "Cupertino"])
// "Hello Jane!" 을 인쇄함
// "I hope the weather is nice in Cupertino." 를 인쇄함
```

`guard` 문 조건에 부합하면, `guard` 문 닫는 중괄호 뒤의 코드를 계속 실행합니다. 조건 절에서 옵셔널 연결로 값을 할당한 어떤 변수 또는 상수든 `guard` 문이 있는 코드 블럭 나머지에서 사용 가능합니다.

해당 조건에 부합하지 않으면, `else` 분기 안의 코드를 실행합니다. 해당 분기는 `guard` 문이 있는 코드 블럭을 탈출하기 위해 반드시 제어를 옯겨야 합니다. 이는 `return`, `break`, `continue`,  또는 `throw` 같은 제어 전달문으로 할 수도, 아니면 `fatalError(_:file:line:)` 같은, 반환 안하는 함수나 메소드 호출로 할 수 있습니다.

필수 조건으로 `guard` 문을 사용하는 건, 동일한 검사를 `if` 문으로 하는 것과 비교하여, 코드 가독성을 개선합니다. 이는 실행 코드를 `else` 블럭으로 포장하지 않고도 작성하게 해주며, 위반 조건을 처리하는 코드를 필수 조건과 나란히 유지하도록 해줍니다.

### Checking API Availability (API 사용 가능성 검사)

스위프트는 API 사용 가능성 검사를 내장 지원하는데, 이는 주어진 배포 대상에선 사용 불가능한 API 를 쓰는 사고가 없도록 보장합니다.

컴파일러는 SDK[^SDK] 의 사용 가능성 정보를 써서 코드 안의 모든 API 가 프로젝트에서 지정한 배포 대상에 사용 가능한지 밝혀냅니다.[^availability-information] 사용 불가능한 API 를 쓰려고 하면 컴파일 시간에 스위프트가 에러를 보고합니다.

`if` 문이나 `guard` 문에서 _사용 가능성 조건 (availability condition)_ 을 쓰면, 사용하고 싶은 API 가 실행 시간에 사용 가능한지에 따라, 조건부로 코드 블럭을 실행합니다.[^availability-condition] 컴파일러는 그 코드 블럭 안의 API 가 사용 가능한지 밝혀낼 때 사용 가능성 조건 정보를 사용합니다.

```swift
if #available(iOS 10, macOS 10.12, *) {
  // iOS 면 iOS 10 API 를 사용하고, macOS 면 macOS 10.12 API 를 사용함
} else {
  // 더 앞선 iOS 및 macOS API 로 대체함
}
```

위 사용 가능성 조건이 지정하는 건 iOS 에선, iOS 10 이후에서만; macOS 에선, macOS 10.12 이후에서만 `if` 문 본문을 실행하라는 겁니다. 마지막 인자인, `*` 는, 필수이며, 다른 어떤 플랫폼에서든, 대상이 지정한 최소 배포 대상에서 `if` 본문을 실행하도록, 지정합니다.

자신의 일반 형식에서, 사용 가능성 조건은 플랫폼 이름 및 버전 목록을 취합니다. 플랫폼 이름으론 `iOS` 와, `macOS`, `watchOS`, 및 `tvOS` 같은 걸 사용하며-전체 목록은, [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 을 보기 바랍니다. iOS 8 이나 macOS 10.10 같은 주 버전 번호[^major-version-numbers] 지정에 더하여, iOS 11.2.6 과 macOS 10.13.3 같은 부 버전 번호[^minor-version-numbers] 들도 지정할 수 있습니다.

&nbsp;&nbsp;&nbsp;&nbsp;if #available(`platform name-플랫폼 이름` `version-버전`, `...`, *) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements to execute if the APIs are available-API 가 사용 가능하면 실행할 구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;} else {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`fallback statements to execute if the APIs are unavailable-API 가 사용 불가능하면 실행할 대체 구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

사용 가능성 조건을 `guard` 문에 쓰면, 사용 가능성 조건을 다듬어 그 코드 블럭의 나머지 코드에서 사용합니다.

```swift
@available(macOS 10.12, *)
struct ColorPreference {
  var bestColor = "blue"
}

func chooseBestColor() -> String {
  guard #available(macOS 10.12, *) else {
    return "gray"
  }
  let colors = ColorPreference()
  return colors.bestColor
}
```

위 예제에서, `ColorPreference` 구조체는 **macOS 10.12** 이후를 요구합니다. `chooseBestColor()` 함수는 사용 가능성 guard 문으로 시작합니다. 플랫폼 버전이 `ColorPreference` 를 사용하기에 너무 오래된 거면, 항상 사용 가능한 동작으로 대체합니다. `guard` 문 후엔, **macOS 10.12** 이후를 요구하는 API 를 사용할 수 있습니다.

`#available` 에 더하여, 스위프트는 사용 불가능성 조건으로 정반대로 검사하는 것도 지원합니다.예를 들어, 다음의 두 검사는 똑같은 걸 합니다:

```swift
if #available(iOS 10, *) {
} else {
  // 대체 코드
}

if #unavailable(iOS 10) {
  // 대체 코드
}
```

`#unavailable` 형식을 사용하면 대체 코드만 담은 검사일 때의 코드를 더 읽기 쉽게 해줍니다.

### 다음 장

[Functions (함수) > ]({% post_url 2020-06-02-Functions %})

### 참고 자료

[^Control-Flow]: 이 글에 대한 원문은 [Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html) 에서 확인할 수 있습니다.

[^snakes-and-ladders]: '뱀과 사다리 (Snakes and Ladders)' 는 인도에서 유래하여 영국에서 만들어진 보드 게임이라고 합니다. 'Chutes and Ladders (미끄럼틀과 사다리)' 라는 이름은 이 게임을 미국 회사에서 다시 만들게 되면서 유래한 것 같습니다. 더 자세한 정보는 위키피디아의 [Snakes and Ladders](https://en.wikipedia.org/wiki/Snakes_and_Ladders) 와 [뱀과 사다리](https://ko.wikipedia.org/wiki/뱀과_사다리) 항목을 보도록 합니다.

[^do-while]: 원문에서는 스위프트의 `repeat`-`while` 문이 다른 언어의 `do`-`while` 문과 유사하다고 했지만, 원래 스위프트도 처음에는 `do`-`while` 문을 썼었는데, `repeat`-`while` 문으로 이름이 바뀐 것입니다. 바뀐 이유는 잘 모르겠지만, [Document Revision History (문서를 다듬은 역사)]({% post_url 2020-03-16-Document-Revision-History %}) 에 있는 [2015-09-16](#2015-09-16) 부분의 역사를 보면 대략 '스위프트 2.0' 부터 바뀐 것으로 추정됩니다.

[^optional]: 여기서의 '옵션 (optional)' 은 '옵셔널 타입' 과는 상관이 없습니다.

[^wildcard-pattern]: '와일드카드 (wildcard)' 는 일종의 '만능 카드' 처럼 상황에 따라 어떤 값도 가질 수 있는 카드를 말합니다. '와일드카드 패턴 (wildcard pattern)' 은 특정한 문자열 뿐만 아니라, '조건에 부합하는 모든 문자열을 맞춰보는 패턴' 이라고 이해할 수 있습니다. 보다 자세한 내용은, 위키피디아의 [Pattern matching](https://en.wikipedia.org/wiki/Pattern_matching) 항목에 있는 'wildcard pattern' 부분을 보도록 합니다.

[^sequences]: '시퀀스 (sequence)' 는 수학 용어로는 '수열' 을 의미하는 단어이지만, 자료 구조로는 '같은 타입의 값들이 순차적으로 붙어서 나열된 구조' 를 의미합니다. 본문에 있는 '집합체 (collection)', '리스트 (list)', '시퀀스 (sequence)' 등은 모두 알고리즘에서 사용하는 '자료 구조' 입니다. '시퀀스' 에 대한 더 자세한 정보는, 위키피디아의 [Sequential access](https://en.wikipedia.org/wiki/Sequential_access) 항목과 [순차 접근](https://ko.wikipedia.org/wiki/순차_접근) 항목을 보도록 합니다. 

[^C-like]: 'C-같은 언어 (C-like languages) ' 는 [Basic Operators (기초 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 장에서 언급한 **C-기반 언어** 와 같은 개념으로, 보통 'C-계열 (C-family) 언어' 라고도 합니다. 이는 역사적으로 C 언어의 영향을 받았거나 C 언어에서 파생한 언어들을 말합니다. 위키피디아의 [List of C-family programming languages](https://en.wikipedia.org/wiki/List_of_C-family_programming_languages) 항목에서 이 **C-계열 언어** 목록을 확인할 수 있습니다.

[^dictionary-contents]: 딕셔너리의 내용물 (contents) 은 해시 함수 (hash function) 를 써서 저장하기 때문에, 저장 순서를 알 길이 없습니다. 더 자세한 내용은, [Collection Types (집합체 타입)]({% post_url 2016-06-06-Collection-Types %}) 장의 [Hash Values for Set Types (셋 타입의 해시 값)]({% post_url 2016-06-06-Collection-Types %}#hash-values-for-set-types-셋-타입의-해시-값) 부분과 위키피디아의 [Hash function](https://en.wikipedia.org/wiki/Hash_function) 항목 및 [해시 함수](https://ko.wikipedia.org/wiki/해시_함수) 항목을 참고하기 바랍니다.

[^not-guarantee-the-order]: 반복할 때마다 가져오는 순서가 달라질 수 있다는 의미입니다.

[^stride-to-through]: `stride(from:to:by:)` 는 '반-열린 범위' 를 만들고, `stride(from:through:by:)` 는 '닫힌 범위' 를 만듭니다.

[^square-zero]: 즉, 게임판 밖의 가상의 공간에서부터 시작합니다. 윷놀이에서 말이 대기하고 있는 것과 같습니다.

[^no-effect]: 이는, 게임을 시작할 때는 `square` 가 0 이라, `square < finalSquare` 가 항상 참이라서, 비교를 안해도 아무런 문제가 없다 (즉, 효과가 없다) 는 의미입니다.

[^array-bounds-check]: `square < board.count` 를 검사할 필요가 없다는 의미입니다.

[^Fahrenheit-32]: '화씨 (Fahrenheit) 32도' 는 '섭씨 (Celsius) 0도' 와 같습니다. '화-씨', '섭-씨' 에서의 '씨' 는 '김-씨', '이-씨' 할 때의 '씨 (氏)' 입니다.

[^exhaustive]: '다 써버려야 (exhaustive)' 한다는 건, 뒤에 설명 하듯, `switch` 문으로 전달될 수 있는 모든 값이 적어도 한 `case` 와는 맞아야 한다는 의미입니다. 스위프트 컴파일러는 `switch` 문을 다 써버리지 않으면 컴파일 시간 에러를 띄웁니다.

[^letter]: 원문에서는 'letter' 라는 단어를 사용하는데, 영어에서 'character' 는 표의 문자, 'letter' 는 표음 문자를 의미한다고 합니다. 원문에도 영어 알파벳은 항상 'letter' 를 사용합니다.

[^default-case-character]: 이 예제는 `default` case 절이 있어야, 완전 소진 (exhaustive) 합니다. 왜냐면, `Character` 가 영어 문자가 아닌 다른 유니코드 문자를 가질 수도 있기 때문입니다.

[^SDK]: 'SDK' 는 소프트웨어 개발 키트 (Software development kit) 의 줄임말입니다. 엑스코드 같은 통합 개발 환경 (IDE; Integrated Development Environment) 과는 의미가 조금 다릅니다. 통합 개발 환경은 소프트웨어 개발을 한 곳에서 할 수 있게 환경을 제공하는 프로그램이고, 소프트웨어 개발 키트는 실제 개발에 필요한, 컴파일러와 패키지 등을 포함한, 도구를 말합니다. 이에 대한 더 자세한 정보는 위키피디아의 [Software development kit](https://en.wikipedia.org/wiki/Software_development_kit) 항목과 [소프트웨어 개발 키트](https://ko.wikipedia.org/wiki/소프트웨어_개발_키트) 항목을 참고하기 바랍니다.

[^availability-information]: 여기서 SDK 의 사용 가능성 정보를 쓴다는 건, 예를 들어, 스위프트 4.0 용 SDK 로 스위프트 5.0 기능을 사용할 수 없는 것처럼, 그 SDK 의 정보를 활용하여 API 의 사용 가능성을 검사한다는 의미입니다.

[^availability-condition]: '사용 가능성 조건 (availability condition)' 은 [Statements (구문)]({% post_url 2020-08-20-Statements %}) 에 있는 [Compiler Control Statements (컴파일러 제어문)]({% post_url 2020-08-20-Statements %}#compiler-control-statements-컴파일러-제어문) 과 비슷해 보입니다. 하지만, 컴파일러 제어문은 컴파일 시간에 검사하는 반면, 사용 가능성 조건은 실행 시간에 검사합니다. 이에 대한 더 자세한 내용은, 애플 개발자 포럼의 [Do we need something like ‘#if available’?](https://forums.swift.org/t/do-we-need-something-like-if-available/40349) 항목을 참고하기 바랍니다. 

[^major-version-numbers]: '주 버전 번호 (major version numbers)' 는 의미 구조 상의 버전 번호에서 가장 큰 버전을 의미합니다.

[^minor-version-numbers]: '부 버전 번호 (minor version numbers)' 는 의미 구조 상의 버전 번호에서 두 번째로 큰 버전을 의미합니다.

