---
layout: post
pagination: 
  enabled: true
comments: true
title:  "Swift 5.7: Advanced Operators (고급 연산자)"
date:   2020-05-11 10:00:00 +0900
categories: Swift Language Grammar Advanced Operator
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [Advanced Operators](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html) 부분[^Advanced-Operators]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Advanced Operators (고급 연산자)

[Basic Operators (기초 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 에서 설명한 연산자에 더해, 스위프트는 더 복잡하게 값을 조작하는 여러 가지 고급 연산자를 제공합니다. 이는 모든 종류의 비트 (bitwise) 및 비트 이동 (bit shifting) 연산자를 포함하는데 C 와 오브젝티브-C 에서부터 익숙할 겁니다.

C 의 산술 (arithmetic) 연산자와 달리, 스위프트의 산술 연산자는 기본적으로 값이 넘치지 않습니다. 값 넘침 (overflow) 동작은 잡아서 에러라고 보고합니다. 값 넘침 동작을 직접 선택하려면, 값 넘침 덧셈 연산자 (`&+`) 같이, 기본적으로 값이 넘치는 스위프트의 두 번째 산술 연산자 집합을 사용합니다. 이러한 모든 값 넘침 연산자는 앰퍼샌드 (`&`)[^ampersand] 로 시작합니다.

자신만의 구조체와, 클래스, 및 열거체를 정의할 땐, 이 사용자 정의 타입에 자신만의 표준 스위프트 연산자를 구현하는 게 유용할 수 있습니다. 스위프트는 이 연산자들의 맞춤식 구현을 쉽게 제공하도록 그리고 생성한 각 타입마다 이들의 정확한 동작이 무엇인지도 쉽게 결정하게 해줍니다.

이미 정의된 연산자로 제한된 것도 아닙니다. 스위프트가 준 자유를 통해, 자신만의 우선 순위 및 결합 법칙 값을 가진, 사용자 정의 중위 (infix) 와, 접두사 (prefix), 접미사 (postfix), 및 할당 (assignment) 연산자를 정의할 수 있습니다. 이미 정의된 어떤 연산자 같이 이 연산자를 코드에서 사용하고 채택할 수 있으며, 심지어 기존 타입을 확장하면 직접 정의한 자신만의 연산자도 지원할 수 있습니다.

### Bitwise Operators (비트 연산자)

_비트 연산자 (bitwise operators)_ 는 자료 구조 안의 개별 원시 데이터 비트를 조작할 수 있게 합니다. 그래픽 프로그래밍과 장치 드라이버 생성 같은, 저-수준 프로그래밍에 주로 사용합니다. 사용자 정의 프로토콜로 통신하는 데이터의 부호화 (encoding) 및 복호화 (decoding) 같이, 외부 소스의 원시 데이터와 작업할 때도 비트 연산자가 유용할 수 있습니다.

아래 설명 처럼, 스위프트는 C 에 있는 모든 비트 연산자를 지원합니다.

#### Bitwise NOT Operator (비트 부정 연산자)

_비트 부정 연산자 (bitwise NOT operator;_ `~`_)_ 는 모든 수치 값 비트를 거꾸로 합니다:

![bitwise-NOT-operator](/assets/Swift/Swift-Programming-Language/Advanced-Operators-bitwise-NOT-operator.jpg)

비트 부정 연산자는 접두사 연산자로, 어떤 공백도 없이, 연산 값 바로 앞에 둡니다:

```swift
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits   // 11110000 과 같음
```

`UInt8` 정수는 8-비트로 `0` 과 `255` 사이의 어떤 값이든 저장할 수 있습니다. 이 예제는 이진 값 `00001111` 로 `UInt8` 정수를 초기화하여, 첫 네 비트는 `0` 으로 설정하고, 그 다음 네 비트는 `1` 로 설정합니다. 이는 10-진수 값 `15` 와 같습니다.

그런 다음 비트 부정 연산자로 `invertedBits` 라는 새로운 상수를 생성하는데, 이는 `initialBits` 와 같지만, 모든 비트가 거꾸로입니다. 0 은 1 이 되고, 1 은 0 이 됩니다. `invertedBits` 의 값은 `11110000` 인데, 부호없는 10-진수 값 `240` 과 같습니다.

#### Bitwise AND Operator (비트 곱 연산자)

_비트 곱 연산자 (bitwise AND operator;_ `&`_)_ 는 두 수치 값 비트를 조합합니다. 입력 수치 값 비트가 _둘 다 (both)_ `1` 일 때만 비트 설정이 `1` 인 새로운 수치 값을 반환합니다:

![bitwise-AND-operator](/assets/Swift/Swift-Programming-Language/Advanced-Operators-bitwise-AND-operator.jpg)

아래 예제의, `firstSixBits` 와 `lastSixBits` 값은 둘 다 네 중간 비트가 `1` 입니다. 비트 곱 연산자로 조합하면 `00111100` 인데, 이는 부호없는 십진수 값 `60` 과 같습니다:

```swift
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits // 00111100 과 같음
```

#### Bitwise OR Operator (비트 합 연산자)

_비트 합 연산자 (bitwise OR operator;_ `|`_)_ 는 두 수치 값 비트를 비교합니다. 연산자는 _어느 (either)_ 입력 수치 값 비트가 `1` 이든 비트 설정이 `1` 인 새로운 수치 값을 반환합니다:

![bitwise-OR-operator](/assets/Swift/Swift-Programming-Language/Advanced-Operators-bitwise-OR-operator.jpg)

아래 예제의, `someBits` 와 `moreBits` 값은 서로 다른 비트에 `1` 이 설정되어 있습니다. 비트 합 연산자로 이를 조합한 수치 값은 `11111110` 으로, 부호없는 10-진수 `254` 와 같습니다:

```swift
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedBits = someBits | moreBits // 11111110 과 같음
```

#### Bitwise XOR Operator (배타적 비트 합 연산자)

_배타적 비트 합 연산자 (bitwise XOR operator)_, 또는 "배타적 논리 합 연산자 (`^`)"[^exclusive-or] 는, 두 수치 값 비트를 비교합니다. 연산자가 반환한 새 수치 값 비트는 입력 비트들이 서로 다르면 `1` 로 설정하고 입력 비트가 같으면 `0` 으로 설정합니다:

![bitwise-XOR-operator](/assets/Swift/Swift-Programming-Language/Advanced-Operators-bitwise-XOR-operator.jpg)

아래 예제의, `firstBits` 와 `otherBits` 값은 상대는 그렇지 않은 장소에 `1` 이 설정된 비트가 있습니다. 배타적 비트 합 연산자는 이 비트 모두의 출력 값을 `1` 로 설정합니다. `firstBits` 와 `otherBits` 안의 다른 모든 비트는 일치하며 출력 값은 `0` 으로 설정합니다:

```swift
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits // 00010001 과 같음
```

#### Bitwise Left and Right Shift Operators (비트 왼쪽-이동 및 오른쪽-이동 연산자)

_비트 왼쪽 이동 연산자 (bitwise left shift operator;_ `<<`_)_ 와 _비트 오른쪽 이동 연산자 (bitwise right shift operator;_ `>>`_)_ 는 모든 수치 값 비트를, 아래 정의한 규칙에 따라, 특정 수의 자리만큼 왼쪽 또는 오른쪽으로 이동합니다.

비트를 왼쪽과 오른쪽으로 이동하는 건 정수를 2 라는 인수 (factor)[^factor] 로 곱하거나 나누는 효과가 있습니다. 정수 비트를 왼쪽으로 한 위치 이동하면 자신의 값이 두 배가 되는 반면, 오른쪽으로 한 위치 이동하면 자신의 값이 반이 됩니다.

**Shifting Behavior for Unsigned Integers (부호없는 정수의 이동 동작)**

부호없는 정수의 비트-이동 동작은 다음과 같습니다:

1. 기존 비트를 요청한 수의 위치만큼 왼쪽이나 오른쪽으로 이동합니다.
2. 어떤 비트든 정수 저장 공간 경계를 넘으면 버립니다.
3. 원본 비트가 왼쪽이나 오른쪽으로 이동한 후 남은 공간엔 0 을 집어 넣습니다.

이 접근법을 _논리적 이동 (logical shift)_ 이라 합니다.

아래의 묘사는 (`11111111` 을 `1` 위치만큼 왼쪽 이동하는) `11111111 << 1` 과, (`11111111` 을 `1` 위치만큼 오른쪽 이동하는) `11111111 >> 1` 의 결과를 보여줍니다. 파란 숫자는 이동한 것이고, 회색 숫자는 버린 것이며, 주황색 `0` 은 집어 넣은 것입니다:

![shifting behavior for unsigned integer](/assets/Swift/Swift-Programming-Language/Advanced-Operators-shifting-behavior-for-unsigned.png)

스위프트 코드의 비트 이동은 이렇게 보입니다:

```swift
let shiftBits: UInt8 = 4    // 00000100 (2-진수)
shiftBits << 1              // 00001000
shiftBits << 2              // 00010000
shiftBits << 5              // 10000000
shiftBits << 6              // 00000000
shiftBits >> 2              // 00000001
```

비트 이동을 사용하면 다른 데이터 타입 안의 값을 부호화 (encoding) 및 복호화 (decoding) 할 수 있습니다:

```swift
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16    // redComponent 는 0xCC, 또는 204 임
let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent 는 0x66, 또는 102 임
let blueComponent = pink & 0x0000FF           // blueComponent 는 0x99, 또는 153 임
```

이 예제는 `pink` 라는 `UInt32` 상수를 사용하여 분홍색의 CSS 값[^CSS] 을 저장합니다. CSS 색상 값 `#CC6699` 은 스위프트 16-진수 표현법으론 `0xCC6699` 라고 작성합니다. 그런 다음 비트 곱 연산자 (`&`) 와 비트 오른쪽 이동 연산자 (`>>`) 로 이 색의 빨간색 (`CC`), 녹색 (`66`), 및 파란색 (`99`) 성분을 분해합니다.

빨간색 성분은 수치 값 `0xCC6699` 와 `0xFF0000` 를 비트 곱하여 구합니다. `0xFF0000` 안의 0 이 `0xCC6699` 의 두 번째와 세 번째 바이트를 "가린 (mask)" 효과로, `6699` 는 무시하고 그 결과 `0xCC0000` 만 남도록 합니다.

그런 다음 이 수를 16 자리만큼 오른쪽 이동 (`>> 16`) 합니다. 16-진수 안의 각 문자 쌍은 8 비트를 사용해서, 오른쪽 16 자리 이동은 `0xCC0000` 을 `0x0000CC` 로 변환하게 됩니다. 이는 `0xCC` 와 똑같은 것으로, 10-진수 값은 `204` 입니다.

이와 비슷하게, 녹색 성분은 수치 값 `0xCC6699` 와 `0x00FF00` 를 비트 곱하여 구하며, 결과 값은 `0x006600` 입니다. 그런 다음 이 결과 값을 8 자리만큼 오른쪽 이동하면, `0x66` 이라는 값을 주는데, 10-진수 값은 `102` 입니다.

최종적으로, 파란색 성분은 수치 값 `0xCC6699` 와 `0x0000FF` 를 비트 곱하여 구하며, 결과 값은 `0x000099` 입니다. `0x000099` 는 이미 `0x99` 와 같은, 10-진수 값 `153` 를 갖기 때문에, 이 값은 오른쪽 이동 없이 사용합니다.

**Shifting Behavior for Signed Integers (부호있는 정수의 이동 동작)**

부호있는 정수의 이동 동작은, 부호있는 정수를 2-진수로 나타내는 방식 때문에, 부호없는 정수보다 더 복잡합니다. (아래 예제는 단순함을 위해 8-비트 부호있는 정수로 하고 있지만, 어떤 크기의 부호있는 정수든 작용 원리는 동일합니다.)

부호있는 정수는 (_부호 비트 (sign bit)_ 라는) 첫 번째 비트를 사용하여 정수가 양수인지 음수인지 지시합니다. 부호 비트가 `0` 이면 양수를 의미하고, 부호 비트가 `1` 이면 음수를 의미합니다.

(_값 비트 (value bits)_ 라는) 남은 비트가 실제 값을 저장합니다. 양수의 저장 방식은 부호없는 정수와 정확히 똑같아서, `0` 부터 위로 셉니다. `Int8` 안에 수치 값 `4` 가 있으면 비트가 이렇게 보입니다:

![signed positive 4](/assets/Swift/Swift-Programming-Language/Advanced-Operators-signed-positive-4.jpg)

부호 비트는 `0` 이고 ("양수 (positive)" 를 의미하며), 일곱 개의 값 비트는 그냥 수치 값 `4` 를, 2진 표기법으로 쓴겁니다.

음수는, 하지만, 다르게 저장합니다. `2` 의 `n` 제곱에서 자신의 절대 값을 뺀 걸[^two-s-complement] 로 저장하는데, 여기서 `n` 은 값 비트 개수입니다. 여덟-비트 수엔 값 비트가 일곱 개 있으므로, 이는 `2`의 `7` 제곱, 또는 `128` 을, 의미합니다.

`Int8` 안에 수치 값 `-4` 가 있으면 비트가 이렇게 보입니다:

![signed negative 4](/assets/Swift/Swift-Programming-Language/Advanced-Operators-signed-negative-4.jpg)

이번엔, 부호 비트가 `1` 이고 ("음수 (negative)" 를 의미하며), 일곱 개의 값 비트엔 2진 값 `124` (`128 - 4`) 가 있습니다:

![signed 124](/assets/Swift/Swift-Programming-Language/Advanced-Operators-signed-124.jpg)

음수를 이렇게 부호화 (encoding) 하는 걸 _2의 보수 (two's complement)_ 표현법이라 합니다. 이 방식은 음수를 특이하게 나타내는 것 같지만, 여러가지 장점이 있습니다.

첫 번째로, `-1` 과 `-4` 를 더하는 걸, 단순히 모든 (부호 비트를 포함한) 여덟 비트의 표준 이진 덧셈을 하고, 나서 여덟 비트에 들지 않는 어떤 것이든 버림으로써, 할 수 있다는 겁니다: 

![two complement negative addition](/assets/Swift/Swift-Programming-Language/Advanced-Operators-two-complement-negative-addtion.jpg)

두 번째로, 2의 보수 표현법은 음수 비트의 왼쪽 오른쪽 이동을 양수 같이 하게 해주며, 여전히 왼쪽 이동마다 두 배가 되고, 오른쪽 이동마다 반이 됩니다. 이를 달성하기 위해, 부호있는 정수의 오른쪽 이동 땐 부가 규칙을 사용하는데: 부호있는 정수를 오른쪽으로 이동할 땐, 부호없는 정수와 동일한 규칙을 적용하되, 왼쪽의 빈 자리를, `0` 보단, _부호 비트 (sign bit)_ 로 채운다는 겁니다.

![two complement negative shift](/assets/Swift/Swift-Programming-Language/Advanced-Operators-two-complement-negative-shift.jpg)

이런 행동은 부호있는 정수의 오른쪽 이동 후에도 부호가 동일하도록 보장하여, _산술 이동 (arithmetic shfit)_ 이라고 합니다.[^arithmetic-shift]

특수한 방식으로 양수와 음수를 저장하기 때문에, 오른쪽으로 이동하면 어느 것이든 더 `0` 에 가까워집니다. 이런 이동 중에 부호 비트를 동일하게 유지한다는 건 자신의 값이 `0` 에 가까워져도 음수는 음으로 남는다는 의미입니다.

### Overflow Operators (값 넘침 연산자)

수를 집어 넣으려는데 정수 상수나 변수가 그 값을 가질 수 없다면, 스위프트는 기본적으로 무효한 값을 생성하기 보단 에러를 보고합니다. 이 동작은 너무 크거나 작은 수를 다룰 때 부가적인 안전성을 줍니다.

예를 들어, `Int16` 정수 타입은 `-32768` 과 `32767` 사이의 어떤 부호있는 정수든 가질 수 있습니다. `Int16` 상수 또는 변수에 이 범위 밖의 수를 설정하려 하면 에러를 일으킵니다:

```swift
var potentialOverflow = Int16.max
// potentialOverflow 는, Int16 이 가질 수 있는 최대 값인, 32767 과 같음
potentialOverflow += 1
// 이는 에러를 일으킴
```

값이 너무 커지거나 작아질 때 에러 처리를 제공하면 경계 값 조건의 코딩 때 훨씬 더 많은 유연함을 줍니다.

하지만, 특히 사용할 수치 비트만 값 넘침 조건으로 잘라내고 싶을 때, 에러 발동 보단 이 동작을 직접 선택할 수 있습니다. 스위프트가 제공하는 세 개의 산술 _값 넘침 연산자 (overflow operators)_ 로 정수 계산에 대한 값 넘침 동작을 직접 선택합니다. 이 연산자는 모두 앰퍼샌드 (`&`) 로 시작합니다:

* 값 넘침 덧셈 (overflow addition; `&+`)
* 값 넘침 뺄셈 (overflow subtraction; `&-`)
* 값 넘침 곱셈 (overflow multiplication; `&*`)

#### Value Overflow (값 넘침)

수치 값은 양의 방향과 음의 방향 양쪽으로 넘칠 수 있습니다.

부호없는 정수가, 값 넘침 덧셈 연산자 (`&+`) 로, 양의 방향 값 넘침을 허용할 때 발생하는 일에 대한 예제는 이렇습니다:

```swift
var unsignedOverflow = UInt8.max
// unsignedOverflow 는, UInt8 이 가질 수 있는 최대 값인, 255 와 같음
unsignedOverflow = unsignedOverflow &+ 1
// unsignedOverflow 는 이제 0 과 같음
```

`unsignedOverflow` 변수를 `UInt8` 가 가질 수 있는 최대 값으로 (`255`, 또는 2-진수 `11111111` 로) 초기화합니다. 그런 다음 값 넘침 덧셈 연산자 (`&+`) 로 `1` 만큼 증가시킵니다. 이는 자신의 2진수 값을 `UInt8` 이 가질 수 있는 크기 위로 밀어내서, 아래 도표에 보는 것처럼, 경계 너머로 값이 넘치게 합니다. 값 넘침 덧셈 후 `UInt8` 경계 안에 남는 값은 `00000000`, 또는 `0` 입니다.

![value overflow 0](/assets/Swift/Swift-Programming-Language/Advanced-Operators-value-overflow-0.png)

부호없는 정수가 음의 방향 값 넘침을 허용할 때도 이와 비슷한 뭔가가 발생합니다. 값 넘침 뺄셈 연산자 (`&-`) 를 사용한 예제는 이렇습니다:

```swift
var unsignedOverflow = UInt8.min
// unsignedOverflow 는, UInt8 이 가질 수 있는 최소 값인, 0 과 같음
unsignedOverflow = unsignedOverflow &- 1
// unsignedOverflow 는 이제 255 임
```

`UInt8` 이 가질 수 있는 최소 값은 0, 또는 2-진수 `00000000` 입니다. 값 넘침 뺄셈 연산자 (`&-`) 로 `00000000` 에서 `1` 을 빼면, 수치 값이 넘쳐서 `11111111`, 또는 10-진수 `255` 로 넘어가게 (wrap around)[^wrap-around] 됩니다.

![value overflow 255](/assets/Swift/Swift-Programming-Language/Advanced-Operators-value-overflow-255.png)

부호있는 정수도 값 넘침이 일어납니다. 모든 부호있는 정수의 덧셈과 뺄셈은, [Bitwise Left and Right Shift Operators (비트 왼쪽-이동 및 오른쪽-이동 연산자)](#bitwise-left-and-right-shift-operators-비트-왼쪽-이동-및-오른쪽-이동-연산자) 에서 설명한 것처럼, 부호 비트도 덧셈 또는 뺄셈하는 수의 일부로 포함한, 비트 방식으로 합니다.

```swift
var signedOverflow = Int8.min
// signedOverflow 는, Int8 이 가질 수 있는 최소 값인, -128 과 같음
signedOverflow = signedOverflow &- 1
// signedOverflow 는 이제 127 과 같음
```

`Int8` 이 가질 수 있는 최소 값은 `-128`, 또는 2-진수 `10000000` 입니다. 이 2-진수에 값 넘침 연산자로 `1` 을 빼면 `01111111` 이라는 2-진수 값을 주는데, 이는 부호 비트를 반전하고, `Int8` 이 가질 수 있는 최대 양수 값인, 양의 `127` 입니다.

![value overflow 255](/assets/Swift/Swift-Programming-Language/Advanced-Operators-value-overflow-127.png)

부호있는 정수 및 부호없는 정수 둘 다, 양의 방향 값 넘침은 최대 유효 정수 값에서 최소 값으로 넘어가며, 음의 방향 값 넘침은 최소 값에서 최대 값으로 넘어갑니다.

### Precedence and Associativity (우선권과 결합성)

연산자 _우선권 (precedence)_ 은 일부 연산자에 다른 것보다 더 높은 우선 순위를 주며; 이 연산자를 먼저 적용합니다.

연산자 _결합성 (associativity)_[^associativity] 은 동일 우선권의 연산자를 서로-왼쪽부터 그룹짓거나, 오른쪽부터 그룹지어-묶는 방법을 정의합니다. 이는 “자신의 왼쪽 표현식과 결합한다”, 거나 “자신의 오른쪽 표현식과 결합한다” 는 의미로 생각하면 됩니다.

각 연산자의 우선권과 결합성을 고려하는 건 복합 표현식의 계산 순서를 알아낼 때 중요합니다. 예를 들어, 연산자 우선권은 왜 다음 표현식이 `17` 인지 설명합니다.

```swift
2 + 3 % 4 * 5
// 이는 17 과 같음
```

왼쪽에서 오른쪽으로 곧이곧대로 읽으면, 표현식 계산이 다음과 같다고 예상할 지 모릅니다:

* `2` 더하기 `3` 은 `5`
* `5` 를 `4` 로 나눈 나머지는 `1`
* `1` 곱하기 `5` 는 `5`

하지만, 실제 답은 `17` 이지, `5` 가 아닙니다. 더 높은-우선권인 연산자를 더 낮은-우선권인 것 앞에 평가합니다. 스위프트에선, C 처럼, 나머지 연산자 (`%`) 와 곱하기 연산자 (`*`) 의 우선 순위가 덧셈 연산자 (`+`) 보다 더 높습니다. 그 결과, 덧셈 전에 이 둘을 평가합니다.

하지만, 나머지와 곱셈의 우선권은 서로 _동일 (same)_ 합니다. 정확한 평가 순서를 알아 내려면, 그들의 결합성도 고려할 필요가 있습니다. 나머지와 곱셈 둘 다 자신의 왼쪽 표현식과 결합합니다. 이는 표현식 주위에, 왼쪽에서 시작하는, 암시적 괄호를 추가한다고 생각하면 됩니다:

```swift
2 + ((3 % 4) * 5)
```

`(3 % 4)` 는 `3` 이므로, 다음과 동치 (equivalent) 입니다:

```swift
2 + (3 * 5)
```

`(3 * 5)` 는 `15` 이므로, 다음과 동치입니다:

```swift
2 + 15
```

이 계산이 내는 최종 답은 `17` 입니다.

스위프트 표준 라이브러리가 제공한 연산자에 대한, 연산자 우선권 그룹과 결합성 설정의 완전한 목록을 포함한, 정보는, [Operator Declaration (연산자 선언)](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 항목을 보도록 합니다.

> 스위프트의 연산자 우선권과 결합성 규칙은 C 및 오브젝티브-C 의 것보다 단순하여 더 예측하기 쉽습니다. 하지만, 이는 C-기반 언어의 것과 정확히 똑같지는 않다는 의미이기도 합니다. 기존 코드를 스위프트로 이식할 땐 연산자가 여전히 의도대로 상호 작용하도록 보장하는데 주의하기 바랍니다.

### Operator Methods (연산자 메소드)

클래스와 구조체는 기존 연산자에 자신만의 구현을 제공할 수 있습니다. 이를 기존 연산자의 _중복 정의 (overloading)_ 라고 합니다.

아래 예제는 자신의 구조체에 산술 덧셈 연산자 (`+`) 를 구현하는 방법을 보여줍니다. 산술 덧셈 연산자는 연산 대상이 두 개이기 때문에 _이항 연산자 (binary operator)_ 이며 두 대상 사이에 있기 때문에 _중위 (infix)_[^infix] 연산자입니다.

예제는 2-차원 위치 벡터 `(x, y)` 를 위한 `Vector2D` 구조체를 정의하고, 뒤이어 `Vector2D` 구조체의 인스턴스를 서로 더하는 _연산자 메소드 (operator method)_ 를 정의합니다:

```swift
struct Vector2D {
  var x = 0.0, y = 0.0
}

extension Vector2D {
  static func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
  }
}
```

연산자 메소드는 `Vector2D` 에 대한 타입 메소드로 정의하며, 메소드 이름은 중복 정의한 연산자 (`+`) 와 일치합니다. 덧셈은 벡터의 핵심 동작이 아니기 때문에, 타입 메소드를 `Vector2D` 구조체의 주 선언부 보다는 `Vector2D` 의 익스텐션에서 정의합니다. 산술 덧셈 연산자가 이항 연산자이기 때문에, 이 연산자 메소드는 `Vector2D` 타입의 입력 매개 변수는 두 개 취하고, 역시 `Vector2D` 타입인, 단일 출력 값을 반환합니다.

이 구현 안의, 입력 매개 변수엔 `left` 와 `right` 라는 이름을 붙여서 `+` 연산자의 왼쪽과 오른쪽에 있을 `Vector2D` 인스턴스를 나타냅니다. 메소드가 반환한 새로운 `Vector2D` 인스턴스의, `x` 와 `y` 속성은 두 `Vector2D` 인스턴스에 있는 `x` 와 `y` 속성을 서로 더한 합계로 초기화됩니다.

타입 메소드를 기존 `Vector2D` 인스턴스 사이의 중위 연산자인 것처럼 사용할 수 있습니다:

```swift
let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector
// combinedVector 는 값이 (5.0, 5.0) 인 Vector2D 인스턴스임
```

이 예제는, 아래 묘사 처럼, 벡터 `(3.0, 1.0)` 과 `(2.0, 4.0)` 을 서로 더하여 벡터 `(5.0, 5.0)` 을 만듭니다.

![operator method](/assets/Swift/Swift-Programming-Language/Advanced-Operators-operator-method.png)

#### Prefix and Postfix Operators (접두사 및 접미사 연산자)

위에서 본 예제는 자신만의 중위 이항 연산자를 실제로 구현합니다. 클래스와 구조체는 표준 _단항 연산자 (unary operators)_ 도 구현할 수 있습니다. 단항 연산자는 단일 대상을 연산합니다. 자신의 대상 앞에 (`-a` 처럼) 있으면 _접두사 (prefix)_ 연산자이고 자신의 대상 뒤에 (`b!` 처럼) 있으면 _접미사 (postfix)_ 연산자입니다.

단항 접두사나 단항 접미사 연산자를 구현할 때는 연산자 메소드 선언의 `func` 키워드 앞에 `prefix` 나 `postfix` 수정자를 작성합니다:

```swift
extension Vector2D {
  static prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
  }
}
```

위 예제는 `Vector2D` 인스턴스의 단항 음수 연산자 (`-a`) 를 구현합니다. 단항 음수 연산자는 접두사 연산자라서, 이 메소드를 `prefix` 수정자로 규명 (qualified) 해야 합니다.[^qualified]

단순 수치 값에선, 단항 음수 연산자가 양수는 등가의 음수로 변환하고 그 반대도 마찬가지입니다. `Vector2D` 인스턴스에 해당하는 구현은 `x` 와 `y` 속성 둘 다에 이 연산을 수행합니다:

```swift
let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
// negative 는 값이 (-3.0, -4.0) 인 Vector2D 인스턴스임
let alsoPositive = -negative
// alsoPositive 는 값이 (3.0, 4.0) 인 Vector2D 인스턴스임
```

#### Compound Assignment Operators (복합 할당 연산자)

_복합 할당 연산자 (compound assignment operators)_ 는 할당 (`=`) 을 다른 연산과 조합합니다. 예를 들어, 덧셈 할당 연산자 (`+=`) 는 덧셈과 할당을 단일 연산으로 조합합니다. 복합 할당 연산자의 왼쪽 입력 매개 변수 타입은 `inout` 으로 표시하는데, 매개 변수 값을 연산자 메소드 안에서 직접 수정하기 때문입니다.

아래 예제는 `Vector2D` 인스턴스의 덧셈 할당 연산자 메소드를 구현합니다:

```swift
extension Vector2D {
  static func += (left: inout Vector2D, right: Vector2D) {
    left = left + right
    }
}
```

덧셈 연산자는 앞서 정의했기 때문에[^addition-earlier], 덧셈 과정을 여기서 다시 구현할 필요는 없습니다. 그 대신, 덧셈 할당 연산자 메소드는 기존 덧셈 연산자 메소드를 사용하여, 왼쪽 값과 오른쪽 값을 더한 걸 왼쪽 값으로 설정합니다:

```swift
var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd
// original 의 값은 이제 (4.0, 6.0) 임
```

> 기본 할당 연산자 (`=`) 를 중복 정의하는 건 불가능합니다. 복합 할당 연산자만 중복 정의할 수 있습니다. 이와 비슷하게, 삼항 조건 연산자 (`a ? : b : c`) 도 중복 정의할 수 없습니다.

#### Equivalence Operators (같음 비교 연산자)

기본적으로, 사용자가 정의한 클래스와 구조체는, _같음 (equal to)_ 연산자 (`==`) 와 _같지 않음 (not equal to)_ 연산자 (`!=`) 라는, _같음 비교 연산자 euivalence operators)_ 를 구현하지 않습니다. 대체로 `==` 연산자는 구현하고, `!=` 연산자는 표준 라이브러리의 기본 구현을 써서 `==` 연산자의 결과를 반대로 뒤집습니다. `==` 연산자 구현에는 두 가지 방법이 있는데: 스스로 구현할 수도, 또는 많은 타입들에서, 스위프트에 통합 구현을 요청할 수도 있습니다. 두 경우 모두, 표준 라이브러리의 `Equatable` 프로토콜을 준수하도록 추가합니다.

`==` 연산자의 구현 방식은 다른 중위 연산자의 구현과 똑같습니다:

```swift
extension Vector2D: Equatable { 
  static func == (left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
  }
}
```

위 예제는 `==` 연산자를 구현하여 두 `Vector2D` 인스턴스가 가진 값이 같은 것인 지를 검사합니다. `Vector2D` 상황에선, “같음 (equal)” 의 의미가 “인스턴스 둘 다 동일한 `x` 값과 `y` 값을 가진다” 고 고려하는 게 말이 되므로, 이 논리를 연산자 구현에서도 사용합니다.

이제 이 연산자를 사용하여 두 `Vector2D` 인스턴스가 같은 건지를 검사할 수 있습니다:

```swift
let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("These two vectors are equivalent.")
}
// "These two vectors are equivalent." 를 인쇄함
```

[Adopting a Protocol Using a Synthesized Implementation (통합 구현을 사용하여 프로토콜 채택하기)]({% post_url 2016-03-03-Protocols %}#adopting-a-protocol-using-a-synthesized-implementation-통합-구현을-사용하여-프로토콜-채택하기) 에서 설명한 것처럼, 수많은 단순한 경우에, 스위프트가 같음 비교 연산자의 통합 구현을 제공하도록 요청할 수 있습니다.

### Custom Operators (사용자 정의 연산자)

스위프트가 제공하는 표준 연산자에 더해 자신만의 _사용자 정의 연산자 (custom operators)_ 를 선언하고 구현할 수 있습니다. 자신만의 연산자 정의에 사용할 수 있는 문자 목록은, [Operators (연산자)]({% post_url 2020-07-28-Lexical-Structure %}#operators-연산자) 부분을 보도록 합니다.

새로운 연산자는 전역 수준에서 `operator` 키워드로 선언하며[^global-level], `prefix` 나, `infix`, 또는 `postfix` 수정자를 표시합니다:

```swift
prefix operator +++
```

위 예제는 `+++` 라는 새로운 접두사 연산자를 정의합니다. 이 연산자는 기존의 스위프트에선 없던 것이라서, `Vector2D` 인스턴스와 작업하는 특정 상황 하에서만 자신만의 의미를 가집니다. 이 예제 용으론, `+++` 를 새로 “두 배로 만드는 접두사 (prefix doubling)” 연산자로 취급합니다. 이는, 앞서 정의한 덧셈 할당 연산자로 벡터에 자신을 더하여, `Vector2D` 인스턴스의 `x` 와 `y` 값을 두 배로 만듭니다. `+++` 연산자를 구현하려면, 다음 처럼 `Vector2D` 에 `+++` 라는 타입 메소드를 추가합니다:

```swift
extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
// toBeDoubled 의 값은 이제 (2.0, 8.0) 임[^doubling]
// afterDoubling 의 값도 (2.0, 8.0) 임
```

#### Precedence for Custom Infix Operators (사용자 중위 연산자의 우선권)

사용자 중위 연산자 각각은 우선권 그룹에 속합니다. 우선권 그룹은 다른 중위 연산자와 상대적인 연산자의 우선권 뿐만 아니라, 연산자의 결합성도 지정합니다. [Precedence and Associativity (우선권과 결합성)](#precedence-and-associativity-우선권과-결합성) 을 보면 이러한 성질이 중위 연산자와 다른 중위 연산자의 상호 작용에 영향을 주는 방법을 설명합니다.

사용자 중위 연산자에 우선권 그룹을 명시하지 않으면 기본 우선권 그룹으로 삼항 조건 연산자 바로 위의 우선권을 줍니다.

다음 예제는 `+-` 라는 새로운 사용자 중위 연산자를 정의하는데, 이는 `AdditionPrecedence` 라는 우선권 그룹에 속합니다:

```swift
infix operator +-: AdditionPrecedence
extension Vector2D {
  static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y - right.y)
  }
}
let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
// plusMinusVector 는 값이 (4.0, -2.0) 인 Vector2D 인스턴스임
```

이 연산자는 두 벡터의 `x` 값은 서로 더하고, `y` 값은 첫 번째에서 두 번째 벡터 걸 뺍니다. 이는 본질적으로 "덧셈류 (additive)" 연산자이기 때문에, `+` 와 `-` 같은 덧셈류 중위 연산자와 동일한 우선권 그룹을 줬습니다. 스위프트 표준 라이브러리가 제공한, 연산자 우선권 그룹 및 결합성 설정에 대한 완전한 목록을 포함하는, 연산자 정보는, [Operators Declarations (연산자 선언)](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations-apple] 항목을 보도록 합니다. 우선권 그룹에 대한 더 많은 정보와 자신만의 연산자 및 우선권 그룹 정의 구문을 보려면, [Operator Declaration (연산자 선언)]({% post_url 2020-08-15-Declarations %}#operator-declaration-연산자-선언) 부분을 보도록 합니다.

> 접두사나 접미사 연산자를 정의할 땐 우선권을 지정하지 않습니다. 하지만, 동일한 피연산자에 접두사와 접미사 연산자를 둘 다 적용하면, 접미사 연산자가 먼저 적용됩니다.

### Result Builders (결과 제작자)

_결과 제작자 (result builder)_ 는, 자연스러운, 선언형 방식으로, 리스트나 트리 같은[^list-or-tree], 중첩 데이터 생성 구문을 추가하는 직접 정의하는 타입합니다. 결과 제작자를 사용한 코드는, `if` 와 `for` 같은, 평범한 스위프트 구문을 포함해서, 조건이나 데이터 조각의 반복을 처리할 수 있습니다.

아래 코드는 한 줄 위에 별과 글로 그림을 그리는 몇 가지 타입을 정의합니다.

```swift
protocol Drawable {
  func draw() -> String
}
struct Line: Drawable {
  var elements: [Drawable]
  func draw() -> String {
    return elements.map { $0.draw() }.joined(separator: "")
  }
}
struct Text: Drawable {
  var content: String
  init(_ content: String) { self.content = content }
  func draw() -> String { return content }
}
struct Space: Drawable {
  func draw() -> String { return " " }
}
struct Stars: Drawable {
  var length: Int
  func draw() -> String { return String(repeating: "*", count: length) }
}
struct AllCaps: Drawable {
  var content: Drawable
  func draw() -> String { return content.draw().uppercased() }
}
```

`Drawable` 프로토콜은, 선이나 도형 같이, 그릴 것에 대한 필수 조건을 정의하는데: 타입은 반드시 `draw()` 함수를 구현해야 합니다. `Line` 구조체는 단 한-줄짜리 그림을 나타내며, 대부분의 그림에서 최-상단 컨테이너[^container] 역할을 합니다. `Line` 을 그리고자, 구조체는 각 줄 (line) 성분의 `draw()` 를 호출한 다음, 결과 문자열을 단일 문자열로 이어붙입니다. `Text` 구조체는 문자열을 포장하여 그림으로 만듭니다. `AllCaps` 구조체는 또 다른 그림을 포장 및 수정하는데, 그림 안의 어떤 문장이든 대문자로 변환합니다.

이 타입들의 초기자를 호출하면 그림을 만드는게 가능합니다:

```swift
let name: String? = "Ravi Patel"
let manualDrawing = Line(elements: [
  Stars(length: 3),
  Text("Hello"),
  Space(),
  AllCaps(content: Text((name ?? "World") + "!")),
  Stars(length: 2),
  ])
print(manualDrawing.draw())
// "***Hello RAVI PATEL!**" 를 인쇄함
```

이 코드는 작동하지만, 조금 어색합니다. `AllCaps` 뒤에 깊게 중첩된 괄호는 이해하기 힘듭니다. `name` 이 `nil` 일 땐 "World" 를 사용하라는 대체 논리는 `??` 연산자를 써서 인라인으로 해야 하는데, 어떤 더 복잡한 걸 쓰든 어려울 겁니다. switch 나 `for` 반복문을 포함하여 그림을 제작할 필요가 있어도, 그럴 방법이 없습니다. 결과 제작자는 이와 같은 코드를 재작성하여 보통의 스위프트 코드 같이 보이게 해줍니다.

결과 제작자를 정의하려면, 타입 선언에 `@resultBuilder` 특성[^attribute] 을 씁니다. 예를 들어, 다음 코드는 `DrawingBuilder` 라는 결과 제작자를 정의하여, 선언형 구문으로 그림을 설명하게 해줍니다:

```swift
@resultBuilder
struct DrawingBuilder {
  static func buildBlock(_ components: Drawable...) -> Drawable {
    return Line(elements: components)
  }
  static func buildEither(first: Drawable) -> Drawable {
    return first
  }
  static func buildEither(second: Drawable) -> Drawable {
    return second
  }
}
```

`DrawingBuilder` 구조체는 결과 제작자 구문의 (각) 부분들을 구현하는 세 메소드를 정의합니다. `buildBlock(_:)` 메소드는 코드 블럭에 연속된 줄의 작성을 지원합니다. 이는 그 블럭 안의 성분들을 하나의 `Line` 으로 조합합니다. `buildEither(first:)` 와 `buildEither(second:)` 메소드는 `if`-`else` 문을 지원합니다.

함수 매개 변수에 `@DrawingBuilder` 특성을 적용하면, 함수에 전달한 클로저를 그 클로저를 써서 결과 제작자가 생성한 값으로 바꿀 수 있습니다. 예를 들어 다음과 같습니다:

```swift
func draw(@DrawingBuilder content: () -> Drawable) -> Drawable {
  return content()
}
func caps(@DrawingBuilder content: () -> Drawable) -> Drawable {
  return AllCaps(content: content())
}

func makeGreeting(for name: String? = nil) -> Drawable {
  let greeting = draw {
    Stars(length: 3)
    Text("Hello")
    Space()
    caps {
      if let name = name {
        Text(name + "!")
      } else {
        Text("World!")
      }
    }
    Stars(length: 2)
  }
  return greeting
}
let genericGreeting = makeGreeting()
print(genericGreeting.draw())
// "***Hello WORLD!**" 를 인쇄함

let personalGreeting = makeGreeting(for: "Ravi Patel")
print(personalGreeting.draw())
// "***Hello RAVI PATEL!**" 를 인쇄함
```

`makeGreeting(for:)` 함수는 `name` 매개 변수를 취하여 이로써 개인별 인사말을 그립니다. `draw(_:)` 와 `caps(_:)` 함수는 둘 다 자신의 인자로 단일 클로저를 취하며, 이를 `@DrawingBuilder` 특성으로 표시합니다. 이 함수들을 호출할 땐, `DrawingBuilder` 가 정의한 특수 구문을 사용합니다.[^greeting-draw] 스위프트는 선언형 그림 설명을 `DrawingBuilder` 에 있는 메소드로의 연속 호출로 변형하여 함수 인자로 전달한 값을 제작합니다. 예를 들어, 스위프트는 위 예제 안의 `caps(_:)` 호출 코드를 다음 같이 변형합니다:[^greeting-caps]

```swift
let capsDrawing = caps {
  let partialDrawing: Drawable
  if let name = name {
    let text = Text(name + "!")
    partialDrawing = DrawingBuilder.buildEither(first: text)
  } else {
    let text = Text("World!")
    partialDrawing = DrawingBuilder.buildEither(second: text)
  }
  return partialDrawing
}
```

스위프트는 `if`-`else` 블럭을 `buildEither(first:)` 와 `buildEither(second:)` 메소드 호출로 변형합니다. 자신의 코드에서 이 메소드들을 호출하지 않긴 하지만, 변형 결과를 보는 건 `DrawingBuilder` 구문을 사용할 때의 스위프트 코드 변형 방법을 더 알아보기 쉽게 합니다.

특수 그림 구문이 `for` 반복문 작성을 지원하게 하려면, `buildArray(_:)` 메소드를 추가합니다:

```swift
extension DrawingBuilder {
  static func buildArray(_ components: [Drawable]) -> Drawable {
    return Line(elements: components)
  }
}
let manyStars = draw {
  Text("Stars:")
  for length in 1...3 {
    Space()
    Stars(length: length)
  }
}
```

위 코드에서, `for` 반복문은 그림 배열을 생성하며, `buildArray(_:)` 메소드가 그 배열을 `Line` 으로 바꿉니다.

제작자 구문을 제작자 타입의 메소드 호출로 스위프트가 변형하는 방법에 대한 완전한 목록은, [resultBuilder]({% post_url 2020-08-14-Attributes %}#resultbuilder-결과-제작자) 부분을 보도록 합니다.

### 다음 장

[About the Language Reference (언어의 기준에 대하여) > ]({% post_url 2017-03-13-About-the-Language-Reference %})

### 참고 자료

[^Advanced-Operators]: 이 글에 대한 원문은 [Advanced Operators](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html) 에서 확인할 수 있습니다.

[^ampersand]: '앰퍼샌드 (ampersand; `&`)' 는 영어로 `and` 를 의미하는 라틴어의 `et` 에서 유래한 단어로 '앤드 기호' 라고도 합니다. 이에 대한 더 자세한 내용은, 위키피디아의 [Ampersand](https://en.wikipedia.org/wiki/Ampersand) 항목과 [앰퍼샌드](https://ko.wikipedia.org/wiki/앰퍼샌드) 항목을 보도록 합니다.

[^exclusive-or]: '배타적 논리 합 (exclusive OR)' 에 대한 더 자세한 내용은, 위키피디아의 [Exclusive or](https://en.wikipedia.org/wiki/Exclusive_or) 항목과 [배타적 논리합](https://ko.wikipedia.org/wiki/배타적_논리합) 항목을 보도록 합니다. 

[^factor]: '인수 (factor)' 는 수학 용어로, '정수 (integer) 나 수식 (equation)' 을 몇 개의 곱으로 나타냈을 때, 각각의 구성 요소를 말합니다. '인수 분해 (factorization)' 에서의 인수가 이것입니다. '인수 (factor)' 에 대한 더 자세한 정보는, 위키피디아의 [Factor (mathematics)](https://en.wikipedia.org/wiki/Factor#Mathematics) 항목과 [인수](https://ko.wikipedia.org/wiki/인수) 항목을 보도록 합니다. 요즘에는 '인수' 보다 [약수](https://ko.wikipedia.org/wiki/약수) ([divisor](https://en.wikipedia.org/wiki/Divisor)) 라는 말을 더 많이 사용하는 것 같습니다.

[^CSS]: 원문은 'Cascading Style Sheets' 라고 되어 있는데, CSS 라는 줄임말이 더 유명하며 이해하기 쉬울 것입니다. 'CSS' 에 대한 더 자세한 정보는, 위키피디아의 [Cascading Style Sheets](https://en.wikipedia.org/wiki/Cascading_Style_Sheets) 항목과 [종속형 시트](https://ko.wikipedia.org/wiki/종속형_시트) 항목을 보도록 합니다.

[^two-s-complement]: `2` 의 `n` 제곱에서 자신의 절대 값을 뺀 걸 '2의 보수 (two's complement)' 라고 합니다. 2의 보수를 사용하면, `0` 의 표현 방식을 한 가지로 통일할 수 있으며, 사칙 연산도 자연스러워집니다. 2의 보수에 대한 더 자세한 정보는, 위키피디아의 [Two's complement](https://en.wikipedia.org/wiki/Two%27s_complement) 항목과 [2의 보수](https://ko.wikipedia.org/wiki/2의_보수) 항목을 보도록 합니다.

[^arithmetic-shift]: '산술 이동 (arithmetic shift)' 에 대한 더 자세한 내용은, 위키피디아의 [Arithmetic shift](https://en.wikipedia.org/wiki/Arithmetic_shift) 항목과 [산술 시프트](https://ko.wikipedia.org/wiki/산술_시프트) 항목을 보도록 합니다.

[^wrap-around]: 컴퓨터 용어로 'wrap around' 는 `0, 1, 2 ... 9, 0, 1 ... 9, 0, ...` 처럼 최대 값을 넘어선 수들이 다시 처음부터 되풀이되는 걸 말합니다. 'wrap around' 에 대한 더 자세한 정보는, 위키피디아의 [Integer overflow](https://en.wikipedia.org/wiki/Integer_overflow) 항목을 보도록 합니다.

[^associativity]: 스위프트의 '결합성 (associativity)' 은 수학 분야에 있는 '결합 법칙 (associative law)' 과 관련이 있습니다. 결합 법칙에 대한 더 자세한 내용은, 위키피디아의 [Associative property](https://en.wikipedia.org/wiki/Associative_property) 항목과 [결합법칙](https://ko.wikipedia.org/wiki/결합법칙) 항목을 보도록 합니다.

[^operator-declarations]: 원문 자체가 '애플 개발자 문서' 로 연결된 링크입니다.

[^infix]: '중위 (infix)' 는 '중간에 위치한다' 라는 말을 줄인 것으로, 수학에서 사용하는 용어입니다. '중위 (infix)' 에 대한 더 자세한 정보는, 위키피디아의 [Infix notation](https://en.wikipedia.org/wiki/Infix_notation) 항목과 [중위 표기법](https://ko.wikipedia.org/wiki/중위_표기법) 항목을 보도록 합니다. 

[^qualified]: '규명 (qualifed) 해야 한다' 는 건 자신의 소속을 알려야 한다는 의미입니다. 규명하다는 것에 대한 더 자세한 내용은, [Nested Types (중첩 타입)]({% post_url 2017-03-03-Nested-Types %}) 장의 [Referring to Nested Types (중첩 타입 참조하기)](#referring-to-nested-types-중첩-타입-참조하기) 부분에 있는 주석을 보도록 합니다.

[^addition-earlier]: [Operator Methods (연산자 메소드)](#operator-methods-연산자-메소드) 부분에서 구현한 것을 그대로 사용합니다. 스위프트 프로그래밍 언어 책의 예제는 각각의 장별로 내용이 이어집니다.

[^global-level]: 실제 정의와는 별도로 전역 수준에서 따로 선언도 해야 한다는 의미입니다.

[^doubling]: `+++` 는 '단항 접두사 연산자' 이므로, `toBeDoubled` 만 두 배로 만듭니다. 이어서 이 `toBeDoubled` 를 `afterDoubled` 에 할당함으로써 `afterDoubled` 가 `toBeDoubled` 와 같은 값을 가지게 됩니다.

[^operator-declarations-apple]: 원문 자체가 '애플 개발자 문서' 로 가는 링크로 되어 있습니다.

[^list-or-tree]: '리스트 (list) 와 트리 (tree)' 자료 구조에 대한 더 자세한 정보는, 위키피디아의 [Linked list](https://en.wikipedia.org/wiki/Linked_list) 항목 및 [연결 리스트](https://ko.wikipedia.org/wiki/연결_리스트) 그리고 [Tree (data structure)](https://en.wikipedia.org/wiki/Tree_(data_structure)) 항목 및 [트리 구조](https://ko.wikipedia.org/wiki/트리_구조) 항목을 보도록 합니다.

[^attribute]: '특성 (attribute)' 에 대한 더 자세한 내용은, [Attributes (특성)]({% post_url 2020-08-14-Attributes %}) 장을 보도록 합니다.

[^greeting-draw]: `makeGreeting` 함수 안에서 `draw { ... }` 부분과 `caps { ... }` 부분이 이 함수들을 호출하는 부분이며, 이 때 `DrawingBuilder` 가 정의한 특수 구문을 사용하게 됩니다.

[^greeting-caps]: `makeGreeting` 함수 안에서 `caps { ... }` 부분을 본문 아래 처럼 변형한다는 의미입니다.

[^container]: 여기서의 '컨테이너 (container)' 는 자료 구조 타입을 의미합니다. 예제에 있는 `List` 구조체도 그리기 가능한 원소들을 `[Drawable]` 처럼 배열로 담고 있습니다. 컨테이너에 대한 더 자세한 정보는, 위키피디아의 [Container (abstract data type)](https://en.wikipedia.org/wiki/Container_(abstract_data_type) 항목을 보도록 합니다.
