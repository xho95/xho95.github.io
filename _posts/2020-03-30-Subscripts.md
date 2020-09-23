---
layout: post
comments: true
title:  "Swift 5.2: Subscripts (첨자 연산)"
date:   2020-03-30 10:00:00 +0900
categories: Swift Language Grammar Subscripts
redirect_from: "/swift/language/grammar/subscripts/2020/03/15/Subscripts.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Subscripts](https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html) 부분[^Subscripts]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 스위프트 5.3 에 대한 내용이 다시 일부 수정되어서,[^swift-update] 추가된 내용 먼저 옮기고 나머지 부분을 옮기도록 합니다. 전체 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Subscripts (첨자 연산)

'클래스 (classes)', '구조체 (structures)', 그리고 '열거체 (enumerations)' 는 '_첨자 연산 (subscripts)_' 을 정의하여, '컬렉션 (collection)', '리스트 (list)', 또는 '시퀀스 (sequence)' 의 멤버 원소에 접근하는 간편한 방법을 제공합니다. '첨자 연산' 을 사용하면 색인으로 값을 설정하고 가져올 수 있어서 별도의 메소드를 따로 만들 필요도 없습니다. 예를 들어, `Array` 인스턴스의 원소는 `someArray[index]` 로 접근할 수 있으며, `Dictionary` 인스턴스의 원소는 `someDictionary[key]` 로 접근할 수 있습니다.

하나의 단일한 타입에 대해 여러 개의 '첨자 연산' 을 정의할 수도 있으며, 이 때 첨자 연산에 전달한 색인 값의 타입에 따라 첨자 연산을 적절하게 선택하고 사용합니다. 첨자 연산은 1차원으로만 한정된 것이 아니라서, 사용자 정의 타입의 요구에 맞게 여러 개의 입력 매개 변수를 갖는 첨자 연산도 정의할 수 있습니다.

### Subscript Syntax (첨자 연산 구문 표현)

첨자 연산을 사용해서 타입의 인스턴스를 조회하려면 인스턴스 이름 뒤위 대괄호 안에 하나 이상의 값을 써주면 됩니다. 이러한 구문 표현은 '인스턴스 메소드 구문 표현' 및 '계산 속성 구문 표현' 과 비슷합니다. 첨자 연산을 정의하려면 `subscript` 키워드를 쓴 다음, 하나 이상의 매개 변수와 하나의 반환 타입을 지정하면 되며, 이는 인스턴스 메소드와 방법이 같습니다. 다만 인스턴스 메소드와는 달리, 첨자 연산은 '읽기-쓰기 혼용' 일 수도 있고 '읽기-전용' 일 수도 있습니다. 이 행동은 'getter (획득자)' 와 'setter (설정자)' 를 사용하여 상호 작용하는데 이것도 '계산 속성' 과 같은 방법입니다.

```swift
subscript(index: Int) -> Int {  
  get {
    // 여기서 알맞은 첨자 연산 값을 반환합니다.
  }
  set(newValue) {
    // 여기서 적당한 설정 작업을 수행합니다.  
  }
}
```

`newValue` 의 타입은 첨자 연산의 반환 값과 같습니다. '계산 속성 (computed properties)' 에서 처럼, 'setter (설정자)' 의 `(newValue)` 매개 변수를 지정 안해도 상관 없습니다. 직접 제공하지 않으면 'setter (설정자)' 는 `newValue` 라는 기본 매개 변수를 제공합니다.

'읽기-전용 계산 속성' 에서 처럼, `get` 키워드와 괄호를 제거하여 '읽기-전용 첨자 연산' 의 선언을 더 줄일 수도 있습니다.

```swift
subscript(index: Int) -> Int {
  // 여기서 알맞은 첨자 연산 값을 반환합니다.
}
```

다음은 '읽기-전용 첨자 연산' 의 구현 예제로, 정수 n 에 대해서 '구구단 n단' 를 나타내는 `TimesTable` 구조체를 정의하고 있습니다.

```swift
struct TimesTable {
  let multiplier: Int
  subscript(index: Int) -> Int {
    return multiplier * index
  }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// "six times three is 18" 를 출력합니다.
```

이 예제에서는, `TimesTable` 의 새 인스턴스를 만들어서 구구단 3단을 나타내고 있습니다. 이는 인스턴스의 `multiplier` 속성에 사용할 값으로 구조체의 `initializer` 에 `3` 이라는 값을 전달하는 것으로 표현됩니다.

첨자 연산을 호출하여 `threeTimesTable` 인스턴스를 조회할 수 있으며, 위에서는 `threeTimesTable[6]` 라고 했습니다. 이는 '구구단 3단' 의 6번째 값을 요청한 것으로, 결과인 `18`, 또는 `3` 곱하기 `6` 을 반환합니다.

> '구구단 n단' 은 정해진 수학 규칙에 기반한 것입니다. 즉 `threeTimesTable[someIndex]` 에 새로운 값을 설정하는 것은 적절하지 않으며, 따라서 `TimesTable` 첨자 연산을 읽기-전용 첨자 연산으로 정의한 것입니다.

### Subscript Usage (첨자 연산 사용법)

"첨자 연산" 의 정확한 의미는 그것이 사용되는 영역에 달려 있습니다. 첨자 연산은 보통 컬렉션, 리스트, 또는 시퀀스의 멤버 원소에 접근하기 위한 간편한 방법으로 사용됩니다. 첨자 연산의 구현은 아주 자유롭기 때문에 특정 클래스나 구조체의 기능에 가장 알맞은 방식으로 구현할 수 있습니다.

예를 들어, 스위프트의 `Dictionary` 타입은 `Dictionary` 인스턴스에 저장된 값을 설정하고 가져오는 첨자 연산을 구현하고 있습니다. '딕셔너리' 에 값을 설정하려면 첨자 연산의 괄호 안에 '딕셔너리' 키 타입의 키를 제공한 다음, 첨자 연산에 '딕셔너리' 값 타입의 값을 할당하면 됩니다.

```swift
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2
```

위에 있는 예제는 `numberOfLegs` 라는 변수를 정의하고 이를 세 개의 키-값 쌍을 가지고 있는 '딕셔너리 글자 값 (dictionary literal)' 으로 초기화하고 있습니다. `numberOfLegs` 딕셔너리의 타입은 `[String: Int]` 로 추론합니다. 딕셔너리를 만든 다음, 이 예제는 첨자 연산 할당을 사용하여 문자열 키가 `"bird"` 이고 `Int` 값이 `2` 인 원소를 딕셔너리에 할당합니다.

`Dictionary` 첨자 연산에 대한 더 많은 정보는 [Accessing and Modifying a Dictionary (딕셔너리에 접근하고 수정하기)]({% post_url 2016-06-06-Collection-Types %}#accessing-and-modifying-a-dictionary-딕셔너리에-접근하고-수정하기) 를 참고하기 바랍니다.

> 스위프트의 '딕셔너리' 타입은 키-값 첨자 연산이 옵셔널 타입을 받아들이고 반환하는 것으로 구현하고 있습니다. 위의 `numberOfLegs` 딕셔너리에서는, 키-값 첨자 연산이 값의 타입으로 `Int?`, 또는 "옵셔널 정수 (optional int)" 를 받아들이고 반환합니다. `Dictionary` 타입이 옵셔널 첨자 연산 타입을 사용한다는 것은 모든 키가 값을 가지는 것은 아니라는 사실을 모델링하고 있기도 하고, 키에 `nil` 값을 할당하여 그 키에 대한 값을 지울 수 있는 방법을 제공하고 있는 것이기도 합니다.

### Subscript Options (첨자 연산의 선택 사항들)

첨자 연산의 입력 매개 변수는 개수가 몇 개가 되든 상관이 없으며, 입력 매개 변수의 타입도 어떤 타입이든 상관이 없습니다. 첨자 연산은 또 어떤 타입의 값이라도 반환할 수 있습니다.

함수와 마찬가지로, 첨자 연산은 가변 개수의 매개 변수도 받을 수 있고 매개 변수에 기본 설정 값을 제공할 수도 있는데, 이는 [Variadic Parameters (가변 매개 변수)]({% post_url 2020-06-02-Functions %}#variadic-parameters-가변-매개-변수) 와 [Default Parameter Values (기본 설정 매개 변수 값)]({% post_url 2020-06-02-Functions %}#default-parameter-values-기본-설정-매개-변수-값) 에서 설명하고 있습니다. 하지만, 함수와는 다르게, 첨자 연산에는 'in-out (입-출력)' 매개 변수를 사용할 수는 없습니다.

클래스나 구조체는 첨자 연산 구현을 필요한 만큼 많이 제공 할 수 있는데, 이 중에서 어떤 첨자 연산을 사용하는 것이 알맞은 지는 첨자 연산이 사용되는 시점에서 첨자 연산이 괄호 안에 가지고 있는 값이나 갑들의 타입에 기반하여 추론됩니다. 이렇게 여러 개의 첨자 연산을 정의하는 것을 _첨자 연산 중복 정의 (subscript overloading)_ 라고 합니다.

첨자 연산은 단일한 매개 변수를 가지는 것이 가장 일반적이기는 하지만, 타입에 더 알맞을 경우 여러 개의 매개 변수를 가지는 첨자 연산을 정의하는 것도 가능합니다. 아래 예제는 `Matrix` 구조체를 정의하고 있는데, 이는 `Double` 값을 갖는 2-차원 배열을 나타냅니다. 이 `Matrix` 구조체의 첨자 연산은 두 개의 정수 매개 변수를 가지고 있습니다:

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

`Matrix` 가 제공하는 초기자는 두 개의 매개 변수인 `rows` 와 `columns` 을 받아서, 타입이 `Double` 이고 `rows * columns` 값들을 저장하기에 충분한 크기의 배열을 만듭니다. 행렬의 각 위치에 주어진 기본 설정 값은 `0.0` 입니다. 이를 위해, 배열의 크기 값과, 초기 셀 값인 `0.0` 을 배열 초기자에 전달하여 정확한 크기의 새 배열을 만들고 초기화하고 있습니다. 이러한 '초기자' 는 [Creating an Array with a Default Value (기본 설정 값을 갖는 배열 생성하기)]({% post_url 2016-06-06-Collection-Types %}#creating-an-array-with-a-default-value-기본-설정-값을-가진-배열-생성하기) 에서 더 자세히 설명하도록 합니다.

알맞은 행과 열의 개수를 초기자에 전달하면 새로운 `Matrix` 인스턴스를 만들 수 있습니다:

```swift
var matrix = Matrix(rows: 2, columns: 2)
```

위의 예제는 두 개의 행과 두 개의 열로 새로운 `Matrix` 인스턴스를 만듭니다. 이 `Matrix` 인스턴스를 위한 `grid` 배열은 사실상 이 행렬을 '1-차원화한 버전 (flattened version)' 인데, 순서는 맨 위 왼쪽에서 맨 아래 오른쪽으로 향합니다:

![flattened-version-of-the-matrix](/assets/Swift/Swift-Programming-Language/Subscripts-flattened-version-matrix.jpg)

행과 열의 값을, 쉼표로 구분하여 첨자 연산에 전달하면, 행렬의 값을 설정할 수 있습니다:

```swift
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2
```

이 두 문장은 첨자 연산의 'setter (설정자)' 를 호출하여 행렬의 맨 위 오른쪽 위치 (행이 `0` 이고 열이 `1` 인 위치) 에 `1.5` 값을 설정하고, 맨 아래 왼쪽 위치 (행이 `1` 이고 열이 `0` 인 위치) 에 `3.2` 값을 설정합니다:

![matrix](/assets/Swift/Swift-Programming-Language/Subscripts-matrix.jpg)

`Matrix` 첨자 연산의 'getter (획득자)' 와 'setter (설정자)' 모두 첨자 연산의 행과 열 값이 유효한지를 검사하는 '단언 (assertion)' 문을 가지고 있습니다. 이 '단언' 문을 보조하기 위해, `Matrix` 는 `indexIsValid(row:column:)` 이라는 '편의 메소드' 도 포함하는데, 이는 요청한 행과 열이 행렬의 경계 내에 있는지를 검사합니다:

```swift
func indexIsValid(row: Int, column: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
}
```

행렬 경계 밖에 있는 첨자 연산에 접근하려 하면 이 '단언 (assertion)' 문이 발동합니다:

```swift
let someValue = matrix[2, 2]
// This triggers an assert, because [2, 2] is outside of the matrix bounds.
}
```

### Type Subscript (타입 첨자 연산)

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

### 참고 자료

[^Subscripts]: 이 글에 대한 원문은 [Subscripts](https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.
