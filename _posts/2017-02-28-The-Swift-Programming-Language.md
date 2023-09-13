---
layout: post
comments: true
title:  "Swift Programming Language (스위프트 프로그래밍 언어)"
date:   2017-02-28 00:00:00 +0900
categories: Swift Programming Language Grammar
redirect_from: "/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html"
---
{: .comment}
> **Apple** 의 **The Swift Programming Language**[^Swift-Programming-Language] 책을 번역하고, 주석을 달아 정리했습니다.
>
> 궁금한 점이 있으면 **댓글** 이나 <a href="mailto:{{ site.email }}">**메일**</a> 로 알려 주시기 바랍니다.

# 스위프트 프로그래밍 언어

![5.7](https://img.shields.io/badge/Translation%20Complete-5.7-green) ![5.7](https://img.shields.io/badge/Translation%20Ongoing-5.7-yellow)

### Welcome to Swift (스위프트 소개)

* [About Swift (스위프트에 대하여)]({% link docs/swift-books/swift-programming-language/about-swift.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Version Compatibility (버전 호환성)]({% link docs/swift-books/swift-programming-language/version-compatibility.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [A Swift Tour (스위프트 둘러보기)]({% link docs/swift-books/swift-programming-language/a-swift-tour.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)

### Language Guide (언어 설명서)

* [The Basics (기초)]({% link docs/swift-books/swift-programming-language/the-basics.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Basic Operators (기초 연산자)]({% link docs/swift-books/swift-programming-language/basic-operators.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Strings and Characters (문자열과 문자)]({% link docs/swift-books/swift-programming-language/strings-and-characters.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Collection Types (집합체 타입)]({% link docs/swift-books/swift-programming-language/collection-types.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Control Flow (제어 흐름)]({% link docs/swift-books/swift-programming-language/control-flow.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Functions (함수)]({% link docs/swift-books/swift-programming-language/functions.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Closures (클로저; 잠금 블럭)]({% link docs/swift-books/swift-programming-language/closures.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Enumerations (열거체)]({% link docs/swift-books/swift-programming-language/enumerations.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Structures and Classes (구조체와 클래스)]({% link docs/swift-books/swift-programming-language/structures-and-classes.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Properties (속성)]({% link docs/swift-books/swift-programming-language/properties.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Methods (메소드)]({% link docs/swift-books/swift-programming-language/methods.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Subscripts (첨자)]({% link docs/swift-books/swift-programming-language/subscripts.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Inheritance (상속; 물려받기)]({% link docs/swift-books/swift-programming-language/inheritance.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Initialization (초기화)]({% link docs/swift-books/swift-programming-language/initialization.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Deinitialization (뒷정리)]({% link docs/swift-books/swift-programming-language/deinitialization.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Optional Chaining (옵셔널 사슬)]({% link docs/swift-books/swift-programming-language/optional-chaining.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Error Handling (에러 처리)]({% link docs/swift-books/swift-programming-language/error-handling.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Concurrency (동시성)]({% link docs/swift-books/swift-programming-language/concurrency.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Type Casting (타입 변환)]({% link docs/swift-books/swift-programming-language/type-casting.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Nested Types (중첩 타입)]({% link docs/swift-books/swift-programming-language/nested-types.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Extensions (익스텐션; 확장)]({% link docs/swift-books/swift-programming-language/extensions.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Protocols (프로토콜; 규약)]({% link docs/swift-books/swift-programming-language/protocols.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Generics (일반화)]({% link docs/swift-books/swift-programming-language/generics.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Opaque Types and Boxed Types (불투명 타입과 상자친 타입)]({% link docs/swift-books/swift-programming-language/opaque-types.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Automatic Reference Counting (자동 참조 카운팅)]({% link docs/swift-books/swift-programming-language/automatic-reference-counting.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Memory Safety (메모리 안전성)]({% link docs/swift-books/swift-programming-language/memory-safety.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Access Control (접근 제어)]({% link docs/swift-books/swift-programming-language/access-control.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Advanced Operators (고급 연산자)]({% link docs/swift-books/swift-programming-language/advanced-operators.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)

### Language Reference (언어의 기준)

* [About the Language Reference (언어의 기준에 대하여)]({% link docs/swift-books/swift-programming-language/about-the-language-reference.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Lexical Structure (어휘 구조)]({% link docs/swift-books/swift-programming-language/lexical-structure.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Types (타입)]({% link docs/swift-books/swift-programming-language/types.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Expressions (표현식)]({% link docs/swift-books/swift-programming-language/expressions.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Statements (구문)]({% link docs/swift-books/swift-programming-language/statements.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Declarations (선언)]({% link docs/swift-books/swift-programming-language/declarations.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Attributes (특성)]({% link docs/swift-books/swift-programming-language/attributes.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Patterns (패턴; 유형)]({% link docs/swift-books/swift-programming-language/patterns.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Generic Parameters and Arguments (일반화 매개 변수와 인자)]({% link docs/swift-books/swift-programming-language/generic-parameters-and-arguments.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)
* [Summary of the Grammar (문법 총정리)](https://docs.swift.org/swift-book/ReferenceManual/zzSummaryOfTheGrammar.html#) - 번역 없이 원문으로 이동함

### Revision History (개정 이력)

* [Document Revision History (문서를 다듬은 역사)]({% link docs/swift-books/swift-programming-language/document-revision-history.md %}) ![5.7](https://img.shields.io/badge/-5.7-green)

### 참고 자료

[^Swift-Programming-Language]: 책 전체의 원문은 [Swift Programming Language](https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html) 에서 볼 수 있습니다.