---
layout: post
comments: true
title:  "Swift 5.5: Error Handling (에러 처리)"
date:   2020-05-16 10:00:00 +0900
categories: Swift Language Grammar Error Handling
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Error Handling](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html) 부분[^Error-Handling]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Error Handling (에러 처리)

_에러 처리 (error handling)_ 는 프로그램의 에러 조건에 응답하고 이로부터 복구하는 과정입니다. 스위프트는 실행 시간에 '복구 가능한 에러' 를 던지고, 잡아내며, 전파하고, 조작하기 위한 '일급 지원'[^first-class-support] 을 제공합니다.

연산들이 실행을 완료하거나 유용한 결과를 만드는 것을 항상 보장하는 것은 아닙니다. '옵셔널' 을 사용하여 '값의 없음' 을 표현하긴 하지만, 작업이 실패했을 때, 무엇이 실패를 유발한 것인지를 이해해서, 코드가 적당하게 응답할 수 있도록 하는게, 유용할 때가 있습니다.

예를 들어, '디스크 (disk)' 의 파일에서 자료를 읽고 처리하는 작업을 고려해 봅시다. 이 작업은, 지정한 경로에 파일이 존재하지 않거나, 파일에 대한 읽기 권한이 없는 것, 또는 파일이 호환 가능한 양식으로 인코딩되지 않은 것을 포함한, 여러 가지 이유로 실패할 수 있습니다. 이런 서로 다른 상황들 사이를 구별하는 것은 프로그램이 일부 에러를 해결하도록 그리고 해결할 수 없는 에러는 어떤 것이라도 사용자와 소통하도록 허용합니다.

> 스위프트의 에러 처리는 'Cocoa' 와 오브젝티브-C 에서 `NSError` 클래스를 사용한 '에러 처리 패턴' 과 상호 호환됩니다. 이 클래스에 대한 더 많은 정보는, [Handling Cocoa Errors in Swift (스위프트에서 Cocoa 에러 처리하기)](https://developer.apple.com/documentation/swift/cocoa_design_patterns/handling_cocoa_errors_in_swift) 를 참고하기 바랍니다.

### Representing and Throwing Errors (에러 표현하기와 던지기)

스위프트에서, 에러는 `Error` 프로토콜을 준수하는 타입의 값으로 표현합니다. 이 '빈 프로토콜'[^empty-protocol] 은 에러 처리에 타입을 사용할 수 있음을 지시합니다.

스위프트의 열거체는 특히 관련된 에러 조건의 그룹을, 소통할 에러의 본질에 대한 추가적인 정보를 허용하는 '결합 값' 으로, 모델링하기에 꽤 적합합니다. 예를 들어, 다음은 게임 내 '자동 판매기' 작동의 에러 조건들을 표현할 수도 있는 방법입니다:

```swift
enum VendingMachineError: Error {
  case invalidSelection
  case insufficientFunds(coinsNeeded: Int)
  case outOfStock
}
```

'에러를 던지는 것' 은 예상하지 못한 어떤 것이 발생해서 보통의 실행 흐름을 계속할 수 없음을 지시합니다. 에러를 던지기 위해서는 `throw` 문을 사용합니다. 예를 들어, 다음 코드는 자동 판매기에서 동전 5개가 추가로 더 필요하다는 에러를 던집니다:

```swift
throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
```

### Handling Errors (에러 처리하기)

에러를 던질 때는, 주위의 어떤 코드가 반드시 에러 처리-예를 들어, 문제를 올바로 고치거나, 다른 대안을 시도하거나, 또는 사용자에게 실패를 알리는 등의-책임을 져야 합니다.

스위프트의 에러 처리에는 네 가지 방법이 있습니다. 에러는 (발생한) 함수에서 해당 함수를 호출한 코드로 '전파 (propagate)' 하거나, 에러를 `do-catch` 문으로 처리하거나, 또는 에러를 '옵셔널 값' 으로 처리하거나, 아니면 에러가 일어나지 않을 것이라고 '단언 (assert)' 할 수 있습니다. 각각의 접근 방식에 대해서는 아래 부분에서 설명합니다.

함수가 에러를 던질 때, 프로그램의 흐름이 바뀌므로, 에러를 던질 수 있는 위치를 코드에서 빨리 식별할 수 있는 것이 중요합니다. 코드에서 이런 위치를 식별하려면, 에러를 던질 수 있는 함수, 메소드, 또는 초기자 호출 코드 앞에, `try` 키워드-또는 `try?` 나 `try!` 같은 변형-을 작성합니다. 이 '키워드' 들에 대해서는 아래 부분에서 설명합니다.

> 스위프트의 '에러 처리' 는, `try`, `catch`, 그리고 `throw` 키워드를 사용하는, 다른 언어의 '예외 (exception) 처리' 와 닮았습니다. 오브젝티브-C 를 포함한-많은 언어에서의 '예외 처리' 와는 달리, 스위프트의 에러 처리는, 계산 비용이 비쌀 수 있는 과정인, '호출 스택 풀기 (unwinding call stack)'[^unwinding-call-stack] 와 엮여 있지 않습니다. 그로 인해, `throw` 문의 성능은 `return` 문에 필적합니다.

#### Propagating Errors Using Throwing Functions ('던지는 함수' 를 사용하여 에러 전파하기)

함수, 메소드, 또는 초기자가 에러를 던질 수 있다고 지시하려면, 함수 선언에 있는 매개 변수 뒤에 `throws` 키워드를 작성합니다. `throws` 로 표시한 함수를 _던지는 함수 (throwing function)_ 라고 합니다. 함수가 반환 타입을 지정하는 경우, `throws` 키워드를 '반환 화살표 (`->`)' 앞에 작성합니다.

```swift
func canThrowErrors() throws -> String

func cannotThrowErrors() -> String
```

'던지는 함수' 는 자기 안에서 던져진 에러를 자기를 호출하는 영역으로 전파합니다.

> 오직 '던지는 함수' 만이 에러를 전파할 수 있습니다. '던지지 않는 (nonthrowing) 함수' 안에서 던져진 에러는 어떤 것이든 반드시 함수 안에서 처리해야 합니다.

아래 예제에서, `VendingMachine` 클래스는, 요청한 항목이 사용 가능하지 않거나, 재고가 없거나, 아니면 비용이 현재 보관중인 양을 초과할 경우, 적절한 `VendingMachineError` 를 던지는 `vend(itemNamed:)` 메소드를 가집니다:

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

`vend(itemNamed:)` 메소드의 구현은 간식 구매를 위한 어떤 '필수 조건' 도 만족하지 않을 경우 메소드를 조기에 종료하고 적절한 에러를 던지기 위해 `guard` 문을 사용합니다. `throw` 문은 프로그램 제어를 곧바로 전달하기 때문에, 모든 '필수 조건' 을 만족할 경우에만 항목을 판매할 것입니다.

`vend(itemNamed:)` 메소드는 어떤 에러를 던져도 다 전파하기 때문에, 이 메소드를 호출하는 코드는 어떤 것이든 반드시-`do-catch` 문, `try?`, 또는 `try!` 을 사용하여-에러를 처리하던가, 아니면 전파를 계속하던가 해야 합니다. 예를 들어, 아래 예제에 있는 `buyFavoriteSnack(person:vendingMachine:)` 도 '던지는 함수' 이며, `vend(itemNamed:)` 메소드가 던지는 어떤 에러든 `buyFavoriteSnack(person:vendingMachine:)` 함수를 호출하는 곳으로 '위로 전파 (propagate up)' 할 것입니다.

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

이 예제에서, `buyFavoriteSnack(person:vendingMachine:)` 함수는 주어진 사람이 가장 좋아하는 간식거리를 찾아 보고 `vend(itemNamed:)` 메소드를 호출하여 이를 사려고 합니다. `vend(itemNamed:)` 메소드는 에러를 던질 수 있기 때문에, 앞에다 `try` 키워드 붙여서 호출합니다.

'던지는 초기자 (throwing initializers)' 는 '던지는 함수' 와 같은 방식으로 에러를 전파할 수 있습니다. 예를 들어, 아래에 나열한 `PurchasedSnack` 구조체의 초기자는 초기화 과정에서 '던지는 함수' 를 호출하며, 마주치는 어떤 에러든 호출하는 쪽으로 전파하는 것으로써 이를 처리합니다.

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

`do`-`catch` 문은 코드 블럭을 실행하는 것으로 에러를 처리하고자 사용합니다. `do` 절의 코드가 에러를 던지면, 에러를 처리할 수 있는 것을 결정하기 위해 `catch` 절과 맞춰봅니다.

다음은 `do`-`catch` 문의 일반적인 형식입니다:

do {<br />
&nbsp;&nbsp;&nbsp;&nbsp;try `expression-표현식`<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
} catch `pattern 1-유형 1` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
} catch `pattern 2-유형 2` where `condition-조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
} catch `pattern 3-유형 3`, `pattern 4--유형 4` where `condition-조건` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
} catch {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
}

해당 '절 (clause)' 이 처리할 수 있는 에러가 무엇인지 표시하려면 `catch` 뒤에 '유형 (pattern)' 을 작성합니다. `catch` 절에 '유형' 이 없으면, 이 절은 어떤 에러와도 일치하며 에러를 `error` 라는 이름의 '지역 상수' 로 '연결 (bind)' 합니다. '유형 맞춤 (pattern matching; 패턴 매칭)' 에 대한 더 많은 정보는, [Patterns (패턴; 유형)]({% post_url 2020-08-25-Patterns %}) 을 참고하기 바랍니다.

예를 들어, 다음 코드는 `VendingMachineError` 열거체의 모든 세 'case 값' 들과 맞춰봅니다.

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
// "Insufficient funds. Please insert an additional 2 coins." 를 인쇄합니다.
```

위 예제에서, `buyFavoriteSnack(person:vendingMachine:)` 함수는, 에러를 던질 수 있기 때문에, '`try` 표현식'[^try-expression] 안에서 호출합니다. 에러를 던지면, 실행은 곧바로, 전파를 계속 허용할 지를 결정하는, `catch` 절로 옮깁니다. 아무 '유형' 과도 일치하지 않으면, 에러는 '최종 `catch` 절' 이 잡아내며 `error` 라는 지역 상수와 연결됩니다. 아무 에러도 던지지 않으면, `do` 문에 있는 나머지 구문들을 실행합니다.

`catch` 절은 `do` 절의 코드가 던질 가능성이 있는 모든 에러를 처리하지 않아도 됩니다. 아무런 `catch` 절도 에러를 처리하지 않으면, 에러를 주위 영역으로 전파합니다. 하지만, _어떤 (some)_ 주위 영역에서 반드시 이 전파한 에러를 처리해야 합니다. '던지지 않는 (nonthrowing) 함수' 는, '테두리를 친 `do`-`catch` 문' 이 에러를 반드시 처리해야 합니다. '던지는 함수' 는, '테두리를 친 `do-catch` 문' 이든 '호출한 쪽 (caller)' 이든 어느 한 곳에서 에러를 반드시 처리해야 합니다. 에러가 처리되지 않은 채로 '최상단 (top-level) 영역' 으로 전파되면, 실행시간 에러를 가질 것입니다.

예를 들어, 위 예제는 `VendingMachineError` 가 아닌 에러는 어떤 것이든 호출 함수가 대신 잡아내도록 작성할 수 있습니다:

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
// "Invalid selection, out of stock, or not enough money." 를 인쇄합니다.
```

`nourish(with:)` 함수에서, `vend(itemNamed:)` 가 `VendingMachineError` 열거체의 'case 값' 에 해당하는 에러를 던지면, `nourish(with:)` 는 메시지를 인쇄하는 것으로써 에러를 처리합니다. 그 외의 경우, `nourish(with:)` 는 호출한 쪽으로 에러를 전파합니다. 그런 다음 '일반적인 `catch` 절' 이 에러를 잡아냅니다.

서로 관련된 여러 에러를 잡아내는 또 다른 방법은 `catch` 뒤에, 쉼표로 구분하여, 이들을 나열하는 것입니다. 예를 들면 다음과 같습니다:

```swift
func eat(item: String) throws {
  do {
    try vendingMachine.vend(itemNamed: item)
  } catch VendingMachineError.invalidSelection, VendingMachineError.insufficientFunds, VendingMachineError.outOfStock {
    print("Invalid selection, out of stock, or not enough money.")
  }
}
```

`eat(item:)` 함수는 잡아낼 '자판기 (vending machine) 에러' 를 나열하며, 에러 문장은 해당 목록에 있는 항목과 연관이 있습니다. 나열된 세 개의 에러 중 어떤 것이든 던져지면, 이 `catch` 절은 메시지를 인쇄하는 것으로써 이를 처리합니다. 나중에 추가될 수도 있는 자판기 에러를 포함한, 다른 에러는 어떤 것이든 주위 영역으로 전파합니다.

#### Converting Errors to Optional Values (에러를 '옵셔널 값' 으로 변환하기)

`try?` 는 옵셔널 값으로 변환함으로써 에러를 처리하기 위해 사용합니다. `try?` 표현식을 평가하는 동안 에러를 던지면, 표현식의 값이 `nil` 입니다. 예를 들어, 다음의 `x` 와 `y` 코드는 똑같은 값과 작동 방식을 가집니다:

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

`someThrowingFunction()` 이 에러를 던지면, `x` 와 `y` 의 값은 `nil` 입니다. 그 외의 경우, `x` 와 `y` 의 값은 함수가 반환한 값입니다. `x` 와 `y` 는 `someThrowingFunction()` 이 무슨 타입을 반환하던 '옵셔널' 임을 기억하기 바랍니다. 여기선 함수가 '정수 (integer)' 를 반환하므로, `x` 와 `y` 는 '옵셔널 정수' 들입니다.

`try?` 를 사용하는 것은 모든 에러를 똑같은 방식으로 처리하고 싶을 때 '에러 처리 코드' 를 간결하게 작성하도록 해줍니다.[^error-to-optional] 예를 들어, 다음 코드는 자료를 가져오기 위해 여러 접근 방식을 사용하며, 모든 접근 방식이 실패하면 `nil` 을 반환합니다.

```swift
func fetchData() -> Data? {
  if let data = try? fetchDataFromDisk() { return data }
  if let data = try? fetchDataFromServer() { return data }
  return nil
}
```

#### Disabling Error Propagation (에러 전파 못하게 하기)

'던지는' 함수나 메소드가, 사실상, 실행 시간에 에러를 던지지 않을 것임을 알고 있을 때가 있습니다. 그럴 때는, 에러 전파를 못하게 하고 아무런 에러도 던지지 않을 거라는 '실행시간 단언문 (runtime assertion)' 으로 호출을 포장하기 위해 표현식 앞에 `try!` 를 작성할 수 있습니다. 에러를 실제로 던지게 되면, 실행시간 에러를 가질 것입니다.[^runtime-error]

예를 들어, 다음 코드는, 주어진 경로의 이미지 자원을 불러오거나 이미지를 불러올 수 없다면 에러를 던지는, `loadImage(atPath:)` 함수를 사용합니다. 이 경우, 이미지는 응용 프로그램과 같이 출하하기 때문에, 실행 시간에 에러를 던지지 않을 것이므로, 에러 전파를 못하게 하는 것이 적절합니다.

```swift
let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
```

### Specifying Cleanup Actions (정리 작업 지정하기)

`defer` 문은 실행이 현재 코드 블럭을 떠나기 직전에 일정 구문 집합을 실행하기 위해 사용합니다. 이 구문은 실행이 현재 코드 블럭을-에러를 던지기 때문에 아니면 `return` 이나 `break` 같은 구문 때문에 떠나는 것이든-떠나는 _방법 (how)_ 에는 관계 없이 수행할 필요가 있는 정리는 어떤 것이든 하도록 해줍니다. 예를 들어, '파일 서술자 (file descriptors)'[^file-discriptors] 를 닫고 수동으로 할당한 메모리를 풀어서 확보한다는 것을 보장하기 위해 `defer` 문을 사용할 수 있습니다.

`defer` 문은 현재 영역을 빠져나갈 때까지 실행을 지연합니다. 이 구문은 `defer` 키워드와 나중에 실행할 구문들로 이루어져 있습니다. '지연된 (deferred) 구문' 들은, `break` 나 `return` 문, 또는 에러를 던지는 것과 같이, 제어를 구문 외부로 옮기는 어떤 코드를 담고 있지 않을 수도 있습니다. '지연된 행동' 들은 소스 코드에서 작성한 것과 반대 순서로 실행됩니다. 즉, 첫 번째 `defer` 문 코드를 마지막에 실행하고, 두 번째 `defer` 문 코드를 마지막에서 두 번째로 실행하며, 이를 계속합니다. 소스 코드 순서로 마지막인 `defer` 문을 맨 처음 실행합니다.

```swift
func processFile(filename: String) throws {
  if exists(filename) {
    let file = open(filename)
    defer {
      close(file)
    }
    while let line = try file.readline() {
      // 파일 작업을 함.
    }
    // close(file) 은, 영역의 끝인, 여기서 호출합니다.
  }
}
```

위 예제는 `open(_:)` 함수가 `close(_:)` 라는 연관된 호출을 가진다는 것을 보장하기 위해 `defer` 문을 사용합니다.

> `defer` 문은 에러 처리 코드와 엮여 있지 않은 때에도 사용할 수 있습니다.

### 다음 장

[Concurrency (동시성) > ]({% post_url 2021-06-10-Concurrency %})

### 참고 자료

[^Error-Handling]: 이 글에 대한 원문은 [Error Handling](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^first-class-support]: 여기서 말하는 '일급 지원 (first-class support)' 이란, '복구 가능한 에러 (recoverable errors)' 를 하나의 객체로써 취급할 수 있다는 의미로 추측됩니다.

[^empty-protocol]: 실제로 스위프트에서 `Error` 프로토콜은 아무 내용이 없는 '빈 (empty) 프로토콜' 입니다. 즉, `Error` 라는 타입만을 정의하고 있습니다.

[^unwinding-call-stack]: '호출 스택 풀기 (unwinding call stack)' 는 프로그램의 다른 위치에서 실행을 재개하기 위해 스택에서 하나 이상의 프레임을 '뽑아내어 (pop)' 풀어버리는 작업입니다. 다른 프로그래밍 언어에 있는 '예외 처리' 는 던져진 예외를 처리할 때까지 스택을 풉니다. 반면, 스위프트는 이런 '호출 스택 풀기' 를 하지 않습니다. '호출 스택 풀기' 에 대한 더 자세한 정보는 위키피디아의 [Call stack](https://en.wikipedia.org/wiki/Call_stack) 항목에 있는 [Unwinding](https://en.wikipedia.org/wiki/Call_stack#Unwinding) 부분을 참고하기 바랍니다.

[^try-expression]: '`try` 표현식' 에 대한 더 자세한 정보는 [Expressions (표현식)]({% post_url 2020-08-19-Expressions %}) 장의 [Try Operator ('try' 연산자)]({% post_url 2020-08-19-Expressions %}#try-operator-try-연산자) 부분을 참고하기 바랍니다.

[^error-to-optional]: 본문에서 설명한 것처럼, `try?` 는 모든 에러를 `nil` 로 변환한다는, 단 한 가지 방식으로만 처리합니다. 따라서 `try?` 는 사실상 에러를 무시해도 상관없을 때 사용합니다. 예제에서 사용한 `someThrowingFunction()` 함수의 경우 모든 에러는 결국 '정수 (integer)' 를 반환할 수 없을 경우에만 발생합니다. 즉, 정수를 반환할 수 없는 모든 경우에 대해 발생하는 모든 에러를 `nil` 로 변환해서 무시하고자 한다면, `try?` 를 사용할 수 있습니다.

[^runtime-error]: 실행시간 에러가 발생할 수도 있는데 `try!` 를 왜 사용하는지 의문이 들 수도 있습니다. 본문에서 표현한 '실행 시간에 에러를 던지지 않을 것임을 알고 있을 때' 라는 건, 결국 '실행 시간에 에러가 나면 안되는 상황' 을 말하는 것입니다. 즉, `try!` 는 실행 시간에 에러가 나면 안되는 상황을 개발 과정에서 미리 파악하고 해결하기 위해서 사용하는 것입니다. 실행 시간에 에러가 절대로 나면 안되는 코드라면, 개발 과정에서 `try!` 를 사용한다고 이해하면 됩니다.

[^file-discriptors]: '파일 서술자 (file descriptors)' 는 `POSIX` 운영 체제에서 특정 파일에 접근하기 위한 추상적인 키를 말하는 컴퓨터 용어라고 합니다. 보다 자세한 내용은 위키피디아의 [File descriptor](https://en.wikipedia.org/wiki/File_descriptor) 항목과 [파일 서술자](https://ko.wikipedia.org/wiki/파일_서술자) 항목을 참고하기 바랍니다.
