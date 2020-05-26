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

클래스, 구조체, 그리고 열거체는, '저장 속성' 외에도,  _계산 속성 (computed properties)_ 을 정의할 수 있는데, 이는 실제로 값을 저장하진 않습니다. 대신에, '획득자 (getter)' 와 '선택적인 설정자 (optional setter)'[^optional-setter] 를 제공하여 이로써 다른 속성과 값을 간접적으로 가져오고 설정하게 됩니다.

```swift
struct Point {
  var x = 0.0, y = 0.0
}
struct Size {
  var width = 0.0, height = 0.0
}
struct Rect {
  var origin = Point()
  var size = Size()
  var center: Point {
    get {
      let centerX = origin.x + (size.width / 2)
      let centerY = origin.y + (size.height / 2)
      return Point(x: centerX, y: centerY)
    }
    set(newCenter) {
      origin.x = newCenter.x - (size.width / 2)
      origin.y = newCenter.y - (size.height / 2)
    }
  }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// "square.origin is now at (10.0, 10.0)" 를 출력합니다.
```

이 예제는 기하학적 도형 작업을 위해 세 가지 구조체를 정의합니다.

* `Point` 는 한 점에 대한 x, y 좌표를 캡슐화 합니다.
* `Size` 는 `width` 와 `height` 를 캡슐화 합니다.
* `Rect` 는 '원점 (origin point)' 과 '크기 (size)' 를 사용하여 사각형을 정의합니다.

`Rect` 구조체는 `center` 라는 '계산 속성' 도 제공합니다. `Rect` 의 현재 중심 위치는 `origin` 과 `size` 로부터 항상 결정할 수 있으므로, 중심 점을 `Point` 값으로 저장할 필요가 없습니다. 대신, `Rect` 는 `center` 라는 '계산 변수' 에 대한 사용자 정의 '획득자 (getter)' 와 '설정자 (setter)' 를 정의하여, 사각형의 `center` 를 마치 실제 저장 속성인 것처럼 사용할 수 있게 해줍니다.

위의 예제에서는 `square` 라는 새로운 `Rect` 변수를 생성합니다. `square` 변수의 원점은 `(0, 0)`, 폭과 높이는 `10` 으로 초기화 됩니다. 이 '정사각형 (square)' 은 아래 그림에서 파란색 사각형으로 표현됩니다.

`square` 변수의 `center` 속성은 이제 '점 구문 표현 (`square.center`)' 을 통해 접근하게 되는데, 이는 `center` 의 '획득자 (getter)' 를 호출하여, 현재 속성의 값을 가져옵니다. 이 '획득자 (getter)' 는, 존재하고 있는 값을 반환하는게 아니고, 정사각형의 중심을 나타내는 새 `Point` 를 실제로 계산한 다음 반환합니다. 위에서 봤듯이, '획득자' 는 중심점이 `(5, 5)` 라고 정확하게 반환합니다.

`center` 속성은 이제 새 값인 `(15, 15)` 로 설정되며, 이는 정사각형을 오른쪽 위로 이동하게 되는데, 이 새 위치는 아래 그림의 오렌지 정사각형으로 나타냈습니다. `center` 속성을 설정하면 `center` 의 '설정자 (setter)' 를 호출하며, 이는 `origin` 저장 속성의 `x` 와 `y` 값을 수정하여, 정사각형을 새 위치로 이동합니다.

![computed properties](/assets/Swift/Swift-Programming-Language/Properties-computed-property.png)

#### Shorthand Setter Declaration (설정자 선언의 약칭 표현)

계산 속성의 '설정자 (setter)' 가 설정할 새 값에 대한 이름을 정의하지 않을 경우, 기본 제공되는 이름인 `newValue` 를 사용합니다. 다음은 이 '약칭 표현법 (shorthand notation)' 의 이점을 활용하여 `Rect` 구조체를 다른 방법으로 만들어 본 것입니다:

```swift
struct AlternativeRect {
  var origin = Point()
  var size = Size()
  var center: Point {
    get {
      let centerX = origin.x + (size.width / 2)
      let centerY = origin.y + (size.height / 2)
      return Point(x: centerX, y: centerY)
    }
    set {
      origin.x = newValue.x - (size.width / 2)
      origin.y = newValue.y - (size.height / 2)
    }
  }
}
```

#### Shorthand Getter Declaration (획득자 선언의 약칭 표현)

'획득자 (getter)' 의 전체 본문이 '단일 표현식 (single expression)' 으로 되어 있는 경우, '획득자' 는 암시적으로 그 표현식을 반환합니다. 다음은 이 '약칭 표현법' 과 '설정자' 에 대한 '약칭 표현법' 이점을 활용하여 `Rect` 구조체를 다른 방법으로 만들어 본 것입니다:

```swift
struct CompactRect {
  var origin = Point()
  var size = Size()
  var center: Point {
    get {
      Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
    }
    set {
      origin.x = newValue.x - (size.width / 2)
      origin.y = newValue.y - (size.height / 2)
    }
  }
}
```

'획득자' 에서 `return` 을 생략하는 것은 함수에서 `return` 을 생략하는 것과 같은 규칙을 따르는 것으로, 이는 [Functions With an Implicit Return (암시적으로 반환하는 함수)](https://docs.swift.org/swift-book/LanguageGuide/Functions.html#ID607) 에서 설명되어 있습니다.

#### Read-Only Computed Properties (읽기-전용 계산 속성)

획득자는 있지만 설정자는 없는 계산 속성을 _읽기-전용 계산 속성 (read-only computed property)_ 라고 합니다. '읽기-전용 계산 속성' 은 항상 값을 반환하고, '점 구문 표현' 으로 접근할 수 있지만, 다른 값을 설정할 수는 없습니다.

> 계산 속성은-읽기 전용 계산 속성도 포함하여- 반드시 `var` 키워드를 써서 변수 속성으로 선언해야 하는데, 이는 값이 고정된 것이 아니기 때문입니다. `let` 키워드는 상수 속성에만 사용하며, 인스턴스 초기화에서 한 번 설정한 값은 바꿀 수 없음을 지시하는 것입니다.

읽기-전용 계산 속성의 선언은 `get` 키워드와 중괄호를 제거하여 간소화 할 수 있습니다:

```swift
struct Cuboid {
  var width = 0.0, height = 0.0, depth = 0.0
  var volume: Double {
    return width * height * depth
  }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// "the volume of fourByFiveByTwo is 40.0" 를 출력합니다.
```

이 예제는 `Cuboid` 라는 새 구조체를 정의하여, `width`, `height`, 그리고 `depth` 속성을 가진 3D 직사각형 상자를 표현합니다. 이 구조체는 `volume` 이라는 읽기-전용 계산 속성도 가지고 있는데, 이는 '직육면체 (cuboid)'[^cuboid] 의 현재 부피를 계산하고 반환합니다. `volume` 은 '설정 가능하다는 (settable)' 것은 말이 안되는데, 왜냐면 특정한 `volume` 값에 대한 `width`, `height`, 그리고 `depth` 값이 어떤 것인지 모호하기 때문입니다. 그렇지만, `Cuboid` 가 읽기-전용 계산 속성을 제공하여 현재 계산된 부피를 외부 사용자도 알 수 있게 하는 것은 유용합니다.

### Property Observers (속성 관찰자)

'속성 관찰자 (property observers)' 는 속성 값이 바뀌는 것을 관찰하여 이에 대한 응답을 합니다. 속성 관찰자는 속성의 값이 설정될 때마다 호출되는데, 심지어 새 값이 현재 속성의 값과 같은 경우에도 호출됩니다.

직접 정의한 저장 속성이라면 어떤 것에든, '지연 저장 속성' 만 아니라면, 속성 관찰자를 추가할 수 있습니다. 상속받은 속성에도 (저장 속성이든 계산 속성이든 상관없이) 어느 것에든 속성 관찰자를 추가할 수 있으며, 하위 클래스에서 그 속성을 '재정의 (overriding)' 하면 됩니다. '재정의 하지 않은 계산 속성 (nonoverridden computed properties)'[^nonoverridden-computed-properties] 에는 속성 관찰자를 정의 할 필요가 없는데, 이는 계산 속성의 설정자 (setter) 에서 해당 값의 변화를 관찰하고 응답할 수 있기 때문입니다. '속성 재정의 (property overriding)' 는 [Overriding (재정의하기)]({% post_url 2020-03-31-Inheritance %}#overriding-재정의하기) 에서 설명합니다.

속성에 다음 관찰자 중에서 하나만 정의할 지 둘 다 정의할 지 선택할 수 있습니다:

* `willSet` 은 값이 저장되기 바로 직전에 호출됩니다.
* `didSet` 은 새 값이 저장된 바로 직후에 호출됩니다.

`willSet` 관찰자를 구현하면, 새 속성 값은 상수 매개 변수의 형태로 전달됩니다. 이 매개 변수의 이름은 `willSet` 구현부에서 지정할 수 있습니다. 구현부에서 매개 변수 이름과 괄호를 쓰지 않으면, 이 매개 변수는 기본 제공되는 매개 변수 이름인 `newValue` 를 사용하게 됩니다.

마찬가지로, `didSet` 관찰자를 구현하면, 이전 속성 값을 담고 있는 상수 매개 변수가 전달됩니다. 매개 변수에 이름을 지정할 수도 있고 기본 제공 매개 변수 이름인 `oldValue` 를 사용할 수도 있습니다. 자신이 가지고 있는 `didSet` 관찰자에서 속성의 값을 할당하면, 새로 할당한 값이 방금 설정된 값을 대체하게 됩니다.

> 상위 클래스 속성의 `willSet` 과 `didSet` 관찰자는, 하위 클래스의 초기자에서 속성을 설정할 때, 상위 클래스의 초기자를 호출한 후, 호출됩니다. 이들은 클래스 속성을 설정하는 동안, 상위 클래스의 초기자가 호출되기 전에는, 호출되지 않습니다.
>
> '초기자 위임 (initializer delegation)' 에 대한 더 많은 정보는, [Initializer Delegation for Value Types (값 타입을 위한 초기자 위임하기)]({% post_url 2020-03-31-Inheritance %}#initial-delegation-for-value-types-값-타입을-위한-초기자-위임하기) 와 [Initializer Delegation for Class Types (클래스 타입을 위한 초기자 위임하기)]({% post_url 2020-03-31-Inheritance %}#initializer-delegation-for-class-types-클래스-타입을-위한-초기자-위임하기) 을 참고하기 바랍니다.

다음은 `willSet` 과 `didSet` 의 실제 사례입니다. 아래 예제는 `StepCounter` 라는 새로운 클래스를 정의하여, 한 사람이 걷는 동안의 총 걸음 수를 추적합니다. 이 클래스는 사람의 운동 과정을 매일 매일 추적하기 위해 '만보계 (pedometer)' 나 다른 '걸음 카운터 (step counter)' 의 입력 데이터를 같이 사용할 수도 있을 것입니다.

```swift
class StepCounter {
  var totalSteps: Int = 0 {
    willSet(newTotalSteps) {
      print("About to set totalSteps to \(newTotalSteps)")
    }
    didSet {
      if totalSteps > oldValue  {
        print("Added \(totalSteps - oldValue) steps")
      }
    }
  }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps
```

`StepCounter` 클래스는 타입이 `Int` 인 `totalSteps` 속성을 선언합니다. 이것은 `willSet` 과 `didSet` 관찰자를 가지고 있는 저장 속성입니다.

`totalSteps` 의 `willSet` 과 `didSet` 관찰자는 속성에 새 값이 할당될 때마다 호출됩니다. 심지어 새 값이 현재 값과 같은 경우에도 그렇습니다.

이 예제의 `willSet` 관찰자는 새로 지정할 값에 `newTotalSteps` 라는 사용자 정의 매개 변수 이름을 사용합니다. 이 예제에서는, 이는 단순히 설정하려는 값을 출력하기만 합니다.

`didSet` 관찰자는 `totalSteps` 값이 갱신된 후에 호출됩니다. 이는 `totalSteps` 의 새 값을 이전 값과 비교합니다. 총 걸음 수가 증가다면, 얼마나 더 걸었는지 나타내기 위해 메시지를 출력합니다. `didSet` 관찰자는 이전 값에 대해 사용자 정의 매개 변수 이름을 제공하지 않고, 그 대신 기본 제공되는 이름인 `oldValue` 를 사용합니다.

> 관찰자를 가지고 있는 속성을 함수의 '입-출력 매개 변수 (in-out parameter)' 로 전달하면, `willSet` 과 `didSet` 관찰자는 항상 호출됩니다. 이는 '입-출력 매개 변수' 의 '복사해 들어가고 (copy-in)' '복사해 나오는 (copy-out)' 모델 때문입니다: 함수의 끝에서 속성의 값은 항상 다시 쓰여집니다. '입-출력 매개 변수' 의 이러한 동작 방식에 대한 더 자세한 논의는, [In-Out Parameters (입-출력 매개 변수)](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID545) 를 참고하기 바랍니다.

### Property Wrappers (속성 포장)

#### Setting Initial Values for Wrapped Properties (포장된 속성에 대한 초기 값 설정하기)

#### Projecting a Value From a Property Wrapper (속성 포장에서 값 투영하기)

### Global and Local Variables (전역 변수 및 지역 변수)

### Type Properties (타입 속성)

#### Type Property Syntax (타입 속성 구문 표현)

#### Querying and Setting Type Properties (타입 속성 조회하고 설정하기)

### 참고 자료

[^Properties]: 이 글에 대한 원문은 [Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html) 에서 확인할 수 있습니다.

[^optional-setter]: 여기서의 'optional' 은 스위프트에 있는 '옵셔널 타입' 과는 상관이 없습니다. '계산 속성' 은 '설정자 (setter)' 를 가질 수도 있고 안가질 수도 있기 때문에 'optional setter' 라는 용어를 사용합니다.

[^cuboid]: 'cuboid' 는 수학 용어로 '직육면체' 를 의미하며, 모든 면이 직사각형으로 이루어진 기하학적 도형을 의미합니다. 이름이 'cuboid' 인 것은 'polyhedral graph (다면체 그래프; 일종의 기하학적인 구조?)' 가 'cube (정육면체)' 와 같기 때문이라고 합니다. 보다 자세한 내용은 위키피디아의 [Cuboid](https://en.wikipedia.org/wiki/Cuboid) 또는 [직육면체](https://ko.wikipedia.org/wiki/직육면체) 를 참고하기 바랍니다.

[^nonoverridden-computed-properties]: 본문에서는 '재정의 하지 않은 계산 속성 (nonoverridden computed properties)' 이라고 뭔가 굉장히 어려운 말을 사용했는데, 그냥 개발자가 직접 만든 계산 속성은 모두 이 '재정의 하지 않은 계산 속성' 입니다. 본문의 내용은, 일반적으로 자신이 직접 만든 '계산 속성' 에는 따로 '속성 관찰자' 를 추가할 필요가 없다는 의미입니다. '계산 속성' 은 말 그대로 자신이 직접 값을 계산하는 것으로 값의 변화를 자기가 직접 제어하는 셈입니다. 그러니까 굳이 값의 변화를 관찰할 필요가 없습니다.
