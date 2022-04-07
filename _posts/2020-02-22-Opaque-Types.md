---
layout: post
comments: true
title:  "Swift 5.5: Opaque Types (불투명 타입)"
date:   2020-02-22 11:30:00 +0900
categories: Swift Language Grammar Opaque Type
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Opaque Types](https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html) 부분[^Opaque-Types]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Opaque Types (불투명 타입)

불투명 (opaque) 반환 타입을 가진 함수나 메소드는 자신의 반환 값 타입 정보를 숨깁니다. 함수 반환 타입으로 고정 타입을 제공하는 대신, 반환 값이 지원하는 프로토콜로 이를 설명합니다. 타입 정보를 감추는 건 모듈과 그 모듈 안을 호출하는 코드 경계선 상에서 유용한데, 이는 반환 값의 실제 타입이 개인 전용[^private] 으로 남을 수 있기 때문입니다. 타입이 프로토콜 타입인 값을 반환하는 것과 달리, 불투명 타입은 타입 정체성[^type-identity] 을 보존합니다-컴파일러는 타입 정보에 접근하지만, 모듈 사용자는 아닙니다.

### The Problem That Opaque Types Solve (불투명 타입이 풀어내는 문제)

예를 들어, ASCII 로 예술 도형을 그리는 모듈을 작성한다 가정해 봅니다. ASCII 예술 도형의 기본 성질은 그 도형을 문자열로 나타낸 걸 반환하는 `draw()` 함수인데, 이를 `Shape` 프로토콜의 필수 조건[^requirement] 으로 사용할 수 있습니다:

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

일반화를 사용하면, 아래 코드에서 보는 것처럼, 도형을 수직으로 뒤집는 연산을 구현할 수도 있을 겁니다. 하지만, 이 접근법에는 중요한 한계가 있는데: 뒤집은 결과의 생성에 사용하는 일반화 타입을 정확히 드러낸다는 겁니다.[^flippedTriangle-Type]

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

불투명 타입은 일반화 타입의 역방향이라고 생각할 수 있습니다. 일반화 타입은 함수 호출 코드가 그 함수의 매개 변수와 반환 값 타입을 고르게 해서 함수 구현을 추상화하는 방식입니다. 예를 들어, 다음 코드에서 함수가 반환할 타입은 자신을 호출한 쪽에 의존합니다:

```swift
func max<T>(_ x: T, _ y: T) -> T where T: Comparable { ... }
```

`max(_:_:)` 를 호출한 코드가 `x` 와 `y` 의 값을 선택하며, 이 값들의 타입이 `T` 라는 고정 타입을 결정합니다. 호출 코드는 `Comparable` 프로토콜을 준수한 어떤 타입이든 사용할 수 있습니다. 함수 안의 코드는 일반적인 (general) 방식으로 작성하므로 호출한 쪽이 무슨 타입을 제공하든 처리할 수 있습니다. `max(_:_:)` 구현부는 모든 `Comparable` 타입이 공유하는 기능만을 사용합니다.

불투명 반환 타입을 가진 함수에선 이러한 역할이 역방향입니다. 불투명 타입은 함수 구현부가 자신의 반환 값 타입을 고르게 해서 함수 호출 코드를 추상화하는 방식입니다. 예를 들어, 다음 예제의 함수는 도형의 실제 타입인 사다리꼴 (trapezoid) 을 드러내지 않고도 이를 반환합니다.

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

이 예제에서 `makeTrapezoid()` 함수는 반환 타입이 `some Shape` 이라고 선언하는데; 그 결과, 함수는, 어떤 특별한 '고정 타입' 도 지정하지 않으면서, `Shape` 프로토콜을 준수하는 주어진 어떠한 타입의 값을 반환합니다. `makeTrapezoid()` 함수를 이런 식으로 작성하면 '공용 인터페이스' 에서 만들어지는 도형에 대한 특정 타입을 만들지 않고도 '공용 인터페이스' 의 기본적인 측면-반환하는 값이 도형이라는 것-을 나타내도록 해줍니다. 이 구현은 삼각형 두 개와 정사각형 하나를 사용했지만, 반환 타입을 바꾸지 않으면서 다른 다양한 방식으로 '사다리꼴' 을 그리도록 함수를 재작성할 수 있을 것입니다.

이 예제는 '불투명 반환 타입' 이 '일반화 타입' 을 거꾸로 한 것과 같다는 것을 강조합니다. `makeTrapezoid()` 안에 있는 코드는, 해당 타입이 `Shape` 프로토콜을 준수하기만 한다면, '일반화 함수' 를 호출하는 코드가 하듯이, 필요한 어떤 타입이든 반환할 수 있습니다. 함수를 호출하는 코드는, '일반화 함수' 의 구현 같이, '일반적인 방식' 으로 작성할 필요가 있는데, 그래야 `makeTrapezoid()` 가 반환하는 어떤 `Shape` 과도 작업할 수 있습니다.

'불투명 반환 타입' 을 '일반화 (generics)' 와 조합할 수도 있습니다. 다음 코드에 있는 함수는 둘 다 `Shape` 프로토콜을 준수하는 '어떠한 (some)' 타입의 값을 반환합니다.

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

이 예제의 `opaqueJoinedTriangles` 값은 이 장 앞의 [The Problem That Opaque Types Solve (불투명 타입이 풀어내는 문제)](#the-problem-that-opaque-types-solve-불투명-타입이-풀어내는-문제) 부분에 있는 '일반화 (generics) 예제' 의 `joinedTriangles` 과 똑같습니다. 하지만, 해당 예제에 있는 값과는 달리, `flip(_:)` 과 `join(_:_:)` 은, 이 타입들이 보이는 것을 막도록, '일반화 도형 연산' 이 반환하는 실제 타입을 '불투명 반환 타입' 으로 포장합니다. 두 함수 다 '일반화 (generic)' 에 의지하고 있기 때문에 '일반화 (타입)' 이며, 함수의 '타입 매개 변수' 가 `FlippedShape` 과 `JoinedShape` 에 필요한 '타입 정보' 를 전달합니다.

'불투명 반환 타입' 을 가진 함수가 여러 곳에서 반환하는 경우, 가능한 모든 반환 값들은 반드시 똑같은 타입이어야 합니다. '일반화 함수' 에서는, 해당 반환 타입으로 함수의 '일반화 타입 매개 변수' 를 사용할 순 있지만, 여전히 '단일 타입' 이어야 합니다. 예를 들어, 다음은 '정사각형' 이라는 특수한 경우를 포함한 _무효한 (invalid)_ 버전[^invalid-code] 의 '도형-뒤집기' 함수입니다:

```swift
func invalidFlip<T: Shape>(_ shape: T) -> some Shape {
  if shape is Square {
    return shape                      // 에러: 반환 타입이 일치하지 않음
  }
  return FlippedShape(shape: shape)   // 에러: 반환 타입이 일치하지 않음
}
```

`Square` 를 가지고 이 함수를 호출하면, `Square` 를 반환하며; 그 외 경우라면, `FlippedShape` 을 반환합니다. 이는 '한 가지 값만 반환해야 한다' 는 '필수 조건' 을 위반하며 `invalidFlip(_:)` 을 '무효한 코드' 로 만듭니다. `invalidFlip(_:)` 을 고치는 한 방법은, 이 함수가 항상 `FlippedShape` 값을 반환하도록, '정사각형' 이라는 특수한 경우를 `FlippedShape` 구현 속으로 이동하는 것입니다:

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

'항상 단일 타입을 반환하라' 는 '필수 조건' 이 '일반화' 를 '불투명 반환 타입' 에 사용하는 것을 막는 것은 아닙니다. 다음은 자신의 '타입 매개 변수' 를 반환 값의 '실제 타입' 속에 편입하는 함수에 대한 예제입니다:

```swift
func `repeat`<T: Shape>(shape: T, count: Int) -> some Collection {
  return Array<T>(repeating: shape, count: count)
}
```

이 경우, 반환 값의 실제 타입은 `T` 에 의존하는데: 전달한 도형이 뭐든 간에, `repeat(shape:count:)` 는 해당 도형에 대한 배열을 생성하여 반환합니다. 그럼에도 불구하고, 반환 값의 실제 타입은 항상 `[T]` 로 똑같으므로, '불투명한 반환 타입' 을 가진 함수는 '단일 타입' 의 반환 값만을 가져야 한다는 '필수 조건' 을 따릅니다.

### Differences Between Opaque Types and Protocol Types ('불투명 타입' 과 '프로토콜 타입' 의 차이)

'불투명 타입' 을 반환하는 것은 함수 반환 타입으로 '프로토콜 타입' 을 사용하는 것과 매우 비슷해 보이지만, 이 두 종류의 반환 타입은 '타입 정체성'[^differ-type-identity] 을 보존하는 지에 있어 다릅니다. '불투명 타입' 은, 비록 함수를 호출하는 쪽에서 어느 타입인지를 볼 순 없더라도, 하나의 특정한 타입을 참조하는 것이지만; '프로토콜 타입' 은 프로토콜을 준수하는 어떤 타입이든 참조할 수 있습니다. 일반적으로 말해서, '프로토콜 타입' 은 저장 값의 실제 타입에 더 많은 '유연함' 을 부여하며, '불투명 타입' 은 그 '실제 타입' 들을 더 강하게 보증하도록 해줍니다.

예를 들어, 다음은 '불투명 반환 타입' 대신 '프로토콜 타입' 을 반환 타입으로 사용하는 버전의 `flip(_:)` 입니다:

```swift
func protoFlip<T: Shape>(_ shape: T) -> Shape {
  return FlippedShape(shape: shape)
}
```

이 버전의 `protoFlip(_:)` 은 `flip(_:)` 과 똑같은 본문을 가지며, 항상 똑같은 타입의 값을 반환합니다. `flip(_:)` 과는 달리, `protoFlip(_:)` 반환 값이 항상 똑같은 타입이라는 건 필수가 아닙니다-단지 `Shape` 프로토콜을 준수하기만 하면 됩니다. 다른 식으로 말하면, `protoFlip(_:)` 이 호출하는 쪽과 맺는 'API 계약 (contract)' 은 `flip(_:)` 이 맺는 것보다 훨씬 더 느슨합니다. 이는 여러 타입의 값을 반환할 '유연함' 을 남겨 둡니다:

```swift
func protoFlip<T: Shape>(_ shape: T) -> Shape {
  if shape is Square {
    return shape
  }
  return FlippedShape(shape: shape)
}
```

개정된 버전의 코드는, 전달받은 도형이 무엇인지에 의존하여, `Square` 인스턴스 또는 `FlippedShape` 인스턴스를 반환합니다. 이 함수가 반환하는 두 '뒤집힌 도형' 은 서로 완전히 다른 타입일 수도 있습니다. 이 함수의 유효한 다른 버전은 똑같은 도형의 여러 인스턴스를 뒤집을 때 서로 다른 타입인 값들을 반환할 수도 있습니다. `protoFlip(_:)` 에서 '덜 특정한 반환 타입 정보' 는 '타입 정보' 에 의존하는 많은 연산들을 반환 값에서 사용할 수 없다는 의미입니다.[^less-sepcific] 예를 들어, 이 함수가 반환하는 결과를 비교하는 `==` 연산자를 작성하는 것은 불가능합니다.

```swift
let protoFlippedTriangle = protoFlip(smallTriangle)
let sameThing = protoFlip(smallTriangle)
protoFlippedTriangle == sameThing     //  에러
```

예제 마지막 줄의 에러는 여러가지 이유로 일어납니다. 직접적인 문제점은 `Shape` 의 '프로토콜 필수 조건' 이 `==` 연산자를 포함하지 않는다는 것입니다. 이를 추가하려 하면, 그 다음 마주칠 문제점은 `==` 연산자가 왼-쪽과 오른-쪽 인자의 타입을 알아야 한다는 것입니다. 이런 종류의 연산자는 평소에, 프로토콜을 채택한 '고정 타입' 이 뭐든 간에 일치하도록, `Self` 타입의 인자를 취하지만, 프로토콜에 '`Self` 필수 조건' 을 추가하는 것은 프로토콜을 타입으로 사용할 때 발생하는 '타입 삭제 (type erasure)' 를 허용하지 않습니다.

'프로토콜 타입' 을 함수의 반환 타입으로 사용하는 것은 프로토콜을 준수하는 어떤 타입이든 반환하도록 하는 '유연함' 부여합니다. 하지만, 해당 유연함의 대가로 일부 연산이 반환 값에서 (사용) 불가능해집니다. 예제는 `==` 연산자가 사용 불가능해지는 방법-프로토콜 타입이 보존하지 않는 특정 타입 정보에 의존하는 것-을 보여줍니다.

이 접근 방식이 가진 또 다른 문제는 '도형 변화 (규칙)' 을 중첩하지 않는다는 것입니다. '삼각형' 을 뒤집은 결과는 `Shape` 타입의 값이고, `protoFlip(_:)` 함수는 `Shape` 프로토콜을 준수하는 어떤 타입의 인자를 취합니다. 하지만, 프로토콜 타입의 값은 해당 프로토콜을 준수하지 않으며[^protocol-type-value]: `protoFlip(_:)` 이 반환하는 값은 `Shape` 을 준수하지 않습니다. 이는 '다중 변화' 를 적용하는 `protoFlip(protoFlip(smallTriangle))` 같은 코드는 '뒤집은 (flipped) 도형' 이 `protoFlip(_:)` 의 유효한 인자가 아니기 때문에 무효하다는 의미입니다.[^invalid-flipped]

이와 대조적으로, '불투명 타입' 은 실제 타입의 '정체성 (identity)' 을 보존합니다. 스위프트는 '결합 타입'[^associated-types] 을 추론할 수 있어서, '프로토콜 타입' 을 반환 값으로 사용할 수 없는 곳에서 '불투명 타입 값' 을 사용할 수 있게 해줍니다. 예를 들어, 다음은 [Generics (일반화)]({% post_url 2020-02-29-Generics %}) 에 있는 `Container` 프로토콜의 한 버전입니다:

```swift
protocol Container {
  associatedtype Item
  var count: Int { get }
  subscript(i: Int) -> Item { get }
}
extension Array: Container { }
```

`Container` 는 해당 프로토콜이 '결합 타입' 을 가지고 있기 때문에 함수의 반환 타입으로 사용할 수 없습니다. 이는 '일반화 타입' 이 무엇인지 추론하는데 필요한 충분한 정보가 함수 외부에는 없기 때문에 '일반화 반환 타입' 의 '구속 조건' 으로도 사용할 수 없습니다.

```swift
// 에러: '결합 타입' 을 가진 프로토콜은 반환 타입으로 사용할 수 없음
func makeProtocolContainer<T>(item: T) -> Container {
  return [item]
}

// 에러: 'C' 를 추론하기 위한 충분한 정보가 없음
func makeProtocolContainer<T, C: Container>(item: T) -> C {
  return [item]
}
```

반환 타입으로 `some Container` 라는 '불투명 타입' 을 사용하면 '원하던 API 계약'-함수가 '컨테이너' 를 반환하지만, '컨테이너' 타입 지정은 거부한다는 것-을 나타냅니다:

```swift
func makeOpaqueContainer<T>(item: T) -> some Container {
  return [item]
}

let opaqueContainer = makeOpaqueContainer(item: 12)
let twelve = opaqueContainer[0]
print(type(of: twelve))
// "Int" 를 인쇄합니다.
```

`twelve` 의 타입은 `Int` 라고 추론하는데, 이는 '타입 추론'[^type-inference] 이 '불투명 타입' 과도 작업한다는 사실을 묘사합니다. `makeOpaqueContainer(item:)` 의 구현에서, '불투명한 컨테이너' 의 (밑에 놓인) 실제 타입은 `[T]` 입니다. 이 경우, `T` 가 `Int` 이므로, 반환 값은 정수 배열이고 `Item` 이라는 '결합 타입' 은 `Int` 라고 추론합니다. `Container` 에 대한 '첨자 연산' 은 `Item` 을 반환하는데, 이는 `twelve` 의 타입도 `Int` 라고 추론함을 의미합니다.

### 다음 장

[Automatic Reference Counting (자동 참조 카운팅) > ]({% post_url 2020-06-30-Automatic-Reference-Counting %})

### 참고 자료

[^Opaque-Types]: 전체 원문은 [Opaque Types](https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html)에서 확인할 수 있습니다.

[^private]: '개인 전용 (private)' 은 스위프트의 '개체 (entity)' 에 대한 '접근 수준' 이 `private` 인 것을 말합니다. '개인 전용' 에 대한 더 자세한 정보는, [Access Control (접근 제어)]({% post_url 2020-04-28-Access-Control %}) 장에 있는 [Access Levels (접근 수준)]({% post_url 2020-04-28-Access-Control %}#access-levels-접근-수준) 부분을 참고하기 바랍니다.

[^type-identity]: '타입 정체성 (type identity) 을 보존한다' 는 건 불투명 타입을 사용하면 한 특정한 타입이 계속 유지된다 의미입니다. 프로토콜은 그 프로토콜을 준수하는 어떤 타입이든 모두 그 프로토콜 타입이기 때문에 타입 정체성을 보존할 수 없습니다.

[^requirement]: '필수 조건 (requirement)' 은 그 프로토콜을 준수하는 타입이 반드시 구현해야 하는 조건을 의미합니다. 필수 조건에 대한 더 자세한 내용은, [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 장에 있는 설명을 참고하기 바랍니다.

[^flippedTriangle-Type]: 이 예제에서, `flippedTriangle` 은 `FlippedShape<Triangle>` 타입입니다. 본문이 의미하는 건, (모듈 안에 있어야 할) `FlippedShape` 이라는 타입이 모듈 밖으로 드러난다는 의미입니다.

[^joinedTriangle-Type]: 원문에서는 타입이 `JoinedShape<FlippedShape<Triangle>, Triangle>` 라고 되어 있는데, `JoinedShape<Triangle, FlippedShape<Triangle>>` 이 맞는 것 같습니다.

[^wrapper-types]: '포장 타입 (wrapper type)' 에 대한 더 자세한 내용은, [Attributes (특성)]({% post_url 2020-08-14-Attributes %}) 장의 [propertyWrapper (속성 포장)]({% post_url 2020-08-14-Attributes %}#propertywrapper-속성-포장) 부분을 참고하기 바랍니다.

[^invalid-code]: 스위프트에서 코드가 '무효 (invalid)' 하다는 것은 해당 코드를 컴파일하면 '컴파일-시간 에러' 가 발생한다는 의미입니다.

[^differ-type-identity]: '타입 정체성 (type identity)' 에 대해서는 이 장 맨 앞부분의 설명과 주석을 참고하기 바랍니다.

[^less-sepcific]: 이는 '프로토콜 타입' 을 사용하면 해당 '프로토콜 필수 조건' 에서 정의한 인터페이스만 사용할 수 있기 때문입니다. 즉 타입 정보가 덜 특정해 질수록 사용할 수 있는 인터페이스가 더 줄어들게 됩니다.

[^invalid-flipped]: 즉 무효하므로 '컴파일-시간 에러' 가 발생한다는 의미입니다. 본문의 코드를 실행하면 `Value of protocol type 'Shape' cannot conform to 'Shape'; only struct/enum/class types can conform to protocols` 같은 에러가 발생합니다.

[^associated-types]: '결합 타입 (associated types)' 에 대한 더 자세한 정보는, [Generics (일반화)]({% post_url 2020-02-29-Generics %}) 장에 있는 [Associated Types (결합 타입)]({% post_url 2020-02-29-Generics %}#associated-types-결합-타입) 부분을 참고하기 바랍니다.

[^type-inference]: '타입 추론' 에 대한 더 자세한 정보는, [The Basics (기초)]({% post_url 2016-04-24-The-Basics %}) 장에 있는 [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)]({% post_url 2016-04-24-The-Basics %}#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 부분을 참고하기 바랍니다.
