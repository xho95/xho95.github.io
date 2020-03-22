---
layout: post
comments: true
title:  "Swift 5.2: The Basics (기초)"
date:   2016-04-24 19:45:00 +0900
categories: Swift Language Grammar Basics
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [The Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html) 부분[^The-Basics]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## The Basics (기초)

스위프트는 iOS, macOS, watchOS 그리고 tvOS 용 앱을 개발할 수 있는 새로운 프로그래밍 언어입니다. 그럼에도 불구하고 C 언어와 오브젝티브-C 언어로 개발한 경험이 있다면 스위프트의 많은 부분들이 이미 익숙할 것입니다.

스위프트는 자신만의 방식으로 C 언어와 오브젝티브-C 언어에 있는 모든 기본 타입들을 제공하며, 여기에는 정수를 위한 `Int`, 부동 소수점 값을 위한 `Double` 과 `Float`, 논리 (Boolean) 값을 위한 `Bool`, 그리고 텍스트 데이터를 위한 `String` 을 포함합니다. 스위프트는 강력한 방식으로 세 가지 주요 컬렉션 (집합체) 타입인, `Array` (배열), `Set` (셋), 그리고 `Dictionary` (딕셔너리) 도 제공하며, 이는 [Collection Types (집합체 타입)](https://xho95.github.io/swift/grammar/collection/array/set/dictionary/2016/06/06/Collection-Types.html) 에서 설명합니다.

C 언어와 마찬가지로, 스위프트도 '식별 이름 (identifying name)' 을 써서 값을 저장하고 참조하기 위해 '변수' 를 사용합니다. 스위프트는 값을 바꿀 수 없는 변수 역시 역시 광범위하게 사용합니다. 이를 '상수' 라고 하는데, C 언어의 상수보다 훨씬 더 강력합니다. 상수는 바뀔 필요가 없는 값을 가지고 작업할 때 코드를 더 안전하고 명확하게 만들 목적으로 스위프트 전반에 걸쳐서 사용됩니다.

이런 익숙한 타입들 외에, 스위프트에는 C 언어에는 없는 고급 타입들도 있는데, '튜플 (tuple)' 이 그렇습니다. 튜플을 사용하면 값들을 '그룹으로 뭉쳐서 (group)' 생성하고 전달할 수 있습니다. 함수에서 여러 개의 값을 반환하고자 할 떄 튜플로 '단일한 복합 값 (single compound value)' 을 만들어서 반환하면 됩니다.

스위프트에는 'Optional (선택) 타입' 이라는 것도 있어서, 값이 없는 상태를 처리할 수 있습니다. 'Optional (선택)' 은 "값이 _있으며 (is)_, 그 값은 x 입니다" 또는 "값이 전혀 _없습니다 (isn't)_" 라고 합니다. 'Optional' 을 사용하는 것은 오브젝티브-C 언어의 포인터에 `nil` 을 사용하는 것과 비슷하지만, '클래스 (class)' 뿐만 아니라 모든 타입에 대해서 사용할 수 있다는 것이 다릅니다. 'Optional' 은 오브젝티브-C 언어에 있는 `nil` 포인터보다 더 안전하고 의미도 잘 드러낼 뿐만 아니라, 스위프트에 있는 가장 강력한 특징들 중에서도 핵심이라고 할 수 있습니다.

스위프트는 '_타입-안전 (type-sefe)_' 언어이며, 이는 코드에서 사용할 값의 타입을 명확히 알 수 있도록 언어가 도와준다는 것을 의미합니다. 코드 일부에서 `String` 을 요구하는데, 실수로 `Int` 를 전달하면 '타입 안전기 (type safety)' 가 이를 막아줍니다. 이와 마찬가지로, '타입 안전기' 는 옵셔널이 아닌 `String` 을 요구하는 코드에 실수로 'Optional  `String`' 을 전달하는 것도 막아줍니다.  '타입 안전기' 는 개발 과정에서 최대한 빨리 에러를 잡아내고 고칠 수 있도록 도와줍니다.

### Constants and Variables (상수와 변수)

상수와 변수는 이름 (가령 `maximumNumberOfLoginAttempts` 나 `welcomeMessage` 등) 을 특정한 타입의 값 (가령 정수 `10` 이나 문자열 `Hello` 등) 과 관련지어 줍니다. _상수 (constant)_ 의 값은 한번 설정하면 바꿀 수 없으나, _변수 (variable)_ 는 나중에 다른 값으로 설정하는 것이 가능합니다.

#### Declaring Constants and Variables (상수와 변수 선언하기)

상수와 변수는 사용하기 전에 반드시 선언부터 해야 합니다. 상수 선언은 `let` 키워드를 사용하고 변수는 `var` 키워드를 사용합니다. 상수와 변수를 사용해서 사용자의 로그인 시도 횟수를 추적하는 방법에 대한 예제를 살펴봅시다:

```swift
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
```

이 코드는 다음 처럼 이해할 수 있습니다:

"새로운 상수 `maximNumberOfLoginAttempts` 를 선언하고, 값은 `10` 으로 줍니다. 그런 다음, 새로운 변수 `currentLoginAttempt` 를 선언하고, 초기 값으로 `0` 을 줍니다."

이 예에서, '허용 가능한 최대 로그인 시도 횟수' 는 상수로 선언했는데, 이는 최대 값이 절대로 변하지 않기 때문입니다. '현재 로그인 시도 횟수' 는 변수로 선언했는데, 이는 로그인 시도가 실패할 때마다 반드시 값이 증가돼야 하기 때문입니다.

한 줄에 여러 개의 상수와 변수를 선언하려면, '쉼표 (commas)' 로 구분하면 됩니다:

```swift
var x = 0.0, y = 0.0, z = 0.0
```

> 코드에서 저장된 값이 바뀌지 않는다면, 항상 `let` 키워드를 써서 상수로 선언하기 바랍니다.[^constant-optimization] 변수는 저장된 값이 바뀔 가능성이 있는 경우에만 쓰기 바랍니다.

#### Type Annotations (타입 보조 설명)

상수나 변수를 선언할 때 _타입 보조 설명 (type annotation)_[^annotation] 을 제공해서, 상수나 변수에 저장할 수 있는 값의 종류를 명확하게 드러낼 수 있습니다. '타입 보조 설명' 을 쓰려면 상수나 변수의 이름 뒤에 콜론을 붙이고, 공백으로 띄운 다음, 사용할 타입의 이름을 적으면 됩니다.

아래 예제는 `welcomeMessage` 라는 변수에 '타입 보조 설명' 을 제공하여, 변수가 `String` 값을 저장할 수 있음을 지시합니다:

```swift
var welcomeMessage: String
```

선언문에 있는 콜론은 "...타입인..." 을 의미하므로 위의 코드는 다음과 같이 이해할 수 있습니다:

"`String` 타입인 `welcomeMessage` 변수를 선언하기 바랍니다."

"`String` 타입인" 이라는 구절은 "어떤 `String` 값도 저장할 수 있다" 는 것을 의미합니다. 이는 저장할 수 있는 "것의 타입인" (또는 "것의 종류인") 의 의미로 생각할 수 있습니다.

이제 `welcomeMessage` 변수에는 어떤 문자열 값도 설정할 수 있으며 에러도 없습니다:

```swift
welcomeMessage = "Hello"
```

서로 관련성이 있는 같은 타입의 변수 여러 개를 한 줄에 정의할 수도 있는데, 이 때는 쉼표로 구분한 후, 마지막 변수 이름 뒤에 '타입 보조 설명' 을 한 번만 붙이면 됩니다:

```swift
var red, green, blue: Double
```

> 실제로 '타입 보조 설명 (type annotations)' 을 쓸 일은 거의 없습니다. 상수나 변수를 정의할 때 초기 값을 제공하면, 스위프트는 거의 항상 상수나 변수에서 사용할 타입을 추론할 수 있으며, 이는 [Type Safety and Type Inference (타입 안전기와 타입 추론기)](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html#ID322) 에서 설명합니다. 위에 있는 `welcomeMessage` 예제에서는, 초기 값이 제공되지 않았으므로, `welcomeMessage` 변수의 타입을 초기 값으로 추론하지 않고 '타입 보조 설명' 으로 지정했습니다.

#### Naming Constants and Variables (상수와 변수 이름짓기)

상수와 변수의 이름은 '유니코드 문자 (Unicode characters)' 를 포함해서 거의 모든 문자를 가질 수 있습니다:

```swift
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"
```

상수와 변수의 이름은 '공백 문자 (whitespace)', '수학 기호 (mathematical symbols)', '화살표 (arrows)', '보조 사용자 영역의 유니코드 크기 값 (private-use Unicode scalar values)'[^private-use-Unicode-scalar-values], 또는 '선-그리기 (line-drawing)' 및 '상자-그리기 문자 (box-drawing characters)' 를 가질 수 없습니다. 이름을 숫자로 시작하는 것도 안되지만, 숫자가 다른 위치에 있는 건 괜찮습니다.

상수나 변수를 특정 타입으로 한번 선언했으면, 같은 이름을 선언에 다시 사용하거나, 다른 타입의 값을 저장하도록 바꿀 수 없습니다. 상수를 변수로 바꾸거나 변수를 상수로 바꾸는 것도 안됩니다.

> 상수나 변수에 '스위프트에서 예약한 키워드 (reserved Swift keyword)' 와 같은 이름을 쓰고싶으면, 이름으로 쓸 키워드를 '역따옴표 (backticks) (**`**) 기호'[^backticks] 로 감싸면 됩니다. 하지만 선택의 여지가 없는 것이 아니라면 키워드를 사용하지 않는 것이 좋습니다.

기존 변수의 값을 다른 값으로 바꿀 수 있는데 이 때 타입은 서로 호환 가능해야 합니다. 아래 예에서는, `friendlyWelcome` 의 값을 `"Hello!"` 에서 `"Bonjour!"` 로 바꿉니다:

```swift
var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"
// friendlyWelcome 은 이제 "Bonjour!" 입니다.
```

변수와 달리, 상수의 값은 설정하고 나면 바꿀 수 없습니다. 그렇게 하면 코드를 컴파일 할 때 에러가 발생합니다:

```swift
let languageName = "Swift"
languageName = "Swift++"
// 이것은 컴파일-시간에 에러가 발생합니다: languageName cannot be changed. (languageName 은 바꿀 수 없습니다.)
```

#### Prints Constants and Variables (상수와 변수 출력하기)

상수나 변수의 현재 값을 출력하려면 `print(_:separator:terminator:)` 함수를 사용하면 됩니다:

```swift
print(friendlyWelcome)
// "Bonjour!" 를 출력합니다.
```

`print(_:separator:terminator:)` 함수는 하나 이상의 값을 적절한 결과 형태로 출력하는 전역 함수입니다. 예를 들어, Xcode (엑스코드) 에서는, `print(_:separator:terminator:)` 함수가 그 결과를 Xcode 의 "console (콘솔)" 창에 출력합니다. `separator` 와 `terminator` 매개 변수는 기본 값을 갖고 있으므로, 이 함수를 호출할 때 생략할 수 있습니다. 기본적으로, 이 함수는 줄의 마지막에 '줄 바꿈 (line break)' 을 추가하여 출력합니다. 값을 출력할 때 끝에 줄 바꿈을 없애려면, 'terminator (종료자)'에 빈 문자열을 전달하면 됩니다-예를 들어, `print(someValue, terminator : "")` 처럼 하면 됩니다. '기본 값을 가지는 매개 변수' 에 대해서는 [Default Parameter Values](https://docs.swift.org/swift-book/LanguageGuide/Functions.html#ID169) 를 보기 바랍니다.


스위프트는 '_문자열 보간법 (string interpolation)_' 을 사용하여 긴 문자열 속에 상수나 변수 이름으로 '자리 표시 (placeholder)' 를 하고, 스위프트가 그 자리를 해당 상수나 변수의 현재 값으로 교체하도록 알려줄 수 있습니다. 이는 이름을 괄호로 감싼 다음, 시작 괄호 앞에 역-슬래시 (backslash) 로 'escape (벗어나게)'[^escape] 하면 됩니다:

```swift
print("The current value of friendlyWelcome is \(friendlyWelcome)")
// "The current value of friendlyWelcome is Bonjour!" 를 출력합니다.
```

> 문자열 보간법에서 사용할 수 있는 모든 '선택 사항들 (options)' 은 [String Interpolation (문자열 보간법)](https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html#ID292) 에서 설명합니다.

### Comments (주석)

'주석 (comments)' 을 사용하면 코드 내에 실행되지 않는 텍스트를 넣어서, 설명이나 기억을 되살리는 용도로 사용할 수 있습니다. 스위프트 컴파일러는 코드를 컴파일할 때 주석은 무시합니다.

스위프트의 주석은 C 언어의 주석과 매우 비슷합니다. 한-줄짜리 주석은 슬래쉬 두 개 (`//`) 로 시작합니다:

```swift
// This is a comment.
```

여러 줄짜리 주석은 슬래쉬 뒤에 별표가 있는 곳에서 시작하고 (`/*`) 별표 뒤에 슬래쉬가 있는 곳에서 끝납니다 (`*/` ):

```swift
/* This is also a comment
 but is written over multiple lines. */
```

C 언어의 여러 줄짜리 주석과 달리, 스위프트의 '여러 줄짜리 주석' 은 다른 여러 줄짜리 주석을 '품을 (nested)' 수 있습니다. 이렇게 'nested (품어진) 주석' 을 만들려면 일단 '여러 줄짜리 주석 블럭' 을 시작한 후 이 첫 번째 블럭 안에서 두 번째 '여러 줄짜리 주석을 시작하면 됩니다. 그리고 두 번째 블럭을 먼저 닫고, 첫 번째 블럭을 닫으면 됩니다:

```swift
/* This is the start of the first multiline comment.
 /* This is the second, nested multiline comment. */
 This is the end of the first multiline comment. */
```

'nested (품어진) 여러 줄짜리 주석' 을 사용하면 커다란 코드 블럭도 빠르고 쉽게 주석 처리할 수 있으며, 그 코드에 이미 여러 줄짜리 주석이 있더라도 상관없습니다.

### 세미콜론 (Semicolons)

다른 많은 언어와는 달리, 스위프트는 코드 문장 뒤에 세미콜론 (`;`) 을 쓸 필요가 없지만, 굳이 원한다면 써도 됩니다. 하지만, 여러 개의 분리된 문장을 한 줄에 쓰고 싶으면 세미콜론을 쓰는 _것이 (are)_ 필요합니다:

```swift
let cat = "🐱"; print(cat)
// "🐱" 를 출력합니다.
```

### Integers (정수)

정수는 `42` 와 `-23` 처럼 분수 성분이 없는 모든 수를 말합니다. [^integer] 정수 타입에는 부호가 있는 경우 (양수, 0, 또는 음수) 가 있고 없는 경우 (양수나 0) 가 있습니다.

Swift 는 부호가 있는 정수 타입과 없는 정수 타입을 8, 16, 32, 그리고 64 비트 형식으로 제공합니다. 이 정수 타입의 이름은 C 와 비슷한 규칙으로 지어졌는데, 8-비트 부호 없는 정수는 `UInt8` 타입이고, 32-비트 부호 있는 정수는 `Int32` 타입입니다 . [^naming] [^convention] Swift 의 모든 다른 타입들처럼 정수 타입은 대문자로 시작합니다.

#### Integer Bounds (정수의 경계)

각 정수 타입의 최소 값과 최대 값에 접근하려면 `min` 과 `max` 속성을 사용하면 됩니다:

```swift
let minValue = UInt8.min  // minValue 값은 0 이고 타입은 UInt8 입니다.
let maxValue = UInt8.max  // maxValue 값은 255 이고 타입은 UInt8 입니다.
```

이 속성의 값은 (위의 예에 있는 `UInt8` 처럼) 적당한 크기의 수 타입이므로 같은 타입의 다른 값들과 함께 수식에 사용될 수도 있습니다.

#### Int

대부분의 경우 코드에 사용할 정수의 크기를 직접 특정지을 필요가 없습니다. Swift 는 별도로 `Int` 라는 정수 타입을 제공하며 이는 현재 플랫폼의 내장 워드 크기와 같은 크기를 가지고 있습니다: [^native-word-size]

* 32-비트 플랫폼에서 `Int` 는 `Int32` 와 크기가 같습니다.
* 64-비트 플랫폼에서 `Int` 는 `Int64` 와 크기가 같습니다.

특정 크기의 정수 타입이 필요한 것이 아니라면, 정수 값으로 항상 `Int` 를 사용하도록 합니다. 이렇게 하면 코드의 일관성과 상호 이용성에 도움이 됩니다. [^consistency] [^interoperability] 32-비트 플랫폼일지라도 `Int` 는 `-2,147,483,648` 에서 `2,147,483,647` 사이의 값을 저장할 수 있으며 이는 대다수의 정수 범위에서 충분히 큰 편입니다.

#### UInt

Swift 는 부호 없는 정수 타입으로 `UInt` 도 제공하는데, 이것도 현재 플랫폼의 내장 워드와 같은 크기를 가지고 있습니다:

* 32-비트 플랫폼에서 `UInt` 는 `UInt32` 와 크기가 같습니다.
* 64-비트 플랫폼에서 `UInt` 는 `UInt64` 와 크기가 같습니다.

> `UInt`는 플랫폼의 기본 워드와 같은 크기의 부호 없는 정수 타입이 특별히 필요한 경우만 사용하도록 합니다. 이런 특별한 경우가 아니라면 저장되는 값이 음수가 아니더라도 `Int` 를 사용하는 것이 더 좋습니다. 정수 값으로 일관되게 `Int` 를 사용하면 상호 이용성에 도움이 되고, 다른 수 타입으로 타입을 바꿀 필요가 없으며, [타입 안전 검사기와 타입 추론 (Type Safety and Type Inference)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID322) 에 설명된 것 처럼 정수 타입 추론에 들어맞게 됩니다.

### Floating-Point Numbers (부동-소수점 수)

부동 소수점 수는 `3.14159`, `0.1` 와 `-273.15` 처럼 분수 요소가 있는 수입니다.

부동 소수점 타입은 정수 타입보다 훨씬 광범위한 값을 표현할 수 있으며 `Int` 에 저장할 수 있는 것보다 더 크거나 작은 수를 저장할 수 있습니다. Swift 는 두 가지의 부호 있는 부동 소수점 수 타입을 제공합니다:

* `Double` 은 64-비트 부동 소수점 수를 나타냅니다.
* `Float` 은 32-비트 부동 소수점 수를 나타냅니다.

> `Double` 은 적어도 소수점 이하 15 자리수의 정밀도를 가지고 있는 반면 `Float` 의 정밀도는 소수점 이하 6자리일 정도로 작습니다. 사용하고 있는 부동 소수점 타입이 적절한지는 코드에서 사용할 값의 특성과 범위에 달린 문제입니다. 두 타입이 모두 적당한 상황이라면 `Double` 을 쓰는 것이 더 낫습니다.

### Type Safety and Type Inference (타입 안전기와 타입 추론기)

Swift 는 타입-안전 언어입니다. 타입 안전 언어는 코드에서 사용하는 값의 타입을 분명히 할 것을 권장합니다. 코드의 일부분이 `String` 을 예상하고 있다면 실수로 `Int` 를 전달할 수 없습니다.

Swift 는 타입에 안전하므로 코드를 컴파일할 때 타입 검사를 수행해서 일치하지 않는 타입이 있으면 에러로 알려줍니다. 이렇게 함으로써 개발 과정에서 최대한 빠른 시간에 에러를 포착하고 고칠 수 있도록 해줍니다. [^mismatch]

타입-검사는 다른 타입의 값들을 사용할 때 에러를 피하도록 해 줍니다. 하지만 이것이 상수와 변수를 선언할 때 항상 타입을 지정해줘야 함을 뜻하는 것은 아닙니다. 필요한 값의 타입을 지정하지 않으면 Swift 는 타입 추론을 사용해서 적절한 타입을 찾아냅니다. [^appropriate] 타입 추론은 코드를 컴파일할 때 자동으로 컴파일러가 특정 표현식의 타입을 찾을 수 있도록 해주는데,  이것은 단순히 제공된 값을 검사하는 것으로 이루어 집니다.

타입 추론으로 인하여 Swift 는 C 나 Objective-C 같은 언어보다 타입 선언을 훨씬 더 적게 해도 됩니다. 상수와 변수는 여전히 직접 쳐줘야 하지만, 타입을 지정하는 대부분의 작업은 자동으로 이루어집니다.

타입 추론은 초기 값을 가지고 상수와 변수를 선언할 때 특히 더 유용합니다. 이것은 선언할 때 글자표현 (literals) 을 상수나 변수에 할당하는 것을 말합니다. [^literal] (리터럴 값은 소스 코드에 그대로 나타나는 값을 말하며 아래 예에서 `42` 와 `3.14159` 같은 것입니다.)

예를 들어 `42` 라는 리터럴 값을 무슨 타입인지 말하지 않고 새로운 상수에 할당하면 Swift 는 상수가 `Int` 가 되길 원한다고 추론하는데, 이는 정수 처럼 보이는 수로 초기화를 했기 때문입니다:

```swift
let meaningOfLife = 42
// meaningOfLife 는 Int 타입으로 추론됩니다.
```

마찬가지로 부동 소수점 리터럴에 타입을 지정하지 않으면 Swift 는 `Double` 을 만들고 싶어 한다고 추론합니다:

```swift
let pi = 3.14159
// pi 는 Double 타입으로 추론됩니다.
```

Swift 는 부동 소수점 수의 타입을 추론할 때 (`Float` 이 아니라) 항상 `Double` 을 선택합니다.

수식에서 정수와 부동 소수점 리터럴을 같이 사용하면 문맥을 통해서 `Double` 타입으로 추론합니다: [^expression] [^context]

```swift
let anotherPi = 3 + 0.14159
// anotherPi 역시 Double 타입으로 추론됩니다.
```

리터럴 값인 `3` 은 직접 타입을 지정한 것도 아니고 그자체가 타입인 것도 아니므로 적절한 출력 타입은 `Double` 로 추론되는데 이는 덧셈의 일부에 부동 소수점 리터럴이 있기 때문입니다.

### Numeric Literals (수치 글자표현)

정수 리터럴은 다음과 같은 방법으로 작성할 수 있습니다:

* 아무런 접두사가 없는 10진수
* `0b` 접두사를 붙인 2진수
* `0o` 접두사를 붙인 8진수
* `0x` 접두사를 붙인 16진수

아래에 있는 모든 리터럴은 십진수로 `17`입니다:

```swift
let decimalInteger = 17
let binaryInteger = 0b10001       // 17 의 2진 표기법
let octalInteger = 0o21           // 17 의 8진 표기법
let hexadecimalInteger = 0x11     // 17 의 16진 표기법
```

부동 소수점 리터럴은 (아무런 접두사가 없는) 10진수이거나 (`0x` 접두사가 있는) 16진수 일 수 있습니다. 소수점 양쪽 모두에 수 (또는 16진수)가 있어야 합니다. 10진 부동 소수점 수에는 지수가 있을 수 있는데 대/소문자 `e` 로 나타냅니다; 16진 부동 소수점 수는 반드시 지수를 가져야 하며 대/소문자 `p` 로 나타냅니다.

`exp` 라는 지수부를 가지고 있는 10진수는 가수부에 10<sup>exp</sup> 를 곱해줍니다: [^base-number]

* 1.25e2 는 1.25 x 10<sup>2</sup> 를 뜻하며 125.0 이기도 합니다.
* 1.25e-2 는 1.25 x 10<sup>-2</sup>를 뜻하며 0.0125 이기도 합니다.

`exp` 라는 지수부를 가지고 있는 16진수는 가수부에 2<sup>exp</sup> 를 곱해줍니다:

* 0xFp2 는 15 x 2<sup>2</sup> 를 뜻하며 60.0 이기도 합니다.
* 0xFp-2 는 15 x 2<sup>-2</sup> 를 뜻하며 3.75 이기도 합니다.

다음의 모든 부동 소수점 리터럴의 10진 값은 `12.1875` 입니다:

```swift
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0
```

수치 값 리터럴은 보다 읽기 쉽도록 별도 서식을 가질 수 있습니다. [^extra-formatting] 정수와 부동 소수점 수 모두 별도의 0으로 채워질 수 있으며 가독성을 높이기 위해 밑줄 기호를 가질 수 있습니다. [^extra] [^readability] 이 서식 타입 어느 것도 리터럴의 원래 값에는 영향을 주지 않습니다: [^underlying]

```swift
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
```

### Numeric Type Conversion (수치 타입 변환)

모든 일반 용도에서 그리고 심지어는 양수로만 쓰는 경우에도 정수 상수나 변수에는 항상 `Int` 타입만 쓰도록 합니다. 모든 상황에서 기본 정수 타입만 쓴다는 것은 코드에 있는 정수 상수와 변수가 언제든지 상호 호환가능함을 의미하며 정수 리터럴 값의 타입 추론과도 일치함을 의미합니다.

다른 정수 타입은 특별하게 필요한 경우에만 사용하도록 하는데 이는 외부 소스에서 직접 크기가 결정된 데이터라던가 성능이나 메모리 사용량 문제 아니면 다른 최적화가 필요한 경우 등에 해당합니다. 이런 상황에서는 직접 크기가 결정된 타입을 사용하는 것이 우연하게 값이 넘치는 문제를 잡아내는데 도움을 주고 사용하는 데이터의 특성을 저절로 문서화할 수 있도록 해 줍니다.

#### Integer Conversion (정수 변환)

정수 상수나 변수에 저장될 수 있는 수의 범위는 각 수치 타입마다 다릅니다. `Int8` 상수나 변수는 `-128` 에서 `127` 사이의 수를 저장할 수 있는 반면에, `UInt8` 상수나 변수는 `0` 에서 `255` 사이의 수를 저장할 수 있습니다. 크기가 지정된 정수 타입의 상수나 변수 범위에 있지 않는 수는 컴파일할 때 에러로 보고됩니다:

```swift
let cannotBeNegative: UInt8 = -1
// UInt8 는 음수를 저장할 수 없으므로 에러를 보고합니다.
let tooBig: Int8 = Int8.max + 1
// Int8 는 그것의 최대 값을 넘어서는 수를 저장할 수 없으므로 에러를 보고합니다.
```

각 정수 타입은 다른 범위의 값을 저장할 수 있으므로 상황에 따라 수치 타입의 형변환을 직접 선택해 줘야 합니다. 이러한 직접 선택 (opt-in) 접근 방법은 잠재 형변환 에러를 방지하고 타입 변환 의도를 분명하게 드러내 줍니다. [^opt-in approach]

하나의 특정 수치 타입을 다른 타입으로 변환하려면 기존 값을 써서 원하는 수치 타입을 초기화합니다. 아래에 있는 예제에서 `twoThousand` 상수는 `UInt16` 타입이고, `one` 상수는 `UInt8` 타입입니다. 이 둘은 직접 더할 수 없는데, 왜냐면 같은 타입이 아니기 때문입니다. 대신에 이 예제에서는 `UInt16(one)` 을 호출하여 새로운 `UInt16` 값을 만들고, `one` 값으로 초기화한 다음, 원래 값 대신 이 값을 사용합니다:

```swift
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
```

이제 양쪽 항이 모두 `UInt16` 타입이므로 덧셈이 가능합니다. 결과를 담은 상수 (`twoThousandAndOne`) 는 `UInt16` 타입으로 추론되는데  두 개의 `UInt16` 값의 합이기 때문입니다.

`SomeType(ofInitialValue)` 는 Swift 에서 타입의 초기자를 호출하고 초기 값을 전달하는 기본 방법입니다. 속을 들여다 보면, `UInt16` 타입은 `UInt8` 값을 받아들일 수 있는 초기자를 가지고 있어서, 이 초기자로 기존의 `UInt8` 값에서 새로운 `UInt16` 값을 만듭니다. 즉 여기서 아무 타입이나 전달할 수는 없고 — `UInt16` 의 초기자에 넘길 수 있는 타입만 가능합니다. 기존 타입의 초기자를 확장해서 (직접 정의한 타입도 포함하여) 새로운 타입을 받아들이게 하는 방법은 [확장 (Extensions) 기능](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html#//apple_ref/doc/uid/TP40014097-CH24-ID151) 에서 다룹니다.

#### Integer and Floating-Point Conversion (정수와 부동-소수점 수 변환)

정수와 부동 소수점 수치 타입 사이의 형변환은 반드시 직접 드러내놓고 해야 합니다:

```swift
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi 는 3.14159 과 같고 Double 타입으로 추론됩니다.
```

위에서는 상수 `three` 의 값으로 `Double` 타입의 새 값을 만들어서 덧셈의 양쪽 항이 같은 타입이 되게 만들었습니다. 이렇게 형변환을 하지 않았다면 덧셈을 할 수 없었을 것입니다.

부동 소수점 수에서 정수로 형변환 하는 것도 반드시 직접 해야 합니다. 정수 타입은 `Double` 이나 `Float` 값으로 초기화할 수 있습니다:

```swift
let integerPi = Int(pi)
// integerPi 는 3과 같고 Int 타입으로 추론됩니다.
```

이렇게 부동 소수점 수로 새로운 정수 값을 초기화하는 방식은 항상 수를 잘라냅니다. 이것은 `4.75` 는 `4` 가 되고 `-3.9` 는 `-3` 이 됨을 의미합니다.

> 수치 상수와 변수를 결합하는 규칙은 수치 리터럴 끼리의 규칙과는 다릅니다. 리터럴 값 `3` 은 리터럴 값 `0.14159` 와 직접 더해지는데, 왜냐면 수치 리터럴은 타입이 직접 지정된 것도 아니고 그 자체가 타입인 것도 아니기 때문입니다. 이들의 타입은 컴파일러가 값을 평가하는 순간에만 추론됩니다.

### Type Aliases (타입 별칭)

타입의 별칭은 기존 타입에 대한 대체 이름을 정의합니다. [^aliase] 타입 별칭을 정의하려면 `typealias` 키워드를 사용합니다.

타입 별칭은 문맥상 더 적절한 이름으로 기존 타입을 참조하고자 할 때 유용합니다, 가령 외부 소스에 있는 특정 크기의 데이터를 사용할 경우에 유용합니다: [^contextually]

```swift
typealias AudioSample = UInt16
```

타입 별칭을 한 번 정의하고 나면, 원래 이름을 사용할 수 있는 곳이면 어디든 별칭을 사용할 수 있습니다:

```swift
var maxAmplitudeFound = AudioSample.min
// maxAmplitudeFound 는 이제 0 입니다.
```

여기 보면 `AudioSample` 는 `UInt16` 에 대한 별칭으로 정의되었습니다. 별칭이므로 `AudioSample.min` 를 호출하는 것은 실제로 `UInt16.min` 를 호출하는 것을 의미하며, `maxAmplitudeFound` 변수에  초기 값으로 `0` 을 넘기게 됩니다.

### Booleans (불린; 논리 값)

Swift 에 있는 기본 불 (Boolean) 타입은 `Bool` 입니다. 불 (Boolean) 값은 참과 거짓만이 가능하기 때문에 논리 값이라고 합니다. Swift 는 `true` 와 `false` 라는 두 개의 불 상수 값을 제공합니다:

```swift
let orangesAreOrange = true
let turnipsAreDelicious = false
```

`orangesAreOrange` 와 `turnipsAreDelicious` 의 타입은 `Bool` 로 추론되는데 이는 이들이 불 리터럴 값으로 초기화되었기 때문입니다. 앞서 살펴본 `Int` 와 `Double` 와 같이, 상수나 변수를 만들면서 바로 `true` 나 `false` 값을 설정하면, 상수나 변수를 `Bool` 이라고 선언할 필요가 없습니다.  타입 추론은 타입이 알려진 다른 값으로 상수나 변수를 초기화할 때 Swift 코드를 더 간결하고 읽기 편하게 만들어 줍니다. [^readable]  

불 (Boolean) 값은 `if` 문 같은 조건 구문을 사용할 때 특히 더 유용합니다:

```swift
if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}
// "Eww, turnips are horrible." 를 출력합니다.
```

`if` 문 같은 조건 구문에 대해서는 [흐름 제어(Control Flow)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html#//apple_ref/doc/uid/TP40014097-CH9-ID120) 에서 더 자세히 다룹니다. [^cover]

Swift 의 타입 안전 검사기는 불이 아닌 값이 `Bool` 을 대신하는 것을 방지합니다. 아래에 보인 예는 컴파일-시간 에러를 보고합니다:

```swift
let i = 1
if i {
    // 이 예제는 컴파일되지 않고 에러를 보고합니다.
}
```

하지만 아래 예제에 보인 대안은 유효합니다:

```swift
let i = 1
if i == 1 {
    // 이 예제는 컴파일에 성공합니다.
}
```

`i == 1` 비교 연산의 결과는 `Bool` 타입이므로 두번째 예는 타입-검사를 통과합니다. `i == 1` 과 같은 비교 연산은 [기본 연산자 (Basic Operators)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/BasicOperators.html#//apple_ref/doc/uid/TP40014097-CH6-ID60) 에서 논의합니다.

Swift 에 있는 다른 타입 검사기의 예들과 마찬가지로 이러한 접근 방식은 실수로 인한 에러를 방지하고 특정 코드 영역의 의도가 항상 명확히 드러나도록 만들어 줍니다.

### Tuples (튜플; 짝)

튜플은 여러 개의 값을 그룹지어서 단일 합성 값으로 만듭니다. 튜플안에는 어떤 타입의 값이라도 넣을 수 있으며서로 같은 타입일 필요도 없습니다.

다음의 예제에서 `(404, "Not Found")` 는 HTTP 상태 코드를 나타내는 튜플입니다. HTTP 상태 코드는 웹 페이지를 요청할 때마다 웹 서버가 반환하는 특수한 값입니다. `404 Not Found` 라는 상태 코드는 요청한 웹페이지가 없는 경우에 반환됩니다.

```swift
let http404Error = (404, "Not Found")
// http404Error is of type (Int, String), and equals (404, "Not Found")
```

`(404, "Not Found")` 라는 튜플은 `Int` 와 `String` 을 그룹지어서 두 개의 별개의 값을 HTTP 상태코드로 제공할 수 있게 합니다: 수 하나와 사람이 읽을 수 있는 설명 한 가지가 그것입니다. 이는 “`(Int, String)` 타입으로된 튜플” 이라고 묘사할 수 있습니다.

튜플을 만들 때 타입의 순서는 아무래도 상관이 없으며 원하는 만큼 많은 다른 종류의 타입을 넣어도 됩니다. `(Int, Int, Int)` 타입의 튜플을 만들던 아니면 `(String, Bool)` 을 만들던 이것도 아니면 정말로 원하는 대로 아무 순서로 된 것을 만들던 어떠한 제한도 없습니다.

튜플의 내용은 별개의 상수와 변수로 분해할 수 있으며 이렇게 해서 평소 사용하던 방식대로 접근할 수도 있습니다: [^decompose]

```swift
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// Prints "The status code is 404"
print("The status message is \(statusMessage)")
// Prints "The status message is Not Found"
```

튜플의 값 중에서 일부만 필요할 경우 튜플을 분해할 때 무시할 부분에 밑줄 (`_`) 기호를 사용하면 됩니다:

```swift
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
// Prints "The status code is 404"
```

그 대신에 튜플에 있는 각 개별 요소의 값에 접근하고 싶으면 0 부터 시작하는 인덱스 값을 사용하면 됩니다:

```swift
print("The status code is \(http404Error.0)")
// Prints "The status code is 404"
print("The status message is \(http404Error.1)")
// Prints "The status message is Not Found"
```

튜플을 정의할 때 튜플에 있는 개별 요소에 이름을 줄 수도 있습니다:

```swift
let http200Status = (statusCode: 200, description: "OK")
```

튜플의 요소에 이름을 지정하면 요소의 이름을 사용하여 그 요소의 값에 접근할 수 있습니다:

```swift
print("The status code is \(http200Status.statusCode)")
// Prints "The status code is 200"
print("The status message is \(http200Status.description)")
// Prints "The status message is OK"
```

튜플은 특히 함수의 반환 값으로 유용합니다. 웹 페이지를 검색하려고 하는 함수는 페이지 검색이 성공했는지 실패했는지 나타내기 위해 `(Int, String)` 튜플 타입으로 반환할 수도 있습니다. 두 개의 다른 타입으로 된 두 개의 값을 가지는 튜플로 반환하면, 이 함수는 한 가지 타입으로 된 한 개의 값만 반환할 때보다 더 유용한 정보를 제공할 수 있습니다. 더 많은 정보는 [여러 반환 값을 가지는 함수 (Functions with Multiple Return Values)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html#//apple_ref/doc/uid/TP40014097-CH10-ID164) 에서 볼 수 있습니다.

> 튜플은 관련 있는 값들을 임시로 그룹지을 때 유용합니다. 복잡한 데이터 구조를 만드는데는 알맞지 않습니다. [^suite] 만약 데이터 구조가 임시 영역을 넘어서 유지되어야 할 경우 튜플 보다는 클래스 (객체 타입) 이나 구조 타입으로 모델을 만들도록 합니다. 더 많은 정보는 [클래스와 구조 타입 (Classes and Structures)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-ID82) 에서 볼 수 있습니다.

### Optionals (옵셔널; 선택적 타입)

옵셔널은 값이 아예 없을 수도 있는 상황에서 사용합니다. 옵셔널은 두 가지 가능성을 나타냅니다: 값이 있어서 옵셔널을 풀고 그 값에 접근할 수 있거나 아니면 값 자체가 아예 없는 경우입니다.

> 옵셔널이라는 개념은 C 나 Objective-C 에는 없는 것입니다. [^concept] Objective-C 에서 그나마 가장 가까운 것은 객체를 반환하도록 하는 메소드가 `nil` 을 반환할 수 있다는 정도인데, 여기서 `nil` 은 “유효한 객체가 없음” 을 의미합니다. 하지만 이것은 객체에서만 동작하며 — 구조 타입이나 기본 C 타입들 또는 열거 타입의 값에서는 동작하지 않습니다. 이들 타입의 경우  Objective-C 메소드에서 보통 (`NSNotFound` 같은) 특별한 값을 반환하는 것으로 값이 없는 상태를 나타냅니다. [^typically] 이런 접근 방식은 메소드를 호출하는 쪽에서 테스트를 위한 특별한 값이 있는 지도 알아야 하고 그 값을 검사해야하는 것도 알고 있다고 가정합니다. Swift 의 옵셔널은 모든 타입에 대해서 값이 없는 상태를 나타낼 수 있고 특별한 상수도 따로 필요하지 않습니다.

여기에 옵셔널을 써서 어떻게 값이 없는 상태를 다룰 수 있는지를 보이도록 합니다. [^cope] Swift 의 `Int` 타입에는 `String` 값을 받아서 `Int` 값으로 형변환하는 초기자가 있습니다. 하지만 모든 문자열을 정수로 형변환할 수는 없습니다. 문자열 `"123"` 은 수치 값 `123` 으로 형변환 할 수 있지만 문자열 `"hello, world"` 는 형변환을 할 수치 값이 딱히 없습니다.

아래의 예제는 초기자를 사용하여 `String` 을 `Int` 로 변환하고 있습니다:

```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber 는 "Int?" 타입 또는 "optional Int" 로 추론됩니다.
```

초기자는 실패할 수도 있기 때문에 `Int` 가 아닌 옵셔널 `Int` 를 반환합니다. 옵셔널 `Int` 는 `Int` 가 아니라 `Int?` 라고 씁니다. 물음표는 그 값이 옵셔널을 담고 있음을 표시하며, `Int` 값을 가지고 있거나 아니면 값 자체가 아예 없음을 의미합니다. (그 외의 다른 것은 아예 안되므로 `Bool` 값이나  `String` 값 같은 것을 담을 수는 없습니다. 오직 `Int` 이거나 아니면 값이 아예 없는 것입니다.)

#### nil

옵셔널 변수에 값이 없는 상태를 설정하려면 특별한 값인 `nil` 을 할당합니다: [^nil]

```swift
var serverResponseCode: Int? = 404
// serverResponseCode contains an actual Int value of 404
serverResponseCode = nil
// serverResponseCode now contains no value
```

> `nil` 은 옵셔널이 아닌 상수 및 변수와는 사용할 수 없습니다. 코드에 있는 상수나 변수가 특정 상황에서 값이 없는 상태를 나타내야 할 경우에는 항상 적당한 타입에 옵셔널 값으로 선언하도록 합니다.

옵셔널 변수를 정의할 때 기본 값을 제공하지 않으면 그 변수는 자동으로 `nil` 로 설정됩니다:

```swift
var surveyAnswer: String?
// surveyAnswer is automatically set to nil
```

> Swift 의 `nil` 은 Objective-C 의 `nil` 과 같은 것이 아닙니다. Objective-C 에서의 `nil` 은 존재하지 않는 객체에 대한 포인터입니다. Swift 에서는 `nil` 은 포인터가 아닙니다 — 이것은 특정 타입의 값이 없음을 나타내는 상태입니다. [^swift-nil] 객체 타입 뿐만 아니라 모든 타입의 옵셔널에 `nil` 을 설정할 수 있습니다.

#### If Statements and Forced Unwrapping (If 구문과 강제 풀기)

`if` 문을 사용하면 옵셔널을 `nil` 과 비교함으로써 옵셔널이 값을 가지고 있는 지를 알아낼 수 있습니다. 이 비교 연산은 “같음” 연산자 (`==`) 나 “같지 않음” 연산자 (`!=`) 를 써서 수행합니다. [^equal-to-not-equal-to]

옵셔널이 값을 가지고 있으면 `nil` 과는 “같지 않음” 이 됩니다:

```swift
if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}
// Prints "convertedNumber contains some integer value."
```

옵셔널이 값을 가지고 있다고 확신하는 경우에는 옵셔널 이름의 끝에 느낌표 (`!`) 를 붙여서 원래의 값에 접근할 수 있습니다. 느낌표는 사실상 다음과 같이 말하는 것입니다. “이 옵셔널은 확실히 값을 가지고 있어, 그러니 그것을 사용해.” 이것을 가지고 옵셔널 값을 강제로 푼다고 합니다:

```swift
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}
// Prints "convertedNumber has an integer value of 123."
```

`if` 문에 대해 더 알고 싶으면 [흐름 제어(Control Flow)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html#//apple_ref/doc/uid/TP40014097-CH9-ID120) 를 보면 됩니다.

> `!` 를 사용해서 존재하지 않는 옵셔널 값에 접근하려고 하면 실행 시간에 에러가 발생합니다. [^runtime] 항상 먼저 옵셔널이 `nil`이 아닌 값을 가지고 있는지 확인한 다음에 `!` 를 사용해서 값을 강제로 풀어야 합니다.

#### Optional Binding (옵셔널 바인딩; 선택적 연결)

옵셔널 연결 (optional binding) 구문을 사용하면 옵셔널이 값을 가지고 있는지 확인하고 있으면 그 값을 임시 상수나 변수에서 쓸 수 있도록 만들 수 있습니다. [^binding] 옵셔널 연결 구문은 `if` 및 `while` 문과 함께 사용해서 단 한번의 명령으로 옵셔널 안에 있는 값을 검사하고 그 값을 상수나 변수로 추출할 수 있습니다. `if` 문과 `while` 문에 대해서는 [흐름 제어(Control Flow)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html#//apple_ref/doc/uid/TP40014097-CH9-ID120) 에서 더 자세하게 설명하고 있습니다.

`if` 문에서 옵셔널 연결 구문을 사용하는 방법은 다음과 같습니다:

```
if let constantName = someOptional {
    statements
}
```

[옵셔널 (Optionals)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID330) 에 있는 `possibleNumber` 예제를 강제 풀기 (forced unwrapping) 방식이 아니라 옵셔널 연결 (optional binding) 구문을 사용해서 다시 작성하면 다음과 같습니다:

```swift
if let actualNumber = Int(possibleNumber) {
    print("\"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("\"\(possibleNumber)\" could not be converted to an integer")
}
// Prints ""123" has an integer value of 123"
```

이 코드는 다음과 같은 뜻을 가지고 있습니다:

“`Int(possibleNumber)` 가 반환하는 옵셔널 `Int` 가 값을 가지고 있으면 옵셔널이 갖고 있는 값을 `actualNumber` 라는 새로운 상수에 설정합니다.”

형변환이 성공하면 `actualNumber` 상수는 `if` 구문의 첫번째 괄호 영역에서 사용할 수 있게 됩니다. 이 값은 이미 옵셔널이 가진 값으로 초기화가 되었으므로 `!` 접미사를 써서 접근할 필요가 없습니다. 이 예제에서는 `actualNumber` 는 단순히 형변환 결과를 출력하는데 사용하고 있습니다.

옵셔널 연결 구문에는 상수와 변수 둘다 사용가능합니다. `if` 구문의 첫번째 괄호 영역에서 `actualNumber` 값을 조절하고 싶으면, `if var actualNumber` 라고 고쳐서 옵셔널이 갖고 있는 값을 상수가 아니라 변수에 담도록 만들어야 합니다. [^manipulate]

하나의 `if` 문에는 원하는 만큼 많은 옵셔널 연결 구문과 불 조건문을 넣을 수 있으며, 이 때 쉼표로 서로를 구분합니다. 옵셔널 연결 구문에 있는 값이 하나라도 `nil` 이거나 불 조건문의 평가 값이 하나라도 `false` 라면, `if` 문 전체의 조건이 `false` 가 됩니다. 다음에 나타낸 두 개의 `if` 문은 서로 동일한 의미입니다:

```swift
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
// Prints "4 < 42 < 100"

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}
// Prints "4 < 42 < 100"
```

> `if` 문 안에 있는 옵셔널 연결 구문에서 만들어진 상수와 변수는 `if` 구문의 본체 영역 안에서만 사용할 수 있습니다. 이와는 반대로 `guard` 문에서 만들어진 변수는 `guard` 이후의 영역에서도 사용이 가능한데, 이 내용은 [조기 종료 (Early Exit)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html#//apple_ref/doc/uid/TP40014097-CH9-ID525) 에서 설명합니다. [^early-exit]

#### Implicitly Unwrapped Optionals (암묵적으로 풀리는 옵셔널; 저절로 풀리는 선택형 타입)

위에서 설명했듯이 옵셔널은 상수나 변수가 “값이 없음” 일 수도 있음을 나타냅니다. 옵셔널은 `if` 문으로 값이 있는지 검사할 수도 있고, 옵셔널 연결 구문으로 값이 있으면 풀어서 옵셔널 값에 접근할 수도 있습니다.

때에 따라서 프로그램의 구조상 옵셔널 변수가 처음 설정되고 나면, 항상 값이 있음을 알 수 있는 경우가 있습니다. 이러한 경우에는 접근할 때마다 값을 풀고 검사할 필요가 없는 옵셔널을 사용하는 것이 편리한데, 언제나 값이 있다고 가정해도 안전하기 때문입니다.

이러한 종류의 옵셔널을 저절로 풀리는 옵셔널이라고 정의합니다. [^implicitly-unwrapped-optional] 저절로 풀리는 옵셔널을 만들려면 옵셔널로 만들 타입 뒤에 물음표 (`String?`) 대신 느낌표 (`String!`) 를 붙여주면 됩니다.

저절로 풀리는 옵셔널은 옵셔널 값이 처음 정의된 직후에 존재하는 것이 확인되고, 이후의 모든 시점에서 존재한다고 확실히 가정할 수 있는 경우, 유용하게 사용할 수 있습니다. Swift 에서 저절로 풀리는 옵셔널이 주로 사용되는 곳은 클래스의 초기화에서인데, 이에 대해서는 [소유자가 없는 참조 및 저절로 풀리는 옵셔널 속성 (Unowned References and Implicitly Unwrapped Optional Properties)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID55) 에서 설명합니다.

저절로 풀리는 옵셔널은 원래는 보통의 옵셔널이지만, 마치 옵셔널이 아닌 값처럼 쓸 수 있어서 옵셔널 값을 풀 필요없이 값에 접근할 수 있습니다. 다음의 예제는 옵셔널 문자열과 저절로 풀리는 옵셔널 문자열이 `String` 타입으로 지정한 값에 접근할 때의 동작 방식이 어떻게 다른지 보여줍니다:

```swift
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation mark

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation mark
```

저절로 풀리는 옵셔널은 사용할 때마다 자동으로 풀리도록 그 옵셔널에 권한을 준 것으로 생각해도 됩니다. 옵셔널 타입을 선언할 때 타입 뒤에 느낌표를 붙이면 접근할 때만다 옵셔널 이름 뒤에 느낌표를 붙이지 않아도 됩니다.

> 저절로 풀리리 옵셔널이 `nil` 인데 이 값에 접근하려고 하면 실행 시간 에러가 발생합니다. 이 결과는 보통의 옵셔널이 값을 가지고 있지 않은데 느낌표를 붙였을 때와 정확히 같은 결과입니다.

저절로 풀리는 옵셔널을 마치 보통의 옵셔널처럼 사용할 수도 있는데 값이 있는지 검사하려면 다음처럼 하면 됩니다:

```swift
if assumedString != nil {
    print(assumedString)
}
// Prints "An implicitly unwrapped optional string."
```

저절로 풀리는 옵셔널을 옵셔널 연결 구문과 함께 사용할 수도 있으며 하나의 구문으로 값을 검사하고 풀 수 있습니다.:

```swift
if let definiteString = assumedString {
    print(definiteString)
}
// Prints "An implicitly unwrapped optional string."
```

> 나중에라도 변수가 `nil`이 될 가능성이 있는 경우 저절로 풀리는 옵셔널을 사용하지 않도록 합니다. 변수의 생명 주기 동안에 `nil` 값인지 검사할 필요가 있으면 항상 보통의 옵셔널 타입을 사용하도록 합니다.

### Error Handling (오류 처리)

에러 처리 구문을 사용하면 프로그램 실행 중에 마주칠 수 있는 에러 조건들에 대응을 할 수 있습니다.

옵셔널은 값의 존재 유무를 사용해서 함수가 성공했는지 실패했는지를 알릴수 있다면, 이와는 반대로 에러 처리 구문은 실패의 근원이 되는 실마리를 판별하게 하고 필요하다면 에러를 프로그램의 다른 부분으로 전파합니다. [^underlying]

함수가 에러 조건을 만나게 되면 에러를 던집니다. 그 함수를 호출한 쪽에서는 에러를 포착해서 적절하게 응답 할 수 있습니다.

```swift
func canThrowAnError() throws {
    // this function may or may not throw an error
}
```

함수가 에러를 던질 수 있음을 나타내려면 선언 부분에 `throws` 키워드를 넣어주면 됩니다. 에러를 던질 수 있는 함수를 호출할 때는 표현 구문 앞에 `try` 키워드를 붙입니다.

Swift 는 자동으로 현재 범위 밖으로 에러를 전파하는데 이 과정은 `catch` 절에서 처리가 될 때까지 계속됩니다.

```swift
do {
    try canThrowAnError()
    // no error was thrown
} catch {
    // an error was thrown
}
```

`do` 구문은 에러를 하나 이상의 `catch` 절에 전파할 수 있는 새로운 포함 범위를 만듭니다.

다음은 다양한 에러 조건에 응답하기 위해 에러 처리를 사용하는 예제입니다:

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

위의 예제에서 `makeASandwich()` 함수는 깨끗한 접시가 없거나 재료가 빠진 경우 에러를 던집니다. `makeASandwich()` 가 에러를 던질 수 있기 때문에 함수 호출을 `try` 표현식에 넣습니다. 함수 호출을 `do` 구문으로 감싸면, 던져지는 모든 에러가 주어진 `catch` 절로 전파됩니다.

아무런 에러도 던져지지 않으면 `eatASandwich()` 함수가 호출됩니다. 던져진 에러가 `SandwichError.outOfCleanDishes` 와 일치하는 경우에는 `washDishes()` 함수가 호출됩니다. 던져진 함수가 `SandwichError.missingIngredients` 와 일치하면 `buyGroceries(_:)` 함수가 호출되는데, 이 때 `catch` 패턴으로 붙잡힌 관련 `[String]` 값을 가지고 호출합니다. [^captured]

에러를 던지고, 포착하고, 전파하는 것에 대해서는 [에러 처리 (Error Handling) 구문](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html#//apple_ref/doc/uid/TP40014097-CH42-ID508) 에서 아주 상세하게 다룹니다.

### Assertions and Preconditinos (단언과 선행 조건)

어떤 경우에는 특정 조건이 만족이 안될 경우 코드의 실행을 계속할 수 없는 경우가 있습니다. 이러한 상황일 때 단언 (Assertions) 구문을 써서 코드 실행을 종료하고 값이 없거나 잘못된 원인을 고칠 수 있는 기회를 제공할 수 있습니다. [^assertion] [^debug]

#### Debugging with Assertions (단언문으로 디버깅하기)

단언 (assertion) 구문은 불 (Boolean) 조건이 확실히 `true` 로 평가되는지 실행 시간에 검사합니다. 문자 그대로 단언 구문은 조건이 참이라고 “단언” 합니다. 단언 구문은 어떤 코드를 실행하기 전에 필수 조건들을 만족하는지 확인하는 용도로 사용합니다. 조건이 `true` 로 평가되면 코드가 평소대로 계속 실행되지만, 조건이 `false` 로 평가되면 코드 실행이 멈추고 앱이 종료됩니다.

Xcode 에서 앱을 빌드하고 실행하는 경우 처럼 디버그 환경에서 실행하는 도중에 코드의 단언 구문이 작동하면, 정확하게 어디에서 상태가 잘못되었는지 볼 수 있고 단언 구문이 작동할 때의 앱 상태에 대해서 질의 (query) 를 할 수도 있습니다. [^query] 단언 구문은 또한 기본으로 내장된 특성을 이용하여 유용한 디버그 메시지를 제공하게 할 수도 있습니다.

단언 구문을 작성하려면 Swift 표준 라이브러러의 전역 함수인 `assert(_:_:file:line:)` 를 호출합니다. 이 함수에 `true` 나 `false` 로 평가할 수 있는 표현식과 조건의 결과가 `false` 이면 화면에 보여줄 메시지를 전달합니다:

```swift
let age = -3
assert(age >= 0, "A person's age cannot be less than zero")
// this causes the assertion to trigger, because age is not >= 0
```

위의 예제는 `age >= 0` 가 `true` 인 경우, 즉 `age` 의 값이 음수가 아닌 경우에만 코드 실행이 계속 됩니다. 만약 `age` 의 값이 음수이면 위의 코드에서 보듯 `age >= 0` 가 `false` 로 평가되고 단언 구문이 작동해서 응용 프로그램을 종료합니다.

단언 구문에서 메시지는 원할 경우 다음과 같이 생략할 수 있습니다:

```swift
assert(age >= 0)
```

> 단언 구문은 Xcode 에서 앱을 빌드할 때 Release 설정으로 빌드하는 경우 처럼 최적화 옵션으로 컴파일 할 때는 비활성화 됩니다. [^disabled]

#### 단언 구문을 사용하는 시점 (When to Use Assertions)

조건이 거짓이 될 가능성이 있지만 코드 실행을 계속하려면 반드시 참이어야만 하는 경우 단언 구문을 사용합니다. 단언 구문 검사를 하기에 적당한 상황은 다음과 같습니다:

* 정수 첨자 인덱스를 사용자 정의 첨자 구현에 전달하는데, 이 첨자 인덱스가 너무 낮거나 높을 수 있습니다.
* 값을 함수에 전달하는데, 유효하지 않은 값은 함수가 작업을 할 수 없음을 의미합니다.
* 옵셔널 값이 지금은 `nil` 인데, 후속 코드의 실행이 성공하려면 `nil` 이 아닌 값이 필요합니다.

[첨자 구문 (Subscripts)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/Subscripts.html#//apple_ref/doc/uid/TP40014097-CH16-ID305) 과 [함수 (Functions)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html#//apple_ref/doc/uid/TP40014097-CH10-ID158) 도 보기 바랍니다.

> 단언 구문은 앱을 종료시켜 버리는데다가 잘못된 조건이 발생하지 않도록 코드를 설계하는 용도로는 사용할 수 없습니다. 그럼에도 불구하고, 유효하지 않은 조건이 발생하는 상황에서는 단언 구문이 효과가 큰 방법인데, 앱 출시 전 개발 과정에서 문제가 있는 조건을 강조해서 파악하기 쉽게 해주기 때문입니다.


#### Enforcing Preconditions (선행 조건 강제하기)

### 참고 자료

[^The-Basics]: 원문은 [The Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html) 에서 확인할 수 있습니다.

[^constant-optimization]: 예전에 작성한 글 [Swift에서 변수 최적화에 대한 의문](http://xho95.github.io/xcode/swift/variables/optimization/2016/01/22/Swift-Variables-Optimization.html) 을 여기로 옮겨서 편집하도록 합니다.

[^private-use-Unicode-scalar-values]: '보조 사용자 영역의 유니코드 크기 값' 이란 '유니코드' 에서 'private-use areas' 를 말하는 것 같습니다. 유니코드에는 `U+E000 ~ U+F8FF` 등, 총 3개의 'private-use areas' 이 있는데, 보다 자세한 내용은 위키피디아의 [Unicode](https://en.wikipedia.org/wiki/Unicode) 항목을 참고하기 바랍니다.

[^annotation]: 'annotation' 자체에 '주석' 이라는 의미가 있지만, 프로그래밍 용어로 '주석' 은 'comments' 라는 말이 이미 널리 쓰이고 있으므로, 스위프트의 'annotation' 은 '보조 설명' 이라는 말로 옮기도록 합니다. 실제로 스위프트에서 'annotation' 을 쓸 일은 거의 없기 때문에 이 용어의 의미에 크게 비중을 두지 않아도 될 것 같습니다.

[^backticks]: 'backtics' 는 'grave accent' 라고도 하며 우리말로는 실제로는 '억음 부호' 라고 합니다. 말이 어렵기 때문에 의미 전달의 편의를 위해 '역따옴표' 라고 옮깁니다. 'grave accent' 에 대해서는 위키피디아의 [Grave accent](https://en.wikipedia.org/wiki/Grave_accent) 항목을 참고하기 바랍니다.

[^string-interpolation]: 'interpolation' 은 원래 수학 용어로 '보간법' 이라고 하며 두 값 사이의 값을 근사식으로 구해서 집어넣는 것을 말합니다. 'string interpolation' 은 '문자열 삽입법' 정도로 할 수 있겠지만, 수학 용어로 '보간법' 이라는 말이 널리 쓰이고 있으므로 '문자열 보간법' 이라고 옮기도록 합니다.

[^escape]: 'escape' 는 '벗어나다' 라는 의미를 가지고 있는데, 컴퓨터 용어에서 'escape character' 라고 하면 '(본래의 의미를) 벗어나서 (다른 의미를 가지는) 문자' 라는 의미가 있습니다. 참고로 스위프트에서 'escaping closure' 는 '(본래 영역을) 벗어날 수 있는 클로저' 를 의미합니다.





[^output]: 여기서 'output'을 '결과'로 옮겼는데, 하드웨어의 출력 장치를 말하는 것인지 확인이 필요합니다.

[^terminate]: 이 문장은 좀 더 다음어야 합니다.

[^string-interpolation]: 'string interpolation'은 '문자열 삽입 구문'으로 옮깁니다.

[^escape]: 이스케이프 문자는 그 다음에 오는 문자가 가지는 특별한 의미를 무시하는 단일 문자입니다. [이스케이프 문자](https://msdn.microsoft.com/ko-kr/library/aa559665.aspx)

[^integer]: 상황에 따라서 'integer' 를 그냥 '정수'로도 '정수 타입'으로도 옮깁니다.

[^naming]: 'naming'은 '이름짓기'로 옮깁니다.

[^convention]: 'convention'은 '규칙'으로 옮깁니다. 이것도 상황에 따라 달라질 것 같습니다.

[^native-word-size]: 'native word size'는 '내장 워드 크기'로 옮깁니다.

[^consistency]: 'consistency'는 '일관성'으로 옮깁니다.

[^interoperability]: 'interoperability'는 '상호 호환성'으로 옮깁니다. 말을 좀 더 부드럽게 다음을 필요가 있습니다.

[^mismatch]: 'mismatch'를 불일치하다라고 옮기면, 자연히 'match'는 일치하다라고 옮기는 것이 좋을 수 있을 것 같습니다.

[^appropriate]: 'appropriate'은 때에 따라서 '적당한' 또는 '적절한'으로 옮깁니다.

[^literal]: 'literal'는 '문자 그대로'라는 의미를 가지고 있습니다. 일단은 '글자표현' 이라는 말로 옮기고, 필요한 경우 발음 그대로 '리터럴'로 옮깁니다.

[^expression]: 'expression'는 '수식' 또는 '표현식'으로 옮깁니다. 일단 '수식'으로만 해 봅니다.

[^context]: 여기서는 'context' 를 '문맥'으로 옮겼습니다. 좀 더 생각해 봅니다.

[^numeric]: 여기서는 일단 'numeric' 을 '수치 값'으로 옮겼습니다.

[^base-number]: 'base number'는 '가수'로 옮겨지는데 마음에 안 듭니다. 좀 더 생각해 봅니다.

[^readability]: 'readability'는 '가독성'으로 옮깁니다.

[^extra-formatting]: 'extra formatting'는 '추가 서식'으로 옮깁니다.

[^extra]: 'extra'도 다양하게 옮길 수 있는데 좀 더 생각합니다. 일단 '여분'으로 옮깁니다. '별도'라는 말도 좋을 것 같습니다.

[^underlying]: 'underlying'은 '(밑에 깔려있는) 원래의'라는 말로 옮깁니다.

[^opt-in approach]: 'opt-in'은 '직접 선택'하는 것을 의미하며 이런 직접 선택 접근 방법은 수치 타입 변환이 필요할 경우에 각 경우마다 타입 변환을 명시해주는 방식을 뜻하는 듯합니다. 즉, 컴파일러가 임의로 변환하지 않고, 변환이 필요한 경우 직접 어떻게 변환할지를  컴파일러에게 알려주는 방식을 말하는 것 같습니다.

[^explicit]: 형용사로써 'explicit' 은 '명백한'으로도 옮길 수 있습니다.

[^aliase]: 'aliase'는 '별칭'으로 옮깁니다.

[^contextually]: 'contextually'는 '문맥상'으로 옮깁니다.

[^readable]: 'readable'은 '읽기 편하게'로 옮깁니다.

[^cover]: 'cover'는 '다룬다'고 옮깁니다.

[^decompose]: 'decompose'는 '분해하다'로 옮깁니다.

[^suite]: 'suite'는 '알맞다'로 옮깁니다.

[^concept]: 'concept'은 '개념'이라고 옮깁니다.

[^typically]: 'typically'는 여기서는 '보통'이라고 옮깁니다.

[^cope]: 'cope'는 '대처하다' 또는 '다루다'라고 옮깁니다.

[^nil]: 'nil'은 '무'라는 뜻인 것 같습니다.

[^swift-nil]: 이 부분은 조금 의역이 된 것인데, 좀 더 정리가 필요합니다.

[^equal-to-not-equal-to]: 'equal to'는 '같음'으로 'not equal to'는 '같지 않음'으로 옮깁니다. 일단 위키피디아의 [C와 C++에서의 연산자](https://ko.wikipedia.org/wiki/C와_C%2B%2B에서의_연산자) 에 있는 방식을 따랐습니다.

[^runtime]: 'runtime'은 '런타임'으로도 사용하는데 여기서는 '실행 시간'으로 옮겼습니다.

[^binding]: 'binding'은 '연결'로 옮겼는데 그냥 '바인딩'으로 할 지 좀 더 생각합니다. 'optional binding'을 '옵셔널 연결 구문' 으로 하는 것이 더 좋을 것도 같습니다.

[^manipulate]: 'manipulate'는 '조절하다'로 옮깁니다.

[^early-exit]: 'early exit'를 '조기 종료'로 옮겼는데 다시 생각해 봅니다.

[^implicitly-unwrapped-optional]: 'implicitly unwrapped optional'은 '저절로 풀리는 옵셔널'이라고 옮깁니다.

[^underlying]: 'underlying'은 '근원이 되는'으로 옮깁니다.

[^captured]: 'captured'는 '붙잡힌'으로 옮깁니다.

[^assertion]: 'assertion'은 '단언' 또는 '단언 구문'으로 옮깁니다.

[^debug]: 'debug'는 때에 따라서 '고치다'로 옮기기도 합니다.

[^query]: 'query'는 '질의'로 옮깁니다.

[^disabled]: 'disabled'는 일단 '비활성화'로 옮깁니다. 이 문장은 Xcode 옵션을 보고 좀 더 정확한 표현을 쓸 필요가 있습니다.
