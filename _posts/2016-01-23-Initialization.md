---
layout: post
comments: true
title:  "Swift 5.2: Initialization (객체 초기화하기)"
date:   2016-01-23 19:35:00 +0900
categories: Xcode Swift Grammar Initialization
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html) 부분[^Initialization]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Initialization (객체 초기화하기)

### Setting Initial Values for Stored Properties (저장 속성을 위한 기본 설정 값 설정하기)

#### Initializers (초기자)

#### Default Property Values (기본 속성 값)

### Customizing Initialization (자기만의 초기화 방법 만들기)

#### Initialization Parameters (초기화 매개 변수)

#### Parameter Names and Argument Labels (매개 변수 이름과 인자 이름표)

#### Initializer Parameters Without Argument Labels (인자 이름표가 없는 초기자 매개 변수)

#### Optional Property Types (옵셔널 속성 타입)

#### Assigning Constant Properties During Initialization (초기화하는 동안 상수 속성 할당하기)

### Default Initializers (기본 초기자)

C++에서는 클래스로 사용자 정의 타입을 새로 만들 경우, 조건에 따라서 자동으로 생성되는 특수한 멤버 함수들이 있습니다. 보통 여기에는 기본 생성자나 복사 생성자와 같은 것들이 해당됩니다.

Swift에도 C++에서와 같이 사용자 정의 타입에 대해 자동으로 생성되는 멤버 함수들이 있는데, 기본 초기자(Default Initializers)가 여기에 해당됩니다.

> Swift에서의 초기자(Initializers)라는 것은 C++에서의 생성자와 같은 역할을 하는 멤버 함수 입니다. 하지만, Swift에서는 인스턴스를 만들 때 해당 타입에 대해 초기화도 반드시 이루어지도록 강제합니다. 이것은 타입 체크 및 추론을 강하게 하는 현대 프로그래밍 방식의 경향을 따르는 것인데, 타입의 정의시에 초기화까지 이루어 지므로 이름을 초기자라고 하지 않았을까 유추해 봅니다. (물론 Apple의 자존심상 자신들이 만든 언어에 다른 언어에 있는 명칭을 쓰지 않고 자신들만의 명칭을 만들어내고 싶은 마음도 있지 않았을까 생각합니다.)

이러한 기본 초기자는 클래스와 구조체에서 모두 제공되는데, 구조체에는 특별히 멤버 초기자라는 것도 추가로 제공합니다. 멤버 초기자에 대해서는 기본 초기자에 이어서 언급하겠습니다.

### Memberwise Initializers for Structure Types (구조체 타입에 대한 멤버 초기자)

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

### Initial Delegation for Value Types (값 타입을 위한 초기화 위임하기)

### Class Inheritance and Initialization (클래스 상속과 초기화)

#### Designated Initializers and Convenience Initializers (지명된 초기자와 편의 초기자)

#### Syntax for Designated and Convenience Initializers (지명된 초기자와 편의 초기자의 구문 표현)

#### Initializer Delegation for Class Type (클래스 타입을 위한 초기자 위임하기)

**Rule 1 (규칙 1)**

**Rule 2 (규칙 2)**

**Rule 3 (규칙 3)**

#### Two-Phase Initialization (초기화의 두-단계)

**Safety Check 1 (안전성 검사 1)**

**Safety Check 2 (안전성 검사 2)**

**Safety Check 3 (안전성 검사 3)**

**Safety Check 4 (안전성 검사 4)**

**Phase 1 (단계 1)**

**Phase 2 (단계 2)**

#### Initializer Inheritance and Overriding (초기자 상속과 재정의)

#### Automatic Initializer Inheritance (자동 초기자 상속)

상위 클래스의 초기자를 자동으로 상속받는다는 것은, 사실상 초기자를 중복적재할 필요가 없는 경우가 태반일 뿐만 아니라 상위 클래스의 초기자를 상속받을 때도 최소한의 노력으로 가능한 안전한 상황에서 할 수 있음을 뜻합니다.

우선 모든 속성들에 기본값을 준 하위 클래스를 만들었다면, 다음의 두 규칙이 적용됩니다:

**규칙 1**

만약 하위 클래스가 어떤 지명된 초기자(designated Initializer)도 정의하지 않았다면, 자동으로 모든 상위 클래스의 지정 초기자를 상속합니다.

**규칙 2**

만약 하위 클래스가 상위 클래스의 모든 지정 초기자를 구현했다면-규칙 1에 의해 상속받거나, 클래스 정의에서 직접 구현했거나 상관없이-, 자동으로 상위 클래스의 모든 편의 초기자(convenience Initializers)를 상속합니다.

이들 규칙은 하위 클래스에 또 다른 '편의 초기자' 를 추가한 경우에도 적용됩니다.

> 하위 클래스는 상위 클래스의 지정 초기자를 편의 초기자로 구현할 수도 있는데, 이 때도 규칙 2를 만족하게 됩니다.

#### Designated and Convenience Initialization in Action (지명된 초기자와 편의 초기자 실제 사례)

### Failable Initializers (실패 가능한 초기자)

#### Failable Initializers for Enumerations (열거체를 위한 실패 가능한 초기자)

#### Failable Initializers for Enumerations with Raw Values (원시 값을 갖는 열거체를 위한 실패 가능한 초기자)

#### Propagation of Initialization Failure (초기화 실패의 전파)

#### Overriding a Failable Initializer (실패 가능한 초기자 재정의하기)

#### The `init!` Failable Initializer (`init!` 실패 가능한 초기자)

### Required Initializers (필수 초기자)

### Setting a Default Property Value with a Closure or Function (클로저나 함수를 사용하여 기본 속성 값 설정하기)

### 참고 자료

[^Initialization]: 원문은 [Initialization](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html) 에서 확인할 수 있습니다.
