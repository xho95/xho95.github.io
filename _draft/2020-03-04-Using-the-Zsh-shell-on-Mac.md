---
layout: post
comments: true
title:  "macOS: Catalina (카탈리나) 부터 기본 쉘이 된 zsh 알아보기"
date:   2020-03-04 11:30:00 +0900
categories: macOS CLI Shell zsh
---

macOS 버전 10.15 인 '카탈리나' 부터 기본 쉘 (Shell) 이 bash[^bash] 에서 zsh (Z shell)[^zsh] 로 변경 되었습니다.[^Use-zsh] 일단 쉘을 변경한 이유를 애플에서 직접 밝히진 않았지만, The Verge 라는 언론에서는 bash 쉘의 라이센스와 관련된 이유인 것으로 추측하고 있습니다.[^the-Verge] 이 기사를 보면 여러 후보군 중에서 zsh 을 택하게 된 것은 라이센스 문제를 해결하면서도 기존 bash 쉘과의 호환성을 최대한 지원하기 위함인 것 같습니다.[^Bourne-shell]

사실 zsh 자체는 맥 사용자에게 오래전부터 알려려 있던 것으로, 한 때 [iTerm2](https://iterm2.com)[^iTerms2] 라는 터미널이 유행하면서 Oh My Zsh[^ohmyzsh] 로 변경하는 경우가 꽤 있었던 기억이 납니다. 다만 저는 개인적으로 어지간하면 기본 세팅을 변경하지 않는 사람다 보니 zsh 이 있다는 것을 알고만 있었는데, 언젠가부터 터미널을 사용할 때 아래와 같은 메시지가 계속 뜨길래 알아보니 기본 쉘이 변경된 것이었습니다.

![bash-shell](/assets/macOS/bash-shell.png)

> 실제 맥의 기본 쉘이 변경된 것은 카탈리나가 공개된 후이므로 2019년 10월 경입니다. 물론 기본 쉘이 변경될 것이라는 것을 공개한 것은 WWDC 2019 였으므로, 2019년 6월입니다.[^recognized]

그런데 '카탈리나' 부터 기본 쉘이 zsh 이 되었다고 하지만, 위 메시지가 계속 뜬다는 것은 기본 쉘이 계속 bash 인 상태라는 것을 의미합니다. 아마도 원래 bash 쉘을 쓰고 있던 사람은 OS 를 업데이트하더라도 기본 설정이 유지되어서 그런 것 같습니다. 참고로 자신의 기본 쉘이 어떤 것인지는 스크린샷에서 표시한 것처럼 터미널의 제목 부분을 보면 알 수 있습니다. 위에서는 bash 인 것으로 나타납니다.

### 현재 맥에 설치되어 있는 쉘 확인하기

일단 쉘을 변경하기 전에 컴퓨터에 설치되어 있는 쉘에는 어떤 것들이 있는지 먼저 확인해 보겠습니다. 현재 컴퓨터에 설치되어 있는 쉘을 확인하려면 다음과 같은 명령을 이용하면 됩니다.

```sh
cat /etc/shells
```

`cat` 이 명령은 지정된 파일의 내용을 보여주는 명령으로, 여기서는 `etc` 디렉토리에[^etc-directory] 있는 `shells` 파일의 내용을 보여줍니다. 저의 경우 결과가 아래와 같습니다.

```sh
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

macOS '카탈리나' 에는 기본적으로 위와 같은 쉘들이 설치되어 있음을 알 수 있습니다. 이제 기본 쉘을 zsh 로 변경한 다음 본격적으로 zsh 을 알아보도록 하겠습니다.

### 기본 쉘을 zsh 로 변경하기

macOS 의 기본 쉘을 변경하려면 터미널에서 알려준 것처럼 아래와 같은 명령을 사용하면 됩니다.

```sh
chsh -s /bin/zsh
```

위에서 `chsh` 는 `chpass` 와 동일한 것으로, 사용자의 데이터베이스 정보를 변경하거나 추가하는 '유틸리티'입니다. 여기서 옵션을 `-s` 를 붙여서 `chsh -s` 라고 하면, 사용자의 쉘을 바꾸겠다는 의미가 됩니다.

위 명령을 실행하고, 암호를 입력한 다음에도 실제 변경되는 것은 없습니다. 왜냐면 터미널은 그 자체로 하나의 프로세스라서 새 설정을 적용하려면 기존 터미널을 닫고 새 터미널을 실행해야 하기 때문입니다.

이제 새로 터미널을 실행하면, 아래와 같이 업데이트할 것인지를 묻는데, Y를 입력해서 업데이트를 진행합니다.

```sh
[Oh My Zsh] Would you like to check for updates? [Y/n]: Y
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

업데이트가 완료되면 위와 비슷한 결과가 나타날 것입니다. 터미널을 보면 제목에도 zsh 이 기본 쉘임을 보여주고 있습니다.

![bash-shell](/assets/macOS/zsh.png)




### zsh 장점 알아보기

위키피디아의 [Comparison of command shells](https://en.wikipedia.org/wiki/Comparison_of_command_shells) 라는 글에서 각 쉘들을 비교해서 표로 만들어 둔 자료가 있는데, 이 자료를 훓어보면 bash 보다 zsh 이 더 나은 부분이 몇 가지 있는 것 같습니다. 그 중에서 몇가지를 옮겨보면 다음과 같습니다.[^comparison]

* 기본 기능은 두 개가 서로 엇비슷한데 `zsh` 은 코드를 추가해서 마우스를 지원하도록 할 수 있습니다.
* 사용 편의성 면에서는 `zsh` 가 자동 제안 및 수정 기능을 제공하며, 문맥에 맞는 도움말도 지원한다고 합니다.
* 프로그래밍 측면에서는 `zsh` 가 부동-소수점 수와 수학 함수 라이브러리를 제공한다고 합니다.[^zsh-programming]
* 문자열 처리나 파일 탐색 등의 기능은 `zsh` 이 전체 기능을 다 지원하고 있습니다.

### 참고 자료

[^bash]: bash 쉘에 대해서는 위키피디아의 [Bash (Unix shell)](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) 항목을 참고하기 바랍니다.

[^zsh]: zsh (Z 쉘) 에 대해서는 위키피디아의 [Z shell](https://en.wikipedia.org/wiki/Z_shell) 항목을 참고하기 바랍니다.

[^Use-zsh]: 보다 자세한 내용은 [Use zsh as the default shell on your Mac](https://support.apple.com/en-us/HT208050) 에서 확인할 수 있습니다.

[^the-Verge]: 원문으로 된 기사는 [Apple replaces bash with zsh as the default shell in macOS Catalina](https://www.theverge.com/2019/6/4/18651872/apple-macos-catalina-zsh-bash-shell-replacement-features) 에서 확인할 수 있습니다. 일단 이 기사에서는 bash 쉘의 최신 버전이 GPLv3 라이센스인 것과 관련이 있다고 보고 있습니다.

[^Bourne-shell]: bash 쉘은 [Brian Jhan Fox](https://en.wikipedia.org/wiki/Brian_Fox_(computer_programmer)) 가 1989년 최초로 공개한 쉘로, 이는 1979년 벨 연구소의 [Stephen R. Bourne](https://en.wikipedia.org/wiki/Stephen_R._Bourne) 이 공개한 Bourne 쉘을 대체하기 위한 것이었습니다. 애플의 설명에 의하면 zsh 는 이 Bourne shell 과의 호환성이 아주 높기 때문에, bash 쉘과도 약간의 차이점을 제외하면 거의 대부분의 기능이 호환된다고 합니다. 이런 이유로 zsh 을 채택하게 된 것 같습니다.

[^iTerms2]: 저도 예전에 아주 잠깐 써본 기억이 납니다. [iTerm2](https://iterm2.com) 에서 보다 자세하게 알 수 있습니다.

[^ohmyzsh]: Oh My Zsh 의 GitHub 계정은 [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) 입니다. 여기서 Oh My Zsh 에 대해 더 많은 정보를 확인할 수 있습니다.

[^recognized]: 제가 맥의 기본 쉘이 변경되었다는 것을 그만큼 늦게 인지하게 된 것은, WWDC 2019 발표 당시 제가 회사 출장 관계로 개인 PC 를 거의 쓰지 못해서 터미널을 쓸 일이 없었기 때문입니다.

[^etc-directory]: macOS 에서 `etc` 디렉토리는 주로 환경 설정 파일들이 존재하는 곳입니다. 보다 자세한 내용은 이 블로그의 [macOS: 맥의 기본 디렉토리 구조 살펴보기](http://xho95.github.io/macos/file/system/directory/2016/10/08/macOS-Directory-Structure.html) 를 참고하시기 바랍니다.

[^comparison]: 여기서 정리한 내용은 대략적인 내용을 옮겨놓은 것으로 각각에 대한 자세한 내용은 위키피디아의 [Comparison of command shells](https://en.wikipedia.org/wiki/Comparison_of_command_shells) 글을 참고하시기 바랍니다.

[^zsh-programming]: 이 말이 아직 뭔지는 잘 모르겠습니다. 아마도 쉘 스크립트를 작성할 때 수학 함수를 쓸 수 있다는 의미인 것 같습니다. 혹시 아시는 분은 댓글 남겨주시면 감사하겠습니다.
