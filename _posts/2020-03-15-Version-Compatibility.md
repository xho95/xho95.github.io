---
layout: post
comments: true
title:  "Swift 5.2: Version Compatibility (버전 호환성)"
date:   2020-03-15 10:00:00 +0900
categories: Swift Language Grammar Version Compatibility
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Version Compatibility](https://docs.swift.org/swift-book/GuidedTour/Compatibility.html) 부분[^Version-Compatibility]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Version Compatibility (버전 호환성)

이 책은 'Xcode (엑스코드) 11.4' 에 탑재된 기본 버전인 '스위프트 5.2' 를 설명합니다. Xcode 11.4 를 사용하여 스위프트 5.2, 스위프트 4.2, 또는 스위프트 4 로 작성된 타겟 (targets)[^targets] 을 빌드할 수 있습니다.

Xcode 11.4 로 스위프트 4 와 스위프트 4.2 의 코드를 빌드할 때, 스위프트 5.2 의 기능을 대부분 사용할 수 있습니다. 그렇다 하더라도, 아래의 변경 사항들은 스위프트 5.2 이상을 사용한 코드에서만 사용할 수 있습니다:

* Opaque (불투명한) 타입을 반환하는 함수는 스위프트 5.1 '런타임 (runtime)'[^swift-runtime] 을 요구합니다.
* `try?` 표현식은 이미 옵셔널 (optionals) 을 반환하는 표현식에 옵셔널리티 단계 (level of optionality) 을 추가하지 않습니다.[^level-of-optionality]
* '큰 정수 글자표현 (large integer literal)' 을 사용하는 초기화 표현식도 올바른 정수 타입인 것으로 추론합니다. 예를 들어, `UInt64(0xffff_ffff_ffff_ffff)` 라고 해도 값이 넘친 것이 아니라 올바른 값으로 인식합니다.

스위프트 5.2 로 작성된 타겟과 스위프트 4.2 나 스위프트 4 로 작성된 타겟은 서로 의존성을 가져도 문제가 없습니다.[^depend-on] 이것이 의미하는 것은, 여러 개의 프레임웍으로 나누어진 큰 프로젝트에서, 코드를 스위프트 4 에서 스위프트 5.2 로 이전할 때 한 번에 한 프레임웍씩 진행할 수 있다는 것입니다.

### 참고 자료

[^Version-Compatibility]: 이 글에 대한 원문은 [Version Compatibility](https://docs.swift.org/swift-book/GuidedTour/Compatibility.html) 에서 확인할 수 있습니다.

[^targets]: 엑스코드 에서 하나의 '대상 (target; 타켓)' 이란 하나의 '제품 (product) 을 정의한 것' 입니다. 하나의 프로젝트에서도 타겟은 여러 개가 될 수 있습니다. 좀 더 자세한 내용은 [Xcode Target](https://developer.apple.com/library/archive/featuredarticles/XcodeConcepts/Concept-Targets.html) 문서를 참고하기 바랍니다.

[^swift-runtime]: 런타임 (runtime) 은 '런타임 라이브러리' 를 의미하는데, 위키피디아의 [Swift (programming language)](https://en.wikipedia.org/wiki/Swift_(programming_language)) 항목에 따르면, 2019년 3월에 공개된 스위프트 5 부터는 ABI 안전성 (ABI Stability)[^ABI-Stability] 을 지원하면서 스위프트 런타임이 애플 운영체제 속에 포함되었다고 합니다. 즉 최신 버전의 스위프트 런타임을 사용하려면 운영체제를 업데이트하는 것이 필요합니다. 스위프트의 런타임에 대한 더 많은 내용은 [The Swift Runtime](https://github.com/apple/swift/blob/master/docs/Runtime.md) 라는 글을 참고하기 바랍니다.

[^ABI-Stability]: 스위프트의 ABI 안정성에 대해서는 [Evolving Swift On Apple Platforms After ABI Stability](https://swift.org/blog/abi-stability-and-apple/) 라는 글을 참고하기 바랍니다. 한글 자료로는 **Zedd02028** 님이 [ABI stability](https://zeddios.tistory.com/654) 라는 글에 정리를 잘 해두신 것 같습니다.

[^level-of-optionality]: '옵셔널 단계' 를 추가하지 않는다는 말은 '옵셔널 연쇄 (optional chaining)' 에서 처럼, 여러 단계로 중첩이 되어도 마지막에 값을 구할 때는 '옵셔널 값 (optional value)' 을 한 번만 벗기면 된다는 의미입니다. 좀 더 자세한 내용은 [Optional Chaining](https://docs.swift.org/swift-book/LanguageGuide/OptionalChaining.html) 문서를 참고하기 바랍니다.

[^depend-on]: 이것은 ABI 안정성[^ABI-Stability] 에 더해서 스위프트 5.2 부터 모듈 안정성 (module stability) 도 지원하기 때문인 것으로 추측됩니다. 이 부분은 대해서는 [ABI Stability and More](https://swift.org/blog/abi-stability-and-more/) 글을 참고하기 바랍니다.
