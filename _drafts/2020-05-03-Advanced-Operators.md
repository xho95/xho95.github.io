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

![shifting behavior for unsigned integer](/assets/Swift/Swift-Programming-Language/Advanced-Operators-shifting-behavior-for-unsigned.png)

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

**Shifting Behavior for Signed Integers (부호있는 정수에 대한 이동 동작)**

'부호있는 정수 (signed integers)' 에 대한 이동 동작은 '부호없는 정수 (unsigend integers)' 에서보다 더 복잡한데, 이는 부호있는 정수를 2-진수로 표현하는 방식 때문입니다. (아래 예제는 문제를 단순화하기 위해 8-비트 부호있는 정수를 기반으로 하고 있지만, 모든 크기의 부호있는 정수에 대해서 같은 원칙이 적용됩니다.)

부호있는 정수는 첫 번째 비트 (_부호 비트 (sign bit)_) 를 사용하여 그 정수가 양수인지 음수인지를 나타냅니다. 부호 비트가 `0` 이면 양수를 의미하고, 부호 비트가 `1` 이면 음수를 의미합니다.

나머지 비트들 (_값 비트들 (value bits)_) 은 실제 값을 저장하고 있습니다. 양수는 부호없는 정수와 정확하게 같은 방식인, `0` 으로 시작하여 저장됩니다. `Int8` 내부 비트로 `4` 라는 수를 나타내는 방법은 다음과 같습니다:

![signed positive 4](/assets/Swift/Swift-Programming-Language/Advanced-Operators-signed-positive-4.jpg)

부호 비트는 `0` 이며 ("양수 (positive)" 를 의미), 7 개의 값 비트들은 그냥 `4` 라는 수를, 2-진수 표기법으로 나타낸 것입니다.

하지만, 음수는 다른 방식으로 저장됩니다. 음수는 `2` 의 `n` 거듭 제곱에서 자신의 절대 값을 뺀 형태로 저장되는데, 여기서 `n` 은 값 비트의 개수입니다.[^two-s-complement] 8-비트 수는 7 개의 값 비트를 가지므로, 이는 `2`의 `7` 거듭 제곱, 또는 `128` 을 의미하게 됩니다.

`Int8` 내부 비트로 `-4` 라는 수를 나타내는 방법은 다음과 같습니다:

![signed negative 4](/assets/Swift/Swift-Programming-Language/Advanced-Operators-signed-negative-4.jpg)

이번에는, 부호 비트가 `1` 이며 ("음수 (negative)" 를 의미), 7 개의 값 비트들은 `124` 의 2-진수 값을 가집니다 (이는 `128 - 4` 입니다.):

![signed 124](/assets/Swift/Swift-Programming-Language/Advanced-Operators-signed-124.jpg)

음수를 이렇게 '부호화 (encoding)' 하는 것을 _2의 보수 (two's complement)_ 표현법이라고합니다. 음수를 표현하기에 특이한 방법으로 보일 수 있지만, 이렇게 하는데는 몇 가지 장점이 있습니다.

첫 번째는, `-1` 과 `-4` 를 더할 때, (부호 비트도 포함하여) 8 개의 모든 비트를 단순히 표준 이진 방식으로 더하고, 완료 후 8 비트에 해당되지 않는 것은 버림으로써, 구할 수 있다는 것입니다:

![two complement negative addition](/assets/Swift/Swift-Programming-Language/Advanced-Operators-two-complement-negative-addtion.jpg)

두 번째는, 2의 보수 표현법은 음수 비트를 왼쪽이나 오른쪽으로 이동하는 것도 양수처럼 할 수 있게 해주며, 왼쪽으로 이동할 때마다 두 배로 증가하는 것, 오른쪽으로 이동할 때마다 반으로 나누는 것도 여전히 같습니다. 이를 위해, 부호있는 정수가 오른쪽으로 이동될 때는 부가적인 규칙을 사용합니다: 부호있는 정수를 오른쪽으로 이동할 때는, 부호없는 정수와 동일한 규칙을 적용하지만, 왼쪽에 생기는 빈 '자리 (bits)' 는, `0` 이 아니라, _부호 비트 (sign bit)_ 로 채웁니다.

![two complement negative shift](/assets/Swift/Swift-Programming-Language/Advanced-Operators-two-complement-negative-shift.jpg)

이런 행동은 부호있는 정수가 오른쪽으로 이동된 다음에도 같은 부호를 가지도록 보장하는 것으로, 이를 _산술 이동 (arithmetic shfit)_ 이라고 합니다.[^arithmetic-shift]

양수와 음수가 저장되는 특수한 방식으로 인해, 둘 중 어떤 것도 오른쪽으로 이동하면 점점 더 `0` 에 가까워집니다. 이동 중에 부호 비트를 같게 유지하는 것은 값이 `0` 에 가까워지더라도 음수는 계속 음수로 남는다는 것을 의미합니다.

### Overflow Operators (값 넘침 연산자)

어떤 수를 정수 상수나 변수에 집어 넣을 때 그 값을 수용할 수 없는 경우, 스위프트는 기본적으로 무효한 값이 생성되도록 내버려두지 않고 에러를 보고합니다. 이런 동작 방식은 너무 크거나 너무 작은 수를 다룰 때 부가적인 안전성을 줍니다.

예를 들어, `Int16` 정수 타입은 `-32768` 과 `32767` 사이의 부호있는 정수를 수용할 수 있습니다. `Int16` 상수나 변수에 이 범위를 벗어나는 수를 설정하면 에러를 띄웁니다:

```swift
var potentialOverflow = Int16.max
// potentialOverflow 는 32767 과 같으며, 이는 Int16 이 수용할 수 있는 최대 값입니다.
potentialOverflow += 1
// 이것은 에러를 띄웁니다.
```

값이 너무 크거나 너무 작을 때 에러 처리를 제공하는 것은 경계 부근의 값을 가지고 코딩하는 조건에서 더 큰 유연함을 줍니다.

하지만, 수치 값에서 유용한 비트만 잘라내고자 값 넘침 조건을 특별히 원할 때, 에러를 발생시키는 대신 이런 동작 방식을 선택할 수도 있습니다. 스위프트는 정수 계산에 대한 값 넘침 동작을 선택하는 세 가지의 '산술 값 넘침 연산자 (arithmetic overflow operators)' 를 제공합니다. 이 연산자들은 모두 앤드 기호 (ampersand; `&`) 로 시작합니다:

* 값 넘침 더하기 (overflow addition; `&+`)
* 값 넘침 빼기 (overflow subtraction; `&-`)
* 값 넘침 곱하기 (overflow multiplication; `&*`)

#### Value Overflow (값 넘침)

수치 값은 양의 방향과 음의 방향 양쪽으로 다 넘칠 수 있습니다.

다음 예제는 '값 넘침 더하기 연산자 (overflow addtion operator; `&+`)' 를 사용하여, 값 넘침을 허용한 부호없는 정수에서 어떤 일이 일어나는지를 보여줍니다:

```swift
var unsignedOverflow = UInt8.max
// unsignedOverflow 는 255 와 같으며, 이는 UInt8 이 수용할 수 있는 최대 값입니다.
unsignedOverflow = unsignedOverflow &+ 1
// unsignedOverflow 는 이제 0 과 같습니다.
```

변수 `unsignedOverflow` 는 `UInt8` 이 수용할 수 있는 최대 값 (`255`, 또는 2-진수 `11111111`) 으로 초기화됩니다. 그런 다음 '값 넘침 더하기 연산자' (`&+`) 로 `1` 만큼 증가합니다. 이는 아래 도표에 나타낸 것처럼, 경계 너머로 값을 넘치게 하므로, 2-진 표현법으로는 `UInt8` 이 수용할 수 있는 크기를 넘겨 버립니다. 값 넘침 더하기 후 `UInt8` 경계 내에 남는 값은 `00000000`, 즉 `0` 입니다.

![value overflow 0](/assets/Swift/Swift-Programming-Language/Advanced-Operators-value-overflow-0.png)

이와 비슷한 일은 부호없는 정수가 음의 방향으로 값이 넘칠 때도 일어납니다. 다음은 '값 넘침 빼기 연산자 (overflow subtraction operator; `&-`)' 를 사용하는 예제입니다:

```swift
var unsignedOverflow = UInt8.min
// unsignedOverflow 는 0 과 같으며, 이는 UInt8 이 수용할 수 있는 최소값입니다.
unsignedOverflow = unsignedOverflow &- 1
// unsignedOverflow 는 이제 255 와 같습니다.
```

`UInt8` 이 수용할 수 있는 최소 값은 `0`, 즉 2-진수 `00000000` 입니다. '값 넘침 빼기 연산자 (`&-`)' 로 `00000000` 에서 `1` 을 빼면, 수치 값이 넘쳐서 `11111111` 또는 10-진수로 `255` 가 되버립니다.

![value overflow 255](/assets/Swift/Swift-Programming-Language/Advanced-Operators-value-overflow-255.png)

부호있는 정수에서도 값 넘침은 발생합니다. 부호있는 정수에 대한 더하기와 빼기 연산은 모두 비트 방식으로 실행되는데, 이 때 [Bitwise Left and Right Shift Operators (비트 왼쪽-이동 및 오른쪽-이동 연산자)](#bitwise-left-and-right-shift-operators-비트-왼쪽-이동-및-오른쪽-이동-연산자) 에서 설명한 대로, 부호 비트도 마치 더하거나 빼는 수의 일부인 것처럼 포함합니다.

```swift
var signedOverflow = Int8.min
// signedOverflow 는 -128 과 같으며, 이는 Int8 이 수용할 수 있는 최소 값입니다.
signedOverflow = signedOverflow &- 1
// signedOverflow 는 이제 127 과 같습니다.
```

`Int8` 이 수용할 수 있는 최소 값은 `-128`, 또는 2-진수로 `10000000` 입니다. '값 넘침 연산자' 로 이 2-진수에서 `1` 을 빼면 2-진수 값이 `01111111` 이 되는데, 이는 부호 비트를 전환해서 양수 `127` 이 되어, `Int8` 이 수용할 수 있는 최대의 양수 값이 됩니다.

![value overflow 255](/assets/Swift/Swift-Programming-Language/Advanced-Operators-value-overflow-127.png)

부호있는 정수와 부호없는 정수에서, 양의 방향으로 넘치면 유효한 최대 정수 값이 최소 값이 되어 돌아오고, 음의 방향으로 넘치면 최소 값이 최대 값이 되어 돌아옵니다.

### Precedence and Associativity (우선 순위 및 결합 법칙)

연산자 _우선 순위 (precedence)_ 는 일부 연산자에 다른 것보다 더 높은 우선권을 주는 것입니다; 이 연산자들은 먼저 적용됩니다.

연산자 _결합 법칙 (associativity)_[^associativity] 은 같은 우선 순위의 연산자들을 서로 그룹짓는 방법을 정의하는 것입니다-왼쪽으로 그룹짓거나, 오른쪽으로 그룹지을 수 있습니다. 이 의미는 “왼쪽의 표현식과 관련 (결합) 되어 있다”, 거나 “오른쪽의 표현식과 관련 (결합) 되어 있다” 로 생각하면 됩니다.

각 연산자의 우선 순위와 결합 법칙을 고려해야 복합 표현식의 계산 순서를 알아낼 수 있다는 점에서 중요합니다. 예를 들어, 연산자 우선 순위는 다음의 표현식이 `17` 인 이유를 설명해 줍니다.

```swift
2 + 3 % 4 * 5
// 이는 17 과 같습니다.
```

곧이 곧대로 왼쪽에서 오른쪽으로 읽으면, 표현식을 다음과 같이 계산된다고 예상할 수도 있습니다:

* 2 더하기 3 은 5 입니다
* 5 나누기 4 의 나머지는 1 입니다
* 1 곱하기 5 는 5 입니다

하지만, 실제 답은 `17` 이지, `5` 가 아닙니다. 높은-우선 순위 연산자가 낮은-우선 순위인 것보다 먼저 계산됩니다. 스위프트에서는, C 언어에서와 같이, '나머지 연산자 (remainder operator; `%`)' 와 '곱하기 연산자 (multiplication operator; `*`)' 가 '더하기 연산자 (addtion operator; `+`) 보다 더 높은 우선 순위를 가집니다. 결과적으로, 더하기를 하기 전에 이 둘을 먼저 계산합니다.

하지만, 나머지와 곱하기는 서로 _같은 (same)_ 우선 순위를 가지고 있습니다. 정확한 계산 순서를 알고 사용하려면, 이들 간의 결합 법칙도 고려할 필요가 있습니다. 나머지와 곱하기 둘 모두 왼쪽에 있는 표현식과 결합되어 있습니다. 이는 이 부분의 표현식에, 왼쪽에서 시작하는, 암시적인 괄호를 추가하는 것으로 생각하면 됩니다:

```swift
2 + ((3 % 4) * 5)
```

`(3 % 4)` 는 `3` 이므로, 이는 다음과 같습니다:

```swift
2 + (3 * 5)
```

`(3 * 5)` 는 `15` 이므로, 이는 다음과 같습니다:

```swift
2 + 15
```

이 계산의 최종 답은 `17` 입니다.

스위프트 표준 라이브러리에서 제공하는 연산자와, 여기에 설정된 연산자 우선 순위와 결합 법칙에 대한 완전한 목록에 대한 더 자세한 정보는, [Operator Declaration (연산자 선언)](https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations) 을 참고하기 바랍니다.

> 스위프트의 연산자 우선 순위와 결합 법칙은 C 언어와 오브젝티브-C 언어에서보다 더 간단하고 이해하기 쉽습니다. 하지만, 이말은 C-기반 언어에 있는 것들과 정확하게 같지는 않다는 것을 의미합니다. 기존 코드를 스위프트로 이식할 때는 연산자의 상호 작용이 원하는 방식을 유지할 수 있도록 주의해야 합니다.

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

[^two-s-complement]: 이런 방식으로 음수를 표현하는 것을 컴퓨터 용어로 '2의 보수 표현법' 이라고 합니다. '2의 보수 표현법' 을 사용하면 `0` 을 한 가지 방식으로 표현할 수 있고, 사칙 연산이 자연스러워 지는 등의 장점이 있습니다. 이는 본문에서도 조금 언급합니다. 더 자세한 정보는 위키피디아의 [Two's complement](https://en.wikipedia.org/wiki/Two%27s_complement) 또는 [2의 보수](https://ko.wikipedia.org/wiki/2의_보수) 를 참고하기 바랍니다.

[^arithmetic-shift]: '산술 이동 (arithmetic shift)' 에 대한 더 자세한 내용은 위키피디아의 [Arithmetic shift](https://en.wikipedia.org/wiki/Arithmetic_shift) 또는 [산술 시프트](https://ko.wikipedia.org/wiki/산술_시프트) 를 참고하기 바랍니다.

[^associativity]: 'associativity' 는 '관련성' 정도로 번역할 수도 있겠지만, 수학 용어로 '결합 법칙' 이라고 널리 쓰이고 있습니다. 이에 대한 더 자세한 내용은 위키피디아의 [Associative property](https://en.wikipedia.org/wiki/Associative_property) 또는 [결합법칙](https://ko.wikipedia.org/wiki/결합법칙) 을 참고하기 바랍니다.
