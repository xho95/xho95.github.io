---
layout: post
comments: true
title:  "Swift 5.2: Advanced Operators (고급 연산자)"
date:   2020-05-03 10:00:00 +0900
categories: Swift Language Grammar Advanced Operator
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Advanced Operators](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html) 부분[^Advanced-Operators]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Advanced Operators (고급 연산자)

[Basic Operators (기본 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 에서 설명한 연산자에 더하여, 스위프트는 더 복잡한 값을 조작을 수행할 수 있는 여러가지의 고급 연산자를 제공합니다. 여기에는 C 언어와 오브젝티브-C 언어에서 익숙한 모든 '비트 연산자 (bitwise operators)' 와 '비트 이동 연산자 (bit shifting operators)' 가 포함되어 있습니다.

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

아래 예제에서, `firstSixBits` 와 `lastSixBits` 의 값은 둘 다 중간의 '네 자리 (four bits)' 가 `1` 입니다. '비트 논리 곱 연산자' 는 이를 결합하여 수치 값 `00111100` 을 만드는데, 이는 부호없는 10-진수 값 `60` 과 같습니다:

```swift
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits // 00111100 과 같습니다.
```

### Bitwise OR Operator (비트 논리 합 연산자)

_비트 논리 합 연산자 (bitwise OR operator)_ (`|`) 는 두 수치 값을 비트를 비교합니다. 이 연산자는 입력 수치 값의 비트 중 _어느 것이든 (either)_ `1` 이면 해당 비트를 `1` 로 설정한 새 수치 값을 반환합니다.

![bitwise-OR-operator](/assets/Swift/Swift-Programming-Language/Advanced-Operators-bitwise-OR-operator.jpg)

아래 예제에서, `someBits` 와 `moreBits` 의 값은 서로 다른 '자리들 (bits)' 이 `1` 입니다. '비트 논리 합 연산자' 는 이들을 결합하여 수치 값 `11111110` 을 만드는데, 이는 부호없는 10-진수 `254` 와 같습니다:

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

_비트 왼쪽-이동 연산자 (bitwise left shift operator)_ (`<<`) 와 _비트 오른쪽-이동 연산자 (bitwise right shift operator)_ (`>>`) 는, 아래 정의된 규칙에 따라, 수치 값에 있는 모든 비트를 정해진 위치 값만큼 왼쪽이나 오른쪽으로 이동합니다.

비트를 왼쪽-이동 및 오른쪽-이동 하는 것은 정수 '인수 (factor)'[^factor] `2` 로 곱하거나 나누는 효과를 가집니다. 정수 비트를 왼쪽으로 한 위치 이동하면 값이 두 배가 되며, 오른쪽으로 한 위치 이동하면 값이 절반이 됩니다.

**Shifting Behavior for Unsigned Integers (부호없는 정수에 대한 이동 동작)**

부호없는 정수에 대한 비트-이동 동작은 다음과 같습니다:

1. 기존 비트를 요청한 위치 값만큼 왼쪽이나 오른쪽으로 이동합니다.
2. 정수 (integer) 의 수용 범위를 넘어서는 비트는 어떤 것이든 버립니다.
3. 원래 비트를 왼쪽이나 오른쪽으로 이동하면서 남는 공간에는 `0` 을 삽입합니다.

이러한 접근 방법을 _논리적 이동 (logical shift)_ 이라고 합니다.

아래 그림은 `11111111 << 1` (`11111111` 이 `1` 위치 만큼 왼쪽으로 이동한 것) 과 `11111111 >> 1` (`11111111` 이 `1` 위치 만큼 오른쪽으로 이동한 것) 의 결과를 보여줍니다. 파란색 숫자가 이동된 것이고, 회색 숫자는 삭제된 것이며, 주황색 `0` 이 삽입되었습니다:

![shifting behavior for ussigned integer](/assets/Swift/Swift-Programming-Language-shifting-behavior-for-unsigned.jpg)

다음은 스위프트 코드에서 비트 이동을 하는 방법을 보여줍니다:

```swift
let shiftBits: UInt8 = 4    // 00000100 라는 2-진수 와 같습니다.
shiftBits << 1              // 00001000
shiftBits << 2              // 00010000
shiftBits << 5              // 10000000
shiftBits << 6              // 00000000
shiftBits >> 2              // 00000001
```

'비트 이동 (bit shifting)' 기능을 사용하면 다른 자료 타입 내의 값을 '부호화 (encoding)' 하고 '복호화 (decoding)' 할 수 있습니다:

```swift
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16    // redComponent 는 0xCC, 또는 204 가 됩니다.
let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent 는 0x66, 또는 102 가 됩니다.
let blueComponent = pink & 0x0000FF           // blueComponent 는 0x99, 또는 153 이 됩니다.
```

이 예제는 `pink` 라는 `UInt32` 상수를 사용하여 핑크 색상에 대한 'CSS'[^CSS] 값을 저장합니다. CSS 색상 값 `#CC6699` 를 스위프트의 16-진수 수치 표현으로 나타내면 `0xCC6699` 입니다. 그다음 '비트 논리 곱 연산자 (bitwise AND operator)' (`&`) 와 '비트 오른쪽-이동 연산자 (bitwise right shift operator)' (`>>`) 를 사용하여 이 색상을 '빨간색 (`CC`)', '녹색 (`66`)', 그리고 '파란색 (`99`)' 성분으로 분해했습니다.

빨간색 성분은 수치 값 `0xCC6699` 와 `0xFF0000` 를 '비트 논리 곱' 하여 구합니다. `0xFF0000` 에 있는 `0` 들은 `0xCC6699` 의 두 번째와 세 번째 '바이트 (bytes)' 를 효과적으로 "숨기므로 (mask)", `6699` 는 무시되어 결과적으로 `0xCC0000` 만 남습니다.

이 수치는 그다음 16-자리 만큼 오른쪽으로 이동합니다 (`>> 16`). 16-진수에서 두 개의 문자는 8 '자리 (bits)' 를 사용하므로, 오른쪽으로 16 자리 만큼 이동하는 것은 `0xCC0000` 을 `0x0000CC` 로 변환하게 됩니다. 이는 `0xCC` 와 같으며, 10-진수 값으로는 `204` 입니다.

이와 비슷하게, 녹색 성분은 수치 값 `0xCC6699` 와 `0x00FF00` 를 '비트 논리 곱' 하여 구하며, 이 결과 값은 `0x006600` 입니다. 그 다음 이 결과 값을 오른쪽으로 8 자리 이동하면, `0x66` 값을 얻게 되며, 이의 10-진수 값은 `102` 입니다.

마지막으로, 파란색 성분은 `0xCC6699` 와 `0x0000FF` 를 '비트 논리 곱' 하여 구하며, 이 결과 값은 `0x000099` 입니다. `0x000099` 는 이미 `0x99` 와 같기 때문에, 오른쪽 이동은 필요 없으며, 10-진수 값은 `153` 입니다.

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

[^bits]: '비트' 를 우리 말로 한다면 수의 '자리 (값)' 정도가 될 것 같습니다. 다만 편의를 위해서 프로그래밍에서 많이 사용하는 '비트' 라는 말을 사용하기로 하며, '자리' 라고 하는 것이 자연스러울 때는 '자리' 라고도 하겠습니다.

[^exclusive]: 'exclusive' 는 경우에 따라 '독점적인' 이라는 말이 더 어울릴 때가 있습니다. 배타적이라는 말과 독점적이라는 말 모두 혼자서 차지한다는 의미를 가지고 있습니다. 하지만, 프로그래밍 분야에서는 '배타적인' 이라는 용어가 이미 널리 사용되고 있으므로 'exclusive OR' 는 '배타적인 논리 합' 으로 옮기도록 합니다.

[^factor]: 'factor' 는 수학 용어로 '인수' 라고 하며, '정수 (integer)' 나 '정식 (equation)' 을 몇 개의 곱으로 나타냈을 때, 각 구성 요소를 일컫는 말이라고 합니다. 보통 '인수 분해 (factorization)' 라고 할 때의 '인수' 가 바로 이 'factor' 입니다. 더 자세한 정보는 위키피디아의 [Factor (mathematics)](https://en.wikipedia.org/wiki/Factor#Mathematics) 또는 [인수](https://ko.wikipedia.org/wiki/인수) 를 참고하기 바랍니다. 요즘에는 '인수' 보다 [약수](https://ko.wikipedia.org/wiki/약수) ([divisor](https://en.wikipedia.org/wiki/Divisor)) 라는 말을 더 많이 사용하는 것 같습니다.

[^CSS]: 원문에서는 'Cascading Style Sheets' 라고 풀어썼지만, 아마도 'CSS' 라는 줄임말이 더 유명할 것입니다. 이에 대해 굳이 더 알고싶은 분은 위키피디아의 [Cascading Style Sheets](https://en.wikipedia.org/wiki/Cascading_Style_Sheets) 또는 [종속형 시트](https://ko.wikipedia.org/wiki/종속형_시트) 를 참고하기 바랍니다.
