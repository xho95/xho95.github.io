---
layout: post
comments: true
title:  "Jekyll: 버전 4.x 로 업그레이드하기"
date:   2020-05-06 12:30:00 +0900
categories: Blog Jekyll Upgrade Ruby Bundler
---

> 이 글은 Jekyll 버전을 업그레이드하는 내용을 정리한 것입니다.
>
> Jekyll 로 블로그를 제작하는 방법은 [Jekyll: 블로그 제작의 모든 것]({% post_url 20202-05-06-Jekyll-Blog %}) 을 보도록 합니다.

## Jekyll: 버전 4.x 로 업그레이드하기

여기서는 Jekyll 을 3.x 에서 4.x 로 업그레이드하는 부분을 다룹니다. 기본적인 내용은 Jekyll 홈페이지의 [Upgrading](https://jekyllrb.com/docs/upgrading/) 을 참고했으며, 해당 문서와 다른 부분이 있어서 따로 정리한 것입니다.

### Ruby 업데이트

Jekyll 4.x 를 사용하려면 먼저 'Ruby (루비)' 버전을 2.5.0 이상으로 업데이트해야 합니다.[^jekyll-ruby]

터미널에서 다음 명령을 실행하여 설치된 루비 버전을 확인하고, 버전이 2.5.0 보다 낮으면 루비를 업데이트합니다. 업데이트할 필요가 없으면 [Jekyll 업데이트](#jekyll-업데이트) 로 이동합니다.

```sh
$ ruby -v
ruby 2.7.0p0 (2019-12-25 revision 647ee6f091) [x86_64-darwin19]
```

macOS 에서 루비를 업데이트 하는 방법은 크게 [RVM](http://rvm.io) 을 사용하는 방법과 [rbenv](https://github.com/rbenv/rbenv) 를 사용하는 방법 두 가지가 있습니다. 여기서는 RVM 을 사용하여 업데이트합니다.[^RVM-vs-rbenv]

터미널에서 다음 명령들을 실행하여 루비를 업데이트합니다.

```sh
$ rvm get stable
$ rvm install ruby-2.7.0
```

첫 번째 명령은 RVM 자체를 최신 버전으로 업데이트하는 명령이며, 두 번째 명령은 (ruby-2.7 과 같이) 지정한 버전의 루비를 설치하는 명령입니다. `rvm install` 뒤에 적을 수 있는 루비 버전을 알아보려면 터미널에서 `$ rvm list known` 명령을 실행하면 됩니다.[^rvm-get-stable-ruby]

### Jekyll 업데이트

Jekyll 을 업데이트 하는 방법은 Jekyll 프로젝트 폴더에 'Gemfile' 이 있는지 여부에 따라 두 가지로 나뉩니다.[^Gemfile] 다음처럼 블로그 디렉토리로 이동하여 Gemfile 이 있는지 먼저 확인합니다.

```sh
$ cd the-directory-of-my-blog
$ ls
```

'Gemfile' 과 'Gemfile.lock' 이 없다면 [Gemfile 이 없는 경우](#gemfile-이-없는-경우) 로 이동하여 업데이트를 진행합니다.

#### Gemfile 이 있는 경우

[GitHub Pages 에 블로그 만들기]({% post_url 2017-03-05-Jekyll-Blog-with-Minima %}) 에서 설명한대로, `bundler` 와 같이 설치한 Jekyll 에는 이미 'Gemfile' 이 있으므로 Jekyll 을 바로 업데이트하면 Jekyll 을 업그레이드 할 수 있습니다.

다음과 같이 바로 `gem` 명령을 사용하면 됩니다.

```sh
$ gem update jekyll
```

#### Gemfile 이 없는 경우

하지만 Jekyll 블로그를 초창기에 시작하여 Gemfile 이 없는 경우에는 바로 `gem` 명령을 사용할 수 없습니다.[^gem] 이 때는 아래 처럼 `bundler` 를 이용하여 먼저 Gemfile 을 생성해 줍니다.

```sh
$ gem update jekyll
Nothing to update
```

> 업데이트할 jekyll 의존 정보가 gemfile 에 있는데 gemfile 이 없으므로 문제가 없는 것입니다. 일단 update 가 다 된 것처럼 나오는데 의존된 것이 없으므로 문제가 없습니다. 일단 jekyll 이 최신이어서 일 수 도 있습니다. 하지만 jekyll 이 최신이어서가 아니라 gemfile 이 없어서라면 `bundler` 를 이용하여 먼저 Gemfile 을 생성해 줍니다.

#### Gemfile 이 없는 경우

**bundler 로 Gemfile 생성하기**

앞서 gem 명령으로 jekyll 을 업그레이드 할 수 있었다면 여기 내용은 지나갈 수 있습니다. gem 명령을 사용할 수 없다면 해당 프로젝트에 gemfile 이 없기 때문입니다.

이때는 아래와 같이 bundler 를 사용하여 먼저 gemfile 을 생성해 줍니다.

```sh
$ bundle init
```

직접 Gemfile 을 만드는 방법은 [Could not locate Gemfile or .bundle/ directory](https://forestry.io/docs/troubleshooting/could-not-locate-gemfile-or-bundle-directory/) 에 나온대로 위와 같이 하면 됩니다.

> 'Gemfiles' 은 최소한 하나 이상의, RubyGems 서버에 대한 URL 양식의, 'gem' 소스를 요구합니다. 위 명령은 기본적인 rubygems.org 소스를 사용해서 'Gemfile' 을 생성하는 명령입니다. 이에 대한 설명은 [Gemfiles](https://bundler.io/gemfile.html#gemfiles) 를 보도록 합니다.


### `bundle update jekyll`

```sh
$ bundle update jekyll
Could not locate Gemfile
```

해당 디렉토리에 'Gemfile' 이 없기 때문입니다. 직접 Gemfile 을 만드는 방법은 [Could not locate Gemfile or .bundle/ directory](https://forestry.io/docs/troubleshooting/could-not-locate-gemfile-or-bundle-directory/) 에 나온대로 다음과 같이 하면 됩니다.

### 참고 자료

[^jekyll-ruby]: 'Jekyll' 은 실제로는 '루비 (Ruby)' 언어로 만들어진 하나의 패키지 입니다. 그래서 Jekyll 을 사용하려면 루비를 먼저 설치해야 하는데, macOS 에는 루비가 이미 설치되어 있으므로 따로 설치할 필요는 없습니다. 하지만, `Jekyll 4.x` 버전을 사용하려면 `Ruby 2.5.0` 이상의 버전이 필요하므로, 기존 루비의 버전이 낮다면 업데이트할 필요가 있습니다.

[^RVM-vs-rbenv]: 인터넷으로 검색하면 대체로 `rbenv` 를 더 선호하는 것 같습니다. 다만, `rbenv` 는 사용자가 직접 새로 설치해야 하지만, RVM 은 일단 루비가 설치됐으면 이미 있으므로, 여기서는 RVM 을 사용한 것입니다. `rbenv` 는 기회 있을 때 다루도록 하겠습니다.

[^rvm-get-stable-ruby]: RVM 을 사용하면서 `$ rvm get stable --ruby` 라는 명령을 사용하면 RVM 과 루비 업데이트를 동시에 하는 것 같습니다. 다만 이 방법은 루비 뿐만 아니라 의존 관계에 있는 모든 패키지들도 함께 설치하는 바람에, 설정 등을 재조정할 필요가 생기므로, 루비 프로그래머가 아닌 이상 좋은 방법은 아닌 듯 합니다.

[^Gemfile]: 'Gemfile' 은 루비 언어에서 의존성 정보를 담고 있는 파일입니다. Jekyll 은 패키지 관리자로 Bundler 를 사용하며, Bundler 와 같이 설치한 Jekyll 에는 이미 Gemfile 이 설치되어 있습니다.

[^gem]: `gem` 명령을 사용할 수 없다기 보다, 의존성 정보를 담고 있는 'Gemfile' 이 없으므로, `gem` 명령을 사용하는 것이 무의미해집니다.
