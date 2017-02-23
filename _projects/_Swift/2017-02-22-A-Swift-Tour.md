## Swift 둘러보기

새로운 언어로 만드는 첫 프로그램은 화면에 `"Hello, world!"` 를 출력하는 것이 전통입니다. Swift 의 경우에는 다음과 같은 코드 한 줄로 할 수 있습니다:

```swift
print("Hello, world!)
``` 

C 나 Objective-C 로 코드를 만들어 본 적이 있다면, 이 문법이 꽤 친숙할 것입니다 - 하지만 Swift 에서는 이 한 줄의 코드가 완전한 프로그램입니다. 입 / 출력이나 문자열 처리를 위해 별도의 라이브러리를 불러올 필요가 없습니다. 전역에 있는 코드는 프로그램의 시작점으로 사용되어서 `main()` 함수도 필요없습니다. 심지어 문장 끝에 세미콜론을 붙일 필요도 없습니다.

이 둘러보기는 다양한 프로그래밍 Swift 코드 작성을 시작하도록 충분한 정보를 줘서 

This tour gives you enough information to start writing code in Swift by showing you how to accomplish a variety of programming tasks. Don’t worry if you don’t understand something—everything introduced in this tour is explained in detail in the rest of this book.

> For the best experience, open this chapter as a playground in Xcode. Playgrounds allow you to edit the code listings and see the result immediately.
> Download Playground

### 간단한 값 (Simple Values)

Use let to make a constant and var to make a variable. The value of a constant doesn’t need to be known at compile time, but you must assign it a value exactly once. This means you can use constants to name a value that you determine once but use in many places.

```swift
var myVariable = 42
myVariable = 50
let myConstant = 42
```

A constant or variable must have the same type as the value you want to assign to it. However, you don’t always have to write the type explicitly. Providing a value when you create a constant or variable lets the compiler infer its type. In the example above, the compiler infers that `myVariable` is an integer because its initial value is an integer.

If the initial value doesn’t provide enough information (or if there is no initial value), specify the type by writing it after the variable, separated by a colon.

```swift
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70
```

Values are never implicitly converted to another type. If you need to convert a value to a different type, explicitly make an instance of the desired type.

```swift
let label = "The width is "
let width = 94
let widthLabel = label + String(width)
```

There’s an even simpler way to include values in strings: Write the value in parentheses, and write a backslash (`\`) before the parentheses. For example:

```swift
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."
```

Create arrays and dictionaries using brackets (`[]`), and access their elements by writing the index or key in brackets. A comma is allowed after the last element.

```swift
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"
 
var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"
```

To create an empty array or dictionary, use the initializer syntax. [^initializer]

```swift
let emptyArray = [String]()
let emptyDictionary = [String: Float]()
```

If type information can be inferred, you can write an empty array as `[]` and an empty dictionary as `[:]`—for example, when you set a new value for a variable or pass an argument to a function.

```swift
shoppingList = []
occupations = [:]
```

#### 흐름 제어 (Control Flow)

Use `if` and `switch` to make conditionals, and use `for`-`in`, `for`, `while`, and `repeat`-`while` to make loops. Parentheses around the condition or loop variable are optional. Braces around the body are required.

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

In an `if` statement, the conditional must be a Boolean expression—this means that code such as `if score { ... }` is an error, not an implicit comparison to zero.

You can use `if` and `let` together to work with values that might be missing. These values are represented as optionals. An optional value either contains a value or contains `nil` to indicate that a value is missing. Write a question mark (`?`) after the type of a value to mark the value as optional.

```swift
var optionalString: String? = "Hello"
print(optionalString == nil)
 
var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}
```

If the optional value is `nil`, the conditional is `false` and the code in braces is skipped. Otherwise, the optional value is unwrapped and assigned to the constant after `let`, which makes the unwrapped value available inside the block of code.

Another way to handle optional values is to provide a default value using the `??` operator. If the optional value is missing, the default value is used instead.

```swift
let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"
Switches support any kind of data and a wide variety of comparison operations—they aren’t limited to integers and tests for equality.

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

Notice how `let` can be used in a pattern to assign the value that matched the pattern to a constant.

After executing the code inside the switch case that matched, the program exits from the switch statement. Execution doesn’t continue to the next case, so there is no need to explicitly break out of the switch at the end of each case’s code.

You use `for`-`in` to iterate over items in a dictionary by providing a pair of names to use for each key-value pair. Dictionaries are an unordered collection, so their keys and values are iterated over in an arbitrary order.

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

Use `while` to repeat a block of code until a condition changes. The condition of a loop can be at the end instead, ensuring that the loop is run at least once.

```swift
var n = 2
while n < 100 {
    n = n * 2
}
print(n)
 
var m = 2
repeat {
    m = m * 2
} while m < 100
print(m)
```

You can keep an index in a loop by using `..<` to make a range of indexes.

```swift
var total = 0
for i in 0..<4 {
    total += i
}
print(total)
```

Use `..<` to make a range that omits its upper value, and use `...` to make a range that includes both values.

### Functions and Closures

Use `func` to declare a function. Call a function by following its name with a list of arguments in parentheses. Use `->` to separate the parameter names and types from the function’s return type.

```swift
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")
```

By default, functions use their parameter names as labels for their arguments. Write a custom argument label before the parameter name, or write `_` to use no argument label.

```swift
func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")
```

Use a tuple to make a compound value—for example, to return multiple values from a function. The elements of a tuple can be referred to either by name or by number.

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
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)
```

Functions can also take a variable number of arguments, 
collecting them into an array.

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

Functions can be nested. Nested functions have access to variables that were declared in the outer function. You can use nested functions to organize the code in a function that is long or complex.

```swift
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()
```

Functions are a first-class type. This means that a function can return another function as its value.

```swift
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)
```

A function can take another function as one of its arguments.

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

Functions are actually a special case of closures: blocks of code that can be called later. The code in a closure has access to things like variables and functions that were available in the scope where the closure was created, even if the closure is in a different scope when it is executed—you saw an example of this already with nested functions. You can write a closure without a name by surrounding code with braces (`{}`). Use `in` to separate the arguments and return type from the body.

```swift
numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})
```

You have several options for writing closures more concisely. When a closure’s type is already known, such as the callback for a delegate, you can omit the type of its parameters, its return type, or both. Single statement closures implicitly return the value of their only statement.

```swift
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)
```

You can refer to parameters by number instead of by name—this approach is especially useful in very short closures. A closure passed as the last argument to a function can appear immediately after the parentheses. When a closure is the only argument to a function, you can omit the parentheses entirely.

```swift
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)
```

#### Objects and Classes

클래스를 만드려면 `class` 키워드를 쓰고 그뒤에 클래스 이름을 씁니다. 클래스에서 속성을 선언하는 것은 클래스의 내부에 있다는 점만 빼면 상수나 변수의 선언과 같습니다. 마찬가지로 메소드와 함수 선언도 방식이 같습니다.

```swift
class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
```

클래스의 인스턴스를 만들려면 클래스 이름뒤에 괄호를 쓰면 됩니다. 인스턴스의 속성이나 메소드에 접근하려면 점을 사용합니다.

```swift
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()
```

지금의 `Shape` 클래스는 뭔가 중요한 것이 빠졌습니다: 인스턴스가 만들어질 때 클래스를 셋업하는 초기자입니다. 초기자를 만들려면 `init` 을 사용합니다.

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

초기자에서 `name` 속성을 name 인자와 구분하기 위해 `self` 를 사용하고 있음을 주목합니다. 초기자의 인자는 클래스 인스턴스 생성시에 전달되는 데 마치 함수를 호출하는 것 처럼 전달됩니다. 모든 속성은 값이 할당되어야 합니다 — (`numberOfSides` 처럼) 선언에서든 아니면 (`name` 처럼) 초기자에서든 말입니다.

객체의 할당이 해제되기 전에 정리를 수행해야하는 경우 `deinit` 를 사용하여 정리자를 만듭니다. [^deinitializer]

하위 클래스는 자신의 이름에 상위 클래스의 이름을 포함하는 데 그 사이를 콜론으로 구분해 줍니다. 클래스는 표준 루트 클래스를 상속할 필요가 없으므로 상위 클래스는 있을 수도 있고 없을 수도 있습니다.

Methods on a subclass that override the superclass’s implementation are marked with `override`—overriding a method by accident, without `override`, is detected by the compiler as an error. The compiler also detects methods with `override` that don’t actually override any method in the superclass.

```swift
class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() ->  Double {
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

In addition to simple properties that are stored, properties can have a getter and a setter.

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

In the setter for `perimeter`, the new value has the implicit name `newValue`. You can provide an explicit name in parentheses after `set`.

Notice that the initializer for the `EquilateralTriangle` class has three different steps:

1. Setting the value of properties that the subclass declares.
2. Calling the superclass’s initializer.
3. Changing the value of properties defined by the superclass. Any additional setup work that uses methods, getters, or setters can also be done at this point.

If you don’t need to compute the property but still need to provide code that is run before and after setting a new value, use `willSet` and `didSet`. The code you provide is run any time the value changes outside of an initializer. For example, the class below ensures that the side length of its triangle is always the same as the side length of its square.

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

When working with optional values, you can write `?` before operations like methods, properties, and subscripting. If the value before the `?` is `nil`, everything after the `?` is ignored and the value of the whole expression is `nil`. Otherwise, the optional value is unwrapped, and everything after the `?` acts on the unwrapped value. In both cases, the value of the whole expression is an optional value.

```swift
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength
```

### Enumerations and Structures

열거체를 만들려면 `enum` 을 사용합니다. 클래스나 다른 모든 일반적인 타입처럼 열거체도 메소드를 가질 수 있습니다. [^method]

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

기본으로 Swift 는 case 의 원시 값 (raw value) 을 0부터 시작해서 하나씩 증가하면서 지정하는데 다른 값을 명시적으로 지정해서 바꿀 수 있습니다. [^raw] 위에 있는 예제에서 `Ace` 는 명시적으로 원시 값을 `1` 로 지정했고 나머지의 원시 값은 순서대로 정하도록 했습니다. 열거체의 raw 타입을 문자열이나 부동-소수점으로 지정해서 사용할 수도 있습니다. 열거체 case 의 raw 값에 접근하려면 `rawValue` 속성을 사용합니다.

raw 값을 가지고 열거체의 인스턴스를 만들려면 `init?(rawValue:)` 초기자를 사용합니다.

```swift
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}
```

열거체의 case 값은 raw 값을 사용하는 또 다른 방법이 아닌 실제 값입니다. 사실 raw 값이 별 의미가 없는 경우에는 굳이 raw 값을 부여할 필요가 없습니다.

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

위에서 열거체의 `hearts` case 를 두 가지 방법으로 언급하는 것을 확인합니다: 값을 `hearts` 상수에 할당할 때는 `Suit.hearts` 라고 열거체 case 의 전체 이름을 사용하는데 이는 상수에 명시적인 타입을 지정하지 않았기 때문입니다. switch 구문안에서는 열거체의  case 가 `.hearts` 라는 축약 형태로 사용되는데 `self` 값은 Suit 타입임을 이미 알고 있기 때문입니다. 값의 타입을 이미 알고 있다면 언제든지 축약 형태를 사용할 수 있습니다.

열거체의 raw 값은 선언될 때 결정되는데 따라서 특정한 열거체의 모든 인스터스들은 항상 같은 raw 값을 가집니다. 열거체 cases 를 위한 또다른 선택은 case 와 연관된 값을 가지게 하는 것입니다 — 이 값은 인스턴스를 만들 때 결정되며 따라서 열거체 case 의 각 인스턴스마다 다른 값을 가집니다. 연관 값은 열거체 case 인스턴스의 저장 속성 (stored properties) 과 같은 것이라고 생각하면 됩니다. 예를 들어 서버에 일출과 일몰 시간을 요청하는 경우가 있다고 가정해 봅시다. 서버는 요청 정보에 맞는 응답을 하거나 뭔가 잘못되었다고 응답합니다.

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

switch 의 case 구문과 값을 맞추는 과정에서 `ServerResponse` 의 일출과 일몰 시간이 어떻게 추출되는지 주목하기 바랍니다.

구조체를 생성하려면 `struct` 를 사용합니다. 구조체는 메소드와 초기자를 포함하여 클래스와 같은 동작을 많이 지원합니다. 하지만 구조체와 클래스의 가장 중요한 차이는 구조체는 전달될 때 항상 복사되지만 클래스는 참조로 전달될다는 점입니다.

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

### 프로토콜 (Protocols) 과 확장 (Extensions)

프로토콜을 선언하려면 `protocol` 을 사용합니다.

```swift
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}
```

클래스, 열거체, 그리고 구조체 모두 프로토콜을 따를 수 있습니다.

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

`SimpleStructure` 선언의 `mutating` 키워드는 메소드가 구조체를 변경함을 나타내는 표시입니다. `SimpleClass` 의 선언에서는 어떤 메소드도 변경 (mutating) 표시를 할 필요가 없는데 이는 클래스의 메소드는 클래스를 언제든지 변경할 수 있기 때문입니다.

이미 있는 타입에 새로운 메소드나 계산 속성 (computed properties) 과 같은 기능을 추가하려면 `extension` 을 사용합니다. 확장 (extension) 을 사용하면 다른 곳에서 선언된 타입 또는 심지어 라이브러리나 프레임웍에서 불러온 타입이라도 프로토콜을 따르게 할 수 있습니다.

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

프로토콜을 이름을 마치 다른 보통의 타입 이름인 것처럼 사용할 수 있는데 - 가령 서로 다른 타입들이지만 같은 프로코톨을 따르고 있는 객체들로 된 집합 (collection) 을 만들 수 있습니다. 다만 타입이 프로토콜인 값을 사용할 때는 프로토콜 정의 외부에 있는 메소드에는 접근할 수 없습니다.

```swift
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
// print(protocolValue.anotherProperty)  // 주석을 제거하면 에러가 납니다.
```

`protocolValue` 변수는 런타임 타입이 `SimpleClass` 이지만, 컴파일러는 `ExampleProtocol` 타입이라고 여깁니다. 이것은 프로토콜을 따르는 면서 클래스에서 구현한 메소드나 속성에 실수로 접근하는 것을 막도록 합니다.

### 에러 처리 (Error Handling)

`Error` 프로토콜을 따르는 모든 타입을 사용해서 에러를 나타냅니다. [^error] [^adopt]

```swift
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}
```

에러를 던지려면 `throw` 를 사용하면 되며 `throws` 는 그 함수가 에러를 던질 수 있음을 표시합니다. 함수 안에서 에러를 던지면, 그 함수는 즉시 반환되며 함수를 호출한 코드는 에러를 처리합니다.

```swift
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}
```

에러를 처리하는 방법에는 여러 가지가 있습니다. 한가지 방법은 `do`-`catch` 를 사용하는 것입니다. `do` 블럭 안에서는 에러를 던질 수 있는 코드 앞에 `try` 를 표시합니다. `catch` 블럭 안에서 에러는 다른 이름을 붙이지 않는한 알아서 `error` 라는 이름을 가집니다.

```swift
do {
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    print(printerResponse)
} catch {
    print(error)
}
```

다수의 `catch` 를 사용해서 지정된 에러들을 처리할 수 있습니다. switch 구문의 `case` 에서 했던 것처럼 `catch` 뒤에도 패턴을 사용할 수 있습니다.

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

에러 처리를 하는 다른 방법은 `try?` 를 사용해서 결과를 옵셔널 (optional) 로 바꾸는 것입니다. 함수가 에러를 던지면 에러를 버려버리고 결과를 `nil` 로 만듭니다. 아니라면 결과는 함수의 반환 값을 가지는 옵셔널이 됩니다.

```swift
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")
```

함수가 반환되기 전에 함수의 다른 모든 코드 이후에 실행될 코드 블럭을 작성하려면 `defer` 를 사용합니다. 이 코드는 함수가 에러를 던지는지의 유무화는 상관없이 실행됩니다. `defer` 를 사용하면 설정 코드와 정리 코드가 서로 다른 시간에 실행될 지라도, 두 코드를 바로 붙여서 작성할 수 있습니다.

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

### 제네릭 (Generics)

제네릭 함수나 타입을 만들려면 꺽쇠 괄호 안에 이름을 쓰면 됩니다.

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

함수와 메소드 뿐만 아니라 클래스, 열거체, 구조체도 제네릭 양식으로 만들 수 있습니다.

```swift
// Reimplement the Swift standard library's optional type
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)
```

요구 조건 목록을 지정하려면 본체 바로 앞에 `where` 를 사용합니다 — 예를 들어, 타입이 프로토콜을 구현하도록 하거나, 두 타입을 같도록 하거나, 아니면 클래스가 특별한 상위 클래스에서 상속받아야 하는 경우에 사용하면 됩니다.

```swift
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool
    where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
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

`<T: Equatable>` 라고 쓰는 것은 `<T> ... where T: Equatable` 라고 쓰는 것과 같습니다.

### 원문 자료 

[A Swift Tour](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/GuidedTour.html#//apple_ref/doc/uid/TP40014097-CH2-ID1) : The Swift Programming Language (Swift 3.1) 자료입니다.

### 참고 자료

[^initializer]: 'initializer' 는 '초기자'라고 번역합니다. 이것은 C++ 의 constructor 를 생성자라고 부르는 것에서 착안하였습니다. Swift 의 초기자는 C++ 의 생성자와 초기화 함수의 역할을 동시에 수행합니다. 이것은 현대의 프로그래밍 언어들이 변수 선언 시점을 최대한 실제 변수가 사용되는 시점에 맞춰서 하려고 하기 때문에, 변수 선언 시점에 값을 초기화까지 하려고 강제하기 위해서라고 추측하고 있습니다.

[^deinitializer]: 'deinitializer' 단어는 도저히 뭐라고 번역해야할 지 몰라서 일단은 '정리자'라고 번역합니다. 구글 번역도 번역을 포기한 단어같습니다. 실제로 Swift 는 메모리 관리를 ARC 가 해주기 때문에 따로 정리할 일이 없어서 사용할 일이 거의 없는 것 같습니다. 

[^method]: 'method' 는 멤버 함수의 의미도 있지만 일단 메소드라고 그대로 씁니다. 메소드는 특정 클래스나 구조체 처럼 어떤 객체에 속해있다는 점에서 일반 함수와 구분됩니다.

[^error]: Swift 에서는 예외 (Exception) 라는 표현 대신에 오류 (Error) 라는 표현을 씁니다. 일단 혼동을 막기 위해 에러라고 번역합니다.

[^adopt]: 일단 'adopt' 라는 표현을 '따른다'라고 번역합니다. Swift 에서는 클래스는 상위 클래스로부터 상속 받는다는 표현을 사용하고 프로토콜의 경우 따른다는 표현으로 구분합니다. 프로토콜을 따르는 것은 C++ 에서  순수 추상 클래스 중의 하나인 프로토콜 클래스를 상속받는 것과 유사한 개념입니다.

[^raw]: 'raw value' 는 마음에는 안들지만 일단 '원시 값' 으로 번역합니다. 나중에 더 좋은 단어가 생각나면 바꿀 예정입니다.



