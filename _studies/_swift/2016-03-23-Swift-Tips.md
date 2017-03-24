재활용 뷰가 있는 리스트에서는 AutuLayout 을 절대 쓰지 않는 것이 좋다. 

라이브러리

Alarmofire
SnapKit
ObjectMapper - JSON 라이브러리 파싱이 편하다.


Segwei 도 안쓰는 것이 좋다. 대안은 세가지다.

* Notification - 동시 접근이 필요할 때
* Closure 콜백 - 하나만 접근할 때
* Delegate 패턴 - 요즘 많이 안쓴다, Closure 로 대체되는 상황인 듯 하다

CollectionView 가 TablewView 보다 커스텀하기 좋다.

extension을 할 경우 파일 네이밍에 +를 붙여준다. 

TableViewDataSource 관련 코드는 따로 extension 으로 분리한다.

Notification 은 RxBus

