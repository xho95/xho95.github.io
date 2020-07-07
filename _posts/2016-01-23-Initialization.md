---
layout: post
comments: true
title:  "Swift 5.3: Initialization (초기화)"
date:   2016-01-23 19:35:00 +0900
categories: Xcode Swift Grammar Initialization
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html) 부분[^Initialization]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## Initialization (초기화)

_초기화 (initialization)_ 는 사용하고자 하는 클래스나, 구조체, 혹은 열거체의 인스턴스를 준비하는 과정을 말합니다. 이 과정은 해당 인스턴스의 저장 속성 각각에 대한 초기 값 설정과 새 인스턴스를 사용하도록 준비하기 전에 필수적으로 해야하는 설정이나 초기화 등을 포함합니다.

이러한 초기화 과정은, 특정 타입에 대한 인스턴스를 새로 생성하기 위해 호출할 수 있는 특수한 함수와도 같은, _초기자 (initializers)_ 를 정의하여 구현합니다. 오브젝티브-C 언어의 초기자와는 다르게, 스위프트의 초기자는 값을 반환하지 않습니다. 이들의 제1의 역할은 새로운 타입의 인스턴스가 맨 처음 사용되기 전에 올바르게 초기화되도록 보장하는 것입니다.

클래스 타입의 인스턴스는 _정리자 (deinitializers)_ 도 구현할 수 있는데, 이는 해당 클래스의 인스턴스가 해제되기 바로 전에 사용자 정의 정리 작업을 수행합니다. 정리자에 대한 더 자세한 정보는, [Deinitialization (객체 정리)]({% post_url 2017-03-03-Deinitialization %}) 를 참고하기 바랍니다.

### Setting Initial Values for Stored Properties (저장 속성에 대한 초기 값 설정하기)

클래스와 구조체는 해당 클래스나 구조체의 인스턴스를 생성하는 시점에 _반드시 (must)_ 자신의 모든 저장 속성에 대한 적절한 초기 값을 설정해야 합니다. 저장 속성을 결정하지 않은 상태로 남겨둘 수 없습니다.

저장 속성에 대한 초기 값은 '초기자 (initializer)' 내에서 설정할 수도 있고, 아니면 속성의 정의 부분에서 '기본 설정 속성 값 (default property value)' 을 할당하여 설정할 수도 있습니다. 이러한 동작들은 이어지는 장에서 설명합니다.

> 저장 속성에 기본 설정 값을 할당하거나, 초기자 내에서 초기 값을 설정할 때는, 해당 속성의 값을 직접 설정하며, 어떤 속성 관찰자도 호출되지 않습니다.

#### Initializers (초기자)

_초기자 (initializers)_ 는 특정한 타입의 인스턴스를 새로 생성하려고 호출합니다. 가장 간단한 형태의, 초기자는 아무런 매개 변수도 가지지 않는 인스턴드 메소드와 비슷하며, `init` 키워드를 사용하여 작성합니다:

```swift
init() {
  // 여기서 일정한 초기화 작업을 수행합니다.
}
```

아래 예제는 `Fahrenheit` 라는 새로운 구조체를 정의하여 화씨 눈금으로 표시된 온도를 저장합니다. `Fahrenheit` 구조체는 타입이 `Double` 인, `temperature` 라는, 하나의 저장 속성을 가집니다:

```swift
struct Fahrenheit {
  var temperature: Double
  init() {
    temperature = 32.0
  }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// "The default temperature is 32.0° Fahrenheit" 를 출력합니다.
```

이 구조체는 매개 변수가 없는, `init` 이라는, 초기자 하나를 정의하여, 저장할 온도를 (화씨 단위에서 물의 어는 점인) `32.0` 이라는 값으로 초기화합니다.

#### Default Property Values (기본 설정 속성 값)

위에서 본 것처럼, 저장 속성의 초기 값은 초기자 내에서 설정할 수 있습니다. 다른 방법은, 속성의 선언 부분[^property-declaration]에서 _기본 설정 속성 값 (default property value)_ 을 지정하는 것입니다. '기본 설정 속성 값' 을 지정하려면 속성을 정의할 때 초기 값을 할당하면 됩니다.

> 속성이 항상 같은 초기 값을 받아 들인다면, 초기자 내에서 값을 설정하는 것보다 '기본 설정 값' 을 제공하기 바랍니다. 최종 결과는 같지만, 기본 설정 값은 속성의 초기화를 그 선언과 더 밀접하게 이어줍니다. 이는 초기자를 더 짧고, 명확하게 만들며 속성의 타입을 기본 설정 값으로 추론할 수 있게 해줍니다. 기본 설정 값은 또, 이 장의 뒤에서 설명하는 것처럼, '기본 설정 초기자 (default initializer)' 와 '초기자 상속 (initializer inheritance)' 이라는 이점을 더 쉽게 활용하도록 만들어 줍니다.

속성을 선언하는 시점에 `temperature` 속성에 대한 기본 설정 값을 제공하면 위의 `Fahrenheit` 구조체를 더 간단한 형태로 작성할 수 있습니다:

```swift
struct Fahrenheit {
  var temperature = 32.0
}
```

### Customizing Initialization (사용자 목적에 맞게 초기화 변경하기)

초기화 과정은, 이어지는 장에서 설명하는 것처럼, 입력 매개 변수와 옵셔널 속성 타입을 사용하거나, 아니면 초기화 동안 상수 속성을 할당하는 것으로써, 사용자 목적에 맞게 변경할 수 있습니다.

#### Initialization Parameters (초기화 매개 변수)

초기자의 정의 부분에서 _초기화 매개 변수 (initialization parameters)_ 를 제공하여, 초기화 과정을 사용자 목적에 맞게 변경하는 값의 타입과 이름을 정의할 수 있습니다. 초기화 매개 변수는 함수 매개 변수 및 메소드 매개 변수와 같은 기능과 구문 표현을 가지고 있습니다.

다음 예제는, 섭씨 단위로 표시된 온도를 저장하는, `Celsius` 라는 구조체를 정의합니다. `Celsius` 구조체는, 각각 다른 눈금의 온도 값을 가지고 구조체의 새 인스턴스를 초기화하는, `init(fromFahrenheit:)` 와 `init(fromKelvin:)` 이라는 두 개의 사용자 정의 초기자를 구현합니다:

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

첫 번째 초기자는 인자 이름표가 `fromFahrenheit` 이고 매개 변수 이름이 `fahrenheit` 인 단일한 초기화 매개 변수를 가집니다. 두 번째 초기자는 인자 이름표가 `fromKelvin` 이고 매개 변수 이름이 `kelvin` 인 단일한 초기화 매개 변수를 가집니다. 두 초기자 모두 자신의 단일한 인자를 연관된 섭씨 값으로 변경한 다음 이 값을 `temperatureInCelsius` 라는 속성에 저장합니다.

#### Parameter Names and Argument Labels (매개 변수 이름과 인자 이름표)

함수 매개 변수 및 메소드 매개 변수와 마찬가지로, 초기화 매개 변수는 초기자 본문 내에서 사용되는 매개 변수 이름과 초기자를 호출할 때 사용되는 '인자 이름표 (argument label)' 를 모두 가질 수 있습니다.

하지만, 초기자는 함수와 메소드가 하듯이 자신의 괄호 앞에 식별용 함수 이름을 가지지는 못합니다. 따라서, 초기자에 있는 매개 변수의 이름과 타입은 어떤 초기자를 호출해야 하는지 식별하는데 특히 중요한 역할을 담당합니다. 이것 때문에, 스위프트는 제공하지 않는 것이 하나라도 있다면 초기자의 _모든 (every)_ 매개 변수에 대한 인자 이름표를 제공합니다.

다음 예제는, `red`, `green`, 그리고 `blue` 라는 세 개의 상수 속성을 사용하여, `Color` 라는 구조체를 정의합니다. 이 속성들은 `0.0` 에서 `1.0` 사이의 값을 저장하여 색상에 있는 빨간색, 녹색, 그리고 파란색 (성분의) 양을 지시합니다.

`Color` 는 자신의 빨간색, 녹색, 및 파란색 성분에 대하여 적절하게 이름 붙인 `Double` 타입의 매개 변수 세 개를 가지는 초기자를 제공합니다. `Color` 는 `white` 라는 매개 변수 하나를 가지는 두 번째 초기자도 제공하는데, 이는 세 개의 색상 성분 모두에 같은 값을 제공할 때 사용합니다.

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

두 초기자 모두, 각 초기자의 매개 변수에 대해 이름 붙인 값을 제공하여, 새로운 `Color` 인스턴스를 생성하는데 사용할 수 있습니다:

```swift
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
```

인자 이름표를 사용하지 않고 이 초기자들을 호출할 수는 없다는 점에 주목하기 바랍니다. 인자 이름표를 정의 했다면 반드시 초기자에서 사용해야 하며, 이를 생략하면 '컴파일 시간 에러 (compile-time error)' 가 발생합니다.

```swift
let veryGreen = Color(0.0, 1.0, 0.0)
// 이는 컴파일 시간 에러를 띄웁니다 - 인자 이름표는 필수입니다.
```

#### Initializer Parameters Without Argument Labels (인자 이름표가 없는 초기자 매개 변수)

초기자 매개 변수에 인자 이름표를 사용하고 싶지 않을 경우, 해당 매개 변수의 인자 이름표에 명시적으로 '밑줄 (`_`)' 을 작성하여 기본 설정 동작을 '재정의 (override)' 하면 됩니다.

다음은 위의 [Initialization Parameters (초기화 매개 변수)](#initialization-parameters-초기화-매개-변수) 에 있는 `Celsius` 예제를 확장한 버전으로,
이는 이미 썹씨 눈금인 `Double` 값으로 새 `Celsius` 인스턴스를 생성하는 추가적인 초기자를 가집니다:

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

`Celsius(37.0)` 초기자 호출은 그 의도상 인자 이름표가 필요 없음이 명확합니다. 따라서 이 초기자를 `init(_ celsius: Double)` 로 작성해서 이름 없는 `Double` 값을 제공하여 호출하는 것은 적절한 것입니다.

#### Optional Property Types (옵셔널 속성 타입)

자신의 사용자 정의 타입이 가지고 있는 정의 속성이 논리적으로 "값이 없음 (no value)" 일 수 있는 경우-아마도 초기화 동안에 값을 설정할 수 없기 때문이거나, 아니면 어떤 이후 시점에 "값이 없음" 인 상태일 수 있기 때문에-이 때는 그 속성을 _옵셔널 (optional)_ 타입으로 선언합니다. 옵셔널 타입인 속성은 자동으로 `nil` 값으로 초기화되며, 이는 그 속성이 초기화 동안에 "아직 값이 없는 (no value yet)" 상태인 것이 일부러 의도한 것임을 지시합니다.

다음 예제는, `response` 라는 옵셔널 `String` 속성을 가지는, `SurveyQuestion` 이라는 클래스를 정의합니다:

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
// "Do you like cheese?" 를 출력합니다.
cheeseQuestion.response = "Yes, I do like cheese."
```

설문 조사에 대한 응답은 질문을 하기 전까지 알 수 없으므로, `response` 속성은 `String?` 타입, 또는 “옵셔널 `String`” 타입으로 선언합니다. `SurveyQuestion` 의 새 인스턴스를 초기화할 때, "아직 값이 없음 (no value yet)" 을 의미하는, `nil` 이라는 기본 설정 값을 여기에다 자동으로 할당합니다.

#### Assigning Constant Properties During Initialization (초기화하는 동안 상수 속성 할당하기)

상수 속성은, 초기화를 마치는 순간에 정확한 값이 설정되어 있기만 하다면, 초기화 동안의 어느 순간에도 값을 할당할 수 있습니다. 일단 한번 상수 속성에 값이 할당되면, 더 이상 수정할 수는 없습니다.

> 클래스 인스턴스의 경우, 상수 속성은 오직 자신을 도입한 클래스의 초기화 동안에만 수정할 수 있습니다. 하위 클래스에서는 수정할 수 없습니다.

위에서 `SurveyQuestion` 예제의 질문에 대한 `text` 속성을 변수 속성이 아닌 상수 속성으로 개량하여, `SurveyQuestion` 의 인스턴스가 일단 생성되면 질문은 바뀌지 않는다고 지시할 수 있습니다. `text` 속성이 이제 상수가 됐음에도 불구하고, 클래스의 초기자에서 설정하는 것은 여전히 가능합니다:

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
// "How about beets?" 를 출력합니다.
beetsQuestion.response = "I also like beets. (But not with cheese.)"
```

### Default Initializers (기본 설정 초기자)

스위프트는 어떤 구조체나 클래스가 모든 속성에 대한 '기본 설정 값 (default values)' 을 제공하면서 그 자신은 단 하나의 초기자도 제공하지 않을 경우 '_기본 설정 초기자 (default initializer)_' 를 제공합니다. 기본 설정 초기자는 단순히 모든 속성을 기본 설정 값으로 설정하는 식으로 새로운 인스턴스를 생성합니다.

다음 예제는 `ShoppingListItem` 이라는 클래스를 정의하여, 구매 목록의 각 항목에 대한 이름, 수량, 그리고 구매 상태를 '은닉합니다 (encapsulates)':

```swift
class ShoppingListItem {
  var name: String?
  var quantity = 1
  var purchased = false
}
var item = ShoppingListItem()
```

`ShoppingListItem` 클래스는 모든 속성이 기본 설정 값을 가지고 있으며, 상위 클래스가 없는 '기본 클래스 (base class)' 이기 때문에, `ShoppingListItem` 은 자동으로 '기본 설정 초기자' 구현을 가지게 되며 이로써 새 인스턴스를 생성할 때 모든 속성을 기본 설정 값으로 설정합니다. (`name` 속성은 옵셔널 `String` 속성이므로, 코드에 작성된 값이 없더라도, 자동으로 `nil` 이라는 기본 설정 값을 부여 받습니다.) 위 예제는 `ShoppingListItem` 클래스의 기본 설정 초기자와 '초기자 구문 표현 (initializer syntax)' 을 같이 사용하여, `ShoppingListItem()` 처럼 작성해서, 클래스의 새로운 인스턴스를 생성했으며, 이 새로운 인스턴스를 `item` 이라는 변수에 할당하였습니다.

#### Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)

구조체 타입은 스스로 정의한 초기자가 하나도 없을 경우 자동으로 '_멤버 초기자 (memberwise initializer)_' 를 부여 받습니다. '기본 설정 초기자' 와는 다르게, 구조체의 저장 속성이 기본 설정 값을 가지지 않더라도 '멤버 초기자' 는 부여 받습니다.

멤버 초기자는 새 구조체 인스턴스의 멤버 속성을 초기화하는 '약칭 방법 (shorthand way)' 입니다. 새 인스턴스의 속성에 대한 초기 값은 이름을 사용하여 멤버 초기자에 전달할 수 있습니다.

아래 예제는 `width` 와 `height` 두 개의 속성을 가지는 `Size` 라는 구조체를 정의합니다. 두 속성 모두 기본 설정 값을 `0.0` 으로 할당하므로 `Double` 타입으로 추론됩니다.

`Size` 구조체는 자동으로 `init(width:height:)` 멤버 초기자를 부여 받으므로, 이를 새 `Size` 인스턴스를 초기화하는데 사용할 수 있습니다:

```swift
struct Size {
  var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
```

멤버 초기자를 호출할 때, 기본 설정 값을 가지고 있는 속성에 대한 것이라면 어떤 것이든 값을 생략할 수 있습니다. 위 예제의, `Size` 구조체는 `height` 와 `width` 속성 둘 모두에 대한 기본 설정 값을 가지고 있습니다. 한 속성이나 두 속성 모두 생략할 수 있으며, 초기자는 생략한 것에는 기본 설정 값을 사용합니다-예를 들면 다음과 같습니다:

```swift
let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
// "0.0 2.0" 를 출력합니다.

let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)
// "0.0 0.0" 를 출력합니다.
```

### Initializer Delegation for Value Types (값 타입을 위한 초기자의 위임)

초기자는 다른 초기자를 호출하여 인스턴스 초기화의 일부를 수행하도록 할 수 있습니다. 이러한 과정을, _초기자 위임 (initializer delegation)_ 이라고 하는데, 여러 개의 초기자들 사이에 코드가 중복되는 것을 피하도록 해줍니다.

초기자 위임이 작동하는 방법에 대한 규칙과, 허용되는 위임 양식에 대한 규칙은, 값 타입인지 클래스 타입인지에 따라 다릅니다. (구조체와 열거체 같은) 값 타입은 상속을 지원하지 않으므로, 초기자 위임 과정이 상대적으로 간단한데, 이는 위임을 할 수 있는 다른 초기자라는 것이 오직 자기가 직접 제공하는 것뿐이기 때문입니다. 하지만, 클래스는 [Inheritance (상속)]({% post_url 2020-03-31-Inheritance %}) 에서 설명한 것처럼, 다른 클래스를 상속할 수 있습니다. 이것의 의미는 클래스의 경우 자신이 상속받은 모든 저장 속성들이 초기화 동안 알맞은 값으로 할당 되었다는 것을 보장하는 추가적인 책임을 가진다는 것입니다. 이 책임에 대해서는 아래의 [Class Inheritance and Initialization (클래스 상속과 초기화)](#class-inheritance-and-initialization-클래스-상속과-초기화) 에서 설명합니다.

값 타입에서, 자기만의 사용자 정의 초기자를 작성할 때는 `self.init` 을 사용하여 같은 값 타입에 있는 다른 초기자를 참조할 수 있습니다. `self.init` 은 초기자 안에서만 호출할 수 있습니다.

값 타입에 대한 초기자를 직접 정의할 경우, 이제 더 이상 해당 타입에 대한 기본 설정 초기자 (또는, 구조체일 경우, 멤버 초기자) 를 가지지 않게 된다는 점을 주목하기 바랍니다. 이러한 구속 조건은 누군가 자동 초기자 하나를 사용하는 바람에 더 복잡한 초기자가 제공하는 추가적인 핵심 설정 작업을 우회해 버리는 상황을 막아줍니다.

> 자신이 만든 값 타입이 '기본 설정 초기자' 와 '멤버 초기자' 로도 초기화 가능하면서, 자기가 만든 사용자 정의 초기자로도 초기화 가능하도록 만들고 싶으면, 자신의 사용자 정의 초기자를 값 타입의 원래 구현부가 아니라 'extension (확장)' 에다 작성하면 됩니다. 이에 대한 더 많은 정보는, [Extensions (확장)]({% post_url 2016-01-19-Extensions %}) 을 참고하기 바랍니다.

다음 예제는 기하학적인 사각형을 표현하는 사용자 정의 구조체인 `Rect` 를 정의합니다. 이 예제는 `Size` 와 `Point` 라는 두 개의 '보조용 구조체 (supporting structures)' 를 필수로 요구하는데, 이 둘은 모든 속성에 대해서 `0.0` 이라는 기본 설정 값을 제공합니다:

```swift
struct Size {
  var width = 0.0, height = 0.0
}
struct Point {
  var x = 0.0, y = 0.0
}
```

아래의 `Rect` 구조체는 세 가지 방법 중 하나를 써서 초기화할 수 있습니다-기본 설정인 '0' 으로 초기화된 `origin` 과 `size` 속성 값을 사용하거나, 원점과 크기 값에 지정된 값을 제공하거나, 아니면 중심점과 크기 값에 지정된 값을 제공하는 것입니다. 이러한 초기화 옵션은 `Rect` 구조체의 정의 부분에 있는 세 개의 사용자 정의 초기자로써 표현됩니다:

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

첫 번째 `Rect` 초기자인, `init()` 는, 자신만의 초기자를 가지지 않는 구조체가 부여 받게 되는, 기본 설정 초기자와 그 기능이 같습니다. 이 초기자는, 빈 중괄호 쌍인 `{}` 로 표현하는, 빈 본문을 가지고 있습니다. 이 초기자를 호출하면 `Rect` 인스턴스를 반환하는데 여기서 `origin` 과 `size` 속성 둘 다 자신의 속성 정의에 따라 `Point(x: 0.0, y: 0.0)` 와 `Size(width: 0.0, height: 0.0)` 라는 기본 설정 값으로 초기화됩니다:

```swift
let basicRect = Rect()
// basicRect 의 원점은 (0.0, 0.0) 이고 크기는 (0.0, 0.0) 입니다.
```

두 번째 `Rect` 초기자인, `init(origin:size:)` 는, 자신만의 초기자를 가지지 않는 구조체가 부여 받게 되는, 멤버 초기자와 그 기능이 같습니다. 이 초기자는 단순히 `origin` 과 `size` 인자 값을 적당한 저장 속성에 할당합니다:

```swift
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
// originRect 의 원점은 (2.0, 2.0) 이고 크기는 (5.0, 5.0) 입니다.
```

세 번째 `Rect` 초기자인, `init(center:size:)` 는, 조금 더 복잡합니다. 이는 먼저 `center` 점과 `size` 값을 기초로 하여 적당한 원점을 계산합니다. 그런 다음  `init(origin:size:)` 초기자를 호출하여 (또는 '_위임 (delegates)_' 하여), 새로운 원점과 크기 값을 적당한 속성에 저장합니다:

```swift
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
// centerRect 의 원점은 (2.5, 2.5) 이고 크기는 (3.0, 3.0) 입니다.
```

`init(center:size:)` 초기자가 `origin` 과 `size` 의 새 값을 직접 적당한 속성에 할당할 수도 있을 것입니다. 하지만, 정확하게 해당 기능을 제공하는 초기자가 이미 존재한다면 `init(center:size:)` 초기자가 이러한 이점을 활용하는 것이 더 편리할 (그리고 의도도 더 분명할) 것입니다.

> 또 다른 방법으로 `init()` 과 `init(origin:size:)` 초기자를 스스로 정의하지 않으면서 작성하는 방법에 대해서는, [Extensions (확장)]({% post_url 2016-01-19-Extensions %}) 을 참고하기 바랍니다.

### Class Inheritance and Initialization (클래스 상속과 초기화)

클래스의 모든 저장 속성은-그 클래스가 상위 클래스에서 상속받은 모든 속성을 포함하여-초기화 동안 _반드시 (must)_ 초기 값이 할당되어야 합니다.

스위프트는 클래스 타입에 대한 두 가지 종류의 초기자를 정의하여 모든 저장 속성이 초기 값을 부여 받도록 보장합니다. 이들을 '지명 초기자 (designated initializers)' 와 '편의 초기자 (convenience initializers)' 라고 합니다.

#### Designated Initializers and Convenience Initializers (지명 초기자와 편의 초기자)

_지명 초기자 (designated initializers)_ 는 클래스에 대한 제1의 초기자입니다. 지명 초기자는 해당 클래스가 도입한 모든 속성을 완전히 초기화하고 적당한 상위 클래스 초기자를 호출하여 위쪽 상위 클래스 연쇄망으로 초기화 과정을 계속 이어갑니다.

클래스는 아주 적은 수의 지명 초기자만 가지는 경향이 있으며, 사실 단 하나만 가지는 것이 일반적입니다. 지명 초기자는 이를 통해 초기화가 일어나고, 이를 통해 초기화 과정이 위쪽 상위 클래스 연쇄망으로 계속되는, 일종의 "깔때기 (funnel)"[^funnel] 같은 곳입니다.

모든 클래스는 최소한 하나의 지명 초기자를 반드시 가져야 합니다. 어떤 경우에, 이러한 '필수 조건 (requirement)' 은 상위 클래스로부터 하나 이상의 지명 초기자를 상속받음으로써 만족시킬 수 있으며, 이는 아래의 [Automatic Initializer Inheritance (자동적인 초기자 상속)](#automatic-initializer-inheritance-자동적인-초기자-상속) 에서 설명하도록 합니다.

_편의 초기자 (convenient initializers)_ 는 클래스에 대한 제2의, 보조용 초기자입니다. 편의 초기자는 동일한 클래스에 있는 지명 초기자의 일부 매개 변수에 기본 값을 설정하기 위해서 정의할 수 있습니다.[^convenient] 편의 초기자는 또 해당 클래스의 인스턴스를 특정한 용도나 특정한 입력 값 타입에 맞게 생성하기 위해서 정의할 수도 있습니다.

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

> 스위프트의 2-단계 초기화 과정은 오브젝티브-C 언어의 초기화와 비슷합니다. 주요 차이점이라면 1 단계를 진행하는 동안, 오브젝티브-C 언어는 모든 속성에 '0' 또는 'null' (가령 `0` 이나 `nil` 같은) 값을 할당한다는 것입니다. 스위프트의 초기화 흐름은, 사용자가 자신만의 초기 값을 설정할 수 있으며, `0` 이나 `nil` 이 기본 설정 값으로 유효하지 않은 타입에도 대처할 수 있다는 점에서 좀 더 유연합니다.

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

하위 클래스 초기자를 작성할 때 상위 클래스의 _지명 (designated)_ 초기자와 일치하는 경우, 이는 사실상 해당 지명 초기자에 대한 '재정의 (override)' 를 제공하는 것입니다. 그러므로, 하위 클래스의 초기자 정의 앞에 반드시 `override` 수정자를 붙여줘야 합니다. 이는, [Default Initializers (기본 설정 초기자)](#default-initializers-기본-설정-초기자) 에서 설명한 것처럼, 자동으로 제공되는 '기본 설정 초기자' 를 재정의하는 경우에도 마찬가지 입니다.

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

`Vehicle` 클래스는 하나 뿐인 저장 속성에 대해 기본 설정 값을 제공하며, 자기 스스로는 어떤 초기자도 제공하지 않습니다. 결과적으로, [Default Initializers (기본 설정 초기자)](#default-initializers-기본-설정-초기자) 에서 설명한대로, 자동으로 기본 설정 초기자를 부여 받습니다. 기본 설정 초기자는 (사용 가능한 경우) 항상 클래스에 대한 '지명 초기자' 이며, 이를 사용하여 `numberOfWheels` 가 `0` 인 새로운 `Vehicle` 인스턴스를 생성할 수 있습니다:

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

하위 클래스에서 도입한 새로운 속성마다 기본 설정 값을 제공했다고 가정할 경우, 다음의 두 규칙이 적용됩니다:

**Rule 1 (규칙 1)**

  하위 클래스가 어떤 지명 초기자도 정의하지 않은 경우, 상위 클래스 모든 지명 초기자를 자동으로 상속 받습니다.

**Rule 2 (규칙 2)**

  하위 클래스가 상위 클래스의 _모든 (all)_ 지명 초기자에 대한 구현을 제공할 경우-'규칙 1' 에 의해 상속을 받은 것이든, 정의 부분에서 직접 구현을 제공한 것이든 상관없이-그러면 상위 클래스의 모든 편의 초기자를 자동으로 상속 받습니다.

이 규칙들은 하위 클래스에서 편의 초기자를 더 추가한 경우에도 그대로 적용됩니다.

> 하위 클래스는 '규칙 2' 를 만족시키기 위한 한 방편으로 상위 클래스의 지명 초기자를 하위 클래스에서 편의 초기자로 구현할 수 있습니다.

#### Designated and Convenience Initialization in Action ('지명 초기자' 와 '편의 초기자' 의 실제 사례)

### Failable Initializers (실패 가능한 초기자)

#### Failable Initializers for Enumerations (열거체를 위한 실패 가능한 초기자)

#### Failable Initializers for Enumerations with Raw Values (원시 값을 갖는 열거체를 위한 실패 가능한 초기자)

원시 값을 가지는 열거체는 자동적으로 '실패 가능한 초기자 (failable initializer)' 인, `init?(rawValue:)` 를 받게 되는데, 이는 `rawValue` 라는 적절한 원시-값 타입의 매개 변수를 취한 다음 해당하는 열거체 '경우 값' 을 찾으면 이를 선택하고, 해당하는 값이 존재하지 않으면 '초기화 실패 (initialization failure)' 를 일으킵니다.

위에 있는 `TemperatureUnit` 예제를 `Character` 타입의 원시 값을 사용하여 `init?(rawValue:)` 초기자의 이점을 활용하도록 다시 작성할 수 있습니다:

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

#### Propagation of Initialization Failure (초기화 실패의 전파)

#### Overriding a Failable Initializer (실패 가능한 초기자 재정의하기)

#### The `init!` Failable Initializer (`init!` 실패 가능한 초기자)

### Required Initializers (필수 초기자)

`required` '수정자 (modifier)' 를 클래스 초기자 정의 앞에 붙이면 모든 하위 클래스에서 그 초기자를 반드시 구현하도록 지시할 수 있습니다:

```swift
class SomeClass {
  required init () {
    // 여기서 초기자를 구현합니다.
  }
}
```

모든 하위 클래스에 있는 필수 초기자의 구현 앞에도 `required` '수정자' 를 붙여줘야 하는데, 이는 초기자 (를 반드시 구현해야 한다는) '필수 조건 (requirement)' 이 연쇄적으로 더 하위의 클래스에도 적용된다는 것을 지시하기 위함입니다. '필수 지명 초기자 (required designated initializer)' 를 재정의할 때는 `override` 는 붙이지 않습니다:

```swift
class SomeSubClass: SomeClass {
  required init () {
    // 여기서 하위 클래스의 필수 초기자를 구현합니다.
  }
}
```

> 상속받은 초기자로 '필수 조건 (requirement)' 를 만족할 수 있는 경우라면 필수 초기자를 명시적으로 구현하지 않아도 됩니다.

### Setting a Default Property Value with a Closure or Function (클로저나 함수를 사용하여 기본 속성 값 설정하기)

### 참고 자료

[^Initialization]: 원문은 [Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html) 에서 확인할 수 있습니다.

[^property-declaration]: 원문에서도 저장 속성의 '기본 설정 값 (default value)' 를 설정하는 부분을 '속성의 정의' 와 '속성의 선언' 이라고 이 둘의 구분없이 사용하고 있습니다.

[^funnel]: 지명 초기자를 깔대기에 비유한 것은 모든 초기화 과정이 일단 지명 초기자로 모인 다음 위쪽 상위 클래스로 연쇄되는 모습이 깔대기와 흡사하기 때문입니다.

[^convenient]: 이 부분은 원문 자체가 장황하게 설명되어 있는데, 결국 의미 자체는 번역한 문장과 대동소이 하므로, 짧게 줄여서 변역했습니다.

[^option]: 원문에서는 여기서 'option' 이라는 단어를 사용했습니다. 이는 '지명 초기자 (designated initializer)' 에서 값을 다시 수정하는 작업은 반드시 해야하는 것이 아니라 해도 되고 안해도 되는 일종의 '선택 사항 (option)' 이기 때문입니다. 일단 여기서는 문맥에 맞게 '기회' 라고 옮겼습니다.

[^base-class]: 스위프트에서 '기본 클래스 (base class)' 란 어떤 클래스로부터도 상속을 받지 않는 클래스를 말합니다. 보통 계층 구조에서 최상단에 위치하는 클래스는 다 기본 클래스라고 할 수 있지만, 계층 구조 없이 홀로 존재하는 클래스도 역시 기본 클래스가 될 수 있습니다. 물론 여기서 프로토콜은 예외에 해당하며, 아무리 프로토콜을 많이 '준수 (conforming)' 하더라도 다른 클래스로부터 직접 상속을 받지 않으면 '기본 클래스' 에 해당합니다.  
