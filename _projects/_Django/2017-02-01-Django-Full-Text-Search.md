### 전체 문장 검색(Full text search)

```
장고 1.10 에서 새로 추가된 기능
```

**django.contrib.postgres.search** 모듈에 있는 데이터베이스 함수들은 PostgreSQL 의 전체 문장 검색 엔진( [full text search engine](https://www.postgresql.org/docs/current/static/textsearch.html) )을 보다 쉽게 사용할 수 있게 만듭니다.

이 문서의 예제는, 쿼리 만들기( [Making queries](https://docs.djangoproject.com/en/1.10/topics/db/queries/) ) 에서 만든 모델을 사용합니다.

> **함께 보기**
> 
> 검색 기능에 대해서 더 잘 이해하고 싶으면, [topic documentation](https://docs.djangoproject.com/en/1.10/topics/db/search/) 을 살펴보기 바랍니다.

#### `search` 조회

전체 문장 검색의 가장 간단한 예는 데이터베이스의 한 컬럼에 대해 한 용어를 검색하는 것입니다. 예를 들면:

```python
>>> Entry.objects.filter(body_text__search='Cheese')
[<Entry: Cheese on Toast recipes>, <Entry: Pizza Recipes>]
```

위에서는 **body_text** 필드로부터 데이터베이스에서 **to_tsvector** 를 만들고, 검색 용어 **'Cheese'** 로부터 **plainto_tsquery** 를 만드는데, 둘다 기본 데이터베이스 검색 설정을 사용합니다. 쿼리와 벡터를 일치시켜 결과를 얻습니다.

**search** 조회를 사용하려면, **'django.contrib.postgres'** 가 **INSTALLED_APPS** 에 있어야 합니다.

#### `SearchVector`

* class **SearchVector(** **expressions, config=None, weight=None* **)**

단일 필드 검색은 좋긴하지만 한계도 있습니다. 우리가 찾고있는 **Entry** 인스턴스는 `tagline` 필드를 가진 **Blog** 에 속합니다. 두 필드 모두를 쿼리하려면 SearchVector를 사용하십시오:

```python
>>> from django.contrib.postgres.search import SearchVector
>>> Entry.objects.annotate(
...     search=SearchVector('body_text', 'blog__tagline'),
... ).filter(search='Cheese')
[<Entry: Cheese on Toast recipes>, <Entry: Pizza Recipes>]
```

**SearchVector** 의 인자는 **Expression**(수식) 이나 필드의 이름이 될 수 있습니다. 여러 인자일 경우 공백 문자를 사용하면 같이 묶이게 되므로 검색 문서에는 모두가 포함됩니다.

**SearchVector** 객체는 함께 결합하여 재사용할 수 있습니다. 예를 들면 다음과 같습니다:

```python
>>> Entry.objects.annotate(
...     search=SearchVector('body_text') + SearchVector('blog__tagline'),
... ).filter(search='Cheese')
[<Entry: Cheese on Toast recipes>, <Entry: Pizza Recipes>]
```

**config** 와 **weight** 매개 변수에 대한 설명은 [Changing the search configuration](https://docs.djangoproject.com/en/1.10/ref/contrib/postgres/search/#postgresql-fts-search-configuration) 와 [Weighting queries](https://docs.djangoproject.com/en/1.10/ref/contrib/postgres/search/#postgresql-fts-weighting-queries) 를 보시기 바랍니다.

#### `SearchQuery`

* class **SearchQuery(** *value, config=None* **)**

**SearchQuery** 는 사용자가 제공 한 용어를 검색 쿼리 개체로 변환하며 데이터베이스가 이를 검색 벡터와 비교합니다. 기본적으로 사용자가 제공하는 모든 단어는 형태소 분석 알고리즘을 통과 한 다음 모든 결과 용어에 대해 일치하는 단어를 찾습니다.

더 많은 유연성을 제공하기 위해 **SearchQuery** 용어를 논리적으로 결합 할 수 있습니다:

```python
>>> from django.contrib.postgres.search import SearchQuery
>>> SearchQuery('potato') & SearchQuery('ireland')  # potato AND ireland
>>> SearchQuery('potato') | SearchQuery('penguin')  # potato OR penguin
>>> ~SearchQuery('sausage')  # NOT sausage
```

**config** 매개 변수에 대한 설명은 [Changing the search configuration](https://docs.djangoproject.com/en/1.10/ref/contrib/postgres/search/#postgresql-fts-search-configuration) 를 보시기 바랍니다.

#### `SearchRank`

* class **SearchRank(** *vector, query, weights=None* **)**

지금까지 벡터와 쿼리가 들어맞는 경우에 대한 결과를 반환했습니다. 때로는 관련성의 정도에 따라서 결과에 순서를 부여하고 싶을 수도 있습니다. PostgreSQL 은 순위 지정(ranking) 함수를 제공하는데, 쿼리 용어가 문서에 얼마나 자주 나타나는지, 용어가 문서에서 얼마나 가깝게 있는지, 그리고 문서의 일부분이 얼마나 중요한지를 고려하여 순서를 결정합니다. 더 잘 들어맞을 수록, 순위의 가치가 높아집니다. 관련성으로 순서를 매기는 것은 다음과 같습니다:

```python
>>> from django.contrib.postgres.search import SearchQuery, SearchRank, SearchVector
>>> vector = SearchVector('body_text')
>>> query = SearchQuery('cheese')
>>> Entry.objects.annotate(rank=SearchRank(vector, query)).order_by('-rank')
[<Entry: Cheese on Toast recipes>, <Entry: Pizza recipes>]
```

**weight** 매개 변수에 대한 설명은 [Weighting queries](https://docs.djangoproject.com/en/1.10/ref/contrib/postgres/search/#postgresql-fts-weighting-queries) 를 보시기 바랍니다.

### 검색 설정 변경하기

You can specify the **config** attribute to a **SearchVector** and **SearchQuery** to use a different search configuration. This allows using a different language parsers and dictionaries as defined by the database:

**SearchVector** 및 **SearchQuery** 에 대해서 **config** 속성을 지정하여 다른 검색 구성을 사용할 수 있습니다. 이렇게하면 데이터베이스에서 정의한 다른 언어 구문 분석기(parsers)와 사전(dictionaries)을 사용할 수 있습니다. (문장을 좀 더 매끄럽게 다음어야 합니다.)

```python
>>> from django.contrib.postgres.search import SearchQuery, SearchVector
>>> Entry.objects.annotate(
...     search=SearchVector('body_text', config='french'),
... ).filter(search=SearchQuery('œuf', config='french'))
[<Entry: Pain perdu>]
```

**config** 의 값은 다른 컬럼에도 저장 될 수 있습니다:

```python
>>> from django.db.models import F
>>> Entry.objects.annotate(
...     search=SearchVector('body_text', config=F('blog__language')),
... ).filter(search=SearchQuery('œuf', config=F('blog__language')))
[<Entry: Pain perdu>]
```

#### 쿼리(queries)에 가충치 부여하기 

모든 필드가 쿼리의 관련성에서 같은 값을 갖지는 않으므로, 이들을 결합하기 전에 여러 벡터들의 가중치를 따로 지정할 수 있습니다:

```python
>>> from django.contrib.postgres.search import SearchQuery, SearchRank, SearchVector
>>> vector = SearchVector('body_text', weight='A') + SearchVector('blog__tagline', weight='B')
>>> query = SearchQuery('cheese')
>>> Entry.objects.annotate(rank=SearchRank(vector, query)).filter(rank__gte=0.3).order_by('rank')
```

가중치는 다음의 네 문자 중 하나로 지정합니다: D, C, B, A. 기본으로는, 이 가중치 값은  각각 순서대로 **0.1**, **0.2**, **0.4**, 그리고 **1.0** 로 지정되어 있습니다. 다른 가중치를 사용하고 싶으면, 위에 있는 것과 같은 순서로 네 개의 실수로 된 리스트를  **SearchRank** 에 전달해서 **weights** 로 지정할 수 있습니다:

```python
>>> rank = SearchRank(vector, query, weights=[0.2, 0.4, 0.6, 0.8])
>>> Entry.objects.annotate(rank=rank).filter(rank__gte=0.3).order_by('-rank')
```

#### 성능

특별한 데이터베이스 구성은 이러한 함수들을 전혀 사용할 필요가 없지만, 몇 백 개가 넘는 레코드를 검색하는 경우, 성능 문제가 발생할 수 있습니다. 전체 텍스트 검색은 예컨대 정수의 크기를 비교하는 것보다 더 복잡한 작업(intensive process)입니다.

쿼리하는 모든 필드가 하나의 특정 모델에 포함되어있는 경우, 사용할 검색 벡터와 일치하는 기능 인덱스(functional index)를 만들 수 있습니다. PostgreSQL 문서의 [전체 텍스트 검색을 위한 색인 생성(creating indexes for full text search)](https://www.postgresql.org/docs/current/static/textsearch-tables.html#TEXTSEARCH-TABLES-INDEX) 을 보면 더 자세히 알 수 있습니다.

#### `SearchVectorField`

* class **SearchVectorField**

이 방법이 너무 느린 경우, 모델에 **SearchVectorField** 를 추가 할 수 있습니다. 예를 들어, [PostgreSQL 문서](https://www.postgresql.org/docs/current/static/textsearch-features.html#TEXTSEARCH-UPDATE-TRIGGERS) 에서 설명한대로 트리거가 채워져 있어야합니다. (이부분은 의미를 잘 모르겠습니다). 그런 다음 주석이 지정된 **SearchVector** 인 것처럼 필드를 쿼리 할 수 ​​있습니다.

```python
>>> Entry.objects.update(search_vector=SearchVector('body_text'))
>>> Entry.objects.filter(search_vector='cheese')
[<Entry: Cheese on Toast recipes>, <Entry: Pizza recipes>]
```

#### 삼각(Trigram) 닮음(similarity)

검색에 대한 또 다른 접근법은 삼각 닮음(trigram similarity)입니다. 삼각(trigram)은 3개의 연속 글자로 이루어진 그룹입니다. `trigram_similar` 조회와 더불어, 몇 가지 다른 표현식을 사용할 수 있습니다.

이들을 사용하려면, PostgreSQL에서 [pg_trgm extension](https://www.postgresql.org/docs/current/static/pgtrgm.html) 을 활성화해야 합니다. **TrigramExtension** 이주(migration) 기능을 사용하여 설치할 수 있습니다.

#### `TrigramSimilarity`

* class **TrigramSimilarity(** *expression, string, \*\*extra* **)**

```
장고 1.10 에서 새로 추가된 기능
```

필드 이름 또는 표현식, 그리고 문자열 또는 표현식을 허용합니다. 두 인수 사이의 삼각 닮음(trigram similarity)을 반환합니다.

사용 예:

```python
>>> from django.contrib.postgres.search import TrigramSimilarity
>>> Author.objects.create(name='Katy Stevens')
>>> Author.objects.create(name='Stephen Keats')
>>> test = 'Katie Stephens'
>>> Author.objects.annotate(
...     similarity=TrigramSimilarity('name', test),
... ).filter(similarity__gt=0.3).order_by('-similarity')
[<Author: Katy Stevens>, <Author: Stephen Keats>]
```

#### TrigramDistance

* class **TrigramDistance(** *expression, string, \*\*extra* **)**

```
장고 1.10 에서 새로 추가된 기능
```

필드 이름 또는 표현식, 그리고 문자열 또는 표현식을 허용합니다. 두 인수 사이의 삼각 거리(trigram similarity)를 반환합니다.

사용 예:

```python
>>> from django.contrib.postgres.search import TrigramDistance
>>> Author.objects.create(name='Katy Stevens')
>>> Author.objects.create(name='Stephen Keats')
>>> test = 'Katie Stephens'
>>> Author.objects.annotate(
...     distance=TrigramDistance('name', test),
... ).filter(distance__lte=0.7).order_by('distance')
[<Author: Katy Stevens>, <Author: Stephen Keats>]
``` 

- - -
이전글 : [Database migration operations](https://docs.djangoproject.com/en/1.10/ref/contrib/postgres/operations/)  
- - -
이후글 : [Validators](https://docs.djangoproject.com/en/1.10/ref/contrib/postgres/validators/)
- - - 