### issue

#### Auto Layout 

* Content Hugging Priority
* Content Compression Resistance Priority

#### Baby Tale

* calendar hidden

#### Unwind Segue

* 약간의 코드가 필요 : 코드를 입력하면 ViewController의 Exit에 나타난다.
* unwindSegue는 stack의 맨 아래에 있으면 전체적으로 영향을 미치며 stack 위의 ViewController라면 어디서는 사용할 수 있다.
* 연쇄적으로 사용할 수 있는지 알아보자. 

#### 순환 참조 

* closure 에서 [weak self]를 사용한다.

#### WWDC 2016

* Protocol Oriented Programming
	* Model
		* 모델도 하나의 타입이 될 수 있다.
		* 모델에 protocol 같은 것이 적용될 수 있다.
		* 모델을 재사용할 수 있다.
	* View
		* View 재사용 : 양쪽을 염두해둔 모델을 만든다(?)
		* UIView, SKNode 등도 Layout 이라는 하나의 타입으로 묶을 수 있다. - 영상에는 Layout에 frame 속성만이 있다.
		* UIView, SKNode 모두 Layout protocol을 confirm한다.
		* LayoutCell : TableCellView 을 상속하지 말고, Composition 사용 - 새로운 타입을 만듬
		* Unit Test도 편해진다. : TestLayout을 만들어서 Layout 부분만 테스트 할 수 있다.
	* Controller
		* state도 enum으로 빼서 다른 타입으로 만든다. 
		* state 패턴을 따로 쓰지 않고 enum으로 가능한 것은 Swift에서는 enum도 firt-class type이기 때문인가? 
		* Swift에서는 enum도 하나의 타입으로 만들 수 있다. : enum도 클래스처럼 초기자, 멤버 함수 등을 가질 수 있다.
	
####  VLC

* 동영상 플레이어

#### Swift 3 

* 개발 목표
	* 인간 친화적인 언어 지향
	* Swift Package Manager : 구체적으로는 안 나옴

### Baby Tale

* UI 등이 전체적으로 변경됨 

#### CVCalendar

* A custom visual calendar for iOS 8+ written in Swift (2.0).





