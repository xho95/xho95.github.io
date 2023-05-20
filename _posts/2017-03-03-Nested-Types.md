---
layout: post
comments: true
title:  "Nested Types (중첩 타입)"
date:   2017-03-03 02:00:00 +0900
categories: Swift Language Grammar Nested Types
redirect_from: "/swift/language/grammar/nested/2017/03/02/Nested-Types.html"
redirect_from: "/swift/language/grammar/nested/types/2017/03/02/Nested-Types.html"
---

{% include header_swift_book.md %}

## Nested Types (중첩 타입)

열거체는 종종 특정 클래스나 구조체의 기능을 지원하기 위해서 생성합니다. 이와 비슷하게, 순전히 더 복잡한 타입 안에서만 쓸 보조 클래스와 구조체를 정의하는게 편리할 수도 있습니다. 이를 해내려고, 스위프트는 _중첩 타입 (nested types)_ 을 정의하여, 지원용 열거체와, 클래스, 및 구조체를 자신이 지원할 타입의 정의 안에 중첩할 수 있게 합니다. 

한 타입을 또 다른 타입 안에 중첩하려면, 지원할 타입의 바깥쪽 중괄호 안에 그 정의를 쓰면 됩니다. 타입은 필요한 만큼 많은 단계로 중첩할 수 있습니다:

### Nested Types in Action (중첩 타입의 실제 사례)

아래 예제는, 블랙잭 게임[^blackjack] 에서 사용할 놀이용 카드[^playing-card] 를 모델링하는, `BlackjackCard` 이라는 구조체를 정의합니다. `BlackjackCard` 구조체는 `Suit` 와 `Rank` 라는 두 개의 중첩 열거체 타입을 담고 있습니다.

블랙잭의, 에이스 카드는 1 이나 11 중 어느 하나의 값을 가집니다. `Rank` 열거체 안에 중첩한, `Values` 라는 구조체로 이런 특징을 나타냅니다:

```swift
struct BlackjackCard {

  // 중첩 Suit 열거체
  enum Suit: Character {
    case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
  }

  // 중첩 Rank 열거체
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

  // BlackjackCard 의 속성 및 메소드
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

`Suit` 열거체는, 자신의 기호를 나타내는 `Character` 원시 값[^raw-value] 과, 일반 놀이용 카드의 네 가지 패[^suits] 를 함께 설명합니다.

`Rank` 열거체는, 자신의 카드(면) 값을 나타내는 `Int` 원시 값과, 놀이용 카드에서 가능한 13 개의 끗수[^ranks] 를 함께 설명합니다. (잭 (Jack), 퀸 (Queen), 킹 (King), 및 에이스 (Ace) 카드에선 이 `Int` 원시 값을 사용하지 않습니다.)

위에서 언급한 것처럼, `Rank` 열거체는 자신만의, `Values` 라는, 더 중첩된 구조체를 정의합니다. 이 구조체는 대부분의 카드엔 하나의 값만 있지만, 에이스 카드엔 두 개의 값이 있다는 사실을 은닉합니다. `Values` 구조체는 두 개의 속성을 정의하여 이를 나타냅니다:

* `first`, 타입은 `Int`
* `second`, 타입은 `Int?`, 또는 “옵셔널 `Int`”

`Rank` 는 `Values` 구조체 인스턴스를 반환하는, `values` 라는, 계산 속성도 정의합니다. 이 계산 속성은 카드의 끗수를 고려하여 자신의 끗수에 기초한 적절한 값으로 새로운 `Values` 인스턴스를 초기화합니다. `jack`, `queen`, `king`, 및 `ace` 면 특수한 값을 사용합니다. 숫자 카드면, 끗수의 `Int` 원시 값을 사용합니다.

`BlackjackCard` 구조체 그 자체도-`rank` 와 `suit` 라는-두 속성을 가집니다. `description` 이라는 계산 속성도 정의하는데, 이는 `rank` 와 `suit` 에 저장한 값을 사용하여 카드 이름과 값의 설명을 제작합니다. `description` 속성은 옵셔널 연결[^optional-binding] 을 사용하여 보여줄 두 번째 값이 있는 지 검사하고, 그럴 경우, 그 두 번째 값의 세부적인 추가 설명을 집어 넣습니다.

`BlackjackCard` 는 자신만의 초기자가 없는 구조체이기 때문에, [Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)]({% link docs/swift-books/swift-programming-language/initialization.md %}#memberwise-initializers-for-structure-types-구조체-타입을-위한-멤버-초기자) 에서 설명한 것처럼, 암시적인 멤버 초기자를 가집니다. 이 초기자를 사용하여 `theAceOfSpades` 라는 새로운 상수를 초기화할 수 있습니다:

```swift
let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
// "theAceOfSpades: suit is ♠, value is 1 or 11" 를 인쇄함
```

`Rank` 와 `Suit` 가 `BlackjackCard` 안에 중첩되어 있을지라도, 이 타입들은 상황으로 추론할 수 있어서, (`.ace` 와 `.spades` 라는) 자신의 case 이름 만으로도 이 인스턴스의 초기화가 열거체 case 를 참조할 수 있습니다.[^case-name-alone] 위 예제에선, 스페이드 에이스엔 `1` 또는 `11` 의 값이 있음을 `description` 속성이 올바로 보고합니다.

### Referring to Nested Types (중첩 타입 참조하기)

정의한 곳 밖에서 중첩 타입을 사용하려면, 자신을 중첩한 타입의 이름을 이름 앞에 접두사로 둡니다:

```swift
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
// heartsSymbol 은 "♡" 임
```

위 예제에서, 이는 `Suit` 와, `Rank`, 및 `Values` 의 이름을 의도적으로 짧게 유지할 수 있도록 하는데, 이는 자신이 정의된 곳의 상황에 의해 그 이름의 소속이 자연스럽게 밝혀지기 때문입니다.[^qualified]

### 다음 장

[Extensions (익스텐션; 확장)]({% link docs/swift-books/swift-programming-language/extensions.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [Nested Types](https://docs.swift.org/swift-book/LanguageGuide/NestedTypes.html) 에서 볼 수 있습니다.

[^blackjack]: '블랙잭 (blackjack)' 은 카드 합이 21 을 넘지않는 선에서 최대한 21 에 가깝게 만들면 이기는 게임입니다. 블랙잭 게임에 대한 더 자세한 정보는, 위키피디아의 [Blackjack](https://en.wikipedia.org/wiki/Blackjack) 항목과 [블랙잭](https://ko.wikipedia.org/wiki/블랙잭) 항목을 보도록 합니다.

[^playing-card]: '놀이용 카드 (playing card)' 는 서양 카드 놀이에 사용되는 종이나 플라스틱으로 만든 카드를 말합니다. 우리나라에서는 보통 트럼프라고 부르는 경우가 많습니다. 이에 대한 더 자세한 내용은, 위키피디아의 [Playing card](https://en.wikipedia.org/wiki/Playing_card) 항목과 [플레잉 카드](https://ko.wikipedia.org/wiki/플레잉_카드) 항목을 보도록 합니다. 

[^raw-value]: '원시 값 (raw value)' 은 스위프트의 열거체 case 가 가질 수 있는 일종의 기본 값입니다. 원시 값에 대한 더 자세한 정보는, [Enumerations (열거체)]({% link docs/swift-books/swift-programming-language/enumerations.md %}) 장의 [Raw Values (원시 값)]({% link docs/swift-books/swift-programming-language/enumerations.md %}#raw-values-원시-값) 부분을 보도록 합니다.

[^suits]: '패 (suits)' 는 스페이드 (spades), 다이아몬드 (diamonds), 하트 (hearts), 클로버 (clovers) 라는 서양 카드의 네 가지 범주를 말합니다.

[^ranks]: '끗수 (ranks)' 는 각각의 카드마다 숫자 또는 알파펫으로 나타내는 등급을 말합니다. 서양 카드에는 13 가지 끗수가 있습니다.

[^optional-binding]: '옵셔널 연결 (optional binding)' 에 대한 더 자세한 정보는, [The Basics (기초)]({% link docs/swift-books/swift-programming-language/the-basics.md %}) 장에 있는 [Optional Binding (옵셔널 연결)](#optional-binding-옵셔널-연결) 항목을 보도록 합니다.

[^case-name-alone]: `Suit.spades` 처럼 타입을 붙이지 않고, `.spades` 같이 사용할 수 있다는 의미입니다. 이는 (암시적인) 초기자의 매개 변수에서 타입을 명시하기 때문에, 초기자 호출 시에 매개 변수 타입을 추론할 수 있기 때문입니다.

[^qualified]: 중첩 타입을 정의한 곳이 중첩 타입이 소속된 곳이므로 자연스럽게 '소속이 밝혀지게 (qualified)' 됩니다.
