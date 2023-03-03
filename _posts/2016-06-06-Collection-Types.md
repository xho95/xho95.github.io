---
layout: post
comments: true
title:  "Collection Types (집합체 타입)"
date:   2016-06-06 19:45:00 +0900
categories: Swift Grammar Collection Array Set Dictionary
redirect_from: "/swift/grammar/collection/array/set/dictionary/2016/06/06/Collection-Types.html"
---

{% include header_swift_book.md %}

## Collection Types (집합체 타입)

스위프트는, 배열[^arrays-type] 과, 셋[^sets-type], 및 딕셔너리[^dictionaries-type] 라는, 세 개의 으뜸가는 _집합체 타입 (collection types)_[^collections] 을 제공하여, 값의 집합체를 저장합니다. 배열은 순서 있는 값들의 집합체[^ordered-collection] 입니다. 셋은 순서 없는 유일한 값들의 집합체입니다. 딕셔너리는 순서 없는 키-값 결합들 [^key-value-associations] 의 집합체입니다.

![Array-Set-Dictionary](/assets/Swift/Swift-Programming-Language/Collection-Types-array-set-dictionary.jpg)

스위프트의 배열과, 셋, 및 딕셔너리에 저장할 수 있는 값 및 키의 타입은 항상 명확합니다. 이는 실수로 잘못된 타입 값을 집합체에 집어 넣을 순 없다는 걸 의미합니다. 집합체에서 가져올 값의 타입에 자신감을 가져도 된다는 의미이기도 합니다.

> 스위프트의 배열과, 셋, 및 딕셔너리 타입은 _일반화 집합체 (generic collections)_ 로 구현되어 있습니다. 일반화 타입 및 집합체에 대한 더 많은 내용은, [Generics (일반화)]({% link docs/swift-books/swift-programming-language/generics.md %}) 장을 보기 바랍니다.

### Mutability of Collections (집합체의 변경 가능성)

배열이나, 셋, 또는 딕셔너리를 생성하고, 이를 변수에 할당한다면, 생성한 집합체는 _변경 가능 (mutable)_ 할 겁니다. 이는 집합체를 생성한 후엔 집합체 안의 항목을 추가하거나, 삭제, 또는 바꿈으로써 이를 바꿀 수 (또는 _변경 (mutate)_ 할 수) 있다는 의미입니다. 배열이나, 셋, 또는 딕셔너리를 상수에 할당한다면, 그 집합체는 _변경 불가능 (immutable)_ 이라, 크기와 내용물을 바꿀 수 없습니다.

> 바꿀 필요가 없는 모든 집합체는 변경 불가능한 집합체로 생성하는게 좋은 습관입니다. 그렇게 하면 코드를 파악하는게 쉬워지며 스위프트 컴파일러가 생성한 집합체의 성능을 최적화할 수 있게 합니다.

### Arrays (배열)

_배열 (array)_ 은 똑같은 타입의 값을 순서 있는 리스트[^list] 에 저장합니다. 배열에선 똑같은 값이 서로 다른 위치에 여러 번 나타날 수 있습니다.

> 스위프트의 `Array` 타입은 **Foundation**[^Foundation] 의 `NSArray` 클래스와 연동됩니다.
>
> **Foundation** 및 **Cocoa** 와 사용하는 `Array` 에 대한 더 많은 정보는, [Bridging Between Array and NSArray](https://developer.apple.com/documentation/swift/array#2846730) 항목을 보기 바랍니다.

#### Array Type Shorthand Syntax (배열 타입을 짧게 줄인 구문)

스위프트 배열 타입은 완전체로 `Array<Element>` 라고 작성하는데, 여기서 `Element` 는 배열에 저장을 허용한 값의 타입입니다. 배열 타입은 `[Element]` 라는 짧게 줄인 형식으로 작성할 수도 있습니다. 두 형식의 기능은 정체가 같지만, 짧게 줄인 형식이 더 좋으며 이 안내서 전체에 걸쳐 배열 타입을 참조할 땐 이를 사용합니다.

#### Creating an Empty Array (빈 배열 생성하기)

특정 타입의 빈 배열은 초기자 구문으로 생성할 수 있습니다:

```swift
var someInts = [Int]()
print(("someInts is of type [Int] with \(someInts.count) items.")
// "someInts is of type [Int] with 0 items." 를 인쇄함
```

`someInts` 변수의 타입은 초기자 타입으로부터 `[Int]` 로 추론한다는 걸 기록하기 바랍니다.

대안으로, 이미 타입 정보를 제공한, 함수 인자 또는 이미 타입을 지정한 변수나 상수 같은, 상황이면, 빈 배열 글자 값[^empty-array-literal] 으로 빈 배열을 생성할 수 있는데, 이는 `[]` (비어 있는 한 쌍의 빈 대괄호) 로 작성합니다:

```swift
someInts.append(3)
// someInts 는 이제 Int 타입 값 1 개를 담음
someInts = []
// someInts 는 이제 빈 배열이지만, 여전히 [Int] 타입임
```

#### Creating an Array with a Default Value (기본 값으로 배열 생성하기)

스위프트의 `Array` 타입은 특정 크기면서 자신의 모든 값에 동일한 기본 값을 설정한 배열을 생성하는 초기자도 제공합니다. 이 초기자엔 적절한 타입의 (`repeating` 이라는) 기본 값: 과 새 배열에서 그 값을 반복할 (`count` 라는) 횟수를 전달합니다: 

```swift
var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles 은 [Double] 타입이고, [0.0, 0.0, 0.0] 와 같음
```

#### Creating an Array by Adding Two Arrays Together (두 배열을 함께 더하여 배열 생성하기)

덧셈 연산자 (`+`) 와 호환 가능한[^compatible] 타입의 두 기존 배열을 함께 더해서 새로운 배열을 생성할 할 수도 있습니다. 새 배열의 타입은 함께 더한 두 배열 타입으로 추론합니다:

```swift
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles 은 [Double] 타입이고, [2.5, 2.5, 2.5] 와 같음

var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles 은 [Double] 타입이라 추론하며, [0.0, 0,0, 0.0, 2.5, 2.5, 2.5] 와 같음
```

#### Creating an Array with an Array Literal (배열 글자 값으로 배열 생성하기)

_배열 글자 값 (array literal)_[^literal] 으로 배열을 초기화할 수도 있는데, 이는 짧게 줄인 방식으로 하나 이상의 값으로 배열 집합체를 작성하게 합니다. 배열 글자 값을 작성하려면, 쉼표로 구분한, 값의 목록을, 대괄호 쌍으로 둘러싸면 됩니다:

&nbsp;&nbsp;&nbsp;&nbsp;[`value 1-값 1`, `value 2-값 2`, `value 3-값 3`]

아래 예제는 `shoppingList` 라는 배열을 생성하여 `String` 값을 저장합니다:

```swift
var shoppingList: [String] = ["Eggs", "Milk"]
// shoppingList 를 두 개의 초기 항목으로 초기화됨
```

`shoppingList` 변수는 "문자열 값 배열" 이라 선언하고, `[String]` 이라고 씁니다. 이 특별한 배열엔 `String` 이라는 값 타입을 지정했기 때문에, `String` 값만 저장을 허용합니다. 여기선, 배열 글자 값 안에 작성한, (`"Eggs"` 와 `"Milk"` 라는) 두 `String` 값으로 `shoppingList` 배열을 초기화 합니다.

> `shoppingList` 배열은 (`let` 도입자[^introducer] 를 쓰는) 상수가 아니라 (`var` 도입자를 쓰는) 변수로 선언하는데 아래 예제에서 구매 목록 (shopping list) 에 더 많은 항목을 추가하기 때문입니다.

이 경우, 배열 글자 값은 두 `String` 값 외엔 아무 것도 담지 않습니다. 이는 `shoppingList` 변수가 선언한 타입 (인 `String` 값만 담을 수 있는 배열) 과 맞아서, 배열 글자 값 할당을 `shoppingList` 를 두 초기 항목으로 초기화하는 방식으로 허가합니다.

고맙게도 스위프트의 타입 추론 덕분에, 동일 타입 값을 담은 배열 글자 값으로 초기화한다면 배열 타입은 작성하지 않아도 됩니다. `shoppingList` 초기화는 더 짧은 형식으로 대신 작성할 수도 있을 겁니다:

```swift
var shoppingList = ["Eggs", "Milk"]
```

배열 글자 값 안의 모든 값이 똑같은 타입이기 때문에, `[String]` 이 `shoppingList` 변수에 사용할 올바른 타입이라는 걸 스위프트가 추론할 수 있습니다.

#### Accessing and Modifying an Array (배열 접근 및 수정하기)

배열은 메소드와 속성을 통하거나, 첨자 구문을 써서, 접근하고 수정합니다.

배열의 항목 개수를 찾아내려면, 읽기-전용 속성인 `count` 를 검사합니다:

```swift
print("The shopping list contains \(shoppingList.count) items.")
// "The shopping list contains 2 items." 를 인쇄함
```

`count` 속성이 `0` 인지 검사하는 건 그 줄임말인 `isEmpty` 불리언 속성을 사용합니다[^isEmpty-count]:

```swift
if shoppingList.isEmpty {
  print("The shopping list is empty.")
} else {
  print("The shopping list is not empty.")
}
// "The shopping list is not empty." 를 인쇄함
```

배열 끝에 새로운 항목을 덧붙이려면 배열의 `append(_:)` 메소드를 호출하면 됩니다:

```swift
shoppingList.append("Flour")
// shoppingList 은 이제 3 개의 항목을 담는데, 누군가 팬케이크를 만드는가 봅니다.
```

대안으로, 호환되는 하나 이상의 항목을 가진 배열은 덧셈 할당 연산자 (`+=`) 로 덧붙입니다:

```swift
shoppingList += ["Baking Powder"]
// shoppingList 가 담은 항목은 이제 4 개임
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
// shoppingList 가 담은 항목은 이제 7 개임
```

배열에서 값을 가져오는건 _첨자 구문 (subscript syntax)_ 을 쓰는데, 가져오고 싶은 값의 색인을 배열 이름 바로 뒤의 대괄호 안에 전달하면 됩니다:

```swift
var firstItem = shoppingList[0]
// firstItem 은 "Eggs" 와 같음
```

> 배열 첫 번째 항목의 색인은, `1` 이 아니라, `0` 입니다. 스위프트의 배열은 항상 0 기반-색인[^zero-indexed] 입니다.

첨자 구문을 사용하면 주어진 색인에 있는 기존 값을 바꿀 수 있습니다:

```swift
shoppingList[0] = "Six eggs"
// 목록의 첫 번째 항목은 이제 "Eggs" 라기 보단 "Six eggs" 와 같음
```

첨자 구문을 사용할 땐, 지정한 색인이 유효할 필요가 있습니다. 예를 들어, 배열 끝에 항목을 덧붙이려고 `shoppingList[shoppingList.count] = "Salt"` 라고 쓰면 결과는 실행 시간 에러입니다.[^count-runtime-error]

첨자 구문을 사용하면, 교체할 값 집합 길이가 교체될 범위와 다르더라도, 한번에 일정 범위의 값을 바꿀 수 있습니다. 다음 예제는 `"Chocolate Spread"` 와, `"Cheese"`, 및 `"Butter"` 를 `"Bananas"` 와 `"Apples"` 로 교체합니다:

```swift
shoppingList[4...6] = ["Bananas", "Apples"]
// shoppingList 가 담은 항목은 이제 6 개임
```

항목을 배열에서 지정한 색인에 집어 넣으려면, 배열의 `insert(_:at:)` 메소드를 호출합니다:

```swift
shoppingList.insert("Maple Syrup", at: 0)
// shoppingList 가 담은 항목은 이제 7 개임
// 이제 "Maple Syrup" 이 목록의 첫 번째 항목임
```

이렇게 호출한 `insert(_:at:)` 메소드는 값이 `"Maple Syrup"` 인 새 항목을 구매 목록의 맨 앞인, 색인 `0` 으로 지시한 곳, 에 집어 넣습니다.

이와 비슷하게, 배열에서 항목을 제거하는 건 `remove(at:)` 메소드로 합니다. 이 메소드는 지정한 색인의 항목을 제거하고 제거한 항목을 반환합니다 (물론 필요 없다면 반환 값을 무시할 수 있긴 합니다):

```swift
let mapleSyrup = shoppingList.remove(at: 0)
// 색인 0 에 있던 항목을 방금 제거했음
// shoppingList 가 담은 항목은 이제 6 개며, Maple Syrup 이 없음
// 이제 mapleSyrup 상수는 제거한 문자열인 "Maple Syrup" 과 같음
```

> 기존 배열 경계 밖에 있는 색인의 값에 접근하거나 수정하려 하면, 실행 시간 에러를 발생시킬 겁니다. 색인이 유효한지 검사하려면 사용 전에 배열의 `count` 속성과 비교하면 됩니다. 배열에서 유효한 색인으로 가장 큰 건 `count - 1` 인데 이는 배열 색인이 0-기반 색인이기 때문입니다-하지만, `count` 가 (빈 배열을 의미하는) `0` 일 땐, 유효한 색인은 아무 것도 없습니다.

배열에서 항목을 제거할 땐 어떤 빈틈도 메꾸므로, 색인 `0` 의 값은 다시 한 번 `"Six eggs"` 와 같습니다:

```swift
firstItem = shoppingList[0]
// 이제 firstItem 은 "Six eggs" 임
```

배열에서 최종 항목을 제거하고 싶으면, `remove(at:)` 메소드 보단 `removeLast()` 메소드를 사용하여 배열의 `count` 속성을 조회할 필요를 피하도록 합니다. `remove(at:)` 메소드 같이, `removeLast()` 메소드도 제거한 항목을 반환합니다:

```swift
let apples = shoppingList.removeLast()
// 배열 마지막 항목을 방금 제거했음
// shoppingList 가 담은 항목은 이제 5 개며, apple 은 없음
// 이제 apples 상수는 제거한 문자열인 "Apples" 와 같음
```

#### Iterating Over an Array (배열 반복하기)

`for`-`in` 반복문으로 배열 안의 전체 값 집합을 반복할 수 있습니다:

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

각각의 정수 색인도 그 값만큼 필요하다면, 그 대신 `enumerated()` 메소드로 배열을 반복합니다. 배열 안의 각 항목마다, `enumerated()` 메소드가 정수와 항목을 합성한 튜플을 반환합니다. 정수는 0 에서 시작해서 각각의 항목마다 하나씩 위로 세며; 배열 전체를 열거[^enumerate] 한다면, 이러한 정수는 항목의 색인과 맞습니다. 매 반복 부분마다 튜플을 임시 상수나 변수로 분해할 수 있습니다:

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

`for`-`in` 반복문에 대한 더 많은 건, [For-In Loops (For-In 반복문)]({% link docs/swift-books/swift-programming-language/control-flow.md %}#for-in-loops-for-in-반복문) 부분을 보기 바랍니다.

### Sets (셋)

_셋 (set)_ 은 똑같은 타입의 별개 값을 아무런 순서 없이[^with-no-defined-ordering] 집합체에 저장합니다. 항목의 순서가 중요하지 않거나, 한 항목이 한 번만 나타나는 걸 보장할 필요가 있을 때 배열 대신 셋을 사용할 수 있습니다.

> 스위프트의 `Set` 타입은 **Foundation** 의 `NSSet` 클래스와 연동됩니다.
>
> **Foundation** 및 **Cocoa** 와 사용하는 `Set` 에 대한 더 많은 정보는, [Bridging Between Set and NSSet](https://developer.apple.com/documentation/swift/set#2845530) 항목을 보기 바랍니다.

#### Hash Values for Set Types (셋 타입의 해시 값)

타입은 반드시 _해시 가능 (hashable)_[^hashable] 해야 셋에 저장됩니다-즉, 타입은 반드시 스스로 _해시 값 (hash value)_[^hash-value] 을 계산할 방법을 제공해야 합니다. 비교해서 같은 모든 객체의 해시 값은 똑같은 하나의 `Int` 값이어서, `a == b` 이면, `a` 의 해시 값과 `b` 의 해시 값이 같습니다.

스위프트의 (`String` 과, `Int`, `Double`, 및 `Bool` 같은) 모든 기본 타입은 기본적으로 해시 가능하며, 셋의 값 타입 또는 딕셔너리의 키 타입으로 사용할 수 있습니다. ([Enumerations (열거체)]({% link docs/swift-books/swift-programming-language/enumerations.md %}) 에서 설명한 것처럼) 결합 값이 없는 열거체 case 값도 기본적으로 해시 가능합니다.   

> 자신만의 타입을 셋의 값 타입 또는 딕셔너리 키 타입으로 사용하려면 스위프트 표준 라이브러리의 `Hashable` 프로토콜을 준수하게 하면 됩니다. 필수인 `hash(into:)` 메소드를 구현하기 위한 정보는, [Hashable](https://developer.apple.com/documentation/swift/hashable) 을 보기 바랍니다. 프로토콜을 준수하기 위한 정보는, [Protocols (프로토콜; 규약)]({% link docs/swift-books/swift-programming-language/protocols.md %}) 을 보기 바랍니다.

#### Set Type Syntax (셋 타입 구문)

스위프트의 셋 타입은 `Set<Element>` 라고 작성하며, 여기서 `Element` 는 셋이 저장을 허용한 타입입니다. 배열과 달리, 셋은 짧게 줄인 형식 같은게 없습니다.

#### Creating and Initializing an Empty Set (빈 셋 생성하고 초기화하기)

특정 타입의 빈 셋을 생성하려면 초기자 구문을 사용합니다:

```swift
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
// "letters is of type Set<Character> with 0 items." 을 인쇄함
```

> 초기자의 타입으로부터, `letters` 변수 타입을 `Set<Character>` 라고 추론합니다.

대안으로, 함수 인자 또는 이미 타입을 지정한 변수나 상수 같이, 이미 타입 정보를 제공한 상황이라면, 빈 배열 글자 값[^empty-array-literal] 으로 빈 셋을 생성할 수 있습니다:

```swift
letters.insert("a")
// letters 는 이제 Character 타입인 값을 1개 담음
letters = []
// 이제 letters 는 빈 셋이지만, 여전히 Set<Character> 타입임
```

#### Creating a Set with an Array Literal (배열 글자 값으로 셋 생성하기)

셋은 배열 글자 값[^set-array-collection] 으로 초기화할 수도 있는데, 짧게 줄인 방식으로 하나 이상의 값으로 셋 집합체를 작성합니다.

아래 예제는 `favoriteGenres` 라는 셋을 생성하여 `String` 값을 저장합니다:

```swift
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip Hop"]
// favoriteGenres 를 세 개의 초기 항목으로 초기화했음
```

`favoriteGenres` 변수는, `Set<String>` 을 써서, "`String` 값의 셋” 이라고 선언합니다. 이 특별한 셋에는 `String` 값 타입을 지정했기 때문에, `String` 값의 저장 _만 (only)_ 허용합니다. 여기선, 배열 글자 값 안에 쓴, 세 개의 `String` 값 (인 `"Rock"` 과, `"Classical"`, 및 `"Hip hop"`) 으로 `favoriteGenres` 셋을 초기화 합니다.

> `favoriteGenres` 셋을 (`let` 도입자인) 상수가 아니라 (`var` 도입자인) 변수로 선언한 건 아래 예제에서 항목을 추가 및 제거하기 때문입니다.

배열 글자 값 홀로는 셋 타입으로 추론할 수 없으므로[^set-array-literal], 반드시 `Set` 타입을 명시하여 선언해야 합니다. 하지만, 스위프트의 타입 추론 때문에, 초기화하는 배열 글자 값에 단 하나의 타입 값만 담겨 있으면 셋의 원소 타입을 작성하지 않아도 됩니다. `favoriteGenres` 초기화는 더 짧은 형식으로 대신 작성할 수 있을 겁니다:

```swift
var favoriteGenres: Set = ["Rock", "Classical", "Hip Hop"]
```

배열 글자 값 안의 모든 값이 똑같은 타입이기 때문에, `Set<String>` 이 `favoriteGenres` 변수에 사용할 올바른 타입이라는 걸 스위프트가 추론할 수 있습니다.

#### Accessing and Modifying a Set (셋 접근 및 수정하기)

셋의 메소드와 속성을 통해서 접근하고 수정합니다.

셋의 항목 개수를 알아 내려면, 읽기-전용 속성인 `count` 를 검사합니다:

```swift
print("I have \(favoriteGenres.count) favorite music genres.")
// "I have 3 favorite music genres." 를 인쇄함
```

`count` 속성이 `0` 인지 검사하는 건 그 줄임말인 `isEmpty` 불리언 속성을 사용합니다:

```swift
if favoriteGenres.isEmpty {
  print("As far as music goes, I'm not picky.")
} else {
  print("I have particular music preferences.")
}
// "I have particular music preferences." 를 인쇄함
```

셋 안에 새로운 항목을 추가하려면 셋의 `insert(_:)` 메소드를 호출하면 됩니다:

```swift
favoriteGenres.insert("Jazz")
// favoriteGenres 가 담은 항목은 이제 4 개임
```

셋에서 항목을 제거하려면 셋의 `remove(_:)` 메소드를 호출하는데, 항목이 셋의 멤버면 이를 제거하고, 제거한 값을 반환하나, 셋에 담겨 있지 않으면 `nil` 을 반환합니다. 대안으로는, 셋의 모든 항목을 `removeAll()` 메소드로 제거할 수 있습니다.

```swift
if let removeGenres = favoriteGenres.remove("Rock") {
  print("\(removeGenres)? I'm over it.")
} else {
  print("I never much cared for that.")
}
// "Rock? I'm over it." 를 인쇄함
```

셋이 특별한 항목을 담고 있는지 검사하려면, `contains(_:)` 메소드를 사용합니다.

```swift
if favoriteGenres.contains("Funk") {
  print("I get up on the good foot.")
} else {
  print("It's too funky in here.")
}
// "It's too funky in here." 를 인쇄함
```

#### Iterating Over a Set (셋 반복하기)

`for`-`in` 반복문으로 셋 안의 값을 반복할 수 있습니다.

```swift
for genre in favoriteGenres {
  print("\(genre)")
}
// Classical
// Jazz
// Hip Hop
```

`for`-`in` 반복문에 대한 더 많은 건, [For-In Loops (For-In 반복문)]({% link docs/swift-books/swift-programming-language/control-flow.md %}#for-in-loops-for-in-반복문) 을 보기 바랍니다.

스위프트의 `Set` 타입은 순서를 정의하지 않습니다. 셋 값을 정해진 순서로 반복하려면, `sorted()` 메소드를 사용하는데, 이는 `<` 연산자로 정렬한 배열로 셋의 원소를 반환합니다.

```swift
for genre in favoriteGenres.sorted() {
  print("\(genre)")
}
// Classical
// Hip Hop
// Jazz
```

### Performing Set Operations (집합 연산하기)

(셋으로는) 기본적인 집합 연산 (set operations)[^set-operations] 을 효율적으로 할 수 있는데, 이는 두 집합을 서로 조합하기나, 두 집합의 공통 값 결정하기, 또는 두 집합이 담은 값 중에서 똑같은게 모두인지, 일부인지, 아무것도 없는지 결정하기 등 입니다.

### Fundamental Set Operations (기본적인 집합 연산)

아래 삽화는 두 집합-`a` 와 `b`-에 다양한 집합 연산을 한 결과를 음영으로 그려서 나타냅니다.

![Fundamental-Set-Operations](/assets/Swift/Swift-Programming-Language/Collection-Types-fundamental-set-operations.jpg)

* `intersection(_:)`[^intersection] 메소드를 사용하면 두 집합에 공통인 값만으로 새 집합을 생성합니다.
* `symmetricDifference(_:)`[^symmetric-difference] 메소드를 사용하면 각 집합에는 있지만, 둘 다에 있지는 않은 값으로 새 집합을 생성합니다.
* `union(_:)` : 메소드를 사용하면 두 집합의 모든 값으로 새 집합을 생성합니다.
* `subtracting(_:)`[^subtracting] 메소드를 사용하면 지정한 집합에는 없는 값으로 새 집합을 생성합니다.

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

### Set Membership and Equality (집합의 포함 관계 및 같음)

아래 삽화는 세 집합-`a` 와, `b`, 및 `c`-의 겹치는 지역으로 집합 사이의 공유 원소를 그려서 나타냅니다. 집합 `a` 는 집합 `b` 의 _상위 집합 (superset)_ 인데, `a` 가 `b` 의 모든 원소를 담고 있기 때문입니다. 거꾸로, 집합 `b` 는 집합 `a` 의 _하위 집합 (subset)_[^subset] 인데, `b` 안의 모든 원소가 `a` 에도 담겨 있기 때문입니다. 집합 `b`와 집합 `c`는 서로 _분리 (disjoint)_[^disjoint] 라고 하며, 이는 공유하는 공통 원소가 없기 때문입니다.

![Set-Membership-and-Equality](/assets/Swift/Swift-Programming-Language/Collection-Types-set-membership-and-equality.jpg)

* “같음 (`==`)” 연산자를 사용하면 두 집합에 담긴 값이 모두 똑같은지 결정합니다.
* `isSubset(of:)` 메소드를 사용하면 햔 집합의 모든 값이 지정한 집합에도 담겨 있는지 결정합니다.
* `isSuperset(of:)` 메소드를 사용하면 지정한 집합의 모든 값이 한 집합에도 담겨 있는지 결정합니다.
* `isStrictSubset(of:)` 이나 `isStrictSuperset(of:)` 메소드를 사용하면 한 집합이, 지정한 집합과, 같지 않은, 하위 집합 또는 상위 집합인지 결정합니다.[^subset-or-superset]
* `isDisjoint(with:)` 메소드를 사용하면 두 집합에 공통인 값은 없는지 결정합니다.

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

_딕셔너리 (dictionary)_ 는 동일한 타입의 키와 동일한 타입의 값 사이의 결합 (associations) 을 아무런 순서 없이 집합체에 저장합니다. 각각의 값은 유일한 _키 (key)_ 와 결합되는데, 이는 딕셔너리 안에서 그 값의 식별자[^identifier] 처럼 행동합니다. 배열 항목과 달리, 딕셔너리 항목엔 지정된 순서가 없습니다. 자신의 식별자를 기반으로 값을 찾아볼 필요가 있을 때 딕셔너리를 사용하는데, 이는 실제-세계에서 사전[^dictionary] 을 사용하여 한 특별한 단어의 정의를 찾아 보는 것과 거의 똑같은 방식입니다.

> 스위프트의 `Dictionary` 타입은 **Foundation** 의 `NSDictionary` 클래스와 연동됩니다.
>
> **Foundation** 및 **Cocoa** 와 사용하는 `Dictionary` 에 대한 더 많은 정보는, [Bridging Between Dictionary and NSDictionary](https://developer.apple.com/documentation/swift/dictionary#2846239) 항목을 보기 바랍니다.


#### Dictionary Type Shorthand Syntax (딕셔너리 타입을 짧게 줄인 구문)

스위프트의 딕셔너리 타입은 완전체로 `Dictionary<Key, Value>` 라고 작성하는데, 여기서 `Key` 는 딕셔너리 키로 쓸 수 있는 값의 타입이고, `Value` 는 딕셔너리가 그 키에 저장할 값의 타입입니다.

> 딕셔너리 `Key` 타입은, 셋의 값 타입 처럼, 반드시 `Hashable` 프로토콜을 준수해야 합니다.

딕셔너리 타입은 `[Key: Value]` 라는 짧게 줄인 형식으로 작성할 수도 있습니다. 두 형식의 기능은 정체가 같지만, 짧게 줄인 형식이 더 좋으며 이 안내서 전체에 걸쳐 딕셔너리 타입을 참조할 땐 이를 사용합니다.

#### Creating an Empty Dictionary (빈 딕셔너리 생성하기)

배열에서 처럼, 특정 타입의 빈 `Dictionary` 을 생성하려면 초기자 구문을 사용하면 됩니다:

```swift
var namesOfIntegers = [Int: String]()
// namesOfIntegers 는 빈 [Int: String] 딕셔너리임
```

이 예제는 [Int: String]` 타입의 빈 딕셔너리를 생성하여 정수 값을 사람이-읽을 수 있는 이름으로 저장합니다. 키는 `Int` 타입이고, 값은 `String` 타입입니다.

이미 타입 정보를 제공한 상황이면, 빈 딕셔너리를 빈 딕셔너리 글자 값[^empty-dictionary-literal] 으로 생성할 수 있는데, 이는 `[:]` (한 쌍의 대괄호 안의 콜론) 이라고 씁니다:

```swift
namesOfIntegers[16] = "sixteen"
// namesOfIntegers 는 이제 1 개의 키-값 쌍을 담음
namesOfIntegers = [:]
// namesOfIntegers 는 다시 한 번 [Int: String] 타입의 빈 딕셔너리임
```

#### Creating a Dictionary with a Dictionary Literal (딕셔너리 글자 값으로 딕셔너리 생성하기)

_딕셔너리 글자 값 (dictionary literal)_ 으로 딕셔너리를 초기화할 수도 있는데, 구문은 앞서 본 배열 글자 값과 비슷합니다. 딕셔너리 글자 값은 짧게 줄인 방식으로 하나 이상의 키-값 쌍으로 `Dictionary` 집합체를 작성하게 합니다.

_키-값 쌍 (key-value pair)_ 은 키와 값을 조합한 겁니다. 딕셔너리 글자 값에서, 각각의 키-값 쌍 안의 키와 값은 콜론으로 구분합니다. 키-값 쌍은, 쉼표로 구분한, 목록을, 한 쌍의 대괄호로 둘러싸서 작성합니다:

&nbsp;&nbsp;&nbsp;&nbsp;[`key 1-키 1`: `value 1-값 1`, `key 2-키 2`: `value 2-값 2`, `key 3-키 3`: `value 3-값 3`]

아래 예제는 딕셔너리를 생성하여 국제 공항의 이름을 저장합니다. 이 딕셔너리에서, 키는 세-글자짜리 국제 항공 운송 협회 코드[^IATA] 이고, 값은 공항 이름입니다:

```swift
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
```

`airport` 딕셔너리는 `[String: String]` 타입이라고 선언하는데, 이는 "키가 `String` 타입이고, 값도 `String` 타입인 `Dictionary`" 를 의미합니다.

> `airport` 딕셔너리를, (`let` 도입자인) 상수가 아니라, (`var` 도입자인) 변수로 선언한 건, 아래 예제에서 딕셔너리에 더 많은 공항을 추가하기 때문입니다.

`airports` 딕셔너리를 초기화하는 건 두 개의 키-값 쌍을 담은 딕셔너리입니다. 첫 번째 쌍은 키가 `"YYZ"` 이고 값은 `"Toronto Pearson"` 입니다. 두 번째 쌍은 키가 `"DUB"` 이고 값은 `"Dublin"` 입니다.

이 딕셔너리 글자 값은 두 개의 `String: String` 쌍을 담습니다. 이 키-값 타입은 `airports` 변수 선언의 (키는 `String` 만, 값은 `String` 만인 딕셔너리) 타입과 맞아서, 배열 글자 값을 할당하여 두 초기 항목으로 `airports` 딕셔너리를 초기화하는 방식을 허가합니다.

배열에서 처럼, 일관된 타입의 키와 값을 가진 딕셔너리 글자 값으로 초기화한다면 딕셔너리 타입을 작성하지 않아도 됩니다. `airports` 초기화는 더 짧은 형식으로 대신 작성할 수도 있을 겁니다:

```swift
var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
```

글자 값 안의 모든 키가 서로 같은 타입이고, 마찬가지로 모든 값이 서로 같은 타입이기 때문에, `[String: String]` 이 `airports` 딕셔너리에 사용할 올바른 타입이라는 걸 스위프트가 추론할 수 있습니다.

#### Accessing and Modifying a Dictionary (딕셔너리 접근 및 수정하기)

딕셔너리는 메소드와 속성을 통하거나, 첨자 구문을 써서, 접근하고 수정합니다.

배열에서 처럼, `Dictionary` 의 항목 개수를 찾아내려면 읽기-전용 속성인 `count` 를 검사하면 됩니다:

```swift
print("The airports dictionary contains \(airports.count) items.")
// "The airports_2 dictionary contains 2 items." 를 인쇄함
```

`count` 속성이 `0` 인지 검사하는 건 그 줄임말인 `isEmpty` 불리언 속성을 사용합니다:

```swift
if airports.isEmpty {
  print("The airports dictionary is empty.")
} else {
  print("The airports dictionary is not empty.")
}
// "The airports dictionary is not empty." 를 인쇄함
```

딕셔너리에 새 항목을 추가하는 건 첨자 구문으로 할 수 있습니다. 적절한 타입의 새로운 키를 첨자 색인으로 사용하고, 적절한 타입의 새 값을 할당하면 됩니다:  

```swift
airports["LHR"] = "London"
// 이제 airports 딕셔너리는 3개의 항목을 담음
```

첨자 구문으로 한 특별한 키와 결합된 값을 바꿀 수도 있습니다:

```swift
airports["LHR"] = "London Heathrow"
// "LHR" 의 값을 "London Heathrow" 로 바꿨음
```

첨자의 대안으로는, 딕셔너리의 `updateValue(_:forKey:)` 메소드로 특별한 키의 값을 설정하거나 업데이트합니다. 위의 첨자 예제 같이, `updateValue(_:forKey:)` 메소드는 키가 존재하지 않으면 값을 설정하고, 그 키가 이미 존재하면 값을 업데이트합니다. 하지만, 첨자와 달리, `updateValue(_:forKey:)` 메소드는 업데이트한 후에 _예전 (old)_ 값을 반환합니다. 이는 업데이트를 했는지 안했는지 검사할 수 있게 합니다.

`updateValue(_:forKey:)` 메소드는 딕셔너리 값 타입의 옵셔널 값을 반환합니다. 딕셔너리가 `String` 값을 저장한 거면, 예를 들어, 메소드가 `String?`, 또는 "옵셔널 `String`", 타입의 값을 반환합니다. 이 옵셔널 값은 업데이트 전에 그 키에 값이 하나라도 존재했으면 예전 값을, 값이 존재하지 않았으면 `nil` 을, 담고 있습니다:

```swift
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
  print("The old value for DUB was \(oldValue).")
}
// "The old value for DUB was Dublin." 를 인쇄함
```

첨자 구문을 사용하여 딕셔너리에서 특별한 키의 값을 가져올 수도 있습니다. 요청한 키에 값이 존재하지 않는 것도 가능하기 때문에, 딕셔너리의 첨자는 딕셔너리 값 타입의 옵셔널 값을 반환합니다. 요청한 키의 값을 딕셔너리가 담고 있으면, 첨자는 그 키에 존재하는 값을 담은 옵셔널 값을 반환합니다. 그 외 경우, 첨자는 `nil` 을 반환합니다:

```swift
if let airportName = airports["DUB"] {
  print("The name of the airport is \(airportName).")
} else {
  print("That airport is not in the airports dictionary.")
}
// "The name of the airport is Dublin Airport." 를 인쇄함
```

첨자 구문으로 딕셔너리에서 키-값 쌍을 제거하려면 그 키에 `nil` 값을 할당하면 됩니다:

```swift
airports["APL"] = "Apple International"
// "Apple International" 은 실제 APL 의 공항이 아니라서, 이를 삭제함
airports["APL"] = nil
// 이제 APL 을 딕셔너리에서 제거했음
```

대안으로, `removeValue(_:forKey)` 메소드로도 딕셔너리에서 키-값 쌍을 제거합니다. 이 메소드는 키-값 쌍이 존재하면 이를 제거하고 제거한 값을 반환하지만, 값이 존재하지 않으면 `nil` 을 반환합니다:

```swift
if let removedValue = airports.removeValue(forKey: "DUB") {
  print("The removed airport's name is \(removedValue).")
} else {
  print("The airports dictionary does not contain a value for DUB.")
}
// "The removed airport's name is Dublin Airport." 를 인쇄함
```

#### Iterating Over a Dictionary (딕셔너리 반복하기)

`for`-`in` 반복문으로 딕셔너리의 키-값 쌍 전체를 반복할 수 있습니다. 각각의 딕셔너리 항목은 `(key, value)` 튜플로 반환되며, 튜플 멤버는 반복 회차[^iteration] 부분에서 임시 상수 또는 변수로 분해할 수 있습니다:

```swift
for (airportCode, airportName) in airports {
  print("\(airportCode): \(airportName)")
}
// LHR: London Heathrow               
// YYZ: Toronto Pearson
```

`for`-`in` 반복문에 대한 더 많은 건, [For-In Loops (For-In 반복문)]({% link docs/swift-books/swift-programming-language/control-flow.md %}#for-in-loops-for-in-반복문) 부분을 보기 바랍니다.

딕셔너리의 `keys` 와 `values` 속성에 접근하여 반복 가능한 집합체[^iterable-collection] 형태로 키와 값을 가져올 수도 있습니다:

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

`Array` 인스턴스를 취하는 API 에 딕셔너리의 키와 값을 사용할 필요가 있다면, `keys` 또는 `values` 속성으로 새로운 배열을 초기화 합니다:

```swift
let airportCodes = [String](airports.keys)
// airportCodes 는 ["LHR", "YYZ"] 임

let airportNames = [String](airports.values)
// airportNames 은 ["London Heathrow", "Toronto Pearson"] 임
```

스위프트의 `Dictionary` 타입은 순서를 정의하지 않습니다. 딕셔너리의 키나 값을 정해진 순서로 반복하려면, `sorted()` 메소드를 `keys` 또는 `values` 속성에 사용합니다.

### 다음 장

[Control Flow (제어 흐름) >]({% link docs/swift-books/swift-programming-language/control-flow.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [Collection Types](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html) 에서 볼 수 있습니다.

[^sets-type]: 'Sets' 은 수학 용어로 그 자체로 집합이라는 뜻이며, 스위프트의 '셋 (sets)' 역시 수학의 집합 (sets) 에서 유래한 개념입니다. 실제로 셋이라는 자료 구조는 수학에 있는 집합을 프로그램으로 구현한 것에 해당합니다. 하지만, 셋을 집합이라고 번역하면 수학 용어를 말하는 것인지 자료 타입을 말하는 것인지가 모호하므로, 스위프트의 자료 타입을 의미할 땐 '셋' 이라고 발음을 그대로 사용합니다.

[^dictionaries-type]: 'dictionaries' 는 '사전' 이라고 옮길 수도 있는데, 타입이 실제 사전처럼 '키' 와 '값' 이라는 두 가지 성분으로 되어있습니다. 다만 '셋' 과 마찬가지로 '사전' 이라고 옮기면 다른 의미로 해석될 수 있으므로, 스위프트의 자료 타입 중 하나임을 의미하도록 '딕셔너리' 라고 발음 그대로 옮깁니다.

[^collections]: 'collection' 은 '집합', '묶음' 등 여러 가지 말로 옮길 수 있지만 여기서는 '집합체' 라는 말을 사용합니다. 이는 프로그래밍 용어에서 '객체', '구조체', '열거체' 등이 하나의 '타입' 을 의미하는 것에서 착안한 것입니다. '집합체' 는 어떤 성분들의 집합으로 이루어진 '타입' 이라고 이해하면 좋을 것 같습니다.

[^ordered-collection]: '순서 있는 집합체 (ordered collections)' 는 '정렬된 집합체 (sorted collection)' 와 다릅니다. 이 둘의 차이점에 대해서는, StackOverflow 의 [What is the difference between an ordered and a sorted collection?](https://stackoverflow.com/questions/1084146/what-is-the-difference-between-an-ordered-and-a-sorted-collection) 항목을 참고하기 바랍니다. [Closures (클로저; 잠금 블럭)]({% link docs/swift-books/swift-programming-language/closures.md %}) 장이 [The Sorted Method (정렬 메소드)]({% link docs/swift-books/swift-programming-language/closures.md %}#the-sorted-method-정렬-메소드) 부분에서 보듯, 여기선 'order' 는 순서로 'sort' 는 정렬이라고 옮깁니다.

[^list]: '리스트 (list)' 는 자료 구조의 하나입니다. 리스트 자료 구조에 대한 더 많은 정보는, 위키피디아의 [List (abstract data type)](https://en.wikipedia.org/wiki/List_(abstract_data_type)) 항목과 [리스트 (컴퓨팅)](https://ko.wikipedia.org/wiki/리스트_(컴퓨팅)) 항목을 참고하기 바랍니다.

[^Foundation]: **Foundation** 은 모든 스위프트 프로그래밍의 기반이 되는 프레임웍이며, `import Foundation` 으로 불러옵니다. **Foundation** 프레임웍에 대한 더 자세한 정보는, 애플 개발자 문서의 [Foundation](https://developer.apple.com/documentation/foundation) 항목을 참고하기 바랍니다.

[^Cocoa]: **Cocoa** 는 **macOS** 용 **API** 입니다. 하지만, [Cocoa Fundamentals Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CocoaFundamentals/WhatIsCocoa/WhatIsCocoa.html) 항목을 보면 현재는 그만둔 (Retired) 문서라고 합니다. **M1** 맥북의 등장하며 **macOS** 가 **ARM** 기반이 되면서 **Cocoa** 프레임웍의 비중은 더 줄어들고 있습니다.

[^compatible]: 컴퓨터 용어로 '호환 가능 (compatible)' 하다는 건 서로 같이 사용하거나 교체가 가능하다는 말입니다. 예를 들어, 스위프트에서 `Float` 과 `Double` 타입은 덧셈 연산자와 호환 가능이라 이 둘을 덧셈 연산자로 더할 수 있습니다. 본문에서 호환 가능하다라는 표현을 사용한 건 두 값을 더할 때 둘의 타입이 똑같을 필요는 없기 때문입니다.

[^literal]: 'literal' (글자 값) 은 실제 글자로 표현된 값을 의미합니다. 예를 들어 `let a = 10` 이라고 하면 여기서 `10` 은 ASCII 코드로 된 문자 `1` 과 `0` 의 조합이지만 '실제 글자로 표현된 값' 은 정수 `10` 을 의미하므로, `a` 는 `Int` 타입으로 추론됩니다.

[^isEmpty-count]: 스위프트는 배열이나, 셋, 또는 딕셔너리가 빈 것인지 검사할 때 `isEmpty` 를 사용하라고 합니다. `count` 는 값의 개수를 셀 때 사용합니다. `count` 와 `isEmpty` 는 사용 목적이 다르며, 단순히 편리하기 때문에 `isEmpty` 를 사용하는게 아닙니다. [Strings and Characters (문자열과 문자)]({% link docs/swift-books/swift-programming-language/strings-and-characters.md %}) 장의 [Counting Characters (문자 개수 세기)](#counting-characters-문자-개수-세기) 절에서 설명하듯, 배열이나, 셋, 또는 딕셔너리가 빈 것인지 검사할 때 `count` 를 사용하면, 배열의 전체 항목을 반복해야만 할 수도 있습니다. 이런 종류의 최적화에 대해선, [isEmpty vs. count == 0](https://medium.com/better-programming/strings-comparison-isempty-vs-count-0-be80d701901b) 항목을 참고하기 바랍니다.

[^count-runtime-error]: `shippingList.count` 는 현재 배열의 전체 항목 개수인데, 이 값을 써서 새 항목을 추가하는 행위 자체가 다시 `count` 값을 바꿉니다. 이는 `count` 라는 변수에 값을 읽고 쓰는 행위를 동시에 하는 것과 같아서, 동시성 문제를 일으킵니다. 따라서 `shippingList.count` 는 유효한 색인이 아닙니다.

[^iterate-over]: '동작을 반복한다 (iterate over)' 는 것은 '배열의 모든 항목마다 한 번씩 동작한다' 는 의미입니다.

[^with-no-defined-ordering]: '(정의한) 아무런 순서가 없다 (no defined ordering)' 는 건 항목을 집어넣는 순서와 저장된 순서 사이에 아무런 관계가 없다는 의미입니다. 여기서 순서 (order) 는 정렬 (sort) 과 상관 없는 개념입니다. 이에 대해서는 앞에서 설명한 순서 있는 집합체[^ordered-collection] 부분을 참고하기 바랍니다.

[^hashable]: '해시 (hash)' 는 고기와 감자를 잘게 다져서 마구잡이로 섞어놓은 음식에서 유래한 것으로 '많은 것을 마구잡이로 뒤섞은 것' 을 의미합니다. 즉, 'hashable' 은 이렇게 'hash 를 만들 수 있는' 걸 의미하며, 컴퓨터 용어로는, '많은 양의 정보를 잘게 다져 마구 뒤섞어 놓은 형태로 저장할 수 있다는' 의미입니다. 우리말로 '(잘게) 다질 수 있는' 정도로 이해할 수 있는데, 여기선, 컴퓨터 용어임을 알 수 있게 해시라는 발음을 그대로 사용합니다.

[^hash-value]: '해시 값 (hash value)' 은, 앞에서 설명한 'hashable' 을 참고하여, '잘게 쪼개고 뒤섞어 다진 값' 정도로 이해할 수 있습니다.

[^empty-array-literal]: '빈 셋 글자 값 (empty set literal)' 같은 건 따로 없기 때문에, '빈 배열 글자 값 (empty array literal)' 을 그대로 사용합니다.

[^set-array-collection]: 앞에서 설명한 것처럼, '셋 글자 값' 이란 것은 따로 없고, 셋에서도 '배열 글자 값' 을 사용합니다.

[^set-array-literal]: '셋 글자 값' 이 따로 없기 때문에, 타입을 명시하지 않고 '배열 글자 값' 만 사용하면 `Array` 타입이라고 추론할 것입니다.

[^set-operations]: 여기서는 'set' 을 '집합' 이라고 옮겼는데, '셋 (set)' 자체가 수학 집합을 뜻하기 때문에, 셋 연산은 그 자체로 수학에서의 집합 연산을 의미합니다.

[^disjoint]: 'disjoint' 는 수학 용어로 '분리' 또는 '서로 소' 라고 옮기는 것 같습니다. 영어로 [Disjoint sets](https://en.wikipedia.org/wiki/Disjoint_sets) 은 한글로 [서로 소 집합](https://ko.wikipedia.org/wiki/서로소_집합) 이라고 하지만, [분리 합집합](https://ko.wikipedia.org/wiki/분리_합집합) 이라는 용어도 있는 것을 보면, 'disjoint' 를 '분리' 라고 하는 것도 맞는 것 같습니다.

[^subset-or-superset]: 수학 용어로 이를 진 부분 집합 (진 하위 집합) 및 진 상위 집합이라고 합니다.

[^intersection]: 원래는 메소드의 이름이 `intersect` 였는데, `intersection` 으로 바뀌었습니다. 이는 애플의 [API Design Guidelines (API 설계 지침)]({% post_url 2020-09-15-API-Design-Guidelines %}) 에 있는 [Strive for Fluent Usage (자연스러운 사용법이 되도록 노력하기)]({% post_url 2020-09-15-API-Design-Guidelines %}#strive-for-fluent-usage-자연스러운-사용법이-되도록-노력하기) 에서 설명한 규칙에 맞추기 위함으로 보입니다. 즉, 메소드의 이름을 **명사** 나 **분사** 형태로 만들어서 원본이 변경되지 않음을 나타낸 것입니다.

[^symmetric-difference]: 원래는 메소드의 이름이 `exclusiveOr` 였는데, `symmetricDifference` 로 바뀌었습니다. 앞서와 마찬가지로 애플의 [API Design Guidelines (API 설계 지침)]({% post_url 2020-09-15-API-Design-Guidelines %}) 에 있는 [Strive for Fluent Usage (자연스러운 사용법이 되도록 노력하기)]({% post_url 2020-09-15-API-Design-Guidelines %}#strive-for-fluent-usage-자연스러운-사용법이-되도록-노력하기) 에서 설명한 규칙에 맞추기 위함으로 보입니다. 즉, 메소드의 이름을 '명사' 나 '분사' 형태로 만들어서 원본이 변경되지 않음을 나타낸 것입니다.

[^subtracting]: 원래는 메소드의 이름이 `subtract` 였는데, `subtracting` 으로 바뀌었습니다. 역시 마찬가지로 애플의 [API Design Guidelines (API 설계 지침)]({% post_url 2020-09-15-API-Design-Guidelines %}) 에 있는 [Strive for Fluent Usage (자연스러운 사용법이 되도록 노력하기)]({% post_url 2020-09-15-API-Design-Guidelines %}#strive-for-fluent-usage-자연스러운-사용법이-되도록-노력하기) 에서 설명한 규칙에 맞추기 위함으로 보입니다. 즉, 메소드의 이름을 '명사' 나 '분사' 형태로 만들어서 원본이 변경되지 않음을 나타낸 것입니다.

[^subset]: '하위 집합 (subset)' 은 '수학에서 말하는 부분 집합' 입니다. 다만, 'subset' 에 대응하는 'superset' 에 대한 명확한 우리말이 없는 것 같아서, 여기서는 일단 '상위 집합 (superset)' 과의 대응의 의미로 '하위 집합 (subset)' 이라고 합니다.

[^IATA]: 본문에 있는 '국제 항공 운송 협회 (International Air Transport Association)' 는 예제를 위한 것이 아니라 실제로 존재하는 협회입니다. 이 협회의 홈페이지는 [https://www.iata.org](https://www.iata.org) 입니다.

[^zero-indexed]: '0 기반-색인 (zero-indexed)' 은 색인이 0 부터 시작한다는 의미입니다. 앞 장에 있는 0-기반 목록과 유사한 개념입니다. 0-기반 목록에 대한 더 많은 정보는, 위키피디아의 [Zero-based numbering](https://en.wikipedia.org/wiki/Zero-based_numbering) 항목을 참고하기 바랍니다.
