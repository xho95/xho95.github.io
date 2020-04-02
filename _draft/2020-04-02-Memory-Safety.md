---
layout: post
comments: true
title:  "Swift 5.2: Memory Safety (메모리 안전 장치)"
date:   2020-04-02 10:00:00 +0900
categories: Swift Language Grammar Memory Safety
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Memory Safety](https://docs.swift.org/swift-book/LanguageGuide/MemorySafety.html) 부분[^Memory-Safety]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Memory Safety (메모리 안전 장치)

기본적으로, 스위프트는 코드에서 안전하지 않은 동작이 발생하는 것을 막아줍니다. 예를 들어, 스위프트는 변수일 경우 사용 전에 미리 초기화가 되게 하고, 메모리일 경우 해제 후에는 접근하지 않도록 하며, 배열 색인일 경우 경계를-벗어난 에러가 있는지 검사하도록 합니다.

스위프트는 또한 동일한 메모리 영역에 여러 개의 접근이 발생할 경우 이들이 서로 충돌이 되지 않도록 하는데, 이를 위해 메모리의 특정 위치를 수정하는 코드라면 그 메모리에 배타적으로 접근하도록 요구합니다. 스위프트는 메모리를 자동으로 관리하기 때문에, 대부분의 경우 메모리 접근에 대해 전혀 생각할 필요가 없긴 합니다. 하지만, 잠재적으로 충돌이 발생할 수 있는 곳을 이해하는 것은 여전히 중요하며, 이는 애초에 코드를 작성할 때부터 메모리 접근의 충돌을 피할 수 있기 때문입니다. 코드에 충돌이 발생하는 곳이 있으면, '컴파일 시간 에러' 나 '실행 시간 에러' 가 발생할 것입니다.  

### Understanding Conflicting Access to Memory (메모리에 접근할 때의 충돌 이해하기)

#### Characteristics of Memory Access (메모리 접근의 성질)

### Conflicting Access to In-Out Parameters (입-출력 매개 변수에 접근할 때의 충돌)

### Conflicting Access to self in Methods (메소드 내에서 self 에 접근할 때의 충돌)

### Conflicting Access to Properties (속성에 접근할 때의 충돌)

### 참고 자료

[^Memory-Safety]: 이 글에 대한 원문은 [Memory Safety](https://docs.swift.org/swift-book/LanguageGuide/MemorySafety.html) 에서 확인할 수 있습니다.
