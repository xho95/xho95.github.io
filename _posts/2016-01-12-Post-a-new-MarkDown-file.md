---
layout: post
comments: true
title:  "Jekyll: Markdown 문서로 새 포스트 만들기"
date:   2016-01-12 11:58:00 +0900
categories: Blog Jekyll MarkDown Post kramdown
redirect_from: "/jekyll/markdown/atom/kramdown/2016/01/12/Post-a-new-MarkDown-file.html"
---

> 이 글은 Jekyll 블로그에서 Markdown 로 포스팅하는 방밥을 정리한 것입니다.
>
> Jekyll 로 블로그를 제작하고 설정하는 방법에 대한 전체 내용은 [Jekyll: 블로그 제작의 모든 것]({% post_url 2020-05-06-Jekyll-Blog %}) 을 참고하기 바랍니다.

## Jekyll: MarkDown 문서로 새 포스트 만들기

Jekyll 블로그의 가장 큰 장점은 일반 텍스트 파일로 블로그에 포스팅할 수 있다는 것입니다. 물론 HTML 문서로 포스팅해도 무방합니다.[^posts]

하지만, Jekyll 블로그에서 포스팅하는 가장 일반적인 방식은 Markdown 을 사용하는 것입니다. 여기서는 Markdown 양식으로 블로그에 새 포스트를 만드는 방법을 설명합니다.

### `_posts` 폴더

Jekyll 블로그의 포스트는 `_posts` 디렉토리에 위치합니다.

단, 모든 포스트는 Jekyll 에서 정한 규칙에 맞는 이름과 'front matter'[^front-matter] 를 가져야 합니다.

### 포스트의 이름 규칙

Jekyll 포스트는 이름이 다음 규칙을 따릅니다.

```txt
YYYY-MM-DD-NAME-OF-POST.md
```

위에서 'YYYY-MM-DD' 는 포스트를 작성한 날짜이고, 'NAME-OF-POST' 는 포스트 이름입니다. 날짜에서 년도는 네 자리를 맞춰야 하고, 전체 이름은 각 단어가 공백없이 `-` 로 연결된다는 점에 유의하기 바랍니다.

아래는 Jekyll 홈페이지에서 유효한 이름으로 소개한 예제입니다.[^naming-sample-of-jekyll]

```txt
2011-12-31-new-years-eve-is-awesome.md
2012-09-12-how-to-write-a-blog.md
```

### Front matter 설정하기

각 블로그 포스트는 문서의 맨 앞에 'front matter' 라고 하는 특정 형식을 유지해야 합니다. 'front matter' 는 메타 데이터 집합으로 세 개의 대쉬 (`---`) 를 사용하여 나타냅니다.

다음은 Jeyll 홈페이지에 있는 가장 간단한 'front matter' 양식입니다.

```yml
---
layout: post
title:  "Welcome to Jekyll!"
---

포스트 내용은 여기에서부터 작성합니다.
```

다음은 GitHub Pages 홈페이지에 있는 'front matter' 양식입니다.[^naming-of-github-pages]

```yml
---
layout: page
title: "POST TITLE"
date: YYYY-MM-DD hh:mm:ss -0000
categories: CATEGORY-1 CATEGORY-2
---

포스트 내용은 여기에서부터 작성합니다.
```

보통은 위와 같이 하는 것이 가장 일반적입니다.

### 마크다운 엔진 설정하기

Jekyll 에서 Markdown 으로 포스트를 할 수 있는 것은, Jekyll 과 함께 설치된 [kramdown](http://kramdown.gettalong.org) 이라는 루비 패키지가 markdown 을 해석해 주기 때문입니다.

`_config.yml` 문서를 열어보면 다음과 같은 markdown 해석기로 'kramdown' 이 설정이 있는 것을 확인할 수 있습니다.[^kramdown]

```yml
markdown: kramdown
```

### 참고 자료

[^posts]: 이에 대한 더 자세한 내용은 Jeyll 홈페이지의 [Posts](https://jekyllrb.com/docs/posts/) 를 참고하기 바랍니다.

[^front-matter]: 'front matter' 라고 하면 우리 말로는 '서문' 정도에 해당합니다. Jekyll 의 모든 포스트는 이 '서문' 이 문서 맨 앞에 반드시 있어야 하는데, Jekyll 이 이 '서문' 을 해석해서 해당 포스트의 이름과 경로를 지정하기 때문입니다.

[^naming-of-github-pages]: 이에 대한 내용은 [Adding a new page to your site](https://help.github.com/en/github/working-with-github-pages/adding-content-to-your-github-pages-site-using-jekyll#adding-a-new-page-to-your-site) 를 참고하기 바랍니다.

[^naming-sample-of-jekyll]: 이에 대한 내용은 [Creating Posts](https://jekyllrb.com/docs/posts/#creating-posts) 를 참고하기 바랍니다.

[^kramdown]: GitHub 에서는 markdown 기본 번역 엔진으로 'kramdown' 을 사용합니다. 그리고 Jekyll 4.x 버전부터는 kramdown-1.x 버전을 지원하지 않습니다.
