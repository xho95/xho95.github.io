---
layout: post
pagination: 
  enabled: true
comments: true
title:  "Jekyll: 블로그 제작의 모든 것"
date:   2020-05-06 12:30:00 +0900
categories: Blog Jekyll GitHub
---

이 문서는 Jekyll 로 블로그를 제작한 후 GitHub Pages 로 호스팅하는 방법을 정리한 것입니다.

### Jekyll 블로그 개요

[Jekyll](https://jekyllrb.com) 은 [Markdown](https://en.wikipedia.org/wiki/Markdown) 같은 텍스트 파일로 정적 사이트를 만들 수 있게 해주는 '사이트 생성기' 입니다.[^Jekyll] 또 [GitHub](https://github.com) 에서 지원하므로[^github-and-jekyll], GitHub 의 자체 호스팅 서비스인 [GitHub Pages](https://pages.github.com) 에서 무료[^limits]로 블로그를 운영할 수 있습니다.[^benefits]

### Jekyll 로 블로그를 제작하는 방법

* [GitHub Pages 에 블로그 만들기]({% post_url 2017-03-05-Jekyll-Blog-with-Minima %})
* [마크다운 (markdown) 양식으로 새 포스트 만들기]({% post_url 2016-01-12-Post-a-new-MarkDown-file %})
* [Disqus 연결부터 마이그레이션까지]({% post_url 2017-01-21-Add-Disqus-to-Jekyll %})[^disqus]

### 참고 자료

[^Jekyll]: 'Jekyll' 은 실제로는 '루비 (Ruby)' 언어로 만들어진 하나의 패키지 입니다. 루비 언어의 패키지를 '젬 (Gem)' 이라고 하는데, 루비 입장에서는 Jekyll 도 하나의 젬인 것입니다. 그래서 Jekyll 로 블로그를 제작하기 위해서는 자신의 컴퓨터에 루비를 먼저 설치해야 합니다.

[^github-and-jekyll]: **Chulgil.Lee** 님의 [블로그 만들기 GitHub 편 총정리](https://blog.chulgil.me/how-to-make-blog-using-github/) 라는 글을 보면 Github CEO 가 Jekyll 을 만들었다고 합니다. 그러므로, GitHub 에서 Jekyll 을 지원하는 것은 당연하다 할 수 있습니다.

[^limits]: 물론 아무리 GitHub 라고는 해도 무한정 사용할 수 있는 것은 아닙니다. **About GitHub Pages** 문서의 [Usage limits](https://help.github.com/en/github/working-with-github-pages/about-github-pages#usage-limits) 부분을 보면, 'GitHub Pages' 에서 소스 저장소의 크기는 `1GB`, 대역폭은 매월 `100GB`, 사이트 빌드는 시간당 `10` 번으로 제한하고 있다고 합니다. 보다 자세한 내용은 앞의 링크를 보도록 합니다.

[^benefits]: Jekyll 로 블로그를 제작 할 때의 장점들에 대해서는 예전에 작성한 [Jekyll 기반의 GitHub Pages에 블로그 만들기]({% post_url 2016-01-11-Make-a-blog-with-Jekyll %}) 의 앞부분을 보도록 합니다.

[^disqus]: Jekyll 은 정적 사이트이기 때문에 댓글 시스템 같은 동적 요소가 없습니다. 따라서 동적 요소는 사용하려면 [Disqus](https://disqus.com) 같은 외부 서비스를 사용해야 합니다.
