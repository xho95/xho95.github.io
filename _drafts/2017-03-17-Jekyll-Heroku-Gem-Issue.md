### 설치 과정 

`jekyll new` 의 결과는 다음과 같습니다.

```
$ jekyll new test-site
  
  ...
  
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
New jekyll site installed in /.../test-site. 
```

### Gemfile 충돌 (?)

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

당장 실행에는 문제가 없는 모양입니다. 일단 디렉토리 내용은 다음과 같습니다.
