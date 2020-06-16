---
layout: post
comments: true
title:  "Swift 5.2: Optional Chaining (옵셔널 사슬)"
date:   2020-06-13 10:00:00 +0900
categories: Swift Language Grammar Error Handling
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Optional Chaining](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 부분[^Optional-Chaining]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Optional Chaining (옵셔널 사슬)

_옵셔널 사슬 (optional chaining)_ 은 현재 값이 `nil` 일 수도 있는 '옵셔널' 의 속성, 메소드, 그리고 첨자 연산을 조회하고 호출하는 '과정 (process)' 을 말합니다. 만약 '옵셔널' 이 값을 가지고 있으면, 속성, 메소드, 또는 첨자 연산에 대한 호출은 성공합니다; 먄약 '옵셔널' 이 `nil` 이라면, 속성, 메소드, 또는 첨자 연산에 대한 호출은 `nil` 을 반환합니다. '다중 조회 (multiple queries)' 는 서로 사슬처럼 이어질 수 있으며, 사슬 중에 어느 한 고리라도 `nil` 이면 전체 사슬은 우아하게 실패합니다.[^gracefully-fail]

> 스위프트의 '옵셔널 사슬' 은 오브젝티브-C 언어에서 `nil` 메시지를 주고받는 것과 비슷하지만, 어떤 타입과도 작업할 수 있으며, 성공이나 실패를 검사할 수 있습니다.

### Optional Chaining as an Alternative to Forced Unwrapping (강제 풀기의 대안으로써의 옵셔널 사슬)

'옵셔널 사슬 (optional chaining)' 을 지정하려면 해당 옵셔널이 `nil`-이 아니라면 그의 속성, 메소드, 또는 첨자 연산을 호출하고자 하는 옵셔널 값의 뒤에 '물음표 (`?`)' 를 붙여주면 됩니다. 이것은 강제로 값을 풀 때 옵셔널 값 뒤에 '느낌표 (`!`)' 를 붙이는 것과 아주 비슷합니다. 주요한 차이점은 '옵셔널 사슬' 은 해당 옵셔널이 `nil` 일 때 우아하게 실패하는데 반해, '강제 풀기 (forced unwrapping)' 은 해당 옵셔널이 `nil` 일 때 '실행시간 에러 (runtime error)' 를 일으킨다는 것입니다.

'옵셔널 사슬' 이 `nil` 값에 대해서도 호출될 수 있다는 사실을 반영하기 위해, 조회 중인 속성, 메소드, 또는 첨자 연산이 설령 옵셔널-아닌 값을 반환하더라도, '옵셔널 사슬' 호출 결과는 항상 하나의 '옵셔널 값' 이 됩니다. 이 옵셔널 반환 값을 사용하여 옵셔널 사슬 호출이 성공했는지 (반환된 옵셔널은 값을 가지고 있습니다), 아니면 사슬에 있는 `nil` 값 때문에 성공하지 못했는 지를 (반환된 옵셔널 값은 `nil` 입니다) 검사할 수 있습니다.

특히, 옵셔널 사슬 호출의 결과는 예상하던 반환 값과 같은 타입이긴 하지만, 옵셔널로 감싸져 있습니다. 평범하게 `Int` 를 반환하는 속성도 '옵셔널 사슬' 을 통해 접근하면 `Int?` 를 반환하게 됩니다.

다음의 여러 코드 조각들은 '옵셔널 사슬' 이 '강제 풀기' 와 어떻게 다른지 그리고 어떻게 성공 여부를 검사할 수 있는지를 시연합니다.

첫 번째로, `Person` 과 `Residence` 라는 두 클래스를 정의합니다:

```swift
class Person {
  var residence: Residence?
}

class Residence {
  var numberOfRooms = 1
}
```

`Residence` 의 인스턴스는, 기본 설정 값이 `1` 인, `numberOfRooms` 라는 단일한 `Int` 속성을 가집니다. `Person` 의 인스턴스는 타입이 `Residence?` 인 하나의 옵셔널 `residence` 속성을 가집니다.

새로운 `Person` 인스턴스를 생성하면, `residence` 속성은 기본적으로 `nil` 로 초기화되는데, 이는 '옵셔널' 이 가지는 장점에 해당합니다. 아래 코드에서, `john` 은 값이 `nil` 인 `residence` 속성을 가집니다:

```swift
let john = Person()
```

이 사람의 `residence` 에 있는 `numberOfRooms` 속성에 접근하기 위해, `residence` 뒤에 '느낌표' 를 붙여서 값을 '강제로 풀려고' 하면, '실행시간 에러 (runtime error)' 가 발생하는데, `residence` 값이 없어서 풀 수가 없기 때문입니다:

```swift
let roomCount = john.residence!.numberOfRooms
// 이는 실행시간 에러를 발생시킵니다.
```

위 코드는 `john.residence` 가 `nil`-아닌 값을 가질 때 성공해서 적절한 방의 개수를 가지는 `Int` 값으로 `roomCount` 를 설정하게 됩니다. 하지만, 이 코드는 `residence` 가 `nil` 일 때는, 위에서 본 것처럼, 항상 실행시간 에러를 일으킵니다.

옵셔널 사슬은 `numberOfRooms` 값에 접근하는 또 다른 방법을 제공합니다. 옵셔널 사슬을 사용하려면, '느낌표' 자리에 '물음표' 를 사용하면 됩니다:

```swift
if let roomCount = john.residence?.numberOfRooms {
  print("John's residence has \(roomCount) room(s).")
} else {
  print("Unable to retrieve the number of rooms.")
}
// "Unable to retrieve the number of rooms." 를 출력합니다.
```

이것은 스위프트에게 말해서 옵셔널 `residence` 속성을 "사슬처럼 이어서 (chain)" `residence` 가 존재하면 `numberOfRooms` 의 값을 가져오라고 하는 것입니다.

`numberOfRooms` 에 접근하려는 시도는 잠재적으로 실패할 수 있기 때문에, 옵셔널 사슬 시도는 `Int?` 타입, 혹은 "옵셔널 `Int`" 타입의 값을 반환합니다. 위의 예제 처럼, `residence` 가 `nil` 일 때, `numberOfRooms` 에 접근할 수 없다는 사실을 반영해서, 이 옵셔널 `Int` 역시 `nil` 이 될 것입니다. 이 옵셔널 `Int` 를 '옵셔널 연결 (optional binding)' 로 접근하여 정수를 풀고 옵셔널-아닌 값을 `roomCount` 변수에 할당합니다.

이것은 `numberOfRooms` 가 옵셔널 `Int`-가 아니어도 마찬가지라는 점을 기억하기 바랍니다. 옵셔널 사슬로 조회한다는 것의 의미는 `numberOfRooms` 호출이 `Int` 가 아니라 항상 `Int?` 를 반환할 것이라는 사실입니다.

`john.residence` 에 `Residence` 인스턴스를 할당하면, 더 이상 `nil` 값을 가지지 않게 됩니다:

```swift
john.residence = Residence()
```

`john.residence` 는 이제 `nil` 이 아니라, 실제 `Residence` 인스턴스를 가지고 있습니다. 이전과 같은 옵셔널 사슬로 `numberOfRooms` 에 접근하면, 이제는 기본 `numberOfRooms` 값이 `1` 인 `Int?` 를 반환하게 됩니다:

```swift
if let roomCount = john.residence?.numberOfRooms {
  print("John's residence has \(roomCount) room(s).")
} else {
  print("Unable to retrieve the number of rooms.")
}
// "John's residence has 1 room(s)." 를 출력합니다.
```

### Defining Model Classes for Optional Chaining (옵셔널 사슬을 위한 모델 클래스 정의하기)

'옵셔널 사슬 (optional chaining)' 을 사용하면 한 단계보다 더 깊은 곳의 속성, 메소드, 그리고 첨자 연산을 호출할 수 있습니다.  이는 상호 관계된 타입에 대한 복접한 모델의 '하위 속성 (subproperties)' 밑으로 파고 들어서, 그 '하위 속성' 에 대한 속성, 메소드, 그리고 첨자 연산에 접근할 수 있는 지를 검사할 수 있게 해줍니다.

아래의 코드 조각은 네 개의 '모델 클래스 (model classes)' 를 정의하여 이를, 다중-단계 옵셔널 사슬 예제를 포함한, 후속 예제에서 사용합니다. 이 클래스는 위에 있는 `Person` 과 `Residence` 모델을 확장하려고 `Room` 과 `Address` 클래스를, '결합된 값', 메소드, 그리고 첨자 연산과 함께 추가합니다.

`Person` 클래스는 이전과 같은 방법으로 정의합니다:

```swift
class Person {
  var residence: Residence?
}
```

`Residence` 클래스는 이전보다 더 복잡합니다. 이번에는, `Residence` 클래스에 `rooms` 라는 '변수 속성' 을 정의하고, 이를 `[Room]` 타입의 빈 배열로 초기화합니다:

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

이 버전의 `Residence` 는 `Room` 인스턴스의 배열을 저장하고 있으므로, `numberOfRooms` 속성을, '저장 속성' 이 아니라, '계산 속성' 으로 구현합니다. `numberOfRooms` 계산 속성은 단순히 `rooms` 배열에 있는 `count` 속성 값을 반환합니다.

`rooms` 배열에 바로 접근할 수 있도록, 이 버전의 `Residence` 는 요청한 색인에 있는 `rooms` 배열의 '방 (room)' 에 접근하는 '읽고-쓰기' 첨자 연산을 제공합니다.

이 버전의 `Residence` 는 `printNumberOfRooms` 라는 메소드도 제공하는데, 이는 단순히 '거주지 (residence)' 에 있는 방의 개수를 출력합니다.

마지막으로, `Residence` 는 타입이 `Address?` 인, `Address` 라는 '옵셔널 속성' 을 정의합니다. 이 속성에서 사용하있는 `Address` 클래스 타입은 아래에서 정의합니다.

`rooms` 배열에서 사용하는 `Room` 클래스는 `name` 이라는 하나의 속성만 가지고 있는 간단한 클래스로, 초기자에서 이 속성에 적당한 방 이름을 설정합니다:

```swift
class Room {
  let name: String
  init(name: String) { self.name = name }
}
```

이 모델의 마지막 클래스는 `Address` 입니다. 이 클래스는 `String?` 타입의 옵셔널 속성을 세 개 가지고 있습니다. 처음 두 개의 속성인, `buildingName` 과 `buildingNumber` 는, 주소에서 특정 건물을 식별하기 위한 방법으로 서로를 대체합니다. 세 번째 속성인, `street` 는, 해당 주소의 거리 이름에 사용됩니다:

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

`Address` 클래스는, 반환 타입이 `String?` 인, `buildingIdentifier()` 라는 메소드도 제공합니다. 이 메소드는 주소 속성을 검사하여 `buildingNumber` 와 `street` 값이 모두 있으면 이 둘을 이은 값을 반환하고, 그렇진 않지만 `buildingName` 값이 있으면 이를 반환하며, 그것도 아니라면 `nil` 을 반환합니다.

### Accessing Properties Through Optional Chaining (옵셔널 사슬을 통해 속성에 접근하기)

[Optional Chaining as an Alternative to Forced Unwrapping (강제 풀기의 대안으로써의 옵셔널 사슬)](#optional-chaining-as-an-alternative-to-forced-unwrapping-강제-풀기의-대안으로써의-옵셔널-사슬) 에서 보인 바 있듯이, 옵셔널 사슬을 사용하면 옵셔널 값에 대한 속성에 접근할 수 있으며, 해당 속성의 접근이 성공했는 지 검사할 수 있습니다.

위에서 정의한 클래스를 사용하여 새로운 `Person` 인스턴스를 생성하고, 이전과 같이 `numberOfRooms` 속성에 접근해 봅시다:

```swift
let john = Person()
if let roomCount = john.residence?.numberOfRooms {
  print("John's residence has \(roomCount) room(s).")
} else {
  print("Unable to retrieve the number of rooms.")
}
// "Unable to retrieve the number of rooms." 를 출력합니다.
```

`john.residence` 가 `nil` 이기 때문에, 이 옵셔널 사슬 호출은 이전 처럼 실패하게 됩니다.

옵셔널 사슬을 통해 속성의 값을 설정하도록 시도할 수도 있습니다.

```swift
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress
```

이 예제에서는, `john.residence` 의 `address` 를 설정하려는 시도는 실패하게 되는데, 이는 현재 `john.residence` 가 `nil` 이기 때문입니다.

'할당 (assignment)' 은 '옵셔널 사슬 (optional chaining)' 의 일부분이며, 이것의 의미는 `=` 연산자의 오른쪽에 있는 코드의 값은 아무 것도 계산되지 않는다는 것입니다. 앞 예제에서, `someAddress` 의 값이 절대로 계산되지 않는다는 점을 알기는 쉽지 않은데, 상수에 대한 접근은 어떤 부작용도 가지고 있지 않기 때문입니다. 아래는 똑같은 할당 작업을 하지만, 함수를 써서 주소를 생성하고자 합니다. 이 함수는 값을 반환하기 전에 "Function was called (함수를 호출하였습니다)" 를 출력하여, `=` 연산자의 오른쪽 값이 계산되었는 지를 보여줍니다.

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

`createAddress()` 함수가 호출되지 않았다는 건, 아무 것도 출력되지 않았다는 것으로, 알 수 있습니다.

### Call Methods Through Optional Chaining (옵셔널 사슬을 통해 메소드 호출하기)

옵셔널 사슬을 사용하여 옵셔널 값에 있는 메소드를 호출할 수 있으며, 그 메소드 호출이 성공했는지 여부도 검사할 수 있습니다. 해당 메소드가 반환 값을 정의하지 않은 경우에도 이렇게 할 수 있습니다.

`Residence` 클래스에 있는 `printNumberOfRooms()` 메소드는 현재의 `numberOfRooms` 값을 출력합니다. 메소드는 다음처럼 생겼습니다:

```swift
func printNumberOfRooms() {
  print("The number of rooms is \(numberOfRooms)")
}
```

이 메소드는 반환 타입을 지정하고 있지 않습니다. 하지만, 반환 타입이 없는 함수와 메소드는 `Void` 라는 암시적인 반환 타입을 가지며, 이는 [Functions Without Return Values (반환 값이 없는 함수)]({% post_url 2020-06-02-Functions %}#functions-without-return-values-반환-값이-없는-함수) 에서 설명한 바 있습니다. 이것의 의미는 `()` 인 값 값, 또는 '빈 튜플 (empty tuple)' 을 반환한다는 것입니다.

옵셔널 값에 있는 이 메소드를 '옵셔널 사슬 (optional chaining)' 을 사용하여 호출하면, 메소드의 반환 타입은, `Void` 가 아니라, `Void?` 가 되는데, 왜냐면 '옵셔널 사슬' 을 통해 호출할 땐 반환 값이 항상 옵셔널 타입이기 때문입니다. 이는, 심지어 메소드 그 자체가 반환 값을 정의하지 않더라도, `if` 문으로 `printNumberOfRooms()` 메소드를 호출할 수 있는 지 여부를 검사할 수 있게 해 줍니다. `printNumberOfRooms` 호출의 반환 값을 `nil` 과 비교하면 이 메소드 호출이 성공했는지 확인할 수 있습니다.

```swift
if john.residence?.printNumberOfRooms() != nil {
  print("It was possible to print the number of rooms.")
} else {
  print("It was not possible to print the number of rooms.")
}
// "It was not possible to print the number of rooms." 를 출력합니다.
```

옵셔널 사슬을 통해 속성을 설정하려고 하는 경우도 같은 방식입니다. 위의 [Accessing Properties Through Optional Chaining (옵셔널 사슬을 통해 속성에 접근하기)](#accessing-properties-through-optional-chaining-옵셔널-사슬을-통해-속성에-접근하기) 에 있는 예제는, `residence` 속성이 `nil` 임에도 불구하고, `john.residence` 에 대하여 `address` 값을 설정하려고 합니다. 옵셔널 사슬을 통해 속성을 설정하려는 어떤 시도도 `Void?` 타입의 값을 반환하는데, 이는 속성 설정이 성공했는 지를 확인하기 위해 `nil` 과 비교할 수 있도록 해줍니다:

```swift
if (john.residence?.address = someAddress) != nil {
  print("It was possible to set the address.")
} else {
  print("It was not possible to set the address.")
}
// "It was not possible to set the address." 를 출력합니다.
```

### Accessing Subscripts Through Optional Chaining (옵셔널 사슬을 통해 첨자 연산 접근하기)

옵셔널 사슬을 사용하면 옵셔널 값에 있는 첨자 연산으로부터 값을 설정하거나 가져올 수 있으며, 그 첨자 연산 호출이 성공했는지를 검사할 수도 있습니다.

> 옵셔널 사슬로 옵셔널 값의 첨자 연산에 접근할 때는, '물음표' 를 첨자 연산의 대괄호 기호, 뒤가 아니라, _앞에 (before)_ 붙여야 합니다. 옵셔널 사슬의 물음표는 항상 표현식의 옵셔널 부분 곧바로 뒤에 따라와야 합니다.

다음 예제는 `Residence` 클래스에서 정의한 첨자 연산을 사용하여 `john.residence` 속성의 `rooms` 배열에 있는 첫 번째 방의 이름을 가져오려고 합니다. `john.residence` 는 현재 `nil` 이기 때문에, 첨자 연산 호출은 실패합니다:

```swift
if let firstRoomName = john.residence?[0].name {
  print("The first room name is \(firstRoomName).")
} else {
  print("Unable to retrieve the first room name.")
}
// "Unable to retrieve the first room name." 를 출력합니다.
```

#### Accessing Subscripts of Optional Type (옵셔널 타입의 첨자 연산 접근하기)

### Linking Multiple Levels of Chaining (여러 단계로 이어서 연결하기)

### Chaining on Methods with Optional Return Values (옵셔널 반환 값을 가지는 메소드 줄짓기?)

### 참고 자료

[^Optional-Chaining]: 이 글에 대한 원문은 [Optional Chaining](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 에서 확인할 수 있습니다.

[^gracefully-fail]: 본문에서 사용한 '우아하게 실패한다 (fail gracefully)' 라는 말은 '실행-시간 에러 (runtime error)' 가 발생하지 않고 `nil` 이 되는 것을 말합니다.
