---
layout: post
comments: true
title:  "Swift 5.5: Access Control (접근 제어)"
date:   2020-04-28 10:00:00 +0900
categories: Swift Language Grammar Access Control
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Access Control](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html) 부분[^Access-Control]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Access Control (접근 제어)

_접근 제어 (Access Control)_ 는 다른 소스 파일과 모듈에 있는 코드가 이 코드에 접근하는 것을 제약합니다. 이러한 특징은 코드의 세부 구현은 숨기면서, 해당 코드에 접근하고 사용할 수 있는 바람직한 인터페이스를 지정하도록 해줍니다.

(클래스, 구조체, 그리고 열거체 같은) 개별 타입 뿐만 아니라, 그 타입에 속한 속성, 메소드, 초기자, 그리고 첨자 연산에도 특정한 '접근 수준' 을 할당할 수 있습니다. '프토토콜' 은, 전역인 상수, 변수, 그리고 함수가 그러는 것처럼, 정해진 '상황 (context)' 으로 제약될 수 있습니다.

다양한 수준의 접근 제어를 제안하는 것에 더하여, 스위프트는 '전형적인 상황 (scenarios)' 을 위해 '기본적인 접근 수준' 을 제공함으로써 '접근 제어 수준' 을 명시적으로 지정할 필요를 줄여줍니다. 진짜로, '단일-대상 (single-target) 앱' 을 작성하고 있다면, 명시적인 접근 제어 수준을 지정할 필요가 전혀 없을 수도 있습니다.

> 아래 부분에서 접근 제어를 적용할 수 있는 코드의 다양한 측면 (속성, 타입, 함수, 등등) 은, 간결함을 위해, "개체 (entities)" 라고 부르도록 합니다.

### Modules and Source Files (모듈과 소스 파일)

스위프트의 '접근 제어 모델' 은 모듈과 소스 파일이라는 개념을 기초로 합니다.

_모듈 (module)_ 은 단일한 코드 배포 단위-단일 단위로 제작하고 출하하며 스위프트의 또 다른 모듈에서 `import` 키워드로 불러올 수 있는 '프레임웍 (framework)' 이나 '응용 프로그램'-입니다.

'Xcode' 에서 ('앱 번들 (app bundle)' 이나 '프레임웍' 같은) 각각의 '제작 대상 (build target)' 은 스위프트에 있는 별도의 모듈처럼 취급합니다. 앱 코드의 각 측면들을-아마도 해당 코드를 은닉하여 여러 응용 프로그램에서 재사용하려고-'독립된 프레임웍' 으로 그룹지으면, 앱에서 불러오고 사용할 때, 또는 다른 프레임웍에서 사용할 때, 해당 프레임웍 안에서 정의한 모든 것이 별도의 모듈이 될 것입니다.

_소스 파일 (source file)_ 은 모듈 안의 단일 스위프트 소스 코드 파일 (실제론, 앱이나 프레임웍 안의 단일 파일) 입니다. 비록 개별 타입을 별도의 소스 파일에 정의하는 것이 일반적으로 공통일지라도, 단일 소스 파일에 여러 타입, 함수, 등등의 정의를 담을 수 있습니다.

### Access Levels (접근 수준)

스위프트는 코드 안의 '개체 (entities)' 들에 대하여 다섯 개의 서로 다른 _접근 수준 (access levels)_ 을 제공합니다. 이 '접근 수준' 들은 '개체' 를 정의한 소스 파일과도 관계가 있고, 해당 소스 파일이 속한 모듈과도 관계가 있습니다.

* _공개 접근 (open access)_ 과 _공용 접근 (public access)_ 은 자신을 정의한 모듈의 어떤 소스 파일 안에서든, 그리고 정의한 모듈을 불러온 다른 모듈에 있는 소스 파일에서도 '개체' 를 사용할 수 있게 합니다. 전형적으로 '공개 (open)' 또는 '공용 (public) 접근' 은 프레임웍의 공용 인터페이스를 지정할 때 사용합니다. '공개 (open)' 와 '공용 (public) 접근' 의 차이점은 아래에서 설명합니다.
* _내부 접근 (internal access)_ 은 자신을 정의한 모듈의 어떤 소스 파일 안에서는 사용할 수 있지만, 해당 모듈 밖의 어떤 소스 파일에서는 '개체' 를 사용할 수 없도록 합니다. 전형적으로 '내부 (internal) 접근' 은 앱이나 프레임웍의 내부 구조를 정의할 때 사용합니다.
* _파일-전용 접근 (file-private access)_ 은 '개체' 의 사용을 자신을 정의한 소스 파일만으로 제약합니다. '파일-전용 (file-private) 접근' 은 특정 기능을 전체 파일에서 사용하면서 해당 세부 구현을 숨겨야할 때 사용합니다.
* _개인 전용 접근 (private access)_ 은 '개체' 의 사용을, 똑같은 파일에 있는 '(자신을) 둘러싼 선언' 과 해당 선언의 '익스텐션' 만으로, 제약합니다. '개인 전용 (private) 접근' 은 특정 기능을 단일 선언에서만 사용하면서 해당 세부 구현을 숨겨야할 때 사용합니다.

'공개 접근' 은 가장 높은 (최소로 제약한) 접근 수준이며 '개인 전용 접근' 은 '가장 낮은 (가장 제약한)' 접근 수준입니다.

'공개 접근' 은 클래스와 클래스 멤버에만 적용하며, 아래에 있는 [Subclassing (하위 클래스)](#subclassing-하위-클래스) 에서 논의하는 것처럼, 모듈 밖의 코드에 '하위 클래스 만들기' 와 '재정의 (override)' 를 허용한다는 점에서 '공용 접근' 과 차이가 있습니다. 클래스를 명시적으로 '공개 (open)' 라고 표시하는 것은 해당 클래스를 상위 클래스로 사용하는 다른 모듈의 코드에 가해지는 충격을 고려하여, 그에 따라 클래스 코드를 설계했다고 지시하는 것입니다.

#### Guiding Principle of Access Levels (접근 수준에 대한 지침)

스위프트의 접근 수준은: _어떤 '개체' 도 '더 낮은 (더 제약한) 접근 수준' 을 가진 다른 '개체' 를 써서 정의할 수 없다._ 는 '전반적인 지침' 을 따릅니다.

예를 들면 다음과 같습니다:

* '공용 (public) 변수' 는 '내부 (internal)', '파일-전용 (file-private)', 또는 '개인 전용 (private) 타입' 을 가지도록 정의할 수 없는데, '공용 변수' 를 사용하는 모든 곳에서 타입이 사용 가능한 것은 아닐 수도 있기 때문입니다.
* '함수' 는 자신의 매개 변수 타입 및 반환 타입 보다 더 높은 접근 수준을 가질 수 없는데, 주위 코드에서 자신의 구성 요소 타입을 사용할 수 없는 곳에서 함수를 사용하게 될 수 있기 때문입니다.

언어의 각 측면에 대해서 이 지침이 가진 특정한 '의미 (implications)' 는 아래에서 자세하게 다룹니다:

#### Default Access Levels (기본 접근 수준)

(이 장 나중에 설명할, 몇몇 특정한 예외를 제외하면) 코드의 모든 '개체' 들은 직접 명시적인 '접근 수준' 을 지정하지 않을 경우 '내부 (internal)' 라는 '기본 접근 수준' 을 가집니다. 그 결과, 많은 경우 코드에서 '접근 수준' 을 명시적으로 지정할 필요가 없습니다.

#### Access Levels for Single-Target Apps ('단일-대상 앱' 을 위한 접근 수준)

간단한 '단일-대상 (single-target) 앱' 을 작성할 때, 앱의 코드는 앱 안에 '독립된' 것이 전형적이며, 앱 모듈 밖에서 사용 가능하게 할 필요가 없습니다. '내부 (internal)' 라는 '기본 접근 수준' 은 이미 이 필수 조건과 일치합니다. 그러므로, 따로 접근 수준을 지정할 필요가 없습니다. 하지만, 앱 모듈 내의 다른 코드로 부터 세부 구현을 숨기기 위해서 코드 일부를 '파일 전용 (file private)' 이나 '개인 전용 (private)' 으로 표시할 수도 있습니다.

#### Access Levels for Frameworks ('프레임웍' 을 위한 접근 수준)

'프레임웍' 을 개발할 때, 해당 프레임웍에서 '공용을-향한 인터페이스' 를 '공개 (open)' 나 '공용 (public)' 으로 표시하여야, 프레임웍을 불러온 앱 같은, 다른 모듈이 보고 접근할 수 있습니다. 이런 '공용을-향한 인터페이스' 가 프레임웍의 '응용 프로그래밍 인터페이스 (또는 API[^API])' 입니다.

> 프레임웍의 다른 내부 코드로부터 숨기고 싶은, 프레임웍의 어떤 세부 내부 구현이든 여전히 '내부 (internal)' 라는 '기본 접근 수준' 을 사용하거나, '개인 전용 (private)' 또는 '파일 전용 (file private)' 이라고 표시할 수 있습니다. 프레임웍의 'API' 가 되길 원할 경우에만 '개체' 를 '공개 (open)' 또는 '공용 (public)' 으로 표시해야 합니다.

#### Access Levels for Unit Test Targets ('단위 테스트 대상' 을 위한 접근 수준)

'단위 테스트 대상' 을 가진 앱을 작성할 때, 테스트를 위해서는 해당 모듈에서 앱의 코드를 사용 가능하도록 만들 필요가 있습니다. 기본적으로는, '공개 (open)' 나 '공용 (public)' 으로 표시한 '개체' 만 다른 모듈에서 접근 가능합니다. 하지만, '단위 테스트 대상' 은, 제품 모듈에 대한 '불러오기 (import) 선언' 을 '`@testable` 특성 (attribute)' 으로 표시하고 해당 제품을 '테스트 가능 (test enabled)' 하도록 컴파일한 경우라면, 어떤 '내부 (internal) 개체' 든 접근할 수 있습니다.

### Access Control Syntax (접근 제어 구문)

'개체' 의 '접근 수준' 은 '개체' 선언의 맨 앞에 `open`, `public`, `internal`, `fileprivate`, 또는 `private` 수정자를 붙임으로써 정의합니다.

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

따로 지정하지 않으면, [Default Access Levels (기본 접근 수준)](#default-access-levels-기본-접근-수준) 에서 설명한 것처럼, 기본 접근 수준이 '내부 (internal)' 입니다. 이는 `SomeInternalClass` 와 `someInternalConstant` 는 '명시적인 접근-수준 수정자 (modifier)' 없이 작성해도 되며, 그래도 여전히 '내부 (internal)' 라는 접근 수준을 가진다는 의미입니다.

```swift
class SomeInternalClass {}        // 암시적인 내부
let someInternalConstant = 0      // 암시적인 내부
```

### Custom Types (사용자 정의 타입)

'사용자 정의 타입' 에 명시적인 접근 수준을 지정하고 싶으면, 타입을 정의하는 시점에 그렇게 합니다. 그러면 새로운 타입을 접근 수준이 허가하는 어디서나 사용할 수 있습니다. 예를 들어, '파일-전용 (file-private) 클래스' 를 정의하면, 해당 클래스는 '파일-전용 클래스' 를 정의한 소스 파일에 있는, 속성의 타입, 또는 함수 매개 변수나 반환 타입으로만 사용할 수 있습니다.

타입의 접근 제어 수준은 (속성, 메소드, 초기자, 및 첨자 연산 같은) 해당 타입의 _멤버 (members)_ 를 위한 '기본 접근 수준' 에도 영향을 줍니다. 타입의 접근 수준을 '개인 전용 (private)' 이나 '파일 전용 (file private)' 으로 정의하면, 멤버의 기본 접근 수준도 '개인 전용 (private)' 또는 '파일 전용 (file private)' 이 될 것입니다. 타입의 접근 수준을 '내부 (internal)' 나 '공용 (public)' 으로 정의 (하거나 접근 수준을 명시적으로 지정하지 않고 '내부 (internal)' 라는 기본 접근 수준을 사용) 하는 경우, 타입의 멤버에 대한 기본 접근 수준이 '내부 (internal)' 가 될 것입니다.

> '공용 (public) 타입' 은, '공용 (public) 멤버' 가 아닌, '내부 (internal) 멤버' 를 가지는 것이 기본입니다. 타입 멤버가 '공용 (public)' 이길 원한다면, 명시적으로 그렇다고 표시해야 합니다. 이 '필수 조건' 은 타입에서 '공용을-향한 API' 는 직접 발행한다고 선택하는 것임을 보장하며, 실수로 타입 내부의 작업을 '공용 API' 로 출연시키는 것을 막아줍니다.

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

튜플 타입의 접근 수준은 해당 튜플에서 사용한 모든 타입 중 '가장 제약한 (the most restrictive) 접근 수준'[^the-most-restrictive] 입니다. 예를 들어, 하나는 '내부 (internal) 접근' 이고 하나는 '개인 전용 (private) 접근' 인, 두 개의 서로 다른 타입을 튜플로 합성하면, 해당 '복합 튜플 타입' 의 접근 수준은 '개인 전용 (private)' 이 될 것입니다.

> 튜플 타입은 클래스, 구조체, 열거체, 그리고 함수가 하는 방식의 '독립적인 정의' 를 가지지 않습니다. 튜플 타입의 접근 수준은 튜플 타입을 이루는 타입들에 의해 자동으로 결정되며, 명시적으로 지정할 순 없습니다.

#### Function Types (함수 타입)

함수 타입의 접근 수준은 함수의 매개 변수 타입과 반환 타입 중에서 '가장 제약한 접근 수준' 이라고 계산합니다. 함수가 계산한 접근 수준이 기본적인 상황과 일치하지 않을 경우 함수 정의에서 명시적으로 접근 수준을 지정해야 합니다.[^function-access-level]

아래 예제는, 함수 스스로 특정 '접근-수준 수정자 (modifier)' 를 제공하지 않으면서, `someFunction()` 이라는 전역 함수를 정의합니다. 이 함수가 "내부 (internal)" 라는 기본 접근 수준을 가진다고 예상했겠지만, 그렇지 않습니다. 사실상, 아래 처럼 작성한 `someFunction()` 은 컴파일이 안 될 것입니다:

```swift
func someFunction() -> (SomeInternalClass, SomePrivateClass) {
  // 함수 구현은 여기에 둡니다.
}
```

함수의 반환 타입은 위의 [Custom Types (사용자 정의 타입)](#custom-types-사용자-정의-타입) 에서 정의한 두 사용자 정의 클래스를 합성한 '튜플 타입' 입니다. 이 클래스 중 하나는 '내부 (internal)' 라고 정의하고, 다른 건 '개인 전용 (private)' 이라고 정의합니다. 그러므로, '복합 튜플 타입' 의 '전체적인 접근 수준' 은 (튜플의 구성 요소 타입들 중 '최소 접근 수준' 인) '개인 전용' 입니다.

함수의 반환 타입이 '개인 전용' 이기 때문에, 함수 선언이 유효하려면 함수의 전체적인 접근 수준을 `private` 수정자로 반드시 표시해야 합니다:

```swift
private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
  // 함수 구현은 여기에 둡니다.
}
```

`someFunction()` 정의를 `public` 또는 `internal` 수정자로 표시하거나, '내부 (internal)' 라는 기본 설정을 사용하는 것은 유효하지 않은데, 함수의 '공용' 또는 '내부 사용자' 가 함수 반환 타입의 '개인 전용 클래스' 에 접근하는 것이 적절하지 않을 수 있기 때문입니다.

#### Enumeration Types (열거체 타입)

열거체의 '개별 case 값' 은 자신이 속한 열거체와 똑같은 접근 수준을 자동으로 부여 받습니다. 개별 '열거체 case 값' 마다 서로 다른 접근 수준을 지정할 수 없습니다.

아래 예제에서, `CompassPoint` 열거체는 '공용 (public)' 이라는 '명시적인 접근 수준' 을 가집니다. '열거체 case 값' 인 `north`, `south`, `east`, 그리고 `west` 도 따라서 '공용 (public)' 이라는 접근 수준을 가집니다:

```swift
public enum CompassPoint {
  case north
  case south
  case east
  case west
}
```

**Raw Values and Associated Values ('원시 값' 과 '결합 값')**

열거체 정의에서 '원시 값 (raw values)' 이나 '결합 값 (associated values)'[^raw-values-and-associated-values] 으로 사용된 어떤 타입이든 적어도 열거체의 접근 수준 만큼은 높아야 합니다. 예를 들어, '내부 (internal) 접근 수준' 을 가진 열거체의 '원시-값 타입' 으로 '개인 전용 (private) 타입' 을 사용할 수 없습니다.

#### Nested Types (중첩 타입)

'중첩 타입' 의 접근 수준은, 자신을 '담은 (containing) 타입' 이 '공용 (public)' 이 아니라면, 자신을 '담은 타입' 과 똑같습니다. '공용 타입' 안에서 정의한 '중첩 타입' 은 자동으로 '내부' 라는 접근 수준을 가집니다. '공용 타입' 안의 '중첩 타입' 을 공용으로 사용하고 싶으면, 반드시 명시적으로 '중첩 타입' 이 '공용' 이라고 선언해야 합니다.

### Subclassing (하위 클래스)

현재 접근 상황에서 접근할 수 있으며 동일 모듈에서 하위 클래스로 정의한 어떤 클래스든 하위 클래스를 만들 수 있습니다. 다른 모듈에서 정의한 어떤 '공개 (open) 클래스' 도 역시 하위 클래스를 만들 수 있습니다. 하위 클래스는 자신의 상위 클래스보다 더 높은 접근 수준을 가질 수 없습니다-예를 들어, '내부 (internal) 상위 클래스' 에 대한 '공용 (public) 하위 클래스' 를 작성할 수 없습니다.

이에 더하여, 동일 모듈에서 정의한 클래스들은, 정해진 접근 상황에서 보이는 (메소드, 속성, 초기자, 또는 첨자 연산 같은) 어떤 클래스 멤버든 '재정의 (override)' 할 수 있습니다. 또 다른 모듈에서 정의한 클래스는, 어떤 '공개 (open) 클래스 멤버' 든 '재정의' 할 수 있습니다.

'재정의' 는 상속한 클래스 멤버의 접근 가능성을 상위 클래스 버전에서 보다 더 높일 수있습니다. 아래 예제에서, 클래스 `A` 는 `someMethod()` 라는 '파일-전용 (file-private) 메소드' 를 가진 '공용 (public) 클래스' 입니다. 클래스 `B` 는, "내부 (internal)" 라는 '감소한 접근 수준' 을 가진, `A` 의 하위 클래스입니다. 그럼에도 불구하고, 클래스 `B` 는, `someMethod()` 의 원본 구현보다 _더 높은 (higher)_[^higher], "내부 (internal)" 라는 접근 수준을 가진 `someMethod()` 의 재정의 버전을 제공합니다:[^subclassing]

```swift
public class A {
  fileprivate func someMethod() {}
}

internal class B: A {
  override internal func someMethod() {}
}
```

상위 클래스 멤버에 대한 호출이 (즉, 상위 클래스와 동일한 소스 파일에서 '파일-전용' 멤버를 호출하거나, 상위 클래스와 동일한 모듈에서 '내부' 멤버를 호출하는 것 처럼) 허용된 접근 수준 상황에서 일어나는 한, 하위 클래스 멤버가 심지어 하위 클래스 멤버보다 더 낮은 접근 수준 권한을 가진 상위 클래스 멤버를 호출하는 것도 유효합니다:

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

상위 클래스 `A` 와 하위 클래스 `B` 를 동일 소스 파일에서 정의하기 때문에, `B` 에서 구현한 `someMethod()` 가 `super.someMethod()` 를 호출하는 것은 유효합니다.

### Constants, Variables, Properties, and Subscripts (상수, 변수, 속성, 그리고 첨자 연산)

상수, 변수, 또는 속성은 자신의 타입보다 더 '공개 (public)' 적일 수 없습니다.[^more-public] 예를 들어, '개인 전용 (private) 타입' 을 가진 '공용 (public) 속성' 을 작성하는 것은 유효하지 않습니다. 이와 비슷하게, 첨자 연산은 자신의 '색인 타입' 이나 '반환 타입' 보다 더 '공개 (public)' 적일 수 없습니다.

상수, 변수, 속성, 또는 첨자 연산이 '개인 전용 타입' 을 사용할 경우, 그 상수, 변수, 속성, 또는 첨자 연산도 반드시 `private` 이라고 표시해야 합니다:

```swift
private var privateInstance = SomePrivateClass()
```

#### Getters and Setters ('획득자' 와 '설정자')

상수, 변수, 속성, 또는 첨자 연산을 위한 '획득자 (getters)' 와 '설정자 (setters)' 는 자신이 속한 상수, 변수, 속성, 또는 첨자 연산과 똑같은 접근 수준을 자동으로 부여 받습니다.

'설정자' 는, 해당 변수, 속성, 또는 첨자 연산에 대한 '읽고-쓰기' 영역 범위를 제약하기 위해, 자신과 연관된 '획득자' 보다 _더 낮은 (lower)_ 접근 수준을 부여할 수 있습니다. '더 낮은 접근 수준' 은 '`var`' 또는 '`subscript` 도입자 (introducer)' 앞에 `fileprivate(set)`, `private(set)`, 또는 `internal(set)` 을 작성함으로써 할당합니다.

> 이 규칙은 '계산 속성' 뿐만 아니라 '저장 속성' 에도 적용됩니다. '저장 속성' 을 위한 '명시적인 획득자' 와 '설정자' 를 작성하진 않을지라도, 스위프트는 '저장 속성' 의 '백업 저장 공간' 에 대한 접근을 제공하기 위해 여전히 '암시적인 획득자' 와 '설정자' 를 만들고 통합합니다. `fileprivate(set)`, `private(set)`, 그리고 `internal(set)` 을 사용하면 이 '통합된 설정자' 의 접근 수준을 '계산 속성' 의 '명시적인 설정자' 와 정확하게 똑같은 방식으로 바꾸게 됩니다.

아래 예제는, 문자열 속성이 수정된 횟수를 추적하는, `TrackedString` 이라는 구조체를 정의합니다:

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

`TrackedString` 구조체는, 초기 값이 `""` (빈 문자열) 인, `value` 라는 '문자열 저장 속성' 을 정의합니다. 구조체는, `value` 를 수정한 횟수를 추적하는데 사용하는, `numberOfEdits` 라는 '정수 저장 속성' 도 정의합니다. 이 '수정 추적' 기능은, `value` 속성에 새 값이 설정될 때마다 `numberOfEdits` 를 증가하는, `value` 속성의 '`didSet` 속성 관찰자 (property observer)'[^property-observer] 로 구현합니다.

`TrackedString` 구조체와 `value` 속성은 '명시적인 접근-수준 수정자 (modifier)' 를 제공하지 않으므로, 둘 다 '내부 (internal)' 라는 기본 접근 수준을 부여 받습니다. 하지만, 속성의 '획득자' 는 여전히 '내부 (internal)' 라는 기본 접근 수준을 가지지만, `TrackedString` 구조체 안의 코드만 속성을 설정할 수 있음을 지시하기 위해 `numberOfEdits` 속성의 접근 수준을 `private(set)` 수정자로 표시합니다. 이는 `TrackedString` 이 내부적으로는 `numberOfEdits` 속성을 수정하도록 하지만, 구조체 정의 밖에서 사용할 때는 속성을 '읽기-전용 속성' 으로 나타날 수 있게 해줍니다.

`TrackedString` 인스턴스를 생성해서 문자열 값을 몇 번 수정하면, `numberOfEdits` 속성 값이 수정 횟수와 일치하도록 갱신되는 것을 볼 수 있습니다:

```swift
var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")
// "The number of edit is 3" 를 인쇄합니다.
```

비록 다른 소스 파일에 있는 `numberOfEdits` 속성의 현재 값을 조회할 순 있을지라도, 다른 소스 파일에 있는 속성을 _수정 (modify)_ 할 수는 없습니다. 이 제약은, 여전히 해당 기능에 대한 편리한 접근을 제공하면서도, `TrackedString` 편집-추적 기능의 세부 구현을 보호합니다.

필요하다면 '획득자' 와 '설정자' 둘 다에 대해 '명시적인 접근 수준' 을 할당할 수 있다는 것을 기억하기 바랍니다. 아래 예제는 '공용 (public)' 이라는 명시적인 접근 수준을 가지는 `TrackedString` 구조체 버전을 보여줍니다. 그럼으로써 (`numberOfEdits` 속성을 포함한) 구조체 멤버들은 기본적으로 '내부 (internal) 접근 수준' 을 가집니다.[^internal-by-default] '`public`' 과 '`private(set)` 접근-수준 수정자' 를 조합[^combining-public-private-set]함으로써, 구조체에 있는 `numberOfEdits` 속성의 '획득자' 는 '공용 (public)' 으로, 속성의 '설정자' 는 '개인 전용 (private)' 으로 만들 수 있습니다:

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

'사용자 정의 초기자' 는 초기화하는 타입보다 더 낮거나 같은 접근 수준을 할당할 수 있습니다. 단 하나의 예외는 ([Required Initializers (필수 초기자)]({% post_url 2016-01-23-Initialization %}#required-initializers-필수-초기자) 에서 정의한) '필수 초기자' 입니다. '필수 초기자' 는 반드시 자신이 속한 클래스와 똑같은 접근 수준을 가져야 합니다.

함수 매개 변수와 메소드 매개 변수에서 처럼, 초기자의 매개 변수 타입은 초기자 자신의 접근 수준보다 더 '개인 전용 (private)' 일 수 없습니다.

#### Default Initializers (기본 초기자)

[Default Initializers (기본 초기자)]({% post_url 2016-01-23-Initialization %}#default-initializers-기본-초기자) 에서 설명한 것처럼, 스위프트는 모든 속성에 대한 '기본 값' 을 제공하면서 스스로는 단 하나의 초기자도 제공하지 않는 어떤 구조체나 '기초 클래스' 에든 _기본 초기자 (default initializer)_ 를 제공합니다.

'기본 초기자' 는, 해당 타입을 `public` 으로 정의하지 않는 한, 자신이 초기화하는 타입과 똑같은 접근 수준을 가집니다. `public` 으로 정의한 타입은, '기본 초기자' 를 '내부 (internal)' 라고 고려합니다. 다른 모듈에서 사용할 때 '공용 (public) 타입' 을 '인자-없는 초기자' 로 초기화 가능하게 만들고 싶으면, 타입 정의에서 '공용인 인자-없는 초기자' 를 반드시 직접 명시적으로 제공해야 합니다.[^public-no-argument]

#### Default Memberwise Initializers for Structure Types (구조체 타입을 위한 기본 멤버 초기자)

구조체 타입을 위한 '기본 멤버 초기자' 는 구조체의 어떤 저장 속성이든 '개인 전용 (private)' 이면 '개인 전용' 이라고 고려합니다. 마찬가지로, 구조체의 어떤 저장 속성이든 '파일 전용 (file private)' 이면, 초기자는 '파일 전용' 입니다. 그 외의 경우, 초기자는 '내부 (internal)' 라는 접근 수준을 가집니다.

위의 '기본 초기자' 에서 처럼, 다른 모듈에서 사용할 때 '공용 (public) 구조체 타입' 을 '멤버 초기자' 로 초기화 가능하게 만들고 싶으면, 타입 정의에서 '공용 (public) 멤버 초기자' 를 반드시 직접 제공해야 합니다.

### Protocols (프로토콜)

'프로토콜 타입' 에 '명시적인 접근 수준' 을 할당하고 싶으면, 프로토콜을 정의하는 시점에 하도록 합니다. 이는 정해진 접근 상황일 때만 '채택 (adopted)' 할 수 있는 프로토콜을 생성할 수 있게 해줍니다.

프로토콜 정의에 있는 각 '필수 조건' 의 접근 수준은 자동으로 프로토콜과 똑같은 접근 수준으로 설정됩니다. 프로토콜의 '필수 조건' 은 자신이 지원하는 프로토콜과 다른 접근 수준으로 설정할 수 없습니다. 이는 프로토콜을 채택하는 어떤 타입에서든 프로토콜의 모든 '필수 조건' 을 볼 수 있도록 보장합니다.

> '공용 (public) 프로토콜' 을 정의하면, 프로토콜의 '필수 조건' 은 해당 '필수 조건' 을 '공용 접근 수준' 으로 구현할 것을 요구합니다. 이런 작동 방식은, '공용 타입 정의' 가 타입의 멤버에 대한 '내부 (internal) 접근 수준' 을 의미하는, 다른 타입들과는 다릅니다.

#### Protocol Inheritance (프로토콜 상속)

기존 프로토콜을 상속하여 새로운 프로토콜을 정의할 경우, 새 프로토콜은 자신이 상속한 프로토콜과 똑같은 접근 수준을 최대로 가질 수 있습니다.[^at-most-the-same] 예를 들어, '내부 (internal) 프로토콜' 을 상속하여 '공용 (public) 프로토콜' 을 작성할 수 없습니다.

#### Protocol Conformance (프로토콜 준수성)

타입은 타입 자신보다 더 낮은 접근 수준을 가진 프로토콜을 준수할 수 있습니다. 예를 들어, 다른 모듈에서 사용할 수 있지만, '내부 (internal) 프로토콜' 에 대한 자신의 '준수성 (conformance)' 은 '내부 프로토콜' 을 정의한 모듈 안에서만 사용할 수 있는, '공용 (public) 타입' 을 정의할 수 있습니다.

타입이 특별한 프로토콜을 준수하는 상황에서는 타입의 접근 수준과 프로토콜의 접근 수준 사이의 '최소값 (minimum)'[^the-minimum] 입니다. 예를 들어, 타입은 '공용 (public)' 이지만, 준수하는 프로토콜이 '내부 (internal)' 라면, 해당 프로토콜에 대한 타입의 준수성도 '내부 (internal)' 입니다.

프로토콜을 준수하기 위해 타입을 작성하거나 확장할 때는, 각 '프로토콜 필수 조건' 에 대한 타입의 구현이 적어도 해당 프로토콜에 대한 타입의 '준수성' 과 똑같은 접근 수준을 가지도록 반드시 보장해야 합니다. 예를 들어, '공용 타입' 이 '내부 프로토콜' 을 준수한다면, 각 '프로토콜 필수 조건' 에 대한 타입의 구현은 적어도 반드시 '내부 (internal)' 여야 합니다.

> 오브젝티브-C 처럼, 스위프트에서의, '프로토콜 준수성' 은 '전역' 입니다-똑같은 프로그램 안에서 타입이 서로 다른 두 가지 방식으로 프로토콜을 준수하는 것은 불가능합니다.

### Extensions (익스텐션)

클래스, 구조체, 또는 열거체는 클래스, 구조체, 또는 열거체가 사용 가능한 어떤 접근 상황에서든 '확장 (extend)' 할 수 있습니다. '익스텐션' 에 추가한 어떤 타입 멤버든 확장 중인 원본 타입에서 선언한 타입 멤버와 똑같은 '기본 접근 수준' 을 가집니다. '공용 (public)' 이나 '내부 (internal) 타입' 을 확장하면, 새로 추가한 어떤 타입 멤버든 '내부' 라는 '기본 접근 수준' 을 가집니다. '파일-전용 (file-private) 타입' 을 확장하면, 새로 추가한 어떤 타입 멤버든 '파일 전용' 이라는 '기본 접근 수준' 을 가집니다. '개인 전용 (private) 타입' 을 확장하면, 새로 추가한 어떤 타입 멤버든 '개인 전용' 이라는 '기본 접근 수준' 을 가집니다.

대안으로, '익스텐션' 에서 정의한 모든 멤버에 '새로운 기본 접근 수준' 을 설정하기 위해 '익스텐션' 을 (예를 들어, `private` 같은) '명시적인 접근-수준 수정자' 로 표시할 수 있습니다. 이 새 '기본 값' 은 개별 타입 멤버의 '익스텐션' 에서 여전히 '재정의 (overridden)' 할 수 있습니다.

해당 '익스텐션' 이 '프로토콜 준수성' 을 추가하기 위한 것이라면 '익스텐션' 에서 '명시적인 접근-수준 수정자' 를 제공할 수 없습니다. 그 대신, 프로토콜 자신의 접근 수준을 사용하여 '익스텐션' 안의 각 '프로토콜 필수 조건 구현' 에 대한 '기본 접근 수준' 을 제공합니다.

### Private Members in Extensions ('익스텐션' 에 있는 '개인 전용 멤버')

자신이 확장하는 클래스, 구조체, 또는 열거체와 동일한 파일에 있는 '익스텐션' 은 마치 '익스텐션' 코드가 원본 타입 선언에서 작성된 것처럼 동작합니다. 그 결과, 다음을 할 수 있습니다:

* 원본 선언에서 '개인 전용 (private) 멤버' 를 선언하고, 동일한 파일에 있는 '익스텐션' 에서 해당 멤버에 접근합니다.
* 한 '익스텐션' 에서 '개인 전용 (private) 멤버' 를 선언하고, 동일한 파일에 있는 또 다른 '익스텐션' 에서 해당 멤버에 접근합니다.
* '익스텐션' 에서 '개인 전용 (private) 멤버' 를 선언하고, 동일한 파일에 있는 원본 선언에서 해당 멤버에 접근합니다.

이런 작동 방식은, 타입이 '개인 전용 (private) 개체' 를 가지는 것과 상관없이, 코드를 정돈하기 위한 방법으로 '익스텐션' 을 사용할 수 있다는 의미입니다. 예를 들어, 다음 같이 간단한 프로토콜이 주어졌습니다:

```swift
protocol SomeProtocol {
  func doSomething()
}
```

'프로토콜 준수성' 을 추가히기 위해, 다음 같이, '익스텐션' 을 사용할 수 있습니다[^protocol-conformance-extension]:

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

'일반화 타입' 또는 '일반화 함수' 에 대한 접근 수준은 '일반화 타입이나 함수 자신의 접근 수준' 과 '타입 매개 변수에 대한 어떤 타입 구속 조건의 접근 수준' 중에서의 '최소값' 입니다.

### Type Aliases (타입 별명)

자신이 정의한 어떤 '타입 별명 (type aliases)' 이든 '접근 수준' 용으로는 서로 별개의 타입인 것처럼 취급합니다. '타입 별명' 은 별명을 붙인 타입의 접근 수준보다 낮거나 같은 접근 수준을 가질 수 있습니다. 예를 들어, '개인 전용 (private) 타입 별명' 은 '개인 전용 (private)', '파일-전용 (file-private)', '내부 (internal)', '공용 (public)', 또는 '공개 (open) 타입' 에 별명을 붙일 수 있지만, '공용 (public) 타입 별명' 은 '내부 (internal)', '파일-전용 (file-private)', 또는 '개인 전용 (private) 타입' 에 별명을 붙일 수 없습니다.

> 이 규칙은 '프로토콜 준수성' 을 만족하기 위해 사용하는 '결합 타입' 에 대한 '타입 별명' 에도 적용됩니다.

### 다음 장

[Advanced Operators (고급 연산자) > ]({% post_url 2020-05-11-Advanced-Operators %})

### 참고 자료

[^Access-Control]: 이 글에 대한 원문은 [Access Control](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html) 에서 확인할 수 있습니다.

[^API]: API 는 'Application Programming Interface' 의 약자입니다.

[^the-most-restrictive]: [Access Levels (접근 수준)](#access-levels-접근-수준) 에서 설명한 것처럼, '가장 제약한 접근 수준' 은 '가장 낮은 접근 수준' 입니다. 스위프트의 접근 수준을 높은 순서로 나열하면 '공개 (open)' >= '공용 (public)' > '내부 (internal)' > '파일-전용 (file-private)' > '개인 전용 (private)' 입니다.

[^function-access-level]: 이 말은, 함수의 접근 수준이 '개인 전용 (private)' 이어야 할 때는, 반드시 함수 정의에 `private` 을 붙여야 한다는 의미입니다. '함수가 (자동으로) 계산한 접근 수준' 과 '기본적인 상황' 이 일치해야 한다는 것은, 이어지는 예제에서 설명하고 있습니다. '함수가 계산한 접근 수준 (`private`)' 과 '기본적인 상황 (`internal`)' 이 일치하지 않으면, 컴파일이 안됩니다.

[^raw-values-and-associated-values]: 스위프트의 열거체는 각 'case 값' 마다 '원시 값 (raw value)' 과 '결합 값 (associated value)' 이라는 별도의 값을 가집니다. `enum Direction: Int { case east = 0, west }` 라고 하면 `east` 는 'case 값' 이고,  `east` 의 '원시 값' 은 `0` 입니다. '결합 값' 은 'case 값' 의 각 인스턴스마다 할당하는 값을 말하는데, `enum Direction { case east(String), west(String) }; let east = Direction.east("Sun rise")` 라고 하면, `east` 의 'case 값' 은 `"Sun rise"` 가 됩니다.

[^higher]: [Access Levels (접근 수준)](#access-levels-접근-수준) 에서 설명한 것처럼, 스위프트의 접근 수준은 '공개 (open)' 가 가장 높고, '개인 전용 (private)' 이 가장 낮습니다.

[^subclassing]: 여기서 알 수 있는 것은 '클래스의 접근 수준' 과 '클래스 멤버의 접근 수준' 은 서로 독립적으로 작동한다는 것입니다. 

[^property-observer]: '속성 관찰자 (property observers)' 에 대한 더 자세한 내용은, [Properties (속성)]({% post_url 2020-05-30-Properties %}) 장에 있는 [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 부분을 참고하기 바랍니다. 

[^more-public]: '더 공개 (public) 일 수 없다' 는 것은, '더 높은 접근 수준을 가질 수 없다' 는 의미입니다. 일단 어떤 속성을 '공개 (public)' 하고 싶으면 반드시 해당 속성을 가진 타입도 '공개 (public)' 해야 한다고 이해할 수 있습니다. '더 높은 접근 수준' 이라는 단어 대신 '공개 (public)' 라는 단어를 선택한 것에도 의미가 있다고 생각됩니다.

[^internal-by-default]: [Custom Types (사용자 정의 타입)](#custom-types-사용자-정의-타입) 에서 설명한 것처럼, 사용자 정의 클래스를 '공용 (public) 접근 수준' 으로 정의하면 멤버의 기본 접근 수준은 '내부 (internal)' 가 됩니다.

[^combining-public-private-set]: 본문에서 처럼, `public private(set)` 이라는 수정자도 가능합니다. 이는 '획득자' 와 '설정자' 를 가지는 '속성' 에만 유효한 것으로 추측됩니다.

[^public-no-argument]: 바로 위의 `TrackedString` 예제에 있는 `public init() {}` 이 바로 이에 대한 예입니다. 

[^at-most-the-same]: '하위 프로토콜' 은 '상위 프로토콜' 보다 더 높은 접근 수준을 가질 수 없다는 의미입니다.

[^the-minimum]: 이 접근 수준이 서로 다를 경우에는 '가장 낮은 접근 수준' 을 가진다는 의미입니다.

[^protocol-conformance-extension]: 예제처럼 하면, `SomeStruct` 를 '원본 구현' 부분과 `SomeProtocol` 을 준수하는 구현 부분으로 정돈할 수 있습니다. 