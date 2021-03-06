---
layout: post
comments: true
title:  "Swift 5.5: Version Compatibility (버전 호환성)"
date:   2020-03-15 10:00:00 +0900
categories: Swift Language Grammar Version Compatibility
redirect_from: "/swift/language/grammar/versuib/compatibility/2020/03/15/Version-Compatibility.html"
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Version Compatibility](https://docs.swift.org/swift-book/GuidedTour/Compatibility.html) 부분[^Version-Compatibility]을 번역하고, 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Version Compatibility (버전 호환성)

이 책은, '엑스코드 (Xcode) 12' 에 포함된 '스위프트 (Swift)' 의 기본 버전인, '스위프트 5.3' 을 설명합니다. '엑스코드 12' 는 '스위프트 5.3', '스위프트 4.2', 또는 '스위프트 4' 로 작성된 '대상 (targets)'[^targets] 을 제작하는데 사용할 수 있습니다.

스위프트 4와 스위프트 4.2 코드를 제작하기 위해 '엑스코드 12' 를 사용할 때, 스위프트 5.3 의 기능도 대부분 사용 가능합니다. 그렇다 하더라도, 아래의 변경 사항은 스위프트 5.3 이후의 코드에서만 사용 가능합니다:

* '불투명 타입 (opaque type)' 을 반환하는 함수는 '스위프트 5.1 런타임 (runtime)'[^swift-runtime] 이 필수입니다.
* '`try?` 표현식' 은 이미 '옵셔널 (optionals)' 을 반환하는 표현식에 부가적인 수준의 '옵셔널성 (optionality)' 를 도입하지 않습니다.[^level-of-optionality]
* '아주 큰 정수 글자 값 초기화 표현식 (large integer literal initialization expressions)'[^large-integer-literal] 은 올바른 정수 타입인 것으로 추론합니다. 예를 들어, `UInt64(0xffff_ffff_ffff_ffff)` 도 '값 넘침 (overflowing)' 이 아닌 올바른 값으로 평가합니다.

스위프트 5.3 으로 작성된 대상은 스위프트 4.2 나 스위프트 4 로 작성된 대상에 의존할 수 있으며, 그 반대도 가능합니다.[^depend-on] 이것의 의미는, 프로젝트가 아주 커서 프레임웍이 여러 개로 분할된 경우, 코드를 스위프트 4 에서 스위프트 5.3 으로 한 번에 한 프레임웍씩 이전할 수 있다는 것입니다.

### 다음 장

[A Swift Tour (스위프트 둘러보기) >]({% post_url 2016-04-17-A-Swift-Tour %})

### 참고 자료

[^Version-Compatibility]: 이 글에 대한 원문은 [Version Compatibility](https://docs.swift.org/swift-book/GuidedTour/Compatibility.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^targets]: '엑스코드 (Xcode)' 에서 하나의 '대상 (target; 타켓)' 이란 '제품 (product) 을 정의한 것' 입니다. 프로젝트는 하나지만 '대상 (target)' 은 여러 개가 될 수 있습니다. 좀 더 자세한 내용은 [Xcode Target](https://developer.apple.com/library/archive/featuredarticles/XcodeConcepts/Concept-Targets.html) 항목을 참고하기 바랍니다.

[^swift-runtime]: 런타임 (runtime) 은 '런타임 라이브러리' 를 의미하는데, 위키피디아의 [Swift (programming language)](https://en.wikipedia.org/wiki/Swift_(programming_language)) 항목에 따르면, 2019년 3월에 공개된 스위프트 5 부터는 ABI 안전성 (ABI Stability)[^ABI-Stability] 을 지원하면서 스위프트 런타임이 애플 운영체제 속에 포함되었다고 합니다. 이말은 최신 버전의 '스위프트 런타임' 을 사용하려면 '운영 체제' 도 최신으로 업데이트해야 한다는 것을 의미합니다. 스위프트의 런타임에 대한 더 많은 내용은 [The Swift Runtime](https://github.com/apple/swift/blob/master/docs/Runtime.md) 항목을 참고하기 바랍니다.

[^ABI-Stability]: 스위프트의 ABI 안정성에 대해서는 [Evolving Swift On Apple Platforms After ABI Stability](https://swift.org/blog/abi-stability-and-apple/) 항목을 참고하기 바랍니다. 한글 자료로는 **Zedd02028** 님이 [ABI stability](https://zeddios.tistory.com/654) 라는 글에 정리를 잘 해두신 것 같습니다.

[^level-of-optionality]: 부가적인 수준의 '옵셔널성' 를 도입하지 않는다는 말은, '옵셔널 연쇄 (optional chaining)' 에서 처럼, 여러 단계로 포장되어 있어도 전체 '옵셔널 값 (optional value)' 을 구하려면 한 번만 포장을 풀면 된다는 의미입니다. 좀 더 자세한 내용은 [Optional Chaining (옵셔널 연쇄)]({% post_url 2020-06-17-Optional-Chaining %}) 항목을 참고하기 바랍니다.

[^large-integer-literal]: '아주 큰 정수 글자 값' 이란 바로 뒤 예제에 나오는 것처럼, 정수가 아주 클 때, `0xffff_ffff_ffff_ffff` 처럼, 일정 자리마다 구분자를 표시한 '글자 값' 을 말합니다. 여기서 '글자 값 (literal)' 이란 '글자로 표현된 그 자체로서의 값' 을 의미하며, `let x = 1` 과 같은 구문이 있을 때, `1` 을 문자가 아니라 그 글자가 표현하는 값인 하나의 수 `1` 로 인식한다는 것을 의미합니다.

[^depend-on]: 이것은 ABI 안정성[^ABI-Stability] 에 더해서 스위프트 5.2 부터 모듈 안정성 (module stability) 도 지원하기 때문인 것으로 추측됩니다. 이 부분은 대해서는 [ABI Stability and More](https://swift.org/blog/abi-stability-and-more/) 항목을 참고하기 바랍니다.
