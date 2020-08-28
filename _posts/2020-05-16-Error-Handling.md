---
layout: post
comments: true
title:  "Swift 5.2: Error Handling (에러 처리)"
date:   2020-05-16 10:00:00 +0900
categories: Swift Language Grammar Error Handling
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Error Handling](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html) 부분[^Error-Handling]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## Error Handling (에러 처리)

_에러 처리 (error handling)_ 는 프로그램의 에러 상황에 대해 응답하고 여기서 복구하는 과정을 말합니다. 스위프트는 복구 가능한 에러를 실행 시간에 던지고, 잡아내며, 전파하고, 조작하기 위한 일급의 지원 기능을 제공합니다.

어떤 작업은 '실행의 종료' 나 '유용한 결과의 생성' 을 항상 보장하지는 않습니다. '옵셔널 (optionals)' 을 사용하면 '값이 없음' 을 나타낼 순 있지만, 작업이 실패했을 때, 실패한 원인이 무엇인지 이해할 수 있다면, 코드에서 적절하게 응답할 수 있으므로 이또한 유용할 것입니다.

예를 들어, 디스크에 있는 파일에서 자료를 읽고 처리하는 작업을 고려해 봅시다. 이 작업은 여러가지 이유로 실패할 수 있는데, 지정된 경로에 파일이 존재하지 않을 수도 있고, 그 파일에 대한 읽기 권한이 없을 수도 있고, 또는 그 파일이 호환되지 않는 양식으로 'encoding (부호화)' 되었을 수도 있습니다. 이런 상황을 서로 구별할 수 있다면 프로그램이 일부 에러를 해결할 수도 있고 해결할 수 없는 에러를 사용자와 소통할 수도 있을 것입니다.

> 스위프트의 에러 처리는 'Cocoa' 와 오브젝티브-C 언어에서 `NSError` 클래스를 사용하는 '에러 처리 패턴' 과 상호 호환됩니다. 이 클래스에 대한 더 자세한 내용은, [Handling Cocoa Errors in Swift (스위프트에서 Cocoa 에러 처리하기)](https://developer.apple.com/documentation/swift/cocoa_design_patterns/handling_cocoa_errors_in_swift) 를 참고하기 바랍니다.

### Representing and Throwing Errors (에러를 표현하고 던지기)

스위프트의, 에러는 `Error` 프로토콜을 준수하는 타입의 값으로 표현합니다. 이 빈 프로토콜은 에러 처리에 사용될 수 있는 타입을 지시합니다.

스위프트의 열거체는 관계가 있는 에러 상황들을 그룹으로 모델링 하는데 특화되어 있으며, '결합된 값 (associated values)' 으로 에러의 본질에 대한 추가적인 정보를 전달할 수 있습니다. 예를 들어, 게임에서 자동 판매기가 작동할 때의 에러 상황들은 다음과 같이 표현할 수도 있을 것입니다:

```swift
enum VendingMachineError: Error {
  case invalidSelection
  case insufficientFunds(coinsNeeded: Int)
  case outOfStock
}
```

에러를 던진다는 것은 예기치 않은 일이 발생해서 정상적인 실행 흐름을 계속할 수 없음을 지시합니다. 에러를 던지려면 `throw` 문을 사용합니다. 예를 들어, 다음 코드는 에러를 던져서 자동 판매기에 추가로 동전 5개가 더 필요함을 알립니다:

```swift
throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
```

### Handling Errors (에러 처리하기)

에러를 던지면, 주변 코드에서 그 에러를 반드시 책임져야 합니다-예를 들어, 문제를 고치든, 다른 접근 방법을 시도하든, 아니면 사용자에게 실패를 알리든 뭔가를 해야 합니다.

스위프트의 에러 처리 방법에는 네 가지가 있습니다. 에러를 한 함수에서 그 함수를 호출한 코드로 전파할 수도 있고, `do-catch` 문으로 처리할 수도 있으며, 혹은 '옵셔널 값 (optional value)' 으로 처리하거나, 아니면 이 에러는 발생하지 않을 거라고 '단언 (assert)' 할 수도 있습니다. 각각의 접근 방법은 아래 장에서 설명합니다.

함수가 에러를 던지면, 프로그램의 흐름이 바뀌게 되므로, 에러를 던질 수 있는 코드 위치를 재빨리 식별할 수 있는 것이 중요합니다. 이 코드 위치를 식별하려면, `try` 키워드-또는 `try?` 나 `try!` 같은 변형-을 에러를 던질 수 있는 함수나, 메소드, 혹은 초기자 호출 코드 앞에 작성합니다. 이 키워드들은 아래 장에서 설합니다.

> 스위프트의 '에러 처리' 는, `try`, `catch` 와 `throw` 키워드를 사용하는, 다른 언어의 '예외 처리 (exception handling)' 와 비슷해 보입니다. 다만, 오브젝티브-C 언어를 포함한-많은 언어들의 '예외 처리' 와 다르게, 스위프트의 에러 처리는 계산 비용이 많이 드는 과정인, '호출 스택 (call stack)' 을 풀지 않습니다. 그로 인해, `throw` 문의 성능은 `return` 문에 필적합니다.

#### Propagating Errors Using Throwing Functions ('던지는 함수' 로 에러 전파하기)

함수, 메소드, 또는 초기자가 에러를 던질 수 있다고 지시하려면, 함수 선언의 매개 변수 뒤에 `throws` 키워드를 써주면 됩니다. `throws` 로 표시된 함수를 _던지는 함수 (throwing function)_ 이라고 합니다. 이 함수가 반환 타입을 지정할 경우, `throws` 키워드는 '반환 화살표 (return arrow; `->`)' 앞에 써줍니다.

```swift
func canThrowErrors() throws -> String

func cannotThrowErrors() -> String
```

'던지는 함수' 는 안에서 던져진 에러를 자신을 호출한 영역으로 전파합니다.

> '던지는 함수' 만 에러를 전파할 수 있습니다. '던지지 않는 함수 (nonthrowing function)' 내에서 던져진 에러는 반드시 그 함수 내에서 처리해야 합니다.

아래 예제에 있는, `VendingMachine` 클래스는 `vend(itemNamed:)` 메소드를 가지고 있는데, 이는 요청한 항목이 유효하지 않거나, 재고가 없거나, 아니면 비용이 현재 예치된 금액을 초과할 경우, 이에 따른 적절한 `VendingMachineError` 를 던집니다:

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

`vend(itemNamed:)` 메소드는, 간식 구매를 위한 '필수 조건' 이 만족되지 않으면, `guard` 문으로 메소드를 조기 종료하고 적절한 에러를 던지도록 구현되었습니다. `throw` 문은 프로그램 제어를 즉시 전달하므로, 모든 '필수 조건' 을 만족해야만 항목을 판매합니다.

`vend(itemNamed:)` 메소드는 던지는 에러는 어떤 것이든 다 전파하므로, 이 메소드를 호출하는 코드는 어떤 것이든 각자 반드시 에러를 처리해야 합니다-`do-catch` 문으로든, `try?`, 또는 `try!` 을 사용하든-아니면 다시 전파하든 말입니다. 예를 들어, 아래 예제의 `buyFavoriteSnack(person:vendingMachine:)` 는 자신도 '던지는 함수' 라서, `vend(itemNamed:)` 메소드가 던지는 에러는 어떤 것이든 다시 위로 전파하여 `buyFavoriteSnack(person:vendingMachine:)` 함수를 호출하는 곳으로 보냅니다.

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

이 예제의, `buyFavoriteSnack(person:vendingMachine:)` 함수는 주어진 사람이 가장 좋아하는 과자를 찾은 다음 `vend(itemNamed:)` 메소드를 호출하여 이를 사려고 시도합니다. `vend(itemNamed:)` 메소드는 에러를 던질 수 있으므로, 호출할 때 `try` 키워드를 앞에 붙입니다.

'던지는 초기자 (throwing initializers)' 는 '던지는 함수' 와 같은 방법으로 에러를 전파할 수 있습니다. 예를 들어, 아래의 `PurchasedSnack` 구조체에 대한 초기자는 초기화 과정에서 '던지는 함수' 를 호출하며, 어떤 에러든 마주치기만 하면 호출하는 쪽으로 전파하는 것으로 이를 처리합니다.

```swift
struct PurchasedSnack {
  let name: String
  init(name: String, vendingMachine: VendingMachine) throws {
    try vendingMachine.vend(itemNamed: name)
    self.name = name
  }
}
```

#### Handling Errors Using Do-Catch ('Do-Catch' 구문으로 에러 처리하기)

에러를 처리하는 코드 블럭을 실행하려면 `do`-`catch` 문을 사용합니다. `do` 절의 코드에서 에러를 던지면, `catch` 절과 일치 여부를 맞춰봐서 이 중에서 어떤 것이 에러를 처리할 수 있는 지를 결정합니다.

`do`-`catch` 문의 일반적인 형식은 다음과 같습니다:

do {
<br />
&nbsp;&nbsp;&nbsp;&nbsp;try `expression`
<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements`
<br />
} catch `pattern 1` {
<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements`
<br />
} catch `pattern 2` where `condition` {
<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements`
<br />
} catch {
<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements`
<br />
}

`catch` 뒤에 '패턴 (pattern)' 을 작성하여 해당 '절 (clause)' 이 처리할 수 있는 에러가 무엇인지 지시합니다. 만약 `catch` 절이 '패턴' 을 가지고 있지 않으면, 이 절은 어떤 에러와도 일치하며 이 에러는 `error` 라는 '지역 상수 이름' 에 '연결 (bind)' 됩니다. '패턴 맞춤 (pattern matching; 패턴 매칭)' 에 대한 더 자세한 내용은 [Patterns (패턴; 유형)]({% post_url 2020-08-25-Patterns %}) 을 참고하기 바랍니다.

예를 들어, 다음 코드는 `VendingMachineError` 열거체의 세 'case 값' 모두와 일치 여부를 맞춰보고 있습니다.

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
// "Insufficient funds. Please insert an additional 2 coins." 를 출력합니다.
```

위 예제에서, `buyFavoriteSnack(person:vendingMachine:)` 함수는 `try` 표현식 안에서 호출하는데, 이는 이것이 에러를 던질 수 있기 때문입니다. 에러를 던지면, 실행은 즉시 `catch` 절로 옮겨지며, 여기서 계속 전파하게 둘지를 결정합니다. 일치하는 '패턴' 이 없으면, 에러는 최종 `catch` 절에서 잡히게 되고 지역 상수인 `error` 에 연결됩니다. 에러를 던지지 않으면, `do` 문 안에 있는 나머지 구문을 실행합니다.

`do` 절에 있는 코드가 던질 가능성이 있는 모든 에러를 `catch` 절에서 처리해야 하는 것은 아닙니다. 어느 `catch` 절에서도 에러를 처리하지 않는 경우, 이 에러는 주변 영역으로 전파됩니다. 하지만, 이렇게 전파된 에러는 _어떤 (some)_ 주변 영역에서 반드시 처리해야 합니다. '던지지 않는 함수 (nonthrowing function)' 에서는, `do`-`catch` 문으로 둘러싼 영역이 반드시 에러를 처리해야 합니다. '던지는 함수 (throwing function)' 에서는, `do-catch` 문으로 둘러싼 영역 또는 이를 호출한 쪽에서 반드시 에러를 처리해야 합니다. 만약 처리되지 않은 에러가 최상위 영역에 까지 전파된다면, '실행시간 에러' 를 보게 될 것입니다.

예를 들어, 위 예제를 재작성하면 `VendingMachineError` 가 아닌 어떤 에러라도 호출 함수에서 대신 잡아내도록 할 수 있습니다:

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
// "Invalid selection, out of stock, or not enough money." 를 출력합니다.
```

`nourish(with:)` 함수에서, `vend(itemNamed:)` 가 `VendingMachineError` 열거체의 'case 값' 중 하나에 해당하는 에러를 던지면, `nourish(with:)` 는 메시지를 출력하는 것으로 이 에러를 처리합니다. 이외의 경우, `nourish(with:)` 는 이 에러를 호출하는 쪽으로 전파합니다. 에러는 이제 일반 범용 `catch` 절에 의해 잡히게 됩니다.

#### Converting Errors to Optional Values (에러를 '옵셔널 값' 으로 변환하기)

`try?` 를 사용하면 에러를 '옵셔널 값 (optional value)' 으로 변환할 수 있습니다. `try?` 표현식의 값을 계산할 때 에러가 던져진 경우, 이 표현식의 값은 `nil` 이 됩니다. 예를 들어, 다음의 코드의 `x` 와 `y` 는 같은 값을 가지며 동작도 같습니다:

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

`someThrowingFunction()` 이 에러를 던지면, `x` 와 `y` 의 값은 `nil` 이 됩니다. 이외의 경우, `x` 와 `y` 의 값은 함수의 반환 값이 됩니다. `x` 와 `y` 는 `someThrowingFunction()` 의 반환하는 것이 무슨 타입이든 '옵셔널 (optional)' 임을 기억하기 바랍니다. 여기서는 함수가 '정수 (integer)' 를 반환하므로, `x` 와 `y` 는 '옵셔널 정수 (optional integers)' 입니다.

모든 에러를 같은 방식으로 처리하고 싶을 때 `try?` 를 사용하면 에러 처리 코드를 간결하게 작성할 수 있습니다.[^error-to-optional] 예를 들어, 아래 코드는 자료를 가져오기 위해 여러 가지 방법을 사용하는데, 모든 방법이 실패할 경우 `nil` 을 반환합니다.

```swift
func fetchData() -> Data? {
  if let data = try? fetchDataFromDisk() { return data }
  if let data = try? fetchDataFromServer() { return data }
  return nil
}
```

#### Disabling Error Propagation (에러 전파 못하게 하기)

'던지는 함수' 나 '던지는 메소드' 가, 실제로는, 실행시간에 에러를 던지지 않을 거라는 것을 알 수도 있습니다. 그런 경우, 표현식 앞에 `try!` 를 사용하면 에러 전파를 못하게 하고 이 호출을 '실행시간 단언문 (runtime assertion)' 으로 감싸서 에러를 던지지 않을 거라고 단언할 수 있습니다. 이 때 에러가 실제로 던져지면, 실행시간 에러가 발생합니다.[^runtime-error]

예를 들어, 다음 코드는 `loadImage(atPath:)` 함수로, 주어진 경로의 이미지 자원을 불러오거나 혹은 이미지를 불러올 수 없다는 에러를 던집니다. 이런 경우, 이미지는 응용 프로그램과 함께 출하하므로, 실행 시간에 에러를 던질 일이 없으며, 따라서 에러 전파를 못하게 하는 것이 아주 적절합니다.

```swift
let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
```

### Specifying Cleanup Actions (정리 작업 지정하기)

`defer` 문을 사용하면 실행 코드가 현재 코드 블럭을 나가기 전에 일정 구문을 실행할 수 있습니다. 이 구문을 사용하면 현재 코드 블럭을 _어떤 방법으로 (how)_ 나가든 상관없이 해야할 필요가 있는 정리를 할 수 있습니다-에러가 던져져서 나가게 됐든 아니면 `return` 이나 `break` 문 등으로 나가게 됐든 상관없습니다. 예를 들어, `defer` 문을 사용하면 'file descriptors (파일 서술자)'[^file-discriptors] 를 닫고 수동으로 할당된 메모리를 풀어서 확보했다고 보장할 수 있습니다.

`defer` 문은 현재 영역이 종료될 때까지 실행을 지연합니다. 이 구문은 `defer` 키워드와 나중에 실행할 구문들로 구성됩니다. '지연 구문 (deferred statements)' 은, `break` 나 `return` 문 등, 또는 에러를 던지는 것 등의, 제어를 구문 밖으로 전달하게 되는 코드는 포함하지 않는 것이 좋습니다. 지연된 작업은 소스 코드에 작성된 것과 반대 순서로 실행됩니다. 즉, 첫 번째 `defer` 문 코드가 맨 마지막에 실행되고, 두 번째 `defer` 문 코드가 마지막에서 두 번째로 실행되며, 죽 이런 식입니다. 소스 코드 순서에서 가장 마지막의 `defer` 문이 맨 처음에 실행됩니다.

```swift
func processFile(filename: String) throws {
  if exists(filename) {
    let file = open(filename)
    defer {
      close(file)
    }
    while let line = try file.readline() {
      // 파일 작업을 수행합니다.
    }
    // close(file) 은, 영역의 끝인, 여기서 호출됩니다.
  }
}
```

위의 예제는 `open(_:)` 함수와 연관되어 있는 `close(_:)` 를 호출할 것임을 보장하기 위해 `defer` 문을 사용하고 있습니다.

> `defer` 문은 에러 처리 코드와 상관없이 사용할 수 있습니다.

### 참고 자료

[^Error-Handling]: 이 글에 대한 원문은 [Error Handling](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html) 에서 확인할 수 있습니다.

[^error-to-optional]: 본문에도 나와 있듯이 `try?` 는 모든 에러를, `nil` 로 변환한다고 하는, 한 가지 방식으로만 처리합니다. 따라서 `try?` 는 모든 에러를 무시해도 상관없는 경우에만 사용할 수 있습니다. 생각해보면, 예제에서 사용된 `someThrowingFunction()` 도 원래 `nil` 이 될 수 있는 함수이고, 이 함수의 모든 에러는 '정수 (integer)' 를 만들 수 없는 경우로 한정됩니다. 따라서, 이 경우에 모든 에러를 `nil` 로 변경한다고 해서 프로그램 실행에 문제가 될 것은 없습니다.

[^runtime-error]: 실행시간 에러가 발생할 수도 있는데 `try!` 나 '실행시간 단언문 (runtime assertion)' 을 왜 사용하는지 의문이 들 수 있습니다. 사실 좀 더 정확하게 표현하면 `try!` 는 '에러가 발생하지 않을 거라는 것을 알고 있는 상황에서 사용하는 것' 이라기 보다는, '에러가 나면 안되는 상황을 개발 과정에서 미리 알기 위해 사용하는 것' 입니다. 실행 시간에 에러가 나는 것을 막을 수는 없으므로 상황에 맞는 '에러 처리' 는 항상 필요하지만, 에러가 절대 나면 안되는 코드를 미리 걸러내고 싶을 때는 개발 과정에서 `try!` 를 사용하면 된다고 이해할 수 있습니다.

[^file-discriptors]: 'file descriptors' 는 '파일 서술자' 라고 하는데, POSIX 운영 체제에서 특정 파일에 접근하기 위한 추상적인 키를 말하는 컴퓨터 용어라고 합니다. 보다 자세한 내용은 위키피디아의 [File descriptor](https://en.wikipedia.org/wiki/File_descriptor) 와 [파일 서술자](https://ko.wikipedia.org/wiki/파일_서술자) 를 참고하기 바랍니다.
