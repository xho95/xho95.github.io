---
layout: post
comments: true
title:  "Swift 5.5: Deinitialization (뒷정리)"
date:   2017-03-03 02:00:00 +0900
categories: Swift Language Grammar Deinitialization
redirect_from: "/swift/language/grammar/deinitialization/2017/03/02/Deinitialization.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Deinitialization](https://docs.swift.org/swift-book/LanguageGuide/Deinitialization.html) 부분[^Deinitialization]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Deinitialization (뒷정리)

_정리자 (deinitializer)_[^deinitializer] 는 클래스 인스턴스를 해제하기 (deallocated)[^deallocated] 바로 전 호출합니다. 정리자는 `deinit` 키워드로 작성하는데, 초기자를 `init` 키워드로 작성하는 것과 비슷합니다. 정리자는 클래스 타입에서만 사용 가능합니다.

### How Deinitialization Works (정리자의 작동 방식)

스위프트는, 자원을 확보하기 위해, 인스턴스가 더 이상 필요 없을 때 자동으로 해제합니다. 스위프트는, [Automatic Reference Counting (자동 참조 카운팅)]({% post_url 2020-06-30-Automatic-Reference-Counting %}) 에서 설명한 것처럼, '자동 참조 카운팅 (ARC)' 을 통해 인스턴스의 메모리를 관리합니다. 일반적으로 인스턴스를 해제할 때 수동으로 정리할 필요는 없습니다. 하지만, 자신만의 자원을 가지고 작업할 때는, 몇몇 추가적인 정리를 직접 해야할 필요가 있을 수도 있습니다. 예를 들어, 파일을 열고 어떤 자료를 작성하는 사용자 정의 클래스를 생성한 경우, 클래스 인스턴스를 해제하기 전에 파일을 닫을 필요가 있습니다.

'클래스 정의' 는 클래스 당 최대 하나의 '정리자' 를 가질 수 있습니다. 정리자는 어떤 매개 변수도 취하지 않으며 괄호 없이 작성합니다:

```swift
deinit {
  // 뒷정리를 수행합니다.
}
```

정리자는, 인스턴스 해제가 일어나기 직전에, 자동으로 호출됩니다. 정리자를 직접 호출하는 것은 허용하지 않습니다. 상위 클래스의 정리자는 하위 클래스로 상속되며, 상위 클래스 정리자는 하위 클래스 정리자의 구현 끝에서 자동으로 호출됩니다. 상위 클래스 정리자는, 하위 클래스가 자신만의 정리자를 제공하지 않더라도, 항상 호출됩니다.

인스턴스는 정리자를 호출한 후까지 해제되지 않기 때문에, 정리자는 자신을 호출한 인스턴스의 모든 속성에 접근할 수 있으며 해당 속성을 기초로 (닫아야할 파일의 이름을 찾아보는 것 같이) 작동 방식을 수정할 수 있습니다.

### Deinitializers in Action (정리자의 실제 사례)

다음은 정리자의 실제 사례입니다. 이 예제는, 단순한 게임을 위해, `Bank` 와 `Player` 라는, 두 개의 새로운 타입을 정의합니다. `Bank` 클래스는, 유통 과정에서 동전이 절대로 10,000 개를 넘지 않는, '가상 통화' 를 관리합니다. 게임에는 늘 하나의 `Bank` 만 있을 수 있으므로, 현재 상태를 저장하고 관리하기 위해 `Bank` 를 타입 속성과 메소드를 가진 클래스로 구현합니다[^singleton]:

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

`Bank` 는 현재 보유한 동전 수를 `coinsInBank` 속성으로 추적합니다. 이는 동전의 배포와 수집을 처리하는-`distribute(coins:)` 와 `receive(coins:)` 라는-두 개의 메소드도 제안합니다.

`distribute(coins:)` 메소드는 배포 전에 은행에 동전이 충분히 있는지 검사합니다. 동전이 충분하지 않으면, `Bank` 는 요청한 개수보다 적은 수를 반환 (하고 은행에 남은 동전이 없으면 '0' 을 반환) 합니다. 실제 제공된 동전 수를 표시하고자 '정수 값' 을 반환합니다.

`receive(coins:)` 메소드는 받은 동전 수를 은행의 '동전 창고' 에 다시 단순히 더합니다.

`Player` 클래스는 게임의 '참여자' 를 설명합니다. 각 참여자는 지갑에 언제든지 정해진 수의 동전을 저장합니다. 이는 참여자의 `coinsInPurse` 속성으로 표현합니다:

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

각 `Player` 인스턴스는 초기화 동안 은행으로부터 '최초 할당량' 이라는 지정한 동전 수로 초기화되는데, 동전이 충분하지 않으면 `Player` 인스턴스가 해당 수보다 적게 받을 수도 있습니다.

`Player` 클래스는, 은행으로부터 정해진 수의 동전을 받고 이를 참여자의 지갑에 더하는, `win(coins:)` 메소드를 정의합니다. `Player` 클래스는, `Player` 클래스를 해제하기 직전에 호출되는, '정리자' 도 구현합니다. 여기서, 정리자는 단순히 참여자의 모든 동전을 은행에 반환합니다:

```swift
var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// "A new player has joined the game with 100 coins" 를 인쇄합니다.
print("There are now \(Bank.coinsInBank) coins left in the bank")
// "There are now 9900 coins left in the bank" 를 인쇄합니다.
```

새로운 `Player` 인스턴스를 생성하면서, 동전 '100' 개가 가능한지 요청합니다. 이 `Player` 인스턴스를 `playerOne` 이라는 '옵셔널 `Player` 변수' 에 저장합니다. 여기서 옵셔널 변수를 사용한 것은, 참여자가 언제든지 게임을 떠날 수 있기 때문입니다. 옵셔널은 게임에 현재 참여자가 있는지를 추적하게 해줍니다.

`playerOne` 이 옵셔널이기 때문에, `coinsInPurse` 속성에 접근하여 기본 동전 수를 출력할 때, 그리고 `winCoins(_:)` 메소드를 호출할 때마다, 느낌표 (`!`) 로 '규명 (qualified)' 합니다.:

```swift
playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// "PlayerOne won 2000 coins & now has 2100 coins" 를 인쇄합니다.
print("The bank now only has \(Bank.coinsInBank) coins left")
// "The bank now only has 7900 coins left" 를 인쇄합니다.
```

여기서, 참여자가 이겨서 동전 '2,000' 개를 손에 넣었습니다. 참여자의 지갑에는 이제 동전 '2,100' 개가 담겨 있고, 은행에는 '7,900' 개의 동전만이 남아 있습니다.

```swift
playerOne = nil
print("PlayerOne has left the game")
// "PlayerOne has left the game" 을 인쇄합니다.
print("The bank now has \(Bank.coinsInBank) coins")
// "The bank now has 10000 coins" 를 인쇄합니다.
```

참여자가 이제 게임을 떠났습니다. 이는 '옵셔널 `Player` 변수에, "`Player` 인스턴스가 없음" 을 의미하는, `nil` 을 설정함으로써 지시합니다. 이것이 일어나는 시점에, `Player` 인스턴스에 대한 `playerOne` 변수의 참조가 끊어집니다. 다른 어느 속성이나 변수도 `Player` 인스턴스를 참조하지 않으므로, 메모리 확보를 위해 해제됩니다. 이것이 일어나기 직전에, 정리자를 자동으로 호출하여, 동전을 은행으로 반환합니다.

### 다음 장

[Optional Chaining (옵셔널 연쇄) > ]({% post_url 2020-06-17-Optional-Chaining %})

### 참고 자료

[^Deinitialization]: 이 글에 대한 원문은 [Deinitialization](https://docs.swift.org/swift-book/LanguageGuide/Deinitialization.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^deinitializer]: '정리자 (deinitializer)' 라고 옮긴 것은 '초기자 (initializer)' 와 짝을 맞추기 위함입니다. 이는 C++ 의 '생성자 (constructor) 와 소멸자 (destructor)' 에서 착안한 것입니다. 스위프트는 '자동 참조 카운팅 (Automatic Reference Counting)' 으로 자동으로 메모리를 관리하기 때문에, 메모리의 생성이나 소멸이라는 개념이 (사실상) 거의 없습니다. 그러므로 생성자나 소멸자 같은 용어보다 초기자 및 정리자 같은 용어가 더 적합합니다.

[^deallocated]: 여기서 'deallocated' 는 메모리 해제를 말하는데, 스위프트가 앞서 말한 'ARC (Auto Reference Counting)' 로 자동으로 합니다.

[^singleton]: `Bank` 클래스는, 참조 타입인 클래스라서 복사가 일어나지 않으며, 타입 속성과 메소드로 구현되어 개별 인스턴스를 따로 생성하지 않으므로, '싱글턴 (singleton) 패턴' 에 해당합니다. 사실 `Bank` 클래스는 스위프트에서 '싱글턴 패턴' 을 구현하는 방법을 보여주는 것입니다. '싱글턴 패턴' 에 대한 더 자세한 정보는 위키피디아의 [Singleton pattern](https://en.wikipedia.org/wiki/Singleton_pattern) 과 [싱글턴 패턴](https://ko.wikipedia.org/wiki/싱글턴_패턴) 항목을 참고하기 바랍니다.
