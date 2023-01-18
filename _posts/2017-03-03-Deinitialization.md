---
layout: post
pagination:
  enabled: true
comments: true
title:  "Swift 5.7: Deinitialization (뒷정리)"
date:   2017-03-03 02:00:00 +0900
categories: Swift Language Grammar Deinitialization
redirect_from: "/swift/language/grammar/deinitialization/2017/03/02/Deinitialization.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [Deinitialization](https://docs.swift.org/swift-book/LanguageGuide/Deinitialization.html) 부분[^Deinitialization]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Deinitialization (뒷정리)

_정리자 (deinitializer)_[^deinitializer] 는 클래스 인스턴스를 해제하기 (deallocated)[^deallocated] 바로 전 호출합니다. 정리자는 `deinit` 키워드로 작성하는데, 초기자를 `init` 키워드로 작성하는 것과 비슷합니다. 정리자는 클래스 타입에서만 사용 가능합니다.

### How Deinitialization Works (뒷정리 방법)

스위프트는 인스턴스가 더 이상 필요없을 때, 자원을 풀어주고자, 자동으로 해제합니다. [Automatic Reference Counting (자동 참조 카운팅)]({% post_url 2020-06-30-Automatic-Reference-Counting %}) 에서 설명한 것처럼, 스위프트는 _자동 참조 카운팅 (ARC)_ 을 통해 인스턴스 메모리 관리를 처리합니다. 인스턴스를 해제할 때 일반적으론 수동 정리를 할 필요가 없습니다. 하지만, 자신만의 자원으로 작업할 땐, 스스로 어떠한 추가 정리를 해야할 지도 모릅니다. 예를 들어, 자신만의 클래스를 생성하여 파일을 열고 어떠한 데이터를 작성하면, 클래스 인스턴스의 해제 전에 파일을 닫아야 할 지 모릅니다.

클래스 정의에는 클래스 당 최대 하나의 정리자가 있을 수 있습니다. 정리자는 어떤 매개 변수도 취하지 않고 괄호 없이 작성합니다:

```swift
deinit {
  // 뒷정리를 함
}
```

인스턴스 해제 직전에, 자동으로 정리자를 호출합니다. 정리자를 스스로 호출하는 건 허용 안합니다. 하위 클래스는 상위 클래스 정리자를 상속하며, 하위 클래스 정리자 구현 끝에서 상위 클래스 정리자를 자동으로 호출합니다. 하위 클래스가 자신만의 정리자를 제공하지 않는 경우에도, 항상 상위 클래스 정리자를 호출합니다.

인스턴스는 자신의 정리자를 호출하고난 후 전까진 해제된 게 아니기 때문에, 정리자는 자신을 호출한 인스턴스의 모든 속성에 접근할 수 있으며 그 속성을 기초로 (닫아야 할 파일의 이름 찾아보기 같은) 자신의 동작을 수정할 수 있습니다.

### Deinitializers in Action (정리자의 실제 사례)

다음은 정리자의 실제 사례입니다. 이 예제는, 단순한 게임을 위해, `Bank` 와 `Player` 라는, 새로운 두 타입을 정의합니다. `Bank` 클래스는 가상 통화를 관리하며, 유통 과정에서 절대로 동전이 10,000 개를 넘지 않게 할 수 있습니다. 게임에선 늘 하나의 `Bank` 만 있을 수 있으므로, 타입 속성 및 메소드를 가진 클래스로 `Bank` 를 구현하여 현재 상태를 저장하고 관리합니다[^singleton]:

```swift
class Bank {
  static var coinsInBank = 10_000
  static func distribute(coins numberOfCoinsRequested: Int) -> Int {
    let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
    coinsInBank -= numberOfCoinsToVend
    return numberOfCoinsToVend
  }
  static func receive(coins: Int) {
    coinsInBank += coins
  }
}
```

`Bank` 는 자신이 현재 쥐고 있는 동전 수를 `coinsInBank` 속성으로 추적합니다. 동전의 배포와 수집을 처리하는-`distribute(coins:)` 와 `receive(coins:)` 라는-메소드 두 개도 제안합니다.

`distribute(coins:)` 메소드는 배포하기 전에 은행에 충분한 동전이 있는 지를 검사합니다. 동전이 충분치 않으면, 요청한 것보다 적은 개수를 `Bank` 가 반환 (하며 은행에 남은 동전이 없으면 0 을 반환) 합니다. 정수 값을 반환하여 실제 제공한 동전 수를 표시합니다.

`receive(coins:)` 메소드는 되돌려 받은 동전 수를 단순히 은행의 동전 창고에 더합니다.

`Player` 클래스는 게임 참가자를 설명합니다. 각각의 참가자는 언제든지 정해진 수의 동전을 지갑에 저장합니다. 참가자의 `coinsInPurse` 속성이 이를 나타냅니다:

```swift
class Player {
  var coinsInPurse: Int
  init(coins: Int) {
    coinsInPurse = Bank.distribute(coins: coins)
  }
  func win(coins: Int) {
    coinsInPurse += Bank.distribute(coins: coins)
  }
  deinit {
    Bank.receive(coins: coinsInPurse)
  }
}
```

초기화 중에 은행이 지정한 초기 허용량 만큼의 동전 수로 각 `Player` 인스턴스를 초기화하지만, 동전이 충분하지 않으면 `Player` 인스턴스가 그 보다 더 적게 받을 수도 있습니다.

`Player` 클래스는 `win(coins:)` 메소드를 정의하여, 정해진 수의 동전을 은행에서 받아서 참가자의 지갑에 더합니다. `Player` 클래스는, `Player` 클래스 해제 직전에 호출하는, 정리자도 구현합니다. 여기서, 정리자는 단순히 참가자의 모든 동전을 은행에 반환합니다:

```swift
var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// "A new player has joined the game with 100 coins" 를 인쇄함
print("There are now \(Bank.coinsInBank) coins left in the bank")
// "There are now 9900 coins left in the bank" 를 인쇄함
```

새로운 `Player` 인스턴스를 생성하면서, 동전 100 개를 쓸 수 있는지 요청합니다. 이 `Player` 인스턴스는 `playerOne` 이라는 옵셔널 `Player` 변수에 저장합니다. 여기서 옵셔널 변수를 사용하는 건, 언제든지 참가자가 게임을 떠날 수 있기 때문입니다. 옵셔널은 게임에 참가자가 현재 있는지 추적하게 해줍니다.

`playerOne` 은 옵셔널이기 때문에, `coinsInPurse` 속성에 접근하여 자신의 기본 동전 수를 인쇄할 때, 및 `winCoins(_:)` 메소드를 호출할 때마다, 느낌표 (`!`) 로 규명합니다:

```swift
playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// "PlayerOne won 2000 coins & now has 2100 coins" 를 인쇄함
print("The bank now only has \(Bank.coinsInBank) coins left")
// "The bank now only has 7900 coins left" 를 인쇄함
```

여기선, 참가자가 이겨서 동전 2,000 개를 가졌습니다. 이제 참가자의 지갑엔 동전 2,100 개가 담겨 있고, 은행엔 7,900 개의 동전만 남았습니다.

```swift
playerOne = nil
print("PlayerOne has left the game")
// "PlayerOne has left the game" 을 인쇄함
print("The bank now has \(Bank.coinsInBank) coins")
// "The bank now has 10000 coins" 를 인쇄함
```

이제 참가자가 게임을 떠났습니다. 이는, "`Player` 인스턴스의 없음" 을 의미하는, `nil` 을 옵셔널 `Player` 변수에 설정함으로써 지시합니다. 이게 발생하는 시점에, `playerOne` 변수가 `Player` 인스턴스를 참조하는 걸 끊습니다. 다른 어느 속성이나 변수도 `Player` 인스턴스를 참조하지 않으므로, 이를 해제하여 메모리를 풀어줍니다. 이게 발생하기 직전에, 자동으로 정리자를 호출하고, 동전을 은행에 반환합니다.

### 다음 장

[Optional Chaining (옵셔널 사슬) > ]({% post_url 2020-06-17-Optional-Chaining %})

### 참고 자료

[^Deinitialization]: 이 글에 대한 원문은 [Deinitialization](https://docs.swift.org/swift-book/LanguageGuide/Deinitialization.html) 에서 확인할 수 있습니다.

[^deinitializer]: '정리자 (deinitializer)' 라고 옮긴 것은 '초기자 (initializer)' 와 짝을 맞추기 위함입니다. 이는 C++ 의 '생성자 (constructor) 와 소멸자 (destructor)' 에서 착안한 것입니다. 스위프트는 '자동 참조 카운팅 (Automatic Reference Counting)' 으로 자동으로 메모리를 관리하기 때문에, 메모리의 생성이나 소멸이라는 개념이 (사실상) 거의 없습니다. 그러므로 생성자나 소멸자 같은 용어보다 초기자 및 정리자 같은 용어가 더 적합합니다.

[^deallocated]: 여기서 'deallocated' 는 메모리 해제를 말하는데, 스위프트가 앞서 말한 'ARC (Auto Reference Counting)' 로 자동으로 합니다.

[^singleton]: `Bank` 클래스는, 참조 타입이라서 복사되지 않으며, 타입 속성 및 메소드로 구현하여 개별 인스턴스를 따로 생성하지 않으므로, 싱글턴 (singleton) 에 해다합니다. 이 예제는 스위프트로 싱글턴을 구현하는 방법을 보여줍니다. 싱글턴 패턴에 대한 더 자세한 정보는 위키피디아의 [Singleton pattern](https://en.wikipedia.org/wiki/Singleton_pattern) 항목과 [싱글턴 패턴](https://ko.wikipedia.org/wiki/싱글턴_패턴) 항목을 보도록 합니다.
