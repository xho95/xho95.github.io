---
layout: post
comments: true
title:  "Swift 5.7: A Swift Tour (스위프트 둘러보기)"
date:   2016-04-17 19:45:00 +0900
categories: Swift Language Grammar Tour
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [A Swift Tour](https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html) 부분[^A-Swift-Tour]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## A Swift Tour (스위프트 둘러보기)[^a-swift-tour]

새로운 언어의 첫 번째 프로그램은 `"Hello, world!"` 라는 글을 화면에 인쇄하는게 좋다는 전통이 있습니다.[^hello-world] 스위프트는, 이를 단 한 줄로 할 수 있습니다:

```swift
print("Hello, world!")
// "Hello, world!"  를 인쇄함
```

**C** 나 **오브젝티브-C** 코딩을 해봤으면, 이 구문이 익숙할 건데-스위프트에서, 이 한 줄의 코드가 완전한 프로그램입니다. 입/출력이나 문자열 처리 같은 기능을 위해 별도의 라이브러리를 불러올 필요가 없습니다. 전역[^global-scope] 에서 작성한 코드는 프로그램의 진입점[^entry-point] 으로 사용해서, `main()` 함수도 필요 없습니다. 모든 문장 끝마다 세미콜론을 작성할 필요도 없습니다.

이 둘러보기에선 다양한 프로그래밍 임무를 어떻게 달성하는지를 보여줘서 스위프트 코드 작성을 시작하기에 충분한 정보를 줍니다. 어떤게 이해가 안돼도 걱정할 필요 없습니다-둘러보기에서 소개한 모든 걸 이 책 나머지에서 더 자세히 설명합니다.

> **엑스코드** 를 설치한 **맥** 이나, **스위프트 플레이그라운드** 가 있는 **아이패드** 에선, 이 장을 **플레이그라운드** 로 열 수 있습니다. **플레이그라운드** 로는 나열한 코드를 편집하고 곧바로 결과도 볼 수 있습니다.
>
> [Download Playground (플레이그라운드 다운로드 하기)](https://docs.swift.org/swift-book/GuidedTour/GuidedTour.playground.zip)

### Simple Values (단순한 값)

상수를 만들려면 `let` 을 변수를 만들려면 `var` 를 사용합니다. 상수 값은 컴파일 시간에 알 필요가 없지만, 반드시 값을 정확하게 한 번 할당해야 합니다. 이는 한 번 결정하면 많은 곳에서 사용할 값의 이름을 붙이는데 상수를 사용할 수 있다는 의미입니다.

```swift
var myVariable = 42
myVariable = 50
let myConstant = 42
```

상수나 변수는 반드시 할당하려는 값과 똑같은 타입이어야 합니다. 하지만, 항상 타입을 명시적으로 작성하진 않아도 됩니다. 상수나 변수를 생성할 때 값을 제공하면 컴파일러가 그 타입을 추론하게 합니다. 위 예제는, 초기 값이 정수이기 때문에 `myVariable` 은 정수라고 컴파일러가 추론합니다.

초기 값이 충분한 정보를 제공하지 않을 (또는 초기 값이 없을) 경우, 변수 뒤에, '콜론' 으로 구분하여, 작성함으로써 타입을 지정합니다.

```swift
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70
```

> 실험
>
> 명시적인 타입이 `Float` 이고 값이 `4` 인 상수를 생성해 봅니다.

값은 절대 또 다른 타입으로 암시적으로 변환되지 않습니다. 값을 다른 타입으로 변환할 필요가 있으면, 원하는 타입의 인스턴스를 명시적으로 만들어야 합니다.

```swift
let label = "The width is "
let width = 94
let widthLabel = label + String(width)
```

> 실험
>
> 마지막 줄의 `String` 변환을 제거해 봅니다. 무슨 에러를 가지게 됩니까?

심지어 문자열이 값을 포함하는 더 단순한 방식도 있는데: 괄호 안에 값을 작성하고, 괄호 앞에 '역 빗금 (backshlash; `\`)' 을 작성하는 것입니다. 예를 들면 다음과 같습니다:

```swift
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."
```

> 실험
>
> `\()` 로 문자열에 부동-소수점 계산 값을 포함시켜 보고 인사말에 누군가의 이름을 포함시켜 봅니다.

'여러 줄 (lines) 을 차지하는 문자열' 에는 '세 따옴표 (`"""`)' 를 사용합니다. 각 줄 시작마다, '닫는 따옴표의 들여쓰기' 와 일치하는 만큼의, 들여쓰기를 제거합니다.[^indentation] 예를 들면 다음과 같습니다:

```swift
let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""
```

'배열 (arrays) 과 딕셔너리 (dictionary)' 는 '대괄호 (`[]`)' 로 생성하며, '대괄호 안에 색인 (index) 이나 키 (key) 를 작성' 함으로써 그 원소에 접근합니다. 마지막 원소 뒤에 '쉼표 (comma)' 가 있어도 됩니다.

```swift
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"

var occupations = [
  "Malcolm": "Captain",
  "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"
```

원소를 추가하면 배열이 자동으로 커집니다.

```swift
shoppingList.append("blue paint")
print(shoppingList)
```

빈 배열이나 딕셔너리를 생성하려면, '초기자 구문 (initializer syntax)' 을 사용합니다.

```swift
let emptyArray = [String]()
let emptyDictionary = [String: Float]()
```

'타입 정보' 를 추론할 수 있으면, 예를 들어, 변수에 새 값을 설정하거나 함수에 인자를 전달할 때-'빈 배열은 `[]`' 로 '빈 딕셔너리는 `[:]`' 라고 작성할 수 있습니다.

```swift
shoppingList = []
occupations = [:]
```

### Control Flow (제어 흐름)

조건문을 만들려면 `if` 와 `switch` 를 사용하고, 반복문을 만들려면 `for`-`in`, `while`, 그리고 `repeat`-`while` 을 사용합니다. 조건이나 반복 변수 주변의 괄호는 옵션입니다. 본문 주변의 '중괄호' 는 필수입니다.

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

`if` 문의, 조건 절은 반드시 '불리언 (Boolean) 표현식' 이어야 하는데-이는 `if score { ... }` 같은 코드, 0과 암시적인 비교를 하는 것이 아니라, 에러라는 의미입니다.

'빠졌을 지도 모를 값' 과 작업하는 데는 `if` 와 `let` 을 함께 사용할 수 있습니다. 이 값들은 '옵셔널 (optionals)' 로 표현합니다. '옵셔널 값' 은 값을 담고 있든지 아니면 값이 빠졌다고 지시하는 `nil` 을 담고 있습니다. 값의 타입 뒤에 '물음표 (`?`)' 를 작성하여 값을 옵셔널로 표시합니다.

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
> `optionalName` 을 `nil` 로 바꿔 봅니다. 어떤 인사말을 가지게 됩니까? `else` 절을 추가하여 `optionalName` 이 `nil` 이면 다른 인사말을 설정해 봅니다.

옵셔널 값이 `nil` 이면, 조건절은 `false` 이고 중괄호 안의 코드는 건너뜁니다. 그 외 경우, 옵셔널 값의 포장을 풀고 `let` 뒤의 상수에 할당하여, 코드 블럭 안에서 '포장 푼 값 (unwrapped value)' 을 사용 가능하게 합니다.

옵셔널 값을 처리하는 또 다른 방법은 `??` 연산자로 '기본 (default) 값' 을 제공하는 것입니다. 옵셔널 값이 빠졌으면, '기본 값' 을 대신 사용합니다.

```swift
let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"
```

switch 문은 어떤 종류의 자료와도 아주 다양한 비교 연산을 지원합니다-'정수와 같음 비교 (equality) 테스트' 만으로 제한하지 않습니다.

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
> '기본 (default) case 절' 을 제거해 봅니다. 무슨 에러를 가지게 됩니까?

'패턴 (pattern) 과 일치하는 값을 상수에 할당' 하기 위해 '패턴에서 `let` 을 사용하는 방법' 에 주목하기 바랍니다.

'일치한 switch 문 case 절 안의 코드를 실행' 한 후, 프로그램은 'switch 문' 을 빠져 나갑니다. 그 다음 'case 절' 을 계속 실행하진 않으므로, 각 'case 절 코드' 끝에서 'switch 문을 명시적으로 깨고 (break) 나올 필요' 는 없습니다.[^break-out]

'딕셔너리 (dictionary) 항목' 에 '각각의 키-값 쌍 (key-value pair) 에서 사용할 이름 쌍' 을 제공함으로써 동작을 반복하려면 `for`-`in` 을 사용합니다. 딕셔너리는 '순서 없는 집합체 (unordered collection)'[^unordered-collection] 이므로, 임의의 순서로 키와 값을 반복합니다.

```swift
let interestingNumbers = [
  "Prime": [2, 3, 5, 7, 11, 13],
  "Fibonacci": [1, 1, 2, 3, 5, 8],
  "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (_, numbers) in interestingNumbers {
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
> `_` 를 변수 이름으로 대체하여, 가장 큰 수의 종류가 무엇인지를 추적해 봅니다.

조건이 바뀔 때까지 '코드 블럭' 을 반복하려면 `while` 문을 사용합니다. 반복문을 적어도 한 번은 실행하도록, 반복문 조건이 끝에 있을 수도 있습니다.

```swift
var n = 2
while n < 100 {
  n = n * 2
}
print(n)
// "128" 을 인쇄합니다.

var m = 2
repeat {
  m = m * 2
} while m < 100
print(m)
// "128" 을 인쇄합니다.
```

`..<` 로 '색인 범위 (range of indexes)' 를 만들면 반복 회차에서 '색인' 을 유지할 수 있습니다.

```swift
var total = 0
for i in 0..<4 {
  total += i
}
print(total)
// "6" 을 인쇄합니다.
```

'최상단 값 (upper value) 을 생략한 범위' 를 만들려면 `..<` 을 사용하며, '양 끝단 값 둘 다 포함한 범위' 를 만들려면 `...` 를 사용합니다.

### Functions and Closures (함수와 클로져)

`func` 으로 함수를 선언합니다. 이름 뒤에 인자 목록을 담은 괄호를 붙여 함수를 호출합니다. `->` 로 '매개 변수 이름과 타입' 을 '함수 반환 타입' 과 구분합니다.

```swift
func greet(person: String, day: String) -> String {
  return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")
```

> 실험
>
> `day` 매개 변수를 제거해 봅니다. '인사말에 오늘의 점심 특선을 포함하는 매개 변수' 를 추가해 봅니다.

기본적으로, 함수는 '자신의 매개 변수 이름' 을 '인자 이름표 (labels)' 로 사용합니다. 매개 변수 이름 앞에 '사용자 정의 인자 이름표' 를 작성하거나, 아무런 인자 이름표를 사용하지 않기 위한 `_` 를 작성합니다.

```swift
func greet(_ person: String, on day: String) -> String {
  return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")
```

'튜플 (tuple)' 로는-예를 들어, '여러 값' 을 함수에서 반환하기 위한-'복합 값 (compound value)' 을 만듭니다. 튜플 원소는 '이름' 이나 '번호' 로 참조할 수 있습니다.

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

함수는 중첩할 수 있습니다. '중첩 함수 (nested functions)' 는 바깥 함수에서 선언한 변수에 접근할 수 있습니다. 중첩 함수로 길고 복잡한 함수 코드를 정돈할 수 있습니다.

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

함수는 '일급 타입 (first-class type)' 입니다.[^first-class] 이는 함수가 또 다른 함수를 자신의 값으로 반환할 수 있다는 의미입니다.

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

함수는 또 다른 함수를 자신의 인자로 취할 수 있습니다.

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

함수는 사실: 나중에 호출 할 수 있는 '코드 블럭' 인, '클로저 (closure)' 의 한 특수한 종류입니다. 클로저 코드는, 실행할 때의 클로저가 다른 영역인 경우에도, 클로저를 생성한 영역에서 사용 가능한 변수와 함수 같은 것들에 접근할 수 있습니다-이 예제는 '중첩 함수' 부분에서 이미 봤습니다. '이름 없는 클로저' 는 '중괄호 (`{}`) 로 코드를 둘러쌈' 으로써 작성할 수 있습니다. `in` 으로 인자와 반환 타입을 본문과 구분합니다.

```swift
numbers.map({ (number: Int) -> Int in
  let result = 3 * number
  return result
})
```

> 실험
>
> 모든 홀수마다 '0' 을 반환하도록 클로저를 재작성해 봅니다.

클로저를 더 간결하게 작성하는 여러 옵션들이 있습니다. '대리자 (delegate) 에 대한 콜백 (callback)' 같이, 클로저 타입을 이미 알고 있으면, 그 매개 변수, 반환 타입, 또는 둘 다의 타입을 생략할 수 있습니다. '단일 구문 클로저 (single statement closures)' 는 자신의 유일한 구문 값을 암시적으로 반환합니다.

```swift
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)
// "[60, 57, 21, 36]" 을 인쇄합니다.
```

매개 변수는 '이름' 대신 '번호 (number)' 로 참조 할 수 있습니다-이 접근 방식은 특히 클로저가 아주 짧을 때 유용합니다. 함수 마지막 인자로 전달한 클로저는 괄호 바로 뒤에 나타날 수 있습니다. 클로저가 함수의 유일한 인자일 때는, 괄호 전체를 생략할 수 있습니다.

```swift
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)
// "[20, 19, 12, 7]" 을 인쇄합니다.
```

### Objects and Classes (객체와 클래스)

클래스는 `class` 뒤에 '클래스 이름' 을 붙여서 생성합니다. 클래스의 속성 선언은, 클래스 안이라는 것만 제외하면, 상수나 변수 선언과 똑같은 방식으로 작성합니다. 마찬가지로, 메소드와 함수 선언도 똑같은 방식으로 작성합니다.

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
> `let` 으로 상수 속성을 추가하고, 인자를 취하는 또 다른 메소드를 추가해 봅니다.

클래스 인스턴스는 클래스 이름 뒤에 괄호를 둬서 생성합니다. 인스턴스의 속성과 메소드에 접근하려면 '점 구문 (dot syntax)' 을 사용합니다.

```swift
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()
```

이 버전의 `Shape` 클래스에는 뭔가 중요한 것이 빠졌는데: 인스턴스를 생성할 때 클래스를 설정하는 '초기자 (initializer)' 가 그것입니다. `init` 으로 하나 생성합니다.

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

`name` 속성과 초기자의 `name` 인자를 구별하기 위해 `self` 를 사용하는 방법에 주목하기 바랍니다. 클래스의 인스턴스를 생성할 때 함수 호출 처럼 초기자 인자를 전달합니다. 모든 속성은-(`numberOfSides` 과 같이) 자신의 선언에서든 (`name` 과 같은) 초기자에서든-할당 값이 필요합니다.

객체 해제 전에 어떠한 청소가 필요하면 `deinit` 을 써서 정리자 (deinitializer) 를 생성합니다.

'하위 클래스 (subclasses)' 는 자신의 클래스 이름 뒤에, 콜론으로 구분한, '상위 클래스 (superclass) 이름' 을 포함합니다. 클래스가 '어떤 표준 근원 클래스 (standard root class)[^standard-root-class] 의 하위 클래스' 라는 '필수 조건 (requirement)' 은 없으므로, 필요에 따라 상위 클래스를 포함하거나 생략할 수 있습니다.

'상위 클래스 구현을 재정의 (override) 한 하위 클래스 메소드' 는 `override` 로 표시합니다—`override` 없이, 우연히 재정의한 메소드는, 컴파일러가 에러라고 탐지합니다. 실제로는 상위 클래스의 어떤 메소드도 재정의하지 않으면서 `override` 를 가진 메소드도 컴파일러가 탐지합니다.

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
> 초기자 인자로 반지름과 이름을 취하는 `Circle` 이라는 `NamedShape` 의 또 다른 하위 클래스를 만들어 봅니다. `Circle` 클래스에 대해 `area()` 와 `simpleDescription()` 메소드를 구현해 봅니다.

저장을 한다는 단순한 속성에 더하여, 속성은 '획득자 (getter)' 와 '설정자 (setter)' 를 가질 수 있습니다.[^getter-and-setter]

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

`perimeter` 의 '설정자' 안에서, 새 값은 `newValue` 라는 암시적인 이름을 가집니다. 명시적인 이름은 `set` 뒤의 괄호에서 제공할 수 있습니다.

`EquilateralTriangle` 클래스의 초기자는 서로 다른 세 단계를 거친다는 것에 주목하기 바랍니다:

1. 하위 클래스가 선언한 속성 값 설정하기
2. 상위 클래스의 초기자 호출하기
3. 상위 클래스가 정의한 속성 값 바꾸기. 이 시점에서 메소드, 획득자, 또는 설정자를 사용한 어떤 추가적인 설정 작업도 할 수 있음.

속성을 계산할 필요는 없지만 여전히 새 값 설정 전후에 실행할 코드를 제공할 필요가 있다면, `willSet` 과  `didSet` 을 사용합니다. 제공한 코드는 값이 초기자 밖에서 바뀔 때마다 실행됩니다. 예를 들어, 아래 클래스는 삼각형 한 변 길이가 정사각형 한 변 길이와 항상 똑같도록 보장합니다.

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

'옵셔널 값' 과 작업할 때는, '메소드, 속성, 및 첨자 연산 (subscripting)' 같은 연산 앞에 `?` 를 작성할 수 있습니다. `?` 앞의 값이 `nil` 이면, `?` 뒤의 모든 것을 무시하며 전체 표현식 값은 `nil` 입니다. 그 외 경우, 옵셔널 값의 포장을 풀며, `?` 뒤의 모든 것을 '포장 푼 값' 에 작용합니다. 두 경우 모두, 전체 표현식 값이 옵셔널 값입니다.

```swift
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength
```

### Enumerations and Structures (열거체와 구조체)

열거체는 `enum` 으로 생성합니다. 클래스 및 '그 외 모든 이름 붙인 (named) 타입' 같이, 열거체는 자신과 결합된 메소드[^methods-associated] 를 가질 수 있습니다.

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
> '서로의 원시 값 (raw value) 을 비교함' 으로써 '두 `Rank` 값을 비교하는 함수' 를 작성해 봅니다.

기본적으로, 스위프트는 '0에서 시작해서 매번 1씩 증가하는 원시 값 (raw value)' 을 할당하지만, 값을 명시적으로 지정함으로써 이 동작을 바꿀 수 있습니다. 위 예제에선, `Ace` 에 `1` 이라는 원시 값을 명시적으로 부여하며, 나머지 원시 값은 순서대로 할당합니다. 문자열이나 부동-소수점 수를 열거체의 원시 타입으로 사용할 수도 있습니다. '열거체 case 값 (enumeration case) 의 원시 값' 에 접근하려면 `rawValue` 속성을 사용합니다.

원시 값으로 열거체의 인스턴스를 만들려면 `init?(rawValue:)` 초기자를 사용합니다. 이는 '원시 값과 일치하는 열거체 case 값을 반환' 하거나 아니면 '일치하는 `Rank` 가 없을 경우 `nil` 을 반환' 합니다.

```swift
if let convertedRank = Rank(rawValue: 3) {
  let threeDescription = convertedRank.simpleDescription()
}
```

'열거체 case 값' 은, 자신의 원시 값을 작성하는 또 다른 방식인 것이 아니라, '실제 값' 입니다. 사실상, 원시 값이 의미가 없을 경우, 이를 제공하지 않아도 됩니다.

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
> `Suit` 에, '스페이드 (spades) 와 클럽 (clubs)' 이면 "검정색 (black)" 을 반환하고, '하트 (hearts) 와 다이아몬드 (diamonds)' 면 "빨간색 (red)" 을 반환하는 `color()` 메소드를 추가해 봅니다.

위에서 두 가지 방식으로 '열거체 `hearts` case 값' 을 참조함을 주목하기 바랍니다: `hearts` 상수에 값을 할당할 때는, 상수에 명시적인 타입을 지정하지 않았기 때문에 `Suit.hearts` 라는 전체 이름으로 열거체 case 값을 참조합니다. 'switch 문' 에서는, `self` 값이 '패 (suit)'[^suit] 임을 이미 알고 있기 때문에 `.hearts` 라는 단축 형식으로 열거체 case 값을 참조합니다. 값의 타입을 이미 알 때는 언제든 단축 형식을 사용할 수 있습니다.

열거체가 원시 값을 가진 경우, 해당 값은 선언 시에 결정하는데, 이는 '특별한 열거체 case 의 모든 인스턴스는 항상 똑같은 원시 값을 가진다' 는 의미입니다. '열거체 case 를 위한 또 다른 선택' 은 'case 값과 결합된 (associated) 값을 가지는 것' 입니다-이 값들은 인스턴스를 만들 때 결정하며, '열거체 case 의 각 인스턴스' 마다 서로 다를 수 있습니다. '결합 값 (associated values)' 은 '열거체 case 인스턴스의 저장 (stored) 속성 같이 작동한다' 고 생각할 수 있습니다. 예를 들어, 서버에 일출과 일몰 시간을 요청하는 경우를 고려합니다. 서버는 요청받은 정보를 가지고 응답하든지, 아니면 뭔가 잘못됐다는 설명을 가지고 응답힙니다.

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
> `ServerResponse` 와 'switch 문' 에 '세 번째 case 값' 을 추가해 봅니다.

'switch 문 case 절' 과 값을 맞춰볼 때 `ServerResponse` 값에서 일출과 일몰 시간을 추출하는 방법에 주목하기 바랍니다.

구조체는 `struct` 로 생성합니다. 구조체는 클래스와 똑같이, 메소드와 초기자를 포함한, 많은 동작을 지원합니다. 구조체와 클래스의 가장 중요한 차이점은 주변 코드로 전달할 때 구조체는 항상 복사하지만, 클래스는 참조로 전달한다는 것입니다.

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
> 각각의 카드가 '계급 (rank) 과 패 (suit)[^suit] 의 조합' 인, '카드 한 벌 (full deck) 을 담은 배열' 을 반환하는 함수를 작성해 봅니다.

### Protocols and Extensions (프로토콜과 익스텐션)

'프로토콜 (protocol)' 은 `protocol` 로 선언합니다.

```swift
protocol ExampleProtocol {
  var simpleDescription: String { get }
  mutating func adjust()
}
```

클래스, 열거체, 그리고 구조체 모두 프로토콜을 '채택 (adopt)'[^adopt] 할 수 있습니다.

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
> 또 다른 '필수 조건 (requirement)' 을 `ExampleProtocol` 에 추가해 봅니다. `SimpleClass` 와 `SimpleStructure` 가 프로토콜을 여전히 '준수 (conform)' 하도록 하려면 무엇을 바꿔야 합니까?

구조체를 수정하는 메소드를 표시하고자 `SimpleStructure` 선언에 `mutating` 키워드를 사용함에 주목하기 바랍니다. `SimpleClass` 선언은 자신의 어떤 메소드도 '변경 (mutating)' 으로 표시할 필요가 없는데 클래스 메소드는 항상 클래스를 수정할 수 있기 때문입니다.

`extension` 으로 기존 타입에, 새로운 '메소드나 계산 (computed) 속성' 같은, 기능을 추가합니다. 다른 곳에서 선언한 타입, 또는 심지어 라이브러리나 프레임웍에서 불러온 타입에, '프로토콜 준수성 (protocol conformance)'[^protocol-conformance] 을 추가하기 위해 '익스텐션 (extension)' 을 사용할 수 있습니다.

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
> `Double` 타입에 `absoluteValue` 속성을 추가하는 '익스텐션' 을 작성해 봅니다.

'프로토콜 이름' 은 그냥 다른 어떤 '이름 붙인 (named) 타입' 인 것처럼-예를 들어, 서로 다른 타입이지만 모두 단일 프로토콜을 준수하는 '객체의 집합체 (collection)' 을 생성하는데-사용할 수 있습니다. 프로토콜 타입인 값과 작업할 때는, 프로토콜 정의 밖의 메소드를 사용할 수 없습니다.

```swift
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
// "A very simple class.  Now 100% adjusted." 를 인쇄합니다.
// print(protocolValue.anotherProperty)  // 주석을 제거하면 에러가 나타납니다.
```

`protocolValue` 변수의 '실행 시간 (runtime) 타입' 이 `SimpleClass` 일지라도, 컴파일러는 주어진 타입이 `ExampleProtocol` 인 것처럼 취급합니다. 이는 자신의 프로토콜 준수성과는 별개로 클래스가 구현한 메소드나 속성에 접근하는 사고가 일어날 순 없다는 의미입니다.

### Error Handling (에러 처리)

`Error` 프로토콜을 채택한 어떤 타입으로 에러를 표현합니다.

```swift
enum PrinterError: Error {
  case outOfPaper
  case noToner
  case onFire
}
```

`throw` 로 에러를 던지고 `throws` 로 에러를 던질 수 있는 함수를 표시합니다. 함수에서 에러를 던지면, 함수는 곧바로 반환하며 함수를 호출한 코드가 에러를 처리합니다.

```swift
func send(job: Int, toPrinter printerName: String) throws -> String {
  if printerName == "Never Has Toner" {
    throw PrinterError.noToner
  }
  return "Job sent"
}
```

에러 처리에는 여러 가지 방법이 있습니다. 한 가지는 `do`-`catch` 문을 사용하는 것입니다. `do` 블럭 안에서, 앞에 `try` 를 작성함으로써 에러를 던질 수 있는 코드를 표시합니다. `catch` 블럭 안에서, 에러는 다른 이름을 주지 않은 한 `error` 라는 이름을 자동으로 가집니다.

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
> '인쇄기 (printer) 이름' 을 `"Never Has Toner"` 로 바꿔서, `send(job:toPrinter:)` 함수가 에러를 던지게 해봅니다.

특정 에러를 처리하는 '여러 개의 `catch` 블럭' 을 제공할 수 있습니다. 그냥 'switch 문' 의 `case` 뒤에 하듯이 `catch` 뒤에 '패턴 (pattern)' 을 작성하면 됩니다.

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
> `do` 블럭 안에 에러를 던지는 코드를 추가해 봅니다. 무슨 종류의 에러를 던져야 첫 번째 `catch` 블럭에서 에러를 처리합니까? 무엇을 던져야 두 번째와 세 번째 블럭에서 합니까?

에러를 처리하는 또 다른 방법은 결과를 옵셔널로 변환하는 `try?` 를 사용하는 것입니다. 함수가 에러를 던지면, 특정 에러를 버려서 결과가 `nil` 이 됩니다. 그 외의 경우, 결과는 '함수 반환 값을 담은 옵셔널' 이 됩니다.

```swift
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")
```

`defer` 로 '함수 반환 직전에, 함수의 다른 모든 코드 뒤에 실행할 코드 블럭' 을 작성합니다. 코드는 함수가 에러를 던지는 지와는 상관없이 실행합니다. `defer` 를 사용하면, 서로 다른 시간에 실행할, 설정 (setup) 및 정리 (cleanup) 코드일지라도, 나란히 작성할 수 있습니다.

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
// "false" 를 인쇄함
```

### Generics (일반화)

'꺽쇠 괄호 (angle brackets) 안에 이름을 작성' 하여 '일반화 (generic) 함수나 타입' 을 만듭니다.

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

클래스, 열거체, 및 구조체 뿐만 아니라, '함수와 메소드에 대한 일반화 형식 (generic forms)' 도 만들 수 있습니다.

```swift
// 스위프트 표준 라이브러리에 있는 옵셔널 타입을 재구현한 것
enum OptionalValue<Wrapped> {
  case none
  case some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)
```

`where` 를 본문 바로 앞에 사용하여 '필수 조건 (requirements) 목록'-예를 들어, 타입이 프로토콜을 구현하도록 요구하거나, 두 타입이 똑같을 것을 요구, 또는 클래스가 특별한 상위 클래스를 가질 것을 요구하는 등-을 지정합니다.

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
> `anyCommonElements(_:_:)` 함수를 수정하여 '두 시퀀스 (sequence)[^sequence] 에 공통인 원소 배열을 반환하는 함수' 를 만들어 봅니다.


`<T: Equatable>` 이라고 작성하는 것은 `<T> ... where T: Equatable` 이라고 작성하는 것과 똑같습니다.

### 다음 장

[The Basics (기초) > ]({% post_url 2016-04-24-The-Basics %})

### 참고 자료

[^A-Swift-Tour]: 원문은 [A Swift Tour](https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html) 에서 확인할 수 있습니다.

[^a-swift-tour]: 영어의 **Swift** 에는 재빠르다라는 의미도 있기 때문에, 이 장의 제목인 **A Swift Tour** 는 **재빨리 둘러보기** 라는 중의적인 의미도 가지고 있습니다.

[^hello-world]: `"Hello, world!"` 를 출력하는게 전통이 된 것은, 1978년 [The C Programming Language](https://en.wikipedia.org/wiki/The_C_Programming_Language) 라는 책에 이 예제가 처음으로 등장하면서부터입니다. 이 책의 공동 저자 중 한 사람이 **유닉스** 와 **C 언어** 를 개발한, 그 유명한 [Dennis Ritchie (데니스 리치)](https://en.wikipedia.org/wiki/Dennis_Ritchie) 입니다.

[^global-scope]: '전역 (global scope)' 이란 어떤 영역에도 속하지 않는 프로그램의 가장 바깥쪽 영역입니다. 

[^entry-point]: '진입점 (entry point)' 이란 프로그램 실행을 시작하는 지점을 말합니다. 보통의 프로그래밍 언어에선 `main()` 함수를 자신의 진입점으로 사용합니다.

[^indentation]: 이 부분은 말로 하는 설명보다는 예제를 보는 것이 이해하기 더 쉽습니다. 관련 예제는, [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) 장의 [Multiline String Literals (여러 줄짜리 문자열 글자 값)](#multiline-string-literals-여러-줄짜리-문자열-글자-값) 부분을 보도록 합니다.

[^break-out]: ''switch 문을 명시적으로 깨고 (break) 나올 필요는 없다' 는 것은 'switch 문의 각 case 절마다 `break` 를 쓸 필요는 없다' 는 의미입니다.

[^first-class]: 프로그래밍에서 '일급 (first-class)' 이라는 말은 특정 대상을 '객체' 와 동급으로 사용할 수 있다는 것을 의미합니다. 예를 들어, '일급 (first-class) 인 대상' 은 '객체' 처럼 인자로 전달할 수도 있고, 함수에서 반환할 수도 있으며, 다른 변수 등에 할당할 수도 있습니다. 스위프트에서는 '함수' 도 '일급 (first-class) 타입' 이기 때문에, 인자 전달, 함수 반환, 변수 할당 등에 사용할 수 있다는 의미입니다. '일급 객체' 에 대한 더 자세한 정보는, 위키피디아의 [First-class citizen](https://en.wikipedia.org/wiki/First-class_citizen) 과 [일급 객체](https://ko.wikipedia.org/wiki/일급_객체) 항목을 보도록 합니다.

[^suit]: 영어로 'suit' 에는 카드의 '패' 라는 의미가 있으며, '다이아몬드', '하트' 등이 이 'suit' 입니다. 서양 카드에는 4 종류의 'suits' 가 있습니다.

[^adopt]: '프로토콜을 채택한다' 는 것의 의미는 [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 앞 부분에 잘 설명되어 있습니다. '프로토콜을 준수한다 (conform to a protocol)' 는 것과는 의미가 조금 다릅니다

[^protocol-conformance]: '프로토콜 준수성 (protocol conformance)' 에 대한 더 자세한 내용은 [Adding Protocol Conformance with an Extension (익스텐션으로 프로토콜 준수성 추가하기)]({% post_url 2016-03-03-Protocols %}#adding-protocol-conformance-with-an-extension-익스텐션으로-프로토콜-준수성-추가하기) 부분을 보도록 합니다.

[^standard-root-class]: 여기서 말하는 '표준 근원 클래스 (standard root class)' 는 오브젝티브-C 의 `NSObject` 와 같은 클래스를 말하며, 스위프트에는 이런 식의 클래스가 없습니다.

[^getter-and-setter]: 사실 여기서 말하는 '간단한 속성' 과 '획득자 및 설정자를 가지는 속성' 은 서로 다른 것입니다. 전자를 '저장 속성 (stored properties)' 라고 하고 후자를 '계산 속성 (computed properties)' 라고 합니다. 책의 다른 부분에서 많이 설명하고 있기 때문인지, 여기서는 이 둘을 딱히 구분하지 않고 설명하고 있습니다. 보다 자세한 내용은 [Properties (속성)]({% post_url 2020-05-30-Properties %}) 부분을 보도록 합니다.

[^unordered-collection]: '순서 있는 집합체 (ordered collections)' 와 '정렬된 집합체 (sorted collection)' 는 수학적으로 의미가 다릅니다. 이 둘의 차이점에 대해서는, '스택 오버플로우 (StackOverflow)' 의 [What is the difference between an ordered and a sorted collection?](https://stackoverflow.com/questions/1084146/what-is-the-difference-between-an-ordered-and-a-sorted-collection) 항목을 보도록 합니다. 향후 'order' 는 '순서' 로, 'sort' 는 '정렬' 로 옮기도록 합니다. 

[^methods-associated]: '열거체가 자신과 결합된 메소드 (methods associated with them) 를 가질 수 있다' 는 말은 '열거체가 멤버 함수를 가질 수 있다' 는 의미입니다.

[^sequence]: 컴퓨터 자료 구조의 하나인 '시퀀스 (sequence)' 는 원래 수학 용어인 '수열' 에서 온 개념입니다. 그러므로 해당 문장은 '두 수열에 공통인 원소 배열을 반환하는 함수' 라고 이해할 수도 있습니다.