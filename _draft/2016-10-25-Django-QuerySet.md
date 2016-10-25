queryset으로 모델을 지정하면 model 속성은 자동으로 무효가 된다고 합니다. 

queryset을 사용하면 객체에 대한 filtered list를 정의할 수 있어서 뷰에 보일 객체들을 선별해서 보여줄 수 있습니다.

Dynamic filtering에 대한 내용도 잘 읽고 자기 것으로 만들어야 합니다. 

context_object_name 속성을 사용하면 object_list를 대체하는 이름을 지정할 수 있습니다. 이 부분은 Making “friendly” template contexts부분을 참고하면 됩니다.

### 참고 자료

[Built-in class-based generic views](https://docs.djangoproject.com/es/1.10/topics/class-based-views/generic-display/) 의 Viewing subsets of objects 부분을 보면 queryset의 활용법에 대해서 잘 나와있다.