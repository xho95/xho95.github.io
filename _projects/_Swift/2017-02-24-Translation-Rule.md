### 옮기는 규칙 

다음의 순서대로 말을 옮기기로 했습니다.

#### 1. 이미 옮겨진 말이 있는 경우
	
첫번째는 이미  옮겨져서 사용하고 있는 말이 있는 경우입니다. 이 경우 최대한 새로 만들지 않고 기존에 널리 사용되는 단어를 그대로 사용합니다.

기존의 말이 자연스럽지 않는 경우에도 널리 퍼진 경우라면 최대한 기존 말을 사용합니다. 엄밀하면 좋겠지만 그건 전문 번역가들이 할 일이고 저는 전문 번역가가 아니니 그냥 뜻을 자연스럽게 연상할 수 있으면 됩니다.

예를 들어서 enumeration 의 경우 이미 많은 곳에서 열거체라고 사용하고 있습니다. 따라서 자연스럽게 뜻을 연상할 수 있기 때문에 굳이 바꾸지 않고 그대로 씁니다.

다음과 같은 단어들이 여기에 해당합니다.

* declaration : 선언
* enumeration : 열거체
* function : 함수
* hierarchy : 계통
* inheritance : 상속
* return : 반환하다
* structure : 구조체
* subclass : 하위 클래스
* superclass : 상위 클래스

#### 2. 발음을 옮겨 적는 경우

두번째는 의미를 옮기면 더 이상해지거나 옮겨 적을 마땅한 말이 없어서 발음을 그대로 받아들여서 새로운 말처럼 사용하는 경우입니다. 이 경우에도 굳이 새로 뭔가를 만들지 않고 그냥 발음 그대로 옮겨 적은 것을 사용하도록 합니다. 보통 키워드에 해당하는 경우가 많은 것 같습니다.

무리해서 옮기기보다 발음 그대로 적는 것이 그 단어를 가장 잘 연상하는 경우 그대로 받아들이기로 합니다. 

예를 들어서 protocol 의 경우 프로그래밍 이외의 분야에서는 규약이라는 말로 사용할 수 있지만 프로그래밍에서 사용하기에는 무리가 있어서 말을 그대로 받아들여서 프로토콜이라 합니다. 보통 해당 단어에 대응하는 한글이 없어서 단어 자체를 그대로 받아들이는 경우에 적용합니다.

다음과 같은 단어들이 여기에 해당합니다.

* protocol : 프로토콜
* code : 코드
* generic : 제네릭
* class : 클래스
* optional : 옵셔널
* error : 에러
* type : 타입

#### 3. 원 글을 그대로 사용하는 경우

세번째는 두번째의 특수한 경우로 의미를 살려서 말을 옮겨도 이상하고 발음을 옮겨서 한글로 적어도 이상한 경우입니다. 이 때는 그냥 원 글을 그대로 적도록 합니다. 해당 단어가 일상 한글 용어에 자주 쓰이면서 Swift 의 키워드로도 사용되는 경우에 해당합니다.

예를 들어서 switch, case 같은 경우 한글로 스위치, 케이스 라고 적어도 애매하고 바꾸다, 사례 같은 말로  옮겨도 애매합니다. 각각 switch 구문, 열거체의 case 가 연상되지가 않습니다. 이럴 때는 그냥 원 글을 그대로 씁니다. 아니면 스위치-구문, 열거체-케이스 등으로 명시해도 되겠지만 일단은 원 글을 쓰도록 합니다.
 
여기에는 일단 다음의 두가지만 해당합니다. 더 있을지는 두고봐야할 것 같습니다.

* switch
* case

#### 4. 새로운 단어를 만드는 경우

마지막으로 이도 저도 아닌 경우입니다. 일단 Swift 에 새로 도입이 되어서 기존에 해당하는 경우가 없으며 키워드도 아니라서 문장속에서 의미를 살려야하는 경우가 많습니다. 이 때는 좀 의역을 하더라도 문장이 가장 자연스럽게 이어지는 방식으로 옮기도록 합니다. 

예를 들어 initializer 초기자라고 옮기도록 합니다. 왜냐면 contructor 를 생성자라고 옮기는 선례가 있으므로 가장 자연스럽게 해당 의미를 연상할 수 있기 때문입니다. 예전에 클래스에서 init() 등의 함수를 쓸 때 초기화 함수라는 표현을 썼는데 초기자는 생성자와 초기화 함수의 역할을 모두 하고 있으므로 원 글의 의미도 훼손되지 않습니다.

다음과 같은 단어들이 여기에 해당합니다.

* adopt : 따른다
* computed property : 계산 속성
* deinitializer : 정리자
* initializer : 초기자
* named type : 보통의 타입 - 이름이 알려진 타입의 의미에서 보편 타입을 의미
* raw value : 원시 값
* stored property : 저장 속성

### 번역 단어 표

* abbreviated : 축약 형태의
* adopt : 따른다 > 받아들인다 - 좀더 생각합니다.
* angle brackets : 꺽쇠 괄호
* approach : 접근 방법
* argument : 인자
* array : 배열, 배열 타입
* associated value : 연관 값
* behavior : 작동 방식
* block : 블럭
* brace : 중괄호
* callback : 콜백
* case : `case`, 경우
* class : 클래스
* cleanup : 정리
* closure : 클로져
* code : 코드
* collection : 모듬 타입
* compile time : 컴파일 시간
* compiler : 컴파일러
* computed property : 계산 속성
* conditional : 조건 구문
* context : 내부 - 좀더 생각합니다.
* declaration : 선언
* deinitializer : 정리자
* delegate : 델리케이트
* determine : 결정하다
* dictionary : 사전 타입
* dot syntax : 점 문법
* enumeration : 열거체
* error : 에러
* explicitly : 직접 - (드러내놓고) 직접
* extension : `extension`, 확장
* first-class : 일급
* form : 양식 - 형식이 더 맞는지 생각합니다.
* function : 함수
* generic : 제네릭
* handle : 처리하다
* initializer : 초기자
* integer : 정수, 정수 타입
* implicitly : 저절로 - (은연 중에) 저절로
* label : 꼬리표 
* loop : 반복 구문
* match : 일치하는지 찾아보다 - 좀더 생각합니다.
* method : 메소드
* mutating : `mutating`, 변경
* named : 보통의 - (이름이 알려질 정도로) 보편화 된
* nest : 중첩하다
* optional : 옵셔널
* organize : 정리하다 - 좀더 생각해야 합니다.
* override : 덮어 쓰다, `override`
* pair : 쌍
* property : 속성, 일반 언어로는 성질 - 둘을 구분하기 위해
* protocol : 프로토콜
* raw value : 원시 값
* requirements : 요구 사항
* return : 반환하다
* root : 루트
* run time : 실행 시간
* setup : 초기 설정
* specify : 지정하다
* stored property : 저장 속성
* structure : 구조체
* subclass : 하위 클래스
* subsripting : 첨자 인덱싱
* superclass : 상위 클래스
* switch : `switch`
* throw : 던지다
* type : 타입
* variable : 가변
