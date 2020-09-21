---
layout: post
comments: true
title:  "Swift 5.2: Memory Safety (메모리 안전성)"
date:   2020-04-07 10:00:00 +0900
categories: Swift Language Grammar Memory Safety
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Memory Safety](https://docs.swift.org/swift-book/LanguageGuide/MemorySafety.html) 부분[^Memory-Safety]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## Memory Safety (메모리 안전성; 메모리 안전 장치)

기본적으로, 스위프트는 코드에서 안전하지 않은 동작이 발생하는 것을 막아줍니다. 예를 들어, 스위프트에서 변수는 사용 전에 초기화가 되고, 메모리는 해제되고 나면 접근하지 않으며, 배열 색인은 경계를-벗어난 에러가 있는지 검사합니다.

스위프트는 또 동일한 메모리 영역을 여러 곳에서 접근할 경우 서로 '충돌 (conflict)' 이 안되게끔 하는데, 이를 위해 메모리의 특정 위치를 수정하는 코드는 그 메모리에 대한 '독점적인 접근 (exclusive access)' 을 갖도록 합니다. 스위프트는 메모리를 자동으로 관리하기 때문에, 대부분의 경우 메모리 접근에 대해 생각할 필요가 전혀 없습니다. 하지만, 잠재적으로 충돌이 발생할만한 곳을 이해하는 것은 여전히 중요한데, 이는 코드를 작성할 때 애초에 메모리 접근 사이의 충돌을 피할 수 있기 때문입니다. 코드에 충돌이 있으면, '컴파일 시간 에러' 나 '실행 시간 에러' 가 발생하게 됩니다.

### Understanding Conflicting Access to Memory (메모리에 접근할 때의 충돌 이해하기)

'메모리에 대한 접근 (access to memory)' 은 변수의 값을 설정하거나 함수에 인자로 전달하거나 등을 할 때 발생합니다. 예를 들어, 다음의 코드는 '읽기 접근 (read access)' 과 '쓰기 접근 (write access)' 을 모두 가지고 있습니다:

```swift
// one 이 저장될 때 메모리에 대한 '쓰기 접근' 이 발생함
var one = 1

// one 이 저장된 곳의 메모리에 대한 '읽기 접근' 이 발생함
print("We're number \(one)!")
```

메모리 접근의 충돌은 코드의 서로 다른 부분이 같은 위치의 메모리를 동시에 접근하려고 할 때 발생합니다. 동시에 메모리의 특정 위치를 여러 곳에서 접근할 경우 예측할 수 없거나 일관성이 없는 동작을 발생시킬 수 있습니다. 스위프트에는, 코드에서 여러 줄에 걸쳐서 값을 수정하는 방법도 있으므로, 자기가 수정하는 도중에 값에 접근하는 경우도 생길 수 있습니다.

이와 비슷한 문제로 종이에 쓴 예산을 갱신하는 방법을 생각해 볼 수 있습니다. 예산 갱신은 2-단계의 과정을 거칩니다: 첫 번째는 항목의 이름과 가격을 추가하는 것이고, 그 다음은 목록에 있는 항목들의 현재 상태를 반영하도록 총 금액을 바꾸는 것입니다. 갱신 전후에 걸쳐, 예산에 대한 어떤 정보라도 읽을 수 있고 정확한 답도 구할 수 있는데, 이는 아래에 그림으로 나타냈습니다.

![bugdet](/assets/Swift/Swift-Programming-Language/Memory-Safety-budget.jpg)

예산에 항목을 추가하는 동안에는, 일시적으로, 무효 상태가 되는데 이는 총 금액이 새로 추가된 항목을 반영하도록 갱신되지 않았기 때문입니다. 즉 항목을 추가하는 과정에서 총 금액을 읽게 되면 잘못된 정보를 얻게 됩니다.

이 예제는 메모리 접근에 대한 충돌을 고쳐야 할 때 마주치게 될 문제를 보여주고 있기도 합니다: 충돌을 고치는 방법은 여러 가지가 있을 수 있는데 이들은 서로 다른 답을 내놓을 수 있으며, 어떤 답이 올바른지가 항상 명확한 것은 아니라는 것입니다. 이 예제에서는, 원한 것이 원래의 총 금액인지 아니면 갱신된 총 금액인지에 따라, '$5' 든 '$320' 든 둘 다 올바른 답이 될 수 있습니다. 즉 '접근 충돌 (conflicting access)' 문제를 고치기 전에, 목적하는 바가 무엇인지를 결정하는 것이 우선되어야 합니다.

> '동시성 (concurrent)' 코드나 '다중 쓰레드 (multithreaded)' 코드를 작성해 본 적이 있다면, 메모리 충돌은 꽤 익숙한 문제일 것입니다. 하지만, 여기서 논의하는 메모리 충돌은 단일 쓰레드에서도 발생할 수 있으며 동시성 코드나 다중 쓰레드 코드에만 국한된 것은 _아닙니다 (doesn't)_.
>
> 단일 스레드 내에서 메모리 접근이 충돌할 경우, 스위프트는 컴파일 시간이나 실행 시간에 에러가 발생하도록 보장해 줍니다. 다중 쓰레드 코드에서는, [Thread Sanitizer (쓰레드 살균제)](https://developer.apple.com/documentation/code_diagnostics/thread_sanitizer)[^Thread-Sanitizer] 를 사용하면 쓰레드 간에 접근이 충돌하는지 감지할 수 있습니다.

#### Characteristics of Memory Access (메모리 접근의 성질들)

접근이 충돌하는 상황에서 고려해야 할 메모리 접근의 성질에는 세 가지가 있습니다: 그 접근의 읽기 또는 쓰기 여부, 접근의 지속 시간, 메모리에서 접근이 이뤄지는 위치가 그것입니다. 특히, 다음의 조건을 모두 충족하는 접근이 두 개가 되면 충돌이 발생합니다:

* 적어도 하나는 '쓰기 접근 (write access)' 입니다.
* 이들은 메모리의 동일한 위치에 접근합니다.
* 이들의 지속 시간이 겹칩니다.

보통의 경우 읽기 접근과 쓰기 접근의 차이점은 분명히 드러납니다: 쓰기 접근은 메모리 위치를 변경하지만, 읽기 접근은 그렇지 않다는 것입니다. 메모리의 위치는 접근 중인 대상을 참조합니다-예를 들어, 변수, 상수, 또는 속성이 그것입니다. 메모리 접근의 지속 시간은 순간적일 수도 있고 장기적일 수도 있습니다.

연산이 _원자적 (atomic)_ 이라는 것은 C 언어의 '원자적인 연산 (atomic operations)' 만을 사용하는 경우입니다; 다른 경우 '원자적이 아닌 (nonatomic)' 것입니다. 해당 함수의 목록은, `stdatomic(3)` 의 'man' 페이지를 참고하기 바랍니다.[^man-page]

접근이 _순간적 (instantaneous)_ 이라는 것은 해당 접근을 시작하면 끝나기 전에는 다른 코드를 실행하는 것이 가능하지 않는 경우입니다; 본질적으로, 순간적인 접근 두 개가 동시에 일어날 수는 없습니다. 대부분의 메모리 접근은 '순간적' 입니다. 예를 들어, 아래 나열된 코드의 모든 읽기 및 쓰기 접근은 순간적 입니다:

```swift
func oneMore(than number: Int) -> Int {
  return number + 1
}

var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)
// "2" 를 출력합니다.
```

하지만, 메모리에 접근하는 방법에는 여러 가지가 있으며, 그 중 _장기적인 (long-term)_ 접근은, 그 범위가 다른 코드의 실행에 이르기까지 뻗어 있습니다. 단기적인 접근과 장기적인 접근 사이의 차이점은 장기적인 접근의 경우 접근을 시작한 다음에 그것이 끝나기 전이라도 다른 코드를 실행할 수 있다는 것인데, 이를 일컬어 '_겹친다 (overlap)_' 라고 합니다. 장기적인 접근은 다른 장기적인 접근이나 순간적인 접근과 겹쳐질 수 있습니다.

코드에서 '겹치는 접근 (overlapping accesses)' 이 주로 나타나는 때는 함수와 메소드의 '입-출력 매개 변수 (in-out parameters)' 를 사용할 때 또는 구조체의 '변경 메소드 (mutating methods)' 를 사용할 때입니다. 지정된 종류의 스위프트 코드에서 장기적인 접근을 사용하는 방법은 아래의 각각의 문단에서 논의하겠습니다.

### Conflicting Access to In-Out Parameters (입-출력 매개 변수에 접근할 때의 충돌)

함수에 사용되는 모든 '입-출력 매개 변수 (in-out parameters)' 는 장기적인 접근을 합니다. 입-출력 매개 변수에 대한 쓰기 접근은 모든 '비-입-출력 매개 변수 (non-in-out parameters)' 를 계산한 다음에 시작하여 전체 함수 호출 기간 동안 지속됩니다. 입-출력 매개 변수가 여러 개 있을 경우, 매개 변수가 나타나는 순서대로 쓰기 접근을 시작합니다.

이러한 장기적인 쓰기 접근으로 인한 결과 중 하나는, 입-출력으로 전달된 변수의 원본에 접근할 수 없다는 것이 있는데, 이는 다른 때라면 '범위 규칙 (scoping rules)' 과 '접근 제어 (access control)' 에 의해 허용되는 경우더라도 그렇습니다-원본에 대한 어떤 접근도 충돌이 됩니다. 예를 들면 다음과 같습니다:

```swift
var stepSize = 1

func increment(_ number: inout Int) {
  number += stepSize
}

increment(&stepSize)
// 에러: stepSize 에 대한 접근이 충돌함
```

위의 코드에서, `stepSize` 는 전역 변수이며, 일반적으로 `increment(_:)` 내에서 접근 가능합니다. 하지만, `stepSize` 에 대한 읽기 접근은 `number` 에 대한 쓰기 접근과 겹칩니다. 아래 그림에 나타낸 것처럼, `number` 와 `stepSize` 둘 다 메모리에서 같은 위치를 참조합니다. 읽기 접근과 쓰기 접근이 같은 메모리를 참조하면서 겹치는 경우, 충돌을 일으킵니다.

![in-out parameters](/assets/Swift/Swift-Programming-Language/Memory-Safety-inout-conflict.jpg)

이러한 충돌을 해결하는 한 가지 방법은 `stepSize` 에 대한 명시적인 복사본을 만드는 것입니다:

```swift
// 명시적인 복사본을 만듭니다.
var copyOfStepSize = stepSize
increment(&copyOfStepSize)

// 원본을 갱신합니다.
stepSize = copyOfStepSize
// stepSize 는 이제 2 입니다.
```

`increment(_:)` 를 호출하기 전에 `stepSize` 의 복사본을 만들어 두면, `copyOfStepSize` 의 값이 현재의 '스텝 크기 (step size)' 에 의해 증가됨이 분명해집니다. 쓰기 접근이 시작되기 전에 읽기 접근이 끝나므로, 충돌은 없습니다.

입-출력 매개 변수에 대한 장기적인 쓰기 접근의 또다른 결과는 동일한 함수의 여러 개의 입-출력 매개 변수에 대한 인자로 단일한 변수를 전달하면 충돌을 일으킨다는 것입니다. 예를 들면 다음과 같습니다:

```swift
func balance(_ x: inout Int, _ y: inout Int) {
  let sum = x + y
  x = sum / 2
  y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)   // OK, 괜찮습니다.
balance(&playerOneScore, &playerOneScore)   // 에러: playerOneScore 에 대한 접근이 충돌합니다.
```

위의 `balance(_:_:)` 함수는 두 매개 변수의 값을 총 합하여 고르게 나눈 값으로 수정합니다. `playerOneScore` 와 `playerTwoScore` 를 인자로 전달하여 호출하면 충돌이 일어나지 않습니다-두 개의 쓰기 접근은 시간이 겹치긴 하지만, 서로다른 메모리 위치에 접근합니다. 이와는 달리, `playerOneScore` 를 두 매개 변수의 값으로 전달하면 충돌이 일어나게 되며 이는 두 개의 쓰기 접근이 동시에 같은 위치의 메모리에 접근하기 때문입니다.

> 연산자도 함수이기 때문에, 이 역시 입-출력 매개 변수에 대한 장기적인 접근을 하게 됩니다. 예를 들어, `balance(_:_:)` 가 `<^>` 라는 연산자 함수라면, `playerOneScore <^> playerOneScore` 라고 했을 경우 그 결과로 `balance(& playerOneScore, & playerOneScore)` 와 같이 충돌이 발생할 것입니다.

### Conflicting Access to self in Methods (메소드 내에서 self 에 접근할 때의 충돌)

구조체의의 '변경 (mutating)' 메소드는 메소드 호출이 지속되는 동안에 `self` 에 대한 쓰기 접근을 하게 됩니다. 예를 들어, 각각의 참여자마다 피해를 받으면 줄어드는 '체력' 과, 특수한 능력을 사용하면 줄어드는 '에너지' 를 가지고 있는 게임을 생각해 봅시다.

```swift
struct Player {
  var name: String
  var health: Int
  var energy: Int

  static let maxHealth = 10
  mutating func restoreHealth() {
    health = Player.maxHealth
  }
}
```

위의 `restoreHealth()` 메소드에서, `self` 에 대한 쓰기 접근은 메소드의 첫 부분에서 시작하여 메소드가 반환할 때까지 지속됩니다. 이 경우, `restoreHealth()` 안에 있는 코드 중에 `Player` 인스턴스의 속성과 접근이 겹칠 수도 있는 것은 전혀 없습니다. 아래에 있는 `shareHealth(with:)` 메소드는 다른 `Player` 인스턴스를 입-출력 매개 변수로 받으므로, 접근이 겹칠 수 있는 가능성이 생기게 됩니다.

```swift
extension Player {
  mutating func shareHealth(with teammate: inout Player) {
    balance(&teammate.health, &health)
  }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)   // OK. 괜찮습니다.
```

위의 예제에서, 참여자 'Oscar' 의 `shareHealth(with:)` 메소드를 호출해서 체력을 참여자 'Maria' 와 공유해도 충돌은 일어나지 않습니다. 메소드를 호출하는 동안 `oscar` 에 대한 쓰기 접근을 하는데 이는 `oscar` 가 '변경 (mutating) 메소드' 에 있는 `self` 의 값이기 때문인 것으로, 같은 기간 동안 `maria` 에 대해서도 쓰기 접근을 하며 이는 `maria` 가 입-출력 매개 변수로 전달되었기 때문입니다. 아래 그림에서 나타낸 것처럼, 이들은 서로 다른 위치의 메모리에 접근합니다. 이 두 쓰기 접근은 시간이 겹치긴 하지만, 충돌은 하지 않습니다.

![access different locations in memory](/assets/Swift/Swift-Programming-Language/Memory-Safety-self-different-memory.jpg)

하지만, `oscar` 를 `shareHealth(with:)` 의 인자로 전달하면, 이는 충돌입니다:

```swift
oscar.shareHealth(with: &oscar)
// 에러: oscar 에 대한 접근이 충돌합니다.
```

변경 메소드는 메소드의 지속 시간 동안 `self` 에 쓰기 접근을 해야 하고, 입-출력 매개 변수는 같은 시간 동안 `teammate` 에 쓰기 접근을 해야합니다. 메소드 범위 내에서, `self` 와 `teammate` 는 같은 위치의 메모리를 참조합니다-이를 나타내면 아래 그림과 같습니다. 두 개의 쓰기 접근이 같은 메모리를 참조하면서 겹치므로, 충둘을 일으킵니다.

![access the same memory](/assets/Swift/Swift-Programming-Language/Memory-Safety-self-same-memory.jpg)

### Conflicting Access to Properties (속성에 접근할 때의 충돌)

구조체, 튜플, 그리고 열거체와 같은 타입들은 개별 성분 값, 가령 구조체의 속성이나 튜플의 원소들 같은, 것들로 구성되어 있습니다. 이들은 '값 타입' 이기 때문에, 값의 일 부분을 변경하는 것은 전체 값을 변경하는 것이며, 이는 하나의 속성에 대한 읽기나 쓰기 접근이 전체 값에 대한 읽기나 쓰기 접근일 필요가 있다는 것을 의미합니다. 예를 들어, 튜플 원소에 대한 쓰기 접근이 겹칠면 충돌이 일어나게 됩니다:

```swift
var playerInformation = (health: 10, energy: 20)
balance(&playerInformation.health, &playerInformation.energy)
// 에러: playerInformation 에 대한 접근이 충돌합니다.
```

위의 예제에서, 튜플 원소에 대한 `balance(_:_:)` 호출이 충돌을 일으키는데 이는 `playerInformation` 의 쓰기 접근이 겹치기 때문입니다. `playerInformation.health` 와 `playerInformation.energy` 둘 다 입-출력 매개 변수로 전달됐으며, 이는 `balance(_:_:)` 함수 호출의 지속 시간 동안 쓰기 접근을 할 필요가 있음을 의미합니다. 두 가지 경우 모두, 튜플 원소에 대한 쓰기 접근은 튜플 전체에 대한 쓰기 접근을 필요로 합니다. 이것은 `playerInformation` 에 대한 두 개의 쓰기 접근이 지속 시간 동안 겹친다는 것을 의미하며, 이는 충돌의 원인이 됩니다.

구조체를 '전역 변수 (global variable)' 에 저장하게 되면 이 구조체 속성에 대한 쓰기 접근이 겹칠 경우 똑같은 에러가 발생함을 아래 코드가 보여줍니다.

```swift
var holly = Player(name: "Holly", health: 10, energy: 10)
balance(&holly.health, &holly.energy)   // 에러
```

실제로는, 구조체의 속성에 대한 대부분의 접근은 '겹치는 것에 대해 안전 (overlap safely)' 합니다. 예를 들어, 위 예제의 `holly` 변수를 전역 변수 대신 '지역 변수 (local variable)' 로 바꾸면, 컴파일러가 구조체의 '저장 속성 (stored properties)' 에 대한 접근이 겹치는 것이 안전함을 증명할 수 있게 됩니다[^local-variable]:

```swift
func someFunction() {
  var oscar = Player(name: "Oscar", health: 10, energy: 10)
  balance(&oscar.health, &oscar.energy)   // OK, 괜찮습니다.
}
```

위의 예에서, 'Oscar' 의 체력과 에너지는 `balance(_:_:)` 의 두 입-출력 매개 변수로 전달됩니다. 컴파일러가 '메모리 안전성 (memory safety)' 이 보존되고 있다는 것을 증명할 수 있는 이유는 두 개의 저장 속성이 어떤 방식으로도 상호 작용하지 않고 있기 때문입니다.

메모리 안전성을 유지하기 위해 구조체 속성에 대한 접근을 항상 겹치지 않게 제한해야하는 것은 아닙니다. 메모리 안전성은 '보장하길 원하는 것 (desired guarantee)' 이지만, '독점적인 접근 (exclusive access)' 은 그보다 더 엄격한 '필수 조건 (requirement)' 에 해당합니다-이것의 의미는, 메모리에 대한 '독점적인 접근' 을 위반함에도 불구하고, 메모리 안전성을 보존하는 코드도 있다는 것입니다. 스위프트는 컴파일러가 메모리에 대한 비독점적인 접근이 여전히 안전하다는 것을 증명할 수 있다면 그러한 메모리-안전 코드도 허용합니다. 특히, 아래의 조건이 적용된다면 구조체의 속성에 대한 접근이 겹치더라도 안전하다고 증명할 수 있습니다:

* 인스턴스의 저장 속성에만 접근하며, 계산 속성이나 클래스 속성에는 접근하지 않습니다.
* 구조체가 지역 변수의 값이며, 전역 변수의 값이 아닙니다.
* 구조체가 어떤 클로저에 의해서도 붙잡히지 않은 경우이거나, 아니면 '벗어나지 않는 클로저 (nonescaping closure)' 에 의해서만 붙잡힌 경우에 해당합니다.

컴파일러는 접근이 안전하다는 것을 증명하지 못했을 경우, 그 접근을 허용하지 않습니다.

### 참고 자료

[^Memory-Safety]: 이 글에 대한 원문은 [Memory Safety](https://docs.swift.org/swift-book/LanguageGuide/MemorySafety.html) 에서 확인할 수 있습니다.

[^Thread-Sanitizer]: 'Sanitizer' 는 우리 말로 '소독제, 살균제' 등으로 옮길 수 있는데, 'Thread Sanitizer (쓰레드 살균제)' 는 Xcode 에 포함된 도구 중의 하나로 앱에서 'data race (자료 경쟁)' 가 일어나는 지를 찾아줍니다. 'data race' 에 대해서는 위키피디아의 [Race condition](https://en.wikipedia.org/wiki/Race_condition) 이나 [경쟁 상태](https://ko.wikipedia.org/wiki/경쟁_상태) 항목을 참고하기 바랍니다.

[^local-variable]: 전역 변수에 저장할 경우 컴파일러가 이 변수에 대한 접근이 언제 다시 이루어지게 될지 장담할 수 없으므로 에러가 발생하지만, 지역 변수에 저장할 경우 이 변수에 대한 접근이 특정 지역 내로 한정됨을 알 수 있기 때문인 것으로 추측됩니다. 본문의 이어지는 내용에서 이에 대해 좀 더 설명하고 있습니다.

[^man-page]: 이는 'macOS' 의 터미널에서 `$ man stdatomic` 명령을 수행하여 확인할 수 있습니다. '원자적인 연산 (atomic operations)' 앞에는 `atomic_` 라는 접두사가 붙는 것을 볼 수 있습니다.
