---
layout: post
comments: true
title:  "Swift 5.2: Enumerations (열거체)"
date:   2020-05-16 10:00:00 +0900
categories: Swift Language Grammar Error Handling
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Error Handling](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 부분[^Enumerations]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Enumerations (열거체)

_열거체 (enumerations)_ 는 서로 관계가 있는 값들에 대한 공통 타입을 정의하여 코드에서 이들을 '타입-안전 (type-safe)' 하게[^type-safe] 사용하도록 해줍니다.

C 언어에 익숙하다면, C 언어의 열거체가 관계가 있는 이름을 할당하는 것은 정수 값 집합이라는 것을 알 것입니다. 스위프트의 열거체는 이보다 더 유연하여, 열거체의 각 '경우 값 (cases)' 에 대해 어떤 값을 제공하지 않아도 됩니다. 각각의 열거체 경우 값에 대해 (_원시 값 (raw value)_ 이라는) 어떤 값이 제공되는 경우, 이 값은 문자열, 문자, 또는 정수나 부동-소수점 타입의 값일 수 있습니다.

다른 방법으로, 열거체의 '경우 값 (cases)' 은 서로 다른 각 경우 값에 따라 저장되는 '관련 값 (associated values)' 을 _어떤 (any)_ 타입이든 지정할 수 있으며, 이는 다른 언어의 '유니온 (unions)' 또는 '변형체 (variants)' 와 거의 같습니다. 관계가 있는 공통된 '경우 값들 (cases)' 의 집합을 하나의 열거체로 정의하면서, 제각각은 그것과 관련된 적절한 타입의 서로 다른 값들의 집합을 가질 수 있습니다.

스위프트의 열거체는 그 자체로 '일급 타입 (first-class types)'[^first-class] 입니다. 이 (스위프트의 열거체) 는 전통적으로 클래스에서만 지원하던 많은 특징들을 채택했는데, 가령 열거체의 현재 값에 대한 추가적인 정보를 제공하는 '계산 속성 (computed properties)', 열거체가 표현할 값과 관계있는 기능을 제공하는 '인스턴스 메소드 (instance methods)' 등입니다. 열거체는 '초기 경우 값 (initial case value)' 을 제공하기 위한 '초기자' 도 정의할 수 있습니다; 자신의 기능을 원래 구현 이상으로 확장하기 위해 확장될 수 있습니다; 표준 기능을 제공하기 위해 프로토콜을 준수할 수 있습니다.

이 '기능들 (capabilities)' 에 대한 더 자세한 내용은, [Properties (속성)](), [Methods (메소드)]({% post_url 2020-05-03-Methods %}), [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}), [Extensions (확장)]({% post_url 2016-01-19-Extensions %}), 그리고 [Protocols (규약)]({% post_url 2016-03-03-Protocols %}) 을 참고하기 바랍니다.

### Enumeration Syntax (열거체 구문 표현)

### Matching Enumeration Values with a Switch Statement ('switch' 문으로 해당하는 열거체 값 찾기)

### Iterating over Enumeration Cases (열거체 경우 값에 대해 동작 반복 적용하기)

### Associated Values (관련 값; 결합 값)

### Raw Values (원시 값)

#### Implicitly Assigned Raw Values (암시적으로 할당되는 원시 값)

#### Initializing from a Raw Value (원시 값으로 초기화하기)

### Recursive Enumerations (재귀적인 열거체)

### 참고 자료

[^Enumerations]: 이 글에 대한 원문은 [Enumerations](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 에서 확인할 수 있습니다.

[^type-safe]: 스위프트는 '타입 추론 장치 (type inference)' 와 '타입 검사 기능 (type check)' 을 기본적으로 제공합니다. 본문의 내용은 자신만의 열거체 타입을 만들면 이렇게 스위프트가 제공하는 기능을 사용할 수 있음을 의미합니다.

[^first-class]: 프로그래밍에서 '일급 (first-class)' 이라는 말은 특정 대상을 '객체' 와 동급으로 사용할 수 있다는 것을 의미합니다. 예를 들어 '객체' 처럼 인자로 전달할 수도 있고, 함수에서 반환할 수 있으며, 다른 변수 등에 할당할 수도 있는 대상이 있다면 이 대상을 '일급 (first-class)' 이라고 합니다. 이에 대한 보다 자세한 내용은 위키피디아의 [First-class citizen](https://en.wikipedia.org/wiki/First-class_citizen) 과 [일급 객체](https://ko.wikipedia.org/wiki/일급_객체) 항목을 참고하기 바랍니다.
