---
layout: post
title:  "Atom 에디터 활용하기"
date:   2016-09-28 02:15:00 +0900
categories: Editor Atom Markdown Python
---

Atom 에디터는 GitHub를 만든 에디터로 Electron 이라는 웹 기반 기술로 만들어서 Windows, OS X, Linux 등에서 모두 동작합니다. 그 밖에도 Markdown 관련 패키지가 기본으로 내장되어 있다고 합니다.[^kichul]

### 맥에 Atom 에디터 설치하기

Atom은 `https://atom.io`에서 다운 받을 수 있습니다.[^Atom]

맥의 경우 홈페이지에서 `Download For Mac` 버튼을 누르면 다운되며 압축을 풀면 바로 하나의 실행 파일 형태로 설치가 끝납니다.

> 필요하다면 실행 파일을 맥의 `Application` 폴더로 이동하여 `Launchpad`에 등록하거나 앱 아이콘을 끌어다가 `Dock`에 두고 사용할 수 있습니다.

### Atom 설정하기

Atom 에디터를 설정하는 방법은 [Atom Setting](http://lks21c.blogspot.kr/2015/06/atom-shortcut.html)에 잘 나와 있습니다.

### 터미널에서 Atom 실행하기

터미널에서 Atom 에디터를 실행하려면 다음과 같이 입력하면 됩니다.

```bash
$ atom .
```

`"."`은 현재 폴더를 프로젝트로 연다는 의미가 되며 atom 뒤에 특정 파일 이름을 입력하면 해당 파일을 열게 됩니다.[^stackoverflow]

### Atom 에디터를 마크다운 편집기로 사용하기

* 장점 : 맥용 마크다운 편집기에는 여러가지 종류가 있으나, Atom의 경우 폴더 기준으로 프로젝트를 관리할 수 있어서, 블로그 제작용으로 사용하기 편리합니다. 그리고, Atom에는 Markdown 관련 패키지가 기본으로 내장되어 있습니다.

* 단점 : 일단 웹기반이라 그런지 마크다운 편집기로는 조금 무겁고, 파일이 커지면 느려지는 단점이 있는 것 같습니다.

최근에는 Atom 편집기의 단점을 많이 겪어보면서 마크다운 문서를 편집하는 용도로는 많이 사용하지 않게 되었습니다. 다만, 간단한 마크다운 편집기로 내용을 작성한 후, 전체 폴더를 다룰 때 사용하고 있습니다.

### Atom 에디터를 Python 개발 도구로 사용하기

Atom 에디터를 Python 개발도구로 사용하는 것은 문제가 있다고 하는 블로그 글이 있습니다.[^chann] 다만, 지금 현재 사용하면서 겪은 바로는, Anaconda 덕분인지 아니면 Atom 에디터가 버전업하면서 문제가 해결되었는지, 큰 문제는 없는 것 같습니다.

#### 관련 Package 설치하기

Atom 에디터를 Python 개발툴로 사용하는 방법 및 관련 Package 설치에 대해서는 [Atom을 Python 개발 툴로 사용하기](http://reachlab-kr.github.io/python/2016/01/10/Python-Atom-Packages.html)라는 블로그 글에서 잘 정리되어 있는 것 같습니다.[^reachlab-kr] 기타 Atom 에디터에 설치할만한 Package에 대해서는 [Atom Editor 추천 패키지](http://blog.naver.com/PostView.nhn?blogId=jkikss&logNo=220590070604&categoryNo=44&parentCategoryNo=0&viewDate=&currentPage=1&postListTopCurrentPage=1&from=postView)을 참고할 만 합니다.[^naver]

> [Atom을 Python 개발 툴로 사용하기](http://reachlab-kr.github.io/python/2016/01/10/Python-Atom-Packages.html)라는 블로그에서는 Atom 에디터를 시작할 때 터미널에서 `atom .`로 실행해야해서 귀찮다고 되어 있는데, 막상 사용해보면 굳이 터미널에서 실행하지 않아도 특별한 문제가 없는 것 같습니다.

요약하면 Atom 에디터에서 `autocomplete-python`과 `script`라는 두 개의 패키지를 설치하면 Atom 에디터를 Python 개발 도구로 사용할 수 있습니다.

Atom 에디터에서 Package를 설치하는 방법은 **Atom > Preferences... > Settings > + Install** 메뉴에서 Package를 이름으로 검색한 후 설치하면 됩니다.

### 고찰 하기

Atom 에디터와 Sublime Text 같은 다른 에디터들을 비교해서 사용해 볼 필요가 있을 것 같습니다. 제가 Sublime Text를 직접 사용해 본적이 없어서 어떤 에디터가 더 나은 지는 잘 모르겠습니다. 

업데이트가 자주 되는 것은 장점이기도 하지만, 대신에 업데이트 때마다 어떤 변경이 있었는지를 알기 힘든 것 같습니다. 해결책이 있을 것 같은데 아직은 잘 모르겠습니다. 이 글을 작성하는 시점에서도 Python Unicode 출력관련 버그가 소리소문없이 해결된 것 같습니다.

### 참고 자료

[^Atom]: [Atom.io](https://atom.io)

[^kichul]: [KICHUL's Blog](http://blog.kichul.co.kr/2015-08-25-Atom%20Editor/)

[^stackoverflow]: [Open Atom editor from command line](http://stackoverflow.com/questions/22390709/open-atom-editor-from-command-line)

[^chann]: [Atom 에서 Python 3 개발하기](https://blog.chann.kr/how-to-use-python3-in-atom/)

[^naver]: [Atom Editor 추천 패키지](http://blog.naver.com/PostView.nhn?blogId=jkikss&logNo=220590070604&categoryNo=44&parentCategoryNo=0&viewDate=&currentPage=1&postListTopCurrentPage=1&from=postView) 내용은 괜찮은 것 같은데 처음에 화면 가득 이미지가 떠서 당황했습니다. 

[^reachlab-kr]: [Atom을 Python 개발 툴로 사용하기](http://reachlab-kr.github.io/python/2016/01/10/Python-Atom-Packages.html) 이를 통해 Atom 에디터에 플러그인 같은 도구를 설치하는 방법도 알 수 있습니다. autocomplete-glsl 같은 것도 있는 것 같습니다.
