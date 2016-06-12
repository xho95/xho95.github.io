### 이슈

#### WWDC 2016

* Swift 
	* Swift Package Manager
	* Visual Studio

#### tableView slide

- app store 같은 슬라이드 가능한 메뉴 구현
- tableView 속에 collectionView 사용
- tableView 속에 tableView 넣어서 구현 가능(?)
	
#### collectionView Scroll 설정

* **Layout** : **Flow**
* **Direction** : **Horizontal**
	
#### extension 활용법

- 기존 class에 상속이나 protocol을 적용할 경우 extension을 써서 관련 코드를 기존 코드에서 분리하자.
- extension을 막을 수 있는가 : 	`final`
- extension은 따로 막을 수 있는 방법이 없어 보인다.

#### Storyboard

* Storyboard가 나오면서 협업이 힘들어진 부분이 있다(?)

#### Segue

* dismiss는 떠있는 View가 기준이된다 
* segue를 활용하면 원점 View를 기준으로 동작이 된다. 

	
### BabyTale App

#### Refactoring

* ContainerView
	* 화면의 단위 : Scene
		* Scene 안에 ViewController가 들어간다.
		* 여러 View를 전환할 때 매끄럽게 동작하기 힘들 수 있다.
	* ContainerView는 View를 알아서 치환해주는 개념이다.
	* ContainerView 안에서 PageViewController를 넣어서 스크롤 가능하게 만든다.
	* 여러 ViewController에서 공통 View를 segue로 연결하면 component 처럼 사용할 수 있다.
	
* View 사이즈 맞추기 : 꼭 필요한 것은 아님 - **Free**로 설정

* PageViewController
	* 장점 : 리소스 관리가 된다.
	* ScrollView는 전체 View를 다 메모리에 올리지만, PageViewController는 보이는 부분만 메모리에 올린다(?) 

* ModalView로 이전 View 일부만 가리기
	* Custom Segue를 활용
	* Dimmable protocol을 활용한다.
	* **Presentation** : Full Screen > **Over Current Context** 로 수정한다.

#### Core Data

* Editor에서 상속과 유사한 방식으로 관계를 설정할 수 있다. 
* 상속을 활용하면 sellect 등을 할 경우에도 장점이 있다. 상위 클래스를 sellect 함으로써 유사한 table을 다 가져올 수 있다. 

#### NSNotificationCenter 

* app 하나에 적용되는 singleton 인 듯 하다.
* observer로 등록하면 해당 view들에 변경 사항을 통지한다.
	* 키 이름이 같으면 observer로 등록할 수 있다.
* PageViewController의 경우 현재 보이는 View가 무엇인지를 알려주지 않는다. 

#### 기능 추가 사항

* CallenderViewController : 변혁진
	* 날짜를 선택하면 달력을 띄워서 날짜를 변경할 수 있도록 한다.
	
* ImagePickerViewController : 김민호
	* 아이 얼굴 아이콘을 누르면 앨범에서 사진 추가하고, 카메라를 선택하면 아이 사진을 찍어서 올릴 수 있도록 한다. 
	
* CollectionView, Network 준비 : 김진형 

* 다음주부터 코딩 참여 : 박준일





