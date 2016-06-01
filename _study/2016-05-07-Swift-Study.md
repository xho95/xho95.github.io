### Slide Menu

* master-detail view 와의 차이 
	* side bar menu
	* main이 detail view라고 봐야한다.
	* menu가 나오면 전체 화면을 덮어버린다.
	
* revealViewController 
	* slide menu를 만들기 위한 프레임웍
	* CocoaPods을 지원함 - MIT 라이센스
	
	* **sw_rear** : menu view의 Segue identifier의 이름을 맞춰줘야 한다. - segue에는 class 이름도 지정해줘야 한다.
 	* **sw_front** : detail view의 identifier 이름, class 이름도 지정해야 한다.
 	* **SWRevealViewController** : NavigationController의 class 이름을 지정해야 한다. - **문제 발생**
 	
* 문제 해결
	* SWRevealViewController는 NavigationViewController를 쓰지 않는다. 그냥 UIViewController를 사용해야 한다.
	* SWRevealViewController 는 UIViewController를 NavigationViewController로 사용한다.
	* 각 Detail View 마다 class를 SWRevealViewController로 지정해줘야 한다.
	
	* **SWRevealViewSetController**, **SWRevealViewPushController** 두 개로 나눠진다.

* gesture 추가
	* viewDidLoad 에 작성
	* **self.view.addGestureRecognizer()** 사용

	
### Alamofire

* restful 라이브러리 : HTTP 리퀘스트 라이브러리
	* AFNetworking와 비슷한 라이브러리, Alamofire와 같은 개발자들이다.
	* AFNetworking의 Swift 버전인 듯 하다.
	
* slack에 hook을 날리는 방법
	* slack의 **incoming webhook** 참고
	* **curl** : http request 날리는 소프트웨어(?) 사용 - 터미널에서 테스트 가능하다.
	* **Alamofire.request()** 사용
	* requesetBody는 Dictionary 타입이다.
	
* 문제 발생
	* status code : 500 - server internal error, 서버에서 튕기는 문제
	* status code : 200 - 정상일 때 코드
	
* 문제 해결
	* Sever에 맞는 JSON 양식으로 만들어줘야 한다. : "payload"를 key로 하는 JSON 문법 구문

### Responder Chain으로 버튼 만들기

* responder chain
	* first responder 를 전체 프로그램에서 공유가능하다. - first responder에 이벤트가 있다. 
	* first responder에 action 추가
	* global 버튼을 만드는 효과를 얻을 수 있는 듯 하다.
	* AppDelegate에서 이벤트를 받는다. Action의 구현체를 AppDelegate에서 구현
	* ViewController에 구현체를 넣어도 되지만 AppDelegate에 구현체가 있으면 ViewController의 구현체는 호출이 안 될 것이다.
	
* graphic layer에서 key 값을 얻을 때 쓰는 디자인 패턴

### 좌표를 주소로 변환하기

* CoreLocation을 사용 : CLGeocoder
	* **geocoder.reverseGeocodeLocation()** 	
	* 문제 발생 
		* address는 optional이다.
		* JSON string 안에 optional이 전달되면 서버에서 해석이 안된다.
	* 문제 해결 
		* guard 등으로 optional을 벗겨서 넣어줘야 한다.

* Daum Map API 활용
	* **MTMapReverseGeoCoder** 	사용 : 헤더 파일 import
	* static method 제공 : **MTMapReverseGeoCoder.findAddressForMapPoint()** - 동기 방식(?)
	* 문제 발생
		* 동기, 비동기 방식 - 동기 방식일 때는 상관없이 되야 한다.
		* 주소가 nil로 들어온다.
	* 문제 해결
		* DaumMapKey도 optional이다. - key 값을 직접 전달하면 된다. 넘길 때 optional을 풀어 넣으면 될 수 있을 것이다. 
	
## 이슈
 	
### 위젯 배경 투명화

**System Preferences > Misson Control > Dashboard > As Overlay**
**Hot Corners...** : Dash 보드 나오는 곳을 지정할 수 있다.

### Objective-C import 파일 경로

* 쌍 따옴표 : 절대경로 기준
* 꺽쇠 : 프로젝트에서 경로를 알고 찾을 수 있을 때

### lldb console 사용하기

* **po** : print object - 디버그 시에 **(lldb)** console에서 명령을 사용할 수 있다.

### slack으로 logging 하기

* 웹의 게시판, 앱의 로깅 등에 slack을 사용한다. - slack hook을 사용
* CI : Customize Integration(?) - 빌드를 전문으로 하는 프로젝트(?)
	* Jenkins : CI 툴 - 빌드 자동화 툴
	* 모빌(MoBil) : Kakao에서 CI 만든 툴 - JIRA 기반
	* Naver도 JIRA 기반 툴을 만들어 쓴다(?)
* **/build ...** : slack으로 CI에 빌드를 걸 수 있다.	

### 다음 프로젝트

* 김진형님
	* 앱 이름 : 제테크의 신 - mockups-gdrive-bmpr.appspot.com
	* customize view : view의 재사용이 목적
	
* 고재승님
	* 아이용 다이어리 : 아이들 귀저기, 밥먹기 스케쥴 앱 
	* 탭바 사용(?)
	* 맘스 홀릭 등에 홍보 
	* 아이관련 무료 아이콘 사용
	
