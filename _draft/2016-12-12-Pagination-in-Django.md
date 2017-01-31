Django에서 리스트를 보여줄 때 pagination을 하는 방법을 정리한 글입니다.

#### `page_range`

```
{% for page in objects.paginator.page_range %}
    {% if forloop.counter != 1 %} | {% endif %}
    {{ page }}
{% endfor %}
```

```
1 | 2 | 3 | 4 | 5
```

#### objects number of list

```
{{ forloop.revcounter|add:page_obj.start_index }}
```

위의 코드는 순방향일 때는 좋은데, 역방향일 때는 뭔가 좀 잘 안됩니다. `start_index`를 수정해 보면 어떨까 생각합니다.



### 참고 자료

[Pagination](https://docs.djangoproject.com/en/1.10/topics/pagination/) : Pagination 관련 Django 공식 문서입니다.

[django paginator - how to show all page numbers available](http://stackoverflow.com/questions/19751806/django-paginator-how-to-show-all-page-numbers-available)

[How to Paginate with Django](https://simpleisbetterthancomplex.com/tutorial/2016/08/03/how-to-paginate-with-django.html) : FBS와 CBV 각각에 대해서 Pagination을 하는 방법을 예제 코드로 소개하고 있는 블로그 글입니다.

[Django Row Number in Pagination](http://stackoverflow.com/questions/9939917/django-row-number-in-pagination)

[How to show the correct object numbers when using django-pagination](http://stackoverflow.com/questions/9373532/how-to-show-the-correct-object-numbers-when-using-django-pagination)

[Built-in template tags and filters](https://docs.djangoproject.com/en/1.10/ref/templates/builtins/) : forloop 변수들에 대한 설명이 나옵니다.