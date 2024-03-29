---
layout: post
comments: true
title:  "Swift 5.7: Properties (속성)"
date:   2020-05-30 10:00:00 +0900
categories: Swift Language Grammar Property
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html) 부분[^Properties]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Properties (속성)

_속성 (properties)_ 은 값을 특별한 클래스, 구조체, 또는 열거체와 결합합니다. 저장 속성은 인스턴스의 일부분으로써 상수와 변수 값을 저장하는 반면, 계산 속성은 값을 (저장한다기 보단) 계산합니다. 계산 속성은 클래스, 구조체, 및 열거체에서 제공합니다. 저장 속성은 클래스와 구조체에서만 제공합니다.

저장 속성과 계산 속성은 대체로 특별한 타입의 인스턴스와 결합합니다. 하지만, 속성은 타입 그 자체와 결합할 수도 있습니다. 그러한 속성을 타입 속성이라고 합니다.

여기다, 속성 값이 바뀌는 걸 감시하는 속성 관찰자 (property observers) 를 정의할 수 있어, 사용자 정의 행동으로 응답할 수도 있습니다. 자신이 직접 정의한 저장 속성, 및 상위 클래스로부터 상속한 하위 클래스 속성에, 속성 관찰자를 추가할 수도 있습니다.

속성 포장 (property wrapper) 을 사용하여 여러 속성에서 획득자 (getter) 와 설정자 (setter) 코드를 재사용할 수도 있습니다.

### Stored Properties (저장 속성)

가장 단순한 형식의, 저장 속성은, 특별한 클래스나 구조체 인스턴스의 일부분으로써 저장하는 상수나 변수입니다. 저장 속성은 (`var` 키워드로 도입한) _변수 저장 속성 (variable stored properties)_ 이거나 (`let` 키워드로 도입한) _상수 저장 속성 (constant stored properties)_ 일 수 있습니다.

[Default Property Values (기본 속성 값)]({% post_url 2016-01-23-Initialization %}#default-property-values-기본-속성-값) 에서 설명한 것처럼, 저장 속성을 정의하면서 기본 값 (default value) 을 제공할 수 있습니다. 초기화 중에 저장 속성의 초기 값을 설정하고 수정할 수도 있습니다. [Assigning Constant Properties During Initialization (초기화 중에 상수 속성 할당하기)]({% post_url 2016-01-23-Initialization %}#assigning-constant-properties-during-initialization-초기화-중에-상수-속성-할당하기) 에서 설명한 것처럼, 이는 상수 저장 속성에서도 참입니다.

아래 예제는, 생성 후엔 길이를 바꿀 수 없는 정수 범위를 설명한, `FixedLengthRange` 라는 구조체를 정의합니다:

```swift
struct FixedLengthRange {
  var firstValue: Int
  let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// 이 범위는 정수 값 0, 1, 2 를 나타냄
rangeOfThreeItems.firstValue = 6
// 이제 범위는 정수 값 6, 7, 8 을 나타냄
```

`FixedLengthRange` 인스턴스에는 `firstValue` 라는 변수 저장 속성과 `length` 라는 상수 저장 속성이 있습니다. 위 예제에서, `length` 는, 상수 속성이기 때문에, 새 범위를 생성할 때 초기화하고 그 후엔 바꿀 수 없습니다.

#### Stored Properties of Constant Structure Instances (상수 구조체 인스턴스의 저장 속성)

구조체 인스턴스를 생성하고 그 인스턴스를 상수에 할당하면, 변수 속성으로 선언한 경우에도, 인스턴스의 속성을 수정할 수 없습니다:

```swift
let rangeOfFourItems = FixedLengthRange(firstValue : 0, length: 4)
// 이 범위는 정수 값 0, 1, 2, 3 을 나타냄
rangeOfFourItems.firstValue = 6
// 이는, firstValue 가 변수 속성일지라도, 에러를 보고할 것임
```

(`let` 키워드로) `rangeOfFourItems` 을 상수로 선언하기 때문에, `firstValue` 가 변수 속성일지라도, 자신의 `firstValue` 속성을 바꾸는 게 불가능합니다.

이런 동작은 구조체가 _값 타입 (value types)_ 이기 때문입니다. 값 타입의 인스턴스를 상수로 표시할 땐, 자신의 모든 속성도 그렇습니다.

_참조 타입 (reference types)_ 인, 클래스는 이와 똑같지 않습니다. 참조 타입의 인스턴스를 상수에 할당하면, 그 인스턴스의 변수 속성을 여전히 바꿀 수 있습니다.

#### Lazy Stored Properties (느긋한 저장 속성)

_느긋한 저장 속성 (lazy stored property)_ 은 최초로 사용하기 전까진 초기 값을 계산하지 않는 속성입니다. 선언 앞에 `lazy` 수정자 (modifier) 를 작성하여 느긋한 저장 속성을 지시합니다.

> 느긋한 속성은 반드시 항상 (`var` 키워드를 가진) 변수로 선언해야 하는데, 인스턴스 초기화를 완료하기 전까진 자신의 초기 값을 못가져올 수도 있기 때문입니다. 상수 속성은 반드시 항상 초기화 완료 _전에 (before)_ 값을 가져야 하므로, 느긋하다고 (lazy) 선언할 수 없습니다.

느긋한 속성은 속성의 초기 값이 외부 요인에 의존해서 인스턴스 초기화를 완료하기 전까지 값을 알 수 없을 때 유용합니다. 느긋한 속성은 속성의 초기 값이 복잡하거나 비싼 계산 비용을 요구해서 필요한 게 아닌 한 그 전까지 수행하지 않는게 좋을 때도 유용합니다.

아래 예제는 느긋한 저장 속성을 사용하여 불필요한 복잡한 클래스의 초기화를 피합니다. 이 예제는 `DataImporter` 와 `DataManager` 라는 두 개의 클래스를 정의하는데, 어느 것도 완전체를 보여준 건 아닙니다:

```swift
class DataImporter {
  /*
  DataImporter 는 외부 파일에서 자료를 불러오는 클래스입니다.
  이 클래스의 초기화에는 유의미한 양의 시간이 걸린다고 가정합니다.
  */
  var filename = "data.txt"
  // DataImporter 클래스는 여기서 자료 불러오는 기능을 제공할 것임
}

class DataManager {
  lazy var importer = DataImporter()
  var data = [String]()
  // DataManager 클래스는 여기서 자료 관리 기능을 제공할 것임
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// importer 속성의 DataImporter 인스턴스는 아직 생성하지 않음
```

`DataManager` 클래스에는 `data` 라는 저장 속성이 있는데, 이는 새로운, 빈 `String` 값 배열로 초기화됩니다. 나머지 기능을 보여주진 않지만, `DataManager` 클래스의 목적은 이 `String` 자료 배열의 접근을 제공하고 이를 관리하는 것입니다.

`DataManager` 클래스의 일부 기능은 파일에서 자료를 불러오는 능력입니다. 이 기능은, 초기화에 유의미한 양의 시간이 걸린다고 가정한, `DataImporter` 클래스가 제공합니다. 이는 `DataImporter` 인스턴스를 초기화할 때 `DataImporter` 인스턴스가 파일을 열고 그 내용을 메모리로 읽어들일 필요가 있을 지도 모르기 때문입니다.

`DataManager` 인스턴스가 파일에서 불러오지 않은 자료를 관리할 가능성도 있기 때문에, `DataManager` 는 `DataManager` 스스로를 생성할 때 새 `DataImporter` 인스턴스를 생성하지 않습니다. 그 대신, `DataImporter` 인스턴스를 최초로 사용할 경우 그 때 생성하는 게 더 말이 됩니다.

`lazy` 수정자로 표시하기 때문에, `filename` 속성을 조회할 때 같이, `importer` 속성에 최초로 접근할 때에만 `importer` 속성의 `DataImporter` 인스턴스를 생성합니다:

```swift
print(manager.importer.filename)
// importer 속성의 DataImporter 인스턴스가 이제 막 생성됨
// "data.txt" 를 인쇄함
```

> `lazy` 수정자로 표시한 속성이 아직 초기화가 안됐는데 동시에 여러 개의 쓰레드가 접근할 경우, 속성이 한 번만 초기화될 거라는 보증은 없습니다.

#### Stored Properties and Instance Variables (저장 속성과 인스턴스 변수)

오브젝티브-C 에 대한 경험이 있다면, 클래스 인스턴스 일부분으로 값과 참조를 저장하는데 _두 가지 (two)_ 방식을 제공하는 걸 알고 있을 겁니다.[^instance-variables] 속성에다가, 속성에 저장한 값의 백업용 저장 공간인 인스턴스 변수도 사용할 수 있습니다.

스위프트는 이 개념들을 단일한 속성 선언으로 통일했습니다. 스위프트 속성은 해당하는 인스턴스 변수를 가지지 않으며, 속성의 백업용 저장 공간에 직접 접근하지 않습니다. 이런 접근법은 서로 다른 상황에서의 값 접근 방법에 대한 혼동을 피하게 하며 속성 선언을 단일, 정의문으로 단순화합니다. 속성의-이름, 타입, 및 메모리 관리 성질을 포함한-모든 정보는 타입 정의의 일부분으로써 단일 위치에 정의합니다.

### Computed Properties (계산 속성)

저장 속성에 더해, 클래스, 구조체, 및 열거체는, 실제론 값을 저장하지 않는, _계산 속성 (computed properties)_ 도 정의할 수 있습니다. 이는, 그 대신, 간접적으로 다른 속성과 값을 가져오고 설정하는 '획득자 (getter) 와 옵션인 설정자 (setter)'[^optional-setter] 를 제공합니다.

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
// "square.origin is now at (10.0, 10.0)" 를 인쇄함
```

이 예제는 기하학 도형과 작업하기 위한 구조체 세 개를 정의합니다:

* `Point` 는 한 점의 x- 및 y-좌표를 은닉합니다.
* `Size` 는 `width` 와 `height` 를 은닉합니다.
* `Rect` 는 원점과 크기로 직사각형을 정의합니다.

`Rect` 구조체는 `center` 라는 계산 속성도 제공합니다. `Rect` 의 현재 중심은 자신의 `origin` 과 `size` 로 항상 결정할 수 있으므로, 명시적인 `Point` 값으로 중심점을 저장할 필요가 없습니다. 그 대신, `Rect` 는 `center` 라는 계산 변수를 위한 사용자 정의 획득자 및 설정자를 정의하여, 직사각형의 `center` 가 마치 실제 저장 속성인 것처럼 작업할 수 있게 합니다.

위 예제에선 `square` 라는 새로운 `Rect` 변수를 생성합니다. `square` 변수는 `(0, 0)` 이라는 원점과, `10` 이라는 폭과 높이로, 초기화됩니다. 아래 그림의 파란색 정사각형이 이 정사각형을 나타냅니다.

그런 다음 점 구문 (`square.center`) 을 통해 `square` 변수의 `center` 속성에 접근하는데, 이는 `center` 의 획득자를 호출하도록 하여, 현재 속성 값을 가져옵니다. 기존 값을 반환하기 보단, 실제로 획득자는 정사각형 중심을 나타내는 새 `Point` 를 계산하여 반환합니다. 위에서 볼 수 있는 것처럼, 획득자는 `(5, 5)` 라는 올바른 중심점을 반환합니다.

그런 다음 `center` 속성에 `(15, 15)` 라는 새로운 값을 설정하는데, 이는 정사각형을 오른쪽 위의, 아래 도표에서 오렌지 정사각형이 보여준 새 위치로, 이동시킵니다. `center` 속성을 설정하면 `center` 의 설정자를 호출하는데, 이는 `origin` 이라는 저장 속성의 `x` 와 `y` 값을 수정하여, 정사각형을 새 위치로 이동시킵니다.

![computed properties](/assets/Swift/Swift-Programming-Language/Properties-computed-property.png)

#### Shorthand Setter Declaration (짧게 줄인 설정자 선언)

설정할 새 값의 이름을 계산 속성 설정자가 정의하지 않으면, `newValue` 라는 기본 이름을 사용합니다. 이 짧게 줄인 표기법의 이점을 취한 대안 버전의 `Rect` 구조체는 이렇습니다:

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

#### Shorthand Getter Declaration (짧게 줄인 획득자 선언)

획득자의 전체 본문이 단일 표현식이면, 획득자가 그 표현식을 암시적으로 반환합니다. 이 짧게 줄인 표기법과 짧게 줄인 설정자 표기법의 이점을 취한 또 다른 버전의 `Rect` 구조체는 이렇습니다:

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

획득자에서 `return` 을 생략하는 건, [Functions With an Implicit Return (암시적으로 반환하는 함수)]({% post_url 2020-06-02-Functions %}#functions-with-an-implicit-return-암시적으로-반환하는-함수) 에서 설명한 것처럼, 함수에서 `return` 을 생략하는 것과 동일한 규칙을 따릅니다.

#### Read-Only Computed Properties (읽기-전용 계산 속성)

획득자는 있지만 설정자가 없는 계산 속성을 _읽기-전용 계산 속성 (read-only computed property)_ 이라고 합니다. 읽기-전용 계산 속성은 항상 값을 반환하며, 점 구문을 통해 접근할 수 있지만, 다른 값을 설정할 순 없습니다.

> 읽기-전용 계산 속성을 포함한-계산 속성은, 값이 고정된게 아니기 때문에, 반드시 `var` 키워드를 써서 변수 속성으로 선언해야 합니다. 인스턴스 초기화의 일부분으로 한 번 설정하고 나면 자신의 값을 바꿀 수 없다고 지시하는, 상수 속성에만 `let` 키워드를 사용합니다.

`get` 키워드와 중괄호를 제거함으로써 읽기-전용 계산 속성의 선언을 단순화할 수 있습니다:[^simplify]

```swift
struct Cuboid {
  var width = 0.0, height = 0.0, depth = 0.0
  var volume: Double {
    return width * height * depth
  }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// "the volume of fourByFiveByTwo is 40.0" 를 인쇄함
```

이 예제는, `width`, `height`, 및 `depth` 속성으로 3-차원 직사각형 상자를 나타내는, `Cuboid` 라는 새로운 구조체를 정의합니다. 이 구조체에는, 직육면체[^cuboid] 의 현재 부피를 계산하여 반환하는, `volume` 이라는 읽기-전용 계산 속성이 있습니다. 특별한 한 `volume` 값에 대해 어떤 `width`, `height`, 및 `depth` 값을 사용해야할 지 헷갈리기 때문에, `volume` 이 설정 가능하다는 건 말이 안됩니다.[^be-settable] 그럼에도 불구하고, 현재 계산한 부피를 외부 사용자가 발견할 수 있도록 `Cuboid` 가 읽기-전용 계산 속성을 제공하는 게 유용합니다.

### Property Observers (속성 관찰자)

속성 관찰자는 속성 값이 바뀌는 걸 관찰하여 응답합니다. 속성 관찰자는 속성 값을 설정할 때마다, 새 값이 현재 속성 값과 똑같은 경우에도, 호출됩니다.

다음 장소에 속성 관찰자를 추가할 수 있습니다:

* 자신이 정의한 저장 속성
* 자신이 상속한 저장 속성
* 자신이 상속한 계산 속성

상속한 속성이면, 하위 클래스에서 그 속성을 재정의 (overriding) 함으로써 속성 관찰자를 추가합니다. 자신이 정의한 계산 속성이면, 관찰자를 생성하는 대신, 속성의 설정자로 값의 바뀜을 관찰하여 응답합니다. 속성을 재정의하는 건 [Overriding (재정의하기)]({% post_url 2020-03-31-Inheritance %}#overriding-재정의하기) 부분에서 설명합니다.

속성에 대해 다음 관찰자 중 하나만 정의할지 둘 다 정의할지 선택할 수 있습니다:

* `willSet` 은 값을 저장하기 직전에 호출합니다.
* `didSet` 은 새 값을 저장한 바로 뒤에 호출합니다.

`willSet` 관찰자를 구현하면, 새로운 속성 값을 상수 매개 변수로 전달합니다. `willSet` 구현부에서 이 매개 변수에 이름을 지정할 수 있습니다. 구현부에서 매개 변수 이름과 괄호를 작성하지 않으면, 매개 변수는 `newValue` 라는 기본 매개 변수 이름으로 쓸 수 있게 됩니다.

이와 비슷하게, `didSet` 관찰자를 구현하면, 예전 속성 값을 담은 상수 매개 변수를 전달합니다. 매개 변수에 이름을 붙이거나 `oldValue` 라는 기본 매개 변수 이름을 사용할 수도 있습니다. 자신의 `didSet` 관찰자 안에서 속성에 값을 할당하면, 방금 설정된 걸 새로 할당한 값으로 교체합니다.

> 상위 클래스 속성의 `willSet` 과 `didSet` 관찰자는, 상위 클래스 초기자를 호출한 후, 하위 클래스 초기자에서 속성을 설정할 때 호출됩니다. 상위 클래스 초기자를 호출하기 전, 클래스가 자신만의 속성을 설정하는 동안엔 이를 호출하지 않습니다.[^obervers-and-superclass]
>
> 초기자 맡김 (initializer delegation) 에 대한 더 많은 정보는, [Initializer Delegation for Value Types (값 타입을 위한 초기자 맡김)]({% post_url 2016-01-23-Initialization %}#initializer-delegation-for-value-types-값-타입을-위한-초기자-맡김) 과 [Initializer Delegation for Class Types (클래스 타입을 위한 초기자 맡김)]({% post_url 2016-01-23-Initialization %}#initializer-delegation-for-class-types-클래스-타입을-위한-초기자-맡김) 부분을 보도록 합니다.

다음은 `willSet` 과 `didSet` 의 실제 사례입니다. 아래 예제는, 사람이 산책하는 동안의 총 걸음 수를 추적하는, `StepCounter` 라는 새로운 클래스를 정의합니다. 이 클래스는 일과 중에 사람의 운동을 추적하기 위해 만보계 (pedometer) 나 다른 걸음 측정기 (step counter) 에 있는 입력 자료를 사용할 지 모릅니다.

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
// About to set totalSteps to 200     // totalSteps 를 200 으로 설정하려고 함
// Added 200 steps                    // 200 걸음을 추가함
stepCounter.totalSteps = 360
// About to set totalSteps to 360     // totalSteps 를 360 으로 설정하려고 함
// Added 160 steps                    // 160 걸음을 추가함
stepCounter.totalSteps = 896
// About to set totalSteps to 896     // totalSteps 를 896 으로 설정하려고 함
// Added 536 steps                    // 536 걸음을 추가함
```

`StepCounter` 클래스는 `Int` 타입인 `totalSteps` 속성을 선언합니다. 이는 `willSet` 과 `didSet` 관찰자가 있는 저장 속성입니다.

`totalSteps` 의 `willSet` 과 `didSet` 관찰자는 새 값을 속성에 할당할 때마다 호출됩니다. 이는 새 값이 현재 값과 똑같은 경우에도 참입니다.

이 예제의 `willSet` 관찰자는 새로 다가올 값으로 `newTotalSteps` 라는 사용자 정의 매개 변수 이름을 사용합니다. 이 예제에선, 설정하려는 값을 단순히 인쇄합니다.

`totalSteps` 값을 갱신한 후 `didSet` 관찰자를 호출합니다. 이는 새 `totalSteps` 값과 예전 값을 비교합니다. 총 걸음 수가 증가했으면, 새 걸음 수가 얼마인지 표시하고자 메시지를 인쇄합니다. `didSet` 관찰자는 예전 값에 사용자 정의 매개 변수 이름을 제공하지 않고, `oldValue` 라는 기본 이름을 대신 사용합니다.

> 관찰자를 가진 속성을 '입-출력 (in-out) 매개 변수' 로 함수에 전달하면, `willSet` 과 `didSet` 관찰자를 항상 호출합니다. 이는: 함수 끝에서 값을 속성으로 항상 다시 작성하는 '입-출력 매개 변수의 복사-입력 복사-출력 (copy-in copy-out) 메모리 모델' (방식) 때문입니다. 입-출력 매개 변수 동작에 대한 자세한 논의는, [In-Out Parameters (입-출력 매개 변수)]({% post_url 2020-08-15-Declarations %}#in-out-parameters-입-출력-매개-변수) 부분을 보도록 합니다.

### Property Wrappers (속성 포장)

속성 포장은 속성 저장 방법을 관리하는 코드와 속성을 정의하는 코드 사이에 구분 계층 (layer of seperation) 을 추가합니다. 예를 들어, 쓰레드-안전성 검사를 제공하거나 자신의 실제 자료를 데이터베이스에 저장하는 속성이 있다면, 모든 속성에 대해 그 코드를 작성해야 합니다. 속성 포장을 사용할 땐, 관리 코드를 포장 정의할 때 한 번 작성하면, 여러 속성에 적용함으로써 그 관리 코드를 재사용합니다.[^property-wrapper]

속성 포장을 정의하려면, `wrappedValue` 속성을 정의한 구조체나, 열거체, 또는 클래스를 만듭니다. 아래 코드의, `TwelveOrLess` 구조체는 자기의 포장 값이 항상 12 보다 작거나 같은 수를 담는다는 걸 보장합니다. 더 큰 수를 저장하도록 요청하면, 12 를 대신 저장합니다.

```swift
@propertyWrapper
struct TwelveOrLess {
  private var number: Int
  init() { self.number = 0 }
  var wrappedValue: Int {
    get { return number }
    set { number = min(newValue, 12) }
  }
}
```

설정자는 새 값이 12 보다 작다는 걸 보장하며, 획득자는 저장한 값을 반환합니다.

> 위 예제의 `number` 선언은 변수를 `private` 이라고 표시하는데, 이는 `TwelveOrLess` 의 구현부 안에서만 `number` 를 사용하도록 보장합니다. 그 외 어떤 곳에서 작성한 코드든 `wrappedValue` 의 획득자와 설정자로 값에 접근(해야) 하며, 직접 `number` 를 사용할 순 없습니다. `private` 에 대한 정보는, [Access Control (접근 제어)]({% post_url 2020-04-28-Access-Control %}) 장을 보도록 합니다.

속성 앞에 포장 이름을 '특성 (attribute)'[^attribute] 으로 작성함으로써 속성에 포장을 적용합니다. 다음은, 직사각형의 차원이 항상 12 이하가 되도록 보장하고자 `TwelveOrLess` 속성 포장을 사용하여 저장하는 구조체입니다:

```swift
struct SmallRectangle {
  @TwelveOrLess var height: Int
  @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)
// "0" 을 인쇄함

rectangle.height = 10
print(rectangle.height)
// "10" 을 인쇄함

rectangle.height = 24
print(rectangle.height)
// "12" 를 인쇄함
```

`height` 와 `width` 속성은, `TwelveOrLess.number` 를 0 으로 설정한, `TwelveOrLess` 정의로부터 초기 값을 획득합니다. `TwelveOrLess` 의 설정자는 10 을 유효한 값으로 취급해서 `rectangle.height` 에 수 10 을 저장하는 건 작성한 대로 진행합니다. 하지만, 24 는 `TwelveOrLess` 가 허용한 것보다 커서, 24 를 저장하려는 건 `rectangle.height` 에, 허용한 가장 큰 값인, 12 를 대신 설정하는 것으로 끝납니다.

속성에 포장을 적용할 때, 컴파일러는 포장의 저장 공간을 제공하는 코드와 포장을 통해 속성의 접근을 제공하는 코드를 통합합니다. (속성 포장은 포장 값의 저장을 책임지므로, 그에 대한 통합 코드는 없습니다.) 특수한 특성 구문[^attribute-syntax] 의 이점을 취하지 않고, 속성 포장 동작을 사용하는 코드를 작성할 수도 있습니다. 예를 들어, 이전에 나열한 코드에서, `@TwelveOrLess` 를 특성으로 작성하는 대신, `TwelveOrLess` 구조체 안에 명시적으로 자신의 속성을 포장한 `SmallRectangle` 버전은 이렇습니다:[^explicitly-wrap]

```swift
struct SmallRectangle {
  private var _height = TwelveOrLess()
  private var _width = TwelveOrLess()
  var height: Int {
    get { return _height.wrappedValue }
    set { _height.wrappedValue = newValue }
  }
  var width: Int {
    get { return _width.wrappedValue }
    set { _width.wrappedValue = newValue }
  }
}
```

`_height` 와 `_width` 속성은, `TwelveOrLess` 라는, 속성 포장의 인스턴스를 저장합니다. `height` 와 `width` 의 획득자와 설정자는 `wrappedValue` 속성에 대한 접근을 포장합니다.

#### Setting Initial Values for Wrapped Properties (포장 속성에 초기 값 설정하기)

위 예제 코드는 `TwelveOrLess` 정의 안에서 `number` 에 초기 값을 주는 것으로 포장 속성의 초기 값을 설정합니다. 이 속성 포장을 사용하는 코드는, `TwelveOrLess` 가 포장한 속성에 다른 초기 값을 지정할 수 없습니다-예를 들어, `SmallRectangle` 정의에서 `height` 나 `width` 에 초기 값을 줄 순 없습니다. 초기 값 설정 및 다른 사용자 정의를 지원하려면, 속성 포장에 초기자를 추가할 필요가 있습니다. 다음은 `SmallNumber` 라고 `TwelveOrless` (의 기능을) 늘린 버전인데 초기자를 정의하여 포장 값과 최대 값을 설정합니다:

```swift
@propertyWrapper
struct SmallNumber {
  private var maximum: Int
  private var number: Int

  var wrappedValue: Int {
    get { return number }
    set { number = min(newValue, maximum) }
  }
  init() {
    maximum = 12
    number = 0
  }
  init(wrappedValue: Int) {
    maximum = 12
    number = min(wrappedValue, maximum)
  }
  init(wrappedValue: Int, maximum: Int) {
    self.maximum = maximum
    number = min(wrappedValue, maximum)
  }
}
```

`SmallNumber` 정의는-`init()`, `init(wrappedValue:)`, 및 `init(wrappedValue:maximum:)` 이라는-세 개의 초기자를 포함하며 아래 예제에서 포장 값과 최대 값을 설정할 때 이를 사용합니다. 초기자와 초기자 구문에 대한 정보는, [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 장을 보도록 합니다.

속성에 포장을 적용하면서 초기 값을 지정하지 않을 땐, 스위프트가 `init()` 초기자로 포장을 설정합니다. 예를 들면 다음과 같습니다:

```swift
struct ZeroRectangle {
  @SmallNumber var height: Int
  @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)
// "0 0" 를 인쇄함
```

`height` 와 `width` 를 포장한 `SmallNumber` 인스턴스는 `SmallNumber()` 호출로 생성합니다. 그 초기자 안의 코드는, 0 과 12 라는 기본 값을 사용하여, 초기 포장 값과 초기 최대 값을 설정합니다. 속성 포장은, 앞서 `SmallRectangle` 에서 `TwelveOrLess` 를 사용한 예제 같이, 여전히 모든 초기 값을 제공합니다. 그 예제완 달리, `SmallNumber` 는 속성을 선언하는 부분에서 그 초기 값을 작성하는 것도 지원합니다.

속성의 초기 값을 지정할 땐, 스위프트가 `init(wrappedValue:)` 초기자로 포장을 설정합니다. 예를 들면 다음과 같습니다:

```swift
struct UnitRectangle {
  @SmallNumber var height: Int = 1
  @SmallNumber var width: Int = 1
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)
// "1 1" 를 인쇄함
```

포장을 가진 속성에 `= 1` 를 작성할 땐, `init(wrappedValue:)` 초기자의 호출이라고 번역합니다. `height` 와 `width` 를 포장한 `SmallNumber` 인스턴스는 `SmallNumber(wrappedValue: 1)` 호출로 생성합니다. 초기자는 여기서 지정한 포장 값을 사용하며, 12 라는 기본 최대 값을 사용합니다.

사용자 정의 특성 (attribute) 뒤의 괄호 안에 인자를 작성할 땐, 스위프트가 그 인자를 받는 초기자로 포장을 설정합니다. 예를 들어, 초기 값과 최대 값을 제공하는 경우, 스위프트가 `init(wrappedValue:maximum:)` 초기자를 사용합니다:

```swift
struct NarrowRectangle {
  @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
  @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
// "2 3" 를 인쇄함

narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)
// "5 4" 를 인쇄함
```

`height` 를 포장한 `SmallNumber` 인스턴스는 `SmallNumber(wrappedValue: 2, maximum: 5)` 호출로 생성하며, `width` 를 포장힌 인스턴스는 `SmallNumber(wrappedValue: 3, maximum: 4)` 호출로 생성합니다.

속성 포장에 인자를 포함시켜서, 포장의 초기 상태를 설정하거나 포장을 생성할 때 다른 옵션을 전달할 수 있습니다. 이 구문이 속성 포장을 사용하는 가장 일반적인 방식입니다. 필요한 무슨 인자든 특성에 제공할 수 있으며, 이를 초기자로 전달합니다.

속성 포장 인자를 포함할 땐, 할당을 사용하여 초기 값을 지정할 수도 있습니다. 스위프트는 할당을 `wrappedValue` 인자인 것처럼 취급하여 초기자를 써서 포함한 인자를 받습니다. 예를 들면 다음과 같습니다:

```swift
struct MixedRectangle {
  @SmallNumber var height: Int = 1
  @SmallNumber(maximum: 9) var width: Int = 2
}

var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)
// "1" 를 인쇄함

mixedRectangle.height = 20
print(mixedRectangle.height)
// "12" 를 인쇄함
```

`height` 를 포장한 `SmallNumber` 인스턴스는 `SmallNumber(wrappedValue : 1)` 호출로 생성하는데, 이는 12 라는 기본 최대 값을 사용합니다. `width` 를 포장한 인스턴스는 `SmallNumber(wrappedValue: 2, maximum: 9)` 호출로 생성합니다.

#### Projecting a Value From a Property Wrapper (속성 포장에 있는 값 내밀기)

포장 값에 더하여, 속성 포장은 _내민 값 (projected value)_ 을 정의함으로써 추가 기능을 드러낼 수 있습니다-예를 들어, 데이터베이스 접근을 관리하는 속성 포장은 자신의 내민 값에 대하여 `flushDatabaseConnection()` 메소드를 드러낼 수 있습니다. 내민 값의 이름은, 달러 기호 (`$`) 로 시작한다는 것만 제외하면, 포장 값과 똑같습니다. 코드에서 `$` 로 시작하는 속성을 정의할 순 없기 때문에 내민 값이 자신이 정의한 속성을 간섭할 일은 절대로 없습니다.

위의 `SmallNumber` 예제에서, 너무 큰 수를 속성에 설정하려고 하면, 속성 포장이 저장 전에 수치 값을 적당히 조정합니다. 아래 코드는 `SmallNumber` 구조체에 `projectedValue` 속성을 추가하여 새 값을 속성에 저장하기 전에 속성 포장이 새 값을 적당히 조정했는지 추적합니다.

```swift
@propertyWrapper
struct SmallNumber {
  private var number: Int
  var projectedValue: Bool
  init() {
    self.number = 0
    self.projectedValue = false
  }
  var wrappedValue: Int {
    get { return number }
    set {
      if newValue > 12 {
        number = 12
        projectedValue = true
      } else {
        number = newValue
        projectedValue = false
      }
    }
  }
}
struct SomeStructure {
  @SmallNumber var someNumber: Int
}
var someStructure = SomeStructure()

someStructure.someNumber = 4
print(someStructure.$someNumber)
// "false" 를 인쇄함

someStructure.someNumber = 55
print(someStructure.$someNumber)
// "true" 를 인쇄함
```

`someStructure.$someNumber` 라고 작성하면 포장이 내민 값에 접근합니다. 4 와 같이 작은 수를 저장한 후엔, `someStructure.$someNumber` 값이 `false` 입니다. 하지만, 55 같이, 너무 큰 수를 저장하려고 한 후엔 내민 값이 `true` 입니다.

속성 포장은 어떤 타입의 값이든 자신이 내민 값으로 반환할 수 있습니다. 이 예제에선, 속성 포장이-수치 값을 적당히 조정했는지 라는-단 한 조각의 정보만을 드러내므로 불리언 (Boolean) 값을 자신의 내민 값으로 드러냅니다. 더 많은 정보를 드러낼 필요가 있는 포장은 어떠한 다른 자료 타입 인스턴스를 반환하거나, 포장의 인스턴스를 자신의 내민 값으로 드러내기 위해 `self` 를 반환할 수도 있습니다.

속성 획득자나 인스턴스 메소드 같이, 타입의 일부분인 코드에서 내민 값에 접근할 땐, 다른 속성에 접근할 때 같이, 속성 이름 앞의 `self.` 를 생략할 수 있습니다. 다음 예제에 있는 코드는 `height` 와 `width` 포장의 내민 값을 `$height` 와 `$width` 로 참조합니다:

```swift
enum Size {
  case small, large
}

struct SizedRectangle {
  @SmallNumber var height: Int
  @SmallNumber var width: Int

  mutating func resize(to size: Size) -> Bool {
    switch size {
    case .small:
      height = 10
      width = 20
    case .large:
      height = 100
      width = 100
    }
    return $height || $width
  }
}
```

속성 포장 구문은 그냥 획득자와 설정자가 있는 속성을 위한 수월한 구문일 뿐이기 때문에, `height` 와 `width` 로의 접근은 다른 어떤 속성으로의 접근과 똑같이 동작합니다. 예를 들어, `resize(to:)` 코드는 자신의 속성 포장을 써서 `height` 와 `width` 에 접근합니다. `resize(to: .large)` 를 호출하면, `.large` 라는 switch 문 case 절이 직사각형의 높이와 폭을 100 으로 설정합니다. 포장 (wrapper) 은 그 속성 값이 12 보다 커지는 걸 막고, 자신이 값을 적당히 조정한 사실을 기록하고자, 내민 값을 `true` 로 설정합니다. `resize(to:)` 끝에서, 반환문이 `$heigh` 와 `$width` 를 검사하여 속성 포장이 `height` 나 `width` 중 어느 하나를 적당히 조정했는 지 결정합니다. 

### Global and Local Variables (전역 변수와 지역 변수)

위에서 설명한 속성을 계산하고 관찰하는 능력은 _전역 변수 (global variables)_ 와 _지역 변수 (local variables)_ 에서도 사용 가능합니다. 전역 변수는 어떤 함수나, 메소드, 클로저, 및 타입 밖에서 정의한 변수입니다. 지역 변수는 함수나, 메소드, 및 클로저 안에서 정의한 변수입니다.

이전 장에서 마주친 전역 변수와 지역 변수는 모두 _저장 변수 (stored variables)_ 였습니다. 저장 변수는, 저장 속성 같이, 정해진 타입의 값에 저장 공간을 제공하며 그 값을 설정하고 가져오는 걸 허용합니다.

하지만, 전역이나 지역 중 어디서든, _계산 변수 (computed variables)_ 를 정의할 수도 저장 변수의 관찰자를 정의할 수도 있습니다. 계산 변수는, 자신의 값을 저장하기 보단, 계산하며, 계산 속성과 똑같은 식으로 작성합니다.

> 전역 상수와 변수는, [Lazy Stored Properties (느긋한 저장 속성)](#lazy-stored-properties-느긋한-저장-속성) 과 비슷한 관례에 따라, 항상 느긋하게 (lazily) 계산합니다. 느긋한 저장 속성과 달리, 전역 상수와 변수를 `lazy` 수정자로 표시할 필요는 없습니다.
>
> 지역 상수와 변수는 절대로 느긋하게 계산하지 않습니다.

전역 변수나 계산 변수가 아닌, 지역 저장 변수에 속성 포장을 적용할 수 있습니다. 예를 들어, 아래 코드의, `myNumber` 는 `SmallNumber` 를 속성 포장으로 사용합니다. 

```swift
func someFunction() {
  @SmallNumber var myNumber: Int = 0

  myNumber = 10 
  // 이제 myNumber 는 10 임

  myNumber = 24
  // 이제 myNumber 는 12 임 
}
```

`SmallNumber` 를 속성에 적용할 때 같이, `myNumber` 값에 10 을 설정하는 건 유효합니다. 12 보다 높은 값은 속성 포장이 허용하지 않기 때문에, 24 대신 12 를 `myNumber` 에 설정합니다.

### Type Properties (타입 속성)

인스턴스 속성은 한 특별한 타입의 인스턴스에 속하는 속성입니다. 그 타입의 인스턴스를 새로 생성할 때마다, 다른 어떤 인스턴스와도 구분된, 자신만의 속성 값 집합을 가지게 됩니다.

그 타입의 어떤 한 인스턴스가 아니라, 타입 그 자체에 속하는 속성을 정의할 수도 있습니다. 그 타입의 인스턴스를 얼마나 많이 만들던 간에, 이 속성의 복사본은 늘 단 하나만 있을 것입니다. 이러한 종류의 속성을 _타입 속성 (type properties)_ 이라고 합니다.

타입 속성은, (C 의 정적 상수 같이) 모든 인스턴스가 사용할 수 있는 상수 속성, 또는 (C 의 정적 변수 같이) 그 타입의 모든 인스턴스에 값을 전역으로 저장하는 변수 속성 같이, 한 특정한 타입의 _모든 (all)_ 인스턴스에 보편적인 (universal) 값을 정의하기에 유용합니다.

저장 타입 속성은 변수 또는 상수일 수 있습니다. 계산 타입 속성은, 계산 인스턴스 속성과 똑같이, 항상 변수 속성으로 선언합니다.

> 저장 인스턴스 속성과 달리, 저장 타입 속성엔 반드시 기본 값을 항상 줘야 합니다. 이는 타입 그 자체엔 초기화 시간에 저장 타입 속성에 값을 할당할 수 있는 초기자가 없기 때문입니다.
>
> 저장 타입 속성은 최초로 접근할 때에 느긋하게 (lazily) 초기화됩니다. 동시에 여러 쓰레드가 접근할 때도, 단 한 번만 초기화하는 걸 보증하며, `lazy` 수정자로 표시할 필요도 없습니다.

#### Type Property Syntax (타입 속성 구문)

C 와 오브젝티브-C 에선, 타입과 결합한 정적 상수와 변수를 _전역 (global)_ 정적 변수로 정의합니다. 스위프트에선, 하지만, 타입 속성을 타입 정의의 일부분인, 타입의 바깥 중괄호 안에서, 작성하며, 각각의 타입 속성 영역은 자신이 지원하는 타입 영역으로 명시됩니다.

타입 속성은 `static` 키워드로 정의합니다. 클래스 타입의 계산 타입 속성이면, `class` 키워드를 대신 사용하여 상위 클래스 구현을 하위 클래스가 재정의하도록 허용할 수 있습니다. 아래 예제는 저장 및 계산 타입 속성의 구문을 보여줍니다:

```swift
struct SomeStructure {
  static var storedTypeProperty = "Some value."
  static var computedTypeProperty: Int {
    return 1
  }
}
enum SomeEnumeration {
  static var storedTypeProperty = "Some value."
  static var computedTypeProperty: Int {
    return 6
  }
}
class SomeClass {
  static var storedTypeProperty = "Some value."
  static var computedTypeProperty: Int {
    return 27
  }
  class var overrideableComputedTypeProperty: Int {
    return 107
  }
}
```

> 위의 계산 타입 속성 예제는 읽기-전용 (read-only) 계산 타입 속성을 위한 거지만, 계산 인스턴스 속성을 위한 것과 동일한 구문으로 읽고-쓰기 (read-write) 계산 타입 속성을 정의할 수도 있습니다.

#### Querying and Setting Type Properties (타입 속성 조회하기 및 설정하기)

타입 속성은, 그냥 인스턴스 속성인 것 같이, 점 구문으로 조회하고 설정합니다. 하지만, 타입 속성은, 그 타입의 인스턴스에서가 아니라, _타입 (type)_ 에 대해서 조회하고 설정합니다. 예를 들면 다음과 같습니다:

```swift
print(SomeStructure.storedTypeProperty)
// "Some value." 를 인쇄함
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
// "Another value." 를 인쇄함
print(SomeEnumeration.computedTypeProperty)
// "6" 을 인쇄함
print(SomeClass.computedTypeProperty)
// "27" 을 인쇄함
```

뒤따르는 예제는 구조체의 일부분으로 두 개의 저장 타입을 사용하여 '다수의 음향 채널을 위한 음량 측정기 (audio level meter) 를 모델링합니다. 각각의 채널은 `0` 부터 `10` 까지를 포함한 정수 음량 (audio level)' 을 가집니다.

아래 그림은 이 두 음향 채널을 조합하여 스테레오 음량 측정기를 모델링할 수 있는 방법을 묘사합니다. 채널 음량이 `0` 일 땐, 그 채널에 아무런 불도 들어오지 않습니다. 음량이 `10` 일 땐, 그 채널의 모든 불이 들어옵니다. 이 그림에서, 왼쪽 채널의 현재 량은 `9` 이고, 오른쪽 채널은 현재 량은 `7` 입니다:

![audio level meter](/assets/Swift/Swift-Programming-Language/Properties-audio-level-meter.jpg)

위에서 설명한 음향 채널을 `AudioChannel` 구조체 인스턴스로 나타냅니다:

```swift
struct AudioChannel {
  static let thresholdLevel = 10
  static var maxInputLevelForAllChannels = 0
  var currentLevel: Int = 0 {
    didSet {
      if currentLevel > AudioChannel.thresholdLevel {
        // 새로운 음량의 상한을 임계치까지로 제한함
        currentLevel = AudioChannel.thresholdLevel
      }
      if currentLevel > AudioChannel.maxInputLevelForAllChannels {
        // 이를 새로운 전체 최대 입력량으로 저장함
        AudioChannel.maxInputLevelForAllChannels = currentLevel
      }
    }
  }
}
```

`AudioChannel` 구조체는 자신의 기능을 지원하는 두 개의 저장 타입 속성을 정의합니다. 첫 번째인, `thresholdLevel` 은, 음량이 가질 수 있는 최대 임계 값을 정의합니다. 모든 `AudioChannel` 인스턴스에서 이 값은 `10` 이라는 상수입니다. `10` 보다 높은 값을 가진 음향 신호가 들어 오면, (아래 설명처럼) 이 임계 값까지로 상한을 제한할 것입니다.

두 번째 타입 속성은 `maxInputLevelForAllChannels` 라는 변수 저장 속성입니다. 이는 _어떤 (any)_ `AudioChannel` 인스턴스에서 받은 최대 입력 값이든 계속 추적합니다. 초기 값은 `0` 으로 시작합니다.

`AudioChannel` 구조체는 `currentLevel` 이라는 저장 인스턴스 속성도 정의하는데, 이는 채널의 현재 음량을 `0` 부터 `10` 까지 정도로 나타냅니다.

`currentLevel` 속성은 `currentLevel` 값을 설정할 때마다 검사하는 `didSet` 속성 관찰자를 가집니다. 이 관찰자는 두 가지를 검사합니다:

* 새 `currentLevel` 값이 허용한 `thresholdLevel` 보다 크면, 속성 관찰자가 `currentLevel` 상한을 `thresholdLevel` 까지로 제한합니다.
* (상한을 제한한 후의) 새 `currentLevel` 값이 이전에 _어떤 (any)_ `AudioChannel` 인스턴스가 받은 값보다도 높으면, 속성 관찰자가 새 `currentLevel` 값을 `maxInputLevelForAllChannels` 타입 속성에 저장합니다.

> 이 두 검사 중 첫 번째에서, `didSet` 관찰자가 `currentLevel` 을 다른 값으로 설정합니다. 하지만, 이것이 관찰자를 다시 호출하도록 하진 않습니다.

`AudioChannel` 구조체를 사용하여, 스테레오 음향 시스템의 음량을 나타내는, `leftChannel` 과 `rightChennel` 이라는 두 음향 채널을 생성할 수 있습니다:

```swift
var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
```

_왼쪽 (left)_ 채널의 `currentLevel` 을 `7` 로 설정하면, `maxInputLevelForAllChannels` 타입 속성을 `7` 로 갱신하는 걸 볼 수 있습니다:

```swift
leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
// "7" 을 인쇄함
print(AudioChannel.maxInputLevelForAllChannels)
// "7" 을 인쇄함
```

_오른쪽 (right)_ 채널의 `currentLevel` 을 `11` 로 설정하려 하면, 오른쪽 채널의 `currentLevel` 속성이 최대 값 `10` 으로 위가 막히며, `maxInputLevelForAllChannels` 타입 속성은 `10` 으로 업데이트하는 걸 볼 수 있습니다:

```swift
rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
// "10" 을 인쇄함
print(AudioChannel.maxInputLevelForAllChannels)
// "10" 을 인쇄함
```

### 다음 장

[Methods (메소드) > ]({% post_url 2020-05-03-Methods %})

### 참고 자료

[^Properties]: 이 글에 대한 원문은 [Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html) 에서 확인할 수 있습니다.

[^instance-variables]: 이 부분은 오브젝티브-C 나 C++ 같은 객체 지향 언어에 대한 설명이므로, 객체 지향 언어에 익숙하지 않으면 넘어가도 됩니다. 객체 지향 언어에서는 '객체 안에서만 접근 가능한 내부 변수' 와 '객체 외부와의 인터페이스를 담당하는 속성' 이란 두 가지 방식으로 값을 저장합니다. 속성에서 인터페이스를 담당하는 부분이 '설정자 (setter) 와 획득자 (getter)' 입니다. 스위프트에서는 이 두 가지를 '속성' 하나로 통합했다는 의미입니다.

[^optional-setter]: '옵션인 설정자 (optional setter)' 는 설정자는 가질 수도 있고 안가질 수도 있기 때문입니다. 참고로, 여기서의 'optional' 은 스위프트의 옵셔널 타입과는 (직접적으로) 상관 없습니다.

[^simplify]: 이 예제에 있는 읽기-전용 계산 속성은 단일 표현식이기도 해서 `return` 키워드도 생략할 수 있습니다. 앞서 [Shorthand Getter Declaration (짧게 줄인 획득자 선언)](#shorthand-getter-declaration-짧게-줄인-획득자-선언) 에서 전체 획득자 본문이 단일 표현식이면 `return` 을 생략할 수 있다고 했는데, 전체 계산 속성 본문도 마찬가지입니다.

[^cuboid]: 'cuboid' 는 수학 용어로 '직육면체' 를 의미합니다. 직육면체는 모든 면이 직사각형인 기하학 도형을 말하며, 이름이 'cuboid' 인 건 기하학 구조의 일종인 '다면체 그래프 (polyhedral graph)' 가 '정육면체 (cube)' 와 같기 때문입니다. 보다 자세한 내용은, 위키피디아의 [Cuboid](https://en.wikipedia.org/wiki/Cuboid) 항목과 [직육면체](https://ko.wikipedia.org/wiki/직육면체) 항목을 보도록 합니다.

[^nonoverridden-computed-properties]: 본문에서는 '재정의 하지 않은 계산 속성 (nonoverridden computed properties)' 이라고 뭔가 굉장히 어려운 말을 사용했는데, 그냥 개발자가 직접 만든 계산 속성은 모두 이 '재정의 하지 않은 계산 속성' 입니다. 본문의 내용은, 일반적으로 자신이 직접 만든 '계산 속성' 에는 따로 '속성 관찰자' 를 추가할 필요가 없다는 의미입니다. '계산 속성' 은 말 그대로 자신이 직접 값을 계산하는 것으로 값의 변화를 자기가 직접 제어하는 셈입니다. 그러니까 굳이 값의 변화를 관찰할 필요가 없습니다.

[^property-wrapper]: 스위프트에서, 본문에서 예를 든 관리 코드 등은 언어 외부의 프레임웍에서 이미 제공하는 경우가 많습니다. 본문에 있는 쓰레드-안전성 검사와 데이터베이스 저장의 경우, 각각 [Dispatch](https://developer.apple.com/documentation/dispatch)[^dispatch] 와 [Core Data](https://developer.apple.com/documentation/coredata) 라는 프레임웍으로 제공하는 기능입니다. (쓰레드-안전성 검사는 최근에 생긴 'Concurrency' 를 통해 언어 차원에서 기능을 제공하고 있기도 합니다.)속성 포장은 자신이 직접 만들 수도 있지만, 보통은 이렇게 스위프트 언어 외부에서 제공하는 부가 기능을 사용할 때 많이 사용하게 됩니다.

[^dispatch]: 예전에는 [Grand Central Dispatch (GCD)](https://en.wikipedia.org/wiki/Grand_Central_Dispatch) 라는 용어를 많이 사용하였는데, 최근에는 'Dispatch' 라고만 하고 있으며, [Dispatch](https://developer.apple.com/documentation/dispatch) 프레임웍 문서에서 'Dispatch' 를 'Grand Central Dispatch (GCD)' 라고도 한다고 설명하고 있습니다.

[^obervers-and-superclass]: 이 개념은 스위프트 클래스의 '2-단계 초기화' 와 관련이 깊습니다. 2-단계 초기화는, 먼저 자신의 속성을 초기화하고 상위 클래스의 초기자를 호출하며, 그런 다음 이어서 상위 클래스의 속성을 다시 바꾸는 과정을 거치는 것을 말합니다. 즉 본문의 내용은 상위 클래스 속성의 `willSet` 과 `didSet` 은 '2-단계' 에서만 호출된다는 의미입니다. '2-단계 초기화' 에 대한 더 자세한 정보는, [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 장에 있는 [Two-Phase Initialization (2-단계 초기화)](#two-phase-initialization-2-단계-초기화) 를 보도록 합니다.

[^be-settable]: 즉, `volumn` 은 획득자만 있는 읽기-전용 계산 속성이어야 말이 된다는 의미입니다.

[^attribute]: '특성 (attribute)' 는 스위프트 언어에서 지원하는 문법 양식입니다. 보다 자세한 내용은, [Attributes (특성)]({% post_url 2020-08-14-Attributes %}) 장을 보도록 합니다.

[^attribute-syntax]: '특수한 특성 구문 (special attribute syntax)' 을 사용하지 않는다는 건 위 예제에 있는 `@TwelveOrLess` 같은 걸 사용하지 않는다는 의미입니다.

[^explicitly-wrap]: 속성 포장을 사용하는 대신, 구조체가 자신의 속성을 명시적으로 포장하는 방식이, 이 장 맨 앞에서 설명한 예전 '객체 지향 프로그래밍 언어' 방식입니다.
