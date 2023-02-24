---
layout: post
comments: true
title:  "Subscripts (첨자)"
date:   2020-03-30 10:00:00 +0900
categories: Swift Language Grammar Subscripts
redirect_from: "/swift/language/grammar/subscripts/2020/03/15/Subscripts.html"
---

{% include header_swift_book.md %}

## Subscripts (첨자)

클래스와, 구조체, 및 열거체는 _첨자 (subscripts)_ 를 정의할 수 있는데, 이는 집합체 (collection) 나, 리스트 (list), 또는 시퀀스 (sequence)[^sequences] 의 멤버 원소에 접근하기 위한 줄임말입니다. 첨자를 쓰면 설정하고 가져오기 위한 별도의 메소드 없이 색인[^index] 으로 값을 설정하고 가져옵니다. 예를 들어, `Array` 인스턴스 안의 원소는 `someArray[index]` 로 `Dictionary` 인스턴스 안의 원소는 `someDictionary[key]` 로 접근합니다.

단일 타입에 여러 개의 첨자를 정의할 수 있으며, 중복 정의한 첨자 중 사용하기 적절한 건 첨자에 전달한 색인 값의 타입을 기반으로 선택됩니다. 첨자는 단일 차원으로 제한된 것이 아니며, 자신만의 타입에 어울리도록 여러 입력 매개 변수가 있는 첨자를 정의할 수도 있습니다.

### Subscript Syntax (첨자 구문)

첨자는 인스턴스 이름 뒤 대괄호 안에 하나 이상의 값을 작성함으로써 타입의 인스턴스를 조회할 수 있게 합니다. 이러한 구문은 인스턴스 메소드 구문 및 계산 속성 구문 둘 다와 비슷합니다. 첨자 정의는 `subscript` 키워드로 작성하며, 인스턴스 메소드와 똑같이, 하나 이상의 입력 매개 변수와 반환 타입을 지정합니다. 인스턴스 메소드와 달리, 첨자는 읽기-쓰기 (read-write) 나 읽기-전용 (read-only) 일 수 있습니다.[^read-only] 이런 동작은 계산 속성에서와 똑같이 획득자 (getter) 와 설정자 (setter) 로 통신합니다.

```swift
subscript(index: Int) -> Int {  
  get {
    // 여기서 적절한 첨자 값을 반환함
  }
  set(newValue) {
    // 여기서 적합한 설정 행동을 함
  }
}
```

`newValue` 타입은 첨자의 반환 값과 똑같습니다. 계산 속성처럼, 설정자의 `(newValue)` 매개 변수를 지정하지 않게 선택할 수 있습니다. 스스로 제공하지 않으면 `newValue` 라는 기본 매개 변수를 설정자에 제공합니다.

읽기-전용 계산 속성처럼, `get` 키워드와 괄호를 제거함으로써 읽기-전용 첨자 정의를 단순하게 할 수 있습니다:

```swift
subscript(index: Int) -> Int {
  // 여기서 적절한 첨자 값을 반환함
}
```

다음 예제는, 정수 구구단 n-단을 나타내는 `TimesTable` 구조체를 정의한, 읽기-전용 첨자 구현입니다:

```swift
struct TimesTable {
  let multiplier: Int
  subscript(index: Int) -> Int {
    return multiplier * index
  }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// "six times three is 18" 을 인쇄함
```

이 예제에선, 구구단 3-단을 나타내는 새 `TimesTable` 인스턴스를 생성합니다. 이는 인스턴스의 `multiplier` 속성이 사용할 `3` 이라는 값을 구조체의 `initializer`[^initializer] 에 전달함으로써 지시합니다.

`threeTimesTable[6]` 이라는 호출로 보는 것처럼, 자신의 첨자를 호출함으로써 `threeTimesTable` 인스턴스를 조회할 수 있습니다. 이는 구구단 3-단의 6번째 요소를 요청하여, `18`, 또는 `3` 곱하기 `6` 의 값을 반환합니다.

> 구구단 n-단은 고정된 수학 규칙에 기초합니다. `threeTimesTable[someIndex]` 에 새 값을 설정하는 건 적절치 않으므로, `TimesTable` 의 첨자는 읽기-전용 첨자로 정의합니다.

### Subscript Usage (첨자 사용법)

"첨자 (subscript)" 의 정확한 의미는 자신이 사용된 곳의 상황에 의존합니다. 첨자는 전형적으로 집합체나, 리스트, 또는 시퀀스 멤버 원소의 접근에 대한 줄임말로 사용합니다. 자신의 한 특별한 클래스나 구조체 기능에 가장 적절한 방식으로 자유롭게 첨자를 구현할 수 있습니다.

예를 들어, 스위프트의 `Dictionary` 타입은 `Dictionary` 인스턴스에 저장한 값을 설정하고 가져오고자 첨자를 구현합니다. 첨자 대괄호 안에 딕셔너리의 키 타입인 키를 제공하고, 첨자에 딕셔너리의 값 타입인 값을 할당함으로써, 딕셔너리에 값을 설정할 수 있습니다:

```swift
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2
```

위 예제는 `numberOfLegs` 라는 변수를 정의하고 세 키-값 쌍을 담은 딕셔너리 글자 값으로 이를 초기화합니다. `numberOfLegs` 딕셔너리의 타입은 `[String: Int]` 라고 추론합니다. 딕셔너리를 생성한 후, 이 예제는 첨자 할당을 사용하여 딕셔너리에 `"bird"` 라는 `String` 키와 `2` 라는 `Int` 값을 추가합니다.

`Dictionary` 첨자 연산에 대한 더 많은 정보는, [Accessing and Modifying a Dictionary (딕셔너리 접근 및 수정하기)]({% link docs/swift-books/swift-programming-language/collection-types.md %}#accessing-and-modifying-a-dictionary-딕셔너리-접근-및-수정하기) 부분을 보도록 합니다.

> 스위프트의 `Dictionary` 타입은 _옵셔널 (optional)_ 타입을 취하고 반환하는 첨자로 자신의 키-값 첨자 연산을 구현합니다. 위의 `numberOfLegs` 딕셔너리에선, 키-값 첨자가 `Int?`, 또는 "옵셔널 정수 (optional int)", 타입의 값을 취하고 반환합니다. `Dictionary` 타입은 옵셔널 첨자 타입을 사용하여 모든 키가 값을 가지진 않을 거라는 사실을 모델링하고, 그 키에 `nil` 값을 할당함으로써 키의 값을 삭제할 방법을 제공합니다.

### Subscript Options (첨자의 옵션)

첨자는 어떤 개수의 입력 매개 변수든 취할 수 있으며, 이 입력 매개 변수는 어떤 타입이든 될 수 있습니다. 첨자는 어떤 타입의 값이든 반환할 수도 있습니다.

[Variadic Parameters (가변 매개 변수)]({% link docs/swift-books/swift-programming-language/functions.md %}#variadic-parameters-가변-매개-변수) 와 [Default Parameter Values (기본 매개 변수 값)]({% link docs/swift-books/swift-programming-language/functions.md %}#default-parameter-values-기본-매개-변수-값) 에서 설명한 것처럼, 함수와 같이, 첨자도 가변 개수의 매개 변수를 취할 수 있으며 이 매개 변수에 기본 값을 제공할 수도 있습니다. 하지만, 함수와 달리, 첨자 연산은 입-출력 (in-out) 매개 변수를 사용할 수 없습니다.

클래스나 구조체는 필요한 만큼 많은 첨자 구현을 제공할 수 있으며, 사용하가 적절한 첨자는 첨자를 사용할 시점에 첨자 대괄호 안에 담은 값이나 값들의 타입을 기초로 추론할 겁니다. 이런 여러 개의 첨자 정의를 _첨자 중복 정의 (subscript overloading)_ 라고 합니다.

단일 매개 변수를 취하는 첨자 연산이 가장 흔한 반면에, 자신의 타입에 적절하다면 여러 개의 매개 변수를 가진 첨자를 정의할 수도 있습니다. 다음 예제는, 이-차원 `Double` 값 배열을 나타내는, `Matrix` 구조체를 정의합니다. `Matrix` 구조체의 첨자는 두 정수 매개 변수를 취합니다:

```swift
struct Matrix {
  let rows: Int, columns: Int
  var grid: [Double]
  init(rows: Int, columns: Int) {
    self.rows = rows
    self.columns = columns
    grid = Array(repeating: 0.0, count: rows * columns)
  }
  func indexIsValid(row: Int, column: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
  }
  subscript(row: Int, column: Int) -> Double {
    get {
      assert(indexIsValid(row: row, column: column), "Index out of range")
      return grid[(row * columns) + column]
    }
    set {
      assert(indexIsValid(row: row, column: column), "Index out of range")
      grid[(row * columns) + column] = newValue
    }
  }
}
```

`Matrix` 는 `rows` 와 `columns` 이라는 두 매개 변수를 취하는 초기자를 제공하며, `rows * columns` 개의 `Double` 타입 값을 저장할만큼 충분히 큰 배열을 생성합니다. 행렬 (matrix) 안의 각 위치엔 `0.0` 이라는 초기 값을 줍니다. 이를 달성하기 위해, 배열 초기자에 배열 크기와, `0.0` 이라는 초기 단위 조직 값을 전달하여, 올바른 크기의 새 배열을 생성하고 초기화합니다. 이 초기자는 [Creating an Array with a Default Value (기본 값으로 배열 생성하기)]({% link docs/swift-books/swift-programming-language/collection-types.md %}#creating-an-array-with-a-default-value-기본-값으로-배열-생성하기) 에서 더 자세히 설명합니다.

자신의 초기자에 적절한 행과 열 개수를 전달함으로써 새로운 `Matrix` 인스턴스를 생성할 수 있습니다:

```swift
var matrix = Matrix(rows: 2, columns: 2)
```

위 예제는 두 행과 두 열을 가진 새로운 `Matrix` 인스턴스를 생성합니다. 이 `Matrix` 인스턴스의 `grid` 배열은 사실상, 맨 왼쪽 위에서 오른쪽 아래로 읽어가는, 납작한 버전의 행렬입니다[^flattend-version]:

![flattened-version-of-the-matrix](/assets/Swift/Swift-Programming-Language/Subscripts-flattened-version-matrix.jpg)

행과 열 값을, 쉼표로 구분하여, 첨자에 전달함으로써 행렬에 있는 값을 설정할 수 있습니다:

```swift
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2
```

이 두 구문은 첨자의 설정자를 호출하여 (`row` 가 `0` 이고 `column` 이 `1` 인) 행렬 맨 오른쪽 위를 `1.5` 로, (`row` 가 `1` 이고 `column` 이 `0` 인) 맨 왼쪽 아래를 `3.2` 라는 값으로 설정합니다:

![matrix](/assets/Swift/Swift-Programming-Language/Subscripts-matrix.jpg)

`Matrix` 첨자의 획득자와 설정자 둘 다 첨자의 `row` 와 `column` 값이 유효한지 검사하는 단언문 (assertion) 을 담고 있습니다. 이 단언문을 거들려고, 요청한 `row` 와 `column` 이 행렬 경계 안에 있는지 검사하는, `indexIsValid(row:column:)` 라는 편의(를 위한) 메소드를 `Matrix` 가 포함합니다:

```swift
func indexIsValid(row: Int, column: Int) -> Bool {
  return row >= 0 && row < rows && column >= 0 && column < columns
}
```

행렬 경계 밖에 있는 첨자에 접근하려 하면 단언문을 발동합니다:

```swift
let someValue = matrix[2, 2]
// [2, 2] 가 행렬 경계 밖이기 때문에, 단언문을 발동합니다.
}
```

### Type Subscripts (타입 첨자)

인스턴스 첨자는, 위에서 설명한 것처럼, 한 특별한 타입의 인스턴스에서 호출하는 첨자입니다. 타입 그 자체에서 호출하는 첨자도 정의할 수 있습니다. 이러한 종류의 첨자를 _타입 첨자 (type subscript)_ 라고 합니다. `subscript` 키워드 앞에 `static` 키워드를 작성함으로써 타입 첨자를 표시합니다. 클래스는 `class` 키워드를 대신 사용하여, 그 첨자의 상위 클래스 구현을 하위 클래스가 재정의하도록 허용할 수 있습니다. 아래 예제는 타입 첨자의 정의와 호출 방법을 보여줍니다:

```swift
enum Planet: Int {
  case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune

  static subscript(n: Int) -> Planet {
    return Planet(rawValue: n)!
  }
}
let mars = Planet[4]
print(mars)
```

### 다음 장

[Inheritance (상속) >]({% link docs/swift-books/swift-programming-language/inheritance.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [Subscripts](https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html) 에서 볼 수 있습니다.

[^sequences]: '시퀀스 (sequence)' 는 수학 용어로는 '수열' 을 의미하는 단어이지만, 자료 구조로는 '같은 타입의 값들이 순차적으로 붙어서 나열된 구조' 를 의미합니다. 본문에 있는 '집합체 (collection), 리스트 (list), 시퀀스 (sequence)' 등은 모두 알고리즘에서 사용하는 자료 구조입니다. '시퀀스' 에 대한 더 자세한 정보는, 위키피디아의 [Sequential access](https://en.wikipedia.org/wiki/Sequential_access) 항목과 [순차 접근](https://ko.wikipedia.org/wiki/순차_접근) 항목을 보도록 합니다. 

[^read-only]: 이런 동작은 바로 뒤에서 설명하는 '계산 속성 (computed property)' 과 비슷합니다. 이런 관점에서 보면 계산 속성과 첨자는 인스턴스 메소드의 특수한 한 형태라고 볼 수 있습니다.

[^initializer]: 여기서 사용한 초기자 (initializer) 는 구조체 타입이면 자동으로 가지는 '멤버 초기자 (memberwise initializer)' 입니다. 자동으로 가지게 되므로 코드에는 없습니다. 멤버 초기자에 대한 더 많은 정보는, [Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)]({% link docs/swift-books/swift-programming-language/structures-and-classes.md %}#memberwise-initializers-for-structure-types-구조체-타입을-위한-멤버-초기자) 부분을 보도록 합니다.

[^flattend-version]: '납작한 (flattened) 버전의 행렬' 이란 2-차원 배열의 형상을 바꿔서 1-차원 배열로 만들었다는 의미입니다.
