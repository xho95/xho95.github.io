---
layout: post
comments: true
title:  "Swift 5.3: Expressions (표현식)"
date:   2020-08-19 11:30:00 +0900
categories: Swift Language Grammar Expression
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Expressions](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html) 부분[^Expressions]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## Expressions (표현식)

스위프트에는 네 가지 종류의 표현식이 있습니다: '접두사 표현식 (prefix expressions)', '이항 표현식 (binary expressions)', '제1 표현식 (primary expressions)', 및 '접미사 표현식 (postfix expressions)' 이 그것입니다. 표현식을 평가하는 것은 값을 반환하거나, '부작용 (side effect)'[^side-effect] 을 일으키거나, 아니면 둘 다에 해당합니다.

접두사 표현식 및 이항 표현식은 더 작은 표현식에 연산자를 적용할 수 있도록 해줍니다. '제1 표현식' 은 개념적으로 가장 간단한 종류의 표현식이며, 값에 접근하는 방법을 제공합니다. 접미사 표현식은, 접두사 표현식 및 이항 표현식 처럼, 함수 호출 및 멤버 접근 등의 접미사를 사용하여 더 복잡한 표현식을 제작하도록 해줍니다. 표현식은 각 종류별로 아래 장에서 더 자세히 설명합니다.

> GRAMMAR OF AN EXPRESSION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html)

### Prefix Expressions (접두사 표현식)

#### Try Operator ('try' 연산자)

### Binary Expressions (이항 표현식)

#### Assignment Operator

#### Ternary Conditional Operator

#### Type-Casting Operators

### Primary Expressions

#### Literal Expression (글자 값 표현식)

_글자 값 표현식 (literal expression)_ 은 일상적인 글자 값 (가령 문자열이나 숫자 등), 배열 또는 딕셔너리 글자 값, '플레이그라운드 글자 값 (playground literal)', 아니면 다음의 특수 글자 값 중 하나로써 구성됩니다:

글자 값 | 타입 | 값
---|---|---
`#file` | `String` |  이 값이 있는 파일 및 모듈의 이름
`#filePath` | `String` | 이 값이 있는 파일의 경로
`#line` | `Int` | 이 값이 있는 줄의 번호
`#column` | `Int` | 이 값이 시작하는 열의 번호
`#function` | `String` | 이 값이 있는 선언의 이름
`#dsohandle` | `UnsafeRawPointer` | 이 값이 있는 곳에서 사용중인 '동적 공유 객체 (dynamic shared object; DSO) 핸들 (handle)'

`#file` 표현식의 문자열 값은 _module/file_ 형식을 가지며, 여기서 _file_ 은 표현식이 있는 파일의 이름이고 _module_ 은 이 파일이 있는 모듈의 이름입니다. `#filePath` 표현식의 문자열 값은 표현식이 있는 파일에 대한 '온전한 파일-시스템 경로 (full file-system path)' 입니다. 이 두 값 모두, [Line Control Statement (줄 제어문)]() 에서 설명한 것처럼, `#sourceLocation` 로 바꿀 수 있습니다.

#### Self Expression

#### Superclass Expression

#### Closure Expression

**Capture Lists**

#### Implicit Member Expression

#### Parenthesized Expression

#### Tuple Expression

#### Wildcard Expression

#### Key-Path Expression

#### Selector Expression

#### Key-Path String Expression

### Postfix Expressions

#### Function Call Expression

#### Initializer Expression

#### Explicit Member Expression

#### Postfix Self Expression

#### Subscript Expression

#### Forced-Value Expression

#### Optional-Chaining Expression

### 참고 자료

[^Expressions]: 원문은 [Expressions](https://docs.swift.org/swift-book/ReferenceManual/Expressions.html) 에서 확인할 수 있습니다.

[^side-effect]: 컴퓨터 용어에서 'side effect' 를 '부작용' 이라고 직역하는 것이 옳은 것인지는 잘 모르겠습니다. 위키피디아에서는 'side effect' 를 다음과 같이 설명하고 있습니다. 컴퓨터 과학에서, 연산, 함수, 또는 표현식이 'side effect' 를 가지고 있다는 것은 이들이 지역 범위 외부에 있는 상태 변수의 값을 수정하는 경우를 말하는 것으로, 즉 해당 연산의 호출 쪽에서 함수 반환이라는 '주요 효과 (main effect)' 외에 별도로 '관찰 가능한 효과' 를 가지는 것을 말합니다. 이러한 정의에 따르면, 'side effect' 를 '부작용' 이라기 보다는 '부수적인 효과' 정도로 이해해도 좋을 것입니다. 다만, 'side effect' 가 '부작용' 이라고 널리 쓰이고 있으므로, 컴퓨터 용어에서의 '부작용' 이란 의미를 앞서와 같이 이해할 수도 있을 것입니다. 보다 자세한 내용은 위키피디아의 [Side effect (computer science)](https://en.wikipedia.org/wiki/Side_effect_(computer_science)) 및 [부작용 (컴퓨터 과학)](https://ko.wikipedia.org/wiki/부작용_(컴퓨터_과학)) 항목을 참고하기 바랍니다.
