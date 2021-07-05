---
layout: post
comments: true
title:  "Swift 5.5: Enumerations (열거체)"
date:   2020-06-13 10:00:00 +0900
categories: Swift Language Grammar Error Handling
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Enumerations](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 부분[^Enumerations]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Enumerations (열거체)

_열거체 (enumerations)_ 는 관련된 값의 그룹에 '공통 타입' 을 정의하여 이 값들을 코드에서 '타입-안전한 (type-safe)'[^type-safe] 방식으로 작업할 수 있게 해줍니다.

C 에 익숙하다면, C 열거체는 관련된 이름에 일련의 정수 값을 할당한다는 것을 알고 있을 겁니다. 스위프트의 열거체는 훨씬 더 유연하며, 열거체의 각 'case 값' 에 값을 제공할 필요가 없습니다. 만약 열거체의 각 'case 값' 에 (_원시 값 (raw value)_ 이라는) 값을 제공할 경우, 이 값은 '문자열 (string)' 이나, '문자 (character)', 또는 '정수 (integer)' 나 '부동-소수점 (float-point)' 등 어떤 타입의 값이든 될 수 있습니다.

또 다른 방법으로, 열거체의 'case 값' 은 서로 다른 각 'case 값' 에 나란히 저장되는, 다른 언어의 '공용체 (unions)' 나 '가변체 (variants)' 와 거의 같은, '결합 값 (associated values)' 을 _어떤 (any)_ 타입이든 지정할 수 있습니다. 관련된 'case 값' 들의 공통 집합은, 저마다 이와 결합된 적절한 타입의 서로 다른 값 집합을 가진, 하나의 열거체로 정의할 수 있습니다.

스위프트의 열거체는 그 자체로 '일급 (first-class) 타입'[^first-class] 입니다. 이는, 열거체의 현재 값에 대한 추가적인 정보를 제공하는 '계산 속성 (computed properties)' 과, 열거체가 표현하는 값과 관련된 기능을 제공하는 '인스턴스 메소드' 같이, 전통적으로 클래스에서만 지원하던 많은 특징들을 채택하고 있습니다. 열거체는 '초기 case 값' 을 제공하기 위해 '초기자 (initializers)' 도 정의할 수 있고; 원래의 구현 너머로 기능을 확대하기 위해 확장될 수도 있으며; 표준 기능을 제공하기 위해 프로토콜을 준수할 수도 있습니다.

이 '보유 능력 (capabilities)' 들에 대한 더 많은 내용은, [Properties (속성)]({% post_url 2020-05-30-Properties %}), [Methods (메소드)]({% post_url 2020-05-03-Methods %}), [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}), [Extensions (익스텐션; 확장)]({% post_url 2016-01-19-Extensions %}), 그리고 [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 을 참고하기 바랍니다.

### Enumeration Syntax (열거체 구문)

열거체는 `enum` 키워드로 도입하며 그의 전체 정의는 중괄호 쌍 안에 둡니다:

```swift
enum SomeEnumeration {
  // 열거체 정의는 여기에 둡니다.
}
```

다음은 '나침반' 의 네 주요 '방위 (points)' 에 대한 예제입니다:

```swift
enum CompassPoint {
  case north
  case south
  case east
  case west
}
```

열거체에서 정의한 (`north`, `south`, `east`, 그리고 `west` 같은) 값들은 _열거체 case 값 (enumeration cases)_ 입니다.[^cases] 새로운 '열거체 case 값' 을 도입하려면 `case` 키워드를 사용합니다.

> 스위프트의 '열거체 case 값' 은, 'C' 와 ''오브젝티브-C' 같은 언어와는 달리, 기본적으로 정수 값으로 설정되지 않습니다. 위의 `CompassPoint` 예제에 있는, `north`, `south`, `east`, 및 `west` 는 `0`, `1`, `2`, 및 `3` 과 암시적으로 같아 지지 않습니다. 그 대신, 서로 다른 '열거체 case 값' 은 그 자체로, `CompassPoint` 라는 명시적으로 정의된 타입을 가진, '값 (values)' 입니다.

'다중 (multiple) case 값' 은, 쉼표로 구분하여, 한 줄로 나타낼 수 있습니다:

```swift
enum Planet {
case mercury, venus, earth, mars, jupiter, saturn uranus, neptune
}
```

각각의 열거체 정의는 새로운 타입을 정의합니다. 스위프트에 있는 다른 타입들 같이, (`CompassPoint` 와 `Planet` 같은) 그 이름은 대문자로 시작합니다. 열거체 타입은, 자명하게 이해되도록, '복수형 (plural)' 보다는 '단수형 (singular) 이름' 을 부여합니다[^plural-vs-singular]:

```swift
var directionToHead = CompassPoint.west
```

`directionToHead` 의 타입은 이를 가능한 `CompassPoint` 값들 중 하나로 초기화할 때 추론됩니다. `directionToHead` 를 `CompassPoint` 로 한 번 선언하고 나면, '줄인 점 구문 (shorter dot syntax)' 을 사용하여 이를 다른 `CompassPoint` 값으로 설정할 수 있습니다:

```swift
directionToHead = .east
```

`directionToHead` 의 타입은 이미 알고 있으므로, 값을 설정할 때 타입을 뺄 수 있습니다. 이는 타입을 명시적으로 지정한 열거체의 값과 작업할 때 가독성 높은 코드를 만들어 줍니다.

### Matching Enumeration Values with a Switch Statement ('열거체 값' 과 'switch 문' 맞춰보기)

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
// "Watch out for penguins" 를 인쇄합니다.
```

이 코드는 다음 처럼 이해할 수 있습니다:

“`directionToHead` 의 값을 검토합니다. `.north` 와 같은 경우, `"Lots of planets have a north"` 를 인쇄합니다. `.south` 와 같은 경우, `"Watch out for penguins"` 을 인쇄합니다."

...이를 계속합니다.

[Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에서 설명한 것처럼, `switch` 문은 '열거체 case 값' 을 검토할 때 반드시 '빠짐없이 철저 (exhaustive)' 해야 합니다. 만약 `.west` 에 대한 '`case` 절' 을 생략하면, '`CompassPoint` case 값' 의 완료된 목록을 검토하지 않기 때문에, 코드를 컴파일하지 않습니다. '빠짐없이 철처함' 을 요구하는 것은 예기치 않게 '열거체 case 값' 을 생략하지 않도록 보장합니다.

모든 '열거채 case 값' 에 '`case` 절' 를 제공하는 것이 적절하지 않을 때는, 명시적으로 알리지 않은 어떤 'case 값' 도 다룰 수 있는 '`default` case 절' 을 제공할 수 있습니다:

```swift
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
  print("Mostly harmless")
default:
  print("Not a safe place for humans")
}
// "Mostly harmless" 를 인쇄합니다.
```

### Iterating over Enumeration Cases (열거체 case 값들에 동작 반복시키기)

어떤 열거체에서는, 해당 열거체의 모든 'case 값' 에 대한 '집합체 (collection)' 를 가지는 것이 유용합니다. 이렇게 하려면 열거체 이름 뒤에 `: CaseIterable` 을 작성합니다. 스위프트는 열거체 타입의 `allCases` 속성으로 모든 'case 값' 집합체를 드러냅니다. 다음은 예제입니다:

```swift
enum Beverage: CaseIterable {
case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// "3 beverages available" 를 인쇄합니다.
```

위 예제는, `Beverage` 열거체의 모든 'case 값' 을 담은 '집합체' 에 접근하기 위해 `Beverage.allCases` 를 작성합니다. `allCase` 는 다른 집합체 처럼 똑같이 사용할 수 있습니다-집합체의 원소는 열거체 타입의 인스턴스이므로, 이 경우는 `Beverage` 값입니다. 위 예제는 'case 값' 이 얼마나 있는지를 세며, 아래 예제는 모든 'case 값' 에 동작을 반복시키기 위해 `for` 반복문을 사용합니다.

```swift
for beverage in Beverage.allCases {
  print(beverage)
}
// coffee
// tea
// juice
```

위 예제에서 사용한 구문 표현은 열거체가 [CaseIterable](https://developer.apple.com/documentation/swift/caseiterable) 프로토콜을 준수하는 것으로 표시합니다. 프로토콜에 대한 정보는, [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 을 참고하기 바랍니다.

### Associated Values (결합 값)

이전 부분에 있는 예제는 열거체의 'case 값' 이 그 자체로 (타입을 가지고) 정의된 값이 되는 방법을 보여줍니다. 상수나 변수를 `Planet.earth` 로 설정하고, 나중에 이 값을 검사할 수 있습니다. 하지만, 이 'case 값' 들과 나란히 다른 타입의 값을 저장할 수 있다면 유용할 때가 있습니다. 이런 추가적인 정보를 _결합 값 (associated value)_ 이라고 하며, 이는 매 번 해당 'case 값' 을 코드에서 값으로 사용할 때마다 달라집니다.

스위프트 열거체는 어떤 타입의 '결합 값' 이든 저장하라고 정의할 수 있으며, 필요하면 값 타입이 열거체의 각 'case 값' 마다 서로 달라도 됩니다. 이와 유사한 열거체를 다른 프로그래밍 언어에서는 _차별화된 공용체 (discriminated unions)_, _꼬리표 단 공용체 (tagged unions)_, 또는 _가변체 (variants)_ 라고 합니다.[^variants]

예를 들어, '재고 추적 시스템' 이 서로 다른 두 타입의 바코드로 물품을 추적할 필요가 있다고 가정합니다. 어떤 물품은, `0` 에서 `9` 까지의 숫자를 사용하는, UPC 양식의 1-차원 바코드로 이름표를 붙입니다. 각 바코드는 한 자리 수의 '시스템 코드' 뒤에, 다섯 자리의 '제조회사 코드' 와 다섯 자리의 '물품 코드' 를 가집니다. 그 뒤에는 코드를 올바르게 '스캔 (scan)' 했는지를 증명하기 위한 '검사 자리' 가 있습니다:

![1-d barcode](/assets/Swift/Swift-Programming-Language/Enumerations-1d-barcode.png)

다른 제품은, 어떤 'ISO 8859-1' 문자도 사용할 수 있고 최대 '2,953' 개 길이의 문자열을 '부호화 (encoding)' 할 수 있는, QR 코드 양식의 2-차원 바코드로 이름표를 붙입니다:

![2-d barcode](/assets/Swift/Swift-Programming-Language/Enumerations-2d-barcode.png)

UPC 바코드는 네 정수의 '튜플' 로 저장하고, QR 코드 바코드는 임의 길이 문자열로 저장하는 것이 '재고 추적 시스템' 에게 편리합니다.

스위프트에서, 어느 타입이든 다 되는 '물품 바코드' 를 정의한 열거체는 다음 같이 보일 수도 있습니다:

```swift
enum Barcode {
  case upc(Int, Int, Int, Int)
  case qrCode(String)
}
```

이는 다음처럼 이해할 수 있습니다:

"결합 값이 (`Int`, `Int`, `Int`, `Int`) 타입인 `upc` 값, 또는 결합 값이 `String` 타입인 `qrCode` 값을 취할 수 있는 `Barcode` 라는 열거체 타입을 정의합니다."

이 정의는 실제로 어떤 `Int` 나 `String` 값을 제공하지 않습니다-단지 `Barcode.upc` 나 `Barcode.qrCode` 일 때 `Barcode` 상수와 변수가 저장할 수 있는 '결합 값' 의 _타입 (type)_ 만을 정의합니다.

그러면 어느 타입을 사용해도 새로운 바코드를 생성할 수 있습니다:

```swift
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
```

이 예제는 `productBarcode` 라는 새로운 변수를 생성한 다음 `(8, 85909, 51226, 3)` 라는 튜플 '결합 값' 을 가진 `Barcode.upc` 값을 할당합니다.

똑같은 물품에 다른 타입의 바코드를 할당할 수 있습니다:

```swift
productBarcode = .qrCode( "ABCDEFGHIJKLMNOP")
```

이 순간, 원래의 `Barcode.upc` 와 정수 값들이 새로운 `Barcode.qrCode` 와 문자열 값으로 대체됩니다. `Barcode` 타입의 상수와 변수는 `.upc` 이든 `.qrCode` 이든 (결합 값과 같이) 저장할 수 있지만, 주어진 순간에 단 한 가지만을 저장할 수 있습니다.

서로 다른 바코드 타입은, [Matching Enumeration Values with a Switch Statement ('열거체 값' 과 'switch 문' 맞춰보기)](#matching-enumeration-values-with-a-switch-statement-열거체-값-과-switch-문-맞춰보기) 의 예제와 비슷하게, 'switch 문' 으로 검사할 수 있습니다. 하지만, 이번에는 'switch 문' 에서 '결합 값' 을 뽑아냅니다. 각 '결합 값' 은 '`switch` 문의 case 절' 본문에서 사용하려고 (`let` 접두사를 가진) 상수 또는 (`var` 접두사를 가진) 변수로써 뽑아냅니다:

```swift
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
  print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
  print("QR code: \(productCode).")
}
// "QR code: ABCDEFGHIJKLMNOP." 를 인쇄합니다.
```

'열거체 case 값' 의 '결합 값' 모두를 상수로 뽑아내거나, 변수로 뽑아내려면, 간결하게, 'case 값' 이름 앞에 단일 `var` 또는 `let` '보조 설명 (annotation)' 을 붙일 수 있습니다:

```swift
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
  print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
  print("QR code: \(productCode).")
}
// "QR code: ABCDEFGHIJKLMNOP." 를 인쇄합니다.
```

### Raw Values (원시 값)

[Associated Values (결합 값)](#associated-values-결합-값) 에 있는 바코드 예제는 열거체의 'case 값' 이 서로 다른 타입의 '결합 값' 을 저장한다고 선언할 수 있는 방법을 보여줍니다. '결합 값' 에 대한 대안으로써, '열거체 case 값' 은, (_원시 값 (raw values)_ 이라는),  모두 같은 타입인, '기본 값' 으로 미리 채울 수 있습니다.

다음은 이름 붙인 '열거체 case 값' 에 나란하게 '원시 ASCII 값' 을 저장하는 예제입니다:

```swift
enum ASCIIControlCharacter: Character {
  case tab = "\t"
  case lineFeed = "\n"
  case carriageReturn = "\r"
}
```

여기서, `ASCIIControlCharacter` 라는 열거체에 대한 '원시 값' 은 `Character` 타입으로 정의되었으며, 좀 더 공통적인 ASCII 제어 문자로 설정됩니다. `Character` 값은 [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) 에서 설명합니다.

'원시 값' 은 '문자열 (strings)', '문자 (characters)', 또는 어떤 '정수 (integer)' 나 '부동-소수점(floating-point) 수' 타입이든 될 수 있습니다. 각각의 원시 값은 '열거체 선언' 내에서 반드시 유일해야 합니다.

> '원시 값' 은 '결합 값' 과 같은 것이 _아닙니다 (not)_. '원시 값' 은, 위의 세 ASCII 코드와 같이, 코드에서 열거체를 맨 처음 선언할 때 미리 채워지는 값으로 설정됩니다. 특정 '열거체 case 값' 에 대한 '원시 값' 은 항상 같습니다. '결합 값' 은 열거체의 'case 값' 중 하나에 기초하여 새로운 상수나 변수를 생성할 때 설정되먀, 그럴 때마다 서로 다를 수 있습니다.

#### Implicitly Assigned Raw Values (암시적으로 할당되는 원시 값)

정수나 문자열 원시 값을 저장하는 열거체와 작업할 때, 각 'case 값' 에 대한 '원시 값' 을 명시적으로 할당할 필요는 없습니다. 안할 때는, 스위프트가 값을 자동으로 할당합니다.

예를 들어, 정수를 원시 값으로 사용할 때, 각 'case 값' 에 대한 암시적인 값은 '이전 case 값' 보다 하나 큰 값입니다. 첫 번째 'case 값' 에 설정된 값이 없는 경우, 값은 `0` 이 됩니다.

아래의 열거체는, 각 행성을 태양 순으로 표현하는 정수 원시 값을 갖도록, 앞에 있던 `Planet` 열거체를 개량한 것입니다:

```swift
enum Planet: Int {
  case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
```

위 예제에서, `Planet.mercury` 는 명시적인 원시 값인 `1` 을 가지고, `Planet.venus` 는 암시적인 원시 값인 `2` 를 가지며, 이렇게 계속됩니다.

문자열을 원시 값으로 사용할 때, 각 'case 값' 에 대한 암시적인 값은 해당 'case 값' 의 이름에 쓰인 글자입니다.

아래의 열거체는, 각 방향의 이름을 표현하는 문자열 원시 값을 갖도록, 앞에 있던 `CompassPoint` 열거체를 개량한 것입니다:

```swift
enum CompassPoint: String {
  case north, south, east, west
}
```

위 예제에서, `CompassPoint.south` 는 암시적인 원시 값 `"south"` 를 가지며, 이렇게 계속됩니다.

'열거체 case 의 원시 값' 은 `rawValue` 속성으로 접근합니다:

```swift
let earthsOrder = Planet.earth.rawValue
// earthsOrder (지구 순서) 는 3 입니다.

let sunsetDirection = CompassPoint.west.rawValue
// sunsetDirection (해지는 방향) 은 "west (서쪽)" 입니다.
```

#### Initializing from a Raw Value (원시 값으로 초기화하기)

원시-값 타입을 가진 열거체를 정의할 경우, 열거체는 (`rawValue` 라는 매개 변수로써) 원시 값 타입의 값을 취해서 '열거체 case 값' 또는 `nil` 을 반환하는 '초기자 (initializers)' 를 자동으로 받습니다. 이 '초기자' 는 열거체의 새로운 인스턴스를 생성할 때 사용할 수 있습니다.

다음 예제는 `7` 이라는 '원시 값' 으로 '천왕성 (Uranus)' 임을 식별합니다:

```swift
let possiblePlanet = Planet(rawValue: 7)
// possiblePlanet 은 타입이 Planet? 이고 값은 Planet.uranus 입니다.
```

하지만, 가능한 모든 `Int` 값마다 일치하는 행성을 찾을 수 있는 것은 아닙니다. 이 때문에, '원시 값 초기자 (raw value initializer)' 는 항상 _옵셔널 (optional)_ '열거체 case 값' 을 반환합니다. 위 예제에서, `possiblePlanet` 는 `Planet?` 타입, 또는 “옵셔널 (optional) `Planet`” 타입입니다.

> '원시 값 초기자' 는 '실패 가능 (failable) 초기자' 인데, 모든 '원시 값' 마다 '열거체 case 값' 을 반환하는 것은 아니기 때문입니다. 더 많은 정보는, [Failable Initializers (실패 가능 초기자)]({% post_url 2020-08-15-Declarations %}#failable-initializers-실패-가능-초기자)[^failable-initializer] 를 참고하기 바랍니다.

`11` 번 째 위치의 행성을 찾으려고 하면, '원시 값 초기자' 가 반환하는 '옵셔널 `Planet`' 값은 `nil` 일 것입니다:

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
// "There isn't a planet at position 11" 를 인쇄합니다.
```

이 예제는 원시 값이 `11` 인 행성에 접근하기 위해 '옵셔널 연결 (optional binding)' 을 사용합니다. `if let somePlanet = Planet(rawValue : 11)` 은 '옵셔널 `Planet`' 을 생성하고, 가져올 수 있었다면 이 `somePlanet` 에 해당 '옵셔널 `Planet`' 의 값을 설정합니다. 이 경우, `11` 번 째 위치의 행성을 가져오는 것이 불가능하므로, 그 대신 `else` 분기를 실행합니다.

### Recursive Enumerations (재귀적인 열거체)

_재귀적인 열거체 (recursive enumeration)_ 는 또 다른 열거체의 인스턴스를 하나 이상의 '열거체 case 값' 에 대한 '결합 값' 으로 가지는 열거체입니다. '열거체 case 값' 은 그 앞에 `indirect`[^indirect] 를 작성하여 '재귀적' 임을 지시하는데, 이는 필요한 '간접 계층 (layer of indirection)' 을 집어 넣을 것을 컴파일러에게 알립니다.

예를 들어, 다음은 간단한 '산술 (arithmetic) 표현식' 을 저장하는 열거체입니다:

```swift
enum ArithmeticExpression {
  case number(Int)
  indirect case addition(ArithmeticExpression, ArithmeticExpression)
  indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
```

'결합 값' 을 가진 모든 '열거체 case 값' 이 '간접 (indirection)'[^indirection] 일 수 있도록 열거체 맨 앞에 `indirect` 를 작성할 수도 있습니다:

```swift
indirect enum ArithmeticExpression {
  case number(Int)
  case addition(ArithmeticExpression, ArithmeticExpression)
  case multiplication(ArithmeticExpression, ArithmeticExpression)
}
```

이 열거체는 세 가지 종류의 '산술 표현식' 을 저장할 수 있는데: 평범한 수, 두 표현식의 덧셈, 그리고 두 표현식의 곱셈입니다. `addition` 과 `multiplication` 'case 값' 은 또 다시 '산술 표현식' 을 '결합 값' 으로 가집니다-이 '결합 값' 들은 표현식을 '중첩' 가능하게 만듭니다. 예를 들어, 표현식 `(5 + 4) * 2` 는 곱셈 오른-쪽엔 수를 가지고 곱셈 왼-쪽엔 또 다른 표현식을 가집니다. '자료 (data)' 가 중첩되어 있기 때문에, 자료를 저장하기 위해 사용되는 열거체도 중첩을 지원할 필요가 있습니다-이는 열거체가 '재귀적 (recursive)' 일 필요가 있다는 의미입니다. 아래 코드는 `(5 + 4) * 2` 를 위해 생성되는 재귀적인 열거체인 `ArithmeticExpression` 을 보여줍니다:

```swift
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
```

'재귀 함수 (recursive function)' 는 재귀 구조를 가진 자료와 작업하기 위한 직접적인 방법입니다. 예를 들어, 다음은 '산술 표현식' 을 평가하는 함수입니다:

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
// "18" 를 인쇄합니다.
```

이 함수는 '평범한 수' 는 단순히 그 '결합 값' 을 반환함으로써 평가합니다. 덧셈과 곱셈은 왼-쪽의 표현식을 평가하고, 오른-쪽의 표현식을 평가한 다음, 이를 더하거나 곱함으로써 평가합니다.

### 다음 장

[Structures and Classes (구조체와 클래스) > ]({% post_url 2020-04-14-Structures-and-Classes %})

### 참고 자료

[^Enumerations]: 이 글에 대한 원문은 [Enumerations](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^type-safe]: 여기서 '타입-안전한 (type-safe) 방식' 은 스위프트가 기본적으로 제공하는 '타입 추론 (type inference)' 과 '타입 검사 (type check)' 기능을 사용할 수 있음을 의미합니다. 이에 대한 더 자세한 정보는 [The Basic (기초)]({% post_url 2016-04-24-The-Basics %}) 장의 [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)]({% post_url 2016-04-24-The-Basics %}#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 부분을 참고하기 바랍니다.

[^first-class]: 프로그래밍에서 '일급 (first-class)' 이라는 말은 특정 대상을 '객체' 와 동급으로 사용할 수 있다는 것을 의미합니다. 예를 들어 '객체' 처럼 인자로 전달할 수도 있고, 함수에서 반환할 수 있으며, 다른 변수 등에 할당할 수도 있는 대상이 있다면 이 대상을 '일급 (first-class)' 이라고 합니다. 이에 대한 더 자세한 정보는 위키피디아의 [First-class citizen](https://en.wikipedia.org/wiki/First-class_citizen) 항목과 [일급 객체](https://ko.wikipedia.org/wiki/일급_객체) 항목을 참고하기 바랍니다.

[^variants]: 사실상, 이 세가지 용어는 같은 것입니다. 각각에 대한 더 자세한 정보는 위키피디아의 [Tagged union](https://en.wikipedia.org/wiki/Tagged_union) 항목과 [Variant type](https://en.wikipedia.org/wiki/Variant_type) 항목을 참고하기 바랍니다. 참고로 컴퓨터 공학에서는 '차별화된 공용체 (discriminated union)' 가 '꼬리표 단 공용체 (tagged union)' 을 의미하기 때문에 이 둘은 서로 항목이 나뉘지도 않았습니다.

[^failable-initializer]: 사실 해당 내용은 **Language Guide** 부분의 [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 에 있는 [Failable Initializers (실패 가능 초기자)]({% post_url 2016-01-23-Initialization %}#failable-initializers-실패-가능-초기자) 와 [Failable Initializers for Enumerations with Raw Values (원시 값을 가진 열거체를 위한 실패 가능 초기자)]({% post_url 2016-01-23-Initialization %}#failable-initializers-for-enumerations-with-raw-values-원시-값을-가진-열거체를-위한-실패-가능한-초기자) 에서도 설명하고 있습니다.

[^indirect]: 여기서 '재귀적인 (recursive) 열거체' 를 만들기 위해 '`indirect` (간접)' 이라는 키워드를 사용하는데, 이는 메모리 주소 방식 중 하나인 'indirect addressing mode' 라는 말에서 유래한 것으로 추측됩니다. 'indirect addressing mode' 에 대한 보다 더 자세한 내용은 [Difference between Indirect and Immediate Addressing Modes](https://www.geeksforgeeks.org/difference-between-indirect-and-immediate-addressing-modes/?ref=rp) 항목을 참고하기 바랍니다.

[^indirection]: 본문을 보면 '재귀 (recursive)' 라는 말과 '간접 (indirection)' 이라는 말을 거의 같은 개념으로 사용하는데, 이는 스위프트 열거체를 '재귀적' 으로 만드는 방식이 메모리의 '간접 주소' 방식을 써서 구현하기 때문입니다.

[^cases]: 'case' 는 '경우' 라고 옮길 수 있지만, 스위프트의 'case' 는 하나의 '키워드 (keyword)' 이기도 하면서, 때에 따라 'case 값', 'case 절', 그리고 그냥 '경우' 를 의미하기도 하기 때문에, 한글로 '경우' 를 의미할 때만 '경우' 라고 하고, 그 이외의 상황에서는 'case 값' 또는 'case 절' 이라고 옮깁니다.

[^plural-vs-singular]: '열거체 이름' 을 '복수형' 으로 만들면 본문 예제는 `CompassPoints` 가 될 것입니다. 이 경우, 아래 예제는 `CompassPoints.west` 가 되는데, '나침판 (compass)' 의 방향이 동시에 여러 개일 수 있다고 착각할 수 있을 것입니다.
