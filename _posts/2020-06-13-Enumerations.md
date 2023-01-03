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

대안으로, 열거체 case 에 _어떤 (any)_ 타입의 결합 값을 지정하여 서로 다른 각각의 case 값과 나란히 저장할 수 있는데, 다른 언어에선 대부분 공용체나 가변체로 이렇게 합니다.[^variants] 한 열거체 안에서 관련된 case 들의 공통 집합을 정의할 수 있는데, 제각각은 자신과 결합된 서로 다른 적절한 타입의 값 집합을 가집니다.

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

개별 열거체 값은 `switch` 문으로 맞춰볼 수 있습니다:

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

이 코드는 다음 처럼 읽을 수 있습니다:

“`directionToHead` 값을 고려합니다. 이게 `.north` 와 같은 경우면, `"Lots of planets have a north"` 를 인쇄합니다. `.south` 와 같은 경우면, `"Watch out for penguins"` 을 인쇄합니다."

...등으로 계속됩니다.

[Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에서 설명하듯, 열거체 case 를 고려할 땐 반드시 `switch` 문을 다 써버려야 합니다. `.west` 라는 `case` 를 생략하면, 이 코드의 컴파일이 안되는데, 이는 완성된 `CompassPoint` case 목록을 검토하지 않기 때문입니다. 다 써버리길 요구하는 건 열거체 case 를 생략하는 사고가 없도록 보장합니다.

모든 열거채 case 마다 `case` 를 제공하는 게 적절하지 않을 땐, `default` case 를 제공하면 명시하지 않은 어떤 case 도 다룰 수 있습니다:

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

### Iterating over Enumeration Cases (열거체 case 들 반복하기)

일부 열거체에선, 그 열거체의 모든 case 들을 집합체[^collection] 로 가지는 게 유용합니다. 열거체 이름 뒤에 `: CaseIterable` 을 쓰면 이렇게 할 수 있습니다. 스위프트는 모든 case 들의 집합체를 열거체 타입의 `allCases` 속성으로 드러냅니다. 예는 이렇습니다:

```swift
enum Beverage: CaseIterable {
  case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// "3 beverages available" 를 인쇄함
```

위 예제에선, `Beverage.allCases` 라고 써서 `Beverage` 열거체의 모든 case 를 담은 집합체에 접근합니다. 다른 어떤 집합체인 것 같이 `allCases` 를 쓸 수 있습니다-집합체의 원소는 열거체 타입의 인스턴스라서, 이 경우는 `Beverage` 값입니다. 위 예제는 얼마나 많은 case 가 있는지 세며, 아래 예제는 `for`-`in` 반복문으로 모든 case 를 한 번씩 반복합니다.

```swift
for beverage in Beverage.allCases {
  print(beverage)
}
// coffee
// tea
// juice
```

위 예제에서 쓴 구문은 열거체가 [CaseIterable](https://developer.apple.com/documentation/swift/caseiterable) 프로토콜을 준수한다고 표시합니다. 프로토콜에 대한 정보는, [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 장을 보기 바랍니다.

### Associated Values (결합 값)

이전 절의 예제는 어떻게 열거체 case 가 그 자체로 정의된 (타입 있는) 값인지를 보여줍니다. 상수나 변수를 `Planet.earth` 로 설정하고, 나중에 이 값을 검사할 수 있습니다. 하지만, 이러한 case 값과 나란히 다른 타입의 값을 저장하는게 유용할 때가 있습니다. 이 추가 정보는 _결합 값 (associated value)_ 이라고 하며, 매 번 그 case 를 코드에서 사용할 때마다 변합니다.

스위프트 열거체를 정의하면서 주어진 어떤 타입의 결합 값도 저장할 수 있으며, 필요하다면 각각의 열거체 case 마다 값의 타입이 다를 수도 있습니다. 이와 비슷한 열거체를 다른 프로그래밍 언어에선 _차별화된 공용체 (discriminated unions)_ 나, _꼬리표 단 공용체 (tagged unions)_, 또는 _가변체 (variants)_ 라고 합니다.[^unions-variants]

예를 들어, 재고 추적 시스템이 제품 추적을 하는데 서로 다른 두 가지 타입의 바코드가 필요하다고 가정해 봅시다. 일부 제품의 이름표는 **UPC** 양식의 1차원 바코드이며, `0` 부터 `9` 까지의 수를 사용합니다. 각각의 바코드엔 시스템 숫자, 뒤에 제조사 코드 숫자 다섯 개와 제품 코드 숫자 다섯 개가 있습니다. 그 뒤엔 검사 숫자가 있어서 코드 스캔이 올바로 됐는지 밝혀냅니다:

![1-d barcode](/assets/Swift/Swift-Programming-Language/Enumerations-1d-barcode.png)

다른 제품의 이름표는 **QR** 코드 양식의 2차원 바코드로, 이는 어떤 **ISO 8859-1** 문자든 쓸 수 있으며 2,953개 문자 길이만큼의 문자열을 인코딩할 수 있습니다:

![2-d barcode](/assets/Swift/Swift-Programming-Language/Enumerations-2d-barcode.png)

재고 추적 시스템이 **UPC** 바코드면 네 정수의 튜플로 저장하고, **QR** 코드 바코드면 임의 길이의 문자열로 저장하는게 편리합니다.

스위프트에서, 어느 쪽 타입의 제품 바코드든 정의하는 열거체는 이렇게 보일지 모릅니다:

```swift
enum Barcode {
  case upc(Int, Int, Int, Int)
  case qrCode(String)
}
```

이는 다음 처럼 읽을 수 있습니다:

"`Barcode` 라는 열거체 타입을 정의하는데, 이는 결합 값 타입이 (`Int`, `Int`, `Int`, `Int`) 인 `upc` 값, 또는 결합 값 타입이 `String` 인 `qrCode` 값 중 어느 쪽 하나를 가질 수 있습니다."

이 정의는 실제로 어떤 `Int` 나 `String` 값도 제공하지 않습니다-`Barcode` 상수와 변수가 `Barcode.upc` 나 `Barcode.qrCode` 일 때 저장할 수 있는 결합 값 _타입 (type)_ 을 그냥 정의만 합니다.

그러면 어느 쪽 타입으로든 새 바코드를 생성할 수 있습니다:

```swift
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
```

이 예제는 `productBarcode` 라는 새로운 변수를 생성해서 여기에 `Barcode.upc` 를 할당하는데 결합된 튜플 값은 `(8, 85909, 51226, 3)` 입니다.

똑같은 제품에 또 다른 타입의 바코드를 할당할 수도 있습니다:

```swift
productBarcode = .qrCode( "ABCDEFGHIJKLMNOP")
```

이 순간, 원본 `Barcode.upc` 와 정수 값이 새로운 `Barcode.qrCode` 와 문자열 값으로 교체됩니다. `Barcode` 타입의 상수와 변수는 `.upc` 나 `.qrCode` 중 어느 것이든 (결합 값과 함께) 저장할 수 있지만, 주어진 시간에 단 하나만 저장할 수 있습니다.

서로 다른 바코드 타입은 switch 문으로 검사할 수 있으며, 이는 [Matching Enumeration Values with a Switch Statement (switch 문으로 열거체 값 맞춰보기)](#matching-enumeration-values-with-a-switch-statement-switch-문으로-열거체-값-맞춰보기) 에 있는 예제와 비슷합니다. 하지만, 이번에는 switch 문에서 결합 값을 뽑아냅니다. 각각의 결합 값을 (`let` 접두사인) 상수나 (`var` 접두사인) 변수로 뽑아서 `switch` case 본문에서 사용합니다:

```swift
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
  print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
  print("QR code: \(productCode).")
}
// "QR code: ABCDEFGHIJKLMNOP." 를 인쇄함
```

열거체 case 의 모든 결합 값을 상수나, 변수로 뽑아낸다면, case 이름 앞에 단 하나의 `var` 나 `let` 보조 설명[^annotation] 만 둬서, 간결하게 할 수 있습니다:

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

[Associated Values (결합 값)](#associated-values-결합-값) 에 있는 바코드 예제는 열거체 case 를 어떻게 선언하면 서로 다른 타입의 결합 값을 저장할 수 있는지 보여줍니다. 결합 값의 대안으로, (_원시 값 (raw values)_ 이라는) 기본 값으로 열거체 case 를 미리 채울 수도 있는데, 이들은 모두 똑같은 타입입니다.

원시 ASCII 값과 이름 있는 열거체 case 를 나란히 저장하는 예제는 이렇습니다:

```swift
enum ASCIIControlCharacter: Character {
  case tab = "\t"
  case lineFeed = "\n"
  case carriageReturn = "\r"
}
```

여기서, `ASCIIControlCharacter` 라는 열거체의 원시 값은 `Character` 타입이라고 정의하며, 좀 더 흔한 일부 ASCII 제어 문자들로 설정합니다. `Character` 값은 [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) 에서 설명합니다.

원시 값은 문자열이나, 문자, 또는 어떠한 정수나 부동-소수점 수 타입일 수 있습니다. 각각의 원시 값은 반드시 자신의 열거체 선언 안에서 유일해야 합니다.

> 원시 값은 결합 값과 똑같지 _않습니다 (not)_. 원시 값은 코드에서 열거체를 최초로 선언할 때 설정하는 미리 채울 값으로, 위에 있는 세 ASCII 코드 같은 겁니다. 특별한 한 열거체 case 의 원시 값은 항상 똑같습니다. 결합 값은 한 열거체 case 를 기반으로 새로운 상수나 변수를 생성할 때 설정하는 것으로, 그럴 때마다 서로 다를 수 있습니다.

#### Implicitly Assigned Raw Values (암시적으로 할당되는 원시 값)

열거체가 정수 또는 문자열 원시 값을 저장할 때는, 각 case 의 원시 값 할당을 명시하지 않아도 됩니다. 그럴 땐, 스위프트가 값을 자동으로 할당합니다.

예를 들어, 원시 값이 정수일 땐, 각 case 의 암시적 값은 이전 case 보다 하나 큽니다. 첫 번째 case 에 설정 값이 없으면, 그 값은 `0` 입니다.

아래 열거체는 앞에 있던 `Planet` 열거체를 다듬어서, 태양으로부터 각 행성의 순서를 정수 원시 값으로 나타내도록 한 겁니다:

```swift
enum Planet: Int {
  case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
```

위 예제에서, `Planet.mercury` 에는 명시적 원시 값인 `1` 이 있고, `Planet.venus` 에는 암시적 원시 값인 `2` 가 있으며, 기타 등등 그렇게 계속됩니다.

문자열을 원시 값으로 쓸 땐, 각 case 의 암시적 값은 그 case 이름에 있는 글입니다.

아래 열거체는 앞에 있던 `CompassPoint` 열거체를 다듬어서, 문자열 원시 값으로 각 방향의 이름을 나타내도록 한 겁니다:

```swift
enum CompassPoint: String {
  case north, south, east, west
}
```

위 예제에서, `CompassPoint.south` 에는 암시적 원시 값인 `"south"` 가 있으며, 기타 등등 그렇게 계속됩니다.

열거체 case 의 원시 값은 `rawValue` 속성으로 접근합니다:

```swift
let earthsOrder = Planet.earth.rawValue
// earthsOrder (지구 순서) 는 3 임

let sunsetDirection = CompassPoint.west.rawValue
// sunsetDirection (해지는 방향) 은 "west (서쪽)" 임
```

#### Initializing from a Raw Value (원시 값으로 초기화하기)

열거체 정의에 원시-값 타입이 있으면, 열거체가 자동으로 초기자를 받게 되는데 이는 원시 값 타입의 값을 (`rawValue` 라는 매개 변수로) 입력 받고 열거체 case 나 `nil` 증 어느 하나를 반환합니다. 이 초기자로 열거체의 새로운 인스턴스를 생성하려고 할 수 있습니다.

다음 예제는 원시 값 `7` 로부터 천왕성 (Uranus) 의 정체를 파악합니다:

```swift
let possiblePlanet = Planet(rawValue: 7)
// possiblePlanet 의 타입은 Planet? 이고 Planet.uranus 와 같음
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

[^variants]: 공용체 (unions) 나 가변체 (variants) 는 뒤에 있는 [Associated Values (결합 값)](#associated-values-결합-값) 부분에서 설명합니다.

[^first-class]: 프로그래밍에서 '일급 (first-class)' 이라는 건 객체 (class) 와 동-급으로 사용할 수 있다는 의미입니다. 예를 들어, 객체 처럼 인자로 전달할 수도 있고, 함수에서 반환할 수도 있으며, 다른 변수에 할당할 수도 있다면, '일급' 이라고 합니다. 일급에 대한 더 자세한 정보는, 위키피디아의 [First-class citizen](https://en.wikipedia.org/wiki/First-class_citizen) 과 [일급 객체](https://ko.wikipedia.org/wiki/일급_객체) 항목을 참고하기 바랍니다.

[^plural-vs-singular]: 열거체는 한 번에 하나의 case 값만 가집니다. 그러므로 열거체 이름이 단수형이어야 코드가 그 자체로-분명해집니다. 열거체 이름이 `CompassPoints` 처럼 복수형이 되면, 아래 예제는 `CompassPoints.west` 가 되는데, 이러면 동시에 여러 방향을 가지고 있다고 오해할 수 있습니다.

[^unions-variants]: 여기 있는 세 가지 용어는 사실상 똑같은 개념입니다. 각각에 대한 더 자세한 정보는, 위키피디아의 [Tagged union](https://en.wikipedia.org/wiki/Tagged_union) 항목과 [Variant type](https://en.wikipedia.org/wiki/Variant_type) 항목을 참고하기 바랍니다. 컴퓨터 공학 용어에선 '차별화된 공용체 (discriminated union)' 가 '꼬리표 단 공용체 (tagged union)' 이기 때문에, 위키피디아에서도 이 둘의 항목이 아예 같습니다. 어쨌든, 본문에 따르면 스위프트 열거체에서의 결합 값은 **C** 언어에서의 공용체 (union) 와 유사한 개념이라고 볼 수 있습니다.

[^annotation]: '보조 설명 (annotation)' 에 대한 더 자세한 설명은 [Type Annotations (타입 보조 설명)]({% post_url 2016-04-24-The-Basics %}#type-annotations-타입-보조-설명) 부분을 참고하기 바랍니다.

[^failable-initializer]: 사실 해당 내용은 **Language Guide** 부분의 [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 에 있는 [Failable Initializers (실패 가능 초기자)]({% post_url 2016-01-23-Initialization %}#failable-initializers-실패-가능-초기자) 와 [Failable Initializers for Enumerations with Raw Values (원시 값이 있는 열거체의 실패 가능 초기자)]({% post_url 2016-01-23-Initialization %}#failable-initializers-for-enumerations-with-raw-values-원시-값이-있는-열거체의-실패-가능-초기자) 에서도 설명하고 있습니다.

[^indirect]: 여기서 '재귀적인 (recursive) 열거체' 를 만들기 위해 '`indirect` (간접)' 이라는 키워드를 사용하는데, 이는 메모리 주소 방식 중 하나인 'indirect addressing mode' 라는 말에서 유래한 것으로 추측됩니다. 'indirect addressing mode' 에 대한 보다 더 자세한 내용은 [Difference between Indirect and Immediate Addressing Modes](https://www.geeksforgeeks.org/difference-between-indirect-and-immediate-addressing-modes/?ref=rp) 항목을 보도록 합니다.

[^indirection]: 본문을 보면 '재귀 (recursive)' 라는 말과 '간접 (indirection)' 이라는 말을 거의 같은 개념으로 사용하는데, 이는 스위프트 열거체를 '재귀적으로 만드는 방식' 이 '메모리의 간접 주소 방식' 을 써서 구현하기 때문입니다.
