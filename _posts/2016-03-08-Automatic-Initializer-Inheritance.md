---
layout: post
title:  "Swift 문법 정리: 자동으로 초기자가 상속(Automatic Initializer Inheritance)되는 상황 알아보기"
date:   2016-03-08 01:00:00 +0900
categories: Swift Grammar Automatic Initializer
---

Swift에서는 하위 클래스가 상위 클래스의 초기자를 저절로 상속하는 경우는 없습니다. 하지만, 상위 클래스의 초기자를 자동으로 상속받는 그런 특수한 상황도 있습니다. 여기서는 Swift에서 어떤 경우에 자동으로 초기자가 상속되는지에 대해 알아봅니다. 이 내용은 **The Swift Programming Language** 에서 **Automatic Initializer Inheritance** 부분을 번역하고 정리한 것입니다.[^Automatic]

상위 클래스의 초기자를 자동으로 상속받는다는 것은, 사실상 초기자를 중복적재할 필요가 없는 경우가 태반일 뿐만 아니라 상위 클래스의 초기자를 상속받을 때도 최소한의 노력으로 가능한 안전한 상황에서 할 수 있음을 뜻합니다.

우선 모든 속성들에 기본값을 준 하위 클래스를 만들었다면, 다음의 두 규칙이 적용됩니다:

**규칙 1**

만약 하위 클래스가 어떤 지정 초기자(designated Initializer)도 정의하지 않았다면, 자동으로 모든 상위 클래스의 지정 초기자를 상속합니다.

**규칙 2**

만약 하위 클래스가 상위 클래스의 모든 지정 초기자를 구현했다면-규칙 1에 의해 상속받거나, 클래스 정의에서 직접 구현했거나 상관없이-, 자동으로 상위 클래스의 모든 편의 초기자(convenience Initializers)를 상속합니다.

이들 규칙은 하위 클래스에 또다른 편의 초기자를 추가한 경우에도 적용됩니다.

> 하위 클래스는 상위 클래스의 지정 초기자를 편의 초기자로 구현할 수도 있는데, 이 때도 규칙 2를 만족하게 됩니다.


### 고찰하기

Swift에서의 초기자는 일단 기본이 클래스, 또는 구조체가 생길 때 모든 속성을 빠짐없이 초기화할 것을 요구합니다. 따라서 초기자의 상속 조건도 자신의 속성들에 기본값을 모두 제공하는 경우에 한해서 일어나는 것을 알 수 있습니다. 이것은 상속받은 초기자를 호출하여 객체를 만들더라도 자기가 정의한 속성까지 빠짐없이 초기화할 수 있게 만들어야 하기 때문입니다.

하지만 그렇지 않은 예제가 있는 것 같은데, 그 부분은 나중에 다시 추가할 생각입니다.

### 참고 자료

[^Automatic]: [Automatic Initializer Inheritance](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203)
