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

Now that we've got some users to work with, we'd better add representations of those users to our API. Creating a new serializer is easy. In serializers.py add:

### 참고 자료

[Tutorial 4: Authentication & Permissions](http://www.django-rest-framework.org/tutorial/4-authentication-and-permissions/)