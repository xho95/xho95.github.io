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

한 타입을 또 다른 타입 안에 중첩하려면, 지원할 타입의 바깥쪽 중괄호 안에 정의를 쓰면 됩니다. 타입은 필요한 만큼 많은 수준으로 중첩할 수 있습니다:

### Nested Types in Action (중첩 타입의 실제 사례)

아래 예제에서 정의하는 구조체인 `BlackjackCard` 는, 블랙잭[^blackjack] 게임에서 쓸 플레잉 카드 (playing card)[^playing-card] 를 모델링합니다. `BlackjackCard` 구조체는 두 개의 중첩 열거체 타입인 `Suit` 와 `Rank` 를 담고 있습니다.

블랙잭에서, 에이스 카드는 **1** 이나 **11** 중 어느 한 값을 가집니다. 이런 특징은 `Values` 라는 구조체로 나타내는데, 이는 `Rank` 열거체 안에 중첩되어 있습니다:

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

`Suit` 열거체는 네 개의 일반적인 플레잉 카드 패[^suits] 와, 그 기호를 나타내는 `Character` 원시 값[^raw-value] 을 함께, 설명합니다.

`Rank` 열거체는 열세 개가 가능한 플레잉 카드의 끗수[^ranks] 와, 그 카드 값을 나타내는 `Int` 원시 값을 함께, 설명합니다. (이 `Int` 원시 값을 잭 (Jack) 과, 퀸 (Queen), 킹 (King), 및 에이스 (Ace) 카드는 쓰지 않습니다.)

위에서 언급했듯이, `Rank` 열거체는 자신 안에 더 중첩된 구조체인, `Values` 를 정의합니다. 이 구조체는 대부분의 카드엔 값이 하나만 있지만, 에이스 카드엔 값이 두 개 있다는 사실을 감춥니다. `Values` 구조체는 두 개의 속성을 정의하여 이를 나타냅니다:

* `first`, 타입은 `Int`
* `second`, 타입은 `Int?`, 또는 “옵셔널 `Int`”

`Rank` 는 계산 속성인, `values` 도 정의하며, 이는 `Values` 구조체의 인스턴스를 반환합니다. 이 계산 속성은 카드의 끗수를 고려하여 그 끗수에 기초한 적절한 값으로 새로운 `Values` 인스턴스를 초기화합니다. `jack` 과, `queen`, `king`, `ace` 면 특수한 값을 사용합니다. 숫자 카드면, 끗수의 `Int` 원시 값을 사용합니다.

`BlackjackCard` 구조체 그 자체에도 두 개의 속성인-`rank` 와 `suit` 가 있습니다. 이는 계산 속성인 `description` 도 정의하여, `rank` 와 `suit` 에 저장된 값을 써서 카드의 이름과 값에 대한 설명을 제작합니다. `description` 속성은 옵셔널 연결[^optional-binding] 을 써서 보여줄 두 번째 값이 있는지 검사하고, 그런 경우, 그 두 번째 값에 대한 세부적인 추가 설명을 집어 넣습니다.

`BlackjackCard` 이란 구조체엔 자신만의 초기자가 없기 때문에, 암시적 멤버 초기자가 있으며, 이는 [Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)]({% link docs/swift-books/swift-programming-language/initialization.md %}#memberwise-initializers-for-structure-types-구조체-타입을-위한-멤버-초기자) 에서 설명했습니다. 이 초기자로 새로운 상수인 `theAceOfSpades` 를 초기화할 수 있습니다:

```swift
let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
// "theAceOfSpades: suit is ♠, value is 1 or 11" 를 인쇄함
```

`Rank` 와 `Suit` 가 `BlackjackCard` 안에 중첩되었을지라도, 상황으로부터 이 타입을 추론할 수 있어서, 이 인스턴스의 초기화 부분에선 열거체 case 의 이름 (인 `.ace` 와 `.spades`) 만으로도 열거체 case 를 참조할 수 있습니다.[^case-name-alone] 위 예제에서, `description` 속성은 스페이드 에이스에 `1` 또는 `11` 의 값이 있다고 올바로 보고합니다.

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

[^blackjack]: '블랙잭 (blackjack)' 은 카드 합이 21 을 넘지않는 선에서 최대한 21 에 가깝게 만들면 이기는 게임입니다. 블랙잭 게임에 대한 더 자세한 정보는, 위키피디아의 [Blackjack](https://en.wikipedia.org/wiki/Blackjack) 항목과 [블랙잭](https://ko.wikipedia.org/wiki/블랙잭) 항목을 참고하기 바랍니다.

[^playing-card]: '플레잉 카드 (playing card)' 는 서양 카드 놀이에 사용되는 종이나 플라스틱으로 만든 카드를 말합니다. 우리나라에서는 보통 트럼프라고 합니다. 더 자세한 내용은, 위키피디아의 [Playing card](https://en.wikipedia.org/wiki/Playing_card) 항목과 [플레잉 카드](https://ko.wikipedia.org/wiki/플레잉_카드) 항목을 참고하기 바랍니다.

[^raw-value]: '원시 값 (raw value)' 은 스위프트의 열거체 case 에 있는 일종의 기본 값입니다. 원시 값에 대한 더 자세한 정보는, [Enumerations (열거체)]({% link docs/swift-books/swift-programming-language/enumerations.md %}) 장의 [Raw Values (원시 값)]({% link docs/swift-books/swift-programming-language/enumerations.md %}#raw-values-원시-값) 절을 보기 바랍니다.

[^suits]: '패 (suits)' 는 서양 카드에 있는 스페이드 (spades) 와, 다이아몬드 (diamonds), 하트 (hearts), 및 클로버 (clovers) 라는 네 개의 범주를 말합니다.

[^ranks]: '끗수 (ranks)' 는 숫자 또는 알파펫으로 나타내는 카드의 등급을 말하며, 서양 카드엔 13 개의 끗수가 있습니다.

[^optional-binding]: '옵셔널 연결 (optional binding)' 에 대한 더 자세한 정보는, [The Basics (기초)]({% link docs/swift-books/swift-programming-language/the-basics.md %}) 장의 [Optional Binding (옵셔널 연결)](#optional-binding-옵셔널-연결) 절을 보기 바랍니다.

[^case-name-alone]: `Suit.spades` 처럼 하지 않고, `.spades` 만으로도 참조할 수 있다는 의미입니다. 초기자의 매개 변수에서 타입을 명시했기 때문에, 초기자 호출 시에 그 매개 변수의 타입을 추론할 수 있기 때문입니다.

[^qualified]: 중첩 타입을 정의한 곳이 중첩 타입이 소속된 곳이므로 자연스럽게 '소속이 밝혀지게 (qualified)' 됩니다.
