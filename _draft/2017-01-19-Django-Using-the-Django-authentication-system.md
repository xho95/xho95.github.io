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

```
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

```
$ python manage.py createsuperuser --username=joe --email=joe@example.com
```

바로 비밀번호를 입력하라고 나타납니다. 입력하고 나면 곧바로 운영자가 생깁니다. **--username** 이나 **--email** 옵션 없이 실행하면, 이 값들을 입력하라고 바로 나타납니다.

#### 비밀번호 변경하기

장고는 사용자 모델의 원래(순수 텍스트) 비밀번호를 저장하지 않으며, 단지 해쉬 (자세한 사항은 [documentation of how passwords are managed](https://docs.djangoproject.com/en/1.10/topics/auth/passwords/) 문서를 보십시오) 만 저장합니다. 따라서 사용자가 직접 비밀번호 속성을 변경할 수 없습니다. 사용자를 만들 때 헬퍼 함수를 사용하는 이유가 이 때문입니다.

비밀번호를 변경하는 데는 여러 옵션이 있습니다:

**manage.py changepassword *username*** 는 명령줄에서 사용자 비밀번호를 변경하는 방법을 제공합니다. 이것은 주어진 사용자의 비밀번호를 바꾸기 위해 즉시 두 번의 입력을 요구합니다. 그 두 개가 맞으면, 곧바로 새 비밀번호로 바뀝니다. 만약 사용자를 제공하지 않으면, 현재 시스템의 사용자와 이름이 같은 사용자의 비밀번호를 바꾸게 됩니다.

비밀번호는 **set_password()** 를 사용하면 프로그램 내에서도 수정할 수 있습니다:

```
>>> from django.contrib.auth.models import User
>>> u = User.objects.get(username='john')
>>> u.set_password('new password')
>>> u.save()
```

장고 관리자 화면(admin)을 설치했으면, 사용자 비밀번호를 인증 시스템의 관리자 페이지에서 변경할 수도 있습니다.

또한 장고는 뷰([views](https://docs.djangoproject.com/en/1.10/topics/auth/default/#built-in-auth-views)) 와 폼([forms](https://docs.djangoproject.com/en/1.10/topics/auth/default/#built-in-auth-forms))을 통해서도 사용자가 자신의 비밀번호를 수정할 수 있도록 허용합니다.

사용자의 비밀번호를 변경하면 모든 세션에서 빠져 나옵니다(log out). 자세한 사항은 [Session invalidation on password change](https://docs.djangoproject.com/en/1.10/topics/auth/default/#session-invalidation-on-password-change) 를 보십시오.

#### 사용자 인증하기

```
authenticate(**credentials)
```

자격(credentials)이 유효한지(verify) 검사하려면 **authenticate()** 를 사용합니다. 이 함수는 자격을 키워드 인자로 받아 들이는데, 기본은 **username** 과 **password** 를 사용합니다. 그리고  각각의 인증 백엔드(authentication backend)와 맞춰 봐서, 자격이 백엔드에서 유효하면 **User** 객체를 반환합니다. 자격이 어떤 백엔드에서도 유효하지 않거나 백엔드가 **PermissionDenied** 예외를 발생하면, **None** 을 반환합니다. 예를 들면 다음과 같습니다:

```
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

승인은 객체 타입별로 적용할 수 있을 뿐만 아니라 개별 객체 인스턴스에 대해서도 적용가능합니다. **ModelAdmin** 클래스에서 제공하는 **has\_add_permission()**, **has\_change_permission()** 그리고 **has\_delete_permission()** 메소드를 사용하면, 같은 타입의 서로 다른 객체 인스턴스를 위해 인증을 사용자화할 수 있습니다.

**User** 객체는 두 개의 다-대-다(many-to-many) 관계 필드를 가지고 있습니다: **groups** 과 **user_permissions** 이 그들입니다. **User** 객체가 관계를 맺은 객체에 접근하는 방법은 다른 [Django model](https://docs.djangoproject.com/en/1.10/topics/db/models/) 과 동일합니다:

```
myuser.groups.set([group_list])
myuser.groups.add(group, group, ...)
myuser.groups.remove(group, group, ...)
myuser.groups.clear()
myuser.user_permissions.set([permission_list])
myuser.user_permissions.add(permission, permission, ...)
myuser.user_permissions.remove(permission, permission, ...)
myuser.user_permissions.clear()
```

#### 기본 인증(permissions)

**INSTALLED_APPS** 설정에 **django.contrib.auth** 이 있으면, 그것은 세 개의 기본 인증 - 추가, 변경, 삭제 - 을 각각의 장고 모델에 생성하는 것을 보장합니다. 이 장고 모델들은 설치한 앱들 중의 하나에 정의되어 있습니다(?)

세 개의 인증은 **manage.py migrate** 을 실행할 때 생성합니다; **django.contrib.auth** 를 **INSTALLED_APPS** 에 추가하고 처음으로  **migrate** 명령을 실행하면, 기본 인증은 미리-설치된 모든 모델들뿐만 아니라, 그 시점에 설치되는 새로운 모든 모델들을 위해서도 생성됩니다. 이후로는, **manage.py migrate** 명령을 실행할 때마다 새 모델들을 위한 기본 인증을 생성합니다. (인증을 생성하는 함수는 **post_migrate** 신호와 연결되어 있습니다).

**app_label** 의 **foo** 라는 어플리케이션과 이름이 **Bar** 인 모델이 있다고 가정합시다, 기본 인증을 실험하려면 아래와 같이 하면 됩니다:

* 추가: **user.has\_perm('foo.add_bar')**
* 변경: **user.has\_perm('foo.change_bar')**
* 삭제: **user.has\_perm('foo.delete_bar')**

인증 모델은 직접 접근할 일이 거의 없습니다.

#### 그룹(Groups)

**django.contrib.auth.models.Group** 모델은 사용자를 분류하는(categorizing) 제네릭한(generic) 방법이라서 해당 사용자들에게 인증을 적용하거나 다른 이름표를 붙이거나 할 수 있습니다. 한 명의 사용자는 다수의 그룹에 속할 수 있습니다.

그룹에 있는 사용자는 그룹에 부여된 인증을 자동으로 갖습니다. 예를 들어, 만약 **Site editors** 그룹이 **can\_edit\_home_page** 에 대해 인증을 가지고 있으면, 이 그룹에 속한 어떤 사용자라도 해당 인증을 가지게 됩니다.

인증을 넘어서 그룹은 사용자들을 분류하는 편리한 방법을 제공하는데, 특정한 이름표를 부여하거나 확장된 기능들을 제공하는 것들이 있습니다. 예를 들면, **'Special users'** 라는 그룹을 만들고, 코드를 작성해서, 이 그룹이 멤버들만 접근 가능한 영역에 접근하게 하거나, 멤버에게만 보내는 메일을 보내주거나 할 수 있습니다.

#### 프로그램으로 인증 만들기

[custom permissions](https://docs.djangoproject.com/en/1.10/topics/auth/customizing/#custom-permissions) (사용자화한 인증)은 모델의 **Meta** 클래스안에서 정의하는 것이지만, 직접 인증을 생성할 수도 있습니다. 예를 들어, **can_publish** 인증을 **myapp** 에 있는 **BlogPost** 모델에 만들 수 있습니다:

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

The permission can then be assigned to a **User** via its **user_permissions** attribute or to a **Group** via its **permissions** attribute.

#### Permission caching

The **ModelBackend** caches permissions on the user object after the first time they need to be fetched for a permissions check. This is typically fine for the request-response cycle since permissions aren’t typically checked immediately after they are added (in the admin, for example). If you are adding permissions and checking them immediately afterward, in a test or view for example, the easiest solution is to re-fetch the user from the database. For example:

```
from django.contrib.auth.models import Permission, User
from django.shortcuts import get_object_or_404

def user_gains_perms(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    # any permission check will cache the current set of permissions
    user.has_perm('myapp.change_bar')

    permission = Permission.objects.get(codename='change_bar')
    user.user_permissions.add(permission)

    # Checking the cached permission set
    user.has_perm('myapp.change_bar')  # False

    # Request new instance of User
    # Be aware that user.refresh_from_db() won't clear the cache.
    user = get_object_or_404(User, pk=user_id)

    # Permission cache is repopulated from the database
    user.has_perm('myapp.change_bar')  # True

    ...
```

### Authentication in Web requests

Django uses [sessions](https://docs.djangoproject.com/en/1.10/topics/http/sessions/) and middleware to hook the authentication system into **request objects**.

These provide a **request.user** attribute on every request which represents the current user. If the current user has not logged in, this attribute will be set to an instance of **AnonymousUser**, otherwise it will be an instance of **User**.

You can tell them apart with **is_authenticated**, like so:

```
if request.user.is_authenticated:
    # Do something for authenticated users.
    ...
else:
    # Do something for anonymous users.
    ...
```

### 사용자(users)를 관리 화면(admin)에서 다루기

**django.contrib.admin** 과 **django.contrib.auth** 를 모두 설치하면, 관리 화면(admin)에서 사용자, 그룹 및 권한(permissions)을 보고 관리할 수 있는 편리한 방법을 제공합니다. 사용자를 장고의 다른 모델처럼 생성하고 삭제할 수 있습니다. 그룹을 생성할 수 있고, 권한(permissions)을 사용자나 그룹에 할당할 수 있습니다. 사용자가 관리 화면에서 모델을 편집한 기록 또한 저장되고 표시됩니다.

#### 사용자 만들기

메인 관리 화면(admin) 페이지의 “Auth” 섹션에 있는 “Users” 링크에 들어갑니다. “Add user” 관리 페이지를 보면 표준 관리 페이지랑 다른데 여기서 username 과 password 를 결정해야 나중에 사용자의 다른 필드들을 편집할 수 있게 됩니다.

추가 노트: 한 사용자가 장고 관리 화면에서 사용자를 추가할 수 있도록 하려면, 그 사용자에게 사용자를 추가하고 변경할 수 있도록 권한을 부여해야 합니다 (가령, “Add user” 와 “Change user” 권한 등). 만약 한 계정이 사용자를 추가할 수 있는데 변경할 수 없다면, 그 계정은 사용자를 추가할 수 없습니다. 왜일까요? 사용자를 추가할 수 있는 권한을 가지고 있다면, 수퍼 사용자를 생성할 수 있는 힘을 가지고 있는 것인데 수퍼사용자는 말 그대로 다른 사용자들을 변경할 수 있습니다. 그래서 장고는 추가와 변경 권한을 약간의 보안 문제로써 요구합니다.

Be thoughtful about how you allow users to manage permissions. If you give a non-superuser the ability to edit users, this is ultimately the same as giving them superuser status because they will be able to elevate permissions of users including themselves!

#### 비밀번호 바꾸기

User passwords are not displayed in the admin (nor stored in the database), but the password storage details are displayed. Included in the display of this information is a link to a password change form that allows admins to change user passwords.  

### 원문

[Using the Django authentication system](https://docs.djangoproject.com/en/1.10/topics/auth/default/#auth-admin)