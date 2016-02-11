---
layout: post
title:  "Swift 3.0 : 커리 함수 선언 구문의 생략"
date:   2016-02-02 19:50:00 +0900
categories: Xcode Swift Currying Evolution
---

최근에 Apple에서 공개한 The Swift Programming Language의 2.2 버전을 보면 커리 함수(Curried Function)에 대한 설명이 빠져있는 것을 볼 수 있다. 이에 관련 자료를 살펴보니 Swift 3.0에서는 커리 함수를 선언하는 문법에 변경 사항이 있음을 알게 되었다.

여기서는 Swift 3.0에서 바뀌게 될 커리 함수의 선언 방식에 대해 간단하게 번역하여 정리하고자 한다. 참고로 Swift의 문법 변화에 대한 내용은 [GitHub](https://github.com/apple/swift-evolution/blob/master/proposals/0002-remove-currying.md)에서 확인할 수 있다.[^Evolution]


### 소개

Swift에서 커리 함수는 `func foo(x: Int)(y: Int)`와 같은 방법으로 선언하게 된다. 이 문법은 사용하기에 번거롭고 용어도 헷갈리며 구현이 복잡하다. 따라서 제거해야 한다.


### 동기

현재의 커리 함수 문법은 언어의 다른 특성들과 얽혀서 연쇄적인 영향을 끼치게 된다:

* 지금의 커링 방식은 키워드 규칙과 함수의 선언명에 혼란을 일으킨다. 커리 함수의 인자들만 하더라도 함수 인자들의 연속인지, 새 함수에 대한 인자 리스트의 시작인지, 아니면 아예 다른 규칙들을 따르는게 맞는지 등 이 모든 것들이 논쟁꺼리가 된다.

* 이것은 `var`와 `inout` 인자 주석(annotations)과 얽혀 있다. 커리 함수가 `inout` 매개 변수를 가질 경우 이 변수가 첫번째 구절에 있지 않을 경우 부분 적용이 되지 않는다. 이는 어쩌면 당연한 문법상의 제약인데, 결국 사용성을 제한하게 된다. `var` 매개 변수의 경우에는, 의문스러운 것이 `var`의 범위가 미치는 레벨이다; 많은 사용자들이 기대하는 것은 가장 외곽의 부분 적용(partial application)에 되는 것이지만, 현재는 가장 안쪽의 부분 적용에 영향을 미치도록 만들었다.  

`Cocoa`와 같은 표준 라이브러리의 관용구나, 대부분의 써드 파티 코드

많은 사용자들의 관찰 결과 우리의 커링 방식은 쓰잘떼기 없으며, 차라리 `f(_, 1)`처럼 Scala 방식의 부분 적용 구문을 쓰기를 원했다. 이미 함수형 언어에 익숙한 사용자들은 우리의 커링 방식에 별 관심조차 없어서, 마치 없는게 더 낫다고 여기는 듯 했다. "만약 없다면 추가해야 할 것이다."라는 테스트는 명백히 실패한 것이다.  

### 세부 디자인

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

### 기존 코드에 미칠 충격

이러한 변경은 언어의 특성을 제거하는 것이므로, 기존 코드가 깨지는 문제가 발생할 것이다. 하지만 커링은 비교적 주변 기술이고, 신생 언어에서 쓰기에는 거슬리기도 하며, 자동 수정 기능이 잘 작동하므로, 언어를 단순하게 수정하는 것이 가져올 충격은 미미할 것이다.[^tranlation]


### 대안으로 고려해볼 사항들


### 참고 자료


[^Evolution]: Apple에서 GitHub에 Swift를 오픈 소스로 올려두면서 [apple/swift-evolution](https://github.com/apple/swift-evolution) 저장소에는 Swift 언어 관련 변경 사항에 대한 내용을 정리해 두었다. 해당 글은 [Joe Groff](https://github.com/jckarter)라는 분이 작성한 것이다.

[^tranlation]: 이 문장의 번역은 매끄럽지 못한데, 원문을 보고 더 좋은 번역을 제안하고자 하는 분은 답글을 달아주기 바란다.
