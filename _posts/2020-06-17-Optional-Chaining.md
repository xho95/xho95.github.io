---
layout: post
comments: true
title:  "Optional Chaining (옵셔널 사슬)"
date:   2020-06-17 10:00:00 +0900
categories: Swift Language Grammar Error Handling
---

{% include header_swift_book.md %}

## Optional Chaining (옵셔널 사슬)

_옵셔널 사슬 (optional chaining)_ 은 현재 `nil` 일지도 모르는 옵셔널의 속성과, 메소드, 및 첨자를 조회하여 호출하는 가공 과정입니다. 옵셔널이 값을 담고 있으면, 속성이나, 메소드, 또는 첨자 호출이 성공하고; 옵셔널이 `nil` 이면, 속성이나, 메소드, 또는 첨자 호출이 `nil` 을 반환합니다. 여러 개의 조회를 서로 사슬처럼 이을 수도 있으며, 사슬망의 어떤 고리라도 `nil` 이면 전체 사슬이 우아하게 실패합니다.[^gracefully-fail]

> 스위프트의 옵셔널 사슬은 오브젝티브-C 에서 `nil` 메시지를 보내는 것과 비슷하지만, 어떤 타입과도 작동하며, 성공이냐 실패냐를 검사할 수 있는 방식입니다.

### Optional Chaining as an Alternative to Forced Unwrapping (강제 포장 풀기의 대안인 옵셔널 사슬)

옵셔널 사슬을 지정하려면 옵셔널이 `nil`-이 아닐 경우 속성이나, 메소드, 또는 첨자를 호출하고 싶은 옵셔널 값 뒤에 물음표 (`?`) 를 두면 됩니다. 이는 옵셔널 값 뒤에 느낌표 (`!`) 를 둬서 그 값을 강제로 푸는 것과 매우 비슷합니다. 주요 차이점은 옵셔널 사슬은 옵셔널이 `nil` 일 때 우아하게 실패하는 반면, 강제 포장 풀기는 옵셔널이 `nil` 일 때 실행시간 에러를 발생시킨다는 겁니다.

옵셔널 사슬의 호출이 `nil` 값일 수도 있다는 사실을 반영하고자, 옵셔널 사슬의 호출 결과는 항상 옵셔널 값이며, 심지어 조회하고 있는 속성이나, 메소드, 또는 첨자가 옵셔널-아닌 값을 반환하더라도 그렇습니다. 이 옵셔널 반환 값을 써서 옵셔널 사슬의 호출이 성공인지 (반환된 옵셔널에 값이 담김), 아니면 사슬에 있는 `nil` 값으로 인해 성공하지 못했는지 (반환된 옵셔널 값이 `nil` 임) 검사할 수 있습니다.

특히, 옵셔널 사슬의 호출 결과는 예상한 반환 값과 타입은 똑같지만, 옵셔널로 포장되어 있습니다. 보통은 `Int` 를 반환하는 속성도 옵셔널 사슬을 통하여 접근할 때는 `Int?` 를 반환할 겁니다.

다음의 여러 코드 조각들은 옵셔널 사슬이 강제 포장 풀기와 어떻게 다르고 어떻게 성공을 검사하게 하는지 실제로 보여줍니다.

첫 번째로, 두 개의 클래스인 `Person` 과 `Residence` 를 정의합니다:

```swift
class Person {
  var residence: Residence?
}

class Residence {
  var numberOfRooms = 1
}
```

`Residence` 인스턴스엔 단 하나의 `Int` 속성인 `numberOfRooms` 가 있으며, 기본 값은 `1` 입니다. `Person` 인스턴스엔 `Residence?` 타입의 옵셔널 `residence` 속성이 있습니다.

새로운 `Person` 인스턴스를 생성하면, `residence` 속성의 기본이, 옵셔널인 덕에, `nil` 로 초기화됩니다. 아래 코드에서, `john` 의 `residence` 속성 값은 `nil` 입니다:

```swift
let john = Person()
```

이 사람의 `residence` 에 있는 `numberOfRooms` 속성에 접근하려고, `residence` 뒤에 느낌표를 둬서 강제로 값을 풀면, 실행시간 에러를 발생시키게 되는데, 이는 포장을 풀 아무런 `residence` 값도 없기 때문입니다:

```swift
let roomCount = john.residence!.numberOfRooms
// 이는 실행시간 에러를 발생시킵니다.
```

위 코드는 `john.residence` 에 `nil`-아닌 값이 있어서 `roomCount` 에 적절한 방 개수인 `Int` 값을 설정할 때 성공합니다. 하지만, 이 코드는 `residence` 가 `nil` 일 땐 항상 실행시간 에러를 발생시키며, 이는 위에서 묘사한 것과 같습니다.

옵셔널 사슬은 `numberOfRooms` 값에 접근하기 위한 대안을 제공합니다. 옵셔널 사슬을 쓰려면, 느낌표 자리에 물음표를 쓰면 됩니다:

```swift
if let roomCount = john.residence?.numberOfRooms {
  print("John's residence has \(roomCount) room(s).")
} else {
  print("Unable to retrieve the number of rooms.")
}
// "Unable to retrieve the number of rooms." 를 인쇄함
```

이는 스위프트에게 옵셔널 `residence` 속성을 "사슬처럼 이어 (chain)" 서 `residence` 가 존재하면 `numberOfRooms` 의 값을 가져오라고 말합니다.

`numberOfRooms` 로 접근하려는 시도는 실패할 수도 있기 때문에, 옵셔널 사슬로 시도한 것의 타입은 `Int?`, 또는 "옵셔널 `Int`" 타입의 값을 반환합니다. `residence` 가 `nil` 일 땐, 위 예제 처럼, 이 옵셔널 `Int` 도 `nil` 이 되어서, `numberOfRooms` 로 접근하는게 불가능하다는 사실을 반영할 것입니다. 옵셔널 `Int` 는 옵셔널 연결[^optional-binding] 을 통해 접근하여 정수를 풀며 옵셔널-아닌 값을 `roomCount` 상수에 할당합니다.

이는 `numberOfRooms` 가 옵셔널-아닌 `Int` 라도 그렇다는 걸 기억하기 바랍니다.[^non-optional-int] 옵셔널 사슬을 통해 조회된다는 사실은 `numberOfRooms` 의 호출이 항상 `Int` 대신 `Int?` 를 반환한다는 걸 의미합니다.

`Residence` 인스턴스를 `john.residence` 에 할당하여, 더 이상 `nil` 값이 아니게 할 수 있습니다:

```swift
john.residence = Residence()
```

이제 `john.residence` 엔, `nil` 보단, 실제 `Residence` 인스턴스가 담겨 있습니다. 이전과 똑같이 옵셔널 사슬로 `numberOfRooms` 에 접근하려고 하면, 이제 반환한 `Int?` 에는 기본 `numberOfRooms` 값인 `1` 이 담겨 있을 겁니다:

```swift
if let roomCount = john.residence?.numberOfRooms {
  print("John's residence has \(roomCount) room(s).")
} else {
  print("Unable to retrieve the number of rooms.")
}
// "John's residence has 1 room(s)." 를 인쇄함
```

### Defining Model Classes for Optional Chaining (옵셔널 사슬을 모델링하는 클래스 정의하기)

옵셔널 사슬을 사용하여 한 단계 깊이 이상의 속성, 메소드, 및 첨자를 호출할 수 있습니다. 이는 서로 복잡하게 관련된 타입 모델 안의 하위 속성으로 파고 들어 가서, 그 하위 속성의 속성, 메소드, 및 첨자 접근이 가능한 지 검사하도록 합니다.

아래 코드 조각은, 여러 단계인 옵셔널 사슬 예제를 포함하여, 뒤이은 여러 예제에서 사용할 모델 클래스를 네 개 정의합니다. 이 클래스들은, 결합된 속성, 메소드, 및 첨자를 가진, `Room` 과 `Address` 클래스를 추가함으로써, 위에 있는 `Person` 과 `Residence` 모델을 확대합니다.

`Person` 클래스는 이전과 똑같이 정의합니다:

```swift
class Person {
  var residence: Residence?
}
```

`Residence` 클래스는 이전보다 더 복잡합니다. 이번엔, `Residence` 클래스가 `rooms` 라는 변수 속성을 정의하고, 이를 `[Room]` 타입의 빈 배열로 초기화합니다:

```swift
class Residence {
  var rooms = [Room]()
  var numberOfRooms: Int {
    return rooms.count
  }
  subscript(i: Int) -> Room {
    get {
      return rooms[i]
    }
    set {
      rooms[i] = newValue
    }
  }
  func printNumberOfRooms() {
    print("The number of rooms is \(numberOfRooms)")
  }
  var address: Address?
}
```

이 버전의 `Residence` 는 `Room` 인스턴스 배열을 저장하기 때문에, 저장 속성이 아니라, 계산 속성으로 `numberOfRooms` 속성을 구현합니다. `numberOfRooms` 계산 속성은 단순히 `rooms` 배열의 `count` 속성 값을 반환합니다.

자신의 `rooms` 배열 접근의 줄임말로, 이 버전의 `Residence` 는 요청한 `rooms` 배열 색인의 방에 접근하는 읽고-쓰기 (read-write) 첨자를 제공합니다.

이 버전의 `Residence` 는 `printNumberOfRooms` 라는 메소드도 제공하며, 이는 단순히 거주 공간의 방 개수를 인쇄합니다.

최종적으로, `Residence` 는 `address` 라는, `Address?` 타입의, 옵셔널 속성을 정의합니다. 이 속성의 `Address` 클래스 타입은 아래에 정의합니다.

`rooms` 배열에 사용된 `Room` 클래스는 `name` 이라는 하나의 속성 및, 그 속성에 적합한 방 이름을 설정하는 초기자를 가진, 단순한 클래스입니다:

```swift
class Room {
  let name: String
  init(name: String) { self.name = name }
}
```

이 모델의 마지막 클래스는 `Address` 라고 합니다. 이 클래스에는 `String?` 타입의 옵셔널 속성이 세 개 있습니다. 처음 두 속성인, `buildingName` 과 `buildingNumber` 는, 주소 부분에서 한 특별한 건물을 식별하기 위한 대안입니다. 세 번째 속성인, `street` 는, 그 주소의 거리 이름으로 사용합니다:

```swift
class Address {
  var buildingName: String?
  var buildingNumber: String?
  var street: String?
  func buildingIdentifier() -> String? {
    if let buildingNumber = buildingNumber, let street = street {
      return "\(buildingNumber) \(street)"
    } else if buildingName != nil {
      return buildingName
    } else {
      return nil
    }
  }
}
```

`Address` 클래스는 `buildingIdentifier()` 라는, `String?` 반환 타입을 가진, 메소드도 제공합니다. 이 메소드는 주소의 속성을 검사하여 `buildingName` 에 값이 있으면 이를, 또는 `buildingNumber` 와 `street` 둘 다에 값이 있으면 이들을 이어붙인 걸, 또는 그 외의 경우 `nil` 을 반환합니다.

### Accessing Properties Through Optional Chaining (옵셔널 사슬을 통하여 속성 접근하기)

[Optional Chaining as an Alternative to Forced Unwrapping (강제 포장 풀기의 대안인 옵셔널 사슬)](#optional-chaining-as-an-alternative-to-forced-unwrapping-강제-포장-풀기의-대안인-옵셔널-사슬) 에서 실증한 것처럼, 옵셔널 사슬을 사용하여 옵셔널 값의 속성에 접근하고, 그 속성 접근이 성공인지 검사할 수 있습니다.

위에서 정의한 클래스를 사용하여 새 `Person` 인스턴스를 생성하고, 이전 처럼 `numberOfRooms` 속성에 접근해 봅니다:

```swift
let john = Person()
if let roomCount = john.residence?.numberOfRooms {
  print("John's residence has \(roomCount) room(s).")
} else {
  print("Unable to retrieve the number of rooms.")
}
// "Unable to retrieve the number of rooms." 를 인쇄함
```

`john.residence` 가 `nil` 이기 때문에, 이 옵셔널 사슬 호출은 이전과 똑같이 실패합니다.

옵셔널 사슬을 통하여 속성 값을 설정하려고 시도할 수도 있습니다:

```swift
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress
```

이 예제에서, `john.residence` 가 현재 `nil` 이기 때문에, `john.residence` 의 `address` 속성을 설정하려는 시도가 실패할 것입니다.

할당은 옵셔널 사슬의 일부인데, 이는 `=` 연산자의 오른-쪽 코드는 아무 것도 평가하지 않는다는 의미입니다. 이 예제에서, `someAddress` 를 절대 평가하지 않는다는 걸 알아보긴 쉽지 않은데, 상수에 접근하는 건 어떤 부작용[^side-effect] 도 없기 때문입니다. 아래 나열한 건 동일한 할당을 하지만, 함수를 사용하여 주소를 생성합니다. 값을 반환하기 전에, 함수가 "Function was called" 를 인쇄하여, `=` 연산자의 오른-쪽을 평가했는지 알아보게 해줍니다.[^function-was-called]

```swift
func createAddress() -> Address {
  print("Function was called.")

  let someAddress = Address()
  someAddress.buildingNumber = "29"
  someAddress.street = "Acacia Road"

  return someAddress
}
john.residence?.address = createAddress()
```

아무 것도 인쇄하지 않기 때문에, `createAddress()` 함수를 호출하지 않는다고 말할 수 있습니다.

### Calling Methods Through Optional Chaining (옵셔널 사슬을 통하여 메소드 호출하기)

옵셔널 사슬을 사용하여 옵셔널 값의 메소드를 호출하고, 그 메소드 호출이 성공인지 검사할 수 있습니다. 그 메소드가 반환 값을 정의하지 않은 경우에도 이렇게 할 수 있습니다.

`Residence` 클래스의 `printNumberOfRooms()` 메소드는 `numberOfRooms` 의 현재 값을 인쇄합니다. 메소드를 보면 이렇습니다:

```swift
func printNumberOfRooms() {
  print("The number of rooms is \(numberOfRooms)")
}
```

이 메소드는 반환 타입을 지정하지 않습니다. 하지만, [Functions Without Return Values (반환 값이 없는 함수)]({% link docs/swift-books/swift-programming-language/functions.md %}#functions-without-return-values-반환-값이-없는-함수) 에서 설명한 것처럼, 반환 타입이 없는 함수와 메소드는 `Void` 라는 암시적인 반환 타입을 가집니다. 이는 이들이 `()` 라는 반환 값, 또는 빈 튜플을 반환한다는 의미입니다.

옵셔널 값에서 옵셔널 사슬로 이 메소드를 호출하면, 메소드 반환 타입이, `Void` 가 아니라, `Void?` 일 건데, 옵셔널 사슬을 통하여 호출할 땐 반환 값이 항상 옵셔널 타입이기 때문입니다. 이는, 메소드가 그 자체론 반환 값을 정의하지 않을지라도, `if` 문을 사용하여 `printNumberOfRooms()` 메소드 호출이 가능한지 검사할 수 있게 합니다. 메소드 호출이 성공했는지 알아보려면 `printNumberOfRooms` 호출의 반환 값을 `nil` 과 비교하기 바랍니다.

```swift
if john.residence?.printNumberOfRooms() != nil {
  print("It was possible to print the number of rooms.")
} else {
  print("It was not possible to print the number of rooms.")
}
// "It was not possible to print the number of rooms." 를 인쇄함
```

옵셔널 사슬을 통하여 속성을 설정하려고 시도하는 경우도 똑같습니다. 위의 [Accessing Properties Through Optional Chaining (옵셔널 사슬을 통하여 속성 접근하기)](#accessing-properties-through-optional-chaining-옵셔널-사슬을-통하여-속성-접근하기) 에 있는 예제는, `residence` 속성이 `nil` 인데도, `john.residence` 의 `address` 값을 설정하려고 시도합니다. 옵셔널 사슬을 통하여 속성을 설정하려는 어떤 시도든 `Void?` 타입의 값을 반환하는데, 이는 `nil` 과 비교하여 속성 설정이 성공했는지 알아볼 수 있게 합니다:

```swift
if (john.residence?.address = someAddress) != nil {
  print("It was possible to set the address.")
} else {
  print("It was not possible to set the address.")
}
// "It was not possible to set the address." 를 인쇄함
```

### Accessing Subscripts Through Optional Chaining (옵셔널 사슬을 통하여 첨자 접근하기)

옵셔널 사슬을 사용하여 옵셔널 값의 첨자로 값을 가져오고 설정하며, 그 첨자 호출이 성공인지 검사할 수 있습니다.

> 옵셔널 사슬을 통하여 옵셔널 값의 첨자에 접근할 땐, 첨자 대괄호, 뒤가 아닌, _앞에 (before)_ 물음표를 둡니다. 옵셔널 사슬의 물음표는 항상 표현식의 옵셔널 부분 바로 뒤에 붙습니다.

아래 예제는 `Residence` 클래스에서 정의한 첨자를 써서 `john.residence` 속성의 `rooms` 배열에 있는 첫 번째 방 이름을 가져오려고 합니다. 현재는 `john.residence` 가 `nil` 이기 때문에, 첨자 호출이 실패합니다:

```swift
if let firstRoomName = john.residence?[0].name {
  print("The first room name is \(firstRoomName).")
} else {
  print("Unable to retrieve the first room name.")
}
// "Unable to retrieve the first room name." 를 인쇄함
```

이 첨자 호출에선, `john.residence` 바로 뒤, 첨자 대괄호 앞에, 옵셔널 사슬 물음표를 두는데, 이는 옵셔널 사슬이 시도하고 있는 옵셔널 값이 `john.residence` 이기 때문입니다.

이와 비슷하게, 옵셔널 사슬로 첨자를 통하여 새 값을 설정해 볼 수 있습니다:

```swift
john.residence?[0] = Room(name: "Bathroom")
```

현재는 `residence` 가 `nil` 이기 때문에, 이 첨자 설정 시도도 실패합니다.

`Residence` 의 `rooms` 배열에 `Room` 인스턴스가 있는, 실제 인스턴스를 생성하여 `john.residence` 에 할당하면, `Residence` 첨자로 옵셔널 사슬을 통하여 `rooms` 배열의 실제 항목에 접근할 수 있습니다:

```swift
let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
  print("The first room name is \(firstRoomName).")
} else {
  print("Unable to retrieve the first room name.")
}
// "The first room name is Living Room." 를 인쇄함
```

#### Accessing Subscripts of Optional Type (옵셔널 타입의 첨자에 접근하기)

스위프트 `Dictionary` 타입의 키 (key) 첨자 같이-첨자가 옵셔널 타입의 값을 반환하면, 첨자의 닫는 대괄호 _뒤에 (after)_ 물음표를 둬서 자신의 옵셔널 반환 값을 사슬처럼 잇습니다:

```swift
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
// 이제 "Dave" 배열은 [91, 82, 84] 이고 "Bev" 배열은 [80, 94, 81] 임
```

위 예제는 `testScores` 라는 딕셔너리를 정의하는데, 이는 `String` 키를 `Int` 값 배열로 대응시키는 두 개의 키-값 쌍을 담고 있습니다. 예제는 옵셔널 사슬로 `"Dave"` 배열의 첫 번째 항목을 `91` 로 설정하고; `"Bev"` 배열의 첫 번째 항목은 `1` 만큼 증가시키며; 키가 `"Brian"` 인 배열의 첫 번째 항목을 설정합니다. 첫 두 호출은 성공인데, 이는 `testScores` 딕셔너리가 `"Dave"` 와 `"Bev"` 라는 키를 담고 있기 때문입니다. 세 번째 호출은 실패하며, 이는 `testScores` 딕셔너리가 `"Brian"` 이라는 키를 담고 있지 않기 때문입니다.

### Linking Multiple Levels of Chaining (여러 수준의 사슬 연결하기)

여러 수준의 옵셔널 사슬을 서로 연결하면 모델 더 깊은 곳의 속성, 메소드, 및 첨자로 파고 들 수 있습니다. 하지만, 여러 수준의 옵셔널 사슬이 반환 값에 옵셔널 수준을 더 추가하진 않습니다.

다른 식으로 말해:

* 가져올 타입이 옵셔널이 아니면, 옵셔널 사슬 때문에 옵셔널이 될 겁니다.
* 가져올 타입이 _이미 (already)_ 옵셔널이면, 사슬 때문에 _더 (more)_ 옵셔널[^more-optional]이 되진 않을 겁니다.

그러므로:

* 옵셔널 사슬을 통하여 `Int` 값을 가져오려 하면, 얼마나 많은 수준의 사슬을 사용하든, 항상 `Int?` 를 반환합니다.
* 이와 비슷하게, 옵셔널 사슬을 통하여 `Int?` 값을 가져오려 하면, 얼마나 많은 수준의 사슬을 사용하든, 항상 `Int?` 를 반환합니다.

아래 예제는 `john` 의 `residence` 속성에 있는 `address` 속성의 `street` 속성에 접근하려 합니다. 여기선 _2 (two)_ 단 수준의 옵셔널 사슬로, 둘 다 옵셔널 타입인, `residence` 와 `address` 속성을 사슬로 잇습니다:

```swift
if let johnsStreet = john.residence?.address?.street {
  print("John's street name is \(johnsStreet).")
} else {
  print("Unable to retrieve the address.")
}
// "Unable to retrieve the address." 를 인쇄함
```

`john.residence` 값은 현재 유효한 `Residence` 인스턴스를 담고 있습니다. 하지만, `john.residence.address` 의 값은 현재 `nil` 입니다. 이 때문에, `john.residence?.address?.street` 호출이 실패합니다.

위 예제에선, `street` 속성의 값을 가져오려는 중임을 기억하기 바랍니다. 이 속성의 타입은 `String?` 입니다. 그러므로, 실제 옵셔널 타입인 속성에다 2 단 수준의 옵셔널 사슬을 더할지라도, `john.residence?.address?.street` 의 반환 값 역시 `String?` 입니다.

`john.residence.address` 의 값에 실제 `Address` 인스턴스를 설정하고, 주소 (address) 의 `street` 속성에 실제 값을 설정하면, 여러 수준 (multilevel) 옵셔널 사슬을 통하여 `street` 속성의 값에 접근할 수 있습니다:

```swift
let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress

if let johnsStreet = john.residence?.address?.street {
  print("John's street name is \(johnsStreet).")
} else {
  print("Unable to retrieve the address.")
}
// "John's street name is Laurel Street." 를 인쇄함
```

이 예제선, `john.residence` 값이 현재 유효한 `Residence` 인스턴스를 담고 있기 때문에, `john.residence` 의 `address` 속성 설정 시도가 성공합니다.

### Chaining on Methods with Optional Return Values (옵셔널 반환 값이 있는 메소드 사슬잇기)

이전 예제는 옵셔널 사슬로 옵셔널 타입의 속성 값을 가져오는 방법을 보여줍니다. 옵셔널 사슬을 사용하면 옵셔널 타입의 값을 반환하는 메소드도 호출하고, 필요하다면 그 메소드의 반환 값을 사슬처럼 이을 수도 있습니다.

아래 예제는 옵셔널 사슬을 통하여 `Address` 클래스의 `buildingIdentifier()` 메소드를 호출합니다. 이 메소드는 `String?` 타입의 값을 반환합니다. 위에서 설명한 것처럼, 옵셔널 사슬 뒤에 호출하는 이 메소드의 반환 타입도 결국에는 `String?` 입니다:

```swift
if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
  print("John's building identifier is \(buildingIdentifier).")
}
// "John's building identifier is The Larches." 를 인쇄함
```

이 메소드 반환 값에서 옵셔널 사슬을 더 잇고 싶으면, 메소드 괄호 _뒤에 (after)_ 옵셔널 사슬 물음표를 둡니다:

```swift
if let beginsWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
  if beginsWithThe {
    print("John's building identifier begins with \"The\".")
  } else {
    print("John's building identifier does not begin with \"The\".")
  }
}
// "John's building identifier begins with "The"." 를 인쇄함
```

> 위 예제에서, 옵셔널 사슬 물음표는 괄호 _뒤에 (after)_ 붙이는데, 이는 사슬처럼 이을 옵셔널 값이, `buildingIdentifier()` 메소드 그 자체가 아니라, `buildingIdentifier()` 메소드의 반환 값이기 때문입니다.

### 다음 장

[Error Handling (에러 처리) >]({% link docs/swift-books/swift-programming-language/error-handling.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [Optional Chaining](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 에서 볼 수 있습니다.

[^gracefully-fail]: '우아하게 실패한다 (fails gracefully)' 는 건 실행-시간 에러가 발생하지 않는다는 의미입니다. 사슬의 어떤 고리든 `nil` 이면, 실행시간 에러가 발생하는 게 아니라, 전체 사슬이 `nil` 이 됩니다.

[^optional-binding]: '옵셔널 연결 (optional binding)' 에 대해서는, [The Basics (기초)]({% link docs/swift-books/swift-programming-language/the-basics.md %}) 장의 [Optional Binding (옵셔널 연결)]({% link docs/swift-books/swift-programming-language/the-basics.md %}#optional-binding-옵셔널-연결) 부분을 참고하기 바랍니다.

[^side-effect]: 프로그래밍 분야에선 '부작용 (side effects)' 을 '부수적인 효과' 라는 의미로 이해하는 게 좋습니다. 본문 내용은 상수에 대한 접근이 부수적인 효과가 없기 때문에, `someAddress` 를 평가했는지 아닌지 알 방법이 없다는 의미입니다. 프로그래밍 분야의 부작용에 대한 더 자세한 내용은, [Expressions (표현식)]({% link docs/swift-books/swift-programming-language/expressions.md %}) 맨 앞 부분에 있는 '부작용 (side effect)' 에 대한 주석을 보도록 합니다.

[^function-was-called]: 이 예제 코드에 있는 `print("Function was called.")` 같은 것이 프로그래밍에서 말하는 부수적인 효과, 즉, '부작용 (side effects)' 입니다. 이 함수의 원래 목적은 주소를 생성하는 것인데, `print` 는 원래 목적과는 상관없이 부수적인 효과-부작용-를 일으킵니다.

[^more-optional]: '더 옵셔널이 되진 않는다' 는 건 '옵셔널의 옵셔널' 같은 건 없다는 의미입니다.

[^non-optional-int]: `numberOfRooms` 가 옵셔널이 아니더라도 `john.residence?.numberOfRooms` 는 무조건 옵셔널이 된다는 의미입니다.
