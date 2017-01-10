여기서는 Django에서 사용할 수 있는 대표적인 Rest Framework인 [Django REST framework](http://www.django-rest-framework.org)에 대해서 정리합니다. [^django-rest-framework]

파이님의 [Django REST Framework 사용기](https://perhapsspy.wordpress.com/2013/07/11/django-rest-framework-사용기/) 라는 글에 보면 다음과 같이 요약한 부분 있습니다. 

간략히 요약하자면 API로 만들고자 하는 Django 모델을 만들고, 그 모델을 모델시리얼라이저를 이용해 시리얼라이저를 만듭니다. 그리고 그 시리얼라이저와 Django 모델을 쿼리셋으로 하는 뷰셋을 만든 뒤 URL에 매핑하면 끝입니다. [^perhapsspy-django-rest-framework]

#### 사용법 

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