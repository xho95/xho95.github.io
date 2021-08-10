---
layout: post
comments: true
title:  "Swift 5.5: The Basics (기초)"
date:   2016-04-24 19:45:00 +0900
categories: Swift Language Grammar Basics
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [The Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html) 부분[^The-Basics]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## The Basics (기초)

스위프트는 'iOS, macOS, watchOS, 및 tvOS 앱 개발' 을 위한 새로운 프로그래밍 언어입니다. 그럼에도 불구하고, C 와 오브젝티브-C 개발 경험으로 인하여 스위프트의 많은 부분들이 익숙할 것입니다.

스위프트는, 정수를 위한 `Int`, 부동 소수점 값을 위한 `Double` 과 `Float`, '불리언 (Boolean) 값' 을 위한 `Bool`, 그리고 문장 자료를 위한 `String` 을 포함한, 모든 C 와 오브젝티브-C 기본 타입에 대한 자신만의 버전을 제공합니다. 스위프트는, [Collection Types (집합체 타입)]({% post_url 2016-06-06-Collection-Types %}) 에서 설명한 것처럼, `Array` (배열), `Set` (셋), 그리고 `Dictionary` (딕셔너리)[^set-dictionary] 라는, 강력한 '주요 집합체 (collection) 타입' 세 개도 제공합니다.

C 같이, 스위프트도 '식별 가능한 이름 (identifying name) 으로 값을 저장하고 참조' 하기 위해 '변수 (variables)' 를 사용합니다. 스위프트는 '값을 바꿀 수 없는 변수' 도 광범위하게 사용합니다. 이를 '상수 (constants)' 라고 하는데, C 에 있는 상수보다 훨씬 더 강력합니다. 바꿀 필요가 없는 값과 작업할 때 코드를 더 안전하고 명확하게 만들려는 의도로 스위프트 전반에 걸쳐 상수를 사용합니다.

익숙한 타입에 더하여, 스위프트는 오브젝티브-C 에 없는, '튜플 (tuple)' 같은, 고급 타입도 도입합니다. 튜플은 '값의 그룹 (groupings)' 을 생성하고 전달할 수 있게 합니다. 함수에서 '여러 개의 값을 단일 복합 값 (single compound value) 으로 반환' 하기 위해 튜플을 사용할 수 있습니다.

스위프트는, '값의 없음 (absence)' 을 처리하는, '옵셔널 (optional) 타입' 도 도입합니다. 옵셔널은 "값이 _있고 (is)_, 그건 x 입니다" 라거나 아니면 "값이 전혀 _없습니다 (isn't)_" 라고 말합니다. '옵셔널의 사용' 은 '오브젝티브-C 의 포인터에 `nil` 을 사용' 한 것과 비슷하지만, '클래스 (class)' 뿐만 아니라, 어떤 타입과도 작업할 수 있습니다. 옵셔널은 오브젝티브-C 의 '`nil` 포인터' 보다 더 안전하고 표현력이 풍부할 뿐만 아니라, 수많은 스위프트의 가장 강력한 특징 중에서도 핵심입니다.

스위프트는 '_타입-안전 (type-sefe)_ 언어' 이며, 이는 '코드에서 작업할 값의 타입이 명확하도록 언어가 도와준다' 는 의미입니다. 코드가 `String` 을 요구하면, '타입 안전 장치 (type safety)' 가 `Int` 를 전달하는 실수를 막아줍니다. 마찬가지로, 타입 안전 장치는 '옵셔널-아닌 `String` 을 요구하는 코드' 에 '옵셔널 `String` 을 전달하는 사고' 도 막아줍니다. '타입 안전 장치' 는 개발 과정에서 에러를 가능한 빨리 잡아내고 고칠 수 있게 도와줍니다.

### Constants and Variables (상수와 변수)

상수와 변수는 (`maximumNumberOfLoginAttempts` 나 `welcomeMessage` 같은) 이름을 (`10` 이라는 수나 `"Hello"` 라는 문자열 같은) 특별한 타입의 값과 결합합니다. _상수 (constant)_ 값은 한 번 설정하면 바꿀 수 없는 반면, _변수 (variable)_ 는 미래에 다른 값을 설정할 수 있습니다.

#### Declaring Constants and Variables (상수와 변수 선언하기)

상수와 변수는 반드시 사용 전에 선언해야 합니다. 상수는 `let` 키워드로 변수는 `var` 키워드로 선언합니다. 다음은 상수와 변수로 사용자 로그인 시도 횟수를 추적하는 방법에 대한 예제입니다:

```swift
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
```

이 코드는 다음 처럼 이해할 수 있습니다:

"`maximumNumberOfLoginAttempts` 라는 새로운 상수를 선언하고, `10` 이라는 값을 줍니다. 그런 다음, `currentLoginAttempt` 라는 새로운 변수를 선언하고, `0` 이라는 초기 값을 줍니다."

이 예제에서, 최대 값은 절대 바뀌지 않기 때문에, '로그인 시도 최대 허용 횟수' 를 상수로 선언합니다. '현재 로그인 시도 횟수' 의, 값은 각각의 로그인 시도가 실패한 후에 반드시 증가해야 하기 때문에, 변수로 선언합니다.

'쉼표 (commas)' 로 구분하여, 여러 개의 상수나 여러 개의 변수를 한 줄로 선언할 수 있습니다:

```swift
var x = 0.0, y = 0.0, z = 0.0
```

> 코드에서 저장 값을 바꾸지 않을 거라면, 항상 `let` 키워드를 가진 상수로 선언합니다. 저장 값이 바뀔 수 있는 경우에만 변수를 사용합니다.

#### Type Annotations (타입 보조 설명)

상수나 변수를 선언할 때는, 상수나 변수가 저장할 값의 종류가 명확하도록, _타입 보조 설명 (type annotation)_[^annotation] 을 제공할 수 있습니다. '타입 보조 설명' 은 상수나 변수 이름 뒤에 콜론을 두고, 공백을 넣은 다음, 뒤에 사용할 타입 이름을 써서 작성합니다.

다음 예제는 `welcomeMessage` 라는 변수가 , `String` 값을 저장할 수 있음을 지시하는, 타입 보조 설명을 제공합니다: 

```swift
var welcomeMessage: String
```

선언에서 콜론은 "...타입인 (of type)..." 의 의미이므로, 위 코드는 다음 처럼 이해할 수 있습니다:

"`String` 타입인 `welcomeMessage` 라는 변수를 선언합니다."

"`String` 타입인" 이라는 구절은 "어떤 `String` 값이든 저장할 수 있다" 는 의미입니다. 저장할 수 있는 "어떤 것의 타입" (또는 "어떤 것의 종류") 를 의미한다고 생각하기 바랍니다.

이제 `welcomeMessage` 변수에는 에러 없이 어떤 문자열 값이든 설정할 수 있습니다:

```swift
welcomeMessage = "Hello"
```

서로 관계 있는 동일 타입의 여러 변수들은, 쉼표로 구분하고, 최종 변수 이름 뒤에 '단일 타입 보조 설명' 을 둬서, 한 줄로 정의할 수 있습니다:

```swift
var red, green, blue: Double
```

> 실제로 '타입 보조 설명' 을 작성할 필요는 거의 없습니다. 상수나 변수를 정의하는 시점에 초기 값을 제공하면, [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)](#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 에서 설명한 것처럼, 해당 상수나 변수가 사용할 타입을 거의 항상 스위프트가 추론할 수 있습니다. 위 `welcomeMessage` 예제는, 초기 값을 제공하지 않으므로, `welcomeMessage` 변수의 타입을 초기 값으로 추론하기 보다 '타입 보조 설명' 으로 지정한 것입니다.

#### Naming Constants and Variables (상수와 변수 이름짓기)

상수와 변수 이름은, '유니코드 문자 (Unicode characters)' 를 포함한, 거의 어떤 문자든 담을 수 있습니다:

```swift
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"
```

상수와 변수 이름은 '공백 (whitespace) 문자', '수학 기호 (mathematical symbols)', '화살표 (arrows)', '사용자 영역 유니코드 크기 값 (private-use Unicode scalar values)'[^private-use-Unicode-scalar-values], 또는 '선- 및 상자-그리기 (line-drawing and box-drawing) 문자' 를 담을 순 없습니다. 숫자로 시작하는 것도 안되긴 하지만, 이름 안의 다른 곳에 숫자를 포함할 순 있습니다.

정해진 타입의 상수나 변수를 한 번 선언하고 나면, 똑같은 이름을 가지고 다시 선언하거나, 다른 타입의 값을 저장하도록 바꿀 수 없습니다. 상수를 변수로 변수를 상수로 바꿀 수도 없습니다.

> 상수나 변수에 '스위프트 예약 키워드 (reserved Swift keyword) 와 똑같은 이름' 을 줘야 한다면, 키워드를 이름으로 사용할 때 '역따옴표 (backticks; `` ` ``)'[^backticks] 로 감쌉니다. 하지만, 절대적으로 선택의 여지가 없는 것이 아닌 한 키워드를 이름으로 사용하는 걸 피하기 바랍니다.

기존 변수의 값을 호환 가능한 타입의 또 다른 값으로 바꿀 수 있습니다. 다음 예제는, `friendlyWelcome` 의 값을 `"Hello!"` 에서 `"Bonjour!"` 로 바꿉니다:

```swift
var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"
// friendlyWelcome 은 이제 "Bonjour!" 입니다.
```

변수와 달리, 상수 값은 설정 후에 바꿀 수 없습니다. 그렇게 하려고 하면 코드 컴파일 때 에러를 보고합니다:

```swift
let languageName = "Swift"
languageName = "Swift++"
// 이는 컴파일-시간 에러입니다: languageName 을 바꿀 수 없습니다.
```

#### Printing Constants and Variables (상수와 변수 인쇄하기)

상수나 변수의 현재 값은 `print(_:separator:terminator:)` 함수로 인쇄할 수 있습니다:

```swift
print(friendlyWelcome)
// "Bonjour!" 를 인쇄합니다.
```

`print(_:separator:terminator:)` 함수는 하나 이상의 값을 적절한 출력 결과로 인쇄하는 전역 함수입니다. '엑스코드 (Xcode)' 에선, 예를 들어, `print(_:separator:terminator:)` 함수가 출력 결과를 '엑스코드의 "콘솔 (console)" 구역' 에 인쇄합니다. `separator` 와 `terminator` 매개 변수에는 '기본 (default) 값' 이 있으므로, 함수 호출 시 이를 생략할 수 있습니다. 기본적으로, 함수는 자신이 인쇄하는 줄에 '줄 끊음 (line break)' 을 추가하여 종결합니다. '줄 끊음' 없이 값을 인쇄하려면,-예를 들어, `print(someValue, terminator : "")` 처럼-빈 문자열을 '종결자 (terminator)' 로 전달합니다. '기본 값을 가진 매개 변수' 에 대한 정보는, [Default Parameter Values (기본 매개 변수 값)]({% post_url 2020-06-02-Functions %}#default-parameter-values-기본-매개-변수-값) 부분을 참고하기 바랍니다.

스위프트는 '상수나 변수 이름을 더 긴 문자열 안의 자리 표시자 (placeholder) 로 포함시켜, 이를 해당 상수나 변수의 현재 값으로 대체' 하도록 스위프트에게 알리기 위한 _문자열 보간법 (string interpolation)_[^string-interpolation] 을 사용합니다. 이는 '이름을 괄호로 포장' 하고 '시작 괄호 앞에서 역 빗금 (backslash) 으로 벗어나게 (escape)'[^escape] 하면 됩니다:

```swift
print("The current value of friendlyWelcome is \(friendlyWelcome)")
// "The current value of friendlyWelcome is Bonjour!" 를 인쇄합니다.
```

> '문자열 보간법과 같이 쓸 수 있는 모든 옵션' 들은 [String Interpolation (문자열 보간법)]({% post_url 2016-05-29-Strings-and-Characters %}#string-interpolation-문자열-보간법) 부분에서 설명합니다.

### Comments (주석)

스스로의 기록이나 기억을 위해, 코드에 '실행 불가능한 문장' 을 포함하려면 '주석 (comments)' 을 사용합니다. 코드를 컴파일할 때 스위프트 컴파일러는 주석을 무시합니다.

스위프트의 주석은 C 의 주석과 매우 비슷합니다. '한-줄 (single-line) 주석' 은 '두 빗금 (two forward-slashes; `//`)' 으로 시작합니다:

```swift
// 이것은 주석입니다.
```

'여러 줄 (multiline) 주석' 은 '빗금과 그 뒤의 별표 (`/*`)' 로 시작하여 '별표와 그 뒤의 빗금 (`*/`)' 으로 끝납니다:

```swift
/* 이것도 주석이지만
 여러 줄에 걸쳐 작성합니다 */
```

'C 의 여러 줄 주석' 과는 달리, '스위프트의 여러 줄 주석' 은 '다른 여러 줄 주석 안에 중첩' 할 수 있습니다. '중첩 주석' 은 '여러 줄 주석 블럭을 시작한 다음 첫 번째 블럭 안에서 두 번째 여러 줄 주석을 시작' 함으로써 작성합니다. 그런 다음 두 번째 블럭을 닫고, 그 뒤에 첫 번째 블럭을 닫습니다:

```swift
/* 이것은 첫 번째 여러 줄 주석의 시작입니다.
 /* 이것은 중첩한, 두 번째 여러 줄 주석입니다. */
 이것은 첫 번째 여러 줄 주석의 끝입니다. */
```

'여러 줄 주석 중첩' 은, 코드에 이미 '여러 줄 주석' 이 있는 경우에도, 빠르고 쉽게 큰 코드 블럭을 주석으로 만들 수 있게 합니다.

### 세미콜론 (Semicolons)

다른 많은 언어들과는 달리, 스위프트는, 원한다면 그럴 순 있지만, 각각의 코드 구문 뒤에 '세미콜론 (`;`)' 을 작성하도록 요구하지 않습니다. 하지만, 별도의 여러 구문을 한 줄로 작성하고 싶으면 '세미콜론 _이 (are)_ 필수' 입니다:

```swift
let cat = "🐱"; print(cat)
// "🐱" 를 인쇄합니다.
```

### Integers (정수)

_정수 (integers)_ 는, `42` 와 `-23` 같이, '분수 성분이 없는 수' 전체 입니다. 정수는 _부호 있는 (signed)_ 것 (양수, 0, 또는 음수) 이거나 아니면 _부호 없는 (unsigned)_ 것 (양수, 또는 0) 입니다.

스위프트는 '8, 16, 32, 및 64 비트 형식의 부호 있는 그리고 부호 없는 정수' 를 제공합니다. 이 정수들은, '8-비트 부호 없는 정수' 가 `UInt8` 타입이고, '32-비트 부호 있는 정수' 는 `Int32` 타입이라는 점에서, C 와 비슷한 '작명법 (naming convention)' 을 따릅니다. 스위프트의 모든 타입 같이, 이 정수 타입 이름들은 대문자로 시작합니다.

#### Integer Bounds (정수의 경계)

`min` 과 `max` 속성으로 각 정수 타입의 최소 및 최대 값에 접근할 수 있습니다:

```swift
let minValue = UInt8.min  // minValue 는 0 이고, 타입은 UInt8 입니다.
let maxValue = UInt8.max  // maxValue 는 255 이고, 타입은 UInt8 입니다.
```

이 속성 값들은 (위 예제의 `UInt8` 같은) 적절한-크기의 수치 타입이며 따라서 표현식에서 똑같은 타입의 다른 값과 나란히 사용할 수 있습니다.

#### Int (정수)

대부분의 경우, 코드에서 사용할 특정 정수의 크기는 고를 필요가 없습니다. 스위프트는, `Int` 라는, 추가적인 정수 타입을 제공하며, 이는 '현 플랫폼 고유의 워드 (word)[^word] 크기' 와 똑같은 크기를 가집니다:

* 32-비트 플랫폼에 대한, `Int` 는 `Int32` 와 똑같은 크기입니다.
* 64-비트 플랫폼에 대한, `Int` 는 `Int64` 와 똑같은 크기입니다.

특정 크기의 정수와 작업해야 하는 것이 아닌 한, 코드에서 정수 값으로 항상 `Int` 를 사용합니다. 이는 '코드 일관성 (consistency) 과 상호 호환성 (interoperability)' 을 높입니다. 32-비트 플랫폼에 대한, `Int` 도 `-2,147,483,648` 에서 `2,147,483,647` 에 이르는 값을 저장할 수 있으며, 수많은 정수 범위로는 충분히 큽니다.

#### UInt (부호없는 정수)

스위프트는, `UInt` 라는, 부호없는 정수 타입도 제공하며, 이는 '현 플랫폼 고유의 워드 크기' 와 똑같은 크기를 가집니다:

* 32-비트 플랫폼에 대한, `UInt` 는 `UInt32` 와 똑같은 크기입니다.
* 64-비트 플랫폼에 대한, `UInt` 는 `UInt64` 와 똑같은 크기입니다.

> `UInt` 는 특별히 플랫폼의 고유 워드 크기와 같은 크기의 부호 없는 정수가 꼭 필요할 때만 사용합니다. 이 경우가 아니면, 저장 값이 음수가 아는 것을 알아도, `Int` 가 더 좋습니다. 정수 값으로 `Int` 를 일관되게 사용하는 것은, [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)](#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 에서 설명한 것처럼, 코드의 '상호 호환성 (interoperability)' 을 높이고, 서로 다른 수치 타입간의 변환을 피하게 해주며, 정수로 타입 추론한 것과도 일치합니다.

### Floating-Point Numbers (부동-소수점 수)

_부동-소수점 수 (floating-point numbers)_ 는, `3.14159`, `0.1`, 그리고 `-273.15` 같이, 분수 성분이 있는 수를 말합니다.

'부동-소수점 타입 (floating-point types)' 은 '정수 타입' 보다 훨씬 넓은 범위의 값을 표현할 수 있으며, `Int` 가 저장할 수 있는 것보다 훨씬 더 크거나 작은 수도 저장할 수 있습니다. 스위프트는 두 가지의 부호 있는 부동-소수점 수치 타입을 제공합니다:

* `Double` 은 64-비트 부동-소수점 수를 표현합니다.
* `Float` 은 32-비트 부동-소수점 수를 표현합니다.

> `Double` 은 최소 '15 자리 유효 숫자 (15 decimal digits)' 의 정밀도를 가지는 반면, `Float` 의 정밀도는 좀 더 적은 '6 자리 유효 숫자 (6 decimal digits)' 입니다. 사용하기 적절한 부동-소수점 타입은 코드 작업에서 필요한 값의 본성과 범위에 달려 있습니다. 어느 타입이든 적절할 것 같은 상황에선, `Double` 을 사용하는 것이 더 좋습니다.

### Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)

스위프트는 _타입-안전 (type-safe)_ 언어입니다. '타입 안전 언어' 는 코드에서 작업할 값의 타입이 명확하다는 확신을 줍니다. 코드에서 `String` 이 필수인 경우, 실수로 `Int` 를 전달하는 것도 막아줍니다.

스위프트는 타입 안전하므로, 코드를 컴파일할 때 _타입 검사 (type checks)_ 를 수행해서 일치하지 않는 타입은 어떤 것이든 에러라고 표시합니다. 이는 개발 과정에서 에러를 최대한 빨리 잡아내고 고치도록 해줍니다.

'타입 검사 (Type-checking)' 는 서로 타입이 다른 값들과 작업할 때 에러를 피하도록 도와줍니다. 하지만, 이것이 상수와 변수를 선언할 때마다 타입을 지정해야 함을 의미하는 것은 아닙니다. 필요한 값의 타입을 지정하지 않은 경우, 스위프트는 _타입 추론 장치 (type inference)_ 를 사용하여 적절한 타입을 알아냅니다. '타입 추론 장치' 는, 제공한 값을 단순히 검토하는 것으로써, 코드를 컴파일할 때 컴파일러가 특정 표현식의 타입을 자동으로 이끌어 낼 수 있게 해줍니다.

'타입 추론' 으로 인하여, 스위프트에서 선언이 필수인 경우는 C 나 오브젝티브-C 같은 언어보다 훨씬 적습니다. 상수와 변수의 타입은 여전히 명시적이어야 하지만, 타입을 지정하는 작업 대부분을 알아서 해줍니다.

'타입 추론' 은 특히 초기 값을 가진 상수나 변수를 선언할 때 아주 유용합니다. 이는 종종 상수나 변수를 선언하는 순간에 _글자 표현 값 (literal value)_-또는 _글자 값 (literal)_-을 할당하여 수행합니다. ('글자 값 (literal value)' 은, 아래 예제의 `42` 와 `3.14159` 같이, 소스 코드에 직접 나타난 값을 말합니다.)

예를 들어, 새로운 상수에 글자 값 `42` 를 할당하면서 타입이 무엇인지 말하지 않으면, 정수처럼 보이는 수로 초기화하기 때문에, 스위프트는 이 상수가 `Int` 이길 원한다고 추론합니다:

```swift
let meaningOfLife = 42
// meaningOfLife 는 Int 타입이라고 추론합니다.
```

마찬가지로, '부동 소수점 글자 값 (floating-point literal)' 에 타입을 지정하지 않으면, 스위프트는 `Double` 을 생성하길 원한다고 추론합니다:

```swift
let pi = 3.14159
// pi 는 타입이 Double 이라고 추론합니다.
```

스위프트는 항상 부동-소수점 수의 타입을 추론할 때 (`Float` 이 아니라) `Double` 을 선택합니다.

표현식에 정수 글자 값과 부동-소수점 글자 값이 조합되어 있으면, 상황으로부터 `Double` 타입임을 추론할 것입니다:

```swift
let anotherPi = 3 + 0.14159
// anotherPi 도 타입이 Double 이라고 추론합니다.
```

`3` 이라는 글자 값은 그 안에 명시적인 타입이 있는 것도 아니고 그 자체가 타입도 아니므로, 더하기에 '부동-소수점 글자 값' 이 있는 것을 보고 적절한 출력 타입이 `Double` 임을 추론합니다.

### Numeric Literals (수치 글자 값)

'정수 글자 값 (integer literals)' 은 다음처럼 작성합니다:

* _10진 (decimal)_ 수는, 접두사 없음
* _2진 (binary)_ 수는, `0b` 접두사 사용
* _8진 (octal)_ 수는, `0o` 접두사 사용
* _16진 (hexadecimal)_ 수는, `0x` 접두사 사용

다음의 모든 정수 글자 값은 10진수로 `17` 이라는 값을 가집니다:

```swift
let decimalInteger = 17
let binaryInteger = 0b10001       // 17 의 2진 표기법
let octalInteger = 0o21           // 17 의 8진 표기법
let hexadecimalInteger = 0x11     // 17 의 16진 표기법
```

'부동-소수점 글자 값' 은 (접두사 없는) 10진수, 또는 (접두사가 `0x` 인) 16진수일 수 있습니다. 반드시 '소수점 (decimal point)' 양 쪽에는 항상 수 (또는 16진수) 가 있어야 합니다. '10진 부동수 (decimal floats)' 는 옵션으로 _지수 (exponent)_ 를 가질 수 있으며, 대문자 또는 소문자 `e` 로 나타냅니다; '16진 부동수 (hexadecimal floats)' 는 반드시 지수를 가져야 하며, 대문자 또는 소문자 `p` 로 나타냅니다.

지수가 `exp` 인 10진수에는, '밑수 (base number)'[^base-number] 에 10<sup>exp</sup> 이 곱해집니다:

* `1.25e2` 는 1.25 x 10<sup>2</sup>, 또는 `125.0` 를 의미합니다.
* `1.25e-2` 는 1.25 x 10<sup>-2</sup>, 또는 `0.0125` 를 의미합니다.

지수가 `exp` 인 16진수에는, '밑수' 에 2<sup>exp</sup> 이 곱해집니다:

* `0xFp2` 는 15 x 2<sup>2</sup>, 또는 `60.0` 을 의미합니다.
* `0xFp-2` 는 15 x 2<sup>-2</sup>, 또는 `3.75` 를 의미합니다.

다음의 모든 부동-소수점 글자 값은 10진수로 `12.1875` 라는 값을 가집니다:

```swift
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0
```

'수치 글자 값' 은 이해하기 더 쉽도록 부가적인 '양식 (formatting)' 을 가질 수 있습니다. 정수와 '부동수 (floats)' 둘 다 부가적인 '0' 으로 채울 수도 있고 가독성을 돕고자 '밑줄 (underscores)' 을 가질 수도 있습니다. 양식이 어떻든 '글자 값' 의 실제 값에는 영향이 없습니다:

```swift
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
```

### Numeric Type Conversion (수치 타입 변환)

코드에서 모든 일반-용도의 정수 상수와 변수는, 음수가 아님을 알더라도, `Int` 타입을 사용합니다. 언제 어디서나 '기본 정수 타입' 을 사용하면 코드의 정수 상수와 변수가 즉시 '상호 호환 가능 (interoperable)' 하며 '정수 글자 값' 으로 추론한 타입과 일치할 것임을 의미합니다.

다른 정수 타입은 특별히 지금 당장 필요한 작업일 때만, 즉 외부 소스에서 크기가 명시적으로 정해진 자료, 또는 성능 및, 메모리 사용량을 위해서, 아니면 다른 최적화가 필요하기 때문인 경우에만 사용합니다. 이 상황에서 명시적인 크기의 타입을 사용하는 것은 예기치 않은 어떤 '값 넘침 (overflows)' 을 잡아내도록 도와주며 사용 중인 자료의 '본성 (nature)' 을 암시적으로 '문서화 (documents)' [^documents] 합니다.

#### Integer Conversion (정수 변환)

정수 상수나 변수에 저장할 수 있는 수의 범위는 각 수치 타입마다 다릅니다. `Int8` 상수나 변수는 `-128` 에서 `127` 사이의 수를 저장할 수 있는 반면, `UInt8` 상수나 변수는 `0` 에서 `255` 사이의 수를 저장할 수 있습니다. 크기가 조절된 정수 타입의 상수나 변수에 어떤 수가 들어 맞지 않으면 코드를 컴파일할 때 에러로 보고합니다:

```swift
let cannotBeNegative: UInt8 = -1
// UInt8 는 음수를 저장할 수 없으므로, 이는 에러로 보고할 것입니다.
let tooBig: Int8 = Int8.max + 1
// Int8 는 최대 값 보다 큰 수를 저장할 수 없으므로,
// 이것도 에러로 보고할 것입니다.
```

각 수치 타입은 서로 다른 범위의 값을 저장할 수 있기 때문에, 수치 타입 변환은 반드시 각 경우마다 직접 선택해야 합니다. 이러한 '직접 선택 접근 방식 (opt-in approach)' 은 모르게 변환되는 에러를 막아주며 타입 변환의 의도를 코드에 명시하도록 만듭니다.

지정된 하나의 수치 타입을 또 다른 것으로 변환하려면, 원하는 타입의 새로운 수를 기존 값으로 초기화 합니다. 아래 예제에서, 상수 `twoThousand` 의 타입은 `UInt16` 인 반면, 상수 `one` 의 타입은 `UInt8` 입니다. 이들은 직접 더할 수가 없는데, 같은 타입이 아니기 때문입니다. 그 대신, 이 예제는 `UInt16(one)` 을 호출하여 `one` 의 값으로 초기화된 새로운 `UInt16` 를 생성하며, 원본 자리에 이 값을 사용합니다:

```swift
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
```

이제 '더히기' 의 양쪽 모두 `UInt16` 타입이므로, 더하기가 가능해집니다. 출력 상수 (`twoThousandAndOne`) 는 `UInt16` 타입이라고 추론되는데, 두 `UInt16` 값의 합계이기 때문입니다.

`SomeType(ofInitialValue)` 는 스위프트 타입의 초기자를 호출하고 초기 값을 전달하는 기본 방식입니다. 그 이면을 살펴보면, `UInt16` 이 `UInt8` 값을 받는 초기자를 가지고 있어서, 이 초기자를 사용하여 기존 `UInt8` 로 새로운 `UInt16` 를 만듭니다. 하지만, 여기서 _어떤 (any)_ 타입이든 전달할 수는 없으며-`UInt16` 가 초기자를 제공하는 타입이어야만 합니다. 새로운 (자기가 정의한 타입도 포함한) 타입을 받는 초기자를 제공하기 위해 기존 타입을 확장하는 것은 [Extensions (익스텐션; 확장)]({% post_url 2016-01-19-Extensions %}) 에서 다룹니다.

#### Integer and Floating-Point Conversion (정수와 부동-소수점 수 변환)

정수와 부동-소수점 수치 타입 간의 변환은 반드시 명시적으로 해야 합니다:

```swift
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi 는 3.14159 이며, Double 타입으로 추론됩니다.
```

여기서, 상수 `three` 의 값을 써서 `Double` 타입인 새로운 값을 생성했으므로, 더하기 양쪽 모두 같은 타입입니다. 여기서 이 변환을 하지 않으면, 더하기를 할 수는 없을 겁니다.

부동-소수점 수에서 정수로의 변환도 반드시 명시적으로 해야 합니다. `Double` 이나 `Float` 값으로 정수 타입을 초기화 할 수 있습니다:

```swift
let integerPi = Int(pi)
// integerPi 는 3 이며, Int 타입으로 추론됩니다.
```

이런 방식으로 새로운 정수 값을 초기화 할 때는 부동-소수점 값이 항상 잘립니다. 이는 `4.75` 는 `4` 가, `-3.9` 는 `-3` 이 된다는 의미입니다.

> 수치 상수와 변수를 조합하는 규칙은 '수치 글자 값 (numeric literals)' 에 대한 규칙과 다릅니다. 글자 값 `3` 은 글자 값 `0.14159` 에 직접 더할 수 있는데, 이는 '수치 글자 값' 이 그 안에 명시적인 타입을 가진 것도 그 자체가 타입인 것도 아니기 때문입니다. 이들의 타입은 컴파일러가 값을 평가하는 순간에만 추론됩니다.  

### Type Aliases (타입 별명)

_타입 별명 (type aliases)_ 은 기존 타입에 대한 '또 다른 이름 (alternative name)' 을 정의합니다. '타입 별명' 은 `typealias` 키워드로 정의합니다.

타입 별명은, 크기가 외부 소스에서 정해진 자료와 작업할 때 처럼, 상황에 더 적절한 이름으로 기존 타입을 참조하고 싶을 때 유용합니다:

```swift
typealias AudioSample = UInt16
```

타입 별명을 한 번 정의하면, 원래 이름을 사용할 수 있는 곳이면 어디에서든 이 별명을 사용할 수 있습니다:

```swift
var maxAmplitudeFound = AudioSample.min
// maxAmplitudeFound 는 이제 0 입니다.
```

여기서는, `UInt16` 에 대한 별명으로 `AudioSample` 을 정의합니다. 이는 별명이므로, `AudioSample.min` 라는 호출은 실제로 `UInt16.min` 를 호출하는데, 이는 `maxAmplitudeFound` 변수에 초기 값 `0` 을 제공합니다.

### Booleans (불리언; 논리 값)

스위프트는, `Bool` 이라는, 기본적인 _불리언 (Boolean)_ 타입을 가지고 있습니다. '불리언' 값은 _논리 값 (logical)_ 이라고도 하는데, 늘`true` 또는 `false` 만 될 수 있기 때문입니다. 스위프트는, `true` 와 `false` 라는, 두 개의 불리언 상수 값을 제공합니다:

```swift
let orangesAreOrange = true
let turnipsAreDelicious = false
```

`orangesAreOrange` 와 `turnipsAreDelicious` 은 '불리언 글자 값 (Boolean literal values)' 으로 초기화된다는 사실로 부터 타입이 `Bool` 이라고 추론합니다. 위의 `Int` 와 `Double` 에서 처럼, 생성하자마자 `true` 나 `false` 로 설정하는 경우 상수나 변수를 `Bool` 이라고 선언할 필요가 없습니다. '타입 추론 (type inference)' 은 타입을 이미 알고 있는 다른 값으로 상수나 변수를 초기화 할 때 스위프트 코드를 더 간결하고 이해하기 쉽도록 만들어 줍니다.

불리언 값은 특히 `if` 문 같은 조건 구문과 작업할 때 아주 유용합니다:

```swift
if turnipsAreDelicious {
  print("Mmm, tasty turnips!")
} else {
  print("Eww, turnips are horrible.")
}
// "Eww, turnips are horrible." 를 인쇄합니다.
```

`if` 문 같은 조건 구문은 [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에서 더 자세히 다룹니다.

스위프트의 '타입 안전 장치 (type safety)' 는 '불리언이-아닌 (non-Boolean)' 값이 `Bool` 을 대체하는 것을 막아줍니다. 다음 예제는 '컴파일 시간 (compile-time)' 에러를 보고합니다:

```swift
let i = 1
if i {
  // 이 예제는 컴파일이 되지 않고, 에러를 보고할 것입니다.
}
```

하지만, 아래 예제에 있는 대안은 유효합니다:

```swift
let i = 1
if i == 1 {
  // 이 예제는 컴파일이 성공할 것입니다.
}
```

`i == 1` 비교 연산의 결과는 `Bool` 타입이므로, 두 번째 예제는 '타입 검사 (type-check)' 를 통과합니다. `i == 1` 같은 비교 연산은 [Basic Operators (기초 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 에서 논의합니다.

스위프트에 있는 다른 '타입 안전 예제' 에서 처럼, 이 접근 방식은 예기치 않은 에러를 피하고 특정 코드의 의도를 항상 명확하게 드러내도록 보장합니다.

### Tuples (튜플; 짝)

_튜플 (tuples)_ 은 여러 값을 '단일 복합 값' 으로 그룹짓습니다. 튜플 내의 값은 어떤 타입도 될 수 있으며 서로 같은 타입일 필요도 없습니다.

다음 예제의, `(404, "Not Found")` 는 _HTTP 상태 코드 (HTTP status code)_ 를 설명하는 튜플입니다. 'HTTP 상태 코드' 는 웹 페이지를 요청할 때마다 웹 서버가 반환하는 특수한 값입니다. `404 Not Found` 라는 상태 코드는 요청한 웹 페이지가 존재하지 않을 경우 반환됩니다.

```swift
let http404Error = (404, "Not Found")
// http404Error 은 (Int, String) 타입이고, 값은 (404, "Not Found") 입니다.
```

`(404, "Not Found")` 라는 튜플은 `Int` 와 `String` 을 함께 그룹지어서 HTTP 상태 코드에 별도인 두 개의 값: '하나의 수' 와 '사람이-이해할 수 있는 설명' 을 부여합니다. 이는 "`(Int, String)` 타입인 튜플" 이라고 설명할 수 있습니다.

튜플은 어떤 '순서 조합 (permutation)'[^permutation] 으로 된 타입이든 생성할 수 있으며, 서로 다른 타입을 원하는 만큼 많이 담을 수도 있습니다. `(Int, Int, Int)` 나, `(String, Bool)` , 또는 진짜 순서를 필요한 대로 아무렇게나 섞은 타입인 튜플도 만들 수 있습니다.

튜플의 내용은 별도의 상수나 변수로 _분해 (decompose)_ 한 다음, 평소 처럼 접근할 수 있습니다:

```swift
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// "The status code is 404" 를 인쇄합니다.
print("The status message is \(statusMessage)")
// "The status message is Not Found" 를 인쇄합니다.
```

튜플 값에서 일부만 필요한 경우, 튜플을 분해할 때 '밑줄 (underscore; `_`) 을 써서 튜플 일부를 무시합니다:

```swift
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
// "The status code is 404" 를 인쇄합니다.
```

대안으로, 0 으로 시작하는 '색인 번호 (index numbers)' 을 사용하여 튜플의 개별 원소 값에 접근합니다:

```swift
print("The status code is \(http404Error.0)")
// "The status code is 404" 를 인쇄합니다.
print("The status message is \(http404Error.1)")
// "The status message is Not Found" 를 인쇄합니다.
```

튜플을 정의할 때 튜플의 개별 원소에 이름을 붙일 수 있습니다:

```swift
let http200Status = (statusCode: 200, description: "OK")
```

튜플 원소에 이름을 붙이면, 해당 원소의 값에 접근하기 위해 원소 이름을 사용할 수 있습니다:

```swift
print("The status code is \(http200Status.statusCode)")
// "The status code is 200" 를 인쇄합니다.
print("The status message is \(http200Status.description)")
// "The status message is OK" 를 인쇄합니다.
```

튜플은 특히 함수의 반환 값으로 아주 유용합니다. 웹 페이지를 가져오려고 하는 함수는 페이지 가져오기의 성공 또는 실패를 설명하고자 `(Int, String)` 튜플 타입을 반환할 수도 있습니다. 함수는, 각 타입이 서로 다른, 별개의 두 값을 가진 튜플을 반환함으로써, 단일 타입인 단일 값만 반환하는 경우보다 결과물에 대한 더 유용한 정보를 제공합니다. 더 많은 정보는 [Functions with Multiple Return Values (반환 값이 여러 개인 함수)]({% post_url 2020-06-02-Functions %}#functions-with-multiple-return-values-반환-값이-여러-개인-함수) 부분을 참고하기 바랍니다.

> 튜플은 관련 값들의 간단한 그룹에서 유용한 것입니다. 복잡한 자료 구조의 생성에는 적합하지 않습니다. 자료 구조가 더 복잡하게 되면, 튜플이 아니라, 클래스나 구조체로 모델을 만듭니다. 더 많은 정보는 [Structures and Classes (구조체와 클래스)]({% post_url 2020-04-14-Structures-and-Classes %}) 를 참고하기 바랍니다.

### Optionals (옵셔널)

_옵셔널 (optionals)_ 은 값이 없을 수도 있는 상황에서 사용합니다. '옵셔널' 은 두 개의 가능성: 즉, 값이 _있고 (is)_, 해당 값에 접근하기 위해 옵셔널의 포장을 풀 수 있는 경우, 또는 값이 전혀 _없는 (isn't)_ 경우를 표현합니다.

> 옵셔널이라는 개념은 C 나 오브젝티브-C 에는 존재하지 않습니다. 오브젝티브-C 에서 가장 가까운 것은, "유효한 객체가 없음" 을 의미하는 `nil` 을 써서, 다른 경우라면 객체를 반환했을 법한 메소스가 `nil` 을 반환하는 능력입니다. 하지만, 이는 객체에서만 작동합니다-구조체나, 기본 C 타입, 또는 열거체에서는 작동하지 않습니다. 이러한 타입을 위해, 오브젝티브-C 메소드는 값이 없음을 나타내는 전형적인 (`NSNotFound` 같은) 특수한 값을 반환합니다. 이러한 접근 방식은 메소드를 호출하는 사람이 테스트할 특수한 값이 있음도 알고 검사를 해야함도 기억하고 있다고 가정합니다. 스위프트의 옵셔널은, 특수한 상수 없이도, _어떤 타입에든 (any type at all)_ 값이 없다는 것을 나타내도록 해줍니다.

다음은 옵셔널로 값이 없는 상황을 대처하는 방법에 대한 예제입니다. 스위프트의 `Int` 타입에는 `String` 값을 `Int` 값으로 변환하려는 '초기자 (initializer)' 가 있습니다. 하지만, 모든 문자열을 정수로 변환할 수 있는 것은 아닙니다. 문자열 `"123"` 은 수치 값 `123` 으로 변환할 수 있지만, 문자열 `"hello, world"` 는 변환할 수치 값이 분명하지 않습니다:

아래 예제는 `String` 을 `Int` 로 변환하기 위해 이 초기자를 사용합니다:

```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber 는 "Int?" 나, "optional Int" 타입으로 추론됩니다.
```

초기자가 실패할 수도 있으므로, `Int` 대신, '_옵셔널 (optional)_ `Int`' 를 반환합니다. '옵셔널 `Int`' 는, `Int` 가 아니라, `Int?` 라고 작성합니다. 물음표는 담고 있는 값이 옵셔널임을 나타내는데, _어떤 (some)_ `Int` 값을 담고 있거나, 아니면 _아예 아무 값도 (no value at all)_ 담고 있지 않음을 의미합니다. (`Bool` 값이나 `String` 값 같은, 다른 어떤 것도 담을 수 없습니다. `Int` 이거나, '아예 아무 것도 아닌 것' 입니다.)

#### nil

옵셔널 변수에 특수한 값인 `nil` 을 할당함으로써 '값이 없는 상태 (valueless state)' 를 설정합니다:

```swift
var serverResponseCode: Int? = 404
// serverResponseCode 는 404 라는 실제 Int 값을 담고 있습니다.
serverResponseCode = nil
// serverResponseCode 는 이제 아무 값도 담고 있지 않습니다.
```

> `nil` 은 '옵셔널-아닌 (non-optional)' 상수와 변수와는 사용할 수 없습니다. 정해진 조건 아래에서 코드의 상수나 변수가 값의 없음을 다뤄야 한다면, 이를 항상 적절한 타입의 옵셔널 값으로 선언합니다.

옵셔널 변수를 정의하면서 '기본 값 (default value)' 을 제공하지 않으면, 이 변수는 `nil` 로 자동 설정합니다:

```swift
var surveyAnswer: String?
// surveyAnswer 는 nil 로 자동 설정됩니다.
```

> 스위프트의 `nil` 은 오브젝티브-C 의 `nil` 과 같지 않습니다. 오브젝티브-C 의, `nil` 은 존재하지 않는 객체에 대한 '포인터 (pointer)' 입니다. 스위프트의, `nil` 은 포인터가 아닙니다-이는 정해진 타입의 '값이 없는 것' 입니다. 객체 타입뿐만 아니라, _어떤 (any)_ 타입의 옵셔널에도 `nil` 을 설정할 수 있습니다.

#### If Statements and Forced Unwrapping (If 문과 강제 포장 풀기)

`if` 문을 사용하면 옵셔널을 `nil` 과 비교함으로써 옵셔널이 값을 담고 있는지 알아낼 수 있습니다. 이 비교 연산은 "같음 (equal to)" 연산자 (`==`) 나 "같지 않음 (not equal to)" 연산자 (`!=`) 로 수행합니다:

만약 옵셔널이 값을 가지고 있으면, `nil` 과 "같지 않은" 것으로 간주합니다:

```swift
if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}
// "convertedNumber contains some integer value." 를 인쇄합니다.
```

옵셔널이 값을 담고 있음을 한 번 확신 _하고 (does)_ 나면, 옵셔널 이름 끝에 느낌표 (`!`) 를 붙여서 '실제 값 (underlying value)' 에 접근할 수 있습니다. 느낌표는 실제로, "이 옵셔널이 값을 가짐은 확실하니; 사용하기 바랍니다." 라고 말하는 것입니다. 이것이 옵셔널 값의 '강제 포장 풀기 (forced unwrapping)' 라는 것입니다:

```swift
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}
// "convertedNumber has an integer value of 123." 을 인쇄합니다.
```

`if` 문에 대한 더 많은 것들은, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 을 참고하기 바랍니다.

> `!` 를 '존재하지 않는 옵셔널 값 (nonexistent optional value)' 에 접근하려고 사용하면 '실행 시간 에러 (runtime error)' 를 발생합니다. 값의 포장을-강제로 풀려고 `!` 를 사용하려면 항상 그전에 옵셔널이 '`nil` 아닌 값을 담고 있는지를 먼저 확인합니다.

#### Optional Binding (옵셔널 연결)

_옵셔널 연결 (optional binding)_ 을 사용하면 옵셔널이 값을 담고 있는지 알아내서, 그 경우, 해당 값을 임시 상수나 변수로 사용 가능하게 만들어 줍니다. '옵셔널 연결' 을 `if` 와 `while` 문과 같이 사용하면, 단일 작업으로, 옵셔널 안의 값을 검사하고, 해당 값을 상수나 변수로 추출할 수 있습니다. `if` 와 `while` 문은 [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에서 더 자세하게 설명합니다.

`if` 문의 '옵셔널 연결' 은 다음 처럼 작성합니다:

if let `constantName-상수 이름` = `someOptional-어떤 옵셔널` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
}

[Optionals (옵셔널)](#optionals-옵셔널) 에 있는 `possibleNumber` 예제는 '강제 포장 풀기 (forced unwrapping)' 대신 '옵셔널 연결 (optional binding)' 을 사용하도록 재작성할 수 있습니다:

```swift
if let actualNumber = Int(possibleNumber) {
  print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
  print("The string \"\(possibleNumber)\" could not be converted to an integer")
}
// "The string "123" has an integer value of 123" 을 인쇄합니다.
```

이 코드는 다음처럼 이해할 수 있습니다:

"`Int(possibleNumber)` 에서 반환된 옵셔널 `Int` 가 값을 담고 있으면, `actualNumber` 라는 새로운 상수를 옵셔널에 담긴 값에 설정합니다."

변환이 성공하면, `actualNumber` 상수가 `if` 문의 첫 번째 분기에서 사용 가능해 집니다. 이는 이미 옵셔널 _내에 (within)_ 담긴 값으로 초기화되었으므로, 값에 접근하려고 `!` 접미사를 사용할 필요가 없습니다. 이 예제의, `actualNumber` 는 단순히 변환 결과를 인쇄하는데 사용됩니다.

'옵셔널 연결' 은 상수와 변수 둘 모두와 사용할 수 있습니다. `if` 문의 첫 번째 분기 내에서 `actualNumber` 값을 조작하고 싶으면, 대신 `if var actualNumber` 라고 작성하여, 옵셔널 내에 담긴 값을 상수가 아니라 변수로 사용 가능하도록 만들 수도 있습니다.

단일 `if` 문에는 필요한 만큼 많은 '옵셔널 연결' 과 '불리언 조건' 을, 쉽표로 구분하여, 포함시킬 수 있습니다. 옵셔널 연결에 있는 어떤 값이든 `nil` 이거나 어떤 불리언 조건이든 `false` 로 평가된다면, 전체 `if` 문의 조건이 `false` 인 것으로 간주됩니다. 다음의 `if` 문들은 서로 '동치 (equivalent)' 입니다:

```swift
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
  print("\(firstNumber) < \(secondNumber) < 100")
}
// "4 < 42 < 100" 를 인쇄합니다.

if let firstNumber = Int("4") {
  if let secondNumber = Int("42") {
    if firstNumber < secondNumber && secondNumber < 100 {
      print("\(firstNumber) < \(secondNumber) < 100")
    }
  }
}
// "4 < 42 < 100" 를 인쇄합니다.
```

> `if` 문에서 '옵셔널 연결' 로 생성한 상수와 변수는 `if` 문의 본문 안에서만 사용 가능합니다. 이와 대조적으로, `guard` 문으로 생성한 상수와 변수는, [Early Exit (조기 탈출문)]({% post_url 2020-06-10-Control-Flow %}#early-exit-조기-탈출문) 에서 설명한 것처럼, `guard` 문 이후의 코드에서 사용 가능합니다.

#### Implicitly Unwrapped Optionals (암시적으로 포장을 푸는 옵셔널)

위에서 설명한 것처럼, 옵셔널은 상수나 변수가 "값이 없는" 상태를 가질 수 있는 것임을 나타냅니다. 옵셔널은 값이 존재하는지 보기 위해 `if` 문으로 검사할 수 있으며, 존재할 경우 옵셔널 값에 접근하기 위해 옵셔널 연결을 써서 '조건부로 포장을 풀 (conditionally unwrapped)' 수도 있습니다.

프로그램의 구조에 의해, 해당 값을 처음 설정한 다음에는, 옵셔널이 _항상 (always)_ 값을 가질 것임이 명확할 때가 있습니다. 이 경우, 옵셔널 값에 접근할 때마다 검사하고 포장 풀고 하는 것을 제거하는게 좋은데, 언제나 값이 있다고 가정해도 안전하기 때문입니다.

이러한 종류의 옵셔널을 '_암시적으로 포장을 푸는 옵셔널 (implicitly unwrapped optionals)_' 이라고 정의합니다. '암시적으로 옵셔널' 은 옵셔널로 만들고 싶은 타입 뒤에 물음표 (`String?`) 대신 느낌표 (`String!`) 을 붙여서 작성합니다. 옵셔널을 사용할 때 이름 뒤에 느낌표를 붙이지 말고, 옵셔널을 선언할 때 타입 뒤에 느낌표를 붙입니다.

'암시적으로 포장을 푸는 옵셔널' 은 옵셔널이 처음 정의된 직후 옵셔널 값이 존재함이 확정되고 이후의 모든 순간에 존재한다고 확실하게 가정할 수 있을 때 유용합니다. 스위프트에서 '암시적으로 포장을 푸는 옵셔널' 은, [Unowned References and Implicitly Unwrapped Optional Properties ('소유하지 않는 참조' 와 '암시적으로 포장을 푸는 옵셔널 속성')]({% post_url 2020-06-30-Automatic-Reference-Counting %}#unowned-references-and-implicitly-unwrapped-optional-properties-소유하지-않는-참조와-암시적으로-포장을-푸는-옵셔널-속성) 에서 설명한 것처럼, 주로 클래스 초기화 시에 사용됩니다.

'암시적으로 포장을 푸는 옵셔널' 도 그 이면을 살펴보면 보통의 옵셔널이지만, 접근할 때마다 옵셔널 값의 포장을 풀 필요 없이, '옵셔널-아닌 값 (non-optional value)' 처럼 사용할 수 있습니다. 다음 예제는 자신의 '포장 값' 을 '명시적인 `String`' 으로 접근할 때 '옵셔널 문자열' 과 '암시적으로 포장을 푸는 옵셔널 문자열' 작동 방식의 차이점을 보여줍니다:

```swift
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 느낌표는 필수입니다.

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // 느낌표가 필요 없습니다.
```

'암시적으로 포장을 푸는 옵셔널' 은 옵셔널에 필요하다면 강제로-포장을 푸는 권한을 부여한 것으로 생각할 수 있습니다. '암시적으로 포장을 푸는 옵셔널' 값을 사용할 때, 스위프트는 처음에 이를 평범한 옵셔널 값처럼 사용하려고 시도합니다; 옵셔널처럼 사용할 수 없으면, 스위프트가 값의 포장을-강제로 풉니다. 위 코드에서, 옵셔널 값 `assumedString` 은 `implicitString` 에 값을 할당하기 전에 강제로-포장을 푸는데 이는 `implicitString` 의 타입이 명시적인, 옵셔널-아닌 `String` 이기 때문입니다. 아래 코드의, `optionalString` 은 명시적인 타입을 가지고 있지 않으므로 이는 평범한 옵셔널입니다.

```swift
let optionalString = assumedString
// optionalString 의 타입은 "String?" 이며 assumedString 은 강제로-풀리지 않습니다.
```

'암시적으로 포장을 푸는 옵셔널' 이 `nil` 일 때 이 '포장 값' 에 접근하려고 하면, '실행 시간 에러 (runtime error)' 가 발생할 것입니다. 이 결과는 마치 값을 담지 않은 보통의 옵셔널 뒤에 느낌표를 붙인 경우에서와 정확히 똑같습니다.

'암시적으로 포장을 푸는 옵셔널' 이 `nil` 인지 검사하는 방식은 보통의 옵셔널 검사와 똑같습니다:

```swift
if assumedString != nil {
  print(assumedString)
}
// "An implicitly unwrapped optional string." 를 인쇄합니다.
```

'암시적으로 포장을 푸는 옵셔널' 과 '옵셔널 연결' 을 같이 사용하여, 단일 구문에서 값을 검사하고 포장을 풀 수도 있습니다:

```swift
if let definiteString = assumedString {
  print(definiteString)
}
// "An implicitly unwrapped optional string." 를 인쇄합니다.
```

> 변수가 나중에 `nil` 이 될 가능성이 있을 때는 '암시적으로 포장을 푸는 옵셔널' 을 사용하지 않도록 합니다. 변수가 살아 있는 동안 `nil` 값을 검사할 필요가 있을 경우 항상 보통의 옵셔널 타입을 사용하기 바랍니다.

### Error Handling (에러 처리)

프로그램 실행 중 마주칠 수도 있는 에러 조건에 응답하기 위해 _에러 처리 (error handling)_ 를 사용합니다.

값의 있고 없음으로 함수의 성공이나 실패를 전할 수 있는, 옵셔널과는 대조적으로, 에러 처리는 실패의 실제 원인을 결정하도록 하고, 필요하다면, 프로그램 다른 부분으로 에러를 전파하도록 허용합니다.

함수는 에러 조건과 마주칠 때, 에러를 _던집니다 (throws)_. 이러면 해당 함수를 호출한 쪽에서 에러를 _잡아내고 (catch)_ 적절하게 응답할 수 있습니다.

```swift
func canThrowAnError() throws {
  // 이 함수는 에러를 던질 수도 있고 아닐 수도 있습니다.
}
```

함수는 선언 시에 `throws` 키워드를 포함하는 것으로써 에러를 던질 수 있음을 나타냅니다. 에러를 던질 수 있는 함수를 호출할 땐, `try` 키워드를 표현식 '앞에 붙입니다 (prepend)'.

스위프트는 `catch` 절에서 처리될 때까지 에러를 자동으로 현재 범위 밖으로 전파합니다.

```swift
do {
  try canThrowAnError()
  // 에러가 던져지지 않았습니다.
} catch {
  // 에러가 던져 졌습니다.
}
```

`do` 구문은, 에러를 하나 이상의 `catch` 절로 전파하도록 하는. 새로운 '포함 영역 (containing scope)' 을 생성합니다.

다음은 에러 처리로 서로 다른 에러 조건에 응답하는 방법에 대한 예제입니다:

```swift
func makeASandwich() throws {
  // ...
}

do {
  try makeASandwich()
  eatASandwich()
} catch SandwichError.outOfCleanDishes {
  washDishes()
} catch SandwichError.missingIngredients(let ingredients) {
  buyGroceries(ingredients)
}
```

이 예제에서, `makeASandwich()` 함수는 사용할 수 있는 깨끗한 접시가 없거나 어떤 재료가 빠진 경우 에러를 던질 것입니다. `makeASandwich()` 가 에러를 던질 수 있기 때문에, 함수 호출을 `try` 표현식으로 '포장됩니다 (wrapped).' 함수 호출을 `do` 구문으로 포장함으로써, 던져진 에러가 어떤 것이든 제공된 `catch` 절로 전파될 것입니다.

던져진 에러가 없으면, `eatASandwich()` 함수를 호출합니다. 던져진 에러가 `SandwichError.outOfCleanDishes` 'case 절' 과 일치하면, 그 땐 `washDishes()` 함수를 호출할 것입니다. 던져진 에러가 `SandwichError.missingIngredients` 'case 절' 과 일치하면, 그 땐 `catch` '패턴 (pattern)' 이 붙잡은 '결합된 `[String]` 값' 을 가지고 `buyGroceries(_:)` 함수를 호출합니다.

에러를 던지고, 붙잡고, 전파하는 것은 [Error Handling (에러 처리)]({% post_url 2020-05-16-Error-Handling %}) 에서 아주 자세하게 다룹니다.

### Assertions and Preconditions (단언문과 선행 조건문)

_단언문 (assertions)_ 과 _선행 조건문 (Preconditions)_ 은 '실행 시간 (runtime)' 에 하는 검사입니다. 이는 어떤 코드를 더 실행하기 전에 핵심적인 조건을 만족하고 있는지 확인하려고 사용합니다. 단언문이나 선행 조건문에 있는 '불리언 조건' 이 `true` 로 평가되면, 코드 실행을 평소처럼 계속합니다. 조건이 `false` 로 평가되면, 프로그램의 현재 상태는 무효가 되고; 코드 실행을 중지하며, 앱을 종료합니다.

단언문과 선행 조건문은 코딩하면서 만들고 가지게 된 '가정 (assumptions)' 과 '예상값 (expectations)' 을 표현하기 위해 사용하는 것이므로, 코드에 포함시킬 수 있습니다. 단언문은 개발 도중의 실수와 잘못된 가정을 찾는데 도움이 되며, 선행 조건문은 제품의 '문제점 (issues)' 을 감지하는데 도움이 됩니다.

실행 시간에 예상값을 검증하는 것과는 별도로, 단언문과 선행 조건문은 코드 내에서의 문서화 형식으로도 유용합니다. 위의 [Error Handling (에러 처리)](#error-handling-에러-처리) 에서 설명한 에러 조건과는 달리, 단언문과 선행 조건문은 복구 가능하거나 예상했던 에러를 위해 사용하지 않습니다. 실패한 단언문이나 선행 조건문은 무효한 프로그램 상태를 나타내기 때문에, 실패한 단언문을 잡아내는 방법이란 건 없습니다.

단언문과 선행 조건문의 사용은 '무효 조건은 생기지 않는다는 그런 식의 코드 설계' 를 대체하지 않습니다. 하지만, 유효한 자료와 상태를 강제하도록 이를 사용하는 것은 무효한 상태가 일어난 경우에도 앱이 좀 더 예측 가능하게 종료하도록 하며, 문제를 더 쉽게 '고치도록 (debug)' 도와줍니다. 무효한 상태를 감지하자 마자 곧바로 실행을 중지하는 것도 무효한 상태로 인한 피해를 제한하도록 도와줍니다.

단언문과 선행 조건문의 차이점은 검사하는 시점에 있습니다: 단언문은 '디버그 빌드 (debug builds)' 일 때만 검사하지만, 선행 조건문은 '디버그 빌드와 제품 빌드 (debug and production builds)' 일 때 모두 검사합니다. 제품 빌드일 때는, 단언문 내의 조건을 평가하지 않습니다. 이는 개발 과정 동안, 제품 성능의 손실없이, 원하는 만큼 많은 단언문을 사용할 수 있음을 의미합니다.

#### Debugging with Assertions (단언문으로 디버깅하기)

단언문은 스위프트 표준 라이브러리의 [assert(_:_:file:line:)](https://developer.apple.com/documentation/swift/1541112-assert) 함수를 호출하여 작성합니다. 이 함수에 `true` 나 `false` 로 평가할 표현식과 조건 결과가 `false` 이면 표시할 메시지를 전달합니다. 예를 들면 다음과 같습니다:

```swift
let age = -3
asset(age >= 0, "A person's age can't be less than zero.")
// 이 단언문은 -3 이 >= 0 이 아니기 때문에 실패합니다.
```

이 예제는, `age >= 0` 를 `true` 로 평가하면, 즉 다시 말해서, `age` 의 값이 음수가 아니면, 코드 실행을 계속합니다. `age` 의 값이 음수면, 위 코드처럼, 그 땐 `age >= 0` 을 `false` 로 평가하여, 단언문이 실패하고, 응용 프로그램을 종료합니다.

단언문의 메시지는 생략할 수 있습니다.-예를 들어, 조건문을 그냥 글자 형태로 반복할 때 등입니다.

```swift
assert(age >= 0)
```

코드가 이미 조건을 검사했다면, 단언문이 실패했음을 나타내기 위해 [assertionFailure(_:file:line:)](https://developer.apple.com/documentation/swift/1539616-assertionfailure) 함수를 사용합니다. 예를 들면 다음과 같습니다:

```swift
if age > 10 {
  print("You can ride the roller-coaster or the first ferris wheel.")
} else if age >= 0 {
  print("You can ride the ferris wheel.")
} else {
  assertionFailure("A person's age can't be less than zero.")
}
```

#### Enforcing Preconditions (선행 조건 강제하기)

선행 조건문은, 코드를 계속 실행하려면 반드시 _확실하게 (definitely)_ 참이어야 하는, 조건이 거짓이 될 잠재성을 가질 때마다 사용합니다. 예를 들어, 첨자 연산이 범위를 벗어나지 않았는지 검사하거나, 함수에 유효한 값이 전달 됐는지 검사하기 위해 선행 조건문을 사용하기 바랍니다.

선행 조건문은 [precondition(_:_:file:line:)](https://developer.apple.com/documentation/swift/1540960-precondition) 함수를 호출하여 작성합니다. 이 함수에 `true` 나 `false` 로 평가할 표현식과 조건 결과가 `false` 이면 표시할 메시지를 전달합니다. 예를 들면 다음과 같습니다:

```swift
// 첨자 연산 (subscript) 의 구현부에서  ...
precondition(index > 0, "Index must be greater than zero.")
```

실패가 발생했다는 것-예를 들어, 모든 유효한 입력 자료는 'switch 문' 의 다른 'case 절' 에서 처리됐어야 함에도, 'switch 문의 기본 (default) case 절' 이 선택된 경우 등-을 나타내기 위해 [preconditionFailure(_:file:line:)](https://developer.apple.com/documentation/swift/1539374-preconditionfailure) 함수를 호출할 수도 있습니다.

> '검사하지 않는 모드 (unchecked mode; `-Ounchecked`)' 로 컴파일하면, 선행 조건문을 검사하지 않습니다. 컴파일러는 해당 선행 조건문이 항상 참이라고 가정하며, 이에 따라 코드를 최적화합니다. 하지만, `fatalError(_:file:line:)` 함수는, 최적화 설정과는 상관없이, 항상 실행을 중단합니다.
>
> `fatalError(_:file:line:)` 함수는 프로토타입 및 초기 개발 동안에, 땜빵 구현처럼 `fatalError("Unimplemented")` 을 작성함으로써, 아직 구현하지 않는 기능에 대한 땜빵을 생성하기 위해 사용할 수 있습니다. '치명적인 에러 (fatal errors)' 는 절대 최적화로 없어지지 않기 때문에, 단언문이나 선행 조건문과는 달리, 땜빵 구현과 마주치면 실행이 항상 중단될 거라고 확신할 수 있습니다.

### 다음 장

[Basic Operators (기초 연산자) > ]({% post_url 2016-04-27-Basic-Operators %})

### 참고 자료

[^The-Basics]: 원문은 [The Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^set-dictionary]: 'Set (셋)' 은 수학 용어로 '집합' 을 의미하고, 'Dictionary (딕셔너리)' 는 '사전' 을 의미합니다. 이들의 역할은 용어의 의미와 일치하지만, 각자 '자료 타입' 임을 확실히 나타내기 위해, '셋' 과 '딕셔너리' 라고 발음대로 옮깁니다. 'Array (배열)' 의 경우에는, 이미 '배열' 이라는 용어를 '자료 타입' 으로 널리 사용하고 있으므로 계속 '배열' 이라고 옮깁니다.

[^private-use-Unicode-scalar-values]: 유니코드에는 '15번 평면 (`F0000 ~ FFFFF`) 과 16번 평면 (`100000 ~ 10FFFF`)' 이라는, 두 개의 '사용자 영역 (private-use areas)' 이 있습니다. '사용자 영역 유니코드 크기 값' 은 '유니코드 평면 (Unicode planes) 의 사용자 영역 (private-use areas) 에 있는 값' 을 말합니다. '유니코드 평면' 에 대한 더 자세한 정보는, 위키피디아의 [Plane (Unicode)](https://en.wikipedia.org/wiki/Plane_(Unicode)) 항목과 [유니코드 평면](https://ko.wikipedia.org/wiki/유니코드_평면) 항목을 참고하기 바랍니다.

[^annotation]: 'annotation' 는 사실 '주석' 이라고 옮기는 것이 가장 적당하지만, 프로그래밍 분야에서는 'comments' 가 '주석' 이라고 이미 쓰이고 있으므로, 스위프트의 'annotation' 은 '보조 설명' 이라고 옮깁니다. 실제로 스위프트에서는 'annotation' 을 쓸 일이 거의 없기 때문에 이 용어에는 비중을 크게 두지 않아도 됩니다.

[^backticks]: 'backtics' 는 'grave accent' 라고도 하며 우리말로는 '억음 부호' 라고 합니다. 말이 이해하기 어렵기 때문에 의미 전달을 위해 '역따옴표' 라고 옮깁니다. 'grave accent' 에 대해서는 위키피디아의 [Grave accent](https://en.wikipedia.org/wiki/Grave_accent) 항목 또는 [억음 부호](https://ko.wikipedia.org/wiki/억음_부호) 항목을 참고하기 바랍니다.

[^string-interpolation]: 'interpolation' 은 원래 수학 용어로 '보간법' 이라고 하며, 두 값 사이에 근사식으로 구한 값을 집어넣는 것을 말합니다. 'string interpolation' 은 '문자열 삽입법' 정도로 옮길 수도 있지만, 수학 용어로 '보간법' 이라는 말이 널리 쓰이고 있으므로 '문자열 보간법' 이라고 옮깁니다.

[^escape]: 'escape' 는 '벗어나다' 라는 의미를 가지고 있는데, 컴퓨터 용어에서 'escape character' 는 '(본래의 의미를) 벗어나서 (다른 의미를 가지는) 문자'-즉, '특수한 의미를 가지는 문자' 정도로 이해할 수 있습니다. 참고로 스위프트에는 'escaping closure' 라는 것도 있는데, 이는 '(자신이 정의되어 있는 영역을) 벗어나서 (존재할 수 있는) 클로저'-즉, '영역을 벗어날 수 있는 클로저' 정도의 의미를 가지고 있습니다.

[^word]: 컴퓨터 용어로 'word (워드; 단어)' 는 프로세서에서 한 번에 처리할 수 있는 데이터 단위를 말합니다.

[^base-number]: 'base number' 는 우리 말로 지수의 '밑수', '가수', '기저' 등의 말로 옮길 수 있는데, 컴퓨터 용어로 엄밀하게 말 할 때는 '가수' 라는 말을 쓰는 것 같습니다. 여기서는 일단 지수의 '밑수' 라고 옮깁니다. 부동-소수점 수에서는 'base-number' 가 '유효 숫자' 에 해당하는데, 이에 대한 더 자세한 내용은 위키피디아의 [부동소수점](https://ko.wikipedia.org/wiki/부동소수점) 항목과 [Floating-point arithmetic](https://en.wikipedia.org/wiki/Floating-point_arithmetic) 항목을 참고하기 바랍니다.

[^permutation]: 'permutation' 은 수학 용어로 '순열' 을 의미합니다. '순열' 이라는 것은 서로 다른 n 개의 원소에서 r 개를 선택해서 한 줄로 세울 수 있는 경우의 수를 말합니다. 즉, 스위프트에서 n 개의 원소를 가진 튜플이 가질 수 있는 경우의 수는 이 '순열 (permetation)' 개수 만큼 많다는 걸 의미입니다. 여기서는 '순열' 이라는 말을 좀 더 이해하기 쉽게 '순서 조합' 라는 말로 옮겼습니다. '순열 (permutation)' 에 대한 더 자세한 내용은 위키피디아의 [Permutation](https://en.wikipedia.org/wiki/Permutation) 항목이나 [순열](https://ko.wikipedia.org/wiki/순열) 항목을 참고하기 바랍니다.

[^documents]: '자료의 본성을 암시적으로 문서화 한다' 는 말은, 예를 들어, `Int` 라고 할 것을 `UInt8` 이라고 하면, 코드 자체가 자료의 본성이 `0 ~ 255` 범위라는 것을 제공한다는 의미입니다. '암시적인 문서화 (implicitly documents)' 는 별도의 주석이나 문서 작성없이 코드 자체가 '문서화' 효과를 가지는 것을 말합니다. '문서화' 에 대한 더 자세한 정보는, [API Design Guidelines (API 설계 지침)]({% post_url 2020-09-15-API-Design-Guidelines %}) 에 있는 '문서화 주석' 설명을 참고하기 바랍니다.
