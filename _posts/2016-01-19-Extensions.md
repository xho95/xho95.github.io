---
layout: post
comments: true
title:  "Extensions (익스텐션; 확장)"
date:   2016-01-19 17:10:00 +0900
categories: Xcode Swift Grammar Extensions
---

{% include header_swift_book.md %}

## Extensions (익스텐션; 확장)

_익스텐션 (extensions; 확장)_[^extension] 은 이미 있던 클래스나, 구조체, 열거체, 또는 프로토콜 타입에 새로운 기능[^functionality] 을 추가합니다. 이는 원본 소스 코드에 접근할 수 없는 타입을 확장하는 (_소급 적용 모델링 (retroactive modeling)_[^retroactive-modeling] 이라는) 능력도 포함합니다. 익스텐션은 **오브젝티브-C** 의 카테고리 (categories)[^categories] 와 비슷합니다. (오브젝티브-C 의 카테고리와 달리, 스위프트의 익스텐션에는 이름이 없습니다.)

스위프트의 익스텐션이 할 수 있는 건 다음과 같습니다:

* 계산 인스턴스 속성과 계산 타입 속성을 추가함
* 인스턴스 메소드와 타입 메소드를 정의함
* 새로운 초기자를 제공함
* 첨자를 정의함
* 새로운 중첩 타입을 정의하고 사용함
* 이미 있던 타입이 프로토콜을 준수하도록 만듦

스위프트에선, 심지어 프로토콜을 확장하여 필수 조건에 구현을 제공하거나 추가 기능을 더할 수 있어서 이를 준수 타입이 활용할 수 있습니다. 더 자세한 건, [Protocol Extensions (프로토콜 익스텐션; 규약 확장)]({% link docs/swift-books/swift-programming-language/protocols.md %}#protocol-extensions-프로토콜-익스텐션-규약-확장) 부분을 보기 바랍니다.

> 익스텐션은 타입에 새로운 기능을 추가할 수 있지만, 이미 있던 기능을 재정의할 순 없습니다.

### Extension Syntax (익스텐션 구문)

익스텐션은 `extension` 키워드로 선언합니다:

```swift
extension SomeType {
  // SomeType 에 추가할 새로운 기능은 여기에 둠
}
```

익스텐션은 이미 있던 타입이 하나 이상의 프로토콜을 채택[^adopt] 하도록 확장할 수 있습니다. 프로토콜 준수성[^conformance] 을 추가하려면, 클래스나 구조체에서 쓰는 것과 똑같은 방식으로 프로토콜 이름을 쓰면 됩니다:

```swift
extension SomeType: SomeProtocol, AnotherProtocol {
  // 프로토콜 필수 조건의 구현은 여기에 둠
}
```

프로토콜 준수성을 이런 식으로 추가하는 건 [Adding Protocol Conformance with an Extension (익스텐션으로 프로토콜 준수성 추가하기)]({% link docs/swift-books/swift-programming-language/protocols.md %}#adding-protocol-conformance-with-an-extension-익스텐션으로-프로토콜-준수성-추가하기) 에서 설명합니다.

익스텐션을 써서 이미 있던 일반화 타입을 확장할 수 있는데, 이는 [Extending a Generic Type (일반화 타입 확장하기)]({% link docs/swift-books/swift-programming-language/generics.md %}#extending-a-generic-type-일반화-타입-확장하기) 에서 설명합니다. 일반화 타입을 확장하여 기능을 조건부로 추가할 수도 있는데, 이는 [Extensions with a Generic Where Clause (일반화 where 절이 있는 익스텐션)]({% link docs/swift-books/swift-programming-language/generics.md %}#extensions-with-a-generic-where-clause-일반화-where-절이-있는-익스텐션) 에서 설명합니다.

> 익스텐션을 정의하여 기존 타입에 새로운 기능을 추가하면, 그 타입에 이미 있떤 모든 인스턴스에서 새로운 기능을 사용할 수 있으며, 심지어 그게 익스텐션을 정의하기 전에 생성됐더라도 그렇습니다.

### Computed properties (계산 속성)

익스텐션은 기존 타입에 계산 인스턴스 속성과 계산 타입 속성을 추가할 수 있습니다. 이번 예제는 다섯 개의 계산 인스턴스 속성을 스위프트의 내장 `Double` 타입에 추가해서, 기초적인 거리 단위 작업을 지원하게 합니다:

```swift
extension Double {
  var km: Double { return self * 1_000.0 }
  var m: Double { return self }
  var cm: Double { return self / 100.0 }
  var mm: Double { return self / 1_000.0 }
  var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// "One inch is 0.0254 meters" 를 인쇄함

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// "Three feet is 0.914399970739201 meters" 를 인쇄함
```

이 계산 속성들은 `Double` 값이 특정 길이 단위로 고려되어야 함을 표현합니다. 계산 속성으로 구현하긴 했지만, 이 속성의 이름을 부동-소수점 글자 값[^literal] 에 점 구문으로 덧붙여 쓰는 방식으로, 그 글자 값의 거리를 변환할 수 있습니다.

이 예제에서, `Double` 값 `1.0` 은 "1 미터" 를 나타내는 것으로 고려합니다. 이게 `m` 계산 속성이 `self` 를 반환하는 이유입니다-표현식 `1.m` 은 `1.0` 이라는 `Double` 값을 계산한다고 고려합니다.

다른 단위들은 측정 값을 미터로 표현하기 위해 어떠한 변환이 필요합니다. 1 킬로미터는 1,000 미터와 같으므로, `km` 계산 속성은 값에 `1_000.0` 을 곱하여 수가 미터로 표현되게 변환합니다. 이와 비슷하게, 1 미터는 3.28084 피트이므로, `ft` 계산 속성은 그 밑에 놓인 `Double` 값을 `3.28084` 로 나눠서, 피트를 미터로 변환합니다.

이 속성들은 읽기-전용 계산 속성[^read-only] 이라서, 간결하게, `get` 키워드 없이 표현했습니다. 이들의 반환 값은 `Double` 타입이며, `Double` 을 받는 수식 계산마다 쓸 수 있습니다:

```swift
let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
// "A marathon is 42195.0 meters long" 을 인쇄함
```

> 익스텐션은 기존 속성에 새로운 계산 속성을 추가할 순 있지만, 저장 속성을 추가하거나, 속성 관찰자[^property-observers] 를 추가할 순 없습니다.

### Initializers (초기자)

익스텐션은 기존 타입에 새로운 초기자를 추가할 수 있습니다. 이렇게 다른 타입들을 확장하면 자신이 만든 타입을 초기자 매개 변수로 받아들이거나, 타입의 원본 구현에선 포함되지 않았던 초기화 옵션을 추가할 수 있습니다.

익스텐션은 클래스에 새로운 편의 초기자를 추가할 수 있지만, 클래스에 새로운 지명 초기자나 정리자를 추가할 순 없습니다. 지명 초기자와 정리자는 반드시 항상 원본 클래스 구현에서 제공해야 합니다.

익스텐션으로 초기자를 추가한 값 타입이 모든 저장 속성에 기본 값을 제공하면서 자신만의 어떤 초기자도 정의하지 않았다면, 익스텐션의 초기자에서 그 값 타입의 기본 초기자와 멤버 초기자를 호출할 수 있습니다. 값 타입의 원본 구현에서 초기자를 작성했다면 이 경우에 해당이 안되는데, 이는 [Initializer Delegation for Value Types (값 타입에서의 초기자 맡김)]({% link docs/swift-books/swift-programming-language/initialization.md %}#initializer-delegation-for-value-types-값-타입에서의-초기자-맡김) 에서 설명합니다.

익스텐션으로 초기자를 추가한 구조체가 다른 모듈에서 선언한 거라면, 정의 모듈에 있는 초기자를 호출하기 전까진 새로운 초기자로 `self` 에 접근할 수 없습니다.[^access-self]

아래 예제는 자신만의 `Rect` 구조체를 정의하여 기하 도형인 사각형을 나타냅니다. 예제는 두 개의 지원용 구조체인 `Size` 와 `Point` 도 정의하며, 이 둘 다 자신의 모든 속성에 `0.0` 이라는 기본 값을 제공합니다:

```swift
struct Size {
  var width = 0.0, height = 0.0
}

struct Point {
  var x = 0.0, y = 0.0
}

struct Rect {
  var origin = Point()
  var size = Size()
}
```

`Rect` 구조체가 자신의 모든 속성에 기본 값을 제공하기 때문에, 기본 초기자와 멤버 초기자를 자동으로 받으며, 이는 [Default Initializers (기본 초기자)]({% link docs/swift-books/swift-programming-language/initialization.md %}#default-initializers-기본-초기자) 에서 설명했습니다. 이 초기자를 써서 새로운 `Rect` 인스턴스를 생성할 수 있습니다:

```swift
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
```

`Rect` 구조체를 확장하여 특정한 중심점과 크기를 입력 받는 초기자를 추가할 수 있습니다.

```swift
extension Rect {
  init(center: Point, size: Size) {
    let originX = center.x - (size.width / 2)
    let originY = center.y - (size.height / 2)
    self.init(origin: Point(x: originX, y: originY), size: size)
  }
}
```

이 새로운 초기자는 제공된 `center` 점과 `size` 값에 기초한 적절한 원점을 계산하는 걸로 시작합니다. 그런 다음 초기자가 구조체의 자동 멤버 초기자[^automatic-memberwise-initializer] 인 `init(origin:size:)` 를 호출하는데, 이는 새로운 원점과 크기 값을 적절한 속성에 저장합니다.

```swift
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
// centerRect 의 원점은 (2.5, 2.5) 이고 크기는 (3.0, 3.0) 임
```

> 익스텐션으로 새로운 초기자를 제공하는 경우에도, 일단 초기자가 완료되면 각각의 인스턴스 전체가 확실히 초기화된다는 걸 여전히 책임져야 합니다. 

### Methods (메소드)

익스텐션은 기존 타입에 새로운 인스턴스 메소드와 타입 메소드를 추가할 수 있습니다. 다음 예제는 `Int` 타입에 새로운 인스턴스 메소드인 `repetitions` 을 추가합니다:

```swift
extension Int {
  func repetitions(task: () -> Void) {
    for _ in 0..<self {
      task()
    }
  }
}
```

`repetitions(task:)` 메소드는 `() -> Void` 타입의 인자를 단 하나 입력 받는데, 이는 아무런 매개 변수도 없고 값도 반환 안하는 함수를 지시합니다.

이 익스텐션을 정의한 후에, 어떤 정수에서든 `repetitions(task:)` 메소드를 호출하면 그 횟수 만큼의 임무를 수행할 수 있습니다:

```swift
3.repetitions {
  print("Hello!")
}

// Hello!
// Hello!
// Hello!
```

#### Mutating Instance Methods (변경 인스턴스 메소드)

익스텐션으로 추가한 인스턴스 메소드도 인스턴스 그 자체를 수정 또는 _변경 (mutate)_ 할 수 있습니다. 구조체와 열거체의 메소드가 `self` 나 자신의 속성을 수정하는 거면 반드시 그 인스턴스 메소드를, 원본 구현의 변경 메소드와 같이, `mutating` 으로 표시해야 합니다.

아래 예제는 새로운 변경 메소드인 `square` 를 스위프트의 `Int` 타입에 추가하여, 원본 값을 제곱합니다:

```swift
extension Int {
  mutating func square() {
    self = self * self
  }
}

var someInt = 3
someInt.square()
// someInt 는 이제 9 임
```

### Subscripts (첨자)

익스텐션은 기존 타입에 새로운 첨자를 추가할 수 있습니다. 이번 예제는 스위프트의 내장 `Int` 타입에 정수 첨자를 추가합니다. 이 `[n]` 첨자는 수치 값의 오른쪽 `n` 번째 자리에 있는 10진 숫자를 반환하여:

* `123456789[0]` 은 `9` 를 반환하고
* `123456789[1]` 은 `8` 을 반환하며

... 이렇게 계속됩니다:

```swift
extension Int {
  subscript(digitIndex: Int) -> Int {
    var decimalBase = 1
    for _ in 0..<digitIndex {
      decimalBase *= 10
    }
    return (self / decimalBase) % 10
  }
}

746381295[0]
// 5 를 반환함
746381295[1]
// 9 를 반환함
746381295[2]
// 2 를 반환함
746381295[8]
// 7 을 반환하
```

`Int` 값의 숫자가 요청한 색인만큼 충분히 있지 않다면, 첨자 구현이 `0` 을 반환하여, 마치 수치 값 왼쪽이 0 으로 덧대진 것처럼 합니다:

```swift
746381295[9]
// 마치 이렇게 요청한 것처럼, 0 을 반환함:
0746381295[9]
```

### Nested Types (중첩 타입)

익스텐션은 기존의 클래스, 구조체, 및 열거체에 새로운 중첩 타입을 추가할 수 있습니다:

```swift
extension Int {
  enum Kind {
    case negative, zero, positive
  }
  var kind: Kind {
    switch self {
    case 0:
      return .zero
    case let x where x > 0:
      return .positive
    default:
      return .negative
    }
  }
}
```

이 예제는 `Int` 에 새로운 중첩 열거체를 추가합니다. `Kind` 라는, 이 열거체는 한 특별한 정수가 나타내는 수치 값의 종류를 표현합니다. 특히, 수치 값이 음수인지, 0, 또는 양수인지를 표현합니다.

이 예제는, 그 정수에 대한 적절한 `Kind` 열거체를 반환하는, `kind` 라는, 새로운 계산 인스턴스 속성도 `Int` 에 추가합니다.

이제 어떤 `Int` 을 가지고도 중첩 열거체를 사용할 수 있습니다:

```swift
func printIntegerKinds(_ number: [Int]) {
  for number in numbers {
    switch number.kind {
    case .negative:
      print("- ", terminator: "")
    case .zero:
      print("0 ", terminator: "")
    case .positive:
      print("+ ", terminator: "")
    }
  }
  print("")
}

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// "+ + - 0 - 0 + " 를 인쇄함
```

`printIntegerKinds(_:)` 라는, 이 함수는 `Int` 값의 입력 배열을 취해서 차례대로 그 값들을 반복합니다. 배열의 각 정수마다, 함수가 그 정수의 `kind` 계산 속성을 고려하여, 적절한 설명을 인쇄합니다.

> `number.kind` 가 `Int.Kind` 타입인 건 이미 알고 있습니다. 이 때문에, `Int.Kind.negative` 보단 `.negative` 와 같이, `switch` 문 안에서 짧게 줄인 형식으로 모든 `Int.Kind` case 값을 작성할 수 있습니다.

### 다음 장

[Protocols (프로토콜; 규약)]({% link docs/swift-books/swift-programming-language/protocols.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [Extensions](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html) 에서 볼 수 있습니다.

[^extension]: 스위프트의 `extension` 은 확장이라는 의미를 가진 하나의 키워드입니다. 키워드 자체로 사용할 때는 '익스텐션' 이라는 발음을 그대로 사용합니다.

[^functionality]: '기능 (functionality) 을 추가한다' 는 건 타입의 본질을 바꾸지 않는 함수 같은 것들만 추가한다는 의미입니다. 즉, 타입의 구조를 바꾸는  저장 속성 같은 것들은 추가하지 않는다는 걸 이미 내포하고 있는 말입니다. 사실 기능만 추가하기 때문에, 기존 타입을 확장 (extension) 하는 것이 가능합니다.

[^retroactive-modeling]: '소급 적용 모델링 (retroactive modeling)' 은 적용하기 전에 있던 코드에도 영향을 미치는 모델링을 의미합니다. 스위프트의 소급 적용 모델링을 통하여 스위프트 표준 라이브러리에 있는 타입과 패키지에 있는 타입을 확장할 수 있습니다. 소급 적용 모델링에 대한 더 자세한 정보는, 위키피디아의 [Retroactive data structure](https://en.wikipedia.org/wiki/Retroactive_data_structure) 항목을 참고하기 바랍니다.

[^categories]: '카테고리 (categories)' 는 범주 정도의 의미를 가지고 있습니다. 카데고리에 대한 더 자세한 정보는 애플 문서의 [Categories and Extensions](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjectiveC/Chapters/ocCategories.html) 항목을 참고하기 바랍니다. 

[^adopt]: '프로토콜을 채택한다 (adopt)' 는 건 특정 객체를 정의할 때 프로토콜 이름도 붙여서 그 프로토콜을 따르게 한다는 의미입니다. 한편, '프로토콜을 준수한다 (conform)' 는 건 모든 프로토콜 필수 조건들을 구현하여 (그 조건을) 만족한다는 의미입니다.

[^conformance]: 바로 앞에서 설명한 것처럼, '프로토콜 준수성 (conformance) 을 추가한다' 는 건 모든 프로토콜 필수 조건에 대한 구현을 제공한다는 의미입니다. 이렇게 필수 조건에 대한 구현을 제공하려면, 먼저 프로토콜을 채택 (adopt) 해야 합니다. 

[^literal]: '글자 값 (leteral)' 은 '글자 자체의 의미를 가진 값' 정도로 이해할 수 있습니다. 예를 들어, 코드에서 `0` 을 입력할 때 실제로는 문자 '0' 이지만, `let a = 0` 이라고 하면, 컴파일러가 이 `0` 을 '0' 이라는 정수로 이해합니다. 이런 상황에서의 `0` 을 정수 '글자 값 (literal)' 이라고 합니다.

[^read-only]: 설정자 (setter) 없이 획득자 (getter) 만 있으므로 읽기-전용 계산 속성입니다.

[^property-observers]: '속성 관찰자 (property observers)' 는 원래 저장 속성에만 추가할 수 있는 것으로, 계산 속성의 경우 속성이 바뀌는 시점을 자신이 알 수 있어서 속성 관찰자가 필요 없습니다. 속성 관찰자에 대한 더 자세한 정보는, [Properties (속성)]({% link docs/swift-books/swift-programming-language/properties.md %}) 장의 [Property Observers (속성 관찰자)]({% link docs/swift-books/swift-programming-language/properties.md %}#property-observers-속성-관찰자) 부분을 보도록 합니다.

[^access-self]: 익스텐션으로 추가할 수 있는 초기자는 사실상 편의 초기자 역할을 합니다. 구조체의 경우 편의 초기자와 지명 초기자라는 구분은 없지만, 익스텐션으로 추가하는 초기자는 이미 있던 초기자를 활용하여 초기화를 수행합니다. 실제 인스턴스의 메모리는 기존에 이미 있던 초기자가 초기화하는 것입니다.

<!--
접근할려는 인스턴스의 전체 메모리가 초기화되어 있어야 `self` 에 접근할 수 있기 때문입니다. 익스텐션으로 추가하는 초기자는 편의 초기자 클래스와 구조체라는 약간의 차이는 있지만, 스위프트는 '2-단계 초기화' 를 하며, `self` 에 대한 접근은 '1-단계 초기화' 가 완료된 시점부터 가능합니다. 본문에 있는 다른 '지명 초기자' 를 호출 완료한 시점이 '1-단계 초기화' 가 완료된 시점에 해당합니다. '2-단계 초기화' 에 대한 더 자세한 정보는, [Initialization (초기화)]({% link docs/swift-books/swift-programming-language/initialization.md %}) 장에 있는 [Two-Phase Initialization (2-단계 초기화)]({% link docs/swift-books/swift-programming-language/initialization.md %}#two-phase-initialization-2-단계-초기화) 부분을 보도록 합니다.
-->

[^automatic-memberwise-initializer]: '자동 멤버 초기자 (autumatic memberwise initializer)' 라는 이름은 이 '멤버 초기자' 가 명시적인 구현없이, 스위프트의 컴파일러에 의해 자동으로 제공되기 때문에 붙은 이름입니다.
