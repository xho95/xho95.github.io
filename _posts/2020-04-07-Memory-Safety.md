---
layout: post
comments: true
title:  "Swift 5.7: Memory Safety (메모리 안전성)"
date:   2020-04-07 10:00:00 +0900
categories: Swift Language Grammar Memory Safety
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [Memory Safety](https://docs.swift.org/swift-book/LanguageGuide/MemorySafety.html) 부분[^Memory-Safety] 을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Memory Safety (메모리 안전성)

기본적으로, 스위프트는 안전하지 않은 동작이 코드에서 발생하는 걸 막습니다. 예를 들어, 스위프트는 사용 전에 변수를 초기화하는지, 해제 후에 메모리에 접근하진 않은지, 배열 색인이 경계를-벗어난 (out-of-bounds) 에러인지의 검사를 보장합니다.

스위프트는, 어떤 장소의 메모리를 수정하는 코드는 그 메모리에 독점적으로 접근 (exclusive access) 하길 요구함으로써, 동일한 메모리 영역으로의 여러 개의 접근도 충돌하지 않도록 합니다. 스위프트가 메모리를 자동으로 관리하기 때문에, 대부분의 시간엔 메모리 접근에 대해 전혀 생각하지 않아도 됩니다. 하지만, 충돌이 일어날 수 있을 만한 곳을 이해해서, 메모리 접근이 충돌하는 코드의 작성을 피할 수 있는 건, 중요합니다. 충돌하는 코드를 담고 있으면, 컴파일-시간이나 실행 시간 에러를 가질겁니다.

### Understanding Conflicting Access to Memory (메모리 접근의 충돌 이해하기)

메모리 접근은 코드에서 변수 값의 설정이나 함수에 인자 전달하기 같은 걸 할 때 발생합니다. 예를 들어, 다음 코드는 읽기 접근과 쓰기 접근 둘 다를 담고 있습니다:

```swift
// one 을 저장한 메모리로의 쓰기 접근
var one = 1

// one 을 저장한 메모리에서 읽기 접근
print("We're number \(one)!")
```

메모리 접근 충돌은 서로 다른 부분의 코드가 동시에 동일 장소의 메모리에 접근하려고 할 때 일어날 수 있습니다. 동시에 한 장소의 메모리에 여러 개가 접근하면 예측 불가능하거나 일관성 없는 동작을 만들어 낼 수 있습니다. 스위프트에는, 여러 줄의 코드에 걸쳐 값을 수정하는 방식이 있는데, 이는 자신만의 수정 중간에 값에 접근하려는 시도를 가능하게 합니다.

종이 쪽지에 쓴 비용의 업데이트 방법을 생각함으로써 비슷한 문제를 알아볼 수 있습니다. 비용 업데이트는 2-단계 과정인데: 첫 번째는 항목 이름과 가격을 추가하는 것이고, 그 다음엔 총 금액을 바꿔서 현재 목록에 있는 항목을 반영하는 것입니다. 업데이트 전과 후엔, 아래 그림에서 보듯, 어떤 비용 정보든 읽을 수 있고 올바른 답을 가질 수도 있습니다.

![bugdet](/assets/Swift/Swift-Programming-Language/Memory-Safety-budget.jpg)

비용에 항목을 추가하는 동안엔, 일시적으로, 무효 상태인데 이는 새로 추가한 항목을 반영하도록 총 금액을 업데이트하지 않았기 때문입니다. 항목을 추가하는 과정 중에 총 금액을 읽으면 잘못된 정보를 줍니다.

이 예제는 메모리 접근 충돌을 고칠 때 마주칠 수도 있는 도전 과제도 실제로 보여줍니다: 여러 방법으로 충돌을 고치다 보면 서로 다른 답을 만들어 낼 때가 있으며, 어느 답이 올바른 지 항상 명백하지는 않다는 것입니다. 이 예제에선, 원하는게 원본 총 금액인지 업데이트한 총 금액인지에 따라, $5 나 $320 어느 것도 올바른 답이 될 수 있습니다. 접근 충돌을 고칠 수 있으려면 그전에, 무얼 하려는 의도인지를 결정해야 합니다.

> 동시성 (concurrent) 이나 다중 쓰레드 (multithreaded) 코드를 작성해 봤으면, 메모리 접근 충돌이 익숙한 문제일 지도 모릅니다. 하지만, 여기서 논의한 접근 충돌은 단일 쓰레드에서 발생할 수도 있으며 동시성이나 다중 쓰레드 코드와 엮이지 _않은 (doesn't)_ 것입니다.
>
> 단일 쓰레드 안에서 메모리 접근이 충돌하면, 컴파일 시간 또는 실행 시간에 에러를 가지는 걸 스위프트가 보증합니다. 다중 쓰레드 코드에선, [Thread Sanitizer (쓰레드 살균제)](https://developer.apple.com/documentation/code_diagnostics/thread_sanitizer)[^Thread-Sanitizer] 를 사용하면 쓰레드 간의 접근 충돌 탐지를 도와줍니다.

#### Characteristics of Memory Access (메모리 접근의 성질)

접근 충돌 상황에서 고려할 메모리 접근의 성질엔 세 가지가 있는데: 접근이 읽기인지 쓰기인지와, 접근의 지속 시간, 및 접근할 메모리의 장소가 그것입니다. 특히, 충돌은 두 접근이 다음의 모든 조건에 부합하면 일어납니다:

* 적어도 하나는 쓰기 접근이거나 원자적이 아닌 접근[^nonatomic] 입니다.
* 동일한 장소의 메모리에 접근합니다.
* 지속 시간이 겹칩니다.

읽기 및 쓰기 접근의 차이는 대체로 명백한데: 쓰기 접근은 그 장소의 메모리를 바꾸지만, 읽기 접근은 아니라는 겁니다. 메모리 장소는 접근하고 있는 걸 참조하는데-예를 틀어, 변수나, 상수, 또는 속성 등입니다. 메모리 접근의 지속 시간은 순간적 (instantaneous) 이거나 장기적 (long-term) 입니다.

C-언어의 원자적 연산 (atomic operations) 만 사용하면 연산이 _원자적 (atomic)_ 이며; 그 외의 경우 원자적이 아닙니다 (nonatomic). 이 함수들의 목록은, `stdatomic(3)` 매뉴얼 페이지 (man page)[^man-page] 를 보도록 합니다.

접근을 시작한 후엔 이게 끝나기 전까지 다른 코드의 실행이 불가능하면 접근이 _순간적 (instantaneous)_ 입니다. 태생적으로, 두 개의 순간적 접근이 동시에 발생할 순 없습니다. 대부분의 메모리 접근은 순간적입니다. 예를 들어, 아래 나열한 코드의 모든 읽기 및 쓰기 접근은 순간적입니다:

```swift
func oneMore(than number: Int) -> Int {
  return number + 1
}

var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)
// "2" 를 인쇄함
```

하지만, _장기적 (long-term)_ 접근이라는, 여러 가지 방식의 메모리 접근법이 있는데, 이는 다른 코드의 실행까지 걸쳐져 있습니다. 순간적 접근과 장기적 접근의 차이는 장기적 접근을 시작한 후엔 이게 끝나기 전에 다른 코드의 실행이 가능하다는 것으로, 이를 _겹친다 (overlap)_ 고 합니다. 한 장기적 접근은 다른 장기적인 접근 및 순간적 접근과 겹쳐질 수 있습니다.

접근 겹침은 주로 함수와 메소드 및 구조체의 변경 메소드에서 입-출력 매개 변수를 사용하는 코드에서 나타납니다. 장기적 접근을 사용한 특정 종류의 스위프트 코드는 밑의 절에서 논의합니다.

### Conflicting Access to In-Out Parameters (입-출력 매개 변수로의 접근 충돌)

함수는 자신의 모든 입-출력 매개 변수[^in-out-parameters] 에 장기적인 쓰기 접근을 합니다. 입-출력 매개 변수로의 쓰기 접근은 모든 입-출력-아닌 매개 변수를 평가한 후 시작해서 그 함수 호출의 전체 지속 시간 동안 계속 이어집니다. 입-출력 매개 변수가 여러 개 있으면, 매개 변수가 나타난 순서대로 쓰기 접근을 시작합니다.

이 장기적 쓰기 접근의 한 가지 결론은, 다른 경우라면 영역 규칙 (scoping rules) 과 접근 제어 (access control) 가 허가했을 경우에도, 입-출력으로 전달한 원본 변수에 접근할 수 없다는 겁니다-원본으로의 어떤 접근이든 충돌을 생성합니다. 예를 들면 다음과 같습니다:

```swift
var stepSize = 1

func increment(_ number: inout Int) {
  number += stepSize
}

increment(&stepSize)
// 에러: stepSize 로의 접근 충돌
```

위 코드에서, `stepSize` 는 전역 변수며, 보통은 `increment(_:)` 안에서 접근 가능합니다. 하지만, `stepSize` 로의 읽기 접근은 `number` 로의 쓰기 접근과 겹칩니다. 아래 그림에서 보는 것처럼, `number` 와 `stepSize` 는 둘 다 동일한 장소의 메모리를 참조합니다. 읽기 및 쓰기 접근이 동일 메모리를 참조하면서 겹치므로,[^three-rules] 충돌을 만듭니다.

![in-out parameters](/assets/Swift/Swift-Programming-Language/Memory-Safety-inout-conflict.jpg)

이 충돌을 푸는 한 가지 방법은 명시적으로 `stepSize` 의 복사본을 만드는 겁니다:

```swift
// 명시적인 복사본을 만듦.
var copyOfStepSize = stepSize
increment(&copyOfStepSize)

// 원본을 업데이트함.
stepSize = copyOfStepSize
// stepSize 는 이제 2 임
```

`increment(_:)` 의 호출 전에 `stepSize` 복사본을 만들 땐, `copyOfStepSize` 값이 현재 걸음 (step size) 만큼 증가하는게 명확합니다. 읽기 접근이 쓰기 접근 시작 전에 끝나므로, 충돌은 없습니다.

입-출력 매개 변수로의 장기적 쓰기 접근의 또 다른 결론은 동일 함수에 있는 여러 입-출력 매개 변수의 인자로 단일한 변수를 전달하면 충돌을 만든다는 겁니다. 예를 들면 다음과 같습니다:

```swift
func balance(_ x: inout Int, _ y: inout Int) {
  let sum = x + y
  x = sum / 2
  y = sum - x
}
var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)   // 괜찮음
balance(&playerOneScore, &playerOneScore)   // 에러: playerOneScore 로의 접근 충돌
```

위의 `balance(_:_:)` 함수는 자신의 두 매개 변수를 이들의 총합으로 공평하게 나눈 값으로 수정합니다. `playerOneScore` 와 `playerTwoScore` 로 호출하면 충돌을 만들지 않는데-쓰기 접근 두 개가 시간은 겹치지만, 서로 다른 위치의 메모리에 접근해서 입니다. 이와 대조적으로, `playerOneScore` 를 두 매개 변수의 값으로 전달하면 충돌을 만드는데 이는 동시에 동일한 장소의 메모리에 두 개의 쓰기 접근을 하려고 하기 때문입니다.

> 연산자도 함수기 때문에, 이들도 자신의 입-출력 매개 변수로의 장기적 접근을 합니다. 예를 들어, `balance(_:_:)` 가 `<^>` 라는 이름의 연산자 함수였다면, `playerOneScore <^> playerOneScore` 라고 작성해도 `balance(&playerOneScore, &playerOneScore)` 와 동일하게 충돌이 될 것입니다.

### Conflicting Access to self in Methods (메소드에서 self 로의 접근 충돌)

구조체의 변경 메소드[^mutating-methods] 는 메소드 호출의 지속 시간 동안 `self` 로의 쓰기 접근을 합니다. 예를 들어, 게임의 각 참가자가, 피해를 받으면 감소하는, 체력 량과, 특수 능력을 쓰면 감소하는, 에너지 양을, 가진다고 고려합니다.

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

위의 `restoreHealth()` 메소드에서, `self` 로의 쓰기 접근은 메소드 맨 앞에서 시작해서 메소드 반환 전까지 계속 이어집니다. 이 경우, `restoreHealth()` 안에는 `Player` 인스턴스의 속성으로 접근 겹침이 있을만한 다른 코드가 없습니다. 아래의 `shareHealth(with:)` 메소드는 또 다른 `Player` 인스턴스를 입-출력 매개 변수로 취해서, 접근 겹침이 발생할 가능성이 생깁니다.

```swift
extension Player {
  mutating func shareHealth(with teammate: inout Player) {
    balance(&teammate.health, &health)
  }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)   // 괜찮음
```

위 예제에서, Oscar 의 `shareHealth(with:)` 메소드를 호출하여 Maria 와 체력을 공유하는 건 충돌을 일으키지 않습니다. 메소드 호출 중에 `oscar` 로의 쓰기 접근을 하는데 변경 메소드 안의 `self` 값이 `oscar` 이기 때문이며, 동일 지속 시간 동안 `maria` 로의 쓰기 접근도 하는데 `maria` 를 입-출력 매개 변수로 전달했기 때문입니다. 아래 그림에 보는 것처럼, 이들은 다른 장소의 메모리에 접근합니다. 두 쓰기 접근의 시간이 겹칠지라도, 충돌하진 않습니다.

![access different locations in memory](/assets/Swift/Swift-Programming-Language/Memory-Safety-self-different-memory.jpg)

하지만, `shareHealth(with:)` 에 `oscar` 를 인자로 전달하면, 충돌합니다:

```swift
oscar.shareHealth(with: &oscar)
// 에러: oscar 로의 접근 충돌
```

변경 메소드는 메소드 지속 시간 동안 `self` 로의 쓰기 접근을 할 필요가 있고, 입-출력 매개 변수는 동일 지속 시간 동안 `teammate` 로의 쓰기 접근을 할 필요가 있습니다. 아래 그림에 보는 것처럼-메소드 안에서, `self` 와 `teammate` 둘 다 동일한 장소의 메모리를 참조합니다. 두 쓰기 접근이 동일한 메모리를 참조하며 서로 겹치므로, 충돌을 만듭니다.

![access the same memory](/assets/Swift/Swift-Programming-Language/Memory-Safety-self-same-memory.jpg)

### Conflicting Access to Properties (속성으로의 접근 충돌)

구조체와, 튜플, 및 열거체 같은 타입은, 구조체의 속성 또는 튜플의 원소 같이, 개별 구성 요소 값으로 이루어집니다. 이들은 값 타입이기 때문에, 어떤 조각의 값을 변경하든 값 전체를 변경하는데, 이것의 의미는 속성 하나에 대한 읽기나 쓰기 접근도 값 전체로의 읽기나 쓰기 접근을 요구한다는 겁니다. 예를 들어, 튜플의 원소에 대한 쓰기 접근이 겹치면 충돌을 만듭니다:

```swift
var playerInformation = (health: 10, energy: 20)
balance(&playerInformation.health, &playerInformation.energy)
// 에러: playerInformation 의 속성으로의 접근 충돌
```

위 예제에서, 튜플 원소에 대한 `balance(_:_:)` 호출은 충돌을 만드는데 이는 `playerInformation` 에 대한 쓰기 접근이 겹치기 때문입니다. `playerInformation.health` 와 `playerInformation.energy` 둘 다 입-출력 매개 변수로 전달하는데, 이는 함수 호출 지속 시간 동안 `balance(_:_:)` 가 이들로의 쓰기 접근을 할 필요가 있다는 의미입니다. 두 경우 모두, 튜플 원소로의 쓰기 접근은 전체 튜플로의 쓰기 접근을 요구합니다. 이게 의미하는 건 `playerInformation` 으로의 두 쓰기 접근의 지속 시간이 겹쳐서, 충돌을 일으킨다는 겁니다.

아래 코드가 보여주는 건 전역 변수에 저장한 구조체의 속성에 대한 쓰기 접근이 겹쳐도 동일한 에러가 나타난다는 겁니다.

```swift
var holly = Player(name: "Holly", health: 10, energy: 10)
balance(&holly.health, &holly.energy)   // 에러
```

사실, 구조체의 속성에 대한 대부분의 접근은 안전하게 겹칠 수 있습니다.[^safe-overlap] 예를 들어, 위 예제의 `holly` 변수를 전역 변수 대신 지역 변수로 바꾸면, 구조체에 있는 저장 속성으로의 접근 겹침이 안전하다는 걸 컴파일러가 증명할 수 있습니다:[^local-variable]

```swift
func someFunction() {
  var oscar = Player(name: "Oscar", health: 10, energy: 10)
  balance(&oscar.health, &oscar.energy)   // 괜찮음
}
```

위 예제에선, Oscar 의 체력과 에너지를 `balance(_:_:)` 의 두 입-출력 매개 변수로 전달합니다. 컴파일러는 메모리 안전성이 보존되는 걸 증명할 수 있는데 두 저장 속성은 어떤 식으로도 상호 작용하지 않기 때문입니다.

구조체의 속성에 대한 접근 겹침을 제약하는 게 메모리 안전성을 보존하는데 항상 필요한 건 아닙니다. 메모리 안전성은 보증하길 원하는 거고, 독점적 접근은 메모리 안전성보다 더 엄격한 필수 조건입니다[^stricter-requirement]-이는 어떠한 코드는 메모리로의 독점적 접근은 위반할지라도, 메모리 안전성은 보존한다는 의미입니다. 스위프트는 메모리로의 비독점적 접근이 여전히 안전함을 컴파일러가 증명할 수 있다면 이러한 메모리-안전 코드도 허용합니다. 특히, 다음 조건이 적용되면 구조체의 속성에 대한 접근이 겹치는게 안전하다는 걸 증명할 수 있습니다:

* 인스턴스의, 계산 속성이나 클래스 속성이 아닌, 저장 속성에만 접근합니다.
* 구조체가, 전역 변수가 아닌, 지역 변수의 값입니다.
* 구조체가 어떤 클로저로도 붙잡은 게 아니거나, 벗어나지 않는 클로저로만 붙잡은 것입니다.

접근이 안전하다는 걸 컴파일러가 증명하지 못하면, 접근을 허용하지 않습니다.

### 다음 장

[Access Control (접근 제어) > ]({% post_url 2020-04-28-Access-Control %})

### 참고 자료

[^Memory-Safety]: 이 글에 대한 원문은 [Memory Safety](https://docs.swift.org/swift-book/LanguageGuide/MemorySafety.html) 에서 확인할 수 있습니다.

[^Thread-Sanitizer]: '쓰레드 살균제 (thread sanitizer)' Xcode 에 포함된 도구이며, 앱에서 '자료 경쟁 (data race)' 이 일어나는 지를 찾아줍니다. '자료 경쟁 (data race)' 에 대한 더 자세한 정보는, 위키피디아의 [Race condition](https://en.wikipedia.org/wiki/Race_condition) 항목 또는 [경쟁 상태](https://ko.wikipedia.org/wiki/경쟁_상태) 항목을 보도록 합니다.

[^nonatomic]: '원자적이 아닌 접근 (nonatomic access)' 은 뒤의 본문에서 설명하는 것처럼, 'C-언어의 원자적인 연산 (atomic operations)' 이 아닌 함수로 접근하는 것을 의미합니다. '원자적 접근' 에 대해서는, 애플의 [Introducing Swift Atomics](https://swift.org/blog/swift-atomics/) 항목을 보도록 합니다.

[^man-page]: '매뉴얼 페이지 (man page)' 란 터미널에서 `man` 명령어로 해당 명령어의 매뉴얼을 출력한 페이지를 말합니다. 본문에 있는 `stdatomic(3)` 의 매뉴얼 페이지를 보려면 macOS 의 터미널에서 `$ man stdatomic` 라고 명령하면 됩니다. 해당 매뉴얼을 보면 원자적 연산은 앞에 `atomic_` 이라는 접두사가 붙는다는 걸 알 수 있습니다.

[^in-out-parameters]: '입-출력 매개 변수 (in-out parameters)' 에 대한 더 자세한 내용은, [Functions (함수)]({% post_url 2020-06-02-Functions %}) 장의 [In-Out Parameters (입-출력 매개 변수)]({% post_url 2020-06-02-Functions %}#in-out-parameters-입-출력-매개-변수) 부분을 보도록 합니다.

[^three-rules]: 즉, 앞에서 말한 충돌이 일어나는 세 가지 조건 모두에 부합합니다. 세 가지 조건 중 하나라도 해당이 안되면, 충돌은 일어나지 않습니다.

[^mutating-methods]: '변경 메소드 (mutating methods)' 에 대한 더 자세한 내용은, [Methods (메소드)]({% post_url 2020-05-03-Methods %}) 장의 [Modifying Value Types from Within Instance Methods (인스턴스 메소드 안에서 값 타입 수정하기)]({% post_url 2020-05-03-Methods %}#modifying-value-types-from-within-instance-methods-인스턴스-메소드-안에서-값-타입-수정하기) 부분을 보도록 합니다.

[^safe-overlap]: 이어지는 내용에서 설명하는 것처럼, 구조체를 지역 변수에 저장하면, 그 속성으로의 접근이 겹쳐도 컴파일러가 안전하다는 걸 증명할 수 있으면 충돌이 발생하지 않습니다.

[^local-variable]: 지역 변수에 저장하면 변수로의 접근 지속 시간이 지역 안에서만 지속하므로, 두 접근이 겹치더라도 실제로 충돌하지는 않는다는 걸 컴파일러가 검사할 수 있습니다.

[^stricter-requirement]: 메모리 안정성을 보존하기 위해 무조건 독점적 접근을 해야하는 건 아니라는 의미입니다. 
