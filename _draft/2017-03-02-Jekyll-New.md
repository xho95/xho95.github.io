새로운 [Jekyll](https://jekyllrb.com) 의 구조에 대해서 정리합니다. 일단 Jekyll 홈페이지의 내용부터 정리합니다. [^jekyllrb]

최근의 Jekyll 은 설치하면 [Minima](https://github.com/jekyll/minima) 테마를 사용합니다. [^jekyll-minima] [^jekyllrb-themes] 이전 질문답변을 참고하기 바랍니다.

### Jekyll 이란

Jekyll 은 간단하며 블로그에 적합한 정적 사이트 생성기입니다. 다양한 포맷으로 되어 있는 문서 파일을 템플릿 디렉토리에 저장하고 이에 (Markdown 과 같은) 변환기와 Liquid 렌더러를 적용하면 웹서버에 바로 서비스 가능한 완전한 형태의 정적 웹 사이트를 만들어 줍니다. [^docs-home]

Jekyll 은 또 GitHub 의 엔진으로 채택되었기 때문에 GitHub 서버를 통해서 무료로 자신의 프로젝트, 블로그 및 웹사이트를 호스트할 수 있습니다.

### Jekyll 설치

Jekyll 의 설치는 다음과 같이 RubyGems 을 사용합니다. [^ruby-gems]

```
$ gem install jekyll bundler
```

그렇기 때문에 Jekyll 을 사용하려면 Ruby 가 먼저 설치되어 있어야 합니다. Ruby 설치에 관련된 내용은 이전 글을 참고하기 바랍니다.

#### running

```
$ bundle exec jekyll serve
```

### Bundler 란

앞에서 실행한 `gem install jekyll bundler` 명령은 RubyGems 으로 jekyll 과 bundler 젬 (gem) 을 설치합니다.

bundler 는 다른 Ruby 젬 (gem) 들을 관리하는 젬 (gem) 입니다. 이것은 젬들 사이의 버전이 호환되는지 또 각 젬들에게 필요한 의존 관계가 만족하는지를 확인합니다.
**Gemfile** 과 **Gemfile.lock** 파일은 사이트에 필요한 젬들을 Bundler 에게 알려주는 역할을 합니다. 이 Gemfile 들이 없으면 실행할 때 `bundle exec` 를 생략하고 `jekyll serve` 로 실행할 수 있습니다.
`bundle exec jekyll serve` 명령을 수행하면 Bundler 가 `Gemfile.lock` 에 지정된 젬과 버전들이 맞게 되었는지 검사해서 사이트의 호환성과 의존 관계 충돌이 없음을 보장해 줍니다.

### 설치 및 설치에 피요한 요소들

첫 블로그 글을 참고하는 것이 좋을 것 같습니다. [Installation](http://jekyllrb.com/docs/installation/) 부분을 정리해야할 지 고민해 봅니다.`$ gem update jekyll` 부분은 참고할만한 것 같습니다.

### Jekyll 의 구조

```
$ jekyll new test-site
$ cd test-site
```

위처럼 `jekyll new` 를 해서 사이트를 생성한 후 이동해서 내부 파일들을 보면 다음과 같은 파일들이 생성되는 것을 볼 수 있습니다.

```
.
├── Gemfile
├── Gemfile.lock
├── _config.yml
├── _posts
├── _site
├── about.md
└── index.md
```

minima 테마를 쓰게 되면서 예전과는 조금 달라졌습니다. 많은 폴더들이 감춰지는 것을 알 수 있습니다. 

이제 `jekyll new` 를 수행하면 기본으로 Jekyll 사이트가 `Minima` 라는 젬 기반 테마를 사용하도록 합니다. 젬 기반 테마 (gem-based themes) 를 사용하게 되면서 몇몇 디렉토라와 파일들이 테마-젬에 저장되어 밖으로는 보이지 않게 되었습니다.

설치할 때 몇가지 옵션을 통해서 예전처럼 설치할 수도 있습니다. [^docs-quickstart]

### 참고 자료

[^jekyllrb]: [Jekyll](https://jekyllrb.com) 공식 홈페이지입니다.

[^jekyll-minima]: Jekyll 에서 사용하는 minima 테마에 대해서는 [jekyll/minima](https://github.com/jekyll/minima) 에서 자료를 찾을 수 있습니다.

[^docs-quickstart]: [Quick-start guide](https://jekyllrb.com/docs/quickstart/)

[^jekyllrb-themes]: Jekyll 의 테마에 대해서는 [Themes](http://jekyllrb.com/docs/themes/) 라는 글을 참고합니다.

[^docs-home]: [Welcome](http://jekyllrb.com/docs/home/)

[^ruby-gems]: RubyGems 은 Ruby 언어를 위한 패키지 관리자 프레임웍입니다. RubyGems 은 [Download RubyGems](https://rubygems.org/pages/download) 에서 다운로드 할 수 있습니다.