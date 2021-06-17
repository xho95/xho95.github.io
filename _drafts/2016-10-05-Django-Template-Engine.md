일단 템플릿 언어라고 하면 마치 HTML 처럼 여러 시스템에서 공통으로 사용되는 것 같습니다. 웹브라우저마다 같은 HTML 코드를 제각각 해석해서 보여주듯이, 하나의 템플릿 코드도 템플릿 엔진마다 조금씩 고유한 방법으로 해석해 주는 것 같습니다. 

일단 템플릿 언어라면 웹에서 반복되는 작업을 줄여주기 위해서 나온게 아닌가라는 추측을 하고 있습니다. 이부분은 나중에 좀 더 공부해서 정리하도록 하겠습니다.

템플릿 언어 또는 이 템플릿 언어를 해석하는 템플릿 엔진에는 Liquid, Jinja2 등 다양한 것들이 있습니다.[^Liquid]  [^Jinja2]  [^wikipedia] 하지만, 제각각 각자의 템플릿 언어나 엔진을 강조하는 것은 아직 구체적인 표준안이 없기 때문이 아닐까 추측하고 있습니다.

### 장고(Django)에서의 템플릿 코드

장고에서의 템플릿 코드는 파이썬 프로그래밍 언어의 문법과는 다른 것이며, 장고 템플릿 시스템-템플릿 엔진-에서만 사용되는 고유한 문법입니다. 장고의 템플릿 엔진은 템플릿 문법으로 작성된 템플릿 코드를 해석하여 템플릿 파일로 결과물을 만들어 줍니다.[^hanbit_book_1] 

> 템플릿 시스템이라는 용어는 결국 템플릿 엔진을 말하는 것 같습니다. 따라서 이후로는 장고 템플릿 엔진이라는 용어를 사용하도록 하겠습니다.

템플릿에서는 로직을 표현하는 것이 아니라 사용자에게 어떻게 보여줄지에 대한 룩앤필을 표현합니다. 따라서, 템플릿 코딩은 프로그래밍이라기 보다는 화면 구현이라고 하는 것이 더 적절한 표현입니다. 

템플릿 코드를 템플릿 파일로 해석하는 과정을 장고에서는 렌더링이라고 합니다. 결과물인 템플릿 파일은 HTML, XML, CSV 등의 단순한 텍스트 파일입니다. 

여기서는 장고의 템플릿 엔진에서 사용하는 고유한 템플릿 문법을 알아봅니다.[^docs_templates] 나중에 Jekyll에서 사용하는 템플릿 언어인 Liquid와는 어떻게 다른지 비교하는 것도 의미가 있을 것 같습니다.[^Shopify_liquid]

### 템플릿 변수
 
템플릿 변수는 아래와 같은 방식으로 정의합니다.

```
{{ variable }}
```

장고 템플릿 엔진은 변수를 평가해서 변수값으로 변경해줍니다.

템플릿 문법에서 닷(`.`)을 만나면 장고는 아래와 같은 방법으로 살펴보기(LookUp)을 시도합니다. 예를 들어 `{{ foo.bar }}` 라는 코드가 있다고 합니다.

* `foo`가 딕셔너리(Dictionary) 타입인지를 검사합니다. 딕셔너리이면 `foo['bar']`로 해석합니다.
* 다음은 `foo`를 객체로 보고 속성(attribute)를 찾습니다. `bar`라는 속성이 있으면 `foo.bar`로 해석합니다.
* 마지막으로 `foo`가 리스트(List)인지 확인합니다. 그렇다면 `foo[bar]`로 해석합니다.

템플릿 엔진은 정의가 되어 있지 않은 변수를 사용하는 경우 디폴트로는 빈문자열(`''`)로 채워주며, 이 값은 **settings.py**에서 다르게 지정할 수 있습니다. 

```
TEMPLATE_STRING_IF_INVALID
```

다만, 위의 코드도 장고 1.7 이전 기준일 것 같고, 1.8 이후 버전에서는 어떻게 변경됐는지 알아볼 필요가 있습니다.

### 템플릿 필터

장고의 템플릿 문법에서도 템플릿 변수에 필터를 적용하여 변수의 출력 결과를 바꿀 수 있습니다. 필터는 아래처럼 파이프(`|`) 문자를 사용합니다. 

```
{{ name|lower }}
```

위의 코드는 `name` 변수의 모든 문자를 소문자로 바꿔주는 필터입니다.

#### filter chaining

필터는 체인으로 연결할 수도 있습니다. 

```
{{ text|escape|linebreaks }}
```

위의 코드는 text 변수값 중에서 특수 문자를 escape해주고, 줄바꿈(?)의 기능을 위해 결과 문자열에 HTML `<p>` 태그를 붙여줍니다.

#### filter argument

몇가지 필터는 인자를 가질 수 있습니다. 인자는 필터 뒤에  콜론(`:`)으로 구분하는 것 같습니다. 

```
{{ bio|truncatewords:30 }}
```

위의 코드는 `bio` 변수값 중에서 앞의 30개의 단어만 보여주고, 줄바꿈 문자는 모두 없애줍니다. 즉, 30개의 문자만을 잘라내는 효과를 줍니다.

필터의 인자에 빈칸이 있는 경우 따옴표로 묶어 줍니다. 

```
{{ list|join:" // " }}
```

위에서 만약 `list`가 `['a', 'b', 'c']`라면, 결과는 `"a // b // c"`가 됩니다.

인자는 디폴트 값을 가질 수도 있습니다.

```
{{ value|default:"nothing" }}
```

위의 코드에서 `value`에 값이 없거나 `False`인 경우, `"nothing"`으로 보여줍니다.

#### length 

아래는 변수값의 길이를 반환하는 필터입니다.

```
{{ value|length }}
```

`value`가 `['a', 'b', 'c']`면, 결과는 3이됩니다.

#### striptags

아래는 변수값에서 HTML 태그를 모두 없애주는 필터입니다. 하지만 이 필터는 100% 보장하지는 않는다고 합니다. 

```
{{ value|striptags }} 
```

#### pluralize

아래는 복수 접미사 필터입니다.

```
{{ value|pluralize }}
```

위의 코드는 value 변수값이 1이 아니면 복수 접미사 `s`를 붙여줍니다. 복수 접미사에 `es`나 `ies`를 붙일 때는 필터에 인자를 사용합니다.

```
{{ value|pluralize:"es" }}
{{ value|pluralize:"y, ies" }}
```

복수 형태가 접미사 형태가 아니고 단어가 바뀌는 것은 어떻게 처리해주는지 아직 모르겠습니다. 따지고 보면 value라는 단어는 개발자가 결정하게 되므로 개발자가 그때그때 필요한 단어가 되게끔 설계를 하면 될 것 같기도 합니다. 

#### add 

아래는 더하기 필터입니다. 

```
{{ value|add:"2" }}
```

`value` 값이 4라면 최종 결과는 6이 됩니다. 더하기 필터는 데이터 타입에 따라서 다르게 동작하므로 주의가 필요합니다.

일단 변수 `value` 와 필터의 인자인 `2`가 모두 integer 타입이라고 가정하고 덧셈을 시도합니다. 이 시도가 실패하면 타입에 따라 각자의 방식으로 더하기를 시도합니다. 여기서도 실패하면  빈 문자열을 반환합니다. 

아래과 같은 코드가 있을 경우, 

```
{{ first|add:second }}
```

* `first='python'`, `second='django'`라면, 결과는 `'pythondjango'`가 됩니다.
* `first=[1, 2, 3]`, `second=[4, 5, 6]` 이라면, 결과는 `[1, 2, 3, 4, 5, 6]`이 됩니다.
* `first='5'`, `second='10'`이라면, 결과는 `15`가 됩니다. 

#### 그 외 필터들

장고는 이외에도 60여가지가 넘는 필터가 존재한다고 합니다. 공식 문서를 참고하면 도움이 될 것 같습니다.[^docs_template_builtins] 

### 템플릿 태그

템플릿 태그는 `{% tag %}` 형식을 가지며, 어떤 태그는 시작 태그와 끝 태그가 둘다 있어야 하기도 하는 등 템플릿 변수나 필터보다는 조금 복잡합니다. 

템플릿 태그는 텍스트 결과물을 만들기도 하고, 템플릿 로직을 제어하기도 하며, 외부 파일을 템플릿 내부로 로딩하기도 합니다.

#### {% for %}

`{% for %}` 태그를 사용하면 리스트에 담겨있는 항목들을 순회하면서 출력할 수 있습니다.

```
<ul>
{% for athlete in athlete_list %}
	<li>{{ athlete.name }}</li>
{% endfor %}
</ul>
```

위의 예제는 운동선수 리스트(athlete_list)에 있는 항목들을 순회하면서 각 운동 선수의 이름(athlete.name)을 보여주는 코드입니다.

forloop 태그에는 아래의 변수들도 사용할 수 있다고 합니다. 다만, 아직 직접 사용해 본적은 없어서 나중에 다시 정리하도록 합니다. 

변수명 | 설명
---|---
`forloop.counter` | 현재까지 실행한 루프 카운트, 1부터 카운트함
`forloop.counter0` | 현재까지 실행한 루프 카운트, 0부터 카운트함
`forloop.revcounter` | 루프 끝에서 현재가 몇 번째인지 카운트한 숫자, 1부터 카운트함
`forloop.counter0` | 루프 끝에서 현재가 몇 번째인지 카운트한 숫자, 0부터 카운트함
`forloop.first` | 루프에서 첫번째 실행이면 `True` 값을 가짐
`forloop.last` | 루프에서 마지막 실행이면 `True` 값을 가짐
`forloop.parentloop` | 중첩된 루프에서 현재의 루프 바로 상위의 루프를 의미함

#### {% if %}

변수를 평가하여, `True`이면 바로 아래의 문장이 표시됩니다.

```
{% if athlete_list %}
	Number of atheletes: {{ athlete_list|length }}
{% elif athlete_in_locker_room_list %}
	Athletes should be out of the lockter room soon!
{% else %}
	No athletes.
{% endif %}
```

위의 코드에서 `athlete_list`가 비어 있지 않으면 운동선수 수가 표시되고, `athlete_in_locker_room_list`가 비어 있지 않으면 그 아래 문장이 화면에 나타날 것입니다. 두 조건 모두 아니라면 `No athletes.`라는 문장이 나타날 것입니다.

`{% if %}` 태그는 필터와 연산자를 사용할 수 있습니다. 다만, 대부분의 필터가 문자열을 반환하므로 산출 연산이 안되는데, `length` 필터는 예외적으로 산술 연산이 가능합니다.

```
{% if athlete_list|length > 1 %}
```

`{% if %}` 태그에는 아래과 같은 논리(boolean) 연산자도 사용할 수 있습니다.

```
and, or, not, and not, ==, !=, <, >, <=, >=, in, not in
```

#### {% csrf_token %}

POST 방식의 `<form>`을 사용하는 템플릿 코드에서는 CSRF 공격을 방지하기 위하여 `{% csrf_token %}` 태그를 사용해야 합니다. 폼 데이터에는 악의적인 스크립트 문장이 있을 수 있기 때문입니다. 

> ### CSFR 공격
> ---
> CSRF(Cross-Site Request Forgery)는 사이트 사이의 요청 위조 공격이라고도 합니다. 웹 사이트의 취약점을 공격하는 방식의 하나로, 특정 웹 사이트에서 이미 인증을 받은 사용자를 이용하여 공격을 시도합니다. 인증을 받은 사용자가 공격 코드가 삽입된 페이지를 열면 공격 대상이 되는 웹 사이트는 위조된 공격 명령이 믿을 수 있는 사용자로부터 발송된 것으로 판단하여 공격을 받게 되는 방식입니다.

```
<form action="." method="post>{% csrf_token %}
```

위치는 위와 같이 `<form>` 요소의 첫 줄 다음에 넣어주면 됩니다. 이 태그를 사용하면 장고는 내부적으로 CSRF 토큰값의 유효성을 검증합니다. 만일 CSRF 토큰값 검증에 실패하면 사용자에게 403 에러를 보여줍니다. 

주의할 점은 CSRF 토큰값이 유출될 수도 있으므로, 외부 URL로 보내는 `<form>`에는 사용하지 않도록 해야합니다.

#### {% url %}

`{% url %}`도 자주 사용하는 코드입니다. 이 태그는 소스에 URL을 하드 코딩하지 않도록 하기 위해 사용합니다. 

```
<form action="{% url 'polls:vote' question.id %}" method="post">

<form action="/polls/3/vote/" method="post">
```

위의 예제는 `{% url %}`를 사용하는 것을 보여주는데, 만약 위에서 `/polls/`라는 폴더를 다른 곳으로 변경하게 되더라도 장고에서 알아서 URLconf 파일을 참조해서 정상적으로 작동하게 됩니다.

태그의 사용 방법은 아래와 같습니다. 

```
{% url 'namespace:view-name' arg1 arg2 %}
``` 

* `namespace` : **urls.py** 파일의 `include()` 함수에서 정의한 이름 공간(namespace)의 이름
* `view-name` : **urls.py** 파일의 URL 패턴에서 정의한 뷰 함수 또는 패턴 이름
* `arg` : 뷰 함수에서 사용하는 인자로, 없을 수도 있고 여러 개인 경우 빈칸으로 구분함 

#### {% with %}

`{% with %}` 태그는 특정 값을 변수에 저장해 두는 기능을 합니다.

```
{% with total=business.employee.count %}
	{{ total }} people works at business
{% endwith %}
```

위 코드에서 total 변수의 유효 범위는 with 구문 내, 즉 `{% with %}`에서 `{% endwith %}` 까지 입니다.

이 태그는 데이터베이스를 조회하는 경우 처럼, 부하가 큰 동작의 결과를 저장해 두고 다시 동일한 동작이 필요한 경우에 저장해둔 결과를 재활용해서 부하를 줄여주기 위해 사용합니다. 

예전 문법은 달랐다고 하는데, 예전 문법은 따로 정리하지 않겠습니다.

#### {% load %}

`{% load %}`는 사용자 정의 태그 및 필터를 로딩해줍니다. 

태그 및 필터는 장고에서 제공해주는 것 말고도 개발자가 필요에 따라 직접 정의해서 사용할 수 있습니다. 이것을 사용자 정의 태그, 사용자 정의 필터라고 합니다. 이들을 사용하기 위해서는 먼저 로딩을 해줘야 합니다. 

```
{% load somelibrary package.otherlibrary %}
```

위의 코드는 somelibrary.py 파일 및 package/otherlibrary.py 파일에 정의된 사용자 정의 태그 및 필터를 로딩하는 코드입니다. 

#### 그 외 태그들

장고는 위에 설명한 태그를 포함하여 약 30여가지의 태그를 제공하고 있으며, 사용자 정의 태그를 만들 수도 있습니다. 이들에 대한 자세한 사항은 장고의 공식 문서를 보면 좋을 것 같습니다.[^docs_custom-template-tags]

### 템플릿 주석

템플릿 코드에도 주석문을 사용할 수 있습니다. 템플릿에 주석문을 사용하는 방법은 2가지가 있습니다. 

1. `{# #}` : 한 줄 주석문입니다. 한 문장 전부 또는 일부를 주석 처리합니다. 

	```
	{# greeting #}hello
	{# {% if foo %}bar{% else %} #}
	```
	
	첫 번째 문장에서는 `greeting`이 주석 처리됩니다. 
	두 번째 문장에서는 템플릿 코드도 주석처리됩니다.
	
2. `{% comment %}` ... `{% endcomment %}` : 여러 줄 주석문입니다.

	```
	{% comment "Optional note" %}
	<p>Commented out text here</p>
	{% endcomment %}
	```
	
	위에서 "Optional note"는 무조건 쓸 필요는 없지만, 주석 처리를 하는 이유를 적어두면 좋은 곳입니다.  
	 `{% comment %}` 태크는 중첩해서 사용할 수는 없습니다.
	
### HTML 이스케이프 

템플릿 코드를 렌더링하여 HTML 코드를 만들 때 템플릿 변수에 HTML 태그가 들어 있는 경우, 문제가 발생할 수 있습니다.  
예를 들어 아래와 같은 상황이 있을 수 있습니다. 

```
name = <b>username
...
Hello, {{ name }}
```

그러면, 결과는 다음과 같이 됩니다. 

```
Hello, <b>username
```

하지만 이 결과가 브라우저에 표시될 때는 `<b>` 태그 이후의 문장을 모두 볼드체로 바꾸게 됩니다. `Hello, <b>username`와 같은 식으로는 나타나지 않습니다. 

이러한 약점을 이용해서 XSS 공격이 이루어 집니다. 

> ### XSS 공격
> ---
> XSS(Cross-Site Scripting)는 사이트 사이의 스크립트 공격이라고 표현합니다. 웹 사이트의 취약점을 공격하는 방법 중의 하나로, 웹 사이트 관리자가 아닌 일반 사용자라도 시도할 수 있는 공격 방법입니다. 주로 여러 사용자가 보게 되는 전자 게시판에 악성 스크립트가 담긴 글을 올리는 형태로 이루어 집니다. 이 취약점은 웹 어플리케이션이 사용자로 부터 입력받은 값을 제대로 검사하지 않고 사용할 경우에 나타납니다.

이와 같이 사용자가 입력한 데이터를 그대로 렌더링하는 것은 위험할 수 있습니다. 그래서 장고는 자동 이스케잎(escape) 기능을 제공하고 있습니다. 장고는 디폴트로 HTML에 사용되는 예약 문자들을 아래처럼 의미를 제거한 문자로 변경해주는 기능을 제공합니다. 

* `<` (less than) 문자는 `&lt;`로 변경합니다.
* `>` (great than) 문자는 `&gt;`로 변경합니다.
* `'` (single quote) 문자는 `&#39;`로 변경합니다.
* `"` (double quote) 문자는 `&quot;`로 변경합니다.
* `&` (ampersand) 문자는 `&amp;`로 변경합니다.

하지만 가끔씩 이 자동 HTML 이스케잎 기능을 비활성화해야 하는 경우도 있스빈다. 예를 들면, HTML 태그를 그대로 출력해야 할 때라던가, 이스케잎 문자가 들어 있는 이메일 메시지를 템플릿 파일에 출력해야할 경우입니다.

이 때 장고의 자동 이스케잎 기능을 비활성화시키는 방법은 2가지가 있습니다. 

1. `safe` 필터 사용하기

	```
	This will not be escaped: {{ data|safe }}
	```
	
	`safe` 필터는 템플릿 변수에만 영향을 미칩니다.

2. `{% autoescape %}` 태그 사용하기

	```
	{% autoescape off %}
	Hello {{ name }}
	{% endautoescape %}
	```
	
	이 방법은 템플릿 코드 전체나 일부 영역에서 이스케잎을 방지할 수 있습니다.  
	
필터의 인자에 사용되는 문자열 리터럴(literal)에는 자동 이스케잎 기능이 적용되지 않습니다. 그래서 아래의 예제에서 첫번째 보다는 두번째 방법을 사용하는 것이 좋다고 합니다.

```
{{ data|default:"3 < 5" }}
{{ data|default:"3 &lt; 5" }}
```

하지만, 그냥 보기에도 잘 안될 것 같습니다. ㅜㅜ

### 템플릿 상속

템플릿 코드는 상속도 가능합니다. 템플릿 상속을 이용하면 템플릿 코드를 재사용할 수 있고, 사이트의 룩앤필을 일관성있게 보여줄 수 있습니다. 

부모 템플릿은 템플릿의 뼈대를 만들고 `{% block %}` 태그를 통해 하위로 상속해 줄 부분을 지정하며, 자식 탬플릿은 부모 템플릿의 뼈대는 그대로 사용하고 `{% block %}` 부분만 채워주면 됩니다. 

아래에 템플릿 상속을 사용하는 예를 나타내었습니다.

* **base.html**
	
	```
	<!DOCTYPE html>
	<html lang="en">
	<head>
		<link rel="stylesheet" href="style.css" />
		<title>{% block title %}My amazing site{% endblock %}</title>
	</head>
	<body>
		<div id="sidebar">
			{% block sidebar %}
			<ul>
				<li><a href="/">Home</a>
				<li><a href="/blog/">Blog</a></li>
			</ul>
			{% endblock %}
		</div>
		<div id="content">
			{% block content %}{% endblock %}
		</div>
	</body>
	</html>
	```
	일단 기반 템플릿에서 3개의 `{% block %}` 태그를 지정했습니다. 
	 
* **derived.html**

	```
	{% extends "base.html" %}

	{% block title %}My amazing blog{% endblock %}

	{% block content %}
	{% for entry in blog_entries %}
		<h2>{{ entry.title }}</h2>
		<p>{{ entry.body }}</p>
	{% endfor %}
	{% endblock %}
	```
	
	그리고, 파생 템플릿에서 2개의  `{% block %}` 태그를 채웠습니다. 파생 템플릿에서 채우지 않은 태그는 기반 템플릿의 내용을 그대로 사용합니다.  
	또한 상속받는 다는 것을 표시하기 위해  `{% extends %}` 태그를 사용합니다.
	
* **렌더링(rendering) 결과**

	```
	<!DOCTYPE html>
	<html lang="en">
	<head>
		<link rel="stylesheet" href="style.css" />
		<title>My amazing blog</title>
	</head>
	<body>
		<div id="sidebar">
			<ul>
				<li><a href="/">Home</a>
				<li><a href="/blog/">Blog</a></li>
			</ul>
		</div>
		<div id="content">
			<h2>Entry one</h2>
			<p>This is my first entry.</p>

			<h2>Entry two</h2>
			<p>This is my second entry.</p>
		</div>
	</body>
	</html>
	```
	
위와 같이 템플릿 상속을 사용하면 템플릿 전체의 모습을 구조화할 수 있어서 코드의 재사용이나 변경이 용이하고, 무엇보다도 사이트 UI의 룩앤필을 일관되게 가져갈 수 있습니다. 

사이트 전체적으로 조화로운 룩앤필을 만들기 위하여 보통 템플릿 상속을 3단계로 사용하는 것을 권장하고 있다고 합니다. 

* 1단계 : 사이트 전체의 룩앤필을 담고 있는 **base.html**을 만듭니다. 
* 2단계 : 사이트 하위의 섹션별 스타일을 담고 있는 **base_news.html**, **base_sports.html** 등의 템플릿을 만듭니다. 2단계의 템플릿들은 1단계 **base.html** 템플릿들을 상속합니다.
* 3단계 : 개별 페이지에 대한 템플릿을 만듭니다. 3단계 템플릿들은 2단계 템플릿 중에서 적절한 템플릿을 상속받습니다.

마지막으로 템플릿 상속에서 조심해야할 점들을 정리했습니다. 

* `{% extends %}` 태그는 사용하는 태그 중에서 가능 먼저 나와야 합니다. 
* 템플릿의 공통 사항을 가능하면 많이 뽑아서 1단계 기반 템플릿에 `{% block %}` 태그가 많아질수록 좋습니다.
* 기반 템플릿에 있는 `{% block %}`의 내용을 그대로 사용하고 싶다면 파생 템플릿에서 `{{ block.super }}` 변수를 사용하면 됩니다. 이 경우는 기반 템플릿의 `{% block %}` 내용을 파생 템플릿이 내용으로 오버라이드하지 않스빈다. 기반 템플릿의 내용을 그대로 사용하면서 파생 템플릿의 내용을 추가하는 경우에 사용할 수 있습니다. 
* 가독성을 높이기 위하여 `{% endblock content %}` 처럼 블럭명을 기입해도 됩니다. 

### 참고 자료

[^Liquid]: [Liquid](http://shopify.github.io/liquid/) : Liquid is an open-source template language created by Shopify and written in Ruby.

[^Jinja2]: [Jinja2](http://jinja.pocoo.org) : Jinja2 is a full featured template engine for Python.

[^docs_templates]: [The Django template language](https://docs.djangoproject.com/en/1.10/ref/templates/language/) : Django의 template language에 대한 공식 문서입니다.

[^hanbit_book_1]: [파이썬 웹 프로그래밍: Django(장고)로 배우는 쉽고 빠른 웹 개발](http://www.hanbit.co.kr/store/books/look.php?p_code=B5790464800)

[^wikipedia]: [Comparison of web template engines](https://en.wikipedia.org/wiki/Comparison_of_web_template_engines) : Wikipedia에 있는 웹 Template 언어 또는 엔진(?)들을 비교한 자료입니다.

[^Shopify_liquid]: [Shopify/liquid](https://github.com/Shopify/liquid/wiki) : GitHub for Liquid

[^docs_template_builtins]: [Built-in template tags and filters](https://docs.djangoproject.com/en/1.10/ref/templates/builtins/) : 장고(Django) 1.10 버전 기준으로 내장된(built-in) 템플릿 필터에 대한 공식 문서입니다.

[^docs_custom-template-tags]: [Custom template tags and filters](https://docs.djangoproject.com/en/1.10/howto/custom-template-tags/) : 장고에서 사용자 정의 태그 및 필터를 만드는 방법에 대해서 설명한 공식 문서입니다.