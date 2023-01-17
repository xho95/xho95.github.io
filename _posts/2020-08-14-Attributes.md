---
layout: post
pagination: 
  enabled: true
comments: true
title:  "Swift 5.7: Attributes (특성)"
date:   2020-08-14 11:30:00 +0900
categories: Swift Language Grammar Attribute
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [Attributes](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html) 부분[^Attributes]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Attributes (특성)

스위프트에는 두 가지 종류의 특성 (attributes) 이 있는데-선언에 적용하는 것과 타입에 적용하는 것이 그것입니다. 특성은 선언이나 타입에 대한 추가 정보를 제공합니다. 예를 들어, 함수 선언이 `discardableResult` 특성이면, 함수는 값을 반환하지만, 반환 값을 사용하지 않는다고 컴파일러가 경고를 생성하지는 않는게 좋다는 걸 지시합니다.

특성을 지정하려면 `@` 기호 뒤예 특성 이름과 특성이 받아들이는 어떤 인자를 작성하면 됩니다:

&nbsp;&nbsp;&nbsp;&nbsp;@`attribute name-특성 이름`<br />
&nbsp;&nbsp;&nbsp;&nbsp;@`attribute name-특성 이름`(`attribute argument-특성 인자`)

일부 선언 특성은 더 많은 특성 정보와 특별한 한 선언으로의 적용법을 지정하는 인자를 받습니다. 이러한 _특성 인자 (attribute arguments)_ 는 괄호를 치고, 자신이 속한 특성에서 양식을 정의합니다.

### Declaration Attributes (선언 특성)

선언 특성은 선언에만 적용할 수 있습니다.

#### available (사용 가능)

이 특성을 적용하면 특정 스위프트 언어 버전이나 특정 플랫폼 및 운영 체제 버전에 따라 상대적인 선언의 생명 주기[^life-cycle] 를 지시합니다.

`available` 특성은 항상 쉼표로 구분한 둘 이상의 특성 인자 목록과 함께 나타납니다. 이러한 인자는 다음의 플랫폼이나 언어 이름 중 하나로 시작합니다:

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

별표 (`*`) 를 사용하야 위에 나열한 모든 플랫폼 이름에 대한 선언의 사용 가능성 (availability) 을 지시할 수도 있습니다. 스위프트 버전 번호로 사용 가능성을 지시한 `available` 특성엔 별표를 사용할 수 없습니다.

나머지 인자는 어떤 순서로든 나타날 수 있으며 선언 생명 주기에 대한 추가 정보를 지정할 수 있는데, 이는 중요한 이정표 (milestones) 를 포함합니다.

* `unavailable` 인자는 지정한 플랫폼에선 선언의 사용이 불가능하다는 걸 지시합니다. 스위프트 버전 사용 가능성을 지정할 땐 이 인자를 사용할 수 없습니다.

* `introduced` 인자는 지정한 플랫폼이나 언어 버전이 선언을 도입한 첫번째 버전이라는 걸 지시합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;introduce: `version number-버전 번호`

&nbsp;&nbsp;&nbsp;&nbsp;_버전 번호 (version number)_ 는, 1개에서 3개까지의 양수를, 마침표로 구분하여, 구성합니다.

* `deprecated` 인자는 지정한 플랫폼이나 언어 버전이 선언을 폐기할 예정인[^deprecated] 첫 번째 버전이라는 걸 지시합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;deprecated: `version number-버전 번호`

&nbsp;&nbsp;&nbsp;&nbsp;옵션인 _버전 번호 (version number)_ 는, 1개에서 3개까지의 양수를, 마침표로 구분하여, 구성합니다. 버전 번호를 생략하면, 언제 폐기가 일어나는지에 대해선 어떤 정보도 주지 않고, 현재부터 선언이 폐기 예정이라는 걸 지시합니다. 버전 번호를 생략한다면, 콜론 (`:`) 마저 생략합니다.

* `obsoleted` 인자는 지정한 플랫폼이나 언어 버전이 선언을 폐기한[^obsoleted] 첫 번째 버전이라는 걸 지시합니다. 폐기한 선언일 땐, 지정한 플랫폼이나 언어에서 제거하여 더 이상 사용할 수 없습니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;obsoleted: `version number-버전 번호`

&nbsp;&nbsp;&nbsp;&nbsp;_버전 번호 (version number)_ 는, 1개에서 3개까지의 양수를, 마침표로 구분하여, 구성합니다.

* `message` 인자는 폐기 예정이거나 폐기한 선언의 사용에 대한 경고 또는 에러를 내보낼 때 컴파일러가 보여줄 메시지 글을 제공합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;message: `message-메시지`

&nbsp;&nbsp;&nbsp;&nbsp;_메시지 (message)_ 는 문자열 글자 값으로 구성합니다.

* `renamed` 인자는 이름을 바꾼 선언의 새 이름을 지시하는 메시지 글을 제공합니다. 컴파일러는 이름 바꾼 선언의 사용에 대한 에러를 내보낼 때 새 이름을 보여줍니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;renamed: `new name-새로운 이름`

&nbsp;&nbsp;&nbsp;&nbsp;_새로운 이름 (new name)_ 은 문자열 글자 값으로 구성합니다.

&nbsp;&nbsp;&nbsp;&nbsp;밑에서 보는 것처럼, `rename` 과 `unavailable` 인자가 있는 `available` 특성을 타입 별명 선언에 적용하면, 프레임웍이나 라이브러리 발매 사이에 바뀐 선언의 이름을 지시할 수 있습니다. 이 조합은 선언의 이름이 바뀌었다는 컴파일 시간 에러가 됩니다.

  ```swift
  // 첫 번재 발매
  protocol MyProtocol {
    // 프로토콜 정의
  }

  // 후속 발매 시에 MyProtocol 이름을 바꿈
  protocol MyRenamedProtocol {
    // 프로토콜 정의
  }

  @available(*, unavailable, renamed: "MyRenamedProtocol")
  typealias MyProtocol = MyRenamedProtocol
  ```

단일 선언에 여러 개의 `available` 특성을 적용하여 서로 다른 플랫폼과 서로 다른 스위프트 버전에 대한 선언 사용 가능성을 지정할 수 있습니다. 특성이 지정한 플랫폼이나 언어 버전이 현재 대상과 일치하지 않으면 `available` 특성을 적용한 선언을 무시합니다. 여러 개의 `available` 특성을 사용하면, 효과적인 사용 가능성은 플랫폼과 스위프트 사용 가능성을 조합한 것입니다.[^effective]

`available` 특성이 플랫폼이나 언어 이름 인자 외엔 `introduced` 인자만 지정한다면, 다음의 짧게 줄인 구문을 대신 사용할 수 있습니다:

&nbsp;&nbsp;&nbsp;&nbsp;\@available(`platform name-플랫폼 이름` `version number-버전 번호`, *)<br />
&nbsp;&nbsp;&nbsp;&nbsp;\@available(swift `version number-버전 번호`)

`available` 특성의 짧게 줄인 구문은 여러 플랫폼의 사용 가능성을 간결하게 표현합니다. 두 형식의 기능이 같긴 하지만, 가능할 때마다 짧게 줄인 형식을 쓰는게 더 좋습니다.

```swift
@available(iOS 10.0, macOS 10.12, *)
class MyClass {
  // 클래스 정의
}
```

스위프트 버전 번호를 써서 사용 가능성을 지정한 `available` 특성은 선언의 플랫폼 사용 가능성을 추가로 지정할 수 없습니다. 그 대신, 별도의 `available` 특성으로 스위프트 버전 사용 가능성과 하나 이상의 플랫폼 사용 가능성을 지정합니다.[^seperate]

```swift
@available(swift 3.0.2)
@available(macOS 10.12, *)
struct MyStruct {
  // 구조체 정의
}
```

#### discardableResult (버려도 되는 결과)

이 특성을 함수나 메소드 선언에 적용하면 값을 반환하는 함수나 메소드를 호출하고 결과를 사용하지 않을 때의 컴파일러 경고를 억누릅니다.

#### dynamicCallable (동적으로 호출 가능)

이 특성을 클래스나, 구조체, 열거체, 또는 프로토콜에 적용하면 그 타입의 인스턴스를 호출 가능한 함수로 취급합니다.[^dynamic-callable] 타입은 반드시 `dynamicallyCall(withArguments:)` 메소드나, `dynamicallyCall(withKeywordArguments:)` 메소드, 또는 둘 다를 구현해야 합니다.

동적으로 호출 가능한 타입의 인스턴스은 마치 어떤 개수의 인자든 취하는 함수인 것처럼 호출할 수 있습니다.

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
// "Get Swift help on forums.swift.org" 를 인쇄함

dial(8, 6, 7, 5, 3, 0, 9)
// "Unrecognized number" 를 인쇄함

// 실제 메소드를 직접 호출합니다.
dial.dynamicallyCall(withArguments: [4, 1, 1])
```

`dynamicallyCall(withArguments:)` 메소드 선언은 반드시 [ExpressibleByArrayLiteral](https://developer.apple.com/documentation/swift/expressiblebyarrayliteral) 프로토콜을 준수한 단일 매개 변수-위 예제의 `[Int]` 같은 거-를 가져야 합니다. 반환 타입은 어떤 타입이든 됩니다.

`dynamicallyCall(withKeywordArguments:)` 메소드를 구현한다면 동적 메소드 호출에 이름표를 포함시킬 수 있습니다.

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

`dynamicallyCall(withKeywordArguments:)` 메소드 선언엔 반드시 [ExpressibleByDictionaryLiteral](https://developer.apple.com/documentation/swift/expressiblebydictionaryliteral) 프로토콜을 준수한 단일 매개 변수가 있어야 하며, 반환 타입은 어떤 타입이든 됩니다. 매개 변수의 [Key](https://developer.apple.com/documentation/swift/expressiblebydictionaryliteral/2294108-key) 는 반드시 [ExpressibleByStringLiteral](https://developer.apple.com/documentation/swift/expressiblebystringliteral) 이어야 합니다. 이전 예제는 [KeyValuePairs](https://developer.apple.com/documentation/swift/keyvaluepairs) 를 매개 변수 타입으로 사용해서 호출한 쪽이 매개 변수 이름표를 중복으로 포함할 수 있습니다-`repeat` 호출에 `a` 와 `b` 가 여러 번 나타납니다.

`dynamicallyCall` 메소드를 둘 다 구현하면, 메소드 호출에 키워드 인자를 포함할 때 `dynamicallyCall(withKeywordArguments:)` 를 호출합니다. 다른 모든 경우엔, `dynamicallyCall(withArguments:)` 를 호출합니다.

인자와 반환 값 타입이 `dynamicallyCall` 메소드 구현에서 지정한 것과 일치한 동적 호출 가능 인스턴스만 호출할 수 있습니다. 다음 예제 호출은 컴파일이 안되는데 `KeyValuePairs<String, String>` 을 취하는 `dynamicallyCall(withArguments:)` 구현이 없기 때문입니다.

```swift
repeatLabels(a: "four") // 에러
```

#### dynamicMemberLookup (동적으로 멤버 찾아보기)

이 특성을 클래스나, 구조체, 열거체, 또는 프로토콜에 적용하면 멤버를 실행 시간에 이름으로 찾아볼 수 있게 합니다. 타입은 반드시 `subscript(dynamicMemberLookup:)` 첨자를 구현해야 합니다.

명시적 멤버 표현식에서, 이름 있는 멤버에 해당하는 선언이 없으면, 표현식이 타입의 `subscript(dynamicMemberLookup:)` 첨자로의 호출이라고 이해하며, 멤버에 대한 정보를 인자로 전달합니다. 첨자는 키 경로나 멤버 이름인 매개 변수를 받아들일 수 있으며; 두 첨자를 모두 구현하면, 키 경로 인자를 가진 첨자를 사용합니다.

`subscript(dynamicMemberLookup:)` 구현은 [KeyPath](https://developer.apple.com/documentation/swift/keypath) 나, [WritableKeyPath](https://developer.apple.com/documentation/swift/writablekeypath), 또는 [ReferenceWritableKeyPath](https://developer.apple.com/documentation/swift/referencewritablekeypath) 타입의 인자를 사용한 키 경로를 받아들일 수 있습니다. [ExpressibleByStringLiteral](https://developer.apple.com/documentation/swift/expressiblebystringliteral) 프로토콜을 준수하는 타입의 인자를 사용한 멤버 이름도 받아들일 수 있는데-대부분의 경우, `String` 입니다. 첨자의 반환 타입은 어떤 타입이든 됩니다.

멤버 이름을 써서 동적으로 멤버 찾아보기는, 다른 언어로 된 데이터를 스위프트로 연동할 때 같이, 컴파일 시간에 타입 검사를 할 수 없는 데이터의 포장 타입을 생성하는데 사용할 수 있습니다. [^dynamic-member-lookup] 예를 들면 다음과 같습니다:

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

// 동적으로 멤버 찾아보기를 사용합니다.
let dynamic = s.someDynamicMember
print(dynamic)
// "325" 를 인쇄함

// 실제 첨자를 직접 호출합니다.
let equivalent = s[dynamicMember: "someDynamicMember"]
print(dynamic == equivalent)
// "true" 를 인쇄함
```

키 경로를 써서 동적으로 멤버 찾아보기는 컴파일-시간 타입 검사를 지원하는 방식의 포장 타입을 구현하는데 사용할 수 있습니다. 예를 들면 다음과 같습니다:

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

#### frozen (동결; 얼림)

이 특성을 구조체나 열거체 선언에 적용하면 타입에 가할 수 있는 변화의 종류를 제약합니다. 이 특성은 라이브러리 진화 모드[^library-evolution-mode] 로 컴파일할 때만 허용합니다. 미래 버전의 라이브러리가 열거체 case 나 구조체의 저장 인스턴스 속성을 추가, 삭제, 또는 재배치하는 걸로 선언을 바꿀 수 없습니다. 동결 아닌 (nonfrozen) 타입은 이러한 변화를 허용하지만, 동결 (frozen) 타입이 이러면 ABI 호환성[^ABI-compatibility] 을 깨뜨립니다.

> 컴파일러가 라이브러리 진화 모드가 아닐 땐, 모든 구조체 및 열거체가 암시적 동결이라, 이 특성을 무시합니다.

라이브러리 진화 모드에서, 동결 아닌 구조체 및 열거체 멤버와 상호 작용하는 코드는 미래 버전의 라이브러리가 그 타입의 일부 멤버를 추가, 삭제, 또는 재배치하더라도 재-컴파일 없이 작업을 계속 허용하는 방식으로 컴파일합니다. 컴파일러는 실행 시간에 정보 찾아보기 및 간접 계층 추가하기 같은 기술을 써서 이를 가능하게 합니다. 구조체나 열거체를 동결로 만드는 건 이런 유연함을 포기하면서 성능을 얻는 것인데: 미래 버전의 라이브러리가 타입을 바꾸는 데는 제한이 있지만, 타입 멤버와 상호 작용하는 코드를 컴파일러가 추가로 최적화할 수 있습니다.

동결 타입과, 동결 구조체의 저장 속성 타입, 및 동결 열거체 case 의 결합 값은 반드시 공용 (public) 이거나 '`usableFromInline` 특성을 표시해야 합니다. 동결 구조체의 속성엔 속성 관찰자가 있을 수 없으며, 저장 인스턴스 속성에 초기 값을 제공하는 표현식은, [inlinable (인라인 가능)](#inlinable-인라인-가능) 에서 논의한 것처럼, 반드시 인라인 가능 함수와 똑같은 제약 사항을 따라야 합니다.

명령 줄[^command-line] 에서 라이브러리 진화 모드를 켜려면, `-enable-library-evolution` 옵션을 스위프트 컴파일러로 전달합니다. 엑스코드에서 켜려면, [Xcode Help](https://help.apple.com/xcode/mac/current/#/dev04b3a04ba) 에서 설명한, "배포용 라이브러리 제작 (`BUILD_LIBRARY_FOR_DISTRIBUTION`)" 배포 설정을 예 (Yes) 로 설정합니다.

[Switching Over Future Enumeration Cases (미래의 열거체 case 를 전환하기)]({% post_url 2020-08-20-Statements %}#switching-over-future-enumeration-cases-미래의-열거체-case-를-전환하기) 에서 논의한 것처럼, 동결 열거체에 대한 switch 문은 `default` case 를 요구하지 않습니다. 동결 열거체 전환 때 `default` 나 `@unknown default` case 를 포함하면 경고를 만들어 내는데 그 코드는 절대 실행되지 않기 때문입니다.

#### GKInspectable (점검 가능한 GameplayKit)

이 특성을 적용하면 사용자가 정의한 GameplayKit 성분 속성을 SpriteKit 편집기 UI 로 드러냅니다. 이 특성을 적용하면 암시적으로 `objc` 특성도 적용합니다.

#### inlinable (인라인 가능)

이 특성을 함수나, 메소드, 계산 속성, 첨자, 편의 초기자, 또는 정리자 선언에 적용하면 그 선언 구현을 모듈의 공용 인터페이스 부분으로 드러냅니다. 컴파일러는 인라인 가능한 기호의 호출을 기호 구현부의 복사본으로 호출한 쪽에서 교체하는 걸 허용합니다.

인라인 가능 코드는 어떤 모듈에서 선언한 `public` 기호와도 상호 작용할 수 있으며, 동일 모듈에서 `usableFromInline` 특성을 표시하여 선언한 `internal` 기호와도 상호 작용할 수 있습니다. 인라인 가능 코드는 `private` 이나 `fileprivate` 기호와는 상호 작용할 수 없습니다.

이 특성을 함수 안에 중첩한 선언이나 `fileprivate` 및 `private` 선언에 적용할 순 없습니다. 인라인 가능 함수 안에서 정의한 함수와 클로저는, 이 특성을 표시할 수 없을지라도, 암시적으로 인라인 가능입니다.

#### main (메인)

이 특성을 구조체나, 클래스, 또는 열거체 선언에 적용하면 이게 프로그램 흐름의 최상단 진입점 (top-level entry point) 을 담고 있다고 지시합니다. 타입은 반드시 어떤 인자도 취하지 않고 `Void` 를 반환하는 `main` 타입 함수를 제공해야 합니다. 예를 들면 다음과 같습니다:

```swift
@main
struct MyTopLevel {
  static func main() {
    // 최상단 코드는 여기에 둠
  }
}
```

`main` 특성의 필수 조건을 설명하는 또 다른 방식은 이 특성을 쓴 타입은 반드시 다음의 가상 (hypothetical) 프로토콜을 준수한 타입과 똑같은 필수 조건을 만족해야 한다는 것입니다:

```swift
protocol ProvidesMain {
  static func main() throws
}
```

[Top-Level Code (최상단 코드)]({% post_url 2020-08-15-Declarations %}#top-level-code-최상단-코드) 에서 논한 것처럼, 실행 파일을 만들려고 컴파일하는 스위프트 코드는 최대 한 개의 최상단 진입점을 담을 수 있습니다.

#### nonobjc (오브젝티브-C 아님)

이 특성을 메소드나, 속성, 첨자, 또는 초기자 선언에 적용하면 암시적 `objc` 특성을 억누릅니다. `nonobjc` 특성은 컴파일러에게, 오브젝티브-C 로 나타내는게 가능한 선언일지라도, 오브젝티브-C 코드에서 사용 불가능하게 하라고 말하는 겁니다.

`nonobjc` 특성을 사용하여 클래스에서 `objc` 특성을 표시한 연동 메소드 (bridging methods) 의 순환성도 해결하고, 클래스에서 `objc` 특성을 표시한 메소드와 초기자의 중복 정의도 허용합니다.

`nonobjc` 특성을 표시한 메소드는 `objc` 특성을 표시한 메소드를 재정의할 수 없습니다. 하지만, `objc` 특성을 표시한 메소드는 `nonobjc` 특성을 표시한 메소드를 재정의할 수 있습니다. 이와 비슷하게, `nonobjc` 특성을 표시한 메소드는 `objc` 특성을 표시한 메소드에 대한 프로토콜 필수 조건을 만족할 수 없습니다.

#### NSApplicationMain (NS 앱 메인)

이 특성을 클래스에 적용하면 자신이 앱의 일을-맡은자 (the application delegate) 라는 걸 지시합니다. 이 특성을 사용하는 건 `NSApplicationMain(_:_:)` 함수를 호출하는 것과 같은 겁니다.

이 특성을 사용하지 않는다면, 다음 처럼 최상단에서 `NSApplicationMain(_:_:)` 함수를 호출하는 코드가 있는 `main.swift` 파일을 공급합니다:[^NSApplicationMain-UIApplicationMain]

```swift
import AppKit
NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
```

[Top-Level Code (최상단 코드)]({% post_url 2020-08-15-Declarations %}#top-level-code-최상단-코드) 에서 논한 것처럼, 실행 파일을 만들려고 컴파일하는 스위프트 코드는 최대 한 개의 최상단 진입점을 담을 수 있습니다.

#### NSCopying (NS 복사)

이 특성은 클래스의 저장 변수 속성에 적용합니다. 이 특성은 속성의 설정자가 속성 그 자체의 값 대신-`copyWithZone(_:)` 메소드로 반환한-속성 값의 _복사본 (copy)_ 과 통합되도록 합니다. 속성 타입은 반드시 `NSCopying` 프로토콜을 준수해야 합니다.

`NSCopying` 특성은 오브젝티브-C 의 `copy` 속성 특성과 비슷하게 동작합니다.

#### NSManaged (NS 관리)

이 특성을 `NSManagedObject` 를 상속한 클래스의 인스턴스 메소드 또는 저장 변수 속성에 적용하면, 결합 개체 설명[^associated-entity-description] 을 기초로, 코어 데이터 (Core Data) 가 자신의 구현을 실행 시간에 동적으로 제공한다는 걸 지시합니다. `NSManaged` 특성을 표시한 속성이면, 코어 데이터가 실행 시간에 저장 공간도 제공합니다. 이 특성을 적용하면 암시적으로 `objc` 특성도 적용합니다.

#### objc (오브젝티브-C)

이 특성은 오브젝티브-C 로 나타낼 수 있는 어떤 선언에든 적용하는데-예를 들어, 중첩 아닌 클래스, 프로토콜, (정수 원시-값 타입으로 구속한) 일반화 아닌 열거체, (획득자와 설정자를 포함한) 클래스 속성 및 메소드, 프로토콜과 프로토콜의 옵셔널 멤버, 초기자, 및 첨자입니다. `objc` 특성은 컴파일러에게 오브젝티브-C 코드에서 선언이 사용 가능하다고 말하는 겁니다.

이 특성을 익스텐션에 적용하는 건 그 익스텐션에서 `nonobjc` 특성을 명시하지 않은 모든 멤버에 이를 적용한 것과 똑같은 효과입니다.

컴파일러는 오브젝티브-C 로 정의한 어떤 클래스의 하위 클래스에든 `objc` 특성을 암시적으로 추가합니다. 하지만, 하위 클래스는 반드시 일반화가 아니어야 하며, 반드시 어떤 일반화 클래스도 상속하지 않아야 합니다. 이러한 기준에 부합하는 하위 클래스에 `objc` 특성을 명시적으로 추가하면, 밑에서 논한 것처럼 자신의 오브젝티브-C 이름을 지정할 수 있습니다. `objc` 특성을 표시한 프로토콜은 이 특성을 표시하지 않은 프로토콜을 상속할 수 없습니다.

다음 경우에도 `objc` 특성을 암시적으로 추가합니다:

* 하위 클래스에서 재정의한 선언이, 상위 클래스에서 `objc` 특성을 가진 경우
* `objc` 특성을 가진 프로토콜의 필수 조건을 만족하는 선언인 경우
* `IBAction` 이나, `IBSegueAction`, `IBOutlet`, `IBDesignable`, `IBInspectable`, `NSManaged`, 또는 `GKInspectable` 특성을 가진 선언인 경우

열거체에 `objc` 특성을 적용하면, 각각의 열거체 case 를 열거체 이름과 case 이름을 이어붙인 형태로 오브젝티드-C 코드에 드러납니다. case 이름의 첫 글자는 대문자입니다. 예를 들어, 스위프트 `Planet` 열거체 안의 `venus` 라는 이름의 case 는 `PlanetVenus` 라는 이름의 case 로 오브젝티브-C 에 드러납니다.

`objc` 특성은, 식별자로 구성한, 단일 특성 인자를 옵션으로 받습니다. 식별자는 `objc` 특성을 적용한 개체가 오브젝티브-C 로 드러날 이름을 지정합니다. 이 인자를 사용하여 클래스와, 열거체, 열거체 case, 프로토콜, 메소드, 획득자, 설정자, 및 초기자의 이름을 지을 수 있습니다. 클래스나, 프로토콜, 또는 열거체의 오브젝티브-C 이름을 지정한다면, [Programming with Objective-C](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011210) 에 있는 [Conventions](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Conventions/Conventions.html#//apple_ref/doc/uid/TP40011210-CH10-SW1) 에서 설명한 것처럼, 이름에 세-글자짜리 접두사[^three-letter-prefix] 를 포함시킵니다. 아래 예제는 `ExampleClass` 에 있는 `enabled` 속성의 획득자를 속성 자신의 이름 보단 `isEnabled` 로 오브젝티브-C 코드에 드러냅니다.

```swift
class ExampleClass: NSObject {
  @objc var enabled: Bool {
    @objc(isEnabled) get {
      // 적절한 값을 반환함
    }
  }
}
```

더 많은 정보는, [Importing Swift into Objective-C](https://developer.apple.com/documentation/swift/imported_c_and_objective-c_apis/importing_swift_into_objective-c) 항목을 보기 바랍니다.

> `objc` 특성의 인자는 그 선언의 런타임[^runtime]  이름도 바꿀 수 있습니다. 런타임 이름은, [NSClassFromString](https://developer.apple.com/documentation/foundation/1395135-nsclassfromstring) 같이, 오브젝티브-C 런타임과 상호 작용하는 함수를 호출할 때와, 앱의 **Info.plist** 파일에서 클래스 이름을 지정할 때, 사용합니다. 인자를 전달해서 이름을 정하면, 그 이름을 오브젝티브-C 코드 안의 이름과 런타임 이름으로 사용합니다. 인자를 생략하면, 오브젝티브-C 코드 안에서 사용할 이름이 스위프트 코드 안의 이름과 일치하며, 런타임 이름은 보통의 스위프트 컴파일러 이름 뭉개기 협약[^name-mangling] 을 따릅니다.

#### objcMembers (오브젝티브-C 멤버)

이 특성을 클래스 선언에 적용하면, 클래스와, 익스텐션, 하위 클래스, 및 하위 클래스의 모든 익스텐션 안에서 오브젝티브-C 와 호환 가능한 모든 멤버에 암시적으로 `objc` 특성을 적용합니다.

대부분의 코드는 `objc` 특성을 대신 사용하여, 필요한 선언만 드러내는게 좋습니다. 수많은 선언을 드러낼 필요가 있다면, 익스텐션 그룹을 만들어 `objc` 특성을 줄 수 있습니다. `objcMembers` 특성은 오브젝티브-C 런타임의 내부 기능 (introspection facilities) 을 아주 많이 쓰는 라이브러리의 편의를 위한 것입니다.[^objc] 불필요할 때 `objc` 특성을 적용하면 바이너리 크기가 증가하고 성능에 불리한 영향을 줄 수 있습니다.

#### propertyWrapper (속성 포장)

이 특성을 클래스나, 구조체, 또는 열거체 선언에 적용하면 그  타입을 속성 포장으로 사용합니다. 이 특성을 타입에 적용할 땐, 그 타입과 똑같은 이름을 가진 자신만의 특성을 생성하는 겁니다. 그 새로운 특성을 클래스나, 구조체, 또는 열거체 속성에 적용하면 속성으로의 접근을 포장 타입 (wrapper type) 의 인스턴스로 포장하며; 특성을 지역 저장 변수에 적용하면 변수로의 접근을 똑같은 방식으로 포장합니다. 계산 변수와, 전역 변수, 및 상수는 속성 포장을 사용할 수 없습니다.

포장 (wrapper) 은 반드시 `wrappedValue` 인스턴스 속성을 정의해야 합니다. 속성의 _포장 값 (wrapped value)_ 은 이 속성의 획득자 (getter) 와 설정자 (setter) 가 드러낼 값입니다. 대부분의 경우, `wrappedValue` 는 계산 값 (computed value) 이지만, 그 대신 저장 값 (stored value) 일 수도 있습니다. 포장은 자신의 포장 값에 필요한 어떤 실제 저장 공간이든 정의하고 관리합니다. 컴파일러는 포장한 속성 이름 앞에 접두사로 밑줄 (`_`) 을 붙여서 포장 타입 인스턴스의 저장 공간을 만들어 통합합니다-예를 들어, `someProperty` 의 포장은 `_someProperty` 라고 저장됩니다. 포장의 통합 저장 공간은 `private` 접근 제어 수준을 가집니다.

속성 포장을 가진 속성은 `willSet` 과 `didSet` 블럭을 포함할 수 있지만, 컴파일러에-통합된 `get` 이나 `set` 블럭을 재정의할 순 없습니다.

스위프트는 속성 포장의 초기화를 위해 두 가지 형식의 수월한 구문을 제공합니다. 포장 값 정의에 할당 구문을 사용하면 할당 오른-쪽 표현식을 속성 포장 초기자의 `wrappedValue` 매개 변수에 인자로 전달할 수 있습니다. 속성에 특성을 적용할 때 인자를 제공할 수도 있는데, 이 인자들은 속성 포장 초기자로 전달됩니다. 예를 들어, 아래 코드에서, `SomeStruct` 는 `SomeWrapper` 에서 정의한 각각의 초기자를 호출합니다.

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
  // init() 을 사용함
  @SomeWrapper var a: Int

  // init(wrappedValue:) 을 사용함
  @SomeWrapper var b = 10

  // 둘 다 init(wrappedValue:custom:) 을 사용함
  @SomeWrapper(custom: 98.7) var c = 30
  @SomeWrapper(wrappedValue: 30, custom: 98.7) var d
}
```

포장한 속성의 _내민 값 (projected value)_ 은 두 번째 값으로 이를 사용하면 속성 포장이 추가 기능을 드러낼 수 있습니다. 속성 포장 타입의 작성자는 내민 값의 의미를 결정하고 내민 값을 드러낼 인터페이스의 정의를 책임집니다. 속성 포장에서 값을 내밀려면, 포장 타입에 `projectedValue` 인스턴스 속성을 정의합니다. 컴파일러는 포장한 속성 이름 앞에 접두사로 달러 기호 (`$`) 를 둠으로써 내민 값의 식별자를 만들어 통합합니다-예를 들어, `someProperty` 의 내민 값은 `$someProperty` 입니다. 내민 값의 접근 제어 수준은 원본 포장 속성과 똑같습니다.

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

이 특성을 클래스, 구조체, 및 열거체에 적용하면 그 타입을 결과 제작자로 사용합니다. _결과 제작자 (result builder)_ 는 중첩 자료 구조를 한 걸음씩 단계별로 제작하는 타입입니다. 결과 제작자를 사용하여 자연스러운, 선언형 방식으로, 중첩 자료 구조를 생성하기 위한 특정-분야 언어 (DSL)[^domain-specific-language] 을 구현합니다. `resultBuilder` 특성의 사용법에 대한 예제는, [Result Builders (결과 제작자)]({% post_url 2020-05-11-Advanced-Operators %}#result-builders-결과-제작자) 부분을 보기 바랍니다.

**Result-Building Methods (결과-제작 메소드)**

결과 제작자는 밑에서 설명할 정적 메소드를 구현합니다. 결과 제작자의 모든 기능은 정적 메소드를 통해 드러나기 때문에, 절대 그 타입의 인스턴스를 초기화하지 않습니다.[^do-not-ever] `buildBlock(_:)` 메소드는 필수이며; DSL 에 추가 기능을 부여하는-다른 메소드는 옵션입니다. 결과 제작자 타입의 선언은 어떤 프로토콜 준수성도 실제로 포함하지 않아도 됩니다.[^do-not-actually]

정적 메소드 설명엔 세 개의 타입을 자리 표시자로 사용합니다. `Expression` 타입은 결과 제작자의 입력 타입에 대한 자리 표시자이고, `Component` 는 부분 결과 타입에 대한 자리 표시자이며, `FinalResult` 는 결과 제작자가 만들어 내는 결과 타입에 대한 자리 표시자입니다. 이러한 타입은 자신의 결과 제작자가 사용할 실제 타입으로 교체합니다. 자신의 결과-제작 메소드에서 `Expression` 이나 `FinalResult` 타입을 지정하지 않으면, 기본적으로 `Component` 와 똑같아 집니다.

결과-제작 메소드는 다음과 같습니다:

`static func buildBlock(_ components: Compnent...) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;부분 결과들의 배열을 단일 부분 결과로 조합함. 결과 제작자는 반드시 이 메소드를 구현해야 함.

`static func buildOptional(_ component: Compnent?) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;`nil` 일 수 있는 부분 결과로 부분 결과를 제작함. 이 메소드를 구현하면 `else` 절을 포함하지 않는 `if` 문을 지원함.

`static func buildEither(first: Compnent) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;어떠한 조건에 따라 값이 변하는 부분 결과를 제작함. 이 메소드와 `buildEither(second:)` 둘 다를 구현하면 `switch` 문과 `else` 절을 포함한 `if` 문을 지원함.

`static func buildEither(second: Compnent) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;어떠한 조건에 따라 값이 변하는 부분 결과를 제작함. 이 메소드와 `buildEither(first:)` 둘 다를 구현하면 `switch` 문과 `else` 절을 포함한 `if` 문을 지원함.

`static func buildArray(_ components: [Compnent]) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;부분 결과들의 배열로 부분 결과를 제작함. 이 메소드를 구현하면 `for` 반복분을 지원함.

`static func buildExpression(_ expression: Expression) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;표현식으로 부분 결과를 제작함. 이 메소드를 구현하면 전처리 과정을 수행-예를 들어, 표현식을 내부 타입으로 변환하는 것을-하거나 사용하는 쪽에 타입 추론을 위한 추가 정보를 제공함.

`static func buildFinalResult(_ component: Compnent) -> FinalResult`

&nbsp;&nbsp;&nbsp;&nbsp;부분 결과로 최총 결과를 제작함. 이 메소드는 부분 및 최종 결과에서 사용할 타입이 서로 다른 결과 제작자를 구현하거나, 결과 반환 전에 다른 후처리 과정을 수행하기 위해 구현할 수 있음.

`static func buildLimitedAvailablility(_ component: Compnent) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;사용 가능성을 검사하는 컴파일러-제어문 밖으로 타입 정보를 전파하거나 지우는 부분 결과를 제작함. 이를 사용하면 조건 분기마다 다양하게 변하는 타입 정보를 지울 수 있음.

예를 들어, 아래 코드는 정수 배열을 제작하는 단순한 결과 제작자를 정의합니다. 이 코드는 `Component` 와 `Expression` 을 타입 별명으로 정의하여, 아래 예제와 위의 메소드 목록을 더 쉽게 맞춰보게 합니다.

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

**Result Transformations (결과 변형)**

다음의 구문 변형을 재귀적으로 적용하여 결과-제작자 구문 코드를 결과 제작자 타입의 정적 메소드 호출 코드로 바꿉니다:

* 결과 제작자에 `buildExpression(_:)` 메소드가 있으면, 각각의 표현식은 그 메소드 호출이 됩니다. 이 변형이 항상 첫 번째입니다. 예를 들어, 다음 선언들은 서로 같은 겁니다:

```swift
@ArrayBuilder var builderNumber: [Int] { 10 }
var manualNumber = ArrayBuilder.buildExpression(10)
```

* 할당문의 변형은 표현식과 같지만, `()` 를 평가하는 걸로 이해합니다.[^evaluate] `()` 타입 인자를 취하는 `buildExpression(_:)` 을 중복 정의하면 할당을 특수하게 처리할 수 있습니다.

* 사용 가능성 조건을 검사하는 분기문은 `buildLimitedAvailablility(_:)` 메소드 호출이 됩니다. 이 변형은 `buildEither(first:)` 나, `buildEither(second:)`, 또는 `buildOptional(_:)` 호출로 변형하기 전에 발생합니다. `buildLimitedAvailablility(_:)` 메소드를 사용하면 어느 분기를 취할 지에 따라 바뀌는 타입 정보를 지웁니다. 예를 들어, 아래의 `buildEither(first:)` 와 `buildEither(second:)` 메소드는 일반화 타입을 사용하여 두 분기 모두에 대한 타입 정보를 붙잡습니다.

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

하지만, 이런 접근법은 사용 가능성을 검사하는 코드에서 문제를 일으킵니다:

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
// brokenDrawing 의 타입은 Line<DrawEither<Line<FutureText>, Line<Text>>> 임
```

위 코드엔, `brokenDrawing` 타입 부분에 `FutureText` 가 나타나는데 이는 `DrawEither` 일반화 타입에 있는 타입 중 하나이기 때문입니다. 이는 `FutureText` 타입을 명시적으로 사용하지 않는 경우라도, 실행 시간에 그 타입이 사용 가능하지 않으면 프로그램 충돌을 일으킬 수 있습니다.

이 문제를 풀려면, `buildLimitedAvailability(_:)` 메소드를 구현하여 타입 정보를 지웁니다. 예를 들어, 아래 코드는 자신의 사용 가능성 검사로 `AnyDrawable` 값을 제작합니다.

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
// typeErasedDrawing 의 타입은 Line<DrawEither<AnyDrawable, Line<Text>>> 임
```

* 분기문은 연속된 `buildEither(first:)` 와 `buildEither(second:)` 의 중첩 호출이 됩니다. 구문의 조건과 case 는 이진 트리[^binary-tree] 의 잎 노드 (leaf nodes) 에 대응하며, 구문은 뿌리 노드 (root node) 에서 그 잎 노드로의 경로를 따라가는 중첩된 `buildEither` 메소드 호출이 됩니다.

예를 들어, 세 개의 case 절이 있는 switch 문을 작성하면, 컴파일러는 세 개의 잎 노드가 있는 이진 트리를 사용합니다. 마찬가지로, 뿌리 노드에서 두 번째 case 로의 경로는 "두 번째 자식" 다음에 "첫 번째 자식" 이기 때문에, 그 case 는 `buildEither(first: buildEither(second: ...))` 와 같은 중첩 호출이 됩니다. 다음 선언들은 서로 같은 겁니다:  

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

* 값을 만들지 않을 지도 모르는, `else` 절 없는 `if` 문 같은, 분기문은, `buildOptional(_:)` 호출이 됩니다. `if` 문의 조건을 만족하면, 자신의 코드 블럭을 변형하여 인자로 전달하며; 그 외 경우, `nil` 을 인자로 가진 `buildOptional(_:)` 을 호출합니다. 예를 들어, 다음 선언들은 서로 같은 겁니다:

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

* 코드 블럭이나 `do` 문은 `buildBlock(_:)` 메소드 호출이 됩니다. 블럭 안에 있는 각각의 구문은, 한번에 하나씩, 변형하여, `buildBlock(_:)` 메소드의 인자가 됩니다. 예를 들어, 다음 선언들은 서로 같은 겁니다:

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

* `for` 반복문은 임시 변수[^temporary-variable] 와, `for` 반복문, 및 `buildArray(_:)` 메소드 호출이 됩니다. 새로운 `for` 반복문은 시퀀스[^sequence] 를 반복하여 각 부분 결과를 그 배열에 덧붙입니다. 임시 배열은 `buildArray(_:)` 호출의 인자로 전달됩니다. 예를 들어, 다음 선언들은 서로 같은 겁니다:

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

* 결과 제작자에 `buildFinalResult(_:)` 메소드가 있으면, 최종 결과는 그 메소드 호출이 됩니다. 이 변형이 항상 마지막입니다.

변형 동작을 임시 변수로 설명하긴 했지만, 결과 제작자를 사용한다고 실제로 어떤 새로운 선언을 코드에 보이게 생성하는 건 아닙니다.

결과 제작자가 변형할 코드에 `break` 나, `continue`, `defer`, `guard`, 또는 `return` 문, `while` 문, 및 `do`-`catch` 문을 사용할 수 없습니다.

변형 과정은 코드 안의 선언을 바꾸지 않으며, 이는 임시 상수와 변수를 사용하여 표현식을 한 조각씩 제작하게 해줍니다. 이는 `throw` 문이나, 컴파일-시간 진단문, 또는 `return` 문을 담은 클로저도 바꾸지 않습니다.

가능할 때마다, 변형을 합체합니다. 예를 들어, 표현식 `4 + 5 * 6` 는 그 함수를 여러 번 호출하기 보단 `buildExpression(4 + 5 * 6)` 가 됩니다. 마찬가지로, 중첩한 분기문은 단일 이진 트리 형태로 `buildEither` 메소드를 호출합니다.

**Custom Result-Builder Attributes (사용자 결과-제작자 특성)**

결과 제작자 타입을 생성하면 똑같은 이름을 가진 자신만의 특성을 생성합니다. 그 특성은 다음 장소에 적용할 수 있습니다:

* 함수 선언에선, 결과 제작자가 함수 본문을 제작합니다.
* 획득자를 포함한 변수나 첨자 연산 선언에선, 결과 제작자가 획득자 본문을 제작합니다.
* 함수 선언의 매개 변수에선, 결과 제작자가 해당 인자로 전달된 클로저의 본문을 제작합니다.

결과 제작자 특성을 적용해도 ABI 호환성엔 충격을 주지 않습니다. 결과 제작자 특성을 매개 변수에 적용하면 그 특성이 함수 인터페이스의 일부가 되어, 소스 호환성에 효과를 줄 수 있습니다.

#### requires_stored_property_inits (저장 속성 초기화를 요구함)

이 특성을 클래스 선언에 적용하면 클래스 정의 부분에서 자신의 모든 저장 속성에 기본 값을 제공하길 요구합니다. `NSManagedObject` 를 상속한 어떤 클래스든 이 특성이라고 추론합니다.

#### testable (테스트 가능)

이 특성을 `import` 선언에 적용하면 그 모듈의 접근 제어를 바꾼 채로 불러와서 모듈 코드 테스트를 단순하게 해줍니다. 불러온 모듈 안의 개체가 `internal` 접근-수준 수정자로 표시한 거면 마치 `public` 접근-수준 수정자로 선언한 것처럼 불러옵니다. `internal` 이나 `public` 접근-수준 수정자로 표시한 클래스 및 클래스 멤버는 마치 `open` 접근-수준 수정자로 선언한 것처럼 불러옵니다. 불러온 모듈은 반드시 테스트 할 수 있는 상태 (testing enabled)[^test-enabled] 로 컴파일해야 합니다.

#### UIApplicationMain (UI 앱 메인)

이 특성을 클래스에 적용하면 자신이 앱의 일을-맡은자 (the application delegate) 라는 걸 지시합니다. 이 특성을 사용하는 건 `UIApplicationMain` 함수를 호출하는 것과 같은 것이며 이 클래스 이름을 일-맡은 클래스 이름으로 전달합니다.

이 특성을 사용하지 않는다면, 최상단에서 [UIApplicationMain(_:_:_:_:)](https://developer.apple.com/documentation/uikit/1622933-uiapplicationmain) 함수를 호출하는 코드가 있는 `main.swift` 파일을 공급합니다. 예를 들어, 자신의 앱이 자신만의 `UIApplication` 하위 클래스를 주된 클래스 (principal class) 로 사용한다면, 이 특성을 사용하는 대신 `UIApplicationMain(_:_:_:_:)` 함수를 호출합니다.[^NSApplicationMain-UIApplicationMain]

[Top-Level Code (최상단 코드)]({% post_url 2020-08-15-Declarations %}#top-level-code-최상단-코드) 에서 논한 것처럼, 실행 파일을 만들려고 컴파일하는 스위프트 코드는 최대 한 개의 최상단 진입점을 담을 수 있습니다.

#### unchecked (검사 안함)

타입 선언이 채택한 프로토콜 목록 부분에 이 특성을 적용하면 그 프로토콜 필수 조건을 강제하는 걸 끕니다.

유일하게 지원하는 프로토콜은 [Sendable](https://developer.apple.com/documentation/swift/sendable) 입니다.[^sendable]

#### usableFromInline (인라인에서 사용 가능)

이 특성을 함수나, 메소드, 계산 속성, 첨자, 초기자, 또는 정리자 선언에 적용하면 선언과 동일한 모듈 안에서 정의한 인라인 가능 코드에서 그 기호를 사용하는 걸 허용합니다. 선언엔 반드시 `internal` 접근 수준 수정자가 있어야 합니다. `usableFromInline` 을 표시한 구조체나 클래스는 자신의 속성이 공용 (public) 또는 `usableFromInline` 인 타입만 사용할 수 있습니다. `usableFromInline` 을 표시한 열거체는 자신의 case 원시 값과 결합 값이 공용 또는 `usableFromInline` 인 타입만 사용할 수 있습니다.

`public` 접근 수준 수정자와 같이, 이 특성은 모듈의 공개 인터페이스 부분에서 선언을 드러냅니다. `public` 과는 달리, 선언 기호를 내보낼지라도, `usableFromInline` 을 표시한 선언이 모듈 밖 코드에서 이름으로 참조되는 걸 컴파일러가 허용하진 않습니다. 하지만, 모듈 밖 코드는 런타임 동작을 사용하여 여전히 선언 기호와 상호 작용할 수 있을지도 모릅니다.

`inlinable` 특성을 표시한 선언은 암시적으로 인라인 가능한 코드에서 사용 가능합니다.[^inlinable] `inlinable` 이든 `usableFromInline` 이든 `internal` 선언에 적용할 수 있긴 하지만, 두 특성을 모두 적용하면 에러입니다.

#### warn_unqualified_access (규명 안된 접근 경고하기)

이 특성을 최상단 함수나, 인스턴스 메소드, 또는 클래스나 정적 메소드에 적용하면, 모듈 이름이나, 타입 이름, 또는 인스턴스 변수 및 상수 같은, 앞선 규명자[^preceding-qualifier] 없이 그 함수나 메소드를 사용할 때 경고를 발생시킵니다. 이 특성을 사용하면 동일한 영역에서 접근 가능한 똑같은 이름의 함수 사이에 모호함이 없게 도와줍니다.

예를 들어, 스위프트 표준 라이브러리는 최상단 `min(_:_:)` 함수 및 비교 가능 원소의 시퀀스 (sequence) 를 위한 `min()` 메소드를 둘 다 포함합니다. 시퀀스 메소드는 `warn_unqualified_access` 특성으로 선언되어 `Sequence` 익스텐션 안에서 둘 중 하나를 사용하려할 때의 혼동을 줄이도록 합니다.

#### Declaration Attributes Used by Interface Builder (인터페이스 빌더에서 쓰는 선언 특성)

인터페이스 빌더 특성은 인터페이스 빌더[^interface-builder] 에서 엑스코드와 동기화하기 위해 쓰는 선언 특성입니다. 스위프트는 다음의 인터페이스 빌더 특성을 제공하는데: `IBAction` 과, `IBSegueAction`, `IBOutlet`, `IBDesignable`, 및 `IBInspectable` 이 그것입니다. 이러한 특성은 오브젝티브-C 에 있는 것과 개념이 똑같습니다.

`IBOutlet` 과 `IBInspectable` 특성은 클래스의 속성 선언에 적용합니다. `IBAction` 과 `IBSegueAction` 특성은 클래스의 메소드 선언에 `IBDesignable` 특성은 클래스 선언에 적용합니다.

`IBAction` 이나, `IBSegueAction`, `IBOutlet`, `IBDesignable`, 또는 `IBInspectable` 특성을 적용하는 건 `objc` 특성이기도 함을 암시합니다.

### Type Attributes (타입 특성)

타입 특성은 타입에만 적용할 수 있습니다.

#### autoclosure (자동 클로저)

이 특성을 적용하면 인자 없는 클로저로 표현식을 자동 포장함으로써 그 표현식의 평가를 늦춥니다. 함수나 메소드 선언에서, 매개 변수 타입이 아무런 인자도 취하지 않으며 표현식 타입의 값을 반환하는 함수 타입이면, 그 매개 변수 타입에 이를 적용합니다. `autoclosure` 특성의 사용법에 대한 예제는, [Autoclosures (자동 클로저)]({% post_url 2020-03-03-Closures %}#autoclosures-자동-클로저) 와 [Function Type (함수 타입)]({% post_url 2020-02-20-Types %}#function-type-함수-타입) 부분을 보기 바랍니다.

#### convention (협약)

이 특성을 함수의 타입에 적용하면 호출 협약[^calling-convention] 을 지시합니다.

`convention` 특성은 항상 다음의 인자 중 하나와 함께 나타납니다:

* `swift` 인자는 스위프트 함수 참조를 지시합니다. 이는 스위프트 함수 값에 대한 표준 호출 협약입니다.
* `block` 인자는 오브젝티브-C 호환 가능한 블럭 참조를 지시합니다. 함수 값은 블럭 객체로의 참조를 나타내는데, 이는 자신의 소환 함수[^invocation-function] 를 객체 안에 박아 넣은 `id`-호환 가능한 오브젝티브-C 객체입니다. 소환 함수는 **C** 호출 협약 을 사용합니다.
* `c` 인자는 C 함수 참조를 지시합니다. 함수 값은 아무런 의미도 없으며 **C** 호출 협약을 사용합니다.

몇 가지를 제외하면, 어떤 호출 협약의 함수든 다른 어떤 호출 협약인 함수가 필요할 때 사용할 수 있습니다. 일반화 아닌 전역 함수나, 어떤 지역 변수도 붙잡지 않는 지역 함수, 또는 어떤 지역 변수도 붙잡지 않는 클로저는 **C** 호출 협약으로 변환할 수 있습니다. 다른 스위프트 함수는 C 호출 협약으로 변환할 수 없습니다. 오브젝티브-C 블럭 호출 협약인 함수는 C 호출 협약으로 변환 할 수 없습니다.

#### escaping (벗어남)

이 특성을 함수나 메소드 선언 안의 매개 변수 타입에 적용하면 나중에 실행하기 위해 매개 변수 값을 저장할 수 있다는 걸 지시합니다. 이는 그 값이 호출 수명보다 오래 사는 걸 허용한다는 의미입니다. `escaping` 타입 특성인 함수 타입 매개 변수는 속성이나 메소드에 `self.` 를 명시하여 사용할 걸 요구합니다. `escaping` 특성의 사용법에 대한 예제는, [Escaping Closures (벗어나는 클로저)]({% post_url 2020-03-03-Closures %}#escaping-closures-벗어나는-클로저) 부분을 보기 바랍니다.

#### Sendable (보내기 가능함)

이 특성은 함수 타입에 적용하여 함수나 클로저가 보내기 가능하다는 걸 지시합니다. 이 특성을 참수 타입에 적용하는 건 함수-아닌 타입이 [Sendable](https://developer.apple.com/documentation/swift/sendable) 프로토콜을 따르는 것과 의미가 똑같습니다.

함수나 클로저를 사용하는 곳이 보내기 가능한 값을 예상한 상황이면서, 함수나 클로저가 보내기 가능한 필수 조건을 만족하는 경우에, 함수와 클로저에서 이 특성을 추론합니다.

보내기 가능한 함수 타입은 그에 해당하는 보내기 불가능한 함수 타입의 하위 타입입니다.

### Switch Case Attributes (switch 문 case 절 특성)

**switch** 의 **case** 특성은 **switch** 문의 **case** 에만 적용할 수 있습니다.

#### unknown (알려지지 않음)

이 특성을 **switch** 문의 **case** 에 적용하면 코드를 컴파일하는 시점에 알고 있는 어떤 열거체 case 와도 일치하지 않을 것으로 예상한다고 지시합니다. `unknown` 특성의 사용법에 대한 예제는, [Switching Over Future Enumeration Cases (미래의 열거체 case 를 전환하기)]({% post_url 2020-08-20-Statements %}#switching-over-future-enumeration-cases-미래의-열거체-case-를-전환하기) 부분을 보기 바랍니다.

> GRAMMAR OF AN ATTRIBUTE 부분 생략 - [링크](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html#ID604)

### 다음 장

[Patterns (패턴; 유형) > ]({% post_url 2020-08-25-Patterns %})

### 참고 자료

[^Attributes]: 원문은 [Attributes](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html) 에서 확인할 수 있습니다.

[^life-cycle]: '생명 주기 (life cycle)' 는 다양한 분야에서 여러 가지 의미로 사용되므로 정확하게 딱 잘라 말하기 어렵지만, 여기서는 대체로 하나의 선언이 메모리 할당부터 해제될 때까지 겪는 상태 변화를 의미합니다. 생명 주기에 대한 더 자세한 정보는 애플 개발자 문서의 [Managing Your App's Life Cycle](https://developer.apple.com/documentation/uikit/app_and_environment/managing_your_app_s_life_cycle/) 항목을 참고하기 바랍니다. 

[^deprecated]: 선언을 '폐기할 예정 (deprecated)' 이라는 건 당장은 쓸 수 있지만 앞으로 폐기할 거라서 지금부터 쓰지 않는게 좋다고 알리는 것입니다. 

[^obsoleted]: 선언을 '폐기한 (obseleted)' 건 이미 쓸 수 없는 선언이라는 의미입니다.

[^effective]: 여러 개의 `available` 특성을 사용할 경우, 플랫폼 사용 가능성만 여러 개 적용하거나 스위프트 버전 사용 가능성만 여러 개 적용한 건 별 의미가 없다는 의미입니다. 

[^seperate]: 하나의 `available` 특성에 스위프트 버전과 플랫펌 버전 인자를 동시에 쓸 수 없다는 의미입니다.

[^dynamic-callable]: '동적으로 호출 가능한 (dynamicCallable) 특성' 은 C++ 언어 등에 있는 함수 객체 (function object) 와 유사한 개념입니다. 함수 객체에 대한 더 자세한 정보는, 위키피디아의 [Function object](https://en.wikipedia.org/wiki/Function_object) 항목을 보기 바랍니다.

[^dynamic-member-lookup]: 본문에서 설명한 것처럼, 스위프트에서 **Core Data** 나 **JSON** 을 다룰 때 동적으로 멤버 찾아보기 (dynamicMemberLookup) 를 많이 사용하게 됩니다. 다만, 스위프트 언어가 업데이트되면서 동적으로 멤버 찾아보기 같은 기능을 명시적으로 쓰는 경우는 점점 줄어들고 있습니다. 

[^library-evolution-mode]: '라이브러리 진화 모드 (library evolution mode)' 는 스위프트 바이너리 프레임웍을 생성할 때 사용할 수 있는 옵션입니다. 이어지는 설명을 볼 때, 앞으로 라이브러리가 지속적으로 바뀔 가능성이 있을 때 선택하는 옵션이라고 추측할 수 있습니다. 라이브러리 진화 모드에 대한 더 자세한 정보는, [Library Evolution in Swift](https://swift.org/blog/library-evolution/) 항목을 보도록 합니다. 

[^ABI-compatibility]: 'ABI 호환성 (Application Binary Interface Compatibility)' 이란 앱과 앱에서 사용한 라이브러리가 바이너리 수준에서 호환성을 가지는 걸 말합니다. ABI 호환성이 있으면 이미 컴파일되어 있는 라이브러리로 앱에서 그대로 사용할 수 있습니다. 이렇게 ABI 호환성을 가질려면 기존에 컴파일해둔 라이브러리가 미래에 바뀌어선 안되는 것입니다. 

[^command-line]: '명령 줄 (command line)' 은 터미널 (terminal) 에서 명령을 입력하는 곳을 말합니다. 

[^associated-entity-description]: '결합 개체 설명 (associated entity description)' 은 엑스코드 안의 `*.xcdatamodeld` 파일에서 만드는 데이터베이스 스키마 (database schema) 를 말합니다. 코어 데이터의 개체 (entity) 는 다른 데이터베이스의 테이블 (table) 을 말합니다.

[^three-letter-prefix]: 오브젝티브-C 에서 클래스 이름에 세-글자짜리 접두사를 붙이는 이유는 오브젝티브-C 가 이름 공간 (namespaces) 을 지원하지 않기 때문입니다. 이에 대한 더 자세한 정보는 스택오버플로우의 [Is prefix necessary for methods in iOS?](https://stackoverflow.com/questions/26711099/is-prefix-necessary-for-methods-in-ios) 항목과 [What is the best way to solve an Objective-C namespace collision?](https://stackoverflow.com/questions/178434/what-is-the-best-way-to-solve-an-objective-c-namespace-collision) 항목을 참고하기 바랍니다. 

[^runtime]: 여기서 말하는 '런타임 (runtime)' 은 런타임 라이브러리를 의미합니다. 

[^name-mangling]: '이름 뭉개기 (name mangling)' 는 현대 프로그래밍에서 함수와 같은 각각의 프로그램 개체에 유일한 이름을 주기 위한 기법입니다. 타입 자체의 이름에 추가 정보를 덧대어서 유일한 이름을 만드는데 이 과정에서 이름이 뭉개지기 때문에 이렇게 부르는 것으로 추측됩니다.

[^objc]: 오브젝티브-C 기능을 아주 많이 쓰면, 호환성을 위해 `objc` 를 남발하게 될텐데, 이 때의 비효율성을 줄이기 위해 `objcMembers` 특성을 사용한다고 이해할 수 있습니다. 

[^domain-specific-language]: '특정-분야 언어 (domain-specific language; DSL)' 는 특별한 한 응용 분야에서만 특정하게 사용되는 언어입니다. DSL 중에 대표적인 것이 홈페이지를 만드는데 특화된 HTML 입니다. 

[^do-not-ever]: 타입에 정적 메소드만 있으므로, 타입 그 자체를 사용하지 그 타입의 인스턴스를 만들어서 쓸 일이 없다는 의미입니다.

[^do-not-actually]: 이것도 바로 앞에서 설명한 내용과 같은 의미입니다. 정적 메소드만 있어서 인스턴스를 만들지 않으므로, 필수 조건의 구현이라는 개념이 의미가 없기 때문입니다.

[^temporary-variable]: 이 세 개 중에서 임시 변수는, 바로 이어서 설명하는 것처럼, 배열입니다.

[^sequence]: '시퀀스 (sequence)' 는 수학 용어로는 '수열' 을 의미하는 단어이지만, 자료 구조로는 '같은 타입의 값들이 순차적으로 붙어서 나열된 구조' 를 의미합니다. 본문에 있는 '집합체 (collection), 리스트 (list), 시퀀스 (sequence)' 등은 모두 알고리즘에서 사용하는 자료 구조입니다. '시퀀스' 에 대한 더 자세한 정보는, 위키피디아의 [Sequential access](https://en.wikipedia.org/wiki/Sequential_access) 항목과 [순차 접근](https://ko.wikipedia.org/wiki/순차_접근) 항목을 보도록 합니다. 

[^NSApplicationMain-UIApplicationMain]: `NSApplicationMain` 과 `UIApplicationMain` 을 사용하는 방식은 예전 방식입니다. 이제 SwiftUI 에선 `@main` 을 사용하기 때문에, `NSApplicationMain` 이나, `UIApplicationMain`, 또는 `main.swift` 파일을 사용할 일이 없습니다.

[^evaluate]: 할당문의 경우, `buildExpression(_:)` 의 평가 결과를 사용한다는 의미입니다.

[^binary-tree]: '이진 트리 (binary tree)' 는 각각의 노드 (node) 에 최대 두 개의 자식 노드가 있는 트리 자료 구조입니다. 이진 트리에 대한 더 자세한 정보는, 위키피디아의 [Binary tree](https://en.wikipedia.org/wiki/Binary_tree) 항목과 [이진 트리](https://ko.wikipedia.org/wiki/이진_트리) 항목을 참고하기 바랍니다. 

[^test-enabled]: '데트스 할 수 있는 상태 (tesing enabled)' 란 엑스코드의 스킴 (Scheme) 화면 안의 테스트 (Test) 옵션에서 **Debug executable** 이 켜진 상태를 의미합니다.

[^sendable]: 한 동시성 영역에서 다른 곳으로 안전하게 값을 보낼 수 있는 (sendable) 타입입니다. 보다 자세한 내용은 본문에 있는 애플 개발자 문서 내용을 참고하기 바랍니다. 

[^inlinable]: `inlinable` 특성을 부여하면 따로 `usableFromInline` 특성을 부여할 필요가 없다는 의미입니다.

[^preceding-qualifier]: '앞선 규명자 (preceding qualifier)' 는 예제에 있던 `temporary.append(partialResult)` 에서의 `temporary` 같이 그 기호에 **앞**에서 그 기호가 어디에 소속되어 있는지를 **규명**하는 지시**자** 입니다.

[^interface-builder]: '인터페이스 빌더 (Interface Builder)' 는 엑스코드에서 사용하는 UI 제작 도구입니다. 2019년 애플에서 **SwiftUI** 라는 새로운 UI 제작 프레임웍을 발표함에 따라 사용이 줄어들고 있습니다.

[^calling-convention]: '호출 협약 (calling conventions)' 은 호출한 쪽의 매개 변수 전달 방법과 하위 루틴의 결과 반환 방법을 협의해서 정한 약속입니다. 호출 규약이라고도 하는데, 규약은 프로토콜 (protocol) 을 의미하기 때문에, Convention 은 협약이라고 옮깁니다. 호출 협약에 대한 더 자세한 정보는, 위키피디아의 [Calling convention](https://en.wikipedia.org/wiki/Calling_convention) 항목과 [호출 규약](https://ko.wikipedia.org/wiki/호출_규약) 항목을 참고하기 바랍니다. 스위프트의 호출 협약에 대한 더 자세한 정보는, 애플의 **GitHub** 저장소에 있는' [The Swift Calling Convention](https://github.com/apple/swift/blob/main/docs/ABI/CallingConvention.rst) 항목을 참고하기 바랍니다.

[^invocation-function]: '자신의 소환 함수 (invocation function)' 란 자기 자신을 호출하는 함수를 의미합니다. 호출 (call) 은 어떠한 메소드를 직접 실행하는 것을 의미하고 소환 (invoke) 은 어떤 것이 알아서 자동으로 메소드를 실행하게 하는 것을 의미합니다.