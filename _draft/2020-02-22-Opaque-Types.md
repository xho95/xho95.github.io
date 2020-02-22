---
layout: post
comments: true
title:  "Swift 5.2: Opaque Types (불투명한 타입)"
date:   2020-02-22 11:30:00 +0900
categories: Swift Language Grammar Opaque Type
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Opaque Types](https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html) 부분[^Opaque-Types]을 정리한 글입니다.

## Opaque Types

함수나 메소드에서 Opaque (불투명한) 반환 타입을 쓰면 반환 값의 타입 정보를 감춥니다. 함수의 반환 타입으로 명확한 타입 (concrete type) 을 제공하는 대신에, 반환 값을 그가 제공하는 프로토콜로써 묘사합니다. 타입 정보를 감추는 것은 모듈과 그 모듈을 호출하는 코드 사이 지점에서 유용한데, 이는 반환 값의 실제 숨겨진 타입을 사적 영역에 남겨둘 수 있기 때문입니다. 값을 프로토콜 타입으로 반환하는 것과는 다르게, opaque 타입은 타입 정체성 (type identity) 를 보존합니다. - 컴파일러는 타입 정보에 접근하더라도, 모듈 사용자는 그게 안됩니다.


### Opaque 타입으로 해결하는 문제

```swift
```

### 생각하기

### 참고 자료

[^Opaque-Types]: 전체 원문은 [Opaque Types](https://docs.swift.org/swift-book/LanguageGuide/OpaqueTypes.html)에서 확인할 수 있습니다.
