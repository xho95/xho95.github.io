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

```swift
while condition {
  statements
}
```

다음 예제는 _뱀과 사다리 (Snakes and Ladders)_[^snakes-and-ladders] 라는 간단한 개임을 플레이합니다. (이 게임을 _Chutes and Ladders_ 라고도 한다고 합니다.)

![snakes and ladders](/assets/Swift/Swift-Programming-Language/Control-Flow-snakes-and-ladders.jpg)

게임의 규칙은 다음과 같습니다:

* 게임 '판 (board)' 에는 25 개의 정사각형이 있는데, 최종 목표는 25 번째 정사각형에 도달하거나 이를 넘어가는 것입니다.
* 참여자가 출발하는 곳은 “0 번째 정사각형 (square zero)” 인데, 이는 보드 가장 왼쪽-밑 모서리 외부에 있는 (가상의) 위치입니다.
* 매 '차례 (turn; 턴)' 마다, 6-면체 주사위를 굴려서 그 수만 큼 정사각형, 위에 점선 화살표로 지시한 수평 경로를 따라, 이동합니다.
* 자기 차례일 때 사다리 밑에 도착하게 되면, 그 사다리를 올라갑니다.
* 자기 차례일 때 뱀의 머리에 도착하, 그 뱀 밑으로 내려옵니다.

게임 판은 `Int` 값의 배열로 표현합니다. 크기는 `finalSquare` 라는 상수를 기반으로 하며, 이는 배열을 초기화하는데도 사용하고 예제 끝에서 승리 조건을 검사할 때도 사용하기도 합니다. 참여자가 시작하는 곳이, "0 번째 정사각형" 이기 때문에, 게임 판은 `25` 개가 아니라, `26` 개의 `Int` 값 0 으로 초기화 됩니다.

```swift
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
```

그 다음 일부 정사각형들에 특정한 값을 설정하여 뱀과 사다리를 나타내도록 합니다. 사다리 받침이 있는 정사각형은 게임 판에서 위로 이동할 수 있도록 양수를 가지는 반면, 뱀의 머리가 있는 정사각형은 게임 판에서 아래로 내려가도록 음수를 가지게 됩니다.

```swift
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
```

정사각형 3 은 정사각형 11 로 올라갈 수 있는 사다리 받침을 가지고 있습니다. 이를 표현하고자, `board[03]` 는 `+08` 라고 두며, 이는 (`3` 과 `11` 의 차이인) 정수 값 `8` 과 같은 것입니다. 값과 구문을 보기 좋게 정렬하기 위해, '단항 양수 연산자 (unary plus operator; `+i`)' 를 '단항 음수 연산자 (unary minus operator; `-`)' 와 같이 사용하였으며 `10` 보다 작은 수치 값은 0 으로 채웠습니다. (문장을 꾸미는 기교는 꼭 필요한 건 아니지만, 코드를 좀 더 깔끔하게 만들게 해 줍니다.)

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

#### Repeat-While (Repeat-While 문)

### Conditional Statements (조건 구문)

#### If (If 문)

#### Switch (Switch 문)

**No Implicit Fallthrough (암시적으로 빠져나가지 않음)**

**Interval Matching (해당 구간 찾기)**

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

[^snakes-and-ladders]: '뱀과 사다리 (Snakes and Ladders)' 는 인도에서 유래하여 영국에서 만들어진 보드 게임이라고 합니다. 'Chutes and Ladders' 라는 이름은 이 게임을 미국 회사에서 다시 만들게 되면서 유래한 것 같습니다. 더 자세한 정보는 위키피디아의 [Snakes and Ladders](https://en.wikipedia.org/wiki/Snakes_and_Ladders) 와 [뱀과 사다리](https://ko.wikipedia.org/wiki/뱀과_사다리) 항목을 참고하기 바랍니다.
