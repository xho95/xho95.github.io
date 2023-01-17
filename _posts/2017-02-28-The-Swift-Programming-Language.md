---
layout: post
pagination: 
  enabled: true
comments: true
title:  "Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)"
date:   2017-02-28 00:00:00 +0900
categories: Swift Programming Language Grammar
redirect_from: "/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/)[^Swift] 책을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리했습니다.
>
> 현재는 5차 번역을 진행하면서, 문장을 다듬는 중입니다. 수정 사항을 발견하게 되면 댓글이나 <a href="mailto:{{ site.email }}">메일</a>로 연락주시면 감사하겠습니다.

### Translator's words (옮긴이의 말)

* 진행 상황: ![5.7](https://img.shields.io/badge/-%205.5-success) 4차 완료, ![5.7 on-going](https://img.shields.io/badge/-%205.5-yellow) 5차 수정 진행중, ![5.7 inactive](https://img.shields.io/badge/-%205.5-inactive) - 5.6 완료

### Welcome to Swift (스위프트 소개)

* [About Swift (스위프트에 대하여)]({% post_url 2017-03-02-About-Swift %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Version Compatibility (버전 호환성)]({% post_url 2020-03-15-Version-Compatibility %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [A Swift Tour (스위프트 둘러보기)]({% post_url 2016-04-17-A-Swift-Tour %}) ![5.7](https://img.shields.io/badge/-%205.5-success)

### Language Guide (언어 설명서)

* [The Basics (기초)]({% post_url 2016-04-24-The-Basics %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Basic Operators (기초 연산자)]({% post_url 2016-04-27-Basic-Operators %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Collection Types (집합체 타입)]({% post_url 2016-06-06-Collection-Types %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Functions (함수)]({% post_url 2020-06-02-Functions %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Closures (클로저; 잠금 블럭)]({% post_url 2020-03-03-Closures %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Enumerations (열거체)]({% post_url 2020-06-13-Enumerations %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Structures and Classes (구조체와 클래스)]({% post_url 2020-04-14-Structures-and-Classes %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Properties (속성)]({% post_url 2020-05-30-Properties %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Methods (메소드)]({% post_url 2020-05-03-Methods %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Subscripts (첨자)]({% post_url 2020-03-30-Subscripts %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Inheritance (상속)]({% post_url 2020-03-31-Inheritance %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Deinitialization (뒷정리)]({% post_url 2017-03-03-Deinitialization %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Optional Chaining (옵셔널 사슬)]({% post_url 2020-06-17-Optional-Chaining %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Error Handling (에러 처리)]({% post_url 2020-05-16-Error-Handling %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Concurrency (동시성)]({% post_url 2021-06-10-Concurrency %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Type Casting (타입 변환)]({% post_url 2020-04-01-Type-Casting %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Nested Types (중첩 타입)]({% post_url 2017-03-03-Nested-Types %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Extensions (익스텐션; 확장)]({% post_url 2016-01-19-Extensions %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Generics (일반화)]({% post_url 2020-02-29-Generics %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Opaque Types (불투명 타입)]({% post_url 2020-02-22-Opaque-Types %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Automatic Reference Counting (자동 참조 카운팅)]({% post_url 2020-06-30-Automatic-Reference-Counting %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Memory Safety (메모리 안전성)]({% post_url 2020-04-07-Memory-Safety %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Access Control (접근 제어)]({% post_url 2020-04-28-Access-Control %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) ![5.7](https://img.shields.io/badge/-%205.5-success)

### Language Reference (언어의 기준)

* [About the Language Reference (언어의 기준에 대하여)]({% post_url 2017-03-13-About-the-Language-Reference %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Lexical Structure (어휘 구조)]({% post_url 2020-07-28-Lexical-Structure %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Types (타입)]({% post_url 2020-02-20-Types %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Expressions (표현식)]({% post_url 2020-08-19-Expressions %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Statements (구문)]({% post_url 2020-08-20-Statements %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Declarations (선언)]({% post_url 2020-08-15-Declarations %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Attributes (특성)]({% post_url 2020-08-14-Attributes %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Patterns (패턴; 유형)]({% post_url 2020-08-25-Patterns %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Generic Parameters and Arguments (일반화 매개 변수와 인자)]({% post_url 2017-03-16-Generic-Parameters-and-Arguments %}) ![5.7](https://img.shields.io/badge/-%205.5-success)
* [Summary of the Grammar (문법 총정리)](https://docs.swift.org/swift-book/ReferenceManual/zzSummaryOfTheGrammar.html#) - 직접 링크 (번역 없음)

### Revision History (개정 이력)

* [Document Revision History (문서를 다듬은 역사)]({% post_url 2020-03-16-Document-Revision-History %}) ![5.7](https://img.shields.io/badge/-%205.5-success)

### 참고 자료

[^Swift]: 'The Swift Programming Language (스위프트 프로그래밍 언어)' 는 애플에서 공개하고 있는 '스위프트 문법 책' 이며, 2021년 2월 17일에 '버전 5.4' 로 갱신되었습니다. 원문 링크는 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 입니다.
