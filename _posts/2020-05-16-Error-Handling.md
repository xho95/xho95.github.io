---
layout: post
comments: true
title:  "Error Handling (에러 처리)"
date:   2020-05-16 10:00:00 +0900
categories: Swift Language Grammar Error Handling
---

{% include header_swift_book.md %}

## Error Handling (에러 처리)

_에러 처리 (error handling)_ 는 프로그램의 에러 조건에 응답하고 이로부터 복구하는 과정을 말합니다. 스위프트는 일-급 지원[^first-class-support] 기능을 제공하여 실행 시간에 복구 가능한 에러를 던지고, 잡아내며, 전파하고, 조작합니다.

일부 연산은 실행을 완료하거나 쓸만한 출력을 만들어 내는 걸 항상 보장하지 않습니다. 옵셔널을 써서 값이 없는 건 나타내지만, 연산이 실패할 땐, 무엇이 실패를 일으켰는지 이해하고, 그에 따라 코드가 응답할 수 있도록 하는게, 유용할 때가 자주 있습니다.

예를 들어, (하드) 디스크의 파일에서 데이터를 읽고 가공하는 임무를 고려합니다. 다수의 이유로 이 임무가 실패할 수 있는데, 이는 지정된 경로에 파일이 존재하지 않거나, 파일을 읽을 권한이 없거나, 파일이 호환 가능한 양식으로 인코딩되지 않은 것 등을 포함합니다. 이렇게 서로 다른 상황들을 구별하면 일부 에러는 프로그램이 해결하게 그리고 어떤 에러가 해결할 수 없다면 사용자와 소통하게 할 수 있습니다.

> 스위프트의 에러 처리는 `NSError` 클래스를 쓰는 **Cocoa** 와 **오브젝티브-C** 의 에러 처리 패턴과 서로 호환됩니다. 이 클래스에 대한 더 많은 정보는, [Handling Cocoa Errors in Swift (스위프트에서 Cocoa 에러 처리하기)](https://developer.apple.com/documentation/swift/cocoa_design_patterns/handling_cocoa_errors_in_swift) 를 보기 바랍니다.

### Representing and Throwing Errors (에러 나타내고 던지기)

스위프트에서, 에러는 `Error` 프로토콜을 따르는 타입의 값으로 나타냅니다. 이 빈 프로토콜[^empty-protocol] 은 에러 처리에 쓸 수 있는 타입임을 지시합니다.

스위프트 열거체는 특히 서로 관련된 에러 조건 그룹을 모델링하기에 적당한데, 결합 값은 통신할 에러 고유의 성질에 대한 추가 정보도 허용합니다. 예를 들어, 게임 안에서 자동 판매기 동작의 에러 조건을 나타낸다면 이럴지도 모릅니다:

```swift
enum VendingMachineError: Error {
  case invalidSelection
  case insufficientFunds(coinsNeeded: Int)
  case outOfStock
}
```

에러를 던지는 건 예상치 못한 일이 발생하여 보통의 실행 흐름이 계속될 수 없다는 걸 지시합니다. 에러는 `throw` 문으로 던집니다. 예를 들어, 다음 코드가 던지는 에러는 자동 판매기에 추가로 동전 5개가 필요하다는 걸 지시합니다:

```swift
throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
```

### Handling Errors (에러 처리하기)

에러가 던져질 땐 주위를 둘러싼 코드 조각이 반드시 에러 처리를 책임져야 하는데-예를 들어, 문제를 바로 잡거나, 대안을 시도하거나, 또는 사용자에게 실패를 알리거나 합니다.

스위프트의 에러 처리엔 네 가지 방법이 있습니다. 함수에서 그 함수를 호출한 코드로 에러를 퍼뜨리거나 (propagate), `do-catch` 문으로 에러를 처리하거나, 옵셔널 값으로 에러를 처리하거나, 또는 에러가 나지 않을 거라고 단언 (assert) 할 수 있습니다. 각각의 접근법은 아래 절에서 설명합니다.

함수가 에러를 던질 땐, 프로그램의 흐름이 바뀌게 되므로, 코드에서 에러를 던질 수 있는 곳을 빠르게 아는게 중요합니다. 코드에서 이런 곳을 알려면, `try` 키워드나-`try?` 또는 `try!` 같이 변화된 걸-에러를 던질 수 있는 함수나, 메소드, 또는 초기자의 호출 코드 앞에 쓰면 됩니다. 이 키워드들은 아래 절에서 설명합니다.

> 스위프트의 에러 처리는, `try` 와, `catch`, 및 `throw` 키워드를 쓴다는 점에서, 다른 언어의 예외[^exception] 처리와 닮았습니다. **오브젝티브-C** 를 포함한-수많은 언어의 예외 처리와 달리, 스위프트의 에러 처리는, 계산 비용이 비쌀 수도 있는 과정인, 호출 스택 풀기[^unwinding-call-stack] 와 엮여 있지 않습니다. 그로 인해, `throw` 문의 수행 성능은 `return` 문과 비교할 만합니다.

#### Propagating Errors Using Throwing Functions (던지는 함수로 에러 전파하기)

함수, 메소드, 또는 초기자가 에러를 던질 수 있다고 지시하려면, 함수 선언의 매개 변수 뒤에 `throws` 키워드를 작성합니다. `throws` 로 표시한 함수를 _던지는 함수 (throwing function)_ 라고 합니다. 반환 타입을 지정한 함수면, 반환 화살표 (`->`) 앞에 `throws` 키워드를 씁니다.

```swift
func canThrowErrors() throws -> String

func cannotThrowErrors() -> String
```

던지는 함수는 자기 안에서 던진 에러를 자신을 호출한 영역으로 전파합니다.

> 던지는 함수만 에러를 전파할 수 있습니다. 던지지 않는 (nonthrowing) 함수 안에서 던진 어떤 에러든 함수 안에서 반드시 처리해야 합니다.

아래 예제의, `VendingMachine` 클래스엔 `vend(itemNamed:)` 메소드가 있는데, 요청한 항목을 쓸 수 없거나, 재고가 없거나, 또는 비용이 현재 보관량을 초과할 경우, 적절한 `VendingMachineError` 를 던집니다:

```swift
struct Item {
  var price: Int
  var count: Int
}

class VendingMachine {
  var inventory = {
    "Candy Bar": Item(price: 12, count: 7)
    "Chips": Item(price: 10, count: 4)
    "Pretzels": Item(price: 7, count: 11)
  }
  var coinsDeposited = 0

  func vend(itemNamed name: String) throws {
    guard let item = inventory[name] else {
      throw VendingMachineError.invalidSelection
    }

    guard item.count > 0 else {
      throw VendingMachineError.outOfStock
    }

    guard item.price <= coinsDeposited else {
      throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
    }

    coinsDeposited -= item.price

    var newItem = item
    newItem.count -= 1
    inventory[name] = newItem

    print("Dispensing \(name)")
  }
}
```

`vend(itemNamed:)` 메소드 구현은 `guard` 문을 사용하여 간식 구매를 위한 어떤 필수 조건이든 만족하지 않으면 메소드를 때 이르게 빠져나와서 적절한 에러를 던집니다. `throw` 문이 곧바로 프로그램 제어를 옮기기 때문에, 이 모든 필수 조건에 부합할 경우에만 항목을 팔 것입니다.

`vend(itemNamed:)` 메소드는 자신이 던진 어떤 에러든 전파하기 때문에, 이 메소드를 호출하는 어떤 코드든 반드시-`do-catch` 문이나, `try?`, 또는 `try!` 를 써서-에러를 처리하든지, 아니면 이를 계속 전파해야 합니다. 예를 들어, 아래 예제의 `buyFavoriteSnack(person:vendingMachine:)` 도 던지는 함수이며, `vend(itemNamed:)` 메소드가 던진 어떤 에러든 `buyFavoriteSnack(person:vendingMachine:)` 함수를 호출한 곳으로 위로 전파 (propagate up) 할 것입니다.

```swift
let favoriteSnaks = [
  "Alice": "Chips",
  "Bob": "Licorice",
  "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
  let snackName = favoriteSnacks[person] ?? "Candy Bar"
  try vendingMachine.vend(itemNamed: snackName)
}
```

이 예제에서, `buyFavoriteSnack(person:vendingMachine:)` 함수는 주어진 사람이 가장 좋아하는 간식을 찾아 보고 `vend(itemNamed:)` 메소드 호출로 이를 사려고 합니다. `vend(itemNamed:)` 메소드가 에러를 던질 수 있기 때문에, `try` 키워드를 앞에 붙여서 호출합니다.

던지는 초기자 (throwing initializers) 는 던지는 함수와 똑같은 식으로 에러를 전파할 수 있습니다. 예를 들어, 아래 나열한 `PurchasedSnack` 구조체의 초기자는 초기화 과정에서 던지는 함수를 호출하며, 마주친 어떤 에러든 자신을 호출한 쪽으로 전파함으로써 이를 처리합니다.

```swift
struct PurchasedSnack {
  let name: String
  init(name: String, vendingMachine: VendingMachine) throws {
    try vendingMachine.vend(itemNamed: name)
    self.name = name
  }
}
```

#### Handling Errors Using Do-Catch ('Do-Catch' 문으로 에러 처리하기)

`do`-`catch` 문을 사용하면 코드 블럭을 실행함으로써 에러를 처리합니다. `do` 절 코드에서 에러를 던지면, `catch` 절과 맞춰봐서 에러를 처리할 수 있는 걸 하나 결정합니다.

다음은 `do`-`catch` 문의 일반 형식입니다:

&nbsp;&nbsp;&nbsp;&nbsp;do {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;try `expression-표현식`<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;} catch `pattern 1-패턴 1` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;} catch `pattern 2-패턴 2` where `condition-조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;} catch `pattern 3-패턴 3`, `pattern 4-패턴 4` where `condition-조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;} catch {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

`catch` 뒤에 패턴 (pattern) 을 작성하여 그 절이 처리할 수 있는 에러를 지시합니다. `catch` 절에 패턴이 없으면, 그 절은 어떤 에러와도 일치하며 `error` 라는 이름의 지역 상수와 에러를 연결 (bind) 합니다. 패턴 맞춤 (pattern matching) 에 대한 더 많은 정보는, [Patterns (패턴; 유형)]({% link docs/swift-books/swift-programming-language/patterns.md %}) 장을 보도록 합니다.

예를 들어, 다음 코드는 `VendingMachineError` 열거체의 세 모든 case 들과 맞춰봅니다.

```swift
var vendingMachine = VendingMachine()
vendingMachine.conisDeposited = 8

do {
  try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
  print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
  print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
  print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
  print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
  print("Unexpected error: \(error).")
}
// "Insufficient funds. Please insert an additional 2 coins." 를 인쇄함
```

위 예제의, `buyFavoriteSnack(person:vendingMachine:)` 함수는 에러를 던질 수 있기 때문에, `try` 표현식[^try-expression] 안에서 호출합니다. 에러를 던지면, 곧바로`catch` 절로 실행을 옮기며, 여기서 전파를 계속 허용할 지 결정합니다. 일치하는 패턴이 없으면, 최종 `catch` 절이 에러를 잡아내어 `error` 라는 지역 상수에 연결합니다. 던진 에러가 없으면, `do` 문의 나머지 구문을 실행합니다.

`do` 절 코드가 던질 가능성이 있는 모든 에러를 `catch` 절이 처리하지 않아도 됩니다. 아무 `catch` 절도 에러를 처리하지 않으면, 에러를 주위 영역으로 전파합니다. 하지만, 전파한 에러는 _어떠한 (some)_ 주위 영역이 됐든 반드시 처리해야 합니다. 던지지 않는 함수에선, 둘러싼 `do`-`catch` 문이 반드시 에러를 처리해야 합니다. 던지는 함수에선, 둘러싼 `do-catch` 문이든 호출한 쪽이든 반드시 에러를 처리해야 합니다. 처리되지 않은 에러를 최상단 영역으로 전파하면, 실행시간 에러를 가지게 됩니다.

예를 들어, 위 예제를 `VendingMachineError` 가 아닌 어떤 에러든 호출하는 함수가 대신 잡아내도록 작성할 수 있습니다:

```swift
func nourish(with item: String) throws {
  do {
    try vendingMachine.vend(itemNamed: item)
  } catch is VendingMachineError {
    print("Invalid selection, out of stock, or not enough money.")
  }
}

do {
  try nourish(with: "Beet-Flavored Chips")
} catch {
  print("Unexpected non-vending-machine-related error: \(error)")
}
// "Invalid selection, out of stock, or not enough money." 를 인쇄함
```

`nourish(with:)` 함수에서, `vend(itemNamed:)` 가 `VendingMachineError` 열거체 case 중 하나를 던지면, 메시지를 인쇄함으로써 `nourish(with:)` 가 에러를 처리합니다. 그 외 경우, `nourish(with:)` 가 자신을 호출한 쪽으로 에러를 전파합니다. 그러면 일반적인 `catch` 절이 에러를 잡아냅니다.

서로 관련된 여러 에러를 잡아내는 또 다른 방법은 `catch` 뒤에, 쉼표로 구분하여, 나열하는 겁니다. 예를 들면 다음과 같습니다:

```swift
func eat(item: String) throws {
  do {
    try vendingMachine.vend(itemNamed: item)
  } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
    print("Invalid selection, out of stock, or not enough money.")
  }
}
```

`eat(item:)` 함수는 잡아낼 자판기 에러를 나열하는데, 에러 문장은 그 목록의 항목입니다. 나열한 세 에러 중 어떤 것이든 던지면, 이 `catch` 절이 메시지 인쇄로 이를 처리합니다. 다른 어떤 에러는, 나중에 추가할 지도 모를 자판기 에러도 포함하여, 주위 영역으로 전파합니다.

#### Converting Errors to Optional Values (에러를 옵셔널 값 변환하기)

`try?` 를 사용하면 옵셔널 값 변환으로 에러를 처리합니다. `try?` 표현식 평가 동안 에러를 던지면, 표현식 값이 `nil` 입니다. 예를 들어, 다음 코드에서 `x` 와 `y` 의 값과 동작은 똑같습니다:

```swift
func someThrowingFunction() throws -> Int {
  // ...
}

let x = try? someThrowingFunction()

let y: Int?
do {
  y = try someThrowingFunction()
} catch {
  y = nil
}
```

`someThrowingFunction()` 이 에러를 던지면, `x` 와 `y` 값이 `nil` 입니다. 그 외 경우, `x` 와 `y` 값은 함수의 반환 값입니다. `someThrowingFunction()` 이 무슨 타입을 반환하든 `x` 와 `y` 가 옵셔널임을 기억하기 바랍니다. 여기선 함수가 정수를 반환하므로, `x` 와 `y` 는 옵셔널 정수입니다.

`try?` 의 사용은 모든 에러를 똑같이 처리하고 싶을 때의 에러 처리 코드가 간결해지게 합니다.[^error-to-optional] 예를 들어, 다음 코드는 여러 접근법으로 자료를 가져오거나, 아니면 모든 접근법이 실패할 경우 `nil` 을 반환합니다.

```swift
func fetchData() -> Data? {
  if let data = try? fetchDataFromDisk() { return data }
  if let data = try? fetchDataFromServer() { return data }
  return nil
}
```

#### Disabling Error Propagation (에러 전파 못하게 하기)

던지는 함수나 메소드가 실행 시간에 에러를 던지지 않을 거라는, 사실을, 알 때가 있습니다. 그럴 때, 표현식 앞에 `try!` 를 작성하면 에러 전파를 못하게 하고 실행시간 단언문[^runtime-assertion] 으로 호출을 포장하여 아무 에러도 던지지 않을거라고 (단언) 할 수 있습니다. 에러를 실제로 던지면, 실행시간 에러를 가지게 됩니다.[^runtime-error]

예를 들어, 다음 코드는 `loadImage(atPath:)` 함수로, 주어진 경로의 이미지를 불러오거나 아니면 이미지를 불러올 수 없을 경우 에러를 던집니다. 이 경우, 응용 프로그램과 같이 이미지를 출하하기 때문에, 실행 시간에 에러를 던지진 않을 것이므로, 에러를 전파 못하게 하는 게 적절합니다.

```swift
let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
```

### Specifying Cleanup Actions (정리 행동 지정하기)

`defer` 문을 사용하면 현재 코드 블럭을 떠나기 직전에 일정 구문 집합을 실행할 수 있습니다. 이 구문은 현재 코드 블럭을 떠나는 _방법 (how)_ 엔 상관없이-에러를 던지기 때문에 떠나든 `return` 이나 `break` 같은 구문 때문에 떠나든-하는게 필요한 어떤 정리를 하게 해줍니다. 예를 들어, `defer` 문을 사용하면 파일 서술자 (file descriptors)[^file-discriptors] 를 닫고 수동으로 할당한 메모리를 풀어준다는 걸 보장할 수 있습니다.

`defer` 문은 현재 영역을 빠져나갈 때까지 실행을 미룹니다. 이 구문은 `defer` 키워드 및 나중에 실행할 구문으로 이루어집니다. 미룬 구문 (deferred statements) 은 구문 밖으로 제어를 옮기는, `break` 나 `return` 문, 또는 에러 던짐 같은, 어떤 코드를 담고 있지 않을 수 있습니다. 미룬 행동은 소스 코드에 작성한 반대 순서로 실행합니다. 즉, 첫 번째 `defer` 문 코드를 마지막에 실행하고, 두 번째 `defer` 문 코드를 마지막에서 두 번째로 실행하며, 기타 등등 그렇게 계속됩니다. 소스 코드의 마지막 `defer` 문을 첫 번째로 실행합니다.

```swift
func processFile(filename: String) throws {
  if exists(filename) {
    let file = open(filename)
    defer {
      close(file)
    }
    while let line = try file.readline() {
      // 파일 작업함.
    }
    // close(file) 은, 영역의 끝인, 여기서 호출함.
  }
}
```

위 예제는 `defer` 문을 사용하여 `open(_:)` 함수에 해당하는 `close(_:)` 를 호출함을 보장합니다.

> 에러 처리 코드와 엮이지 않은 때에도 `defer` 문을 사용할 수 있습니다.

### 다음 장

[Concurrency (동시성) >]({% link docs/swift-books/swift-programming-language/concurrency.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [Error Handling](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html) 에서 볼 수 있습니다.

[^first-class-support]: 스위프트가 에러 처리를 일-급 지원 (first-class support) 한다는 건 언어 수준에서 에러 처리를 지원한다는 의미입니다. 이에 대한 더 자세한 정보는 [Error Handling with Try and Catch in Swift](https://www.appypie.com/error-handling-swift-do-try-catch) 항목을 보도록 합니다. 

[^empty-protocol]: `Error` 프로토콜은 본문이 없는 빈 프로토콜로 구현되어 있습니다. 즉, `Error` 라는 타입만 정의한 프로토콜입니다.

[^unwinding-call-stack]: '호출 스택 풀기 (unwinding call stack)' 는 프로그램의 다른 곳에서 실행을 다시 시작하려고 스택에서 하나 이상의 프레임을 뽑아서 (pop) 풀어버리는 걸 말합니다. 다른 프로그래밍 언어의 예외 처리는 던져진 예외를 처리할 때까지 스택을 풉니다. 반면, 스위프트는 호출 스택 풀기를 하지 않습니다. 호출 스택 풀기에 대한 더 자세한 정보는, 위키피디아의 [Call stack](https://en.wikipedia.org/wiki/Call_stack) 항목의 [Unwinding](https://en.wikipedia.org/wiki/Call_stack#Unwinding) 부분을 참고하기 바랍니다.

[^try-expression]: '`try` 표현식' 에 대한 더 자세한 정보는 [Expressions (표현식)]({% link docs/swift-books/swift-programming-language/expressions.md %}) 장의 [Try Operator ('try' 연산자)]({% link docs/swift-books/swift-programming-language/expressions.md %}#try-operator-try-연산자) 부분을 보도록 합니다.

[^error-to-optional]: 본문에서 설명한 것처럼, `try?` 는 모든 에러를 `nil` 로 변환한다는, 단 한 가지 방식으로만 처리합니다. 즉, `try?` 는 사실상 모든 에러를 똑같은 방식으로만 처리할 수 있습니다.

[^runtime-error]: 실행 시간에 에러를 던지지 않을 거라는 사실을 안다는 건, 결국 그 때가 '실행 시간에 에러가 나면 안될 때' 이기 때문입니다. 즉, `try!` 는 실행 시간에 에러가 나면 안되는 걸, 개발 과정에서 미리 파악하여 조치하고자 사용하는 겁니다.

[^file-discriptors]: '파일 서술자 (file descriptors)' 는 `POSIX` 운영 체제에서 특정 파일에 접근하기 위한 추상적인 키를 의미합니다. 이에 대한 더 자세한 정보는, 위키피디아의 [File descriptor](https://en.wikipedia.org/wiki/File_descriptor) 항목과 [파일 서술자](https://ko.wikipedia.org/wiki/파일_서술자) 항목을 보도록 합니다.

[^runtime-assertion]: '실행시간 단언문 (runtime assertion)' 에 대한 더 자세한 정보는 [The Basics (기초)]({% link docs/swift-books/swift-programming-language/the-basics.md %}) 장에 있는 [Assertions and Preconditions (단언문과 선행 조건문)]({% link docs/swift-books/swift-programming-language/the-basics.md %}#assertions-and-preconditions-단언문과-선행-조건문) 부분을 보도록 합니다. 