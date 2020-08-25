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

> GRAMMAR OF A STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html)

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

`do` 문은 다음의 형식을 가지고 있습니다:

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

`do` 코드 블럭에 있는 어떤 구문이든 에러를 던지게 되면, 애러와 일치하는 '패턴 (pattern)' 의 첫 번째 `catch` 절로 프로그램 제어를 전달합니다. 일치하는 구절이 없으면, 에러를 주변 영역으로 전파합니다. 에러가 최상위 수준에서도 처리되지 않으면, 실행 시간 에러와 함께 프로그램 실행을 중지합니다.

컴파일러는, `switch` 문 처럼, `catch` 절이 빠짐없이 철저한 지를 추론합니다. 그렇다고 결정할 수 있으면, 에러는 처리되는 것이라 간주됩니다. 다른 경우라면, 에러는 담고 있는 영역 밖으로 전파할 수 있는 것으로, 이는 에러가 둘러싼 `catch` 절에서 반드시 처리되거나 아니면 담고 있는 함수가 반드시 `throws` 로 선언되어야 함을 의미합니다.

다중 패턴을 가지고 있는 `catch` 절은 패턴 중에서 어떤 것이 에러와 일치하는 경우 에러와 일치합니다. `catch` 절이 다중 패턴을 가지는 경우, 모든 패턴이 반드시 같은 '상수 연결 (bindings)' 또는 '변수 연결 (bindings)' 을 가져야 하며, 각각의 연결된 변수 또는 상수는 모든 `catch` 절의 패턴에서 반드시 똑같은 타입을 가져야 합니다.

에러가 처리되는 것을 보장하려면, `catch` 절에, '와일드카드 패턴 (wildcard pattern; `_`)' 같은, 모든 에러와 일치하는 패턴을 사용합니다. `catch` 절에서 패턴을 지정하지 않으면, 이 `catch` 절은 어떤 에러와도 일치하며 이를 `error` 라는 지역 상수에 연결합니다. `catch` 절에서 사용할 수 있는 패턴에 대한 더 많은 정보는, [Patterns (패턴; 유형)]({% post_url 2020-08-25-Patterns %}) 을 참고하기 바랍니다.

`do` 문을 여러 개의 `catch` 절과 함께 사용하는 방법에 대한 예제를 보려면, [Handling Errors (에러 처리하기)]({% post_url 2020-05-16-Error-Handling %}#handling-errors-에러-처리하기) 를 참고하기 바랍니다.

> GRAMMAR OF A DO STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID533)

### Compiler Control Statements

#### Conditional Compilation Block

#### Line Control Statement (라인 제어문)

'라인 제어문 (line control statement)' 은 컴파일 되는 소스 코드의 '라인 (line)' 번호 및 파일 이름과 다를 수도 있는 라인 번호 및 파일 이름을 지정하기 위해 사용합니다. 스위프트가 진단 및 디버깅 목적으로 사용하는 소스 코드의 위치를 바꾸려면 '라인 제어문' 을 사용하도록 합니다.

라인 제어문은 다음의 형식을 가지고 있습니다:

```swift
  #sourceLocation(file: file path, line: line number)
  #sourceLocation()
```

첫 번째 형식의 라인 제어문은, 라인 제어문 다음의 코드 라인에서 시작하여, `#line`, `#file`, 그리고 `#filePath` 글자 값 표현식의 값을 바꿉니다. _라인 번호 (line number)_ 는 `#line` 의 값을 바꾸는 것으로 '0' 보다 큰 어떤 정수 글자 값입니다. _파일 경로 (file path)_ 는 `#file` 과 `#filePath` 의 값을 바꾸는 것으로, 문자열 글자 값입니다. 지정한 문자열이 `#filePath` 의 값이 되고, 문자열의 마지막 경로 성분이 `#file` 의 값이 됩니다.

두 번째 형식의 라인 제어문인, `#sourceLocation()` 은, 소스 코드 위치를 기본 라인 번호와 파일 경로로 재설정 합니다.

> GRAMMAR OF A LINE CONTROL STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID538)

#### Compile-Time Diagnostic Statement

### Availability Condition

### 참고 자료

[^Statements]: 원문은 [Statements](https://docs.swift.org/swift-book/ReferenceManual/Statements.html) 에서 확인할 수 있습니다.
