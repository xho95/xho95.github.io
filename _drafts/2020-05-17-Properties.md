---
layout: post
comments: true
title:  "Swift 5.2: Properties (속성)"
date:   2020-05-16 10:00:00 +0900
categories: Swift Language Grammar Property
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html) 부분[^Properties]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Properties (속성)

_속성 (properties)_ 은 값을 특정한 클래스, 구조체, 또는 열거체와 관련짓습니다. '저장 속성 (stored properties)' 은 상수와 변수 값을 인스턴스의 일부로 저장하며, 반면 '계산 속성 (computed properties)' 은 값을 (저장하는 대신) 계산합니다. '계산 속성' 은 클래스, 구조체, 그리고 열거체에서 제공합니다. '저장 속성' 은 클래스와 구조에서만 제공합니다.

저장 및 계산 속성은 보통 특정한 타입의 인스턴스와 관련되어 있습니다. 하지만, 속성은 타입 그 자체와 관련될 수도 있습니다. 이러한 속성을 타입 속성이라고 합니다.

이에 더하여, '속성 관찰자 (property observers)' 를 정의하면 속성 값이 바뀌는 것을 감시해서, 그 응답으로 자기가 정의한 행동을 하게 할 수도 있습니다. '속성 관찰자' 는 자기 스스로 정의한 '저장 속성' 에 추가할 수 있으며, 상위 클래스에서 상속 받은 하위 클래스 속성에도 추가할 수 있습니다.

'속성 포장 (property wrapper)' 을 사용하여 여러 속성들의 '획득자 (getter)' 와 '설정자 (setter)' 에 있는 코드를 재사용할 수도 있습니다.

### Stored Properties (저장 속성)

가장 간단한 양식의, 저장 속성 중은 특정한 클래스나 구조체 인스턴스의 일부로 저장되는 상수 또는 변수입니다. 저장 속성은 (`var` 키워드로 도입하는) _변수 저장 속성 (variable stored properties)_ 일 수도 있고 (`let` 키워드로 도입하는) _상수 저장 속성 (constant stored properties)_ 일 수도 있습니다.   

저장 속성은 정의하면서 '기본 설정 값 (default value)' 을 제공할 수 있으며, 이는 [Default Property Values (기본 설정 속성 값)]({% post_url 2016-01-23-Initialization %}#default-property-values-기본-설정-속성-값) 에서 설명합니다. 초기화하는 과정에서 저장 속성의 초기 값을 설정하고 수정할 수도 있습니다. 이는 '상수 저장 속성' 에서도 마찬가지인데, [Assigning Constant Properties During Initialization (초기화하는 동안 상수 속성 할당하기)]({% post_url 2016-01-23-Initialization %}#assigning-constant-properties-during-initialization-초기화하는-동안-상수-속성-할당하기) 에서 설명하도록 합니다.

아래 예제는 `FixedLengthRange` 라는 구조체를 정의하는데, 이는 생성되고 나면 범위의 크기를 바꿀 수 없는 정수 범위를 나타냅니다:

```swift
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// 범위는 정수 값 0, 1, 그리고 2 를 나타냅니다.
rangeOfThreeItems.firstValue = 6
// 범위는 이제 정수 값 6, 7, 그리고 8 를 나타냅니다.
```

`FixedLengthRange` 인스턴스는 `firstValue` 라는 '변수 저장 속성' 과 `length` 라는 '상수 저장 속성' 을 가지고 있습니다. 위의 예제에서, `length` 는 새로운 범위를 생성할 때 초기화되어 그 이후로는 바꿀 수 없는데, 이는 '상수 속성' 이기 때문입니다.

#### Stored Properties of Constant Structure Instances (상수 구조체 인스턴스의 저장 속성)

#### Lazy Stored Properties (늦은 저장 속성)

#### Stored Properties and Instance Variables (저장 속성과 인스턴스 변수)

### Computed Properties (계산 속성)

#### Shorthand Setter Declaration (설정자 선언의 약칭 표현)

#### Shorthand Getter Declaration (획득자 선언의 약칭 표현)

#### Read-Only Computed Properties (읽기-전용 계산 속성)

### Property Observers (속성 관찰자)

### Property Wrappers (속성 포장)

#### Setting Initial Values for Wrapped Properties (포장된 속성에 대한 초기 값 설정하기)

#### Projecting a Value From a Property Wrapper (속성 포장에서 값 투영하기)

### Global and Local Variables (전역 변수 및 지역 변수)

### Type Properties (타입 속성)

#### Type Property Syntax (타입 속성 구문 표현)

#### Querying and Setting Type Properties (타입 속성 조회하고 설정하기)

### 참고 자료

[^Properties]: 이 글에 대한 원문은 [Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html) 에서 확인할 수 있습니다.
