---
layout: post
comments: true
title:  "Swift 3.0: 연결된 클로져 표기법"
date:   2016-06-21 17:30:00 +0900
categories: Swift Grammar Expressions Closures
---

WWDC 2016 동영상을 보기 시작하고 있습니다.[^WWDC_Videos] 동영상이 너무 많아서 다 보기는 힘들 것 같아서 우선 비교적 쉬어보이는 동영상부터 보고 있습니다.


맨 처음에는 [Getting Started with Swift](https://developer.apple.com/videos/play/wwdc2016/404/)라는 영상으로 시작했는데, 전체 내용은 [The Swift Programming Language](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/index.html)의 [A Swift Tour](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/GuidedTour.html#//apple_ref/doc/uid/TP40014097-CH2-ID1) 수준이라 보기에 무난하지만, 그래도 인상적인 부분이 있어서 간단하게 정리합니다.

### 연결된 클로져 표기법

스위프트(Swift)에서 `map(_:)`[^Function_Expressions]과 같이 클로져(Closures)를 인자로 받는 함수들을 사용하다보면 표기법이 약간 애매해지는 경우가 있습니다.  

클로져를 인자로 받는 함수들은 괄호의 중복을 막기위해 trailing closure 문법을 사용해서 마지막 중괄호를 밖으로 뺄 수 있습니다.  
문제는 이렇게 하면 `map(_:)`류 함수들을 여러번 연이어서 호출할 경우 클로져가 이어져서 뭔가 표기법이 이상해진다는 점입니다.[^Closure_Argument]

제가 만들어봤던 예제를 참고하여 설명하겠습니다.

```swift
let itemsSum = self.map({ $0.sum }).reduce(0, combine: +)
```

위의 코드는 전에 만들었던 코드인데,[^My_Code] 보통 위와 같이 이어서 사용되게 됩니다. 실제로 예제를 만들면서도 가독성이 조금 떨어진다고 생각했었습니다.

사실 위의 코드는 아래처럼 써도 되는데, 아래의 코드가 더 이상한 것 같아서 일부러 괄호를 없애지 않았습니다. 왜냐면, 중괄호 다음에 연이어서 닷(`.`) 기호가 오는 것이 어색했기 때문입니다.

```swift
let itemsSum = self.map { $0.sum }.reduce(0, combine: +)
```

애플에서도 이 호출 구문이 이상하다고 느껴져서인지, 아래와 같이 사용하는 것을 알게 되었습니다.[^Dot_Notation]

```swift
let itemsSum = self.map { $0.sum }
                   .reduce(0, combine: +)
```

위처럼 줄을 바꾸면서 닷(`.`) 기호를 기준으로 정렬하는 것이 가독성도 좋은 것 같고, 일단 뭔가 파이프라인을 통과하면서 데이터가 바뀌고 있다는 것을 명시적으로 보여주는 것 같아서 인상적이었습니다.

이 포스팅을 하면서 찾아보니까, **The Swift Programming Launguage** 책의 Expressoins 장에서도 사용하고 있는 것을 볼 수 있었습니다.[^Expressions_Chapter]

### 고찰하기

RayWenderich 사이트에서 Swift 코딩 스타일 가이드를 잘 정리해서 GitHub에 공개한 글이 있습니다.[^RayWenderich]

그 글에도 Closure Expressions 부분에 제가 고민한 내용이 이미 정리되어 있는 것 같습니다. 물론 어떻게 하든 작성자의 맘이라고 결론 짓기는 했지만요. 역시 누구나 생각하는 것은 비슷한 것 같습니다.

언젠가 RayWenderich 의 Swift 스타일 가이드도 정리를 해 볼 생각입니다.

보통 이러한 비교 함수들을 Predicate라고 하는 것 같습니다. 이 부분은 좀 더 정리할 예정입니다.

### 참고 자료

[^Dot_Notation]: `map(_:)` 류의 함수들을 위한 닷 표기법은 WWDC 2016의 [Getting Started with Swift](https://developer.apple.com/videos/play/wwdc2016/404/) 영상 후반부에 나옵니다.

[^My_Code]: 얼마전에 쓴 [Protocol Programming과 관련된 글](http://xho95.github.io/swift/grammar/protocol/constraints/2016/03/03/Adding-Constraints-to-Protocol-Extensions.html)을 쓰면서 만든 예제입니다. [Gist](https://gist.github.com)에도 [ProtocolExtensionConstraints.swift](https://gist.github.com/xho95/3ce1e821852d0debf646)라는 코드로 올렸었습니다.

[^Expressions_Chapter]: 위의 표기법은 The Swift Programming Language 책에서 [Expressions](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/Expressions.html#//apple_ref/doc/uid/TP40014097-CH32-ID383) 장의 Explicit Member Expression 절에 있습니다.

[^RayWenderich]: [The Official raywenderlich.com Swift Style Guide.](https://github.com/raywenderlich/swift-style-guide)

[^WWDC_Videos]: 애플 Developer 사이트의 [WWDC 2016 Videos](https://developer.apple.com/videos/wwdc2016/)에 가시면 WWDC 2016에서 발표된 모든 동영상을 볼 수 있습니다. 참고로 [이곳](https://developer.apple.com/videos/)에 가면 WWDC를 비롯한 모든 애플 관련 동영상을 볼 수 있습니다.

[^Function_Expressions]: 앞으로 가능한한 함수의 표기법은 애플의 reference에 나온 것과 같이 인자 타입도 표시하는 방식의 표기법을 따르려고 합니다.

[^Closure_Argument]: 경험에 의하면 `map(_:)` 처럼 클로져를 인자로 받는 함수들은 단독으로 사용되기 보다 연이어서 사용되는 경우가 많은 것 같습니다. 아마도 클로져가 적용된 결과를 다시 또
다른 리스트로 반환하기 때문인 것 같습니다.
