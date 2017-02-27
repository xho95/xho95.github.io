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
// Prints "The current value of friendlyWelcome is Bonjour!"
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
// Prints "🐱"
```

### 정수 (Integers)

Integers are whole numbers with no fractional component, such as `42` and `-23`. Integers are either signed (positive, zero, or negative) or unsigned (positive or zero).

Swift provides signed and unsigned integers in 8, 16, 32, and 64 bit forms. These integers follow a naming convention similar to C, in that an 8-bit unsigned integer is of type `UInt8`, and a 32-bit signed integer is of type `Int32`. Like all types in Swift, these integer types have capitalized names.

#### Integer Bounds

You can access the minimum and maximum values of each integer type with its `min` and `max` properties:

```swift
let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8
```

The values of these properties are of the appropriate-sized number type (such as `UInt8` in the example above) and can therefore be used in expressions alongside other values of the same type.

#### Int

In most cases, you don’t need to pick a specific size of integer to use in your code. Swift provides an additional integer type, `Int`, which has the same size as the current platform’s native word size:

* On a 32-bit platform, `Int` is the same size as `Int32`.
* On a 64-bit platform, `Int` is the same size as `Int64`.

Unless you need to work with a specific size of integer, always use `Int` for integer values in your code. This aids code consistency and interoperability. Even on 32-bit platforms, `Int` can store any value between `-2,147,483,648` and `2,147,483,647`, and is large enough for many integer ranges.

#### UInt

Swift also provides an unsigned integer type, `UInt`, which has the same size as the current platform’s native word size:

* On a 32-bit platform, `UInt` is the same size as `UInt32`.
* On a 64-bit platform, `UInt` is the same size as `UInt64`.

> Use `UInt` only when you specifically need an unsigned integer type with the same size as the platform’s native word size. If this is not the case, `Int` is preferred, even when the values to be stored are known to be non-negative. A consistent use of `Int` for integer values aids code interoperability, avoids the need to convert between different number types, and matches integer type inference, as described in [Type Safety and Type Inference]().

### Floating-Point Numbers

Floating-point numbers are numbers with a fractional component, such as `3.14159`, `0.1`, and `-273.15`.

Floating-point types can represent a much wider range of values than integer types, and can store numbers that are much larger or smaller than can be stored in an `Int`. Swift provides two signed floating-point number types:

* `Double` represents a 64-bit floating-point number.
* `Float` represents a 32-bit floating-point number.

> `Double` has a precision of at least 15 decimal digits, whereas the precision of `Float` can be as little as 6 decimal digits. The appropriate floating-point type to use depends on the nature and range of values you need to work with in your code. In situations where either type would be appropriate, `Double` is preferred.

### Type Safety and Type Inference

Swift is a type-safe language. A type safe language encourages you to be clear about the types of values your code can work with. If part of your code expects a `String`, you can’t pass it an `Int` by mistake.

Because Swift is type safe, it performs type checks when compiling your code and flags any mismatched types as errors. This enables you to catch and fix errors as early as possible in the development process.

Type-checking helps you avoid errors when you’re working with different types of values. However, this doesn’t mean that you have to specify the type of every constant and variable that you declare. If you don’t specify the type of value you need, Swift uses type inference to work out the appropriate type. Type inference enables a compiler to deduce the type of a particular expression automatically when it compiles your code, simply by examining the values you provide.

Because of type inference, Swift requires far fewer type declarations than languages such as C or Objective-C. Constants and variables are still explicitly typed, but much of the work of specifying their type is done for you.

Type inference is particularly useful when you declare a constant or variable with an initial value. This is often done by assigning a literal value (or literal) to the constant or variable at the point that you declare it. (A literal value is a value that appears directly in your source code, such as `42` and `3.14159` in the examples below.)

For example, if you assign a literal value of `42` to a new constant without saying what type it is, Swift infers that you want the constant to be an `Int`, because you have initialized it with a number that looks like an integer:

```swift
let meaningOfLife = 42
// meaningOfLife is inferred to be of type Int
```

Likewise, if you don’t specify a type for a floating-point literal, Swift infers that you want to create a `Double`:

```swift
let pi = 3.14159
// pi is inferred to be of type Double
```

Swift always chooses `Double` (rather than `Float`) when inferring the type of floating-point numbers.

If you combine integer and floating-point literals in an expression, a type of `Double` will be inferred from the context:

```swift
let anotherPi = 3 + 0.14159
// anotherPi is also inferred to be of type Double
```

The literal value of `3` has no explicit type in and of itself, and so an appropriate output type of `Double` is inferred from the presence of a floating-point literal as part of the addition.

### Numeric Literals

Integer literals can be written as:

* A decimal number, with no prefix
* A binary number, with a `0b` prefix
* An octal number, with a `0o` prefix
* A hexadecimal number, with a `0x` prefix

All of these integer literals have a decimal value of `17`:

```swift
let decimalInteger = 17
let binaryInteger = 0b10001       // 17 in binary notation
let octalInteger = 0o21           // 17 in octal notation
let hexadecimalInteger = 0x11     // 17 in hexadecimal notation
```

Floating-point literals can be decimal (with no prefix), or hexadecimal (with a `0x` prefix). They must always have a number (or hexadecimal number) on both sides of the decimal point. Decimal floats can also have an optional exponent, indicated by an uppercase or lowercase `e`; hexadecimal floats must have an exponent, indicated by an uppercase or lowercase `p`.

For decimal numbers with an exponent of `exp`, the base number is multiplied by 10<sup>exp</sup>:

* 1.25e2 means 1.25 x 10<sup>2</sup>, or 125.0.
* 1.25e-2 means 1.25 x 10<sup>-2</sup>, or 0.0125.

For hexadecimal numbers with an exponent of exp, the base number is multiplied by 2<sup>exp</sup>:

* 0xFp2 means 15 x 2<sup>2</sup>, or 60.0.
* 0xFp-2 means 15 x 2<sup>-2</sup>, or 3.75.

All of these floating-point literals have a decimal value of `12.1875`:

```swift
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0
```

Numeric literals can contain extra formatting to make them easier to read. Both integers and floats can be padded with extra zeros and can contain underscores to help with readability. Neither type of formatting affects the underlying value of the literal:

```swift
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1
```

### Numeric Type Conversion

Use the `Int` type for all general-purpose integer constants and variables in your code, even if they are known to be non-negative. Using the default integer type in everyday situations means that integer constants and variables are immediately interoperable in your code and will match the inferred type for integer literal values.

Use other integer types only when they are specifically needed for the task at hand, because of explicitly-sized data from an external source, or for performance, memory usage, or other necessary optimization. Using explicitly-sized types in these situations helps to catch any accidental value overflows and implicitly documents the nature of the data being used.

#### Integer Conversion

The range of numbers that can be stored in an integer constant or variable is different for each numeric type. An `Int8` constant or variable can store numbers between `-128` and `127`, whereas a `UInt8` constant or variable can store numbers between `0` and `255`. A number that will not fit into a constant or variable of a sized integer type is reported as an error when your code is compiled:

```swift
let cannotBeNegative: UInt8 = -1
// UInt8 cannot store negative numbers, and so this will report an error
let tooBig: Int8 = Int8.max + 1
// Int8 cannot store a number larger than its maximum value,
// and so this will also report an error
```

Because each numeric type can store a different range of values, you must opt in to numeric type conversion on a case-by-case basis. This opt-in approach prevents hidden conversion errors and helps make type conversion intentions explicit in your code.

To convert one specific number type to another, you initialize a new number of the desired type with the existing value. In the example below, the constant `twoThousand` is of type `UInt16`, whereas the constant `one` is of type `UInt8`. They cannot be added together directly, because they are not of the same type. Instead, this example calls `UInt16(one)` to create a new `UInt16` initialized with the value of `one`, and uses this value in place of the original:

```swift
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
```

Because both sides of the addition are now of type `UInt16`, the addition is allowed. The output constant (`twoThousandAndOne`) is inferred to be of type `UInt16`, because it is the sum of two `UInt16` values.

`SomeType(ofInitialValue)` is the default way to call the initializer of a Swift type and pass in an initial value. Behind the scenes, `UInt16` has an initializer that accepts a `UInt8` value, and so this initializer is used to make a new `UInt16` from an existing `UInt8`. You can’t pass in any type here, however—it has to be a type for which `UInt16` provides an initializer. Extending existing types to provide initializers that accept new types (including your own type definitions) is covered in [Extensions]().

#### Integer and Floating-Point Conversion

Conversions between integer and floating-point numeric types must be made explicit:

```swift
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
// pi equals 3.14159, and is inferred to be of type Double
```

Here, the value of the constant `three` is used to create a new value of type `Double`, so that both sides of the addition are of the same type. Without this conversion in place, the addition would not be allowed.

Floating-point to integer conversion must also be made explicit. An integer type can be initialized with a `Double` or `Float` value:

```swift
let integerPi = Int(pi)
// integerPi equals 3, and is inferred to be of type Int
```

Floating-point values are always truncated when used to initialize a new integer value in this way. This means that `4.75` becomes `4`, and `-3.9` becomes `-3`.

> The rules for combining numeric constants and variables are different from the rules for numeric literals. The literal value `3` can be added directly to the literal value `0.14159`, because number literals do not have an explicit type in and of themselves. Their type is inferred only at the point that they are evaluated by the compiler.

### Type Aliases

Type aliases define an alternative name for an existing type. You define type aliases with the `typealias` keyword.

Type aliases are useful when you want to refer to an existing type by a name that is contextually more appropriate, such as when working with data of a specific size from an external source:

```swift
typealias AudioSample = UInt16
```

Once you define a type alias, you can use the alias anywhere you might use the original name:

```swift
var maxAmplitudeFound = AudioSample.min
// maxAmplitudeFound is now 0
```

Here, `AudioSample` is defined as an alias for `UInt16`. Because it is an alias, the call to `AudioSample.min` actually calls `UInt16.min`, which provides an initial value of `0` for the `maxAmplitudeFound` variable.

### Booleans

Swift has a basic Boolean type, called `Bool`. Boolean values are referred to as logical, because they can only ever be true or false. Swift provides two Boolean constant values, `true` and `false`:

```swift
let orangesAreOrange = true
let turnipsAreDelicious = false
```

The types of `orangesAreOrange` and `turnipsAreDelicious` have been inferred as `Bool` from the fact that they were initialized with Boolean literal values. As with `Int` and `Double` above, you don’t need to declare constants or variables as `Bool` if you set them to `true` or `false` as soon as you create them. Type inference helps make Swift code more concise and readable when it initializes constants or variables with other values whose type is already known.

Boolean values are particularly useful when you work with conditional statements such as the `if` statement:

```swift
if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}
// Prints "Eww, turnips are horrible."
```

Conditional statements such as the `if` statement are covered in more detail in [Control Flow]().

Swift’s type safety prevents non-Boolean values from being substituted for `Bool`. The following example reports a compile-time error:

```swift
let i = 1
if i {
    // this example will not compile, and will report an error
}
```

However, the alternative example below is valid:

```swift
let i = 1
if i == 1 {
    // this example will compile successfully
}
```

The result of the `i == 1` comparison is of type Bool, and so this second example passes the type-check. Comparisons like `i == 1` are discussed in [Basic Operators]().

As with other examples of type safety in Swift, this approach avoids accidental errors and ensures that the intention of a particular section of code is always clear.

### Tuples

Tuples group multiple values into a single compound value. The values within a tuple can be of any type and do not have to be of the same type as each other.

In this example, `(404, "Not Found")` is a tuple that describes an HTTP status code. An HTTP status code is a special value returned by a web server whenever you request a web page. A status code of `404 Not Found` is returned if you request a webpage that doesn’t exist.

```swift
let http404Error = (404, "Not Found")
// http404Error is of type (Int, String), and equals (404, "Not Found")
```

The `(404, "Not Found")` tuple groups together an `Int` and a `String` to give the HTTP status code two separate values: a number and a human-readable description. It can be described as “a tuple of type `(Int, String)`”.

You can create tuples from any permutation of types, and they can contain as many different types as you like. There’s nothing stopping you from having a tuple of type `(Int, Int, Int)`, or `(String, Bool)`, or indeed any other permutation you require.

You can decompose a tuple’s contents into separate constants or variables, which you then access as usual:

```swift
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// Prints "The status code is 404"
print("The status message is \(statusMessage)")
// Prints "The status message is Not Found"
```

If you only need some of the tuple’s values, ignore parts of the tuple with an underscore (`_`) when you decompose the tuple:

```swift
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
// Prints "The status code is 404"
```

Alternatively, access the individual element values in a tuple using index numbers starting at zero:

```swift
print("The status code is \(http404Error.0)")
// Prints "The status code is 404"
print("The status message is \(http404Error.1)")
// Prints "The status message is Not Found"
```

You can name the individual elements in a tuple when the tuple is defined:

```swift
let http200Status = (statusCode: 200, description: "OK")
```

If you name the elements in a tuple, you can use the element names to access the values of those elements:

```swift
print("The status code is \(http200Status.statusCode)")
// Prints "The status code is 200"
print("The status message is \(http200Status.description)")
// Prints "The status message is OK"
```

Tuples are particularly useful as the return values of functions. A function that tries to retrieve a web page might return the `(Int, String)` tuple type to describe the success or failure of the page retrieval. By returning a tuple with two distinct values, each of a different type, the function provides more useful information about its outcome than if it could only return a single value of a single type. For more information, see [Functions with Multiple Return Values]().

> Tuples are useful for temporary groups of related values. They are not suited to the creation of complex data structures. If your data structure is likely to persist beyond a temporary scope, model it as a class or structure, rather than as a tuple. For more information, see [Classes and Structures]().

### Optionals

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

#### If Statements and Forced Unwrapping

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

#### Optional Binding

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

#### Implicitly Unwrapped Optionals

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

### Error Handling

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

### Assertions

In some cases, it is simply not possible for your code to continue execution if a particular condition is not satisfied. In these situations, you can trigger an assertion in your code to end code execution and to provide an opportunity to debug the cause of the absent or invalid value.

#### Debugging with Assertions

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

#### When to Use Assertions

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