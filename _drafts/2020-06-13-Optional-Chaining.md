---
layout: post
comments: true
title:  "Swift 5.2: Optional Chaining (옵셔널 사슬)"
date:   2020-06-13 10:00:00 +0900
categories: Swift Language Grammar Error Handling
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Optional Chaining](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 부분[^Optional-Chaining]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Optional Chaining (옵셔널 사슬)

_옵셔널 사슬 (optional chaining)_ 은 현재 값이 `nil` 일 수도 있는 '옵셔널' 의 속성, 메소드, 그리고 첨자 연산을 조회하고 호출하는 '과정 (process)' 을 말합니다. 만약 '옵셔널' 이 값을 가지고 있으면, 속성, 메소드, 또는 첨자 연산에 대한 호출은 성공합니다; 먄약 '옵셔널' 이 `nil` 이라면, 속성, 메소드, 또는 첨자 연산에 대한 호출은 `nil` 을 반환합니다. '다중 조회 (multiple queries)' 는 서로 사슬처럼 이어질 수 있으며, 사슬 중에 어느 한 고리라도 `nil` 이면 전체 사슬은 깔끔하게 실패합니다.

> 스위프트의 '옵셔널 사슬' 은 오브젝티브-C 언어에서 `nil` 메시지를 주고받는 것과 비슷하지만, 어떤 타입과도 작업할 수 있으며, 성공이나 실패를 검사할 수 있습니다.

### Optional Chaining as an Alternative to Forced Unwrapping (강제 풀기의 대안으로써의 줄지어진 옵셔널)

### Defining Model Classes for Optional Chaining (줄지어진 옵셔널에 대한 클래스 모델 정의하기)

### Accessing Properties Through Optional Chaining (줄지어진 옵셔널을 통해 속성 접근하기)

### Call Methods Through Optional Chaining (줄지어진 옵셔널을 통해 메소드 호출하기)

### Accessing Subscripts Through Optional Chaining (줄지어진 옵셔널을 통해 첨자 연산 접근하기)

#### Accessing Subscripts of Optional Type (옵셔널 타입의 첨자 연산 접근하기)

### Linking Multiple Levels of Chaining (여러 단계로 이어서 연결하기)

### Chaining on Methods with Optional Return Values (옵셔널 반환 값을 가지는 메소드 줄짓기?)

### 참고 자료

[^Optional-Chaining]: 이 글에 대한 원문은 [Optional Chaining](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 에서 확인할 수 있습니다.
