### Decorator

Python에서 decorator는 하나의 wrapper이며, 이것은 특정 코드를 원하는 함수 호출 이전이나 이후에 실행할 때, 원래의 함수에는 어떠한 변경도 필요없음을 의미합니다. **- 문장을 좀 더 다듬을 필요가 있습니다.**

원문은 [How to make a chain of function decorators in Python?](http://stackoverflow.com/questions/739654/how-to-make-a-chain-of-function-decorators-in-python) 글의 답글에 있으며, 다음과 같습니다. (decorators are “wrappers”, which means that they let you execute code before and after the function they decorate without modifying the function itself.) [^stackoverflow-739654]

#### 느낌

일단 python의 decorator는 design pattern의 decorator 패턴을 함수에 적용한 듯한 느낌이 듭니다. 함수에 바로 적용할 수 있는 것은 python 역시 큰 범주에서는 함수형 언어라서 함수를 객체처럼 다룰 수 있기 때문이고, 그래서 객체에 적용되는 패턴을 함수에도 적용할 수 있게 되는 것 같습니다. 

어쨌든 decorator는 원래의 함수를 변경하지 않고, 확장할 수 있게 만들어 주는 도구입니다. 이를 통해서 라이브러리에 존재하는 수정할 수 없는 함수들도 확장할 수 있게 됩니다. 

#### `get\_absolute\_url()` 과 `@permalink`

[What is @permalink and get\_absolute\_url in Django?](http://stackoverflow.com/questions/13503645/what-is-permalink-and-get-absolute-url-in-django) 글을 참고하면 이제 `@permalink` decorator는 사용하지 않는 모양입니다. [^stackoverflow-13503645] 구 시대의 유물로 보면 될 것 같습니다. 


### 참고 자료

[Kevin Stone](http://blog.kevinastone.com/#) : 엄청난 내공을 가진 분의 블로그입니다. Python design pattern에 대한 내용이 많은 것 같습니다. 언젠가 따로 정리해야 할 것 같습니다.

[^stackoverflow-13503645]: [What is @permalink and get_absolute_url in Django?](http://stackoverflow.com/questions/13503645/what-is-permalink-and-get-absolute-url-in-django)

[^stackoverflow-739654]: [How to make a chain of function decorators in Python?](http://stackoverflow.com/questions/739654/how-to-make-a-chain-of-function-decorators-in-python) : Python’s functions are objects, 이 글의 답글중에 e-satis님의 답글이 큰 도움이 되는 것 같습니다.

[get\_absolute\_url()](https://docs.djangoproject.com/en/dev/ref/models/instances/?from=olddocs#get-absolute-url) : `@permalink` 와 관련이 있는 것 같습니다. 언젠가 내용을 정리할 날이 올 것 같습니다. 이제 `@permalink` decorator는 없어졌기 때문인지 따로 설명이 없는 것 같습니다.

[Naming URL patterns](https://docs.djangoproject.com/en/dev/topics/http/urls/#naming-url-patterns)