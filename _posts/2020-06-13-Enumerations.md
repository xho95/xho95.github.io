---
layout: post
comments: true
title:  "Swift 5.7: Enumerations (열거체)"
date:   2020-06-13 10:00:00 +0900
categories: Swift Language Grammar Error Handling
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [Enumerations](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 부분[^Enumerations]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Enumerations (열거체)

_열거체 (enumerations)_ 는 관련된 값의 그룹에 공통 타입을 정의하여 그 값을 코드 안에서 타입-안전하게[^type-safe] 작업할 수 있게 합니다.

**C** 에 익숙하다면, **C** 열거체는 관련된 이름에 정수 값 집합을 할당하는 걸 알 겁니다. 스위프트 열거체는 훨씬 더 유연해서, 각각의 열거체 case 마다 값을 제공하지 않아도 됩니다. 각 열거체 case 마다 (_원시 (raw)_ 값이라는) 값을 제공할 경우, 값은 문자열이나, 문자, 또는 어떤 정수나 부동-소수점 타입이든 다 됩니다.

대안으로, 열거체 case 에 _어떤 (any)_ 타입의 결합 값을 지정하여 서로 다른 각각의 case 값과 나란히 저장할 수 있는데, 다른 언어에선 대부분 공용체[^unions] 나 가변체[^variants] 로 이렇게 합니다. 한 열거체 안에서 관련된 case 들의 공통 집합을 정의할 수 있는데, 제각각은 자신과 결합된 서로 다른 적절한 타입의 값 집합을 가집니다.

스위프트 열거체는 그 자체로 일급 타입입니다.[^first-class] 전통적으로 클래스에서만 지원하던 수많은 특징을 채택하는데, 계산 속성으로 현재 열거체 값에 추가 정보 제공하기, 인스턴스 메소드로 열거체가 나타내는 값과 관련된 기능 제공하기 같은 겁니다. 열거체는 초기자[^initializers] 를 정의하여 초기 case 값도 제공할 수 있으며; 확장[^extend] 하여 자신의 원본 구현 너머로 기능을 늘릴 수도 있고; 프로토콜을 준수하여 표준 기능을 제공할 수도 있습니다.

이런 더 많은 보유 능력에 대한 건, [Properties (속성)]({% post_url 2020-05-30-Properties %}) 과, [Methods (메소드)]({% post_url 2020-05-03-Methods %}), [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}), [Extensions (익스텐션; 확장)]({% post_url 2016-01-19-Extensions %}), 및 [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 장을 보기 바랍니다.

### Enumeration Syntax (열거체 구문)

열거체는 `enum` 키워드로 도입하며 자신의 전체 정의를 한 쌍의 중괄호 안에 둡니다:

```swift
enum SomeEnumeration {
  // 열거체 정의는 여기에 둠
}
```

나침반의 네 주요 방위에 대한 예제는 이렇습니다:

```swift
enum CompassPoint {
  case north
  case south
  case east
  case west
}
```

열거체 안에 정의한 (`north` 와, `south`, `east`, 및 `west` 같은) 값이 _열거체 case (enumeration cases)_ 입니다. `case` 키워드로 새로운 열거체 case 를 도입합니다.

> **C** 와 **오브젝티브-C** 같은 언어와 달리, 스위프트 열거체 case 는 기본적으로 정수 값을 설정하지 않습니다. 위의 `CompassPoint` 예제에서, `north` 와, `south`, `east`, 및 `west` 는 `0` 과, `1`, `2`, 및 `3` 과 같지 않습니다. 그 대신, 각각의 열거체 case 는 그 자체로 값이며, `CompassPoint` 라는 명시적으로 정의한 타입을 가집니다.

여러 case 를 한 줄로 나타내려면, 쉼표로 구분하면 됩니다:

```swift
enum Planet {
  case mercury, venus, earth, mars, jupiter, saturn uranus, neptune
}
```

각각의 열거체 정의는 새로운 타입을 정의합니다. 스위프트의 다른 타입 같이, 이들의 이름은 (`CompassPoint` 와 `Planet` 같이) 대문자로 시작합니다. 열거체 타입은 복수형 보단 단수형 이름이어야, 그 자체로-분명하게 읽힙니다[^plural-vs-singular]:

```swift
var directionToHead = CompassPoint.west
```

`directionToHead` 의 타입은 가능한 `CompassPoint` 값 하나로 초기화할 때 추론합니다. 일단 한 번 `directionToHead` 를 `CompassPoint` 로 선언하면, 다른 `CompassPoint` 값은 더 짧은 점 구문으로 설정할 수 있습니다:

```swift
directionToHead = .east
```

`directionToHead` 의 타입을 이미 알고 있어서, 값을 설정할 때 타입을 뺄 수 있습니다. 이는 타입을 명시한 열거체 값과 작업할 때 코드를 아주 읽기 쉽게 합니다.

### Matching Enumeration Values with a Switch Statement (switch 문으로 열거체 값 맞춰보기)

`switch` 문을 가지고 개별 열거체 값을 맞춰볼 수 있습니다:

```swift
directionToHead = .south
switch directionToHead {
case .north:
  print("Lots of planets have a north")
case .south:
  print("Watch out for penguins")
case .east:
  print("Where the sun rises")
case .west:
  print("Where the skies are blue")
}
// "Watch out for penguins" 를 인쇄함
```

이 코드는 다음처럼 이해할 수 있습니다:

“`directionToHead` 값을 검토합니다. `.north` 와 같은 경우, `"Lots of planets have a north"` 를 인쇄합니다. `.south` 와 같은 경우, `"Watch out for penguins"` 을 인쇄합니다."

...등을 계속합니다.

[Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에서 설명한 것처럼, 열거체 case 를 고려할 땐 `switch` 문을 반드시 다 써버려야 합니다. `.west` 이라는  `case` 를 생략하면, `CompassPoint` 의 완전한 case 목록을 검토한 게 아니기 때문에, 코드를 컴파일하지 않습니다. 다 써버리도록 요구하는 건 열거체 case 를 생략하는 사고가 없도록 보장합니다.

모든 열거채 case 마다 `case` 절을 제공하는 게 적절하지 않을 때, `default` case 절을 제공하면 명시적으로 알리지 않은 어떤 case 도 다룰 수 있습니다:

```swift
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
  print("Mostly harmless")
default:
  print("Not a safe place for humans")
}
// "Mostly harmless" 를 인쇄함
```

### Iterating over Enumeration Cases (열거체 case 들을 반복하기)

일부 열거체에선, 그 열거체의 '모든 case 를 집합체 (collection)' 로 가지는 게 유용합니다. 열거체 이름 뒤에 `: CaseIterable` 을 작성하면 이렇게 할 수 있습니다. 스위프트는 모든 case 의 집합체를 '열거체 타입의 `allCases` 속성' 으로 노출합니다. 다음은 예제입니다:

```swift
enum Beverage: CaseIterable {
  case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// "3 beverages available" 를 인쇄함
```

위 예제에선, `Beverage.allCases` 라고 작성하여 `Beverage` 열거체의 모든 case 를 담은 집합체에 접근합니다. `allCase` 는 다른 어떤 집합체인 것 같이 사용할 수 있습니다-집합체 원소가 열거체 타입의 인스턴스이므로, 이 경우엔 `Beverage` 값입니다. 위 예제는 case 가 얼마나 많은 지를 세며, 아래 예제는 `for` 반복문을 사용하여 모든 case 에 동작을 반복합니다.

```swift
for beverage in Beverage.allCases {
  print(beverage)
}
// coffee
// tea
// juice
```

위 예제에서 사용한 구문은 열거체가 [CaseIterable](https://developer.apple.com/documentation/swift/caseiterable) 프로토콜을 준수한다고 표시합니다. 프로토콜에 대한 정보는, [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 장을 보도록 합니다.

### Associated Values (결합 값)

이전 부분에 있는 예제는 열거체 case 가 그 자체로 (타입을 지정한) 정의 값이라는 걸 보여줍니다. 상수나 변수에 `Planet.earth` 를 설정할 수도, 이 값을 나중에 검사할 수도 있습니다. 하지만, 이 case 값과 나란하게 다른 타입의 값을 저장할 수 있는 게 유용할 때가 있습니다. 이런 추가 정보를 _결합 값 (associated value)_ 이라고 하며, 이는 코드에서 그 case 를 값으로 사용할 때마다 변합니다.

스위프트 열거체는 주어진 어떤 타입의 결합 값이든 저장할 수 있으며, 필요하다면 각각의 열거체의 case 마다 값 타입이 서로 다를 수도 있습니다. 이와 비슷한 열거체를 다른 프로그래밍 언어에서는 _차별화된 공용체 (discriminated unions)_, _꼬리표 단 공용체 (tagged unions)_, 또는 _가변체 (variants)_ 라고 합니다.[^variants]

예를 들어, 재고 추적 시스템이 서로 다른 두 가지 타입의 바코드로 제품을 추적할 필요가 있다고 가정해 봅시다. 일부 제품은, `0` 부터 `9` 까지의 숫자를 쓴, UPC 양식의 1-차원 바코드를 가지고 이름표를 답니다. 각각의 바코드에는 '한 자리 시스템 코드' 와, 그 뒤의 '다섯 자리 제조 회사 코드' 및 '다섯 자리 물품 코드' 가 있습니다. 그 뒤엔 코드를 올바로 스캔했는 지 증명하는 '한 자리 검사 코드' 를 붙입니다:

![1-d barcode](/assets/Swift/Swift-Programming-Language/Enumerations-1d-barcode.png)

다른 제품은, 어떤 ISO 8859-1 문자든 사용할 수 있고 문자열을 2,953 개의 문자만큼 부호화 (encode) 할 수 있는, QR 코드 양식의 2-차원 바코드를 가지고 이름표를 답니다:

![2-d barcode](/assets/Swift/Swift-Programming-Language/Enumerations-2d-barcode.png)

재고 추적 시스템이 'UPC 바코드는 네 정수를 가진 튜플로 저장' 하고, 'QR 코드 바코드는 임의 길이의 문자열로 저장' 하는 게 편리합니다.

스위프트에서, 어느 타입이든 다 되는 제품 바코드 열거체는 다음 같이 보일 지도 모릅니다:

```swift
enum Barcode {
  case upc(Int, Int, Int, Int)
  case qrCode(String)
}
```

이는 다음처럼 이해할 수 있습니다:

"(`Int`, `Int`, `Int`, `Int`) 타입 결합 값을 가진 `upc` 값, 또는 `String` 타입 결합 값을 가진 `qrCode` 값 중 어느 하나를 취할 수 있는, `Barcode` 라는 열거체 타입을 정의합니다."

이 정의는 어떤 `Int` 나 `String` 값도 실제로 제공하지 않습니다-그냥 `Barcode` 상수 및 변수가 `Barcode.upc` 나 `Barcode.qrCode` 와 같을 때 저장할 수 있는 결합 값의 _타입 (type)_ 만 정의합니다.

그러면 어느 타입을 사용하는 바코드든 새로 생성할 수 있습니다:

```swift
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
```

이 예제는 `productBarcode` 라는 새로운 변수를 생성하고 결합 값으로 `(8, 85909, 51226, 3)` 라는 튜플 값을 가진 `Barcode.upc` 을 할당합니다.

동일한 제품에 다른 타입의 바코드를 할당할 수 있습니다:

```swift
productBarcode = .qrCode( "ABCDEFGHIJKLMNOP")
```

이 순간, 원본 `Barcode.upc` 와 정수 값들을 새로운 `Barcode.qrCode` 와 문자열 값으로 교체합니다. `Barcode` 타입의 상수와 변수는 `.upc` 든 `.qrCode` 든 (자신의 결합 값과 함께) 저장할 수 있지만, 주어진 어떤 순간엔 하나만 저장할 수 있습니다.

[Matching Enumeration Values with a Switch Statement (switch 문으로 열거체 값 맞춰보기)](#matching-enumeration-values-with-a-switch-statement-switch-문으로-열거체-값-맞춰보기) 에 있는 예제와 비슷하게, switch 문을 사용하여 서로 다른 바코드 타입들을 검사할 수 있습니다. 하지만, 이번엔 switch 문에서 결합 값을 뽑아냅니다. `switch` 문 case 절 본문 안에서 사용할 (`let` 접두사의) 상수나 (`var` 접두사의) 변수로 각각의 결합 값을 뽑아냅니다:

```swift
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
  print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
  print("QR code: \(productCode).")
}
// "QR code: ABCDEFGHIJKLMNOP." 를 인쇄함
```

열거체 case 의 모든 결합 값을 상수로 뽑아내거나, 변수로 뽑아낼 경우, 간결함을 위해, case 이름 앞에 `var` 나 `let` 보조 설명 (annotation) 하나만 둘 수도 있습니다:

```swift
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
  print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
  print("QR code: \(productCode).")
}
// "QR code: ABCDEFGHIJKLMNOP." 를 인쇄함
```

### Raw Values (원시 값)

[Associated Values (결합 값)](#associated-values-결합-값) 에 있는 바코드 예제는 열거체 case 가 서로 다른 타입의 결합 값을 저장한다고 선언할 수 있는 방법을 보여줍니다. 결합 값의 대안으로써, (_원시 값 (raw values)_ 이라는), 모두 동일한 타입의, 기본 값을 가지고 열거체 case 를 미리 채울 수 있습니다.

다음은 원시 ASCII 값을 이름 붙인 열거체 case 와 나란하게 저장하는 예제입니다:

```swift
enum ASCIIControlCharacter: Character {
  case tab = "\t"
  case lineFeed = "\n"
  case carriageReturn = "\r"
}
```

여기선, `ASCIIControlCharacter` 라는 열거체의 원시 값을 `Character` 타입으로 정의하며, 좀 더 흔한 일부의 ASCII 제어 문자들로 설정합니다. `Character` 값은 [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) 에서 설명합니다.

원시 값은 문자열이나, 문자, 아니면 어떤 정수 또는 부동-소수점 수 타입일 수 있습니다. 각각의 원시 값은 자신의 열거체 선언 안에서 반드시 유일해야 합니다.

> 원시 값은 결합 값과 똑같지 _않습니다 (not)_. 원시 값은, 위의 ASCII 코드 세 개 같이, 코드에서 최초로 열거체를 선언할 때 미리 채울 값으로 설정합니다. 특별한 한 열거체 case 의 원시 값은 항상 똑같습니다. 결합 값은 열거체 case 중 하나를 기초로 새로운 상수나 변수를 생성할 때 설정하며, 그럴 때마다 서로 다를 수 있습니다.

#### Implicitly Assigned Raw Values (암시적으로 할당하는 원시 값)

정수나 문자열 원시 값을 저장한 열거체와 작업할 때는, 각 case 의 원시 값을 명시적으로 할당하지 않아도 됩니다. 안 할 땐, 스위프트가 자동으로 값을 할당합니다.

예를 들어, 원시 값으로 정수를 사용할 땐, 각 case 값이 이전 case 보다 암시적으로 하나 커집니다. 첫 번째 case 에 값을 설정하지 않으면, 그 값은 `0` 입니다.

아래 열거체는, 태양으로부터 각 행성의 순서를 나타내는 정수 원시 값을 갖도록, 앞선 `Planet` 열거체를 개량한 것입니다:

```swift
enum Planet: Int {
  case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
```

위 예제에서, `Planet.mercury` 는 `1` 이라는 명시적인 원시 값을 가지고, `Planet.venus` 는 `2` 라는 암시적인 원시 값을 가지며, 등등 그렇게 계속됩니다.

원시 값으로 문자열을 사용할 땐, 그 case 이름에 있는 문장이 각 case 의 암시적인 값입니다.

아래 열거체는, 각 방향의 이름을 나타내는 문자열 원시 값을 갖도록, 앞선 `CompassPoint` 열거체를 개량한 것입니다:

```swift
enum CompassPoint: String {
  case north, south, east, west
}
```

위 예제에서, `CompassPoint.south` 는 `"south"` 라는 암시적인 원시 값을 가지며, 등등 그렇게 계속됩니다.

열거체 case 의 원시 값엔 `rawValue` 속성으로 접근합니다:

```swift
let earthsOrder = Planet.earth.rawValue
// earthsOrder (지구의 순서) 는 3 임

let sunsetDirection = CompassPoint.west.rawValue
// sunsetDirection (해지는 방향) 은 "west (서쪽)" 임
```

#### Initializing from a Raw Value (원시 값으로 초기화하기)

원시-값 타입을 가진 열거체를 정의하면, 열거체가 '원시 값 타입의 값을 (`rawValue` 라는 매개 변수로) 취하고 열거체 case 나 `nil` 을 반환하는 초기자 (initializer)' 를 자동으로 받습니다. 이 초기자를 사용하면 새로운 열거체 인스턴스를 생성할 수 있습니다.

이 예제는 `7` 이라는 원시 값으부터 '천왕성 (Uranus)' 을 식별합니다:

```swift
let possiblePlanet = Planet(rawValue: 7)
// possiblePlanet 은 Planet? 타입이고 Planet.uranus 와 같음
```

하지만, 모든 `Int` 값이 일치하는 행성을 찾을 수 있는 건 아닙니다. 이 때문에, 원시 값 초기자는 항상 _옵셔널 (optional)_ 열거체 case 를 반환합니다. 위 예제에서, `possiblePlanet` 은 `Planet?` 타입, 또는 “옵셔널 (optional) `Planet`” 타입입니다.

> 원시 값 초기자는, 모든 원시 값이 열거체 case 를 반환하는 건 아니기 때문에, '실패 가능 (failable) 초기자' 입니다. 더 많은 정보는, [Failable Initializers (실패 가능 초기자)]({% post_url 2020-08-15-Declarations %}#failable-initializers-실패-가능-초기자)[^failable-initializer] 부분을 보도록 합니다.

`11` 번 째 위치의 행성을 찾으려고 하면, 원시 값 초기자가 반환할 옵셔널 `Planet` 값이 `nil` 일 겁니다:

```swift
let positionToFind = 11
if let somePlanet = Planet(rawValue: positionToFind) {
  switch somePlanet {
  case .earth:
    print("Mostly harmless")
  default:
    print("Not a safe place for humans")
  }
} else {
  print("There isn't a planet at position \(positionToFind)")
}
// "There isn't a planet at position 11" 를 인쇄함
```

이 예제는 '옵셔널 연결 (optional binding)' 을 사용하여 원시 값 `11` 을 가진 행성에 접근하려고 합니다. 구문 `if let somePlanet = Planet(rawValue : 11)` 은 옵셔널 `Planet` 을 생성하고, 옵셔널 `Planet` 값을 가져올 수 있다면 `somePlanet` 에 그 값을 설정합니다. 이 경우, `11` 번 째 위치의 행성을 가져오는 건 불가능하므로, 대신 `else` 분기를 실행합니다.

### Recursive Enumerations (재귀 열거체)

_재귀 열거체 (recursive enumeration)_ 는 '하나 이상의 열거체 case 가 결합 값으로 또 다른 열거체 인스턴스를 가지는 열거체' 입니다. 열거체 case 가 재귀적이라고 지시하려면, 필요한 '간접 계층 (layer of indirection)' 을 집어 넣어야 함을 컴파일러에게 알리고자, 그 앞에 `indirect`[^indirect] 를 작성합니다.

예를 들어, 다음은 단순한 산술 표현식을 저장하는 열거체입니다:

```swift
enum ArithmeticExpression {
  case number(Int)
  indirect case addition(ArithmeticExpression, ArithmeticExpression)
  indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
```

열거체 맨 앞에 `indirect` 를 작성하면 '결합 값을 가진 모든 열거체 case 가 간접 (indirection)'[^indirection] 이 되게 할 수 있습니다:

```swift
indirect enum ArithmeticExpression {
  case number(Int)
  case addition(ArithmeticExpression, ArithmeticExpression)
  case multiplication(ArithmeticExpression, ArithmeticExpression)
}
```

이 열거체는: 평범한 수, 두 표현식의 덧셈, 그리고 두 표현식의 곱셈이라는 세 가지 종류의 산술 표현식을 저장할 수 있습니다. `addition` 과 `multiplication` case 는 또 다시 산술 표현식인 결합 값을 가집니다-이러한 결합 값은 표현식을 중첩 가능하게 합니다. 예를 들어, 표현식 `(5 + 4) * 2` 는 곱셈 오른-쪽엔 수가 있고 곱셈 왼-쪽엔 또 다른 표현식이 있습니다. 자료를 중첩하기 때문에, 자료를 저장하는데 사용하는 열거체도 중첩을 지원할 필요가 있습니다-이는 열거체가 재귀적일 (recursive) 필요가 있다는 의미입니다. 아래 코드는 `(5 + 4) * 2` 를 생성하고 있는 재귀 열거체인 `ArithmeticExpression` 을 보여줍니다:

```swift
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
```

재귀 함수는 재귀 구조를 가진 자료와 직접적인 방식으로 작업합니다. 예를 들어, 다음은 산술 표현식을 평가하는 함수입니다:

```swift
func evaluate(_ expression: ArithmeticExpression) -> Int {
  switch expression {
  case let .number(value):
    return value
  case let .addition(left, right):
    return evaluate(left) + evaluate(right)
  case let .multiplication(left, right):
    return evaluate(left) * evaluate(right)
  }
}

print(evaluate(product))
// "18" 를 인쇄함
```

이 함수가 평범한 수를 평가하는 방식은 단순히 결합 값을 반환하는 것입니다. 덧셈이나 곱셈의 평가 방식은 '왼-쪽의 표현식을 평가하고, 오른-쪽의 표현식을 평가한 다음, 이를 더하거나 곱하는 것' 입니다.

### 다음 장

[Structures and Classes (구조체와 클래스) > ]({% post_url 2020-04-14-Structures-and-Classes %})

### 참고 자료

[^Enumerations]: 이 글에 대한 원문은 [Enumerations](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 에서 확인할 수 있습니다.

[^type-safe]: 스위프트에서 '타입-안전 (type-safe)' 하다는 건 스위프트가 제공하는 타입 추론 (type inference) 과 타입 검사 (type check) 기능을 사용할 수 있다는 걸 의미합니다. 이에 대한 더 자세한 정보는, [The Basic (기초)]({% post_url 2016-04-24-The-Basics %}) 장의 [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)]({% post_url 2016-04-24-The-Basics %}#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 부분을 참고하기 바랍니다.

[^first-class]: 프로그래밍에서 '일급 (first-class)' 이라는 건 객체 (class) 와 동-급으로 사용할 수 있다는 의미입니다. 예를 들어, 객체 처럼 인자로 전달할 수도 있고, 함수에서 반환할 수도 있으며, 다른 변수에 할당할 수도 있다면, '일급' 이라고 합니다. 일급에 대한 더 자세한 정보는, 위키피디아의 [First-class citizen](https://en.wikipedia.org/wiki/First-class_citizen) 과 [일급 객체](https://ko.wikipedia.org/wiki/일급_객체) 항목을 참고하기 바랍니다.

[^plural-vs-singular]: 열거체는 한 번에 하나의 case 값만 가집니다. 그러므로 열거체 이름이 단수형이어야 코드가 그 자체로-분명해집니다. 열거체 이름이 `CompassPoints` 처럼 복수형이 되면, 아래 예제는 `CompassPoints.west` 가 되는데, 이러면 동시에 여러 방향을 가지고 있다고 오해할 수 있습니다.

[^variants]: 여기 있는 세 가지 용어는 사실상 똑같은 개념입니다. 각각에 대한 더 자세한 정보는, 위키피디아의 [Tagged union](https://en.wikipedia.org/wiki/Tagged_union) 항목과 [Variant type](https://en.wikipedia.org/wiki/Variant_type) 항목을 보도록 합니다. 컴퓨터 공학 용어로는 '차별화된 공용체 (discriminated union)' 가 '꼬리표 단 공용체 (tagged union)' 이기 때문에, 이 둘은 항목 자체가 같습니다. 어쨌든, 본문 내용에 따르면 '스위프트 열거체의 결합 값' 은 'C 언어의 공용체 (union)' 와 유사한 개념이라고 이해할 수 있습니다.

[^failable-initializer]: 사실 해당 내용은 **Language Guide** 부분의 [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 에 있는 [Failable Initializers (실패 가능 초기자)]({% post_url 2016-01-23-Initialization %}#failable-initializers-실패-가능-초기자) 와 [Failable Initializers for Enumerations with Raw Values (원시 값이 있는 열거체의 실패 가능 초기자)]({% post_url 2016-01-23-Initialization %}#failable-initializers-for-enumerations-with-raw-values-원시-값이-있는-열거체의-실패-가능-초기자) 에서도 설명하고 있습니다.

[^indirect]: 여기서 '재귀적인 (recursive) 열거체' 를 만들기 위해 '`indirect` (간접)' 이라는 키워드를 사용하는데, 이는 메모리 주소 방식 중 하나인 'indirect addressing mode' 라는 말에서 유래한 것으로 추측됩니다. 'indirect addressing mode' 에 대한 보다 더 자세한 내용은 [Difference between Indirect and Immediate Addressing Modes](https://www.geeksforgeeks.org/difference-between-indirect-and-immediate-addressing-modes/?ref=rp) 항목을 보도록 합니다.

[^indirection]: 본문을 보면 '재귀 (recursive)' 라는 말과 '간접 (indirection)' 이라는 말을 거의 같은 개념으로 사용하는데, 이는 스위프트 열거체를 '재귀적으로 만드는 방식' 이 '메모리의 간접 주소 방식' 을 써서 구현하기 때문입니다.
