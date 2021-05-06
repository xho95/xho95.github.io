---
layout: post
comments: true
title:  "Swift 5.4: A Swift Tour (스위프트 둘러보기)"
date:   2016-04-17 19:45:00 +0900
categories: Swift Language Grammar Tour
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.4)](https://docs.swift.org/swift-book/) 책의 [A Swift Tour](https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html) 부분[^A-Swift-Tour]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.4: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## A Swift Tour (스위프트 둘러보기)[^a-swift-tour]

전통적으로 새로운 언어의 첫 프로그램은 `"Hello, world!"` 라는 말을 화면에 쇄합니다. 스위프트는, 이를 단 한 줄로 할 수 있습니다:

```swift
print("Hello, world!")
// "Hello, world!"  를 인쇄합니다.
```

'C' 나 '오브젝티브-C' 로 코딩을 해봤다면, 이 '구문 표현 (syntax)' 이 익숙해 보이겠지만-스위프트에서는, 이 한 줄의 코드가 완전한 프로그램입니다. 입/출력 또는 문자열 처리 같은 기능을 위해 별도의 라이브러리를 불러올 필요가 없습니다. 전역 범위에서 작성된 코드는 프로그램의 '진입점 (entry point)' 으로 사용되므로, `main()` 함수도 필요 없습니다. 구문 끝에 매번 세미콜론을 작성할 필요도 없습니다.

'둘러보기' 에서는 스위프트로 코드 작성을 시작하기에 충분한 정보를 제공하고자 다양한 프로그래밍 임무를 달성하는 방법을 보입니다. 이해가 안되는 것이 있어도 걱정할 필요 없습니다-둘러보기에서 소개한 모든 것들을 이 책의 나머지 부분에서 더 자세히 설명하기 때문입니다.

> 최상의 경험을 위해서, 이 장을 '엑스코드 (Xcode)' 에 있는 '플레이그라운드 (Playgrounds; 놀이터)' 로 열도록 합니다. '플레이그라운드' 는 나열된 코드를 편집하고 결과를 즉시 확인할 수 있게 해줍니다.
>
> [Download Playground (플레이그라운드 다운로드 하기)](https://docs.swift.org/swift-book/GuidedTour/GuidedTour.playground.zip)

### Simple Values (간단한 값)

`let` 을 사용해서 상수를 만들고 `var` 를 사용해서 변수를 만듭니다. 상수의 값을 컴파일 시간에 알아야 하는 건 아니지만, 반드시 한 번은 정확하게 값을 할당해야 합니다. 이는 결정은 한 번만 하지만 많은 곳에서 사용하는 값에 이름을 짓기 위해 상수를 사용할 수 있다는 것을 의미합니다.

```swift
var myVariable = 42
myVariable = 50
let myConstant = 42
```

상수나 변수는 반드시 할당하고자 하는 값과 같은 타입을 가져야 합니다. 하지만, 타입을 항상 명시적으로 작성해야 하는 것은 아닙니다. 상수나 변수를 생성할 때 값을 제공하면 컴파일러가 타입을 추론하게 됩니다. 위 예제에서, 컴파일러는 `myVariable` 을 정수라고 추론하는데 초기 값이 정수이기 때문입니다.

초기 값이 충분한 정보를 제공하지 않는 (아니면 초기 값이 없는) 경우, 변수 뒤에, 콜론 (`:`) 으로 구분된, 타입을 작성하여 지정합니다.

```swift
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70
```

> 실험
>
> 명시적인 타입이 `Float` 이고 값이 `4` 인 상수를 생성해 봅시다.

값은 절대 다른 타입으로 암시적으로 변환되지 않습니다. 값을 다른 타입으로 변환해야 한다면, 원하는 타입의 인스턴스를 명시적으로 만들도록 합니다.

```swift
let label = "The width is "
let width = 94
let widthLabel = label + String(width)
```

> 실험
>
> 마지막 줄에서 `String` 으로의 변환을 제거해 봅시다. 어떤 에러를 갖게 됩니까?

문자열에 값을 포함시키는 더 간단한 방법도 있습니다: 괄호 안에 값을 작성하고, 그 괄호 앞에 '역 빗금 기호 (backshlash; `\`)' 를 작성합니다. 예를 들면 다음과 같습니다:

```swift
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."
```

> 실험
>
> `\()` 를 사용해서 문자열에 부동-소수점 계산을 포함시켜 보고 인사말에 어떤 사람의 이름을 포함시켜 봅시다.

'여러 줄 (multiple lines)' 을 차지하는 문자열은 '세 따옴표 (three double quotation marks; `"""`)' 를 사용합니다. 각 줄의 시작시마다, '닫는 따옴표' 의 들여쓰기와 일치하는 만큼의, 들여쓰기를 제거합니다.[^indentation] 예를 들면 다음과 같습니다:

```swift
let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""
```

대괄호 (brackets, `[]`) 를 사용하여 '배열 (arrays)' 과 '딕셔너리 (dictionary)' 를 생성하며, 대괄호 안에 '색인 (index)' 또는 '키 (key)' 를 작성하여 이들의 원소에 접근합니다. 마지막 원소 뒤에 '쉼표 (comma)' 를 두는 것도 허용합니다.

```swift
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"

var occupations = [
  "Malcolm": "Captain",
  "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"
```

배열은 원소를 추가하면 자동으로 커집니다.

```swift
shoppingList.append("blue paint")
print(shoppingList)
```

빈 배열 또는 딕셔너리를 생성하려면, '초기자 구문 표현 (initializer syntax)' 을 사용합니다.

```swift
let emptyArray = [String]()
let emptyDictionary = [String: Float]()
```

'타입 정보' 를 추론할 수 있는 경우, 빈 배열은 `[]` 로 그리고 빈 딕셔너리는 `[:]` 로 작성할 수 있습니다-예를 들어, 변수에 대해서 새로운 값을 설정할 때 또는 함수에 인자로 전달할 때에 그렇습니다.

```swift
shoppingList = []
occupations = [:]
```

### Control Flow (제어 흐름)

`if` 와 `switch` 를 사용해서 조건문을 만들고, `for`-`in`, `while`, 그리고 `repeat`-`while` 을 사용해서 반복문을 만듭니다. 조건문이나 반복문 변수 주위의 괄호는 선택 사항입니다. 본문 주위의 '중괄호 (braces)' 는 필수입니다.

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
// "11" 을 인쇄합니다.  
```

`if` 문에 있는, '조건절 (the conditional)' 은 반드시 '불리언 표현식 (Boolean expression)' 이어야 합니다-이것은 `if score { ... }` 와 같은 코드는 에러이며, '0' 과 암시적인 비교를 하는 것이 아니라는 것을, 의미합니다.

'없을 (missing)' 수도 있는 값과 작업하기 위해 `if` 와 `let` 을 함께 사용할 수 있습니다. 이러한 값은 '옵셔널 (optionals)' 로 표현합니다. '옵셔널 값' 은 값을 담고 있거나 아니면 값의 없음을 지시하는 `nil` 을 담고 있습니다. 값을 옵셔널로 표시하려면 값의 타입 뒤에 '물음표 (`?`)' 를 작성합니다.

```swift
var optionalString: String? = "Hello"
print(optionalString == nil)
// "false" 를 인쇄합니다.

var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
  greeting = "Hello, \(name)"
}
```

> 실험
>
> `optionalName` 을 `nil` 로 바꿔 봅시다. 어떤 인사말을 갖게 됩니까? `optionalName` 이 `nil` 이면 다른 인사말을 설정하도록 `else` 절을 추가해 봅시다.

옵셔널 값이 `nil` 이면, 조건절은 `false` 이고 중괄호 안의 코드를 건너뜁니다. 다른 경우라면, 옵셔널 값의 포장을 풀어서 `let` 뒤의 상수에 할당하는데, 이는 코드 블럭 안에서 '포장이 풀린 값 (unwrapped value)' 을 사용 가능하게 만듭니다.

옵셔널 값을 처리하는 또 다른 방법은 `??` 연산자를 사용하여 '기본 값 (default value)' 을 제공하는 것입니다. 옵셔널 값이 없으면, '기본 값' 을 대신 사용합니다.

```swift
let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"
```

'switch 문' 은 어떤 종류의 '자료형 (data)' 도 지원하며 폭넓고 다양한 비교 연산도 지원합니다-정수만 되고 '같음 (equality)' 비교만 테스트하도록 제한되지 않았습니다.

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
// "Is it a spicy red pepper?" 를 인쇄합니다.
```

> 실험
>
> '기본 (default) case 절' 을 제거해 봅니다. 어떤 에러를 갖게 됩니까?

'유형 (pattern; 패턴)' 과 일치하는 값을 상수에 할당하기 위해 '유형 (pattern)' 안에서 `let` 을 사용할 수 있는 방법이 있음에 주목하도록 합니다.

일치한 'switch 문의 case 절' 내의 코드를 실행한 후에는, 프로그램이 'switch 문' 을 빠져 나옵니다. 실행은 그 다음 'case 절' 로 계속되는 않으므로, 각 'case 절' 의 코드 끝에서 'switch 문' 을 명시적으로 '끊고 (break)' 나올 필요가 없습니다.[^break-out]

`for`-`in` 을 사용하여 '딕셔너리' 에 있는 항목 전체에 동작을 반복시키려면 각각의 '키-값 쌍 (key-value pair)' 에 사용할 '이름 쌍' 을 제공하도록 합니다. 딕셔너리는 '정렬되지 않은 컬렉션 (unordered collection)' 이므로, 전체 키와 값은 임의 순서로 동작합니다.

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
// "25" 를 인쇄합니다.
```

> 실험
>
> 가장 큰 수에 대해 한 것처럼, 가장 큰 수의 종류가 무엇인지 추적하는 또 다른 변수를 추가해 봅시다.

조건이 바뀔 때까지 '코드 블럭' 을 반복하려면 `while` 문을 사용합니다. 반복문이 최소 한 번은 실행됨을 보장하기 위해, 반복 조건을 끝에 대신 둘 수 있습니다.

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

`..<` 를 사용하여 '색인의 범위 (range of indexes)' 를 만들면 반복 시에 '색인' 을 유지할 수 있습니다.

```swift
var total = 0
for i in 0..<4 {
  total += i
}
print(total)
// "6" 을 인쇄합니다.
```

'최상단 값 (upper value)' 을 생략한 범위를 만들려면 `..<` 을 사용하고, 양 끝단 값을 모두 포함하는 범위를 만들려면 `...` 를 사용합니다.

### Functions and Closures (함수와 클로져)

`func` 을 사용하여 함수를 선언합니다. 함수 호출은 이름 뒤에 인자 목록이 있는 괄호를 붙여서 합니다. `->` 로 매개 변수의 이름과 타입을 함수의 반환 타입과 구분합니다.

```swift
func greet(person: String, day: String) -> String {
  return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")
```

> 실험
>
> `day` 매개 변수를 제거해 봅시다. 오늘의 점심 특선을 인사말에 포함하는 매개 변수를 추가해 봅시다.

기본적으로, 함수는 매개 변수 이름을 인자의 '이름표 (labels)' 로 사용합니다. 매개 변수 이름 앞에 '사용자 정의 인자 이름표 (custom argument label)' 를 작성하거나, 또는 인자 이름표를 사용하지 않기 위한 `_` 를 작성합니다.

```swift
func greet(_ person: String, on day: String) -> String {
  return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")
```

'튜플 (tuple)' 을 사용하여 '복합 값 (compound value)'-예를 들어, 함수에서 '여러 개의 값 (multiple values)' 을 반환하는-것을 만듭니다. 튜플의 원소는 이름이나 번호로 참조할 수 있습니다.

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
// "120" 을 인쇄합니다.
print(statistics.2)
// "120" 을 인쇄합니다.
```

함수는 중첩될 수 있습니다. '중첩된 함수 (nested functions)' 는 외부 함수에서 선언한 변수에 접근할 수 있습니다. 중첩된 함수를 사용하면 길고 복잡한 함수 코드를 정돈할 수 있습니다.

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

함수는 '일급 타입 (first-class type)' 입니다.[^first-class] 이는 함수가 또 다른 함수를 값처럼 반환할 수 있다는 의미입니다.

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

함수는 또 다른 함수를 하나의 인자처럼 받을 수 있습니다.

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

함수는 사실, 나중에 호출 할 수 있는 '코드 블럭' 인: '클로저 (closure; 잠금 블럭)' 의 한 특수한 경우에 해당합니다. 클로저의 코드는 클로저가 생성된 영역에서 사용 가능한 변수와 함수 같은 것에 접근할 수 있는데, 이는 실행할 때 클로저가 다른 영역에 있더라도 그렇습니다-이에 대한 예제는 '중첩된 함수' 에서 이미 봤습니다. 코드를 중괄호 (`{}`) 로 감싸서 '이름 없는 클로저' 를 작성할 수 있습니다. `in` 으로 인자와 반환 타입을 본문과 구분합니다.

```swift
numbers.map({ (number: Int) -> Int in
  let result = 3 * number
  return result
})
```

> 실험
>
> 클로저를 재작성하여 모든 홀수에 대해서 '0' 을 반환하도록 해봅시다.

클로저를 더 간결하게 작성하기 위한 몇 가지 옵션이 있습니다. '대리자 (delegate)' 에 대한 '콜백 (callback)' 처럼, 클로저의 타입을 이미 알고 있으면, 매개 변수, 반환 타입, 또는 둘 다의 타입을 생략할 수 있습니다. '단일 구문 클로저 (single statement closures)' 는 암시적으로 유일한 구문의 값을 반환합니다.

```swift
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)
// "[60, 57, 21, 36]" 을 인쇄합니다.
```

매개 변수를 이름 대신 '번호 (number)' 로 참조 할 수 있습니다-이 접근 방식은 특히 클로저가 아주 짧을 때 좋습니다. 함수의 마지막 인자로 전달된 클로저는 괄호 바로 뒤에 둘 수 있습니다. 클로저가 함수의 유일한 인자일 때, 괄호 전체를 생략할 수 있습니다.

```swift
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)
// "[20, 19, 12, 7]" 을 인쇄합니다.
```

### Objects and Classes (객체와 클래스)

`class` 뒤에 클래스 이름을 붙여서 클래스를 생성합니다. 클래스 내의 속성 선언은, 클래스인 상황이라는 것만 제외하면, 상수나 변수 선언과 작성 방법이 똑같습니다. 마찬가지로, 메소드와 함수 선언도 같은 방법으로 작성합니다.

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
> `let` 으로 상수 속성을 추가하고, 인자를 받는 또 다른 메소드도 추가해 봅시다.

클래스의 인스턴스는 클래스 이름 뒤에 괄호를 붙임으로써 생성합니다. 인스턴스의 속성과 메소드에 대한 접근은 '점 구문 표현 (dot syntax)' 을 사용합니다.

```swift
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()
```

이 버전의 `Shape` 클래스는 뭔가 중요한 것이 빠졌습니다: 인스턴스를 생성할 때 클래스를 설정하는 '초기자 (initializer)' 입니다. `init` 을 사용하여 하나 생성해 봅니다.

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

`self` 를 사용하여 `name` 속성과 '초기자' 의 `name` 인자를 구별하는 방법에 주목합니다. 초기자의 인자는 클래스의 인스턴스를 생성할 때 함수 호출인 것처럼 전달됩니다. 모든 속성은-(`numberOfSides` 에서 처럼) 선언에서든 (`name` 에서 처럼) 초기자에서든-할당된 값이 필요합니다.

객체를 해제하기 전에 어떤 정리 작업을 수행할 필요가 있다면 `deinit` 으로 '정리자 (deinitializer)' 를 생성합니다.

'하위 클래스 (subclasses)' 는 '상위 클래스 (superclass)' 이름을 클래스 이름 뒤에, 콜론으로 구분하여, 포함합니다. 클래스가 어떤 '표준 근원 클래스 (standard root class)'[^standard-root-class] 의 하위 클래스여야 한다는 '필수 조건 (requirement)' 은 없으므로, 필요에 따라 상위 클래스를 포함하거나 생략할 수 있습니다.

상위 클래스의 구현을 '재정의 (override)' 하는 하위 클래스의 메소드는 `override` 로 표시합니다—`override` 없이, 우연히 메소드를 재정의하는 것은, 컴파일러가 에러라고 감지합니다. 컴파일러는 실제로는 상위 클래스의 어떤 메소드도 재정의하지 않는 `override` 메소드도 감지합니다.

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
> `NamedShape` 의 또 다른 하위 클래스로 반지름과 이름을 초기자의 인자로 받는 `Circle` 을 만들어 봅시다. `Circle` 클래스에 대한 `area()` 와 `simpleDescription()` 메소드를 구현해 봅시다.

저장된다는 단순한 속성에 더하여, 속성은 '획득자 (getter)' 와 '설정자 (setter)' 를 가질 수 있습니다.[^getter-and-setter]

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
// "9.3" 을 인쇄합니다.
triangle.perimeter = 9.9
print(triangle.sideLength)
// "3.3000000000000003" 을 인쇄합니다.
```

`perimeter` 의 '설정자' 안에서, 새로운 값은 `newValue` 라는 암시적인 이름을 가집니다. `set` 뒤의 괄호에서 명시적인 이름을 제공할 수 있습니다.

`EquilateralTriangle` 클래스의 초기자는 세 가지 다른 단계를 가진다는 것에 주목합니다:

1. 하위 클래스가 선언한 속성의 값을 설정함
2. 상위 클래스의 초기자를 호출함
3. 상위 클래스에서 정의한 속성의 값을 바꿈. 이 시점에서 메소드, 획득자, 및 설정자를 사용한 어떤 추가적인 설정 작업도 할 수 있음.

속성을 계산할 필요는 없지만 새 값의 설정 전후에 실행할 코드를 아직 제공해야 하는 경우, `willSet` 과  `didSet` 을 사용합니다. 제공한 코드는 초기자 밖에서 값이 바뀔 때마다 실행됩니다. 예를 들어, 아래 클래스는 삼각형의 한 변의 길이가 정사각형의 한 변의 길이와 같음을 항상 보장합니다.

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
// "10.0" 을 인쇄합니다.
print(triangleAndSquare.triangle.sideLength)
// "10.0" 을 인쇄합니다.
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)
// "50.0" 을 인쇄합니다.
```

옵셔널 값과 작업할 때, 메소드, 속성, 그리고 '첨자 연산 (subscripting)' 같은 연산 앞에 `?` 를 작성할 수 있습니다. `?` 앞의 값이 `nil` 이면, `?` 뒤의 모든 것을 무시하며 전체 표현식의 값은 `nil` 입니다. 다른 경우, 옵셔널 값의 포장을 풀고, `?` 뒤의 모든 것이 '포장이 풀린 값 (unwrapped value)' 에 작용합니다. 두 경우 모두, 전체 표현식은 옵셔널 값입니다.

```swift
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength
```

### Enumerations and Structures (열거체와 구조체)

`enum` 을 사용하여 열거체를 생성합니다. 클래스와 다른 모든 '이름 붙은 (named) 타입' 같이, 열거체는 자신과 결합된 메소드를 가질 수 있습니다.

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
> '원시 값 (raw value)' 을 비교해서 두 `Rank` 값을 비교하는 함수를 작성해 봅시다.

기본적으로, 스위프트는 '0' 에서 시작해서 매번 '1' 씩 증가하는 '원시 값 (raw value)' 을 할당하지만, 이 작동 방식은 값을 명시적으로 지정함으로써 바꿀 수 있습니다. 위 예제에서, `Ace` 는 `1` 이라는 원시 값을 명시적으로 부여받으며, 나머지 원시 값은 순서대로 할당됩니다. 열거체의 원시 타입으로 문자열이나 부동-소수점 수도 사용할 수 있습니다. '열거체 case 값 (enumeration case)' 의 원시 값에 접근하려면 `rawValue` 속성을 사용합니다.

원시 값을 가지고 열거체의 인스턴스를 만들려면`init?(rawValue:)` 초기자를 사용합니다. 이는 원시 값과 일치하는 '열거체 case 값' 을 반환하거나 일치하는 `Rank` 가 없을 경우 `nil` 을 반환합니다.

```swift
if let convertedRank = Rank(rawValue: 3) {
  let threeDescription = convertedRank.simpleDescription()
}
```

열거체의 'case 값' 은, 원시 값을 작성하는 또 다른 방법이 아니라, 실제 값입니다. 사실상, 원시 값이 의미가 없는 경우, 이를 제공할 필요가 없습니다.

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
> `'스페이드 (spades)' 와 '클럽 (clubs)' 이면 "검정색 (black)" 을 반환하고, '하트 (hearts)' 와 '다이아몬드 (diamonds)' 면 "빨간색 (red)" 을 반환하는 `color()` 라는 메소드를 `Suit` 에 추가해 봅시다.

위에서 두 가지 방식으로 열거체의 `hearts` 'case 값' 을 참조한 것에 주목합니다: `hearts` 상수에 값을 할당할 때는, 열거체 case 값인 `Suit.hearts` 를 전체 이름으로 참조하는데 이는 상수에 지정된 명시적인 타입이 없기 때문입니다. 'switch 문' 안에서는, 열거체 case 값을 단축 형식인 `.hearts` 로 참조하는데 이는 `self` 값이 'suit' 임을 이미 알고 있기 때문입니다. 값의 타입을 이미 알고 있을 때는 언제든지 단축 형식을 사용할 수 있습니다.

열거체가 원시 값을 가지고 있으면, 그 값은 선언 시에 결정되는데, 이는 특정 '열거체 case 값' 의 모든 인스턴스는 항상 똑같은 원시 값을 가진다는 의미입니다. '열거체 case 값' 에 대한 또 다른 선택은 'case 값' 과 '결합된 (associated)' 값을 가지게 하는 겁니다-이 값은 인스턴스를 만들 때 결정되며, '열거체 case 값' 의 각 인스턴스마다 서로 다를 수 있습니다. '결합 값 (associated values)' 은 '열거체 case 값 인스턴스' 의 '저장 속성 (stored properties)' 처럼 작동한다고 생각해도 됩니다. 예를 들어, 서버에서 일출 시간과 일몰 시간을 요청하는 경우를 고려해 봅시다. 서버는 요청받은 정보를 가지고 응답하거나, 뭔가 잘못된 것의 설명을 가지고 응답합니다.

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
// "Sunrise is at 6:00 am and sunset is at 8:09 pm." 을 인쇄합니다.
```

> 실험
>
> `ServerResponse` 와 'switch 문' 에 세 번째 'case 값' 을 추가해 봅시다.

'switch 문의 case 절' 과 값이 일치하는지 맞춰보는 부분에서 `ServerResponse` 값의 일출 시간과 일몰 시간이 추출되는 방법에 주목합니다.

`struct` 를 사용하여 구조체를 생성합니다. 구조체는, 메소드와 초기자를 포함하여, 클래스와 똑같은 작동 방식을 많이 지원합니다. 구조체와 클래스 사이의 가장 중요한 차이점 하나는, 클래스는 참조로써 전달되지만, 구조체는 코드에서 전달될 때 항상 복사된다는 것입니다.

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
> 각각의 카드가 '계급 (rank)' 과 '패 (suit)'[^suit] 의 조합인, 온전한 한 벌의 카드 배열을 반환하는 함수를 작성해 봅시다.  

### Protocols and Extensions (프로토콜과 익스텐션; 규약과 확장)

`protocol` 를 사용하여 '프로토콜 (protocol; 규약)' 을 선언합니다.

```swift
protocol ExampleProtocol {
  var simpleDescription: String { get }
  mutating func adjust()
}
```

클래스, 열거체, 그리고 구조체는 모두 프로토콜을 '채택 (adopt)'[^adopt] 할 수 있습니다.

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
> `ExampleProtocol` 에 또 다른 '필수 조건 (requirement)' 을 추가해 봅시다. 무엇을 바꿔야 `SimpleClass` 와 `SimpleStructure` 가 여전히 프로토콜을 '준수 (conform)' 하게 만들 수 있습니까?

`SimpleStructure` 선언에서는 구조체를 수정하는 메소드를 `mutating` 키워드로 표시함에 주목합니다. `SimpleClass` 의 선언에서는 어떤 메소드도 '변경 (mutating)' 이라고 표시할 필요가 없는데 클래스의 메소드는 클래스를 항상 수정할 수 있기 때문입니다.

`extension` 을 사용하여 기존 타입에, 새로운 메소드나 새로운 '계산 속성 (computed properties)' 같은, 기능성을 추가합니다. '익스텐션 (extension; 확장)' 은 다른 곳에서 선언한 타입, 또는 심지어 라이브러리나 프레임웍에서 불러온 타입에도, '프로토콜 준수성 (protocol conformance)'[^protocol-conformance] 을 추가할 수 있습니다.

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
// "The number 7" 을 인쇄합니다.
```

> 실험
>
> `Double` 타입에 `absoluteValue` 속성을 추가하는 '익스텐션' 을 작성해 봅시다.

'프로토콜 이름' 은 다른 어떤 '이름 붙은 (named) 타입' 처럼-예를 들어, 타입이 서로 다르지만 모두 단일 프로토콜을 준수하는 객체의 '컬렉션 (collection)' 을 생성하기 위해-사용할 수 있습니다. 타입이 프로토콜 타입인 값과 작업할 때, 프로토콜 정의 밖의 메소드는 사용 불가능합니다.

```swift
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
// "A very simple class.  Now 100% adjusted." 를 인쇄합니다.
// print(protocolValue.anotherProperty)  // 주석을 제거하면 에러가 나타납니다.
```

`protocolValue` 변수의 '실행 시간 타입 (runtime type)' 이 `SimpleClass` 이더라도, 컴파일러는 주어진 타입이 `ExampleProtocol` 인 것처럼 취급합니다. 이는 프로토콜 준수와 별개로 클래스가 구현한 메소드나 속성에 예기치 않게 접근하는 일은 안생긴다는 의미입니다.

### Error Handling (에러 처리)

에러는 `Error` 프로토콜을 '채택한 (adopts)' 어떤 타입으로 표현합니다.

```swift
enum PrinterError: Error {
  case outOfPaper
  case noToner
  case onFire
}
```

`throw` 를 사용하여 에러를 던지고 `throws` 로 에러를 던질 수 있는 함수를 표시합니다. 함수에서 에러를 던지면, 함수는 즉시 반환하며 함수를 호출한 코드가 에러를 처리합니다.

```swift
func send(job: Int, toPrinter printerName: String) throws -> String {
  if printerName == "Never Has Toner" {
    throw PrinterError.noToner
  }
  return "Job sent"
}
```

에러 처리에는 여러 가지 방법이 있습니다. 한 가지는 `do`-`catch` 문을 사용하는 것입니다. `do` 블럭 내에서, 에러를 던질 수 있는 코드는 그 앞에 `try` 를 써서 표시합니다. `catch` 블럭 내에서, 에러는 다른 이름을 부여하지 않는 이상 자동으로 `error` 라는 이름을 부여합니다.

```swift
do {
  let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
  print(printerResponse)
} catch {
  print(error)
}
// "Job sent" 를 인쇄합니다.
```

> 실험
>
> 프린터 이름을 `"Never Has Toner"` 로 바꿔서, `send(job:toPrinter:)` 함수가 에러를 던지게 해봅시다.

'다중 `catch` 블럭' 을 제공하여 지정된 에러를 처리하게 할 수 있습니다. 'switch 문' 의 `case` 절 뒤에 하는 것처럼 `catch` 절 뒤에 '유형 (pattern; 패턴)' 을 작성합니다.

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
// "Job sent" 를 인쇄합니다.
```

> 실험
>
> `do` 블럭 내에 에러를 던지는 코드를 추가해 봅시다. 무슨 종류의 에러를 던져야 에러가 첫 번째 `catch` 블럭에서 처리됩니까? 두 번째와 세 번째 블럭에 대해서는 무엇입니까?

에러를 처리하는 또 다른 방법은 `try?` 를 사용하여 결과를 옵셔널로 변환하는 것입니다. 함수가 에러를 던지면, 지정된 에러를 버리고 결과는 `nil` 이 됩니다. 다른 경우, 결과는 함수가 반환한 값을 담은 옵셔널이 됩니다.

```swift
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")
```

`defer` 를 사용하여 작성한 코드는, 함수 반환 바로 직전에, 함수에 있는 모든 다른 코드 다음에 실행됩니다. 이 코드는 함수가 에러를 던지더라도 이에 상관없이 실행됩니다. `defer` 를 사용하면, 서로 다른 시간에 실행되어야 하는, '설정 (setup) 코드' 와 '정리 (cleanup) 코드' 도 서로 나란하게 작성할 수 있습니다.

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
// "false" 를 인쇄합니다.
```

### Generics (일반화)

'꺽쇠 괄호 (angle brackets)' 안에 이름을 작성하여 '일반화한 (generic) 함수' 나 '일반화한 (generic) 타입' 을 만듭니다.

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

클래스, 열거체, 그리고 구조체 뿐만 아니라, 함수와 메소드의 '일반화 형식 (generic forms)' 도 만들 수 있습니다.

```swift
// 스위프트 표준 라이브러리의 옵셔널 타입을 재구현함
enum OptionalValue<Wrapped> {
  case none
  case some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)
```

본문 바로 앞에 `where` 를 사용하여 '필수 조건 (requirements)' 목록-예를 들어, 타입이 프로토콜을 필수로 구현할 것, 두 개의 타입이 필수로 같을 것, 또는 클래스가 특정 상위 클래스를 필수로 가질 것 등-을 지정합니다.

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
> `anyCommonElements(_:_:)` 함수를 수정하여 두 '수열 (sequence)' 에 공통인 원소의 배열을 반환하는 함수를 만들어 봅시다.


`<T: Equatable>` 로 작성하는 것은 `<T> ... where T: Equatable` 로 작성하는 것과 똑같습니다.

### 다음 장

[The Basics (기초) > ]({% post_url 2016-04-24-The-Basics %})

### 참고 자료

[^A-Swift-Tour]: 원문은 [A Swift Tour](https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^a-swift-tour]: 'Swift' 는 '재빠른' 이라는 의미도 가지고 있기 때문에, 이 장의 제목인 'A Swift Tour' 는 '재빨리 둘러보기' 라는 중의적인 의미도 가지고 있습니다.

[^indentation]: 이 부분은 설명보다는 예제를 보는 것이 이해하기 좋은데, 예제는 [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) 의 [Multiline String Literals (여러 줄짜리 문자열 글자 값)](#multiline-string-literals-여러-줄짜리-문자열-글자-값) 부분에 있습니다.

[^break-out]: 이 말은 스위프트의 'switch 문' 에서는 각 'case 절' 끝마다 'break' 를 쓸 필요가 없다는 것을 의미입니다.

[^first-class]: 프로그래밍에서 '일급 (first-class)' 이라는 말은 특정 대상을 '객체' 와 동급으로 사용할 수 있다는 것을 의미합니다. 예를 들어 '객체' 처럼 인자로 전달할 수도 있고, 함수에서 반환할 수 있으며, 다른 변수 등에 할당할 수도 있는 대상이 있다면 이 대상을 '일급 (first-class)' 이라고 할 수 있습니다. 본문 내용은 스위프트에서는 '함수' 도 '객체' 처럼 'first-class' 라서 앞의 동작들을 모두 다 수행할 수 있다는 것을 의미합니다. 보다 자세한 내용은 위키피디아의 [First-class citizen](https://en.wikipedia.org/wiki/First-class_citizen) 과 [일급 객체](https://ko.wikipedia.org/wiki/일급_객체) 항목을 참고하기 바랍니다.

[^suit]: 영어로 'suit' 에는 카드의 '패' 라는 의미가 있으며, '다이아몬드', '하트' 등이 이 'suit' 입니다. 서양 카드에는 4 종류의 'suits' 가 있습니다.

[^adopt]: '프로토콜을 채택한다' 는 것의 의미는 [Protocols (규약)]({% post_url 2016-03-03-Protocols %}) 앞 부분에 잘 설명되어 있습니다. '프로토콜을 준수한다 (conform to a protocol)' 는 것과는 의미가 조금 다릅니다

[^protocol-conformance]: '프로토콜 준수성 (protocol conformance)' 에 대한 더 자세한 내용은 [Adding Protocol Conformance with an Extension (익스텐션으로 프로토콜 준수성 추가하기)]({% post_url 2016-03-03-Protocols %}#adding-protocol-conformance-with-an-extension-익스텐션으로-프로토콜-준수성-추가하기) 부분을 참고하기 바랍니다.

[^standard-root-class]: 여기서 말하는 '표준 근원 클래스 (standard root class)' 는 오브젝티브-C 언어의 `NSObject` 같은 클래스를 말하는 것으로, 스위프트에는 이런 `NSObject` 같은 클래스가 없다는 의미입니다.

[^getter-and-setter]: 사실 여기서 말하는 '간단한 속성' 과 '획득자 및 설정자를 가지는 속성' 은 서로 다른 것입니다. 전자를 '저장 속성 (stored properties)' 라고 하고 후자를 '계산 속성 (computed properties)' 라고 합니다. 책의 다른 부분에서 많이 설명하고 있기 때문인지, 여기서는 이 둘을 딱히 구분하지 않고 설명하고 있습니다. 보다 자세한 내용은 [Properties (속성)]({% post_url 2020-05-30-Properties %}) 부분을 참고하기 바랍니다.
