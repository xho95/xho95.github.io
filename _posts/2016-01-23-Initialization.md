---
layout: post
comments: true
title:  "Swift 5.2: Initialization (초기화)"
date:   2016-01-23 19:35:00 +0900
categories: Xcode Swift Grammar Initialization
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html) 부분[^Initialization]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Initialization (초기화)

### Setting Initial Values for Stored Properties (저장 속성을 위한 초기 값 설정하기)

#### Initializers (초기자)

#### Default Property Values (기본 설정 속성 값)

위와 같이, 초기자 내에서 저장 속성의 '초기 값 (initial value)' 을 설정할 수 있습니다. 다른 방법은, 속성을 선언하면서 _기본 설정 속성 값 (default property value)_ 을 지정하는 것입니다. '기본 설정 속성 값' 을 지정하려면 속성을 정의할 때 초기 값을 할당하면 됩니다.

> 속성이 받는 초기 값이 항상 같은 경우, 초기자 내에서 값을 설정하는 것 대신 '기본 설정 값' 을 제공하도록 합니다. 최종 결과는 같지만, '기본 설정 값' 은 속성 초기화를 선언과 더 밀접하게 이어줍니다. 이는 초기자를 더 짧고, 더 명확하게 만들고 '기본 설정 값' 으로 속성의 타입을 추론할 수 있게 해줍니다. '기본 설정 값' 은 또, 이 장의 뒷 부분에서 설명하는 것처럼, '기본 설정 초기자 (default initializer)' 와 '초기자 상속 (initializer inheritance)' 이라는 이점을 더 쉽게 활용할 수 있도록 합니다.

`temperature` 속성을 선언하는 시점에 '기본 설정 값' 을 제공하면 위에 있는 `Fahrenheit` 구조체를 더 간단한 양식으로 작성할 수 있습니다:

```swift
struct Fahrenheit {
  var temperature = 32.0
}
```

### Customizing Initialization (자기만의 초기화 방법 만들기)

#### Initialization Parameters (초기화 매개 변수)

#### Parameter Names and Argument Labels (매개 변수 이름과 인자 이름표)

#### Initializer Parameters Without Argument Labels (인자 이름표가 없는 초기자 매개 변수)

#### Optional Property Types (옵셔널 속성 타입)

#### Assigning Constant Properties During Initialization (초기화하는 동안 상수 속성 할당하기)

상수 속성의 값은, 초기화를 마칠 때 값이 정확하게 설정되어 있는 한, 초기화하는 동안 어느 지점에서든 할당할 수 있습니다. 단, 일단 상수 속성에 값이 할당되고 나면, 더 이상 수정할 수 없습니다.

> 클래스 인스턴스의, 상수 속성은 그것을 도입한 클래스의 초기화 중에서만 수정할 수 있습니다. 하위 클래스에서는 수정할 수 없습니다.

위의 `SurveyQuestion` 예제에 있는 `text` 속성을 변수 속성이 아닌 상수 속으로 개정하여, 일단 `SurveyQuestion` 인스턴스가 생성되고 나면 질문이 바뀌지 않을 것임일 지시할 수 있습니다. `text` 속성이 상수가 됐다고 해도, 여전히 클래스의 초기자에서 설정할 수 있습니다:

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

스위프트는 어떤 구조체나 클래스가 모든 속성에 대한 '기본 설정 값 (default values)' 을 제공하면서도 스스로는 단 하나의 초기자도 제공하지 않을 경우 '_기본 설정 초기자 (default initializer)_' 를 제공합니다. '기본 설정 초기자' 는 새로운 인스턴스를 생성할 때 모든 속성을 단순히 '기본 설정 값' 으로 설정합니다.

다음 예제는 `ShoppingListItem` 이라는 클래스를 정의하여, 구매 목록의 각 항목에 대한 '이름', '수량', 그리고 '구매 상태 (purchase state)' 를 담아둡니다:

```swift
class ShoppingListItem {
  var name: String?
  var quantity = 1
  var purchased = false
}
var item = ShoppingListItem()
```

`ShoppingListItem` 클래스는 모든 속성이 '기본 설정 값' 을 가지고 있고, 상위 클래스가 없는 '기본 클래스 (base class)' 이므로, 자동적으로 '기본 설정 초기자' 구현을 가지며 이로써 새 인스턴스를 생성할 때 모든 속성을 '기본 설정 값' 으로 설정할 수 있습니다. (`name` 속성은 '옵셔널 (optional)' `String` 속성이므로, 자동적으로 `nil` 이라는 '기본 설정 값' 을 가지므로, 이 값을 코드에 굳이 안써도 됩니다.) 위의 예제는 `ShoppingListItem` 클래스의 '기본 설정 초기자' 를 사용하여 새 인스턴스를 생성하면서, `ShoppingListItem()` 와 같이, '초기자 구문 표현 (initializer syntax)' 를 썼으며, 이 새 인스턴스를 `item` 이라는 변수에 할당했습니다.

### Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)

구조체 타입은 자기 스스로 어떤 초기자도 직접 정의하고 있지 않을 경우 자동적으로 '_멤버 초기자 (memberwise initializer)_' 를 가지게 됩니다. '기본 설정 초기자' 와는 달리, 구조체의 '저장 속성 (stored properties)' 에 '기본 설정 값' 이 없어도 '멤버 초기자' 는 가집니다.

'멤버 초기자' 는 새로운 구조체 인스턴스의 멤버 속성을 초기화하는 '약칭법 (shorthand way)' 에 해당합니다. 새 인스턴스의 속성에 대한 '초기 값' 을 '멤버 초기자' 에 전달하려면 이름을 사용하면 됩니다.

아래 예제는 `width` 와 `height` 라는 두 속성을 가지는 `Size` 라는 구조체를 정의합니다. 두 속성 모두 '기본 설정 값' 이 `0.0` 으로 할당되므로 타입은 `Double` 로 추론됩니다.

`Size` 구조체는 자동적으로 `init(width:height:)` 멤버 초기자를 가지게 되므로, 이것을 써서 새 `Size` 인스턴스를 초기화할 수 있습니다:

```swift
struct Size {
  var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
```

멤버 초기자를 호출할 때, 기본 속성을 가지고 있는 속성은 그 값을 생략할 수도 있습니다. 위의 예에서, `Size` 구조체의 `height` 와 `width` 속성은 둘 다 '기본 설정 값' 을 가지고 있습니다. 따라서 둘 중 하나 또는 두 속성 모두 생략할 수 있으며, 생략된 것은 '기본 설정 값' 으로 초기화 됩니다-예를 들면 다음과 같습니다:

```swift
let zeroByTwo = Size(height: 2.0)
print(zeroByTwo.width, zeroByTwo.height)
// "0.0 2.0" 를 출력합니다.

let zeroByZero = Size()
print(zeroByZero.width, zeroByZero.height)
// "0.0 0.0" 를 출력합니다.
```

### Initializer Delegation for Value Types (값 타입을 위한 초기자 위임하기)

초기자는 다른 초기자를 호출하여 인스턴스 초기화의 일부를 진행할 수 있습니다. 이 과정을, _초기자 위임 (initializer delegation)_ 이라고 하는데, 여러 초기자에서 코드가 중복되는 것을 피하도록 해줍니다.

초기자 위임의 작동 방식에 대한 규칙 및 위임에서 허용하는 양식에 대한 규칙은, 값 타입과 클래스 타입에 따라 다릅니다. 값 타입 (구조체와 열거체 같은) 은 상속을 지원하지 않으므로, 초기자 위임 과정이 상대적으로 간단한데, 이는 자기가 제공하는 또 다른 초기자로만 위임을 할 수 있기 때문입니다. 클래스는, 하지만, [Inheritance (상속)]({% post_url 2020-03-31-Inheritance %}) 에서 설명한 대로, 다른 클래스를 상속할 수 있습니다. 이것이 의미하는 바는 클래스는 초기화하는 동안 자신이 상속한 모든 저장 속성에 알맞은 값을 할당했음을 보장하는 추가적인 책임을 가진다는 것입니다. 이러한 책임은 아래의 [Class Inheritance and Initialization (클래스 상속과 초기화)](#class-inheritance-and-initialization-클래스-상속과-초기화) 에서 설명합니다.

값 타입에서는, 자신만의 사용자 정의 초기자를 작성할 때 `self.init` 로 같은 값 타입에 있는 다른 초기자를 참조할 수 있습니다. `self.init` 은 초기자 내에서만 호출할 수 있습니다.

값 타입에서 직접 사용자 정의 초기자를 정의하게 되면, 더 이상 그 타입에 대한 기본 설정 초기자에 (또는, 구조체일 경우, 멤버 초기자에도) 접근할 수 없게 된다는 것을 기억하기 바랍니다. 이러한 구속 조건은 더 복잡한 초기자가 제공하는 추가적인 핵심 설정 작업이 누군가 자동으로 제공되는 초기자 중 하나를 사용하는 바람에 우회해 버리는 상황을 막아줍니다.

> 자신이 직접 만든 값 타입이 '기본 설정 초기자' 와 '멤버 초기자' 로 초기화 가능하면서, 사용자 정의 초기자로도 초기화 가능하도록 하고 싶으면, 자기만의 사용자 정의 초기자를 값 타입의 원래 구현부가 아니라 'extension (확장)' 에서 작성하도록 합니다. 더 많은 정보는, [Extensions (확장)]({% post_url 2016-01-19-Extensions %}) 을 참고하기 바랍니다.

다음 예제는 기하학적인 사각형을 나타내는 사용자 정의 구조체인 `Rect` 를 정의합니다. 이 예제에서는 `Size` 와 `Point` 라는 두 개의 보조용 구조체가 필요한데, 이 둘의 모든 속성은 기본값으로 `0.0` 을 제공합니다:

```swift
struct Size {
  var width = 0.0, height = 0.0
}
struct Point {
  var x = 0.0, y = 0.0
}
```

아래에 있는 `Rect` 구조체는 세 가지 방법 중 하나로 초기화할 수 있습니다-`origin` 과 `size` 속성을 기본 값인 `0` 으로 초기화하는 것을 사용하거나, 원점과 크기에 지정된 값을 제공하거나, 중심점과 크기에 지정된 값을 제공하는 것입니다. 이런 초기화 시의 선택 사항들은 `Rect` 구조체의 정의 부분에 있는 세 개의 사용자 정의 초기자로 표현됩니다:

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

첫 번째 `Rect` 초기자인, `init()` 는, 사용자 정의 초기자가 없는 구조체가 가지는, '기본 설정 초기자 (default initializer)' 와 기능이 같습니다. 이 초기자는 본문이 비어 있는데, 이는 비어있는 중괄호 `{}` 로 표현되었습니다. 이 초기자를 호출하면 `origin` 과 `size` 속성 모두 각 속성에서 정의한 대로 기본 값인 `Point(x: 0.0, y: 0.0)` 및 `Size(width: 0.0, height: 0.0)` 로 초기화된 `Rect` 인스턴스를 반환합니다:

```swift
let basicRect = Rect()
// basicRect 의 원점은 (0.0, 0.0) 이고 크기는 (0.0, 0.0) 입니다.
```

두 번째 `Rect` 초기자인, `init(origin:size:)` 는, 사용자 정의 초기자가 없는 구조체가 가지는, '멤버 초기자 (memberwise initialzier)' 와 기능이 같습니다. 이 초기자는 단순히 `origin` 과 `size` 인자 값을 알맞은 저장 속성에 할당하기만 합니다:

```swift
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
// originRect 의 원점은 (2.0, 2.0) 이고 크기는 (5.0, 5.0) 입니다.
```

세 번째 `Rect` 초기자인, `init(center:size:)` 는, 조금 더 복잡합니다. 이것은 일단 `center` 와 `size` 값으로 적절한 원점을 계산하는 것으로 시작합니다. 그 다음 `init(origin:size:)` 초기자를 호출 (또는 '_delegates (위임)_') 하여, 새로운 원점과 크기 값을 알맞은 속성에 저장합니다:

```swift
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
// centerRect 의 원점은 (2.5, 2.5) 이고 크기는 (3.0, 3.0) 입니다.
```

`init(center:size:)` 초기자가 직접 새로운 `origin` 과 `size` 값을 알맞은 속성에 할당할 수도 있습니다. 하지만, 이미 그 기능을 정확하게 제공하는 초기자 있을 경우 `init(center:size:)` 초기자가 이를 활용하도록 하는 것이 더 편리하면서 (의도로 명확하게) 해줍니다.

> 이 예제를 작성하는 다른 방법은 `init()` 과 `init(origin:size:)` 초기자를 직접 정의하지 않는 것인데, 이에 대해서는 [Extensions (확장)]({% post_url 2016-01-19-Extensions %}) 을 참고하기 바랍니다.

### Class Inheritance and Initialization (클래스 상속과 초기화)

#### Designated Initializers and Convenience Initializers ('지명 초기자' 와 '편의 초기자')

#### Syntax for Designated and Convenience Initializers ('지명 초기자' 와 '편의 초기자' 의 구문 표현)

#### Initializer Delegation for Class Types (클래스 타입을 위한 초기자 위임하기)

'지명 초기자 (designated initializers)' 와 '편의 초기자 (convenience initializers)' 사이의 관계를 단순화하기 위해, 스위프트는 초기자 간의 '위임 호출 (delegation calls)' 에 대해서 다음의 세 가지 규칙을 적용합니다:

**Rule 1 (규칙 1)**

  지명 초기자는 반드시 자신의 직속 상위 클래스에 있는 지명 초기자를 호출해야 합니다.

**Rule 2 (규칙 2)**

  편의 초기자는 반드시 _같은 (same)_ 클래스에 있는 다른 초기자를 호출해야 합니다.

**Rule 3 (규칙 3)**

  편의 초기자는 궁극적으로 반드시 지명 초기자를 호출해야 합니다.

이것을 기억하는 간단한 방법은 다음과 같습니다:

* 지명 초기자는 항상 반드시 _위로 (up)_ 위임합니다.
* 편의 초기자는 항상 반드시 _옆으로 (across)_ 위임합니다.

이 규칙을 그림으로 도식화하면 다음과 같습니다:

![delegation rules](/assets/Swift/Swift-Programming-Language/Initialization-delegation-rules.jpg)

여기서, 상위 클래스는 한 개의 지명 초기자와 두 개의 편의 초기자를 가지고 있습니다. 한 '편의 초기자' 는 다른 편의 초기자를 호출하고, 그 다음 차례로 지명 초기자를 호출합니다. 이는 위의 '규칙 2' 와 '규칙 3' 을 만족시킵니다. 상위 클래스 그 자체는 다른 상위 클래스를 가지지 않으므로, '규칙 1' 은 적용되지 않습니다.

이 그림에 있는 하위 클래스는 두 개의 지명 초기자와 한 개의 편의 초기자를 가지고 있습니다. 편의 초기자는 반드시 두 개의 지명 초기자 중 하나를 호출할 수 밖에 없는데, 왜냐면 같은 클래스에 있는 다른 초기자만 호출할 수 있기 때문입니다. 이것은 위의 '규칙 2' 와 '규칙 3' 을 만족시킵니다. 두 개의 지명 초기자 모두 반드시 상위 클래스에 있는 단일 지명 초기자를 호출해야 하며, 이로써 위의 '규칙 1' 을 만족하게 됩니다.

> 이 규칙은 클래스의 사용자가 각 클래스의 인스턴스를 _생성하는 (create)_ 방법에는 영향을 주지 않습니다. 위 도표에 있는 초기자라면 어떤 것을 사용해도 자신이 속한 클래스의 완전히 초기화된 인스턴스를 생성할 수 있습니다. 즉, 이 규칙은 클래스의 초기자를 구현하는 방법에만 영향을 줍니다.

아래 그림은 네 개의 클래스에 대한 더 복잡한 클래스 계층 구조를 보입니다. 이는 지명 초기자가 계층 구조에서, 클래스 사이의 연쇄적인 상호 관계를 단순화하는, 클래스 초기화의 "합류 (funnel)" 점으로 작용하는 방법을 나타내고 있습니다:

![funnel points](/assets/Swift/Swift-Programming-Language/Initialization-funnel.png)

#### Two-Phase Initialization (초기화의 두-단계)

**Safety Check 1 (안전성 검사 1)**

**Safety Check 2 (안전성 검사 2)**

**Safety Check 3 (안전성 검사 3)**

**Safety Check 4 (안전성 검사 4)**

**Phase 1 (단계 1)**

**Phase 2 (단계 2)**

#### Initializer Inheritance and Overriding (초기자 상속과 재정의)

#### Automatic Initializer Inheritance (자동적인 초기자 상속)

앞서 언급한 대로, 하위 클래스는 기본적으로 상위 클래스의 초기자를 상속받지 않습니다. 하지만, 지정된 조건을 만족할 경우에는 상위 클래스의 초기자를 자동적으로 상속 _받습니다. (are)_. 실제로, 이것은 일반적인 많은 상황에서 초기자를 '재정의 (override)' 할 필요는 없으며, 안전하기만 하다면 언제든 최소한의 노력으로 상위 클래스의 초기자를 상속받을 수 있다는 것을 의미합니다.

'하위 클래스' 에서 새로 도입한 모든 속성에 대해 '기본 설정 값' 을 제공한다고 가정하면, 다음의 두 규칙이 적용됩니다:

**규칙 1**

  하위 클래스에서 어떤 '지명 초기자 (designated Initializer)' 도 정의하지 않았을 경우, 상위 클래스의 모든 '지명 초기자' 를 자동으로 상속받습니다.

**규칙 2**

  하위 클래스에서 상위 클래스의 '지명 초기자' 에 대한 모든 구현을 제공할 경우-'규칙 1' 에 의해서 상속을 받았든, 정의하면서 직접 구현을 제공했든 상관없이-이 때는 상위 클래스의 모든 '편의 초기자 (convenience Initializers)' 를 자동으로 상속받습니다.

이 규칙은 하위 클래스에서 '편의 초기자' 를 더 추가했어도 그대로 적용됩니다.

> '규칙 2' 를 만족하기 위한 방편으로, 상위 클래스의 '지명 초기자' 를 하위 클래스에서 '편의 초기자' 의 형태로 구현할 수도 있습니다.

#### Designated and Convenience Initialization in Action ('지명 초기자' 와 '편의 초기자' 의 실제 사례)

### Failable Initializers (실패 가능한 초기자)

#### Failable Initializers for Enumerations (열거체를 위한 실패 가능한 초기자)

#### Failable Initializers for Enumerations with Raw Values (원시 값을 갖는 열거체를 위한 실패 가능한 초기자)

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
