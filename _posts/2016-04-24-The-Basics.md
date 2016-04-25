---
layout: post
title:  "Swift 2.2: 기초(The Basics)"
date:   2016-04-24 19:45:00 +0900
categories: Xcode Swift Grammar Basic
---

* a new programming language : iOS, OS X, watchOS, tvOS

- familiar from C and Objective-C
- all fundamental C and Objective-C types : `Int`, `Double`, `Float`, `Bool`, `String`
- the three primary collection types : `Array`, `Set`, `Dictionary`

* advanced types : tuples, optional types
    - tuples : return multiple values
    * optional types : handle the absence of a value - similar to using `nil`
    * work for any type, not just classes
    * safer and more expressive than `nil`

- **a type-safe language** : the langage halps you to be clear about the types of values
- type safety helps you fix errors as early as possible in the develoment process

### Constants and Variables

* associate a name with a value of a particular type

- constant : cannot be changed once it is set
- variable : can be set to a different value in the future


#### Declaring Constants and Variables

* must be declared before they are used
* `let` : declare constants
* `var` : declare variables

```swift
let maximumNumbeOfLoginAttemps = 10

var currentLoginAttempt = 0
```

* declare multiple constants or variables on a single line, separated by commas

```swift
var x = 0.0, y = 0.0, z = 0.0
```

> note:
If a stored value is not going to change, always declare it as a constant


#### Type Annotations

* a type annotation : to be clear about the kind of values

```swift
var welcomeMessage: String
```

* the colon : means "...of type..."
* "of type `String` : "can store any `String` value"

```swift
welcomeMessage = "Hello"
```

* define multiple related variables of the same type on a single line

```swift
var red, green, blue: Double
```

> note:
It is rare that you need to write type annotation
If you provide an initial value, Swift can almost always infer the type


#### Naming Constants and Variables

* names can contain almost any character - including **Unicode** characters

```swift
let π = 3.14159

let 你好 = "你好世界"

let 🐶🐮 = "dogcow"
```

* cannot contain
    * whitespace characters
    * mathematical symbols
    * arrows
    * private-use (invalid) Unicode code points
    * line-drawing, box-drawing characters

- cannot
    * begin with a number : numbers may be included elsewhere

* cannot
    * redeclare it again with the same name
    * change it to store values of a different type
    * change a constant into a variable
    * change a variable into a constant

> note:
the same name as a reserved Swift keyword : back ticks (\`) - however, avoid using keyword

* can change the value of an existing variable to another value of a compatible type

```swift
var friendlyWelcome = "Hello!"

friendlyWelcome = "Bonjour!"

// friendlyWelcome is now "Bonjour!"
```

* the value of a constant cannot be changed

```swift
let languageName = "Swift"

// languageName = "Swift++"

// this is a compile-time error - languageName connot be changed
```


#### Printing Constants and Variables

* `print(_:seperator:terminator:)` : print the current value

```swift
print(friendlyWelcome)

// Prints "Bonjour!"
```

* a global function : its output in Xcode's "console" pane
* `serperator`, `terminator` : default value - adding a line break
* `print(someValue, terminator: "")` : pass an empty strings as the terminator

- string interpolation : include the name as a placeholder in a longer string

```swift
print("The current value of friendlyWelcome is \(friendlyWelcome)")

// Prints "The current values of friendlyWelcome is Bonjour!"
```


### Comments

* nonexecutable text : ingored by the Swift compiler
- similar to comments in C
- single-line comments : `//`

```swift
// this is a comment
```

* multiline comments : `/*` ... `*/`

```swift
/* this is also a comment,

   but written over multiple lines */
```

* multiline comments in Swift can be nested

```swift
/* this is the start of the first multiline comment

   /* this is the second, nested multiline comment */

   this is the end of the first multiline comment */
```

* nested multiline comments : comment out large blocks of code quickly and easily


### Semicolons

* not require : a semicolon(`;`) after each statment
* are required : multiple statements on a single line

```swift
let cat = "🐱"; print(cat)

// Prints "🐱"
```


### Integers

* numbers with no fractional component

- signed and unsigned integers in 8, 16, 32, and 64 bit forms
- naming convention similar to C : have capitalized names
- `UInt8` : an 8-bit unsigned integer
- `Int32` : a 32-bit signed integer


#### Integer Bounds

* `min`, `max` : access the minimum and maximum values of integer type

```swift
let minValue = UInt8.min // minValue is equal to 0, and is of type UInt8

let maxValue = UInt8.max // maxValue is equal to 255, and is of type UInt8
```

* the appropriate-sized number type : used in expressions of the same type


#### Int

* don't need to pick a specific size of integer
* `Int` : the same size as the current platform's native word size

  - 32-bit platform : `Int == Int32`
  - 64-bit platform : `Int == Int64`

* use `Int` : code consistency and interoperability


### UInt

* `UInt` : the same size as the current platform's native word size
  - 32-bit platform : `UInt == UInt32`
  - 64-bit platform : `UInt == UInt64`

> note:
`UInt` : only when you specially need
`Int` : preferred - code interoperability, avoids the need to convert, matches integer type inference


### Floating-Point Numbers

* numbers with a fractional component
- a much wider range of values than integer types
* Swift : two signed floating-point number types
* `Double` : a 64-bit floating-point number
* `Float` : a 32-bit floating-point number

> note:
`Double` : 15 decimal digits
`Float` : 6 decimal digits
If either type would be appropriate, `Double` is preferred


### Type Safety and Type Inference

* **type-safe** language : be clear about the types of values

- **type checks** : when compiling and flags any mismatched types as errors
- catch and fix errors as early as possible

* **type inference** : a compiler deduce the type of a particular expression automatically

- Swift requires far fewer type declarations

* useful with an initial value : **literal value** (or **literal**) - appears directly in source code

- assign a literal value of `42` : `Int`

```swift
let meaningOfLife = 42

// meaningOfLife is infered to be of type Int
```

* a floating-point literal : `Double`

```swift
let pi_1 = 3.14159

// pi is inferred to be of type Double
```

* Swift always chooses `Double` (rather than `Float`)

- combine integer and floating-point literals : `Double` will be inferred

```swift
let anotherPi = 3 + 0.14159

// anotherPi is also inferred to be of type Double
```

* `3` has no explicit type : a floating-point literal as part of the addtion


### Numeric Literals

* Integer literals
    * no prefix : a deimal
    * `0b` prefix : a binary
    * `0o` prefix : an octal
    * `0x` prefix : a hexadecimal

- a decimal value of `17`

```swift
let decimalInteger = 17

let binaryInteger = 0b10001      // 17 in binary notation

let octalInteger = 0o21         // 17 in octal notation

let hexadecimalInteger = 0x11   // 17 in hexadecimal notation
```

* Floating-point literals : decimal or hexadecimal
* must always have a number on both sides of the decimal point
* decimal floats : an optional exponent : `e`
* hexadecimal floats : must have an exponent `p`

- decimal numbers
    - `1.25e2` : 1.25 x 10^2 - 125.0
    - `1.25e-2` : 1.25 x 10^-2 - 0.0125

* hexadecimal numbers
    * `0xFp2` : 15 x 2^2 - 60.0
    * `0xFp-2` : 15 x 2^-2 - 3.75

- a decimal value of `12.1875`

```swift
let decimalDouble = 12.1875

let exponentDouble = 1.21875e1

let hexadecimalDouble = 0xC.3p0
```

* numeric literals : extra formatting - easier to read
* padded with extra zeros
* underscores to help with readability

```swift
let paddedDouble = 000123.456

let oneMillion = 1_000_000

let justOverOneMillion = 1_000_000.000_000_1
```


### Numeric Type Conversion

* `Int` type : all general-purpose integer
* immediately interoperable
* match the inferred type for integer literal values

- use other integer types only when they are specifically needed
- using explicitly-sized types : catch any accidental value overflows


#### Integer Convension

* the range of numbers is different for each numeric type
* a number that will not fit is reported as an error

```swift
// let cannotBeNegative: UInt8 = -1

// UInt8 cannot store negative numbers, and so  this will report an error

// let tooBig: Int8 = Int8.max + 1

// Int8 cannot store a number larger than its maximum value, and so this will also report an error
```

* opt-in approach : make type conversion intentions explicit

- to convert : initialize a new number of the desired type with the existing value

```swift
let twoThousand: UInt16 = 2_000

let one: UInt8 = 1

let twoThousandAndOne = twoThousand + UInt16(one)
```

* `UInt16` has an initializer that accepts a `UInt8` value - can't pass in any type

- `Extensions` : extending existing types to provide initializers that accept new types


#### Integer and Floating-Point Conversion

* conversions between integer and floating-point numeric types : explicit

```swift
let three = 3

let pointOneFourOneFiveNine = 0.14159

let pi = Double(three) + pointOneFourOneFiveNine

// pi equals 3.14159, and is inferred to be of type Double
```

* create a new value of type `Double`

- floating-point to integer conversion : also explicit

```swift
let integerPi = Int(pi)

// integerPi equals 3, and is inferred to be of type Int
```

* floating-point value are always truncated

> note:
number literals : do not have an explicit type
their type is inferred only at the point that they are evaluated by the compiler


### Type Aliases

* `typealias` : define an alternative name for an existing type
* a name that is contextually more appropriate

```swift
typealias AudioSample = UInt16
```

* can use the alias anywhere you might use the original name

```swift
var maxAmplitudeFound = AudioSample.min

// maxAmplitudeFound is now 0
```

* `AudioSample.min == UInt16.min`


### Booleans

* `Bool` : a basic Boolean type
* boolean values : logical - ever be true or false
* two Boolean constant values : `true`, `false`

```swift
let orangesAreOrange = true

let turnipsAreDelicious = false
```

* initialized with Boolean literal values : type inference

- particularly useful with conditional statements : `if`

```swift
if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}

// Prints "Eww, turnips are horrible."
```

* prevents non-Boolean values from being substituted for `Bool` : type safety
* a compile-time error

```swift
/*
let i = 1

if i {
    // this example will not compile, and will report an error
}
*/
```

* valid

```swift
let i = 1

if i == 1 {
    // this example will compile successfully
}
```

* this second example passes the type-check : `i == 1` - `Bool`

- type safety : avoids accidental errors, code is always clear


### Tuples

* **Tuples** : group multiple values into a single compound value
* the values within a tuple can be of any type

- an HTTP status code : `(404, "Not Found")`

```swift
let http404Error = (404, "Not Found")

// http404Error is of type (Int, String), and equals (404, "Not Found")
```

* a tuple of type `(Int, String)`

- any permutation of types
- many different types

* decompose a tuple's contents

```swift
let (statusCode, statusMessage) = http404Error

print("The status code is \(statusCode)")

// Prints "The status code is 404"

print("The status message is \(statusMessage)")

// Prints "The status message is Not Found"
```

* ignore parts of the tuple : an underscore(`_`)

```swift
let (justTheStatusCode, _) = http404Error

print("The status code is \(justTheStatusCode)")

// Prints "The status code is 404"
```

* access the individual element values using index numbers starting at zero

```swift
print("The status code is \(http404Error.0)")

// Prints "The status code is 404"

print("The status message is \(http404Error.1)")

// Prints "The status message is Not Found"
```

* name the individual elements when the tuple is defined

```swift
let http200Status = (statusCode: 200, description: "OK")
```

* use the element names to access the values

```swift
print("The status code is \(http200Status.statusCode)")

// Prints "The status code is 200"

print("The status message is \(http200Status.description)")

// Prints "The status message is OK"
```

* particularly useful as the return values of functions

> note:
 useful for temporary groups of related values
 not suited to the creation of complex data structures : persist beyond a temprary scope


### Optionals

* optionals : a value may be absent
    * there *is* a value, and it equals *x*
    * there *isn't* a value at all

> note:
 `nil` : the absence of a valid object - only works for objects
 Swift's optionals : the absence of a value for any type at all

* `String` into an `Int`

```swift
let possibleNumber = "123"

let convertedNumber = Int(possibleNumber)

// convertedNumber is inferred to be of type "Int?", or "optional Int"
```

* an optional `Int` : `Int?` - some `Int` or no value at all


#### nil

* set an optional variable to a valueless state : `nil`

```swift
var serverResponseCode: Int? = 404

// serverResponseCode contains an actual Int value of 404

serverResponseCode = nil

// serverResponseCode now contains no value
```

> note:
 `nil` : cannot be used with nonoptional constants and variables

* without providing a default value : automatically set to `nil`

```swift
var surveyAnswer: String?

// surveyAnswer is automatically set to nil
```

> note:
 In Objective-C : `nil` - a point to a nonexistent object
 In Swift : `nil` - not a pointer, the absence of a value of a certain type


#### If Statements and Forced Unwrapping

* `if` statement : find out whether an optional contains a value
* by comparing the optional against `nil` - `==`, `!=`

- if an optional has a value : not equal to `nil`

```swift
if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}

// Prints "convertedNumber contains some integer value."
```

* access its underlying value : an exclamation mark(`!`)
* optional definitely has a value : **forced unwrapping**

```swift
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}

// Prints "convertedNumber has an integer value of 123."
```

> note:
 use `!` to access a nonexistent optional value : a runtime error
 make sure that an optional contains a non-`nil` value before using `!`


#### Optional Binding

* **optional binding** : find out whether an optional contains a value
* to make that value avaiable as a temporary constant or variable
* `if`, `while` statements : check, extract - a single action

- an optional binding for an `if` statement

```text
 if let constantName = someOptional {
    statements
 }
```

```swift
if let actualNumber = Int(possibleNumber) {
    print("\"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("\"\(possibleNumber)\" could not be converted to an integer")
}

// Prints ""123" has an integer value of 123"
```

* initialized with the value contained within the optional : no need to use the  `!` suffix

- both constants and variables with optional binding
- `if var` : the value as a variable rather than a constant

* multiple optional bindings in a single `if` statement
* `where` : check for a Boolean condition
* the values are `nil` or the `where` clause evaluates to `false` : unsuccessful

```swift
if let firstNumber = Int("4"), secondNumber = Int("42") where firstNumber < secondNumber {
    print("\(firstNumber) < \(secondNumber)")
}

// Prints "4 < 42"
```

> note:
 constants and variables created with optional binding in an `if` statement :
 available only within the body
 constants and variables created with a `guard` statement :
 available in the lines of code that follow the `guard` statement


#### Implicitly Unwrapped Optionals

* sometimes an optional will always have a value
* useful to remove the need to check and unwrap the optional's value
* because it can be safely assumed to have a value

- **implicitly unwrapped optionals** : by placing an exclamation mark after the type

* useful when an optional's value is confirmed to exist
* the primary use of implicitly unwrapped optional : during class initialization

- an implicitly unwrapped optional
    - a normal optional
    - also be used like a nonoptoinal value : without the need to unwrap
- the difference between an optional string and an implicitly unwrapped optional string

```swift
let possibleString: String? = "An optional string."

let forcedString: String = possibleString! // requires an exclamation mark

let assumedString: String! = "An implicitly unwrapped optional string."

let implicitString: String = assumedString // no need for an exclamation mark
```

* as giving permission for the optional to be unwrapped automatically
* place an exclamation mark after the optional's type

> note:
 if an implicitly unwrapped optional is `nil` and try to access its wrapped value
 trigger a runtime error

* still treat an implicitly unwrapped optional like a normal optional

```swift
if assumedString != nil {
    print(assumedString)
}

// Prints "An implicitly unwrapped optional string."
```

* also an implicitly unwrapped optional with optional binding

```swift
if let definiteString = assumedString {
    print(definiteString)
}

// Prints "An implicitly unwrapped optional string."
```

> note:
 do not use an implicitly unwrapped optional when there is a possibility of a variable becoming `nil`


### Error Handling

* **error handling** : to respond to error conditions
* to determine the underlying cause of failure
* to propagate the error to another part of the program

- a function : *throws* an error
- the function's caller : *catch* the error and respond

```swift
func canThrowAnError() throws {
    // this function may or may not throw an error
}
```

* `throws` : indicates that it can throw an error
* `try` : when you call a function that can throw an error

- Swift automatically propagates errors : until handled by a `catch` clause

```text
do {
    try canThrowAnError()
    // no error was thrown
} catch {
    // an error was thrown
}
```

* `do` statement : creates a new containing scope : allows errors to be propagated

```swift
// additional code - start

enum Error: ErrorType {
    case OutOfCleanDishes
    case MissingIngredients(ingredients: [String])
}

func eatASandwich() {
    print("Eat")
}

func washDishes() {
    print("Wash the Dishes!")
}

func buyGroceries(ingredients: [String]) {
    print("Buy some ", terminator: "")

    for item in ingredients {
        print("\(item)", terminator: "")
        if item != ingredients.last {
            print(", ", terminator: "")
        }
    }
    print(".")
}

func makeASandwich() throws {
    let isDishClean = true
    let haveIngredients = false

    guard isDishClean else {
//        throw Error.OutOfCleanDishes
    }

    guard haveIngredients else {
        throw Error.MissingIngredients(ingredients: ["pepper, salt", "water"])
    }

//    print("a sandwich!")
}

// additional code - end

do {
    try makeASandwich()
    eatASandwich()
} catch Error.OutOfCleanDishes {
    washDishes()
} catch Error.MissingIngredients(let ingredients) {
    buyGroceries(ingredients)
}
```

* `makeASandwich()` : throw an error - the function call is wrapped in a `try` expression
* `do` statement : any errors will be propagated to the provided `catch` clauses


### Assertions

* in some cases : not possible to continue if a particular condition is not satisfied
* trigger an *assertion* : to end code execution and to provide an opportunity to debug


#### Debugging with Assertions

* an assertion
    * a runtime check that a Boolean condition definitely evaluates to `true`
    * an essential condition is satisfied before executing any further code
    * `true` : code execution continues as usual
    * `false` : code execution ends, your app is terminated

- in a debug environment
    - when you build an run an app in Xcode
    - exaltly where the invalid state occured and query the state of your app
    - privide a suitable debug message

* `assert(_:_:file:line:)` : the Swift standard library global function

```swift
let age = -3

// assert(age >= 0, "A person's age cannot be less than zero")

// this causes the asertion to trigger, because age is not >= 0
```

* code execution will continue only if `age >= 0` evaluates to `true`
* the assertion is triggered, terminating the application

```swift
// assert(age >= 0)
```

> note:
 assertions are disabled : code is compiled with optimizations
 when building with an app target's default Release configuration in Xcode


#### When to Use Assertions

* whenever a condition has the potential to be false : definitely be true
* suitable scenarios
    * subscript index value could be too low or too high
    * an invalid argument value means the function connot fulfill its task
    * a not-`nil` optional value is essential for sebsequent code

> note:
 assertions cause your app to terminate and are not a substitute
 an assertion is an effective way during development, before your app is published
