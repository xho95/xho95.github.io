---
layout: post
comments: true
title:  "Swift 5.4: Attributes (특성)"
date:   2020-08-14 11:30:00 +0900
categories: Swift Language Grammar Attribute
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.4)](https://docs.swift.org/swift-book/) 책의 [Attributes](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html) 부분[^Attributes]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 전체 번역은 [Swift 5.4: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

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

`available` 특성이 플랫폼 또는 언어 이름 인자과 더불어 `introdued` 인자 만을 지정하는 경우, 다음의 '약칭 구문 표현 (shorhand syntax)' 를 대신 사용할 수 있습니다:

\@available(`platform name-플랫폼 이름` `version number-버전 번호`, *)<br />
\@available(swift `version number-버전 번호`)

`available` 특성에 대한 '약칭 구문 표현' 은 다중 플랫폼에 대한 사용 가능성을 간결하게 표현해줍니다. 두 형식이 기능적으로 '동치 (equivalent)' 이더라도, 가능할 때마다 '약칭' 형식을 사용하는 것이 좋습니다.

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

#### dynamicMemberLookup (동적으로 멤버 찾아보기)

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

#### frozen (동결된)

이 특성은 타입이 바뀔 수 있는 종류를 제약하기 위해 구조체나 열거체 선언에 적용합니다. 이 특성은 '라이브러리 진화 모드 (library evolution mode)' 에서 컴파일할 때만 허용됩니다. '미래 버전 (future versions)' 의 라이브러리는 열거체의 'case 값' 또는 구조체의 저장 인스턴스 속성을 추가, 삭제, 및 '재배치 (reordering)' 하는 것으로써 선언을 바꿀 수 없습니다. 이러한 변화는 '동결되지 않은 타입 (nonfrozen types)' 에 대해서는 허용된 것이지만, '동결된 타입 (frozen types)' 에서는 'ABI 호환성 (ABI compatibility)' 을 깨뜨립니다.

> 컴파일러가 '라이브러리 진화 모드' 이지 않을 때는, 모든 구조체와 열거체는 암시적으로 '동결된 (frozen)' 것이 되어, 이 특성이 무시됩니다.

'라이브러리 진화 모드' 에서, '동결되지 않은' 구조체 및 열거체의 멤버와 상호 작용하는 코드는 '미래 버전' 의 라이브러리가 해당 타입의 멤버 일부를 추가, 삭제, 또는 재배치하는 경우에라도 다시 컴파일하지 않고 계속 작업할 수 있는 방식으로 컴파일됩니다. 컴파일러는 실행 시간에 정보를 찾아가는 것 및 간접 계층을 추가하는 것과 같은 기술을 사용하여 이를 가능하게 만듭니다. 구조체 또는 열거체를 '동결된 (frozen)' 것으로 만드는 것은 성능을 얻기 위해 이 유연함을 포기하는 것입니다: 미래 버전의 라이브러리는 타입에 대해서 제한된 변화만을 줄 수 있지만, 컴파일러는 타입의 멤버와 상호 작용하는 코드에 추가적인 최적화를 만들 수 있습니다.

'동결된 타입', '동결된 구조체' 에 있는 저장 속성의 타입, 그리고 동결된 열거체 'case 값' 의 '결합 값 (associated values)' 은 반드시 '공용 (public)' 이거나 또는 `usableFromInline` 특성으로 표시해야 합니다. '동결된 구조체' 의 속성은 '속성 관찰자' 를 가질 수 없으며, 저장 인스턴스 속성에 초기 값을 제공하는 표현식은, [inlinable (인라인 가능한)](#inlinable-인라인-가능한) 에서 논의한 것처럼, 반드시 '인라인 가능한 함수 (inlinable functions)' 와 같은 '제약 조건 (restrictions)' 을 따라야 합니다.

'명령 줄 (command line)' 에서 '라이브러리 진화 모드' 를 켜려면, 스위프트 컴파일러에 `-enable-library-evolution` 옵션을 전달합니다. '엑스코드 (Xcode)' 에서 켜려면, [Xcode Help](https://help.apple.com/xcode/mac/current/#/dev04b3a04ba) 에서 설명한 것처럼, "배포용 라이브러리 제작 (Build Libraries for Distribution)" 이라는 빌드 설정인 (`BUILD_LIBRARY_FOR_DISTRIBUTION`) 을 '예 (Yes)' 로 설정합니다.

'동결된 열거체' 에 대한 'switch' 문은, [Switching Over Future Enumeration Cases (미래의 '열거체 case 값' 에 대해 전환 (switching) 하기)]({% post_url 2020-08-20-Statements %}#switching-over-future-enumeration-cases-미래의-열거체-case-값에-대해-전환-switching-하기) 에서 논의한 것처럼, `default` 'case 절' 이 필수가 아닙니다. '동결된 열거체' 를 전환할 때 `default` 또는 `@unknown default` 'case 절' 를 포함하면 '경고' 를 일으키는데 왜냐면 해당 코드는 절대로 실행되지 않기 때문입니다.

#### GKInspectable (점검 가능한 GameplayKit 성분)

이 특성을 적용하면 사용자 지정 'GameplayKit' '성분 (component) 속성' 을 'SpriteKit' 편집기의 'UI' 로 내보입니다. 이 특성을 적용하는 것은 또한 `objc` 특성이기도 함을 의미합니다.

#### inlinable (인라인 가능한)

이 특성을 함수, 메소드, 계산 속성, 첨자 연산, 편의 초기자, 또는 정리자 (deinitializer) 선언에 적용하면 해당 선언의 구현을 모듈의 공용 인터페이스 부분으로 내보입니다. 컴파일러는 '인라인 가능한 기호 (inlinable symbol)' 에 대한 호출을 호출하는 쪽에서 기호 구현의 복사본으로 대체하도록 허용됩니다.

'인라인 가능한 코드' 는 어떤 모듈에서 선언한 `public` 기호와도 상호 작용할 수 있으며, `usableFromInline` 특성으로 표시한 경우 같은 모듈에서 선언한 `internal` 기호와도 상호 작용할 수 있습니다. '인라인 가능한 코드' 는 `private` 또는 `fileprivate` 기호와 상호 작용할 수 없습니다.

이 특성을 함수 내부에 중첩된 선언이나 `fileprivate` 또는 `private` 선언에는 적용할 수 없습니다. '인라인 가능한 함수' 내부에서 정의한 함수와 클로저는, 이 특성으로 표시할 수 없음에도 불구하고, 암시적으로 '인라인 가능한' 것이 됩니다.

#### main (메인)

이 특성을 구조체, 클래스, 또는 열거체 선언에 적용하면 이것이 프로그램 흐름에 대한 '최상위-수준 진입점 (top-level entry point)' 을 담고 있다는 것을 지시합니다. 이 타입은 반드시 어떤 인자도 취하지 않으며 `Void` 를 반환하는 `main` 이라는 타입 함수를 제공해야 합니다. 예를 들면 다음과 같습니다:

```swift
@main
struct MyTopLevel {
  static func main() {
    // 여기에 최상위-수준 코드를 둡니다.
  }
}
```

`main` 특성의 '필수 조건' 을 설명하는 또 다른 방식은 이 특성을 붙인 타입은 반드시 다음과 같은 '가상의 (hypothetical)' 프로토콜을 준수하고 있는 타입과 똑같은 필수 조건을 만족한다는 것입니다:

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

#### resultBuilder (결과 제작자)

클래스, 구조체, 열거체를 '결과 제작자' 로 사용하려면 해당 타입에 이 특성을 적용합니다. _결과 제작자 (result builder)_ 는 '중첩된 자료 구조' 를 한걸음씩 단계별로 제작하는 타입니다. '결과 제작자' 는 '중첩된 자료 구조' 를 자연스럽고, 선언적인 방식으로, 생성하기 위해 '분야에-특화된 언어 (domain-specific language; DSL)' 을 구현하고자 사용합니다. `resultBuilder` 특성을 사용하는 방법에 대한 예제는, [Result Builders (결과 제작자)]({% post_url 2020-05-11-Advanced-Operators %}#result-builders-결과-제작자) 를 참고하기 바랍니다.

**Result-Building Methods (결과-제작 메소드)**

'결과 제작자' 는 아래에서 설명할 '정적 (static) 메소드' 를 구현합니다. 결과 제작자의 모든 기능은 정적 메소드를 통하여 노출하기 때문에, 해당 타입의 인스턴스를 절대로 초기화하지 않습니다. `buildBlock(_:)` 메소드는 필수이며; DSL 에 추가적인 기능을 부여하는-다른 메소드들은 선택 사항입니다. 결과 제작자 타입의 선언은 실제로 어떤 프로토콜 준수성도 포함할 필요가 없습니다.

정적 메소드에 대한 설명은 세 개의 타입을 '자리 표시자 (placeholder)' 로 사용합니다. `Expression` 타입은 '결과 제작자' 의 입력 타입에 대한 자리 표시자이고, `Component` 는 부분적인 결과 타입에 대한 자리 표시자이며, `FinalResult` 는 '결과 제작자' 가 만들어 내는 결과 타입에 대한 자리 표시자입니다. 이 타입들은 결과 제작자가 사용하는 실제 타입으로 대체합니다. '결과-제작 메소드' 가 `Expression` 이나 `FinalResult` 에 대한 타입을 지정하지 않으면, 기본적으로 `Component` 과 똑같아 집니다.

'결과-제작 메소드' 들은 다음과 같습니다:

`static func buildBlock(_ components: Compnent...) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;부분적인 결과들의 배열을 단일 '부분 결과' 로 조합함. '결과 제작자' 는 이 메소드를 반드시 구현해야 함.

`static func buildOptional(_ component: Compnent?) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;`nil` 일 수 있는 부분적인 결과로부터 '부분 결과' 를 제작함. 이 메소드는 `else` 절을 포함하지 않은 `if` 문을 지원하기 위해 구현함.

`static func buildEither(first: Compnent) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;어떤 조건에 따라 값이 달라지는 '부분 결과' 를 제작함. 이 메소드와 `buildEither(second:)` 는 `else` 절을 포함하는 `switch` 문과 `if` 문을 지원하기 위해 함께 구현함.

`static func buildEither(second: Compnent) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;어떤 조건에 따라 값이 달라지는 '부분 결과' 를 제작함. 이 메소드와 `buildEither(first:)` 는 `else` 절을 포함하는 `switch` 문과 `if` 문을 지원하기 위해 함께 구현함.

`static func buildArray(_ components: [Compnent]) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;부분적인 결과들의 배열로부터 '부분 결과' 를 제작함. 이 메소드는 `for` 반복분을 지원하기 위해 구현함.

`static func buildExpression(_ expression: Expression) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;표현식으로부터 '부분 결과' 를 제작함. 이 메소드는 전처리-예를 들어, 표현식을 내부 타입으로 변환하는-과정을 수행하거나 사용자 측에 타입 추론에 대한 추가적인 정보를 제공하기 위해 구현할 수 있음.

`static func buildFinalResult(_ component: Compnent) -> FinalResult`

&nbsp;&nbsp;&nbsp;&nbsp;부분적인 결과로부터 '최총 결과' 를 제작함. 이 메소드는, 부분 결과와 최종 결과에서 서로 다른 타입을 사용하는 '결과 제작자' 에서, 또는 반환하기 전에 결과에 다른 후처리 과정을 수행하기 위해, 구현할 수 있음.

`static func buildLimitedAvailablility(_ component: Compnent) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;사용 가능성 검사를 수행하는 컴파일러-제어문 이외의 타입 정보를 전파하거나 지운 '부분 결과' 를 제작함. 이는 조건 분기 마다 달라지는 타입 정보를 지우기 위해 사용할 수 있음.

예를 들어, 아래 코드는 정수 배열을 제작하는 단순한 '결과 제작자' 를 정의합니다. 이 코드는, 아래 예제와 위 메소드 목록을 더 쉽게 일치하도록 하려고, `Component` 와 `Expression` 을 '타입 별명 (type aliases)' 으로 정의합니다.

```swift
@resultBuilder
struct ArrayBuilder {
  typealias Component = [Int]
  typealias Expression = Int
  static func buildExpression(_ element: Expression) -> Component {
    return [element]
  }
  static func buildOptional(_ component: Component?) -> Component {
    guard let component = component else { return [] }
    return component
  }
  static func buildEither(first component: Component) -> Component {
    return component
  }
  static func buildEither(second component: Component) -> Component {
    return component
  }
  static func buildArray(_ components: [Component]) -> Component {
    return Array(components.joined())
  }
  static func buildBlock(_ components: Component...) -> Component {
    return Array(components.joined())
  }
}
```

**Result Transformations (결과 변화)**

다음의 구문 변화들을 재귀적으로 적용하여 '결과-제작자' 구문을 사용한 코드를 '결과 제작자' 타입의 '정적 메소드' 를 호출하는 코드로 바꿉니다:

* '결과 제작자' 가 `buildExpression(_:)` 메소드를 가진 경우, 각 표현식은 해당 메소드에 대한 호출이 됩니다. 이 변화가 항상 첫 번째입니다. 예를 들어, 다음 선언은 서로 '동치 (equivalent)' 입니다:

```swift
@ArrayBuilder var builderNumber: [Int] { 10 }
var manualNumber = ArrayBuilder.buildExpression(10)
```

* 할당문은 표현식과 같이 변화하지만, `()` 를 평가하는 것으로 이해합니다. 할당을 특별하게 처리하기 위해 `()` 타입의 인자를 취하는 `buildExpression(_:)` 을 '중복 정의 (overload)' 할 수 있습니다.

* 사용 가능성 조건을 검사하는 분기문은 `buildLimitedAvailablility(_:)` 메소드에 대한 호출이 됩니다. 이 변화는 `buildEither(first:)`, `buildEither(second:)`, 및 `buildOptional(_:)` 호출로의 변화 전에 발생합니다. `buildLimitedAvailablility(_:)` 메소드는 어느 분기를 취하는 지에 따라 바뀌는 타입 정보를 지우기 위해 사용합니다. 예를 들어, 아래의 `buildEither(first:)` 와 `buildEither(second:)` 메소드는 두 분기 모두에 대한 타입 정보를 붙잡는 '일반화 (generic) 타입' 을 사용합니다.

```swift
protocol Drawable {
  func draw() -> String
}
struct Text: Drawable {
  var content: String
  init(_ content: String) { self.content = content }
  func draw() -> String { return content }
}
struct Line<D: Drawable>: Drawable {
  var elements: [D]
  func draw() -> String {
    return elements.map { $0.draw() }.joined(separator: "")
  }
}
struct DrawEither<First: Drawable, Second: Drawable>: Drawable {
  var content: Drawable
  func draw() -> String { return content.draw() }
}

@resultBuilder
struct DrawingBuilder {
  static func buildBlock<D: Drawable>(_ components: D...) -> Line<D> {
    return Line(elements: components)
  }
  static func buildEither<First, Second>(first: First) -> DrawEither<First, Second> {
    return DrawEither(content: first)
  }
  static func buildEither<First, Second>(second: Second) -> DrawEither<First, Second> {
    return DrawEither(content: second)
  }
}
```

하지만, 이 접근 방식은 사용 가능성 검사를 가진 코드에서 문제를 유발합니다:

```swift
@available(macOS 99, *)
struct FutureText: Drawable {
  var content: String
  init(_ content: String) { self.content = content }
  func draw() -> String { return content }
}
@DrawingBuilder var brokenDrawing: Drawable {
  if #available(macOS 99, *) {
    FutureText("Inside.future")  // 문제
  } else {
    Text("Inside.present")
  }
}
// brokenDrawing 의 타입은 Line<DrawEither<Line<FutureText>, Line<Text>>> 입니다.
```

위 코드에서는, `brokenDrawing` 타입에 `FutureText` 가 있는데 이것이 `DrawEither` 라는 '일반화 (generic) 타입' 에 있는 타입이기 때문입니다. 이는 `FutureText` 가 실행 시간에 사용 가능하지 않은 경우, 해당 타입이 명시적으로는 사용하지 않는 상태인 경우이더라도, 프로그램의 충돌을 일으킬 수 있습니다.

이 문제를 풀려면, 타입 정보를 지우는 `buildLimitedAvailability(_:)` 메소드를 구현합니다. 예를 들어, 아래 코드는 사용 가능성 검사에서 `AnyDrawable` 값을 제작합니다.

```swift
struct AnyDrawable: Drawable {
  var content: Drawable
  func draw() -> String { return content.draw() }
}
extension DrawingBuilder {
  static func buildLimitedAvailability(_ content: Drawable) -> AnyDrawable {
    return AnyDrawable(content: content)
  }
}

@DrawingBuilder var typeErasedDrawing: Drawable {
  if #available(macOS 99, *) {
    FutureText("Inside.future")
  } else {
    Text("Inside.present")
  }
}
// typeErasedDrawing 의 타입은 Line<DrawEither<AnyDrawable, Line<Text>>> 입니다.
```

* 분기문은 `buildEither(first:)` 와 `buildEither(second:)` 메소드에 대한 '연속된 중첩 호출' 이 됩니다. 구문의 조건과 'case 값' 은 '이진 (binary) 트리' 의 '잎 (leaf) 노드' 에 대응되며, 구문은 '근원 (root) 노드' 에서 해당 '잎 노드' 로의 경로를 따르는 `buildEither` 메소드의 '중첩 호출' 이 됩니다.

예를 들어, 세 개의 'case 절' 을 가진 'switch 문' 을 작성한 경우, 컴파일러는 '잎 노드' 가 세 개인 '이진 트리' 를 사용합니다. 마찬가지로, '근원 노드' 에서 '두 번째 case 절' 로의 경로가 "두 번째 자식" 다음에 "첫 번째 자식" 이기 때문에, 해당 'case 절' 은 `buildEither(first: buildEither(second: ...))` 같은 '중첩 호출' 이 됩니다. 다음 선언은 서로 '동치' 입니다:  

```swift
let someNumber = 19
@ArrayBuilder var builderConditional: [Int] {
  if someNumber < 12 {
    31
  } else if someNumber == 19 {
    32
  } else {
    33
  }
}

var manualConditional: [Int]
if someNumber < 12 {
  let partialResult = ArrayBuilder.buildExpression(31)
  let outerPartialResult = ArrayBuilder.buildEither(first: partialResult)
  manualConditional = ArrayBuilder.buildEither(first: outerPartialResult)
} else if someNumber == 19 {
  let partialResult = ArrayBuilder.buildExpression(32)
  let outerPartialResult = ArrayBuilder.buildEither(second: partialResult)
  manualConditional = ArrayBuilder.buildEither(first: outerPartialResult)
} else {
  let partialResult = ArrayBuilder.buildExpression(33)
  manualConditional = ArrayBuilder.buildEither(second: partialResult)
}
```

* '`else` 절' 이 없는 `if` 문 같이, 값을 만들지 않을 수도 있는 분기문은, `buildOptional(_:)` 에 대한 호출이 됩니다. `if` 문의 조건을 만족하면, 코드 블럭을 변화하여 인자로 전달하며; 그 외 경우, `nil` 인 인자를 가지고 `buildOptional(_:)` 을 호출합니다. 예를 들어, 다음 선언은 서로 '동치' 입니다:

```swift
@ArrayBuilder var builderOptional: [Int] {
  if (someNumber % 2) == 1 { 20 }
}

var partialResult: [Int]? = nil
if (someNumber % 2) == 1 {
  partialResult = ArrayBuilder.buildExpression(20)
}
var manualOptional = ArrayBuilder.buildOptional(partialResult)
```

* 코드 블럭이나 `do` 문은 `buildBlock(_:)` 메소드에 대한 호출이 됩니다. 블럭 안에 있는 각 구문들은, 한번에 하나씩, 변하여 `buildBlock(_:)` 메소드의 인자가 됩니다. 예를 들어, 다음 선언은 서로 '동치' 입니다:

```swift
@ArrayBuilder var builderBlock: [Int] {
  100
  200
  300
}

var manualBlock = ArrayBuilder.buildBlock(
  ArrayBuilder.buildExpression(100),
  ArrayBuilder.buildExpression(200),
  ArrayBuilder.buildExpression(300)
)
```

* `for` 반복문은 임시 변수와, `for` 반복문, 그리고 `buildArray(_:)` 메소드에 대한 호출이 됩니다.[^temporary-variable] 새 `for` 반복문은 '일련 값 (sequence)' 에 동작을 반복하여 각 '부분 결과' 를 해당 배열에 덧붙입니다. 임시 배열은 `buildArray(_:)` 호출의 인자로 전달됩니다. 예를 들어, 다음 선언은 서로 '동치' 입니다:

```swift
@ArrayBuilder var builderArray: [Int] {
  for i in 5...7 {
    100 + i
  }
}

var temporary: [[Int]] = []
for i in 5...7 {
  let partialResult = ArrayBuilder.buildExpression(100 + i)
  temporary.append(partialResult)
}
let manualArray = ArrayBuilder.buildArray(temporary)
```

* '결과 제작자' 가 `buildFinalResult(_:)` 메소드를 가지고 있는 경우, '최종 결과' 는 해당 메소드에 대한 호출이 됩니다. 이 변화가 항상 마지막입니다.

변화의 작동 방식을 '임시 변수' 로 설명하고 있을지라도, 결과 제작자를 사용하는 것이 코드 나머지에서 눈에 보이는 새로운 어떤 선언을 실제로 생성하는 것은 아닙니다.

'결과 제작자' 가 변화할 코드에 `break`, `continue`, `defer`, `guard`, 나 `return` 문, `while` 문, 또는 `do`-`catch` 문을 사용할 수는 없습니다.

'변화 과정 (transformation process)' 은, 표현식을 한 조각씩 제작하기 위해 임시 상수와 변수를 사용하도록 하는, 코드 내의 선언을 바꾸지 않습니다. 이는 또 `throw` 문, '컴파일-시간 진단문', 또는 `return` 문을 담고 있는 클로저를 바꾸지 않습니다.

가능할 때마다, 변화는 통합됩니다. 예를 들어, 표현식 `4 + 5 * 6` 은 해당 함수를 여러 번 호출하는 대신 `buildExpression(4 + 5 * 6)` 가 됩니다. 마찬가지로, 중첩된 분기문은 `buildEither` 메소드를 호출하는 단일 이진 트리가 됩니다.

**Custom Result-Builder Attributes (사용자 정의 결과-제작자 특성)**

결과 제작자 타입을 생성하면 똑같은 이름을 가진 사용자 정의 특성을 생성합니다. 해당 특성을 다음 위치에 적용할 수 있습니다:

* 결과 제작자가 함수의 본문을 제작하도록, 함수 선언에
* 결과 제작자가 획득자의 본문을 제작하도록, 획득자를 포함하고 있는 변수나 첨자 연산 선언에
* 결과 제작자가 관련된 인자로 전달된 클로저의 본문을 제작하도록, 함수 선언의 매개 변수에

결과 제작자 특성을 적용하는 것은 'ABI 호환성' 에 영향을 주지 않습니다. 결과 제작자 특성을 매개 변수에 적용하는 것은 해당 특성을, 소스 호환성에 영향을 줄 수 있는, 함수 인터페이스가 되도록 만듭니다.

#### requires_stored_property_inits (저장 속성의 초기화를 필수로 요구함)

이 특성을 클래스 선언에 적용하면 클래스 내에 있는 모든 저장 속성이 정의 시에 필수로 '기본 값 (default value)' 을 제공할 것을 요구합니다. 이 특성은 `NSManagedObject` 로부터 상속받은 클래스는 어떤 것에든 적용됩니다.[^infer]

#### testable (테스트 가능한)

이 특성을 `import` 선언에 적용하면 해당 모듈을 불러올 때 이 모듈 코드의 테스트를 단순화하도록 접근 제어를 바꿉니다. 불러오는 모듈에서 `internal` 접근-수준 수정자로 표시된 '개체 (entities)' 들은 마치 `public` 접근-수준 수정자로 선언한 것처럼 불러옵니다. `internal` 또는 `public` 접근-수준 수정자로 표시한 클래스와 클래스 멤버는 마치 `open` 접근-수준 수정자로 선언한 것처럼 불러옵니다. 불러온 모듈은 반드시 테스트를 할 수 있게한 상태에서 컴파일해야 합니다.

#### UIApplicationMain (UI 앱 메인)

이 특성을 클래스에 적용하면 이것이 '응용 프로그램 대리자 (application delegate)' 임을 지시합니다. 이 특성을 사용하는 것은 `UIApplicationMain` 함수를 호출하고 이 클래스 이름을 '대리자 클래스 (delegate)' 이름으로 전달하는 것과 '동치 (equivalent)' 입니다.

이 특성을 사용하지 않는 경우, [UIApplicationMain(_:_:_:_:)](https://developer.apple.com/documentation/uikit/1622933-uiapplicationmain) 함수를 호출하는 최상위 수준의 코드를 가진 `main.swift` 파일을 제공하도록 합니다. 예를 들어, 앱에서 사용자가 정의한 `UIApplication` 의 하위 클래스를 '주 클래스 (principal class)' 로 사용할 경우, 이 특성을 사용하는 대신 `UIApplicationMain(_:_:_:_:)` 함수를 호출하도록 합니다.

실행 파일을 만들려고 컴파일하는 스위프트 코드는, [Top-Level Code (최상위-수준 코드)]({% post_url 2020-08-15-Declarations %}#top-level-code-최상위-수준-코드) 에서 설명한 것처럼, '최상위-수준 진입점' 을 최대 한 개만 가질 수 있습니다.

#### usableFromInline (인라인에서 사용 가능한)

이 특성을 함수, 메소드, 계산 속성, 첨자 연산, 초기자, 또는 '정리자 (deinitilaizer)' 선언에 적용하면 그 선언과 같은 모듈에서 정의한 인라인 가능한 코드에서 해당 기호를 사용하는 것을 허용합니다. 그 선언은 반드시 `internal` 접근 수준 수정자를 가져야 합니다. `usableFromInline` 으로 표시한 구조체나 클래스는 그 속성들이 '공용 (public)' 또는 `usableFromInline` 인 타입만 사용할 수 있습니다. `usableFromInline` 으로 표시한 열거체는 그 'case 값' 의 '원시 값' 과 '결합 값' 이 '공용 (public)' 또는 `usableFromInline` 인 타입만 사용할 수 있습니다.

`public` 접근 수준 수정자와 마찬가지로, 이 특성은 선언을 모듈의 '공개 인터페이스 (public interface)' 로 노출합니다. `public` 과는 달리, 컴파일러는 `usableFromInline` 으로 표시한 선언이, 그 선언의 기호를 밖으로 내보내더라도, 모듈 외부의 코드에서 이름으로 참조하는 것을 허용하지 않습니다. 하지만, 모듈 외부의 코드는 '실행 시간 동작 (runtime behavior)' 를 사용함으로써 여전히 그 선언의 기호와 상호 작용할 수도 있습니다.

`inlinable` 특성으로 표시한 선언은 암시적으로 '인라인 가능한 코드 (inlinable code)' 에서 사용 가능합니다. `inlinable` 또는 `usableFromInline` 은 각각 `internal` 선언에 적용할 수 있다하더라도, 두 특성을 모두 적용하는 것은 에러입니다.

#### warn_unqualified_access (조건을 갖추치 않은 접근 경고하기)

이 특성을 최상위-수준 함수, 인스턴스 메소드, 또는 클래스 메소드나 정적 메소드에 적용하면 해당 함수나 메소드가 모듈 이름, 타입 이름, 또는 인스턴스 변수나 인스턴스 상수 같은, '선행 자격자 (preceding qualifier)' 없이 사용할 때 경고를 일으킵니다. 이 특성을 사용하면 같은 이름을 가진 함수가 동일한 영역에서 접근 가능할 때의 모호함을 방지할 수 있습니다.

예를 들어, 스위프트 표준 라이브러리는 최상위-수준의 `min(_:_:)` 함수와 비교 가능한 원소를 가지는 '시퀀스 (sequence; 수열)' 에 대한 `min()` 메소드 둘 다를 포함하고 있습니다. 이 '시퀀스' 메소드는 `warn_unqualified_access` 특성으로 선언하여 `Sequence` '익스텐션' 내에서 둘 중 하나를 사용하려고 할 때의 혼동을 줄이도록 해줍니다.

#### Declaration Attributes Used by Interface Builder (인터페이스 빌더가 사용하는 선언 특성)

'인터페이스 빌더 (interface builder)' 특성은 '엑스코드 (Xcode)' 와 동기화하기 위해 '인터페이스 빌더' 에서 사용하는 '선언 특성' 입니다. 스위프트는 다음의 '인터페이스 빌더' 특성을 제공합니다: `IBAction`, `IBSegueAction`, `IBOutlet`, `IBDesignable`, 그리고 `IBInspectable`. 이 특성들의 개념은 오브젝티브-C 에서의 대응되는 것들과 같습니다.

`IBOutlet` 과 `IBInspectable` 특성은 클래스의 속성 선언에 적용합니다. `IBAction` 과 `IBSegueAction` 특성은 클래스의 메소드 선언에 적용하고 `IBDesignable` 특성은 클래스 선언에 적용합니다.

`IBAction`, `IBSegueAction`, `IBOutlet`, `IBDesignable`, 및 `IBInspectable` 특성을 적용하는 것은 또한 `objc` 특성이기도 함을 의미합니다.

### Type Attributes (타입 특성)

'타입 특성' 은 타입에만 적용할 수 있습니다.

#### autoclosure (자동 클로저; 자동 잠금 블럭)

이 특성을 적용하면 해당 표현식을 인자가 없는 클로저 안에 자동으로 포장함으로써 표현식의 평가를 늦춥니다. 이는 메소드 선언 또는 함수 선언에 있는 매개 변수 타입 중에서, 그 매개 변수의 타입이 인자를 받지 않고 표현식 타입의 값을 반환하는 함수 타입에 대하여, 적용합니다. `autoclosure` 특성을 사용하는 방법에 대한 예제는, [Autoclosures (자동 클로저)]({% post_url 2020-03-03-Closures %}#autoclosures-자동-클로저) 와 [Function Type (함수 타입)]({% post_url 2020-02-20-Types %}#function-type-함수-타입) 을 참고하기 바랍니다.

#### convention (협약)

이 특성을 함수의 타입에 적용하면 그것의 '호출 협약 (calling conventions)' 을 지시합니다.[^calling-convention]

`convention` 특성은 항상 다음의 인자 중 하나와 함께 나타냅니다:

* '스위프트 함수 참조 (swift function reference)' 를 지시하는 `swift` 인자. 이는 스위프트에 있는 함수 값에 대한 '표준 호출 협약 (standard calling convention)' 입니다.
* '오브젝티브-C 와 호환 가능한 블럭 참조' 를 지시하는 `block` 인자. 함수 값은, 그 안에 '발동 함수 (invocation function)' 를 갖고 있는 객체이자 '`id`-호환 가능한' 오브젝티브-C 객체인, 블럭 객체에 대한 참조로써 표현됩니다. '발동 함수' 는 'C 호출 협약 (C calling convention)' 을 사용합니다.
* 'C 함수 참조' 를 지시하는 `c` 인자. 함수 값은 아무런 '컨텍스트 (context)' 도 옮기지 않으며 'C 호출 협약' 을 사용합니다.

몇 가지 예외를 제외한다면, 어떤 '호출 협약' 의 함수든 다른 '호출 협약' 이 필요한 곳에서 사용할 수도 있습니다. '제네릭이 아닌 전역 함수 (nongeneric global function)', 어떤 지역 변수도 '붙잡지 (capture)' 않는 지역 함수 및 어떤 지역 변수도 '붙잡지' 않는 클로저는 'C 호출 협약' 으로 '변환 (converted)' 할 수 있습니다. 다른 스위프트 함수는 'C 호출 협약' 으로 변환할 수 없습니다. '오브젝티브-C 블럭 호출 협약' 을 가지는 함수는 'C 호출 협약' 으로 변환 할 수 없습니다.

#### escaping (벗어나는)

이 특성을 메소드 선언 또는 함수 선언에 있는 매개 변수의 타입에 적용하면 더 나중에 실행하기 위해 그 매개 변수의 값을 저장할 수 있음을 지시합니다. 이는 그 값이 호출의 수명보다 더 오래 살도록 허용한다는 것을 의미합니다. `escaping` 타입 특성을 가지는 함수 타입 매개 변수는 속성 또는 메소드에 대해 `self.` 를 명시적으로 사용하는 것이 필수입니다. `escaping` 특성을 사용하는 방법에 대한 예제는, [Escaping Closures (벗어나는 클로저)]({% post_url 2020-03-03-Closures %}#escaping-closures-벗어나는-클로저) 를 참고하기 바랍니다.

### Switch Case Attributes ('switch 문의 case 절' 특성)

'switch 문 case 절' 특성은 'switch 문의 case 절' 에만 적용할 수 있습니다.

#### unknown (알려지지 않은)

이 특성을 'switch 문의 case 절' 에 적용하면 이것이 코드를 컴파일하는 시점에 알려진 열거체의 어떤 'case 값' 과도 일치하지 않을 것으로 예상된다는 것을 지시합니다. `unknown` 특성을 사용하는 방법에 대한 예제는, [Switching Over Future Enumeration Cases (미래의 '열거체 case 값' 에 대해 전환 (switching) 하기)]({% post_url 2020-08-20-Statements %}#switching-over-future-enumeration-cases-미래의-열거체-case-값에-대해-전환-switching-하기) 를 참고하기 바랍니다.

> GRAMMAR OF AN ATTRIBUTE 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html#ID604)

### 참고 자료

[^Attributes]: 원문은 [Attributes](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^associated-entity-description]: '결합된 개체 설명 (associated entity description)' 은 '엑스코드 (Xcode)' 의 `*.xcdatamodeld` 파일에서 만드는 '데이터베이스 스키마 (database schema)' 를 의미합니다. 여기서 '개체 (entity; 엔티티)' 는 다른 '데이터베이스 언어' 의 '테이블 (table)' 에 해당합니다.

[^objc]: 원문 자체에서 `objc` 라고 되어 있는데, `objcMembers` 를 잘못 적은 것이 아닐까 추측됩니다.

[^infer]: 원문에서는 '추론된다 (inferred)' 고 되어 있는데, '암시적으로 적용된다 (imply)' 는 의미로 사용된 것으로 추측됩니다.

[^calling-convention]: 스위프트의 '호출 협약 (calling conventions)' 에 대한 더 자세한 정보는 '깃허브 (GitHub)' 의 '애플 (Apple)' 저장소에 있는 [The Swift Calling Convention](https://github.com/apple/swift/blob/main/docs/ABI/CallingConvention.rst) 문서를 참고하기 바랍니다.

[^temporary-variable]: 이 세 개 중에서 '임시 변수' 는, 바로 이어서 설명하는 것처럼, '배열' 입니다.
