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
> 'Foundation' 및 'Cocoa' 프레임웍과 `Array` 를 같이 사용하는 방법에 대해서는 [Bridging Between Array and NSArray](https://developer.apple.com/documentation/swift/array#2846730) 에서 더 자세히 알 수 있습니다.

#### Array Type Shorthand Syntax (배열 타입 약칭 문법)

스위프트의 배열 타입을 온전하게 작성하는 방법은 `Array<Element>` 이며, 여기서 `Element` 는 배열에 저장하는 값의 타입입니다. 또한 배열 타입은 약칭으로 `[Element]` 와 같은 형태로 작성할 수도 있습니다. 두 양식의 기능은 동일하지만, 약칭 형태를 권장하며 이 책의 전체에서도 배열 타입은 약칭 형태로 사용하도록 합니다.

#### Creating an Empty Array (빈 배열 생성하기)

특정 타입의 빈 배열을 생성하려면 초기자 문법을 사용합니다:

```swift
var someInts = [Int]()
print(("someInts is of type [Int] with \(someInts.count) items.")
// "someInts is of type [Int] with 0 items." 를 출력합니다.
```

`someInts` 변수의 타입은 초기자의 타입으로부터 `[Int]` 로 추론할 수 있음을 기억하기 바랍니다.

다른 방법으로, 영역 내에서 이미 타입 정보를 제공하는 경우, 예를 들면 함수 인자에서나 이미 타입이 알려진 변수 또는 상수일 경우에, '빈 배열 문자표현 (empty array literal)' 을 써서 빈 배을을 생성할 수도 있으며, 이 때는 `[]` (빈 대괄호 쌍) 만 써주면 됩니다:

```swift
someInts.append(3)
// someInts 는 이제 Int 타입 값 1 개를 갖습니다.
someInts = []
// someInts 는 이제 빈 배열이 됐지만, 타입은 여전히 [Int] 입니다.
```

#### Creating an Array with a Default Value (기본 값을 가진 배열 생성하기)

스위프트의 `Array` 타입에는 특정 크기의 배열을 생성하면서 모든 값을 동일한 기본 값으로 설정할 수 있는 초기자도 있습니다. 이 초기자에 적절한 타입의 기본 값 (명칭은 `repeating`): 과 이 값이 배열에서 반복되야할 횟수 (명칭은 `count`): 를 전달하면 됩니다:

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

#### Creating an Array with an Array Literal ('배열 문자표현' 을 사용해서 배열 생성하기)

_배열 문자표현 (array literal)_[^literal] 을 써서 배열을 초기화 할 수도 있는데, 이는 하나 이상의 값을 가진 배열 집합체 (array collection) 를 약칭 (shorthand) 으로 만들 수 있는 방법입니다. '배열 문자표현' 을 작성하려면 값을 나열하면서, 쉼표로 나누고, 대괄호 쌍으로 감싸면 됩니다.

[`value 1`, `value 2`, `value 3`]

아래 예제는 `shoppingList` 라는 배열을 만들어 `String` 값을 저장하고 있습니다:

```swift
var shoppingList: [String] = ["Eggs", "Milk"]
// shoppingList 가 두 초기 요소로 초기화 되었습니다.
```

`shoppingList` 변수는 `[String]` 을 써서 "문자열 값의 배열" 로 선언했습니다. 이 배열은 `String` 타입의 값만 갖도록 지정됐으므로, 이제 `String` 값만 저장할 수 있습니다. 여기서, `shoppingList` 배열은 '배열 문자표현 (array literal)' 에 있는 두 개의 `String` 값인 (`"Eggs"` 와 `"Milk"`) 로 초기화 되었습니다.

> `shoppingList` 배열은 (`var` 소개자를 쓰는) 변수로 선언되었지 (`let` 소개자를 쓰는) 상수로 선언된 것이 아닙니다. 이는 아래 예제에서 이 `shoppingList` 에 더 많은 요소를 추가할 것이기 때문입니다.

이 경우, '배열 문자표현 (array literal)' 에는 두 개의 `String` 값만 있지 다른 건 전혀 없습니다. 이는 `shoppingList` 변수를 선언할 때의 타입 (`String` 값만 담을 수 있는 배열) 과 들어 맞으므로, '배열 문자표현' 을 할당하는 것이 허용되어 두 개의 초기 요소로 `shoppingList` 를 초기화할 수 있습니다.

스위프트의 타입 추론 덕분에, 배열의 타입을 안써도 되는 경우가 있는데, 초기화할 때 '배열 문자표현' 이 같은 타입의 값만 가지고 있으면 그렇습니다. 따라서 `shoppingList` 의 초기화는 앞에서보다 더 짧은 형태로도 작성할 수 있습니다:

```swift
var shoppingList = ["Eggs", "Milk"]
```

'배열 문자표현' 의 모든 값이 같은 타입이므로, 스위프트는 `shoppingList` 변수가 정확하게 `[String]` 타입임을 추론할 수 있습니다.

#### Accessing and Modifying an Array (배열에 접근하고 수정하기)

배열은 메소드 (methods) 와 속성 (properties), 또는 '첨자 연산 문법 (subscript syntax)' 을 사용하여 접근하고 수정할 수 있습니다.

배열에 있는 요소의 개수를 알고 싶으면, 일기-전용 속성인 `count` 를 검사하면 됩니다:

```swift
print("The shopping list contains \(shoppingList.count) items.")
// "The shopping list contains 2 items." 를 출력합니다.
```

'불린 (Boolean)' 속성인 `inEmpty` 를 사용하면 `count` 속성이 `0` 과 같은 지를 검사하는 것보다 간단합니다[^isEmpty-count]:

```swift
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}
// "The shopping list is not empty." 를 출력합니다.
```

배열에 있는 `append(_:)` 메소드를 호출하여 배열의 끝에 새로운 요소를 추가할 수 있습니다:

```swift
shoppingList.append("Flour")
// shoppingList 는 이제 3 개의 요소를 가지며, 누군가 팬케이크를 만들 수 있게 됐습니다.
```

다른 방법으로, 배열에 '더하기 할당 연산자 (addition assignment operator)' (`+=`) 를 사용하여 하나 이상의 호환성 있는 요소를 덧붙일 수 있습니다:

```swift
shoppingList += ["Baking Powder"]
// shoppingList 는 이제 4 개의 요소를 가집니다.
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
// shoppingList 는 이제 7 개의 요소를 가집니다.
```

배열에서 값을 가져오려면 _첨자 연산 문법 (subscript syntax)_ 을 사용하며, 이는 배열 이름 바로 뒤의 대괄호 안에 가져올 값의 _색인 (index)_ 을 넣으면 됩니다:

```swift
var firstItem = shoppingList[0]
// firstItem 은 "Eggs" 가 됩니다.
```

> 배열의 첫 번째 요소는 색인으로 `0` 을 갖습니다. `1` 이 아닙니다. 스위프트에 있는 배열은 항상 '영-기준 색인 (zero-indexed)' 입니다.

'첨자 연산 문법 (subscript syntax)' 을 사용하면 주어진 색인 위치의 값을 바꿀 수 있습니다:

```swift
shoppingList[0] = "Six eggs"
// 이제 목록에 있는 첫 번째 요소는 단순히 "Eggs" 가 아니라 "Six eggs" 입니다.
```

첨자 연산 문법을 사용할 때는, 지정한 인덱스가 유효해야만 합니다. 예를 들어, 배열 끝에 요소를 추가한답시고 `shoppingList[shoppingList.count] = "Salt"` 라고 하면 '실행 시간에 에러 (runtime error)' 가 발생합니다.[^count-concurrent]

첨자 연산 문법을 사용해서 일정 범위의 값들을 한 번에 바꿀 수도 있는데, 이 때 대체될 값들의 범위와 대체할 범위의 길이가 달라도 문제 없습니다. 다음 예제는 `"Chocolate Spread"`, `"Cheese"`, 그리고 `"Butter"` 를 `"Bananas"` 와 `"Apples"` 로 바꾸는 것을 보여줍니다:

```swift
shoppingList[4...6] = ["Bananas", "Apples"]
// shoppingList 는 이제 6 개의 요소를 가집니다.
```

배열에 요소를 넣을 때 특정 색인 위치에 넣고 싶으면, 배열의 `insert(_:at:)` 메소드를 호출하면 됩니다:

```swift
shoppingList.insert("Maple Syrup", at: 0)
// shoppingList 는 이제 7 개의 요소를 가집니다.
// "Maple Syrup" 이 이제 목록의 첫 번째 요소입니다.
```

여기서는 `insert(_:at:)` 메소드를 호출하여 `"Maple Syrup"` 이라는 새 요소를 '쇼핑 목록 (shopping list)' 의 맨 처음 위치-색인 `0` 으로 지시한 곳-에 집어 넣었습니다.

비슷하게, 배열에 요소를 제거하려면 `remove(at:)` 메소드를 사용합니다. 이 메소드는 특정 색인 위치의 요소를 제거한 후 이 제거한 요소를 반환합니다. (반환 값이 필요 없다면 무시해도 됩니다):

```swift
let mapleSyrup = shoppingList.remove(at: 0)
// 색인 0 위치의 값이 방금 제거되었습니다.
// shoppingList 는 이제 6 개의 요소를 가지며, Maple Syrup 은 더이상 없습니다.
// 이제 상수 mapleSyrup 은 제거된 문자열인 "Maple Syrup" 이 됩니다.
```

> 배열 범위를 벗어난 색인으로 값에 접근하려고 하거나 수정하려고 하면 '실행 시간에 에러 (runtime error)' 가 발생합니다. 색인을 사용하기 전에 유효한 지를 검사하고 싶으면 배열의 `count` 속성과 비교하면 됩니다. 배열에서 유효한 색인으로 가장 큰 것은 `count - 1` 인데, 배열의 '색인은 영-기준 (indexed from zero)' 이기 때문입니다 - 하지만, `count` 가 `0` (즉 배열이 비어있으면) 이면, 유효한 색인이 아예 없습니다.

배열에 요소를 제거할 때 발생하는 틈은 모조리 메꿔지므로, 색인 `0` 에 있는 값은 이제 다시 `"Six eggs"` 와 같아집니다:

```swift
firstItem = shoppingList[0]
// firstItem 은 다시 "Six eggs" 입니다.
```

배열에서 마지막 요소를 제거하려면, `remove(at:)` 메소드 대신 `removeLast()` 메소드를 사용하는 것이 좋은데, 이는 배열의 `count` 속성을 조회할 필요가 없기 때문입니다. `remove(at:)` 메소드 처럼, `removeLast()` 메소드도 제거된 요소를 반환합니다:

```swift
let apples = shoppingList.removeLast()
// 배열의 마지막 요소가 바금 제거되었습니다.
// shoppingList 는 이제 5 개의 요소를 가지며, Apples 은 더이상 없습니다.
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

각 요소에 대해 값 뿐만 아니라 정수 색인도 필요하다면, 배열에 동작을 반복 적용시킬 때 `enumerated()`[^enumerate] 메소드도 같이 사용하면 됩니다. `enumerated()` 메소드는 배열의 각 요소에 대해서 정수와 요소의 조합으로 된 '튜플 (tuple)'[^tuple] 을 반환합니다. 이 정수는 0 에서 시작해서 각 요소마다 하나씩 증가합니다; 배열 전체를 열거하게 되면, 이 정수들은 결국 요소들의 색인이 됩니다. 반복 적용하는 구문 내에서 '튜플' 을 임시 상수나 변수로 분해 (decompose) 할 수 있습니다:

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

`for-in` 반복문에 대한 더 자세한 정보는 [For-In Loop]() 를 보기 바랍니다.

## Sets (셋)

_셋 (set)_ 은 같은 타입이지만 서로 다른 값들을 순서는 따로 정의하지 않은채 컬렉션에 저장합니다. 배열 대신 셋을 사용할 때는, 요소의 순서가 중요하지 않거나, 요소가 단 한 번만 나타나도록 해야할 경우 등이 있습니다.


> 스위프트의 `Set` 타입은 'Foundation' 프레임웍에 있는 `NSSet` 클래스와 연동되어 (bridged) 있습니다.
>
> 'Foundation' 및 'Cocoa' 프레임웍과 `Set` 을 같이 사용하는 방법에 대해서는 [Bridging Between Set and NSSet](https://developer.apple.com/documentation/swift/set#2845530) 에서 더 자세히 알 수 있습니다.

### Hash Values for Set Types (셋 타입의 해쉬 값)

셋에 저장하는 타입은 반드시 _해쉬 가능 (hashable)_[^hashable] 해야 합니다 - 이것은, 이 타입은 반드시 자체적으로 _해쉬 값 (hash value)_[^hash-value] 을 계산할 수 있어야 한다는 말입니다. 여기서 해시 값이란, 하나의 `Int` 값으로서, 비교했을 때 같다고 판단되는 객체들은 모두 같아야 하는 값을 말하는 것으로, 가령 `a == b` 인 경우, 이는 필연적으로 `a.hashValue == b.hashValue` 이라는 말이 됩니다.

스위프트의 모든 기본 타입 (가령 `String`, `Int`, `Double` 그리고 `Bool`) 은 기본적으로 해시 가능하므로, '셋 (set)' 의 값 타입과 '딕셔너리 (dictionary)' 의 키 (key) 타입으로 사용할 수 있습니다. 관련된 값 (associated values) 이 없는 열거체[^enumeration]의 경우 값 (enumeration case value; [Enumerations]() 에 설명되어 있습니다) 역시 기본적으로 해시 가능합니다.

> 자신이 만든 타입을 셋의 값 타입이나 딕셔너리의 키 타입으로 사용하고 싶으면, 스위프트 표준 라이브러리에 있는 `Hashable` 프로토콜을 준수하도록 하면 됩니다. `Hashable` 프로토콜을 준수하는 타입은 반드시 `hashValue` 라는 읽을 수 있는 (gettable) `Int` 속성을 제공해야 합니다. 같은 프로그램을 다른 시점에 실행할 때나 다른 프로그램을 실행할 때, 이 타입의 `hashValue` 속성이 반환하는 값을 같도록 만들 필요는 없습니다.
>
> `HashValue` 프로토콜은 `Equatable`[^equtable] 을 준수하므로, ('Hashable' 을) '준수하는 타입 (conforming types)' 은 반드시 '같음 연산자 (`==`)' 도 구현해야 합니다. `Equatable` 프로토콜은 '같은 값을 가진 관계 (equivalent relation)' 임을 알기 위해서 어떤 형태로든 `==` 의 구현이 필요하기 때문입니다. 좀 더 정확하게 말하면, 모든 `a`, `b`, `c` 값에서, `==` 의 구현은  다음의 세 가지를 반드시 만족해야 합니다:
>
> * `a == a` (Reflexivity; 반사성[^reflexivity])
> * `a == b` 는 곧 `b == a` (Symmetry; 대칭성[^symmetry])
> * `a == b && b == c` 는 곧 `a == c` (Transitivity; 추이성[^transitivity])
>
> 프로토콜 준수에 대한 더 자세한 내용은 [Protocols](http://xho95.github.io/swift/language/grammar/protocol/2016/03/03/Protocols.html) 을 보도록 합니다.

### Set Type Syntax (셋 타입 문법)

스위프트의 '셋' 타입은 `Set<Element>` 라고 작성하며, 여기서 `Element` 는 셋에 저장할 수 있는 타입을 말합니다. '배열' 과 달리, '셋' 은 약칭으로 쓸 수 있는 형태가 없습니다.

### Creating and Initializing an Empty Set (빈 셋 생성하고 초기화하기)

특정 타입의 빈 '셋' 을 만들려면 초기자 문법을 사용하면 됩니다:

```swift
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
// "letters is of type Set<Character> with 0 items." 을 출력합니다.
```

> `letters` 변수의 타입은 초기자의 타입에 의해 `Set<Character>` 로 추론됩니다.

다른 방법으로는, 영역 내에서 타입 정보를 제공하는 경우, 가령 함수 인자이거나 이미 타입이 알려진 변수 또는 상수인 경우, 빈 배열은 '빈 배열 문자표현' 을 써서 생성할 수 있습니다:


```swift
letters.insert("a")
// letters 는 이제 Character 타입 값 1 개를 갖고 있습니다.
letters = []
// letters 는 이제 빈 셋이 됐지만, 타입은 여전히 Set<Character> 입니다.
```

### Creating a Set with an Array Literal (배열 문자표현을 써서 셋 생성하기)

'배열 문자표현' 으로 '셋' 을 초기화할 수도 있는데, 이는 '셋 컬렉션 (set collection)' 에 하나 이상의 값을 할당하는 '약칭법 (shorthand way)' 입니다.

아래 예제는 `favoriteGenres` 라는 셋을 만든 후 `String` 값을 저장하는 방법을 보여줍니다:

```swift
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip Hop"]
// favoriteGenres 는 3 개의 초기 요소를 가지고 초기화 되었습니다.
```

`favoriteGenres` 변수는 `Set<String>` 을 써서 "`String` 값의 셋” 으로 선언되었습니다. 이 셋은 `String` 타입의 값을 지정했기 때문에, `String` 값만 저장할 수 있습니다. 여기서 `favoriteGenres` 셋은 '배열 문자표현' 에 있는 세 개의 `String` 값인 (`"Rock"`, `"Classical"`, 그리고 `"Hip hop"`) 으로 초기화 됩니다.

> `favoriteGenres` 셋은 (`var` 소개자를 써서) 변수로 선언되었으며, (`let` 소개자를 쓴) 상수가 아닙니다. 이는 아래 예제에서 요소를 추가하거나 제거할 것이기 때문입니다.

셋 타입은 '배열 문자표현 (array literal)' 만으로는 추론할 수 없으므로[^set-array-literal], `Set` 이라는 타입은 반드시 명시적으로 선언해야 합니다. 그러나 스위프트의 타입 추론 기능에 의해서, '배열 문자표현' 이 하나의 타입만 갖고 있는 경우, 셋 요소 (set's elements) 의 타입은 쓸 필요가 없습니다. 따라서 `favoriteGenres` 의 초기화는 다음 처럼 더 짧은 양식으로 작성 할 수 있습니다:

```swift
var favoriteGenres: Set = ["Rock", "Classical", "Hip Hop"]
```

'배열 문자표현' 에 있는 모든 값들이 같은 타입이므로, 스위프트는 `favoriteGenres` 변수가 `Set<String>` 임을 올바르게 추론할 수 있습니다.

### Accessing and Modifying a Set (셋에 접근하고 수정하기)

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

[^sets]: 'Sets' 은 수학 용어로는 그 자체로 '집합' 이라는 뜻을 가지고 있는데, '집합' 이라고 하면 프로그래밍에서 다른 의미로 해석될 수도 있으므로, 여기서는 스위프트의 자료 타입을 의미하도록 '셋' 이라고 발음 그대로 옮기도록 합니다.

[^dictionaries]: 'dictionaries' 는 '사전' 으로 옮길 수 있는데, 타입의 요소가 실제 사전처럼 '키' 와 '값' 의 두 가지 성분으로 되어있습니다. 다만 '사전' 이라고 옮기면 다른 의미로 해석될 수도 있으므로, 여기서는 스위프트의 자료 타입을 의미하도록 '딕셔너리' 라고 발음 그대로 옮기도록 합니다.

[^compatible]: 'compatible' 은 컴퓨터 용어에서 '호환성이 있는' 것을 말하며, 이는 서로 같이 사용하거나 교체가 가능한 것을 말합니다. 예를 들어, 스위프트에서 `Float` 과 `Double` 타입은 서로 '호환성이 있는' 데, 이로써 두 값은 서로 같이 연산할 수 있습니다. 그리고 이 때의 연산 결과는 `Double` 타입이 됩니다. 사실 스위프트에서는 특별한 경우가 아니면 `Float` 타입을 따로 쓸 필요가 없긴 합니다.

[^literal]: 'literal' (리터럴) 은 '문자로 표현된 실제 의미' 를 뜻합니다. 예를 들어 `let a = 10` 이라고 하면 여기서 `10` 은 ASCII 코드로 된 문자 `1` 과 `0` 의 조합이지만 '문자로 표현된 실제 의미' 는 정수 `10` 을 의미하고 있고 따라서 `a` 는 `Int` 타입으로 추론됩니다.

[^isEmpty-count]: 실제로 스위프트에서는 배열에 값이 있는지 없는지를 검사할 때는 `isEmpty` 를 사용할 것을 권장합니다. `count` 는 값의 개수가 몇 개인지를 알고 싶을 때 사용하는 것입니다. 즉, 단순히 편리하기 때문에만 `isEmpty` 를 사용하는 것은 아닙니다. 이에 대한 이유는 [isEmpty vs. count == 0](https://medium.com/better-programming/strings-comparison-isempty-vs-count-0-be80d701901b) 이라는 글을 읽어보길 바랍니다.

[^count-concurrent]: `shippingList.count` 는 현재 배열의 요소 전체 개수를 나타내는데, 이 값을 사용해서 요소를 새로 추가하게 되면 그 자ㅔ로 `count` 가 변경돼야 합니다. 즉 `count` 변수에 값을 읽는 작업과 쓰는 작업을 동시에 진행하는 문제가 발생할 수 있습니다.

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

[^set-array-literal]: 이것은 '배열 문자표현 (array literal)' 만 사용할 경우, `Array` 로 추론되기 때문일 것입니다.
