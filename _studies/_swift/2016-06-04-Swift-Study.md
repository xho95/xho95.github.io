### 이슈

* 뜨는 언어 : Rust가 핫함

#### AutoLayout : 김준형님

* 반응형 UI
	* 개발 중인 앱에서 아이의 얼굴이 스크롤에 따라 커졌다 작아졌다 함
	* 코딩으로 만듬 : ScrollView와 ScrollView 사이의 제약으로 만듬
	* tableView도 ScrollView에서 상속받은 거라 ScrollView의 속성을 가지고 있음
	* 구속 조건의 우선도를 사용하여 하나의 구속 조건을 변경시킴

	* tableView의 경우 구속 조건을 주는 것을 코딩으로 할 수 밖에 없을 것이다(?) : storyboard에 따로 보여지는 속성이 없다(?)

#### PageView : 김준형님

* View 간에 값의 싱크를 맞춰줄 경우
	* self를 넘겨줘서 처리하게 하는 방법 : 의존성이 생길 수 있다(?)
	* Notification 사용 : 의존성 없이 값을 전송해 준다.
* PageViewController
	* 특정 View가 나타날 경우의 상황을 알 수 없다(?) - ViewController가 아니라 View의 ViewWillAppear 등을 통해서 알아야 한다.
	* 여러 개의 View를 사용할 경우 viewDidLoad 보다 viewWillAppear 을 사용해야 한다.
	* 장점 : 사용성이 좋다 - 익숙한 UI (예) 달력 UI)
* ViewController 위에 ViewController를 Modal로 띄울 경우
	* 일반적으로는 앞의 View가 뒤의 View를 완전히 가려버리며 배경이 검어진다.
	* **Presentation** : **Over Current Context** 로 선택한다.
	* **Background** : **Clear** 로 설정한다.

#### Protocol Extension : 김준형님

* Protocol Oriented Programming : Protocol을 사용해서 선택적으로 기능을 확장할 수 있다.

#### View 사이의 Animation 전환 : 김준형님

* custom segue 를 통해서 처리하는 것이 좋다.

#### 크롬 캐스트 : 김진형님

* 미러링 도구 : 화면 전송, 공유
* 크롬 브라우저로 동작 : 따로 앱을 설치하거나 코덱 같은 것이 필요없다.


#### Firebase : 김진형님

* Cloud DB : 서버 개발이 필요없을 정도
	* 비용 : unlimited - $5 / GB
	* 작년에 구글에서 인수함
	* RDB가 아니라 NoSQL 방식
	* Realtime DB
	* 로그인도 구글 ID로 된다.
* [Firebase](https://console.firebase.google.com/)
* Push : 안드로이드 - GCM, 애플 -
	* 아이폰, 안드로이드 상관없이 앱 전체에 푸쉬 가능
	* 무료로 사용가능
* 문제점
	* 자체 SDK 가 느리다.
	* 다른 것은 놓침
* 지금 BabyTale을 만들어도 Firebase를 사용을 고려해볼만하다.
	* 단점 : Cloud에서 모든걸 처리한다. 비지니스 로직이 중복으로 사용된다(?)
* Heroku : 서버를 제공한다.


#### MVVM : 김진형님

* ContainerView 활용 : View Model 역할을 함 - ViewController 재사용 가능
* [파크히어 Realm 사용 사례](http://www.slideshare.net/sunhyouplee/realm-60539221)
* [프로토콜 지향 MVVM을 소개합니다.](https://realm.io/kr/news/doios-natasha-murashev-protocol-oriented-mvvm/)
* [[WPF] MVC, MVP, MVVM 차이점 :: 공대인들이 직접쓰는 컴퓨터공부방](http://hackersstudy.tistory.com/71)

#### Extension 사용

* Extension을 하게되면 다른 파일로 분리하는 것이 트렌드인 것 같다.
	* 예) UIViewController가 UITableViewDelegate를 conform하면, 해당 부분을 extension으로 뽑아 내고, 이를 다시 다른 파일로 분리해서 구분한다. (이 경우에는 파일로까지 분리할 필요는 없을 듯)
* NSManagedObject를 상속받는 class도 이런 의도로 두 개의 파일로 분리하는 것 같다.	  

#### CocoaPods

* Image Slider 등의 라이브러리를 활용

#### DateFormmater

* local 고려 필요(?)

#### freenom

* 국가 이름을 domain으로 사용(?)

#### MagicVoxel

* [MagicaVoxel](https://voxel.codeplex.com)
	* 간단한 3D 도트 그래픽 툴
	* 무료, 상용으로 사용 가능

#### IPv6

* [애플의 IPv6 관련 리젝트 정책에 대한 해결 방법](http://lab.gamecodi.com/board/zboard.php?id=GAMECODILAB_Lecture&no=458)
* [애플, 모든 앱 6월 1일부터 IPv6-only 네트웍 지원해야 한다고 말해 | www.itcle.com](http://www.itcle.com/2016/05/05/애플-모든-앱-6월-1일부터-ipv6-only-네트웍-지원해야-한다고/)


### BabyTale : 진행 사항

#### CoreData 부분 추가 : 김준형님

* 데이터 타입을 `enum`을 쓰지 않고 CoreData 안에서 처리하도록 수정
* 관계형 DB로 상속과 같은 개념을 구현(?) : **Parent Entity** 를 사용

- enum을 사용하는 방식
	- 장점 : 서버쪽 부분이 간단해 진다.  	
	- 	과 서로 trade-off 관계인 듯 하다. : 서로 간의 장단점이 있는 부분인 듯 함

- CoreData Scheme 에서 상속받는 방식
	- 장점 : 현재 트랜드에 맞는 방법
	- 단점 : 서버쪽이 복잡해진다(?) Schema가 복잡할 경우 쓰기 힘들 수 있다(?)

#### 다른 부분

* Issue와 연결 되는 부분이 많아서 issue 부분에 정리
