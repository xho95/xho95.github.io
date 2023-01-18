---
layout: post
pagination:
  enabled: true
comments: true
title:  "Homebrew: 설치 및 Sierra 관련 이슈 정리"
date:   2017-01-14 01:11:30 +0900
categories: macOS Sierra Package Homebrew Issues
redirect_from: "/macos/sierra/package/homebrew/issues/2017/01/13/Using-Homebrew-and-some-Issues.html"
---

여기서는 [Homebrew](http://brew.sh) 의 사용 방법에 대해서 간단하게 알아보고, Homebrew 를 사용하다가 문제가 발생할 경우의 해결 방법에 대해서 정리합니다.

**Homebrew** 는 macOS 용 패키지 관리자[^brew]입니다. [^mimul-homebrew] 이 도구를 사용해서 맥에 필요한 각종 패키지를 설치할 수 있습니다. [^tree] 맥 사용자, 특히 개발자라면 원하든 원하지 않든 반드시 사용할 일이 생깁니다.

> Homebrew 공식 홈페이지에서는 한글도 지원합니다. 첫 화면의 선택 상자에서 한국어를 선택하면 됩니다. [^brew-ko]
>
> macOS용 패키지 관리자에는 Homebrew 외에도 [MacPorts](https://www.macports.org) 라는 것도 있습니다. [^macports] 하지만 Homebrew 와 비교하면 사용할 일이 적으며 가끔씩 macports로만 설치할 수 있는 패키지가 있을 때 사용합니다.

사실 맥을 사용하는 개발자 중에 Homebrew를 사용하지 않는 사람은 없기 때문에 Homebrew에 대해서 따로 정리할 필요를 느끼지 못했었습니다. 그런데 최근 macOS 시에라(Sierra)가 나오고 나서 한동안 Homebrew가 시에라를 지원하지 못하는 바람에 여러가지 문제를 겪게 되면서 관련 이슈에 대해서 정리해야겠다고 생각하게 되었습니다. [^brew-issues]

이제 매년 새로운 macOS가 나오고 있는데 혹시라도 다음에 macOS를 업데이트 하고 나서 Homebrew 사용에 문제가 생기면 이 글이 도움이 되지 않을까 생각합니다.

### Homebrew 설치하기

우선 터미널에서 `brew` 또는 `brew -v` 명령을 입력해서 Homebrew가 설치되었는지 확인합니다. 이미 설치되어 있다면 `brew update` 명령으로 업데이트를 해 줍니다. `brew update` 명령은 이 글 마지막 부분에 설명해 두었습니다.

설치되어있지 않으면 공식 홈페이지에서 설명한 대로 터미널에 아래의 명령을 입력해서 설치합니다.

```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

명령어가 길기 때문에 타자를 치기보다는 그냥 복사하는 편이 나을 것입니다. 홈페이지에서도 당당하게 **터미널에 붙여넣기** 하라고 설명합니다.

> 위에서 보듯이 Homebrew는 ruby를 통해서 설치되지만 macOS에는 ruby가 이미 설치되어 있으므로 따로 신경쓸 필요가 없습니다.
>
> curl 명령도 사용하는데 이 또한 macOS에는 이미 설치되어 있기 때문에 크게 신경쓰지 않아도 됩니다. curl 명령에 대한 내용은 정광섭님의 글 [curl 설치 및 사용법 - HTTP GET/POST, REST API 연계 등](https://www.lesstif.com/pages/viewpage.action?pageId=14745703) 을 참고하시면 좋을 것 같습니다. [^lesstif-14745703]  

설치를 완료한 후 터미널에 `brew` 명령을 입력해서 아래와 같이 기본적인 사용법이 나타나면 설치가 잘 된 것입니다.

```
Example usage:
  brew search [TEXT|/REGEX/]
  brew (info|home|options) [FORMULA...]
  brew install FORMULA...
  brew update
  brew upgrade [FORMULA...]
  brew uninstall FORMULA...
  brew list [FORMULA...]

Troubleshooting:
  brew config
  brew doctor
  brew install -vd FORMULA

Developers:
  brew create [URL [--no-fetch]]
  brew edit [FORMULA...]
  https://github.com/Homebrew/brew/blob/master/docs/Formula-Cookbook.md

Further help:
  man brew
  brew help [COMMAND]
  brew home
```

> 버전에 따라서 내용이 조금 다를 수는 있을 것입니다. 설치 관련해서는 다른 문서도 있습니다. [^homebrew-installation]

### Homebrew 사용하기

사용 방법은 정말 간단하며 `brew install` 명령 뒤에 원하는 패키지 명을 사용하면 됩니다. 만약 `wget`을 설치하고 싶다면 아래와 같이 하면 됩니다.

```
$ brew install wget
```

보통의 경우 설치하고자 하는 패키지 사이트에서 brew를 사용해서 설치하는 방법이 나와 있으므로 그대로 따라하면 됩니다.

#### Homebrew에 새로운 저장소 등록하기

`brew` 명령은 Homebrew의 저장소에서 패키지를 다운받는 명령입니다. 하지만 어떤 경우에는 원하는 패키지가 Homebrew 저장소가 아닌 다른 저장소에 있을 수도 있습니다. 이 경우 homebrew는 새로운 저장소를 등록해서 다운받을 수 있도록 하고 있습니다.

이것은 아래와 같이 `brew tap` 명령을 사용합니다. [^brew-tap]

```
$ brew tap new_repository
```

즉 위와 같이 하면 `new_repository`를 `brew`에 등록하게 됩니다. 이제 `new_repository` 에 있는 다른 패키지들도 다운 받을 수 있습니다.

예를 들어 아래와 같이 하면 `some_package`라는 패키지를 다운 받을 수 있습니다.

```sh
$ brew install some_package
```

#### 기타 사용 방법에 대한 글들

[Kevin Elliott](https://gist.github.com/kevinelliott) 님의 [macOS 10.12 Sierra Setup](https://gist.github.com/kevinelliott/7a152c556a83b322e0a8cd2df128235c) 라는 글에는 macOS 시에라에 각종 도구들을 설치하는 방법이 나오는데 Homebrew 의 다양한 사용법을 은연 중에 볼 수 있습니다. [^kevin]

[RKJun](https://rkjun.wordpress.com) 님의 [HOMEBREW 로 OS X 패키지 관리하기](https://rkjun.wordpress.com/2013/07/14/os-x-missing-package-manager-home-brew/) 라는 글에는 Homebrew 의 설치부터 사용법까지 잘 설명되어 있습니다. 특히 특정 패키지의 과거 버전을 사용하는 방법에 대해서 설명이 잘 되어 있는 것 같습니다. [^rkjun]

[주경야근](http://apple.viewtreefull.com/index.html) 님의 글 [Homebrew 설치하기](https://veryfaraway.github.io/digging/homebrew.html) 에도 설치 및 사용 방법이 잘 정리되어 있습니다. 특히, 특정 패키지의 버전을 고정하는 `brew pin` 명령에 대한 내용이 설명되어 있습니다. [^veryfaraway-homebrew]

### Homebrew 이슈 정리

이제 macOS 시에라에서 Homebrew 를 사용할 경우 발생할 수 있는 문제들에 대해 살펴봅니다. 사실 글을 작성하는 시점에서는 Homebrew 가 시에라를 공식 지원하기 때문에 문제가 해결된 것도 있지만 나중에라도 언제든 발생할 수 있는 부분이라서 기록해 둡니다.

#### `/usr/local` 폴더 권한 문제

시에라에서 부터인지 아니면 그 전 OS X에서 부터인지 잘 모르겠지만 최근의 macOS 에서는 **/usr/local/** 폴더의 권한이 변경되었습니다.

> 참고 자료에 따르면 엘 케피탄부터 변경된 것 같습니다. [^macnews-3728]

따라서 `brew install` 명령을 사용하는 과정에서 아래와 비슷한 에러가 발생하면서 설치가 안되는 경우가 있습니다.

```
==> The following existing directories will be made group writable:
/usr/local/bin
```

이것은 Homebrew 의 작동 방식이 전용 디렉토리에 패키지를 설치하고 **/usr/local** 위치로 심볼릭 링크를 연결하는 방식인데 해당 폴더에 대한 권한이 없기 때문입니다. [^symbolic-link] 즉, 패키지 자체는 설치되지만 권한 때문에 해당 패키지의 심볼릭 링크를 만들 수 없는 현상이 발생하는 것입니다.

해결 방법은 [In macOS 10.12 Sierra, /usr/local is readonly.](https://github.com/Homebrew/brew/issues/385) 라는 글에 나와 있는대로 `/usr/local` 폴더의 권한을 다음과 같이 수정하는 것입니다.

```
$ sudo chown -R $(whoami) /usr/local
```

> 참고로 위에서 `$(whoami)` 부분은 철자 그대로 입력해야 합니다.
>
> 최신 Homebrew의 경우 폴더 권한을 알아서 수정해 주는 줄 알았는데, 패키지에 따라서는 폴더 권한을 수정해야 하는 경우가 발생합니다. 일단 한 번만 폴더 권한을 수정하면 되긴 하지만 Homebrew에서 자동으로 폴더 권한을 수정하지는 않는 것 같습니다.

폴더 권한 문제이므로 `brew` 명령에 `sudo` 를 붙이면 해결할 수 있지 않을까 생각되지만, `brew` 에 `sudo` 를 사용하는 것은 위험성 때문에 운영체제에서 막고 있습니다.

`$ sudo brew` 를 실행해보면 다음과 같은 에러 메시지를 볼 수 있습니다.

```
Error: Running Homebrew as root is extremely dangerous and no longer supported.
As Homebrew does not drop privileges on installation you would be giving all
build scripts full access to your system.
```

내용을 보면 Homebrew 를 루트 권한에서 실행하는 것은 매우 위험하므로 이를 더 이상 지원 하지 않는다고 합니다. Homebrew 는 설치시 권한을 낮추지 않기 때문에 빌드 과정에서 특정 구문이 시스템의 모든 부분에 접근할 수 있기 때문이라고 합니다.  

#### brew link 이슈

`/usr/local` 폴더에 권한이 없어서 패키지 설치가 완료가 안되더라도 심볼릭 링크만 생성되지 않을 뿐이지 패키지 자체는 설치될 경우가 있습니다. 그럴 경우 아래와 같은 메시지가 출력됩니다.

```
Error: The `brew link` step did not complete successfully
The formula built, but is not symlinked into /usr/local
Could not symlink ...
/usr/local/... is not writable.
```

일단 `/usr/local` 폴더의 권한 문제는 앞서와 같이 아래 명령을 사용해서 해결할 수 있습니다.

```
$ sudo chown -R $(whoami) /usr/local
```

다만 폴더 권한 문제로 설치가 진행되다가 멈춘 경우 이미 패키지 자체는 설치되어 있지만 심볼릭 링크를 만들 수 없어서 link 관련 문제가 발생하는 것입니다.

이 경우 위의 방법으로 폴더 권한을 수정한 후 설치를 다시 수행하면 아래와 같이 `brew link`를 먼저 수행하라는 에러를 띄웁니다.

```
Error: You must `brew link ...` before ... can be installed
```

또는 아래와 같은 경고가 나타날 수도 있습니다.

```
Warning: ... already installed, it's just not linked
```

이 경우 다음과 같이 `brew link ...`를 수행해서 설치된 파일을 연결하도록 하면 문제가 해결됩니다. [^stackoverflow-37135982]

```
$ brew link ...
```

> 위의 ... 부분에 해당 패키지 명을 넣으면 됩니다.

위의 명령은 **/usr/local** 폴더 권한 문제로 링크가 연결이 안된 것을 다시 연결해 주는 의미를 갖습니다.

#### brew doctor

`brew link` 등의 명령이 안될 경우 아래의 명령으로 원인을 알 수 있다고 합니다.

```
$ brew doctor
```

현재의 문제를 파악해주는 Homebrew 명령으로 추측됩니다. 저는 아직까지 직접 사용해 본 적이 없어서 `brew doctor`에 대해서는 잘 모르겠습니다.

#### brew update 이슈

Homebrew를 사용하다가 아래처럼 upate 에러가 발생하면서 설치 등에 문제가 발생할 수 있습니다. [^tackoverflow-38410020]

```
Error: update-report should not be called directly
```

위 문제는 `brew update` 명령을 직접 사용해서 해결할 수 있습니다.

```
$ brew update
```

위와 같이 `brew update` 명령을 실행한 후에도 문제가 그대로인 경우가 있는데 이 경우 `brew upate` 명령을 다시 실행하면 `brew`가 스스로 문제를 찾는다고 합니다.

> `brew upate` 명령을 두 번 사용하는 것은 직접 설명을 보고 실행한 적이 있는데, 글을 작성하는 시점이 실행한 시점과는 다르다 보니 해당 내용이 설명된 문서를 찾지 못하고 있습니다. 찾게 되면 링크를 추가하도록 하겠습니다.
>
> 다만, 아래 내용을 보면 알겠지만 최신 Homebrew 부터는 `brew upate` 명령을 사용할 일이 없어질 것 같습니다.

이 글을 작성하고 있는 시점에서 `brew install` 명령을 사용해 보면 `brew update`가 가장 먼저 실행되는 것을 볼 수 있습니다. 참고로, 사용하고 있는 Homebrew 버전은 `Homebrew 1.1.6` 입니다.

제 기억이 맞는 지는 모르겠는데 얼마전까지는 `brew install` 명령을 실행할 때 `brew update`를 자동으로 호출하지 않았던 것으로 기억합니다. 지금은 `brew` 자체적으로 스스로를 최신 버전으로 유지하려고 하는 것 같습니다. 따라서 최신 Homebrew를 사용하면 앞으로 `brew update`를 사용할 일이 거의 없어지지 않을까 생각됩니다.

### 고찰하기

Homebrew 이슈를 겪은 시점과 글을 작성하는 시점이 달라서 과거 기억에 의존하다 보니 내용이 부정확한 부분이 있을 수 있습니다. 혹시 글을 보시고 수정할 부분이 있으면 알려주시면 감사하겠습니다.

### 참고 자료

[^brew]: [Homebrew](http://brew.sh) : Homebrew 공식 홈페이지입니다. 홈페이지에서 애플이 제공하지 않는 패키지 관리자를 제공해 준다고 당당하게 말하고 있습니다.

[^mimul-homebrew]: [Homebrew 대해](https://github.com/mimul/dev-environment/blob/master/mac-homebrew.md) : [mimul](http://www.mimul.com/pebble/default/) 님의 GitHub 저장소 글입니다. 공식 홈페이지에도 없는 Homebrew의 어원에 대해서 설명하고 있어서 인상적입니다.

[^tree]: Homebrew를 통해 설치할 수 있는 것 중에 `tree`가 있습니다. `tree`의 설치 및 사용 방법에 대해서는 따로 정리할 생각입니다.

[^brew-ko]: [Homebrew](http://brew.sh/index_ko.html) : Homebrew 공식 홈페이지 한글 버전 바로가기입니다.

[^macports]: [MacPorts](https://www.macports.org) : MacPorts 공식 홈페이지입니다.

[^brew-issues]: [In macOS 10.12 Sierra, /usr/local is readonly.](https://github.com/Homebrew/brew/issues/385) : Homebrew의 시에라 관련 이슈에 대한 예입니다. 해결 방법도 여기가 가장 간단하게 설명되어 있습니다.

[^lesstif-14745703]: [curl 설치 및 사용법 - HTTP GET/POST, REST API 연계 등](https://www.lesstif.com/pages/viewpage.action?pageId=14745703) : curl 에 대해서 이보다 더 정리를 잘할 수 있을까 싶을 정도로 정리를 잘 하신 [정광섭](https://www.lesstif.com/dashboard.action#all-updates) 님의 글입니다.

[^brew-tap]: [Taps (third-party repositories)](https://github.com/Homebrew/brew/blob/master/docs/brew-tap.md) : `brew tap` 명령에 대해서 정리한 Homebrew의 GitHub 저장소 글입니다. 일단 `brew tap` 명령에 대한 공식 문서라고 할 수 있겠습니다.

[^homebrew-installation]: [Installation](https://github.com/Homebrew/brew/blob/master/docs/Installation.md#installation) : Homebrew의 GitHub 저장소 중에서 설치관련 문서입니다. 보다 자세한 정보를 원하는 분은 참고하시면 될 것 같습니다. 특별한 일이 없으면 공식 홈페이지만으로 충분한 것 같습니다.

[^kevin]: [macOS 10.12 Sierra Setup](https://gist.github.com/kevinelliott/7a152c556a83b322e0a8cd2df128235c) : macOS 시에라에서 여러가지 Homebrew를 사용해서 여러가지 도구들을 셋업하는 방법을 소개한 글입니다. 지금 시점에서 꼭 필요하지 않을 수도 있지만 Homebrew에 문제가 있을 경우의 다양한 방법들이 은연 중에 녹아 있습니다. `brew pin`, `brew tap` 등의 옵션들을 자유자재로 사용하는 것을 볼 수 있습니다.

[^rkjun]: [HOMEBREW 로 OS X 패키지 관리하기](https://rkjun.wordpress.com/2013/07/14/os-x-missing-package-manager-home-brew/) : Homebrew의 여러가지 사용법에 대해서 설명을 잘 해놓은 [RKJun](https://rkjun.wordpress.com) 님의 글입니다. 다만 텍스트와 코드가 분리가 되지 않아서 글을 보기가 살짝 불편한 것 같습니다. 하지만 내용이 워낙 좋아서 한 번 찬찬히 볼 만하다고 생각합니다.

[^veryfaraway-homebrew]: [Homebrew 설치하기](https://veryfaraway.github.io/digging/homebrew.html) : Homebrew의 설치 방법과 사용법에 대해서 정리한 [주경야근](http://apple.viewtreefull.com/index.html) 님의 글입니다. 조금 특이하게 `brew pin` 명령에 대한 설명이 나와서 기록 차원에서 참조를 연결합니다.

[^macnews-3728]: [OS X 10.11 엘 캐피탄에 '홈브류(Homebrew)'를 설치하는 방법](http://macnews.tistory.com/3728) : 엘 케피탄에서의 Homebrew 이슈와 시스템 무결성 보호에 대한 내용이 잘 정리되어 있습니다. 이 글에 따르면 엘 케피탄부터 적용된 시스템 무결성 보호 정책 때문에 Homebrew 이슈가 발생하게 된 것 같습니다.

[^symbolic-link]: [심볼릭 링크](https://ko.wikipedia.org/wiki/심볼릭_링크) : 심볼릭 링크에 대한 한글 위키피디아 설명입니다.

[^stackoverflow-37135982]: [cmake-3.5.2 already installed, it's just not linked](http://stackoverflow.com/questions/37135982/cmake-3-5-2-already-installed-its-just-not-linked) : cmake의 link가 연결되지 않을 경우의 해결 방법에 대한 글입니다. `brew link`의 사용 방법이 잘 나와 있습니다.

[^tackoverflow-38410020]: [Homebrew: Error: update-report should not be called directly](http://stackoverflow.com/questions/38410020/homebrew-error-update-report-should-not-be-called-directly)
