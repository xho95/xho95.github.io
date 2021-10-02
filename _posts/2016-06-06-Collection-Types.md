---
layout: post
comments: true
title:  "Swift 5.5: Collection Types (집합체 타입)"
date:   2016-06-06 19:45:00 +0900
categories: Swift Grammar Collection Array Set Dictionary
redirect_from: "/swift/grammar/collection/array/set/dictionary/2016/06/06/Collection-Types.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Collection Types](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html) 부분[^Collection-Types]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Collection Types (집합체 타입)

스위프트는, 값의 집합체를 저장하는, '배열 (arrays), 셋 (sets)[^sets-type], 및 딕셔너리 (dictionaries)[^dictionaries-type]' 라는, 세 가지 주요 _집합체 타입 (collection types)_[^collections] 을 제공합니다. 배열은 '값들의 순서가 있는 (ordered) 집합체'[^ordered-collection] 입니다. 셋은 '유일한 값들이 순서 없이 (unordered) 있는 집합체' 입니다. 딕셔너리는 '키-값 결합 (key-value associations) 들이 순서 없이 있는 집합체' 입니다.

![Array-Set-Dictionary](/assets/Swift/Swift-Programming-Language/Collection-Types-array-set-dictionary.jpg)

스위프트에서 배열, 셋, 그리고 딕셔너리는 자신이 저장할 값과 키의 타입을 항상 명확히 합니다. 이는 집합체에 잘못된 타입의 값을 실수로 집어 넣을 수는 없다는 의미입니다. 집합체로부터 가져올 값의 타입을 자신해도 된다는 의미이기도 합니다.

> 스위프트의 배열, 셋 그리고 딕셔너리 타입은 _일반화 집합체 (generic collections)_ 로 구현되어 있습니다. '일반화 (generic) 타입과 집합체' 에 대한 더 많은 것은, [Generics (일반화)]({% post_url 2020-02-29-Generics %}) 장을 참고하기 바랍니다.

### Mutability of Collections (집합체의 변경 가능성)

배열이나, 셋, 또는 딕셔너리를 생성한 후, 이를 변수에 할당하면, 생성한 집합체가 _변경 가능 (mutable)_ 할 것입니다. 이는 집합체를 생성한 후 집합체의 항목을 추가, 삭제, 또는 바꿈으로써 이를 바꾸거나-_변경 (mutate)_-할 수 있다는 의미입니다. 배열, 셋, 또는 딕셔너리를 상수에 할당하면, 그 집합체는 _변경 불가능 (immutable)_ 하며, 크기와 내용물을 바꿀 수 없습니다.

> 바꿀 필요가 없는 모든 집합체는 '변경 불가능한 집합체로 생성' 하는 것이 좋은 습관입니다. 그럼으로써 코드 파악이 쉬워지며 생성한 집합체를 스위프트 컴파일러가 성능 최적화 하도록 합니다.

### Arrays (배열)

_배열 (array)_ 은 '똑같은 타입의 값을 순서 있는 리스트[^ordered-list] 에 저장' 합니다. 배열에서는 똑같은 값이 서로 다른 위치에 여러 번 있을 수 있습니다.

> 스위프트의 `Array` 타입은 'Foundation[^Foundation] 의 `NSArray` 클래스와 연동 (bridged)' 되어 있습니다.
>
> `Array` 와 'Foundation 및 Cocoa'[^Cocoa] 를 함께 사용하기 위한 더 많은 정보는, [Bridging Between Array and NSArray](https://developer.apple.com/documentation/swift/array#2846730) 항목을 참고하기 바랍니다.

#### Array Type Shorthand Syntax (배열 타입의 줄임 구문)

스위프트 배열 타입의 온전한 작성법은 `Array<Element>` 인데, 여기서 `Element` 는 배열에 저장이 허용된 값의 타입입니다. 배열 타입을 `[Element]` 라는 줄임 형식으로 작성할 수도 있습니다. 두 형식은 기능이 완전히 똑같지만, 줄임 형식이 더 좋으며 이 설명서 전반에 걸쳐 배열 타입을 참조할 때 이를 사용합니다.

#### Creating an Empty Array (빈 배열 생성하기)

정해진 타입에 대한 빈 배열은 '초기자 구문 (initializer syntax)' 으로 생성할 수 있습니다:

```swift
var someInts = [Int]()
print(("someInts is of type [Int] with \(someInts.count) items.")
// "someInts is of type [Int] with 0 items." 를 인쇄함
```

`someInts` 라는 변수 타입은 초기자의 타입에 의해 `[Int]` 라고 추론함을 기억하기 바랍니다.

대안으로, 함수 인자 또는 이미 타입을 지정한 변수나 상수 같이, 이미 타입 정보를 제공한 상황이라면, '(빈 대괄호 쌍인) `[]` 를 쓴, 빈 배열 글자 값 (empty array literal)' 으로 빈 배열을 생성할 수 있습니다:

```swift
someInts.append(3)
// someInts 는 이제 Int 타입의 값 1 개를 담고 있습니다.
someInts = []
// someInts 는 이제 빈 배열이지만, 여전히 [Int] 타입입니다.
```

#### Creating an Array with a Default Value (기본 값으로 배열 생성하기)

스위프트 `Array` 타입은 '정해진 크기의 배열을 생성할 때 자신의 모든 값을 똑같은 기본 값으로 설정하는 초기자' 도 제공합니다. 이 초기자에 '(`repeating` 이라는) 적절한 타입의 기본 값' 과 '(`count` 라는) 새로운 배열에서 해당 값을 반복할 횟수' 를 전달합니다:

```swift
var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles 은 [Double] 타입이고, [0.0, 0.0, 0.0] 와 같음
```

#### Creating an Array by Adding Two Arrays Together (두 배열을 서로 더해서 배열 생성하기)

새로운 배열은 '덧셈 연산자 (`+`) 와 호환 가능한[^compatible] 타입인 두 기존 배열을 더함' 으로써 생성할 수 있습니다. 새 배열의 타입은 서로 더한 두 배열의 타입으로 추론합니다:

```swift
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles 은 [Double] 타입이고, [2.5, 2.5, 2.5] 와 같음

var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles 은 [Double] 타입이라고 추론하며, [0.0, 0,0, 0.0, 2.5, 2.5, 2.5] 와 같음
```

#### Creating an Array with an Array Literal (배열 글자 값으로 배열 생성하기)

배열은, 하나 이상의 값을 배열 집합체로 작성하여 줄인, _배열 글자 값 (array literal)_[^literal] 으로 초기화할 수도 있습니다. '배열 글자 값' 은, 쉼표로 구분한, 값의 목록을, 대괄호 쌍으로 둘러싸서 작성합니다:

&nbsp;&nbsp;&nbsp;&nbsp;[`value 1-값 1`, `value 2-값 2`, `value 3-값 3`]

아래 예제는 `String` 값을 저장하는 `shoppingList` 라는 배열을 생성합니다:

```swift
var shoppingList: [String] = ["Eggs", "Milk"]
// shoppingList 를 두 개의 초기 항목으로 초기화함
```

`shoppingList` 변수는, `[String]` 을 쓴, "문자열 값 배열" 이라고 선언합니다. 이 특별한 배열에 `String` 타입인 값을 지정했기 때문에, `String` 값의 저장만 허용합니다. 여기서, `shoppingList` 배열은, '배열 글자 값' 안에 작성한, (`"Eggs"` 와 `"Milk"` 라는) 두 `String` 값으로 초기화 합니다.

> `shoppingList` 배열을 (`let` '도입자 (introducer)' 를 쓴) 상수가 아니라 (`var` 도입자를 쓴) 변수로 선언했는데 이는 아래 예제에서 '구매 목록 (shopping list)' 에 더 많은 항목을 추가하기 때문입니다.

이 경우, '배열 글자 값' 은 두 개의 `String` 값 외에 다른 것은 아무 것도 담고 있지 않습니다. 이는 `shoppingList` 변수의 선언 타입 (`String` 값만 담을 수 있는 배열) 과 일치하므로, '배열 글자 값' 의 할당이 두 초기 항목으로 `shoppingList` 를 초기화하는 방법으로써 허가됩니다.

스위프트의 '타입 추론 (type inference)' 에 감사하게도, 같은 타입의 값을 담은 '배열 글자 값' 으로 초기화할 경우 배열의 타입은 작성하지 않아도 됩니다. `shoppingList` 의 초기화는 '줄임 형식' 으로 대신 작성할 수도 있습니다:

```swift
var shoppingList = ["Eggs", "Milk"]
```

'배열 글자 값' 에 있는 모든 값이 같은 타입이기 때문에, 스위프트가 `shoppingList` 변수에 대한 올바른 타입이 `[String]` 이라고 추론할 수 있습니다.

#### Accessing and Modifying an Array (배열 접근하기와 수정하기)

배열은 메소드와 속성을 통하여, 아니면 '첨자 연산 구문 표현 (subscript syntax)' 을 사용하여, 접근하고 수정합니다.

배열의 항목 개수를 알아 내려면, 읽기-전용 속성인 `count` 를 검사합니다:

```swift
print("The shopping list contains \(shoppingList.count) items.")
// "The shopping list contains 2 items." 를 인쇄합니다.
```

'불리언 (Boolean)' 속성 `isEmpty` 는 `count` 속성이 `0` 인지 검사하는 것의 '줄임말 (shortcut)' 로써 사용합니다[^isEmpty-count]:

```swift
if shoppingList.isEmpty {
  print("The shopping list is empty.")
} else {
  print("The shopping list is not empty.")
}
// "The shopping list is not empty." 를 인쇄합니다.
```

배열의 `append(_:)` 메소드를 호출함으로써 배열 끝에 새로운 항목을 덧붙일 수 있습니다:

```swift
shoppingList.append("Flour")
// shoppingList 는 이제 3 개의 항목을 담고 있으며, 누군가 팬케이크를 만들고 있습니다.
```

또 다른 방법으로, '더하기 할당 연산자 (`+=`)' 로 하나 이상의 호환 가능한 항목들의 배열을 덧붙입니다:

```swift
shoppingList += ["Baking Powder"]
// shoppingList 는 이제 4 개의 항목을 담고 있습니다.
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
// shoppingList 는 이제 7 개의 항목을 담고 있습니다.
```

배열의 값은, 배열 이름 바로 뒤의 대괄호에 가져오고자 하는 값의 '색인 (index)' 을 전달하는, _첨자 연산 구문 표현 (subscript syntax)_ 을 사용하여 가져옵니다.:

```swift
var firstItem = shoppingList[0]
// firstItem 은 "Eggs" 입니다.
```

> 배열에 있는 첫 번째 항목은, `1` 이 아닌, `0` 이라는 색인을 가집니다. 스위프트의 배열은 항상 '0 으로-색인 (zero-indexed)' 됩니다.

주어진 색인의 기존 값을 바꾸기 위해 '첨자 연산 구문 표현' 을 사용할 수 있습니다:

```swift
shoppingList[0] = "Six eggs"
// 목록의 첫 번째 항목은 이제 "Eggs" 가 아니라 "Six eggs" 입니다.
```

'첨자 연산 구문 표현' 을 사용할 때는, 유효한 색인을 지정할 필요가 있습니다. 예를 들어, 배열 끝에 항목을 추가하려고 `shoppingList[shoppingList.count] = "Salt"` 라고 작성하면 '실행 시간 에러' 가 되버립니다.[^count-concurrent]

일정 범위의 값들을 한 번에 바꾸기 위해 '첨자 연산 구문 표현' 을 사용할 수도 있는데, 이 때 대체할 값의 집합이 대체될 범위와는 다른 길이를 가지더라도 무방합니다. 다음 예제는 `"Chocolate Spread"`, `"Cheese"`, 와 `"Butter"` 를 `"Bananas"` 와 `"Apples"` 로 대체합니다:

```swift
shoppingList[4...6] = ["Bananas", "Apples"]
// shoppingList 는 이제 6 개의 항목을 담고 있습니다.
```

배열에서 지정된 색인에 항목을 집어 넣으려면, 배열의 `insert(_:at:)` 메소드를 호출합니다:

```swift
shoppingList.insert("Maple Syrup", at: 0)
// shoppingList 는 이제 7 개의 항목을 담고 있습니다.
// "Maple Syrup" 이 이제 목록에 있는 첫 번째 항목입니다.
```

이 `insert(_:at:)` 메소드 호출은, 색인 `0` 으로 지시한, '구매 목록' 의 맨 앞에, 값이 `"Maple Syrup"` 인 새로운 항목을 집어 넣습니다.

이와 비슷하게, `remove(at:)` 메소드로 배열에서 항목을 삭제합니다. 이 메소드는 지정된 색인의 항목을 삭제하고 삭제한 항목을 반환합니다. (물론 필요 없다면 이 반환 값을 무시할 수 있습니다):

```swift
let mapleSyrup = shoppingList.remove(at: 0)
// 색인이 0 인 값을 방금 삭제했습니다.
// shoppingList 는 이제 6 개의 항목을 담고 있으며, Maple Syrup 은 없습니다.
// mapleSyrup 상수는 이제 삭제한 문자열인 "Maple Syrup" 입니다.
```

> 배열이 존재하는 범위 밖에 있는 색인의 값에 접근하려고 하거나 수정하려고 하면, 실행 시간 에러를 발생시키게 됩니다. 색인이 유효한 지는 사용하기 전에 배열의 `count` 속성과 비교함으로써 검사할 수 있습니다. 배열에서 유효한 색인으로 가장 큰 것은 `count - 1` 인데 이는 배열이 '0-부터 색인 (indexed from zero)' 되기 때문입니다-하지만, `count` 가 (배열이 비어있음을 의미하는) `0` 일 땐, 유효한 색인은 아예 없습니다.

배열에서 항목을 삭제할 때는 어떤 빈틈이든 메워지므로, 색인 `0` 의 값은 다시 한 번 `"Six eggs"` 가 됩니다:

```swift
firstItem = shoppingList[0]
// firstItem 은 이제 "Six eggs" 입니다.
```

배열에서 최종 항목을 삭제하고 싶으면, 배열의 `count` 속성 조회를 피하도록 `remove(at:)` 메소드 보다는 `removeLast()` 메소드를 사용합니다. `remove(at:)` 메소드와 같이, `removeLast()` 메소드도 삭제한 항목을 반환합니다:

```swift
let apples = shoppingList.removeLast()
// 배열의 마지막 항목을 방금 삭제했습니다.
// shoppingList 는 이제 5 개의 항목을 담고 있으며, apple 은 없습니다.
// apples 상수는 이제 삭제한 문자열인 "Apples" 입니다.
```

#### Iterating Over an Array (배열에 동작을 반복시키기)

배열에 있는 전체 값들은 `for`-`in` 반복문으로 '동작을 반복시킬 (iterate over)'[^iterate-over] 수 있습니다:

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

값 뿐만 아니라 각 항목의 정수 색인도 필요한 경우, 배열에 동작을 반복시키기 위해 대신 `enumerated()` 메소드를 사용합니다. 배열의 각 항목마다, `enumerated()` 메소드는 정수와 항목으로 구성된 '튜플 (tuple)' 을 반환합니다. 이 정수는 '0' 에서 시작하며 각 항목마다 하나씩 세어 갑니다; 전체 배열을 '열거하는 (enumerate over)' 경우엔, 이 정수들이 항목들의 색인과 일치합니다. 튜플은 '반복 회차 (iteration)' 마다 임시 상수나 변수로 분해할 수 있습니다:

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

`for`-`in` 반복문에 대한 더 많은 내용은, [For-In Loops (For-In 반복문)]({% post_url 2020-06-10-Control-Flow %}#for-in-loops-for-in-반복문) 을 참고하기 바랍니다.

### Sets (셋)

_셋 (set)_ 은 '집합체 (collection)' 에 같은 타입의 서로 별개인 값들을 '정의된 순서없이 (no defined ordering)'[^no-defined-ordering] 저장합니다. '셋' 은 항목의 순서가 중요하지 않을 때나, 항목이 한 번만 나타나도록 보장해야 할 때에, 배열 대신 사용할 수 있습니다.

> 스위프트의 `Set` 타입은 'Foundation'[^Foundation] 의 `NSSet` 클래스와 '연동되어 (bridged)' 있습니다.
>
> `Set` 을 'Foundation' 및 'Cocoa'[^Cocoa] 와 같이 사용하는 것에 대한 더 많은 정보는, [Bridging Between Set and NSSet](https://developer.apple.com/documentation/swift/set#2845530) 을 참고하기 바랍니다.

#### Hash Values for Set Types (셋 타입을 위한 해시 값)

'셋' 에 저장하는 타입은 반드시 _해시 가능 (hashable)_[^hashable] 해야 합니다-즉, 타입 스스로 반드시 _해시 값 (hash value)_[^hash-value] 을 계산하는 방식을 제공해야 합니다. '해시 값' 은 비교해서 같은 모든 객체끼리는 똑같은 하나의 `Int` 값으로, 가령 `a == b` 라면, `a` 의 해시 값은 `b` 의 해시 값과 같습니다.

스위프트의 모든 (`String`, `Int`, `Double`, 및 `Bool` 같은) 기본 타입은 기본적으로 '해시 가능' 해서, '셋' 의 값 타입 또는 '딕셔너리 (dictionary)' 의 '키 (key)' 타입으로 사용할 수 있습니다. ([Enumerations (열거체)]({% post_url 2020-06-13-Enumerations %}) 에서 설명한 것처럼) '결합 값 (associated values)' 이 없는 '열거체 case 값' 역시 기본적으로 해시 가능합니다.   

> 자신만의 사용자 정의 타입은 스위프트 표준 라이브러리의 `Hashable` 프로토콜을 준수함으로써 '셋' 의 값 타입 또는 '딕셔너리' 의 키 타입으로 사용할 수 있습니다. '필수 (required) 메소드' 인 `hash(into:)` 을 구현하는 것에 대한 정보는, [Hashable](https://developer.apple.com/documentation/swift/hashable) 을 참고하기 바랍니다. 프로토콜을 준수하는 것에 대한 정보는, [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 을 참고하기 바랍니다.

#### Set Type Syntax (셋 타입 구문 표현)

스위프트의 '셋' 타입은 `Set<Element>` 라고 작성하는데, 여기서 `Element` 는 셋에 저장하도록 허용한 타입입니다. '배열' 과는 달리, '셋' 은 동치인 '줄임 표현' 이 없습니다.

#### Creating and Initializing an Empty Set (빈 셋 생성하고 초기화하기)

정해진 타입의 빈 '셋' 은 '초기자 구문 표현 (initializer syntax)' 을 사용하여 생성할 수 있습니다:

```swift
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
// "letters is of type Set<Character> with 0 items." 을 인쇄합니다.
```

> `letters` 변수의 타입을, 초기자의 타입으로부터, `Set<Character>` 라고 추론합니다.

또 다른 방법으로, 이미 타입 정보를 제공한 상황, 가령 함수 인자에서 또는 이미 타입을 정한 변수나 상수 같은 상황인 경우, 빈 '셋' 을 '빈 배열 글자 값 (empty array literal)'[^empty-array-literal] 으로 생성할 수 있습니다:

```swift
letters.insert("a")
// letters 는 이제 Character 타입의 값 1 개를 담고 있습니다.
letters = []
// letters 는 이제 빈 셋이지만, 타입은 여전히 Set<Character> 입니다.
```

#### Creating a Set with an Array Literal (배열 글자 값으로 셋 생성하기)

'셋' 은, 하나 이상의 값을 '셋 집합체 (set collection)' 에 작성하는 '줄임 표현법' 인, '배열 글자 값' 으로 초기화할 수도 있습니다.

아래 예제는 `String` 값을 저장하는 `favoriteGenres` 라는 '셋' 을 생성합니다:

```swift
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip Hop"]
// favoriteGenres 는 세 개의 초기 항목들로 초기화되었습니다.
```

`favoriteGenres` 변수는, `Set<String>` 을 써서, "`String` 값의 '셋 (set)'[^set]” 으로 선언합니다. 이 특정 셋은 값 타입이 `String` 이라고 지정했기 때문에, `String` 값 _만 (only)_ 저장하도록 허용합니다. 여기서의, `favoriteGenres` 셋은, '배열 글자 값' 에서 작성된, 세 개의 `String` (`"Rock"`, `"Classical"`, 그리고 `"Hip hop"`) 값으로 초기화 됩니다.

> `favoriteGenres` 셋은 (`let` '도입자' 를 쓰는) 상수가 아니라 (`var` '도입자' 를 써서) 변수로 선언되었는데 이는 아래 예제에서 항목이 추가되거나 삭제되기 때문입니다.

'셋' 타입은 '배열 글자 값' 홀로 있으면 추론할 수 없으므로[^set-array-literal], `Set` 타입은 반드시 명시적으로 선언해야 합니다. 하지만, 스위프트의 타입 추론으로 인하여, 단 한 가지 타입의 값을 담은 '배열 글자 값' 으로 초기화하는 경우 '셋' 의 '원소 (elements)' 타입은 작성하지 않아도 됩니다. `favoriteGenres` 의 초기화는 '줄임 형식' 으로 대신 작성할 수도 있습니다:

```swift
var favoriteGenres: Set = ["Rock", "Classical", "Hip Hop"]
```

'배열 글자 값' 에 있는 모든 값이 같은 타입이기 때문에, 스위프트가 `favoriteGenres` 변수에 대한 올바른 타입이 `Set<String>` 이라고 추론할 수 있습니다.

#### Accessing and Modifying a Set (셋 접근하기와 수정하기)

'셋' 은 메소드와 속성을 통하여 접근하고 수정합니다.

'셋' 의 항목 개수를 알아 내려면, 읽기-전용 속성인 `count` 를 검사합니다:

```swift
print("I have \(favoriteGenres.count) favorite music genres.")
// "I have 3 favorite music genres." 를 인쇄합니다.
```

'불리언' 속성 `isEmpty` 는 `count` 속성이 `0` 인지 검사하는 것의 '줄임말' 로써 사용합니다[[^isEmpty-count]]:

```swift
if favoriteGenres.isEmpty {
  print("As far as music goes, I'm not picky.")
} else {
  print("I have particular music preferences.")
}
// "I have particular music preferences." 를 인쇄합니다.
```

`insert(_:)` 메소드를 호출하여 '셋' 에 새로운 항목을 추가할 수 있습니다:

```swift
favoriteGenres.insert("Jazz")
// favoriteGenres 는 이제 4 개의 항목을 담고 있습니다.
```

'셋' 의 `remove(_:)` 메소드를 호출하여 셋에 있는 항목을 삭제할 수 있는데, 이는 그 항목이 셋의 멤버라면 이를 삭제하고, 삭제한 값을 반환하지만, '셋' 이 이를 담고 있지 않은 경우 `nil` 을 반환합니다. 또 다른 방법으로는, `removeAll()` 메소드로 '셋' 에 있는 모든 항목을 삭제할 수 있습니다.

```swift
if let removeGenres = favoriteGenres.remove("Rock") {
  print("\(removeGenres)? I'm over it.")
} else {
  print("I never much cared for that.")
}
// "Rock? I'm over it." 를 인쇄합니다.
```

셋이 특정 항목을 담고 있는 지를 검사하려면, `contains(_:)` 메소드를 사용합니다.

```swift
if favoriteGenres.contains("Funk") {
  print("I get up on the good foot.")
} else {
  print("It's too funky in here.")
}
// "It's too funky in here." 를 인쇄합니다.
```

#### Iterating Over a Set (셋에 동작을 반복시키기)

셋에 있는 값들은 `for`-`in` 반복문으로 '동작을 반복시킬' 수 있습니다.

```swift
for genre in favoriteGenres {
  print("\(genre)")
}
// Classical
// Jazz
// Hip Hop
```

`for`-`in` 반복문에 대한 더 자세한 내용은, [For-In Loops (For-In 반복문)]({% post_url 2020-06-10-Control-Flow %}#for-in-loops-for-in-반복문) 을 참고하기 바랍니다.

스위프트의 `Set` 타입은 '정의된 순서 (defined ordering)' 를 가지고 있지 않습니다. 지정된 순서로 셋의 값들에 동작을 반복시키려면, '셋' 의 원소를 `<` 연산자로 '정렬된 배열' 로써 반환하는, `sorted()` 메소드를 사용합니다.

```swift
for genre in favoriteGenres.sorted() {
  print("\(genre)")
}
// Classical
// Hip Hop
// Jazz
```

### Performing Set Operations (집합 연산 수행하기)

('셋' 으로) 기본적인 '집합 연산 (set operations)'[^set-operations] 들, 가령 두 집합을 서로 '조합하는 것 (combining)', 두 집합이 공통적으로 가지고 있는 값을 결정하는 것, 또는 두 집합이 모두 같은, 일부만 같은, 아니면 아무 것도 같지 않은 값들을 담고 있는 지를 결정하는 것 등, 을 효율적으로 수행할 수 있습니다.  

### Fundamental Set Operations (기본적인 집합 연산)

아래 그림은 두 집합-`a` 와 `b`-에 다양한 집합 연산을 수행한 결과를 '음영 영역' 으로 보입니다.

![Fundamental-Set-Operations](/assets/Swift/Swift-Programming-Language/Collection-Types-fundamental-set-operations.jpg)

* `intersect(_:)`[^intersection] 메소드는 두 집합에 공통인 값만으로 새 집합을 생성하기 위해 사용합니다.
* `symmetricDifference(_:)`[^symmetric-difference] 메소드는 각 집합에는 있지만, 동시에 있지는 않은 값으로 새 집합을 생성하기 위해 사용합니다.
* `union(_:)` : 메소드는 두 집합에 있는 모든 값으로 새 집합을 생성하기 위해 사용합니다.
* `subtracting(_:)`[^subtracting] 메소드는 지정한 집합에는 없는 값으로 새 집합을 생성하기 위해 사용합니다.

```swift
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sort()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sort()
// []
oddDigits.subtracting(singleDigitPrimeNumbers).sort()
// [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sort()
// [1, 2, 9]
```

### Set Membership and Equality (집합의 포함관계 및 같음 비교)

아래 그림은 세 '집합 (sets)'[^sets]-`a`, `b`, 와 `c`-에서 서로 공유하는 원소를 '겹침 영역' 으로 표현하여 보입니다. 집합 `a` 는 집합 `b` 의 _상위 집합 (superset)_ 이며, 이는 `a` 가 `b` 의 모든 원소를 담고 있기 때문입니다. 거꾸로, 집합 `b` 는 집합 `a` 의 _하위 집합 (subset)_[^subset] 이며, 이는 `b` 의 모든 원소가 `a` 에도 담겨 있기 때문입니다. 집합 `b`와 집합 `c`는 서로 _분리 (disjoint)_[^disjoint] 라고 하며, 이는 서로 공통인 원소를 공유하고 있지 않기 때문입니다.

![Set-Membership-and-Equality](/assets/Swift/Swift-Programming-Language/Collection-Types-set-membership-and-equality.jpg)

* “같음 (is equal)” 연산자 (`==`) 는 두 집합이 모두 같은 값을 담고 있는지 결정하기 위해 사용합니다.
* `isSubset(of:)` 메소드는 집합의 모든 값이 지정된 집합에 담겨 있는지 결정하기 위해 사용합니다.
* `isSuperset(of:)` 메소드는 집합이 지정한 집합에 있는 값을 모두 담고 있는지 결정하기 위해 사용합니다.
* `isStrictSubset(of:)` 또는 `isStrictSuperset(of:)` 메소드는 집합이, 지정된 집합의, '진 하위 집합 (진 부분 집합)' 또는 '진 상위 집합' 인지 결정하기 위해 사용합니다.
* `isDisjoint(with:)` 메소드는 두 집합에 공통인 값이 없는지 결정하기 위해 사용합니다.

```swift
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals)
// 참
farmAnimals.isSuperset(of: houseAnimals)
// 참
farmAnimals.isDisjoint(with: cityAnimals)
// 참
```

### Dictionaries (딕셔너리)

_딕셔너리 (dictionary)_ 는 똑같은 타입인 키들과 똑같은 타입인 값들 사이의 '결합 (associations)' 을 '정의된 순서' 없이 '집합체 (collection)' 에 저장합니다. 각 값은 유일한 _키 (key)_ 와 결합되며, 이는 딕셔너리 내에서 해당 값을 위한 '식별자 (identifier)' 로 작동합니다. 배열의 항목과는 달리, 딕셔너리의 항목은 '지정된 순서 (specified order)' 를 가지지 않습니다. 딕셔너리는, 실제-세계의 '사전 (dictionary)' 이 특정 단어에 대한 정의를 찾아 보는 것과 거의 같은 방식으로, 식별자를 기초로 하여 값을 찾아 볼 때 사용합니다.

> 스위프트의 `Dictionary` 타입은 'Foundation'[^Foundation] 의 `NSDictionary` 클래스와 '연동되어 (bridged)' 있습니다.
>
> `Dictionary` 를 'Foundation' 및 'Cocoa'[^Cocoa] 와 같이 사용하는 것에 대한 더 많은 정보는, [Bridging Between Dictionary and NSDictionary](https://developer.apple.com/documentation/swift/dictionary#2846239) 를 참고하기 바랍니다.

#### Dictionary Type Shorthand Syntax (딕셔너리 타입의 줄임 구문 표현)

스위프트의 딕셔너리 타입을 온전하게 작성하려면 `Dictionary<Key, Value>` 라고 하는데, 여기서 `Key` 는 딕셔너리의 키로 사용될 수 있는 값의 타입이며, `Value` 는 딕셔너리가 해당 키로 저장하는 값의 타입입니다.

> 딕셔너리의 `Key` 타입은, '셋' 의 값 타입과 같이, 반드시 `Hashable` 프로토콜을 준수해야 합니다.

딕셔너리 타입은 `[Key: Value]` 라는 '줄임 형식' 으로 작성할 수도 있습니다. 비록 두 형식이 기능적으로는 완전히 똑같지만, 줄임 형식이 더 좋으며 이 설명서 전체에서 딕셔너리 타입을 참조할 때는 이를 사용합니다.

#### Creating an Empty Dictionary (빈 딕셔너리 생성하기)

배열에서 처럼, '초기자 구문 (initializer syntax)' 을 사용함으로써 정해진 타입의 빈 `Dictionary` 를 생성할 수 있습니다:

```swift
var namesOfIntegers = [Int: String]()
// namesOfIntegers 는 [Int: String] 타입의 빈 딕셔너리입니다.
```

다음 예제는 정수 값을 '사람이-읽을 수 있는 이름' 으로 저장하기 위해 `[Int: String]` 타입의 빈 딕셔너리를 생성합니다. 이것의 키는 `Int` 타입이고, 값은 `String` 타입입니다.

이미 타입 정보를 제공한 상황인 경우, 빈 딕셔너리는, `[:]` (대괄호 쌍 안의 콜론) 으로 작성하는, '빈 딕셔너리 글자 값 (empty dictionary literal)' 으로 생성할 수 있습니다:

```swift
namesOfIntegers[16] = "sixteen"
// namesOfIntegers 는 이제 1 개의 '키-값 쌍' 을 담고 있습니다.
namesOfIntegers = [:]
// namesOfIntegers 는 다시 한 번 타입이 [Int: String] 인 빈 딕셔너리 입니다.
```

#### Creating a Dictionary with a Dictionary Literal (딕셔너리 글자 값으로 딕셔너리 생성하기)

'딕셔너리' 는, 이전에 본 '배열 글자 값' 과 비슷한 구문 표현을 가진, _딕셔너리 글자 값 (dictionary literal)_ 으로 초기화할 수도 있습니다. '딕셔너리 글자 값' 은 하나 이상의 '키-값 쌍' 을 `Dictionary` '집합체 (collection)' 로 작성하는 '줄임 표현법' 입니다.

_키-값 쌍 (key-value pair)_ 은 '키' 와 '값' 이 조합된 것입니다. '딕셔너리 글자 값' 에서, 각 '키-값 쌍' 에 있는 '키' 와 '값' 은 '콜론 (colon)' 으로 구분됩니다. '키-값 쌍' 들은, 쉼표로 구분된, 목록, 주위를 대괄호 쌍으로 감싸서 작성합니다:

[`key 1-키 1`: `value 1-값 1`, `key 2-키 2`: `value 2-값 2`, `key 3-키 3`: `value 3-값 3`]

아래 예제는 국제 공항의 이름을 저장하는 '딕셔너리' 를 생성합니다. 이 딕셔너리에서, '키' 는 세-글자의 '국제 항공 운송 협회 (International Air Transport Association)'[^IATA] 코드 이며, '값' 은 공항 이름입니다:

```swift
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
```

`airport` 딕셔너리는 `[String: String]` 타입을 가지는 것으로 선언했는데, 이는 "키는 `String` 타입이며, 값도 `String` 타입인 `Dictionary`" 를 의미합니다.

> `airport` 딕셔너리는, (`let` '도입자' 를 쓰는) 상수가 아니라, (`var` '도입자' 를 써서) 변수로 선언했는데, 이는 아래 예제에서 이 '딕셔너리' 에 공항을 더 추가하기 때문입니다.

`airports` 딕셔너리는 두 개의 '키-값 쌍' 을 담은 '딕셔너리 글자 값' 으로 초기화됩니다. 첫 번째 쌍은 `"YYZ"` 라는 '키' 와 `"Toronto Pearson"` 라는 '값' 을 가집니다. 두 번째 쌍은 `"DUB"` 이라는 '키' 와 `"Dublin"` 이라는 '값' 을 가집니다.

이 '딕셔너리 글자 값' 은 두 개의 `String: String` 쌍을 담고 있습니다. 이 '키-값 타입' 은  `airports` 변수의 선언 타입 (`String` 키와, `String` 값만을 가지는 딕셔너리) 와 일치하므로, '딕셔너리 글자 값' 의 할당이 두 초기 항목으로 `airports` 딕셔너리를 초기화하는 방법으로써 허가됩니다.

배열에서 처럼, 일관성 있는 타입의 키와 값을 가진 딕셔너리로 초기화하는 경우 디셔너리의 타입을 작성하지 않아도 됩니다. `airports` 의 초기화는 '줄임 형식' 으로 대신 작성할 수도 있습니다:

```swift
var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
```

'글자 값' 에 있는 모든 키가 서로 같은 타입이고, 마찬가지로 모든 값도 서로 같은 타입이기 때문에, 스위프트가 `airports` 딕셔너리에 대한 올바른 타입이 `[String: String]` 이라고 추론할 수 있습니다.

#### Accessing and Modifying a Dictionary (딕셔너리 접근하기와 수정하기)

딕셔너리는 메소드와 속성을 통하여, 아니면 '첨자 연산 구문 표현 (subscript syntax)' 을 사용하여, 접근하고 수정합니다.

배열에서 처럼, 읽기-전용 속성인 `count` 를 검사하여 `Dictionary` 의 항목 개수를 알아냅니다:

```swift
print("The airports dictionary contains \(airports.count) items.")
// "The airports_2 dictionary contains 2 items." 를 인쇄합니다.
```

'불리언' 속성 `isEmpty` 는 `count` 속성이 `0` 인지 검사하는 것의 '줄임말' 로써 사용합니다[^isEmpty-count]:

```swift
if airports.isEmpty {
  print("The airports dictionary is empty.")
} else {
  print("The airports dictionary is not empty.")
}
// "The airports dictionary is not empty." 를 인쇄합니다.
```

'첨자 연산 구문 표현' 으로 딕셔너리에 새 항목을 추가할 수 있습니다. '첨자 연산의 색인 (subscript index)' 으로 적절한 타입의 새로운 키를 사용해서, 적절한 타입의 새로운 값을 할당합니다:  

```swift
airports["LHR"] = "London"
// airports 딕셔너리는 이제 3 개의 항목을 담고 있습니다.
```

'첨자 연산 구문 표현' 은 특정 키와 결합되어 있는 값을 바꾸는데도 사용합니다:

```swift
airports["LHR"] = "London Heathrow"
// "LHR" 에 대한 값을 "London Heathrow" 로 바꿨습니다.
```

첨자 연산의 대안으로, 특정 키에 대한 값을 설정하거나 갱신하려면 딕셔너리의 `updateValue(_:forKey:)` 메소드를 사용합니다. 위의 첨자 연산 예제에서와 같이, `updateValue(_:forKey:)` 메소드는 아무 것도 존재하지 않으면 키에 대한 값을 설정하고, 해당 키가 이미 존재하면 값을 갱신합니다. 하지만, 첨자 연산과는 달리, `updateValue(_:forKey:)` 메소드는 갱신을 한 후에 _예전 (old)_ 값을 반환합니다. 이는 갱신이 일어났는지 아닌지를 검사할 수 있게 해줍니다.

`updateValue(_:forKey:)` 메소드는 딕셔너리의 값 타입에 대한 '옵셔널 (optional) 값' 을 반환합니다. 예를 들어, `String` 값을 저장하는 딕셔너리에 대해서는, 메소드가 `String?` 타입의 값, 또는 "옵셔널 `String`", 을 반환합니다. 이 옵셔널 값은, 갱신 전에 값이 존재했으면 해당 키에 대한 예전 값을, 아무 값도 존재하지 않았으면 `nil` 을, 담고 있습니다:

```swift
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
  print("The old value for DUB was \(oldValue).")
}
// "The old value for DUB was Dublin." 를 인쇄합니다.
```

'첨자 연산 구문 표현' 은 딕셔너리에서 특정 키에 대한 값을 가져오기 위해 사용할 수도 있습니다. 값이 존재하지 않는 키로 요청할 수도 있기 때문에, 딕셔너리의 첨자 연산은 딕셔너리의 '값 타입' 에 대한 '옵셔널 값' 을 반환합니다. 딕셔너리가 요청한 키에 대한 값을 담고 있으면, 첨자 연산이 해당 키에 존재하고 있는 값을 담은 '옵셔널 값' 을 반환합니다. 다른 경우라면, 첨자 연산이 `nil` 을 반환합니다:

```swift
if let airportName = airports["DUB"] {
  print("The name of the airport is \(airportName).")
} else {
  print("That airport is not in the airports dictionary.")
}
// "The name of the airport is Dublin Airport." 를 인쇄합니다.
```

'첨자 연산 구문 표현' 은 해당 키에 `nil` 값을 할당함으로써 딕셔너리에서 '키-값 쌍' 을 삭제하기 위해 사용할 수 있습니다:

```swift
airports["APL"] = "Apple International"
// "Apple International" 은 APL 에 대한 실제 공항이 아니므로, 이를 지웁니다.
airports["APL"] = nil
// APL 이 이제 딕셔너리에서 삭제되었습니다.
```

또 다른 방법으로, `removeValue(_:forKey)` 메소드로 딕셔너리에서 '키-값 쌍' 을 삭제합니다. 이 메소드는 '키-값 쌍' 이 존재하면 이를 삭제하고 삭제한 값을 반환하며, 값이 존재하지 않았으면 `nil` 을 반환합니다:

```swift
if let removedValue = airports.removeValue(forKey: "DUB") {
  print("The removed airport's name is \(removedValue).")
} else {
  print("The airports dictionary does not contain a value for DUB.")
}
// "The removed airport's name is Dublin Airport." 를 인쇄합니다.
```

#### Iterating Over a Dictionary (딕셔너리에 동작을 반복시키기)

딕셔너리에 있는 '키-값 쌍' 들은 `for`-`in` 반복문으로 '동작을 반복시킬 (iterate over)' 수 있습니다. 딕셔너리의 각 항목은 `(key, value)` 튜플로써 반환되며, 튜플의 '멤버 (member)' 는 '반복 회차 (iteration)' 마다 임시 상수나 변수로 분해할 수 있습니다:

```swift
for (airportCode, airportName) in airports {
  print("\(airportCode): \(airportName)")
}
// LHR: London Heathrow               
// YYZ: Toronto Pearson
```

`for`-`in` 반복문에 대한 더 자세한 내용은, [For-In Loops (For-In 반복문)]({% post_url 2020-06-10-Control-Flow %}#for-in-loops-for-in-반복문) 을 참고하기 바랍니다.

딕셔너리의 키와 값들은 `keys` 와 `values` 속성에 접근함으로써 '반복 가능한 집합체 (iterable collection)' 로 가져올 수도 있습니다:

```swift
for airportCode in airports.keys {
  print("Airport code: \(airportCode)")
}
// Airport code: LHR
// Airport code: YYZ

for airportName in airports.values {
  print("Airport name: \(airportName)")
}
// Airport name: London Heathrow
// Airport name: Toronto Pearson
```

딕셔너리의 키와 값들을 `Array` 인스턴스를 취하는 API 와 같이 사용할 필요가 있는 경우, `keys` 또는 `values` 속성으로 새로운 배열을 초기화 합니다:

```swift
let airportCodes = [String](airports.keys)
// airportCodes 는 ["LHR", "YYZ"] 입니다.

let airportNames = [String](airports.values)
// airportNames 은 ["London Heathrow", "Toronto Pearson"] 입니다.
```

스위프트의 `Dictionary` 타입은 '정의된 순서 (defined ordering)' 를 가지고 있지 않습니다. 지정된 순서로 딕셔너리의 키 또는 값들에 동작을 반복시키려면, `keys` 또는 `values` 속성에 `sorted()` 메소드를 사용합니다.

### 다음 장

[Control Flow (제어 흐름) > ]({% post_url 2020-06-10-Control-Flow %})

### 참고 자료

[^Collection-Types]: 원문은 [Collection Types](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^collections]: 'collection' 은 '집합', '묶음' 등 여러 가지 말로 옮길 수 있지만 여기서는 '집합체' 라는 말을 사용합니다. 이는 프로그래밍 용어에서 '객체', '구조체', '열거체' 등이 하나의 '타입' 을 의미하는 것에서 착안한 것입니다. '집합체' 는 어떤 성분들의 집합으로 이루어진 '타입' 이라고 이해하면 좋을 것 같습니다.

[^sets-type]: 'Sets' 은 수학 용어로써 그 자체로 '집합' 이라는 뜻을 가지고 있으며, 스위프트의 '셋 (sets)' 역시 수학에 있는 '집합 (sets)' 에서 유래한 개념입니다. 하지만, '집합' 이라고 하면 수학 용어인지 자료 타입인지 모호할 수 있으므로, 스위프트의 자료 타입임을 의미할 때는 '셋' 이라는 발음대로 옮기도록 합니다.

[^dictionaries-type]: 'dictionaries' 는 '사전' 이라고 옮길 수도 있는데, 타입이 실제 사전처럼 '키' 와 '값' 이라는 두 가지 성분으로 되어있습니다. 다만 '셋' 과 마찬가지로 '사전' 이라고 옮기면 다른 의미로 해석될 수 있으므로, 스위프트의 자료 타입 중 하나임을 의미하도록 '딕셔너리' 라고 발음 그대로 옮깁니다.

[^compatible]: 컴퓨터 용어로 '호환 가능 (compatible) 하다' 는 것은 '서로 같이 사용하거나 교체가 가능하다' 는 의미입니다. 예를 들어, 스위프트에서 `Float` 과 `Double` 타입은 '덧셈 연산자와 호환 가능' 하기 때문에, 두 값을 덧셈 연산자로 더할 수 있습니다. 본문에서 '호환 가능 (compatible) 하다' 는 표현을 사용한 것은, 두 값을 더할 때는 둘의 타입이 똑같을 필요는 없기 때문입니다.

[^literal]: 'literal' (글자 값) 은 '실제 글자로 표현된 값' 을 의미합니다. 예를 들어 `let a = 10` 이라고 하면 여기서 `10` 은 ASCII 코드로 된 문자 `1` 과 `0` 의 조합이지만 '실제 글자로 표현된 값' 은 정수 `10` 을 의미하므로, `a` 는 `Int` 타입으로 추론됩니다.

[^isEmpty-count]: 실제로, 스위프트는 배열, 셋, 또는 딕셔너리에 값이 비어 있는지 검사할 때는 `isEmpty` 를 사용하라고 합니다. `count` 는 값의 개수를 셀 때 사용하는 것입니다. 둘은 서로 목적이 다르며, 단순히 편리하기 때문에 `isEmpty` 를 사용하는 것은 아닙니다. 이는 [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) 에 있는 [Counting Characters (문자 개수 세기)](#counting-characters-문자-개수-세기) 에서 설명한 것처럼, `count` 를 사용할 경우 배열에 있는 전체 항목에 동작을 반복하는 과정이 필요할 수도 있기 때문입니다. 이에 대해서는 [isEmpty vs. count == 0](https://medium.com/better-programming/strings-comparison-isempty-vs-count-0-be80d701901b) 라는 글도 참고할만 합니다.

[^count-concurrent]: `shippingList.count` 는 현재 배열에 있는 전체 항목의 개수를 나타내는데, 이 값으로 새 항목을 추가하면 그 행위 자체가 다시 `count` 값을 바꾸게 됩니다. 즉 `count` 라는 변수에 값을 읽는 행위와 값을 쓰는 행위를 동시에 하려는 문제가 발생합니다. 즉 `shippingList.count` 는 유효한 색인이 아닙니다.

[^hashable]: 'hash' 는 '고기와 감자를 잘게 다져서 마구잡이로 섞어놓은 음식' 에서 유래한 말로 '많은 것들이 마구잡이로 뒤섞인 것' 을 말합니다. 'hashable' 은 이렇게 'hash 를 만들 수 있는' 이라는 의미를 가진 단어입니다. 이것을 컴퓨터 용어로 이해하면, 타입이 'hashable' 이라는 말은 '많은 양의 정보를 잘게 쪼개서 마구 뒤섞어 놓은 형태로 저장할 수 있는' 기능을 의미합니다. 우리말로 하자면 '(잘게) 다질 수 있는' 정도로 옮길 수 있겠지만, 컴퓨터 용어임을 의미하도록 '해시' 라고 발음대로 옮기도록 합니다.

[^hash-value]: 'hash value' 란 앞서 'hashable' 에서 살펴본 바와 같이, '잘게 쪼개고 뒤섞어서 다진 값' 정도로 이해할 수 있습니다. 역시 컴퓨터 용어임을 의미하도록 '해시 값' 이라고 발음대로 옮기도록 합니다.

[^set-array-literal]: '셋 글자 값 (set literal)' 이란 것이 따로 없기 때문에, 타입을 명시하지 않고 '배열 글자 값 (array literal)' 만 사용하면 타입을 `Array` 로 추론하게 됩니다.

[^set-operations]: 여기서는 'set' 을 '집합' 이라고 옮겼는데, '셋 (set)' 타입 자체가 수학에서의 '집합 (set)' 을표현하는 타입이기도 해서, 수학에서 다루는 '집합 연산' 을 하고자 할 때는 스위프트의 '셋 (set)' 타입을 사용하면 효율적으로 할 수 있다 정도로 이해하면 좋을 것 같습니다.

[^sets]: 여기서도 앞 부분과 마찬가지 이유로 'set' 을 '집합' 으로 옮깁니다.

[^disjoint]: 'disjoint' 는 수학에서 '분리' 또는 '서로 소' 라고 옮기는 것 같습니다. 영어로 [Disjoint sets](https://en.wikipedia.org/wiki/Disjoint_sets) 은 한글로 [서로 소 집합](https://ko.wikipedia.org/wiki/서로소_집합) 이라고 하지만, [분리 합집합](https://ko.wikipedia.org/wiki/분리_합집합) 이라는 용어가 있는 것을 보면, 'disjoint' 를 '분리' 라고 하는 것도 맞는 것 같습니다.

[^ordered-collection]: '순서 있는 집합체 (ordered collections)' 는 '정렬된 집합체 (sorted collection)' 와 다릅니다. 이 둘의 차이점에 대해서는, StackOverflow 의 [What is the difference between an ordered and a sorted collection?](https://stackoverflow.com/questions/1084146/what-is-the-difference-between-an-ordered-and-a-sorted-collection) 항목을 참고하기 바랍니다. 참고로 [Closures (클로저; 잠금 블럭)]({% post_url 2020-03-03-Closures %}) 장에 [The Sorted Method (정렬 메소드)]({% post_url 2020-03-03-Closures %}#the-sorted-method-정렬-메소드) 라는 항목이 따로 있기도 하므로, 'order 는 순서' 로, 'sort 는 정렬' 로 옮깁니다.

'순서가 있는 집합 (ordered set)' 은 '정렬된 집합 (sorted set)' 과는 수학적인 의미가 다릅니다. 

[^ordered-list]: '순서 있는 리스트 (ordered list)' 에서의 리스트는 자료 구조의 하나입니다. '리스트 (list) 자료 구조' 에 대한 더 많은 정보는, 위키피디아의 [List (abstract data type)](https://en.wikipedia.org/wiki/List_(abstract_data_type)) 항목과 [리스트 (컴퓨팅)](https://ko.wikipedia.org/wiki/리스트_(컴퓨팅)) 항목을 참고하기 바랍니다.

[^Foundation]: 'Foundation (기반)' 은 모든 스위프트 프로그래밍의 기반이 되는 프레임웍으로 `import Foundation` 으로 불러옵니다. 'Foundation 프레임웍' 에 대한 더 자세한 정보는, 애플 문서의 [Foundation](https://developer.apple.com/documentation/foundation) 항목을 참고하기 바랍니다.

[^Cocoa]: 'Cocoa (코코아)' 는 'Apple (애플) 에서 macOS 용으로 만든 API' 입니다. 하지만, [Cocoa Fundamentals Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/WhatIsCocoa/WhatIsCocoa.html) 항목을 보면 현재는 '그만둔 (Retired) 문서' 라고 설명합니다. 'M1 칩' 의 등장 이후로 '맥 (mac) 과 모바일 기기' 가 더 유사해 질 것이므로, 'Cocoa 프레임웍' 의 비중은 더 줄어드는 추세라고 이해할 수 있습니다.

[^iterate-over]: 여기서 '동작을 반복시킨다 (iterate over)' 시킨다는 말은 배열에 있는 모든 항목들마다 한 번씩 동작을 시킨다는 의미입니다.

[^no-defined-ordering]: '정의된 순서없이 (no defined ordering)' 라는 말도 '정렬되지 않은 채로' 라고 옮길 수도 있지만, 'ordered collections'[^ordered-collection] 과 같이, 'sorted' 와의 구별을 위해 '순서가 없이' 라고 옮깁니다.

[^empty-array-literal]: '빈 셋 글자 값 (empty set literal)' 이 아니라 '빈 배열 글자 값 (empty array literal)' 입니다. '빈 셋 글자 값' 같은 건 따로 없고, '빈 배열 글자 값' 을 그대로 사용합니다.

[^set]: 여기서의 '셋 (set)' 은 수학에서 말하는 '집합 (set)' 과 같은 의미로 사용되었다고 볼 수 있습니다. 실제 자료 구조로써의 '셋 (set)' 은 수학에서의 '집합 (set)' 을 구현하고 있는 것입니다.

[^intersection]: 원래는 메소드의 이름이 `intersect` 였는데, `intersection` 으로 바뀌었습니다. 이는 애플의 [API Design Guidelines (API 설계 지침)]({% post_url 2020-09-15-API-Design-Guidelines %}) 에 있는 [Strive for Fluent Usage (자연스러운 사용법이 되도록 노력하기)]({% post_url 2020-09-15-API-Design-Guidelines %}#strive-for-fluent-usage-자연스러운-사용법이-되도록-노력하기) 에서 설명한 규칙에 맞추기 위함으로 보입니다. 즉, 메소드의 이름을 '명사' 나 '분사' 형태로 만들어서 원본이 변경되지 않음을 나타낸 것입니다.

[^symmetric-difference]: 원래는 메소드의 이름이 `exclusiveOr` 였는데, `symmetricDifference` 로 바뀌었습니다. 앞서와 마찬가지로 애플의 [API Design Guidelines (API 설계 지침)]({% post_url 2020-09-15-API-Design-Guidelines %}) 에 있는 [Strive for Fluent Usage (자연스러운 사용법이 되도록 노력하기)]({% post_url 2020-09-15-API-Design-Guidelines %}#strive-for-fluent-usage-자연스러운-사용법이-되도록-노력하기) 에서 설명한 규칙에 맞추기 위함으로 보입니다. 즉, 메소드의 이름을 '명사' 나 '분사' 형태로 만들어서 원본이 변경되지 않음을 나타낸 것입니다.

[^subtracting]: 원래는 메소드의 이름이 `subtract` 였는데, `subtracting` 으로 바뀌었습니다. 역시 마찬가지로 애플의 [API Design Guidelines (API 설계 지침)]({% post_url 2020-09-15-API-Design-Guidelines %}) 에 있는 [Strive for Fluent Usage (자연스러운 사용법이 되도록 노력하기)]({% post_url 2020-09-15-API-Design-Guidelines %}#strive-for-fluent-usage-자연스러운-사용법이-되도록-노력하기) 에서 설명한 규칙에 맞추기 위함으로 보입니다. 즉, 메소드의 이름을 '명사' 나 '분사' 형태로 만들어서 원본이 변경되지 않음을 나타낸 것입니다.

[^subset]: '하위 집합 (subset)' 은 수학에서 말하는 '부분 집합' 입니다. 다만, 'subset' 에 대응되는 'superset' 에 대한 명확한 우리말이 없는 것 같아서, 여기서는 일단 '상위 집합 (superset)' 과의 대응의 의미로 '하위 집합 (subset)' 이라고 옮깁니다. 영어로 '부분집합' 은 'subset' 이라고 하고, 그 반대는 'superset' 이라고 한다고 이해하면 될 것입니다.

[^IATA]: 본문에 있는 '국제 항공 운송 협회 (International Air Transport Association)' 는 예제를 위한 것이 아니라 실제로 존재하는 협회입니다. 이 협회의 홈페이지는 [https://www.iata.org](https://www.iata.org) 입니다.
