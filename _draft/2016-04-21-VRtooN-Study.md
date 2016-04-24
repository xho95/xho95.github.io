---
layout: post
title:  "VRtooN 스터디 정리"
date:   2016-04-21 13:30:00 +0900
categories: Study VR aFrame.io Javascript
---


### chrome 개발자 도구

개발자 도구의 console 창에서 명령을 입력해서 결과를 브라우저 창에서 볼 수 있다. 디버깅 등에 유용할 것이다.

### querySelector

querySelector 는 최초의 하나만 가져온다.

querySelectorAll 라는 것이 따로 있다.

MDN 의 도움말을 참고하자! - Mozilla


### Javascript

같은 자바스크립트라도 브라우저마다 결과가 다를 수 있다.

크로스브라우저 테스트가 필요하다.

### electron

electron으로 데스크탑 앱을 만들면 chrome 최신 버전 기능을 쓸 수 있다.

chrome에서 제공하지 않는 기능은 npm 모듈을 불러와서 쓸 수 있다.

### a-animation

a-animation은 component와는 다르다. a-entity 밑에 component 처럼 들어가지는 않는다.

### getAttribute, getComputedAttribute

getComputedAttribute는 모든 속성을 보여준다? 좀 더 정리하자.

### setObject3D

three.js 3d 객체를 만든다? 좀 더 정리하자.

### 출석부

변하지 않는 것 - 날짜, 시간 - 반 속성 테이블, 회원이 듣는 반이 나열된 테이블, 회원이 출석할 때마다 되는 테이블 - 3개의 테이블을 조인

날짜에 대한 테이블 - 연, 월, 요일, 반이름
반에 대한 테이블 - 요일, 시간, 등록한 사람
출석에 대한 테이블 - 출석시간, 반, 출석한 사람 이름 - 회원의 하위 개념으로 출석 액션
회원에 대한 테이블 - 이름,

변하는 것 - db와는 맞지 않을 수 있다... update, select

#### StudyiOS

월, 일, 년 테이블(?) - 통계 테이블 구분 필요 - star 스키마 - 출석율, 등등을 구현, - fact, demension - 미리 구현해서 실시간성을 높임

최근 RDB 기반 빅데이터 분석 - 하둡... 등등... - star 스키마는 원론적인 관점

회원 테이블, 클래스 테이블, 출석 (언제, 어디에, 누가) - 끝

domain model - OOP 개념으로 접근
object 들의 relation을 그린다. - 기능 : method

속성  : db의 테이블이 된다.

db model - 물리적인 db

Core Data - data model을 그릴 수 있다. 확인해 보자. 

Core Data tutorial 참고

Data Warehouse (?), ETL - spoon 등 - 최근에는 빅데이터 분석으로 변화. log 데이터가 많이 쌓임 - Star 스키마의 한계 - 분산 DB, 하둡, spark 등등 으로 해결하려고 노력중

액션에 대해서 log data를 잘 담는게 중요(?) - 최근, log도 JSON으로 다 담는다(?) - logging을 비동기로 처리하는 방법도 필요

Jsession (?)


