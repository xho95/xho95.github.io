---
layout: post
comments: true
title:  "Swift 5.7: The Basics (기초)"
date:   2016-04-24 19:45:00 +0900
categories: Swift Language Grammar Basics
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [The Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html) 부분[^The-Basics]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## The Basics (기초)

스위프트는 **iOS** 와, **macOS**, **watchOS**, 및 **tvOS** 앱 개발을 위한 새로운 프로그래밍 언어입니다. 그럼에도 불구하고, **C** 와 **오브젝티브-C**  개발 경험으로부터 스위프트의 수많은 부분들이 익숙할 것입니다.

스위프트는 모든 **C** 및 **오브젝티브-C** 기본 타입에 자신만의 버전을 제공하며, 이는 정수를 위한 `Int` 와, 부동 소수점 값을 위한 `Double` 및 `Float`, 불리언 값을 위한 `Bool`, 및 텍스트 데이터를 위한 `String` 을 포함합니다. 스위프트는 강력한 버전의 세 으뜸 집합체 타입인, `Array` 와, `Set`, 및 `Dictionary`[^set-dictionary] 도 제공하는데, [Collection Types (집합체 타입)]({% post_url 2016-06-06-Collection-Types %}) 에서 설명합니다.

**C** 같이, 스위프트는 식별 이름[^identifying-name] 으로 값을 저장하고 참조하는데 변수를 사용합니다. 스위프트는 값을 바꿀 수 없는 변수도 광범위하게 사용합니다. 이를 상수라고 하며, **C** 에 있는 상수보다 훨씬 더 강력합니다. 스위프트 전반에 걸쳐 상수를 사용하면 바꿀 필요 없는 값과 작업할 의도일 때의 코드를 더 안전하고 명확하게 만듭니다.

익숙한 타입에다가, 스위프트는 **오브젝티브-C** 엔 없는, 튜플 같은, 진보한 타입도 도입합니다. 튜플은 값의 그룹을 생성하고 전달할 수 있게 합니다. 튜플을 사용하면 함수에서 여러 개의 값을 단일 복합 값[^compound-value] 으로 반환할 수 있습니다.

스위프트는 옵셔널 타입[^optional-types] 도 도입하는데, 이는 값의 없음[^absence] 을 처리합니다. 옵셔널은 "값이 _있는데 (is)_, 그건 _x_ 입니다" 라고 하거나 "전혀 값이 _없습니다 (isn't)_" 라고 말합니다. 옵셔널을 사용하는 건 오브젝티브-C 에서 포인터에 `nil` 을 사용하는 것과 비슷하지만, 클래스만이 아니라, 어떤 타입에도 쓸 수 있습니다. 옵셔널은 오브젝티브-C 의 `nil` 포인터 보다 더 안전하면서 표현력도 더 좋을 뿐 아니라, 수많은 스위프트의 가장 강력한 특징 중에서도 심장부에 해당합니다.

스위프트는 _타입-안전 (type-sefe)_ 언어인데, 이는 코드에서 작업할 수 있는 값의 타입이 명확하도록 언어가 도와준다는 의미입니다. 코드가 `String` 을 요구하면, 타입 안전 장치[^type-safety] 가 실수로 `Int` 를 전달하는 걸 막아줍니다. 마찬가지로, 타입 안전 장치는 옵셔널-아닌 `String` 을 요구한 코드 조각에 옵셔널 `String` 을 전달하는 사고도 막아줍니다. 타입 안전 장치는 개발 과정에서 가능한 일찍 에러를 잡아내서 고칠 수 있게 돕습니다.

### Constants and Variables (상수와 변수)

상수와 변수는 (`maximumNumberOfLoginAttempts` 나 `welcomeMessage` 같은) 이름을 (`10` 이라는 수나 `"Hello"` 라는 문자열 같은) 특별한 타입의 값과 결합합니다. _상수 (constant)_ 값은 한 번 설정하고 나면 바꿀 수 없는 반면, _변수 (variable)_ 는 미래에 다른 값을 설정할 수 있습니다.

#### Declaring Constants and Variables (상수와 변수 선언하기)

상수와 변수는 반드시 사용 전에 선언해야 합니다. 상수는 `let` 키워드로 변수는 `var` 키워드로 선언합니다. 상수와 변수로 사용자의 로그인 시도 횟수를 추적할 수 있는 사례는 이렇습니다:

```swift
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
```

이 코드는 다음 처럼 읽을 수 있습니다:

"`maximumNumberOfLoginAttempts` 라는 새로운 상수를 선언하고, `10` 이라는 값을 줍니다. 그런 다음, `currentLoginAttempt` 라는 새로운 변수를 선언하고, `0` 이라는 초기 값을 줍니다."

이 예제에서, 최대 로그인 허용 횟수는 상수로 선언하는데, 최대 값은 절대로 바뀌지 않기 때문입니다. 현재 로그인 횟수 측정기는 변수로 선언하는데, 이 값은 각각의 로그인 시도가 실패한 뒤엔 반드시 증가해야 하기 때문입니다.

여러 개의 상수나 여러 개의 변수를 한 줄로 선언하려면, 쉼표로 구분하면 됩니다:

```swift
var x = 0.0, y = 0.0, z = 0.0
```

> 코드에 있는 저장 값을 바꾸지 않을 거면, 항상 `let` 키워드를 써서 상수로 선언합니다. 바꿀 필요가 있는 저장 값에만 변수를 사용합니다.

#### Type Annotations (타입 보조 설명)

상수나 변수를 선언할 때 _타입 보조 설명 (type annotation)_[^annotation] 을 제공하면, 상수나 변수가 저장할 수 있는 값의 종류를 명확하게 합니다. 타입 보조 설명을 작성하려면 상수나 변수 이름 뒤에 콜론과, 공백을 둔 다음, 사용할 타입 이름을 두면 됩니다.

다음 예제는 `welcomeMessage` 라는 변수에 타입 보조 설명을 제공하여, `String` 값을 저장할 수 있는 변수라는 걸 지시합니다: 

```swift
var welcomeMessage: String
```

선언에서 콜론은 "...타입인 (of type)..." 이라는 의미라서, 위 코드를 다음 처럼 읽을 수 있습니다:

"`String` 타입인 `welcomeMessage` 라는 변수를 선언합니다."

"`String` 타입인" 이라는 구절은 "어떤 `String` 값이든 저장할 수 있다" 는 의미입니다. 저장할 수 있는 "어떤 것의 타입" (또는 "어떤 것의 종류") 라는 의미로 생각하면 됩니다.

이제 `welcomeMessage` 변수엔 어떤 문자열 값이든 에러 없이 설정할 수 있습니다:

```swift
welcomeMessage = "Hello"
```

똑같은 타입인 여러 개의 관련 변수를 한 줄로 정의하려면, 쉼표로 구분하고, 최종 변수 이름 뒤에 단일한 타입 보조 설명을 두면 됩니다:

```swift
var red, green, blue: Double
```

> 사실상 타입 보조 설명을 작성할 필요는 거의 없습니다. 상수나 변수 정의 시점에 초기 값을 제공하면, [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)](#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 에서 설명한 것처럼, 스위프트가 거의 항상 그 상수나 변수에 사용할 타입을 추론할 수 있습니다. 위의 `welcomeMessage` 예제에선, 초기 값을 제공하지 않아서, `welcomeMessage` 변수의 타입을 초기 값으로 추론하게 하기 보단 타입 보조 설명으로 지정한 겁니다.

#### Naming Constants and Variables (상수와 변수 이름짓기)

상수와 변수 이름엔 거의 어떤 문자든 담을 수 있는데, 유니코드 문자[^unicode-characters] 도 포함합니다:

```swift
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"
```

상수와 변수 이름은 공백 문자[^whitespace] 나, 수학 기호[^mathematical-symbols], 화살표[^arrows], 사용자 영역 유니코드 크기 값[^private-use-Unicode-scalar-values], 또는 선- 및 상자-그리기 문자[^line-drawing-and-box-drawing] 를 담을 수 없습니다. 숫자로 시작하는 것도 안되긴 하지만, 이름 안의 다른 곳에 숫자를 포함시킬 순 있습니다.

일단 한번 특정 타입의 상수나 변수를 선언하면, 똑같은 이름으로 다시 선언하거나, 다른 타입 값을 저장하게 바꿀 수 없습니다. 상수를 변수로 변수를 상수로 바꿀 수도 없습니다.

> 상수나 변수에 스위프트가 예약한 키워드[^reserved-swift-keyword] 와 똑같은 이름을 줄 필요가 있다면, 키워드를 이름으로 사용할 때 역따옴표 (`` ` ``)[^backticks] 로 둘러쌉니다. 하지만, 선택할게 절대로 없는게 아닌 한 이름에 키워드를 사용하는 걸 피하도록 합니다.

기존 변수 값을 호환 가능한 타입의 다른 값으로 바꿀 수 있습니다. 다음 예제에선, `friendlyWelcome` 값을 `"Hello!"` 에서 `"Bonjour!"` 로 바꿉니다:

```swift
var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"
// friendlyWelcome 은 이제 "Bonjour!" 임
```

변수와 달리, 상수 값은 설정 후에 바꿀 수 없습니다. 그렇게 하려고 하면 코드를 컴파일할 때 에러라고 보고합니다:

```swift
let languageName = "Swift"
languageName = "Swift++"
// This is a compile-time error: languageName cannot be changed. (이는 컴파일-시간 에러입니다: languageName 은 바꿀 수 없습니다.)
```

#### Printing Constants and Variables (상수와 변수 인쇄하기)

`print(_:separator:terminator:)` 함수로 상수나 변수의 현재 값을 인쇄할 수 있습니다:

```swift
print(friendlyWelcome)
// "Bonjour!" 를 인쇄함
```

`print(_:separator:terminator:)` 함수는 전역 함수로서 하나 이상의 값을 적절한 출력 결과로 인쇄합니다. **엑스코드** 에선, 예를 들어, `print(_:separator:terminator:)` 함수가 자신의 출력 결과를 **엑스코드** 의 "콘솔 (console)" 판에 인쇄합니다. `separator` 와 `terminator` 매개 변수엔 기본 값이 있어서, 이 함수의 호출 때 생략할 수 있습니다. 기본적으로, 함수는 줄 끊음[^line-break] 을 추가하는 걸로 자신이 인쇄하는 줄을 종결합니다. 줄 끊음 없이 값을 인쇄하려면 빈 문자열을 종결자 (terminator) 로 전달합니다-예를 들어, `print(someValue, terminator : "")` 라고 합니다. 기본 값이 있는 매개 변수에 대한 정보는, [Default Parameter Values (기본 매개 변수 값)]({% post_url 2020-06-02-Functions %}#default-parameter-values-기본-매개-변수-값) 부분을 보도록 합니다.

스위프트는 _문자열 보간법 (string interpolation)_[^string-interpolation] 을 써서 상수나 변수 이름을 더 긴 문자열의 자리 표시자[^placeholder] 로 포함시키고, 스위프트가 이를 그 상수나 변수의 현재 값으로 즉시 교체하게 합니다. 이름을 괄호로 포장하고 여는 괄호 앞에서 역 빗금[^backslash] 으로 벗어나게[^escape] 하면 됩니다:

```swift
print("The current value of friendlyWelcome is \(friendlyWelcome)")
// "The current value of friendlyWelcome is Bonjour!" 를 인쇄함
```

> 문자열 보간법과 같이 쓸 수 있는 모든 옵션은 [String Interpolation (문자열 끼워 넣기)]({% post_url 2016-05-29-Strings-and-Characters %}#string-interpolation-문자열-끼워-넣기) 에서 설명합니다.

### Comments (주석)

주석을 사용하면 실행 불가능한 글을 코드에 포함시켜, 스스로 기록하거나 떠올리게 합니다. 주석은 스위프트가 코드를 컴파일할 때 무시합니다.

스위프트 주석은 **C** 주석과 매우 비슷합니다. 한-줄짜리 주석은 두 개의 빗금(`//`)[^forward-slashes] 으로 시작합니다:

```swift
// 이것은 주석입니다.
```

여러 줄짜리 주석은 빗금과 그 뒤의 별표 (`/*`)[^asterisk] 로 시작해서 별표와 그 뒤의 빗금 (`*/`) 으로 끝납니다:

```swift
/* 이것도 주석이지만
 여러 줄 위에 작성합니다 */
```

**C** 의 여러 줄 주석과 달리, 스위프트의 여러 줄 주석은 다른 여러 줄 주석 안에 중첩할 수 있습니다. 중첩 주석을 작성하려면 여러 줄 주석 블럭을 시작한 다음 첫 번째 블럭 안에서 두 번째 여러 줄 주석을 시작하면 됩니다. 그런 다음 두 번째 블럭을 닫은, 뒤에 첫 번째 블럭을 닫습니다:

```swift
/* 이것은 첫 번째 여러 줄 주석의 시작입니다.
 /* 이것은 중첩된, 두 번째 여러 줄 주석입니다. */
 이것은 첫 번째 여러 줄 주석의 끝입니다. */
```

여러 줄 주석의 중첩은, 코드에 이미 여러 줄 주석이 있더라도, 빠르고 쉽게 아주 큰 코드 블럭을 주석 처리할 수 있도록 합니다.

### 세미콜론 (Semicolons)

수많은 다른 언어와 달리, 스위프트는 각각의 구문 뒤에 세미콜론 (`;`) 을 작성하길 요구하지 않으나, 원한다면 그럴 순 있습니다. 하지만, 여러 개의 별도 구문을 한 줄에 작성하고 싶으면 세미콜론 _이 (are)_ 필수입니다:

```swift
let cat = "🐱"; print(cat)
// "🐱" 를 인쇄함
```

### Integers (정수)

_정수 (integers)_ 는, `42` 와 `-23` 같이, 분수 성분이 없는 수 전체입니다. 정수는 _부호 있는 (signed)_ 것 (양수, 0, 또는 음수) 이거나 _부호 없는 (unsigned)_ 것 (양수, 또는 0) 입니다.

스위프트는 8, 16, 32, 및 64 비트 형식의 부호 있는 그리고 부호 없는 정수를 제공합니다. 이 정수들은 **C** 와 비슷한 작명법[^naming-convention] 을 따라서, 8-비트 부호 없는 정수는 `UInt8` 타입이고, 32-비트 부호 있는 정수는 `Int32` 타입입니다. 스위프트의 모든 타입 같이, 이 정수 타입 이름들도 대문자로 시작합니다.

#### Integer Bounds (정수의 경계)

각 정수 타입의 최소 및 최대 값엔 `min` 과 `max` 속성으로 접근할 수 있습니다:

```swift
let minValue = UInt8.min  // minValue 는 0 이고, 타입은 UInt8 임
let maxValue = UInt8.max  // maxValue 는 255 이고, 타입은 UInt8 임
```

이 속성 값들은 적절한-크기의 수치 타입 (위 예제의 `UInt8` 같은 것) 이므로 표현식 안에서 타입이 똑같은 다른 값과 나란하게 사용할 수 있습니다.

#### Int (정수)

대부분의 경우, 정해진 크기의 정수를 골라서 코드에 사용할 필요는 없습니다. 스위프트는 추가 정수 타입으로, `Int` 를 제공하는데, 이는 현재 플랫폼 고유의 워드 크기[^word] 와 똑같은 크기입니다:

* 32-비트 플랫폼에서, `Int` 는 `Int32` 와 똑같은 크기입니다.
* 64-비트 플랫폼에서, `Int` 는 `Int64` 와 똑같은 크기입니다.

정해진 크기의 정수가 필요한게 아닌 한, 항상 코드 안의 정수 값에 `Int` 를 사용하도록 합니다. 이는 코드 일관성[^consistency] 과 상호 호환성[^interoperability] 을 높입니다. 심지어 32-비트 플랫폼의, `Int` 도 `-2,147,483,648` 에서 `2,147,483,647` 사이의 어떤 값이든 저장할 수 있으며, 수많은 정수 범위로는 이것도 충분히 큽니다.

#### UInt (부호없는 정수)

스위프트는 부호없는 정수 타입인, `UInt` 도 제공하는데, 이것의 크기는 현재 플랫폼 고유의 워드 크기와 똑같습니다:

* 32-비트 플랫폼에서, `UInt` 는 `UInt32` 와 똑같은 크기입니다.
* 64-비트 플랫폼에서, `UInt` 는 `UInt64` 와 똑같은 크기입니다.

> `UInt` 는 특히 플랫폼 고유의 워드 크기와 크기가 똑같은 부호 없는 정수가 필요할 때만 사용합니다. 이 경우가 아니면, 저장 값이 음수가 아님을 알 때라도, `Int` 가 더 좋습니다. 정수 값에 `Int` 를 일관되게 사용하면, [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)](#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 에서 설명하듯, 코드의 상호 호환성도 높이고, 다른 수치 타입끼리 변환할 필요도 없애주며, 정수 타입 추론과도 (잘) 맞습니다.

### Floating-Point Numbers (부동-소수점 수)

_부동-소수점 수 (floating-point numbers)_ 는, `3.14159` 와, `0.1`, 및 `-273.15` 같이, 분수 성분이 있는 수입니다.

부동-소수점 타입은 정수 타입보다 훨씬 더 넓은 범위의 값을 나타낼 수 있으며, `Int` 가 저장할 수 있는 것보다 훨씬 더 크거나 작은 수도 저장할 수 있습니다. 스위프트는 두 개의 부호 있는 부동-소수점 수치 타입을 제공합니다:

* `Double` 은 64-비트 부동-소수점 수를 나타냅니다.
* `Float` 은 32-비트 부동-소수점 수를 나타냅니다.

> `Double` 의 정밀도는 적어도 15 자리 유효 숫자[^decimal-digits] 인 반면, `Float` 의 정밀도는 6 자리 유효 숫자인 만큼 작습니다. 사용에 적절한 부동-소수점 타입은 코드 작업에 필요한 값의 고유 성질과 범위에 달려 있습니다. 어느 타입이어도 적절할 상황이면, `Double` 이 더 좋습니다.

### Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)

스위프트는 _타입이-안전한 (type-safe)_ 언어입니다. 타입 안전 언어는 코드에서 작업할 값의 타입이 명확하다는 자신감을 줍니다. 코드가 `String` 을 요구한다면, 실수로 `Int` 를 전달할 수 없습니다.

스위프트는 타입 안전하기 때문에, 코드 컴파일 때 _타입 검사 (type checks)_ 를 하여 어떤 안맞는 타입에든 에러를 표시합니다. 이는 개발 과정에서 최대한 빨리 에러를 잡아내고 고치게 합니다.

타입-검사는 서로 다른 타입인 값과 작업할 때의 에러를 피하도록 도와줍니다. 하지만, 이것이 의미하는게 선언할 모든 상수와 변수에 타입을 지정해야 한다는 건 아닙니다. 필요한 값의 타입을 지정하지 않으면, 스위프트가 _타입 추론 장치 (type inference)_ 를 사용하여 적절한 타입을 알아냅니다. 타입 추론 장치는 컴파일러가 코드를 컴파일할 때, 제공된 값을 단순히 검토함으로써, 특별한 표현식 타입을 자동으로 이끌어 내도록 합니다.[^deduce]

타입 추론 때문에, 스위프트가 요구하는 타입 선언은 **C** 나 **오브젝티브-C** 같은 언어보다 훨씬 적습니다. 상수와 변수는 여전히 타입을 명시하지만, 대부분의 타입 지정 작업은 알아서 합니다.

타입 추론은 초기 값이 있는 상수나 변수를 선언할 때 특히 더 유용합니다. 이는 선언 시점에 상수나 변수에 _글자 값 (literal value_ 또는 _literal)_ 을 할당할 때 자주 일어납니다. (글자 값은 소스 코드에 직접 나타나는, 아래 예제의 `42` 와 `3.14159` 같은, 값입니다.)

예를 들어, 새로운 상수에 `42` 라는 글자 값을 할당하면서 무슨 타입인지 말하지 않으면, `Int` 상수를 원한다고 스위프트가 추론하는데, 이를 정수 같아 보이는 수로 초기화하기 때문입니다:

```swift
let meaningOfLife = 42
// meaningOfLife 를 Int 타입이라고 추론함
```

마찬가지로, 부동 소수점 글자 값에 타입을 지정하지 않으면, `Double` 의 생성을 원한다고 스위프트가 추론합니다:

```swift
let pi = 3.14159
// pi 를 Double 타입이라고 추론함
```

스위프트가 부동-소수점 수의 타입을 추론할 땐 항상 (`Float` 보단) `Double` 을 선택합니다.

표현식 안에 정수와 부동-소수점 글자 값을 조합하면, 상황으로부터 `Double` 이라는 타입을 추론할 것입니다:

```swift
let anotherPi = 3 + 0.14159
// anotherPi 도 Double 타입이라고 추론함
```

글자 값 `3` 은 그 자체에 명시적 타입이 있는 것도 그 자체가 타입인 것도 아니라서, 덧셈 연산 부분에 부동-소수점 글자 값이 있다는 것으로부터 적절한 출력 타입이 `Double` 이라는 걸 추론합니다.

### Numeric Literals (수치 글자 값)

정수 글자 값은 다음 처럼 작성할 수 있습니다:

* _10진 (decimal)_ 수, 아무런 접두사 없음
* _2진 (binary)_ 수, `0b` 접두사 있음
* _8진 (octal)_ 수, `0o` 접두사 있음
* _16진 (hexadecimal)_ 수, `0x` 접두사 있음

다음 모든 정수 글자 값의 10진 값은 `17` 입니다:

```swift
let decimalInteger = 17
let binaryInteger = 0b10001       // 17 의 2진 표기법
let octalInteger = 0o21           // 17 의 8진 표기법
let hexadecimalInteger = 0x11     // 17 의 16진 표기법
```

부동-소수점 글자 값은 (아무런 접두사 없는) 10진수, 또는 (`0x` 접두사 있는) 16진수일 수 있습니다. 반드시 항상 소수점[^decimal-point] 양 쪽 모두에 수 (또는 16진수) 가 있어야 합니다. 10진 부동수엔 옵션으로 _지수 (exponent)_ 도 있을 수 있는데, 대소문자 `e` 로 지시합니다; 16진 부동수엔 반드시 지수가 있어야 하는데, 대소문자 `p` 로 지시합니다.

지수가 `exp` 인 10진수는, 밑수[^base-number] 에 10<sup>exp</sup> 을 곱합니다:

* `1.25e2` 는 1.25 x 10<sup>2</sup>, 또는 `125.0` 를 의미합니다.
* `1.25e-2` 는 1.25 x 10<sup>-2</sup>, 또는 `0.0125` 를 의미합니다.

지수가 `exp` 인 16진수는, 밑수에 2<sup>exp</sup> 을 곱합니다:

* `0xFp2` 는 15 x 2<sup>2</sup>, 또는 `60.0` 을 의미합니다.
* `0xFp-2` 는 15 x 2<sup>-2</sup>, 또는 `3.75` 를 의미합니다.

다음 모든 부동-소수점 글자 값의 10진 값은 `12.1875` 입니다:

```swift
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0
```

수치 글자 값에 부가적인 양식[^formatting] 을 담아 더 읽기 쉽게 만들 수 있습니다. 정수와 부동수 둘 다에 부가적인 0 을 덧댈 수도 있고 밑줄을 담아 가독성[^readability] 을 도울 수도 있습니다. 어느 타입의 양식도 실제 글자 값에 영향을 주지 않습니다:

```swift
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
```

### Numeric Type Conversion (수치 타입 변환)

음수가 아니라는 걸 알더라도, 코드의 모든 일반-용 정수 상수와 변수엔, `Int` 타입을 사용합니다. 언제 어디서나 기본 정수 타입을 사용하면 코드 안의 정수 상수와 변수가 곧바로 상호 호환 가능하고 정수 글자 값으로 추론한 타입과도 맞을 거라는 걸 의미합니다.

외부 소스에서 크기를 명시한 자료이거나, 성능 및, 메모리 사용량을 위해, 또는 그 외 필요한 최적화 때문에, 특히 당장 필요한 임무일 때만 다른 정수 타입을 사용합니다. 이러한 상황에서 크기를 명시한 타입을 사용하면 어떤 값 넘침 사고든 잡아내도록 하며 사용 중인 자료의 고유 성질을 암시적으로 문서화합니다.[^documents]

#### Integer Conversion (정수 변환)

정수 상수나 변수가 저장할 수 있는 수의 범위는 각각의 수치 타입마다 다릅니다. `Int8` 상수나 변수는 `-128` 에서 `127` 사이의 수를 저장할 수 있는 반면, `UInt8` 상수나 변수는 `0` 에서 `255` 사이의 수를 저장할 수 있습니다. 크기를 정한 정수 타입 상수나 변수에 들어 맞지 않는 수는 코드를 컴파일할 때 에러로 보고합니다:

```swift
let cannotBeNegative: UInt8 = -1
// UInt8 은 음수를 저장할 수 없어서, 이는 에러라고 보고할 것임
let tooBig: Int8 = Int8.max + 1
// Int8 은 자신의 최대 값 보다 큰 수를 저장할 수 없어서,
// 이것도 에러로 보고할 것임
```

각각의 수치 타입에 저장한 값의 범위가 서로 다를 수 있기 때문에, 반드시 각각의 경우마다 수치 타입 변환을 직접 선택해줘야 합니다.[^opt-in] 이런 직접-선택 접근법은 숨겨진 변환 에러를 막아주며 타입 변환 의도를 코드에 명시하도록 돕습니다.

한 특정 수치 타입을 다른 걸로 변환하려면, 기존 값으로 원하는 타입의 새 수치 값을 초기화합니다. 아래 예제에서, 상수 `twoThousand` 는 `UInt16` 타입인 반면, 상수 `one` 은 `UInt8` 타입입니다. 타입이 똑같지 않기 때문에, 이들을 직접 더할 순 없습니다. 그 대신, 이 예제는 `UInt16(one)` 을 호출하여 `one` 값으로 새로운 `UInt16` 를 생성하고, 이 값을 원본 대신 사용합니다:

```swift
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
```

이제 덧셈 양 쪽이 모두 `UInt16` 타입이기 때문에, 덧셈이 됩니다. (`twoThousandAndOne` 이라는) 출력 상수는 `UInt16` 타입으로 추론하며, 이는 `UInt16` 값 두 개의 합이기 때문입니다.

`SomeType(ofInitialValue)` 는 스위프트 타입의 초기자를 호출하고 초기 값을 전달하는 기본 방식입니다. 그 속을 보면, `UInt16` 에 `UInt8` 값을 받는 초기자가 있어서, 이 초기자를 써서 기존 `UInt8` 로 새로운 `UInt16` 를 만듭니다. 하지만, 여기에 _어떤 (any)_ 타입이든 전달할 수 있는 건 아닙니다-`UInt16` 이 초기자를 제공한 타입이어야 합니다. 기존 타입을 확장하여 (자신이 정의한 타입을 포함한) 새로운 타입을 받는 초기자를 제공하는 건 [Extensions (익스텐션; 확장)]({% post_url 2016-01-19-Extensions %}) 에서 다룹니다.

#### Integer and Floating-Point Conversion (정수와 부동-소수점 수 변환)

정수와 부동-소수점 수치 타입 간의 변환은 반드시 명시해야 합니다:

```swift
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi 는 3.14159 이고, Double 타입으로 추론함
```

여기선, 상수인 `three` 값으로 새로운 `Double` 타입 값을 생성해서, 덧셈의 양 쪽 타입이 다 똑같습니다. 이 변환을 적당한 곳에서 하지 않으면, 덧셈이 안 될 겁니다.

부동-소수점 수에서 정수로의 변환도 반드시 명시해야 합니다. `Double` 이나 `Float` 값으로 정수 타입을 초기화할 수 있습니다:

```swift
let integerPi = Int(pi)
// integerPi 는 3 이고, Int 타입으로 추론함
```

이런 식으로 새 정수 값을 초기화할 땐 부동-소수점 값이 항상 잘립니다. 이는 `4.75` 은 `4` 가, `-3.9` 는 `-3` 이 된다는 의미입니다.

> 수치 상수와 변수를 조합하는 규칙은 수치 글자 값의 규칙과 다릅니다. 글자 값 `3` 과 글자 값 `0.14159` 는 직접 더할 수 있는데, 이는 수치 글자 값 그 자체에 명시적 타입이 있는 것도 그 자체가 타입인 것도 아니기 때문입니다. 이들의 타입은 컴파일러가 이들을 평가하는 시점에만 추론됩니다.

### Type Aliases (타입 별명)

_타입 별명 (type aliases)_ 은 기존 타입을 위한 대안 이름[^alternative] 을 정의합니다. 타입 별명은 `typealias` 키워드로 정의합니다.

타입 별명은, 외부 소스에서 크기가 정해진 데이터와 작업할 때 같이, 기존 타입을 상황에 더 적절하게 맞는 이름으로 참조하고 싶을 때 유용합니다:

```swift
typealias AudioSample = UInt16
```

일단 한 번 타입 별명을 정의하면, 원본 이름을 사용할 수 있는 어떤 곳에든 별명을 사용할 수 있습니다:

```swift
var maxAmplitudeFound = AudioSample.min
// maxAmplitudeFound 는 이제 0 임
```

여기선, `AudioSample` 을 `UInt16` 의 별명으로 정의합니다. 별명이기 때문에, `AudioSample.min` 호출은 실제로 `UInt16.min` 을 호출하는데, 이는 `maxAmplitudeFound` 변수에 `0` 이라는 초기 값을 제공합니다.

### Booleans (불리언; 논리 값)

스위프트엔, `Bool` 이라는, 기초적인 _불리언 (Boolean)_ 타입이 있습니다. 불리언 값은 _논리 값 (logical)_ 이라고 하는데, 늘 참 또는 거짓만 될 수 있기 때문입니다. 스위프트는, `true` 와 `false` 라는, 두 개의 불리언 상수 값을 제공합니다:

```swift
let orangesAreOrange = true
let turnipsAreDelicious = false
```

`orangesAreOrange` 와 `turnipsAreDelicious` 타입은 불리언 글자 값으로 초기화한다는 사실로 인하여 `Bool` 로 추론되었습니다. 위에 있는 `Int` 와 `Double` 처럼, 상수나 변수를 생성하자 마자 `true` 나 `false` 로 설정하면 `Bool` 로 선언할 필요가 없습니다. 타입 추론 장치는 이미 타입을 아는 값으로 상수나 변수를 초기화할 때 더 간결하고 읽기 쉬운 스위프트 코드를 만들도록 해줍니다.

불리언 값은 `if` 문 같은 조건문과 작업할 때 특히 더 유용합니다:

```swift
if turnipsAreDelicious {
  print("Mmm, tasty turnips!")
} else {
  print("Eww, turnips are horrible.")
}
// "Eww, turnips are horrible." 를 인쇄함
```

`if` 문 같은 조건문은 [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 장에서 더 자세히 다룹니다.

스위프트 타입 안전 장치는 불리언-아닌 값이 `Bool` 을 대체하는 걸 막아 줍니다. 다음 예제는 컴파일-시간 에러를 보고합니다:

```swift
let i = 1
if i {
  // 이 예제는 컴파일하지 않고, 에러를 보고할 것임
}
```

하지만, 대안으로 밑에 있는 예제는 유효합니다:

```swift
let i = 1
if i == 1 {
  // 이 예제는 컴파일 성공할 것임
}
```

`i == 1` 비교 결과는 `Bool` 타입이라서, 이 두 번째 예제는 타입 검사를 통과합니다. `i == 1` 같은 비교 연산은 [Basic Operators (기초 연산자)]({% post_url 2016-04-27-Basic-Operators %}) 에서 논의합니다.

스위프트의 다른 타입 안전 장치 예제 처럼, 이 접근법은 우연한 사고로 인한 에러를 피하고 코드의 특별한 코드의 의도가 항상 명확하도록 보장합니다.

### Tuples (튜플; 짝)

_튜플 (tuples)_ 은 여러 개의 값을 그룹지어 단 하나의 복합 값을 만듭니다. 튜플 안에 있는 값은 어떤 타입이든 될 수 있으며 서로 똑같은 타입이 아니어도 됩니다.

다음 예제에서, `(404, "Not Found")` 는 _HTTP 상태 (status) 코드_ 를 설명하는 튜플입니다. HTTP 상태 코드는 웹 페이지 요청 때마다 웹 서버가 반환하는 특수한 값입니다. 요청한 웹 페이지가 존재하지 않으면 `404 Not Found` 라는 상태 코드를 반환합니다.

```swift
let http404Error = (404, "Not Found")
// http404Error 는 (Int, String) 타입이며, (404, "Not Found") 와 같음
```

`(404, "Not Found")` 튜플은 `Int` 와 `String` 을 함께 그룹지어 HTTP 상태 코드에 두 개의 별도 값을 주는데: 수치 값과 사람이-읽을 수 있는 설명이 그것입니다. 이는 "`(Int, String)` 타입인 튜플" 이라고 설명할 수 있습니다.

튜플은 어떤 순서 조합[^permutation] 의 타입으로든 생성할 수 있으며, 서로 다른 타입을 원하는 만큼 많이 담을 수 있습니다. `(Int, Int, Int)` 나, `(String, Bool)`, 또는 진짜 필요한 다른 어떤 순서 조합 타입인 튜플도 다 됩니다.

튜플의 내용을 별도의 상수나 변수로 _분해 (decompose)_ 한 다음, 평소 처럼 접근할 수 있습니다:

```swift
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// "The status code is 404" 를 인쇄함
print("The status message is \(statusMessage)")
// "The status message is Not Found" 를 인쇄함
```

일부 튜플 값만 필요하다면, 튜플을 분해할 때 밑줄 (`_`) 로 튜플의 일부분을 무시합니다:

```swift
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
// "The status code is 404" 를 인쇄함
```

대안으로, 0 부터 시작하는 색인 번호[^index] 를 써서 튜플의 개별 원소 값에 접근합니다:

```swift
print("The status code is \(http404Error.0)")
// "The status code is 404" 를 인쇄함
print("The status message is \(http404Error.1)")
// "The status message is Not Found" 를 인쇄함
```

튜플을 정의할 때 튜플 안의 개별 원소에 이름을 붙일 수 있습니다:

```swift
let http200Status = (statusCode: 200, description: "OK")
```

튜플 원소에 이름을 붙이면, 원소 이름을 써서 그 원소 값에 접근할 수 있습니다:

```swift
print("The status code is \(http200Status.statusCode)")
// "The status code is 200" 를 인쇄함
print("The status message is \(http200Status.description)")
// "The status message is OK" 를 인쇄함
```

튜플은 함수 반환 값으로 특히 더 유용합니다. 웹 페이지를 가져오려는 함수는 `(Int, String)` 튜플 타입을 반환하여 페이지 가져오기의 성공 또는 실패를 설명할지도 모릅니다. 서로 다른 타입인, 별개의 두 값이 있는 튜플을 반환함으로써, 단일 타입인 단 하나의 값만 반환할 수 있는 경우보다 함수 자신의 결과물에 대해 더 유용한 정보를 제공합니다. 더 많은 정보는, [Functions with Multiple Return Values (반환 값이 여러 개인 함수)]({% post_url 2020-06-02-Functions %}#functions-with-multiple-return-values-반환-값이-여러-개인-함수) 부분을 보도록 합니다.

> 튜플은 단순한 그룹의 관련 값에 유용합니다. 복잡한 자료 구조의 생성에는 적합하지 않습니다. 자료 구조가 더 복잡해질 것 같으면, 튜플 보다는, 클래스나 구조체로 모델링 합니다. 더 많은 정보는, [Structures and Classes (구조체와 클래스)]({% post_url 2020-04-14-Structures-and-Classes %}) 장을 보도록 합니다.

### Optionals (옵셔널)

_옵셔널 (optionals)_ 은 값이 없을 수도 있는 상황에서 사용합니다. 옵셔널은 두 가지 가능성을 나타내는데: 값이 _있어서 (is)_, 옵셔널의 포장을 풀고 그 값에 접근할 수 있다, 또는 값이 전혀 _없다 (isn't)_ 라는게 그것입니다.

> **C** 나 **오브젝티브-C** 에는 옵셔널이라는 개념이 존재하지 않습니다. **오브젝티브-C** 에서 (그나마) 가장 가까운 건, "유효한 객체가 없음" 을 의미하는 `nil` 을 가지고, 다른 경우라면 객체를 반환했을 메소스가 `nil` 을 반환하는 능력입니다. 하지만, 이는 객체하고만 작동합니다-구조체나, C 기초 타입, 또는 열거체 값과 작동하진 않습니다. 이러한 타입에선, 전형적으로 오브젝티브-C 메소드가 (`NSNotFound` 같은) 특수한 값을 반환하여 값의 없음을 지시합니다. 이런 접근법은 메소드를 호출한 쪽이 테스트할 특수 값이 있다는 것도 알고 검사하는 걸 기억도 하고 있다고 가정합니다. 스위프트 옵셔널은 _아예 어떤 타입 (any type at all)_ 의 값 없음이든 지시하면서, 특수 상수도 필요 없습니다.

옵셔널로 값의 없음을 대처할 수 있는 예는 이렇습니다. 스위프트의 `Int` 타입엔 `String` 값을 `Int` 값으로 자동 변환하려는 초기자가 있습니다. 하지만, 모든 문자열을 정수로 변환할 수 있는 건 아닙니다. `"123"` 이라는 문자열은 `123` 이라는 수치 값으로 변환할 수 있지만, `"hello, world"` 라는 문자열은 변환할 수치 값이 분명하지 않습니다:

아래 예제는 초기자를 사용하여 `String` 을 `Int` 로 변환하려 합니다:

```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber 는 "Int?", 또는 "optional Int" 타입으로 추론함
```

초기자가 실패할지 모르기 때문에, `Int` 보단, _옵셔널 (optional)_ `Int` 를 반환합니다. 옵셔널 `Int` 는, `Int` 가 아니라, `Int?` 라고 작성합니다. 물음표는 자신이 담은 값이 옵셔널임을 지시하는데, 이는 _어떠한 (some)_ `Int` 값을 담고 있을 수도, 아니면 _아예 아무런 값 (no value at all)_ 도 담지 않을 수도 있다는 의미입니다. (`Bool` 값이나 `String` 값 같은, 어떤 다른 것도 담을 수 없습니다. `Int` 이거나, 아예 아무 것도 아닌 겁니다.)

#### nil

옵셔널 변수에 값이 없는 상태를 설정하려면 `nil` 이라는 특수 값을 할당하면 됩니다:

```swift
var serverResponseCode: Int? = 404
// serverResponseCode 는 404 라는 실제 Int 값을 담음
serverResponseCode = nil
// serverResponseCode 는 이제 아무 값도 담지 않음
```

> 옵셔널-아닌 상수와 변수엔 `nil` 을 쓸 수 없습니다. 특정 조건에서 코드가 값이 없는 상수나 변수와 작업할 필요가 있다면, 항상 적절한 타입의 옵셔널 값으로 선언합니다.

옵셔널 변수를 정의하면서 기본 값을 제공하지 않으면, 변수에 자동으로 `nil` 을 설정합니다:

```swift
var surveyAnswer: String?
// surveyAnswer 에 자동으로 nil 을 설정합니다.
```

> 스위프트의 `nil` 은 오브젝티브-C 의 `nil` 과 똑같은게 아닙니다. 오브젝티브-C 의, `nil` 은 존재하지 않는 객체로의 포인터[^pointer] 입니다. 스위프트의, `nil` 은 포인터가 아닙니다-이는 특정 타입의 값이 없다는 것입니다. 객체 타입만이 아니라, _어떤 (any)_ 타입의 옵셔널도 `nil` 로 설정할 수 있습니다.

#### If Statements and Forced Unwrapping (If 문과 강제 포장 풀기)

`if` 문으로 옵셔널이 값을 담고 있는지 알아내려면 옵셔널을 `nil` 과 비교하면 됩니다. 이 비교 연산은 "같음 (equal to)" 연산자 (`==`) 나 "같지 않음 (not equal to)" 연산자 (`!=`) 로 합니다:

옵셔널에 값이 있으면, `nil` 과 "같지 않다" 고 고려합니다:

```swift
if convertedNumber != nil {
  print("convertedNumber contains some integer value.")
}
// "convertedNumber contains some integer value." 를 인쇄함
```

일단 한 번 옵셔널이 값을 담은 _걸 (does)_ 확신하면, 옵셔널 이름 끝에 느낌표 (`!`) 를 추가하여 그 실제 값에 접근할 수 있습니다. 느낌표의 효과는, "이 옵셔널엔 값이 있다는 걸 확실하게 알고 있으니; 사용하기 바랍니다." 라고 말하는 겁니다. 이를 옵셔널 값의 _강제 포장 풀기 (forced unwrapping)_ 라고 합니다:

```swift
if convertedNumber != nil {
  print("convertedNumber has an integer value of \(convertedNumber!).")
}
// "convertedNumber has an integer value of 123." 을 인쇄함
```

`if` 문에 대한 더 많은 건, [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 부분을 보도록 합니다.

> `!` 로 존재하지 않는 옵셔널 값에 접근하려 하면 실행 시간 에러를 발생시킵니다. `!` 로 자신의 값을 강제로-풀기 전에 항상 옵셔널에 `nil`-아닌 값이 담겨 있는지 확실히 합니다.

#### Optional Binding (옵셔널 연결)

_옵셔널 연결 (optional binding)_ 을 사용하면 옵셔널이 값을 담고 있는지 알아내서, 그렇다면, 그 값을 임시 상수나 변수로 쓸 수 있게 합니다. 옵셔널 연결을 `if` 와 `while` 문과 같이 써서 옵셔널 안의 값을 검사하는 것과, 그 값을 상수나 변수로 뽑아내는 걸, 단 하나의 행동으로 할 수 있습니다. `if` 와 `while` 문은 [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 장에서 더 자세히 설명합니다.

`if` 문에서 옵셔널 연결을 쓰는 건 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;if let `constantName-상수 이름` = `someOptional-어떤 옵셔널` {<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`statements-구문`<br />
&nbsp;&nbsp;&nbsp;&nbsp;}

[Optionals (옵셔널)](#optionals-옵셔널) 절의 `possibleNumber` 예제도 강제 풀기 보단 옵셔널 연결을 사용하도록 다시 쓸 수 있습니다:

```swift
if let actualNumber = Int(possibleNumber) {
  print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
  print("The string \"\(possibleNumber)\" could not be converted to an integer")
}
// "The string "123" has an integer value of 123" 을 인쇄함
```

이 코드는 다음 처럼 읽을 수 있습니다:

"`Int(possibleNumber)` 가 반환한 옵셔널 `Int` 에 값이 담겼으면, `actualNumber` 라는 새 상수에 옵셔널 안에 담긴 값을 설정합니다."

자동 변환[^conversion] 이 성공하면, `actualNumber` 상수가 `if` 문 첫 번째 분기 안에서 쓸 수 있게 됩니다. 이미 옵셔널 _안에 (within)_ 담긴 값으로 초기화돼서, `!` 접미사로 값에 접근하지 않습니다. 이 예제에선, `actualNumber` 로 단순히 자동 변환한 결과만 인쇄합니다.

옵셔널 상수나 변수가 담은 값에 접근한 후에, 원본을 참조할 필요가 없으면, 새로운 상수나 변수 이름을 똑같은 걸로 쓸 수 있습니다:

```swift
let myNumber = Int(possibleNumber)
// 여기선, myNumber 가 옵셔널 정수임
if let myNumber = myNumber {
  // 여기선, myNumber 가 옵셔널-아닌 정수임
  print("My number is \(myNumber)")
}
// "My number is 123" 을 인쇄함
```

이 코드는, 이전 예제 코드 같이, `myNumber` 가 값을 담고 있는지 검사하는 걸로 시작합니다. `myNumber` 에 값이 있으면, 이름이 `myNumber` 인 새 상수의 값을 그 값으로 설정합니다. `if` 문의 본문 안에서, `myNumber` 를 쓰면 새로운 옵셔널-아닌 상수를 참조합니다. `if` 문의 시작 전과 끝난 후에, `myNumber` 를 쓰면 옵셔널 정수인 상수를 참조합니다.

이런 종류의 코드가 너무 흔하기 때문에, 더 짧은 철자법으로 옵셔널 값을 풀 수가 있는데: 포장을 풀 상수나 변수의 이름을 그냥 쓰는 겁니다. 새로, 푼 상수나 변수는 암시적으로 옵셔널 값과 똑같은 이름을 사용합니다.

```swift
if let myNumber {
  print("My number is \(myNumber)")
}
// "My number is 123" 을 인쇄함
```

상수와 변수 둘 다 옵셔널 연결과 쓸 수 있습니다. 첫 번째 `if` 문 분기에서 `myNumber` 값을 조작하고 싶었다면, 그 대신 `if var myNumber` 라고 써서, 옵셔널 안의 값을 상수 보단 변수로 쓰도록 할 수 있었을 겁니다. `if` 문 본문 안에서 `myNumber` 를 바꾸면 그 지역 변수에만 적용되지, 포장을 푼 원본, 옵셔널 상수나 변수는 _아닙니다 (not)_.

단일한 `if` 문에 옵셔널 연결과 불리언 조건을 필요한 만큼 많이 포함시키려면, 쉼표로 구분하면 됩니다. 어떤 옵셔널 연결 값이든 `nil` 이거나 어떤 불리언 조건 평가든 `false` 면, 전체 `if` 문의 조건이 `false` 라고 고려합니다. 다음의 `if` 문들은 서로 같은 겁니다:

```swift
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
  print("\(firstNumber) < \(secondNumber) < 100")
}
// "4 < 42 < 100" 를 인쇄함

if let firstNumber = Int("4") {
  if let secondNumber = Int("42") {
    if firstNumber < secondNumber && secondNumber < 100 {
      print("\(firstNumber) < \(secondNumber) < 100")
    }
  }
}
// "4 < 42 < 100" 를 인쇄함
```

> `if` 문에서 옵셔널 연결로 생성한 상수와 변수는 `if` 문 본문에서만 쓸 수 있습니다. 이와 대조하여, [Early Exit (때 이른 탈출문)]({% post_url 2020-06-10-Control-Flow %}#early-exit-때-이른-탈출문) 에서 설명하듯, `guard` 문으로 생성한 상수와 변수는 `guard` 문 뒤의 코드 줄에서 쓸 수 있습니다.

#### Implicitly Unwrapped Optionals (암시적으로 포장 푸는 옵셔널)

위에서 설명한 것처럼, 옵셔널은 상수나 변수의 "값 없음" 을 허용한다고 지시합니다. 옵셔널을 `if` 문으로 검사하면 값이 존재하는지 알아볼 수 있고, 옵셔널 값이 존재하면 옵셔널 연결로 조건부로 포장을 풀어 이에 접근할 수 있습니다.

최초로 값을 설정한 후엔, 프로그램 구조에 의해 옵셔널에 _항상 (always)_ 값이 있음이 명확할 때가 있습니다. 이 경우엔, 옵셔널 값에 접근할 때마다 검사하고 포장 푸는 걸 제거하는게 유용한데, 모든 시간에 값이 있다고 가정해도 안전하기 때문입니다.

이런 종류의 옵셔널을 _암시적으로 포장 푸는 옵셔널 (implicitly unwrapped optionals)_ 이라고 정의합니다. 암시적으로 포장 푸는 옵셔널을 쓰려면 옵셔널을 만들고 싶은 타입 뒤에 물음표 (`String?`) 보단 느낌표 (`String!`) 를 붙이면 됩니다. 사용할 때 옵셔널 이름 뒤에 느낌표를 두는 것 보단, 선언할 때 옵셔널 타입 뒤에 느낌표를 둡니다.[^implicitly-optional-declare]

암시적으로 포장 푸는 옵셔널은 최초로 옵셔널을 정의한 바로 뒤에 옵셔널 값이 존재한다는게 확정되고 그 후의 모든 시점에도 확실히 존재한다고 가정할 수 있을 때 유용합니다. [Unowned References and Implicitly Unwrapped Optional Properties (소유하지 않는 참조와 암시적으로 포장 푸는 옵셔널 속성)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#unowned-references-and-implicitly-unwrapped-optional-properties-소유하지-않는-참조와-암시적으로-포장-푸는-옵셔널-속성) 에서 설명한 것처럼, 스위프트에서 암시적으로 포장 푸는 옵셔널은 클래스 초기화 중에 사용하는게 으뜸입니다.

암시적으로 포장 푸는 옵셔널도 그 속을 보면 보통의 옵셔널이지만, 접근할 때마다 옵셔널 값의 포장을 풀 필요가 없는, 옵셔널-아닌 값 처럼 사용할 수도 있습니다. 다음 예제는 자신의 포장 값을 명시적 `String` 으로 접근할 때의 옵셔널 문자열과 암시적으로 포장 푸는 옵셔널 문자열 동작의 차이를 보여줍니다:

```swift
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 느낌표를 요구함

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // 느낌표가 필요 없음
```

암시적으로 포장 푸는 옵셔널은 옵셔널에 필요하다면 강제-포장 풀기 권한을 준 것처럼 생각할 수 있습니다. 암시적으로 포장 푸는 옵셔널 값을 사용할 때, 최초엔 스위프트가 이를 평범한 옵셔널 값으로 사용하려 하며; 옵셔널로 사용할 수 없으면, 스위프트가 값의 포장을-강제로 풉니다. 위 코드에선, 옵셔널 값 `assumedString` 을 `implicitString` 에 할당하기 전에 그 값의 포장을-강제로 푸는데 이는 `implicitString` 이 명시적인, 옵셔널-아닌 `String` 타입이기 때문입니다. 아래 코드의, `optionalString` 은 명시적 타입이 없으므로 평범한 옵셔널입니다.

```swift
let optionalString = assumedString
// optionalString 의 타입은 "String?" 이며 assumedString 을 강제로-포장 풀지 않습니다.
```

암시적으로 포장 푸는 옵셔널이 `nil` 인데 이 포장 값에 접근하려 하면, 실행 시간 에러를 발생시킬 겁니다. 그 결과는 마치 값을 담지 않은 보통의 옵셔널 뒤에 느낌표를 둔 것과 정확히 똑같습니다.

암시적으로 포장 푸는 옵셔널이 `nil` 인지는 보통의 옵셔널 검사와 똑같은 방식으로 검사할 수 있습니다:

```swift
if assumedString != nil {
  print(assumedString)
}
// "An implicitly unwrapped optional string." 를 인쇄함
```

암시적으로 포장 푸는 옵셔널을 옵셔널 연결과 사용하여, 단일 구문으로 자신의 값 검사와 포장 풀기를 할 수도 있습니다:

```swift
if let definiteString = assumedString {
  print(definiteString)
}
// "An implicitly unwrapped optional string." 를 인쇄함
```

> 더 나중 시점에 변수가 `nil` 일 가능성이 있을 땐 암시적으로 포장 푸는 옵셔널을 사용하지 않습니다. 변수가 살아 있는 중에 `nil` 값 검사가 필요한 경우라면 항상 보통의 옵셔널 타입을 사용합니다.

### Error Handling (에러 처리)

_에러 처리 (error handling)_ 를 사용하여 실행 중에 프로그램이 마주칠 수 있는 에러 조건에 응답합니다.

값의 있고 없음으로 함수의 성공 또는 실패를 소통할 수 있는, 옵셔널과 대조하여, 에러 처리는 실패의 실제 원인을 결정하도록 하며, 그리하여, 필요하다면, 에러를 프로그램 다른 부분으로 전파합니다.

함수는 에러 조건과 마주칠 때, 에러를 _던집니다 (throws)_. 그러면 그 함수를 호출한 쪽이 적절하게 에러를 _잡아내어 (catch)_ 응답할 수 있습니다.

```swift
func canThrowAnError() throws {
  // 이 함수는 에러를 던질 수도 아닐 수도 있음
}
```

함수가 에러를 던질 수 있다고 지시하려면 그 선언에 `throws` 키워드를 포함시키면 됩니다. 에러를 던질 수 있는 함수를 호출할 땐, `try` 키워드를 표현식 앞에 붙입니다.

스위프트는 에러가 `catch` 절에서 처리될 때까지 현재 범위 밖으로 자동으로 전파합니다.

```swift
do {
  try canThrowAnError()
  // 아무 에러도 던지지 않았음
} catch {
  // 에러를 던졌음
}
```

`do` 문은 새로운 시야 범위를 생성하여, 에러를 하나 이상의 `catch` 절로 전파하도록 허용합니다.

에러 처리로 서로 다른 에러 조건에 응답할 수 있는 예는 이렇습니다:

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

이 예제에선, 쓸만한 깨끗한 접시가 없거나 어떤 재료를 깜빡하면 `makeASandwich()` 함수가 에러를 던질 겁니다. `makeASandwich()` 가 에러를 던질 수 있기 때문에, 함수 호출을 `try` 표현식으로 포장합니다. `do` 문으로 함수 호출을 포장함으로써, 어떤 에러를 던져도 제공한 `catch` 절로 전파할 겁니다.

던진 에러가 없으면, `eatASandwich()` 함수를 호출합니다. 던진 에러가 `SandwichError.outOfCleanDishes` case 와 맞으면, `washDishes()` 함수를 호출할 겁니다. 던진 에러가 `SandwichError.missingIngredients` case 와 맞으면, 그 땐 `catch` 패턴이 붙잡은 `[String]` 결합 값을 가지고 `buyGroceries(_:)` 함수를 호출합니다.

에러 던지기와, 붙잡기, 및 전파하기는 [Error Handling (에러 처리)]({% post_url 2020-05-16-Error-Handling %}) 에서 아주 자세히 다룹니다.

### Assertions and Preconditions (단언문과 선행 조건문)

_단언문 (assertions)_ 과 _선행 조건문 (Preconditions)_ 은 실행 시간에 발생하는 검사입니다. 이를 사용하여 어떤 코드를 더 실행하기 전에 본질적인 조건을 만족하고 있는지 확실히 합니다. 단언문이나 선행 조건문의 불리언 조건 평가가 `true` 면, 코드 실행을 평소 처럼 계속합니다. 조건 평가가 `false` 면, 현재 프로그램 상태가 무효라서; 코드 실행을 끝내고, 앱을 종료합니다.

단언문과 선행 조건문을 사용해서 코딩 동안 만든 가정[^assumptions] 과 예상값[^expectations] 을 표현하여, 이를 코드 부분에 포함시킬 수 있습니다. 단언문은 실수와 잘못한 가정들을 개발 중에 찾도록 도와주며, 선행 조건문은 제품의 문제점[^issues] 을 탐지하도록 도와줍니다.

실행 시간에 예상값을 검증하는 것에 더해, 코드 안에 문서화하는 형식으로도 단언문과 선행 조건문이 유용합니다. 위의 [Error Handling (에러 처리)](#error-handling-에러-처리) 에서 논의한 에러 조건과 달리, 복구 가능하거나 예상한 에러에 단언문과 선행 조건문을 사용하진 않습니다. 실패한 단언문이나 선행 조건문은 무효한 프로그램 상태[^invalid-sate] 를 지시하기 때문에, 실패한 단언문을 잡아내는 방법 같은 건 없습니다.

단언문과 선행 조건문의 사용은 무효한 조건이 생기진 않을 것 같다는 식으로 코드 설계를 대체하는게 아닙니다. 하지만, 이를 써서 유효한 데이터와 상태를 강제하면 무효 상태에서의 앱 종료를 더 예측 가능하게 하며, 문제를 더 쉽게 디버그하도록 도와줍니다. 무효 상태를 탐지하자 마자 실행을 멈추는 것도 그 무효 상태가 일으킨 피해를 제한하도록 도와줍니다.

단언문과 선행 조건문의 차이는 검사 시점에 있는데: 단언문은 디버그 제작[^debug-builds] 일 때만 검사 하지만, 선행 조건문은 디버그 및 제품 제작[^debug-and-production-builds] 둘 다에서 검사합니다. 제품 제작 (모드) 에선, 단언문 안의 조건을 평가하지 않습니다. 이는 개발 과정 중에 단언문을 원하는 만큼 많이 써도, 제품 성능에는 큰 충격을 주지 않는다는, 의미입니다.

#### Debugging with Assertions (단언문으로 디버깅하기)

단언문을 작성하려면 스위프트 표준 라이브러리의 [assert(_:_:file:line:)](https://developer.apple.com/documentation/swift/1541112-assert) 함수를 호출하면 됩니다. 이 함수에 `true` 나 `false` 로 평가할 표현식과 조건 결과가 `false` 면 보여줄 메시지를 전달합니다. 예를 들면 다음과 같습니다:

```swift
let age = -3
asset(age >= 0, "A person's age can't be less than zero.")
// 이 단언문은 실패인데 -3 은 0 보다 크거나 같지 않기 (>=0) 때문임
```

이 예제에선, `age >= 0` 평가가 `true` 면, 즉, `age` 값이 음수가 아니면, 코드 실행을 계속합니다. 위 코드 처럼, `age` 값이 음수면, `age >= 0` 평가가 `false` 이고, 단언문을 실패하며, 응용 프로그램을 종결합니다.

단언문 메시지는 생략할 수 있습니다-예를 들어, 그냥 조건문을 글자 그대로 되풀이 할 때 그럽니다.

```swift
assert(age >= 0)
```

코드에서 이미 검사한 조건이면, [assertionFailure(_:file:line:)](https://developer.apple.com/documentation/swift/1539616-assertionfailure) 함수로 단언문의 실패를 지시합니다. 예를 들면 다음과 같습니다:

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

조건이 잠재적으로 거짓일 순 있지만, 코드 실행을 계속하려면 반드시 _확실하게 (definitely)_ 참이어야 할 때마다, 선행 조건문을 사용합니다. 예를 들어, 선행 조건문으로 첨자가 경계를 벗어났는지 검사하거나, 함수에 유효한 값을 전달했는지를 검사합니다.

선행 조건문을 작성하려면 [precondition(_:_:file:line:)](https://developer.apple.com/documentation/swift/1540960-precondition) 함수를 호출하면 됩니다. 이 함수에 `true` 나 `false` 로 평가할 표현식과 조건 결과가 `false` 면 보여줄 메시지를 전달합니다. 예를 들면 다음과 같습니다:

```swift
// 첨자 구현 안에서...
precondition(index > 0, "Index must be greater than zero.")
```

[preconditionFailure(_:file:line:)](https://developer.apple.com/documentation/swift/1539374-preconditionfailure) 함수를 호출하여 실패가 일어났음을 지시할 수도 있는데-예를 들어, 모든 유효한 입력 데이터는 switch 문의 다른 case 절에서 처리하는게 좋음에도, switch 문의 기본 case 를 차지한 경우에 그렇습니다.

> 검사하지 않음 모드 (`-Ounchecked`)[^unchecked] 로 컴파일하면, 선행 조건문을 검사하지 않습니다. 컴파일러는 선행 조건문이 항상 참이라고 가정하며, 그에 따라 코드를 최적화합니다. 하지만, `fatalError(_:file:line:)` 함수는, 최적화 설정에 상관없이, 항상 실행을 중단합니다.
>
> `fatalError(_:file:line:)` 함수를 프로토 타입 및 이른 개발 시기에 사용하여 아직 구현안된 자투리 기능을 생성하려면, `fatalError("Unimplemented")` 를 자투리 구현[^stub] 으로 쓰면 됩니다. 치명적인 에러[^fatal-errors] 는 절대로 최적화로 없어지지 않기 때문에, 단언문이나 선행 조건문과 달리, 짜투리 구현과 마주치면 실행이 항상 중단된다고 확신할 수 있습니다.

### 다음 장

[Basic Operators (기초 연산자) > ]({% post_url 2016-04-27-Basic-Operators %})

### 참고 자료

[^The-Basics]: 원문은 [The Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html) 에서 확인할 수 있습니다.

[^set-dictionary]: `Set` 은 실제 수학 용어로써 '집합' 이라는 의미이고, `Dictionary` 는 '사전' 이라는 의미입니다. 하지만, 본문에서 자료 타입으로 사용할 때는 이들을 **셋** 과 **딕셔너리** 처럼 발음 그대로 옮깁니다. `Array` 는 오랜 시간 동안 이미 **배열** 이라는 용어를 사용해 오고 있기 때문에, 계속해서 배열이라고 옮깁니다.

[^annotation]: 'annotation' 는 사실 '주석' 이라고 옮기는 것이 가장 적당하지만, 프로그래밍 분야에서는 'comments' 가 '주석' 이라고 이미 쓰이고 있으므로, 스위프트의 'annotation' 은 '보조 설명' 이라고 옮깁니다. 실제로 스위프트에서는 'annotation' 을 쓸 일이 거의 없기 때문에 이 용어에는 비중을 크게 두지 않아도 됩니다.

[^private-use-Unicode-scalar-values]: 유니코드에는 '15번 평면 (`F0000 ~ FFFFF`) 과 16번 평면 (`100000 ~ 10FFFF`)' 이라는, 두 개의 '사용자 영역 (private-use areas)' 이 있습니다. '사용자 영역 유니코드 크기 값' 은 '유니코드 평면 (Unicode planes) 의 사용자 영역 (private-use areas) 에 있는 값' 을 말합니다. '유니코드 평면' 에 대한 더 자세한 정보는, 위키피디아의 [Plane (Unicode)](https://en.wikipedia.org/wiki/Plane_(Unicode)) 항목과 [유니코드 평면](https://ko.wikipedia.org/wiki/유니코드_평면) 항목을 참고하기 바랍니다.

[^string-interpolation]: 'interpolation' 은 원래 수학 용어로 '보간법' 이라고 하며, 두 값 사이에 근사식으로 구한 값을 집어넣는 것을 말합니다. 'string interpolation' 은 '문자열 삽입법' 정도로 옮길 수도 있지만, 수학 용어로 '보간법' 이라는 말이 널리 쓰이고 있으므로 '문자열 보간법' 이라고 옮깁니다.

[^escape]: 'escape' 는 '벗어나다' 라는 의미를 가지고 있는데, 컴퓨터 용어에서 'escape character' 는 '(본래의 의미를) 벗어나서 (다른 의미를 가지는) 문자'-즉, '특수한 의미를 가지는 문자' 정도로 이해할 수 있습니다. 참고로 스위프트에는 'escaping closure' 라는 것도 있는데, 이는 '(자신이 정의되어 있는 영역을) 벗어나서 (존재할 수 있는) 클로저'-즉, '영역을 벗어날 수 있는 클로저' 정도의 의미를 가지고 있습니다.

[^word]: 컴퓨터 용어로 'word (워드; 단어)' 는 프로세서에서 한 번에 처리할 수 있는 데이터 단위를 말합니다.

[^deduce]: 원문에서 'deduce' 라는 단어를 사용했는데, 이는 수학의 논리 용어로 '연역하다' 라는 의미입니다. 즉, 스위프트에서는 연역법으로 타입을 추론한다고 이해할 수 있습니다.

[^documents]: '사용 중인 자료의 고유 성질을 암시적으로 문서화한다' 는 건, 예를 들어, `Int` 라고 할 걸 `UInt8` 이라고 하면 타입의 범위가 `0 ~ 255` 까지라는 걸 알 수 있듯이, 타입을 명시하는 것 자체도 하나의 문서화에 해당한다는 의미입니다. '암시적인 문서화 (implicitly documents)' 는 별도의 주석이나 문서 작성 없이 코드 그 자체가 문서화 효과를 가지는 걸 말합니다. 문서화에 대한 더 자세한 정보는, [API Design Guidelines (API 설계 지침)]({% post_url 2020-09-15-API-Design-Guidelines %}) 안의 '문서화 주석' 부분 설명을 참고하기 바랍니다.

[^backticks]: 'backtics' 는 'grave accent' 라고도 하며 우리말로는 '억음 부호' 라고 합니다. 말이 이해하기 어렵기 때문에 의미 전달을 위해 '역따옴표' 라고 옮깁니다. 'grave accent' 에 대해서는 위키피디아의 [Grave accent](https://en.wikipedia.org/wiki/Grave_accent) 항목 또는 [억음 부호](https://ko.wikipedia.org/wiki/억음_부호) 항목을 참고하기 바랍니다.

[^base-number]: 'base number' 는 우리 말로 지수의 '밑수', '가수', '기저' 등의 말로 옮길 수 있는데, 컴퓨터 용어로 엄밀하게 말 할 때는 '가수' 라는 말을 쓰는 것 같습니다. 여기서는 일단 지수의 '밑수' 라고 옮깁니다. 부동-소수점 수에서는 'base-number' 가 '유효 숫자' 에 해당하는데, 이에 대한 더 자세한 내용은 위키피디아의 [부동소수점](https://ko.wikipedia.org/wiki/부동소수점) 항목과 [Floating-point arithmetic](https://en.wikipedia.org/wiki/Floating-point_arithmetic) 항목을 참고하기 바랍니다.

[^permutation]: 'permutation' 은 수학 용어로 '순열' 을 의미합니다. '순열' 이라는 것은 서로 다른 `n` 개의 원소에서 `r` 개를 선택해서 한 줄로 세울 수 있는 경우의 수입니다. 즉, 원소가 `n` 개인 튜플의 경우의 수는 이 순열 개수 만큼 많다는 의미입니다. 여기서는 '순열' 이라는 말을 좀 더 이해하기 쉽게 '순서 조합' 라는 말로 옮겼습니다. 순열에 대한 더 자세한 정보는, 위키피디아의 [Permutation](https://en.wikipedia.org/wiki/Permutation) 항목과 [순열](https://ko.wikipedia.org/wiki/순열) 항목을 참고하기 바랍니다.

[^conversion]: 새로운 상수에 값을 설정할 때 그 값의 타입을 상수 타입으로 '자동 변환 (conversion)' 하게 되는데, 성공할 수도 있고 실패할 수도 있습니다. 

[^stub]: '자투리 (stub)' 는 나무 토막이나 그루터기 처럼 그 자체로는 미완성인 것을 말합니다. '자투리 구현 (stub implementation)' 은 소프트웨어 개발 과정에서 아직 완성안된 기능을 위해 임시로 놓아 두는 코드입니다. 자투리 구현에 대한 더 자세한 정보는, 위키피디아의 [Method stub](https://en.wikipedia.org/wiki/Method_stub) 과 [메소드 스텁](https://ko.wikipedia.org/wiki/메소드_스텁) 항목을 참고하기 바랍니다.