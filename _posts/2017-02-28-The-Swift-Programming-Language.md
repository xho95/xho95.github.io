---
layout: post
comments: true
title:  "Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)"
date:   2017-02-28 00:00:00 +0900
categories: Swift Programming Language Grammar
redirect_from: "/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/)[^Swift] 책을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리했습니다.
>
> 1차 번역은 완료했으며, 현재는 문장을 다듬고 오류를 고치는 중입니다. 보시고 수정 사항이 있으면 댓글이나 <a href="mailto:{{ site.email }}">메일</a>로 연락주시면 감사하겠습니다.

### Translator's words (옮긴이의 말)

* 진행 상황: ![5.3](https://img.shields.io/badge/-%205.3-success) 2차 완료, ![5.3 on-going](https://img.shields.io/badge/-%205.3-yellow) 2차 수정 진행중, ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive) - 5.3 1차 완료

### Welcome to Swift (스위프트 소개)

* [About Swift (스위프트에 대하여)]({% post_url 2017-03-02-About-Swift %}) ![5.3](https://img.shields.io/badge/-%205.3-success)
* [Version Compatibility (버전 호환성)]({% post_url 2020-03-15-Version-Compatibility %}) ![5.3](https://img.shields.io/badge/-%205.3-success)
* [A Swift Tour (스위프트 둘러보기)]({% post_url 2016-04-17-A-Swift-Tour %}) ![5.3](https://img.shields.io/badge/-%205.3-success)

### Language Guide (언어 설명서)

* [The Basics (기초)]({% post_url 2016-04-24-The-Basics %}) ![5.3](https://img.shields.io/badge/-%205.3-success)
* [Basic Operators (기본 연산자)]({% post_url 2016-04-27-Basic-Operators %}) ![5.3 on-going](https://img.shields.io/badge/-%205.3-yellow)
* [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Collection Types (컬렉션 타입; 집합체 타입)]({% post_url 2016-06-06-Collection-Types %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Functions (함수)]({% post_url 2020-06-02-Functions %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Closures (클로저; 잠금 블럭)]({% post_url 2020-03-03-Closures %}) ![5.3 on-going](https://img.shields.io/badge/-%205.3-yellow)
* [Enumerations (열거체)]({% post_url 2020-06-13-Enumerations %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Structures and Classes (구조체와 클래스)]({% post_url 2020-04-14-Structures-and-Classes %})
* [Properties (속성)]({% post_url 2020-05-30-Properties %}) ![5.3 on-going](https://img.shields.io/badge/-%205.3-yellow)
* [Methods (메소드)]({% post_url 2020-05-03-Methods %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Subscripts (첨자 연산)]({% post_url 2020-03-30-Subscripts %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Inheritance (상속)]({% post_url 2020-03-31-Inheritance %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) ![5.3](https://img.shields.io/badge/-%205.3-success)
* [Deinitialization (객체 정리)]({% post_url 2017-03-03-Deinitialization %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Optional Chaining (옵셔널 체이닝; 옵셔널 연쇄)]({% post_url 2020-06-17-Optional-Chaining %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Error Handling (에러 처리)]({% post_url 2020-05-16-Error-Handling %}) ![5.3 on-going](https://img.shields.io/badge/-%205.3-yellow)
* [Type Casting (타입 변환)]({% post_url 2020-04-01-Type-Casting %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Nested Types (중첩 타입)]({% post_url 2017-03-03-Nested-Types %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Extensions (익스텐션; 확장)]({% post_url 2016-01-19-Extensions %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) ![5.3](https://img.shields.io/badge/-%205.3-success)
* [Generics (제네릭; 일반화)]({% post_url 2020-02-29-Generics %}) ![5.3](https://img.shields.io/badge/-%205.3-success)
* [Opaque Types (불투명한 타입)]({% post_url 2020-02-22-Opaque-Types %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Automatic Reference Counting (자동 참조 카운팅)]({% post_url 2020-06-30-Automatic-Reference-Counting %}) ![5.3](https://img.shields.io/badge/-%205.3-success)
* [Memory Safety (메모리 안전성)]({% post_url 2020-04-07-Memory-Safety %}) ![5.3](https://img.shields.io/badge/-%205.3-success)
* [Access Control (접근 제어)]({% post_url 2020-04-28-Access-Control %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)

### Language Reference (언어의 기준)

* [About the Language Reference (언어의 기준에 대하여)]({% post_url 2017-03-13-About-the-Language-Reference %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Lexical Structure (어휘 구조)]({% post_url 2020-07-28-Lexical-Structure %}) ![5.3](https://img.shields.io/badge/-%205.3-success)
* [Types (타입)]({% post_url 2020-02-20-Types %}) ![5.3](https://img.shields.io/badge/-%205.3-success)
* [Expressions (표현식)]({% post_url 2020-08-19-Expressions %}) ![5.3](https://img.shields.io/badge/-%205.3-success)
* [Statements (구문)]({% post_url 2020-08-20-Statements %}) ![5.3](https://img.shields.io/badge/-%205.3-success)
* [Declarations (선언)]({% post_url 2020-08-15-Declarations %}) ![5.3](https://img.shields.io/badge/-%205.3-success)
* [Attributes (특성)]({% post_url 2020-08-14-Attributes %}) ![5.3](https://img.shields.io/badge/-%205.3-success)
* [Patterns (패턴; 유형)]({% post_url 2020-08-25-Patterns %}) ![5.3](https://img.shields.io/badge/-%205.3-success)
* [Generic Parameters and Arguments (일반화된 매개 변수와 일반화된 인자)]({% post_url 2017-03-16-Generic-Parameters-and-Arguments %}) ![5.3 inactive](https://img.shields.io/badge/-%205.3-inactive)
* [Summary of the Grammar (문법 총정리)](https://docs.swift.org/swift-book/ReferenceManual/zzSummaryOfTheGrammar.html#) - 직접 링크 (번역 없음)

### Revision History (개정 이력)

* [Document Revision History (문서 개정 이력)]({% post_url 2020-03-16-Document-Revision-History %})  ![5.3](https://img.shields.io/badge/-%205.3-success)

### 참고 자료

[^Swift]: 'The Swift Programming Language (스위프트 프로그래밍 언어)' 는 애플에서 공개한 스위프트 언어 문법 책으로, 2020-09-16 에 최신 버전으로 갱신되었습니다. 원문은 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 에서 볼 수 있습니다.
