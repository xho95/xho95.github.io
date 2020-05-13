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

어떤 작업은 완전한 실행이나 유용한 결과를 생성하는 것을 항상 보장하지는 못합니다. '옵셔널 (optoinals)' 을 사용하면 값이 없음은 나타낼 수 있지만, 작업이 실패할 때, 실패한 원인이 무엇인지 이해하면, 코드에서 적절하게 응답할 수 있으므로 유용할 수 있습니다.

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

#### Propagating Errors Using Throwing Functions (던지는 함수를 사용하여 에러 전파하기)

#### Handling Errors Using Do-Catch ('Do-Catch' 구문을 사용하여 에러 처리하기)

#### Converting Errors to Optional Values (에러를 옵셔널 값으로 변환하기)

#### Disabling Error Propagation (에러 전파 못하게 하기)

### Specifying Cleanup Actions (정리 작업 지정하기)
