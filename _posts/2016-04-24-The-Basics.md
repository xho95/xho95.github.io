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

> `UInt` 는 특히 '플랫폼 고유의 워드 크기와 똑같은 크기의 부호 없는 정수가 필요할 때' 에만 사용합니다. 이 경우가 아니면, 저장 값이 음수가 아님을 알 때에도, `Int` 가 더 좋습니다. 정수 값에 `Int` 를 일관성 있게 사용하면, [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)](#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 에서 설명한 것처럼, '코드 상호 호환성 (interoperability)' 을 높이고, 서로 다른 수치 타입 사이의 변환을 피하며, '정수 타입 추론' 과도 일치합니다.

### Floating-Point Numbers (부동-소수점 수)

_부동-소수점 수 (floating-point numbers)_ 는, `3.14159`, `0.1`, 및 `-273.15` 같이, '분수 성분을 가진 수' 입니다.

'부동-소수점 타입' 은 정수 타입보다 훨씬 넓은 범위의 값을 표현할 수 있으며, `Int` 에 저장할 수 있는 것보다 훨씬 더 크거나 작은 수도 저장할 수 있습니다. 스위프트는 두 개의 부호 있는 부동-소수점 수치 타입을 제공합니다:

* `Double` 은 64-비트 부동-소수점 수를 표현합니다.
* `Float` 은 32-비트 부동-소수점 수를 표현합니다.

> `Double` 은 적어도 '15 자리 유효 숫자 (decimal digits) 의 정밀도' 를 가지는 반면, `Float` 의 정밀도는 좀 더 적은 '6 자리 유효 숫자' 를 가질 수 있습니다. 사용에 적절한 부동-소수점 타입은 코드 작업에 필요한 값의 본질과 범위에 달려 있습니다. 어느 타입이든 적절할 수 있는 상황이면, `Double` 이 더 좋습니다.

### Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)

스위프트는 _타입-안전 (type-safe)_ 언어입니다. '타입 안전 언어' 는 코드와 작업할 값의 타입이 명확하다는 자신감을 줍니다. 코드가 `String` 을 요구하면, 실수로도 `Int` 를 전달할 수 없습니다.

스위프트는 타입 안전하기 때문에, 코드 컴파일 때 _타입 검사 (type checks)_ 를 수행하며 불일치하는 어떤 타입이든 에러라고 표시합니다. 이는 에러를 개발 과정에서 최대한 빨리 잡아내고 고칠 수 있게 합니다.

'타입-검사' 는 서로 다른 타입의 값과 작업할 때의 에러를 피하도록 돕습니다. 하지만, 이는 모든 선언 상수와 변수의 타입을 지정해야 함을 의미하진 않습니다. 필요한 값의 타입을 지정하지 않으면, 스위프트가 _타입 추론 장치 (type inference)_ 로 적절한 타입을 알아냅니다. '타입 추론 (장치)' 는 코드를 컴파일할 때, 제공한 값을 단순히 검토함으로써, 특별한 표현식의 타입을 컴파일러가 자동으로 이끌어 내도록 합니다.

'타입 추론' 때문에, 스위프트가 C 나 오브젝티브-C 같은 언어보다 타입 선언을 훨씬 덜 요구합니다. 상수와 변수는 여전히 타입을 명시하지만, 대부분의 타입 지정 작업을 알아서 합니다.

'타입 추론' 은 초기 값을 가지고 상수나 변수를 선언할 때 특별히 유용합니다. 이는 종종 선언하는 시점에 상수나 변수에 _글자 값 (literal value_-또는 _literal)_-을 할당함으로써 일어납니다. ('글자 값 ' 은, 아래 예제의 `42` 와 `3.14159` 같이, 소스 코드에 직접 나타나는 값입니다.)

예를 들어, 무슨 타입인지 말하지 않고 새로운 상수에 `42` 라는 글자 값을 할당하면, 정수 같이 보이는 수로 초기화하기 때문에, 상수가 `Int` 이길 원한다고 스위프트가 추론합니다:

```swift
let meaningOfLife = 42
// meaningOfLife 는 Int 타입이라고 추론합니다.
```

마찬가지로, '부동 소수점 글자 값' 에 대한 타입을 지정하지 않으면, `Double` 을 생성하길 원한다고 스위프트가 추론합니다:

```swift
let pi = 3.14159
// pi 는 Double 타입이라고 추론합니다.
```

스위프트는 부동-소수점 수의 타입을 추론할 때 (`Float` 보다는) 항상 `Double` 을 선택합니다.

표현식 안에 정수와 부동-소수점 글자 값을 조합하면, 상황으로부터 `Double` 이라는 타입을 추론할 것입니다:

```swift
let anotherPi = 3 + 0.14159
// anotherPi 도 Double 타입이라고 추론합니다.
```

`3` 이라는 글자 값은 그 안에 명시적인 타입이 있는 것도 아니고 그 자체가 타입도 아니므로, '덧셈 연산에 부동-소수점 글자 값이 있는 것' 으로 부터 `Double` 이라는 적절한 출력 타입을 추론합니다.

### Numeric Literals (수치 글자 값)

'정수 글자 값' 은 다음 같이 작성합니다:

* _10진 (decimal)_ 수, 접두사 없음
* _2진 (binary)_ 수, `0b` 접두사 사용
* _8진 (octal)_ 수, `0o` 접두사 사용
* _16진 (hexadecimal)_ 수, `0x` 접두사 사용

다음의 모든 정수 글자 값은 '`17` 이라는 10진 값' 을 가집니다:

```swift
let decimalInteger = 17
let binaryInteger = 0b10001       // 17 의 2진 표기법
let octalInteger = 0o21           // 17 의 8진 표기법
let hexadecimalInteger = 0x11     // 17 의 16진 표기법
```

부동-소수점 글자 값은 (접두사 없는) 10진수, 또는 (`0x` 접두사를 가진) 16진수일 수 있습니다. 이들은 항상 반드시 '소수점 (decimal point)' 양 쪽 모두에 (16진수 또는) 수가 있어야 합니다. '10진 부동 (floats) 수' 는 옵션으로, 대소문자 `e` 로 지시한, _지수 (exponent)_ 도 가질 수 있으며; '16진 부동 (floats) 수' 는 반드시, 대소문자 `p` 로 지시한, 지수를 가져야 합니다.

`exp` 라는 지수를 가진 10진수는, '밑수 (base number)'[^base-number] 에 10<sup>exp</sup> 을 곱합니다:

* `1.25e2` 는 1.25 x 10<sup>2</sup>, 또는 `125.0` 를 의미합니다.
* `1.25e-2` 는 1.25 x 10<sup>-2</sup>, 또는 `0.0125` 를 의미합니다.

`exp` 라는 지수를 가진 16진수는, '밑수' 에 2<sup>exp</sup> 을 곱합니다:

* `0xFp2` 는 15 x 2<sup>2</sup>, 또는 `60.0` 을 의미합니다.
* `0xFp-2` 는 15 x 2<sup>-2</sup>, 또는 `3.75` 를 의미합니다.

다음의 모든 부동-소수점 글자 값은 '`12.1875` 라는 10진 값' 을 가집니다:

```swift
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0
```

'수치 글자 값' 은 이해가 더 쉽도록 '부가적인 양식 (formatting)' 을 담을 수 있습니다. '정수와 부동수 (floats)' 둘 다 '부가적인 0 을 덧댈 수' 도 있고 '가독성을 돕고자 밑줄 (underscores) 을 담을 수' 도 있습니다. 어느 타입의 양식도 '실제 글자 값' 에는 영향을 주지 않습니다:

```swift
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
```

### Numeric Type Conversion (수치 타입 변환)

코드의 모든 일반-용 정수 상수와 변수는, 음수가 아님을 아는 경우에도, `Int` 타입을 사용합니다. 언제 어디서나 기본 정수 타입을 사용하면 정수 상수와 변수가 코드에서 '곧바로 상호 호환 가능 (interoperable)' 하며 '정수 글자 값으로 추론한 타입과도 일치할 것' 을 의미합니다.

다른 정수 타입은 특히, 외부 소스에서 명시적으로 크기를 정한 자료이거나, 성능, 메모리 사용량, 또는 다른 필요한 최적화 때문에, 머지 않아 그런 임무가 필요한 때만 사용합니다. 이런 상황에서 명시적인 크기 타입을 사용하면 '어떤 값 넘침 (overflows) 사고' 든 잡아내게 도와주며 '사용하는 자료의 본질 (nature) 을 암시적으로 문서화 (documents)' [^documents] 합니다.

#### Integer Conversion (정수 변환)

정수 상수나 변수에 저장할 수 있는 수의 범위는 각 수치 타입마다 다릅니다. `Int8` 상수나 변수는 `-128` 에서 `127` 사이의 수를 저장할 수 있는 반면, `UInt8` 상수나 변수는 `0` 에서 `255` 사이의 수를 저장할 수 있습니다. 정해진 크기의 정수 타입 상수나 변수에 들어 맞지 않는 수치 값은 코드 컴파일 때 에러라고 보고합니다:

```swift
let cannotBeNegative: UInt8 = -1
// UInt8 은 음수를 저장할 수 없으므로, 이를 에러로 보고할 것입니다.
let tooBig: Int8 = Int8.max + 1
// Int8 은 자신의 최대 값 보다 큰 수를 저장할 수 없으므로,
// 이것도 에러로 보고할 것입니다.
```

각 수치 타입이 서로 다른 범위의 값을 저장할 수 있기 때문에, 수치 타입 변환은 각각의 경우마다 반드시 직접 선택해야 합니다. 이런 '직접-선택 (opt-in) 접근 방식' 은 '숨겨진 변환 에러' 를 막아주며 '코드에 타입 변환 의도를 명시' 하도록 돕습니다.

한 특정 수치 타입을 또 다른 걸로 변환하려면, 기존 값을 가지고 원하는 타입의 새 수치 값을 초기화 합니다. 아래 예제에서, 상수 `twoThousand` 의 타입은 `UInt16` 인 반면, 상수 `one` 의 타입은 `UInt8` 입니다. 이들은, 같은 타입이 아니기 때문에, 직접 더할 수 없습니다. 그 대신, 이 예제는 `one` 의 값으로 새로운 `UInt16` 를 생성하는 `UInt16(one)` 을 호출하며, 원래 자리에서 이 값을 사용합니다:

```swift
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
```

이제 더하기 양 쪽 모두가 `UInt16` 타입이기 때문에, 덧셈이 가능합니다. (`twoThousandAndOne` 이라는) 출력 상수는, 두 `UInt16` 값의 합이기 때문에, `UInt16` 타입이라고 추론합니다.

`SomeType(ofInitialValue)` 는 스위프트 타입의 초기자를 호출하고 초기 값을 전달하는 기본 방식입니다. 속을 들여다보면, `UInt16` 에는 `UInt8` 값을 받는 초기자가 있어서, 기존 `UInt8` 로 새로운 `UInt16` 를 만드는데 이 초기자를 사용합니다. 하지만, 여기서 _어떤 (any)_ 타입이든 전달할 수 있는 것은 아니며-`UInt16` 이 초기자를 제공하는 타입이어야만 합니다. (자신이 정의한 타입도 포함하여) 새로운 타입을 받는 초기자를 제공하기 위해 기존 타입을 확장하는 것은 [Extensions (익스텐션; 확장)]({% post_url 2016-01-19-Extensions %}) 에서 다룹니다.

#### Integer and Floating-Point Conversion (정수와 부동-소수점 수 변환)

정수와 부동-소수점 수치 타입 사이의 변환은 반드시 명시적으로 해야 합니다:

```swift
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi 는 3.14159 이고, Double 타입이라고 추론합니다.
```

여기서, 상수 `three` 값으로 새로운 `Double` 타입 값을 생성하므로, 더하기 양 쪽 모두가 같은 타입입니다. 알맞은 곳에서의 이런 변환 없이는, 덧셈을 할 수 없을 것입니다.

부동-소수점 수에서 정수로의 변환도 반드시 명시적으로 해야 합니다. 정수 타입은 `Double` 이나 `Float` 값으로 초기화 할 수 있습니다:

```swift
let integerPi = Int(pi)
// integerPi 는 3 이고, Int 타입이라고 추론합니다.
```

부동-소수점 값은 이런 식으로 새 정수 값을 초기화할 때 사용하면 항상 잘립니다. 이는 `4.75` 가 `4`, `-3.9` 가 `-3` 이 된다는 의미입니다.

> '수치 상수와 변수를 조합하는 규칙' 은 '수치 글자 값 (numeric literals) 에서의 규칙' 과 다릅니다. 수치 글자 값은 명시적인 타입을 가진 것도 그 자체가 타입인 것도 아니기 때문에, 글자 값 `3` 에 글자 값 `0.14159` 를 직접 더할 수 있습니다. 이들의 타입은 컴파일러가 이들을 평가하는 시점에만 추론합니다.

### Type Aliases (타입 별명)

_타입 별명 (type aliases)_ 은 '기존 타입의 대안 (alternative) 이름' 을 정의합니다. 타입 별명은 `typealias` 라는 키워드로 정의합니다.

타입 별명은, 외부 소스에서 크기를 정한 자료와 작업할 때와 같이, 기존 타입을 상황에 더 적절하게 맞는 이름으로 참조하고 싶을 때 유용합니다:

```swift
typealias AudioSample = UInt16
```

한 번 타입 별명을 정의하고 나면, 원본 이름을 사용할 지도 모를 어떤 곳에서든 별명을 사용할 수 있습니다:

```swift
var maxAmplitudeFound = AudioSample.min
// maxAmplitudeFound 는 이제 0 입니다.
```

여기서는, `AudioSample` 을 `UInt16` 의 별명으로 정의합니다. 이는 별명일 뿐이기 때문에, `AudioSample.min` 호출은 실제로 `UInt16.min` 을 호출하는데, 이는 `maxAmplitudeFound` 변수에 `0` 이라는 초기 값을 제공합니다.

### Booleans (불리언; 논리 값)

스위프트는, `Bool` 이라는, 기초적인 _불리언 (Boolean)_ 타입을 가집니다. '불리언 값' 은, 늘 `true` 나 `false` 만 될 수 있기 때문에, _논리 값 (logical)_ 이라고 합니다. 스위프트는, `true` 와 `false` 라는, 두 개의 불리언 상수 값을 제공합니다:

```swift
let orangesAreOrange = true
let turnipsAreDelicious = false
```

`orangesAreOrange` 와 `turnipsAreDelicious` 의 타입은 '불리언 글자 값으로 초기화한다' 는 사실에 의해서 `Bool` 이라고 추론합니다. 위의 `Int` 와 `Double` 에서 처럼, 상수나 변수를 생성하자 마자 `true` 나 `false` 로 설정하면 `Bool` 이라고 선언할 필요가 없습니다. '타입 추론 (장치)' 는 이미 타입을 알고 있는 값으로 상수나 변수를 초기화할 때 더 간결하고 이해하기 쉬운 스위프트 코드를 만들도록 도와줍니다.

불리언 값은 특히 `if` 문 같은 조건문과 작업할 때 유용합니다:

```swift
if turnipsAreDelicious {
  print("Mmm, tasty turnips!")
} else {
  print("Eww, turnips are horrible.")
}
// "Eww, turnips are horrible." 를 인쇄합니다.
```

`if` 문 같은 조건문은 [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 장에서 더 자세히 다룹니다.

스위프트의 '타입 안전 (장치)' 는 '불리언-아닌 (non-Boolean) 값을 `Bool` 로 대체하는 것' 을 막아줍니다. 다음 예제는 컴파일-시간 에러를 보고합니다:

```swift
let i = 1
if i {
  // 이 예제는 컴파일하지 않고, 에러를 보고할 것입니다.
}
```

하지만, 아래의 대안 예제는 유효입니다:

```swift
let i = 1
if i == 1 {
  // 이 예제는 컴파일 성공할 것입니다.
}
```

`i == 1` 비교 결과는 `Bool` 타입이므로, 두 번째 예제는 '타입 검사' 를 통과합니다. `i == 1` 같은 비교 연산은 [Basic Operators (기초 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 장에서 논의합니다.

스위프트의 '다른 타입 안전 예제' 에서 처럼, 이런 접근 방식은 에러 사고를 피하고 특별한 부분의 코드가 항상 명확한 의도를 가지도록 보장합니다.

### Tuples (튜플; 짝)

_튜플 (tuples)_ 은 '여러 개의 값을 단일한 복합 값으로 그룹' 짓습니다. 튜플 안의 값은 어떤 타입이든 될 수 있으며 서로 똑같은 타입이 아니어도 됩니다.

다음 예제의, `(404, "Not Found")` 는 _HTTP 상태 (status) 코드_ 를 설명하는 튜플입니다. 'HTTP 상태 코드' 는 웹 페이지를 요청할 때마다 웹 서버가 반환하는 특수한 값입니다. 요청한 웹 페이지가 존재하지 않으면 `404 Not Found` 라는 상태 코드를 반환합니다.

```swift
let http404Error = (404, "Not Found")
// http404Error 는 (Int, String) 타입이며, (404, "Not Found") 와 같습니다.
```

`(404, "Not Found")` 라는 튜플은 HTTP 상태 코드에: '하나의 수' 와 '사람이-이해할 수 있는 설명' 이라는 별도의 두 값을 주기 위해 `Int` 와 `String` 을 함께 그룹 짓습니다. 이는 "`(Int, String)` 타입의 튜플" 이라고 설명할 수 있습니다.

어떤 '순서로 조합 (permutation)[^permutation] 한 타입' 으로든 튜플을 생성할 수 있으며, 서로 다른 타입을 원하는 만큼 많이 담을 수도 있습니다. `(Int, Int, Int)` 나, `(String, Bool)` , 또는 '진짜 그 외 요구한 어떤 순서 조합의 타입' 이든 가질 수 있습니다.

튜플의 내용물은 별도의 상수나 변수로 _분해 (decompose)_ 한 다음, 평소 처럼 접근할 수 있습니다:

```swift
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// "The status code is 404" 를 인쇄합니다.
print("The status message is \(statusMessage)")
// "The status message is Not Found" 를 인쇄합니다.
```

튜플에서 일부 값만 필요한 경우, 튜플을 분해할 때 '밑줄 (underscore; `_`) 로 튜플의 일부분을 무시합니다:

```swift
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
// "The status code is 404" 를 인쇄합니다.
```

대안으로는, '0에서 시작하는 색인 (index) 번호' 로 튜플의 개별 원소 값에 접근합니다:

```swift
print("The status code is \(http404Error.0)")
// "The status code is 404" 를 인쇄합니다.
print("The status message is \(http404Error.1)")
// "The status message is Not Found" 를 인쇄합니다.
```

튜플을 정의할 때 튜플 개별 원소에 이름을 붙일 수 있습니다:

```swift
let http200Status = (statusCode: 200, description: "OK")
```

튜플 원소에 이름을 붙이면, 원소 이름으로 해당 원소 값에 접근할 수 있습니다:

```swift
print("The status code is \(http200Status.statusCode)")
// "The status code is 200" 를 인쇄합니다.
print("The status message is \(http200Status.description)")
// "The status message is OK" 를 인쇄합니다.
```

튜플은 특히 함수 반환 값으로 유용합니다. 웹 페이지를 가져오려고 하는 함수는 페이지 가져오기의 성공 또는 실패를 설명하는 `(Int, String)` 튜플 타입을 반환할 지도 모릅니다. 함수는, 각각이 서로 다른 타입인, 별개의 두 값을 가진 튜플을 반환함으로써, 단일 타입의 단일 값을 반환하는 경우보다 더 자신의 결과물에 대한 유용한 정보를 제공합니다. 더 많은 정보는, [Functions with Multiple Return Values (반환 값이 여러 개인 함수)]({% post_url 2020-06-02-Functions %}#functions-with-multiple-return-values-반환-값이-여러-개인-함수) 부분을 참고하기 바랍니다.

> 튜플은 서로 관계 있는 값의 단순한 그룹에 유용합니다. 복잡한 자료 구조를 생성하는 데는 적합하지 않습니다. 자료 구조가 더 복잡해질 것 같으면, 튜플 보다는, 클래스나 구조체로 모델링 합니다. 더 많은 정보는, [Structures and Classes (구조체와 클래스)]({% post_url 2020-04-14-Structures-and-Classes %}) 장을 참고하기 바랍니다.

### Optionals (옵셔널)

_옵셔널 (optionals)_ 은 값이 없을 수도 있는 상황에서 사용합니다. 옵셔널은: 값이 _있고 (is)_, 해당 값의 접근을 위해 옵셔널의 포장을 풀 수 있거나, 아니면 값이 전혀 _없다 (isn't)_ 는 두 가지 가능성을 표현합니다.

> C 나 오브젝티브-C 에는 옵셔널이라는 개념이 존재하지 않습니다. 오브젝티브-C 에서 (그나마) 가장 가까운 건, 그 외의 경우라면 객체를 반환했을 메소스가, "유효한 객체가 없음" 을 의미하는, `nil` 을 반환하는 능력입니다. 하지만, 이는 객체에 대해서만 작동합니다-구조체나, C 기초 타입, 또는 열거체 값과는 작동하지 않습니다. 이 타입들의, 값이 없음을 지시하기 위해 오브젝티브-C 메소드는 전형적으로 (`NSNotFound` 같은) 특수한 값을 반환합니다. 이 접근 방식은 메소드를 호출한 쪽이 '테스트 할 특수한 값이 있음도 알고 이 검사를 기억도 하고 있다' 고 가정합니다. 스위프트 옵셔널은, 특수한 상수 없이, _어떤 타입이든 (any type at all)_ 값의 없음을 지시할 수 있게 해줍니다.

다음은 값의 없음을 대처하기 위한 옵셔널의 사용 방법에 대한 예제입니다. 스위프트 `Int` 타입에는 `String` 값을 `Int` 값으로 변환하려고 하는 '초기자 (initializer)' 가 있습니다. 하지만, 모든 문자열을 정수로 변환할 수는 없습니다. `"123"` 이라는 문자열은 `123` 이라는 수치 값으로 변환할 수 있지만, `"hello, world"` 라는 문자열은 변환할 수치 값이 분명하지 않습니다:

아래 예제는 `String` 을 `Int` 로 변환하려고 초기자를 사용합니다:

```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber 는 "Int?" 또는, "optional Int" 타입이라고 추론합니다.
```

초기자는 실패할 지도 모르기 때문에, `Int` 보다는, '_옵셔널 (optional)_ `Int`' 를 반환합니다. 옵셔널 `Int` 는, `Int` 가 아닌, `Int?` 로 작성합니다. 물음표는 담고 있는 값이, _어떠한 (some)_ `Int` 값을 담을 수도 있고, 아니면 _아예 아무 값도 (no value at all)_ 담지 않을 수 있음을 의미하는, 옵셔널임을 지시합니다. (이는 그 외 다른 어떤, `Bool` 값이나 `String` 값 같은, 것도 담을 수 없습니다. 이는 `Int` 이거나, 아예 아무 것도 아닙니다.)

#### nil

옵셔널 변수는 `nil` 이라는 특수 값을 할당함으로써 '값이 없는 (valueless) 상태' 를 설정합니다:

```swift
var serverResponseCode: Int? = 404
// serverResponseCode 는 404 라는 실제 Int 값을 담습니다.
serverResponseCode = nil
// serverResponseCode 는 이제 아무 값도 담고 있지 않습니다.
```

> '옵셔널-아닌 상수와 변수' 에 `nil` 을 사용할 순 없습니다. 코드의 상수나 변수가 정해진 조건 하에서 값의 없음을 다뤄야 한다면, 항상 적절한 타입의 옵셔널 값으로 선언합니다.

옵셔널 변수를 정의하면서 '기본 값' 을 제공하지 않으면, 자동으로 변수를 `nil` 로 설정합니다:

```swift
var surveyAnswer: String?
// surveyAnswer 는 자동으로 nil 로 설정합니다.
```

> 스위프트의 `nil` 은 오브젝티브-C 의 `nil` 과 똑같지 않습니다. 오브젝티브-C 의, `nil` 은 존재하지 않는 객체에 대한 '포인터 (pointer)' 입니다. 스위프트의, `nil` 은 포인터가 아닙니다-이는 정해진 타입 '값의 없음' 입니다. 객체 타입만이 아니라, _어떤 (any)_ 타입의 옵셔널이든 `nil` 로 설정할 수 있습니다.

#### If Statements and Forced Unwrapping (If 문과 강제 포장 풀기)

`if` 문으로 옵셔널을 `nil` 과 비교함으로써 옵셔널이 값을 담고 있는 지를 알아낼 수 있습니다. 이 비교 연산은 "같음 (equal to)" 연산자 (`==`) 나 "같지 않음 (not equal to)" 연산자 (`!=`) 로 수행합니다:

옵셔널이 값을 가지고 있으면, `nil` 과 "같지 않은" 것으로 고려합니다:

```swift
if convertedNumber != nil {
  print("convertedNumber contains some integer value.")
}
// "convertedNumber contains some integer value." 를 인쇄합니다.
```

옵셔널이 값을 담고 _있다고 (does)_ 한 번 확신하고 나면, '옵셔널 이름 끝에 느낌표 (`!`) 를 추가함' 으로써 이 실제 값에 접근할 수 있습니다. 느낌표는 실제로, "이 옵셔널은 확실히 값을 가지고 있다고 알고 있으니; 사용하기 바랍니다." 라고 말하는 것입니다. 이를 '옵셔널 값의 _강제 포장 풀기 (forced unwrapping)_' 라고 합니다:

```swift
if convertedNumber != nil {
  print("convertedNumber has an integer value of \(convertedNumber!).")
}
// "convertedNumber has an integer value of 123." 을 인쇄합니다.
```

`if` 문에 대한 더 많은 것은, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 부분을 참고하기 바랍니다.

> 존재하지 않는 옵셔널 값에 접근하려고 `!` 를 사용하면 실행 시간 에러를 발동합니다. 값의 포장을-강제로 풀려고 `!` 를 사용하기 전에 항상 옵셔널이 '`nil`-아닌 값을 담고 있음을 확실히 합니다.

#### Optional Binding (옵셔널 연결)

옵셔널이 값을 담고 있는 지 알아내고, 그럴 경우, 해당 값을 임시 상수나 변수로 사용 가능하도록, _옵셔널 연결 (optional binding)_ 을 사용합니다. 옵셔널 연결은, 단일 작업으로, 옵셔널 안의 값을 검사하고, 상수나 변수로 해당 값을 추출하기 위해, `if` 와 `while` 문과 사용할 수 있습니다. `if` 와 `while` 문은 [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 장에서 더 자세히 설명합니다.

`if` 문을 위한 옵셔널 연결은 다음 처럼 작성합니다:

&nbsp;&nbsp;&nbsp;&nbsp;if let `constantName-상수 이름` = `someOptional-어떤 옵셔널` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

[Optionals (옵셔널)](#optionals-옵셔널) 부분의 `possibleNumber` 예제는 '강제 포장 풀기' 보단 '옵셔널 연결' 을 사용하도록 재작성할 수 있습니다:

```swift
if let actualNumber = Int(possibleNumber) {
  print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
  print("The string \"\(possibleNumber)\" could not be converted to an integer")
}
// "The string "123" has an integer value of 123" 을 인쇄합니다.
```

이 코드는 다음처럼 이해할 수 있습니다:

"`Int(possibleNumber)` 가 반환한 옵셔널 `Int` 가 값을 담고 있다면, 옵셔널이 담은 값을 `actualNumber` 라는 새로운 상수에 설정합니다."

변환을 성공하면, `actualNumber` 라는 상수가 `if` 문의 첫 번째 분기 안에서 사용 가능해 집니다. 이미 옵셔널 _안에 (within)_ 담긴 값으로 초기화 했으므로, 값에 접근할 때 `!` 접미사를 사용하지 않습니다. 이 예제의, `actualNumber` 는 변환 결과를 단순히 인쇄하는데 사용합니다.

상수와 변수 둘 다 옵셔널 연결과 사용할 수 있습니다. `actualNumber` 의 값을 `if` 문 첫 번째 분기 안에서 조작하고 싶으면, `if var actualNumber` 라고 대신 작성하면, 옵셔널 안에 담긴 값을 상수 보단 변수로 사용 가능하게 할 수 있을 것입니다.

쉼표로 구분하여, 필요한 만큼 '많은 옵셔널 연결과 불리언 조건' 을, 단일 `if` 문 안에 포함할 수 있습니다. 옵셔널 연결의 어떤 값이든 `nil` 이거나 어떤 불리언 조건이든 `false` 라고 평가한다면, `if` 문 조건 전체가 `false` 인 것으로 고려합니다. 다음 `if` 문들은 서로 '동치 (equivalent)' 입니다:

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

> '`if` 문의 옵셔널 연결로 생성한 상수와 변수' 는 '`if` 문 본문 안에서만 사용 가능' 합니다. 이와 대조적으로, `guard` 문으로 생성한 상수와 변수는, [Early Exit (이른 탈출문)]({% post_url 2020-06-10-Control-Flow %}#early-exit-이른-탈출문) 에서 설명한 것처럼, `guard` 문 뒤의 코드 줄에서 사용 가능합니다.

#### Implicitly Unwrapped Optionals (암시적으로 포장 푸는 옵셔널)

위에 설명한 것처럼, 옵셔널은 상수나 변수가 "값이 없을" 수 있음을 지시합니다. 옵셔널은 `if` 문으로 값의 존재를 검사할 수 있으며, 옵셔널 값이 존재하면 이에 접근하고자 '옵셔널 연결' 을 가지고 조건부로 포장을 풀 수 있습니다.

때때로 프로그램 구조에 의해, 최초로 값을 설정한 후, 옵셔널이 _항상 (always)_ 값을 가짐이 명확할 때가 있습니다. 이 경우, 언제나 값이 있다고 가정해도 안전하기 때문에, 옵셔널 값에 접근할 때마다 필요한 검사와 포장 풀기를 제거하는 것이 유용합니다.

이런 종류의 옵셔널을 _암시적으로 포장 푸는 옵셔널 (implicitly unwrapped optionals)_ 이라고 정의합니다. '암시적으로 포장 푸는 옵셔널' 은 옵셔널로 만들고 싶은 타입 뒤에 물음표 (`String?`) 보단 느낌표 (`String!`) 를 붙여서 작성합니다. 사용할 때 옵셔널 이름 뒤에 느낌표를 붙이기 보다는, 선언할 때 옵셔널 타입 뒤에 느낌표를 붙입니다.

'암시적으로 포장 푸는 옵셔널' 은 옵셔널 값이 최초로 옵셔널을 정의한 바로 뒤 존재를 확정하고 그 후의 모든 시점에 존재를 확실히 가정할 수 있을 때 유용합니다. 스위프트에서 '암시적으로 포장 푸는 옵셔널' 은, [Unowned References and Implicitly Unwrapped Optional Properties ('소유하지 않는 참조' 와 '암시적으로 포장 푸는 옵셔널 속성')]({% post_url 2020-06-30-Automatic-Reference-Counting %}#unowned-references-and-implicitly-unwrapped-optional-properties-소유하지-않는-참조와-암시적으로-포장-푸는-옵셔널-속성) 에서 설명한 것처럼, 클래스를 초기화하는 동안에 주로 사용합니다.

속을 들여다보면 '암시적으로 포장 푸는 옵셔널' 도 보통의 옵셔널이지만, 매 번 접근할 때마다 옵셔널 값의 포장을 풀 필요 없는, '옵셔널-아닌 값' 처럼 사용할 수도 있습니다. 다음 예제는 '자신의 포장 값을 명시적인 `String` 으로 접근' 할 때 '옵셔널 문자열' 과 '암시적으로 포장 푸는 옵셔널 문자열' 의 동작의 차이를 보여줍니다:

```swift
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 느낌표를 요구함

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // 느낌표가 필요 없음
```

'암시적으로 포장 푸는 옵셔널' 은 '필요하다면 포장을-강제로 푸는 권한을 옵셔널에 준 것' 으로 생각할 수 있습니다. '암시적으로 포장 푸는 옵셔널 값' 을 사용할 때, 스위프트는 처음에 이를 평범한 옵셔널 값으로 사용하려고 하며; 옵셔널로 사용할 수 없으면, 스위프트가 값의 포장을-강제로 풉니다. 위 코드에서는, `implicitString` 이 명시적으로, 옵셔널-아닌 `String` 타입이기 때문에 `assumedString` 이라는 옵셔널 값을 `implicitString` 에 할당하기 전에 포장을-강제로 풉니다. 아래 코드의, `optionalString` 은 명시적인 타입이 없으므로 평범한 옵셔널입니다.

```swift
let optionalString = assumedString
// optionalString 의 타입은 "String?" 이며 assumedString 의 포장은-강제로 풀지 않습니다.
```

'암시적으로 포장 푸는 옵셔널이 `nil` 인데 이 포장 값에 접근' 하려고 하면, 실행 시간 에러를 발동할 것입니다. 이 결과는 마치 값을 담지 않은 보통의 옵셔널 뒤에 느낌표를 둔 것과 정확히 똑같습니다.

'암시적으로 포장 푸는 옵셔널이 `nil` 인 지' 는 보통의 옵셔널 검사와 똑같은 방식으로 검사할 수 있습니다:

```swift
if assumedString != nil {
  print(assumedString)
}
// "An implicitly unwrapped optional string." 를 인쇄합니다.
```

'암시적으로 포장 푸는 옵셔널' 을 '옵셔널 연결' 과 같이 사용하면, 단일 구문으로 자신의 값 검사와 포장 풀기를 할 수 있습니다:

```swift
if let definiteString = assumedString {
  print(definiteString)
}
// "An implicitly unwrapped optional string." 를 인쇄합니다.
```

> 더 나중에 변수가 `nil` 이 될 가능성이 있을 때는 '암시적으로 포장 푸는 옵셔널' 을 사용하지 않도록 합니다. 변수 수명 동안 `nil` 값 검사가 필요하다면 항상 보통의 옵셔널 타입을 사용하기 바랍니다.

### Error Handling (에러 처리)

프로그램 실행 동안 마주칠 수도 있는 에러 조건에 응답하고자 _에러 처리 (error handling)_ 를 사용합니다.

함수의 성공이나 실패를 값의 있고 없음으로 통신할 수 있는, 옵셔널과는 대조적으로, 에러 처리는 실패의 실제 원인을 결정하도록, 그리고, 필요하다면, 프로그램 다른 부분으로 에러를 전파하도록 허용합니다.

함수가 에러 조건과 마주칠 때, 에러를 _던집니다 (throws)_. 그러면 해당 함수를 호출한 쪽에서 적절하게 에러를 _잡아내고 (catch)_ 응답할 수 있습니다.

```swift
func canThrowAnError() throws {
  // 이 함수는 에러를 던질 수도 아닐 수도 있습니다.
}
```

함수는 자신의 선언에 `throws` 키워드를 포함함으로써 에러를 던질 수 있다고 지시합니다. 에러를 던질 수 있는 함수를 호출할 때는, 표현식 앞에 `try` 키워드를 붙입니다.

스위프트는 `catch` 절이 처리할 때까지 자동으로 에러를 현재 범위 밖으로 전파합니다.

```swift
do {
  try canThrowAnError()
  // 아무런 에러도 던지지 않은 경우
} catch {
  // 에러를 던진 경우
}
```

`do` 문은, 에러를 하나 이상의 `catch` 절로 전파하도록 허용하는. 새로운 '담은 (containing) 영역' 을 생성합니다.

다음은 서로 다른 에러 조건에 응답하기 위해서 에러 처리를 사용하는 방법에 대한 예제입니다:

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

이 예제에서는, 사용 가능한 깨끗한 접시가 없거나 어떤 재료가 빠지면 `makeASandwich()` 함수가 에러를 던질 것입니다. `makeASandwich()` 가 에러를 던질 수 있기 때문에, 함수 호출을 `try` 표현식으로 포장합니다. 함수 호출을 `do` 문으로 포장함으로써, 어떤 에러를 던지든 제공된 `catch` 절로 전파할 것입니다.

아무 에러도 던지지 않으면, `eatASandwich()` 함수를 호출합니다. 에러를 던지는데 이것이 '`SandwichError.outOfCleanDishes` case 절' 과 일치하면, 그 때는 `washDishes()` 함수를 호출할 것입니다. 에러를 던지는데 이것이 '`SandwichError.missingIngredients` case 절' 과 일치하면, 그 때는 '`catch` 절 패턴 (pattern) 이 붙잡는 `[String]` 결합 값' 을 가지고 `buyGroceries(_:)` 함수를 호출합니다.

에러 던지기, 붙잡기, 전파하기는 [Error Handling (에러 처리)]({% post_url 2020-05-16-Error-Handling %}) 장에서 아주 자세하게 다룹니다.

### Assertions and Preconditions (단언문과 선행 조건문)

_단언문 (assertions)_ 과 _선행 조건문 (Preconditions)_ 은 '실행 시간에 하는 검사' 입니다. 어떤 코드를 더 실행하기 전에 핵심 조건을 만족하고 있는 지를 확실히 하려고 이를 사용합니다. 단언문 또는 선행 조건문의 불리언 조건 평가가 `true` 면, 평소 처럼 코드 실행을 계속합니다. 조건 평가가 `false` 면, 현재 프로그램 상태는 무효이며; 코드 실행을 중지하고, 앱을 종료합니다.

단언문과 선행 조건문은 '코딩하는 동안 만들고 가지게 된 가정 (assumptions) 과 예상 값 (expectations)' 을 나타내고자 사용하므로, 이를 코드에 포함할 수 있습니다. 단언문은 '잘못된 가정과 실수' 를 개발 중에 찾도록 도와주며, 선행 조건문은 '제품의 문제점 (issues)' 을 탐지하도록 도와줍니다.

예상 값을 실행 시간에 검증하는 것에 더하여, 단언문과 선행 조건문은 '코드 안에서 문서화하는 유용한 형식' 이 되기도 합니다. 위의 [Error Handling (에러 처리)](#error-handling-에러-처리) 에서 논의한 에러 조건들과 달리, 단언문과 선행 조건문은 '복구 가능하거나 예상했던 에러' 에 사용하는 것이 아닙니다. 실패한 단언문 또는 선행 조건문은 프로그램 상태가 무효함을 지시하기 때문에, 실패한 단언문을 잡아내는 방법 같은 건 없습니다.

단언문과 선행 조건문의 사용은 '무효한 조건이 생기지 않도록 하는 식의 코드 설계' 를 대신하지 않습니다. 하지만, 유효한 자료와 상태를 강제하도록 이를 사용하면 무효 상태가 일어나도 더 예측 가능하게 앱을 종결하며, 문제를 더 쉽게 디버그하도록 도와줍니다. 무효 상태를 탐지하자 마자 실행을 중지하는 것도 해당 무효 상태로 인한 피해를 제한하도록 돕습니다.

단언문과 선행 조건문의 차이는 검사 시점에 있는데: 단언문은 '디버그 제작 (debug builds) 일 때만 검사' 하지만, 선행 조건문은 '디버그와 제품 제작 (debug and production builds) 둘 다에서 검사' 합니다. '제품 제작' 일 때는, 단언문 안의 조건을 평가하지 않습니다. 이는 개발 과정 중에 원하는 만큼 많은 단언문을 사용해도, 제품 성능에는 큰 영향이 없다는, 의미입니다.

#### Debugging with Assertions (단언문으로 디버깅하기)

단언문은 스위프트 표준 라이브러리의 [assert(_:_:file:line:)](https://developer.apple.com/documentation/swift/1541112-assert) 함수 호출로 작성합니다. 이 함수에 '`true` 또는 `false` 로 평가할 표현식' 과 '조건 결과가 `false` 면 보여줄 메시지' 를 전달합니다. 예를 들면 다음과 같습니다:

```swift
let age = -3
asset(age >= 0, "A person's age can't be less than zero.")
// 이 단언문은 -3 이 0 보다 크지 않기 때문에 실패합니다.
```

이 예제, 코드는 `age >= 0` 평가가 `true` 면, 즉, `age` 값이 음수가 아니면, 실행을 계속합니다. 위 코드 처럼, `age` 값이 음수면, 그 때는 `age >= 0` 평가가 `false` 며, 단언문이 실패하고, 응용 프로그램을 종결합니다.

단언문 메시지는-예를 들어, 조건문을 그냥 글자 그대로 되풀이 할 때에-생략할 수 있습니다.

```swift
assert(age >= 0)
```

이미 코드에서 조건을 검사했으면, 단언문의 실패를 지시할 때 [assertionFailure(_:file:line:)](https://developer.apple.com/documentation/swift/1539616-assertionfailure) 함수를 사용합니다. 예를 들면 다음과 같습니다:

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

선행 조건문은, 잠재적으로 거짓일 수 있는 조건이, 코드를 계속 실행하려면 반드시 _확실히 (definitely)_ 참이어야 할 때마다, 사용합니다. 예를 들어, 경계를 벗어난 첨자 연산인 지 검사하거나, 유효한 값을 함수에 전달했는 지 검사하려면 선행 조건문을 사용합니다.

선행 조건문은 [precondition(_:_:file:line:)](https://developer.apple.com/documentation/swift/1540960-precondition) 함수 호출로 작성합니다. 이 함수에 '`true` 또는 `false` 로 평가할 표현식' 과 '조건 결과가 `false` 면 보여줄 메시지' 를 전달합니다. 예를 들면 다음과 같습니다:

```swift
// 첨자 연산 구현에서...
precondition(index > 0, "Index must be greater than zero.")
```

실패가 일어났다는 것-예를 들어, '모든 유효한 입력 자료는 switch 문의 다른 case 절에서 처리했어야 함' 에도, 'switch 문의 기본 case 절' 을 취한 경우 등-을 지시하기 위해 [preconditionFailure(_:file:line:)](https://developer.apple.com/documentation/swift/1539374-preconditionfailure) 함수를 호출할 수도 있습니다.

> '검사 안하는 (unchecked) 모드 (`-Ounchecked`)' 로 컴파일하면, 선행 조건문을 검사하지 않습니다. 컴파일러는 선행 조건문을 항상 참으로 가정하며, 그에 따라 코드를 최적화합니다. 하지만, `fatalError(_:file:line:)` 함수는, 최적화 설정과 상관없이, 실행을 항상 중단합니다.
>
> `fatalError(_:file:line:)` 함수는 프로토 타입 및 이른 시기의 개발 중에 아직 구현 안된 기능에 대해, `fatalError("Unimplemented")` 를 작성함으로써, '토막 (stub) 구현'[^stub] 을 생성하고자, 사용할 수 있습니다. '치명적인 에러 (fatal errors)' 는 최적화로 절대 없어지지 않기 때문에, 단언문이나 선행 조건문과는 달리, '토막 구현' 과 마주치면 항상 실행이 중단된다고 확신할 수 있습니다.

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

[^permutation]: 'permutation' 은 수학 용어로 '순열' 을 의미합니다. '순열' 이라는 것은 서로 다른 n 개의 원소에서 r 개를 선택해서 한 줄로 세울 수 있는 경우의 수를 말합니다. 즉, 스위프트에서 'n 개의 원소를 가진 튜플' 이 가질 수 있는 경우의 수는 이 '순열 (permetation) 개수 만큼 많다' 는 의미입니다. 여기서는 '순열' 이라는 말을 좀 더 이해하기 쉽게 '순서 조합' 라는 말로 옮겼습니다. '순열 (permutation)' 에 대한 더 자세한 정보는, 위키피디아의 [Permutation](https://en.wikipedia.org/wiki/Permutation) 항목과 [순열](https://ko.wikipedia.org/wiki/순열) 항목을 참고하기 바랍니다.

[^documents]: '사용하는 자료의 본질을 암시적으로 문서화한다' 는 것은, 예를 들어, `Int` 라고 할 것을 `UInt8` 이라고 하면, 코드만으로 자료가 `0 ~ 255` 범위라는 것을 알려준다는 의미입니다. '암시적인 문서화 (implicitly documents)' 는 별도의 주석이나 문서 작성 없이 '코드 자체가 문서화 효과를 가지는 것' 을 말합니다. '문서화' 에 대한 더 자세한 정보는, [API Design Guidelines (API 설계 지침)]({% post_url 2020-09-15-API-Design-Guidelines %}) 에 있는 '문서화 주석' 부분의 설명을 참고하기 바랍니다.

[^stub]: '토막 구현 (stub implementation)' 은 소프트웨어 개발 과정에서 다른 기능을 위해 (잠시) 세워 놓은 코드입니다. '토막 구현' 에 대한 더 자세한 정보는, 위키피디아의 [Method stub](https://en.wikipedia.org/wiki/Method_stub) 항목과 [메소드 스텁](https://ko.wikipedia.org/wiki/메소드_스텁) 항목을 참고하기 바랍니다.  