정규 표현식을 실습해 볼 수 있는 곳이 있습니다.[^regex101]  [^regexr]

### 하위 표현식에 이름 붙이기 

파이썬은 하위 표현식에 이름을 붙여두고, 역참조할 때 이 이름을 사용할 수 있는 기능을 제공합니다. 

하위 표현식 시작을 `?P<name>sub-expression`으로 하는데, 이게 하위 표현식에 이름을 붙이는 문법입니다. 하위 표현식에 이름을 붙일 때, 정규 표현식은 대소문자를 구분하므로 반드시 대문자 `P`로 사용해야 합니다.[^egloos]

```
urlpatterns = [
	...
    url(r'^(?P<question_id>\d+)/$', views.detail, name='detail'),
    ...
]

```

위와 같이 파이썬에서 URL을 지정하는 곳에서 많이 사용하는 것을 볼 수 있습니다.

### 참고 자료

[^regex101]: [regex101](https://regex101.com) : 정규 표현식을 테스트해 볼 수 있는 곳입니다.

[^regexr]: [RegExr](http://www.regexr.com) : RegExr is an online tool to learn, build, & test Regular Expressions

[^egloos]: [Python - 정규 표현식](http://egloos.zum.com/sweeper/v/3065126) : 하위 표현식에 이름을 붙이는 방법에 대해서 설명이 잘 나와있습니다.