## 첨자 (Subscripts)

클래스, 구조 타입, 그리고 열거 타입은 첨자를 정의할 수 있는데 이를 사용해서 집합 (collection), 목록 (list) 또는 순열 (sequence) 의 멤버 요소에 바로 접근할 수 있습니다. 첨자를 사용하면 별도의 메소드 없이도 인덱스를 사용해서 값을 넣거나 불러올 수 있습니다. 예를 들어 `Array` 인스턴스 요소에는 `someArray[index]` 와 같이, `Dictionary` 인스턴스 요소에는 `someDictionary[key]` 와 같이 접근할 수 있습니다.

하나의 타입에 대해 여러 개의 첨자를 추가 정의할 수 있으며 이 때 첨자에 전달되는 인덱스 값의 타입에 따라 가장 적당한 버전이 선택됩니다. 첨자는 단일 차원으로만 쓸 수 있는 것은 아니어서 사용자 정의 타입에 필요하다면 여러 입력 매개 변수를 가지는 첨자를 정의할 수도 있습니다.

### 첨자 문법 (Subscript Syntax)

첨자는 타입의 인스턴스를 조회할 수 있도록 하는 것으로 인스턴스의 이름 뒤에 하나 이상의 값을 대괄호 속에 쓰면 됩니다. 문법은 인스턴스 메소드 문법 및 계산 속성의 문법 이 두가지 모두와 비슷합니다. 첨자를 정의하려면 `subscript` 키워드와 하나 이상의 입력 매개 변수를 쓴 다음 반환 값을 쓰면 되는데 이러한 방법은 인스턴스 메소드와 같습니다. 인스턴스 메소드와 다른 점이라면 첨자의 경우 읽기-쓰기 또는 읽기-전용이 될 수 있다는 것입니다. 이 동작은 게터 (getter) 와 세터 (setter) 로 전달되는데 이러한 방법은 계산 속성과 같습니다:

```swift
subscript(index: Int) -> Int {
    get {
        // return an appropriate subscript value here
    }
    set(newValue) {
        // perform a suitable setting action here
    }
}
```

`newValue` 의 타입은 첨자가 반환하는 값의 타입과 같습니다. 계산 속성과 마찬가지로 세터 (setter) 의 `(newValue)` 매개 변수를 지정하지 않아도 됩니다. 따로 지정하지 않으면 세터 (setter) 에 `newValue` 라는 기본 매개 변수가 제공됩니다.

일기-전용 계산 속성과 같이 읽기-전용 첨자의 경우 `get` 키워드와 중괄호를 없애서 정의를 더 단순하게 할 수도 있습니다:

```swift
subscript(index: Int) -> Int {
    // return an appropriate subscript value here
}
```

다음은 읽기-전용 첨자의 구현 예로 구구단 (`TimesTable`) 구조 타입을 정의한 것으로 정수 n에 대해 구구단 n-단을 표현하도록 한 것입니다:

```swift
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// Prints "six times three is 18"
```

이 예에서는 `TimesTable` 의 새 인스턴스를 만들어서 구구단 3단을 표현하고 있습니다. 여기서는 구조 타입의 `initializer` 에 값 `3`을 전달해서 인스턴스의 `multiplier` 매개 변수에 사용하도록 지정하고 있습니다.

`threeTimesTable[6]` 호출에서 보듯이 첨자를 호출해서 `threeTimesTable` 인스턴스에 질의할 수 있습니다. 여기서는 구구단 3단의 6번째의 값을 요청한 것으로 값 `18` 또는 `3` 곱하기 `6` 을 반환합니다.

> 구구단에서 n-단 이라는 것은 고정된 수학 규칙에 기반한 것입니다. 즉  `threeTimesTable[someIndex]` 를 새 값으로 설정할 일은 없는 셈이므로 구구단 (`TimesTable`) 의 첨자는 일기-전용 첨자로 정의된 것입니다.

### 첨자 사용법 (Subscript Usage)

“첨자” 의 정확한 의미는 그것이 사용된 문맥에 달려 있습니다. 첨자는 보통 집합, 목록 또는 순열의 멤버 요소에 바로 접근하기 위한 용도로 사용됩니다. 특정 클래스나 구조 타입의 기능에 가장 적합한 방식으로 자유롭게 첨자를 구현할 수 있습니다.

예를 들면 Swift 의 `Dictionary` 타입은 `Dictionary` 인스턴스에 저장된 값을 설정하고 불러오기 위해 첨자를 구현합니다. 사전 타입에 값을 설정하려면 첨자 대괄호 안에 사전 키 타입의 키를 넣은 다음 첨자에 사전 값 타입의 값을 할당하면 됩니다:

```swift
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2
```

The example above defines a variable called `numberOfLegs` and initializes it with a dictionary literal containing three key-value pairs. The type of the `numberOfLegs` dictionary is inferred to be `[String: Int]`. After creating the dictionary, this example uses subscript assignment to add a `String` key of `"bird"` and an `Int` value of `2` to the dictionary.

For more information about `Dictionary` subscripting, see [Accessing and Modifying a Dictionary]().

> NOTE
> 
> Swift’s `Dictionary` type implements its key-value subscripting as a subscript that takes and returns an optional type. For the `numberOfLegs` dictionary above, the key-value subscript takes and returns a value of type `Int?`, or “optional int”. The `Dictionary` type uses an optional subscript type to model the fact that not every key will have a value, and to give a way to delete a value for a key by assigning a `nil` value for that key.

### Subscript Options

Subscripts can take any number of input parameters, and these input parameters can be of any type. Subscripts can also return any type. Subscripts can use variadic parameters, but they can’t use in-out parameters or provide default parameter values.

A class or structure can provide as many subscript implementations as it needs, and the appropriate subscript to be used will be inferred based on the types of the value or values that are contained within the subscript brackets at the point that the subscript is used. This definition of multiple subscripts is known as subscript overloading.

While it is most common for a subscript to take a single parameter, you can also define a subscript with multiple parameters if it is appropriate for your type. The following example defines a `Matrix` structure, which represents a two-dimensional matrix of `Double` values. The `Matrix` structure’s subscript takes two integer parameters:

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

`Matrix` provides an initializer that takes two parameters called `rows` and `columns`, and creates an array that is large enough to store `rows * columns` values of type `Double`. Each position in the matrix is given an initial value of `0.0`. To achieve this, the array’s size, and an initial cell value of `0.0`, are passed to an array initializer that creates and initializes a new array of the correct size. This initializer is described in more detail in [Creating an Array with a Default Value]().

You can construct a new `Matrix` instance by passing an appropriate row and column count to its initializer:

```swift
var matrix = Matrix(rows: 2, columns: 2)
```

The preceding example creates a new `Matrix` instance with two rows and two columns. The `grid` array for this `Matrix` instance is effectively a flattened version of the matrix, as read from top left to bottom right:

![image:](https://xho95.github.io/assets/Swift/subscriptMatrix01_2x.png)

Values in the matrix can be set by passing row and column values into the subscript, separated by a comma:

```swift
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2
```

These two statements call the subscript’s setter to set a value of `1.5` in the top right position of the matrix (where `row` is `0` and `column` is `1`), and `3.2` in the bottom left position (where `row` is `1` and `column` is `0`):

![image:](https://xho95.github.io/assets/Swift/subscriptMatrix02_2x.png)

The `Matrix` subscript’s getter and setter both contain an assertion to check that the subscript’s `row` and `column` values are valid. To assist with these assertions, `Matrix` includes a convenience method called `indexIsValid(row:column:)`, which checks whether the requested `row` and `column` are inside the bounds of the matrix:

```swift
func indexIsValidForRow(row: Int, column: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
}
```

An assertion is triggered if you try to access a subscript that is outside of the matrix bounds:

```swift
let someValue = matrix[2, 2]
// this triggers an assert, because [2, 2] is outside of the matrix bounds
```