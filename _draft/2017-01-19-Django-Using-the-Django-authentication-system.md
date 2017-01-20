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
2. 존재한다면 사용자 백엔드(**user.backend**) 속성의 값을 사용합니다. 이것은 **authenticate()** 와 **login()**을 짝을 짓도록 허용합니다: **authenticate()** 는 반환되는 사용자 객체에 **user.backend** 속성을 지정합니다.
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

**The raw way**

The simple, raw way to limit access to pages is to check **request.user.is_authenticated** and either redirect to a login page:

```python
from django.conf import settings
from django.shortcuts import redirect

def my_view(request):
    if not request.user.is_authenticated:
        return redirect('%s?next=%s' % (settings.LOGIN_URL, request.path))
    # ...
```
   
...or display an error message:

```python
from django.shortcuts import render

def my_view(request):
    if not request.user.is_authenticated:
        return render(request, 'myapp/login_error.html')
    # ...
```

**The login_required decorator**

```
login_required(redirect_field_name='next', login_url=None)
```

As a shortcut, you can use the convenient login_required() decorator:

```
from django.contrib.auth.decorators import login_required

@login_required
def my_view(request):
    ...
```
    
login_required() does the following:

* If the user isn’t logged in, redirect to settings.LOGIN_URL, passing the current absolute path in the query string. Example: /accounts/login/?next=/polls/3/.
* If the user is logged in, execute the view normally. The view code is free to assume the user is logged in.

By default, the path that the user should be redirected to upon successful authentication is stored in a query string parameter called "next". If you would prefer to use a different name for this parameter, login_required() takes an optional redirect_field_name parameter:

```
from django.contrib.auth.decorators import login_required

@login_required(redirect_field_name='my_redirect_field')
def my_view(request):
    ...
```
    
Note that if you provide a value to redirect_field_name, you will most likely need to customize your login template as well, since the template context variable which stores the redirect path will use the value of redirect_field_name as its key rather than "next" (the default).

login_required() also takes an optional login_url parameter. Example:

```
from django.contrib.auth.decorators import login_required

@login_required(login_url='/accounts/login/')
def my_view(request):
    ...
```
    
Note that if you don’t specify the login_url parameter, you’ll need to ensure that the settings.LOGIN_URL and your login view are properly associated. For example, using the defaults, add the following lines to your URLconf:

```
from django.contrib.auth import views as auth_views

url(r'^accounts/login/$', auth_views.login),
```

The settings.LOGIN_URL also accepts view function names and named URL patterns. This allows you to freely remap your login view within your URLconf without having to update the setting.

> The login_required decorator does NOT check the is_active flag on a user, but the default AUTHENTICATION_BACKENDS reject inactive users.  

> See also
> 
> If you are writing custom views for Django’s admin (or need the same authorization check that the built-in views use), you may find the django.contrib.admin.views.decorators.staff_member_required() decorator a useful alternative to login_required().

**The LoginRequired mixin**

When using class-based views, you can achieve the same behavior as with login_required by using the LoginRequiredMixin. This mixin should be at the leftmost position in the inheritance list.

class **LoginRequiredMixin**
	
`New in Django 1.9.`

If a view is using this mixin, all requests by non-authenticated users will be redirected to the login page or shown an HTTP 403 Forbidden error, depending on the raise_exception parameter.

You can set any of the parameters of AccessMixin to customize the handling of unauthorized users:

```
from django.contrib.auth.mixins import LoginRequiredMixin

class MyView(LoginRequiredMixin, View):
    login_url = '/login/'
    redirect_field_name = 'redirect_to'
```
    
> Just as the login_required decorator, this mixin does NOT check the is_active flag on a user, but the default AUTHENTICATION_BACKENDS reject inactive users.

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