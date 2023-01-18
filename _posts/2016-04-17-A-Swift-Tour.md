---
layout: post
pagination:
  enabled: true
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

이 둘러보기는 다양한 프로그래밍 임무를 어떻게 해내는지 보여줌으로써 스위프트로 코드 작성을 시작하기에 충분한 정보를 줍니다. 어떤게 이해가 안돼도 걱정할 필요 없습니다-이 책 나머지 부분에서 이 둘러보기에서 소개한 모든 걸 더 자세히 설명합니다.

> **엑스코드** 를 설치한 **맥** 이나, **스위프트 플레이그라운드** 가 있는 **아이패드** 에선, 이 장을 **플레이그라운드** 로 열 수 있습니다. **플레이그라운드** 로는 나열한 코드를 편집하고 곧바로 결과도 볼 수 있습니다.
>
> [Download Playground (플레이그라운드 다운로드 하기)](https://docs.swift.org/swift-book/GuidedTour/GuidedTour.playground.zip)

### Simple Values (단순한 값)

`let` 으로 상수를 만들고 `var` 로 변수를 만듭니다. 상수 값은 컴파일 시간에 알 필요가 없지만, 반드시 정확하게 한 번 값을 할당해야 합니다. 이는 상수로는 한 번만 결정하면 수많은 곳에서 쓸 값의 이름을 지을 수 있다는 의미입니다.

```swift
var myVariable = 42
myVariable = 50
let myConstant = 42
```

상수나 변수는 반드시 할당하고 싶은 값과 똑같은 타입이어야 합니다. 하지만, 항상 타입을 명시하진 않아도 됩니다. 상수나 변수를 생성할 때 값을 제공하면 컴파일러가 타입을 추론합니다. 위 예제에선, 컴파일러가 `myVariable` 를 정수로 추론하는데 이는 초기 값이 정수이기 때문입니다.

초기 값이 충분한 정보를 제공하지 않(거나 초기 값이 없)으면, 콜론으로 구분한, 변수 뒤에 타입을 작성하여 지정합니다.

```swift
let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70
```

> 실험
>
> 명시적 타입이 `Float` 이고 값이 `4` 인 상수를 생성해 봅니다.

값을 절대 다른 타입으로 암시적으로 자동 변환하지 않습니다.[^convert] 값을 다른 타입으로 변환할 필요가 있으면, 원하는 타입의 인스턴스를 명시적으로 만듭니다.

```swift
let label = "The width is "
let width = 94
let widthLabel = label + String(width)
```

> 실험
>
> 마지막 줄에 있는 `String` 으로의 변환을 제거해 봅니다. 무슨 에러가 뜹니까?

심지어 문자열에 값을 포함하는 더 단순한 방식도 있는데: 괄호 안에 값을 쓰고, 괄호 앞에 역 빗금 (backshlash; `\`) 을 쓰는 겁니다. 예를 들면 다음과 같습니다:

```swift
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."
```

> 실험
>
> `\()` 를 써서 문자열에 부동-소수점 계산도 포함시키고 인사말에 어떤 사람의 이름도 포함시켜 봅니다.

여러 줄을 차지하는 문자열엔 세 개의 큰 따옴표 (`"""`) 를 사용합니다. 각각의 따온 줄 시작에 있는 들여쓰기는, 닫는 따옴표의 들여쓰기와 일치하는 만큼, 제거합니다.[^indentation] 예를 들면 다음과 같습니다:

```swift
let quotation = """
I said "I have \(apples) apples."
And then I said "I have \(apples + oranges) pieces of fruit."
"""
```

배열과 딕셔너리는 대괄호 (`[]`) 로 생성하며, 원소 접근은 대괄호 안에 색인이나 키를 작성하면 됩니다. 마지막 원소 뒤에 쉼표를 둬도 됩니다.

```swift
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"

var occupations = [
  "Malcolm": "Captain",
  "Kaylee": "Mechanic",
]
occupations["Jayne"] = "Public Relations"
```

배열은 원소를 추가함에 따라 자동으로 커집니다.

```swift
shoppingList.append("blue paint")
print(shoppingList)
```

빈 배열 또는 딕셔너리를 생성하려면, 초기자 구문 을 사용합니다.[^initializer-syntax]

```swift
let emptyArray: [String] = []
let emptyDictionary: [String: Float] = [:]
```

타입 정보를 추론할 수 있으면, 빈 배열은 `[]` 로 빈 딕셔너리는 `[:]` 로 작성할 수 있습니다[^empty-literal]-예를 들어, 변수에 새 값을 설정하거나 함수에 인자를 전달할 때가 그렇습니다.

```swift
shoppingList = []
occupations = [:]
```

### Control Flow (제어 흐름)

`if` 와 `switch` 로 조건문을 만들고, `for`-`in` 와, `while`, 및 `repeat`-`while` 로 반복문을 만듭니다. 조건이나 반복 변수 주변의 괄호는 옵션입니다. 본문 주변의 중괄호는 필수입니다.

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
// "11" 을 인쇄함
```

`if` 문의, 조건은 반드시 불리언 표현식[^Boolean] 이어야 하며-이는 `if score { ... }` 같은 코드는 에러이지, 암시적으로 0 비교하는 게 아니라는 의미입니다.

`if` 와 `let` 을 함께 사용하면 잃어버린 건지도 모를 값과 작업할 수 있습니다. 이러한 값은 옵셔널[^optionals] 로 나타냅니다. 옵셔널 값은 값을 담고 있거나 `nil` 을 담아 값을 잃어버렸다고 지시합니다. 값에 옵셔널을 표시하려면 값 타입 뒤에 물음표 (`?`) 를 작성합니다.

```swift
var optionalString: String? = "Hello"
print(optionalString == nil)
// "false" 를 인쇄함

var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
  greeting = "Hello, \(name)"
}
```

> 실험
>
> `optionalName` 을 `nil` 로 바꿔 봅니다. 무슨 인사말이 뜹니까? `else` 절을 추가하여 `optionalName` 이 `nil` 이면 다른 인사말을 설정해 봅니다.

옵셔널 값이 `nil` 이면, 조건은 `false` 고 중괄호 안의 코드를 건너뜁니다. 그 외 경우, 옵셔널 값의 포장을 풀어서 `let` 뒤의 상수에 할당하는데, 이는 코드 블럭에서 포장 푼 값을 사용 가능하게 합니다.

옵셔널 값을 처리하는 또 다른 방법은 `??` 연산자로 기본 값을 제공하는 겁니다. 옵셔널 값이 잃어버린 거면, 그 대신 기본 값을 사용합니다.

```swift
let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"
```

포장 푼 값과 똑같은 이름을 사용하면, 더 짧은 철자로 값의 포장을 풀 수 있습니다.[^shorter-spelling]

```swift
if let nickname {
  print("Hey, \(nickname)")
}
```

**switch 문** 은 어떤 종류의 자료와도 다양한 폭의 비교 연산을 지원합니다-정수 및 같음 테스트만으로 제한하지 않습니다.

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
// "Is it a spicy red pepper?" 를 인쇄함
```

> 실험
>
> 기본 case[^default-case] 를 제거해 봅니다. 무슨 에러가 뜹니까?

패턴[^pattern] 에서 `let` 을 사용하여 패턴과 맞는 값을 상수로 할당할 수 있는 방법을 알기 바랍니다.

맞는 switch 문 case 안의 코드를 실행한 후엔, 프로그램이 switch 문 밖을 나갑니다. 실행이 그 다음 case 로 계속되진 않아서, 각각의 case 코드 끝에서 명시적으로 switch 문을 끊고 나올 필요가 없습니다.[^break-out]

`for`-`in` 으로 딕셔너리의 항목을 반복하려면 각각의 키-값 쌍[^key-value-pair] 에 사용할 한 쌍의 이름을 제공하면 됩니다. 딕셔너리는 순서 없는 집합체[^unordered-collection] 라서, 자신의 키와 값을 임의의 순서로 반복합니다.

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
// "25" 를 인쇄함
```

> 실험
>
> `_` 를 변수 이름으로 교체하여, 가장 큰 수가 무슨 종류인지 추적해 봅니다.

`while` 문을 사용하면 조건이 바뀔 때까지 코드 블럭을 반복합니다. 반복문 조건을 끝에 대신 둬서, 반복문이 적어도 한 번은 실행되도록 보장할 수도 있습니다.

```swift
var n = 2
while n < 100 {
  n = n * 2
}
print(n)
// "128" 을 인쇄함

var m = 2
repeat {
  m = m * 2
} while m < 100
print(m)
// "128" 을 인쇄함
```

반복문의 한 회차에서 색인을 유지하려면 `..<` 로 색인의 범위를 만들면 됩니다.

```swift
var total = 0
for i in 0..<4 {
  total += i
}
print(total)
// "6" 을 인쇄함
```

`..<` 로는 자신의 가장 윗 값을 생략한 범위를 만들고, `...` 로는 양 끝 값을 둘 다 포함한 범위를 만듭니다.

### Functions and Closures (함수와 클로져)

`func` 로 함수를 선언합니다. 함수를 호출하려면 이름 뒤에 인자 목록을 담은 괄호를 붙이면 됩니다. `->` 로 매개 변수 이름 및 타입을 함수의 반환 타입과 구분합니다.

```swift
func greet(person: String, day: String) -> String {
  return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")
```

> 실험
>
> `day` 매개 변수를 제거해 봅니다. 매개 변수를 추가하여 인사말에 오늘의 점심 특선을 포함시켜 봅니다.

기본적으로, 함수는 자신의 매개 변수 이름을 인자의 이름표로 사용합니다. 자신만의 인자 이름표를 매개 변수 이름 앞에 작성하거나, `_` 를 작성하여 아무런 인자 이름표도 사용하지 않습니다.

```swift
func greet(_ person: String, on day: String) -> String {
  return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")
```

튜플[^tuple] 로 복합 값을 만듭니다-예를 들어, 함수에서 여러 개의 값을 반환합니다. 튜플 원소의 참조는 이름이나 번호로 할 수 있습니다.

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
// "120" 을 인쇄함
print(statistics.2)
// "120" 을 인쇄함
```

함수는 중첩할 수 있습니다. 중첩 함수[^nested-functions] 는 더 바깥 쪽 함수에서 선언한 변수에 접근합니다. 중첩 함수를 사용하면 길고 복잡한 함수의 코드를 정돈할 수 있습니다.

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

함수는 일급 타입입니다.[^first-class] 이는 한 함수가 반환한 값이 또 다른 함수일 수 있다는 의미입니다.

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

함수는 자신의 인자로 또 다른 함수를 가질 수 있습니다.

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

함수는 실제로는 클로저[^closures] 의 한 특수한 경우인: 나중에 호출 할 수 있는 코드 블럭입니다. 클로저 안의 코드는 클로저를 생성한 시야 범위에서 사용 가능한 변수와 함수 같은 거라면, 실행 때 클로저가 다른 시야 범위에 있더라도, 접근합니다-이미 이런 예를 중첩 함수에서 봤습니다. 클로저를 이름 없이 작성하려면 중괄호 (`{}`) 로 코드를 둘러싸면 됩니다. `in` 으로 인자 및 반환 타입을 본문과 구분합니다.

```swift
numbers.map({ (number: Int) -> Int in
  let result = 3 * number
  return result
})
```

> 실험
>
> 클로저를 재작성하여 모든 홀수마다 0 을 반환해 봅니다.

여러 가지 옵션으로 클로저를 더 간결하게 작성합니다. 일-맡은자[^delegate] 의 콜백[^callback] 같이, 이미 클로저의 타입을 알고 있을 땐, 매개 변수나, 반환 타입, 또는 둘 다의 타입을 생략할 수 있습니다. 단일문 클로저[^single-statement-closures] 는 자신의 유일한 구문 값을 암시적으로 반환합니다.

```swift
let mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)
// "[60, 57, 21, 36]" 을 인쇄함
```

매개 변수의 참조를 이름 대신 번호로 할 수도 있습니다-이 접근법은 아주 짧은 클로저에서 특히 유용합니다. 함수의 마지막 인자로 전달한 클로저는 괄호 바로 뒤에 나타날 수 있습니다. 클로저가 함수의 유일한 인자일 땐, 괄호 전체를 생략할 수 있습니다.

```swift
let sortedNumbers = numbers.sorted { $0 > $1 }
print(sortedNumbers)
// "[20, 19, 12, 7]" 을 인쇄함
```

### Objects and Classes (객체와 클래스)

`class` 뒤에 클래스 이름을 쓰면 클래스를 생성합니다. 클래스 안의 속성 선언으, 그게 클래스 안에 있다는 것만 제외하면, 상수나 변수 선언과 똑같은 방식으로 작성합니다. 마찬가지로, 메소드 및 함수 선언도 똑같은 방식으로 작성합니다.

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
> `let` 으로 상수 속성을 추가해 보고, 인자를 가지는 또 다른 메소드도 추가해 봅니다.

클래스 인스턴스를 생성하려면 클래스 이름 뒤에 괄호를 두면 됩니다. 점 구문 (dot syntax) 으로 인스턴스의 속성과 메소드에 접근합니다.

```swift
var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()
```

이 버전의 `Shape` 클래스는 중요한 걸 잃어버렸는데: 인스턴스를 생성할 때 클래스를 초기 설정하는 초기자[^initializer] 가 그것입니다. `init` 으로 하나 생성합니다.

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

`self` 를 사용해서 초기자의 `name` 속성과 `name` 인자를 구별하는 방법을 알기 바랍니다. 초기자의 인자는 클래스 인스턴스를 생성할 때 함수 호출인 것 같이 전달합니다. 모든 속성에 값을 할당할 필요가 있습니다-(`numberOfSides` 처럼) 자신의 선언에서든 (`name` 처럼) 초기자에서든 그렇습니다.

객체를 해제하기 전에 어떤 정리가 필요하다면 `deinit` 으로 정리자[^deinitializer] 를 생성합니다.

하위 클래스는 자신의 클래스 이름 뒤에, 콜론으로 구분하여, 상위 클래스 이름을 포함합니다. 클래스가 어떤 표준 뿌리 클래스[^standard-root-class] 의 하위 클래스여야 한다는 필수 조건은 없어서, 필요에 따라 상위 클래스를 포함하거나 생략할 수 있습니다.

하위 클래스 메소드가 상위 클래스 구현을 재정의한다면 `override` 를 표시합니다—`override` 없이, 메소드를 재정의하는 우연한 사고가 일어나면, 컴파일러가 에러라고 탐지합니다. 컴파일러는 `override` 를 가지고도 실제로는 어떤 상위 클래스 메소드도 재정의하지 않는 메소드 역시 탐지합니다.

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
> `NamedShape` 의 또 다른 하위 클래스로 `Circle` 을 만들고 초기자 인자로는 반지름과 이름을 가지게 합니다. `Circle` 클래스의 `area()` 와 `simpleDescription()` 메소드를 구현해 봅니다.

저장하는 단순 속성에 더하여, 속성에 획득자와 설정자가 있을 수 있습니다.[^getter-and-setter]

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
// "9.3" 을 인쇄함
triangle.perimeter = 9.9
print(triangle.sideLength)
// "3.3000000000000003" 을 인쇄함
```

`perimeter` 의 설정자 안에선, 새 값이 `newValue` 라는 암시적 이름을 가집니다. `set` 뒤의 괄호에서 명시적 이름을 제공할 수 있습니다.

`EquilateralTriangle` 클래스의 초기자엔 세 개의 서로 다른 단계가 있다는 걸 알기 바랍니다:

1. 하위 클래스가 선언한 속성에 값을 설정함
2. 상위 클래스의 초기자를 호출함
3. 상위 클래스가 정의한 속성의 값을 바꿈. 메소드나, 획득자, 또는 설정자를 사용한 어떤 추가 설정 작업도 이 시점에서 할 수 있음.

속성을 계산할 필요는 없지만 새 값 설정 전후에 실행할 코드는 여전히 제공할 필요가 있다면, `willSet` 과 `didSet` 을 사용합니다. 제공한 코드는 초기자 밖에서 값이 바뀔 때마다 실행됩니다. 예를 들어, 아래 클래스는 삼각형 한 변 길이가 정사각형 한 변 길이와 항상 똑같도록 보장합니다.

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
// "10.0" 을 인쇄함
print(triangleAndSquare.triangle.sideLength)
// "10.0" 을 인쇄함
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)
// "50.0" 을 인쇄함
```

옵셔널 값과 작업할 땐, 메소드와, 속성, 및 첨자 같은 연산 앞에 `?` 를 쓸 수 있습니다. `?` 앞의 값이 `nil` 이면, `?` 뒤의 모든 걸 무시하여 전체 표현식 값이 `nil` 입니다. 그 외 경우, 옵셔널 값의 포장을 풀어서, `?` 뒤의 모든 걸 포장 푼 값에 작용합니다. 두 경우 모두, 전체 표현식 값은 옵셔널 값입니다.

```swift
let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength
```

### Enumerations and Structures (열거체와 구조체)

`enum` 으로 열거체를 생성합니다. 클래스 및 다른 모든 이름 있는 타입 같이, 열거체엔 자신과 결합된 메소드가 있을 수 있습니다.

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
> 서로의 원시 값[^raw-value] 을 비교해서 두 `Rank` 값을 비교하는 함수를 작성해 봅니다.

기본적으로, 스위프트는 0 에서 시작하여 매번 1 씩 증가하는 원시 값을 할당하지만, 값을 명시해서 이 동작을 바꿀 수 있습니다. 위 예제에선, `Ace` 에 `1` 이라는 원시 값을 명시해주고, 나머지 원시 값은 순서대로 할당됩니다. 문자열이나 부동-소수점 수를 열거체의 원시 타입으로 사용할 수도 있습니다. `rawValue` 속성을 써서 열거체 case 의 원시 값에 접근합니다.

`init?(rawValue:)` 초기자를 사용하면 원시 값으로 열거체 인스턴스를 만듭니다. 이는 원시 값과 맞는 열거체 case 또는 맞는 `Rank` 가 없다면 `nil` 을 반환합니다.

```swift
if let convertedRank = Rank(rawValue: 3) {
  let threeDescription = convertedRank.simpleDescription()
}
```

열거체 case 값은 실제 값이지, 자신의 원시 값을 또 다른 방식으로 작성한게 아닙니다. 사실상, 의미있는 원시 값이 없는 경우라면, 이를 제공하지 않아도 됩니다.

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
> `Suit` 에 `color()` 메소드를 추가하여 스페이드와 클럽이면 "검은색 (black)" 을 반환하고, 하트와 다이아몬드면 "빨간색 (red)" 을 반환해 봅니다.

위에서 열거체의 `hearts` case 를 두 가지 방식으로 참조한 걸 알기 바랍니다: `hearts` 상수에 값을 할당할 땐, 열거체 case `Suit.hearts` 를 전체 이름으로 참조하는데 이는 상수에 타입을 명시하지 않았기 때문입니다. switch 문 안에선, 열거체 case 를 단축 형식인 `.hearts` 로 참조하는데 이는 `self` 값이 패 (suit)[^suit] 라는 걸 이미 알기 때문입니다. 이미 값의 타입을 알 때는 언제든지 단축 형식을 사용할 수 있습니다.

열거체에 원시 값이 있다면, 그 값을 선언 부분에서 결정하는데, 이는 특별한 한 열거체 case 의 모든 인스턴스들이 항상 똑같은 원시 값을 가진다는 의미입니다. 열거체 case 의 또 다른 선택은 case 와 결합한 값을 가지는 겁니다-이 값은 인스턴스를 만들 때 결정하며, 각각의 열거체 case 인스턴스마다 서로 다를 수 있습니다. 결합 값[^associated-values] 은 열거체 case 인스턴스의 저장 속성인 것 같이 작동한다고 생각할 수 있습니다. 예를 들어, 서버에 일출 및 일몰 시간을 요청하는 경우를 고려해 봅니다. 서버는 요청한 정보를 가지고 응답하거나, 뭔가가 잘못됐다는 설명을 가지고 응답힙니다.

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
// "Sunrise is at 6:00 am and sunset is at 8:09 pm." 을 인쇄함
```

> 실험
>
> `ServerResponse` 와 switch 문에 세 번째 case 를 추가해 봅니다.

switch 문 case 와 값을 맞춰보면서 `ServerResponse` 값에서 일출 및 일몰 시간을 추출하는 방법을 알기 바랍니다.

`struct` 로 구조체를 생성합니다. 구조체는, 메소드와 초기자를 포함하여, 클래스와 똑같은 수많은 동작을 지원합니다. 구조체와 클래스의 가장 중요한 차이점은 코드 주변으로 전달할 때 구조체는 항상 복사되자만, 클래스는 참조로 전달된다는 것입니다.

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
> 함수를 작성하여, 하나의 카드가 각각 끗수 (rank)[^rank] 와 패의 조합인, 한 벌의 카드[^deck] 를 담은 배열을 반환해 봅니다.

### Concurrency (동시성)

`async` 로 비동기 실행 함수를 표시합니다.

```swift
func fetchUserID(from server: String) async -> Int {
  if server == "primary" {
    return 97
  }
  return 501
}
```

비동기 함수 호출을 표시하려면 그 앞에 `await` 를 작성하면 됩니다.

```swift
func fetchUsername(from server: String) async -> String {
  let userID = await fetchUserID(from: server)
  if userID == 501 {
    return "John Appleseed"
  }
  return "Guest"
}
```

`async let` 으로 비동기 함수를 호출하면, 다른 비동기 코드와 병렬로 실행합니다. 반환하는 값을 사용할 땐, `await` 를 작성합니다.

```swift
func connectUer(to server: Stirng) async {
  async let userID = fetchUserID(from: server
  async let username = fetchUsername(from: server
  let greeting = await "Hello \(username), user ID \(userID)"
  print(greeting)
}
```

`Task` 를 사용하면, 비동기 함수의 반환을 기다리지 않고, 동기 코드에서 이를 호출합니다.

```swift
Task {
  await connectUser(to: "primary")
}
//  "Hello Guest, user ID 97" 를 인쇄함
```

### Protocols and Extensions (프로토콜과 익스텐션)

`protocol` 로 프로토콜을 선언합니다.

```swift
protocol ExampleProtocol {
  var simpleDescription: String { get }
  mutating func adjust()
}
```

클래스와, 열거체, 및 구조체 모두 프로토콜을 채택[^adopt] 할 수 있습니다.

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
> `ExampleProtocol` 에 또 다른 필수 조건[^requirement] 을 추가해 봅니다. 무엇을 바꿔야 `SimpleClass` 와 `SimpleStructure` 가 여전히 프로토콜을 준수하게 됩니까?

`SimpleStructure` 선언 안에서 `mutating` 키워드를 사용하여 구조체를 수정할 메소드를 표시한다는 걸 알기 바랍니다. `SimpleClass` 선언에선 어떤 메소드도 변경[^mutating] 으로 표시할 필요가 없는데 클래스 메소드는 항상 클래스를 수정할 수 있기 때문입니다.

`extension` 을 사용하면 기존 타입에, 새로운 메소드와 계산 속성 같은, 기능을 추가합니다. 익스텐션을 사용하면 다른 곳에서 선언한 타입, 또는 심지어 라이브러리나 프레임웍에서 불러온 타입에, 프로토콜 준수성[^protocol-conformance] 을 추가할 수 있습니다.

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
// "The number 7" 을 인쇄함
```

> 실험
>
> 익스텐션을 작성하여 `Double` 타입에 `absoluteValue` 속성을 추가해 봅니다.

프로토콜 이름은 그냥 다른 어떤 이름의 타입인 것 처럼-예를 들어, 타입은 서로 다르지만 모두가 단일 프로토콜을 준수하는 객체 집합체[^collection] 를 생성하는데-사용할 수 있습니다. 프로토콜 타입인 값과 작업할 땐, 프로토콜 정의 밖의 메소드를 사용하는게 불가능합니다.

```swift
let protocolValue: ExampleProtocol = a
print(protocolValue.simpleDescription)
// "A very simple class.  Now 100% adjusted." 를 인쇄함
// print(protocolValue.anotherProperty)  // 주석을 제거하면 에러를 봄
```

`protocolValue` 변수의 실행 시간 타입이 `SimpleClass` 일지라도, 컴파일러는 이 타입을 `ExampleProtocol` 로 주어진 것처럼 취급합니다. 이는 클래스 구현 중에서 프로토콜 준수성 이외인 메소드나 속성에 접근하는 사고는 일어날 수 없다는 걸 의미합니다.

### Error Handling (에러 처리)

에러는 `Error` 프로토콜을 채택한 어떤 타입으로 나타냅니다.

```swift
enum PrinterError: Error {
  case outOfPaper
  case noToner
  case onFire
}
```

`throw` 로 에러를 던지고 `throws` 로 에러를 던질 수 있는 함수를 표시합니다. 함수가 에러를 던지면, 곧바로 함수를 반환하며 함수 호출 코드에서 에러를 처리합니다.

```swift
func send(job: Int, toPrinter printerName: String) throws -> String {
  if printerName == "Never Has Toner" {
    throw PrinterError.noToner
  }
  return "Job sent"
}
```

에러 처리엔 여러 가지 방법이 있습니다. 한 가지는 `do`-`catch` 문을 사용하는 겁니다. `do` 블럭 안에선, 앞에 `try` 를 작성하여 에러를 던질 수 있는 코드를 표시합니다. `catch` 블럭 안에선, 에러에 다른 이름을 주지 않는 한 자동으로 `error` 라는 이름이 주어집니다.

```swift
do {
  let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
  print(printerResponse)
} catch {
  print(error)
}
// "Job sent" 를 인쇄함
```

> 실험
>
> 프린터 이름을 `"Never Has Toner"` 로 바꿔서, `send(job:toPrinter:)` 함수가 에러를 던지게 해봅니다.

여러 `catch` 블럭을 제공하여 정해진 에러들을 처리할 수 있습니다. 패턴은 **switch** 문의 `case` 뒤에 하듯 `catch` 뒤에 작성합니다.

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
// "Job sent" 를 인쇄함
```

> 실험
>
> 에러를 던지는 코드를 `do` 블럭 안에 추가해 봅니다. 무슨 종류의 에러를 던져야 첫 번째 `catch` 블럭에서 에러를 처리합니까? 두 번째 및 세 번째 블럭에 대한 건 무엇입니까?

에러를 처리하는 또 다른 방법은 `try?` 를 써서 결과를 옵셔널로 변환하는 겁니다. 함수가 에러를 던지면, 정해진 에러를 버려서 결과가 `nil` 입니다. 그 외 경우, 결과는 함수 반환 값을 담은 옵셔널입니다.

```swift
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")
```

`defer` 를 사용하여, 함수 반환 직전, 함수 안의 다른 모든 코드 뒤에 실행할 코드 블럭을 작성합니다. 함수가 에러를 던지는 거엔 상관없이 코드를 실행합니다. `defer` 를 쓰면, 서로 다른 시간에 실행할 필요가 있는, 설정 및 정리 코드도 서로 나란하게 작성할 수 있습니다.

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

꺽쇠 괄호[^angle-brackets] 안에 이름을 써서 일반화 함수나 타입을 만듭니다.[^generic]

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

클래스와, 열거체, 및 구조체 뿐 아니라, 일반화 형식의 함수와 메소드도 만들 수 있습니다.

```swift
// 스위프트 표준 라이브러리의 옵셔널 타입을 재-구현한 것
enum OptionalValue<Wrapped> {
  case none
  case some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)
```

본문 바로 앞의 `where` 로 필수 조건 목록을 지정합니다-예를 들어, 타입이 프로토콜을 구현하길 요구하거나, 두 타입이 똑같을 걸 요구하며, 또는 클래스가 특별한 상위 클래스를 가지길 요구합니다.

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
> `anyCommonElements(_:_:)` 함수를 수정해서 어떤 두 시퀀스[^sequence] 의 공통 원소 배열든 반환하는 함수를 만들어 봅니다.


`<T: Equatable>` 을 작성하는 건 `<T> ... where T: Equatable` 을 작성하는 것과 똑같습니다.

### 다음 장

[The Basics (기초) > ]({% post_url 2016-04-24-The-Basics %})

### 참고 자료

[^A-Swift-Tour]: 원문은 [A Swift Tour](https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html) 에서 확인할 수 있습니다.

[^a-swift-tour]: 영어의 **Swift** 에는 재빠르다라는 의미도 있기 때문에, 이 장의 제목인 **A Swift Tour** 는 **재빨리 둘러보기** 라는 중의적인 의미도 가지고 있습니다.

[^hello-world]: `"Hello, world!"` 를 출력하는게 전통이 된 것은, 1978년 [The C Programming Language](https://en.wikipedia.org/wiki/The_C_Programming_Language) 라는 책에 이 예제가 처음으로 등장하면서부터입니다. 이 책의 공동 저자 중 한 사람이 **유닉스** 와 **C 언어** 를 개발한, 그 유명한 [Dennis Ritchie (데니스 리치)](https://en.wikipedia.org/wiki/Dennis_Ritchie) 입니다.

[^global-scope]: '전역 (global scope)' 이란 어떤 영역에도 속하지 않는 프로그램의 가장 바깥쪽 영역입니다. 

[^entry-point]: '진입점 (entry point)' 이란 프로그램 실행을 시작하는 지점을 말합니다. 보통의 프로그래밍 언어에선 `main()` 함수를 자신의 진입점으로 사용합니다.

[^convert]: 타입 변환에는 '변환 (casting)' 과 '자동 변환 (conversion)' 이라는 두 가지 종류가 있습니다. 본문에서 말하는 '자동 변환 (conversion)' 은 컴파일러가 자동으로 타입을 변환하는 걸 말합니다. 본문 내용은 다른 언어와는 달리 스위프트는 값을 자동 변환하지 않는다는 의미입니다.

[^indentation]: 이 설명은 예제를 보는게 더 이해하기 쉽습니다. 예제는, [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) 장의 [Multiline String Literals (여러 줄짜리 문자열 글자 값)](#multiline-string-literals-여러-줄짜리-문자열-글자-값) 부분에 있습니다.

[^initializer-syntax]: 사실 본문에 있는 예제는 '초기자 구문 (initializer syntax)' 이라기 보단 '빈 글자값 (empty literal)' 을 사용한 것입니다. 예전에는 초기자 구문을 사용한 예제였었는데, 책의 버전이 바뀌면서 예제 코드가 바뀌었습니다. 실제로 초기자 구문을 사용하는 예제는 [Creating an Empty Array (빈 배열 생성하기)]({% post_url 2016-06-06-Collection-Types %}#creating-an-empty-array-빈-배열-생성하기) 와 [Creating an Empty Dictionary (빈 딕셔너리 생성하기)]({% post_url 2016-06-06-Collection-Types %}#creating-an-empty-dictionary-빈-딕셔너리-생성하기) 부분을 참고하기 바랍니다. 

[^empty-literal]: 이걸 각각 '빈 배열 글자값 (empty array literal)' 및 '빈 딕셔너리 글자값 (empty dictionary literal)' 이라고 하는데, 사실 위에서도 이 빈 글자값들을 사용했습니다.

[^Boolean]: '불리언 (Boolean)' 은 `true` 또는 `false` 값만 가지는 논리 타입입니다.

[^optionals]: '옵셔널 (optionals)' 에 대한 더 자세한 설명은 [Optionals (옵셔널)]({% post_url 2016-04-24-The-Basics %}#optionals-옵셔널) 부분을 참고하기 바랍니다. 

[^shorter-spelling]: **스위프트 5.7** 에서 추가된 문법으로 `if let nickname { ... }` 은 예전 버전에서 `if let nickname = nickname { ... }` 라고 하는 것과 같습니다.

[^default-case]: switch 문 안의 `default:` 절을 말합니다. 

[^pattern]: '패턴 (Pattern)' 에 대한 더 자세한 정보는 [Patterns (패턴; 유형)]({% post_url 2020-08-25-Patterns %}) 장을 참고하기 바랍니다. 

[^break-out]: '명시적으로 switch 문을 끊고 나올 필요가 없다' 는 건 `break` 문을 쓸 필요가 없다는 의미입니다.

[^key-value-pair]: '딕셔너리 (dictionary)' 자체가 키 (key) 와 값 (value) 의 쌍 (pair) 으로 구성되어 있습니다.  

[^unordered-collection]: 수학적으로 '순서 있는 집합체 (ordered collections)' 와 '정렬된 집합체 (sorted collection)' 는 다른 의미입니다. 이 둘의 차이점에 대해서는, **StackOverflow** 의 [What is the difference between an ordered and a sorted collection?](https://stackoverflow.com/questions/1084146/what-is-the-difference-between-an-ordered-and-a-sorted-collection) 항목을 참고하기 바랍니다. 이 후부턴,  **order** 는 순서로, **sort** 는 정렬로 옮기겠습니다.

[^tuple]: '튜플 ()' 에 대한 더 자세한 정보는 [Tuples (튜플; 짝)]({% post_url 2016-04-24-The-Basics %}#tuples-튜플-짝) 부분을 참고하기 바랍니다.  

[^nested-functions]: '중첩 함수 (nested functions)' 에 대한 더 자세한 정보는 [Nested Functions (중첩 함수)]({% post_url 2020-06-02-Functions %}#nested-functions-중첩-함수) 부분을 참고하기 바랍니다.

[^first-class]: 프로그래밍에서 '일급 (first-class)' 이라는 말은 객체와 동급으로 사용할 수 있다는 걸 의미합니다. 예를 들어, 일급인 함수는 객체 처럼 인자로 전달할 수도 있고, 함수에서 반환할 수도 있으며, 다른 변수에 할당할 수도 있습니다. 스위프트에선 함수가 일급 타입이기 때문에, 함수를 인자의 전달과, 함수의 반환, 및 변수로 할당할 수 있습니다. 일급에 대한 더 자세한 정보는, 위키피디아의 [First-class citizen](https://en.wikipedia.org/wiki/First-class_citizen) 과 [일급 객체](https://ko.wikipedia.org/wiki/일급_객체) 항목을 참고하기 바랍니다.

[^closures]: '클로저 (closures)' 에 대한 더 자세한 정보는 [Closures (클로저; 잠금 블럭)]({% post_url 2020-03-03-Closures %}) 장을 참고하기 바랍니다. 

[^delegate]: '일-맡은자 (delegate)' 에 대한 더 자세한 정보는 [Delegation (맡김)]({% post_url 2016-03-03-Protocols %}#delegation-맡김) 부분을 참고하기 바랍니다.

[^callback]: '콜백 (callback)' 또는 콜백 함수는 다른 쪽에 인자로 넘겨서, 받은 쪽에서 호출하는 함수를 의미합니다. 스위프트에선, 이 콜백을 가지고 있는 개체를 일을 맡았다는 의미로 '일-맡은자 (delegate)' 라고 합니다. 콜백 자체는 '되돌아서 호출한다 (call back)' 는 의미입니다. 콜백에 대한 더 자세한 정보는 위키피디아의 [Callback (computer programming)](https://en.wikipedia.org/wiki/Callback_(computer_programming)) 항목과 [콜백](https://ko.wikipedia.org/wiki/콜백) 항목을 참고하기 바랍니다. 

[^single-statement-closures]: '단일문 클로저 (single statement closures)' 는 클로저 본문에 단 하나의 구문만 있는 걸 말합니다.

[^initializer]: '초기자 (initializer)' 에 대한 더 자세한 정보는 [Initializers (초기자)]({% post_url 2016-01-23-Initialization %}#initializers-초기자) 부분을 참고하기 바랍니다. 

[^deinitializer]: '정리자 (deinitializer)' 에 대한 더 자세한 정보는 [Deinitialization (뒷정리)]({% post_url 2017-03-03-Deinitialization %}) 장을 참고하기 바랍니다. 

[^standard-root-class]: '표준 뿌리 클래스 (standard root class)' 는 오브젝티브-C 에서의 `NSObject` 같은 클래스를 말합니다. 스위프트는 함수형 프로그래밍 패러다임을 가진 언어라서 객체 지향 프로그래밍 언어에서 사용하는 이런 식의 클래스가 없습니다.

[^getter-and-setter]: 본문에서 말하는 단순 속성을 '저장 속성 (stored properties)' 이라고 하고, 획득자와 설정자가 있는 속성을 '계산 속성 (computed properties)' 이라고 합니다. 각각에 대한 더 자세한 정보는 [Properties (속성)]({% post_url 2020-05-30-Properties %}) 부분을 참고하기 바랍니다.

[^suit]: '패 (suits)' 는 스페이드 (spades), 다이아몬드 (diamonds), 하트 (hearts), 클로버 (clovers) 라는 서양 카드의 네 가지 범주를 말합니다.

[^associated-values]: 결합 값에 대한 더 자세한 정보는 [Associated Values (결합 값)]({% post_url 2020-06-13-Enumerations %}#associated-values-결합-값) 부분을 참고하기 바랍니다. 

[^rank]: '끗수 (ranks)' 는 각각의 카드마다 숫자 또는 알파펫으로 나타내는 등급을 말합니다. 서양 카드에는 13 가지 끗수가 있습니다.

[^deck]: '벌 (deck)' 은 한 세트의 카드 묶음을 말합니다. 한 벌의 서양 카드엔 총 52 장의 카드가 있습니다.

[^adopt]: 프로토콜 채택에 대한 더 자세한 정보는 [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 장의 앞 부분을 참고하기 바랍니다. 프로토콜 채택과 프로토콜 준수는 의미가 조금 다릅니다

[^requirement]: '필수 조건 (requirements)' 에 대한 더 자세한 정보도 [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 장을 참고하기 바랍니다.

[^protocol-conformance]: '프로토콜 준수성 (protocol conformance)' 에 대한 더 자세한 내용은 [Adding Protocol Conformance with an Extension (익스텐션으로 프로토콜 준수성 추가하기)]({% post_url 2016-03-03-Protocols %}#adding-protocol-conformance-with-an-extension-익스텐션으로-프로토콜-준수성-추가하기) 부분을 참고하기 바랍니다.

[^angle-brackets]: `< ... >` 을 말합니다.

[^generic]: '일반화 (generic)' 에 대한 더 자세한 정보는 [Generics (일반화)]({% post_url 2020-02-29-Generics %}) 장을 참고하기 바랍니다.

[^sequence]: 컴퓨터 자료 구조의 하나인 '시퀀스 (sequence)' 는 원래 수학 용어인 '수열' 에서 온 개념입니다. 그러므로 해당 문장은 '두 수열에 공통인 원소 배열을 반환하는 함수' 라고 이해할 수도 있습니다.
