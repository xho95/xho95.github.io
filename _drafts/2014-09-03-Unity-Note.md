### Unity 강의 노트 정리

Scale 주의 사항

* Transform 컴포넌트에서 Scale 값은 모두 동일하게 해 주는게 좋다. (비균등 스케일 : 내부적으로 한번더 호출 - 균등하게 하도록 하자.) 새 버전의 Unity에서는 이 문제가 해결된다고 하니 나중에 알아보자.

Normal Map

Transform 호출

Animation - 동작을 모아둔 것으로 하나의 동작은 clip이라고 한다.

Loop - 2가지 : 

* Rendering Loop, 
* Physics Loop

Collider 계산 속도 차이

* Sphere (r 계산) > Capsule (r, h) > Box > … > Mesh

Unity에서는 Mesh와 Mesh의 충돌 감지가 안되도록 되어 있다. - 부하가 크기 때문이다. 

사용하지 않는 Update 문은 지우자!

Bullet

* Prefab으로 연결한다. 
* 동적으로 만들어내는 물체는 Prefab으로 연결한다. 총알의 경우 벽에 부딪히면 사라지기 때문에 다시 만들어 줘야 하기 때문이다.

Unity에 예약되어 있는 폴더 - Editor, Plugins, Resources, Gizmos, Standard Assets

Unity 충돌 발생 조건 - 

* Collider 끼리 충돌해야 함. 
* 움직이는 물체는 Rigid Body 속성이 있어야 함 

Unity 하늘 - 2가지 :

* Skybox (6개의 면 이용),
* Sky Dome (한장의 텍스쳐를 돔 형태의 mesh에 맵핑)

모바일 게임 성능 - DrawCall 을 줄여야 한다. (폴리곤 수 만큼 중요)

Sound - 발소리, 총소리, 효과음은 wav가 mp3보다 좋다. 왜냐면 mp3는 압축음원이라 최초의 경우 압축해제시 시간이 걸린다. (ogg 파일 포맷이 가장 안전? 버그 문제)

AudioListen 1 : AudioSource n - 1 대 다 의 관계

OnCollisionEnter
OnTriggerEnter

Layer - 그룹의 개념

온라인 도움말 - 원하는 키워드에 커서를 두고 Command + ‘

GUI 레거시 - OnGUI 이벤트 : 매 free 마다 새로 GUI를 그림 - 최소 5 이상의 DrawCall 

ezGUI ($200) > NGUI ($95) - 1 DrawCall로 UI를 만들 수 있다

asset bundle - 

Unity url 지원 4가지 - http, https, ftp, file
