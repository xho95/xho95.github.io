---
layout: post
comments: true
title:  "Swift 5.2: The Basics (기초)"
date:   2016-04-24 19:45:00 +0900
categories: Swift Language Grammar Basics
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [The Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html) 부분[^The-Basics]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## The Basics (기초)

스위프트는 iOS, macOS, watchOS, 그리고 tvOS 용 앱 개발을 위한 새로운 프로그래밍 언어입니다. 그럼에도 불구하고, C 와 오브젝티브-C 언어로 개발한 경험이 있다면 스위프트의 많은 부분들이 이미 익숙할 것입니다.

스위프트는 C 와 오브젝티브-C 언어에 있는 모든 기본 타입들을 자신만의 버전으로 제공하묘, 여기에는 정수를 위한 `Int`, 부동 소수점 값을 위한 `Double` 과 `Float`, '불린 (Boolean)' 값을 위한 `Bool`, 그리고 텍스트 데이터를 위한 `String` 을 포함합니다. 스위프트는, [Collection Types (집합체 타입)]({% post_url 2016-06-06-Collection-Types %}) 에서 설명한 것처럼, 강력한 세 개의 주요 컬렉션 (collection; 집합체) 타입인, `Array` (배열), `Set` (셋), 그리고 `Dictionary` (딕셔너리) 도 제공합니다.

C 언어 처럼, 스위프트도 '변수 (variables)' 를 사용하여 '식별 가능한 이름 (identifying name)' 으로 값을 저장하고 참조합니다. 스위프트는 값을 바꿀 수 없는 변수 역시 광범위하게 사용합니다. 이를 '상수 (constants)' 라고 하는데, C 언어의 상수보다 훨씬 더 강력합니다. 상수는 스위프트 전반에 걸쳐 사용되는 것으로 바꿀 필요가 없는 값과 작업할 때 코드를 더 안전하고 의도는 더 명확하게 만들어 줍니다.

이런 익숙한 타입들에 더하여, 스위프트는 오브젝티드-C 언어에는 없는 고급 타입들도 도입했는데, '튜플 (tuple)' 이 이에 해당합니다. 튜플은 값들을 '그룹지어 (group)' 생성하고 전달할 수 있게 해줍니다. 튜플을 사용하면 함수에서 여러 개의 값을 '단일한 복합 값 (single compound value)' 의 형태로 반환할 수 있습니다.

스위프트는, 값이 없는 상태를 처리하는, '옵셔널 타입 (optional types)' 도 도입했습니다. '옵셔널' 은 "여기 값이 _있으며 (is)_, 그 값은 x 입니다" 라고 하거나 "여기에 값이 전혀 _없습니다 (isn't)_" 라고 말합니다. '옵셔널' 을 사용하는 것은 오브젝티브-C 언어의 포인터에 `nil` 을 사용하는 것과 비슷하지만, '클래스 (class)' 만이 아니라, 어떤 타입과도 작업할 수 있습니다. '옵셔널' 은 오브젝티브-C 언어의 `nil` 포인터보다 더 안전하고 의미 표현도 더 쉬울 뿐만 아니라, 스위프트의 가장 강력한 특징 중에서도 심장부에 해당합니다.

스위프트는 '_타입-안전 (type-sefe)_' 언어로써, 이는 코드가 작업할 수 있는 값의 타입을 명확하게 알 수 있도록 언어 차원에서 도와준다는 것을 의미합니다. 코드에서 `String` 을 필수로 요구할 경우, '타입 안전 장치 (type safety)' 는 실수로 `Int` 를 전달하는 것을 막아줍니다. 이와 마찬가지로, '타입 안전 장치' 는 옵셔널이-아닌 `String` 을 필수로 요구하는 코드-조각에 우현히 옵셔널 `String` 을 전달하는 것도 막아줍니다. '타입 안전 장치' 는 개발 과정에서 최대한 빨리 에러를 잡아내고 고칠 수 있게 도와줍니다.

### Constants and Variables (상수와 변수)

상수와 변수는 (`maximumNumberOfLoginAttempts` 또는 `welcomeMessage` 같은) 이름을 (수치 값 `10` 또는 문자열 `"Hello"` 같은) 특정한 타입의 값과 결합합니다. _상수 (constant)_ 의 값은 일단 한번 설정되면 바꿀 수 없지만, _변수 (variable)_ 는 나중에 다른 값으로 설정할 수 있습니다.

#### Declaring Constants and Variables (상수와 변수 선언하기)

상수와 변수는 사용하기 전에 반드시 선언되어 있어야 합니다. 상수 선언은 `let` 키워드를 사용하며 변수는 `var` 키워드를 사용합니다. 다음은 상수와 변수를 사용하여 사용자의 로그인 시도 횟수를 추적하는 방법에 대한 예제입니다:

```swift
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
```

이 코드는 다음과 같이 읽을 수 있습니다:

"`maximNumberOfLoginAttempts` 라는 새로운 상수를 선언하고, `10` 이라는 값을 부여합니다. 그다음, `currentLoginAttempt` 라는 새로운 변수를 선언하고, `0` 이라는 초기 값을 부여합니다."

이 예제에서, '로그인 시도로 허용된 최대 횟수 (the maximum number of allowed login attempts)' 는 상수로 선언되어 있는데, 최대 값은 절대로 바뀌지 않기 때문입니다. '현재 로그인 시도 횟수 (the current login attempt counter)' 는 변수로 선언되어 있는데, 이 값은 각각의 로그인 시도가 실패하고 나면 반드시 증가해야 하기 때문입니다.

여러 개의 상수 또는 여러 개의 변수를, '쉼표 (commas)' 로 구분하여, 한 줄로 선언할 수 있습니다:

```swift
var x = 0.0, y = 0.0, z = 0.0
```

> 코드에서 저장된 값이 바뀌지 않을 거라면, 항상 `let` 키워드를 써서 상수로 선언합니다. 변수는 저장하는 값이 바뀔 수 있어야 할 때만 사용하기 바랍니다.

#### Type Annotations (타입 보조 설명)

상수 또는 변수를 선언할 때 _타입 보조 설명 (type annotation)_[^annotation] 을 제공하면, 상수나 변수가 저장할 수 있는 값의 종류를 명확하게 할 수 있습니다. '타입 보조 설명' 을 작성하려면 상수나 변수의 이름 뒤에 콜론을 붙이고, 뒤에 공백을 넣은 다음, 사용할 타입의 이름을 붙이면 됩니다.

다음 예제는 `welcomeMessage` 라는 변수에 대한 '타입 보조 설명' 을 제공하여, 이 변수가 `String` 값을 저장할 수 있음을 지시합니다:

```swift
var welcomeMessage: String
```

선언문에 있는 콜론은 "...타입인..." 을 의미하므로, 위의 코드는 다음 처럼 읽을 수 있습니다:

"`String` 타입인 `welcomeMessage` 라는 변수를 선언합니다."

"`String` 타입인" 이라는 구절은 "어떤 `String` 값도 저장할 수 있다" 는 것을 의미합니다. 저장할 수 있는 "어떤 것의 타입" (또는 "어떤 것의 종류") 라는 의미로 생각하기 바랍니다.

`welcomeMessage` 변수에는 이제 에러 없이 어떤 문자열 값도 설정할 수 있습니다:

```swift
welcomeMessage = "Hello"
```

같은 타입의 관계 있는 변수들 여러 개를 한 줄에 정의할 수도 있는데, 이 때는 쉼표로 구분한 다음, 마지막 변수 이름 뒤에 '타입 보조 설명' 을 한 번만 붙이면 됩니다:

```swift
var red, green, blue: Double
```

> 실제로 '타입 보조 설명 (type annotations)' 을 작성할 일은 극히 드뭅니다. 상수나 변수를 정의하는 시점에 초기 값을 제공하면, 스위프트는, [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)](#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 에서 설명한 것처럼, 거의 항상 해당 상수나 변수에 대한 타입을 추론할 수 있습니다. 위의 `welcomeMessage` 예제는, 초기 값을 제공하지 않으므로, `welcomeMessage` 변수의 타입을 초기 값으로 추론하지 않고 '타입 보조 설명' 으로 지정한 것입니다.

#### Naming Constants and Variables (상수와 변수 이름짓기)

상수와 변수의 이름은, '유니코드 문자 (Unicode characters)' 를 포함하여, 거의 어떤 문자라도 가질 수 있습니다:

```swift
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"
```

상수와 변수의 이름은 '공백 (whitespace)', '수학 기호 (mathematical symbols)', '화살표 (arrows)', '사용자 영역 유니코드 크기 값 (private-use Unicode scalar values)'[^private-use-Unicode-scalar-values], 또는 '선-그리기 (line-drawing)' 및 '상자-그리기 문자 (box-drawing characters)' 를 가질 수 없습니다. 숫자로 시작하는 것도 안되지만, 이름 내의 다른 곳에서 숫자를 포함하는 것은 괜찮습니다.

일단 한번 상수나 변수를 정해진 타입으로 선언하면, 같은 이름으로 다시 선언하거나, 다른 타입의 값을 저장하도록 바꿀 수 없습니다. 상수를 변수로 바꾸거나 변수를 상수로 바꾸는 것도 안됩니다.

> 상수나 변수에 '스위프트에서 예약된 키워드 (reserved Swift keyword)' 와 같은 이름을 부여해야 할 경우, 이름으로 사용할 때 키워드를 '역따옴표 (backticks; `` ` ``)'[^backticks] 로 감싸도록 합니다. 하지만, 선택의 여지가 전혀 없는 상황이 아니라면 키워드를 이름으로 사용하는 것을 피하도록 합니다.

기존 변수의 값은 호환 가능한 타입의 다른 값으로 바꿀 수 있습니다. 다음 예제는, `friendlyWelcome` 의 값을 `"Hello!"` 에서 `"Bonjour!"` 로 바꿉니다:

```swift
var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"
// friendlyWelcome 은 이제 "Bonjour!" 입니다.
```

변수와는 다르게, 상수의 값은 설정한 다음 바꿀 수 없습니다. 그렇게 하려고 하면 코드를 컴파일할 때 에러를 띄웁니다:

```swift
let languageName = "Swift"
languageName = "Swift++"
// 이것은 컴파일-시간 에러가 됩니다: languageName cannot be changed. (languageName 은 바꿀 수 없습니다.)
```

#### Prints Constants and Variables (상수와 변수 출력하기)

상수나 변수의 현재 값은 `print(_:separator:terminator:)` 함수로 출력할 수 있습니다:

```swift
print(friendlyWelcome)
// "Bonjour!" 를 출력합니다.
```

`print(_:separator:terminator:)` 함수는 하나 이상의 값을 적당한 결과로 출력하는 전역 함수입니다. 예를 들어, 'Xcode (엑스코드)' 에서, `print(_:separator:terminator:)` 함수는 그 결과를 'Xcode' 의 "console (콘솔)" 창에 출력합니다. `separator` 와 `terminator` 매개 변수는 '기본 설정 값 (default values)' 을 갖고 있으므로, 함수를 호출할 때 생략할 수 있습니다. 기본적으로, 이 함수는 출력하는 줄에 '줄 끊음 (line break)' 을 추가하여 끝냅니다. 값을 '줄 끊음' 없이 출력하려면, 빈 문자열을 'terminator (종결자)' 로 전달합니다-예를 들어, `print(someValue, terminator : "")` 라고 합니다. '기본 설정 값을 가지는 매개 변수' 에 대한 더 많은 정보는, [Default Parameter Values (기본 설정 매개 변수 값)]({% post_url 2020-06-02-Functions %}#default-parameter-values-기본-설정-매개-변수-값) 을 참고하기 바랍니다.

스위프트는 '_문자열 보간법 (string interpolation)_' 을 사용하여 더 긴 문자열 속에 '자리 표시 (placeholder)' 용도로 상수나 변수의 이름을 포함한 후, 이를 해당 상수나 변수의 현재 값으로 대체하도록 스위프트에게 알립니다. 이는 이름을 괄호로 감싼 후, 시작 괄호 앞에 '역-빗금 (backslash)' 으로 'escape (벗어나게)'[^escape] 하면 됩니다:

```swift
print("The current value of friendlyWelcome is \(friendlyWelcome)")
// "The current value of friendlyWelcome is Bonjour!" 를 출력합니다.
```

> 문자열 보간법과 같이 사용할 수 있는 모든 '옵션 (options)' 은 [String Interpolation (문자열 보간법)]({% post_url 2016-05-29-Strings-and-Characters %}#string-interpolation-문자열-보간법) 에서 설명합니다.

### Comments (주석)

'주석 (comments)' 은 코드 내에 실행이 안되는 글을 포함시켜, 기록이나 기억을 되살리는 용도로 사용하는 것입니다. 주석은 코드를 컴파일할 때 스위프트 컴파일러에 의해 무시됩니다.

스위프트에 있는 주석은 C 언어에 있는 주석과 매우 비슷합니다. '한-줄짜리 주석 (single-line comments)' 은 '빗금 두 개 (two forward-slashes; `//`)' 로 시작합니다:

```swift
// 이것은 주석입니다.
```

'여러 줄짜리 주석 (multiline comments)' 은 빗금 뒤에 별표가 있는 곳 (`/*`) 에서 시작하고 별표 뒤에 빗금이 있는 곳 (`*/`) 에서 끝납니다:

```swift
/* 이것 또한 주석이지만
 여러 줄에 걸쳐 작성되었습니다 */
```

C 언어의 '여러 줄짜리 주석' 과는 달리, 스위프트의 여러 줄짜리 주석은 다른 여러 줄짜리 주석을 '중첩할 (nested)' 수 있습니다. '중첩 주석 (nested comments)' 을 만들려면 일단 '여러 줄짜리 주석 블럭' 을 시작한 다음 첫 번째 블럭 내에서 두 번째 '여러 줄짜리 주석' 을 시작합니다. 두 번째 블럭을 닫은 다음, 이어서 첫 번째 블럭을 닫습니다:

```swift
/* 이것은 첫 번째 여러 줄짜리 주석의 시작입니다.
 /* 이것은 두 번째이자, 중첩된 여러 줄짜리 주석입니다. */
 이것은 첫 번째 여러 줄짜리 주석의 끝입니다. */
```

'중첩된 여러 줄짜리 주석 (nested multiline comments)' 은, 이미 여러 줄짜리 주석을 가지고 있는, 큰 코드 블럭도 빠르고 쉽게 주석 처리할 수 있게 해줍니다.

### 세미콜론 (Semicolons)

다른 여러 언어들과는 다르게, 스위프트는 코드에 있는 각각의 구문 뒤에 세미콜론 (`;`) 을 붙일 필요가 없습니다. 물론 원한다면 그렇게 해도 되긴 합니다. 하지만, 여러 개의 분리된 구문을 한 줄에 쓰고 싶을 경우에는 세미콜론을 쓰는 _것이 (are)_ 필수입니다:

```swift
let cat = "🐱"; print(cat)
// "🐱" 를 출력합니다.
```

### Integers (정수)

_정수 (integers)_ 는 분수 성분이 없는 모든 수를 말하며, `42` 와 `-23` 같은 것이 여기에 해당합니다. 정수는 _부호가 있는 (signed)_ 것 (양수, '0', 및 음수) 또는  _부호가 없는 (unsigned)_ 것 (양수, 및 '0') 이 있습니다.

스위프트는 8, 16, 32, 그리고 64 비트 형태의 '부호 있는 정수' 와 '부호 없는 정수' 를 제공합니다. 이 정수들은 C 언어의 '작명법 (naming convention)' 에 따라, 8-비트 부호 없는 정수는 `UInt8` 타입이고, 32-비트 부호 있는 정수는 `Int32` 타입입니다. 스위프트의 모든 타입들 처럼, 이 정수 타입의 이름은 대문자로 시작합니다.

#### Integer Bounds (정수의 경계)

각각의 정수 타입에 대한 최소 값과 최대 값은 `min` 과 `max` 속성으로 접근할 수 있습니다:

```swift
let minValue = UInt8.min  // minValue 는 0 이고, 타입은 UInt8 입니다.
let maxValue = UInt8.max  // maxValue 는 255 이고, 타입은 UInt8 입니다.
```

이 속성 값들은 적절한-크기의 수치 타입 (가령 위 예제의 경우 `UInt8`) 이므로 타입이 같은 다른 값들과 나란히 표현식에서 사용할 수 있습니다.

#### Int

대부분의 경우, 코드에서 사용할 정수의 크기를 특정하게 고를 필요가 없습니다. 스위프트는, `Int` 라는, 추가적인 정수 타입을 제공하는데, 이는 현 플랫폼의 고유한 '워드 (word)'[^word] 크기와 같은 크기를 가집니다.

* 32-비트 플랫폼에서, `Int` 는 `Int32` 와 같은 크기입니다.
* 64-비트 플랫폼에서, `Int` 는 `Int64` 와 같은 크기입니다.

특정한 크기의 정수와 작업해야 하는 경우가 아니라면, 코드의 정수 값으로 항상 `Int` 를 사용하기 바랍니다. 이것은 코드의 '일관성 (consistency)' 과 '상호 호환성 (interoperability)' 을 높입니다. 32-비트 플랫폼에서도, `Int` 는 `-2,147,483,648` 과 `2,147,483,647` 사이의 어떤 값도 저장할 수 있으므로, 왠만한 정수 범위로는 충분히 큰 편입니다.

#### UInt

스위프트는, `UInt` 라는, 부호없는 정수 타입도 제공하는데, 이는 현 플랫폼의 고유한 워드 크기와 같은 크기를 가집니다:

* 32-비트 플랫폼에서, `UInt` 는 `UInt32` 와 같은 크기입니다.
* 64-비트 플랫폼에서, `UInt` 는 `UInt64` 와 같은 크기입니다.

> `UInt` 는 특히 플랫폼의 고유한 워드 크기와 같은 크기를 가지면서도 부호 없는 정수가 꼭 필요할 때만 사용하기 바랍니다. 이 경우가 아니라면, 저장 값이 음수가 되지 않음을 알고 있더라도, `Int` 가 더 바람직합니다. 정수 값으로 `Int` 를 일관되게 사용하는 것은, [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)](#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 에서 설명한 것처럼, 코드의 '상호 호환성 (interoperability)' 을 높이고, 서로 다른 수치 타입 간의 변환에 대한 필요성을 없애주며, 정수 타입 추론 장치와도 잘 들어 맞습니다.

### Floating-Point Numbers (부동-소수점 수)

_부동-소수점 수 (floating-point numbers)_ 는 분수 성분이 있는 수를 말하며, `3.14159`, `0.1` 그리고 `-273.15` 등이 여기에 해당합니다.

'부동-소수점 타입 (floating-point types)' 은 '정수 타입' 보다 훨씬 더 넓은 범위의 값을 표현할 수 있으며, `Int` 에 저장할 수 있는 것보다 훨씬 더 크거나 작은 수도 저장할 수 있습니다. 스위프트는 두 가지의 부호 있는 부동-소수점 수치 타입을 제공합니다:

* `Double` 은 64-비트 부동-소수점 수를 표현합니다.
* `Float` 은 32-비트 부동-소수점 수를 표현합니다.

> `Double` 은 최소 '15 자리 유효 숫자 (15 decimal digits)' 의 정밀도를 가지는 반면, `Float` 의 정밀도는 좀 더 적은 '6 자리 유효 숫자 (6 decimal digits)' 입니다. 어떤 부동-소수점 타입이 적당한가 하는 것은 코드에서 작업할 값의 성질과 범위에 달려 있습니다. 어느 타입을 써도 무방한 상황이라면, `Double` 이 더 바람직합니다.

### Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)

스위프트는 _타입-안전 (type-safe)_ 언어입니다. '타입 안전 언어' 는 코드에서 같이 작업할 수 있는 값의 타입을 명확히 알 수 있도록 해 줍니다. 코드 일부에서 `String` 을 필수로 요구하는 경우, 실수로라도 `Int` 를 전달할 수 없습니다.

스위프트는 타입 안전하기 때문에, 코드를 컴파일할 때 _타입 검사 (type checks)_ 를 수행해서 맞지 않는 타입이 있으면 에러를 표시합니다. 이는 개발 과정에서 최대한 빨리 에러를 잡아내고 고칠 수 있게 해줍니다.

'타입 검사 (Type-checking)' 는 서로 다른 타입의 값을 가지고 작업할 때 에러를 피하도록 돕습니다. 하지만, 이것이 모든 상수와 변수 선언마다 타입을 지정해야 한다는 것을 의미하는 것은 아닙니다. 필요한 곳에서 값의 타입을 지정하지 않으면, 스위프트는 적당한 타입을 알아내기 위해 _타입 추론 장치 (type inference)_ 를 사용합니다. '타입 추론 장치' 는 컴파일러가 코드를 컴파일할 때, 제공한 값을 단순히 검토하는 것으로써, 특정한 표현식의 타입을 자동으로 파악할 수 있게 해줍니다.

'타입 추론 장치' 덕분에, 스위프트에서 타입 선언이 필요한 경우는 C 나 오브젝트브-C 같은 언어들 보다 훨씬 적습니다. 상수와 변수는 여전히 타입을 명시해야 하지만, 이 타입을 지정하는 작업의 대부분은 자동으로 이루어집니다.

'타입 추론 장치' 는 상수나 변수를 선언하면서 초기 값을 사용하는 경우 특히 더 유용합니다. 이는 보통 상수나 변수를 선언하는 시점에 _글자 표현 값 (literal value)_-또는 '_글자 값 (literal)_'-을 할당하는 것으로 이루어 집니다. ('글자 표현 값 (literal value)' 은 소스 코드 상에서 직접 나타나는 값으로, 가령 아래 예제의 `42` 와 `3.14159` 같은 것들 입니다.)

예를 들어, 글자 값 `42` 를 새로운 상수에 할당하면서 무슨 타입인 지를 알리지 않으면, 스위프트는 상수가 `Int` 이길 원할 거라고 추론하는데, 이는 정수 같아 보이는 수치 값으로 초기화를 했기 때문입니다:

```swift
let meaningOfLife = 42
// meaningOfLife 의 타입을 Int 로 추론합니다.
```

마찬가지로, '부동 소수점 글자 값 (floating-point literal)' 에 대한 타입을 지정하지 않으면, 스위프트는 `Double` 을 생성하고 싶어할 거라고 추론합니다:

```swift
let pi = 3.14159
// pi 의 타입을 Double 로 추론합니다.
```

스위프트는 부동-소수점 수치 값의 타입을 추론할 때 (`Float` 이 아니라) 항상 `Double` 을 선택합니다.

만약 한 표현식에 '정수 글자 값' 과 '부동-소수점 글자 값' 이 혼합되어 있으면, 상황을 통해서 `Double` 타입으로 추론하게 됩니다:

```swift
let anotherPi = 3 + 0.14159
// anotherPi 의 타입 역시 Double 이라고 추론합니다.
```

`3` 이라는 글자 값은 명시적인 타입을 가지는 것도 아니고 그 자체가 타입인 것도 아니라서, 더하기 연산 중에 '부동-소수점 글자 값' 이 있는 것을 보고 `Double` 이 적당한 결과 타입이라고 추론하게 됩니다.

### Numeric Literals (수치 글자 값)

'정수 글자 값 (integer literals)' 은 다음과 같이 작성합니다:

* _10진 (decimal)_ 수는, 접두사 사용 안함
* _2진 (binary)_ 수는, `0b` 접두사 사용
* _8진 (octal)_ 수는, `0o` 접두사 사용
* _16진 (hexadecimal)_ 수는, `0x` 접두사 사용

다음의 모든 '정수 글자 값' 은 `17` 이라는 10진수 값을 가집니다:

```swift
let decimalInteger = 17
let binaryInteger = 0b10001       // 17 의 2진 표기법
let octalInteger = 0o21           // 17 의 8진 표기법
let hexadecimalInteger = 0x11     // 17 의 16진 표기법
```

'부동-소수점 글자 값' 은 (접두사가 없는) 10진수 (decimal) 나, (접두사가 `0x` 인) 16진수 (hexadecimal) 일 수 있습니다. 소수점 양 쪽에는 반드시 항상 숫자 (또는 16진 숫자) 가 있어야 합니다. 10진 부동-소수점 (decimal floats) 은 _지수 (exponent)_ 를 옵션으로 가질 수 있는데, 대문자 또는 소문자 `e` 로 지시합니다; 16진 부동-소수점 (hexadecimal floats) 은 지수를 반드시 가져야 하는데, 대문자 또는 소문자 `p` 로 지시합니다.

지수가 `exp` 인 10진수의 경우, '밑수 (base number)'[^base-number] 에 10<sup>exp</sup> 이 곱해집니다:

* `1.25e2` 는 1.25 x 10<sup>2</sup>, 또는 `125.0` 를 의미합니다.
* `1.25e-2` 는 1.25 x 10<sup>-2</sup>, 또는 `0.0125` 를 의미합니다.

지수가 `exp` 인 16진수의 경우, '밑수' 에 2<sup>exp</sup> 이 곱해집니다:

* `0xFp2` 는 15 x 2<sup>2</sup>, 또는 `60.0` 을 의미합니다.
* `0xFp-2` 는 15 x 2<sup>-2</sup>, 또는 `3.75` 를 의미합니다.

다음의 모든 '부동-소수점 글자 값' 은 `12.1875` 라는 10진수 값을 가집니다:

```swift
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0
```

'수치 글자 값' 은 더 이해하기 쉽도록 여분의 '양식 (formatting)' 을 가질 수 있습니다. 정수와 부동-소수점 모두 여분의 '0' 으로 채울 수도 있고 가독성을 높이기 위해 '밑줄 (underscores)' 을 가질 수도 있습니다. 어떤 양식을 사용하든 '글자 값' 의 실제 값에는 영향을 주지 않습니다:

```swift
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
```

### Numeric Type Conversion (수치 타입 변환)

코드에 있는 모든 일반적인-용도의 정수 상수나 변수에는, 설령 그것이 음수가 되지 않는다는 것을 알더라도, `Int` 타입을 사용하도록 합니다. 언제 어디서나 이 기본 정수 타입을 사용한다는 것은 코드에 있는 정수 상수나 변수를 즉시 '상호 호환가능 (interoperable)' 하며 '정수 글자 값 (integer literal values)' 으로 추론된 타입과도 일치하게 만들게 된다는 것을 의미합니다.

다른 정수 타입을 사용하는 것은 지금 당장 꼭 필요한 작업일 때만이어야 하며, 이는 외부 소스에서 데이터의 크기가 명시적으로 정해진 경우, 또는 성능, 메모리 사용량, 아니면 다른 최적화가 필요한 경우일 때에만 해당합니다. 이러한 상황에서는 명시적으로 크기가 정해진 타입을 써야 우연히 값이 넘치는 것을 잡아낼 수도 있고 사용할 데이터의 본질에 대해 암시적인 문서화를 하는 효과도 거둘 수 있습니다.

#### Integer Conversion (정수 변환)

정수 상수나 변수에서 저장할 수 있는 수의 범위는 각각의 수치 타입마다 다릅니다. `Int8` 상수나 변수는 `-128` 에서 `127` 사이의 수를 저장할 수 있는 반면, `UInt8` 상수나 변수는 `0` 에서 `255` 사이의 수를 저장할 수 있습니다. 어떤 수가 크기가 정해진 정수 타입의 상수나 변수에 맞지 않으면 코드를 컴파일하면서 에러가 띄웁니다:

```swift
let cannotBeNegative: UInt8 = -1
// UInt8 는 음수를 저장할 수 없으므로, 이것은 에러를 띄웁니다.
let tooBig: Int8 = Int8.max + 1
// Int8 는 최대 값 보다 큰 수를 저장할 수 없으므로,
// 이것도 에러를 띄웁니다.
```

각각의 수치 타입은 저장할 수 있는 값의 범위가 서로 다르기 때문에, (변환을 하려면) 각각의 경우마다 일일이 수치 타입 변환을 직접 선택해야 합니다. 이러한 '직접 선택 접근 방법 (opt-in approach)' 은 의도하지 않게 저절로 변환되는 바람에 발생할 수 있는 에러도 방지하고 코드에서 타입 변환을 하는 의도를 명시하는데도 도움이 됩니다.

지정된 타입의 수를 다른 타입으로 변환하려면, 원하는 타입의 새로운 수를 기존 값으로 초기화하면 됩니다. 아래의 예제에서, 상수 `twoThousand` 의 타입은 `UInt16` 인 반면, 상수 `one` 의 타입은 `UInt8` 입니다. 이들은 같은 타입이 아니기 때문에 직접 더할 수가 없습니다. 대신에, 이 예제는 `UInt16(one)` 을 호출하여 새로운 `UInt16` 를 생성하고 `one` 의 값으로 초기화한 다음, 원본 대신 이 값을 사용합니다.  

```swift
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
```

이제 양쪽 타입이 모두 `UInt16` 이므로, 더하기가 가능합니다. '결과 상수 (`twoThousandAndOne`)' 의 타입도, 두 `UInt16` 값의 합이기 때문에, `UInt16` 으로 추론됩니다.

`SomeType(ofInitialValue)` 는 스위프트에서 타입의 초기자를 호출하고 기본 설정 값을 전달하는 기본적인 방법입니다. 속을 들여다보면, `UInt16` 는 `UInt8` 값을 받아들이는 초기자를 가지고 있어서, 이 초기자를 사용해서 기존의 `UInt8` 로 새로운 `UInt16` 를 만들 수 있는 것입니다. 여기서, _아무 (any)_ 타입이나 전달해서는 안되며-`UInt16` 가 제공하는 초기자에 맞는 타입이라야만 합니다. 기존 타입을 확장해서 (자기가 정의한 타입을 포함한) 새로운 타입을 받아들이는 초기자를 제공하려면 [Extensions (확장)]({% post_url 2016-01-19-Extensions %}) 을 참고하기 바랍니다.

#### Integer and Floating-Point Conversion (정수와 부동-소수점 수 변환)

정수와 부동-소수점 수치 타입 사이의 변환은 이를 반드시 명시해야 합니다.:

```swift
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi 는 3.14159 와 같고, 타입은 Double 로 추론됩니다.
```

여기서, 상수 `three` 의 값을 써서 `Double` 타입의 새로운 값을 생성했으므로, 더하기의 양쪽이 모두 같은 타입입니다. 이 변환이 제 위치에 맞게 있지 않았다면, 더하기를 할 수 없었을 것입니다.

부동-소수점 수 (floating-point) 를 정수로 변환할 때도 반드시 이를 명시해야 합니다. 정수 타입은 `Double` 이나 `Float` 값으로 초기화할 수 있습니다:

```swift
let integerPi = Int(pi)
// integerPi 는 3 과 같고, 타입은 Int 로 추론됩니다.
```

이와 같이 부동-소수점 값으로 새로운 정수 값을 초기화할 때는 항상 값이 잘리게 됩니다. 이는 `4.75` 는 `4` 가 되고, `-3.9` 는 ㄴ`3` 이 된다는 것을 의미합니다.

> 수치 상수와 변수를 결합할 때의 규칙은 '수치 글자 값 (numeric literals)' 의 규착과는 다릅니다. '글자 값' `3` 은 글자 값 `0.14159` 에 바로 더해질 수 있는데, 이는 '수치 글자 값' 이 명시적인 타입을 가지고 있는 것도 아니고 그 자체가 타입인 것도 아니기 때문입니다. 이들의 타입은 컴파일러가 값을 계산하는 순간에만 추론됩니다.  

### Type Aliases (타입 별명)

_타입 별명 (type aliases)_ 은 기존 타입에 대한 '대체 이름 (alternative name)' 을 정의합니다. '타입 별명' 을 정의할 때는 `typealias` 키워드를 사용합니다.

'타입 별명' 은 기존 타입을 문맥에 더 알맞은 이름으로 참조하고 싶을 때 유용하며, 가령 외부 소스에서 크기가 지정된 데이터와 작업할 때는 아래와 같이 할 수 있습니다:

```swift
typealias AudioSample = UInt16
```

타입 별명을 한 번 정의하고 나면, 원래의 이름을 사용할 수 있는 곳이라면 어디서든 이 별명을 사용할 수 있습니다:

```swift
var maxAmplitudeFound = AudioSample.min
// maxAmplitudeFound 는 이제 0 입니다.
```

여기서는, `AudioSample` 을 `UInt16` 의 별명으로 정의했습니다. 이것은 별명이므로, `AudioSample.min` 을 호출하는 것은 실제로 `UInt16.min` 를 호출하는 것이며, 이는 `maxAmplitudeFound` 변수에 기본 설정 값으로 `0` 을 제공하게 됩니다.

### Booleans (불린; 논리 값)

스위프트는 `Bool` 이라는 기본적인 _불린 타입 (Boolean type)_ 을 가지고 있습니다. '불린 (Boolean)' 값을 일컬어 _논리 값 (logical)_ 이라고도 하는데, 왜냐면 이 값들은 항상 `true` 또는 `false` 일 수 밖에 없기 때문입니다. 스위프트는 두 개의 '불린 (Boolean)' 상수 값, `true` 와 `false` 를 제공합니다:

```swift
let orangesAreOrange = true
let turnipsAreDelicious = false
```

`orangesAreOrange` 와 `turnipsAreDelicious` 의 타입은 이들이 '불린 글자 값 (Boolean literal values)' 으로 초기화되었다는 사실에 의해 `Bool` 로 추론됩니다. 앞서 `Int` 와 `Double` 에서와 같이, 생성하자마자 `true` 나 `false` 로 설정하면, 상수나 변수를 `Bool` 이라고 선언할 필요가 없습니다. '타입 추론 장치 (type inference)' 는 스위프트에서 상수나 변수를 초기화할 때 이미 타입이 알려진 값을 사용할 경우 코드를 더 간결하고 이해하기 쉽게 만들도록 도와줍니다.

'불린 (Boolean)' 값은 특히 `if` 문 같은 조건 구문에서 사용할 때 아주 유용합니다:

```swift
if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}
// "Eww, turnips are horrible." 를 출력합니다.
```

`if` 문 같은 조건 구문에 대해서는 [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에서 더 자세히 다룹니다.

스위프트의 '타입 안전 장치 (type safety)' 는 '불린-아닌 값 (non-Boolean values)' 이 `Bool` 을 대체하지 못하도록 막아줍니다. 다음 예제는 '컴파일 시간에 (compile-time)' 에러를 띄웁니다:

```swift
let i = 1
if i {
    // 이 예제는 컴파일되지 않고, 에러를 띄웁니다.
}
```

아래 예제는 이에 대한 유효한 대안 방식을 보여줍니다:

```swift
let i = 1
if i == 1 {
    // 이 예제는 성공적으로 컴파일됩니다.
}
```

`i == 1` 비교 연산의 결과는 `Bool` 타입이고, 따라서 이 두 번째 예제는 타입 검사를 통과하게 됩니다. `i == 1` 과 같은 비교 연산들은 [Basic Operators (기본 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 에서 설명합니다.

스위프트의 '타입 안전 장치 (type safety)' 에 대한 여타 다른 예제에서 봤듯이, 이런 접근 방법은 실수로 인한 에러를 방지해주며 특정 코드 영역의 의도가 늘 명확하도록 해 줍니다.

### Tuples (튜플; 짝)

_튜플 (tuples)_ 은 여러 개의 값을 그룹지어 단일한 하나의 복합 값으로 만들어 줍니다. 튜플 안의 값은 어떤 타입이어도 상관 없으며 서로 같은 타입이어야할 필요도 없습니다.

다음 예제에서, `(404, "Not Found")` 는 _HTTP 상태 코드 (HTTP status code)_ 를 나타내는 튜플입니다. 'HTTP 상태 코드' 는 웹 페이지를 요청할 때마다 웹 서버가 반환하는 특수한 값을 말합니다. 이 중에서 `404 Not Found` 라는 상태 코드는 요청한 웹페이지가 존재하지 않을 때 반환됩니다.

```swift
let http404Error = (404, "Not Found")
// http404Error 의 타입은 (Int, String) 이고, 값은 (404, "Not Found") 와 같습니다.
```

`(404, "Not Found")` 라는 튜플은 `Int` 와 `String` 을 함께 그룹지어서 HTTP 상태 코드에 별개의 두 값을 부여합니다: 수 하나와 사람이-인식할 수 있는 하나의 설명이 그것입니다. 이는 "타입이 `(Int, String)` 인 튜플" 이라고 말할 수 있습니다.

튜플을 만들 때는 타입의 '순서 (permutation)'[^permutation] 같은 것은 아무 상관이 없으며, 서로 다른 타입을 원하는 만큼 많이 집어 넣어도 상관 없습니다. 타입이 `(Int, Int, Int)` 든 `(String, Bool)` 이든 다 튜플을 만들 수 있으며, 진짜로 원하는 데로 아무 순서로 만들어도 상관없습니다.

튜플의 내용물은 별도의 상수나 변수로 _분해할 (decompose)_ 수도 있으며, 평소처럼 접근할 수도 있습니다:

```swift
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// "The status code is 404" 를 출력합니다.
print("The status message is \(statusMessage)")
// "The status message is Not Found" 를 출력합니다.
```

튜플 값 중에서 일부만 필요한 경우, 튜플을 분해할 때 '밑줄 (underscore)' (`_`) 을 써서 그 일부분를 무시할 수 있습니다:

```swift
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
// "The status code is 404" 를 출력합니다.
```

다른 방법으로는, 0 으로 시작하는 '색인 번호 (index numbers)' 을 사용하여 튜플의 개별 원소 값에 접근할 수도 있습니다:

```swift
print("The status code is \(http404Error.0)")
// "The status code is 404" 를 출력합니다.
print("The status message is \(http404Error.1)")
// "The status message is Not Found" 를 출력합니다.
```

튜플을 정의할 때 튜플에 있는 개별 원소에 이름을 부여할 수도 있습니다:

```swift
let http200Status = (statusCode: 200, description: "OK")
```

이렇게 튜플의 원소에 이름을 부여했으면, 그 원소의 값에 접근할 때 원소의 이름을 사용할 수 있습니다:

```swift
print("The status code is \(http200Status.statusCode)")
// "The status code is 200" 를 출력합니다.
print("The status message is \(http200Status.description)")
// "The status message is OK" 를 출력합니다.
```

튜플은 함수의 반환 값으로 쓸 때 특히 더 유용합니다. 웹 페이지를 가져오는 함수는 그 페이지를 가져오는 것에 성공했는지 실패했는지를 나타내기 위해 `(Int, String)` 튜플 타입을 반환할 수 있을 것입니다. 두 개의 별개의, 서로 타입이 다르기 까지한, 값으로 구성된 튜플을 반환함으로써, 이 함수는 단일한 타입의 단 하나의 값을 반환하는 경우보다 결과물에 대한 더 유용한 정보를 제공할 수 있습니다. 더 자세한 정보는 [Functions with Multiple Return Values (반환 값이 여러 개인 함수)]({% post_url 2020-06-02-Functions %}#functions-with-multiple-return-values-반환-값이-여러-개인-함수) 를 참고하기 바랍니다.

> 튜플은 관계 있는 값을 간단히 그룹지을 때 유용한 것입니다. 복잡한 데이터 구조를 생성하는 데는 적합하지 않습니다. 데이터 구조가 더 복잡해질 수도 있을 것 같으면, 튜플 대신에, 클래스나 구조체로 모델링하도록 합니다. 더 자세한 정보는 [Structures and Classes (구조체와 클래스)]({% post_url 2020-04-14-Structures-and-Classes %}) 를 참고하기 바랍니다.

### Optionals (옵셔널; 선택적 값 타입)

_옵셔널 (optionals)_ 값이 없을 수도 있는 상황에서 사용합니다. 옵셔널은 두 가지 가능성을 표현합니다: 값이 _있어서 (is)_, 그 옵셔널이 감싸고 있는 값에 접근할 수 있는 경우, 또는 값이 아예 _있지 않은 (isn't)_ 경우가 그것입니다.

> 옵셔널이라는 개념은 C 나 오브젝티브-C 언어에는 존재하지 않습니다. 오브젝티브-C 언어에서 그나마 가장 근접한 개념은 객체를 반환해야할 메소드가 `nil` 을 반환할 수 있다는 것 정도인데, 여기서 `nil` 은 "유효한 객체가 없음" 을 의미합니다. 하지만, 이것은 오직 객체일 때만 작동합니다-구조체나, C 언어의 기본 타입들, 또는 열거체 값에서는 작동하지 않습니다. 이러한 타입들을 위해, 오브젝티브-C 의 메소드는 보통 특수한 값을 (가령 `NSNotFound` 같은 값을) 반환해서 값이 없다는 것을 나타냅니다. 이런 접근 방법은 메소드를 호출한 쪽에서 테스트가 필요한 특수한 값이 있다는 것도 알고 검사가 필요한 것도 기억하고 있다는 가정 위에서 동작하는 것입니다. 스위프트의 '옵셔널 (optionals)' 은 _어떤 타입이든 상관없이 (any type at all)_ 값이 없다는 것을 나타낼 수 있고, 특별한 상수가 필요하지도 않습니다.

이제 옵셔널을 사용하여 값이 없는 상황에 대처하는 방법을 알아봅시다. 스위프트의 `Int` 타입은 `String` 값을 `Int` 값으로 변환할 수 있는 '초기자 (initializer)' 를 가지고 있습니다. 하지만, 모든 문자열을 정수로 변환할 수 있는 것은 아닙니다. 문자열 `"123"` 은 수치 값 `123` 으로 변환할 수 있지만, 문자열 `"hello, world"` 는 변환할 만한 확실한 수치 값을 갖고 있지 않습니다:

아래 예제는 초기자를 사용하여 `String` 을 `Int` 로 변환하려고 시도합니다:

```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber 의 타입은 "Int?", 또는 "optional Int" 라고 추론합니다.
```

초기자가 실패할 수도 있으므로, `Int` 가 아니라, '_옵셔널 (optional)_ `Int`' 를 반환합니다. '옵셔널 `Int`' 는 `Int` 가 아니라, `Int?` 라고 씁니다. 물음표는 이 값이 옵셔널을 갖고 있음을 나타내며, 이는 _어떤 (some)_ `Int` 값을 갖고 있거나, 아니면 갖고 있는 _값이 전혀 없다 (no value at all)_ 는 것을 의미합니다. (그 외 다른 어떤 것도 가질 수 없으며, 가령 `Bool` 이나 `String` 값일 수도 없습니다. 오직 `Int` 이거나, 아무 것도 아닌 것이어야 합니다.)

#### nil

옵셔널 변수에 값이 없는 상태를 설정하려면 `nil` 이라는 특수한 값을 할당하면 됩니다:

```swift
var serverResponseCode: Int? = 404
// serverResponseCode 는 404 라는 실제 Int 값을 가집니다.
serverResponseCode = nil
// serverResponseCode 는 이제 아무 값도 갖지 않습니다.
```

> `nil` 은 '옵셔널이-아닌 (non-optional)' 상수와 변수에는 사용할 수 없습니다. 코드 내의 상수나 변수를 쓸 때 특정 조건에서는 값이 없을 수도 있다면, 항상 적당한 타입의 옵셔널 값으로 선언해야 합니다.

옵셔널 변수를 정의할 때 기본 설정 값을 제공하지 않으면, 그 변수는 자동으로 `nil` 로 설정됩니다:

```swift
var surveyAnswer: String?
// surveyAnswer 는 자동으로 nil 로 설정됩니다.
```

> 스위프트의 `nil` 은 오브젝티브-C 의 `nil` 과 같지 않습니다. 오브젝티브-C 에서, `nil` 은 존재하지 않는 객체에 대한 포인터입니다. 스위프트에서, `nil` 은 포인터가 아닙니다-이것은 정해진 타입에 대해 '어떤 값도 없다 (absence of a value)' 는 것입니다. 객체 타입 뿐만 아니라, _어떤 (any)_ 타입의 옵셔널에도 `nil` 을 설정할 수 있습니다.

#### If Statements and Forced Unwrapping (If 문과 강제 포장 풀기)

`if` 문을 사용하면 옵셔널을 `nil` 과 비교하여 옵셔널이 값을 가지는지 확인할 수 있습니다. 이 비교는 "같음 (equal to)" 연산자 (`==`) 나 "같지 않음 (not equal to)" 연산자 (`!=`) 를 써서 수행할 수 있습니다:

옵셔널이 값을 가지고 있으면, 이는 `nil` 과 "같지 않은" 것으로 여겨집니다:

```swift
if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}
// "convertedNumber contains some integer value." 를 출력합니다.
```

옵셔널이 값을 가지고 있다고 확신할 수 _있는 (does)_ 경우에는, 옵셔널 이름 끝에 느낌표 (`!`) 를 추가해서 그것의 '실제 값 (underlying value)' 에 접근할 수 있습니다. 느낌표가 말하는 것은 이렇습니다, "나는 이 옵셔널이 값을 가지고 있음을 정확히 알고 있으니; 그걸 쓰기 바랍니다." 이것을 일컬어 옵셔널 값에 대한 '강제 포장 풀기 (forced unwrapping)' 라고 합니다:

```swift
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}
// "convertedNumber has an integer value of 123." 을 출력합니다.
```

`if` 문에 대한 더 자세한 내용은 [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 을 보기 바랍니다.

> `!` 를 사용해서 '존재하지 않는 옵셔널 값 (nonexistent optional value)' 에 접근하려고 하면 '실행 시간에 에러 (runtime error)' 를 띄웁니다. `!` 를 사용해서 값을 강제로 풀기 전에 항상 옵셔널이 '`nil` 이 아닌 값 (non-`nil` value)' 을 가지고 있음을 먼저 확인하기 바랍니다.

#### Optional Binding (옵셔널 연결)

_옵셔널 연결 (optional binding)_ 을 사용하면 옵셔널이 값을 가지는지 확인해서, 그 경우, 그 값을 임시 상수나 변수의 형태로 사용하게 할 수 있습니다. '옵셔널 연결' 을 `if` 와 `while` 문과 같이 사용하면, 옵셔널 안의 값을 검사하고 그 값을 상수나 변수로 추출하는 것을, 단 한 번의 동작으로 할 수 있습니다. `if` 와 `while` 문에 대해서는 [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에서 더 자세히 다룹니다.

if 문에서 '옵셔널 연결' 을 작성하는 방법은 다음과 같습니다:

```
if let constantName = someOptional {
    statements
}
```

[Optionals (옵셔널)](#optionals-옵셔널-선택적-값-타입) 에 있는 `possibleNumber` 예제는 '강제 포장 풀기 (forced unwrapping)' 대신 '옵셔널 연결 (optional binding)' 을 써서 다음과 같이 고칠 수 있습니다:

```swift
if let actualNumber = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("The string \"\(possibleNumber)\" could not be converted to an integer")
}
// "The string "123" has an integer value of 123" 을 출력합니다.
```

이 코드는 다음과 같이 이해할 수 있습니다:

"`Int(possibleNumber)` 에서 반환한 '옵셔널 `Int`' 가 값을 가지고 있으면, 그 옵셔널이 가지고 있는 값을 새로운 상수인 `actualNumber` 에 설정하기 바랍니다."

이 변환에 성공하면, `if` 문의 첫 번째 분기에서 `actualNumber` 상수를 사용할 수 있게 됩니다. 이것은 옵셔널 _속에 (within)_ 있던 값으로 이미 초기화 됐으므로, 값에 접근할 때 `!` 접미사를 사용할 필요가 없습니다. 이 예제에서, `actualNumber` 는 단순히 변환 결과를 출력하는데 사용되고 있습니다.

'옵셔널 연결' 에는 상수와 변수 모두 사용할 수 있습니다. `if` 문의 첫 번째 분기 내에서 `actualNumber` 값을 조작하고 싶으면, `if var actualNumber` 를 대신 사용하여, 옵셔널이 갖고 있는 값을 상수가 아닌 변수로 사용하게끔 할 수도 있습니다.

단일 `if` 문에 쉼표로 분리하는 방법을 쓰면, '옵셔널 연결' 과 '불린 조건 (Boolean conditions)' 을 원하는 만큼 많이 포함시킬 수 있습니다. 옵셔널 연결 중 어떤 값이든 `nil` 이거나 혹은 어떤 '불린 (Boolean)' 조건이든 `false` 로 계산된다면, 전체 `if` 문의 조건은 `false` 인 것으로 고려됩니다. 다음의 `if` 문들은 서로 동등합니다:

```swift
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
// "4 < 42 < 100" 를 출력합니다.

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}
// "4 < 42 < 100" 를 출력합니다.
```

`if` 문 안의 '옵셔널 연결' 에서 만든 상수와 변수는 `if` 문의 본문 내에서만 사용 가능합니다. 이와는 달리, `guard` 문에서 만든 상수와 변수는 `guard` 문 이후의 코드 줄에서도 사용 가능한데, 이는 [Early Exit (조기 탈출 구문)]({% post_url 2020-06-10-Control-Flow %}#early-exit-조기-탈출-구문) 에서 설명하도록 합니다.

#### Implicitly Unwrapped Optionals (암시적으로 포장이 풀리는 옵셔널)

앞서 설명한 것처럼, 옵셔널은 상수나 변수가 "값이 없을" 수 있음을 나타냅니다. 옵셔널은 `if` 문을 사용하여 값이 존재하는지를 검사할 수 있으며, 옵셔널 값에 접근하기 위해 '옵셔널 연결' 을 사용하여 값의 유무에 따른 '조건부 풀기 (conditionally unwrapped)' 를 할 수도 있습니다.

프로그램의 구조상, 최초로 값을 설정한 후, 옵셔널은 _항상 (always)_ 값을 갖는다는 것은 분명합니다. 이와 같은 경우, 항상 값이 있다고 가정해도 안전하므로, 접근할 때마다 옵셔널 값을 검사하고 풀고할 필요가 없는 것이 유용할 것입니다.

이러한 종류의 옵셔널을 '_암시적으로 포장이 풀리는 옵셔널 (implicitly unwrapped optionals)_' 이라고 정의합니다. 암시적으로 포장이 풀리는 옵셔널을 작성하려면 옵셔널로 만들고 싶은 타입 뒤에 물음표 (`String?`) 대신 느낌표 (`String!`) 을 붙이면 됩니다.

'암시적으로 포장이 풀리는 옵셔널' 이 유용한 순간은 옵셔널이 처음 정의되자마자 옵셔널 값이 존재한다는 것을 보장할 수 있고 이후 모든 곳에서 존재한다고 가정할 수 있을 때입니다. 스위프트에서 '암시적으로 포장이 풀리는 옵셔널' 이 주로 사용되는 곳은 클래스를 초기화하는 곳에서이며, 이는 [Unowned References and Implicitly Unwrapped Optional Properties (무소속 참조와 암시적으로 포장이 풀리는 옵셔널 속성)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#unowned-references-and-implicitly-unwrapped-optional-properties-무소속-참조와-암시적으로-포장이-풀리는-옵셔널-속성) 에서 설명합니다.

'암시적으로 포장이 풀리는 옵셔널' 도 그 속을 들여다보면 보통의 옵셔널이지만, '옵셔널이-아닌 값 (non-optional value)' 처럼 쓸 수 있으며, 접근할 때마다 옵셔널 값을 풀 필요도 없습니다. 다음의 예제는 '옵셔널 문자열' 과 '암시적으로 포장이 풀리는 옵셔널 문자열' 에서 그들이 감싸고 있는 값을 명시적인 `String` 으로 접근할 때의 동작이 어떻게 다른지를 보여줍니다:

```swift
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 느낌표가 필요합니다.

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // 느낌표가 필요없습니다.
```

'암시적으로 포장이 풀리는 옵셔널' 은 사용될 때마다 자동으로 옵셔널이 풀리는 권환을 부여받았다고 생각할 수 있습니다. 이는 사용할 때마다 옵셔널 이름 뒤에 느낌표를 붙이는 것이 아니라, 선언할 때 옵셔널을 선언할 때 그 타입 뒤에 느낌표를 붙이는 것에 해당합니다.

> '암시적으로 포장이 풀리는 옵셔널' 이 `nil` 인데 그것이 감싼 값에 접근하려고 하면, '실행 시간 에러 (runtime error)' 를 발생시키게 됩니다. 이 결과는 값을 갖고 있지 않은 보통의 옵셔널 뒤에 느낌표를 붙이는 것과 정확하게 같습니다.

'암시적으로 포장이 풀리는 옵셔널' 은 여전히 보통의 옵셔널처럼 취급할 수도 있어서, 다음 처럼 값을 갖고 있는지 검사하는 것도 가능합니다:

```swift
if assumedString != nil {
    print(assumedString)
}
// "An implicitly unwrapped optional string." 를 출력합니다.
```

You can also use an implicitly unwrapped optional with optional binding, to check and unwrap its value in a single statement:

'암시적으로 포장이 풀리는 옵셔널' 을 '옵셔널 연결' 과 같이 써서, 단일한 구문으로 값을 검사하고 풀기까지 할 수도 있습니다:

```swift
if let definiteString = assumedString {
    print(definiteString)
}
// "An implicitly unwrapped optional string." 를 출력합니다.
```

> 나중에 어느 시점에 변수가 `nil` 이 될 가능성이 조금이라도 있다면 '암시적으로 포장이 풀리는 옵셔널' 을 사용하면 안됩니다. 변수가 존재하는 동안 `nil` 값인지 검사할 필요가 있을 때는 항상 보통의 옵셔널 타입을 사용하기 바랍니다.

### Error Handling (에러 처리)

_에러 처리 (error handling)_ 을 사용하면 프로그램 실행 중에 마주칠 수있는 에러 조건들에 대응을 할 수가 있습니다.

값의 있고 없음으로 함수의 성공과 실패라는 정보를 전달할 수 있는, 옵셔널과는 다르게, 에러 처리는 실패의 실제 원인을 확인할 수 있도록 해주며, 필요하다면, 그 에러를 프로그램의 다른 부분으로 전파할 수 있도록 해줍니다.

하나의 함수는 에러 조건과 마주쳤을 때, 에러를 하나 _던집니다 (throws)_. 그 함수를 호출한 쪽에서 그 에러를 _잡아내고 (catch)_ 적절하게 응답할 수 있습니다.

```swift
func canThrowAnError() throws {
    // 이 함수는 에러를 던질수도 있고 아닐 수도 있습니다.
}
```

함수가 에러를 던질 수 있다고 표시하러면 함수를 선언할 때 `throws` 키워드를 포함시키면 됩니다. 에러를 던질 수 있는 함수를 호출할 때는, 표현식에 `try` 키워드를 '먼저 붙여야 (prepend)' 합니다.

스위프트는 `catch` 절에서 처리될 때까지 에러를 자동으로 현재 범위 밖으로 전파합니다.

```swift
do {
    try canThrowAnError()
    // 아무 에러도 던져지지 않았습니다.
} catch {
    // 어떤 에러가 던져 졌습니다.
}
```

`do` 구문은 새로운 포함 범위를 만들어서, 에러가 하나 이상의 `catch` 절로 전파되도록 합니다.

다음 예제는 '에러 처리' 를 사용하여 서로 다른 에러 조건에 응답할 수 있는 방법을 보여줍니다:

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

이 예제에서, `makeASandwich()` 함수는 남아있는 깨끗한 접시가 하나도 없거나 하나라도 재료가 빠진 경우 에러를 던질 것입니다. `makeASandwich()` 가 에러를 던질 수 있기 때문에, 이 함수 호출을 `try` 표현식으로 감쌌습니다. `do` 구문 속에 함수 호출을 감쌌기 때문에, 어떤 에러가 던져져도 이미 제공한 `catch` 절로 전파될 것입니다.

에러가 던져지지 않으면, `eatASandwich()` 함수를 호출합니다. 에러가 던져지고 이것이 `SandwichError.outOfCleanDishes` '경우 값' 에 해당한다면, `washDishes()` 함수를 호출할 것입니다. 에러가 던져지고 이것이 `SandwichError.missingIngredients` '경우 값' 에 해당한다면, 그 때는 `catch` '유형 (pattern)' 에 의해 붙잡힌 `[String]` '결합 값' 을 가지고 `buyGroceries(_:)` 함수를 호출하게 됩니다.

에러를 던지고, 붙잡고, 전파하는 것은 [Error Handling (에러 처리)]({% post_url 2020-05-16-Error-Handling %}) 에서 아주 상세하게 다룹니다.

### Assertions and Preconditinos (단언과 선행 조건)

_단언 (assertions)_ 과 _선행 조건 (Preconditions)_ 은 '실행 시간 (runtime)' 에 하는 '검사 (checks)' 입니다. 이를 사용하면 그 다음 코드를 실행하기 전에 '필수 조건 (essential condition)' 을 만족하고 있는지 확인할 수 있습니다. '단언' 이나 '선행 조건' 에 있는 '불린 (Boolean) 조건이 `true` 로 계산되면, 코드 실행이 평소처럼 계속됩니다. 조건이 `false` 로 계산되면, 프로그램의 현재 상태가 무효한 것입니다; 코드 실행은 중지되고, 앱을 종료합니다.

'단언' 과 '선행 조건' 을 사용하면 코딩 중에 만들게 된 '가정 (assumptions)' 과 코딩 중에 가졌던 '기대값 (expectations)' 을 표현할 수 있으며, 이들을 코드의 일부로 포함할 수 있습니다. '단언' 은 개발 중에 실수한 것과 잘못된 가정을 찾도록 도와주며, '선행 조건' 은 제품의 '문제점 (issues)' 을 미리 감지할 수 있도록 도와줍니다.

실행 시간에 기대값을 검증하는 용도 외에도, '단언' 과 '선행 조건' 은 코드 내에서 문서화를 할 수 있는 편리한 양식이기도 합니다. 앞서 [Error Handling (에러 처리)](#error-handling-에러-처리) 에서 설명한 에러 조건과는 다르게, '단언' 과 '선행 조건' 은 복구 가능하거나 예상 가능한 에러에 사용하는 것이 아닙니다. 실패한 '단언' 이나 '선행 조건' 은 프로그램의 상태가 유효하지 않음을 나타내는 것이기 때문에, 실패한 '단언' 을 잡아내는 방법이란 건 없습니다.

'단언' 과 '선행 조건' 은 예기치 않게 무효한 조건이 발생하는 상황에 대한 코드 설계인 것이 아닙니다. 하지만, 유효한 데이터와 상태에 이를 적용하는 것은 무효한 상태가 발생했을 때 앱이 종료될 것임을 예측 가능하게 해주고, 문제를 더 쉽게 고칠 수 있도록 해 줍니다. 무효한 상태가 감지되자마자 즉시 실행을 중지하는 것은 무효한 상태로 인한 피해를 줄이는 데도 도움이 됩니다.

'단언' 과 '선행 조건' 의 차이점은 그들이 검사되는 시점에 있습니다: '단언 (assertions)' 은 오직 '디버그 빌드 (debug builds)' 시에만 검사되지만, '선행 조건 (preconditions)' 은 '디버그와 제품 빌드 (debug and production builds)' 시 모두에서 검사됩니다. 제품 빌드 시에는, '단언' 내의 조건은 계산되지 않습니다. 이것은, 개발 과정에서 원하는 만큼 '단언' 을 많이 사용할 수 있으며, 이 경우에도 제품의 성능에는 영향을 주지 않는다는 것을 의미합니다.

#### Debugging with Assertions ('단언' 으로 디버깅하기)

'단언 (assertion)' 을 작성하려면 스위프트 표준 라이브러리에 있는 `assert(_:_:file:line:)` 함수를 호출하면 됩니다. 이 함수에 `true` 나 `false` 로 계산될 표현식과 조건 결과가 `false` 일 때 표시할 메시지를 전달합니다. 예를 들면 다음과 같습니다:

```swift
let age = -3
asset(age >= 0, "A person's age can't be less than zero.")
// 이 단언은 -3 이 >= 0 이 아니기 때문에 실패합니다.
```

위의 예제에서, 코드 실행을 계속하려면 `age >= 0` 가 `true` 로 계산되거나, 다시 말해서, `age` 의 값이 음수가 아니어야 합니다. 만약 `age` 의 값이 음수이면, 위의 코드에서 보듯, `age >= 0` 가 `false` 로 계산되므로, '단언' 이 실패하고, 응용 프로그램을 종료합니다.

'단언' 의 메시지는 생략할 수 있습니다-예를 들어, 조건 자체를 글자 그대로 표시하려고 할 수도 있을 것입니다.

```swift
assert(age >= 0)
```

코드가 이미 조건을 검사한 경우라면, `assertionFailure(_:file:line:)` 함수를 사용하여 '단언' 이 실패했음을 나타낼 수 있습니다. 예를 들면 다음과 같습니다:

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

코드를 계속 실행하려면 _분명히 (definitely)_ 참이어야 하지만, 잠재적으로 거짓이 될 수 있는 조건이 있을 때마다 '선행 조건 (precondition)' 을 사용하기 바랍니다. 예를 들어, 선행 조건으로 첨자 연산이 범위를 벗어나지 않았는지 검사하거나, 함수에 유효한 값이 전달되었는지 검사하도록 합니다.

'선행 조건' 을 작성하려면 `precondition(_:_:file:line:)` 함수를 호출하면 됩니다. 이 함수에 `true` 나 `false` 로 계산될 표현식과 조건 결과가 `false` 일 때 표시할 메시지를 전달합니다. 예를 들면 다음과 같습니다:

```swift
// 첨자 연산 (subscript) 의 구현 내부에서 ...
precondition(index > 0, "Index must be greater than zero.")
```

`preconditionFailure(_:file:line:)` 함수 호출로도 실패가 발생했음을 나타낼 수 있습니다-예를 들어, 모든 유효한 데이터들은 'switch (스위치)' 의 다른 '경우값들 (cases)' 에서 처리됐어야 함에도, 'switch (스위치)' 의 '기본 경우값 (default case)' 에 들어온 상황이 그런 것입니다.

> '검사없는 모드 (unchecked mode)' (`-Ounchecked`) 로 컴파일하면, '선행 조건' 을 검사하지 않습니다. 컴파일러는 선행 조건이 항상 참이라고 가정하며, 그에 따라 코드를 최적화합니다. 하지만, `fatalError(_:file:line:)` 함수는 최적화 설정과는 상관없이, 항상 실행을 중단합니다.
>
> `fatalError(_:file:line:)` 함수를 사용하면 초기 모델 제작이나 초기 개발 중에 아직 구현안된 기능에 대한 짜투리 표시를 만들어 둘 수 있으며, 짜투리 구현으로  `fatalError("Unimplemented")` 와 같이 할 수 있습니다. 'fatal errors (치명적인 에러)' 는 최적화로도 절대 없어지지 않기 때문에, '단언' 이나 '선행 조건' 과는 달리, 이 짜투리 구현에 도달하게 되면 항상 실행이 중단될 것임을 확신할 수 있습니다.

### 참고 자료

[^The-Basics]: 원문은 [The Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html) 에서 확인할 수 있습니다.

[^private-use-Unicode-scalar-values]: '사용자 영역 유니코드 크기 값' 이란 '유니코드 평면 (Unicode planes)' 에서 '사용자 영역 (private-use areas)' 에 있는 값을 말합니다. 유니코드에는 '15번 평면 (`F0000 ~ FFFFF`)' 과 '16번 평면 (`100000 ~ 10FFFF`)', 이렇게 두 개의 '사용자 영역 (private-use areas)' 이 있습니다. 더 자세한 내용은 위키피디아의 [Plane (Unicode)](https://en.wikipedia.org/wiki/Plane_(Unicode)) 및 [유니코드 평면](https://ko.wikipedia.org/wiki/유니코드_평면) 항목을 참고하기 바랍니다.

[^annotation]: 'annotation' 는 사실 '주석' 이라는 옮기는 것이 가장 적당하지만, '주석' 은 프로그래밍 분야에서 'comments' 라는 말로 이미 널리 쓰이고 있으므로, 스위프트의 'annotation' 을 '보조 설명' 이라는 말로 옮기도록 하겠습니다. 실제로 스위프트에서 'annotation' 을 쓸 일은 거의 없기 때문에 이 용어의 의미에 크게 비중을 두지 않아도 될 것 같습니다.

[^backticks]: 'backtics' 는 'grave accent' 라고도 하며 우리말로는 실제로는 '억음 부호' 라고 합니다. 말이 어렵기 때문에 의미 전달의 편의를 위해 '역따옴표' 라고 옮깁니다. 'grave accent' 에 대해서는 위키피디아의 [Grave accent](https://en.wikipedia.org/wiki/Grave_accent) 또는 [억음 부호](https://ko.wikipedia.org/wiki/억음_부호) 항목을 참고하기 바랍니다.

[^string-interpolation]: 'interpolation' 은 원래 수학 용어로 '보간법' 이라고 하며 두 값 사이의 값을 근사식으로 구해서 집어넣는 것을 말합니다. 'string interpolation' 은 '문자열 삽입법' 정도로 할 수 있겠지만, 수학 용어로 '보간법' 이라는 말이 널리 쓰이고 있으므로 '문자열 보간법' 이라고 옮기도록 합니다.

[^escape]: 'escape' 는 '벗어나다' 라는 의미를 가지고 있는데, 컴퓨터 용어에서 'escape character' 라고 하면 '(본래의 의미를) 벗어나서 (다른 의미를 가지는) 문자' 라는 의미가 있습니다. 참고로 스위프트에서 'escaping closure' 는 '(본래 영역을) 벗어날 수 있는 클로저' 를 의미합니다.

[^word]: 컴퓨터 용어로 'word (워드; 단어)' 는 프로세서에서 한 번에 처리할 수 있는 데이터 단위를 말합니다.

[^base-number]: 'base number' 는 우리 말로 지수의 '밑수', '가수', '기저' 등의 여러 말로 옮길 수 있는데, 컴퓨터 용어로 엄일하게 말 할 때는 '가수' 라는 말을 쓰는 것 같습니다. 여기서는 일단 지수의 밑수라는 말로 옮겼습니다. 일부동-소수점 수에서의 'base-number' 는 '유효 숫자' 에 해당한다고 볼 수 있으며, 더 자세한 내용은 위키피디아의 [부동소수점](https://ko.wikipedia.org/wiki/부동소수점) 과 [Floating-point arithmetic](https://en.wikipedia.org/wiki/Floating-point_arithmetic) 항목을 참고하기 바랍니다.

[^permutation]: 'permutation' 은 수학 용어로 '순열' 을 의미합니다. '순열' 이라는 것은 서로 다른 n개의 원소에서 r개를 선택해서 한 줄로 세울 수 있는 경우의 수를 말합니다. 즉 r개의 원소들을 서로 다른 순서로 줄 지을 수 있는 가지 수를 말하며, 스위프트의 튜플은 이 모든 경우에 대해서 튜플을 만들 수 있다는 의미가 됩니다. 여기서는 모든 순열에 대해 튜플을 만들 수 있다는 것을 원소의 순서에 상관없이 튜플을 만들 수 있다는 의미로 옮겼습니다. 보다 자세한 내용은 위키피디아의 [순열](https://ko.wikipedia.org/wiki/순열) 또는 [Permutation](https://en.wikipedia.org/wiki/Permutation) 항목을 참고하기 바랍니다.
