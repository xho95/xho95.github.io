### Issues

#### Stack View

* 추론 사이즈()가 3개 이상이 되면 조절이 안된다. 적어도 하나의 값이 고정되어 있어야 하는 것 같다.

#### Swift 3

* 증감 연산자 없어짐 : 함수형 언어와 관련 - for 구문에서 index의 mutable 부분을 없앰
* Scalar 함수형 언어 강의 : 함수형 언어를 이해하는 데 도움 - Scalar : 마틴 오더스키

#### Package Manager

* Swift Package Manager : 아직 베타 버전
* CocoaPods : 정식 버전 1.0 나옴

#### 맥 사용

* Mac 안되는 곳 : 하나은행, 홈텍스

* 장점 : 안꺼도 됨
* 단점 : 프로그램 지울 때 - 찾아서 지우는 것이 좋다.
	* 추천 프로그램 : AppCleaner
	* 윈도우용 프로그램을 포팅한 것들이 문제가 많다.

#### LG 채널 플러스

* TV에서 기존 채널 외에 인터넷 방송 등의 자료를 TV에서 볼 수 있도록 지원(?)
	* 기존 IP TV : 전용 셋탑 박스 필요
	* 채널 플러스 : TV 자체에서 기능 지원

#### 넷 플릭스

* 최고 갑 : 사용율 높고 중남미 등은 석권 - 넷 플릭스가 원하는 대로 만들어야 함(?)
* TV 등에 넷 플릭스가 설치되어 있어야 함(?)

#### 코드 관리

* GitHub
* Gist : Sample Code 업로드
	* 단점
		* 파일 단위 - UI 등이 조금 불편함
		* API - 검색 API가 없음
	* 장점 : 버전 관리가 됨
* Dash : 유료 전환됨
	* 단점 : 터미널에서 사용할 수 없음 	

#### Editor : vi

* vi : atom, visual studio code 등등 해도 가장 효율적(?)
* Bundle : vi 용 패키기 매니저

* vi 익히기 : YouTube 자료 참고하면 좋다.

* 화면 분할 : sp - 수평 분할, vs - 수직 분할
	* 숫자를 입력하면 어느 정도 분할할 지 정할 수 있다.

### 구문 반복

* 좋은 자료 : [Swift - Collection 타입의 도구들: map, filter, reduce, zip](http://seorenn.blogspot.kr/2014/07/swift-array-map-filter-reduce.html)

* forEach : 리턴값이 없이 동작을 반복한다.
* reduce : 리턴값이 있다.
* map :
* filter : bool 값으로 false를 빼고 걸러준다.

### forEach

* range 구문과 결합시 주의가 필요함

```
[1...10].forEach { Range<Int> in ... } - loop를 한번만 돈다.
```

```
(1...10).forEach { (range: Int) in ... } - loop를 10번 돈다.
```

### 아기 앱

#### 기록할 정보

* 기본 : 아기 정보 - 태어난 날, 사진

* 분유 양, 시간 : 입력은 일단 pickerView 이용
* 귀저기 교체 시간, 종류
* 수면 회수, 시간

* 통계 : 비교 대상이 되는 표준 정보가 필요 - 공개된 의학 정보 있음

#### UI Visual Effect

* background blur : component가 있다. - **Visual Effet View with Blur**
* floating button

* UI는 일단 기능을 만든 다음에 변경할 수 있도록 함
