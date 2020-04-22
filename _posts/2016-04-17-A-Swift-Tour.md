---
layout: post
comments: true
title:  "Swift 5.2: A Swift Tour (스위프트 둘러보기)"
date:   2016-04-17 19:45:00 +0900
categories: Swift Language Grammar Tour
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [A Swift Tour](https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html) 부분[^A-Swift-Tour]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## A Swift Tour (스위프트 둘러보기)

전통적으로 새로운 언어로 만든 첫 번째 프로그램은 화면에 `"Hello, world!"` 라는 문장을 출력합니다. 스위프트로는, 이것을 단 한 줄로 할 수 있습니다:

```swift
print("Hello, world!")
// "Hello, world!"  를 출력합니다.
```

C 언어나 오브젝티브-C 언어로 코딩을 해봤다면, 이 구문 표현이 익숙한 듯 보이겠지만-스위프트에서는, 이 코드 한 줄로 프로그램이 완성된 것입니다. 입력/출력이나 문자열 처리와 같은 기능을 위해 개별 라이브러리를 불러올 필요가 없습니다. 전역 범위 공간에 작성한 코드는 프로그램의 진입점으로 사용되므로, `main()` 함수도 필요 없습니다.모든 문장의 끝에 세미콜론을 붙일 필요 또한 없습니다.

이 둘러보기는 스위프트 코드 작성을 시작하기 충분한 정보를 제공해 주기 위해 다양한 프로그래밍 작업을 수행하는 방법을 보이도록 할 것입니다. 어떤 부분에서 이해가 가지 않더라도 당황할 필요 없습니다-이 둘러보기에서 소개한 모든 내용은 이 책의 나머지 부분에서 더 자세하게 다시 설명할 것이기 때문입니다.

> 최고의 경험을 위해, 이 장을 Xcode 에 있는 'playgroud (놀이터)' 로 열어보기 바랍니다. 'playground (놀이터)' 로 코드 목록을 편집하고 그 결과를 즉시 확인할 수 있습니다.
>
> ['playground (놀이터)' 다운로드 하기](https://docs.swift.org/swift-book/GuidedTour/GuidedTour.playground.zip)

### Simple Values (간단한 값들)

`let` 을 사용하여 상수를 만들고 `var` 를 사용하여 변수를 만듭니다. 상수의 값은 컴파일 시간에 알아야 할 필요는 없지만, 그 값을 반드시 정확히 한 번은 할당해야 합니다. 이는 한 번 결정하고 나면 많은 곳에서 사용할 수 있는 값에 이름을 짓는 것이 상수라는 것을 의미합니다.

```swift
var myVariable = 42
myVariable = 50
let myConstant = 42
```

상수나 변수는 반드시 할당하려는 값과 타입이 같아야 합니다. 하지만, 타입을 항상 명시적으로 적어야만 하는 것은 아닙니다. 상수나 변수를 만들 때 값을 제공하면 컴파일러가 그 타입을 추론할 수 있습니다. 위의 예제에서, 컴파일러는 `myVariable` 이 정수라고 추론하는데 이는 초기 값이 정수이기 때문입니다.

초기 값이 충분한 정보를 제공하지 않거나 (혹은 초기 값이 없는 경우), 변수 뒤에 콜론 (`:`) 을 써서 구분한 다음, 타입을 지정하면 됩니다.

```swift
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70
```

> 실험
>
> 명시적인 타입이 `Float` 이고 값이 `4` 인 상수를 만들어 봅시다.

값은 절대 다른 타입으로 암시적으로 변환되지 않습니다. 값을 다른 타입으로 변환할 필요가 있을 경우, 원하는 타입의 인스턴스를 명시적으로 만들어야 합니다.

```swift
let label = "The width is "
let width = 94
let widthLabel = label + String(width)
```

> 실험
>
> 마지막 줄에서 `String` 으로의 변환을 제거해 봅시다. 어떤 에러가 발생합니까?

문자열에 값을 포함시킬 수 있는 더 간단한 방법도 있습니다. 값을 괄호 안에 쓰고, 괄호 앞에 백 슬래시 (`\`) 를 쓰면 됩니다. 예를 들면 다음과 같습니다:

```swift
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."
```

> 실험
>
> `\()` 를 사용하여 문자열에 부동-소수점 연산을 포함시켜 보고 또 인사말에 다른 사람 이름을 포함시켜 봅시다.

따옴표 세 개 (`"""`) 를 써서 여러 줄짜리 문자열을 만들 수 있습니다. 닫는 따옴표 앞에 들여쓰기가 있으면, 그 만큼의 들여쓰기가 각 줄 시작마다 제거됩니다. 예를 들면 다음과 같습니다:

```swift
let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""
```

대괄호 (`[]`) 로 '배열 (arrays)' 과 '딕셔너리 (dictionary)' 를 만들고, 괄호 안에 색인과 키를 작성해서 그 원소에 접근할 수 있습니다. 마지막 원소 뒤에는 쉼표가 있어도 됩니다.

```swift
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"

var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"
```

배열은 원소를 더할 때마다 자동으로 크기가 커집니다.

```swift
shoppingList.append("blue paint")
print(shoppingList)
```

빈 '배열 (array)' 이나 빈 '딕셔너리 (dictionary)' 를 만들려면, '초기자 구문 표현 (initializer syntax)' 을 사용하면 됩니다.

```swift
let emptyArray = [String]()
let emptyDictionary = [String: Float]()
```

타입 정보를 추론할 수 있는 경우에는, 빈 배열은 `[]` 라고 쓸 수 있고 빈 딕셔너리는 `[:]` 라고 쓸 수 있습니다-예를 들어, 변수에 새 값을 설정하거나 함수의 인자로 전달할 때에 해당합니다.

```swift
shoppingList = []
occupations = [:]
```

### Control Flow (제어 흐름)

`if` 와 `switch` 를 사용하여 조건문을 만들고, `for-in`, `while` 그리고 `repeat-while` 을 사용하여 반복문을 만듭니다. 조건이나 반복 변수 주위의 괄호는 선택 사항입니다. 다만 본문 주위의 중괄호는 필수입니다.

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
// "11" 을 출력합니다.  
```

`if` 문에서, '조건절 (the conditional)' 은 반드시 '불린 표현식 (Boolean expression)' 이어야 합니다-이것은 `if score { ... }` 와 같은 코드는 에러가 되는 것이지, 0으로 암시적인 비교를 하는 게 아님을 의미합니다.

`if` 와 `let` 을 같이 사용하여 누락될 수도 있는 값을 다룰 수 있습니다. 이 값은 '옵셔널 (optionals)' 을 써서 나타냅니다. 옵셔널 값은 하나의 값을 가지거나 아니면 값이 누락됐음을 나타내는 `nil` 을 가지고 있습니다. 값의 타입 뒤에 물음표 (`?`) 를 붙여서 그 값이 '옵셔널' 임을 표시합니다.

```swift
var optionalString: String? = "Hello"
print(optionalString == nil)
// "false" 를 출력합니다.

var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}
```

> 실험
>
> `optionalName` 을 `nil` 로 바꿔 보기 바랍니다. 어떤 인사말을 받게 됩니까? `else` 절을 추가해서 `optionalName` 이 `nil` 이면 다른 인사말을 하도록 설정해 보도록 합니다.

옵셔널 값이 `nil` 이면, 조건절이 `false` 가 되어 중괄호 안의 코드를 건너뛰게 됩니다. 그렇지 않다면, 옵셔널 값이 풀려서 `let` 뒤의 상수에 할당되어, 코드 블럭 내부에서 이 풀린 값을 사용할 수 있게 됩니다.

옵셔널 값을 처리하는 또 다른 방법은 `??` 연산자를 사용하여 기본 값을 제공하는 것입니다. 이 경우 옵셔널 값이 누락됐으면, 기본 값을 대신 사용하게 됩니다.

```swift
let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"
```

'switches (스위치)' 문은 모든 종류의 데이터를 지원하며 비교 가능한 연산 종류도 광범위합니다-정수에만 한정되지 않으며 같은 지만 검사할 수 있는 것도 아닙니다.

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
// "Is it a spicy red pepper?" 를 출력합니다.
```

> 실험
>
> '기본 경우 값 (default case)' 을 제거해 봅니다. 어떤 에러를 받게 됩니까?

패턴 안에서 `let` 을 사용하여 패턴에 해당하는 값을 상수에 할당할 수 있음에 주목하기 바랍니다.

'스위치 경우 값 (switch case)' 에 해당하는 코드를 실행하고 나면, '스위치 (switch)' 구문을 빠져 나오게 됩니다. 프로그램 실행은 그 다음 '경우 값 (case)' 으로 계속 이어지지 않으므로, 각 '경우 값 (case)' 의 코드 끝에서 '스위치 (switch) 문' 을 '깨고 나와야 한다 (break out)' 고 명시할 필요가 없습니다.[^break-out]

`for-in` 을 사용하여 '딕셔너리' 에 있는 항목에 동작을 반복 적용시키려면 각각의 '키-값 쌍 (key-value pair)' 에 사용할 '이름 쌍' 을 제공하면 됩니다. '딕셔너리' 는 순서가 없는 '컬렉션 (collection' 이므로, 이 키와 값들은 임의의 순서로 동작을 반복 적용시키게 됩니다.

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
// "25" 를 출력합니다.
```

> 실험
>
> 가장 큰 수가 무엇인지 추적했던 것처럼, 다른 변수를 추가하여 가장 큰 수의 종류가 무엇인지 추적해보기 바랍니다.

`while` 문을 사용하면 조건이 바뀌기 전까지 한 '코드 블럭 (block of code)' 을 반복할 수 있습니다. 반복문이 최소한 한 번은 실행되도록 하려면, 대신 반복 조건을 맨 뒤에 두면 됩니다.

```swift
var n = 2
while n < 100 {
    n = n * 2
}
print(n)
// "128" 을 출력합니다.

var m = 2
repeat {
    m = m * 2
} while m < 100
print(m)
// "128" 을 출력합니다.
```

`..<` 로 색인 범위를 만들면 반복문 내에서 색인을 유지할 수 있습니다.

```swift
var total = 0
for i in 0..<4 {
    total += i
}
print(total)
// "6" 을 출력합니다.
```

최상단 값을 생략하는 범위를 만들려면 `..<` 를 사용하고, 양 끝단의 값을 모두 포함하는 범위를 만들려면 `...` 를 사용하면 됩니다.

### Functions and Closures (함수와 클로져)

`func` 을 사용하여 함수를 선언합니다. 함수 호출은 이름 뒤에 인자 목록을 담은 괄호를 붙여주면 됩니다. `->` 를 사용하여 매개 변수의 이름과 타입을 함수의 반환 타입에서 구분짓도록 합니다.

```swift
func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")
```

> 실험
>
> `day` 매개 변수를 제거해 봅니다. 매개 변수를 추가하여 인사말에 오늘의 점심 특선을 포함시켜 봅니다.

기본적으로, 함수는 매개 변수의 이름을 인자의 '이름표 (labels)' 로 사용합니다. 자신만의 인자 '이름표 (label)' 를 사용하려면 매개 변수 앞에 써 주면 되고, 아무런 인자 이름표 사용하지 않으려면 `_` 를 써주면 됩니다.

```swift
func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")
```

'튜플 (tuple)' 을 사용하면 '복합 값 (compound value)' 을 만들 수 있습니다-예를 들어, 함수에서 여러 값을 반환할 때 쓸 수 있습니다. 튜플의 원소들은 이름이나 번호로 참조할 수 있습니다.

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
// "120" 을 출력합니다.
print(statistics.2)
// "120" 을 출력합니다.
```

함수는 'nested (품어질)' 수 있습니다. 'nested (품어진)' 함수는 외부 함수에서 선언한 변수에 접근할 수 있습니다. 'nested (품어진)' 함수를 사용하여 길고 복잡한 함수의 코드를 정돈할 수 있습니다.

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

함수는 '일급 타입 (first-class type)' 입니다.[^first-class] 이것은 함수가 다른 함수를 값의 형태로 반환할 수 있다는 것을 의미합니다.

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

함수는 다른 함수를 인자의 하나로 받을 수도 있습니다.

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

함수는 실제로는 '클로저 (closures; 잠금 블럭)' 의 특수한 경우에 해당합니다: 여기서 클로저는 나중에 호출할 수 있는 코드 블럭을 말합니다. 클로저의 코드는 클로저가 만들어진 범위 영역에서 사용 가능한 변수와 함수 등에 접근할 수 있는데, 이 범위 영역은 클로저가 실행될 때는 달라져도 상관없습니다-이에 대한 예제는 앞서 'nested (품어진)' 함수에서 이미 살펴봤었습니다. 클로저는 이름 없이 만들 수도 있는데 이 때는 코드를 중괄호 (`{}`) 로 감싸기만 하면 도비니다. 이 경우 `in` 을 사용하여 인자와 반환 값을 본문에서 구분하게 됩니다.

```swift
numbers.map({ (number: Int) -> Int in
    let result = 3 * number
    return result
})
```

> 실험
>
> 클로저가 모든 홀수에 대해 0을 반환하도록 재작성해 봅시다.

클로저를 더 간결하게 작성하기 위한 여러 개의 옵션이 있습니다. 클로저의 타입이 이미 알려진 경우, 가령 '대리자 (delegate)' 의 '콜백 (callback)' 등인 경우, 매개 변수의 타입, 반환 값의 타입, 또는 두 가지 모두를 생략할 수 있습니다. 단일 문장으로 된 클로저는 그 한 문장의 값을 암시적으로 반환합니다.

```swift
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)
// "[60, 57, 21, 36]" 을 출력합니다.
```

매개 변수를 이름 대신 번호로 참조 할 수도 있습니다-이 접근 방법은 클로저가 아주 짧을 때 특히 유용합니다. 함수의 마지막 인자로 전달된 클로저는 괄호 바로 뒤에 나타낼 수 있습니다. 클로저가 함수의 유일한 인자인 경우에는, 괄호를 완전히 생략 할 수도 있습니다.

```swift
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)
```

#### Objects and Classes (객체와 클래스)

`class` 뒤에 그 클래스 이름을 쓰면 '클래스 (class)' 를 만들게 됩니다. 클래스에서 속성의 선언은, 그것이 클래스 영역 안에 있다는 것만 빼면, 그냥 상수나 변수의 선언과 방법이 똑같습니다. 마찬가지로, 메소드와 함수의 선언도 같은 방법으로 하면 됩니다.

```swift
class Shape {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}
```

> 실험
>
> `let` 을 써서 상수 속성을 추가해 봅시다. 인자를 받는 또 다른 메소드도 추가해 봅시다.

클래스의 인스턴스를 만들려면 클래스 이름 뒤에 괄호를 써주면 됩니다. '점 구문 표현 (dot syntax)' 으로 그 인스턴스의 속성과 메소드에 접근할 수 있습니다.

```swift
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()
```

이 버전의 `Shape` 클래스에는 뭔가 중요한 것이 누락됐습니다: 인스턴스가 만들어질 때 클래스를 설정하는 '초기자 (initializer)' 말입니다. `init` 을 사용하여 하나 만들어 봅시다.

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

'초기자' 의 `name` 인자와 `name` 속성을 구별하기 위해 `self` 를 사용하는 방법에 주목하기 바랍니다. 초기자의 인자는 클래스 인스턴스를 만들 때 전달되는 데 이는 함수 호출에서 그런 것과 비슷합니다. 모든 속성에는 값이 할당돼야 합니다-(`numberOfSides` 처럼) 선언에서든 (`name` 처럼) '초기자' 에서든 말입니다.

객체를 해제하기 전에 어떤 정리 작업을 수행해야 할 경우 `deinit` 을 사용하여 '정리자 (deinitializer)' 를 만들도록 합니다.

'하위 클래스 (subclasses)' 는 클래스 이름 뒤에, 콜론으로 구분된, '상위 클래스 (superclass)' 이름을 포함합니다. 클래스가 어떤 '표준 루트 클래스 (standard root class)' 의 '하위 클래스' 여야 한다는 요구 사항은 전혀 없으므로, 필요에 따라 '상위 클래스' 를 포함할 수도 있고 생략할 수도 있습니다.

'하위 클래스' 의 메소드가 '상위 클래스' 의 구현을 '재정의 (override)' 할 경우 `override` 를 써서 표시합니다—우연히 메소드를 재정의하면서, `override` 를 붙이지 않을 경우, 컴파일러는 에러라고 감지합니다. 컴파일러는 메소드에 `override` 를 붙이고도 실제로는 '상위 클래스' 의 어떤 메소드도 재정의하지 않는 경우도 감지합니다.

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

> 실험
>
> 반지름과 이름을 초기자의 인자로 받는 `Circle` 을 이라는 `NamedShape` 의 '하위 클래스' 를 만들어 봅시다. `Circle` 클래스에 `area()` 와 `simpleDescription()` 메소드를 구현해 봅시다.

저장되는 간단한 속성 외에도, 'getter (획득자)' 와 'setter (설정자)' 를 가지는 속성도 있습니다.

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
// "9.3" 을 출력합니다.
triangle.perimeter = 9.9
print(triangle.sideLength)
// "3.3000000000000003" 을 출력합니다.
```

`perimeter` 에 대한 'setter (설정자)' 에서, 새로운 값의 암시적인 이름은 `newValue` 입니다. `set` 뒤에 명시적인 이름을 괄호 안에 써서 제공할 수도 있습니다.

`EquilateralTriangle` 클래스의 초기자는 다음의 세 단계를 가지고 있음에 주목하기 바랍니다:

1. 그 '하위 클래스' 가 선언한 속성의 값을 설정하기
2. '상위 클래스' 의 초기자 호출하기
3. '상위 클래스' 에서 정의한 속성의 값을 바꾸기. 이 시점에서 메소드, 'getter (획득자)', 또는 'setter (설정자)' 를 사용하는 모든 추가적인 설정 작업들도 수행할 수 있습니다.

속성을 계산할 필요는 없지만 새 값의 설정 전후에 실행될 코드를 제공할 필요가 있을 경우, `willSet` 과  `didSet` 을 사용하면 됩니다. 제공한 코드는 초기자 외부에서 값의 변경이 있을 때마다 실행됩니다. 예를 들어, 아래 클래스는 삼각형의 한 변의 길이가 항상 사각형의 한 변의 길이와 같도록 만들어 줍니다.

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
// "10.0" 을 출력합니다.
print(triangleAndSquare.triangle.sideLength)
// "10.0" 을 출력합니다.
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)
// "50.0" 을 출력합니다.
```

'옵셔널 (optional)' 값으로 작업할 때, 메소드, 속성, 그리고 '첨자 연산 (subscripting)' 등의 연산 전에 `?` 를 쓸 수가 있습니다. `?` 앞의 값이 `nil` 이면, `?` 이후의 모든 것은 무시되고 전체 표현식의 값이 `nil` 이 됩니다. 그렇지 않다면, 옵셔널 값은 풀리고, `?` 이후의 모든 것은 이 '풀린 값 (unwrapped value)' 에 대해 작용합니다. 두 경우 모두, 전체 표현식은 옵셔널 값입니다.

```swift
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength
```

### Enumerations and Structures (열거체와 구조체)

열거체를 만들려면 `enum` 을 사용합니다. 클래스와 다른 모든 '이름있는 타입들 (named types)' 처럼, 열거체도 자신과 관련된 메소드를 가질 수 있습니다.

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

> 실험
>
> '원시 값 (raw value)' 을 비교하는 방식으로 두 `Rank` 값을 비교하는 함수를 작성해 봅시다.

기본적으로, 스위프트는 '원시 값 (raw value)' 을 '0' 에서 시작하여 매번 '1' 씩 증가하며 할당하는데, 지정된 값을 명시하면 이 방식을 바꿀 수도 있습니다. 위의 예제에서, `Ace` 의 '원시 값 (raw value)' 은 `1` 로 명시되었으며, 나머지 '원시 값' 들은 순서대로 할당됩니다. 열거체의 원시 (값) 타입으로 '문자열' 이나 '부동-소수점 수' 를 사용하는 것도 가능합니다. '열거체 경우 값 (enumeration case)' 의 '원시 값' 에 접근하려면 `rawValue` 속성을 사용하면 됩니다.

'원시 값' 을 써서 열거체의 인스턴스를 만들려면 `init?(rawValue:)` 초기자를 사용하면 됩니다. 이는 '원시 값' 에 해당하는 '열거체의 경우 값 (enumeration case)' 을 반환하거나 또는 해당하는 `Rank` 가 없을 경우 `nil` 을 반환합니다.

```swift
if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}
```

열거체의 '경우 값 (case values)' 은 실제 값이며, 단순히 '원시 값 (raw values)' 을 표기하는 또 다른 방법인 것이 아닙니다. 실제로, '경우 값' 에 의미있는 '원시 값' 이 없을 때는, 굳이 이를 제공할 필요가 없습니다.

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

> 실험
>
> `Suit` 에 `color()` 메소드를 추가하여, '스페이드' 와 '클럽' 일 때는 "검정색" 을 반환하고, '하트' 와 '다이아몬드' 일 때는 "빨간색" 을 반환하도록 해 봅시다.

위에서 열거체의 '`hearts` 경우 값 (case)' 을 참조할 때 두 가지 다른 방법을 썼음에 주목하기 바랍니다: `hearts` 상수에 값을 할당할 때는, 열거체 경우 값 `Suit.hearts` 이 전체 이름으로 참조됐는데 이는 이 상수에 명시적인 타입이 지정된 것이 없기 때문입니다. 'switch (스위치)' 구문 내부에서는, 열거체의 기본 값이 `.hearts` 라는 단축된 양식으로 참조되었으며 이는 `self` 값이 이미 'suit' 인 것을 알고 있기 때문입니다. 이처럼 값의 타입을 이미 알고 있을 때는 언제든 단축된 양식을 사용할 수 있습니다.

열거체가 원시 값을 가질 경우, 이 값은 선언의 일부로써 결정되며, 이는 특정한 '열거체 경우 값 (enumeration case)' 의 모든 인스턴스는 항상 같은 '원시 값' 을 가진다는 것을 의미합니다. 열거체의 경우 값은 또 다른 선택을 할 수 있는데 그 경우 값에 '관련 값' 을 가지도록 하는 것입니다-이 값이 결정될 때는 인스턴스를 만들 때이므로, '열거체 경우 값' 의 개별 인스턴스마다 다를 수 있습니다. '관련 값 (associated values)' 은 '열거체 경우 값 인스턴스 (enumeration case instance)' 의 '저장 속성' 처럼 동작하는 것으로 생각할 수 있습니다. 예를 들어, 서버에서 일출 시간과 일몰 시간을 요청하는 경우를 고려해 봅시다. 서버의 응답은 요청한 정보일 수도 있고, 또는 뭔가 잘못됐을 경우에 대한 설명일 수도 있습니다.

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
"Sunrise is at 6:00 am and sunset is at 8:09 pm." 을 출력합니다.
```

> 실험
>
> `ServerResponse` 와 'switch (스위치)' 구문에 세 번째 '경우 값 (case)' 을 추가해 봅시다.

해당하는 'switch cases (스위치 경우 값)' 을 맞춰볼 때 어떻게 `ServerResponse` 값에서 일출 시간과 일몰 시간을 추출하고 있는지 주목하기 바랍니다.

구조체를 만들려면 `struct` 를 사용합니다. 구조체는 메소드와 초기자를 포함하여, 클래스에서 지원하는 것과 같은 동작들을 많이 지원합니다. 이런 구조체와 클래스의 가장 중요한 차이점 중 하나는 코드내에서 구조체는 항상 복사에 의해 전달된다는 것으로, 클래스는 참조에 의해 전달된다는 것에서 차이가 있습니다.

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

> 실험
>
> 개별 카드가 '계급 (rank)' 과 '패 (suit)'[^suit] 의 조합인, 온전한 카드 한 벌을 담고 있는 배열을 반환하는 함수를 만들어 봅시다.

### Protocols and Extensions (프로토콜-규약-과 확장)

'프로토콜 (protocol; 규약)' 을 선언하려면 `protocol` 를 사용하면 됩니다.

```swift
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}
```

'클래스 (classes)', '열거체 (enumerations)', 그리고 '구조체 (structs)' 모두 '프로토콜' 을 '채택 (adopt)'[^adopt] 할 수 있습니다.

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

> 실험
>
> `ExampleProtocol` 에 또 다른 '요구 사항 (requirement)' 을 추가해 봅시다. `SimpleClass` 와 `SimpleStructure` 가 여전히 이 프로토콜을 '준수 (conform)' 하도록 하려면 무엇을 바꿔야 할까요?

`SimpleStructure` 선언 내부에서 메소드가 구조체를 수정하고 있음을 표시하기 위해 `mutating` 키워드를 사용함에 주목하기 바랍니다. `SimpleClass` 선언에서는 어떤 메소드도 'mutating (변경)' 표시를 할 필요가 없는데 이는 클래스 메소드는 항상 클래스를 수정할 수 있기 때문입니다.

기존 타입에 `extension` 을 사용하면 새 기능, 가령 새로운 메소드나 '계산 속성 (computed properties)' 을 추가할 수 있습니다. 'extension (확장)' 을 사용하면 다른 곳에서 선언된 타입이나, 또는 라이브러리나 프레임웍에서 'import (불러온)' 타입 까지도, 특정 '프로토콜을 따르도록 (protocol conformance)' 만들 수 있습니다.

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
"The number 7" 을 출력합니다.
```

> 실험
>
> `Double` 타입에 대한 'extension (확장)' 을 만들어서 `absoluteValue` 속성을 추가해 봅시다.

프로토콜 이름은 마치 또 다른 '이름있는 타입 (named type)' 인 것처럼 사용할 수 있습니다-예를 들어, 서로 다른 타입을 가지지만 모두 단일한 프로토콜을 준수하는 객체들의 '컬렉션 (집합체)' 를 만드는데 사용할 수도 있습니다. 값의 타입이 프로토콜 타입인 경우에는, 프로토콜 정의 밖의 메소드를 사용할 수 없습니다.

```swift
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
// "A very simple class.  Now 100% adjusted." 를 출력합니다.
// print(protocolValue.anotherProperty)  // 주석을 제거하면 에러가 발생합니다.
```

`protocolValue` 변수의 '실행 시간 타입 (runtime type)' 이 `SimpleClass` 일지라도, 컴파일러는 주어진 타입을 `ExampleProtocol` 로 취급합니다. 이것은 프로토콜을 준수하게 되면 클래스 구현부의 메소드나 속성에 실수로라도 접근할 수 없다는 것을 의미합니다.

### Error Handling (에러 처리)

'에러 (errors)' 를 나타내려면 `Error` 프로토콜을 '채택 (adopt)' 한 타입을 사용하면 됩니다.

```swift
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}
```

에러를 던지려면 `throw` 를 사용하고 에러를 던질 수 있는 함수라고 표시하려면 `throws `를 사용하면 됩니다. 함수에서 에러를 던지면, 그 함수는 즉시 반환되며 함수를 호출한 코드에서 그 에러를 처리하게 됩니다.

```swift
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner
    }
    return "Job sent"
}
```

에러 처리에는 여러 가지 방법이 있습니다. 한 가지 방법은 `do-catch` 문를 사용하는 것입니다. `do` 블럭 안에서, 에러를 던질 수 있는 코드를 표시하려면 그 앞에 `try` 를 써주면 됩니다. `catch` 블럭 안에서는, 다른 이름을 주지 않았을 경우 에러가 자동으로 `error` 라는 이름을 가지게 됩니다.

```swift
do {
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    print(printerResponse)
} catch {
    print(error)
}
// "Job sent" 를 츨력합니다.
```

> 실험
>
> 프린터 이름을 `"Never Has Toner"` 로 바꿔서, `send(job:toPrinter:)` 함수가 에러를 던지도록 해 봅시다.

여러 개의 `catch` 블럭을 제공해서 지정된 에러들을 처리할 수 있습니다. 'switch (스위치)' 의 `case` 뒤에서 하듯 `catch` 뒤에 '유형 (pattern)' 을 작성하면 됩니다.

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
// "Job sent" 를 츨력합니다.
```

> 실험
>
> `do` 블럭 내부에 에러를 던지는 코드를 추가해 봅시다. 에러가 첫 번째 `catch` 블럭에서 처리되도록 하려면 어떤 종류의 에러를 던지면 됩니까? 두 번째와 세 번째 블럭에서 되게 하려면요?

에러를 처리하는 또 다른 방법은 `try?` 를 사용하여 결과를 옵셔널로 변환하는 것입니다. 함수가 에러를 던지면, 지정된 그 에러를 버리고 결과를 `nil` 이 됩니다. 다른 경우라면, 결과는 함수가 반환한 값을 가지고 있는 옵셔널이 됩니다.

```swift
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")
```

`defer` 를 사용하여 작성된 코드 블럭은, 함수 반환의 바로 직전, 함수 내의 모든 다른 코드의 이후에 실행됩니다. 이 코드는 함수가 에러를 던지는 것과는 상관없이 실행됩니다. `defer` 를 사용하면, 서로 다른 시간에 실행될 필요가 있는, '설정 (setup)' 코드와 '정리 (cleanup)' 코드도 서로 이웃하게 작성할 수 있습니다.

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
// "false" 를 출력합니다.
```

### Generics (일반화)

'일반화된 함수 (generic function)' 나 '일반화된 타입 (generic type)' 을 만들려면 '꺽쇠 괄호 (angle brackets)' 안에 이름을 적으면 됩니다.

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

'클래스 (classes)', '열거체 (enumerations)', 그리고 '구조체 (structures)' 뿐만 아니라 함수와 메소드도 '일반화된 양식 (generic forms)' 으로 만들 수 있습니다.

```swift
// 스위프트 표준 라이브러리의 옵셔널 타입을 재구현한 것임
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)
```

본문 바로 앞에 `where` 를 사용하면 '요구 사항의 목록 (a list of requirements)' 을 지정할 수 있습니다-예를 들어, 타입이 프로토콜을 구현해야 한다는 요구 사항, 두 타입이 같아야 한다는 요구 사항, 또는 클래스가 특정한 '상위 클래스' 를 가져야 한다는 요구 사항 등이 있을 수 있습니다.

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

> 실험
>
> `anyCommonElements(_:_:)` 함수를 수정하여 두 개의 'sequence (나열값들)' 에 공통된 원소의 배열을 반환하는 함수를 만들어 봅시다.


`<T: Equatable>` 이라고 적는 것은 `<T> ... where T: Equatable` 이라고 적는 것과 같습니다.

### 참고 자료

[^A-Swift-Tour]: 원문은 [A Swift Tour](https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html) 에서 확인할 수 있습니다.

[^break-out]: 이 말은 스위프트의 'switch' 구문에서는 각 'case' 절마다 끝에 'break' 를 쓸 필요는 없다는 말을 의미합니다.

[^first-class]: 프로그래밍에서 '일급 (first-class)' 이라는 말은 특정 대상을 '객체' 와 동급으로 사용할 수 있다는 것을 의미합니다. 예를 들어 '객체' 처럼 인자로 전달할 수도 있고, 함수에서 반환할 수 있으며, 다른 변수 등에 할당할 수도 있는 대상이 있다면 이 대상을 '일급 (first-class)' 이라고 할 수 있습니다. 본문 내용은 스위프트에서는 '함수' 도 '객체' 처럼 'first-class' 라서 앞의 동작들을 모두 다 수행할 수 있다는 것을 의미합니다. 보다 자세한 내용은 위키피디아의 [First-class citizen](https://en.wikipedia.org/wiki/First-class_citizen) 과 [일급 객체](https://ko.wikipedia.org/wiki/일급_객체) 항목을 참고하기 바랍니다.

[^suit]: 영어로 'suit' 에는 카드의 '패' 라는 의미가 있으며, '다이아몬드', '하트' 등이 이 'suit' 입니다. 서양 카드에는 4 종류의 'suits' 가 있습니다.

[^adopt]: '프로토콜을 채택한다' 는 것의 의미는 [Protocols (규약)](http://xho95.github.io/swift/language/grammar/protocol/2016/03/03/Protocols.html) 앞 부분에 잘 설명되어 있습니다. '프로토콜을 준수한다' 는 말과는 늬앙스가 조금 다른 것 같습니다.
