---
layout: post
comments: true
title:  "Swift 5.5: Generic Parameters and Arguments (일반화된 매개 변수와 일반화된 인자)"
date:   2017-03-16 00:00:00 +0900
categories: Swift Language Grammar Generic Parameters Arguments
redirect_from: "/swift/language/grammar/generic/parameters/arguments/2017/03/15/Generic-Parameters-and-Arguments.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Generic Parameters and Arguments](https://docs.swift.org/swift-book/ReferenceManual/GenericParametersAndArguments.html) 부분[^Version-Compatibility]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Generic Parameters and Arguments (일반화된 매개 변수와 일반화된 인자)

이번 장에서는 일반화된 (generic) 버전의 타입, 함수, 그리고 초기자 (initializer) 에서 사용하는 매개 변수와 인자에 대해 설명합니다. 일반화된 버전의 타입, 함수, 첨자 연산자 (subscript), 또는 초기자를 선언할 때는, 이들이 사용할 '타입 매개 변수'를 지정하게 됩니다. 이러한 '타입 매개 변수'는 자리를 지키고 있다가 일반화된 타입의 인스턴스가 만들어지거나 일반화된 함수나 초기자가 호출될 때 전달되는 인자로 대체되어, 실제 '구체적으로 고정된 타입 (concrete type)' 으로 바뀝니다.

스위프트에서의 일반화 (generic) 에 대해서는 [Generics (일반화)]({% post_url 2020-02-29-Generics %}) 부분을 참고 바랍니다.

### Generic Parameter Clause (일반화된 매개 변수 구절; 제네릭 매개 변수 구절)

_일반화된 매개 변수 구절 (generic parameter clause)_ 은 일반화된 타입이나 일반화된 함수의 '타입 매개 변수' 를 지정하면서, 이 매개 변수와 관련된 모든 '구속 조건 (constraints)' 과 '필수 조건 (requirements)' 도 다같이 지정합니다. '일반화된 매개 변수 구절' 은 꺾쇠 괄호 (`<>`) 로 감싸여 있으며 다음과 같은 양식을 가집니다:

<`generic parameter list (일반화된 매개 변수 목록)`>

_일반화된 매개 변수 목록 (generic parameter list)_ 은 쉼표로-구분된 '일반화된 매개 변수' 들의 목록으로, 각각의 '일반화된 매개 변수' 는 다음의 양식을 가집니다:

`type parameter (타입 매개 변수)`: `constraint (구속 조건)`

위에서 보듯 일반화된 매개 변수는 _타입 매개 변수_ 와 _구속 조건_ 으로 구성되며, 여기서 '구속 조건'은 선택 사항 (option) 입니다. _타입 매개 변수_ 는 단순히 해당 자리를 표시하는 용도로 사용하는 타입 이름입니다.[^placeholder] (예를 들면 `T`, `U`, `V`, `Key`, `Value` 등이 이에 해당합니다.) 타입 매개 변수 (및 이와 결합된 타입 어떤 것이든), 함수 또는 초기자의 '서명 (signature)'[^signature] 부분을 포함하여, 타입, 함수, 또는 초기자 선언의 나머지 부분에서 접근 할 수 있습니다.

_구속 조건 (constraint)_ 은 '타입 매개 변수'가 특정한 클래스를 상속 받아야 하는지 또는 프로토콜이나 '프로토콜 합성' 을 준수해야 하는지를 지정합니다. 예를 들어 아래의 일반화된 함수에서, 일반화된 매개 변수인 `T: Comparable` 은 타입 매개 변수 `T` 를 대체하는 타입 인자라면 어떤 것이든 반드시 `Comparable` 프로토콜을 따라야함을 나타내고 있습니다.

```swift
func simpleMax<T: Comparable>(_ x: T, _ y: T) -> T {
  if x < y {
    return y
  }
  return x
}
```

`Int` 와 `Double` 은 둘 다 `Comparable` 프로토콜을 따르고 있기 때문에 이 함수의 인자로 넘길 수 있습니다. 일반회된 타입에서와는 다르게, 일반화된 함수나 초기자에서는 '일반화된 인자 구절 (generic argument clause)'을 지정할 필요가 없습니다. 함수나 초기자로 전달되는 인자의 타입으로부터 타입 인자를 추론할 수 있기 때문입니다.

```swift
simpleMax(17, 42) // T 를 Int 로 추론합니다.
simpleMax(3.14159, 2.71828) // T 를 Double 로 추론합니다.
```

#### Generic Where Clauses (일반화 'where' 절)

'타입 매개 변수 (type parameters)' 및 그와 '결합된 타입 (associated types)' 에 추가적인 '필수 조건 (requirements)' 을 지정하려면 타입 또는 함수 본문의 '여는 중괄호' 바로 앞에 '일반화된 `where` 절 (generic where clause)' 을 집어 넣으면 됩니다. '일반화된 `where` 절' 은 `where` 키워드 다음에, 쉼표로-구분되는 하나 이상의 '_필수 조건 (requirements)_' 목록을 이어 붙여서 만듭니다.

where `requirements`

'일반화된 `where` 절' 의 '_필수 조건 (requirements)_' 은 '타입 매개 변수' 가 어떤 클래스를 상속받도록 지정하거나 프로토콜 또는 '프로토콜 합성' 을 준수하도록 지정합니다. '일반화된 `where` 절' 은 '타입 매개 변수' 의 간단한 구속 조건 표현을 표현하도록 쉽게 해주는 꿀팁같은 것을 (예를 들어 `<T: Comparable>` 를 `<T> where T: Comparable` 로 동등하게 표현하는 것 등) 제공해 주지만, 이를 잘 사용하면 타입 매개 변수와 그와 '결합된 타입' 들에 더 복잡한 구속 조건도 부여할 수 있습니다. 가령 타입 매개 변수의 연관 타입이 프로토콜을 따르도록 제약할 수 있습니다. 예를 들어 `<S: Sequence> where S.Iterator.Element: Equatable` 은 이 `S` 가 `Sequence` 프로토콜을 따르면서 그 연관 타입인 `S.Iterator.Element` 가 `Equatable` 프로토콜을 따르도록 지정합니다. 이 구속 조건은 수열의 각 요소가 동등 비교를 수행할 수 있어야 함을 보장합니다.

두 타입이 동일해야 함을 요구 조건으로 지정할 수도 있는데 이 때는 `==` 연산자를 사용합니다. 예를 들면 `<S1: Sequence, S2: Sequence> where S1.Iterator.Element == S2.Iterator.Element` 는 `S1` 과 `S2` 가 `Sequence` 프로토콜을 따르도록 제약하면서 각 수열의 요소들이 반드시 같은 타입으로 되어 있어야 함을 표현합니다.

타입 매개 변수를 대체할 어떤 타입 인자라도 반드시 타입 매개 변수에 대한 모든 '구속 조건' 과 '필수 조건' 을 만족해야만 합니다.

일반화된 함수나 초기자는 타입 매개 변수에 다른 구속 조건, 필수 조건, 또는 둘 다를 제공해서 추가 정의 (overload) 할 수 있습니다. 일반화된 함수나 초기자의 추가 정의 버전을 호출하면 컴파일러는 이들 구속 조건을 사용하여 어떤 추가 정의 함수나 초기자를 실행해야할지를 결정하게 됩니다.

일반화된 `where` 절에 대한 보다 많은 정보와 일반화된 함수 선언의 예를 보고 싶으면 [Generic Where Clauses (일반화 'where' 절)]({% post_url 2020-02-29-Generics %}#generic-where-clauses-일반화-where-절) 부분을 보면 됩니다.

> 일반화된 매개 변수 구절의 문법
>
> generic-parameter-clause → **<­** generic-parameter-list ­**>**  
> generic-parameter-list → generic-parameter­ \| generic-parameter **,** ­generic-parameter-list­  
> generic-parameter → type-name­
> generic-parameter → type-name­ **:** ­type-identifier­  
> generic-parameter → type-name­ **:** ­protocol-composition-type
>
> generic-where-clause → **where** ­requirement-list­  
> requirement-list → requirement­  requirement­ **,** ­requirement-list  
> requirement → conformance-requirement­  same-type-requirement  
>
> conformance-requirement → type-identifier­ **:** ­type-identifier  
> conformance-requirement → type-identifier­ **:** ­protocol-composition-type  
> same-type-requirement → type-identifier­ **==­** type­

### Generic Argument Clause (일반화된 인자 구절)

_일반화된 인자 구절 (generic argument clause)_ 은 '일반화된 타입' 의 '타입 인자' 를 지정합니다. '일반화된 인자 구절' 은 꺾쇠 괄호 (`<>`) 로 감싸여 있으며 다음과 같은 양식을 가집니다:

<`generic argument list (일반화된 인자 목록)`>

_일반화된 인자 목록 (generic argument list)_ 은 쉼표로-구분된 '타입 인자' 들의 목록을 말합니다. _타입 인자 (type argument)_ 는 실제 '구체적으로 고정된 타입 (concrete type)' 이름이며 이것이 '일반화된 타입' 의 '일반화된 매개 변수 구절' 에 있는 연관되어 있는 '타입 매개 변수' 를 대체합니다. 그 결과는 '일반화된 타입' 의 '특수한 버전 (specialized version)' 입니다.[^specialized-version] 아래 예제는 스위프트 표준 라이브러리에 있는 '일반화된 딕셔터리 타입 (generic dictionary type)' 을 간추려서 보여줍니다.

```swift
struct Dictionary<Key: Hashable, Value>: Collection, ExpressibleByDictionaryLiteral {
    /* ... */
}
```

일반화된 `Dictionary` 타입의 특수한 버전인 `Dictionary<String, Int>` 은 일반화된 매개 변수 `Key: Hashable` 과 `Value` 를 굳혀진 타입 인자인 `String` 과 `Int` 로 대체합니다. 각 타입 인자들은 일반화된 매개 변수를 대체할 때 반드시 모든 '구속 조건' 들을 만족해야하며 이 때 일반화된 `where` 절에서 지정한 모든 추가 요구 사항들도 예외 없이 만족해야 합니다. 위의 예제에서 보면 `Key` 타입 매개 변수는 `Hashable` 프로토콜을 따르도록 제약하고 있으므로 `String` 은 반드시 `Hashable` 프로토콜을 따라야 합니다.

타입 매개 변수를 스스로가 일반화된 타입의 특수화 버전인 타입 인자로 대체할 수도 있습니다. (물론 이 타입 인자도 '구속 조건' 과 '필수 조건' 을 적절하게 만족하도록 주어져야 합니다.) 예를 들어 `Array<Element>` 의 타입 매개 변수인 `Element` 를 행렬의 특수화 버전인 `Array<Int>` 로 대체하여 그 요소들이 스스로 정수 배열인 배열을 만들 수 있습니다. [^specialized-form]

```swift
let arrayOfArrays: Array<Array<Int>> = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
```

[Generic Parameter Clause (일반화된 매개 변수 구절; 제네릭 매개 변수 구절)](#generic-parameter-clause-일반화된-매개-변수-구절-제네릭-매개-변수-구절) 에서 언급한 것처럼, '일반화된 인자 구절' 을 사용해서 일반화된 함수나 초기자의 '타입 매개 변수' 를 지정하는 것은 아닙니다.

> 일반화된 인자 구절의 문법
>
> generic-argument-clause → **<­** generic-argument-list ­**>­**  
> generic-argument-list → generic-argument­ \| generic-argument **,** generic-argument-list­  
> generic-argument → type­

### 참고 자료

[^GPandA]: 원문은 [Generic Parameters and Arguments](https://docs.swift.org/swift-book/ReferenceManual/GenericParametersAndArguments.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^placeholder]: 즉, 특정한 타입의 이름이 아니므로 사용자가 편리한 데로 임의로 정할 수 있는 이름입니다.

[^signature]: 함수나 초기자의 '서명 (signature)' 은, 중복 정의된 함수들 중에서 호출해야 할 것을 찾기 위해 사용하는 것으로, 보통 '함수 이름' 과 매개 변수 등으로 구성됩니다. '함수 서명 (function signature)' 이 '함수 선언 (function declaration)' 과 다른 점이라면 '반환 타입' 자체는 '함수 선언' 에 포함되지 않는다는 것입니다. 보다 자세한 정보는 위키피디아의 [Type signature](https://en.wikipedia.org/wiki/Type_signature) 항목을 참고하기 바랍니다.

[^specialized-version]: 이 부분은 C++ 언어의 메타 프로그래밍에서 나오는 일반화 (generalization) 및 특수화 (specialization) 의 개념과 유사한 것 같습니다. Swift 의 일반화 (generic; 제네릭) 이 C++ 의 템플릿 (template) 과 사실상 동등한 개념이므로 당연한 것이라고 할 수 있습니다.

[^specialized-form]: 이 부분은 아직 잘은 모르겠지만 C++ 의 template template parameter 와 유사한 개념인 것 같습니다.
