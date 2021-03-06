---
layout: post
comments: true
title:  "Swift 5.5: Initialization (초기화)"
date:   2016-01-23 19:35:00 +0900
categories: Xcode Swift Grammar Initialization
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html) 부분[^Initialization]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Initialization (초기화)

_초기화 (initialization)_ 는 사용을 위해 클래스, 구조체, 또는 열거체의 인스턴스를 준비하는 과정입니다. 이 과정은 해당 인스턴스의 각 저장 속성에 초기 값을 설정하는 것과 새로운 인스턴스를 사용하기 전에 필수로 준비해야 할 어떤 설정 또는 초기화를 포함합니다.

이 초기화 과정은, 특정 타입의 새로운 인스턴스를 생성하기 위해 호출할 수 있는 특수한 함수 같은, _초기자 (initializers)_ 를 정의함으로써 구현합니다. 오브젝티브-C 의 초기자와는 달리, 스위프트의 초기자는 값을 반환하지 않습니다. 이들의 주 역할은 최초로 사용하기 전에 새로운 타입의 인스턴스가 올바르게 초기화되도록 보장하는 것입니다.

클래스 타입의 인스턴스는, 해당 클래스의 인스턴스가 해제되기 직전에 '사용자 정의 정리 작업' 을 수행하는, _정리자 (deinitializers)_ 도 구현할 수 있습니다. 정리자에 대한 더 많은 정보는, [Deinitialization (뒷정리)]({% post_url 2017-03-03-Deinitialization %}) 를 참고하기 바랍니다.

### Setting Initial Values for Stored Properties (저장 속성에 대한 초기 값 설정하기)

클래스와 구조체는 해당 클래스나 구조체의 인스턴스가 생성될 때까지 자신의 모든 저장 속성에 _반드시 (must)_ 적절한 초기 값을 설정해야 합니다. 저장 속성을 '결정하지 않은 상태' 로 남겨둘 수는 없습니다.

저장 속성의 초기 값은 '초기자' 내에서나, 또는 속성 정의에서 '기본 (default) 속성 값' 을 할당함으로써 설정할 수 있습니다. 이 행동들은 다음 부분에서 설명합니다.

> 기본 값을 저장 속성에 할당하거나, 초기자 내에서 초기 값을 설정할 때, 해당 속성의 값은, 어떤 '속성 관찰자' 도 호출하지 않은 채, 직접 설정됩니다.

#### Initializers (초기자)

_초기자 (initializers)_ 는 특정 타입의 새로운 인스턴스를 생성하기 위해 호출됩니다. 가장 단순한 형식의, 초기자는, `init` 키워드로 작성된, 매개 변수가 없는 인스턴드 메소드와 같습니다:

```swift
init() {
  // 여기에서 일정한 초기화를 수행함
}
```

아래 예제는 '화씨 (Fahrenheit)' 눈금으로 표현된 온도를 저장하는 `Fahrenheit` 라는 새로운 구조체를 정의합니다. `Fahrenheit` 구조체는, `Double` 타입의, `temperature` 라는, 저장 속성을 하나 가지고 있습니다:

```swift
struct Fahrenheit {
  var temperature: Double
  init() {
    temperature = 32.0
  }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// "The default temperature is 32.0° Fahrenheit" 를 인쇄합니다.
```

이 구조체는, 저장 온도를 ('화씨' 에서 물의 어는 점인) `32.0` 값으로 초기화하는, 매개 변수가 없는, 단일 초기자인, `init` 을 정의합니다.

#### Default Property Values (기본 속성 값)

위에서 본 것처럼, 저장 속성의 초기 값은 '초기자' 에서 설정할 수 있습니다. 대안으로, 속성의 선언[^property-declaration]에서 _기본 속성 값 (default property value)_ 을 지정합니다. '기본 속성 값' 은 정의할 때 속성에 초기 값을 할당함으로써 지정합니다.

> 속성이 항상 똑같은 초기 값을 취한다면, 초기자에서 값을 설정하는 대신 '기본 값' 을 제공하도록 합니다. 최종 결과는 똑같지만, 기본 값은 속성의 초기화를 선언과 더 가깝게 묶어줍니다. 이는 초기자를 더 짧고, 더 명확하게 해주며 기본 값으로 속성의 타입을 추론할 수 있게 해줍니다. 기본 값은, 이 장 나중에 설명하는 것처럼, '기본 초기자 (default initializer)' 와 '초기자 상속 (initializer inheritance)' 이라는 장점도 더 쉽게 취하도록 해줍니다.

위에 있는 `Fahrenheit` 구조체는 속성을 선언하는 시점에 `temperature` 속성에 기본 값을 제공함으로써 더 간단한 형식으로 작성할 수 있습니다:

```swift
struct Fahrenheit {
  var temperature = 32.0
}
```

### Customizing Initialization (초기화를 사용자 정의하기)

초기화 과정은, 다음 부분에서 설명하는 것처럼, 입력 매개 변수와 옵셔널 속성 타입으로, 또는 초기화하는 동안 상수 속성을 할당함으로써, 사용자 정의할 수 있습니다.

#### Initialization Parameters (초기화 매개 변수)

초기자의 정의는, 초기화 과정을 사용자 정의하는 값의 타입과 이름을 정의하도록, _초기화 매개 변수 (initialization parameters)_ 를 제공할 수 있습니다. '초기화 매개 변수' 는 함수 및 메소드 매개 변수와 똑같은 '보유 능력' 과 '구문 표현' 을 가집니다.

다음 예제는, '섭씨 (Celsius)' 눈금으로 표현된 온도를 저장하는, `Celsius` 라는 구조체를 정의합니다. `Celsius` 구조체는, 다른 '척도 (scale)' 의 온도 값을 가지고 새 구조체 인스턴스를 초기화하는, `init(fromFahrenheit:)` 와 `init(fromKelvin:)` 이라는 두 개의 '사용자 정의 초기자' 를 구현합니다:

```swift
struct Celsius {
  var temperatureInCelsius: Double
  init(fromFahrenheit fahrenheit: Double) {
    temperatureInCelsius = (fahrenheit - 32.0) / 1.8
  }
  init(fromKelvin kelvin: Double) {
    temperatureInCelsius = kelvin - 273.15
  }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius 는 100.0 입니다.
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// freezingPointOfWater.temperatureInCelsius 는 0.0 입니다.
```

첫 번째 초기자는 `fromFahrenheit` 라는 '인자 이름표' 와 `fahrenheit` 라는 '매개 변수 이름' 을 가진 '단일 초기화 매개 변수' 를 가지고 있습니다. 두 번째 초기자는 `fromKelvin` 이라는 '인자 이름표' 와 `kelvin` 이라는 '매개 변수 이름' 을 가진 '단일 초기화 매개 변수' 를 가집니다. 두 초기자 모두 자신의 단일 인자를 관련된 섭씨 값으로 변환하며 `temperatureInCelsius` 라는 속성에 이 값을 저장합니다.

#### Parameter Names and Argument Labels (매개 변수 이름과 인자 이름표)

함수 및 메소드 매개 변수에서 처럼, '초기화 매개 변수' 는 초기자 본문에서 사용하기 위한 '매개 변수 이름' 과 초기자를 호출할 때 사용하기 위한 '인자 이름표' 를 둘 다 가질 수 있습니다.

하지만, 초기자는 함수와 메소드가 하는 방식대로 자신의 괄호 앞에 식별용 '함수 이름' 을 가지진 않습니다.[^function-name] 그러므로, 초기자 매개 변수의 이름과 타입은 어떤 초기자를 호출해야 하는지 식별하는데 특히 중요한 역할을 담당합니다. 이 때문에, 직접 제공하지 않을 경우 스위프트는 초기자의 _모든 (every)_ 매개 변수에 대해 '자동 인자 이름표' 를 제공합니다.[^automatic-argument-label]

다음 예제는, `red`, `green`, 그리고 `blue` 라는 세 개의 상수 속성을 가진, `Color` 라는 구조체를 정의합니다. 이 속성들은 '색상 (color)' 에 있는 빨강, 녹색, 및 파랑 (성분의) 양을 표시하는 `0.0` 에서 `1.0` 사이의 값을 저장합니다.

`Color` 는 빨강, 녹색, 및 파랑 성분에 대하여 적절한 이름의 `Double` 타입인 세 매개 변수를 가지는 초기자를 제공합니다. `Color` 는, 모든 세 색상 성분에 대해 똑같은 값을 제공하는, '단일 `white` 매개 변수' 를 가지는 두 번째 초기자도 제공합니다.

```swift
struct Color {
  let red, green, blue: Double
  init(red: Double, green: Double, blue: Double) {
    self.red   = red
    self.green = green
    self.blue  = blue
  }
  init(white: Double) {
    red   = white
    green = white
    blue  = white
  }
}
```

두 초기자 모두, 각각의 초기자 매개 변수에 '이름 붙인 값 (named value)' 을 제공함으로써, 새로운 `Color` 인스턴스를 생성하는데 사용할 수 있습니다:

```swift
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
```

이 초기자들은 '인자 이름표' 를 사용하지 않고 호출하는 것이 불가능하다는 점을 기억하기 바랍니다. '인자 이름표' 가 정의되어 있으면 반드시 항상 초기자에서 사용해야 하며, 이를 생략하는 것은 '컴파일-시간 에러' 입니다[^argument-label]:

```swift
let veryGreen = Color(0.0, 1.0, 0.0)
// 이는 컴파일-시간 에러라고 보고합니다 - 인자 이름표는 필수입니다
```

#### Initializer Parameters Without Argument Labels (인자 이름표가 없는 초기자 매개 변수)

초기자 매개 변수에 인자 이름표를 사용하고 싶지 않으면, 해당 매개 변수에 '명시적인 인자 이름표' 대신 '밑줄 (underscore; `_`)' 를 작성하여 기본 작동 방식을 '재정의 (override)' 합니다.

다음은 위의 [Initialization Parameters (초기화 매개 변수)](#initialization-parameters-초기화-매개-변수) 에 있는 `Celsius` 예제를, 이미 '섭씨' 척도인 `Double` 값으로 새 `Celsius` 인스턴스를 생성하는 추가적인 초기자를 가지도록, 확장한 버전입니다:

```swift
struct Celsius {
  var temperatureInCelsius: Double
  init(fromFahrenheit fahrenheit: Double) {
    temperatureInCelsius = (fahrenheit - 32.0) / 1.8
  }
  init(fromKelvin kelvin: Double) {
    temperatureInCelsius = kelvin - 273.15
  }
  init(_ celsius: Double) {
    temperatureInCelsius = celsius
  }
}
let bodyTemperature = Celsius(37.0)
// bodyTemperature.temperatureInCelsius 는 37.0 입니다.
```

`Celsius(37.0)` 라는 초기자 호출은 인자 이름표가 필요 없이 의도가 명확합니다. 그러므로 이 초기자를 `init(_ celsius: Double)` 로 작성하여 '이름 없는 `Double` 값' 으로 호출할 수 있게 하는 것이 적절합니다.

#### Optional Property Types (옵셔널 속성 타입)

자신만의 사용자 정의 타입이-초기화 동안 값을 설정할 수 없거나, 나중의 어떤 시점에 "값이 없울" 수도 있기 때문에-논리적으로 "값이 없음 (no value)" 을 허용한 저장 속성을 가질 경우, 그 속성은 _옵셔널 (optional)_ 타입으로 선언합니다. 옵셔널 타입인 속성은, 초기화 동안 속성의 "값이 아직 없음" 은 일부로 의도한 것임을 지시하는, `nil` 값으로 초기화 됩니다.

다음 예제는, `response` 라는 '옵셔널 `String` 속성' 을 가진, `SurveyQuestion` 이라는 클래스를 정의합니다:

```swift
class SurveyQuestion {
  var text: String
  var response: String?
  init(text: String) {
    self.text = text
  }
  func ask() {
    print(text)
  }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// "Do you like cheese?" 를 인쇄합니다.
cheeseQuestion.response = "Yes, I do like cheese."
```

'설문 조사 (survey question)' 에 대한 응답은 질문하기 전까지는 알 수 없으므로, `response` 속성을 `String?`, 또는 “옵셔널 `String`” 타입으로 선언합니다. 이는, 새로운 `SurveyQuestion` 인스턴스를 초기화할 때, "값이 아직 없음" 을 의미하는, `nil` 기본 값으로 자동 할당됩니다.

#### Assigning Constant Properties During Initialization (초기화하는 동안 상수 속성 할당하기)

상수 속성의 값은, 초기화를 종료할 때까지 확실한 값이 설정되기만 한다면, 초기화 동안의 어떤 시점에도 할당할 수 있습니다. 상수 속성에 값을 한 번 설정하고 나면, 더 이상 수정할 수 없습니다.

> 클래스 인스턴스에서의, 상수 속성은 이를 도입한 클래스의 초기화 동안에만 수정할 수 있습니다. 하위 클래스에서 수정할 수는 없습니다.

위에 있는 `SurveyQuestion` 예제는, `SurveyQuestion` 인스턴스를 한 번 생성하고 나면 질문은 바뀔 수 없음을 지시하기 위해, 질문에 대한 `text` 속성을 '변수 속성' 대신 '상수 속성' 을 사용하도록 개정할 수 있습니다. `text` 속성은 이제 상수일지라도, 여전히 클래스의 초기자에서 설정할 수 있습니다:

```swift
class SurveyQuestion {
  let text: String
  var response: String?
  init(text: String) {
    self.text = text
  }
  func ask() {
    print(text)
  }
}
let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
// "How about beets?" 를 인쇄합니다.
beetsQuestion.response = "I also like beets. (But not with cheese.)"
```

### Default Initializers (기본 초기자)

스위프트는 모든 속성에 '기본 값' 을 제공면서 자체로는 단 하나의 초기자도 제공하지 않는 어떤 구조체나 클래스든 '_기본 초기자 (default initializer)_' 를 제공합니다. '기본 초기자' 는 단순히 모든 속성을 기본 값으로 설정하는 것으로 새로운 인스턴스를 생성합니다.

이 예제는, '구매 목록 (shopping list)' 의 각 항목에 대한 이름, 수량, 그리고 '구매 상태' 를 '은닉 (encapsulate)' 하는, `ShoppingListItem` 이라는 클래스를 정의합니다:

```swift
class ShoppingListItem {
  var name: String?
  var quantity = 1
  var purchased = false
}
var item = ShoppingListItem()
```

`ShoppingListItem` 클래스는 모든 속성이 기본 값을 가지고 있기 때문에, 그리고 '상위 클래스' 를 가지지 않는 '기초 클래스'[^base-class] 이기 때문에, `ShoppingListItem` 은 모든 속성을 기본 값으로 설정하는 것으로 새로운 인스턴스를 생성하는 '기본 초기자' 구현을 자동으로 가지게 됩니다. (`name` 속성은 '옵셔널 `String` 속성' 이므로, 코드에 값을 작성하지 않더라도, `nil` 이라는 기본 값을 자동으로 받습니다.) 위 예제는 `ShoppingListItem` 클래스가, `ShoppingListItem()` 라고 작성한, '초기자 구문 표현' 으로 클래스의 새로운 인스턴스를 생성하는데 '기본 초기자' 를 사용하며, 이 새 인스턴스를 `item` 이라는 변수에 할당합니다.

#### Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)

구조체 타입이 자신만의 초기자를 직접 정의하지 않은 경우라면 _멤버 초기자 (memberwise initializer)_ 를 자동으로 부여 받습니다. '기본 초기자' 와는 달리, 구조체는 '기본 값' 이 없는 저장 속성을 가진 경우에도 '멤버 초기자' 를 부여 받습니다.

멤버 초기자는 새 구조체 인스턴스의 '멤버 속성' 을 초기화하는 '줄임 표현법' 입니다. 새 인스턴스의 속성을 위한 초기 값은 '이름' 으로써 '멤버 초기자' 에 전달할 수 있습니다.

아래 예제는 `width` 와 `height` 라는 두 속성을 가진 `Size` 라는 구조체를 정의합니다. 두 속성 다 `0.0` 이라는 기본 값을 할당함으로써 `Double` 타입으로 추론됩니다.

`Size` 구조체는, 새 `Size` 인스턴스를 초기화하는데 사용할 수 있는, '`init(width:height:)` 멤버 초기자'를 자동으로 부여 받습니다:

```swift
struct Size {
  var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
```

'멤버 초기자' 를 호출할 때는, 기본 값을 가진 어떤 속성의 값도 생략할 수 있습니다. 위 예제에 있는, `Size` 구조체는 `height` 와 `width` 속성 둘 다 기본 값을 가집니다. 어느 한 속성 또는 두 속성 다 생략할 수 있으며, 생략한 것에는 초기자가 기본 값을 사용합니다-예를 들면 다음과 같습니다:

```swift
let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
// "0.0 2.0" 를 인쇄합니다.

let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)
// "0.0 0.0" 를 인쇄합니다.
```

### Initializer Delegation for Value Types (값 타입을 위한 초기자의 위임)

초기자는 인스턴스 초기화의 일부를 다른 초기자를 호출하여 수행할 수 있습니다. _초기자 위임 (initializer delegation)_ 이라고 하는, 이 과정은, 여러 초기자들 간에 코드가 중복되는 것을 피하도록 합니다.

초기자 위임의 작업 방법, 및 허용된 위임 형식에 대한 규칙은, 값 타입인지 클래스 타입인지에 따라 다릅니다. (구조체와 열거체 같은) 값 타입은 상속을 지원하지 않으므로, 초기자 위임 과정이 상대적으로 간단한데, 직접 제공하는 또 다른 초기자로만 위임할 수 있기 때문입니다. 하지만, 클래스는, [Inheritance (상속)]({% post_url 2020-03-31-Inheritance %}) 에서 설명한 것처럼, 다른 클래스를 상속할 수 있습니다. 이는 클래스의 경우 초기화 동안 자신이 상속한 모든 저장 속성에 적합한 값을 할당했음을 보장하는 추가적인 책임을 진다는 의미입니다. 이 책임들은 아래의 [Class Inheritance and Initialization (클래스 상속과 초기화)](#class-inheritance-and-initialization-클래스-상속과-초기화) 에서 설명합니다.

'값 타입' 에 대해서는, 자신만의 사용자 정의 초기자를 작성할 때 동일한 값 타입에 있는 다른 초기자를 참조하기 위해 `self.init` 을 사용합니다. `self.init` 은 초기자 내에서만 호출할 수 있습니다.

값 타입에 '사용자 정의 초기자' 를 정의한 경우, 더 이상 해당 타입에 대한 '기본 초기자' (또는, 구조체라면, 멤버 초기자) 에 접근할 수 없음을 기억하기 바랍니다. 이 구속 조건은 누군가 자동 초기자 중 하나를 사용함으로써 더 복잡한 초기자에서 제공한 추가적인 핵심 설정들을 우회하는 상황을 막아줍니다.

> 자신이 만든 값 타입이 '기본 초기자' 와 '멤버 초기자' 뿐 아니라, 자신만의 사용자 정의 초기자로도 초기화 가능하도록 하고 싶으면, 자신만의 사용자 정의 초기자를 값 타입의 원본 구현에서가 아니라 '익스텐션 (extension)' 에서 작성합니다. 더 많은 정보는, [Extensions (익스텐션; 확장)]({% post_url 2016-01-19-Extensions %}) 을 참고하기 바랍니다.

다음 예제는 기하학적인 직사각형을 표현하는 사용자 정의 구조체인 `Rect` 를 정의합니다. 이 예제는 `Size` 와 `Point` 라는, 둘 다 모든 속성에 `0.0` 이라는 기본 값을 제공하는, 두 개의 '보조 구조체' 를 필수로 요구합니다:

```swift
struct Size {
  var width = 0.0, height = 0.0
}
struct Point {
  var x = 0.0, y = 0.0
}
```

아래의 `Rect` 구조체는-기본 값 '0' 으로 초기화된 `origin` 과 `size` 속성 값을 사용하거나, 또는 원점과 크기를 지정하거나, 아니면 중심 점과 크기를 지정하는-세 방법 중 하나로 초기화할 수 있습니다. 이 초기화 옵션들은 `Rect` 구조체 정의의 일부분인 '세 개의 사용자 정의 초기자' 로써 표현됩니다:

```swift
struct Rect {
  var origin = Point()
  var size = Size()
  init() {}
  init(origin: Point, size: Size) {
    self.origin = origin
    self.size = size
  }
  init(center: Point, size: Size) {
    let originX = center.x - (size.width / 2)
    let originY = center.y - (size.height / 2)
    self.init(origin: Point(x: originX, y: originY), size: size)
  }
}
```

첫 번째 `Rect` 초기자인, `init()` 은, 구조체가 자신만의 사용자 정의 초기자를 가지지 않았다면 부여 받았을 '기본 초기자' 와 기능이 똑같습니다. 이 초기자는, `{}` 라는 빈 중괄호 쌍으로 표현된, 빈 본문을 가지고 있습니다. 이 초기자를 호출하면 `origin` 과 `size` 속성이 둘 다 `Point(x: 0.0, y: 0.0)` 과 `Size(width: 0.0, height: 0.0)` 라고 자신의 속성 정의에 있는 기본 값으로 초기화된 `Rect` 인스턴스를 반환합니다:

```swift
let basicRect = Rect()
// basicRect 의 원점은 (0.0, 0.0) 이고 크기는 (0.0, 0.0) 입니다.
```

두 번째 `Rect` 초기자인, `init(origin:size:)` 는, 구조체가 자신만의 사용자 정의 초기자를 가지지 않았다면 부여 받았을 '멤버 초기자' 와 기능이 똑같습니다. 이 초기자는 단순히 `origin` 과 `size` 인자 값을 적절한 저장 속성에 할당합니다:

```swift
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
// originRect 의 원점은 (2.0, 2.0) 이고 크기는 (5.0, 5.0) 입니다.
```

세 번째 `Rect` 초기자인, `init(center:size:)` 는, 좀 더 복잡합니다. 이는 `center` 점과 `size` 값을 기초로 적절한 원점을 계산하는 것으로써 시작합니다. 그런 다음, 새 원점과 크기 값을 적절한 속성에 저장하는,  `init(origin:size:)` 초기자를 호출합니다 (또는 그리로 _위임 (delegates)_ 합니다):

```swift
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
// centerRect 의 원점은 (2.5, 2.5) 이고 크기는 (3.0, 3.0) 입니다.
```

`init(center:size:)` 초기자가 새 `origin` 과 `size` 값을 적절한 속성에 직접 할당할 수도 있을 것입니다. 하지만, `init(center:size:)` 초기자가 해당 기능을 이미 정확하게 제공하는 기존 초기자의 장점을 취하도록 하는 것이 더 편리 (하고 의도도 더 명확) 합니다.

> `init()` 과 `init(origin:size:)` 초기자를 직접 정의하지 않고도 이 예제를 작성하는 대안 방식은, [Extensions (익스텐션; 확장)]({% post_url 2016-01-19-Extensions %}) 을 참고하기 바랍니다.

### Class Inheritance and Initialization (클래스 상속과 초기화)

클래스의 모든 저장 속성은-상위 클래스에서 상속한 어떤 속성이든 포함하여-초기화 동안 _반드시 (must)_ 초기 값을 할당해야 합니다.

스위프트는 클래스 타입이 모든 저장 속성에 초기 값을 부여했음을 보장하는 것을 돕기 위해 두 가지 종류의 초기자를 정의합니다. 이들을 '지명 (designated) 초기자' 와 '편의 (convenience) 초기자' 라고 합니다.

#### Designated Initializers and Convenience Initializers (지명 초기자와 편의 초기자)

_지명 초기자 (designated initializers)_ 는 클래스에 대한 '첫째가는 초기자' 입니다. '지명 초기자' 는 해당 클래스가 도입한 모든 속성을 온전히 초기화하며 초기화 과정이 위쪽 상위 클래스 연쇄망으로 계속 이어지도록 적절한 상위 클래스 초기자를 호출합니다.

클래스는 극 소수의 지명 초기자만 가지는 경향이 있으며, 단 하나만 가지는 것이 꽤 일반적입니다. 지명 초기자는 이를 통해 초기화가 일어나고, 초기화 과정이 위쪽 상위 클래스 연쇄망으로 계속 이어지도록 하는, "깔때기 (funnel)"[^funnel] 지점입니다.

모든 클래스는 반드시 최소한 하나의 지명 초기자를 가져야만 합니다. 어떤 경우, 이 '필수 조건 (requirement)' 은, 아래의 [Automatic Initializer Inheritance (자동적인 초기자 상속)](#automatic-initializer-inheritance-자동적인-초기자-상속) 에서 설명하는 것처럼, 하나 이상의 상위 클래스 지명 초기자를 상속함으로써 만족됩니다.

_편의 초기자 (convenience initializers)_ 는 클래스에 대한 '둘째가는, 지원용 초기자' 입니다. '편의 초기자' 는 지명 초기자의 일부 매개 변수를 기본 값으로 설정함으로써 동일 클래스에 있는 지명 초기자를 호출하기 위해 정의할 수 있습니다. '편의 초기자' 는 지정한 용도 또는 입력 값 타입에 맞게 해당 클래스의 인스턴스를 생성하기 위해 정의할 수도 있습니다.

클래스에서 필수가 아니라면 편의 초기자를 제공할 필요는 없습니다. 일반적으로 공통된 초기화 유형에 대한 '줄임말' 이 시간을 절약하거나 클래스 초기화의 의도를 명확하게 해줄 때마다 '편의 초기자' 를 생성하기 바랍니다.

#### Syntax for Designated and Convenience Initializers (지명 초기자와 편의 초기자를 위한 구문 표현)

클래스를 위한 '지명 초기자' 는 '값 타입' 을 위한 단순 초기자와 작성 방식이 같습니다:

init(`parameters-매개 변수`) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
}

'편의 초기자' 는 같은 양식으로 작성하지만, `init` 키워드 앞에, 공백으로 구분한 후, `convenience` 수정자를 붙입니다:

convenience init(`parameters-매개 변수`) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
}

#### Initializer Delegation for Class Types (클래스 타입을 위한 초기자의 위임)

지명과 편의 초기자 사이의 관계를 단순화하기 위해, 스위프트는 초기자 사이의 '위임 호출 (delegation calls)'[^delegation-calls] 에 대해 다음과 같은 세 가지 규칙을 적용합니다:

**Rule 1 (규칙 1)**

&nbsp;&nbsp;&nbsp;&nbsp;지명 초기자는 자신의 직속 상위 클래스에 있는 지명 초기자를 반드시 호출해야 합니다.

**Rule 2 (규칙 2)**

&nbsp;&nbsp;&nbsp;&nbsp;편의 초기자는 _같은 (same)_ 클래스에 있는 또 다른 초기자를 반드시 호출해야 합니다.

**Rule 3 (규칙 3)**

&nbsp;&nbsp;&nbsp;&nbsp;편의 초기자는 궁극적으로 지명 초기자를 반드시 호출해야 합니다.

이를 기억하는 간단한 방법은 다음과 같습니다:

* 지명 초기자는 반드시 항상 _위로 (up)_ 위임합니다.
* 편의 초기자는 반드시 항상 _옆으로 (across)_ 위임합니다.

이 규칙들을 묘사하면 아래 그림처럼 됩니다:

![delegation rules](/assets/Swift/Swift-Programming-Language/Initialization-delegation-rules.jpg)

여기에 있는, 상위 클래스는 단일 지명 초기자와 두 개의 편의 초기자를 가지고 있습니다. 편의 초기자 하나가, 차례대로 단일 지명 초기자를 호출하는, 다른 편의 초기자를 호출합니다. 이는 위에 있는 '규칙 2' 와 '규칙 3' 을 만족합니다. 상위 클래스 자체는 더 위의 상위 클래스를 가지지 않으므로, '규칙 1' 은 적용되지 않습니다.

이 그림에 있는 하위 클래스는 두 개의 지명 초기자와 하나의 편의 초기자를 가지고 있습니다. 편의 초기자는, 동일한 클래스에 있는 다른 초기자만 호출할 수 있기 때문에, 두 지명 초기자 중 하나를 반드시 호출해야 합니다. 이는 위에 있는 '규칙 2' 와 '규칙 3' 을 만족합니다. 두 지명 초기자 모두, 위에 있는 '규칙 1' 을 만족하기 위해, 상위 클래스에 있는 단일 지명 초기자를 반드시 호출해야 합니다.

> 이 규칙들은 클래스의 사용자가 각각의 클래스 인스턴스를 _생성하는 (create)_ 방법에는 영향을 주지 않습니다. 위 도식에 있는 어떤 초기자든 자신이 속한 클래스의 온전히 초기화된 인스턴스를 생성하는데 사용할 수 있습니다. 이 규칙들은 클래스의 초기자에 대한 구현을 작성하는 방법에만 영향을 미칩니다.

아래 그림은 네 클래스로 이루어진 더 복잡한 클래스 계층 구조를 보여줍니다. 이는 이 계층 구조에 있는 지명 초기자가 클래스 초기화에 대해서, 연쇄망에 있는 클래스 간의 관계를 단순화하는, "깔때기 (funnel)" 처럼 행동하는 방식을 묘사합니다.

![funnel points](/assets/Swift/Swift-Programming-Language/Initialization-funnel.png)

#### Two-Phase Initialization (2-단계 초기화)

스위프트의 클래스 초기화는 '2-단계 (two-phase) 과정' 입니다. 첫 번째 단계에서는, 도입한 클래스가 각각의 저장 속성에 초기 값을 할당합니다. 모든 저장 속성에 대해서 초기 상태를 한 번 결정하고 나면, 두 번째 단계를 시작하며, 새 인스턴스를 사용할 준비를 마치기 전에 각각의 클래스가 자신의 저장 속성을 한번 더 사용자 정의할 수 있는 기회를 가집니다.

'2-단계 초기화 과정' 의 사용은, 여전히 클래스 계층 구조에 있는 각 클래스에 완전한 유연함을 부여하면서도, 초기화는 안전하도록 만듭니다. 2-단계 초기화는 초기화되기 전에 속성 값에 접근하는 것도 막아 주며, 또 다른 초기자에 의해 예상치 않게 속성 값이 다른 값으로 설정되는 것도 막아줍니다.

> 스위프트의 2-단계 초기화 과정은 오브젝티브-C 의 초기화와 비슷합니다. 주요 차이점은 '1 단계' 동안, 오브젝티브-C 는 모든 속성에 ('0' 이나 'null' 같은) '0' 또는 '널 (null) 값' 을 할당한다는 것입니다. 스위프트의 초기화 흐름은 더 유연해서, 사용자 정의 초기 값을 설정할 수 있으며, `0` 또는 `nil` 이 기본 값으로 유효하지 않은 타입에도 대처할 수 있습니다.

스위프트 컴파일러는 '2-단계 초기화' 가 에러 없이 완료됨을 확실하게 하기 위해 도움이 될 만한 네 개의 '안전성-검사' 를 수행합니다:

**Safety Check 1 (안전성 검사 1)**

&nbsp;&nbsp;&nbsp;&nbsp;지명 초기자는 상위 클래스 초기자로 '위로 위임'[^delegate-up] 하기 전에 반드시 자신의 클래스가 도입한 모든 속성의 초기화를 보장해야 합니다.

위에서 언급한 것처럼, 객체의 메모리는 모든 저장 속성의 초기 상태를 한 번 알게 될 때에만 온전히 초기화된 것으로 고려합니다. 이 규칙을 만족하기 위해서는, 지명 초기자가 연쇄망 위로 손을 떼기 전에 반드시 자신만의 모든 속성을 초기화함을 확실히 해야 합니다.

**Safety Check 2 (안전성 검사 2)**

&nbsp;&nbsp;&nbsp;&nbsp;지명 초기자는 상속한 속성에 값을 할당하기 전에 반드시 상위 클래스 초기자로 '위로 위임' 해야 합니다. 그렇지 않으면, 상위 클래스의 초기화가 지명 초기자가 할당한 새 값을 덮어 쓸 것입니다.

**Safety Check 3 (안전성 검사 3)**

&nbsp;&nbsp;&nbsp;&nbsp;편의 초기자는 (동일한 클래스에서 정의한 속성을 포함하여) _어떤 (any)_ 속성에든 값을 할당하기 전에 반드시 다른 초기자로 위임해야 합니다. 그렇지 않으면, 클래스 자신의 지명 초기자가 편의 초기자가 할당한 새 값을 덮어 쓸 것입니다.

**Safety Check 4 (안전성 검사 4)**

&nbsp;&nbsp;&nbsp;&nbsp;초기자는 '1-단계 초기화' 를 완료하기 전까지는, 어떤 인스턴스 메소드의 호출도, 어떤 인스턴스 속성의 값을 읽는 것도, 또는 `self` 를 값으로 참조하는 것도, 할 수 없습니다.

클래스 인스턴스는 '1-단계' 가 끝나기 전까지는 온전하게 유효한 것이 아닙니다. '1-단계' 끝에서 한 번 클래스 인스턴스가 유효하다는 것을 알아야만, 속성에 접근할 수 있고, 메소드를 호출할 수 있습니다.

다음은, 위 네 안전성 검사를 기초로, '2-단계 초기화' 를 끝까지 마무리하는 방법입니다:

**Phase 1 (단계 1)**

* 클래스에 대한 지명 또는 편의 초기자를 호출합니다.
* 해당 클래스의 새로운 인스턴스에 대한 메모리를 할당합니다. 메모리가 초기화된 것은 아직 아닙니다.
* 해당 클래스에 대한 지명 초기자가 해당 클래스가 도입한 모든 저장 속성이 값을 가짐을 확정합니다. 이 저장 속성들에 대한 메모리가 이제 초기화되었습니다.
* 지명 초기자는 상위 클래스 초기자가 자신의 저장 속성을 위해 똑같은 작업을 수행하도록 손을 떼고 넘겨 줍니다.
* 이를 클래스 상속 연쇄망의 최상단에 도달할 때까지 계속합니다.
* 연쇄망의 최상단에 도달했고, 연쇄망에 있는 '최종 (final) 클래스'[^final-class] 가 모든 저장 속성이 값을 가짐을 한 번 보장하고 나면, 인스턴스의 메모리가 온전히 초기화됐다고 여기고, '1-단계' 를 완료합니다.

**Phase 2 (단계 2)**

* 연쇄망의 최상단에서 밑으로 거꾸로 내려가면서, 연쇄망의 각 지명 초기자는 인스턴스를 한번 더 사용자 정의할 수 있는 '옵션'[^option] 을 가집니다. 초기자는 이제 `self` 에 접근할 수 있으며, 자신의 속성을 수정하고, 자신의 인스턴스 메소드를 호출하는 것, 등을 할 수 있습니다.
* 최종적으로, 연쇄망의 어떤 편의 초기자라도 인스턴스를 사용자 정의하고 `self` 와 작업할 '옵션' 을 가집니다.

다음은 가상의 하위 클래스와 상위 클래스가 있을 때 '1-단계' 가 '초기화 호출' 을 찾아가는 방식입니다:

![Phase 1](/assets/Swift/Swift-Programming-Language/Initialization-delegation-phase-1.jpg)

이 예제에서, 초기화는 하위 클래스에 대한 편의 초기자를 호출하는 것으로 시작합니다. 이 편의 초기자는 아직 어떤 속성도 수정할 수 없습니다. 이는 동일한 클래스에 있는 지명 초기자로 '옆으로 위임' 합니다.

지명 초기자는, '안전성 검사 1' 에 따라, 하위 클래스의 모든 속성이 확실히 값을 가지도록 만듭니다. 그런 다음 초기화가 연쇄망 위로 계속되도록 자신의 상위 클래스에 대한 지명 초기자를 호출합니다.

상위 클래스의 지명 초기자는 상위 클래스의 모든 속성이 확실히 값을 가지도록 만듭니다. 더 이상 초기화할 상위 클래스가 없으므로, 더 이상의 위임은 필요하지 않습니다.

상위 클래스의 모든 속성이 초기 값을 가지자 마자, 메모리가 온전히 초기화된 것으로 고려하며, '1-단계' 를 완료합니다.

다음은 '2-단계' 가 같은 '초기화 호출' 을 찾아가는 방식입니다:

![Phase 2](/assets/Swift/Swift-Programming-Language/Initialization-delegation-phase-2.png)

상위 클래스의 지명 초기자는 이제 (꼭 해야하는 것은 아닐지라도) 인스턴스를 한 번 더 사용자 정의할 기회를 가집니다.

상위 클래스의 지명 초기자가 (작업을) 종료하고 나면, 하위 클래스의 지명 초기자가 추가적인 사용자 정의를 수행할 수 있습니다. (다시 말하지만, 꼭 해야하는 것은 아닙니다).

최종적으로, 하위 클래스의 지명 초기자가 종료하면, 원래 호출했던 편의 초기자가 추가적인 사용자 정의를 수행할 수 있습니다.

#### Initializer Inheritance and Overriding (초기자 상속과 재정의)

오브젝티브-C 의 하위 클래스와는 달리, 스위프트 하위 클래스는 자신의 상위 클래스 초기자를 기본적으로 상속하지 않습니다. 스위프트의 접근 방식은 상위 클래스의 단순한 초기자를 더 특수화된 하위 클래스가 상속해서 온전히 또는 올바르게 초기화되지 않은 하위 클래스의 인스턴스를 생성하는 상황을 막아줍니다.

> 상위 클래스 초기자 _는 (are)_ 정해진 상황에서는 상속되는데, 그렇게 하는 것이 안전하고 적절할 때만 그렇습니다. 더 많은 정보는, 아래의 [Automatic Initializer Inheritance (자동적인 초기자 상속)](#automatic-initializer-inheritance-자동적인-초기자-상속) 을 참고하기 바랍니다.  

사용자 정의 하위 클래스가 자신의 상위 클래스와 똑같은 초기자를 하나 이상 가지게 하고 싶으면, 하위 클래스 내에서 해당 초기자들의 사용자 정의 구현을 제공할 수 있습니다.

상위 클래스의 _지명 (designated)_ 초기자와 일치하는 하위 클래스 초기자를 작성할 때는, 실제로 해당 지명 초기자를 '재정의 (override)' 하고 있는 것입니다. 그러므로, 하위 클래스의 초기자 정의 앞에 반드시 `override` 수정자를 작성해야 합니다. 이는, [Default Initializers (기본 초기자)](#default-initializers-기본-초기자) 에서 설명한 것처럼, 자동으로 제공된 '기본 초기자' 를 재정의하고 있는 경우에도 그렇습니다.

속성, 메소드, 또는 첨자 연산의 '재정의' 에서 처럼, `override` 수정자를 붙이면 재정의한 것과 일치하는 '지명 초기자' 를 상위 클래스가 가지고 있는지 검사하도록 스위프트를 재촉하며, 직접 재정의한 초기자에 대한 매개 변수가 의도대로 지정되었는지 검증합니다.

> 상위 클래스의 지명 초기자를 재정의할 때는, 하위 클래스에서 구현하는 초기자가 편의 초기자인 경우이더라도, 항상 `override` 수정자를 작성합니다.

거꾸로 말해서, 상위 클래스의 _편의 (convenience)_ 초기자와 일치하는 하위 클래스 초기자를 작성하는 경우, 해당 상위 클래스의 편의 초기자는, 위의 [Initializer Delegation for Class Types (클래스 타입을 위한 초기자의 위임)](#initializer-delegation-for-class-types-클래스-타입을-위한-초기자의-위임) 에서 설명한 규칙에 따라, 하위 클래스가 절대로 직접 호출할 수 없습니다. 그러므로, 이 하위 클래스는 (엄밀하게 말해서) 상위 클래스 초기자의 '재정의' 를 제공하는 것이 아닙니다. 그 결과, 상위 클래스의 편의 초기자와 일치하는 구현을 제공할 때는 `override` 수정자를 작성하지 않습니다.

아래 예제는 `Vehicle` 이라는 '기초 클래스'[^base-class] 를 정의합니다. 이 기초 클래스는, 기본 `Int` 값이 `0` 인, `numberOfWheels` 라는 저장 속성을 선언합니다. `numberOfWheels` 속성은 `description` 이라는 계산 속성이 차량의 성질에 대한 `String` 설명을 생성하는데 사용합니다:

```swift
class Vehicle {
  var numberOfWheels = 0
  var description: String {
    return "\(numberOfWheels) wheel(s)"
  }
}
```

`Vehicle` 클래스는 단 하나의 저장 속성에 기본 값을 제공하며, 어떤 사용자 정의 초기자도 직접 제공하지 않습니다. 그 결과, [Default Initializers (기본 초기자)](#default-initializers-기본-초기자) 에서 설명한 것처럼, 기본 초기자를 자동으로 받습니다. 기본 초기자는 (사용 가능할 땐) 항상 클래스의 '지명 초기자' 이며, `numberOfWheels` 가 `0` 인 새로운 `Vehicle` 인스턴스를 생성하는데 사용할 수 있습니다:

```swift
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")
// Vehicle: 0 wheel(s)
```

그 다음 예제는 `Bicycle` 이라는 `Vehicle` 의 하위 클래스를 정의합니다:

```swift
class Bicycle: Vehicle {
  override init() {
    super.init()
    numberOfWheels = 2
  }
}
```

`Bicycle` 하위 클래스는 사용자 정의 지명 초기자인, `init()` 을, 정의합니다. 이 지명 초기자는 `Bicycle` 의 상위 클래스에 있는 지명 초기자와 일치하므로, 이 `Bicycle` 초기자 버전을 `override` 수정자로 표시합니다.

`Bicycle` 의 `init()` 초기자는, `Bicycle` 의 상위 클래스에 대한 기본 초기자를 호출하는, `super.init()` 의 호출로 시작합니다. 이는 `Bicycle` 이 속성을 수정할 기회를 가지기 전에 `Vehicle` 이 상속한 속성인 `numberOfWheels` 를 초기화하도록 보장합니다. `super.init()` 를 호출한 후에, `numberOfWheels` 의 원본 값을 `2` 라는 새 값으로 대체합니다.

`Bicycle` 의 인스턴스를 생성한 경우, `numberOfWheels` 속성이 갱신된 것을 보기 위해 상속한 계산 속성인 `description` 을 호출할 수 있습니다:

```swift
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")
// Bicycle: 2 wheel(s)
```

하위 클래스의 초기자가 초기화 과정 '2-단계' 에서 아무런 사용자 정의를 하지 않으면서, 상위 클래스가 '인자가-0개인' 지명 초기자를 가진 경우, 하위 클래스의 모든 저장 속성에 값을 할당한 후에 `super.init()` 호출을 생략할 수 있습니다.

이 예제는, `Hoverboard` 라는, `Vehicle` 의 또 다른 하위 클래스를 정의합니다. `Hoverboard` 클래스는, 초기자에서, 자신의 `color` 속성만을 설정합니다. `super.init()` 을 명시적으로 호출하는 대신, 이 초기자는 상위 클래스의 초기자에 대한 암시적인 호출에 의지하여 과정을 완료합니다.

```swift
class Hoverboard: Vehicle {
  var color: String
  init(color: String) {
    self.color = color
    // 여기에서 super.init() 을 암시적으로 호출합니다.
  }
  override var description: String {
    return "\(super.description) in a beautiful \(color)"
  }
}
```

`Hoverboard` 인스턴스는 `Vehicle` 초기자에서 지원하는 기본 설정 바퀴 개수를 사용합니다

```swift
let hoverboard = Hoverboard(color: "silver")
print("Hoverboard: \(hoverboard.description)")
// Hoverboard: 0 wheel(s) in a beautiful silver
```

> 하위 클래스는 초기화 동안 '상속한 변수 속성' 을 수정할 수 있지만, '상속한 상수 속성' 을 수정할 수는 없습니다.

#### Automatic Initializer Inheritance (자동적인 초기자 상속)

위에서 언급한 것처럼, 하위 클래스는 기본적으로 자신의 상위 클래스를 상속하지 않습니다. 하지만, 정해진 조건과 만나는 경우에는 상위 클래스의 초기자 _를 (are)_ 자동으로 상속합니다. 실제로, 이는 일반적인 많은 상황에서 '초기자 재정의' 를 작성할 필요가 없으며, 자신의 상위 클래스 초기자를 상속하는게 안전할 때마다 최소한의 노력으로 그렇게 할 수 있다는 의미입니다.

하위 클래스에서 자신이 도입한 어떤 새로운 속성에 대해서든 기본 값을 제공한다고 가정하면, 다음의 두 규칙이 적용됩니다:

**Rule 1 (규칙 1)**

&nbsp;&nbsp;&nbsp;&nbsp;하위 클래스가 어떤 지명 초기자도 정의하지 않는 경우, 상위 클래스의 모든 지명 초기자를 자동으로 상속합니다.

**Rule 2 (규칙 2)**

&nbsp;&nbsp;&nbsp;&nbsp;하위 클래스가 상위 클래스의 _모든 (all)_ 지명 초기자 구현을 제공하는 경우-'규칙 1' 에 따라 상속한 것이든, 정의에서 사용자 정의 구현을 제공한 것이든-그러면 상위 클래스의 모든 편의 초기자를 자동으로 상속합니다.

이 규칙들은 자신의 하위 클래스에서 편의 초기자를 더 추가한 경우에도 적용됩니다.

> 하위 클래스는 '규칙 2' 를 만족하기 위한 방편으로 상위 클래스의 지명 초기자를 하위 클래스의 편의 초기자로 구현할 수 있습니다.

#### Designated and Convenience Initialization in Action (지명 초기자와 편의 초기자의 실제 사례)

다음 예제는 지명 초기자, 편의 초기자, 그리고 '자동적인 초기자 상속' 에 대한 실제 사례를 보여줍니다. 이 예제는 `Food`, `RecipeIngredient`, 그리고 `ShoppingListItem` 이라는 세 클래스 계층 구조를 정의하고, 이 초기자들이 상호 작용하는 방법을 실증합니다.

계층 구조의 '기초 클래스'[^base-class-in-hierachy] 는 `Food` 라고 하는데, 식료품의 이름을 '은닉 (encapsulate)' 하는 단순한 클래스입니다. `Food` 클래스는 `name` 이라는 '단일 `String` 속성' 을 도입하며 `Food` 인스턴스를 생성하기 위한 두 개의 초기자를 제공합니다:

```swift
class Food {
  var name: String
  init(name: String) {
    self.name = name
  }
  convenience init() {
    self.init(name: "[Unnamed]")
  }
}
```

아래의 그림은 `Food` 클래스의 초기자 '연쇄망 (chain)' 을 보여줍니다:

![Initializer chain for the Food](/assets/Swift/Swift-Programming-Language/Initialization-chain-for-food.png)

클래스들이 기본적인 '멤버 초기자' 를 가지지 않으므로[^default-member-initializer], `Food` 클래스는 `name` 이라는 단일 인자를 취하는 지명 초기자를 제공합니다. 이 초기자는 지정한 이름을 가진 새 `Food` 인스턴스를 생성하는데 사용할 수 있습니다:

```swift
let namedMeat = Food(name: "Bacon")
// namedMeat 의 이름은 "Bacon" 입니다.
```

`Food` 클래스의 `init(name: String)` 초기자를 _지명 (designated)_ 초기자로 제공한 것은, 새로운 `Food` 인스턴스의 모든 저장 속성이 온전하게 초기화 된다는 것을 보장해야 하기 때문입니다. `Food` 클래스는 상위 클래스를 가지지 않으므로, `init(name: String)` 초기자는 초기화를 완료하기 위해 `super.init()` 을 호출할 필요가 없습니다.

`Food` 클래스는, `init()` 이라는, 인자가 없는, _편의 (convenience)_ 초기자도 제공합니다. `init()` 초기자는 `[Unnamed]` 라는 `name` 값으로 `Food` 클래스의 `init(name: String)` 에 '옆으로 위임' 함으로써 새로운 음식에 대한 기본적인 '자리 표시자 (placeholder)' 이름을 제공합니다:

```swift
let mysteryMeat = Food()
// mysteryMeat 의 이름은 "[Unnamed]" 입니다.
```

계층 구조의 두 번째 클래스는 `RecipeIngredient` 라는 `Food` 의 하위 클래스입니다. `RecipeIngredient` 클래스는 요리 조리법에 있는 '재료 (ingredient)' 를 모델링합니다. 이는 (`Food` 에서 상속한 `name` 속성에 더하여) `quantity` 라는 `Int` 속성을 도입하며 `RecipeIngredient` 인스턴스를 생성하기 위한 두 초기자를 정의합니다:

```swift
class RecipeIngredient: Food {
  var quantity: Int
  init(name: String, quantity: Int) {
    self.quantity = quantity
    super.init(name: name)
  }
  override convenience init(name: String) {
    self.init(name: name, quantity: 1)
  }
}
```

아래 그림은 `RecipeIngredient` 클래스의 초기자 '연쇄망' 을 보여줍니다:

![Initializer chain for the RecipeIngredient](/assets/Swift/Swift-Programming-Language/Initialization-chain-for-recipe.png)

`RecipeIngredient` 클래스는, 새 `RecipeIngredient` 인스턴스의 모든 속성을 정착시키는데 사용할 수 있는, `init(name: String, amount: Int)` 라는, 단일 지명 초기자를 가집니다. 이 초기자는 전달받은 `quantity` 인자를, `RecipeIngredient` 가 도입한 유일한 새 속성인, `quantity` 속성에 할당하는 것으로 시작합니다. 그런 후에, 초기자는 `Food` 클래스의 `init(name: String)` 초기자로 '위로 위임' 합니다. 이 과정은 위의 [Two-Phase Initialization (2-단계 초기화)](#two-phase-initialization-2-단계-초기화) 에 있는 '안전성 검사 2' 를 만족합니다.

`RecipeIngredient` 는, 이름 만으로 `RecipeIngredient` 인스턴스를 생성하고자 사용하는, `init(name: String)` 이라는, 편의 초기자도 정의합니다. 이 편의 초기자는 명시적인 수량 없이 생성된 `RecipeIngredient` 인스턴스는 어떤 것이든 수량이 `1` 이라고 가정합니다. 이런 편의 초기자 정의는 `RecipeIngredient` 인스턴스의 생성을 더 빠르고 편리하게 해주며, 여러 개의 단일-수량 `RecipeIngredient` 인스턴스를 생성할 때 코드 중복을 피하게 해줍니다. 이 편의 초기자는 단순히 클래스 지명 초기자에, `1` 이라는 `quantity` 값을 전달하여, '옆으로 위임' 합니다.

`RecipeIngredient` 가 제공한 `init(name: String)` 편의 초기자는 `Food` 의 _지명 (designated)_ 초기자인 `init(name: String)` 과 똑같은 매개 변수를 취합니다. 이 편의 초기자는 상위 클래스의 지명 초기자를 '재정의' 하기 때문에, ([Initializer Inheritance and Overriding (초기자 상속과 재정의)](#initializer-inheritance-and-overriding-초기자-상속과-재정의) 에서 설명한 것처럼) 반드시 `override` 수정자로 표시해야 합니다.

`RecipeIngredient` 가 `init(name: String)` 초기자를 편의 초기자로 제공하고 있을지라도, 그럼에도 불구하고 `RecipeIngredient` 는 상위 클래스에 대한 모든 지명 초기자의 구현을 제공하고 있는 것입니다. 그러므로, `RecipeIngredient` 또한 상위 클래스의 모든 편의 초기자를 자동으로 상속합니다.

이 예제에서, `RecipeIngredient` 의 상위 클래스는, `init()` 이라는 단일 편의 초기자를 가진, `Food` 입니다. 그러므로 이 초기자를 `RecipeIngredient` 가 상속합니다. 상속한 버전의 `init()` 은, `Food` 버전 대신 `RecipeIngredient` 버전의 `init(name: String)` 으로 위임한다는 것만 제외하면, `Food` 버전과 정확히 똑같은 방식으로 기능합니다.

이 세 초기자 모두 새 `RecipeIngredient` 인스턴스를 생성하는데 사용할 수 있습니다:

```swift
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
```

계층 구조의 세 번째이자 최종 클래스는 `ShoppingListItem` 라는 `RecipeIngredient` 의 하위 클래스입니다. `ShoppingListItem` 클래스는 구매 목록에 있는 '조리 재료 (recipe ingredient)' 를 모델링합니다.

구매 목록의 모든 항목은 "미구매 (unpurchased)" 로 시작합니다. 이 사실을 표현하기 위해, `ShoppingListItem` 은, 기본 값이 `false` 인, `purchased` 라는 '불리언 (Boolean)' 속성을 도입합니다. `ShoppingListItem` 은, `ShoppingListItem` 인스턴스를 설명하는 문장을 제공하는, `description` 계산 속성도 추가합니다:

```swift
class ShoppingListItem: RecipeIngredient {
  var purchased = false
  var description: String {
    var output = "\(quantity) x \(name)"
    output += purchased ? " ✔" : " ✘"
    return output
  }
}
```

> `ShoppingListItem` 은 `purchased` 에 초기 값을 제공하는 초기자를 하나도 정의하지 않는데, (여기서 모델링한) 구매 목록의 항목은 항상 '미구매' 로 시작하기 때문입니다.

`ShoppingListItem` 은, 도입한 모든 속성에 '기본 값' 을 제공하면서 어떤 초기자도 직접 정의하지 않기 때문에, 상위 클래스의 _모든 (all)_ 지명 및 편의 초기자를 자동으로 상속합니다.

아래 그림은 세 클래스 모두의 전체적인 초기자 연쇄망을 보여줍니다:

![Initializer chain for the all](/assets/Swift/Swift-Programming-Language/Initialization-chain-for-all.png)

상속한 세 초기자 모두 새 `RecipeIngredient` 인스턴스를 생성하는데 사용할 수 있습니다:

```swift
var breakfastList = [
  ShoppingListItem(),
  ShoppingListItem(name: "Bacon"),
  ShoppingListItem(name: "Eggs", quantity: 6),
]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
  print(item.description)
}
// 1 x Orange juice ✔
// 1 x Bacon ✘
// 6 x Eggs ✘
```

여기서, `breakfastList` 라는 새로운 배열을 세 개의 새로운 `ShoppingListItem` 인스턴스를 담은 '배열 글자 값 (array literal)' 으로 생성합니다. 배열의 타입은 `[ShoppingListItem]` 이라고 추론합니다. 배열을 생성한 후에, 배열 맨 처음에 있는 `ShoppingListItem` 의 이름을 `"[Unnamed]"` 에서 `"Orange juice"` 로 바꾸고 구매 완료 표시를 합니다. 각 배열 항목의 설명을 인쇄하면 예상대로 설정된 기본 상태를 보여줍니다.

### Failable Initializers (실패 가능 초기자)

초기화가 실패할 수 있는 클래스, 구조체, 또는 열거체를 정의하는 것이 유용할 때가 있습니다. 이 실패는 '무효한 초기화 매개 변수 값' 에 의해서, 또는 필수적인 외부 자원이 없어서, 아니면 초기화가 성공하는 것을 막는 어떤 다른 조건에 의해서 발생할 수가 있습니다.

실패할 수 있는 초기화 조건에 대처하기 위해, 클래스, 구조체, 또는 열거체의 정의에서 하나 이상의 '실패 가능 초기자' 를 정의합니다. '실패 가능 초기자' 는 `init` 키워드 뒤에 물음표를 붙여서 (`init?` 라고) 작성합니다.

> 똑같은 매개 변수 타입과 이름을 가진 '실패 가능 초기자' 와 '실패하지 않는 초기자' 를 정의할 수는 없습니다.

'실패 가능 초기자' 는 초기화하는 타입의 _옵셔널 (optional)_ 값을 생성합니다. 실패 가능 초기자에서 `return nil` 을 작성하여 초기화 실패가 발생한 지점을 지시합니다.

> 엄밀하게 말해서, 초기자는 값을 반환하지 않습니다. 그 보다는, 초기화가 끝날 때까지 `self` 가 온전히 그리고 올바르게 초기화되도록 보장하는 역할을 합니다. 비록 초기화 실패를 발생시키도록 `return nil` 을 작성할지라도, 초기화 성공을 지시하고자 `return` 키워드를 사용하지는 않습니다.

구체적인 예를 들어 보면, 수치 타입 변환을 위해 구현된 '실패 가능 초기자' 가 있습니다. 수치 타입 간의 변환이 값을 정확하게 유지하도록 보장하려면, `init(exactly:)` 초기자를 사용합니다.[^exactly] 타입 변환이 값을 유지할 수 없으면, 초기자가 실패합니다.

```swift
let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
  print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}
// "12345.0 conversion to Int maintains value of 12345" 를 인쇄합니다.

let valueChanged = Int(exactly: pi)
// valueChanged 는, Int 타입이 아니라, Int? 타입입니다.

if valueChanged == nil {
  print("\(pi) conversion to Int does not maintain value")
}
// "3.14159 conversion to Int does not maintain value" 를 인쇄합니다.
```

아래 예제는, `species` 라는 '상수 `String` 속성' 을 가진, `Animal` 이라는 구조체를 정의합니다. `Animal` 구조체는 `species` 라는 단일 매개 변수를 가진 '실패 가능 초기자' 도 정의합니다. 이 초기자는 초기자로 전달된 `species` 값이 빈 문자열인지 검사합니다. 빈 문자열인 경우, 초기화 실패가 발생합니다. 다른 경우라면, `species` 속성의 값을 설정하고, 초기화가 성공합니다:

```swift
struct Animal {
  let species: String
  init?(species: String) {
    if species.isEmpty { return nil }
    self.species = species
  }
}
```

이 '실패 가능 초기자' 는 새로운 `Animal` 인스턴스를 초기화하고 초기화가 성공했는지 검사하기 위해 사용할 수 있습니다:

```swift
let someCreature = Animal(species: "Giraffe")
// someCreature 의 타입은, Animal 이 아니라, Animal? 입니다.

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
// "An animal was initialized with a species of Giraffe" 를 인쇄합니다.
```

빈 문자열 값을 '실패 가능 초기자' 의 `species` 매개 변수에 전달하면, 초기자가 초기화 실패를 발생시킵니다:

```swift
let anonymousCreature = Animal(species: "")
// anonymousCreature 의 타입은, Animal 이 아니라, Animal? 입니다.

if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}
// "The anonymous creature could not be initialized" 를 인쇄합니다.
```

> (`"Giraffe"` 가 아닌 `""` 같은) 빈 문자열 값을 검사하는 것은 _옵셔널 (optional)_ `String` 값의 없음을 표시하는 `nil` 을 검사하는 것과 같지 않습니다. 위 예제에서, 빈 문자열 (`""`) 은 옵셔널-아닌, 유효한 `String` 입니다. 하지만, 동물이 자신의 `species` 속성 값으로 빈 문자열을 가지는 것은 적절하지 않습니다. 이런 제약 조건을 모델링하기 위해, 빈 문자열을 찾은 경우 '실패 가능 초기자' 가 초기화 실패를 발생시킵니다.

#### Failable Initializers for Enumerations (열거체를 위한 실패 가능 초기자)

실패 가능 초기자는 하나 이상의 매개 변수를 기초로 적절한 '열거체 case 값' 을 선택하기 위해 사용할 수 있습니다. 그런 다음 제공한 매개 변수가 적절한 '열거체 case 값' 과 일치하지 않을 경우 초기자가 실패할 수 있습니다.

아래 예제는, (`kelvin`, `celsius`, 그리고 `fahrenheit` 라는) 세 개의 가능한 상태를 가진, `TemperatureUnit` 이라는 열거체를 정의합니다. '실패 가능 초기자' 는 '온도 (temperature) 기호' 를 표현하는 `Character` 값에 대한 적절한 '열거체 case 값' 을 찾기 위해 사용합니다:

```swift
enum TemperatureUnit {
  case kelvin, celsius, fahrenheit
  init?(symbol: Character) {
    switch symbol {
    case "K":
      self = .kelvin
    case "C":
      self = .celsius
    case "F":
      self = .fahrenheit
    default:
      return nil
    }
  }
}
```

이 '실패 가능 초기자' 는 세 가능한 상태에 대한 적절한 '열거체 case 값' 을 선택하고 매개 변수가 이 세 상태 중 어느 것도 일치하지 않는 경우 초기화가 실패하도록 하고자 사용할 수 있습니다:

```swift
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
  print("This is a defined temperature unit, so initialization succeeded.")
}
// "This is a defined temperature unit, so initialization succeeded." 를 인쇄합니다.

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
  print("This is not a defined temperature unit, so initialization failed.")
}
// "This is not a defined temperature unit, so initialization failed." 를 인쇄합니다.
```

#### Failable Initializers for Enumerations with Raw Values (원시 값을 가진 열거체를 위한 실패 가능 초기자)

원시 값을 가진 열거체는, 적절한 원시-값 타입의 `rawValue` 라는 매개 변수를 취해서 일치하는 '열거체 case 값' 을 찾으면 이를 선택하고, 일치하는 값이 존재하지 않으면 '초기화 실패' 를 발생시키는, `init?(rawValue:)` 라는, '실패 가능 초기자' 를 자동으로 부여 받습니다.   

위에 있는 `TemperatureUnit` 예제는 `Character` 타입의 원시 값을 사용하고 `init?(rawValue:)` 초기자라는 장점을 취하여 재작성할 수 있습니다:

```swift
enum TemperatureUnit: Character {
  case kelvin = "K", celsius = "C", fahrenheit = "F"
}

let fahrenheitUnit = TemperatureUnit(rawValue: "F")
if fahrenheitUnit != nil {
  print("This is a defined temperature unit, so initialization succeeded.")
}
// "This is a defined temperature unit, so initialization succeeded." 를 인쇄합니다.

let unknownUnit = TemperatureUnit(rawValue: "X")
if unknownUnit == nil {
  print("This is not a defined temperature unit, so initialization failed.")
}
// "This is not a defined temperature unit, so initialization failed." 를 인쇄합니다.
```

#### Propagation of Initialization Failure (초기화 실패의 전파)

클래스, 구조체, 또는 열거체의 '실패 가능 초기자' 는 동일한 클래스, 구조체, 또는 열거체에 있는 또 다른 '실패 가능 초기자' 에 '옆으로 위임' 할 수 있습니다. 이와 비슷하게, 하위 클래스의 '실패 가능 초기자' 는 상위 클래스의 '실패 가능 초기자' 에 '위로 위임' 할 수 있습니다.

어느 경우든, 초기화 실패를 유발하는 또 다른 초기자로 위임한 경우, 전체 초기화 과정은 곧바로 실패하며, 더 이상 초기화 코드를 실행하지 않습니다.

> '실패 가능 초기자' 는 '실패하지 않는 초기자' 로도 위임할 수 있습니다. 다른 경우라면 실패하지 않을 기존의 '실패하지 않는 초기자' 에 잠재적인 실패 상태를 추가할 필요가 있을 경우 이 접근 방식을 사용합니다.

아래 예제는 `CartItem` 라는 `Product` 의 하위 클래스를 정의합니다. `CartItem` 클래스는 온라인 '장바구니 (shopping cart)' 에 있는 항목을 모델링 합니다. `CartItem` 은 `quantity` 라는 상수 저장 속성을 도입하며 이 속성이 항상 최소 `1` 이상의 값을 가지도록 보장합니다:

```swift
class Product {
  let name: String
  init?(name: String) {
    if name.isEmpty { return nil }
    self.name = name
  }
}

class CartItem: Product {
  let quantity: Int
  init?(name: String, quantity: Int) {
    if quantity < 1 { return nil }
    self.quantity = quantity
    super.init(name: name)
  }
}
```

`CartItem` 의 '실패 가능 초기자' 는 `1` 이상의 `quantity` 값을 받았는지 검증하는 것으로 시작합니다. `quantity` 가 무효하면, 전체 초기화 과정이 곧바로 실패하며 더 이상 초기화 코드를 실행하지 않습니다. 마찬가지로, `Product` 의 '실패 가능 초기자' 는 `name` 값을 검사하며, `name` 이 빈 문자열이면 초기화 과정이 곧바로 실패합니다.

이름이 비어있지 않고 수량이 `1` 이상인 `CartItem` 인스턴스를 생성하면, 초기화가 성공합니다:

```swift
if let twoSocks = CartItem(name: "sock", quantity: 2) {
  print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
// "Item: sock, quantity: 2" 를 인쇄합니다.
```

`quantity` 값이 `0` 인 `CartItem` 인스턴스를 생성하려고 하면, `CartItem` 초기자가 초기화를 실패하게 합니다:

```swift
if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
  print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
  print("Unable to initialize zero shirts")
}
// "Unable to initialize zero shirts" 를 인쇄합니다.
```

이와 비슷하게, 빈 `name` 값을 가진 `CartItem` 인스턴스를 생성하려고 하면, 상위 클래스인 `Product` 의 초기자가 초기화를 실패하게 합니다:

```swift
if let oneUnnamed = CartItem(name: "", quantity: 1) {
  print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
  print("Unable to initialize one unnamed product")
}
// "Unable to initialize one unnamed product" 를 인쇄합니다.
```

#### Overriding a Failable Initializer (실패 가능 초기자 재정의하기)

상위 클래스의 '실패 가능 초기자' 는, 다른 어떤 초기자들과 마찬가지로, 하위 클래스에서 재정의 할 수 있습니다. 대안으로, 상위 클래스의 '실패 가능 초기자' 를 하위 클래스의 '_실패하지 않는 (nonfailable)_ 초기자' 로 재정의할 수 있습니다. 이는, 상위 클래스의 초기화가 실패를 허용할지라도, 초기화가 실패하지 않는 하위 클래스를 정의할 수 있도록 해줍니다.

실패 가능한 상위 클래스 초기자를 실패하지 않는 하위 클래스 초기자로 재정의하는 경우, 상위 클래스로 '위로 위임' 하는 유일한 방법은 실패 가능한 상위 클래스 초기자의 결과를 '강제-포장 풀기 (force-unwrap)' 하는 것임을 기억하기 바랍니다.

> 실패 가능 초기자는 실패하지 않는 초기자로 재정의할 수 있지만 그 반대는 안됩니다.

아래 예제는 `Document` 라는 클래스를 정의합니다. 이 클래스는 비어있지 않은 문자열 값이나 `nil` 일 순 있지만, 빈 문자열일 수는 없는, `name` 속성으로 초기화할 수 있는 '문서 (document)' 를 모델링합니다:

```swift
class Document {
  var name: String?
  // 이 초기자는 nil 이라는 이름 값을 가진 문서를 생성합니다.
  init() {}
  // 이 초기자는 이름 값이 비어있지 않은 문서를 생성합니다.
  init?(name: String) {
    if name.isEmpty { return nil }
    self.name = name
  }
}
```

이 다음 예제는 `AutomaticNamedDocument` 라는 `Document` 의 하위 클래스를 정의합니다. `AutomaticNamedDocument` 하위 클래스는 `Document` 가 도입한 두 개의 지명 초기자 모두 재정의합니다. 이 재정의들은, 인스턴스를 이름 없이 초기화할 경우, 또는 `init(name:)` 초기자에 빈 문자열을 전달하는 경우, `AutomaticallyNamedDocument` 인스턴스가 `[Untitled]` 라는 '초기 `name` 값' 을 가지도록 보장합니다:

```swift
class AutomaticallyNamedDocument: Document {
  override init() {
    super.init()
    self.name = "[Untitled]"
  }
  override init(name: String) {
    super.init()
    if name.isEmpty {
      self.name = "[Untitled]"
    } else {
      self.name = name
    }
  }
}
```

`AutomaticNamedDocument` 는 상위 클래스의 '실패 가능 `init?(name:)` 초기자' 를 '실패하지 않는 `init(name:)`  초기자' 로 재정의합니다. `AutomaticNamedDocument` 는 상위 클래스와 다른 방식으로 빈 문자열을 처리하기 때문에, 초기자가 실패할 필요가 없으므로, 실패하지 않는 초기자 버전을 대신 제공합니다.

하위 클래스의 '실패하지 않는 초기자' 에서 상위 클래스에 있는 '실패 가능 초기자' 를 호출하기 위해 초기자에서 '강제 포장 풀기 (forced unwrapping)' 를 사용할 수 있습니다. 예를 들어, 아래의 `UntitledDocument` 하위 클래스는 항상 `"[Untitled]"` 라는 이름을 붙이며, 초기화 동안 상위 클래스의 '실패 가능 `init(name:)` 초기자' 를 사용합니다.

```swift
class UntitledDocument: Document {
  override init() {
    super.init(name: "[Untitled]")!
  }
}
```

이 경우, 상위 클래스의 `init(name:)` 초기자를 빈 문자열의 이름을 가지고 호출했다면, '강제 포장 풀기' 연산이 '실행시간 에러' 로 끝났을 것입니다. 하지만, 문자열 상수를 가지고 호출했기 때문에, 초기자가 실패하지 않을 거라는 것을, 그래서 이 경우 아무런 실행시간 에러도 일어날 수 없음을, 알 수 있습니다.

#### The `init!` Failable Initializer (`init!` 실패 가능 초기자)

적절한 타입의 옵셔널 인스턴스를 생성하는 '실패 가능 초기자' 는 전형적으로 `init` 키워드 뒤에 물음표를 붙여 (`init?` 처럼) 정의합니다. 대안으로, 적절한 타입의 '암시적으로 포장을 푸는 옵셔널 인스턴스' 를 생성하는 '실패 가능 초기자' 를 정의할 수 있습니다. 이는 `init` 키워드 뒤에 물음표 대신 느낌표를 붙여서 (`init!` 처럼) 합니다.

`init?` 에서 `init!` 로 또 그 반대로도 위임할 수 있으며, `init?` 를 `init!` 로 또 그 반대로도 재정의할 수 있습니다. `init` 에서 `init!` 으로 위임할 수도 있지만, 그렇게 하면 `init!` 초기자가 초기화를 실패하도록 할 경우 '단언문 (asssertion)' 을 발동할 것입니다.

### Required Initializers (필수 초기자)

클래스의 모든 하위 클래스가 해당 초기자를 반드시 구현하도록 지시하려면 클래스 초기자의 정의 앞에 `required` 수정자를 작성합니다:

```swift
class SomeClass {
  required init () {
    // 초기자 구현은 여기에 둡니다.
  }
}
```

필수 초기자의 모든 하위 클래스 구현 앞에도, 초기자 '필수 조건 (requirement)' 이 더 멀리 있는 연쇄망의 하위 클래스에도 적용됨을 지시하기 위해, 반드시 `required` 수정자를 작성해야 합니다. '필수 (required) 지명 초기자' 를 재정의할 때는 `override` 수정자를 작성하지 않습니다:

```swift
class SomeSubClass: SomeClass {
  required init () {
    // 필수 초기자의 하위 클래스 구현을 여기에 둡니다.
  }
}
```

> 상속한 초기자로 '필수 조건' 를 만족할 수 있는 경우에는 필수 조가자의 명시적인 구현을 제공하지 않아도 됩니다.

### Setting a Default Property Value with a Closure or Function (클로저나 함수로 기본 속성 값 설정하기)

저장 속성의 기본 값을 사용자 정의하거나 설정하는 것이 필수인 경우, 해당 속성에 사용자 정의 기본 값을 제공하기 위해 클로저나 전역 함수를 사용할 수 있습니다. 속성이 속한 타입에 대한 새로운 인스턴스를 초기화할 때마다, 클로저나 함수를 호출하여, 반환 값을 속성의 기본 값으로 할당합니다.

이런 종류의 클로저나 함수는 전형적으로, 속성과 똑같은 타입의 임시 값을 생성해서, 원하는 초기 상태를 표현하도록 값을 맞춘 다음, 속성의 기본 값으로 사용할 임시 값을 반환합니다.

다음은 클로저를 사용하여 기본 속성 값을 제공하는 방법에 대한 '뼈대' 입니다:

```swift
class SomeClass {
  let someProperty: SomeType = {
    // 이 클로저 안에서 속성을 위한 기본 값을 생성함
    // someValue 는 반드시 SomeType 과 같은 타입이어야 합니다.
    return someValue
  }()
}
```

클로저의 중괄호 끝에 빈 괄호 쌍이 붙어 있음을 기억하기 바랍니다. 이는 클로저를 곧바로 실행하라고 스위프트에게 말하는 것입니다. 이 괄호를 생략하면, 클로저의 반환 값이 아닌, 클로저 자체를 속성에 할당하는 것입니다.

> 속성을 초기화하기 위해 클로저를 사용하는 경우, 클로저를 실행한 시점에는 인스턴스의 나머지 부분이 아직 초기화되지 않았음을 떠올리도록 합니다. 이는, 해당 속성들이 기본 값을 가진 경우라도, 클로저 내에서 다른 어떤 속성 값에도 접근할 수 없다는 의미입니다. '암시적인 `self` 속성' 을 사용하거나, 어떤 인스턴스 메소드를 호출하는 것도 할 수 없습니다.

아래 예제는, '체스 게임판' 을 모델링하는, `Chessboard` 라는 구조체를 정의합니다. 체스는, 검은색과 흰색 정사각형이 번갈아 있는, 8x8 크기의 판에서 진행합니다.

![Chessboard](/assets/Swift/Swift-Programming-Language/Initialization-chessboard.png)

이 게임판을 표현하기 위해, `Chessboard` 구조체는, '64' 개의 `Bool` 값 배열인, `boardColors` 라는 단일 속성을 가집니다. 배열에서 `true` 값은 검은색 정사각형을 나타내며 `false` 값은 흰색 정사각형을 나타냅니다. 배열의 첫 번째 항목은 게임판의 맨 위 왼쪽 정사각형을 나타내며 배열의 마지막 항목은 게임판의 맨 아래 오른쪽 정사각형을 나타냅니다.

`boardColors` 배열은 자신의 색상 값을 설정하는 클로저를 가지고 초기화합니다.

```swift
struct Chessboard {
  let boardColors: [Bool] = {
    var temporaryBoard = [Bool]()
    var isBlack = false
    for i in 1...8 {
      for j in 1...8 {
        temporaryBoard.append(isBlack)
        isBlack = !isBlack
      }
      isBlack = !isBlack
    }
    return temporaryBoard
  }()
  func squareIsBlackAt(row: Int, column: Int) -> Bool {
    return boardColors[(row * 8) + column]
  }
}
```

새 `Chessboard` 인스턴스를 생성할 때마다, 클로저를 실행하여, `boardColors` 의 기본 값을 계산하고 반환합니다. 위 예제에 있는 클로저는 `temporaryBoard` 라는 임시 배열에 있는 게임판의 각 정사각형에 대해서 적절한 색상을 계산하고 설정하며, 설정을 한 번완료하고 나면 클로저의 반환 값으로 이 임시 배열을 반환합니다. 반환한 배열 값은 `boardColors` 에 저장하며 `squareIsBlackAt(row:column:)` 라는 '보조 함수' 로 조회할 수 있습니다:

```swift
let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
// "true" 를 인쇄합니다.
print(board.squareIsBlackAt(row: 7, column: 7))
// "false" 를 인쇄합니다.
```

### 다음 장

[Deinitialization (뒷정리) > ]({% post_url 2017-03-03-Deinitialization %})

### 참고 자료

[^Initialization]: 원문은 [Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^property-declaration]: 본문의 앞 부분인 [Setting Initial Values for Stored Properties (저장 속성에 대한 초기 값 설정하기)](#setting-initial-values-for-stored-properties-저장-속성에-대한-초기-값-설정하기) 를 보면, '기본 값' 을 속성의 '정의 (definition)' 에서 할 수 있다고 했다가, 여기서는 속성의 '선언 (declaration)' 에서 지정한다고 말하고 있는데, 이는 잘못된 것이 아닙니다. [Declarations (선언)]({% post_url 2020-08-15-Declarations %}) 장의 맨 처음을 읽어 보면, 스위프트에서는 대부분의 '선언' 이 '정의' 이기도 하기 때문에, 이 둘의 구분은 중요하지 않으며, 이 두 용어를 대부분 같은 의미로 사용한다고 설명하고 있습니다.

[^funnel]: 지명 초기자를 '깔대기' 에 비유한 것은 모든 초기화 과정이 일단 지명 초기자로 모인 다음 위쪽 상위 클래스로 연쇄되는 모습이 깔대기와 흡사하기 때문입니다.

[^convenience]: 이 부분은 원문 자체가 장황하게 설명되어 있는데, 결국 의미 자체는 번역한 문장과 대동소이 하므로, 짧게 줄여서 변역했습니다.

[^option]: 여기서 '옵션 (option)' 이라고 한 것은 인스턴스를 한 번 더 사용자 정의하는 것은 반드시 해야하는 것이 아니라 해도 되고 안해도 되는 '선택 사항 (option)' 이기 때문입니다.

[^base-class]: 스위프트에서 '기초 클래스 (base class)' 란 어떤 클래스로부터도 상속을 받지 않는 클래스를 말합니다. 보통 계층 구조에서 최상단에 위치하는 클래스는 다 기초 클래스라고 할 수 있지만, 계층 구조 없이 홀로 존재하는 클래스 역시 기초 클래스가 될 수 있습니다. 물론 여기서 프로토콜은 예외에 해당하며, 아무리 프로토콜을 많이 '준수 (conforming)' 하더라도 다른 클래스로부터 직접 상속을 받지 않으면 '기초 클래스' 에 해당합니다.  

[^base-class-in-hierachy]: 앞에서 '기초 클래스 (base class)' 란 어떤 클래스도 상속하지 않는 클래스라고 했는데, 계층 구조에서 이런 클래스는 최상단 클래스일 수 밖에 없습니다. 즉, 계층 구조의 '기초 클래스' 란 '최상단 클래스' 입니다.

[^default-member-initializer]: 여기서 '클래스들이 기본적인 멤버 초기자를 가지지 않는다' 고 복수형을 사용한 것은, '기초 클래스' 의 '저장 속성' 이 '기본 값' 을 가지고 있지 않기 때문에, 이 '기초 클래스' 의 모든 하위 클래스들도 '기본 값' 을 가지지 않게 되어, 계층 구조의 모든 클래스들이 '멤버 초기자' 를 자동으로 부여받지 않기 때문입니다. [Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)]({% post_url 2016-01-23-Initialization %}#memberwise-initializers-for-structure-types-구조체-타입을-위한-멤버-초기자) 에서 설명한 것처럼, 구조체라면 이런 경우에도 '멤버 초기자' 를 부여 받지만, '상속 계층' 을 사용하는 클래스는 이에 해당되지 않습니다.

[^function-name]: 사실 초기자는 함수 이름을 가지지 않는다기 보다 모든 함수 이름이 `init` 으로 똑같은 경우입니다. 이렇기 때문에, '함수 이름' 으로 초기자를 식별할 수 없으며 그래서 본문에서 '식별용 (identifying)' 함수 이름을 가지진 않는다고 표현한 것입니다.

[^automatic-argument-label]: '자동 인자 이름표 (automatic argument label)' 은 '매개 변수 이름' 이 자동으로 '인자 이름표' 가 되는 것을 말합니다.

[^argument-label]: 바로 위에서 스위프트의 초기자는 '자동 인자 이름표' 를 가진다고 했습니다. 그러므로, 초기자를 호출할 때는 반드시 '인자 이름표' 를 붙이는 것이 기본입니다. 그럼에도 불구하고, 본문에서 '인자 이름표 가 정의되어 있다면' 이라고 단서를 붙인 것은 바로 다음 부분에서 이어지는 '밑줄 (underscore; `_`)' 을 써서 '인자 이름표' 를 명시적으로 무시하는 것도 가능하기 때문입니다.

[^delegate-up]: 여기서 '상위 클래스 초기자' 로 '위로 위임 (delegate up)' 한다는 말은 '상위 클래스 초기자' 를 '호출' 한다는 것입니다. '위임' 은 '호출' 을 통해서 이루어지기 때문입니다.

[^final-class]: '최종 클래스 (final class)' 는 '상속 구조' 의 가장 밑에 있는 클래스를 말합니다. 스위프트에서 `final` 이라는 키워드는 원래 더 이상 상속을 하지 못하도록 하는 역할을 합니다.

[^exactly]: `init(exactly:)` 초기자를 사용하면 값이 정확하게 유지될 때만 타입을 변환합니다. 본문의 예제를 보면 `3.14159` 는 값을 유지하면서 `Int` 타입으로 변환할 수 없기 때문에 변환이 실패합니다.  
