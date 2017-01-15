---
layout: post
comments: true
title:  "Swift 2.2: 집합형(Collection Types)"
date:   2016-06-06 19:45:00 +0900
categories: Swift Grammar Collection Types Array Set Dictionary
---

* three primary **collection type** : arrays, sets, and dictionaries
    * Arrays : ordered collections of values
    * Sets : unordered collections of unique values
    * Dictionaries : unordered collections of key-value associations
- always clear about the types of values and keys that they can store
    - be confident about the type of values

> note:
 Swift's array, set, and dictionary : implemented as **generic collections**

## Mutability of Collections

* mutable : assign it to a variable - change (or mutate) the collection
* immutable : assign the collections to a constant - its size and contents cannot be changed

> note:
 to create immutable collections : enable the Swift compiler to optimize the performance

## Arrays

* an **array** : stores values of the same type in an ordered list
    * the same value can appear in an array multiple times

> note:
 Swift's `Array` type : bridged to Foundation's `NSArray` class

### Array Type Shorthand Syntax

* the type of a Swift array :
    * `Array<Element>` - `Element` is type of values the array is allowed to store
    * `[Element]` : shorthand form - preferred

### Creating an Empty Array

* create an empty array : initializer syntax

```swift
var someInts = [Int]()

print("someInts is of type [Int] with \(someInts.count) items.")

// Prints "someInts is of type [Int] with 0 items."
```

* `someInts` : inferred to be `[Int]`
- create an empty array : an empty array literal - `[]` (an empty pair of square brackets)
    - if the context already provides type information

```swift
someInts.append(3)

// someInts now contains 1 value of type Int

someInts = []

// someInts is now an empty array, but is still of type [Int]
```

### Creating an Array with a Default Value

* an initializer : creating an array of a certain size with the same default value
    * `count` : the number of items
    * `repeatedValue` : a default value of the appropriate type

```swift
var threeDoubles = [Double](count: 3, repeatedValue: 0.0)

// threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]
```

### Creating an Array by Adding Two Arrays Together

* create a new array by adding together : the addition operator(`+`)

```swift
var anotherThreeDoubles = [Double](count: 3, repeatedValue: 2.5)

// anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]

var sixDoubles = threeDoubles + anotherThreeDoubles

// sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
```

### Creating an Array with an Array Literal

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

### Accessing and Modifying an Array

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

### Iterating Over an Array

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
