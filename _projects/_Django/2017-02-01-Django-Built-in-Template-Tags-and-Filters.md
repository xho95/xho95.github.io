현재는 전체 내용중에서 include 부분만 정리한 것입니다. 

**include**

템플릿을 불러와서 현재 내용(context)에 나타내줍니다. 이것은 한 템플릿이 다른 템플릿을 “포함하는(including)” 한가지 방법입니다.

템플릿 이름은 변수일 수도 있고 (따옴표로) 지정된 문자열 일수도 있으며, 따옴표는 홀따옴표나 겹따옴표 모두 가능합니다.

아래의 예제는 **"foo/bar.html"** 템플릿의 내용(contents)을 포함하는 방법을 보여줍니다:

```html
{% include "foo/bar.html" %}
```

문자열 인자에서 상대 경로를 나타낼 경우 **./** 나 **../** 로 시작할 수 있습니다. 이는 **extends** 태그에 설명되어 있습니다.

> **장고 1.10 에서 달라진 것**:
> 
> 상대 경로를 사용하는 방법이 추가되었습니다.

아래의 예제는 템플릿 내용을 포함하는 예제인데 템플릿의 이름이 **template_name** 라는 변수에 저정되어 있는 경우입니다:

```html
{% include template_name %}
```

이 변수는 내용을 받아들이는 **render()** 메소드가 있는 어떤 객체라도 됩니다. 이렇게하면 컨텍스트에서 컴파일된 **Template** 을 참조할 수 있습니다.

포함되는 템플릿은 템플릿을 포함하는 템플릿 컨텍스트내에서 렌더링됩니다. 아래의 예제는 결과로 **"Hello, John!"** 을 만들어 냅니다:

* 컨텍스트(Context): 변수 **person** 은 **"John"** 으로 두고변수 **greeting** 은 **"Hello"** 로 둡니다.

* 템플릿:

	```
	{% include "name_snippet.html" %}
	```
	
* **name_snippet.html** 템플릿:

	```
	{{ greeting }}, {{ person|default:"friend" }}!
	```
	
키워드 인자를 사용하여 템플릿에 추가 컨텍스트를 전달할 수 있습니다:

```
{% include "name_snippet.html" with person="Jane" greeting="Hello" %}
```

제공된 변수 만 사용하여 컨텍스트를 렌더링하려면 (또는 변수가 전혀없는 경우) **only** 옵션을 사용하십시오. 포함 된 템플릿에는 다른 변수를 사용할 수 없습니다:

```
{% include "name_snippet.html" with greeting="Hi" only %}
```

If the included template causes an exception while it’s rendered (including if it’s missing or has syntax errors), the behavior varies depending on the **template engine's debug** option (if not set, this option defaults to the value of **DEBUG**). When debug mode is turned on, an exception like **TemplateDoesNotExist** or **TemplateSyntaxError** will be raised. When debug mode is turned off, **{% include %}** logs a warning to the **django.template** logger with the exception that happens while rendering the included template and returns an empty string.

> **장고 1.9 에서 달라진 점**:
> 
> Template logging now includes the warning logging mentioned above.

> **Note**
> 
> The include tag should be considered as an implementation of “render this subtemplate and include the HTML”, not as “parse this subtemplate and include its contents as if it were part of the parent”. This means that there is no shared state between included templates – each include is a completely independent rendering process.
> 
> Blocks are evaluated before they are included. This means that a template that includes blocks from another will contain blocks that have already been evaluated and rendered - not blocks that can be overridden by, for example, an extending template.

### 원문 자료

[Built-in template tags and filters](https://docs.djangoproject.com/en/1.10/ref/templates/builtins/)