---
layout: post
title:  "Swift 2.2: 문자열(Strings and Characters)"
date:   2016-05-29 19:45:00 +0900
categories: Swift Grammar Strings Characters
---

* a string : a series of characters
* `String` : accessed in various ways - a collection of `Character` values
- `String`, `Character` types
    - fast, Unicode-compliant way
    - the syntax : lightweight and readable
    - a string literal syntax : similar to C
    - string concatenation : simple, `+` operator
    - string mutablity : like other value in Swift
    - string interpolation : use strings into longer strings
* `String`
    * encoding-independent Unicode characters
    * Unicode representations

> note:
 `String` : briged with Foundation's `NSString` class
 \
 Foundation framework in Cocoa
 \
    : entire `NSString` API is available to call on any `String` value
 \
    : use a `String` value with any API that requires an `NSString` instance

### String Literals

* include predefined `String` values : string literals
* string literal : a fiexed sequence of textual characters surrounded by a pair of double quotes ("")
- use a string literal as an initial value

```swift
let someString = "Some string literal value"
```

* Swift infers a type of `string` : initialized with a string literal value


### Initializing an Empty String

* to create an empty `String` value
    * assign an empty string literal
    * initialize a new `String` instance with initializer syntax

```swift
var emptyString = ""                // empty string literal

var anotherEmptyString = String()   // initializer syntax

// these two strings are both empty, and are qeuivalent to each other
```

* whether a `String` value is empty : `isEmpty` property

```swift
if emptyString.isEmpty {
    print("Nothing to see here")
}

// Prints "Nothing to see here"
```

### String Mutability

* indicate whether a particular `String` can be modified (mutated)

```swift
var variableString = "Horse"

variableString += " and carriage"

// variableString is now "Horse and carriage"

let constantString = "Highlander"

// constantString += " and another Highlander"

// this reports a compile-time error - a constant string cannot be modified
```
> note:
 different from string mutation in Objective-C and Cocoa : NSString, NSMutableString


### Strings Are Value Types

* Swift's `String` : a value type
    * copied when it is passed, or when it is assigend
    * the new copy is pssed or assigned, not the original version
- Swift's copy-by-default `String` behavior
    - it is clear that you own that exact `String` value
    - the string you are passed will not be modified unless you modify it yourself
* Swift's compiler optimizes string usage
    * actual copying takes place only when absolutely necessary
    * greate performance when working with strings


### Working with Characters

* access the indevidual `Character` values for a `String`
    * `characters` property with a `for-in` loop

```swift
for character in "Dog!🐶".characters {
    print(character)
}

// D
// o
// g
// !
// 🐶
```

* a stand-alone `Character` : a single-character string literal by providing a `Character` type annotation

```swift
let exclamationMark_1: Character = "!"
```

* `String` : constructed by passing an array of `Character` values to its initializer

```swift
let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]

let catString = String(catCharacters)

print(catString)

// Prints "Cat!🐱"
```


### Concatenating Strings an Characters

* add (or concatenate) : the addition operator (`+`) - a new `String` value

```swift
let string1 = "hello"

let string2 = " there"

var welcome_1 = string1 + string2

// welcome_1 now equals "hello there"
```

* append : the addition assignment operator(`+=`)

```swift
var instruction = "look over"

instruction += string2

// instruction now equals "look over there"
```

* append a `Character` value : the `String` type's `append()` method

```swift
let exclamationMark_2: Character = "!"

welcome_1.append(exclamationMark_2)

// welcome now equals "hello there!"
```
> note:
 can't append a `String` or `Character` to an existing `Character` variable
 \
 a `Character` value must contain a single character only


### String Interpolation

* string interpolation
    * a new `String` value from a mix of constants, variables, literals, and expressions
    * each item is wrapped in a pair of parentheses, prefixed by a backslash

```swift
let multiplier = 3

let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

// message is "3 times 2.5 is 7.5"
```

* this placeholder is replaced with the actual value

> note:
 the expressions
 \
 cannot contain an unescaped backslash(`\`), a carriage return, or a line feed
 \
 can contain other string literals


### Unicode

* **Unicode**
    * an international standard for encoding, representing, and processing text in different writing systems
    * represent almost any character from any language in a standardized form
- Swift's `String`, `Character` : fully Unicode-compliant


#### Unicode Scalars

* Swift's native `String` type : built from `Unicode scalar` values
* a Unicode scalar : a unique 21-bit number for a character or modifier
    * ex) LATIN SMALL LETTER A ("a") : `U+0061`

* not all 21-bit Unicode scalars are assigned to a character : reserved for future assignment
* scalars typically have a name

#### Special Characters in String Literals

* string literals can include the following special characters
- the escaped special characters
    - `\0` : null character
    - `\\` : backslash
    - `\t` : horizontal tab
    - `\n` : line feed
    - `\r` : carriage return
    - `\"` : double quote
    - `\'` : single quote
* an arbitrary Unicode scalar
    * `\u{n}` : n - a 1-8 digit hexadecimal number
- four examples of special characters

```swift
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"

// "Imagination is more important than knowledge" - Einstein

let dollarSign = "\u{24}"           // $, Unicode scalar U+0024

let blackHeart = "\u{2665}"         // ♥, Unicode scalar U+2665

let sparklingHeart = "\u{1F496}"    // 💖, Unicode scalar U+1F496
```


#### Extended Grapheme Clusters

* every instance of Swift's `Character` type : a single **extended grapheme cluster**
* an **extended grapheme cluster** :
    * a sequence of one or more Unicode scalars
    * produce a single human-readable character
- the letter `é`
    - represented as the single Unicode scalar `é` : `U+00E9`
    - represented as a pair of scalars : `e` (`U+0065`) + ` ́` (`U+0301`)
* In both cases, the letter `é` - a single Swift `Character` value

```swift
let eAcute: Character = "\u{E9}"                // é

let combinedEAcute: Character = "\u{65}\u{301}" // e followed by  ́

// eAcute is é, combinedEAcute is é
```

* Extended grapheme clusters : a flexible way
    * ex) Hangul syllables : represented as either a precomposed or decomposed sequence

```swift
let precomposed: Character = "\u{D55C}"                 // 한

let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"  // ᄒ, ᅡ, ᆫ

// precomposed is 한, decomposed is 한
```

* scalars for enclosing marks

```swift
let enclosedEAcute: Character = "\u{E9}\u{20DD}"

// enclosedEAcute is é⃝
```

* unicode scalars for regional indicator symbols : make a singe `Character` value
    * `U` (`U+1F1FA`) + `S` (`U+1F1F8`)

```swift
let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"

// regionalIndicatorForUS is 🇺🇸
```


### Counting Characters

* to retrieve a count of the `Character` values : the `count` property of the string's `characters`

```swift
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"

print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")

// Prints "unusualMenagerie has 40 characters"
```

* string concatenation and modification may not always affect a string's character count
    * extended grapheme clusters for `Character` values
- ex) cafe + ` ́` (`U+0301`) = a character count of `4`

```swift
var word = "cafe"

print("the number of characters in \(word) is \(word.characters.count)")

// Prints "the number of characters in cafe is 4"

word += "\u{301}"       // COMBINING ACUTE ACCENT, U+0301

print("the number of characters in \(word) is \(word.characters.count)")

// Prints "the number of characters in café is 4"
```

> note:
 Extended grapheme clusters : composed of one or more Unicode scalars
 \
 means that different characters and different representations of the same character can require different amounts of memory to store
 \
 characters in Swift do not each take up the same amount of memory within a string's representation
 \
 the number of characters in a string cannot be calculated without iterating through the string to determine its extended grapheme cluster boundaries
 \
 `characters` property must iterate over the Unicode scalars in the entire string in order to determine the characters for that sting : long string values - be aware that !
 \
 \
 the count of the characters : not always the same as the `length` property of an `NSString`
 \
 the length of an `NSString` : the number of 16-bit code units within the string's UTF-16 representation


### Accessing and Modifying a String

* access and modify a string : its methods and properties, or by using subscript syntax


#### String Indices

* each `String` value : has an associated index type - `String.Index`
    * the position of each `Character` in the string
- to determine which `Character` is at a position : iterate over each Unicode scalar from the start or end  of that `String`
- Swift strings cannot be indexed by integer values.
* `startIndex` : the position of the first `Character` of a `String`
* `endIndex` : the position after the last character in a `String` - `endIndex` isn't a valid argument to a string's subscript
* `String` is empty : `startIndex` and `endIndex` are equal
- a `String.Index` value
    - `predecessor()` : its immediately preceding index
    - `successor()` : its immediately succeeding index
- any index in a `String`
    - by chaining these methods together
    - by using the `advancedBy(_:)` method
- access an index outside of a string's range : trigger a runtime error

* subscript syntax : access the `Character` at a particular `String` index

```swift
let greeting = "Guten Tag!"

greeting[greeting.startIndex]

// G

greeting[greeting.endIndex.predecessor()]

// !

greeting[greeting.startIndex.successor()]

// u

let index = greeting.startIndex.advancedBy(7)

greeting[index]

// a
```

* access a `Character` at an index outside of a string's range : trigger a runtime error

```swift
// greeting[greeting.endIndex]     // error
// greeting.endIndex.successor()   // error
```

* `indices` property of the `characters` : create a `Range` of all of the indexes

```swift
for index in greeting.characters.indices {
    print("\(greeting[index]) ", terminator: "")
}

// prints "G u t e n   T a g ! "
```


#### Inserting and Removing

* `insert(_:atIndex:)` : to insert a character into a string at a specified index

```swift
var welcome_2 = "hello"

welcome_2.insert("!", atIndex: welcome_2.endIndex)

// welcome_2 now equals "hello!"
```

* `insertContentsOf(_:at:)` : to insert the contents of another string at a specified index

```swift
welcome_2.insertContentsOf(" there".characters, at: welcome_2.endIndex.predecessor())

// welcome_2 now equals "hello there!"
```

* `removeAtIndex(_:)` : to remove a character from a string at a specified index

```swift
welcome_2.removeAtIndex(welcome_2.endIndex.predecessor())

// welcome now equals "hello there"
```

* `removeRange(_:)` : to remove a substring at a specified range

```swift
let range = welcome_2.endIndex.advancedBy(-6)..<welcome_2.endIndex

welcome_2.removeRange(range)

// welcome now equals "hello"
```


### Comparing Strings

* three ways to compare textual values
    * string and character equality
    * prefix equality
    * suffix equality


#### String and Character Equality

* checked with the "equal to" operator (`==`) and the "not equal to" operator (`!=`)

```swift
let quotation = "We're a lot alike, you and I."

let sameQuotation = "We're a lot alike, you and I."

if quotation == sameQuotation {
    print("These two strings are considered equal")
}

// Prints "These two strings are considered equal."
```

* two `String` values (or two `Character` values) are considered equal
    * extended grapheme clusters are **canonically equivalent**
    * **canonically equivalent** : the same linguistic meaning and appearance
    * even if they are composed from different Unicode scalars
- ex) `é` (`U+00E9`) `== e` (`U+0065`) + ` ́` (`U+0301`)

```swift
// "Voulez-vous un café?" using LATIN SMALL LETTER E WITH ACUTE

let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

// "Voulez-vous un café?" using LATIN SMALL LETTER E and COMBINING ACUTE ACCENT

let combinedEAccuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

if eAcuteQuestion == combinedEAccuteQuestion {
    print("These two strings are considered equal")
}

// Prints "These two strings are considered equal"
```

* ex) `A` (`U+0041`) used in English is not equivalent to `А` (`U+0410`) used in Russian.
* the characters do not have the same linguistic meaning

```swift
let latinCapitalLetterA: Character = "\u{41}"

let cyrillicCapitalLetterA: Character = "\u{0410}"

if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters are not equivalent")
}

// Prints "These two characters are not equivalent"
```

> note:
 String and character comparisons in Swift are not locale-sensitive.


#### Prefix and Suffix Equality

* to check whether a string has a particular string prefix or suffix : `hasPrefix(_:)`, `hasSuffix(_:)` methods
* both take a single argument of type `String` and return a Boolean value
- the first two acts of Shakespeare's **Romeo and Juliet**

```swift
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]
```

* `hasPrefix(_:)` : to count the number of scenes in Act 1

```swift
var act1SceneCount = 0

for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1") {
        act1SceneCount += 1
    }
}

print("There are \(act1SceneCount) scenes in Act 1")

// Prints "There are 5 scenes in Act 1"
```

* `hasSuffix(_:)` : to count the number of scenes that take place in or around Capulet's mansion and Friar Lawrence's cell

```swift
var mansionCount = 0
var cellCount = 0

for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}

print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")

// Prints "6 mansion scenes; 2 cell scenes"
```

> note:
 `hasPrefix(_:)`, `hasSuffix(_:)` : a character-by-character canonical equivalence comparison between the extended grapheme clusters in each string


### Unicode Representations of Strings

* Unicode scalars : encoded in one of several Unicode-defined **encoding forms**
* each form encodes the string in small     - **code units**
    * the UTF-8 encoding form : encodes a string as 8-bit code units
    * the UTF-16 encoding form : encodes a string as 16-bit code units
    * the UTF-32 encoding form : encodes a string as 32-bit code units
- access a `String` value in one of three other Unicode-compliant representations
    - `utf8` property : a collection of UTF-8 code units
    - `utf16` property : a collection of UTF-16 code units
    - `unicodeScalars` property : a collection of 21-bit Unicode scalar values - equivalent to the string's UTF-32 encoding form
* each example below shows a different representation of the following string

```swift
let dogString = "Dog!!🐶"
```


#### UTF-8 Representation

* `utf8` : access a UTF-8 representation of a `String`
    * type : `String.UTF8View` - a collection of unsigned 8-bit values (`UInt8`)

```swift
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}

print("")

// 68 111 103 226 128 188 240 159 144 182
```

* `68, 111, 103` : `D`, `o`, and `g`
* `226, 128, 188` : `!!`
* `240, 159, 144, 182` : `🐶`


#### UTF-16 Representation

* `utf16` : access a UTF-8 representation of a `String`
    * type : `String.UTF16View` - a collection of unsigned 8-bit values (`UInt16`)

```swift
for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}

print("")

// 68 111 103 8252 55357 56374
```

* `68, 111, 103` : `D`, `o`, and `g` - the same values as in the string's UTF-8 representation
* `8252` : `!!` - a decimal equivalent of the hexadecimal value `203C`
* `55357, 56374` : `🐶` - a UTF-16 surrogate pair


#### Unicode Scalar Representation

* `unicodeScalars` : access a Unicode scalar representation of a `String`
    * type : `String.UnicodeScalarView` - a collection of `UnicodeScalar`
    * each `UnicodeScalar` has a `value` property : return the scalar's 21-bit value - a `UInt32` value

```swift
for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}

print("")

for scalar in dogString.unicodeScalars {
    print("\(scalar) ")
}

// 68 111 103 8252 128054
```

* `68, 111, 103` : `D`, `o`, and `g` - the same values as in the string's UTF-8 representation
* `8252` : `!!` - a decimal equivalent of the hexadecimal value `203C`
* `128054` : `🐶` - a decimal equivalent of the hexadecimal value `1F436`

* an alternative to querying `value` properties : `UnicodeScalar`
