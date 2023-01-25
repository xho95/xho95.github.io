---
layout: post
comments: true
title:  "Structures and Classes (구조체와 클래스)"
date:   2020-04-14 10:00:00 +0900
categories: Swift Language Grammar Structure Class
redirect_from: "/swift/language/grammar/structure/class/2020/04/08/Structures-and-Classes.html"
---

{% include header_swift_book.md %}

## Structures and Classes (구조체와 클래스)

_구조체 (structures)_ 와 _클래스 (classes)_ 는 범용적이고, 유연한 구조물로써 프로그램 코드의 건축 자재 역할을 합니다. 속성과 메소드 정의로 구조체와 클래스에 기능을 추가하는 건 상수와, 변수, 및 함수 정의에 쓰인 것과 똑같은 구문을 사용합니다.

다른 프로그래밍 언어와 달리, 스위프트는 자신의 구조체와 클래스를 인터페이스와 구현 파일로 분리하여 생성하라고 요구하지 않습니다. 스위프트에선, 구조체나 클래스를 단 하나의 파일로 정의하며, 그 클래스나 구조체의 외부 인터페이스는 다른 코드에서 쓸 수 있게 자동으로 만들어집니다.

> 클래스의 인스턴스는 전통적으로 _객체 (object)_ 라고 합니다. 하지만, 스위프트의 구조체와 클래스는 다른 언어에서보다 기능이 훨씬 더 밀접해서, 이 장에서 설명한 대부분의 기능은 클래스나 구조체 타입 중 _어느 (either)_ 인스턴트에든 적용됩니다. 이 때문에, 좀 더 일반적인 용어인 _인스턴스 (instance)_ 를 사용합니다.[^object-instance]

### Comparing Structures and Classes (구조체와 클래스 비교하기)

스위프트의 구조체와 클래스엔 공통점이 많습니다. 둘 다 할 수 있는 건 이렇습니다:

* 속성을 정의하여 값을 저장함
* 메소드를 정의하여 기능을 제공함
* 첨자 연산을 정의하여 자신의 값에 접근하는 첨자 구문을 제공함
* 초기자를 정의하여 자신의 초기 상태를 설정함
* 확장을 하여 자신의 기본 구현 너머로 기능을 늘림
* 프로토콜을 따름으로써 특정 종류의 표준 기능을 제공함

더 많은 정보는, [Properties (속성)]({% link docs/swift-books/swift-programming-language/properties.md %}) 과, [Methods (메소드)]({% link docs/swift-books/swift-programming-language/methods.md %}), [Subscripts (첨자)]({% link docs/swift-books/swift-programming-language/subscripts.md %}), [Initialization (초기화)]({% link docs/swift-books/swift-programming-language/initialization.md %}), [Extensions (익스텐션; 확장)]({% link docs/swift-books/swift-programming-language/extensions.md %}), 및 [Protocols (프로토콜; 규약)]({% link docs/swift-books/swift-programming-language/protocols.md %}) 을 보기 바랍니다.

클래스는 구조체엔 없는 추가 능력이 있습니다:

* 상속 (inheritance) 은 한 클래스가 또 다른 것의 성질[^characteristics] 을 상속할 수 있게 합니다.
* 타입 변환 (type casting) 은 클래스 인스턴스의 타입을 실행 시간에 검사하고 해석할 수 있게 합니다.
* 정리자 (deinitializer) 는 클래스 인스턴스가 할당한 어떤 자원이든 풀어줄 수 있게 합니다.
* 참조 카운팅 (reference counting) 은 클래스 인스턴스로의 참조를 하나 이상 허용합니다.

더 많은 정보는, [Inheritance (상속)]({% link docs/swift-books/swift-programming-language/inheritance.md %}) 과, [Type Casting (타입 변환)]({% link docs/swift-books/swift-programming-language/type-casting.md %}), [Deinitialization (뒷정리)]({% link docs/swift-books/swift-programming-language/deinitialization.md %}), 및 [Automatic Reference Counting (자동 참조 카운팅)]({% link docs/swift-books/swift-programming-language/automatic-reference-counting.md %}) 을 보기 바랍니다.

클래스가 지원하는 추가 능력엔 복잡도 증가라는 비용이 따라 붙습니다. 일반적인 지침은, 이유 파악이 더 쉽기 때문에 구조체가 더 좋으며, 클래스는 적절하거나 필요할 때만 사용하라는 겁니다. 실상, 이는 직접 정의하는 대부분의 사용자 자료 타입은 구조체와 열거체일 거라는 의미입니다. 더 자세한 비교는, [Choosing Between Structures and Classes (구조체와 클래스 사이에서 선택하기)](https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes) 문서[^choosing-between-structures-and-classes] 를 보기 바랍니다.

> 클래스와 행위자는 똑같은 성질과 동작을 많이 공유합니다. 행위자에 대한 정보는, [Concurrency (동시성)]({% link docs/swift-books/swift-programming-language/concurrency.md %}) 장을 보기 바랍니다. 

#### Definition Syntax (정의 구문)

구조체와 클래스의 정의 구문은 비슷합니다. 구조체는 `struct` 키워드로 클래스는 `class` 키워드로 첫 소개를 합니다. 둘 다 한 쌍의 중괄호 안에 자신의 전체 정의를 둡니다:

```swift
struct SomeStructure {
  // 구조체 정의는 여기에 둠
}
class SomeClass {
  // 클래스 정의는 여기에 둠
}
```

> 새로운 구조체나 클래스를 정의할 때마다, 새로운 스위프트 타입을 정의하는 겁니다. 타입에는 (여기 있는 `SomeStructure` 와 `SomeClass` 같이) `UpperCamelCase` (낙타 모양 대문자)[^uppser-camel-case] 이름을 줘서 (`String` 과, `Int`, 및 `Bool` 같은) 표준 스위프트 타입의 대문자 방식과 맞춥니다. 속성과 메소드엔 (`frameRate` 와 `incrementCount` 같은) `lowerCamelCase` (낙타 모양 소문자) 이름을 줘서 타입 이름과 구별하도록 합니다.

구조체 정의와 클래스 정의의 예는 이렇습니다:

```swift
struct Resolution {
  var width = 0
  var height = 0
}
class VideoMode {
  var resolution = Resolution()
  var interlaced = false
  var frameRate = 0.0
  var name: String?
}
```

위 예제는 `Resolution` 이라는 새로운 구조체를 정의하여, 픽셀-기반[^pixel] 디스플레이의 해상도를 설명합니다. 이 구조체엔 `width` 와 `height` 이라는 두 저장 속성이 있습니다. 저장 속성은 구조체나 클래스의 일부로 엮여서 저장되는 상수나 변수입니다. 이 두 속성은 초기 정수 값을 `0` 으로 설정하여 `Int` 타입이라고 추론됩니다.

위 예제는 `VideoMode` 라는 새로운 클래스도 정의하여, 영상 디스플레이에 특화된 영상 모드를 설명합니다. 이 클래스에는 네 개의 저장 속성 변수가 있습니다. 첫 번째인, `resolution` 은, 새로운 `Resolution` 구조체 인스턴스로 초기화하며, 속성의 타입은 `Resolution` 으로 추론합니다. 다른 세 속성의 경우, 새로운 `VideoMode` 인스턴스에서 `interalced` 설정은 ("비월 주사 방식"[^interlaced] 을 의미하는) `false` 로, 녹화 프레임 재생 속도[^playback] 는 `0.0` 으로, 옵셔널 `String` 값은 `name` 으로 초기화할 겁니다. `name` 속성엔 기본 값 `nil`, 또는 "`name` 값 없음" 이, 자동으로 주어지는데, 이는 옵셔널 타입이기 때문입니다.

#### Structure and Class Instances (구조체와 클래스 인스턴스)

`Resolution` 구조체 정의와 `VideoMode` 클래스 정의는 `Resolution` 이나 `VideoMode` 가 보여질 모습만을 설명합니다. 그 자체로 특정 해상도나 영상 모드를 설명하진 않습니다. 그럴려면, 구조체나 클래스의 인스턴스를 생성해야 합니다.

구조체와 클래스 양 쪽의 인스턴스 생성 구문은 매우 비슷합니다:

```swift
let someResolution = Resolution()
let someVideoMode = VideoMode()
```

구조체와 클래스 둘 다 새 인스턴스에 초기자 구문[^initializer-syntax] 을 사용합니다. 가장 단순한 형식의 초기자 구문은 클래스나 구조체의 타입 이름 뒤에 빈 괄호가 있는, `Resolution()` 이나 `VideoMode()` 같은 겁니다. 이는 클래스나 구조체의 새 인스턴스를 생성하면서, 어떤 속성이든 자신의 기본 값으로 초기화합니다. 클래스와 구조체 초기화는 [Initialization (초기화)]({% link docs/swift-books/swift-programming-language/initialization.md %}) 장에서 더 자세하게 설명합니다.

#### Accessing Properties (속성에 접근하기)

인스턴스의 속성에 접근하는 건 _점 구문 (dot syntax)_ 으로 할 수 있습니다. 점 구문은, 인스턴스 이름 바로 뒤에 속성 이름을 쓰며, 어떤 공백도 없이, 마침표 (`.`) 로 구분합니다:

```swift
print ("The width of someResolution is \(someResolution.width)")
// "The width of someResolution is 0" 를 인쇄함
```

이 예제에서, `someResolution.width` 는 `someResolution` 의 `width` 속성을 참조하며, 자신의 기본 초기 값인 `0` 을 반환합니다.

하위 속성으로 파고 들어, `VideoMode` 의 `resolution` 속성 안의 `width` 속성 같이 할 수도 있습니다:

```swift
print ( "The width of someVideoMode is \(someVideoMode.resolution.width)")
// "The width of someVideoMode is 0" 를 인쇄함
```

점 구문을 써서 변수 속성에 새 값을 할당할 수도 있습니다:

```swift
someVideoMode.resolution.width = 1280
print ( "The width of someVideoMode is now \(someVideoMode.resolution.width)")
// "The width of someVideoMode is now 1280" 를 인쇄함
```

#### Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)

모든 구조체엔 자동으로 생기는 _멤버 초기자 (memberwise initializer)_ 가 있는데, 이걸 쓰면 새 구조체 인스턴스의 멤버 속성을 초기화할 수 있습니다. 새 인스턴스에 있는 속성의 기본 값은 이름으로 멤버 초기자로 전달할 수 있습니다:

```swift
let vga = Resolution(width: 640, height: 480)
```

구조체와 달리, 클래스 인스턴스는 기본 멤버 초기자를 받지 않습니다. 초기자는 [Initialization (초기화)]({% link docs/swift-books/swift-programming-language/initialization.md %}) 장에서 더 자세하게 설명합니다.

### Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)

_값 타입 (value type)_ 은 변수나 상수에 할당할 때, 또는 함수로 전달할 때, 자신의 값을 _복사하는 (copied)_ 타입입니다.

실제로 이전 장들 내내 값 타입을 광범위하게 썼습니다. 사실, 스위프트의 모든 기본 타입인-정수와, 부동 소수점 수, 불리언, 문자열, 배열, 및 딕셔너리-는 값 타입으로, 그 이면엔 구조체로 구현되어 있습니다.

스위프트에서 모든 구조체와 열거체는 값 타입입니다. 이것의 의미는 어떤 구조체와 열거체 인스턴스를 생성하든-그리고 어떤 값 타입을 속성으로 가지든-이들을 코드 주변으로 전달할 땐 항상 복사된다는 겁니다.

> 배열과, 딕셔너리, 및 문자열 같이 표준 라이브러리에서 정의한 집합체[^collections] 는 최적화를 써서 복사하기 위한 성능 비용을 감소시킵니다. 곧바로 복사하는 대신, 이러한 집합체는 원본 인스턴스와 복사본이 원소를 저장한 곳의 메모리를 공유합니다. 집합체의 한 복사본을 수정하면, 수정 직전에 원소를 복사합니다. 코드 동작은 마치 항상 곧바로 복사하는 것처럼 보입니다.

이전 예제에 있던 `Resolution` 구조체를 쓴, 다음 예제를 고려해 봅시다:

```swift
let hd = Resolution(width : 1920, height : 1080)
var cinema = hd
```

이 예제는 `hd` 라는 상수를 선언하고 여기에 **Full HD** 영상의 너비와 높이 (1920 픽셀 너비와 1080 픽셀 높이) 로 초기화된 `Resolution` 인스턴스를 설정합니다.

그런 다음 `cinema` 라는 변수를 선언하고 여기엔 현재 `hd` 값을 설정합니다. `Resolution` 은 구조체이기 때문에, 기존 인스턴스의 _복사본 (copy)_ 이 만들어지고, 이 새 복사본을 `cinema` 에 할당합니다. 이제 `hd` 와 `cinema` 가 똑같은 너비와 높이일지라도, 이들의 이면은 완전히 다른 두 인스턴스입니다.

그 다음, `cinema` 의 `width` 속성을 조금 고쳐서 디지털 영화 송출에 쓰는 살짝 더 넓은 **2K** 표준 (2048 픽셀 너비와 1080 픽셀 높이) 의 너비가 되게 합니다:

```swift
cinema.width = 2048
```

`cinema` 의 `width` 속성을 검사하면 진짜 `2048` 로 바뀐 걸 보여줍니다:

```swift
print("cinema is now \(cinema.width) pixels wide")
// "cinema is now 2048 pixels wide" 를 인쇄함
```

하지만, 원본 `hd` 인스턴스의 `width` 속성엔 여전히 예전 값인 `1920` 이 있습니다:

```swift
print("hd is still \(hd.width) pixels wide")
// "hd is still 1920 pixels wide" 를 인쇄함
```

`cinema` 에 현재 `hd` 값이 주어질 때, `hd` 의 저장 _값 (values)_ 이 새 `cinema` 인스턴스로 복사됩니다. 끝의 결과는 똑같은 수치 값이 담긴 완전히 분리된 두 개의 인스턴스입니다. 하지만, 분리된 인스턴스기 때문에, 아래 그림에서 보는 것처럼, `cinema` 너비에 `2048` 을 설정하는 건 `hd` 가 저장한 너비에는 영향이 없습니다:

![an copy of the value type](/assets/Swift/Swift-Programming-Language/Structures-and-Classes-value-type-copy.jpg)

열거체에 적용되는 동작도 똑같습니다:

```swift
enum CompassPoint {
  case north, south, east, west
  mutating func turnNorth() {
    self = .north
  }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")
// "The current direction is north" 를 인쇄함
// "The remembered direction is west" 를 인쇄함
```

`rememberedDirection` 에 `currentDirection` 값을 할당할 때, 실제로는 그 값의 복사본을 설정합니다. 그 후에 `currentDirection` 값을 바꾸는 건 `rememberedDirection` 가 저장한 원본 값의 복사본에는 영향을 주지 않습니다.

### Classes Are Reference Types (클래스는 참조 타입입니다)

값 타입과 달리, _참조 타입 (reference types)_ 은 변수나 상수에 할당할 때, 또는 함수로 전달할 때, 복사되지 _않습니다 (not)_. 복사 보단, 기존과 똑같은 인스턴스로의 참조를 사용합니다.

위에 정의한 `VideoMode` 클래스를 쓰는, 예는 이렇습니다:

```swift
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
```

이 예제는 `tenEighty` 라는 새로운 상수를 선언하고 이게 `VideoMode` 클래스의 새로운 인스턴스를 참조하도록 설정합니다. 영상 모드에는 이전의 `1920` 및 `1080` **HD** 해상도의 복사본을 할당합니다. 비월 주사 방식이고, 이름은 "`1080i`" 이며, 프레임 재생 속도는 초당 `25.0` 프레임이라고 설정합니다.

그 다음, `alsoTenEighty` 라는, 새로운 상수에 `tenEighty` 를 할당하고, `alsoTenEighty` 의 프레임 재생 속도를 수정합니다:

```swift
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
```

클래스는 참조 타입이기 때문에, `tenEighty` 와 `alsoTenEighty` 는 실제로 둘 다 _똑같은 (same)_ `VideoMode` 인스턴스를 참조합니다. 그 효과로, 아래 그림에서 보듯, 이들은 그냥 단 하나의 똑같은 인스턴스에 대한 서로 다른 두 이름일 뿐입니다:

![before and after of an reference type](/assets/Swift/Swift-Programming-Language/Structures-and-Classes-reference-type-before-after.jpg)

`tenEighty` 의 `frameRate` 속성을 검사하면 그 밑에 놓인 `VideoMode` 인스턴스로부터 새로운 프레임 재생 속도인 `30.0` 을 올바로 보고한다는 걸 보여줍니다:

```swift
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// "The frameRate property of tenEighty is now 30.0" 를 인쇄함
```

이 예제는 참조 타입의 파악이 얼마나 더 힘들어질 수 있는지도 보여줍니다. `tenEighty` 와 `alsoTenEighty` 가 프로그램 코드에서 멀리 떨어져 있다면, 영상 모드를 바꾸는 모든 방법을 찾는게 어려울 수가 있습니다. `tenEighty` 를 쓰는 곳마다, `alsoTenEighty` 를 쓰는 코드를 생각해야 하며, 그 반대도 마찬가집니다. 이와 대조하여, 값 타입은 파악하기가 더 쉬운데 이는 똑같은 값과 상호 작용할 모든 코드가 소스 파일 안에서 서로 가까이에 있기 때문입니다.

`tenEighty` 와 `alsoTenEighty` 는, 변수 보단, _상수 (constants)_ 로 선언한다는 걸 기록하기 바랍니다. 하지만, 여전히 `tenEighty.frameRate` 와 `alsoTenEighty.frameRate` 를 바꿀 수 있는데 이는 `tenEighty` 와 `alsoTenEighty` 상수 그 자체의 값을 실제로 바꾸진 않기 때문입니다. `tenEighty` 와 `alsoTenEighty` 그 자체는 `VideoMode` 인스턴스를 "저장 (store)" 하지 않습니다-그 대신, 이 둘은 모두 그 이면에서 `VideoMode` 인스턴스를 _참조 (refer)_ 합니다. 바뀌는 건 그 밑에 놓인 `VideoMode` 의 `frameRate` 속성이지, 그 `VideoMode` 로의 상수 참조 값이 아닙니다.

#### Identity Operators (정체 식별 연산자)

클래스는 참조 타입이기 때문에, 여러 개의 상수와 변수가 그 이면은 동일한 단 하나의 클래스 인스턴스를 참조할 가능성이 있습니다. (구조체와 열거체는 이와 같지 않은데, 이들은 상수나 변수로의 할당, 또는 함수로의 전달 때, 항상 복사되기 때문입니다.)

두 개의 상수나 변수가 정확하게 동일한 클래스 인스턴스를 참조하고 있는지 찾아내는 게 유용할 때가 있습니다. 이럴 수 있게, 스위프트는 두 개의 정체 식별 연산자를 제공합니다:

* 정체가 같음 (`===`)
* 정체가 같지 않음 (`!==`)

이 연산자들로 두 개의 상수나 변수가 동일한 단 하나의 인스턴스를 참조하는 지를 검사합니다:

```swift
if tenEighty === alsoTenEighty {
  print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// "tenEighty and alsoTenEighty refer to the same VideoMode instance." 를 인쇄함
```

(세 개의 같음 기호, 또는 `===` 로 나타낸) _정체가 같음 (identical to)_ 은 (두 개의 같음 기호, 또는 `==` 로 나타낸) _같음 (equal to)_ 과 똑같은 걸 의미하지 않는다는 걸 기록하기 바랍니다. _정체가 같음 (identical to)_ 의 의미는 클래스 타입의 두 상수나 변수가 정확하게 동일한 클래스 인스턴스를 참조한다는 겁니다. _같음 (equal to)_ 의 의미는, 타입 설계자가 정의한, 어떠한 적절한 _같음 (equal)_ 의 의미에 따라서, 두 인스턴스의 값이 같거나 같은 걸로 볼 수 있다고 고려하는 겁니다.

자신만의 구조체와 클래스를 정의할 땐, 두 인스턴스를 같다고 볼 조건을 결정하는게 본인 책임입니다. 자신만의 구현으로 `==` 와 `!=` 연산자 정의하는 과정은 [Equivalence Operators (같음 비교 연산자)]({% link docs/swift-books/swift-programming-language/advanced-operators.md %}#equivalence-operators-같음-비교-연산자) 에서 설명합니다.

#### Pointers (포인터)

**C** 나, **C++** 및 **오브젝티브-C** 를 경험했으면, 이 언어들이 _포인터 (pointers)_ 로 메모리 주소를 참조한다는 걸 알 겁니다. 스위프트의 상수나 변수는 어떠한 참조 타입의 인스턴스를 참조하는 건 **C** 의 포인터와 비슷하지만, 메모리 주소를 직접 포인팅하는 건 아니며, 참조를 생성하고 있다고 지시하기 위해 별표 (`*`) 를 쓸 걸 요구하지도 않습니다. 그 대신, 이 참조들을 스위프트의 다른 어떤 상수나 변수인 것 같이 정의합니다. 표준 라이브러리는 포인터와 직접 상호 작용할 필요가 있을 경우 쓸 수 있는 포인터 및 버퍼[^buffer] 타입을 제공합니다-[Manual Memory Management (수동 메모리 관리)](https://developer.apple.com/documentation/swift/swift_standard_library/manual_memory_management)[^manual-memory-management] 항목을 보기 바랍니다.

### 다음 장

[Properties (속성) >]({% link docs/swift-books/swift-programming-language/properties.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [Structures and Classes](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html) 에서 볼 수 있습니다.

[^object-instance]: 스위프트 구조체와 클래스를 같이 설명하는데, 객체라는 용어는 클래스에만 해당하므로, 인스턴스라는 용어를 사용해서 클래스와 구조체 모두에 해당하는 부분을 설명한다는 의미입니다.

[^uppser-camel-case]: '낙타 모양 대소문자 (camel case)' 는, 변수 이름을 지정할 때 모든 단어를 붙이고. 각 단어의 첫 글자를 대문자로 표기하면, 모양이 낙타 등처럼 보이기 때문에 나온 말입니다. 위키피디아에서는 'camel case' 를 '낙타 대문자' 라고 옮기고 있지만, 이 책에서는 `UpperCamelCase` 와 `lowerCamelCase` 로 또다시 나누기 때문에, 각각 '낙타 모양 대문자' 와 '낙타 모양 소문자' 라고 옮깁니다. '낙타 모양 대소문자 (camel Case)' 에 대한 보다 자세한 내용은, 위키피디아의 [Camel case](https://en.wikipedia.org/wiki/Camel_case) 항목과 [낙타 대문자](https://ko.wikipedia.org/wiki/낙타_대문자) 항목을 보도록 합니다.

[^interlaced]: 'interlaced' 는 예전 모니터의 화면 주사 방식 중에서 '비월 주사 방식' 을 의미하는 것입니다. 보다 자세한 내용은 위키피디아의 [Interlaced video](https://en.wikipedia.org/wiki/Interlaced_video) 와 [비월 주사 방식](https://ko.wikipedia.org/wiki/비월_주사_방식) 항목을 보도록 합니다.

[^choosing-between-structures-and-classes]: 원문 자체가 '애플 개발자 (developer) 문서 링크' 입니다.

[^manual-memory-management]: 이것 역시 원문 자체가 애플 '개발자' 문서에 대한 링크입니다. 초창기에는 `UnsagePointer` 에 대한 설명이 본문에도 있었으나, 스위프트를 갱신하면서 관련 설명이 없어졌습니다.
