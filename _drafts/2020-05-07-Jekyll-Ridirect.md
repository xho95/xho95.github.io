### Redirect

여러가지 이유로 해당 문서의 URL 이 변경될 수 있습니다.

이 경우 Jekyll 에서 기존 URL 요청을 새 URL 로 Redirect 하는 방법을 설명합니다.

문서 URL 변경으로 인해 Disqus 연결이 끊어진 경우는 [Disqus 연결부터 마이그레이션까지]({% post_url 2017-01-21-Add-Disqus-to-Jekyll %}) 의 마이그레이션 부분을 참고하기 바라비다.

### 301 Redirects

[Redirects on GitHub Pages](https://help.github.com/en/enterprise/2.13/user/articles/redirects-on-github-pages)

301 Redirect 는 GtiHub Pages 에서 지원하지 않는 듯 합니다. 좀 더 확인이 필요합니다. [Changing Permalinks and duplicate content/ranking/indexing](https://support.google.com/webmasters/forum/AAAA2Jdx3sUh7T62hZuWuA/?hl=ko) 를 참고하기 바랍니다.

### Jekyll 플러그인 : `jekyll-redirect-from` 패키지

[What is the best approach for redirection of old pages in Jekyll and GitHub Pages?](https://stackoverflow.com/questions/10178304/what-is-the-best-approach-for-redirection-of-old-pages-in-jekyll-and-github-page) 라는 글을 보면 GitHub Page 에서 redirect-from plugin 을 지원하는 것 같습니다.

[JekyllRedirectFrom](https://github.com/jekyll/jekyll-redirect-from#redirect-to) 설명을 참고하면 좋을 것 같습니다.

### 의존 관계 설정하기 : `Gemfile`

다음과 같은 문장을 Gemfile 에 넣어줍니다.

```Gemfile
gem 'jekyll-redirect-from'
```

이는 `jekyll-redirect-from` 패키지 의존 관계를 표시해서 `bundler` 가 해당 패키지를 설치할 수 있도록 지정합니다.

### 플러그인 사용 설정하기 : `_config.yml`

다음과 같은 문장을 `_config.yml` 에 넣어줍니다.

```yml
plugins:
  - jekyll-redirect-from
```

이것은 Jekyll 이 `jekyll-redirect-from` 플러그인을 사용하겠다고 알리는 것입니다.

### GitHub Pages 에서 한 URL 만 Redirect 되는 현상

[Keeping your site up to date with the GitHub Pages gem](https://help.github.com/en/enterprise/2.13/user/articles/setting-up-your-github-pages-site-locally-with-jekyll#keeping-your-site-up-to-date-with-the-github-pages-gem) 을 보면 github-pages 플러그인을 최신으로 만들어 주라고 하고 있다.

```sh
$ bundle update github-pages
Could not find gem 'github-pages'.
```
