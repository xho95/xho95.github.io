---
layout: post
comments: true
title:  "Swift 5.5: Extensions (익스텐션; 확장)"
date:   2016-01-19 17:10:00 +0900
categories: Xcode Swift Grammar Extensions
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Extensions](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html) 부분[^Extensions]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Extensions (익스텐션; 확장)

_익스텐션 (extensions; 확장)_[^extension] 은 기존의 클래스나, 구조체, 열거체, 또는 프로토콜 타입에 새로운 기능[^functionality] 을 추가합니다. 이는 원본 소스 코드에 접근할 수 없는 타입을 확장하는 (_소급 적용 모델링 (retroactive modeling)_[^retroactive-modeling] 이라는) 능력도 포함합니다. 익스텐션은 오브젝티브-C 의 카테고리 (categories; 범주) 와 비슷합니다. (오브젝티브-C 의 카테고리와는 달리, 스위프트의 익스텐션엔 이름이 없습니다.)

스위프트의 '익스텐션' 은 다음을 할 수 있습니다:

* '계산 인스턴스 속성' 과 '계산 타입 속성' 을 추가함
* '인스턴스 메소드' 와 '타입 메소드' 를 정의함
* 새로운 '초기자' 를 제공함
* '첨자 연산' 을 정의함
* 새로운 '중첩 타입' 을 정의하고 사용함
* 기존 타입이 프로토콜을 준수하도록 만듦

스위프트에서는, 심지어 프로토콜도 확장하여 '필수 조건 (requirements)' 의 구현을 제공하거나 준수하는 타입이 장점을 취할 수 있는 추가적인 기능을 추가할 수 있습니다. 더 자세한 것은, [Protocol Extensions (프로토콜 익스텐션; 규약 확장)]({% post_url 2016-03-03-Protocols %}#protocol-extensions-프로토콜-익스텐션-규약-확장) 을 참고하기 바랍니다.

> '익스텐션' 은 타입에 새로운 기능을 추가할 순 있지만, 기존 기능을 '재정의 (override)' 할 수는 없습니다.

### Extension Syntax (익스텐션 구문 표현)

'익스텐션' 은 `extension` 키워드로 선언합니다:

```swift
extension SomeType {
  // SomeType 에 추가할 새로운 기능을 여기에 둡니다.
}
```

'익스텐션' 은 기존 타입이 하나 이상의 프로토콜을 '채택 (adopt)' 하게끔 확장할 수 있습니다. 프로토콜 '준수성 (conformance)' 을 추가하려면, 클래스나 구조체에 대해 작성하는 것과 같은 방식으로 프로토콜 이름을 작성합니다:

```swift
extension SomeType: SomeProtocol, AnotherProtocol {
  // 프로토콜의 '필수 조건' 을 여기에서 구현합니다.
}
```

이 같은 방식으로 '프로토콜 준수성' 을 추가하는 것은 [Adding Protocol Conformance with an Extension (익스텐션으로 프로토콜 준수성 추가하기)]({% post_url 2016-03-03-Protocols %}#adding-protocol-conformance-with-an-extension-익스텐션으로-프로토콜-준수성-추가하기) 에서 설명합니다.

'익스텐션' 은, [Extending a Generic Type (일반화 타입을 확장하기)]({% post_url 2020-02-29-Generics %}#extending-a-generic-type-일반화-타입을-확장하기) 에서 설명한 것처럼, 기존 '일반화 (generic) 타입' 을 확장하기 위해 사용할 수 있습니다. '일반화 타입' 은, [Extensions with a Generic Where Clause ('일반화 where 절' 을 가진 익스텐션)]({% post_url 2020-02-29-Generics %}#extensions-with-a-generic-where-clause-일반화-where-절을-가진-익스텐션) 에서 설명한 것처럼, 조건에 따라 기능을 추가하기 위해 확장할 수도 있습니다.

> '익스텐션' 을 기존 타입에 새로운 기능을 추가하기 위해 정의한 경우, 새로운 기능은, '익스텐션' 을 정의하기 전에 생성된 경우이더라도, 해당 타입의 모든 기존 인스턴스에서 사용 가능할 것입니다.

### Computed properties (계산 속성)

'익스텐션' 은 기존 타입에 '계산 인스턴스 속성' 과 '계산 타입 속성' 을 추가할 수 있습니다. 다음 예제는 스위프트에 내장된 `Double` 타입에, '거리 단위' 와의 작업을 위한 기초적인 지원을 제공하는, 다섯 개의 계산 인스턴스 속성을 추가합니다:

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
// "One inch is 0.0254 meters" 를 인쇄합니다.

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// "Three feet is 0.914399970739201 meters" 를 인쇄합니다.
```

이 '계산 속성' 들은 `Double` 값을 정해진 길이 단위로 고려해야 함을 나타냅니다. 비록 계산 속성으로 구현되어 있을지라도, 이 속성의 이름은, 해당 글자 값으로 거리 변환을 하도록, '점 구문 (dot syntax)' 으로 부동-소수점 '글자 값 (literal)'[^literal] 에 덧붙일 수 있습니다.

이 예제에서, `1.0` 이라는 `Double` 값이 "1 미터" 를 표현하는 것으로 고려합니다. 이것이 `m` 이라는 계산 속성이 `self` 를 반환하는 이유입니다-`1.m` 이라는 표현식은 `1.0` 이라는 `Double` 값을 계산한다고 고려합니다.

다른 단위를 미터 측정 값으로 나타내기 위해서는 약간의 변환이 필수입니다. '1 킬로미터' 는 '1,000 미터' 와 같으므로, '`km` 계산 속성' 을 미터로 변환하려면 `1_000.0` 이라는 값을 곱합니다. 이와 비슷하게, '1 미터' 에는 '3.28084 피트 (feet)' 가 있으므로, '`ft` 계산 속성' 은, 피트를 미터로 변환하기 위해, '실제 `Double` 값' 을 `3.28084` 로 나눕니다.

이 속성들은 '읽기-전용 (read-only) 계산 속성' 이므로, 간결함을 위해, `get` 키워드 없이 나타냅니다. 반환 값은 `Double` 타입이며, 수식 계산 안에서 `Double` 을 받아 들이는 곳마다 사용할 수 있습니다:

```swift
let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
// "A marathon is 42195.0 meters long" 을 인쇄합니다.
```

> '익스텐션' 은 기존 속성에 새로운 계산 속성을 추가할 수 있지만, '저장 속성' 이나, '속성 관찰자 (observers)'[^property-observers] 를 추가할 수는 없습니다.

### Initializers (초기자)

'익스텐션' 은 기존 타입에 새로운 '초기자' 를 추가할 수 있습니다. 이는 초기자 매개 변수로 자신이 만든 사용자 정의 타입을 받도록 하거나, 타입의 원본 구현에 포함되지 않은 추가적인 초기화 옵션을 제공하기 위해 다른 타입을 확장할 수 있게 해줍니다.

'익스텐션' 은 클래스에 새로운 '편의 (convenience) 초기자' 추가할 순 있지만, 클래스에 새로운 '지명 (designated) 초기자' 나 '정리자 (deinitializers)' 를 추가할 순 없습니다. '지명 초기자' 나 '정리자' 는 반드시 항상 원본 클래스 구현에서 제공해야 합니다.

모든 저장 속성에 '기본 값' 을 제공하면서 어떤 초기자도 직접 정의하지 않는 값 타입에 '초기자' 추가하기 위해 '익스텐션' 을 사용하는 경우, '익스텐션' 의 초기자 내에서 해당 값 타입을 위한 '기본 (default) 초기자' 와 '멤버 (memberwise) 초기자' 를 호출할 수 있습니다. [Initializer Delegation for Value Types (값 타입을 위한 초기자 맡김)]({% post_url 2016-01-23-Initialization %}#initializer-delegation-for-value-types-값-타입을-위한-초기자-맡김) 에서 설명한 것처럼, 값 타입의 원본 구현에서 초기자를 작성한 경우라면 이렇지 않을 것입니다.

다른 모듈에서 선언한 구조체에 초기자를 추가하려고 '익스텐션' 을 사용한 경우, 새로운 초기자는 정의한 모듈에 있는 초기자를 호출하기 전까지 `self` 에 접근할 수 없습니다.[^access-self]

아래 예제는 기하학적 사각형을 표현하는 `Rect` 구조체를 정의합니다. 이 예제는 `Size` 와 `Point` 라는, 둘 다 모든 속성에 `0.0` 이라는 '기본 값' 을 제공하는, 두 '지원용 구조체' 도 정의합니다:

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

`Rect` 구조체는 모든 속성에 기본 값을 제공하기 때문에, [Default Initializers (기본 초기자)]({% post_url 2016-01-23-Initialization %}#default-initializers-기본-초기자) 에서 설명한 것처럼, '기본 초기자' 와 '멤버 초기자' 를 자동으로 부여 받습니다. 이 초기자를 사용하여 새로운 `Rect` 인스턴스를 생성할 수 있습니다:

```swift
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
```

`Rect` 구조체는 특정 중심점과 크기를 취하는 추가적인 초기자를 제공하도록 확장할 수 있습니다.

```swift
extension Rect {
  init(center: Point, size: Size) {
    let originX = center.x - (size.width / 2)
    let originY = center.y - (size.height / 2)
    self.init(origin: Point(x: originX, y: originY), size: size)
  }
}
```

이 새로운 초기자는 제공한 `center` 점과 `size` 값을 기초로 적절한 원점을 계산하는 것으로 시작합니다. 그런 다음 초기자는, 적절한 속성으로 새로운 원점과 크기 값을 저장한, `init(origin:size:)` 라는 구조체의 '자동 멤버 초기자'[^automatic-memberwise-initializer] 를 호출합니다.

```swift
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
// centerRect 의 원점은 (2.5, 2.5) 이고, 크기는 (3.0, 3.0) 입니다.
```

> '익스텐션' 으로 새로운 초기자를 제공하는 경우에도, 여전히 초기자를 완료할 때 각 해당 인스턴스가 온전히 초기화됐다는 것을 확실히 할 책임이 있습니다.

### Methods (메소드)

'익스텐션' 은 기존 타입에 새로운 '인스턴스 메소드' 와 '타입 메소드' 를 추가할 수 있습니다. 다음 예제는 `Int` 타입에 `repetitions` 이라는 새로운 인스턴스 메소드를 추가합니다:

```swift
extension Int {
  func repetitions(task: () -> Void) {
    for _ in 0..<self {
      task()
    }
  }
}
```

`repetitions(task:)` 메소드는, 매개 변수가 없고 값을 반환하지 않는 함수임을 지시하는, `() -> Void` 타입의 단일 인자를 취합니다.

이 '익스텐션' 을 정의한 후에는, 해당 수만큼 많은 횟수의 작업을 수행하기 위해 어떤 정수에 대해서든 `repetitions(task:)` 메소드를 호출할 수 있습니다:

```swift
3.repetitions {
  print("Hello!")
}

// Hello!
// Hello!
// Hello!
```

#### Mutating Instance Methods (변경 인스턴스 메소드)

'익스텐션' 으로 추가한 '인스턴스 메소드' 도 인스턴스 자체를 수정-또는 _변경 (mutate)_-할 수 있습니다. 구조체와 열거체의 `self` 나 속성을 수정하는 메소드는, 원본 구현에 있는 '변경 메소드' 와 마찬가지로, 인스턴스 메소드를 반드시 `mutating` 이라고 표시해야 합니다.

아래 예제는 스위프트 `Int` 타입에, 원본 값을 '제곱 (square)' 하는, `square` 라는 새로운 '변경 메소드' 를 추가합니다:

```swift
extension Int {
  mutating func square() {
    self = self * self
  }
}

var someInt = 3
someInt.square()
// someInt 는 이제 9 입니다.
```

### Subscripts (첨자)

'익스텐션' 은 기존 타입에 새로운 '첨자' 를 추가할 수 있습니다. 다음 예제는 스위프트에 내장된 `Int` 타입에 '정수 첨자' 을 추가합니다. 이 '첨자 `[n]`' 은 오른쪽에서 `n` 번째 자리에 있는 10-진수의 '자리 값 (digit)' 을 반환합니다.

* `123456789[0]` 은 `9` 를 반환합니다.
* `123456789[1]` 은 `8` 을 반환합니다.

... 이렇게 계속합니다:

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
// 5 를 반환합니다.
746381295[1]
// 9 를 반환합니다.
746381295[2]
// 2 를 반환합니다.
746381295[8]
// 7 을 반환합니다.
```

요청한 색인 만큼 충분한 자리를 `Int` 값이 가지고 있지 않으면, 마치 수 왼쪽이 '0' 으로 채워져 있는 것처럼, '첨자 연산' 구현이 `0` 을 반환합니다:

```swift
746381295[9]
// 마치 아래와 같이 요청한 것처럼, '0' 을 반환합니다:
0746381295[9]
```

### Nested Types (중첩 타입)

'익스텐션' 은 기존 클래스, 구조체, 그리고 열거체에 새로운 '중첩 타입' 을 추가할 수 있습니다:

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

이 예제는 `Int` 에 새로운 '중첩 (nested) 열거체' 를 추가합니다. 이, `Kind` 라는,  열거체는 특별한 정수가 표현하는 수의 종류를 나타냅니다. 특히, 수가 음수인지, '0' 인지, 양수인지를 나타냅니다.

이 예제는 `Int` 에, 해당 정수를 위해 적절한 `Kind` 열거체를 반환하는, `kind` 라는, 새로운 '계산 인스턴스 속성' 도 추가합니다.

'중첩 열거체' 는 이제 어떤 `Int` 값과도 같이 사용할 수 있습니다:

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
// "+ + - 0 - 0 + " 를 인쇄합니다.
```

이, `printIntegerKinds(_:)` 라는, 함수는 `Int` 값 배열을 입력 받아서 그 값들에 차례대로 동작을 반복합니다. 배열에 있는 각각의 정수마다, 함수가 해당 정수의 `kind` 계산 속성을 고려하여, 적절한 설명을 인쇄합니다.

> `number.kind` 는 이미 `Int.Kind` 타입임을 알고 있습니다. 이 때문에, `switch` 문 안에서 모든 `Int.Kind` case 값을, `Int.Kind.negative` 가 아닌 `.negative` 같은, 짧게 줄인 형식으로 작성할 수 있습니다.

### 다음 장

[Protocols (프로토콜; 규약) > ]({% post_url 2016-03-03-Protocols %})

### 참고 자료

[^Extensions]: 원문은 [Extensions](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^extension]: 스위프트의 `extension` 은 확장이라는 의미를 가진 하나의 키워드입니다. 키워드 자체로 사용할 때는 '익스텐션' 이라는 발음 그대로 사용합니다.

[^functionality]: '기능 (functionality) 을 추가한다' 는 건, 타입의 구조를 바꾸는 저장 속성은 추가하지 않는다는 의미를 이미 내포하고 있습니다. 사실 기능만 추가하기 때문에, 기존 타입의 확장 (extension) 이 가능한 것입니다.

[^retroactive-modeling]: 스위프트는, '소급 적용 모델링 (retroactive modeling)' 을 통하여, 스위프트 표준 라이브러리의 타입과 패키지의 타입도 '확장' 할 수 있습니다. '소급 적용 모델링' 에 대한 더 자세한 정보는, 위키피디아의 [Retroactive data structure](https://en.wikipedia.org/wiki/Retroactive_data_structure) 항목을 참고하기 바랍니다.

[^literal]: '글자 값 (leteral)' 은 '글자 자체의 의미를 가진 값' 정도로 이해할 수 있습니다. 예를 들어, 코드에서 `0` 을 입력할 때 실제로는 문자 '0' 이지만, `let a = 0` 이라고 하면, 컴파일러가 이 `0` 을 '0' 이라는 정수로 이해합니다. 이런 상황에서의 `0` 을 정수 '글자 값 (literal)' 이라고 합니다.

[^property-observers]: '속성 관찰자 (property observers)' 자체가 원래 '저장 속성' 에만 추가할 수 있는 것으로, '계산 속성' 의 경우, 속성을 바꾸는 시점을 직접 알 수 있기 때문에 '속성 관찰자' 가 필요 없습니다. '속성 관찰자' 에 대한 더 자세한 정보는, [Properties (속성)]({% post_url 2020-05-30-Properties %}) 장의 [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 부분을 참고하기 바랍니다.

[^access-self]: 이는, `self` 에 접근하기 위해선, 접근하려는 인스턴스의 메모리가 온전하게 초기화되어 있어야 하기 때문입니다. 클래스와 구조체라는 약간의 차이는 있지만, 스위프트는 '2-단계 초기화' 를 하며, `self` 에 대한 접근은 '1-단계 초기화' 가 완료된 시점부터 가능합니다. 본문에 있는 다른 '지명 초기자' 를 호출 완료한 시점이 '1-단계 초기화' 가 완료된 시점에 해당합니다. '2-단계 초기화' 에 대한 더 자세한 정보는, [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 장에 있는 [Two-Phase Initialization (2-단계 초기화)]({% post_url 2016-01-23-Initialization %}#two-phase-initialization-2-단계-초기화) 부분을 참고하기 바랍니다.

[^automatic-memberwise-initializer]: '자동 멤버 초기자 (autumatic memberwise initializer)' 라는 이름은 이 '멤버 초기자' 가 명시적인 구현없이, 스위프트의 컴파일러에 의해 자동으로 제공되기 때문에 붙은 이름입니다.
