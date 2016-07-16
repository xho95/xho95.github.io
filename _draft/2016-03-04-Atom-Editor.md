---
layout: post
title:  "Atom 에디터 사용법"
date:   2016-03-04 20:50:00 +0900
categories: OSX Editor Atom Terminal
---

Atom 에디터는 GitHub를 만든 에디터로 Electron 이라는 웹 기반 기술로 만들어서 Windows, OS X, Linux 등에서 모두 동작한다. 그 밖에도 Markdown 관련 패키지가 기본으로 내장되어 있다고 한다.[^kichul]

맥용 마크다운 편집기에는 여러가지 종류가 있으나, Atom의 경우 폴더 기준으로 프로젝트를 관리할 수 있어서, 블로그 제작용으로 사용하기 편리하다.[^Atom]

최근에는 Atom 편집기의 단점을 많이 겪어보면서 잘 사용하지 않게 되었습니다.

### Atom 설치하기

Atom은 `https://atom.io`에서 다운 받을 수 있다.

홈페이지에서 `Download For Mac` 버튼을 누르면 다운되며 압축을 풀면 바로 하나의 실행 파일 형태로 설치가 끝난다.

> 필요하다면 실행 파일을 맥의 `Application` 폴더로 이동하여 `Launchpad`에 등록하거나 앱 아이콘을 끌어다가 `Dock`에 두고 사용할 수 있다.

### Atom 설정하기

[Atom Setting](http://lks21c.blogspot.kr/2015/06/atom-shortcut.html)


### 터미널에서 아톰 실행하기

터미널에서 Atom 에디터를 실행하려면 다음과 같이 입력하면 된다.

```bash
$ atom .
```

`"."`은 현재 폴더를 프로젝트로 연다는 의미가 되며 atom 뒤에 특정 파일 이름을 입력하면 해당 파일을 열게 된다.[^stackoverflow]


### 고찰 하기

Atom 명령이나 설정 관련 내용을 계속해서 기록 할 예정이다.

### 참고 자료

[^Atom]: [Atom.io](https://atom.io)

[^kichul]: [KICHUL's Blog](http://blog.kichul.co.kr/2015-08-25-Atom%20Editor/)

[^stackoverflow]: [Open Atom editor from command line](http://stackoverflow.com/questions/22390709/open-atom-editor-from-command-line)
