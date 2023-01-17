---
layout: post
pagination: 
  enabled: true
comments: true
title:  "Swift 5.7: Version Compatibility (버전 호환성)"
date:   2020-03-15 10:00:00 +0900
categories: Swift Language Grammar Version Compatibility
redirect_from: "/swift/language/grammar/versuib/compatibility/2020/03/15/Version-Compatibility.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [Version Compatibility](https://docs.swift.org/swift-book/GuidedTour/Compatibility.html) 부분[^Version-Compatibility]을 번역하고, 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Version Compatibility (버전 호환성)

이 책이 설명하는 건 **스위프트 5.7** 로, **액스코드 14** 에 포함된 스위프트 기본 버전입니다.[^swift-version] 엑스코드 14 를 사용하면 스위프트 5.5 나, 스위프트 4.2, 또는 스위프트 4 로 작성한 대상[^targets] 을 제작할 수 있습니다.

엑스코드 14 를 사용하여 스위프트 4 및 스위프트 4.2 코드를 제작할 땐, 대부분의 스위프트 5.7 기능이 사용 가능합니다. 그렇더라도, 아래 바뀐 내용은 스위프트 5.7 이후의 코드에서만 사용 가능합니다:

* 불투명 타입을 반환하는 함수는 **스위프트 5.1 런타임**[^swift-runtime] 을 요구합니다.
* `try?` 표현식은 이미 옵셔널을 반환하는 표현식에 옵셔널 수준을 부가하지 않습니다.[^level-of-optionality]
* 아주 큰 정수 글자 값 초기화 표현식[^large-integer-literal] 은 올바른 정수 타입으로 추론합니다. 예를 들어, `UInt64(0xffff_ffff_ffff_ffff)` 을 값 넘침 보단 올바른 값으로 평가합니다.

동시성[^concurrency] 은 스위프트 5.7 이후, 와 해당 동시성 타입을 제공하는 버전의 스위프트 표준 라이브러리를 요구합니다. 애플 플랫폼이면, 배포 대상을 적어도 **iOS 15** 나, **macOS 12**, **tvOS 15**, 또는 **watchOS 8.0** 으로 설정합니다.[^deployment-target]  

**스위프트 5.7** 로 작성한 대상이 **스위프트 4.2** 또는 **스위프트 4** 로 작성한 대상에 의존할 수도 있고, 그 반대도 마찬가지입니다.[^depend-on] 이는, 프로젝트가 아주 커서 여러 개의 프레임웍으로 분할한 거면, **스위프트 4** 에서 **스위프트 5.7** 로 한 번에 한 프레임웍씩 코드를 이전할 수 있다는 의미입니다.

### 다음 장

[A Swift Tour (스위프트 둘러보기) >]({% post_url 2016-04-17-A-Swift-Tour %})

### 참고 자료

[^Version-Compatibility]: 이 글에 대한 원문은 [Version Compatibility](https://docs.swift.org/swift-book/GuidedTour/Compatibility.html) 에서 확인할 수 있습니다.

[^swift-version]: [Document Revision History (문서를 다듬은 역사)]({% post_url 2020-03-16-Document-Revision-History %}) 에서 확인할 수 있는 것처럼, 스위프트 언어의 버전은 매년 1씩 증가하다가, 2019년 이후로는 주 버전이 5.x 대를 유지하고 있습니다. 아마도 스위프트 언어의 문법이 어느 정도 정리되었기 때문일 것입니다.

[^targets]: 엑스코드에서 하나의 **대상 (target)** 이란 '하나의 제품 (product) 을 정의한 것' 입니다. 프로젝트는 하나지만 대상은 여러 개일 수 있는데, 한 프로젝트로 만든 앱을 다양한 종류의 기기로 배포할 수도 있기 때문입니다. 대상에 대한 더 자세한 정보는, [Xcode Target](https://developer.apple.com/library/archive/featuredarticles/XcodeConcepts/Concept-Targets.html) 항목을 참고하기 바랍니다.

[^swift-runtime]: 여기서의, 런타임 (runtime) 은 런타임 라이브러리를 의미합니다. 위키피디아의 [Swift (programming language)](https://en.wikipedia.org/wiki/Swift_(programming_language)) 항목에 따르면, 2019년 3월에 공개한 스위프트 5 부턴, ABI 안전성 (ABI Stability)[^ABI-Stability] 을 지원하면서, 스위프트 런타임이 애플 운영체제 안에 포함되었다고 합니다. 즉, 최신 버전의 스위프트 런타임을 사용하려면 운영 체제도 최신으로 업데이트해야 합니다. 스위프트 런타임에 대한 더 많은 정보는, 깃허브 애플 문서의 [The Swift Runtime](https://github.com/apple/swift/blob/master/docs/Runtime.md) 항목을 참고하기 바랍니다.

[^ABI-Stability]: 스위프트의 ABI 안정성에 대해서는 [Evolving Swift On Apple Platforms After ABI Stability](https://swift.org/blog/abi-stability-and-apple/) 항목을 보도록 합니다. 한글 자료로는 **Zedd02028** 님이 [ABI stability](https://zeddios.tistory.com/654) 라는 글에 정리를 잘 해두신 것 같습니다.

[^level-of-optionality]: '옵셔널 수준을 부가하지 않는다' 는 건, 이미 옵셔널을 반환하는 걸 다시 옵셔널로 포장하지 않는다는 의미입니다. 옵셔널성에 대한 더 자세한 내용은, [Optional Chaining (옵셔널 사슬)]({% post_url 2020-06-17-Optional-Chaining %}) 부분을 참고하기 바랍니다.

[^large-integer-literal]: '아주 큰 정수 글자 값 초기화 표현식 (large integer literal initialization expressions)' 이란, 바로 뒤의 예제 처럼, 정수가 아주 클 때 `0xffff_ffff_ffff_ffff` 같이 일정 자리마다 구분자를 표시한 글자 값입니다. 여기서 '글자 값 (literal)' 은 글자로 그 자체의 값을 의미하며, `let x = 1` 과 같은 구문에서의 `1` 같은 값입니다.

[^concurrency]: 동시성에 대한 더 자세한 정보는 [Concurrency (동시성)]({% post_url 2021-06-10-Concurrency %}) 장을 참고하기 바랍니다.

[^deployment-target]: 여기서 나열한 배포 대상들이 스위프트 5.7 이후의 기능을 사용하기 위한 조건입니다.

[^depend-on]: 이는 스위프트가 ABI 안정성[^ABI-Stability] 과 모듈 안정성을 지원하기 때문인데, 이들은 **스위프트 5.2** 에서 추가되었습니다. ABI 안정성에 대한 더 자세한 정보는, [ABI Stability and More](https://swift.org/blog/abi-stability-and-more/) 항목을 참고하기 바랍니다.
