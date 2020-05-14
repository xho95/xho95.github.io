---
layout: post
comments: true
title:  "Swift 5.2: Error Handling (에러 처리)"
date:   2020-05-11 10:00:00 +0900
categories: Swift Language Grammar Error Handling
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Error Handling](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html) 부분[^Error-Handling]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Error Handling (에러 처리)

_에러 처리 (error handling)_ 는 프로그램의 에러 조건에 대해 응답하고 여기서 복구하는 과정을 말합니다. 스위프트는 실행 시간에 복구 가능한 에러를 던지고, 잡아내고, 전파하며, 조작하는 일급 지원을 제공합니다.

어떤 작업은 실행을 끝내거나 유용한 결과를 생성하는 것을 항상 보장하지 못할 수도 있습니다. '옵셔널 (optoinals)' 을 사용하면 값이 없음을 나타낼 순 있지만, 작업이 실패할 때, 실패한 원인이 무엇인지 이해하면, 코드에서 적절하게 응답할 수 있으므로 유용할 수 있습니다.

예를 들어, 디스크의 파일에 있는 자료를 읽고 처리하는 작업을 고려해 봅시다. 이 작업은 여러가지 이유로 실패할 수 있는데, 지정된 경로에 파일이 존재하지 않을 수도 있고, 그 파일에 대한 읽기 권한이 없을 수도 있고, 또는 그 파일이 호환되는 양식으로 '부호화' 되어 있지 않을 수도 있습니다. 이런 서로 다른 상황을 구별하는 것은 프로그램이 일부 에러를 해결할 수 있게 하고 직접 해결할 수 없다면 사용자와 통신하도록 할 수 있습니다.

> 스위프트에서의 에러 처리는 'Cocoa' 와 오브젝티브-C 언어에 있는 `NSError` 클래스를 사용하는 '에러 처리 패턴' 과 상호 호환됩니다. 이 클래스에 대한 더 자세한 내용은, [Handling Cocoa Errors in Swift (스위프트에서 Cocoa 에러 처리하기)](https://developer.apple.com/documentation/swift/cocoa_design_patterns/handling_cocoa_errors_in_swift) 를 참고하기 바랍니다.

### Representing and Throwing Errors (에러 나타내고 던지기)

스위프트에서, 에러는 `Error` 프로토콜을 준수하는 타입의 값으로 나타냅니다. 이 빈 프로토콜은 어떤 타입이 에러 처리에 사용될 수 있음을 지시합니다.

스위프트의 열거체는 서로 관계있는 에러 조건들을 그룹지어 모델링 하기에 특히 적합하며, '관련 값 (associated values)' 으로 에러의 본질에 대한 추가 정보를 전달할 수 있습니다. 예를 들어, 다음은 게임 내의 자동 판매기가 작동할 때의 에러 조건을 나타낼 수 있는 방법입니다:

```swift
enum VendingMachineError: Error {
  case invalidSelection
  case insufficientFunds(coinsNeeded: Int)
  case outOfStock
}
```

에러를 던지는 것은 예기치 않은 일이 발생해서 실행 흐름을 정상적으로 계속할 수 없음을 지시할 수 있게 해줍니다. `throw` 문을 사용하면 에러를 던질 수 있습니다. 예를 들어, 다음 코드는 자동 판매기에 동전 5개가 추가로 더 필요하다는 것을 알리기 위해 에러를 던집니다:

```swift
throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
```

### Handling Errors (에러 처리하기)

에러가 던져지면, 주변 코드에서 어떻게든 그 에러를 책임져야 합니다-예를 들어, 문제를 고치거나, 다른 접근 방법을 시도하거나, 아니면 사용자에게 실패를 알리는 것이 이에 해당합니다.

스위프트의 에러 처리 방법에는 총 네 가지가 있습니다. 에러를 함수에서 그 함수를 호출한 코드로 전파하거나, `do-catch` 문으로 처리할 수 있으며, 혹은 옵셔널 값으로 처리할 수도 있고, 아니면 에러가 발생하지 않을 거라고 '단언 (assert)' 할 수 있습니다. 각각의 접근 방법에 대해서는 아래 장에서 설명합니다.

함수가 에러를 던질 땐, 프로그램의 흐름이 바뀌므로, 코드에서 에러를 던질 수 있는 위치를 재빨리 식별할 수 있는 것이 중요합니다. 코드에서 이 위치를 식별하려면, `try` 키워드-또는 `try?` 나 `try!` 같은 변형-을 에러를 던질 수도 있는 함수, 메소드, 혹은 초기자를 호출하는 코드 앞에 써주면 됩니다. 이런 키워드에 대해서는 아래 장에서 설명하합니다.

> 스위프트의 '에러 처리' 는 `try`, `catch` 와 `throw` 키워드를 사용하는, 여타 다른 언어의 '예외 처리 (exception handling)' 와 비슷해 보입니다. 스위프트의 에러 처리가 오브젝티브-C 언어를 포함한-많은 여타 언어들의 '예외 처리' 와 다른 점은, 계산 비용이 많이 드는 과정인, '호출 스택 (call stack)' 을 풀지 않는다는 것입니다. 그로 인해, `throw` 문의 성능은 `return` 문에 필적합니다.

#### Propagating Errors Using Throwing Functions ('던지는 함수' 를 사용하여 에러 전파하기)

함수, 메소드, 또는 초기자가 에러를 던질 수 있음을 지시하려면, 함수 선언의 매개 변수 뒤에 `throws` 키워드를 써주면 됩니다. `throws` 로 표시된 함수를 _던지는 함수 (throwing function)_ 이라고 합니다. 함수가 반환 타입을 지정할 경우, `throws` 키워드를 '반환 화살표 (return arrow; `->`)' 앞에 써주면 됩니다.

```swift
func canThrowErrors() throws -> String

func cannotThrowErrors() -> String
```

'던지는 함수 (throwing function)' 는 안에서 던져진 에러를 자신을 호출한 영역으로 전파합니다.

> '던지는 함수' 만 에러를 전파할 수 있습니다. '던지지 않는 함수 (nonthrowing function)' 에서 던져진 에러는 어떤 것이라도 그 함수 내에서 처리해야 합니다.

아래 예제의, `VendingMachine` 클래스는 `vend(itemNamed:)` 메소드를 가지고 있는데, 이는 요청한 항목이 사용 불가능하거나, 재고가 없거나, 아니면 비용이 현재 예치된 금액을 초과할 경우 적절한 `VendingMachineError` 를 던지게 됩니다:

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

`vend(itemNamed:)` 메소드 구현은, 간식 구매를 하면서 '필수 조건' 이 만족되지 않으면, `guard` 문을 사용하여 메소드를 조기 종료하고 적절한 에러를 던집니다. `throw` 문은 프로그램 제어를 즉시 전달하기 때문에, 모든 '필수 조건' 을 만족할 때만 판매가 이뤄집니다.

`vend(itemNamed:)` 메소드는 던지는 에러 모두 전파하고 있기 때문에, 이 메소드를 호출하는 코드는 각자 에러를 처리해야 합니다-`do-catch` 문이나, `try?`, 또는 `try!` 을 사용해서든-아니면 이를 다시 전파해서든 말입니다. 예를 들어, 아래 예제에 있는 `buyFavoriteSnack(person:vendingMachine:)` 는 자신도 '던지는 함수' 이며, `vend(itemNamed:)` 메소드가 던지는 에러를 다시 위로 전파해서 `buyFavoriteSnack(person:vendingMachine:)` 함수를 호출하는 지점으로 보냅니다.

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

이 예제에 있는, `buyFavoriteSnack(person:vendingMachine:)` 함수는 주어진 사람이 가장 좋아하는 스낵을 찾은 다음 `vend(itemNamed:)` 메소드를 호출하여 이를 사려고 합니다. `vend(itemNamed:)` 메소드는 에러를 던질 수 있기 때문에, `try` 키워드를 앞에 붙여서 호출합니다.

'던지는 초기자 (throwing initializers)' 는 '던지는 함수' 와 같은 방법으로 에러를 전파할 수 있습니다. 예를 들어, 아래에 나타낸 `PurchasedSnack` 구조체의 초기자는 초기화 과정에서 '던지는 함수 (throwing function)' 를 호출하고, 에러를 마주치게 되면 이를 호출하는 쪽으로 전파하는 방식으로 처리합니다.

```swift
struct PurchasedSnack {
  let name: String
  init(name: String, vendingMachine: VendingMachine) throws {
    try vendingMachine.vend(itemNamed: name)
    self.name = name
  }
}
```

#### Handling Errors Using Do-Catch ('Do-Catch' 구문을 사용하여 에러 처리하기)

`do-catch` 문을 사용하면 코드 블럭을 실행하는 것으로 에러를 처리합니다. `do` 구절 내의 코드에서 에러를 던지면, 에러를 처리할 수 있는 것이 어떤 것인지를 결정하기 위해 해당하는 `catch` 구절을 찾게 됩니다.

`do-catch` 문의 일반적인 양식은 다음과 같습니다:

```
do {
  try expression
  statements
} catch pattern 1 {
  statements
} catch pattern 1 where condition {
  statements
} catch {
  statements
}
```

`catch` 뒤에 '유형 (pattern)' 을 작성하여 해당 구절이 처리할 수 있는 에러를 지시합니다. `catch` 구절에 '유형 (pattern)' 이 없으면, 이 구절은 모든 에러에 다 해당되며 이 때 에러는 `error` 라는 지역 상수 이름으로 연결됩니다. '해당하는 유형을 찾는 방법 (pattern matching)' 에 대한 더 자세한 내용은 [Patterns (유형)](https://docs.swift.org/swift-book/ReferenceManual/Patterns.html) 을 참고하기 바랍니다.

예를 들어, 다음 코드는 `VendingMachineError` 열거체의 세 가지 '경우 값 (cases)' 모두에 해당되도록 만들어졌습니다.

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

위 예제에서, `buyFavoriteSnack(person:vendingMachine:)` 함수는, 에러를 던질 수 있기 때문에, `try` 표현식을 써서 호출하고 있습니다. 에러를 던지면, 프로그램 실행은 즉시 `catch` 절로 전송되어, 전파를 계속하게 할지를 결정합니다. 해당하는 '유형 (pattern)' 이 없으면, 에러는 최종 `catch` 절이 잡아서 `error` 라는 지역 상수로 연결됩니다. 던져진 에러가 없으면, `do` 문 내의 나머지 구문이 실행됩니다.

`catch` 절에서 `do` 절 코드가 던질 가능성이 있는 모든 에러를 처리해야 하는 것은 아닙니다. `catch` 절 중 어느 것도 에러를 처리하지 않으면, 이 에러는 주변 영역으로 전파됩니다. 하지만, 전파된 에러는 반드시 _어떤 (some)_ 주변 영역이 됐든 처리해야 합니다. '던지지 않는 함수 (nonthrowing function)' 안이라면, 비 투사 함수에서 둘러싸는 do-catch 문은 오류를 처리해야합니다. 던지는 함수에서 둘러싸는 do-catch 문 또는 호출자가 오류를 처리해야합니다. 오류를 처리하지 않고 최상위 범위로 전파하면 런타임 오류가 발생합니다.

예를 들어, VendingMachineError가 아닌 오류가 호출 함수에 의해 대신 잡히도록 위 예제를 작성할 수 있습니다.

#### Converting Errors to Optional Values (에러를 옵셔널 값으로 변환하기)

#### Disabling Error Propagation (에러 전파 못하게 하기)

### Specifying Cleanup Actions (정리 작업 지정하기)
