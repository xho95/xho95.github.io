---
layout: post
title:  "Anaconda를 사용하여 Python 3 설치하기"
date:   2016-03-08 21:50:00 +0900
categories: Python Install Anaconda Conda
---

파이썬은 최근에 가장 널리 사용되고 있는 인터프리터 언어입니다.[^Python]

### 파이썬 버전 및 설치 도구 선택

예전에는 pip와 virtualenv를 많이 사용했지만,[^guide]  [^kybin] 요즘은 아나콘다(anaconda)를 많이 사용하는 것 같습니다. 버전도 3 버전을 옮겨가는 추세입니다. 

따라서 여기서는 아나콘다로 python 3을 설치하고 환경을 구축하는 방법에 대해서 정리합니다. 이 글을 쓰는 시점에는 python 3.5.2 버전이 최신입니다. [^docs]  [^ssut]

### 맥에서 아나콘다 설치

아나콘다는 파이썬과 함께 필요한 라이브러리들까지 함께 설치할 수 있도록 해주는 종합 세트(?)입니다.[^continuum] 책에 따르면 과학 분야에 특화된 모음이라고 합니다. 

아나콘다는 그래픽 환경과 터미널 환경에서 설치가 가능합니다. 아나콘다를 설치하는 방법은 다음과 같은 자료가 있습니다.[^mcchae]  [^wsyang]터미널 환경에서 설치하는 방법은 이곳에서 잘 설명하고 있습니다. [^ContinuumDownload] 

경험에 의하면 아나콘다를 통해 설치하면 `.bash_profile` 설정도 자동으로 해주는 것 같습니다.

### Python 3 사용하도록 설정하기

아나콘다로 파이썬을 설치하면 따로 설정하지 않아도 `python` 명령을 사용하면 알아서 python 3 버전이 실행됩니다.

> pip 등으로 설치 했을 경우 `Python3`으로 명시적으로 지정하지 않아도 Python 3을 사용하기 위한 방법은 참고 자료에 있습니다.[^eunguru]

### Python 실행하기 

아나콘다를 설치하면 `.bash_profile`이 바뀌게 되는데, 터미널을 그대로 사용하고 있으면 변경 내용이 적용되지 않아서 아무런 변화를 느낄 수 없습니다. `.bash_profile`은 터미널을 새로 시작할 때마다 다시 불러오므로, 새로운 내용을 적용하려면 터미널을 끄고 다시 실행해야 합니다. 

터미널에서 `python`이라고 치면, 아래와 같은 내용이 출력되면서 파이썬 쉘을 실행시키게 되는데, 아래 내용을 보면 알아서 python 3버전으로 실행됨을 알 수 있습니다. 

```
Last login: Mon Sep  5 21:06:22 on ttys001
usercomputer:username$ python
Python 3.5.2 |Anaconda 4.1.1 (x86_64)| (default, Jul  2 2016, 17:52:12) 
[GCC 4.2.1 Compatible Apple LLVM 4.2 (clang-425.0.28)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> 
```

#### Atom을 Python 개발 툴로 사용하기

위에서 본 파이썬 쉘을 통해서도 개발을 할 수 있고, 아니면 파이참 같은 전문 개발 툴을 사용할 수도 있겠지만, 쉘에서는 프로그래밍에 한계가 있을 수 밖에 없고, 파이참 같은 전문 툴은 일단 유료입니다. 

무료로 사용할 수 있는 개발 도구로는 Atom 에디터도 쓸만합니다. Atom 에디터를 파이썬 개발에 사용하기 위해서는 [Atom 에디터 활용하기](http://xho95.github.io/editor/atom/markdown/python/2016/09/27/Using-Atom-Editor.html) 라는 글에 정리해 둔 내용을 살펴 보시기 바랍니다.

### 아나콘다에서 파이썬 Package 관리하기 

파이썬에서 Package를 관리하는 방법은 보통 pip를 활용하는 것입니다. 그리고 pip를 사용하다보면 프로젝트별로 달라지는 패키지 버전 문제를 해결하기 위해 virtualenv를 사용하게 됩니다. 기존 방식에서는 pip와 virtualenv를 같이 사용하는 조합을 많이 사용했습니다.

하지만 위에서와 같이 아나콘다를 통해서 파이썬을 설치하게 되면, 콘다(conda)라는 패키지 관리 프로그램이 같이 설치가 됩니다. 콘다를 사용하면 pip와 virtualenv를 동시에 사용하는 것과 같은 효과를 거둘 수 있습니다. 왜냐면 콘다는 패키지 관리 툴이면서 동시에 가상 환경 툴이기도 하기 때문입니다. 

따라서 아나콘다로 파이썬을 설치했으면 콘다를 패키지 관리 툴로 사용하면 됩니다.  

### 콘다로 가상 환경 사용하기

콘다의 사용법에 대해서는 다음의 자료들이 좋습니다.[^egloos]  

여기에는 콘다와 기존의 pip, virtualenv의 명령어들을 비교해 놓은 곳입니다.[^conda] 이곳은 가끔씩 명령어가 생각나지 않을 때 들르게 되는 곳입니다.

#### 가상 환경 만들기

아래와 같이 하면 콘다로 가상 환경을 만들 수 있습니다. 

```
$ conda create --name $ENVIRONMENT_NAME python
```

가상 환경은 `/Users/kimminho/anaconda3/envs/ENVIRONMENT_NAME`위치에 생깁니다. 콘다의 경우 가상 환경을 중앙 집중식으로 관리하는 것 같습니다.[^atom-with-anacondas]

위에서 `python` 위치에는 가상 환경을 만들 때, 필요한 패키지들을 나열하는 곳입니다. [Anaconda 설치하기 - Python을 제대로 활용해보자](http://mataeoh.egloos.com/7052271) 라는 자료에 따르면 이 환경설정에서 사용하길 원하는 모든 프로그램은 동시에 설치하는 것이 좋다고 합니다. 나중에 한번에 하나씩 설치하는 것은 의존성 충돌을 일으킬 수 있다고 합니다.

#### 가상 환경 진입하기

아래와 같이 하면 가상 환경으로 진입할 수 있습니다. 

```
$ source activate $ENVIRONMENT_NAME
```

그러면 터미널 프롬프트에 아래와 같이 가상 환경 이름이 나타나서 현재 어느 곳에 있는 지를 알 수 있습니다. 

```
(ENVIRONMENT_NAME) ...$
```

이 상태에서 터미널을 닫으면 가상 환경에서 나가지는 지는 모르겠습니다.

#### 가상 환경에서 빠져나오기

아래와 같이 하면 가상 환경에서 빠져나오게 됩니다. 

```
source deactivate
```

다만 위에 적은 것과 같이 만약 가상 환경에 들어갔는데 터미널을 종료하면 계속 가상 화면에 남게 되는 것인지 빠져나오게 되는 것인지는 아직 잘 모르겠습니다. 

#### 가상 환경 목록 살펴보기 

아래와 같은 명령을 사용하면 현재까지 만든 가상 환경의 목록을 볼 수 있습니다. 또 목록에서 별표(`*`) 표시를 통해 현재 사용자가 어떤 가상 환경에 속해 있는지도 알 수 있습니다.

```
$ conda info --envs
```

현재까지의 결과는 아래와 같습니다. 

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

이 부분은 좀 더 살펴봐야 합니다. 

#### 가상 환경 복사하기

다만, 콘다의 경우 목록을 따로 구하지 않고, 아래의 명령을 사용해서 가상 환경 자체를 복사할 수 있습니다.

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

### 참고 자료

[^guide]: [맥 OS X에 파이썬 설치하기](http://python-guide-kr.readthedocs.io/ko/latest/starting/install/osx.html) Virtual Environments에 대한 내용도 설명이 되어 있습니다.

[^kybin]: [파이썬 설치](http://kybin.github.io/translateDiveIntoPython3korean/installing-python.html)

[^mcchae]: [OS X 요세미티, Anaconda 패키지 설치 후 ipython notebook으로](http://egloos.zum.com/mcchae/v/11158397)

[^docs]: [Python 3.5.2 documentation](https://docs.python.org/3/) Python 3에 대한 공식 문서입니다. 

[^ssut]: [Python 3.5 미리보기: 무엇이 바뀌었고 무엇이 추가되었나?](https://b.ssut.me/59) : 파이썬 3.5에 대한 소개 글입니다.

[^wsyang]: [Mac OS X에 Python 개발환경 만들기](http://wsyang.com/2015/07/19/hellow-python/) Python의 버전 관리 툴 pyenv에 대한 내용도 나옵니다. 좀 더 알아봐야 할 것 같습니다. 여기서는 아나콘다도 pyenv를 통해서 설치하고 있습니다. 

[^eunguru]: [Mac에서 python 3.x 버전 사용하기](http://eunguru.tistory.com/28)

[^Python]: [Python](https://www.python.org)

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