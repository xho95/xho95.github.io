### 가상 환경 만들기

장고를 사용할 경우에는 가상 환경을 따로 만들어주는 것이 여러모로 좋습니다. 

파이썬 버전은 일단 3.5로 정해줍니다. 많은 패키지들이 아직 3.6을 지원하지 않습니다. 

> 특히 현재는 PostgreSQL 과 연동하는 패키지가 3.6을 지원하지 않는 것 같습니다.

```
$ conda create --name MY_ENVIRONMENT python=3.5
```

위와 같이 하면 가상 환경이 만들어지고, 아울러 파이썬까지 설치가 됩니다. 

### 가상 환경에 장고 설치

우선 가상 환경을 활성화 합니다. 

```
$ source activate MY_ENVIRONMENT
```

conda를 이용하여 장고를 설치합니다. 

```
(MY_ENVIRONMENT) ...$ conda install django
```

### 장고 프로젝트 시작하기 

프로젝트를 시작할 폴더로 이동한 다음 다음과 같이 프로젝트를 시작합니다. 

```
(MY_ENVIRONMENT) ...$ cd ...
(MY_ENVIRONMENT) ...$ django-admin.py startproject PROJECT
```

아래와 같이 관련 폴더와 파일들이 생기는 것을 볼 수 있습니다. 

```
(MY_ENVIRONMENT) ...$ tree PROJECT
PROJECT
├── PROJECT
│   ├── __init__.py
│   ├── settings.py
│   ├── urls.py
│   └── wsgi.py
└── manage.py
```

> tree 명령의 설치 및 사용법은 다른 글을 참고하시기 바랍니다.

### 패키지 설치 

### 배포하기

장고걸스 튜토리얼의 [배포하기!](https://tutorial.djangogirls.org/ko/deploy/) 라는 글을 참고하면 좋을 것 같습니다. [^djangogirls-deploy]

### 참고 자료

[^djangogirls-deploy]: [배포하기!](https://tutorial.djangogirls.org/ko/deploy/) : 장고걸스 튜토리얼에 있는 내용입니다. 전체 과정이 상당히 좋은 내용이라 한 번 정도 실습하면 좋을 것 같습니다. 
