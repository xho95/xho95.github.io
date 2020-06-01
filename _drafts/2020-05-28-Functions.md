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

#### Functions with Multiple Parameters (매개 변수가 여러 개 있는 함수)

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

#### Functions with Multiple Return Values (반환 값이 여러 개 있는 함수)

**Optional Tuple Return Types (옵셔널 튜플 반환 타입)**

#### Functions With an Implicit Return (암시적으로 반환하는 함수)

### Function Argument Labels and Parameter Names (함수의 인자 이름표와 매개 변수 이름)

#### Specifying Argument Labels (인자 이름표 지정하기)

#### Omitting Argument Labels (인자 이름표 생략하기)

#### Default Parameter Values (기본 설정 매개 변수 값)

#### Variadic Parameters (가변 매개 변수)

#### In-Out Parameters (입-출력 매개 변수)

### Function Types (함수 타입)

#### Using Function Types (함수 타입 사용하기)

#### Function Type as Parameter Types (함수 타입을 매개 변수 타입으로 사용하기)

#### Function Type as Return Types (함수 타입을 반환 타입으로 사용하기)

### Nested Functions (품어진 함수)

### 참고 자료

[^Functions]: 이 글에 대한 원문은 [Functions](https://docs.swift.org/swift-book/LanguageGuide/Functions.html) 에서 확인할 수 있습니다.
