---
layout: post
comments: true
title:  "Swift 5.7: Functions (함수)"
date:   2020-06-02 10:00:00 +0900
categories: Swift Language Grammar Function
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [Functions](https://docs.swift.org/swift-book/LanguageGuide/Properties.html) 부분[^Functions]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Functions (함수)

_함수 (functions)_ 는 '특정 임무를 수행하는 독립된 (self-contained) 코드 조각' 입니다. 함수엔 뭘하는 지 식별할 이름을 부여하며, 필요할 때 이 이름을 사용하여 임무를 수행할 함수를 "호출 (call)" 합니다.

스위프트의 통일된 함수 구문은 '매개 변수 이름이 없는 단순한 C-스타일 함수부터 각각의 매개 변수마다 이름과 인자 이름표 (argument labels) 가 있는 복잡한 오브젝티브-C-스타일 메소드' 까지 어떤 것이든 표현할 만큼 충분히 유연합니다. 매개 변수는 함수 호출이 단순해지도록 기본 (default) 값을 제공할 수도 있고, 함수 실행을 한 번 완료하고 나면 전달한 변수를 수정하는, 입-출력 (in-out) 매개 변수로 전달할 수도 있습니다.

스위프트의 모든 함수는, 함수의 매개 변수 타입과 반환 타입으로 구성된, 타입을 가집니다. 스위프트의 다른 어떤 타입 같이 이 타입을 사용할 수 있는데, 이는 다른 함수의 매개 변수로 함수를 전달하고, 함수가 함수를 반환하는 걸, 하기 쉽게 해줍니다. 함수를 다른 함수 안에 작성하면 유용한 기능을 중첩 함수 영역 안에 은닉할 수도 있습니다.

### Defining and Calling Functions (함수 정의하기와 호출하기)

함수를 정의할 때, _매개 변수 (parameters)_ 라고 하는, 이름과, 타입을 지정한 값을 옵션으로 하나 이상 정의할 수 있습니다. 함수를 마칠 때, _반환 타입 (return type)_ 이라고 하는, 출력으로 되돌려 줄 값 타입을 옵션으로 정의할 수도 있습니다.

모든 함수에는, 함수가 수행할 임무를 설명하는, _함수 이름 (function name)_ 이 있습니다. 함수를 사용하려면, 이름을 가지고 함수를 "호출" 하며 함수 매개 변수 타입과 일치하는 (_인자 (arguments)_ 라고 하는) 입력 값을 전달합니다. 함수 인자는 반드시 항상 함수 매개 변수 목록과 똑같은 순서로 제공해야 합니다.

아래 예제에 있는 함수는, 하는 것이-사람 이름을 입력으로 취하여 해당 사람에 대한 인사말을 반환-하는 것이기 때문에, `greet(person:)` 라고 합니다. 이걸 해내기 위해, `person` 이라는 `String` 값-입력 매개 변수 하나와, 해당 사람에 대한 인사말을 담을, `String` 반환 타입을 정의합니다.

```swift
func greet(person: String) -> String {
  let greeting = "Hello, " + person + "!"
  return greeting
}
```

이 모든 정보를, `func` 키워드로 접두사를 붙인, 함수 _정의 (definition)_ 로 끌어 모읍니다. 함수 반환 타입은 (대쉬 기호 다음에 오른쪽 꺽쇠 괄호 기호를 붙인) _반환 화살표 (return arrow)_ `->` 와, 그 다음의 반환할 타입의 이름으로 지시합니다.

정의는 함수가 뭘 하는 지, 뭘 받길 예상하는 지, 그리고 마칠 때 뭘 반환할 지 설명합니다. 정의는 코드 어디서든 함수 호출을 헷갈리지 않고 쉽게 하도록 합니다:

```swift
print(greet(person: "Anna"))
// "Hello, Anna!" 를 인쇄함
print(greet(person: "Brian"))
// "Hello, Brian!" 를 인쇄함
```

`greet(person:)` 함수는, `greet(person: "Anna")` 같이, `person` 인자 이름표 뒤에 `String` 값을 전달하여 호출합니다. 함수가 `String` 값을 반환하기 때문에, 위에 보는 것처럼, `print(_:separator:terminator:)` 함수 안에 `greet(person:)` 함수를 포장한 채로 호출하여 해당 문자열을 인쇄하고 반환 값을 볼 수 있습니다.

> `print(_:separator:terminator:)` 함수는 자신의 첫 번째 인자에 대한 이름표를 가지지 않으며, 다른 인자들은 기본 값을 가지고 있기 때문에 옵션입니다. 이런 함수 구문의 변화는 아래의 [Function Argument Labels and Parameter Names (함수의 인자 이름표와 매개 변수 이름)](#function-argument-labels-and-parameter-names-함수의-인자-이름표와-매개-변수-이름) 부분과 [Default Parameter Values (기본 매개 변수 값)](#default-parameter-values-기본-매개-변수-값) 부분에서 논의합니다.

`greet(person:)` 함수 본문은 `greeting` 이라는 새로운 `String` 상수를 정의하고 단순한 인사말 메시지를 설정하는 것으로 시작합니다. 그런 다음 `return` 키워드로 이 인사말을 함수 밖으로 되돌려 줍니다. `return greeting` 이라는 코드 줄에서, 함수 실행을 종료하고 현재 `greeting` 값을 반환합니다.

서로 다른 입력 값을 가지고 `greet(person:)` 함수를 여러 번 호출할 수 있습니다. 위 예제는 `"Anna"` 라는 입력 값과, `"Brian"` 이라는 입력 값을 가지고 호출하면 무슨 일이 발생하는 지를 보여줍니다. 함수는 각 경우마다 맞춤식 인사말을 반환합니다.

메시지 생성문과 반환문을 한 줄로 조합하면, 이 함수 본문을 더 짧게 만들 수 있습니다:

```swift
func greetAgain(person: String) -> String {
  return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))
// "Hello again, Anna!" 를 인쇄함
```

### Function Parameters and Return Values (함수의 매개 변수와 반환 값)

스위프트의 함수 매개 변수와 반환 값은 극도로 유연합니다. '이름 없는 단일 매개 변수를 가진 단순한 보조용 (utility) 함수' 부터 '풍부한 표현력의 매개 변수 이름과 서로 다른 매개 변수 옵션을 가진 복잡한 함수' 까지 어떤 것이든 정의할 수 있습니다.

#### Functions Without Parameters (매개 변수가 없는 함수)

함수에서 입력 매개 변수를 정의하는 건 필수가 아닙니다. 다음은, 호출할 때마다 항상 똑같은 `String` 메시지를 반환하는, 입력 매개 변수 없는 함수입니다:

```swift
func sayHelloWorld() -> String {
  return "hello, world"
}
print(sayHelloWorld())
// "hello, world" 를 인쇄함
```

어떤 매개 변수도 취하지 않더라도, 함수 정의에서 함수 이름 뒤에 여전히 괄호가 필요합니다. 함수를 호출할 때도 함수 이름 뒤에 빈 괄호 쌍이 있어야 합니다.

#### Functions with Multiple Parameters (매개 변수가 여러 개인 함수)

함수는, 함수 괄호 안에, 쉼표로 구분하여, 작성한, 여러 개의 입력 매개 변수를 가질 수 있습니다.

이 함수는 입력으로 사람 이름과 이미 인사했는 지를 취하여, 해당 사람에 대한 적절한 인사말을 반환합니다:

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

`greet(person:alreadyGreeted:)` 함수는 괄호 안에 `person` 이름표의 `String` 인자 값과 `alreadyGreeted` 이름표의 `Bool` 인자 값 둘 다를, 쉼표로 구분하여, 전달함으로써 호출합니다. 이 함수는 앞 부분에서 본 `greet(person:)` 함수와 서로 별개라는 걸 기억하기 바랍니다. 두 함수 다 `greet` 으로 시작하는 이름을 가지긴 하지만, `greet(person:alreadyGreeted:)` 함수는 두 인자를 취하지만 `greet(person:)` 함수는 하나만 취합니다.

#### Functions Without Return Values (반환 값이 없는 함수)

함수에서 반환 타입을 정의하는 건 필수가 아닙니다. 다음은, 자신의 `String` 값을 반환하기 보단 인쇄하는, 버전의 `greet(person:)` 함수입니다:

```swift
func greet(person: String) {
  print("Hello, \(person)!")
}
greet(person: "Dave")
// "Hello, Dave!" 를 인쇄함
```

값을 반환할 필요가 없기 때문에, 함수 정의가 반환 화살표 (`->`) 나 반환 타입을 포함하지 않습니다.

> 엄밀히 말해서, 이 버전의 `greet(person:)` 함수가, 반환 값을 정의하지 않았을지라도, 여전히 값을 반환 _합니다 (does)_. 반환 타입을 정의하지 않은 함수는 `Void` 타입의 특수한 값을 반환합니다. 이는 단순히 '빈 튜플 (tuple)' 이며, `()` 라고 작성합니다.

함수를 호출할 땐 반환 값을 무시할 수 있습니다:

```swift
func printAndCount(string: String) -> Int {
  print(string)
  return string.count
}
func printWithoutCounting(string: String) {
  let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
// "hello, world" 를 인쇄하고 12 라는 값을 반환함
printWithoutCounting(string: "hello, world")
// "hello, world" 를 인쇄하지만 값을 반환하지 않음
```

첫 번째 함수인, `printAndCount(string:)` 은, 문자열을 인쇄한 다음, 문자 개수를 `Int` 로 반환합니다. 두 번째 함수인, `printWithoutCounting(string:)` 은, 첫 번째 함수를 호출하지만, 반환 값은 무시합니다. 두 번째 함수를 호출할 때, 첫 번째 함수에 의해 메시지는 여전히 인쇄하지만, 반환 값을 사용하진 않습니다.

> 반환 값을 무시할 순 있지만, 값을 반환할거라고 한 함수는 반드시 항상 그래야 합니다. 반환 타입을 정의한 함수는 값을 반환하지 않고 함수 밑을 빠져나가는 제어를 허용하지 않으며, 그럴려는 시도는 컴파일-시간 에러가 될 것입니다.

#### Functions with Multiple Return Values (반환 값이 여러 개인 함수)

튜플 타입을 함수의 반환 타입으로 사용하면 하나의 복합 반환 값으로 여러 개의 값을 반환할 수 있습니다.

아래 예제는 `minMax(array:)` 라는, `Int` 값 배열에서 가장 작은 수와 가장 큰 수를 찾는, 함수를 정의합니다:

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

`minMax(array:)` 함수는 두 `Int` 값을 담은 튜플을 반환합니다. 이 값에는 `min` 과 `max` 라는 이름표가 붙어 있어서 함수 반환 값을 조회할 때 이름으로 접근할 수 있습니다.

`minMax(array:)` 함수 본문은 `currentMin` 과 `currentMax` 라는 두 작업 변수에 배열의 첫 번째 정수 값을 설정하는 것으로 시작합니다. 그런 다음 함수가 배열의 나머지 값들을 반복하며 각각의 값이 각자 `currentMin` 과 `currentMax` 값보다 더 큰 지 작은 지를 검사합니다. 최종적으로, 전체 최소 및 최대 값을 두 `Int` 값의 튜플로써 반환합니다.

튜플의 멤버 값은 함수 반환 타입에서 이름을 붙였기 때문에, 점 구문 (dot syntax) 으로 접근해서 최소 및 최대 값을 가져올 수 있습니다:

```swift
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
// "min is -6 and max is 109" 를 인쇄함
```

튜플 멤버 이름을 함수 반환 타입에서 이미 지정했기 때문에, 함수가 튜플을 반환하는 시점에는 이름을 붙일 필요가 없다는 걸 기억하기 바랍니다.

<p>
<strong id="optional-tuple-return-types-옵셔널-튜플-반환-타입">Optional Tuple Return Types (옵셔널 튜플 반환 타입)</strong>
</p>

함수가 반환하는 튜플 타입에서 전체 튜플의 "값이 없을 (no value)" 가능성이 있는 경우, _옵셔널 (optional)_ 튜플 반환 타입을 사용하면 전체 튜플이 `nil` 일 수 있다는 사실을 반영할 수 있습니다. 옵셔널 튜플 반환 타입은, '`(Int, Int)?` 나 `(String, Int, Bool)?` 같이, 튜플 타입 닫는 괄호 뒤에 물음표를 둬서 작성합니다.

> `(Int, Int)?` 같은 '옵셔널 튜플 타입' 은 `(Int?, Int?)` 같이 '옵셔널 타입을 담은 튜플' 과는 다릅니다.[^optional-tuple-type] 옵셔널 튜플 타입에선, 튜플 안의 각 개별 값만이 아니라, 전체 튜플이 옵셔널입니다.

위 `minMax(array:)` 함수는 두 `Int` 값을 담은 튜플을 반환합니다. 하지만, 전달한 배열에 대한 어떤 안전성 검사도 함수가 하지 않습니다. `array` 인자가 빈 배열을 담고 있다면, 위에 정의한, `minMax(array:)` 함수가, `array[0]` 에 접근하려고 할 때 실행시간 에러를 발동할 것입니다.

빈 배열을 안전하게 처리하려면, 옵셔널 튜플 반환 타입을 가진 `minMax(array:)` 함수를 작성하여 배열이 비었을 땐 `nil` 값을 반환합니다:

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

옵셔널 연결 (optional binding) 을 사용하면 이 버전의 `minMax(array:)` 함수가 실제 튜플 값을 반환하는 지 `nil` 을 반환하는 지 검사할 수 있습니다:

```swift
if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
  print("min is \(bounds.min) and max is \(bounds.max)")
}
// "min is -6 and max is 109" 를 인쇄함
```

#### Functions With an Implicit Return (암시적으로 반환하는 함수)

전체 함수 본문이 단일 표현식인 경우, 함수가 해당 표현식을 암시적으로 반환합니다. 예를 들어, 아래의 두 함수는 똑같이 동작합니다:

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

전체 `greeting(for:)` 함수 정의가 자신이 반환할 인사말 메시지인데, 이는 이런 더 짧은 형식을 사용할 수 있다는 걸 의미합니다. `anotherGreeting(for:)` 함수는, 더 긴 함수 처럼 `return` 키워드를 써서, 동일한 인사말 메시지를 반환합니다. 단 하나의 `return` 줄만으로 작성한 어떤 함수든 `return` 을 생략할 수 있습니다.

[Shorthand Getter Declaration (짧게 줄인 획득자 선언)]({% post_url 2020-05-30-Properties %}#shorthand-getter-declaration-짧게-줄인-획득자-선언) 에서 볼 것처럼, '속성 획득자 (property getter)' 도 암시적인 반환을 사용할 수 있습니다.

> 암시적인 반환 값이라고 작성한 코드는 어떠한 값을 반환할 필요가 있습니다. 예를 들어, `fatalError("Oh no!")` 나 `print(13)` 을 암시적인 반환 값으로 사용할 순 없습니다.

### Function Argument Labels and Parameter Names (함수 인자 이름표와 매개 변수 이름)

각각의 함수 매개 변수에는 _인자 이름표 (argument label)_ 와 _매개 변수 이름 (paramenter name)_ 가 둘 다 있습니다. 인자 이름표는 함수를 호출할 때 사용하는데; 각각의 인자 앞에 자신의 인자 이름표를 가지고 함수 호출을 작성합니다. 매개 변수 이름은 함수 구현에서 사용합니다. 기본적으로는, 매개 변수가 매개 변수 이름을 자신의 인자 이름표로 사용합니다.

```swift
func someFunction (firstParameterName: Int, secondParameterName: Int) {
  // 함수 본문에서, firstParameterName 과 secondParameterName 은
  // 첫 번째 및 두 번째 매개 변수의 인자 값을 참조합니다.
}
someFunction(firstParameterName: 1, secondParameterName: 2)
```

모든 매개 변수는 반드시 유일한 이름을 가져야 합니다. 여러 개의 매개 변수가 동일한 인자 이름표를 가지는 게 가능은 하지만, 유일한 인자 이름표는 코드를 더 쉽게 이해하도록 도와줍니다.

#### Specifying Argument Labels (인자 이름표 지정하기)

인자 이름표는, 매개 변수 이름 앞에, 공백으로 구분하여, 작성합니다:

```swift
func someFunction(argumentLabel parameterName: Int) {
  // 함수 본문에서, parameterName 은
  // 해당 매개 변수의 인자 값을 참조합니다.
}
```

다음은 `greet(person:)` 함수가 변하여 사람 이름과 출신지를 취하고 인사말을 반환하도록 한 것입니다:

```swift
func greet(person: String, from hometown: String) -> String {
  return "Hello \(person)! Glad you could visit from \(hometown)."
}
print (greet(person: "Bill", from: "Cupertino"))
// "Hello Bill! Glad you could visit from Cupertino." 를 인쇄함
```

인자 이름표를 사용하면, 이해가 쉽고 의도가 명확한 함수 본문을 제공하면서도, 풍부한 표현력을 가진, 일반 문장-같은 관례에 따라 함수를 호출하도록 허용합니다.

#### Omitting Argument Labels (인자 이름표 생략하기)

매개 변수의 인자 이름표를 원하지 않으면, 해당 매개 변수에 대한 명시적인 인자 이름표 대신 _밑줄 (underscore;_ `_` _)_ 을 작성합니다.

```swift
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
  // 함수 본문에서, firstParameterName 과 secondParameterName 은
  // 첫 번째 및 두 번째 매개 변수의 인자 값을 참조합니다.
}
someFunction (1, secondParameterName: 2)
```

매개 변수에 인자 이름표가 있으면, 함수를 호출할 때 인자에 _반드시 (must)_ 이름표를 붙여야 합니다.

#### Default Parameter Values (기본 매개 변수 값)

해당 매개 변수 타입 뒤에 값을 할당함으로써 어떤 함수 매개 변수에든 _기본 값 (default value)_ 을 정의할 수 있습니다. 기본 값을 정의하면, 함수를 호출할 때 해당 매개 변수를 생략할 수 있습니다.

```swift
func someFunction (parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
  // 이 함수를 호출할 때 두 번째 인자를 생략하면,
  // parameterWithDefault 값이 함수 본문 안에서 12 가 됩니다.
}
someFunction (parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault 는 6 임
someFunction (parameterWithoutDefault: 4) // parameterWithDefault 는 12 임
```

기본 값 없는 매개 변수는, 기본 값 있는 매개 변수 앞인, 함수 매개 변수 목록 맨 앞에 둡니다. 기본 값 없는 매개 변수가 함수 의미상 대체로 더 중요합니다-이를 먼저 작성하면, 어떤 기본 매개 변수를 생략하든 상관없이, 동일 함수를 호출하고 있음을 더 인식하기 쉽게 해줍니다.

#### Variadic Parameters (가변 매개 변수)

_가변 매개 변수 (variadic parameter)_ 는 특정 타입의 값을 0 개 이상 받아 들입니다. 가변 매개 변수는 함수 호출할 때 매개 변수에다가 다양한 개수의 입력 값을 전달할 수 있음을 지정하고자 사용합니다. 매개 변수 타입 이름 뒤에 마침표 문자 세 개 (`...`) 를 집어 넣어서 가변 매개 변수를 작성합니다.

가변 매개 변수에 전달한 값은 함수 본문 안에서 적절한 타입의 배열로 사용 가능합니다. 예를 들어, `numbers` 라는 이름과 `Double...` 이라는 타입을 가진 가변 매개 변수는 함수 본문 안에서 `[Double]` 타입의 `numbers` 라는 상수 배열로 사용 가능합니다.

아래 예제는 어떤 길이의 수 목록에 대한 _산술 평균 (arithmetic mean)_ (또는 그냥 _평균 (average)_ 이라고 함) 을 계산합니다:

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

함수에는 여러 개의 가변 매개 변수가 있을 수 있습니다. 가변 매개 변수 뒤에 오는 첫 번째 매개 변수에는 반드시 인자 이름표가 있어야 합니다. 인자 이름표는 인자가 가변 매개 변수로 전달됐는 지 가변 매개 변수 뒤에 오는 매개 변수로 전달됐는 지 헷갈리지 않도록 합니다.

#### In-Out Parameters (입-출력 매개 변수)

기본적으로 함수 매개 변수는 상수입니다. 해당 함수 본문 안에서 함수 매개 변수 값을 바꾸려고 하면 컴파일-시간 에러가 됩니다. 이는 매개 변수 값을 실수로 바꿀 순 없다는 의미입니다. 함수에서 매개 변수 값을 수정하고 싶고, 함수 호출이 끝난 후에도 이렇게 바꾼 걸 지속하고 싶으면, 해당 매개 변수를 _입-출력 매개 변수 (in-out parameter)_ 로 대신 정의합니다.

매개 변수 타입 바로 앞에 `inout` 키워드를 둬서 입-출력 매개 변수를 작성합니다. 입-출력 매개 변수는 원본 값을 교체하려고, 함수 안으로 _입력 (in)_ 하여, 함수가 수정한 다음, 함수 밖으로 _출력 (out)_ 되는 값을 가집니다. 입-출력 매개 변수 및 (이와) 결합된 컴파일러 최적화의 동작에 대한 더 자세한 논의는, [In-Out Parameters (입-출력 매개 변수)]({% post_url 2020-08-15-Declarations %}#in-out-parameters-입-출력-매개-변수) 부분을 보도록 합니다.

변수만 입-출력 매개 변수 인자로 전달할 수 있습니다. 상수나 글자 값 (literal) 은 인자로 전달할 수 없는데, 상수와 글자 값은 수정할 수 없기 때문입니다. 입-출력 매개 변수의 인자로 전달할 때는, 함수가 수정할 수 있음을 지시하기 위해, 변수 이름 바로 앞에 '앰퍼샌드 (ampersand; `&`)' 를 붙입니다.

> 입-출력 매개 변수는 기본 (default) 값을 가질 수 없으며, 가변 매개 변수는 `inout` 으로 표시할 수 없습니다.  

다음 예제는, `a` 와 `b` 라는 두 입-출력 매개 변수를 가진, `swapTwoInts(_:_:)` 라는 함수입니다:

```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
  let temporaryA = a
  a = b
  b = temporaryA
}
```

`swapTwoInts(_:_:)` 함수는 `b` 값을 `a` 로, `a` 값을 `b` 로, 단순히 맞바꿉니다. 함수는 `a` 값을 `temporaryA` 라는 임시 상수에 저장하고, `b` 값을 `a` 에 할당한 다음, `temporaryA` 를 `b` 에 할당함으로써 이 맞바꿈을 수행합니다.

자신의 값을 맞바꿀 두 `Int` 타입 변수를 가지고 `swapTwoInts(_:_:)` 함수를 호출할 수 있습니다. `swapTwoInts(_:_:)` 함수에 전달할 때 `someInt` 와 `anotherInt` 이름 앞에는 '앰퍼샌드' 접두사를 붙인다는 걸 기억하기 바랍니다:

```swift
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// "someInt is now 107, and anotherInt is now 3" 를 인쇄함
```

위 예제는, 원래의 `someInt` 와 `anotherInt` 를 함수 밖에서 정의했을지라도, `swapTwoInts(_:_:)` 함수가 이들의 원본 값을 수정함을 보여줍니다.

> 입-출력 매개 변수는 함수의 값 반환과 똑같지 않습니다. 위의 `swapTwoInts` 예제는 반환 타입을 정의하지도 값을 반환하지도 않지만, 여전히 `someInt` 와 `anotherInt` 값을 수정합니다. 입-출력 매개 변수는 함수가 자신의 함수 본문 영역 밖으로 효과를 주기 위한 대안입니다.

### Function Types (함수 타입)

모든 함수는, 함수의 매개 변수 타입과 반환 타입으로 이루어지는, 특정한 _함수 타입 (function type)_ 을 가집니다.

예를 들면 다음과 같습니다:

```swift
func addTwoInts(_ a: Int, _ b: Int) -> Int {
  return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
  return a * b
}
```

이 예제는 `addTwoInts` 와 `multiplyTwoInts` 라는 단순한 수학 함수 두 개를 정의합니다. 이 함수는 각각 두 개의 `Int` 값을 취하여, 적절한 수학 연산의 결과인, `Int` 값을 반환합니다.

이 함수 둘 다 타입이 `(Int, Int) -> Int` 입니다. 이는 다음 처럼 이해할 수 있습니다:

"둘 다 `Int` 타입인, 매개 변수 두 개를 가지고, `Int` 타입의 값을 반환하는 함수"

다음은, 매개 변수나 반환 값이 없는 함수를 위한, 또 다른 예제입니다:

```swift
func printHelloWorld() {
  print("hello, world")
}
```

이 함수의 타입은 `() -> Void`, 또는 "매개 변수가 없고, `Void` 를 반환하는 함수" 입니다.

#### Using Function Types (함수 타입 사용하기)

함수 타입은 스위프트의 다른 어떤 타입인 것 같이 사용할 수 있습니다. 예를 들어, 상수나 변수를 함수 타입으로 정의하고 해당 변수에 적절한 함수를 할당할 수 있습니다:

```swift
var mathFunction: (Int, Int) -> Int = addTwoInts
```

이는 다음 처럼 이해할 수 있습니다:

"'두 `Int` 값을 취하고, `Int` 값을 반환하는 함수' 타입인, `mathFunction` 이라는 변수를 정의합니다. 이 새 변수가 `addTwoInts` 라는 함수를 참조하도록 설정합니다."

`addTwoInts(_:_:)` 함수는 `mathFunction` 변수와 똑같은 타입이므로, 스위프트 타입-검사기가 이 할당을 허용합니다.

이제 할당한 함수를 `mathFunction` 이란 이름으로 호출할 수 있습니다:

```swift
print("Result: \(mathFunction(2, 3))")
// "Result: 5" 를 인쇄함
```

타입이 동일하게 일치하는 서로 다른 함수는, 함수아닌 타입과 똑같이, 동일한 변수에 할당할 수 있습니다.   

```swift
mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")
// "Result: 6" 을 인쇄함
```

다른 어떤 타입 처럼, 상수나 변수에 함수를 할당할 때 스위프트가 함수 타입을 추론하게 내버려둘 수 있습니다.

```swift
let anotherMathFunction = addTwoInts
// anotherMathFunction 은 (Int, Int) -> Int 타입이라고 추론함
```

#### Function Types as Parameter Types (매개 변수 타입으로써의 함수 타입)

`(Int, Int) -> Int` 와 같은 함수 타입은 또 다른 함수의 매개 변수 타입으로 사용할 수 있습니다. 이는 함수를 호출할 때 함수 구현 일부를 함수 호출한 쪽이 제공하게 내버려 두게 합니다.

다음 예제는 위에 있는 수학 함수의 결과를 인쇄합니다:

```swift
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
  print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// "Result: 8" 를 인쇄함
```

이 예제는, 세 개의 매개 변수를 가진, `printMathResult(_:_:_:)` 라는 함수를 정의합니다. 첫 번째 매개 변수는 `mathFunction` 이며, `(Int, Int) -> Int` 타입입니다. 해당 타입의 어떤 함수든 이 첫 번째 매개 변수의 인자로 전달할 수 있습니다. 두 번째와 세 번째 매개 변수는 `a` 와 `b` 이며, 둘 다 `Int` 타입입니다. 이들은 제공한 수학 함수의 두 입력 값으로 사용합니다.

`printMathResult(_:_:_:)` 를 호출할 때, `addTwoInts(_:_:)` 함수와, 정수 `3` 과 `5` 를 전달합니다. `3` 과 `5` 를 가지고 제공한 함수를 호출하고, `8` 이라는 결과를 인쇄합니다.

`printMathResult(_:_:_:)` 의 역할은 적절한 타입의 수학 함수 호출 결과를 인쇄하는 것입니다. 해당 함수 구현이 실제로 뭘 하는 지는 중요하지 않습니다-함수가 올바른 타입인 것만이 중요합니다. 이는 `printMathResult(_:_:_:)` 가 자신의 기능 일부를 타입-안전하게[^type-safe] 함수를 호출한 쪽으로 넘기게 합니다.

#### Function Types as Return Types (반환 타입으로써의 함수 타입)

함수 타입을 또 다른 함수의 반환 타입으로 사용할 수 있습니다. 이렇게 하려면 반환할 함수의 반환 화살표 (`->`) 바로 뒤에 완전한 함수 타입을 작성하면 됩니다.

다음 예제는 `stepForward(_:)` 와 `stepBackward(_:)` 라는 단순한 두 함수를 정의합니다. `stepForward(_:)` 함수는 자신의 입력 값보다 하나 큰 값을 반환하고, `stepBackward(_:)` 함수는 자신의 입력 값보다 하나 작은 값을 반환합니다. 두 함수 모두 `(Int) -> Int` 타입입니다:

```swift
func stepForward(_ input: Int) -> Int {
  return input + 1
}
func stepBackward(_ input: Int) -> Int {
  return input - 1
}
```

다음은, 반환 타입이 `(Int) -> Int` 인, `chooseStepFunction(backward:)` 라는 함수입니다. `chooseStepFunction(backward:)` 함수는 `backward` 라는 불리언 (Boolean) 매개 변수를 기초로 `stepForward(_:)` 함수나 `stepBackward(_:)` 함수를 반환합니다:

```swift
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
  return backward ? stepBackward : stepForward
}
```

이제 `chooseStepFunction(backward:)` 를 사용하면 이 쪽 또는 저 쪽 방향으로 걸음을 옮기는 함수를 구할 수 있습니다:

```swift
var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero 는 이제 stepBackward() 함수를 참조함
```

위 예제는 `currentValue` 라는 변수가 점점 더 0에 가까워지려면 양으로 걸어야 하는지 음으로 걸어야 하는 지 결정합니다. `currentValue` 의 초기 값은 `3` 인데, 이는 `currentValue > 0` 가 `true` 를 반환하여, `chooseStepFunction(backward:)` 가 `stepBackward(_:)` 함수를 반환하도록 한다는 의미합니다. 반환한 함수의 참조는 `moveNearerToZero` 라는 상수에 저장합니다.

이제 `moveNearerToZero` 가 올바른 함수를 참조하므로, 영까지 세는 데 사용할 수 있습니다:

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

이 장에서 지금까지 마주친 모든 함수는, 전역 범위에서 정의한, _전역 함수 (global functions)_ 예제였습니다. 다른 함수 본문 안에서 함수를 정의할 수도 있는데, 이를 _중첩 함수 (nested functions)_ 라고 합니다.

중첩 함수는 기본적으로 외부 세계로부터 숨겨져 있지만, 자신을 둘러싼 함수에선 여전히 호출하고 사용할 수 있습니다. 중첩 함수를 둘러싼 함수는 또 다른 영역에서 사용할 수 있도록 자신의 중첩 함수 하나를 반환할 수도 있습니다.

중첩 함수를 사용하고 반환하도록 위의 `chooseStepFunction(backward:)` 예제를 재작성할 수 있습니다:

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

[^optional-tuple-type]: 전자인 `(Int, Int)?` 는 튜플 멤버는 옵셔널이 아니지만 전체 튜플이 옵셔널인 경우이고, 후자인 `(Int?, Int?)` 는 튜플 멤버 각각이 옵셔널인 경우입니다.

[^type-safe]: 여기서 '타입-안전한 방식 (type-safe way)' 이라는 것은 스위프트가 기본적으로 제공하는 '타입 추론 (type inference)' 과 '타입 검사 (type check)' 기능을 사용할 수 있다는 것을 의미합니다. 이 내용은 [The Basic (기초)]({% post_url 2016-04-24-The-Basics %}) 부분의 [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)]({% post_url 2016-04-24-The-Basics %}#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 에서 설명한 바 있습니다.
