---
layout: post
comments: true
title:  "Swift 5.7: Access Control (접근 제어)"
date:   2020-04-28 10:00:00 +0900
categories: Swift Language Grammar Access Control
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [Access Control](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html) 부분[^Access-Control]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Access Control (접근 제어)

_접근 제어 (Access Control)_ 는 다른 소스 파일과 모듈 안의 코드가 자신의 코드에 접근하는 걸 제약합니다. 이런 특징은 코드의 세부 구현을 숨기고, 그 코드가 접근하고 사용하기에 더 좋을 수 있는 인터페이스를 지정할 수 있게 합니다.

(클래스, 구조체, 및 열거체 같은) 개별 타입뿐만 아니라, 그 타입에 속한 속성, 메소드, 초기자, 및 첨자에도 특정한 접근 수준을 할당할 수 있습니다. 프토토콜은, 전역 상수, 변수, 및 함수가 그럴 수 있듯, 정해진 상황 (context) 으로 제약할 수 있습니다.

다양한 수준의 접근 제어를 제안하는데 더해, 스위프트는 전형적인 시나리오엔 기본 접근 수준을 제공함으로써 접근 제어 수준을 명시할 필요를 줄여줍니다. 진짜로, 단일-대상 앱[^single-target-app] 을 작성하는 중이라면, 접근 제어 수준을 명시할 필요가 전혀 없을 수도 있습니다.

> 접근 제어를 적용할 수 있는 (속성, 타입, 함수, 등등의) 다양한 부분의 코드를, 간결하게, "개체 (entities)" 라고 합니다.

### Modules and Source Files (모듈과 소스 파일)

스위프트의 접근 제어 모델은 모듈과 소스 파일이라는 개념을 기초로 합니다.

_모듈 (module)_ 은 단일한 코드 배포 단위로써-단일 단위로 제작하고 출하하며 스위프트의 `import` 키워드로 또 다른 모듈에서 불러올 수 있는 프레임웍 또는 응용 프로그램입니다.

(앱 번들이나 프레임웍 같은) Xcode 의 각 제작 대상 (build target)[^build-target] 은 스위프트에서 별도의 모듈로 취급합니다. 자신의 앱 코드를 독립 프레임웍으로 그룹 지으면-아마도 그 코드를 은닉하여 여러 응용 프로그램을 가로질러 재사용하려고 한거면-앱 안에서 불러오고 사용할 때나, 또 다른 프레임웍 안에서 사용할 때, 그 프레임웍 안에서 정의한 모든 것이 별도의 모듈이 될 것입니다.

_소스 파일 (source file)_ 은 모듈 안에 있는 단일한 스위프트 소스 코드 파일 (사실상, 앱 또는 프레임웍 안에 있는 단일 파일) 입니다. 개별 타입은 별도의 소스 파일에 정의하는 게 흔하긴 하지만, 여러 개의 타입, 함수, 등등의 정의를 단일 소스 파일에 담을 수도 있습니다.

### Access Levels (접근 수준)

스위프트는 코드 안의 개체에 서로 다른 다섯 개의 _접근 수준 (access levels)_ 을 제공합니다. 이 접근 수준들은 개체가 정의된 소스 파일에 상대적이며, 그 소스 파일이 속한 모듈에도 상대적입니다.[^relative]

* _공개 접근 (open access)_ 과 _공용 접근 (public access)_ 은 자신을 정의한 모듈의 어떤 소스 파일에서도, 그리고 정의한 모듈을 불러온 다른 모듈의 소스 파일에서도 개체를 사용할 수 있게 합니다. 공개나 공용 접근은 전형적으로 프레임웍의 공용 인터페이스를 지정할 때 사용합니다. 공개와 공용 접근의 차이는 밑에서 설명합니다.
* _내부 접근 (internal access)_ 은 자신을 정의한 모듈의 어떤 소스 파일에서든 사용할 수 있지만, 그 모듈 밖의 어떤 소스 파일에서든 개체를 사용할 수 없게 합니다. 내부 접근은 전형적으로 앱 또는 프레임웍의 내부 구조를 정의할 때 사용합니다.
* _파일-전용 접근 (file-private access)_ 은 개체 사용을 자신이 정의한 소스 파일로 제약합니다. 특정 기능의 세부 구현은 숨기면서 그 세부 기능을 전체 파일에서 사용할 때 파일-전용 접근을 사용합니다.
* _개인 전용 접근 (private access)_ 은 개체 사용을 자신을 둘러싼 선언, 및 동일 파일에 있는 그 선언의 익스텐션으로, 제약합니다. 특정 기능의 세부 구현은 숨기면서 그 세부 기능이 단일 선언 안에서만 사용할 때 개인 전용 접근을 사용합니다.

공개 접근은 가장 높은 (가장 적게 제약한) 접근 수준이고 개인 전용 접근은 가장 낮은 (가장 많이 제약한) 접근 수준입니다.

공개 접근은 클래스 및 클래스 멤버에만 적용하며, 아래의 [Subclassing (하위 클래스)](#subclassing-하위-클래스) 에서 논의한 것처럼, 모듈 밖의 코드가 하위 클래스를 만들고 재정의하는 걸 허용한다는 점이 공용 접근과 다릅니다. 클래스를 공개 (open) 라고 표시하면 그 클래스를 상위 클래스로 사용할 다른 모듈의 코드에 가해질 충격을 고려하여, 클래스 코드를 알맞게 설계했음을 명시적으로 지시하는 겁니다.

#### Guiding Principle of Access Levels (접근 수준의 지침)

스위프트 접근 수준이 따르는 전반적인 지침은: _어느 개체도 더 낮은 (더 제약한) 접근 수준을 가진 다른 개체의 관점에서 정의할 수 없다._ 는 겁니다.

예를 들면 다음과 같습니다:

* 공용 변수는 내부나, 파일-전용, 또는 개인 전용 타입을 가지게 정의할 수 없는데, 공용 변수를 사용한 모든 곳에서 타입을 사용하지 못할지도 모르기 때문입니다.
* 함수는 자신의 매개 변수 타입 및 반환 타입보다 더 높은 접근 수준을 가질 수 없는데, 함수를 사용한 곳 주위 코드에서 자신의 구성 요소 타입을 사용하지 못할 수도 있기 때문입니다.

언어의 서로 다른 부분에서 이 지침이 가지는 특정한 의미는 밑에서 자세히 다룹니다:

#### Default Access Levels (기본 접근 수준)

코드 안의 모든 개체는 (이 장 나중에 설명할, 몇몇 특정 예외만 빼면) 스스로 접근 수준을 명시하지 않을 경우 내부 (internal) 라는 기본 접근 수준을 가집니다. 그 결과, 많은 경우에 코드의 접근 수준을 명시할 필요가 없습니다.

#### Access Levels for Single-Target Apps (단일-대상 앱의 접근 수준)

단순한 단일-대상 앱을 작성할 땐, 앱의 코드가 앱 안에 독립된 게 전형이라 앱 모듈 밖에서 사용하게 할 필요가 없습니다. 기본 접근 수준인 내부 (internal) 는 이미 이런 필수 조건과 일치합니다. 그러므로, 자신이 접근 수준을 지정할 필요가 없습니다. 하지만, 일부 코드를 파일 전용 (file private) 이나 개인 전용 (private) 으로 표시하여 앱 모듈 안의 다른 코드로부터 세부 구현을 숨기고 싶을 수도 있습니다.

#### Access Levels for Frameworks (프레임웍의 접근 수준)

프레임웍을 개발할 땐, 그 프레임웍의 공용-쪽 인터페이스를 공개 (open) 또는 공용 (public) 으로 표시해야, 프레임웍을 불러온 앱 같이, 다른 모듈이 볼 수도 접근할 수도 있습니다. 이런 공용-쪽 인터페이스가 프레임웍의 응용 프로그래밍 인터페이스 (또는 API[^API]) 입니다.

> 프레임웍 내부의 어떤 세부 구현이든 다른 부분의 프레임웍의 내부 코드로부터 숨기고 싶으면 여전히 내부 (internal) 라는 기본 접근 수준을 사용할 수도, 아니면 개인 전용 (private) 이나 파일 전용 (file private) 으로 표시할 수도 있습니다. 개체를 공개 (open) 나 공용 (public) 으로 표시하는 건 프레임웍 API 가 되길 원할 경우에만 필요한 겁니다.

#### Access Levels for Unit Test Targets (단위 테스트 대상의 접근 수준)

단위 테스트 대상이 있는 앱을 작성할 땐, 테스트를 위해 그 모듈이 앱 코드를 사용 가능하게 만들 필요가 있습니다. 기본적으로, 공개 (open) 나 공용 (public) 으로 표시한 개체만 다른 모듈에서 접근 가능합니다. 하지만, 제품 모듈의 불러오기 (import) 선언을 `@testable` 특성으로 표시하고 그 제품 모듈을 테스트 가능 (test enabled) 으로 컴파일하면, 단위 테스트 대상이 어떤 내부 (internal) 개체에든 접근할 수 있습니다.

### Access Control Syntax (접근 제어 구문)

개체에 접근 수준을 정의하려면 개체 선언 맨 앞에 `open` 이나, `public`, `internal`, `fileprivate`, 또는 `private` 수정자를 두면 됩니다.

```swift
public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}
```

따로 정하지 않으면, [Default Access Levels (기본 접근 수준)](#default-access-levels-기본-접근-수준) 에서 설명한 것처럼, 기본 접근 수준인 내부 (internal) 가 됩니다. 이는 `SomeInternalClass` 와 `someInternalConstant` 는 접근-수준 수정자 (modifier) 를 명시하지 않고 작성할 수 있으며, 그래도 여전히 내부 (internal) 라는 접근 수준을 가진다는 걸 의미합니다.

```swift
class SomeInternalClass {}        // 암시적인 내부
let someInternalConstant = 0      // 암시적인 내부
```

### Custom Types (사용자 정의 타입)

자신의 타입에 접근 수준을 명시하고 싶으면, 타입 정의 시점에 그렇게 합니다. 그러면 새 타입의 접근 수준이 허가한 곳마다 이를 사용할 수 있습니다. 예를 들어, 파일-전용 (file-private) 클래스를 정의하면, 파일-전용 클래스를 정의한 소스 파일 안의, 속성 타입이나, 함수 매개 변수 및 반환 타입으로만 그 클래스를 사용할 수 있습니다.

타입의 접근 제어 수준은 (속성, 메소드, 초기자, 및 첨자 같은) 그 타입에 있는 _멤버 (members)_ 의 기본 접근 수준에도 영향을 줍니다. 타입의 접근 수준을 개인 전용 (private) 이나 파일 전용 (file private) 으로 정의하면, 멤버의 기본 접근 수준도 개인 전용이나 파일 전용일 것입니다. 타입의 접근 수준을 내부 (internal) 나 공용 (public) 으로 정의하면 (또는 접근 수준을 명시하지 않고 내부라는 기본 접근 수준을 사용하면), 타입 멤버의 기본 접근 수준은 내부일 것입니다.

> 공용 (public) 타입은, 공용 멤버가 아닌, 내부 멤버를 갖는 게 기본입니다. 타입 멤버가 공용이고 싶으면, 반드시 그렇다고 명시해야 합니다. 이런 필수 조건은 타입의 공용-쪽 API 는 자신이 공용으로의 발행을 직접 선택한 거라는 걸 보장하며, 타입 내부 작업이 실수로 공용 API 가 되는 걸 피하게 합니다.

```swift
public class SomePublicClass {                  // 명시적인 공용 클래스
  public var somePublicProperty = 0             // 명시적인 공용 클래스 멤버
  var someInternalProperty = 0                  // 암시적인 내부 클래스 멤버
  fileprivate func someFilePrivateMethod() {}   // 명시적인 파일-전용 클래스 멤버
  private func somePrivateMethod() {}           // 명시적인 개인 전용 클래스 멤버
}

class SomeInternalClass {                       // 암시적인 내부 클래스
  var someInternalProperty = 0                  // 암시적인 내부 클래스 멤버
  fileprivate func someFilePrivateMethod() {}   // 명시적인 파일-전용 클래스 멤버
  private func somePrivateMethod() {}           // 명시적인 개인 전용 클래스 멤버
}

fileprivate class SomeFilePrivateClass {        // 명시적인 파일-전용 클래스
  func someFilePrivateMethod() {}               // 암시적인 파일-전용 클래스 멤버
  private func somePrivateMethod() {}           // 명시적인 개인 전용 클래스 멤버
}

private class SomePrivateClass {                // 명시적인 개인 전용 클래스
  func somePrivateMethod() {}                   // 암시적인 개인 전용 클래스 멤버
}
```

#### Tuple Types (튜플 타입)

튜플 타입의 접근 수준은 그 튜플 안의 모든 타입 중 가장 많이 제약한 접근 수준[^the-most-restrictive] 입니다. 예를 들어, 두 개의 다른 타입을 튜플로 합성했는데, 하나는 내부 (internal) 접근이고 하나는 개인 전용 (private) 접근이면, 그 복합 튜플 타입의 접근 수준은 개인 전용일 것입니다.

> 튜플 타입엔 클래스와, 구조체, 열거체, 및 함수에 있는 방식의 독립적인 정의가 없습니다. 튜플 타입의 접근 수준은 튜플 타입을 이루는 타입으로부터 자동으로 결정되며, 이를 명시할 수 없습니다.

#### Function Types (함수 타입)

함수 타입의 접근 수준은 함수의 매개 변수 타입 및 반환 타입 중에서 가장 많이 제약한 접근 수준으로 계산합니다. 계산한 함수 접근 수준이 상황별 기본 값과 일치하지 않으면 반드시 함수 정의 부분에 접근 수준을 명시해야 합니다.[^function-access-level]

아래 예제는 `someFunction()` 이라는 전역 함수를 정의하면서, 함수 자체론 특정한 접근-수준 수정자를 제공하지 않습니다. 이 함수의 기본 접근 수준은 "내부 (internal)" 라고 예상할지 모르지만, 이 경우엔 아닙니다. 사실, `someFunction()` 을 아래 처럼 작성하면 컴파일이 안 될 겁니다:

```swift
func someFunction() -> (SomeInternalClass, SomePrivateClass) {
  // 함수 구현은 여기에 둠
}
```

함수의 반환 타입은 위에 있는 [Custom Types (사용자 정의 타입)](#custom-types-사용자-정의-타입) 에서 정의한 사용자 정의 클래스 두 개를 합성한 튜플 타입입니다. 이 클래스들 중 하나는 내부 (internal) 로 정의하고, 다른 건 개인 전용 (private) 으로 정의합니다. 그러므로, 전체 복합 튜플 타입의 접근 수준은 (튜플의 구성 요소 타입 중 최소 접근 수준인) 개인 전용입니다.

함수 반환 타입이 개인 전용이기 때문에, 반드시 함수의 전체 접근 수준을 `private` 수정자로 표시해야 함수 선언이 유효합니다:

```swift
private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
  // 함수 구현은 여기에 둠
}
```

`someFunction()` 정의를 `public` 이나 `internal` 수정자로 표시하는 것, 또는 내부 (internal) 라는 기본 설정을 사용하는 건 유효하지 않은데, 함수의 공용이나 내부 사용자가 함수 반환 타입에 사용된 개인 전용 클래스에 접근하는 게 적절하지 않을지도 모르기 때문입니다.

#### Enumeration Types (열거체 타입)

열거체의 개별 case 는 자동으로 자신이 속한 열거체와 동일한 접근 수준을 받습니다. 서로 다른 접근 수준을 개별 열거체 case 에 지정할 순 없습니다.

아래 예제에서, `CompassPoint` 열거체의 명시적인 접근 수준은 공용 (public) 입니다. 따라서 열거체 case 인 `north` 와, `south`, `east`, 및 `west` 의 접근 수준도 공용 (public) 입니다:

```swift
public enum CompassPoint {
  case north
  case south
  case east
  case west
}
```

**Raw Values and Associated Values (원시 값과 결합 값)**

열거체 정의의 원시 값이나 결합 값[^raw-values-and-associated-values] 으로 사용한 어떤 타입이든 반드시 적어도 열거체 접근 수준만큼 높은 접근 수준을 가져야 합니다. 예를 들어, 내부 (internal) 라는 접근 수준을 가진 열거체의 원시-값 타입이 개인 전용 (private) 타입일 수 없습니다.

#### Nested Types (중첩 타입)

중첩 타입의 접근 수준은, 자신을 담은 타입이 공용 (public) 이 아닌 한, 담은 타입과 똑같습니다. 공용 타입 안에서 정의한 중첩 타입은 자동으로 내부라는 접근 수준을 가집니다. 공용 타입 안에 있는 중첩 타입을 공용으로 사용하고 싶으면, 반드시 중첩 타입을 명시적으로 공용으로 선언해야 합니다.

### Subclassing (하위 클래스)

현재 접근 상황에서 접근할 수 있는 클래스 및 동일 모듈 안에서 하위 클래스로 정의한 어떤 클래스든 하위 클래스를 만들 수 있습니다. 다른 모듈 안에서 정의한 어떤 공개 (open) 클래스도 하위 클래스를 만들 수 있습니다. 하위 클래스는 자신의 상위 클래스보다 더 높은 접근 수준을 가질 수 없습니다-예를 들어, 내부 (internal) 상위 클래스의 공용 (public) 하위 클래스를 작성할 순 없습니다.

여기다, 동일한 모듈 안에서 정의한 클래스면, 특정 접근 상황에서 보이는 (메소드, 속성, 초기자, 또는 첨자 같은) 어떤 클래스 멤버든 재정의할 수 있습니다. 다른 모듈에서 정의한 클래스면, 어떤 공개 클래스 멤버든 재정의할 수 있습니다.

재정의는 상속한 클래스 멤버의 접근 가능성을 상위 클래스 버전보다 더 높일 수 있습니다. 아래 예제에서, 클래스 `A` 는 `someMethod()` 라는 파일-전용 (file-private) 메소드를 가진 공용 (public) 클래스입니다. 클래스 `B` 는 `A` 의 하위 클래스로, "내부 (internal)" 라는 감소한 접근 수준을 가집니다. 그럼에도 불구하고, 클래스 `B` 는 `someMethod()` 를 "내부 (internal)" 라는 접근 수준으로 재정의하는 데, 이는 원본 `someMethod()` 구현보다 _더 높습니다 (higher)_:

```swift
public class A {
  fileprivate func someMethod() {}
}

internal class B: A {
  override internal func someMethod() {}
}
```

이는 심지어 하위 클래스가 하위 클래스 멤버보다 더 낮은 접근을 허가하는 상위 클래스 멤버를 호출하는 것도, 상위 클래스 멤버로의 호출이 허용된 접근 수준 안에서 일어나는 한 (즉, 상위 클래스와 동일한 소스 파일 안에서 파일-전용 멤버를 호출하거나, 상위 클래스와 동일한 모듈 안에서 내부 멤버를 호출하는 한), 유효입니다:

```swift
public class A {
  fileprivate func someMethod() {}
}

internal class B: A {
  override internal func someMethod() {
    super.someMethod()
  }
}
```

동일한 소스 파일에서 상위 클래스 `A` 와 하위 클래스 `B` 를 정의하기 때문에, `B` 가 구현한 `someMethod()` 가 `super.someMethod()` 를 호출해도 유효입니다.

### Constants, Variables, Properties, and Subscripts (상수와, 변수, 속성, 및 첨자)

상수나, 변수, 및 속성은 자신의 타입보다 더 공개적 (public) 일 수 없습니다.[^more-public] 예를 들어, 개인 전용 (private) 타입으로 공용 (public) 속성을 작성하는 건 유효하지 않습니다. 이와 비슷하게, 첨자는 자신의 색인 타입 또는 반환 타입보다 더 공개적 (public) 일 수 없습니다.

상수나, 변수, 속성, 및 첨자가 개인 전용 타입을 사용하면, 상수나, 변수, 속성, 및 첨자도 반드시 `private` 으로 표시해야 합니다:

```swift
private var privateInstance = SomePrivateClass()
```

#### Getters and Setters (획득자 및 설정자)

상수와, 변수, 속성, 및 첨자의 획득자와 설정자는 자동으로 자신이 속한 상수, 변수, 속성, 또는 첨자와 동일한 접근 수준을 받습니다.

설정자엔 그에 해당하는 획득자보다 _더 낮은 (lower)_ 접근 수준을 줘서, 그 변수나, 속성, 및 첨자가 읽고-쓰는 영역을 제약할 수 있습니다. 더 낮은 접근 수준을 할당하려면 `var` 또는 `subscript` 도입자 (introducer) 앞에 `fileprivate(set)` 이나, `private(set)`, 또는 `internal(set)` 을 작성하면 됩니다.

> 이 규칙은 계산 속성뿐 아니라 저장 속성에도 적용됩니다. 저장 속성엔 명시적인 획득자와 설정자를 작성하지 않을지라도, 여전히 스위프트가 암시적인 획득자와 설정자를 통합하여 저장 속성의 백업용 저장 공간으로의 접근을 제공합니다.[^stored-properties] `fileprivate(set)` 과, `private(set)`, 및 `internal(set)` 을 사용하여 이 통합 설정자의 접근 수준을 바꾸는 건 계산 속성의 명시적인 설정자와 정확히 똑같은 방식입니다.

아래 예제는 `TrackedString` 이라는 구조체를 정의하는데, 이는 문자열 속성의 수정 횟수를 추적합니다:

```swift
struct TrackedString {
  private(set) var numberOfEdits = 0
  var value: String = "" {
    didSet {
      numberOfEdits += 1
    }
  }
}
```

`TrackedString` 구조체는 `value` 라는 문자열 저장 속성을 정의하며, 초기 값은 `""` (빈 문자열) 입니다. 구조체는 `numberOfEdits` 라는 정수 저장 속성도 정의하는데, 이를 사용하여 `value` 의 수정 횟수를 추적합니다. 이런 수정 추적 기능은 `value` 속성의 `didSet` 속성 관찰자[^property-observer] 로 구현하는데, 이는 `value` 속성에 새 값을 설정할 때마다 `numberOfEdits` 를 증가합니다.

`TrackedString` 구조체 및 `value` 속성은 접근-수준 수정자를 명시하지 않아서, 둘 다 내부 (internal) 라는 기본 접근 수준을 받습니다. 하지만, `numberOfEdits` 속성의 접근 수준을 `private(set)` 수정자로 표시하면 속성의 획득자는 여전히 내부라는 기본 접근 수준이지만, 속성은 `TrackedString` 구조체 안의 코드만 설정 가능하다는 걸 지시합니다. 이는 `TrackedString` 내부에선 `numberOfEdits` 속성을 수정하지만, 구조체 정의 밖에서 사용할 땐 읽기-전용 속성이 되게 합니다.

`TrackedString` 인스턴스를 생성해서 문자열 값을 몇 번 수정하면, 수정 횟수와 일치하도록 `numberOfEdits` 속성 값을 업데이트하는 걸 볼 수 있습니다:

```swift
var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")
// "The number of edit is 3" 를 인쇄함
```

다른 소스 파일에서 `numberOfEdits` 속성의 현재 값을 조회하는 건 할 수 있지만, 다른 소스 파일의 속성을 _수정 (modify)_ 할 순 없습니다. 이런 제약은 `TrackedString` 편집-추적 기능의 세부 구현은 보호하면서도, 그 기능으로의 편리한 접근을 제공합니다.

필요하다면 획득자와 설정자 둘 다에 명시적 접근 수준을 할당할 수 있음을 기억하기 바랍니다. 아래 예제는 공용 (public) 이라는 명시적 접근 수준을 가진 `TrackedString` 구조체 버전을 보여줍니다. 그리하여 (`numberOfEdits` 속성을 포함한) 구조체 멤버는 기본적으로 내부 (internal) 라는 접근 수준을 가집니다.[^internal-by-default] 구조체에 있는 `numberOfEdits` 속성의 획득자는 공용 (public) 으로, 그 속성의 설정자는 개인 전용 (private) 으로 만들려면, `public` 과 `private(set)` 접근-수준 수정자를 조합하면 됩니다:

```swift
public struct TrackedString {
  public private(set) var numberOfEdits = 0
  public var value: String = "" {
    didSet {
      numberOfEdits += 1
    }
  }
  public init() {}
}
```

### Initializers (초기자)

사용자 정의 초기자에는 자신을 초기화할 타입보다 더 낮거나 같은 접근 수준을 할당할 수 있습니다. 단 하나의 예외는 ([Required Initializers (필수 초기자)]({% post_url 2016-01-23-Initialization %}#required-initializers-필수-초기자) 에서 정의한) 필수 초기자입니다. 필수 초기자의 접근 수준은 반드시 자신이 속한 클래스와 똑같아야 합니다.

함수 및 메소드 매개 변수 처럼, 초기자 매개 변수의 타입은 초기자 자신의 접근 수준보다 더 개인적 (private) 일 수 없습니다.[^more-private]

#### Default Initializers (기본 초기자)


[Default Initializers (기본 초기자)]({% post_url 2016-01-23-Initialization %}#default-initializers-기본-초기자) 에서 설명한 것처럼, 스위프트는 자신의 모든 속성에 기본 값을 제공하면서 그 자체론 단 하나의 초기자도 제공하지 않는 어떤 구조체나 기초 클래스에든 _기본 초기자 (default initializer)_ 를 제공합니다.

기본 초기자는, 자신을 초기화하는 타입의 정의가 `public` 이 아닌 한, 그 타입과 동일한 접근 수준을 가집니다. `public` 으로 정의한 타입은, 기본 초기자가 내부 (internal) 라고 고려합니다. 공용 (public) 타입이 다른 모듈에서 사용될 때 인자-없는 초기자로 초기화 가능하게 하고 싶으면, 타입 정의 부분에서 반드시 직접 인자-없는 공용 초기자를 명시해야 합니다.[^public-no-argument]

#### Default Memberwise Initializers for Structure Types (구조체 타입의 기본 멤버 초기자)

구조체의 저장 속성 중 어떤 것이든 개인 전용 (private) 이면 구조체 타입의 기본 멤버 초기자도 개인 전용이라고 고려합니다. 마찬가지로, 구조체의 저장 속성 중에서 어떤 것이든 파일 전용 (file private) 이면, 초기자도 파일 전용입니다. 그 외 경우, 초기자의 접근 수준은 내부 (internal) 입니다.

위의 기본 초기자 처럼, 공용 (public) 구조체 타입을 다른 모듈에서 사용할 때 멤버 초기자로 초기화 가능하게 하려면, 반드시 스스로 타입 정의 부분에 공용 멤버 초기자를 제공해야 합니다.

### Protocols (프로토콜)

프로토콜 타입에 명시적인 접근 수준을 할당하고 싶으면, 프로토콜 정의 시점에 그래야 합니다. 이러면 특정 접근 상황에서만 채택 가능한 프로토콜을 생성할 수 있습니다.

프로토콜 정의에 있는 각 필수 조건의 접근 수준은 프로토콜과 동일한 접근 수준으로 자동 설정됩니다. 프로토콜의 필수 조건에는 자신이 지원하는 프로토콜과 다른 접근 수준을 설정할 수 없습니다. 이는 프로토콜을 채택한 어떤 타입이든 프로토콜의 모든 필수 조건을 볼 수 있게 보장합니다.

> 공용 프로토콜을 정의하면, 프로토콜의 필수 조건을 구현할 때 그 필수 조건의 접근 수준도 공용이길 요구합니다. 이 동작은 다른 타입들과는 다른데, 여기선 공용 타입을 정의하면 타입 멤버의 접근수준이 암시적으로 내부입니다.

#### Protocol Inheritance (프로토콜 상속)

기존 프로토콜을 상속하여 새 프로토콜을 정의하면, 새 프로토콜이 가질 수 있는 최대한의 접근 수준은 자신이 상속한 프로토콜과 동일한 수준입니다.[^at-most-the-same] 예를 들어, 내부 (internal) 프로토콜을 상속하여 공용 (public) 프로토콜을 작성할 순 없습니다.

#### Protocol Conformance (프로토콜 준수성)

타입은 프로토콜을 타입 그 자체보다 더 낮은 접근 수준으로 준수할 수 있습니다. 예를 들어, 공용 프로토콜을 정의하면 다른 모듈에서 사용할 수 있지만, 그 중에서 내부 프로토콜을 준수한 건 내부 프로토콜을 정의한 모듈 안에서만 사용할 수 있습니다.

한 특별한 프로토콜을 준수하는 타입인 상황(의 접근 수준)은 타입 접근 수준과 프로토콜 접근 수준의 최소값[^the-minimum] 입니다. 예를 들어, 타입은 공용이지만, 그게 준수한 프로토콜이 내부면, 타입에서 그 프로토콜을 준수한 것도 내부입니다.

타입을 작성하거나 확장할 때 프로토콜을 준수하려면, 타입이 구현한 각 프로토콜 필수 조건의 접근 수준이 적어도 반드시 그 프로토콜을 타입이 준수한 것과 동일하도록 보장해야 합니다. 예를 들어, 공용 타입이 내부 프로토콜을 준수하면, 타입이 구현한 각 프로토콜 필수 조건이 적어도 반드시 내부여야 합니다.

> 스위프트에선, 오브젝티브-C 처럼, 프로토콜 준수성이 전역입니다-타입이 동일 프로그램에서 서로 다른 두 방식으로 프로토콜을 준수하는 건 불가능합니다.

### Extensions (익스텐션)

클래스나, 구조체, 또는 열거체가 사용 가능한 어떤 접근 상황에서도 클래스나, 구조체, 또는 열거체를 확장할 수 있습니다. 익스텐션에서 추가한 어떤 타입 멤버든 확장하고 있는 원본 타입에서 선언한 타입 멤버와 동일한 기본 접근 수준을 가집니다. 공용 (public) 이나 내부 (internal) 타입을 확장하면, 새로 추가한 어떤 타입 멤버든 내부라는 기본 접근 수준을 가집니다. 파일-전용 (file-private) 타입을 확장하면, 새로 추가한 어떤 타입 멤버든 파일 전용이라는 기본 접근 수준을 가집니다. 개인 전용 (private) 타입을 확장하면, 새로 추가한 어떤 타입 멤버든 개인 전용이라는 기본 접근 수준을 가집니다.

대안으로, 익스텐션에 명시적 접근-수준 수정자 (예를 들어, `private` 같은 거) 를 표시하면 익스텐션 안에 정의한 모든 멤버에 새로운 기본 접근 수준을 설정할 수 있습니다. 익스텐션 안에서 개별 타입 멤버마다 이 새 기본 값을 여전히 재정의할 수도 있습니다.

프로토콜 준수성을 추가하려고 익스텐션을 사용하는 중이면 거기서 명시적 접근-수준 수정자를 제공할 순 없습니다. 그 대신, 프로토콜 자신의 접근 수준을 사용하여 익스텐션 안에 있는 각각의 프로토콜 필수 조건 구현에 기본 접근 수준을 제공합니다.

### Private Members in Extensions (익스텐션 안의 개인 전용 멤버)

익스텐션이 자신이 확장한 클래스나, 구조체, 또는 열거체와 동일한 파일에 있으면 익스텐션 안의 코드가 마치 원본 타입 선언 부분에서 작성한 것처럼 동작합니다. 그 결과, 다음을 할 수 있습니다:

* 원본 선언 안에 개인 전용 (private) 멤버를 선언하고, 동일한 파일 안의 익스텐션에서 그 멤버에 접근합니다.
* 한 익스텐션 안에 개인 전용 멤버를 선언하고, 동일한 파일 안의 또 다른 익스텐션에서 그 멤버에 접근합니다.
* 익스텐션 안에 개인 전용 멤버를 선언하고, 동일한 파일 안의 원본 선언에서 그 멤버에 접근합니다.

이런 동작은, 타입에 개인 전용 개체가 있든 없든, 익스텐션을 사용하여 코드를 정돈할 수 있다는 의미입니다. 예를 들어, 다음의 단순한 프로토콜이 주어지면:

```swift
protocol SomeProtocol {
  func doSomething()
}
```

이와 같이, 익스텐션을 사용하여 프로토콜 준수성을 추가할 수 있습니다[^protocol-conformance-extension]:

```swift
struct SomeStruct {
  private var privateVariable = 12
}

extension SomeStruct: SomeProtocol {
  func doSomething() {
    print(privateVariable)
  }
}
```

### Generics (일반화)

일반화 타입이나 일반화 함수의 접근 수준은 일반화 타입 및 함수 그 자체의 접근 수준과 타입 매개 변수에 대한 어떤 타입 구속 조건의 접근 수준 중에서 최소값입니다.

### Type Aliases (타입 별명)

직접 정의한 어떤 타입 별명이든 접근 제어용으론 서로 별개의 타입 처럼 취급합니다. 타입 별명은 자신이 별명 붙인 타입의 접근 수준보다 낮거나 같은 접근 수준을 가질 수 있습니다. 예를 들어, 개인 전용 (private) 타입 별명은 개인 전용 (private) 이나, 파일-전용 (file-private), 내부 (internal), 공용 (public), 및 공개 (open) 타입에 별명을 붙일 수 있지만, 공용 타입 별명은 내부나, 파일-전용, 및 개인 전용 타입에 별명을 붙일 수 없습니다.

> 프로토콜 준수성을 만족하기 위해 사용한 결합 타입의 타입 별명에도 이 규칙을 적용합니다.

### 다음 장

[Advanced Operators (고급 연산자) > ]({% post_url 2020-05-11-Advanced-Operators %})

### 참고 자료

[^Access-Control]: 이 글에 대한 원문은 [Access Control](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html) 에서 확인할 수 있습니다.

[^single-target-app]: 바로 밑의 [Modules and Source Files (모듈과 소스 파일)](#modules-and-source-files-모듈과-소스-파일) 에 있는 설명을 통해 '단일-대상 앱 (single-target app)' 이란 Xcode 안에 제작 대상 (build target) 이 하나만 있는 앱을 의미한다는 걸 알 수 있습니다. 

[^build-target]: 본문 내용을 통해 '제작 대상 (build target)' 이란 앱 번들 (app bundle) 이나 프레임웍 (framework) 을 말한다는 걸 알 수 있습니다.

[^relative]: 접근 수준이 '상대적 (relative)' 이라는 건 소스 파일과 모듈의 접근 수준에 따라서 개체 (entity) 의 접근 수준이 영향을 받는다는 의미입니다. 

[^API]: API 는 'Application Programming Interface' 의 약자입니다.

[^the-most-restrictive]: 앞서 [Access Levels (접근 수준)](#access-levels-접근-수준) 에서 설명한 것처럼, 가장 (많이) 제약한 접근 수준은 가장 낮은 접근 수준입니다. 스위프트의 접근 수준을 높은 순서로 나열하면 공개 (open) `>=` 공용 (public) `>` 내부 (internal) `>` 파일-전용 (file-private) `>` 개인 전용 (private) 입니다.

[^function-access-level]: 이는 함수의 접근 수준이 개인 전용 (private) 일 때는, 반드시 함수 정의에서 `private` 을 붙여야 한다는 의미입니다. 함수가 계산한 접근 수준이 상황별 기본 값과 일치해야 하는 건, 이어지는 예제에서 설명합니다. 함수가 계산한 접근 수준 (`private`) 이 상황별 기본 값 (`internal`) 과 일치하지 않으면, 컴파일이 안됩니다.

[^raw-values-and-associated-values]: 스위프트의 열거체는 각 'case 값' 마다 '원시 값 (raw value)' 과 '결합 값 (associated value)' 이라는 별도의 값을 가집니다. `enum Direction: Int { case east = 0, west }` 라고 하면 `east` 는 'case 값' 이고,  `east` 의 '원시 값' 은 `0` 입니다. '결합 값' 은 'case 값' 의 각 인스턴스마다 할당하는 값을 말하는데, `enum Direction { case east(String), west(String) }; let east = Direction.east("Sun rise")` 라고 하면, `east` 의 'case 값' 은 `"Sun rise"` 가 됩니다.

[^higher]: [Access Levels (접근 수준)](#access-levels-접근-수준) 에서 설명한 것처럼, 스위프트의 접근 수준은 '공개 (open)' 가 가장 높고, '개인 전용 (private)' 이 가장 낮습니다.

[^stored-properties]: 저장 속성의 획득자와 설정자는 스위프트가 자동으로 만들어 주지만, 이들의 접근 수준은 개발자가 조절할 수 있다는 의미입니다.

[^property-observer]: '속성 관찰자 (property observers)' 에 대한 더 자세한 내용은, [Properties (속성)]({% post_url 2020-05-30-Properties %}) 장의 [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 부분을 보도록 합니다. 

[^more-public]: 더 공개 (public) 일 수 없다는 건 더 높은 접근 수준을 가질 수 없다는 의미입니다. 어떤 속성을 '공개 (public)' 하고 싶으면 그 속성을 가진 타입도 반드시 공개 (public) 해야 합니다.

[^internal-by-default]: [Custom Types (사용자 정의 타입)](#custom-types-사용자-정의-타입) 에서 설명한 것처럼, 사용자 정의 클래스를 공용 (public) 으로 정의하면 멤버의 기본 접근 수준은 내부 (internal) 가 됩니다.

[^more-private]: 초기자 매개 변수의 접근 수준이 초기자 자신보다 더 개인적이면 초기자를 호출할 때 매개 변수를 사용할 수 없게 됩니다.

[^public-no-argument]: 바로 위의 `TrackedString` 예제에 있는 `public init() {}` 이  이 예입니다. 

[^at-most-the-same]: 하위 프로토콜이 상위 프로토콜보다 더 높은 접근 수준을 가질 순 없다는 의미입니다.

[^the-minimum]: 타입 접근 수준과 타입이 준수한 프로토콜 접근 수준이 겹치는 곳은 서로의 최소 접근 수준을 가진다는 의미입니다.

[^protocol-conformance-extension]: 예제처럼 하면, `SomeStruct` 를 원본 구현 부분과 `SomeProtocol` 준수 부분으로 구분하여 가독성을 높일 수 있습니다.