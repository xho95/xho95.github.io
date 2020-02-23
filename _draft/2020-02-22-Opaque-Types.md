---
layout: post
comments: true
title:  "Swift 5.2: Opaque Types (불투명한 타입)"
date:   2020-02-22 11:30:00 +0900
categories: Swift Language Grammar Opaque Type
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Opaque Types](https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html) 부분[^Opaque-Types]을 정리한 글입니다.

## Opaque Types

함수나 메소드에서 Opaque (불투명한) 반환 타입을 쓰면 반환 값의 타입 정보를 감춥니다. 함수의 반환 타입으로 명확한 타입 (concrete type) 을 제공하는 대신에, 반환 값을 프로토콜로써 묘사합니다. 타입 정보를 감추는 것은 모듈과 그 모듈을 호출하는 코드 사이에서 유용한데, 이는 반환 값의 실제 타입을 사적 영역에 남겨둘 수 있기 때문입니다. 값을 프로토콜 타입으로 반환하는 것과는 다르게, opaque 타입은 타입 정체성 (type identity) 을 보존합니다. - 컴파일러는 타입 정보에 접근하지만, 모듈 사용자는 안됩니다.

### Opaque 타입이 해결하는 문제

예를 들어, ASCII 로 예술적 도형을 그리는 모듈을 제작한다고 칩시다. ASCII 도형 모듈의 기본 성질로 도형을 문자열로 표현해서 반환하는 `draw()` 라는 함수가 있습니다. 이 함수를 `Shape` 프로토콜의 요구 사항 (requirement) 으로 사용할 수 있습니다.

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

### Opaque 타입 반환

Opaque 타입은 generic 타입이 반대가 된 것 (reverse) 으로 생각할 수 있습니다. Generic 타입은 함수를 호출하는 코드가 함수의 매개변수와 반환 값의 타입을 선택하도록 해서 함수 구현에서는 추상화하도록 합니다. 예를 들어, 아래 코드에 있는 함수의 반환 타입은 호출하는 쪽에서 지정합니다:

```swift
func max<T>(_ x: T, _ y: T) -> T where T: Comparable { ... }
```

`max(_:_:)` 를 호출하는 코드는 x 와 y 의 값을 선택하고, 이 값들의 타입은 T 의 명확한 타입을 결정합니다. 호출하는 코드는 `Comparable` 규칙 (protocol) 을 준수하는 모든 타입을 쓸 수 있습니다. 함수 안의 코드는 일반화된 방식 (general way) 으로 작성되기 때문에 호출하는 쪽에서 제공하는 모든 타입을 처리할 수 있습니다. `max(_:_:)` 는 모든 `Comparable` 타입이 공유하는 기능만을 사용하여 구현됩니다.

Opaque 반환 타입을 쓰는 함수에서는 이 역할이 반대가 됩니다. Opaque 타입은 함수 구현부가 반환하는 값의 타입을 선택하도록 해서 함수를 호출하는 코드가 추상화하도록 합니다. 예를 들어, 아래 예제의 함수는 사다리꼴 (trapezoid) 을 반환하면도 도형의 실제 타입을 드러내지 않습니다.

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



### 생각거리



### 참고 자료

[^Opaque-Types]: 전체 원문은 [Opaque Types](https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html)에서 확인할 수 있습니다.

[^flippedTriangle-Type]: 여기서 `flippedTriangle` 의 타입은 `FlippedShape<Triangle>` 가 됩니다. 책의 내용대로라면 모듈내에 있는 `FlippedShape` 구조체 타입이 밖으로 드러나는 문제가 있다는 의미가 됩니다.

[^joinedTriangle-Type]: Swift Programming Language 책에서는 `joinedTriangle` 의 타입이 `JoinedShape<FlippedShape<Triangle>, Triangle>` 인 것으로 나오는데, 오류인 것 같습니다.
