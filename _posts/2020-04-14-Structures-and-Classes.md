---
layout: post
comments: true
title:  "Swift 5.5: Structures and Classes (구조체와 클래스)"
date:   2020-04-14 10:00:00 +0900
categories: Swift Language Grammar Structure Class
redirect_from: "/swift/language/grammar/structure/class/2020/04/08/Structures-and-Classes.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Structures and Classes](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html) 부분[^Structures-and-Classes]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Structures and Classes (구조체와 클래스)

_구조체 (structures)_ 와 _클래스 (classes)_ 는 프로그램 코드의 '건축 자재 (building blocks)' 역할을 하는 범용적이고, 유연한 '구조물 (constructs)' 입니다. 구조체와 클래스에 기능을 추가하기 위한 속성과 메소드는 상수와, 변수, 및 함수를 정의할 때와 똑같은 구문 표현을 사용하여 정의합니다.

다른 프로그래밍 언어와는 달리, 스위프트는 사용자 정의 구조체와 클래스에서 인터페이스 파일과 구현 파일을 분리하여 생성할 필요가 없습니다. 스위프트에서는, 구조체나 클래스를 단일 파일로 정의하며, 해당 클래스나 구조체에 대한 외부 인터페이스는 다른 코드에서 자동으로 사용 가능합니다.

> 클래스의 인스턴스는 전통적으로 _객체 (object)_ 라고 합니다. 하지만, 스위프트의 구조체와 클래스는 다른 언어보다 그 기능이 훨씬 더 가까우며, 이 장 대부분이 클래스나 구조체 _어느 (either)_ 것의 인스턴트에든 적용되는 기능을 설명합니다. 이 때문에, 더 일반적인 용어인 _인스턴스 (instance)_ 를 사용합니다.[^object-instance]

### Comparing Structures and Classes (구조체와 클래스 비교하기)

스위프트의 구조체와 클래스는 공통점을 많이 가지고 있습니다. 둘 다 다음을 할 수 있습니다:

* 값을 저장하는 속성을 정의함
* 기능을 제공하는 메소드를 정의함
* 값에 대한 접근을 첨자 연산 구문으로 제공하는 첨자 연산을 정의함
* 초기 상태를 설정하는 초기자를 정의함
* 기본 구현 너머로 기능을 확대하도록 확장됨
* 정해진 종류의 표준 기능을 제공하기 위해 프로토콜을 준수함

더 많은 정보는, [Properties (속성)]({% post_url 2020-05-30-Properties %}), [Methods (메소드)]({% post_url 2020-05-03-Methods %}), [Subscripts (첨자 연산)]({% post_url 2020-03-30-Subscripts %}), [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}), [Extensions (익스텐션; 확장)]({% post_url 2016-01-19-Extensions %}), 그리고 [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 을 참고하기 바랍니다.

클래스는 구조체에는 없는 추가적인 보유 능력을 가집니다:

* '상속 (inheritance)' 은 한 클래스가 또 다른 클래스의 '성질 (characteristics)' 을 상속하도록 해줍니다.
* '타입 변환 (type casting)' 은 클래스 인스턴스의 타입을 '실행 시간' 에 검사하고 해석하도록 해줍니다.
* '정리자 (deinitializer)' 는 클래스 인스턴스가 할당 받은 어떤 자원이든 자유롭게 풀어주도록 합니다.
* '참조 카운팅 (reference counting)' 은 클래스 인스턴스에 대한 참조를 하나 이상 허용합니다.

더 많은 정보는, [Inheritance (상속)]({% post_url 2020-03-31-Inheritance %}), [Type Casting (타입 변환)]({% post_url 2020-04-01-Type-Casting %}), [Deinitialization (객체 정리하기)]({% post_url 2017-03-03-Deinitialization %}), 그리고 [Automatic Reference Counting (자동 참조 카운팅)]({% post_url 2020-06-30-Automatic-Reference-Counting %}) 을 참고하기 바랍니다.

클래스가 지원하는 추가적인 보유 능력은 복잡도 증가라는 비용에 직면합니다. 일반적인 '지침 (guideline)' 대로, 이유를 파악하기가 더 쉽기 때문에 구조체가 더 좋으며, 클래스는 적절하거나 필요할 때만 사용합니다. 실제로, 이는 대부분의 사용자 정의 자료 타입은 구조체나 열거체로 정의된다는 의미입니다. 좀 더 자세한 비교는, [Choosing Between Structures and Classes (구조체와 클래스 사이에서 선택하기)](https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes) 문서[^choosing-between-structures-and-classes]를 첨고하기 바랍니다.

#### Definition Syntax (정의 구문 표현)

구조체와 클래스를 정의하는 구문 표현은 비슷합니다. 구조체는 `struct` 키워드로 도입하고 클래스는 `class` 키워드로 도입합니다. 둘 다 한 쌍의 중괄호 안에 전체 정의를 둡니다:

```swift
struct SomeStructure {
  // 구조체 정의는 여기에 둡니다.
}
class SomeClass {
  // 클래스 정의는 여기에 둡니다.
}
```

> 새로운 구조체나 클래스를 정의할 때마다, 새로운 스위프트 타입을 정의하는 것입니다. 타입은 (`String`, `Int`, 그리고 `Bool` 같은) 표준 스위프트 타입의 대문자 방식과 일치하도록 (여기 있는 `SomeStructure` 와 `SomeClass` 같이) `UpperCamelCase`[^uppser-camel-case] (낙타 모양 대문자) 이름을 부여합니다. 속성과 메소드는 타입 이름과 구별하기 위해 (`frameRate` 와 `incrementCount` 같이) `lowerCamelCase` (낙타 모양 소문자) 이름을 부여합니다.

다음은 구조체 정의와 클래스 정의에 대한 예제입니다:

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

위 예제는, 픽셀-기반 디스플레이 해상도를 설명하는, `Resolution` 이라는 새로운 구조체를 정의합니다. 이 구조체는 `width` 와 `height` 라는 두 개의 '저장 속성 (stored properties)' 을 가집니다. 저장 속성은 구조체나 클래스에 뭉쳐져 저장되는 상수나 변수입니다. 이 두 속성들은 `0` 이라는 초기 값으로 설정되므로 `Int` 타입으로 추론됩니다.

위 예제는, 영상 디스플레이에 지정된 영상 모드를 설명하는, `VideoMode` 라는 새로운 클래스도 정의합니다. 이 클래스는 네 개의 '저장 속성' 변수를 가집니다. 첫 번째인, `resolution` 은, 속성 타입을 `Resolution` 으로 추론하도록, 새로운 `Resolution` 구조체 인스턴스로 초기화됩니다. 다른 세 속성의 경우, `interalced` 는 ("비월 주사 방식 (noninterlaced) 영상"[^interlaced] 을 의미하는) `false`, '녹화 프레임 재생 속도' 는 `0.0`, 그리고 `name` 이라는 '옵셔널 `String` 값' 을 가지고 새로운 `VideoMode` 인스턴스가 초기화될 것입니다. `name` 속성은, 옵셔널 타입이기 때문에, 기본 값이 `nil`, 또는 "`name` 값이 없음", 으로 자동으로 주어집니다.

#### Structure and Class Instances (구조체와 클래스 인스턴스)

`Resolution` 구조체 정의와 `VideoMode` 클래스 정의는 `Resolution` 또는 `VideoMode` 가 무엇으로 보일 지만을 설명합니다. 그 자체로는 지정된 해상도나 영상 모드를 설명하지 않습니다. 그렇게 하기 위해서는, 구조체나 클래스의 인스턴스를 생성할 필요가 있습니다.

인스턴스를 생성하는 구문 표현은 구조체와 클래스 둘 다 매우 비슷합니다:

```swift
let someResolution = Resolution()
let someVideoMode = VideoMode()
```

구조체와 클래스 둘 다 새로운 인스턴스를 위해 '초기자 구문 표현 (initializer syntax)' 을 사용합니다. 가장 간단한 형식의 초기자 구문 표현은, `Resolution()` 이나 `VideoMode()` 처럼, 클래스나 구조체의 타입 이름 뒤에 빈 괄호를 사용합니다. 이는 클래스나 구조체의, 어떤 속성이든 '기본 값' 으로 초기화 된, 새로운 인스턴스를 생성합니다. 클래스와 구조체의 초기화는 [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 에서 더 자세하게 설명합니다.

#### Accessing Properties (속성에 접근하기)

인스턴스의 속성은 _점 구문 표현 (dot syntax)_ 을 사용하여 접근할 수 있습니다. '점 구문' 에서, 속성 이름은 인스턴스 이름 바로 뒤에, 어떤 공백도 없이, '마침표 (period; `.`)' 로 구분하여, 작성합니다:

```swift
print ( "The width of someResolution is \(someResolution.width)")
// "The width of someResolution is 0" 를 인쇄합니다.
```

이 예제에서, `someResolution.width` 는 `someResolution` 의 `width` 속성을 참조하며, `0` 이라는 '기본 초기 값' 을 반환합니다.

`VideoMode` 의 `resolution` 속성에 있는 `width` 속성 처럼, '하위 속성' 으로 파고 들어 갈 수 있습니다:

```swift
print ( "The width of someVideoMode is \(someVideoMode.resolution.width)")
// "The width of someVideoMode is 0" 를 인쇄합니다.
```

'점 구문' 은 '변수 속성' 에 새로운 값을 할당하기 위해서도 사용할 수 있습니다:

```swift
someVideoMode.resolution.width = 1280
print ( "The width of someVideoMode is now \(someVideoMode.resolution.width)")
// "The width of someVideoMode is now 1280" 를 인쇄합니다.
```

#### Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)

모든 구조체는 자동으로 생기는 _멤버 초기자 (memberwise initializer)_ 를 가지는데, 이는 새로운 구조체 인스턴스의 멤버 속성을 초기화하는데 사용할 수 있습니다. 새로운 인스턴스의 속성 기본 값은 멤버 초기자에 이름으로써 전달할 수 있습니다:

```swift
let vga = Resolution(width: 640, height: 480)
```

구조체와는 달리, 클래스 인스턴스는 '기본 멤버 초기자' 를 받지 않습니다. 초기자는 [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 에서 더 자세하게 설명합니다.

### Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)

_값 타입 (value type)_ 은 변수나 상수에 할당될 때, 또는 함수에 전달될 때, 값이 _복사되는 (copied)_ 타입입니다.

실제로 값 타입은 이전 장 전체에서 광범위하게 사용했습니다. 사실상, 스위프트의 모든 기본 타입-정수, 부동 소수점 수, '불리언 (Booleans)', 문자열, 배열, 그리고 딕셔너리-들은 값 타입이며, 그 이면을 살펴보면 구조체로 구현되어 있습니다.

스위프트에서 모든 구조체와 열거체는 값 타입니다. 이는 생성하는 어떤 구조체와 열거체 인스턴스-그리고 속성으로 가진 어떤 값 타입-이라도 코드에서 전달될 때 항상 복사된다는 의미입니다.

> 배열, 딕셔너리, 그리고 문자열 같이 표준 라이브러리에서 정의한 '집합체 (collections)' 들은 복사에 드는 성능 비용을 감소하기 위한 최적화를 사용합니다. 곧바로 복사하는 대신, 이 '집합체' 들은 원본 인스턴스와 복사본 사이에 원소가 저장된 곳의 메모리를 공유합니다. 집합체의 복사본 중 하나가 수정되면, 수정되기 바로 전에 그 원소를 복사합니다. 코드의 작동 방식은 항상 마치 복사가 곧바로 발생하는 것처럼 보입니다.

이전 예제의 `Resolution` 구조체를 사용하는, 다음 예제를 살펴봅시다:

```swift
let hd = Resolution(width : 1920, height : 1080)
var cinema = hd
```

이 예제는 `hd` 라는 상수를 선언하고 이를 (1920 픽셀 너비와 1080 픽셀 높이의) 'Full HD 영상' 너비와 높이로 초기화된 `Resolution` 인스턴스를 설정합니다.

그런 다음 `cinema` 라는 변수를 선언하고 이에 `hd` 의 현재 값을 설정합니다. `Resolution` 은 구조체이기 때문에, 기존 인스턴스의 _복사본 (copy)_ 을 만들며, 이 새 복사본을  `cinema` 에 할당합니다. `hd` 와 `cinema` 는 이제 너비와 높이가 똑같지만, 이면을 살펴보면 서로 완전히 다른 두 인스턴스입니다.

다음으로, `cinema` 의 `width` 속성을 '디지털 영화 송출' 에 사용되는 것보다 약간 더 넓은 (2048 픽셀 너비와 1080 픽셀 높이인)'2K 표준' 너비로 수정합니다.

```swift
cinema.width = 2048
```

`cinema` 의 `width` 속성을 검사하여 진짜 `2048` 로 바뀌었는지 봅니다:

```swift
print("cinema is now \(cinema.width) pixels wide")
// "cinema is now 2048 pixels wide" 를 인쇄합니다.
```

하지만, 원본인 `hd` 인스턴스의 `width` 속성은 여전히 예전 값인 `1920` 을 가집니다:

```swift
print("hd is still \(hd.width) pixels wide")
// "hd is still 1920 pixels wide" 를 인쇄합니다.
```

`cinema` 에 `hd` 의 현재 값을 부여할 때는, `hd` 에 저장된 _값 (values)_ 이 새로운 `cinema` 인스턴스로 복사됩니다. 최종 결과는 똑같은 수치 값을 담은 완전히 분리된 두 인스턴스입니다. 하지만, 분리된 인스턴스이기 때문에,  `cinema` 의 너비를 `2048` 로 설정하는 것은, 아래 그럼에 있는 것처럼, `hd` 에 저장된 너비에 영향을 주지 않습니다:

![an copy of the value type](/assets/Swift/Swift-Programming-Language/Structures-and-Classes-value-type-copy.jpg)

열거체에도 똑같은 작동 방식이 적용됩니다:

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
// "The current direction is north" 를 인쇄합니다.
// "The remembered direction is west" 를 인쇄합니다.
```

`rememberedDirection` 에 `currentDirection` 의 값을 할당할 때, 실제로는 해당 값의 복사본을 설정하는 것입니다. 그러므로 `currentDirection` 값을 바꾸는 것은 `rememberedDirection` 에 저장된 원래 값의 복사본에는 영향을 주지 않습니다.

### Classes Are Reference Types (클래스는 참조 타입입니다)

값 타입과는 달리, _참조 타입 (reference types)_ 은 변수나 상수에 할당할 때, 또는 함수에 전달할 때, 복사하지 _않 (not)_ 습니다. 복사하는 대신, 기존과 똑같은 인스턴스에 대한 참조를 사용합니다.

다음은, 위에서 정의한 `VideoMode` 클래스를 사용하는, 예제입니다:

```swift
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
```

이 예제는 `tenEighty` 라는 새로운 상수를 선언하고 `VideoMode` 클래스의 새로운 인스턴스에 대한 참조를 설정합니다. '영상 (video) 모드' 는 이전에 있던 `1920` 너비 `1080` 폭 'HD 해상도' 의 복사본으로 할당됩니다. '비월 주사 방식' 으로 설정하고, 이름은 "`1080i`" 로 설정하며, '프레임 재생 속도' 는 초당 `25.0` 프레임으로 설정합니다.

다음으로, `tenEighty` 를, `alsoTenEighty` 라는, 새로운 상수로 할당하며, `alsoTenEighty` 의 '프레임 재생 속도' 를 수정합니다:

```swift
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
```

클래스가 참조 타입이기 때문에, `tenEighty` 와 `alsoTenEighty` 둘 다 실제로는 _똑같은 (same)_ `VideoMode` 인스턴스를 참조합니다. 실제로, 이들은, 아래 그림에 보인 것처럼, 똑같은 단일 인스턴스에 대한 서로 다른 두 이름일 뿐입니다:

![before and after of an reference type](/assets/Swift/Swift-Programming-Language/Structures-and-Classes-reference-type-before-after.jpg)

`tenEighty` 의 `frameRate` 속성을 검사하면 실제 `VideoMode` 인스턴스에 있는 새로운 '프레임 재생 속도' 인 `30.0` 을 올바르게 보고합니다:

```swift
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// "The frameRate property of tenEighty is now 30.0" 를 인쇄합니다.
```

이 예제는 참조 타입이 얼마나 더 파악하기 힘든 지도 보여줍니다. `tenEighty` 와 `alsoTenEighty` 가 프로그램 코드에서 꽤 멀리 떨어져 있다면, '영상 모드' 를 바꾸는 방법 모두를 찾기가 여러울 수 있습니다. `tenEighty` 를 사용하는 곳마다, `alsoTenEighty` 를 사용하는 코드에 대해서도 생각해야 하며, 그 반대도 마찬가지 입니다. 이와 대조적으로, 값 타입은 파악하기가 더 쉬운데 왜냐면 똑같은 값과 상호 작용하는 모든 코드가 소스 파일에서 서로 가깝게 있기 때문입니다.

`tenEighty` 와 `alsoTenEighty` 를, 변수가 아닌, _상수 (constants)_ 로 선언한다는 점을 기억하기 바랍니다. 하지만, 여전히 `tenEighty.frameRate` 와 `alsoTenEighty.frameRate` 를 바꿀 수 있는데 `tenEighty` 와 `alsoTenEighty` 상수 자체의 값은 실제로 바뀌지 않기 때문입니다. `tenEighty` 와 `alsoTenEighty` 자체는 `VideoMode` 인스턴스를 "저장 (store)" 하지 않습니다-그 대신, 이면을 살펴보면 이 둘 다 `VideoMode` 인스턴스를 _참조하고 (refer)_ 있습니다. 해당 `VideoMode` 에 대한 상수 참조의 값이 아니라, `VideoMode` 인 것의 `frameRate` 속성이 바뀌는 것입니다.

#### Identity Operators (식별 연산자)

클래스가 참조 타입이기 때문에, 이면을 살펴보면 다중 상수와 변수가 똑같은 단일 클래스의 인스턴스를 참조하는 것이 가능합니다. (똑같은 일은 구조체와 열거체에서는 일어나지 않는데, 이들은 상수나 변수에 할당하거나, 함수에 전달할 때, 항상 복사되기 때문입니다.)

두 개의 상수나 변수가 정확하게 똑같은 클래스의 인스턴스를 참조하고 있는지를 알아내는 것이 유용할 때가 있습니다. 이를 위해, 스위프트는 두 개의 '식별 연산자' 를 제공합니다:

* '식별됨 (identical to; `===`)'
* '식별되지 않음 (not identical to; `!==`)'

두 개의 상수나 변수가 똑같은 단일 인스턴스를 참조하는 지를 검사하려면 이 연산자들을 사용합니다:

```swift
if tenEighty === alsoTenEighty {
  print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// "tenEighty and alsoTenEighty refer to the same VideoMode instance." 를 인쇄합니다.
```

(세 개의 등호 기호, 또는 `===` 로 표시한) _식별됨 (identical to)_ 은 (두 개의 등호 기호, 또는 `==` 로 표시한) _같음 (equal to)_ 과 똑같은 의미가 아닙니다. _식별됨 (identical to)_ 은 클래스 타입의 두 상수나 변수가 정확하게 똑같은 클래스 인스턴스를 참조한다는 것을 의미합니다. _같음 (equal to)_ 은, 타입 설계자가 정의한, 어떤 적절한 _같음 (equal)_ 의 의미에 따라서, 두 인스턴스의 값이 같거나 '동치 (equivalent)' 라고 고려한다는 의미입니다.

자신만의 구조체와 클래스를 정의할 때는, 두 인스턴스의 같음을 규명하는 것이 무엇인지 결정하는 것은 본인 책임입니다. 자신만의 `==` 연산자와 `!=` 연산자 구현을 정의하는 과정은 [Equivalence Operators (같음 비교 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#equivalence-operators-같음-비교-연산자) 에서 설명합니다.

#### Pointers (포인터)

C, C++ 또는 오브젝티브-C 에 대한 경험이 있다면, 이 언어들은 메모리 주소를 참조할 때 _포인터 (pointers)_ 를 사용함을 알고 있을 것입니다. 어떤 참조 타입의 인스턴스를 참조하는 스위프트 상수나 변수는 C 의 포인터와 비슷하지만, 메모리 주소에 대한 직접적인 포인터는 아니며, 참조를 생성한다고 지시하는 '별표 (asterisk; `*`)' 를 작성하는 것도 필요하지 않습니다. 그 대신, 이들은 스위프트에 있는 다른 상수나 변수와 똑같이 정의합니다. 표준 라이브러리는 직접 포인터와 상호 작용할 필요가 있을 경우 사용할 수 있는 '포인터' 와 '버퍼 타입 (buffer types)' 을 제공합니다-이는 [Manual Memory Management (수동 메모리 관리)](https://developer.apple.com/documentation/swift/swift_standard_library/manual_memory_management)[^manual-memory-management] 를 참고하기 바랍니다.

### 다음 장

[Properties (속성) > ]({% post_url 2020-05-30-Properties %})

### 참고 자료

[^Structures-and-Classes]: 이 글에 대한 원문은 [Structures and Classes](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^object-instance]: 여기서 '인스턴스' 가 '객체' 보다 더 일반적인 용어라는 표현을 사용했는데, '객체' 라고 하면 '클래스의 인스턴스' 만을 지칭하지만, 그냥 '인스턴스' 라고 하면 '구조체의 인스턴스' 도 모두 포함하는 개념이기 때문입니다.

[^uppser-camel-case]: '낙타 모양 대소문자 (camel case)' 는, 변수 이름을 지정할 때 모든 단어를 붙이고. 각 단어의 첫 글자를 대문자로 표기하면, 모양이 낙타 등처럼 생겼기 때문에 나온 말입니다. 위키피디아에서는 'camel case' 를 '낙타 대문자' 라고 옮기고 있지만, 이 책에서는 `UpperCamelCase` 와 `lowerCamelCase` 로 또다시 구분을 하기 때문에, 각각 '낙타 모양 대문자' 와 '낙타 모양 소문자' 라고 옮깁니다. '낙타 모양 대소문자 (camel Case)' 에 대한 보다 자세한 내용은 위키피디아의 [Camel case](https://en.wikipedia.org/wiki/Camel_case) 와 [낙타 대문자](https://ko.wikipedia.org/wiki/낙타_대문자) 항목을 참고하기 바랍니다.

[^interlaced]: 'interlaced' 는 예전 모니터의 화면 주사 방식 중에서 '비월 주사 방식' 을 의미하는 것입니다. 보다 자세한 내용은 위키피디아의 [Interlaced video](https://en.wikipedia.org/wiki/Interlaced_video) 와 [비월 주사 방식](https://ko.wikipedia.org/wiki/비월_주사_방식) 항목을 참고하기 바랍니다.

[^choosing-between-structures-and-classes]: 원문 자체가 애플 '개발자 (developer)' 문서에 대한 링크입니다.

[^manual-memory-management]: 이것 역시 원문 자체가 애플 '개발자' 문서에 대한 링크입니다. 초창기에는 `UnsagePointer` 에 대한 설명이 본문에도 있었으나, 스위프트를 갱신하면서 관련 설명이 없어졌습니다.
