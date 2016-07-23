### 스터디 브리핑

* 일자 : 2016년 7월 22일
* 참여자 : 김희제, 김민호 - 참관 : 윤희동

### 이슈

#### `extension` 관련 컴파일 에러 디버깅

* 발생 에러
	* 명칭 : Declarations from extensions cannot be overridden yet
	* 상황 : 특정 클래스의 extension 부분에 선언한 함수를 재정의할 수 없음

* 해결 방안
	* 문제 : extension으로 확장한 클래스가   
	* `@objc`
	* 상황 : Swift에서 만들거나 확장한 함수가 objective-C도 지원해야할 경우 사용
	* 대안 : 클래스의 경우 `NSObject`를 상속받으면 자동으로 `@objc`가 적용됨
	 
* `@nonobjc`
	* 상황 : Swift 내에서는 objective-C 함수로 인식하고 있을 경우 사용 
	* 의미 : 해당 함수가 objective-C 함수가 아님을 선언



#### Unit Test

* 앱 출시전 개발 단계에서 테스트
* 1인 개발에서는 잘 안하는 습관이 듦
* 기획자 : 시나리오 대로 진행, 리포팅, 재현 문제
* Way의 경우
	* 설정에서 언어별로 테스트
	* UI 테스트

#### Alamofire

* RxAlamofire : HTTP Parsing 등을 할 수 있는 통신 관련 라이브러리

### WWDC 2016에서의 Swift 변경사항

#### GCD 

* WWDC 영상 링크 : [Concurrent Programming With GCD in Swift 3](https://developer.apple.com/videos/play/wwdc2016/720/)
* 변경 사항
	* 문법구조 변화
	* 함수 이름 등이 C 스타일에서 Swift 스타일로
	* 글로벌 함수 형태에서 객체의 멤버 함수 형태로 바뀜
* 미리 변화에 대비할 필요가 있음

#### Core API

* 변경 사항	
	* 함수 이름 등에 Swift 스타일 적용
	* 객체의 멤버 함수 형태로 바뀜 : 코딩량이 줄어듦

### 다음 주 할 일 

지난 주 계획을 다음 주에 이어서 실행
