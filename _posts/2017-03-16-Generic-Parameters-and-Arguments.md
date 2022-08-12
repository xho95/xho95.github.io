---
layout: post
comments: true
title:  "Swift 5.7: Generic Parameters and Arguments (일반화 매개 변수와 인자)"
date:   2017-03-16 00:00:00 +0900
categories: Swift Language Grammar Generic Parameters Arguments
redirect_from: "/swift/language/grammar/generic/parameters/arguments/2017/03/15/Generic-Parameters-and-Arguments.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [Generic Parameters and Arguments](https://docs.swift.org/swift-book/ReferenceManual/GenericParametersAndArguments.html) 부분[^Version-Compatibility]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Generic Parameters and Arguments (일반화 매개 변수와 인자)

이번 장에선 일반화 타입과, 함수, 및 초기자의 매개 변수와 인자를 설명합니다. 일반화 타입이나, 함수, 첨자, 또는 초기자를 선언할 땐, 일반화 타입이나, 함수, 또는 초기자와 작업할 수 있는 타입 매개 변수를 지정합니다. 이러한 타입 매개 변수는 자리 표시자[^placeholders] 처럼 행동하며 일반화 타입 인스턴스를 생성하거나 일반화 함수 또는 초기자를 호출할 때 실제 고정 타입[^concrete-type] 인자로 교체합니다.

스위프트 일반화의 전체 개요에 대해선, [Generics (일반화)]({% post_url 2020-02-29-Generics %}) 를 보기 바랍니다.

### Generic Parameter Clause (일반화 매개 변수 절)

_일반화 매개 변수 절 (generic parameter clause)_ 은 일반화 타입 및 함수의 타입 매개 변수를, 그 매개 변수와 결합된 어떤 구속 조건 및 필수 조건과도 나란히 지정합니다. 일반화 매개 변수 절의 테두리는 꺾쇠 괄호 (`<>`) 이며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;<`generic parameter list-일반화 매개 변수 목록`>

_일반화 매개 변수 목록 (generic parameter list)_ 은 쉼표로-구분한 일반화 매개 변수 목록으로, 각각의 형식은 다음과 같습니다:

`type parameter-타입 매개 변수`: `constraint-구속 조건`

일반화 매개 변수는 _타입 매개 변수 (type parameter)_ 와 옵션인 그 뒤의 _구속 조건 (constraint)_ 으로 구성합니다. _타입 매개 변수 (type parameter)_ 는 단순히 자리 표시용 타입 (예를 들어, `T`, `U`, `V`, `Key`, `Value`, 등) 의 이름입니다. 타입 매개 변수 (및 그와 결합된 어떤 타입) 은 함수 또는 초기자 서명[^signature] 을 포함한, 타입이나, 함수, 또는 초기자 선언의 나머지 부분에서 접근합니다.

_구속 조건 (constraint)_ 은 타입 매개 변수가 지정한 클래스를 상속하도록 또는 프로토콜이나 프로토콜 합성을 준수하도록 지정합니다. 예를 들어, 아래 일반화 함수의, 일반화 매개변수인 `T: Comparable` 은 타입 매개 변수 `T` 를 대신할 어떤 타입 인자든 반드시 `Comparable` 프로토콜을 준수해야 한다고 지시합니다.

```swift
func simpleMax<T: Comparable>(_ x: T, _ y: T) -> T {
  if x < y {
    return y
  }
  return x
}
```

`Int` 와 `Double` 은, 예를 들어, 둘 다 `Comparable` 프로토콜을 준수하기 때문에, 이 함수는 어느 쪽 타입 인자든 받습니다. 일반화 타입과 대조하여, 일반화 함수나 초기자를 사용할 땐 일반화 인자 절을 지정하지 않습니다. 그 대신 함수나 초기자로 전달한 인자 타입으로 타입 인자를 추론합니다.

```swift
simpleMax(17, 42) // T 는 Int 라고 추론함
simpleMax(3.14159, 2.71828) // T 는 Double 이라고 추론함
```

#### Generic Where Clauses (일반화 where 절)

타입 매개 변수와 그의 결합 타입에 추가 필수 조건을 지정하려면 타입이나 함수 본문을 여는 중괄호 바로 앞에 일반화 `where` 절을 포함하면 됩니다. 일반화 `where` 절은 `where` 키워드와, 그 뒤의 쉼표로-구분한 하나 이상의 _필수 조건 (requirements)_ 목록으로 구성됩니다.

&nbsp;&nbsp;&nbsp;&nbsp;where `requirements-필수 조건`

일반화 `where` 절의 _필수 조건 (requirements)_ 은 타입 매개 변수가 클래스를 상속하거나 프로토콜 또는 프로토콜 합성을 준수하도록 지정합니다. 일반화 `where` 절이 타입 매개 변수에 대한 단순한 구속 조건 표현의 수월한 구문을 제공하긴 하지만 (예를 들어, `<T: Comparable>` 과 같은 것인 `<T> where T: Comparable` 등등), 이를 사용하여 타입 매개 변수와 그 결합 타입에 더 복잡한 구속 조건을 제공할 수도 있습니다. 예를 들어, 타입 매개 변수의 결합 타입이 프로토콜을 준수하도록 구속할 수 있습니다. 예를 들어, `<S: Sequence> where S.Iterator.Element: Equatable` 은 `S` 가 `Sequence` 프로토콜을 준수하면서 그 결합 타입인 `S.Iterator.Element` 는 `Equatable` 프로토콜을 준수하도록 지정합니다. 이 구속 조건은 시퀀스의 각 원소가 같음 비교 가능하도록 보장합니다.

`==` 연산자로, 두 타입의 정체가 같다 (identical)[^identical] 는 필수 조건을 지정할 수도 있습니다. 예를 들어, `<S1: Sequence, S2: Sequence> where S1.Iterator.Element == S2.Iterator.Element` 는 `S1` 과 `S2` 가 `Sequence` 프로토콜을 준수하면서 반드시 두 시퀀스 모두 똑같은 타입이어야 한다는 구속 조건을 표현합니다.

타입 매개 변수를 대체할 어떤 타입 인자든 반드시 타입 매개 변수에 있는 모든 구속 조건 및 필수 조건을 만족해야 합니다.

일반화 `where` 절은 타입 매개 변수를 포함한 선언 부분이나, 타입 매개변수를 포함한 선언 안의 중첩 선언 부분에 나타날 수 있습니다. 중첩 선언의 일반화 `where` 절은 자신을 둘러싼 선언의 타입 매개 변수를 여전히 참조할 수 있으며; 하지만, 그 where 절의 필수 조건은 이를 작성한 선언에만 적용됩니다.

자신을 둘러싼 선언에도 where 절이 있으면, 두 절의 필수 조건을 모두 조합합니다. 아래 예제에서, `startsWithZero()` 는 `Element` 가 `SomeProtocol` 과 `Numeric` 을 둘 다 준수해야만 사용 가능합니다.

```swift
extension Collection where Element: SomeProtocol {
  func startsWithZero() -> Bool where Element: Numeric {
    return first == .zero
  }
}
```

일반화 함수나 초기자를 중복 정의하려면 타입 매개 변수에 서로 다른 구속 조건이나, 필수 조건, 또는 둘 다를 제공하면 됩니다. 중복 정의한 일반화 함수나 초기자를 호출할 때, 컴파일러가 이러한 구속 조건을 사용하여 어느 중복 정의 함수나 초기자를 불러낼 건지 해결합니다.

일반화 `where` 절에 대한 더 많은 정보와 일반화 함수 선언에서의 사용 예를 보려면, [Generic Where Clauses (일반화 where 절)]({% post_url 2020-02-29-Generics %}#generic-where-clauses-일반화-where-절) 부분을 보기 바랍니다.

> GRAMMAR OF A GENERIC PARAMETER CLAUSE 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/GenericParametersAndArguments.html#ID407)

### Generic Argument Clause (일반화 인자 절)

_일반화 인자 절 (generic argument clause)_ 은 일반화 타입의 타입 인자를 지정합니다. 일반화 인자 절의 테두리는 꺾쇠 괄호 (`<>`) 이며 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;<`generic argument list-일반화 인자 목록`>

_일반화 인자 목록 (generic argument list)_ 은 쉼표로-구분한 타입 인자 목록입니다. _타입 인자 (type argument)_ 는 실제 고정 타입의 이름으로 일반화 타입의 일반화 매개 변수 절 안에 있는 해당 타입 매개 변수를 교체합니다. 결과는 그 일반화 타입의 특수화 버전[^specialized-version] 입니다. 아래 예제는 스위프트 표준 라이브러리의 일반화 딕셔너리 타입을 단순하게 한 버전입니다.

```swift
struct Dictionary<Key: Hashable, Value>: Collection, ExpressibleByDictionaryLiteral {
  /* ... */
}
```

일반화 `Dictionary` 타입의 특수화 버전인, `Dictionary<String, Int>` 는 `Key: Hashable` 과 `Value` 라는 일반화 매개 변수를 `String` 과 `Int` 라는 고정 타입 인자로 교체하여 형성합니다. 각각의 타입 인자는 반드시 자신이 대체할 일반화 매개 변수의 모든 구속 조건을 만족해야 하는데, 이는 일반화 `where` 절에서 지정한 어떤 추가 필수 조건도 포함합니다. 위 예제의, `Key` 타입 매개 변수는 `Hashable` 프로토콜을 준수하도록 구속하며 따라서 `String` 도 반드시 `Hashable` 프로토콜을 준수해야 합니다.

타입 매개 변수의 교체를 그 자체가 일반화 타입의 특수화 버전인 타입 인자 (적절한 구속 조건과 필수 조건을 만족하게 한 거) 로 할 수도 있습니다. 예를 들어, `Array<Element>` 의 `Element` 타입 매개 변수를, `Array<Int>` 라는, 행렬의 특수화 버전으로 교체하면, 원소 그 자체가 정수 배열인 배열을 형성할 수 있습니다.

```swift
let arrayOfArrays: Array<Array<Int>> = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
```

[Generic Parameter Clause (일반화 매개 변수 절)](#generic-parameter-clause-일반화-매개-변수-절) 에서 언급한 것처럼, 일반화 인자 절로 일반화 함수나 초기자의 타입 인자를 지정하진 않습니다.

> GRAMMAR OF A GENERIC ARGUMENT CLAUSE 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/GenericParametersAndArguments.html#ID409)

### 다음 장 

* **Summary of the Grammar (문법 총정리)** 장은 번역하는게 의미가 없으므로 생략합니다. 그 장의 링크는 밑에 있는 전체 목록을 참고하기 바랍니다.

### 전체 목록 

[Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %})

### 참고 자료

[^GPandA]: 원문은 [Generic Parameters and Arguments](https://docs.swift.org/swift-book/ReferenceManual/GenericParametersAndArguments.html) 에서 확인할 수 있습니다.

[^placeholders]: '자리 표시자 (placeholder)' 에 대한 자세한 설명은 [Generic Functions (일반화 함수)](#generic-functions-일반화-함수)) 부분을 참고하기 바랍니다.

[^concrete-type]: 프로그래밍에서 자신이 직접 인스턴스를 만들 수 있는, 타입을 '고정 타입 (concrete type)' 이라고 합니다. 이와 반대로 자신이 직접 인스턴스를 만들 수 없는 타입을 '추상 타입 (abstract type)' 이라고 합니다.

[^signature]: 함수나 초기자의 '서명 (signature)' 은, 중복 정의한 함수에서 호출할 걸 찾기 위해 사용하며, 보통 함수 이름과 매개 변수 등을 합쳐서 구성됩니다. 함수 서명 (function signature) 과 함수 선언 (function declaration) 의 차이점은 함수 선언의 경우 반환 타입을 포함하지 않는다는 것입니다. 타입 서명에 대한 더 자세한 정보는, 위키피디아의 [Type signature](https://en.wikipedia.org/wiki/Type_signature) 항목을 참고하기 바랍니다.

[^specialized-version]: '특수화 버전 (specialized version)' 은 일반화 타입의 타입 매개 변수가 특수한 타입으로 정해진 것입니다. 이렇게 특수화 버전을 만들면 일반화 타입의 적용 범위가 좁아집니다.

[^identical]: 프로그래밍에서 '정체가 같다 (identical)' 는 건 '값이 똑같다 (equal)' 보다 더 강한 개념입니다. 두 개의 인스턴스가 있는데, 이들의 값이 똑같으면 값이 똑같은 거지만, 이 둘의 정체가 같은 건 아닙니다. 본문은 타입에 대한 설명이므로, 정체가 같다라고 표현합니다.