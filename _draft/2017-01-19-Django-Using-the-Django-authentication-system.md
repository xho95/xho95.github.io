## 장고(Django)의 인증 시스템 사용하기

이 문서는 장고의 인증 시스템을 사용하는 방법에 대해서 기본 설정을 가지고 설명합니다. 이 설정은 가장 일반적인 프로젝트의 요구 사항을 지원하기 위해 진화했습니다, 합당한 광범위한 일들을 처리하면서, 그리고 암호와 권한 부여에 대해 주의깊게 구현되었습니다. 프로젝트가 기본 설정과는 다른 인증을 요구할 때를 위해 장고는 인증에 대해 광범위한 확장과 사용자화를 지원합니다.

장고 인증은 인증과 권한 부여 기능을 함께 제공하며 보통의 경우 인증 시스템인 것으로 언급됩니다. 이들은 어쨌거나 서로 연결이 되어 있는 특성입니다.

### **User** 객체

**User** 객체는 인증 시스템의 핵심입니다. 사이트과 상호 작용하는 사람들을 나타내는데 제한된 접근을 가능하게 하거나 사용자 정보를 등록하며 작성자와 내용을 연결짓는 등의 기능을 담당합니다. 단 하나의 user 클래스만 장고 인증 프레임웍에 존재합니다. 가령, **superusers** 나 관리자 **staff** 사용자들은 그냥 특별한 속성 집합을 가지는 user 객체들로 , user 객체와 다를 바가 없습니다.

기본 사용자(user)는 다음과 같은 주요 특성들을 가집니다:

* **username**
* **password**
* **email**
* **first_name**
* **last_name**

전체 내용은 **full API documentation** 를 보십시오, 이어지는 문서는 좀 더 업무에 기반(task oriented)한 내용을 다룹니다.

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

장고 관리자(Django admin)를 설치했으면, 사용자를 대화형으로 생성할 수 있습니다.

#### 수퍼사용자(superusers) 만들기

수퍼사용자는 **createsuperuser** 명령을 사용해서 만듭니다:

```
$ python manage.py createsuperuser --username=joe --email=joe@example.com
```

비밀번호를 입력하라는 프롬프터가 뜹니다. 입력하고 나면, 즉시 수퍼상요자가 생깁니다. **--username** 이나 **--email** 옵션 없이 실행하면, 이 값들을 입력하라는 프롬프터가 뜹니다.

#### 비밀번호 변경하기

장고는 사용자 모델의 원(순수 텍스트) 비밀번호를 저장하지 않으며, 단지 해쉬 (자세한 사항은 documentation of how passwords are managed 문서를 보십시오) 만 저장합니다. 따라서 사용자가 직접 비밀번호 속성을 변경할 수 없습니다. 이것이 사용자를 만들 때 헬퍼 함수를 사용하는 이유입니다.

비밀번호를 변경하는 데는 여러 옵션이 있습니다:

**manage.py changepassword *username*** 는 명령줄에서 사용자 비밀번호를 변경하는 방법을 제공합니다. 이것은 주어진 사용자의 비밀번호를 바꾸기 위해 프롬프터로 두 번 입력해야 합니다. 그 두 개가 맞으면, 새 비밀번호로 즉시 바뀝니다. 만약 사용자를 제공하지 않으면(?), 명령은 username 과 맞는 현재 시스템의 사용자의 비밀번호를 바꾸려고 시도합니다.

비밀번호는 프로그램에서도 수정할 수 있습니다.**set_password()** 를 사용하십시오:

```
>>> from django.contrib.auth.models import User
>>> u = User.objects.get(username='john')
>>> u.set_password('new password')
>>> u.save()
```

장고 관리자(Django admin)를 설치했으면, 사용자 비밀번호를 인증 시스템의 관리자 페이지에서 변경할 수도 있습니다.

장고는 뷰(views) 와 폼(forms)을 통해서도 사용자가 자신의 비밀번호를 수정할 수 있도록 허용합니다.

사용자의 비밀번호를 변경하면 모든 세션에서 빠져 나옵니다(log out). 자세한 사항은 Session invalidation on password change 를 보십시오.

#### 사용자 인증하기

```
authenticate(**credentials)
```

자격 요건을 입증하려면 **authenticate()** 를 사용합니다. 자격 입증에는 키워드 인자가 필요한데, 기본은 **username** 과 **password** 를 사용합니다, 각 인증 백엔드(authentication backend)에 대해 체크해서, 자격 요건이 백엔드에서 입증되면 **User** 객체를 반환합니다. 자격이 어떤 백엔드에서도 유효하지 않거나 백엔가 **PermissionDenied** 예외를 발생하면, **None** 을 반환합니다. 예를 들면 다음과 같습니다:

```
from django.contrib.auth import authenticate
user = authenticate(username='john', password='secret')
if user is not None:
    # A backend authenticated the credentials
else:
    # No backend authenticated the credentials
```

> 이 방밥은 자격 조건으로 인증하는 낮은 단계의 방법입니다; 예를 들어, **RemoteUserMiddleware** 에서 사용됩니다. 스스로의 인증 시스템을 작성하지 않으면, 아마도 이것을 사용하지 않을 것입니다. 만약 로그인한 사용자에 대해 제한된 접근을 하는 방법을 찾고 있다면 이 보다는  **login_required()** 데코레이터를 보도록 하십시오.
 
### 승인(Permissions) 및 권한 부여(Authorization)

장고는 Django comes with a simple permissions system. It provides a way to assign permissions to specific users and groups of users.

It’s used by the Django admin site, but you’re welcome to use it in your own code.

The Django admin site uses permissions as follows:

Access to view the “add” form and add an object is limited to users with the “add” permission for that type of object.
Access to view the change list, view the “change” form and change an object is limited to users with the “change” permission for that type of object.
Access to delete an object is limited to users with the “delete” permission for that type of object.
Permissions can be set not only per type of object, but also per specific object instance. By using the has_add_permission(), has_change_permission() and has_delete_permission() methods provided by the ModelAdmin class, it is possible to customize permissions for different object instances of the same type.

User objects have two many-to-many fields: groups and user_permissions. User objects can access their related objects in the same way as any other Django model:

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

When django.contrib.auth is listed in your INSTALLED_APPS setting, it will ensure that three default permissions – add, change and delete – are created for each Django model defined in one of your installed applications.

These permissions will be created when you run manage.py migrate; the first time you run migrate after adding django.contrib.auth to INSTALLED_APPS, the default permissions will be created for all previously-installed models, as well as for any new models being installed at that time. Afterward, it will create default permissions for new models each time you run manage.py migrate (the function that creates permissions is connected to the post_migrate signal).

Assuming you have an application with an app_label foo and a model named Bar, to test for basic permissions you should use:

* add: user.has_perm('foo.add_bar')
* change: user.has_perm('foo.change_bar')
* delete: user.has_perm('foo.delete_bar')

The Permission model is rarely accessed directly.

#### Groups

django.contrib.auth.models.Group models are a generic way of categorizing users so you can apply permissions, or some other label, to those users. A user can belong to any number of groups.

A user in a group automatically has the permissions granted to that group. For example, if the group Site editors has the permission can_edit_home_page, any user in that group will have that permission.

Beyond permissions, groups are a convenient way to categorize users to give them some label, or extended functionality. For example, you could create a group 'Special users', and you could write code that could, say, give them access to a members-only portion of your site, or send them members-only email messages.

#### Programmatically creating permissions

While custom permissions can be defined within a model’s Meta class, you can also create permissions directly. For example, you can create the can_publish permission for a BlogPost model in myapp:

```
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

The permission can then be assigned to a User via its user_permissions attribute or to a Group via its permissions attribute.

#### Permission caching

The ModelBackend caches permissions on the user object after the first time they need to be fetched for a permissions check. This is typically fine for the request-response cycle since permissions aren’t typically checked immediately after they are added (in the admin, for example). If you are adding permissions and checking them immediately afterward, in a test or view for example, the easiest solution is to re-fetch the user from the database. For example:

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

Django uses sessions and middleware to hook the authentication system into request objects.

These provide a request.user attribute on every request which represents the current user. If the current user has not logged in, this attribute will be set to an instance of AnonymousUser, otherwise it will be an instance of User.

You can tell them apart with is_authenticated, like so:

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

You should see a link to “Users” in the “Auth” section of the main admin index page. The “Add user” admin page is different than standard admin pages in that it requires you to choose a username and password before allowing you to edit the rest of the user’s fields.

Also note: if you want a user account to be able to create users using the Django admin site, you’ll need to give them permission to add users and change users (i.e., the “Add user” and “Change user” permissions). If an account has permission to add users but not to change them, that account won’t be able to add users. Why? Because if you have permission to add users, you have the power to create superusers, which can then, in turn, change other users. So Django requires add and change permissions as a slight security measure.

Be thoughtful about how you allow users to manage permissions. If you give a non-superuser the ability to edit users, this is ultimately the same as giving them superuser status because they will be able to elevate permissions of users including themselves!

#### 비밀번호 바꾸기

User passwords are not displayed in the admin (nor stored in the database), but the password storage details are displayed. Included in the display of this information is a link to a password change form that allows admins to change user passwords.  