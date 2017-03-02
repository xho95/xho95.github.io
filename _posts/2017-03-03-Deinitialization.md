---
layout: post
comments: true
title:  "Swift 3.1: 객체 정리하기 (Deinitialization)"
date:   2017-03-03 02:00:00 +0900
categories: Swift Language Grammar Deinitialization
---

> 이 글은 Swift 를 공부하기 위해 애플에서 공개한 [The Swift Programming Language (Swift 3.1)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/) 책의 [The Basics](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309) 부분을 번역하고 주석을 달아서 정리한 글입니다. 현재는 Swift 3.1 버전에 대해서 정리되어 있습니다.

정리자는 객체 인스턴스가 해제되기 바로 직전에 호출됩니다. [^deinitializer] 정리자는 `deinit` 키워드를 써서 작성하는데, 초기자를 `init` 키워드로 작성하는 것과 비슷합니다. 정리자는 클래스 타입에만 사용할 수 있습니다.

### 정리자의 작동 방식 (How Deinitialization Works)

Swift 는 필요없는 인스턴스를 자동으로 해제하여 리소스를 비웁니다. [^free-up] 인스턴스의 메모리 관리를 다룰 때는 자동 참조 카운팅 (ARC; automatic reference counting) 을 사용하는데 이는 [자동 참조 카운팅 (Automatic Reference Counting)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID48) 에서 설명합니다. 인스턴스가 해제될 때 보통의 경우 수동으로 정리 작업을 할 필요는 없습니다. 하지만 자신이 만든 리소스를 가지고 작업할 경우, 추가 정리 작업을 직접 해야할 수도 있습니다. 예를 들어 사용자 정의 클래스를 만들어서 파일을 열고 몇가지 데이터를 작성하는 경우, 클래스 인스턴스가 해제되기 전에 파일을 닫아햐 할 수도 있습니다.

클래스 정의는 클래스 당 최대 하나의 정리자를 가질 수 있습니다. 정리자는 매개 변수를 취하지 않으며 괄호도 사용하지 않습니다:

```swift
deinit {
    // 정리 작업을 수행합니다.
}
```

정리자는 인스턴스의 해제가 일어나기 직전에 자동으로 호출됩니다. 직접 정리자를 호출할 수는 없습니다. 상위 클래스의 정리자는 하위 클래스로 상속되며 상위 클래스의 정리자는 하위 클래스의 정리자의 구현부 끝에서 자동으로 호출됩니다. 상위 클래스의 정리자는 항상 호출되는데 심지어 하위 클래스가 정리자를 제공하지 않아도 호출됩니다.

인스턴스는 정리자의 호출이 마칠 때까지 해제되지 않으므로 정리자에서는 호출한 인스턴스의 모든 속성에 접근이 가능하며 해당 속성에 따라 작동 방식을 바꿀 수 있습니다. (가령 닫아야할 파일의 이름을 조회해 볼 수 있습니다).

### 정리자의 실제 사례 (Deinitializers in Action)

다음에 정리자의 실제 사례를 보이도록 합니다. 이 예제에서는 간단한 게임을 위해 두개의 새로운 타입인 `Bank` 와 `Player` 를 정의합니다. `Bank` 클래스는 유통량이 절대 10,000 개를 넘지 않는 가상 통화를 관리합니다. 게임에는 단 하나의 `Bank` 만이 있어서 `Bank` 는 현재 상태를 저장하고 관리하기 위한 속성과 메소드를 가진 클래스로 구현합니다:

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

`Bank` 는 현재 동전의 수를 추적하기 위해 그 값을 `coinsInBank` 속성에 담아 둡니다. 또 두 개의 메소드 — `distribute(coins:)` 와 `receive(coins:)` — 로 동전의 분배 및 수집을 처리합니다.

`distribute(coins:)` 메소드는 분배하기 전에 은행에 충분한 동전이 있는지를 검사합니다. 충분한 동전이 없으면 `Bank` 는 요청받은 수보다 적은 수를 반환합니다. (은행에 동전이 하나도 남아 있지 않으면 0 을 반환합니다). 이것은 실제 제공되는 동전의 수를 나타내기 위해 정수 값으로 반환합니다.

`receive(coins:)` 메소드는 단순히 받은 동전의 수를 은행의 동전 창고에  다시 더합니다.

`Player` 클래스는 게임내에서 플레이어를 묘사합니다. 각각의 플레이어는 언제든지 일정 수의 동전을 지갑에 가지고 있을 수 있습니다. 이것은 플레이어의 `coinsInPurse` 속성으로 표현됩니다:

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

각각의 `Player` 인스턴스는 초기화될 때 은행에서 최초 할당량으로 지정한 수의 동전으로 초기화되며 동전이 충분하지 않을 경우 어떤 `Player` 인스턴스는 그보다 적게 받을 수도 있습니다.

`Player` 클래스는 `win(coins:)` 메소드를 정의하고 있는데, 이것은 은행에서 특정 수의 동전을 받아서 플레이어의 지갑에 더합니다. `Player` 클래스는 정리자도 구현해서 `Player` 인스턴스가 해제될 때 호출되도록 합니다. 여기서 정리자는 단순히 플레이어의 모든 동전을 은행에 반환합니다:

```swift
var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// Prints "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// Prints "There are now 9900 coins left in the bank"
```

새로운 `Player` 인스턴스가 생성되면서 가능하다면 100 개의 동전을 요구할 수 있습니다. 이 `Player` 인스턴스는 `playerOne` 이라는 옵셔널 `Player` 변수에 저장됩니다. 여기서 옵셔널이 사용되는데 왜냐면 플레이어는 언제든 게임을 떠날 수 있기 때문입니다. 옵셔널은 현재 플레이어가 게임내에 있는지 여부를 추적할 수 있게 합니다.

`playerOne` 은 옵셔널이므로 기본 코인 수를 출력하기 위해 `coinsInPurse` 속성에 접근할 때나 `winCoins(_:)` 메소드가 호출될 때마다 느낌표 (`!`) 를 써서 접근 권한을 취득해야 합니다:

```swift
playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// Prints "PlayerOne won 2000 coins & now has 2100 coins"
print("The bank now only has \(Bank.coinsInBank) coins left")
// Prints "The bank now only has 7900 coins left"
```

위에서 플레이어는 2,000 개의 동전을 획득했습니다. 플레이어의 지갑에는 이제 2,100 개의 동전이 있으며 은행에는 7,900 개의 동전만이 남아 있습니다.

```swift
playerOne = nil
print("PlayerOne has left the game")
// Prints "PlayerOne has left the game"
print("The bank now has \(Bank.coinsInBank) coins")
// Prints "The bank now has 10000 coins"
```

이제 플레이어가 게임을 떠났습니다. 이것은 옵셔널인 `playerOne` 변수를 “`Player` 인스턴스가 없음” 을 의미하는 `nil` 로 설정해서 표시합니다. 이 시점에서 `Player` 인스턴스에 대한 `playerOne` 변수의 참조가 끊어집니다. `Player` 인스턴스를 참조하고 있는 다른 속성이나 변수가 없으므로 메모리를 비우기 위해 해제가 일어납니다. 이 작업이 일어나기 직전에 정리자가 자동으로 호출되고 코인을 은행으로 반환합니다.

### 원문 자료

* [Deinitialization](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/Deinitialization.html#//apple_ref/doc/uid/TP40014097-CH19-ID142) : [The Swift Programming Language (Swift 3.1)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/) 자료입니다.

### 관련 자료

* [Swift: 리눅스에서 Swift 개발 환경 구축하기](http://xho95.github.io/linux/development/swift/package/install/2017/02/19/Developing-Swift-on-Linux.html)

* [Swift 3.1: 빠르게 둘러보기 (A Swift Tour)](http://xho95.github.io/xcode/swift/grammar/tour/2016/04/17/A-Swift-Tour.html)
* [Swift 3.1: 기초 (The Basics)](http://xho95.github.io/swift/grammar/basic/2016/04/24/The-Basics.html)

### 참고 자료

[^deinitializer]: 'deinitializer' 는 '정리자'라고 옮깁니다.

[^free-up]: 'free up'은 '비우다'로 옮기는데 좀 더 확인해야 합니다.
