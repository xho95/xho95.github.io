DB를 다루다보면 트리 구조로 된 자료를 저장하고 불러올 필요가 생깁니다.  [^stackoverflow_1] 이를 어떻게 구현하면 좋을지 고민하던 중 [django-mptt](https://github.com/django-mptt/django-mptt)라는 것을 알게되어 정리합니다.[^stackoverflow_2]

이 글은 GitHub에 있는 [django-mptt](https://github.com/django-mptt/django-mptt) 프로젝트의 글과 [django-mptt의 공식 문서](http://django-mptt.github.io/django-mptt/index.html#)을 중심으로 기타 유용한 자료들을 번역하고 정리한 것입니다.[^django-mptt]  [^document]  [^groups]

참고로 **MPTT**에 대한 개념은 [Storing Hierarchical Data in a Database](https://www.sitepoint.com/hierarchical-data-database-2/)라는 글에 잘 정리되어 있는 것 같습니다.[^sitepoint] 이 글은 [Mysql + php 트리구조 재귀호출](http://www.freeimage.kr/tip_php/p40/804)라는 글로 번역되어 있는 글도 있는 것 같습니다.[^freeimage]  다른 자료도 있습니다.[^mikehillyer] 

### `django-mptt`란 무엇인가?

`django-mptt`는 재사용 가능한 Django 어플리케이션으로 Django 모델에서 MPTT를 쉽게 사용하게 할 목적으로 만들어진 것입니다.

> Django에서의 어플리케이션이라는 말은 일반적인 쓰는 어플리케이션이라는 단어와는 의미가 조금 다릅니다. 
 
이것은 데이터베이트 테이블을 트리(tree) 구조로 관리하는 세부적인 부분들을 처리하며, 모델 인스턴스의 트리와 작업하기 위한 도구들을 제공합니다.

### 시스템 요구사항

* python 2.7 또는 3.2 이상
* 지원되는 Django 버전 (현재는 1.8 이상 버전)

### 특징

* 모델 등록이 간단합니다. - 트리 구조에 필요한 필드(fields)를 자동으로 추가합니다.
* 트리 구조는 모델 인스턴스를 생성, 삭제하거나 인스턴스의 부모를 바꿀 때 자동으로 업데이트 됩니다. 
* 각 단계에서의 트리는 사용자가 선택한 필드(또는 필드들)에 따라 자동으로 정렬됩니다. 
* 새로운 멤버 함수들이 각각의 등록된 모델에 추가됩니다.
	* 트리에서의 위치를 변경하기
	* 부모, 친척, 자손들을 알아보기
	* 자손들을 헤아리기
	* 기타 트리-관련 동작 수행하기
* `TreeManager`라는 매니저가 모든 등록된 모델들에 추가됩니다. 이는 다음 멤버 함수를 제공합니다.
	* 노드(nodes)를 하나의 트리에서 내에서 이동하거나 다른 트리로 이동하기 
	* 노드를 트리의 어느 곳에서든 추가하기
	* 트리를 위한 MPTT 필드를 재구성하기 (django 외부에서 대량의 업데이트를 할 때 유용합니다?)
* 트리 모델을 위한 폼(From) 필드를 제공합니다(?)
* 트리 모델을 위한 유용한 함수들을 제공합니다. 
* 트리를 렌더링하기 위해 템플릿 태그(template tages)와 필터(filters)를 제공합니다.
* Django 관리자 인터페이스에서 트리를 보여주고 수정하기 위한 관리자(Admin) 클래스를 제공합니다.

### `django-mptt` 설치하기

`django-mptt`를 설치하는 방법에는 공식 버전을 다운받는 방법과 개발자 버전을 GitHub에서 클론 받는 방법, 이렇게 두가지가 있습니다.

일단 여기서는 공식 버전을 PyPI에서 다운받은 후 설치하는 방법을 설명합니다. 개발자 버전을 설치하는 방법은 `django-mptt`의 [공식 문서](http://django-mptt.github.io/django-mptt/install.html)를 참고하시면 될 것 같습니다.[^install]

[PyPI](https://pypi.python.org/pypi/django-mptt/)에서 Source가 압축된 파일인 **django-mptt-0.8.6.tar.gz (md5)** (또는 다운받는 시점에서의 최신 버전 파일)을 다운받습니다.[^pypi] 

> 다운로드 가능한 파일을 보면 타입이 Python Wheel인 파일도 있는데, 이 파일은 무슨 파일인지 아직 잘 모르겠습니다.

다운받은 파일의 압축을 풀고 적당한 곳에 둡니다. **setup.py**가 있는 곳으로 이동해서 아래의 명령을 실행합니다.

```
$ python setup.py install
```

그러면 패키지가 알아서 자동으로 설치됩니다. 패키지가 설치되는 위치는 Django를 설치하면 생기는 **.../site-packages/** 폴더에 **django_mptt-0.8.6-py3.5.egg**와 같은 이름으로 설치되는 것 같습니다.

#### 설치 확인하기

터미널에서 python을 실행하고 아래의 명령을 입력하면 설치가 제대로 된 것인지 확인할 수 있습니다.

```
>>> import mptt
>>> mptt.VERSION

(0, 8, 6)
```

이 글을 작성하는 시점에서는 버전이 **0.8.6** 입니다.

### `django-mptt` 프로젝트

**Caktus Group**에서 `django-mptt`를 이용하여 `django-treenav`를 만든 것 같습니다. 참고 자료를 보시면 **MPTT**에 대한 개념을 설명한 부분도 있습니다. [^caktusgroup]  [^django-treenav]

### 사용법 

#### {% recursetree %}

[{% recursetree %} doesn't insert children context into template](https://github.com/django-mptt/django-mptt/issues/139)

#### get_descendants

[django-mptt get_descendants for a list of nodes](http://stackoverflow.com/questions/5722767/django-mptt-get-descendants-for-a-list-of-nodes) : django-mptt의 `get_descendants` 함수의 사용 방법에 대한 질문 답변 글입니다.

#### CRUD with Django-MPTT 

[Django, how to do CRUD with django-mptt?](http://stackoverflow.com/questions/11508088/django-how-to-do-crud-with-django-mptt)

#### Many To Many 관계에서 첫번째 아이템 구하기

[Django Templating: how to access properties of the first item in a list](http://stackoverflow.com/questions/1479206/django-templating-how-to-access-properties-of-the-first-item-in-a-list) : 아래와 같은 코드를 활용할 수 있습니다. 

```
object.m2m_field.all.0.item_property
```

### 참고 자료

[^stackoverflow_1]: [Making a tree structure in django models?](http://stackoverflow.com/questions/15486520/making-a-tree-structure-in-django-models) : 다른 질문 답변 글입니다.

[^stackoverflow_2]: [Django hierarchical model list](http://stackoverflow.com/questions/8177207/django-hierarchical-model-list) : 세상 어딘가에는 누군가 나와 같은 고민을 하고 있다는 것을 알게되는 경우가 많은 것 같습니다.

[^django-mptt]: [django-mptt](https://github.com/django-mptt/django-mptt) : django-mptt 프로젝트의 GitHub 저장소 입니다. 

[^document]: [django-mptt의 공식 문서](http://django-mptt.github.io/django-mptt/index.html#)

[^sitepoint]: [Storing Hierarchical Data in a Database](https://www.sitepoint.com/hierarchical-data-database/) : The Adjacency List Model과 Modified Preorder Tree Traversal를 비교하고 분석한 글입니다.

[^install]: [Django MPTT documentation](http://django-mptt.github.io/django-mptt/install.html) : django-mptt를 설치하는 방법에 대해 설명한 공식 문서입니다.

[^groups]: [Django MPTT Discussion group](https://groups.google.com/forum/#!forum/django-mptt-dev) : django-mptt 프로젝트 관련 토론이 이루어지고 있는 구글 그룹입니다. 

[^pypi]: [django-mptt 0.8.6](https://pypi.python.org/pypi/django-mptt/) : 이 글을 작성하는 시점에서의 최신 버전은 0.8.6입니다.

[^caktusgroup]: [Modified Preorder Tree Traversal in Django](https://www.caktusgroup.com/blog/2016/01/04/modified-preorder-tree-traversal-django/) : django-mptt를 이용하여 django-treenav를 만든 내용을 소개하고 있습니다.

[^django-treenav]: [django-treenav](https://django-treenav.readthedocs.io/en/latest/) : django-mptt를 이용하여 만든 django-treenav 사이트입니다.

[^freeimage]: [Mysql + php 트리구조 재귀호출](http://www.freeimage.kr/tip_php/p40/804) : [Storing Hierarchical Data in a Database](https://www.sitepoint.com/hierarchical-data-database/) 글을 한글로 번역한 문서인 것 같습니다. 

[^mikehillyer]: [Managing Hierarchical Data in MySQL](http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/) : MPTT를 설명한 글입니다.

[Using Django-MPTT: lessons learned…](http://www.michelepasin.org/blog/2009/09/15/using-django-mptt-lessons-learned/) : Django-MPTT에 대한 설명을 정리한 곳입니다. 전체를 한번 훑어보면 좋을 것 같습니다. 약간 예전 자료이긴 하지만 내용은 좋을 것 같습니다. 막상 보니 별게 없군요. 너무 예전 자료인 것 같습니다. ㅜㅜ
