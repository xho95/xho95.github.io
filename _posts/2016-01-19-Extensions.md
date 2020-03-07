---
layout: post
comments: true
title:  "Swift 5.2: Extensions (확장)"
date:   2016-01-19 17:10:00 +0900
categories: Xcode Swift Grammar Extensions
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Extensions](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html) 부분[^Extensions]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Extensions (확장)

_익스텐션 (Extensions)_ [^extension]은 이미 존재하는 클래스, 구조체, 열거체[^enumeration] 또는 프로토콜 타입에 새로운 기능 (functionality)[^functionality] 을 추가하는 식으로 확장하는 것입니다. 원본 소스 코드에 접근할 수 없는 타입도 확장이 가능합니다. (이를 _`retroactive modeling (소급 적용 모델링)`_ 이라고 합니다.)[^retroactive-modeling] 익스텐션은 오브젝티브-C 의 카테고리 (categries) 와 유사합니다. (하지만 오브젝티브-C 의 카테고리와는 다르게, 스위프트의 익스텐션은 이름을 가지지 않습니다.)

스위프트의 익스텐션은 다음과 같은 것들을 할 수 있습니다:

* 계산 인스턴스 속성 (computed instance properties) 및 계산 타입 속성 (computed type properties) 추가하기
* 인스턴스 메소드 (instance methods 및 타입 메소드 (type methods) 정의하기
* 새로운 초기자 (initializer) 제공하기
* 첨자 연산자 (subscripts) 정의하기
* 새로운 '품어진 타입 (nested types)' 정의하고 사용하기
* 기존 타입이 특정한 프로토콜을 준수하도록 만들기

스위프트에서는 프로토콜도 확장할 수 있어서, 요구 사항 (requirements) 에 대한 구현을 제공하거나 추가 기능을 덧붙여서 준수하는 타입에게 편의를 제공할 수 있습니다. 이에 대한 자세한 내용은 **Protocol Extensions (프로토콜 확장)** 을 참고하기 바랍니다.

> 익스텐션은 타입에 새로운 기능을 추가할 수 있지만, 이미 있는 기능을 덮어쓸 (override) 수는 없습니다.

### Extension Syntax (확장 문법)

익스텐션을 선언할 때는 `extension` 키워드를 사용합니다:

```swift
extension SomeType {
  // 여기에 SomeType 에 추가할 새 기능을 작성합니다.
}
```

익스텐션으로 기존 타입을 확장하여 하나 이상의 프로토콜을 채택 (adopt) 하도록 만들 수 있습니다. 프로토콜을 준수하도록 (protocol conformance) 하려면 프로토콜 이름을 써주면 되는데 클래스나 구조체의 이름을 쓰는 것과 방식이 같다고 보면 됩니다:

```swift
extension SomeType: SomeProtocol, AnotherProtocol {
  // 여기에 프로토콜의 요구 사항에 대한 구현을 작성합니다.
}
```

이와 같은 방식으로 프로토콜을 준수하도록 하는 방법은 **Adding Protocol Conformance with an Extension (익스텐션으로 프로토콜 준수하도록 만들기)** 부분에서 더 설명하도록 합니다.

익스텐션으로 이미 존재하는 일반화된 타입 (generic type) 도 확장할 수 있으며, 이는 **Extending a Generic Type (일반화된 타입 확장하기)** 에서 설명합니다. 일반화된 타입을 확장할 때 조건부로 기능을 추가할 수도 있는데, 이는 **Extensions with a Generic Where Clause (일반화된 Where 구절을 사용하여 확장하기)** 에서 설명하도록 합니다.

> 익스텐션을 정의해서 기존 타입에 새 기능을 추가하면, 이 기능은 해당하는 타입의 이미 존재하는 모든 인스턴스에서 사용할수 있으며, 익스텐션이 정의되기 전에 생성된 인스턴스도 예외가 아닙니다.

### Computed properties (계산 속성)

익스텐션으로 이미 존재하는 타입에 계산 인스턴스 속성 (computed instance properties) 과 계산 타입 속성 (computed type properties) 을 추가할 수 있습니다. 아래 예제는 스위프트에 내장된 타입인 `Double` 에 다섯 개의 계산 인스턴스 속성을 추가해서, 거리 단위 작업을 지원하는 방법을 보여줍니다.

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
// Prints "One inch is 0.0254 meters"

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints "Three feet is 0.914399970739201 meters"
```

이 계산 속성들 (computed properties) 을 사용하면 `Double` 값이 길이 단위를 가진 것처럼 표현할 수 있습니다. 비록 계산 속성으로 구현되었더라도, 속성의 이름을 '부동-소수점 문자 값 (floating-point literal value)'[^literal] 뒤에 점을 찍고 붙여서, 거리 변환을 수행하여 사용할 수 있습니다.   

이 예에서, `Double` 값 `1.0` 은 "1 미터" 를 나타내는 것으로 볼 수 있습니다. 이것이 계산 속성 `m` 이 `self` 를 반환하는 이유인데-`1.m` 이라는 표현은 `Double` 값 `1.0` 으로 계산되기 때문입니다.

다른 단위들은 미터 기준으로 표현하기 위해 약간의 변환이 필요합니다. 1 킬로미터는 1,000 미터와 같으므로, `km` 계산 속성은 `1_000.0` 을 곱해서 미터 기준으로 변환합니다. 마찬가지로 1 미터는 3.28084 피트이므로,`ft` 계산 속성은 `Double` 값 `3.28084` 로 나눠서 피트 값을 미터로 변환합니다.

이 속성들은 '읽기-전용 계산 속성 (read-only computed properties)' 이므로, `get` 키워드 없이 간결하게 작성할 수도 있습니다. 반환 값은 `Double` 타입이며, `Double` 을 쓸 수 있다면 어디서나 수학 계산과 함께 쓸 수 있습니다.

```swift
let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
// Prints "A marathon is 42195.0 meters long"
```

> 익스텐션은 이미 존재하는 속성들에 계산 속성을 새로 추가할 수는 있지만, 저장 속성 (stored properties)이나 속성 옵져버 (property observers) 를 추가할 수는 없습니다.

### Initializers

익스텐션은 이미 존재하는 타입에 초기자 (initializer) 를 새로 추가할 수 있습니다. 이를 활용하면, 다른 타입을 확장해서 초기자의 매개 변수로 내가 만든 타입도 넘겨줄 수 있으며, 원래 타입의 구현에는 없던 새로운 초기자 옵션을 제공하는 것도 가능해집니다.

익스텐션은 클래스에 편의 초기자 (convenience initializers)를 새로 추가할 수는 있지만, 지명된 초기자 (designated initializers) 나 정리자 (deinitializers) 를 추가할 수는 없습니다. 지명된 초기자나 해제자는 반드시 본래의 클래스 구현에서 제공해야만 합니다.

익스텐션을 사용해서 값 타입에 초기자를 추가하는 경우 중에서, 해당 값 타입이 모든 저장 속성에 기본 값을 제공하면서도 초기자가 정의된 것이 하나도 없는 경우, 익스텐션 내의 초기자에서 기본 초기자 (default initializer) 와 멤버 초기자 (memberwise initializer) 를 호출할 수 있습니다. 값 타입의 원래 구현에 초기자가 하나라도 있는 경우에는 해당하지 않으며, 이는 **Initializer Delegation for Value Types (값 타입을 위한 초기자의 위임)** 에 설명되어 있습니다.

익스텐션을 사용해서 다른 모듈에서 선언한 구조체에 초기자를 추가할 경우, 이 새 초기자 내에서 `self` 에 접근하려면 모듈에서 정의된 초기자 중 하나를 먼저 호출해야만 합니다.

아래는 기하학적인 사각형을 표현하는 `Rect` 구조체를 정의하는 예제입니다. 이 예제는 `Size` 와 `Point` 라는 두 개의 구조체도 정의하는데, 둘 다 모든 속성의 기본 값이 `0.0` 입니다:

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

`Rect` 구조체는 모든 속성에 기본 값을 제공하고 있으므로, **Default Initializers (기본 초기자)** 에 설명한 것처럼, 자동으로 '기본 초기자'와 '멤버 초기자'를 가지게 됩니다. 이 초기자로 새 `Rect` 인스턴스를 만들 수 있습니다:

```swift
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
```

`Rect` 구조체를 확장하여 특정 중심점과 크기를 가지는 초기자를 추가로 제공할 수도 있습니다.

```swift
extension Rect {
  init(center: Point, size: Size) {
    let originX = center.x - (size.width / 2)
    let originY = center.y - (size.height / 2)
    self.init(origin: Point(x: originX, y: originY), size: size)
  }
}
```

이 새 초기자는 먼저 주어진 `center` (중심점) 과 `size` (크기) 값을 바탕으로 적절한 원점을 계산합니다. 그 다음으로 구조체가 자동으로 가지는 멤버 초기자인 `init(origin:size:)` 를 호출하여, 적절한 속성에 새 원점과 크기 값을 저장하도록 시킵니다.

```swift
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
// centerRect 의 원점은 (2.5, 2.5) 이고, 크기는 (3.0, 3.0) 입니다.
```

> 익스텐션으로 새 초기자를 제공하는 경우에도, 초기자가 완료되는 시점에 각 인스턴스가 온전히 초기화되도록 하는 것은 여전히 여러분 몫입니다.

### Methods

익스텐션으로 기존 타입에 새로운 인스턴스 메소드 (instance methods) 와 타입 메소드 (type methods) 를 추가할 수 있습니다. 아래 예제는 `Int` 타입에 새로 `repetitions` (반복) 이라는 인스턴스 메소드를 추가하고 있습니다:

```swift
extension Int {
  func repetitions(task: () -> Void) {
    for _ in 0..<self {
      task()
    }
  }
}
```

`repetitions(task:)` 메소드는 인자로 `() -> Void` 타입의 값 하나만을 가지는데, 이는 매개 변수도 없고 반환 값도 없는 함수를 의미합니다.

이 익스텐션 (확장) 을 정의한 후에는 어떤 정수 값에서도 `repetitions(task:)` 메소드를 호출할 수 있어서 여러 번의 임무를 반복 수행할 수 있습니다.

```swift
3.repetitions {
  print("Hello!")
}

// Hello!
// Hello!
// Hello!
```

#### Mutating Instance Methods (인스턴스를 변경하는 메소드)

익스텐션으로 추가된 인스턴스 메소드는 인스턴스 자체를 수정 (또는 _변경 (mutate)_) 할 수도 있습니다. 구조체 또는 열거체에서 `self` 나 속성을 수정하는 메소드는 반드시 인스턴스 메소드에 `mutating` 을 표기해야 하며, 이는 원 구현의 '변경 메소드 (mutating methods)' 와 같은 방식입니다.

아래는 스위프트의 `Int` 타입에 `square` (제곱) 이라는 새로운 변경 메소드를 추가하는 예제로, 원래의 값을 제곱합니다.

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

### Subscripts (첨자 연산)

익스텐션으로 기존 타입에 새 '첨자 연산 (subscripts)'을 추가할 수 있습니다. 아래는 스위프트 내장 타입인 `Int` 에 정수 첨자 연산 (integer subscripts) 을 추가하는 예제입니다. 첨자 연산 `[n]` 은 주어진 수의 오른쪽 `n` 번째 자리 값을 10진수로 반환합니다.

* `123456789[0]` 은 `9` 를 반환합니다.
* `123456789[1]` 은 `8` 을 반환합니다.

... 이런 식으로 계속됩니다:

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

`Int` 값이 가진 숫자 개수보다 큰 값으로 요청하면, 첨자 연산이 `0` 을 반환하는데, 이는 수 왼쪽이 `0`으로 채워진 것으로 이해하면 됩니다:

```swift
746381295[9]
// 마치 아래와 같이 요청한 것처럼, 0 을 반환합니다:
0746381295[9]
```

### Nested Types (품어진 타입)

익스텐션을 써서 이미 존재하는 클래스, 구조체, 그리고 열거체에 '품어진 타입 (nested type)'[^nested-type]을 새로 추가할 수 있습니다:

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

이 예제는 `Int` 에 '품어진 열거체'를 새로 추가합니다. 이 열거체는 `Kind` 라고 하는데 정수가 나타내는 수의 종류를 표시합니다. 특히 이 수가 음수인지, 0 인지, 양수인지를 표시합니다.

이 예제는 또 `Int` 에 `kind` 라는 새로운 '계산 인스턴스 속성'을 추가해서, 이 정수에 맞는 적당한 `Kind` 열거체의 사례 값[^case]을 반환합니다.

이제 '품어진 열거체'는 모든 `Int` 값에서 사용할 수 있습니다:

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
// Prints "+ + - 0 - 0 + "
```

`printIntegerKinds(_:)` 함수는 `Int` 값의 배열을 입력받아서 다음과 같은 계산을 순차적으로 진행합니다. 배열의 각 정수마다, 이 정수의 `kind` 계산 속성 값을 고려하여, 알맞은 설명을 출력합니다.

> `number.kind` 는 이미 `Int.Kind` 타입인 것을 알 수 있습니다. 이로 인해, `switch` 구문 내의 모든 `Int.Kind` 사례 값 (case values) 은 `Int.Kind.negative` 가 아니라 `.negative` 와 같은 축약된 형태 (shorthand form) 로 쓸 수 있습니다.

### 참고 자료

[^Extensions]: 원문은 [Extensions](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html) 에서 확인할 수 있습니다.

[^extension]: `extension` 은 키워드이기도 하면서 '확장'이라는 뜻도 가지고 있는데, 키워드로 사용될 때는 익스텐션이라고 발음으로 옮기고, 확장이라는 의미로 사용될 때는 '확장'이라고 옮기도록 합니다.

[^enumeration]: `class` 를 '객체', `structure` 를 '구조체' 라고 하듯이, 일관성을 유지하기 위해서 `enumeration` 을 '열거체' 라고 옮깁니다.

[^functionality]: 여기서 기능이라는 말이 중요한데, 확장 (extensions) 은 대상의 구조는 변화시키지 않고 기능만을 더하는 것입니다. 클래스를 예로 들면 실제로 새로운 '속성'이 추가되는 것은 없고 일종의 '메소드' -또는 메소드에 준하는 요소-만 추가된다고 볼 수 있습니다.

[^retroactive-modeling]: 즉 스위프트 표준 라이브러리에서 제공하는 타입이나 패키지에 있는 타입들도 확장 (extensions) 할 수 있습니다. 이것 역시 확장이 대상의 구조 변화없이 기능만을 추가하기 때문이기도 합니다.

[^literal]: `leteral` 은 문자로 표현된 것을 말하며, `leteral value` 는 '문자로 표현된 값'을 말합니다 .예를 들어 코드에서 `0` 이라고 작성할 때 실제로는 문자 '0' 을 입력한 것이지만, `let a = 0` 에서의 `0` 은 하나의 수를 나타냅니다. 여기서 `0` 을 `integer literal value (정수 문자 값)` 라고 하며 '문자로 표현된 정수 값'이라는 의미를 갖습니다.

[^nested-type]: 'nested types' 은 일단 '품어진 타입'으로 옮기도록 합니다.

[^case]: `case` 에 적당한 말을 아직 못 찾았습니다. 임시로 '사례 값'으로 옮깁니다.
