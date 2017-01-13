여기서는 Django에서 사용할 수 있는 대표적인 Rest 프레임웍(Framework)인 [Django REST framework](http://www.django-rest-framework.org)에 대해서 정리합니다. [^django-rest-framework]

전체 내용은 Django REST framework 홈페이지의 내용을 실습하고 정리한 것입니다. 

* [Rest Framework 맛보기](../_draft/2016-12-19-Django-REST-Framework.md)
* [Quick Start]()
* Tutorial 1: Serialization
* Tutorial 2: Requests and Responses

### 시작하기

여기서부터 REST 프레임웍의 핵심 부분을 시작한다고 합니다. 

### Request 객체

REST 프레임웍은 Request 객체를 가지고 있는데 이것은 표준 HttpRequest 객체를 확장한 것으로 더 유연한 request 파싱(parsing)을 할 수 있습니다. Request 객체의 핵심은 `request.data` 속성으로 `request.POST`와 비슷하지만 웹 API와 작업하기에 더 유용합니다.

```
request.POST  
request.data  
``` 

* `request.POST` : 폼 데이터(form data)만 다룰 수 있고, `POST` 메소드와만 동작합니다.
* `request.data` : 임의의 데이터를 다룰 수 있으며, `POST`, `PUT` 그리고 `PATCH` 메소드와 같이 동작할 수 있습니다.

### Response 객체

REST 프레임웍에는 Response 객체도 있는데 TemplateResponse 타입으로 렌더링되지 않은 내용(unrendered content)을 받아서 정확한 내용 타입(correct content type)을 결정해서 클라이언트에게 반환합니다. 

> 위 과정에서 content negotiation을 사용한다고 하는데, 그게 뭔지 아직 모르겠습니다.

```
return Response(data)  
```

* 클라이언트에게서 요청받은 내용 타입(content type)으로 렌더링합니다.

### 상태 코드

뷰(views)에서 숫자로된 HTTP 상태 코드를 사용하면 정확한 뜻을 파악하기 힘들고 잘못된 에러 코드를 받았을 경우 이를 놓치기 쉽습니다. REST 프레임웍은 `status` 모듀을 통해서 `HTTP_400_BAD_REQUEST` 같은 더 분명한 식별자를 제공합니다. 숫자로된 식별자보다 이들을 사용하는 것이 더 좋습니다.

### API 뷰(views)를 감싸기

REST 프레임웍은 2개의 래퍼(wrappers)를 제공해서 API 뷰(views)를 작성할 수 있게 합니다.

1. `@api_view` 데코레이터(decorator)는 함수 기반 뷰(function based views)와 작동합니다.
2. `APIView` 클래스는 클래스 기반 뷰(class-based views)와 작동합니다.

이 래퍼들은 몇가지 기능들을 제공하는데, 예를 들어 뷰(view)에서 Request 인스턴스(instances)를 받았는지 확인하게 해주고, 내용(context)을 Response 객체에 추가해서 내용 절충(content negotiation)을 하게 해줍니다.

여기에 래퍼들은 적당할 때 `405 Method Not Allowed` 응답(responses)을 반환하는 기능도 가지고 있고, 잘못된 입력으로 `request.data`에 접글할 때 발생하는 `ParseError` 예외(exception)도 처리할 수 있습니다.

### 직접 다뤄보기

**views.py**에서 `JSONResponse` 클래스는 필요없으므로 지우고 뷰(views)를 다음과 같이 수정합니다.

```
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from snippets.models import Snippet
from snippets.serializers import SnippetSerializer

# Create your views here.
@api_view(['GET', 'POST'])
def snippet_list(request):
    """
    List all snippets, or create a new snippet.
    """
    if request.method == 'GET':
        snippets = Snippet.objects.all()
        serializer = SnippetSerializer(snippets, many=True)

        return Response(serializer.data)

    elif request.method == 'POST':
        serializer = SnippetSerializer(data=request.data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)

        return JSONResponse(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
```

이전 예제보다 인스턴스 뷰(instance view)가 개선되었습니다. 약간 더 간결해지고 코드는 폼(Forms) API를 사용하는 것과 매우 비슷합니다. 이름달린 상태 코드(named status codes)를 사용해서 응답(response)의 의미가 더 분명입니다.

이제 **views.py** 에서 개별 snippet 코드를 수정합니다.

```
@api_view(['GET', 'PUT', 'DELETE'])
def snippet_detail(request, pk):
    """
    Retrieve, update or delete a snippet instance.
    """
    try:
        snippet = Snippet.objects.get(pk=pk)
    except Snippet.DoesNotExist:
        return Response(status=status_HTTP_404_NOT_FOUND)

    if request.method == 'GET':
        serializer = SnippetSerializer(snippet)
        return Response(serializer.data)

    elif request.method == 'PUT':
        serializer = SnippetSerializer(snippet, data=request.data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)

        return Response(serializer.errors, status=HTTP_400_BAD_REQUEST)

    elif request.method == 'DELETE':
        snippet.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
```

위 코드는 매우 친숙하게 느껴지는데 - 표준 장고 뷰(regular Django views)를 사용하는 것과 별반 다를 것이 없습니다.

이제 더 이상 요청(requests) 이나 응답(responses)에 주어진 내용의 타입(given content type)을 겉으로 드러내지 않는 것을 확인하기 바랍니다. `request.data`는 `json` 요청을 처리할 수도 있지만, 다른 포맷도 처리할 수 있습니다. 마찬가지로 응답 객체로 data를 리턴할 수 있으며, REST 프레임웍이 알아서 정확한 타입으로 응답을 렌더링하게 놔둘 수 있습니다. 

> 말을 고치면 좋을 것 같습니다.

### URLs에 포맷 접미사 추가하기

응답(responses) 하나의 내용 타입(content type)과 엮이지 않았다는 것의 한가지 장점은 API 말단에 포맷 접미사(format suffixes)를 추가할 수 있다는 점입니다. 포맷 접미사를 사용하면 URLs이 주어진 포맷(given format)을 나타내고 있음을 명시할 수 있고, 이는 API가 `http://example.com/api/items/4.json` 같은 URLs을 처리할 수 있음을 의미합니다.

두개의 뷰(views)에 `format` 키워드 인자를 추가해 봅시다. 

```
def snippet_list(request, format=None):

...

def snippet_detail(request, pk, format=None):
```

이제 **urls.py** 파일을 조금 고쳐서, `format_suffix_patterns`을 URLs에 추가합니다.

```
from django.conf.urls import url
from rest_framework.urlpatterns import format_suffix_patterns
from snippets import views

urlpatterns = [
    url(r'^snippets/$', views.snippet_list),
    url(r'^snippets/(?P<pk>[0-9]+)$', views.snippet_detail),
]

urlpatterns = format_suffix_patterns(urlpatterns)
```

사실 이 추가적인 url 패턴을 포함할 필요는 없습니다만, 이렇게 함으로써 간단하고 분명하게 특별한 포맷을 언급하고 있음을 명시할 수 있습니다.

> 말을 고칩시다.

### 어떤지 봅시다.

서버를 실행하고 API를 터미널(command line)에서 테스트해 봅니다. 잘못된 요청을 하면 좀 더 나은 에러 처리를 볼 수 있습니다.

다음과 같이 하면 이전과 같이 snippet 리스트를 볼 수 있습니다.

```
$ http http://127.0.0.1:8000/snippets/
```

`Accept` 헤더를 사용하거나 해서 돌려받는 응답의 포맷을 제어할 수 있습니다.

```
$ http http://127.0.0.1:8000/snippets/ Accept:application/json

$ http http://127.0.0.1:8000/snippets/ Accept:text/html
```

첫번째는 JSON 요청이고, 두번째는 HTML 요청입니다. 

또한 포맷 접미사를 추가할 수 있습니다.

```
$ http http://127.0.0.1:8000/snippets.json
$ http http://127.0.0.1:8000/snippets.api
```

첫번째는 JSON 접미사이고, 두번째는 Browsable API 접미사입니다. 

비슷하게 우리가 보내는 요청 포맷도 제어할 수 있는데, 이 때는 `Content-Type` 헤더를 사용합니다.

```
http --form POST http://127.0.0.1:8000/snippets/ code="print 123"

{
  "id": 3,
  "title": "",
  "code": "print 123",
  "linenos": false,
  "language": "python",
  "style": "friendly"
}
```

위는 데이터를 사용해서 POST를 하는 결과입니다. 

> `--debug`에 대한 내용도 조금 있는데 좀 더 확인하고 정리하도록 합니다. 
 
### Browsability

뭔가 API가 웹 브라우징 가능함을 얘기하는 것 같습니다. 나중에 좀 더 이해하고 번역해서 정리할 예정입니다. 

Because the API chooses the content type of the response based on the client request, it will, by default, return an HTML-formatted representation of the resource when that resource is requested by a web browser. This allows for the API to return a fully web-browsable HTML representation.

Having a web-browsable API is a huge usability win, and makes developing and using your API much easier. It also dramatically lowers the barrier-to-entry for other developers wanting to inspect and work with your API.

See the browsable api topic for more information about the browsable API feature and how to customize it.


### 참고 자료

[Tutorial 2: Requests and Responses](http://www.django-rest-framework.org/tutorial/2-requests-and-responses/)

[What is a "browsable" API?](https://www.quora.com/What-is-a-browsable-API) : browserable API에 대해서 설명하고 있습니다.

[The Browsable API](http://www.django-rest-framework.org/topics/browsable-api/) : 나중에 좀 더 이해해서 정리할 필요가 있습니다.