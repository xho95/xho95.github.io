---
layout: post
comments: true
title:  "Swift 5.2: Subscripts (첨자 연산)"
date:   2020-03-15 10:00:00 +0900
categories: Swift Language Grammar Subscripts
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Subscripts](https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html) 부분[^Subscripts]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Subscripts (첨자 연산)

'클래스 (classes)', '구조체 (structures)', 그리고 '열거체 (enumerations)' 는 '_첨자 연산 (subscripts)_' 을 정의하여, '컬렉션 (collection)', '리스트 (list)', 또는 '시퀀스 (sequence)' 의 멤버 원소에 접근하는 간편한 방법을 제공합니다. '첨자 연산' 을 사용하면 색인으로 값을 설정하고 가져올 수 있어서 별도의 메소드를 따로 만들 필요도 없습니다. 예를 들어, `Array` 인스턴스의 원소는 `someArray[index]` 로 접근할 수 있으며, `Dictionary` 인스턴스의 원소는 `someDictionary[key]` 로 접근할 수 있습니다.

하나의 단일한 타입에 대해 여러 개의 '첨자 연산' 을 정의할 수도 있으며, 이 때 첨자 연산에 전달한 색인 값의 타입에 따라 첨자 연산을 적절하게 선택하고 사용합니다. 첨자 연산은 1차원으로만 제한된 것이 아니라서, 사용자 정의 타입의 요구에 맞게 여러 개의 입력 매개 변수를 갖는 첨자 연산도 정의할 수 있습니다.

### Subscript Syntax (첨자 연산 구문 표현)

첨자 연산을 사용해서 타입의 인스턴스를 조회하려면 인스턴스 이름 뒤위 대괄호 안에 하나 이상의 값을 써주면 됩니다. 이러한 구문 표현은 '인스턴스 메소드 구문 표현' 및 '계산 속성 구문 표현' 과 비슷합니다. 첨자 연산을 정의하려면 `subscript` 키워드를 쓴 다음, 하나 이상의 매개 변수와 하나의 반환 타입을 지정하면 되며, 이는 인스턴스 메소드와 방법이 같습니다. 다만 인스턴스 메소드와는 달리, 첨자 연산은 '읽기-쓰기 혼용' 일 수도 있고 '읽기-전용' 일 수도 있습니다. 이 행동은 'getter (게터)' 와 'setter (세터)' 를 사용하여 상호 작용하는데 이것도 '계산 속성' 과 같은 방법입니다.

```swift
subscript(index: Int) -> Int {  
  get {
    // 여기서 알맞은 첨자 연산 값을 반환합니다.
  }
  set(newValue) {
    // 여기서 적당한 설정 행동을 수행합니다.  
  }
}
```

`newValue` 의 타입은 첨자 연산의 반환 값과 같습니다. '계산 속성 (computed properties)' 에서 처럼, 'setter (세터)' 의 `(newValue)` 매개 변수를 지정 안해도 상관 없습니다. 직접 제공하지 않으면 'setter (세터)' 는 `newValue` 라는 기본 매개 변수를 제공합니다.

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

For example, Swift’s Dictionary type implements a subscript to set and retrieve the values stored in a Dictionary instance. You can set a value in a dictionary by providing a key of the dictionary’s key type within subscript brackets, and assigning a value of the dictionary’s value type to the subscript:

예를 들어, 스위프트의 `Dictionary` 타입은 `Dictionary` 인스턴스에 저장된 값을 설정하고 가져오는 첨자 연산을 구현하고 있습니다. '딕셔너리' 에 값을 설정하려면 첨자 연산의 괄호 안에 '딕셔너리' 키 타입의 키를 제공한 다음, 첨자 연산에 '딕셔너리' 값 타입의 값을 할당하면 됩니다.

```swift
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2
```

위에 있는 예제는 `numberOfLegs` 라는 변수를 정의하고 이를 세 개의 키-값 쌍을 가지고 있는 '딕셔너리 글자표현 (dictionary literal)' 으로 초기화하고 있습니다. `numberOfLegs` 딕셔너리의 타입은 `[String: Int]` 로 추론합니다. 딕셔너리를 만든 다음, 이 예제는 첨자 연산 할당을 사용하여 문자열 키가 `"bird"` 이고 `Int` 값이 `2` 인 원소를 딕셔너리에 할당합니다.

`Dictionary` 첨자 연산에 대한 더 많은 정보는 [Accessing and Modifying a Dictionary (딕셔너리에 접근하고 수정하기)](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html#ID116) 를 참고하기 바랍니다.

Swift’s Dictionary type implements its key-value subscripting as a subscript that takes and returns an optional type. For the numberOfLegs dictionary above, the key-value subscript takes and returns a value of type Int?, or “optional int”. The Dictionary type uses an optional subscript type to model the fact that not every key will have a value, and to give a way to delete a value for a key by assigning a nil value for that key.

> 스위프트의 '딕셔너리' 타입은 키-값 첨자 연산이 옵셔널 타입을 받아들이고 반환하는 것으로 구현하고 있습니다. 위의 `numberOfLegs` 딕셔너리에서는, 키-값 첨자 연산이 값의 타입으로 `Int?`, 또는 "옵셔널 정수 (optional int)" 를 받아들이고 반환합니다. `Dictionary` 타입이 옵셔널 첨자 연산 타입을 사용한다는 것은 모든 키가 값을 가지는 것은 아니라는 사실을 모델링하고 있기도 하고, 키에 `nil` 값을 할당하여 그 키에 대한 값을 지울 수 있는 방법을 제공하고 있는 것이기도 합니다.

### Subscript Options (첨자 연산의 선택 사항들)

### Type Subscript (타입 첨자 연산)

### 참고 자료

[^Subscripts]: 이 글에 대한 원문은 [Subscripts](https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html) 에서 확인할 수 있습니다.
