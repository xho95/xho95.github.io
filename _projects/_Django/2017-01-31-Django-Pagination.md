## 페이지 나누기(Pagination)

장고는 데이터를 페이지로 나누어 볼 수 있게 하는 몇가지 클래스들을 제공합니다 – 페이지를 나눈다는 것은 데이터가 여러 페이지에 걸쳐 쪼개져서 “이전/다음” 링크를 통해 이동하는 것을 말합니다. 장고에서 제공하는 클래스는 **django/core/paginator.py** 파일에 있습니다.

### 예제

**Paginator** 에 객체의 리스트를 주고 한 페이지에 몇 개의 아이템을 보여주고 싶은지를 알려주면, 각페이지의 아이템들에 접근하는 방법을 알려 줍니다:

```django
>>> from django.core.paginator import Paginator
>>> objects = ['john', 'paul', 'george', 'ringo']
>>> p = Paginator(objects, 2)

>>> p.count
4
>>> p.num_pages
2
>>> type(p.page_range)  # 파이썬 2에서는 `<type 'rangeiterator'>` 입니다.
<class 'range_iterator'>	# 저는 <class 'range'> 라고 뜹니다.
>>> p.page_range
range(1, 3)

>>> page1 = p.page(1)
>>> page1
<Page 1 of 2>
>>> page1.object_list
['john', 'paul']

>>> page2 = p.page(2)
>>> page2.object_list
['george', 'ringo']
>>> page2.has_next()
False
>>> page2.has_previous()
True
>>> page2.has_other_pages()
True
>>> page2.next_page_number()
Traceback (most recent call last):
...
EmptyPage: That page contains no results
>>> page2.previous_page_number()
1
>>> page2.start_index() # 이 페이지의 첫 아이템의 인덱스 값으로 1부터 시작하는 인덱스 값
3
>>> page2.end_index() # 이 페이지의 마지막 아이템의 인덱스 값으로 1부터 시작하는 인덱스 값
4

>>> p.page(0)
Traceback (most recent call last):
...
EmptyPage: That page number is less than 1
>>> p.page(3)
Traceback (most recent call last):
...
EmptyPage: That page contains no results
```

> **Paginator** 에는 리스트/튜플, 장고의 **QuerySet**, 또는 `count()` 나 `__len__()` 메소드가 있는 다른 객체를 전달할 수 있습니다. 전달된 객체에 담겨있는 아이템의 수를 결정할 때, **Paginator** 는 먼저 `count()`를 호출하는데, 전달된 객체에 `count()` 메소드가 없으면 대안으로 `len()` 을 호출합니다. 이러한 방법은 장고의 **QuerySet** 같은 객체가 더 효율적인 `count()` 메소드를 사용할 수 있도록 합니다.

### 뷰에서 Paginator 사용하기

여기서는 쿼리집합(queryset)의 페이지 나누기위해 뷰에서 **Paginator** 를 사용하는 조금 더 복잡한 예제를 다룹니다. 뷰와 템플릿을 같이 나타냈는데 이를 통해 결과를 어떻게 표현할 수 있는지 알 수 있습니다. 아래의 예제에서는 이미 **Contacts** 모델을 이미 포함하고 있다고 가정합니다.

뷰 함수는 다음과 같습니다:

```django
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.shortcuts import render

def listing(request):
    contact_list = Contacts.objects.all()
    paginator = Paginator(contact_list, 25) # 페이지당 25 개의 연락처를 보여줌

    page = request.GET.get('page')
    try:
        contacts = paginator.page(page)
    except PageNotAnInteger:
        # 페이지가 숫자가 아니면, 첫 페이지로 이동
        contacts = paginator.page(1)
    except EmptyPage:
        # 페이지가 (9999 같이) 범위를 벗어나면, 결과의 마지막 페이지로 이동
        contacts = paginator.page(paginator.num_pages)

    return render(request, 'list.html', {'contacts': contacts})
```

**list.html** 템플릿에서는, 객체 자체의 흥미로운 정보를 따라서 페이지들 사이를 이동하는 기능(navigation)을 넣고 싶을 것입니다:

```html
{% for contact in contacts %}
    {# 각각의 "contact" 은 Contact 모델 객체입니다. #}
    {{ contact.full_name|upper }}<br />
    ...
{% endfor %}

<div class="pagination">
    <span class="step-links">
        {% if contacts.has_previous %}
            <a href="?page={{ contacts.previous_page_number }}">previous</a>
        {% endif %}

        <span class="current">
            Page {{ contacts.number }} of {{ contacts.paginator.num_pages }}.
        </span>

        {% if contacts.has_next %}
            <a href="?page={{ contacts.next_page_number }}">next</a>
        {% endif %}
    </span>
</div>
```

### Paginator 객체

**Paginator** 클래스는 다음의 생성자를 가지고 있습니다:

* class **Paginator(** *object\_list, per\_page, orphans=0, allow\_empty\_first\_page=True* **)**

#### 필수 인자

* **`object_list`**

리스트, 튜플, **QuerySet**, 또는 `count()` 나 `__len__()` 메소드를 가지고 있어서 나뉠 수 있는 다른 객체. 페이지 분할(pagination)의 일관성을 위해, **QuerySets** 은 정렬되어있어야 합니다. 예를 들어 `order_by()` 구절이나 모델의 기본 **ordering** 을 이용합니다.

> **큰 쿼리집합의 페이지 분할 성능 이슈**
> 
> 매우 많은 아이템에 대해 **QuerySet** 을 사용하면, 일부 데이터베이스에서 큰 페이지 번호를 요청할 때 느려질 수 있습니다, 왜냐면 **LIMIT/OFFSET** 쿼리의 결과를 내기 위해서는 **OFFSET** 레코드의 수를 헤아려야 하는데 페이지 번호가 커지면 더 많은 시간이 필요하기 때문입니다.

* **`per_page`**

	한 페이지에 담을 아이템의 최대 개수, 이 때 **orphans** 는 포함하지 않습니다. (**orphans** 선택 인자에 대해서는 아래를 참고하시기 바랍니다).

#### 선택 인자

* **`orphans`**

	마지막 페이지에 허용할 최소 아이템 개수로 기본 값은 0 입니다. 마지막 페이지에 너무 작은 아이템이 놓이는 것을 막을 때 사용합니다. 마지막 페이지의 아이템 수가 **orphans** 과 같거나 더 적으면, 이 아이템들은 별도 페이지가 되지 않고 이전 페이지에 붙여집니다. (이제 마지막 페이지로 바뀝니다). 예를 들어 23개의 아이템이 있고, `per_page=10`, `orphans=3` 이면, 총 2 페이지가 생깁니다; 첫번째 페이지는 10 개의 아이템을 갖고 두번째 (이자 마지막) 페이지는 13 개의 아이템을 가집니다

* **`allow_empty_first_page`**

	첫번째 페이지를 비울 수 있게 할지의 여부. 이 값이 **False** 이고 `object_list` 가 비어있으면, **EmptyPage** 에러가 발생합니다.

#### 메소드

* **Paginator.page(** *number* **)**

	1부터 시작하는 인덱스를 가지는 **Page** 객체를 반환합니다. 주어진 페이지 번호가 없으면 **InvalidPage** 예외를 발생합니다.

#### 속성

* **Paginator.count**

	모든 페이지에 걸쳐있는 전체 객체 수.

> `object_list` 에 있는 객체 수를 결정할 때, **Paginator** 는 먼저 `object_list.count()` 를 호출합니다. `object_list` 가 `count()` 메소드를 가지고 있지 않으면, **Paginator** 는 대안으로`len(object_list)` 를 사용합니다. 이 방법은 장고의 **QuerySet** 같은 객체에서 가능하면 더 효율적인 `count()` 메소드를 사용할 수 있게 합니다.

* **`Paginator.num_pages`**

	전체 페이지 수.

* **`Paginator.page_range`**
	
	페이지 번호에 사용되는 1부터 시작하는 범위 반복자. **[1, 2, 3, 4]** 등을 산출한다.

> **장고 1.9 에서 변한 것**:
> 
> 예전 버전에서는, `page_range` 는 반복자 대신에 리스트를 반환했습니다.

### InvalidPage 예외

* exception **InvalidPage**

	paginator에 잘못된 페이지 번호가 전달 될 때 발생하는 예외에 대한 기본 클래스입니다.

`Paginator.page()` 메소드는 요청받은 페이지가 (숫자가 아닌 등) 잘못됐거나 객체를 가지고 있지 않을 때 예외를 발생합니다. 일반적으로 **InvalidPage** 예외를 잡는 것(catch)으로 충분하지만 보다 세밀한 부분을 원한다면 다음 예외 중 하나를 잡을 수 있습니다.:

* exception **PageNotAnInteger**
	
	`page()` 에 정수가 아닌 값이 주어질 때 발생합니다.

* exception **EmptyPage**

	`page()` 에 유효한 값이 지정되었지만 해당 페이지에 객체가 없을 때 발생합니다.

위의 두 예외는 모두 **InvalidPage** 의 하위 클래스이므로, 간단하게 **except InvalidPage** 를 사용해서 처리할 수 있습니다.

### Page objects

보통 **Page** 객체는 직접 생성하지 않고 – `Paginator.page()` 를 사용해서 생성합니다.

* class **Page(** *object_list, number, paginator* **)**

	페이지는 `len ()`을 사용하거나 직접 반복 할 때 **Page.object\_list** 시퀀스처럼 작동합니다.

#### 메소드

* **`Page.has_next()`**

	다음 페이지가 있으면 **True** 를 반환합니다.

* **`Page.has_previous()`**

	이전 페이지가 있으면 **True** 를 반환합니다.

* **`Page.has_other_pages()`**

	다음이나 이전 페이지가 있으면 **True** 를 반환합니다.

* **`Page.next_page_number()`**

	다음 페이지 번호를 반환합니다. 없으면 **InvalidPage** 를 발생합니다.

* **`Page.previous_page_number()`**

	이전 페이지 번호를 반환합니다. 없으면 **InvalidPage** 를 발생합니다.

* **`Page.start_index()`**

	페이지에서 첫번째 객체의 인덱스를 반환하는데 1부터 시작하는 인덱스이고 페이지 관리자의 목록에 있는 전체 객체들을 기준으로 하는 값입니다. 예를 들어, 5개의 객체로 된 목록을 페이지 나누기 하면서 페이지 당 2개의 객체를 둔다고 하면, 두번째 페이지의 **start_index()** 는 **3** 을 반환합니다.

* **`Page.end_index()`**

	페이지에서 마지막 객체의 인덱스를 반환하는데 1부터 시작하는 인덱스이고 페이지 관리자의 목록에 있는 전체 객체들을 기준으로 하는 값입니다. 예를 들어, 5개의 객체로 된 목록을 페이지 나누기 하면서 페이지 당 2개의 객체를 둔다고 하면, 두번째 페이지의 **end_index()** 는 **4** 을 반환합니다.

#### 속성

* **`Page.object_list`**

	이 페이지에 있는 객체들의 목록.

* **`Page.number`**

	이 페이지 번호로 1부터 시작하는 번호.

* **`Page.paginator`**

	관련 **Paginator** 객체.

### 원문 자료

[Pagination](https://docs.djangoproject.com/en/1.10/topics/pagination/) : 장고 공식 문서의 Pagination 자료입니다.

### 참고 자료

[Django Packages: Pagination](https://djangopackages.org/grids/g/pagination/)