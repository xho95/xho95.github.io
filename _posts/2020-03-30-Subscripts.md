---
layout: post
comments: true
title:  "Swift 5.2: Subscripts (첨자 연산)"
date:   2020-03-15 10:00:00 +0900
categories: Swift Language Grammar Subscripts
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Subscripts](https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html) 부분[^Subscripts]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Subscripts (첨자 연산)

'클래스 (classes)', '구조체 (structures)', 그리고 '열거체 (enumerations)' 는 '_첨자 연산 (subscripts)_' 을 정의하여, '컬렉션 (collection)', '리스트 (list)', 또는 '시퀀스 (sequence)' 의 멤버 원소에 더 쉽게 접근할 수 있는 방법을 제공합니다. '첨자 연산' 을 사용하면 색인으로 값을 설정하고 가져올 수 있어서 별도의 메소드를 따로 만들 필요도 없습니다. 예를 들어, `Array` 인스턴스의 원소는 `someArray[index]` 로 접근할 수 있으며, `Dictionary` 인스턴스의 원소는 `someDictionary[key]` 로 접근할 수 있습니다.

하나의 단일한 타입에 대해 여러 개의 '첨자 연산' 을 정의할 수도 있으며, 이 때 첨자 연산에 전달한 색인 값의 타입에 따라 첨자 연산을 적절하게 선택하고 사용합니다. 첨자 연산은 1차원으로만 제한된 것이 아니라서, 사용자 정의 타입의 요구에 맞게 여러 개의 입력 매개 변수를 갖는 첨자 연산도 정의할 수 있습니다.

### Subscript Syntax (첨자 연산 구문 표현)

첨자 연산을 사용해서 타입의 인스턴스를 조회하려면 인스턴스 이름 뒤위 대괄호 안에 하나 이상의 값을 써주면 됩니다. 이러한 구문 표현은 '인스턴스 메소드 구문 표현' 및 '계산 속성 구문 표현' 과 비슷합니다. 첨자 연산을 정의하려면 `subscript` 키워드를 쓴 다음, 하나 이상의 매개 변수와 하나의 반환 타입을 지정하면 되며, 이는 인스턴스 메소드와 방법이 같습니다. 다만 인스턴스 메소드와는 달리, 첨자 연산은 '읽기-쓰기 혼용' 일 수도 있고 '읽기-전용' 일 수도 있습니다. 이 행동은 'getter (게터)' 와 'setter (세터)' 를 사용하여 상호 작용하는데 이것도 '계산 속성' 과 같은 방법입니다.

```swift
subscript(index: Int) -> Int {  
  get {
    // 여기서 알맞은 첨자 연산 값을 반환합니다.
  }
  set(newValue) {
    // 여기서 적당한 설정 행동을 수행합니다.  
  }
}
```

`newValue` 의 타입은 첨자 연산의 반환 값과 같습니다. '계산 속성 (computed properties)' 에서 처럼, 'setter (세터)' 의 `(newValue)` 매개 변수를 지정 안해도 상관 없습니다. 직접 제공하지 않으면 'setter (세터)' 는 `newValue` 라는 기본 매개 변수를 제공합니다.

'읽기-전용 계산 속성' 에서 처럼, `get` 키워드와 괄호를 제거하여 '읽기-전용 첨자 연산' 의 선언을 더 줄일 수도 있습니다.

```swift
subscript(index: Int) -> Int {
  // 여기서 알맞은 첨자 연산 값을 반환합니다. 
}
```

### Subscript Usage (첨자 연산 사용법)

### Subscript Options (첨자 연산의 선택 사항들)

### Type Subscript (타입 첨자 연산)

### 참고 자료

[^Subscripts]: 이 글에 대한 원문은 [Subscripts](https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html) 에서 확인할 수 있습니다.
