### Disqus 댓글 추가하기

#### disqus.html 파일 만들기
 
**_includes** 폴더에 **disqus.html** 파일을 만들고 아래와 같은 disqus 코드를 복사해 넣습니다. 주소는 각자의 것으로 치환해야 합니다. [Universal Embed Code directly from Disqus](https://django-test-blog.disqus.com/admin/universalcode/) 라는 것을 복사해 넣으면 된다고 합니다. [^disqus-universalcode]

그런데 disqus 코드는 사용하는 사람마다 조금씩 다른 것 같습니다. [^sgeos] [^aweekj] 이부분은 좀 더 알아봐야겠습니다. 

일단 Disqus 홈페이지에서 받은 새로운 disqus 코드를 사용합니다. 제가 사용한 최종 코드는 아래와 같습니다.

```
<div id="disqus_thread"></div>
<script>
		var disqus_shortname = '{{ site.disqus }}';

		(function() {  // DON'T EDIT BELOW THIS LINE
        var d = document, s = d.createElement('script');

        s.src = '//' + 'disqus_shortname' + '.disqus.com/embed.js';

        s.setAttribute('data-timestamp', +new Date());
        (d.head || d.body).appendChild(s);
    })();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>
```

원래 코드는 좀 더 긴데 처음부터 주석이 된 부분이 있습니다. 이 주석 처리한 부분을 사용해 보니 정작 작동하지 않았고, 주석 부분을 빼고 하니 잘 작동하는 것 같아서 주석 처리된 부분을 과감히 제거 했습니다.

> 참고로 위의 코드를 사용하려면 **_config.yml** 파일에 미리 `disqus` 변수를 만들어야 합니다. 이부분은 나중에 추가하도록 하겠습니다.
> 
> 기타 참고 자료도 한 번 살펴봅니다. [^perfectlyrandom] 참고를 안 한 이유가 있을 것입니다.

#### post.html 파일 수정하기

**_layouts** 폴더에 있는 **post.html** 파일의 끝에 아래와 같은 코드를 넣어 줍니다.

```
{% include disqus.html %}
```

#### 각 post의 YAML front matter 수정하기

아래와 같은 YAML front matter를 각 post 앞에 추가해 줍니다. 이는 포스트의 댓글을 사용할 수 있게 합니다.

```
comments: true
```

예를 들면 변경 후의 각 post 글은 아래와 같이 시작하게 될 것 입니다.

```
---
layout: post
comments: true
title:  "My Post Title"
date:   2017-01-15 00:00:00 +0900
categories: disqus jekyll comments
---
```

### 댓글 counter 추가하기

#### **default.html** 파일 수정하기

**_layouts** 폴더에 있는 **default.html** 파일에서 `</body>` 태그 앞에 아래와 같은 코드를 추가해 줍니다. 

```
<script id="dsq-count-scr" src="//django-test-blog.disqus.com/count.js" async></script>
```

#### **post.html** 파일 수정하기

댓글 카운터를 작동하려면 주소에 `#disqus_thread` 코드가 있어야 합니다. **_layouts** 폴더에 있는 **post.html** 에 아래와 같은 코드를 `<p class="post-meta">` 줄의 마지막에 추가합니다.

```
{% if page.comments %} • <a href="https://sgeos.github.io{{ page.url }}#disqus_thread">0 Comments</a>{% endif %}
```

#### **index.html** 파일 수정하기

**index.html** 파일에 아래와 같은 코드를 추가합니다. 이것은 각 포스트의 리스트에 댓글을 표시하기 위함입니다.

```
<a href="https://sgeos.github.io{{ post.url }}#disqus_thread">0 Comments</a>
```

포스트를  **_drafts/** 폴더에서 **_posts/** 폴더로 옮기면 포스트의 URL이 바뀝니다. 이것은 draft 파일에 추가된 모든 댓글을 사라지게 만듭니다. [Disqus Migration Tools](https://help.disqus.com/customer/portal/articles/286778-migration-tools) 은 댓글들을 새 URL로 옮기는데 사용됩니다. [^disqus-migration-tools]

### 참고 자료

[^disqus-universalcode]: [Setup Instructions for Universal Code](https://django-test-blog.disqus.com/admin/universalcode/#configuration-variables) : Disqus 공식 설명 문서입니다. 결국 이 자료를 잘 이해해야할 것 같습니다. 댓글 개수를 다는 부분도 설명되어 있습니다.

[^sgeos]: [Adding Disqus to a Jekyll Blog](http://sgeos.github.io/jekyll/disqus/2016/02/14/adding-disqus-to-a-jekyll-blog.html) : 설명이 잘 되어 있는 것 같습니다. 특히 각 포스트마다 댓글 개수를 표시하도록 하는 부분을 설명해 둔 점이 좋은 것 같습니다.

[^aweekj]: [Jekyll에 Disqus 추가하기](https://aweekj.github.io/2016-08-09/add-disqus-to-jekyll/) : 설명이 중간에 중단된 듯한 느낌입니다. 그래도 YAML frontmatter의 예시를 보여줘서 도움이 되었습니다.

[^perfectlyrandom]: [Adding Disqus to your Jekyll](http://www.perfectlyrandom.org/2014/06/29/adding-disqus-to-your-jekyll-powered-github-pages/) : 뭔가 보기 불편해서 여기서 뺀 것 같습니다. 나중에 다시 확인해 봐야 합니다.

[^disqus-migration-tools]: [Disqus Migration Tools](https://help.disqus.com/customer/portal/articles/286778-migration-tools)
