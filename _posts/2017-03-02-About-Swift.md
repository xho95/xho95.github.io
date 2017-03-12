---
layout: post
comments: true
title:  "Swift 3.1: 스위프트에 대하여 (About Swift)"
date:   2017-03-02 10:00:00 +0900
categories: Swift Language Grammar About
---

> 이 글은 Swift 를 공부하기 위해 애플에서 공개한 [The Swift Programming Language (Swift 3.1)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/) 책의 [About Swift](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/index.html#//apple_ref/doc/uid/TP40014097-CH3-ID0) 부분을 번역하고 주석을 달아서 정리한 글입니다. 현재는 Swift 3.1 버전에 대해서 정리되어 있습니다.

스위프트 (Swift) 는 iOS, macOS, watchOS, 및 tvOS 앱 개발을 위한 새로운 프로그래밍 언어로써 C 와 Objective-C 의 가장 좋은 점은 살리고도 C 와의 호환성은 유지했습니다. 스위프트는 안전성을 높이는 프로그래밍 패턴을 채택하고 최신 기능들을 추가하여 프로그래밍을 더 쉽고 더 유연하며 더 즐겁게 만들어 줍니다. 깔끔하고 새로운 스위프트와 성숙하고 많은 사랑을 받아온 코코아 (Cocoa) 및 코코아 터치 (Cocoa Touch) 프레임웍의 만남은 소프트웨어 개발에 대해 새로운 시각을 가지는 계기가 될 것입니다. [^clean-slate]

스위프트는 다년간에 걸쳐 만들어졌습니다. 애플 (Apple) 은 스위프트의 토대를 닦기 위해 기존의 컴파일러, 디버거, 및 프레임웍 기반들을 개선했습니다. 메모리 관리를 간소화하기 위해 자동 참조 카운팅 (ARC; Automatic Reference Counting) 도 만들었습니다. Foundation 과 코코아라는 견고한 기반 위에 구축된 프레임웍 계층들도 모든 부분에서 현대화하고 표준화 하였습니다. Objective-C 자체도 블럭, 컬렉션 리터널 및 모듈을 지원하도록 발전시켜 현대 프로그래밍 기술의 프레임웍을 받아들이는데 혼란이 없도록 했습니다. 이러한 밑작업에 힘입어 Apple 소프트웨어 개발의 미래가 될 새로운 언어를 소개하게 된 것입니다.

Objective-C 개발자라면 스위프트가 꽤 친숙할 것입니다. 가독성을 위해 Objective-C 의 매개 변수 이름을 도입하였고 성능을 위해 Objective-C 의 동적 객체 모델도 도입하였습니다. 기존 코코아 프레임웍에 같은 방식으로 접근할 수 있고 Objective-C 코드와 섞어 쓸 수 있는 호환성도 제공합니다. 이러한 공통점 위에 스위프트는 새로운 많은 특징들을 도입하였으며 이를 언어의 절차 및 객체 지향 프로그래밍 부분들과 통합하였습니다.

신규 프로그래머도 스위프트에 쉽게 접근할 수 있습니다. 산업계-품질의 시스템 프로그래밍 언어 최초로 스크립트 언어 만큼 표현이 간결하고 재밌게 작업할 수 있도록 했습니다. 플레이그라운드 (Playgrounds) 도 지원하는데, 프로그래머가 스위프트 코드를 실습하고 바로 결과를 볼 수 있는 혁신과 같은 도구로, (언어를 사용하는데) 실제로 앱을 개발하고 실행할 필요가 없도록 했습니다.

스위프트는 현대 언어의 철학에서 가장 좋은 부분과 애플 엔지니어 문화가 가진 지혜를 결합했습니다. 컴파일러는 성능에 최적화 되어 있고 언어는 개발에 최적화되어 있는데 그 어느 것도 놓치지 않았습니다. “hello, world” 에서부터 전체 운영 체제까지 개발 할 수 있는 확장성을 가지도록 설계했습니다. 스위프트는 개발자와 애플의 미래를 위한 확실한 투자입니다.

스위프트는 iOS, macOS, watchOS, 및 tvOS 앱을 만드는 놀라운 방법으로 새로운 특징과 기능을 가지고 끈임없이 진화할 것입니다. 스위프트에 대한 우리의 목표는 원대합니다. 여러분들이 이 언어로 무엇을 만들지 정말 기대하고 있습니다.

### 참고 자료

[^clean-slate]: 'clean slate'는 '오점 없는 깨끗하 상태'를 의미하는 말인 듯 합니다.
