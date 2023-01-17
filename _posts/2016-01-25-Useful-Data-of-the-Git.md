---
layout: post
pagination: 
  enabled: true
comments: true
title:  "Git 관련 자료 모음"
date:   2016-01-25 21:25:00 +0900
categories: Resources Sites Books Git
---

여기서는 Git의 사용법에 대해서 정리하도록 합니다. 아직은 관련 링크만 연결해두었지만 차차 내용을 정리할 생각입니다.

### Git 기본 명령어들

터미널에서 `git --help`를 입력하면 기본 사용법이 나오는데, 이 때 기본 명령어들에 대한 간단한 설명들이 나옵니다.

```
$ git --help
```

#### 작업 공간 시작하기

* `clone` : 원격 저장소를 지역 디렉토리에 복제합니다.
* `init` : 비어있는 Git 저장소를 만들거나 기존에 있던 것을 초기화합니다.

> `git help tutorial`의 결과도 살펴볼 필요가 있습니다.

#### 현재의 변경에서 작업하기

* `add` : 파일 변경 내용을 인덱스에 추가합니다.
* `mv` : 파일, 디렉토리, 또는 (연결)링크를 옮기거나 이름을 변경합니다.
* `reset` : 현재 **HEAD** 를 특정한 상태로 재설정합니다.
* `rm` : 파일들을 작업 트리와 인덱스에서 제거합니다.

> `git help everyday`의 결과도 살펴볼 필요가 있습니다.

#### 변경 내력과 상태를 검사하기

* `bisect` : 버그를 알리는 커밋을 찾기 위해 이진 트리를 사용합니다.
* `grep` : 패턴과 들어맞는 라인들을 출력합니다.
* `log` : 커밋 로그들을 보여줍니다.
* `show` : 다양한 타입의 객체들을 보여줍니다.
* `status` : 작업 트리의 상태를 보여줍니다.

> `git help revisions`의 결과도 살펴볼 필요가 있습니다.

#### 변경 내력을 키우고, 표시하고, 비틀기

* `branch` : 브랜치들을 나열하고, 만들고, 또는 지웁니다.
* `checkout` : 브랜치들을 바꾸거나 작업 트리 파일들을 재저장합니다.
* `commit` : 변경 사항들을 저장소에 기록합니다.
* `diff` : 커밋들 또는 커밋과 작업 트리 사이의 변경 사항을 보여줍니다.
* `merge` : 두 개 또는 다수의 개발 변경 내력을 서로 합칩니다.
* `rebase` : Forward-port local commits to the updated upstream head (아직 뭐라고 번역해야할지 모르겠습니다. ㅜㅜ)
* `tag` : GPG로 표기된 태그 객체를 만들고, 나열하고, 지우고, 또는 확인합니다.

#### 협업하기

* `fetch` : 다른 저장소에서 객체들과 참조들을 다운로드 합니다.
* `pull` : 다른 저장소나 브랜치에서 fetch를 하고 취합합니다.
* `push` : 원격 참조들을 관련된 객체들을 가지고서 업데이트 합니다.

> `git help workflows`의 결과도 살펴볼 필요가 있습니다.

### 고찰하기

현재는 **Git** 관련 자료와 **GitHub** 자료들이 섞여 있는데, 나중에 이들을 분리해서 포스팅할 예정입니다.

### 참고 자료

#### Git 관련 인터넷 자료들

[GitHub Guides](https://guides.github.com) : GitHub 사용과 관련한 전체 도움말 사이트입니다.

[Git Large File Storage](https://git-lfs.github.com) : GitHub에 최근에 도입된 대용량 파일 시스템에 대해 설명한 곳입니다.

[Resolving a merge conflict from the command line](https://help.github.com/articles/resolving-a-merge-conflict-from-the-command-line/) : 터미널에서 Merge 시에 충돌 문제를 해결하는 방법에 대해 설명한 곳입니다.

#### Git 참고 서적들

[만들면서 배우는 Git+GitHub 입문](http://www.hanbit.co.kr/book/look.html?isbn=978-89-6848-202-1) : Xcode에서 Git의 사용법이 설명되어 있는 책이다.

[Pro Git 정리 자료](https://git-scm.com/book/ko/) : Git 사용법에 대해서 잘 설명된 책인 Pro Git을 인터넷에 정리한 곳으로, 한글로도 책을 이용할 수 있습니다. Git 관련 자료로는 최고의 사이트라고 할 수 있을 것 같습니다.

#### Git 관련 블로그 자료들

[완전 초보를 위한 깃허브](https://nolboo.github.io/blog/2013/10/06/github-for-beginner/) : 초보자를 위해 Git을 설명한 [놀부님 블로그](https://nolboo.github.io/) 글입니다.

[GitHub로 남의 프로젝트에 감놓고 배놓기](https://dogfeet.github.io/articles/2012/how-to-github.html)

[Github를 이용하는 전체 흐름 이해하기 #1](https://blog.outsider.ne.kr/865)

[A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/) : 프로젝트를 진행할 때 Branch를 어떻게 만들면 좋은지에 대해 설명한 블로그 글입니다.

[Git Tutorial (Git 사용하기, 튜토리얼)](http://sapeyes.blog.me/70118257910)

[git 파일 대소문자 변경하기](http://ohgyun.com/518) 다음에 git 파일 이름 변경 및 이동에 대한 내용을 정리할 필요가 있습니다. git mv 와 그냥 mv는 역할이 다른 것 같습니다.

[git 대소문자 변경하기](http://wkdgusdn3.tistory.com/entry/Git-git-대소문자-변경하기)

#### Organization

[6.4 GitHub - Organization 관리하기](https://git-scm.com/book/ko/v2/GitHub-Organization-관리하기)

[GitHub 협업 - 조직, 팀 만들기](http://i5on9i.blogspot.kr/2015/09/github.html)


#### 원격 Git 저장소 사이트들

[GitHub](https://github.com) : Git을 위한 원격 저장소를 제공해주는 사이트이다. 이 블로그도 GitHub에서 관리하고 있다.

[GitLab](https://about.gitlab.com) : GitHub와 유사하게 원격 저장소를 제공하는 사이트이다. 한가지 다른 점이라면 무료로 Private Repository를 만들 수 있다는 점이다. 잘 활용하면 좋을 것 같다.

#### GitHub

[GitHub Developer Guide](https://developer.github.com/)

[Github LFS 테스트 :: Outsider's Dev Story](https://blog.outsider.ne.kr/1147)

[Creating Project Pages manually](https://help.github.com/articles/creating-project-pages-manually/)


#### Sourcetree 자료들

[Sourcetree를 이용한 Github 시작하기](http://hackersstudy.tistory.com/41)


#### GitHub gist

[Example of how to embed a Gist on GitHub Pages using Jekyll.](https://gist.github.com/benbalter/5555251)

[What You Can Do With Gists on Github?](http://www.labnol.org/internet/github-gist-tutorial/28499/)

[블로그 등에 소스 코드 Snippet 붙여넣기 - GitHub Gist](http://hanmomhanda.tistory.com/entry/블로그-등에-소스-코드-Snippet-붙여넣기-GitHub-Gist)
