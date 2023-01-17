---
layout: post
pagination: 
  enabled: true
comments: true
title:  "Error: Declarations from extensions cannot be overridden yet"
date:   2016-07-22 01:50:00 +0900
categories: Xcode Swift Grammar Errors
redirect_from: "/xcode/swift/grammar/errors/2016/07/21/Declarations-from-extensions-cannot-be-overridden-yet.html"
---

여기서는 **Declarations from extensions cannot be overridden yet** 에러가 발생했을 경우의 해결 방법에 대해서 정리합니다.

### 에러의 원인

에러 문구 : Declarations from extensions cannot be overridden yet[^Situation]

직역하면 `extension`에서 선언한 함수를 재정의(override)하는게 아직 가능하지 않다는 의미입니다. 이것은 실제로 `extension`에서 선언한 함수를 재정의 할 수 없는 것이 아니라 재정의에 필요한 조건을 만족하지 않기 때문에 현재로써는 방법이 없다는 뜻입니다.

일단 추즉컨데, 시스템에서도 다룰 수 있어야 하는 함수의 경우, 단순히 재정의만 하면 안되고 시스템에서 호출할 수 있도록 `Objective-C`와의 호환성을 유지해야하기 때문에 발생하는 에러인 듯 합니다.

따라서 호환성을 위해 `@objc` 키워드를 사용하는 것이 해결 방법의 핵심입니다.

### 해결 방법

**stackoverflow** 의 답글 중에 `Objective-C`와의 호환성을 유지하기 위해 `@objc` 키워드가 필요하다는 답변이 있습니다.[^stackoverflow1]

만약 Swift로 만든 클래스를 함수에 전달할 경우 그 클래스에 `@objc` 키워드가 적용되든지, 아니면 `NSObject`를 상속받은 클래스던지 해야합니다. 그런데 `@objc` 클래스를 선언하려면 해당 클래스가 `NSObject`를 상속받은 클래스여야 합니다. 따라서 사용자가 만든 클래스에 `@objc`를 적용하고 싶으면 단순히 `NSObject`를 상속받기만 하면 됩니다.[^stackoverflow2]

### 고찰하기

이 글에 나온 내용들과 `@objc`에 대한 내용은 애플의 공식 문서인 **Using Swift Cocoa and Objective-C** 에 잘 나와 있는 것 같습니다. 나중에 이 글도 공식 문서를 참고하여 업데이트할 예정입니다.

### 참고 자료

[^Situation]: 해당 에러의 발생 상황과 원인에 대해서는 GitHub에 **onmyway133**분이 [Declarations from extensions cannot be overridden yet](https://github.com/onmyway133/notes/issues/86)라는 노트로 잘 정리해 두었습니다.

[^stackoverflow1]: [Override function error in swift](http://stackoverflow.com/questions/34061246/override-function-error-in-swift)라는 글에 설명이 되어 있는데, 다만 이 글의 경우 Override 하는 함수에 `@objc` 키워드를 적용하였습니다. 일단 이것 만으로는 에러가 해결이 안됩니다.

[^stackoverflow2]: [Unable to use custom class in a protocol with @objc attribute?](http://stackoverflow.com/questions/28838433/unable-to-use-custom-class-in-a-protocol-with-objc-attribute) 글에 클래스를 **NSObject**에서 상속받도록 하는 것이 나옵니다.
