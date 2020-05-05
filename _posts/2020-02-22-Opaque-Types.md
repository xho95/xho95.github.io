---
layout: post
comments: true
title:  "Swift 5.2: Opaque Types (불투명한 타입)"
date:   2020-02-22 11:30:00 +0900
categories: Swift Language Grammar Opaque Type
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Opaque Types](https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html) 부분[^Opaque-Types]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Opaque Types (불투명한 타입)

함수나 메소드에서 'opaque (불투명한) 반환 타입' 을 쓰면 그 반환 값의 타입 정보를 감추게 됩니다. 함수의 반환 타입으로 '명확한 타입 (concrete type)' 을 제공하는 대신에, 반환 값을 그가 지원하는 프로토콜로써 설명합니다. 타입 정보를 감추는 것은 모듈과 그 모듈을 호출하는 코드의 경계 지점에서 유용하며, 이는 반환 값의 실제 타입을 'private (개인 전용)' 으로 남겨둘 수 있기 때문입니다.[^private] 값을 프로토콜 타입으로 반환하는 것과는 다르게, 'opaque (불투명한) 타입' 은 '타입 정체성 (type identity)' 을 보존합니다-컴파일러는 타입 정보에 접근할 수 있지만, 모듈의 사용자는 그럴 수 없습니다.

### The Problem That Opaque Types Solve (불투명한 타입이 해결하는 문제)

예를 들어, ASCII 로 예술적 도형을 그리는 모듈을 제작한다고 가정해 봅시다. 'ASCII 예술 도형' 모듈은 도형을 문자열로 표현해서 반환하는 `draw()` 라는 함수를 기본으로 가지고 있는데, 이 함수를 `Shape` 프로토콜을 위한 '요구 사항 (requirement)'[^requirement] 으로 사용할 수 있습니다:

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

아래 코드처럼, '일반화 (generics)' 를 사용하면 도형을 수직으로 뒤집는 연산도 구현할 수 있을 것 같습니다. 하지만, 이 접근 방식에는 아주 중요한 한계가 존재합니다: 뒤집힌 결과를 만드는데 사용한 '일반화된 (generic) 타입' 이 정확하게 드러난다는 점이 그것입니다.[^flippedTriangle-Type]

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

이 접근 방식을 사용하여 두 도형을 수직으로 붙이는 `JoinedShape<T: Shape, U: Shape>` 구조체를 정의하면, 아래에 나타낸 코드와 같이 되는데, 뒤집힌 삼각형을 다른 삼각형과 붙임으로써 타입의 결과는 `JoinedShape<Triangle, FlippedShape<Triangle>>` 와 같은 것이 됩니다.[^joinedTriangle-Type]

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

도형 생성에 대한 세부 정보를 드러내는 것은 'ASCII 예술' 모듈의 '공용 인터페이스 (public interface)' 가 아닌 타입도 유출하게 되는데, 이는 전체 반환 타입을 분명하게 알려야 할 필요가 있기 때문입니다. 모듈 안에 있는 코드는 동일한 도형을 다양한 방식으로 만들 수 있어야 하면서도, 모듈 밖에서 도형을 사용하는 코드는 그 변환들에 대한 세부 구현을 일일이 서술하지 않도록 해야 합니다. `JoinedShape` 과 `FlippedShape` 같은 '감싼 (wrapper)' 타입은 모듈 사용자에게는 아무 의미가 없으므로, 보이지 않도록 해야 합니다. 모듈의 '공용 인터페이스' 는 도형의 '합치기 (joining)' 와 '뒤집기 (flipping)' 같은 '연산 (operation)' 으로 구성되어야 하며, 이 연산은 또 다른 `Shape` 값을 반환하도록 해야 합니다.

### Returning an Opaque Type (불투명한 타입 반환하기)

'opaque (불투명한) 타입' 은 'generic (일반화된) 타입' 의 '반대 (reverse)' 라고 생각할 수 있습니다. 'generic (일반화된) 타입' 은 함수를 호출하는 코드에서 함수의 매개 변수와 반환 값의 타입을 선택하는 방법으로 이를 함수 구현에서 분리하여 떨어뜨려 놓습니다. 예를 들어, 아래 코드에 있는 함수의 반환 타입은 전적으로 호출하는 쪽에 달려 있습니다:

```swift
func max<T>(_ x: T, _ y: T) -> T where T: Comparable { ... }
```

`max(_:_:)` 를 호출하는 코드에서 `x` 와 `y` 의 값을 선택하므로, 값의 타입은 명확한 타입인 `T` 로 결정됩니다. 호출하는 코드는 `Comparable` 프로토콜을 준수하면 어떤 타입이든 사용할 수 있습니다. 함수 안의 코드는 '일반화된 방식 (general way)' 으로 작성되므로 호출하는 쪽에서 제공하는 타입이 무엇이든 상관없이 처리할 수 있습니다. `max(_:_:)` 의 구현은 모든 `Comparable` 타입이 공유하는 기능만 사용하게 됩니다.

이 역할은 'opaque (불투명한)' 반환 타입을 쓰는 함수에서 반대가 됩니다. 'opaque (불투명한)' 타입은 함수 구현에서 반환하는 값의 타입을 선택하는 방법으로 이를 함수 호출 코드에서 분리하여 떨여뜨려 놓습니다. 예를 들어, 아래 예제에 있는 함수는 '사다리꼴 (trapezoid)' 을 반환하면서 도형의 실제 타입은 드러내지 않습니다.

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

이 예제에 있는 `makeTrapezoid()` 함수는 반환 타입을 `some Shape` 이라고 선언하고 있습니다; 그 결과, 함수에서 '명확한 타입' 을 지정하지 않았음에도, `Shape` 프로토콜을 준수하는 어떤 주어진 타입의 값을 반환합니다. `makeTrapezoid()` 함수를 이런 식으로 작성하면 '공용 인터페이스' 의 근본적인 부분-반환하는 값이 도형이라는 것-을 표현 하면서도 '공용 인터페이스' 가 만드는 도형의 타입을 지정하지 않아도 됩니다. 이 구현에서는 두 개의 삼각형과 한 개의 정사각형을 사용했지만, 다양한 다른 방법으로 사다리꼴을 그리도록 함수를 새로 작성할 수도 있으며 이 때 반환 타입은 바꾸지 않아도 됩니다.

이 예제가 강조하는 것은 'opaque (불투명한)' 반환 타입은 'generic (일반화된)' 타입의 반대에 해당한다는 것입니다. `makeTrapezoid()` 내부 코드는, 타입이 `Shape` 프로토콜을 준수하기만 하면, 필요한 경우 어떤 타입이든 반환할 수 있으며, 이는 'generic (일반화된)' 함수를 호출하는 코드에서 그렇게 하는 것과 유사합니다. 함수를 호출하는 코드는, '일반화된 함수 (generic function)' 가 그렇듯이, '일반화된 방법 (general way)' 으로 작성해야 하는데, 그렇게 해야 `makeTrapezoid()` 가 반환하는 어떤 `Shape` 과도 작동할 수 있기 때문입니다.

'opaque (불투명한)' 반환 타입을 'generics (일반화)' 와 결합할 수도 있습니다. 아래 코드에 있는 두 개의 함수는 둘 다 `Shape` 프로토콜을 준수하는 'some (어떤)' 타입의 값을 반환합니다.

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

이 예제에 있는 `opaqueJoinedTriangles` 의 값은 이 장 앞에 있는 [The Problem That Opaque Types Solve (불투명한 타입이 해결하는 문제)](#the-problem-that-opaque-types-solve-불투명한-타입이-해결하는-문제) 부분의 'generics 예제' 에 있는 `joinedTriangles` 과 같습니다. 하지만, 그 예제의 값과는 달리, `flip(_:)` 과 `join(_:_:)` 은 '일반화된 (generics) 도형 연산' 이 반환하는 실제 타입을 'opaque 반환 타입' 으로 감싸서, 타입이 드러나는 것을 막아줍니다. 두 함수 모두 'generic' 에 의존하므로 'generic' 타입이며, 함수의 타입 매개 변수를 통해 `FlippedShape` 과 `JoinedShape` 에 필요한 타입 정보를 전달합니다.

'opaque (불투명한)' 반환 타입을 가지는 함수가 반환을 여러 곳에서 하는 경우, 모든 반환 가능한 값들은 반드시 타입이 같아야 합니다. '일반화된 함수 (generic function)' 에 대해서, 반환 타입으로 함수의 일반화된 타입 매개 변수를 사용할 수는 있지만, 그래도 여전히 단일한 타입이어야만 합니다. 예를 들어, 다음에 나타낸 도형 뒤집기 함수의 _무효한 (invalid)_ 버전은 특수한 경우인 '정사각형 (square)' 에 대한 내용을 포함하고 있습니다:

```swift
func invalidFlip<T: Shape>(_ shape: T) -> some Shape {
  if shape is Square {
    return shape                      // Error: 에러, 반환 타입이 일치하지 않습니다.
  }
  return FlippedShape(shape: shape)   // Error: 에러, 반환 타입이 일치하지 않습니다.
}
```

이 함수를 호출할 때 `Square` 를 사용하면, `Square` 를 반환합니다; 그 외에는, `FlippedShape` 을 반환합니다. 이는 '반환 값은 단 하나의 타입이어야 한다' 는 '필수 조건 (requirement)' 을 위반하므로 `invalidFlip(_:)` 을 무효한 코드로 만듭니다. `invalidFlip(_:)` 을 고치는 한 가지 방법은 '정사각형 (square)' 이라는 특수한 경우를 `FlippedShape` 의 구현으로 옮겨서, 함수가 항상 `FlippedShape` 값을 반환하게 만드는 것입니다:

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

항상 단일한 타입을 반환해야 한다는 요구 사항이 'opaque (불투명한)' 반환 타입에 'generics (일반화)' 를 사용하지 못하게 하는 것은 아닙니다. 다음 예제에 있는 함수는 타입 매개 변수를 반환하는 값의 실제 타입에 통합하는 방법을 보여줍니다:

```swift
func `repeat`<T: Shape>(shape: T, count: Int) -> some Collection {
  return Array<T>(repeating: shape, count: count)
}
```

이 경우에, 반환 값의 실제 타입은 `T` 에 달려 있습니다: 어떤 도형이 전달 되더라도, `repeat(shape:count:)` 는 해당 도형의 배열을 생성해서 반환합니다. 그럼에도 불구하고, 반환 값의 실제 타입은 항상 동일하게 `[T]` 이므로, 'opaque (불투명한)' 반환 타입을 가지는 함수는 단일한 타입의 반환 값을 가져야만 한다는 요구 사항을 만족하게 됩니다.

### Difference Between Opaque Types and Protocol Types (불투명한 타입과 프로토콜 타입의 차이점)

'opaque (불투명한) 타입' 을 반환하는 것은 함수의 반환 타입으로 'protocol (프로토콜; 규약) 타입' 을 사용하는 것과 매우 비슷해 보이지만, 이 두 가지의 반환 타입은 '타입 정체성 (type identity)' 을 보존하는 지에 따른 차이가 있습니다. 하나의 'opaque (불투명한)' 타입은 하나의 지정된 타입을 참조하는 것으로, 이는 함수를 호출하는 쪽에서 무슨 타입인지 볼 수 없더라도 그렇습니다; 하나의 프로토콜 타입은 그 프로토콜을 준수하는 어떤 타입이든 참조할 수 있습니다. 일반적으로 말해서, 프로토콜 타입은 저장하고 있는 값의 실제 타입을 좀 더 유연하게 해주는 것이고, 'opaque (불투명한)' 타입은 그 실제 타입을 더 확실해게 보증하는 것입니다.

예를 들어, 반환 타입으로 'opaque 반환 타입' 대신 '프로토콜 타입' 을 사용하는 `flip(_:)` 함수가 여기 있습니다:

```swift
func protoFlip<T: Shape>(_ shape: T) -> Shape {
  return FlippedShape(shape: shape)
}
```

이 `protoFlip(_:)` 함수는 `flip(_:)` 과 같은 본문 내용을 가지며, 항상 동일한 타입의 값을 반환합니다. 다만 `flip(_:)` 과는 달리, `protoFlip(_:)` 이 반환하는 값이 항상 같은 타입일 것을 요구하고 있는 것은 아닙니다-단지 `Shape` 프로토콜을 준수하기만 하면 되는 것입니다. 달리 말하면, `protoFlip(_:)` 과 호출하는 쪽의 'API 계약 (API contract)' 은 `flip(_:)` 에서 보다 훨씬 느슨해집니다. 이는 여러 타입의 반환 값을 가질 여지를 남겨 두는 것입니다:

```swift
func protoFlip<T: Shape>(_ shape: T) -> Shape {
  if shape is Square {
    return shape
  }
  return FlippedShape(shape: shape)
}
```

이 개정된 버전의 코드는 어떤 도형을 전달 받았는 지에 따라, `Square` 인스턴스나 `FlippedShape` 인스턴스를 반환합니다. 이 함수가 반환하는 두 개의 뒤집힌 도형은 완전히 서로 다른 타입일 수도 있습니다. 이 함수의 유효한 버전 중에는 같은 도형의 여러 가지 인스턴스를 뒤집는데도 서로 다른 타입의 값을 반환할 지도 모릅니다. `protoFlip(_:)` 에서 지정한 반환 타입 정보가 더 적다는 것은 타입 정보에 의존하는 많은 연산들을 반환 값에 사용할 수 없다는 것을 의미합니다. 예를 들어, 이 함수가 반환하는 결과를 서로 비교하는 `==` 연산자는 작성할 수 없습니다.

```swift
let protoFlippedTriangle = protoFlip(smallTriangle)
let sameThing = protoFlip(smallTriangle)
protoFlippedTriangle == sameThing     //  Error, 에러
```

예제 마지막 줄에서 에러가 발생하는 데는 몇 가지 이유가 있습니다. 직접적인 문제는 `Shape` 이 프로토콜의 요구 사항인 `==` 연산자를 포함하지 않는다는 것입니다. 그래서 이를 추가하려고 하면, 그 다음 마주치게 되는 문제는 `==` 연산자가 왼쪽 인자와 오른쪽 인자의 타입을 알 필요가 있다는 것입니다. 이런 종류의 연산자는 보통 `Self` 타입의 인자를 받아들여서, 프로토콜을 채택하는 명확한 타입이 무엇인지를 찾는데, 문제는 프로토콜에 추가된 `Self` '요구 사항' 은 프로토콜을 타입으로 사용할 때 타입의 삭제가 일어나는 경우를 고려하지 않는다는 것입니다.

함수의 반환 타입으로 프로토콜 타입을 사용하는 것은 유연함을 제공해서 그 프로토콜을 준수하는 어떤 타입도 반환할 수 있게 합니다. 하지만, 그 유연함의 대가로 몇몇 연산을 반환 값에서 사용할 수 없게 됩니다. 이 예제는 `==` 연산자가 왜 불가능한지를 보여줍니다-그것이 의존하는 특정한 타입 정보가 프로토콜 타입을 쓸 경우 보존되지 않기 때문입니다.

이 접근 방식의 또 다른 문제는 도형 변환을 '숨기지 (nest)'[^nest] 않는다는 것입니다. 삼각형을 뒤집은 결과는 `Shape` 타입의 값이고, `protoFlip(_:)` 함수는 `Shape` 프로토콜을 준수하는 '어떤 (some) 타입' 인 인자를 받습니다. 하지만, 프로토콜 타입의 값은 그 프로토콜을 준수하지 않습니다[^protocol-type-value]: `protoFlip(_:)` 이 반환하는 값은 `Shape` 을 준수하지 않습니다. 이는 `protoFlip(protoFlip(smallTriangle))` 과 같이 여러번 반복해서 변환하는 코드는 유효하지 않음을 의미하는 것으로 '뒤집힌 도형 (flipped shape)' 은 `protoFlip(_:)` 의 인자로 유효하지 않기 때문입니다.

이와는 대조적으로, 'opaque (불투명한) 타입' 은 실제 타입의 정체성을 보존합니다. 스위프트는 'associated types (관련 타입)' 을 추론할 수 있어서, 반환 값으로 프로토콜 타입을 사용할 수 없는 곳에서도 'opaque (불투명한) 타입 값' 은 사용할 수 있습니다. 예를 들어, 다음은 [Generics (일반화)](http://xho95.github.io/swift/language/grammar/generic/2020/02/29/Generics.html) 에 있는 `Container` 프로토콜의 한 예시입니다:

```swift
protocol Container {
  associatedtype Item
  var count: Int { get }
  subscript(i: Int) -> Item { get }
}

extension Array: Container { }
```

`Container` 프로토콜은 함수의 반환 타입으로 사용할 수 없는데 이는 이 프로토콜이 '관련 타입 (associated type)' 을 가지고 있기 때문입니다. 'generic (일반화된) 반환 타입' 의 '구속 조건 (constraint)' 으로도 사용할 수 없는데 이는 함수 본문 외부에 'generic (일반화된) 타입' 이 무엇인지 추론하는데 필요한 충분한 정보가 없기 때문입니다.

```swift
// Error: 에러, 관련 타입 (associated type) 을 가지는 프로토콜은 반환 타입으로 사용할 수 없습니다.
func makeProtocolContainer<T>(item: T) -> Container {
  return [item]
}

// Error: 에러, C 를 추론하기에 정보가 충분하지 않습니다.
func makeProtocolContainer<T, C: Container>(item: T) -> C {
  return [item]
}
```

반환 타입으로 'opaque (불투명한) 타입' 인 `some Container` 를 사용해야 원하던 'API 계약 (API contract)' 을 표현하게 됩니다-함수가 하나의 '컨테이너 (container)' 를 반환하지만, '컨테이너 (container)' 의 타입은 지정하지는 않겠다는 것 말입니다:  

```swift
func makeOpaqueContainer<T>(item: T) -> some Container {
  return [item]
}

let opaqueContainer = makeOpaqueContainer(item: 12)
let twelve = opaqueContainer[0]
print(type(of: twelve))

// "Int" 를 출력합니다.
```

`twelve` 의 타입은 `Int` 로 추론되며, 이는 '타입 추론 (type inference)' 이 'opaque (불투명한) 타입' 과도 잘 작동한다는 사실을 명확히 보여줍니다. `makeOpaqueContainer(item:)` 의 구현에서, 'opaque container (불투명한 집합체)' 의 실제 타입은 `[T]` 입니다. 여기서 `T` 는 `Int` 이므로, 반환 값은 정수 배열이며 '관련 타입 (associated type)' 인 `Item` 은 `Int` 로 추론됩니다. `Container` 의 '첨자 연산 (subscript)' 은 `Item` 을 반환하는데, 이는 `twelve` 의 타입도 `Int` 로 추론함을 의미합니다.

### 참고 자료

[^Opaque-Types]: 전체 원문은 [Opaque Types](https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html)에서 확인할 수 있습니다.

[^private]: 'private (개인 전용)' 은 스위프트의 '엔티티' 에 대한 '접근 수준 (access level)' 이 'private (개인 전용)' 인 것을 말하는데, 이는 특정 클래스 영역 내에서만 접근 가능하다는 것을 나타냅니다. 다른 프로그래밍 언어의 'private' 과 유사한 의미를 가진다고 이해할 수 있습니다.

[^requirement]: '프로토콜 (protocol)' 의 '요구 사항 (requirement)' 은 스위프트에서 '프로토콜을 준수 (conforming to protocol)' 하는 대상이 반드시 구현해야 할 요소를 말합니다.

[^flippedTriangle-Type]: 이 예제에서 `flippedTriangle` 의 타입은 `FlippedShape<Triangle>` 가 됩니다. 본문 내용에 의하면, 모듈 내에 있는 `FlippedShape` 이라는 구조체 타입이 밖으로 드러나는 것이 문제라는 것입니다.

[^joinedTriangle-Type]: 원문에는 `joinedTriangle` 의 타입이 `JoinedShape<FlippedShape<Triangle>, Triangle>` 라고 되어 있는데, `JoinedShape<Triangle, FlippedShape<Triangle>>` 이 맞는 것 같습니다.

[^protocol-type-value]: 본문의 코드를 실행하면 `Value of protocol type 'Shape' cannot conform to 'Shape'; only struct/enum/class types can conform to protocols` 과 같은 에러가 발생합니다. 프로토콜을 반환하는 결과를 다시 프로토콜을 인자로 받는 함수에 전달하는 것은 안된다고 이해하면 될 것 같습니다.
