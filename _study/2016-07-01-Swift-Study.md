### 스터디 브리핑

* 일자 : 2016년 7월 1일
* 참여자 : 김희제, 김민호

### 회원 관리 앱 제작

#### gitignore

* 실제 gitignore 파일을 생성하여 Git 버전 관리에서 특정 파일 제외하기
* 이미 버전 관리중인 파일을 `git rm --cached` 명령으로 제거하기
* `git rm --cached` 명령을 사용할 경우 반드시 commit을 해야함
* 참고자료 : 지난 6월 17일 회의록의 자료 활용

#### xcrun

* 문제 발생 : xcrun 명령어로 해결 가능

#### NSManagedObject Subclasses

* Xcode를 통해서 자동으로 NSManagedObject 클래스 만들기
* GitHub에서 필요 소스들을 pull해서 실행 테스트
* 2장까지 완성하여 GitHub/modulab 계정으로 push 완료함

#### Error Handing 수정본

* 기존 책의 내용은 Error Handling을 다루지 않아서 호환이 안됨
* 코드를 Swift 2.2 버전에 맞게 수정하여 해결
* 나중에 Swift 3.0 버전으로 업데이트 할 예정

### 자유 토론

#### WWDC 2016

* Core Data Stack 변경 사항 체크
* [What's New in Core Data](https://developer.apple.com/videos/play/wwdc2016/242/) : 비디오를 보면서 토론

#### Core Data 변경 사항 정리

* Faults : 아직 확실히 정리된 것은 아님
	* DB 최적화와 관련된 기술로 보인다. 
	* 메모리, CPU 사용량을 줄일 수 있다. 
	* 접근이 안되는 것은 지우도록 할 수 있다.
	
* Query Generations
	* 데이터를 불러오는 것과 관련이 있다(?) 
	* 앱이 보여주고 편집하는 자료와 DB에 있는 자료가 버전별로 관리된다.
	* 함수형 프로그래밍 기법을 DB에 적용한 듯한 느낌이다.
	* 쿼리 구문을 직접 넣을 수도 있는 것 같다 : `NSQueryGenerationToken`
	
* Concurrency
	* autorelease pool 
	* SQLite 밑단에서 Locking을 지원하는 것 같다 : Moving the Lock Down
	* 따라서, 이제 동시 접근을 허용한다 : 다중 읽기, 단일 쓰기
	* Connection Pool : 아직 잘 모르겠다.
	
* Core Data Stack
	* `NSPersistenceStore`
	* `NSPersisentContainer` : 기존 Core Data code가 여기로 통합된다.
	
* Generics
	* New protocol : `NSFetchRequestResult`
	* 사용이 간편해짐 : 일일이 형변환할 필요가 없어짐

* Automatic Subclass Generation  
