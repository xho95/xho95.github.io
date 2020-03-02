---
layout: post
comments: true
title:  "Swift 5.2: Extensions (확장)"
date:   2016-01-19 17:10:00 +0900
categories: Xcode Swift Grammar Extensions
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Extensions](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html) 부분[^Extensions]을 정리한 글입니다.

## Extensions (확장)

_확장 (Extensions)_ 은 이미 존재하는 클래스, 구조체, 열거체[^enumeration] 또는 프로토콜 타입에 새로운 기능 (functionality)[^functionality] 을 추가하는 것입니다. 원본 소스 코드에 접근할 수 없는 타입도 확장이 가능합니다. (이를 _`retroactive modeling (소급 적용 모델링)`_ 이라고 합니다.[^retroactive-modeling]) 확장은 오브젝티브-C의 카테고리 (categries) 와 유사합니다. (하지만 오브젝티브-C의 카테고리와는 다르게, 스위프트의 확장은 이름을 가지지 않습니다.)


> 공식 문서에서는 Swift의 Extensions이 Objective-C의 categories와 유사하다고 하는데,  Objective-C에 대해서는 잘 몰라서, 개인적으로는 Delphi에서 사용하는 Object Pascal이라는 언어의 Helper class와 유사한 개념인 것처럼 느껴진다.

Swift의 Extensions이 기존 타입에 확장할 수 있는 것들은 다음과 같다.

* computed properties, computed type properties 추가하기
* convenience initializers 추가하기
* instance methods, type methods 정의하기
* subscripts 정의하기
* nested types 정의하기
* 기존 타입이 특정한 protocol을 따르도록 하기

> Extensions은 타입 뿐만 아니라 프로토콜도 확장이 가능하며, 프로토콜의 확장을 통해서 프로토콜의 요구사항(requirements)과 추가적인 기능(additional functionality) 확장이 가능하며, 이렇게 확장된 프로토콜은 해당 프로토콜을 따르는 모든 타입들에 적용된다.

### Extension Syntax

### Computed properties

### Initializers

### Methods

### Subscripts

### Nested Teyps


### 참고 자료

[^Extensions]: 원문은 [Extensions](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html) 에서 확인할 수 있습니다.

[^enumeration]: `class` 를 '객체', `structure` 를 '구조체' 라고 하듯이, 일관성을 유지하기 위해서 `enumeration` 을 '열거체' 라고 옮깁니다.

[^functionality]: 여기서 기능이라는 말이 중요한데, 확장 (extensions) 은 대상의 구조는 변화시키지 않고 기능만을 더하는 것입니다. 클래스를 예로 들면 실제로 새로운 '속성'이 추가되는 것은 없고 일종의 '메소드' -또는 메소드에 준하는 요소-만 추가된다고 볼 수 있습니다.

[^retroactive-modeling]: 즉 스위프트 표준 라이브러리에서 제공하는 타입이나 패키지에 있는 타입들도 확장 (extensions) 할 수 있습니다. 이것 역시 확장이 대상의 구조 변화없이 기능만을 추가하기 때문이기도 합니다.
