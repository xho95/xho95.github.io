---
layout: post
comments: true
title:  "Jekyll: 시간대 (timezone) 설정하고 `post_url` 사용하기"
date:   2020-05-07 12:30:00 +0900
categories: Blog Jekyll timezone post-url
---

> 이 글은 Jekyll 블로그의 시간대 (timezone) 를 설정하고 `post_url` 을 사용하는 방법을 정리한 것입니다.
>
> Jekyll 로 블로그를 제작하고 설정하는 방법에 대한 전체 내용은 [Jekyll: 블로그 제작의 모든 것]({% post_url 2020-05-06-Jekyll-Blog %}) 을 보도록 합니다.

## Jekyll: 시간대 (timezone) 설정하고 `post_url` 사용하기

`post_url` 을 사용하면 블로그에서 링크를 연결하기 편해집니다.

단 `post_url` 을 사용하려면 `_config.yml` 파일에서 시간대를 설정해야 합니다. 시간대 설정을 하지 않고 `post_url` 을 사용하면 Jekyll 블로그를 빌드할 수 없을 것입니다.[^post-url-not-build]

### `_config.yml` 에서 시간대 (timezone) 설정하기

시간대를 설정하려면 양식에 맞게 지정해야 합니다. 일단 다음과 같이 설정해줍니다.

```yml
# set timezone
timezone: Asia/Seoul
```

Jekyll 에서 사용할 수 있는 시간대 (timezone) 목록은 [List of tz database time zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) 에 잘 나와 있습니다.

설정 예제는 [Posting Jekyll Content on Time](https://mehmandarov.com/jekyll-content-on-time/) 을 보도록 합니다.

### 시간대 설정에 따른 이슈 해결하기

[마크다운 (markdown) 양식으로 새 포스트 만들기]({% post_url 2016-01-12-Post-a-new-MarkDown-file %}) 에서 설명한 대로, Jekyll 은 'front matter' 에 있는 '메타 데이터' 를 이용하여 문서의 URL 을 지정합니다.

이 경우 'front matter' 에 시간 메타 데이터가 있을 경우, 시간대를 설정하면서 문서의 URL 이 변경될 수 있습니다.

이 문제는 redirect 로 해결하는 것이 가장 편합니다. 문서 URL 변경으로 인해 Disqus 연결이 끊어진 경우는 [Disqus 연결부터 마이그레이션까지]({% post_url 2017-01-21-Add-Disqus-to-Jekyll %}) 의 마이그레이션 부분을 참고하기 바라비다.

[What is the best approach for redirection of old pages in Jekyll and GitHub Pages?](https://stackoverflow.com/questions/10178304/what-is-the-best-approach-for-redirection-of-old-pages-in-jekyll-and-github-page) 라는 글을 보면 GitHub Page 에서 redirect-from plugin 을 지원하는 것 같습니다.

[JekyllRedirectFrom](https://github.com/jekyll/jekyll-redirect-from#redirect-to) 설명을 참고하면 좋을 것 같습니다.

[Redirects on GitHub Pages](https://help.github.com/en/enterprise/2.13/user/articles/redirects-on-github-pages)

301 Redirect 는 GtiHub Pages 에서 지원하지 않는 듯 합니다. 좀 더 확인이 필요합니다. [Changing Permalinks and duplicate content/ranking/indexing](https://support.google.com/webmasters/forum/AAAA2Jdx3sUh7T62hZuWuA/?hl=ko) 를 보도록 합니다.


### 참고 자료

[^post-url-not-build]: '시간대 (timezone)' 를 설정하지 않은 상태에서 `post_url` 을 사용할 경우의 문제는 [Using post_url causes pages to not build in Github](https://github.com/jekyll/jekyll/issues/3179) 를 보도록 합니다.
