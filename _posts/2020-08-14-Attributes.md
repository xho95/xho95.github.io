---
layout: post
comments: true
title:  "Swift 5.3: Attributes (특성)"
date:   2020-08-14 11:30:00 +0900
categories: Swift Language Grammar Attribute
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Attributes](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html) 부분[^Attributes]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 스위프트 5.3 에 대한 내용이 다시 일부 수정되어서,[^swift-update] 추가된 내용 먼저 옮기고 나머지 부분을 옮기도록 합니다. 전체 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Attributes (특성)

스위프트에는 두 가지 종류의 '특성 (attributes)' 이 있습니다: 선언에 적용되는 것과 타입에 적용되는 것이 그것입니다. 특성은 선언 또는 타입에 대한 추가적인 정보를 제공합니다. 예를 들어, 함수 선언에 대한 `discardableResult` 특성은, 함수가 값을 반환하더라도, 컴파일러가 반환 값을 사용하지 않는다는 이유로 경고를 생성하지는 않아야 한다는 것을 나타냅니다.

특성을 지정하려면 `@` 기호 뒤에 특성의 이름과 그 특성이 받는 어떤 인자를 작성합니다:

@`attribute name-특성 이름`<br />
@`attribute name-특성 이름`(`attribute argument-특성 인자`)

몇몇 '선언 특성 (declaration attributes)' 은 특성에 대한 추가 정보를 지정하는 인자와 특정 선언에 적용하는 방법을 지정하는 인자를 받습니다. 이 _특성 인자 (attribute arguments)_ 들은 괄호로 닫혀 있으며, 양식은 그들이 속한 특성에서 정의합니다.

### Declaration Attributes (선언 특성)

'선언 특성' 은 선언에만 적용할 수 있습니다.

#### available (사용 가능한)

이 특성을 적용하면 선언의 '생명 주기 (life cycle)' 가 정해진 스위프트 언어 버전 또는 정해진 플랫폼 및 운영 체제 버전과 관계되어 있다는 것을 지시합니다.

`available` 특성은 항상 두 개 이상의 쉼표로 구분된 특성 인자들의 목록과 같이 사용합니다. 이 인자들은 다음의 플랫폼 또는 언어 이름 중 하나로 시작합니다:

* `iOS`
* `iOSApplicationExtension`
* `macOS`
* `macOSApplicationExtension`
* `macCatalyst`
* `macCatalystApplicationExtension`
* `watchOS`
* `watchOSApplicationExtension`
* `tvOS`
* `tvOSApplicationExtension`
* `swift`

'별표 (asterisk; `*`)' 를 사용하면 위에 나열한 모든 플랫폼 이름에 대한 선언의 '사용 가능성 (availability)' 을 지시할 수도 있습니다. '스위프트 버전 번호' 를 사용하여 '사용 가능성' 을 지시하는 `available` 특성은 '별표' 를 사용할 수 없습니다.

나머지 인자들은 어떤 순서로 나타내도 상관 없으며, 중요한 '이정표 (milestones)' 를 포함한, 선언의 생명 주기에 대한 추가적인 정보를 지정할 수 있습니다.

* `unavailable` 인자는 이 선언이 지정한 플랫폼에서는 사용 가능하지 않음을 지시합니다. 이 인자는 '스위프트 버전 사용 가능성' 을 지정할 때는 사용할 수 없습니다.

* `introduced` 인자는 이 선언을 도입하도록 지정한 플랫폼 또는 언어의 첫 번째 버전을 지시합니다. 형식은 다음과 같습니다:

  introduce: `version number-버전 번호`

  _version number-버전 번호_ 는, 마침표로 구분된, '1' 개에서 '3' 개 사이의 양의 정수로 구성됩니다.

* `deprecated` 인자는 이 선언을 '폐기 예정 (deprecated)' 하기로 지정한 플랫폼 또는 언어의 첫 번째 버전을 지시합니다. 형식은 다음과 같습니다:

  deprecated: `version number-버전 번호`

  선택 사항인 _version number-버전 번호_ 는, 마침표로 구분된, '1' 개에서 '3' 개 사이의 양의 정수로 구성됩니다. '버전 번호' 를 생략하면, 폐지 시점에 대한 어떤 정보도 없이, 이 선언이 현재 폐지 예정이라는 것을 지시합니다. 버전 번호를 생략할 경우, '콜론 (`:`)' 도 생략합니다.

* `obsoleted` 인자는 이 선언을 '폐기 (obsoleted)' 하기로 지정한 플랫폼 또는 언어의 첫 번째 버전을 지시합니다. 선언을 폐기하면, 지정한 플랫폼 또는 언어에서 제거되며 더 이상 사용할 수 없게 됩니다. 형식은 다음과 같습니다:

  obsoleted: `version number-버전 번호`

  _version number-버전 번호_ 는, 마침표로 구분된, '1' 개에서 '3' 개 사이의 양의 정수로 구성됩니다.

* `message` 인자는 '폐기 예정 (deprecated)' 이거나 '폐기한 (obsoleted)' 선언의 사용에 대한 '경고 (warning)' 또는 '에러 (error)' 를 내보낼 때 컴파일러가 보여주는 문장 형태의 메시지를 제공합니다. 형식은 다음과 같습니다:

  message: `message-메시지`

  _message-메시지_ 는 '문자열 글자 값 (string literal)' 으로 구성됩니다.

* `rename` 인자는 이름이 바뀐 선언에 대한 새 이름을 지시하는 문장 형태의 메시지를 제공합니다. 컴파일러는 이름이 바뀐 선언에 대한 에러를 내보낼 때 이 새로운 이름을 보여줍니다. 형식은 다음과 같습니다:

  renamed: `new name-새 이름`

  _new name-새 이름_ 은 '문자열 글자 값' 으로 구성됩니다.

  아래에 보인 것처럼, `rename` 인자와 `unavailable` 인자를 가진 `available` 특성을 '타입 별명 선언 (type alias declaration)' 에 적용하면, 선언의 이름이 프레임웍 또는 라이브러리의 발매 중에 바뀌었다는 것을 지시할 수 있습니다. 이렇게 조합하면 이 선언의 이름이 바뀌었다는 컴파일 시간 에러로 끝나게 됩니다.

  ```swift
  // 첫 번재 발매
  protocol MyProtocol {
    // 프로토콜 정의
  }

  // 뒤이은 발매에서는 MyProtocol 의 이름을 바꿉니다.
  protocol MyRenamedProtocol {
    // 프로토콜 정의
  }

  @available(*, unavailable, renamed: "MyRenamedProtocol")
  typealias MyProtocol = MyRenamedProtocol
  ```

'다중 `available` 특성' 을 단일 선언에 적용하면 서로 다른 플랫폼 및 서로 다른 버전의 스위프트에 대한 선언의 사용 가능성을 지정할 수 있습니다. 만약 특성에서 지정한 플랫폼 또는 언어 버전이 현재 대상과 일치하지 않는 경우 그 `available` 특성을 적용한 선언은 무시됩니다. 다중 `available` 특성을 사용할 경우, 플랫폼 사용 가능성과 스위프트 사용 가능성을 조합하는 것이 효과적입니다.

`avaiable` 특성이 플랫폼 또는 언어 이름 인자과 더불어 `introdued` 인자 만을 지정하는 경우, 다음의 '약칭 구문 표현 (shorhand syntax)' 를 대신 사용할 수 있습니다:

\@available(`platform name-플랫폼 이름` `version number-버전 번호`, *)<br />
\@available(swift `version number-버전 번호`)

`avaiable` 특성에 대한 '약칭 구문 표현' 은 다중 플랫폼에 대한 사용 가능성을 간결하게 표현해줍니다. 두 형식이 기능적으로 '동치 (equivalent)' 이더라도, 가능할 때마다 '약칭' 형식을 사용하는 것이 좋습니다.

```swift
@available(iOS 10.0, macOS 10.12, *)
class MyClass {
  // 클래스 정의
}
```

스위프트 버전 번호를 사용하여 '사용 가능성' 을 지정하는 `available` 특성은 선언의 플랫폼 사용 가능성을 추가적으로 지정할 수 없습니다. 그 대신, '스위프트 버전 사용 가능성' 과 하나 이상의 '플랫폼 사용 가능성' 을 지정하려면 별도의 `available` 특성을 사용합니다.

```swift
@available(swift 3.0.2)
@available(macOS 10.12, *)
struct MyStruct {
  // 구조체 정의
}
```

#### discardableResult (버릴 수 있는 결과)

이 특성을 함수 선언 또는 메소드 선언에 적용하면 값을 반환하는 함수나 메소드가 결과를 사용하지 않은 채로 호출할 때도 컴파일러가 경고를 내지 않도록 합니다.

#### dynamicCallable (동적으로 호출 가능한)

이 특성을 클래스, 구조체, 열거체, 또는 프로토콜에 적용하면 그 타입의 인스턴스를 호출 가능한 함수처럼 취급합니다. 해당 타입은 반드시 `dynamicCall(withArguments:)` 메소드나, `dynamicCall(withKeywordArguments:)` 메소드 중 하나, 또는 둘 다를 구현해야 합니다.

동적으로 호출 가능한 타입의 인스턴스는 마치 어떤 개수의 인자도 받을 수 있는 함수인 것처럼 호출할 수 있습니다.

```swift
@dynamicCallable
struct TelephoneExchange {
  func dynamicallyCall(withArguments phoneNumber: [Int]) {
    if phoneNumber == [4, 1, 1] {
      print("Get Swift help on forums.swift.org")
    } else {
      print("Unrecognized number")
    }
  }
}

let dial = TelephoneExchange()

// 동적 메소드 호출을 사용합니다.
dial(4, 1, 1)
// "Get Swift help on forums.swift.org" 를 출력합니다.

dial(8, 6, 7, 5, 3, 0, 9)
// "Unrecognized number" 를 출력합니다.

// 실제 메소드를 직접 호출합니다.
dial.dynamicallyCall(withArguments: [4, 1, 1])
```

`dynamicCall(withArguments:)` 메소드의 선언은-위 예제에 있는 `[Int]` 와 같이-반드시 [ExpressibleByArrayLiteral](https://developer.apple.com/documentation/swift/expressiblebyarrayliteral) 프로토콜을 준수하는 단일 매개 변수를 가져야 합니다. 반환 타입은 어떤 타입든 될 수 있습니다.

`dynamicCall(withKeywordArguments:)` 메소드를 구현하는 경우에는 '동적 메소드 호출' 에서 이름표를 포함시킬 수 있습니다.

```swift
@dynamicCallable
struct Repeater {
  func dynamicallyCall(withKeywordArguments pairs: KeyValuePairs<String, Int>) -> String {
    return pairs
      .map { label, count in
        repeatElement(label, count: count).joined(separator: " ")
      }
      .joined(separator: "\n")
  }
}

let repeatLabels = Repeater()
print(repeatLabels(a: 1, b: 2, c: 3, b: 2, a: 1))
// a
// b b
// c c c
// b b
// a
```

`dynamicCall(withKeywordArguments:)` 메소드의 선언은 반드시 [ExpressibleByDictionaryLiteral](https://developer.apple.com/documentation/swift/expressiblebydictionaryliteral) 프로토콜을 준수하는 단일 매개 변수를 가져야 하며, 반환 타입은 어떤 타입이든 될 수 있습니다. 매개 변수의 [Key](https://developer.apple.com/documentation/swift/expressiblebydictionaryliteral/2294108-key) 는 반드시 [ExpressibleByStringLiteral](https://developer.apple.com/documentation/swift/expressiblebystringliteral) 이어야 합니다. 이전 예제는 [KeyValuePairs](https://developer.apple.com/documentation/swift/keyvaluepairs) 를 매개 변수 타입으로 사용하므로 '호출자 (caller)' 가 중복된 매개 변수 레이블을 포함할 수 있습니다-`a` 와 `b` 는 `repeat` 호출에서 여러 번 나타납니다.

두 개의 `dynamicCall` 메소드를 모두 구현하는 경우, 메소드 호출이 키워드 인자를 포함할 땐 `dynamicCall(withKeywordArguments:)` 을 호출합니다. 그 외 모든 다른 경우에는, `dynamicCall(withArguments:)` 를 호출합니다.

동적으로 호출 가능한 인스턴스는 `dynamicallyCall` 메소드 구현에서 지정한 타입과 일치하는 인자와 반환 값을 가질 때만 호출할 수 있습니다. 다음 예제에 있는 호출은 컴파일 되지 않는데 왜냐면 `KeyValuePairs<String, String>` 을 받는 `dynamicCall(withArguments:)` 구현은 없기 때문입니다.

```swift
repeatLabels(a: "four") // 에러
```

#### dynamicMemberLookup (동적으로 멤버 찾아가기)

이 특성을 클래스, 구조체, 열거체, 또는 프로토콜에 적용하면 실행 시간에 멤버를 이름으로 찾아갈 수 있습니다. 그 타입은 반드시 `subscript(dynamicMemberLookup:)` 첨자 연산을 구현해야 합니다.

명시적인 '멤버 표현식' 에 있는, 이름 있는 멤버와 관련된 선언이 없는 경우, 이 표현식은, 멤버에 대한 정보를 인자로 전달하는, 타입의 `subscript(dynamicMemberLookup:)` 첨자 연산에 대한 호출인 것으로 이해합니다. 첨자 연산은 '키 경로 (key path)' 또는 '멤버 이름' 인 매개 변수를 받을 수 있습니다; 두 첨자 연산 모두들 구현한 경우, 키 경로 인자를 취하는 첨자 연산을 사용합니다.

`subscript(dynamicMemberLookup:)` 의 구현은 키 경로의 경우 [KeyPath](https://developer.apple.com/documentation/swift/keypath), [WritableKeyPath](https://developer.apple.com/documentation/swift/writablekeypath), 및 [ReferenceWritableKeyPath](https://developer.apple.com/documentation/swift/referencewritablekeypath) 인 인자를 받을 수 있습니다. 멤버 이름의 경우 [ExpressibleByStringLiteral] 프로토콜을 준수하는 타입인 인자를 받을 수 있습니다-대부분의 경우, `String` 입니다. 첨자 연산의 반환 타입은 어떤 타입이든 될 수 있습니다.

'동적으로 멤버 찾아가기' 를 '멤버 이름' 으로 하는 것은, 다른 언어로 된 자료를 스위프트로 연동할 때 처럼, 컴파일 시간에 타입 검사를 할 수 없는 자료에 대한 '포장 타입 (wrapper type; 래퍼 타입)' 을 생성하는 용도로 사용할 수 있습니다. 예를 들면 다음과 같습니다:

```swift
@dynamicMemberLookup
struct DynamicStruct {
  let dictionary = ["someDynamicMember": 325,
                    "someOtherMember": 787]
  subscript(dynamicMember member: String) -> Int {
    return dictionary[member] ?? 1054
  }
}
let s = DynamicStruct()

// '동적으로 멤버 찾아가기' 를 사용합니다.
let dynamic = s.someDynamicMember
print(dynamic)
// "325" 를 출력합니다.

// 실제 첨자 연산을 직접 호출합니다.
let equivalent = s[dynamicMember: "someDynamicMember"]
print(dynamic == equivalent)
// "true" 를 출력합니다.
```

'동적으로 멤버 찾아가기' 를 '키 경로' 로 하는 것은 컴파일-시간 타입 검사를 지원하는 방식으로 '포장 타입' 을 구현하는 용도로 사용할 수 있습니다. 예를 들면 다음과 같습니다:

```swift
struct Point { var x, y: Int }

@dynamicMemberLookup
struct PassthroughWrapper<Value> {
  var value: Value
  subscript<T>(dynamicMember member: KeyPath<Value, T>) -> T {
    get { return value[keyPath: member] }
  }
}

let point = Point(x: 381, y: 431)
let wrapper = PassthroughWrapper(value: point)
print(wrapper.x)
```

#### frozen (동결)

이 특성을 구조체나 열거체 선언에 적용하면 타입에 대해서 할 수 있는 변화의 종류를 제약합니다. 이 특성은 '라이브러리 진화 모드 (library evolution mode)' 에서 컴파일할 때만 허용됩니다. '미래 버전 (future versions)' 의 라이브러리는 열거체의 'case 값' 또는 구조체의 저장 인스턴스 속성을 추가, 삭제, 및 '재배치 (reordering)' 하는 것으로써 선언을 바꿀 수 없습니다. 이러한 변화는 '동결되지 않은 타입 (nonfrozen types)' 에 대해서는 허용된 것이지만, '동결된 타입 (frozen types)' 에서는 'ABI 호환성 (ABI compatibility)' 을 깨뜨립니다.

> 컴파일러가 '라이브러리 진화 모드' 이지 않을 때는, 모든 구조체와 열거체는 암시적으로 '동결 (frozen)' 이 되어, 이 특성이 무시됩니다.

'라이브러리 진화 모드' 에서, '동결되지 않은' 구조체 및 열거체의 멤버와 상호 작용하는 코드는 '미래 버전' 의 라이브러리가 해당 타입의 멤버 일부를 추가, 삭제, 또는 재배치하는 경우에라도 다시 컴파일하지 않고 계속 작업할 수 있는 방식으로 컴파일됩니다. 컴파일러는 실행 시간에 정보를 찾아가는 것 및 간접 계층을 추가하는 것과 같은 기술을 사용하여 이를 가능하게 만듭니다. 구조체 또는 열거체를 '동결 (frozen)' 로 만드는 것은 성능을 얻기 위해 이 유연함을 포기하는 것입니다: 미래 버전의 라이브러리는 타입에 대해서 제한된 변화만을 줄 수 있지만, 컴파일러는 타입의 멤버와 상호 작용하는 코드에 추가적인 최적화를 만들 수 있습니다.

'동결된 타입', '동결된 구조체' 에 있는 저장 속성의 타입, 그리고 동결된 열거체 'case 값' 과 '결합된 값 (associated values)' 은 반드시 '공용 (public)' 이거나 또는 `usableFromInline` 특성으로 표시해야 합니다. '동결된 구조체' 의 속성은 '속성 관찰자' 를 가질 수 없으며, 저장 인스턴스 속성에 초기 값을 제공하는 표현식은, [inlinable (인라인 가능한)](#inlinable-인라인-가능한) 에서 논의한 것처럼, 반드시 '인라인 가능한 함수 (inlinable functions)' 와 같은 '제약 조건 (restrictions)' 을 따라야 합니다.

'명령 줄 (command line)' 에서 '라이브러리 진화 모드' 를 켜려면, 스위프트 컴파일러에 `-enable-library-evolution` 옵션을 전달합니다. '엑스코드 (Xcode)' 에서 켜려면, [Xcode Help](https://help.apple.com/xcode/mac/current/#/dev04b3a04ba) 에서 설명한 것처럼, "배포용 라이브러리 제작 (Build Libraries for Distribution)" 이라는 빌드 설정인 (`BUILD_LIBRARY_FOR_DISTRIBUTION`) 을 '예 (Yes)' 로 설정합니다.

'동결된 열거체' 에 대한 'switch' 문은, [Switching Over Future Enumeration Cases (미래의 열거체 case 값에 대해서도 전환 (switching) 하기)](#switching-over-future-enumeration-cases-미래의-열거체-case-값에-대해서도-전환-switching-하기) 에서 논의한 것처럼, `default` 'case 절' 이 필수가 아닙니다. '동결된 열거체' 를 전환할 때 `default` 또는 `@unknown default` 'case 절' 를 포함하면 '경고' 를 일으키는데 왜냐면 해당 코드는 절대로 실행되지 않기 때문입니다.

#### GKInspectable (점검 가능한 GameplayKit 성분)

이 특성을 적용하면 사용자 지정 'GameplayKit' '성분 (component) 속성' 을 'SpriteKit' 편집기의 'UI' 로 내보입니다. 이 특성을 적용하는 것은 또한 `objc` 특성이기도 함을 의미합니다.

#### inlinable (인라인 가능한)

#### main

이 특성을 구조체, 클래스, 또는 열거체 선언에 적용하는 건 그것이 프로그램 흐름에서 '최상위-수준의 진입점 (top-level entry point)' 을 가진다는 것을 나타냅니다. 그 타입은, 어떤 인자도 받지 않고 `Void` 를 반환하는, 타입 함수인 `main` 을 반드시 제공해야 합니다:

```swift
@main
struct MyTopLevel {
    static func main() {
        // 여기에 최상위-수준 코드를 둡니다.
    }
}
```

`main` 특성의 '필수 조건' 을 설명하는 또 다른 방법은 이 특성을 붙이려는 타입은 아래에 있는 가상의 프로토콜을 준수하는 타입이 하는 것과 같은 필수 조건을 반드시 만족해야 한다는 것입니다:

```swift
protocol ProvidesMain {
    static func main() throws
}
```

실행 파일을 만들기 위해 컴파일하는 스위프트 코드는, [Top-Level Code (최상위-수준 코드)]({% post_url 2020-08-15-Declarations %}#top-level-code-최상위-수준-코드) 에서 설명한 것처럼, 최대 한 개의 최상위-수준 진입점을 가질 수 있습니다.

#### nonobjc

#### NSApplicationMain

#### NSCopying

#### NSManaged

#### objc

#### objcMembers

#### propertyWrapper

#### requires_stored_property_inits

#### testable

#### UIApplicationMain

#### usableFromInline

#### warn_unqualifed_access

#### Declaration Attributes Used by Interface Builder

### Type Attributes

#### autoclosure

#### convention

#### escaping

### Switch Case Attributes

#### unknown

### 참고 자료

[^Attributes]: 원문은 [Attributes](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.
