---
layout: post
title:  "Swift 문법 정리: 확장(Extensions)"
date:   2016-01-19 17:10:00 +0900
categories: Xcode Swift Grammar Extensions
---

여기서는 Swift의 Extensions에 대해서 알아본다.

기본적으로 전체 내용은 Apple의 공식 Swift 문서인 `The Swift Programming Language (Swift 2.1)`의 내용을 정리한 것이며, Swift의 버전이 바뀌면서 바뀌게 되는 내용이 있다면 반영하도록 할 예정이다.[^Swift]


### Extensions

Extensions은 이미 존재하는 클래스, 구조체, 열거체 또는 프로토콜 타입에 새로운 기능을 부여하는 것을 말한다. Extensions의 장점은 라이브러리에 포함되어 있어서서 우리가 직접 해당 소스를 바꿀 수 없는 미리 정의된 타입에도 적용 가능하다는 점이다. (이것을 공식 문서에서는 `retroactive modeling`이라는 용어로 소개하고 있다. 우리 말로 표헌하면 `소급 적용하는 모델링 기법` 정도일 것이다.)

> 공식 문서에서는 Swift의 Extensions이 Objective-C의 categories와 유사하다고 하는데,  Objective-C에 대해서는 잘 몰라서, 개인적으로는 Delphi에서 사용하는 Object Pascal이라는 언어의 Helper class와 유사한 개념인 것처럼 느껴진다.

Swift의 Extensions이 기존 타입에 확장할 수 있는 것들은 다음과 같다.

* computed properties, computed type properties 추가하기
* convenience initializers 추가하기
* instance methods, type methods 정의하기
* subscripts 정의하기
* nested types 정의하기
* 기존 타입이 특정한 protocol을 따르도록 하기

> Extensions은 타입 뿐만 아니라 프로토콜도 확장이 가능하며, 프로토콜의 확장을 통해서 프로토콜의 요구사항(requirements)과 추가적인 기능(additional functionality) 확장이 가능하며, 이렇게 확장된 프로토콜은 해당 프로토콜을 따르는 모든 타입들에 적용된다.

[^Swift]: Apple의 Swift 공식 문서는 [여기](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/index.html)서 확인할 수 있다. iBooks에서도 다운받을 수 있는데, 경험에 의하면 웹 페이지의 문서가 좀 더 최신 버전을 빨리 반영하는 것 같다.
