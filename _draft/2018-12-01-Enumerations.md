---
layout: post
comments: true
title:  "Swift 4.2: 열거형 (Enumerations)"
date:   2018-12-01 19:35:00 +0900
categories: Xcode Swift Grammar Enumerations
---

### 열거형 경우들을 되풀이하기

열거형 중에는 열거형의 모든 경우들에 대해 집합체를 취하는 것이 편리할 때가 있습니다. 이렇게 하려면 열거형 이름 뒤에 `: CaseIterable` 를 붙여주면 됩니다. 스위프트는 모든 경우의 집합체를 열거형의 `allCases` 라는 속성으로 제공합니다. 다음에 예가 있습니다.


```swift
enum Beverage: CaseIterable {
    case coffee, tea, juice
}

let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")

// Prints "3 beverages available’
```

위 예제에서 `Beverage.allCases` 를 써서 `Beverage` 열거형의 모든 경우를 담고 있는 집합체에 접근합니다. `allCases` 는 다른 집합체처럼 사용할 수 있습니다 - 집합체의 요소는 열거형의 인스턴스로, 이 경우는 `Beverage` 값입니다. 위 예는 얼마나 많은 경우가 있는지를 나타내며, 아래의 `for` loop 예제는 모든 경우를 되풀이하는 방법을 나타냅니다.

```Swift
for beverage in Beverage.allCases {
  print(beverage)
}

// coffee
// tea
// juice
```

위 예제에서 사용된 문법은 열거형이 `CaseIterable` 프로토콜을 따름을 나타냅니다. 프로토콜에 대한 정보는 Protocol 을 보기 바랍니다.

### 고찰 하기


### 참고 자료
