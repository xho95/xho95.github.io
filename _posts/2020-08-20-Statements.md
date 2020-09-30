---
layout: post
comments: true
title:  "Swift 5.3: Statements (구문)"
date:   2020-08-20 11:30:00 +0900
categories: Swift Language Grammar Statement
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Statements](https://docs.swift.org/swift-book/ReferenceManual/Statements.html) 부분[^Statements]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 스위프트 5.3 에 대한 내용이 다시 일부 수정되어서,[^swift-update] 추가된 내용 먼저 옮기고 나머지 부분을 옮기도록 합니다. 전체 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Statements (구문)

스위프트에는, 세 가지 종류의 구문이 있습니다: '단순 구문 (simple statements)', '컴파일러 제어문 (compiler control statements)', 그리고 '제어 흐름문 (control flow statements)' 이 그것입니다. '단순 구문' 은 가장 공통된 것으로 표현식 또는 선언으로 구성됩니다. '컴파일러 제어문' 은 프로그램이 컴파일러의 작동 방식을 바꾸도록 해주며 '조건부 컴파일 블럭 (conditional compilation block)' 및 '라인 제어문 (line control statement)' 을 포함합니다.

'제어 흐름문' 은 프로그램에 있는 실행 흐름을 제어하기 위해 사용합니다. 스위프트에는, '반복문 (loop statements)', '분기문 (branch statements)', 및 '제어 전달문 (control transfer statements)' 을 포함하여, 여러가지 타입의 제어 흐름문이 있습니다. '반복문' 은 코드 블럭을 반복해서 실행하도록 해주며, '분기문' 은 정해진 코드 블럭이 정해진 조건을 만날 때만 실행되도록 해주며, '제어 전달문' 은 코드의 실행 순서를 부분적으로 바꾸는 방법을 제공합니다. 여기에 더하여, 스위프트는 영역을 도입해서, 에러를 잡아내고 처리하는 `do` 구문, 및 현재 영역을 빠져나가기 바로 직전에 정리 작업을 실행하는 `defer` 문을 제공합니다.

'세미콜론 (semicolon; `;`)' 은 어떤 구문 뒤에든 선택적으로 붙일 수 있으며 다중 구문이 같은 줄에 있는 경우 이를 구분하는 데 사용합니다.

> GRAMMAR OF A STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html)

### Loop Statements (반복문)

반복문은, 반복문에서 지정한 조건에 따라, 코드 블럭을 반복해서 실행하게 해줍니다. 스위프트는 세 가지의 반복문을 가지고 있습니다; 이는 `for`-`in` 문, `while` 문, `repeat`-`while` 문입니다.

반복문의 제어 흐름은 `break` 문과 `continue` 문으로 바꿀 수 있으며 이는 아래의 [Break Statement ('break' 문)](#break-statement-break-문) 및 [Continue Statement ('continue' 문)](#continue-statement-continue-문) 에서 설명합니다.

> GRAMMAR OF A LOOP STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID429)

#### For-In Statement ('for-in' 문)

`for`-`in` 문은 [Sequence](https://developer.apple.com/documentation/swift/sequence) 프로토콜을 준수하는 컬렉션 (또는 어떤 타입) 의 각 항목마다 코드 블럭을 한 번씩 실행하도록 해줍니다.

`for`-`in` 문의 형식은 다음과 같습니다:

for `item-항목` in `collection-컬렉션/집합체` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
}

`makeIterator()` 메소드를 호출하여 _컬렉션 (collection)_ 표현식에 대한 '반복자 타입 (iterator type)'-즉, [IteratorProtocol](https://developer.apple.com/documentation/swift/iteratorprotocol) 프로토콜을 준수하는 타입-인 값을 구합니다. 프로그램은 반복자에 대해서 `next()` 메소드를 호출하는 것으로 반복문의 실행을 시작합니다. 반환 값이 `nil` 이 아닌 경우, 이를 _항목 (item)_ '유형 (pattern)' 에 할당하고, 프로그램은 _구문 (statements)_ 을 실행한 다음, 반복문의 맨 처음에서 실행을 계속합니다. 다른 경우라면, 프로그램은 할당을 수행하거나 _구문 (statements)_ 을 실행하지 않고, `for`-`in` 문의 실행을 종료합니다.

> GRAMMAR OF A FOR-IN STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html)

#### While Statement ('while' 문)

`while` 문은, 조건이 참으로 남아 있는 한, 반복해서 코드 블럭을 실행하도록 해줍니다.

`while` 문의 형식은 다음과 같습니다:

while `condition-조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
}

`while` 문은 다음 처럼 실행합니다:

1. _조건 (condition)_ 을 평가합니다.

  `true` 이면, 실행을 2 단계로 계속합니다. `false` 면, 프로그램은 `while` 문의 실행을 종료합니다.

2. 프로그램은 _구문 (statements)_ 을 실행하고, 실행은 1 단계로 돌아갑니다.

_조건 (condition)_ 의 값은 _구문 (statements)_ 을 실행하기 전에 평가하기 때문에, `while` 문에 있는 _구문 (statements)_ 은 '0' 번 이상 실행될 수 있습니다.

_조건 (condition)_ 의 값은 반드시 `Bool` 타입이거나 `Bool` 과 '연동된 (bridged)' 타입이어야 합니다. '조건' 은, [Optional Binding (옵셔널 연결; 옵셔널 바인딩)]({% post_url 2016-04-24-The-Basics %}#optional-binding-옵셔널-연결-옵셔널-바인딩) 에서 설명한 것처럼, '옵셔널 연결 선언 (optional binding declaration)' 일 수 있습니다.

> GRAMMAR OF A WHILE STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html)

#### Repeat-While Statement ('repeat'-'while' 문)

`repeat`-`while` 문은, 조건이 참으로 남아 있는 한, 한 번 이상 코드 블럭을 실행하도록 해줍니다.

`repeat`-`while` 문의 형식은 다음과 같습니다:

repeat {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
} while `condition-조건`

`repeat`-`while` 문은 다음 처럼 실행합니다:

1. 프로그램은 _구문 (statements)_ 을 실행하고, 실행을 2 단계로 계속합니다.

2. _조건 (condition)_ 을 평가합니다.

  `true` 이면, 실행은 1 단계로 돌아갑니다. `false` 면, 프로그램은 `repeat`-`while` 문의 실행을 종료합니다.

_조건 (condition)_ 의 값은 _구문 (statements)_ 을 실행한 후에 평가하기 때문에, `repeat`-`while` 문에 있는 _구문 (statements)_ 은 최소한 한 번은 실행됩니다.

_조건 (condition)_ 의 값은 반드시 `Bool` 타입이거나 `Bool` 과 '연동된 (bridged)' 타입이어야 합니다. '조건' 은, [Optional Binding (옵셔널 연결; 옵셔널 바인딩)]({% post_url 2016-04-24-The-Basics %}#optional-binding-옵셔널-연결-옵셔널-바인딩) 에서 설명한 것처럼, '옵셔널 연결 선언 (optional binding declaration)' 일 수 있습니다.

> GRAMMAR OF A REPEAT-WHILE STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html)

### Branch Statements (분기문)

분기문은 하나 이상의 조건 값에 따라 프로그램이 정해진 코드 부분을 실행하도록 해줍니다. 분기문에서 지정한 조건의 값이 프로그램을 어떻게 분기할 지를 제어하며, 따라서, 어떤 코드 블럭을 실행할 지 제어합니다. 스위프트는 세 가지의 분기문을 가지고 있습니다: `if` 문, `guard` 문, 그리고 `switch` 문이 그것입니다.

`if` 문 또는 `switch` 문에 있는 제어 흐름은 `break` 문으로 바꿀 수 있는데 이는 아래의 [Break Statement ('break' 문)](#break-statement-break-문)) 에서 설명합니다.

> GRAMMAR OF A BRANCH STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID434)

#### If Statement ('if' 문)

`if` 문은 하나 이상의 조건을 평가한 것을 기초로 하여 코드를 실행하는 데 사용합니다.

`if` 문의 기본 형식에는 두 가지가 있습니다. 각 형식에서, '여는 중괄호' 와 '닫는 중괄호' 는 필수입니다.

첫 번째 형식은 조건이 참일 때만 코드를 실행하도록 해주며 형식은 다음과 같습니다:

if `condition-조건` {<br />
  `statements-구문`<br />
}

`if` 문의 두 번째 형식은 (`else` 키워드로 도입하는) 추가적인 _else 절 (else clause)_ 을 제공하여 코드 한 부분은 조건이 참일 때 실행하고 코드의 다른 부분은 같은 조건이 거짓일 때 실행합니다. 단 하나의 `else` 절만 있을 때의, `if` 문의 형식은 다음과 같습니다:

if `condition-조건` {<br />
  `statements to execute if condition is true-조건이 참인 경우 실행하는 구문`<br />
} else {<br />
  `statements to execute if condition is false-조건이 거짓인 경우 실행하는 구문`<br />
}

`if` 문의 'else 절' 은 둘 이상의 조건을 테스트하기 위해 또 다른 `if` 문을 가질 수 있습니다. 이러한 식으로 서로 연쇄된 `if` 문의 형식은 다음과 같습니다:

if `condition 1-조건 1` {<br />
  `statements to execute if condition 1 is true-조건 1 이 참인 경우 실행하는 구문`<br />
} else if `condition 2-조건 2` {<br />
  `statements to execute if condition 2 is true-조건 2 이 참인 경우 실행하는 구문`<br />
} else {<br />
  `statements to execute if both conditions are false- 두 조건 모두 거짓인 경우 실행하는 구문`<br />
}

`if` 문에 있는 조건의 값은 어떤 것이든 반드시 `Bool` 타입이거나 `Bool` 과 '연동된 (bridged)' 타입이어야 합니다. '조건' 은, [Optional Binding (옵셔널 연결; 옵셔널 바인딩)]({% post_url 2016-04-24-The-Basics %}#optional-binding-옵셔널-연결-옵셔널-바인딩) 에서 설명한 것처럼, '옵셔널 연결 선언 (optional binding declaration)' 일 수 있습니다.

> GRAMMAR OF A BRANCH STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID434)

#### Guard Statement ('guard' 문)

`guard` 문은 조건이 하나라도 만족하지 않을 경우 프로그램 제어를 영역 밖으로 전달하는데 사용합니다.

`guard` 문의 형식은 다음과 같습니다:

guard `condition-조건` else {<br />
  `statements-구문`<br />
}

`guard` 문에 있는 조건의 값은 어떤 것이든 반드시 `Bool` 타입이거나 `Bool` 과 '연동된 (bridged)' 타입이어야 합니다. '조건' 은, [Optional Binding (옵셔널 연결; 옵셔널 바인딩)]({% post_url 2016-04-24-The-Basics %}#optional-binding-옵셔널-연결-옵셔널-바인딩) 에서 설명한 것처럼, '옵셔널 연결 선언 (optional binding declaration)' 일 수 있습니다.

`guard` 문 조건에 있는 '옵셔널 연결 선언 (optional binding declaration)' 으로 값을 할당한 상수나 변수는 어떤 것이든 'guard 문' 을 둘러싼 나머지 영역에서 사용할 수 있습니다.

`guard` 문의 `else` 절은 필수이며, 반드시 반환 타입이 `Never` 인 함수를 호출하거나 아니면 아래의 구문 중 하나를 사용하여 프로그램 제어를 'guard 문' 을 둘러싼 영역 밖으로 옮겨야 합니다:

* `return`
* `break`
* `continue`
* `throw`

'제어 전달 구문 (control transfer statements)' 은 아래의 [Control Transfer Statements (제어 전달 구문)](#control-transfer-statements-제어-전달-구문) 에서 논의합니다. `Never` 라는 반환 타입을 가지는 함수에 대한 더 많은 정보는, [Functions that Never return ('Never' 를 반환하는 함수)]({% post_url 2020-08-15-Declarations %}#functions-that-never-return-never-를-반환하는-함수) 를 참고하기 바랍니다.

> GRAMMAR OF A GUARD STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID434)

#### Switch Statement ('switch' 문)

`switch` 문은 제어 표현식의 값에 따라 정해진 코드 블럭을 실행하도록 해줍니다.

`switch` 문의 형식은 다음과 같습니다:

switch `control expression-제어 표현식` {<br />
case `pattern 1-유형 1`:<br />
  `statements-구문`<br />
case `pattern 2-유형 2` where `condition-조건`:<br />
  `statements-구문`<br />
case `pattern 3-유형 3` where `condition-조건`,<br />
     `pattern 4-유형 4` where `condition-조건`:<br />
  `statements-구문`<br />
default:<br />
  `statements-구문`<br />
}

`switch` 문의 _제어 표현식 (control expression)_ 을 평가한 다음 각각의 'case 절' 에서 지정한 '패턴 (patterns; 유형)' 과 비교합니다. 일치하는 것을 찾으면, 프로그램은 해당 'case 절' 영역 내에 열거한 _구문 (statements)_ 을 실행합니다. 각 'case 절' 영역은 비어 있을 수 없습니다. 그 결과, 각 'case 절' 이름표의 '콜론 (`:`)' 뒤에는 반드시 최소 하나의 구문이 포함되어야 합니다. 일치한 'case 절' 의 본문에서 어떤 코드도 실행하지 않으려면 단일 `break` 문을 사용합니다.

코드를 분기시킬 수 있는 표현식의 값은 매우 유연합니다. 예를 들어, 정수와 문자 같은, '크기 값 타입 (scalar types)'[^scalar-types] 의 값에 더하여, 부동-소수점 수, 문자열, 튜플, 사용자 정의 클래스의 인스턴스 및, 옵셔널을 포함한, 어떤 타입의 값으로도 코드를 분기시킬 수 있습니다. _제어 표현식 (control expression)_ 의 값은 심지어 열거체의 'case 값' 과도 일치하는지 맞춰볼 수 있으며 지정한 범위의 값에 포함되는지도 검사할 수 있습니다. 이런 다양한 타입의 값들을 `switch` 문에서 사용하는 방법에 대한 예제는, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에 있는 [Switch (Switch 문)]({% post_url 2020-06-10-Control-Flow %}#switch-switch-문) 을 참고하기 바랍니다.

`switch` 문의 'case 절' 은 선택적으로 각각의 '패턴 (pattern)' 뒤에 `where` 절을 가질 수 있습니다. _where 절 (where clause)_ 은 `where` 키워드와 그 뒤의 표현식을 써서 도입하며, 'case 절' 에 있는 패턴이 _제어 표현식 (control expression)_ 과 일치한다고 간주하기 전에 추가적인 조건을 제공하기 위해 사용합니다. `where` 절이 있으면, 관계가 있는 'case 절' 내의 _구문 (statements)_ 은 _제어 표현식 (control expression)_ 의 값이 'case 절' 의 패턴 중 하나와 일치하면서 `where` 절의 표현식이 `true` 로 평가될 때만 실행됩니다. 예를 들어, _제어 표현식 (control expression)_ 은 아래 예제의 'case 절' 과 튜플이면서, `(1, 1)` 처럼, 똑같은 값을 담고 있을 때만 일치합니다.

```switch
case let (x, y) where x == y:
```

위 예제에서 볼 수 있듯이, 'case 절' 에 있는 패턴은 `let` 키워드를 사용하여 상수를 연결할 수 있습니다 (`var` 키워드를 사용하여 변수를 연결할 수도 있습니다). 이런 상수 (또는 변수) 는 관련된 `where` 절과 'case 절' 영역 내의 나머지 코드에서 참조할 수 있습니다. 만약 'case 절' 이 제어 표현식과 일치하는 다중 패턴을 가지고 있는 경우, 모든 패턴은 반드시똑같은 상수 연결 또는 변수 연결을 담고 있어야 하며, 각 연결된 변수 또는 상수는 반드시 'case 절' 의 모든 패턴들과 똑같은 타입을 가져야 합니다.

`switch` 문은 또, `default` 키워드로 도입한, '기본 case 절 (default case)' 을 포함할수 있습니다. '기본 case 절' 에 있는 코드는 다른 'case 절' 어느 것도 제어 표현식과 일치하지 않는 경우에만 실행됩니다. `switch` 문은 단 하나의 '기본 case 절' 을 포함할 수 있으며, 이는 반드시 `switch` 문의 맨 끝에 있어야 합니다.

비록 '패턴 매칭 (pattern-matching; 유형 맞춤)' 연산의 실제 실행 순서, 및 특히 'case 절' 에 있는 패턴의 평가 순서는, 지정되어 있지 않더라도, `switch` 문에 있는 '패턴 매칭' 은 마치 값 평가를 소스 순서-즉, 소스 코드에 있는 순서-대로 하는 것처럼 작동합니다. 그 결과, 같은 값으로 평가되어, 제어 표현식의 값과 일치할 수 있는, 패턴을 가지는 'case 절' 이 여러 개인 경우, 프로그램은 소스 순서상 처음으로 일치하는 'case 절' 에 있는 코드만 실행합니다.

**Switch Statements Must Be Exhaustive (switch 문은 반드시 빠짐없이 철저해야 합니다)**

스위프트에서는, '제어 표현식' 의 타입으로 생성 가능한 모든 값은 최소한 반드시 하나의 'case 절' 패턴과 일치해야 합니다. 이의 실현이 간단한 것이 아닐 때는 (예를 들어, '제어 표현식' 의 타입이 `Int` 일 때) 는, 필수 조건을 만족하기 위해 '기본 case 값 (default case)' 을 포함시킬 수 있습니다.

**Switching Over Future Enumeration Cases (미래의 열거체 case 값에 대해서도 전환 (switching) 하기)**

_동결되지 않은 열거체 (nonfrozen enumeration)_ 는 미래-심지어 앱을 컴파일하고 출하한 후-에도 새로운 열거체 case 값을 가질 수 있는 특수한 종류의 열거체입니다. 동결되지 않은 열거체에서 전환 (switching) 을 하려면 '부가적인 고려 (extra consideration)' 가 필수로 요구됩니다. 라이브러리 작성자가 열거체를 '동결되지 않은 (nonfrozen)' 것으로 표시하면, 새로운 열거체 case 절을 추가할 수 있는 권리를 예약한 것으로, 해당 열거체와 상호 작용하는 코드는 어떤 것이든 _반드시 (must)_ 재컴파일 없이 이런 미래의 'case 값' 을 처리할 수 있어야 합니다. '라이브러리 진화 모드 (library evolution mode)' 에서 컴파일된 코드, 표준 라이브러리에 있는 코드, '애플 프레임웍 (Apple frameworks)' 을 위한 '스위프트 오버레이 (Swift overlays)'[^Swift-overlays], 및 C 와 오브젝티브-C 코드는 '동결되지 않은 열거체' 라고 선언할 수 있습니다. 동결 열거체 및 동결되지 않은 열거체에 대한 정보는, [frozen (동결)]({% post_url 2020-08-14-Attributes %}#frozen-동결) 를 참고하기 바랍니다.

동결되지 않은 열거체 값을 전환할 때는, 열거체의 모든 'case 값' 이 그와 관련된 'switch 문의 case 절' 을 가지고 있더라도, 항상 '기본 case 절' 을 포함해야 합니다. '기본 case 절' 에 `@unknown` 속성을 적용할 수 있는데, 이는 기본 case 절이 미래에 추가되는 열거체 case 값과만 일치해야 함을 지시합니다. 스위프트는 '기본 case 절' 이 컴파일 시간에 이미 알고 있는 어떤 열거체 case 값과 일치하면 경고를 일으킵니다. 이 미래의 경고는 라이브러리 작성자가 switch 문에서 관련된 case 절을 가지지 않은 열거체에 새로운 case 값을 추가했음을 알려줍니다.

다음 예제는 표준 라이브러리에 있는 [Mirror.AncestorRepresentation](https://developer.apple.com/documentation/swift/mirror/ancestorrepresentation) 열거체의 기존 case 값 세 개 모두에 대한 전환을 보여줍니다. 미래에 추가적인 'case 값' 을 추가할 경우, 컴파일러는 새로운 'case 값' 을 고려하기 위해 'switch 문' 을 갱신할 필요가 있음을 나타내고자 경고를 생성합니다.

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
// "Generate a default mirror for all ancestor classes." 를 출력합니다.
```

**Execution Does Not Fall Through Cases Implicitly (실행은 case 절을 암시적으로 뚫고 가지 않습니다)**

프로그램은, 일치한 case 절에 있는 코드의 실행을 종료하면, `switch` 문을 빠져나갑니다. 프로그램 실행은 그 다음 'case 절' 이나 '기본 case 절' 로 계속되거나 "뚫고 가지 (fall through)" 않습니다. 즉, 한 'case 절' 에서 그 다음으로 실행이 계속되길 원한다면, 실행을 계속하길 원하는 'case 절' 안에, 단순히 `fallthrough` 키워드로 구성된, `fallthrough` 문을 명시적으로 포함시키도록 합니다. `fallthrough` 문에 대한 더 많은 정보는, 아래의 [Fallthrough Statement ('fallthrough' 문)](#fallthrough-statement-fallthrough-문) 을 참고하기 바랍니다.

> GRAMMAR OF A SWITCH STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID434)

### Labeled Statement (이름표 달린 구문)

반복문, `if` 문, `switch` 문, 또는 `do` 문은, 이름표와 바로 뒤의 콜론 (`:`) 으로 구성된, _구문 이름표 (statement label)_ 를 접두사로 가질 수 있습니다.  
반복문이나 `switch` 문에서 제어 흐름을 어떻게 바꾸고 싶은 지를 명시하려면, 아래의 [Break Statement ('break' 문)](#break-statement-break-문) 및 [Continue Statement ('continue' 문)](#continue-statement-continue-문) 에서 설명한 것처럼, `break` 문과 `continue` 문에서 '구문 이름표 (statement label)' 를 사용하면 됩니다.

'이름표 달린 구문 (labeled statement)' 의 영역은 '구문 이름표' 뒤의 전체 구문입니다. '이름표 달린 구문' 은 중첩할 수 있지만, 각각의 '구문 이름표' 는 반드시 유일해야 합니다.

더 자세한 정보와 구문 이름표를 사용하는 방법에 대한 예제는, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에 있는 [Labeled Statements (이름표 달린 구문)]({% post_url 2020-06-10-Control-Flow %}#labeled-statements-이름표-달린-구문) 을 참고하기 바랍니다.

> GRAMMAR OF A LABELED STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID439)

### Control Transfer Statements (제어 전달 구문)

'제어 전달 구문 (control transfer statements)' 은 '프로그램 제어' 를 코드 한 곳에서 또 다른 곳으로 무조건적으로 전달하여 프로그램에서 코드의 실행 순서를 바꿀 수 있습니다. 스위프트는 다섯 가지의 제어 전달 구문을 가지고 있습니다: `break` 문, `continue` 문, `fallthrough` 문, `return` 문, 그리고 `throw` 문이 그것입니다.

> GRAMMAR OF A CONTROL TRANSFER STATEMENT 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Statements.html#ID440)

#### Break Statement ('break' 문)

#### Continue Statement ('continue' 문)

#### Fallthrough Statement ('fallthrough' 문)

#### Return Statement

#### Throw Statement

### Defer Statement

### Do Statement ('do' 구문)

`do` 구문은 새로운 영역을 도입하기 위해 사용하며, 정의한 에러 조건과 일치하는 '패턴 (pattern; 유형)' 을 가지고 있는, 하나 이상의 `catch` 절을 선택적으로 가질 수 있습니다. `do` 문의 영역 안에서 선언한 변수 및 상수는 해당 영역 내에서만 접근할 수 있습니다.

스위프트의 `do` 문은 C 언어에서 코드 블럭의 경계를 구분하는데 사용하는 '중괄호 (curly; `{}`)' 와 비슷한 것으로, 실행 시간에 성능 비용을 초래하지 않습니다.

`do` 문은 다음의 형식을 가지고 있습니다:

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

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^scalar-types]: '크기 타입 (scalar types)' 은 수학에서 사용하는 '스칼라량 (scalar)' 과 비슷하게 크기 값만 가지는 타입이라고 이해할 수 있습니다.

[^Swift-overlays]: 여기에서 '스위프트 오버레이 (Swift overlays)' 는 '뷰 (View)' 위에 다른 '뷰 (View)' 를 덧입힐 수 있는 UI 관련 프레임웍으로 추측됩니다.
