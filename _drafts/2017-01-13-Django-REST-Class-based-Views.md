여기서는 Django에서 사용할 수 있는 대표적인 Rest 프레임웍(Framework)인 [Django REST framework](http://www.django-rest-framework.org)에 대해서 정리합니다. [^django-rest-framework]

전체 내용은 Django REST framework 홈페이지의 내용을 실습하고 정리한 것입니다. 

* [Rest Framework 맛보기](../_draft/2016-12-19-Django-REST-Framework.md)
* [Quick Start]()
* Tutorial 1: Serialization
* Tutorial 2: Requests and Responses
* Tutorial 3: Class-based Views

### 시작하기

API 뷰(views)를 함수 기반 뷰(function based views) 대신에 클래스 기반 뷰(class-based views)로 작성할 수 있습니다. 이렇게 하면 공통 기능들을 재사용할 수 있어서 매우 강력하며 DRY(Don't repeat yourself) 구현에 도움이 됩니다.

### 기존 API를 클래스 기반 뷰(class-based views)로 재작성하기

먼저 루트 뷰(root view) 부터 클래스 기반 뷰로 재작성합니다. **views.py** 파일을 다음과 같이 수정합니다.

```
from snippets.models import Snippet
from snippets.serializers import SnippetSerializer
from django.http import Http404
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

class SnippetList(APIView):
    """
    List all snippets, or create a new snippet.
    """
    def get(self, request, format=None):
        snippets = Snippet.objects.all()
        serializer = SnippetSerializer(snippets, many=True)
        return Response(serializer.data)

    def post(self, request, format=None):
        serializer = SnippetSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
```

지금까지는 그럭저럭 괜찮아 보입니다. 이전과 거의 같아보이지만 다른 HTTP 메소드끼리 더 잘 구분됩니다. 

이제 인스턴스 뷰를 업데이트합니다.

```
class SnippetDetail(APIView):
    """
    Retrieve, update or delete a snippet instance.
    """
    def get_object(self, pk):
        try:
            return Snippet.objects.get(pk=pk)
        except Snippet.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        snippet = self.get_object(pk)
        serializer = SnippetSerializer(snippet)
        return Response(serializer.data)

    def put(self, request, pk, format=None):
        snippet = self.get_object(pk)
        serializer = SnippetSerializer(snippet, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk, format=None):
        snippet = self.get_object(pk)
        snippet.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
```

이것도 역시 좋아 보입니다.  여전히 함수 기반 뷰와 상당히 비슷합니다.

이제 **urls.py** 파일을 조금 고쳐서 클래스 기반 뷰를 사용할 수 있게 합니다.

```
urlpatterns = [
    url(r'^snippets/$', views.SnippetList.as_view()),
    url(r'^snippets/(?P<pk>[0-9]+)/$', views.SnippetDetail.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)
```

이제 됐습니다. 서버를 실행해보면 모든 것이 이전과 같이 작동할 겁니다.

### mixins 사용하기

클래스 기반 뷰를 사용하는 큰 장점중의 하나는 재사용 가능한 동작(behaviour)을 쉽게 만들 수 있다는 것입니다.

지금까지 사용한 `create/retrieve/update/delete` 기능들은 앞으로 만들 어떤 모델-기반(model-backed) API에서도 비슷하게 사용할 것입니다. 이러한 공통 동작들은 REST 프레임웍의 mixin 클래스로 구현되어 있습니다.

뷰(views)들을 mixin 클래스로 어떻게 구현하는지 살펴봅시다. **views.py** 모듈을 새로 만들면 다음과 같습니다.

```
from snippets.models import Snippet
from snippets.serializers import SnippetSerializer
from rest_framework import mixins
from rest_framework import generics

class SnippetList(mixins.ListModelMixin,
                  mixins.CreateModelMixin,
                  generics.GenericAPIView):
    queryset = Snippet.objects.all()
    serializer_class = SnippetSerializer

    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)
```

뭐가 일어났는지 살펴봅시다. 뷰를 `GenericAPIView`를 사용해서 구현했습니다. 그리고 `ListModelMixin`과 `CreateModelMixin`을 추가 했습니다.

기반(base) 클래스는 핵심 기능을 제공하고, mixin 클래스들은 `.list()`와 `.create()` 함수들을 제공합니다. 그 다음 get 과 post 메소드들을 적당한 함수들과 명시적으로 결합합니다. 지금까지는 꽤 간단합니다.

```
class SnippetDetail(mixins.RetrieveModelMixin,
                    mixins.UpdateModelMixin,
                    mixins.DestroyModelMixin,
                    generics.GenericAPIView):
    queryset = Snippet.objects.all()
    serializer_class = SnippetSerializer

    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)

    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)

    def delete(self, request, *args, **kwargs):
        return self.destroy(request, *args, **kwargs)
```

이전과 유사합니다. `GenericAPIView` 클래스를 사용해서 핵심 기능을 제공하고, `mixins`을 추가해서 `.retrieve()`, `.update()` 및 `.destroy()` 함수를 제공합니다.

### generic 클래스 기반 뷰 사용하기

mixin 클래스를 사용해서 재작성한 뷰는 이전보다 코드량이 줄었습니다만, 여기서 한 걸음 더 나아갈 수 있습니다. REST 프레임웍은 이미 mixed-in 제네릭 뷰(generic views)를 제공하는데, **views.py** 모듈을 더 줄일 수 있습니다.

```
from snippets.models import Snippet
from snippets.serializers import SnippetSerializer
from rest_framework import generics


class SnippetList(generics.ListCreateAPIView):
    queryset = Snippet.objects.all()
    serializer_class = SnippetSerializer


class SnippetDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Snippet.objects.all()
    serializer_class = SnippetSerializer
```

확실히 간결해 졌습니다. 코드도 장고스러워졌습니다.

### 참고 자료

[Tutorial 3: Class-based Views](http://www.django-rest-framework.org/tutorial/3-class-based-views/)