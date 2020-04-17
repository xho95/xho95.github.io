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

* _open access (열린 접근)_ 과 _public access (공공 접근)_ 은 해당 엔티티를 이것이 정의된 모듈의 어떤 소스 파일에서도 사용할 수 있도록 하며, 또한 이 정의된 모듈을 불러온 또다른 모듈의 소스 파일에서도 사용할 수 있도록 합니다. 'open 이나 public 접근' 은 일반적으로 프레임웍의 공용 인터페이스를 지정할 때 사용합니다. 'open 접근' 과 'public 접근' 의 차이점은 아래에 따로 설명합니다.
* _internal access (내부 접근)_ 은 해당 엔티티를 이것이 정의된 모듈의 어떤 소스 파일에서도 사용할 수 있도록 하지만, 그 모듈 외부에 있다면 어떤 소스 파일에서도 접근하지 못하도록 합니다. 'internal 접근' 은 일반적으로 앱이나 프레임웍의 내부 구조를 정의할 때 사용합니다.
* _file-private access (파일-개인 접근)_ 은 엔티티의 사용을 자신이 정의된 소스 파일로만 제한합니다. 'file-private 접근' 을 사용하면 특정 기능의 세부 구현을 숨기면서 그 세부 정보를 한 파일 내에서만 사용할 수 있도록 합니다.
* _private access (개인 접근)_ 은 엔티티의 사용을 그를 둘러싼 '선언 (declaration)' 과, 동일 파일 내의 그 선언의 '확장 (extensions)' 으로만 제한합니다. 'private 접근' 을 사용하면 특정 기능의 세부 구현을 숨기면서 그 세부 정보를 단일 선언 내에서만 사용할 수 있도록 합니다.

'open (열린) 접근' 은 가장 높은 (제한이 가장 적은; least restrictive) 접근 수준이며 'private 접근' 은 가장 낮은 (제한이 가장 많은; most restrictive) 접근 수준입니다.

'open (열린) 접근' 은 클래스와 클래스 멤버에만 적용되어, 모듈 외부의 코드에서 하위 클래스를 만들고 '재정의 (override)' 를 할 수 있게 한다는 점이 'public access (공공 접근)' 과 다른 점으로, 이는 아래의 [Subclassing (하위 클래스)](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html#ID16) 에서 설명합니다. 클래스를 'open' 으로 명시적으로 표시한다는 것은 그 클래스를 상위 클래스로 사용하는 다른 모듈의 코드에 대한 영향을 이미 고려했으며, 그에 따라 클래스 코드를 설계했음을 지시하는 것입니다.

#### Guiding Principle of Access Levels (접근 수준의 원칙)

#### Default Access Levels (기본 접근 수준)

#### Access Levels for Single-Target Apps (단일-대상 앱을 위한 접근 수준)

#### Access Levels for Frameworks (프레임웍을 위한 접근 수준)

#### Access Levels for Unit Test Targets (단위 테스트 대상을 위한 접근 수준)

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
