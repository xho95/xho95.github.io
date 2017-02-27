## 기초 (The Basics)

Swift 는 iOS, macOS, watchOS, 그리고 tvOS 앱 개발을 위한 새로운 프로그래밍 언어입니다. 그렇더라도 C 와 Objective-C 에서의 개발 경험이 있다면 Swift 의 많은 부분이 꽤 친숙하게 느껴질 겁니다.

Swift 는 C 와 Objective-C 에 있는 모든 기본 타입들에 대한 자체 버전을 제공하는데, 정수는 `Int`, 부동 소수점은 `Double` 과 `Float`, 논리 (불린) 값으로는 `Bool`, 그리고 글자 데이터로는 `String` 을 제공합니다. Swift 는 또 [모듬 타입 (Collection Types)]() 에서 설명하는 것과 같이 `Array`, `Set`, 및 `Dictionary` 라는 세 가지의 강력한 기초 모듬 타입을 제공합니다.

C 처럼 Swift 도 값을 저장하고 참조하는데 변수를 사용하며, 이 때 이름을 가지고 각각을 식별합니다. [^identify] Swift 는 또한 값을 바꿀 수 없는 변수를 광범위하게 사용합니다. 이는 상수라고 하며 C 에서의 상수보다 훨씬 더 강력합니다. 상수는 Swift 의 전 영역에서 사용되는데, 바꿀 필요가 없는 값을 사용할 때 코드를 더 안전하고 명확하게 만들 목적으로 사용합니다.

이런 친숙한 타입과 더불어서 Swift 는 Objective-C 에는 없는 튜플 (tuples) 같은 더 앞선 타입도 도입합니다. [^tuple] [^advanced] [^introduce] 튜플은 값을 그룹으로 만들어서 전달 할 수 있도록 합니다. 튜플을 사용하면 함수에서 단일 합성 값의 형태로 한번에 여러 값을 반환할 수 있습니다. [^single-compound-value]

Swift 는 옵셔널 타입도 도입했는데 이는 값이 없는 상태를 처리합니다. 옵셔널은 “값이 있는데 그 값은 x 입니다” 라고 하거나 아니면 “값이 전혀 없습니다” 라고 말합니다. 옵셔널을 사용하는 것은 Objective-C 에서 `nil` 과 포인터를 사용하는 것과 비슷하지만, 클래스 뿐만 아니라 모든 타입에서 작동한다는 것이 다릅니다. 옵셔널은 Objective-C 의 `nil` 포인터보다 더 안전하고 표현이 간결할 뿐만 아니라, Swift 의 가장 강력한 특징들의 많은 곳에서 핵심을 담당합니다.

Swift 는 타입-안전 언어인데, 이는 코드에서 사용 중인 값의 타입이 분명해 지도록 언어가 돕는다는 것을 의미합니다. [^type-safe] 코드의 일부에서 `String` 을 예상하고 있다면, 타입 안전 검사기는 `Int` 를 실수로 전달하지 않도록 막습니다. [^type-safety] 마찬가지로, 타입 안전 검사기는 실수로 옵셔널 `String` 을 옵셔널이 아닌 `String` 을 기대하고 있는 코드에 전달하지 못하게 합니다. 타입 안전 검사기는 개발 과정에서 에러를 최대한 빨리 파악하고 수정할 수 있도록 도와줍니다.

### 상수 (Constants) 와 변수 (Variables)

상수와 변수는 이름 (가령 `maximumNumberOfLoginAttempts` 또는 `welcomeMessage`) 을 특정한 타입의 값 (가령 수 `10` 또는 문자열 `"Hello"`) 과 연결짓습니다. [^accociate] 상수의 값은 한 번 설정하면 바꿀 수 없는 반면에 변수는 나중에 다른 값으로 설정할 수 있습니다.

#### 상수와 변수 선언하기 (Declaring)

상수와 변수는 사용하기 전에 반드시 먼저 선언돼 있어야 합니다. 상수는 `let` 키워드로 선언하고 변수는 `var` 키워드로 선언합니다. 상수와 변수를 사용해서 사용자가 로그인하려고 시도한 횟수를 추적하는데 사용하는 예제입니다:

```swift
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
```

이 코드는 다음처럼 말할 수 있습니다:

“`maximumNumberOfLoginAttempts` 라는 새로운 상수를 선언하고 값을 `10` 으로 둡니다. 그런 다음 `currentLoginAttempt` 라는 새로운 변수를 선언해서 초기 값으로 `0` 을 지정합니다.”

이 예제에서 최대로 허용되는 로그인 시도 횟수는 상수로 선언되는데, 최대 허용 값은 절대 바뀔 일이 없기 때문입니다. 한 편 현재 로그인 시도 카운터는 변수로 선언되며, 이는 이 값이 로그인 시도가 실패할 때마다 증가되어야 하기 때문입니다. [^counter]

쉼표로 구분하면 하나의 행에 여러 개의 상수나 변수를 선언할 수 있습니다:

```swift
var x = 0.0, y = 0.0, z = 0.0
```

> 코드에서 저장된 값이 바뀔 일이 없으면, 항상 `let` 키워드로 상수로 만들도록 합니다. 변수는 저장된 값이 바뀔 가능성이 있는 경우에만 쓰도록 합니다. [^using-constant]

#### 타입 지정 (Type Annotations)

상수나 변수를 선언할 때 타입을 지정할 수 있는데, 이렇게 하면 상수나 변수에 저장할 수 있는 값의 종류를 분명하게 알 수 있습니다. [^annotation] 타입을 지정하는 방법은 상수나 변수 뒤에 콜론을 놓고 공백으로 띄운 다음 사용할 타입의 이름을 적으면 됩니다.

아래의 예제는 `welcomeMessage` 라는 변수의 타입을 지정하고 있는데, 이 변수가 `String` 값을 저장할 수 있음을 나타냅니다:

```swift
var welcomeMessage: String
```

선언에서의 콜론은 “… 타입으로 …,” 을 의미하므로 위의 코드는 다음과 같은 말이 됩니다:

“`welcomeMessage` 변수를 `String` 타입으로 선언합니다.”

“`String` 타입으로” 라는 구절은 “어떠한 `String` 값도 저장할 수 있도록” 을 의미합니다. 이는 저장할 수 있는 “어떠한 타입” (또는 “어떠한 종류”) 를 의미한다고 생각하면 됩니다.

이제 `welcomeMessage` 변수에는 에러없이 어떤 문자열 값이라도 넣을 수 있습니다:

```swift
welcomeMessage = "Hello"
```

쉼표로 구분한 다음 마지막 변수 이름 뒤에 한 번만 타입 지정을 하면, 하나의 행에 타입이 같은 다수의 관련 변수를 정의할 수 있습니다:

```swift
var red, green, blue: Double
```

> 실제로 타입 지정을 하는 경우는 드뭅니다. 상수나 변수를 정의하는 시점에 초기 값을 주면,  Swift 는 상수나 변수에 사용되는 타입을 거의 항상 추론할 수 있는데, 이 내용은 [타입 안전 검사기와 타입 추론 (Type Safety and Type Inference)]() 에 설명하고 있습니다. 위에 있는 `welcomeMessage` 예제에서는 초기 값을 주지 않았으므로 `welcomeMessage` 변수의 타입은 초기 값으로 추론된 것이 아니라 타입 지정으로 지정된 것입니다.

#### 상수와 변수의 이름짓기 (Naming)

상수나 변수의 이름에는 유니 코드를 포함해서 거의 모든 문자를 사용할 수 있습니다:

```swift
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"
```

상수 또는 변수의 이름에는 빈공백 문자, 수학 기호, 화살표, 개인-목적의 (또는 유효하지 않은) 유니코드 코드 번호, 또는 줄- 및 상자-그림 문자가 있을 수 없습니다. 게다가 숫자로 시작할 수도 없습니다. 물론 숫자는 시작 위치만 아니면 이름의 어디든지 있을 수 있습니다.

일단 상수나 변수를 특정 타입으로 한 번 선언 하고 나면, 같은 이름으로 재선언할 수도 저장된 값을 다른 타입으로 바꿀 수도 없습니다. 상수를 변수로 바꾸거나 변수를 상수로 바꾸는 것도 안됩니다.

> Swift 의 예약 키워드와 같은 이름을 상수나 변수에 써야할 경우, 키워드를 이름으로 사용할 때에는 역 따옴표 (`) 로 키워드를 감싸면 됩니다. 하지만 정말로 선택의 여지가 없는 것이 아니라면 키워드를 이름으로 사용하지 않도록 합니다.

기존 변수의 값은 호환 가능한 타입이면 다른 값으로 바꿀 수 있습니다. 다음의 예에서는 `friendlyWelcome` 의 값 `"Hello!"` 에서 `"Bonjour!"` 로 바뀌었습니다:

```swift
var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"
// friendlyWelcome 은 이제 "Bonjour!" 입니다.
```

변수와는 다르게 상수는 한 번 설정되고 나면 바꿀 수 없습니다. 그렇게 하려고 하면 코드를 컴파일할 때 에러가 발생합니다:

```swift
let languageName = "Swift"
languageName = "Swift++"
// This is a compile-time error: languageName cannot be changed.
```

#### 상수와 변수 출력하기 (Printing)

상수 또는 변수의 현재 값을 출력하려면 `print(_:separator:terminator:)` 함수를 사용합니다:

```swift
print(friendlyWelcome)
// "Bonjour!" 를 출력합니다.
```

`print(_:separator:terminator:)` 함수는 하나 이상의 값을 적절한 결과로 출력하는 전역 함수입니다. [^output] 예를 들어 Xcode 에서는 `print(_:separator:terminator:)` 함수가 Xcode 의 “콘솔” 창에 결과를 출력합니다. `separator` 와 `terminator` 매개 변수는 기본 값을 갖고 있어서, 이 함수를 호출할 때 생략할 수 있습니다. 기본으로 이 함수는 한 줄을 출력할 때 끝에 줄 바꿈을 추가합니다. [^terminate] 줄 바꿈 없이 값을 출력하려면, `terminator` 매개 변수에 빈 문자열을 전달합니다 — 예를 들어 `print(someValue, terminator: "")` 라고 하면 됩니다. 기본 값이 있는 매개 변수에 대한 정보는 [Default Parameter Values]() 부분을 보기 바랍니다.

Swift 의 문자열 삽입 구문 (string interpolation) 을 사용하면, 긴 문자열 속에 자리 표시자의 형태로 상수나 변수의 이름을 쓰고, Swift 가 상수나 변수의 현재 값으로 대체하도록 할 수 있습니다. 자리 표시자는 이름을 괄호로 감싼 다음 괄호 맨 앞에 역 슬래시를 붙여줘서 이스케이프 해주면 됩니다: [^escape]

```swift
print("The current value of friendlyWelcome is \(friendlyWelcome)")
// "The current value of friendlyWelcome is Bonjour!" 를 출력합니다.
```

> 문자열 삽입 구문에서 사용할 수 있는 모든 옵션은 [문자열 삽입 구문 (String Interpolation)]() 에서 설명합니다.

### 주석 (Comments)

주석을 사용하여 코드에 기록이나 기억을 돕는 용도로 실행되지 않는 글을 넣을 수 있습니다. Swift 컴파일러는 컴파일할 때 주석을 무시합니다.

Swift 의 주석은 C 의 주석과 매우 비슷합니다. 한 줄 짜리 주석은 두 개의 슬래시 (`//`) 로 시작합니다:

```swift
// This is a comment.
```

여러 줄짜리 주석은 슬래시와 별표 (`/*`) 가 있는 곳에서 시작해서 별표와 슬래시 (`*/`) 가 있는 곳에서 끝납니다:

```swift
/* This is also a comment
 but is written over multiple lines. */
```

C 의 여러 줄 주석과는 다르게 Swift 의 여러 줄 주석은 다른 여러 줄 주석 안에 중첩될 수 있습니다. 중첩된 주석을 만들려면 여러 줄짜리 주석 블럭을 시작한 다음 첫번째 주석 블럭 내에서 두번째 여러 줄 주석을  시작하면 됩니다. 두번째 주석 블럭이 닫히고 나서야 첫번째 주석 블럭이 닫히게 됩니다.

```swift
/* This is the start of the first multiline comment.
 /* This is the second, nested multiline comment. */
 This is the end of the first multiline comment. */
```

여러 줄 주석을 중첩하면 코드에 이미 여러 줄 주석이 섞여 있는 경우에도 대용량의 블럭을 빠르고 쉽게 주석 처리 할 수 있습니다.

### 세미콜론 (Semicolons)

많은 다른 언어와는 다르게  Swift 는 코드의 각 문장의 끝에 세미콜론 (`;`) 을 붙일 필요가 없습니다. 물론 원한다면 할 수는 있습니다. 하지만 한 줄에 여러 개의 다른 문장을 쓰고 싶으면 세미콜론을 넣어야 합니다:

```swift
let cat = "🐱"; print(cat)
// "🐱" 를 출력합니다.
```

### 정수 (Integers) 타입

정수는 `42` 와 `-23` 처럼 분수 성분이 없는 모든 수를 말합니다. [^integer] 정수 타입에는 부호가 있는 경우 (양수, 0, 또는 음수) 가 있고 없는 경우 (양수나 0) 가 있습니다.

Swift 는 부호가 있는 정수 타입과 없는 정수 타입을 8, 16, 32, 그리고 64 비트 형식으로 제공합니다. 이 정수 타입의 이름은 C 와 비슷한 규칙으로 지어졌는데, 8-비트 부호 없는 정수는 `UInt8` 타입이고, 32-비트 부호 있는 정수는 `Int32` 타입입니다 . [^naming] [^convention] Swift 의 모든 다른 타입들처럼 정수 타입은 대문자로 시작합니다.

#### 정수 범위 (Bounds)

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

> `UInt`는 플랫폼의 기본 워드와 같은 크기의 부호 없는 정수 타입이 특별히 필요한 경우만 사용하도록 합니다. 이런 특별한 경우가 아니라면 저장되는 값이 음수가 아니더라도 `Int` 를 사용하는 것이 더 좋습니다. 정수 값으로 일관되게 `Int` 를 사용하면 상호 이용성에 도움이 되고, 다른 수 타입으로 타입을 바꿀 필요가 없으며, [타입 안전 검사기와 타입 추론 (Type Safety and Type Inference)]() 에 설명된 것 처럼 정수 타입 추론에 들어맞게 됩니다.

### 부동소수점 수 (Floating-Point Numbers) 타입 

부동 소수점 수는 `3.14159`, `0.1` 와 `-273.15` 처럼 분수 요소가 있는 수입니다.

부동 소수점 타입은 정수 타입보다 훨씬 광범위한 값을 표현할 수 있으며 `Int` 에 저장할 수 있는 것보다 더 크거나 작은 수를 저장할 수 있습니다. Swift 는 두 가지의 부호 있는 부동 소수점 수 타입을 제공합니다:

* `Double` 은 64-비트 부동 소수점 수를 나타냅니다.
* `Float` 은 32-비트 부동 소수점 수를 나타냅니다.

> `Double` 은 적어도 소수점 이하 15 자리수의 정밀도를 가지고 있는 반면 `Float` 의 정밀도는 소수점 이하 6자리일 정도로 작습니다. 사용하고 있는 부동 소수점 타입이 적절한지는 코드에서 사용할 값의 특성과 범위에 달린 문제입니다. 두 타입이 모두 적당한 상황이라면 `Double` 을 쓰는 것이 더 낫습니다.

### 타입 안전 검사기 (Type Safety) 와 타입 추론(Type Inference)

Swift 는 타입-안전 언어입니다. 타입 안전 언어는 코드에서 사용하는 값의 타입을 분명히 할 것을 권장합니다. 코드의 일부분이 `String` 을 예상하고 있다면 실수로 `Int` 를 전달할 수 없습니다.

Swift 는 타입에 안전하므로 코드를 컴파일할 때 타입 검사를 수행해서 일치하지 않는 타입이 있으면 에러로 알려줍니다. 이렇게 함으로써 개발 과정에서 최대한 빠른 시간에 에러를 포착하고 고칠 수 있도록 해줍니다. [^mismatch]

타입-검사는 다른 타입의 값들을 사용할 때 에러를 피하도록 해 줍니다. 하지만 이것이 상수와 변수를 선언할 때 항상 타입을 지정해줘야 함을 뜻하는 것은 아닙니다. 필요한 값의 타입을 지정하지 않으면 Swift 는 타입 추론을 사용해서 적절한 타입을 찾아냅니다. [^appropriate] 타입 추론은 코드를 컴파일할 때 자동으로 컴파일러가 특정 표현식의 타입을 찾을 수 있도록 해주는데,  이것은 단순히 제공된 값을 검사하는 것으로 이루어 집니다.

타입 추론으로 인하여 Swift 는 C 나 Objective-C 같은 언어보다 타입 선언을 훨씬 더 적게 해도 됩니다. 상수와 변수는 여전히 직접 쳐줘야 하지만, 타입을 지정하는 대부분의 작업은 자동으로 이루어집니다.

타입 추론은 초기 값을 가지고 상수와 변수를 선언할 때 특히 더 유용합니다. 이것은 선언할 때 문자 그대로의 값 (리터럴) 을 상수나 변수에 할당하는 것을 말합니다. [^literal] (리터럴 값은 소스 코드에 그대로 나타나는 값을 말하며 아래 예에서 `42` 와 `3.14159` 같은 것입니다.)

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

### 수치 값 리터럴 (Numeric Literals)

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

### 수치 타입의 형변환 (Numeric Type Conversion)

모든 일반 용도에서 그리고 심지어는 양수로만 쓰는 경우에도 정수 상수나 변수에는 항상 `Int` 타입만 쓰도록 합니다. 모든 상황에서 기본 정수 타입만 쓴다는 것은 코드에 있는 정수 상수와 변수가 언제든지 상호 호환가능함을 의미하며 정수 리터럴 값의 타입 추론과도 일치함을 의미합니다.

다른 정수 타입은 특별하게 필요한 경우에만 사용하도록 하는데 이는 외부 소스에서 직접 크기가 결정된 데이터라던가 성능이나 메모리 사용량 문제 아니면 다른 최적화가 필요한 경우 등에 해당합니다. 이런 상황에서는 직접 크기가 결정된 타입을 사용하는 것이 우연하게 값이 넘치는 문제를 잡아내는데 도움을 주고 사용하는 데이터의 특성을 저절로 문서화할 수 있도록 해 줍니다.

#### 정수 사이의 형변환 (Integer Conversion)

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

`SomeType(ofInitialValue)` 는 Swift 에서 타입의 초기자를 호출하고 초기 값을 전달하는 기본 방법입니다. 속을 들여다 보면, `UInt16` 타입은 `UInt8` 값을 받아들일 수 있는 초기자를 가지고 있어서, 이 초기자로 기존의 `UInt8` 값에서 새로운 `UInt16` 값을 만듭니다. 즉 여기서 아무 타입이나 전달할 수는 없고 — `UInt16` 의 초기자에 넘길 수 있는 타입만 가능합니다. 기존 타입의 초기자를 확장해서 (직접 정의한 타입도 포함하여) 새로운 타입을 받아들이게 하는 방법은 [확장 (Extensions) 기능]() 에서 다룹니다.

#### 정수와 부동 소수점 수 사이의 형변환 (Integer and Floating-Point Conversion)

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

### 타입의 별칭 (Type Aliases)

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

### 불 타입 (Booleans)

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

`if` 문 같은 조건 구문에 대해서는 [흐름 제어(Control Flow)]() 에서 더 자세히 다룹니다. [^cover]

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

`i == 1` 비교 연산의 결과는 `Bool` 타입이므로 두번째 예는 타입-검사를 통과합니다. `i == 1` 과 같은 비교 연산은 [기본 연산자 (Basic Operators)]() 에서 논의합니다.

Swift 에 있는 다른 타입 검사기의 예들과 마찬가지로 이러한 접근 방식은 실수로 인한 에러를 방지하고 특정 코드 영역의 의도가 항상 명확히 드러나도록 만들어 줍니다.

### 튜플 (Tuples)

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

튜플은 특히 함수의 반환 값으로 유용합니다. 웹 페이지를 검색하려고 하는 함수는 페이지 검색이 성공했는지 실패했는지 나타내기 위해 `(Int, String)` 튜플 타입으로 반환할 수도 있습니다. 두 개의 다른 타입으로 된 두 개의 값을 가지는 튜플로 반환하면, 이 함수는 한 가지 타입으로 된 한 개의 값만 반환할 때보다 더 유용한 정보를 제공할 수 있습니다. 더 많은 정보는 [여러 반환 값을 가지는 함수 (Functions with Multiple Return Values)]() 에서 볼 수 있습니다.

> 튜플은 관련 있는 값들을 임시로 그룹지을 때 유용합니다. 복잡한 데이터 구조를 만드는데는 알맞지 않습니다. [^suite] 만약 데이터 구조가 임시 영역을 넘어서 유지되어야 할 경우 튜플 보다는 클래스 (객체 타입) 이나 구조 타입으로 모델을 만들도록 합니다. 더 많은 정보는 [클래스와 구조 타입 (Classes and Structures)]() 에서 볼 수 있습니다.

### 옵셔널 (Optionals)

You use optionals in situations where a value may be absent. An optional represents two possibilities: Either there is a value, and you can unwrap the optional to access that value, or there isn’t a value at all.

> The concept of optionals doesn’t exist in C or Objective-C. The nearest thing in Objective-C is the ability to return `nil` from a method that would otherwise return an object, with `nil` meaning “the absence of a valid object.” However, this only works for objects—it doesn’t work for structures, basic C types, or enumeration values. For these types, Objective-C methods typically return a special value (such as `NSNotFound`) to indicate the absence of a value. This approach assumes that the method’s caller knows there is a special value to test against and remembers to check for it. Swift’s optionals let you indicate the absence of a value for any type at all, without the need for special constants.

Here’s an example of how optionals can be used to cope with the absence of a value. Swift’s `Int` type has an initializer which tries to convert a `String` value into an `Int` value. However, not every string can be converted into an integer. The string `"123"` can be converted into the numeric value `123`, but the string `"hello, world"` does not have an obvious numeric value to convert to.

The example below uses the initializer to try to convert a `String` into an `Int`:

```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber is inferred to be of type "Int?", or "optional Int"
```

Because the initializer might fail, it returns an optional Int, rather than an Int. An optional `Int` is written as `Int?`, not `Int`. The question mark indicates that the value it contains is optional, meaning that it might contain some `Int` value, or it might contain no value at all. (It can’t contain anything else, such as a `Bool` value or a `String` value. It’s either an `Int`, or it’s nothing at all.)

#### nil

You set an optional variable to a valueless state by assigning it the special value `nil`:

```swift
var serverResponseCode: Int? = 404
// serverResponseCode contains an actual Int value of 404
serverResponseCode = nil
// serverResponseCode now contains no value
```

> `nil` cannot be used with nonoptional constants and variables. If a constant or variable in your code needs to work with the absence of a value under certain conditions, always declare it as an optional value of the appropriate type.

If you define an optional variable without providing a default value, the variable is automatically set to `nil` for you:

```swift
var surveyAnswer: String?
// surveyAnswer is automatically set to nil
```

> Swift’s `nil` is not the same as `nil` in Objective-C. In Objective-C, `nil` is a pointer to a nonexistent object. In Swift, nil is not a pointer—it is the absence of a value of a certain type. Optionals of any type can be set to `nil`, not just object types.

#### If 조건문 (Statements) 과 강제 풀기 (Forced Unwrapping)

You can use an `if` statement to find out whether an optional contains a value by comparing the optional against `nil`. You perform this comparison with the “equal to” operator (`==`) or the “not equal to” operator (`!=`).

If an optional has a value, it is considered to be “not equal to” `nil`:

```swift
if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}
// Prints "convertedNumber contains some integer value."
```

Once you’re sure that the optional does contain a value, you can access its underlying value by adding an exclamation mark (`!`) to the end of the optional’s name. The exclamation mark effectively says, “I know that this optional definitely has a value; please use it.” This is known as forced unwrapping of the optional’s value:

```swift
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}
// Prints "convertedNumber has an integer value of 123."
```

For more on the `if` statement, see [Control Flow]().

> Trying to use `!` to access a nonexistent optional value triggers a runtime error. Always make sure that an optional contains a non-`nil` value before using `!` to force-unwrap its value.

#### 옵셔널 연결 (Optional Binding)

You use optional binding to find out whether an optional contains a value, and if so, to make that value available as a temporary constant or variable. Optional binding can be used with `if` and `while` statements to check for a value inside an optional, and to extract that value into a constant or variable, as part of a single action. `if` and `while` statements are described in more detail in [Control Flow]().

Write an optional binding for an `if` statement as follows:

```
if let constantName = someOptional {
    statements
}
```

You can rewrite the `possibleNumber` example from the [Optionals]() section to use optional binding rather than forced unwrapping:

```swift
if let actualNumber = Int(possibleNumber) {
    print("\"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("\"\(possibleNumber)\" could not be converted to an integer")
}
// Prints ""123" has an integer value of 123"
```

This code can be read as:

“If the optional `Int` returned by `Int(possibleNumber)` contains a value, set a new constant called `actualNumber` to the value contained in the optional.”

If the conversion is successful, the `actualNumber` constant becomes available for use within the first branch of the `if` statement. It has already been initialized with the value contained within the optional, and so there is no need to use the `!` suffix to access its value. In this example, `actualNumber` is simply used to print the result of the conversion.

You can use both constants and variables with optional binding. If you wanted to manipulate the value of actualNumber within the first branch of the if statement, you could write if var actualNumber instead, and the value contained within the optional would be made available as a variable rather than a constant.

You can include as many optional bindings and Boolean conditions in a single `if` statement as you need to, separated by commas. If any of the values in the optional bindings are `nil` or any Boolean condition evaluates to `false`, the whole `if` statement’s condition is considered to be `false`. The following `if` statements are equivalent:

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

> Constants and variables created with optional binding in an `if` statement are available only within the body of the `if` statement. In contrast, the constants and variables created with a `guard` statement are available in the lines of code that follow the `guard` statement, as described in [Early Exit]().

#### 저절로 풀리는 옵셔널 (Implicitly Unwrapped Optionals)

As described above, optionals indicate that a constant or variable is allowed to have “no value”. Optionals can be checked with an `if` statement to see if a value exists, and can be conditionally unwrapped with optional binding to access the optional’s value if it does exist.

Sometimes it is clear from a program’s structure that an optional will always have a value, after that value is first set. In these cases, it is useful to remove the need to check and unwrap the optional’s value every time it is accessed, because it can be safely assumed to have a value all of the time.

These kinds of optionals are defined as implicitly unwrapped optionals. You write an implicitly unwrapped optional by placing an exclamation mark (`String!`) rather than a question mark (`String?`) after the type that you want to make optional.

Implicitly unwrapped optionals are useful when an optional’s value is confirmed to exist immediately after the optional is first defined and can definitely be assumed to exist at every point thereafter. The primary use of implicitly unwrapped optionals in Swift is during class initialization, as described in [Unowned References and Implicitly Unwrapped Optional Properties]().

An implicitly unwrapped optional is a normal optional behind the scenes, but can also be used like a nonoptional value, without the need to unwrap the optional value each time it is accessed. The following example shows the difference in behavior between an optional string and an implicitly unwrapped optional string when accessing their wrapped value as an explicit `String`:

```swift
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation mark
 
let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation mark
```

You can think of an implicitly unwrapped optional as giving permission for the optional to be unwrapped automatically whenever it is used. Rather than placing an exclamation mark after the optional’s name each time you use it, you place an exclamation mark after the optional’s type when you declare it.

> If an implicitly unwrapped optional is `nil` and you try to access its wrapped value, you’ll trigger a runtime error. The result is exactly the same as if you place an exclamation mark after a normal optional that does not contain a value.

You can still treat an implicitly unwrapped optional like a normal optional, to check if it contains a value:

```swift
if assumedString != nil {
    print(assumedString)
}
// Prints "An implicitly unwrapped optional string."
```

You can also use an implicitly unwrapped optional with optional binding, to check and unwrap its value in a single statement:

```swift
if let definiteString = assumedString {
    print(definiteString)
}
// Prints "An implicitly unwrapped optional string."
```

> Do not use an implicitly unwrapped optional when there is a possibility of a variable becoming `nil` at a later point. Always use a normal optional type if you need to check for a `nil` value during the lifetime of a variable.

### 에러 처리 (Error Handling)

You use error handling to respond to error conditions your program may encounter during execution.

In contrast to optionals, which can use the presence or absence of a value to communicate success or failure of a function, error handling allows you to determine the underlying cause of failure, and, if necessary, propagate the error to another part of your program.

When a function encounters an error condition, it throws an error. That function’s caller can then catch the error and respond appropriately.

```swift
func canThrowAnError() throws {
    // this function may or may not throw an error
}
```

A function indicates that it can throw an error by including the `throws` keyword in its declaration. When you call a function that can throw an error, you prepend the `try` keyword to the expression.

Swift automatically propagates errors out of their current scope until they are handled by a `catch` clause.

```swift
do {
    try canThrowAnError()
    // no error was thrown
} catch {
    // an error was thrown
}
```

A `do` statement creates a new containing scope, which allows errors to be propagated to one or more `catch` clauses.

Here’s an example of how error handling can be used to respond to different error conditions:

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
In this example, the `makeASandwich()` function will throw an error if no clean dishes are available or if any ingredients are missing. Because `makeASandwich()` can throw an error, the function call is wrapped in a `try` expression. By wrapping the function call in a do statement, any errors that are thrown will be propagated to the provided `catch` clauses.

If no error is thrown, the `eatASandwich()` function is called. If an error is thrown and it matches the `SandwichError.outOfCleanDishes` case, then the `washDishes()` function will be called. If an error is thrown and it matches the `SandwichError.missingIngredients` case, then the `buyGroceries(_:)` function is called with the associated `[String]` value captured by the `catch` pattern.

Throwing, catching, and propagating errors is covered in greater detail in [Error Handling]().

### 단언 (Assertions) 구문

In some cases, it is simply not possible for your code to continue execution if a particular condition is not satisfied. In these situations, you can trigger an assertion in your code to end code execution and to provide an opportunity to debug the cause of the absent or invalid value.

#### 단언 구문으로 디버깅하기 (Debugging with Assertions)

An assertion is a runtime check that a Boolean condition definitely evaluates to `true`. Literally put, an assertion “asserts” that a condition is true. You use an assertion to make sure that an essential condition is satisfied before executing any further code. If the condition evaluates to `true`, code execution continues as usual; if the condition evaluates to `false`, code execution ends, and your app is terminated.

If your code triggers an assertion while running in a debug environment, such as when you build and run an app in Xcode, you can see exactly where the invalid state occurred and query the state of your app at the time that the assertion was triggered. An assertion also lets you provide a suitable debug message as to the nature of the assert.

You write an assertion by calling the Swift standard library global `assert(_:_:file:line:)` function. You pass this function an expression that evaluates to `true` or `false` and a message that should be displayed if the result of the condition is `false`:

```swift
let age = -3
assert(age >= 0, "A person's age cannot be less than zero")
// this causes the assertion to trigger, because age is not >= 0
```

In this example, code execution will continue only if `age >= 0` evaluates to `true`, that is, if the value of `age` is non-negative. If the value of `age` is negative, as in the code above, then `age >= 0` evaluates to `false`, and the assertion is triggered, terminating the application.

The assertion message can be omitted if desired, as in the following example:

```swift
assert(age >= 0)
```

> Assertions are disabled when your code is compiled with optimizations, such as when building with an app target’s default Release configuration in Xcode.

#### 언제 단언 구문을 사용하는가 (When to Use Assertions)

Use an assertion whenever a condition has the potential to be false, but must definitely be true in order for your code to continue execution. Suitable scenarios for an assertion check include:

* An integer subscript index is passed to a custom subscript implementation, but the subscript index value could be too low or too high.
* A value is passed to a function, but an invalid value means that the function cannot fulfill its task.
* An optional value is currently `nil`, but a non-`nil` value is essential for subsequent code to execute successfully.

See also [Subscripts]() and [Functions]().

> Assertions cause your app to terminate and are not a substitute for designing your code in such a way that invalid conditions are unlikely to arise. Nonetheless, in situations where invalid conditions are possible, an assertion is an effective way to ensure that such conditions are highlighted and noticed during development, before your app is published.

### 참고 자료 

[^identify]: 'identify'는 '신원을 파악하다'를 살려서 옮깁니다. 일단 '식별하다' 로 옮깁니다. 정리가 필요합니다.

[^tuple]: 'tuple'은 '튜플'로 옮깁니다.

[^advanced]: 'advanced'는 '더 앞선' 으로 옮깁니다.

[^single-compound-value]: 'single compound value'는 '단일 합성 값'으로 옮깁니다.

[^introduce]: 'introduce'는 때에 따라서 '도입하다'라고 옮깁니다.

[^type-safe]: 'type safe'는 '타입 안전'으로 옮깁니다. '타입에 대하 안전한'이 더 좋을지는 좀 더 지켜볼 생각입니다.

[^type-safety]: 'type safety'는 '타입 안전 검사기'로 옮깁니다.

[^accociate]: 'accociate'는 '연관짓다'로 옮기지만 때에 따라 '연결짓다'로 옮깁니다.

[^counter]: 'counter'는 '카운터'로 옮깁니다.

[^using-constant]: 이 부분은 컴파일러 최적화와 관련이 있습니다.

[^annotation]: 'annotation'은 '주석, 주해'의 의미가 있는데 여기서는 일단 '지정'으로 옮깁니다. 'annotation'은 프로그래밍마다 조금씩 다른 의미로 사용되는데 Swift 에서는 타입을 지정하는 표시로 사용하는 것 같습니다.

[^code-point]: 아직은 단어 자체가 생소합니다. 일단은 'code point'를 '코드 번호'로 옮겼는데 나중에 바꾸도록 합니다.

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

[^literal]: 'literal'는 '문자 그대로'라는 의미를 가지고 있습니다. 일단은 그냥 '리터럴'로 옮깁니다.

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