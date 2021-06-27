---
layout: post
comments: true
title:  "Swift 5.5: Advanced Operators (고급 연산자)"
date:   2020-05-11 10:00:00 +0900
categories: Swift Language Grammar Advanced Operator
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Advanced Operators](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html) 부분[^Advanced-Operators]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Advanced Operators (고급 연산자)

[Basic Operators (기초 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 에서 설명한 연산자에 더하여, 스위프트는 더 복잡한 값을 조작하는 여러 가지의 고급 연산자를 제공합니다. 이는 C 와 오브젝티브-C 에서 익숙할 모든 '비트 (bitwise) 연산자' 와 '비트 이동 (bit shifting) 연산자' 를 포함합니다.

C 의 '산술 (arithmetic) 연산자' 와는 달리, 스위프트의 산술 연산자는 기본적으로 '값이 넘치지 (overflow)' 않습니다. '값 넘침 (overflow) 동작' 은 '덫으로 잡아서 (trapped)' 에러로 보고합니다. '값 넘침 동작' 을 직접 선택하려면, '값 넘침 더하기 연산자 (`&+`)' 같은, 기본적으로 '값이 넘치는' 스위프트의 '추가 산술 연산자 집합' 을 사용합니다. 이 모든 '값 넘침 연산자' 들은 '앤드 기호 (ampersand; `&`)' 로 시작합니다.

자신만의 구조체, 클래스, 그리고 열거체를 정의할 때는, 사용자 정의 타입에 대한 자신만의 표준 스위프트 연산자를 구현하는 것이 유용할 수 있습니다. 스위프트는 이 연산자들의 맞춤형 구현과 각 생성 타입에 대해 이들이 무슨 동작을 해야하는 지를 쉽게 결정할 수 있게 해줍니다.

'미리 정의된 연산자' 로 제한하지 않습니다. 스위프트는, '사용자 정의 우선 순위 (precedence)' 와 '결합성 (associativity)' 을 가진, 자신만의 사용자 정의 '중위 (infix)', '접두사 (prefix)', '접미사 (postfix)', 그리고 '할당 (assignment) 연산자' 를 정의하는 자유를 줍니다. 이 연산자들은 다른 어떤 '미리 정의된 연산자' 와 마찬가지로 코드에서 채택하고 사용할 수 있으며, 심지어 기존 타입을 확장하여 자신이 정의한 사용자 정의 연산자를 지원하게 할 수도 있습니다.

### Bitwise Operators (비트 연산자)

_비트 연산자 (bitwise operators)_ 는 자료 구조 안에 있는 '개별 원시 데이터 비트' 를 조작하도록 해줍니다. 이들은 종종, '그래픽 (graphic) 프로그래밍' 과 '장치 드라이버 (device driver) 생성' 같은, 저-수준 프로그래밍에서 사용합니다. '비트 연산자' 는, 사용자 정의 프로토콜을 사용한 통신에서의 '데이터 부호화 (encoding)' 및 '복호화 (decoding)' 같은, 외부 소스의 '원시 데이터' 와 작업할 때도 유용할 수 있습니다.

스위프트는, 아래에서 설명하는 것처럼, C 에 있는 모든 '비트 연산자' 를 지원합니다.

#### Bitwise NOT Operator (비트 부정 연산자)

_비트 부정 연산자 (bitwise NOT operator;_ `~`_)_ 는 수치 값의 모든 비트를 거꾸로 만듭니다:

![bitwise-NOT-operator](/assets/Swift/Swift-Programming-Language/Advanced-Operators-bitwise-NOT-operator.jpg)

'비트 부정 연산자' 는 '접두사 (prefix) 연산자' 이며, 어떤 공백도 없이, 연산할 값 바로 앞에 나타납니다:

```swift
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits   // 11110000 과 같습니다.
```

`UInt8` 정수는 '8-비트' 이며 `0` 에서 `255` 사이의 어떤 값이든 저장할 수 있습니다. 이 예제는 `UInt8` 정수를, 처음 '네 비트' 는 `0` 으로 설정하고, 다음 '네 비트' 는 `1` 로 설정하는, 이진 값 `00001111` 로 초기화합니다. 이는 10-진수 값으로 `15` 와 같습니다.

그런 다음 '비트 부정 연산자' 를 사용하여, `initialBits` 와 똑같지만, 모든 비트를 거꾸로 만든, `invertedBits` 라는 새로운 상수를 생성합니다. '0' 은 '1' 이 되고, '1' 은 '0' 이 됩니다. `invertedBits` 의 값은, 부호없는 10-진수 값으로 `240` 인, `11110000` 입니다.

#### Bitwise AND Operator (비트 곱 연산자)

_비트 곱 연산자 (bitwise AND operator;_ `&`_)_ 는 두 수치 값의 비트를 조합합니다. 이는 입력 수치 값의 비트가 _둘 다 (both)_ `1` 일 때만 비트를 `1` 로 설정한 새로운 수치 값을 반환합니다:

![bitwise-AND-operator](/assets/Swift/Swift-Programming-Language/Advanced-Operators-bitwise-AND-operator.jpg)

아래 예제에서, `firstSixBits` 와 `lastSixBits` 의 값은 둘 다 `1` 이라는 '네 개의 중간 비트' 를 가집니다. '비트 곱 연산자' 는 이들을 조합하여, 부호없는 십진수 값으로 `60` 인, 수치 값 `00111100` 을 만듭니다:

```swift
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits // 00111100 과 같습니다.
```

#### Bitwise OR Operator (비트 합 연산자)

_비트 합 연산자 (bitwise OR operator;_ `|`_)_ 는 두 수치 값의 비트를 비교합니다. 연산자는 입력 수치 값 비트가 _어느 것 (either)_ 이든 `1` 이면 비트를 `1` 로 설정한 새로운 수치 값을 반환합니다:

![bitwise-OR-operator](/assets/Swift/Swift-Programming-Language/Advanced-Operators-bitwise-OR-operator.jpg)

아래 예제에서, `someBits` 와 `moreBits` 의 값은 서로 다른 '비트 집합' 의 `1` 을 가집니다. '비트 합 연산자' 는 이들을 조합하여, 부호없는 10-진수 값으로 `254` 인, 수치 값 `11111110` 을 만듭니다:

```swift
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedBits = someBits | moreBits // 11111110 과 같습니다.
```

#### Bitwise XOR Operator (비트 배타 연산자)

_비트 배타 연산자 (bitwise XOR operator)_, 또는 "배타적 논리 합 연산자 (exclusive OR operator; `^`)" 는, 두 수치 값의 비트를 비교합니다. 연산자는 입력 비트들이 다르면 비트를 `1` 로 설정하고 입력 비트들이 같으면 `0` 으로 설정한 새로운 수치 값을 반환합니다:

![bitwise-XOR-operator](/assets/Swift/Swift-Programming-Language/Advanced-Operators-bitwise-XOR-operator.jpg)

아래 예제에서, `firstBits` 와 `otherBits` 값은 각각 서로 다른 위치에서 `1` 로 설정된 비트를 가집니다. '비트 배타 연산자' 는 '출력 값' 에서  이 이 비트를 둘 다 `1` 로 설정합니다. `firstBits` 와 `otherBits` 에서 일치하는 모든 다른 비트들은 '출력 값' 에서 `0` 으로 설정합니다:

```swift
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits // 00010001 과 같습니다.
```

#### Bitwise Left and Right Shift Operators (비트 왼쪽-이동 및 오른쪽-이동 연산자)

_비트 왼쪽 이동 연산자 (bitwise left shift operator;_ `<<`_)_ 와 _비트 오른쪽-이동 연산자 (bitwise right shift operator;_ `>>`_)_ 는, 아래 정의한 규칙에 따라, 수치 값의 모든 비트를 정해진 수의 자리만큼 왼쪽 또는 오른쪽으로 이동합니다.

비트 왼쪽 및 오른쪽 이동은 정수를 '2' 라는 '인수 (factor)'[^factor] 로 곱하거나 나누는 효과를 가집니다. 정수 비트의 위치를 왼쪽으로 하나 이동하는 것은 값을 두 배로 만드는 반면, 위치를 오른쪽으로 하나 이동하는 것은 값을 반으로 만듭니다.

**Shifting Behavior for Unsigned Integers ('부호없는 정수' 의 이동 동작)**

'부호없는 정수' 의 '비트-이동 동작' 은 다음과 같습니다:

1. 기존 비트는 요청한 수의 위치만큼 왼쪽 또는 오른쪽으로 이동합니다.
2. 정수 저장 공간의 경계 너머로 이동하는 어떤 비트든 버립니다.
3. 원본 비트를 왼쪽 또는 오른쪽으로 이동한 후 남은 공간은 `0` 을 집어 넣습니다.

이 접근 방식을 _논리적 이동 (logical shift)_ 이라고 합니다.

아래 묘사는 (`11111111` 을 `1` 위치 만큼 왼쪽으로 이동하는) `11111111 << 1` 과, (`11111111` 을 `1` 위치 만큼 오른쪽으로 이동하는) `11111111 >> 1` 의 결과를 보여줍니다. 파란색 숫자는 이동한 것이고, 회색 숫자는 버린 것이며, 주황색 `0` 은 집어 넣은 것입니다:

![shifting behavior for unsigned integer](/assets/Swift/Swift-Programming-Language/Advanced-Operators-shifting-behavior-for-unsigned.png)

다음은 '비트 이동' 방법을 스위프트 코드로 보인 것입니다:

```swift
let shiftBits: UInt8 = 4    // 00000100 (2-진수 표현)
shiftBits << 1              // 00001000
shiftBits << 2              // 00010000
shiftBits << 5              // 10000000
shiftBits << 6              // 00000000
shiftBits >> 2              // 00000001
```

'비트 이동' 을 사용하여 다른 데이터 타입의 값을 '부호화 (encoding)' 하고 '복호화 (decoding)' 할 수 있습니다:

```swift
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16    // redComponent 는 0xCC, 또는 204 입니다.
let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent 는 0x66, 또는 102 입니다.
let blueComponent = pink & 0x0000FF           // blueComponent 는 0x99, 또는 153 입니다.
```

이 예제는 '핑크 색' 에 대한 'CSS 값'[^CSS] 을 저장하는 `pink` 라는 `UInt32` 상수를 사용합니다. 'CSS 색상 값 `#CC6699`' 을 스위프트 '16-진수 표현' 으로 작성하면 `0xCC6699` 입니다. 그런 다음 '비트 곱 연산자 (`&`)' 와 '비트 오른쪽 이동 연산자 (`>>`)' 가 이 색을 '빨간색 (`CC`)', '녹색 (`66`)', 그리고 '파란색 (`99`) 성분' 으로 분해합니다.

'빨간색 성분' 은 `0xCC6699` 와 `0xFF0000` 라는 수를 '비트 곱' 하여 구합니다. `0xFF0000` 에 있는 `0` 들은 `0xCC6699` 의 두 번째와 세 번째 '바이트 (bytes)' 를 효과적으로 "숨겨서 (mask)", `6699` 는 무시하고 결과적으로 `0xCC0000` 만 남도록 합니다.

그런 다음 이 수를 '16 자리' 만큼 오른쪽으로 이동 (`>> 16`) 합니다. 16-진수에서 각각의 문자 쌍은 '8 비트' 를 사용하므로, 오른쪽으로 '16 자리' 이동하는 것은 `0xCC0000` 을 `0x0000CC` 로 변환할 것입니다. 이는, 10-진수 값이 `204` 인, `0xCC` 와 똑같습니다.

이와 비슷하게, '녹색 성분' 은 `0xCC6699` 와 `0x00FF00` 라는 수를 '비트 곱' 하여 구하는데, 결과 값은 `0x006600` 입니다. 그런 다음 이 결과 값을 '8 자리' 만큼 오른쪽으로 이동하면, 10-진수 값이 `102` 인, `0x66` 이라는 값을 줍니다.

최종적으로, '파란색 성분' 은 `0xCC6699` 와 `0x0000FF` 라는 수를 '비트 곱' 하여 구하는데, 결과 값은 `0x000099` 입니다. `0x000099` 는, 10-진수 값이 `153` 인, `0x99` 와 이미 같기 때문에, 오른쪽 이동 없이 이 값을 사용합니다.

**Shifting Behavior for Signed Integers ('부호있는 정수' 의 이동 동작)**

'부호있는 정수' 의 이동 동작은, '부호있는 정수' 를 2-진수로 표현하는 방식 때문에, '부호없는 정수' 보다 더 복잡합니다. (아래 예제는 문제를 단순하게 하려고 '8-비트 부호있는 정수' 에 기초하고 있지만, 어떤 크기의 '부호있는 정수' 에도 똑같은 원리가 적용됩니다.)

'부호있는 정수' 는 정수가 양수인지 음수인지 지시하기 위해 (_부호 비트 (sign bit)_ 라고 하는) 첫 번째 비트를 사용합니다. `0` 이라는 부호 비트는 양수를 의미하고, `1` 이라는 부호 비트는 음수를 의미합니다.

(_값 비트 (value bits)_ 라고 하는) 나머지 비트들이 실제 값을 저장합니다. 양수는, `0` 부터 위로 세는, '부호없는 정수' 와 정확하게 똑같은 방식으로 저장합니다. 다음은 `Int8` 안의 비트로 `4` 를 저장하는 방법입니다:

![signed positive 4](/assets/Swift/Swift-Programming-Language/Advanced-Operators-signed-positive-4.jpg)

부호 비트는 ("양수 (positive)" 를 의미하는) `0` 이며, 7 개의 값 비트들은 그냥, 2-진 표기법으로 작성된, `4` 라는 수입니다.

하지만, 음수는 다르게 저장합니다. 이는 `2` 의 `n` 제곱에서 자신의 절대 값을 뺀 값으로 저장되는데, 여기서 `n` 은 값 비트의 개수입니다.[^two-s-complement] '8-비트 수' 는 '7 개의 값 비트' 를 가지므로, 이는 `2`의 `7` 제곱, 또는 `128` 을, 의미합니다.

다음은 `Int8` 안의 비트로 `-4` 를 저장하는 방법입니다:

![signed negative 4](/assets/Swift/Swift-Programming-Language/Advanced-Operators-signed-negative-4.jpg)

이번에는, 부호 비트가 ("음수 (negative)" 를 의미하는) `1` 이며, 7 개의 값 비트들은 (`128 - 4` 인) `124` 의 '2-진 값' 을 가집니다:

![signed 124](/assets/Swift/Swift-Programming-Language/Advanced-Operators-signed-124.jpg)

음수에 대한 이런 '부호화' 를 '_2의 보수 (two's complement)_ 표현' 이라고 합니다. 특이한 방식으로 음수를 표현하는 것 같지만, 이는 여러 장점을 가지고 있습니다.

첫 번째로, `-1` 과 `-4` 를, 단순히 (부호 비트를 포함한) 모든 8 비트 '표준 이진 더하기' 를 한 후, 8 비트 안에 맞지 않는 어떤 것이든 버림으로써, 더할할 수 있다는 것입니다: 

![two complement negative addition](/assets/Swift/Swift-Programming-Language/Advanced-Operators-two-complement-negative-addtion.jpg)

두 번째로, '2의 보수 표현' 은 음수 비트의 왼쪽 오른쪽 이동을 양수 같이 할 수 있게 해주며, 여전히 왼쪽으로 이동할 때마다 두 배 증가하고, 오른쪽으로 이동할 때마다 반으로 나누는 식으로 끝맺습니다. 이를 달성하기 위해, '부호있는 정수' 를 오른쪽으로 이동할 때는, 부가적인 규칙을 사용합니다: '부호있는 정수' 를 오른쪽으로 이동할 때는, '부호없는 정수' 와 똑같은 규칙을 적용하지만, 왼쪽에 남은 '빈 자리' 를, `0` 보다는, _부호 비트 (sign bit)_ 로 채웁니다.

![two complement negative shift](/assets/Swift/Swift-Programming-Language/Advanced-Operators-two-complement-negative-shift.jpg)

이 행동은, _산술 이동 (arithmetic shfit)_ 이라고 하는데, '부호있는 정수' 가 오른쪽으로 이동한 후에도 똑같은 부호를 가지도록 보장합니다.[^arithmetic-shift]

양수와 음수를 저장하는 특수한 방식 때문에, 어느 것이든 오른쪽으로 이동하면 점점 더 `0` 에 가까워집니다. 이 이동 중에 부호 비트를 똑같이 유지한다는 것은 음수 값이 `0` 에 가까워지더라도 음의 정수는 음수로 남는다는 의미입니다.

### Overflow Operators (값 넘침 연산자)

해당 값을 쥘 수 없는 정수 상수나 변수에 수를 집어 넣으려고 하면, 기본적으로 스위프트는 무효한 값을 생성하기 보다는 에러를 보고합니다. 이런 동작은 너무 크거나 작은 수와 작업할 때 부가적인 안전성을 부여합니다.

예를 들어, `Int16` 정수 타입은 `-32768` 과 `32767` 사이의 어떤 '부호있는 정수' 든 쥘 수 있습니다. `Int16` 상수나 변수에 이 범위를 밖의 수를 설정하려고 하면 에러를 일으킵니다:

```swift
var potentialOverflow = Int16.max
// potentialOverflow 는, Int16 이 쥘 수 있는 최대 값인, 32767 입니다.
potentialOverflow += 1
// 이는 에러를 일으킵니다.
```

값이 너무 크거나 작을 때 '에러 처리' 를 제공하면 '경계 값 조건' 을 코딩할 때 훨씬 더 큰 유연함을 부여합니다.

하지만, 특히 '값 넘침 조건' 으로 수에서 사용 가능한 비트만 잘라내고 싶을 때는, 에러를 발동하기 보다는 직접 이런 동작을 선택할 수도 있습니다. 스위프트는 정수 계산을 위한 '값 넘침 동작' 을 직접 선택하는 세 개의 산술 _값 넘침 연산자 (overflow operators)_ 를 제공합니다. 이 연산자들은 모두 '앤드 기호 (ampersand; `&`)' 로 시작합니다:

* 값 넘침 더하기 (overflow addition; `&+`)
* 값 넘침 빼기 (overflow subtraction; `&-`)
* 값 넘침 곱하기 (overflow multiplication; `&*`)

#### Value Overflow (값 넘침)

수는 양의 방향과 음의 방향 둘 다로 넘칠 수 있습니다.

다음은, '값 넘침 더하기 연산자 (`&+`)' 로, '부호없는 정수' 가 양의 방향 값 넘침을 허용할 때 발생하는 일에 대한 예제입니다:

```swift
var unsignedOverflow = UInt8.max
// unsignedOverflow 는, UInt8 이 쥘 수 있는 최대 값인, 255 입니다.
unsignedOverflow = unsignedOverflow &+ 1
// unsignedOverflow 는 이제 0 입니다.
```

`unsignedOverflow` 변수는 `UInt8` 이 쥘 수 있는 최대 값 (`255`, 또는 2-진수 `11111111`) 으로 초기화됩니다. 그런 다음 '값 넘침 더하기 연산자 (`&+`)' 가 이를 `1` 만큼 증가합니다. 이는 `UInt8` 이 쥘 수 있는 크기 바로 너머로 '2-진 표현' 을 밀어서, 아래 도표에 보인 것처럼, 경계 너머로 값이 넘치도록 합니다. '값 넘침 더하기' 후에 `UInt8` 경계 안에 남는 값은 `00000000`, 또는 `0` 입니다.

![value overflow 0](/assets/Swift/Swift-Programming-Language/Advanced-Operators-value-overflow-0.png)

이와 비슷한 일이 '부호없는 정수' 가 음의 방향 값 넘침을 허용할 때도 발생합니다. 다음은 '값 넘침 빼기 연산자 (`&-`)' 를 사용하는 예제입니다:

```swift
var unsignedOverflow = UInt8.min
// unsignedOverflow 는, UInt8 이 쥘 수 있는 최소 값인, 0 입니다.
unsignedOverflow = unsignedOverflow &- 1
// unsignedOverflow 는 이제 255 입니다.
```

`UInt8` 이 쥘 수 있는 최소 값은 '0', 또는 2-진수로 `00000000` 입니다. '값 넘침 빼기 연산자 (`&-`)' 로 `00000000` 에서 `1` 을 빼면, 수는 값이 넘쳐서 `11111111`, 또는 10-진수 `255` 로 '되돌아 갈 (wrap around)'[^wrap-around] 것입니다.

![value overflow 255](/assets/Swift/Swift-Programming-Language/Advanced-Operators-value-overflow-255.png)

'값 넘침' 은 '부호있는 정수' 에서도 일어납니다. 모든 부호있는 정수의 더하기와 빼기는, [Bitwise Left and Right Shift Operators (비트 왼쪽-이동 및 오른쪽-이동 연산자)](#bitwise-left-and-right-shift-operators-비트-왼쪽-이동-및-오른쪽-이동-연산자) 에서 설명한 것처럼, 부호 비트도 더하거나 빼는 수인 것처럼 포함하는, '비트 방식' 으로 수행합니다.

```swift
var signedOverflow = Int8.min
// signedOverflow 는, Int8 이 쥘 수 있는 최소 값인, -128 입니다.
signedOverflow = signedOverflow &- 1
// signedOverflow 는 이제 127 입니다.
```

`Int8` 이 쥘 수 있는 최소 값은 `-128`, 또는 2-진수로 `10000000` 입니다. '값 넘침 연산자' 로 이 2-진수에서 `1` 을 빼면, 부호 비트는 전환하고, `Int8` 이 쥘 수 있는 최대 양수 값인, 양수 `127` 을 부여하여, `01111111` 이라는 2-진수 값을 줍니다.

![value overflow 255](/assets/Swift/Swift-Programming-Language/Advanced-Operators-value-overflow-127.png)

'부호있는 정수' 와 '부호없는 정수' 둘 다에서, '양의 방향 값 넘침' 은 '최대 유효 정수 값' 이 '최소 값' 으로 되돌아 가며, '음의 방향 값 넘침' 은 '최소 값' 이 '최대 값' 으로 되돌아 갑니다.

### Precedence and Associativity (우선 순위와 결합성)

연산자 _우선 순위 (precedence)_ 는 일부 연산자에 다른 것보다 더 높은 '우선권' 을 줍니다; 이 연산자들이 먼저 적용됩니다.

연산자 _결합성 (associativity)_[^associativity] 은 똑같은 우선 순위의 연산자들을-왼쪽부터든, 아니면 오른쪽부터든-서로 그룹짓는 방법을 정의합니다. “이들은 왼쪽에 있는 표현식과 결합한다”, 또는 “이들은 오른쪽에 있는 표현식과 결합한다” 라는 의미로 생각하면 됩니다.

복합 표현식을 계산할 순서를 알아낼 때 각각의 연산자 우선 순위와 결합성을 고려하는 것이 중요합니다. 예를 들어, 연산자 우선 순위는 다음 표현식이 `17` 인 이유를 설명합니다.

```swift
2 + 3 % 4 * 5
// 이는 17 입니다.
```

왼쪽에서 오른쪽으로 곧이곧대로 읽으면, 표현식을 다음 처럼 계산한다고 예상할 수도 있습니다:

* `2` 더하기 `3` 은 `5`
* `5` 를 `4` 로 나눈 나머지는 `1`
* `1` 곱하기 `5` 는 `5`

하지만, 실제 답은, `5` 가 아닌, `17` 입니다. '더 높은-우선 순위 연산자' 를 '더 낮은-우선 순위' 보다 먼저 평가합니다. 스위프트에서는, C 처럼, '나머지 연산자 (`%`)' 와 '곱하기 연산자 (`*`)' 가 '더하기 연산자 (`+`) 보다 더 높은 우선 순위를 가집니다. 그 결과, 더하기를 하기 전에 이 둘을 먼저 평가합니다.

하지만, '나머지' 와 '곱하기' 는 서로 _똑같은 (same)_ 우선 순위를 가집니다. 정확한 평가 순서를 알아 내려면, 이들의 '결합성' 도 고려해야 합니다. '나머지' 와 '곱하기' 둘 다 왼쪽에 있는 표현식과 결합합니다. 이는 표현식 주위에, 왼쪽에서 시작하는, '암시적인 괄호' 를 추가하는 것처럼 생각하면 됩니다:

```swift
2 + ((3 % 4) * 5)
```

`(3 % 4)` 는 `3` 이므로, 다음과 '동치 (equivalent)' 입니다:

```swift
2 + (3 * 5)
```

`(3 * 5)` 는 `15` 이므로, 다음과 동치입니다:

```swift
2 + 15
```

이 계산은 최종 답으로 `17` 을 산출합니다.

'연산자 우선 순위 그룹' 과 '결합성 설정' 의 완전한 목록을 포함하여, '스위프트 표준 라이브러리' 에서 제공하는 연산자에 대한 정보는, [Operator Declaration (연산자 선언)](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations] 을 참고하기 바랍니다.

> 스위프트의 '연산자 우선 순위와 결합성 규칙' 은 C 와 오브젝티브-C 에 있는 것보다 더 간단하며 더 예측 가능합니다. 하지만, 이는 곧 'C-기반 언어' 에 있는 것과 정확하게 똑같지는 않다는 것을 의미힙니다. 기존 코드를 스위프트로 이식할 때는 '연산자 상호 작용' 이 의도대로 여전히 동작하도록 보장하는데 주의하기 바랍니다.

### Operator Methods (연산자 메소드)

클래스와 구조체는 기존 연산자에 대한 자신만의 구현을 제공할 수 있습니다. 이를 기존 연산자의 _중복 정의 (overloading)_ 라고 합니다.

아래 예제는 '사용자 정의 구조체' 에 대한 '산술 더하기 연산자 (`+`)' 를 구현하는 방법을 보여줍니다. '산술 더하기 연산자' 는 두 개의 대상을 연산하기 때문에 _이항 연산자 (binary operator)_ 이며 이 두 대상 사이에 있기 때문에 _중위 (infix)_[^infix] 라고 말합니다.

예제는 '2-차원 위치 벡터 `(x, y)`' 를 위한 `Vector2D` 구조체를 정의하고, 이어서 `Vector2D` 구조체 인스턴스를 서로 더하기 위한 _연산자 메소드 (operator method)_ 를 정의합니다:

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

연산자 메소드는 `Vector2D` 에 대한 '타입 메소드' 로 정의하며, '메소드 이름' 은 '중복 정의할 연산자 (`+`)' 와 일치합니다. 더하기가 '벡터 (vector)' 의 핵심 동작은 아니기 때문에, 타입 메소드를 `Vector2D` 구조체의 주 선언부 보다는 '`Vector2D` 익스텐션' 에서 정의합니다. '산술 더하기 연산자' 가 '이항 연산자' 이기 때문에, 이 연산자 메소드는 `Vector2D` 타입의 두 입력 매개 변수를 취하며, 역시 `Vector2D` 타입인, 단일 출력 값을 반환합니다.

이 구현에서, 입력 매개 변수는 `+` 연산자의 왼쪽과 오른쪽에 있는 `Vector2D` 인스턴스를 표현하기 위한 `left` 와 `right` 라는 이름을 붙입니다. 메소드는, 자신의 `x` 와 `y` 을 서로 더한 두 `Vector2D` 인스턴스에 있는 `x` 와 `y` 속성의 합으로 초기화하는, 새로운 `Vector2D` 인스턴스를 반환합니다.

타입 메소드는 기존 `Vector2D` 인스턴스 사이의 '중위 연산자' 로 사용할 수 있습니다:

```swift
let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector
// combinedVector 는 (5.0, 5.0) 라는 값을 가진 Vector2D 인스턴스입니다.
```

이 예제는 벡터 `(3.0, 1.0)` 과 `(2.0, 4.0)` 을 서로 더하여, 아래에 묘사한 것처럼, 벡터 `(5.0, 5.0)` 을 만듭니다.

![operator method](/assets/Swift/Swift-Programming-Language/Advanced-Operators-operator-method.png)

#### Prefix and Postfix Operators (접두사 연산자와 접미사 연산자)

위에 보인 예제는 사용자 정의 구현한 '이항 중위 (binary infix) 연산자' 를 실증합니다. 클래스와 구조체는 표준 _단항 연산자 (unary operators)_ 의 구현도 제공할 수 있습니다. '단항 연산자' 는 단일 대상에 대해 연산합니다. (`-a` 처럼) 대상 앞에 있으면 _접두사 (prefix)_ 연산자이고 (`b!` 처럼) 대상 뒤에 있으면 _접미사 (postfix)_ 연산자입니다.

'단항 접두사 연산자' 또는 '단항 접미사 연산자' 는 '연산자 메소드' 를 선언할 때 `func` 키워드 앞에 `prefix` 나 `postfix` 수정자를 작성하여 구현합니다:

```swift
extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}
```

위 예제는 `Vector2D` 인스턴스를 위한 '단항 음수 연산자 (`-a`)' 를 구현합니다. '단항 음수 연산자' 는 '접두사 연산자' 이므로, 이 메소드는 `prefix` 수정자로 '규명되어야 (qualified)' 합니다.[^qualified]

단순한 '수치 값' 에 대하여, '단항 음수 연산자' 는 양수를 '등가의 음수' 로 변환하며 그 반대도 마찬가지입니다. `Vector2D` 인스턴스와 관련된 구현에서는 `x` 와 `y` 속성 둘 다에 대해 이 연산을 수행합니다:

```swift
let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
// negative 는 (-3.0, -4.0) 라는 값을 가진 Vector2D 인스턴스 입니다.
let alsoPositive = -negative
// alsoPositive (3.0, 4.0) 라는 값을 가진 Vector2D 인스턴스 입니다.
```

#### Compound Assignment Operators (복합 할당 연산자)

_복합 할당 연산자 (compound assignment operators)_ 는 '할당 (`=`)' 을 다른 연산과 조합합니다. 예를 들어, '더하기 할당 연산자 (`+=`)' 는 '더하기' 와 '할당' 을 단일 연산으로 조합합니다. '복합 할당 연산자' 의 '왼쪽 입력 매개 변수 타입' 은, '연산자 메소드' 안에서 매개 변수의 값을 직접 수정할 것이기 때문에, `inout` 으로 표시합니다.

아래 예제는 `Vector2D` 인스턴스에 대한 '더하기 할당 연산자 메소드' 를 구현합니다:

```swift
extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}
```

'더하기 연산자' 는 앞에서 정의했기 때문에[^addition-earlier], 더하는 과정을 여기서 재구현할 필요는 없습니다. 그 대신, '더하기 할당 연산자 메소드' 는 '기존 더하기 연산자 메소드' 를 사용하여, 왼쪽 값과 오른쪽 값을 더한 것을 왼쪽 값에 설정합니다:

```swift
var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd
// original 은 이제 (4.0, 6.0) 이라는 값을 가집니다.
```

> '기본 할당 연산자 (`=`)' 를 '중복 정의 (overload)' 하는 것은 불가능합니다. '복합 할당 연산자' 만 '중복 정의' 할 수 있습니다. 이와 비슷하게, '삼항 조건 연산자 (`a ? : b : c`)' 도 '중복 정의' 할 수 없습니다.

#### Equivalence Operators (같음 비교 연산자)

기본적으로, 사용자 정의 클래스 및 구조체는, '_같음 (equal to)_ 연산자 (`==`)' 와 '_같지 않음 (not equal to)_ 연산자 (`!=`)' 라는, _같음 비교 연산자 euivalence operators)_ 구현을 가지지 않습니다. 대체로 `==` 연산자는 구현하며, `==` 연산자 결과를 반대로 만드는 `!=` 연산자는 표준 라이브러리의 기본 구현을 사용합니다. `==` 연산자 구현에는 두 가지 방식이 있습니다: 자신이 직접 구현할 수도 있고, 아니면 '많은 타입' 들에서, 구현을 만들어 통합하라고 스위프트에게 요청할 수 있습니다. 두 경우 모두, 표준 라이브러리의 `Equatable` 프로토콜에 대한 '준수성' 을 추가합니다.

`==` 연산자는 다른 '중위 연산자' 를 구현하는 것과 똑같이 구현합니다:

```swift
extension Vector2D: Equatable {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
}
```

위 예제는 두 `Vector2D` 인스턴스의 값이 같은 지를 검사하는 `==` 연산자를 구현합니다. `Vector2D` 에서, “같음 (equal)” 은 “두 인스턴스 모두 똑같은 `x` 값과 `y` 값을 가진다” 는 의미로 고려하는 것이 합리적이므로, 연산자 구현에서도 이 논리를 사용합니다.

이제 두 `Vector2D` 인스턴스가 같은 지를 검사하는데 이 연산자를 사용할 수 있습니다:

```swift
let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("These two vectors are equivalent.")
}
// "These two vectors are equivalent." 를 인쇄합니다.
```

[Adopting a Protocol Using a Synthesized Implementation (통합된 구현을 사용하여 프로토콜 채택하기)]({% post_url 2016-03-03-Protocols %}#adopting-a-protocol-using-a-synthesized-implementation-통합된-구현을-사용하여-프로토콜-채택하기) 에서 설명한 것처럼, 많은 단순한 경우에, '같음 비교 연산자' 의 '통합된 구현' 을 스위프트가 제공하도록 요청할 수 있습니다.

### Custom Operators (사용자 정의 연산자)

스위프트가 제공하는 '표준 연산자' 에 더하여 자신만의 _사용자 정의 연산자 (custom operators)_ 를 선언하고 구현할 수 있습니다. '사용자 정의 연산자' 를 정의할 때 사용할 수 있는 문자들의 목록은, [Operators (연산자)]({% post_url 2020-07-28-Lexical-Structure %}#operators-연산자) 를 참고하기 바랍니다.

새로운 연산자는 `operator` 키워드를 사용하여 '전역 수준' 에서 선언하며, `prefix`, `infix`, 또는 `postfix` 수정자로 표시합니다:[^global-level]

```swift
prefix operator +++
```

위 예제는 `+++` 라는 새로운 '접두사 연산자' 를 정의합니다. 이 연산자는 기존 스위프트에서 의미가 없던 것이므로, 아래 처럼 `Vector2D` 인스턴스와 작업하는 특정 상황에서만 자신만의 사용자 정의 의미가 주어집니다. 이 예제 용으로, `+++` 는 “두 배로 만드는 접두사 형식의 (prefix doubling)” 새로운 연산자로 취급합니다. 이는, 앞에서 정의한 '더하기 할당 연산자' 로 벡터에 자신을 더함으로써, `Vector2D` 인스턴스의 `x` 와 `y` 값을 두 배로 만듭니다. `+++` 연산자를 구현하려면, 다음 처럼 `Vector2D` 에 `+++` 라는 타입 메소드를 추가합니다:

```swift
extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
// toBeDoubled 은 이제 (2.0, 8.0) 라는 값을 가집니다.[^doubling]
// afterDoubling 도 (2.0, 8.0) 라는 값을 가집니다.
```

#### Precedence for Custom Infix Operators (사용자 중위 연산자에 대한 우선 순위)

각각의 '사용자 중위 연산자' 는 '우선 순위 그룹 (precedence group)' 에 속합니다. '우선 순위 그룹' 은, 연산자의 '결합성 (associativity)' 뿐 아니라, 다른 중위 연산자와 이 연산자의 상대적인 '우선 순위' 를 지정합니다. 이 성질들이 중위 연산자와 다른 중위 연산자와의 상호 작용에 영향을 주는 방법에 대한 설명은 [Precedence and Associativity (우선 순위와 결합성)](#precedence-and-associativity-우선-순위와-결합성) 을 참고하기 바랍니다.

'우선 순위 그룹' 을 명시하지 않은 '사용자 중위 연산자' 는 '삼항 조건 연산자' 바로 위의 우선 순위를 가진 '기본 우선 순위 그룹' 을 부여합니다.

다음 예제는, `AdditionPrecedence` '우선 순위 그룹' 에 속한, `+-` 라는 새로운 '사용자 중위 연산자' 를 정의합니다:

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
// plusMinusVector 는 (4.0, -2.0) 라는 값을 가진 Vector2D 인스턴스입니다.
```

이 연산자는 두 벡터의 `x` 값은 서로 더하며, `y` 값은 첫 번째에서 두 번째 벡터의 값을 뺍니다. 이는 본질적으로 "더하는 (additive)" 연산자이기 때문에, `+` 와 `-` 같은 '더하는 중위 연산자' 와 똑같은 '우선 순위 그룹' 을 부여했습니다. 스위프트 표준 라이브러리가 제공하는, 연산자 '우선 순위 그룹' 과 '결합성 설정' 의 완전한 목록을 포함한, 연산자에 대한 정보는, [Operators Declarations (연산자 선언)](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations)[^operator-declarations-apple] 을 참고하기 바랍니다. '우선 순위 그룹' 에 대한 더 많은 정보와 자신만의 연산자 및 우선 순위 그룹을 정의하기 위한 구문을 보려면, [Operator Declaration (연산자 선언)]({% post_url 2020-08-15-Declarations %}#operator-declaration-연산자-선언) 을 참고하기 바랍니다.

> '접두사' 나 '접미사 연산자' 를 정의할 땐 '우선 순위' 를 지정하지 않습니다. 하지만, 동일한 피연산자에 '접두사' 와 '접미사 연산자' 를 둘 다 적용할 경우, '접미사 연산자' 를 먼저 적용합니다.

### Result Builders (결과 제작자)

_결과 제작자 (result builder)_ 는, '리스트 (list)' 나 '트리 (tree)' 같은[^list-or-tree], '중첩 데이터' 를, 자연스러운, 선언형 방식으로, 생성하는 구문을 추가하기 위해 정의하는 타입입니다. '결과 제작자' 를 사용하는 코드는, `if` 와 `for` 같이, 조건문 또는 '데이터' 의 반복을 처리하는, 평범한 스위프트 구문을 포함할 수 있습니다.

아래 코드는 '별' 과 '문장' 으로 한 줄 위에 그림을 그리기 위한 몇몇 타입을 정의합니다.

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

`Drawable` 프로토콜은, 선이나 도형 같이, 그릴 수 있기 위한 '필수 조건' 인: 타입은 반드시 `draw()` 함수를 구현해야 한다는 것을 정의합니다. `Line` 구조체는 '한-줄 그림' 을 표현하며, 대부분의 그림에 대한 '최상단 컨테이너 (container)'[^container] 역할을 합니다. `Line` 을 그리기 위해, 구조체는 각각의 '줄 (line)' 성분에 대한 `draw()` 를 호출하며, 그런 다음 '결과 문자열' 들을 '단일 문자열' 로 이어붙입니다. `Text` 구조체는 문자열을 포장하여 '그림' 으로 만듭니다. `AllCaps` 구조체는 또 다른 그림을 포장하고 수정하여, 그림 안의 어떤 문장이든 대문자로 변환합니다.

초기자를 호출함으로써 이 타입들로 그림을 만들 수 있습니다:

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
// "***Hello RAVI PATEL!**" 를 인쇄합니다.
```

이 코드는 작동은 하지만, 조금 어색합니다. `AllCaps` 뒤에 깊게 중첩된 괄호들은 이해하기가 힘듭니다. `name` 이 `nil` 일 때 "World" 를 사용하는 '대체 논리' 는, 어떤 더 복잡한 것도 어려울 것이므로, `??` 연산자를 사용하여 '인라인' 으로 했어야 합니다. 그림을 제작하기 위해 'switch 문' 이나 `for` 반복문을 포함할 필요가 있어도, 그럴 방법이 없습니다. '결과 제작자' 는 이와 같은 코드를 재작성하여 보통의 스위프트 코드 처럼 보이게 합니다.

'결과 제작자' 를 정의하려면, '타입 선언' 에 '`@resultBuilder` 특성 (attribute)'[^attribute] 을 작성합니다. 예를 들어, 다음 코드는, '선언형 구문 (declarative)' 으로 그림을 설명하도록 해주는, `DrawingBuilder` 라는 '결과 제작자' 를 정의합니다:

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

`DrawingBuilder` 구조체는 '결과 제작자 구문' 일부를 구현하는 세 개의 메소드를 정의합니다. `buildBlock(_:)` 메소드는 코드 블럭에 '연속된 줄들 ' 을 작성하기 위한 지원을 추가합니다. 이는 해당 블럭에 있는 성분들을 하나의 `Line` 으로 조합합니다. `buildEither(first:)` 와 `buildEither(second:)` 메소드는 `if`-`else` 문에 대한 지원을 추가합니다.

함수의 매개 변수에 `@DrawingBuilder` 를 적용하여, 함수에 전달한 클로저를 해당 클로저로부터 '결과 제작자' 가 생성한 값으로 바꿀 수 있습니다. 예를 들어 다음과 같습니다:

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
// "***Hello WORLD!**" 를 인쇄합니다.

let personalGreeting = makeGreeting(for: "Ravi Patel")
print(personalGreeting.draw())
// "***Hello RAVI PATEL!**" 를 인쇄합니다.
```

`makeGreeting(for:)` 함수는 `name` 매개 변수를 취하고 이를 사용하여여 '개인별 인사말' 을 그립니다. `draw(_:)` 와 `caps(_:)` 함수 둘 다, `@DrawingBuilder` 특성으로 표시한, 단일 클로저를 인자로 취합니다. 해당 함수를 호출할 땐, `DrawingBuilder` 가 정의한 '특수 구문' 을 사용합니다.[^greeting-draw] 스위프트는 함수 인자로 전달한 값을 제작하기 위해 해당 그림의 '선언형 설명' 을 `DrawingBuilder` 메소드에 대한 연속된 호출로 변형합니다. 예를 들어, 스위프트는 해당 예제의 `caps(_:)` 호출을 다음 같은 코드로 변형합니다:

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

스위프트는 `if`-`else` 블럭을 `buildEither(first:)` 와 `buildEither(second:)` 메소드에 대한 호출로 변형합니다. 비록 자신의 코드에서 이 메소드를 호출하진 않더라도, 변형 결과를 보는 것은 `DrawingBuilder` 구문을 사용할 때 스위프트가 코드를 변형하는 방식을 알기 쉽게 만듭니다.

그림을 그리는 '특수 구문' 에서 `for` 반복문 지원을 추가하도록 작성하려면, `buildArray(_:)` 메소드를 추가합니다:

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

위 코드에서, `for` 반복문은 그림 배열을 생성하며, `buildArray(_:)` 메소드는 해당 배열을 `Line` 으로 바꿉니다.

스위프트가 '제작자 구문' 을 '제작자 타입의 메소드에 대한 호출' 로 변형하는 방식에 대한 완전한 목록은, [resultBuilder]({% post_url 2020-08-14-Attributes %}#resultbuilder-결과-제작자) 를 참고하기 바랍니다.

### 다음 장

[About the Language Reference (언어의 기준에 대하여) > ]({% post_url 2017-03-13-About-the-Language-Reference %})

### 참고 자료

[^Advanced-Operators]: 이 글에 대한 원문은 [Advanced Operators](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html) 에서 확인할 수 있습니다.

[^factor]: '인수 (factor)' 는 수학 용어로, '정수 (integer)' 나 '수식 (equation)' 을 몇 개의 곱으로 나타냈을 때, 각 구성 요소를 일컫는 말입니다. 보통 '인수 분해 (factorization)' 라고 할 때의 '인수' 가 바로 이 'factor' 입니다. '인수 (factor)' 에 대한 더 자세한 정보는, 위키피디아의 [Factor (mathematics)](https://en.wikipedia.org/wiki/Factor#Mathematics) 항목과 [인수](https://ko.wikipedia.org/wiki/인수) 항목을 참고하기 바랍니다. 요즘에는 '인수' 보다 [약수](https://ko.wikipedia.org/wiki/약수) ([divisor](https://en.wikipedia.org/wiki/Divisor)) 라는 말을 더 많이 사용하는 것 같습니다.

[^CSS]: 원문에서는 'Cascading Style Sheets' 라고 했지만, 오히려 'CSS' 라는 줄임말이 더 이해하기 편할 것입니다. 'CSS' 에 대한 더 자세한 정보는, 위키피디아의 [Cascading Style Sheets](https://en.wikipedia.org/wiki/Cascading_Style_Sheets) 항목과 [종속형 시트](https://ko.wikipedia.org/wiki/종속형_시트) 항목을 참고하기 바랍니다.

[^two-s-complement]: 컴퓨터 용어로 이런 방식을 '2의 보수 표현법' 이라고 합니다. '2의 보수 표현법' 을 사용하면, 본문에서 계속 언급하는 것처럼, `0` 을 한 가지 방식으로 표현할 수 있고, 사칙 연산이 자연스러워지는 장점을 가집니다. '2의 보수' 에 대한 더 자세한 정보는, 위키피디아의 [Two's complement](https://en.wikipedia.org/wiki/Two%27s_complement) 항목과 [2의 보수](https://ko.wikipedia.org/wiki/2의_보수) 항목을 참고하기 바랍니다.

[^arithmetic-shift]: '산술 이동 (arithmetic shift)' 에 대한 더 자세한 내용은, 위키피디아의 [Arithmetic shift](https://en.wikipedia.org/wiki/Arithmetic_shift) 항목과 [산술 시프트](https://ko.wikipedia.org/wiki/산술_시프트) 항목을 참고하기 바랍니다.

[^wrap-around]: 컴퓨터 용어로 'wrap around' 는 `0, 1, 2 ... 10, 0, 1 ...` 처럼 일련의 수들이 빙글빙글 돌아가면서 되풀이되는 것을 말합니다. 'wrap around' 에 대한 더 자세한 정보는, 위키피디아의 [Integer overflow](https://en.wikipedia.org/wiki/Integer_overflow) 항목을 참고하기 바랍니다.

[^associativity]: 'associativity' 는 수학 용어인 '결합 법칙 (associative law)' 과의 연관성을 위해 '결합성' 이라고 옮깁니다. 의미도 '결합 법칙' 과 거의 유사합니다. '결합 법칙' 에 대한 더 자세한 내용은, 위키피디아의 [Associative property](https://en.wikipedia.org/wiki/Associative_property) 항목과 [결합법칙](https://ko.wikipedia.org/wiki/결합법칙) 항목을 참고하기 바랍니다.

[^operator-declarations]: 원문 자체가 '애플 개발자 문서' 로 연결된 링크입니다.

[^infix]: '중위 (infix)' 는 '중간에 위치한다' 라는 말을 줄인 것으로, 수학에서 사용하는 용어입니다. '중위 (infix)' 에 대한 더 자세한 정보는, 위키피디아의 [Infix notation](https://en.wikipedia.org/wiki/Infix_notation) 항목과 [중위 표기법](https://ko.wikipedia.org/wiki/중위_표기법) 항목을 참고하기 바랍니다. 

[^qualified]: '규명되어야 (qualifed) 한다' 는 말은 '자신의 소속이 어디인지를 알아야 한다' 는 의미입니다. 스위프트에서 '규명하다' 라는 말의 의미는, [Nested Types (중첩 타입)]({% post_url 2017-03-03-Nested-Types %}) 장에 있는 [Referring to Nested Types (중첩 타입 참조하기)](#referring-to-nested-types-중첩-타입-참조하기) 부분의 내용과 그 주석을 참고하기 바랍니다.

[^addition-earlier]: [Operator Methods (연산자 메소드)](#operator-methods-연산자-메소드) 부분에서 구현한 것을 그대로 사용합니다. '스위프트 프로그래밍 언어' 책에 있는 예제는 하나의 장 단위로 내용이 이어집니다.

[^global-level]: 실제 '정의' 와는 별도로 '전역 수준' 에서 '선언' 을 따로 해야 한다는 의미입니다.

[^doubling]: `+++` 는 '단항 접두사 연산자' 이므로, `toBeDoubled` 만 두 배로 만듭니다. 이어서 이 `toBeDoubled` 를 `afterDoubled` 에 할당함으로써 `afterDoubled` 가 `toBeDoubled` 와 같은 값을 가지게 됩니다.

[^operator-declarations-apple]: 원문 자체가 '애플 개발자 문서' 로 가는 링크로 되어 있습니다.

[^list-or-tree]: 여기서의 '리스트 (list)' 와 '트리 (tree)' 는 '자료 구조' 타입 중의 하나를 의미입니다. 

[^attribute]: '특성 (attribute)' 에 대한 더 자세한 내용은, [Attributes (특성)]({% post_url 2020-08-14-Attributes %}) 장을 참고하기 바랍니다.

[^greeting-draw]: 본문 예제에서는 `makeGreeting` 함수 안에서 `greeting` 상수를 생성할 때 `draw { ... }` 와 `caps { ... }` 부분에서 이 '특수 구문' 을 사용하고 있습니다.

[^container]: 여기서의 '컨테이너 (container)' 는 다른 객체들의 '집합체' 를 나타내는 '자료 구조 타입' 입니다. 예제에 있는 `List` 구조체도 그리기 가능한 원소들을 `[Drawable]` 처럼 배열로 담고 있습니다. '컨테이너' 에 대한 더 자세한 정보는, 위키피디아의 [Container (abstract data type)](https://en.wikipedia.org/wiki/Container_(abstract_data_type) 항목을 참고하기 바랍니다.
