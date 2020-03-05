---
layout: post
comments: true
title:  "Swift 3.1: 품어진 타입 (Nested Types)"
date:   2017-03-03 02:00:00 +0900
categories: Swift Language Grammar Nested
---

> 이 글은 Swift 를 공부하기 위해 애플에서 공개한 [The Swift Programming Language (Swift 3.1)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/) 책의 [Nested Types](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/NestedTypes.html#//apple_ref/doc/uid/TP40014097-CH23-ID242) 부분을 번역하고 주석을 달아서 정리한 글입니다. 현재는 Swift 3.1 버전에 대해서 정리되어 있습니다.

## 품어진 타입 (Nested Types)

열거 타입의 경우 때때로 특정한 클래스나 구조 타입의 기능을 보조하려고 만듭니다. 비슷하게 생각해보면, 클래스나 구조 타입을 더 복잡한 타입을 보조하기 위한 용도로 사용하는 것도 나름 편리할 것입니다. 이를 위해 Swift 는 중첩 타입을 정의할 수 있는데, 보조하려는 타입을 정의할 때 보조 용도로 열거 타입, 클래스 및 구조 타입을 중첩할 수 있습니다.

다른 타입 내에서 타입을 중첩시키려면 지원하려는 타입의 중괄호 범위 내에서 정의를 작성하면 됩니다. 타입은 필요한 만큼 많이 중첩될 수 있습니다.

### 품어진 타입의 사용 예시 (Nested Types in Action)

아래의 예제는 `BlackjackCard` 라는 구조 타입을 정의하는데 블랙잭 게임에서 사용되는 플레이 카드를 모델링합니다. `BlackJack` 구조 타입은 `Suit` 와 `Rank` 라는 두 개의 중첩된 열거 타입을 가지고 있습니다.

블랙잭에서는 에이스 카드의 값은 1 일 수도 있고 11 일 수도 있습니다. 이 특성은 `Values` 라는 구조 타입으로 표현되는데 이는 `Rank` 열거 타입 내에 중첩되어 있습니다:

```
struct BlackjackCard {

    // nested Suit enumeration
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }

    // nested Rank enumeration
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }

    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}
```

`Suit` 열거 타입은 네 벌의 공통 카드 묶음과 그 기호를 표현하기 위한 `Character` 원시 값을 나타냅니다.

`Rank` 열거 타입은 13 개의 가능한 카드 등급과 그들이 표시할 값인 `Int` 원시값을 나타냅니다. (이 `Int` 값은 잭, 퀸, 킹 그리고 에이스 카드에서는 사용하지 않습니다.)

위에서 언급한 대로 `Rank` 열거 타입은 `Values` 라는 중첩된 구조 타입을 정의합니다. 이 구조 타입은 대부분의 카드는 하나의 값을 갖지만 에이스 카드는 두 값을 가지고 있다는 사실을 감춥니다. [^encapsulate] `Values` 구조 타입은 이를 나타내기 위해 두 개의 속성을 정의합니다:

* `first` 는 `Int` 타입니다.
* `second` 는 `Int?` 타입으로 “옵셔널 `Int`” 라고 합니다.

`Rank` 는 또 `Values` 구조 타입의 인스턴스를 반환하는 `values` 라는 계산 속성을 정의합니다. 이 계산 속성은 카드의 등급을 고려해서 새 `Values` 인스턴스를 등급에 맞는 값으로 초기화합니다. `jack`, `queen`, `king`, 그리고 `ace` 에는 특별한 값을 사용하합니다. 숫자 카드의 경우 `Rank` 열거 타입의 `Int` 원시 값을 사용합니다.

`BlackjackCard` 구조 타입은 그 자체로 두 개의 속성을 가지고 있는데 — `rank` 와 `suit` 입니다. 또 `description` 라는 카드의 이름과 값을 설명하는 계산 속성도 정의하고 있는데 이는 `rank` 와 `suit` 에 저장된 값을 사용합니다. `description` 속성은 옵셔널 연결 (optional binding) 을 사용해서 표시할 두번째 값이 있는지를 검사한 후  있으면 두번째 값을 위한 추가 설명을 넣습니다. [^optional-binding]

`BlackjackCard` 는 사용자 정의 초기자가 없는 구조 타입이기 때문에 [구조 타입에 대한 멤버 초기자 (Memberwise Initializers for Structure Types)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID214) 에 설명된 것 처럼 저절로 멤버 초기자를 가지게 됩니다. [^memberwise] [^implicitly] 이 초기자를 사용하여 `theAceOfSpades` 라는 새로운 상수를 초기화할 수 있습니다:

```
let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
// Prints "theAceOfSpades: suit is ♠, value is 1 or 11"
```

`Rank` 와 `Suit` 가 `BlackjackCard` 안에 중첩되어 있지만 그들의 타입은 문맥을 통해서 추론할 수 있으므로 인스턴스 초기화 구문에서 그 자신의 case 이름 (`.ace` 와 `.spades`) 만으로 열거 타입의 case 를 추론할 수 있습니다. [^context] 위의 예제에서 `description` 속성은 스페이드 에이스의 값이 `1` 또는 `11` 임을 정확하게 보고하고 있습니다.

### 품어진 타입 가리키기 (Referring to Nested Types)

중첩된 타입을 정의된 영역 밖에서 사용하려면 이름 앞에 중첩하고 있는 타입의 이름을 붙여주면 됩니다: [^context-2]

```
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
// heartsSymbol is "♡"
```

위의 예제에서 `Suit`, `Rank` 및 `Values` 의 이름은 일부러 짧게 만들었는데 왜냐면 이들이 정의된 곳의 문맥을 통해서  의미를 자연스럽게 파악할 수 있게 되기 때문입니다. [^qualified]

### 원문 자료

* [Nested Types](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/NestedTypes.html#//apple_ref/doc/uid/TP40014097-CH23-ID242) : [The Swift Programming Language (Swift 3.1)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/) 자료입니다.

### 관련 자료

* [Swift: 리눅스에서 Swift 개발 환경 구축하기](http://xho95.github.io/linux/development/swift/package/install/2017/02/19/Developing-Swift-on-Linux.html)

* [Swift 3.1: 빠르게 둘러보기 (A Swift Tour)](http://xho95.github.io/swift/language/grammar/tour/2016/04/17/A-Swift-Tour.html)
* [Swift 3.1: 기초 (The Basics)](http://xho95.github.io/swift/language/grammar/basic/2016/04/24/The-Basics.html)

### 참고 자료

[^encapsulate]: 'encapsulate'는 일단 '감추다'라고 옮깁니다.

[^optional-binding]: 'optional binding'은 '옵셔널 연결'이라고 옮깁니다. 나중에 좀 더 적당한 용어로 바꿀 생각입니다.

[^memberwise]: 'memberwise initializer'는 '멤버 초기자'로 옮깁니다.

[^implicitly]: 'implicitly'는 (은연 중에) 저절로 라는 느낌으로 '저절로'라고 옮깁니다.

[^context]: 여기서는 'context'를 '문맥'으로 옮깁니다.

[^context-2]: 여기서는 'context'를 '영역'이라고 옮깁니다. 좀 더 생각해봐야 할 것 같습니다.

[^qualified]: 이 문장도 좀 더 다듬어야 합니다.
