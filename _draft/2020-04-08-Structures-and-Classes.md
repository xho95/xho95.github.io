---
layout: post
comments: true
title:  "Swift 5.2: Structures and Classes (구조체와 클래스)"
date:   2020-04-08 10:00:00 +0900
categories: Swift Language Grammar Structure Class
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Structures and Classes](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html) 부분[^Structures-and-Classes]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Structures and Classes (구조체와 클래스)

_구조체 (structures)_ 와 _클래스 (classes)_ 는 프로그램 코드에서 건축 자재 역할을 하는 범용적이고, 유연한 구조물을 말합니다. 구조체와 클래스에 기능을 추가하기 위해 속성과 메소드를 정의할 때는 상수, 변수, 그리고 함수를 정의할 때와 똑같은 구문 표현을 사용하면 됩니다.

다른 프로그래밍 언어들과는 다르게, 스위프트에서는 구조체와 클래스에 대해서 인터페이스 파일과 구현 파일을 별도로 분리해서 만들 필요가 없습니다. 스위프트에서는, 구조체나 클래스는 단일한 파일내에서 정의하면 되고, 그 클래스나 구조체에 대한 외부 인터페이스는 다른 코드에서 자동으로 사용할 수 있도록 만들어 줍니다.

> 클래스의 인스턴스는 전통적으로 _객체 (object)_ 라고 알려져 있습니다. 하지만, 스위프트의 구조체와 클래스는 그 기능 면에서 다른 언어에서 보다 훨씬 더 가까우며, 이번 장에서 설명하는 기능 대부분은 클래스이든 구조체이든 _어느 쪽의 (either)_ 인스턴스에도 적용할 수 있습니다. 이러한 이유로 때문에, 더 일반적인 용어인 _인스턴스 (instance)_ 를 사용합니다.[^object-instance]

### Comparing Structures and Classes (구조체와 클래스 비교하기)

스위프트에서 구조체와 클래스는 공통 점이 아주 많습니다. 이들은 다음과 같습니다:

* 값을 저장하기 위한 속성 정의하기
* 기능을 제공하기 위한 메소드 정의하기
* 첨자 연산 구문으로 값에 접근할 수 있도록 첨자 연산 정의하기
* 초기 상태를 설정하기 위한 초기자 정의하기
* 기능을 기본 구현 이상으로 확대하도록 확장하기
* 정해진 종류의 표준 기능을 제공하도록 프로토콜 준수하기

더 자세한 내용은, [Properties (속성)], [Methods (메소드)], [Subscripts (첨자 연산)](http://xho95.github.io/swift/language/grammar/subscripts/2020/03/15/Subscripts.html), [Initialization (초기화하기)](http://xho95.github.io/xcode/swift/grammar/initialization/2016/01/23/Initialization.html), [Extensions (확장)](http://xho95.github.io/xcode/swift/grammar/extensions/2016/01/19/Extensions.html), 그리고 [Protocols (프로토콜; 규약)](http://xho95.github.io/swift/language/grammar/protocol/2016/03/03/Protocols.html) 을 참조하기 바랍니다.

클래스는 구조체에는 없는 다음의 추가 기능들을 가지고 있습니다:

* '상속 (inheritance)' 은 한 클래스가 다른 클래스의 성질을 상속 할 수 있게 합니다.
* '타입 변환 (type casting)' 은 클래스 인스턴스의 타입을 '실행 시간 (runtime)' 에 검사하고 해석할 수 있게 합니다.
* '정리자 (deinitializer)' 는 클래스 인스턴스가 할당한 어떤 자원이든 다시 확보할 수 있게 합니다.
* '참조 카운팅 (reference counting)' 은 클래스 인스턴스에 대해 참조를 한 개 이상 할 수 있게 합니다.

더 자세한 내용은, [Inheritance (상속)](http://xho95.github.io/swift/language/grammar/inheritance/2020/03/31/Inheritance.html), [Type Casting (타입 변환)](http://xho95.github.io/swift/language/grammar/type/casting/2020/03/31/Type-Casting.html), [Deinitialization (객체 정리하기)](http://xho95.github.io/swift/language/grammar/deinitialization/2017/03/02/Deinitialization.html), 그리고 [Automatic Reference Counting (자동 참조 카운팅)] 을 참고하기 바랍니다.

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

> 새로운 구조체나 클래스를 정의할 때마다, 새로운 스위프트 타입을 정의하고 있는 것입니다. 타입은 (여기서 `SomeStructure` 와 `SomeClass` 라고 한 것처럼) `UpperCamelCase`-대문자 낙타 활자[^uppser-camel-case] 방식의-이름을 부여해서 표준 스위프트 타입의 대문자 방식 (`String`, `Int`, 그리고 `Bool` 과 같은 것들) 에 맞추도록 합니다. 속성과 메소드는 `lowerCamelCase`-소문자 낙타 활자 방식의-이름 (가령 `frameRate` 와 `incrementCount` 같은 것들) 을 부여해서 타입 이름과 구별되도록 합니다.

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

위의 예제는 `Resolution` 이라는 새 구조체를 정의해서, 픽셀 기반 디스플레이의 해상도를 묘사합니다. 이 구조체는 `width` 와 `height` 라는 두 개의 '저장 속성 (stored properties)' 을 가집니다. 저장 속성은 구조체나 클래스의 일부로 포함되어 저장되는 상수나 변수를 말합니다. 이 두 속성은 타입이 `Int` 로 추론되는데 이는 초기 값이 정수인 `0` 으로 설정되었기 때문입니다.

위의 예제는 `VideoMode` 라는 새 클래스도 정의하며, 비디오 디스플레이를 위한 지정된 비디오 모드를 묘사하고 있습니다. 이 클래스는 네 개의 저장 속성 변수를 가집니다. 첫 번째인, `resolution` 은, 새로운 구조체인 `Resolution` 의 인스턴스로 초기화되어, 속성의 타입이 `Resolution` 으로 추론됩니다. 다른 세 개의 속성들로, `interlaced` 설정은 `false` ("비월 주사 방식"[^interlaced]의 의미), '프레임 재생 속도' 는 `0.0`, 그리고 `name` 이라는 옵셔널 `String` 값을 가지고 `VideoMode` 의 새로운 인스턴스가 초기화 됩니다. `name` 속성의 기본 값은 자동으로 `nil`, 또는 "`name` 값이 없음", 이 되는데, 이는 옵셔널 타입이기 때문입니다.

#### Structure and Class Instances (구조체 인스턴스와 클래스 인스턴스)

#### Accessing Properties (속성 접근하기)

#### Memberwise Initializers for Structure Types (구조체 타입의 멤버 초기자)

### Structures and Enumerations Are Value Types (구조체와 열거체는 값 타입입니다)

### Classes Are Reference Types (클래스는 참조 타입입니다)

#### Identity Operators (식별 연산자)

#### Pointers (포인터)

### 참고 자료

[^Structures-and-Classes]: 이 글에 대한 원문은 [Structures and Classes](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html) 에서 확인할 수 있습니다.

[^object-instance]: 여기서 '인스턴스' 가 '객체' 보다 더 일반적인 용어라는 표현을 사용했는데, '객체' 라고 하면 '클래스의 인스턴스' 만을 지칭하지만, 그냥 '인스턴스' 라고 하면 '구조체의 인스턴스' 도 모두 포함하는 개념이기 때문입니다.

[^uppser-camel-case]: 'Camel case' 라면 '낙타 활자' 정도의 의미를 갖고 있는데, 프로그래밍에서 변수 이름을 정할 때 모든 단어를 붙여서 표기하되. 각 단어의 첫 글자를 대문자로 표기하는 방법을 말합니다. 이렇게 하면 모양이 마치 낙타 등처럼 생겼다고 해서 'Camel case' 라고 합니다. 'Camel case' 를 우리 말로 '낙타 대문자' 라고 하는 것 같은데, 이 책에서는 'UpperCamelCase' 와 'LowerCamelCase' 라고 구분을 하고 있어서 각각 '대문자 낙타 활자' 와 '소문자 낙타 활자' 라고 옮기도록 합니다. 'Camel Case' 에 대한 보다 자세한 내용은 위키피디아의 [Camel case](https://en.wikipedia.org/wiki/Camel_case) 와 [낙타 대문자](https://ko.wikipedia.org/wiki/낙타_대문자) 항목을 참고하기 바랍니다.

[^interlaced]: 'interlaced' 는 예전 모니터의 화면 주사 방식 중에서 '비월 주사 방식' 을 의미하는 것입니다. 보다 자세한 내용은 위키피디아의 [Interlaced video](https://en.wikipedia.org/wiki/Interlaced_video) 와 [비월 주사 방식](https://ko.wikipedia.org/wiki/비월_주사_방식) 항목을 참고하기 바랍니다.
