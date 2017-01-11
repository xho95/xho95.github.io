여기서는 Django에서 사용할 수 있는 대표적인 Rest 프레임웍(Framework)인 [Django REST framework](http://www.django-rest-framework.org)에 대해서 정리합니다. [^django-rest-framework]

### 개요 

> 일단 홈페이지 첫 문단에 있는 내용은 좀 더 공부해서 정리하도록 합니다.

파이님의 [Django REST Framework 사용기](https://perhapsspy.wordpress.com/2013/07/11/django-rest-framework-사용기/) 라는 글에 보면 다음과 같이 요약한 부분 있습니다. 

간략히 요약하자면 API로 만들고자 하는 Django 모델을 만들고, 그 모델을 모델시리얼라이저를 이용해 시리얼라이저를 만듭니다. 그리고 그 시리얼라이저와 Django 모델을 쿼리셋으로 하는 뷰셋을 만든 뒤 URL에 매핑하면 끝입니다. [^perhapsspy-django-rest-framework]

### 설치하기

공식 문서에 설명되어 있는대로 아래와 같이 설치해 줍니다. 

```
$ pip install djangorestframework
$ pip install markdown
$ pip install django-filter
```

`markdown`과 `django-filter`는 같이 설치해 줍니다. 

> 위의 패키지 중에서 `markdown`의 경우 conda로도 설치가 가능합니다. 
> 
> conda에 대해서는 다른 글을 참고하시기 바랍니다. 

**settings.py** 파일의 `INSTALLED_APPS` 부분에 `rest_framework`을 등록해 줍니다. 

```
INSTALLED_APPS = [
	...
    'rest_framework',
]
```

browsable API를 사용하기 위해서는 REST 프레임웍의 로그인(login) 과 로그아웃(logout) 뷰(views)도 등록해야한다고 합니다. 

루트에 있는 **urls.py** 파일에 아래와 같이 추가해줍니다.

```
urlpatterns = [
    ...
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]
```

> URL 경로는 아무거나 해도 되지만, 'rest_framework.urls' 과 'rest_framework' 네임스페이스(namespace)는 반드시 동일하게 지정해줘야 한다고 합니다. 
> 
> 장고(Django) 1.9 버전 이상에서는 네임스페이스를 지정하지 않으면 REST 프레임웍이 알아서 위와 같이 지정해 준다고 합니다.

### 사용하기

#### 홈페이지 예제

홈페이지에는 간단한 모델-기반(model-backed) API를 실습하면서 REST 프레임웍에 대한 감을 잡고 있습니다. 

예제에서는 프로젝트의 사용자 정보에 접근하는 읽고-쓰기 가능한(?) API를 만듭니다.

REST 프레임웍 API의 글로벌 설정은 **REST_FRAMEWORK**이라는 단일 설정 딕셔너리(dictionary)에 지정합니다.

**settings.py** 파일에 다음과 같이 추가합니다.

```
REST_FRAMEWORK = {
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.DjangoModelPermissionsOrAnonReadOnly'
    ]
}
```

> 위의 설정은 일반 유저의 경우 장고(Django)의 표준 `django.contrib.auth` 권한 설정을 사용하지만, 인증되지 않는 사용자에 대해서는 읽기 접근만을 허용하도록 합니다.

 

### 사용법 

간단한 사용법은 공식 문서의 [Quickstart](http://www.django-rest-framework.org/tutorial/quickstart/) 부분을 실습하면서 익히면 될 것 같습니다. [^django-rest-framework-quickstart]

[How to use Django rest framework](https://www.buzzvil.com/2016/12/26/how-to-use-django-rest-framework-buzzvil/) 글도 상당히 좋은 내용입니다. [^how-to-use-django-rest-framework-buzzvil]

[PyCharm과 함께 DJango와 RestFramework를 활용한 웹 사이트 구축하기](https://devissue.wordpress.com/2015/02/01/pycharm과-함께-django와-restframework를-활용한-웹-사이트-구축하기/) 라는 강좌 글도 좋은 것 같습니다. [^raccoonyy] [^devissue]

### 참고 자료

[^django-rest-framework]: [Django REST framework](http://www.django-rest-framework.org) : Django REST framework is a powerful and flexible toolkit for building Web APIs

[^django-rest-framework-quickstart]: [Quickstart](http://www.django-rest-framework.org/tutorial/quickstart/) : 처음 Rest Framework을 시작하는 방법을 설명한 공식 문서입니다. 내용은 관리자가 일반 사용자에게 권한을 부여하는 API를 만드는 방법을 소개하고 있습니다.

[^perhapsspy-django-rest-framework]: [Django REST Framework 사용기](https://perhapsspy.wordpress.com/2013/07/11/django-rest-framework-사용기/) : 파이님의 Rest Framework 사용기입니다. 조금 오래된 글이지만 한 번 읽어볼 필요가 있습니다. 

[^raccoonyy]: [괜찮은 Django Rest Framework 강좌를 찾아서 소개합니다](http://raccoonyy.github.io/django-rest-framework-tutorial-by-devissue/) : devissue님이 정리하신 Rest Framework 강좌를 소개하고 있습니다. 

[^devissue]: [PyCharm과 함께 DJango와 RestFramework를 활용한 웹 사이트 구축하기](https://devissue.wordpress.com/2015/02/01/pycharm과-함께-django와-restframework를-활용한-웹-사이트-구축하기/) : raccoony님이 소개한 원본 글인데 찾기가 힘들어서 raccoony님의 글을 통해 접근하는 것이 좋을 것 같습니다. 

[^how-to-use-django-rest-framework-buzzvil]: [How to use Django rest framework](https://www.buzzvil.com/2016/12/26/how-to-use-django-rest-framework-buzzvil/) : buzzvil님의 글입니다. 아주 좋은 내용입니다.