---
layout: post
title:  "Swift 문법 정리: Default Initializers"
date:   2016-01-23 19:35:00 +0900
categories: Xcode Swift Grammar Initializers
---

이 포스트는 Apple의 공식 문서인 Swift Programming Language의 내용 중에서 [Default Initializers](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203)에 대한 부분을 정리한 것이다.[^Default Initializers]


### 기본 초기자

C++에서는 클래스를 이용하여 사용자 정의 타입을 새로 만들 경우, 조건에 따라서 자동적으로 생성되는 특수한 함수들이 있다. 보통 이것들은 기본 생성자나 복사 생성자와 같은 것들이다.

Swift에서도 C++에서와 같이 사용자 정의 타입에 대해 자동으로 생성되는 함수들이 있는데, 이들을 기본 초기자(Default Initializers)라고 한다.

> Swift에서의 초기자(Initializers)라는 것은 C++에서의 생성자와 사실상 같은 것들인데, 이름을 초기자라고 한 것은 아마도 타입의 정의와 초기화를 동시에 하는 것을 선호하는 현대 프로그래밍 방식에서 이름을 따온 듯 하다. (물론 Apple의 자존심상 자신들이 만든 언어에 다른 언어에 있는 명칭을 쓰고 싶지 않은 마음도 있었겠지...)

이러한 기본 초기자에는 클래스와 구조체에서 모두 제공하는 기본 초기자가 있고, 구조체에서만 특별히 제공하는 초기자가 있다.


### 클래스와 구조체에서 모두 제공하는 기본 초기자

Swift에서는 클래스와 구조체에 대해, 그들이 모든 속성(properties)들에 대해 기본값(default values)을 제공하면서 아무런 초기자를 제공하지 않으면 기본 초기자를 자동으로 만들어준다. 이 기본 초기자는 단순히 새로운 인스턴스(instance)를 만들면서 이 속성들을 기본값으로 초기화하는 역할을 수행한다.

> 여기서 아무런 초기자를 제공하지 않는다는 조건이 중요한데, 클래스의 경우 자신이 초기자를 제공해주지 않아도 상속에 의해서 초기자를 제공할 수도 있다. 따라서 클래스에서 기본 초기자가 자동으로 생기는 경우는 초기자가 없는 기반 클래스(base class)와 같이 특수한 경우일 때로 한정된다.

기본 초기자는 초기자 구문(initializer syntax)을 사용하여 호출하는데, 이것은 단순히 클래스 이름 뒤에 빈괄호가 있는 구문이다.

```Swift
  class BaseClass {
    var name: String?
    var isABaseClass = true
  }

  var aClass = BaseClass()      // initializer syntax
```

위 코드에서는 BaseClass를 정의하면서 모든 속성에 기본값을 제공했지만 초기자를 제공하지는 않았다. (참고로, name은 optional 타입이기 때문에 자동으로 nill이 기본값으로 제공된다.)

이 경우 컴파일러가 자동으로 기본 초기자를 제공하며, `BaseClass()`와 같이 초기자 구문을 사용하여 초기자를 호출할 수 있다.


### 구조체에서만 특별히 제공하는 초기자

위에서 클래스와 구조체는 초기자를 제공하지 않을 때, 기본 초기자를 자동으로 제공한다고 했는데, 구조체에서는 이 경우 또 다른 초기자를 하나 더 제공한다.

이것을 `memberwise initializer`라고 한다. 우리말로 하면 `멤버 초기자` 정도로 할 수 있을 것이다. 이 초기자는 호출하면서 각 멤버에 대해 초기값을 같이 전달할 수 있는 초기자이다.

아래에 간단한 예를 나타냈다.

```Swift
  class Size {
    var width = 10, height = 20
  }

  var newSize = Size(width: 5, height: 10)      // memberwise initializer
```

위의 코드를 보면 앞의 BaseClass와 같은 상황인데, 멤버 초기자를 호출하여 newSize를 생성할 수 있음을 알 수 있다. 이 경우 초기값은 기본값과는 다르게 멤버 초기자에서 제공한 값으로 설정된다.

> 초기자에서 바로 초기값을 전달할 수 있으므로 구조체에서는 멤버에 대해 기본값을 제공하지 않아도 인스턴스를 만들 수 있다. 물론 이렇게 하면 기본 초기자가 생기지 않으므로 기본 초기자로 구조체를 생성할 수는 없게 된다.

```Swift
  class Size {
    var width: Double                             
    var height: Double
  }

  var newSize = Size(width: 10, height: 20)      // memberwise initializer

  // 여기서는, Size()를 직접 호출할 수 없다.
```

위에서는 앞서의 예제와는 다르게 처음부터 기본값을 제공하지 않았다. 하지만 이 경우에도 멤버 초기자를 호출할 수 있음을 알 수 있다. 대신에 이제는 기본 초기자를 직접 호출할 수는 없다.


### 고찰 하기

구조체에서 두 예제를 비교해 보면 기본값을 제공하는 경우가 `annotation` 자체도 줄일 수 있어서 실제 사용할 경우 더 편한 것 같다.


### 참고 자료

[^Default Initializers]: Default Initializers에 대한 내용은 [Swift Programming Language](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/index.html)에서 [Initializers](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203) 부분에 정리되어 있다.
