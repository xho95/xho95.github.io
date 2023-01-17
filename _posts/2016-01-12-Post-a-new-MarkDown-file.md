---
layout: post
pagination: 
  enabled: true
comments: true
title:  "Jekyll: 마크다운 (markdown) 양식으로 새 포스트 만들기"
date:   2016-01-12 11:58:00 +0900
categories: Blog Jekyll MarkDown Post kramdown
redirect_from: "/jekyll/markdown/atom/kramdown/2016/01/12/Post-a-new-MarkDown-file.html"
---

> 이 글은 Jekyll 블로그에서 마크다운 (markdown) 문서로 새 포스트를 작성하는 방밥을 정리한 것입니다.
>
> Jekyll 로 블로그를 제작하고 설정하는 방법에 대한 전체 내용은 [Jekyll: 블로그 제작의 모든 것]({% post_url 2020-05-06-Jekyll-Blog %}) 을 보도록 합니다.

## Jekyll: 마크다운 (markdown) 양식으로 새 포스트 만들기

Jekyll 블로그의 가장 큰 장점은 일반 텍스트 파일로 블로그에 포스팅할 수 있다는 것입니다. 물론 여전히 HTML 문서로도 포스팅할 수 있습니다.[^posts]

하지만, 역시 '마크다운 (markdown)' 양식으로 포스트를 작성하는 것이 가장 일반적인 방식입니다. 여기서는 마크다운 양식으로 블로그에 새 포스트를 만드는 방법을 설명합니다.

### `_posts` 폴더

Jekyll 블로그의 모든 포스트는 `_posts` 디렉토리에 위치합니다.

단, 포스트를 작성할 때는 Jekyll 에서 정한 규칙에 맞게 이름과 'front matter (서문)'[^front-matter] 을 지정해야 합니다.

### 포스트의 이름 규칙

Jekyll 포스트의 이름 규칙은 다음과 같습니다.

```txt
YYYY-MM-DD-NAME-OF-POST.md
```

위에서 'YYYY-MM-DD' 는 포스트를 작성한 날짜이고, 'NAME-OF-POST' 는 포스트 이름입니다. 날짜에서 년도는 네 자리이고, 전체 이름은 각 단어가 공백없이 '대쉬 (`-`)' 로 연결된다는 점에 유의하기 바랍니다.

아래는 Jekyll 홈페이지에서 소개한 이름 샘플입니다.[^naming-sample-of-jekyll]

```txt
2011-12-31-new-years-eve-is-awesome.md
2012-09-12-how-to-write-a-blog.md
```

### Front matter 설정하기

각각의 포스트는 문서의 맨 앞에 'front matter' 라고 하는 특정한 양식을 붙여야 합니다. 'front matter' 는 일종의 '메타 데이터 집합' 으로 세 개의 대쉬 (`---`) 를 사용하여 구분합니다.

Jeyll 홈페이지에서 소개하고 있는 가장 간단한 'front matter' 양식은 다음과 같습니다.

```yml
---
layout: post
title:  "포스트 제목"
---

여기서부터 포스트 내용을 작성합니다.
```

위는 'front matter' 중에서 아무런 메타 데이터도 없는 양식이며, 최소한의 양식이라고 할 수 있습니다.

GitHub Pages 홈페이지에서는 다음 처럼 메타 데이터로 시간과 카테고리를 지정하는 샘플을 보여줍니다.[^naming-of-github-pages]

```yml
---
layout: page
title: "포스트 제목"
date: YYYY-MM-DD hh:mm:ss -0000
categories: CATEGORY-1 CATEGORY-2
---

여기서부터 포스트 내용을 작성합니다.
```

위에서 지정한 시간 및 카테고리 데이터는 해당 포스트의 URL 을 생성할 때 사용됩니다.

'front matter' 이후부터는 일반 마크다운 문서를 작성하는 것과 똑같이 작성하면 됩니다.

### 마크다운 엔진 설정하기

사실, Jekyll 에서 마크다운 양식으로 포스트를 작성할 수 있는 이유는, Jekyll 이 [kramdown](http://kramdown.gettalong.org) 이라는 마크다운 해석 엔진을 기본으로 지원하기 때문입니다.[^kramdown]

`_config.yml` 문서를 열어보면 다음과 같이 'kramdown' 이 markdown 해석기로 설정이 있는 것을 확인할 수 있습니다.

```yml
markdown: kramdown
```

### 참고 자료

[^posts]: 이 설명은 Jeyll 홈페이지의 [Posts](https://jekyllrb.com/docs/posts/) 에 나옵니다. 하지만 HTML 로 포스트를 작성할 것이라면 애초에 Jekyll 을 사용할 필요없이 가입형 블로그 서비스를 사용하는 것이 더 편리할 것입니다.

[^front-matter]: 'front matter' 는 우리 말로는 '서문' 정도에 해당하며, 문서 맨 앞에 붙이는 요소 정도로 이해하면 될 것 같습니다. 'Jekyll 의 모든 포스트는 이 'front matter' 가 반드시 문서 맨 앞에 있어야 하는데, 이 'front matter' 의 '메타 데이터 (mata data)' 들을 해석해서 해당 포스트의 이름과 경로 등을 지정하기 때문입니다.

[^naming-of-github-pages]: 이에 대한 내용은 [Adding a new page to your site](https://help.github.com/en/github/working-with-github-pages/adding-content-to-your-github-pages-site-using-jekyll#adding-a-new-page-to-your-site) 를 보도록 합니다.

[^naming-sample-of-jekyll]: 이에 대한 내용은 [Creating Posts](https://jekyllrb.com/docs/posts/#creating-posts) 를 보도록 합니다.

[^kramdown]: 이에 대한 설명은 [Kramdown](https://jekyllrb.com/docs/configuration/markdown/#kramdown) 에서 확인할 수 있습니다. Kramdown 은 GitHub 에서도 기본 번역 엔진으로 사용되고 있습니다. 단, Jekyll 4.x 버전부터는 kramdown-2.x 이상의 버전만을 지원한다고 합니다.
