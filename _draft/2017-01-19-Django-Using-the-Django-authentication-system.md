## 장고(Django)의 인증(authentication) 시스템 사용하기

이 문서는 장고의 인증 시스템을 사용하는 방법에 대해서 기본 설정을 가지고 설명합니다. 이 설정은 가장 일반적인 프로젝트의 요구 사항을 지원하기 위해 진화했습니다, 합당한 광범위한 일들을 처리하면서, 그리고 암호와 승인(permissions)에 대해 주의깊게 구현되었습니다. 프로젝트가 기본 설정과는 다른 인증을 요구할 때를 위해 장고는 인증에 대해 광범위한 확장과 사용자화를 지원합니다.

장고 인증은 인증과 권한 부여(authorization) 기능을 함께 제공하며 보통의 경우 인증 시스템인 것으로 언급됩니다. 이들은 어쨌거나 서로 연결이 되어 있는 특성입니다.

### **User** 객체

**User** 객체는 인증 시스템의 핵심입니다. 이는 사이트와 상호 작용하는 사람들을 나타내는 것으로 제한된 접근을 가능하게 하고 사용자 정보를 등록하며 작성자와 내용을 연결짓는 기능 등을 담당합니다. 단 한 종류의 user 클래스만 장고 인증 프레임웍에 존재합니다. 가령, **superusers** 나 관리 **staff** 사용자들은 그냥 특별한 속성 집합을 가지는 user 객체이며, 사실상 user 객체와 다를 바가 없습니다.

기본 사용자(user)는 다음과 같은 주요 특성들을 가집니다:

* **username**
* **password**
* **email**
* **first_name**
* **last_name**

전체 특성들은 [full API documentation](https://docs.djangoproject.com/en/1.10/ref/contrib/auth/#django.contrib.auth.models.User) 에서 볼 수 있습니다. 이어지는 내용은 좀 더 실무적인(task oriented) 내용을 다룹니다.

#### 사용자(users) 만들기

사용자를 만드는 가장 직접적인 방법은 포함된 **create_user()** 헬퍼 함수를 사용하는 것입니다:

```python
>>> from django.contrib.auth.models import User
>>> user = User.objects.create_user('john', 'lennon@thebeatles.com', 'johnpassword')

# 이 시점에서 user 는 이미 데이터베이스에 저장된 User 객체입니다.
# 다른 필드들을 바꾸길 원하면 속성을 계속해서 수정할 수 있습니다.

>>> user.last_name = 'Lennon'
>>> user.save()
```

장고 관리자 화면(admin)을 설치했으면, 사용자를 대화형 방식으로 생성할 수 있습니다.

#### 운영자(superusers) 만들기

운영자는 **createsuperuser** 명령을 사용해서 만듭니다:

```bash
$ python manage.py createsuperuser --username=joe --email=joe@example.com
```

바로 비밀번호를 입력하라고 나타납니다. 입력하고 나면 곧바로 운영자가 생깁니다. **--username** 이나 **--email** 옵션 없이 실행하면, 이 값들을 입력하라고 바로 나타납니다.

#### 비밀번호 변경하기

장고는 사용자 모델의 원래(순수 텍스트) 비밀번호를 저장하지 않으며, 단지 해쉬 (자세한 사항은 [documentation of how passwords are managed](https://docs.djangoproject.com/en/1.10/topics/auth/passwords/) 문서를 보십시오) 만 저장합니다. 따라서 사용자가 직접 비밀번호 속성을 변경할 수 없습니다. 사용자를 만들 때 헬퍼 함수를 사용하는 이유가 이 때문입니다.

비밀번호를 변경하는 데는 여러 옵션이 있습니다:

**manage.py changepassword *username*** 는 명령줄에서 사용자 비밀번호를 변경하는 방법을 제공합니다. 이것은 주어진 사용자의 비밀번호를 바꾸기 위해 즉시 두 번의 입력을 요구합니다. 그 두 개가 맞으면, 곧바로 새 비밀번호로 바뀝니다. 만약 사용자를 제공하지 않으면, 현재 시스템의 사용자와 이름이 같은 사용자의 비밀번호를 바꾸게 됩니다.

비밀번호는 **set_password()** 를 사용하면 프로그램 내에서도 수정할 수 있습니다:

```python
>>> from django.contrib.auth.models import User
>>> u = User.objects.get(username='john')
>>> u.set_password('new password')
>>> u.save()
```

장고 관리자 화면(admin)을 설치했으면, 사용자 비밀번호를 인증 시스템의 관리자 페이지에서 변경할 수도 있습니다.

또한 장고는 뷰([views](https://docs.djangoproject.com/en/1.10/topics/auth/default/#built-in-auth-views)) 와 폼([forms](https://docs.djangoproject.com/en/1.10/topics/auth/default/#built-in-auth-forms))을 통해서도 사용자가 자신의 비밀번호를 수정할 수 있도록 허용합니다.

사용자의 비밀번호를 변경하면 모든 세션에서 빠져 나옵니다(log out). 자세한 사항은 [Session invalidation on password change](https://docs.djangoproject.com/en/1.10/topics/auth/default/#session-invalidation-on-password-change) 를 보십시오.

#### 사용자 인증하기

```python
authenticate(**credentials)
```

자격(credentials)이 유효한지(verify) 검사하려면 **authenticate()** 를 사용합니다. 이 함수는 자격을 키워드 인자로 받아 들이는데, 기본은 **username** 과 **password** 를 사용합니다. 그리고  각각의 인증 백엔드(authentication backend)와 맞춰 봐서, 자격이 백엔드에서 유효하면 **User** 객체를 반환합니다. 자격이 어떤 백엔드에서도 유효하지 않거나 백엔드가 **PermissionDenied** 예외를 발생하면, **None** 을 반환합니다. 예를 들면 다음과 같습니다:

```python
from django.contrib.auth import authenticate
user = authenticate(username='john', password='secret')
if user is not None:
    # 하나의 백엔드에서 자격을 인증했습니다.
else:
    # 어떤 백엔드도 자격을 인증하지 않았습니다.
```

> 이 방법은 자격을 인증하는 낮은 단계의 방법입니다; 예를 들어, **RemoteUserMiddleware** 에서 이 방법을 사용합니다. 스스로 인증 시스템을 작성하지 않는다면, 아마 이것을 사용하지 않을 것입니다. 로그인한 사용자에 대해 제한된 접근을 하는 방법을 찾고 있다면 이 방법 보다는  **login_required()** 데코레이터를 살펴보도록 하십시오.

### 승인(Permissions) 및 권한 부여(Authorization)

장고는 간단한 승인 시스템을 가지고(comes with) 있습니다. 이는 특별한 사용자와 사용자 그룹을 승인하는 기능을 제공합니다.

장고 관리 화면(admin) 사이트에서도 사용되지만, 직접 코드에서 사용하는 것도 문제 없습니다.

장고의 관리 화면 사이트에서는 승인을 다음과 같이 사용합니다:

* `add` 폼(form)에 가서 객체를 추가하려는 접근이 있을 때, 이를 해당 타입에 대해 `add` 승인을 가진 사용자만 가능하도록 제한합니다.
* 변경 목록을 보고 `change` 폼에 가서 객체를 변경하려는 접근이 있을 때, 이를 해당 타입에 대해 `change` 승인을 가진 사용자만 가능하도록 제한합니다.
* 객체를 지우는 접근이 있을 때, 이를 해당 타입에 대해 `delete` 승인을 가진 사용자만 가능하도록 제한합니다.

승인은 객체 타입별로 적용할 수 있을 뿐만 아니라 개별 객체 인스턴스에 대해서도 적용가능합니다. **ModelAdmin** 클래스에서 제공하는 **has\_add_permission()**, **has\_change_permission()** 그리고 **has\_delete_permission()** 메소드를 사용하면, 같은 타입의 서로 다른 객체 인스턴스를 위해 승인을 사용자화할 수 있습니다.

**User** 객체는 두 개의 다-대-다(many-to-many) 관계 필드를 가지고 있습니다: **groups** 과 **user_permissions** 이 그들입니다. **User** 객체가 관계를 맺은 객체에 접근하는 방법은 다른 [Django model](https://docs.djangoproject.com/en/1.10/topics/db/models/) 과 동일합니다:

```python
myuser.groups.set([group_list])
myuser.groups.add(group, group, ...)
myuser.groups.remove(group, group, ...)
myuser.groups.clear()
myuser.user_permissions.set([permission_list])
myuser.user_permissions.add(permission, permission, ...)
myuser.user_permissions.remove(permission, permission, ...)
myuser.user_permissions.clear()
```

#### 기본 승인(permissions)

**INSTALLED_APPS** 설정에 **django.contrib.auth** 이 있으면, 그것은 세 개의 기본 승인 - 추가, 변경, 삭제 - 을 각각의 장고 모델에 생성하는 것을 보장합니다. 이 장고 모델들은 설치한 앱들 중의 하나에 정의되어 있습니다(?)

세 개의 승인은 **manage.py migrate** 을 실행할 때 생성합니다; **django.contrib.auth** 를 **INSTALLED_APPS** 에 추가하고 처음으로  **migrate** 명령을 실행하면, 기본 승인은 미리-설치된 모든 모델들뿐만 아니라, 그 시점에 설치되는 새로운 모든 모델들을 위해서도 생성됩니다. 이후로는, **manage.py migrate** 명령을 실행할 때마다 새 모델들을 위한 기본 승인을 생성합니다. (승인을 생성하는 함수는 **post_migrate** 신호와 연결되어 있습니다).

**app_label** 의 **foo** 라는 어플리케이션과 이름이 **Bar** 인 모델이 있다고 가정합시다, 기본 승인을 실험하려면 아래와 같이 하면 됩니다:

* 추가: **user.has\_perm('foo.add_bar')**
* 변경: **user.has\_perm('foo.change_bar')**
* 삭제: **user.has\_perm('foo.delete_bar')**

승인 모델은 직접 접근할 일이 거의 없습니다.

#### 그룹(Groups)

**django.contrib.auth.models.Group** 모델은 사용자를 분류하는(categorizing) 제네릭한(generic) 방법이라서 해당 사용자들에게 승인을 적용하거나 다른 이름표를 붙이거나 할 수 있습니다. 한 명의 사용자는 다수의 그룹에 속할 수 있습니다.

그룹에 있는 사용자는 그룹에 부여된 승인을 자동으로 갖습니다. 예를 들어, 만약 **Site editors** 그룹이 **can\_edit\_home_page** 에 대해 승인을 가지고 있으면, 이 그룹에 속한 어떤 사용자라도 해당 승인을 가지게 됩니다.

승인을 넘어서 그룹은 사용자들을 분류하는 편리한 방법을 제공하는데, 특정한 이름표를 부여하거나 확장된 기능들을 제공하는 것들이 있습니다. 예를 들면, **'Special users'** 라는 그룹을 만들고, 코드를 작성해서, 이 그룹이 멤버들만 접근 가능한 영역에 접근하게 하거나, 멤버에게만 보내는 메일을 보내주거나 할 수 있습니다.

#### 프로그램으로 승인 만들기

[custom permissions](https://docs.djangoproject.com/en/1.10/topics/auth/customizing/#custom-permissions) (사용자화한 승인)은 모델의 **Meta** 클래스안에서 정의하는 것이지만, 직접 승인을 생성할 수도 있습니다. 예를 들어, **can_publish** 승인을 **myapp** 에 있는 **BlogPost** 모델에 만들 수 있습니다:

```python
from myapp.models import BlogPost
from django.contrib.auth.models import Permission
from django.contrib.contenttypes.models import ContentType

content_type = ContentType.objects.get_for_model(BlogPost)
permission = Permission.objects.create(
    codename='can_publish',
    name='Can Publish Posts',
    content_type=content_type,
)
```

이렇게 생성한 승인을 **User** 에는 **user_permissions** 속성을 사용해서, **Group** 에는 **permissions** 속성을 사용해서 할당할 수 있습니다.

#### 승인 캐싱하기(caching)

**ModelBackend** 는 사용자 객체에 대한 승인을 저장하는데 이는 처음 승인 체크를 위해 가져온 다음에 이루어 집니다. 일반적인 요청-응답 주기에서는 별 문제가 없는 것이 승인은 보통 추가되자 마자 체크가 되는 것은 아니기 때문입니다 (예를 들어 관리 화면만 봐도 그렇습니다). 테스트로든 뷰에서든, 만약 승인을 추가하고 그 즉시 체크를 해야 한다면, 가장 쉬운 방법은 사용자를 데이터베이스에서 다시 가져오는(re-fetch) 것입니다. 예를 들면 다음과 같습니다:

```python
from django.contrib.auth.models import Permission, User
from django.shortcuts import get_object_or_404

def user_gains_perms(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    # 어떤 승인 체크가 일어나기만 하면 현재 승인들이 저장됩니다.
    user.has_perm('myapp.change_bar')

    permission = Permission.objects.get(codename='change_bar')
    user.user_permissions.add(permission)

    # 저장된 승인들을 체크합니다.
    user.has_perm('myapp.change_bar')  # 실패(False)

    # 새 사용자(User) 인스턴스를 요청합니다.
    # user.refresh_from_db() 는 저장(cache)에 대해 명확하게 동작하지 않을 수 있음을 주의 하십시오.
    user = get_object_or_404(User, pk=user_id)

    # 데이터베이스로부터 승인 저장(cache)이 다시 일어납니다.
    user.has_perm('myapp.change_bar')  # 성공(True)

    ...
```

### 웹 요청에 대해 인증하기

장고는 세션([sessions](https://docs.djangoproject.com/en/1.10/topics/http/sessions/)) 과 미들웨어(middleware)를 사용해서 인증 시스템을 **요청 객체 (request objects)** 에 연결합니다.

이들은 현재 사용자를 나타내는 **request.user** 속성을 모든 요청에 제공합니다. 현재 사용자가 아직 로그인하지 않았으면, 이 속성은 **AnonymousUser** 의 인스턴스로 설정되고, 로그인 한 경우 **User**의 인스턴스가 됩니다.

이와는 별도로 **is_authenticated** 를 사용할 수 있습니다(?) 다음과 같습니다:

```python
if request.user.is_authenticated:
    # 인증된 사용자이면 뭔가를 하십시오.
    ...
else:
    # 익명의 사용자이면 뭔가를 하십시오.
    ...
```

#### 사용자 로그인하는 방법

인증된 사용자를 현재의 세션에 추가하고 싶으면  - **login()** 함수를 사용합니다.

```python
login(request, user, backend=None)
```

사용자를 로그인 하려면, 뷰(view)에서 **login()** 을 사용합니다. 이 함수는 **HttpRequest** 객체와 **User** 객체를 인자로 받습니다. **login()** 장고의 세션 프레임웍을 사용하여 사용자의 ID를 세션에 저장합니다.

익명 세션 동안에 있던 모든 데이터 집합들은 사용자가 로그인한 다음에 계속 유지된다는 것을 기억하시기 바랍니다.

아래의 예제는 어떻게 **authenticate()** 와 **login()** 이 두 개의 함수를 사용하는지를 보여줍니다.:

```python
from django.contrib.auth import authenticate, login

def my_view(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    if user is not None:
        login(request, user)
        # 성공 페이지로 재연결(redirect)합니다.
        ...
    else:
        # 'invalid login' 에러 메시지를 반환합니다.
        ...
```

> **장고  1.10에서 변화된 점**:
>
> 예전 버전에서는 수동으로 사용자를 로그인할 때 **login()** 을 호출하기 전에 **authenticate()** 로 사용자를 인증하는데 성공했어야 했습니다. 지금은 새로운 **backend** 인자를 사용해서 백엔드를 지정할 수 있습니다.

**인증 백엔드 선택하기**

사용자가 로그인 할 때, 사용자의 ID와 인증에 사용될 백엔드가 사용자 세션에 저장됩니다. 이것은 같은 인증 백엔드([authentication backend](https://docs.djangoproject.com/en/1.10/topics/auth/customizing/#authentication-backends)) 가 미래의 요청시에 사용자의 세부 정보를 가져올 수 있도록 합니다. 세션에 저장되는 인증 백엔드는 다음과 같이 선택됩니다:

1. 만약 제공된다면, 선택적 백엔드(optional **backend**) 인자의 값을 사용합니다.
2. 존재한다면 **user.backend** 속성의 값을 사용합니다. 이것은 **authenticate()** 와 **login()**을 짝을 짓도록 허용합니다: **authenticate()** 는 반환되는 사용자 객체에 **user.backend** 속성을 지정합니다.
3. 하나만 있을 경우 **AUTHENTICATION_BACKENDS** 에 있는 **backend** 를 사용합니다.
4. 다른 경우, 예외를 발생시킵니다.

1번과 2번의 경우에, **backend** 인자의 값이나 **user.backend** 속성은 실제 백엔드 클래스면 안되고 점으로 연결한 import 경로 문자열(a dotted import path string) 이어야 합니다. (**AUTHENTICATION_BACKENDS** 에서 찾을 수 있는 것과 같습니다)

#### 사용자 로그 아웃하는 방법

```python
logout(request)
```

**django.contrib.auth.login()** 을 통해서 로그인한 사용자가 로그 아웃하려면, **django.contrib.auth.logout()** 을 같은 뷰 범위에서 사용합니다. 이 함수는 **HttpRequest** 객체를 인자로 가지며 반환 값이 없습니다. 예제는 아래와 같습니다:

```python
from django.contrib.auth import logout

def logout_view(request):
    logout(request)
    # 성공 페이지로 재이동(redirect) 합니다.
```

**logout()** 은 사용자가 로그인하지 않았다면 어떠한 에러나 예외도 던지지 않음을 명심하십시오.

**logout()** 을 호출할 때, 현재 요청을 위한 세션 데이터는 완전히 제거됩니다. 모든 존재하는 데이터는 삭제됩니다. 이것은 같은 웹 브라우저를 사용하는 다른 사용자가 로그인해서 이전 사용자의 세션 데이터에 접근하는 것을 막이 위해서 입니다. 로그 아웃한 직후의 사용자가 사용할 세션에 뭔가를 담고 싶으면, **django.contrib.auth.logout()** 을 호출한 이후에 그 작업을 하면 됩니다.

#### 로그인한 사용자의 접근을 제한하기

**저수준의 방법(The raw way)**

페이지 접근을 막는 간단하고, 낮는 단계의 방법은 **request.user.is_authenticated** 를 체크해서 아닐 경우 로그인 페이지로 재연결하거나:

```python
from django.conf import settings
from django.shortcuts import redirect

def my_view(request):
    if not request.user.is_authenticated:
        return redirect('%s?next=%s' % (settings.LOGIN_URL, request.path))
    # ...
```

...아니면 에러 메시지를 나타내는 것입니다:

```python
from django.shortcuts import render

def my_view(request):
    if not request.user.is_authenticated:
        return render(request, 'myapp/login_error.html')
    # ...
```

**login_required 테코레이터(decorator)**

* **login\_required(redirect\_field\_name='next', login\_url=None)**

	보다 간단하게는, 편리한 **login_required()** 데코레이터를 사용할 수 있습니다:

	```python
	from django.contrib.auth.decorators import login_required

	@login_required
	def my_view(request):
    	...
	```

	**login_required()** 는 아래와 같이 동작합니다:

	* 사용자가 로그인되어 있지 않으면, **settings.LOGIN_URL** 로 재이동하면서, 현재의 절대 경로를 쿼리 문자열로 전달합니다. 예를 들면 이렇게 됩니다: **/accounts/login/?next=/polls/3/**.
	* 사용자가 로그인되어 있으면, 뷰(view)를 정상적으로 실행합니다. 뷰 코드는 사용자가 로그인되어 있다고 가정해도 됩니다.

	기본으로는, 인증이 성공했을 때 사용자가 재이동해야하는 경로는 **"next"** 라는 쿼리 문자열 매개 변수에 저장되어 있습니다. 이 매개 변수의 이름을 바꾸고 싶으면, **login_required()** 에 **redirect_field_name** 이라는 매개 변수를 사용해서 지정할 수 있습니다.:

	```python
	from django.contrib.auth.decorators import login_required

	@login_required(redirect_field_name='my_redirect_field')
	def my_view(request):
    	...
	```

	만약 **redirect_field_name** 값을 지정한다면, 아울러 로그인 템플릿도 다시 작성해야할 가능성이 높다는 것을 알아둬야 합니다. 왜냐면 재이동(redirect) 경로를 저장하는 템플릿 내용 변수(context variable)가 키로**redirect_field_name** 를 사용하지 (기본값인) **"next"** 를 사용하지 않을 것이기 때문입니다.

	**login_required()** 는 또 선택 사항으로 **login_url** 매개 변수를 가집니다. 예를 들어 보면 아래와 같습니다:

	```python
	from django.contrib.auth.decorators import login_required

	@login_required(login_url='/accounts/login/')
def my_view(request):
	    ...
	```

	**login_url** 매개 변수를 특별히 지정하지 않으면, **settings.LOGIN_URL** 값을 확실히 해서 로그인 뷰(login view)와 잘 연결될 필요가 있음을 명심해야 합니다. 예를 들어, 아래의 코드를 URLconf 에 추가하는 것은 기본입니다:

	```python
	from django.contrib.auth import views as auth_views

	url(r'^accounts/login/$', auth_views.login),
	```

	**settings.LOGIN_URL** 은 뷰 함수(view function) 이름과 이름있는 URL 패턴([named URL patterns](https://docs.djangoproject.com/en/1.10/topics/http/urls/#naming-url-patterns))도 받을 수 있습니다. 이렇게 하면 설정을 고치지 않고도 URLconf 에서 자유롭게 로그인 뷰를 재-맵핑(remap)할 수 있습니다.

> **login_required** 데코레이터는 사용자의 **is_active** 를 체크하지 않습니다, 기본 **AUTHENTICATION_BACKENDS** 가 비활성 사용자를 거부합니다.    

> **See also**
>
> 장고의 관리 화면(admin)을 직접 만들고 있거나 (제공되는 뷰에서 쓰는 것과 같은 인증 체크를 할 필요가 있다면), **django.contrib.admin.views.decorators.staff\_member_required()** 데코레이터를 살펴 보는 것이 **login_required()** 보다 좋을 수 있습니다.

**LoginRequired 믹스인(mixin)**

클래스 기반 뷰([class-based views](https://docs.djangoproject.com/en/1.10/topics/class-based-views/))를 사용할 때는, **LoginRequiredMixin** 을 사용하여 **login_required** 에서와 같은 기능을 구현할 수 있습니다. 이 믹스인(mixin)은 상속 리스트에서 가장 왼쪽에 위치해야 합니다.

* class **LoginRequiredMixin**

	```
	장고 1.9에서 추가된 것입니다.
	```

	뷰에서 이 믹스인을 사용하면, 비-인증 사용자의 모든 요청은 로그인 페이지로 재-연결되거나, **raise_exception** 매개 변수에 따라 HTTP 403 Forbidden 에러를 표시하도록 합니다.

	비인증 사용자를 처리하는 방식은 **AccessMixin** 의 매개 변수를 지정함으로써 마음대로 변경할 수 있습니다:

	```python
	from django.contrib.auth.mixins import LoginRequiredMixin

	class MyView(LoginRequiredMixin, View):
    	login_url = '/login/'
    	redirect_field_name = 'redirect_to'
	```

> **login_required** 데코레이터와 마찬가지로, 이 믹스인도 사용자가  **is_active** 인지를 체크하는지는 않고, 다만 기본  **AUTHENTICATION_BACKENDS** 가 비활성 사용자를 막는 것입니다.

**테스트를 통과한(?) 로그인 사용자의 접근 제한하기**

어떤 승인이나 다른 테스트에 기반을 둔 접근 제한을 위해서는, 본질적으로 이전 절에서 설명한 것과 동일하게 하면 됩니다.

간단한 방법은 뷰에서 직접 **request.user** 에 테스트를 실행하는 것입니다. 예를 들어, 아래는 사용자의 이메일이 요구된 도메인을 가지고 있는지를 검사해서 아니라면 로그인 페이지로 재-이동 하는 예입니다:

```python
from django.shortcuts import redirect

def my_view(request):
    if not request.user.email.endswith('@example.com'):
        return redirect('/login/?next=%s' % request.path)
    # ...
```

* **user\_passes_test(test_func, login_url=None, redirect\_field_name='next')**

	보다 간단하게는, **user\_passes_test** 데코레이터를 사용하면 편리한데 이것은 호출 가능 한 것(callable)이 **False** 를 반환하면 재-이동을 수행합니다:

	```python
	from django.contrib.auth.decorators import user_passes_test

	def email_check(user):
    	return user.email.endswith('@example.com')

	@user_passes_test(email_check)
	def my_view(request):
    	...
	```

	**user\_passes_test()** 에는 하나의 필수 인자가 있습니다: **User** 객체를 인자로 받아서 사용자가 페이지를 볼 수 있게 허용되면 **True** 를 반환하는 호출 가능한 것(callable)입니다. **user_passes_test()** 는 **User** 가 익명인지 자동으로 검사하지 않음을 명심해야 합니다.

	**user\_passes_test()** 에는 선택 가능한 두 개의 인자도 있습니다:

	* **login_url**  

		테스트를 통과하지 못한 사용자가 재이동할 URL 을 특별히 지정하도록 합니다. 아마도 로그인 페이지가 될 것이므로 따로 지정하지 않으면 기본으로 **settings.LOGIN_URL** 로 지정됩니다.

	* **redirect\_field_name**  

		기능은 **login_required()** 에서와 같습니다. **None** 으로 두면 URL 에서 제거하게 되는데, 테스트를 통과하지 못해서 재이동해야하는 사용자를 비-로그인 페이지 등 “next page” 가 없는 페이지로 이동시키고 싶을 때 사용할 수 있습니다.

	예를 들면 아래와 같습니다:

	```
	@user_passes_test(email_check, login_url='/login/')
	def my_view(request):
		...
	```

* class **UserPassesTestMixin**

	```
	장고 1.9에서 추가된 것입니다.
	```

	클래스 기반 뷰를 사용할 때, **UserPassesTestMixin** 로는 다음과 같은 것들을 할 수 있습니다.

	* **test_func()**

		클래스에 테스트 기능을 제공하려면 **test_func()** 메소드를 재정의해야 합니다. 더 나아가서, 비인증 사용자의 처리를 직접 구현하려면  **AccessMixin** 의 (구현체를 ?) 매개 변수에 할당하면 됩니다 (말을 조금 더 다듬어야 합니다):

		```
		from django.contrib.auth.mixins import UserPassesTestMixin

		class MyView(UserPassesTestMixin, View):

    	def test_func(self):
    		return self.request.user.email.endswith('@example.com')
		```

	* **get\_test_func()**

		또한 **get_test_func()** 메소드를 재정의해서 믹스인이 검사 함수로 (**test_func()** 대신에) 다른 이름을 가지게 할 수 있습니다.

> **UserPassesTestMixin** 쌓는 문제
>
> **UserPassesTestMixin** 방법이 구현되었기 때문에, 상속 리스트에 이것을 쌓을 수 없습니다. 아래의 코드는 동작하지 않습니다:
>
> ```python
> class TestMixin1(UserPassesTestMixin):
>     def test_func(self):
>         return self.request.user.email.endswith('@example.com')
>
> class TestMixin2(UserPassesTestMixin):
>     def test_func(self):
>         return self.request.user.username.startswith('django')
>
> class MyView(TestMixin1, TestMixin2, View):
>     ...
> ```
>
> **TestMixin1** 가  **super()** 를 호출하고 결과를 가지고 있게 되면, **TestMixin1** 는 더이상 혼자서는 동작할 수 없습니다. (이부분은 아직 완전히 이해하지 못했습니다. 나중에 다시 정리해야 합니다.)

**The permission_required decorator**

* **permission\_required(perm, login_url=None, raise\_exception=False)**

	사용자가 특별한 (것들에 대해) 승인을 가지는 지  검사하는 것은 일반적인 임무입니다. 그런 이유로, 장고는 이런 경우에 대해 보다 간단한 방법을 제공합니다: **permission_required()** 데코레이터가 그것입니다:

	```python
	from django.contrib.auth.decorators import permission_required

	@permission_required('polls.can_vote')
	def my_view(request):
		...
	```

	**has_perm()** 메소드와 마찬가지로, 승인 이름은 다음과 같이 **"<app label>.<permission codename>"** 형태가 됩니다. (가령 **polls** 의 모델에 대한 승인은 **polls.can_vote** 가 됩니다).

	데코레이터는 승인들의 반복자(iterable)를 가질 수 있는데, 이런 경우에 사용자가는 뷰에 접근하기 위해 모든 승인들을 가지고 있어야한 합니다.

	**permission_required()** 는 선택 사항으로 **login_url** 매개 변수를 가질 수 있음을 명심하시기 바랍니다:

	```python
	from django.contrib.auth.decorators import permission_required

	@permission_required('polls.can_vote', login_url='/loginpage/')
	def my_view(request):
	...
	```

	**login_required()** 데코레이터에서와 같이, **login_url** 대신에 **settings.LOGIN_URL** 를 기본으로 사용할 수 있습니다.

	**raise_exception** 매개 변수가 주어지면, 데코레이터는 로그인 페이지로 재연결하지 않고 **PermissionDenied** 를 발생시켜서, [the 403 (HTTP Forbidden) view](https://docs.djangoproject.com/en/1.10/ref/views/#http-forbidden-view) 를 바로 표시합니다.

	**raise_exception** 을 사용하면서 로그인 기능을 같이 제공하고 싶으면, **login_required()** 데코레이터를 추가하면 됩니다:

	```
	from django.contrib.auth.decorators import login_required, permission_required

	@login_required
	@permission_required('polls.can_vote', 	raise_exception=True)
	def my_view(request):
		...
	```

	> **Django 1.9** 에서 변한 부분:
	>
	> 예전 버전에서는 **permission** 매개 변수가 문자열, 리스트, 그리고 튜플하고만 작동했습니다. 지금은 스트링과 모든 반복 가능한(iterable) 형태와 작동합니다.

**PermissionRequiredMixin 믹스인**

클래스 기반 뷰에서 승인 검사를 하려면, **PermissionRequiredMixin** 를 사용하면 됩니다:

* class **PermissionRequiredMixin**

	```
	장고 1.9에서 추가된 것입니다.
	```

	이 믹스인은 **permission_required** 데코레이터와 같이, 뷰에 접근하려는 사용자가 모든 승인을 가지고 있는지를 검사합니다. **permission_required** 매개 변수를 사용하여 승인 (이나 승인 반복 형태) 를 지정해야 합니다:

	```
	from django.contrib.auth.mixins import PermissionRequiredMixin

	class MyView(PermissionRequiredMixin, View):
		permission_required = 'polls.can_vote'
		# 다수의 승인일 경우는 아래처럼 합니다:
		permission_required = ('polls.can_open', 'polls.can_edit')
	```

	비인증 사용자를 처리하는 부분을 사용자화 하기 위해 **AccessMixin** 의 어떤 매개 변수라도 지정할 수 있습니다.

	또 아래와 같은 메소드들을 재정의할 수 있습니다:

	* **get_permission_required()**

		믹스인에 사용될 승인들의 이름들을 반복(iterable) 형태로 반환합니다. 기본은 **permission_required** 속성인데, 필요하다면 튜플로 변환합니다. (반환 타입을 말하는 것 같습니다. 나중에 다시 확인합니다.)

	* **has_permission()**

		불린(boolean) 값을 반환하는데 이는 현재 사용자가 제공받은(decorated ?) 뷰를 실행할 수 있는지 여부를 나타냅니다. 이 함수는 기본으로는 **has_perms()** 함수의 결과를 반환하는데, 이 때 **get\_permission_required()** 가 반환하는 승인 리스트를 사용합니다.

#### 클래스 기반 뷰에서 비승인 요청에 대해 재연결(Redirecting) 하기

클래스 기반 뷰에서 접근 제한을 처리할 때는, **AccessMixin** 을 사용함으로써 사용자를 로그인 페이지로 재이동시키거나 HTTP 403 Forbidden 응답을 하는 것을 쉽게 할 수 있습니다.

* class **AccessMixin**

	```
	장고 1.9에서 추가된 것입니다.
	```

	**login_url**

	**get\_login_url()** 의 기본 반환 값입니다. **get_login_url()** 이 **settings.LOGIN_URL** 의 값을 사용하게 되는 경우에는 기본 값이 **None** 입니다. (이 문장은 다시 봅니다)

	**permission\_denied_message**

	**get\_permission\_denied\_message()** 의 기본 반환 값입니다. 기본은 빈 문자열입니다.

	**redirect\_field_name**

	**get\_redirect\_field\_name()** 의 기본 반환 값입니다. 기본은 **"next"** 입니다.

	**raise_exception**

	이 속성이 **True** 가 되면, 재이동없이 **PermissionDenied** 예외가 발생합니다. 기본은 **False** 입니다.

	**get\_login_url()**

	테스트를 통과하지 못한 사용자가 재이동해야할 URL 을 반환합니다. 설정되어 있으면 **login_url** 을 반환하고, 아니면 **settings.LOGIN_URL** 을 반환합니다.

	**get_permission\_denied\_message()**

	**raise_exception** 이 **True** 가 되면, 이 메소드가 에러 핸들러에게 전달되는 에러 메시지를 처리하고 그 결과를 사용자에게 보여줍니다. 기본으로는 **permission\_denied\_message** 속성을 반환합니다.

	**get\_redirect\_field_name()**

	로그인이 성공한 후에 사용자가 재이동할 URL 까지 포함한 쿼리 매개 변수의 이름을 반환합니다. 이것을 **None** 으로 설정하면, 쿼리 매개 변수가 추가되지 않습니다. 기본으로 **redirect\_field\_name** 속성을 반환합니다.

	**handle\_no_permission()**

	**raise_exception** 의 값에 따라, 이 메소드는 **PermissionDenied** 예외를 발생하거나 사용자를 **login_url** 로 재이동합니다. 설정되어 있으면 **redirect\_field_name** 을 포함합니다.

**비밀 번호 변경에 따른 세션 무효화**

> **장고 1.10에서 변화된 부분**:
>
> 세션 유효 검사는 **SessionAuthenticationMiddleware** 이 설정되어 있든 아니든 장고1.10에서 의무 사항입니다. (비활성화하는 방법은 없습니다). 예전 버전에서는, 이 보호 기능은 **django.contrib.auth.middleware.SessionAuthenticationMiddleware** 이 **MIDDLEWARE** 에서 활성화되어 있을 때만 적용됩니다.

**AUTH\_USER\_MODEL** 이 **AbstractBaseUser** 를 상속받거나 자체에서 직접 **get\_session\_auth\_hash()** 메소드를 구현한 경우, 인증된 세션은 이 함수에서 반환된 해쉬(hash)를 포함합니다. **AbstractBaseUser** 인 경우에는, 이 값은 비밀 번호 필드의 HMAC(Hash-based Message Authentication Code) 입니다. 장고는 각각의 요청에 대한 세션에 있는 해쉬와 요청 중에 계산된 해쉬가 들어맞는지를 검사합니다. 이것은 사용자가 비밀 번호를 변경하면 모든 세션에서 로그 아웃하도록 만듭니다.

장고에 포함되어 있는 기본 비밀 번호 변경 뷰들인, **django.contrib.auth** 관리 화면에 있는 **password\_change()** 와 **user\_change\_password** 는, 세션을 새 비밀 번호 해쉬로 업데이트해서 사용자가 비밀 번호를 변경하면서 로그 아웃하지 않아도 되게 합니다. 비밀 번호 변경 뷰를 새로 만들면서 이와 비슷한 기능을 구현하고 싶으면, **update\_session\_auth\_hash()** 함수를 사용하면 됩니다. 하지만, 이 경우에도 사용자가 비밀 번호를 변경할 때 세션이 무효화되길 원한다면 (예를 들어, 컴퓨터에 있는 세션 쿠키가 도난당했다고 믿는 경우 등), 그 때는 세션을 로그 아웃하는 것이 필요할 수 있습니다.

* **update\_session\_auth\_hash(request, user)**

	이 함수는 현재 요청과 함께 상속받은 새 세션 해쉬로부터 업데이트된 사용자를 인자로 받아서 세션 해쉬를 적절하게 업데이트합니다. 사용 예시는 다음과 같습니다:

	```
	from django.contrib.auth import update_session_auth_hash

	def password_change(request):
		if request.method == 'POST':
			form = PasswordChangeForm(user=request.user, data=request.POST)
			if form.is_valid():
				form.save()
				update_session_auth_hash(request, form.user)
		else:
			...
	```

> **get\_session\_auth_hash()** 는 **SECRET_KEY** 에 기초하고 있어서, 새로운 비밀 번호로 사이트를 업데이트 하는 것은 이전에 존재하던 세션에서는 작동하지 않습니다.

#### 인증 뷰(Authentication Views)

장고는 로그인, 로그아웃, 비밀 번호 관리 등을 처리하기 위한 여러 가지 뷰를 제공합니다. 이것은 stock(?) auth 폼(forms)을 사용하도록 하지만, 직접 만든 폼으로 대체도 가능합니다.

장고는 인증 뷰를 위한 기본 템플릿(template)을 제공하지 않습니다. 사용할 뷰에 대한 템플릿은 직접 만들어야 합니다. 템플릿 내용 변수(context)는 각각의 뷰에 대해 문서화되어 있습니다. 아래의 모든 인증 뷰(all authentication views) 부분을 보기 바랍니다.

**뷰(views) 사용하기**

프로젝트에 이 뷰들을 구현하는 방법은 여러 가지가 있습니다. 가장 쉬운 방법은 **django.contrib.auth.urls** 에서 제공하는 URLconf 를 자신의 URLconf 에 포함하는 것입니다, 예를 들면 다음과 같습니다:

```python
urlpatterns = [
    url('^', include('django.contrib.auth.urls')),
]
```

이것은 아래의 URL 패턴들을 포함하는 것과 같습니다:

```django
^login/$ [name='login']
^logout/$ [name='logout']
^password_change/$ [name='password_change']
^password_change/done/$ [name='password_change_done']
^password_reset/$ [name='password_reset']
^password_reset/done/$ [name='password_reset_done']
^reset/(?P<uidb64>[0-9A-Za-z_\-]+)/(?P<token>[0-9A-Za-z]{1,13}-[0-9A-Za-z]{1,20})/$ [name='password_reset_confirm']
^reset/done/$ [name='password_reset_complete']
```

이 뷰들은 접근하기 쉽도록 URL 이름을 제공합니다. 이름지어진 URL 패턴에 대해서 좀 더 알고 싶으면 [the URL documentation](https://docs.djangoproject.com/en/1.10/topics/http/urls/) 를 봅니다.

자신의 URLs 에 대해 자신만의 제어를 하고 싶으면, URLconf 에서 특별한 뷰를 지정할 수 있습니다:

```
from django.contrib.auth import views as auth_views

urlpatterns = [
    url('^change-password/$', auth_views.password_change),
]
```

뷰는 선택 사항인 인자들을 가질 수 있는데 이 들을 이용해서 뷰의 행동을 변경할 수 있습니다. 예를 들어, 뷰가 사용하는 템플릿 이름을 변경하려면, **template_name** 인자를 사용하면 됩니다. 이렇게 하는 한 가지 방법은 URLconf 에서 키워드 인자를 제공하는 것입니다, 이 값들은 뷰에게 전달됩니다. 예를 들면 다음과 같습니다:

```
urlpatterns = [
    url(
        '^change-password/$',
        auth_views.password_change,
        {'template_name': 'change-password.html'}
    ),
]
```

모든 뷰는 **TemplateResponse** 인스턴스를 반환받는데, 이것은 응답 데이터를 화면에 보여주기 전에 보다 쉽게 사용자화할 수 있도록 합니다. 사용자화하는 한 가지 방법은 자신의 뷰에서 이 뷰를 감싸는(wrap) 것입니다:

```
from django.contrib.auth import views

def change_password(request):
    template_response = views.password_change(request)
    # `template_response`를 가지고 뭔가를 합니다.
    return template_response
```

더 자세한 사항은 [TemplateResponse documentation](https://docs.djangoproject.com/en/1.10/ref/template-response/) 를 보기 바랍니다.

**모든 인증 뷰(All authentication views)**

아래는 **django.contrib.auth** 에서 제공하는 모든 뷰의 목록입니다. 구현을 위한 세부 사항은 앞서 나왔던 뷰(views) 사용하기 부분을 보도록 합니다.

* **`login`(request, template_name='registration/login.html', redirect\_field\_name='next', authentication\_form=AuthenticationForm, current\_app=None, extra\_context=None, redirect\_authenticated\_user=False)**

	**URL 이름: login**

	이름지어진(named) URL 패턴에에 대해서는 [the URL documentation](https://docs.djangoproject.com/en/1.10/topics/http/urls/) 를 보도록 합니다.

	**선택 인자(Optional arguments):**

	* **template_name**: 사용자가 로그인할 때 사용되는 뷰를 보여주기 위한 템플릿의 이름입니다. 기본 값은 **registration/login.html** 입니다.

	* **redirect\_field_name**: 로그인한 후에 재이동할 URL을 담고있는 **GET** 필드의 이름입니다. 기본 값은 **next** 입니다.

	* **authentication_form**: 인증에 사용할 호출 가능한 것으로 (보통은 그냥 폼(form) 클래스) 입니다. 기본 값은 **AuthenticationForm** 입니다.

	* **current_app**: 어떤 앱이 현재 뷰를 담고 있는지를 알려주는 힌트입니다. 더 자세한 사항은 [the namespaced URL resolution strategy](https://docs.djangoproject.com/en/1.10/topics/http/urls/#topics-http-reversing-url-namespaces) 를 보기 바랍니다.

	* **extra_context**: 기본 내용 변수에 더해서 탬플릿에 전달되는 딕셔너리(dictionary) 형태의 내용 변수(context) 데이터입니다.

	* **redirect\_authenticated\_user**: 인증된 사용자가 로그인 페이지에 접근할 때 자동으로 로그인에 성공한 것처럼 재이동을 할지를 결정하는 불린 값입니다. 기본 값은 **False** 입니다.

	> **경고**
	>
	> **redirect\_authenticated\_user** 를 사용하면, 다른 웹 사이트가 우리 웹 사이트의 이미지 파일로 재이동(redirect) URL을 요청하여 그 사이트의 방문자가 우리 사이트에서 인증되었는지를 확인할 수 있습니다. 이러한 “[social media fingerprinting](https://robinlinus.github.io/socialmedia-leak/)” 정보 유출을 막기 위해서는, 모든 이미지와 파비콘(favicon)을 별도의 도메인에서 제공(host)해야 합니다.

	> **1.9 버전부터 없어지는 것**:
	>
	> `current_app` 매개 변수는 없어지게 되며 장고 2.0에서 제거 될 예정입니다. 호출할 때는 이 대신에 `request.current_app` 를 지정하면 됩니다.

	> **장고 1.10 에서 추가된 것**:
	>
	> **redirect\_authenticated\_user** 매개 변수가 추가되었습니다.

	**django.contrib.auth.views.login** 가 하는 것은 다음과 같습니다:

	* **GET** 을 통해 호출하면, 동일한 URL에 POST 하는 로그인 양식(form)을 보여줍니다. 이 부분에 대해서는 바로 뒤에서 좀 더 다룹니다 (More on this in a bit). (?)
	* 사용자가 제출한 증명서로 **POST** 를 통해 호출하면, 사용자를 로그인하려고 시도합니다. 로그인이 성공하면, 뷰는 **next** 에 지정된 URL 로 재이동합니다. **next** 가 제공되지 않으면, **settings.LOGIN_REDIRECT_URL** 로 재이동합니다. (기본 값은 **/accounts/profile/** 입니다). 로그인에 실패하면 로그인 양식을 다시 보여줍니다.

	로그인 템플릿, 기본은 **registration/login.html** 인, 을 위해 html 을 제공하는 것은 개발자의 책임입니다. 이 템플릿은 4개의 템플릿 내용 변수(context variables)를 인자로 전달받습니다:

	* **form**: **AuthenticationForm** 을 나타내는 양식(**Form**) 객체.
	* **next**: 로그인이 성공한 후 재이동할 URL. 이것은 쿼리 문자열도 같이 포함할 수 있습니다.
	* **site**: **SITE_ID** 설정에 따른 현재 사이트(**Site**). 사이트 프레임웍을 설치한 것이 없으면, 이것은 현재의 **HttpRequest** 에서 사이트 이름과 도메인을 상속받는 **RequestSite** 의 인스턴스로 설정됩니다.
	* **site_name**: **site.name** 의 별명. 사이트 프레임웍을 설치한 것이 없으면, 이것은 **request.META['SERVER_NAME']** 값으로 지정됩니다. 사이트에 대한 더 자세한 내용은 [The “sites” framework](https://docs.djangoproject.com/en/1.10/ref/contrib/sites/) 를 보면 됩니다.

	**registration/login.html** 템플릿을 호출하고 싶지 않으면, **template_name** 매개 변수를 URLconf 에 있는 뷰의 추가 인자를 통해 전달하면 됩니다. 예를 들어, 아래의 URLconf 는 **myapp/login.html** 을 사용하도록 합니다s:

	```python
	url(r'^accounts/login/$', auth_views.login, {'template_name': 'myapp/login.html'}),
	```

	**redirect\_field\_name** 을 뷰로 전달하는 것으로 로그인 한 후에 재이동하는 URL을 담고 있는 **GET** 필드의 이름을 지정할 수도 있습니다. 기본으로 이 필드는 **next** 에 의해 호출됩니다.

	아래에 **registration/login.html** 템플릿의 보기를 나타냈습니다. 이 걸 수정해서 사용해도 됩니다. 아래 파일은 **base.html** 템플릿을 가지고 있고 **content** 블럭을 정의했다고 가정합니다:

	```html
	{% extends "base.html" %}

	{% block content %}

	{% if form.errors %}
	<p>Your username and password didn't match. Please try again.</p>
	{% endif %}

	{% if next %}
		{% if user.is_authenticated %}
		<p>Your account doesn't have access to this page. To proceed, please login with an account that has access.</p>
		{% else %}
    	<p>Please login to see this page.</p>
		{% endif %}
	{% endif %}

	<form method="post" action="{% url 'login' %}">
	{% csrf_token %}
	<table>
	<tr>
		<td>{{ form.username.label_tag }}</td>
		<td>{{ form.username }}</td>
	</tr>
	<tr>
		<td>{{ form.password.label_tag }}</td>
		<td>{{ form.password }}</td>
	</tr>
	</table>

	<input type="submit" value="login" />
	<input type="hidden" name="next" value="{{ next }}" />
	</form>

	{# Assumes you setup the password_reset view in your URLconf #}
	<p><a href="{% url 'password_reset' %}">Lost password?</a></p>

	{% endblock %}
	```

	인증을 사용자화 하려면 ([Customizing Authentication](https://docs.djangoproject.com/en/1.10/topics/auth/customizing/) 를 보기 바랍니다) 직접 만든 커스텀 인증을 로그인 뷰에서 **authentication_form** 매개 변수를 통해 전달할 수 있습니다. 이 양식은 __init__ 메소드에서 **request** 키워드 인자를 전달 받아야 하고, 인증된 사용자 객체를 반환하는 **get_user()** 메소드를 제공해야 합니다. (이 메소드는 폼 유효 검사가 성공한 이후에만 호출됩니다).

* **`logout`(request, next\_page=None, template\_name='registration/logged\_out.html', redirect\_field\_name='next', current\_app=None, extra\_context=None)**

	사용자를 로그 아웃합니다.

	**URL 이름: logout**

	**선택 사항인 인자들**:

	* **next\_page**: 로그 아웃한 후에 재이동할 URL. 지정된 것이 없으면 기본으로 **settings.LOGOUT\_REDIRECT\_URL** 를 사용합니다.
	* **template_name**: 사용자가 로그 아웃한 후에 보여지는 템플릿의 완전한 이름. 이 인자가 지정되지 않으면 기본으로 **registration/logged\_out.html** 가 됩니다.
	* **redirect\_field\_name**: 로그 아웃 후에 재이동할 URL을 담고 있는 **GET** 필드의 이름. 기본 값은 **next** 입니다. 주어진 GET 매개 변수가 전달되면 **next\_page** URL을 대체합니다.
	* **current_app**: 어떤 앱이 현재 뷰를 담고 있는지를 알려주는 힌트입니다. 더 자세한 사항은 [the namespaced URL resolution strategy](https://docs.djangoproject.com/en/1.10/topics/http/urls/#topics-http-reversing-url-namespaces) 를 보기 바랍니다.
	* **extra_context**: 기본 내용 변수에 더해서 탬플릿에 전달되는 딕셔너리(dictionary) 형태의 내용 변수(context) 데이터입니다.

	> **1.9 버전부터 없어지는 것**:
	>
	> `current_app` 매개 변수는 없어지게 되며 장고 2.0에서 제거 될 예정입니다. 호출할 때는 이 대신에 `request.current_app` 를 지정하면 됩니다.

	**템플릿 내용 변수(Template context)**:

	* **title**: “Logged out” 이라는 문자열의 지역화 버전입니다.
	* **site**: **SITE_ID** 설정에 따른 현재 사이트(**Site**). 사이트 프레임웍을 설치한 것이 없으면, 이것은 현재의 **HttpRequest** 에서 사이트 이름과 도메인을 상속받는 **RequestSite** 의 인스턴스로 설정됩니다.
	* **site_name**: **site.name** 의 별명. 사이트 프레임웍을 설치한 것이 없으면, 이것은 **request.META['SERVER_NAME']** 값으로 지정됩니다. 사이트에 대한 더 자세한 내용은 [The “sites” framework](https://docs.djangoproject.com/en/1.10/ref/contrib/sites/) 를 보면 됩니다.

* **`logout_then_login`(request, login\_url=None, current\_app=None, extra\_context=None)**

	사용자를 로그 아웃하고, 로그인 페이지로 재이동합니다.

	**URL 이름**: 기본 URL 이 제공되지 않음

	**선택 사항인 인자들**:

	* **login_url**: 재이동할 로그인 페이지의 URL. 지정된 것이 없으면 기본으로 **settings.LOGIN_URL** 을 사용합니다.
	* **current_app**: 어떤 앱이 현재 뷰를 담고 있는지를 알려주는 힌트입니다. 더 자세한 사항은 [the namespaced URL resolution strategy](https://docs.djangoproject.com/en/1.10/topics/http/urls/#topics-http-reversing-url-namespaces) 를 보기 바랍니다.
	* **extra_context**: 기본 내용 변수에 더해서 탬플릿에 전달되는 딕셔너리(dictionary) 형태의 내용 변수(context) 데이터입니다.

	> **1.9 버전부터 없어지는 것**:
	>
	> `current_app` 매개 변수는 없어지게 되며 장고 2.0에서 제거 될 예정입니다. 호출할 때는 이 대신에 `request.current_app` 를 지정하면 됩니다.

* **`password_change`(request, template\_name='registration/password\_change\_form.html', post\_change\_redirect=None, password\_change\_form=PasswordChangeForm, current\_app=None, extra\_context=None)**

	사용자가 비밀 번호를 변경하도록 합니다.

	**URL 이름: password_change**

	**선택 사항인 인자들**:

	* **template\_name**: 비밀 번호 변경 양식을 보여주는데 사용되는 템플릿의 전체 이름. 지정된 것이 없으면 기본 값은 **registration/password_change_form.html** 입니다.
	* **post\_change\_redirect**: 비밀 번호 변경이 성공한 다음 재이동하는 URL.
	* **password\_change\_form**: 사용자가 만든 “비밀 번호 변경” 양식으로 반드시 **user** 키워드 인자를 받도록 해야 합니다. 이 양식은 사용자의 비밀 번호를 실제로 변경하는데 책임이 있습니다. 기본 값은 **PasswordChangeForm** 입니다.
	* **current_app**: 어떤 앱이 현재 뷰를 담고 있는지를 알려주는 힌트입니다. 더 자세한 사항은 [the namespaced URL resolution strategy](https://docs.djangoproject.com/en/1.10/topics/http/urls/#topics-http-reversing-url-namespaces) 를 보기 바랍니다.
	* **extra_context**: 기본 내용 변수에 더해서 탬플릿에 전달되는 딕셔너리(dictionary) 형태의 내용 변수(context) 데이터입니다.

	> **1.9 버전부터 없어지는 것**:
	>
	> `current_app` 매개 변수는 없어지게 되며 장고 2.0에서 제거 될 예정입니다. 호출할 때는 이 대신에 `request.current_app` 를 지정하면 됩니다.

	**Template context**:

	* **form**: 비밀 번호 변경 양식 (위에 있는 **password\_change\_form** 을 봅니다).

* **`password_change_done`(request, template\_name='registration/password\_change\_done.html', current\_app=None, extra\_context=None)**

	사용자가 비밀 번호를 변경한 후에 보여지는 페이지입니다.

	**URL 이름: password\_change_done**

	**선택 사항인 인자들**:

	* **template_name**: 사용할 템플릿의 전체 이름. 지정된 것이 없으면 기본 값은 **registration/password_change_done.html** 입니다.
	* **current_app**: 어떤 앱이 현재 뷰를 담고 있는지를 알려주는 힌트입니다. 더 자세한 사항은 [the namespaced URL resolution strategy](https://docs.djangoproject.com/en/1.10/topics/http/urls/#topics-http-reversing-url-namespaces) 를 보기 바랍니다.
	* **extra_context**: 기본 내용 변수에 더해서 탬플릿에 전달되는 딕셔너리(dictionary) 형태의 내용 변수(context) 데이터입니다.

	> **1.9 버전부터 없어지는 것**:
	>
	> `current_app` 매개 변수는 없어지게 되며 장고 2.0에서 제거 될 예정입니다. 호출할 때는 이 대신에 `request.current_app` 를 지정하면 됩니다.

* **`password_reset`(request, template\_name='registration/password\_reset\_form.html', email\_template\_name='registration/password\_reset\_email.html', subject\_template\_name='registration/password\_reset\_subject.txt', password\_reset\_form=PasswordResetForm, token\_generator=default\_token\_generator, post\_reset\_redirect=None, from\_email=None, current\_app=None, extra\_context=None, html\_email_template\_name=None, extra\_email\_context=None)**

	패스워드를 재설정할 수 있는 일회용 링크를 생성해서 사용자가 비밀 번호를 재설정하도록 하며, 이 링크를 사용자가 등록한 이메일 주소로 전송합니다.

	지정한 이메일 주소가 시스템에 존재하지 않으면, 이 뷰는 이메일을 전송하지 않을 뿐만 아니라, 사용자는 어떤 에러 메시지도 받지 않게 됩니다. 이것은 잠재적인 공격자에게서 정보의 유출을 막기 위함입니다. 이 경우에라도 에러 메시지를 주고 싶으면, **PasswordResetForm** 을 상속받아서 **password\_reset\_form** 인자를 사용하면 됩니다.

	사용할 수 없는 비밀 번호라고 체크된 사용자는 LDAP 같은 외부의 인증 소스로 비밀 번호를 재설정하도록 하는 요청을 보낼 수 없습니다. (**set\_unusable\_password()** 를 보기 바랍니다). 메일 계정의 존재를 노출하지 않기 위해 그들은 어떠한 에러 메시지도 받지 않을 뿐만 아니라, 메일을 전송하지도 않음을 명심하십시오.

	**URL 이름: password\_reset**

	**선택 사항인 인자들**:

	* **template\_name**: 비밀 번호 변경 양식을 보여주기 위한 템플릿의 전체 이름. 지정된 것이 없으면 기본 값은 **registration/password\_reset\_form.html** 입니다.
	* **email\_template\_name**: 비밀 번호 재설정 링크를 가진 이메일을 생성하는데 사용하는 템플릿의 전체 이름. 지정된 것이 없으면 기본 값은 **registration/password\_reset\_email.html** 입니다.
	* **subject\_template\_name**: 비밀 번호 재설정 링크를 가진 이메일의 제목에 사용할 템플릿의 전체 이름. 지정된 것이 없으면 기본 값은 **registration/password\_reset\_subject.txt** 입니다.
	* **password\_reset\_form**: 비밀 번호를 재설정하기 위해 사용자의 이메일을 입력 받는데 사용되는 양식(Form). 기본 값은 **PasswordResetForm** 입니다.
	* **token\_generator**: 일회용 링크를 검사하기 위한 클래스의 인스턴스. 기본 값은 **default\_token\_generator** 인데, 이것은 **django.contrib.auth.tokens.PasswordResetTokenGenerator** 의 인스턴스입니다.
	* **post\_reset\_redirect**: 비밀 번호 재설정 요청이 성공한 다음에 재이동할 URL.
	* **from_email**: 유효한 이메일 주소. 장고는 기본으로 **DEFAULT\_FROM\_EMAIL** 를 사용합니다.
	* **current_app**: 어떤 앱이 현재 뷰를 담고 있는지를 알려주는 힌트입니다. 더 자세한 사항은 [the namespaced URL resolution strategy](https://docs.djangoproject.com/en/1.10/topics/http/urls/#topics-http-reversing-url-namespaces) 를 보기 바랍니다.
	* **extra\_context**: 기본 내용 변수에 더해서 탬플릿에 전달되는 딕셔너리(dictionary) 형태의 내용 변수(context) 데이터입니다.
	* **html\_email\_template\_name**: 비밀 번호 재설정 링크를 가진 **text/html** 복수(타입)의 이메일을 생성하는데 사용할 템플릿의 전체 이름. 기본으로는 HTML 이메일을 보내지 않게 되어 있습니다.
	* **extra\_email\_context**: 이메일 템플릿에서 사용 가능한 딕셔너리 형태의 내용 변수(context) 데이터.

	> **1.9 버전부터 없어지는 것**:
	>
	> `current_app` 매개 변수는 없어지게 되며 장고 2.0에서 제거 될 예정입니다. 호출할 때는 이 대신에 `request.current_app` 를 지정하면 됩니다.

	> **장고 1.9에서 추가된 것**:
	>
	> **extra\_email\_context** 매개 변수가 추가 되었습니다.

	**템플릿 내용 변수(context)**:

	* **form**: 사용자의 비밀 번호를 설정하기 위한 양식. (앞서 설명한 **password\_reset\_form** 을 보십시오).

	**이메일 템플릿 내용 변수(context)**:

	* **email**: **user.email** 의 별명(alias)
	* **user**: 이메일 양식 필드에 따른 현재 사용자. 활성화된 사용자만이 비밀 번호를 재설정할 수 있습니다. (**User.is_active is True**).
	* **site_name**: **site.name** 의 별명. 사이트 프레임웍을 설치한 것이 없으면, 이것은 **request.META['SERVER_NAME']** 값으로 지정됩니다. 사이트에 대한 더 자세한 내용은 [The “sites” framework](https://docs.djangoproject.com/en/1.10/ref/contrib/sites/) 를 보면 됩니다.
	* **domain**: **site.domain** 의 별명. 사이트 프레임웍을 설치한 것이 없으면, 이것은 **request.get_host()** 값으로 지정됩니다.
	* **protocol**: http 또는 https
	* **uid**: base 64 로 인코딩된 사용자의 주키(primary key).
	* **token**: 재설정 링크가 유효한지 검사하기 위한 토큰.

	예시로 만든 **registration/password\_reset\_email.html** 는 다음과 같습니다. (이메일 본문(body)에 쓰일 템플릿):

	```django
	Someone asked for password reset for email {{ email }}. Follow the link below:
	{{ protocol}}://{{ domain }}{% url 'password_reset_confirm' uidb64=uid token=token %}
	```

같은 템플릿 내용 변수(context) 가 제목 템플릿에 사용됩니다. 제목은 한 줄짜리 기본 텍스트의 문자열이어야 합니다.

* **`password_reset_done`(request, template\_name='registration/password\_reset\_done.html', current\_app=None, extra\_context=None)**

	사용자가 비밀 번호를 재설정하는 링크를 담은 이메일을 받은 후에 보여지는 페이지. 이 뷰는 **password\_reset()** 뷰가 명시적인 **post\_reset\_redirect** URL 집합을 가지고 있지 않으면 기본으로 불려집니다.

	**URL 이름: password\_reset\_done**

	> 지정한 이메일 주소가 시스템에 존재하지 않거나, 사용자가 비활성, 또는 사용할 수 없는 비밀 번호를 가진 경우에도, 이 뷰로 재이동하긴 하지만 이메일은 보내지지 않습니다.

	**선택 사항인 인자들**:

	* **template\_name**: 사용할 템플릿의 전체 이름. 지정된 것이 없으면 기본 값으로 **registration/password\_reset\_done.html** 을 가집니다.
	* **current\_app**: 어떤 앱이 현재 뷰를 담고 있는지를 알려주는 힌트입니다. 더 자세한 사항은 [the namespaced URL resolution strategy](https://docs.djangoproject.com/en/1.10/topics/http/urls/#topics-http-reversing-url-namespaces) 를 보기 바랍니다.
	* **extra\_context**: 기본 내용 변수에 더해서 탬플릿에 전달되는 딕셔너리(dictionary) 형태의 내용 변수(context) 데이터입니다.

	> **1.9 버전부터 없어지는 것**:
	>
	> `current_app` 매개 변수는 없어지게 되며 장고 2.0에서 제거 될 예정입니다. 호출할 때는 이 대신에 `request.current_app` 를 지정하면 됩니다.

* **`password_reset_confirm`(** *request, uidb64=None, token=None, template\_name='registration/password\_reset\_confirm.html', token\_generator=default\_token\_generator, set\_password\_form=SetPasswordForm, post\_reset_redirect=None, current\_app=None, extra\_context=None* **)**

	새 비밀 번호를 입력하기 위한 양식을 보여줍니다.

	**URL 이름: `password_reset_confirm`**

	**선택 사항인 인자들**:

	* `uidb64`: base 64 로 인코딩된 사용자 아이디. 기본 값은 **None** 입니다.
	* `token`: 비밀 번호가 유효한지 감사하기 위한 토큰. 기본 값은 **None** 입니다.
	* `template_name`: 비밀 번호 확정 뷰를 보여줄 템플릿의 전제 이름. 기본 값은 **registration/password\_reset\_confirm.html** 입니다.
	* `token_generator`: 비밀 번호를 검사하기 위한 클래스의 인스턴스. 기본 값은 **default\_token\_generator** 인데, 이것은 **django.contrib.auth.tokens.PasswordResetTokenGenerator** 의 인스턴스입니다.
	* `set_password_form`: 비밀 번호를 설정하는데 사용될 양식. 기본 값은 **SetPasswordForm** 입니다.
	* `post_reset_redirect`: 비밀 번호 재설정이 완료된 후 재이동할 URL. 기본 값은 **None** 입니다.
	* `current_app`: 어떤 앱이 현재 뷰를 담고 있는지를 알려주는 힌트입니다. 더 자세한 사항은 [the namespaced URL resolution strategy](https://docs.djangoproject.com/en/1.10/topics/http/urls/#topics-http-reversing-url-namespaces) 를 보기 바랍니다.
	* `extra_context`: 기본 내용 변수에 더해서 탬플릿에 전달되는 딕셔너리(dictionary) 형태의 내용 변수(context) 데이터입니다.

	**템플릿 내용 변수(context)**:

	* `form`: 사용자의 비밀 번호를 설정하기 위한 양식. (앞서 설명한 **password\_reset\_form** 을 보십시오).
	* `validlink`: 불린(Boolean) 값, 링크 (uidb64 와 토큰의 조합) 가 유효하거나 아직 사용 전이면 참입니다.

	> **1.9 버전부터 없어지는 것**:
	>
	> `current_app` 매개 변수는 없어지게 되며 장고 2.0에서 제거 될 예정입니다. 호출할 때는 이 대신에 `request.current_app` 를 지정하면 됩니다.

* **`password_reset_complete`(** *request, template\_name='registration/password\_reset\_complete.html', current\_app=None, extra\_context=None* **)**

	비밀 번호 변경이 성공했음을 사용자에게 알리기 위한 뷰를 보여줍니다.

	**URL 이름: `password_reset_complete`**

	**선택 사항인 인자들**:

	* `template_name`: 뷰를 보여주기 위해 사용되는 템플릿의 전체 이름. 기본 값은 **registration/password\_reset\_complete.html** 입니다.
	* `current_app`: 어떤 앱이 현재 뷰를 담고 있는지를 알려주는 힌트입니다. 더 자세한 사항은 [the namespaced URL resolution strategy](https://docs.djangoproject.com/en/1.10/topics/http/urls/#topics-http-reversing-url-namespaces) 를 보기 바랍니다.
	* `extra_context`: 기본 내용 변수에 더해서 탬플릿에 전달되는 딕셔너리(dictionary) 형태의 내용 변수(context) 데이터입니다.

	> **1.9 버전부터 없어지는 것**:
	>
	> `current_app` 매개 변수는 없어지게 되며 장고 2.0에서 제거 될 예정입니다. 호출할 때는 이 대신에 `request.current_app` 를 지정하면 됩니다.

#### 도우미 함수들(Helper functions)

* **`redirect_to_login`(** *next, login\_url=None, redirect\_field\_name='next'* **)**

	로그인 페이지로 재이동한 후, 로그인이 성공하면 다른 URL 로 돌아갑니다.

	**요구되는 인자**:

	* `next`: 로그인이 성공한 후 재이동할 URL.

	**선택 사항인 인자**:

	* `login_url`: 재이동할 로그인 페이지의 URL. 지정된 것이 없으면 기본 값은 **settings.LOGIN\_URL** 입니다.
	* `redirect_field_name`: 로그 아웃한 이후에 재이동할 URL을 담고 있는 **GET** 필드의 이름. 주어진 **GET** 매개 변수가 전달되면 **next** 를 오버라이드합니다.

#### 내장 양식(forms)

내장된 뷰를 사용하고 싶지는 않지만, 이 기능들을 위해 양식을 작성하지 않아도 되는 편의를 위해서, 인증 시스템은 여러 가지 내장 양식을 제공하는데 **django.contrib.auth.forms** 에 있습니다:

> 내장 인증 양식은 사용자 모델에 몇가지 가정을 합니다. 만약 따로 만든 사용자 모델([custom user model](https://docs.djangoproject.com/en/1.10/topics/auth/customizing/#auth-custom-user)) 을 사용한다면, 인증 시스템을 위해 직접 양식을 정의해야할 수도 있습니다. 더 자세한 내용은, 내장 인증 양식과 따로 만든 사용자 모델을 같이 사용하기([using the built-in authentication forms with custom user models](https://docs.djangoproject.com/en/1.10/topics/auth/customizing/#custom-users-and-the-built-in-auth-forms)) 라는 문서에 나와 있습니다.

* class **AdminPasswordChangeForm**

	사용자의 비밀 번호를 변경하기 위해 관리 화면(admin)에서 사용되는 양식.

	**user** 를 첫번째 인자로 취합니다.

* class **AuthenticationForm**

	사용자 로그인을 위한 양식.

	**request** 를 첫번째 인자로 취하는데, 하위 클래스에서 사용할 수 있도록 양식 인스턴스(form instance)에 저장합니다.

	* **`confirm_login_allowed`(** *user* **)**

		By default, **AuthenticationForm** rejects users whose **is_active** flag is set to **False**. You may override this behavior with a custom policy to determine which users can log in. Do this with a custom form that subclasses **AuthenticationForm** and overrides the **confirm_login_allowed()** method. This method should raise a **ValidationError** if the given user may not log in.

		For example, to allow all users to log in regardless of “active” status:

		```
		from django.contrib.auth.forms import AuthenticationForm

		class
		AuthenticationFormWithInactiveUsersOkay(AuthenticationForm):
    		def confirm_login_allowed(self, user):
        		pass
		```

		(In this case, you’ll also need to use an authentication backend that allows inactive users, such as as **AllowAllUsersModelBackend**.)

		Or to allow only some active users to log in:

		```
		class PickyAuthenticationForm(AuthenticationForm):
    		def confirm_login_allowed(self, user):
        		if not user.is_active:
            		raise forms.ValidationError(
                		_("This account is inactive."),
                		code='inactive',
            		)
        		if user.username.startswith('b'):
            		raise forms.ValidationError(
                		_("Sorry, accounts starting with 'b' aren't welcome here."),
                		code='no_b_users',
            		)
		```

* class **PasswordChangeForm**

	A form for allowing a user to change their password.

* class **PasswordResetForm**

	A form for generating and emailing a one-time use link to reset a user’s password.

	* **`send_email`(** *subject\_template\_name, email\_template\_name, context, from\_email, to\_email, html\_email\_template\_name=None* **)**

		Uses the arguments to send an **EmailMultiAlternatives**. Can be overridden to customize how the email is sent to the user.

		**Parameters**:

		* **subject_template_name** – the template for the subject.
		* **email_template_name** – the template for the email body.
		* **context** – context passed to the subject_template, email_template, and html_email_template (if it is not None).
		* **from_email** – the sender’s email.
		* **to_email** – the email of the requester.
		* **html_email_template_name** – the template for the HTML body; defaults to None, in which case a plain text email is sent.

		By default, **save()** populates the **context** with the same variables that **password_reset()** passes to its email context.

* class **SetPasswordForm**

	A form that lets a user change their password without entering the old password.

* class **UserChangeForm**

	A form used in the admin interface to change a user’s information and permissions.

* class **UserCreationForm**

	A **ModelForm** for creating a new user.

	It has three fields: **username** (from the user model), **password1**, and **password2**. It verifies that **password1** and **password2** match, validates the password using **validate_password()**, and sets the user’s password using **set_password()**.

#### Authentication data in templates

The currently logged-in user and their permissions are made available in the template context when you use **RequestContext**.

> **Technicality**
>
> Technically, these variables are only made available in the template context if you use RequestContext and the 'django.contrib.auth.context_processors.auth' context processor is enabled. It is in the default generated settings file. For more, see the RequestContext docs.

**Users**

When rendering a template RequestContext, the currently logged-in user, either a User instance or an AnonymousUser instance, is stored in the template variable {{ user }}:

```
{% if user.is_authenticated %}
    <p>Welcome, {{ user.username }}. Thanks for logging in.</p>
{% else %}
    <p>Welcome, new user. Please log in.</p>
{% endif %}
```

This template context variable is not available if a RequestContext is not being used.

**Permissions**

The currently logged-in user’s permissions are stored in the template variable {{ perms }}. This is an instance of django.contrib.auth.context_processors.PermWrapper, which is a template-friendly proxy of permissions.

In the {{ perms }} object, single-attribute lookup is a proxy to User.has_module_perms. This example would display True if the logged-in user had any permissions in the foo app:

```
{{ perms.foo }}
```

Two-level-attribute lookup is a proxy to User.has_perm. This example would display True if the logged-in user had the permission foo.can_vote:

```
{{ perms.foo.can_vote }}
```

Thus, you can check permissions in template {% if %} statements:

```
{% if perms.foo %}
    <p>You have permission to do something in the foo app.</p>
    {% if perms.foo.can_vote %}
        <p>You can vote!</p>
    {% endif %}
    {% if perms.foo.can_drive %}
        <p>You can drive!</p>
    {% endif %}
{% else %}
    <p>You don't have permission to do anything in the foo app.</p>
{% endif %}
```

It is possible to also look permissions up by {% if in %} statements. For example:

```html
{% if 'foo' in perms %}
    {% if 'foo.can_vote' in perms %}
        <p>In lookup works, too.</p>
    {% endif %}
{% endif %}
```

### 사용자(users)를 관리 화면(admin)에서 다루기

**django.contrib.admin** 과 **django.contrib.auth** 를 모두 설치하면, 관리 화면(admin)에서 사용자, 그룹 및 승인(permissions)을 보고 관리할 수 있는 편리한 방법을 제공합니다. 사용자를 장고의 다른 모델처럼 생성하고 삭제할 수 있습니다. 그룹을 생성할 수 있고, 승인(permissions)을 사용자나 그룹에 할당할 수 있습니다. 사용자가 관리 화면에서 모델을 편집한 기록 또한 저장되고 표시됩니다.

#### 사용자 만들기

메인 관리 화면(admin) 페이지의 “Auth” 섹션에 있는 “Users” 링크에 들어갑니다. “Add user” 관리 페이지를 보면 표준 관리 페이지랑 다른데 여기서 username 과 password 를 결정해야 나중에 사용자의 다른 필드들을 편집할 수 있게 됩니다.

추가 노트: 한 사용자가 장고 관리 화면에서 사용자를 추가할 수 있도록 하려면, 그 사용자에게 사용자를 추가하고 변경할 수 있도록 권한을 부여해야 합니다 (가령, “Add user” 와 “Change user” 권한 등). 만약 한 계정이 사용자를 추가할 수 있는데 변경할 수 없다면, 그 계정은 사용자를 추가할 수 없습니다. 왜일까요? 사용자를 추가할 수 있는 권한을 가지고 있다면, 수퍼 사용자를 생성할 수 있는 힘을 가지고 있는 것인데 수퍼사용자는 말 그대로 다른 사용자들을 변경할 수 있습니다. 그래서 장고는 추가와 변경 권한을 약간의 보안 문제로써 요구합니다.

Be thoughtful about how you allow users to manage permissions. If you give a non-superuser the ability to edit users, this is ultimately the same as giving them superuser status because they will be able to elevate permissions of users including themselves!

#### 비밀번호 바꾸기

User passwords are not displayed in the admin (nor stored in the database), but the password storage details are displayed. Included in the display of this information is a link to a password change form that allows admins to change user passwords.  

### 원문

[Using the Django authentication system](https://docs.djangoproject.com/en/1.10/topics/auth/default/#auth-admin)
