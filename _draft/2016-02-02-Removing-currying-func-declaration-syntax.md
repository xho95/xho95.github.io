---
layout: post
title:  "Swift 3.0 : Removing currying `func` declaration syntax"
date:   2016-02-02 19:50:00 +0900
categories: Xcode Swift Currying Evolution
---

최근에 Swift 2.2 관련 내용이 업데이트 되면서 The Swift Programming Language (Swift 2.2)를 다운받게 되었다. 그런데 책의 내용 중에 커리 함수(Curried Function) 관련 부분의 설명이 빠지는 것을 보고 확인하니 Swift 3.0에서는 커리 함수에 변경 사항이 있었다.

이에 여기서는 Swift 3.0에서 변경될 커리 함수에 대해 정리하고자 한다. 참고로 Swift의 문법 변화에 대한 내용은 [GitHub](https://github.com/apple/swift-evolution/blob/master/proposals/0002-remove-currying.md)에서 확인할 수 있다.[^Evolution]

여기서는 swift-evolution에 소개된 내용 중에서 커리 함수의 문법 변경 사항에 대한 부분을 간단하게 번역하여 정리하였다.


### 소개

커리 함수 선언 문법이라는 것은 `func(x: Int)(y: Int)`와 같이 커리 함수를 선언하는 것을 말한다. 이 문법은 사용하기에 번거롭고 용어도 헷갈리며 구현이 복잡하다. 따라서 제거해야 한다.


### 동기

커리 함수 문법은 언어의 다른 특성들과 얽혀서 연쇄적인 영향을 끼치게 된다:

* 커링의 존재는 키워드 규칙과 함수의 선언명에 혼란을 일으킨다. 커리 함수의 인자들을 함수 인자들의 연속으로 볼지, 새 함수에 대한 인자 리스트의 시작으로 볼지, 아니면 아예 완전히 다른 규칙들을 따르도록 할지 등에 대해서도 논란꺼리가 된다.

* 이것은 `var`와 `inout` 인자 주석(annotations)과 얽혀 있다. 커리 함수가 `inout` 매개 변수를 가질 경우 이 변수가 첫번째 구절에 있지 않을 경우 부분 적용이 되지 않는다. 이는 놀랍지 않은 문법상의 제약인데, 사용성을 제한하게 된다. `var` 매개 변수의 경우에는, 질문이 있을 수 있는 것이 `var`의 범위가 미치는 레벨이다; 많은 유저들이 기대하는 것은 가장 외곽의 부분 응용(partial application)이지만, 현재는 가장 안쪽 부분 응용에까지 미치게 만들었다.  

`Cocoa`와 같은 표준 라이브러리의 관용구나, 대부분의 써드 파티 코드



[^Evolution]: Apple에서 GitHub에 Swift를 오픈 소스로 올려두면서 [apple/swift-evolution](https://github.com/apple/swift-evolution) 저장소에는 Swift 언어 관련 변경 사항에 대한 내용을 정리해 두었다.
