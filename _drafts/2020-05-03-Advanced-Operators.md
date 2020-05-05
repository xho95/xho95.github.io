---
layout: post
comments: true
title:  "Swift 5.2: Advanced Operators (고급 연산자)"
date:   2020-05-03 10:00:00 +0900
categories: Swift Language Grammar Advanced Operator
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Advanced Operators](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html) 부분[^Advanced-Operators]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Advanced Operators (고급 연산자)

[Basic Operators (기본 연산자)](http://xho95.github.io/swift/language/grammar/basic/operators/2016/04/27/Basic-Operators.html) 에서 설명한 연산자에 더하여, 스위프트는 더 복잡한 값을 조작을 수행할 수 있는 여러가지의 고급 연산자를 제공합니다. 여기에는 C 언어와 오브젝티브-C 언어에서 익숙한 모든 '비트 연산자 (bitwise operators)' 와 '비트 이동 연산자 (bit shifting operators)' 가 포함되어 있습니다.

C 언어의 '산술 연산자 (arithmetic operators)' 와는 달리, 스위프트의 산술 연산자는 기본적으로 '값이 넘치지 (overflow)' 않습니다. '값 넘침 동작 (overflow behavior)' 은 '덫에 걸려서 (trapped)' 에러라고 보고됩니다. 값 넘침 동작을 선택하려면, 스위프트의 추가적인 산술 연산자 집합들을 사용하여 기본적으로 '값 넘침 (overflow)' 동작을 하도록 할 수 있는데, 여기에는 가령 '값 넘침 더하기 연산자 (overflow addition operator; `&+`)' 등이 있습니다. 이러한 값 넘침 연산자들은 모두 '앤드 기호 (`&`; 앰퍼센드)' 로 시작합니다.

자신만의 구조체, 클래스, 그리고 열거체를 정의할 때는, 이 사용자 정의 타입에 대한 표준 스위프트 연산자의 자신만의 구현을 제공하는 것이 유용할 것입니다. 스위프는 연산자의 맞춤형 구현을 제공하는 것과 생성할 각 타입의 동작이 정확히 무엇인지 결정하는 것을 쉽게 할 수 있도록 해줍니다.

이는 '이미 정의된 (predefined)' 연산자로 한정되지 않습니다. 스위프트에서는 자유롭게 자신만의 사용자 정의 '중위 (infix)', '접두 (prefix)', '접미 (postfix)', 그리고 '할당 연산자' 를 정의할 수 있으며, 사용자 정의 '우선 순위 (precedence)' 와 '결합 법칙 (associativity)' 도 지정할 수 있습니다. 이 연산자는 '이미 정의된' 연산자 처럼 코드에서 채택하여 사용할 수 있고, 심지어 직접 정의한 사용자 정의 연산자를 지원하도록 기존 타입을 확장할 수도 있습니다.

### Bitwise Operators (비트 연산자)

_비트 연산자 (bitwise operators)_ 는 자료 구조에서 개별 '원시 자료 비트 (raw data bits)' 를 조작할 수 있게 해 줍니다. 이는 주로 저-수준 프로그래밍에서 사용되는데, 이에는 '그래픽 프로그래밍 (graphic programming)' 과 '장치 드라이버 생성 (device driver creation)' 등이 있습니다. '비트 연산자' 는 외부 소스에 있는 원시 자료와 작업할 때도 유용한데, 이에는 사용자 정의 프로토콜을 사용한 통신에서 'data encoding (자료 부호화)' 와 'data decoding (자료 복호화)' 할 때 등이 있습니다.

스위프트는 아래에서 설명하는 것처럼, C 언어에 있는 모든 비트 연산자를 지원합니다.

### Bitwise NOT Operator (비트 논리 부정 연산자)

_비트 논리 부정 연산자 (bitwise NOT operator)_ (`~`) 는 어떤 수치 값에 있는 모든 비트를 반전시킵니다:

![bitwise-NOT-operator](/assets/Swift/Swift-Programming-Language/Advanced-Operators-bitwise-NOT-operator.jpg)

'비트 논리 부정 연산자' 는 '접두 연산자 (prefix operator)' 이며, 연산할 값 바로 앞에, 아무 공백없이 위치합니다:

```swift
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits   // 11110000 과 같습니다.
```

`UInt8` 정수는 8-비트를 가지고 있어서 `0` 과 `255` 사이의 값을 저장할 수 있습니다. 이 예제는 한 `UInt8` 정수를, 처음 '네 자리 (four bits)'[^bits] 는 `0` 이고, 다음 네 자리는 `1` 인, 이진 값 `00001111` 로 초기화합니다. 이는 십진수 값 `15` 와 같습니다.

그런 다음 '비트 논리 부정 연산자' 를 사용하여 `invertedBits` 라는 새로운 상수를 생성하는데, 이는 `initialBits` 와 같으나, 모든 비트를 반전한 것입니다. `0` 은 `1` 이 되고, `1` 은 `0` 이 됩니다. `invertedBits` 의 값은 `11110000` 인데, 부호없는 10-진수 값 `240` 과 같습니다.

### Bitwise AND Operator (비트 논리 곱 연산자)

_비트 논리 합 연산자 (bitwise AND operator)_ (`&`) 는 두 수치 값의 비트를 결합합니다. 이 연산자는 입력 수치 값의 비트가 _둘 다 (both)_ `1` 일 때만 해당 비트를 `1` 로 설정한 새 수치 값을 반환합니다.

![bitwise-AND-operator](/assets/Swift/Swift-Programming-Language/Advanced-Operators-bitwise-AND-operator.jpg)

아래 예제에서, `firstSixBits` 와 `lastSixBits` 의 값은 둘 다 중간의 '네 자리 (four bits)' 가 `1` 입니다. '비트 논리 곱 연산자' 는 이를 결합하여 수치 값 `00111100` 을 만드는데, 이는 부호 없는 10-진수 값 `60` 과 같습니다:

```swift
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits // 00111100 과 같습니다.
```

### Bitwise OR Operator (비트 논리 합 연산자)

_비트 논리 합 연산자 (bitwise OR operator)_ (`|`) 는 두 수치 값을 비트를 비교합니다. 이 연산자는 입력 수치 값의 비트 중 _어느 것이든 (either)_ `1` 이면 해당 비트를 `1` 로 설정한 새 수치 값을 반환합니다.

![bitwise-OR-operator](/assets/Swift/Swift-Programming-Language/Advanced-Operators-bitwise-OR-operator.jpg)

아래 예제에서, `someBits` 와 `moreBits` 의 값은 서로 다른 '자리들 (bits)' 이 `1` 입니다. '비트 논리 합 연산자' 는 이들을 결합하여 수치 값 `11111110` 을 만드는데, 이는 부호 없는 10-진수 `254` 와 같습니다:

```swift
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedBits = someBits | moreBits // 11111110 와 같습니다.
```

### Bitwise XOR Operator (비트 논리 배타 연산자)

_비트 논리 배타 연산자 (bitwise XOR operator)_, 또는 "배타적 논리 합 연산자 (exclusive OR operator)"[^exclusive] (`^`) 는 두 수치 값의 비트를 비교합니다. 이 연산자는 입력 비트들이 서로 다르면 해당 비트를 `1` 로 설정하고 입력 비트들이 같으면 해당 비트를 `0` 으로 설정한 새 수치 값을 반환합니다:

![bitwise-XOR-operator](/assets/Swift/Swift-Programming-Language/Advanced-Operators-bitwise-XOR-operator.jpg)

아래 예제에서, `firstBits` 와 `otherBits` 의 값은 각각 다른 위치에 있는 '자리 (bit)' 가 `1` 입니다. '비트 논리 배타 연산자' 는 결과 값에서 이 '자리들 (bits)' 을 `1` 로 설정합니다. `firstBits` 와 `otherBits` 의 다른 자리들은 모두 일치하므로 출력 값에서 `0` 으로 설정됩니다:

```swift
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits // 00010001 과 같습니다.
```

### Bitwise Left and Right Shift Operators (비트 왼쪽-이동 및 오른쪽-이동 연산자)

**Shifting Behavior for Unsigned Integers (부호없는 정수를 위한 이동 동작)**

**Shifting Behavior for Signed Integers (부호있는 정수를 위한 이동 동작)**

### Overflow Operators (넘침 연산자)

#### Value Overflow (값 넘침)

### Precedence and Associativity (우선 순위 및 결합 법칙)

### Operator Methods (연산자 메소드)

#### Prefix and Postfix Operators (접두사 연산자와 접미사 연산자)

#### Compound Assignment Operators (복합 할당 연산자)

#### Equivalence Operators (같음 비교 연산자)

### Custom Operators (사용자 정의 연산자)

#### Precedence for Custom Infix Operators (사용자 정의 중위 연산자에 대한 우선 순위)

### 참고 자료

[^Advanced-Operators]: 이 글에 대한 원문은 [Advanced Operators](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html) 에서 확인할 수 있습니다.

[^bits]: '비트' 를 우리 말로 한다면 수의 '자리 (값)' 정도가 될 것 같습니다. 다만 편의를 위해서 프로그래밍에서 많이 사용하는 '비트' 라는 말을 사용하기로 하며, 필요에 따라 '자리' 이라는 말로 옮기도록 하겠습니다.

[^exclusive]: 'exclusive' 는 경우에 따라 '독점적인' 이라는 말이 더 어울릴 때가 있습니다. 하지만, 프로그래밍 용어에서는 '배타적인' 이라는 용어가 널리 사용되고 있으므로 'exclusive OR' 는 '배타적인 논리 합' 으로 옮기도록 합니다.
