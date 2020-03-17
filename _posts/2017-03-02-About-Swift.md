---
layout: post
comments: true
title:  "Swift 5.2: About Swift (스위프트에 대하여)"
date:   2017-03-02 10:00:00 +0900
categories: Swift Language Grammar About
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [About Swift](https://docs.swift.org/swift-book/) 부분[^About-Swift]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## About Swift (스위프트에 대하여)

Swift는 최신 프로그래밍 패턴을 채택하여 일반적인 프로그래밍 오류의 큰 클래스를 정의합니다.

Swift defines away large classes of common programming errors by adopting modern programming patterns:

'스위프트 (Swift)' 를 사용하면 아주 멋진 방법으로 소프트웨어를 만들 수 있으며, 이는 휴대 전화, 데스크탑, 서버, 그 밖에 코드를 실행하는 어떤 기기에서든 마찬가지입니다. 안전하고, 빠른, 대화형 프로그래밍 언어로써 현대적 언어에 대한 통찰 중에서 가장 핵심 부분에 애플 엔지니어링 문화의 지혜와 오픈-소스 커뮤니티의 다양한 공헌들을 결합했습니다. 컴파일러는 성능에 최적화 되어 있고 언어는 개발에 최적화 되어 있으며, 어느 한 쪽도 놓치지 않았습니다.

스위프트는 새로 시작하는 프로그래머에게도 친절합니다. 산업계-수준의 프로그래밍 언어이면서도 스크립트 언어만큼 표현력이 풍부하고 개발이 즐겁습니다. 스위프트로 코딩할 때 'playground (놀이터)' 를 사용하면 코드를 실험할 수 있고 결과도 바로 확인할 수 있으며, 앱을 빌드하고 실행하는 부당도 없습니다.

스위프트는 최신 프로그래밍 패턴을 받아들여 많은 종류의 일반적인 프로그래밍 오류를 사전에 제거합니다:

* 변수는 사용하기 전에 항상 초기화 합니다.
* 배열 인덱스는 범위를 벗어난 오류가 있는지 검사합니다.
* 정수형은 값이 넘치는지 검사합니다.
* 선택형 (Optional) 은 `nil` 값이 명시적으로 처리되는지 확인합니다.
* 메모리는 자동으로 관리됩니다.
* 오류 처리는 예기치 않은 실패에도 제어된 복구를 허용합니다.  

스위프트 코드는 최신 하드웨어를 최대한 활용하도록 컴파일되고 최적화됩니다. 문법과 표준 라이브러리는 뻔한 방법으로 작성된 코드도 최고의 성능을 발휘해야 한다는 기본 원칙에 의해 설계되었습니다. 안전과 속도가 결합된 스위프트는 "Hello, world!" 에서부터 운영 체제 개발에 이르기까지 모든 영역에서 탁월한 선택입니다.

스위프트는 강력한 타입 추론과 패턴 정합 기능에 최신의 가벼운 문법이 결합되어 복잡한 아이디어도 분명하고 간결하게 표현할 수 있습니다. 그 결과, 코드 작성도 쉽지만 유지 보수는 더욱 더 쉬워졌습니다.

스위프트는 수 년 동안 제작 중이며 새로운 특징과 기능들로 계속 발전하고 있습니다. 우리는 원대한 목표를 갖고 있습니다. 여러분들이 이 걸로 무엇을 만들지 정말 기대하고 있습니다.

### 참고 자료

[^About-Swift]: 원문은 [About Swift](https://docs.swift.org/swift-book/) 에서 확인할 수 있습니다.
