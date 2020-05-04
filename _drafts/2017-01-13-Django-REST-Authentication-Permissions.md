여기서는 Django에서 사용할 수 있는 대표적인 Rest 프레임웍(Framework)인 [Django REST framework](http://www.django-rest-framework.org)에 대해서 정리합니다. [^django-rest-framework]

전체 내용은 Django REST framework 홈페이지의 내용을 실습하고 정리한 것입니다. 

* [Rest Framework 맛보기](../_draft/2016-12-19-Django-REST-Framework.md)
* [Quick Start]()
* Tutorial 1: Serialization
* Tutorial 2: Requests and Responses
* Tutorial 3: Class-based Views
* Tutorial 4: Authentication & Permissions

### 시작하기

지금까지는 누구든 코드 조각(snippets)을 편집하고 지울 수 있게 API에 아무런 제약이 없었습니다. 이제 좀 더 나은 동작을 만들어서 다음과 같은 것들을 할 수 있게 합니다:

* 코드 조각은 항상 만든 사람과 관련짓습니다.
* 인증된 사용자만 조각을 만들 수 있습니다.
* 조각을 만든 사람만 그것을 수정하고 지울 수 있습니다.
* 인증받지 않은 요청은 읽기 접근만 가능하게 합니다.

### 모델에 정보 추가하기

Snippet 모델 클래스에서 몇 가지를 고쳐봅니다. 먼저, 몇 가지 필드(fields)를 추가합니다. 이 중 하나는 누가 코드 조각을 만들었는지를 나타낼 때 사용됩니다. 다른 필드는 색이 강조된 HTML 코드를 저장하는데 사용됩니다.

두 필드를 **models.py** 의 `Snippet` 모델에 추가합니다.

```
owner = models.ForeignKey('auth.User', related_name='snippets', on_delete=models.CASCADE)
highlighted = models.TextField()
```

model이 저장될 때, `highlighted` 필드도 만들어야 하므로, `pygments` 코드 색 강조(highlighting) 라이브러리를 사용하도록 해야합니다.

다음처럼 추가적인 `import`가 필요합니다:

```
from pygments.lexers import get_lexer_by_name
from pygments.formatters.html import HtmlFormatter
from pygments import highlight
```

그리고 모델 클래스에 `.save()` 메소드를 추가합니다:

```
def save(self, *args, **kwargs):
    """
    Use the `pygments` library to create a highlighted HTML
    representation of the code snippet.
    """
    lexer = get_lexer_by_name(self.language)
    linenos = self.linenos and 'table' or False
    options = self.title and {'title': self.title} or {}
    formatter = HtmlFormatter(style=self.style, linenos=linenos,
                              full=True, **options)
    self.highlighted = highlight(self.code, lexer, formatter)
    super(Snippet, self).save(*args, **kwargs)
```

다 했으면 데이터베이스 테이블을 업데이트 해야합니다. 보통은 데이터베이스 마이그레이션(migration)을 생성하지만, 여기서는 데이터베이스를 삭제하고 다시 생성해봅니다.

```
$ rm -f tmp.db db.sqlite3
$ rm -r snippets/migrations

$python manage.py makemigrations snippets
$python manage.py migrate
```

> 위와 같이 하면 데이터베이스를 삭제하고 다시 생성할 수 있습니다. PostgreSQL 같은 다른 데이터베이스도 같은 방식으로 사용할 수 있는지 알아볼 필요가 있습니다. 
> 
> 그렇다면 데이터베이스를 옮기거나 변경하는 과정에서 발생하는 에러를 해결하기 쉬울 것 같습니다. 

API를 테스트하기 위해 다른 사용자를 만들고 싶을 겁니다. 가장 빠른 방법은 `createsuperuser` 명령을 사용하는 것입니다.

```
$ python manage.py createsuperuser
```

### 사용자(User) 모델을 위한 말단(주소?) 추가하기 

이제 작업할 사용자들이 준비됐으므로 그 유저들을 나타낼 API를 추가합니다. 새로운 serializer를 만드는 것은 쉽습니다. **serializers.py**에 다음을 추가합니다:

```
from django.contrib.auth.models import User

class UserSerializer(serializers.ModelSerializer):
    snippets = serializers.PrimaryKeyRelatedField(many=True, queryset=Snippet.objects.all())

    class Meta:
        model = User
        fields = ('id', 'username', 'snippets')
```

`'snippets'`은 User 모델에 대해 역 관계이기 때문에, `ModelSerializer` 클래스를 사용할 때 저절로 포함되지 않습니다. 그래서 명시적으로 필드에 추가해줘야 합니다.

이제 **views.py** 파일에 몇 개의 뷰를 추가합니다. 사용자에 대해서는 읽기 전용 뷰만 있으면 되므로 `ListAPIView`와 `RetrieveAPIView` 제네릭 클래스 기반 뷰를 사용할 것입니다.

```
from django.contrib.auth.models import User

class UserList(generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class UserDetail(generics.RetrieveAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
```

`UserSerializer` 클래스를 import 하는 것도 잊지 맙시다.

```
from snippets.serializers import UserSerializer
```

마지막으로 이 뷰들을 API에 추가하기 위해서 URL 설정을 고칩니다. 아래 내용을 **urls.py**의 패턴 부분에 추가합니다.

```
url(r'^users/$', views.UserList.as_view()),
url(r'^users/(?P<pk>[0-9]+)/$', views.UserDetail.as_view()),
```

### Snippets을 Users와 연결하기

지금은, 코드 조각을 만들면, 조각 인스턴스로 그 조각을 만든 사용자와 연결할 방법이 없습니다. 사용자는 직렬화 표현으로 보내지는 부분이 아니라 들어오는 요청의 한 속성입니다.

이것을 해결하려면 `.perform_create()` 메소드를 오버라이드해서, 저장되는 인스턴스를 수정해서 다룰 수 있게 하고, 들어오는 요청이나 요청 URL에 묻어오는 정보를 다룰 수 있게 해야합니다.

`SnippetList` 뷰 클래스에 다음의 메소드를 추가합니다:

```
def perform_create(self, serializer):
    serializer.save(owner=self.request.user)
```

serializer의 `create()` 메소드는 추가적인 `'owner'` 필드와 요청의 유효한 데이터를 함께 전달 받습니다.

> 번역을 새로 해야 할 것 같습니다.

### Serializer 업데이트 하기

나중에 다시 정리합니다. 

### 참고 자료

[Tutorial 4: Authentication & Permissions](http://www.django-rest-framework.org/tutorial/4-authentication-and-permissions/)