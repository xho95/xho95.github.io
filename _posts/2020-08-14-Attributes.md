---
layout: post
comments: true
title:  "Swift 5.3: Attributes (특성)"
date:   2020-08-14 11:30:00 +0900
categories: Swift Language Grammar Attribute
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Attributes](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html) 부분[^Attributes]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## Attributes (특성)

스위프트에는 두 가지 종류의 '특성 (attributes)' 이 있습니다: 선언에 적용되는 것과 타입에 적용되는 것이 그것입니다. 특성은 선언 또는 타입에 대한 추가적인 정보를 제공합니다. 예를 들어, 함수 선언에 대한 `discardableResult` 특성은, 함수가 값을 반환하더라도, 컴파일러가 반환 값을 사용하지 않는다는 이유로 경고를 생성하지는 않아야 한다는 것을 나타냅니다.

특성을 지정하려면 `@` 기호 뒤에 특성의 이름과 그 특성이 받는 어떤 인자를 작성합니다:

@`attribute name`
<br />
@`attribute name`(`attribute argument`)

몇몇 '선언 특성 (declaration attributes)' 은 특성에 대한 추가 정보를 지정하는 인자와 특정 선언에 적용하는 방법을 지정하는 인자를 받습니다. 이 _특성 인자 (attribute arguments)_ 들은 괄호로 닫혀 있으며, 양식은 그들이 속한 특성에서 정의합니다.

### Declaration Attributes (선언 특성)

'선언 특성' 은 선언에만 적용할 수 있습니다.

#### available

#### discardableResult

#### dynamicCallable

#### dynamicMemberLookup

#### frozen

#### GKInspectable

#### inlinable

#### main

이 특성을 구조체, 클래스, 또는 열거체 선언에 적용하는 건 그것이 프로그램 흐름에서 '최상위-수준의 진입점 (top-level entry point)' 을 가진다는 것을 나타냅니다. 그 타입은, 어떤 인자도 받지 않고 `Void` 를 반환하는, 타입 함수인 `main` 을 반드시 제공해야 합니다:

```swift
@main
struct MyTopLevel {
    static func main() {
        // 여기에 최상위-수준 코드를 둡니다.
    }
}
```

`main` 특성의 '필수 조건' 을 설명하는 또 다른 방법은 이 특성을 붙이려는 타입은 아래에 있는 가상의 프로토콜을 준수하는 타입이 하는 것과 같은 필수 조건을 반드시 만족해야 한다는 것입니다:

```swift
protocol ProvidesMain {
    static func main() throws
}
```

실행 파일을 만들기 위해 컴파일하는 스위프트 코드는, [Top-Level Code (최상위-수준 코드)]({% post_url 2020-08-15-Declarations %}#top-level-code-최상위-수준-코드) 에서 설명한 것처럼, 최대 한 개의 최상위-수준 진입점을 가질 수 있습니다.

#### nonobjc

#### NSApplicationMain

#### NSCopying

#### NSManaged

#### objc

#### objcMembers

#### propertyWrapper

#### requires_stored_property_inits

#### testable

#### UIApplicationMain

#### usableFromInline

#### warn_unqualifed_access

#### Declaration Attributes Used by Interface Builder

### Type Attributes

#### autoclosure

#### convention

#### escaping

### Switch Case Attributes

#### unknown

### 참고 자료

[^Attributes]: 원문은 [Attributes](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html) 에서 확인할 수 있습니다.
