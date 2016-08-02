### 이슈

#### 스터디 진행 방식

* 컨셉이 필요하다.
* 공통 관심사 : Swift - 대표앱을 만들어보자.
	* StudyiOS 블로그에 프로젝트 공간이 있음
	* 각자 추진중인 프로젝트를 정리하도록 함
	* 프로젝트 맵을 만들 예정 : 코드 쉐어
	* 목표 : 오픈소스 프로젝트
		* 준형님 : HTML 파싱 - 앱스토어 랭킹 분석, 뒤에서 상세 설명함

#### 아이콘 제작

* 아이콘 : 사과 안됨, 제비도 안될 것임
* 아이콘 일괄 제작에 용이, 템플릿 
* YouTube 강좌 : [iOS App Icon Design Tutorial in Photoshop - For Beginners](https://www.youtube.com/watch?v=jpRBucuml2M)
* 앱아이콘 템플릿 사이트 : [AppIcon Template](https://appicontemplate.com)
	
#### HTMLParsing 

* GitHub 자료 : 김준형님
* CocoaPods 라이브러리 : **[HTMLKit](https://github.com/iabudiab/HTMLKit)** 사용
* `String`에 url을 넣으면 바로 컨텐츠를 가져올 수 있다.
	* **info.plist**에 보안 관련 옵션을 추가해야 한다.
	* HTTPS가 아니라서, HTTP에서 필요한 옵션이다. 
	* **NSAppTransportSecurity** : **NSAllowsArbitraryLoads**
	* [iOS 9 ATS 보안규정, Xcode 7 기반 iOS 9 앱의 HTTP 네트워크 연결 차단 이슈](http://blog.naver.com/sqlpro/220485058339) 
	* 옵션 설명 : [Cocoa Keys](https://developer.apple.com/library/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW33)
* `querySelectorAll` : 해당 키 값에 해당하는 요소들을 뽑아온다.
	* 키에 넣을 CSS 규칙 : [CSS Selector Reference](http://www.w3schools.com/cssref/css_selectors.asp) 참고
* `webView.loadHTMLString(item.innerHTML, )` : 하위 요소만 뽑을 수 있다.

* 외부 통신에서는 NSAppTransportSecurity 사용
* 내부 앱끼리의 통신에서는 Scheme 사용 : 앱에서의 Scheme과 다르다(?)
	* 참고자료 : [iOS9에서 새로 생긴 url scheme 관련 변경 사항](https://medium.com/@blueprajna/ios9에서-새로-생긴-url-scheme-관련-변경-사항-71d22f5926e1#.7ouvcmesu)

* 고려할 점
	* NSURL은 주소만 된다.
	* POST 등의 옵션을 주려면 NSURLSession을 사용해야 한다.

#### Global Key 설정 이슈

* System Preference에서 설정을 해줘야 한다.

#### NSOrderedSet

* Set처럼 한 요소만 가지면서, 넣는 순서대로 저장

#### NSHashTable, NSMapTable

* NSMapTable : Dictionary와 유사하다.

#### NSLocale

* 강제로 앱의 특정 부분을 다른 언어로 설정할 수 있다(?)
* `NSLocale(localeIdentifier: "en")` 처럼 사용

#### NSNotificationCenter block 이슈

#### Regular Expressions

* 사용 : 가끔씩 동일한 패턴을 너무 많이 사용하게 될 때 사용

1. single digit 매칭 : 한 글자 매칭
2. 매칭 체인 : 한 단락(?)
3. 그룹 매칭 : 레퍼런스 처럼 응용이 됨
	* 예) `(apple)name\1` : applenameapple 찾음

* Xcode Find에서도 사용 가능
* email form, url form 등에도 사용
* 참고자료 : [regular expressions 101](https://regex101.com)

#### iCloud 이슈

* 동기화 문제
	* 인터넷이 안되면 로컬에 저장하는데 이 때 Core Data 사용
	* 파일 크기에 따라서 연결이 잘 안되는 경우가 있다. - 1MB(?)
	* 참조 URL 사용하여 파일 이름만 DB에 저장(?)

#### 이력서 살펴보기

* Vingle
* GCD : `NSOperationQueue`

#### Docker

* 기존 : 서버 호스팅 관리 - 하드웨어 스펙 결정
* 가상 서버
	* 하나의 서버에 여러 OS를 사용할 수 있는 개념
	* 하나의 서버 세팅을 Docker 이미지로 저장한다. 
	* 서버의 하드웨어 레이어랑 소프트웨어(OS) 레이어를 분리한 듯 한 개념

#### Playground 이슈
	
* 조금 불안정함
	
#### Xcode 폴더 구조	

* 파란 폴더 : 레퍼런스 folder - 실제 외부 폴더가 있다.
* 노란 폴더 : group folder - 물리적인 폴더는 따로 없다, 프로젝트 내에서만 구분
	
* `NSBundle.mainBundle().bundleURL` : 실제 폴더 경로에서 찾는다.
* iOS와 macOS가 bundle 구성이 조금 다르다. : 맥은 URL에 "Contents/Resources/..."를 붙여야한다.

#### Gori 앱 출시

* 리딤 코드
* 버그 리포팅