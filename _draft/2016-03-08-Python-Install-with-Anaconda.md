---
layout: post
title:  "Anaconda를 사용하여 Python 설치하기"
date:   2016-03-08 21:50:00 +0900
categories: Resources Softwares Programming Python
---

파이썬은 최근에 가장 널리 사용되고 있는 인터프리터 언어입니다.[^Python]

### 맥에서 파이썬 설치

다음과 같은 자료들이 있습니다.[^guide]  [^kybin] 여기서는 anaconda를 이용해서 파이썬을 설치하도록 하겠습니다. 

### 맥에서 아나콘다 설치

아나콘다 홈페이지입니다.[^continuum]

아나콘다는 파이썬과 함께 필요한 라이브러리들까지 함께 설치할 수 있도록 해주는 도구(?)입니다. 아나콘다를 설치하는 방법은 다음과 같은 자료가 있습니다.[^mcchae]  [^wsyang]

아나콘다는 그래픽 환경과 터미널 환경에서 설치가 가능합니다. 터미널 환경에서 설치하는 방법은 이곳에서 잘 설명하고 있습니다. [^ContinuumDownload] `.bash_profile` 설정도 자동으로 해줍니다. 

### Python 3 사용하도록 설정하기

`Python3`으로 명시적으로 지정하지 않아도 Python 3을 사용하기 위한 방법은 참고 자료에 설명이 되어 있습니다.[^eunguru]

위의 아나콘다를 설치하면 이 부분은 하지 않아도 되는 것 같습니다. 

### Python 실행하기 

아나콘다를 설치하면 `.bash_profile`이 바뀌게 되는데, 터미널을 그대로 사용하고 있으면 기존 `.bash_profile`이 적용되어서 작동이 안됩니다. 따라서, `.bash_profile` 설정을 끝내고 나면 터미널을 끄고 다시 실행해야 합니다. 

터미널에서 `python`이라고만 쳐도 알아서 python 3버전이 아래와 같이 실행됨을 알 수 있습니다. 

```
Last login: Mon Sep  5 21:06:22 on ttys001
Kimui-MacBook-Pro-2:~ kimminho$ python
Python 3.5.2 |Anaconda 4.1.1 (x86_64)| (default, Jul  2 2016, 17:52:12) 
[GCC 4.2.1 Compatible Apple LLVM 4.2 (clang-425.0.28)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> 
```

#### Atom을 Python 개발 툴로 사용하기

이 부분은 Atom 에디터 관련 글에서 따로 정리하도록 합니다. 

### Package 관리하기 

파이썬에서 Package를 관리하는 방법은 pip를 활용하는 것입니다. 그리고 이렇게 pip를 사용하다보면 프로젝트별로 적용되는 패키지 버전이 달라 문제가 있을 수 있으므로, virtualenv를 pip과 같이 사용하게 됩니다. 

하지만 위에서와 같이 anaconda를 통해서 파이썬을 설치하게 되면, conda라는 패키지 관리 프로그램이 같이 설치가 됩니다. 이 conda를 사용하면 pip와 virtualenv를 동시에 사용하는 것과 같은 효과를 거둘 수 있으므로 anaconda를 설치했을 경우, conda를 사용하면 됩니다.[^conda]  [^egloos]

### 참고 자료

[^guide]: [맥 OS X에 파이썬 설치하기](http://python-guide-kr.readthedocs.io/ko/latest/starting/install/osx.html) Virtual Environments에 대한 내용도 설명이 되어 있습니다.

[^kybin]: [파이썬 설치](http://kybin.github.io/translateDiveIntoPython3korean/installing-python.html)

[^mcchae]: [OS X 요세미티, Anaconda 패키지 설치 후 ipython notebook으로](http://egloos.zum.com/mcchae/v/11158397)

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

[Python 3.5.2 documentation](https://docs.python.org/3/) Python 3에 대한 공식 문서입니다. 

[Python in Xcode 7](http://stackoverflow.com/questions/5276967/python-in-xcode-7) Xcode 7에서 Python 개발 환경을 구축하는 방법에 대한 질문 답변입니다.

[BUILDING AND RUNNING PYTHON SCRIPTS WITH XCODE 6.1](https://vandadnp.wordpress.com/2014/10/20/building-and-running-python-scripts-with-xcode-6-1/) Xcode 6.1에서 Python 개발 환경을 구축하는 방법에 대한 질문 답변입니다.

[Is it possible to make abstract classes in python?](http://stackoverflow.com/questions/13646245/is-it-possible-to-make-abstract-classes-in-python) Python에서 추상 클래스 또는 프로토콜 클래스를 구현하는 방법에 대한 질문 답변입니다.

[^conda]: [conda vs. pip vs. virtualenv](http://conda.pydata.org/docs/_downloads/conda-pip-virtualenv-translator.html) conda를 pip 및 virtualenv와 비교한 표입니다.

[^egloos]: [Anaconda 설치하기 - Python을 제대로 활용해보자](http://egloos.zum.com/mataeoh/v/7052271) conda의 사용법에 대해 잘 정리한 글입니다.