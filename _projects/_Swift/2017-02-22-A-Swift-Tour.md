## 스위프트 (Swift) 둘러보기

새로운 언어의 첫 프로그램으로는 화면에 `"Hello, world!"` 를 출력하는 것이 하나의 전통입니다. Swift 는 한 줄의 코드로 이 일을 할 수 있습니다:

```swift
print("Hello, world!)
``` 

C 나 Objective-C 로 코딩을 해봤다면 이 문법이 친숙할 것입니다 - 하지만 Swift 에서는 이 한 줄의 코드가 완전한 프로그램입니다. 입/출력이나 문자열 처리를 위해 별도의 라이브러리를 불러올 필요가 없습니다. 전역 범위에 있는 코드는 프로그램의 시작점으로 사용되므로 `main()` 함수도 필요없습니다. 심지어 문장 끝에 세미콜론을 붙일 필요도 없습니다.

이 둘러보기는 스위프트 프로그래밍을 시작하는데 필요한 정보를 다양한 프로그래밍 방법을 통해 보여줍니다. 이해 안되는  곳이 있어도 걱정할 필요 없습니다. - 이 책의 나머지 부분에서 둘러보기에서 소개된 모든 내용을 자세히 설명하고 있기 때문입니다.

> 최고의 학습을 위해, 이 장 (chapter) 을 Xcode 의 playground 로 엽니다. Playground 를 사용하면 코드를 편집하고 결과를 즉시 확인할 수 있습니다.

### 간단한 값 (Simple Values)

`let` 으로 상수를 만들고 `var` 로 변수를 만듭니다. 상수 값은 컴파일 시간에 알 필요는 없지만, 할당은 단 한 번만 가능합니다.  [^compile-time] 즉, 값에 이름을 한 번 지정하면 여러 곳에서 사용할 수 있는 것이 상수입니다.

```swift
var myVariable = 42
myVariable = 50
let myConstant = 42
```

상수나 변수는 반드시 할당하려는 값과 같은 타입이어야 합니다. [^type] 하지만 매번 타입을 드러내놓고 적어야 하는 것은 아닙니다. [^explicitly] 상수나 변수를 만들 때 값을 제공해서 컴파일러가 해당 타입을 추론하게 할 수 있습니다. 위의 예제에서는 초기값이 정수 이기 때문에 컴파일러가 `myVariable` 를 정수 타입으로 추론합니다. [^integer]

초기 값에 정보가 부족하거나 (초기 값이 없는 경우), 변수 뒤에 콜론(`:`)을 쓴 다음 타입을 지정합니다.

```swift
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70
```

값은 은연 중에 다른 타입으로 바뀌지 않습니다. [^implicitly] 값을 다른 타입으로 바꾸고 싶으면 드러내놓고 원하는 타입의 인스턴스를 만들어야 합니다.

```swift
let label = "The width is "
let width = 94
let widthLabel = label + String(width)
```

문자열에 값을 넣는 더 간단한 방법도 있습니다: 괄호 안에 값을 쓰고, 괄호 앞에 역 슬래시 (`\`) 를 습니다. 다음을 참고합니다:

```swift
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."
```

대괄호 (`[]`) 로 배열 타입과 사전 타입을 만들고, 인덱스나 키를 대괄호 안에 써서 각 요소에 접근합니다. 마지막 요소 다음에 쉼표를 써도 무방합니다. [^array-dictionary]

```swift
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"
 
var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"
```

빈 배열이나 사전 타입을 만들려면, 초기자 문법을 사용합니다. [^initializer]

```swift
let emptyArray = [String]()
let emptyDictionary = [String: Float]()
```

타입 정보를 추론할 수 있는 경우 , 빈 배열 타입은 `[]` 로 빈 사전 타입은 `[:]` 로 적을 수 있습니다 — 예를 들어 변수에 새 값을 설정하거나 함수에 인자를 전달할 때가 여기에 해당합니다.

```swift
shoppingList = []
occupations = [:]
```

### 흐름 제어 (Control Flow)

`if` 와 `switch` 로 조건 구문을 만들고, `for`-`in`, `for`, `while`, 그리고 `repeat`-`while` 로 반복 구문을 만듭니다. [^conditional-loop] 조건 또는 반복 변수 주위의 괄호는 선택 사항이고, 구문 본체 주위의 중괄호는 필수 사항입니다. [^brace]

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

`if` 문에서, 조건문은 불린 (Boolean) 표현식이어야 합니다 - 이것은 `if score { ... }` 같은 코드는 은연 중에 0 으로 비교되지 않고 에러가 됨을 뜻합니다.

`if` 와 `let` 을 같이 쓰면 값이 없는 상태를 다룰 수 있습니다. 이 값은 옵셔널 (optional) 로 표시됩니다. [^optional] 옵셔널 값은 값을 가지고 있거나 값이 없을을 나타내는 `nil` 을 가지고 있습니다. 값을 옵셔널로 표시하려면 값 타입 뒤에 물음표 (`?`) 를 쓰면 됩니다.

```swift
var optionalString: String? = "Hello"
print(optionalString == nil)
 
var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}
```

옵셔널 값이 `nil`이면 조건문은 거짓 (`false`) 이고 중괄호 안의 코드는 건너뜁니다. 아닌 경우, 옵셔널 값은 풀려져서 `let` 뒤의 상수에 할당되고 이 값은 코드 블럭에서 사용할 수 있게 됩니다.

옵셔널 값을 처리하는 또 다른 방법은 `??` 연산자를 써서 기본 값을 제공하는 것입니다. 옵셔널 값이 없는 상태라면 기본 값이 대신 사용됩니다.

```swift
let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"
```

Switch 문은 정수 값의 비교에만 국한되지 않고, 모든 종류의 데이터 타입과 광범위한 비교 연산을 지원합니다. [^switch]

```
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

`let`을 사용해서 상수 패턴에 들어맞는 값을 할당하는 방법에 주목하기 바랍니다. [^match] 이 부분은 다시 정리합니다.

들어맞는 switch case 의 코드를 실행하면 프로그램은 switch 구문을 마칩니다. 다음 case 문을 실행하지는 않으므로 switch 문을 빠져나가려고 각 case 코드 끝에 `break` 를 쓸 필요는 없습니다.

`for`-`in` 구문을 사용하면 사전 타입의 아이템을 반복할 수 있는데, 이 때 각각의 키-값 쌍에 사용할 이름 쌍을 제공하면 됩니다. [^pair] 사전 타입은 순서가 없는 모듬 타입이어서, 키와 값은 임의의 순서로 반복됩니다. [^collection]

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

`while` 구문은 조건문이 바뀔 때까지 코드 블럭을 반복하는데 사용합니다. 최소한 한 번의 반복 구문이 실행되도록 하기 위해 반복 구문의 끝에 조건문이 있을 수도 있습니다.

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

`..<` 로 범위 인덱스를 만들어서 반복 구문내에서 인덱스를 유지할 수도 있습니다.

```swift
var total = 0
for i in 0..<4 {
    total += i
}
print(total)
```

`..<` 를 사용하면 최상단 값을 생략하는 범위를 만들 수 있고, `...` 를 사용하면 양 끝단의 값을 포함하는 범위를 만들 수 있습니다.

### 함수 (Functions) 와 클로져 (Closures)

`func` 을 사용하여 함수를 선언합니다. 함수를 호출하려면 이름 뒤에 인자 목록을 가진 괄호를 쓰면 됩니다. `->` 기호 앞은 매개 변수의 이름 및 타입이고 뒤는 함수의 반환 타입입니다.

```swift
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")
```

함수는 따로 지정된 값이 없으면 매개 변수 이름을 인자의 꼬리표로 사용합니다. [^label] 따로 지정하려면 매개 변수 이름 앞에 자신만의 인자 꼬리표를 써주고 꼬리표를 아예 쓰고 싶지 않으면 `_` 를 쓰면 됩니다.

```swift
func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")
```

값을 합성하려면 튜플 (tuple) 을 사용합니다 — 예를 들어 함수에서 다수의 값을 반환할 때 사용할 수 있습니다. 튜플의 요소는 이름이나 번호로 참조할 수 있습니다.

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

함수는 가변 길이의 인자를 취할 수 있으며 이를 모아서 자동으로 배열 타입으로 만들어 줍니다. [^variable-number]

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

함수는 중첩될 수 있습니다. [^nest] 중첩된 함수는 외부 함수에서 선언된 변수에 접근할 수 있습니다. 중첩된 함수를 사용하여 길고 복잡한 함수 코드를 정리할 수 있습니다. [^organize]

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

함수는 일급 타입입니다. [^first-class] 이 말은 함수가 다른 함수를 값으로 반환할 수 있음을 의미합니다.

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

함수는 인자의 하나로 다른 함수를 취할 수 있습니다.

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

함수는 실제로는 특수한 형태의 클로저입니다: 여기서 클로저는 나중에 호출할 수 있는 코드 블럭을 말합니다. [^closure] 클로저의 코드는 클로저가 만들어지는 범위에서 사용 가능한 변수와 함수들에 접근할 수 있습니다. 이 때 클로저가 실행될 때 범위가 달라져도 접근할 수 있습니다 - 이미 중첩된 함수에서 이 예를 보았습니다. 클로저는 이름 없이 코드를 중괄호 (`{}`) 로 감싸는 것으로 만들 수 있습니다. 구분 본체에서 인자와 반환 타입을 구분하는데는 `in` 을 사용합니다.

```swift
numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})
```

클로져를 더 간결하게 작성할 수 있는 옵션이 몇 개 있습니다. 가령 델리게이트 (delegate) 의 콜백 처럼 클로저의 타입을 이미 알 수 있으면, 매개 변수의 타입, 반환 타입, 또는 둘 다를 생략할 수 있습니다. [^delegate-callback] 단일 구문 클로저는 그 단일 구문의 값을 `return` 을 쓰지 않고도 반환할 수 있습니다.

```swift
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)
```

매개 변수를 이름 대신에 번호로 참조할 수 있습니다 — 이 접근 방법은 특히 매우 짧은 클로저에 유용합니다. [^approach] 함수의 마지막 인자로 전달된 클로저는 괄호 바로 뒤로 옮길 수 있습니다. 클로저가 함수의 유일한 인자라면 괄호 전체를 생략할 수 있습니다.

```swift
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)
```

#### 객체 (Objects) 와 클래스 (Classes: 객체 타입)

`class` 를 쓰고 그뒤에 클래스 이름을 써서 클래스를 만듭니다. 클래스에서 속성을 선언하는 방법은 클래스의 내부에 있다는 점만 빼면 상수나 변수의 선언과 같습니다. [^context] 메소드와 함수 선언 방법도 마찬가지입니다.

```swift
class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
```

클래스의 인스턴스를 만들려면 클래스 이름뒤에 괄호를 쓰면 됩니다. 인스턴스의 속성이나 메소드에 접근하려면 점 문법 (dot syntax) 을 사용합니다. [^dot-syntax]

```swift
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()
```

지금의 `Shape` 클래스에는 뭔가 중요한 것이 빠졌습니다: 그것은 인스턴스가 만들어질 때 클래스를 초기 설정하는 초기자입니다. [^setup] 초기자를 만들려면 `init` 을 사용합니다.

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

초기자의 `name` 인자와 `name` 속성을 구분하기 위해 `self` 를 사용하는 방법을 주목합니다. 초기자의 인자는 클래스의 인스턴스를 만들 때 전달되는데 마치 함수 호출인 것 처럼 전달됩니다. 모든 속성에는 값이 할당되어야 합니다 — (`numberOfSides` 처럼) 선언에서든 아니면 (`name` 처럼) 초기자에서든 말입니다.

할당된 객체를 해제하기 전에 정리를 해야하는 경우 `deinit` 를 사용하여 정리자를 만듭니다. [^deinitializer]

하위 클래스는 자신의 이름뒤에 콜론을 쓰고 뒤이어 상위 클래스의 이름을 추가할 수 있습니다. 클래스가 꼭 표준 루트 클래스의 하위 클래스일 필요는 없기 때문에 상위 클래스를 추가할 수도 있고 생략할 수도 있습니다. [^standard-root-class]

하위 클래스의 메소드가 상위 클래스의 구현을 덮어 쓰는 경우 `override` 로 표시합니다 —  `override` 없이, 실수로 메소드를 덮어 쓸 경우 컴파일러에서 에러로 검출됩니다. 컴파일러는  `override` 메소드면서도 실제로는 상위 클래스의 어떤 메소드도 덮어 쓰지 않는 경우도 검출합니다. [^override]

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

저장된다는 간단한 성질외에도, 속성은 게터 (getter) 와 세터 (setter) 를 가질 수 있습니다. [^property-2]

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

`perimeter` 의 세터에서, 새로 전달되는 값은 은연 중에 `newValue` 라는 이름을 가집니다. `set` 뒤에 괄호를 쓰고 직접 새 이름을 지정할 수 도 있습니다.

`EquilateralTriangle` 클래스의 초기자는 다음의 세 단계를 가지고 있습니다:

1. 하위 클래스에서 선언한 속성의 값을 설정합니다.
2. 상위 클래스의 초기자 호출합니다.
3. 상위 클래스에서 정의한 속성의 값을 바꿉니다. 메소드, 게터, 또는 세터를 사용하는 모든 추가 설정 작업은 여기에서 수행할 수 있습니다.

속성을 계산할 필요는 없지만 새 값의 설정 전후에 작동하는 코드가 필요할 경우 `willSet` 과  `didSet` 을 사용합니다. 이 코드는 초기자의 외부에서 값의 변경이 있을 때마다 실행됩니다. 예를 들어 아래에 나타낸 클래스는 삼각형의 한 변의 길이가 사각형의 한 변의 길이와 항상 같도록 합니다.

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

옵셔널 값과 작업할 때, 메소드, 속성, 그리고 첨자 인덱싱 (subscripting) 과 같은 연산 작업 전에 `?` 를 쓸 수 있습니다. [^subscripting] `?` 앞에 오는 값이 `nil` 이면 `?` 다음의 모든 것은 무시되고 전체 표현식의 값은 `nil` 이 됩니다. 그렇지 않으면 옵셔널 값은 풀어지고 `?` 다음의 모든 것은 풀려진 값에 작용합니다. 두 경우 모두 전체 표현식의 값은 옵셔널 값입니다.

```swift
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength
```

### 열거 타입 (Enumerations) 과 구조 타입(Structures)

`enum` 을 사용해서 열거 타입을 만듭니다. 클래스나 다른 모든 보통의 타입처럼 열거 타입도 메소드를 가질 수 있습니다. [^method] [^named]

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

Swift 는 기본으로 case 의 원시 값 (raw value) 을 0부터 하나씩 증가하면서 지정하는데, 다른 값을 직접 지정해서 바꿀 수 있습니다. [^raw] 위에 있는 예제에서 `Ace` 는 직접 원시 값을 `1` 로 지정했고 나머지의 원시 값은 순서대로 지정하도록 했습니다. 열거 타입의 원시 타입을 문자열이나 부동-소수점으로 지정할 수도 있습니다. 열거 타입 case 의 원시 값에 접근하려면 `rawValue` 속성을 사용합니다.

`init?(rawValue:)` 초기자를 사용하면 열거 타입의 인스턴스를 만들 때 원시 값을 넣을 수 있습니다.

```swift
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}
```

열거 타입의 case 값은 원시 값을 표현하는 또 다른 방법이 아닌 실제 값입니다. 사실 원시 값이 별 의미가 없는 경우에는 굳이 원시 값을 사용할 필요가 없습니다.

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

위에서 열거 타입의 `hearts` case 를 두 가지 방법으로 참조하고 있음을 주목합니다: `hearts` 상수에 값을 할당할 때는 `Suit.hearts` 라고 열거 타입 case 의 전체 이름을 사용하는데, 이는 타입을 직접 지정하지 않는 이상 상수가 타입을 알 수 있는 방법이 없기 때문입니다. switch 구문안에서는 열거 타입의  case 가 `.hearts` 라는 축약 형태로 참조되는데, 이는 `self` 의 값이 Suit 타입임을 이미 알고 있기 때문입니다. 값의 타입을 이미 알고 있다면 언제든지 축약 형태를 사용할 수 있습니다. [^abbreviated]

열거 타입이 원시 값을 가지고 있을 경우, 그 값은 선언될 때 결정되는데, 이것은 특정 열거 타입 case 의 모든 인스터스는 항상 같은 원시 값을 가진다는 것을 의미합니다. [^determine] 열거 타입 case 를 위해 또 다른 선택을 할 수 있는데 case 와 연관된 값을 갖도록 하는 것입니다 — 이 값은 인스턴스를 만들 때 결정되며, 따라서 열거 타입 case 의 각 인스턴스마다 다른 값을 가집니다. 연관 값은 마치 열거 타입 case 인스턴스에 대한 저장 속성 (stored properties) 과 같이 작동하는 것이라고 생각할 수 있습니다. [^associated-value] [^stored-property] 예를 들어 서버에 일출과 일몰 시간을 요청하는 경우를 가정합니다. 서버는 요청된 정보로 응답하거나 잘못되었을 경우 잘못에 대한 설명으로 응답합니다.

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

switch 의 case 와 값을 비교할 때 `ServerResponse` 값에서 일출과 일몰 시간이 어떻게 추출되는지 주목합니다.

`struct` 를 사용해서 구조 타입을 만듭니다. 구조 타입은 메소드와 초기자를 포함하여 클래스와 작동 방식이 같은 것이 많습니다. [^behavior] 구조 타입과 클래스 (객체 타입) 의 가장 중요한 차이점은 구조체는 코드에서 전달될 때 항상 복사되지만 클래스는 참조로 전달된다는 점입니다.

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

`protocol` 을 사용해서 프로토콜을 선언합니다.

```swift
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}
```

클래스 (객체 타입), 열거 타입, 그리고 구조 타입 모두 프로토콜을 받아들일 수 있습니다. [^adopt]

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

`SimpleStructure` 선언에서 메소드가 구조 타입을 변경하고 있음을 표시하려고 `mutating` 키워드를 사용하고 있음에 주목합니다. `SimpleClass` 의 선언에서는 어떤 메소드도 변경한다는 (mutating) 표시를 할 필요가 없는데, 이는 클래스의 메소드는 언제든지 클래스를 변경할 수 있기 때문입니다.

기존 타입에 새로운 메소드나 계산 속성 (computed properties) 과 같은 기능을 추가하려면 `extension` 을 사용합니다. [^computed-property] 확장 (extension) 을 사용하면 다른 곳에서 선언된 타입 또는 심지어 라이브러리나 프레임웍에서 불러온 타입도 프로토콜을 받아들이게 할 수 있습니다.

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

프로토콜 이름은 모든 다른 보통의 타입처럼 사용할 수 있습니다 - 예를 들어 타입이 다 다르지만 단일 프로토톨을 받아들이고 있는 객체들의 모듬 타입 (collection) 을 만들 수 있습니다. 타입이 프로토콜 타입인 값을 사용할 때는, 프로토콜 정의 외부에 있는 메소드는 접근할 수 없습니다.

```swift
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
// print(protocolValue.anotherProperty)  // 주석을 제거하면 에러가 납니다.
```

`protocolValue` 변수의 실행 시간 타입은 `SimpleClass` 이지만, 컴파일러는 해당 타입을 `ExampleProtocol` 타입이라고 여깁니다. [^run-time] [^compiler] 이것은 프로토콜을 받아들이면서도 클래스가 구현하고 있는 메소드나 속성에 실수로라도 접근할 수는 없음을 의미합니다.

### 에러 처리 (Error Handling)

에러를 나타내려면 어떤 타입이든지 `Error` 프로토콜을 받아들이면 됩니다. [^error] 

```swift
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}
```

`throw` 를 사용해서 에러를 던지며 `throws` 를 사용해서 함수가 에러를 던질 수 있음을 표시합니다. 함수에서 에러를 던지면, 그 함수는 즉시 반환되며, 함수를 호출한 코드가 에러를 처리합니다.

```swift
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}
```

에러를 처리하는 방법에는 여러 가지가 있습니다. 한 가지 방법은 `do`-`catch` 를 사용하는 것입니다. `do` 블럭 안에는 에러를 던질 수 있는 코드 앞에 `try` 를 표시합니다. `catch` 블럭 안에서는 다른 이름을 붙이지 않는한 에러는 알아서 `error` 라는 이름을 가집니다.

```swift
do {
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    print(printerResponse)
} catch {
    print(error)
}
```

지정된 에러를 처리하는 다수의 `catch` 블럭을 제공할 수 있습니다. switch 구문의 `case` 에서 했던 것처럼 `catch` 뒤에도 패턴을 사용할 수 있습니다.

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

에러 처리를 하는 또 다른 방법은 `try?` 를 사용해서 결과를 옵셔널로 바꾸는 것입니다. 함수가 에러를 던지면 지정된 에러는 무시되며 결과는 `nil` 이 됩니다. 그렇지 않으면 결과는 함수가 반환한 값을 가지는 옵셔널이 됩니다.

```swift
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")
```

`defer` 를 사용하면, 함수의 모든 다른 코드 다음에 실행될 코드 블럭을 작성해서 함수가 반환되기 직전에 실행되도록 할 수 있습니다. 이 코드는 함수가 에러를 던지던 말던 상관없이 실행됩니다. `defer` 를 사용하면 서로 다른 시간에 실행되는 설정 코드와 정리 코드도 바로 붙여서 작성할 수 있습니다. [^defer-code]

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

꺽쇠 괄호 안에 이름을 써서 제네릭 함수나 타입을 만듭니다.

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

클래스 (객체 타입), 열거 타입, 그리고 구조 타입 뿐만 아니라 함수와 메소드도 제네릭 양식으로 만들 수 있습니다. [^form] [^generic]

```swift
// Reimplement the Swift standard library's optional type
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)
```

본체 구문 바로 앞에 `where` 를 사용해서 요구 사항 목록을 지정합니다 [^requirement] — 예를 들어, 타입이 프로토콜을 구현하도록 요구하거나, 두 타입이 같아야 함을 요구하거나, 아니면 클래스가 특정한 상위 클래스를 가져야만 하도록 요구할 수 있습니다.

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

아래에 있는 내용은 다른 곳으로 분리해서 옮길 예정입니다.

[^initializer]: 'initializer' 는 '초기자'라고 번역합니다. 이것은 C++ 의 constructor 를 생성자라고 부르는 것에서 착안하였습니다. Swift 의 초기자는 C++ 의 생성자와 초기화 함수의 역할을 동시에 수행합니다. 이것은 현대의 프로그래밍 언어들이 변수 선언 시점을 최대한 실제 변수가 사용되는 시점에 맞춰서 하려고 하기 때문에, 변수 선언 시점에 값을 초기화까지 하려고 강제하기 위해서라고 추측하고 있습니다. 번역과 관련한 내용은 다른 곳으로 옮기고 여기서는 초기자 문법에 대해서 설명합니다.

[^deinitializer]: 'deinitializer' 단어는 도저히 뭐라고 번역해야할 지 몰라서 일단은 '정리자'라고 번역합니다. 구글 번역도 번역을 포기한 단어같습니다. 실제로 Swift 는 메모리 관리를 ARC 가 해주기 때문에 따로 정리할 일이 없어서 사용할 일이 거의 없는 것 같습니다. 

[^method]: 'method' 는 멤버 함수의 의미도 있지만 일단 메소드라고 그대로 씁니다. 메소드는 특정 클래스나 구조체 처럼 어떤 객체에 속해있다는 점에서 일반 함수와 구분됩니다.

[^error]: Swift 에서는 예외 (Exception) 라는 표현 대신에 오류 (Error) 라는 표현을 씁니다. 일단 혼동을 막기 위해 에러라고 번역합니다.

[^adopt]: 일단 'adopt' 라는 표현을 '받아들이다'라고 번역합니다. Swift 에서는 클래스는 상위 클래스로부터 상속 받는다는 표현을 사용하고 프로토콜의 경우 받아들인다는 표현으로 구분합니다. 프로토콜을 받아들이는 것은 C++ 에서  순수 추상 클래스 중의 하나인 프로토콜 클래스를 상속받는 것과 유사한 개념입니다.

[^raw]: 'raw value' 는 마음에는 안들지만 일단 '원시 값' 으로 번역합니다. 나중에 더 좋은 단어가 생각나면 바꿀 예정입니다.

[^compile-time]: 'compile time' 은 '컴파일 시간'으로 옮깁니다. 하나의 새로운 단어로 인식합니다.

[^type]: 'type' 은 '타입' 이라고 옮깁니다. 하나의 새로운 단어로 인식합니다.

[^explicitly]: 'explicitly' 는 '명시적 ' 또는 '직접'으로 옮깁니다. 이 부분은 다시 정리해야 합니다. 드러내놓고 라는 의미를 살리도록 합니다.

[^integer]: 'integer'는 '정수' 또는 '정수 타입'으로 옮깁니다.

[^implicitly]: 'implicitly'는 보통 '암시적으로'라고 옮깁니다. 생각을 좀 해야 합니다. 드러내지 않고 라는 의미를 살리도록 합니다. Swift 는 강한 타입 언어 입니다.

[^array-dictionary]: 'array' 는 배열 타입, 'dictionary' 는 '사전 타입'으로 옮깁니다.

[^conditional-loop]: 'conditional' 은 '조건 구문' 또는 '조건문'으로 'loop' 는 '반복 구문' 또는 '반복문'으로 옮깁니다.

[^optional]: 'optional' 은 '옵셔널'로 옮깁니다.

[^brace]: 'brace' 는 '중괄호'로 옮깁니다. 영어에서는 괄호의 종류마다 다른 단어가 있습니다. 나중에 정리합니다.

[^switch]: 'switch' 는 발음으로도 옮기지 않고 'switch' 그대로 사용합니다. 필요에 따라 'switch 구문' 또는 'switch 문'으로 옮깁니다.

[^match]: 'match'는 값을 맞추다는 의미를 살리도록 합니다. 여기서는 '들어맞다'로 옮깁니다. 때에 따라서는 '비교하다'로 옮겨야 할 수 있습니다. 좀 더 생각합니다.

[^pair]: 'pair'는 일단 '쌍'으로 옮깁니다.

[^collection]: 'collection' 은 '모듬 타입'으로 옮깁니다.

[^label]: 'label' 은 '꼬리표'로 옮깁니다.

[^argument]: 'argument'는 '인자'로 옮깁니다. 

[^variable-number]: 인자에서 'variable number'는 '가변 길이'로 옮깁니다.

[^nest]: 'nest'는 일단 '중첩하다'로 옮깁니다. 좀 더 생각해야 합니다.

[^organize]: 'organize' 는 여러 가지 의미를 가지고 있는데, 여기서는 '정리하다'로 옮깁니다.

[^first-class]: 'first-class'는 '일급'으로 옮깁니다. 일급 함수에 대해서는 위키피디아의 [First-class function](https://en.wikipedia.org/wiki/First-class_function) 을 참고합니다.

[^delegate-callback]: 'delegate' 는 델리게이트로 'callback' 은 콜백으로 옮깁니다. 새로운 단어로 받아들입니다.

[^approach]: 'approach'는 '접근 방법'으로 옮깁니다.

[^closure]: 'closure'는 '클로져'로 옮깁니다.

[^context]: 번역이 어려운 단어 같습니다. 여기서는 'context'를 '내부'로 옮겼는데, 그냥 '컨텍스트'로 두는 것이 좋을 것 같습니다.

[^dot-syntax]: 'dot syntax'는 점 문법으로 옮깁니다.

[^setup]: 'setup'은 일단 '초기 설정'으로 옮깁니다.

[^standard-root-class]: 'standard root class'는 '표준 루트 클래스'로 옮깁니다.

[^override]: 'override'는 의미로 사용될 때는 '덮어 쓰다'로, 키워드로 사용될 때는 'override' 그대로 옮깁니다.

[^property-2]: 키워드의 'property'가 아닌 경우, 키워드의 property와 구분하기 위하여 '성질'이라고 옮깁니다.

[^subscripting]: 'subscripting' 은 Swift 에서 인덱싱 작업을 하기 때문에 '첨자 인덱싱'으로 옮깁니다. 나중에 더 좋은 단어가 있으면 바꿀 생각입니다.

[^named]: 이름이 알려질 정도로 보편화 된 것을 의미하는 것 같습니다. 'named' 는 일단 '보통의' 라고 옮깁니다.

[^abbreviated]: 'abbreviated'는 '축약 형태의'라고 옮깁니다.

[^determine]: 'determine' 은 '결정하다'라고 옮깁니다.

[^associated-value]: 'associated value'는 '연관 값'으로 옮깁니다.

[^stored-property]: 저장 속성은 Swift 의 두가지 속성 중의 하나입니다. 나중에 속성 부분에서 저장 속성에 대해서 정리할 예정입니다.

[^behavior]: 'behavior'는 옮기기 좀 애매한데, 여기서는 일단 '작동 방식'으로 옮깁니다.

[^computed-property]: 'computed property'는 '계산 속성'으로 옮깁니다. 계산 속성에 대해서는 나중에 속성 부분에서 다시 정리합니다.

[^run-time]: 'run time'은 '실행 시간'으로 옮깁니다.

[^compiler]: 컴파일러는 항상 컴파일 시간에만 동작합니다.

[^defer-code]: 이렇게 하면 코드의 유지 보수가 조금 더 쉬워질 수 있을 것 같습니다.

[^form]: 'form' 은 '양식'으로 옮깁니다.

[^generic]: 'generic'은 '일반', '보편'의 의미가 있는데, 일단 여기서는 '제네릭'이라고 발음 그대로 사용해서 새로운 단어로 받아들입니다.

[^requirement]: 'requirement'는 '요구 사항'으로 옮깁니다.