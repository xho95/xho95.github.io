---
layout: post
comments: true
title:  "Swift 5.2: Nested Types (품어진 타입)"
date:   2017-03-03 02:00:00 +0900
categories: Swift Language Grammar Nested Types
redirect_from: "/swift/language/grammar/nested/2017/03/02/Nested-Types.html"
redirect_from: "/swift/language/grammar/nested/types/2017/03/02/Nested-Types.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Nested Types](https://docs.swift.org/swift-book/LanguageGuide/NestedTypes.html) 부분[^Nested-Types]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Nested Types (품어진 타입)

열거체를 만드는 것은 대체로 클래스나 구조체의 특정 기능을 지원하기 위함입니다. 이와 비슷하게, 복잡한 타입의 영역 내에서만 사용되는 보조용 (utility)[^utility] 클래스와 구조체를 정의할 수 있다면 편리할 것입니다. 이를 위해, 스위프트에서는 _품어진 타입 (nested types)_ 을 정의할 수 있으며, 이를 통해 지원할 타입의 정의 영역에서 '보조용 열거체, 클래스 및 구조체'[^supporting-types] 를 품을 수 있습니다.

한 타입이 다른 타입 내에 품어지게 만드는 방법은, 그것의 정의를 지원할 타입의 외곽 중괄호 안에 작성하는 것입니다. 타입을 품는 단계는 원하는 만큼 많이 중첩할 수 있습니다.

### Nested Types in Action (품어진 타입의 실제 사례)

아래의 예제는 `BlackjackCard` 라는 구조체를 정의하여, '블랙잭 (Blackjack)' 게임에서 사용할 플레이용 카드의 모델을 만듭니다. `BlackjackCard` 구조체는 `Suit` 와 `Rank` 라는 두 개의 '품어진 열거체 타입 (nested enumeration types)' 을 가집니다.

블랙잭에서, 에이스 카드의 값은 '1' 일 수도 있고 '11' 일 수도 있습니다. 이러한 특징은 `Rank` 열거체 내에 품어진 `Values` 라는 구조체로 표현됩니다:

```swift
struct BlackjackCard {

    // 품어진 Suit 열거체
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }

    // 품어진 Rank 열거체
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

    // BlackjackCard 의 속성과 메소드
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

`Suit` 열거체는 일반적인 플레이용 카드의 네가지 패[^suits]를 묘사하고 있으며, `Character` 타입의 '원시 값 (raw value)'[^raw-value] 으로 각 기호를 표현합니다.

`Rank` 열거체는 플레이용 카드에서 가능한 13개의 계급을 묘사하고 있으며, `Int` 타입의 원시 값으로 카드 면에 나타날 값을 표현합니다. (이 `Int` 원시 값은 Jack, Queen, King 그리고 에이스 (Ace) 카드에는 사용하지 않습니다.)

위에서 언급한 대로, `Rank` 열거체는 `Values` 라는 한 단계 더 품어진 구조체를 정의합니다. 이 구조체는 거의 모든 카드는 하나의 값을 갖지만, 에이스 카드는 두 값을 가진다는 사실을 내부에 감춥니다. `Values` 구조체는 두 개의 속성을 정의하여 이를 나타냅니다:

* 속성 `first`, `Int` 타입임
* 속성 `second`, `Int?` (또는 “옵셔널 `Int`”) 타입임

`Rank` 는 `Values` 구조체의 인스턴스를 반환하는 `values` 라는 '계산 속성 (computed property)' 도 정의합니다. 이 계산 속성은 카드의 계급을 고려해서 새 `Values` 인스턴스를 계급에 맞는 값으로 초기화합니다. 이 때 `jack`, `queen`, `king`, 그리고 `ace` 에는 특별한 값을 사용합니다. 숫자 카드라면 그 계급에 해당하는 `Int` '원시 값 (raw value)' 을 사용합니다.

`BlackjackCard` 구조체 그 자신도 두 개의 속성-`rank` 와 `suit`-을 가집니다. 여기다 `description` 이라는 '계산 속성' 도 정의하여, `rank` 와 `suit` 에 저장된 값으로 카드의 이름과 값에 대한 설명을 만들어 냅니다. `description` 속성은 '옵셔널 연결 (optional binding)' 을 사용해서 표시할 두 번째 값이 있는 지 검사하며, 있다면 두 번째 값에 대한 추가 세부 설명을 덧붙입니다.

`BlackjackCard` 는 따로 정의된 초기자가 없는 구조체 이므로, 저절로[^implicit] 멤버 초기자를 가지며, 이는 [Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)]({% post_url 2016-01-23-Initialization %}#memberwise-initializers-for-structure-types-구조체-타입을-위한-멤버-초기자) 에서 설명했습니다. 이 초기자로 다음과 같이 `theAceOfSpades` 라는 새로운 상수를 초기화할 수 있습니다:

```swift
let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
// "theAceOfSpades: suit is ♠, value is 1 or 11" 를 출력합니다.
```

Even though Rank and Suit are nested within BlackjackCard, their type can be inferred from context, and so the initialization of this instance is able to refer to the enumeration cases by their case names (.ace and .spades) alone. In the example above, the description property correctly reports that the Ace of Spades has a value of 1 or 11.


`Rank` 와 `Suit` 는 `BlackjackCard` 안에 품어져 있지만, 이 타입은 문맥으로부터 추론할 수 있으며, 따라서 이 인스턴스를 초기화할 때는 '경우 값 (case)' 의 이름 (`.ace` 와 `.spades`) 만으로도 구조체의 '경우 값들 (cases)' 을 참조할 수 있습니다.[^refer-to] 위의 예제에서, `description` 속성은 '스페이드 에이스' 의 값이 `1` 또는 `11` 임을 정확하게 보고합니다.

### Referring to Nested Types (품어진 타입 참조하기)

'품어진 타입 (nested type)' 을 자신이 정의된 영역 밖에서 사용하려면, 이름 앞에 자신을 품고 있는 타입 이름을 접두사로 붙이면 됩니다:

```swift
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
// heartsSymbol 은 "♡" 입니다.
```

위 예제를 보면, 이는 `Suit`, `Rank`, 그리고 `Values` 의 이름을 의식적으로 짧게 유지할 수 있게 해주는데, 이들의 이름이 정의된 영역에 의해 자연스럽게 '규명되기 (qualified)' 때문입니다.

### 참고 자료

[^Nested-Types]: 이 글에 대한 원문은 [Nested Types](https://docs.swift.org/swift-book/LanguageGuide/NestedTypes.html) 에서 확인할 수 있습니다.

[^utility]: 'utility' 는 '실용적인, 다목적의' 같은 의미를 가진 단어인데, 여기서는 하나의 큰 타입의 범위 내에서만 사용되는 것이라 '보조 용도로 사용된다는' 의미를 강조해서 '보조용' 으로 옮겼습니다. 컴퓨터의 용어로서 'utility' 는 따로 적합한 단어를 찾기 어려운 것 같습니다.

[^supporting-types]: 책에서는 'supporting enumerations, classes, and structures' 라고 되어 있는데, 우리 말로 옮겼을 때 지원을 받는 것인지 지원을 하는 것인지 모호할 수 있기 때문에 자신이 지원을 하는 쪽이라는 의미에서 '보조용 열거체, 클래스 및 구조체' 라고 옮겼습니다. 이들이 다른 타입의 내부에서 그 대상을 지원하는 '품어진 타입 (nested types)' 입니다.

[^suits]: 영어로 'suit' 에는 카드의 '패' 라는 의미가 있으며, '다이아몬드', '하트' 등이 이 'suit' 입니다. 서양 카드에는 4 종류의 'suits' 가 있습니다.

[^raw-value]: 여기서 '원시 값 (raw value)' 는 스위프트의 열거체에서 'case' 가 가질 수 있는 값을 말합니다.

[^implicit]: 여기서 'implicit memberwise initializer' 는 '멤버 초기자를 저절로' 갖게 된다는 의미입니다.

[^refer-to]: 여기서 '참조할 수 있다' 는 말은 '사용할 수 있다' 는 의미입니다. 즉, `Suit.spades` 같이 타입을 직접 명시 하지 않고 `.spades` 같은 형태로도 사용할 수 있다는 의미입니다.
