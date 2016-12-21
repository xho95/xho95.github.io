장고(Django)의 Authentication System에 대해서 정리합니다. 

### 기본 정보 

* Authentication (인증) : 합당한 유저인지를 판별합니다.
* Authorization (위임) : 합당한 유저에게 권한을 부여합니다.

### 사용하기 

#### 설치하기 

Django에서는 인증 관련 부분이 Django contrib module로 제공되고 있으며, 이 모듈은 **django.contrib.auth**에 있습니다. (말을 고쳐야 할 것 같습니다.) [^docs-auth]

1. **django.contrib.auth** : 인증 프레임웍의 핵심 부분을 담고 있으며, 기본 인증 모델도 지원합니다.
2. **django.contrib.contenttypes** : Django content type 시스템은 개발자가 만든 모델에 권한을 허락(permissions)하여 연결짓도록 합니다.

위 두 내용은 django 프로젝트를 시작하면 **settings.py** 파일에 기본적으로 설정이 되어 있습니다. 

#### Middleware 설치하기

Django에서 인증을 사용하려면 관련 middleware도 필요합니다.

1. **SessionMiddleware** : 요청(requests) 사이의 세션(session)을 관리합니다.
2. **AuthenticationMiddleware** : 세션을 사용해서 유저(users)를 요청(requests)과 연결짓습니다.

위의 설정들을 완료한 후, `manage.py migrate` 명령을 실행하면, 인증 관련 DB 테이블들과 설치한 앱에서 정의한 모델들에 대해 허락된 것들이 생성됩니다. (말을 좀 더 부드럽게 다듬어야겠습니다.)

### Django Authentication System 사용하기

장고의 인증은 인증(authentication)과 위임(authorization)의 두 가지를 동시에 지원하며 인증 시스템(authentication system)이라 부릅니다. 어쨌든 이 두 가지의 속성들은 다소 결합되어 있습니다. [^docs-auth-default]

#### User 객체



### 참고 자료

[^docs-auth]: [User authentication in Django](https://docs.djangoproject.com/en/1.10/topics/auth/)

[^docs-auth-default]: [Using the Django authentication system](https://docs.djangoproject.com/en/1.10/topics/auth/default/)





