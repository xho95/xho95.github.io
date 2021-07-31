---
layout: post
comments: true
title:  "Swift 5.5: About Swift (스위프트에 대하여)"
date:   2017-03-02 10:00:00 +0900
categories: Swift Language Grammar About
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [About Swift](https://docs.swift.org/swift-book/) 부분[^About-Swift]을 번역하고, 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## About Swift (스위프트에 대하여)

'스위프트 (swift)' 는 전화, 데스크탑, 서버, 또는 그 외 코드를 실행하는 어떤 곳이든, 소프트웨어를 작성하는 환상적인 방법입니다. 안전하고, 빠른, 대화형 프로그래밍 언어로써 '현대적인 (modern)[^modern] 언어 사고의 가장 좋은 것' 에 '폭넓은 애플 개발 문화의 지혜와 오픈-소스 공동체의 광범위한 기여' 을 조합하였습니다. 컴파일러는 성능에 최적화했고 언어는 개발에 최적화했으면서도, 어느 쪽과도 타협하지 않았습니다.

스위프트는 새로운 프로그래머에게 친절합니다. 산업계-품질의 프로그래밍 언어면서도 스크립트 언어처럼 표현력이 풍부하여 즐겁습니다. 스위프트 코드를 '플레이그라운드 (Playground; 놀이터)' 로 작성하면, 앱 제작 및 실행 부담없이, 곧바로 코드를 실험하고 결과를 볼 수 있게 합니다.

스위프트는 '현대적인 프로그래밍 패턴'[^modern-programming-patterns] 을 채택함으로써 많은 부류의 일반적인 프로그래밍 에러를 미리 없애버립니다:

* '변수' 는 항상 사용 전에 초기화합니다.
* '배열 색인' 은 '경계를-벗어난 (out-of-bounds) 에러' 를 검사합니다.
* '정수' 는 '값 넘침 (overflow)' 을 검사합니다.
* '옵셔널 (optional)' 은 `nil` 값을 명시적으로 처리하도록 보장합니다.
* '메모리' 는 자동으로 관리합니다.
* '에러 처리 (error handling)' 는 예상치 못한 실패로부터의 '제어되는 복구 (controlled recovery)' 를 허용합니다.

스위프트 코드는 최신 하드웨어의 장점을 최대한 활용하도록 컴파일되고 최적화됩니다. '구문 (syntax) 과 표준 라이브러리' 는 '코드를 작성하는 명백한 방식이 수행 또한 최고가 돼야 한다' 는 기본 원리에 기초하여 설계하였습니다. 이 안전성과 속도의 조합은 "Hello, world!" 부터 전체 운영 체제까지의 모든 것에 스위프트가 탁월한 선택이도록 합니다.

스위프트는 '강력한 타입 추론 (type inference) 과 패턴 맞춤 (pattern matching) 기능' 에 '현대적인, 가벼운 구문' 을 조합하여, 복잡한 아이디어도 명확하고 간결하게 표현하도록 허용합니다. 그 결과, 코드 작성만 쉬워진게 아니라, 이해하고 유지하는 것도 더 쉬워졌습니다.

스위프트는 다년간 다듬어지고 있으며, 새로운 특징과 보유 능력으로 계속 진화하고 있습니다. 스위프트에 대한 우리의 목표는 원대합니다. 이것으로 무엇을 만들지 정말 기대합니다.

### 다음 장

[Version Compatibility (버전 호환성) >]({% post_url 2020-03-15-Version-Compatibility %})

### 참고 자료

[^About-Swift]: 원문은 [About Swift](https://docs.swift.org/swift-book/) 에서 확인할 수 있습니다.

[^modern]: 'modern' 이란 말에는 '현대' 라는 의미와 '최신' 이란 의미가 모두 담겨 있습니다. 그러므로 '현대 언어' 라는 말을 '최신 언어' 라는 말로 대체해도 상관없습니다.

[^modern-programming-patterns]: 이 역시 '최신 프로그래밍 패턴' 으로 이해해도 무방합니다.
