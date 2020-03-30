---
layout: post
comments: true
title:  "Swift 5.2: Opaque Types (불투명한 타입)"
date:   2020-02-22 11:30:00 +0900
categories: Swift Language Grammar Opaque Type
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Opaque Types](https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html) 부분[^Opaque-Types]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Opaque Types (불투명한 타입)

함수나 메소드에서 'opaque (불투명한)' 반환 타입을 쓰면 반환 값의 타입 정보를 감춥니다. 함수의 반환 타입으로 '명확한 타입 (concrete type)' 을 제공하는 대신에, 반환 값을 프로토콜로써 묘사합니다. 타입 정보를 감추는 것은 모듈과 그 모듈을 호출하는 코드 사이에서 유용한데, 이는 반환 값의 실제 타입을 사적 영역에 남겨둘 수 있기 때문입니다. 값을 프로토콜 타입으로 반환하는 것과는 다르게, opaque 타입은 타입 정체성 (type identity) 을 보존합니다. - 컴파일러는 타입 정보에 접근하지만, 모듈 사용자는 안됩니다.

### The Problem That Opaque Types Solve (불투명한 타입이 해결하는 문제)

예를 들어, ASCII 로 예술적 도형을 그리는 모듈을 제작한다고 칩시다. ASCII 도형 모듈의 기본 성질로 도형을 문자열로 표현해서 반환하는 `draw()` 라는 함수가 있습니다. 이 함수를 `Shape` 프로토콜의 '요구 사항 (requirement)' 으로 사용할 수 있습니다.

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

generics (일반화) 를 사용해서 아래 코드 처럼 도형을 수직으로 뒤집는 연산을 구현할 수도 있습니다. 하지만, 이 방식에는 중요한 한계가 있습니다: 뒤집은 결과가 그것을 만드는데 사용한 정확한 generic 타입을 드러낸다는 것입니다.[^flippedTriangle-Type]

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

이 방식으로 두 도형을 수직으로 붙이는 `JoinedShape<T: Shape, U: Shape>` 구조체를 아래와 같이 정의하면, 뒤집힌 삼각형이 다른 삼각형과 붙여져진 타입의 결과는 `JoinedShape<Triangle, FlippedShape<Triangle>>` 가 됩니다.[^joinedTriangle-Type]

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

도형을 생성하는 세부 정보를 드러내는 것은 ASCII 도형 모듈의 공용 인터페이스 (public interface) 가 아닌 타입도 누출하게 되는데, 이는 전체 반환 타입을 명시해야하기 때문입니다. 모듈 안에 있는 코드는 동일한 도형을 다양한 방식으로 만들 수 있어야 하고, 모듈 밖에서 해당 도형을 사용하는 코드는 다양한 방식에 대한 구현 세부 사항을 설명하지 않아도 돼야 합니다. `JoinedShape` 과 `FlippedShape` 같은 wrapper (감싼) 타입은 모듈 사용자에게 의미 없으며 보이지 않도록 해야 합니다. 모듈의 공용 인터페이스는 도형의 합치기 (joining) 나 뒤집기 (flipping) 같은 연산 (operation) 으로 구성되며, 그 연산은 또 하나의 `Shape` 값을 반환합니다.

### Returning an Opaque Type (불투명한 타입을 반환하기)

Opaque 타입은 generic 타입이 '반대가 된 것 (reverse)' 으로 생각할 수 있습니다. Generic 타입은 함수를 호출하는 코드가 함수의 매개변수와 반환 값의 타입을 선택하도록 해서 함수 구현에서는 추상화하도록 합니다. 예를 들어, 아래 코드에 있는 함수의 반환 타입은 호출하는 쪽에서 지정합니다:

```swift
func max<T>(_ x: T, _ y: T) -> T where T: Comparable { ... }
```

`max(_:_:)` 를 호출하는 코드는 x 와 y 의 값을 선택하고, 이 값들의 타입은 T 의 명확한 타입을 결정합니다. 호출하는 코드는 `Comparable` 규약 (protocol) 을 준수하는 모든 타입을 쓸 수 있습니다. 함수 안의 코드는 일반화된 방식 (general way) 으로 작성되기 때문에 호출하는 쪽에서 제공하는 모든 타입을 처리할 수 있습니다. `max(_:_:)` 는 모든 `Comparable` 타입이 공유하는 기능만을 사용하여 구현됩니다.

Opaque 반환 타입을 쓰는 함수에서는 이 역할이 반대가 됩니다. Opaque 타입은 함수 구현부가 반환하는 값의 타입을 선택하도록 해서 함수를 호출하는 코드가 추상화하도록 합니다. 예를 들어, 아래 예제의 함수는 trapezoid (사다리꼴) 을 반환하면서도 도형의 실제 타입을 드러내지 않습니다.

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

이 예제의 `makeTrapezoid()` 함수는 반환 타입을 `some Shape` 으로 선언합니다; 그로 인해, 명확한 타입을 지정하지 않고도 `Shape` 프로토콜을 따르는 임의의 타입으로 반환하게 됩니다. `makeTrapezoid()` 함수를 이런 식으로 작성하는 것은 공용 인터페이스의 기본적인 측면-반환하는 값이 도형이라는 것-을 표한하게 합니다. 공용 인터페이스에서 도형을 만들어 내는 특정 타입을 만들지 않아도 됩니다. 이 구현에서는 두 개의 삼각형과 한 개의 정사각형을 사용했지만, 함수를 재작성해서 다른 방법으로 사다리꼴을 그리도록 만들 수 있으며 이 때 반환 타입을 변경할 필요는 없습니다.

이 예제는 'opaque (불투명한)' 반환 타입이 'generic (일반화된)' 타입의 반대 방식이라는 것을 강조해서 보여줍니다. `makeTrapezoid()` 내부의 코드는 타입이 `Shape` 프로토콜을 준수하기만 하면 어떤 타입이든 반환할 수 있는데, generic (일반화된) 함수를 호출하는 코드도 이와 같습니다. 함수를 호출하는 코드는 general (일반화된) 방법으로 작성해야 하는데, 그래서 generic (일반화된) 함수의 구현과 같이, `makeTrapezoid()` 가 반환하는 모든 `Shape` 을 사용할 수 있습니다.

Opaque 반환 타입을 generics 과 결합할 수도 있습니다. 아래의 코드에 있는 두 함수는 모두 `Shape` 프로토콜을 따르는 `some` (어떤) 타입을 반환합니다.

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

이 예제의 `opaqueJoinedTriangles` 값은 이 장 앞의 **Opaque 타입이 해결하는 문제** 부분에서 generics 를 사용한 예제에 있는 `joinedTriangles` 와 같습니다. 하지만 그 때와는 달리, `flip(_:)` 과 `join(_:_:)` 은 일반화된 (generics) 도형 연산이 반환하는 실제 타입을 opaque 반환 타입으로 감싸서, 보이지 않도록 합니다. 두 함수 모두 의존하는 타입이 genenric 이므로 generic 이며, 함수에 전달되는 타입 매개 변수는 `FlippedShape` 과 `JoinedShape` 에 필요한 타입 정보로 전달됩니다.

Opaque 반환 타입을 가지는 함수가 반환을 여러 곳에서 하는 경우, 모든 반환 값들은 반드시 동일한 타입을 가져야 합니다. generic 함수의 경우 반환 타입으로 함수의 generic 타입 매개 변수를 사용할 수는 있지만, 그래도 여전히 단 하나의 타입이어야 합니다. 예를 들어, 아래에 도형을 뒤집는 함수의 _잘못된_ 버전이 있는데 특수한 경우에는 square (정사각형) 을 반환합니다:

```swift
func invalidFlip<T: Shape>(_ shape: T) -> some Shape {
  if shape is Square {
    return shape                      // Error: return types doesn't match
  }
  return FlippedShape(shape: shape)   // Error: return types doesn't match
}
```

이 함수는 `Square` 로 호출하면 `Square` 를 반환하고, 그 외에는 `FlippedShape` 을 반환합니다. 이는 반환 값은 하나의 타입이어야 한다는 요구 사항을 위배하며 따라서 `invalidFlip(_:)` 는 잘못된 것입니다. `invalidFlip(_:)` 을 수정하는 한 가지 방법은 square (정사각형) 이라는 특수한 경우를 `FlippedShape` 의 구현부로 옮겨서, 항상 `FlippedShape` 값을 반환하도록 하는 것입니다:

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

항상 하나의 타입으로 반환해야 하는 요구 사항이 있다고 해서 opaque 반환 타입에 generics 를 쓸 수 없는 것은 아닙니다. 다음의 함수는 타입 매개 변수를 반환 값의 실제 타입에 통합하는 예입니다:

```swift
func `repeat`<T: Shape>(shape: T, count: Int) -> some Collection {
  return Array<T>(repeating: shape, count: count)
}
```

이 경우 반환 값의 실제 타입은 `T` 에 따라 달라집니다: 어떤 도형이 전달 되더라도, `repeat(shape:count:)` 는 해당 도형의 배열을 만들어 반환합니다. 그럼에도 불구하고 반환 값의 실제 타입은 항상 `[T]` 로 동일하므로, opaque 반환 타입을 가지는 함수는 단 한가지 타입의 반환 값을 가져야 한다는 요구 사항을 만족하고 있습니다.

### Difference Between Opaque Types and Protocol Types (불투명한 타입과 프로토콜-규약 타입의 차이점)

Opaque 타입을 반환하는 것은 함수의 반환 타입으로 프로토콜 타입을 사용하는 것과 매우 비슷하게 보이지만, 이 두 가지는 타입 정체성 (type identity) 을 유지하는가의 여부에 따라 차이가 있습니다. Opaque 타입은 하나의 특정 타입을 가리킵니다. 비록 함수를 호출하는 쪽에서는 어떤 타입인지를 볼 수 없지만요; 프로토콜 타입은 그 프로토콜을 준수하기만 하면 어떤 타입이든 가리킬 수 있습니다. 일반적으로 말해서, 프로토콜 타입은 저장하는 값의 실제 타입이 좀 더 다양할 수 있으며, opaque 타입은 그 타입이 실제 타입임을 더 확실하게 보증합니다.

예를 들어, 여기 반환 타입으로 opaque 반환 타입 대신 프로토콜 타입을 사용하는 `flip(_:)` 함수가 있습니다.

```swift
func protoFlip<T: Shape>(_ shape: T) -> Shape {
  return FlippedShape(shape: shape)
}
```

여기 있는 `protoFlip(_:)` 은 `flip(_:)` 과 본문이 같으며, 항상 같은 타입의 값을 반환합니다. 다만 `flip(_:)` 과 달리 `protoFlip(_:)` 이 반환하는 값은 항상 같은 타입이어야 할 필요는 없으며-Shape 프로토콜을 준수하기만 하면 됩니다. 달리 말하면, `protoFlip(_:)` 은 호출하는 쪽과의 API 계약 조건을 `flip(_:)` 보다 훨씬 느슨하게 만듭니다. 이는 여러 타입의 반환 값을 가질 수 있는 여지를 남기게 됩니다:

```swift
func protoFlip<T: Shape>(_ shape: T) -> Shape {
  if shape is Square {
    return shape
  }
  return FlippedShape(shape: shape)
}
```

변경된 버전의 코드는, 어떤 도형을 전달 받았는지에 따라, `Square` 또는 `FlippedShape` 인스턴스를 반환합니다. 이 함수에서 반환된 두 개의 뒤집힌 도형은 완전히 다른 타입일 수 있습니다. 이 함수의 여러 유효한 버전들은, 같은 도형에 대한 다양한 인스턴스들을 뒤집을 때, 다른 타입의 값들을 반환할 수도 있습니다. `protoFlip(_:)` 에서 보듯 덜 구체적인 반환 타입 정보가 의미하는 것은 타입 정보에 의존하는 많은 연산들을 반환 값에 적용할 수 없다는 것입니다. 예를 들어, `==` 연산자를 작성할 수 없기 때문에 이 함수에서 반환한 결과를 비교하는 것도 안됩니다.

```swift
let protoFlippedTriangle = protoFlip(smallTriangle)
let sameThing = protoFlip(smallTriangle)

protoFlippedTriangle == sameThing     //  Error
```

예제의 마지막 줄에서 오류가 발생하는 건 몇 가지 이유가 있기 때문입니다. 직접적인 문제는 `Shape` 프로토콜이 요구 사항으로 `==` 연산자를 포함하지 않기 때문입니다. 그런데 막상 추가하려고 하면, 그 다음 마주치는 문제는 `==` 연산자가 왼쪽 및 오른쪽 인자의 타입을 알아야 한다는 것입니다. 이런 종류의 연산자는 보통 인자 타입으로 `Self` 를 가지고, 이를 써서 프로토콜을 준수하는 명확한 타입을 찾는데, 문제는 프로토콜에 `Self` 요구 사항을 추가하는 것은 불가능하다는 점이며 이는 프로토콜을 타입으로 쓸 때 타입 삭제가 일어나기 때문입니다.

프로토콜 타입을 반환 타입으로 쓰면 함수에 유연함을 부여해서 그 프로토콜을 준수하는 어떤 타입이라도 반환할 수 있습니다. 하지만 그 유연함의 대가로 반환 값에 사용할 수 있는 몇몇 연산 기능을 잃습니다. 위 예제는 `==` 연산자가 왜 불가능한지를 보여주는데 - 프로토콜 타입을 사용하면 보존되지 않는 특정 타입 정보에 의존하기 때문입니다.

이 방법의 또 다른 문제는 도형 변환이 숨겨지지 (nest) 않는다는 점입니다. 삼각형을 뒤집은 결과 값은 `Shape` 타입이고, `protoFlip(_:)` 함수는 `Shape` 프로토콜을 준수하는 어떤 (some) 타입의 인자를 가집니다. 하지만 프로토콜 타입의 값은 그 프로토콜을 준수하지 않습니다: `protoFlip(_:)` 이 반환하는 값은 `Shape` 을 준수하지 않습니다. 이는 `protoFlip(protoFlip(smallTriange))` 과 같이 여러번 변환하는 코드가 유효하지 않다는 의미인데 이는 뒤집힌 도형은 `protoFlip(_:)` 의 인자로 유효하지 않기 때문입니다.

반대로, opaque 타입은 실제 타입의 정체성을 보존합니다. 스위프트는 associated types (관련된 타입) 을 추론할 수 있으므로, opaque 타입 값은 프로토콜 타입을 반환 값으로 쓸 수 없는 위치에서도 쓸 수 있습니다. 다음은 **Generics** 에 있는 `Container` 프로토콜의 한가지 예입니다:

```swift
protocol Container {
  associatedtype Item
  var count: Int { get }
  subscript(i: Int) -> Item { get }
}

extension Array: Container { }
```

`Container` 프로토콜은 associtatedtype (관련된 타입) 이 있으므로 함수의 반환 타입으로 사용할 수 없습니다. generic (일반화된) 반환 타입의 constraint (제약 조건) 으로도 사용할 수 없는데, 이는 함수 본체 외부로 나타나는 정보가 부족해서 generic 타입 추론하는데 충분하지 않기 때문입니다.

```swift
// Error: Ptorocol with associated types can't be used as a return type.
func makeProtocolContainer<T>(item: T) -> Container {
  return [item]
}

// Error: Not enough information to infer C.
func makeProtocolContainer<T, C: Container>(item: T) -> C {
  return [item]
}
```

반환 타입으로 opaque 타입인 `some Container` 를 사용하면 원하는 API 계약 조건인 - container 를 반환하지만, 그 container 의 타입을 한가지로 못박지는 않는 것 - 을 표현할 수 있습니다:  

```swift
func makeOpaqueContainer<T>(item: T) -> some Container {
  return [item]
}

let opaqueContainer = makeOpaqueContainer(item: 12)
let twelve = opaqueContainer[0]
print(type(of: twelve))

// Prints "Int"
```

`twelve` 의 타입은 `Int` 로 추론되는데, 이는 타입 추론이 opaque 타입과 작동하는 방식을 잘 보여줍니다. `makeOpaqueContainer(item:)` 의 구현에서, opaque컨테이너 (container) 의 실제 타입은 `[T]` 입니다. 여기서 `T` 는 `Int` 이므로, 반환 값은 정수 배열이며 associated type (관련된 타입) 인 `Item` 은 `Int` 로 추론됩니다. `Container` 의 subscript (첨자 연산자) 는 `Item` 을 반환하는데, 이는 곧 `twelve` 의 타입으로 `Int` 를 추론함을 의미합니다.

### 참고 자료

[^Opaque-Types]: 전체 원문은 [Opaque Types](https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html)에서 확인할 수 있습니다.

[^flippedTriangle-Type]: 여기서 `flippedTriangle` 의 타입은 `FlippedShape<Triangle>` 가 됩니다. 책의 내용대로라면 모듈내에 있는 `FlippedShape` 구조체 타입이 밖으로 드러나는 문제가 있다는 의미가 됩니다.

[^joinedTriangle-Type]: Swift Programming Language 책에서는 `joinedTriangle` 의 타입이 `JoinedShape<FlippedShape<Triangle>, Triangle>` 인 것으로 나오는데, 오류인 것 같습니다.
