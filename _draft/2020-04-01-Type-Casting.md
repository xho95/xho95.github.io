---
layout: post
comments: true
title:  "Swift 5.2: Type Casting ()"
date:   2020-03-31 10:00:00 +0900
categories: Swift Language Grammar Type Casting
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Type Casting](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html) 부분[^Type-Casting]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Type Casting (타입 변환)

_타입 변환 (Type Casting)_ 은 한 인스턴스의 타입을 검사하는 방법 또는, 그 인스턴스가 속한 '클래스 계층 (class hierarchy)' 의 어딘가에 있는 다른 '상위 클래스' 나 '하위 클래스' 로 취급하는 방법을 말합니다.

스위프트의 '타입 변환' 은 `is` 와 `as` 연산자로 구현됩니다. 이 두 연산자는 간단하면서도 이해하기 쉬운 방법으로 값의 타입을 검사하거나 값을 다른 타입으로 변환할 수 있도록 해 줍니다.

'타입 변환' 을 사용하면 그 타입이 프로토콜을 준수하고 있는지도 검사할 수 있으며, 이는 [Checking for Protocol Conformance (프로토콜을 준수하는지 검사하기)](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID283) 에서 설명하도록 합니다.

### Defining a Class Hierarchy for Type Casting

### Checking Type

### Downcasting

### Type Casting for Any and AnyObject

### 참고 자료

[^Type-Casting]: 이 글에 대한 원문은 [Type Casting](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html) 에서 확인할 수 있습니다.
