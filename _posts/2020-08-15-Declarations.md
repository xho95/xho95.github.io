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

_선언 (declaration)_ 은 프로그램에 새로운 이름 또는 구조물을 도입합니다. 예를 들어, 선언을 사용하여 함수와 메소드를 도입하고, 변수와 상수를 도입하며, 열거체, 구조체, 클래스, 및 프로토콜 타입을 정의합니다. 또한 선언을 사용하면 기존 '이름 있는 타입 (named type)' 의 작동 방식을 확장할 수도 있고 다른 곳에서 선언한 '기호 (symbols)' 를 프로그램으로 불러 올 수도 있습니다.

스위프트에서는, 선언과 동시에 구현 또는 초기화 된다라는 점에서 대부분의 '선언 (declarations)' 은 또한 '정의 (definitions)' 이기도 합니다. 즉, 프로토콜은 그 멤버를 구현하지 않기 때문에, 대부분의 프로토콜 멤버는 선언이기만 합니다. 편의상 그리고 스위프트에서는 그 구별이 그다지 중요하지 않기 때문에, _선언 (declarations)_ 이라는 용어로 선언과 정의를 모두 다룹니다.

> GRAMMAR OF A DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html)

### Top-Level Code (최상위-수준 코드)

스위프트 소스 파일에 있는 '최상위-수준 코드 (top-level code)' 는 '0' 개 이상의 구문, 선언, 그리고 표현식으로 구성됩니다. 기본적으로, 소스 파일의 최상위-수준에서 선언한 변수, 상수, 및 그외 '이름 있는 선언 (named declarations)' 들은 같은 모듈에 있는 모든 소스 파일의 코드에서 접근 가능합니다. 이런 기본 작동 방식을 재정의하려면, [Access Control Levels (접근 제어 수준)](#access-control-levels-접근-제어-수준) 에서 설명한 것처럼, 선언을 '접근-수준 수정자' 로 표시하면 됩니다.

'최상위-수준 코드' 에는 두 가지 종류가 있습니다: '최상위-수준 선언 (top-level declarations)' 과 '실행 가능한 최상위-수준 코드 (excutable top-level code)' 가 그것입니다. '최상위-수준 선언' 은 선언 만으로 구성되며, 모든 스위프트 소스 파일에서 허용됩니다. '실행 가능한 최상위-수준 코드' 는, 선언뿐만 아니라, 구문과 표현식도 가지고 있으며, 프로그램에 대한 최상위-수준 진입점으로만 허용됩니다.

'실행 파일 (executable)' 을 만들기 위해 컴파일하는 스위프트 코드는, 코드가 어떻게 파일과 모듈로 구성되는 지에 상관없이, 최상위-수준 진입점을 표시하는 다음의 접근 방법 중에서 최대 한 개만을 가질 수 있습니다: `main` 특성, `NSApplicationMain` 특성, `UIApplicationMain` 특성, `main.swift` 파일, 아니면 '최상위-수준 실행 가능한 코드' 를 가지고 있는 파일.

> GRAMMAR OF A TOP-LEVEL DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID352)

### Code Blocks

### Import Declaration

### Constant Declaration

### Variable Declaration (변수 선언)

_변수 선언 (variable declaration)_ 은 프로그램에 '이름 있는 변수 값 (variable named value)' 을 프로그램에 도입하는 것으로 `var` 키워드를 사용하여 선언합니다.

변수 선언은, 저장 변수 및 속성과 계산 변수 및 속성, 저장 변수 관찰자 및 저장 속성 관찰자, 그리고 정적 변수 속성을 포함하여, 서로 다른 종류의 이름 있는, 변경 가능한 값을 선언하는 여러 가지 양식을 가지고 있습니다. 어떤 양식을 사용하는게 적절한가 하는 것은 변수를 선언하는 영역이 어디인지 그리고 선언하고자 하는 변수의 종류가 무엇인지에 달려 있습니다.

> [Protocol Property Declaration (프로토콜 속성 선언)](#protocol-property-declaration-프로토콜-속성-선언) 에서 설명하는 것처럼, 프로토콜 선언 상황에서도 속성을 선언할 수 있습니다.

[Overriding (재정의하기)]({% post_url 2020-03-31-Inheritance %}#overriding-재정의하기) 에서 설명한 것처럼, 하위 클래스의 속성 선언을 `override` 선언 수정자로 표시하면 하위 클래스에서 속성을 재정의할 수 있습니다.

#### Stored Variables and Stored Variable Properties

#### Computed Variables and Computed Properties

#### Stored Variable Observers and Property Observers (저장 변수 관찰자와 속성 관찰자)

저장 변수 또는 저장 속성은 `willSet` 및 `didSet` 관찰자로 선언할 수도 있습니다. 관찰자로 선언된 저장 변수 및 저장 속성은 다음의 양식을 가집니다:

```swift
  var variable name: type = expression {
    willSet(setter name) {
      statements
    }
    didSet(setter name) {
      statements
    }
  }
```

이런 양식의 변수 선언은 전역 범위나, 함수의 지역 범위, 또는 클래스 및 구조체 선언에서 정의합니다. 이 양식의 변수 선언을 전역 범위나 함수의 지역 범위에서 선언할 때는, 이 관찰자를 _저장 변수 관찰자 (stored variable observers)_ 라고 합니다. 클래스나 구조체 선언에서 선언할 때는, 이 관찰자를 _속성 관찰자 (property observers)_ 라고 합니다.

속성 관찰자는 어떤 저장 속성에도 추가할 수 있습니다. [Overriding Property Observers (속성 관찰자 재정의하기)]({% post_url 2020-03-31-Inheritance %}#overriding-property-observers-속성-관찰자-재정의하기) 에서 설명한 것처럼, 하위 클래스에서 속성을 재정의하면 상속받은 어떤 속성에도 (저장 속성인지 계산 속성인지에 상관없이) 속성 관찰자를 추가할 수 있습니다.

초기자 _표현식 (expression)_[^expression] 은 클래스나 구조체 선언에서는 선택 사항이지만, 다른 곳에서는 필수 입니다. _타입 (type)_ 보조 설명은 초기자 _표현식 (expression)_ 으로부터 타입을 추론할 수 있을 때는 선택 사항입니다. 이 표현식은 속성의 값을 맨 처음 읽는 순간에 평가합니다. 속성의 초기 값을 읽지 않고 덮어 쓰면, 이 표현식은 속성에 값을 맨 처음 쓰는 순간 바로 전에 평가합니다.

`willSet` 및 `didSet` 관찰자는 변수나 속성의 값을 설정할 때 관찰 (하고 적절하게 응답) 하는 방법을 제공합니다. 변수나 속성을 맨 처음 초기화 할 때는 관찰자가 호출되지 않습니다. 그 대신, 초기화 상황 이외에서 값을 설정할 때만 호출됩니다.

`willSet` 관찰자는 변수나 속성의 값을 설정하기 바로 직전에 호출됩니다. 새로운 값은 `willSet` 관찰자에 상수로써 전달되므로, `willSet` 절의 구현부에서 이를 바꿀 수 없습니다. `didSet` 관찰자는 새 값을 설정한 바로 직후 호출됩니다. `willSet` 관찰자와는 대조적으로, `didSet` 관찰자에 전달된 변수나 속성의 예전 값은 아직 접근이 필요한 경우입니다. 즉, `didSet` 관찰자 구절에서 변수나 속성에 직접 값을 할당하는 경우, 직접 할당한 새 값이 방금 `willSet` 관찰자에서 전달하고 설정한 것을 대체하게 됩니다.

`willSet` 과 `didSet` 절에 있는 _설정자 이름 (setter name)_ 및 이를 감싼 괄호는 선택 사항입니다. 설정자 이름을 제공하면, 이를 `willSet` 및 `didSet` 관찰자의 매개 변수 이름으로 사용합니다. 설정자 이름을 제공하지 않으면, `willSet` 관찰자의 기본 매개 변수 이름은 `newValue` 으 되고 `didSet` 관찰자의 기본 매개 변수 이름은 `oldValue` 이 됩니다.

`willSet` 절을 제공 할 때면 `didSet` 절은 선택 사항이 됩니다. 마찬가지로, `didSet` 절을 제공 할 때면 `willSet` 절이 선택 사항이 됩니다.

`didSet` 관찰자의 본문에서 예전 값을 참조하는 경우, 예전 값을 사용 가능하게 만들기 위해, 관찰자 이전에 '획득자 (getter)' 가 호출됩니다. 다른 경우라면, 상위 클래스의 '획득자' 를 호출하지 않고 새 값을 저장합니다. 아래 예제는 상위 클래스에서 정의하고 하위 클래스에서 관찰자를 추가하여 재정의한 계산 속성을 보여줍니다:

```swift
class Superclass {
  private var xValue = 12
  var x: Int {
    get { print("Getter was called"); return xValue }
    set { print("Setter was called"); xValue = newValue }
  }
}

// 이 하위 클래스는 관찰자에서 oldValue 를 참조하지 않으므로,
// 상위 클래스의 획득자는 값을 출력하기 위해 한 번만 호출됩니다.
class New: Superclass {
  override var x: Int {
    didSet { print("New value \(x)") }
  }
}
let new = New()
new.x = 100
// "Setter was called" 를 출력합니다.
// "Getter was called" 를 출력합니다.
// "New value 100" 를 출력합니다.

// 이 하위 클래스는 관찰자에서 oldValue 를 참조하므로, 상위 클래스의 획득자는,
// 설정자 이전에 한 번, 그리고 값을 출력하기 위해 다시 한 번 호출됩니다.
class NewAndOld: Superclass {
  override var x: Int {
    didSet { print("Old value \(oldValue) - new value \(x)") }
  }
}
let newAndOld = NewAndOld()
newAndOld.x = 200
// "Getter was called" 를 출력합니다.
// "Setter was called" 를 출력합니다.
// "Getter was called" 를 출력합니다.
// "Old value 12 - new value 200" 를 출력합니다.
```

속성 관찰자에 대한 더 많은 정보와 이를 사용하는 방법에 대한 예제를 보려면, [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 를 참고하기 바랍니다.

#### Type Variable Properties

### Type Alias Delcaration

### Function Declaration (함수 선언)

#### Parameter Names

#### In-Out Parameters (입-출력 매개 변수)

입-출력 매개 변수는 다음 처럼 전달됩니다:

1. 함수를 호출할 때, 인자의 값을 복사합니다.
2. 함수 본문에서, 이 복사본을 수정합니다.
3. 함수를 반환할 때, 복사본의 값을 원래 인자에 할당합니다.

이러한 작동 방식을 _복사-입력 복사-출력 (copy-in copy-out)_ 또는 _값-결과에 의한 호출 (call by value result)_[^call-by-value-result] 라고 합니다. 예를 들어, 계산 속성이나 관찰자를 가진 속성을 입-출력 매개 변수로 전달하면, 함수 호출 시에는 '획득자 (getter)' 가 호출되고 함수 반환 시에는 '설정자 (setter)' 가 호출됩니다.

최적화에 따라서, 인자가 메모리에 있는 물리적 주소에 저장된 값일 때는, 함수 본문의 내부와 외부 둘 다에서 같은 메모리 위치를 사용합니다. 이런 최적화된 작동 방식을 _참조에 의한 호출 (call by reference)_ 이라고 합니다; 이는 '복사-입력 복사-출력' 모델의 필수 조건을 모두 만족하면서 복사에 따른 부담도 제거합니다. 코드를 '복사-입력 복사-출력' 으로 주어진 모델을 사용하여 작성하면, '참조에 의한 호출' 최적화에 의존하지 않으므로, 최적화를 하든 하지 않든 올바르게 작동합니다.

함수 내에서, 원본 값이 현재 영역에서 사용 가능하더라도, '입-출력 인자' 로 전달된 값에는 접근하지 않도록 합니다. 원본에 접근하는 것은 값에 대한 동시 접근이 되어, 스위프트의 '메모리 독점권 보증 (memory exclusivity gurantee)' 을 위반합니다. 같은 이유로 인하여, 같은 값을 여러 개의 입-출력 매개 변수로 전달할 수 없습니다.

메모리 안전성 및 메모리 독점권에 대한 더 자세한 정보는, [Memory Safety (메모리 안전성)]({% post_url 2020-04-07-Memory-Safety %}) 를 참고하기 바랍니다.

입-출력 매개 변수를 붙잡는 클로저나 중첩 함수는 반드시 '벗어나지 않는 (nonescaping)' 것 이어야 합니다. 입-출력 매개 변수를 변경없이 붙잡거나 아니면 다른 코드가 바꿨는지 관찰할 필요가 있는 경우, '붙잡을 목록 (capture list)' 을 사용하여 매개 변수를 명시적으로 변경 불가능하게 붙잡아야 합니다.

```swift
func someFunction(a: inout Int) -> () -> Int {
  return { [a] in return a + 1 }
}
```

입-출력 매개 변수를 붙잡아서 변경해야할 필요가 있는 경우, 함수 반환 전에 모든 변경을 마쳤다고 보장하는 다중 쓰레드 코드 처럼, 명시적인 지역 복사본을 사용하도록 합니다:

```swift
func multithreadedFunction(queue: DispatchQueue, x: inout Int) {
  // 지역 복사본을 만들고 이를 다시 수동으로 되돌려서 복사합니다.
  var localX = x
  defer { x = localX }

  // localX 에 대한 비동기 연산을 한 후, 반환 전에 기다립니다.
  queue.async { someMutatingOperation(&localX) }
  queue.sync {}
}
```

더 많은 논의와 입-출력 매개 변수에 대한 예제는, [In-Out Parameters (입-출력 매개 변수)]({% post_url 2020-06-02-Functions %}#in-out-parameters-입-출력-매개-변수) 를 참고하기 바랍니다.

#### Special Kinds Paramters

#### Special Kinds Methods

#### Methods with Special Names (특수한 이름을 가진 메소드)

#### Throwing Functions and Methods (던지는 함수 및 메소드)

에러를 던질 수 있는 함수와 메소드는 반드시 `throws` 키워드로 표시해야 합니다. 이러한 함수와 메소드를 _던지는 함수 (throwing functions)_ 및 _던지는 메소드 (throwing methods)_ 라고 합니다. 형식은 다음과 같습니다:

func `function name`(`parameters`) throws -> `return type` {
<br />
    `statements`
<br />
}

던지는 함수 또는 던지는 메소드에 대한 호출은 반드시 `try` 나 `try!` 표현식 (즉, `try` 나 `try!` 연산자의 영역 안) 으로 포장돼야 합니다.

`throws` 키워드는 함수 타입의 일부이며, '던지지 않는 함수 (nonthrowing functions)' 는 '던지는 함수' 의 하위 타입입니다. 그 결과, '던지지 않는 함수' 를 '던지는 함수' 와 같은 위치에 사용할 수 있습니다.

함수가 에러를 던질 수 있는 지의 여부 만을 기준으로 하여 함수를 '중복 정의 (overload)' 할 수는 없습니다. 이 말은, 함수의 _매개 변수 (parameter)_ 가 에러를 던질 수 있는 지의 여부를 기준으로는 함수를 중복 정의할 수 있다는 말입니다.

'던지는 메소드' 는 '던지지 않는 메소드' 를 재정의할 수 없으며, '던지는 메소드' 는 '던지지 않는 메소드' 에 대한 프로토콜 필수 조건을 만족할 수 없습니다. 이 말은, '던지지 않는 메소드' 는 '던지는 메소드' 를 재정의할 수 있고, '던지지 않는 메소드' 는 '던지는 메소드' 에 대한 프로토콜 필수 조건을 만족할 수 있다는 말입니다.

#### Rethrowing Functions and Methods (다시 던지는 함수 및 메소드)

함수 또는 메소드는 함수 매개 변수 중 하나가 에러를 던지는 경우에만 에러를 던진다는 것을 나타내기 위해 `rethrows` 키워드로 선언할 수 있습니다. 이러한 함수 및 메소드를 _다시 던지는 함수 (rethrowing functions)_ 및 _다시 던지는 메소드 (rethrowing methods)_ 라고 합니다. '다시 던지는 함수' 와 '다시 던지는 메소드' 는 반드시 최소한 하나의 '던지는 함수 매개 변수 (throwing function parameter)' 를 가져야 합니다:

```swift
func someFunction(callback: () throws -> Void) rethrows {
  try callback()
}
```

다시 던지는 함수 또는 다시 던지는 메소드는 `catch` 절 안에서만 `throw` 문을 가질 수 있습니다. 이는 `do`-`catch` 구문 안에서 '던지는 함수' 를 호출하고 `catch` 절에서는 다른 에러를 던지는 것으로 에러를 처리하게 해줍니다. 여기에 더하여, `catch` 절은 반드시 '다시 던지는 함수' 의 '던지는 매개 변수'[^throwing-parameter] 중 하나에서 던지는 에러만 처리해야 합니다. 예를 들어, 다음은 `catch` 절이 `alwaysThrows()` 가 던지는 에러를 처리하게 되므로 무효입니다.

```swift
func alwaysThrows() throws {
  throw SomeError.error
}
func someFunction(callback: () throws -> Void) rethrows {
  do {
    try callback()
    try alwaysThrows()  // 무효입니다, alwaysThrows() 는 던지는 매개 변수가 아닙니다.
  } catch {
    throw AnotherError.error
  }
}
```

'던지는 메소드' 는 '다시 던지는 메소드' 를 재정의할 수 없으며, '던지는 메소드' 는 '다시 던지는 메소드' 에 대한 프로토콜 필수 조건을 만족할 수 없습니다. 이 말은, '다시 던지는 메소드' 는 '던지는 메소드' 를 재정의할 수 있으며, '다시 던지는 메소드' 는 '던지는 메소드' 에 대한 프로토콜 필수 조건을 만족할 수 있다는 말입니다.

#### Functions that Never return

### Enumeration Declaration

#### Enumerations with Cases of Any Type

**Enumerations with Indirection**

#### Enumerations with Cases of a Raw-Value Type

#### Accessing Enumeration Cases

### Structure Declaration

### Class Declaration

### Protocol Declaration (프로토콜 선언)

_프로토콜 선언 (protocol declaration)_ 은 프로그램에 '이름 있는 프로토콜 타입' 을 도입합니다. 프로토콜 선언은 `protocol` 키워드를 사용하여 '전역 범위 (global scope)' 에서 선언하며 다음 양식을 가집니다:

```swift
  protocol protocol name: inherited protocols {
    protocol member declarations
  }
```

프로토콜의 본문은, 이 프로토콜을 채택한 타입이면 어떤 것이든 반드시 충족해야 하는 '준수 필수 조건 (conformance requirements)' 을 설명하는, '0' 개 이상의 _프로토콜 멤버 선언 (protocol member declarations)_ 을 가집니다. 특히, 프로토콜은 '준수 타입 (conforming types)' 이 반드시 구현해야 하는 정해진 속성, 메소드, 초기자, 및 첨자 연산을 선언할 수 있습니다. 프로토콜은 또, _결합된 타입 (associated types)_ 이라는, 특수한 종류의 '타입 별명 (type aliases)' 을 선언하여, 프로토콜의 다양한 선언들 간의 관계를 지정할 수도 있습니다. 프로토콜 선언은 클래스, 구조체, 열거체, 또는 다른 프로토콜 선언을 가질 수 없습니다. _프로토콜 멤버 선언 (protocol member declarations)_ 은 아래에서 자세히 설명합니다.

프로토콜 타입은 다른 프로토콜을 어떤 개수든 상속할 수 있습니다. 프로토콜 타입이 다른 프로토콜을 상속할 때면, 이 다른 프로토콜에 있는 필수 조건들의 집합은 한데 모여서, 현재 프로토콜을 상속하는 타입이 어떤 것이든 이 모든 필수 조건들을 반드시 준수해야 합니다. 프로토콜 상속을 사용하는 방법에 대한 예제는, [Protocol Inheritance (프로토콜 상속)]({% post_url 2016-03-03-Protocols %}#protocol-inheritance-프로토콜-상속) 을 참고하기 바랍니다.

> [Protocol Composition Type (프로토콜 합성 타입)]({% post_url 2020-02-20-Types %}#protocol-composition-type-프로토콜-합성-타입) 과 [Protocol Composition (프로토콜 합성)]({% post_url 2016-03-03-Protocols %}#protocol-composition-프로토콜-합성) 에서 설명한 것처럼, 프로토콜 합성 타입을 사용하여 다중 프로토콜의 준수 필수 조건을 한데 모으는 것도 가능합니다.

이전에 선언되어 있던 타입에 '프로토콜 준수성' 을 추가하려면 해당 타입의 '익스텐션' 선언에서 그 프로토콜을 채택하면 됩니다. 그 '익스텐션' 에서, 채택한 프로토콜의 모든 필수 조건을 반드시 구현해야 합니다. 타입이 이미 모든 필수 조건을 구현하고 있는 경우에는, '익스텐션' 선언의 본문을 비워둘 수도 있습니다.

기본적으로, 프로토콜을 준수하는 타입은 프로토콜에서 선언한 모든 속성, 메소드, 및 첨자 연산을 반드시 구현해야 합니다. 즉, 이런 프로토콜 멤버 선언을 `optional` 선언 수정자로 표시하면 '준수 타입' 에 의한 구현이 '옵셔널 (optional)' 임을 지정할 수 있습니다.[^optional-member] `optional` '수정자 (modifier)' 는 `objc` '특성 (attribute)' 으로 표시한 멤버와, `objc` 특성으로 표시한 프로토콜의 멤버에만 적용할 수 있습니다. 그 결과로, 클래스 타입만 '옵셔널 멤버 필수 조건' 을 가지는 프로토콜을 채택하고 준수할 수 있습니다. `optional` 선언 수정자를 사용하는 방법에 대한 더 자세한 정보와 옵셔널 프로토콜 멤버에 접근하는 방법-예를 들어, 준수 타입이 이를 구현했는지 확실하지 않을 때-에 대한 지침은, [Optional Protocol Requirements (옵셔널 프로토콜 필수 조건)]({% post_url 2016-03-03-Protocols %}#optional-protocol-requirements-옵셔널-프로토콜-필수-조건) 을 참고하기 바랍니다.

'열거체의 case 값' 은 타입 멤버에 대한 프로토콜 필수 조건을 만족할 수 있습니다. 특히, '결합된 값' 이 없는 '열거체 case 값' 은 `Self` 타입의 '읽기-전용 (get-only)' 타입 변수에 대한 프로토콜 필수 조건을 만족하며, '결합된 값' 이 있는 '열거체 case 값' 은 매개 변수와 인자 이름표가 'case 값' 의 '결합된 값' 에 일치하는 `Self` 를 반환하는 함수에 대한 프로토콜 필수 조건을 만족합니다. 예를 들면 다음과 같습니다:

```swift
protocol SomeProtocol {
  static var someValue: Self { get }
  static func someFunction(x: Int) -> Self
}
enum MyEnum: SomeProtocol {
  case someValue
  case someFunction(x: Int)
}
```

프로토콜의 '채택 (adoption)' 을 클래스 타입으로만 제약하려면, 콜론 뒤의 _상속받은 프로토콜 (inherited protocols)_ 목록에 `AnyObject` 프로토콜을 포함하면 됩니다. 예를 들어, 다음 프로토콜은 클래스 타입만 채택할 수 있습니다:

```swift
protocol SomeProtocol: AnyObject {
  /* 여기에 프로토콜 멤버를 둡니다 */
}
```

`AnyObject` 필수 조건으로 표시한 프로토콜을 상속한 어떤 프로토콜이든 마찬가지로 클래스 타입만 채택할 수 있습니다.

> 프로토콜을 `objc` 특성으로 표시할 경우, `AnyObject` 필수 조건이 해당 프로토콜에 암시적으로 적용됩니다; 이 프로토콜은 `AnyObject` 필수 조건을 명시적으로 표시할 필요가 없습니다.

프로토콜은 '이름 있는 타입 (named types)' 이며, 그래서 [Protocols as Types (타입으로써의 프로토콜)]({% post_url 2016-03-03-Protocols %}#protocols-as-types-타입으로써의-프로토콜) 에서 설명한 것처럼, 코드에서 다른 이름 있는 타입과 똑같은 위치에서 나타낼 수 있습니다. 하지만, 프로토콜의 인스턴스를 '생성 (construct)' 할 수는 없는데, 프로토콜은 그것이 지정한 필수 조건에 대한 구현부를 실제로 제공하는 것이 아니기 때문입니다.

프로토콜을 사용하면, [Delegation (위임)]({% post_url 2016-03-03-Protocols %}#delegation-위임) 에서 설명한 것처럼, 클래스 또는 구조체의 '대리자 (delegate)' 가 구현해야 하는 메소드를 선언할 수 있습니다.

> GRAMMAR OF A PROTOCOL DECLARATION 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID369)

#### Protocol Property Declaration (프로토콜 속성 선언)

#### Protocol Method Declaration

#### Protocol Initializer Declaration

#### Protocol Subscript Declaration (프로토콜 첨자 연산 선언)

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

스위프트는 다섯 가지 수준의 접근 제어를 제공합니다: '공개 (open)', '공용 (public)', '내부 (internal)', '파일 전용 (file private)', 그리고 '개인 전용 (private)' 이 그것입니다. 아래의 접근-수준 수정자 중 하나를 선언에 표시하여 그 선언의 접근 수준을 지정할 수 있습니다. 접근 제어는 [Access Control (접근 제어)]({% post_url 2020-04-28-Access-Control %}) 에서 더 자세하게 설명합니다.

`open`

선언에 이 수정자를 적용하면 해당 선언이 선언과 같은 모듈에 있는 코드에서 접근할 수도 있고 하위 클래스를 만들 수도 있다고 나타냅니다. `open` 접근-수준 수정자로 표시한 선언은 해당 선언을 가지고 있는 모듈을 불러온 모듈 내의 코드에서도 접근할 수 있고 하위 클래스를 만들 수 있습니다.

`public`

선언에 이 수정자를 적용하면 해당 선언이 선언과 같은 모듈에 있는 코드에서 접근할 수도 있고 하위 클래스를 만들 수도 있다고 나타냅니다. `public` 접근-수준 수정자로 표시한 선언은 해당 선언을 가지고 있는 모듈을 불러온 모듈 내의 코드에서도 접근할 수 있습니다. (하위 클래스를 만들 수는 없습니다.)

`internal`

선언에 이 수정자를 적용하면 해당 선언이 선언과 같은 모듈에 있는 코드에서만 접근할 수 있다고 나타냅니다. 기본적으로, 대부분의 선언은 암시적으로 `internal` 접근-수준 수정자로 표시됩니다.

`fileprivate`

선언에 이 수정자를 적용하면 해당 선언이 선언과 같은 소스 파일에 있는 코드에서만 접근할 수 있다고 나타냅니다.

`private`

선언에 이 수정자를 적용하면 해당 선언이 바로 그 선언을 둘러싼 영역 내에 있는 코드에서만 접근할 수 있다고 나타냅니다.

'접근 제어' 라는 용도를 위해서, 같은 파일에 있는 같은 타입에 대한 '익스텐션 (extensions)' 은 접근-제어 영역을 공유합니다. 확장하는 타입 역시 같은 파일에 있다면, 타입의 접근-제어 영역을 공유합니다. 타입의 선언에서 선언한 '개인 전용 (private)' 멤버는 '익스텐션' 에서 접근할 수 있으며, 한 '익스텐션' 에서 선언한 '개인 전용' 멤버는 다른 '익스텐션' 및 타입의 선언에서 접근할 수 있습니다.

위에 있는 각각의 접근-수준 수정자는, `set` 키워드를 괄호로 감싸서 구성한 (예를 들어, `private(set)` 같은), 단일 인자를 선택적으로 받을 수 있습니다. 이 형태의 접근-제어 수정자는, [Getters and Setters ('획득자' 와 '설정자')]({% post_url 2020-04-28-Access-Control %}#getters-and-setters-획득자-와-설정자) 에서 설명한 것처럼, 변수나 첨자 연산의 '설정자 (setter)' 에 대한 접근 수준을 변수나 첨자 연산 그 자체의 접근 수준보다 낮거나 같도록 지정하고 싶을 때 사용합니다.

### 참고 자료

[^Declarations]: 원문은 [Declarations](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html) 에서 확인할 수 있습니다.

[^expression]: 여기서의 '표현식 (expression)' 은 위 예제 양식에 있는 'expression' 을 말합니다. 클래스 선언이나 구조체 선언에서는 이 'expression' 부분이 없어도 된다는 말입니다.

[^type]: 여기서의 '타입 (type)' 보조 설명이란 위 에제 양식에 있는 'type' 을 말합니다. 뒤에 붙은 'expression' 을 통해 타입을 추론할 수 있는 경우 생략할 수 있는데, 스위프트에서는 거의 생략된 채로 사용합니다.

[^call-by-value-result]: 기본적으로, '값-결과에 의한 호출 (call by value result)' 은 '값에 의한 호출 (call by value)' 과 '참조에 의한 호출 (call by reference)' 이 합쳐진 것으로 볼 수 있습니다. [프로그래밍 학습법탐구자](http://blog.daum.net/here8now/) 님의 [call by value, call by reference, call by value result, call by name](http://blog.daum.net/here8now/37) 항목에 따르면, 함수 안에서는 '값에 의한 호출 (call by value)' 처럼 동작하고, 함수 반환 시에는 '참조에 의한 호출 (call by reference)' 처럼 동작합니다. 다만, 본문에서 이어서 설명하는 것처럼, '값-결과에 의한 호출' 은 최적화에 따라 '참조에 의한 호출' 처럼 동작하기도 합니다. 즉, 스위프트의 '입-출력 매개 변수' 는 '참조에 의한 호출' 또는 '값-결과에 의한 호출' 을 상황에 따라 적절하게 선택해서 인자를 전달하는 것이라 볼 수 있습니다.

[^optional-member]: 여기서의 '옵셔널 (optional)' 은 '선택적' 이라는 말과 '타입이 옵셔널' 이라는 두 가지 의미를 모두 가지고 있습니다. 이는 프로토콜에서 선언한 '필수 조건' 이 구현되어 있는 지가 '옵셔널' 인 것으로 이해할 수 있습니다. 즉, 프로토콜의 준수 타입에서 구현을 했으면 그 구현체를 가지는 것이고, 구현이 되어 있지 않으면 `nil` 인 것입니다.

[^throwing-parameter]: 여기서 '던지는 매개 변수 (throwing paramter)' 는 앞서 얘기한 '던지는 함수 매개 변수 (throwing function parameter)' 를 말하는 것으로, 매개 변수가 '던지는 함수 (throwing function)' 인 것입니다.
