여기서는 Django에서 사용할 수 있는 대표적인 Rest 프레임웍(Framework)인 [Django REST framework](http://www.django-rest-framework.org)에 대해서 정리합니다. [^django-rest-framework]

전체 내용은 Django REST framework 홈페이지의 내용을 실습하고 정리한 것입니다. 

* [Rest Framework 맛보기](../_draft/2016-12-19-Django-REST-Framework.md)
* [Quick Start]()
* Tutorial 1: Serialization

### 소개

간단한 pastebin 코드 하이라이팅 웹 API를 만든다고 합니다. 

### 환경 설정하기

가상 환경의 경우 `tutorial`을 그대로 사용해도 될 것 같습니다. 

아래와 같이 패키지를 더 설치합니다. 

```
$ conda install pygments
```

### 시작하기

적당한 폴더를 만들고 프로젝트와 앱을 새로 만듭니다. 

```
$ django-admin.py startproject tutorial
$ cd tutorial

$ python manage.py startapp snippets
```

settings.py 파일에 프레임웍과 앱을 등록합니다. 

```
INSTALLED_APPS = (
    ...
    'rest_framework',
    'snippets.apps.SnippetsConfig',
)
```

### 모델 만들기

일부 코드는 아래와 같습니다. 

```
class Snippet(models.Model):
    created = models.DateTimeField(auto_now_add=True)
    title = models.CharField(max_length=100, blank=True, default='')
    code = models.TextField()
    linenos = models.BooleanField(default=False)
    language = models.CharField(choices=LANGUAGE_CHOICES, default='python', max_length=100)
    style = models.CharField(choices=STYLE_CHOICES, default='friendly', max_length=100)

    class Meta:
        ordering = ('created',)
```

모델을 만든 다음에는 migration을 해 줍니다. 

이 때 아래처럼 하나의 모델에 대해서도 해줄 수 있는 모양입니다. 

```
$ python manage.py makemigrations snippets
$ python manage.py migrate
```

### Serializer 클래스 만들기

웹 API에서 처음에 할 일은 시리얼라이징(serializing) 및 디시리얼라이징(deserializing) 하는 방법을 제공해서 snippet 인스턴스를 json 형태로 표현하도록 하는 것입니다.

이렇게 하기 위해서 serializers를 선언하는데, 이것은 장고(Django)의 폼(forms)과 매우 비슷합니다.

`snippets` 디렉토리에 **serializers.py** 파일을 만들고 다음 내용을 추가합니다.

```
길어서 코드는 생략합니다. 
```

The first part of the serializer class defines the fields that get serialized/deserialized. The create() and update() methods define how fully fledged instances are created or modified when calling serializer.save()

A serializer class is very similar to a Django Form class, and includes similar validation flags on the various fields, such as required, max_length and default.

We can actually also save ourselves some time by using the ModelSerializer class, as we'll see later, but for now we'll keep our serializer definition explicit.

### Serializers 사용하기

파이썬 쉘을 사용해서 위의 Serializer를 테스트 할 수 있습니다.

```
$ python manage.py shell
```

```
>>> from snippets.models import Snippet
>>> from snippets.serializers import SnippetSerializer
>>> from rest_framework.renderers import JSONRenderer
>>> from rest_framework.parsers import JSONParser
>>> 
>>> snippet = Snippet(code='foo = "bar"\n')
>>> snippet.save()
>>> 
>>> snippet = Snippet(code='print "hello, world"\n')
>>> snippet.save()
```

이제 serializer를 실행해 봅니다. 그러면 아래와 같은 결과를 얻을 수 있습니다. 

```
>>> serializer = SnippetSerializer(snippet)
>>> serializer.data

{'code': 'print "hello, world"\n', 'title': '', 'language': 'python', 'linenos': False, 'style': 'friendly', 'id': 2}
```

위에서는 파이썬 내장(native) 자료형으로 변환이 되었는데 이를 json 형태로 렌더링해봅니다.

```
>>> content = JSONRenderer().render(serializer.data)
>>> content
>>> 
b'{"id":2,"title":"","code":"print \\"hello, world\\"\\n","linenos":false,"language":"python","style":"friendly"}'
```

디시리얼라이즈(Deserialization)도 비슷합니다. 

먼저 json 양식을 파이썬 내장 데이터형으로 변환하고 이것을 객체 인스턴스로 변환합니다. 

```
>>> from django.utils.six import BytesIO

>>> stream = BytesIO(content)
>>> data = JSONParser().parse(stream)
```

```
>>> serializer = SnippetSerializer(data=data)
>>> serializer.is_valid()
True
>>> serializer.validated_data
OrderedDict([('title', ''), ('code', 'print "hello, world"'), ('linenos', False), ('language', 'python'), ('style', 'friendly')])
>>> serializer.save()
<Snippet: Snippet object>
```

We can also serialize querysets instead of model instances. To do so we simply add a many=True flag to the serializer arguments.

```
>>> serializer = SnippetSerializer(Snippet.objects.all(), many=True)
>>> serializer.data

# [OrderedDict([('id', 1), ('title', u''), ('code', u'foo = "bar"\n'), ('linenos', False), ('language', 'python'), ('style', 'friendly')]), OrderedDict([('id', 2), ('title', u''), ('code', u'print "hello, world"\n'), ('linenos', False), ('language', 'python'), ('style', 'friendly')]), OrderedDict([('id', 3), ('title', u''), ('code', u'print "hello, world"'), ('linenos', False), ('language', 'python'), ('style', 'friendly')])]
```

### ModelSerializers 사용하기

앞서 만들었던 SnippetSerializer 클래스는 Snippet 모델이 갖고 있는 정보를 상당히 많이 반복하고 있습니다. 코드를 더 간결하게 만들 수 있다면 좋을 것입니다.

장고(Django)에서 Form 클래스와 더불어 ModelForm 클래스를 제공하듯이, REST 프레임웍도 Serializer 클래스 뿐만 아니라, ModelSerializer 클래스를 제공합니다.

리팩토링을 통해서 serializer를 ModelSerializer 클래스로 바꿔봅시다. **snippets/serializers.py** 에서 SnippetSerializer 클래스를 다음과 같이 바꿉니다.

```
class SnippetSerializer(serializers.ModelSerializer):
    class Meta:
        model = Snippet
        fields = ('id', 'title', 'code', 'linenos', 'language', 'style')
```

코드량이 엄청 줄어드는 것을 볼 수 있습니다. 

ModelSerializer 클래스는 특별한 다른 기능은 없고, 그냥 serializer 클래스를 쉽게 만드는 역할만 한다고 합니다.

* 자동으로 필드(fields) 집합을 결정한다고 합니다(?) - 아직 의미를 모르겠습니다.
* `create()`와 `update()` 메소드의 기본적인 구현을 합니다. - 복잡한 기능이 필요하면 직접 다시 재정의해야할 것 같습니다.

### Serializer를 사용해서 표준 Django views 만들기 

새 Serializer 클래스로 어떻게 API 뷰(views)들을 만들 수 있는지 살펴봅시다.

우선 HttpResponse 클래스를 상속받아서 json으로 반환하는 데이터들을 렌더링 할 수 있도록 합니다.

**snippets/views.py** 파일을 아래처럼 작성합니다.

```
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser
from snippets.models import Snippet
from snippets.serializers import SnippetSerializer

class JSONResponse(HttpResponse):
    """
    An HttpResponse that renders its content into JSON.
    """
    def __init__(self, data, **kwargs):
        content = JSONRenderer().render(data)
        kwargs['content_type'] = 'application/json'
        super(JSONResponse, self).__init__(content, **kwargs)
```

The root of our API is going to be a view that supports listing all the existing snippets, or creating a new snippet.

```
@csrf_exempt
def snippet_list(request):
    """
    List all code snippets, or create a new snippet.
    """
    if request.method == 'GET':
        snippets = Snippet.objects.all()
        serializer = SnippetSerializer(snippets, many=True)
        return JSONResponse(serializer.data)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = SnippetSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JSONResponse(serializer.data, status=201)
        return JSONResponse(serializer.errors, status=400)
```

Note that because we want to be able to POST to this view from clients that won't have a CSRF token we need to mark the view as csrf_exempt. This isn't something that you'd normally want to do, and REST framework views actually use more sensible behavior than this, but it'll do for our purposes right now.

We'll also need a view which corresponds to an individual snippet, and can be used to retrieve, update or delete the snippet.

```
@csrf_exempt
def snippet_detail(request, pk):
    """
    Retrieve, update or delete a code snippet.
    """

    try:
        snippet = Snippet.objects.get(pk=pk)
    except Snippet.DoesNotExist:
        return HttpResponse(status=404)

    if request.method = 'GET':
        serializer = SnippetSerializer(snippet)
        return JSONResponse(serializer.data)

    elif request.method == 'PUT':
        data = JSONParser().parse(request)
        serializer = SnippetSerializer(snippet, data=data)

        if serializer.is_valid():
            serializer.save()
            return JSONResponse(serializer.data)

        return JSONResponse(serializer.errors, status=400)

    elif request.method = 'DELETE':
        snippet.delete()
        return HttpResponse(status=204)

```

### URLs 설정하기

#### snippets/urls.py 파일
 
```
from django.conf.urls import url
from snippets import views

urlpatterns = [
    url(r'^snippets/$', views.snippet_list),
    url(r'^snippets/(?P<pk>[0-9]+)/$', views.snippet_detail),
]
```

#### tutorial/urls.py 파일

```
from django.conf.urls import url, include

urlpatterns = [
    url(r'^', include('snippets.urls')),
]
```

It's worth noting that there are a couple of edge cases we're not dealing with properly at the moment. If we send malformed json, or if a request is made with a method that the view doesn't handle, then we'll end up with a 500 "server error" response. Still, this'll do for now.

### 테스트하기

HTTPie를 설치합니다. HTTP 글에 설치 방법을 설명했습니다. 아래처럼 Homebrew를 이용하여 설치할 수 있습니다. 

```
$ brew install httpie
```

```
$ http http://127.0.0.1:8000/snippets/
```

위와같이 명령을 입력하면 아래처럼 결과가 나옵니다. 

```
HTTP/1.0 200 OK
...
[
    {
        "code": "foo = \"bar\"\n",
        "id": 1,
        "language": "python",
        "linenos": false,
        "style": "friendly",
        "title": ""
    },
    ...,
]

```


### 참고 자료

[Tutorial 1: Serialization](http://www.django-rest-framework.org/tutorial/1-serialization/)