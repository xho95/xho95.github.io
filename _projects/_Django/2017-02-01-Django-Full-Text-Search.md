### 전체 문장 검색(Full text search)

```
장고 1.10 에서 새로 추가된 기능
```

**django.contrib.postgres.search** 모듈에 있는 데이터베이스 함수들은 PostgreSQL 의 전체 문장 검색 엔진( [full text search engine](https://www.postgresql.org/docs/current/static/textsearch.html) )을 보다 쉽게 사용할 수 있게 만듭니다.

이 문서의 예제는, 쿼리 만들기( [Making queries](https://docs.djangoproject.com/en/1.10/topics/db/queries/) ) 에서 만든 모델을 사용합니다.

> **함께 보기**
> 
> 검색 기능에 대해서 더 잘 이해하고 싶으면, [topic documentation](https://docs.djangoproject.com/en/1.10/topics/db/search/) 을 살펴보기 바랍니다.

#### The `search` lookup

전체 문장 검색의 가장 간단한 예는 데이터베이스의 한 컬럼에 대해 한 용어를 검색하는 것입니다. 예를 들면:

```python
>>> Entry.objects.filter(body_text__search='Cheese')
[<Entry: Cheese on Toast recipes>, <Entry: Pizza Recipes>]
```

This creates a **to_tsvector** in the database from the **body_text** field and a **plainto_tsquery** from the search term **'Cheese'**, both using the default database search configuration. The results are obtained by matching the query and the vector.

To use the **search** lookup, **'django.contrib.postgres'** must be in your **INSTALLED_APPS**.

#### `SearchVector`

* class **SearchVector(** **expressions, config=None, weight=None* **)**

Searching against a single field is great but rather limiting. The Entry instances we’re searching belong to a Blog, which has a tagline field. To query against both fields, use a SearchVector:

```python
>>> from django.contrib.postgres.search import SearchVector
>>> Entry.objects.annotate(
...     search=SearchVector('body_text', 'blog__tagline'),
... ).filter(search='Cheese')
[<Entry: Cheese on Toast recipes>, <Entry: Pizza Recipes>]
```

The arguments to SearchVector can be any Expression or the name of a field. Multiple arguments will be concatenated together using a space so that the search document includes them all.

SearchVector objects can be combined together, allowing you to reuse them. For example:

```python
>>> Entry.objects.annotate(
...     search=SearchVector('body_text') + SearchVector('blog__tagline'),
... ).filter(search='Cheese')
[<Entry: Cheese on Toast recipes>, <Entry: Pizza Recipes>]
```

See Changing the search configuration and Weighting queries for an explanation of the config and weight parameters.

#### `SearchQuery`

* class **SearchQuery(** *value, config=None* **)**

SearchQuery translates the terms the user provides into a search query object that the database compares to a search vector. By default, all the words the user provides are passed through the stemming algorithms, and then it looks for matches for all of the resulting terms.

SearchQuery terms can be combined logically to provide more flexibility:

```python
>>> from django.contrib.postgres.search import SearchQuery
>>> SearchQuery('potato') & SearchQuery('ireland')  # potato AND ireland
>>> SearchQuery('potato') | SearchQuery('penguin')  # potato OR penguin
>>> ~SearchQuery('sausage')  # NOT sausage
```

See Changing the search configuration for an explanation of the config parameter.

#### `SearchRank`

* class **SearchRank(** *vector, query, weights=None* **)**

So far, we’ve just returned the results for which any match between the vector and the query are possible. It’s likely you may wish to order the results by some sort of relevancy. PostgreSQL provides a ranking function which takes into account how often the query terms appear in the document, how close together the terms are in the document, and how important the part of the document is where they occur. The better the match, the higher the value of the rank. To order by relevancy:

```python
>>> from django.contrib.postgres.search import SearchQuery, SearchRank, SearchVector
>>> vector = SearchVector('body_text')
>>> query = SearchQuery('cheese')
>>> Entry.objects.annotate(rank=SearchRank(vector, query)).order_by('-rank')
[<Entry: Cheese on Toast recipes>, <Entry: Pizza recipes>]
```

See Weighting queries for an explanation of the weights parameter.

### Changing the search configuration

You can specify the config attribute to a SearchVector and SearchQuery to use a different search configuration. This allows using a different language parsers and dictionaries as defined by the database:

```python
>>> from django.contrib.postgres.search import SearchQuery, SearchVector
>>> Entry.objects.annotate(
...     search=SearchVector('body_text', config='french'),
... ).filter(search=SearchQuery('œuf', config='french'))
[<Entry: Pain perdu>]
```

The value of config could also be stored in another column:

```python
>>> from django.db.models import F
>>> Entry.objects.annotate(
...     search=SearchVector('body_text', config=F('blog__language')),
... ).filter(search=SearchQuery('œuf', config=F('blog__language')))
[<Entry: Pain perdu>]
```

#### Weighting queries

Every field may not have the same relevance in a query, so you can set weights of various vectors before you combine them:

```python
>>> from django.contrib.postgres.search import SearchQuery, SearchRank, SearchVector
>>> vector = SearchVector('body_text', weight='A') + SearchVector('blog__tagline', weight='B')
>>> query = SearchQuery('cheese')
>>> Entry.objects.annotate(rank=SearchRank(vector, query)).filter(rank__gte=0.3).order_by('rank')
```

The weight should be one of the following letters: D, C, B, A. By default, these weights refer to the numbers 0.1, 0.2, 0.4, and 1.0, respectively. If you wish to weight them differently, pass a list of four floats to SearchRank as weights in the same order above:

```python
>>> rank = SearchRank(vector, query, weights=[0.2, 0.4, 0.6, 0.8])
>>> Entry.objects.annotate(rank=rank).filter(rank__gte=0.3).order_by('-rank')
```

#### Performance

Special database configuration isn’t necessary to use any of these functions, however, if you’re searching more than a few hundred records, you’re likely to run into performance problems. Full text search is a more intensive process than comparing the size of an integer, for example.

In the event that all the fields you’re querying on are contained within one particular model, you can create a functional index which matches the search vector you wish to use. The PostgreSQL documentation has details on creating indexes for full text search.

#### `SearchVectorField`

* class SearchVectorField

If this approach becomes too slow, you can add a SearchVectorField to your model. You’ll need to keep it populated with triggers, for example, as described in the PostgreSQL documentation. You can then query the field as if it were an annotated SearchVector:

```python
>>> Entry.objects.update(search_vector=SearchVector('body_text'))
>>> Entry.objects.filter(search_vector='cheese')
[<Entry: Cheese on Toast recipes>, <Entry: Pizza recipes>]
```

#### Trigram similarity

Another approach to searching is trigram similarity. A trigram is a group of three consecutive characters. In addition to the trigram_similar lookup, you can use a couple of other expressions.

To use them, you need to activate the pg_trgm extension on PostgreSQL. You can install it using the TrigramExtension migration operation.

#### `TrigramSimilarity`

class TrigramSimilarity(expression, string, **extra)[source]¶
New in Django 1.10.
Accepts a field name or expression, and a string or expression. Returns the trigram similarity between the two arguments.

Usage example:

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

* class TrigramDistance(expression, string, **extra)

```
장고 1.10 에서 새로 추가된 기능
```

Accepts a field name or expression, and a string or expression. Returns the trigram distance between the two arguments.

Usage example:

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