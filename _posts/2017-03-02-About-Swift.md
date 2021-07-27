---
layout: post
comments: true
title:  "Swift 5.5: About Swift (스위프트에 대하여)"
date:   2017-03-02 10:00:00 +0900
categories: Swift Language Grammar About
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [About Swift](https://docs.swift.org/swift-book/) 부분[^About-Swift]을 번역하고, 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## About Swift (스위프트에 대하여)

스위프트는, 코드 실행을 전화, 데스크탑, 서버, 또는 그 외 어떤 곳에서 하던, 소프트웨어를 작성하는 환상적인 방법을 제공합니다. '현대 (modern) 언어'[^modern] 에 대한 최고의 통찰에 폭넓은 애플 개발 문화의 지혜와 오픈-소스 공동체의 광범위한 공헌을 조합한, 안전하고, 빠른, 대화형 프로그래밍 언어입니다. 컴파일러는 성능 최적화를 하고 언어는 개발 최적화를 하면서도, 어느 쪽과도 타협하지 않습니다.

스위프트는 새로운 프로그래머에게 친절합니다. 산업계-품질의 프로그래밍 언어면서도 스크립트 언어처럼 의미 전달력이 좋으며 즐겁게 작업할 수 있습니다. 'Playground (놀이터)' 로 스위프트 코드를 작성하는 것은, 앱을 제작하고 실행하는 부담없이, 코드를 실험하고 결과를 즉시 확인하도록 해줍니다.

스위프트는 '현대적인 프로그래밍 패턴'[^modern-programming-patterns] 을 채택하여 공통된 많은 부류의 프로그래밍 에러를 미리 없애버립니다:

* '변수' 는 항상 사용 전에 초기화합니다.
* '배열 색인' 은 '경계를-벗어난 (out-of-bounds)' 에러를 검사합니다.
* '정수' 는 '값 넘침 (overflow)' 을 검사합니다.
* '옵셔널 (optional)' 은 `nil` 값을 명시적으로 처리함을 보장합니다.
* '메모리' 는 자동으로 관리합니다.
* '에러 처리' 는 예상하지 않은 실패로부터 '제어되는 복구 (controlled recovery)' 를 허용합니다.

스위프트 코드는 최신 하드웨어의 장점을 최대한 활용하도록 컴파일하고 최적화합니다. '구문 표현 (syntax)' 과 '표준 라이브러리' 는 코드 작성 방식은 명백하면서도 성능은 최고가 돼야 한다는 '기본 원리' 에 기초하여 설계되었습니다. 이러한 안전성과 속도의 조합은 스위프트를 "Hello, world!" 에서부터 '전체 운영 체제' 에 이르기까지 모든 것에 대한 탁월한 선택이 되도록 합니다.

스위프트는 최신의, 가벼운 구문 표현을 사용하여 강력한 '타입 추론 (type inference)' 과 '패턴 맞춤 (pattern matching)' 을 조합함으로써, 복잡한 아이디어도 명확하고 간결한 방법으로 표현할 수 있게 해줍니다. 그 결과, 코드를 작성하기만 쉬워진게 아니라, 이해하고 유지하는 것도 더 쉬워졌습니다.

스위프트는 수 년간 다듬어져 왔으며, 새로운 특징과 보유 능력을 가지고 계속 진화하고 있습니다. 스위프트에 대한 우리의 목표는 원대합니다. 여러분들이 이것으로 무엇을 만들지 정말 정말 기대됩니다.

### 다음 장

[Version Compatibility (버전 호환성) >]({% post_url 2020-03-15-Version-Compatibility %})

### 참고 자료

[^About-Swift]: 원문은 [About Swift](https://docs.swift.org/swift-book/) 에서 확인할 수 있습니다.

[^modern]: 'modern' 이란 말에는 '현대' 라는 의미와 '최신' 이란 의미가 모두 담겨 있습니다. 그러므로 '현대 언어' 라는 말을 '최신 언어' 라는 말로 대체해도 상관없습니다.

[^modern-programming-patterns]: 이 역시 '최신 프로그래밍 패턴' 으로 이해해도 무방합니다.
