---
layout: post
comments: true
title:  "Swift 5.3: About Swift (스위프트에 대하여)"
date:   2017-03-02 10:00:00 +0900
categories: Swift Language Grammar About
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [About Swift](https://docs.swift.org/swift-book/) 부분[^About-Swift]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## About Swift (스위프트에 대하여)

스위프트는, 휴대 전화, 데스크탑, 서버, 혹은 다른 어떤 기기에서 코드를 실행하던 상관없이, 소프트웨어를 작성할 수 있는 환상적인 방법입니다. 안전하고, 빠른, 대화형 프로그래밍 언어로써 '현대적인 언어 (modern language)' 의 통찰 중에서 최상의 것에 폭넓은 애플 개발 문화의 지혜와 오픈-소스 공동체의 광범위한 기여들을 조합하였습니다. 컴파일러는 성능에 최적화되어 있고 언어는 개발에 최적화되어 있으면서도, 그 어느 쪽과도 타협하지 않았습니다.

스위프트는 새로운 프로그래머에게도 친절합니다. 산업계-품질의 프로그래밍 언어이면서도 스크립트 언어처럼 이해하기 쉽고 즐겁게 작업할 수 있습니다. '플레이그라운드 (playground; 놀이터)' 로 스위프트 코드를 작성하면, 앱을 제작하고 실행하는 부담없이도, 코드를 실험하고 결과를 즉시 확인할 수 있습니다.

스위프트는 '현대적인 프로그래밍 패턴 (modern programming pattern)' 을 채택하여 많은 종류의 일반적인 프로그래밍 에러들을 미리 없애버립니다:

* '변수 (variables)' 는 사용하기 전에 항상 초기화 합니다.
* '배열 색인 (array indices)' 은 '경계를-벗어난 (out-of-bounds)' 에러가 없는지 검사합니다.
* '정수 (integers)' 는 값이 넘치지 않는지 검사합니다.
* '옵셔널 (optional)' 은 `nil` 값이 명시적으로 처리되도록 보장합니다.
* '메모리 (memory)' 는 자동으로 관리합니다.
* '에러 처리 (error handling)' 는 예기치 않은 실패 상황을 제어하고 복구할 수 있도록 합니다.

스위프트 코드는 최신 하드웨어를 최대한 활용하도록 컴파일되고 최적화되어 있습니다. '구문 표현 (syntax)' 과 표준 라이브러리는 코드를 작성할 때 명백한 것들은 성능 또한 최상이어야 한다는 '기본 원리 (guiding principle)' 에 따라 설계되었습니다. 이런 안전성과 속도의 조합은 스위프트를 "Hello, world!" 에서부터 전체 운영 체제에 이르는 모든 영역에서 탁월한 선택이 되도록 합니다.

스위프트는 강력한 '타입 추론 (type inference)' 과 '패턴 매칭 (pattern matching; 유형 맞춤)' 기능을 현대적이고, 가벼운 구문 표현과 조합하여, 복잡한 아이디어도 명확하고 간결한 방법으로 표현하게 해줍니다. 그 결과로써, 코드 작성만 더 쉬워진게 아니라, 이해하고 유지하기는 더 쉬워졌습니다.

스위프트는 수 년간 다듬어져 왔으며, 새로운 특징과 기능을 가지고 계속 진화하고 있습니다. 스위프트에 대한 우리의 목표는 원대합니다. 여러분들이 이것으로 무엇을 만들지 정말 정말 기대됩니다.

[Version Compatibility (버전 호환성) >]({% post_url 2020-03-15-Version-Compatibility %})

### 참고 자료

[^About-Swift]: 원문은 [About Swift](https://docs.swift.org/swift-book/) 에서 확인할 수 있습니다.
