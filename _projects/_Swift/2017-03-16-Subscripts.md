## 첨자 (Subscripts)

클래스, 구조 타입 및 열거 타입은 첨자를 정의할 수 있는데 이를 사용해서 집합 (collection), 목록 (list) 또는 순열 (sequence) 의 멤버 요소에 바로 접근할 수 있습니다. 첨자를 사용하면 별도의 메소드 없이도 인덱스를 사용해서 값을 넣거나 불러올 수 있습니다. 예를 들어 `Array` 인스턴스의 요소에는 `someArray[index]` 와 같이 `Dictionary` 인스턴스 요소에는 `someDictionary[key]` 와 같이 접근할 수 있습니다.

하나의 타입에 대해 여러 개의 첨자를 정의할 수 있으며 이 때 첨자에 전달되는 인덱스 값의 타입에 따라 추가 정의된 첨자 중에서 가장 적당한 것이 선택됩니다. 첨자는 단일 차원으로만 쓸 수 있는 것은 아니어서 사용자 정의 타입에 필요하다면 여러 개의 입력 매개 변수를 가지는 첨자를 정의할 수도 있습니다.

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

The type of `newValue` is the same as the return value of the subscript. As with computed properties, you can choose not to specify the setter’s `(newValue)` parameter. A default parameter called `newValue` is provided to your setter if you do not provide one yourself.

As with read-only computed properties, you can simplify the declaration of a read-only subscript by removing the `get` keyword and its braces:

```swift
subscript(index: Int) -> Int {
    // return an appropriate subscript value here
}
```

Here’s an example of a read-only subscript implementation, which defines a `TimesTable` structure to represent an n-times-table of integers:

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

In this example, a new instance of `TimesTable` is created to represent the three-times-table. This is indicated by passing a value of `3` to the structure’s `initializer` as the value to use for the instance’s `multiplier` parameter.

You can query the `threeTimesTable` instance by calling its subscript, as shown in the call to `threeTimesTable[6]`. This requests the sixth entry in the three-times-table, which returns a value of `18`, or `3` times `6`.

> NOTE
> 
> An n-times-table is based on a fixed mathematical rule. It is not appropriate to set `threeTimesTable[someIndex]` to a new value, and so the subscript for `TimesTable` is defined as a read-only subscript.

### Subscript Usage

The exact meaning of “subscript” depends on the context in which it is used. Subscripts are typically used as a shortcut for accessing the member elements in a collection, list, or sequence. You are free to implement subscripts in the most appropriate way for your particular class or structure’s functionality.

For example, Swift’s `Dictionary` type implements a subscript to set and retrieve the values stored in a `Dictionary` instance. You can set a value in a dictionary by providing a key of the dictionary’s key type within subscript brackets, and assigning a value of the dictionary’s value type to the subscript:

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