---
layout: post
comments: true
title:  "Swift 5.3: Declarations (선언)"
date:   2020-08-15 11:30:00 +0900
categories: Swift Language Grammar Declaration
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Declarations](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html) 부분[^Declarations]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## Declarations (선언)

### Top-Level Code (최상위-수준 코드)

스위프트 소스 파일에 있는 '최상위-수준 코드 (top-level code)' 는 '0' 개 이상의 구문, 선언, 그리고 표현식으로 구성됩니다. 기본적으로, 소스 파일의 최상위-수준에서 선언한 변수, 상수, 및 그외 알려진 선언들은 같은 모듈에 있는 모든 소스 파일의 코드에서 접근 가능합니다. 이런 기본 작동 방식을 재정의하려면, [Access Control Levels (접근 제어 수준)](#access-control-levels-접근-제어-수준) 에서 설명한 것처럼, 선언을 '접근-수준 수정자' 로 표시하면 됩니다.

'최상위-수준 코드' 에는 두 가지 종류가 있습니다: '최상위-수준 선언 (top-level declarations)' 과 '실행 가능한 최상위-수준 코드 (excutable top-level code)' 가 그것입니다. '최상위-수준 선언' 은 선언 만으로 구성되며, 모든 스위프트 소스 파일에서 허용됩니다. '실행 가능한 최상위-수준 코드' 는, 선언뿐만 아니라, 구문과 표현식도 가지고 있으며, 프로그램에 대한 최상위-수준 진입점으로만 허용됩니다.

'실행 파일 (executable)' 을 만들기 위해 컴파일하는 스위프트 코드는, 코드가 어떻게 파일과 모듈로 구성되는 지에 상관없이, 최상위-수준 진입점을 표시하는 다음의 접근 방법 중에서 최대 한 개만을 가질 수 있습니다: `main` 특성, `NSApplicationMain` 특성, `UIApplicationMain` 특성, `main.swift` 파일, 아니면 '최상위-수준 실행 가능한 코드' 를 가지고 있는 파일.

> GRAMMAR OF A TOP-LEVEL DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/LexicalStructure.html#ID411)

### Code Blocks

### Import Declaration

### Constant Declaration

### Variable Declaration

#### Stored Variables and Stored Variable Properties

#### Computed Variables and Computed Properties

#### Stored Variable Observers and Property Observers

#### Type Variable Properties

### Type Alias Delcaration

### Function Declaration

#### Parameter Names

#### In-Out Parameters

#### Special Kinds Paramters

#### Special Kinds Methods

#### Methods with Special Names

#### Throwing Functions and Nethods

#### Rethrowing Functions and Methods

#### Functions that Never return

### Enumeration Declaration

#### Enumerations with Cases of Any Type

**Enumerations with Indirection**

#### Enumerations with Cases of a Raw-Value Type

#### Accessing Enumeration Cases

### Structure Declaration

### Class Declaration

### Protocol Declaration

#### Protocol Property Declaration

#### Protocol Method Declaration

#### Protocol Initializer Declaration

#### Protocol Subscript Declaration

#### Protocol Associated Type Declaration

### Initializer Declaration

#### Failable Initializers

### Deinitializer Declaration

### Extension Declaration

#### Conditional Conformance

**Overridden Requirements Aren't Used in Some Generic Contexts**

#### Protocol Conformance Must Not Be Redundant

**Resolving Explicit Redundancy**

**Resolving Implicit Redundancy**

### Subscipt Declaration

#### Type Subscript Declarations

### Operator Declaration

### Precedence Group Declaration

### Declaration Modifiers

#### Access Control Levels (접근 제어 수준)

### 참고 자료

[^Declarations]: 원문은 [Declarations](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html) 에서 확인할 수 있습니다.
