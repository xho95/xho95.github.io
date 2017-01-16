---
layout: post
comments: true
title:  "Swift 2.2: 기초 연산자(Basic Operators)"
date:   2016-04-24 19:45:00 +0900
categories: Swift Grammar Basic Operators
---

* operator : a special symbol or phrase - check, change, or combine values
- supports most standard C operators
- improves
    - the assignment operator(`=`) : does not return a value
    - arithmetic operators : detect and disallow value overflow - Swift's overflow operators
* unlike C
    * remainder(`%`) : calculations on floating-point numbers
    * two range operators : `a..<b` and `a...b`
- Advanced Operators
    - how to define custom operators
    - implement the standard operators for custom types


### Terminology

* unary, binary, or ternary
* unary : on a single target - `-a`
    * unary prefix operators : immediately before their target - `!b`
    * unary postfix operators : immediately after their target - `c!`
- binary : on two targets - `2 + 3`
    - infix : between their two targets
* ternary : on three targets
    * only one ternary operator : the ternary conditional operator - `a ? b : c`
- operands : the values that operators affect
    - `1 + 2` : `+` - a binary operator, `1`, `2` - two operands


### Assignment Operator

* the assignment operator : `a = b` - initializes or updates the value

```swift
let b = 10

var a_1 = 5

a_1 = b

// a is now equal to 10
```

* a tuple : its elements can be decomposed

```swift
let (x, y) = (1, 2)

// x is equal to 1, and y is equal to 2
```

* the assignment operator in Swift : does not itself return a value

```swift
if x = y {
    // this is not valid, because x = y does not return a value
}
```

* prevents `=` from being used by accident when `==` is intended
* Swift helps you to avoid these kinds of errors


### Arithmetic Operators

* the four standard arithmetic operators : for all number types
    * addtion : `+`
    * subtraction : `-`
    * multiplication : `*`
    * division : `/`

```swift
1 + 2       // equals 3

5 - 3       // equals 2

2 * 3       // equals 6

10.0 / 2.5  // equals 4.0
```

* Swift arithmetic operators : do not allow values to overflow by default
* value overflow behavior : by using Swift's overflow operators
- the addition operator : supported for `String` concatenation

```swift
"Hello, " + "world"     // equals "hello, world"
```


#### Remainder Operator

* the remainder operator : `a % b` - returns the value that is left over (the remainder)

> note:
 the remainder operator : `%` - modulo operator in other languages
 its behavior in Swift for negative numbers : a remainder rather than a modulo operation

```swift
9 % 4       // equals 1
```

* `a % b`
* `a = (b x some multiplier) + remainder`
* `9 = (4 x 2) + 1`
- the remainder for a negative value

```swift
-9 % 4      // equals -1
```

* `-9 = (4 x -2) + -1`
- the sign of `b` is ignored for negative values
- `a % b`, `a % -b` : always give the same answer


#### Floating-Point Remainder Calculations

* Swift's remainder operator : can also operate on floating-point numbers

```swift
8 % 2.5     // equals 0.5
```

```text
* `8 = (2.5 x 3) + 0.5`
```


#### Unary Minus Operator

* the unary minus operator : `-` - the sign of a numeric value can be toggled

```swift
let three = 3

let minusThree = -three         // minusThree equals -3

let plusThree = -minusThree     // plusThree equals 3, or "minus minus three"
```

* prepended directly before the value : without any white space


#### Unary Plus Operator

* the unary plus operator : `+` - simply returns the value, without any change

```swift
let minusSix = -6

let alsoMinusSix = +minusSix    // alsoMinusSix equals -6
```

* doesn't do anything : use it to provide symmetry in code


### Compound Assignment Operators

* compound assignment operators : combine assignment (`=`) with another operation
* the additional assignment operator : `+=`

```swift
var a_2 = 1

a_2 += 2

// a is now equal to 3
```

* `a += 2` : shorthand for `a = a + 2`

> note:
 the compound assignment operators do not return a value
 cannot write `let b = a += 2`


### Comparison Operators

* Swift : supports all standard C comparison operators
    * equal to : `a == b`
    * not equal to : `a != b`
    * greater than : `a > b`
    * less than : `a < b`
    * greater than or equal to : `a >= b`
    * less than or equal to : `a <= b`

> note:
 Swift : two identity operators `===`, `!==`
 to test whether two object references both refer to the same object instance

* the comparison operators : return a `Bool` value

```swift
1 == 1      // true because 1 is equal to 1

2 != 1      // true because 2 is not equal to 1

2 > 1       // true because 2 is greater than 1

1 < 2       // true because 1 is less than 2

1 >= 1      // true because 1 is greater than or equal to 1

2 <= 1      // false because 2 is not less than or equal to 1
```

* often used in conditional statements : `if` statement

```swift
let name = "world"

if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}

// prints "hello, world", because name is indeed equal to "world"
```

* compare tuples
    * as long as each of the values can be compared
    * `Bool` : can't be compared - tuples that contain a Boolean value can't be compared
    - compared from left to right, one value at a time,
    - if all the elements are equal : the tuples themselves are equal

```swift
(1, "zebra") < (2, "apple")     // true because 1 is less than 2

(3, "apple") < (3, "bird")      // true because 2 is equal to 3, and "apple" is less than "bird"

(4, "dog") == (4, "dog")        // true because 4 is equal to 4, and "dog" is equal to "dog"
```

> note:
 tuple comparison operators for tuples : less than seven elements
 to compare tuples with seven or more elements : implement the operators yourself


### Ternary Conditional Operator

* the ternary conditional operator : a special operator with three parts
* `question ? answer1 : answer2`

```text
if question {
    answer1
} else {
    answer2
}
```

* an example

```swift
let contentHeight_1 = 40

let hasHeader_1 = true

let rowHeight_1 = contentHeight_1 + (hasHeader_1 ? 50 : 20)

// rowHeight_1 is equal to 90
```

* the preceding example is shorthand for the code below

```swift
let contentHeight_2 = 40

let hasHeader_2 = true

let rowHeight_2: Int

if hasHeader_2 {
    rowHeight_2 = contentHeight_2 + 50
} else {
    rowHeight_2 = contentHeight_2 + 20
}

// rowHeight_2 is equal to 90
```

* the ternary conditional operator
    * set to the correct value on a single line of code
    * removes the need for `rowHeight` to be a variable
    - provides an efficient shorthand
    - can lead to hard-to-read code if overused
    - avoid combining multiple instances of the ternary conditional operator


### Nil Coalescing Operator

* the nil coalescing operator : `a ?? b` - unwraps `a` or returns `b`
* the expression `a` is always of an optional type
- shorthand for the code below

```text
a != nil ? a! : b
```

* the ternary conditional operator + forced unwrapping = the nil coalescing operator

> note:
 if the `a` is non-`nil`, `b` is not evaluated : short-circuit evaluation

* the example

```swift
let defaultColorName = "red"

var userDefinedColorName: String?   // defaults to nil

var colorNameToUse = userDefinedColorName ?? defaultColorName

// userDefinedColorName is nil, so colorNameToUse is set to the default of "red"
```

* a non-`nil` value

```swift
userDefinedColorName = "green"

colorNameToUse = userDefinedColorName ?? defaultColorName

// userDefinedColorName is not nil, so colorNameToUse is set to "green"
```


### Range Operators

* two range operators : shortcuts for expressing a range of values


#### Closed Range Operator

* the closed range operator : `a...b` - from `a` to `b`, includes the value `a` and `b`
    * `a` must not be greater than `b`
- useful when all of the values to be used : `for-in` loop

```swift
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

// 1 times 5 is 5
// 2 times 5 is 10
// 3 times 5 is 15
// 4 times 5 is 20
// 5 times 5 is 25
```


#### Half-Open Range Operator

* the half-open range operator : `a..<b` - from `a` to `b`, but does not include `b`
    * _half-open_ : it contains its first value, but not its final value
    * `a` must not be greater that `b`
    * `a` is equal to `b` : the resulting range will be empty
- particularly useful with zero-based lists
- to count up to (but not including) the length of the list

```swift
let names = ["Anna", "Alex", "Brian", "Jack"]

let count = names.count

for i in 0..<count {
    print("Person \(i + i) is called \(names[i])")
}

// Person 1 is called Anna
// Person 2 is called Alex
// Person 3 is called Brian
// Person 4 is called Jack
```


### Logical Operators

* logical operators : modify or combine the Boolean logic values `true` and `false`
* Swift : three standard logical operators
    * Logical NOT : `!a`
    * Logical AND : `a && b`
    * Logical OR : `a || b`


#### Logical NOT Operator

* the logical NOT operator : `!a` - inverts a Boolean value
- a prefix operator : immediately before the value, without any white space - "not `a`"

```swift
let allowedEntry = false

if !allowedEntry {
    print("ACCESS DENIED")
}

// Prints "ACCESS DENIED"
```

* careful choice of Boolean constant and variable names : to keep code readable and concise


#### Logical AND Operator

* the logical AND operator : `a && b` - creates logical expressions
    * both values must be `true` for the overall expression also be `true`
- either value is `false` : the overall expression will also be `false`
- the first value is `false` : the second value  won't even be evaluated - **short-circuit evaluation**

```swift
let enteredDoorCode = true

let passedRetinaScan = false

if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

// Prints "ACCESS DENIED"
```


#### Logical OR Operator

* the logical OR operator : `a || b` - an infix operator, create logical expressions
    * only one of the two values has to be `true` for the overall expression to be `true`
- short-circuit evaluation : if the left side is `true`, the right side is not evaluated

```swift
let hasDoorKey = false

let knowsOverridePassword = true

if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

// Prints "Welcome!"
```


#### Combining Logical Operators

* combine multiple logical operators to create longer compound expressions

```swift
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

// Prints"Welcome!"
```

* this is actually three smaller expressions chained together

> note:
 the Swift logical operators : left-associative - evaluate the leftmost subexpression first


#### Explicit Parentheses

* sometimes useful to include parentheses : a complex expression easier to read

```swift
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

// Prints "Welcome!"
```

* the output doesn't change : the overall intention is clearer
* readability is always preferred over brevity : use parentheses
