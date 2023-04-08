---
layout: post
comments: true
title:  "Deinitialization (뒷정리)"
date:   2017-03-03 02:00:00 +0900
categories: Swift Language Grammar Deinitialization
redirect_from: "/swift/language/grammar/deinitialization/2017/03/02/Deinitialization.html"
---

{% include header_swift_book.md %}

## Deinitialization (뒷정리)

_정리자 (deinitializer)_[^deinitializer] 는 클래스 인스턴스가 해제되기[^deallocated] 바로 전에 호출됩니다. 정리자는 `deinit` 키워드로 작성하는데, 초기자가 `init` 키워드로 작성되는 것과 비슷합니다. 정리자는 클래스 타입에서만 쓸 수 있습니다.

### How Deinitialization Works (뒷정리 방법)

스위프트는 인스턴스가 더 이상 필요없을 때 이를 자동으로 해제하여, 자원을 풀어줍니다. 스위프트는 인스턴스의 메모리 관리를 _자동 참조 카운팅 (ARC)_ 을 통해서 하는데, 이는 [Automatic Reference Counting (자동 참조 카운팅)]({% link docs/swift-books/swift-programming-language/automatic-reference-counting.md %}) 에서 설명합니다. 일반적으로 인스턴스를 해제할 때는 수동으로 정리할 필요가 없습니다. 하지만, 자신만의 자원을 가지고 작업할 땐, 어떤 추가적인 정리를 하는게 필요할지도 모릅니다. 예를 들어, 파일을 열고 거기다 어떤 데이터를 쓰는 자신만의 클래스를 생성한다면, 클래스 인스턴스를 해제하기 전에 파일 닫기가 필요할지도 모릅니다.

클래스 정의에는 클래스마다 최대 한 개의 정리자가 있을 수 있습니다. 정리자는 어떤 매개 변수도 입력 받지 않으며 괄호 없이 작성합니다:

```swift
deinit {
  // 뒷정리를 함
}
```

정리자는, 인스턴스 해제 직전에, 자동으로 호출됩니다. 정리자 그 자체를 호출하는 건 안됩니다. 상위 클래스의 정리자는 하위 클래스가 물려받으며, 상위 클래스 정리자는 하위 클래스 정리자의 구현 끝에서 자동으로 호출됩니다. 상위 클래스의 정리자는 항상 호출되는데, 심지어 하위 클래스가 그 자신만의 정리자를 제공하지 않더라도 그렇습니다.

인스턴스는 정리자가 호출된 후에도 해제된 건 아니기 때문에, 정리자가 자신을 호출한 인스턴스의 모든 속성에 접근하는 것도 되고 그 속성을 기초로 하여 동작을 수정하는 (닫아야 할 파일의 이름 찾아보기 같은) 것도 됩니다.

### Deinitializers in Action (정리자의 실제 사례)

정리자의 실제 사례는 이렇습니다. 이 예제에서 정의하는 두 개의 새로운 타입인, `Bank` 와 `Player` 는, 단순한 게임을 위한 겁니다. `Bank` 클래스는 가상 통화를 관리하는데, 유통 과정에서 절대로 동전이 10,000 개를 넘지 않게 할 수 있습니다. 게임에선 늘 하나의 `Bank` 만 있을 수 있어서, `Bank` 는 타입 속성과 메소드를 가진 클래스로 현재 상태를 저장하고 관리하도록 구현됩니다[^singleton]:

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

`Bank` 는 자신이 들고 있는 동전의 현재 개수를 `coinsInBank` 속성으로 추적합니다. 두 개의 메소드인-`distribute(coins:)` 와 `receive(coins:)`-도 제안하여 동전의 배포와 수집을 처리하게 합니다.

`distribute(coins:)` 메소드는 동전을 배포하기 전에 은행에 충분하게 있는지부터 검사합니다. 동전이 충분하지 않으면, `Bank` 가 요청된 것보다 더 적은 수를 반환 (하며 은행에 동전이 남은게 없으면 0 을 반환) 합니다. 정수 값을 반환하여 실제로 제공한 동전의 개수를 지시합니다.

`receive(coins:)` 메소드는 돌려 받은 동전 개수를 단순히 은행의 동전 저장고에 더합니다.

`Player` 클래스는 게임의 플레이어를 설명합니다. 각 플레이어의 지갑 속엔 언제든지 특정 개수의 동전이 저장되어 있습니다. 이는 플레이어의 `coinsInPurse` 속성으로 나타냅니다:

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

각각의 `Player` 인스턴스는 초기화 중에 은행이 지정한 초기 허용 동전 개수 만큼 초기화되지만, 쓸 수 있는 동전이 충분치 않으면 `Player` 인스턴스가 그 보다 더 적게 받을 수도 있습니다.

`Player` 클래스는 `win(coins:)` 메소드도 정의하는데, 이는 은행에서 특정 개수의 동전을 받아서 플레이어의 지갑에 더합니다. `Player` 클래스는 정리자도 구현하며, 이는 `Player` 인스턴스가 해제되기 직전에 호출됩니다. 여기서, 정리자는 플레이어의 모든 동전을 단순히 은행에 반환합니다:

```swift
var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// "A new player has joined the game with 100 coins" 를 인쇄함
print("There are now \(Bank.coinsInBank) coins left in the bank")
// "There are now 9900 coins left in the bank" 를 인쇄함
```

새로운 `Player` 인스턴스를 생성하면서, 동전 100 개가 가능한지 요청합니다. 이 `Player` 인스턴스는 옵셔널 `Player` 변수인 `playerOne` 에 저장됩니다. 여기서 옵셔널 변수를 쓰는 건, 플레이어가 언제든지 게임을 떠날 수 있기 때문입니다. 옵셔널은 게임에 현재 플레이어가 있는지 추적하게 해줍니다.

`playerOne` 이 옵셔널이기 때문에, `coinsInPurse` 속성에 접근하여 기본 동전 개수를 인쇄할 때와, `winCoins(_:)` 메소드를 호출할 때마다, 소속을 밝히면서 느낌표 (`!`) 를 붙입니다:

```swift
playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// "PlayerOne won 2000 coins & now has 2100 coins" 를 인쇄함
print("The bank now only has \(Bank.coinsInBank) coins left")
// "The bank now only has 7900 coins left" 를 인쇄함
```

여기서, 플레이어가 이겨 동전 2,000 개를 가집니다. 플레이어의 지갑엔 이제 동전 2,100 개가 담기고, 은행엔 동전 7,900 개만 남습니다.

```swift
playerOne = nil
print("PlayerOne has left the game")
// "PlayerOne has left the game" 을 인쇄함
print("The bank now has \(Bank.coinsInBank) coins")
// "The bank now has 10000 coins" 를 인쇄함
```

플레이어가 이제 막 게임을 떠났습니다. 이는 옵셔널 `Player` 변수에 `nil` 을 설정하여 지시하는데, "아무런 `Player` 인스턴스도 없음" 을 의미합니다. 이게 발생하는 시점에, `playerOne` 변수가 `Player` 인스턴스로 참조하고 있는 걸 끊습니다. 다른 어느 속성이나 변수도 `Player` 인스턴스를 참조하지 않으므로, 이를 해제하고 메모리를 풀어줍니다. 이게 발생하기 직전에, 정리자가 자동으로 호출되며, 동전이 은행으로 반환됩니다.

### 다음 장

[Optional Chaining (옵셔널 사슬) >]({% link docs/swift-books/swift-programming-language/optional-chaining.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [Deinitialization](https://docs.swift.org/swift-book/LanguageGuide/Deinitialization.html) 에서 볼 수 있습니다.

[^deinitializer]: '정리자 (deinitializer)' 라고 옮긴 것은 '초기자 (initializer)' 와 짝을 맞추기 위함입니다. 이는 C++ 의 '생성자 (constructor) 와 소멸자 (destructor)' 에서 착안한 것입니다. 스위프트는 '자동 참조 카운팅 (Automatic Reference Counting)' 으로 자동으로 메모리를 관리하기 때문에, 메모리의 생성이나 소멸이라는 개념이 (사실상) 거의 없습니다. 그러므로 생성자나 소멸자 같은 용어보다 초기자 및 정리자 같은 용어가 더 적합합니다.

[^deallocated]: 여기서 'deallocated' 는 메모리 해제를 말하는데, 스위프트가 앞서 말한 'ARC (Auto Reference Counting)' 로 자동으로 합니다.

[^singleton]: `Bank` 클래스는, 참조 타입이라서 복사되지 않으며, 타입 속성 및 메소드로 구현하여 개별 인스턴스를 따로 생성하지 않으므로, 싱글턴 (singleton) 에 해당합니다. 이 예제는 스위프트로 싱글턴을 구현하는 방법을 보여줍니다. 싱글턴 패턴에 대한 더 자세한 정보는 위키피디아의 [Singleton pattern](https://en.wikipedia.org/wiki/Singleton_pattern) 항목과 [싱글턴 패턴](https://ko.wikipedia.org/wiki/싱글턴_패턴) 항목을 보도록 합니다.
