---
layout: post
comments: true
title:  "Swift 3.0: 커리 함수 선언 구문의 생략"
date:   2016-02-12 20:30:00 +0900
categories: Xcode Swift Currying Evolution
---

최근에 Apple에서 제공하는 **The Swift Programming Language** 문서의 2.2 버전을 보게 되었는데 커리 함수(Curried Function)에 대한 설명이 빠진 것을 볼 수 있었습니다. 관련 자료를 살펴보니 Swift 3.0에서는 커리 함수를 선언하는 문법에 변화가 있다고 합니다.[^Prerelease]

여기서는 Swift 3.0에서 바뀌게 될 커리 함수의 선언 방식에 대해 GitHub에 있는 원문을 번역해서 정리합니다. 참고로 다음 버전에 반영될 Swift의 문법 변화는 GitHub의 [apple/swift-evolution](https://github.com/apple/swift-evolution)에 가면 살펴볼 수 있습니다.[^Evolution]


### 소개

(이전) Swift에서 커리 함수는 `func foo(x: Int)(y: Int)`와 같이 선언했습니다. 이 문법은 사용하기에 번거롭고 용어도 헷갈리며 구현이 복잡합니다. 따라서 제거해야 합니다.


### 동기

지금의 커리 함수 구문은 언어의 다른 특성들과 복잡하게 얽혀서 연쇄적인 영향을 끼칩니다.:

* 지금의 커링 방식은 키워드 규칙과 함수의 선언명에 혼란을 일으킵니다. 커리 함수의 인자만 보더라도 논쟁이 될 수 밖에 없는 것이 함수 인자들의 연속인지, 함수에 대한 인자 리스트의 시작인지, 아니면 아예 다른 규칙들을 따르도록 한 것인지 애매합니다.

* (지금의 커링 방식은) `var`와 `inout` 인자 주석(annotations)과도 얽혀 있습니다. 커리 함수가 `inout` 매개 변수를 가질 경우 이 변수가 첫번째 구절에 있지 않을 경우 부분 적용(partially applied)이 되지 않습니다. 이는 어쩌면 당연한 문법상의 제약인데, 활용도를 떨어뜨리게 됩니다. `var` 매개 변수의 경우에는, `var`의 범위가 미치는 레벨이 의문스럽습니다.; 많은 사용자들이 최외곽의 부분 적용(partial application)까지일 것이라 예상하지만, 현재는 가장 안쪽의 부분 적용까지만입니다.  

기존의 표준 라이브러리, Cocoa, 그리고 대부분의 써드-파티 코드를 쓰게 되면 ML-스타일의 인자 커링으로 비멤버 함수(free functions)를 사용하는 이점이 없어집니다.[^Free-Function] Cocoa와 표준 라이브러리에서는, 대부분 멤버 함수들만이, 여전히 유용하게 부분 적용을 쓸 수 있는데, 이 때 `self.method`나 또는 구현되어 있을 경우 `.map { f($0) }`을 쓰면 됩니다. 게다가 커리 함수 방식은 키워드를 인자에 붙여서 표시하는 방식(keyword argument model)보다도 진보적인 것입니다. 인자는 하나의 튜플이라는 모델 역시 폐기할 것으로(이것은 지금껏 `@autoclosure`와 `inout`과 같은 것으로 속여왔던 것입니다.), 지금껏 ML 인자 모델을 더 벗어나게 만들었던 것들입니다.

많은 사용자들이 살펴본 바 지금의 커링 방식은 쓰잘떼기 없으며, 차라리 `f(_, 1)`처럼 Scala 방식의 부분 적용 구문을 쓰자고 하는 형편입니다. 이미 함수형 언어에 익숙한 사용자들은 지금의 커링 방식에 별 관심조차 없어서, 마치 없는게 더 낫다고 여기는 듯 합니다. "만약 없다면 추가해야 할 것이다."라는 테스트는 명백히 실패한 것으로 보입니다.  


### 세부 디자인

우리는 `func` 선언의 다중 인자 패턴을 없애고, `func-구문`의 문법을 간소화하여, 하나의 인자 구절만을 가지도록 했습니다. 코드 이전을 위해서, 기존 코드에서 사용한 커리 선언 구문은 명시적으로 closure를 반환하는 구문으로 변환할 수 있습니다.:      

```swift
// Before:
func curried(x: Int)(y: String) -> Float {
  return Float(x) + Float(y)!
}

// After:
func curried(x: Int) -> (String) -> Float {
  return {(y: String) -> Float in
    return Float(x) + Float(y)!
  }
}
```

문법의 변화가 의미상의 변화를 의미하지는 않도록 했으며, 함수의 타입은 `Self -> Args -> Return`으로 그대로 유지됩니다.


### 기존 코드에 미칠 충격

이러한 변경은 언어의 특성을 제거하는 것이므로, 기존 코드가 깨지는 문제가 발생할 겁니다. 하지만 커링은 비교적 주변 기술이고, 신생 언어에서 쓰기에는 거슬리기도 하며, 자동 수정 기능이 잘 작동하므로, 언어를 단순하게 하는 것이 가져올 충격은 미미할 것으로 봅니다.[^Translation]


### 대안으로 고려해볼 사항들

대안이라면 커링을 있는 그대로 유지하는 것이겠지만, 이는 위에서 논의한 바와 같이 이상적이진 않습니다. 비록 당장 바꿔야 한다고 제안하는 것은 아니지만, 앞으로 고려할만한 대안은 유사한 기능을 좀 더 수월하게 사용하도록 다음을 포함할 수 있겠습니다.:

* Scala 방식의 특수 부분 적용 구문, 가령 `foo(_, bar: 2)`와 같은 것으로 `{ x in foo (x, bar: 2) }`를 대체해서 줄이는 겁니다. 이것이 가지는 확실한 장점은 더 수월하게 우리의 키워드-인자-기반의 API 설계와 어울리며, 게다가 기존 커링 방식보다 더 유연한게 이전에는 인자의 순서를 API 설계자가 미리 고려해야만 했기 때문입니다.

* 멤버 함수 그리고/또는 연산자 구분 구문, `self.method`는 부분적으로 멤버 함수를 `self` 매개변수에 엮는데, `.method(argument)`를 추가해서 이 경우 멤버 함수를 그것의 비-self 인자들에 묶게 할 수 있습니다. 이것은 `map`과 `filter`와 같은 고차 멤버 함수들에 특히 유용할 것이다. Haskell의 `(2+) / (+2)` 구문 같이 부분 적용 연산자도 꽤 괜찮을 수 있습니다.


### 고찰 하기

일단은 Methods라는 용어를 모두 멤버 함수라고 옮겼습니다. 상황에 따라 다르게 옮겨야 할지 아직 결정하지 못했습니다.

아직은 직역에 가까워서 문장이 매끄럽지 못한데, Swift 3.0이 나오기 전까지 계속해서 업데이트 할 예정입니다. 그리고 원문의 번역만이 아니라 흐름에 대해서 저의 생각도 추가해서 정리할 생각입니다.


### 참고 자료 및 부연 설명

[^Prerelease]: Swift 관련 문서의 경우 Apple에서 실제 버전이 적용되기 전에 prerelease 버전을 먼저 공개하고 있습니다. 현재는 [Swift 2.2 Prerelease](https://itunes.apple.com/kr/book/swift-programming-language/id1002622538?mt=11) 버전이 공개된 상태이며, 문서의 맨 뒷부분에 있는 Document Revision History를 보면 현재까지 Swift의 문법 관련 변화를 살펴볼 수 있습니다.

[^Evolution]: Apple에서 GitHub에 Swift를 오픈 소스로 올려두면서 [apple/swift-evolution](https://github.com/apple/swift-evolution) 저장소에는 앞으로 Swift에서 변화될 부분에 대한 내용을 정리했습니다.. 현재는 Swift 3.0 버전에 대한 내용들을 제안해서 토의하고 있는 것 같습니다. 이 블로그 글은 [Joe Groff](https://github.com/jckarter)라는 분이 제안한 [원문](https://github.com/apple/swift-evolution/blob/master/proposals/0002-remove-currying.md)을 번역한 것입이다.

[^Free-Function]: 원문에서는 free function으로 되어 있는데, [stackoverflow 답 글](http://stackoverflow.com/questions/4861914/what-is-the-meaning-of-the-term-free-function-in-c)을 참고하여 이를 비멤버 함수라고 번역했습니다. 나중에 좀 더 적합한 용어가 생기면 수정할 생각입니다.

[^Translation]: 이 문장은 번역은 매끄럽지 못한데, 아직 문장의 정확한 의미를 파악하지 못했습니다. 원문을 보시고 더 좋은 번역을 제안하고자 하는 분은 답글을 달아주시면 고맙겠습니다.
