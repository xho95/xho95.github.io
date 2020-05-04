여기서는 맥에 설치되어 있는 Git을 업데이트 하는 방법을 정리합니다.

Homebrew에 대한 내용은 다른 글을 참고하시기 바랍니다.

Git 사용법에 대한 내용은 다른 글을 참고하시기 바랍니다.

### 버전 확인하기

git의 버전은 아래와 같은 옵션으로 알 수 있습니다.

```
$ git --version
```

#### macOS 의 git

macOS에 자체적으로 설치된 git이 있을 경우 아래와 같이 나타납니다.

```
git version 2.10.1 (Apple Git-78)
```

위의 git은 macOS Sierra에 설치된 git입니다.

which git의 결과는 아래와 같습니다.

```
$ which git

/usr/bin/git
```

#### 별도 설치한 git

Homebrew 등으로 따로 설치한 경우 아래와 같이 나타납니다.

```
git version 2.8.1
```

which git의 결과는 아래와 같습니다.

```
$ which git

/usr/local/bin/git
```

> `brew insall git`으로 설치한 경우가 아니면,
>
> ```
> Error: git not installed
> ```
> 라고 에러가 발생합니다.

### Git Config 내용 보기

터미널에서 아래와 같이 입력하면 Git 관련 설정을 확인할 수 있습니다.

```
$ git config --list
```

아래과 같이 결과가 나타납니다.

```
credential.helper=osxkeychain
user.name=...
user.email=...
```

### 업데이트

[Install and Update to latest version Git on Mac OSX 10.11 El Capitan](https://coolestguidesontheplanet.com/install-update-latest-version-git-mac-osx-10-9-mavericks/) 같은 글이 있는데 기존 버전을 삭제하고 새로 설치하는 방법을 설명하고 있습니다. [^update-latest-version-git] 딱히 다른 방법은 없는 모양입니다. 더 알아볼 필요가 있습니다.

아예 애플에서 제공하는 Git을 쓰지 않고, Homebrew로 Git을 새로 설치하고 업데이트하는 방법은 Michael Crump님의 [Step-by-Step on How to Update Git on Mac](http://michaelcrump.net/step-by-step-how-to-update-git/) 글에 설명되어 있습니다. [^michaelcrump-update-git]

[How to upgrade Git (Mac OSX)](https://medium.com/@katopz/how-to-upgrade-git-ff00ea12be18)

[Installing and upgrading Git](https://confluence.atlassian.com/crucible045/installing-and-upgrading-git-947848144.html)

### 참고 자료

[^update-latest-version-git]: [Install and Update to latest version Git on Mac OSX 10.11 El Capitan](https://coolestguidesontheplanet.com/install-update-latest-version-git-mac-osx-10-9-mavericks/)

[^michaelcrump-update-git]: [Step-by-Step on How to Update Git on Mac](http://michaelcrump.net/step-by-step-how-to-update-git/)
