---
layout: post
pagination: 
  enabled: true
comments: true
title:  "macOS: 기본 쉘 (shell) 이 된 zsh 설정하기"
date:   2020-03-04 11:30:00 +0900
categories: macOS CLI shell zsh
---

macOS 버전 10.15 인 '카탈리나' 부터 기본 쉘 (Shell) 이 bash[^bash] 에서 zsh (Z shell)[^zsh] 로 변경 되었습니다.[^Use-zsh] 일단 쉘을 변경한 이유를 애플에서 직접 밝히진 않았지만, The Verge 라는 언론에서는 bash 쉘의 라이센스와 연관된 것으로 추측하고 있습니다.[^the-Verge] 이 기사와 애플의 설명을 보면 여러 후보군 중에서 zsh 을 선택한 것은 라이센스 문제를 해결하면서도 기존 bash 쉘과의 호환성을 최대한 지원하기 위함인 것 같습니다.[^Bourne-shell]

사실 zsh 자체는 맥 사용자에게 오래전부터 알려려 있던 것으로, 한 때 [iTerm2](https://iterm2.com)[^iTerms2] 라는 터미널 프로그램이 유행하면서 'Oh My Zsh'[^ohmyzsh] 로 쉘을 변경하는 경우가 꽤 있었던 기억이 납니다. 다만 저는 개인적으로 어지간하면 기본 세팅을 변경하지 않는 사람이여서 zsh 이 있다는 것을 알고만 있었는데, 언젠가부터 터미널을 사용할 때마다 아래와 같은 메시지가 뜨길래 맥의 기본 쉘이 변경된 것을 알게됐습니다.[^recognized]

![bash-shell](/assets/macOS/bash-shell.png)

그런데 '카탈리나' 부터 기본 쉘이 zsh 이 되었다고 해도, 위 메시지가 계속 뜨는 것은 기본 쉘이 아직 bash 라는 것을 의미합니다. 아마도 원래 bash 쉘을 쓰고 있던 사람은 OS 를 업데이트하더라도 기본 설정이 유지되기 때문인 것 같습니다.

참고로 자신의 기본 쉘이 어떤 것인지는 스크린샷에서 표시한 것처럼 터미널의 제목 부분을 보면 알 수 있습니다. 터미널을 실행할 때 위에서처럼 제목에 `bash` 가 표시된다면 기본 쉘이 `bash` 인 것입니다.

### 현재 맥에 설치되어 있는 쉘 확인하기

일단 zsh 쉘로 변경하기 전에, 우선 컴퓨터에 설치되어 있는 쉘에는 어떤 것들이 있는지 확인해 보겠습니다. 현재 컴퓨터에 설치되어 있는 쉘을 확인하려면 다음과 같은 명령을 이용하면 됩니다.

```zsh
$ cat /etc/shells
```

`cat` 명령은 지정된 파일의 내용을 보여주는 명령으로, 여기서는 **etc** 디렉토리[^etc-directory]에 있는 **shells** 파일의 내용을 보여달라는 의미입니다. 저의 경우 결과가 아래와 같았습니다.

```zsh
# List of acceptable shells for chpass(1).
# Ftpd will not allow users to connect who are not using
# one of these shells.

/bin/bash
/bin/csh
/bin/dash
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh
```

macOS '카탈리나' 에는 기본적으로 위와 같이 다양한 쉘들이 설치되어 있음을 알 수 있습니다. 물론 이중에서 자신이 원하는 쉘은 어느 것이든 사용할 수 있습니다. 하지만 어쨌든 애플에서는 기본 쉘로 zsh 를 권장하고 있으니, 이제 기본 쉘을 zsh 로 변경하고 간단하게 테마를 지정해보도록 하겠습니다.

### 기본 쉘을 zsh 로 변경하기

macOS 의 기본 쉘을 변경하려면 터미널을 실행할 때마다 나온 메시지에서 알려준 것처럼 터미널에서 아래와 같은 명령을 입력하면 됩니다.

```zsh
$ chsh -s /bin/zsh
```

위에서 `chsh` 는 `chpass` 와 동일한 것으로, 사용자의 데이터베이스 정보를 추가하거나 변경하는 '유틸리티' 입니다. 여기서 옵션 `-s` 를 붙여서 `chsh -s` 라고 하면, 사용자의 쉘을 바꾸겠다는 의미가 됩니다.

위 명령을 실행하고 암호를 입력해도 막상 달라지는 것은 없는 것 같아 보입니다. 왜냐면 터미널은 그 자체로 하나의 프로세스이기 때문에 새 설정을 적용하려면 기존 터미널을 닫고 새 터미널을 실행해야 하기 때문입니다.

기존 터미널을 닫고 새 터미널을 열면 아래와 같이 업데이트할 것인지를 묻는데, Y를 입력해서 업데이트를 진행합니다.

```zsh
$ [Oh My Zsh] Would you like to check for updates? [Y/n]: Y
Updating Oh My Zsh
remote: Enumerating objects: 9987, done.

...

Fast-forwarded master to 93a2ba6b5f562385f29188cd363329dc2d835959.
        __                                     __   
 ____  / /_     ____ ___  __  __   ____  _____/ /_  
/ __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \
/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / /
\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/  
                       /____/                       
Hooray! Oh My Zsh has been updated and/or is at the current version.
To keep up on the latest news and updates, follow us on twitter: https://twitter.com/ohmyzsh
Get your Oh My Zsh swag at:  http://shop.planetargon.com/
/Users/kimminho/.oh-my-zsh/lib/directories.zsh:32: command not found: compdef
[oh-my-zsh] Random theme '/Users/kimminho/.oh-my-zsh/themes/ys.zsh-theme' loaded...
...

# kimminho @ xho95s-MacBook-Pro in ~ [16:00:12]
$
```

업데이트가 완료되면 위와 같은 결과를 출력합니다. 이제 아래 스크린샷에서와 같이 터미널 제목에서 zsh 이 기본 쉘임을 보여주고 있습니다.

![zsh-shell](/assets/macOS/zsh.png)

일단 zsh 을 보면 처음에 색깔이 알록달록한 것이 살짝 거슬리기는 하지만, 무엇보다 해당 디렉토리의 Git 상태를 표시해 주는 것은 좋은 것 같습니다. 저는 이 블로그를 Git 으로 관리하고 있는데 블로그 디렉토리로 가면 자동으로 `branch` 와 `git status` 를 바로 확인할 수 있습니다.

이래서 예전부터 주위 개발자들이 저보고 zsh 를 써랴고 했었던 거 같은데, 이제서야 쓰게 됐습니다. 저와 달리 Git 을 자주 사용하는 프로페셔널한 개발자라면 진작부터 zsh 을 써왔을 것 같습니다.

![zsh-shell-and-git](/assets/macOS/zsh-git.png)

하지만 zsh 의 화면이 위와 다른 분들이 많을 것입니다. 확인해보니 zsh 의 테마 설정이 random 으로 되어 있어서 터미널을 새로 시작할 때마다 다른 테마가 나타나는 것이었습니다. 현재 zsh 에 설정된 테마를 확인하려면 아래와 같은 명령을 실행해서 `ZSH_THEME` 부분을 확인하면 됩니다.

```zsh
$ cat ~/.zshrc
.
.
ZSH_THEME="random"
.
.
```

아마도 zsh 측에서 여러 가지 테마가 있으니 써보고 결정해라는 의미로 이렇게 한 것 같은데, 터미널을 실행할 때마다 테마가 변경되는 것이 싫으면 원하는 테마로 지정하도록 설정을 변경하면 됩니다.

### zsh 테마 지정하기

물론 테마를 지정하려면 어떤 테마들이 있는지 알아야 합니다. zsh 에서 제공하는 테마들은 **ohmyzsh/ohmyzsh** 의 [Themes](https://github.com/ohmyzsh/ohmyzsh/wiki/themes) 문서에 정리되어 있으며, 각 테마들의 스크린샷을 확인할 수 있어서 보고 마음에 드는 테마를 선택할 수 있습니다.

테마를 지정하는 가장 간단한 방법은 [Themes](https://github.com/ohmyzsh/ohmyzsh/wiki/themes) 와 **macOS Setup Guide** 의 [zsh](https://sourabhbajaj.com/mac-setup/iTerm/zsh.html) 문서에 잘 설명되어 있습니다.[^mac-setup]

일단 저는 우연인지는 모르겠는데 앞서 스크린샷에서 보여드린 설정이 가장 심플하고 마음에 들어서 찾아보니 테마 이름이 `ys` 였습니다. 그래서 아래와 같이 `~/.zshrc` 문서를 수정하여 random 테마를 주석 처리하고 `ys` 를 테마로 지정했습니다.[^ysmood]

```zsh
$ cat ~/.zshrc
.
.
# ZSH_THEME="random"
ZSH_THEME="ys"
.
.
```

이제부터 터미널을 새로 시작해도 지정한 테마로만 실행되는 것을 알 수 있습니다.

> 테마는 **ohmyzsh/ohmyzsh** 의 [Customization](https://github.com/ohmyzsh/ohmyzsh/wiki/Customization) 문서에서 보듯이 Plugin 을 활용하여 사용자가 직접 원하는 방식으로 수정할 수도 있습니다. 자신만의 테마를 구성하고 싶은 분들은 참고하시기 바랍니다.

### zsh 기타 장점들 알아보기

그 외에도 위키피디아의 [Comparison of command shells](https://en.wikipedia.org/wiki/Comparison_of_command_shells) 라는 글을 보면 각 쉘들을 비교해서 표로 만들어 둔 자료가 있는데, 이 자료를 보면 bash 보다 zsh 이 좋은 점이 정리되어 있습니다. 그 중에서 몇가지를 옮겨보면 다음과 같습니다.[^comparison]

* 기본 기능은 두 개가 서로 엇비슷한데 `zsh` 은 코드를 추가해서 마우스를 지원하도록 할 수 있습니다.
* 사용 편의성 면에서는 `zsh` 가 자동 제안 및 수정 기능을 제공하며, 문맥에 맞는 도움말도 지원한다고 합니다.
* 프로그래밍 측면에서는 `zsh` 가 부동-소수점 수와 수학 함수 라이브러리를 제공한다고 합니다.[^zsh-programming]
* 문자열 처리나 파일 탐색 등의 기능은 `zsh` 이 전체 기능을 다 지원하고 있습니다.

저도 아직 `zch` 을 많이 사용한 것은 아니라 소개하는데 한계는 있지만, 혹시라도 나중에 사용하다가 새로운 기능들을 알게되면 다시 정리하도록 하겠습니다.

### 생각해보기

애플의 강요이든 본인의 선택이든 이제 맥 사용자라면 기본 쉘로 `zsh` 을 사용해야 하는 시대가 되었습니다. 중요한 것은 어떤 도구를 사용하는 것이 아니라 그 도구로 무엇을 할 것인가인지도 모릅니다. 이 글이 조금이나마 `zsh` 을 사용하는데 도움이 되었길 바랍니다.

### 참고 자료

[^bash]: bash 쉘에 대해서는 위키피디아의 [Bash (Unix shell)](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) 항목을 보도록 합니다.

[^zsh]: zsh (Z 쉘) 에 대해서는 위키피디아의 [Z shell](https://en.wikipedia.org/wiki/Z_shell) 항목을 보도록 합니다.

[^Use-zsh]: 보다 자세한 내용은 [Use zsh as the default shell on your Mac](https://support.apple.com/en-us/HT208050) 에서 확인할 수 있습니다.

[^the-Verge]: 원문으로 된 기사는 [Apple replaces bash with zsh as the default shell in macOS Catalina](https://www.theverge.com/2019/6/4/18651872/apple-macos-catalina-zsh-bash-shell-replacement-features) 에서 확인할 수 있습니다. 일단 이 기사에서는 bash 쉘의 최신 버전이 GPLv3 라이센스인 것과 관계가 있다고 보고 있습니다.

[^Bourne-shell]: bash 쉘은 [Brian Jhan Fox](https://en.wikipedia.org/wiki/Brian_Fox_(computer_programmer)) 가 1989년 최초로 공개한 쉘로, 이는 1979년 벨 연구소의 [Stephen R. Bourne](https://en.wikipedia.org/wiki/Stephen_R._Bourne) 이 공개한 Bourne 쉘을 대체하기 위한 것이었습니다. 애플의 설명에 의하면 zsh 는 이 Bourne shell 과의 호환성이 아주 높기 때문에, bash 쉘과도 약간의 차이점을 제외하면 거의 대부분의 기능이 호환된다고 합니다. 이런 이유로 zsh 을 채택하게 된 것 같습니다.

[^iTerms2]: 저도 예전에 아주 잠깐 써본 기억이 납니다. [iTerm2](https://iterm2.com) 에서 보다 자세하게 알 수 있습니다.

[^ohmyzsh]: Oh My Zsh 의 GitHub 계정은 [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) 입니다. 여기서 Oh My Zsh 에 대해 더 많은 정보를 확인할 수 있습니다.

[^recognized]: 실제 맥의 기본 쉘이 변경된 것은 카탈리나가 공개된 후이므로 2019년 10월 경입니다. 물론 기본 쉘이 변경될 것이라는 것을 공개한 것은 WWDC 2019 였으므로, 2019년 6월입니다. 제가 맥의 기본 쉘이 변경되었다는 것을 그만큼 늦게 인지하게 된 것은, WWDC 2019 발표 당시 제가 회사 출장 관계로 개인 PC 를 거의 쓰지 못해서 터미널을 쓸 일이 없었기 때문입니다. 생각해보니 WWDC 2019 발표를 직접 보지도 못했었군요.

[^etc-directory]: macOS 에서 **/etc** 디렉토리는 주로 환경 설정 파일들이 존재하는 곳입니다. 보다 자세한 내용은 [macOS: 파일 시스템의 기본 디렉토리 구조]({% post_url 2020-04-20-macOS-File-System-Layout %}) 를 참고하시기 바랍니다.

[^mac-setup]: [macOS Setup Guide](https://sourabhbajaj.com/mac-setup/) 의 [zsh](https://sourabhbajaj.com/mac-setup/iTerm/zsh.html) 라는 문서를 보면 테마 외에도 Plugin 등의 설정을 하는 방법도 설명되어 있습니다. 이 외에도 macOS 를 설정하는 다양한 방법들이 설명되어 있으니 참고하면 좋을 것 같습니다.

[^ysmood]: [Yad Smood](https://blog.ysmood.org)님의 [My terminal theme](https://blog.ysmood.org/my-ys-terminal-theme/) 문서에는 자신이 `zsh` 를 설정한 방법이 나오는데, 참고할만한 것 같습니다. 저도 기회가 되면 저만의 설정을 만들어서 공유할 수 있도록 해보겠습니다.

[^comparison]: 여기서 정리한 내용은 대략적인 내용을 옮겨놓은 것으로 각각에 대한 자세한 내용은 위키피디아의 [Comparison of command shells](https://en.wikipedia.org/wiki/Comparison_of_command_shells) 글을 참고하시기 바랍니다.

[^zsh-programming]: 이 말이 아직 뭔지는 잘 모르겠습니다. 아마도 쉘 스크립트를 작성할 때 수학 함수를 쓸 수 있다는 의미인 것 같습니다. 혹시 아시는 분은 댓글 남겨주시면 감사하겠습니다.
