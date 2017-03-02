## 기초 연산자 (Basic Operators)

연산자는 값을 검사하고, 바꾸거나 결합하는데 사용하는 특별한 기호 또는 구절입니다. 예를 들어 덧셈 연산자 (`+`) 는 `let i = 1 + 2` 에서 보듯이 두 수를 더하고, 논리 AND 연산자 (`&&`) 는 `if enteredDoorCode && passedRetinaScan` 에서 보듯이 두 불 (Boolean) 값을 결합합니다.

Swift 는 대부분의 표준 C 연산자를 지원하면서 자주 발생하는 코딩 에러를 없애기 위해 몇가지 기능들을 향상시켰습니다. 대입 연산자는 (`=`) 는 값을 반환하지 않도록 해서 동등 비교 연산자 (`==`) 가 있어야 할 곳에서 실수로 사용되지 않도록 해줍니다. 산술 연산자들 (`+`, `-`, `*`, `/`, `%` 등) 은 값이 넘치는 것을 감지하고 막아주는데, 이는 수를 다룰 때 결과가 예상치 못하게 타입이 허용하는 범위보다 더 작거나 크지 않도록 해 줍니다. Swift 의 넘침 (overflow) 연산자를 사용하면 값이 넘칠 수 있도록 직접 지정할 수 있습니다. 이는 [Overflow Operators]() 에서 설명하고 있습니다.

Swift 는 또 C 에서는 없는 두 개의 범위 연산자 (`a..<b` 와 `a...b`) 를 제공하는데, 이는 값의 범위를 손쉽게 표현하게 해 줍니다.

이번 장에서는 Swift 에 있는 보통의 연산자에 대해 설명합니다. [Advanced Operators]() 에서는 Swift 의 고급 연산자를 다루면서, 사용자 정의 연산자를 정의하는 방법과 사용자 정의 타입을 위한 표준 연산자를 구현하는 방법에 대해서 설명합니다.

### 용어 (Terminology)

연산자에는 단항, 이항, 삼항 연산자가 있습니다:

* 단항 연산자는 (`-a` 와 같이) 단일 대상에 대해 동작합니다. 단항 접두 연산자는 (`!b` 와 같이) 대상 바로 앞에 위치하고, 단항 접미 연산자는 (`c!` 처럼) 대상 바로 뒤에 위치합니다. [^appear]
* 이항 연산자는 (`2 + 3` 과 같이) 두 개의 대상에 대해 동작하며 두 대상 사이에 위치하므로 중위 (infix) 라고 합니다. [^infix]
* 삼항 연산자는 세 개의 대상에 대해 동작합니다. C 와 같이 Swift 에는 단 한 개의 삼항 연산자가 있는데, 삼항 조건 연산자 (`a ? b : c`) 가 바로 그것입니다.

연산자가 영향을 미치는 값을 피연산자 (operands) 라고 합니다. 가령 `1 + 2` 라는 식에서 `+` 기호는 이항 연산자이고 두 피연산자는 값 `1` 과 `2` 입니다.

### Assignment Operator

The assignment operator (`a = b`) initializes or updates the value of `a` with the value of `b`:

```swift
let b = 10
var a = 5
a = b
// a is now equal to 10
```

If the right side of the assignment is a tuple with multiple values, its elements can be decomposed into multiple constants or variables at once:

```swift
let (x, y) = (1, 2)
// x is equal to 1, and y is equal to 2
```

Unlike the assignment operator in C and Objective-C, the assignment operator in Swift does not itself return a value. The following statement is not valid:

```swift
if x = y {
    // This is not valid, because x = y does not return a value.
}
```

This feature prevents the assignment operator (`=`) from being used by accident when the equal to operator (`==`) is actually intended. By making `if x = y` invalid, Swift helps you to avoid these kinds of errors in your code.

### Arithmetic Operators

Swift supports the four standard arithmetic operators for all number types:

* Addition (`+`)
* Subtraction (`-`)
* Multiplication (`*`)
* Division (`/`)

```swift
1 + 2       // equals 3
5 - 3       // equals 2
2 * 3       // equals 6
10.0 / 2.5  // equals 4.0
```

Unlike the arithmetic operators in C and Objective-C, the Swift arithmetic operators do not allow values to overflow by default. You can opt in to value overflow behavior by using Swift’s overflow operators (such as `a &+ b`). See [Overflow Operators]().

The addition operator is also supported for `String` concatenation:

```swift
"hello, " + "world"  // equals "hello, world"
```


#### Remainder Operator

The remainder operator (`a % b`) works out how many multiples of b will fit inside a and returns the value that is left over (known as the remainder).

> The remainder operator (`%`) is also known as a modulo operator in other languages. However, its behavior in Swift for negative numbers means that it is, strictly speaking, a remainder rather than a modulo operation.

Here’s how the remainder operator works. To calculate `9 % 4`, you first work out how many `4s` will fit inside `9`:

[image](../Art/remainderInteger_2x.png)

You can fit two `4s` inside `9`, and the remainder is `1` (shown in orange).

In Swift, this would be written as:

```swift
9 % 4    // equals 1
```

To determine the answer for `a % b`, the `%` operator calculates the following equation and returns `remainder` as its output:

`a` = (`b` x `some multiplier`) + `remainder`

where `some multiplier` is the largest number of multiples of `b` that will fit inside `a`.

Inserting `9` and `4` into this equation yields:

`9` = (`4` x `2`) + `1`

The same method is applied when calculating the remainder for a negative value of `a`:

```swift
-9 % 4   // equals -1
```

Inserting `-9` and `4` into the equation yields:

`-9` = (`4` x `-2`) + `-1`

giving a remainder value of `-1`.

The sign of `b` is ignored for negative values of `b`. This means that `a % b` and `a % -b` always give the same answer.

#### Unary Minus Operator

The sign of a numeric value can be toggled using a prefixed -, known as the unary minus operator:

```swift
let three = 3
let minusThree = -three       // minusThree equals -3
let plusThree = -minusThree   // plusThree equals 3, or "minus minus three"
```

The unary minus operator (`-`) is prepended directly before the value it operates on, without any white space.

#### Unary Plus Operator

The unary plus operator (`+`) simply returns the value it operates on, without any change:

```swift
let minusSix = -6
let alsoMinusSix = +minusSix  // alsoMinusSix equals -6
```

Although the unary plus operator doesn’t actually do anything, you can use it to provide symmetry in your code for positive numbers when also using the unary minus operator for negative numbers.

### Compound Assignment Operators

Like C, Swift provides compound assignment operators that combine assignment (`=`) with another operation. One example is the addition assignment operator (`+=`):

```swift
var a = 1
a += 2
// a is now equal to 3
```

The expression `a += 2` is shorthand for `a = a + 2`. Effectively, the addition and the assignment are combined into one operator that performs both tasks at the same time.

> The compound assignment operators do not return a value. For example, you cannot write `let b = a += 2`.

For a complete list of the compound assignment operators provided by the Swift standard library, see [Swift Standard Library Operators Reference]().

### Comparison Operators

Swift supports all standard C comparison operators:

* Equal to (`a == b`)
* Not equal to (`a != b`)
* Greater than (`a > b`)
* Less than (`a < b`)
* Greater than or equal to (`a >= b`)
* Less than or equal to (`a <= b`)

> Swift also provides two identity operators (`===` and `!==`), which you use to test whether two object references both refer to the same object instance. For more information, see [Classes and Structures]().

Each of the comparison operators returns a `Bool` value to indicate whether or not the statement is true:

```swift
1 == 1   // true because 1 is equal to 1
2 != 1   // true because 2 is not equal to 1
2 > 1    // true because 2 is greater than 1
1 < 2    // true because 1 is less than 2
1 >= 1   // true because 1 is greater than or equal to 1
2 <= 1   // false because 2 is not less than or equal to 1
```

Comparison operators are often used in conditional statements, such as the `if` statement:

```swift
let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}
// Prints "hello, world", because name is indeed equal to "world".
```

For more on the `if` statement, see [Control Flow]().

You can also compare tuples that have the same number of values, as long as each of the values in the tuple can be compared. For example, both `Int` and `String` can be compared, which means tuples of the type `(Int, String)` can be compared. In contrast, Bool can’t be compared, which means tuples that contain a Boolean value can’t be compared.

Tuples are compared from left to right, one value at a time, until the comparison finds two values that aren’t equal. Those two values are compared, and the result of that comparison determines the overall result of the tuple comparison. If all the elements are equal, then the tuples themselves are equal. For example:

```swift
(1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" are not compared
(3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
(4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"
```

In the example above, you can see the left-to-right comparison behavior on the first line. Because 1 is less than 2, (1, "zebra") is considered less than (2, "apple"), regardless of any other values in the tuples. It doesn’t matter that "zebra" isn’t less than "apple", because the comparison is already determined by the tuples’ first elements. However, when the tuples’ first elements are the same, their second elements are compared—this is what happens on the second and third line.

> The Swift standard library includes tuple comparison operators for tuples with fewer than seven elements. To compare tuples with seven or more elements, you must implement the comparison operators yourself.

### Ternary Conditional Operator

The ternary conditional operator is a special operator with three parts, which takes the form question ? answer1 : answer2. It is a shortcut for evaluating one of two expressions based on whether question is true or false. If question is true, it evaluates answer1 and returns its value; otherwise, it evaluates answer2 and returns its value.

The ternary conditional operator is shorthand for the code below:

```swift
if question {
    answer1
} else {
    answer2
}
```

Here’s an example, which calculates the height for a table row. The row height should be 50 points taller than the content height if the row has a header, and 20 points taller if the row doesn’t have a header:

```swift
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)
// rowHeight is equal to 90
```

The preceding example is shorthand for the code below:

```swift
let contentHeight = 40
let hasHeader = true
let rowHeight: Int
if hasHeader {
    rowHeight = contentHeight + 50
} else {
    rowHeight = contentHeight + 20
}
// rowHeight is equal to 90
```

The first example’s use of the ternary conditional operator means that rowHeight can be set to the correct value on a single line of code, which is more concise than the code used in the second example.

The ternary conditional operator provides an efficient shorthand for deciding which of two expressions to consider. Use the ternary conditional operator with care, however. Its conciseness can lead to hard-to-read code if overused. Avoid combining multiple instances of the ternary conditional operator into one compound statement.

### Nil-Coalescing Operator

The nil-coalescing operator (a ?? b) unwraps an optional a if it contains a value, or returns a default value b if a is nil. The expression a is always of an optional type. The expression b must match the type that is stored inside a.

The nil-coalescing operator is shorthand for the code below:

```swift
a != nil ? a! : b
```

The code above uses the ternary conditional operator and forced unwrapping (a!) to access the value wrapped inside a when a is not nil, and to return b otherwise. The nil-coalescing operator provides a more elegant way to encapsulate this conditional checking and unwrapping in a concise and readable form.

> If the value of a is non-nil, the value of b is not evaluated. This is known as short-circuit evaluation.

The example below uses the nil-coalescing operator to choose between a default color name and an optional user-defined color name:

```swift
let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil
 
var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is nil, so colorNameToUse is set to the default of "red"
```

The userDefinedColorName variable is defined as an optional String, with a default value of nil. Because userDefinedColorName is of an optional type, you can use the nil-coalescing operator to consider its value. In the example above, the operator is used to determine an initial value for a String variable called colorNameToUse. Because userDefinedColorName is nil, the expression userDefinedColorName ?? defaultColorName returns the value of defaultColorName, or "red".

If you assign a non-nil value to userDefinedColorName and perform the nil-coalescing operator check again, the value wrapped inside userDefinedColorName is used instead of the default:

```swift
userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is not nil, so colorNameToUse is set to "green"
```

### Range Operators

Swift includes two range operators, which are shortcuts for expressing a range of values.

#### Closed Range Operator

The closed range operator (a...b) defines a range that runs from a to b, and includes the values a and b. The value of a must not be greater than b.

The closed range operator is useful when iterating over a range in which you want all of the values to be used, such as with a for-in loop:

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

For more on for-in loops, see Control Flow.

#### Half-Open Range Operator

The half-open range operator (a..<b) defines a range that runs from a to b, but does not include b. It is said to be half-open because it contains its first value, but not its final value. As with the closed range operator, the value of a must not be greater than b. If the value of a is equal to b, then the resulting range will be empty.

Half-open ranges are particularly useful when you work with zero-based lists such as arrays, where it is useful to count up to (but not including) the length of the list:

```swift
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}
// Person 1 is called Anna
// Person 2 is called Alex
// Person 3 is called Brian
// Person 4 is called Jack
```

Note that the array contains four items, but 0..<count only counts as far as 3 (the index of the last item in the array), because it is a half-open range. For more on arrays, see Arrays.

### Logical Operators

Logical operators modify or combine the Boolean logic values true and false. Swift supports the three standard logical operators found in C-based languages:

Logical NOT (!a)
Logical AND (a && b)
Logical OR (a || b)

#### Logical NOT Operator

The logical NOT operator (!a) inverts a Boolean value so that true becomes false, and false becomes true.

The logical NOT operator is a prefix operator, and appears immediately before the value it operates on, without any white space. It can be read as “not a”, as seen in the following example:

```swift
let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}
// Prints "ACCESS DENIED"
```

The phrase if !allowedEntry can be read as “if not allowed entry.” The subsequent line is only executed if “not allowed entry” is true; that is, if allowedEntry is false.

As in this example, careful choice of Boolean constant and variable names can help to keep code readable and concise, while avoiding double negatives or confusing logic statements.

#### Logical AND Operator

The logical AND operator (a && b) creates logical expressions where both values must be true for the overall expression to also be true.

If either value is false, the overall expression will also be false. In fact, if the first value is false, the second value won’t even be evaluated, because it can’t possibly make the overall expression equate to true. This is known as short-circuit evaluation.

This example considers two Bool values and only allows access if both values are true:

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

The logical OR operator (a || b) is an infix operator made from two adjacent pipe characters. You use it to create logical expressions in which only one of the two values has to be true for the overall expression to be true.

Like the Logical AND operator above, the Logical OR operator uses short-circuit evaluation to consider its expressions. If the left side of a Logical OR expression is true, the right side is not evaluated, because it cannot change the outcome of the overall expression.

In the example below, the first Bool value (hasDoorKey) is false, but the second value (knowsOverridePassword) is true. Because one value is true, the overall expression also evaluates to true, and access is allowed:

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

You can combine multiple logical operators to create longer compound expressions:

```swift
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
```

This example uses multiple && and || operators to create a longer compound expression. However, the && and || operators still operate on only two values, so this is actually three smaller expressions chained together. The example can be read as:

If we’ve entered the correct door code and passed the retina scan, or if we have a valid door key, or if we know the emergency override password, then allow access.

Based on the values of enteredDoorCode, passedRetinaScan, and hasDoorKey, the first two subexpressions are false. However, the emergency override password is known, so the overall compound expression still evaluates to true.

> The Swift logical operators && and || are left-associative, meaning that compound expressions with multiple logical operators evaluate the leftmost subexpression first.

#### Explicit Parentheses

It is sometimes useful to include parentheses when they are not strictly needed, to make the intention of a complex expression easier to read. In the door access example above, it is useful to add parentheses around the first part of the compound expression to make its intent explicit:

```swift
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
```

The parentheses make it clear that the first two values are considered as part of a separate possible state in the overall logic. The output of the compound expression doesn’t change, but the overall intention is clearer to the reader. Readability is always preferred over brevity; use parentheses where they help to make your intentions clear.

### 참고 자료

[^appear]: 'appear'는 '위치하다'로 옮깁니다. 

[^infix]: 'infix'는 '중위'라고 옮길 수 있는데, 많은 경우 그냥 infix 그대로 두는 것이 좋을 것 같습니다.