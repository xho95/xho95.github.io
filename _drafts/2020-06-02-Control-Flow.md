---
layout: post
comments: true
title:  "Swift 5.2: Control Flow (제어 흐름)"
date:   2020-06-02 10:00:00 +0900
categories: Swift Language Grammar Control-Flow For-In While
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html) 부분[^Control-Flow]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Control Flow (제어 흐름)

스위프트는 다양한 제어 흐름 구문을 제공합니다. 여기에 포함된 것은 작업을 여러 번 수행하는 `while` 반복 구문; 정해진 조건에 따라 다른 분기에 있는 코드를 실행하는 `if`, `guard`, 및 `switch` 구문; 그리고 `break` 와 `continue` 같이 실행 흐름을 코드의 다른 지점으로 전달하는 구문입니다.

스위프트는 `for-in` 반복 구문도 제공하므로 배열, 딕셔너리, 범위, 문자열, 및 기타 '나열된 자료 형태 (sequences)' 에 대해 동작을 쉽게 반복 적용할 수 있습니다.

스위프트의 `switch` 문은 C-계열 언어에 있는 것보다 괄목할만하게 더 강력합니다. '경우 값 (cases)' 는 아주 다양한 '유형 (patterns)' 에 대해서 해당하는 것을 찾을 수 있으며, '해당 구간 찾기 (interval matches)', 튜플 찾기, 그리고 지정된 타입으로의 '변환 (casts)' 기능도 포함합니다. `switch` 의 '경우 값(case)' 에 해당하는 값은 임시 상수나 변수로 연결되어서 '경우 값' 본문 내에서 사용할 수 있으며, 각 '경우 값 (case)' 에 `where` 절을 사용하면 해당 조건이 복잡한 것도 표현할 수 있습니다.

### For-In Loops (For-In 반복 구문)

### While Loops (While 반복 구문)

#### While (While 문)

#### Repeat-While (Repeat-While 문)

### Conditional Statements (조건 구문)

#### If (If 문)

#### Switch (Switch 문)

**No Implicit Fallthrough (암시적으로 빠져나가지 않음)**

**Interval Matching (해당 구간 찾기)**

**Tuples (튜플)**

**Value Bindings (값 연결짓기)**

**Where (Where 절)**

**Compound Cases (복합 경우 값)**

### Control Transfer Statements (제어 전달 구문)

#### Continue (Continue 문)

#### Break (Break 문)

**Break in a Loop Statement (반복 구문 내의 Break 문)**

**Break in a Switch Statement (Switch 구문 내의 Break 문)**

#### Fallthrough (Fallthrough 문)

#### Labeled Statements (이름표 달린 구문)

### Early Exit (조기 탈출 구문)

### Checking API Availability (API 사용 가능 여부 검사하기)

### 참고 자료

[^Control-Flow]: 이 글에 대한 원문은 [Control Flow](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html) 에서 확인할 수 있습니다.
