---
layout: post
comments: true
title:  "Swift 5.2: About Swift (스위프트에 대하여)"
date:   2017-03-02 10:00:00 +0900
categories: Swift Language Grammar About
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [About Swift](https://docs.swift.org/swift-book/) 부분[^About-Swift]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## About Swift (스위프트에 대하여)

스위프트 (Swift) 는 소프트웨어를 작성하는 환상적인 방법으로, 코드를 실행하는 것이 휴대 전화인지, 데스크탑 컴퓨터인지, 서버, 혹은 또 다른 어떤 기기인지 상관하지 않습니다. 안전하고, 빠른, 대화형 프로그래밍 언어로써 '현대적인 언어 (modern language)' 에 대한 통찰 중에서 최상의 것들에 폭넓은 애플 기술-개발 문화의 지혜와 오픈-소스 공동체의 다양한 기여들을 결합한 것입니다. 컴파일러는 성능에 최적화 되었고 언어는 개발에 최적화 되었으며, 그 어느 쪽과도 타협하지 않았습니다.

스위프트는 새로운 프로그래머도 사용하기 쉽습니다. 스크립트 언어처럼 이해하기 쉬우면서 즐겁게 작업할 수 있는 산업계-품질의 프로그래밍 언어입니다. 'playground (놀이터)' 로 스위프트 코드를 작성하면, 앱을 제작하고 실행하는 부담없이도, 코드를 실험하고 결과를 바로 확인할 수 있습니다.

스위프트는 '현대적인 프로그래밍 패턴 (modern programming pattern)' 을 채택하여 많은 종류의 일반적인 프로그래밍 에러들을 사전에 날려 버립니다:

* '변수 (variables)' 는 항상 사용하기 전에 초기화 합니다.
* '배열 색인 (array indices)' 은 경계를-벗어난 에러가 없는지 검사합니다.
* '정수 (integers)' 는 값이 넘치지 않는지 검사합니다.
* '옵셔널 (optional)' 은 `nil` 값이 명시적으로 처리되도록 보장합니다.
* '메모리 (memory)' 는 자동으로 관리합니다.
* '에러 처리 (error handling)' 는 예기치 않은 실패 상황을 제어하여 복구하도록 합니다.

스위프트 코드는 최신의 하드웨어를 최대한 활용할 수 있도록 컴파일 및 최적화됩니다. '구문 표현 (syntax)' 과 표준 라이브러리의 설계는 코드를 작성하는 명백한 방법은 성능 또한 최상이어야 한다는 '기본 원리 (guiding principle)' 에 따라 진행된 것입니다. 안전성과 속도의 결합은 스위프트를 "Hello, world!" 에서부터 전체 운영 체제에 이르기까지 모든 영역에서 탁월한 선택이 되도록 합니다.

스위프트는 강력한 '타입 추론 (type inference)' 과 '유형 맞춤 (pattern matching)' 기능을 현대적이고, 가벼운 구문 표현 과 결합하여, 복잡한 아이디어도 명확하고 간결한 방법으로 표현할 수 있도록 해 줍니다. 그 결과로, 코드는 작성하는 것만 더 쉬워진게 아니라, 이해하고 유지하는 것도 더 쉬워졌습니다.

스위프트는 수 년간 다듬어져 왔으며, 새로운 특징과 기능으로 진화를 계속하고 있습니다. 스위프트에 대한 우리의 목표는 원대합니다. 여러분들이 이것으로 무엇을 만들게 될지 정말 기대하고 있습니다.

[Version Compatibility (버전 호환성)]({% post_url 2020-03-15-Version-Compatibility %})

### 참고 자료

[^About-Swift]: 원문은 [About Swift](https://docs.swift.org/swift-book/) 에서 확인할 수 있습니다.
