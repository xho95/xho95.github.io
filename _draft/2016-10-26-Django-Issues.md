### get_success_url() 오버로딩

```
class CommunicationUpdateDV(UpdateView):
    model = Communication
    template_name = "communication/update.html"
    fields = ['id', 'title', 'content']
#    success_url = reverse_lazy('communication:notification_list')

    def get_success_url(self):
        if self.object.category == 'notification':
            url = 'communication:notification_list'
        else:
            url = ''
        return reverse(url)
```

`success_url`을 조건에 따라 변경하고 싶을 때는 `get_success_url` 함수를 오버로딩하면 된다. 

[Query String Parameter Passing between urls.py, views.py and <template_file>.html in Django](http://stackoverflow.com/questions/30290050/query-string-parameter-passing-between-urls-py-views-py-and-template-file-htm) : urls.py로 넘겨오는 파라미터를 사용하는 법

### 파일 다운로드

[Request and response objects](https://docs.djangoproject.com/en/1.10/ref/request-response/) : File Attachment에 대한 설명이 나와있다고 합니다.

[how to download a filefield file in django view](http://stackoverflow.com/questions/9462999/how-to-download-a-filefield-file-in-django-view) : 위의 링크에 대한 코드를 샘플로 보여줍니다. 아직 그래도 잘 모르겠습니다만, 곧 이해될 것 같습니다. 

[Downloading the files(which are uploaded) from media folder in django 1.4.3](http://stackoverflow.com/questions/15246661/downloading-the-fileswhich-are-uploaded-from-media-folder-in-django-1-4-3) : url 설계 및 함수 구현 방법에 대한 설명입니다.

[Django MEDIA_URL and MEDIA_ROOT](http://stackoverflow.com/questions/5517950/django-media-url-and-media-root) : MEDIA_URL과 MEDIA_ROOT를 url에 추가하는 방법을 설명하고 있습니다.

[uscript: 8장. file upload/download 구현](http://shsong97.blogspot.kr/2015/03/uscript-8-file-uploaddownload.html)

#### 파일 다운로드

일단 Django 1.8 이후 버전에서는 settings.py 파일에서 TEMPLATES 부분에 아래와 같이 `django.template.context_processors.media`를 추가해 줘야합니다.

```
TEMPLATES = [
    {
        'OPTIONS': {
            'context_processors': [
            	...
                'django.template.context_processors.media',
                ...
            ],
        },
    },
]
```

이어서 urls.py 파일에서 아래와 같이 static 부분을 추가해줘서 `settings.MEDIA_URL` 키워드를 url 패턴에 추가해 줍니다.

```
urlpatterns = [
	...
    url(r'^admin/', admin.site.urls),
    ...
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
```

그러면 template 파일에서 `{{ MEDIA_URL }}` 템플릿 변수를 써서 특정 파일의 위치를 찾아갈 수 있습니다. 

이렇게 특정 파일의 위치를 찾은 다음에는 url 패턴을 써서 파일을 다운로드 하는 response를 받아올 수 있습니다.

```
    response = HttpResponse(object_name.file)
    response['Content-Disposition'] = 'attachment; filename=%s' % file_name
    return response

```

위의 코드는 장고의 공식 문서를 참고해서 조금 수정한 것입니다. content_type의 경우 어떤 파일 유형이 올지 몰라서 비워뒀는데, 특정 파일로만 한정하려면 지정해주면 될 것 같습니다.
