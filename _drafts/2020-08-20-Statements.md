---
layout: post
comments: true
title:  "Swift 5.3: Statements (구문)"
date:   2020-08-20 11:30:00 +0900
categories: Swift Language Grammar Statement
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Statements](https://docs.swift.org/swift-book/ReferenceManual/Statements.html) 부분[^Statements]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## Statements (구문)

스위프트에는, 세 가지 종류의 구문이 있습니다: '단순 구문 (simple statements)', '컴파일러 제어문 (compiler control statements)', 그리고 '제어 흐름문 (control flow statements)' 이 그것입니다. '단순 구문' 은 가장 공통된 것으로 표현식 또는 선언으로 구성됩니다. '컴파일러 제어문' 은 프로그램이 컴파일러의 작동 방식을 바꾸도록 해주며 '조건부 컴파일 블럭 (conditional compilation block)' 및 '라인 제어문 (line control statement)' 을 포함합니다.

'제어 흐름문' 은 프로그램에 있는 실행 흐름을 제어하기 위해 사용합니다. 스위프트에는, '반복문 (loop statements)', '분기문 (branch statements)', 및 '제어 전달문 (control transfer statements)' 을 포함하여, 여러가지 타입의 제어 흐름문이 있습니다. '반복문' 은 코드 블럭을 반복해서 실행하도록 해주며, '분기문' 은 정해진 코드 블럭이 정해진 조건을 만날 때만 실행되도록 해주며, '제어 전달문' 은 코드의 실행 순서를 부분적으로 바꾸는 방법을 제공합니다. 여기에 더하여, 스위프트는 영역을 도입해서, 에러를 잡아내고 처리하는 `do` 구문, 및 현재 영역을 빠져나가기 바로 직전에 정리 작업을 실행하는 `defer` 문을 제공합니다.

'세미콜론 (semicolon; `;`)' 은 어떤 구문 뒤에든 선택적으로 붙일 수 있으며 다중 구문이 같은 줄에 있는 경우 이를 구분하는 데 사용합니다.

> GRAMMAR OF AN STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html)

### Loop Statements

#### For-In Statement

#### While Statement

#### Repeat-While Statement

### Branch Statement

#### If Statement

#### Guard Statement

#### Switch Statement

**Switch Statements Must Be Exhaustive**

**Switching Over Future Enumeration Cases**

**Execution Does Not Fall Through Cases Implicitly**

### Labeled Statement

### Control Transfer Statements

#### Break Statement

#### Continue Statement

#### Fallthrough Statement

#### Return Statement

#### Throw Statement

### Defer Statement

### Do Statement ('do' 구문)

`do` 구문은 새로운 영역을 도입하기 위해 사용하며, 정의한 에러 조건과 일치하는 '패턴 (pattern; 유형)' 을 가지고 있는, 하나 이상의 `catch` 절을 선택적으로 가질 수 있습니다. `do` 문의 영역 안에서 선언한 변수 및 상수는 해당 영역 내에서만 접근할 수 있습니다.

스위프트의 `do` 문은 C 언어에서 코드 블럭의 경계를 구분하는데 사용하는 '중괄호 (curly; `{}`)' 와 비슷한 것으로, 실행 시간에 성능 비용을 초래하지 않습니다.

`do` 문은 다음의 형식을 가집니다:

```swift
do {
    try expression
    statements
} catch pattern 1 {
    statements
} catch pattern 2 where condition {
    statements
} catch pattern 3, pattern 4 where condition {
    statements
} catch {
    statements
}
```

do 코드 블록의 문에서 오류가 발생하면 프로그램 제어는 패턴이 오류와 일치하는 첫 번째 catch 절로 전송됩니다. 일치하는 절이 없으면 오류가 주변 범위로 전파됩니다. 최상위 수준에서 오류가 처리되지 않으면 프로그램 실행이 런타임 오류와 함께 중지됩니다.

switch 문과 마찬가지로 컴파일러는 catch 절이 완전한지 여부를 추론합니다. 그러한 결정이 내려지면 오류가 처리 된 것으로 간주됩니다. 그렇지 않으면 오류가 포함 범위 밖으로 전파 될 수 있습니다. 즉, 포함하는 catch 절에서 오류를 처리하거나 포함하는 함수를 throw로 선언해야합니다.

여러 패턴이있는 catch 절은 패턴이 오류와 일치하는 경우 오류와 일치합니다. catch 절에 여러 패턴이 포함 된 경우 모든 패턴에는 동일한 상수 또는 변수 바인딩이 포함되어야하며 각 바인딩 된 변수 또는 상수는 모든 catch 절의 패턴에서 동일한 유형을 가져야합니다.

오류가 처리되도록하려면 와일드 카드 패턴 (`_`)과 같이 모든 오류와 일치하는 패턴과 함께 catch 절을 사용하십시오. catch 절이 패턴을 지정하지 않으면 catch 절은 오류를 일치시키고 error라는 로컬 상수에 바인딩합니다. catch 절에서 사용할 수있는 패턴에 대한 자세한 내용은 패턴을 참조하세요.

여러 catch 절과 함께 do 문을 사용하는 방법의 예를 보려면 오류 처리를 참조하십시오.

### Compiler Control Statements

#### Conditional Compilation Block

#### Line Control Statement

#### Compile-Time Diagnostic Statement

### Availability Condition

### 참고 자료

[^Statements]: 원문은 [Statements](https://docs.swift.org/swift-book/ReferenceManual/Statements.html) 에서 확인할 수 있습니다.
