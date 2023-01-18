---
layout: post
pagination:
  enabled: true
comments: true
title:  "macOS: 맥에서 SSH 키 생성하고 사용하기"
date:   2017-02-22 02:00:00 +0900
categories: macOS Security OpenSSH SSH GitLab
redirect_from: "/macos/security/openssh/ssh/gitlab/2017/02/21/Using-SSH-on-Mac.html"
---

컴퓨터로 어딘가에 접속하려다 보면 SSH 를 사용해야 하는 경우가 생깁니다. [SSH (Secure Shell)](https://en.wikipedia.org/wiki/Secure_Shell) [^wikipedia-ssh] 는 보안되지 않는 네트웍에서도 네트웍 서비스를 안전하게 운영하기 위한 암호화 기반 네트웍 프로토콜을 말하는데, 가장 대표적인 예는 사용자가 컴퓨터 시스템에 원격으로 로그인하는 것입니다. [^understanding-ssh]

특히 최근에는 버전 관리 도구로 Git 을 많이 사용하는데, Git 을 사용할 경우 필수라고 할 수 있는 [GitHub](https://github.com) [^github] 와 [GitLab](https://gitlab.com) [^gitlab] 같은 온라인 저장소 서비스들이 모두 SSH 를  기본으로 지원하고 있습니다.

이 글에서는 인터넷을 사용하는데 필수 요소가 되고 있는 SSH 를 생성하고 사용하는 방법에 대해서 정리합니다. SSH 생성 방법은  기본 (default) 생성 방법과 더불어 GitLab 등을 위해 적당히 옵션을 주고 생성하는 방법도 별도로 설명합니다.

### SSH 키(Key) 생성하기

#### SSH 키 확인하기

새로운 SSH 키를 생성하기 전에 시스템에 이미 SSH 가 있는지 확인합니다. 터미널에서 아래와 같은 명령을 실행합니다. [^cat]

```
$ cat ~/.ssh/id_rsa.pub
```

만약 `ssh-rsa` 로 시작하는 문자열이 보이면 이미 SSH 키 쌍(key pair) 를 가지고 있는 것이므로 새로 SSH 를 만들 필요없이 공개 SSH 키를 바로 사용하면 됩니다.

하지만 아래와 같은 결과가 나오면 아직 SSH 키가 없는 것이므로 새로 SSH 키 쌍을 만들어야 합니다.

```
cat: /.../.ssh/id_rsa.pub: No such file or directory
```

아니면 다음처럼 **~/.ssh** 디렉토리로 가서 내용을 확인해 봐도 됩니다. [^git-scm]

```
$ cd ~/.ssh
$ ls
```

해당 디렉토리에 아무런 파일이 없거나 디렉토리 자체가 없으면 새로 SSH 키를 만들어야 합니다.

#### SSH 키 쌍 만들기

SSH 키를 만드는 것은 아주 쉽습니다. 아래와 같이 간단한 명령으로 새로운 SSH 키를 만들 수 있습니다.

```
$ ssh-keygen
```

macOS 는 유닉스 계열 운영체제로 [OpenSSH](https://www.openssh.com) 를 기본으로 포함하고 있기 때문에 위와 같이 간단하게 생성할 수 있습니다. [^openssh]

리눅스는 사실상 macOS 와 생성 방법이 같으며, Windows 운영 체제의 경우에는 [SSH 접속 설정](https://backlogtool.com/git-guide/kr/reference/ssh.html) 이라는 글에 방법이 잘 나와 있습니다. [^backlogtool-ssh]

그려면 아래와 같이 키 쌍을 저장할 파일 이름을 입력하라고 나옵니다.

```
Enter file in which to save the key (/Users/.../.ssh/id_rsa):
```

보통의 경우 그대로 엔터키를 눌러서 디폴트 값인 `is_rsa` 를 사용합니다. 만약 같은 파일이 있다면 다른 이름을 지정하면 됩니다.

> 파일 이름 뿐만이 아니라 경로까지 다르게 할 경우에는 GitLab 관련 이슈가 있습니다. [^non-default-ssh-key]

그 다음에는 비밀 번호를 입력하라고 나오는데 보통의 경우에는 따로 비밀번호를 입력하지 않고 넘어갑니다. 원한다면 비밀번호를 등록하면 됩니다.

### SSH 키 등록하기

이제 만들어진 공개키를 접속 하려는 서버에 등록하면 됩니다. 이후로는 SSH 로 해당 서버에 접속할 수 있습니다.

#### SSH 키 복사하기

맥에서 다음과 같은 명령을 사용해서 공개키를 클립보드로 복사할 수 있다고 합니다. 이렇게 하면 터미널 명령으로 바로 파일 내용을 복사할 수 있습니다.  

```
$ pbcopy < ~/.ssh/id_rsa.pub
```

물론 아래처럼 `cat` 명령을 실행한 다음 보여지는 공개키를 마우스로 복사해도 상관없습니다.

```
$ cat ~/.ssh/id_ras.pub
```

#### SSH 키 등록하기

SSH 키를 등록하는 방법은 각각의 서버에 설명이 나와 있는 대로 따르면 됩니다.

예를 들어, GitLab의 경우에는 계정에서 **Profile Settings > SSH Keys** 메뉴를 선택하면 나타나는 페이지의 **Key** 섹션에 공개키를 복사해 넣으면 됩니다 (SSH Keys 메뉴는 상단의 탭에 있습니다.)

### GitLab 에서 SSH 사용하기

GitLab 의 [SSH](https://docs.gitlab.com/ce/ssh/README.html) 문서에 따르면 공개키가 없으면 GitLab 의 암호와된 정보에 접근할 수 없다고 합니다. [^gitlab-ssh]

따라서 공개키 없이 `push` 하려고 서버에 접근하면 에러를 띄웁니다. 이 문제를 해결하려면 SSH 키를 등록하면 됩니다.

```
$ git push -u origin master

The authenticity of host 'gitlab.com (...)' can't be established.
```

#### SSH 생성하기

GitLab 을 위해서 SSH 를 생성할 때는 보통의 SSH 생성과는 다르게 옵션이 추가됩니다. 터미널에 다음과 같이 입력해서 SSH 키를 만듭니다.

```
$ ssh-keygen -t rsa -C "GitLab" -b 4096
```

`-t` 옵션은 SSH 키의 타입을 지정하기 위한 것으로 `rsa` 로 지정했습니다.  `-C` 옵션은 주석을 뜻하며 `"GitLab"` 을 위해 만들었음을 표시합니다. [^haruair-2220] `-b` 옵션은 비트수를 지정하는 부분인데 원래 기본 값은 2048이지만, GitLab 은 그 두 배인 4096 을 사용해서 키를 만듭니다. [^storycompiler-112] [^linux-ssh-keygen]

`ssh-keygen` 관련 옵션이 궁금할 경우 아래와 같이 `man` 명령을 사용해서 확인할 수도 있습니다만, 확실히 터미널에서 보기에는 분량이 많아서 조금 불편합니다.

```
$ man ssh-keygen
```

[FreeBSD Man Pages](https://www.freebsd.org/cgi/man.cgi?query=ssh-keygen&sektion=1&manpath=OpenBSD) 페이지에서 `ssh-keygen` 옵션을 확인할 수 있으니 필요하면 웹 브라우저를 통해 확인하시기 바랍니다. [^freebsd-ssh-keygen]

#### SSH 등록하기

GitLab의 계정에서 **Profile Settings > SSH Keys** 메뉴를 선택합니다. SSH Keys 메뉴는 상단의 탭에 있습니다. [^pseg-5966]

복사한 공개키를 **Key** 섹션에 붙여 넣습니다. **Title** 부분에는 구분 가능한 적당한 이름을 붙여줍니다. 예를 들어, `"My MacBook - macOS"` 이나 `"Home Desktop - Linux"` 같은 것을 입력할 수 있습니다.

#### GitLab에 접속해서 push 하기

이제 아래처럼 GitLab 에 접속해서 저장소에 `push` 할 수 있습니다.

```
$ git push -u origin master
```

SSH 키를 만들 때 암호를 입력했으면 아래와 같은 문구가 뜨는데 암호를 입력하면 됩니다.

```
Enter passphrase for key '/Users/.../.ssh/id_rsa':
```

암호를 입력하고 나면 정상적으로 GitLab에 `push` 되는 것을 볼 수 있습니다.

> 물론 GitLab 에 `push`를 하려면 그전에 아래처럼 remote 로 등록해 두어야 합니다.
>
> ```
> $ git remote -v
> origin	git@gitlab.com:.../....git (fetch)
> origin	git@gitlab.com:.../....git (push)
> ```
>
> git 에 remote 저장소를 등록하는 방법은 참고 자료를 보면 됩니다.

### GitHub 에서 SSH 사용하기

GitHub 의 경우 HTTPS 접속을 많이 해서 SSH 를 사용하는 경우가 적은데, GitHub 에서 SSH 로 접속하려면 [Connecting to GitHub with SSH](https://help.github.com/articles/connecting-to-github-with-ssh/) 글을 보면 됩니다. [^github-with-ssh]

전체 흐름은 GitLab 의 경우와 사실상 같기 때문에 따로 정리하지는 않겠습니다.

### SSH 로 원격 서버에 접속하기

그 외에도 SSH 를 사용해서 원격 서버에 접속하는 방법은 다음과 같습니다.

```
$ ssh user-id@ip-address -p port-number
```

위의 경우는 주소가 `ip-address` 이고 포트가 `port-number` 인 원격 서버에 `user-id` 로 접속하는 방법입니다. [^necoaki-54] 이렇게 하면 최초 접속 시에 SSH 키를 생성하고 등록하는 과정을 거입니다. [^eunguru-122]

예를 들어 `user-id` 가 `test` 이고, 주소 및 포트가 각각 `127.0.0.1` 과 `22` 라면 다음과 같을 것입니다. [^mirwebma-119]

```
$ ssh test@127.0.0.1 -p 22
```

### 고찰하기

[Swift: 리눅스에서 Swift 개발 환경 구축하기]({% post_url 2017-02-16-Developing-Swift-on-Linux %}) 라는 글에서도 정리했듯이 SSH 말고도 유사한 기술로 [PGP](https://ko.wikipedia.org/wiki/PGP_(소프트웨어)) 라는 것도 있는 것 같습니다. 오픈 소스를 사용하다 보면 비슷비슷한 기술들이 동시에 경쟁하는 것을 볼 수 있는데, 기술의 변화에 유연하게 대처할 수 있도록 틈틈이 관련 내용을 익혀둬야 할 것 같습니다.

### 참고 자료

[^wikipedia-ssh]: 위키피디아의 [Secure Shell](https://en.wikipedia.org/wiki/Secure_Shell) 에는 SSH 에 대한 내용이 잘 설명되어 있습니다. 한글 문서는 [시큐어 셸](https://ko.wikipedia.org/wiki/시큐어_셸) 에서 보면 됩니다. 원문은 글이 길어서 전공자가 아니라면 굳이 전체를 다 볼 필요는 없을 것 같습니다.

[^understanding-ssh]: [Understanding the SSH Encryption and Connection Process](https://www.digitalocean.com/community/tutorials/understanding-the-ssh-encryption-and-connection-process) 라는 글에는 SSH 의 동작 원리에 대해서 설명이 잘 되어 있습니다. SSH 에 대해서 좀 더 알고 싶은 사람은 참고하면 좋겠지만, SSH 를 사용하기 위해 이 내용을 다 볼 필요는 없을 것 같습니다. 저도 나중에 틈나면 한 번 보려고 링크를 연결해 두었습니다.

[^github]: [GitHub](https://github.com) 는 소스 관리 저장소의 표준이라고 할 수 있습니다. SSH 와 HTTPS 접근을 허용하고 있습니다.

[^gitlab]: [GitLab](https://gitlab.com) 은 속도가 조금 느린 것 같지만 무제한 비공개 저장소를 만들 수 있어서 GitHub 만큼이나 많이 쓰게 되는 온라인 저장소 서비스입니다. 역시 서버에 SSH 로 접근할 수 있도록 하고 있습니다.

[^cat]: `cat` 명령은 macOS 또는 리눅스에서 특정 파일의 내용을 보여주는 쉘 명령어입니다. macOS 의 쉘 명령어에 대해서는 다음에 따로 정리할 예정입니다.

[^git-scm]: Git 공식 홈페이지에 있는 [4.3 Git 서버 - SSH 공개키 만들기](https://git-scm.com/book/ko/v2/Git-서버-SSH-공개키-만들기) 글에는 SSH 를 생성하는 방법이 잘 정리되어 있습니다. Git 에서 설명하는 것이라 가장 확실한 자료라고 할 수 있습니다.

[^openssh]: 공식 홈페이지인 [OpenSSH](https://www.openssh.com) 에 가면 `ssh-keygen` 역시 OpenSSH 에서 제공하는 도구의 하나임을 알 수 있습니다.

[^backlogtool-ssh]: [SSH 접속 설정](https://backlogtool.com/git-guide/kr/reference/ssh.html) 이라는 글은 Nulab 이라는 곳에서 공개한 온라인 책인 [누구나 쉽게 이해할 수 있는 Git 입문](https://backlogtool.com/git-guide/kr/) 에 있는 글입니다. 책 전체를 공개해 놓은 것을 보면 정말 대인배인 것 같습니다.

[^non-default-ssh-key]: 파일 경로가 기본 값이 아닌 경우 이 SSH 키를 GitLab 에 사용하고자 한다면 GitLab 홈페이지의 [Working with non-default SSH key pair paths](https://docs.gitlab.com/ce/ssh/README.html#working-with-non-default-ssh-key-pair-paths) 글을 먼저 참고 하시기 바랍니다. 물론 가능한한 기본 경로를 사용할 것을 추천합니다.

[^gitlab-ssh]: GitLab 에서 정리한 [SSH](https://docs.gitlab.com/ce/ssh/README.html) 관련 공식 문서에는 GitLab 이 비대칭 암호기술 (asymmetric cryptography) 을 사용하여 통신 채널을 암호화하기 때문에 공개키를 가지고 있지 않으면 암호화된 정보에 접근할 수 없다고 설명하고 있습니다.

[^haruair-2220]: [haruair](http://www.haruair.com) 님의 [ssh 인증키 생성 및 서버에 등록하기](http://www.haruair.com/blog/2220) 라는 글에는 SSH 키를 생성하는 방법이 옵션과 함께 깔끔하게 설명되어 있습니다.

[^storycompiler-112]: [윤진](http://storycompiler.tistory.com) 님의 [Ubuntu/Linux: ssh 공개키의 모든 것](http://storycompiler.tistory.com/112) 이라는 글에도 SSH 키 관련 옵션이 상세하게 나와 있습니다.

[^linux-ssh-keygen]: ssh-kengen 명령의 옵션에 대해서 더 알고 싶으면 [ssh-keygen(1) - Linux man page](https://linux.die.net/man/1/ssh-keygen) 라는 곳을 방문하면 도움이 될 것 같습니다. 다만, 사이트를 둘러보기에는 좀 불편한 것 같습니다.

[^freebsd-ssh-keygen]: macOS 가 FreeBSD 기반이어서인지 `$ man ssh-keygen` 의 결과와 [FreeBSD Man Pages](https://www.freebsd.org/cgi/man.cgi?query=ssh-keygen&sektion=1&manpath=OpenBSD) 에 있는 설명이 완전히 동일한 것 같습니다.

[^pseg-5966]: [PSEG](http://pseg.or.kr/pseg/) 라는 그룹의 [GitLab 공개키 등록하기](http://pseg.or.kr/pseg/?mid=infouse&search_target=tag&search_keyword=SSH&document_srl=5966) 라는 글에는 그림과 함께 GitLab 에 공개키를 등록하는 방법이 잘 나와 있습니다. 다만 GitLab UI 가 변경된 것이 반영이 안된 것 같습니다. 그래도 보는데는 큰 문제가 없을 것 같습니다.  

[^github-with-ssh]: GitHub 에서 제공하는 [Connecting to GitHub with SSH](https://help.github.com/articles/connecting-to-github-with-ssh/) 문서는 SSH 에 대한 설명이 원리부터 접속 방법까지 예제 코드와 그림까지 곁들여서 아주 잘 되어 있습니다. 굳이 따로 정리가 필요없을 것 같습니다.

[^necoaki-54]: [db.necoaki.net](http://db.necoaki.net) 님의 [Mac 터미널에서 ssh 접속하는 방법](http://db.necoaki.net/54) 이라는 글에서는 터미널에서  SSH 로 원격 서버에 접속하는 방법이 아주 간단하게 정리되어 있습니다.

[^eunguru-122]: [eunguru](http://eunguru.tistory.com) 님의 [Mac에서 기본 터미널로 SSH 연결하기](http://eunguru.tistory.com/122) 글에는 터미널과 터미널 UI 를 이용해서 SSH 로 원격 서버에 접속하는 방법이 아주 잘 설명되어 있습니다.

[^mirwebma-119]: [Mir](http://mirwebma.tistory.com) 님의 [리눅스 서버 접속하기](http://mirwebma.tistory.com/119) 라는 글에서 SSH 접속의 기본 포트는 `22` 라는 설명이 나옵니다.
