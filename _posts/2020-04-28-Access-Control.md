---
layout: post
comments: true
title:  "Swift 5.2: Access Control (접근 제어)"
date:   2020-04-28 10:00:00 +0900
categories: Swift Language Grammar Access Control
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Access Control](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html) 부분[^Access-Control]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Access Control (접근 제어)

_접근 제어 (Access Control)_ 는 다른 소스 파일과 모듈에 있는 코드가 자기 코드의 특정 부분에 접근하는 것을 제한합니다. 이러한 특징은 자기 코드의 세부 구현은 숨기면서도, 그 코드에 접근해서 사용할 수 있는 적합한 인터페이스를 지정할 수 있게 해줍니다.

특정 접근 수준을 할당하는 것은 개별 타입 (클래스, 구조체, 및 열거체) 에 대해서 뿐만 아니라, 해당 타입에 속해 있는 속성, 메소드, 초기자, 그리고 '첨자 연산' 에 대해서도 할 수 있습니다. 프토토콜은 전역 상수, 전역 변수, 그리고 전역 함수에서 그럴 수 있듯이, 정해진 영역으로 제한될 수 있습니다.

접근 제어를 다양한 수준으로 부여하는 것 외에도, 스위프트는 일반적인 '상황 (scenarios)' 에서는 '기본 접근 수준 (default access levels)' 을 제공하여 접근 제어 수준을 명시적으로 지정할 필요를 줄여줍니다. 실제로, 'single-target (단일-대상)' 앱을 작성할 경우, 접근 제어 수준을 명시적으로 지정할 필요가 전혀 없을 수도 있습니다.

> 코드에서 접근 제어를 가질 수 있는 '부분 요소' (속성, 타입, 함수, 등등) 들을 이제부터, 그냥 간단하게, '엔티티 (entities; 독립체)' 라고 부르겠습니다.

### Modules and Source Files (모듈과 소스 파일)

스위프트의 접근 제어 모델은 모듈과 소스 파일의 개념을 기반으로 한 것입니다.

_모듈 (module)_ 은 단일한 코드 배포 단위입니다-단일 단위 형태로 제작되어 출하되는 프레임웍이나 응용 프로그램을 말하는 것으로 스위프트에서는 `import` 키워드로 다른 모듈에서 불러올 수도 있습니다.

Xcode 에 있는 ('앱 번들' 이나 '프레임웍' 같은) 각각의 '빌드 대상 (build target)' 은 스위프트에서 별도의 모듈인 것처럼 처리합니다. 앱 코드에 있는 각 부분들을 독립된 프레임웍으로 묶으면-아마도 이 코드를 은닉해서 여러 응용 프로그램에서 재사용하려고 할 수 있습니다-그 프레임웍 안에서 정의한 모든 것들은 별도의 모듈의 일부인 것처럼, 앱에서 불러오고 사용되거나 다른 프레임웍에서 사용됩니다.

_소스 파일 (source file)_ 은 모듈 내에 있는 단일한 스위프트 소스 코드 파일 (실제로는, 앱이나 프레임웍에 있는 단일 파일) 입니다. 별도의 소스 파일마다 각각의 타입을 정의하는 것이 일반적이긴 하지만, 단일한 소스 파일도 여러 개의 타입, 함수, 기타 등등을 가질 수 있습니다.

### Access Levels (접근 수준)

스위프트는 코드 내의 '엔티티 (entities)' 를 위하여 서로 다른 다섯 가지의 _접근 수준 (access levels)_ 을 제공합니다. 이 접근 수준은 '엔티티' 가 정의된 소스 파일과 관련되어 있으며, 또 소스 파일이 속해 있는 모듈과도 관련되어 있습니다.

* _open access (공개 접근)_ 과 _public access (공용 접근)_ 은 해당 엔티티를 이것이 정의된 모듈의 어떤 소스 파일에서도 사용할 수 있도록 하며, 또한 이 정의된 모듈을 불러온 또다른 모듈의 소스 파일에서도 사용할 수 있도록 합니다. 'open 이나 public 접근' 은 일반적으로 프레임웍의 공용 인터페이스를 지정할 때 사용합니다. 'open 접근' 과 'public 접근' 의 차이점은 아래에 따로 설명합니다.
* _internal access (내부 접근)_ 은 해당 엔티티를 이것이 정의된 모듈의 어떤 소스 파일에서도 사용할 수 있도록 하지만, 그 모듈 외부에 있다면 어떤 소스 파일에서도 접근하지 못하도록 합니다. 'internal 접근' 은 일반적으로 앱이나 프레임웍의 내부 구조를 정의할 때 사용합니다.
* _file-private access (파일-전용 접근)_ 은 엔티티의 사용을 자신이 정의된 소스 파일로만 제한합니다. 'file-private 접근' 을 사용하면 특정 기능의 세부 구현을 숨기면서 그 세부 정보를 한 파일 내에서만 사용할 수 있도록 합니다.
* _private access (개인 전용 접근)_ 은 엔티티의 사용을 그를 둘러싼 '선언 (declaration)' 과, 동일 파일 내의 그 선언의 '확장 (extensions)' 으로만 제한합니다. 'private 접근' 을 사용하면 특정 기능의 세부 구현을 숨기면서 그 세부 정보를 단일 선언 내에서만 사용할 수 있도록 합니다.

'open (공개) 접근' 은 가장 높은 (가장 적게 제한된; least restrictive) 접근 수준이며 'private 접근' 은 가장 낮은 (가장 많이 제한된; most restrictive) 접근 수준입니다.

'open (공개) 접근' 은 클래스와 클래스 멤버에만 적용되어, 모듈 외부의 코드에서 하위 클래스를 만들고 '재정의 (override)' 를 할 수 있게 한다는 점이 'public access (공용 접근)' 과 다른 점으로, 이는 아래의 [Subclassing (하위 클래스)](#subclassing-하위-클래스) 에서 설명하도록 합니다. 클래스를 'open' 으로 명시적으로 표시한다는 것은 그 클래스를 상위 클래스로 사용하는 다른 모듈의 코드에 대한 영향을 이미 고려했으며, 그에 따라 클래스 코드를 설계했음을 지시하는 것입니다.

#### Guiding Principle of Access Levels (접근 수준에 대한 지침)

스위프트의 접근 수준에 적용되는 '전반적인 지침 (overall guiding principle)' 은 다음과 같습니다: _어떤 엔티티도 더 낮은 (더 제한된; more restrictive) 접근 수준을 가지고 있는 엔티티로써 정의할 수 없습니다._

예를 들면 다음과 같습니다:

* 'public variable (공용 변수)' 는 'internal (내부)', 'file-private (파일-전용)', 또는 'private (개인 전용)' 타입을 가지고 있다고 정의할 수 없는데, 이는 그 타입이 '공용 변수' 가 사용되는 모든 곳에서 사용할 수 있는 것은 아니기 때문입니다.
* '함수' 는 그것의 매개 변수와 반환 값보다 더 높은 접근 수준을 가질 수 없는데, 이는 함수를 사용하면서 주변 코드가 함수의 구성 요소를 사용할 수 없는 상황이 벌어질 수 있기 때문입니다.

언어의 서로 다른 부분들에 대해서 이 지침이 의미하는 바는 아래에서 자세히 다루도록 합니다:

#### Default Access Levels (기본 접근 수준)

코드에 있는 모든 엔티티는 (이 장 뒤에 설명할, 몇몇 특정한 예외를 제외한다면) 접근 수준을 직접 명시해서 지정하지 않을 경우 기본 접근 수준이 'internal (내부)' 가 됩니다. 그 결과, 대부분의 경우에 코드에서 접근 수준을 명시적으로 지정할 필요가 없습니다.

#### Access Levels for Single-Target Apps (단일-대상 앱을 위한 접근 수준)

단순한 '단일-대상 앱 (single-target app)' 을 작성할 때는, 앱 코드는 일반적으로 앱 내부로만 한정되므로 앱 모듈 외부에서 사용할 수 있게끔 만들 필요가 없습니다. 기본 접근 수준은 이러한 요구 사항에 이미 해당됩니다. 그러므로, 접근 수준을 따로 지정할 필요가 없는 것입니다. 하지만, 코드 일부를 'file private (파일 전용)' 이나 'private (개인 전용)' 으로 표시하면 앱 모듈 내의 다른 코드로부터 세부 구현 정보를 숨길 수도 있습니다.

#### Access Levels for Frameworks (프레임웍을 위한 접근 수준)

프레임웍을 개발할 때는, 그 프레임웍의 공용-목적의 인터페이스를 'open (공개)' 나 '공용 (public)' 으로 표시해서 다른 모듈, 가령 그 프레임웍을 불러온 앱 같은 것 등에서 볼 수 있고 접근할 수 있도록 해야합니다. 이러한 공용-목적의 인터페이스를 그 프레임웍에 대한 응용 프로그래밍 인터페이스 (또는 API; Application Programming Interface) 라고 합니다.

> 프레임웍의 어떤 'internal (내부)' 세부 구현이라도 기본 접근 수준인 'internal (내부)' 를 그대로 사용할 수도 있고, 프레임웍의 다른 일부 'internal (내부)' 코드로부터 숨길 목적으로 'private (개인 전용)' 이나 'file private (파일 전용)' 으로 표시할 수도 있습니다. 엔티티를 'open (공개)' 나 'public (공용)' 으로 표시하는 것은 오직 그것이 프레임웍의 'API' 일부가 될 경우에만 하도록 합니다.

#### Access Levels for Unit Test Targets (단위 테스트 대상을 위한 접근 수준)

앱을 작성할 때 단위 테스트를 하려면, 테스트하려는 모듈에서 앱에 있는 코드를 사용할 수 있게 만들어야 합니다. 기본적으로는, 'open (공개)' 나 'public (공용)' 로 표시한 엔티티만 다른 모듈에서 접근할 수 있습니다. 하지만, 단위 테스트 대상이 어떤 'internal (내부)' 엔티티에도 접근할 수 있도록, 제품 모듈에서 선언을 불러오면서 `@testable` '특성 (attribute)' 을 표시한 후 컴파일하면, 이제 제품 모듈에서 테스트를 할 수 있게 됩니다.

### Access Control Syntax (접근 제어 구문 표현)

'엔티티' 에 대한 접근 수준을 정의하려면 엔티티 선언의 시작 부분에 `open`, `public`, `internal`, `fileprivate`, 또는 `private` 수정자 중 하나를 붙이면 됩니다.

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

따로 지정하지 않는다면, 기본 접근 수준은 'internal (내부)' 이며, 이는 [Default Access Levels (기본 접근 수준)](#default-access-levels-기본-접근-수준) 에서 설명한 바 있습니다. 이것은 `SomeInternalClass` 와 `someInternalConstant` 에는 명시적인 '접근-수준 수정자 (access-level modifier)' 를 쓰지 않아도 되며, 그래도 여전히 'internal (내부)' 접근 수준을 가진다는 것을 의미합니다.

### Custom Types (사용자 정의 타입)

직접 정의한 '사용자 정의 타입' 에 대해서 접근 수준을 명시적으로 지정하고 싶으면, 타입을 정의하는 시점에 이를 하도록 합니다. 그러면 이제 접근 수준이 허용되는 곳에서 이 새로운 타입을 사용할 수 있습니다. 예를 들어, 'file-private (파일-전용)' 클래스를 정의하면, 이 'file-private (파일-전용)' 클래스를 정의한 소스 파일 내에서만, 속성의 타입이나, 함수의 매개 변수 또는 반환 값으로 사용할 수 있습니다.

타입의 접근 제어 수준은 그 타입 _멤버 (members)_ (속성, 메소드, 초기자, 그리고 첨자 연산) 의 기본 접근 수준에도 영향을 줍니다. 타입의 접근 수준을 'private (개인 전용)' 이나 'file private (파일 전용)' 으로 정의하면, 멤버의 기본 접근 수준도 'private (개인 전용)' 이나 'file private (파일 전용)' 이 됩니다. 타입의 접근 수준을 'internal (내부)' 나 'public (공용)' 으로 정의하면 (아니면 접근 수준을 명시적으로 지정하지 않고 기본 접근 수준인 'internal (내부)' 를 사용할 경우), 타입 멤버의 기본 접근 수준은 'internal (내부)' 가 됩니다.

> 'public type (공용 타입)' 은 기본적으로 'internal members (내부 멤버)' 를 가지지, 'public members (공용 멤버)' 를 가지지 않습니다. 타입 멤버를 'public (공용)' 으로 만들려면, 명시적으로 표시해야 합니다. 이런 요구 사항은 타입을 위한 공용-목적의 API 는 직접 선택해야 하는 것임을 분명하게 하며, 내부에서 동작하는 타입을 실수로 공용 API 로 드러내는 것을 막아줍니다.

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

튜플 타입의 접근 수준은 해당 튜플에서 사용하는 모든 타입 중 '가장 제한된 접근 수준 (the most restrictive access level)'[^the-most-restrictive] 이 됩니다. 예를 들어, 두 개의 서로 다른 타입을 가지는 튜플을 구성할 때, 하나는 'internal (내부)' 접근이고 하나는 'private (개인 전용)' 접근이면, 이렇게 구성된 튜플의 접근 수준은 'private (개인 전용)' 이 됩니다.

> 튜플 타입에는 클래스, 구조체, 열거체, 그리고 함수와 같은 방식의 독립된 정의가 없습니다. 튜플 타입의 접근 수준은 튜플 타입을 구성하는 타입들에 의해 자동으로 결정되는 것으로, 따로 명시적으로 지정할 수는 없습니다.

#### Function Types (함수 타입)

함수 타입의 접근 수준은 함수의 매개 변수 타입과 반환 타입 중 '가장 제한된 접근 수준' 으로 계산됩니다. 함수가 계산한 접근 수준이 해당 영역의 기본적인 의미에 들어맞지 않을 경우 그 접근 수준을 함수의 정의 부분에서 명시적으로 지정해야 합니다.[^function-access-level]

아래 예제는 `someFunction()` 이라는 전역 함수를 정의하면서, 함수 자체에 대한 특정한 접근-수준 '수정자 (modifier)' 를 제공하지 않습니다. 이 함수의 기본 접근 수준이 "internal (내부)" 일 것이라고 예상하겠지만, 그렇지 않습니다. 실제로, `someFunction()` 을 아래와 같이 작성하면 컴파일이 되지 않습니다:

```swift
func someFunction() -> (SomeInternalClass, SomePrivateClass) {
  // 여기서 함수를 구현합니다.
}
```

함수의 반환 타입은 앞서 [Custom Types (사용자 정의 타입)](#custom-types-사용자-정의-타입) 에서 정의한 사용자 정의 클래스 중 두 개를 써서 구성한 튜플 타입입니다. 이 클래스 중 하나는 'internal (내부)' 로 정의되었고, 다른 것은 'private (개인 전용)' 으로 정의되었습니다. 그러므로, 복합 튜플 타입의 전체 접근 수준은 'private (개인 전용)' 입니다. (튜플의 구성 요소 타입들 중에서 최소 접근 수준입니다.)

함수의 반환 타입이 'private (개인 전용)' 이기 때문이, 반드시 함수의 전체 접근 수준을 `private` 수정자로 표시해야 함수 선언이 유효해 집니다:

```swift
private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
  // 여기서 함수를 구현합니다.
}
```

`someFunction()` 의 정의에서 `public` (공용) 또는 `internal` (내부) 수정자로 표시하는 것, 또는 기본 설정인 'internal (내부)' 를 사용하는 것은 유효하지 않는데, 이는 이 함수의 '공용 (public)' 또는 '내부 (internal)' 사용자가 함수의 반환 타입에 있는 '개인 전용 (private)' 클래스에 접근하는 것은 적절하지 않을 수 있기 때문입니다.

#### Enumeration Types (열거체 타입)

열거체의 각 '경우 값 (cases)' 들은 자동으로 이들이 속해 있는 열거체와 같은 접근 수준을 가지게 됩니다. 열거체의 각각의 '경우 값 (cases)' 에 대해 서로 다른 접근 수준을 지정할 수는 없습니다.

아래의 예제에서, `CompassPoint` 열거체는 명시적인 접근 수준으로 'public (공용)' 을 가집니다. 그러므로 열거체의 '경우 값 (cases)' 들인 `north`, `south`, `east`, 그리고 `west` 형의 접근 수준도 역시 'public (공용)' 을 가지게 됩니다:

```swift
public enum CompassPoint {
  case north
  case south
  case east
  case west
}
```

**Raw Values and Associated Values ('원시 값' 과 '결합된 값')**

열거체 정의에 있는 '원시 값 (raw values)' 이나 '결합된 값 (associated values)'[^raw-values-and-associated-values] 에서 사용되는 타입은 어떤 것이든 적어도 열거체의 접근 수준보다는 높아야 합니다. 예를 들어, 접근 수준이 'internal (내부)' 인 열거체의 '원시-값 (raw-value)' 타입으로 'private (개인 전용)' 타입을 사용할 수는 없습니다.

#### Nested Types (중첩 타입)

'중첩 타입 (nested types)' 의 접근 수준은, 그것을 품고 있는 타입이 'public (공용)' 이 아닌 한, 품고 있는 타입과 같습니다. 'public (공용)' 타입 내에 정의된 '중첩 타입' 의 접근 수준은 자동으로 'internal (내부)' 가 됩니다. 'public (공용)' 타입 내에 '중첩 타입' 이 '공용' 으로 사용되길 원할 경우, 반드시 이 '중첩 타입' 을 'public (공용)' 이라고 명시적으로 선언해야 합니다.

### Subclassing (하위 클래스)

현재 접근 영역에서 접근할 수 있는 클래스라면 그리고 동일 모듈에서 정의된 하위 클래스라면 어떤 클래스에 대해서도 하위 클래스를 만들 수 있습니다. 또한 다른 모듈에서 정의한 'open (공개)' 클래스에 대해서도 하위 클래스를 만들 수 있습니다. 하위 클래스는 상위 클래스보다 더 높은 접근 수준을 가질 수 없습니다-예를 들어, 'internal (내부)' 인 상위 클래스에 대해서 'public (공용)' 인 하위 클래스를 작성할 수는 없습니다.

그와 더불어, 동일한 모듈에서 정의한 클래스에 대해서는, 어떤 클래스 멤버 (메소드, 속성, 초기자, 그리고 첨자 연산) 라도 정해진 접근 영역에서 보이기만 한다면 '재정의 (override)' 를 할 수 있습니다. 다른 모듈에서 정의한 클래스에 대해서는, 'open (공개)' 클래스 멤버에 대해 '재정의' 할 수 있습니다.

'재정의' 를 하면 상속된 클래스 멤버를 상위 클래스 버전에서 보다 더 접근하기 쉽게 만들 수 있습니다. 아래 예제에 있는, 클래스 `A` 는 'public (공용)' 클래스로 `someMethod()` 라는 'file-private (파일-전용)' 메소드를 가지고 있습니다. 클래스 `B` 는 `A` 의 하위 클래스이며, 접근 수준은 감소해서 "internal (내부)" 입니다. 그럼에도 불구하고, 클래스 `B` 는 `someMethod()` 의 접근 수준을 "internal (내부)" 인 것으로 '재정의' 했는데, 이는 `someMethod()` 의 원래 구현보다 _높은 (higher)_[^higher] 것입니다:

```swift
public class A {
  fileprivate func someMethod() {}
}

internal class B: A {
  override internal func someMethod() {}
}
```

하위 클래스 멤버가 하위 클래스 멤버보다 더 낮은 접근 권한을 가지는 상위 클래스의 멤버를 호출하는 것도 가능한데, 이는 상위 클래스 멤버에 대한 호출이 허용된 접근 수준 영역 내에서 이루어질 때 가능한 것입니다. (다시 말해서, 동일한 소스 파일 내에서 상위 클래스의 'file-private (파일-전용)' 멤버를 호출하는 것, 또는 동일한 모듈 내에서 상위 클래스의 'internal (내부)' 멤버를 호출하는 것, 등이 가능합니다):

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

상위 클래스인 `A` 와 하위 클래스인 `B` 가 동일한 소스 파일에서 정의되었기 때문에, `someMethod()` 의 `B` 구현부에서 `super.someMethod()` 를 호출하는 것은 유효합니다.

### Constants, Variables, Properties, and Subscripts (상수, 변수, 속성, 및 첨자 연산)

상수, 변수, 또는 속성은 그것의 타입보다 더 'public (공개적)' 일 수 없습니다.[^more-public] 예를 들면, 'private (개인 전용)' 타입을 가지고 'public (공용)' 속성을 만드는 것은 유효하지 않습니다. 이와 비슷하게, '첨자 연산 (subscript)' 도 그것의 색인 타입이나 반환 타입 그 어느 것보다 더 'public (공개적)' 일 수 없습니다.

상수, 변수, 속성, 또는 첨자 연산을 'private (개인 전용)' 타입으로 만들었을 경우, 그 상수, 변수, 속성, 또는 첨자 연산에는 반드시 `private` 을 표시해야 합니다:

```swift
private var privateInstance = SomePrivateClass()
```

#### Getters and Setters ('획득자' 와 '설정자')

상수, 변수, 속성, 및 첨자 연산을 위한 '획득자 (getters)' 와 '설정자 (setters)' 는 자동으로 그것이 속해 있는 상수, 변수, 속성, 또는 첨자 연산과 동일한 접근 수준을 부여 받게 됩니다.

'설정자 (setter)' 에는 연관되어 있는 '획득자 (getter)' 보다 더 _낮은 (lower)_ 접근 수준을 부여해서, 해당 변수, 속성, 또는 첨자 연산에 대한 '읽고-쓰기' 영역의 범위를 제한할 수 있습니다. 더 낮은 접근 수준을 할당하려면 `var` 나 `subscript` '도입자 (introducer)' 앞에 `fileprivate(set)`, `private(set)`, 또는 `internal(set)` 을 써주면 됩니다.

> 이 규칙은 '계산 속성 (computed properties)' 뿐만 아니라 '저장 속성 (stored properties)' 에도 적용됩니다. '저장 속성' 에 대해서 '획득자 (getter) 와 설정자 (setter)' 를 직접 명시적으로 작성하지 않더라도, 여전히 스위프트는 '저장 속성' 의 뒤쪽 저장 공간에 접근하도록 하는 암시적인 '획득자 (getter) 와 설정자 (setter)' 를 만들어서 통합합니다. '계산 속성' 의 명시적 '설정자 (setter)' 와 동일한 방법을 써서 `fileprivate(set)`, `private(set)`, 그리고 `internal(set)` 을 사용하면 이 '합성된 설정자 (synthesized setter)' 의 접근 수준을 바꿀 수 있습니다.

아래 예제는 `TrackedString` 이라는 구조체를 정의해서, 문자열 속성이 수정된 횟수를 계속 추적합니다:

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

`TrackedString` 구조체는 '문자열 저장 속성' 인 `value` 를 정의하고, 기본 설정 값은 `""` (빈 문자열) 로 둡니다. 이 구조체는 `numberOfEdits` 라는 '정수 저장 속성' 도 정의하여, `value` 가 수정된 횟수를 추적하는데 사용합니다. 이 '수정 추적 기능' 은 `value` 속성의 `didSet` '속성 관찰자 (property observer)' 를 써서 구현했으며, `value` 속성에 새 값을 설정할 때마다 `numberOfEdits` 를 증가하도록 합니다.

`TrackedString` 구조체와 `value` 속성은 명시적인 '접근-수준 수정자 (access-level modifier)' 를 제공하지 않으므로, 둘 다 기본 접근 수준인 `internal` 을 부여 받습니다. 하지만, `numberOfEdits` 속성의 접근 수준을 `private(set)` 수정자로 표시해서 속성의 '획득자 (getter)' 가 여전히 기본 접근 수준인 'internal (내부)' 임에도 불구하고, `TrackedString` 구조체 코드의 일부에서는 속성을 설정할 수 있도록 했습니다. 이것은 `TrackedString` 이 `numberOfEdits` 속성을 내부에서는 수정할 수 있게 하면서도, 이 속성이 구조체 정의 외부에서 사용될 때는 '읽기-전용' 임을 나타내도록 해 줍니다.

`TrackedString` 인스턴스를 생성하고나서 그 문자열 값을 몇 번 수정하면, `numberOfEdits` 속성 값이 수정된 횟수 만큼 갱신되는 것을 볼 수 있습니다:

```swift
var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")
// "The number of edit is 3" 를 출력합니다.
```

비록 다른 소스 파일에서도 `numberOfEdits` 속성의 현재 값을 조회할 수는 있겠지만, 다른 소스 파일에서 그 속성을 _수정하는 (modify)_ 것은 불가능합니다. 이러한 제한은 `TrackedString` 의 추적-편집 기능에 대한 세부 구현을 보호하면서도, 여전히 그 기능 부분에 대한 편리한 접근 방법을 제공하도록 해줍니다.

필요하다면 '획득자 (getter)' 와 '설정자 (setter)' 모두에 대해 명시적인 접근 수준을 할당할 수 있음에 주목하기 바랍니다. 아래 예제는 구조체를 명시적으로 'public (공용)' 접근 수준으로 정의한 `TrackedString` 구조체를 보여줍니다. (`numberOfEdits` 속성을 포함한) 구조체의 멤버들은 그러므로 기본적으로 'internal (내부)' 접근 수준을 가지게 됩니다.[^internal-by-default] 구조체의 `numberOfEdits` 속성에서, `public` 과 `private(set)` 수정자 (modifiers) 를 결합하면, '획득자 (getter)' 는 'public (공용)' 으로 하면서 '설정자 (setter)' 는 'private (개인 전용)' 으로 만들 수 있습니다:

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

직접 만든 초기자에는 초기화하려는 타입보다 같거나 더 낮은 수준의 접근 수준을 할당할 수 있습니다. 단 하나의 예외는 '필수 초기자 (required initializers)' 입니다. ([Required Initializers (필수 초기자)]({% post_url 2016-01-23-Initialization %}#required-initializers-필수-초기자) 에서 정의한 바와 같습니다.) '필수 초기자' 는 자신이 속해 있는 클래스와 같은 접근 수준을 가져야 합니다.

'함수 매개 변수' 및 '메소드 매개 변수' 처럼, 초기자의 매개 변수 타입도 초기자가 가지고 있는 접근 수준보다 더 '개인적 (private)' 일 수 없습니다.

#### Default Initializers (기본 설정 초기자)

[Default Initializers (기본 설정 초기자)]({% post_url 2016-01-23-Initialization %}#default-initializers-기본-설정-초기자) 에서 설명한 것처럼, 스위프트는 어떤 구조체나 '기본 클래스 (base class)' 가 모든 속성에 대한 '기본 설정 값' 을 제공하면서도 스스로는 단 하나의 초기자도 제공하지 않을 경우 '_기본 설정 초기자 (default initializer)_' 를 제공합니다.

'기본 설정 초기자' 는, 해당 타입이 `public` 으로 정의되어 있는 경우를 제외하면, 자기가 초기화하는 타입과 같은 접근 수준을 가집니다. 타입이 `public` 으로 정의된 경우에는, '기본 설정 초기자' 가 'internal (내부)' 인 것으로 여겨집니다. 다른 모듈에서 'public (공용)' 타입을 '인자가 없는 (no-argument)' 초기자로 초기화할 수 있게 만들고 싶으면, 타입을 정의하면서 반드시 'public no-argument initializer (공용의 인자-없는 초기자)' 를 명시적으로 제공해야 합니다.

#### Default Memberwise Initializers for Structure Types (구조체 타입을 위해 기본 제공되는 멤버 초기자)

구조체의 저장 속성 중 어떤 것이라도 'private (개인 전용)' 이면 구조체 타입에 기본 제공되는 '멤버 초기자' 도 'private (개인 전용)' 으로 여겨집니다. 게다가, 구조체의 '저장 속성' 중 어떤 것이라도 'file private (파일 전용)' 이면, 그 초기자는 'file private (파일 전용)' 이 됩니다. 그 외의 경우에는, 초기자의 접근 수준이 'internal (내부)' 가 됩니다.

위의 '기본 설정 초기자' 에서와 마찬가지로, 다른 모듈에서 'public (공용)' 타입을 '멤버 초기자' 로 초기화할 수 있게 만들고 싶으면, 타입을 정의하면서 반드시 'public memberwise initializer (공용 멤버 초기자)' 를 직접 제공해야 합니다.

### Protocols (프로토콜)

프로토콜 타입에 대한 접근 수준을 명시적으로 할당하고 싶으면, 프로토콜을 정의하는 시점에 그렇게 해야 합니다. 이렇게 하면 지정한 접근 영역에서만 '채택 (adopt)' 할 수 있는 프로토콜을 생성할 수 있습니다.

프로토콜 정의에 있는 각 '필수 조건 (requirement)' 은 자동적으로 그 프로토콜과 같은 접근 수준으로 설정됩니다. 프로토콜의 '필수 조건' 에 그것이 지원하는 프로토콜과 다른 접근 수준을 설정할 수는 없습니다. 이렇게 하는 것은 프로토콜을 채택하는 타입이 어떤 것이든 프로토콜의 모든 '필수 조건' 을 볼 수 있도록 하기 위함입니다.

> 'public (공용)' 프로토콜을 정의하게 되면, 프로토콜의 '필수 조건' 은 그 '필수 조건' 을 '공용 (public)' 접근 수준으로 구현할 것을 요구합니다. 이러한 방식은 다른 타입들과는 다른 것이며, 다른 타입들은 'public (공용)' 타입을 정의할 때 그 타입 멤버를 'internal (내부)' 접근 수준으로 구현합니다.

#### Protocol Inheritance (프로토콜 상속)

기존 프로토콜을 상속하는 새로운 프로토콜을 정의할 경우, 이 새 프로토콜이 최대로 가질 수 있는 접근 수준은 상속 해주는 프로토콜과 같은 수준입니다.[^at-most-the-same] 예를 들어, 'internal (내부)' 프로토콜을 상속하는 'public (공용)' 프로토콜을 작성할 수는 없습니다.

#### Protocol Conformance (프로토콜 준수)

타입은 타입 그 자체보다 더 낮은 접근 수준으로 프로토콜을 준수[^conform-to-a-protocol]할 수 있습니다. 예를 들어, 다른 모듈에서 사용할 수 있는 'public (공용)' 타입을 정의하면서, 'internal (내부)' 프로토콜을 정의하는 모듈 내에서만 사용할 수 있는 'internal (내부)' 프로토콜을 준수할 수도 있습니다.

타입이 특정한 프로토콜을 준수할 때의 수준은 타입의 접근 수준과 프로토콜의 접근 수준의 '최소 값 (the minimum)'[^the-minimum] 입니다. 예를 들어, 타입이 'public (공용)' 이라도, 그것이 준수하는 프로토콜이 'internal (내부)' 이면, 타입은 그 프로토콜 역시 'internal (내부)' 로 준수하게 됩니다.

타입을 작성하거나 확장하면서 프로토콜을 준수할 때는, 프로토콜의 각 '필수 조건 (requirement)' 에 대한 구현이 적어도 타입 준수하는 프로토콜과 같은 접근 수준을 가지도록 해야 합니다. 예를 들어, 'public (공용)' 타입이 'internal (내부)' 프로토콜을 준수하는 경우, 프로토콜의 각 '필수 조건' 을 구현할 때는 최소한 'internal (내부)' 가 되도록 해야 합니다.

> 스위프트에서는, 오브젝티브-C 에서와 마찬가지로, '프로토콜 준수 기능 (protocol conformance)' 이 '전역 (global)' 입니다-같은 프로그램에서 한 프로토콜을 서로 다른 두 가지 방법으로 준수하는 것은 불가능합니다.

### Extensions (확장)

클래스, 구조체, 또는 열거체가 사용 가능한 접근 영역에 있다면 어떤 영역에서든 그 클래스, 구조체, 또는 열거체를 확장할 수 있습니다. 확장에서 추가한 타입 멤버는 어느 것이든 기본적으로 확장할 원래 타입에서 선언된 타입 멤버와 같은 접근 수준을 가집니다. 'public (공용)' 이나 'internal (내부)' 타입을 확장하면, 새로 추가 타입은 어느 것이든 기본 접근 수준으로 'internal (내부)' 을 가지게 됩니다. 'file-private (파일-전용)' 타입을 확장하면, 새로 추가한 타입은 어느 것이든 기본 접근 수준으로 'file private (파일 전용)' 을 가집니다. 'private (개인 전용)' 타입을 확장하면, 새로 추가한 타입은 어느 것이든 기본 접근 수준으로 'private (개인 전용)' 을 가집니다.

다른 방법으로, 'extension (확장)' 에 명시적으로 '접근-수준 수정자 (access-level modifier)' (예를 들어, `private` 같은 것) 을 표시해서, 확장 내에서 정의한 모든 멤버들에 대한 새 '기본 접근 수준 (default access level)' 을 설정할 수 있습니다. 이러한 새 기본 설정을 개별 타입 멤버에 대한 'extension (확장)' 에서 '재정의 (overridden)' 하는 것도 여전히 가능합니다.

'프로토콜 준수 기능 (protocol conformance)' 를 추가하기 위해 'extension (확장)' 을 사용하는 경우에는 그 'extension (확장)' 에 대한 '명시적인 접근-수준 수정자' 를 제공할 수 없습니다. 대신, 프로토콜 자체의 접근 수준을 사용해서 'extension (확장)' 에 있는 각각의 프로토콜 '필수 조건 (requirement)' 구현에 대한 기본 접근 수준을 제공합니다.

### Private Members in Extensions (확장 내의 '개인 전용' 멤버)

'extension (확장)' 이 자기가 확장하는 클래스, 구조체, 또는 열거체와 같은 파일에 있다면 'extension (확장)' 내에 있는 코드는 마치 원래 타입 선언에서 작성된 것처럼 동작합니다. 그 결과, 다음과 같은 것을 할 수 있습니다:

* 원래 선언에서 'private (개인 전용)' 멤버를 선언하고, 그 멤버를 같은 파일 내에 있는 'extensions (확장)' 들에서 접근할 수 있습니다.
* 한 'extension (확장)' 에서 'private (개인 전용)' 멤버를 선언하고, 그 멤버를 같은 파일 내에 있는 다른 'extension (확장)' 에서 접근할 수 있습니다.
* 어떤 'extension (확장)' 에서 'private (개인 전용)' 멤버를 선언하고, 그 멤버를 같은 파일 내에 있는 원래의 선언에서 접근할 수 있습니다.

이러한 동작은 'extension (확장)' 을 사용해서, 'private (개인 전용)' 엔티티를 가지고 있는 지를 기준으로, 타입의 코드를 정돈할 수 있음을 의미합니다. 예를 들어, 다음과 같은 간단한 프로토콜이 주어졌을 경우를 알아봅시다:

```swift
protocol SomeProtocol {
  func doSomething()
}
```

이제 아래와 같이, 'extension (확장)' 을 사용하여 '프로토콜 준수 기능' 을 추가할 수 있습니다:

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

'generic type (일반화된 타입)' 이나 'generic function (일반화된 함수)' 에 대한 접근 수준은 '일반화된 타입' 및 '일반화된 함수' 스스로의 접근 수준과 그 타입 매개 변수의 '타입 구속 조건' 에 대한접근 수준 중 최소인 것으로 정해집니다.

### Type Aliases (타입 별명)

직접 정의한 'type aliases (타입 별명)' 은 어떤 것이든 접근 수준의 관점에서는 별개의 타입인 것처럼 처리됩니다. '타입 별명' 은 별명을 짓는 타입의 접근 수준보다 낮거나 같은 접근 수준을 가질 수 있습니다. 예를 들어, 'private (개인 전용) 타입 별명' 은 'private (개인 전용)', 'file-private (파일-전용)', 'internal (내부)', 'public (공용)', 또는 'open (공개)' 타입에 대한 별명이 될 수 있지만, 'public (공용) 타입 별명' 은 'internal (내부)', 'file-private (파일-전용)', 또는 'private (개인 전용)' 타입의 별명이 될 수 없습니다.

> 이 규칙은 '프로토콜 준수 기능' 를 만족시킬려고 사용하는 '결합된 타입 (associated types)' 를 위한 '타입 별명' 에도 동일하게 적용됩니다.

### 참고 자료

[^Access-Control]: 이 글에 대한 원문은 [Access Control](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html) 에서 확인할 수 있습니다.

[^the-most-restrictive]: 본문의 설명에 따르면 '가장 제한된 접근 수준' 은 '가장 낮은 접근' 수준을 의미합니다. 스위프트의 접근 수준을 높은 순서대로 나열하면 'open (공개)' > 'public (공용)' > 'internal (내부)' > 'file-private (파일-전용)' > 'private (개인 전용)' 과 같습니다.

[^function-access-level]: '함수가 계산한 접근 수준' 과 '해당 영역의 기본적인 의미' 가 같아야 한다는 것은, 이어지는 예제에서 설명하고 있습니다. 즉, 함수의 접근 수준을 계산해보니 'private' 일 때는, 반드시 함수의 정의에 'private' 을 써줘야 한다는 것 입니다. 그렇게 하지 않으면, '함수가 계산한 접근 수준 (private)' 과 '해당 영역의 기본적인 의미 (internal)' 가 다르므로, 컴파일이 안되게 됩니다.

[^raw-values-and-associated-values]: 스위프트의 열거체는 각 '경우 값 (case)' 마다 '원시 값 (raw value)' 과 '결합된 값 (associated value)' 이라는 별도의 값을 가집니다. `enum Direction: Int { case east = 0, west }` 라고 하면 `east` 는 '경우 값' 이고,  `east` 의 '원시 값' 은 `0` 입니다. '결합된 값' 은 '경우 값' 의 각 인스턴스마다 할당하는 값을 말하는데, `enum Direction { case east(String), west(String) }; let east = Direction.east("Sun rise")` 라고 하면, `east` 의 '경우 값' 은 `"Sun rise"` 가 됩니다.

[^higher]: 본문의 앞 부분에서도 나오지만, 스위프트에서 접근 수준은 'open (공개)' 가 가장 높고, 'private (개인 전용)' 이 가장 낮습니다. 높은 순서대로 나열하면 'open (공개)' > 'public (공용)' > 'internal (내부)' > 'file-private (파일-전용)' > 'private (개인 전용)' 과 같습니다.

[^more-public]: 여기서 '더 공개적 (more public)' 이라는 말은, '접근 수준 (access level)' 이 더 높은 것을 말합니다. 스위프트의 접근 수준은 'open (공개)' 가 가장 높고, 'private (개인 전용)' 이 가장 낮습니다. '상수나 변수가 타입보다 더 공개적일 수 없다' 는 말은 `let a: Int = 0` 에서 `a` 의 접근 수준이 `Int` 의 접근 수준보다 더 공개적일 수 없다-더 높은 접근 수준을 가질 수 없다-는 것을 의미합니다.

[^internal-by-default]: 문서의 앞 부분인 [Custom Types (사용자 정의 타입)](#custom-types-사용자-정의-타입) 에서 설명한 것처럼, 사용자 정의 클래스의 접근 수준을 'public (공용)' 으로 정의하면 멤버의 기본 접근 수준은 'internal (내부)' 가 됩니다.

[^at-most-the-same]: 이 접근 수준은 '함수' 와 같은 규칙에 해당합니다. 즉, '한 프로토콜 (상속하는 프로토콜)' 은 '그 구성 요소 (상속을 해주는 프로토콜)' 보다 더 높은 접근 수준을 가질 수 없다고 이해할 수 있습니다.

[^conform-to-a-protocol]: 스위프트에는 '프로토콜' 이라는 개념이 있는데, C++ 언어 및 Java 언어의 '추상 클래스 (abstract class)' 와 비슷한 개념입니다. 스위프트에는 '어떤 타입이 프로토콜을 상속한다' 라는 말은 없으며, 대신에 '어떤 타입이 프로토콜을 준수한다' 라는 말을 사용합니다. 스위프트에서 '프로토콜 상속' 이라는 것은 두 '프로토콜' 사이에서만 존재하는 개념입니다.

[^the-minimum]: 이 말은 공통된 접근 수준 중에서 '가장 낮은' 접근 수준을 가진다는 말입니다.
