---
layout: post
comments: true
title:  "Swift 5.2: Deinitialization (객체 정리하기)"
date:   2017-03-03 02:00:00 +0900
categories: Swift Language Grammar Deinitialization
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Deinitialization](https://docs.swift.org/swift-book/LanguageGuide/Deinitialization.html) 부분[^Deinitialization]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Deinitialization (객체 정리하기)

_정리자 (deinitializer)_[^deinitializer] 는 객체 인스턴스가 해제 (deallocated)[^deallocated] 되기 바로 전에 호출됩니다. '정리자' 는 `deinit` 키워드로 작성하며, '초기자 (initializer)' 를 `init` 키워드로 작성하는 것과 비슷하다고 보면 됩니다. '정리자' 는 '클래스 타입 (class types)' 에만 사용 가능합니다.[^class-types]

### How Deinitialization Works (정리자의 작동 방식)

스위프트는 자원을 확보하기 위해 필요 없는 인스턴스는 자동으로 해제합니다.[^free-up] 스위프트에서 인스턴스의 메모리 관리를 처리하는 곳은 '자동 참조 카운팅 (ARC; automatic reference counting)' 이며, 이는 [Automatic Reference Counting (자동 참조 카운팅)](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html) 에서 설명하도록 합니다. 일반적으로는 인스턴스가 해제된다고 해서 정리 작업을 수동으로 따로 할 일은 없습니다. 하지만, 작업하면서 자기 자신의 자원을 사용하는 경우, 직접 추가 정리 작업을 해야할 수도 있습니다. 예를 들어, 직접 만든 클래스로 어떤 파일을 열고 거기다 뭔가를 썼을 경우, 클래스 인스턴스가 해제되기 전에 그 파일을 직접 닫을 필요가 있습니다.

'클래스 정의 (class definitions)' 는 클래스 당 최대 한 개의 '정리자' 만 가집니다. 정리자는 매개 변수를 가지지 않아서 괄호도 쓰지 않습니다:

```swift
deinit {
    // 여기서 정리 작업을 수행합니다.
}
```

정리자는 인스턴스의 해제가 일어나기 바로 전에 자동으로 호출됩니다. 정리자를 직접 호출하는 것은 안됩니다. '상위 클래스 (supperclass)' 의 정리자는 '하위 클래스 (subclasses)' 로 상속되며, '상위 클래스 정리자' 는 '하위 클래스 정리자' 의 구현부 끝에서 자동으로 호출됩니다. '상위 클래스 정리자' 는 항상 호출되는 것으로, 심지어 하위 클래스가 자신의 정리자를 제공하지 않는 경우에도 호출됩니다.

정리자의 호출이 끝나기 전에는 인스턴스가 해제되지 않으므로, 정리자는 자기를 호출한 인스턴스의 모든 속성에 접근할 수 있으며 해당 속성에 기초하여 행동을 수정할 수 있습니다. (가령 닫아야 할 파일을 이름으로 조회하는 것 등이 가능합니다.)

### Deinitializers in Action (정리자의 실제 사례)

다음의 예제는 정리자의 실제 사례입니다. 이 예제에서는 간단한 게임을 위해 두개의 새로운 타입인 `Bank` 와 `Player` 를 정의했습니다. `Bank` 클래스는 유통량이 절대 10,000 개를 넘지 않는 가상 통화를 관리합니다. 게임에는 단 하나의 `Bank` 만이 있어서 `Bank` 는 현재 상태를 저장하고 관리하기 위한 속성과 메소드를 가진 클래스로 구현합니다:

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

* [Swift 3.1: 빠르게 둘러보기 (A Swift Tour)](http://xho95.github.io/swift/language/grammar/tour/2016/04/17/A-Swift-Tour.html)
* [Swift 3.1: 기초 (The Basics)](http://xho95.github.io/swift/language/grammar/basic/2016/04/24/The-Basics.html)

### 참고 자료

[^Deinitialization]: 이 글에 대한 원문은 [Deinitialization](https://docs.swift.org/swift-book/LanguageGuide/Deinitialization.html) 에서 확인할 수 있습니다.

[^deinitializer]: 스위프트의 'deinitializer' 는 '정리자' 라는 말로 옮겼는데, 'initializer' 를 '초기자' 라고 옮긴 것과 짝을 맞추기 위함입니다. 이는 C++ 언어에서 'constructor' 를 '생성자', 'destructor' 를 '소멸자' 라고 부르는 것에서 착안한 말입니다. 스위프트는 메모리 관리를 자동으로 알아서 해주는 언어라서 개발자가 직접 메모리 관리를 하지 않으므로 메모리 '생성' 이나 '소멸' 이라는 개념은 없습니다. 대신 스위프트에는 변수나 상수를 사용하려면 그전에 반드시 '초기화' 를 해줘야 합니다. 그리고 변수나 상수가 사라지기 전에 '초기화' 했던 자원을 정리할 필요가 있습니다. 이것이 '초기자', '정리자' 라는 단어를 선택한 이유입니다.

[^deallocated]: 여기서의 'deallocated' 는 메모리상에서의 해제를 말하며, 스위프트에서는 'Auto Reference Counting' 에 의해 자동으로 이루어집니다.

[^class-types]: 이것이 이 글의 제목인 'deinitialization' 을 '정리하기' 가 아니라 '객체 정리하기' 라고 옮긴 이유입니다. '정리' 의 대상은 'class' 일 때만 가능함을 알 수 있습니다.
