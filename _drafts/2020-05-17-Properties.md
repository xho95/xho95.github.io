---
layout: post
comments: true
title:  "Swift 5.2: Properties (속성)"
date:   2020-05-16 10:00:00 +0900
categories: Swift Language Grammar Property
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html) 부분[^Properties]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Properties (속성)

_속성 (properties)_ 은 값을 특정한 클래스, 구조체, 또는 열거체와 관련짓습니다. '저장 속성 (stored properties)' 은 상수와 변수 값을 인스턴스의 일부로 저장하며, 반면 '계산 속성 (computed properties)' 은 값을 (저장하는 대신) 계산합니다. '계산 속성' 은 클래스, 구조체, 그리고 열거체에서 제공합니다. '저장 속성' 은 클래스와 구조에서만 제공합니다.

저장 및 계산 속성은 보통 특정한 타입의 인스턴스와 관련되어 있습니다. 하지만, 속성은 타입 그 자체와 관련될 수도 있습니다. 이러한 속성을 타입 속성이라고 합니다.

이에 더하여, '속성 관찰자 (property observers)' 를 정의하면 속성 값이 바뀌는 것을 감시해서, 그 응답으로 자기가 정의한 행동을 하게 할 수도 있습니다. '속성 관찰자' 는 자기 스스로 정의한 '저장 속성' 에 추가할 수 있으며, 상위 클래스에서 상속 받은 하위 클래스 속성에도 추가할 수 있습니다.

'속성 포장 (property wrapper)' 을 사용하여 여러 속성들의 '획득자 (getter)' 와 '설정자 (setter)' 에 있는 코드를 재사용할 수도 있습니다.

### Stored Properties (저장 속성)

가장 간단한 양식의, 저장 속성 중은 특정한 클래스나 구조체 인스턴스의 일부로 저장되는 상수 또는 변수입니다. 저장 속성은 (`var` 키워드로 도입하는) _변수 저장 속성 (variable stored properties)_ 일 수도 있고 (`let` 키워드로 도입하는) _상수 저장 속성 (constant stored properties)_ 일 수도 있습니다.   

저장 속성은 정의하면서 '기본 설정 값 (default value)' 을 제공할 수 있으며, 이는 [Default Property Values (기본 설정 속성 값)]({% post_url 2016-01-23-Initialization %}#default-property-values-기본-설정-속성-값) 에서 설명합니다. 초기화하는 과정에서 저장 속성의 초기 값을 설정하고 수정할 수도 있습니다. 이는 '상수 저장 속성' 에서도 마찬가지인데, [Assigning Constant Properties During Initialization (초기화하는 동안 상수 속성 할당하기)]({% post_url 2016-01-23-Initialization %}#assigning-constant-properties-during-initialization-초기화하는-동안-상수-속성-할당하기) 에서 설명하도록 합니다.

아래 예제는 `FixedLengthRange` 라는 구조체를 정의하는데, 이는 생성되고 나면 범위의 크기를 바꿀 수 없는 정수 범위를 나타냅니다:

```swift
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// 이 범위는 정수 값 0, 1, 그리고 2 를 나타냅니다.
rangeOfThreeItems.firstValue = 6
// 이 범위는 이제 정수 값 6, 7, 그리고 8 를 나타냅니다.
```

`FixedLengthRange` 인스턴스는 `firstValue` 라는 '변수 저장 속성' 과 `length` 라는 '상수 저장 속성' 을 가지고 있습니다. 위의 예제에서, `length` 는 새로운 범위를 생성할 때 초기화되어 그 이후로는 바꿀 수 없는데, 이는 '상수 속성' 이기 때문입니다.

#### Stored Properties of Constant Structure Instances (상수 구조체 인스턴스의 저장 속성)

구조체의 인스턴스를 생성한 다음 그 인스턴스를 상수에 할당하면, 인스턴스의 속성은 수정할 수 없는데, 이는 '변수 속성' 으로 선언했더라도 마찬가지입니다:

```swift
let rangeOfFourItems = FixedLengthRange(firstValue : 0, length: 4)
// 이 범위는 정수 값 0, 1, 2 그리고 3 을 나타냅니다.
rangeOfFourItems.firstValue = 6
// 이것은 에러를 보고하는데, firstValue 가 변수 속성 임에도 불구하고 그렇습니다.
```

`rangeOfFourItems` 을 (`let` 키워드로) 상수로 선언했기 때문에, `firstValue` 가 변수 속성임에도 불구하고, 이 `firstValue` 속성을 바꾸는 것은 불가능합니다.

이런 작동 방식은 구조체가 _값 타입 (value types)_ 이기 때문입니다. 값 타입의 인스턴스를 상수로 표시하면, 모든 속성도 마찬가지가 됩니다.

이와 같은 방식은, _참조 타입 (reference types)_ 인, 클래스에는 해당하지 않습니다. 참조 타입의 인스턴스를 상수에 할당하더라도, 그 인스턴스의 '변수 속성' 은 여전히 바꿀 수 있습니다.

#### Lazy Stored Properties (느긋한 저장 속성)

_느긋한 저장 속성 (lazy stored property)_ 은 맨 처음 사용하는 순간까지 초기 값을 계산하지 않는 속성을 말합니다. 느긋한 (lazy) 저장 속성을 지시하려면 선언 앞에 `lazy` 수정자를 붙이면 됩니다.

> 느긋한 속성은 반드시 (`var` 키워드를 써서) 변수로 선언해야 하는데, 인스턴스 초기화가 완료된 후에도 초기 값을 가져오지 못할 수도 있기 때문입니다. 상수 속성은 초기화가 완료되기 _전에 (before)_ 반드시 값을 가져야 하므로, 'lazy (느긋한)' 것으로 선언할 수 없습니다.

느긋한 (lazy) 속성은 속성의 초기 값이 외부 요인에 의존하기 때문에 이 값을 인스턴스 초기화가 완료된 후에까지 알 수 없는 경우에 유용합니다. 느긋한 (lazy) 속성은 또 속성의 초기 값을 설정하는 것이 아주 복잡하고 계산 비용이 비싸서 정말 필요한 순간이 아니라면 또 필요하지 않은 순간이라면 수행하지 않아야 하는 경우에 유용합니다.

아래 예제는 복잡한 클래스에서 불필요한 초기화를 피하기 위해 느긋한 (lazy) 저장 속성을 사용하고 있습니다. 이 예제는 `DataImporter` 와 `DataManager` 라는 두 개의 클래스를 정의하는데, 둘 다 일부만 나타냈습니다:

```swift
class DataImporter {
    /*
    DataImporter 는 외부 파일에서 자료를 불러오는 클래스 입니다.
    이 클래스를 초기화하는데는 적지 않은 시간이 걸린다고 가정합니다.
    */
    var filename = "data.txt"
    // DataImporter 클래스가 자료를 불러오는 기능을 제공하는 곳은 여기입니다.
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // DataManager 클래스가 자료를 관리하는 기능을 제공하는 곳은 여기입니다.
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// importer 속성을 위한 DataImporter 인스턴스는 아직 생성되지 않았습니다.
```

`DataManager` 클래스에는 `data` 라는 저장 속성이 있는데, 이를 `String` 값을 가지는 새로운, 빈 배열로 초기화합니다. 비록 나머지 기능들을 나타내진 않았지만, `DataManager` 클래스의 목적은 이 `String` 배열 자료에 대한 접근을 제공하고 관리하는 것입니다.

`DataManager` 클래스의 기능 중 하나는 파일에서 데이터를 가져 오는 것입니다. 이 기능은 `DataImporter` 클래스가 제공하는 것으로, 일단 이를 초기화하는 데는 적지 않은 시간이 걸린다고 가정합니다. 왜냐면 `DataImporter` 인스턴스를 초기화할 때는 `DataImporter` 인스턴스가 파일을 열고 그 내용을 읽어서 메모리로 옮겨야 할 필요가 있을 것이기 때문입니다.

`DataManager` 인스턴스가 자료를 관리하면서 항상 자료를 파일에서 가져와야 하는 것은 아닐 수 있으므로, `DataManager` 가 자신을 생성할 때 `DataImporter` 인스턴스를 새로 생성할 필요는 없습니다. 그대신, `DataImporter` 인스턴스를 맨 처음 사용할 때 그 때 생성하는 것이 더 합리적입니다.

`lazy` 수정자로 표시했기 때문에, `importer` 속성을 위한 `DataImporter` 인스턴스는 `importer` 속성에 맨 처음 접근할 때에 생성되며, 이는 `filename` 속성을 조회할 때 등이 해당됩니다:

```swift
print(manager.importer.filename)
// importer 속성을 위한 DataImporter 인스턴스는 지금 생성됐습니다.
// "data.txt" 를 출력합니다.
```

> `lazy` 수정자로 표시된 속성이 아직 초기화되지 않은 상태에서 다중 쓰레드로 동시에 접근할 경우, 이 속성이 한 번만 초기화될 것이라고 보장할 수 없습니다.

#### Stored Properties and Instance Variables (저장 속성과 인스턴스 변수)

오브젝티브-C 언어에 대한 경험이 있다면, 클래스 인스턴스의 값을 저장하고 참조하는 데는 _두 가지 (two)_ 방법이 있다는 것을 알고 있을 것입니다. 속성 외에도, '인스턴스 변수 (instance variables)' 를 속성에 저장된 값의 '백업 저장소 (backing store)' 로 사용할 수 있습니다.

스위프트는 이러한 개념을 '단일 속성 선언' 으로 통합했습니다. 스위프트의 속성은 연관되어 있는 인스턴스 변수를 가지지 않으면, 속성의 '백업 저장소' 에 직접 접근하지 않습니다. 이러한 접근 방식은 서로 다른 영역에서 값을 접근할 때의 혼동을 피하고, 속성의 선언을 단일하고 명확한 구문으로 단순화 해줍니다. 속성에 대한 모든 정보는-이름, 타입, 그리고 메모리 관리 성질을 포함하여-타입 정의라는 단일한 위치에서 정의됩니다.

### Computed Properties (계산 속성)

#### Shorthand Setter Declaration (설정자 선언의 약칭 표현)

#### Shorthand Getter Declaration (획득자 선언의 약칭 표현)

#### Read-Only Computed Properties (읽기-전용 계산 속성)

### Property Observers (속성 관찰자)

### Property Wrappers (속성 포장)

#### Setting Initial Values for Wrapped Properties (포장된 속성에 대한 초기 값 설정하기)

#### Projecting a Value From a Property Wrapper (속성 포장에서 값 투영하기)

### Global and Local Variables (전역 변수 및 지역 변수)

### Type Properties (타입 속성)

#### Type Property Syntax (타입 속성 구문 표현)

#### Querying and Setting Type Properties (타입 속성 조회하고 설정하기)

### 참고 자료

[^Properties]: 이 글에 대한 원문은 [Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html) 에서 확인할 수 있습니다.
