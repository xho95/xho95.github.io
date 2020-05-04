새로운 Jekyll 의 구조에 대해서 정리합니다. 일단 Jekyll 홈페이지의 내용부터 정리합니다. [^jekyllrb]

최근의 Jekyll 은 설치하면 Minima 테마를 사용합니다. [^jekyll-minima] 이전 질문답변을 참고하기 바랍니다.

### Jekyll 설치

Jekyll 의 설치는 다음과 같이 Ruby 언어의 `gem` 명령을 사용합니다. 

```
$ gem install jekyll bundler
```

그렇기 때문에 Jekyll 을 사용하려면 Ruby 가 먼저 설치되어 있어야 합니다. Ruby 설치에 관련된 내용은 이전 글을 참고하기 바랍니다.

### jekyll new

`jekyll new` 의 결과는 다음과 같습니다. 맨 앞의 설명을 빼면 나머지는 큰 의미가 없을 것 같습니다. 일단 Bundler 가 의존 파일들을 알아서 내려 받음을 알 수 있습니다.

```
$ jekyll new test-site
Running bundle install in /Users/kimminho/Documents/test-site... 
  Bundler: The dependency tzinfo-data (>= 0) will be unused by any of the platforms Bundler is installing for. Bundler is installing for ruby but the dependency is only for x86-mingw32, x86-mswin32, x64-mingw32, java. To add those platforms to the bundle, run `bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java`.
  Bundler: Fetching gem metadata from https://rubygems.org/...........
  Bundler: Fetching version metadata from https://rubygems.org/..
  Bundler: Fetching dependency metadata from https://rubygems.org/.
  Bundler: Resolving dependencies...
  Bundler: Using public_suffix 2.0.5
  Bundler: Using colorator 1.1.0
  Bundler: Using ffi 1.9.17
  Bundler: Using forwardable-extended 2.6.0
  Bundler: Using sass 3.4.23
  Bundler: Using rb-fsevent 0.9.8
  Bundler: Using kramdown 1.13.2
  Bundler: Using liquid 3.0.6
  Bundler: Using mercenary 0.3.6
  Bundler: Using rouge 1.11.1
  Bundler: Using safe_yaml 1.0.4
  Bundler: Using bundler 1.14.5
  Bundler: Using addressable 2.5.0
  Bundler: Using rb-inotify 0.9.8
  Bundler: Using pathutil 0.14.0
  Bundler: Using jekyll-sass-converter 1.5.0
  Bundler: Using listen 3.0.8
  Bundler: Using jekyll-watch 1.5.0
  Bundler: Using jekyll 3.4.0
  Bundler: Installing jekyll-feed 0.9.1
  Bundler: Installing minima 2.1.0
  Bundler: Bundle complete! 4 Gemfile dependencies, 21 gems now installed.
  Bundler: Use `bundle show [gemname]` to see where a bundled gem is installed.
  Bundler: Post-install message from minima:
  Bundler: 
  Bundler: ----------------------------------------------
  Bundler: Thank you for installing minima 2.0!
  Bundler: 
  Bundler: Minima 2.0 comes with a breaking change that
  Bundler: renders '<your-site>/css/main.scss' redundant.
  Bundler: That file is now bundled with this gem as
  Bundler: '<minima>/assets/main.scss'.
  Bundler: 
  Bundler: More Information:
  Bundler: https://github.com/jekyll/minima#customization
  Bundler: ----------------------------------------------
New jekyll site installed in /Users/kimminho/Documents/test-site. 
```

#### Gemfile 

```
$ cd test-site/
```

위 처럼 생성된 사이트 디렉토리로 이동했는데 다음과 같은 메시지가 뜹니다.

Gemfile 을 RVM 과 Heroku 가 동시에 사용하는 것이 문제가 되는 것 같습니다.

```
RVM used your Gemfile for selecting Ruby, it is all fine - Heroku does that too,
you can ignore these warnings with 'rvm rvmrc warning ignore /Users/kimminho/Documents/test-site/Gemfile'.
To ignore the warning for all files run 'rvm rvmrc warning ignore allGemfiles'.

Unknown ruby interpreter version (do not know how to handle): RUBY_VERSION.
```

당장 실행에는 문제가 없는 모양입니다.

#### tree

일단 디렉토리 내용은 다음과 같습니다.

```
.
├── Gemfile
├── Gemfile.lock
├── _config.yml
├── _posts
│   └── 2017-03-02-welcome-to-jekyll.markdown
├── about.md
└── index.md
```

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

[^jekyllrb]: [Jekyll](https://jekyllrb.com)

[^jekyll-minima]: [jekyll/minima](https://github.com/jekyll/minima)

[^jekyllrb-quickstart]: [Quick-start guide](https://jekyllrb.com/docs/quickstart/)
