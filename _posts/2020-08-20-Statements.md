---
layout: post
comments: true
title:  "Swift 5.4: Statements (구문)"
date:   2020-08-20 11:30:00 +0900
categories: Swift Language Grammar Statement
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.4)](https://docs.swift.org/swift-book/) 책의 [Statements](https://docs.swift.org/swift-book/ReferenceManual/Statements.html) 부분[^Statements]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.4: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Statements (구문)

스위프트, 구문에는: '단순 (simple) 문', '컴파일러 제어 (compiler control) 문', 그리고 '제어 흐름 (control flow) 문' 이라는 세 종류가 있습니다. '단순문' 은 가장 일반적인 것으로 표현식이나 선언문으로 구성됩니다. '컴파일러 제어문' 은 프로그램이 컴파일러의 작동을 바꾸도록 허용하며 '조건부 컴파일 블럭 (conditional compilation block)' 과 '라인 제어문 (line control statement)' 을 포함합니다.

'제어 흐름문' 은 프로그램의 실행 흐름을 제어하기 위해 사용합니다. 스위프트에는, '반복 (loop) 문', '분기 (branch) 문', 그리고 '제어 전달 (control transfer) 문' 을 포함한, 여러가지 타입의 '제어 흐름문' 들이 있습니다. '반복문' 은 코드 블럭이 반복해서 실행되도록 하고, '분기문' 은 정해진 코드 블럭이 지정된 조건을 만날 때만 실행되도록 하며, '제어 전달문' 은 코드가 실행되는 순서를 부분적으로 바꾸는 방법을 제공합니다. 이에 더하여, 스위프트는, 에러를 잡아 내고 처리하는, 영역을 도입하는 '`do` 문' 과, 현재 영역을 탈출하기 바로 직전에 정리 작업을 실행하기 위한 '`defer` 문' 을 제공합니다.

'세미콜론 (semicolon; `;`)' 은 어떤 구문 뒤에든 있을 수 있으며 같은 줄에 여러 구문이 있을 때 이를 구분하기 위해 사용합니다.

> GRAMMAR OF A STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html)

### Loop Statements (반복문)

반복문은, 반복문에서 지정한 조건에 따라, 코드 블럭을 반복해서 실행하도록 합니다. 스위프트에는: `for`-`in` 문, `while` 문, `repeat`-`while` 문 이라는 세 개의 반복문이 있습니다.

반복문의 제어 흐름은 `break` 문과 `continue` 문으로 바꿀 수 있으며 이는 아래에 있는 [Break Statement ('break' 문)](#break-statement-break-문) 과 [Continue Statement ('continue' 문)](#continue-statement-continue-문) 부분에서 논의합니다.

> GRAMMAR OF A LOOP STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID429)

#### For-In Statement ('for-in' 문)

`for`-`in` 문은 [Sequence](https://developer.apple.com/documentation/swift/sequence) 프로토콜을 준수하는 집합체 (또는 어떤 타입) 의 각 항목마다 한 번씩 코드 블럭을 실행하도록 합니다.

`for`-`in` 문의 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;for `item-항목` in `collection-집합체` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

'반복자 (iterator) 타입'-즉, [IteratorProtocol](https://developer.apple.com/documentation/swift/iteratorprotocol) 프로토콜을 준수하는 타입-의 값을 구하기 위해 _집합체 (collection)_ 표현식에 대한 `makeIterator()` 메소드를 호출합니다. 프로그램은 '반복자' 에 대한 `next()` 메소드를 호출함으로써 반복문의 실행을 시작합니다. 반환한 값이 `nil` 이 아니면, 이를 _항목 (item)_ '유형 (pattern)' 에 할당하고, 프로그램이 _구문 (statements)_ 을 실행한 다음, 반복문 맨 앞에서 실행을 계속합니다. 그 외의 경우, 프로그램은 할당이나 _구문 (statements)_ 실행을 하지 않고, `for`-`in` 문 실행을 종료합니다.

> GRAMMAR OF A FOR-IN STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html)

#### While Statement ('while' 문)

`while` 문은, 조건이 '참' 인 한, 코드 블럭을 반복해서 실행하도록 합니다.

`while` 문의 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;while `condition-조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

`while` 문은 다음과 같이 실행합니다:

1. _조건 (condition)_ 을 평가합니다.

  `true` 면, 2 단계를 계속 실행합니다. `false` 면, 프로그램이 `while` 문 실행을 종료합니다.

2. 프로그램이 _구문 (statements)_ 을 실행하고, 1 단계 실행으로 돌아갑니다.

_조건 (condition)_ 의 값을 _구문 (statements)_ 실행 전에 평가하기 때문에, `while` 문의 _구문 (statements)_ 은 '0' 번 또는 그 이상 실행될 수 있습니다.

_조건 (condition)_ 의 값은 반드시 `Bool` 타입 또는 `Bool` 과 '연동된 (bridged)' 타입이어야 합니다. '조건' 은, [Optional Binding (옵셔널 연결)]({% post_url 2016-04-24-The-Basics %}#optional-binding-옵셔널-연결) 에서 설명한 것처럼, '옵셔널 연결 (optional binding) 선언' 일 수도 있습니다.

> GRAMMAR OF A WHILE STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html)

#### Repeat-While Statement ('repeat'-'while' 문)

`repeat`-`while` 문은, 조건이 '참' 인 한, 코드 블럭을 한 번 또는 그 이상 실행하도록 합니다.

`repeat`-`while` 문의 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;repeat {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;} while `condition-조건`

`repeat`-`while` 문은 다음과 같이 실행합니다:

1. 프로그램이 _구문 (statements)_ 을 실행하고, 2 단계를 계속 실행합니다.

2. _조건 (condition)_ 을 평가합니다.

  `true` 면, 1 단계 실행으로 돌아갑니다. `false` 면, 프로그램이 `repeat`-`while` 문 실행을 종료합니다.

_조건 (condition)_ 의 값을 _구문 (statements)_ 실행 후에 평가하기 때문에, `repeat`-`while` 문의 _구문 (statements)_ 은 최소 한 번은 실행됩니다.

_조건 (condition)_ 의 값은 반드시 `Bool` 타입 또는 `Bool` 과 '연동된 (bridged)' 타입이어야 합니다. '조건' 은, [Optional Binding (옵셔널 연결)]({% post_url 2016-04-24-The-Basics %}#optional-binding-옵셔널-연결) 에서 설명한 것처럼, '옵셔널 연결 선언' 일 수도 있습니다.

> GRAMMAR OF A REPEAT-WHILE STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html)

### Branch Statements (분기문)

분기문은 프로그램이 하나 이상의 조건 값에 따라 정해진 코드를 실행하도록 합니다. 분기문에서 지정한 조건 값이 프로그램의 분기 방법, 따라서, 실행할 코드 블럭이 무엇인지를, 제어합니다. 스위프트에는: `if` 문, `guard` 문, 그리고 `switch` 문 이라는 세 개의 분기문이 있습니다.

`if` 문이나 `switch` 문의 제어 흐름은 `break` 문으로 바꿀 수 있는데 이는 아래의 [Break Statement ('break' 문)](#break-statement-break-문)) 에서 논의합니다.

> GRAMMAR OF A BRANCH STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID434)

#### If Statement ('if' 문)

`if` 문은 하나 이상의 조건 평가에 기초하여 코드를 실행하는데 사용합니다.

`if` 문에는 두 개의 기본 형식이 있습니다. 각 형식에서, '여는 중괄호' 와 '닫는 중괄호' 는 필수입니다.

첫 번째 형식은 조건이 참일 때만 코드를 실행하며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;if `condition-조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

`if` 문의 두 번째 형식은 (`else` 키워드를 도입하여) 추가적인 _else 절 (else clause)_ 을 제공하며 한 코드는 조건이 참일 때 실행하고 다른 코드는 똑같은 조건이 거짓일 때 실행하고자 사용합니다. '단일 `else` 절' 이 있을 때의, `if` 문의 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;if `condition-조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements to execute if condition is true-조건이 참이면 실행하는 구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;} else {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements to execute if condition is false-조건이 거짓이면 실행하는 구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

`if` 문의 'else 절' 은 하나 이상의 조건을 테스트하기 위한 또 다른 `if` 문을 담을 수 있습니다. 이런 식으로 서로 연쇄된 `if` 문의 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;if `condition 1-조건 1` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements to execute if condition 1 is true-조건 1 이 참이면 실행하는 구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;} else if `condition 2-조건 2` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements to execute if condition 2 is true-조건 2 가 참이면 실행하는 구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;} else {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements to execute if both conditions are false- 두 조건 다 거짓이면 실행하는 구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

`if` 문의 어떤 조건 값이든 반드시 `Bool` 타입 또는 `Bool` 과 '연동된 (bridged)' 타입이어야 합니다. '조건' 은, [Optional Binding (옵셔널 연결)]({% post_url 2016-04-24-The-Basics %}#optional-binding-옵셔널-연결) 에서 설명한 것처럼, '옵셔널 연결 선언' 일 수도 있습니다.

> GRAMMAR OF A BRANCH STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID434)

#### Guard Statement ('guard' 문)

`guard` 문은 하나 이상의 조건과 만나지 않을 경우 프로그램 제어를 영역 밖으로 전달하고자 사용합니다.

`guard` 문의 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;guard `condition-조건` else {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

`guard` 문의 어떤 조건 값이든 반드시 `Bool` 타입 또는 `Bool` 과 '연동된 (bridged)' 타입이어야 합니다. '조건' 은, [Optional Binding (옵셔널 연결)]({% post_url 2016-04-24-The-Basics %}#optional-binding-옵셔널-연결) 에서 설명한 것처럼, '옵셔널 연결 선언' 일 수도 있습니다.

`guard` 문 조건의 '옵셔널 연결 선언' 으로 값을 할당한 어떤 상수나 변수든 'guard 문' 을 둘러싼 나머지 영역에서 사용할 수 있습니다.

`guard` 문에서 '`else` 절' 은 필수이며, 반드시 '`Never` 반환 타입' 을 가진 함수를 호출하거나 아니면 아래 구문 중 하나를 사용하여 프로그램 제어를 'guard 문' 을 둘러싼 영역 밖으로 옮겨야 합니다:

* `return`
* `break`
* `continue`
* `throw`

'제어 전달 (control transfer) 문' 은 아래의 [Control Transfer Statements (제어 전달문)](#control-transfer-statements-제어-전달문) 에서 논의합니다. '`Never` 반환 타입을 가진 함수' 에 대한 더 많은 정보는, [Functions that Never Return (절대 반환하지 않는 함수)]({% post_url 2020-08-15-Declarations %}#functions-that-never-return-절대-반환하지-않는-함수) 부분을 참고하기 바랍니다.

> GRAMMAR OF A GUARD STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID434)

#### Switch Statement ('switch' 문)

`switch` 문은 제어 표현식의 값에 따라 정해진 코드 블럭을 실행하도록 합니다.

`switch` 문의 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;switch `control expression-제어 표현식` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;case `pattern 1-유형 1`:<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;case `pattern 2-유형 2` where `condition-조건`:<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;case `pattern 3-유형 3` where `condition-조건`,<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`pattern 4-유형 4` where `condition-조건`:<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;default:<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

`switch` 문의 _제어 표현식 (control expression)_ 을 평가한 다음 각각의 'case 절' 에서 지정한 '유형 (patterns)' 과 비교합니다. 일치하는 것을 찾으면, 프로그램은 해당 'case 절' 영역 안에 나열한 _구문 (statements)_ 을 실행합니다. 각 'case 절' 영역은 비워둘 수 없습니다. 그 결과, 반드시 최소 하나의 구문을 각 'case 이름표' 의 '콜론 (`:`)' 뒤에 포함시켜야 합니다. '일치한 case 절' 본문에서 어떤 코드도 실행하지 않으려면 '단일 `break` 문' 을 사용합니다.

코드가 분기할 수 있는 표현식의 값은 매우 유연합니다. 예를 들어, 정수와 문자 같은, '크기 (scalar) 타입'[^scalar-types] 의 값에 더하여, 부동-소수점 수, 문자열, 튜플, 사용자 정의 클래스의 인스턴스, 그리고 옵셔널을 포함한, 어떤 타입의 값에 대해서든 코드를 분기할 수 있습니다. _제어 표현식 (control expression)_ 의 값은 심지어 열거체의 'case 값' 과도 일치할 수 있고 특정 범위가 값을 포함하는지도 검사할 수 있습니다. `switch` 문에서 이 다양한 타입의 값을 사용하는 방법은, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 장의 [Switch (Switch 문)]({% post_url 2020-06-10-Control-Flow %}#switch-switch-문) 부분을 참고하기 바랍니다.

'`switch` 문의 case 절' 은 각 '유형 (pattern)' 뒤에 `where` 절을 담고 있을 수 있습니다. _where 절 (where clause)_ 은 `where` 키워드와 그 뒤의 표현식으로 도입하며, 'case 절' 의 유형이 _제어 표현식 (control expression)_ 과 일치함을 고려하기 전에 추가적인 조건을 제공하고자 사용합니다. `where` 절이 있으면, _제어 표현식 (control expression)_ 값이 'case 절' 유형 중 하나와 일치하면서 `where` 절의 표현식이 `true` 라고 평가할 때만 연관된 'case 절' 안의 _구문 (statements)_ 을 실행합니다. 예를 들어, 아래 예제에 있는 'case 절' 은, `(1, 1)` 같이, 똑같은 값의 두 원소를 담은 튜플일 때만 _제어 표현식 (control expression)_ 과 일치합니다.

```switch
case let (x, y) where x == y:
```

위 예제에서 보는 것처럼, 'case 절' 의 유형은 `let` 키워드로 상수와 연결할 수도 있습니다 (`var` 키워드로 변수와 연결할 수도 있습니다). 그러면 이 상수 (나 변수) 들이 관련된 `where` 절 및 'case 절' 영역 안의 나머지 코드 전반에 걸쳐 참조될 수 있습니다. 제어 표현식과 일치하는 여러 개의 유형을 'case 절' 이 담고 있는 경우, 모든 패턴이 반드시 똑같은 상수나 '변수 연결' 을 담고 있어야 하며, 각각의 연결된 변수나 상수는 모든 'case 절' 유형에서 반드시 똑같은 타입을 가져야 합니다.

`switch` 문은, `default` 키워드로 도입하는, '기본 (default) case 절' 을 포함할 수도 있습니다. '기본 case 절' 안의 코드는 제어 표현식과 일치하는 다른 'case 절' 이 없는 경우에만 실행합니다. `switch` 문은 단 하나의 '기본 case 절' 을 포함할 수 있으며, 이는 반드시 `switch` 문의 끝에 있어야 합니다.

비록 '유형-맞춤 (pattern-matching)' 연산의 실제 실행 순서와, 'case 절' 유형의 평가 순서는 특별히, 지정되어 있지 않을지라도, `switch` 문의 '유형 맞춤 (pattern matching)' 은 마치 평가를 소스 순서대로-즉, 소스 코드에 나타나는 순서대로-수행하는 것 같이 동작합니다. 그 결과, 똑같은 값으로 평가되는, 따라서 제어 표현식 값과 일치하는, 유형을 담은 'case 절' 이 여러 개인 경우, 프로그램은 소스 순서대로 맨 처음 일치하는 'case 절' 의 코드만 실행합니다.

**Switch Statements Must Be Exhaustive (switch 문은 반드시 빠짐없이 철저해야 합니다)**

스위프트에서, '제어 표현식' 타입으로 가능한 모든 값은 최소 'case 절' 의 한 유형과는 반드시 일치해야 합니다. 이의 실현이 (예를 들어, 제어 표현식의 타입이 `Int` 일 때 처럼) 단순치 않을 때는, '필수 조건' 을 만족하도록 '기본 case 값' 을 포함할 수 있습니다.

<p>
<strong id="switching-over-future-enumeration-cases-미래의-열거체-case-값에-대해-전환-switching-하기">Switching Over Future Enumeration Cases (미래의 '열거체 case 값' 에 대해 전환 (switching) 하기)</strong>
</p>

_동결되지 않은 열거체 (nonfrozen enumeration)_ 는-심지어 앱을 엮어서 출하한 후인-미래에도 새로운 '열거체 case 값' 을 가질 수도 있는 특수한 종류의 열거체입니다. '동결되지 않은 열거체' 를 전환 (switching) 하려면 '부가적인 주의' 가 필요합니다. 라이브러리 작성자가 '동결되지 않은 (nonfrozen) 열거체' 라고 표시할 때는, 새로운 '열거체 case 값' 을 추가할 권리를 예약한 것이며, 해당 열거체와 상호 작용하는 어떤 코드든 _반드시 (must)_ 재컴파일 없이 이 미래의 'case 값' 들을 처리할 수 있어야 합니다. '라이브러리 진화 모드'[^library-evolution-mode] 로 컴파일된 코드, 표준 라이브러리에 있는 코드, '애플 프레임웍' 을 '스위프트로 덧씌운 것 (Swift overlays)'[^swift-overlays], 그리고 C 와 오브젝티브-C 코드가 '동결되지 않은 열거체' 를 선언할 수 있습니다. '동결된 열거체' 와 '동결되지 않은 열거체' 에 대한 정보는, [frozen (동결)]({% post_url 2020-08-14-Attributes %}#frozen-동결) 부분을 참고하기 바랍니다.

'동결되지 않은 열거체' 의 값을 전환할 때는, 열거체의 모든 'case 값' 이 이미 관련 'switch 문 case 절' 을 가지고 있는 경우에도, 항상 '기본 case 절' 을 포함할 필요가 있습니다. '기본 case 절' 은, 이미래에 추가되는 '열거체 case 값' 과만 일치해야 함을 지시하도록, '기본 case 절' 에 `@unknown` 속성을 적용할 수 있습니다. 스위프트는 '기본 case 절' 이 컴파일 시간에 알고 있는 '어떤 열거체 case 값' 과 일치할 경우 경고를 만들어 냅니다. 이런 '미래 경고' 는 라이브러리 작성자가 열거체에 '관련 switch 문 case 절' 을 가지지 않은 새로운 'case 값' 을 추가했음을 알려줍니다.

다음 예제는 표준 라이브러리에 있는 [Mirror.AncestorRepresentation](https://developer.apple.com/documentation/swift/mirror/ancestorrepresentation) 열거체의 모든 세 '기존 case 값' 에 대해 전환합니다. 미래에 '추가적인 case 값' 을 추가하면, '새로운 case 값' 을 고려하도록 'switch 문' 을 갱신할 필요가 있다고 지시하는 경고를 컴파일러가 발생합니다.

```swift
let representation: Mirror.AncestorRepresentation = .generated
switch representation {
case .customized:
    print("Use the nearest ancestor’s implementation.")
case .generated:
    print("Generate a default mirror for all ancestor classes.")
case .suppressed:
    print("Suppress the representation of all ancestor classes.")
@unknown default:
    print("Use a representation that was unknown when this code was compiled.")
}
// "Generate a default mirror for all ancestor classes." 를 인쇄합니다.
```

**Execution Does Not Fall Through Cases Implicitly (실행은 case 절을 암시적으로 뚫고 가지 않습니다)**

'일치한 case 절' 안의 코드 실행을 종료한 후에는, 프로그램이 `switch` 문을 빠져나갑니다. 프로그램 실행은 '그 다음 case 절' 이나 '기본 case 절' 에서 계속하거나 "뚫고 가지 (fall through)" 않습니다. 그건 그렇고, 실행이 '한 case 절' 에서 그 다음으로 계속되길 원하면, 명시적으로 실행을 계속할 'case 절' 에, 단순히 `fallthrough` 키워드로 구성하는, '`fallthrough` 문' 을 포함시킵니다. `fallthrough` 문에 대한 더 많은 정보는, 아래의 [Fallthrough Statement ('fallthrough' 문)](#fallthrough-statement-fallthrough-문) 부분을 참고하기 바랍니다.

> GRAMMAR OF A SWITCH STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID434)

### Labeled Statement (이름표 달린 구문)

반복문, `if` 문, `switch` 문, 또는 `do` 문은, 이름표와 바로 뒤의 콜론 (`:`) 으로 구성된, _구문 이름표 (statement label)_ 를 접두사로 가질 수 있습니다.  
반복문이나 `switch` 문에서 제어 흐름을 어떻게 바꾸고 싶은 지를 명시하려면, 아래의 [Break Statement ('break' 문)](#break-statement-break-문) 및 [Continue Statement ('continue' 문)](#continue-statement-continue-문) 에서 설명한 것처럼, `break` 문과 `continue` 문에서 '구문 이름표 (statement label)' 를 사용하면 됩니다.

'이름표 달린 구문 (labeled statement)' 의 영역은 '구문 이름표' 뒤의 전체 구문입니다. '이름표 달린 구문' 은 중첩할 수 있지만, 각각의 '구문 이름표' 는 반드시 유일해야 합니다.

더 자세한 정보와 구문 이름표를 사용하는 방법에 대한 예제는, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에 있는 [Labeled Statements (이름표를 단 구문)]({% post_url 2020-06-10-Control-Flow %}#labeled-statements-이름표를-단-구문) 을 참고하기 바랍니다.

> GRAMMAR OF A LABELED STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID439)

### Control Transfer Statements (제어 전달문)

'제어 전달문 (control transfer statements)' 은 '프로그램 제어' 를 코드 한 곳에서 또 다른 곳으로 무조건적으로 전달하여 프로그램에서 코드의 실행 순서를 바꿀 수 있습니다. 스위프트는 다섯 가지의 제어 전달 구문을 가지고 있습니다: `break` 문, `continue` 문, `fallthrough` 문, `return` 문, 그리고 `throw` 문이 그것입니다.

> GRAMMAR OF A CONTROL TRANSFER STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID440)

#### Break Statement ('break' 문)

`break` 문은 반복문, `if` 문, 또는 `switch` 문의 프로그램 실행을 종료합니다. `break` 문은, 아래에서 보는 것처럼, `break` 키워드로만 구성하거나, `break` 키워드와 그 뒤의 '구문 이름표 (statement label)' 이름으로 구성할 수 있습니다.

break
<br />
break `label name-이름표 이름`

`break` 문 뒤에 '구문 이름표' 이름이 있을 때는, 해당 이름표로 이름을 붙인 반복문, `if` 문, 또는 `switch` 문의 프로그램 실행을 종료합니다.

`break` 문 뒤에 '구문 이름표' 이름이 없을 때는, 자기가 있는 `switch` 문 또는 가장 안쪽에서 둘러싼 반복문의 프로그램 실행을 종료합니다. 이름표가 없는 `break` 문을 사용하여 `if` 문을 끊고 나올 수는 없습니다.

두 경우 모두, 프로그램 제어를 둘러싼 반복문이나 `switch` 문 뒤의 코드, 만약에 있다면, 첫 번째 줄로 전달합니다.

`break` 문을 사용하는 방법에 대한 예제는, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에 있는 [Break (break 문)]({% post_url 2020-06-10-Control-Flow %}#break-break-문) 과 [Labeled Statements (이름표를 단 구문)]({% post_url 2020-06-10-Control-Flow %}#labeled-statements-이름표를-단-구문) 을 참고하기 바랍니다.

> GRAMMAR OF A BREAK STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID440)

#### Continue Statement ('continue' 문)

`continue` 문은 반복문의 현재 회차에 대한 프로그램 실행을 종료하지만 반복문의 실행은 종료하지 않습니다. `continue` 문은, 아래에서 보는 것처럼, `continue` 키워드로만 구성하거나, `continue` 키워드와 그 뒤의 '구문 이름표' 이름으로 구성할 수 있습니다.

continue
<br />
continue `label name-이름표 이름`

`continue` 문 뒤에 '구문 이름표' 이름이 있을 때는, 해당 이름표로 이름을 붙인 반복문의 현재 회차에 대한 프로그램 실행을 종료합니다.

`continue` 문 뒤에 '구문 이름표' 이름이 없을 때는, 자기를 가장 안쪽에서 둘러싼 반복문의 프로그램 실행을 종료합니다.

두 경우 모두, 자기를 둘러싼 반복문의 조건문으로 프로그램 제어를 전달합니다.

`for` 문에서, `continue` 문을 실행한 후에도 '증가 표현식 (increment expression)' 은 여전히 평가되는데, 이는 '증가 표현식' 이 반복문의 본문을 실행한 후에 평가되기 때문입니다.

`continue` 문을 사용하는 방법에 대한 예제는, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에 있는 [Continue (Continue 문)]({% post_url 2020-06-10-Control-Flow %}#continue-continue-문) 과 [Labeled Statements (이름표를 단 구문)]({% post_url 2020-06-10-Control-Flow %}#labeled-statements-이름표를-단-구문) 을 참고하기 바랍니다.

> GRAMMAR OF A CONTINUE STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID440)

#### Fallthrough Statement ('fallthrough' 문)

`fallthrough` 문은 `fallthrough` 키워드로 구성되며 `switch` 문의 'case 절' 블럭에서만 발생합니다. `fallthrough` 문은 프로그램 실행을 `switch` 문의 한 'case 절' 에서 그 다음 'case 절' 로 계속하도록 합니다. 프로그램 실행은 심지어 'case 절' 이름표의 패턴이 `switch` 문의 제어 표현식에 있는 값과 일치하지 않더라도 그 다음 'case 절' 로 계속됩니다.

`fallthrough` 문은 'case 절' 블럭의 마지막 구문으로써만이 아니라, `switch` 문 내부의 어디에서나 있을 수 있지만, 최종 'case 절' 블럭에서는 사용할 수 없습니다. 이는 또 프로그램 제어를 '값 연결 패턴 (value binding patterns)' 을 가지고 있는 패턴으로 전달할 수는 없습니다.

`switch` 문에서 `fallthrough` 문을 사용하는 방법에 대한 예제는, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에 있는 [Control Transfer Statements (제어 전달문)]({% post_url 2020-06-10-Control-Flow %}#control-transfer-statements-제어-전달문) 을 참고하기 바랍니다.

> GRAMMAR OF A FALLTHROUGH STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID440)

#### Return Statement ('return' 문)

`return` 문은 함수나 메소드 정의의 본문에 둬서 프로그램 실행을 호출한 쪽의 함수나 메소드로 반환하도록 합니다. 프로그램 실행은 함수나 메소드 호출의 바로 그 다음 지점에서 계속됩니다.

`return` 문은, 아래에서 보는 것처럼, `return` 키워드로만 구성하거나, `return` 키워드와 그 뒤의 표현식으로 구성할 수 있습니다.

return
<br />
return `expression-표현식`

`return` 문 뒤에 표현식이 있을 때는, 이 표현식의 값이 호출한 함수 또는 메소드로 반환됩니다. 만약 표현식의 값이 함수나 메소드 선언에서 선언한 반환 타입의 값과 일치하지 않으면, 표현식의 값은 호출한 함수나 메소드로 반환되기 전에 해당 반환 타입으로 변환됩니다.

> [Failable Initializers (실패 가능한 초기자)]({% post_url 2020-08-15-Declarations %}#failable-initializers-실패-가능한-초기자) 에서 설명한 것처럼, 초기화의 실패를 지시하기 위해 '실패 가능한 초기자' 에서는  특수한 형식의 `return` 문인 (`return nil`) 을 사용할 수 있습니다.

`return` 문 뒤에 표현식이 없을 때는, 값을 반환하지 않는 함수 또는 메소드의 반환에서만 사용할 수 있습니다 (이는, 함수나 메소드의 반환 타입이 `Void` 또는 `()` 일 때입니다).

> GRAMMAR OF A RETURN STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID440)

#### Throw Statement ('throw' 문)

`throw` 문은 타입을 `throws` 키워드로 표시한 '던지는 함수 (throwing function)' 이나 '던지는 메소드' 의 본문, 및 클로저 표현식의 본문에 둡니다.

`throw` 문은 프로그램이 현재 영역의 실행을 종료하도록 하고 자신을 둘러싼 영역으로 에러 전파를 시작하도록 합니다. 던져진 에러는 `do` 문의 `catch` 절에서 처리할 때까지 계속 전파됩니다.

`throw`, 아래에서 보는 것처럼, `throw` 키워드와 그 뒤의 표현식으로 구성됩니다.

throw `expression-표현식`

_표현식 (expression)_ 의 값은 반드시 `Error` 프로토콜을 준수하는 타입이어야 합니다.

`throw` 문을 사용하는 방법에 대한 예제는, [Error Handling (에러 처리)]({% post_url 2020-05-16-Error-Handling %}) 에 있는 [Propagating Errors Using Throwing Functions ('던지는 함수' 를 사용하여 에러 전파하기)]({% post_url 2020-05-16-Error-Handling %}#propagating-errors-using-throwing-functions-던지는-함수-를-사용하여-에러-전파하기) 를 참고하기 바랍니다.

> GRAMMAR OF A THROW STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID440)

### Defer Statement ('defer' 문)

`defer` 문은 `defer` 문이 있는 영역 밖으로 프로그램 제어를 전달하기 바로 직전에 코드를 실행하기 위해서 사용합니다.

`defer` 문의 형식은 다음과 같습니다:

defer {<br />
  `statements-구문`<br />
}

`defer` 문 내에 있는 구문들은 프로그램 제어가 전달되는 방식과는 상관없이 실행됩니다. 이것은 , 예를 들어, '파일 서술자 (file descriptors)'[^file-discriptors] 닫기 같은 '수동 자원 관리 (manual resource management)' 를 수행하고, 에러를 던지더라도 해야할 필요가 있는 행동을 수행하기 위해 `defer` 문을 사용할 수 있다는 것을 의미합니다.

같은 영역에 여러 개의 `defer` 문이 있는 경우, 나타난 순서와 실행 순서는 반대입니다. 주어진 영역에서 마지막 `defer` 문이 먼저 실행된다는 것은 마지막 `defer` 문 안에 있는 구문은 다른 `defer` 문에서 정리할 자원도 참조할 수 있다는 것을 의미합니다.

```swift
func f() {
    defer { print("First defer") }
    defer { print("Second defer") }
    print("End of function")
}
f()
// "End of function" 를 출력합니다.
// "Second defer" 를 출력합니다.
// "First defer" 를 출력합니다.
```

`defer` 문에 있는 구문이 프로그램 제어를 `defer` 문 밖으로 전달할 수는 없습니다.

> GRAMMAR OF A DEFER STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID532)

### Do Statement ('do' 문)

'`do` 문' 은 새로운 영역을 도입하기 위해 사용하며, 정의된 에러 조건과 일치 여부를 맞춰보는 '유형 (pattern)' 을 담은, 하나 이상의 `catch` 절을 선택적으로 가질 수 있습니다. `do` 문의 영역에서 선언한 변수와 상수는 해당 영역 내에서만 접근할 수 있습니다.

스위프트의 `do` 문은 코드 블럭의 경계를 구분하기 위해 사용하는 C 언어의 '중괄호 (curly; `{}`)' 와 비슷하며, 실행 시간에 성능 비용이 발생하지 않습니다.

`do` 문의 형식은 다음과 같습니다:

do {<br />
&nbsp;&nbsp;&nbsp;&nbsp;try `expression-표현식`<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
} catch `pattern 1-유형 1` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
} catch `pattern 2-유형 2` where `condition-조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
} catch `pattern 3-유형 3`, `pattern 4-유형 4` where `condition-조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
} catch {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
}

`do` 코드 블럭 내의 어떤 구문이든 에러를 던지면, 프로그램 제어는 '유형 (pattern)' 이 에러와 일치하는 첫 번째 '`catch` 절' 로 전달됩니다. 일치하는 절이 없으면, 에러를 주위 영역으로 전파합니다. 에러가 최상위 수준까지 처리되지 않으면, 실행 시간 에러와 함께 프로그램 실행을 중지합니다.

`switch` 문과 같이, 컴파일러는 `catch` 절이 '빠짐없이 철저한 (exhaustive)' 지를 추론하려고 합니다. 그렇다고 결정할 수 있으면, 에러는 처리된 것으로 여깁니다. 다른 경우라면, 에러는 이를 담고 있는 영역 밖으로 전파할 수 있는 것으로, 이는 이를 둘러싼 '둘러싼 `catch` 절' 에서 에러를 반드시 처리하거나 아니면 이를 담고 있는 함수를 반드시 `throws` 로 선언해야 함을 의미합니다.

'다중 유형 (multiple patterns)' 을 가진 `catch` 절은 '유형 (patterns)' 중 어떤 것이라도 에러와 일치하면 에러와 일치합니다. `catch` 절이 '다중 유형 (multipe patterns)' 을 담고 있으면, 모든 '유형 (patterns)' 들이 반드시 똑같은 상수 또는 변수 '연결 (bindings)' 을 담고 있어야 하며, 각각의 연결된 변수 또는 상수는 모든 `catch` 절의 '유형 (patterns)' 에서 반드시 똑같은 타입을 가지고 있어야 합니다.

에러가 처리된다는 것을 보장하려면, '와일드카드 패턴 (wildcard pattern; `_`)' 같이, 모든 에러와 일치하는 '유형 (patterns)' 을 가진 `catch` 절을 사용하면 됩니다. `catch` 절이 패턴을 지정하지 않으면, 이 `catch` 절은 어떤 에러와도 일치하며 이를 `error` 라는 이름의 지역 상수에 연결합니다. `catch` 절에서 사용할 수 있는 패턴에 대한 더 많은 정보는, [Patterns (패턴; 유형)]({% post_url 2020-08-25-Patterns %}) 을 참고하기 바랍니다.

여러 개의 `catch` 절을 가진 `do` 문을 사용하는 방법에 대한 예제를 보려면, [Handling Errors (에러 처리하기)]({% post_url 2020-05-16-Error-Handling %}#handling-errors-에러-처리하기) 를 참고하기 바랍니다.

> GRAMMAR OF A DO STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID533)

### Compiler Control Statements (컴파일러 제어문)

'컴파일러 제어문 (compiler control statements)' 는 프로그램이 컴파일러의 작동 방식을 바꿀 수 있게 해줍니다. 스위프트는 세 개의 컴파일러 제어문을 가지고 있습니다: '조건부 컴파일 블럭 (conditional compilation block)', '라인 제어문 (line control statement)', 그리고 '컴파일-시간 진단문 (compile-time diagnostic statement)' 가 그것입니다.

> GRAMMAR OF A COMPILER CONTROL STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID538)

#### Conditional Compilation Block (조건부 컴파일 블럭)

'조건부 컴파일 블럭 (conditional compile block)' 은 하나 이상의 컴파일 조건 값에 따라 코드를 조건부로 컴파일하게 해줍니다.

모든 조건부 컴파일 블럭은 `#if` '컴파일 지시자 (compilation directive)' 로 시작해서 `#endif` 컴파일 지시사로 끝납니다. 단순 조건부 컴파일 블럭의 형식은 다음과 같습니다:

\#if `compilation condition-컴파일 조건`<br />
  `statements-구문`<br />
\#endif

`if` 문의 조건과는 다르게, _컴파일 조건 (compile condition)_ 은 컴파일 시간에 값을 평가합니다. 그 결과, 컴파일 시간에 _컴파일 조건 (compile condition)_  이 `true` 라고 평가될 때만 _구문 (statements)_ 을 컴파일하고 실행합니다.

_컴파일 조건 (compile condition)_ 은 `true` 및 `false` 불리언 글자 값, `-D` '명령 줄 깃표 (command line flag)'[^flag] 와 함께 사용된 식별자, 또는 아래 표에서 나열한 어떤 '플랫폼 조건 (platform)' 을 포함할 수 있습니다.

**Platform condition (플랫폼 조건)** || **Valid arguments (유효한 인자)**
---|---|---
`os()` || `macOS`, `iOS`, `watchOS`, `tvOS`, `Linux`
`arch()` || `i386`, `x86_64`, `arm`, `arm64`
`swift()` || `>=` 또는 `<` 와 그 뒤의 버전 번호
`compiler()` || `>=` 또는 `<` 와 그 뒤의 버전 번호
`canImport()` || 모듈 이름
`targetEnvironment()` || `simulator`, `macCatalyst`

`swift()` 와 `compiler()` 에 대한 버전 번호는, 버전 번호의 각 부분을 구분하는 점 (`.`) 과 함께, '주요 번호 (major number)', 선택 사항인 '부수 번호 (minor number)', 선택 사항인 '덧댐 번호 (patch number)', 등등으로 구성됩니다. '비교 연산자 (comparison operator)' 와 '버전 번호' 사이에는 반드시 공백이 없어야 합니다. `compiler()` 에 대한 버전은, 컴파일러에 전달된 '스위프트 버전 설정' 과 관계없는, 컴파일러 버전입니다.[^Swift-version-setting] `swift()` 에 대한 버전은 현재 컴파일하고 있는 언어 버전입니다. 예를 들어, 스위프트 5 컴파일러를 사용하면서 스위프트 4.2 모드로 컴파일하는 경우, '컴파일러 버전' 은 '5' 이고 '언어 버전' 은 '4.2' 입니다. 이렇게 설정하면, 다음 코드는 세 개의 메시지를 모두 출력합니다:

```swift
#if compiler(>=5)
print("Compiled with the Swift 5 compiler or later")
#endif
#if swift(>=4.2)
print("Compiled in Swift 4.2 mode or later")
#endif
#if compiler(>=5) && swift(<5)
print("Compiled with the Swift 5 compiler or later in a Swift mode earlier than 5")
#endif
// "Compiled with the Swift 5 compiler or later" 를 출력합니다.
// "Compiled in Swift 4.2 mode or later" 를 출력합니다.
// "Compiled with the Swift 5 compiler or later in a Swift mode earlier than 5" 를 출력합니다.
```

`canImport()` 플랫폼 조건에 대한 인자는 모든 플랫폼에 존재하지는 않을 수도 있는 모듈의 이름입니다. 이 조건은 모듈을 불러오는 것이 가능한지 검사하지만, 실제로 불러오는 것은 아닙니다. 해당 모듈이 있는 경우, 플랫폼 조건은 `true` 를 반환합니다; 다른 경우라면, `false` 를 반환합니다.

`targetEnvironment()` 플랫폼 조건은 코드를 시뮬레이터 용으로 컴파일할 때 `true` 를 반환합니다; 다른 경우라면, `false` 를 반환합니다.

> `arch(arm)` 플랫폼 조건은 'ARM 64' 기기에 대해서 `true` 를 반환하지는 않습니다. `arch(i386)` 플랫폼 조건은 코드를 '32-비트 iOS 시뮬레이터' 용으로 컴파일할 때 `true` 를 반환합니다.

논리 연산자인 `&&`, `||`, 및 `!` 와 그룹화를 위한 괄호를 사용하여 컴파일 조건을 조합할 수 있습니다. 이 연산자들은 일상적인 불리언 표현식을 조합하는데 사용하는 논리 연산자와 같은 '결합성 (associativity)' 과 '우선순위 (precedence)' 를 가지고 있습니다.

`if` 문과 비슷하게, 서로 다른 컴파일 조건을 검사하기 위해 '다중 조건 분기 (multiple conditional branches)' 를 추가할 수 있습니다. `#elseif` 절을 사용하면 어떤 개수로든 추가적인 분기를 추가할 수 있습니다. `#else` 절을 ​​사용하면 최종적인 추가 분기를 추가 할 수 있습니다. '다중 분기' 를 가지고 있는 '조건부 컴파일 블럭' 의 형식은 다음과 같습니다:

\#if `compilation condition 1-컴파일 조건 1`<br />
`statements to compile if compilation condition 1 is true-컴파일 조건 1이 참일 때 컴파일하는 구문`<br />
\#elseif `compilation condition 2-컴파일 조건 2`<br />
`statements to compile if compilation condition 2 is true-컴파일 조건 2가 참일 때 컴파일하는 구문`<br />
\#else<br />
`statements to compile if both compilation conditions are false-두 컴파일 조건 모두 거짓일 때 컴파일하는 구문`<br />
\#endif

> '조건부 컴파일 블럭' 의 본문에 있는 각각의 구문은 컴파일되지 않는 경우에도 해석됩니다. 하지만, 컴파일 조건이 `swift()` 플랫폼 조건을 포함하고 있는 경우는 예외입니다: 이 구문은 컴파일러의 스위프트 버전이 플랫폼 조건서 지정한 것과 일치하는 경우에만 해석됩니다. 이런 예외는 새 버전의 스위프트에서 도입한 '구문 표현 (syntax)' 을 더 예전 컴파일러가 해석하지 않도록 보장합니다.

> GRAMMAR OF A CONDITIONAL COMPILATION BLOCK 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID538)

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

#### Compile-Time Diagnostic Statement (컴파일-시간 진단문)

'컴파일-시간 진단문 (compile-time diagnostic statement)' 은 컴파일러가 컴파일 중에 에러나 경고를 내도록 유발합니다. 컴파일-시간 진단문의 형식은 다음과 같습니다:

\#error("`error message-에러 메시지`")<br />
\#warning("`warning message-경고 메시지`")

첫 번째 형식은 _에러 메시지 (error message)_ 를 '치명적인 오류 (fatal error)' 로 내보내며 컴파일 과정을 종결합니다. 두 번째 형식은 _경고 메시지 (warning message)_ 를 '치명적이지 않은 경고 (nonfatal warning)' 로 내보내며 컴파일은 계속 진행하도록 허용합니다. '진단 메시지 (diagnostic message)' 는 '정적 문자열 글자 값 (static string literal)' 으로 작성합니다. '정적 문자열 글자 값' 은 문자열 '보간 (interpolation)' 이나 '이음 (concatenation)' 같은 특징을 사용할 수 없지만, '여러 줄짜리 문자열 글자 값 구문 표현 (multiline string literal syntax)' 은 사용할 수 있습니다.

> GRAMMAR OF A COMPILE-TIME DIAGNOSTIC STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID538)

### Availability Condition (사용 가능성 조건)

_사용 가능성 조건 (availablility condition)_ 은, 지정한 플랫폼 인자를 기반으로, 실행 시간에 API 의 사용 가능성을 조회하기 위해 `if`, `while`, 및 `guard` 문의 조건으로 사용되는 것입니다.

사용 가능성 조건의 형식은 다음과 같습니다:

if #available(`platform name-플랫폼 이름` `version-버전`, `...`, *) {<br />
  `statements to execute if the APIs are available-API 가 사용 가능하면 실행할 구문`<br />
} else {<br />
  `fallback statements to execute if the APIs are unavailable-API 가 사용 불가능하면 실행할 대체 구문`<br />
}

'사용 가능성 조건' 은, 사용하고 싶은 API 가 실행 시간에 사용 가능한 지에 따라, 코드 블럭을 실행하기 위해 사용합니다. 컴파일러는 해당 코드 블럭에 있는 API 가 사용 가능한 지를 증명할 때 사용 가능성 조건의 정보를 사용합니다.

'사용 가능성 조건' 은 플랫폼 이름과 버전으로 된 것을 쉼표로 구분한 목록을 받아 들입니다. 플랫폼 이름으로는 `iOS`, `macOS`, `watchOS`, 와 `tvOS` 를 사용하며, 연관된 버전 번호를 포함합니다. `*` 인자는 필수인데, '사용 가능성 조건' 이 보호하고 있는 코드 블럭이 최소 배포 대상으로 지정한, 어떤 플랫폼에서라도 실행되도록 지정합니다.

불리언 조건과는 다르게, `&&` 와 `||` 같은 논리 연산자를 사용하여 '사용 가능성 조건' 을 조합할 수는 없습니다.

> GRAMMAR OF AN AVAILABILITY CONDITION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID522)

### 참고 자료

[^Statements]: 원문은 [Statements](https://docs.swift.org/swift-book/ReferenceManual/Statements.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^scalar-types]: '크기 타입 (scalar types)' 은 수학에서 사용하는 용어인 '스칼라량 (scalar)' 과 비슷하게, 크기 값만 가지고 있는 타입입니다.

[^library-evolution-mode]: '라이브러리 진화 모드 (library evolution mode)' 는 스위프트로 '바이너리 프레임웍' 을 생성할 때 사용할 수 있는 옵션으로 추측됩니다. '라이브러리 진화 모드' 에 대한 더 자세한 정보는, [Library Evolution in Swift](https://swift.org/blog/library-evolution/) 항목을 참고하기 바랍니다. 

[^swift-overlays]: 여기서 '스위프트로 덧씌운 것 (Swift overlays)' 은, 예를 들어, `Foundation` 같은 애플 프레임웍을 사용할 때, 오브젝티브-C 등으로 작성된 타입을 스위프트로 '연동 (bridge)' 하여 사용할 수 있게 해주는 것을 말합니다. '스위프트로 덧씌운 것 (Swift overlays)' 에 대한 더 자세한 내용은 [Working with Foundation Types](https://developer.apple.com/documentation/swift/imported_c_and_objective-c_apis/working_with_foundation_types) 항목을 참고하기 바랍니다. 

[^file-discriptors]: 'file descriptors' 는 '파일 서술자' 라고 하는데, POSIX 운영 체제에서 특정 파일에 접근하기 위한 추상적인 키를 말하는 컴퓨터 용어라고 합니다. 보다 자세한 내용은 위키피디아의 [File descriptor](https://en.wikipedia.org/wiki/File_descriptor) 와 [파일 서술자](https://ko.wikipedia.org/wiki/파일_서술자) 를 참고하기 바랍니다.

[^flag]: '명령 줄 깃표 (command line flag)' 는 '비트 필드' 의 한 비트를 `On`/`Off` 하여 프로그램에 약속된 신호를 남기기 위해 사용하는 미리 정의된 비트를 말합니다. 보다 자세한 내용은 위키피디아의 [플래그](https://ko.wikipedia.org/wiki/플래그) 와 [비트 필드](https://ko.wikipedia.org/wiki/비트_필드) 항목을 참고하기 바랍니다.

[^Swift-version-setting]: 이것은 '스위프트 컴파일러 버전' 과 '소스 코드 상의 스위프트 언어 버전' 이 다를 수 있기 때문입니다. 예를 들어, 새로운 컴파일러를 설치한 후에 예전 소스 코드를 컴파일할 경우, '스위프트 버전 설정' 은 예전 버전으로 두면서 컴파일은 최신 버전으로 할 수도 있습니다.
