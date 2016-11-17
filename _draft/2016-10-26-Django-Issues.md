### get\_success\_url() 오버로딩

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

### object\_list empty check

따로 empty 체크나 수를 불러올 필요없이 아래와 같이 바로 if 구문으로 처리할 수 있습니다.

```
{% if object_list %}
    Number of object_list: {{ object_list |length }}
{% else %}
    No object_list.
{% endif %}
```

[How Can I Check the Size of a Collection with Django Templates?](http://stackoverflow.com/questions/902034/how-can-i-check-the-size-of-a-collection-with-django-templates) : 참고 자료입니다.

### Django shell에서 user 만들기

```
$ python manage.py shell
>>> from django.contrib.auth.models import User
>>> user=User.objects.create_user('foo', password='bar')
>>> user.is_superuser=True
>>> user.is_staff=True
>>> user.save()
```

[How to create user from django shell](http://stackoverflow.com/questions/18503770/how-to-create-user-from-django-shell)

### If you get a UnicodeEncodeError 

[How to use Django with Apache and mod_python](https://django.readthedocs.io/en/1.4.X/howto/deployment/modpython.html) : 파일 업로드시 ascii 코덱 문제가 발생할 경우 참고 자료의 **If you get a UnicodeEncodeError** 부분을 보면 된다고 합니다. 

### migration problem

[(postgresql) Error: relation does not exist](http://devhoma.tistory.com/82)

디비 테이블에서 django_migrations 에서 app에서 관련된 필요없는것들 다 지우고하니깐 되더라구요

[What is the correct way to deal with DB migration while using South, Django and Git?](http://stackoverflow.com/questions/10083130/what-is-the-correct-way-to-deal-with-db-migration-while-using-south-django-and)

You should add the migrations folder to your version control system and use the same files for production and development. You may run into some problems on your production system if you introduced your migrations not from the beginning and you have already existing tables.

Therefore you have to fake the first migration, which normally does the same thing as syncdb did when you created your database for the first time. So when trying to apply migrations for your app for the first time on the production machine, execute manage.py migrate app_name 0001 --fake. This lets South know, that the first migration has already been applied (which already happend with syncdb) and when you run migrate again, it would continue with the following migrations.

answered by **Bernhard Vallant**

### Initial Value

[Django set default form values](http://stackoverflow.com/questions/604266/django-set-default-form-values)

[Creating forms from models](https://docs.djangoproject.com/en/1.10/topics/forms/modelforms/#providing-initial-values) : Providing initial values 부분이 여러번 나오는데 이 부분 설명을 읽어볼 필요가 있습니다.

[set initial value in CreateView from ForeignKey (non-self.request.user)](http://stackoverflow.com/questions/18277444/set-initial-value-in-createview-from-foreignkey-non-self-request-user)

### 세션 사용법 

[Django 에서 session 사용법 (공식 Document 번역)](http://egloos.zum.com/blackyyy/v/5314617)

### Data Crawler 

[Beautiful Soup Documentation](https://www.crummy.com/software/BeautifulSoup/bs4/doc/#find)

### bulk_create : multiple records

[^webforefront]: [CRUD operations with multiple records and Django models](https://www.webforefront.com/django/multiplemodelrecords.html) : make CRUD operations for multiple database records 

[Django recipes](https://www.webforefront.com/django/index.html) : 위의 내용을 담고 있는 온라인 오픈(?) 서적인 듯 합니다.

#### Session

[Django 에서 session 사용법 (공식 Document 번역)](http://egloos.zum.com/blackyyy/v/5314617)

[Django의 session 처리](http://somnusnote.tistory.com/entry/Django의-session-처리)

1. session에 값 넣기
   - view 함수에서

	```
	request.session['myname'] = 'michael'
	```

2. session에서 값 얻기
   - view의 함수에서

	```
	myname = request.session['myname']
	```
   
   - Template에서

	```
	{{ request.session.myname }}
	```
	
[Django Login Session](http://ngee.tistory.com/749)

#### bulk_create()

bulk_create(objs, batch_size=None)

[QuerySet API reference](https://docs.djangoproject.com/el/1.10/ref/models/querysets/) : 중간 이후에 bulk_create()에 대한 설명이 나옵니다.

**bulk_create()** 

The advantage of the bulk_create() method is that it creates all entries in a single query, so it's very efficient if you have a list of a dozen or a hundred entries you wish to create.[^webforefront]

it has certain limitations:

the only alternative you have is to loop over each record and use the save() method to create each entry individually

the speed issues related to listing 2 can be dramatically improved if you manually deal with database transactions.

### Popup Window

[Howto: javascript popup form returning value for select like Django admin for foreign keys](http://blog.yourlabs.org/post/20001556462/howto-javascript-popup-form-returning-value-for)

[jQuery/JavaScript Pop Up window with Django (select from child, display on parent)](http://stackoverflow.com/questions/12348681/jquery-javascript-pop-up-window-with-django-select-from-child-display-on-paren)

['Add another' now easy outside the admin too, version 1.0.21](https://github.com/yourlabs/django-autocomplete-light/commit/599687fc71fe5ecf054afc47935626b81e6a8bf2) : popup window를 띄우는 방법에 대해서 참고할만한 소스가 있는 곳입니다.

[Django render template in a pop-up](http://stackoverflow.com/questions/9063831/django-render-template-in-a-pop-up) : popup window에 장고 템플릿을 띄우는 방법에 대한 답변입니다.

[Open New Window for Social Login and then Close and Return to Parent On Success with Django](http://stackoverflow.com/questions/23224434/open-new-window-for-social-login-and-then-close-and-return-to-parent-on-success) : 창을 띄우는 방법으로는 상당히 간단한 방법을 보여줍니다. 

[javascript - pass selected value from popup window to parent window input box](http://stackoverflow.com/questions/9994120/javascript-pass-selected-value-from-popup-window-to-parent-window-input-box) : 질문이 너무 깁니다. 

[DYNAMIC WEB PAGES WITH DJANGO, AJAX AND JQUERY](http://racingtadpole.com/blog/django-ajax-and-jquery/) : 나중에 한 번 읽어 볼만한 글 같습니다만 그럴 수 있을지 모르겠습니다.

### Excel

[django-excel - Let you focus on data, instead of file formats](http://django-excel.readthedocs.io/en/latest/)

### Deploy

[AWS 부분](https://github.com/xho95/xho95.github.io/blob/master/_draft/2016-09-28-AWS.md)을 보면 될 것 같습니다. 나중에 총 정리가 필요합니다.

### Custom Filter

[Writing custom template filters](https://docs.djangoproject.com/en/dev/howto/custom-template-tags/#writing-custom-template-filters) : Custom Filter를 만드는 방법을 설명하는 Django 공식 문서입니다.

### Mixin Class & Class-base View

[Classy Class-Based Views](http://ccbv.co.uk) : 장고 파란책에서 추천하는 사이트입니다.



