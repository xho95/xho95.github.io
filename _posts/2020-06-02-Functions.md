---
layout: post
pagination: 
  enabled: true
comments: true
title:  "Swift 5.7: Functions (함수)"
date:   2020-06-02 10:00:00 +0900
categories: Swift Language Grammar Function
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [Functions](https://docs.swift.org/swift-book/LanguageGuide/Properties.html) 부분[^Functions]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Functions (함수)

_함수 (functions)_ 는 그 자체로-동작하는 코드 뭉치로써 정해진 임무를 수행합니다. 함수는 뭘 하는지 정체를 파악할 이름을 줘서, 필요할 때 이 이름으로 임무를 수행할 함수를 "호출 (call)" 합니다.

스위프트의 통일된 함수 구문은 충분히 유연해서 매개 변수 이름이 없는 단순한 **C**-스타일 함수부터 각각의 매개 변수마다 이름과 인자 이름표가 있는 복잡한 **오브젝티브-C**-스타일 메소드까지 어떤 것이든 표현합니다. 매개 변수는 기본 값을 제공하여 함수 호출을 단순하게 할 수도 있고, 입-출력 매개 변수[^in-out] 로 전달하여, 일단 한 번 함수 실행을 완료하고 나면 전달된 변수를 수정하게 할 수도 있습니다.

스위프트의 모든 함수엔 타입이 있는데, 함수의 매개 변수 타입 및 반환 타입으로 구성됩니다. 이 타입은 스위프트의 다른 어떤 타입인 것 같이 쓸 수 있는데, 함수를 다른 함수의 매개 변수로 전달하고, 함수에서 함수를 반환하는 걸, 하기 쉽게 합니다. 함수를 다른 함수 안에 작성하여 중첩 함수의 시야 안으로 유용한 기능을 감출 수도 있습니다.

### Defining and Calling Functions (함수 정의 및 호출하기)

함수를 정의할 땐, 이름과 타입이 있는, _매개 변수 (parameters)_ 라는, 값을 옵션으로 정의하여 함수의 입력으로 취할 수 있습니다. 함수를 끝낼 때 출력으로 되돌려줄, _반환 타입 (return type)_ 이라는, 값 타입도 옵션으로 정의할 수 있습니다.

모든 함수엔 _함수 이름 (function name)_ 이 있는데, 이는 함수가 수행할 임무를 설명합니다. 함수를 사용하려면, 그 함수를 이름으로 "호출 (call)" 하며 함수의 매개 변수 타입과 맞는 (_인자 (arguments)_ 라는) 입력 값을 전달합니다. 함수 인자는 반드시 항상 함수 매개 변수 목록에 있는 것과 똑같은 순서여야 합니다.

아래 예제에 있는 함수는 `greet(person:)` 이라고 하는데, 하는 일이 그거기 때문입니다-사람 이름을 입력받아 그 사람에 대한 인사말을 반환합니다.[^what-it-does] 이를 해내기 위해, 입력 매개 변수인-`person` 이라는 `String` 값-하나와, 그 사람에 대한 인사말을 담을, `String` 반환 타입을 정의합니다.

```swift
func greet(person: String) -> String {
  let greeting = "Hello, " + person + "!"
  return greeting
}
```

이 모든 정보를 함수 _정의 (definition)_ 로 끌어 모아서, 접두사 `func` 키워드를 붙입니다. 함수의 반환 타입은 (붙임표[^hyphen] 와 그 뒤의 오른쪽 꺽쇠 괄호로 된) _반환 화살표 (return arrow)_ `->` 로 지시하는데, 그 뒤엔 반환할 타입의 이름이 따라옵니다.

정의는 함수가 하는 것과, 받고자 하는 것, 및 끝날 때 반환할 걸 설명합니다. 정의는 코드 어디에서 함수를 호출하든 헷갈리지 않게 합니다:

```swift
print(greet(person: "Anna"))
// "Hello, Anna!" 를 인쇄함
print(greet(person: "Brian"))
// "Hello, Brian!" 를 인쇄함
```

`greet(person:)` 함수를 호출하려면, `greet(person: "Anna")` 처럼, `person` 인자 이름표 뒤에 `String` 값을 전달하면 됩니다. 함수가 `String` 값을 반환하기 때문에, 위에서 보듯, `greet(person:)` 함수를 `print(_:separator:terminator:)` 함수 호출로 감싼 채로 문자열을 인쇄하고 반환 값을 볼 수 있습니다.

> `print(_:separator:terminator:)` 함수엔 첫 번째 인자에 대한 이름표는 없고, 다른 인자들은 기본 값이 있기 때문에 옵션입니다. 이런 함수 구문의 변화는 아래의 [Function Argument Labels and Parameter Names (함수의 인자 이름표와 매개 변수 이름)](#function-argument-labels-and-parameter-names-함수의-인자-이름표와-매개-변수-이름) 과 [Default Parameter Values (기본 매개 변수 값)](#default-parameter-values-기본-매개-변수-값) 부분에서 논의합니다.

`greet(person:)` 함수의 본문은 `greeting` 이라는 새로운 `String` 상수를 정의하고 거기에 단순한 인사말 메시지를 설정하는 걸로 시작합니다. 그런 다음 `return` 키워드로 이 인사말을 함수 밖으로 되돌려 줍니다. `return greeting` 이라고 하는 코드 줄에서, 함수는 실행을 종료하고 현재 `greeting` 값을 반환합니다.

서로 다른 입력 값으로 `greet(person:)` 함수를 여러 번 호출할 수 있습니다. 위의 예제는 이를 `"Anna"` 라는 입력 값과, `"Brian"` 이라는 입력 값으로 호출하면 발생하는게 뭔지 보여줍니다. 각각의 경우마다 함수는 맞춤식 인사말을 반환합니다.

이 함수의 본문을 더 짧게 만들기 위해, 메시지 생성문과 반환문을 한 줄로 조합할 수도 있습니다:

```swift
func greetAgain(person: String) -> String {
  return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))
// "Hello again, Anna!" 를 인쇄함
```

### Function Parameters and Return Values (함수의 매개 변수와 반환 값)

스위프트의 함수 매개 변수와 반환 값은 극히 유연합니다. 이름 없는 단일 매개 변수를 가진 단순 보조 함수부터 의미를 표현하는 매개 변수 이름과 서로 다른 매개 변수 옵션을 가진 복잡한 함수까지 어떤 것도 정의할 수 있습니다.

#### Functions Without Parameters (매개 변수가 없는 함수)

함수에서 입력 매개 변수의 정의는 필수가 아닙니다. 입력 매개 변수가 없는 함수는 이렇는데, 호출할 때마다 항상 똑같은 `String` 메시지를 반환합니다:

```swift
func sayHelloWorld() -> String {
  return "hello, world"
}
print(sayHelloWorld())
// "hello, world" 를 인쇄함
```

함수 정의가 어떤 매개 변수도 받지 않더라도, 함수 이름 뒤엔 여전히 괄호가 필요합니다. 함수를 호출할 때도 함수 이름 뒤에 한 쌍의 빈 괄호가 있어야 합니다.

#### Functions with Multiple Parameters (매개 변수가 여러 개인 함수)

함수엔 여러 개의 입력 매개 변수가 있을 수 있는데, 이들은 함수 괄호 안에, 쉼표로 구분하여, 작성합니다.

다음 함수는 사람 이름과 이미 인사했는지를 입력 받아, 그 사람에 대한 적절한 인사말을 반환합니다:

```swift
func greet(person: String, alreadyGreeted: Bool) -> String {
  if alreadyGreeted {
    return greetAgain(person: person)
  } else {
    return greet(person: person)
  }
}
print(greet(person: "Tim", alreadyGreeted: true))
// "Hello again, Tim!" 를 인쇄함
```

`greet(person:alreadyGreeted:)` 함수를 호출하려면 괄호 안에 이름표가 `person` 인 `String` 인자 값과 이름표가 `alreadyGreeted` 인 `Bool` 인자 값 둘 다를, 쉼표로 구분하여, 전달하면 됩니다. 이 함수는 앞 절에서 본 `greet(person:)` 함수와는 별개라는 걸 기록하기 바랍니다. 함수 둘 다 이름이 `greet` 으로 시작하긴 하지만, `greet(person:alreadyGreeted:)` 함수는 인자를 두 개 받고 `greet(person:)` 함수는 하나만 받습니다.

#### Functions Without Return Values (반환 값이 없는 함수)

함수가 반환 타입을 정의하는 건 필수가 아닙니다. 자신의 `String` 값을 반환하기 보단 인쇄하는, 버전의 `greet(person:)` 함수는 이렇습니다:

```swift
func greet(person: String) {
  print("Hello, \(person)!")
}
greet(person: "Dave")
// "Hello, Dave!" 를 인쇄함
```

값을 반환할 필요가 없기 때문에, 함수 정의에 반환 화살표 (`->`) 나 반환 타입이 포함되지 않습니다.

> 엄밀히 말해서, 이 버전의 `greet(person:)` 함수도 여전히 값을 반환 _하며 (does)_, 심지어 반환 값을 정의한게 없어도 그렇습니다. 반환 타입을 정의하지 않은 함수는 `Void` 타입이라는 특수한 값을 반환합니다. 이는 단순히 빈 튜플이며, `()` 라고 씁니다.

함수를 호출할 때는 반환 값을 무시할 수 있습니다:

```swift
func printAndCount(string: String) -> Int {
  print(string)
  return string.count
}
func printWithoutCounting(string: String) {
  let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
// "hello, world" 를 인쇄하고 값 12 를 반환함
printWithoutCounting(string: "hello, world")
// "hello, world" 를 인쇄하지만 값을 반환하진 않음
```

첫 번째 함수인, `printAndCount(string:)` 은, 문자열을 인쇄하고, 그런 다음 문자 개수를 `Int` 로 반환합니다. 두 번째 함수인, `printWithoutCounting(string:)` 은, 첫 번째 함수를 호출하지만, 그것의 반환 값은 무시합니다. 두 번째 함수를 호출할 땐, 메시지는 첫 번째 함수로 여전히 인쇄하지만, 반환 값은 사용하지 않습니다.

> 반환 값을 무시할 순 있지만, 값을 반환할거라고 말한 함수는 반드시 항상 그렇게 해야 합니다. 반환 타입을 정의한 함수가 값의 반환 없이 함수 밑을 빠져나가게 제어하는 건 허용할 수 없으며, 그러한 시도의 결과는 컴파일-시간 에러가 될 것입니다.

#### Functions with Multiple Return Values (반환 값이 여러 개인 함수)

 튜플 타입을 함수 반환 타입으로 사용하면 여러 개의 값을 하나의 복합 반환 값으로 반환할 수 있습니다.

아래 예제는 `minMax(array:)` 라는 함수를 정의하는데, 이는 `Int` 값 배열에서 가장 작은 수와 가장 큰 수를 찾습니다.:

```swift
func minMax(array: [Int]) -> (min: Int, max: Int) {
  var currentMin = array[0]
  var currentMax = array[0]
  for value in array[1..<array.count] {
    if value < currentMin {
      currentMin = value
    } else if value > currentMax {
      currentMax = value
    }
  }
  return (currentMin, currentMax)
}
```

`minMax(array:)` 함수는 두 `Int` 값을 담은 튜플을 반환합니다. 이 값엔 `min` 과 `max` 라는 이름표가 있어서 함수 반환 값을 조회할 때 이름으로 접근할 수 있습니다.

`minMax(array:)` 함수 본문은 `currentMin` 과 `currentMax` 라는 두 작업 변수에 배열의 첫 번째 정수 값을 설정하는 걸로 시작합니다. 함수는 그런 다음 배열 나머지 값을 반복하고 각각의 값을 검사하여 각자 `currentMin` 과 `currentMax` 값보다 큰지 작은지를 확인합니다. 최후엔, 두 `Int` 값들의 튜플로 전체 최소 값과 최대 값을 반환합니다.

함수 반환 타입 부분에서 튜플의 멤버 값에 이름을 붙였기 때문에, 점 구문으로 접근하여 최소와 최대라고 찾은 값을 가져올 수 있습니다:

```swift
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
// "min is -6 and max is 109" 를 인쇄함
```

함수 반환 타입 부분에서 이미 튜플 멤버에 이름을 지정했기 때문에, 함수가 튜플을 반환하는 시점엔 튜플 멤버에 이름을 붙일 필요가 없다는 걸 기록하기 바랍니다.

<p>
<strong id="optional-tuple-return-types-옵셔널-튜플-반환-타입">Optional Tuple Return Types (옵셔널 튜플 반환 타입)</strong>
</p>

함수가 반환할 튜플 타입에서 전체 튜플이 "값이 없을 (no value)" 수도 있는 경우, _옵셔널 (optional)_ 튜플 반환 타입을 사용하면 전체 튜플이 `nil` 일 수 있다는 사실을 반영할 수 있습니다. 옵셔널 튜플 반환 타입을 쓰려면, `(Int, Int)?` 나 `(String, Int, Bool)?` 같이, 튜플 타입의 닫는 괄호 뒤에 물음표를 두면 됩니다.

> `(Int, Int)?` 같은 옵셔널 튜플 타입은 `(Int?, Int?)` 같이 옵셔널 타입을 담은 튜플과는 다른 겁니다.[^optional-tuple-type] 옵셔널 튜플 타입에선, 튜플 안에 있는 각각의 개별 값뿐만 아니라, 전체 튜플이 옵셔널입니다.

위 `minMax(array:)` 함수가 반환한 튜플엔 두 `Int` 값이 담겨 있습니다. 하지만, 함수는 전달된 배열에 어떤 안전성 검사도 하지 않습니다. `array` 인자에 빈 배열이 담겨 있다면, 위에서 정의한, `minMax(array:)` 함수가, `array[0]` 에 접근하려고 할 때 실행시간 에러를 발생시킬 겁니다.

빈 배열을 안전하게 처리하려면, `minMax(array:)` 함수를 옵셔널 튜플 반환 타입으로 작성하여 빈 배열일 땐 `nil` 값을 반환합니다:

```swift
func minMax(array: [Int]) -> (min: Int, max: Int)? {
  if array.isEmpty { return nil }
  var currentMin = array[0]
  var currentMax = array[0]
  for value in array[1..<array.count] {
    if value < currentMin {
      currentMin = value
    } else if value > currentMax {
      currentMax = value
    }
  }
  return (currentMin, currentMax)
}
```

옵셔널 연결[^optional-binding] 을 사용하면 이 버전의 `minMax(array:)` 함수가 반환하는게 실제 튜플 값인지 `nil` 인지를 검사할 수 있습니다:

```swift
if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
  print("min is \(bounds.min) and max is \(bounds.max)")
}
// "min is -6 and max is 109" 를 인쇄함
```

#### Functions With an Implicit Return (암시적으로 반환하는 함수)

전체 함수 본문이 단일 표현식이면, 함수는 그 표현식을 암시적으로 반환합니다.[^implicitly-returns] 예를 들어, 아래의 두 함수는 똑같이 동작합니다:

```swift
func greeting(for person: String) -> String {
  "Hello, " + person + "!"
}
print(greeting(for: "Dave"))
// "Hello, Dave!" 를 인쇄함

func anotherGreeting(for person: String) -> String {
  return "Hello, " + person + "!"
}
print(anotherGreeting(for: "Dave"))
// "Hello, Dave!" 를 인쇄함
```

`greeting(for:)` 함수의 전체 정의는 자신이 반환할 인사 메시지이며, 이는 이런 더 짧은 형식을 사용할 수 있다는 의미입니다. `anotherGreeting(for:)` 함수는 똑같은 인사 메시지를 반환하는데, 더 긴 함수 같이 `return` 키워드를 사용합니다. 단 하나의 `return` 줄만 쓰는 어떤 함수든 `return` 을 생략할 수 있습니다.

[Shorthand Getter Declaration (짧게 줄인 획득자 선언)]({% post_url 2020-05-30-Properties %}#shorthand-getter-declaration-짧게-줄인-획득자-선언) 에서 보게 될 것처럼, 속성 획득자[^property-getter] 도 암시적 반환을 사용할 수 있습니다.

> 암시적 반환 값이라고 쓴 코드는 어떠한 값을 반환할 필요가 있습니다. 예를 들어, `print(13)` 을 암시적 반환 값으로 사용할 순 없습니다. 하지만, `fatalError("Oh no!")` 같은 절대 반환하지 않는 함수[^never-return] 는 암시적 반환 값으로 사용할 수 있는데, 그 암시적 반환은 발생하지 않는다는 걸 스위프트가 알기 때문입니다.

### Function Argument Labels and Parameter Names (함수 인자 이름표와 매개 변수 이름)

각각의 함수 매개 변수엔 _인자 이름표 (argument label)_ 와 _매개 변수 이름 (paramenter name)_ 이 둘 다 있습니다. 인자 이름표는 함수를 호출할 때 사용하며; 함수 호출 안의 각 인자마다 그 앞에 인자 이름표를 씁니다. 매개 변수 이름은 함수 구현부에서 사용합니다. 기본적으로, 매개 변수는 자신의 매개 변수 이름을 인자 이름표로 사용합니다.

```swift
func someFunction (firstParameterName: Int, secondParameterName: Int) {
  // 함수 본문에선, firstParameterName 과 secondParameterName 이
  // 첫 번째와 두 번째 매개 변수의 인자 값을 가리킵니다.
}
someFunction(firstParameterName: 1, secondParameterName: 2)
```

모든 매개 변수엔 반드시 유일한 이름이 있어야 합니다. 여러 매개 변수에 똑같은 인자 이름표가 있는게 가능하긴 하지만, 유일한 인자 이름표가 코드를 더 읽기 쉽게 해줍니다.

#### Specifying Argument Labels (인자 이름표 지정하기)

인자 이름표는 매개 변수 이름 앞에, 공백으로 구분하여, 작성합니다:

```swift
func someFunction(argumentLabel parameterName: Int) {
  // 함수 본문에선, parameterName 이
  // 그 매개 변수의 인자 값을 가리킵니다.
}
```

`greet(person:)` 함수의 변화 중에 사람 이름과 출신지를 입력 받아 인사말을 반환하는 건 이렇습니다:

```swift
func greet(person: String, from hometown: String) -> String {
  return "Hello \(person)! Glad you could visit from \(hometown)."
}
print (greet(person: "Bill", from: "Cupertino"))
// "Hello Bill! Glad you could visit from Cupertino." 를 인쇄함
```

인자 이름표를 사용하면 표현력이 좋은, (일반) 문장-같은 예에 따라 함수를 호출하면서도, 여전히 읽기 쉽고 의도가 명확한 함수 본문을 제공할 수 있게 합니다.

#### Omitting Argument Labels (인자 이름표 생략하기)

매개 변수에 인자 이름표를 하고 싶지 않으면, 그 매개 변수의 인자 이름표를 명시하는 대신 밑줄 (`_`) 을 씁니다.

```swift
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
  // 함수 본문에선, firstParameterName 과 secondParameterName 이
  // 첫 번째와 두 번째 매개 변수의 인자 값을 가리킵니다.
}
someFunction (1, secondParameterName: 2)
```

매개 변수에 인자 이름표가 있으면, _반드시 (must)_ 함수 호출 때도 인자에 이름표가 있어야 합니다.

#### Default Parameter Values (기본 매개 변수 값)

함수의 어떤 함수 매개 변수든 _기본 값 (default value)_ 을 정의하려면 그 매개 변수의 타입 뒤에 매개 변수의 값을 할당하면 됩니다. 기본 값을 정의하면, 함수 호출 때 그 매개 변수를 생략할 수 있습니다.

```swift
func someFunction (parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
  // 이 함수를 호출할 때 두 번째 인자를 생략하면,
  // 함수 본문 안에서 parameterWithDefault 값은 12 입니다.
}
someFunction (parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault 는 6
someFunction (parameterWithoutDefault: 4) // parameterWithDefault 는 12
```

기본 값이 없는 매개 변수를, 기본 값이 있는 매개 변수의 앞인, 함수의 매개 변수 목록 맨 앞에 둡니다. 기본 값이 없는 매개 변수가 대체로 함수의 의미로는 더 중요합니다-이들을 첫 번째로 작성하면, 어떤 기본 매개 변수를 생략하든, 똑같은 함수를 호출하고 있다는 걸 더 알아보기 쉽게 해줍니다.

#### Variadic Parameters (가변 매개 변수)

_가변 매개 변수 (variadic parameter)_ 는 0개 이상의 지정된 타입 값을 받습니다. 가변 매개 변수를 사용하면 함수 호출 때 매개 변수에 다양한 개수의 입력 값을 전달한다는 걸 지정할 수 있습니다. 가변 매개 변수를 작성하려면 매개 변수의 타입 이름 뒤에 마침표 세 개 (`...`) 를 집어 넣으면 됩니다.

가변 매개 변수로 전달한 값은 함수 본문에서 적절한 타입의 배열로 쓸 수 있게 됩니다. 예를 들어, 이름은 `numbers` 고 타입은 `Double...` 인 가변 매개 변수는 함수 본문에서 `[Double]` 타입의 `numbers` 라는 상수 배열로 쓸 수 있습니다.

아래 예제는 어떤 길이의 수 목록이든 _산술 평균 (arithmetic mean)_ (그냥 _평균 (average)_ 이라고도 함) 을 계산합니다:

```swift
func arithmeticMean(_ numbers: Double...) -> Double {
  var total: Double = 0
  for number in numbers {
    total += number
  }
  return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// 이 다섯 수들의 산술 평균인, 3.0 을 반환함
arithmeticMean(3, 8.25, 18.75)
// 이 세 수들의 산술 평균인, 10.0 을 반환함
```

함수엔 여러 개의 가변 매개 변수가 있을 수 있습니다. 가변 매개 변수 뒤에 올 첫 번째 매개 변수엔 인자 이름표가 반드시 있어야 합니다. 인자 이름표는 인자가 가변 매개 변수로 전달된 것인지 가변 매개 변수 뒤에 올 매개 변수로 전달된 것인지 헷갈리지 않게 합니다.

#### In-Out Parameters (입-출력 매개 변수)

함수 매개 변수는 기본적으로 상수입니다. 함수 매개 변수 값을 그 함수 본문 안에서 바꾸려 하는 건 컴파일-시간 에러입니다. 이는 매개 변수 값을 실수로 바꿀 순 없다는 의미입니다. 함수에서 매개 변수 값을 수정하고 싶고, 그렇게 바꾼 걸 함수 호출이 끝난 후에도 붙들고 있고 싶으면, 그 매개 변수를 대신 _입-출력 매개 변수 (in-out parameter)_ 로 정의합니다.

입-출력 매개 변수를 작성하려면 매개 변수 타입 바로 앞에 `inout` 키워드를 두면 됩니다. 입-출력 매개 변수의 값은, 함수 _안으로 입력 (in)_ 하고, 함수에서 수정한 다음, 함수 _밖으로 출력 (out)_ 하여 원본 값을 교체합니다. 입-출력 매개 변수의 동작 및 이와 결합된 컴파일러 최적화에 대한 자세한 논의는, [In-Out Parameters (입-출력 매개 변수)]({% post_url 2020-08-15-Declarations %}#in-out-parameters-입-출력-매개-변수) 부분을 보기 바랍니다.

변수만 입-출력 매개 변수의 인자로 전달할 수 있습니다. 상수나 글자 값[^literal] 은 인자로 전달할 수 없는데, 상수와 글자 값은 수정할 수 없기 때문입니다. 입-출력 매개 변수의 인자로 전달할 땐 변수 이름 바로 앞에 앰퍼샌드 (`&`)[^ampersand] 를 둬서, 함수에서 수정될 수 있다는 걸 지시합니다.

> 입-출력 매개 변수엔 기본 값이 있을 수 없으며, 가변 매개 변수엔 `inout` 을 표시할 수 없습니다.  

`swapTwoInts(_:_:)` 라는 함수의 예는 이렇는데, `a` 와 `b` 라는 두 개의 입-출력 매개 변수가 있습니다:

```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
  let temporaryA = a
  a = b
  b = temporaryA
}
```

`swapTwoInts(_:_:)` 함수는 단순히 `b` 값은 `a` 로, `a` 값은 `b` 로 맞바꿉니다. 함수는 `a` 값을 `temporaryA` 라는 임시 상수에 저장하고, `b` 값을 `a` 에 할당한 다음, `temporaryA` 를 `b` 에 할당함으로써 이 맞바꿈을 수행합니다.

두 개의 `Int` 타입 변수를 가지고 `swapTwoInts(_:_:)` 함수를 호출하면 값들을 맞바꿀 수 있습니다. `someInt` 와 `anotherInt` 를 `swapTwoInts(_:_:)` 함수로 전달할 땐 이름 앞에 접두사로 앰퍼샌드를 둔다는 걸 기록하기 바랍니다:

```swift
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// "someInt is now 107, and anotherInt is now 3" 를 인쇄함
```

위 예제는 `someInt` 와 `anotherInt` 원본 값을 `swapTwoInts(_:_:)` 함수가 수정하는 걸 보여주는데, 심지어 원본을 함수 밖에서 정의한거라도 그렇습니다.

> 입-출력 매개 변수는 함수에서 값을 반환하는 것과 똑같지 않습니다. 위의 `swapTwoInts` 예제는 반환 타입을 정의하지도 값을 반환하지도 않지만, 여전히 `someInt` 와 `anotherInt` 값을 수정합니다. 입-출력 매개 변수는 함수가 자신의 함수 본문 시야 밖으로 효과를 주기 위한 대안입니다.

### Function Types (함수 타입)

모든 함수엔 정해진 _함수 타입 (function type)_ 이 있으며, 함수의 매개 변수 타입과 반환 타입으로 이루어집니다.

예를 들면 다음과 같습니다:

```swift
func addTwoInts(_ a: Int, _ b: Int) -> Int {
  return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
  return a * b
}
```

이 예제는 두 개의 단순한 수학 함수인 `addTwoInts` 와 `multiplyTwoInts` 를 정의합니다. 이 함수들은 각각 두 개의 `Int` 값을 입력 받아, 적절한 수학 연산의 결과인, `Int` 값을 반환합니다.

이 함수의 타입은 둘 다 `(Int, Int) -> Int` 입니다. 이는 다음 처럼 읽을 수 있습니다:

"두 개의 매개 변수가, 둘 다 `Int` 타입이면서, `Int` 타입의 값을 반환하는 함수"

또 다른 예제로, 아무런 매개 변수나 반환 값이 없는 함수는, 이렇습니다:

```swift
func printHelloWorld() {
  print("hello, world")
}
```

이 함수의 타입은 `() -> Void`, 또는 "아무런 매개 변수도 없고, `Void` 를 반환하는 함수" 입니다.

#### Using Function Types (함수 타입 사용하기)

함수 타입은 그냥 스위프트의 다른 어떤 타입인 것 같이 쓸 수 있습니다. 예를 들어, 상수나 변수를 함수 타입으로 정의하고 그 변수에 적절한 함수를 할당할 수 있습니다:

```swift
var mathFunction: (Int, Int) -> Int = addTwoInts
```

이는 다음 처럼 읽을 수 있습니다:

"'두 `Int` 값을 입력 받아, `Int` 값을 반환하는 함수' 타입인, `mathFunction` 이라는 변수를 정의합니다. 이 새로운 변수가 `addTwoInts` 라는 함수를 참조하도록 설정합니다."

`addTwoInts(_:_:)` 함수와 `mathFunction` 변수는 똑같은 타입이므로, 스위프트 타입-검사기가 이 할당을 허용합니다.

할당한 함수를 이제 `mathFunction` 이란 이름으로 호출할 수 있습니다:

```swift
print("Result: \(mathFunction(2, 3))")
// "Result: 5" 를 인쇄함
```

서로 다른 함수도 타입이 똑같이 맞으면 동일한 변수에 할당할 수 있으며, 이는 비-함수 타입과 똑같은 방식입니다:

```swift
mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")
// "Result: 6" 을 인쇄함
```

다른 어떤 타입에서도 그러듯, 함수를 상수나 변수에 할당할 때도 스위프트가 함수 타입을 추론하도록 내버려둘 수 있습니다.

```swift
let anotherMathFunction = addTwoInts
// anotherMathFunction 은 (Int, Int) -> Int 타입이라고 추론함
```

#### Function Types as Parameter Types (매개 변수 타입으로써의 함수 타입)

`(Int, Int) -> Int` 와 같은 함수 타입은 또 다른 함수의 매개 변수 타입으로 사용할 수 있습니다. 이는 함수 구현 일부를 함수를 호출한 쪽으로 내버려둬서 함수 호출 때 제공할 수 있도록 합니다.

위에 있는 수학 함수의 결과를 인쇄하는 예제는 이렇습니다:

```swift
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
  print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// "Result: 8" 를 인쇄함
```

이 예제는 `printMathResult(_:_:_:)` 라는 함수를 정의하는데, 여기엔 세 개의 매개 변수가 있습니다. 첫 번째 매개 변수는 `mathFunction` 이고, `(Int, Int) -> Int` 타입입니다. 그 타입의 어떤 함수든 이 첫 번째 매개 변수의 인자로 전달할 수 있습니다. 두 번째와 세 번째 매개 변수는 `a` 와 `b` 이며, 둘 다 `Int` 타입입니다. 제공한 수학 함수의 두 입력 값으로 이들을 사용합니다.

`printMathResult(_:_:_:)` 를 호출할 땐, `addTwoInts(_:_:)` 함수와, 정수 값 `3` 및 `5` 를 전달합니다. 제공한 함수를 `3` 과 `5` 로 호출하며, `8` 이라는 결과를 인쇄합니다.

`printMathResult(_:_:_:)` 의 역할은 적절한 타입의 수학 함수 호출 결과를 인쇄하는 겁니다. 그 함수 구현이 실제로 뭘하든 문제 삼지 않습니다-함수가 올바른 타입인지만 문제 삼습니다. 이는 `printMathResult(_:_:_:)` 가 자신의 일부 기능을 함수를 호출한 쪽으로 타입-안전하게[^type-safe] 넘기도록 합니다.

#### Function Types as Return Types (반환 타입으로써의 함수 타입)

함수 타입은 또 다른 함수의 반환 타입으로 사용할 수 있습니다. 이렇게 하려면 반환하는 함수의 반환 화살표 (`->`) 바로 뒤에 완성된 함수 타입을 작성하면 됩니다.

다음 예제는 두 개의 단순한 함수인 `stepForward(_:)` 와 `stepBackward(_:)` 를 정의합니다. `stepForward(_:)` 함수는 자신의 입력 값보다 하나 큰 값을 반환하고, `stepBackward(_:)` 함수는 자신의 입력 값보다 하나 작은 값을 반환합니다. 두 함수는 모두 `(Int) -> Int` 타입입니다:

```swift
func stepForward(_ input: Int) -> Int {
  return input + 1
}
func stepBackward(_ input: Int) -> Int {
  return input - 1
}
```

`chooseStepFunction(backward:)` 라는, 반환 타입이 `(Int) -> Int` 인, 함수는 이렇습니다. `chooseStepFunction(backward:)` 함수는 `backward` 라는 불리언 매개 변수에 기반하여 `stepForward(_:)` 함수나 `stepBackward(_:)` 함수를 반환합니다:

```swift
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
  return backward ? stepBackward : stepForward
}
```

이제 `chooseStepFunction(backward:)` 를 사용하여 이 방향 또는 저 방향으로 걸어가는 함수를 구할 수 있습니다:

```swift
var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero 는 이제 stepBackward() 함수를 참조함
```

위 예제는 `currentValue` 변수가 점점 더 0에 가까워지려면 걷는 방향이 양이어야 하는지 음이어야 하는지를 결정합니다. `currentValue` 의 초기 값이 `3` 인데, 이는 `currentValue > 0` 가 `true` 를 반환하여, `chooseStepFunction(backward:)` 가 `stepBackward(_:)` 함수를 반환하게 한다는 의미입니다. 반환한 함수로의 참조는 `moveNearerToZero` 라는 상수에 저장합니다.

이제 `moveNearerToZero` 가 올바른 함수를 참조하므로, 이것으로 영까지 셀 수 있습니다:

```swift
print("Counting to zero:")
// 영까지 셈:
while currentValue != 0 {
  print("\(currentValue)... ")
  currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// 3...
// 2...
// 1...
// 영!
```

### Nested Functions (중첩 함수)

지금까지 이 장에서 마주쳤던 모든 함수는 _전역 함수 (global functions)_ 예제인데, 이는 전체 시야 범위[^global-scope] 에서 정의합니다. 함수를 다른 함수 본문 안에서 정의할 수도 있는데, 이는 _중첩 함수 (nested functions)_ 라고 합니다.

중첩 함수는 기본적으로 외부 세계로부터 숨겨져 있지만, 자신을 둘러싼 함수에선 여전히 호출하여 쓸 수 있습니다. (중첩 함수를) 둘러싼 함수는 중첩 함수를 반환하여 이를 또 다른 시야 범위에서 사용하도록 허용할 수도 있습니다.

위의 `chooseStepFunction(backward:)` 예제도 중첩 함수를 써서 반환하도록 재작성할 수 있습니다:

```swift
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
  func stepForward(input: Int) -> Int { return input + 1 }
  func stepBackward(input: Int) -> Int { return input - 1 }
  return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero 는 이제 중첩 함수인 stepForward() 를 참조함
while currentValue != 0 {
  print("\(currentValue)... ")
  currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// 영!
```

### 다음 장

[Closures (클로저; 잠금 블럭) > ]({% post_url 2020-03-03-Closures %})

### 참고 자료

[^Functions]: 이 글에 대한 원문은 [Functions](https://docs.swift.org/swift-book/LanguageGuide/Functions.html) 에서 확인할 수 있습니다.

[^hyphen]: '하이픈' 이라고도 하는 '붙임표 (hyphen)' 는, 두 낱말을 합쳐서 하나의 낱말로 만들거나 낱말의 음절을 나눌 때 사용합니다. '대시 (dash)' 와는 기능이 다릅니다. 붙임표에 대한 더 자세한 정보는 위키피디아의 [Hyphen](https://en.wikipedia.org/wiki/Hyphen) 항목 및 [붙임표](https://ko.wikipedia.org/wiki/붙임표) 항목을 참고하기 바랍니다.

[^optional-tuple-type]: `(Int, Int)?` 는 전체 튜플이 옵셔널이라는 의미인 반면, `(Int?, Int?)` 는 튜플 각각의 멤버는 옵셔널이지만 전체 튜플은 옵셔널이 아닌 경우입니다.

[^implicitly-returns]: '암시적으로 반환한다 (implicitly returns)' 는 것은 `return` 을 쓰지 않아도 반환한다는 의미입니다.

[^never-return]: 절대 반환하지 않는 함수에 대한 더 자세한 정보는, [Declarations (선언)]({% post_url 2020-08-15-Declarations %}) 장의 [Functions that Never Return (절대 반환하지 않는 함수)]({% post_url 2020-08-15-Declarations %}#functions-that-never-return-절대-반환하지-않는-함수) 부분을 참고하기 바랍니다. 

[^type-safe]: 여기서 '타입-안전한 방식 (type-safe way)' 이라는 것은 스위프트가 기본적으로 제공하는 '타입 추론 (type inference)' 과 '타입 검사 (type check)' 기능을 사용할 수 있다는 것을 의미합니다. 이 내용은 [The Basic (기초)]({% post_url 2016-04-24-The-Basics %}) 부분의 [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)]({% post_url 2016-04-24-The-Basics %}#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 에서 설명한 바 있습니다.

[^global-scope]: '전체 시야 범위 (global scope)' 를 보통 '전역' 이라고 합니다.
