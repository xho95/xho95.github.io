---
layout: post
comments: true
title:  "Swift 5.2: Functions (함수)"
date:   2020-05-28 10:00:00 +0900
categories: Swift Language Grammar Function
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Functions](https://docs.swift.org/swift-book/LanguageGuide/Properties.html) 부분[^Functions]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Functions (함수)

_함수 (functions)_ 는 지정된 작업을 수행하는 '독립적인 (self-contained)' 코드 조각입니다. 함수는 그것이 뭔지를 식별하도록 이름을 가지며, 작업을 수행할 필요가 있을 때 이 이름을 사용하여 함수를 "호출 (call)" 합니다.

스위프트의 '통합된 함수 구문 표현 (unified function syntax)' 은 충분히 유연하기 때문에, 매개 변수 이름이 없는 간단한 C-스타일 함수에서 부터 각각의 매개 변수 마다 이름과 인자 이름표가 있는 복잡한 오브젝티브-C-스타일의 메소드까지 뭐든지 표현할 수 있습니다. 매개 변수는 함수 호출을 단순화하기 위해 기본 값을 제공 할 수도 있고, 입-출력 매개 변수의 형태로 전달해서, 함수 실행을 완료했을 때 전달된 변수를 수정하도록 할 수도 있습니다.

스위프트의 모든 함수는, 함수의 매개 변수 타입과 반환 타입으로 이루어진, 타입을 가지게 됩니다. 이 타입은 스위프트에 있는 다른 모든 타입처럼 사용할 수 있어서, 함수를 다른 함수의 매개 변수로 전달하거나, 함수에서 함수를 반환하는 것을 쉽게 만들어 줍니다. 함수를 다른 함수 내에서 작성하여 유용한 기능을 '품어진 함수 (nested function)' 영역 범위로 캡슐화할 수도 있습니다.

### Defining and Calling Functions (함수 정의하고 호출하기)

함수를 정의할 때, 그 함수의 입력으로 이름과 타입이 있는 값을 하나 이상 선택하여 정의할 수 있는데, 이를 _매개 변수 (parameters)_ 라고 합니다. 함수를 완료하고 나면 결과로 되돌려질 값의 타입을 선택하여 정의할 수도 있는데, 이는 _값 타입 (return type)_ 이라고 합니다.

모든 함수는 _함수 이름 (function name)_ 을 가지고 있어서, 그 함수가 수행하는 작업을 설명합니다. 함수를 사용하려면, 그 함수를 이름으로 "호출 (call)" 하고 함수의 매개 변수 타입에 해당하는 (_인자 (arguments)_ 라는) 입력 값을 전달하면 됩니다. 함수의 인자는 함수의 매개 변수 목록에 있는 것과 항상 같은 순서로 전달해야 합니다.

아래 예제의 함수는 `greet(person:)` 이라고 하는데, 하는게 그거라서 그렇습니다-사람의 이름을 입력받아서 그 사람에게 인사말을 반환하는 것 말입니다. 이를 위해, 입력 매개 변수-`person` 이라는 `String` 값-하나와, 그 사람에 대한 인사말을 담고 있는 `String` 타입의 반환 값 하나를 정의합니다.

```swift
func greet(person: String) -> String {
  let greeting = "Hello, " + person + "!"
  return greeting
}
```

이 모든 정보가 모여서 함수의 _정의 (definition)_ 가 되며, 이 앞에 `func` 키워드가 붙습니다. 함수의 반환 타입은 _반환 화살표 (return arrow)_ `->` (대쉬 기호 뒤에 꺽쇠 괄호가 붙은 것) 으로 지시하며, 반환할 타입의 이름을 그 뒤에 적어줍니다.

정의는 이 함수가 뭘 하는 지, 뭘 입력받고자 하는 지, 그리고 끝났을 때 뭘 반환하는 지를 설명합니다. 정의는 코드 여러 곳에서 함수를 호출할 때 모호하지 않도록 해줍니다.

```swift
print(greet(person: "Anna"))
// "Hello, Anna!" 를 출력합니다.
print(greet(person: "Brian"))
// "Hello, Brian!" 를 출력합니다.
```

`greet(person:)` 함수는 `person` '인자 이름표 (argument label)' 뒤에 `String` 값을 전달하여, 가령 `greet(person: "Anna")` 와 같이, 호출합니다. `greet(person:)` 함수는, `String` 값을 반환하므로, 위에서 본 것처럼, 문자열을 출력하는 `print(_:separator:terminator:)` 함수 호출로 이를 감싸서 그 반환 값을 보도록 할 수도 있습니다.

> `print(_:separator:terminator:)` 함수의 첫 번째 인자는 이름표를 가지고 있지 않으며, 다른 인자들은 기본 설정 값을 가지고 있어서 선택할 수 있습니다. 함수 구문 표현에 대한 이러한 변형들은 아래의 [Function Argument Labels and Parameter Names (함수의 인자 이름표와 매개 변수 이름)](#function-argument-labels-and-parameter-names-함수의-인자-이름표와-매개-변수-이름) 과 [Default Parameter Values (기본 설정 매개 변수 값)](#default-parameter-values-기본-설정-매개-변수-값) 에서 설명합니다.

`greet(person:)` 함수의 본문은 `greeting` 이라는 새 `String` 상수를 정의하고 여기에 간단한 인사말 메시지를 설정하는 것으로 시작합니다. 그다음 이 인사말은 `return` 키워드로 함수 밖으로 다시 되돌려집니다. `return greeting` 이라는 코드 줄에서, 함수는 실행을 마치고 `greeting` 의 현재 값을 반환합니다.

`greet(person:)` 함수는 서로 다른 입력 값을 사용하여 여러 번 호출할 수 있습니다. 위의 예제는 `"Anna"` 라는 입력 값과, `"Brian"` 이라는 입력 값을 써서 호출했을 때 어떻게 되는 지를 보여줍니다. 함수는 각각의 경우에 맞게 맞춰진 인사말을 반환합니다.

이 함수의 본문을 더 짧게 만들기 위해, 메시지 생성 구문과 반환 구문을 한 줄로 병합할 수도 있습니다:

```swift
func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))
// "Hello again, Anna!" 를 출력합니다.
```

### Function Parameters and Return Values (함수의 매개 변수와 반환 값)

스위프트에서 함수의 매개 변수와 반환 값은 엄청 유연합니다. 이름없는 단일 매개 변수를 가진 간단한 '실용 (utility)' 함수에서 부터 현란한 이름의 매개 변수와 다양한 매개 변수 옵션을 가진 복잡한 함수까지 무엇이든 정의할 수 있습니다.

#### Functions Without Parameters (매개 변수가 없는 함수)

입력 매개 변수를 정의하지 않는 함수를 말합니다. 다음은 입력 매개 변수가 없는 함수로, 호출될 때마다 항상 같은 `String` 메시지를 반환합니다:

```swift
func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())
// "hello, world" 를 출력합니다.
```

함수 정의는, 어떤 매개 변수를 가지지 않더라도, 함수 이름 뒤에 괄호를 붙여야 합니다. 함수를 호출할 때는 함수 이름 뒤에 빈 괄호 쌍을 붙여줍니다.

#### Functions with Multiple Parameters (매개 변수가 여러 개인 함수)

함수는 여러 개의 입력 매개 변수를 가질 수 있는데, 이를 작성할 때는 함수 괄호 안에, 쉼표로 구분해 줍니다.

다음 함수는 사람 이름과 이미 인사를 했는 지를 입력 받아서, 그 사람에 대한 인사말을 적절하게 반환합니다:

```swift
func greet(person: String, alreadyGreeted: Bool) -> String {
  if alreadyGreeted {
    return greetAgain(person: person)
  } else {
    return greet(person: person)
  }
}
print(greet(person: "Tim", alreadyGreeted: true))
// "Hello again, Tim!" 를 출력합니다.
```

`greet(person:alreadyGreeted:)` 함수를 호출할 때는 괄호 안에 `person` 이름표를 단 `String` 인자 값과 `alreadyGreeted` 이름표를 단 `Bool` 인자 값을, 쉼표로 구분하여, 같이 전달하면 됩니다. 이 함수는 이전 장에서 본 `greet(person:)` 함수와 명확하게 구별된다는 점을 주목하기 바랍니다. 두 함수 모두 이름이 `greet` 으로 시작하지만, `greet(person:alreadyGreeted:)` 함수는 두 개의 인자를 받는데 반하여 `greet(person:)` 함수는 하나만 받습니다.

#### Functions Without Return Values (반환 값이 없는 함수)

반환 값을 정의하는 것이 함수에서 필수적인 것은 아닙니다. 다음은 `greet(person:)` 함수의 한 가지로, 자신의 `String` 값을 반환하지 않고 출력하는, 버전입니다:

```swift
func greet(person: String) {
  print("Hello, \(person)!")
}
greet(person: "Dave")
// "Hello, Dave!" 를 출력합니다.
```

값을 반환할 필요가 없기 때문에, 함수 정의는 '반환 화살표 (`->`)' 나 반환 타입을 포함하고 있지 않습니다.

> 엄밀히 말하면, 이 버전의 `greet(person:)` 함수 _역시 (does)_, 반환 값을 아무 것도 정의하지 않았음에도 불구하고, 여전히 값을 반환합니다. 반환 타입을 정의하지 않은 함수는 `Void` 타입인 특수한 값을 반환합니다. 이것은 단순히 빈 튜플 (tuple) 이며, `()` 라고 작성합니다.

함수를 호출할 때 반환 값을 무시할 수 있습니다:

```swift
func printAndCount(string: String) -> Int {
  print(string)
  return string.count
}
func printWithoutCounting(string: String) {
  let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
// "hello, world" 를 출력하며 12 를 반환합니다.
printWithoutCounting(string: "hello, world")
// "hello, world" 를 출력하지만 반환 값은 없습니다.
```

첫 번째 함수인, `printAndCount(string:)` 는, 문자열을 출력한 다음, 문자의 개수를 `Int` 로 반환합니다. 두 번째 함수인, `printWithoutCounting(string:)` 은, 첫 번째 함수를 호출하지만, 반환 값은 무시합니다. 두 번째 함수를 호출하면, 메시지는 여전히 첫 번째 함수에 의해 출력되지만, 반환 값은 사용되지 않습니다.

> 반환 값을 무시할 수는 있지만, 값을 반환한다고 말한 함수는 반드시 항상 그걸 해야합니다. 반환 타입을 정의한 함수는 값을 반환하지 않은 채로 제어가 함수를 빠져나가게 할 수 없으며, 이렇게 하려고 하면 그 결과는 '컴파일-시간 에러 (compile-time error)' 입니다.

#### Functions with Multiple Return Values (반환 값이 여러 개인 함수)

'튜플 (tuple)' 타입을 함수의 반환 타입으로 사용하면 여러 개의 반환 값을 하나의 복합된 반환 값으로 만들어서 반환할 수 있습니다.

아래 예제는, `Int` 값 배열에서 최소 값과 최대 값을 찾는, `minMax(array:)` 라는 함수를 정의합니다:

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

`minMax(array:)` 함수는 두 개의 `Int` 값을 담고 있는 '튜플 (tuple)' 을 반환합니다. 이 값에는 `min` 과 `max` 라는 이름표가 있어서 함수의 반환 값을 조회할 때 이름으로 접근할 수 있습니다.

`minMax(array:)` 함수의 본문은 두 개의 작업 변수인 `currentMin` 과 `currentMax` 를 배열의 첫 번째 정수 값으로 설정하는 것으로 시작합니다. 그런 다음 이 함수는 배열의 나머지 값에 동작을 반복 적용해서 각각의 값이 `currentMin` 과 `currentMax` 값보다 작은 지 큰 지를 하나씩 검사합니다. 마지막으로, 전체의 최소 값과 최대 값이 두 `Int` 값을 가진 튜플 (tuple) 의 형태로 반환됩니다.

함수 반환 타입 부분에서 튜플 멤버 값에 이름을 지어줬기 때문에, 최소 값과 최대 값을 '점 구문 표현 (dot syntax)' 으로 접근하여 가져올 수 있습니다:

```swift
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
// "min is -6 and max is 109" 를 출력합니다.
```

튜플 멤버의 이름은 함수에서 튜플을 반환할 때 지을 필요는 없는데, 이는 함수 반환 타입 부분에서 이미 이름을 지어줬기 때문입니다.

**Optional Tuple Return Types (옵셔널 튜플 반환 타입)**

함수가 반환하는 튜플 타입에서 전체 튜플이 "값이 없음 (no value)" 일 가능성이 있는 경우, _옵셔널 (optional)_ 튜플 반환 타입을 사용하여 이 전체 튜플이 `nil` 이 될 수 있다는 사실을 반영할 수 있습니다. '옵셔널 튜플 반환 타입 (optional tuple return type)' 을 작성하려면 튜플 타입의 '닫음 괄호' 뒤에 물음표를 붙이면 되는데, 가령 `(Int, Int)?` 나 `(String, Int, Bool)?` 같은 것입니다.

> `(Int, Int)?` 와 같은 '옵셔널 튜플 타입' 은 `(Int?, Int?)` 와 같은 '옵셔널 타입을 담고 있는 튜플' 과는 다른 것입니다.[^optional-tuple-type] 옵셔널 튜플 타입은, 전체 튜플이 옵셔널인 것이며, 튜플에 있는 각각의 개별 값만 옵셔널인 것이 아닙니다.

위의 `minMax(array:)` 함수는 두 `Int` 값을 담고 있는 튜플을 반환합니다. 하지만, 이 함수는 전달받은 배열의 안전성 검사를 전혀 하지 않고 있습니다. 만약 `array` 인자가 빈 배열을 담고 있다면, 위에서 정의한, `minMax(array:)` 함수는, `array[0]` 에 접근하려고 할 때 '실행 시간 에러 (runtime error)' 를 띄울 것입니다.

빈 배열을 안전하게 처리하려면, `minMax(array:)` 함수를 작성하면서 옵셔널 튜플 반환 타입을 사용하여 배열이 비었을 때 `nil` 값을 반환하면 됩니다:

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

'옵셔널 바인딩 (optional binding)' 을 사용하면 `minMax(array:)` 함수가 실제로 튜플 값을 반환하는 지 `nil` 을 반환하는지 검사할 수 있습니다:

```swift
if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
  print("min is \(bounds.min) and max is \(bounds.max)")
}
// "min is -6 and max is 109" 를 출력합니다.
```

#### Functions With an Implicit Return (암시적으로 반환하는 함수)

함수의 전체 본문이 단일한 표현식으로 되어 있는 경우, 함수는 이 표현식을 암시적으로 반환합니다. 예를 들어, 아래 두 함수 모두 같은 동작을 합니다:

```swift
func greeting(for person: String) -> String {
  "Hello, " + person + "!"
}
print(greeting(for: "Dave"))
// "Hello, Dave!" 를 출력합니다.

func anotherGreeting(for person: String) -> String {
  return "Hello, " + person + "!"
}
print(anotherGreeting(for: "Dave"))
// "Hello, Dave!" 를 출력합니다.
```

`greeting(for:)` 함수는 전체 정의가 인사말 메시지를 반환하는 것이며, 이는 곧 이렇게 '단축 양식 (shorter form)' 을 사용할 수 있다는 것을 의미합니다. `anotherGreeting(for:)` 함수는 똑같은 인사말 메시지를, `return` 키워드를 사용하여 더 긴 함수 형태로 반환합니다. 하나의 `return` 줄로만 작성된 함수는 어떤 것이든 이 `return` 을 생략할 수 있습니다.

[Shorthand Getter Declaration (획득자 선언의 약칭 표현)](#shorthand-getter-declaration-획득자-선언의-약칭-표현) 에서 보게 될 것 처럼, '속성 획득자 (property getter)' 도 암시적인 반환 기능을 사용할 수 있습니다.

### Function Argument Labels and Parameter Names (함수의 인자 이름표와 매개 변수 이름)

함수의 각 매개 변수는 _인자 이름표 (argument label)_ 와 _매개 변수 이름 (paramenter name)_ 을 둘 다 가집니다. 인자 이름표는 함수를 호출할 때 사용합니다; 함수 호출에서 각 인자는 그 앞에 인자 이름표를 붙여서 작성합니다. 매개 변수 이름은 함수 구현 내에서 사용합니다. 기본적으로, 매개 변수는 매개 변수 이름을 인자 이름표로 사용합니다.

```swift
func someFunction (firstParameterName: Int, secondParameterName: Int) {
  // 함수 본문에서, firstParameterName 과 secondParameterName 은
  // 첫 번째 및 두 번째 매개 변수에 대한 인자 값을 참조합니다.
}
someFunction(firstParameterName: 1, secondParameterName: 2)
```

모든 매개 변수는 반드시 유일한 이름을 가져야 합니다. 인자 이름표는 여러 매개 변수에서 동일하게 할 수는 있지만, 유일한 인자 이름표를 사용하면 코드를 이해하기 더 편할 것입니다.

#### Specifying Argument Labels (인자 이름표 지정하기)

인자 이름표는 매개 변수 이름 앞에, 공백으로 구분하여, 작성합니다:

```swift
func someFunction(argumentLabel parameterName: Int) {
  // 함수 본문에서, parameterName 은
  // 해당 매개 변수에 대한 인자 값을 참조합니다.
}
```

다음은 `greet(person:)` 함수를 변형하여 사람 이름과 출신지를 받아서 인사말을 반환하도록 한 것입니다:

```swift
func greet(person: String, from hometown: String) -> String {
  return "Hello \(person)! Glad you could visit from \(hometown)."
}
print (greet(person: "Bill", from: "Cupertino"))
// "Hello Bill! Glad you could visit from Cupertino." 를 출력합니다.
```

인자 이름표를 사용하면 의미가 잘 드러나며, 일반 문장-같이 함수를 호출할 수 있으면서도, 함수 본문은 여전히 이해하기 쉽고 목적을 명확하게 나타낼 수 있습니다.

#### Omitting Argument Labels (인자 이름표 생략하기)

매개 변수에 인자 이름표를 붙이고 싶지 않으면, 해당 매개 변수에 명시적인 인자 이름표 대신 _밑줄 (underscore)_ (`_`) 을 작성하면 됩니다.

```swift
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
  // 함수 본문에서, firstParameterName 과 secondParameterName 은
  // 첫 번째 및 두 번째 매개 변수의 인자 값을 참조합니다.
}
someFunction (1, secondParameterName: 2)
```

매개 변수가 인자 이름표를 가지고 있으면, 그 인자는 함수를 호출 할 때 _반드시 (must)_ 이름표를 붙여야 합니다.

#### Default Parameter Values (기본 설정 매개 변수 값)

함수의 매개 변수는 어떤 것이든 그 매개 변수 타입 뒤에 값을 할당하여 _기본 설정 값 (default value)_ 을 정의할 수 있습니다. '기본 설정 값' 을 정의하면, 함수를 호출할 때 해당 매개 변수를 생략할 수 있습니다.

```swift
func someFunction (parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
  // 이 함수를 호출할 때 두 번째 인자를 생략하면,
  // parameterWithDefault 의 값은 함수 본문 내에서 12 가 됩니다.
}
someFunction (parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault 는 6 입니다.
someFunction (parameterWithoutDefault: 4) // parameterWithDefault 는 12 입니다.
```

기본 설정 값이 없는 매개 변수를, 기본 설정 값이 있는 매개 변수 보다 앞에, 함수 매개 변수 목록의 시작 부분에 위치하도록 합니다. 기본 설정 값이 없는 매개 변수가 함수에서 보통 더 중요한 의미를 가지기 때문에-이를 먼저 작성하는 것은, 어떤 기본 설정 값이 생략되었든 상관없이, 동일 함수를 호출했음을 더 쉽게 인식하게 만들어 줍니다.

#### Variadic Parameters (가변 매개 변수)

_가변 매개 변수 (variadic parameter)_ 는 지정된 타입에 대한 값을 0 개 또는 그 이상 받아 들입니다. '가변 매개 변수' 를 사용하면 함수를 호출할 때 가변적인 개수의 입력 값을 전달할 수 있습니다. 가변 매개 변수를 작성하려면 매개 변수의 타입 이름 뒤에 세 개의 마침표 (`...`) 를 넣으면 됩니다.

가변 매개 변수로 전달되는 값은 함수 본문에서 적당한 타입의 배열로 사용할 수 있게 만들어 집니다. 예를 들어, `numbers` 라는 이름과 `Double...` 이라는 타입을 가진 가변 매개 변수는 함수 본문에서 이름이 `numbers` 이고 타입이 `[Double]` 인 상수 배열로 사용할 수 있습니다.

아래 예제는 어떤 개수의 수치 값에 대해서도 _산술 평균 (arithmetic mean)_ (또는 그냥 _평균 (average)_) 을 계산할 수 있습니다:

```swift
func arithmeticMean(_ numbers: Double...) -> Double {
  var total: Double = 0
  for number in numbers {
    total += number
  }
  return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// 다섯 개의 수치 값에 대한 산술 평균인, 3.0 을 반환합니다.
arithmeticMean(3, 8.25, 18.75)
// 세 개의 수치 값에 대한 산출 평균인, 10.0 을 반환합니다.
```

> 함수는 한 개의 가변 매개 변수만 가질 수 있습니다.

#### In-Out Parameters (입-출력 매개 변수)

함수의 매개 변수는 기본적으로 상수입니다. 함수의 매개 변수 값을 그 함수 본문에서 바꾸려고 하면 '컴파일 시간 에러 (compile-time error)' 가 발생합니다. 이것의 의미는 매개 변수의 값이 실수로 바뀔 일은 없다는 것입니다. 함수에서 매개 변수의 값을 수정하고, 그렇게 바뀐 것을 함수 호출이 끝난 후에도 유지하고자 한다면, 이 때는 그 매개 변수를 _입-출력 매개 변수 (in-out parameter)_ 라고 정의하면 됩니다.

입-출력 매개 변수를 작성하려면 매개 변수의 타입 바로 앞에 `inout` 키워드를 위치시킵니다. '입-출력 매개 변수' 는 함수에 _입력 (in)_ 된 다음, 함수에서 수정되고 나서, 원래 값을 대체하기 위해 함수 밖으로 _출력 (out)_ 되는 값을 가지고 있습니다. 입-출력 매개 변수의 동작 방식과 이에 관련된 컴파일러 최적화에 대한 더 자세한 논의는 [In-Out Parameters (입-출력 매개 변수)](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID545) 를 참고하기 바랍니다.

입-출력 매개 변수의 인자로는 변수만 전달할 수 있습니다. 상수나 '글자 표현 값 (literal value)' 은 인자로 전달할 수 없는데, 상수와 '글자 표현 (literals)' 은 수정할 수 없기 때문입니다. 입-출력 매개 변수에 인자를 전달할 때는, 함수에서 수정할 수 있는 것을 지시하기 위해, 변수 이름 바로 앞에 '앤드 기호 (`&`; 앰퍼센드)' 를 붙이도록 합니다.

> '입-출력 매개 변수' 는 '기본 설정 값 (default values)' 을 가질 수 없으며, 가변 매개 변수는 `inout` 이라고 표시할 수 없습니다.  

다음은, `a` 와 `b` 라는 두 개의 입-출력 매개 변수를 가지고 있는, `swapTwoInts(_:_:)` 라는 함수에 대한 예제입니다:

```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
  let temporaryA = a
  a = b
  b = temporaryA
}
```

`swapTwoInts(_:_:)` 함수는 단순히 `b` 값을 `a` 로, `a` 값을 `b` 로 서로 교환합니다. 이 함수는 교환 작업을 위해 `a` 값을 `temporaryA` 라는 임시 상수에 저장한 다음, `b` 값을 `a` 에 할당하고, 다시 `temporaryA` 를 `b` 에 할당합니다.

`swapTwoInts(_:_:)` 함수를 호출하면 `Int` 타입의 두 변수 값을 서로 교환할 수 있습니다. `swapTwoInts(_:_:)` 함수로 전달할 때 `someInt` 와 `anotherInt` 의 이름에는 접두사 '앤드 기호 (앰퍼센드)' 를 붙인다는 것을 기억하기 바랍니다:

```swift
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// "someInt is now 107, and anotherInt is now 3" 를 출력합니다.
```

위의 예제는 `someInt` 와 `anotherInt` 의 원래 값이, 함수 외부에서 정의되었음에도 불구하고, `swapTwoInts(_:_:)` 함수에서 수정된 것을 보여줍니다.

> 입-출력 매개 변수는 함수에서 값을 반환하는 것과 같은 것이 아닙니다. 위의 `swapTwoInts` 예제는 반환 타입을 정의하지도 않았고 값을 반환하지도 않지만, 여전히 `someInt` 와 `anotherInt` 의 값을 수정합니다. 입-출력 매개 변수는 함수가 함수 본문 영역의 범위 외부로 효과를 줄 수 있는 또 다른 방법입니다.

### Function Types (함수 타입)

#### Using Function Types (함수 타입 사용하기)

#### Function Type as Parameter Types (함수 타입을 매개 변수 타입으로 사용하기)

#### Function Type as Return Types (함수 타입을 반환 타입으로 사용하기)

### Nested Functions (품어진 함수)

### 참고 자료

[^Functions]: 이 글에 대한 원문은 [Functions](https://docs.swift.org/swift-book/LanguageGuide/Functions.html) 에서 확인할 수 있습니다.

[^optional-tuple-type]: 전자인 `(Int, Int)?` 는 타입 자체가 '옵셔널 (optional)' 이고, 후자인 `(Int?, Int?)` 는 타입은 '튜플 (tuple)' 인데 '옵셔널 타입' 을 담고 있는 것입니다. 즉 후자는 타입 자체가 '옵셔널' 인 것은 아닙니다.
