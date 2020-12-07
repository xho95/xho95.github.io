---
layout: post
comments: true
title:  "Swift 5.3: Deinitialization (객체 정리)"
date:   2017-03-03 02:00:00 +0900
categories: Swift Language Grammar Deinitialization
redirect_from: "/swift/language/grammar/deinitialization/2017/03/02/Deinitialization.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Deinitialization](https://docs.swift.org/swift-book/LanguageGuide/Deinitialization.html) 부분[^Deinitialization]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 전체 번역은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Deinitialization (객체 정리)

_정리자 (deinitializer)_[^deinitializer] 는 객체 인스턴스가 해제 (deallocated)[^deallocated] 되기 바로 전에 호출됩니다. '정리자' 는 `deinit` 키워드로 작성하며, '초기자 (initializer)' 를 `init` 키워드로 작성하는 것과 비슷하다고 보면 됩니다. '정리자' 는 '클래스 타입 (class types)' 에만 사용 가능합니다.[^class-types]

### How Deinitialization Works (정리자의 작동 방식)

스위프트는 자원을 확보하기 위해 필요 없는 인스턴스는 자동으로 해제합니다.[^free-up] 스위프트에서 인스턴스의 메모리 관리를 처리하는 곳은 '자동 참조 카운팅 (ARC; automatic reference counting)' 이며, 이는 [Automatic Reference Counting (자동 참조 카운팅)]({% post_url 2020-06-30-Automatic-Reference-Counting %}) 에서 설명하도록 합니다. 일반적으로는 인스턴스가 해제된다고 해서 정리 작업을 수동으로 따로 할 일은 없습니다. 하지만, 작업하면서 자기 자신의 자원을 사용하는 경우, 직접 추가 정리 작업을 해야할 수도 있습니다. 예를 들어, 직접 만든 클래스로 어떤 파일을 열고 거기다 뭔가를 썼을 경우, 클래스 인스턴스가 해제되기 전에 그 파일을 직접 닫을 필요가 있습니다.

'클래스 정의 (class definitions)' 는 클래스 당 최대 한 개의 '정리자' 만 가집니다. 정리자는 매개 변수를 가지지 않아서 괄호도 쓰지 않습니다:

```swift
deinit {
    // 여기서 정리 작업을 수행합니다.
}
```

정리자는 인스턴스의 해제가 일어나기 바로 전에 자동으로 호출됩니다. 정리자를 직접 호출하는 것은 안됩니다. '상위 클래스 (supperclass)' 의 정리자는 '하위 클래스 (subclasses)' 로 상속되며, '상위 클래스 정리자' 는 '하위 클래스 정리자' 의 구현부 끝에서 자동으로 호출됩니다. '상위 클래스 정리자' 는 항상 호출되는 것으로, 심지어 하위 클래스가 자신의 정리자를 제공하지 않는 경우에도 호출됩니다.

정리자의 호출이 끝나기 전에는 인스턴스가 해제되지 않으므로, 정리자는 자기를 호출한 인스턴스의 모든 속성에 접근할 수 있으며 해당 속성에 기초하여 행동을 수정할 수 있습니다. (가령 닫아야 할 파일을 이름으로 조회하는 것 등이 가능합니다.)

### Deinitializers in Action (정리자의 실제 사례)

다음 예제는 정리자의 실제 사례입니다. 이 예제에서는 간단한 게임을 위해 두개의 새로운 타입인 `Bank` 와 `Player` 를 정의했습니다. `Bank` 클래스는 가상의 통화를 관리하는데 유통되는 동전이 절대로 10,000 개를 넘지 않도록 합니다. 이 게임에는 단 하나의 `Bank` 만 있으므로, `Bank` 는 '타입 속성' 과 '타입 메소드' 를 가지는 클래스로 구현하여 현재 상태를 저장하고 관리합니다[^Bank-class]:

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

`Bank` 에는 현재 보유하고 있는 동전 수를 추적하기 위한 `coinsInBank` 이 있습니다. 또 동전의 분배와 수집을 처리하기 위한 두 개의 메소드 (`distribute(coins:)` 와 `receive(coins:)`) 를 제공합니다.

`distribute(coins:)` 메소드는 분배하기 전에 은행에 동전이 충분히 있는 지 검사합니다. 동전이 충분하지 않으면, `Bank` 는 요청받은 개수보다 적은 개수를 반환합니다. (은행에 남은 동전이 없으면 0 을 반환합니다). 반환하는 정수 값은 실제 제공되는 동전의 수를 나타냅니다.

`receive(coins:)` 메소드는 받은 동전의 개수를 다시 은행의 동전 창고 (store) 에 더하는 것으로 끝납니다.

`Player` 클래스는 게임에 있는 '참여자 (player)' 를 묘사합니다. 각각의 참여자는 언제든지 지갑에 일정 수의 동전을 저장할 수 있습니다. 이는 참여자의 `coinsInPurse` 속성으로 나타냅니다:

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

각 `Player` 인스턴스는 초기화할 때 은행에서 지정한 동전 개수만큼의 '초기 할당량 (staring allowance)' 으로 초기화 되는데, 동전이 충분하지 않으면 특정 `Player` 인스턴스는 그보다 적은 개수를 가지게 될 수도 있습니다.

`Player` 클래스는 `win(coins:)` 메소드를 정의하여, 은행에서 받은 특정 개수의 동전을 자기 지갑에 더합니다. `Player` 클래스는 '정리자' 도 구현하며, 이는 `Player` 인스턴스가 해제되기 바로 직전에 호출됩니다. 여기서 정리자는 단순히 자신의 모든 동전을 은행에 반환합니다:

```swift
var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// "A new player has joined the game with 100 coins" 를 출력합니다.
print("There are now \(Bank.coinsInBank) coins left in the bank")
// "There are now 9900 coins left in the bank" 를 출력합니다.
```

새로운 `Player` 인스턴스를 생성하면서, 동전 100개가 가능한 지 요청합니다. 이어서 이 `Player` 인스턴스를 `playerOne` 이라는 '옵셔널 (optional) `Player`' 변수에 저장합니다. 여기서 옵셔널 변수를 사용했는데, 참여자는 언제든지 게임을 떠날 수 있기 때문입니다. 옵셔널을 사용하면 현재 게임에 참여자가 있는지 없는지를 추적할 수 있습니다.

`playerOne` 은 옵셔널이므로, `coinsInPurse` 속성에 접근해서 동전의 개수를 출력할 때나, `winCoins(_:)` 메소드를 호출할 때마다, 느낌표 (`!`) 를 붙여서 자격을 갖춰야 합니다:

```swift
playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// "PlayerOne won 2000 coins & now has 2100 coins" 를 출력합니다.
print("The bank now only has \(Bank.coinsInBank) coins left")
// "The bank now only has 7900 coins left" 를 출력합니다.
```

참여자가 승리해서 동전 2,000 개를 획득했습니다. 이제 참여자의 지갑에는 동전이 2,100 개 있으며, 은행에 남은 동전은 7,900 개 입니다.

```swift
playerOne = nil
print("PlayerOne has left the game")
// "PlayerOne has left the game" 을 출력합니다.
print("The bank now has \(Bank.coinsInBank) coins")
// "The bank now has 10000 coins" 를 출력합니다.
```

참여자가 방금 막 게임을 떠났습니다. 이는 '옵셔널 `playerOne`' 변수를 (“`Player` 인스턴스가 없음” 을 의미하는) `nil` 로 설정하여 표현합니다. 이렇게 하면, `Player` 인스턴스를 가리키는 `playerOne` 변수의 참조가 끊어집니다. 어떤 다른 속성이나 변수도 `Player` 인스턴스를 참조하지 않으므로, 메모리 자원을 확보하기 위해 해제됩니다. 이 일이 일어나기 바로 전에, 정리자가 자동으로 호출되며, 동전은 은행으로 반환됩니다.

### 참고 자료

[^Deinitialization]: 이 글에 대한 원문은 [Deinitialization](https://docs.swift.org/swift-book/LanguageGuide/Deinitialization.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^deinitializer]: 스위프트의 'deinitializer' 는 '정리자' 라는 말로 옮겼는데, 'initializer' 를 '초기자' 라고 옮긴 것과 짝을 맞추기 위함입니다. 이는 C++ 언어에서 'constructor' 를 '생성자', 'destructor' 를 '소멸자' 라고 부르는 것에서 착안한 말입니다. 스위프트는 '자동 참조 카운팅 (Automatic Reference Counting)' 이 메모리 관리를 자동으로 해주기 때문에, 개발자가 직접 메모리 관리를 할 일이 드물어서, 메모리 '생성' 이나 '소멸' 이라는 개념은 사실상 없습니다. 그래서 '소멸자' 라는 말을 사용하는 것은 어울리지 않아서, 변수나 상수가 사라지기 전에 '정리' 작업을 할 필요가 있다는 의미로 '정리자' 라고 옮기도록 합니다.

[^deallocated]: 여기서의 'deallocated' 는 메모리상에서의 해제를 말하며, 스위프트에서는 'Auto Reference Counting' 에 의해 자동으로 이루어집니다.

[^class-types]: 이것이 이 글의 제목인 'deinitialization' 을 '정리하기' 가 아니라 '객체 정리하기' 라고 옮긴 이유입니다. '정리' 의 대상은 'class' 일 때만 가능함을 알 수 있습니다.

[^free-up]: 여기서 자원을 'free up' 하는 것을 운영 체제의 관점에서 자원을 '확보한다' 는 말로 옮겼습니다.

[^Bank-class]: 이 예제에서의 `Bank` 클래스는 'singleton (싱글턴)' 이라고 볼 수 있습니다.
