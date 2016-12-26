---
layout: post
title:  "Anaconda를 사용하여 Python 3 설치하기"
date:   2016-03-08 21:50:00 +0900
categories: Python Install Anaconda Conda
---

파이썬([Python](https://www.python.org))은 최근에 가장 널리 사용되고 있는 인터프리터 언어입니다.[^Python]

여기서는 아나콘다(anaconda)로 파이썬 3 버전을 설치하고 환경을 구축하는 방법에 대해서 정리합니다. 이 글을 쓰는 시점에서 파이썬 최선 버전은 3.5.2입니다. [^docs]  [^ssut]

> 파이썬을 설치할 때에는 예전에는 pip와 virtualenv를 많이 사용했지만,[^guide]  [^kybin] 요즘은 아나콘다를 많이 사용하는 것 같습니다. 설치 버전도 3 버전으로 옮겨가는 추세입니다. 

### 맥에서 아나콘다 설치

아나콘다는 파이썬과 함께 필요한 라이브러리들까지 함께 설치할 수 있도록 해주는 종합 선물 세트 같은 것입니다.[^continuum] Introducing Pyton 책에 따르면 과학 분야에 특화된 플랫폼(platform)이라고 합니다. 공식 홈페이지에서도 파이썬을 사용하는 Open Data Science Platform 이라고 소개하고 있습니다.

아나콘다는 그래픽 환경과 터미널(terminal) 환경에서 모두 설치가 가능한데, [^mcchae]  [^wsyang] 터미널 환경에서 설치하는 방법은 아나콘다 공식 홈페이지의 [Anaconda Download](https://www.continuum.io/downloads) 부분에서 잘 설명하고 있습니다. [^ContinuumDownload] 

#### 설치하기 

홈페이지에서 Command Line Installer를 다운 받습니다.

아래의 명령을 입력합니다. 

```
bash Anaconda3-4.2.0-MacOSX-x86_64.sh 
```

> bash 명령이 뭔지는 확인이 필요합니다. 

그러면 license를 review 해야 한다고 나옵니다. 엔터키를 입력하고 나오는 글 밑의 `:` 뒤에 `q`를 입력하면 빠져나옵니다. 그냥 계속 글을 밑으로 읽어도 됩니다. 

```
Do you approve the license terms? [yes|no]
```

라는 문구가 나오면 yes를 입력하고 엔터키를 입력합니다. 

```
/Users/username/anaconda3
```

에 설치할 것이냐고 묻습니다. 어지간하면 다른 곳에 설치할 이유가 없으므로 그냥 엔터키를 입력해서 설치를 시작합니다. 

조금 기다리면 파이썬과 관련 패키지들이 설치됩니다.

#### 설치 완료 화면

설치가 완료되면 아래과 같은 문구들이 나옵니다.

```
Thank you for installing Anaconda3!

Share your notebooks and packages on Anaconda Cloud!
Sign up for free: https://anaconda.org
``` 

<https://anaconda.org>에 가입하면 파이썬 노트북과 패키지를 아나콘다 클라우드를 통해 공유할 수 있는 것 같습니다. 

#### `.bash_profille` 설정하기
 
경험에 의하면 아나콘다를 통해 설치하면 `.bash_profile` 설정도 자동으로 해주는 것 같습니다. 따라서 `.bash_profile` 설정 과정도 필요없습니다. 

위의 내용은 아나콘다 설치 과정 마지막에 아래와 같은 내용으로 설명되어 있습니다. 

```
Do you wish the installer to prepend the Anaconda3 install location
to PATH in your /Users/.../.bash_profile ? [yes|no]
[yes] >>> 
Prepending PATH=/Users/.../anaconda3/bin to PATH in
newly created /Users/.../.bash_profile

For this change to become active, you have to open a new terminal.
```

위의 내용을 보면 아나콘다에서 알아서 `.bash_profile` 파일에 **PATH**를 등록함을 알 수 있습니다. 위에서 **[yes]**는 자동으로 입력됩니다. 

그리고 이 변화를 활성화하려면 터미널을 새로 시작해야한다고 알려주고 있습니다. 
이 적용되지 않아서 아무런 변화가 없는 것같이 느껴집니다. 

> `.bash_profile`은 터미널을 새로 시작할 때 다시 불리게 되므로, 변경된 `.bash_profile` 내용을 적용하려면 터미널을 끄고 다시 실행해야 합니다. 

#### 파이썬 3을 사용하도록 설정하기

아나콘다로 파이썬을 설치하면 따로 설정하지 않아도 `python` 명령을 사용하면 알아서 python 3 버전이 실행됩니다.

> pip 등으로 설치 했을 경우 `Python3`으로 명시적으로 지정하지 않아도 Python 3을 사용하기 위한 방법은 참고 자료에 있습니다. [^eunguru]

### 파이썬 실행하기 

터미널에서 `python`이라고 입력하면, 아래와 같은 내용이 출력되는 것을 볼 수 있습니다.  

```
Last login: Mon Sep  5 21:06:22 on ttys001
usercomputer:username$ python
Python 3.5.2 |Anaconda 4.1.1 (x86_64)| (default, Jul  2 2016, 17:52:12) 
[GCC 4.2.1 Compatible Apple LLVM 4.2 (clang-425.0.28)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> 
```

`python` 명령은 파이썬 쉘(shell)을 실행시키는 명령으로, 위의 화면을 보면 자동으로 파이썬이 3 버전으로 실행됨을 알 수 있습니다.

### 아톰(Atom) 에디터를 파이썬 개발 툴로 사용하기

파이썬으로 개발하기 위해서는 개발 도구가 필요합니다. 개발은 앞에 본 것과 같은 파이썬 쉘로 할 수도 있고, 아니면 파이참([PyCharm](https://www.jetbrains.com/pycharm/)) 같은 전문 개발 툴을 사용할 수도 있습니다. 하지만 쉘에서는 프로그래밍에 한계가 있을 수 밖에 없고, 파이참 같은 전문 툴은 유료입니다. 다양한 방법으로 할인 혜택 등을 받을 수 있지만 아무래도 부담이 될 수 있습니다.  

무료로 사용할 수 있는 파이썬 개발 도구 중에서는 아톰(Atom) 에디터도 괜찮은 편입니다. 아톰 에디터를 파이썬 개발에 사용하기 위해서는 [아톰(Atom) 에디터 활용하기](http://xho95.github.io/editor/atom/markdown/python/2016/09/27/Using-Atom-Editor.html) 라는 글에 따로 정리해 둔 내용이 있으니 살펴 보시기 바랍니다.

### 아나콘다에서 파이썬 패키지(Package)s 관리하기 

파이썬에서 패키지를 관리하는 방법은 보통 pip를 활용하는 것입니다. 그리고 pip를 사용하다보면 프로젝트별로 달라지는 패키지 버전 문제를 해결하기 위해 가상환경 도구인 virtualenv를 사용하게 됩니다. 기존 방식에서는 pip와 virtualenv를 같이 사용하는 조합을 많이 사용했습니다.

하지만 아나콘다를 통해서 파이썬을 설치하게 되면, 콘다(conda)라는 패키지 관리 프로그램이 같이 설치가 됩니다. 콘다를 사용하면 pip와 virtualenv를 동시에 사용하는 것과 같은 효과를 거둘 수 있습니다. 왜냐면 콘다는 패키지 관리 툴이면서 동시에 가상 환경 도구이기도 하기 때문입니다. 

따라서 아나콘다로 파이썬을 설치했으면 콘다를 패키지 관리 도구로 사용하면 됩니다. 현재까지의 경험에서는 콘다와 pip를 섞어 썼을 때도 큰 문제는 없었습니다.  

### 콘다 사용하기

콘다의 사용법에 대해서는 다음의 자료들이 좋습니다.[^egloos]  

여기에는 콘다와 기존의 pip, virtualenv의 명령어들을 비교해 놓은 곳입니다.[^conda] 이곳은 가끔씩 명령어가 생각나지 않을 때 들르게 되는 곳입니다.

#### 가상 환경 만들기

아래와 같이 하면 콘다로 가상 환경을 만들 수 있습니다. 

```
$ conda create --name $ENVIRONMENT_NAME python
```

가상 환경은 `/Users/.../anaconda3/envs/ENVIRONMENT_NAME`위치에 생깁니다. 콘다의 경우 가상 환경을 중앙 집중식으로 관리하는 것 같습니다. [^atom-with-anacondas]

위에서 `python` 위치에는 가상 환경을 만들 때, 필요한 패키지들을 나열하는 곳입니다. 

> [Anaconda 설치하기 - Python을 제대로 활용해보자](http://mataeoh.egloos.com/7052271) 라는 자료에 따르면 이 환경설정에서 사용하길 원하는 모든 프로그램은 동시에 설치하는 것이 좋다고 합니다. 나중에 한번에 하나씩 설치하는 것은 의존성 충돌을 일으킬 수 있다고 합니다.

#### 가상 환경 활성화하기

아래와 같이 하면 가상 환경으로 진입할 수 있습니다. 

```
$ source activate $ENVIRONMENT_NAME
```

그러면 터미널 프롬프트에 아래와 같이 가상 환경 이름이 나타나서 현재 어느 가상 환경에 있는 지를 알 수 있습니다. 

```
(ENVIRONMENT_NAME) ...$
```

참고로 해당 터미널을 닫으면 가상 환경에서 나가게 되는 것 같습니다. 특정 가상 환경에서 작업할 경우 가상 환경이 활성화된 터미널에서 작업해야 하는 것 같습니다. 

#### 가상 환경 비활성화하기

아래와 같이 하면 가상 환경에서 빠져나오게 됩니다. 

```
source deactivate
```

다만 위에 적은 것과 같이 만약 가상 환경으로 들어갔지만 터미널을 종료하면 자동으로 가상 환경에서 빠져나오게 되는 것 같습니다.

#### 가상 환경 목록 살펴보기 

터미널에서 아래와 같은 명령을 사용하면 현재까지 만든 가상 환경의 목록을 볼 수 있습니다. 또 목록에 나타난 별표(`*`) 표시를 통해 사용자가 현재 어떤 가상 환경에 속해 있는지도 알 수 있습니다.

```
$ conda info --envs
```

아래와 비슷한 결과가 나타나는 것을 볼 수 있습니다. 

```
# conda environments:
#
first                    /Users/username/anaconda3/envs/first
root                  *  /Users/username/anaconda3
```

#### 가상 환경에 설치된 패키지 목록 구하기

일단 목록을 구할 가상환경으로 진입한 다음에, 아래와 같이 하면 현재 속해있는 가상 환경의 패키지 목록을 따로 저장할 수 있습니다.

```
(ENVIRONMENT_NAME) ...$ conda list --export > first.txt
```

#### 패키지 목록의 패키지들을 가상 환경에 설치하기

위와 같이 특정 가상 환경의 패키지 목록을 사용하여 새로운 가상 환경에 동일한 패키지를 세팅할 수 있습니다.

실행 방법은 좀 더 살펴봐야 합니다. 

#### 가상 환경 복사하기

콘다의 경우 두 가상 환경을 동일하게 맞추기 위해 목록을 따로 구하지 않고, 아래의 명령을 사용해서 가상 환경 자체를 복사할 수 있습니다.

```
$ conda create --name second --clone fisrt
```

위 명령을 사용하면 `first`를 클론해서 `second` 가상 환경을 만듭니다.

#### 가상 환경 삭제하기

아래와 같은 명령을 사용해서 가상 환경을 삭제 할 수 있습니다. 

```
$ conda remove --name second --all
```

원래 `conda remove --name` 명령은 패키지를 삭제하는 명령인데 `--all` 옵션을 붙여줌으로써 가상 환경 전체를 삭제함을 볼 수 있습니다.


### 고찰하기

`conda list` 등에 대한 설명도 필요합니다. 아무래도 아나콘다와 콘다의 내용을 분리해서 2개로 만드는 것이 좋을 것입니다. 여기에 pip index 같은 패키지 관련 자료 페이지들에 대한 설명도 조금 추가하면 좋을 것 같습니다.

### 참고 자료

[^Python]: [Python](https://www.python.org) : Python 공식 홈페이지입니다.

[^guide]: [맥 OS X에 파이썬 설치하기](http://python-guide-kr.readthedocs.io/ko/latest/starting/install/osx.html) Virtual Environments에 대한 내용도 설명이 되어 있습니다.

[^kybin]: [파이썬 설치](http://kybin.github.io/translateDiveIntoPython3korean/installing-python.html)

[^mcchae]: [OS X 요세미티, Anaconda 패키지 설치 후 ipython notebook으로](http://egloos.zum.com/mcchae/v/11158397)

[^docs]: [Python 3.5.2 documentation](https://docs.python.org/3/) Python 3에 대한 공식 문서입니다. 

[^ssut]: [Python 3.5 미리보기: 무엇이 바뀌었고 무엇이 추가되었나?](https://b.ssut.me/59) : 파이썬 3.5에 대한 소개 글입니다.

[^wsyang]: [Mac OS X에 Python 개발환경 만들기](http://wsyang.com/2015/07/19/hellow-python/) Python의 버전 관리 툴 pyenv에 대한 내용도 나옵니다. 좀 더 알아봐야 할 것 같습니다. 여기서는 아나콘다도 pyenv를 통해서 설치하고 있습니다. 

[^eunguru]: [Mac에서 python 3.x 버전 사용하기](http://eunguru.tistory.com/28)

[^continuum]: [continuum](https://www.continuum.io)

[^ContinuumDownload]: [Anaconda Download](https://www.continuum.io/downloads)

[Annotated Algorithms in Python](http://www.amazon.com/Annotated-Algorithms-Python-Applications-Physics/dp/0991160401)

[파이썬을 이용한 시스템 트레이딩 (기초편)](https://wikidocs.net/book/110)

[파이썬3로 뛰어들기](http://kybin.github.io/translateDiveIntoPython3korean/index.html) "Dive into Python 3" 라는 책을 번역한 자료입니다.

[Python 3 Module of the Week](https://pymotw.com/3/) Doug Hellmann란 분이 Python 모듈에 대해서 설명을 정리한 곳입니다. 

[The Python Standard Library](https://docs.python.org/3/library/index.html) Python 표준 라이브러리에 대한 공식 문서입니다.

[Python in Xcode 7](http://stackoverflow.com/questions/5276967/python-in-xcode-7) Xcode 7에서 Python 개발 환경을 구축하는 방법에 대한 질문 답변입니다.

[BUILDING AND RUNNING PYTHON SCRIPTS WITH XCODE 6.1](https://vandadnp.wordpress.com/2014/10/20/building-and-running-python-scripts-with-xcode-6-1/) Xcode 6.1에서 Python 개발 환경을 구축하는 방법에 대한 질문 답변입니다.

[Is it possible to make abstract classes in python?](http://stackoverflow.com/questions/13646245/is-it-possible-to-make-abstract-classes-in-python) Python에서 추상 클래스 또는 프로토콜 클래스를 구현하는 방법에 대한 질문 답변입니다.

[^conda]: [conda vs. pip vs. virtualenv](http://conda.pydata.org/docs/_downloads/conda-pip-virtualenv-translator.html) conda를 pip 및 virtualenv와 비교한 표입니다.

[^egloos]: [Anaconda 설치하기 - Python을 제대로 활용해보자](http://mataeoh.egloos.com/7052271) conda의 사용법에 대해 잘 정리한 글입니다.

[conda에서 파이썬 가상 환경 (virtual environments) 생성하기](http://jkstory-textcube.blogspot.kr/2016/02/conda-virtual-environments.html)

[^atom-with-anacondas]: [Atom with Anaconda’s Python and Anaconda’s Python packages?](https://discuss.atom.io/t/atom-with-anacondas-python-and-anacondas-python-packages/31235) : Atom 에디터가 conda의 가상 환경을 인식 시키도록 하는 방법에 대한 답변이 있는 글입니다. 

[파이썬 생존 안내서 (자막)](http://www.slideshare.net/sublee/ss-67589513) : 이흥섭님의 자료로 넥슨코리아 사내 발표자료로 왓 스튜디오에서 파이썬으로 《야생의 땅: 듀랑고》 서버를 비롯한 여러가지 도구를 만든 경험을 공유한다고 소개된 자료입니다.