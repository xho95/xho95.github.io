---
layout: post
comments: true
title:  "Swift 5.2: Automatic Reference Counting (자동 참조 카운팅)"
date:   2020-06-18 10:00:00 +0900
categories: Swift Language Grammar ARC Automitic Reference Counting
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Optional Chaining](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html) 부분[^Automatic-Reference-Counting]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Automatic Reference Counting (자동 참조 카운팅)

스위프트는 앱의 메모리 사용량을 추적하고 관리하기 위해 _자동 참조 카운팅 (Automatic Reference Counting; ARC)_ 을 사용합니다. 이것은, 대부분의 경우, 스위프트의 메모리 관리는 "그냥 작동하는 것 (just works)" 이라서, 메모리 관리에 대해서 직접 생각할 필요가 없다는 것을 의미합니다. ARC 는 클래스 인스턴스가 더 이상 필요하지 않을 때 그 인스턴스가 사용하고 있는 메모리를 해제하여 확보합니다.

하지만, 메모리 관리를 자동으로 하기 위해서 ARC 가 코드 사이의 관계에 대한 정보를 더 요구하는 경우가 간혹 있습니다. 이번 장에서는 이러한 상황들을 설명하고 ARC 가 모든 앱의 메모리를 관리하도록 만드는 방법을 보이도록 합니다. 스위프트에서 ARC 를 사용하는 것은 오브젝티브-C 와 ARC 를 같이 사용하기 위해 [Transitioning to ARC Release Notes](https://developer.apple.com/library/archive/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html) 에서 설명한 접근 방식과 매우 유사합니다.

'참조 카운팅 (reference counting)' 은 클래스의 인스턴스에만 적용됩니다.[^reference-type] 구조체와 열거체는 값 타입이지, 참조 타입이 아니라서, 참조의 형태로 저장되거나 전달되지 않습니다.

### How ARC Works (ARC 의 작동 방식)

클래스에 대한 새 인스턴스를 생성할 때마다, ARC 는 메모리 덩어리를 할당하여 그 인스턴스에 대한 정보를 저장합니다. 이 메모리는, 그 인스턴스의 타입에 대한 정보와, 해당 인스턴스에 결합된 모든 저장 속성의 값을 함께 담아 둡니다.

여기다, 인스턴스가 더 이상 필요하지 않을 때는, ARC 가 그 인스턴스가 사용하고 있는 메모리를 해제하므로 그 메모리를 다른 용도로 사용할 수 있게 됩니다. 이는 클래스 인스턴스가 더 이상 필요없을 때 메모리 공간을 차지하지 않도록 해줍니다.

하지만, 만약 ARC 가 아직 사용중인 인스턴스의 할당을 해제한 것이라면, 그 인스턴스의 속성에 접근하거나, 그 인스턴스의 메소드를 호출하는 것은 더 이상 가능하지 않을 것입니다. 진짜로, 만약 그 인스턴스에 접근하려고 하면, 거의 확실히 앱이 충돌날 것입니다.

아직 필요한 동안에는 해당 인스턴스가 사라지지 않도록 하기 위해서, ARC 는 현재의 각 클래스 인스턴스를 몇 개의 속성, 상수, 그리고 변수가 참조하고 있는지를 추적합니다. ARC 는 인스턴스에 대한 '활성화된 (active)' 참조가 하나라도 존재하는 한 그 인스턴스의 할당을 해제하지 않을 것입니다.

이를 가능하게 하기 위해, 클래스 인스턴스를 속성, 상수, 또는 변수에 할당할 때마다, 그 속성, 상수, 또는 변수는 인스턴스에 대한 _강한 참조 (strong reference)_ 를 만듭니다. 이 참조를 "강한 (strong)" 참조라고 하는 이유는 해당 인스턴스를 단단히 움켜쥐고 있어서, 그 '강한 참조' 가 남아 있는 한 할당이 해제되지 않도록 하기 때문입니다.

### ARC in Action (ARC 의 실제 사례)

다음은 '자동 참조 카운팅 (Automatic Reference Counting)' 의 작동 방식에 대한 예제입니다. 이 예제는, `name` 이라는 저장 속성을 정의하는, `Person` 이라는 간단한 클래스로 시작합니다:

```swift
class Person {
  let name: String
  init(name: String) {
    self.name = name
    print("\(name) is being initialized")
  }
  deinit {
    print("\(name) is being deinitialized")
  }
}
```

`Person` 클래스는 인스턴스의 `name` 속성을 설정하고 초기화가 진행 중임을 알리는 메시지를 출력하는 '초기자' 를 가지고 있습니다. `Person` 클래스는 클래스 인스턴스의 할당을 해제할 때 메시지를 출력하는 '정리자 (deinitializer)' 도 가지고 있습니다.

다음의 코드 조각은 `Person?` 타입의 변수를 세 개 정의하는데, 이는 이어지는 코드 조각에서 새 `Person` 인스턴스에 대한 '다중 참조 (multiple references)'[^multiple-references] 를 설정하는데 사용됩니다. 이 변수들은 옵셔널 타입 (`Person` 이 아니라, `Person?`) 이기 때문에, 자동적으로 `nil` 값으로 초기화되어, 지금 당장은 `Person` 인스턴스를 참조하지 않습니다.

```swift
var reference1: Person?
var reference2: Person?
var reference3: Person?
```

이제 새로운 `Person` 인스턴스를 생성하여 이 세 변수 중 하나에 할당할 수 있습니다:

```swift
reference1 = Person(name: "John Appleseed")
// "John Appleseed is being initialized" 를 출력합니다.
```

`Person` 클래스의 초기자를 호출하는 순간에 `"John Appleseed is being initialized"` 메시지가 출력된다는 점을 기억하기 바랍니다. 이는 초기화가 일어났음을 입증합니다.

새 `Person` 인스턴스를 `reference1` 변수에 할당했으므로, 이제 `reference1` 에서 새 `Person` 인스턴스로 향하는 '강한 참조 (strong reference)' 가 생겼습니다. 최소 하나의 '강한 참조' 가 있으므로, ARC 가 이 `Person` 에 대한 메모리를 유지하고 할당을 해제하지 않는다고 확신할 수 있습니다.

똑같은 `Person` 인스턴스를 두 변수에 더 할당하면, 그 인스턴스에 대한 두 개의 '강한 참조' 더 생깁니다:

```swift
reference2 = reference1
reference3 = reference1
```

이제 이 단일한 `Person` 인스턴스에 대한 _세 개의 (three)_ '강한 참조' 가 있습니다.

두 개의 변수에 `nil` 을 할당하여 '강한 참조' 중에서 두 개를 끊더라도 (설령 원래의 참조를 끊더라도), 하나의 '강한 참조' 는 남아 있으므로, `Person` 인스턴스의 할당은 해제되지 않습니다:

```swift
reference1 = nil
reference2 = nil
```

ARC 는 세 번째이자 마지막인 '강한 참조' 를 끊을 때까지, 즉 `Person` 인스턴스를 더 이상 사용하지 않는 것이 분명해질 때까지, `Person` 의 할당을 해제하지 않습니다:

```swift
reference3 = nil
// "John Appleseed is being deinitialized" 를 출력합니다.
```

### Strong Reference Cycles Between Class Instances (클래스 인스턴스 사이의 강한 참조 순환)

위 예제에서, ARC 는 새로 생성한 `Person` 인스턴스의 참조 개수를 추적하여 더 이상 필요하지 않을 때 `Person` 인스턴스의 할당을 해제할 수 있었습니다.

하지만, 클래스 인스턴스에 대한 '강한 참조' 가 _절대로 (never)_ 없어지지 않는 코드를 작성하게 될 수도 있습니다. 이것은 두 클래스 인스턴스가 서로에 대한 '강한 참조' 를 움켜쥐고 있는 경우에 발생하는데, 그로 인해 각각의 인스턴스가 다른 것을 계속 살아있게 만드는 것입니다. 이를 '_강한 참조 순환 (strong reference cycle)_' 이라고 합니다.

'강한 참조 순환' 을 해결하려면 클래스 사이의 일부 관계를 강한 참조가 아니라 '약한 참조 (weak reference)' 나 '소유자가 없는 참조 (unowned rerference)' 로 정의해야 합니다. 이 과정은 [Resolving Strong Reference Cycles Between Class Instances (클래스 인스턴스 사이의 강한 참조 순환 해결하기)](#resolving-strong-reference-cycles-between-class-instances-클래스-인스턴스-사이의-강한-참조-순환-해결하기) 에서 설명합니다. 하지만, 강한 참조 순환을 해결하는 방법을 배우기 전에, 어떻게 해서 그런 순환이 일어나는지를 먼저 이해하는 것이 좋을 겁니다.

다음은 강한 참조 순환이 어떻게 해서 우연히 생성될 수 있는 지를 보여주는 예제입니다. 이 예제는, 아파트 단지 및 그 거주자를 모델링하는, `Person` 과 `Apartment` 라는 두 개의 클래스를 정의합니다:

```swift
class Person {
  let name: String
  init(name: String) { self.name = name }
  var apartment: Apartment?
  deinit { print("\(name) is being deinitialized") }
}

class Apartment {
  let unit: String
  init(unit: String) { self.unit = unit }
  var tenant: Person?
  deinit { print("Apartment \(unit) is being deinitialized") }
}
```

모든 `Person` 인스턴스는 `String` 타입인 `name` 속성과 `nil` 로 초기화된 옵셔널 `apartment` 속성을 가지고 있습니다. `apartment` 속성이 '옵셔널' 인건, 사람이 항상 아파트를 가지고 있는 건 아니기 때문입니다.

이와 비슷하게, 모든 `Apartment` 인스턴스는 `String` 타입인 `unit` 속성을 가지며 `nil` 로 초기화된 옵셔널 `tenant` 속성도 가지고 있습니다. '소유주 (tenant)' 속성이 옵셔널인 것은 아파트에 항상 소유주가 있는 것은 아니기 때문입니다.

이 두 클래스 모두, 해당 클래스의 인스턴스가 정리되었다는 사실을 출력하는, '정리자 (deinitializer)'[^deinitializer] 도 정의하고 있습니다. 이는 `Person` 과 `Apartment` 의 인스턴스에 대한 할당이 예상대로 해제되고 있는지를 확인할 수 있도록 해줍니다.

다음 코드 조각은 `john` 과 `unit4A` 라는 옵셔널 타입의 값을 두 개 정의하는데, 이는 그 아래에서 특정한 `Apartment` 와 `Person` 인스턴스로 설정하게 됩니다. 이 두 변수 모두, 옵셔널이 가지는 장점에 의해, `nil` 이라는 초기 값을 가집니다.

```swift
var john: Person?
var unit4A: Apartment?
```

이제 특정한 `Person` 인스턴스와 `Apartment` 인스턴스를 생성해서 이 새 인스턴스를 `john` 과 `unit4A` 변수에 할당할 수 있습니다:

```swift
john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
```

이 두 인스턴스를 생성하고 할당하고 나면 '강한 참조' 는 다음 처럼 보이게 됩니다. `john` 변수는 이제 새 `Person` 인스턴스에 대한 '강한 참조' 를 가지고 있고, `unit4A` 변수는 새 `Apartment` 인스턴스에 대한 '강한 참조' 를 가지고 있습니다:



### Resolving Strong Reference Cycles Between Class Instances (클래스 인스턴스 사이의 강한 참조 순환 해결하기)

#### Week References (약한 참조)

#### Unowned References (소유자가 없는 참조)

#### Unowned References and Implicitly Unwrapped Optional Properties (소유자가 없는 참조 및 암시적으로 풀리는 옵셔널 속성)

### Strong Reference Cycles for Closures (클로저에 대한 강한 참조 순환)

### Resolving Strong Reference Cycles for Closures (클로저에 대한 강한 참조 순환 해결하기)

#### Defining a Capture List (붙잡을 목록 정의하기)

#### Weak and Unowned References (약한 참조와 소유자가 없는 참조)

### 참고 자료

[^Automatic-Reference-Counting]: 이 글에 대한 원문은 [Automatic-Reference-Counting](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html) 에서 확인할 수 있습니다.

[^reference-type]: '참조 카운팅 (reference counting)' 은 스위프트의 메모리 관리 방법으로, 여기서 '메모리 관리' 는 '동적인 메모리를 자동으로 할당하고 해제하는 것' 을 의미합니다. 프로그래밍에서 '동적인 메모리' 의 할당, 해제가 일어나는 곳을 '자유 저장소 (free store; 또는 heap)' 라고 하며, '참조 (reference)' 는 '자유 저장소' 에 있는 할당된 메모리 영역을 '참조하는 (또는 가리키는; refer to)' 것에서 유래한 말입니다. 구조체나 열거체 같은 '값 타입 (value type)' 은 '자유 저장소' 가 아니라 '스택 (stack)' 이라는 '정적인 메모리' 공간에 생기기 것이라서 메모리 관리의 대상이 아닙니다. 보다 자세한 내용은 위키피디아의 'Memory management' 항목 중 [Dynamic memory allocation](https://en.wikipedia.org/wiki/Memory_management#DYNAMIC) 부분과 [Stack-based memory allocation](https://en.wikipedia.org/wiki/Stack-based_memory_allocation) 항목을 참고하기 바랍니다.

[^multiple-references]: 여기서 '다중 참조 (multiple references)' 는 한 인스턴스를 여러 개의 변수에서 동시에 참조하고 있는 상태를 말합니다.

[^deinitializer]: 'deinitializer' 를 '정리자' 라고 옮기는 이유는 스위프트 언어에서 '소멸자' 라는 말은 어울리지 않기 때문입니다. 이에 대해서는 [Deinitialization (객체 정리)]({% post_url 2017-03-03-Deinitialization %}) 의 '[참고 자료]({% post_url 2017-03-03-Deinitialization %}#참고-자료)' 부분을 참고하기 바랍니다.
