---
layout: post
comments: true
title:  "Swift 5.2: Collection Types (집합체 타입)"
date:   2016-06-06 19:45:00 +0900
categories: Swift Grammar Collection Array Set Dictionary
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Collection Types](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html) 부분[^Collection-Types]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Collection Types (집합체 타입)

스위프트는 값의 집합을 저장하는 용도로 세 가지의 주요 _컬렉션 타입 (collection types; 집합체 타입)_[^collections] 을 제공하는데, 이는 '배열 (arrays)', '셋 (sets)[^sets]', 그리고 '딕셔너리 (dictionaries; 사전)[^dictionaries]' 입니다. 배열은 값들이 순서에 따라 모여 있는 컬렉션이고, 셋은 값들이 순서는 없지만 각각 하나씩만 존재하는 컬렉션입니다. 딕셔너리는 '키-값 묶음 (key-value associations)' 들이 순서없이 모여 있는 컬렉션입니다.

![Array-Set-Dictionary](/assets/Swift/Swift-Programming-Language/Collection-Types-array-set-dictionary.png)

스위프트에 있는 배열, 셋, 그리고 딕셔너리는 저장할 수 있는 값과 키의 타입을 명확하게 알고 있습니다. 이는 실수로 컬렉션에 잘못된 타입의 값을 넣을 가능성은 없다는 의미입니다. 또 컬렉션에서 가져오는 값의 타입을 확신할 수 있다는 의미이기도 합니다.

> 스위프트의 배열, 셋 그리고 딕셔너리 타입은 _일반화된 집합체 (generic collections)_ 방식으로 구현되었습니다. 일반화된 타입과 일반화된 집합체 (generic types and collections) 에 대한 더 자세한 내용은 [Generics (일반화)](http://xho95.github.io/swift/language/grammar/generic/2020/02/29/Generics.html) 를 참고하기 바랍니다.

### Mutability of Collections (집합체의 변경-용이성)

배열, 셋 또는 딕셔너리를 하나 만들고, 이를 변수에 할당하면, 이렇게 생성된 컬렉션은 _변경 가능 (mutable)_ 합니다. 이는 컬렉션이 생성된 후, 컬렉션에 요소를 추가, 제거, 또는 변경하는 등의 방법으로 컬렉션을 바꿀 (즉 _변경할_) 수 있다는 의미입니다. 배열, 셋 또는 딕셔너리를 상수에 할당하면 이 컬렉션은 _변경 불가능 (immutable)_ 해져서 크기와 내용을 변경할 수 없습니다.

> 컬렉션을 변경할 필요가 없을 때는 항상 변경 불가능한 컬렉션으로 만드는 습관을 가지도록 합시다. 이렇게 하면 코드를 파악하기 쉬워지며 스위프트 컴파일러가 이 컬렉션의 성능을 최적화할 수 있게 만듭니다.

### Arrays (배열)

_배열 (array)_ 은 같은 타입의 값들을 순서에 따라 줄지어 저장합니다. 값끼리 같아도 한 배열 안에서 위치가 다르면 여러 번 나타날 수 있습니다.

> 스위프트의 `Array` 타입은 'Foundation' 프레임웍에 있는 `NSArray` 클래스와 연동되어 (bridged) 있습니다.
>
> 'Foundation' 및 'Cocoa' 프레임웍과 `Array` 를 같이 사용하는 방법에 대한 더 정보는 [Bridging Between Array and NSArray](https://developer.apple.com/documentation/swift/array#2846730) 에서 확인할 수 수 있습니다.

#### Array Type Shorthand Syntax (배열 타입 약칭 문법)

스위프트의 배열 타입을 온전하게 작성하는 방법은 `Array<Element>` 이며, 여기서 `Element` 는 배열에 저장하는 값의 타입입니다. 또한 배열 타입은 약칭으로 `[Element]` 와 같은 형태로 작성할 수도 있습니다. 두 양식의 기능은 동일하지만, 약칭 형태를 권장하며 이 책의 전체에서도 배열 타입은 약칭 형태로 사용하도록 합니다.

#### Creating an Empty Array (빈 배열 생성하기)

특정 타입의 빈 배열을 생성하려면 초기자 문법을 사용합니다:

```swift
var someInts = [Int]()
print(("someInts is of type [Int] with \(someInts.count) items.")
// "someInts is of type [Int] with 0 items." 를 출력합니다.
```
Note that the type of the someInts variable is inferred to be [Int] from the type of the initializer.

Alternatively, if the context already provides type information, such as a function argument or an already typed variable or constant, you can create an empty array with an empty array literal, which is written as [] (an empty pair of square brackets):

`someInts` 변수의 타입은 초기자의 타입으로부터 `[Int]` 로 추론할 수 있음을 주목하기 바랍니다.

또는 컨텍스트가 이미 함수 인수 또는 이미 입력 된 변수 또는 상수와 같은 유형 정보를 제공하는 경우 [] (빈 대괄호 쌍)으로 작성된 빈 배열 리터럴을 사용하여 빈 배열을 만들 수 있습니다.

* `someInts` : inferred to be `[Int]`
- create an empty array : an empty array literal - `[]` (an empty pair of square brackets)
    - if the context already provides type information

```swift
someInts.append(3)

// someInts now contains 1 value of type Int

someInts = []

// someInts is now an empty array, but is still of type [Int]
```

#### Creating an Array with a Default Value

* an initializer : creating an array of a certain size with the same default value
    * `count` : the number of items
    * `repeatedValue` : a default value of the appropriate type

```swift
var threeDoubles = [Double](count: 3, repeatedValue: 0.0)

// threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]
```

#### Creating an Array by Adding Two Arrays Together

* create a new array by adding together : the addition operator(`+`)

```swift
var anotherThreeDoubles = [Double](count: 3, repeatedValue: 2.5)

// anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]

var sixDoubles = threeDoubles + anotherThreeDoubles

// sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
```

#### Creating an Array with an Array Literal

* initialize an array : an **array literal** - a shorthand way

```
 [value 1, value 2, value 3]
```

```swift
var shoppingList_1: [String] = ["Eggs", "Milk"]

// shoppingList_1 has been initialized with two initial items
```

* `shoppingList_1` : an array of string values - `[String]` (store `String` values only)

> note:
 declared as a variable : more items are added

* the array literal : two `String` values - matches the type of the `shoppingList_1`
- Swift's type inference : don't have to write the type
- written in a shorter form

```swift
var shoppingList_2 = ["Eggs", "Milk"]
```

* Swift can infer that `[String]` is the correct type

#### Accessing and Modifying an Array

* access and modify an array : methods, properties, or subscript syntax
- `count` : read only property - to find out the number of items

```swift
print("The shopping list contains \(shoppingList_2.count) items.")

// Prints "The shopping list contains 2 items."
```

* `isEmpty` : the Boolean property - checking whether the `count` is equal to `0`

```swift
if shoppingList_2.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}

// Prints "The shopping list is not empty."
```

* `append(_:)` : method - add a new item to the end of an array

```swift
shoppingList_2.append("Flour")

// shoppingList_2 now contains 3 items, and someone is making pancakes
```

* `+=` : the addition assignment operator - append an array of compatible items

```swift
shoppingList_2 += ["Baking Powder"]

// shoppingList_2 now contains 4 items

shoppingList_2 += ["Chocolate Spread", "Cheese", "Butter"]

// shoppingList_2 now contains 7 items
```

* **subscript syntax** : retrieve a value

```swift
var firstItem = shoppingList_2[0]

// firstItem is equal to "Eggs"
```

> note:
 the first item in the array : an index of `0`, not `1`
> arrays in Swift : always zero-indexed

* **subscript syntax** : to change an existing value

```swift
shoppingList_2[0] = "Six eggs"

// the first item in the list is now equal to "Six eggs" rather than "Eggs"
```

* **subscript syntax** : to change a range of values at once
    * even if the replacement set of values has a different length

```swift
shoppingList_2[4...6] = ["Bananas", "Apples"]

// shoppingList_2 now contains 6 items
```
> note:
 can't use subscript syntax : to append a new item to the end of an array

* `insert(_:atIndex:)` : method - to insert an item into the array at a specified index

```swift
shoppingList_2.insert("Maple Syrup", atIndex: 0)

// shoppingList_2 now contains 7 items

// "Maple Syrup" is now the first item in the list
```

* `removeAtIndex(_:)` : method - removes the item at the specified index and returns the removed item

```swift
let mapleSyrup = shoppingList_2.removeAtIndex(0)

// the item that was at index 0 has just been removed

// shoppingList now contains 6 items, and no Maple Syrup

// the mapleSyrup constant is now equal to the removed "Maple Syrup" string
```

> note:
 an index that is outside of an array's existing bounds : trigger a runtime error
 check that an index is valid : by comparing it to the array's `count` - except when `count` is `0`
 the largest valid index : always be `count - 1` - arrays are indexed from zero

* any gaps in an array are closed when an item is removed

```swift
firstItem = shoppingList_2[0]

// firstItem is now equal to "Six eggs"
```

* `removeLast()` : method - to remove the final item, returns the removed item
    * rather than the `removeAtIndex(_:)` : to avoid to query the array's `count`

```swift
let apples = shoppingList_2.removeLast()

// the last item in the array has just been removed

// shoppingList_2 now contains 5 items, and no apples

// the apples constant is now equal to the removed "Apples" string
```

#### Iterating Over an Array

* the `for-in` loop : iterate over the entire set of values in an array

```swift
for item in shoppingList_2 {
    print(item)
}

// Six eggs
// Milk
// Flour
// Baking Powder
// Bananas
```

* `enumerate()` : need the integer index of each item as well as its value
    * returns a tuple composed of the index and the value

```swift
for (index, value) in shoppingList_2.enumerate() {
    print("Item \(index + 1): \(value)")
}

// Item 1: Six eggs
// Item 2: Milk
// Item 3: Flour
// Item 4: Baking Powder
// Item 5: Bananas
```

## Sets

* a **set** : stores distinct values of the same type with no defined ordering
    * use a set instead of an array when
        * the order of items is not important
        * ensure that an item only appears once
> note:
 Swift's `Set` type : bridged to Foundation's `NSSet` class

### Hash Values for Set Types

* a type : **hashable** - in order to be stored in a set
    * provide a way to compute a **hash value** for itself
* a hash value : an `Int` value - the same for all objects that compare equally
    * `a == b` : `a.hashValue == b.hashValue`

- all of Swift's basic type : hashable by default - set value types or dictionary key types
- enumeration case values without associated values : hashable by default

> note:
 custom types : conform to the `Hashable` protocol - Swift's standard library
 \
 provide a gettable `Int` property : `hashValue`
 \
 provide an implementation of the "is equal" operator(`==`) : `Equatable`
 \
 `==` : three conditions
 \
 Reflexivity : `a == a`
 \
 Symmetry : `a == b` implies `b == a`
 \
 Transitivity : `a == b && b == c` implies `a == c`

### Set Type Syntax

* the type of a Swift set :
    * `Set<Element>` : `Element` - the type that the set is allowed to store
    * sets do not have an equivalent shorthand form

### Creating and Initializing an Empty Set

* create an empty set : initializer syntax

```swift
var letters = Set<Character>()

print("letters is of type Set<Character> with \(letters.count) items.")

// Prints "letters is of type Set<Character> with 0 items."
```

> note:
 `letters` : inferred to be `Set<Character>` from the type of the initializer

* if the context already provides type information
* create an empty set : an empty array literal

```swift
letters.insert("a")

// letters now contains 1 value of type Character

letters = []

// letters is now an empty set, but is still of type Set<Character>
```

### Creating a Set with an Array Literal

* initialize a set : with an array literal - a shorthand way

```swift
var favoriteGenres_1: Set<String> = ["Rock", "Classical", "Hip Hop"]

// favoriteGenres_1 has been initialized with three initial items
```

* `favoriteGenres_1` : an set of `String` values - `Set<String>` (only allowed to store `String` values)

> note:
 declared as a variable : items are added and removed

* a set type : cannot be inferred - the type `Set` must be explicitly declared
* Swift's type inference : don't have to write the type of the set with an array literal
- written in a shorter form

```swift
var favoriteGenres_2: Set = ["Rock", "Classical", "Hip Hop"]
```

* all values in the array literal : the same type - infer that `Set<String>`

### Accessing and Modifying a Set

* access and modify a set : methods, properties
- `count` : read-only property - to find out the number of items in a set

```swift
print("I have \(favoriteGenres_2.count) favorite music genres.")

// Prints "I have 3 favorite music genres."
```

* `isEmpty` : the Boolean property - a shortcut for checking whether the `count` property is equal to `0`

```swift
if favoriteGenres_2.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}

// Prints "I have particular music preferences."
```

* `insert(_:)` : method - add a new item into a set

```swift
favoriteGenres_2.insert("Jazz")

// favoriteGenres now contains 4 items
```

* `remove(_:)` : method -
    * remove the item if it's a member of the set, and returns the removed value
    * return `nil` if the set did not contain it
- `removeAll()` : method - all items in a set can be removed

```swift
if let removeGenres = favoriteGenres_2.remove("Rock") {
    print("\(removeGenres)? I'm over it.")
} else {
    print("I never much cared for that.")
}

// Prints "Rock? I'm over it."
```

* `contains(_:)` : method - to check whether a set contains a particular item

```swift
if favoriteGenres_2.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}

// Prints "It's too funky in here."
```

### Iterating Over a Set

* a `for-in` loop : iterate over the values in set

```swift
for genre in favoriteGenres_2 {
    print("\(genre)")
}

// Classical
// Jazz
// Hip Hop
```

* Swift's `Set` type : not have a defined ordering
- `sort()` : to iterate over the values of a set in a specific order
    - returns the set's elements as an array sorted : the `<` operator

```swift
for genre in favoriteGenres_2.sort() {
    print("\(genre)")
}

// Classical
// Hip Hop
// Jazz
```

## Performing Set Operations

* efficiently perform fundamental set operations
    * combining two sets together
    * determining which values two sets have in common
    * determining whether two sets contain all, some, non of the same values

### Fundamental Set Operations

* `intersect(_:)` : to create a new set with only the values common to both sets
* `exclusiveOr(_:)` : to create a new set with values in either set, but not both
* `union(_:)` : to create a new set with all of the values in both sets
* `subtract(_:)` : to create a new set with values not in the specified set

```swift
let oddDigits: Set = [1, 3, 5, 7, 9]

let evenDigits: Set = [0, 2, 4, 6, 8]

let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sort()

// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

oddDigits.intersect(evenDigits).sort()

// []

oddDigits.subtract(singleDigitPrimeNumbers).sort()

// [1, 9]

oddDigits.exclusiveOr(singleDigitPrimeNumbers).sort()

// [1, 2, 9]
```

### Set Membership and Equality

* the illustration : `a`, `b` and `c`
    * `a` : a **superset** of set `b` - `a` contains all elements in `b`
    * `b` : a **subset** of set `a` - all elements in `b` are also contained by `a`
    * set `b` and set `c` : *disjoint* with one another - share no elements in common

- the "is equal" operator(`==`) : to determine whether two sets contain all of the same values
- `isSubsetOf(_:)` : to determine whether all of the values of a set are contained in the specified set
- `isSupersetOf(_:)` : to determine whether a set contains all of the values in a specified set
- `isStrictSubsetOf(_:)`, `isStrictSupersetOf(_:)` : to determine whether a set is a subset or superset, but not equal to a specified set
- `isDisjointWith(_:)` : to determine whether two sets have any values in common

```swift
let houseAnimals: Set = ["🐶", "🐱"]

let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]

let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubsetOf(farmAnimals)

// true

farmAnimals.isSubsetOf(houseAnimals)

// true

farmAnimals.isDisjointWith(cityAnimals)

// true
```

## Dictionaries

* a **dictionary** : stores associations between keys of the same type and values of the same type in a collection with no defined ordering
    * each value : associated with a unique **key** - an identifier for that value within the dictionary
    * items in a dictionary : do not have a specified order
    * use a dictionary : to look up values based on their identifier

> note:
 Swift's `Dictionary` type : bridged to Foundation's `NSDictionary` class

### Dictionary Type Shorthand Syntax

* the type of a Swift dictionary :
    * `Dictionary<Key, Value>`
        * `Key` : the type of values used as a dictionary key
        * `Value` : the type of value the dictionary stores for those keys

> note:
 a dictionary `Key` type : conform to the `Hashable` protocol

* `[Key: Value]` : shorthand form - preferred

### Creating an Empty Dictionary

* create an empty `Dictionary` : initializer syntax

```swift
var namesOfIntegers = [Int: String]()

// namesOfIntegers is an empty [Int: String] dictionary
```

* `[Int: String]` : keys - `Int`, values - `String`
- create an empty dictionary : an empty dictionary literal - `[:]` (a colon inside a pair of square brackets)

```swift
namesOfIntegers[16] = "sixteen"

// namesOfIntegers now contains 1 key-value pair

namesOfIntegers = [:]

// namesOfIntegers is once again an empty dictionary of type [Int: String]
```

### Creating a Dictionary with a Dictionary Literal

* initialize a dictionary : a **dictionary literal** - a shorthand way to write key-value pairs
- a **key-value pair** : a combination of a key and a value
    - the key and value : seperated by a colon
    - the key-value pairs : written as a list, seperated by commas, surrounded by a pair of square brackets

```
 [key 1: value 1, Key 2: value 2, key 3: value 3]
```

```swift
var airports_1: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
```

* `airports_1` : `[String: String]`

> note:
 declared as a variable : more items are added

* initialized with a dictionary literal containing two key-value pairs
- two `String: String` pairs
    - a dictionary with only `String` keys, and only `String` values
* don't have to write the type of the dictionary : consistent types - a shorter form

```swift
var airports_2 = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
```

* `airports_2` : infer that `[String: String]` is the correct type

### Accessing and Modifying a Dictionary

* access and modify a dictionary : methods, properties, or subscript syntax
- `count` : read only property - to find out the number of items in a `Dictionary`

```swift
print("The airports_2 dictionary contains \(airports_2.count) items.")

// Prints "The airports_2 dictionary contains 2 items."
```

* `isEmpty` : the Boolean property - a shortcut for checking whether the `count` is equal to `0`

```swift
if airports_2.isEmpty {
    print("The airports_2 dictionary is empty.")
} else {
    print("The airports_2 dictionary is not empty.")
}

// Prints "The airports_2 dictionary is not empty."
```

* subscript syntax : add a new item to a dictionary
    * a new key : appropriate type as the subscript index, a new value : appropriate type

```swift
airports_2["LHR"] = "London"

// the airports_2 dictionary now contains 3 items
```

* subscript syntax : to change the value associated with a particular key

```swift
airports_2["LHR"] = "London Heathrow"

// the value for "LHR" has been changed to "London Heathrow"
```

* `updateValue(_:forKey:)` : method - to set our update the value for a particular key
    * sets : if none exists, updates : if that key already exists
    * returns the old value after performing an update : to check whether or not an update took place
    * returns an optional value of the value type

```swift
if let oldValue = airports_2.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}

// Prints "The old value for DUB was Dublin."
```

* subscript syntax : to retrieve a value
    * a dictionary's subscript : returns an optional value
        * an optional values containing the existing value for key
        * returns `nil`

```swift
if let airportName = airports_2["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}

// Prints "The name of the airport is Dublin Airport."
```

* subscript syntax : to remove a key-value pair - by assigning a value of `nil` for that key

```swift
airports_2["APL"] = "Apple International"

// "Apple International" is not the real airport for APL, so delete it

airports_2["APL"] = nil

// APL has now been removed from the dictionary
```

* `removeValueForKey(_:)` : method
    * removes the key-value pair and returns the removed value
    * return `nil`

```swift
if let removedValue = airports_2.removeValueForKey("DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports_2 dictionary does not contain a value for DUB.")
}

// Prints "The removed airport's name is Dublin Airport."
```

### Iterating Over a Dictionary

* a `for-in` loop : iterate over the key-value pairs in a dictionary
    * each item : as a `(key, value)` tuple

```swift
for (airportCode, airportName) in airports_2 {
    print("\(airportCode): \(airportName)")
}

// YYZ: Toronto Pearson
// LHR: London Heathrow
```

* `keys` and `values` properties : retrieve an iterable collection of a dictionary's keys or values

```swift
for airportCode in airports_2.keys {
    print("Airport code: \(airportCode)")
}

// Airport code: YYZ
// Airport code: LHR

for airportName in airports_2.values {
    print("Airport name: \(airportName)")
}

// Airport name: Toronto Pearson
// Airport name: London Heathrow
```

* to use a dictionary's keys or values with an API that takes an `Array` instance
    * initialize an new array with the `keys` or `values` property

```swift
let airportCodes = [String](airports_2.keys)

// airportCodes is ["YYZ", "LHR"]

let airportNames = [String](airports_2.values)

// airportNames is ["Toronto Pearson", "London Heathrow"]
```

* Swift's `Dictionary` type : not have a defined ordering
- `sort()` on its `keys` or `values` : to iterate over the keys or values of a dictionary in a specific order

### 참고 자료

[^Collection-Types]: 원문은 [Collection Types](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html) 에서 확인할 수 있습니다.

[^collections]: 'collection' 은 '집합', '묶음' 등의 말로 옮길 수 있는데, 여기서는 보통의 경우 '컬렉션' 이라고 발음대로 사용하다가, 필요한 경우는 의미를 살려서 '집합체' 라는 말을 사용합니다. 이는 'class' 를 '객체', 'structure' 를 '구조체', 'enumeration' 을 '열거체' 라고 하는 것과의 통일성을 유지하기 위한 것입니다. 모두다 하나의 '타입' 이 될 수 있는 것들입니다.

[^sets]: 'Sets' 은 수학 용어로는 그 자체로 '집합' 이라는 뜻을 가지고 있는데, '집합' 이라고 하면 프로그래밍에서 다른 의미로 헷갈릴 수 있으므로, 여기서는 프로그래밍의 자료 타입 중 하나를 의미하도록 '셋' 이라는 발음 그대로 옮기도록 합니다.

[^dictionaries]: 'dictionaries' 는 '사전' 으로 옮길 수 있는데, 타입의 요소가 실제 사전처럼 '키' 와 '값' 의 두 가지 성분으로 되어있습니다. 다만 이 단어도 '사전' 이라고 하면 다른 의미로 해석될 수 있으므로, 여기서는 자료 타입을 의미하도록 '딕셔너리' 라고 발금 그대로 옮기도록 합니다.
