---
layout: post
comments: true
title:  "Swift 5.2: Structures and Classes (구조체와 클래스)"
date:   2020-04-14 10:00:00 +0900
categories: Swift Language Grammar Structure Class
redirect_from: "/swift/language/grammar/structure/class/2020/04/08/Structures-and-Classes.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Structures and Classes](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html) 부분[^Structures-and-Classes]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## Structures and Classes (구조체와 클래스)

_구조체 (structures)_ 와 _클래스 (classes)_ 는 프로그램 코드에서 건축 자재 역할을 하는 범용적이고, 유연한 구조물을 말합니다. 구조체와 클래스에 기능을 추가하기 위해 속성과 메소드를 정의할 때는 상수, 변수, 그리고 함수를 정의할 때와 똑같은 구문 표현을 사용하면 됩니다.

다른 프로그래밍 언어들과는 다르게, 스위프트에서는 구조체와 클래스에 대해서 인터페이스 파일과 구현 파일을 별도로 분리해서 만들 필요가 없습니다. 스위프트에서는, 구조체나 클래스는 단일한 파일내에서 정의하면 되고, 그 클래스나 구조체에 대한 외부 인터페이스는 다른 코드에서 자동으로 사용할 수 있도록 만들어 줍니다.

> 클래스의 인스턴스는 전통적으로 _객체 (object)_ 라고 알려져 있습니다. 하지만, 스위프트의 구조체와 클래스는 그 기능 면에서 다른 언어에서 보다 훨씬 더 가까우며, 이번 장에서 설명하는 기능 대부분은 클래스이든 구조체이든 _어느 쪽의 (either)_ 인스턴스에도 적용할 수 있습니다. 이러한 이유로 때문에, 더 일반적인 용어인 _인스턴스 (instance)_ 를 사용합니다.[^object-instance]

### Comparing Structures and Classes (구조체와 클래스 비교하기)

스위프트의 구조체와 클래스는 공통점이 아주 많습니다. 다음과 같은 것들이 있습니다:

* 값을 저장하기 위한 속성 정의하기
* 기능을 제공하기 위한 메소드 정의하기
* 첨자 연산 구문으로 값에 접근할 수 있도록 첨자 연산 정의하기
* 초기 상태를 설정하기 위한 초기자 정의하기
* 기능을 기본 구현 이상으로 확대하도록 확장하기
* 정해진 종류의 표준 기능을 제공하도록 프로토콜 준수하기

더 자세한 내용은, [Properties (속성)], [Methods (메소드)]({% post_url 2020-05-03-Methods %}), [Subscripts (첨자 연산)]({% post_url 2020-03-30-Subscripts %}), [Initialization (초기화하기)]({% post_url 2016-01-23-Initialization %}), [Extensions (확장)]({% post_url 2016-01-19-Extensions %}), 그리고 [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 을 참조하기 바랍니다.

클래스는 구조체에는 없는 다음의 추가 기능들을 가지고 있습니다:

* '상속 (inheritance)' 은 한 클래스가 다른 클래스의 성질을 상속 할 수 있게 합니다.
* '타입 변환 (type casting)' 은 클래스 인스턴스의 타입을 '실행 시간 (runtime)' 에 검사하고 해석할 수 있게 합니다.
* '정리자 (deinitializer)' 는 클래스 인스턴스가 할당한 어떤 자원이든 다시 확보할 수 있게 합니다.
* '참조 카운팅 (reference counting)' 은 클래스 인스턴스에 대해 참조를 한 개 이상 할 수 있게 합니다.

더 자세한 내용은, [Inheritance (상속)]({% post_url 2020-03-31-Inheritance %}), [Type Casting (타입 변환)]({% post_url 2020-04-01-Type-Casting %}), [Deinitialization (객체 정리하기)]({% post_url 2017-03-03-Deinitialization %}), 그리고 [Automatic Reference Counting (자동 참조 카운팅)] 을 참고하기 바랍니다.

클래스가 지원하는 추가 기능을 쓴다는 것은 복잡성 증가라는 비용을 지불하겠다는 의미입니다. 일반적인 지침을 따른다면, 되도록이면 이유를 파악하기 더 쉬운 구조체를 사용하고, 클래스는 더 적합하거나 꼭 필요한 경우에만 사용하도록 합니다. 실제로, 이것은 새로 만드는 자료 타입의 대부분은 구조체나 열거체가 될 것임을 의미입니다. 이에 대한 좀 더 자세히 비교는, [Choosing Between Structures and Classes (구조체와 클래스 사이에서 선택하기)](https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes) 를 첨고하기 바랍니다.

#### Definition Syntax (정의 구문 표현)

구조체와 클래스는 비슷한 정의 구문 표현을 가지고 있습니다. 구조체를 도입하려면 `struct` 키워드를 사용하고 클래스는 `class` 키워드를 사용합니다. 둘 다 전체 정의는 한 쌍의 중괄호 안에 집어넣습니다:

```swift
struct SomeStructure {
  // 여기서 구조체를 정의합니다.
}
class SomeClass {
  // 여기서 클래스를 정의합니다.
}
```

> 새로운 구조체나 클래스를 정의할 때마다, 새로운 스위프트 타입을 정의하고 있는 것입니다. 타입은 (여기서 `SomeStructure` 와 `SomeClass` 라고 한 것처럼) `UpperCamelCase`-대문자로 시작하는 낙타 등 모양[^uppser-camel-case]-이름을 부여해서 표준 스위프트 타입의 대문자 방식 (`String`, `Int`, 그리고 `Bool` 과 같은 것들) 에 맞추도록 합니다. 속성과 메소드는 `lowerCamelCase`-소문자로 시작하는 낙타 등 모양-이름 (가령 `frameRate` 와 `incrementCount` 같은 것들) 을 부여해서 타입 이름과 구별되도록 합니다.

아래는 구조체 정의와 클래스 정의에 대한 예제입니다:

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

위의 예제는 `Resolution` 이라는 새 구조체를 정의해서, 픽셀 기반 디스플레이의 해상도를 묘사합니다. 이 구조체는 `width` 와 `height` 라는 두 개의 '저장 속성 (stored properties)' 을 가집니다. 저장 속성은 구조체나 클래스의 일부로 포함되어 저장되는 상수나 변수를 말합니다. 이 두 속성은 타입이 `Int` 로 추론되는데 이는 기본 설정 값이 정수인 `0` 으로 설정되었기 때문입니다.

위의 예제는 `VideoMode` 라는 새 클래스도 정의하며, 비디오 디스플레이를 위한 특정 비디오 모드를 묘사하고 있습니다. 이 클래스는 네 개의 저장 속성 변수를 가집니다. 첫 번째인, `resolution` 은, 새로운 구조체인 `Resolution` 의 인스턴스로 초기화되어, 속성의 타입이 `Resolution` 으로 추론됩니다. 다른 세 개의 속성들로, `interlaced` 설정은 `false` ("비월 주사 방식"[^interlaced]의 의미), '프레임 재생 속도' 는 `0.0`, 그리고 `name` 이라는 옵셔널 `String` 값을 가지고 `VideoMode` 의 새로운 인스턴스가 초기화 됩니다. `name` 속성의 기본 설정 값은 자동으로 `nil`, 또는 "`name` 값이 없음", 이 되는데, 이는 옵셔널 타입이기 때문입니다.

#### Structure and Class Instances (구조체 인스턴스와 클래스 인스턴스)

`Resolution` 구조체의 정의와 `VideoMode` 클래스의 정의는 `Resolution` 이나 `VideoMode` 이 어떤 형태인지만을 설명하는 것입니다. 그 자체로는 지정된 해상도나 비디오 모드에 대해 아무런 설명을 하지 않습니다. 이를 위해서는, 구조체나 클래스의 인스턴스를 만들 필요가 있습니다.

인스턴스를 생성하는 구문 표현은 구조체와 클래스가 서로 매우 비슷합니다:

```swift
let someResolution = Resolution()
let someVideoMode = VideoMode()
```

구조체와 클래스 모두 '초기자 구문 표현 (initializer syntax)' 을 사용해서 새로운 인스턴스를 만듭니다. 초기자 구문 표현의 가장 간단한 양식은 클래스나 구조체의 타입 이름을 쓰고 뒤에 빈 괄호를 붙이는 것으로, 가령 `Resolution()` 이나 `VideoMode()` 와 같은 것들이 이에 해당합니다. 이렇게 하면 클래스나 구조체의 새 인스턴스가 생성되며, 모든 속성들은 기본 설정 값으로 초기화됩니다. 클래스와 구조체의 초기화는 [Initialization (초기화하기)]({% post_url 2016-01-23-Initialization %}) 에서 더 자세히 설명합니다.

#### Accessing Properties (속성에 접근하기)

인스턴스의 속성에 접근할 때는 _점 구문 표현 (dot syntax)_ 을 사용합니다. '점 구문 표현' 은, 인스턴스 이름 바로 뒤에 속성 이름을 쓰면서, 쉼표 (`.`) 로 구분하며, 그 사이에 아무 공백도 넣지 않습니다.

```swift
print ( "The width of someResolution is \(someResolution.width)")
// "The width of someResolution is 0" 를 출력합니다.
```

이 예제에서, `someResolution.width` 는 `someResolution` 의 `width` 속성을 참조하므로, 그것의 기본 기본 설정 값인 `0` 을 반환합니다.

'하위 속성' 으로 계속 파고 들 수도 있어서, 가령 `VideoMode` 의 `resolution` 속성에 있는 `width` 속성도 접근 가능합니다:

```swift
print ( "The width of someVideoMode is \(someVideoMode.resolution.width)")
// "The width of someVideoMode is 0" 를 출력합니다.
```

'점 구문 표현 (dot syntax)' 을 사용하여 '변수 속성 (variable property)' 에 새로운 값을 할당할 수도 있습니다:

```swift
someVideoMode.resolution.width = 1280
print ( "The width of someVideoMode is now \(someVideoMode.resolution.width)")
// "The width of someVideoMode is now 1280" 를 출력합니다.
```

#### Memberwise Initializers for Structure Types (구조체 타입에 대한 멤버 초기자)

모든 구조체는 자동으로 생겨나는 '_멤버 초기자 (memberwise initializer)_'를 가지고 있어서, 이것을 사용하여 새로운 구조체 인스턴스의 멤버 속성을 초기화할 수 있습니다. 새 인스턴스 속성에 대한 기본 설정 값을 멤버 초기자에 전달할 때는 이름을 사용하면 됩니다:

```swift
let vga = Resolution(width: 640, height: 480)
```

구조체와는 다르게, 클래스 인스턴스에는 '기본 멤버 초기자 (default memberwise initializer)' 가 없습니다. 초기자에 대해서는 [Initialization (초기화하기)]({% post_url 2016-01-23-Initialization %}) 에서 더 자세히 설명합니다.

### Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)

_값 타입 (value type)_ 은, 변수나 상수에 할당하거나 함수에 전달할 때, 그 값이 _복사되는 (copied)_ 타입을 말합니다.

실제로 값 타입은 이전 장에서부터 이미 광범위하게 사용중입니다. 사실, 스위프트의 모든 기본 타입-정수, 부동-소수점 수, 불리언 (Booleans), 문자열, 배열 그리고 딕셔너리-들은 값 타입으로, 속을 들여다보면 구조체로 구현되어 있습니다.

스위프트에 있는 모든 구조체와 열거체는 값 타입니다. 이것은 직접 생성하는 구조체나 열거체의 어떤 인스턴스라도-그리고 이들이 속성으로 가지고 있는 어떤 값 타입이라도-코드 내에서 전달될 때는 항상 복사된다는 것을 의미합니다.

> 표준 라이브러리에 정의되어 있는 컬렉션인 배열 (arrays), 딕셔너리 (dictionary), 그리고 문자열 (strings) 들은 최적화를 사용하여 복사하는데 드는 성능 비용을 줄입니다. 이 컬렉션들은, 복사를 바로 하는 대신에, 원본 인스턴스와 복사본 간에 원소가 저정되어 있는 메모리를 공유합니다. 컬렉션의 복사본 중 하나가 수정되면, 이 수정 작업 바로 전에 그 원소를 복사합니다. 코드의 동작은 항상 마치 복사가 즉시 일어난 것처럼 보이게 됩니다.

이제, 앞 예제에 있는 `Resolution` 구조체를 사용하는 예제를 살펴봅시다:

```swift
let hd = Resolution(width : 1920, height : 1080)
var cinema = hd
```

이 예제는 `hd` 라는 상수를 선언하고 여기에 '풀 HD (full HD)' 비디오의 너비와 높이 (1920 픽셀 너비와 1080 픽셀 높이) 를 가지는 `Resolution` 인스턴스를 설정합니다.

그런 다음 `cinema` 라는 변수를 선언하고 여기에 `hd` 의 현재 값을 설정합니다. `Resolution` 은 구조체이므로, 기존 인스턴스의 _복사본 (copy)_ 이 만들어지며, 이 새로운 복사본이  `cinema` 에 할당됩니다. `hd` 와 `cinema` 는 이제 같은 너비와 높이를 가지고 있긴 하지만, 그 속을 들여다보면 두 개의 인스턴스는 완전히 서로 다른 것들입니다.

다음으로, `cinema` 의 `width` 속성을 디지털 영화 송출에 사용되는 것보다 약간 더 넓은 2K 표준 너비 (2048 픽셀 너비와 1080 픽셀 높이) 로 수정합니다.

```swift
cinema.width = 2048
```

`cinema` 의 `width` 속성을 검사하면 진짜 `2048` 로 바뀌었는지 볼 수 있습니다:

```swift
print("cinema is now \(cinema.width) pixels wide")
// "cinema is now 2048 pixels wide" 를 출력합니다.
```

하지만, 원본인 `hd` 인스턴스의 `width` 속성은 여전히 `1920` 이라는 옛 값을 가지고 있습니다:

```swift
print("hd is still \(hd.width) pixels wide")
// "hd is still 1920 pixels wide" 를 출력합니다.
```

`cinema` 에 `hd` 의 현재 값을 주면, `hd` 에 저장된 _값 (values)_ 이 새 `cinema` 인스턴스로 복사됩니다. 최종 결과는 동일한 수치 값을 가지지만 완전히 별개인 두 개의 인스턴스입니다. 하지만, 이들은 별개의 인스턴스이기 때문에, `cinema` 의 너비를 `2048` 로 설정해도, `hd` 에 저장된 너비에는 영향이 없으며, 이는 아래 그림에 나타낸 것과 같습니다:

![an copy of the value type](/assets/Swift/Swift-Programming-Language/Structures-and-Classes-value-type-copy.jpg)

이 같은 동작은 열거체에도 적용됩니다:

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
// "The current direction is north" 를 출력합니다.
// "The remembered direction is west" 를 출력합니다.
```

`rememberedDirection` 에 `currentDirection` 의 값을 할당할 때는, 사실 해당 값의 복사본을 설정하는 것입니다. 이후에 `currentDirection` 값을 바꿔도 `rememberedDirection` 에 저장된 원래 값의 복사본에는 영향이 없습니다.

### Classes Are Reference Types (클래스는 참조 타입입니다)

값 타입과는 달리, _참조 타입 (reference types)_ 은 변수나 상수에 할당되거나 함수에 전달될 때 복사하지 _않습니다 (not)_. 복사하는 대신, 동일한 기존 인스턴스를 가리키는 참조를 사용합니다.

다음 예제는, 위에서 정의한 `VideoMode` 클래스를 사용합니다:

```swift
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
```

이 예제에서는 새로운 상수인 `tenEighty` 를 선언하고 `VideoMode` 클래스의 새 인스턴스를 참조하도록 설정했습니다. 비디오 모드에는 이전에 있던 `1920` 너비 `1080` 폭의 'HD 해상도' 에 대한 복사본이 할당됩니다. '비월 주사 방식 (interlaced)' 인 것으로 설정되었고, 이름은 "`1080i`" 로 설정되며, '프레임 재생 속도 (frame rate)' 는 초당 `25.0` 프레임으로 설정되었습니다.

다음으로, `tenEighty` 를 `alsoTenEighty` 라는, 새로운 상수에 할당하여, `alsoTenEighty` 의 프레임 속도를 수정합니다:

```swift
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
```

클래스는 참조 타입이기 때문에, `tenEighty` 와 `alsoTenEighty` 둘 모두 실제로는 _동일한 (same)_ `VideoMode` 인스턴스에 대한 참조입니다. 사실상, 이들은 동일한 단일 인스턴스에 대한 두 개의 서로 다른 이름인 것이며, 이를 나타내면 아래 그림과 같습니다:

![before and after of an reference type](/assets/Swift/Swift-Programming-Language/Structures-and-Classes-reference-type-before-after.jpg)

`tenEighty` 의 `frameRate` 속성을 검사해보면 실제 `VideoMode` 인스턴스가 갖고 있는 새 '프레임 재생 속도' 인 `30.0` 을 제대로 보고하는 것을 확인할 수 있습니다.

```swift
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
// "The frameRate property of tenEighty is now 30.0" 를 출력합니다.
```

이 예제는 참조 타입이 얼마나 더 이해하기 어려울 수 있는 지도 보여줍니다. `tenEighty` 와 `alsoTenEighty` 가 프로그램 코드에서 서로 멀리 떨어져 있다면, 비디오 모드를 바꾸는 모든 방법을 찾기가 여러울 수도 있습니다. `tenEighty` 를 사용하는 곳마다, `alsoTenEighty` 를 사용하는 코드도 생각하고 있어야 하며, 반대인 경우에도 그렇습니다. 이와는 대조적으로, 값 타입은 이해하기가 더 쉬운데 이는 동일한 값으로 상호 작용하는 모든 코드가 소스 파일 내에서 서로 가까이 있기 때문입니다.

`tenEighty` 와 `alsoTenEighty` 가 변수가 아닌, _상수 (constants)_ 로 선언되었음에도 주목하기 바랍니다. 하지만, `tenEighty.frameRate` 와 `alsoTenEighty.frameRate` 는 여전히 바꿀 수 있는데 이는 `tenEighty` 와 `alsoTenEighty` 상수 자신들의 값은 실제로 바뀐게 없기 때문입니다. `tenEighty` 와 `alsoTenEighty` 스스로는 `VideoMode` 인스턴스를 "저장 (store)" 하지 않습니다-대신에, 이 둘 모두 그 속을 들여다보면 `VideoMode` 인스턴스를 _참조하고 (refer)_ 있습니다. 실제로는 `VideoMode` 의 `frameRate` 속성이 바뀌는 것이지, 이 `VideoMode` 를 참조하고 있는 상수의 값이 바뀌는 것이 아닙니다.

#### Identity Operators (식별 연산자)

클래스는 참조 타입이기 때문에, 여러 개의 상수와 변수가 참조하는 대상이 실제로는 클래스의 동일한 단일 인스턴스일 수가 있습니다. (이같은 일은 구조체나 열거체에는 해당하지 않는데, 왜냐면 상수나 변수에 할당되거나 함수에 전달될 때, 항상 복사되기 때문입니다.)

때때로 두 상수나 변수가 참조하는 대상이 정확하게 클래스의 동일 인스턴스인지를 확인할 수 있다면 유용할 것입니다. 이를 위해, 스위프트는 두 개의 식별 연산자를 제공합니다:

* 동일함 (identical to) (`===`)
* 동일하지 않음 (not identical to) (`!==`)

이 연산자들을 사용하면 두 개의 상수나 변수가 동일한 단일 인스턴스를 참조하고 있는지를 검사할 수 있습니다.

```swift
if tenEighty === alsoTenEighty {
  print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// "tenEighty and alsoTenEighty refer to the same VideoMode instance." 를 출력합니다.
```

_동일함 (identical to)_ (세 개의 등호 기호, 또는 `===` 로 표시함) 이 의미하는 것은 _같음 (equal to)_ (두 개의 등호 기호, 또는 `==` 로 표시함) 과 같지 않습니다. _동일함 (identical to)_ 이 의미하는 것은 클래스 타입의 두 상수나 변수가 정확하게 동일한 클래스 인스턴스를 참조하고 있다는 것입니다. _같음 (equal to)_ 이 의미하는 것은 두 인스턴스의 값이 같거나 동등하다고 여겨진다는 것으로, 이는 _같은 (equal)_ 에 대한 어떤 적절한 의미로써, 타입 설계자에 의해 정의된 것에 해당합니다.

자신만의 구조체와 클래스를 정의할 때는, 두 인스턴스의 같음 조건이 무엇인지에 대한 결정을 자기가 책임져야 합니다. `==` 와 `!=` 연산자에 대한 자신만의 구현을 정의하는 과정은 [Equivalence Operators (같음 비교 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#equivalence-operators-같음-비교-연산자) 에서 설명합니다.

#### Pointers (포인터)

C, C++ 또는 오브젝티브-C 언어에 대한 경험이 있다면, 이러한 언어가 메모리에 있는 주소를 참조할 때 _포인터 (pointers)_ 를 사용한다는 것을 알고 있을 것입니다. 스위프트의 상수나 변수가 어떤 참조 타입에 대한 인스턴스를 참조하는 것은 C 언어의 포인터과 비슷하긴 하지만, 이는 메모리 주소에 대한 직접적인 포인터는 아니며, 참조를 생성한다는 것을 알리기 위해 별표 (`*`) 를 써줘야할 필요도 없습니다. 대신에, 스위프트에서 참조를 정의하는 방식은 다른 상수나 변수와 같이 하면 됩니다. 표준 라이브러리는 '포인터 타입과 버퍼 타입 (pointer and buffer types)' 을 제공하므로 포인터와 직접 상호 작용할 필요가 있을 때는 이를 사용하면 됩니다-[Manual Memory Management (수동 메모리 관리)](https://developer.apple.com/documentation/swift/swift_standard_library/manual_memory_management) 를 보기 바랍니다.

### 참고 자료

[^Structures-and-Classes]: 이 글에 대한 원문은 [Structures and Classes](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html) 에서 확인할 수 있습니다.

[^object-instance]: 여기서 '인스턴스' 가 '객체' 보다 더 일반적인 용어라는 표현을 사용했는데, '객체' 라고 하면 '클래스의 인스턴스' 만을 지칭하지만, 그냥 '인스턴스' 라고 하면 '구조체의 인스턴스' 도 모두 포함하는 개념이기 때문입니다.

[^uppser-camel-case]: 'Camel case' 라면 '낙타 등 모양 문자' 정도의 의미를 갖고 있는데, 변수 이름을 지정할 때 모든 단어를 붙이되. 각 단어의 첫 글자를 대문자로 표기하면, 모양이 마치 낙타 등처럼 생겼다고 해서 'Camel case' 라고 합니다. 'Camel case' 를 우리 말로 '낙타 대문자' 라고 하는 것 같은데, 이 책에서는 'UpperCamelCase' 와 'LowerCamelCase' 라고 구분을 하고 있어서 각각 '대문자로 시작하는 낙타 등 모양' 과 '소문자로 시작하는 낙타 등 모양' 이라고 옮기도록 합니다. 'Camel Case' 에 대한 보다 자세한 내용은 위키피디아의 [Camel case](https://en.wikipedia.org/wiki/Camel_case) 와 [낙타 대문자](https://ko.wikipedia.org/wiki/낙타_대문자) 항목을 참고하기 바랍니다.

[^interlaced]: 'interlaced' 는 예전 모니터의 화면 주사 방식 중에서 '비월 주사 방식' 을 의미하는 것입니다. 보다 자세한 내용은 위키피디아의 [Interlaced video](https://en.wikipedia.org/wiki/Interlaced_video) 와 [비월 주사 방식](https://ko.wikipedia.org/wiki/비월_주사_방식) 항목을 참고하기 바랍니다.
