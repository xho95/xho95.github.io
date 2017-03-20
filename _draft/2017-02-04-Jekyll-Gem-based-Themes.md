예전과는 다르게 Jekyll 을 설치하면 이제 기본으로 Minima 라는 [젬 기반 테마(Gem based Theme)](https://jekyllrb.com/docs/themes/) 를 사용합니다. [^docs-themes] 젬 (Gem) 은 보석이라는 의미를 갖고 있는데 루비 (Ruby) 언어를 위한 하나의 패키지를 젬이라고 부릅니다.

앞으로 Jekyll 은 루비의 패키지 관리자를 사용해서 테마와 같은 의존 파일을 관리한다고 볼 수 있습니다. Jekyll 을 위한 젬 기반 테마는 [search for jekyll-theme](https://rubygems.org/search?utf8=✓&query=jekyll-theme) 에서 검색할 수 있습니다. [^search-theme] 

여기서는 Jekyll 블로그에 젬 기반 테마를 적용하는 방법에 대해서 정리합니다.

### 젬 기반 테마 사용하기 

#### 테마 검색하기 

젬 기반 테마는 당연히 [search for jekyll-theme](https://rubygems.org/search?utf8=✓&query=jekyll-theme) 에서 검색할 수 있지만 검색을 하려면 테마 이름을 알아야 합니다. 그래서 Jekyll 에서는 각각의 UI 템플릿을 보고 결정할 수 있도록 [Templates](http://jekyll.tips/templates/) 라는 페이지를 만들어 두었습니다. 둘러보고 원하는 테마를 선택해서 사용하면 됩니다.

저의 경우 [콩로그](http://my2kong.net)님의 [Jekyll 블로그에 테마 적용하기](http://my2kong.net/2016/07/07/jekyll-blogging-theme/) 
[^my2kong-theme] 라는 글을 참고하여 [Lanyon](http://lanyon.getpoole.com) 테마를 적용해 보기로 했습니다. [^lanyon] [^gems-lanyon]

#### 블로그에 테마 적용하기 

적용할 테마를 결정했으면 이제 블로그에 적용할 차례입니다. 

방법은 [Theme](https://jekyllrb.com/docs/themes/) 에서 **Installing a gem-based theme** 부분을 보면 됩니다. 

사이트의 **Gemfile** 에 테마를 추가합니다:

```
gem "jekyll-theme-lanyon"
```

bundler 를 사용하여 테마를 설치합니다.

```
bundle install
```

사이트의 **_config.yml**  파일에 다음과 같이 테마를 지정해서 활성화합니다:

```
theme: jekyll-theme-lanyon
```

사이트를 빌드해서 테스트합니다:

```
bundle exec jekyll serve
```

기껏 했는데 로컬에서만 적용되고 GitHub Pages 에서는 지원안하는 테마인 것 같습니다. GitHub Pages 에서 쓸려면 젬 기반 테마가 아니라 기존 방식으로 적용해야할 것 같습니다. 

### 참고 자료

[^docs-themes]: 젬 기반 테마에 대해서는 Jekyll 의 공식 문서의 [Themes](https://jekyllrb.com/docs/themes/) 에 자세히 설명하고 있습니다. 해당 글과 [Jekyll default installation doesn't have _layouts directory](http://stackoverflow.com/questions/38891463/jekyll-default-installation-doesnt-have-layouts-directory) 글을 보면 젬 기반 테마를 사용하면 예전에 있었던 **_includes** 같은 디렉토리들이 감춰진다는 것을 알 수 있습니다.

[^search-theme]: 예전의 테마들은 [Jekyll Themes](http://jekyllthemes.org) 에서 검색했는데 지금은 테마가 젬 기반으로 바뀌면서 다른 루비 젬들과 동일한 방식으로 [search for jekyll-theme](https://rubygems.org/search?utf8=✓&query=jekyll-theme) 에서 검색해야하는 것 같습니다.

[^my2kong-theme]: [콩로그](http://my2kong.net) 님의 [Jekyll 블로그에 테마 적용하기](http://my2kong.net/2016/07/07/jekyll-blogging-theme/) 라는 글에는 Jekyll 블로그에 테마를 적용하는 방법에 대해서 깔끔하게 잘 정리되어 있습니다. 다만 콩로그 님이 글을 쓰실 때에는 Jekyll 이 젬 기반 테마를 적용하기 전인 것 같습니다. 지금은 [Lanyon](http://lanyon.getpoole.com) 테마도 젬 기반 테마의 하나입니다.

[^lanyon]: [Lanyon](http://lanyon.getpoole.com) 은 Mark Otto 란 분이 만든 테마로 젬 기반 테마로도 제공됩니다. GitHub 저장소는 [poole/lanyon](https://github.com/poole/lanyon) 입니다.

[^gems-lanyon]: [search for jekyll-theme](https://rubygems.org/search?utf8=✓&query=jekyll-theme) 에서 Lanyon 테마로 검색한 결과는 [jekyll-theme-lanyon](https://rubygems.org/gems/jekyll-theme-lanyon) 입니다.