---
layout: post
comments: true
title:  "Swift 5.3: Initialization (초기화)"
date:   2016-01-23 19:35:00 +0900
categories: Xcode Swift Grammar Initialization
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html) 부분[^Initialization]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

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

두 초기자 모두, 각각의 초기자 매개 변수에 '이름 있는 값 (named value)' 을 제공함으로써, 새로운 `Color` 인스턴스를 생성하는데 사용할 수 있습니다:

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

`ShoppingListItem` 클래스는 모든 속성이 기본 값을 가지고 있기 때문에, 그리고 '상위 클래스' 를 가지지 않는 '기본 클래스'[^base-class] 이기 때문에, `ShoppingListItem` 은 모든 속성을 기본 값으로 설정하는 것으로 새로운 인스턴스를 생성하는 '기본 초기자' 구현을 자동으로 가지게 됩니다. (`name` 속성은 '옵셔널 `String` 속성' 이므로, 코드에 값을 작성하지 않더라도, `nil` 이라는 기본 값을 자동으로 받습니다.) 위 예제는 `ShoppingListItem` 클래스가, `ShoppingListItem()` 라고 작성한, '초기자 구문 표현' 으로 클래스의 새로운 인스턴스를 생성하는데 '기본 초기자' 를 사용하며, 이 새 인스턴스를 `item` 이라는 변수에 할당합니다.

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

> 자신이 만든 값 타입이 '기본 초기자' 와 '멤버 초기자' 뿐 아니라, 자신만의 사용자 정의 초기자로도 초기화 가능하도록 하고 싶으면, 자신만의 사용자 정의 초기자를 값 타입의 원본 구현에서가 아니라 '익스텐션 (extension)' 에서 작성합니다. 더 많은 정보는, [Extensions (확장)]({% post_url 2016-01-19-Extensions %}) 을 참고하기 바랍니다.

다음 예제는 기하학적인 직사각형을 표현하는 사용자 정의 구조체인 `Rect` 를 정의합니다. 이 예제는 `Size` 와 `Point` 라는, 둘 다 모든 속성에 `0.0` 이라는 기본 값을 제공하는, 두 개의 '보조 구조체' 를 필수로 요구합니다:

```swift
struct Size {
  var width = 0.0, height = 0.0
}
struct Point {
  var x = 0.0, y = 0.0
}
```

아래의 `Rect` 구조체는-기본 값 '0' 으로 초기화된 `origin` 과 `size` 속성 값을 사용하거나, 또는 원점과 크기를 지정하거나, 아니면 중심 점과 크기를 지정하는-세 방법 중 하나로 초기화할 수 있습니다. 이 초기화 옵션들은 `Rect` 구조체의 정의에 있는 세 개의 '사용자 정의 초기자' 로써 표현됩니다:

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

> `init()` 과 `init(origin:size:)` 초기자를 직접 정의하지 않고도 이 예제를 작성하는 대안 방식은, [Extensions (확장)]({% post_url 2016-01-19-Extensions %}) 을 참고하기 바랍니다.

### Class Inheritance and Initialization (클래스 상속과 초기화)

클래스의 모든 저장 속성은-상위 클래스에서 상속한 어떤 속성이든 포함하여-초기화 동안 _반드시 (must)_ 초기 값을 할당해야 합니다.

스위프트는 클래스 타입이 모든 저장 속성에 초기 값을 부여했음을 보장하는 것을 돕기 위해 두 가지 종류의 초기자를 정의합니다. 이들을 '지명 (designated) 초기자' 와 '편의 (convenience) 초기자' 라고 합니다.

#### Designated Initializers and Convenience Initializers (지명 초기자와 편의 초기자)

_지명 초기자 (designated initializers)_ 는 클래스에 대한 제1의 초기자입니다. 지명 초기자는 해당 클래스가 도입한 모든 속성을 완전히 초기화하고 적당한 상위 클래스 초기자를 호출하여 위쪽 상위 클래스 연쇄망으로 초기화 과정을 계속 이어갑니다.

클래스는 아주 적은 수의 지명 초기자만 가지는 경향이 있으며, 사실 단 하나만 가지는 것이 일반적입니다. 지명 초기자는 이를 통해 초기화가 일어나고, 이를 통해 초기화 과정이 위쪽 상위 클래스 연쇄망으로 계속되는, 일종의 "깔때기 (funnel)"[^funnel] 같은 곳입니다.

모든 클래스는 최소한 하나의 지명 초기자를 반드시 가져야 합니다. 어떤 경우에, 이러한 '필수 조건 (requirement)' 은 상위 클래스로부터 하나 이상의 지명 초기자를 상속받음으로써 만족시킬 수 있으며, 이는 아래의 [Automatic Initializer Inheritance (자동적인 초기자 상속)](#automatic-initializer-inheritance-자동적인-초기자-상속) 에서 설명하도록 합니다.

_편의 초기자 (convenience initializers)_ 는 클래스에 대한 제2의, 보조용 초기자입니다. 편의 초기자는 동일한 클래스에 있는 지명 초기자의 일부 매개 변수에 기본 값을 설정하기 위해서 정의할 수 있습니다.[^convenience] 편의 초기자는 또 해당 클래스의 인스턴스를 특정한 용도나 특정한 입력 값 타입에 맞게 생성하기 위해서 정의할 수도 있습니다.

클래스가 꼭 필요한 것이 아니라면 편의 초기자를 제공하지 않아도 됩니다. '일반적인 초기화 유형 (common initialization pattern)' 을 '간략하게 만든 것 (shortcut)' 이 시간을 절약하거나 클래스 초기화의 의도를 명확하게 만들게 될 때마다 편의 초기자를 생성하기 바랍니다.

#### Syntax for Designated and Convenience Initializers (지명 초기자와 편의 초기자에 대한 구문 표현)

클래스에 대한 지명 초기자는 값 타입에 대한 단순한 초기자와 같은 방법으로 작성합니다:

```swift
init('parameters (매개 변수)') {
  'statements (구문)'
}
```

편의 초기자는 같은 스타일로 작성하지만, 공백으로 구분된, `convenience` 수정자를 `init` 키워드 앞에 붙입니다:

```swift
convenience init('parameters (매개 변수)') {
  'statements (구문)'
}
```

#### Initializer Delegation for Class Types (클래스 타입을 위한 초기자의 위임)

지명 초기자와 편의 초기자 사이의 관계를 단순화하기 위해, 스위프트는 초기자들 사이의 '위임 호출 (delegation calls)' 에 대해서 다음의 세 가지 규칙을 적용합니다:

**Rule 1 (규칙 1)**

  지명 초기자는 반드시 자신의 직속 상위 클래스의 지명 초기자를 호출해야 합니다.

**Rule 2 (규칙 2)**

  편의 초기자는 반드시 _같은 (same)_ 클래스에 있는 다른 초기자를 호출해야 합니다.

**Rule 3 (규칙 3)**

  편의 초기자는 궁극적으로 반드시 지명 초기자를 호출해야 합니다.

다음 처럼 생각하면 기억하기 쉽습니다:

* 지명 초기자는 반드시 항상 _위로 (up)_ 위임합니다.
* 편의 초기자는 반드시 항상 _옆으로 (across)_ 위임합니다.

이 규칙을 그려보면 다음 그림과 같습니다:

![delegation rules](/assets/Swift/Swift-Programming-Language/Initialization-delegation-rules.jpg)

여기서, 상위 클래스는 한 개의 지명 초기자와 두 개의 편의 초기자를 가지고 있습니다. 편의 초기자 하나가 다른 편의 초기자를 호출하고 있으며, 그 다음 차례로 단일 지명 초기자를 호출하고 있습니다. 이는 위에 있는 '규칙 2' 와 '규칙 3' 을 만족시킵니다. 이 상위 클래스는 더 위의 상위 클래스를 가지지 않으므로, '규칙 1' 은 적용하지 않습니다.

이 그림에 있는 하위 클래스는 두 개의 지명 초기자와 한 개의 편의 초기자를 가지고 있습니다. 이 편의 초기자는 두 개의 지명 초기자 중 하나를 반드시 호출해야 하는데, 왜냐면 같은 클래스의 다른 초기자만을 호출할 수 있기 때문입니다. 이는 위에 있는 '규칙 2' 와 '규칙 3' 을 만족시킵니다. 두 개의 지명 초기자 모두 상위 클래스에 있는 단일한 지명 초기자를 반드시 호출해야, 위에 있는 '규칙 1' 을 만족시키게 됩니다.

> 이 규칙은 클래스의 사용자가 각 클래스의 인스턴스를 _생성하는 (create)_ 방법에는 영향을 주지 않습니다. 위 도표에 있는 초기자라면 어떤 것을 사용해도 자기가 속한 클래스에 대한 완전히 초기화된 인스턴스를 생성할 수 있습니다. 이 규칙은 클래스 초기자의 구현부를 작성하는 방법에만 영향을 미치는 것입니다.

아래 그림은 네 개의 클래스로 된 좀 더 복잡한 클래스 계층 구조를 보여줍니다. 이는 계층 구조에 있는 지명 초기자가 어떻게 클래스 초기화에 대한, 연쇄망에 있는 클래스 간의 상관 관계를 단순화 하는, "깔때기 (funnel)" 와 같은 역할을 하게 되는 지를 묘사합니다.

![funnel points](/assets/Swift/Swift-Programming-Language/Initialization-funnel.png)

#### Two-Phase Initialization (2-단계 초기화)

스위프트의 클래스 초기화는 '2-단계 (two-phase)' 과정으로 되어 있습니다. 첫 번째 단계는, 각 저장 속성에 이를 도입한 클래스가 초기 값을 할당하는 것입니다. 일단 이렇게 모든 저장 속성에 대한 초기 상태를 결정하고 나면, 두 번째 단계를 시작하며, 이 때 각각의 클래스는 새 인스턴스를 사용할 준비를 끝내기 전에 자신의 저장 속성을 한번 더 사용자 정의할 기회를 가집니다.

2-단계 초기화 과정을 사용하면, 클래스 계층 구조에 있는 각 클래스에 완전한 유연성을 부여 하면서도, 초기화를 안전하도록 만들어 줍니다. 2-단계 초기화는 초기화되기 전에 속성 값에 접근하는 것도 막아 주고, 예상치 못하게 속성 값이 또 다른 초기자에 의해 엉뚱한 값으로 설정되어 버리는 것도 막아줍니다.

> 스위프트의 2-단계 초기화 과정은 오브젝티브-C 언어의 초기화와 비슷합니다. 주요 차이점이라면 1 단계를 진행하는 동안, 오브젝티브-C 언어는 모든 속성에 '0' 또는 'null' (가령 `0` 이나 `nil` 같은) 값을 할당한다는 것입니다. 스위프트의 초기화 흐름은, 사용자가 자신만의 초기 값을 설정할 수 있으며, `0` 이나 `nil` 이 기본 값으로 유효하지 않은 타입에도 대처할 수 있다는 점에서 좀 더 유연합니다.

스위프트 컴파일러는 2-단계 초기화가 에러없이 완료되었음을 확인하기 위해 네 가지의 도움이 될 만한 '안전성-검사 (safety-checks)' 를 수행합니다:

**Safety Check 1 (안전성 검사 1)**

  지명 초기자는 위쪽 상위 클래스로 위임하기 전에 자신의 클래스가 도입한 속성이 모두 초기화되었다는 것을 반드시 보장해야 합니다.

저 위에서 언급한 것처럼, 객체의 메모리는 일단 모든 저장 속성의 초기 상태를 알게 되면 완전히 초기화된 것으로 간주합니다. 이 규칙을 만족하려면, 지명 초기자가 연쇄망 위로 작업을 넘기기 전에 자신이 가진 속성이 모두 초기화되었다는 것을 반드시 확인해줘야 합니다.

**Safety Check 2 (안전성 검사 2)**

  지명 초기자는 상속받은 속성에 값을 할당하기 전에 위쪽 상위 클래스로 위임을 반드시 해야 합니다. 그렇게 하지 않으면, 지명 초기자가 할당하는 새 값이 상위 클래스의 자체 초기화로 인해 덮어 써지게 됩니다.

**Safety Check 3 (안전성 검사 3)**

  편의 초기자는 (동일 클래스에서 정의된 속성을 포함하여) _어떤 (any)_ 속성에든 값을 할당하기 전에 다른 초기자로 위임을 반드시 해야 합니다. 그렇게 하지 않으면, 편의 초기자가 할당하는 새 값이 자기가 있는 클래스의 지명 초기자에 의해 덮어 써지게 됩니다.

**Safety Check 4 (안전성 검사 4)**

  초기자는, 초기화의 첫 단계를 완료하기 전까지, 인스턴스 메소드를 호출하거나, 인스턴스 속성의 값을 읽거나, 아니면 `self` 를 값처럼 참조하는 것 등을 할 수 없습니다.

클래스 인스턴스는 첫 단계가 끝나기 전에는 완전하게 유효한 것이 아닙니다. 일단 첫 단계가 끝나서 클래스 인스턴스가 유효하다는 것을 알아야만, 비로소 속성에 접근할 수도 있고, 메소드를 호출할 수도 있습니다.

다음은, 위의 네 개의 안전성 검사를 기초로, 2-단계 초기화를 끝까지 마치는 방법입니다:

**Phase 1 (단계 1)**

* 클래스에 대한 지명 초기자 또는 편의 초기자를 호출합니다.
* 해당 클래스의 새 인스턴스를 위한 메모리가 할당됩니다. 이 메모리는 아직 초기화된 것이 아닙니다.
* 해당 클래스의 지명 초기자는 이 클래스가 도입한 모든 저장 속성이 값을 가지고 있음을 확정합니다. 이 저장 속성에 대한 메모리는 이제 초기화된 것입니다.
* 지명 초기자는 상위 클래스의 초기자도 자신이 가진 저장 속성에 대해 같은 작업을 수행할 수 있도록 작업을 넘겨줍니다.
* 이렇게 클래스 상속 연쇄망을 올라가는 것을 연쇄망의 최상단에 도달할 때까지 계속합니다.
* 일단 연쇄망의 최상단에 도달했고, 연쇄망에 있는 '최종 클래스 (final class)' 가 자신의 모든 저장 속성이 값을 가지고 있음을 보장하고 나면, 인스턴스의 메모리는 완전히 초기화된 것으로 간주되며, 1 단계를 완료합니다.

**Phase 2 (단계 2)**

* 연쇄망의 최상단에서 거꾸로 내려 가면서, 연쇄망에 있는 각각의 지명 초기자는 추가로 인스턴스를 사용자 정의할 수 있는 '기회 (option)'[^option]를 가집니다. 초기자는 이제 `self` 에 접근할 수 있으므로 자신의 속성을 수정하거나, 자신의 인스턴스 메소드를 호출하는, 등의 일을 할 수 있습니다.
* 마지막으로, 연쇄망에 있는 모든 편의 초기자들이 `self` 를 사용하여 인스턴스를 사용자 정의할 기회를 가집니다.

다음은 1 단계에서 가상의 하위 클래스와 상위 클래스에 대한 초기화 호출이 어떻게 보이는 지를 나타냅니다:

![Phase 1](/assets/Swift/Swift-Programming-Language/Initialization-delegation-phase-1.jpg)

이 예제의, 초기화는 하위 클래스의 편의 초기자를 호출하는 것으로 시작합니다. 이 편의 초기자는 아직 속성을 수정할 수 없습니다. 이는 동일한 클래스에 있는 자기 옆 지명 초기자로 위임을 합니다.

지명 초기자는, 안전성 검사 1에 따라, 하위 클래스의 모든 속성이 값을 가지고 있는 지 확인해 줍니다. 그런 다음 초기화를 연쇄망 위로 계속하기 위하여 자신의 상위 클래스에 있는 지명 초기자를 호출합니다.

상위 클래스의 지명 초기자는 상위 클래스의 모든 속성이 값을 가지고 있는 지 확인해 줍니다. 이제 초기화할 상위 클래스가 더 없으므로, 위임을 더 할 필요가 없습니다.

상위 클래스의 모든 속성들이 초기 값을 가지자 마자, 이 메모리는 완전히 초기화된 것으로 간주되며, 1 단계를 완료하게 됩니다.

다음은 2 단계에서 동일한 초기화 호출이 어떻게 보이는 지를 나타냅니다:

![Phase 2](/assets/Swift/Swift-Programming-Language/Initialization-delegation-phase-2.png)

상위 클래스의 지명 초기자는 이제 (꼭 해야만 하는 것은 아니더라도) 인스턴스를 좀 더 사용자 정의할 기회를 가집니다.

일단 상위 클래스의 지명 초기자가 작업을 마치면, 하위 클래스의 지명 초기자도 추가적인 사용자 정의를 수행할 수 있습니다. (다시 한 번 얘기하지만, 꼭 해야하는 것은 아닙니다).

마지막으로, 하위 클래스의 지명 초기자가 작업을 마치면, 원래 호출되었던 편의 초기자가 추가적인 사용자 정의 작업을 수행할 수 있게 됩니다.

#### Initializer Inheritance and Overriding (초기자 상속 및 재정의)

오브젝티브-C 언어의 하위 클래스와는 다르게, 스위프트 하위 클래스는 기본적으로 자신의 상위 클래스에 있는 초기자를 상속받지 않습니다. 스위프트의 접근 방식은 상위 클래스에 있는 간단한 초기자를 더 특수한 하위 클래스가 상속 받는 바람에 하위 클래스의 새로운 인스턴스를 완전하고 올바르게 초기화 하지 못하는 상황이 발생하는 것을 막아줍니다.

> 상위 클래스 초기자는 정해진 상황에서는 상속이 _되는데 (are)_, 단 그것도 안전하면서 적절한 상황에서만 되는 것입니다. 더 자세한 정보는, [Automatic Initializer Inheritance (자동적인 초기자 상속)](#automatic-initializer-inheritance-자동적인-초기자-상속) 을 참고하기 바랍니다.  

사용자 정의 하위 클래스에 상위 클래스에 있는 것과 똑같은 초기자를 주고 싶을 경우, 하위 클래스에서 해당 초기자에 대한 사용자 구현을 제공할 수 있습니다.

하위 클래스 초기자를 작성할 때 상위 클래스의 _지명 (designated)_ 초기자와 일치하는 경우, 이는 사실상 해당 지명 초기자에 대한 '재정의 (override)' 를 제공하는 것입니다. 그러므로, 하위 클래스의 초기자 정의 앞에 반드시 `override` 수정자를 붙여줘야 합니다. 이는, [Default Initializers (기본 초기자)](#default-initializers-기본-초기자) 에서 설명한 것처럼, 자동으로 제공되는 '기본 설정 초기자' 를 재정의하는 경우에도 마찬가지 입니다.

재정의된 속성, 메소드, 및 첨자 연산에서와 같이, `override` 수정자가 있다는 것은 스위프트를 재촉하여 상위 클래스가 재정의된 것과 일치하는 지명 초기자를 가지고 있는지 검사하도록 하며, 재정의한 초기자에 대한 매개 변수가 의도한대로 지정되었는 지를 입증합니다.

> 상위 클래스의 지명 초기자를 재정의할 때는 항상 `override` 수정자를 붙여줘야 하는데, 이는 하위 클래스에서 그 초기자를 편의 초기자로 구현하더라도 그렇습니다.

거꾸로 말해서, 상위 클래스의 _편의 (convenience)_ 초기자와 일치하는 하위 클래스의 초기자를 작성할 경우, 해당 상위 클래스의 편의 초기자는, 위의 [Initializer Delegation for Class Types (클래스 타입을 위한 초기자의 위임)](#initializer-delegation-for-class-types-클래스-타입을-위한-초기자의-위임) 에서 설명한 규칙에 따라, 절대로 하위 클래스가 직접 호출할 수 없습니다. 그러므로, 이 하위 클래스는 (엄밀하게 말해서) 상위 클래스 초기자의 '재정의 (override)' 를 제공하는 것이 아닙니다. 결과적으로, 상위 클래스의 편의 초기자와 일치하는 구현을 제공할 때는 `override` 수정자를 붙이지 않습니다.

아래 예제는 `Vehicle` 이라는 '기본 클래스 (base class)'[^base-class] 를 정의합니다. 이 기본 클래스는, `0` 인 기본 설정 `Int` 값을 가지는, `numberOfWheels` 라는 저장 속성을 선언합니다. `description` 이라는 계산 속성이 차량 성질에 대한 `String` 타입의 설명을 생성하는데 이 `numberOfWheels` 속성을 사용합니다:

```swift
class Vehicle {
  var numberOfWheels = 0
  var description: String {
    return "\(numberOfWheels) wheel(s)"
  }
}
```

`Vehicle` 클래스는 하나 뿐인 저장 속성에 대해 기본 값을 제공하며, 자기 스스로는 어떤 초기자도 제공하지 않습니다. 결과적으로, [Default Initializers (기본 초기자)](#default-initializers-기본-초기자) 에서 설명한대로, 자동으로 기본 설정 초기자를 부여 받습니다. 기본 설정 초기자는 (사용 가능한 경우) 항상 클래스에 대한 '지명 초기자' 이며, 이를 사용하여 `numberOfWheels` 가 `0` 인 새로운 `Vehicle` 인스턴스를 생성할 수 있습니다:

```swift
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")
// Vehicle: 0 wheel(s)
```

그 다음은 `Bicycle` 이라는 `Vehicle` 의 하위 클래스를 정의하는 예제입니다:

```swift
class Bicycle: Vehicle {
  override init() {
    super.init()
    numberOfWheels = 2
  }
}
```

이 `Bicycle` 하위 클래스는 사용자 정의 지명 초기자인, `init()` 를 정의합니다. 이 지명 초기자는 `Bicycle` 의 상위 클래스에 있는 지명 초기자와 일치하므로, 이 초기자의 `Bicycle` 버전은 `override` 수정자로 표시됩니다.

`Bicycle` 의 `init()` 초기자는, `Bicycle` 클래스의 상위 클래스에 대한 기본 설정 초기자의 호출인, `super.init()` 을 호출하는 것으로 시작합니다. 이는 `Bicycle` 이 상속받은 속성인 `numberOfWheels` 을 수정할 기회를 가지기 전에 이 속성을 `Vehicle` 이 먼저 초기화하도록 보장해 줍니다. `super.init()` 를 호출한 후, `numberOfWheels` 의 원래 값을 새로운 값인 `2` 로 대체합니다.

`Bicycle` 의 인스턴스를 생성하면, 상속받은 계산 속성인 `description` 을 호출하여 `numberOfWheels` 속성이 어떻게 갱신됐는지 확인할 수 있습니다:

```swift
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")
// Bicycle: 2 wheel(s)
```

하위 클래스의 초기자가 초기화 과정의 2 단계에서 아무런 사용자 정의를 수행하지 않으면서, 상위 클래스가 '인자가-전혀 없는 (zero-argument)' 지명 초기자를 가지고 있는 경우, 하위 클래스의 모든 저장 속성에 값을 할당한 후 `super.init()` 에 대한 호출을 생략할 수 있습니다.

다음 예제는, `Hoverboard` 라는, `Vehicle` 의 또 다른 하위 클래스를 정의합니다. 자신의 초기자 내에서, `Hoverboard` 클래스는 `color` 속성만 설정합니다. 이 초기자는 (초기화) 과정을 완료하기 위해, `super.init()` 를 명시적으로 호출하는 대신, 상위 클래스에 대한 암시적인 호출에 의지하고 있습니다.

```swift
class Hoverboard: Vehicle {
  var color: String
  init(color: String) {
    self.color = color
    // 여기서 super.init() 를 암시적으로 호출합니다.
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

> 하위 클래스는 초기화 동안 상속받은 변수 속성을 수정할 수는 있지만, 상속받은 상수 속성을 수정할 수는 없습니다.

#### Automatic Initializer Inheritance (자동적인 초기자 상속)

위에서 언급한 대로, 하위 클래스가 상위 클래스의 초기자를 기본적으로 상속받는 것은 아닙니다. 하지만, 정해진 조건을 만족한다면 상위 클래스의 초기자를 자동으로 상속 받게 _됩니다 (are)_. 이는 실제로, 많은 일반적인 상황에서 초기자를 '재정의 (override)' 할 필요가 없으며, 안전하기만 하다면 언제든 최소의 노력으로 상위 클래스의 초기자를 상속받을 수 있음을 의미합니다.

하위 클래스에서 도입한 새로운 속성마다 기본 값을 제공했다고 가정할 경우, 다음의 두 규칙이 적용됩니다:

**Rule 1 (규칙 1)**

  하위 클래스가 어떤 지명 초기자도 정의하지 않은 경우, 상위 클래스 모든 지명 초기자를 자동으로 상속 받습니다.

**Rule 2 (규칙 2)**

  하위 클래스가 상위 클래스의 _모든 (all)_ 지명 초기자에 대한 구현을 제공할 경우-'규칙 1' 에 의해 상속을 받은 것이든, 정의 부분에서 직접 구현을 제공한 것이든 상관없이-그러면 상위 클래스의 모든 편의 초기자를 자동으로 상속 받습니다.

이 규칙들은 하위 클래스에서 편의 초기자를 더 추가한 경우에도 그대로 적용됩니다.

> 하위 클래스는 '규칙 2' 를 만족시키기 위한 한 방편으로 상위 클래스의 지명 초기자를 하위 클래스에서 편의 초기자로 구현할 수 있습니다.

#### Designated and Convenience Initialization in Action (지명 초기자와 편의 초기자의 실제 사례)

다음 예제는 지명 초기자, 편의 초기자, 그리고 '자동적인 초기자 상속' 에 대한 실제 사례를 보입니다. 이 예제는 `Food`, `RecipeIngredient`, 그리고 `ShoppingListItem` 이라는 세 개의 클래스로 된 계층 구조를 정의하고, 이 초기자들이 어떻게 상호 작용하는 지를 보여줍니다.

계층 구조에 있는 기본 클래스[^base-class-in-hierachy]는 `Food` 라고 하는데, 식료품의 이름을 '은닉하는 (encapsulate)' 간단한 클래스입니다. `Food` 클래스는 `name` 이라는 단 하나의 `String` 속성을 도입하며 `Food` 인스턴스를 생성하기 위한 두 개의 초기자를 제공합니다:

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

아래의 그림은 `Food` 클래스에 대한 '초기자 연쇄망 (initializer chain)' 을 보여줍니다:

![Initializer chain for the Food](/assets/Swift/Swift-Programming-Language/Initialization-chain-for-food.png)

(예제의) 클래스들은 기본 멤버 초기자를 가지지 않으므로[^example], `Food` 클래스는 `name` 이라는 단일 인자를 받는 지명 초기자를 제공합니다. 이 초기자를 사용하여 지정된 이름을 가진 새로운 `Food` 인스턴스를 생성할 수 있습니다:

```swift
let namedMeat = Food(name: "Bacon")
// namedMeat 의 이름은 "Bacon" 입니다.
```

`Food` 클래스에 있는 `init(name: String)` 초기자를 _지명 (designated)_ 초기자로 제공한 것은, 새로운 `Food` 인스턴스의 모든 저장 속성이 완전히 초기화 되었음을 보장해야 하기 때문입니다. `Food` 클래스는 상위 클래스를 가지고 있지 않으므로, `init(name: String)` 초기자는 초기화를 완료하기 위해 `super.init()` 을 호출할 필요가 없습니다.

`Food` 클래스는, 인자가 없는, _편의 (convenience)_ 초기자도 제공합니다. `init()` 초기자는 `Food` 클래스의 `init(name: String)` 에 위임하면서 `name` 값을 `[Unnamed]` 라고 하여 새로운 음식에 대한 자리지킴이 용도의 이름을 제공합니다:

```swift
let mysteryMeat = Food()
// mysteryMeat 의 이름은 "[Unnamed]" 입니다.
```

계층 구조에 있는 두 번째 클래스는 `Food` 의 하위 클래스인 `RecipeIngredient` 입니다. `RecipeIngredient` 클래스는 요리 조리법에 있는 재료를 모델링한 것입니다. 이는 (`Food` 에서 상속받은 `name` 속성에 더하여) `quantity` 라는 `Int` 속성을 도입하며 `RecipeIngredient` 인스턴스를 생성하기 위한 두 개의 초기자를 정의합니다:

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

아래 그림은 `RecipeIngredient` 클래스에 대한 '초기자 연쇄망 (initializer chain)' 을 보여줍니다:

![Initializer chain for the RecipeIngredient](/assets/Swift/Swift-Programming-Language/Initialization-chain-for-recipe.png)

`RecipeIngredient` 클래스는, `init(name: String, amount: Int)` 라는, 단 하나의 지명 초기자를 가지고, 새로운 `RecipeIngredient` 인스턴스의 모든 속성들을 정착시킵니다. 이 초기자는 전달받은 `quantity` 인자를 `quantity` 속성에 할당하는 것으로 시작하는데, 이는 `RecipeIngredient` 가 도입한 유일한 새 속성입니다. 그런 후에, 이 초기자는 위로 위임하고자 `Food` 클래스의 `init(name: String)` 초기자를 호출합니다. 이 과정은 위의 [Two-Phase Initialization (2-단계 초기화)](#two-phase-initialization-2-단계-초기화) 에 있는 '안전성 검사 2' 를 만족시킵니다.

`RecipeIngredient` 는, `init(name: String)` 라는, 편의 초기자도 정의하고 있는데, 이를 사용하면 이름만 가지고 `RecipeIngredient` 인스턴스를 생성할 수 있습니다. 이 편의 초기자는 수량을 명시하지 않은 채로 생성하는 `RecipeIngredient` 인스턴스는 수량이 `1` 이라고 가정합니다. 편의 초기자를 이렇게 정의하면 `RecipeIngredient` 인스턴스를 더 빠르고 편리하게 생성하도록 해주며, 수량-한 개 짜리 `RecipeIngredient` 인스턴스를 여러 개 생성할 때의 코드 중복을 피하도록 해줍니다. 이 편의 초기자는 단순히 옆으로 위임하며 클래스의 지명 초기자에, `1` 이라는 `quantity` 값을 전달합니다.

`RecipeIngredient` 가 제공하는 `init(name: String)` 편의 초기자는 `Food` 에 있는 `init(name: String)` _지명 (designated)_ 초기자와 같은 매개 변수를 받아 들입니다. 이 편의 초기자는 상위 클래스에 있는 지명 초기자를 '재정의 (override)' 하고 있기 때문에, ([Initializer Inheritance and Overriding (초기자 상속 및 재정의)](#initializer-inheritance-and-overriding-초기자-상속-및-재정의) 에서 설명한 것처럼) 반드시 `override` 수정자로 표시해야 합니다.

비록 `RecipeIngredient` 가 `init(name: String)` 초기자를 편의 초기자로 제공하긴 했지만, `RecipeIngredient` 는 그럼에도 불구하고 모든 상위 클래스의 지명 초기자에 대한 구현을 제공했습니다. 따라서, `RecipeIngredient` 는 상위 클래스의 모든 편의 초기자를 자동으로 상속받습니다.

이 예제에서, `RecipeIngredient` 의 상위 클래스는 `Food` 이며, 이는 `init()` 이라는 단 하나의 편의 초기자를 가지고 있습니다. 이 초기자가 `RecipeIngredient` 로 상속되는 것입니다. `init()` 의 상속 버전은, `Food` 버전이 아니라 `RecipeIngredient` 버전의 `init(name: String)` 으로 위임한다는 것만 빼면, `Food` 버전과 동작 방식이 정확하게 똑같습니다.

이 초기자 세 개 모두 새로운 `RecipeIngredient` 인스턴스를 생성하는데 사용할 수 있습니다:

```swift
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
```

계층 구조의 세 번째이자 최종 클래스는 `RecipeIngredient` 의 하위 클래스인 `ShoppingListItem` 입니다. `ShoppingListItem` 클래스는 구매 목록에 표시되는 요리 재료를 모델링합니다.

구매 목록에 있는 모든 항목은 "미구매 (unpurchased)" 상태로 시작합니다. 이러한 사실을 표현하기 위해, `ShoppingListItem` 은 `purchased` 라는, 기본 값이 `false` 인, '불리언 (Boolean)' 속성을 도입합니다. `ShoppingListItem` 은 또 `description` 계산 속성을 추가하여, `ShoppingListItem` 인스턴스에 대한 설명을 제공합니다:

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

> `ShoppingListItem` 은 `purchased` 에 초기 값을 제공하기 위한 초기자를 정의하지 않는데, 이는 구매 목록에 있는 항목들은 (여기서 모델링한 것처럼) 항상 미구매 상태로 시작하기 때문입니다.

자신이 도입한 모든 속성에 대해 기본 값을 제공하면서 스스로는 아무런 초기자도 정의하지 않고 있으므로, `ShoppingListItem` 은 상위 클래스에 있는 _모든 (all)_ 지명 초기자와 편의 초기자를 자동으로 상속받습니다.

이 속성은 도입 한 모든 속성에 기본값을 제공하고 초기화 프로그램 자체를 정의하지 않기 때문에 ShoppingListItem은 자동으로 지정된 및 편리한 초기화 프로그램을 모두 수퍼 클래스에서 상속합니다.

아래 그림은 세 클래스 모두 연관된 전체적인 '초기자 연쇄망 (initializer chain)' 을 보여줍니다:

![Initializer chain for the all](/assets/Swift/Swift-Programming-Language/Initialization-chain-for-all.png)

이 상속받은 초기자 세 개 모두 새로운 `RecipeIngredient` 인스턴스를 생성하는데 사용할 수 있습니다:

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

여기서는, 세 개의 새로운 `ShoppingListItem` 인스턴스를 담고 있는 '배열 글자 값 (array literal)' 을 사용하여 `breakfastList` 라는 새로운 배열을 생성합니다. 배열의 타입은 `[ShoppingListItem]` 이라고 추론됩니다. 배열을 생성한 후에는, 배열 맨 처음에 있는 `ShoppingListItem` 의 이름을 `"[Unnamed]"` 에서 `"Orange juice"` 로 바꾸고 구매한 것으로 표시합니다. 배열에 있는 각 항목의 설명을 출력해보면 이들의 기본 설정 상태가 예상한 대로 설정 되었는지를 보여줍니다.

### Failable Initializers (실패 가능한 초기자)

때로는 초기화가 실패할 수도 있는 클래스, 구조체, 또는 열거체를 정의한다면 좋을 것입니다. 이러한 실패는 무효한 초기화 매개 변수 값에 의해서거나, 필수적인 외부 소스가 없어서 이거나, 아니면 어떤 다른 조건이 초기화가 성공하는 것을 막고 있기 때문에 발생할 수 있을 겁니다.

실패할 수도 있는 초기화 조건에 대처하려면, 클래스, 구조체, 또는 열거체의 정의 부분에서 하나 이상의 '실패 가능한 초기자 (failable initializers)' 를 정의하면 됩니다. 실패 가능한 초기자는 `init` 키워드 뒤에 물음표 기호를 붙여서 (`init?` 라고) 작성합니다.

> '실패 가능한 (failable) 초기자' 와 '실패하지 않는 (nonfailable) 초기자' 를 똑같은 매개 변수 타입과 이름을 가지고 정의할 수는 없습니다.

실패 가능한 초기자는 초기화하는 타입에 대한 _옵셔널 (optional)_ 값을 생성합니다. 실패 가능한 초기자 내에서 `return nil` 을 작성하면 초기화 실패가 발생한 지점을 지시할 수 있습니다.

> 엄밀하게 말해서, 초기자는 값을 반환하지 않습니다. 그 보다, 이들의 역할은 초기화가 끝날 때까지 `self` 가 완전하고 올바르게 초기화되도록 보장하는 것입니다. 비록 초기화 실패를 발생시키기 위해 `return nil` 을 작성한다고 하더라도, 초기화 성공을 나타내기 위해 `return` 키워드를 사용하지는 않습니다.

실제 사례로써, 수치 타입 변환을 위한 실패 가능한 초기자를 구현합니다. 수치 타입 사이의 변환이 값을 정확하게[^exactly] 유지하고 있다는 보장을 하기 위해, `init(exactly:)` 초기자를 사용합니다. 타입 변환이 값을 유지할 수 없는 경우, 이 초기자는 실패합니다.

```swift
let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
  print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}
// "12345.0 conversion to Int maintains value of 12345" 를 출력합니다.

let valueChanged = Int(exactly: pi)
// valueChanged 의 타입은 Int? 이며, Int 인 것이 아닙니다.

if valueChanged == nil {
  print("\(pi) conversion to Int does not maintain value")
}
// "3.14159 conversion to Int does not maintain value" 를 출력합니다.
```

아래 예제는, `species` 라는 상수 `String` 속성을 가지는, `Animal` 이라는 구조체를 정의합니다. 이 `Animal` 구조체는 또 `species` 라는 단일한 매개 변수를 가지는 '실패 가능한 초기자' 도 정의합니다. 이 초기자는 초기자로 전달된 `species` 값이 빈 문자열인지 검사합니다. 빈 문자열을 발견하면, 초기화 실패를 발생시킵니다. 그렇지 않으면, `species` 속성에 값을 설정하고, 초기화는 성공합니다:

```swift
struct Animal {
  let species: String
  init?(species: String) {
    if species.isEmpty { return nil }
    self.species = species
  }
}
```

이러한 실패 가능한 초기자를 사용하면 새로운 `Animal` 인스턴스에 대한 초기화를 시도하고 초기화가 성공했는지를 확인할 수 있습니다:

```swift
let someCreature = Animal(species: "Giraffe")
// someCreature 의 타입은 Animal? 이며, Animal 이 아닙니다.

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
// "An animal was initialized with a species of Giraffe" 를 출력합니다.
```

실패 가능한 초기자의 `species` 매개 변수에 빈 문자열 값을 전달하면, 이 초기자는 초기화 실패를 발생합니다:

```swift
let anonymousCreature = Animal(species: "")
// anonymousCreature 의 타입은 Animal? 이며, Animal 이 아닙니다.

if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}
// "The anonymous creature could not be initialized" 를 출력합니다.
```

> 빈 문자열 값 (가령 `"Giraffe"` 가 아닌 `""`) 을 검사하는 것은 _옵셔널 (optional)_ `String` 값의 부재를 나타내는 `nil` 을 검사하는 것과 같은 것이 아닙니다. 위 예제에서, 빈 문자열 (`""`) 은 유효한 것으로, 옵셔널이-아닌 `String` 인 것입니다. 하지만, 동물의 `species` 속성 값이 빈 문자열을 가진다는 것은 적절한 것이 아닙니다. 이러한 제약 조건을 모델링하기 위해, 실패 가능한 초기자는 빈 문자열을 발견하면 초기화 실패를 발생시킵니다.

#### Failable Initializers for Enumerations (열거체를 위한 실패 가능한 초기자)

실패 가능한 초기자는 하나 이상의 매개 변수를 기반으로 적절한 '열거체 case 값 (enumeration case)' 을 선택하기 위해 사용할 수 있습니다. 제공된 매개 변수가 '열거체 case 값' 과 적당하게 일치하는 게 없다면 이 때 초기자는 실패할 수 있습니다.

아래 예제는, 세 개의 상태가 가능한 (`kelvin`, `celsius`, 그리고 `fahrenheit`), `TemperatureUnit` 이라는 열거체를 정의합니다. 실패 가능한 초기자를 사용하여 '온도 기호 (temperature symbol)' 를 나타내는 `Character` 값에 해당하는 적절한 '열거체 case 값' 를 찾습니다:

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

이 실패 가능한 초기자를 사용하면 가능한 세 개의 상태 중에서 적당한 '열거체 case 값' 을 선택할 수도 있고 매개 변수가 이 상태 세 개와 일치하지 않을 경우 초기화의 실패를 일으킬 수도 있습니다:

```swift
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
  print("This is a defined temperature unit, so initialization succeeded.")
}
// "This is a defined temperature unit, so initialization succeeded." 를 출력합니다.

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
  print("This is not a defined temperature unit, so initialization failed.")
}
// "This is not a defined temperature unit, so initialization failed." 를 출력합니다.
```

#### Failable Initializers for Enumerations with Raw Values (원시 값을 가지는 열거체를 위한 실패 가능한 초기자)

원시 값을 가지는 열거체는, `init?(rawValue:)` 라는, '실패 가능한 초기자' 를 자동으로 부여 받는데, 이는 `rawValue` 라는 적당한 원시-값 타입의 매개 변수를 받아서 일치하는 값을 찾으면 해당하는 '열거체 case 값' 을 선택하고, 일치하는 값이 존재하지 않으면 '초기화 실패' 를 발생시킵니다.

위에 있는 `TemperatureUnit` 예제를 다시 작성하여 `Character` 타입의 원시 값을 사용하고 `init?(rawValue:)` 초기자라는 이점을 활용할 수 있습니다:

```swift
enum TemperatureUnit: Character {
  case kelvin = "K", celsius = "C", fahrenheit = "F"
}

let fahrenheitUnit = TemperatureUnit(rawValue: "F")
if fahrenheitUnit != nil {
  print("This is a defined temperature unit, so initialization succeeded.")
}
// "This is a defined temperature unit, so initialization succeeded." 를 출력합니다.

let unknownUnit = TemperatureUnit(rawValue: "X")
if unknownUnit == nil {
  print("This is not a defined temperature unit, so initialization failed.")
}
// "This is not a defined temperature unit, so initialization failed." 를 출력합니다.
```

#### Propagation of Initialization Failure (초기화 실패 전파하기)

클래스, 구조체, 및 열거체의 실패 가능한 초기자는 같은 클래스, 구조체, 및 열거체에 있는 또 다른 실패 가능한 초기자로 '옆쪽 위임 (delegate across)' 을 할 수 있습니다. 이와 비슷하게, 하위 클래스의 실패 가능한 초기자는 상위 클래스의 실패 가능한 초기자로 '위쪽 위임 (delegate up)' 을 할 수 있습니다.

어떤 경우든, 또 다른 초기자로 위임한 것이 초기화 실패의 원인이 될 경우, 전체 초기화 과정은 즉시 실패하며, 초기화 코드는 더 이상 실행되지 않습니다.

> '실패 가능한 초기자 (failable initializer)' 또한 '실패하지 않는 초기자 (nonfailable initializer)' 로 위임할 수 있습니다. 이 접근 방식은 다른 경우라면 실패하지 않을 기존 초기화 과정에 잠재적인 실패 상태를 추가할 필요가 있을 경우 사용하도록 합니다.

아래 예제는 `Product` 의 하위 클래스인 `CartItem` 을 정의합니다. `CartItem` 클래스는 온라인 장바구니에 담겨있는 항목을 모델링 합니다. `CartItem` 은 `quantity` 라는 상수 저장 속성을 도입하여 이 속성 값이 최소 `1` 이상의 값을 가지도록 보장합니다:

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

`CartItem` 의 실패 가능한 초기자는 부여 받은 `quantity` 값이 `1` 이상인지 검증하는 것으로 시작합니다. `quantity` 가 무효하면, 전체 초기화 과정은 그 즉시 실패하고 초기화 코드를 더 이상 실행하지 않습니다. 이와 마찬가지로, `Product` 의 실패 가능한 초기자는 `name` 값을 검사하는데, `name` 이 빈 문자열이면 초기화 과정이 그 즉시 실패합니다.

비어있지 않은 이름과 `1` 이상의 수량으로 `CartItem` 인스턴스를 생성하면, 초기화를 성공합니다:

```swift
if let twoSocks = CartItem(name: "sock", quantity: 2) {
  print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
// "Item: sock, quantity: 2" 를 출력합니다.
```

`quantity` 값이 `0` 인 `CartItem` 인스턴스를 생성하려고 하면, `CartItem` 초기자가 초기화 실패를 발생시킵니다:

```swift
if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
  print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
  print("Unable to initialize zero shirts")
}
// "Unable to initialize zero shirts" 를 출력합니다.
```

이와 비슷하게, 빈 `name` 값을 가지고 `CartItem` 인스턴스를 생성하려고 하면, 상위 클래스인 `Product` 초기자가 초기화 실패를 발생시킵니다:

```swift
if let oneUnnamed = CartItem(name: "", quantity: 1) {
  print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
  print("Unable to initialize one unnamed product")
}
// "Unable to initialize one unnamed product" 를 출력합니다.
```

#### Overriding a Failable Initializer (실패 가능한 초기자 재정의하기)

상위 클래스의 실패 가능한 초기자는, 여느 다른 초기자들 처럼, 하위 클래스에서 재정의할 수 있습니다. 다른 방법으로, 상위 클래스의 실패 가능한 초기자를 하위 클래스의 '_실패하지 않는 (nonfailable)_' 초기자로 재정의할 수도 있습니다. 이는, 상위 클래스의 초기화가 실패할 수 있음에도 불구하고, 하위 클래스에서 초기화가 실패할 수 없도록 정의할 수 있게 해줍니다.

주목해야 할 것은 상위 클래스의 실패 가능한 초기자를 하위 클래스의 실패하지 않는 초기자로 재정의하는 경우, 상위 클래스로 '위쪽 위임 (delegate up)' 을 하는 유일한 방법은 상위 클래스의 실패 가능한 초기자에 대한 결과를 '강제-포장 풀기 (force-unwrap)' 하는 것 뿐이라는 것입니다.

> 실패 가능한 초기자를 실패하지 않는 초기자로 재정의할 수는 있지만 그 반대는 안됩니다.

아래 예제는 `Document` 라는 클래스를 정의합니다. 이 클래스가 모델링 하는 '문서 (document)' 는 비어있지 않은 문자열 값 또는 `nil` 일 수는 있지만, 빈 문자열일 수는 없습니다:

```swift
class Document {
  var name: String?
  // 아래 초기자는 이름 값이 nil 인 문서를 생성합니다.
  init() {}
  // 아래 초기자는 이름 값이 비어있지 않은 문서를 생성합니다.
  init?(name: String) {
    if name.isEmpty { return nil }
    self.name = name
  }
}
```

이 다음 예제는 `Document` 의 하위 클래스인 `AutomaticNamedDocument` 를 정의합니다. `AutomaticNamedDocument` 하위 클래스는 `Document` 가 도입한 지명 초기자 둘 모두를 재정의합니다. 이러한 재정의는 만약 해당 인스턴스가 이름 없이 초기화될 경우, 아니면 `init(name:)` 초기자에 빈 문자열이 전달될 경우, `AutomaticallyNamedDocument` 인스턴스가 `[Untitled]` 라는 초기 `name` 값을 가지도록 보장해 줍니다:

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

`AutomaticNamedDocument` 는 상위 클래스의 실패 가능한 초기자인 `init?(name:)` 초기자를 실패하지 않는 초기자인 `init(name:)` 으로 재정의합니다. `AutomaticNamedDocument` 는 상위 클래스와는 다른 방법으로 빈 문자열을 처리하기 때문에, 이 초기자는 실패할 필요가 없으므로, 그 대신 실패하지 않는 초기자를 제공하는 것입니다.

초기자 내에서 '강제 포장 풀기 (forced unwrapping)' 를 사용하면 하위 클래스의 실패하지 않는 초기자 구현부에서 상위 클래스의 실패 가능한 초기자를 호출할 수 있습니다. 예를 들어, 아래의 `UntitledDocument` 하위 클래스는 항상 이름을 `"[Untitled]"` 라고 하며, 초기화 동안 상위 클래스에 있는 실패 가능한 초기자인 `init(name:)` 를 사용합니다.

```swift
class UntitledDocument: Document {
  override init() {
    super.init(name: "[Untitled]")!
  }
}
```

이 경우, 만약 상위 클래스의 `init(name:)` 초기자를 빈 문자열 이름을 가지고 호출할 때마다, '강제 포장 풀기 (forced unwrapping)' 동작으로 인해 '실행시간 에러 (runtime error)' 가 발생할 것입니다. 하지만, 문자열 상수를 사용하여 호출하기 때문에, 초기자가 실패하지 않을 거라는 것과, 이 경우 아무런 실행시간 에러도 일어날 수 없다는 것을 알 수 있습니다.

#### The `init!` Failable Initializer (`init!` 실패 가능한 초기자)

일반적으로 적당한 타입의 옵셔널 인스턴스를 생성하는 실패 가능한 초기자는 `init` 키워드 뒤에 물음표 기호를 (`init?` 처럼) 붙여서 정의합니다. 다른 방법으로, 암시적으로 포장이 풀리는 적당한 타입의 옵셔널 인스턴스를 생성하는 실패 가능한 초기자를 정의할 수 있습니다. 이렇게 하려면 `init` 키워드 뒤에 물음표 대신 느낌표를 (`init!` 처럼) 붙이면 됩니다.

`init` 에서 `init!` 으로 또 그 반대로도 위임할 수 있으며, `init?` 를 `init!` 으로 또 그 반대로도 재정의할 수 있습니다. `init` 에서 `init!` 으로 위임할 수도 있지만, 이렇게 하면 `init!` 초기자가 초기화 실패를 일으킬 경우 '단언문 (asssertion)' 을 '발동할 (trigger)' 것입니다.

### Required Initializers (필수 초기자)

클래스 초기자의 정의 앞에 `required` 수정자를 붙이면 이 클래스의 모든 하위 클래스가 반드시 해당 초기자를 구현하도록 지시할 수 있습니다:

```swift
class SomeClass {
  required init () {
    // 여기서 초기자를 구현합니다.
  }
}
```

필수 초기자의 모든 하위 클래스 구현부도 반드시 `required` 수정자를 붙여야 하는데, 이는 연쇄망에 있는 하위 클래스도 이 초기자 '필수 조건 (requirement)' 을 계속 적용해야 함을 지시하는 것입니다. '필수 지명 초기자 (required designated initializer)' 를 재정의할 때는 `override` 는 붙이지 않습니다:

```swift
class SomeSubClass: SomeClass {
  required init () {
    // 여기서 필수 초기자의 하위 클래스 버전을 구현합니다.
  }
}
```

> 상속받은 초기자로 '필수 조건 (requirement)' 를 만족시킬 수 있는 경우라면 명시적으로 '필수 초기자' 를 구현하지 않아도 됩니다.

### Setting a Default Property Value with a Closure or Function (클로저 또는 함수를 사용하여 기본 속성 값 설정하기)

만약 저장 속성의 기본 값에 대해 어떤 사용자 정의 작업이나 설정 작업이 필요한 경우, 클로저 또는 전역 함수를 사용하여 해당 속성에 대해 맞춤형 기본 값을 제공할 수 있습니다. 이 속성이 속해 있는 타입의 새로운 인스턴스가 초기화될 때마다, 클로저나 함수를 호출하여, 이의 반환 값을 속성의 기본 값으로 할당합니다.

이러한 종류의 클로저나 함수는 일반적으로 속성과 같은 타입의 임시 값을 생성하고, 해당 값을 조절하여 원하는 초기 상태를 나타낸 후, 이 임시 값을 반환하여 속성의 기본 값으로 사용하도록 합니다.

다음은 어떻게 하면 클로저로 속성의 기본 값을 제공할 수 있는 지를 대략적으로 보여줍니다:

```swift
class SomeClass {
  let someProperty: SomeType = {
    // 이 클로저 내에서 속성에 대한 기본 값을 생성합니다.
    // someValue 는 반드시 SomeType 과 같은 타입이어야 합니다.
    return someValue
  }()
}
```

클로저의 닫는 중괄호 뒤에 빈 괄호 쌍이 따라 오는 것에 주목하기 바랍니다. 이는 스위프트보고 클로저를 그 즉시 실행하라고 말하는 것입니다. 이 괄호를 생략하면, 클로저의 반환 값이 아니라, 클로저 자체를 속성에 할당하고 있는 것입니다.

> 클로저를 사용하여 속성을 초기화할 경우, 클로저가 실행되는 시점에 인스턴스의 나머지 부분은 아직 초기화된 것이 아님을 기억하기 바랍니다. 이것의 의미는, 비록 해당 속성이 기본 값을 가지고 있다고 하더라도, 클로저 내에서 어떤 다른 속성 값에도 접근할 수 없다는 것을 뜻합니다. 암시적인 `self` 속성도 사용할 수 없으며, 어떠한 인스턴스 메소드도 호출할 수 없습니다.

아래 예제는, 체스 게임판을 모델링하는, `Chessboard` 라는 구조체를 정의합니다. 체스는, 검은색과 흰색 정사각형이 번갈아 가며 있는, 8 x 8 크기의 판에서 진행합니다.

![Chessboard](/assets/Swift/Swift-Programming-Language/Initialization-chessboard.png)

이 게임판을 표현하기 위해, `Chessboard` 구조체는, 64개의 `Bool` 값의 배열인, `boardColors` 라는 단일한 속성을 가지고 있습니다. 배열에서 `true` 값은 검은색 정사각형을 나타내며 `false` 값은 흰색 정사각형을 나타냅니다. 배열의 첫 번째 항목은 판의 맨 위 왼쪽 정사각형을 나타내며 배열의 마지막 항목은 보드의 맨 아래 오른쪽 정사각형을 나타냅니다.

`boardColors` 배열은 자신의 색상 값을 설정하기 위해 클로저로 초기화됩니다.

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

새로운 `Chessboard` 인스턴스를 생성할 때마다, 클로저가 실행되어, `boardColors` 의 기본 값을 계산하여 반환합니다. 위 예제에 있는 클로저는 `temporaryBoard` 라는 임시 배열의 판 위 각 정사각형에 대해 적당한 색상을 계산하고 설정하며, 일단 설정이 완료되면 클로저의 반환 값으로 이 임시 배열을 반환합니다.

반환된 배열 값은 `boardColors` 에 저장되며 `squareIsBlackAt(row:column:)` 라는 보조 함수로 조회할 수 있습니다:

```swift
let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
// "true" 를 출력합니다.
print(board.squareIsBlackAt(row: 7, column: 7))
// "false" 를 출력합니다.
```

### 참고 자료

[^Initialization]: 원문은 [Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^property-declaration]: 본문의 앞 부분인 [Setting Initial Values for Stored Properties (저장 속성에 대한 초기 값 설정하기)](#setting-initial-values-for-stored-properties-저장-속성에-대한-초기-값-설정하기) 를 보면, '기본 값' 을 속성의 '정의 (definition)' 에서 할 수 있다고 했다가, 여기서는 속성의 '선언 (declaration)' 에서 지정한다고 말하고 있는데, 이는 잘못된 것이 아닙니다. [Declarations (선언)]({% post_url 2020-08-15-Declarations %}) 장의 맨 처음을 읽어 보면, 스위프트에서는 대부분의 '선언' 이 '정의' 이기도 하기 때문에, 이 둘의 구분은 중요하지 않으며, 이 두 용어를 대부분 같은 의미로 사용한다고 설명하고 있습니다.

[^funnel]: 지명 초기자를 깔대기에 비유한 것은 모든 초기화 과정이 일단 지명 초기자로 모인 다음 위쪽 상위 클래스로 연쇄되는 모습이 깔대기와 흡사하기 때문입니다.

[^convenience]: 이 부분은 원문 자체가 장황하게 설명되어 있는데, 결국 의미 자체는 번역한 문장과 대동소이 하므로, 짧게 줄여서 변역했습니다.

[^option]: 원문에서는 여기서 'option' 이라는 단어를 사용했습니다. 이는 '지명 초기자 (designated initializer)' 에서 값을 다시 수정하는 작업은 반드시 해야하는 것이 아니라 해도 되고 안해도 되는 일종의 '선택 사항 (option)' 이기 때문입니다. 일단 여기서는 문맥에 맞게 '기회' 라고 옮겼습니다.

[^base-class]: 스위프트에서 '기본 클래스 (base class)' 란 어떤 클래스로부터도 상속을 받지 않는 클래스를 말합니다. 보통 계층 구조에서 최상단에 위치하는 클래스는 다 기본 클래스라고 할 수 있지만, 계층 구조 없이 홀로 존재하는 클래스 역시 기본 클래스가 될 수 있습니다. 물론 여기서 프로토콜은 예외에 해당하며, 아무리 프로토콜을 많이 '준수 (conforming)' 하더라도 다른 클래스로부터 직접 상속을 받지 않으면 '기본 클래스' 에 해당합니다.  

[^base-class-in-hierachy]: 앞서 '기본 클래스 (base class)' 란 어떤 클래스로부터도 상속을 받지 않는 클래스를 말한다고 했는데, 하나의 계층 구조에서 어떤 클래스로부터도 상속을 받지 않는 클래스는 최상단 클래스일 수 밖에 없습니다. 즉, 계층 구조의 기본 클래스란 계층 구조의 최상단 클래스라고 이해하면 됩니다.

[^example]: 이 예제 자체가 '초기자 상속' 이 자동적으로 이루어지는 과정을 이해하기 위해 만들어진 것입니다. 따라서 '기본 설정 초기자' 와 '기본 멤버 초기자' 가 없는 상태에서 시작합니다.

[^exactly]: 이 예제에서 '정확하게 (exactly)' 가 의미하는 것은 수치 값 변환을 성공해서 변환된 값을 가지고 있음을 의미하는 것입니다. 변환된 값이 원래 값과 일치할 필요는 없습니다.

[^function-name]: 사실 초기자는 함수 이름을 가지지 않는다기 보다 모든 함수 이름이 `init` 으로 똑같은 경우입니다. 이렇기 때문에, '함수 이름' 으로 초기자를 식별할 수 없으며 그래서 본문에서 '식별용 (identifying)' 함수 이름을 가지진 않는다고 표현한 것입니다.

[^automatic-argument-label]: '자동 인자 이름표 (automatic argument label)' 은 '매개 변수 이름' 이 자동으로 '인자 이름표' 가 되는 것을 말합니다.

[^argument-label]: 바로 위에서 스위프트의 초기자는 '자동 인자 이름표' 를 가진다고 했습니다. 그러므로, 초기자를 호출할 때는 반드시 '인자 이름표' 를 붙이는 것이 기본입니다. 그럼에도 불구하고, 본문에서 '인자 이름표 가 정의되어 있다면' 이라고 단서를 붙인 것은 바로 다음 부분에서 이어지는 '밑줄 (underscore; `_`)' 을 써서 '인자 이름표' 를 명시적으로 무시하는 것도 가능하기 때문입니다.
