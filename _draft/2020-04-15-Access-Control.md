---
layout: post
comments: true
title:  "Swift 5.2: Access Control (접근 제어)"
date:   2020-04-15 10:00:00 +0900
categories: Swift Language Grammar Access Control
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Access Control](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html) 부분[^Access-Control]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Access Control (접근 제어)

_접근 제어 (Access Control)_ 는 다른 소스 파일이나 모듈에 있는 코드가 자신의 코드의 특정 부분에 접근하는 것을 제한합니다. 이 특징은 코드의 세부 구현을 숨기면서, 이 코드에 접근하고 사용할 수 있는 바람직한 인터페이스를 지정하도록 합니다.

특정한 접근 수준을 할당하는 것은 개별 타입 (클래스, 구조체, 및 열거체) 뿐만 아니라, 해당 타입에 속해 있는 속성, 메소드, 초기자, 그리고 첨자 연산에도 가능합니다. 프토토콜은 전역 상수, 전역 변수, 및 전역 함수와 같이 특정 영역 내로 제한될 수 있습니다.

접근 제어의 수준을 다양하게 제공하는 것 외에도, 스위프트는 일반적인 시나리오에 대한 기본 접근 수준을 제공하여 접근 제어 수준을 명시적으로 지정해야할 필요를 줄여주기도 합니다. 실제로, 단일-대상의 앱을 작성하는 경우라면, 접근 제어 수준을 명시적으로 지정할 필요가 전혀 없을 수도 있습니다.

> 접근 제어를 적용할 수 있는 코드의 다양한 부분 (속성, 타입, 함수, 등등) 을 이제부터, 그냥 간단하게, '엔티티 (entities; 독립체)' 라고 부르도록 합니다.

### Modules and Source Files (모듈과 소스 파일)

스위프트의 접근 제어 모델은 모듈과 소스 파일의 개념을 기반으로 한 것입니다.

_모듈 (module)_ 은 단일한 코드 배포 단위입니다-단일 단위 형태로 제작되어 출하되는 프레임웍이나 응용 프로그램을 말하는 것으로 스위프트에서는 `import` 키워드로 다른 모듈에서 불러올 수도 있습니다.

Xcode 에 있는 ('앱 번들' 이나 '프레임웍' 같은) 각각의 '빌드 대상 (build target)' 은 스위프트에서 별도의 모듈인 것처럼 처리합니다. 앱 코드에 있는 각 부분들을 독립된 프레임웍으로 묶으면-아마도 이 코드를 은닉해서 여러 응용 프로그램에서 재사용하려고 할 수 있습니다-그 프레임웍 안에서 정의한 모든 것들은 별도의 모듈의 일부인 것처럼, 앱에서 불러오고 사용되거나 다른 프레임웍에서 사용됩니다.

_소스 파일 (source file)_ 은 모듈 내에 있는 단일한 스위프트 소스 코드 파일 (실제로는, 앱이나 프레임웍에 있는 단일 파일) 입니다. 별도의 소스 파일마다 각각의 타입을 정의하는 것이 일반적이긴 하지만, 단일한 소스 파일도 여러 개의 타입, 함수, 기타 등등을 가질 수 있습니다.

### Access Levels (접근 수준)

스위프트는 코드 내의 '엔티티 (entities)' 를 위하여 서로 다른 다섯 가지의 _접근 수준 (access levels)_ 을 제공합니다. 이 접근 수준은 '엔티티' 가 정의된 소스 파일과 관련되어 있으며, 또 소스 파일이 속해 있는 모듈과도 관련되어 있습니다.

* _open access (공개 접근)_ 과 _public access (공용 접근)_ 은 해당 엔티티를 이것이 정의된 모듈의 어떤 소스 파일에서도 사용할 수 있도록 하며, 또한 이 정의된 모듈을 불러온 또다른 모듈의 소스 파일에서도 사용할 수 있도록 합니다. 'open 이나 public 접근' 은 일반적으로 프레임웍의 공용 인터페이스를 지정할 때 사용합니다. 'open 접근' 과 'public 접근' 의 차이점은 아래에 따로 설명합니다.
* _internal access (내부 접근)_ 은 해당 엔티티를 이것이 정의된 모듈의 어떤 소스 파일에서도 사용할 수 있도록 하지만, 그 모듈 외부에 있다면 어떤 소스 파일에서도 접근하지 못하도록 합니다. 'internal 접근' 은 일반적으로 앱이나 프레임웍의 내부 구조를 정의할 때 사용합니다.
* _file-private access (파일-개인 접근)_ 은 엔티티의 사용을 자신이 정의된 소스 파일로만 제한합니다. 'file-private 접근' 을 사용하면 특정 기능의 세부 구현을 숨기면서 그 세부 정보를 한 파일 내에서만 사용할 수 있도록 합니다.
* _private access (개인 접근)_ 은 엔티티의 사용을 그를 둘러싼 '선언 (declaration)' 과, 동일 파일 내의 그 선언의 '확장 (extensions)' 으로만 제한합니다. 'private 접근' 을 사용하면 특정 기능의 세부 구현을 숨기면서 그 세부 정보를 단일 선언 내에서만 사용할 수 있도록 합니다.

'open (공개) 접근' 은 가장 높은 (가장 적게 제한된; least restrictive) 접근 수준이며 'private 접근' 은 가장 낮은 (가장 많이 제한된; most restrictive) 접근 수준입니다.

'open (공개) 접근' 은 클래스와 클래스 멤버에만 적용되어, 모듈 외부의 코드에서 하위 클래스를 만들고 '재정의 (override)' 를 할 수 있게 한다는 점이 'public access (공용 접근)' 과 다른 점으로, 이는 아래의 [Subclassing (하위 클래스)](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html#ID16) 에서 설명합니다. 클래스를 'open' 으로 명시적으로 표시한다는 것은 그 클래스를 상위 클래스로 사용하는 다른 모듈의 코드에 대한 영향을 이미 고려했으며, 그에 따라 클래스 코드를 설계했음을 지시하는 것입니다.

#### Guiding Principle of Access Levels (접근 수준에 대한 지침)

스위프트의 접근 수준에 적용되는 '전반적인 지침 (overall guiding principle)' 은 다음과 같습니다: _어떤 엔티티도 더 낮은 (더 제한된; more restrictive) 접근 수준을 갖고 있는 엔티티로 정의될 수는 없습니다._

예를 들면 다음과 같습니다:

* 'public variable (공용 변수)' 는 'internal (내부)', 'file-private (파일-개인)', 또는 'private (개인)' 타입을 가지는 것으로 정의할 수 없는데, 이는 공용 변수가 사용되는 모든 곳마다 그 타입을 사용할 수 있는 것은 아니기 때문입니다.
* '함수' 는 그의 매개 변수와 반환 값보다 더 높은 접근 수준을 가질 수 없는데, 이는 함수를 사용할 때 주위 코드에서 그 성분 요소를 사용할 수 없는 상황도 있을 수 있기 때문입니다.

언어의 서로 다른 부분들에 대해서 이 지침이 의미하는 바는 아래에서 자세히 다루도록 합니다:

#### Default Access Levels (기본 접근 수준)

코드에 있는 모든 엔티티는 (이 장 뒤에 설명할, 몇몇 특정한 예외를 제외한다면) 접근 수준을 직접 명시해서 지정하지 않을 경우 기본 접근 수준이 'internal (내부)' 가 됩니다. 그 결과, 대부분의 경우에 코드에서 접근 수준을 명시적으로 지정할 필요가 없습니다.

#### Access Levels for Single-Target Apps (단일-대상 앱을 위한 접근 수준)

단순한 '단일-대상 앱 (single-target app)' 을 작성할 때는, 앱 코드는 일반적으로 앱 내부로만 한정되므로 앱 모듈 외부에서 사용할 수 있게끔 만들 필요가 없습니다. 기본 접근 수준은 이러한 요구 사항에 이미 해당됩니다. 그러므로, 접근 수준을 따로 지정할 필요가 없는 것입니다. 하지만, 코드 일부를 'file private (파일 개인)' 이나 'private (개인)' 으로 표시하면 앱 모듈 내의 다른 코드로부터 세부 구현 정보를 숨길 수도 있습니다.

#### Access Levels for Frameworks (프레임웍을 위한 접근 수준)

프레임웍을 개발할 때는, 그 프레임웍의 공용-목적의 인터페이스를 'open (공개)' 나 '공용 (public)' 으로 표시해서 다른 모듈, 가령 그 프레임웍을 불러온 앱 같은 것 등에서 볼 수 있고 접근할 수 있도록 해야합니다. 이러한 공용-목적의 인터페이스를 그 프레임웍에 대한 응용 프로그래밍 인터페이스 (또는 API; Application Programming Interface) 라고 합니다.

> 프레임웍의 어떤 'internal (내부)' 세부 구현이라도 기본 접근 수준인 'internal (내부)' 를 그대로 사용할 수도 있고, 프레임웍의 다른 일부 'internal (내부)' 코드로부터 숨길 목적으로 'private (개인)' 이나 'file private (파일 개인)' 으로 표시할 수도 있습니다. 엔티티를 'open (공개)' 나 'public (공용)' 으로 표시하는 것은 오직 그것이 프레임웍의 'API' 일부가 될 경우에만 하도록 합니다.

#### Access Levels for Unit Test Targets (단위 테스트 대상을 위한 접근 수준)

앱을 작성할 때 단위 테스트를 하려면, 테스트하려는 모듈에서 앱에 있는 코드를 사용할 수 있게 만들어야 합니다. 기본적으로는, 'open (공개)' 나 'public (공용)' 로 표시한 엔티티만 다른 모듈에서 접근할 수 있습니다. 하지만, 단위 테스트 대상이 어떤 'internal (내부)' 엔티티에도 접근할 수 있도록, 제품 모듈에서 선언을 불러오면서 `@testable` '특성 (attribute)' 을 표시한 후 컴파일하면, 이제 제품 모듈에서 테스트를 할 수 있게 됩니다.

### Access Control Syntax (접근 제어 구문 표현)

### Custom Types (사용자 정의 타입)

#### Tuple Types (튜플 타입)

#### Function Types (함수 타입)

#### Enumeration Types (열거체 타입)

**Raw Values and Associated Values ('원시 값' 과 '관련 값')**

#### Nested Types (품어진 타입)

### Subclassing (하위 클래스)

### Constants, Variables, Properties, and Subscripts (상수, 변수, 속성, 및 첨자 연산)

#### Getters and Setters ('게터' 와 '세터')

### Initializers (초기자)

#### Default Initializers (기본 초기자)

#### Default Memberwise Initializers for Structure Types (구조체 타입을 위한 기본 멤버 초기자)

### Protocols (프로토콜; 규약)

#### Protocol Inheritance (프로토콜 상속)

#### Protocol Conformance (프로토콜 준수)

### Extensions (확장)

### Private Members in Extensions (확장 내의 비공개 멤버)

### Generics (일반화-된 타입)

### Type Aliases (타입 별명)

### 참고 자료

[^Access-Control]: 이 글에 대한 원문은 [Access Control](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html) 에서 확인할 수 있습니다.
