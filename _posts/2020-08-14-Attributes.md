---
layout: post
comments: true
title:  "Swift 5.5: Attributes (특성)"
date:   2020-08-14 11:30:00 +0900
categories: Swift Language Grammar Attribute
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Attributes](https://docs.swift.org/swift-book/ReferenceManual/Attributes.html) 부분[^Attributes]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Attributes (특성)

스위프트는-선언에 적용되는 것과 타입에 적용되는 것-두 가지 종류의 '특성 (attributes)' 이 있습니다. '특성' 은 선언이나 타입에 대한 추가적인 정보를 제공합니다. 예를 들어, 함수 선언에 대한 `discardableResult` 특성은, 함수가 값을 반환하긴 하지만, 반환 값을 사용하지 않는다는 이유로 컴파일러가 경고를 생성하지는 않도록 지시합니다.

'특성' 은 '`@` 기호' 뒤예 '특성 이름과 특성이 받는 어떤 인자' 들을 작성함으로써 지정합니다:

&nbsp;&nbsp;&nbsp;&nbsp;@`attribute name-특성 이름`<br />
&nbsp;&nbsp;&nbsp;&nbsp;@`attribute name-특성 이름`(`attribute argument-특성 인자`)

일부 '선언 특성' 들은 특성에 대한 추가 정보와 특별한 선언에 적용하는 방법을 지정하는 인자를 받습니다. 이 _특성 인자 (attribute arguments)_ 들은 괄호로 테두리 치며, 그 양식은 자신이 속한 특성에서 정의합니다.

### Declaration Attributes (선언 특성)

'선언 특성' 은 선언에만 적용할 수 있습니다.

#### available (사용 가능)

이 특성은 '정해진 스위프트 언어 버전' 또는 '정해진 플랫폼과 운영 체제 버전' 과 관계 있는 선언의 '생애 주기 (life cycle)' 를 지시하기 위해 적용합니다.

'`available` 특성' 은 항상 쉼표로 구분한 둘 이상의 '특성 인자 목록' 들과 같이 있습니다. 이 인자들은 다음의 플랫폼 또는 언어 이름으로 시작합니다:

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

'별표 (asterisk; `*`)' 로 '위에 나열한 모든 플랫폼 이름' 에 대한 '선언의 사용 가능성 (availability)' 을 지시할 수도 있습니다. '스위프트 버전 번호로 사용 가능성을 지시한 `available` 특성' 은 '별표' 를 사용할 수 없습니다.

나머지 인자들은 어떤 순서로든 있을 수 있으며, 중요한 '이정표 (milestones)' 를 포함하여, '선언의 생애 주기에 대한 추가적인 정보' 를 지정할 수 있습니다.

* `unavailable` 인자는 '특정 플랫폼에서는 사용 불가능한 선언' 을 지시합니다. '스위프트 버전 사용 가능성' 을 지정할 땐 이 인자를 사용할 수 없습니다.

* `introduced` 인자는 '선언을 도입한 첫 번째 특정 플랫폼 또는 언어 버전' 을 지시합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;introduce: `version number-버전 번호`

&nbsp;&nbsp;&nbsp;&nbsp;_버전 번호 (version number)_ 는, 마침표로 구분한, '1개에서 3개까지의 양수' 로 구성합니다.

* `deprecated` 인자는 '선언을 폐기할 (deprecated) 첫 번째 특정 플랫폼 또는 언어 버전' 을 지시합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;deprecated: `version number-버전 번호`

&nbsp;&nbsp;&nbsp;&nbsp;옵션인 _버전 번호 (version number)_ 는, 마침표로 구분한, '1개에서 3개까지의 양수' 로 구성합니다. '버전 번호' 를 생략하면, 폐기 시점에 대한 어떤 정보도 없이, 현재 해당 선언이 폐기 예정임을 지시합니다. 버전 번호를 생략하면, '콜론 (`:`)' 마저 생략합니다.

* `obsoleted` 인자는 '선언을 폐기한 (obsoleted) 첫 번째 특정 플랫폼 또는 언어 버전' 을 지시합니다. 폐기한 선언일 땐, 특정 플랫폼이나 언어에서 이를 제거하며 더 이상 사용할 수 없습니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;obsoleted: `version number-버전 번호`

&nbsp;&nbsp;&nbsp;&nbsp;_버전 번호 (version number)_ 는, 마침표로 구분한, '1개에서 3개까지의 양수' 로 구성합니다.

* `message` 인자는 '폐기 예정 (deprecated) 이거나 폐기한 (obsoleted) 선언' 의 사용에 대한 '경고 (warning) 나 에러 (error)' 를 내보낼 때 컴파일러가 보여줄 문장 메시지를 제공합니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;message: `message-메시지`

&nbsp;&nbsp;&nbsp;&nbsp;_메시지 (message)_ 는 '문자열 글자 값 (literal)' 으로 구성합니다.

* `renamed` 인자는 '이름이 바뀐 선언에 새로운 이름을 지시하는 문장 메시지' 를 제공합니다. 컴파일러는 '이름 바뀐 선언의 사용에 대한 에러' 를 내보낼 때 새로운 이름을 보여줍니다. 형식은 다음과 같습니다:

&nbsp;&nbsp;&nbsp;&nbsp;renamed: `new name-새로운 이름`

&nbsp;&nbsp;&nbsp;&nbsp;_새로운 이름 (new name)_ 은 '문자열 글자 값' 으로 구성합니다.

&nbsp;&nbsp;&nbsp;&nbsp;프레임웍이나 라이브러리를 발매한 사이에 선언 이름이 바뀌었음을 지시하기 위해, 아래 보인 것처럼, `rename` 과 `unavailable` 인자를 가진 `available` 특성을 '타입 별명 (type alias) 선언' 에 적용할 수 있습니다. 이 조합은 '선언 이름이 바뀌었다' 는 컴파일 시간 에러가 됩니다.

  ```swift
  // 첫 번재 발매
  protocol MyProtocol {
    // 프로토콜 정의
  }

  // 후속 발매 시 MyProtocol 이름을 바꿉니다.
  protocol MyRenamedProtocol {
    // 프로토콜 정의
  }

  @available(*, unavailable, renamed: "MyRenamedProtocol")
  typealias MyProtocol = MyRenamedProtocol
  ```

서로 다른 플랫폼 및 서로 다른 스위프트 버전에 대해서 '선언의 사용 가능성' 을 지정하기 위해 '단일 선언' 에 '여러 개의 `available` 특성' 을 적용할 수 있습니다. '특성에서 지정한 플랫폼이나 언어 버전' 이 '현재 대상' 과 일치하지 않으면 '`available` 특성을 적용한 선언' 을 무시합니다. '여러 개의 `available` 특성' 을 사용할 경우, '실제 (effective) 사용 가능성' 은 '플랫폼과 스위프트 사용 가능성을 조합' 한 것입니다.

`available` 특성이 플랫폼 및 언어 이름 인자에 더하여 `introduced` 인자만 지정할 경우, 다음 '줄임 구문 (shorhand syntax)' 을 대신 사용할 수 있습니다:

&nbsp;&nbsp;&nbsp;&nbsp;\@available(`platform name-플랫폼 이름` `version number-버전 번호`, *)<br />
&nbsp;&nbsp;&nbsp;&nbsp;\@available(swift `version number-버전 번호`)

`available` 특성의 줄임 구문은 여러 플랫폼에 대한 사용 가능성을 간결하게 나타냅니다. 두 형식의 기능이 '동치 (equivalent)' 이긴 하지만, 가능할 때마다 줄임 형식을 사용하는 것이 좋습니다.

```swift
@available(iOS 10.0, macOS 10.12, *)
class MyClass {
  // 클래스 정의
}
```

'스위프트 버전 번호로 사용 가능성을 지정하는 `available` 특성' 은 '선언의 플랫폼 사용 가능성' 을 추가적으로 지정할 수 없습니다. 그 대신, 별도의 `available` 특성을 사용하여 '스위프트 버전 사용 가능성' 과 '하나 이상의 플랫폼 사용 가능성' 을 지정합니다.

```swift
@available(swift 3.0.2)
@available(macOS 10.12, *)
struct MyStruct {
  // 구조체 정의
}
```

#### discardableResult (버릴 수 있는 결과)

이 특성은 '결과를 사용하지 않고 값을 반환하는 함수나 메소드를 호출할 때의 컴파일러 경고' 를 억제하기 위해 함수나 메소드 선언에 적용합니다.

#### dynamicCallable (동적으로 호출 가능)

이 특성은 '타입의 인스턴스를 호출 가능한 함수처럼 취급' 하기 위해 클래스, 구조체, 열거체, 또는 프로토콜에 적용합니다.[^dynamic-callable] 타입은 반드시 `dynamicallyCall(withArguments:)` 메소드나, `dynamicallyCall(withKeywordArguments:)` 메소드, 또는 둘 다를 구현해야 합니다.

'동적으로 호출 가능한 타입의 인스턴스' 는 마치 '어떤 개수의 인자든 취할 수 있는 함수' 인 것처럼 호출할 수 있습니다.

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
// "Get Swift help on forums.swift.org" 를 인쇄합니다.

dial(8, 6, 7, 5, 3, 0, 9)
// "Unrecognized number" 를 인쇄합니다.

// 실제 메소드를 직접 호출합니다.
dial.dynamicallyCall(withArguments: [4, 1, 1])
```

`dynamicallyCall(withArguments:)` 메소드 선언은 반드시-위 예제의 `[Int]` 같이-[ExpressibleByArrayLiteral](https://developer.apple.com/documentation/swift/expressiblebyarrayliteral) 프로토콜을 준수하는 단일 매개 변수를 가져야 합니다. 반환 타입은 어떤 타입이어도 됩니다.

`dynamicallyCall(withKeywordArguments:)` 메소드를 구현하면 '동적 메소드 호출' 에 '이름표' 를 포함할 수 있습니다.

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

`dynamicallyCall(withKeywordArguments:)` 메소드 선언은 반드시 [ExpressibleByDictionaryLiteral](https://developer.apple.com/documentation/swift/expressiblebydictionaryliteral) 프로토콜을 준수하는 단일 매개 변수를 가져야 하며, 반환 타입은 어떤 타입이어도 됩니다. 매개 변수의 [Key](https://developer.apple.com/documentation/swift/expressiblebydictionaryliteral/2294108-key) 는 반드시 [ExpressibleByStringLiteral](https://developer.apple.com/documentation/swift/expressiblebystringliteral) 이어야 합니다. 이전 예제는 매개 변수 타입으로 [KeyValuePairs](https://developer.apple.com/documentation/swift/keyvaluepairs) 를 사용하므로 호출한 쪽에서 매개 변수 이름표를 중복하여 포함할 수 있습니다-`repeat` 호출에 `a` 와 `b` 가 여러 번 있습니다.

`dynamicallyCall` 메소드를 둘 다 구현하면, 메소드 호출 시 키워드 인자를 포함하면 `dynamicallyCall(withKeywordArguments:)` 을 호출합니다. 다른 모든 경우에는, `dynamicallyCall(withArguments:)` 를 호출합니다.

`dynamicallyCall` 메소드 구현에서 지정한 타입과 일치하는 인자와 반환 값을 가진 '동적으로 호출 가능한 인스턴스' 만 호출할 수 있습니다. 다음 예제의 호출은 `KeyValuePairs<String, String>` 을 취하는 `dynamicallyCall(withArguments:)` 구현이 없기 때문에 컴파일되지 않습니다.

```swift
repeatLabels(a: "four") // 에러
```

#### dynamicMemberLookup (동적으로 멤버 찾아보기)

이 특성은 실행 시간에 멤버를 이름으로 찾아볼 수 있게 클래스, 구조체, 열거체, 또는 프로토콜에 적용합니다. 타입은 반드시 '`subscript(dynamicMemberLookup:)` 첨자 연산' 을 구현해야 합니다.

'명시적인 멤버 표현식' 에서, '이름 붙인 멤버와 관련한 선언' 이 없을 경우, 표현식은, 멤버 정보를 인자로써 전달하는, '타입의 `subscript(dynamicMemberLookup:)` 첨자 연산 호출' 인 것으로 이해합니다. 첨자 연산은 '키 경로 (key path)' 나 '멤버 이름' 인 매개 변수를 취할 수 있는데; 두 첨자 연산 모두를 구현하면, '키 경로 인자를 취하는 첨자 연산' 을 사용합니다.

`subscript(dynamicMemberLookup:)` 구현은 [KeyPath](https://developer.apple.com/documentation/swift/keypath), [WritableKeyPath](https://developer.apple.com/documentation/swift/writablekeypath), 또는 [ReferenceWritableKeyPath](https://developer.apple.com/documentation/swift/referencewritablekeypath) 타입의 인자를 사용하는 '키 경로' 를 취할 수 있습니다. [ExpressibleByStringLiteral](https://developer.apple.com/documentation/swift/expressiblebystringliteral) 프로토콜을 준수하는 타입-대부분의 경우, `String`-인 인자를 사용하는 '멤버 이름' 을 취할 수도 있습니다. 첨자 연산의 반환 타입은 어떤 타입이어도 됩니다.

'멤버 이름을 써서 동적으로 멤버 찾아보기' 는, 다른 언어로 된 자료를 스위프트 안으로 연동할 때 처럼, 컴파일 시간에 타입 검사를 할 수 없는 자료의 '포장 타입 (wrapper type)' 을 생성하기 위해 사용할 수 있습니다.[^dynamic-member-lookup] 예를 들면 다음과 같습니다:

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

// '동적으로 멤버 찾아보기' 를 사용합니다.
let dynamic = s.someDynamicMember
print(dynamic)
// "325" 를 출력합니다.

// 실제 첨자 연산을 직접 호출합니다.
let equivalent = s[dynamicMember: "someDynamicMember"]
print(dynamic == equivalent)
// "true" 를 출력합니다.
```

'키 경로를 써서 동적으로 멤버 찾아보기' 는 '컴파일-시간 타입 검사를 지원하는 식으로 포장 타입' 을 구현하기 위해 사용할 수 있습니다. 예를 들면 다음과 같습니다:

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

이 특성은 '타입에 가할 수 있는 변화의 종류를 제약' 하기 위해 구조체나 열거체 선언에 적용합니다. 이 특성은 '라이브러리 진화 모드 (library evolution mode)' 로 컴파일할 때만 허용합니다. 라이브러리의 '미래 (future) 버전' 은 '열거체의 case 값이나 구조체의 저장 인스턴스 속성을 추가, 삭제, 또는 재배치 (reordering)' 함으로써 선언을 바꿀 수 없습니다. '동결 아닌 (nonfrozen) 타입' 은 이런 변화를 허용하지만, '동결 타입' 에서 이러면 'ABI 호환성 (ABI compatibility)' 을 깨뜨립니다.

> 컴파일러가 '라이브러리 진화 모드' 가 아닐 땐, 모든 구조체와 열거체가 암시적으로 '동결 (frozen)' 이며, 이 특성을 무시합니다.

'라이브러리 진화 모드' 에서, '동결 아닌 구조체 및 열거체 멤버' 와 상호 작용하는 코드는 라이브러리의 '미래 버전' 이 해당 타입의 일부 멤버를 추가, 삭제, 또는 재배치하는 경우에도 재-컴파일 없이 계속 작업을 허용하는 식으로 컴파일합니다. 컴파일러는 '실행 시간 정보 찾아보기' 와 '간접 계층 추가하기' 같은 기술로 이를 가능하게 합니다. 구조체나 열거체를 '동결' 로 만드는 건 성능을 얻고자 이 유연함을 포기하는 것으로: 미래 버전의 라이브러리는 타입에 대해 제한된 변화만 가할 수 있지만, 타입의 멤버와 상호 작용하는 코드에는 컴파일러가 추가적인 최적화를 가할 수 있습니다.

동결 타입, 동결 구조체의 저장 속성 타입, 그리고 '동결 열거체 case 값의 결합 값' 은 반드시 '공용 (public)' 이거나 '`usableFromInline` 특성으로 표시한 것' 이어야 합니다. '동결 구조체의 속성' 은 '속성 관찰자' 와, [inlinable (인라인 가능)](#inlinable-인라인-가능) 에서 논의한 것처럼, '반드시 인라인 가능 함수 (inlinable functions) 와 똑같은 제약 사항을 따라야 하는 저장 인스턴스 속성에 초기 값을 제공하는 표현식' 을 가질 수 없습니다.

'명령 줄 (command line)' 에서 '라이브러리 진화 모드' 를 쓰려면, 스위프트 컴파일러에 `-enable-library-evolution` 옵션을 전달합니다. '엑스코드 (Xcode)' 에서 쓰려면, [Xcode Help](https://help.apple.com/xcode/mac/current/#/dev04b3a04ba) 에서 설명한 것처럼, "배포용 라이브러리 제작 (`BUILD_LIBRARY_FOR_DISTRIBUTION`)" 이라는 '배포 설정 (build setting)' 을 '예 (Yes)' 로 설정합니다.

'동결 열거체' 에 대한 'switch 문' 은, [Switching Over Future Enumeration Cases (미래의 '열거체 case 값' 에 대해 전환 (switching) 하기)]({% post_url 2020-08-20-Statements %}#switching-over-future-enumeration-cases-미래의-열거체-case-값에-대해-전환-switching-하기) 에서 논의한 것처럼, '`default` case 절' 을 요구하지 않습니다. 동결 열거체를 전환할 때 '`default` 나 `@unknown default` case 절' 를 포함하면 해당 코드를 절대로 실행하지 않기 때문에 '경고' 를 만들어 냅니다.

#### GKInspectable (점검 가능한 GameplayKit)

이 특성은 '사용자 정의 GameplayKit 성분 속성' 을 'SpriteKit 편집기 UI' 로 노출하기 위해 적용합니다. 이 특성을 적용하면 `objc` 특성임을 암시하는 것이기도 합니다.

#### inlinable (인라인 가능)

이 특성은 '구현한 선언을 모듈의 공용 인터페이스로 노출' 하기 위해 함수, 메소드, 계산 속성, 첨자 연산, 편의 초기자, 또는 정리자 선언에 적용합니다. 컴파일러는 호출한 쪽에서 '인라인 가능 (inlinable) 기호에 대한 호출' 을 '기호의 구현에 대한 복사본' 으로 대체하는 걸 허용합니다.

'인라인 가능 코드' 는 어떤 모듈에서 선언한 '`public` 기호' 와도 상호 작용할 수 있고, 동일한 모듈에서 '`usableFromInline` 특성을 표시하여 선언한 `internal` 기호' 와도 상호 작용할 수 있습니다. '인라인 가능 코드' 는 '`private` 이나 `fileprivate` 기호' 와는 상호 작용할 수 없습니다.

이 특성은 '함수 안에 중첩한 선언' 또는 '`fileprivate` 이나 `private` 선언' 에 적용할 수 없습니다. '인라인 가능 함수' 안에 정의한 함수와 클로저는, 이 특성을 표시할 수 없을 지라도, '암시적으로 인라인 가능' 합니다.

#### main (메인)

이 특성은 '프로그램 흐름의 최상단 진입점 (top-level entry point) 을 담고 있음' 을 지시하기 위해 구조체, 클래스, 또는 열거체 선언에 적용합니다. 타입은 반드시 '어떤 인자도 취하지 않으면서 `Void` 를 반환하는 `main` 타입 함수' 를 제공해야 합니다. 예를 들면 다음과 같습니다:

```swift
@main
struct MyTopLevel {
  static func main() {
    // 최상단 코드는 여기에 둡니다
  }
}
```

'`main` 특성의 필수 조건' 을 설명하는 또 다른 방식은 이 특성을 작성한 타입은 반드시 '다음의 가상 (hypothetical) 프로토콜을 준수하는 타입과 똑같은 필수 조건' 을 만족해야 한다는 것입니다:

```swift
protocol ProvidesMain {
    static func main() throws
}
```

실행 파일을 만들려고 컴파일하는 스위프트 코드는, [Top-Level Code (최상단 코드)]({% post_url 2020-08-15-Declarations %}#top-level-code-최상단-코드) 에서 논의한 것처럼, 최대 한 개의 '최상단 진입점' 을 담을 수 있습니다.

#### nonobjc (오브젝티브-C 아님)

이 특성은 '암시적인 `objc` 특성을 억제' 하기 위해 메소드, 속성, 첨자 연산, 또는 초기자 선언에 적용합니다. `nonobjc` 특성은 선언이, 오브젝티브-C 로 표현 가능할 지라도, 오브젝티브-C 코드에서 사용 불가능하게 만들라고 컴파일러에게 말하는 것입니다.

이 특성을 '익스텐션' 에 적용하면 '해당 익스텐션에서 명시적으로 `objc` 특성을 표시하지 않은 모든 멤버에 이를 적용한 것' 과 똑같은 효과입니다.

`nonobjc` 특성은 '`objc` 특성으로 표시한 클래스의 메소드 연동 (bridging) 에 대한 순환성 (circularity) 을 해결' 하기 위해, 그리고 '`objc` 특성으로 표시한 클래스의 메소드와 초기자 중복 정의 (overloading) 를 허용' 하기 위해 사용합니다.

'`nonobjc` 특성으로 표시한 메소드' 는 '`objc` 특성으로 표시한 메소드' 를 '재정의 (override)' 할 수 없습니다. 하지만, '`objc` 특성으로 표시한 메소드' 가 '`nonobjc` 특성으로 표시한 메소드' 를 재정의할 순 있습니다. 이와 비슷하게, '`nonobjc` 특성으로 표시한 메소드' 는 '`objc` 특성으로 표시한 메소드에 대한 프로토콜 필수 조건 (requirement)' 을 만족할 수 없습니다.

#### NSApplicationMain (NS 앱 메인)

이 특성은 '자신이 앱 대리자 (delegate) 임' 을 지시하기 위해 클래스에 적용합니다. 이 특성의 사용은 `NSApplicationMain(_:_:)` 함수의 호출과 '동치 (equivalent)' 입니다.

이 특성을 사용하지 않으면, 다음 처럼 최상단에서 `NSApplicationMain(_:_:)` 함수를 호출하는 코드를 가진 `main.swift` 파일을 공급합니다:[^NSApplicationMain]

```swift
import AppKit
NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
```

실행 파일을 만들려고 컴파일하는 스위프트 코드는, [Top-Level Code (최상단 코드)]({% post_url 2020-08-15-Declarations %}#top-level-code-최상단-코드) 에서 논의한 것처럼, 최대 한 개의 '최상단 진입점' 을 담을 수 있습니다.

#### NSCopying (NS 복사)

이 특성은 '클래스의 저장 변수 속성' 에 적용합니다. 이 특성은 '속성의 설정자 (setter)' 가 속성 자신의 값 대신-`copyWithZone(_:)` 메소드가 반환한-속성 값의 _복사본 (copy)_ 과 통합하도록 합니다. 속성의 타입은 반드시 `NSCopying` 프로토콜을 준수해야 합니다.

`NSCopying` 특성은 '오브젝티브-C 의 `copy` 속성 특성' 과 비슷한 식으로 동작합니다.

#### NSManaged (NS 관리)

이 특성은, '결합 개체 설명 (associated entity description)[^associated-entity-description] 을 기초로, 코어 데이터 (Core Data) 가 자신의 구현을 실행 시간에 동적으로 제공함' 을 지시하기 위해 `NSManagedObject` 를 상속한 클래스의 인스턴스 메소드나 저장 변수 속성에 적용합니다. `NSManaged` 특성으로 표시한 속성은, 실행 시간에 '코어 데이터' 가 '저장 공간 (storage)' 도 제공합니다. 이 특성을 적용하면 `objc` 특성임을 암시하는 것이기도 합니다.

#### objc (오브젝티브-C)

이 특성은 '오브젝티브-C 로 표현할 수 있는 어떤 선언'-예를 들어, 중첩 아닌 클래스, 프로토콜, (정수 원시-값 타입으로 구속한) 일반화 아닌 (nongeneric) 열거체, (획득자와 설정자를 포함한) 클래스의 속성과 메소드, 프로토콜의 프로토콜과 옵셔널 멤버, 초기자, 그리고 첨자 연산-에든 적용합니다. `objc` 특성은 선언이 오브젝티브-C 코드에서 사용 가능하다고 컴파일러에게 말하는 것입니다.

이 특성을 '익스텐션' 에 적용하면 '해당 익스텐션에서 명시적으로 `nonobjc` 특성을 표시하지 않은 모든 멤버에 이를 적용한 것' 과 같은 효과입니다.

컴파일러는 '오브젝티브-C 로 정의한 어떤 클래스의 하위 클래스' 에든 암시적으로 `objc` 특성을 추가합니다. 하지만, 하위 클래스는 반드시 '일반화 (generic)' 가 아니어야 하며, 반드시 '어떤 일반화 클래스' 도 상속하지 않아야 합니다. 이 기준에 부합하는 하위 클래스에는, 아래 논의한 것처럼 '자신의 오브젝티브-C 이름' 을 지정하기 위해, `objc` 특성을 명시적으로 추가할 수 있습니다. `objc` 특성을 표시한 프로토콜은 이 특성을 표시하지 않은 프로토콜을 상속할 수 없습니다.

`objc` 특성은 다음 경우에도 암시적으로 추가됩니다:

* 상위 클래스에서 `objc` 특성을 가진 선언을, 하위 클래스에서 '재정의 (override)' 한 경우
* `objc` 특성을 가진 프로토콜의 필수 조건을 만족하는 선언인 경우
* `IBAction`, `IBSegueAction`, `IBOutlet`, `IBDesignable`, `IBInspectable`, `NSManaged`, 또는 `GKInspectable` 특성을 가진 선언인 경우

`objc` 특성을 열거체에 적용하면, 각각의 '열거체 case 값' 은 '열거체 이름과 case 이름을 이어붙인 형태' 로 오브젝티드-C 코드에 노출됩니다. 'case 이름' 의 첫 글자는 대문자입니다. 예를 들어, 스위프트 `Planet` 열거체의 `venus` 라는 'case 값' 은 오브젝티브-C 에 `PlanetVenus` 라는 'case 이름' 으로 노출됩니다.

`objc` 특성은 옵션으로, '식별자 (identifier)' 로 구성한, 단일한 '특성 인자' 를 받습니다. 이 식별자는 '`objc` 특성을 적용할 개체 (entity)' 가 '오브젝티브-C 로 노출될 이름' 을 지정합니다. 이 인자는 클래스, 열거체, '열거체 case 값', 프로토콜, 메소드, 획득자, 설정자, 그리고 초기자의 이름을 짓는데 사용할 수 있습니다. 클래스, 프로토콜, 또는 열거체의 '오브젝티브-C 이름' 을 지정할 경우, [Programming with Objective-C](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011210) 의 [Conventions](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Conventions/Conventions.html#//apple_ref/doc/uid/TP40011210-CH10-SW1) 항목에서 설명한 것처럼, 이름에 '세-글자짜리 접두사 (three-letter prefix)' 를 포함합니다. 아래 예제는 '`ExampleClass` 의 `enabled` 속성에 대한 획득자' 를 속성 자신의 이름 보다는 `isEnabled` 로 오브젝티브-C 코드에 노출합니다.

```swift
class ExampleClass: NSObject {
  @objc var enabled: Bool {
    @objc(isEnabled) get {
      // 적절한 값을 반환합니다.
    }
  }
}
```

더 많은 정보는, [Importing Swift into Objective-C](https://developer.apple.com/documentation/swift/imported_c_and_objective-c_apis/importing_swift_into_objective-c) 항목을 참고하기 바랍니다.

> `objc` 특성의 인자는 해당 선언에 대한 '실행 시간 (runtime) 이름' 도 바꿀 수 있습니다. '실행 시간 이름' 은, [NSClassFromString](https://developer.apple.com/documentation/foundation/1395135-nsclassfromstring) 같이, '오브젝티브-C 런타임' 과 상호 작용하는 함수를 호출할 때와, 앱의 'Info.plist' 파일에 있는 '클래스 이름' 을 지정할 때, 사용합니다. 인자를 전달함으로써 이름을 지정하면, 해당 이름을 '오브젝티브-C 코드에 있는 이름' 인 것처럼 그리고 '실행 시간 이름' 인 것처럼 사용합니다. 인자를 생략하면, 오브젝티브-C 코드에서 사용하는 이름이 스위프트 코드의 이름과 일치하며, '실행 시간 이름' 은 스위프트 컴파일러의 일반적인 '이름 뭉개기 (name mangling) 협약' 을 따릅니다.

#### objcMembers (오브젝티브-C 멤버)

이 특성은, '클래스와, 그 익스텐션, 그리고 모든 하위 클래스 익스텐션에 있는 모든 오브젝티브-C 호환 가능 멤버에 암시적으로 `objc` 특성을 적용' 하기 위해 클래스 선언에 적용합니다.

대부분의 코드는, 필요한 선언만 노출하도록, `objc` 특성을 대신 사용해야 합니다. 많은 선언들을 노출할 필요가 있으면, `objc` 특성을 가진 '익스텐션' 으로 이를 그룹지을 수 있습니다. `objcMembers` 특성은 '오브젝티브-C 런타임의 내부 기능 (introspection facilities)' 을 아주 많이 쓰는 라이브러리의 편의를 위한 것입니다. 불필요할 때 `objc` 특성[^objc] 을 적용하면 '바이너리 크기가 증가' 하고 '성능에 불리한 영향' 을 줄 수 있습니다.

#### propertyWrapper (속성 포장)

이 특성은 '해당 타입을 속성 포장 (property wrapper) 으로 사용' 하기 위해 클래스, 구조체, 또는 열거체 선언에 적용합니다. 이 특성을 타입에 적용할 땐, 타입과 똑같은 이름의 '사용자 정의 특성' 을 생성하는 것입니다. 해당 새 특성을 클래스, 구조체, 또는 열거체 속성에 적용하면 '포장 타입 (wrapper type) 의 인스턴스를 통해 속성으로의 접근을 포장' 하며; '지역 저장 변수' 에 하면 똑같은 식으로 '변수로의 접근을 포장' 합니다. 계산 변수, 전역 변수, 그리고 상수에는 '속성 포장' 을 사용할 수 없습니다.

'포장 (wrapper)' 은 반드시 '`wrappedValue` 인스턴스 속성' 을 정의해야 합니다. 속성의 _포장 값 (wrapped value)_ 은 '이 속성의 획득자 (getter) 와 설정자 (setter) 가 노출하는 값' 입니다. 대부분의 경우, `wrappedValue` 는 '계산 값 (computed value)' 이지만, 대신 '저장 값 (stored value)' 일 수도 있습니다. '포장' 은 '자신의 포장 값에 필요한 어떤 실제 저장 공간' 도 정의하고 관리합니다. 컴파일러는 '포장 타입의 인스턴스에 대한 저장 공간' 을 '포장 속성의 이름 앞에 밑줄 (`_`) 접두사를 붙임' 으로써 통합합니다-예를 들어, `someProperty` 의 포장은 `_someProperty` 로 저장합니다. '포장의 통합 저장 공간' 은 `private` 접근 제어 수준을 가집니다.

속성 포장을 가진 속성은 `willSet` 과 `didSet` 블럭을 포함할 수 있지만, '컴파일러가-통합한 `get` 이나 `set` 블럭' 을 '재정의 (override)' 할 순 없습니다.

스위프트는 '속성 포장' 의 초기화를 위해 두 가지 형식의 '수월한 구문 (syntactic sugar)' 을 제공합니다. '포장 값' 정의에서 '할당 (assignment) 구문' 을 사용하면 할당의 오른-쪽 표현식을 '속성 포장' 초기자의 `wrappedValue` 매개 변수에 대한 인자로 전달할 수 있습니다. 특성을 속성에 적용할 때 인자를 제공할 수도 있으며, 이 인자들은 '속성 포장의 초기자' 로 전달됩니다. 예를 들어, 아래 코드에서, `SomeStruct` 는 `SomeWrapper` 가 정의한 각각의 초기자를 호출합니다.

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

포장 속성의 _내민 값 (projected value)_ 은 '속성 포장의 추가 기능을 노출하기 위해 사용' 할 수 있는 두 번째 값입니다. 속성 포장 타입의 작성자는 '자신이 내민 값의 의미를 결정' 하고 '내민 값을 노출하는 인터페이스를 정의' 할 책임이 있습니다. 속성 포장에서 값을 내밀려면, 포장 타입에 대해 `projectedValue` 인스턴스 속성을 정의합니다. 컴파일러는 '내민 값에 대한 식별자' 를 '포장 속성의 이름 앞에 달러 기호 (`$`) 접두사를 붙임' 으로써 통합합니다-예를 들어, '`someProperty` 가 내민 값' 은 `$someProperty` 입니다. '내민 값' 은 '원본 포장 속성' 과 똑같은 접근 제어 수준을 가집니다.

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

이 특성은 '해당 타입을 결과 제작자 (result builder) 로 사용' 하기 위해 클래스, 구조체, 열거체에 적용합니다. _결과 제작자 (result builder)_ 는 '중첩 자료 구조를 단계별로 제작하는 타입' 니다. '결과 제작자' 는 '중첩 자료 구조를 자연스러운, 선언 방식으로, 생성' 하기 위한 '특정-분야 언어 (domain-specific language; DSL) 을 구현' 하기 위해 사용합니다. `resultBuilder` 특성의 사용 방법에 대한 예제는, [Result Builders (결과 제작자)]({% post_url 2020-05-11-Advanced-Operators %}#result-builders-결과-제작자) 부분을 참고하기 바랍니다.

**Result-Building Methods (결과-제작 메소드)**

'결과 제작자' 는 아래 설명할 '정적 (static) 메소드' 를 구현합니다. 결과 제작자의 모든 기능은 정적 메소드를 통해 노출하기 때문에, 해당 타입의 인스턴스는 초기화를 항상 안합니다. `buildBlock(_:)` 메소드는 필수이며; 'DSL' 에 추가 기능을 부여하는-다른 메소드들은 옵션입니다. '결과 제작자 타입의 선언' 은 실제로 어떤 프로토콜 준수성도 포함하지 않아도 됩니다.

정적 메소드 설명은 세 개의 타입을 '자리 표시자 (placeholder)' 로 사용합니다. `Expression` 타입은 '결과 제작자의 입력 타입' 에 대한 자리 표시자이고, `Component` 는 '부분 결과 타입' 에 대한 자리 표시자이며, `FinalResult` 는 '결과 제작자가 만드는 결과의 타입' 에 대한 자리 표시자입니다. 이 타입들을 결과 제작자가 사용할 실제 타입으로 대체합니다. '결과-제작 메소드' 가 `Expression` 이나 `FinalResult` 타입을 지정하지 않으면, `Component` 와 똑같아 지는 것이 기본입니다.

'결과-제작 메소드' 는 다음과 같습니다:

`static func buildBlock(_ components: Compnent...) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;'부분 결과들의 배열' 을 '단일 부분 결과' 로 조합. '결과 제작자' 는 반드시 이 메소드를 구현해야 함.

`static func buildOptional(_ component: Compnent?) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;'`nil` 일 수 있는 부분 결과' 로 '부분 결과' 를 제작. `else` 절을 포함하지 않은 `if` 문을 지원하기 위해 이 메소드를 구현함.

`static func buildEither(first: Compnent) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;일부 조건에 따라 값이 변하는 '부분 결과' 를 제작. `else` 절을 포함하는 `switch` 문과 `if` 문을 지원하기 위해 이 메소드와 `buildEither(second:)` 둘 다를 구현함.

`static func buildEither(second: Compnent) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;일부 조건에 따라 값이 변하는 '부분 결과' 를 제작. `else` 절을 포함하는 `switch` 문과 `if` 문을 지원하기 위해 이 메소드와 `buildEither(first:)` 둘 다를 구현함.

`static func buildArray(_ components: [Compnent]) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;'부분 결과들의 배열' 로 '부분 결과' 를 제작. `for` 반복분을 지원하기 위해 이 메소드를 구현함.

`static func buildExpression(_ expression: Expression) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;'표현식' 으로 '부분 결과' 를 제작. 전처리 과정을 수행하거나-예를 들어, 표현식을 내부 타입으로 변환하기 등-사용자 쪽에 타입 추론에 대한 추가 정보를 제공하기 위해 이 메소드를 구현할 수 있음.

`static func buildFinalResult(_ component: Compnent) -> FinalResult`

&nbsp;&nbsp;&nbsp;&nbsp;'부분 결과' 로 '최총 결과' 를 제작. '부분과 최종 결과에 대해 서로 다른 타입을 사용하는 결과 제작자' 로, 또는 '반환 전의 결과에 또 다른 후처리 과정' 을 하기 위해, 이 메소드를 구현할 수 있음.

`static func buildLimitedAvailablility(_ component: Compnent) -> Component`

&nbsp;&nbsp;&nbsp;&nbsp;'사용 가능성을 검사하는 컴파일러-제어문 밖으로 타입 정보를 전파하거나 지우는 부분 결과' 를 제작. 조건 분기마다 변하는 타입 정보를 지우기 위해 이를 사용할 수 있음.

예를 들어, 아래 코드는 정수 배열을 제작하는 단순한 '결과 제작자' 를 정의합니다. 이 코드는, 위의 메소드 목록과 아래 예제가 일치하도록, `Component` 와 `Expression` 을 '타입 별명 (type aliases)' 으로 정의하여, 더 보기 쉽게 합니다.

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

'결과-제작자 구문을 사용한 코드' 를 '결과 제작자 타입의 정적 메소드를 호출하는 코드' 로 바꾸기 위해 다음의 구문 변형을 재귀적으로 적용합니다:

* 결과 제작자가 `buildExpression(_:)` 메소드를 가지고 있으면, 각각의 표현식은 해당 메소드 호출이 됩니다. 이 변형이 항상 첫 번째입니다. 예를 들어, 다음 선언들은 서로 '동치 (equivalent)' 입니다:

```swift
@ArrayBuilder var builderNumber: [Int] { 10 }
var manualNumber = ArrayBuilder.buildExpression(10)
```

* 할당문은 표현식인 것처럼 변형하지만, `()` 를 평가한다고 이해합니다.[^evaluate] 할당을 특수하게 처리하기 위해 `()` 타입의 인자를 취하는 `buildExpression(_:)` 을 '중복 정의 (overload)' 할 수 있습니다.

* '사용 가능성 조건을 검사하는 분기문' 은 `buildLimitedAvailablility(_:)` 메소드 호출이 됩니다. 이 변형은 `buildEither(first:)`, `buildEither(second:)`, 또는 `buildOptional(_:)` 호출로의 변형 전에 발생합니다. `buildLimitedAvailablility(_:)` 메소드는 '어느 분기를 취하는 지에 따라 바뀌는 타입 정보' 를 지우고자 사용합니다. 예를 들어, 아래의 `buildEither(first:)` 와 `buildEither(second:)` 메소드는 '분기 둘 다의 타입 정보를 붙잡는 일반화 (generic) 타입' 을 사용합니다.

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

하지만, 이런 접근 방식은 '사용 가능성 검사 코드' 에서 문제를 유발합니다:

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

위 코드에서, `brokenDrawing` 의 타입에 `FutureText` 가 있는데 이것도 `DrawEither` 라는 '일반화 (generic) 타입' 의 한 타입이기 때문입니다. 이는, 해당 타입을 명시적으로 사용하지 않는 경우라도, 실행 시간에 `FutureText` 가 사용 가능하지 않으면 프로그램 충돌을 유발할 수 있습니다.

이 문제를 풀려면, `buildLimitedAvailability(_:)` 메소드를 구현하여 타입 정보를 지웁니다. 예를 들어, 아래 코드는 '자신의 사용 가능성 검사' 로부터 `AnyDrawable` 값을 제작합니다.

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

* 분기문은 `buildEither(first:)` 와 `buildEither(second:)` 를 '연속으로 중첩한 호출' 들이 됩니다. '구문 조건과 case 값' 들은 '이진 트리 (binary tree)' 의 '잎 노드 (leaf nodes)' 에 대응하며, '구문' 은 '뿌리 노드 (root node) 에서 해당 잎 노드로의 경로' 를 따라가는 `buildEither` 메소드의 '중첩 호출' 이 됩니다.

예를 들어, '세 개의 case 절을 가진 switch 문' 을 작성하면, 컴파일러가 '세 개의 잎 노드를 가진 이진 트리' 를 사용합니다. 마찬가지로, '뿌리 노드에서 두 번째 case 절로의 경로' 는 "두 번째 자식" 인 다음 "첫 번째 자식" 이기 때문에, '해당 case 절' 은 `buildEither(first: buildEither(second: ...))` 와 같은 '중첩 호출' 이 됩니다. 다음 선언은 서로 '동치 (equivalent)' 입니다:  

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

* `else` 절 없는 `if` 문 같이, 값을 만들지 않을 지도 모를 분기문은, `buildOptional(_:)` 호출이 됩니다. `if` 문 조건을 만족하면, 자신의 코드 블럭을 변형하여 인자로 전달하며; 그 외 경우, `nil` 인자로 `buildOptional(_:)` 을 호출합니다. 예를 들어, 다음 선언은 서로 '동치' 입니다:

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

* 코드 블럭이나 `do` 문은 `buildBlock(_:)` 메소드 호출이 됩니다. 블럭 안의 각 구문이, 한번에 하나씩, 변형되어, `buildBlock(_:)` 메소드의 인자가 됩니다. 예를 들어, 다음 선언은 서로 '동치' 입니다:

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

* `for` 반복문은 '임시 변수[^temporary-variable] 와, `for` 반복문, 그리고 `buildArray(_:)` 메소드 호출' 이 됩니다. 새로운 `for` 반복문이 '시퀀스 (sequence)' 를 반복하며 '각각의 부분 결과' 를 해당 배열에 덧붙입니다. 이 임시 배열을 `buildArray(_:)` 호출에 대한 인자로 전달합니다. 예를 들어, 다음 선언은 서로 '동치' 입니다:

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

* 결과 제작자가 `buildFinalResult(_:)` 메소드를 가지고 있으면, '최종 결과' 는 '해당 메소드에 대한 호출' 이 됩니다. 이 변형이 항상 마지막입니다.

변형 동작을 임시 변수라는 용어로 설명하긴 하지만, 결과 제작자가 실제로 눈에 보이는 어떤 새로운 선언을 코드에 생성하진 않습니다.

결과 제작자가 변형하는 코드에 `break`, `continue`, `defer`, `guard`, 나 `return` 문, `while` 문, 또는 `do`-`catch` 문을 사용할 수 없습니다.

변형 과정은 코드에서, 표현식을 조각 조각 제작하는 임시 상수와 변수를 사용하게 해주는, 선언을 바꾸지 않습니다. 이는 `throw` 문, 컴파일-시간 진단 (diagnostic) 문, 또는 '`return` 문을 담은 클로저' 도 바꾸지 않습니다.

가능할 때마다, 변형을 합체합니다. 예를 들어, `4 + 5 * 6` 라는 표현식은 '해당 함수를 여러 번 호출' 하기 보다는 `buildExpression(4 + 5 * 6)` 가 됩니다. 마찬가지로, 중첩 분기문은 `buildEither` 메소드를 호출하는 '단일 이진 트리' 가 됩니다.

**Custom Result-Builder Attributes (사용자 정의 결과-제작자 특성)**

'결과 제작자 타입' 의 생성은 똑같은 이름의 '사용자 정의 특성' 을 생성합니다. 해당 특성은 다음 장소에 적용할 수 있습니다:

* 함수 선언에서, 결과 제작자는 함수 본문을 제작합니다.
* 획득자를 포함하는 변수나 첨자 연산에서, 결과 제작자는 획득자 본문을 제작합니다.
* 함수 선언의 매개 변수에서, 결과 제작자는 관련 인자로 전달한 클로저 본문을 제작합니다.

결과 제작자 특성의 적용은 'ABI 호환성' 에 충격을 주지 않습니다. 결과 제작자 특성을 매개 변수에 적용하면 해당 특성이 함수 인터페이스 일부가 되어, '소스 호환성' 에 영향을 줄 수 있습니다.

#### requires_stored_property_inits (저장 속성의 초기화를 필수로 요구함)

이 특성은 '클래스 안의 모든 저장 속성이 자신의 정의에서 '기본 값' 을 제공할 것을 요구' 하기 위해 클래스 선언에 적용합니다. `NSManagedObject` 를 상속한 어떤 클래스든 이 특성이 (있다고) 추론합니다.

#### testable (테스트 가능한)

이 특성을 `import` 선언에 적용하면 해당 모듈을 불러올 때 이 모듈 코드의 테스트를 단순화하도록 접근 제어를 바꿉니다. 불러오는 모듈에서 `internal` 접근-수준 수정자로 표시된 '개체 (entities)' 들은 마치 `public` 접근-수준 수정자로 선언한 것처럼 불러옵니다. `internal` 또는 `public` 접근-수준 수정자로 표시한 클래스와 클래스 멤버는 마치 `open` 접근-수준 수정자로 선언한 것처럼 불러옵니다. 불러온 모듈은 반드시 테스트를 할 수 있게한 상태에서 컴파일해야 합니다.

#### UIApplicationMain (UI 앱 메인)

이 특성을 클래스에 적용하면 이것이 '응용 프로그램 대리자 (application delegate)' 임을 지시합니다. 이 특성을 사용하는 것은 `UIApplicationMain` 함수를 호출하고 이 클래스 이름을 '대리자 클래스 (delegate)' 이름으로 전달하는 것과 '동치 (equivalent)' 입니다.

이 특성을 사용하지 않는 경우, [UIApplicationMain(_:_:_:_:)](https://developer.apple.com/documentation/uikit/1622933-uiapplicationmain) 함수를 호출하는 '최상단 코드' 를 가진 `main.swift` 파일을 제공하도록 합니다. 예를 들어, 앱에서 사용자가 정의한 `UIApplication` 의 하위 클래스를 '주 클래스 (principal class)' 로 사용할 경우, 이 특성을 사용하는 대신 `UIApplicationMain(_:_:_:_:)` 함수를 호출하도록 합니다.

실행 파일을 만들려고 컴파일하는 스위프트 코드는, [Top-Level Code (최상단 코드)]({% post_url 2020-08-15-Declarations %}#top-level-code-최상단-코드) 에서 설명한 것처럼, '최상단 진입점' 을 최대 한 개만 가질 수 있습니다.

#### usableFromInline (인라인에서 사용 가능한)

이 특성을 함수, 메소드, 계산 속성, 첨자 연산, 초기자, 또는 '정리자 (deinitilaizer)' 선언에 적용하면 그 선언과 같은 모듈에서 정의한 인라인 가능한 코드에서 해당 기호를 사용하는 것을 허용합니다. 그 선언은 반드시 `internal` 접근 수준 수정자를 가져야 합니다. `usableFromInline` 으로 표시한 구조체나 클래스는 그 속성들이 '공용 (public)' 또는 `usableFromInline` 인 타입만 사용할 수 있습니다. `usableFromInline` 으로 표시한 열거체는 그 'case 의 원시 값' 과 '결합 값' 이 '공용 (public)' 또는 `usableFromInline` 인 타입만 사용할 수 있습니다.

`public` 접근 수준 수정자와 마찬가지로, 이 특성은 선언을 모듈의 '공개 인터페이스 (public interface)' 로 노출합니다. `public` 과는 달리, 컴파일러는 `usableFromInline` 으로 표시한 선언이, 그 선언의 기호를 밖으로 내보내더라도, 모듈 외부의 코드에서 이름으로 참조하는 것을 허용하지 않습니다. 하지만, 모듈 외부의 코드는 '실행 시간 동작 (runtime behavior)' 를 사용함으로써 여전히 그 선언의 기호와 상호 작용할 수도 있습니다.

`inlinable` 특성으로 표시한 선언은 암시적으로 '인라인 가능한 코드 (inlinable code)' 에서 사용 가능합니다. `inlinable` 또는 `usableFromInline` 은 각각 `internal` 선언에 적용할 수 있다하더라도, 두 특성을 모두 적용하는 것은 에러입니다.

#### warn_unqualified_access (조건을 갖추치 않은 접근 경고하기)

이 특성을 최상단 함수, 인스턴스 메소드, 또는 클래스 메소드나 정적 메소드에 적용하면 해당 함수나 메소드가 모듈 이름, 타입 이름, 또는 인스턴스 변수나 인스턴스 상수 같은, '선행 자격자 (preceding qualifier)' 없이 사용할 때 경고를 일으킵니다. 이 특성을 사용하면 같은 이름을 가진 함수가 동일한 영역에서 접근 가능할 때의 모호함을 방지할 수 있습니다.

예를 들어, 스위프트 표준 라이브러리는 최상단의 `min(_:_:)` 함수와 비교 가능한 원소를 가지는 '시퀀스 (sequence; 수열)' 에 대한 `min()` 메소드 둘 다를 포함하고 있습니다. 이 '시퀀스' 메소드는 `warn_unqualified_access` 특성으로 선언하여 `Sequence` '익스텐션' 내에서 둘 중 하나를 사용하려고 할 때의 혼동을 줄이도록 해줍니다.

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

[^associated-entity-description]: '결합 개체 설명 (associated entity description)' 은 '엑스코드 (Xcode)' 의 `*.xcdatamodeld` 파일에서 만드는 '데이터베이스 개요 (database schema)' 를 의미합니다. 여기서의 '개체 (entity)' 는 '다른 데이터베이스 언어의 테이블 (table)' 에 해당합니다.

[^objc]: '오브젝티브-C' 의 기능을 아주 많이 쓰면, 호환성을 위해 `objc` 를 남발하게 될텐데, 이 때의 비효율성을 줄이기 위해 `objcMembers` 특성을 사용한다고 이해할 수 있습니다. 

[^calling-convention]: 스위프트의 '호출 협약 (calling conventions)' 에 대한 더 자세한 정보는 '깃허브 (GitHub)' 의 '애플 (Apple)' 저장소에 있는 [The Swift Calling Convention](https://github.com/apple/swift/blob/main/docs/ABI/CallingConvention.rst) 문서를 참고하기 바랍니다.

[^temporary-variable]: 이 세 개 중에서 '임시 변수' 는, 바로 이어서 설명하는 것처럼, '배열' 입니다.

[^dynamic-callable]: '동적으로 호출 가능 (dynamicCallable) 특성' 은 C++ 언어의 '함수 객체 (function object)' 와 개념이 유사합니다. 함수 객체에 대한 더 자세한 정보는, 위키피디아의 [Function object](https://en.wikipedia.org/wiki/Function_object) 항목을 참고하기 바랍니다. 사실 스위프트에는 클로저가 있기 때문에 특수한 목적이 아니라면 직접 `dynamicCallable` 특성을 사용할 일이 거의 없을 것입니다.  

[^dynamic-member-lookup]: '동적으로 멤버 찾아보기 (dynamicMemberLookup)' 은 스위프트에서 'Core Data' 나 'JSON' 을 다룰 때 사용하게 되는 것 같습니다.

[^NSApplicationMain]: `NSApplicationMain` 을 사용하는 방식들은 다 예전 방식입니다. 최신 'SwiftUI' 를 사용할 경우 `@main` 을 기본으로 사용하기 때문에, `NSApplicationMain` 특성이나 `main.swift` 파일을 사용할 일이 없습니다.

[^evaluate]: 할당문의 경우 `buildExpression(_:)` 의 `()` 를 평가한 결과를 사용한다는 의미입니다.
