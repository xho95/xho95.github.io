---
layout: post
title:  "Swift 문법 정리: Default Initializers"
date:   2016-01-23 19:35:00 +0900
categories: Xcode Swift Grammar Initializers
---

C++에서는 클래스를 이용하여 사용자 정의 타입을 새로 만들 경우, 조건에 따라서 자동적으로 생성되는 특수한 함수들이 있다. 보통 이것들은 기본 생성자나 복사 생성자와 같은 것들이다.

Swift에서도 C++에서와 같이 사용자 정의 타입에 대해 자동으로 생성되는 함수들이 있는데, 이들을 기본 초기자들(Default Initializers)이다.

> Swift에서의 초기자(Initializers)라는 것은 C++에서의 생성자와 사실상 같은 것들인데, 이름을 초기자라고 한 것은 아마도 타입의 정의와 초기화를 동시에 하는 것을 선호하는 현대 프로그래밍 방식에서 이름을 따온 듯 하다. (물론 Apple의 자존심상 자신들이 만든 언어에 다른 언어에 있는 명칭을 쓰고 싶지 않은 마음도 있었겠지...)

이러한 기본 초기자에는 클래스와 구조체 모두 제공하는 기본 초기자가 있고, 구조체에서만 특별히 제공하는 기본 초기자가 있다.


### 클래스와 구조체에서 모두 제공하는 기본 초기자

Swift에서는 클래스와 구조체에 대해, 그들이 모든 멤버 속성들에 대해 기본값(default values)을 제공하면서 아무런 초기자를 제공하지 않으면 기본 초기자를 자동으로 만들어준다. 이 기본 초기자는 새로운 인스턴스(instance)를 만들면서 단순하게도 멤버 속성들을 기본값으로 초기화한다.

> 여기서 아무런 초기자를 제공하지 않는다는 점이 중요한데, 클래스의 경우 상속만 하더라도 자동적으로 초기자가 생길 수도 있기 때문이다. 따라서 클래스에서 기본 초기자가 생기는 경우는 기반 클래스(base class)와 같이 특수한 경우일 때로 한정된다.

기본 초기자는 초기자 구문(initializer syntax)을 사용하여 호출하는데, 이것은 단순히 클래스 이름뒤에 빈괄호가 있는 구문이다.

```Swift
  class BaseClass {
    var name: String?
    var isABaseClass = true
  }

  var aClass = BaseClass()      // initializer syntax
```


### 구조체에서만 특별히 제공하는 초기자

위에서 클래스와 구조체에 대해 아무런 초기자를 제공하지 않으면 기본 초기자를 자동으로 제공한다고 했는데, 구조체에서는 이 경우 클래스와는 다르게 또 하나의 초기자를 제공한다.

이것을 `memberwise initializer`라고 한다. 우리말로 하면 `멤버에 대한 초기자`라고 해야하나? 이 초기자는 호출하면서 각 멤버에 대해 초기값을 같이 전달할 수 있는 초기자이다.

```Swift
  class Size {
    var width = 10, height = 20
  }

  var newSize = Size(width: 5, height: 10)      // memberwise initializer
```

> 초기자에서 바로 초기값을 전달할 수 있으므로 구조체에서는 멤버에 대해 기본값을 제공하지 않아도 인스턴스를 만들 수 있다. 물론 이렇게 하면 기본 초기자가 생기지 않으므로 기본 초기자로 구조체를 생성할 수는 없게 된다.

```Swift
  class Size {
    var width: Double                             
    var height: Double
  }

  var newSize = Size(width: 10, height: 20)      // memberwise initializer

  // 여기서는, Size()를 직접 호출할 수 없다.
```

기본값이 있는 경우가 `annotation`을 줄일 수 있어서 더 편한 것 같기는 하다.
