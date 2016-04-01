---
layout: post
title:  "Swift Study 20160401"
date:   2016-04-01 19:30:00 +0900
categories: Study Xcode Swift Grammar
---


### GitHub 계정 만들기

* project fork

### Xcode에서 GitHub 사용하기

* first pull request

### Source Analisys

* LaunchScreen.storyboard 를 사용해서 intro 화면을 구성할 수 없는가?
클래스는 만들 수 있는 것 같다.
* View 를 상속받을 수 만 있는 것 같다. 다만 사용자 클래스를 만들어서 정적 요소의 변화를 줄 수는 있을 것 같다. -  실행시 로딩 이미지 바꾸기 - 김희재님 아이디어...

### Refactoring

* HolderView 최적화
* start() 함수를 따로 호출하지 말고, HoldView의 init() 에서 호출해보자.
* 중복 함수 따로 빼기
* animateStrokeWithColor() 도 Layer에서 호출 가능?
* fillColor도 init에 있을 필요는 없을것 같다.

### 스터디 진행 관련 의견

* Swift 문법은 책의 내용을 좀 더 충실하게 따라가는 방식으로 하자.
* 문법 진도는 1주일에 한 chapter을 기준으로 하며, 평균 30~40쪽 분량이 된다.
* 만약, 너무 긴 chapter면 두 주로 나누며, 짧은 chapter는 합쳐서 진행한다.
