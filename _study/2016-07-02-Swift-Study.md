### Issues

#### 스터디 소개

* 새로 오신 분 : 박범우

#### Core Data

* 밑 단의 DB는 사용자가 바꿀 수 있다.
* WWDC 2016 변경 사항
* Faults
	* Faults : DB 실패 처리(?) 
	* AKA : Unknown As 
* Generation
	* Context : 하나의 Session으로 볼 수 있다.
* Concurrency
	* some methods 
	* 비동기 옵션을 줄 수 있다.
* CoreDataStack
	* NSManagedObjectModel : Entity에 일대일 대응되는 클래스(?) - Schema
	* NSPersistentStoreCoordinator : Lock을 걸어주는 등의 관리자 역할
		* DB 저장소가 바뀔 때 Coordinator 를 사용하게 된다.
	* NSManagedObjectContext : 실제 개발자단에서 사용하는 클래스

	- 문자열로 인덱싱하는 방식이 다 바뀐다.
	
	```
	Subclass.entity()
	Subclass.fetchRequest() 		// Select 역할
	Subclass. ...
	```

* CoreData DB 장점 
	* 파일 핸들링을 지원해준다. 
	* sqlite에서는 직접 파일 핸들링이 안된다.

* 기존 CocoaPods의 라이블러리들 중에 Core Data를 편하게 사용할 수 있게 해주는 라이브러리들이 많이 있다.

* 정리
	* Core Data 자체에 신기술이 적용됐다기 보다는 Swift를 중심에 두고 사용성을 향상시켰음 	
#### 맥 파일 교환

* AirDrop도 느리다.
* DropBox를 사용하는게 더 빠르다.
* 네트워크에서 FTP를 사용하는 것이 더 좋을 수 있다 : 애플 스크립트로 작성 - 준형님
	
#### SceneKit 소개

* 기존 코드 및 새로운 부분 
* Fox 예제 설명

#### 프로젝트 소개

* 박범우 님
	* 여행 앱 : 뼈대 UI 설계
	* 병원 앱 : 졸업 과제 - iBeacon 사용하여 환자 관리(?)

#### 마크다운 라이브러리

* MMMarkdown : 웹뷰 기반 라이브러리가 표현력이 좋다 - 소스도 웹으로 되어 있다.
	
#### C Pointer 적용

* C 스타일 포인터 사용

```
UnsafeMutablePointer<Int>.alloc()
```

#### GitHub .gitignore

* 한 Repository에 여러 프로젝트를 push하는 방법
* Xcode 프로젝트가 아니라 따로 전체 폴더에서 Git을 사용

#### awesome-ios

* GitHub에 올려진 iOS 관련 유익한 자료 모음
* 라이브러리, 프레임웍, 기타 Swift 개발에 유용한 자료들을 망라한 Repository

#### Protocol Extensions

* 인터페이스의 필요한 부분만 protocol로 옮겨서 해당 protocol을 confirm하는 객체만 사용할 수 있도록 한다.
* 상속이 없어지니까 테스트가 편함
* 기존 코드에 대한 의존성 없이 새로운 코드를 추가할 수 있다.

#### forEach

* 사용하지 않는 것이 좋다고 인터넷에 소개됨
* for-in 구문보다 비효율적이므로 현재는 for-in 구문을 사용하도록 하자.

#### Animated Tab Bar

* [RAMAnimatedTabBarController](https://github.com/xho95/animated-tab-bar) : Ramotion Inc. 에서 만든 애니메이션 가능한 탭바 라이브러리 - GitHub에서 받을 수 있다.
* 생각보다 사용법이 까다로움
	
### BabyTale

#### 그래프 라이브러리

* Charts : CocoaPods 라이브러리

#### Opening Input View Controler

* Storyboard Reference : 코드 없이, 유지보수도 편하게 화면 전환에 대한 부분을 설계

#### Autolayout flag

* 아기 얼굴 줄이는 효과
* delegate 패턴이 아니라 notification을 활용 : iOS에서 느려지지도 않고 잘 작동함



