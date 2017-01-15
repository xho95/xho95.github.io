### disqus.html 파일 만들기
 
**_includes** 폴더에 **disqus.html** 파일을 만들고 아래와 같은 disqus 코드를 복사해 넣습니다. 주소는 각자의 것으로 치환해야 합니다. [Universal Embed Code directly from Disqus](https://django-test-blog.disqus.com/admin/universalcode/) 라는 것을 복사해 넣으면 된다고 합니다. 

disqus 코드가 그동안 변한 것 같습니다. 원래 제가 쓰던 코드는 아래와 같습니다 .

```
{% if site.disqus %}
<div class="comments">
	<div id="disqus_thread"></div>
	<script type="text/javascript">

	    var disqus_shortname = '{{ site.disqus }}';

	    (function() {
	        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
	        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
	        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
	    })();

	</script>
	<noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
</div>
{% endif %}
```

그런데 참고 자료에 있는 코드는 아래와 같습니다. [^sgeos]

```
{% if page.comments %}
<div id="disqus_thread"></div>
<script>
	var disqus_config = function () {
		this.page.url = "http://BLOG.host.com{{ page.url }}"; // <--- use canonical URL
		this.page.identifier = "{{ page.id }}";
	};
	(function() { // DON'T EDIT BELOW THIS LINE
		var d = document, s = d.createElement('script');
		s.src = '//SHORTNAME.disqus.com/embed.js'; // <--- use Disqus shortname
		s.setAttribute('data-timestamp', +new Date());
		(d.head || d.body).appendChild(s);
	})();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>
{% endif %}
```

disqus 코드는 사용하는 사람마다 다른데 [^aweekj] 좀 더 알아봐야겠습니다. 

일단 새로운 disqus 코드로 테스트를 해보도록 하겠습니다. 최종 코드는 아래와 같습니다.

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

원래 코드는 좀 더 긴데 처음부터 주석이 된 부분이 있습니다. 이 주석 처리한 부분을 사용해 보니 정작 작동하지 않았고, 주석 부분을 빼고 하니 잘 작동하는 것 같아서 주석 처리된 부분을 제거 했습니다.

> 기타 참고 자료도 한 번 살펴봅니다. [^perfectlyrandom] 참고를 안 한 이유가 있을 것입니다.

### post.html 파일 수정하기

**_layouts** 폴더에 있는 **post.html** 파일의 끝에 아래와 같은 코드를 넣어 줍니다.

```
{% include disqus.html %}
```

### 각 post의 YAML front matter 수정하기

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

### 참고 자료

[^perfectlyrandom]: [Adding Disqus to your Jekyll](http://www.perfectlyrandom.org/2014/06/29/adding-disqus-to-your-jekyll-powered-github-pages/) : 뭔가 보기 불편해서 여기서 뺀 것 같습니다. 나중에 다시 확인해 봐야 합니다.

[^sgeos]: [Adding Disqus to a Jekyll Blog](http://sgeos.github.io/jekyll/disqus/2016/02/14/adding-disqus-to-a-jekyll-blog.html) : 설명이 잘 되어 있는 것 같습니다. 특히 각 포스트마다 댓글 개수를 표시하도록 하는 부분을 설명해 둔 점이 좋은 것 같습니다.

[^aweekj]: [Jekyll에 Disqus 추가하기](https://aweekj.github.io/2016-08-09/add-disqus-to-jekyll/) : 설명이 중간에 중단된 듯한 느낌입니다. 그래도 YAML frontmatter의 예시를 보여줘서 도움이 되었습니다.