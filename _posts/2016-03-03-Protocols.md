---
layout: post
title:  "Swift 문법 정리: 프로토콜 확장(Protocol Extensions)에 구속조건(Constraints) 추가하기"
date:   2016-03-03 23:30:00 +0900
categories: Xcode Swift Grammar Protocols
---

### 프로토콜 확장(Protocol Extensions)에 구속조건(Constraints) 추가하기

프로토콜 확장(Protocol Extensions)을 정의할 때는, 구속조건(Constraints)을 지정해서 프로토콜을 따르는 타입들이 조건을 만족할 때만 확장에 있는 멤버 함수들과 속성들을 사용하도록 할 수 있습니다. 이 구속조건은 프로토콜의 이름 뒤에 `where` 구절을 사용해서 붙일 수 있습니다.

예를 들면,

{% gist 3ce1e821852d0debf646 %}

<script src="https://gist.github.com/xho95/3ce1e821852d0debf646.js"></script>
