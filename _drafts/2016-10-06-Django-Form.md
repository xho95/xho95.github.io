일단 [파이썬 웹 프로그래밍: Django로 배우는 쉽고 빠른 웹 개발]() 책의 내용을 기본으로 정리한 자료입니다. 나중에 내용을 좀 더 추가하고 보완해야 합니다.[^book_1] 

### Form

웹 사이트에서는 사용자로부터 입력을 받기 위해 폼을 사용합니다. 폼에 입력된 데이터는 서버로 보내집니다. 

HTML에서 폼은 `<form>...</form>` 사이에 있는 엘리먼트들의 집합입니다. 폼에서는 텍스트를 입력할 수도 있고, 항목을 선택할 수도 있습니다. 텍스트 입력이나 체크 박스 등과 같은 간단한 폼의 엘리먼트들은 기본 위젯을 사용하지만, 달력 위젯, 슬라이드 바 등의 복잡한 엘리먼트들은 자바 스크립트나 CSS를 사용하기도 합니다. 

폼은 `<input>` 엘리먼트 외에도 폼 데이터를 어디로 보낼지 지정해주는 `action` 속성과 어떤 HTTP 메소드로 보낼지 지정해주는 `method` 속성을 설정해줘야 합니다. 

HTTP 프로토콜 중에서 폼에서 사용할 수 있는 `method`는 GET과 POST 뿐입니다. 

보통 GET과 POST 방식은 다른 용도로 사용합니다. 서버 시스템의 상태를 바꾸는 요청, 예를 들어 데이터베이스의 내용을 변경하는 요청은 POST 방식을 사용하고, 시스템의 상태를 바꾸지 않는 요청에는 GET 방식을 사용합니다. 

GET 방식은 패스워드 폼에서는 사용하지 않습니다. 왜냐면 패스워드가 URL이나 브라우저 히스토리, 서버의 로그에 텍스트로 보일 수 있기 때문입니다. 또 GET 방식은 폼 데이터량이 많거나 이미지와 같은 2진 데이터를 보내는 경우에도 부적합하고 보안에도 취약하기 때문에 이 경우에도 POST 방식만을 사용합니다. 

한편 검색 폼 같은 경우에는 GET 방식이 적절한데, GET 방식의 데이터가 URL에 포함되므로 URL을 북마크해두고 쉽게 공유하거나 재전송할 수 있기 때문입니다.

장고는 폼 처리에 POST 방식만을 사용합니다. 추가적으로 장고는 보안을 강화하기 위하여 CSRF 방지 기능을 제공합니다. 

### 장고의 Form 기능

웹 서버에서의 폼 처리는 복잡해 보이지만, 공통적인 절차를 가지고 있습니다. 장고는 이러한 폼 기능들을 단순화하고 자동화해서 개발자가 직접 코딩하는 것보다 훨씬 안전하게 처리해줍니다. 

장고는 폼 처리를 위하여 다음의 3가지 기능을 제공합니다. 

1. 폼 생성에 필요한 데이터를 폼 클래스로 구조화하기
2. 폼 클래스의 데이터를 렌더링하여 HTML 폼 만들기
3. 사용자로부터 제출된 폼과 데이터를 수신하고 처리하기

장고의 폼 클래스는 폼이 어떻게 작동하고 어떻게 보이는 지를 기술합니다. 

폼 클래스에는 역시 클래스로 이루어진 필드들이 있는데, 폼 클래스의 필드는 HTML 폼의 `<input>` 엘리먼트에 맵핑됩니다. 

필드는 폼 데이터를 저장하고, 데이터의 종류에 따라 자신의 타입을 가지며, 폼이 제출되면 자신의 데이터에 대한 유효성 검사를 실시합니다. 폼의 필드는 브라우저에서 HTML 위젯으로 표현되는데, 필드 타입마다 디폴트 위젯 클래스를 가지고 있으며 필요한 경우 오버라이딩 할 수 있습니다.

폼도 결국 템플릿의 일부이므로 템플릿 코드에 포함되어서 렌더링 절차를 거칩니다. 참고로 장고에서 객체를 렌더링할 때 진행하는 3가지 절차는 아래와 같습니다.

1. 렌더링할 객체를 뷰로 가져오기 (데이터베이트로부터 객체를 추출하기)
2. 객체를 템플릿 시스템으로 넘겨주기
3. 템플릿 문법을 처리해서 HTML로 변환하기 

폼도 위와 같은 과정을 거치는 것은 동일하지만, 다만 폼의 경우 객체에 데이터가 없을 수도 있습니다. 일반적인 모델의 경우 데이터가 없는 객체를 렌더링 할 이유는 없지만, 폼의 경우 렌더링을 먼저하고 이후에 사용자가 데이터를 채우는 것이 보통이므로, 빈 폼을 렌더링해야할 경우가 많습니다. 

따라서 뷰 함수에서 폼 객체를 생성할 때는 데이터 없이 만드는 것과 데이터를 채워서 만드는 것을 구분해서 코딩해야 합니다. 또 데이터를 채울 때는 저장된 모델 객체로부터 채울 수도 있고, 직전에 제출된 HTML 폼으로부터 채울 수도 있습니다. 직전에 제출된 HTML 폼으로부터 채우는 방식은 한 필드에 에러가 발생해서 다시 폼 데이터를 입력받아야 할 때 자주 사용됩니다. 

데이터가 없는 폼을 언바운드 폼(unbound form)이라 하며, 언바운드 폼은 렌더링되어 사용자에게 보여질 때 비어있거나 디폴트 값으로 채워집니다. 바운드 폼(bound form)은 제출된 데이터를 가지고 있어서 데이터의 유효성 검사를 하는데 사용됩니다.

### 장고의 폼 클래스로 폼 생성하기

장고는 폼을 클래스로 정의해서 간단하게 만들 수 있습니다. 

#### HTML로 폼 정의하기

예를 들어 아래와 같이 사용자의 이름을 취득하기 위한 폼을 만든다고 생각합니다. 
- - -
<form action="/your-name/" method="post">
	<label for="your name">Your name: </label>
	<input id="your_name" type="text" name="your_name" value="{{ current_name }}">
	<input type="submit" value="OK">
</form>
- - -

그러면 아래와 같은 코드가 필요할 것입니다.

```
<form action="/your-name/" method="post">
	<label for="your name">Your name: </label>
	<input id="your_name" type="text" name="your_name" value="{{ current_name }}">
	<input type="submit" value="OK">
</form>
```

#### 장고 폼 클래스로 정의하기

장고는  위와 같은 `<form>` 엘리먼트의 기능을 제공하기 위하여 아래와 같이 폼 클래스를 정의합니다. 모든 폼 클래스는 django.forms.Form의 파생 클래스입니다.

```
from django import forms

class NameForm(forms.Form):
	your_name = forms.CharField(label="Your name", max_length=100)
```

위에서는 필드가 `your_name` 하나인 폼 클래스를 만들었습니다. 대부분의 폼 필드는 디폴트 위젯을 가지고 있는데, `CharField` 타입의 필드는 **TextInput** 위젯이 디폴트 위젯이며, HTML `<input type="text">`로 변환됩니다.

디폴트 위젯을 `<textarea>`로 변경하려면 아래와 같이 폼 필드를 정의할 때 명시하면 됩니다.

```
your_name = forms.CharField(label="Your name", max_length=100, widget=forms.Textarea)
```

그리고 `label` 속성을 정의했는데, 이는 렌더링되면 `<label>` 엘리먼트가 될 것입니다.  
필드의 최대 길이도 `max_length` 속성으로 지정했는데, 이는 2가지 기능을 합니다. 하나는 HTML `<input>` 엘리먼트에 `maxlength="100"` 문구를 넣어서 사용자가 100글자 이상 입력하는 것을 방지하도록 합니다. 또 다른 하나는 장고가 브라우저로 하여금 폼 데이터를 받았을 때 데이터의 길이가 유효한지 검사하는데 사용됩니다.

#### 유효성 검사

장고의 폼 클래스는 모든 필드에 대해 유효성 검사 루틴을 실행시키는 `is_valid()` 메소드를 가지고 있습니다. 이 메소드가 호출되어 유효성 검사를 하고 모든 필드가 유효하다면 다음과 같은 2가지를 수행합니다.

1. `True`를 반환합니다.
2. 폼 데이터를 `cleaned_data` 속성에 넣습니다.

#### 장고 폼 클래스의 렌더링 결과

앞의 폼 클래스를 렌더링한 결과는 다음과 같습니다.

```
<label for="your name">Your name: </label>
<input id="your_name" type="text" name="your_name" max_length="100">
```

위의 코드를 보면 `<form>` 태그나 `submit` 버튼이 없습니다. 이는 개발자가 직접 템플릿에 넣어야 합니다. 그래서 템플릿 코드에 아래와 같이 코딩을 합니다.

* **name.html**

	```
	<form acton="/your_name/" method="post">
		{% csrf_token %}
		{{ form }}
		<input type="submit" value="Submit" />
	</form>
	```
	
위에서 CSRF 공격을 방지하기 위하여 `{% csrf_token %}` 태그를 추가하였고, 폼 클래스는 `{{ form }}` 변수로 사용하였습니다. `{{ form }}` 변수는 뷰에서 컨텍스트 변수에 포함하여 템플릿 시스템으로 넘겨줍니다.

#### 뷰에서 폼 클래스 처리하기

`NameForm` 클래스를 정의하고, `name.html` 템플릿 코드를 만든 것은 폼을 화면에 보여주기 위한 것입니다. 이제 뷰 코드를 작성해서 이 폼에 데이터를 수신하고 처리하는 로직을  구현하겠습니다.

폼을 처리하는 뷰는 2개의 기능을 수행해야 합니다. 하나는 폼을 보여주는 기능이고, 하나는 제출된 폼을 처리하는 기능입니다. 장고는 이 2개의 기능을 하나의 뷰로 통합해서 처리할 수 있는데, 이렇게 통합해서 처리하는 것을 권장하고 있습니다. 

하나의 뷰에서 2개의 기능을 수행하려면 두 기능을 구분할 수 있어야 하는데, 장고에서는 HTTP 메소드로 구분합니다. 즉, 뷰가 GET 방식으로 요청을 받으면 사용자에게 처음으로 폼을 보여주도록 처리하고, POST 방식으로 요청을 받으면 데이터가 담긴 제출용 폼으로 간주하여 처리합니다. 

뷰에서 폼 클래스를 처리하는 방식은 다음과 같습니다. 

```
from django.shorcuts import render
from django.http import HttpResponseRedirect

def get_name(request):
	if request.method == 'POST':
		form = NameForm(request.POST)
		
		if form.is_valid():
			new_name = form.cleaned_data['name']
			...
			return HttpResponseRedirect('/thanks/')
	else:
		form = NameForm()
		
	return render(request, 'name.html', { 'form': form })
```

* 뷰 함수의 이름은 `get_name()`이며, `request` 인자는 필수입니다.
* GET 요청과 POST 요청을 구분하여 처리합니다.
* GET 요청이 들어오면 빈 폼 객체를 생성하여 템플릿 엔진으로 전달합니다. 이 부분은 사용자가 해당 URL을 처음 방문할 때 일어납니다.
* 사용자가 폼에 데이터를 입력하고 제출하면 POST 요청으로 도착합니다.
* 폼이 POST 요청으로 제출되면 뷰는 다시 한 번 폼 객체를 생성하는데, 이번에는 요청에 포함된 데이터로 채워줍니다. 이러한 폼을 바운드 폼(bound form)이라고 합니다.
* 폼의 `is_valid()` 메소드를 호출합니다.
* `True`가 아니며, `if` 구문을 벗어나서 마지막 라인의 `render()` 함수를 호출합니다. 이 때 엔진으로 전달되는 컨텍스트 변수 `form`에는 직전에 제출된 폼 데이터로 채워집니다.
* 만일 `True`이면, 유효한 데이터가 `cleaned_data` 속성에 담기게 되고 이 데이터를 사용하여 데이터베이스를 변경하거나 로직에 따른 처리를 합니다. 이후에 브라우저에게 HTTP 리다이렉트를 전송하여 다음 페이지로 이동합니다.
* `HTTPResponseRequest()`를 리턴하는 경우가 아니면 마지막 라인이 실행되는데, `render()` 함수는 템플릿 코드 `name.html`에 컨텍스트 변수를 적용하여 사용자에게 보여줄 최종 템플릿 파일을 만들고 이를 담은 HttpResponse 객체를 반환합니다.

#### 폼 클래스를 템플릿으로 변환할 때의 옵션

폼 클래스를 템플릿으로 변환하기 이해서는 폼 객체를 생성해서 이를 템플릿 엔진으로 넘겨주면 됩니다. 템플릿 엔진에서는 템플릿 문법과 폼 객체를 해석해서 HTML 템플릿 파일을 만들어 줍니다. 

앞서 `{{ form }}` 구문이 HTML의 `<label>`과 `<input>` 엘리먼트로 렌더링 되는 것을 보았는데, 이외에도 3가지 옵션이 더 있습니다.

* `{{ form.as_table }}` : `<tr>` 태그로 감싸서 테이블 셀로 렌더링합니다.
* `{{ form.as_p }}` : `<p>` 태그로 감싸도록 렌더링됩니다. 
* `{{ form.as_ul }}` : `<li>` 태그로 감싸도록 렌더링됩니다.

물론 `<table>` 혹은 `<ul>` 태그들은 자동으로 생기지 않으니 개발자가 직접 추가해야 합니다. 

아래와 같이 ContactForm을 정의했다고 가정합니다.

```
from django import forms

class ContactForm(forms.Form):
	subject = forms.CharField(max_length=100)
	message = forms.CharField(widget=forms.Textarea)
	sender = forms.EmailField()
	cc_myself = forms.BooleanField(required=False)
```

위의 코드를 `{{ form.as_p }}` 옵션을 사용해서 변환하면 아래과 같은 템플릿 파일이 만들어집니다.

```
<p><label for="id_subject">Subject:</label><input id="id_subject" type="text" name="subject" maxlength="100"></p>
<p><label for="id_message">Message:</label><input id="id_message" type="text" name="message"></p>
<p><label for="id_sender">Sender:</label><input id="id_sender" type="email" name="sender"></p>
<p><label for="id_cc_myself">CC myself:</label><input id="id_cc_myself" type="checkbox" name="cc_myself"></p>
```

위에서 보듯 각 필드의 타입에 따라 `<input type>` 태그의 타입이 변합니다.

`<label>` 태그에 나타나는 텍스트는 각 필드를 정의할 때 명시적으로 지정할 수 있는데, 지정하지 않으면 디폴트 레이블 텍스트가 사용됩니다. 디폴트 레이블 텍스트는 필드명에서 첫글자를 대문자로 바꾸고 밑줄(`_`)은 빈칸(` `)으로 변경하여 만들어 줍니다.

`<input id>` 태그의 속성도 각 필드의 필드명을 사용하여 `id_필드명`의 형식으로 만들어 줍니다. 이것은 `<label for>` 태그의 속성에도 사용됩니다.

### 참고 자료

[^book_1]: [파이썬 웹 프로그래밍: Django로 배우는 쉽고 빠른 웹 개발]()