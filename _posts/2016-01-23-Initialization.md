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

위에서 클래스와 구조체는 초기자를 제공하지 않을 때, '기본 설정 초기자' 를 자동으로 제공한다고 했는데, 구조체에서는 또 다른 초기자가 하나 더 있습니다.

이것을 `memberwise initializer`라고 하는데, 우리말로 하면 `멤버 초기자` 정도로 옮길 수 있을 것 같습니다. 이 초기자는 호출하면서 각 멤버에 대한 초기값을 같이 전달할 수 있는 초기자입니다.

아래에 간단한 예를 나타냈습니다.

```swift
  struct WidgetSize {
    var width = 10, height = 20
  }

  var widgetSize = WidgetSize(width: 5, height: 10)      // memberwise initializer
```

위의 코드를 보면 앞의 WidgetClass와 같은 상황인데, 멤버 초기자를 호출하여 widgetSize를 생성할 수 있음을 알 수 있습니다. 이 경우 초기값은 기본값과는 다르게 멤버 초기자에서 제공한 값으로 설정됩니다.

> 초기자에서 바로 초기값을 전달할 수 있으므로 구조체에서는 멤버에 대해 기본값을 제공하지 않아도 인스턴스를 만들 수 있습니다. 물론 이렇게 하면 '기본 설정 초기자' 가 생기지 않으므로 '기본 설정 초기자' 로 구조체를 생성할 수는 없게 됩니다. '기본 설정 초기자' 는 '기본 설정 값' 을 제공할 때만 자동으로 제공된다는 점을 기억하십시오.

```swift
  struct WidgetSize {
    var width: Double                             
    var height: Double
  }

  var newWidgetSize = WidgetSize(width: 10, height: 20)      // memberwise initializer

  // 여기서는, WidgetSize()를 직접 호출할 수 없다.
```

위에서는 앞서의 예제와는 다르게 기본값을 제공하지 않았습니다. 하지만 이 경우에도 멤버 초기자는 호출할 수 있음을 알 수 있습니다. 대신에 이제는 '기본 설정 초기자' 를 직접 호출할 수는 없게 됩니다.

### Initial Delegation for Value Types (값 타입을 위한 초기화 위임하기)

### Class Inheritance and Initialization (클래스 상속과 초기화)

#### Designated Initializers and Convenience Initializers ('지정 초기자' 와 '편의 초기자')

#### Syntax for Designated and Convenience Initializers ('지정 초기자' 와 '편의 초기자' 의 구문 표현)

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

#### Automatic Initializer Inheritance (자동적인 초기자 상속)

앞서 언급한 대로, 하위 클래스는 기본적으로 상위 클래스의 초기자를 상속받지 않습니다. 하지만, 지정된 조건을 만족할 경우에는 상위 클래스의 초기자를 자동적으로 상속 _받습니다. (are)_. 실제로, 이것은 일반적인 많은 상황에서 초기자를 '재정의 (override)' 할 필요는 없으며, 안전하기만 하다면 언제든 최소한의 노력으로 상위 클래스의 초기자를 상속받을 수 있다는 것을 의미합니다.

'하위 클래스' 에서 새로 도입한 모든 속성에 대해 '기본 설정 값' 을 제공한다고 가정하면, 다음의 두 규칙이 적용됩니다:

**규칙 1**

  하위 클래스에서 어떤 '지정 초기자 (designated Initializer)' 도 정의하지 않았을 경우, 상위 클래스의 모든 '지정 초기자' 들을 자동으로 상속받습니다.

**규칙 2**

  하위 클래스에서 상위 클래스의 '지정 초기자' 에 대한 모든 구현을 제공할 경우-'규칙 1' 에 의해서 상속을 받았든, 정의하면서 직접 구현을 제공했든 상관없이-이 때는 상위 클래스의 모든 '편의 초기자 (convenience Initializers)' 들을 자동으로 상속받습니다.

이 규칙은 하위 클래스에서 '편의 초기자' 를 더 추가했어도 그대로 적용됩니다.

> '규칙 2' 를 만족하기 위한 방편으로, 상위 클래스의 '지정 초기자' 를 하위 클래스에서 '편의 초기자' 의 형태로 구현할 수도 있습니다.


#### Designated and Convenience Initialization in Action ('지정 초기자' 와 '편의 초기자' 의 실제 사례)

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
