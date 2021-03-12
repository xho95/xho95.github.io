---
layout: post
comments: true
title:  "Swift 5.4: Optional Chaining (옵셔널 연쇄)"
date:   2020-06-17 10:00:00 +0900
categories: Swift Language Grammar Error Handling
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.4)](https://docs.swift.org/swift-book/) 책의 [Optional Chaining](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 부분[^Optional-Chaining]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.4: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Optional Chaining (옵셔널 연쇄)

_옵셔널 연쇄 (optional chaining)_ 는 현재 `nil` 일 수도 있는 '옵셔널' 에 대한 속성, 메소드, 그리고 첨자 연산을 조회하고 호출하는 과정입니다. '옵셔널' 이 값을 담고 있으면, 속성, 메소드, 또는 첨자 연산 호출이 성공하며; '옵셔널' 이 `nil` 이면, 속성, 메소드, 또는 첨자 연산 호출이 `nil` 을 반환합니다. 여러 개의 조회는 '연쇄망 (chain)' 으로 서로 이을 수 있으며, 연쇄망에 있는 어떤 고리가 `nil` 이이라도 '전체 연쇄망' 이 '우아하게 (gracefully)[^gracefully-fail] 실패' 합니다.

> 스위프트의 '옵셔널 연쇄' 는 오브젝티브-C 의 `nil` 메시징과 비슷하지만, 어떤 타입과도 작업할 수 있으며, 성공 또는 실패 여부를 검사할 수 있습니다.

### Optional Chaining as an Alternative to Forced Unwrapping (강제 포장 풀기의 대안으로써의 옵셔널 연쇄)

'옵셔널 연쇄' 는 옵셔널이 `nil`-이 아니라면 호출하길 바라는 속성, 메소드, 또는 첨자 연산의 옵셔널 값 뒤에 '물음표 (`?`)' 를 붙임으로써 지정합니다. 이는 값을 강제로 풀기 위해 옵셔널 값 뒤에 '느낌표 (`!`)' 를 붙이는 것과 아주 비슷합니다. 주요 차이점은, '강제 포장 풀기' 는 옵셔널이 `nil` 일 때 실행시간 에러를 발생시키는 반면, '옵셔널 연쇄' 는 옵셔널이 `nil` 일 때 '우아하게 실패' 한다는 것입니다.

옵셔널 연쇄는 `nil` 값에 대해서도 호출할 수 있다는 사실을 반영하기 위해, 옵셔널 연쇄 호출의 결과는, 조회하고 있는 속성, 메소드, 또는 첨자 연산이 옵셔널-아닌 값을 반환하는 경우에도, 항상 옵셔널 값입니다. 이 옵셔널 반환 값은 옵셔널 연쇄 호출이 성공했는지 (반환한 옵셔널이 값을 담고 있음), 아니면 연쇄망에 있는 `nil` 값으로 인해 성공하지 못했는 지 (반환한 옵셔널 값이 `nil` 임) 를 검사하는데 사용할 수 있습니다.

특별히, 옵셔널 연쇄 호출의 결과는 예상한 반환 값을, 옵셔널로 포장한, 것과 똑같은 타입입니다. 보통은 `Int` 를 반환할 속성이 '옵셔널 연쇄' 를 통해서 접근할 땐 `Int?` 를 반환할 것입니다.

다음의 여러 코드 조각들은 옵셔널 연쇄가 강제 포장 풀기와 다른점 그리고 성공 여부를 검사하게 해주는 방법을 실증합니다.

첫 번째로, `Person` 과 `Residence` 라는 두 클래스를 정의합니다:

```swift
class Person {
  var residence: Residence?
}

class Residence {
  var numberOfRooms = 1
}
```

`Residence` 인스턴스는, 기본 값이 `1` 인, `numberOfRooms` 라는 단일 `Int` 속성을 가집니다. `Person` 인스턴스는 타입이 `Residence?` 인 옵셔널 `residence` 속성을 가집니다.

새로운 `Person` 인스턴스를 생성하면, `residence` 속성은, 옵셔널인 덕에, 기본적으로 `nil` 로 초기화됩니다. 아래 코드에서, `john` 은 `residence` 속성 값으로 `nil` 을 가집니다:

```swift
let john = Person()
```

이 사람의 `residence` 에 있는 `numberOfRooms` 속성에, 강제로 값의 포장을 푸는 느낌표를 `residence` 뒤에 붙여서, 접근하려고 하면, 포장을 풀 `residence` 값이 없기 때문에, 실행시간 에러가 발생합니다:

```swift
let roomCount = john.residence!.numberOfRooms
// 이는 실행시간 에러를 발생시킵니다.
```

위 코드는 `john.residence` 가 `nil` 이 아닌 값일 때 성공하여 적절한 방 개수를 담은 `Int` 값으로 `roomCount` 를 설정할 것입니다. 하지만, 이 코드는, 위에서 묘사한 것처럼, `residence` 가 `nil` 일 때는, 항상 실행시간 에러를 발생시킵니다.

옵셔널 연쇄는 `numberOfRooms` 값에 접근하는 대안을 제공합니다. 옵셔널 연쇄를 사용하려면, 느낌표 자리에 물음표를 사용합니다:

```swift
if let roomCount = john.residence?.numberOfRooms {
  print("John's residence has \(roomCount) room(s).")
} else {
  print("Unable to retrieve the number of rooms.")
}
// "Unable to retrieve the number of rooms." 를 인쇄합니다.
```

이는 '옵셔널 `residence` 속성' 을 "연쇄 (chain)" 해서 `residence` 가 존재하면 `numberOfRooms` 의 값을 가져오라고 스위프트에게 말하는 것입니다.

`numberOfRooms` 에 접근하려는 시도는 실패할 가능성이 있기 때문에, 옵셔널 연쇄 시도는 `Int?`, 또는 "옵셔널 `Int`" 타입의 값을 반환합니다. `residence` 가 `nil` 일 땐, 위 예제에 있는 것처럼, `numberOfRooms` 에 접근하는 것이 가능하지 않다는 사실을 반영하기 위해, 이 옵셔널 `Int` 도 `nil` 일 것입니다. 옵셔널 `Int` 는 '옵셔널 연결 (optional binding)'[^optional-binding] 을 통해 정수 포장을 풀고 옵셔널-아닌 값을 `roomCount` 상수에 할당합니다.

이는 `numberOfRooms` 가 옵셔널이 아닌 `Int` 일지라도 그렇다는 것을 기억하기 바랍니다. 옵셔널 연쇄를 통해 조회한다는 사실은 `numberOfRooms` 에 대한 호출이 `Int` 대신 항상 `Int?` 를 반환할 것이라는 의미입니다.

`Residence` 인스턴스를 `john.residence` 에 할당하여, 더 이상 `nil` 값을 가지지 않도록, 할 수 있습니다:

```swift
john.residence = Residence()
```

`john.residence` 는 이제, `nil` 이 아닌, 실제 `Residence` 인스턴스를 담고 있습니다. 이전과 똑같은 옵셔널 연쇄로 `numberOfRooms` 에 접근하려고 하면, 이제 `1` 이라는
기본 `numberOfRooms` 값' 을 담은 `Int?` 를 반환할 것입니다:

```swift
if let roomCount = john.residence?.numberOfRooms {
  print("John's residence has \(roomCount) room(s).")
} else {
  print("Unable to retrieve the number of rooms.")
}
// "John's residence has 1 room(s)." 를 인쇄합니다.
```

### Defining Model Classes for Optional Chaining (옵셔널 연쇄를 위한 모델 클래스 정의하기)

깊이가 한 단계 이상인 속성, 메소드, 그리고 첨자 연산에 대한 호출을 가진 '옵셔널 연쇄' 를 사용할 수 있습니다.  이는 상관 관계가 있는 복잡한 타입 모델 내의 '하위 속성 (subproperties)' 밑으로 파고 들어서, 해당 '하위 속성' 에 대한 속성, 메소드, 그리고 첨자 연산에 접근하는 것이 가능한지를 검사할 수 있게 해줍니다.

아래 코드 조각들은, 다중 단계 옵셔널 연쇄에 대한 예제를 포함한, 여러 후속 예제에서 사용하기 위한 네 개의 '모델 클래스' 를 정의합니다. 이 클래스들은 위에 있는 `Person` 과 `Residence` 모델을, `Room` 과 `Address` 클래스, 및 이와 결합된 속성, 메소드, 그리고 첨자 연산를 추가함으로써, 확대합니다.

`Person` 클래스는 이전과 똑같은 방식으로 정의합니다:

```swift
class Person {
  var residence: Residence?
}
```

`Residence` 클래스는 이전보다 더 복잡합니다. 이번에는, `Residence` 클래스가, `[Room]` 타입의 빈 배열로 초기화하는, `rooms` 라는 변수 속성을 정의합니다:

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

이 버전의 `Residence` 는 `Room` 인스턴스 배열을 저장하고 있기 때문에, `numberOfRooms` 속성을, 저장 속성이 아닌, 계산 속성으로 구현합니다. `numberOfRooms` 계산 속성은 단순히 `rooms` 배열에 있는 `count` 속성의 값을 반환합니다.

`rooms` 배열에 접근하기 위한 '줄임말' 로써, 이 버전의 `Residence` 는 `rooms` 배열 중에서 요청한 색인의 '객실 (room)' 에 대한 접근을 제공하는 '읽고-쓰기 (read-write) 첨자 연산' 을 제공합니다.

이 버전의 `Residence` 는, 단순히 '거주지 (residence)' 의 객실 수를 인쇄하는, `printNumberOfRooms` 라는 메소드도 제공합니다.

마지막으로, `Residence` 는, 타입이 `Address?` 인, `address` 라는 '옵셔널 속성' 을 정의합니다. 이 속성을 위한 '`Address` 클래스 타입' 은 아래에서 정의합니다.

`rooms` 배열을 위한 '`Room` 클래스' 는 `name` 이라는 속성 하나와, 해당 속성에 적합한 객실 이름을 설정하는 초기자로 된, 단순한 클래스입니다:

```swift
class Room {
  let name: String
  init(name: String) { self.name = name }
}
```

이 모델의 마지막 클래스는 `Address` 라고 합니다. 이 클래스는 `String?` 타입인 세 개의 옵셔널 속성을 가집니다. 처음 두 개인, `buildingName` 과 `buildingNumber` 속성은, 주소에서 특정 건물을 식별하기 위한 수단입니다. 세 번째 속성인, `street` 는, 해당 주소에서 거리 이름에 사용합니다:

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

`Address` 클래스는, 반환 타입이 `String?` 인, `buildingIdentifier()` 라는 메소드도 제공합니다. 이 메소드는 주소의 속성을 검사해서, `buildingNumber` 와 `street` 가 둘 다 값을 가지면 이 둘을 이어서 반환하거나, `buildingName` 이 값을 가지면 이를 반환하며, 그 외 경우라면 `nil` 을 반환합니다.

### Accessing Properties Through Optional Chaining (옵셔널 연쇄를 통해 속성에 접근하기)

[Optional Chaining as an Alternative to Forced Unwrapping (강제 포장 풀기의 대안으로써의 옵셔널 연쇄)](#optional-chaining-as-an-alternative-to-forced-unwrapping-강제-포장-풀기의-대안으로써의-옵셔널-연쇄) 에서 실증한 것처럼, 옵셔널 값에 대한 속성에 접근해서, 해당 속성 접근이 성공했는지 검사하기 위해 옵셔널 연쇄를 사용할 수 있습니다.

위에서 정의한 클래스를 사용하여 새로운 `Person` 인스턴스를 생성하고, 이전 처럼 `numberOfRooms` 속성에 접근해 봅니다:

```swift
let john = Person()
if let roomCount = john.residence?.numberOfRooms {
  print("John's residence has \(roomCount) room(s).")
} else {
  print("Unable to retrieve the number of rooms.")
}
// "Unable to retrieve the number of rooms." 를 인쇄합니다.
```

`john.residence` 가 `nil` 이기 때문에, 이 옵셔널 연쇄 호출은 이전과 똑같이 실패합니다.

옵셔널 연쇄를 통해 속성의 값을 설정하는 시도를 할 수도 있습니다:

```swift
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress
```

이 예제에서, `john.residence` 의 `address` 속성을 설정하려는 시도는,`john.residence` 가 현재 `nil` 이기 때문에, 실패할 것입니다.

'할당 (assignment)' 은 옵셔널 연쇄의 일부이며, 이는 `=` 연산자의 오른-쪽에 있는 코드는 아무 것도 평가하지 않는다는 의미입니다. 이전 예제에서, `someAddress` 를 절대로 평가하지 않는다는 것은 알기가 쉽지 않은데, 이는 상수에 접근하는 것이 어떠한 '부작용 (side effect)'[^side-effect] 도 가지지 않기 때문입니다. 아래에 나열한 것은 똑같은 할당을 하지만, 주소를 생성하기 위해 함수를 사용합니다. 함수는 값을 반환하기 전에, `=` 연산자의 오른-쪽 값을 평가했는지 볼 수 있도록, "Function was called" 를 인쇄합니다.[^function-was-called]

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

아무 것도 인쇄하지 않기 때문에, `createAddress()` 함수가 호출되지 않는다고 말할 수 있습니다.

### Calling Methods Through Optional Chaining (옵셔널 연쇄를 통해 메소드 호출하기)

옵셔널 값에 대한 메소드를 호출하고, 해당 메소드 호출이 성공했는지 검사하기 위해, 옵서널 연쇄를 사용할 수 있습니다. 이는 해당 메소드가 반환 값을 정의하지 않은 경우에도 사용할 수 있습니다.

`Residence` 클래스에 대한 `printNumberOfRooms()` 메소드는 `numberOfRooms` 의 현재 값을 인쇄합니다. 방법은 다음과 같습니다:

```swift
func printNumberOfRooms() {
  print("The number of rooms is \(numberOfRooms)")
}
```

이 메소드는 반환 타입을 지정하지 않습니다. 하지만, [Functions Without Return Values (반환 값이 없는 함수)]({% post_url 2020-06-02-Functions %}#functions-without-return-values-반환-값이-없는-함수) 에서 설명한 것처럼, 반환 타입을 가지지 않는 함수와 메소드는 `Void` 라는 암시적인 반환 타입을 가집니다. 이는 `()` 라는 반환 값, 또는 '빈 튜플' 을 반환한다는 의미입니다.

옵셔널 연쇄로 옵셔널 값에 대해서 이 메소드를 호출하면, 메소드의 반환 타입이, 옵셔널 연쇄를 통해 호출할 때는 항상 옴셔널 타입이기 때문에, `Void` 가 아닌, `Void?` 가 될 것입니다. 이는, 메소드가 자체가 반환 값을 정의하고 있지 않을지라도, `printNumberOfRooms()` 메소드 호출이 가능한지 `if` 문으로 검사할 수 있게 해줍니다. 메소드 호출이 성공인지 보려면 `printNumberOfRooms` 호출의 반환 값을 `nil` 과 비교합니다.

```swift
if john.residence?.printNumberOfRooms() != nil {
  print("It was possible to print the number of rooms.")
} else {
  print("It was not possible to print the number of rooms.")
}
// "It was not possible to print the number of rooms." 를 인쇄합니다.
```

옵셔널 연쇄를 통해 속성을 설정하려고 하는 경우도 똑같습니다. 위의 [Accessing Properties Through Optional Chaining (옵셔널 연쇄를 통해 속성에 접근하기)](#accessing-properties-through-optional-chaining-옵셔널-연쇄를-통해-속성에-접근하기) 에 있는 예제는, `residence` 속성이 `nil` 일지라도, `john.residence` 를 위한 `address` 값을 설정하려고 시도합니다. 옵셔널 연쇄를 통해 속성을 설정하려는 어떤 시도도 `Void?` 타입의 값을 반환하는데, 이는 속성이 성공적으로 설정됐는지 보기 위해 `nil` 과 비교할 수 있도록 해줍니다:

```swift
if (john.residence?.address = someAddress) != nil {
  print("It was possible to set the address.")
} else {
  print("It was not possible to set the address.")
}
// "It was not possible to set the address." 를 인쇄합니다.
```

### Accessing Subscripts Through Optional Chaining (옵셔널 연쇄를 통해 첨자 연산에 접근하기)

옵셔널 값에 대한 첨자 연산으로 값을 가져오려고 하거나 설정하려고 한 다음, 해당 첨자 연산의 호출이 성공했는지 검사하기 위해, 옵셔널 연쇄를 사용할 수 있습니다.

> 옵셔널 값에 대한 첨자 연산을 옵셔널 연쇄로 접근할 때는, 물음표를 첨자 연산의 대괄호, 뒤가 아니라, _앞에 (before)_ 붙입니다. 옵셔널 연쇄의 물음표는 항상 옵셔널인 표현식의 바로 뒤에 따라옵니다.

아래 예제는 `Residence` 클래스에서 정의한 첨자 연산을 사용하여 `john.residence` 속성의 `rooms` 배열에 있는 첫 번째 방 이름을 가져오려고 시도합니다. `john.residence` 는 현재 `nil` 이기 때문에, 첨자 연산 호출이 실패합니다:

```swift
if let firstRoomName = john.residence?[0].name {
  print("The first room name is \(firstRoomName).")
} else {
  print("Unable to retrieve the first room name.")
}
// "Unable to retrieve the first room name." 를 인쇄합니다.
```

이 첨자 연산의 옵셔널 연쇄 물음표는, 옵셔널 연쇄를 시도하고 있는 옵셔널 값이 `john.residence` 이기 때문에, `john.residence` 바로 뒤인, 첨자 연산 대괄호 바로 앞에, 위치합니다.

이와 비슷하게, 옵셔널 연쇄로 첨자 연산을 통해 새로운 값을 설정하려고 할 수 있습니다:

```swift
john.residence?[0] = Room(name: "Bathroom")
```

이 첨자 연산의 설정 시도도, `residence` 가 현재 `nil` 이기 때문에, 실패합니다.

실제 `Residence` 인스턴스를 생성하고 `john.residence` 에 할당하여, `rooms` 배열이 하나 이상의 `Room` 인스턴스를 가진 경우, 옵셔널 연쇄를 통해 `rooms` 배열의 실제 항목에 접근하기 위해 `Residence` 의 첨자 연산을 사용할 수 있습니다:

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
// "The first room name is Living Room." 를 인쇄합니다.
```

#### Accessing Subscripts of Optional Type (옵셔널 타입의 첨자 연산에 접근하기)

만약 첨자 연산이-스위프트의 `Dictionary` 타입에 있는 '키 (key) 첨자 연산' 처럼-옵셔널 타입의 값을 반환한다면, 옵셔널 반환 값에 대한 연쇄를 하기 위해 첨자 연산의 닫는 대괄호 _뒤에 (after)_ 물음표를 붙입니다:

```swift
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
// "Dave" 배열은 이제 [91, 82, 84] 이고 "Bev" 배열은 이제 [80, 94, 81] 입니다.
```

위 예제는, `String` 키를 `Int` 값 배열에 '대응 (map)' 시키는 '키-값 쌍' 두 개를 담은, `testScores` 라는 딕셔너리를 정의합니다. 예제는 `"Dave"` 배열의 첫 번째 항목을 `91` 로 설정하기 위해; `"Bev"` 배열의 첫 번째 항목을 `1` 만큼 증가시키기 위해; 그리고 '키 (key)' 가 `"Brian"` 인 배열의 첫 번째 항목을 설정하기 위해 옵셔널 연쇄를 사용합니다. 처음 두 호출은 성공하는데, `testScores` 딕셔너리가 `"Dave"` 와 `"Bev"` 라는 키를 담고 있기 때문입니다. 세 번째 호출은 실패하는데, `testScores` 딕셔너리가 `"Brian"` 이라는 키를 담고 있지 않기 때문입니다.

### Linking Multiple Levels of Chaining (다중 수준의 연쇄 연결하기)

모델 안의 더 깊은 속성, 메소드, 그리고 첨자 연산으로 파고 들어가기 위해 다중 수준의 옵셔널 연쇄를 서로 연결할 수 있습니다. 하지만, '다중 수준의 옵셔널 연쇄' 는 반환 값의 옵셔널 수준을 더 추가하지 않습니다.

다른 식으로 말해서:

* 가져오려는 타입이 옵셔널이 아니면, 옵셔널 연쇄이기 때문에 옵셔널이 될 것입니다.
* 가져오려는 타입이 _이미 (already)_ 옵셔널이면, 옵셔널 연쇄이기 때문에 _더 (more)_ 옵셔널[^more-optional]이 되지는 않을 것입니다.

그러므로:

* 옵셔널 연쇄를 통해서 `Int` 값을 가져오려고 하면, 얼마나 많은 연쇄 수준을 사용하던 간에, 항상 `Int?` 를 반환합니다.
* 이와 비슷하게, 옵셔널 연쇄를 통해 `Int?` 값을 가져오려고 하면, 얼마나 많은 연쇄 수준을 사용하던 간에, 항상 `Int?` 를 반환합니다.

아래 예제는 `john` 의 `residence` 속성에 있는 `address` 속성의 `street` 속성에 접근하려고 합니다. 여기서는, 둘 다 옵셔널 타입인, `residence` 와 `address` 속성을 연쇄하기 위해, _두 (two)_ 단계 수준의 옵셔널 연쇄를 사용 중입니다:

```swift
if let johnsStreet = john.residence?.address?.street {
  print("John's street name is \(johnsStreet).")
} else {
  print("Unable to retrieve the address.")
}
// "Unable to retrieve the address." 를 인쇄합니다.
```

`john.residence` 의 값은 현재 유효한 `Residence` 인스턴스를 담고 있습니다. 하지만, `john.residence.address` 값은 현재 `nil` 입니다. 이 때문에, `john.residence?.address?.street` 호출은 실패합니다.

위 예제에서, `street` 속성의 값을 가져오려고 하는 중임을 기억하기 바랍니다. 이 속성의 타입은 `String?` 입니다. 그러므로 `john.residence?.address?.street` 의 반환 값은, 속성의 실제 옵셔널 타입에 더하여 두 단계 수준의 옵셔널 연쇄를 적용할지라도, 역시 `String?` 입니다.

`john.residence.address` 의 값에 실제 `Address` 인스턴스를 설정하고, '주소 (address)' 의 `street` 속성에 실제 값을 설정한 경우, '다중 수준 (multilevel) 옵셔널 연쇄' 를 통해 `street` 속성의 값에 접근할 수 있습니다:

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
// "John's street name is Laurel Street." 를 인쇄합니다.
```

이 예제에서, `john.residence` 의 `address` 속성을 설정하려는 시도는 성공하는데, 이는 `john.residence` 가 현재 유효한 `Residence` 인스턴스 값을 담고 있기 때문입니다.

### Chaining on Methods with Optional Return Values (옵셔널 반환 값을 가진 메소드 연쇄하기)

이전 예제는 옵셔널 연쇄를 통해서 옵셔널 타입의 속성 값을 가져오는 방법을 보여줍니다. 옵셔널 연쇄는, 옵셔널 타입인 값을 반환하는 메소드를 호출하기 위해서도, 그리고 필요한 경우 해당 메소드의 반환 값에 대해서 연쇄하기 위해서도, 사용할 수 있습니다.

아래 예제는 옵셔널 연쇄를 통하여 `Address` 클래스의 `buildingIdentifier()` 메소드를 호출합니다. 이 메소드는 `String?` 타입의 값을 반환합니다. 위에서 설명한 것처럼, 옵셔널 연쇄 다음에 하는 이 메소드 호출 역시 궁극적인 반환 타입은 `String?` 입니다:

```swift
if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
  print("John's building identifier is \(buildingIdentifier).")
}
// "John's building identifier is The Larches." 를 인쇄합니다.
```

이 메소드의 반환 값에 대해 옵셔널 연쇄를 더 하고 싶으면, 메소드의 괄호 _뒤에 (after)_ '옵셔널 연쇄 물음표' 를 붙입니다:

```swift
if let beginsWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
  if beginsWithThe {
    print("John's building identifier begins with \"The\".")
  } else {
    print("John's building identifier does not begin with \"The\".")
  }
}
// "John's building identifier begins with "The"." 를 인쇄합니다.
```

> 위 예제에서, '옵셔널 연쇄 물음표' 를 괄호 _뒤에 (after)_ 붙였는데, 이는 연쇄하는 옵셔널 값이, `buildingIdentifier()` 메소드 자체가 아니라, `buildingIdentifier()` 메소드의 반환 값이기 때문입니다.

### 다음 장

[Error Handling (에러 처리) > ]({% post_url 2020-05-16-Error-Handling %})

### 참고 자료

[^Optional-Chaining]: 이 글에 대한 원문은 [Optional Chaining](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^gracefully-fail]: 스위프트에서 '우아하게 실패한다 (fail gracefully)' 는 말은 '실행-시간 에러' 가 발생하지 않는다는 것을 의미합니다. '연쇄망' 의 어떤 '고리' 라도 `nil` 이면, 실행시간 에러가 발생하는 대신, 전체 연쇄망이 `nil` 이 된다는 의미입니다.

[^optional-binding]: '옵셔널 연결 (optional binding)' 에 대한 더 자세한 정보는, [The Basics (기초)]({% post_url 2016-04-24-The-Basics %}) 장의 [Optional Binding (옵셔널 연결)]({% post_url 2016-04-24-The-Basics %}#optional-binding-옵셔널-연결) 부분을 참고하기 바랍니다.

[^side-effect]: 프로그래밍에서의 '부작용 (side effects)' 는 '부수적인 효과' 정도의 의미로 이해하는 것이 좋습니다. 본문의 내용은 상수에 대한 접근이 '부수적인 효과' 를 가지지 않기 때문에, `someAddress` 를 평가했는지 아닌지를 우리가 알 방법이 없다는 의미입니다. 프로그래밍 분야에서의 '부작용' 에 대한 더 자세한 내용은, [Expressions (표현식)]({% post_url 2020-08-19-Expressions %}) 맨 앞 부분에 있는 '부작용 (side effect)' 에 대한 주석을 참고하기 바랍니다.

[^function-was-called]: 이 예제 코드에 있는 `print("Function was called.")` 같은 것이 프로그래밍에서 말하는 '부수적인 효과', 즉, '부작용 (side effects)' 입니다. 이 함수의 본 목적은 주소를 생성하는 것인데, `print` 문은 주소를 생성하는 것과 직접적으로 관련이 없습니다.

[^more-optional]: '더 옵셔널이 되지는 않는다' 는 것은 '옵셔널의 옵셔널' 같은 것은 없다는 의미입니다.
