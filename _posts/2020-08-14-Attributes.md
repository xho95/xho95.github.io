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

'동결된 열거체' 에 대한 'switch' 문은, [Switching Over Future Enumeration Cases (미래의 열거체 case 값에 대해서도 전환 (switching) 하기)]({% post_url 2020-08-20-Statements %}#switching-over-future-enumeration-cases-미래의-열거체-case-값에-대해서도-전환-switching-하기) 에서 논의한 것처럼, `default` 'case 절' 이 필수가 아닙니다. '동결된 열거체' 를 전환할 때 `default` 또는 `@unknown default` 'case 절' 를 포함하면 '경고' 를 일으키는데 왜냐면 해당 코드는 절대로 실행되지 않기 때문입니다.

#### GKInspectable (점검 가능한 GameplayKit 성분)

이 특성을 적용하면 사용자 지정 'GameplayKit' '성분 (component) 속성' 을 'SpriteKit' 편집기의 'UI' 로 내보입니다. 이 특성을 적용하는 것은 또한 `objc` 특성이기도 함을 의미합니다.

#### inlinable (인라인 가능한)

이 특성을 함수, 메소드, 계산 속성, 첨자 연산, 편의 초기자, 또는 정리자 (deinitializer) 선언에 적용하면 해당 선언의 구현을 모듈의 공용 인터페이스 부분으로 내보입니다. 컴파일러는 '인라인 가능한 기호 (inlinable symbol)' 에 대한 호출을 호출하는 쪽에서 기호 구현의 복사본으로 대체하도록 허용됩니다.

'인라인 가능한 코드' 는 어떤 모듈에서 선언한 `public` 기호와도 상호 작용할 수 있으며, `usableFromInline` 특성으로 표시한 경우 같은 모듈에서 선언한 `internal` 기호와도 상호 작용할 수 있습니다. '인라인 가능한 코드' 는 `private` 또는 `fileprivate` 기호와 상호 작용할 수 없습니다.

이 특성을 함수 내부에 중첩된 선언이나 `fileprivate` 또는 `private` 선언에는 적용할 수 없습니다. '인라인 가능한 함수' 내부에서 정의한 함수와 클로저는, 이 특성으로 표시할 수 없음에도 불구하고, 암시적으로 '인라인 가능한' 것이 됩니다.

#### main (메인)

이 특성을 구조체, 클래스, 또는 열거체 선언에 적용하면 그것이 프로그램 흐름에 대한 '최상위-수준 진입점 (top-level entry point)' 을 가진다는 것을 지시합니다. 그 타입은 반드시 어떤 인자도 취하지 않으며 `Void` 를 반환하는 `main` 이라는 타입 함수를 제공해야 합니다. 예를 들면 다음과 같습니다:

```swift
@main
struct MyTopLevel {
  static func main() {
    // 최상위-수준 코드는 여기에 둡니다.
  }
}
```

`main` 특성의 '필수 조건' 을 설명하는 또 다른 방식은 이 특성을 붙인 타입은 반드시 다음의 '가상 프로토콜 (hypothetical protocol)' 을 준수하는 타입과 같은 필수 조건을 만족해야 한다는 것입니다:

```swift
protocol ProvidesMain {
    static func main() throws
}
```

실행 파일을 만들려고 컴파일하는 스위프트 코드는, [Top-Level Code (최상위-수준 코드)]({% post_url 2020-08-15-Declarations %}#top-level-code-최상위-수준-코드) 에서 설명한 것처럼, '최상위-수준 진입점' 을 최대 한 개만 가질 수 있습니다.

#### nonobjc (오브젝티브-C 가 아닌)

이 특성을 메소드, 속성, 첨자 연산, 또는 초기자 선언에 적용하면 암시적으로 `objc` 특성이 되지않도록 합니다. `nonobjc` 특성은 이 선언이, 설령 오브젝티브-C 에서 표현할 수는 있더라도, 오브젝티브-C 코드에서 사용 불가능함을 컴파일러에게 알려줍니다.

이 특성을 '익스텐션 (확장)' 에 적용하면 해당 '익스텐션' 에서 명시적으로 `objc` 특성을 표시하지 않은 모든 멤버들에 이를 적용하는 것과 같은 효과를 가집니다.

`nonobjc` 특성은 `objc` 특성으로 표시한 클래스의 '연동 메소드 (bridging methods)' 에 대한 '순환성 (circularity)' 을 해결하는데, 그리고 `objc` 특성으로 표시한 클래스의 메소드와 초기자에 대한 '중복 정의 (overloading)' 을 허용하는데 사용합니다.

`nonobjc` 특성으로 표시한 메소드는 `objc` 특성으로 표시한 메소드를 '재정의 (override)' 할 수 없습니다. 하지만, `objc` 특성으로 표시한 메소드는 `nonobjc` 특성으로 표시한 메소드를 '재정의' 할 수 있습니다. 이와 비슷하게, `nonobjc` 특성으로 표시한 메소드는 `objc` 특성으로 표시한 메소드에 대한 '프로토콜 필수 조건 (protocol requirement)' 을 만족시킬 수 없습니다.

#### NSApplicationMain (NS 앱 메인)

이 특성을 클래스에 적용하면 이것이 '응용 프로그램 대리자 (application delegate)' 라는 것을 지시합니다. 이 특성을 사용하는 것은 `NSApplicationMain(_:_:)` 함수를 호출하는 것과 '동치 (equivalent)' 입니다.

이 특성을 사용하지 않을 경우, 다음과 같이 `NSApplicationMain(_:_:)` 함수를 호출하는 '최상위 수준' 코드를 가지는 `main.swift` 파일을 제공하도록 합니다.

```swift
import AppKit
NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
```

실행 파일을 만들려고 컴파일하는 스위프트 코드는, [Top-Level Code (최상위-수준 코드)]({% post_url 2020-08-15-Declarations %}#top-level-code-최상위-수준-코드) 에서 설명한 것처럼, '최상위-수준 진입점' 을 최대 한 개만 가질 수 있습니다.

#### NSCopying (NS 복사)

이 특성은 클래스의 '저장 변수 속성' 에 적용합니다. 이 특성은 속성의 '설정자 (setter)' 가-속성 자체의 값 대신-`copyWithZone(_:)` 메소드가 반환하는-속성 값의 _복사본 (copy)_ 을 만들어서 통합되도록 합니다. 속성의 타입은 반드시 `NSCopying` 프로토콜을 준수해야 합니다.

`NSCopying` 특성은 오브젝티브-C 의 `copy` 속성 특성과 비슷한 방식으로 동작합니다.

#### NSManaged (NS 관리)

이 특성을 `NSManagedObject` 를 상속받은 클래스의 인스턴스 메소드 또는 저장 변수 속성에 적용하면, '코어 데이터 (Core Data)' 가, '결합된 개체 설명 (associated entity description)'[^associated-entity-description] 을 기초로 하여, 실행 시간에 동적으로 그 구현을 제공한다는 것을 지시합니다. `NSManaged` 특성으로 표시한 속성에 대해서, '코어 데이터 (Core Data)' 는 실행 시간에 '저장 공간 (storage)' 도 제공합니다. 이 특성을 적용하는 것은 또한 `objc` 특성이기도 함을 의미합니다.

#### objc (오브젝티브-C)

이 특성은 오브젝티브-C 에서 표현할 수 있는 어떤 선언에든 적용합니다-예를 들어, 중첩되지 않은 클래스, 프로토콜, 제네릭이 아닌 (정수인 원시-값 타입으로 구속된) 열거체, 클래스의 속성과 (획득자 및 설정자를 포함한) 메소드, 프로토콜과 프로토콜의 옵셔널 멤버, 초기자, 그리고 첨자 연산이 그것입니다. `objc` 특성은 선언이 오브젝티브-C 코드에서 사용 가능함을 컴파일러에게 알립니다.

이 특성을 '익스텐션 (확장)' 에 적용하면 해당 '익스텐션' 에서 명시적으로 `nonobjc` 특성을 표시하지 않은 모든 멤버들에 이를 적용하는 것과 같은 효과를 가집니다.

컴파일러는 오브젝티브-C 에서 정의한 어떤 클래스의 하위 클래스에든 `objc` 특성을 암시적으로 추가합니다. 하지만, 이 하위 클래스는 반드시 제네릭이 아니어야 하며, 반드시 어떤 제네릭 클래스에서든 상속받은 것이 아니어야 합니다. 이러한 기준에 부합하는 하위 클래스에는, 아래에서 논의하는 것처럼 오브젝티브-C 이름을 지정하기 위해, 명시적으로 `objc` 특성을 추가할 수 있습니다. `objc` 특성으로 표시한 프로토콜은 이 특성으로 표시되지 않은 프로토콜을 상속할 수 없습니다.

`objc` 특성은 다음과 같은 경우에도 암시적으로 추가됩니다:

* 해당 선언은 하위 클래스에서 '재정의 (override)' 한 것인데, 상위 클래스의 선언이 `objc` 특성을 가지고 있는 경우
* 해당 선언이 `objc` 특성을 가지고 있는 프로토콜의 필수 조건을 만족하는 경우
* 해단 선언이 `IBAction`, `IBSegueAction`, `IBOutlet`, `IBDesignable`, `IBInspectable`, `NSManaged`, 또는 `GKInspectable` 특성을 가지고 있는 경우

`objc` 특성을 열거체에 적용하면, 각각의 열거체 'case 값' 은 열거체 이름과 'case 값' 이름이 이어진 형태로 오브젝티드-C 코드에 노출됩니다. 'case 값' 이름의 첫 번째 글자는 대문자가 됩니다. 예를 들어, 스위프트 열거체인 `Planet` 에 있는 `venus` 라는 이름의 'case 값' 은 오브젝티브-C 에서는 `PlanetVenus` 라는 이름의 'case 값' 으로 노출됩니다.

`objc` 특성은, '식별자 (identifier)' 로 구성된, 단일 특성 인자를 선택적으로 수를 선택적으로 받아 들입니다. 이 식별자는 `objc` 특성을 적용하는 '개체 (entity)' 가 오브젝티브-C 에서 노출될 이름을 지정합니다. 이 인자는 클래스, 열거체, 열거체 'case 값', 프로토콜, 메소드, 획득자, 설정자, 그리고 초기자의 이름을 짓는데 사용할 수 있습니다. 클래스, 프로토콜, 또는 열거체에 대한 오브젝티브-C 이름을 지정할 경우, [Programming with Objective-C](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011210) 의 [Conventions](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Conventions/Conventions.html#//apple_ref/doc/uid/TP40011210-CH10-SW1) 에서 설명한 것처럼, 이름에 '세-글자짜리 접두사 (three-letter prefix)' 를 포함하도록 합니다. 아래 예제는 `ExampleClass` 의 `enabled` 속성에 대한 '획득자 (getter)' 를 속성 그 자체의 이름이 아니라 `isEnabled` 로써 오브젝티브-C 코드에 노출합니다.

```swift
class ExampleClass: NSObject {
  @objc var enabled: Bool {
    @objc(isEnabled) get {
      // 적절한 값을 반환합니다.
    }
  }
}
```

더 자세한 정보는, [Importing Swift into Objective-C](https://developer.apple.com/documentation/swift/imported_c_and_objective-c_apis/importing_swift_into_objective-c) 를 참고하기 바랍니다.

`objc` 특성에 전달한 인자는 해당 선언에 대한 '실행 시간 이름 (runtime name)' 도 바꿀 수 있습니다. '실행 시간 이름' 은 [NSClassFromString](https://developer.apple.com/documentation/foundation/1395135-nsclassfromstring) 처럼, 오브젝티브-C '런타임 (runtime)' 과 상호 작용하는 함수를 호출할 때와, 앱의 'Info.plist' 파일에서 클래스 이름을 지정할 때 사용합니다. 인자를 전달하여 이름을 지정하면, 해당 이름이 오브젝티브-C 코드에 있는 이름인 것처럼 그리고 '실행 시간 (runtime)' 이름인 것처럼 사용됩니다. 인자를 생략하면, 오브젝티브-C 코드에서 사용하는 이름은 스위프트 코드의 이름과 일치하며, '실행 시간 (runtime)' 이름은 스위프트 컴파일러의 일반적인 '이름 뭉개기 (name mangling)' 협약을 따릅니다.

#### objcMembers (오브젝티브-C 멤버)

이 특성을 클래스 선언에 적용하면, 클래스, 및 그 '익스텐션 (확장)', 그 하위 클래스, 그리고 하위 클래스의 모든 '익스텐션' 에 있는 오브젝티브-C 호환 가능한 모든 멤버에 대해 `objc` 특성을 암시적으로 적용합니다.

대부분의 코드는 `objc` 특성을 대신 사용하여, 필요한 선언만 노출하도록 해야 합니다. 많은 선언을 노출할 필요가 있을 경우, 그들을 `objc` 특성을 가지는 '익스텐션' 으로 그룹지으면 됩니다. `objcMembers` 특성은 오브젝티브-C '런타임 (runtime)' 의 '내부 검사 기능 (introspection facilities)' 을 아주 많이 사용하는 라이브러리의 편의를 위한 것입니다. 불필요할 때 `objc`[^objc] 속성을 적용하는 것은 '바이너리 크기' 를 증가시키고 성능에 부정적인 영향을 미칠 수 있습니다.

#### propertyWrapper (속성 포장)

이 특성을 클래스, 구조체, 또는 열거체 선언에 적용하면 해당 타입을 '속성 포장 (property wrapper)' 으로 사용합니다. 이 특성을 타입에 적용할 때는, 그 타입과 같은 이름을 가지는 '사용자 지정 특성 (custom attribute)' 을 생성하는 것입니다. 이 새 특성을 클래스, 구조체, 및 열거체의 속성에 적용하면 속성에 대한 접근을 '포장 타입 (wrapper type)' 의 인스턴스로 '포장 (wrap)' 합니다. 지역 변수와 전역 변수는 '속성 포장 (property wrappers)' 를 사용할 수 없습니다.

'포장 (wrapper)' 은 반드시 `wrappedValue` 인스턴스 속성을 정의해야 합니다. 속성의 _포장된 값 (wrapped value)_ 은 이 속성에 대해서 '획득자 (getter)' 와 '설정자 (setter)' 가 노출하는 값입니다. 대부분의 경우, `wrappedValue` 는 '계산된 값 (computed value)' 이지만, '저장된 값 (stored value)' 이 될 수도 있습니다. '포장 (wrapper)' 은 자신이 포장하는 값에 필요한 '실제 저장 공간' 의 정의와 관리를 책임집니다. 컴파일러는 '포장된 속성' 의 이름에 접두사로 밑줄 (`_`) 을 붙여서 '포장 타입' 의 인스턴스에 대한 저장 공간을 만들고 통합합니다-예를 들어, `someProperty` 에 대한 포장은 `_someProperty` 라고 저장됩니다. '포장' 을 위해 '통합된 저장 공간 (synthesized storage)' 은 `private` 접근 제어 수준을 가집니다.

속성 포장을 가지고 있는 속성은 `willSet` 과 `didSet` 블럭을 포함할 수 있지만, 컴파일러가-통합한 `get` 또는 `set` 블럭을 '재정의 (override)' 할 수는 없습니다.

스위프트는 '속성 포장' 의 초기화를 위해 두 가지 형식의 '수월한 구문 표현 (syntactic sugar)' 을 제공합니다. '포장된 값 (wrapped value)' 의 정의에서 '할당 구문 표현 (assignment syntax)' 을 사용하면 할당의 오른-쪽에 있는 표현식을 '속성 포장' 초기자의 `wrappedValue` 매개 변수에 인자로 전달할 수 있습니다. 특성을 속성에 적용할 때 인자를 제공할 수도 있으며, 이 인자들은 '속성 포장' 의 초기자로 전달됩니다. 예를 들어, 아래 코드에서, `SomeStruct` 는 `SomeWrapper` 가 정의하고 있는 각각의 초기자를 호출합니다.

```swift
@propertyWrapper
struct SomeWrapper {
  var wrappedValue: Int
  var someValue: Double
  init() {
    self.wrappedValue = 100
    self.someValue = 12.3
  }
  init(wrappedValue: Int) {
    self.wrappedValue = wrappedValue
    self.someValue = 45.6
  }
  init(wrappedValue value: Int, custom: Double) {
    self.wrappedValue = value
    self.someValue = custom
  }
}

struct SomeStruct {
  // init() 을 사용합니다.
  @SomeWrapper var a: Int

  // init(wrappedValue:) 을 사용합니다.
  @SomeWrapper var b = 10

  // 둘 다 init(wrappedValue:custom:) 을 사용합니다.
  @SomeWrapper(custom: 98.7) var c = 30
  @SomeWrapper(wrappedValue: 30, custom: 98.7) var d
}
```

'포장된 속성' 을 위한 _드러낸 값 (projected value)_ 은 '속성 포장' 이 추가적인 기능성을 노출하기 위해 사용할 수 있는 두 번째 값입니다. '속성 포장' 타입의 작성자는 이 '드러낸 값 (projected value)' 의 의미를 결정하고 '드러낸 값' 을 노출하는 인터페이스를 정의할 책임이 있습니다. 속성 포장으로 부터 값을 드러내려면, 포장 타입에 대한 `projectedValue` 인스턴스 속성을 정의합니다. 컴파일러는 '포장된 속성' 의 이름에 달러 기호 (`$`) 를 접두사로 붙여서 '드러낸 값' 에 대한 식별자를 만들고 통합합니다-예를 들어, `someProperty` 에 대한 '드러낸 값' 은 `$someProperty` 입니다. '드러낸 값' 은 원래 '포장된 값' 과 같은 수준의 접근 제어 수준을 가집니다.

```swift
@propertyWrapper
struct WrapperWithProjection {
  var wrappedValue: Int
  var projectedValue: SomeProjection {
    return SomeProjection(wrapper: self)
  }
}
struct SomeProjection {
  var wrapper: WrapperWithProjection
}

struct SomeStruct {
  @WrapperWithProjection var x = 123
}
let s = SomeStruct()
s.x           // Int 값
s.$x          // SomeProjection 값
s.$x.wrapper  // WrapperWithProjection 값
```

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

[^associated-entity-description]: '결합된 개체 설명 (associated entity description)' 은 '엑스코드 (Xcode)' 의 `*.xcdatamodeld` 파일에서 만드는 '데이터베이스 스키마 (database schema)' 를 의미합니다. 여기서 '개체 (entity; 엔티티)' 는 다른 '데이터베이스 언어' 의 '테이블 (table)' 에 해당합니다.

[^objc]: 원문 자체에서 `objc` 라고 되어 있는데, `objcMembers` 를 잘못 적은 것이 아닐까 추측됩니다.
