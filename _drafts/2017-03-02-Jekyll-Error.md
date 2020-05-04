
#### Ruby 버전

Ruby 버전은 아래와 같습니다. 일단 최신 버전은 아닌 것 같습니다.

```
$ ruby --version
ruby 2.3.0p0 (2015-12-25 revision 53290) [x86_64-darwin15]
```

#### bundler 설치

아래와 같이 bundler 를 설치합니다.

```
$ gem install bundler
```

```
$ bundle -v
Bundler version 1.14.5
```

### Gem

#### Gem 버전

```
$ gem -v
2.5.1
```

#### Gem 업데이트

Gem 을 업데이트할 때는 `sudo` 를 붙여줍니다. [^jekyllrb-trouble]

```
$ sudo gem update --system
```
### Jekyll Error

#### Jekyll 버전

```
$ jekyll --version
```

Jekyll 버전을 찾으면 아래와 같은 `Gem::LoadError` 에러가 발생합니다.

```
/System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/lib/ruby/2.0.0/rubygems/dependency.rb:296:in `to_specs': Could not find 'jekyll' (>= 0) among 44 total gem(s) (Gem::LoadError)
	from /System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/lib/ruby/2.0.0/rubygems/dependency.rb:307:in `to_spec'
	from /System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/lib/ruby/2.0.0/rubygems/core_ext/kernel_gem.rb:47:in `gem'
	from /usr/local/bin/jekyll:22:in `<main>'
```

일단 `Gem::LoadError` 에러라는 것은 RubyGems 가 Gem 을 불러오거나 활성화할 수 없을 때 발생합니다. [^ruby-load-error]

#### 해결 방법

다음과 같이 업데이트된 gem 으로 jekyll 을 새로 설치해 주면 됩니다. 이는 Jekyll 자체가 하나의 라이브러리라서 새로 설치하는 것으로 일종의 라이브러리가 업데이트되는 개념이 되는 것 같습니다.

```
$ gem install jekyll bundler
```

```
$ jekyll new my-awesome-site
```


### 참고 자료

[^ruby-load-error]: [Gem::LoadError](https://ruby-doc.org/stdlib-2.2.3/libdoc/rubygems/rdoc/Gem/LoadError.html)

[^jekyllrb-trouble]: [Troubleshooting](https://jekyllrb.com/docs/troubleshooting/)
