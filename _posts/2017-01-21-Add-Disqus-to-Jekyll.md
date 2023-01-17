---
layout: post
pagination: 
  enabled: true
comments: true
title:  "Jekyll: Disqus 연결부터 마이그레이션까지"
date:   2017-01-21 02:10:30 +0900
categories: Blog Jekyll Disqus Migration
redirect_from: "/blog/jekyll/disqus/migration/2017/01/20/Add-Disqus-to-Jekyll.html"
---

> 이 글은 Jekyll 블로그에 Disqus 를 이용하여 댓글 시스템을 연결하는 방법을 정리한 것입니다.
>
> Jekyll 로 블로그를 제작하고 설정하는 방법에 대한 전체 내용은 [Jekyll: 블로그 제작의 모든 것]({% post_url 2020-05-06-Jekyll-Blog %}) 을 보도록 합니다.

## Jekyll: Disqus 연결부터 마이그레이션까지

[Jekyll](https://jekyllrb.com) 블로그는 정적 페이지로만 구성되어 있습니다. [^jekyllrb] 따라서 자체적으로는 댓글 시스템 같은 동적 요소를 만들 수 없습니다. 그래서 보통 Jekyll 블로그에는 [Disqus](https://disqus.com) 와 같은 서비스를 추가해서 댓글 시스템을 구현합니다. [^disqus]

여기서는 Jekyll 블로그에 Disqus 를 추가하고, 댓글 카운팅 기능을 추가한 후, 마지막으로 마이그레이션을 수행하는 방법을 정리하도록 합니다.

이 글을 작성할 때는 Disqus 공식 홈페이지의 설명을 기준으로  [Brendan A R Sechter](http://sgeos.github.io) 님의 블로그 글인 [Adding Disqus to a Jekyll Blog](http://sgeos.github.io/jekyll/disqus/2016/02/14/adding-disqus-to-a-jekyll-blog.html) 글을 많이 참고 했습니다. [^sgeos]

### Disqus 에 자신의 블로그 등록하기

먼저 [Disqus](https://disqus.com) 에 가입하고 자신의 블로그를 등록합니다.

블로그를 등록하는 것은 **Admin > Start > Installing Disqus > Create a Site** 메뉴를 선택해서 내용을 입력한 다음 **Create Site** 버튼을 누르면 됩니다.

> 이 시점에 입력하는 내용은 최지훈님 블로그 중에서 [jekyll 블로그에 Disqus 붙이기](https://cjh5414.github.io/Disqus/) 라는 글에 설명이 잘 되어있습니다. [^cjh5414]

그러면 자신의 블로그 플랫폼을 선택하는 화면이 나오는데 이 글을 쓰는 시점에서는 Disqus 가 Jekyll 을 지원하므로 **What platform is your site on?** 페이지에서 Jekyll 을 선택합니다.

### Jekyll 에 설치하기 위해 따라야할 지시들  

#### 1. **YAML Front Matter** 에 comments 변수 추가하기

첫번째는 "YAML Front Matter" 에 `comments` 라는 변수를 추가하고 그 값을 `true` 로 지정하는 것입니다. Disqus 에 나오는 예시는 다음과 같습니다.

```yaml
---
layout: default
comments: true
# other options
---
```

"YAML Front Matter" 라는 것은 각각의 포스트 글 앞에 붙여주는 양식과 같은 것입니다. [^xho95-post]  그러니까 Jekyll 블로그에 포스트를 작성할 때 댓글 시스템을 연동 하고 싶으면 해당 포스트의 "YAML Front Matter" 에 `comments: true` 를 추가하면 되는 것입니다.

> Disqus 공식 문서에 따르면 `comments: false` 로 설정하거나 `comments` 변수를 포함하지 않음으로써 댓글 시스템을 페이지 단위로 비활성화 시킬 수 있다고 합니다.

현재 이 글의  "YAML Front Matter" 는 다음과 같습니다.

```yaml
---
layout: post
pagination: 
  enabled: true
comments: true
title:  "Jekyll: Disqus 연결부터 마이그레이션까지"
date:   2017-01-21 02:10:30 +0900
categories: Blog Jekyll Disqus Migration
---
```

#### 2. **Universal Embed Code** 붙여 주기

블로그의 적당한 템플릿 (template) 에다가  아래의 "Universal Embed Code" 를 복사해서 붙여 넣습니다. 이 때 아래의 코드를 `{% raw %}{% if page.comments %}{% endraw %}` 와 `{% raw %}{% endif %}{% endraw %}` 코드로 감싸줍니다.

```html
<div id="disqus_thread"></div>
<script>
/**
 *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
 *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables
 */

/*
var disqus_config = function () {
	this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
	this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};
 */

(function() { // DON'T EDIT BELOW THIS LINE
	var d = document, s = d.createElement('script');
	s.src = '//test-site-znstiaaoqo.disqus.com/embed.js';
	s.setAttribute('data-timestamp', +new Date());
	(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
```

[Adding Disqus to a Jekyll Blog](http://sgeos.github.io/jekyll/disqus/2016/02/14/adding-disqus-to-a-jekyll-blog.html) 에서는 **_includes** 폴더에 **disqus.html** 파일을 새로 만들어서 이 파일에 "Universal Embed Code" 를 복사해 넣고 있습니다.

이렇게 하는데는 이유가 있는데, **_includes** 폴더는 Jekyll 에서 특정 페이지나 포스트에 반복해서 넣을 수 있는 부분들을 넣는 곳이기 때문입니다. 따라서 **disqus.html** 파일이 **_includes** 폴더에 있으면 템플릿 코드를 사용해서 모든 포스트 글에 댓글 코드를 넣을 수 있게 됩니다.

> 한편, 위 코드에서 RECOMMENDED CONFIGURATION VARIABLES 부분은 블로그의 CMS (Contents Menage System) 이나 플랫폼의 동적 값을 사용하여 편집하는 것을 추천한다고 합니다. Disqus의 [Use Configuration Variables to Avoid Split Threads and Missing Comments](https://help.disqus.com/customer/en/portal/articles/2158629) 라는 문서를 보면, `identifier` 와 `url` 변수를 지정함으로써 쓰레드의 중복을 피할 수 있다고 설명하고 있습니다. [^help-2158629]

제가 작성한 **disqus.html** 파일의 최종 결과는 아래와 같습니다.

```html
{% raw %}{% if page.comments %}{% endraw %}
<div id="disqus_thread"></div>
<script>
/**
 *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
 *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables
 */

var disqus_config = function () {
	this.page.url = "{% raw %}{{ site.url }}{{ page.url }}{% endraw %}";  // Replace PAGE_URL with your page's canonical URL variable
	this.page.identifier = "{% raw %}{{ page.id }}{% endraw %}"; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};

var disqus_shortname = '{% raw %}{{ site.disqus }}{% endraw %}';

(function() {  // DON'T EDIT BELOW THIS LINE
	var d = document, s = d.createElement('script');
	s.src = '//' + 'disqus_shortname' + '.disqus.com/embed.js';
	s.setAttribute('data-timestamp', +new Date());
	(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>
{% raw %}{% endif %}{% endraw %}
```

위의 코드를 보면 `disqus_shortname` 이라는 변수를 사용했는데, 이 변수의 값은 **Admin > Settings > General** 메뉴의 **Configure Disqus for Your Site** 페이지에 있는 "Shortname" 에서 알려주는 문자열을 복사해서 사용하면 됩니다.

> 단, "Shortname" 값에는 함정이 있는데 이 값은 **Configure Disqus** 메뉴에서 "Website URL" 값을 넣은 다음에 **Complete Setup** 버튼을 눌러야  Disqus 가 알아서 만들어 주는 값이라는 것입니다. 따라서 Disqus의 설명과 "Shortname" 값을 동시에 볼 수는 없습니다. 일단  "Shortname" 값을 만들고 다시 Admin 설명을 따라서 진행해야 합니다.

저는 "Shortname" 에서 알려주는 문자열을 **_config.yml** 파일에 새로 `disqus` 변수를 만들고 여기에 할당해서 사용한 것인데 꼭 이렇게 안해도 될 것 같습니다.

그리고 `this.page.url`에는 반드시 해당 페이지의 절대 경로를 넣어야 한다고 합니다. 저도 이 글을 작성하면서 처음에는 실수를 했었는데 위와 같이 `{% raw %}{{ site.url }}{{ page.url }}{% endraw %}` 로 해서 해결했습니다. `{% raw %}{{ site.url }}{% endraw %}` 대신에 `http://xho95.github.io` 처럼 실제 site 주소를 입력해도 상관은 없습니다. [^disqus-3114894823]

#### 3. **disqus.html** 파일 포함하기

앞에서 **disqus.html** 파일을 만들고 "Universal Embed Code" 를 작성했습니다. 이제 이 코드를 각 포스트 글에 넣어줍니다.

이를 위해서는 **_layouts** 폴더에 있는 **post.html** 파일의 끝에 아래와 같은 코드를 넣으면 됩니다.

```html
{% raw %}{% include disqus.html %}{% endraw %}
```

이렇게 하면 모든 포스트 글의 마지막에 **disqus.html** 파일이 덧붙여집니다. 이제 모든 포스트마다 댓글 시스템이 연결되는 것을 확인할 수 있습니다.

### 댓글 counter 추가하기

이제 댓글 카운터를 각 포스트 글과 포스트 리스트에 추가하는 방법을 알아봅니다.

#### JavaScript 코드 추가하기

**_layouts** 폴더에 있는 **default.html** 파일에서 `</body>` 태그 바로 앞에 아래와 같은 코드를 추가해 줍니다.

```html
<script id="dsq-count-scr" src="//django-test-blog.disqus.com/count.js" async></script>
```

위에서 `django-test-blog` 부분은 자기 블로그의 **Shortname** 을 입력하면 됩니다.

저는 앞서 설명드린 것과 같이 **_config.yml** 파일에 `disqus` 변수를 만들고 **Shortname** 값을 저장했기 때문에 아래와 같이 입력했습니다.

```html
<script id="dsq-count-scr" src="//{% raw %}{{ site.disqus }}{% endraw %}.disqus.com/count.js" async></script>
```

#### 링크에 `#disqus_thread` 추가하기

`#disqus_thread` 를 링크의 `href` 속성에 추가합니다. 이것은 Disqus 가 댓글의 개수를 헤아릴 때 어떤 링크를 찾아봐야 할 지를 알려줍니다. 예를 들어 `<a href="http://foo.com/bar.html#disqus_thread"> Link </a>` 와 같이 하면 됩니다.

**_layouts** 폴더에 있는 **post.html** 파일에 아래와 같은 코드를 추가합니다.

```html
{% raw %}{% if page.comments %}{% endraw %} • <a href="https://xho95.github.io{% raw %}{{ page.url }}{% endraw %}#disqus_thread">0 Comments</a>{% raw %}{% endif %}{% endraw %}
```

> 추가하는 위치는 본인 마음이지만 [Adding Disqus to a Jekyll Blog](http://sgeos.github.io/jekyll/disqus/2016/02/14/adding-disqus-to-a-jekyll-blog.html) 글을 참고해서 `<p class="post-meta">` 줄의 마지막 `</p>` 앞에 추가하도록 합니다.

이렇게 하면 모든 포스트 글 링크마다 `#disqus_thread` 값이 추가됩니다.

#### 포스트 리스트에 댓글 카운터 추가하기

포스트의 리스트에 댓글 개수를 표시하기 위해서는 **index.html** 파일에 아래와 같은 코드를 추가합니다. 위치는 `<span class="post-meta">` 줄의 마지막 `</span>` 앞에 추가하도록 합니다.

```html
<a href="https://xho95.github.io{% raw %}{{ post.url }}{% endraw %}#disqus_thread">0 Comments</a>
```

이제 블로그의 포스트 리스트에 각 포스트 마다 몇개의 댓글이 달려있는지 확인할 수 있습니다.

### Disqus 데이터베이스 마이그레이션 하기

블로그를 수정하는 과정에서 블로그의 주소가 바뀌거나 블로그의 특정 포스트 글의 주소가 바뀌는 것은 일상적으로 일어날 수 있는 일입니다. 다만 Jekyll 블로그의 경우 댓글 시스템이 자체 내장된 것이 아니라 Disqus 를 사용해서 링크로 연결된 구조라는 것이 문제가 됩니다.

즉, 포스트 글의 주소가 바뀌면 해당 글에 연결된 댓글들이 연결이 안되서 사라지게 됩니다. 물론, 데이터베이스에서 삭제되는 것은 아니니 복구는 가능합니다.

> 저도 이 문제를 겪다가 뒤늦게 마이그레이션을 수행하면서 이 글을 작성하게 되었습니다.

#### Disqus Migration Tools 개요

이렇게 포스트 글과 댓글이 연결이 안될 경우 사용하는 것이 [Disqus Migration Tools](https://help.disqus.com/customer/portal/articles/286778-migration-tools) 입니다. [^disqus-migration-tools] Disqus의 마이그레이션 툴은 댓글들을 특정 쓰레드에서 다른 쓰레드로 옮겨줍니다.

마이그레이션 툴은 다음과 같은 경우에 사용할 수 있습니다:

* 도메인(domain)을 바꿀 경우. 예: 웹 사이트를 `www.old-url.com` 에서 `new-awesome-url.com` 로 바꿀 경우
* CMS 나 블로그 시스템을 바꿔서 특정 글의 URL 구조가 달라질 경우. 예: `Blogger` 에서 `Wordpress`로 옮길 경우.
* 두 개의 댓글 쓰레드가 하나로 합쳐져야 할 경우.

Disqus의 마이그레이션 툴은 **Admin > Community > Migration Tools** 메뉴에서 찾을 수 있습니다. 그러면 **Migrate Threads** 페이지가 나타나는데 여기서 세 가지의 경우 중에서 본인에게 해당하는 방법을 택해서 진행하면 됩니다.

여기서는 블로그를 하다가 포스트 글의 주소가 바뀌는 경우에 해당하는 솔루션인 "Upload a URL map" 에 대해서 설명하도록 합니다. 나머지 경우의 경우에도 비슷하게 진행하면 될 것입니다.

#### URL 맵 업로드하기 방법

이 방법은 URL 경로 (`.com` 이후의 모든 것) , 프로토콜 (`http://` 또는 `https://` 등), 및 도메인을 변경하거나  다른 좀 더 복잡한 마이그레이션을 수행할 때 사용합니다.

예를 들어 `http://example.com/old-path/old/post.html` 주소가 `http://example.com/new-path/new/post.html` 처럼 바뀌게 되었을 때 사용합니다.

**Start URL mapper** 버튼을 누릅니다.

그러면 파일을 업로드 할 수 있는 화면이 나타납니다. 이전 URL 과 새 URL 을 연결짓는 CSV 포맷의 파일을 만든 다음에 업로드 하면 됩니다.

그전에 `you can download a CSV here` 부분을 눌러서 Disqus 에서 가지고 있는 URL 을 담은 파일을 받습니다. 이 파일을 아래와 같이 이전 URL 과 새 URL 을 쉼표(`,`)로 연결하는 방식으로 수정합니다.

```
http://example.com/old-path/old/posta.html, http://example.com/new-path/new/posta.html
```

이렇게 수정한 `...-links.csv` 파일을 업로드 하면 연결이 끊긴 댓글들을 새 글들로 옮길 수 있습니다.

### 고찰하기

우선 Disqus 의 **Universal Embed Code** 라는 것이 사용하는 사람마다 조금씩 다릅니다. [^aweekj] 하지만 크게 보면 대동소이한 것 같습니다.

이 부분은 [Use Configuration Variables to Avoid Split Threads and Missing Comments](https://help.disqus.com/customer/en/portal/articles/2158629) 글을 보고 이해한 다음에  내용을 추가할 수 있도록 하겠습니다.

한편으로는 이 글을 작성하면서 소스 코드로 넣은 템플릿 코드가 자꾸 실행되어서 문제가 됐는데, 이것은 `{% raw %}{% raw %}{% endraw %}` 태그로 해결할 수 있었습니다. [^stackoverflow-24102498]

### 참고 자료

[^jekyllrb]: [Jekyll](https://jekyllrb.com) : Jekyll 공식 홈페이지입니다. 첫페이지에 정적 웹사이트를 만든다고 명시해두고 있습니다.

[^disqus]: [Disqus](https://disqus.com) : Disqus 공식 홈페이지입니다. 일단 가입을 해서 계정을 만들고 사이트를 등록해야 합니다.

[^sgeos]: [Adding Disqus to a Jekyll Blog](http://sgeos.github.io/jekyll/disqus/2016/02/14/adding-disqus-to-a-jekyll-blog.html) : 설명이 잘 되어 있는 것 같습니다. 특히 각 포스트마다 댓글 개수를 표시하도록 하는 부분을 설명해 둔 점이 좋은 것 같습니다.

[^cjh5414]: [jekyll 블로그에 Disqus 붙이기](https://cjh5414.github.io/Disqus/) : 따라하기 쉽도록 사용법이 그림으로 잘 설명되어 있는 최지훈님 블로그의 글입니다. 다만 해당 글이 쓰여졌을 당시에는 Disqus 에서 Jekyll 을 지원하지 않았던 것 같습니다. 지금은 Disqus 에서 Jekyll 을 지원하므로 조금 다르게 할 수 있습니다.

[^xho95-post]: "YAML Front Matter" 에 대해서는 제 블로그의 다른 글인 [MarkDown 문서를 이용하여 블로그에 포스트하기]({% post_url 2016-01-12-Post-a-new-MarkDown-file %}) 글에서 **Front matter 설정하기** 부분을 참고하시기 바랍니다.

[^help-2158629]: [Use Configuration Variables to Avoid Split Threads and Missing Comments](https://help.disqus.com/customer/en/portal/articles/2158629) : 쓰레드의 중복 문제를 피하는 방법에 대해서 설명한 글입니다. 솔직히 저도 아직 읽어보진 않았습니다. 나중에 내용을 좀 더 알게 되면 블로그 글에 추가할 수 있도록 하겠습니다.

[^disqus-3114894823]: [Bug Reports & Feedback: how can I reconnect my blog with the original disqus account?](https://disqus.com/home/channel/discussdisqus/discussion/channel-discussdisqus/bug_reports_feedback_how_can_i_reconnect_my_blog_with_the_original_disqus_account/#comment-3114894823) : 결국 제 실수였는데, `this.page.url` 를 프로토콜까지 포함한 절대 경로로 사용해야한다는 답변 글입니다.

[^disqus-migration-tools]: [Disqus Migration Tools](https://help.disqus.com/customer/portal/articles/286778-migration-tools)

[^aweekj]: [Jekyll에 Disqus 추가하기](https://aweekj.github.io/2016-08-09/add-disqus-to-jekyll/) : 설명이 중간에 중단된 듯한 느낌입니다. 그래도 YAML frontmatter의 예시를 보여줘서 도움이 되었습니다.

[^help-565624]: [Adding comment count links to your home page](https://help.disqus.com/customer/portal/articles/565624)

[^stackoverflow-24102498]: [Escaping double curly braces inside a markdown code block in Jekyll](http://stackoverflow.com/questions/24102498/escaping-double-curly-braces-inside-a-markdown-code-block-in-jekyll) : Jekyll 엔진이 특정 템플릿 코드를 실행해 버리는 것을 막는 방법에 대해서 소개하고 있습니다.
