---
layout: post
comments: true
title:  "Swift 5.3: Subscripts (첨자 연산)"
date:   2020-03-30 10:00:00 +0900
categories: Swift Language Grammar Subscripts
redirect_from: "/swift/language/grammar/subscripts/2020/03/15/Subscripts.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Subscripts](https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html) 부분[^Subscripts]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Subscripts (첨자 연산)

클래스, 구조체, 그리고 열거체는, '집합체 (collection)', '리스트 (list)', 또는 '일련 값 (sequence)' 의 멤버 원소에 접근하는 '줄임말 (shorcuts)' 인, _첨자 연산 (subscripts)_ 을 정의할 수 있습니다. '첨자 연산' 은 별도의 메소드가 필요없이 '색인 (index)' 으로 값을 설정하고 가져오기 위해 사용합니다. 예를 들어, `Array` 인스턴스에 있는 원소는 `someArray[index]` 로 `Dictionary` 인스턴스에 있는 원소는 `someDictionary[key]` 로 접근합니다.

단일 타입에 대해 여러 개의 '첨자 연산' 을 정의할 수 있으며, 사용하기에 적절한 첨자 연산은 첨자 연산에 전달한 색인 값의 타입에 기초하여 선택됩니다. 첨자 연산은 단일 차원으로만 제한되어 있지 않으며, 사용자 정의 타입의 필요에 적합하도록 '다중 입력 매개 변수' 를 가진 첨자 연산을 정의할 수도 있습니다.

### Subscript Syntax (첨자 연산 구문 표현)

첨자 연산은 인스턴스 이름 뒤의 대괄호에 하나 이상의 값을 작성함으로써 타입의 인스턴스를 조회하도록 해줍니다. 이러한 구문 표현은 '인스턴스 메소드 구문 표현' 및 '계산 속성 (computed properties) 구문 표현' 과 비슷합니다. 첨자 연산 정의는 `subscript` 키워드로 작성하며, 인스턴스 메소드와 똑같은 방식으로, 하나 이상의 매개 변수와 반환 타입을 지정합니다. 인스턴스 메소드와는 달리, 첨자 연산은 '읽기-쓰기 (read-write)' 일 수도 '읽기-전용 (read-only)' 일 수도 있습니다.[^read-only] 이 작동 방식은 '계산 속성' 과 똑같은 방식인 '획득자 (getter)' 와 '설정자 (setter)' 로 '소통 (communicated)' 합니다.

```swift
subscript(index: Int) -> Int {  
  get {
    // 여기에서 적절한 첨자 연산 값을 반환함.
  }
  set(newValue) {
    // 여기에서 적합한 설정 행동을 수행함.
  }
}
```

`newValue` 의 타입은 첨자 연산의 반환 값과 같습니다. '계산 속성' 에서 처럼, '설정자' 의 `(newValue)` 매개 변수를 지정하지 않도록 선택할 수 있습니다. 직접 제공하지 않을 경우 설정자에는 `newValue` 라는 '기본 매개 변수' 가 제공됩니다.

'읽기-전용 계산 속성' 에서 처럼, '읽기-전용 첨자 연산' 의 선언은 `get` 키워드와 괄호를 제거하여 단순화할 수 있습니다:

```swift
subscript(index: Int) -> Int {
  // 여기에서 적절한 첨자 연산 값을 반환함.
}
```

다음은, 정수 구구단 'n-단' 를 표현하는 `TimesTable` 구조체를 정의하는, '읽기-전용 첨자 연산 구현' 에 대한 예제입니다:

```swift
struct TimesTable {
  let multiplier: Int
  subscript(index: Int) -> Int {
    return multiplier * index
  }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// "six times three is 18" 을 인쇄합니다.
```

이 예제는, 구구단 '3-단' 을 표현하기 위해 새로운 `TimesTable` 인스턴스를 생성합니다. 이는 인스턴스의 `multiplier` 속성에 사용할 값으로 구조체의 `initializer`[^initializer] 에 `3` 을 전달함으로써 지시합니다.

`threeTimesTable` 인스턴스는, `threeTimesTable[6]` 라고 나타낸 것처럼, 첨자 연산을 호출함으로써 조회할 수 있습니다. 이는 구구단 '3-단' 의 '6' 번째 항목을 요청하는데, `18`, 또는 `3` 곱하기 `6` 의 값을 반환합니다.

> 구구단 'n-단' 은 고정된 수학 규칙에 기초합니다. `threeTimesTable[someIndex]` 에 새로운 값을 설정하는 것은 적절하지 않으므로, `TimesTable` 에 대한 첨자 연산은 '읽기-전용 첨자 연산' 으로 정의합니다.

### Subscript Usage (첨자 연산의 사용법)

"첨자 연산 (subscript)" 의 정확한 의미는 사용하는 상황에 달려 있습니다. 첨자 연산은 전형적으로 '집합체 (collection)', 리스트, 또는 '일련 값 (sequence)' 에 있는 멤버 원소에 접근하기 위한 '줄임말 (shortcut)' 로써 사용됩니다. 첨자 연산은 특정 클래스나 구조체의 기능에 가장 적절한 방식으로 자유롭게 구현할 수 있습니다.

예를 들어, 스위프트의 `Dictionary` 타입은 `Dictionary` 인스턴스에 저장되어 있는 값을 설정하고 가져오기 위해 첨자 연산을 구현합니다. 딕셔너리는 첨자 연산 대괄호 안에 딕셔너리 키 타입의 키를 제공하고, 첨자 연산에 딕셔너리 값 타입의 값을 할당함으로써, 값을 설정할 수 있습니다:

```swift
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2
```

위 예제는 `numberOfLegs` 라는 변수를 정의하고 이를 세 개의 '키-값 쌍' 을 담고 있는 '딕셔너리 글자 값' 으로 초기화합니다. `numberOfLegs` 딕셔너리의 타입은 `[String: Int]` 라고 추론됩니다. 딕셔너리를 생성한 후, 이 예제는 딕셔너리에 `String` 키 타입 `"bird"` 와 `Int` 값이 `2` 를 추가하기 위해 '첨자 연산 할당' 을 사용합니다.

`Dictionary` 의 첨자 연산에 대한 더 많은 정보는, [Accessing and Modifying a Dictionary (딕셔너리 접근하기와 수정하기)]({% post_url 2016-06-06-Collection-Types %}#accessing-and-modifying-a-dictionary-딕셔너리-접근하기와-수정하기) 를 참고하기 바랍니다.

> 스위프트의 `Dictionary` 타입은 '키-값 첨자 연산' 을 _옵셔널 (optional)_ 타입을 취하고 반환하는 첨자 연산으로 구현합니다. 위의 `numberOfLegs` 딕셔너리는, '키-값 첨자 연산' 이 `Int?`, 또는 "옵셔널 정수 (optional int)" 타입의 값을 취하고 반환합니다. `Dictionary` 타입은 모든 키가 값을 가지진 않는다는 사실을 모델링하고, 해당 키에 `nil` 값을 할당함으로써 키의 값을 지우는 방법을 부여하기 위해, '옵셔널 첨자 연산 타입' 을 사용합니다.

### Subscript Options (첨자 연산의 옵션들)

첨자 연산은 어떤 개수의 입력 매개 변수도 취할 수 있으며, 이 입력 매개 변수들은 어떤 타입이든 될 수 있습니다. 첨자 연산은 어떤 타입의 값도 반환할 수 있습니다.

함수와 같이, 첨자 연산도, [Variadic Parameters (가변 매개 변수)]({% post_url 2020-06-02-Functions %}#variadic-parameters-가변-매개-변수) 와 [Default Parameter Values (기본 매개 변수 값)]({% post_url 2020-06-02-Functions %}#default-parameter-values-기본-매개-변수-값) 에서 설명한 것처럼, 가변 개수의 매개 변수를 취할 수 있으며 매개 변수에 기본 값을 제공할 수 있습니다. 하지만, 함수와는 달리, 첨자 연산은 '입-출력 (in-out) 매개 변수' 를 사용할 수 없습니다.

클래스나 구조체는 필요한 만큼 많은 첨자 연산 구현을 제공할 수 있으며, 사용하기에 적절한 첨자 연산은 첨자 연산이 사용되는 시점에 첨자 연산 대괄호 안에 담긴 값 또는 값들의 타입에 기초하여 추론될 것입니다. 이런 '다중 첨자 연산' 의 정의를 _첨자 연산 중복 정의 (subscript overloading)_ 라고 합니다.

첨자 연산은 단일 매개 변수를 취하는 것이 가장 일반적인 동시에, 자신의 타입에 적절하다면 '다중 매개 변수' 를 가진 첨자 연산을 정의할 수도 있습니다. 다음 예제는, `Double` 값의 '이-차원' 배열을 표현하는, `Matrix` 구조체를 정의합니다. `Matrix` 구조체의 첨자 연산은 두 개의 정수 매개 변수를 취합니다:

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

`Matrix` 는 `rows` 와 `columns` 이라는 두 매개 변수를 취하는 초기자를 제공하여, `rows * columns` 개의 `Double` 타입 값들을 저장하기에 충분한 크기의 배열을 생성합니다. '행렬 (matrix)' 의 각 위치는 초기 값이 `0.0` 으로 주어집니다. 이를 달성하기 위해, 배열의 크기와, `0.0` 이라는 초기 '단위 격자 (cell)' 값이, 정확한 크기의 새로운 배열을 생성하고 초기화하는 '배열 초기자 (array initializer)' 로 전달됩니다. 이 '초기자' 는 [Creating an Array with a Default Value (기본 값으로 배열 생성하기)]({% post_url 2016-06-06-Collection-Types %}#creating-an-array-with-a-default-value-기본-값으로-배열-생성하기) 에서 더 자세히 설명합니다.

새로운 `Matrix` 인스턴스는 적절한 행과 열 개수를 초기자에 전달함으로써 생성할 수 있습니다:

```swift
var matrix = Matrix(rows: 2, columns: 2)
```

위 예제는 두 개의 행과 두 개의 열을 가진 새로운 `Matrix` 인스턴스를 생성합니다. 이 `Matrix` 인스턴스의 `grid` 배열은 행렬을, 맨 왼쪽 위에서부터 오른쪽 아래로, 효과적으로 '납작하게 한 (flattened) 버전' 입니다[^flattend-version]:

![flattened-version-of-the-matrix](/assets/Swift/Swift-Programming-Language/Subscripts-flattened-version-matrix.jpg)

행렬의 값은 행과 열의 값을, 쉼표로 구분하여, 첨자 연산에 전달함으로써 설정할 수 있습니다:

```swift
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2
```

이 두 구문은 행렬의 맨 오른쪽 위인 (`row` 가 `0` 이고 `column` 이 `1` 인 위치) 에 `1.5`, 그리고 맨 왼쪽 아래인 (`row` 가 `1` 이고 `column` 이 `0` 인 위치) 에 `3.2` 라는 값을 설정하기 위해 첨자 연산의 '설정자' 를 호출합니다:

![matrix](/assets/Swift/Swift-Programming-Language/Subscripts-matrix.jpg)

`Matrix` 첨자 연산의 '획득자' 와 '설정자' 는 첨자 연산의 `row` 와 `column` 값이 유효한 지를 검사하기 위해 둘 다 '단언문 (assertion)' 을 가지고 있습니다. 이 '단언문' 들을 보조하기 위해, `Matrix` 는, 요청한 `row` 와 `column` 이 행렬의 경계 내에 있는지를 검사하는, `indexIsValid(row:column:)` 라는 '편의 메소드' 를 포함하고 있습니다:

```swift
func indexIsValid(row: Int, column: Int) -> Bool {
  return row >= 0 && row < rows && column >= 0 && column < columns
}
```

행렬 경계 외부의 첨자 연산에 접근하려고 하면 '단언문' 문이 발동됩니다:

```swift
let someValue = matrix[2, 2]
// 이는, [2, 2] 가 행렬 경계의 외부이기 때문에, 단언문을 발동합니다.
}
```

### Type Subscripts (타입 첨자 연산)

인스턴스 첨자 연산은, 위에서 설명한대로, 특정한 타입의 인스턴스에서 호출하는 첨자 연산입니다. 타입 그 자체에서 호출하는 첨자 연산도 정의할 수 있습니다. 이러한 종류의 첨자 연산을 _타입 첨자 연산 (type subscript)_ 라고 합니다. 타입 첨자 연산을 지정하려면 `subscript` 키워드 앞에 `static` 키워드를 써주면 됩니다. 클래스의 경우 `class` 키워드를 대신 사용하면, '상위 클래스' 에서 구현한 첨자 연산을 '하위 클래스' 에서 '재정의 (override)' 할 수도 있습니다. 아래의 예제는 타입 첨자 연산을 정의하고 호출하는 방법을 보여줍니다:

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

[Inheritance (상속) > ]({% post_url 2020-03-31-Inheritance %})

### 참고 자료

[^Subscripts]: 이 글에 대한 원문은 [Subscripts](https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^sequences]: '일련 값 (sequence)' 은 그 자체로 수학에서의 '수열' 을 의미하는 단어이지만, 여기서는 '수열' 과 비슷하게 '같은 타입의 값들이 쭉 나열되어 있는 것' 이라는 의미로 '일련 값' 이라고 옮깁니다. 본문에 있는 '집합체 (collection)', '리스트 (list)', '일련 값 (sequence)' 등은 모두 알고리즘에서 사용하는 수학적인 '자료 구조' 를 의미합니다.

[^read-only]: 이러한 작동 방식은 바로 뒤에 설명하는 '계산 속성 (computed property)' 과 비슷합니다. 이런 관점에서 보자면 '계산 속성' 과 '첨자 연산' 은 '인스턴스 메소드' 의 특수한 한 형태라고 볼 수 있습니다.

[^initializer]: 여기서 사용한 '초기자 (initializer)' 는 구조체 타입에 대해서 자동으로 생기는 '멤버 초기자 (memberwise initializer)' 입니다. 자동으로 부여되므로 코드에 나타나지는 않습니다. 멤버 초기자에 대한 더 자세한 정보는 [Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)]({% post_url 2020-04-14-Structures-and-Classes %}#memberwise-initializers-for-structure-types-구조체-타입을-위한-멤버-초기자) 부분을 참고하기 바랍니다.

[^flattend-version]: '납작하게 한 (flattened) 버전' 이란 '2-차원' 배열을 '1-차원' 배열의 형태로 만든 버전이라는 의미입니다.
