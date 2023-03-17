---
layout: post
comments: true
title:  "Initialization (초기화)"
date:   2016-01-23 19:35:00 +0900
categories: Xcode Swift Grammar Initialization
---

{% include header_swift_book.md %}

## Initialization (초기화)

_초기화 (initialization)_ 는 클래스나, 구조체, 또는 열거체를 쓰려고 인스턴스를 준비하는 과정입니다. 이 과정엔 그 인스턴스에 있는 각 저장 속성마다 초기 값을 설정하는 것과 새 인스턴스를 준비하기 전에 필요한 어떤 설정 및 초기화를 하는 걸 포함합니다.

이 초기화 과정을 구현하려면 _초기자 (initializers)_ 를 정의하면 되는데, 이는 특수한 메소드와 같은 것으로 호출하면 한 특별한 타입에 대한 새로운 인스턴스를 생성할 수 있습니다. **오브젝티브-C** 의 초기자와 달리, 스위프트 초기자는 값을 반환하지 않습니다. 이들의 으뜸 역할은 최초로 사용되기 전에 타입의 새로운 인스턴스가 올바로 초기화되도록 보장하는 겁니다.

클래스 타입의 인스턴스는 _뒷정리자 (deinitializers)_ 도 구현할 수 있는데, 이는 그 클래스의 인스턴스가 해제되기 직전에 자신만의 뒷정리를 합니다. 뒷정리자에 대한 더 많은 정보는, [Deinitialization (뒷정리)]({% link docs/swift-books/swift-programming-language/deinitialization.md %}) 부분을 보기 바랍니다.

### Setting Initial Values for Stored Properties (저장 속성에 초기 값 설정하기)

클래스와 구조체는 그 클래스나 구조체의 인스턴스가 생성될 때까지는 자신의 모든 저장 속성에 _반드시 (must)_ 적절한 초기 값을 설정해야 합니다. 저장 속성이 결정안된 상태로 내버려두고 떠날 수 없습니다.

저장 속성에 초기 값을 설정하는 건 초기자 안에서 하거나, 속성의 정의 부분에서 기본 속성 값을 할당함으로써 할 수 있습니다. 이 행동들은 다음 절에서 설명합니다.

> 저장 속성에 기본 값을 할당하거나, 초기자에서 초기 값을 설정할 때, 그 속성의 값은 곧바로 설정되며, 어떤 속성 관찰자도 호출하지 않습니다.

#### Initializers (초기자)

_초기자 (initializers)_ 를 호출하면 한 특별한 타입의 새로운 인스턴스를 생성합니다. 가장 단순한 형식의, 초기자는 아무런 매개 변수도 없는 인스턴스 메소드와 같으며, `init` 키워드를 써서 작성합니다:

```swift
init() {
  // 어떠한 초기화를 여기서 함
}
```

아래 예제는 `Fahrenheit` 라는 새로운 구조체를 정의하여 화씨 (Fahrenheit) 로 표현된 온도를 저장합니다. `Fahrenheit` 구조체에는, `temperature` 라는, 저장 속성이 하나 있는데, 타입은 `Double` 입니다:

```swift
struct Fahrenheit {
  var temperature: Double
  init() {
    temperature = 32.0
  }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")
// "The default temperature is 32.0° Fahrenheit" 를 인쇄함
```

구조체에서 정의하는 단 하나의 초기자인, `init` 에는, 아무런 매개 변수도 없으며, (화씨에서 물의 어는 점인) `32.0` 라는 값으로 저장된 온도를 초기화합니다.

#### Default Property Values (기본 속성 값)

저장 속성의 초기 값은 초기자 안에서 설정할 수 있으며, 이는 위에서 본 것과 같습니다. 대안은, 속성의 선언 부분에 _기본 속성 값 (default property value)_ 을 지정하는 겁니다.[^property-declaration] 기본 속성 값을 지정하려면 속성을 정의할 때 초기 값을 할당하면 됩니다.

> 속성이 항상 똑같은 초기 값을 입력 받는다면, 초기자 안에서 값을 설정하기 보단 기본 값을 제공하도록 합니다. 끝의 결과는 똑같지만, 기본 값이 속성 초기화와 선언을 더 가깝게 묶습니다. 이는 초기자를 더 짧고, 명확하게 만들며 속성의 타입을 기본 값으로 추론할 수 있게 해줍니다. 기본 값은 기본 초기자[^default-initializer] 와 초기자 상속[^initializer-inheritance] 도 더 쉽게 활용하도록 해주는데, 이는 이 장 나중에 설명합니다.

위에 있는 `Fahrenheit` 구조체를 더 단순한 형식으로 작성하려면 속성 선언 시점에서 `temperature` 속성에 기본 값을 제공하면 됩니다:

```swift
struct Fahrenheit {
  var temperature = 32.0
}
```

### Customizing Initialization (자신만의 초기화 만들기)

자신만의 초기화 과정을 만들려면 입력 매개 변수와 옵셔널 속성 타입을 쓰거나, 초기화 중에 상수 속성을 할당하면 되는데, 이는 다음 절에서 설명합니다.

#### Initialization Parameters (초기화 매개 변수)

_초기화 매개 변수 (initialization parameters)_ 를 초기자 정의 부분에 제공하여, 값의 타입과 이름을 정의하면 자신만의 초기화 과정을 만들 수 있습니다. 초기화 매개 변수가 가진 능력과 구문은 함수 및 메소드 매개 변수와 똑같습니다.

다음 예제는 `Celsius` 라는 구조체를 정의하여, 섭씨 (Celsius) 로 표현된 온도를 저장합니다. `Celsius` 구조체는 `init(fromFahrenheit:)` 와 `init(fromKelvin:)` 이라는 자신만의 초기자를 두 개 구현하는데, 이는 서로 다른 크기의 온도 값으로 새로운 구조체 인스턴스를 초기화합니다:

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
// boilingPointOfWater.temperatureInCelsius 는 100.0 임
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// freezingPointOfWater.temperatureInCelsius 는 0.0 임
```

첫 번째 초기자엔 단 하나의 초기화 매개 변수가 있으며 인자 이름표는 `fromFahrenheit` 이고 매개 변수 이름은 `fahrenheit` 입니다. 두 번째 초기자에도 단 하나의 초기화 매개 변수가 있으며 인자 이름표는 `fromKelvin` 이고 매개 변수 이름은 `kelvin` 입니다. 두 초기자 모두 자신의 단일 인자를 그에 해당하는 섭씨 값으로 변환하고 `temperatureInCelsius` 라는 속성에 이 값을 저장합니다.

#### Parameter Names and Argument Labels (매개 변수 이름과 인자 이름표)

함수 및 메소드의 매개 변수 처럼, 초기화 매개 변수에도 초기자 본문에서 쓰는 매개 변수 이름과 초기자를 호출할 때 쓰는 인자 이름표가 둘 다 있을 수 있습니다.

하지만, 초기자에는 함수 및 메소드 같이 자신의 정체를 알릴 함수 이름을 괄호 앞에 두지 않습니다.[^function-name] 그러므로, 초기자 매개 변수의 이름과 타입은 호출할 초기자의 정체를 구별하는데 특히 더 중요한 역할을 합니다. 이 때문에, 초기자에서 인자 이름표를 제공하지 않으면 스위프트가 _모든 (every)_ 매개 변수에 자동으로 이를 제공합니다.[^automatic-argument-label]

다음 예제는 `Color` 라는 구조체를 정의하며, 여기엔 `red` 와, `green`, 및 `blue` 라는 세 개의 상수 속성이 있습니다. 이 속성들에 `0.0` 과 `1.0` 사이의 값을 저장하여 색상 속의 빨간색, 녹색, 및 파란색 양을 지시합니다.

`Color` 는 자신의 빨간색, 녹색, 및 파란색 성분을 위해 적절히 이름지은 세 개의 `Double` 타입의 매개 변수가 있는 초기자를 제공합니다. `Color` 는  `white` 매개 변수만 하나 있는 두 번째 초기자도 제공하는데, 이를 쓰면 세 개의 모든 색상 성분에 똑같은 값을 제공합니다.

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

두 초기자 모두 새로운 `Color` 인스턴스를 생성하는데 쓸 수 있으며, 각각의 초기자 매개 변수에 이름을 지정한 값을 제공하면 됩니다:

```swift
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
```

이 초기자들은 인자 이름표 없이 호출하는게 불가능하다는 걸 알기 바랍니다. 인자 이름표를 정의했으면 반드시 초기자에서 항상 써야 하며, 이를 생략하는 건 컴파일-시간 에러입니다:

```swift
let veryGreen = Color(0.0, 1.0, 0.0)
// 이는 컴파일-시간 에러를 보고함 - 인자 이름표는 필수임
```

#### Initializer Parameters Without Argument Labels (인자 이름표가 없는 초기자 매개 변수)

초기자 매개 변수에 인자 이름표를 쓰고 싶지 않으면, 그 매개 변수에 인자 이름표를 명시하는 대신 밑줄 (`_`) 을 써서 기본 동작을 재정의합니다.

위의 [Initialization Parameters (초기화 매개 변수)](#initialization-parameters-초기화-매개-변수) 에 있는 `Celsius` 예제를 확대한 버전은 이렇는데, 추가적인 초기자를 써서 이미 섭씨인 `Double` 값으로 새로운 `Celsius` 인스턴스를 생성합니다:

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
// bodyTemperature.temperatureInCelsius 는 37.0 임
```

`Celsius(37.0)` 초기자 호출은 의도가 명확해서 인자 이름표가 필요없습니다. 그러므로 이 초기자를 `init(_ celsius: Double)` 이라고 써서 이름표 없는 `Double` 값으로 호출하게 하는게 적절합니다.

#### Optional Property Types (옵셔널 속성 타입)

자신만의 타입에서 저장 속성이 "값이 없는 (no value)" 논리를 허용한다면-아마도 초기화 중이라 값을 설정할 수 없거나, 나중의 어떤 시점에 "값이 없는" 걸 허용하기 때문이면-그 속성을 _옵셔널 (optional)_ 타입으로 선언합니다. 옵셔널 타입의 속성은 자동으로 값이 `nil` 로 초기화되어, 초기화 중에 "아직 값이 없는" 건 속성이 일부러 의도한 것임을 지시합니다.

다음 예제는 `SurveyQuestion` 이라는 클래스를 정의하는데, `response` 라는 옵셔널 `String` 속성이 있습니다:

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
// "Do you like cheese?" 를 인쇄함
cheeseQuestion.response = "Yes, I do like cheese."
```

설문 조사 (survey question) 에 대한 응답 (response) 은 묻기 전까진 알 수 없으므로, `response` 속성의 타입은 `String?`, 또는 “옵셔널 `String`” 타입이라고 선언합니다. 새로운 `SurveyQuestion` 인스턴스를 초기화할 때, "아직 문자열이 없다" 는 걸 의미하는, 기본 값 `nil` 을 자동으로 할당합니다.

#### Assigning Constant Properties During Initialization (초기화 중에 상수 속성 할당하기)

초기화 중엔 어떤 시점에든 상수 속성에 값을 할당할 수 있는데, 초기화 종료에 이르는 시간까지 확실한 값을 설정하기만 하면 됩니다. 일단 한 번 상수 속성에 값을 설정하면, 더 이상 수정할 수 없습니다.

> 클래스 인스턴스에서, 초기화 중에 상수 속성을 수정할 수 있는 건 그걸 도입한 클래스뿐입니다. 하위 클래스에선 수정할 수 없습니다.

위에 있는 `SurveyQuestion` 예제를 다듬어서 질문의 `text` 속성에 변수 속성 보단 상수 속성을 쓰도록 하면, `SurveyQuestion` 인스턴스가 일단 한 번 생성되면 질문이 바뀌지 않는다고 지시할 수 있습니다. `text` 속성은 이제 상수지만, 클래스 초기자에선 여전히 설정할 수 있습니다:

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
// "How about beets?" 를 인쇄함
beetsQuestion.response = "I also like beets. (But not with cheese.)"
```

### Default Initializers (기본 초기자)

스위프트는 어떤 구조체나 클래스가 자신의 모든 속성에 기본 값을 제공하면서 그 자체론 단 하나의 초기자도 제공하지 않을 경우 _기본 초기자 (default initializer)_ 를 제공합니다. 기본 초기자는 단순히 자신의 모든 속성에 기본 값을 설정하는 것으로 새로운 인스턴스를 생성합니다.

이 예제에서 정의하는 `ShoppingListItem` 이라는 클래스는, 구매 목록 (shopping list) 에 있는 항목의 이름과, 수량, 및 구매 상태를 속에 감춥니다:

```swift
class ShoppingListItem {
  var name: String?
  var quantity = 1
  var purchased = false
}
var item = ShoppingListItem()
```

`ShoppingListItem` 클래스는 모든 속성에 기본 값이 있고, 상위 클래스가 없는 기초 클래스[^base-class] 이기 때문에, `ShoppingListItem` 은 자동으로 얻은 기본 초기자 구현으로 새로운 인스턴스를 생성하며 그 모든 속성에는 기본 값을 설정합니다. (`name` 속성은 옵셔널 `String` 속성이라서, 자동으로 기본 값 `nil` 을 받으며, 심지어 이 값을 코드에 쓰지도 않았습니다.) 위 예제는 `ShoppingListItem` 클래스의 기본 초기자로 초기자 구문인, `ShoppingListItem()` 을 써서, 클래스의 새로운 인스턴스를 생성하고, 이 새로운 인스턴스를 `item` 이라는 변수에 할당합니다. 

#### Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)

구조체 타입은 자신이 직접 어떤 초기자도 정의하지 않으면 자동으로 _멤버 초기자 (memberwise initializer)_ 를 받습니다. 기본 초기자와 달리, 구조체가 멤버 초기자를 받는 건 심지어 저장 속성에 기본 값이 없어도 됩니다.

멤버 초기자는 짧게 줄인 방식으로 새 구조체 인스턴스의 멤버 속성을 초기화합니다. 새 인스턴스의 속성에 대한 초기 값은 멤버 초기자에 이름으로 전달할 수 있습니다.[^by-name]

아래 예제는 `Size` 라는 구조체를 정의하며 `width` 와 `height` 이라는 두 개의 속성이 있습니다. 두 속성은 모두 기본 값 `0.0` 을 할당하여 `Double` 타입이라고 추론됩니다.

`Size` 구조체는 자동으로 `init(width:height:)` 멤버 초기자를 받으며, 이를 써서 새로운 `Size` 인스턴스를 초기화할 수 있습니다:

```swift
struct Size {
  var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
```

멤버 초기자를 호출할 때는, 기본 값이 있는 어떤 속성 값이든 생략할 수 있습니다. 위 예제에서, `Size` 구조체에는 `height` 와 `width` 속성 둘 다에 기본 값이 있습니다. 어느 한 속성 또는 두 속성 다 생략할 수 있으며, 초기자는 생략한 것에 기본 값을 씁니다-예를 들면 다음과 같습니다:

```swift
let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
// "0.0 2.0" 를 인쇄함

let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)
// "0.0 0.0" 를 인쇄함
```

### Initializer Delegation for Value Types (값 타입에서의 초기자 맡김)

초기자는 다른 초기자를 호출하여 인스턴스의 일부를 초기화할 수 있습니다. 이 과정을, _초기자 맡김 (initializer delegation)_ 이라 하는데, 여러 초기자에 걸쳐 코드가 중복되는걸 피하게 합니다.

초기자를 어떻게 맡기는지, 그리고 무슨 형식으로 맡길 수 있는지에 대한 규칙은, 값 타입과 클래스 타입이 서로 다릅니다. 값 타입(인 구조체와 열거체) 는 상속을 지원하지 않아서, 초기자를 맡기는 과정이 상대적으로 단순한데, 이들은 자기가 제공하는 또 다른 초기자로만 맡길 수 있기 때문입니다. 클래스는, 하지만, [Inheritance (상속; 물려받기)]({% link docs/swift-books/swift-programming-language/inheritance.md %}) 에서 설명하듯, 다른 클래스를 물려받을 수 있습니다. 이것의 의미는 클래스는 초기화 중에 자신이 물려받은 모든 저장 속성에 알맞은 값이 할당되도록 할 책임이 추가된다는 겁니다. 이 책임에 대해서는 아래의 [Class Inheritance and Initialization (클래스 상속 및 초기화)](#class-inheritance-and-initialization-클래스-상속-및-초기화) 에서 설명합니다.

값 타입은, 자신만의 초기자를 작성할 때 `self.init` 으로 똑같은 값 타입에 있는 다른 초기자를 참조합니다. `self.init` 은 초기자 안에서만 호출할 수 있습니다.

값 타입에 자신만의 초기자를 정의하면, 더 이상 그 타입의 기본 초기자 (나, 구조체라면, 멤버 초기자) 에 접근할 수 없다는 걸 알아두기 바랍니다. 이런 구속 조건은 누군가 하나의 자동 초기자를 사용함으로써 더 복잡한 초기자에서 제공한 핵심 추가 설정을 우회하게 되는 사고를 막아줍니다.

> 자신의 값 타입이 기본 초기자 및 멤버 초기자와 함께, 자신만의 초기자로도 초기화 가능하게 하고 싶으면, 자신의 초기자를 값 타입의 원본 구현 부분 보단 익스텐션 (extension) 에서 작성합니다. 더 많은 정보는, [Extensions (익스텐션; 확장)]({% link docs/swift-books/swift-programming-language/extensions.md %}) 을 보도록 합니다.

다음 예제는 기하 직사각형을 나타내는 `Rect` 구조체를 정의합니다. 예제는 `Size` 와 `Point` 라는 두 개의 지원용 구조체를 요구하는데, 둘 다 자신의 모든 속성에 `0.0` 이라는 기본 값을 제공합니다:

```swift
struct Size {
  var width = 0.0, height = 0.0
}
struct Point {
  var x = 0.0, y = 0.0
}
```

아래의 `Rect` 구조체는 세 가지 방법-기본 값 0 으로 초기화한 `origin` 과 `size` 속성 값 사용하기, 특정한 원점과 크기 제공하기, 또는 특정한 중심점과 크기 지정하기-중 하나로 초기화할 수 있습니다. 이 초기화 옵션들은 `Rect` 구조체 정의 부분에서 세 개의 사용자 정의 초기자로 나타냅니다:

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

첫 번째 `Rect` 초기자인, `init()` 은, 구조체에 자신만의 초기자가 없을 경우 받을 기본 초기자와 기능이 똑같습니다. 이 초기자는 빈 본문을 가지며, 빈 중괄호 쌍 `{}` 으로 이를 나타냅니다. 이 초기자 호출이 반환하는 `Rect` 인스턴스는 `origin` 과 `size` 속성 정의로부터 둘 다를 `Point(x: 0.0, y: 0.0)` 과 `Size(width: 0.0, height: 0.0)` 라는 기본 값으로 초기화합니다: 

```swift
let basicRect = Rect()
// basicRect 은 원점이 (0.0, 0.0) 이고 크기는 (0.0, 0.0) 임
```

두 번째 `Rect` 초기자인, `init(origin:size:)` 는, 구조체에 자신만의 초기자가 없을 경우 받을 멤버 초기자와 기능이 똑같습니다. 이 초기자는 단순히 적절한 저장 속성에 `origin` 과 `size` 인자 값을 할당합니다:

```swift
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
// originRect 는 원점이 (2.0, 2.0) 이고 크기는 (5.0, 5.0) 임
```

세 번째 `Rect` 초기자인, `init(center:size:)` 는, 살짝 더 복잡합니다. 이는 `center` 점과 `size` 값에 기초한 적절한 원점 계산으로 시작합니다. 그런 다음, 적절한 속성에 새 원점 및 크기 값을 저장하는, `init(origin:size:)` 초기자를 호출 (또는 일을 _맡긴다 (delegates)_ 고) 합니다:

```swift
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
// centerRect 은 원점이 (2.5, 2.5) 이고 크기는 (3.0, 3.0) 임
```

`init(center:size:)` 초기자 스스로 적절한 속성에 새 `origin` 과 `size` 값을 할당할 수도 있을 겁니다. 하지만, `init(center:size:)` 초기자가 이미 정확히 그 기능을 하는 기존 초기자라는 이점을 취하는게 더 편리 (하며 의도도 더 명확) 합니다.

> `init()` 과 `init(origin:size:)` 초기자 그 자체의 정의 없이 이 예제를 작성하는 대안은, [Extensions (익스텐션; 확장)]({% link docs/swift-books/swift-programming-language/extensions.md %}) 을 보도록 합니다.

### Class Inheritance and Initialization (클래스 상속 및 초기화)

초기화 중엔-상위 클래스로부터 상속한 어떤 속성도 포함한-클래스의 모든 저장 속성에 _반드시 (must)_ 초기 값을 할당해야 합니다.

스위프트는 모든 저장 속성이 초기 값을 받도록 보장하기 위해 클래스 타입에 두 종류의 초기자를 정의합니다. 이들을 지명 초기자와 편의 초기자라고 합니다.

#### Designated Initializers and Convenience Initializers (지명 초기자와 편의 초기자)

_지명 초기자 (designated initializers)_ 는 클래스의 으뜸 초기자입니다. 지명 초기자는 그 클래스가 도입한 모든 속성을 완전히 초기화하며 초기화 과정이 상위 클래스 사슬로 계속 올라가도록 적절한 상위 클래스 초기자를 호출합니다.

클래스엔 아주 적은 수의 지명 초기자만 있는 경향이 있으며, 하나만 있는 클래스도 꽤 흔합니다. 지명 초기자는 "깔때기 (funnel)"[^funnel] 같은 곳이라 이를 통해 초기화가 일어나고, 초기화 과정이 상위 클래스 사슬로 계속 올라갑니다.

모든 클래스는 적어도 하나의 지명 초기자는 반드시 가져야 합니다. 일부의 경우, 아래의 [Automatic Initializer Inheritance (자동적인 초기자 상속)](#automatic-initializer-inheritance-자동적인-초기자-상속) 에서 설명하는 것처럼, 상위 클래스로부터 하나 이상의 지명 초기자를 상속함으로써 이 필수 요구 조건을 만족하기도 합니다.

_편의 초기자 (convenience initializers)_ 는 클래스의 둘째가는, 지원용 초기자입니다. 편의 초기자를 정의하면 지명 초기자의 일부 매개 변수를 기본 값으로 설정한 걸로 동일한 클래스의 지명 초기자를 호출할 수 있습니다. 편의 초기자를 정의하여 그 클래스의 인스턴스를 정해진 용도나 입력 값 타입을 가지게 생성할 수도 있습니다.

클래스에 필요하지 않으면 편의 초기자를 제공하지 않아도 됩니다. 공통 초기화 패턴으로의 줄임말이 시간을 절약하거나 클래스 초기화의 의도를 명확하게 할 때마다 편의 초기자를 생성합니다.

#### Syntax for Designated and Convenience Initializers (지명 및 편의 초기자의 구문)

클래스의 지명 초기자는 단순한 값 타입의 초기자와 똑같은 방식으로 작성합니다:

&nbsp;&nbsp;&nbsp;&nbsp;init(`parameters-매개 변수`) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

편의 초기자도 똑같은 스타일로 작성하지만, 공백으로 구분한, `convenience` 수정자를 `init` 키워드 앞에 둡니다:

&nbsp;&nbsp;&nbsp;&nbsp;convenience init(`parameters-매개 변수`) {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

#### Initializer Delegation for Class Types (클래스 타입의 초기자 맡김)

지명 및 편의 초기자 사이의 관계가 단순해지도록, 스위프트는 초기자 사이의 '맡기는 호출 (delegation calls)'[^delegation-calls] 에 다음의 세 규칙을 적용합니다:

**Rule 1 (규칙 1)**

&nbsp;&nbsp;&nbsp;&nbsp;지명 초기자는 반드시 자신의 바로 위 상위 클래스의 지명 초기자를 호출해야 합니다.

**Rule 2 (규칙 2)**

&nbsp;&nbsp;&nbsp;&nbsp;편의 초기자는 반드시 _동일한 (same)_ 클래스의 다른 초기자를 호출해야 합니다.

**Rule 3 (규칙 3)**

&nbsp;&nbsp;&nbsp;&nbsp;편의 초기자는 궁극적으로 반드시 지명 초기자를 호출해야 합니다.

이를 기억하는 단순한 방법은 다음과 같습니다:

* 지명 초기자는 반드시 항상 _위로 (up)_ 맡깁니다.
* 편의 초기자는 반드시 항상 _옆으로 (across)_ 맡깁니다.

이 규칙을 묘사한게 아래 그림입니다:

![delegation rules](/assets/Swift/Swift-Programming-Language/Initialization-delegation-rules.jpg)

여기선, 상위 클래스에 지명 초기자 하나와 편의 초기자 두 개가 있습니다. 편의 초기자 하나가 다른 편의 초기자를 호출하며, 차례대로 지명 초기자 하나를 호출합니다. 이는 위의 규칙 2 와 규칙 3 을 만족합니다. 상위 클래스 자체는 더 이상 상위 클래스를 가지지 않으므로, 규칙 1 은 적용하지 않습니다.

이 그림의 하위 클래스엔 지명 초기자 두 개와 편의 초기자 하나가 있습니다. 편의 초기자는 두 지명 초기자 중 하나를 반드시 호출해야 하는데, 이는 동일 클래스에 있는 다른 초기자만 호출할 수 있기 때문입니다. 이는 위의 규칙 2 와 규칙 3 을 만족합니다. 두 지명 초기자 모두 반드시 상위 클래스의 단일 지명 초기자를 호출해야, 위의 규칙 1 을 만족합니다.

> 이 규칙은 클래스 사용자가 클래스 인스턴스를 _생성하는 (create)_ 방법엔 영향을 주지 않습니다. 위 도표의 어떤 초기자를 사용하든 자신이 속한 클래스의 완전히 초기화된 인스턴스를 생성할 수 있습니다. 이 규칙은 클래스 초기자 구현을 작성하는 방법에만 영향을 줍니다.

아래 그림은 네 클래스로 된 더 복잡한 클래스 계층 구조를 보여줍니다. 이는 어떻게 지명 초기자가 이 계층 구조에서 "깔때기 (funnel)" 처럼 행동하여, 클래스 사슬 사이의 상호 관계를 단순화하는지, 묘사합니다:

![funnel points](/assets/Swift/Swift-Programming-Language/Initialization-funnel.png)

#### Two-Phase Initialization (2-단계 초기화)

스위프트의 클래스 초기화는 2-단계 과정입니다. 첫 번째 단계에선, 각 저장 속성에 이를 도입한 클래스가 초기 값을 할당합니다. 모든 저장 속성의 초기 상태가 한 번 결정되고 나면, 두 번째 단계가 시작하며, 새 인스턴스를 사용할 준비가 됐다고 고려하기 전에 자신의 저장 속성을 한번 더 사용자 정의할 기회가 각각의 클래스에 주어집니다.

2-단계 초기화 과정의 사용은 초기화를 안전하게 하면서, 여전히 클래스 계층의 각 클래스엔 완전한 유연함을 줍니다. 2-단계 초기화는 속성 값을 초기화하기 전에 접근하는 걸 막아 주며, 예상치 않게 또 다른 초기자가 속성 값에 다른 값을 설정하는 것도 막아줍니다.

> 스위프트의 2-단계 초기화 과정은 오브젝티브-C 의 초기화와 비슷합니다. 주요한 차이점은 1 단계 중에, 오브젝티브-C 는 모든 속성에 (`0` 이나 `null` 같은) 0 또는 널 값을 할당한다는 것입니다. 스위프트의 초기화 흐름은 자신만의 초기 값을 설정하게 해준다는 점에서 더 유연하여, `0` 이나 `nil` 이 유효한 기본 값이 아닌 타입도 대처할 수 있습니다.

스위프트 컴파일러는 2-단계 초기화가 에러 없이 확실히 완료하도록 도움이 되는 네 개의 안전성-검사를 수행합니다:

**Safety Check 1 (안전성 검사 1)**

&nbsp;&nbsp;&nbsp;&nbsp;지명 초기자는 반드시 클래스가 도입한 모든 속성을 초기화하도록 보장한 다음에 상위 클래스 초기자로 맡겨야[^delegate-up] 합니다.

위에서 언급한 것처럼, 모든 저장 속성의 초기 상태를 한 번 알고 나야 객체의 메모리를 완전히 초기화한 것으로 고려합니다. 이 규칙을 만족하기 위해선, 지명 초기자가 사슬 위로 손을 떼기 전에 반드시 모든 속성을 확실히 초기화해야 합니다.

**Safety Check 2 (안전성 검사 2)**

&nbsp;&nbsp;&nbsp;&nbsp;지명 초기자는 반드시 상위 클래스 초기자로 맡긴 다음에 상속한 속성에 값을 할당해야 합니다. 그렇지 않으면, 상위 클래스의 초기화 부분에서 지명 초기자가 할당한 새 값을 덮어 쓸 겁니다.

**Safety Check 3 (안전성 검사 3)**

&nbsp;&nbsp;&nbsp;&nbsp;편의 초기자는 반드시 다른 초기자로 맡긴 다음에 (동일한 클래스가 정의한 속성을 포함한) _어떤 (any)_ 속성에 값을 할당해야 합니다. 그렇지 않으면, 자기 클래스의 지명 초기자가 편의 초기자가 할당한 새 값을 덮어 쓸 것입니다.

**Safety Check 4 (안전성 검사 4)**

&nbsp;&nbsp;&nbsp;&nbsp;첫 단계 초기화를 완료하기 전까진, 어떤 인스턴스 메소드를 호출하는 것이나, 어떤 인스턴스 속성의 값을 읽는 것, 또는 `self` 값을 참조하는 것을, 초기자가 할 수 없습니다.

클래스 인스턴스는 첫 단계가 끝나기 전까진 완전하게 유효한 건 아닙니다. 속성에 접근하는 것과, 메소드를 호출하는 건, 첫 단계 끝에서 클래스 인스턴스가 한 번 유효하다고 알고 나야, 할 수 있습니다.

다음은, 위의 네 안전성 검사를 기초로, 2-단계 초기화를 끝까지 마무리하는 방법입니다:

**Phase 1 (단계 1)**

* 클래스의 지명 또는 편의 초기자를 호출합니다.
* 그 클래스의 새 인스턴스에 메모리를 할당합니다. 메모리는 아직 초기화된 게 아닙니다.
* 그 클래스의 지명 초기자가 그 클래스가 도입한 모든 저장 속성에 값이 있다고 확정합니다. 이제 이 저장 속성의 메모리가 초기화되었습니다.
* 지명 초기자는 상위 클래스 초기자가 자신의 저장 속성에 똑같은 임무를 수행하도록 손을 뗍니다.
* 클래스 사슬 맨 위에 도달할 때까지 상속 사슬을 계속 오릅니다.
* 사슬 맨 위에 도달하여, 사슬망의 최종 클래스가 자신의 모든 저장 속성에 값이 있다고 한 번 보장하고 나면, 인스턴스 메모리가 완전히 초기화됐다고 고려하여, 단계 1 을 완료합니다.

**Phase 2 (단계 2)**

* 사슬 맨 위에서 밑으로 내려가면서, 사슬망의 각 지명 초기자는 한번 더 인스턴스를 사용자 정의할 기회를 가집니다. 이제 초기자는 `self` 에 접근하여 자신의 속성을 수정하고, 자신의 인스턴스 메소드를 호출하는 것, 등을 계속 할 수 있습니다.
* 최종적으로, 사슬망의 어떤 편의 초기자든 인스턴스를 사용자 정의하고 `self` 와 작업할 기회를 가집니다.

다음은 단계 1 이 가상 하위 클래스 및 상위 클래스의 초기화 호출을 찾는 방법을 보여줍니다:

![Phase 1](/assets/Swift/Swift-Programming-Language/Initialization-delegation-phase-1.jpg)

이 예제의, 초기화는 하위 클래스의 편의 초기자 호출로 시작합니다. 이 편의 초기자는 아직 어떤 속성도 수정할 수 없습니다. 이는 동일한 클래스의 지명 초기자로 옆으로 맡깁니다.

지명 초기자는, 안전성 검사 1 에 따라, 모든 하위 클래스 속성이 확실히 값을 가지도록 합니다. 그런 다음 초기화가 사슬 위로 계속되도록 상위 클래스의 지명 초기자를 호출합니다.

상위 클래스의 지명 초기자는 모든 상위 클래스 속성이 확실히 값을 가지도록 합니다. 더 이상 초기화할 상위 클래스가 없으므로, 더 이상 맡길 필요가 없습니다.

모든 상위 클래스 속성이 초기 값을 가지자마자 곧, 그 메모리는 완전히 초기화된 것으로 고려하여, 단계 1 을 완료합니다.

다음은 단계 2 가 동일한 초기화 호출을 찾는 방법입니다:

![Phase 2](/assets/Swift/Swift-Programming-Language/Initialization-delegation-phase-2.png)

이제 상위 클래스 지명 초기자는 (안해도 되긴 하지만) 인스턴스를 한 번 더 사용자 정의할 기회를 가집니다.

상위 클래스 지명 초기자가 종료하고 나면, 하위 클래스 지명 초기자가 추가적인 사용자 정의를 할 수 있습니다. (다시 말하지만, 안해도 됩니다).

최종적으로, 하위 클래스 지명 초기자가 종료하고 나면, 원래 호출한 편의 초기자가 추가적인 사용자 정의를 할 수 있습니다.

#### Initializer Inheritance and Overriding (초기자 상속 및 재정의)

오브젝티브-C 의 하위 클래스와 달리, 스위프트의 하위 클래스는 기본적으로 자신의 상위 클래스 초기자를 상속하지 않습니다. 스위프트 접근법은 더 특수화된 하위 클래스가 단순한 상위 클래스 초기자를 상속하여 완전하지 않거나 올바르지 않게 초기화된 새 하위 클래스 인스턴스를 생성하는 상황을 막아줍니다.

> 특정 상황에선 상위 클래스 초기자 _를 (are)_ 상속하지만, 안전하고 적절할 때만 그렇게 합니다. 더 많은 정보는, 아래의 [Automatic Initializer Inheritance (자동적인 초기자 상속)](#automatic-initializer-inheritance-자동적인-초기자-상속) 을 보도록 합니다.  

하위 클래스에 자신의 상위 클래스와 동일한 초기자를 두고 싶으면, 하위 클래스 안에서 그 초기자에 자신만의 구현을 제공(하여 그렇게) 할 수 있습니다.

상위 클래스 _지명 (designated)_ 초기자와 일치하는 하위 클래스 초기자를 작성할 땐, 사실상 그 지명 초기자를 재정의 (override) 하는 겁니다. 그러므로, 반드시 하위 클래스의 초기자 정의 앞에 `override` 수정자를 작성해야 합니다. [Default Initializers (기본 초기자)](#default-initializers-기본-초기자) 에서 설명한 것처럼, 이는 자동 제공하는 기본 초기자를 재정의하는 경우에도 그렇습니다.

재정의한 속성, 메소드, 및 첨자 처럼, `override` 수정자가 있으면 스위프트가 즉시 재정의와 일치하는 지명 초기자를 상위 클래스가 가지는지 검사하도록 하며, 재정의한 초기자의 매개 변수가 의도대로 지정됐는지 검증합니다.

> 상위 클래스 지명 초기자를 재정의할 땐, 초기자의 하위 클래스 구현이 편의 초기자인 경우에도, 항상 `override` 수정자를 작성합니다.

거꾸로 말해서, 상위 클래스 _편의 (convenience)_ 초기자와 일치하는 하위 클래스 초기자를 작성하면, 위의 [Initializer Delegation for Class Types (클래스 타입의 초기자 맡김)](#initializer-delegation-for-class-types-클래스-타입의-초기자-맡김) 에서 설명한 규칙에 따라, 하위 클래스는 절대로 직접 상위 클래스 편의 초기자를 호출할 수 없습니다. 그러므로, (엄밀하게 말해서) 하위 클래스가 상위 클래스 초기자를 재정의하는 게 아닙니다. 그 결과, 상위 클래스 편의 초기자와 일치하는 구현을 제공할 땐 `override` 수정자를 작성하지 않습니다.

아래 예제는 `Vehicle` 이라는 기초 클래스를 정의합니다. 이 기초 클래스는, `0` 이라는 기본 `Int` 값을 가진, `numberOfWheels` 라는 저장 속성을 선언합니다. `numberOfWheels` 속성은 `description` 이라는 계산 속성이 차량 성질의 `String` 설명을 생성하는데 사용합니다:

```swift
class Vehicle {
  var numberOfWheels = 0
  var description: String {
    return "\(numberOfWheels) wheel(s)"
  }
}
```

`Vehicle` 클래스는 자신의 유일한 저장 속성에 기본 값을 제공하며, 그 자체론 어떤 초기자도 제공하지 않습니다. 그 결과, [Default Initializers (기본 초기자)](#default-initializers-기본-초기자) 에서 설명한 것처럼, 자동으로 기본 초기자를 받습니다. (사용 가능할 때의) 기본 초기자는 항상 클래스의 지명 초기자이며, 이를 사용하여 `0` 이라는 `numberOfWheels` 을 가진 새 `Vehicle` 인스턴스를 생성할 수 있습니다:

```swift
let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")
// Vehicle: 0 wheel(s)
```

다음 예제는 `Bicycle` 이라는 `Vehicle` 의 하위 클래스를 정의합니다:

```swift
class Bicycle: Vehicle {
  override init() {
    super.init()
    numberOfWheels = 2
  }
}
```

`Bicycle` 하위 클래스는, `init()` 라는, 자신만의 지명 초기자를 정의합니다. 이 지명 초기자는 `Bicycle` 의 상위 클래스에 있는 지명 초기자와 일치하므로, 이 초기자의 `Bicycle` 버전을 `override` 수정자로 표시합니다.

`Bicycle` 의 `init()` 초기자는 `super.init()` 을 호출함으로써 시작하는데, 이는 `Bicycle` 의 상위 클래스에 있는 기본 초기자를 호출합니다. 이는 `Bicycle` 이 속성을 수정할 기회를 가지기 전에 `numberOfWheels` 라는 상속 속성을 `Vehicle` 이 (먼저) 초기화하도록 보장합니다. `super.init()` 호출 후에, `numberOfWheels` 원본 값을 `2` 라는 새 값으로 교체합니다.

`Bicycle` 인스턴스를 생성하면, 상속한 `description` 계산 속성을 호출하여 `numberOfWheels` 속성을 어떻게 갱신했는지 볼 수 있습니다:

```swift
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")
// Bicycle: 2 wheel(s)
```

하위 클래스 초기자는 초기화 과정 단계 2 에서 아무런 사용자 정의도 하지 않고, 상위 클래스는 인자가-0 개인 지명 초기자를 가진다면, 하위 클래스의 모든 저장 속성에 값을 할당한 후에 `super.init()` 호출을 생략할 수 있습니다.[^no-customization]

이 예제는, `Hoverboard` 라는, 또 다른 `Vehicle` 하위 클래스를 정의합니다. 자신의 초기자에서, `Hoverboard` 클래스는 `color` 속성만 설정합니다. `super.init()` 호출을 명시하는 대신, 이 초기자는 상위 클래스 초기자의 암시적 호출로 과정을 완료합니다.

```swift
class Hoverboard: Vehicle {
  var color: String
  init(color: String) {
    self.color = color
    // 여기서 super.init() 을 암시적으로 호출함
  }
  override var description: String {
    return "\(super.description) in a beautiful \(color)"
  }
}
```

`Hoverboard` 인스턴스는 `Vehicle` 초기자가 공급한 기본 바퀴 개수를 사용합니다.

```swift
let hoverboard = Hoverboard(color: "silver")
print("Hoverboard: \(hoverboard.description)")
// Hoverboard: 0 wheel(s) in a beautiful silver
```

> 초기화 중에 상속한 변수 속성을 하위 클래스가 수정할 순 있지만, 상속한 상수 속성을 수정할 순 없습니다.

#### Automatic Initializer Inheritance (자동적인 초기자 상속)

위에서 언급한 것처럼, 기본적으로 하위 클래스는 자신의 상위 클래스 초기자를 상속하지 않습니다. 하지만, 정해진 조건에 부합하면 자동으로 상위 클래스 초기자 _를 (are)_ 상속합니다. 실상, 이는 수많은 상황에서 초기자를 재정의하는 건 필요가 없으며, 상위 클래스 초기자를 상속하는 게 안전할 때마다 최소한의 노력으로 그럴 수 있다는 의미입니다.

하위 클래스에서 도입한 새로운 어떤 속성마다 기본 값을 제공한다고 가정하면, 다음의 두 규칙이 적용됩니다:

**Rule 1 (규칙 1)**

&nbsp;&nbsp;&nbsp;&nbsp;하위 클래스가 어떤 지명 초기자도 정의하지 않으면, 자동으로 자신의 모든 상위 클래스 지명 초기자를 상속합니다.

**Rule 2 (규칙 2)**

&nbsp;&nbsp;&nbsp;&nbsp;규칙 1 에 따라 상속을 하든, 아니면 정의 부분에서 자신만의 구현을 제공하든-하위 클래스가 자신의 _모든 (all)_ 상위 클래스 지명 초기자를 구현하면-자동으로 모든 상위 클래스 편의 초기자를 상속합니다.

이 규칙은 하위 클래스에 편의 초기자를 더 추가한 경우에도 적용됩니다.

> 규칙 2 를 만족하는 부분에서 하위 클래스는 상위 클래스 지명 초기자를 하위 클래스 편의 초기자로써 구현할 수 있습니다.

#### Designated and Convenience Initialization in Action (지명 초기자와 편의 초기자의 실제 사례)

다음 예제는 지명 초기자, 편의 초기자, 및 자동적인 초기자 상속을 실제 사례로 보여줍니다. 이 예제는 `Food`, `RecipeIngredient`, 및 `ShoppingListItem` 이라는 세 클래스들의 계층 구조를 정의하고, 이들의 초기자가 어떻게 상호 작용하는 지를 실증합니다.

계층 구조의 기초 클래스는, 식료품 이름을 은닉하는 단순한 클래스인, `Food` 입니다. `Food` 클래스는 `name` 이라는 `String` 속성 하나를 도입하고 `Food` 인스턴스를 생성하기 위한 초기자를 두 개 제공합니다:

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

아래 그림은 `Food` 클래스의 초기자 사슬을 보여줍니다:

![Initializer chain for the Food](/assets/Swift/Swift-Programming-Language/Initialization-chain-for-food.png)

클래스에는 기본 멤버 초기자가 없으므로[^default-member-initializer], `Food` 클래스가 `name` 이라는 단일 인자를 취하는 지명 초기자를 제공합니다. 이 초기자를 사용하여 특정 이름을 가진 새 `Food` 인스턴스를 생성할 수 있습니다:

```swift
let namedMeat = Food(name: "Bacon")
// namedMeat 의 이름은 "Bacon" 임
```

`Food` 클래스의 `init(name: String)` 초기자를 _지명 (designated)_ 초기자로 제공한 건, 새 `Food` 인스턴스의 모든 저장 속성을 완전히 초기화하도록 보장해야 하기 때문입니다. `Food` 클래스에는 상위 클래스가 없으므로, `init(name: String)` 초기자가 자신의 초기화를 완료하는데 `super.init()` 을 호출할 필요는 없습니다.

`Food` 클래스는, 인자 없는, `init()` 이라는, _편의 (convenience)_ 초기자도 제공합니다. `init()` 초기자는 `[Unnamed]` 라는 `name` 값을 가지고 `Food` 클래스의 `init(name: String)` 으로 옆으로 맡김으로써 새 음식에 기본적인 자리 표시용 이름을 제공합니다:

```swift
let mysteryMeat = Food()
// mysteryMeat 의 이름은 "[Unnamed]" 임
```

계층 구조의 두 번째 클래스는 `RecipeIngredient` 라는 `Food` 의 하위 클래스입니다. `RecipeIngredient` 클래스는 요리법에 있는 재료 (ingredient) 를 모델링합니다. 이는 (`Food` 에서 상속한 `name` 속성에 더하여) `quantity` 라는 `Int` 속성을 도입하고 `RecipeIngredient` 인스턴스를 생성하기 위한 초기자를 두 개 정의합니다:

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

아래 그림은 `RecipeIngredient` 클래스의 초기자 사슬을 보여줍니다:

![Initializer chain for the RecipeIngredient](/assets/Swift/Swift-Programming-Language/Initialization-chain-for-recipe.png)

`RecipeIngredient` 클래스에는, `init(name: String, amount: Int)` 라는, 지명 초기자가 하나 있는데, 이를 사용하면 새 `RecipeIngredient` 인스턴스의 모든 속성을 채울 수 있습니다. 이 초기자는 전달받은 `quantity` 인자를, `RecipeIngredient` 가 도입한 유일한 새 속성인, `quantity` 속성에 할당하는 것으로 시작합니다. 그런 후에, 초기자는 `Food` 클래스의 `init(name: String)` 초기자로 위로 맡깁니다. 이 과정은 위 [Two-Phase Initialization (2-단계 초기화)](#two-phase-initialization-2-단계-초기화) 의 안전성 검사 2 를 만족합니다.

`RecipeIngredient` 는, `init(name: String)` 이라는, 편의 초기자도 정의하는데, 이를 사용하면 이름 단독으로 `RecipeIngredient` 인스턴스를 생성합니다. 이 편의 초기자는 수량을 명시하지 않고 생성한 어떤 `RecipeIngredient` 인스턴스든 수량이 `1` 이라 가정합니다. 이 편의 초기자의 정의는 `RecipeIngredient` 인스턴스 생성을 더 빠르고 편리하게 하며, 여러 가지로 단일-수량 `RecipeIngredient` 인스턴스를 생성할 때 코드 중복을 피하게 합니다. 이 편의 초기자는 단순하게 클래스의 지명 초기자로 옆으로 맡기며, `1` 이라는 `quantity` 값을 전달합니다.

`RecipeIngredient` 에서 제공한 `init(name: String)` 편의 초기자는 `Food` 의 `init(name: String)` _지명 (designated)_ 초기자와 똑같은 매개 변수를 취합니다. 이 편의 초기자는 자신의 상위 클래스 지명 초기자를 재정의하기 때문에, ([Initializer Inheritance and Overriding (초기자 상속 및 재정의)](#initializer-inheritance-and-overriding-초기자-상속-및-재정의) 에서 설명한 것처럼) 반드시 `override` 수정자로 표시해야 합니다.

`RecipeIngredient` 가 `init(name: String)` 초기자를 편의 초기자로 제공할지라도, `RecipeIngredient` 는 그럼에도 불구하고 자신의 모든 상위 클래스 지명 초기자를 구현하고 있습니다. 그러므로, `RecipeIngredient` 는 자동으로 자신의 모든 상위 클래스 편의 초기자도 상속합니다.

이 예제에서, `RecipeIngredient` 의 상위 클래스는 `Food` 인데, `init()` 이라는 편의 초기자가 하나 있습니다. 그러므로 이 초기자를 `RecipeIngredient` 가 상속합니다. `Food` 버전 보단 `RecipeIngredient` 버전의 `init(name: String)` 으로 맡긴다는 걸 제외하면, 상속 버전 `init()` 의 기능은 `Food` 버전과 정확히 똑같습니다.

이 세 초기자 모두를 사용하여 새로운 `RecipeIngredient` 인스턴스를 생성할 수 있습니다:

```swift
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
```

계층 구조의 세 번째이자 최종인 클래스는 `ShoppingListItem` 이라는 `RecipeIngredient` 의 하위 클래스입니다. `ShoppingListItem` 클래스는 쇼핑 목록에 나타난 요리 재료 (recipe ingredient) 를 모델링합니다.

쇼핑 목록의 모든 항목은 "미구매 (unpurchased)" 로 시작합니다. 이 사실을 나타내고자, `false` 라는 기본 값을 가진, `purchased` 라는 불리언 속성을 `ShoppingListItem` 이 도입합니다. `ShoppingListItem` 은 `description` 계산 속성도 추가하여, `ShoppingListItem` 인스턴스의 설명문을 제공합니다:

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

> `ShoppingListItem` 은 `purchased` 의 초기 값을 제공하기 위한 초기자를 정의하지 않는데, (여기서 모델링한) 쇼핑 목록 항목은 항상 미구매로 시작하기 때문입니다.

자기가 도입한 모든 속성에 기본 값을 제공하면서 그 자체론 어떤 초기자도 정의하지 않기 때문에, `ShoppingListItem` 은 자동으로 상위 클래스의 _모든 (all)_ 지명 및 편의 초기자를 상속합니다.

아래 그림은 모든 세 클래스들의 전체적인 초기자 사슬을 보여줍니다:

![Initializer chain for the all](/assets/Swift/Swift-Programming-Language/Initialization-chain-for-all.png)

상속한 세 초기자 모두를 사용하여 새로운 `ShoppingListItem` 인스턴스를 생성할 수 있습니다:

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

여기선, 세 개의 새 `ShoppingListItem` 인스턴스를 담은 배열 글자 값으로 `breakfastList` 라는 새 배열을 생성합니다. 배열 타입은 `[ShoppingListItem]` 으로 추론합니다. 배열을 생성한 후, 배열 맨 처음의 `ShoppingListItem` 이름을 `"[Unnamed]"` 에서 `"Orange juice"` 로 바꾸고 구매 완료로 표시합니다. 배열 각각의 항목에 대한 설명을 인쇄하면 기본 상태가 예상대로 설정된 걸 보여줍니다.

### Failable Initializers (실패 가능 초기자)

초기화를 실패할 수도 있는 클래스, 구조체, 및 열거체를 정의하는 게 유용할 때가 있습니다. 이런 실패를 발동하는 건 무효한 초기화 매개 변수 값이거나, 필수 외부 자원의 없음, 또는 초기화의 성공을 막는 어떠한 다른 조건일 지 모릅니다.

초기화가 실패할 조건에 대처하려면, 클래스, 구조체, 및 열거체 정의 부분에서 실패 가능 초기자를 하나 이상 정의합니다. 실패 가능 초기자는 (`init?` 처럼) `init` 키워드 뒤에 물음표를 둬서 작성합니다.

> 동일한 매개 변수 타입 및 이름을 가진 실패 가능 초기자와 실패하지 않는 초기자를 정의할 순 없습니다.

실패 가능 초기자는 자신이 초기화하는 타입의 _옵셔널 (optional)_ 값을 생성합니다. 실패 가능 초기자 안에서 `return nil` 을 작성하여 초기화 실패를 발동할 수 있는 지점을 표시합니다.

> 엄밀하게 말해서, 초기자는 값을 반환하지 않습니다. 그 보단, 초기화가 끝날 때까지 `self` 를 완전히 그리고 올바로 초기화하도록 보장하는 역할입니다. `return nil` 을 작성하여 초기화 실패를 발동하긴 하지만, `return` 키워드로 초기화 성공을 지시하진 않습니다.[^return-nil-return]

구체적인 사례로, 수치 타입 변환을 위해 구현된 실패 가능 초기자가 있습니다. 수치 타입 변환이 값을 정확하게 유지함을 보장하려면, `init(exactly:)` 초기자를 사용합니다.[^exactly] 타입 변환이 값을 유지할 수 없으면, 초기자가 실패합니다.

```swift
let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
  print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}
// "12345.0 conversion to Int maintains value of 12345" 를 인쇄함

let valueChanged = Int(exactly: pi)
// valueChanged 는, Int 타입이 아니라, Int? 타입입니다.

if valueChanged == nil {
  print("\(pi) conversion to Int does not maintain value")
}
// "3.14159 conversion to Int does not maintain value" 를 인쇄함
```

아래 예제는, `species` 라는 `String` 상수 속성을 가진, `Animal` 이라는 구조체를 정의합니다. `Animal` 구조체는 `species` 라는 단일 매개 변수를 가진 실패 가능 초기자도 정의합니다. 이 초기자는 초기자로 전달된 `species` 값이 빈 문자열인지 검사합니다. 빈 문자열이면, 초기화 실패를 발동합니다. 그 외의 경우, `species` 속성의 값을 설정하여, 초기화를 성공합니다:

```swift
struct Animal {
  let species: String
  init?(species: String) {
    if species.isEmpty { return nil }
    self.species = species
  }
}
```

이 실패 가능 초기자를 사용하면 새로운 `Animal` 인스턴스를 초기화해서 초기화가 성공하는지 검사해 볼 수 있습니다:

```swift
let someCreature = Animal(species: "Giraffe")
// someCreature 의 타입은 Animal? 이지, Animal 이 아님

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
// "An animal was initialized with a species of Giraffe" 를 인쇄함
```

실패 가능 초기자의 `species` 매개 변수에 빈 문자열 값을 전달하면, 초기자가 초기화 실패를 발동합니다:

```swift
let anonymousCreature = Animal(species: "")
// anonymousCreature 의 타입은 Animal? 이지, Animal 이 아님

if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}
// "The anonymous creature could not be initialized" 를 인쇄함
```

> (`"Giraffe"` 라기 보단 `""` 같은) 빈 문자열 값의 검사는 _옵셔널 (optional)_ `String` 값의 없음을 지시하는 `nil` 검사와 똑같지 않습니다. 위 예제에서, 빈 문자열 (`""`) 은 유효한, 옵셔널-아닌 `String` 입니다. 하지만, 동물의 `species` 속성 값이 빈 문자열인 건 적절하지 않습니다. 이런 제약 사항을 모델링하고자, 빈 문자열이면 실패 가능 초기자가 초기화 실패를 발동합니다.

#### Failable Initializers for Enumerations (열거체의 실패 가능 초기자)

실패 가능 초기자를 사용하면 매개 변수를 기초로 하여 적절한 열거체 case 를 선택할 수 있습니다. 그러면 제공한 매개 변수와 적절한 열거체 case 가 일치하지 않은 경우에 초기화가 실패할 수 있습니다.

아래 예제는, (`kelvin`, `celsius`, 및 `fahrenheit` 라는) 세 개의 상태가 가능한, `TemperatureUnit` 이라는 열거체를 정의합니다. 실패 가능 초기자를 사용하여 온도 (temperature) 기호를 나타내는 `Character` 값에 적절한 열거체 case 를 찾습니다:

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

이 실패 가능 초기자를 사용하면 가능한 세 상태에 대한 적절한 열거체 case 를 선택하고 매개 변수가 이 세 상태 중 하나와 일치하지 않으면 초기화를 실패하게 할 수 있습니다:

```swift
let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
  print("This is a defined temperature unit, so initialization succeeded.")
}
// "This is a defined temperature unit, so initialization succeeded." 를 인쇄함

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
  print("This is not a defined temperature unit, so initialization failed.")
}
// "This is not a defined temperature unit, so initialization failed." 를 인쇄함
```

#### Failable Initializers for Enumerations with Raw Values (원시 값이 있는 열거체의 실패 가능 초기자)

원시 값이 있는 열거체는 자동으로, `init?(rawValue:)` 라는, 실패 가능 초기자를 받는데, 이는 `rawValue` 라는 적절한 원시-값 타입의 매개 변수를 취하여 일치한 열거체 case 를 찾으면 이를 선택하고, 일치 값이 없으면 초기화 실패를 발동합니다.

`Character` 타입의 원시 값을 사용하고 `init?(rawValue:)` 초기자라는 이점을 취하도록 위의 `TemperatureUnit` 예제를 재작성할 수 있습니다:

```swift
enum TemperatureUnit: Character {
  case kelvin = "K", celsius = "C", fahrenheit = "F"
}

let fahrenheitUnit = TemperatureUnit(rawValue: "F")
if fahrenheitUnit != nil {
  print("This is a defined temperature unit, so initialization succeeded.")
}
// "This is a defined temperature unit, so initialization succeeded." 를 인쇄함

let unknownUnit = TemperatureUnit(rawValue: "X")
if unknownUnit == nil {
  print("This is not a defined temperature unit, so initialization failed.")
}
// "This is not a defined temperature unit, so initialization failed." 를 인쇄함
```

#### Propagation of Initialization Failure (초기화 실패의 전파)

클래스, 구조체, 및 열거체의 실패 가능 초기자는 동일한 클래스, 구조체, 및 열거체에 있는 다른 실패 가능 초기자로 옆으로 맡길 수 있습니다. 이와 비슷하게, 하위 클래스 실패 가능 초기자는 상위 클래스 실패 가능 초기자로 위로 맡길 수 있습니다.

어느 경우든, 다른 초기자에 맡긴 초기화가 실패하면, 전체 초기화 과정이 곧바로 실패하며, 초기화 코드는 더 이상 실행하지 않습니다.

> 실패 가능 초기자는 실패하지 않는 초기자로도 맡길 수 있습니다. 실패하지 않을 기존 초기화 과정에 실패할 수도 있는 상태를 추가해야 할 경우 이 접근법을 사용합니다.

아래 예제는 `CartItem` 이라는 `Product` 의 하위 클래스를 정의합니다. `CartItem` 클래스는 온라인 장바구니에 있는 항목을 모델링합니다. `CartItem` 은 `quantity` 라는 상수 저장 속성을 도입하여 이 속성이 항상 적어도 `1` 이라는 값을 갖도록 보장합니다:

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

`CartItem` 의 실패 가능 초기자는 받은 `quantity` 값이 `1` 이상인지 검증하는 걸로 시작합니다. `quantity` 가 무효면, 곧바로 전체 초기화 과정을 실패하며 초기화 코드는 더 이상 실행하지 않습니다. 마찬가지로, `Product` 의 실패 가능 초기자는 `name` 값을 검사하여, `name` 이 빈 문자열이면 곧바로 초기화 과정을 실패합니다.

비어있지 않은 이름과 `1` 이상의 수량으로 `CartItem` 인스턴스를 생성하면, 초기화가 성공입니다:

```swift
if let twoSocks = CartItem(name: "sock", quantity: 2) {
  print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
// "Item: sock, quantity: 2" 를 인쇄함
```

`0` 이라는 `quantity` 값으로 `CartItem` 인스턴스를 생성하려 하면, `CartItem` 초기자가 초기화를 실패하게 합니다:

```swift
if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
  print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
  print("Unable to initialize zero shirts")
}
// "Unable to initialize zero shirts" 를 인쇄함
```

이와 비슷하게, 빈 `name` 값으로 `CartItem` 인스턴스를 생성하려 하면, 상위 클래스인 `Product` 의 초기자가 초기화를 실패하게 합니다:

```swift
if let oneUnnamed = CartItem(name: "", quantity: 1) {
  print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
  print("Unable to initialize one unnamed product")
}
// "Unable to initialize one unnamed product" 를 인쇄함
```

#### Overriding a Failable Initializer (실패 가능 초기자 재정의하기)

하위 클래스에서 상위 클래스 실패 가능 초기자를, 다른 어떤 초기자인 것 같이, 재정의 할 수 있습니다. 대안으로, 하위 클래스의 _실패하지 않는 (nonfailable)_ 초기자를 가지고 상위 클래스의 실패 가능 초기자를 재정의할 수 있습니다. 이는, 상위 클래스가 초기화 실패를 허용할지라도, 하위 클래스가 초기화 실패할 순 없도록 정의할 수 있게 합니다.

실패 가능한 상위 클래스 초기자를 실패하지 않는 하위 클래스 초기자로 재정의하면, 위의 상위 클래스로 맡기는 유일한 방법이 실패 가능한 상위 클래스 초기자 결과의 포장을 강제로-푸는 거라는 걸 기억하기 바랍니다.

> 실패 가능 초기자를 실패하지 않는 초기자로 재정의할 순 있지만 그 반대는 아닙니다.

아래 예제는 `Document` 라는 클래스를 정의합니다. 이 클래스는 비어있지 않은 문자열 값 또는 `nil` 일 순 있지만, 빈 문자열일 순 없는, `name` 속성으로 초기화할 수 있는 문서 (document) 를 모델링합니다:

```swift
class Document {
  var name: String?
  // 이 초기자는 nil 이라는 이름 값으로 문서를 생성함
  init() {}
  // 이 초기자는 비어있지 않은 이름 값으로 문서를 생성함
  init?(name: String) {
    if name.isEmpty { return nil }
    self.name = name
  }
}
```

그 다음 예제는 `AutomaticNamedDocument` 라는 `Document` 의 하위 클래스를 정의합니다. `AutomaticNamedDocument` 하위 클래스는 `Document` 가 도입한 지명 초기자 둘 다 재정의합니다. 이러한 재정의는, 이름 없이 인스턴스를 초기화하거나, `init(name:)` 초기자에 빈 문자열을 전달하는 경우에, `AutomaticallyNamedDocument` 인스턴스가 `[Untitled]` 라는 초기 `name` 값을 갖도록 보장합니다:

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

`AutomaticNamedDocument` 는 상위 클래스의 실패 가능 `init?(name:)` 초기자를 실패하지 않는 `init(name:)` 초기자로 재정의합니다. `AutomaticNamedDocument` 는 상위 클래스와는 다른 식으로 빈 문자열인 경우에 대처하기 때문에, 자신의 초기자가 실패할 필요가 없어서, 실패하지 않는 버전의 초기자를 대신 제공합니다.

초기자의 포장을 강제로 풀면 하위 클래스의 실패하지 않는 초기자 구현부에서 상위 클래스의 실패 가능 초기자를 호출할 수 있습니다. 예를 들어, 아래의 `UntitledDocument` 하위 클래스는 항상 `"[Untitled]"` 라는 이름을 붙이며, 초기화 중에 자신의 상위 클래스에 있는 실패 가능 `init(name:)` 초기자를 사용합니다.

```swift
class UntitledDocument: Document {
  override init() {
    super.init(name: "[Untitled]")!
  }
}
```

이 경우, 빈 문자열 이름으로 상위 클래스의 `init(name:)` 초기자를 호출한 거였으면, 포장을 강제로 푸는 연산이 실행시간 에러로 끝났을 겁니다. 하지만, 문자열 상수로 호출했기 때문에, 초기자는 실패하지 않을 거라서, 이 경우 아무런 실행시간 에러도 일어날 수 없다는 걸, 알 수 있습니다.

#### The `init!` Failable Initializer (`init!` 실패 가능 초기자)

전형적으로 `init` 키워드 뒤에 물음표를 (`init?` 라고) 붙임으로써 적절한 타입의 옵셔널 인스턴스를 생성하는 실패 가능 초기자를 정의합니다. 대안으로, 적절한 타입의 암시적으로 포장 푸는 옵셔널 인스턴스를 생성하는 실패 가능 초기자를 정의할 수 있습니다. 이렇게 하려면 `init` 키워드 뒤에 물음표 대신 느낌표를 (`init!` 라고) 붙이면 됩니다.

`init?` 에서 `init!` 로 그리고 그 반대로도 맡길 수 있으며, `init?` 를 `init!` 로 그리고 그 반대로도 재정의할 수 있습니다. `init` 에서 `init!` 으로 맡길 수도 있지만, 그러는 건 `init!` 초기자가 초기화를 실패하면 단언문 (asssertion) 을 발동할 것입니다.

### Required Initializers (필수 초기자)

클래스 초기자 정의 앞에 `required` 수정자를 작성하면 클래스의 모든 하위 클래스가 반드시 그 초기자를 구현할 것을 지시합니다: 

```swift
class SomeClass {
  required init () {
    // 초기자 구현은 여기에 둠
  }
}
```

필수 초기자의 모든 하위 클래스 구현 앞에도 반드시 `required` 수정자를 작성해야, 하위 클래스 사슬 더 밑으로 초기자 필수 조건을 적용함을 지시합니다. 필수 지명 초기자를 재정의할 땐 `override` 수정자를 작성하지 않습니다[^required-override]:

```swift
class SomeSubClass: SomeClass {
  required init () {
    // 하위 클래스의 필수 초기자 구현은 여기에 둠
  }
}
```

> 상속한 초기자로 필수 조건를 만족할 수 있다면 필수 초기자 구현을 명시하지 않아도 됩니다.

### Setting a Default Property Value with a Closure or Function (클로저나 함수로 기본 속성 값 설정하기)

저장 속성의 기본 값에 어떠한 사용자 정의나 설정이 필요하다면, 클로저나 전역 함수를 사용하여 그 속성에 자신만의 기본 값을 제공할 수 있습니다. 속성이 속한 타입이 새 인스턴스를 초기화할 때마다, 클로저나 함수를 호출하고, 그 반환 값을 속성의 기본 값으로 할당합니다.

이런 종류의 클로저나 함수는 전형적으로 속성과 동일한 타입의 임시 값을 생성하여, 원하는 초기 상태를 나타내도록 값을 맞춘 다음, 임시 값을 반환하여 속성의 기본 값으로 사용합니다.

다음은 클로저로 기본 속성 값을 제공하는 방법의 뼈대입니다:

```swift
class SomeClass {
  let someProperty: SomeType = {
    // 이 클로저 안에서 someProperty 의 기본 값을 생성함
    // someValue 와 SomeType 은 반드시 똑같은 타입이어야 함
    return someValue
  }()
}
```

클로저의 중괄호 끝에 빈 괄호 쌍이 붙는다는 걸 기억하기 바랍니다. 이는 스위프트에게 곧바로 클로저를 실행하라고 말합니다. 이 괄호를 생략하면, 클로저의 반환 값이 아니라, 클로저 자체를 속성에 할당하려고 하는 겁니다.

> 클로저를 사용하여 속성을 초기화할 경우, 클로저 실행 시점에 인스턴스 나머지 부분을 아직 초기화하지 않았음을 떠올리기 바랍니다. 이는, 속성에 기본 값이 있는 경우에도, 클로저 안에서 다른 어떤 속성 값에 접근할 순 없다는 의미입니다. 암시적인 `self` 속성을 사용할 수도, 어떤 인스턴스 메소드를 호출할 수도 없습니다.

아래 예제는, 체스 게임판을 모델링하는, `Chessboard` 라는 구조체를 정의합니다. 체스는, 검은색과 흰색 정사각형이 번갈아 있는, 8x8 (크기의) 판에서 합니다.

![Chessboard](/assets/Swift/Swift-Programming-Language/Initialization-chessboard.png)

이 게임판을 나타내기 위해, `Chessboard` 구조체에는, 64개의 `Bool` 값 배열인, `boardColors` 라는 단일한 속성이 있습니다. 배열에서 `true` 값은 검은색 정사각형을 나타내고 `false` 값은 흰색 정사각형을 나타냅니다. 배열의 첫 번째 항목은 게임판의 맨 왼쪽 위 정사각형을 나타내며 배열의 마지막 항목은 게임판의 맨 오른쪽 아래 정사각형을 나타냅니다.

자신의 색상 값을 설정하는 클로저로 `boardColors` 배열을 초기화합니다:

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

새 `Chessboard` 인스턴스를 생성할 때마다, 클로저를 실행하고, `boardColors` 의 기본 값을 계산하여 반환합니다. 위 예제에 있는 클로저는 `temporaryBoard` 라는 임시 배열 판 위의 각 정사각형마다 적절한 색을 계산하여 설정하며, 설정을 완료하고 나면 이 임시 배열을 클로저의 반환 값으로 반환합니다. 반환한 배열 값은 `boardColors` 에 저장되며 `squareIsBlackAt(row:column:)` 라는 보조용 함수로 조회할 수 있습니다:

```swift
let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
// "true" 를 인쇄힘
print(board.squareIsBlackAt(row: 7, column: 7))
// "false" 를 인쇄함
```

### 다음 장

[Deinitialization (뒷정리) >]({% link docs/swift-books/swift-programming-language/deinitialization.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html) 에서 볼 수 있습니다.

[^property-declaration]: 앞서 [Setting Initial Values for Stored Properties (저장 속성에 초기 값 설정하기)](#setting-initial-values-for-stored-properties-저장-속성에-초기-값-설정하기) 부분에선, 기본 값 설정을 속성 정의 (definition) 에서 한다고 했다가, 여기선 속성 선언 (declaration) 에서 지정한다고 말합니다. 이것은, [Declarations (선언)]({% link docs/swift-books/swift-programming-language/declarations.md %}) 장 맨 앞에서 설명한 것처럼, 스위프트에선 이 둘의 구분이 중요하지 않아서, 두 용어를 거의 같은 의미로 사용하기 때문입니다.

[^funnel]: 지명 초기자를 '깔대기' 에 비유한 것은 모든 초기화 과정이 일단 지명 초기자로 모인 다음 위쪽 상위 클래스로 연쇄되는 모습이 깔대기와 흡사하기 때문입니다.

[^convenience]: 이 부분은 원문 자체가 장황하게 설명되어 있는데, 결국 의미 자체는 번역한 문장과 대동소이 하므로, 짧게 줄여서 변역했습니다.

[^base-class]: 기초 클래스 (base class) 는 어떤 클래스로부터도 상속받지 않은 클래스입니다. 계층 구조 맨 위에 있을 수 있는 모든 클래스는 기초 클래스이며, 계층 구조 없이 홀로 존재하는 클래스도 기초 클래스입니다. 기초 클래스에 대한 더 많은 정보는, [Inheritance (상속)]({% link docs/swift-books/swift-programming-language/inheritance.md %}) 장의 [Defining a Base Class (기초 클래스 정의하기)]({% link docs/swift-books/swift-programming-language/inheritance.md %}#defining-a-base-class-기초-클래스-정의하기) 부분을 보도록 합니다. 

[^default-member-initializer]: [Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)]({% link docs/swift-books/swift-programming-language/initialization.md %}#memberwise-initializers-for-structure-types-구조체-타입을-위한-멤버-초기자) 에서 설명한 것처럼, 멤버 초기자는 구조체에만 주어집니다. 즉, 클래스에는 기본 멤버 초기자라는게 따로 없습니다. 구조체의 멤버 초기자 같은 초기자가 클래스에 필요하면, 본문 같이 이를 직접 구현해야 합니다.

[^function-name]: 사실, 초기자는 이름이 없다기 보단 모든 이름이 `init` 으로 똑같은 경우입니다. 그래서, 초기자의 정체를 이름만으로 구별할 순 없습니다.

[^automatic-argument-label]: 스위프트가 자동으로 만들어 주는 인자 이름표는 매개 변수 이름과 똑같습니다.

[^delegate-up]: '상위 클래스 초기자로 맡긴다 (delegate up)' 는 건 '상위 클래스 초기자 중 하나를 호출한다' 는 의미입니다.

[^final-class]: '최종 클래스 (final class)' 는 '상속 구조' 의 가장 밑에 있는 클래스를 말합니다. 스위프트에서 `final` 이라는 키워드는 원래 더 이상 상속을 하지 못하도록 하는 역할을 합니다.

[^exactly]: `init(exactly:)` 초기자를 사용하면 값이 정확하게 유지될 때만 타입을 변환합니다. 본문 예제를 보면 `3.14159` 의 정확한 값을 유지하면서 `Int` 타입으로 변환할 수 없어서 실패합니다.  

[^by-name]: 속성 이름이 자동으로 멤버 초기자의 인자 이름표가 되기 때문에 가능합니다.

[^delegation-calls]: '맡기는 호출 (delegation calls)' 이라고 하는 건 자신이 해야할 일 일부를 맡기는 방식이 다른 초기자를 호출하는 것이기 때문입니다.

[^no-customization]: 반대로 말해서, 하위 클래스 초기자가 단 하나의 사용자 정의라도 하는 순간, 반드시 `super.init()` 호출을 작성해야 합니다.

[^return-nil-return]: `return nil` 이 초기화 실패를 의미한다고 해서, `return` 자체가 초기화 성공을 의미하는 건 아니라는 뜻입니다.

[^required-override]: '필수 (required)' 라는 개념 안에 이미 '재정의 (override)' 라는 개념이 들어가 있기 때문에, 따로 `override` 를 작성할 필요가 없습니다.