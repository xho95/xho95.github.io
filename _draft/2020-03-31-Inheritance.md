---
layout: post
comments: true
title:  "Swift 5.2: Inheritance (상속)"
date:   2020-03-31 10:00:00 +0900
categories: Swift Language Grammar Inheritance
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html) 부분[^Inheritance]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Inheritance (상속)

클래스는 다른 클래스로부터 메소드, 속성 그리고 기타 성질들을 _상속 (inherit)_ 받을 수 수 있습니다. 한 클래스가 다른데서 상속받을 때, 상속을 받는 클래스를 _하위 클래스 (subclass)_ 라 하고, 상속을 해주는 클래스를 _상위 클래스 (superclass)_ 라고 합니다. 상속은 Swift에서 클래스를 다른 유형과 차별화하는 기본 동작입니다.

Swift의 클래스는 수퍼 클래스에 속하는 메소드, 특성 및 아래 첨자를 호출하고 액세스 할 수 있으며, 해당 메소드, 특성 및 첨자를 대체하는 고유 버전을 제공하여 동작을 세분화하거나 수정할 수 있습니다. Swift는 대체 정의에 일치하는 수퍼 클래스 정의가 있는지 확인하여 대체가 올바른지 확인하는 데 도움이됩니다.

클래스는 속성 값이 변경 될 때 알림을 받기 위해 상속 된 속성에 속성 관찰자를 추가 할 수도 있습니다. 속성 옵저버는 원래 속성이 저장된 속성인지 계산 된 속성인지에 관계없이 모든 속성에 추가 할 수 있습니다.

### Defining a Base Class (기반 클래스 정의하기)

### Subclassing (하위 클래스 만들기)

### Overriding (재정의하기)

#### Accessing Superclass Methods, Properties, and Subscripts (상위 클래스의 메소드, 속성, 그리고 첨자 연산에 접근하기)

#### Overriding Methods (메소드 재정의하기)

#### Overriding Properties (속성 재정의하기)

**Overriding Property Getters and Setters (속성의 'Getters' 와 'Setters' 재정의하기)**

**Overriding Property Observers (속성의 'Observers' 재정의하기)**

### Preventing Overrides (재정의 금지하기)

### 참고 자료

[^Inheritance]: 이 글에 대한 원문은 [Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html) 에서 확인할 수 있습니다.
