새로운 [Jekyll](https://jekyllrb.com) 의 구조에 대해서 정리합니다. 일단 Jekyll 홈페이지의 내용부터 정리합니다. [^jekyllrb]

최근의 Jekyll 은 설치하면 [Minima](https://github.com/jekyll/minima) 테마를 사용합니다. [^jekyll-minima] [^jekyllrb-themes] 이전 질문답변을 참고하기 바랍니다.

### Jekyll 설치

Jekyll 의 설치는 다음과 같이 Ruby 언어의 `gem` 명령을 사용합니다. 

```
$ gem install jekyll bundler
```

그렇기 때문에 Jekyll 을 사용하려면 Ruby 가 먼저 설치되어 있어야 합니다. Ruby 설치에 관련된 내용은 이전 글을 참고하기 바랍니다.

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

#### running

```
$ bundle exec jekyll serve
```

### 봐야할 자료

[Quick-start guide](https://jekyllrb.com/docs/quickstart/) 설명은 꼭 이해하도록 합니다. [^jekyllrb-quickstart]

```
$ gem update jekyll 
```

위와 같이 해도 같지 않았을까?

### 참고 자료

[^jekyllrb]: [Jekyll](https://jekyllrb.com) 공식 홈페이지입니다.

[^jekyll-minima]: Jekyll 에서 사용하는 minima 테마에 대해서는 [jekyll/minima](https://github.com/jekyll/minima) 에서 자료를 찾을 수 있습니다.

[^jekyllrb-quickstart]: [Quick-start guide](https://jekyllrb.com/docs/quickstart/)

[^jekyllrb-themes]: Jekyll 의 테마에 대해서는 [Themes](http://jekyllrb.com/docs/themes/) 라는 글을 참고합니다.