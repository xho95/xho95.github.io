>이 글은 Jekyll 블로그 제작 중에서 Jekyll 업그레이드에 대한 내용을 정리한 것입니다.
>
>Jekyll 블로그 제작과 관련한 내용은 다음을 참고하기 바랍니다.

Jekyll 홈페이지의 [Upgrading](https://jekyllrb.com/docs/upgrading/) 를 보고 진행합니다.

일단, 3.x 에서 4.x 로 업그레이드를 진행합니다.

### Ruby 업데이트

먼저 루비를 Ruby 5.0 이상 버전으로 업데이트해야 합니다.

루비 업데이트는 RVM 과 rbenv 가 양대 산맥인 듯 합니다.

일단 RVM 은 이미 설치되어 있는 관계로 그냥 RVM 을 사용합니다. 대체로 rbenv 를 선호하는 것 같습니다. 기회 있으면 다루도록 하겠습니다.

```sh
$ rvm get stable --ruby
```

명령은 위와 같이 했는데, 루비 뿐만 아니라 관련된 패키지들이 모조리 설치되는 것 같습니다. 썩 바람직하지는 않는 것 같습니다.

```sh
$ rvm get stable
```

위처럼 하고 안정화 버전의 루비 버전을 적어주는 게 더 좋을 듯 합니다.

### Gem 명령으로 Jekyll 업데이트

1. Gemfile 이 있는 경우

이미 사이트에 gemfile 이 설치되어 있으면 아래와 같이 바로 gem 을 사용하면 됩니다. []() 에서 보듯 minima 가 적용된 버전이면 gemfile 이 이미 있으므로 바로 업데이트하면 됩니다.

```sh
$ gem update jekyll
```

하지만 gemfile 이 없다면 아래와 같이 업데이트할 것이 없다고 뜰 것입니다. 이 때는 아래 처럼 `bundler` 를 이용하여 먼저 Gemfile 을 생성해 줍니다.

```sh
$ gem update jekyll
Nothing to update
```

> 업데이트할 jekyll 의존 정보가 gemfile 에 있는데 gemfile 이 없으므로 문제가 없는 것입니다. 일단 update 가 다 된 것처럼 나오는데 의존된 것이 없으므로 문제가 없습니다. 일단 jekyll 이 최신이어서 일 수 도 있습니다. 하지만 jekyll 이 최신이어서가 아니라 gemfile 이 없어서라면 `bundler` 를 이용하여 먼저 Gemfile 을 생성해 줍니다.

2. Gemfile 이 없는 경우

**bundler 로 Gemfile 생성하기**

앞서 gem 명령으로 jekyll 을 업그레이드 할 수 있었다면 여기 내용은 지나갈 수 있습니다. gem 명령을 사용할 수 없다면 해당 프로젝트에 gemfile 이 없기 때문입니다.

이때는 아래와 같이 bundler 를 사용하여 먼저 gemfile 을 생성해 줍니다.

```sh
$ bundle init
```

직접 Gemfile 을 만드는 방법은 [Could not locate Gemfile or .bundle/ directory](https://forestry.io/docs/troubleshooting/could-not-locate-gemfile-or-bundle-directory/) 에 나온대로 위와 같이 하면 됩니다.

> 'Gemfiles' 은 최소한 하나 이상의, RubyGems 서버에 대한 URL 양식의, 'gem' 소스를 요구합니다. 위 명령은 기본적인 rubygems.org 소스를 사용해서 'Gemfile' 을 생성하는 명령입니다. 이에 대한 설명은 [Gemfiles](https://bundler.io/gemfile.html#gemfiles) 를 참고하기 바랍니다.


### `bundle update jekyll`

```sh
$ bundle update jekyll
Could not locate Gemfile
```

해당 디렉토리에 'Gemfile' 이 없기 때문입니다. 직접 Gemfile 을 만드는 방법은 [Could not locate Gemfile or .bundle/ directory](https://forestry.io/docs/troubleshooting/could-not-locate-gemfile-or-bundle-directory/) 에 나온대로 다음과 같이 하면 됩니다.
