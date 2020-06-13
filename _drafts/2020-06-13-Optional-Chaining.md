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

### Optional Chaining as an Alternative to Forced Unwrapping (강제 풀기의 대안으로 사용되는 옵셔널 사슬)

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

`john.residence` 는 이제 `nil` 이 아니라, 실제 `Residence` 인스턴스를 가지고 있습니다. 이전과 같은 옵셔널 사슬로 `numberOfRooms` 에 접근하면, 이제는 기본 `numberOfRooms` 값이 `1` 인 `Int?` 를 반환하게 됩니다.

```swift
if let roomCount = john.residence?.numberOfRooms {
  print("John's residence has \(roomCount) room(s).")
} else {
  print("Unable to retrieve the number of rooms.")
}
// "John's residence has 1 room(s)." 를 출력합니다.
```

### Defining Model Classes for Optional Chaining (옵셔널 사슬에 대한 클래스 모델 정의하기)

### Accessing Properties Through Optional Chaining (옵셔널 사슬을 통해 속성 접근하기)

### Call Methods Through Optional Chaining (옵셔널 사슬을 통해 메소드 호출하기)

### Accessing Subscripts Through Optional Chaining (옵셔널 사슬을 통해 첨자 연산 접근하기)

#### Accessing Subscripts of Optional Type (옵셔널 타입의 첨자 연산 접근하기)

### Linking Multiple Levels of Chaining (여러 단계로 이어서 연결하기)

### Chaining on Methods with Optional Return Values (옵셔널 반환 값을 가지는 메소드 줄짓기?)

### 참고 자료

[^Optional-Chaining]: 이 글에 대한 원문은 [Optional Chaining](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 에서 확인할 수 있습니다.

[^gracefully-fail]: 본문에서 사용한 '우아하게 실패한다 (fail gracefully)' 라는 말은 '실행-시간 에러 (runtime error)' 가 발생하지 않고 `nil` 이 되는 것을 말합니다.
