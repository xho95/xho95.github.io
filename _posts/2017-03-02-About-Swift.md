---
layout: post
comments: true
title:  "Swift 5.7: About Swift (스위프트에 대하여)"
date:   2017-03-02 10:00:00 +0900
categories: Swift Language Grammar About
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.7)](https://docs.swift.org/swift-book/) 책의 [About Swift](https://docs.swift.org/swift-book/) 부분[^About-Swift]을 번역하고, 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.7: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## About Swift (스위프트에 대하여)

스위프트는, 전화나, 데스크탑, 서버, 또는 코드를 실행하는 다른 어떤 것에든, 환상적인 방법으로 소프트웨어를 작성합니다. 안전하고, 빠른, 대화형 프로그래밍 언어로써 폭넓은 애플 공학 문화의 지혜와 오픈-소스 공동체의 다양한 기여를 최고의 최신 언어 사고 방식[^modern] 과 조합한 것입니다. 컴파일러는 성능을 최적화하고 언어는 개발을 최적화하면서도, 어느 쪽과도 타협하지 않습니다.

스위프트는 새로운 프로그래머에게 친절합니다. 산업계-품질의 프로그래밍 언어면서 스크립트 언어처럼 표현력이 풍부하고 즐겁습니다. 플레이그라운드 (Playground)[^playground] 로 스위프트 코드를 작성하면, 앱 제작과 실행의 부담없이, 코드 경험도 하고 결과도 곧바로 보여줍니다.

스위프트는 최신 프로그래밍 패턴[^modern-programming-patterns] 을 채택함으로써 공통인 프로그래밍 에러의 큰 부분을 정의하여 날려버립니다:

* 변수는 항상 사용 전에 초기화합니다.
* 배열 색인은 경계를-벗어난 에러를 검사합니다.
* 정수는 값 넘침[^overflow] 을 검사합니다.
* 옵셔널은 `nil` 값 처리를 명시하도록 보장합니다.
* 메모리는 자동으로 관리합니다.
* 에러 처리는 예상치 못한 실패를 제어하여 회복하게 합니다.

스위프트 코드의 컴파일과 최적화는 최신 하드웨어를 최대한 끌어냅니다. 구문 및 표준 라이브러리의 설계는 명백한 방식으로 작성한 코드가 수행도 최고인게 좋다[^the-obvious-way] 는 기본 원리를 따릅니다. 안전성과 속도의 조합은 "Hello, world!" 부터 전체 운영 체제까지 모든 것에서 스위프트가 탁월한 선택이도록 만듭니다.

스위프트는 강력한 타입 추론 및 패턴 맞춤을 최신의, 가벼운 구문과 조합하여, 복잡한 아이디어도 명확하고 간결하게 표현하게 합니다. 그 결과, 코드 작성만 더 쉬워진게 아니라, 이해하고 유지하는 것 마저 쉬워졌습니다.

스위프트는 수년간 만들어지면서, 새로운 특징과 보유 능력을 가지고 계속 진화하고 있습니다. 스위프트에 대한 우리의 목표는 원대합니다. 이걸로 무엇을 만들지 정말 기대됩니다.

### 다음 장

[Version Compatibility (버전 호환성) >]({% post_url 2020-03-15-Version-Compatibility %})

### 참고 자료

[^About-Swift]: 원문은 [About Swift](https://docs.swift.org/swift-book/) 에서 확인할 수 있습니다.

[^modern]: 원문에서 사용한 **modern** 이란 단어는 현대라는 의미와 최신이란 의미를 둘 다 담고 있는 말입니다.

[^playground]: '플레이그라운드 (playground)' 는 직역하면 놀이터라는 의미인데, 애플에서 별도로 제공하는 개발 도구이기도 합니다. 애플 앱스토어에서 **Swift Playgounds** 라는 앱을 다운받을 수도 있고, 엑스코드 (Xcode) 안에서 플레이그라운드 프로젝트를 별도로 생성할 수도 있습니다. 

[^modern-programming-patterns]: 이 역시, 최신 프로그래밍 패턴으로 해석해도 무방합니다.

[^overflow]: 일부러 '값 넘침 (overflow)' 을 의도할 수도 있습니다. 이에 대한 더 자세한 내용은 [Overflow Operators (값 넘침 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#overflow-operators-값-넘침-연산자) 부분을 참고하기 바랍니다.

[^the-obvious-way]: 우리말 속담 중에 **보기 좋은 떡이 먹기도 좋다** 와 비슷합니다. 스위프트의 최적화가 좋아서, 뛰어난 성능을 내는 코드를 깔끔하고 단순하게 작성할 수 있다 정도의 의미입니다.
