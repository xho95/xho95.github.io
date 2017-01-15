---
layout: post
comments: true
title:  "Swift 2.2: 기본 초기자(Default Initializers)"
date:   2016-01-23 19:35:00 +0900
categories: Xcode Swift Grammar Initializers
---

이 글에서는 Apple에서 제공하는 Swift 공식 문서인 **The Swift Programming Language** 의 내용 중에서 [Default Initializers](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203)에 대한 부분을 정리하도록 합니다.[^Default_Initializers]

Swift 언어에는 다른 프로그래밍 언어들과 유사하면서도 조금은 달라보이는 개념들을 사용하곤 하는데, 지금 살펴볼 초기자(initializers)라는 개념도 그런 것입니다. 처음보면 약간은 헷갈릴 수도 있는 부분인데 우선은 전체 초기자의 내용 중 기본 초기자(default initializers) 부분만 옮겨봤습니다.

### 기본 초기자

C++에서는 클래스로 사용자 정의 타입을 새로 만들 경우, 조건에 따라서 자동으로 생성되는 특수한 멤버 함수들이 있습니다. 보통 여기에는 기본 생성자나 복사 생성자와 같은 것들이 해당됩니다.

Swift에도 C++에서와 같이 사용자 정의 타입에 대해 자동으로 생성되는 멤버 함수들이 있는데, 기본 초기자(Default Initializers)가 여기에 해당됩니다.

> Swift에서의 초기자(Initializers)라는 것은 C++에서의 생성자와 같은 역할을 하는 멤버 함수 입니다. 하지만, Swift에서는 인스턴스를 만들 때 해당 타입에 대해 초기화도 반드시 이루어지도록 강제합니다. 이것은 타입 체크 및 추론을 강하게 하는 현대 프로그래밍 방식의 경향을 따르는 것인데, 타입의 정의시에 초기화까지 이루어 지므로 이름을 초기자라고 하지 않았을까 유추해 봅니다. (물론 Apple의 자존심상 자신들이 만든 언어에 다른 언어에 있는 명칭을 쓰지 않고 자신들만의 명칭을 만들어내고 싶은 마음도 있지 않았을까 생각합니다.)

이러한 기본 초기자는 클래스와 구조체에서 모두 제공되는데, 구조체에는 특별히 멤버 초기자라는 것도 추가로 제공합니다. 멤버 초기자에 대해서는 기본 초기자에 이어서 언급하겠습니다.


### 클래스와 구조체 타입에서 제공하는 기본 초기자

Swift에서는 클래스와 구조체에 대해, 그들이 모든 속성(properties)에 대해 기본값(default values)을 제공하면서 아무런 초기자를 제공하지 않으면 그 타입에 대해 기본 초기자를 자동으로 만들어줍니다. 이 기본 초기자는 새로운 인스턴스(instance)를 만들 때 해당 타입에 대한 속성들을 단순히 기본값으로 초기화하는 역할을 수행합니다.

> 여기서 아무런 초기자를 제공하지 않는다는 조건이 중요한데, 클래스의 경우 겉으로는 자신이 초기자를 제공해주지 않는 것처럼 보여도 상속에 의해 초기자를 제공하는 경우도 발생합니다. 따라서 자신의 의도와는 다르게 기본 초기자가 제공되지 않을 수도 있으므로 주의가 필요합니다. 그리고 클래스에서 초기자를 제공하지 않는 경우는 보통 기반 클래스(base class)와 같이 특수한 경우일 때 뿐이므로 만약 다른 경우에도 기본 초기자를 쓰고 싶을 때는 사용자가 명시적으로 기본 초기자와 같은 것을 만들어줘야 할 때가 있습니다.

기본 초기자는 초기자 구문(initializer syntax)을 사용하여 호출하는데, 이것은 단순히 클래스 이름 뒤에 빈괄호가 있는 구문입니다.

```swift
  class WidgetClass {
    var name: String?
    var isBaseClass = true
  }

  var myWidget = WidgetClass()      // initializer syntax
```

위 코드에서는 WidgetClass를 정의하면서 모든 속성에 기본값을 제공했지만 초기자를 제공하지는 않습니다. (참고로, name은 optional 타입이기 때문에 기본값이 `nill`로 제공됩니다.)

이 경우 컴파일러가 자동으로 기본 초기자를 제공하며, `WidgetClass()`와 같이 초기자 구문을 사용하여 초기자를 호출할 수 있게 됩니다.


### 구조체에서만 특별히 제공하는 멤버 초기자

위에서 클래스와 구조체는 초기자를 제공하지 않을 때, 기본 초기자를 자동으로 제공한다고 했는데, 구조체에서는 또 다른 초기자가 하나 더 있습니다.

이것을 `memberwise initializer`라고 하는데, 우리말로 하면 `멤버 초기자` 정도로 옮길 수 있을 것 같습니다. 이 초기자는 호출하면서 각 멤버에 대한 초기값을 같이 전달할 수 있는 초기자입니다.

아래에 간단한 예를 나타냈습니다.

```swift
  struct WidgetSize {
    var width = 10, height = 20
  }

  var widgetSize = WidgetSize(width: 5, height: 10)      // memberwise initializer
```

위의 코드를 보면 앞의 WidgetClass와 같은 상황인데, 멤버 초기자를 호출하여 widgetSize를 생성할 수 있음을 알 수 있습니다. 이 경우 초기값은 기본값과는 다르게 멤버 초기자에서 제공한 값으로 설정됩니다.

> 초기자에서 바로 초기값을 전달할 수 있으므로 구조체에서는 멤버에 대해 기본값을 제공하지 않아도 인스턴스를 만들 수 있습니다. 물론 이렇게 하면 기본 초기자가 생기지 않으므로 기본 초기자로 구조체를 생성할 수는 없게 됩니다. 기본 초기자는 기본값을 제공할 때만 자동으로 제공된다는 점을 기억하십시오.

```swift
  struct WidgetSize {
    var width: Double                             
    var height: Double
  }

  var newWidgetSize = WidgetSize(width: 10, height: 20)      // memberwise initializer

  // 여기서는, WidgetSize()를 직접 호출할 수 없다.
```

위에서는 앞서의 예제와는 다르게 기본값을 제공하지 않았습니다. 하지만 이 경우에도 멤버 초기자는 호출할 수 있음을 알 수 있습니다. 대신에 이제는 기본 초기자를 직접 호출할 수는 없게 됩니다.


### 고찰 하기

구조체에서 두 예제를 비교해 보면 기본값을 제공하는 경우가 `annotation` 자체도 줄일 수 있어서 실제 사용할 경우 더 편합니다.

그리고 클래스가 멤버 초기자를 기본으로 제공하지 않는 것은 클래스가 레퍼런스 타입이기 때문일 것으로 추측됩니다. 이 부분에 대해서는 나중에 좀 더 알게되면 정리하도록 하겠습니다.

클래스의 기본 초기자를 살펴보면 결국 Swift에서는 어떤 경우든 객체가 생성되는 시점에서 모든 속성의 초기화가 이루어지도록 강제함을 알 수 있습니다. **The Swift Programming Language** 에서도 Swift는 강한 타입 언어임을 강조하고 있는데, 객체가 생성되는 시점에 값이 초기화가 되어야 해당 객체에 대한 타입을 추론할 수 있어, 강하게 타입 체크를 할 수 있게 됩니다.


### 참고 자료

[^Default_Initializers]: Default Initializers에 대한 내용은 [Swift Programming Language](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/index.html)에서 [Initializers](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203) 부분에 정리되어 있다.
