Jekyll 블로그는 정적 페이지로만 구성되어 있습니다. [^jekyllrb] 따라서 자체적으로는 댓글 시스템 같은 동적 요소를 만들 수 없습니다. 그래서 보통 Jekyll 블로그에는 [Disqus](https://disqus.com) 댓글 시스템을 연결해서 사용합니다. [^disqus]

여기서는 Jekyll 블로그에 Disqus 댓글 시스템을 추가하는 방법에 대해서 알아봅니다. 

> 댓글 시스템이라는 말을 대체할 용어를 찾아봅시다.

막상 자료를 정리하려고 보니까 의외로 Disqus 공식 홈페이지의 문서가 너무 간단한 것 같아서 [Brendan A R Sechter](http://sgeos.github.io) 님의  블로그 글에서 [Adding Disqus to a Jekyll Blog](http://sgeos.github.io/jekyll/disqus/2016/02/14/adding-disqus-to-a-jekyll-blog.html) 라는 글을 많이 참고 했습니다. [^sgeos]

### Disqus 댓글 추가하기

먼저 [Disqus](https://disqus.com)에 가입하고 자신의 블로그를 등록해야 합니다.

Admin 

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

위의 코드를 날짜 부분 뒤에 넣어줍니다. 일단 저는 아래와 같이 했습니다.했습니다.

```
...
<span class="post-meta">{{ post.date | date: "%b %-d, %Y" }} • <a href="https://xho95.github.io{{ post.url }}#disqus_thread">0 Comments</a></span>
...
```

이제 블로그 첫페이지에서 리스트에 각 포스트 마다 몇개의 댓글이 달려있는지 확인할 수 있습니다.

### 고찰하기 

참고 자료의 블로그에 다음과 같은 내용이 있습니다.

포스트를  **_drafts/** 폴더에서 **_posts/** 폴더로 옮기면 포스트의 URL이 바뀝니다. 이것은 draft 파일에 추가된 모든 댓글을 사라지게 만듭니다. [Disqus Migration Tools](https://help.disqus.com/customer/portal/articles/286778-migration-tools) 은 댓글들을 새 URL로 옮기는데 사용됩니다. [^disqus-migration-tools]

일단 생각해보면 draft 상태에서 댓글이 달릴 일이 없을 것 같아서 별 문제는 안될 것으로 보입니다만 이런 글이 있는데는 이유가 있을 것입니다. 좀 더 알아봐야할 것 같습니다.

### 참고 자료

[^jekyllrb]: [Jekyll](https://jekyllrb.com) : Jekyll 공식 홈페이지입니다. 첫페이지에 정적 웹사이트를 만든다고 명시해두고 있습니다.

[^disqus]: [Disqus](https://disqus.com) : Disqus 공식 홈페이지입니다. 일단 가입을 해서 계정을 만들고 사이트를 등록해야 합니다.

[^sgeos]: [Adding Disqus to a Jekyll Blog](http://sgeos.github.io/jekyll/disqus/2016/02/14/adding-disqus-to-a-jekyll-blog.html) : 설명이 잘 되어 있는 것 같습니다. 특히 각 포스트마다 댓글 개수를 표시하도록 하는 부분을 설명해 둔 점이 좋은 것 같습니다.

[^disqus-universalcode]: [Setup Instructions for Universal Code](https://django-test-blog.disqus.com/admin/universalcode/#configuration-variables) : Disqus 공식 설명 문서입니다. 결국 이 자료를 잘 이해해야할 것 같습니다. 댓글 개수를 다는 부분도 설명되어 있습니다.

[^aweekj]: [Jekyll에 Disqus 추가하기](https://aweekj.github.io/2016-08-09/add-disqus-to-jekyll/) : 설명이 중간에 중단된 듯한 느낌입니다. 그래도 YAML frontmatter의 예시를 보여줘서 도움이 되었습니다.

[^perfectlyrandom]: [Adding Disqus to your Jekyll](http://www.perfectlyrandom.org/2014/06/29/adding-disqus-to-your-jekyll-powered-github-pages/) : 뭔가 보기 불편해서 여기서 뺀 것 같습니다. 나중에 다시 확인해 봐야 합니다.

[^disqus-migration-tools]: [Disqus Migration Tools](https://help.disqus.com/customer/portal/articles/286778-migration-tools)
