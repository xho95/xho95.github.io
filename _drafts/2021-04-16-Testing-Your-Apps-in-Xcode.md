---
layout: post
comments: true
title:  "Xcode: Xcode 에서 앱 테스트하기"
date:   2021-04-16 11:30:00 +0900
categories: Xcode XCTest Swift Test
---

> 이 글은 '애플 개발자 문서' 에 있는 [Testing Your Apps in Xcode](https://developer.apple.com/documentation/xcode/testing_your_apps_in_xcode) 문서를 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 것입니다.

## Testing Your Apps in Xcode ('Xcode' 에서 앱 테스트하기)

'XCTest' 로 잘못된 논리, UI 문제, 그리고 퇴화된 성능을 감지함

### Overview (개요)

[XCTest](https://developer.apple.com/documentation/xctest) 는 자신의 능력으로 다른 추상화 수준의 테스트를 작성하도록 도와줍니다. 좋은 테스트 전략은 여러 타입의 테스트를 조합하여, 각각의 이익을 최대로 만듭니다.

테스트는, 아래 그림에 보인 것처럼, "피라미드 (pyramid)" 분포를 목표로 합니다. 앱의 논리를 다루는 빠르고, 잘-격리된 많은 수의 '단위 테스트 (unit tests)', 작은 부분들이 서로 알맞게 연결되어 있음을 실증하는 더 적은 수의 '융합 테스트 (integration tests)', 일반적인 사례에서의 올바른 동작을 '단언 (assert)' 하는 'UI 테스트' 를 포함합니다.

![Aim of the Tests](https://docs-assets.developer.apple.com/published/20b3426c34/93cc7b80-dd57-423d-be85-f937da693ec3.png)




