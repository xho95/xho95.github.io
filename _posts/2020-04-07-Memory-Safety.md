---
layout: post
comments: true
title:  "Swift 5.3: Memory Safety (메모리 안전성)"
date:   2020-04-07 10:00:00 +0900
categories: Swift Language Grammar Memory Safety
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Memory Safety](https://docs.swift.org/swift-book/LanguageGuide/MemorySafety.html) 부분[^Memory-Safety]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 전체 번역은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Memory Safety (메모리 안전성; 메모리 안전 장치)

기본적으로, 스위프트는 코드 내에서 안전하지 않은 동작이 발생하는 것을 막습니다. 예를 들어, 스위프트는 변수가 사용되기 전에 초기화되었다는 것을, 메모리가 해제된 후에는 접근하지 않는다는 것을, 그리고 배열 색인에 대하여 '경계를-벗어난 (out-of-bounds)' 에러를 검사한 것을 보장합니다.

스위프트는 또한 '동일한 메모리 영역' 에 대한 '다중 접근 (multiple accesses)' 의 경우, 특정 위치의 메모리를 수정하는 코드는 해당 메모리에 대한 '독점적인 접근 (exclusive access)' 을 가질 것을 필수로 요구함으로써, 서로 '충돌 (conflict)' 하지 않음을 확실하게 만듭니다. 스위프트는 메모리를 자동으로 관리하기 때문에, 거의 대부분 메모리 접근에 대해 생각을 할 필요가 전혀 없습니다. 하지만, 잠재적인 충돌이 발생할 곳을 이해하는 것은 중요하며, 그래야 작성한 코드에서 메모리 접근이 충돌하는 것을 피할 수 있기 때문입니다. 코드가 충돌을 담고 있으면, '컴파일 시간 에러' 나 '실행 시간 에러' 를 가지게 됩니다.

### Understanding Conflicting Access to Memory (메모리에 대한 접근이 충돌하는 것을 이해하기)

코드에서 '메모리에 대한 접근 (access to memory)' 은 변수의 값을 설정하는 것 또는 함수에 인자를 전달하는 것과 같은 것을 할 때 발생합니다. 예를 들어, 다음 코드는 '읽기 접근 (read access)' 과 '쓰기 접근 (write access)' 둘 다를 모두 담고 있습니다:

```swift
// one 이 저장된 메모리에 대한 '쓰기 접근'
var one = 1

// one 이 저장된 메모리로 부터의 '읽기 접근'
print("We're number \(one)!")
```

메모리에 대한 접근이 충돌하는 것은 서로 다른 곳의 코드가 동시에 똑같은 위치의 메모리에 접근하려고 할 때 발생합니다. 동시에 한 위치의 메모리에 '다중 접근 (multiple accesses)' 하는 것은 예측할 수 없고 일관성이 없는 동작을 일으킬 수 있습니다. 스위프트에는, 여러 줄의 코드에 걸쳐서 값을 수정하는 방식도 있는데, 이는 자기가 수정하는 중간에 값에 접근하려고 하는 것도 가능하게 만듭니다.

이와 비슷한 문제는 종이 쪽지에 쓴 비용을 갱신하는 방법을 생각하는 것으로써 살펴볼 수 있습니다. 비용을 갱신하는 것은 2-단계 과정입니다: 먼저 항목의 이름과 가격을 추가하고, 그 다음 현재 목록의 항목을 반영하도록 총 금액을 바꿉니다. 아래 그림에서 보인 것처럼, 갱신 전이든 후든, 비용에 대한 어떤 정보도 읽을 수 있고 정확한 답도 구할 수 있습니다.

![bugdet](/assets/Swift/Swift-Programming-Language/Memory-Safety-budget.jpg)

비용에 항목을 추가하는 동안에는, 일시적으로, 무효 상태가 되는데 왜냐면 총 금액이 새로 추가된 항목을 반영하도록 갱신되지 않았기 때문입니다. 항목을 추가하는 과정 중에 총 금액을 읽는 것은 잘못된 정보를 부여합니다.

이 예제는 또한 메모리 접근이 충돌하는 것을 고칠 때 맞닥뜨리게 되는 도전 과제를 보여주고 있습니다: 충돌을 고치는 여러가지 방법들은 때때로 서로 다른 답을 내놓는데, 어느 답이 올바른 지가 항상 명백한 것은 아니라는 것입니다. 이 예제의 경우, 원하던 것이 원래의 총 금액인지 아니면 갱신된 총 금액인지에 따라, '$5' 나 '$320' 중 어느 것이든 올바른 답이 될 수 있습니다. '접근 충돌' 을 고칠 수 있으려면, 그전에 의도하는 것이 무엇인지를 결정해야 합니다.

> '동시성 (concurrent)' 코드나 '다중 쓰레드 (multithreaded)' 코드를 작성해 본 적이 있다면, 메모리 접근 충돌은 익숙한 문제일 수도 있습니다. 하지만, 여기서 논의하는 '접근 충돌' 은 단일 쓰레드에서 발생할 수 있는 것으로 '동시성 코드' 나 '다중 쓰레드 코드' 와 엮이지 _않은 (doesn't)_ 것입니다.
>
> 단일 쓰레드 내에서 메모리 접근에 대한 충돌이 발생하면, '컴파일 시간' 또는 '실행 시간' 중 한 곳에서 에러를 가질 것을 스위프트가 보증합니다. 다중 쓰레드 코드에 대해서는, [Thread Sanitizer (쓰레드 살균제)](https://developer.apple.com/documentation/code_diagnostics/thread_sanitizer)[^Thread-Sanitizer] 를 사용하면 쓰레드를 넘나드는 접근 충돌을 감지하는데 도움을 받을 수 있습니다.

#### Characteristics of Memory Access (메모리 접근의 성질)

접근이 충돌하는 상황에서 고려해야 할 '메모리 접근의 성질' 은 세 가지입니다: 접근이 읽기인지 쓰기인지의 여부, 접근의 지속 시간, 그리고 접근 중인 메모리의 위치가 그것입니다. 특히, 두 개의 접근이 다음 조건들에 모두 해당하면 충돌이 일어납니다:

* 적어도 하나는 '쓰기 접근 (write access)' 또는 '원자적이 아닌 접근 (nonatomic access)' 입니다.
* 이들은 메모리의 동일한 위치에 접근합니다.
* 이들의 지속 시간이 겹칩니다.

읽기 접근과 쓰기 접근의 차이점은 대체로 명백합니다: 쓰기 접근은 메모리 위치의 것을 바꾸지만, 읽기 접근은 아닙니다. 메모리 위치는 접근 중인 것을 참조합니다-예를 들어, 변수, 상수, 또는 속성입니다. 메모리 접근의 지속 시간은 '순간적 (instantaneous)' 이거나 '장기적 (long-term)' 입니다.

연산이 _원자적 (atomic)_ 인 것은 C-언어의 '원자적인 연산 (atomic operations)' 만을 사용하는 경우입니다; 그외 다른 경우 '원자적이 아닌 (nonatomic)' 것입니다. 이러한 함수의 목록은, `stdatomic(3)` 의 'man' 페이지를 참고하기 바랍니다.[^man-page]

접근이 _순간적 (instantaneous)_ 인 것은 해당 접근을 시작한 다음에는 끝나기 전에 다른 코드를 실행하는 것이 불가능한 경우입니다; 본질적으로, 두 개의 '순간적인 접근' 은 동시에 발생할 수 없습니다. 대부분의 메모리 접근은 '순간적 (instantaneous)' 입니다. 예를 들어, 아래 코드에 나열되어 있는 모든 읽기 접근과 쓰기 접근은 '순간적' 입니다:

```swift
func oneMore(than number: Int) -> Int {
  return number + 1
}

var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)
// "2" 를 출력합니다.
```

하지만, 다른 코드의 실행까지 걸쳐 있는, _장기적인 (long-term)_ 접근이라는, 여러 가지의 메모리 접근 방법이 있습니다. '단기적인 접근' 과 '장기적인 접근' 의 차이점은 장기적인 접근을 시작한 다음에는 끝나기 전에 다른 코드를 실행하는 것이 가능하다는 것으로, 이를 '_겹친다 (overlap)_' 라고 합니다. 장기적인 접근은 다른 장기적인 접근 및 순간적인 접근과 겹칠 수 있습니다.

접근의 겹침은 함수 및 메소드 또는 구조체의 '변경 메소드 (mutating methods)' 가 '입-출력 매개 변수 (in-out paraeters)' 를 사용하는 코드에서 주로 생깁니다. '장기적인 접근' 을 사용하는 스위프트 코드에 대해서는 특정 종류별로 아래 부분에서 논의합니다.

### Conflicting Access to In-Out Parameters (입-출력 매개 변수에 대한 접근 충돌)

함수는 모든 '입-출력 매개 변수 (in-out parameters)' 에 대해서 '장기적인 쓰기 접근' 을 합니다. 입-출력 매개 변수에 대한 쓰기 접근은 모든 '비-입-출력 매개 변수 (non-in-out parameters)' 를 평가한 후에 시작하며 해당 함수 호출의 전체 기간 동안 지속됩니다. '입-출력 매개 변수' 가 여러 개 있을 경우, 쓰기 접근은 매개 변수가 있는 순서대로 시작합니다.

이러한 장기적인 쓰기 접근으로 인한 한 가지 주요 결과는 입-출력으로 전달된 원본 변수에 접근할 수 없다는 것으로, 심지어 '영역 규칙 (scoping rules)' 과 '접근 제어 (access control)' 가 다른 경우라면 이를 허가할 것이라도 그렇습니다-원본에 대한 어떤 접근도 충돌을 생성합니다.[^original-variable] 예를 들면 다음과 같습니다:

```swift
var stepSize = 1

func increment(_ number: inout Int) {
  number += stepSize
}

increment(&stepSize)
// 에러: stepSize 에 대한 접근 충돌
```

위의 코드에서, `stepSize` 는 전역 변수이고, 보통은 `increment(_:)` 내에서 접근 가능합니다. 하지만, `stepSize` 에 대한 읽기 접근이 `number` 에 대한 쓰기 접근과 겹칩니다. 아래 그림에서 보인 것처럼, `number` 와 `stepSize` 둘 모두 같은 위치의 메모리를 참조합니다. 읽기 접근과 쓰기 접근이 같은 메모리를 참조하고 겹치고 있으므로, 충돌을 만듭니다.

![in-out parameters](/assets/Swift/Swift-Programming-Language/Memory-Safety-inout-conflict.jpg)

이 충돌을 풀어내는 한 가지 방법은 `stepSize` 의 명시적인 복사본을 만드는 것입니다:

```swift
// 명시적인 복사본을 만듭니다.
var copyOfStepSize = stepSize
increment(&copyOfStepSize)

// 원본을 갱신합니다.
stepSize = copyOfStepSize
// stepSize 는 이제 2 입니다.
```

`increment(_:)` 의 호출 전에 `stepSize` 의 복사본을 만들 때, `copyOfStepSize` 의 값은 현재 '걸음 크기 (step size)' 만큼 증가한다는 것이 명확해 집니다. 쓰기 접근을 시작하기 전에 읽기 접근이 끝나므로, 충돌은 없습니다.

입-출력 매개 변수에 대한 '장기적인 쓰기 접근' 의 또다른 주요 결과는 단일 변수를 동일 함수의 '다중 입-출력 매개 변수' 로 전달하는 것은 충돌을 만든다는 것입니다. 예를 들면 다음과 같습니다:

```swift
func balance(_ x: inout Int, _ y: inout Int) {
  let sum = x + y
  x = sum / 2
  y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)   // OK, 괜찮습니다.
balance(&playerOneScore, &playerOneScore)   // Error: playerOneScore 에 대한 접근이 충돌합니다.
```

위에 있는 `balance(_:_:)` 함수는 두 매개 변수의 값을 총합하여 공평하게 나눈 값으로 수정합니다. 인자가 `playerOneScore` 와 `playerTwoScore` 일 때의 호출은 충돌을 만들지 않습니다-시간이 겹치는 쓰기 접근이 두 개 있지만, 서로 다른 위치의 메모리에 접근합니다. 이와 대조적으로, 두 매개 변수 둘 모두에 `playerOneScore` 를 값으로 전달하는 것은 충돌을 만들게 되는데 왜냐면 두 개의 쓰기 접근이 동시에 같은 위치의 메모리에 접근하려고 시도하기 때문입니다.

> 연산자도 함수이기 때문에, 이들도 입-출력 매개 변수에 대해서 장기적인 접근을 합니다. 예를 들어, 만약 `balance(_:_:)` 가 `<^>` 라는 이름의 연산자 함수라면, `playerOneScore <^> playerOneScore` 라고 작성하는 것은 `balance(& playerOneScore, & playerOneScore)` 와 똑같은 충돌로 귀결됩니다.

### Conflicting Access to self in Methods (메소드에서 self 에 대한 접근 충돌)

구조체에 대한 '변경 (mutating) 메소드' 는 메소드 호출의 지속 시간 동안에 `self` 에 대하여 쓰기 접근을 합니다. 예를 들어, 각각의 참여자가, 피해를 받을 때 감소하는, '체력 량' 과, 특수한 능력을 사용할 때 감소하는, '에너지 양' 를 가지고 있는 게임을 고려해 봅시다.

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

위의 `restoreHealth()` 메소드에서, `self` 에 대한 쓰기 접근은 메소드 최초부터 시작해서 메소드 반환 때까지 지속됩니다. 이번 경우, `restoreHealth()` 내에 `Player` 인스턴스의 속성과 접근이 겹칠 수도 있는 코드는 아무 것도 없습니다. 아래의 `shareHealth(with:)` 메소드는 다른 `Player` 인스턴스를 입-출력 매개 변수로 받기 때문에, 접근이 겹칠 가능성이 생깁니다.

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

위의 예제에서, 'Maria' 의 참여자와 체력을 공유하기 위햬 'Oscar' 의 참여자에 대한 `shareHealth(with:)` 메소드를 호출하는 것은 충돌을 야기하지 않습니다. 메소드 호출 동안 `oscar` 에 대한 쓰기 접근을 하는데 이는 `oscar` 가 '변경 메소드' 에 있는 `self` 의 값이기 때문이며, 동일 지속 시간에 `maria` 에 대한 쓰기 접근도 하는데 이는 `maria` 가 입-출력 매개 변수로 전달되었기 때문입니다. 아래 그림에서 보인 것처럼, 이들은 서로 다른 위치의 메모리에 접근합니다. 두 개의 쓰기 접근이 시간이 겹친다고 하더라도, 충돌하지는 않습니다.

![access different locations in memory](/assets/Swift/Swift-Programming-Language/Memory-Safety-self-different-memory.jpg)

하지만, `oscar` 를 `shareHealth(with:)` 의 인자로 전달하면, 이는 충돌입니다:

```swift
oscar.shareHealth(with: &oscar)
// 에러: oscar 에 대한 접근이 충돌합니다.
```

변경 메소드는 메소드의 지속 시간 동안에 `self` 에 대한 쓰기 접근을 할 필요가 있고, 입-출력 매개 변수는 동일한 지속 시간 동안에 `teammate` 에 대한 쓰기 접근을 할 필요가 있습니다. 메소드 내에서, `self` 와 `teammate` 둘 모두는-아래 그림에 보인 것처럼-같은 위치의 메모리를 참조합니다. 두 개의 쓰기 접근이 같은 메모리를 참조하며 겹치고 있으므로, 충돌을 만듭니다.

![access the same memory](/assets/Swift/Swift-Programming-Language/Memory-Safety-self-same-memory.jpg)

### Conflicting Access to Properties (속성에 대한 접근 충돌)

구조체, 튜플, 그리고 열거체 같은 타입은, 구조체의 속성 또는 튜플의 원소와 같이, 개별 '구성 요소 (constituent)' 값들로 이루어져 있습니다. 이들은 '값 타입' 이기 때문에, 값의 어떤 부분을 변경하는 것이든 전체 값을 변경하는 것으로, 이는 속성 하나에 대한 읽기나 쓰기 접근은 전체 값에 대한 읽기나 쓰기 접근을 필수로 요구한다는 의미입니다. 예를 들어, 튜플의 원소에 대해서 쓰기 접근이 겹치면 충돌이 발생합니다:

```swift
var playerInformation = (health: 10, energy: 20)
balance(&playerInformation.health, &playerInformation.energy)
// 에러: playerInformation 에 대한 접근이 충돌합니다.
```

위의 예제에서, 튜플의 원소에 대해서 `balance(_:_:)` 를 호출하는 것은 충돌을 만드는데 이는 `playerInformation` 에 대한 쓰기 접근이 겹치기 때문입니다. `playerInformation.health` 와 `playerInformation.energy` 둘 모두를 입-출력 매개 변수로 전달하는데, 이는 `balance(_:_:)` 가 함수 호출이 지속되는 동안에 이들에 대하여 쓰기 접근을 해야 함을 의미합니다. 두 경우 모두에서, 튜플 원소에 대한 쓰기 접근은 전체 튜플에 대한 쓰기 접근을 필수로 요구합니다. 이는 `playerInformation` 에 대하여 지속 시간이 겹치는, 즉 충돌을 야기하는, 두 개의 쓰기 접근이 있다는 것을 의미합니다.

아래 코드는 '전역 (global) 변수' 에 저장된 구조체도 그 속성에 대한 쓰기 접근이 겹치면 똑같은 에러가 나타남을 보여줍니다.

```swift
var holly = Player(name: "Holly", health: 10, energy: 10)
balance(&holly.health, &holly.energy)   // 에러
```

사실, 구조체의 속성에 대한 대부분의 접근은 안전하게 겹칠 수 있습니다. 예를 들어, 만약 위 예제에서 `holly` 변수를 전역 변수 대신 '지역 (local) 변수' 로 바꾸면, 구조체의 '저장 속성' 에 대한 접근이 겹치는 것이 안전함을 컴파일러가 증명할 수 있습니다:[^local-variable]

```swift
func someFunction() {
  var oscar = Player(name: "Oscar", health: 10, energy: 10)
  balance(&oscar.health, &oscar.energy)   // OK, 괜찮습니다.
}
```

위의 예제에서, 'Oscar' 의 '체력' 과 '에너지' 를 `balance(_:_:)` 의 두 개의 입-출력 매개 변수로 전달합니다. 컴파일러는 '메모리 안전성 (memory safety)' 이 보존된다는 것을 증명할 수 있는데 왜냐면 두 저장 속성이 어떤 방식으로도 상호 작용하지 않기 때문입니다.

구조체 속성에 대한 접근의 겹침을 제약하는 것이 '메모리 안전성' 을 보존하기 위해 항상 필수인 것은 아닙니다. 메모리 안전성은 '요구되는 보증 (desired guarantee)' 이지만, '독점적인 접근 (exclusive access)' 은 '메모리 안전성' 보다 더 엄격한 '필수 조건 (requirement)' 입니다-이는 어떤 코드는, 메모리에 대한 '독점적인 접근' 을 위반함에도 불구하고, 메모리 안전성을 보존한다는 것을 의미합니다. 스위프트는 메모리에 대한 '비독점적인 (nonexclusive) 접근' 이 여전히 안전하다는 것을 컴파일러가 증명할 수만 있다면 이러한 '메모리-안전 코드' 도 허용합니다. 특히, 아래 조건을 적용할 경우 구조체 속성에 대한 접근 겹침이 안전하다는 것을 증명할 수 있습니다:

* 계산 속성이나 클래스 속성이 아니라, 인스턴스의 '저장 속성' 에만 접근하고 있습니다.
* 구조체가, 전역 변수가 아니라, 지역 변수의 값입니다.
* 구조체가 어떤 클로저로도 붙잡히지 않거나, '벗어나지 않는 클로저 (nonescaping closure)' 로만 붙잡힌 것입니다.

컴파일러가 접근이 안전하다는 것을 증명하지 못하면, 접근을 허용하지 않습니다.

### 참고 자료

[^Memory-Safety]: 이 글에 대한 원문은 [Memory Safety](https://docs.swift.org/swift-book/LanguageGuide/MemorySafety.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^Thread-Sanitizer]: 'Sanitizer' 는 우리 말로 '소독제, 살균제' 등으로 옮길 수 있는데, 'Thread Sanitizer (쓰레드 살균제)' 는 Xcode 에 포함된 도구 중의 하나로 앱에서 'data race (자료 경쟁)' 가 일어나는 지를 찾아줍니다. 'data race' 에 대해서는 위키피디아의 [Race condition](https://en.wikipedia.org/wiki/Race_condition) 이나 [경쟁 상태](https://ko.wikipedia.org/wiki/경쟁_상태) 항목을 참고하기 바랍니다.

[^original-variable]: 여기서 '원본 변수에 접근할 수 없다' 는 말을 그 밑의 예제로 해석하면 `increment` 함수 내에서 `stepSize` 를 사용할 수 없다는 말이됩니다. 즉, 예제에서 잘못된 것은 `number += stepSize` 구문이며, `number` 와 `stepSize` 가 같은 위치의 메모리에 접근하기 때문에 충돌이 발생합니다.

[^local-variable]: 전역 변수에 저장할 경우 컴파일러가 이 변수에 대한 접근이 언제 다시 이루어지게 될지 장담할 수 없으므로 에러가 발생하지만, 지역 변수에 저장할 경우 이 변수에 대한 접근이 특정 지역 내로 한정됨을 알 수 있기 때문인 것으로 추측됩니다. 본문의 이어지는 내용에서 이에 대해 좀 더 설명하고 있습니다.

[^man-page]: 'man page (메뉴얼 페이지)' 는 터미널에서 각종 명령어들에 대한 메뉴얼을 볼 수 있게 해주는 것으로 'macOS' 의 터미널에서 `$ man stdatomic` 와 같은 명령을 수행하여 실행합니다. 해당 메뉴얼을 보면 '원자적인 연산 (atomic operations)' 앞에는 `atomic_` 이라는 접두사가 붙는 것을 볼 수 있습니다.
