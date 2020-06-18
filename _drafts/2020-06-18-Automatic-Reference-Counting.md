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

'참조 카운팅 (reference counting)' 은 클래스의 인스턴스에만 적용됩니다. 구조체와 열거체는 값 타입이지, 참조 타입이 아니라서, 참조의 형태로 저장되거나 전달되지 않습니다.

### How ARC Works (ARC 의 작동 원리)

클래스의 새 인스턴스를 만들 때마다 ARC는 해당 인스턴스에 대한 정보를 저장하기 위해 메모리 청크를 할당합니다. 이 메모리에는 해당 인스턴스와 관련된 저장된 속성 값과 함께 인스턴스 유형에 대한 정보가 있습니다.

또한 인스턴스가 더 이상 필요하지 않은 경우 ARC는 해당 인스턴스가 사용하는 메모리를 비워서 다른 용도로 메모리를 사용할 수 있습니다. 이렇게하면 클래스 인스턴스가 더 이상 필요하지 않을 때 메모리에서 공간을 차지하지 않습니다.

그러나 ARC가 아직 사용중인 인스턴스를 할당 해제하면 더 이상 해당 인스턴스의 속성에 액세스하거나 해당 인스턴스의 메서드를 호출 할 수 없습니다. 실제로 인스턴스에 액세스하려고하면 앱이 중단 될 가능성이 높습니다.

ARC는 인스턴스가 여전히 필요한 동안 사라지지 않도록하기 위해 현재 각 클래스 인스턴스를 참조하는 속성, 상수 및 변수의 수를 추적합니다. ARC는 해당 인스턴스에 대한 하나 이상의 활성 참조가 여전히 존재하는 한 인스턴스 할당을 해제하지 않습니다.

이를 가능하게하기 위해 클래스 인스턴스를 속성, 상수 또는 변수에 할당 할 때마다 해당 속성, 상수 또는 변수가 인스턴스를 강력하게 참조합니다. 참조는 "강력한"참조라고하는데, 그 이유는 해당 인스턴스를 확실하게 유지하고 강한 참조가 남아있는 한 할당 해제 할 수 없기 때문입니다.

### ARC in Action (ARC 의 실제 사례)

### Strong Reference Cycles Between Class Instances (클래스 인스턴스 사이의 강한 참조 순환)

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
