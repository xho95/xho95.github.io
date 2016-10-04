장고는 Admin 사이트에서 데이터베이스 관리를 할 수 있지만, 추가로 파이썬 쉘을 이용하여 데이터를 관리할 수 있는 API도 제공하고 있습니다. 

아무래도 Admin 사이트 보다는 더 다양한 데이터 관리 명령이 가능하다는 장점이 있습니다. 

보통 간단하거나 일반적인 데이터 관리는 Admin 사이트에서 진행하고, 복잡한 데이터 처리나 현재 웹 서버에 접속해 있는 상태라서 별도로 웹 브라우저로 접속할 필요가 없는 경우 쉘로 데이터를 처리합니다.

### 장고 파이썬 쉘 시작하기

장고 프로젝트의 manage.py 파일이 있는 폴더로 이동한 후, 아래와 같이 명령을 입력하면 장고 파이썬 쉘을 시작할 수 있습니다.

```
$ python manage.py shell
```


### 참고 자료

[NameError: name 'datetime' is not defined](http://stackoverflow.com/questions/19934248/nameerror-name-datetime-is-not-defined) : `import datetime`을 먼저 해줘야 합니다.

[TypeError: 'module' object is not callable](http://stackoverflow.com/questions/8523963/module-object-is-not-callable) : `datetime()`이 아니라 `datetime.datetime()`을 해야할 것입이다.

[django - get() returned more than one topic](http://stackoverflow.com/questions/22063748/django-get-returned-more-than-one-topic) : `get()` 보다는 `filter()`를 사용합니다.