---
layout: post
comments: true
title:  "Swift 5.3: Nested Types (중첩 타입)"
date:   2017-03-03 02:00:00 +0900
categories: Swift Language Grammar Nested Types
redirect_from: "/swift/language/grammar/nested/2017/03/02/Nested-Types.html"
redirect_from: "/swift/language/grammar/nested/types/2017/03/02/Nested-Types.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Nested Types](https://docs.swift.org/swift-book/LanguageGuide/NestedTypes.html) 부분[^Nested-Types]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Nested Types (중첩 타입)

열거체는 종종 특정 클래스나 구조체의 기능을 지원하는 용도로 생성합니다. 이와 비슷하게, 순수하게 더 복잡한 타입 내에서만 사용하기 위한 보조용 클래스와 구조체를 정의하는 것이 편리할 수 있습니다. 이를 달성하기 위해, 스위프트는, 지원할 타입의 정의 내에 지원용 열거체, 클래스, 그리고 구조체를 중첩하도록 하는, _중첩 타입 (nested types)_ 을 정의할 수 있게 해줍니다.

다른 타입 내에 타입을 중첩하려면, 지원할 타입의 '외곽 (outer) 중괄호' 안에 그 정의를 작성합니다. 필요한 만큼 많은 수준의 타입을 중첩할 수 있습니다:

### Nested Types in Action (중첩 타입의 실제 사례)

아래 예제는, '블랙잭 (Blackjack)'[^blackjack] 게임에서 사용할 '서양 카드(playing card)'[^playing-card] 를 모델링하는, `BlackjackCard` 이라는 구조체를 정의합니다.  `BlackjackCard` 구조체는 `Suit` 와 `Rank` 라는 두 개의 '중첩된 열거체 타입' 을 담고 있습니다.

'블랙잭' 에서, '에이스 (Ace) 카드' 는 '1' 이나 '11' 둘 중 하나의 값을 가집니다. 이 특징은, `Rank` 열거체에 중첩된, `Values` 라는 구조체가 표현합니다:

```swift
struct BlackjackCard {

  // 중첩된 Suit 열거체
  enum Suit: Character {
    case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
  }

  // 중첩된 Rank 열거체
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

`Suit` 열거체는, 자신의 기호를 표현하는 '원시 `Character` 값'[^raw-value] 과 함께, 서양 카드에 공통적인 네가지 '패 (suits)'[^suits] 를 묘사합니다.

`Rank` 열거체는, 자신의 카드 면에 있는 값을 표현하는 '원시 `Int` 값' 과 함께, 서양 카드에서 가능한 13 가지의 '등급 (ranks)' 을 묘사합니다. (이 '원시 `Int` 값' 은 '잭 (Jack)', '퀸 (Queen)', '킹 (King)' 그리고 '에이스 (Ace)' 카드에는 사용하지 않습니다.)

위에서 언급한 것처럼, `Rank` 열거체는, `Values` 라는, 자신보다 더 한층 중첩된 구조체를 정의합니다. 이 구조체는 대부분의 카드가 하나의 값을 갖지만, '에이스 카드' 는 두 값을 가진다는 사실을 '은닉 (encapsulates)' 합니다. `Values` 구조체는 이를 표현하기 위해 두 속성을 정의합니다:

* `first`, `Int` 타입임
* `second`, `Int?`, 또는 “옵셔널 `Int`” 타입임

`Rank` 는, `Values` 구조체 인스턴스를 반환하는, `values` 라는, '계산 속성' 도 정의합니다. 이 계산 속성은 카드의 등급을 고려하여 새로운 `Values` 인스턴스를 등급에 기초한 적절한 값으로 초기화 합니다. `jack`, `queen`, `king`, 그리고 `ace` 에는 특수한 값을 사용합니다. '숫자 카드' 에는, 등급의 '원시 `Int` 값' 을 사용합니다.

`BlackjackCard` 구조체는 자신도 `rank` 와 `suit`라는-두 속성을 가집니다. 이는, 카드의 이름과 값에 대한 설명을 제작하기 위해 `rank` 와 `suit` 에 저장된 값을 사용하는, `description` 이라는 '계산 속성' 도 정의합니다. `description` 속성은 표시할 두 번째 값이 있는지 검사하기 위해 '옵셔널 연결'[^optional-binding] 을 사용하며, 그런 경우, 두 번째 값을 위한 추가적인 세부 설명을 집어 넣습니다.

`BlackjackCard` 는 사용자 정의 초기자가 없는 구조체이기 때문에, [Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)]({% post_url 2016-01-23-Initialization %}#memberwise-initializers-for-structure-types-구조체-타입을-위한-멤버-초기자) 에서 설명한 것처럼, 암시적인 멤버 초기자를 가집니다. 이 초기자를 사용하여 `theAceOfSpades` 라는 새로운 상수를 초기화할 수 있습니다:

```swift
let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
// "theAceOfSpades: suit is ♠, value is 1 or 11" 를 인쇄합니다.
```

`Rank` 와 `Suit` 가 `BlackjackCard` 안에 중첩되어 있을지라도, 상황으로부터 타입을 추론할 수 있으므로, 이 인스턴스를 초기화할 때 (`.ace` 와 `.spades` 라는) 'case 값' 이름 만으로도 '열거체 case 값' 을 참조하는 게 가능합니다.[^case-name-alone] 위 예제에서, `description` 속성은 '스페이드 (Spades)' 의 '에이스 (Ace)' 가 `1` 또는 `11` 이라는 값을 가짐을 올바르게 보고합니다.

### Referring to Nested Types (중첩 타입 참조하기)

자신을 정의한 상황 밖에서 '중첩 타입' 을 사용하려면, 자기 이름 앞에 자신이 중첩되어 있는 타입의 이름을 접두사로 붙입니다:

```swift
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
// heartsSymbol 은 "♡" 입니다.
```

위 예제를 보면, `Suit`, `Rank`, 그리고 `Values` 의 이름은 자신이 정의된 상황에 의해 자연스럽게 '규명되기 (qualified)'[^qualified] 때문에, 이는 이름을 의도적으로 짧게 유지할 수 있도록 해줍니다.

### 다음 장

[Extensions (익스텐션; 확장) > ]({% post_url 2016-01-19-Extensions %})

### 참고 자료

[^Nested-Types]: 이 글에 대한 원문은 [Nested Types](https://docs.swift.org/swift-book/LanguageGuide/NestedTypes.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^blackjack]: '블랙잭 (blackjack)' 은 카드 합이 '21' 을 넘지않는 선에서 최대한 '21' 에 가깝게 만들면 이기는 게임입니다. '블랙잭' 에 대한 더 자세한 정보는 위키피디아의 [Blackjack](https://en.wikipedia.org/wiki/Blackjack) 항목과 [블랙잭](https://ko.wikipedia.org/wiki/블랙잭) 항목을 참고하기 바랍니다.

[^playing-card]: 영어로 'playing card' 는 직역하면 '놀이용 카드' 라고 할 수 있는데, 우리가 보통 '트럼프 (trump)' 라고도 하는 놀이에서 사용되는 '서양 카드' 자체를 의미합니다. 이후로는 그냥 '서양 카드' 라고 옮기도록 합니다.

[^raw-value]: '원시 값 (raw value)' 는 스위프트에 있는 '열거체 case 값' 이 가질 수 있는 일종의 '기본 값' 입니다. '원시 값' 에 대한 더 자세한 정보는 [Enumerations (열거체)]({% post_url 2020-06-13-Enumerations %}) 장의 [Raw Values (원시 값)]({% post_url 2020-06-13-Enumerations %}#raw-values-원시-값) 항목을 참고하기 바랍니다.

[^suits]: 영어로 'suit' 에는 카드의 '패' 라는 의미가 있으며, '다이아몬드 (diamonds)', '하트 (hearts)' 등이 이 '패 (suit)' 에 해당합니다. 서양 카드에는 4 종류의 '패 (suits)' 가 있습니다.

[^optional-binding]: '옵셔널 연결 (optional binding)' 에 대한 더 자세한 정보는, [The Basics (기초)]({% post_url 2016-04-24-The-Basics %}) 장에 있는 [Optional Binding (옵셔널 연결)](#optional-binding-옵셔널-연결) 항목을 참고하기 바랍니다.

[^case-name-alone]: 이는 `Suit.spades` 같이 타입을 직접 붙이지 않고 `.spades` 같은 사용할 수 있다는 의미입니다. 이것이 가능한 것은 '암시적인 멤버 초기자' 의 매개 변수에 타입이 명시되어 있어서, 초기자를 호출할 때 매개 변수의 타입을 추론할 수 있기 때문입니다.

[^qualified]: 스위프트에서 '규명되다 (qualified)' 라는 말은 '자신이 소속된 곳이 어디인지 안다' 는 의미입니다. '중첩 타입' 은 정의 자체에 의해서 소속을 알 수 있기 때문에 자연스럽게 '규명되는' 것입니다.
