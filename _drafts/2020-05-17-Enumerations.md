---
layout: post
comments: true
title:  "Swift 5.2: Enumerations (열거체)"
date:   2020-05-16 10:00:00 +0900
categories: Swift Language Grammar Error Handling
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Error Handling](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 부분[^Enumerations]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Enumerations (열거체)

_열거체 (enumerations)_ 는 관계있는 값 그룹에 '공통 타입' 을 정의하여 이 값들을 코드에서 '타입-안전한 (type-safe)'[^type-safe] 방법으로 사용할 수 있게 해 줍니다.

C 언어에 익숙하다면, C 언어의 열거체는 관계된 이름들에 일종의 정수 값을 할당한다는 것을 알고 있을 것입니다. 스위프트의 열거체는 훨씬 더 유연해서, 열거체의 각 '경우 값 (cases)' 에 값을 제공할 필요도 없습니다. 각 열거체 '경우 값 (case)' 에 값을 제공할 경우 (이를 _원시 값 (raw value)_ 이라 합니다), 이 값은 '문자열 (string)', '문자 (character)', 또는 '정수 (integer)' 나 '부동-소수점 (float-point)' 타입 어떤 것이든 될 수 있습니다.

또 다른 방법으로, 열거체의 '경우 값 (cases)' 에는 각 '경우 값' 에 따라 달리 저장되는 '결합된 값 (associated values)' 이라는 것을 _어떤 (any)_ 타입에 대해서든 지정할 수 있어서, 다른 언어에 있는 '유니온 (unions)' 또는 '변형체 (variants)' 와 흡사한 것을 만들 수 있습니다. 관계된 '경우 값들 (cases)' 의 공통 집합을 하나의 열거체로 정의하면서, 제각각 이에 결합된 적당한 타입의 서로 다른 값 집합을 가지도록 정의할 수 있습니다.

스위프트의 열거체는 그 자체로 '일급 타입 (first-class types)'[^first-class] 입니다. 전통적으로 클래스에서만 지원하던 많은 특징들을 채택했는데, 열거체의 현재 값에 대한 추가적인 정보를 제공하는 '계산 속성 (computed properties)', 열거체가 표현할 값과 관계된 기능을 제공하는 '인스턴스 메소드 (instance methods)' 등이 이에 해당합니다. 열거체에는 '초기자' 를 정의해서 '초기 경우 값 (initial case value)' 도 제공할 수 있습니다; 기능을 확대해서 원래 구현 이상으로 확장할 수도 있습니다; 프로토콜을 준수해서 표준 기능을 제공할 수도 있습니다.

이러한 '기능들 (capabilities)' 에 대한 더 자세한 내용은, [Properties (속성)]({% post_url 2020-05-30-Properties %}), [Methods (메소드)]({% post_url 2020-05-03-Methods %}), [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}), [Extensions (확장)]({% post_url 2016-01-19-Extensions %}), 그리고 [Protocols (규약)]({% post_url 2016-03-03-Protocols %}) 을 참고하기 바랍니다.

### Enumeration Syntax (열거체 구문 표현)

열거체를 도입하려면 `enum` 키워드를 사용하며 중괄호 쌍 안에 전체 정의를 작성하면 됩니다:

```swift
enum SomeEnumeration {
  // 여기에서 열거체를 정의합니다.
}
```

다음은 '나침반 (compass)' 의 네 가지 주요 지점을 나타내는 예제입니다:

```swift
enum CompassPoint {
  case north
  case south
  case east
  case west
}
```

열거체에서 정의한 값들 (가령 `north`, `south`, `east`, 그리고 `west`) 은 _열거체 경우 값 (enumeration cases)_ 입니다. `case` 키워드를 사용하여 새로운 '열거체 경우 값' 을 도입할 수 있습니다.

> 스위프트의 '열거체 경우 값' 은 기본적으로 정수 값으로 설정되지 않으며, 이는 C 언어와 오브젝티브-C 언어와는 다른 점입니다. 위의 `CompassPoint` 예제에 있는, `north`, `south`, `east`, 그리고 `west` 는 암시적으로 `0`, `1`, `2`, 및 `3` 이 되지 않습니다. 그 대신, 서로 다른 '열거체 경우 값' 그 자체가 '값 (values)' 이며, 명시적으로 정의한 `CompassPoint` 가 그 타입입니다.

여러 '경우 값' 을, 쉼표로 구분하여, 한 줄로 나타낼 수 있습니다:

```swift
enum Planet {
case mercury, venus, earth, mars, jupiter, saturn uranus, neptune
}
```

각각의 열거체 정의는 새로운 타입을 정의합니다. 스위프트의 다른 타입들과 마찬가지로, 이 이름 (가령 `CompassPoint` 와 `Planet` 등) 은 대문자로 시작합니다. 열거체의 타입은, 자명하게 이해되도록, 복수형 이름이 아니라 단수형을 부여하도록 합니다:

```swift
var directionToHead = CompassPoint.west
```

`directionToHead` 의 타입은 `CompassPoint` 중 한 가지 값으로 초기화될 때 추론됩니다. `directionToHead` 가 한번 `CompassPoint` 로 선언되고 나면, '단축 점 구문 표현 (shorter dot syntax)' 을 사용하여 다른 `CompassPoint` 값을 설정할 수 있습니다:

```swift
directionToHead = .east
```

`directionToHead` 의 타입을 이미 알고 있으므로, 값을 설정할 때 타입을 뺄 수 있습니다. 이는 명시적으로 타입을 지정한 열거체의 값과 작업할 때 아주 가독성 높은 코드를 만들도록 해 줍니다.

### Matching Enumeration Values with a Switch Statement ('switch' 문으로 열거체 값 맞춰보기)

개별 열거체 값은 `switch` 문으로 맞춰볼 수 있습니다:

```swift
directionToHead = .south
switch directionToHead {
case .north:
  print("Lots of planets have a north")
case .south:
  print("Watch out for penguins")
case .east:
  print("Where the sun rises")
case .west:
  print("Where the skies are blue")
}
// "Watch out for penguins" 를 출력합니다.
```

이 코드는 다음 처럼 이해할 수 있습니다.

“`directionToHead` 의 값을 검토합니다. `.north` 와 같은 경우에는, `"Lots of planets have a north"` 를 출력합니다. `.south` 와 같은 경우에는, `"Watch out for penguins"` 을 출력합니다.

...이렇게 계속됩니다.

[Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 에서 설명한 것 처럼, 열거체의 '경우 값' 을의 검토할 때 `switch` 문은 반드시 '빠짐없이 철저해야 (exhaustive)' 합니다. 만약 `.west` 에 대한 `case` 를 생략하면, 이 코드는 컴파일되지 않는데, `CompassPoint` '경우 값들' 에 해당하는 전체 목록을 다 검토하지 않기 때문입니다. 빠짐없이 철처할 것을 요구하는 것은 열거체의 '경우 값' 을 우연히 생략하지 않도록 보장합니다.

모든 열거채의 '경우 값' 에 대해 `case` 를 제공하는 것이 적절하지 않을 때는, `default` '경우 값' 을 제공해서 명시적으로 알리지 않은 '경우 값' 이라면 어떤 것도 다루도록 할 수 있습니다:

```swift
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
  print("Mostly harmless")
default:
  print("Not a safe place for humans")
}
// "Mostly harmless" 를 출력합니다.
```

### Iterating over Enumeration Cases (열거체 경우 값에 대해 동작 반복 적용하기)

어떤 열거체에서는, 열거체의 모든 '경우 값들' 에 대한 '집합체 (collection)' 을 가지는 것이 유용할 수 있습니다. 이렇게 하려면 열거체의 이름 뒤에 `: CaseIterable` 을 붙여주도록 합니다. 스위프트는 해당 열거체 타입의 모든 '경우 값들' 을 위한 '집합체' 를 `allCases` 라는 속성으로 드러냅니다. 예를 들면 다음과 같습니다:

```swift
enum Beverage: CaseIterable {
case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// "3 beverages available" 를 출력합니다.
```

위 예제에서는, `Beverage.allCases` 를 써서 `Beverage` 열거체의 모든 '경우 값' 을 담고 있는 '집합체 (collection)' 에 접근합니다. `allCase` 는 다른 모든 '집합체' 들 처럼 사용할 수 있는데-이 집합체의 원소는 열거체 타입의 인스턴스라서, 이 경우에는 `Beverage` 값이 됩니다. 위 예제는 '경우 값' 얼마나 많이 있는 지를 계산하며, 아래 예제는 `for` 반복문을 사용하여 모든 '경우 값' 들에 동작을 반복 적용합니다.

```swift
for beverage in Beverage.allCases {
  print(beverage)
}
// coffee
// tea
// juice
```

위 예제에서 사용한 구문 표현은 열거체가 [CaseIterable](https://developer.apple.com/documentation/swift/caseiterable) 프로토콜을 준수하도록 표시한 것입니다. 프로토콜에 대한 정보는, [Protocols (규약)]({% post_url 2016-03-03-Protocols %}) 을 참고하기 바랍니다.

### Associated Values (관련 값; 결합 값)

### Raw Values (원시 값)

#### Implicitly Assigned Raw Values (암시적으로 할당되는 원시 값)

#### Initializing from a Raw Value (원시 값으로 초기화하기)

### Recursive Enumerations (재귀적인 열거체)

### 참고 자료

[^Enumerations]: 이 글에 대한 원문은 [Enumerations](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) 에서 확인할 수 있습니다.

[^type-safe]: 여기서 '타입-안전한 방식 (type-safe way)' 이라는 것은 스위프트가 기본적으로 제공하는 '타입 추론 (type inference)' 과 '타입 검사 (type check)' 기능을 사용할 수 있다는 것을 의미합니다. 이 내용은 [The Basic (기초)]({% post_url 2016-04-24-The-Basics %}) 부분의 [Type Safety and Type Inference (타입 안전 장치와 타입 추론 장치)]({% post_url 2016-04-24-The-Basics %}#type-safety-and-type-inference-타입-안전-장치와-타입-추론-장치) 에서 설명한 바 있습니다.

[^first-class]: 프로그래밍에서 '일급 (first-class)' 이라는 말은 특정 대상을 '객체' 와 동급으로 사용할 수 있다는 것을 의미합니다. 예를 들어 '객체' 처럼 인자로 전달할 수도 있고, 함수에서 반환할 수 있으며, 다른 변수 등에 할당할 수도 있는 대상이 있다면 이 대상을 '일급 (first-class)' 이라고 합니다. 이에 대한 보다 자세한 내용은 위키피디아의 [First-class citizen](https://en.wikipedia.org/wiki/First-class_citizen) 과 [일급 객체](https://ko.wikipedia.org/wiki/일급_객체) 항목을 참고하기 바랍니다.
