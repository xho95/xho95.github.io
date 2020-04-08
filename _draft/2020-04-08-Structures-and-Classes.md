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

클래스가 지원하는 추가 기능을 쓴다는 것은 복잡성 증가라는 비용을 지불하겠다는 의미입니다. 일반적인 지침을 따른다면, 되도록이면 이유를 파악하기 더 쉬운 구조체를 사용하고, 클래스는 더 적합하거나 꼭 필요한 경우에만 사용하도록 합니다. 실제로, 이것은 사용자가 정의하는 자료 타입의 대부분은 구조체나 열거체일 것이라는 의미입니다. 이에 대한 좀 더 자세히 비교는, [Choosing Between Structures and Classes (구조체와 클래스 사이에서 선택하기)](https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes) 를 첨고하기 바랍니다.

#### Definition Syntax (정의 구문 표현)

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
