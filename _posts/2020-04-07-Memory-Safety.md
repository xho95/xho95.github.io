---
layout: post
comments: true
title:  "Swift 5.4: Memory Safety (메모리 안전성)"
date:   2020-04-07 10:00:00 +0900
categories: Swift Language Grammar Memory Safety
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.4)](https://docs.swift.org/swift-book/) 책의 [Memory Safety](https://docs.swift.org/swift-book/LanguageGuide/MemorySafety.html) 부분[^Memory-Safety] 을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.4: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Memory Safety (메모리 안전성)

기본적으로, 스위프트는 코드에서 안전하지 않은 동작이 발생하는 것을 막습니다. 스위프트는, 예를 들어, 변수는 사용 전에 초기화하고, 메모리는 해제 후에 접근을 안 하며, 배열 색인은 '경계를-벗어난 (out-of-bounds) 에러' 를 검사하도록 보장합니다.

스위프트는 '동일한 메모리 영역' 에 대한 '다중 접근' 의 경우, 해당 위치의 메모리를 수정하는 코드가 그 메모리에 대한 '독점적인 접근 (exclusive access)' 을 가질 것을 요구함으로써, 확실히 '충돌 (conflict)' 하지 않도록 합니다. 스위프트가 자동으로 메모리를 관리하기 때문에, 대부분의 시간에 '메모리 접근' 에 대해서 전혀 생각할 필요가 없습니다. 하지만, 충돌이 일어날 수 있는 가능성이 있는 곳을 이해해서, 메모리 접근이 충돌하는 코드를 작성하는 것을 피할 수 있는 것이 중요합니다. 코드가 '충돌' 을 담고 있으면, '컴파일 시간' 또는 '실행 시간 에러' 를 가지게 될 것입니다.

### Understanding Conflicting Access to Memory (메모리에 대한 접근 충돌 이해하기)

코드에서 '메모리에 대한 접근' 은 변수 값의 설정이나 함수에 인자 전달하기 같은 것들을 할 때 발생합니다. 예를 들어, 다음 코드는 '읽기 접근' 과 '쓰기 접근' 을 둘 다 담고 있습니다:

```swift
// 'one' 이 저장된 메모리에 대한 '쓰기 접근'
var one = 1

// 'one' 이 저장된 메모리에서의 '읽기 접근'
print("We're number \(one)!")
```

'메모리에 대한 접근 충돌' 은 서로 다른 곳의 코드가 동시에 똑같은 위치의 메모리에 접근하려고 할 때 일어날 수 있습니다. 한 위치의 메모리에 동시에 '다중 접근' 하는 것은 예측 불가능하거나 일관성이 없는 동작을 일으킬 수 있습니다. 스위프트에서, 코드 여러 줄에 걸쳐 값을 수정하는 방식은, 자신이 수정하는 중간에 값에 접근하려고 것을 가능하게 합니다.

비슷한 문제는 종이 쪽지에 쓴 '비용 (budget)' 을 갱신하는 방법을 생각해 봄으로써 살펴볼 수 있습니다. 비용 갱신은 2-단계 과정입니다: 첫 번째는 항목의 이름과 가격을 추가하며, 그런 다음 현재 목록의 항목을 반영하도록 총 금액을 바꿉니다. 아래 그림에서 보는 것처럼, 갱신 전과 후에, 비용에 대한 어떤 정보도 읽을 수 있고 올바른 답도 구할 수 있습니다.

![bugdet](/assets/Swift/Swift-Programming-Language/Memory-Safety-budget.jpg)

항목을 비용에 추가함과 동시에, 일시적으로, 무효 상태가 되는데 왜냐면 새로 추가된 항목을 반영하도록 총 금액을 갱신하지 않았기 때문입니다. 항목을 추가하는 동안에 총 금액을 읽으면 잘못된 정보를 줍니다.

이 예제는 메모리 접근 충돌을 고칠 때 맞닥뜨릴 수도 있는 '도전 과제': 충돌을 고치는 여러가지 방법들이 서로 다른 답을 만들어 낼 때가 있는데, 어느 답이 올바른 지가 항상 명백한 것은 아니라는 것도 실증합니다. 이 예제에서는, 원하는 것이 '원래의 총 금액' 인지 '갱신한 총 금액' 인지에 따라, '$5' 나 '$320' 어느 것도 올바른 답이 될 수 있습니다. '접근 충돌' 을 고칠 수 있으려면, 그전에 의도가 무엇인지를 결정해야 합니다.

> '동시성 (concurrent)' 또는 '다중 쓰레드 (multithreaded)' 코드를 작성해 봤다면, 메모리에 대한 접근 충돌이 익숙한 문제일 수가 있습니다. 하지만, 여기서 논의한 '접근 충돌' 은 '단일 쓰레드' 에서 발생할 수 있으며 '동시성' 또는 '다중 쓰레드' 코드와 엮여 있지 _않은 (doesn't)_ 것입니다.
>
> '단일 쓰레드' 안에서 메모리에 대한 접근이 충돌하는 경우, 스위프트는 '컴파일 시간' 이나 '실행 시간' 에 에러를 가지도록 보증합니다. '다중 쓰레드' 코드에서는, 쓰레드 간의 '접근 충돌' 을 감지하는데 도움이 되도록 [Thread Sanitizer (쓰레드 살균제)](https://developer.apple.com/documentation/code_diagnostics/thread_sanitizer)[^Thread-Sanitizer] 를 사용합니다.

#### Characteristics of Memory Access (메모리 접근의 성질)

접근이 충돌하는 상황에서 고려해야 할 '메모리 접근의 성질' 은 세 가지가 있습니다: 접근이 읽기인지 쓰기인지, 접근의 지속 시간, 그리고 접근 중인 메모리의 위치가 그것입니다. 특히, 두 접근이 다음의 모든 조건에 부합할 경우 충돌이 일어납니다:

* 최소한 하나는 '쓰기 접근' 또는 '원자적이 아닌 (nonatomic) 접근'[^nonatomic] 입니다.
* 똑같은 위치의 메모리에 접근합니다.
* 지속 시간이 겹칩니다.

읽기 접근과 쓰기 접근의 차이점은 대체로 명백합니다: 쓰기 접근은 그 위치의 메모리를 바꾸지만, 읽기 접근은 아닙니다. 메모리 위치라는 건 접근하고 있는 것이 무엇-예를 틀어, 변수, 상수, 또는 속성-인진를 말하는 것입니다. 메모리 접근의 '지속 시간' 은 '순간적 (instantaneous)' 이거나 '장기적 (long-term)' 입니다.

연산이 _원자적 (atomic)_ 이라는 것은 C-언어의 '원자적인 (atomic) 연산' 만을 사용하는 경우입니다; 그 외 경우라면 '원자적이 아닌 (nonatomic)' 것입니다. 이 함수들의 목록은, `stdatomic(3)` 의 '매뉴얼 페이지 (man page)'[^man-page] 를 참고하기 바랍니다.

접근이 _순간적 (instantaneous)_ 이라는 것은 해당 접근을 시작한 후에는 끝나기 전까지 다른 코드를 실행하는 것이 불가능한 경우입니다. 태생적으로, 두 개의 '순간적인 접근' 이 동시에 발생할 수는 없습니다. 대부분의 메모리 접근은 '순간적' 입니다. 예를 들어, 아래 나열한 코드에 있는 모든 읽기 접근과 쓰기 접근은 '순간적' 입니다:

```swift
func oneMore(than number: Int) -> Int {
  return number + 1
}

var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)
// "2" 를 인쇄합니다.
```

하지만, 다른 코드의 실행까지 걸쳐진, _장기적인 (long-term)_ 접근이라는, 메모리 접근을 위한 여러 방법이 있습니다. '순간적인 접근' 과 '장기적인 접근' 의 차이점은 장기적인 접근의 경우 이를 시작한 후에는 끝나기 전에 다른 코드를 실행할 수 있다는 것으로, 이를 _겹친다 (overlap)_ 라고 합니다. '장기적인 접근' 은 다른 '장기적인 접근' 및 '순간적인 접근' 과 겹칠 수 있습니다.

'접근의 겹침 (overlapping)' 은 주로 함수와 메소드에서 '입-출력 (in-out) 매개 변수' 를 사용하거나 구조체의 '변경 (mutating) 메소드' 를 사용하는 코드에서 나타납니다. '장기적인 접근' 을 사용하는 특정한 종류의 스위프트 코드는 아래 부분에서 논의합니다.

### Conflicting Access to In-Out Parameters (입-출력 매개 변수에서의 접근 충돌)

모든 '입-출력 (in-out) 매개 변수'[^in-out-parameters] 에 대해서 함수는 '장기적인 쓰기 접근' 을 합니다. 입-출력 매개 변수에 대한 쓰기 접근은 '입-출력이 아닌 (non-in-out)' 모든 매개 변수가 평가된 후에 시작하며 해당 함수 호출의 전체 기간 동안 지속됩니다. 입-출력 매개 변수가 여러 개 있을 경우, 매개 변수가 있는 순서대로 쓰기 접근을 시작합니다.

이러한 '장기적인 쓰기 접근' 으로 인한 한 가지 결론은, '영역 규칙 (scoping rules)' 과 '접근 제어 (access control)' 가 다른 경우라면 허가 했을 그런 경우에도, 입-출력으로 전달한 원본 변수에 접근할 수 없다는 것입니다-원본에 대한 어떤 접근도 충돌을 생성합니다. 예를 들면 다음과 같습니다:

```swift
var stepSize = 1

func increment(_ number: inout Int) {
  number += stepSize
}

increment(&stepSize)
// 에러: stepSize 에 대한 접근 충돌
```

위 코드에서, `stepSize` 는 전역 변수이며, `increment(_:)` 안에서 보통 접근 가능합니다. 하지만, `stepSize` 에 대한 읽기 접근은 `number` 에 대한 쓰기 접근과 겹칩니다. 아래 그림에서 보인 것처럼, `number` 와 `stepSize` 둘 다 똑같은 메모리 위치를 참조합니다. 읽기 접근과 쓰기 접근이 똑같은 메모리를 참조하며 겹치고 있으므로[^three-rules], 충돌을 만듭니다.

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

`increment(_:)` 를 호출하기 전에 `stepSize` 복사본을 만들 땐, `copyOfStepSize` 의 값이 현재 '걸음 크기 (step size)' 만큼 증가함이 명확합니다. 읽기 접근은 쓰기 접근이 시작하기 전에 끝나므로, 충돌이 없습니다.

'입-출력 매개 변수' 에 대한 '장기적인 쓰기 접근' 의 또다른 결론은 동일한 함수의 여러 '입-출력 매개 변수' 로 단일 변수를 전달하는 것은 충돌을 만든다는 것입니다. 예를 들면 다음과 같습니다:

```swift
func balance(_ x: inout Int, _ y: inout Int) {
  let sum = x + y
  x = sum / 2
  y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)   // 됩니다.
balance(&playerOneScore, &playerOneScore)   // 에러: playerOneScore 에 대한 접근이 충돌함
```

위의 `balance(_:_:)` 함수는 두 매개 변수를 이들의 총합을 공평하게 나눈 값으로 수정합니다. `playerOneScore` 와 `playerTwoScore` 를 가지고 호출하는 것은 충돌을 만들지 않습니다-두 쓰기 접근의 시간이 겹치지만, 서로 다른 메모리 위치에 접근합니다. 이와 대조적으로, `playerOneScore` 를 두 매개 변수의 값으로 전달하는 것은 동시에 똑같은 메모리 위치에 두 개의 쓰기 접근을 하려고 하기 때문에 충돌을 만듭니다.

> 연산자도 함수이기 때문에, 이들도 입-출력 매개 변수에 대해 '장기적인 접근' 을 합니다. 예를 들어, `balance(_:_:)` 가 `<^>` 라는 이름의 '연산자 함수' 였다면, `playerOneScore <^> playerOneScore` 라고 작성하는 것은 `balance(&playerOneScore, &playerOneScore)` 라는 것과 똑같은 충돌이 되버립니다.

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

구조체 속성에 대한 접근의 겹침을 제약하는 것이 '메모리 안전성' 을 보존하기 위해 항상 필수인 것은 아닙니다. 메모리 안전성은 '원하는 보증 (desired guarantee)' 이지만, '독점적인 접근 (exclusive access)' 은 '메모리 안전성' 보다 더 엄격한 '필수 조건 (requirement)' 입니다-이는 어떤 코드는, 메모리에 대한 '독점적인 접근' 을 위반함에도 불구하고, 메모리 안전성을 보존한다는 것을 의미합니다. 스위프트는 메모리에 대한 '비독점적인 (nonexclusive) 접근' 이 여전히 안전하다는 것을 컴파일러가 증명할 수만 있다면 이러한 '메모리-안전 코드' 도 허용합니다. 특히, 아래 조건을 적용할 경우 구조체 속성에 대한 접근 겹침이 안전하다는 것을 증명할 수 있습니다:

* 계산 속성이나 클래스 속성이 아니라, 인스턴스의 '저장 속성' 에만 접근하고 있습니다.
* 구조체가, 전역 변수가 아니라, 지역 변수의 값입니다.
* 구조체가 어떤 클로저로도 붙잡히지 않거나, '벗어나지 않는 클로저 (nonescaping closure)' 로만 붙잡힌 것입니다.

컴파일러가 접근이 안전하다는 것을 증명하지 못하면, 접근을 허용하지 않습니다.

### 참고 자료

[^Memory-Safety]: 이 글에 대한 원문은 [Memory Safety](https://docs.swift.org/swift-book/LanguageGuide/MemorySafety.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^Thread-Sanitizer]: '쓰레드 살균제 (thread sanitizer)' Xcode 에 포함된 도구이며, 앱에서 '자료 경쟁 (data race)' 이 일어나는 지를 찾아줍니다. '자료 경쟁 (data race)' 에 대한 더 자세한 정보는, 위키피디아의 [Race condition](https://en.wikipedia.org/wiki/Race_condition) 항목 또는 [경쟁 상태](https://ko.wikipedia.org/wiki/경쟁_상태) 항목을 참고하기 바랍니다.

[^nonatomic]: '원자적이 아닌 접근 (nonatomic access)' 은 본문 뒤에 이어서 설명하는 것처럼, 'C-언어의 원자적인 연산 (atomic operations)' 이외의 함수를 사용하여 접근하는 것을 말합니다. '원자적 접근' 과 관련해서는, 애플의 [Introducing Swift Atomics](https://swift.org/blog/swift-atomics/) 문서를 참고하면 좋을 것입니다.

[^man-page]: '매뉴얼 페이지 (man page)' 는 터미널에서 `man` 명령어를 사용하여 각종 명령어들의 메뉴얼을 나타낸 페이지입니다. 'macOS' 의 터미널에서 `$ man stdatomic` 과 같은 명령을 수행하면 됩니다. 해당 메뉴얼을 보면 '원자적인 연산 (atomic operations)' 앞에는 `atomic_` 이라는 접두사가 붙은 것을 볼 수 있습니다.

[^in-out-parameters]: '입-출력 매개 변수 (in-out parameters)' 에 대한 더 자세한 내용은, [Functions (함수)]({% post_url 2020-06-02-Functions %}) 장에 있는 [In-Out Parameters (입-출력 매개 변수)]({% post_url 2020-06-02-Functions %}#in-out-parameters-입-출력-매개-변수) 부분을 참고하기 바랍니다.

[^three-rules]: 이 한 문장은, 앞서 설명한, '충돌이 일어나는 세 가지 조건' 에 모두 해당됨을 나타냅니다. 만약 세 가지 조건 중 하나라도 해당이 안된다면 충돌이 일어나지 않을 것입니다.

[^local-variable]: 전역 변수에 저장할 경우 컴파일러가 이 변수에 대한 접근이 언제 다시 이루어지게 될지 장담할 수 없으므로 에러가 발생하지만, 지역 변수에 저장할 경우 이 변수에 대한 접근이 특정 지역 내로 한정됨을 알 수 있기 때문인 것으로 추측됩니다. 본문의 이어지는 내용에서 이에 대해 좀 더 설명하고 있습니다.
