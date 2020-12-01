---
layout: post
comments: true
title:  "Swift 5.2: Collection Types (집합체 타입)"
date:   2016-06-06 19:45:00 +0900
categories: Swift Grammar Collection Array Set Dictionary
redirect_from: "/swift/grammar/collection/array/set/dictionary/2016/06/06/Collection-Types.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Collection Types](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html) 부분[^Collection-Types]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 스위프트 5.3 에 대한 내용이 다시 일부 수정되어서,[^swift-update] 추가된 내용 먼저 옮기고 나머지 부분을 옮기도록 합니다. 전체 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Collection Types (집합체 타입)

스위프트는 값의 집합을 저장하는 용도로 세 가지의 주요 _컬렉션 타입 (collection types; 집합체 타입)_[^collections] 을 제공하는데, 이는 '배열 (arrays)', '셋 (sets)[^sets]', 그리고 '딕셔너리 (dictionaries; 사전)[^dictionaries]' 입니다. 배열은 값들이 순서에 따라 모여 있는 컬렉션이고, 셋은 값들이 순서는 없지만 각각 하나씩만 존재하는 컬렉션입니다. 딕셔너리는 '키-값 결합 (key-value associations)' 들이 순서없이 모여 있는 컬렉션입니다.

![Array-Set-Dictionary](/assets/Swift/Swift-Programming-Language/Collection-Types-array-set-dictionary.jpg)

스위프트에 있는 배열, 셋, 그리고 딕셔너리는 저장할 수 있는 값과 키의 타입을 명확하게 알고 있습니다. 이는 실수로 컬렉션에 잘못된 타입의 값을 넣을 가능성은 없다는 의미입니다. 또 컬렉션에서 가져오는 값의 타입을 확신할 수 있다는 의미이기도 합니다.

> 스위프트의 배열, 셋 그리고 딕셔너리 타입은 _일반화된 집합체 (generic collections)_ 방식으로 구현되었습니다. 일반화된 타입과 일반화된 집합체 (generic types and collections) 에 대한 더 자세한 내용은 [Generics (일반화)]({% post_url 2020-02-29-Generics %}) 를 참고하기 바랍니다.

### Mutability of Collections (집합체의 변경 가능성)

배열, 셋 또는 딕셔너리를 하나 만들고, 이를 변수에 할당하면, 이렇게 생성된 컬렉션은 _변경 가능 (mutable)_ 합니다. 이는 컬렉션이 생성된 후, 컬렉션에 항목을 추가, 제거, 또는 변경하는 등의 방법으로 컬렉션을 바꿀 (즉 _변경할_) 수 있다는 의미입니다. 배열, 셋 또는 딕셔너리를 상수에 할당하면 이 컬렉션은 _변경 불가능 (immutable)_ 해져서 크기와 내용을 변경할 수 없습니다.

> 컬렉션을 변경할 필요가 없을 때는 항상 변경 불가능한 컬렉션으로 만드는 습관을 가지도록 합시다. 이렇게 하면 코드를 파악하기 쉬워지며 스위프트 컴파일러가 이 컬렉션의 성능을 최적화할 수 있게 만듭니다.

### Arrays (배열)

_배열 (array)_ 은 같은 타입의 값들을 순서에 따라 줄지어 저장합니다. 값끼리 같아도 한 배열 안에서 위치가 다르면 여러 번 나타날 수 있습니다.

> 스위프트의 `Array` 타입은 'Foundation' 프레임웍에 있는 `NSArray` 클래스와 연동되어 (bridged) 있습니다.
>
> 'Foundation' 및 'Cocoa' 프레임웍과 `Array` 를 같이 사용하는 방법에 대해서는 [Bridging Between Array and NSArray](https://developer.apple.com/documentation/swift/array#2846730) 에서 더 자세히 알 수 있습니다.

#### Array Type Shorthand Syntax (배열 타입 약칭 구문 표현)

스위프트의 배열 타입을 온전하게 작성하는 방법은 `Array<Element>` 이며, 여기서 `Element` 는 배열에 저장하는 값의 타입입니다. 또한 배열 타입은 약칭으로 `[Element]` 와 같은 형태로 작성할 수도 있습니다. 두 양식의 기능은 동일하지만, 약칭 형태를 권장하며 이 책의 전체에서도 배열 타입은 약칭 형태로 사용하도록 합니다.

#### Creating an Empty Array (빈 배열 생성하기)

특정 타입의 빈 배열을 생성하려면 초기자 문법을 사용합니다:

```swift
var someInts = [Int]()
print(("someInts is of type [Int] with \(someInts.count) items.")
// "someInts is of type [Int] with 0 items." 를 출력합니다.
```

`someInts` 변수의 타입은 초기자의 타입으로부터 `[Int]` 로 추론할 수 있음을 기억하기 바랍니다.

다른 방법으로, 영역 내에서 이미 타입 정보를 제공하는 경우, 예를 들면 함수 인자에서나 이미 타입이 알려진 변수 또는 상수일 경우에, '빈 배열 글자 값 (empty array literal)' 을 써서 빈 배을을 생성할 수도 있으며, 이 때는 `[]` (빈 대괄호 쌍) 만 써주면 됩니다:

```swift
someInts.append(3)
// someInts 는 이제 Int 타입 값 1 개를 갖습니다.
someInts = []
// someInts 는 이제 빈 배열이 됐지만, 타입은 여전히 [Int] 입니다.
```

#### Creating an Array with a Default Value (기본 설정 값을 가진 배열 생성하기)

스위프트의 `Array` 타입에는 특정 크기의 배열을 생성하면서 모든 값을 동일한 기본 설정 값으로 설정할 수 있는 초기자도 있습니다. 이 초기자에 적절한 타입의 기본 설정 값 (명칭은 `repeating`): 과 이 값이 배열에서 반복되야할 횟수 (명칭은 `count`): 를 전달하면 됩니다:

```swift
var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles 의 타입은 [Double] 이고, 값은 [0.0, 0.0, 0.0] 과 같습니다.
```

#### Creating an Array by Adding Two Arrays Together (두 배열을 서로 더해서 하나의 배열 생성하기)

두 개의 기존 배열이 더하기 연산자 (`+`) 에 대해 '호환성을 가지는 (compatible)'[^compatible] 타입들인 경우 서로 더해서 새로운 배열을 생성할 수 있습니다. 새 배열의 타입은 서로 더한 두 배열의 타입으로부터 추론합니다:

```swift
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles 의 타입은 [Double] 이고, 값은 [2.5, 2.5, 2.5] 와 같습니다.

var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles 의 타입은 [Double] 로 추론되며, 값은 [0.0, 0,0, 0.0, 2.5, 2.5, 2.5] 와 같습니다.
```

#### Creating an Array with an Array Literal (배열 글자 값을 사용해서 배열 생성하기)

_배열 글자 값 (array literal)_[^literal] 을 써서 배열을 초기화 할 수도 있는데, 이는 하나 이상의 값을 가진 배열 집합체 (array collection) 를 '약칭 (shorthand)' 으로 만들 수 있는 방법입니다. '배열 글자 값' 을 작성하려면 값을 나열하면서, 쉼표로 나누고, 대괄호 쌍으로 감싸면 됩니다.

[`value 1`, `value 2`, `value 3`]

아래 예제는 `shoppingList` 라는 배열을 만들어 `String` 값을 저장하고 있습니다:

```swift
var shoppingList: [String] = ["Eggs", "Milk"]
// shoppingList 를 두 개의 초기 항목으로 초기화했습니다.
```

`shoppingList` 변수는 `[String]` 을 써서 "문자열 값의 배열" 로 선언했습니다. 이 배열은 `String` 타입의 값만 갖도록 지정됐으므로, 이제 `String` 값만 저장할 수 있습니다. 여기서, `shoppingList` 배열은 '배열 글자 값 (array literal)' 에 있는 두 개의 `String` 값인 (`"Eggs"` 와 `"Milk"`) 로 초기화 되었습니다.

> `shoppingList` 배열은 (`var` 소개자를 쓰는) 변수로 선언되었지 (`let` 소개자를 쓰는) 상수로 선언된 것이 아닙니다. 이는 아래 예제에서 이 `shoppingList` 에 더 많은 항목을 추가할 것이기 때문입니다.

이 경우, '배열 글자 값 (array literal)' 에는 두 개의 `String` 값만 있지 다른 건 전혀 없습니다. 이는 `shoppingList` 변수를 선언할 때의 타입 (`String` 값만 담을 수 있는 배열) 과 들어 맞으므로, '배열 글자 값' 을 할당하는 것이 허용되어 두 개의 초기 항목들로 `shoppingList` 를 초기화할 수 있습니다.

스위프트의 타입 추론 덕분에, 배열의 타입을 안써도 되는 경우가 있는데, 초기화할 때 '배열 글자 값' 이 같은 타입의 값만 가지고 있으면 그렇습니다. 따라서 `shoppingList` 의 초기화는 앞에서보다 더 짧은 형태로도 작성할 수 있습니다:

```swift
var shoppingList = ["Eggs", "Milk"]
```

'배열 글자 값' 의 모든 값이 같은 타입이므로, 스위프트는 `shoppingList` 변수가 정확하게 `[String]` 타입임을 추론할 수 있습니다.

#### Accessing and Modifying an Array (배열에 접근하고 수정하기)

배열은 메소드 (methods) 와 속성 (properties), 또는 '첨자 연산 구문 표현 (subscript syntax)' 을 사용하여 접근하고 수정할 수 있습니다.

배열에 있는 항목의 개수를 알고 싶으면, 읽기-전용 속성인 `count` 를 검사하면 됩니다:

```swift
print("The shopping list contains \(shoppingList.count) items.")
// "The shopping list contains 2 items." 를 출력합니다.
```

불리언 (Boolean) 속성인 `isEmpty` 를 사용하면, `count` 속성이 `0` 과 같은 지를 더 간단하게 검사할 수 있습니다[^isEmpty-count]:

```swift
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}
// "The shopping list is not empty." 를 출력합니다.
```

배열의 `append(_:)` 메소드를 호출하면 배열 끝에 새로운 항목을 추가할 수 있습니다:

```swift
shoppingList.append("Flour")
// shoppingList 는 이제 3 개의 항목을 가지며, 누군가 팬케이크를 만들 수 있게 됐습니다.
```

다른 방법으로는, '더하기 할당 연산자 (addition assignment operator; `+=`)' 로 하나 이상의 호환 가능한 항목을 배열에 덧붙일 수 있습니다:

```swift
shoppingList += ["Baking Powder"]
// shoppingList 는 이제 4 개의 항목을 가집니다.
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
// shoppingList 는 이제 7 개의 항목을 가집니다.
```

배열에서 값을 가져오려면 _첨자 연산 구문 표현 (subscript syntax)_ 을 사용하며, 이는 배열 이름 바로 뒤의 대괄호 안에 가져올 값의 _색인 (index)_ 을 넣으면 됩니다:

```swift
var firstItem = shoppingList[0]
// firstItem 은 "Eggs" 가 됩니다.
```

> 배열의 첫 번째 항목은, `1` 이 아니라, `0` 번 색인을 가집니다. 스위프트에 있는 배열은 항상 '0 기준-색인 (zero-indexed)' 으로 되어 있습니다.

'첨자 연산 구문 표현' 을 사용하면 주어진 색인 위치의 값을 바꿀 수 있습니다:

```swift
shoppingList[0] = "Six eggs"
// 목록에 있는 첫 번째 항목은 이제 "Eggs" 가 아니라 "Six eggs" 입니다.
```

'첨자 연산 구문 표현' 을 사용할 때, 지정하는 색인은 유효해야 합니다. 예를 들어, 배열 끝에 항목을 추가한다고 `shoppingList[shoppingList.count] = "Salt"` 라고 작성하면 '실행 시간 에러 (runtime error)' 로 끝나게 됩니다.[^count-concurrent]

'첨자 연산 구문 표현' 을 사용하면 일정 범위의 값들을 한 번에 바꿀 수도 있는데, 이 때 대체될 값의 범위와 대체할 범위가 서로 다른 길이여도 됩니다. 다음 예제는 `"Chocolate Spread"`, `"Cheese"`, 및 `"Butter"` 를 `"Bananas"` 와 `"Apples"` 로 대체합니다:

```swift
shoppingList[4...6] = ["Bananas", "Apples"]
// shoppingList 는 이제 6 개의 항목을 가집니다.
```

배열에서 지정된 색인 위치에 항목을 집어 넣으려면, 배열의 `insert(_:at:)` 메소드를 호출합니다:

```swift
shoppingList.insert("Maple Syrup", at: 0)
// shoppingList 는 이제 7 개의 항목을 가집니다.
// "Maple Syrup" 이 이제 목록의 첫 번째 항목입니다.
```

이 `insert(_:at:)` 메소드 호출은 값이 `"Maple Syrup"` 인 새 항목을 '쇼핑 목록 (shopping list)' 의 맨 처음 위치인, 색인 `0` 으로 나타낸 곳에, 집어 넣습니다.

이와 비슷하게, `remove(at:)` 메소드로 배열에서 항목을 제거합니다. 이 메소드는 지정된 색인 위치의 항목을 제거하며 제거한 그 항목을 반환합니다. (필요 없다면 이 반환 값은 무시할 수도 있습니다):

```swift
let mapleSyrup = shoppingList.remove(at: 0)
// 색인 0 위치의 값을 방금 제거했습니다.
// shoppingList 는 이제 6 개의 항목을 가지며, Maple Syrup 은 더 이상 없습니다.
// mapleSyrup 이라는 상수는 이제 제거한 문자열인 "Maple Syrup" 이 됩니다.
```

> 배열 범위를 벗어난 색인으로 값에 접근하려고 하거나 수정하려고 하면 '실행 시간에 에러 (runtime error)' 를 띄웁니다. 색인을 사용하기 전에 유효한 지를 검사하고 싶으면 배열의 `count` 속성과 비교하면 됩니다. 배열에서 유효한 색인으로 가장 큰 것은 `count - 1` 인데, 배열의 '색인은 영-기준 (indexed from zero)' 이기 때문입니다 - 하지만, `count` 가 `0` (즉 배열이 비어있으면) 이면, 유효한 색인이 아예 없습니다.

항목을 제거할 때는 배열의 모든 틈이 다 메워지므로, 색인 `0` 에 있는 값은 다시 한번 `"Six eggs"` 가 됩니다:

```swift
firstItem = shoppingList[0]
// firstItem 은 이제 "Six eggs" 입니다.
```

배열에서 마지막 항목을 제거하려면, `remove(at:)` 메소드 대신 `removeLast()` 메소드를 사용하는 것이 좋은데, 이는 배열의 `count` 속성을 조회할 필요가 없기 때문입니다. `remove(at:)` 메소드 처럼, `removeLast()` 메소드도 제거한 그 항목을 반환합니다:

```swift
let apples = shoppingList.removeLast()
// 배열의 마지막 항목을 방금 제거했습니다.
// shoppingList 는 이제 5 개의 항목을 가지며, Apples 은 더 이상 없습니다.
// 이제 상수 apples 는 제거된 문자열인 "Apples" 가 됩니다.
```

#### Iterating Over an Array (배열에 동작을 반복 적용하기)

`for-in` 반복문 (loop) 을 사용하면 배열에 있는 전체 값들에 '동작을 반복 적용 (iterate over)'[^iterate-over] 할 수 있습니다:

```swift
for item in shoppingList {
    print(item)
}

// Six eggs
// Milk
// Flour
// Baking Powder
// Bananas
```

각 항목의 값 뿐만 아니라 정수 색인도 필요하다면, 배열에 동작을 반복시킬 때 `enumerated()`[^enumerate] 메소드도 같이 사용하면 됩니다. `enumerated()` 메소드는, 배열의 각 항목에 대해서, 정수와 해당 항목의 조합으로 된 '튜플 (tuple)'[^tuple] 을 반환합니다. 이 정수는 '0' 에서 시작해서 각 항목마다 하나씩 증가합니다; 전체 배열을 열거하는 경우, 이 정수들은 항목들의 색인과 일치하게 됩니다. '반복 구문 (iteration)' 에서 '튜플' 을 임시 상수 또는 임시 변수로 분해 (decompose) 할 수 있습니다:

```swift
for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}

// Item 1: Six eggs
// Item 2: Milk
// Item 3: Flour
// Item 4: Baking Powder
// Item 5: Bananas
```

`for-in` 반복문에 대한 더 자세한 내용은, [For-In Loops (For-In 반복문)]({% post_url 2020-06-10-Control-Flow %}#for-in-loops-for-in-반복문) 을 참고하기 바랍니다.

### Sets (셋; 집합)

_셋 (set)_ 은 같은 타입의 서로 다른 값들을 정의된 순서없이 컬렉션에 저장합니다. 항목의 순서가 중요하지 않을 때, 또는 항목이 단 한 번만 나타나도록 보장해야할 때, 배열 대신 셋을 사용할 수 있습니다.

> 스위프트의 `Set` 타입은 'Foundation' 프레임웍에 있는 `NSSet` 클래스와 연동되어 (bridged) 있습니다.
>
> 'Foundation' 및 'Cocoa' 프레임웍과 `Set` 을 같이 사용하는 방법에 대해서는 [Bridging Between Set and NSSet](https://developer.apple.com/documentation/swift/set#2845530) 에서 더 자세히 알 수 있습니다.

#### Hash Values for Set Types (셋 타입의 해쉬 값)

셋에 저장하는 타입은 반드시 _해쉬 가능 (hashable)_[^hashable] 해야 합니다 - 이것은, 이 타입은 반드시 자체적으로 _해쉬 값 (hash value)_[^hash-value] 을 계산할 수 있어야 한다는 말입니다. 여기서 해시 값이란, 하나의 `Int` 값으로서, 비교했을 때 같다고 판단되는 객체들은 모두 같아야 하는 값을 말하는 것으로, 가령 `a == b` 인 경우, 이는 필연적으로 `a.hashValue == b.hashValue` 이라는 말이 됩니다.

스위프트의 모든 기본 타입 (가령 `String`, `Int`, `Double` 그리고 `Bool`) 은 기본적으로 해시 가능하므로, '셋 (set)' 의 값 타입과 '딕셔너리 (dictionary)' 의 키 (key) 타입으로 사용할 수 있습니다. ([Enumerations (열거체)]({% post_url 2020-06-13-Enumerations %}) 에서 설명하듯이) '결합된 값 (associated values)' 이 없는 '열거체[^enumeration] case 값 (enumeration case value)' 역시 기본적으로 해시 가능합니다.   

> 자신이 만든 타입을 셋의 값 타입이나 딕셔너리의 키 타입으로 사용하고 싶으면, 스위프트 표준 라이브러리에 있는 `Hashable` 프로토콜을 준수하도록 하면 됩니다. `Hashable` 프로토콜을 준수하는 타입은 반드시 `hashValue` 라는 읽을 수 있는 (gettable) `Int` 속성을 제공해야 합니다. 같은 프로그램을 다른 시점에 실행할 때나 다른 프로그램을 실행할 때, 이 타입의 `hashValue` 속성이 반환하는 값을 같도록 만들 필요는 없습니다.
>
> `HashValue` 프로토콜은 `Equatable`[^equtable] 을 준수하므로, ('Hashable' 을) '준수하는 타입 (conforming types)' 은 반드시 '같음 연산자 (`==`)' 도 구현해야 합니다. `Equatable` 프로토콜은 '같은 값을 가진 관계 (equivalent relation)' 임을 알기 위해서 어떤 형태로든 `==` 의 구현이 필요하기 때문입니다. 좀 더 정확하게 말하면, 모든 `a`, `b`, `c` 값에서, `==` 의 구현은  다음의 세 가지를 반드시 만족해야 합니다:
>
> * `a == a` (Reflexivity; 반사성[^reflexivity])
> * `a == b` 는 곧 `b == a` (Symmetry; 대칭성[^symmetry])
> * `a == b && b == c` 는 곧 `a == c` (Transitivity; 추이성[^transitivity])
>
> 프로토콜 준수에 대한 더 자세한 내용은 [Protocols (규약)]({% post_url 2016-03-03-Protocols %}) 을 보도록 합니다.

#### Set Type Syntax (셋 타입 문법)

스위프트의 '셋' 타입은 `Set<Element>` 라고 작성하며, 여기서 `Element` 는 셋에 저장할 수 있는 타입을 말합니다. '배열' 과 달리, '셋' 은 약칭으로 쓸 수 있는 형태가 없습니다.

#### Creating and Initializing an Empty Set (빈 셋 생성하고 초기화하기)

특정 타입의 빈 '셋' 을 만들려면 초기자 문법을 사용하면 됩니다:

```swift
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
// "letters is of type Set<Character> with 0 items." 을 출력합니다.
```

> `letters` 변수의 타입은 초기자의 타입에 의해 `Set<Character>` 로 추론됩니다.

다른 방법으로는, 영역 내에서 타입 정보를 제공하는 경우, 가령 함수 인자이거나 이미 타입이 알려진 변수 또는 상수인 경우, 빈 배열은 '빈 배열 글자 값' 을 써서 생성할 수 있습니다:


```swift
letters.insert("a")
// letters 는 이제 Character 타입 값 1 개를 갖고 있습니다.
letters = []
// letters 는 이제 빈 셋이 됐지만, 타입은 여전히 Set<Character> 입니다.
```

#### Creating a Set with an Array Literal (배열 글자 값을 사용하여 셋-집합 생성하기)

'배열 글자 값' 으로 '셋 (set)' 을 초기화할 수도 있는데, 이는 '셋 컬렉션 (set collection)' 에 하나 이상의 값을 할당하는 '약칭법 (shorthand way)' 입니다.

아래 예제는 `favoriteGenres` 라는 셋을 만든 후 `String` 값을 저장하는 방법을 보여줍니다:

```swift
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip Hop"]
// favoriteGenres 를 3 개의 초기 항목으로 초기화했습니다.
```

`favoriteGenres` 변수는 `Set<String>` 을 써서 "`String` 값의 셋” 으로 선언되었습니다. 이 셋은 `String` 타입의 값을 지정했기 때문에, `String` 값만 저장할 수 있습니다. 여기서 `favoriteGenres` 셋은 '배열 글자 값' 에 있는 세 개의 `String` 값인 (`"Rock"`, `"Classical"`, 그리고 `"Hip hop"`) 으로 초기화 됩니다.

> `favoriteGenres` 셋은 (`var` 소개자를 써서) 변수로 선언되었으며, (`let` 소개자를 쓴) 상수가 아닙니다. 이는 아래 예제에서 항목을 추가하거나 제거할 것이기 때문입니다.

셋 타입은 '배열 글자 값 (array literal)' 만으로는 추론할 수 없으므로[^set-array-literal], `Set` 이라는 타입은 반드시 명시적으로 선언해야 합니다. 그러나 스위프트의 타입 추론 기능에 의해서, '배열 글자 값' 이 하나의 타입만 갖고 있는 경우, 셋의 '원소 (elements)' 타입은 쓸 필요가 없습니다. 따라서 `favoriteGenres` 의 초기화는 다음 처럼 더 짧은 양식으로 작성 할 수 있습니다:

```swift
var favoriteGenres: Set = ["Rock", "Classical", "Hip Hop"]
```

'배열 글자 값' 에 있는 모든 값들이 같은 타입이므로, 스위프트는 `favoriteGenres` 변수가 `Set<String>` 임을 올바르게 추론할 수 있습니다.

#### Accessing and Modifying a Set (셋에 접근하고 수정하기)

메소드와 속성을 통해 셋에 접근하고 이를 수정할 수 있습니다.

셋에 있는 항목의 개수를 알고 싶으면, 읽기-전용 속성인 `count` 를 검사하면 됩니다:

```swift
print("I have \(favoriteGenres.count) favorite music genres.")
// "I have 3 favorite music genres." 를 출력합니다.
```
`count` 속성이 `0` 인지를 검사해야할 때는 더 간단한 방법으로 불리언 (Boolean) 속성인 `isEmpty` 를 사용합니다:

```swift
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}

// "I have particular music preferences." 를 출력합니다.
```

셋에 새로운 항목을 추가할 때는 `insert(_:)` 메소드를 호출하면 됩니다:

```swift
favoriteGenres.insert("Jazz")
// favoriteGenres 는 이제 4 개의 항목을 갖고 있습니다.
```

셋에 있는 항목을 제거하려면 셋의 `remove(_:)` 메소드를 호출하면 되는데, 셋의 멤버인 경우라면 그 항목을 제거하고, 제거한 그 값을 반환하지만, 만약 셋이 가지고 있지 않은 경우라면 `nil` 을 반환합니다. 다른 방법으로, `removeAll()` 메소드로 셋에 있는 모든 항목을 제거할 수 있습니다.

```swift
if let removeGenres = favoriteGenres.remove("Rock") {
    print("\(removeGenres)? I'm over it.")
} else {
    print("I never much cared for that.")
}
// "Rock? I'm over it." 를 출력합니다.
```

셋이 특정한 항목을 가지고 있는지 검사하려면, `contain(_:)` 메소드를 사용합니다.

```swift
if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}
// "It's too funky in here." 를 출력합니다.
```

#### Iterating Over a Set (셋에 동작을 반복 적용하기)

`for`-`in` 반복문으로 셋에 있는 값들에 '동작을 반복시킬 (iterate over)' 수 있습니다:

```swift
for genre in favoriteGenres {
    print("\(genre)")
}

// Classical
// Jazz
// Hip Hop
```

`for`-`in` 반복문에 대한 더 자세한 내용은, [For-In Loops (For-In 반복문)]({% post_url 2020-06-10-Control-Flow %}#for-in-loops-for-in-반복문) 을 참고하기 바랍니다.

스위프트의 `Set` 타입은 정의된 순서란 것을 가지고 있지 않습니다. 지정된 순서대로 셋의 값에 동작을 반복시키려면, `<` 연산자로 셋의 원소들을 정렬된 배열 형태로 반환하는, `sorted()` 메소드를 사용합니다.

```swift
for genre in favoriteGenres.sort() {
    print("\(genre)")
}

// Classical
// Hip Hop
// Jazz
```

### Performing Set Operations (집합-셋 연산 수행하기)

(셋으로) 기본 '(집합) 연산'[^set-operations] 을 효율적으로 수행할 수 있습니다. 이에는 두 집합-셋-을 서로 합하는 것, 두 집합-셋-에 공통인 값을 결정하는 것, 또는 두 집합-셋-에 있는 값이 모두 같은 지, 일부만 같은 지, 아니면 같은 게 전혀 없는 지를 결정하는 것 등이 있습니다.

### Fundamental Set Operations (기본 집합-셋 연산)

아래 그림은 두 개의 셋-`a` 와 `b`-에 대해 다양한 집합-셋 연산을 수행한 결과를 음영으로 보여줍니다.

![Fundamental-Set-Operations](/assets/Swift/Swift-Programming-Language/Collection-Types-fundamental-set-operations.jpg)

* `intersect(_:)` 메소드를 사용하여 생성한 새 집합-셋은 두 집합-셋에 공통된 값만 담고 있습니다.
* `exclusiveOr(_:)` 메소드를 사용하여 생성한 새 집합-셋은 각각의 집합-셋에는 있지만 공통되지는 않는 값만 담고 있습니다.
* `union(_:)` : 메소드를 사용하여 생성한 새 집합-셋은 두 집합-셋에 있는 모든 값을 담고 있습니다.
* `subtract(_:)` 메소드를 사용하여 생성한 새 집합-셋은 특정한 집합-셋에는 없는 값만을 답고 있습니다.

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

### Set Membership and Equality (집합-셋의 포함 및 동등 비교)

아래 그림은 세 개의 셋-`a`, `b`, 와 `c`-에서 서로 공유하는 원소들을 겹침 영역 (overlapping regions) 으로 보여줍니다. 여기서 집합-셋 `a` 는 집합-셋 `b` 의 _상위집합 (superset)_ 이며, 이는 `a` 가 `b` 의 모든 원소를 포함하기 때문입니다. 반대로, 집합-셋 `b` 는 집합-셋 `a` 의 _하위집합 (subset; 부분 집합)_ 으로, `b` 의 모든 원소는 `a` 에도 포함되기 때문입니다. 집합-셋 `b`와 집합-셋 `c`는 서로 _분리 (disjoint)_[^disjoint] 되었다고 하며, 이들은 공유하고 있는 공통 원소가 전혀 없기 때문입니다.

![Set-Membership-and-Equality](/assets/Swift/Swift-Programming-Language/Collection-Types-set-membership-and-equality.jpg)

* “같음 (is equal)” 연산자 (`==`) 를 사용하여 두 집합-셋이 모두 같은 값을 가지고 있는지를 확인합니다.
* `isSubset(of:)` 메소드를 사용하여 한 집합-셋에 있는 모든 값들이 지정된 집합-셋에 포함되어 있는지를 확인합니다.
* `isSuperset(of:)` 메소드를 사용하여 한 집합-셋이 지정된 집합-셋에 있는 모든 값을 포함하는지를 확인합니다.
* `isStrictSubset(of:)` 또는 `isStrictSuperset(of:)` 메소드를 사용하여 한 집합-셋이 지정된 집합-셋의 하위집합 (부분집합) 또는 상위집합이면서, 같지는 않은 관계인지를 확인합니다.
* `isDisjoint(with:)` 메소드를 사용하여 두 집합-셋이 공통된 값을 가지고 있지 않은 것을 확인합니다.

```swift
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true
```

## Dictionaries (딕셔너리; 사전)

딕셔너리는 '키-값 결합 (key-value associations)' 들이 순서없이 모여 있는 컬렉션입니다.

_딕셔너리 (dictionary; 사전)_ 는 동일한 타입의 키들과 동일한 타입의 값들 사이의 '결합 (associations)' 을 컬렉션에 순서없이 저장합니다. 각각의 값은 유일한 _키 (key)_ 와 관련지어지며, 이 키는 딕셔너리에서 그 값에 대한 식별자 (identifier) 역할을 합니다. 배열에 있는 항목과는 달리, 딕셔너리에 있는 항목에는 지정된 순서가 없습니다. 딕셔너리는 식별자를 기반으로 하여 값을 찾을 때 쓸 수 있는데, 이는 실제-세계의 사전 (딕셔너리) 이 특정 단어로 정의된 뜻을 찾는 것과 사실상 같은 것입니다.

> 스위프트의 `Dictionary` 타입은 'Foundation' 프레임웍에 있는 `NSDictionary` 클래스와 연동되어 (bridged) 있습니다.
>
> 'Foundation' 및 'Cocoa' 프레임웍과 `Dictionary` 를 같이 사용하는 방법에 대해서는 [Bridging Between Dictionary and NSDictionary](https://developer.apple.com/documentation/swift/dictionary#2846239) 에서 더 자세히 알 수 있습니다.

### Dictionary Type Shorthand Syntax (딕셔너리 타입 약칭 구문 표현)

스위프트의 딕셔너리 타입을 온전하게 작성하는 방법은 `Dictionary<Key, Value>` 이며, 여기서 `Key` 는 딕셔너리에서 키로 사용되는 값의 타입이고, `Value` 이 키로 딕셔너리에 저장되는 값의 타입입니다.

> '딕셔너리' 의 `Key` 타입은 '셋' 의 값 타입처럼 반드시 `Hashable` 프로토콜을 준수해야 합니다.

또한 딕셔너리 타입은 약칭으로 `[Key : Value]` 와 같은 형태로 작성할 수도 있습니다. 두 양식의 기능은 동일하지만 약칭 형태를 권장하며, 이 책에서도 딕셔너리 타입은 약칭 형태로 참조하도록 합니다.

### Creating an Empty Dictionary (빈 딕셔너리 생성하기)

빈 `Dictionary` 를 만들려면 배열 처럼 '초기자 문법 (initializer syntax)' 을 사용합니다:

```swift
var namesOfIntegers = [Int: String]()
// namesOfIntegers 는 [Int: String] 타입의 빈 딕셔너리입니다.
```

아래 예제는 `[Int: String]` 타입의 빈 딕셔너리를 생성해서 사람이 읽을 수 있는 정수의 이름을 저장합니다. 키는 `Int` 타입이고, 값은 `String` 타입입니다.

영역 내에서 이미 타입 정보를 제공하는 경우, 빈 딕셔너리는 '빈 딕셔너리 글자 값 (empty dictionary literal)' 으로 생성할 수도 있는데, 이는 `[:]` 처럼 (대괄호 쌍 안에 콜론) 을 써 주면 됩니다:

```swift
namesOfIntegers[16] = "sixteen"
// namesOfIntegers 는 이제 1 개의 키-값 쌍을 갖고 있습니다.
namesOfIntegers = [:]
// namesOfIntegers 는 다시 빈 딕셔너리가 됐으며 타입은 [Int: String] 입니다.
```

### Creating a Dictionary with a Dictionary Literal (딕셔너리 글자 값을 사용하여 딕셔너리 생성하기)

_딕셔너리 글자 값 (dictionary literal)_ 을 써서 딕셔너리를 초기화할 수도 있는데, 이는 앞서 본 '배열 글자 값' 과 문법이 비슷합니다. 딕셔너리 글자 값은 하나 이상의 키-값 쌍을 가진 `Dictionary` 컬렉션을 약칭 (shorthand) 으로 만들 수 있는 방법입니다.

_키-값 쌍 (key-value pair)_ 은 키와 값의 조합입니다. 딕셔너리 글자 값의 각 '키-값 쌍' 에 있는 키와 값은 콜론으로 구분됩니다. '키-값 쌍들'[^key-value-pairs] 을 작성하려면 값을 나열하면서, 쉼표로 나누고, 대괄호 쌍으로 감싸면 됩니다:

[`key 1`: `value 1`, `key 2`: `value 2`, `key 3`: `value 3`]

아래 예제는 국제 공항의 이름을 저장하는 딕셔너리를 생성합니다. 이 딕셔너리에서, 키는 3-글자로 된 국제 항공운송협회 코드이며, 값은 공항의 이름입니다:

```swift
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
```

`airport` 딕셔너리는 `[String: String]` 타입으로 선언되었는데, 이는 "키가 `String` 타입이고 값이 `String` 타입인 `Dictionary`" 임을 의미합니다.

> `airport` 딕셔너리는 (`var` 소개자를 쓰는) 변수로 선언되었지 (`let` 소개자를 쓰는) 상수로 선언된 것이 아닙니다. 이는 아래 예제에서 이 딕셔너리에 더 많은 공항을 추가할 것이기 때문입니다.

`airport` 딕셔너리는 두 개의 키-값 쌍을 가지는 '딕셔너리 글자 값' 으로 초기화되었습니다. 첫 번째 쌍의 키는 `"YYZ"` 이고, 값은 `"Toronto Pearson"` 입니다. 두 번째 쌍은 키가 `"DUB"` 이고, 값은 `"Dublin"` 입니다.

이 '딕셔너리 글자 값' 은 두 개의 `String: String` 쌍을 가지고 있습니다. 이 키-값 타입은 `airport` 변수 선언의 타입 (오직 `String` 키와, `String` 값만을 가지는 딕셔너리) 에서와 일치하므로, 두 개의 초기 항목들로 `airports` 딕셔너리를 초기화하기 위해 '딕셔너리 글자 값' 을 할당하는 것도 가능합니다.

배열에서 처럼, 딕셔너리도 초기화할 때 타입을 안써도 되는 경우가 있으며, 이는 딕셔너리 글자 값에 있는 키와 값들의 타입이 일관성이 있는 경우입니다. `airport` 의 초기화는 아래 처럼 더 짧게 작성할 수 있습니다:

```swift
var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
```

'글자 값 (literals)' 에 있는 모든 키들이 서로 같은 타입이면서 모든 값들도 같은 타입이므로, 스위프트는 `airport` 딕셔너리의 타입이 정확하게 `[String: String]` 타입임을 추론할 수 있습니다.

### Accessing and Modifying a Dictionary (딕셔너리에 접근하고 수정하기)

메소드와 속성을 통해, 아니면 '첨자 연산 구문 표현' 을 사용하여, 딕셔너리에 접근하고 수정합니다.

배열에서와 같이, `Dictionary` 에 있는 항목의 개수를 알아내려면 읽기-전용 속성인 `count` 를 검사합니다:

```swift
print("The airports dictionary contains \(airports.count) items.")
// "The airports_2 dictionary contains 2 items." 를 출력합니다.
```

불리언 (Boolean) 속성인 `isEmpty` 를 사용하면, `count` 속성이 `0` 과 같은 지를 더 간단하게 검사할 수 있습니다[^isEmpty-count]:

```swift
if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}
// "The airports dictionary is not empty." 를 출력합니다.
```

'첨자 연산 구문 표현' 으로 딕셔너리에 새 항목을 추가할 수 있습니다. 알맞은 타입의 새 키를 첨자 연산 색인으로 사용하고, 알맞은 타입의 새 값을 할당하면 됩니다:  

```swift
airports["LHR"] = "London"
// airports 딕셔너리는 이제 3 개의 항목을 가집니다.
```

'첨자 연산 구문 표현' 을 사용하여 특정한 키와 결합되어 있는 값을 바꿀 수도 있습니다:

```swift
airports["LHR"] = "London Heathrow"
// "LHR" 에 해당하는 값이 "London Heathrow" 로 바뀌었습니다.
```

첨자 연산의 대안으로, 딕셔너리에 있는 `updateValue(_:forKey:)` 메소드를 사용하여 특정 키에 대한 값을 설정하고 업데이트하도록 합니다. 위의 첨자 연산 예제와 같이, `updateValue(_:forKey:)` 메소드는 해당 키가 존재하지 않으면 키의 값을 설정하고, 키가 이미 존재하면 값을 업데이트합니다. 하지만 첨자 연산과는 달리, `updateValue(_:forKey:)` 메소드는 업데이트를 수행한 다음 _예전 (old)_ 값을 반환합니다. 이것으로 업데이트가 실제로 일어났는지를 검사할 수 있습니다.

`updateValue(_:forKey:)` 메소드는 딕셔너리 값 타입에 대한 옵셔널 값 (optional value)[^optional-value] 을 반환합니다. 예를 들어, `String` 값을 저장하는 딕셔너리의 경우, 이 메소드는 ("옵셔널 `String`" 이라고 하는) `String?` 타입의 값을 반환합니다. 이 옵셔널 값은 업데이트 이전에 값이 있었으면 해당 키에 대한 예전 값을 가지고, 없었으면 `nil` 을 가집니다:

```swift
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
// "The old value for DUB was Dublin." 를 출력합니다.
```

첨자 연산 문법을 사용하여 딕셔너리에서 특정 키에 대한 값을 가져올 수도 있습니다. 요청한 키에 대해서 값이 없을 수도 있으므로, 딕셔너리의 첨자 연산은 딕셔너리의 값 타입에 대한 옵셔널 값을 반환합니다. 딕셔너리가 요청한 키에 대한 값을 가지고 있는 경우, 첨자 연산은 그 키에 대한 값을 담고 있는 옵셔널 값을 반환합니다. 그렇지 않는 경우, 첨자 연산은 `nil` 을 반환합니다:

```swift
if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}
// "The name of the airport is Dublin Airport." 를 출력합니다.
```

첨자 연산 문법을 사용하여 키에 대한 값으로 `nil` 을 할당하면 딕셔너리에서 '키-값 쌍' 을 제거할 수 있습니다:

```swift
airports["APL"] = "Apple International"
// APL 및 "Apple International" 은 실제 공항이 아닙니다, 이제 지워봅시다.
airports["APL"] = nil
// APL 이 방금 딕셔너리에서 지워졌습니다.
```

다른 방법으로, 딕셔너리에서 키-값 쌍을 제거하려면 `removeValue(_:forKey)` 메소드를 사용합니다. 이 메소드는 해당 키-값 쌍이 있으면 제거하고나서 제거한 그 값을 반환하고, 없으면 `nil` 을 반환합니다:

```swift
if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}
// "The removed airport's name is Dublin Airport." 를 출력합니다.
```

### Iterating Over a Dictionary (딕셔너리에 동작을 반복 적용하기)

`for`-`in` 반복문을 사용하면 딕셔너리에 있는 전체 키-값 쌍들에 '동작을 반복 (iterate over)' 시킬 수 있습니다. 딕셔너리의 각 항목은 `(key, value)` 튜플의 형태로 반환되며, 튜플의 멤버는 동작 반복 과정에서 임시 상수 또는 임시 변수로 분해할 수 있습니다:

```swift
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

// YYZ: Toronto Pearson
// LHR: London Heathrow               
```

`for`-`in` 반복문에 대한 더 자세한 내용은, [For-In Loops (For-In 반복문)]({% post_url 2020-06-10-Control-Flow %}#for-in-loops-for-in-반복문) 을 참고하기 바랍니다.

딕셔너리의 키와 값들에 대해서 '동작을 반복 적용할 수 있는 컬렉션 (iterable collection)' 을 가질 수도 있는데, 이는 딕셔너리의 `keys` 와 `properties` 속성을 사용하면 됩니다:

```swift
for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
// Airport code: YYZ
// Airport code: LHR

for airportName in airports.values {
    print("Airport name: \(airportName)")
}
// Airport name: Toronto Pearson
// Airport name: London Heathrow
```

딕셔너리의 키와 값을 `Array` 인스턴스를 요구하는 API 에 전달하려면, `keys` 와 `properties` 속성으로 새 배열을 초기화하면 됩니다:

```swift
let airportCodes = [String](airports.keys)
// airportCodes 는 ["YYZ", "LHR"] 가 됩니다.

let airportNames = [String](airports.values)
// airportNames 은 ["Toronto Pearson", "London Heathrow"] 가 됩니다.
```

스위프트의 `Dictionary` 타입에는 따로 정의된 순서가 없습니다. 딕셔너리의 키와 값에 동작을 반복 적용할 때 특정 순서를 따르게 하고 싶으면, `sort()` 를 `keys` 와 `values` 속성에 사용하면 됩니다.

### 참고 자료

[^Collection-Types]: 원문은 [Collection Types](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^collections]: 'collection' 은 '집합', '묶음' 등의 말로 옮길 수 있는데, 여기서는 보통의 경우 '컬렉션' 이라고 발음대로 사용하다가, 필요한 경우는 의미를 살려서 '집합체' 라는 말을 사용합니다. 이는 'class' 를 '객체', 'structure' 를 '구조체', 'enumeration' 을 '열거체' 라고 하는 것과의 통일성을 유지하기 위한 것입니다. 모두다 하나의 '타입' 이 될 수 있는 것들입니다.

[^sets]: 'Sets' 은 수학 용어로는 그 자체로 '집합' 이라는 뜻을 가지고 있는데, '집합' 이라고 하면 프로그래밍에서 다른 의미로 해석될 수도 있으므로, 여기서는 스위프트의 자료 타입을 의미하도록 '셋' 이라고 발음 그대로 옮기도록 합니다.

[^dictionaries]: 'dictionaries' 는 '사전' 으로 옮길 수 있는데, 타입의 항목이 실제 사전처럼 '키' 와 '값' 의 두 가지 성분으로 되어있습니다. 다만 '사전' 이라고 옮기면 다른 의미로 해석될 수도 있으므로, 여기서는 스위프트의 자료 타입을 의미하도록 '딕셔너리' 라고 발음 그대로 옮기도록 합니다.

[^compatible]: 'compatible' 은 컴퓨터 용어에서 '호환성이 있는' 것을 말하며, 이는 서로 같이 사용하거나 교체가 가능한 것을 말합니다. 예를 들어, 스위프트에서 `Float` 과 `Double` 타입은 서로 '호환성이 있는' 데, 이로써 두 값은 서로 같이 연산할 수 있습니다. 그리고 이 때의 연산 결과는 `Double` 타입이 됩니다. 사실 스위프트에서는 특별한 경우가 아니면 `Float` 타입을 따로 쓸 필요가 없긴 합니다.

[^literal]: 'literal' (글자 값) 은 '실제 글자로 표현된 값' 을 의미합니다. 예를 들어 `let a = 10` 이라고 하면 여기서 `10` 은 ASCII 코드로 된 문자 `1` 과 `0` 의 조합이지만 '실제 글자로 표현된 값' 은 정수 `10` 을 의미하므로, `a` 는 `Int` 타입으로 추론됩니다.

[^isEmpty-count]: 실제로 스위프트에서는 배열에 값이 있는지 없는지를 검사할 때는 `isEmpty` 를 사용할 것을 권장합니다. `count` 는 값의 개수가 몇 개인지를 알고 싶을 때 사용하는 것입니다. 즉, 단순히 편리하기 때문에만 `isEmpty` 를 사용하는 것은 아닙니다. 이에 대한 이유는 [isEmpty vs. count == 0](https://medium.com/better-programming/strings-comparison-isempty-vs-count-0-be80d701901b) 이라는 글을 읽어보길 바랍니다.

[^count-concurrent]: `shippingList.count` 는 현재 배열에 있는 전체 항목의 개수를 나타내는데, 이 값으로 새 항목을 추가하면 그 행위 자체가 다시 `count` 값을 바꾸게 됩니다. 즉 `count` 라는 변수에 값을 읽는 행위와 값을 쓰는 행위를 동시에 하려는 문제가 발생합니다.

[^iterate-over]: 'iterate over' 는 그냥 '반복하다' 만으로는 의미가 정확한 것 같지 않아서 '동작을 반복 적용하기' 라는 말로 옮깁니다.

[^enumerate]: 'enumerate' 에는 '열거하다, 헤아리다' 라는 의미가 있으며, 스위프트에서 'enumeration (열거체)' 는 하나의 타입이기도 합니다.

[^tuple]: 'tuple' 은 '두 개로 짝을 이룬 것' 을 나타내는 데, 스위프트의 타입 중 하나를 나타내기 위해 '튜플' 이라는 발음 그대로 사용하기로 합니다.

[^hashable]: 'hash' 는 '고기와 감자를 잘게 다져서 마구잡이로 섞어놓은 음식' 에서 유래한 말로 '많은 것들이 마구잡이로 뒤섞인 것' 을 말합니다. 'hashable' 은 이렇게 'hash 를 만들 수 있는' 이라는 의미를 가진 단어입니다. 이것을 컴퓨터 용어로 이해하면 타입이 'hashable' 이라는 말은 '많은 양의 정보를 잘게 쪼개서 마구 뒤섞어 놓은 형태로 저장할 수 있는' 기능을 가지고 있다는 의미가 됩니다. 용어 자체는 맞는 말이 없으므로 '해쉬' 라고 발음 그대로 사용하도록 합니다.

[^hash-value]: 'hash value' 란 앞서 'hashable' 에서 살펴본 바와 같이, '잘게 쪼개지고 뒤섞일 수 있게 재가공된 값' 정도로 이해할 수 있을 것 같습니다.

[^enumeration]: 'enumeration' 은 '열거체' 라는 말로 옮깁니다. 이는 'class' 를 '객체', 'structure' 를 '구조체' 라고 하는 것과 맞추기 위함입니다.

[^equtable]: 'equtable' 은 '서로 같은 지를 비교할 수 있는' 지를 의미합니다.

[^reflexivity]: 여기서 말하는 '반사성' 은 수학에서 말하는 '반사 관계' 를 말하는 것 같습니다. '반사 관계' 에 대해서는 위키피디아의 [Reflexive relation](https://en.wikipedia.org/wiki/Reflexive_relation) 문서를 참고하기 바랍니다.

[^symmetry]: 여기서 말하는 '대칭성' 은 수학에서 말하는 '대칭 관계' 를 말하는 것 같습니다. '대칭 관계' 에 대해서는 위키피디아의 [Symmetric relation](https://en.wikipedia.org/wiki/Symmetric_relation) 문서를 참고하기 바랍니다.

[^transitivity]: 여기서 말하는 '추이성' 은 수학에서 말하는 '추이 관계' 를 말하는 것 같습니다. '추이 관계' 에 대해서는 위키피디아의 [Transitive relation](https://en.wikipedia.org/wiki/Transitive_relation) 문서를 참고하기 바랍니다.

[^set-array-literal]: 이것은 '배열 글자 값 (array literal)' 만 사용할 경우, `Array` 로 추론되기 때문일 것입니다.

[^set-operations]: '셋' 은 실제로 수학에서 '집합' 을 가리키는 용어인데, 스위프트의 '셋' 타입은 배열이나 딕셔너리보다 좀 더 수학적인 연산에 사용하는 타입이라 이해할 수 있습니다. 따라서 여기서의 'set operations' 은 '집합 연산'의 의미로 이해하는 것이 맞을 것 같습니다.

[^disjoint]: 이를 수학 용어로는 '분리 집합 (disjoint sets)' 이라고 하는 것 같습니다. 분리 집합에 대해서는 위키피디아의 [Disjoint sets](https://en.wikipedia.org/wiki/Disjoint_sets)문서를 참고하기 바랍니다. 한글로는 '[서로 소 집합](https://ko.wikipedia.org/wiki/서로소_집합)' 이라는 용어가 있는데, 프로그래밍 분야에서는 '분리 집합' 이라는 표현도 같이 사용하고 있는 듯 합니다.

[^key-value-pair]: 여러 개의 '키-값 쌍 (key-value pair)' 을 묶은 '키-값 쌍들 (key-value pairs)' 자체가 하나의 '딕셔너리 글자 값 (dictionary literal)' 이라고 할 수 있습니다.

[^optional-value]: 'optional value' 는 '선택적 값' 이라고도 옮길 수 있겠지만, 여기서는 스위프트의 타입임을 드러내기 위해서 발음을 따라서 '옵셔널 값' 으로 옮깁니다.
