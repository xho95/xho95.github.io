뷰는 요청을 받아서 응답을 반환해주는 호출 가능한(callable) 객체입니다. 장고에서는 뷰를 함수로 작성할 수도 있고 클래스로로 작성할 수 있습니다.

클래스 기반 뷰가 함수 기반 뷰보다 장점이 많습니다. 클래스 기반 뷰를 사용하면 상속과 믹스인 기능을 사용하여 코드를 재사용할 수도 있고, 뷰를 체계적으로 관리할 수도 있습니다. 제네릭 뷰 역시 클래스 기반 뷰로 작성되어 있습니다. 

### 클래스 기반 뷰 시작하기

클래스 기반 뷰를 사용하기 위해서는 먼저 **URLconf**에서 클래스 기반 뷰를 사용한다고 선언해줘야 합니다. 예를 들어 `MyView`라는 클래스 기반 뷰를 사용한다면 아래 처럼 선언하게 됩니다.

* **urls.py**

	```
	from django.conf.urls import url
	from myapp.views import MyView
	
	urlpatterns = [
		url(r'^about/', MyView.as_view()),
	]
	```
	
장고의 URL 해석기는 요청과 관련한 파라미터들을 클래스가 아니라 함수에 전달하기 때문에, 클래스 기반 뷰는 `as_view()`라는 클래스 멤버 함수를 제공합니다. 이 메소드를 진입 메소드라고 합니다.

`as_view()`의 역할은 클래스의 인스턴스를 생성하고, 그 인스턴스의 `dispatch()` 메소드를 호출하는 것입니다. `dispatch()` 메소드는 HTTP 요청에 따라 해당 이름을 갖는 메소드로 요청을 중계합니다. 해당 메소드가 구현되어 있지 않으면 `HttpResponseNowAllowed` 예외를 발생합니다. 

### 클래스 기반 뷰 정의하기

일단 `MyView`라는 클래스 기반 뷰를 사용하기로 했으니 이를 어딘가에 정의해야 합니다. 정의 위치는 함수 기반 뷰와 동일하게 **views.py** 파일에 하면 됩니다. 대략적인 형태는 아래와 같을 것입니다.

* views.py

	```
	from django.http import HttpResponse
	from django.views.generic import View
	
	class MyView(View):
		def get(self, request):
			...
			return HttpResponse('result')
	```
 
위의 코드에서 **MyView** 클래스는 **View** 클래스를 상속받고 있는데, `as_view()`와 `dispatch()` 메소드는 **View** 클래스에 정의되어 있습니다. 따라서 따로 구현하지 않아도 됩니다.

### 클래스 기반 뷰의 장점

클래스 기반 뷰는 함수 기반 뷰에 비해 다음과 같은 장점을 가지고 있습니다. 

* GET, POST 등의 HTTP 메소드에 따른 처리 기능을, if 구문을 사용하지 않고 메소드 이름으로 구분할 수 있어서 코드가 깔끔해 집니다. 
* 상속과 같은 객체 지향 기술을 사용하게 되므로, 클래스 기반 제네릭 뷰 및 믹스인 클래스 등을 사용할 수 있어서 코드의 재사용성이나 생산성을 높여줍니다. 

#### 효율적인 메소드 구분

함수 기반 뷰에서는 HTTP 요청이 GET, POST, HEAD 인지 구현부 내에서 구분하는 코드가 필요합니다. 

반면 클래스 기반 뷰에서는 `dispatch()` 메소드가 각각의 요청에 따라서 이름으로 구분을 지어서 호출해 줍니다. 대신 메소드명은 `get()`, `post()`, `head()` 등으로 일정한 규칙을 따라야 합니다. 

#### 제네릭 뷰 상속

클래스 기반 뷰는 장고가 제공해주는 제네릭 뷰를 상속받아서 작성하게 됩니다. 제네릭 뷰란, 뷰 개발 과정에서 공통적으로 사용할 수 있는 기능들을 추상화하고, 장고에서 이를 미리 만들어서 제공해주는 클래스 기반 뷰를 말합니다. 

장고에서 제공하는 제네릭 뷰는 다음과 같이 크게 4가지로 분류할 수 있습니다. 

1. Base View : 뷰 클래스를 생성하고, 다른 제네릭 뷰의 기반 클래스를 제공하는 기본 제네릭 뷰입니다.
	* View
	* TemplateView
	* RedirectView
 
2. Generic Display View : 객체의 리스트를 보여주거나 특정 객체의 상세 정보를 보여줍니다. 
	* DetailView
	* ListView
 
3. Generic Edit View : 폼을 통해 객체를 생성, 수정, 삭제하는 기능을 제공합니다. 
	* FormView
	* CreateView
	* UpdateView
	* DeleteView
 
4. Generic Date View : 날짜 기반 객체의 년/월/일 페이지로 구분해서 보여줍니다.
	* YearArchiveView
	* MonthArchiveView
	* DayArchiveView 

제네릭 뷰에 대한 전체 리스트 및 보다 자세한 설명은 장고 공식 문서를 참고하시기 바랍니다.[^class-based-views]

### 클래스 기반 뷰에서의 폼 처리

폼 처리 과정을 구분하면 아래와 같습니다.

* 최초의 GET : 폼은 비어있거나 미리 채워진 테이터를 가짐
* 유효한 데이터를 가진 POST : 데이터를 처리하고 리다이렉트 처리를 함
* 유효하지 않는 데이터를 가진 POST : 에러 메시지와 함께 폼이 다시 출력됨

함수 기반 뷰로 처리하면 다음과 같습니다. 

```
from django.http import HttpResponseRedirect
from django.shortcuts import render

from forms import MyForm

def myview(request):
	if request.method == "POST":
		form = MyForm(request.POST)
		if form.is_valid():
			...
			return HttpResponseRedirect('/success/')
	else:
		form = MyForm(initial={ 'key': 'value' })
		
	return render(request, 'form_template.html', { 'form': form })
```

같은 로직을 함수 기반 뷰로 코딩하면 다음과 같습니다. View 제네릭 뷰를 상속받았습니다. 

```
from django.http import HttpResponseRedirect
from django.shortcuts import render
from django.views.generic import View

from forms import MyForm

class MyFormView(View):
	form_class = MyForm
	initial = { 'key': 'value' }
	template_name = 'form_template.html'
	
	def get(self, request, *args, **kargs):
		form = self.form_class(initial=self.initial)
		return render(request, self.template_name, { 'form': form })
		
	def post(self, request, *args, **kargs):
		form = self.form_class(request.POST)
		if form.is_valid():
			...
			return HttpResponseRedirect('/success/')
			
		return render(request, self.template_name, { 'form': form })
```

이제 폼 처리용 뷰인 FormView를 상속받아 구현한 코드입니다.

```
from django.views.generic.eidt import FormView

from forms import MyForm

class MyFormView(FormView):
	form_class = MyForm
	template_name = 'form_template.html'
	success_url = '/thanks/'
	
	def form_valid(self, form):
		...
		return super(MyFormView, self).form_valid(form)
```

FormView 제네릭 뷰를 사용하면 상속을 받게 되므로 get(), post() 메소드의 정의도 필요없습니다. 다음의 4가지 사항을 유의하여 코딩하면 됩니다. 

* form_class : 사용자에게 보여줄 폼을 정의한 forms.py 파일 내의 클래스명
* template_name : 폼을 포하하여 렌더링할 템플릿 파일 이름
* success_url : MyFormView 처리가 정상적으로 완료됐을 때 리다이렉트 시킬 URL
* form_vaild() : 유효한 폼 데이터로 처리할 로직 코딩, 반드시 super() 함수를 호출해야 함

### 참고 자료

[^class-based-views]: [Built-in class-based views API](https://docs.djangoproject.com/en/1.10/ref/class-based-views/)
