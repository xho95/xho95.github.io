---
layout: post
comments: true
title:  "macOS: Catalina (카탈리나) 부터 기본 쉘이 된 zsh 알아보기"
date:   2020-03-04 11:30:00 +0900
categories: macOS CLI Shell zsh
---

맥 OS 버전 10.15 인 카탈리나부터 기본 쉘 (Shell) 이 bash[^bash] 에서 zsh (Z shell)[^zsh] 로 변경 되었습니다.[^Use-zsh] 일단 쉘을 변경하게된 이유를 애플에서 직접 밝히진 않았지만, The Verge 라는 언론에서는 bash 쉘의 최신 버전 라이센스가 GPLv3 인 것과 관련이 있다고 보고 있습니다.[^the-Verge] 기사를 보면 여러 쉘 중에서 zsh 을 택하게 된 것은 라이센스 문제를 해결하면서도 최대한 기존 bash 쉘과의 호환성을 염두했기 때문인 것 같습니다.[^Bourne-shell]

사실 zsh 자체는 맥 사용자에게 오래전부터 알려진 것으로 oh my zsh 같은 프로그램도 사용되기도 했습니다. 다만 저는 개인적으로 어지간하면 기본 세팅을 변경하지 않는 사람이라서 그냥 알고만 있었는데, 언젠가부터 터미널을 사용할 때 아래와 같은 메시지가 뜨는 것을 알게된 후 쉘이 변경되었다는 것을 알게됐습니다.

![bash-shell](/assets/macOS/bash-shell.png)

그런데 카탈리나부터 기본 쉘이 zsh 이 되었다고 하면서 제 쉘이 계속 bash 였던 것은 원래 bash 쉘을 쓰고 있던 사람이 OS 를 업데이트를 하면 설정이 유지돼서 그런 것 같습니다.



### 참고 자료

[^bash]: bash 쉘에 대해서는 위키피디아의 [Bash (Unix shell)](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) 항목을 참고하기 바랍니다.

[^zsh]: zsh (Z 쉘) 에 대해서는 위키피디아의 [Z shell](https://en.wikipedia.org/wiki/Z_shell) 항목을 참고하기 바랍니다.

[^Use-zsh]: 보다 자세한 내용은 [Use zsh as the default shell on your Mac](https://support.apple.com/en-us/HT208050) 에서 확인할 수 있습니다.

[^the-Verge]: 원문으로 된 기사는 [Apple replaces bash with zsh as the default shell in macOS Catalina](https://www.theverge.com/2019/6/4/18651872/apple-macos-catalina-zsh-bash-shell-replacement-features) 에서 확인할 수 있습니다.

[^Bourne-shell]: bash 쉘은 [Brian Jhan Fox](https://en.wikipedia.org/wiki/Brian_Fox_(computer_programmer)) 가 1989년 최초로 공개한 쉘로, 이는 1979년 벨 연구소의 [Stephen R. Bourne](https://en.wikipedia.org/wiki/Stephen_R._Bourne) 이 공개한 Bourne 쉘을 대체하기 위한 것이었습니다. 애플의 설명에 의하면 zsh 는 이 Bourne shell 과의 호환성이 아주 높기 때문에 bash 쉘과도 약간의 차이점을 제외하면 거의 대부분의 기능이 호환된다고합니다.
