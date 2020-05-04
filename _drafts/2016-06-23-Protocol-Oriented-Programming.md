이 내용은 WWDC 2016의 Protocol and Value Oriented Programming in UIKit Apps[^WWDC2016_419] 영상과 WWDC 2015의 두 영상을 보고 정리한 글입니다.[^WWDC2015_408]  [^WWDC2015_414]

기본은 클래스와 상속을 사용하는 대신에, struct와 protocol을 위주로 사용하여 컴파일 시간에 타입을 결정하는 현대 프로그래밍 방식을 구현하는 것이 중심입니다.

### MVC 패턴에 적용

### 고찰하기

Local Reasoning은 클래스들 사이의 의존성을 줄이는 것과 관련된 용어인 것 같습니다.

state 패턴을 사용하지 않고 enum을 사용하는 것은 클래스의 사용을 줄이기 위해서인지 아직 잘 모르겠습니다.

### 참고 자료

[^WWDC2016_419]: [Protocol and Value Oriented Programming in UIKit Apps](https://developer.apple.com/videos/play/wwdc2016/419/)

[^WWDC2015_408]: [Protocol-Oriented Programming in Swift](https://developer.apple.com/videos/play/wwdc2015/408/)

[^WWDC2015_414]: [Building Better Apps with Value Types in Swift](https://developer.apple.com/videos/play/wwdc2015/414/)

[^LucidDreams]: [LucidDreams: Swift in Practice Sample Code](https://developer.apple.com/library/prerelease/content/LucidDreams/Introduction/Intro.html)