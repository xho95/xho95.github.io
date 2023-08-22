---
layout: post
comments: true
title:  "Opaque Types and Boxed Types (불투명 타입과 상자 타입)"
date:   2020-02-22 11:30:00 +0900
categories: Swift Language Grammar Opaque Type
---

{% include header_swift_book.md %}

## Opaque Types and Boxed Types (불투명 타입과 상자 타입)

스위프트는 값의 타입에 대한 자세한 것을 숨기는 두 가지 방법인: 불투명 타입과 상자 프로토콜 타입을 제공합니다. 타입 정보를 감추는 건 모듈과 그 모듈 안을 호출하는 코드의 경계 지점에서 유용한데, 반환 값 밑에 놓인 타입을 개인 전용[^private] 으로 남겨둘 수 있기 때문입니다.  

불투명 반환 타입을 가진 함수나 메소드는 반환 값의 타입 정보를 숨깁니다. 함수 반환 타입으로 고정 타입을 제공하는 대신, 자신이 지원하는 프로토콜로써 반환 값을 설명합니다. 반환할 값의 타입이 프로토콜 타입일 때와 달리, 불투명 타입은 타입 정체성[^type-identity] 을 보존합니다-컴파일러는 타입 정보에 접근하지만, 모듈의 사용자는 아닙니다.

상자 프로토콜 타입은 주어진 프로토콜을 따르는 어떠한 타입의 인스턴스든 저장할 수 있습니다. 상자 프로토콜 타입은 타입 정보를 보존하지 않습니다-값의 타입은 실행 시간 전까진 알 수 없으며, 시간이 지나가면서 다른 값이 저장되면 바뀔 수 있습니다. 

### The Problem That Opaque Types Solve (불투명 타입으로 푸는 문제)

예를 들어, **ASCII** 로 예술 도형을 그리는 모듈을 작성하고 있다고 가정합니다. ASCII 예술 도형의 기본 성질은 그 도형을 문자열로 나타낸 걸 반환하는 `draw()` 함수인데, 이를 `Shape` 프로토콜의 필수 조건[^requirement] 으로 사용할 수 있습니다:

```swift
protocol Shape {
  func draw() -> String
}

struct Triangle: Shape {
  var size: Int
  func draw() -> String {
    var result = [String]()
    for length in 1...size {
      result.append(String(repeating: "*", count: length))
    }
    return result.joined(separator: "\n")
  }
}

let smallTriangle = Triangle(size: 3)
print(smallTriangle.draw())
// *
// **
// ***
```

일반화를 사용하면, 아래 코드에서 보듯, 도형을 수직으로 뒤집는 연산도 구현할 수 있을 것입니다. 하지만, 이 접근법에는 중요한 한계가 있는데: 뒤집은 결과를 생성하는데 사용한 일반화 타입이 정확하게 드러난다는 겁니다.[^flippedTriangle-Type]

```swift
struct FlippedShape<T: Shape>: Shape {
  var shape: T
  func draw() -> String {
    let lines = shape.draw().split(separator: "\n")
    return lines.reversed().joined(separator: "\n")
  }
}

let flippedTriangle = FlippedShape(shape: smallTriangle)
print(flippedTriangle.draw())

// ***
// **
// *
```

이 접근법으로 `JoinedShape<T: Shape, U: Shape>` 구조체를 정의하여 두 도형을 수직으로 함께 맞붙이면, 아래 코드에서 보는 것처럼, 뒤집은 삼각형과 또 다른 삼각형을 맞붙임으로써 `JoinedShape<Triangle, FlippedShape<Triangle>>` 같은 타입이 되버립니다.[^joinedTriangle-Type]

```swift
struct JoinedShape<T: Shape, U: Shape>: Shape {
  var top: T
  var bottom: U
  func draw() -> String {
    return top.draw() + "\n" + bottom.draw()
  }
}

let joinedTriangle = JoinedShape(top: smallTriangle, bottom: flippedTriangle)
print(joinedTriangle.draw())

// *
// **
// ***
// ***
// **
// *
```

도형 생성의 세부 정보를 드러내는 건 전체 반환 타입을 알려줘야할 필요성 때문에 ASCII 예술 모듈의 공용 인터페이스가 아닌 타입이 유출되도록 합니다. 모듈 안의 코드는 다양한 방법으로 동일한 도형을 제작할 수 있어야 하고, 모듈 밖에서 도형을 사용할 다른 코드는 변형 목록의 세세한 구현을 밝히지 않는게 좋습니다. `JoinedShape` 과 `FlippedShape` 같은 포장 타입[^wrapper-types] 은 모듈 사용자에겐 중요하지 않으며, 보이지 않는게 좋습니다. 모듈의 공용 인터페이스는 도형 맞붙이기 (joining) 와 뒤집기 (flipping) 같은 연산들로 구성하며, 이러한 연산은 또 다른 `Shape` 값을 반환합니다.

### Returning an Opaque Type (불투명 타입 반환하기)

불투명 타입은 일반화 타입의 역방향이라고 생각할 수 있습니다. 일반화 타입은 그 함수의 매개 변수와 반환 값 타입을 함수를 호출하는 코드가 고르게 해서 함수 구현을 추상화하는 방식입니다. 예를 들어, 다음 코드에 있는 함수의 반환 타입은 자신을 호출한 쪽에 달려있습니다:

```swift
func max<T>(_ x: T, _ y: T) -> T where T: Comparable { ... }
```

`max(_:_:)` 를 호출한 코드가 `x` 와 `y` 의 값을 선택하며, 이 값들의 타입이 `T` 라는 고정 타입을 결정합니다. 호출 코드는 `Comparable` 프로토콜을 준수한 어떤 타입이든 사용할 수 있습니다. 함수 안의 코드는 일반적인 (general) 방식으로 작성하므로 호출한 쪽이 무슨 타입을 제공하든 처리할 수 있습니다. `max(_:_:)` 구현부는 모든 `Comparable` 타입이 공유하는 기능만을 사용합니다.

불투명 반환 타입을 가진 함수에선 이 역할들이 역방향입니다. 불투명 타입은 함수 구현부가 자신의 반환 값 타입을 고르게 해서 함수 호출 코드를 추상화하는 방식입니다. 예를 들어, 다음 예제의 함수는 사다리꼴 (trapezoid) 이라는 실제 도형 타입을 드러내지 않고도 이를 반환합니다.

```swift
struct Square: Shape {
  var size: Int
  func draw() -> String {
    let line = String(repeating: "*", count: size)
    let result = Array<String>(repeating: line, count: size)
    return result.joined(separator: "\n")
  }
}

func makeTrapezoid() -> some Shape {
  let top = Triangle(size: 2)
  let middle = Square(size: 2)
  let bottom = FlippedShape(shape: top)
  let trapezoid = JoinedShape(top: top, bottom: JoinedShape(top: middle, bottom: bottom))
  return trapezoid
}

let trapezoid = makeTrapezoid()
print(trapezoid.draw())

// *
// **
// **
// **
// **
// *
```

이 예제는 `makeTrapezoid()` 함수의 반환 타입이 `some Shape` 이라고 선언하며; 그 결과, 어떤 특별한 고정 타입을 지정하지 않고도, 함수가 `Shape` 프로토콜을 준수한 어떠한 주어진 타입 값을 반환합니다. `makeTrapezoid()` 함수를 이런 식으로 작성하면 공용 인터페이스에 도형의 특정 타입을 만들지 않고도-반환 값이 도형이라는-공용 인터페이스의 기본적인 측면을 표현하도록 해줍니다. 이 구현은 두 개의 삼각형과 한 개의 정사각형을 사용하지만, 함수의 반환 타입을 바꾸지 않고도 다양한 방식으로 사다리꼴을 그리게 재작성할 수도 있습니다.

이 예제는 불투명 반환 타입이 일반화 타입의 역방향과 같다는 걸 강조합니다. `makeTrapezoid()` 안의 코드는, 일반화 함수의 호출 코드가 하듯이, 그 타입이 `Shape` 프로토콜을 준수하는 한, 필요한 어떤 타입이든 반환할 수 있습니다. 함수 호출 코드는, 일반화 함수의 구현부 같이, 일반적인 방식으로 작성할 필요가 있는데, 그래야 `makeTrapezoid()` 가 반환한 어떤 `Shape` 과도 작업할 수 있습니다.

불투명 반환 타입과 일반화를 조합할 수도 있습니다. 다음 코드에 있는 함수는 둘 다 `Shape` 프로토콜을 준수하는 어떠한 (some) 타입의 값을 반환합니다.

```swift
func flip<T: Shape>(_ shape: T) -> some Shape {
  return FlippedShaped(shape: shape)
}

func join<T: Shape, U: Shape>(_ top: T, _ bottom: U) -> some Shape {
  JoinedShape(top: top, bottom: bottom)
}

let opaqueJoinedTriangles = join(smallTriangle, flip(smallTriangle))
print(opaqueJoinedTriangles.draw())

// *
// **
// ***
// ***
// **
// *
```

이 예제의 `opaqueJoinedTriangles` 값은 이 장 앞의 [The Problem That Opaque Types Solve (불투명 타입으로 푸는 문제)](#the-problem-that-opaque-types-solve-불투명-타입으로-푸는-문제) 절의 일반화 예제에 있는 `joinedTriangles` 과 똑같습니다. 하지만, 그 예제의 값과 달리, `flip(_:)` 과 `join(_:_:)` 은 일반화 도형 연산이 반환할 실제 타입을 불투명 반환 타입 안에 포장하여, 그 타입들이 보이는 걸 막습니다. 함수가 일반화 타입에 의지하기 때문에 둘 다 일반화이고, 함수의 타입 매개 변수가 `FlippedShape` 과 `JoinedShape` 에 필요한 타입 정보를 전달합니다.

불투명 반환 타입을 가진 함수가 여러 곳에서 반환을 한다면, 가능한 모든 반환 값의 타입은 반드시 똑같아야 합니다. 일반화 함수에선, 그 반환 타입으로 함수의 일반화 타입 매개 변수를 사용할 순 있지만, 반드시 여전히 단일 타입이어야 합니다. 예를 들어, 정사각형이라는 특수한 경우를 포함한 도형-뒤집기 함수의 _무효한 (invalid)_ 버전[^invalid-code] 은 이렇습니다:

```swift
func invalidFlip<T: Shape>(_ shape: T) -> some Shape {
  if shape is Square {
    return shape                      // 에러: 반환 타입이 일치하지 않음
  }
  return FlippedShape(shape: shape)   // 에러: 반환 타입이 일치하지 않음
}
```

`Square` 를 가지고 이 함수를 호출하면, `Square` 를 반환하며; 그 외 경우, `FlippedShape` 을 반환합니다. 이는 한 가지 타입의 값만 반환한다는 필수 조건을 위반하여 `invalidFlip(_:)` 을 무효한 코드로 만듭니다. `invalidFlip(_:)` 을 고치는 한 방법은, 정사각형이라는 특수한 경우를 `FlippedShape` 구현 안으로 이동하여, 이 함수가 항상 `FlippedShape` 값을 반환하게 하는 겁니다:

```swift
struct FlippedShape<T: Shape>: Shape {
  var shape: T
  func draw() -> String {
    if shape is Square {
      return shape.draw()
    }
    let lines = shape.draw().split(separator: "\n")
    return lines.reversed().joined(separator: "\n")
  }
}
```

항상 단일한 타입을 반환하라는 필수 조건이 불투명 반환 타입에 일반화를 사용하는 걸 막는 건 아닙니다. 함수의 타입 매개 변수를 반환 값의 실제 타입 안에 편입하는 예제는 이렇습니다:

```swift
func `repeat`<T: Shape>(shape: T, count: Int) -> some Collection {
  return Array<T>(repeating: shape, count: count)
}
```

이 경우, 반환 값의 실제 타입은 `T` 에 의존하는데: 무슨 도형을 전달하든, `repeat(shape:count:)` 는 그 도형의 배열을 생성하고 반환합니다. 그럼에도 불구하고, 반환 값의 실제 타입이 항상 `[T]` 로 똑같아서, 불투명 반환 타입을 가진 함수는 반드시 단일 타입의 값만 반환해야 한다는 필수 조건도 따릅니다.

### Differences Between Opaque Types and Protocol Types (불투명 타입과 프로토콜 타입의 차이)

불투명 타입을 반환하는 건 함수 반환 타입으로 프로토콜 타입을 사용하는 것과 매우 비슷해 보이지만, 이 두 종류의 반환 타입은 타입 정체성[^differ-type-identity] 을 보존하는 지가 다릅니다. 불투명 타입은 하나의 특정 타입을 참조하지만, 함수를 호출한 쪽이 어느 타입인지 보는게 불가능하며; 프로토콜 타입은 프로토콜을 준수한 어떤 타입이든 참조할 수 있습니다. 일반적으로 말해서, 프로토콜 타입이 저장 값의 실제 타입에 대해 더 많은 유연함을 주고, 불투명 타입이 그러한 실제 타입을 더 강하게 보증하도록 합니다.

예를 들어, 자신의 반환 타입으로 불투명 반환 타입 대신 프로토콜 타입을 사용한 `flip(_:)` 버전은 이렇습니다:

```swift
func protoFlip<T: Shape>(_ shape: T) -> Shape {
  return FlippedShape(shape: shape)
}
```

이 버전의 `protoFlip(_:)` 은 `flip(_:)` 과 동일한 본문을 가지며, 항상 동일한 타입의 값을 반환합니다. `flip(_:)` 과는 달리, `protoFlip(_:)` 이 반환하는 값은 항상 동일한 타입일 걸 요구하지 않습니다-그냥 `Shape` 프로토콜을 준수하면 됩니다. 다른 식으로 말하면, `protoFlip(_:)` 이 자신을 호출한 쪽과 맺는 API 계약은 `flip(_:)` 보다 더 많이 느슨합니다. 이는 여러 타입의 값을 반환하는 유연함을 남겨두고 있습니다:

```swift
func protoFlip<T: Shape>(_ shape: T) -> Shape {
  if shape is Square {
    return shape
  }
  return FlippedShape(shape: shape)
}
```

뜯어 고친 코드는, 무슨 도형을 전달했는 지에 따라, `Square` 인스턴스나 `FlippedShape` 인스턴스를 반환합니다. 이 함수가 반환할 뒤집은 도형 두 개는 서로 완전히 다른 타입일 지도 모릅니다. 이 함수의 유효한 버전 중에 어떤 건 여러 개의 동일한 도형 인스턴스를 뒤집을 때 서로 다른 타입의 값을 반환할 수도 있습니다. `protoFlip(_:)` 의 반환 타입 정보가 덜 특정하다는 건 타입 정보에 의존하는 수많은 연산을 반환 값에 사용할 수 없다는 의미입니다.[^less-sepcific] 예를 들어, `==` 연산자를 써서 이 함수의 반환 결과를 비교하는 건 불가능합니다.

```swift
let protoFlippedTriangle = protoFlip(smallTriangle)
let sameThing = protoFlip(smallTriangle)
protoFlippedTriangle == sameThing     //  에러
```

예제 마지막 줄 에러는 여러가지 이유로 일어납니다. 직접적인 문제점은 `Shape` 의 프로토콜 필수 조건엔 `==` 연산자가 포함되지 않는다는 겁니다. 이를 추가하려고 하면, 그 다음 마주칠 문제점은 `==` 연산자가 자신의 왼-쪽 및 오른-쪽 인자 타입을 알 필요가 있다는 겁니다. 이런 종류의 연산자는 평소에 `Self` 타입의 인자를 취하여, 무슨 타입이 프로토콜을 채택하든 일치하도록 하지만, 프로토콜에 `Self` 필수 조건을 추가하면 프로토콜을 타입으로 사용할 때 발생하는 타입 삭제 (type erasure) 를 허용하지 않습니다.

프로토콜 타입을 함수의 반환 타입으로 사용하면 프로토콜을 준수하는 어떤 타입도 반환할 수 있는 유연함을 줍니다. 하지만, 그 유연함의 대가는 반환 값에 대해서 일부 연산이 불가능하다는 겁니다. 예제는 `==` 연산자가 가능하지 않은 이유-프로토콜 타입의 사용으론 보존되지 않는 특정 타입 정보에 의존한다는 것-을 보여줍니다.

이 접근법이 가진 또 다른 문제는 도형의 변형을 중첩하지 않는다는 겁니다. 삼각형을 뒤집은 결과는 `Shape` 타입의 값이고, `protoFlip(_:)` 함수는 `Shape` 프로토콜을 준수한 어떠한 타입인 인자를 취합니다. 하지만, 프로토콜 타입의 값은 그 프로토콜을 준수하지 않으며[^protocol-type-value]; `protoFlip(_:)` 이 반환한 값은 `Shape` 을 준수하지 않습니다. 이는 여러 번 변형하는 `protoFlip(protoFlip(smallTriangle))` 같은 코드는 무효라는 의미인데 뒤집은 도형은 `protoFlip(_:)` 의 유효 인자가 아니기 때문입니다.[^invalid-flipped]

이와 대조하여, 불투명 타입은 실제 타입의 정체성을 보존합니다. 스위프트가 결합 타입[^associated-types] 을 추론할 수 있어서, 반환 값으로 프로토콜 타입을 사용할 수 없는 곳에서 불투명 타입 값 을 사용하도록 해줍니다. 예를 들어, [Generics (일반화)]({% link docs/swift-books/swift-programming-language/generics.md %}) 에 있는 한 `Container` 프로토콜 버전입니다:

```swift
protocol Container {
  associatedtype Item
  var count: Int { get }
  subscript(i: Int) -> Item { get }
}
extension Array: Container { }
```

`Container` 프로토콜엔 결합 타입이 있기 때문에 함수의 반환 타입으로 이를 사용할 순 없습니다. 일반화 타입의 구속 조건으로도 사용할 수 없는데 이는 함수 외부에 일반화 타입을 추론하는데 필요한 충분한 정보가 없기 때문입니다.

```swift
// 에러: 결합 타입이 있는 프로토콜은 반환 타입으로 사용할 수 없음
func makeProtocolContainer<T>(item: T) -> Container {
  return [item]
}

// 에러: C 를 추론할 충분한 정보가 없음
func makeProtocolContainer<T, C: Container>(item: T) -> C {
  return [item]
}
```

반환 타입으로 불투명 타입인 `some Container` 를 사용하면-함수가 컨테이너를 반환하지만, 컨테이너의 타입을 지정하는 건 거절한다는-원하는 API 계약을 표현합니다:

```swift
func makeOpaqueContainer<T>(item: T) -> some Container {
  return [item]
}

let opaqueContainer = makeOpaqueContainer(item: 12)
let twelve = opaqueContainer[0]
print(type(of: twelve))
// "Int" 를 인쇄함
```

`twelve` 의 타입은 `Int` 로 추론하는데, 이는 타입 추론[^type-inference] 이 불투명 타입에도 작동한다는 사실을 묘사합니다. `makeOpaqueContainer(item:)` 구현에선, 불투명 컨테이너의 실제 타입은 `[T]` 입니다. 이 경우, `T` 는 `Int` 이므로, 반환 값은 정수 배열이며 결합 타입인 `Item` 은 `Int` 라고 추론합니다. `Container` 의 첨자는 `Item` 을 반환하는데, 이는 `twelve` 의 타입도 `Int` 라고 추론한다는 의미합니다.

### 다음 장

[Automatic Reference Counting (자동 참조 카운팅) >]({% link docs/swift-books/swift-programming-language/automatic-reference-counting.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [Opaque Types](https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html) 에서 볼 수 있습니다.

[^private]: '개인 전용 (private)' 은 스위프트의 '개체 (entity)' 에 대한 '접근 수준' 이 `private` 인 것을 말합니다. '개인 전용' 에 대한 더 자세한 정보는, [Access Control (접근 제어)]({% link docs/swift-books/swift-programming-language/access-control.md %}) 장에 있는 [Access Levels (접근 수준)]({% link docs/swift-books/swift-programming-language/access-control.md %}#access-levels-접근-수준) 부분을 보도록 합니다.

[^type-identity]: '타입 정체성 (type identity) 을 보존한다' 는 건 불투명 타입을 사용하면 한 특정한 타입이 계속 유지된다 의미입니다. 프로토콜은 그 프로토콜을 준수하는 어떤 타입이든 모두 그 프로토콜 타입이기 때문에 타입 정체성을 보존할 수 없습니다.

[^requirement]: '필수 조건 (requirement)' 은 그 프로토콜을 준수하는 타입이 반드시 구현해야 하는 조건을 의미합니다. 필수 조건에 대한 더 자세한 내용은, [Protocols (프로토콜; 규약)]({% link docs/swift-books/swift-programming-language/protocols.md %}) 장에 있는 설명을 보도록 합니다.

[^flippedTriangle-Type]: 이 예제에서, `flippedTriangle` 은 `FlippedShape<Triangle>` 타입입니다. 본문이 의미하는 건, (모듈 안에 있어야 할) `FlippedShape` 이라는 타입이 모듈 밖으로 드러난다는 의미입니다.

[^joinedTriangle-Type]: 원문에서는 타입이 `JoinedShape<FlippedShape<Triangle>, Triangle>` 라고 되어 있는데, `JoinedShape<Triangle, FlippedShape<Triangle>>` 이 맞는 것 같습니다.

[^wrapper-types]: '포장 타입 (wrapper type)' 에 대한 더 자세한 내용은, [Attributes (특성)]({% link docs/swift-books/swift-programming-language/attributes.md %}) 장의 [propertyWrapper (속성 포장)]({% link docs/swift-books/swift-programming-language/attributes.md %}#propertywrapper-속성-포장) 부분을 보도록 합니다.

[^invalid-code]: 스위프트에서 '코드가 무효 (invalid) 하다' 는 건 그 코드를 컴파일하면 컴파일-시간 에러가 발생한다는 의미입니다.

[^differ-type-identity]: '타입 정체성 (type identity)' 에 대해서는 이 장 맨 앞부분의 설명과 주석을 보도록 합니다.

[^less-sepcific]: 이는 '프로토콜 타입' 을 사용하면 해당 '프로토콜 필수 조건' 에서 정의한 인터페이스만 사용할 수 있기 때문입니다. 즉 타입 정보가 덜 특정해 질수록 사용할 수 있는 인터페이스가 더 줄어들게 됩니다.

[^protocol-type-value]: 프로토콜을 준수한다는 건 프로토콜의 필수 조건을 모두 구현한다는 의미입니다. 하지만, 프로토콜 그 자체는 추상 타입이라서 어떤 것도 직접 구현하지 않습니다. 즉, 어떠한 값이 프로토콜 타입이라면 그 프로토콜을 준수하지 않습니다.

[^invalid-flipped]: 즉 무효하므로 '컴파일-시간 에러' 가 발생한다는 의미입니다. 본문의 코드를 실행하면 `Value of protocol type 'Shape' cannot conform to 'Shape'; only struct/enum/class types can conform to protocols` 같은 에러가 발생합니다.

[^associated-types]: '결합 타입 (associated types)' 에 대한 더 자세한 정보는, [Generics (일반화)]({% link docs/swift-books/swift-programming-language/generics.md %}) 장의 [Associated Types (결합 타입)]({% link docs/swift-books/swift-programming-language/generics.md %}#associated-types-결합-타입) 부분을 보도록 합니다.

[^type-inference]: '타입 추론' 에 대한 더 자세한 정보는, [The Basics (기초)]({% link docs/swift-books/swift-programming-language/the-basics.md %}) 장에 있는 [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)]({% link docs/swift-books/swift-programming-language/the-basics.md %}#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 부분을 보도록 합니다.
