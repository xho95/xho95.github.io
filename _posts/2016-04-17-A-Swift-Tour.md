---
layout: post
comments: true
title:  "Swift 3.0: 훑어보기(A Swift Tour)"
date:   2016-04-17 19:45:00 +0900
categories: Xcode Swift Grammar Tour
---

> 이 글은 모두의연구소에서 진행하는 Swift 스터디 모임 [^Modulabs]의 발표 자료를 위해 The Swift Programming Language [^Swift] 내용을 요약한 것입니다.  
지금은 최대한 원문을 축약해서 영어로 되어 있지만, 나중에 다시 한글로 번역하여 정리할 생각입니다.  
내용을 Swift 3.0에 맞게 수정하였습니다.

* the first program : print "Hello, world!"

```swift
print("Hello, world!")
```

* this single line of code : a complete program
- don't need to import a separate library functionality
- don't need a `main()` : global scope- the entry point
- don't need to write semicolones

 > note:
 download the playground file : [http://developer.apple.com/go/?id=swift-tour](http://developer.apple.com/go/?id=swift-tour)

### Simple Values

* `let` : make a constant- assign it a value exactly once
* `var` : make a variable

```swift
var myVariable = 42

myVariable = 50

let myConstant = 42
```

* don't always have to write the type explicitly
- the initial value : lets the compiler infer its type
- no initial value : specify the type
* the initial value doesn't enough : specify the type

```swift
let implicitInteger = 70

let implicitDouble = 70.0

let explicitDouble: Double = 70
```

* values are never implicitly converted to another type
* convert a value :**make an instance** of the desired type

```swift
let label = "The width is "

let width = 94

let widthLabel = label + String(width)
```

* an simple way to include values in strings : a backslash and parenthesis

```swift
let apples = 3

let oranges = 5

let appleSummary = "I have \(apples) apples."

let fruitSummary = "I have \(apples + oranges) pieces of fruit."
```

* arrays and dictionaries : using brackets []
* access their elements : index or key in brackets

```swift
var shoppingList = ["catfish", "water", "tulips", "blue paint"]

shoppingList[1] = "bottle of water"

var occupations = ["Malcolm": "Captain", "Kaylee": "Mechanic"]

occupations["jayne"] = "Public Relations"
```

* an empty array or dictionary : use the initializer syntax

```swift
let emptyArray = [String]()

let emptyDictionary = [String: Float]()
```

* [], [:] : if type information can be inferred

```swift
shoppingList = []

occupations = [:]
```

### Control Flow

* `if`, `switch` : make conditionals
* `for-in`, `for`, `while` : make loops
* parentheses : optional, braces : required

```swift
let individualScores = [75, 43, 103, 87, 12]

var teamScore = 0

for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}

print(teamScore)
```

* `if` statement : the conditional must be a Boolean expression
    * ex) `if score { ... }` : an error code
- `if let` : work with optional values that might be missing
- an optional value : either contains a value or contains `nil`
- a question mark(?) : mark the value as optional

```swift
var optionalString: String? = "Hello"

print(optionalString == nil)

var optionalName: String? = "John Appleseed"

var greeting = "Hello!"

if let name = optionalName {
    greeting = "Hello, \(name)"
}
```

* the optional value == `nil` : the code braces is skipped
* otherwise : the optional value is unwrapped and assigned to the constant
- to provide a default value : using the `??` operator

```swift
let nickName: String? = nil

let fullName: String = "John Appleseed"

let informalGreeting = "Hi \(nickName ?? fullName)"
```

* `Switch` : any kind of data and a wide variety of comparison operations

```swift
let vegetable = "red pepper"

switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}
```

* `let` : used in a pattern
* no need to explicitly break out
- `for-in` : iterate overitems in a dictionary
- dictionaries : an unordered collection- iterated over in an arbitrary order

```swift
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]

var largest = 0

for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}

print(largest)
```

* `while` : repeat a block of code
* `repeat-while` : the loop is run at least once

```swift
var n = 2

while n < 100 {
    n = n* 2
}

print(n)

var m = 2

repeat {
    m = m* 2
} while m < 100

print(m)
```

* keep an index in a loop

```swift
var total = 0

for i in 0..<4 {
    total += i
}

print(total)
```

* `..<` : make a range that omits its upper value
* `...` : make a range that includes both values

### Functions and Closures

* `func` : declare a function
* `->` : separate the parameter names and types from the function's return type

```swift
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}

greet(person: "Bob", day: "Tuesday")
```

* parameter names : labels for their arguments
  * write a custom argument label before the parameter name
  * `_` : use no argument label

```swift
func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
```

greet("John", on: "Wednesday")

* **tuple** : make a compound value- to return multiple values
* the elements : refered to either by**name** or**by number**

```swift
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0

    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }

        sum += score
    }

    return (min, max, sum)
}

let statistics = calculateStatistics([5, 3, 100, 3, 9])

print(statistics.sum)
print(statistics.2)
```

* take a variable number of arguments, collecting them into an array

```swift
func sumOf(numbers: Int...) -> Int {
    var sum = 0

    for number in numbers {
        sum += number
    }

    return sum
}

sumOf()
sumOf(numbers: 42, 597, 12)
```

* **nested functions** : access to variables that were declared in the outer function

```swift
func returnFifteen()-> Int {
    var y = 10

    func add() {
        y += 5
    }

    add()

    return y
}

returnFifteen()
```

* **Functions : a first-class type**
* a function can return another function as its value

```swift
func makeIncrementer()-> ((Int)-> Int) {
    func addOne(number: Int)-> Int {
        return 1 + number
    }

    return addOne
}

var increment = makeIncrementer()

increment(7)
```

* a function can take another function as one of its argument

```swift
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }

    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}

var numbers = [20, 19, 7, 12]

hasAnyMatches(list: numbers, condition: lessThanTen)
```

* **Closures** : functions- a special case of closures
* a closure has access to variables and functions in the scope where the closure was created
* `{}` : write a closure without a name
* `in` : separate the arguments and return type

```swift
numbers.map({ (number: Int)-> Int in
    let result = 3* number
    return 3* number
})
```

* writing closures more concisely
- when a closure's type is known
  - omit the type of its parameters
  - omit its return type
- single statement closures
  - implicitly return the value

```swift
let mappedNumbers = numbers.map({ number in 3* number })

print(mappedNumbers)
```

- short closures
  - refer to parameters by number
- when a closure is the only argument
  - omit the parenthese

```swift
let sortedNumbers = numbers.sort { $0 > $1 }

print(sortedNumbers)
```

### Objects and Classes

* `class` : create a class
* a property declaration : the same way as a constant or variable
* method and function declaration : the same way

```swift
class Shape {
    var numberOfSides = 0

    func simpleDescription()-> String {
        return "A shape with \(numberOfSides) sides."
    }
}
```

* create an instance : by putting parentheses after the class name
* dot syntax : access the properties and methods

```swift
var shape = Shape()

shape.numberOfSides = 7

var shapeDescription = shape.simpleDescription()
```

* `init` : an initializer to set up the class

```swift
class NamedShape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) {
        self.name = name
    }

    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
```

* `self` : to distinguish the `name` property from the `name` argument
* every property needs a value assigned
- `deinit` : create a deinitializer- cleanup before the object is deallocated
* **subclasses** : no requirement
* `override` : methods that override the superclass's implementation
* overriding a method without `override` : an error
* `override` that don't actually override any method : the compiler detecs

```swift
class Square: NamedShape {
    var sideLength: Double

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength

        super.init(name: name)

        numberOfSides = 4
    }

    func area() -> Double {
        return sideLength * sideLength
    }

    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

let test = Square(sideLength: 5.2, name: "my test square")

test.area()
test.simpleDescription()
```

* properties can have a getter and a setter.

```swift
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength

        super.init(name: name)

        numberOfSides = 3
    }

    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }

        set {
            sideLength = newValue / 3.0
        }
    }

    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}

var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")

print(triangle.perimeter)

triangle.perimeter = 9.9

print(triangle.sideLength)
```

* `newValue` : the new value has the implicit name in the setter
- three steps in the initializer
     1. setting the value of properties that the subclass declares
     2. calling the superclass's initializer
     3. changing the value of properties defined by the superclass
* `willSet`, `didSet` : run before and after setting a new value

```swift
class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }

    var square: Square {
        willSet {
            triangle.sideLength = newValue.sideLength
        }
    }

    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}

var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")

print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)

triangleAndSquare.square = Square(sideLength: 50, name: "larger square")

print(triangleAndSquare.triangle.sideLength)
```

* **Optional Values : `?`**- before methods, properties, and subsripting
- the value `== nil` : everything after the `?` is ignored and the whole is `nil`
- the value `!= nil` : everything after the `?` acts on the unwrapped value
* the value of the whole expression is an optional value

```swift
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")

let sideLength = optionalSquare?.sideLength
```

### Enumerations and Structures

* **`enum`** : create an enumeration- can have methods

```swift
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king

    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

let ace = Rank.ace

let aceRawValue = ace.rawValue
```

* **the raw values** : by default, starting at zero and incrementing by one
* the raw type : strings, floating-point numbers
* `rawValue` : access the raw value of an enumeration case
- `init?(rawValue:)` initializer : make an instance from a raw value

```swift
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}
```

* **the case values** : actual values
* there isn't a meaningful raw value : don't have to provide one

```swift
enum Suit {
    case spades, hearts, diamonds, clubs

    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}

let hearts = Suit.hearts

let heartsDescription = hearts.simpleDescription()
```

* two ways that the case of the enumeration is referred to
* referred to by its full name : doesn't have an explicit type- `Suit.Hearts`
* refered to by the abbreviated form : the value's type is already known- `.Hearts`
- **`struct`** : create a structure
- many of the same behaviors as calsses
- structures are always copied when they are passed around in code

```swift
struct Card {
    var rank: Rank
    var suit: Suit

    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}

let threeOfSpades = Card(rank: .three, suit: .spades)

let threeOfSpadesDescription = threeOfSpades.simpleDescription()
```

* **the associated values** : an instance of and enumeration case can have values
* instances of the same enumeration case have different values associated with them

```swift
enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let success = ServerResponse.result("6:00 am", "8:09 pm")

let failure = ServerResponse.failure("Out of cheese.")

switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .failure(message):
    print("Failure...  \(message)")
}
```

* part of matching the value against the switch cases

### Protocols and Extensions

* `protocol` : declare a protocol

```swift
protocol ExampleProtocol {
    var simpleDescription: String { get }

    mutating func adjust()
}
```

* classes, enumerations, and strucs : can adopt protocols

```swift
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anotherProperty: Int = 69105

    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}

var a = SimpleClass()

a.adjust()

let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"

    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}

var b = SimpleStructure()

b.adjust()

let bDescription = b.simpleDescription
```

* `mutating` : mark a method that modifies the structure
* methods on a class can always modify the class
- **`extension`** : add functionality to an existing type
- add protocol conformance to a type

```swift
extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }

    mutating func adjust() {
        self += 42
    }
}

print(7.simpleDescription)
```

* a protocol name : named type
* values whose type is a protocol type : methods outside the protocol definition aren't available

```swift
let protocolValue: ExampleProtocol = a

print(protocolValue.simpleDescription)

// print(protocolValue.anotherProperty)  // Uncomment to see the error
```

* `protocolValue` : a runtime type- `SimpleClass`, the given type- `ExampleProtocol`
* can't access methods or properties that the class implements

### Error Handling

* represent errors : any type that adopts the `ErrorProtocol`

```swift
enum PrinterError: ErrorProtocol {
    case outOfPaper
    case noToner
    case onFire
}
```

* `throw` : throw an error
* `throws` : mark a function can throw an error
* throw an error : the function returns immediately
* the code that called the function handles the error

```swift
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }

    return "Job sent"
}
```

* several ways to handle errors
 1. `do-catch`
    * `do` block : mark code that can throw an error by write `try`
    * `catch` block : the error is automatically given the name `error`

```swift
do {
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    //    let printerResponse = try sendToPrinter("Never Has Toner")

    print(printerResponse)
} catch {
    print(error)
}
````

* multiple `catch` blocks : handle specific errors
* write a pattern after `catch`

```swift
do {
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")

    print(printerResponse)
} catch PrinterError.onFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch {
    print(error)
}
```

 2. `try?`- convert the result to an optional
    * an error : the specific error is discarded and the result is `nil`
    * otherwise : the result is an optional containing the value that the function returned

```swift
let printerSuccess = try? send(job: 1884, "Mergenthaler")
let printerFailure = try? send(job: 1885, "Never Has Toner")
```

* `defer` : executed after all other code, just before the function returns
* regardless of whether the function throws an error
* setup and cleanup code

```swift
var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true

    defer {
        fridgeIsOpen = false
    }

    let result = fridgeContent.contains(food)
    return result
}

fridgeContains("banana")
print(fridgeIsOpen)
```

### Generics

* make a generic function or type : write a name inside angle brackets

```swift
func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}

makeArray(repeating: "knock", numberOfTimes:4)
```

* generic forms of functions, methods, as well as classes, enumerations, and structures

```swift
// Reimplement the Swift standard library's optional type
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}

var possibleInteger: OptionalValue<Int> = .none

possibleInteger = .some(100)
```

* `where` : specify a list of requirements
  - the type to implement a protocol
  - two types to be the same
  - a class to have a particular superclass

```swift
func anyCommonElements <T: SequenceType, U: SequenceType where T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element> (_ lhs: T, _ rhs: U) -> Bool {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}

anyCommonElements([1, 2, 3], [3])
```

* `<T: Equatable> == <T where T: Equatable>`

### 참고 자료

[^Modulabs]: [모두의연구소 Swift 프로그래밍](http://www.modulabs.co.kr/#!swift/so209)

[^Swift]: [The Swift Programming Language](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/index.html)
