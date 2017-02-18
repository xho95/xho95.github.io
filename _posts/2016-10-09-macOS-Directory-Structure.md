---
layout: post
comments: true
title:  "macOS: 맥의 기본 디렉토리 구조 살펴보기"
date:   2016-10-09 02:50:00 +0900
categories: macOS File System Directory
---

보통 맥을 사용하다보면 많은 경우 디렉토리를 의식하지 않고 사용하게 됩니다. [^directory-folder] [^mwultong-folder-directory] 예를 들어, 어떤 프로그램을 설치할 경우 대부분의 사용자는 프로그램이 설치되는 위치를 변경하지 않을 것입니다. 그러다 보니 해당 프로그램이 어디에 설치되는지 어떻게 동작하는지 잘 모르고 사용하는 경우가 많습니다.  

하지만 맥을 좀 더 잘 사용하고 싶다면 결국 macOS 의 좀 더 밑부분, 그 중에서 macOS 의 디렉토리 구조에 대해서 알아둘 필요가 있습니다. 여기서는 macOS 의 기본 디렉토리 구조에 대해서 정리하도록 합니다. 

### 들어가며 

이 글은 [흉내쟁이](http://webdir.tistory.com) 님의 [리눅스 디렉토리 구조](http://webdir.tistory.com/101) 라는 글을 기준으로 여기에 기타 다른 자료들을 참고하여 정리하였습니다. [^webdir-101] [^osxdaily-directory] [^wikipedia-unix-filesystem]

> 아직은 그 때 그 때 알게된 지식을 정리한 것이라서 내용이 완전하지는 않습니다. 다만 앞으로 계속해서 관련 내용을 추가할 예정입니다.

흉내쟁이님의 글은 리눅스 (Linux) 에 대한 글이지만 macOS 에도 많은 부분이 해당되는 것 같습니다. 이는 [위키피디아](https://en.wikipedia.org/wiki/Main_Page) 의 [Unix-like](https://en.wikipedia.org/wiki/Unix-like) 라는 글에서도 알 수 있듯이 리눅스와 맥 OS 모두 유닉스-계열-OS (Unix-like-OS) 라서 시스템 기본 구조가 비슷하기 때문인 듯 합니다. [^wiki]

### macOS 디렉토리 구조

#### `/` : 루트 디렉토리

루트 디렉토리 (root directory) 는 컴퓨터 파일 시스템에서 계층 구조의 첫번째 또는 최상위 디렉토리를 가리킵니다. 트리 구조의 줄기에 비유할 수 있는데, 모든 가지들이 뻗어 나오는 시작점의 역할을 합니다. [^wikipedia-Root]  

터미널에서 맥의 루트 디렉토리로 이동하려면 다음과 같은 명령을 실행하면 됩니다. [^path]

```
$ cd /
```

> **디렉토리 구분자 (Directory Separator)**
> 
> 맥에서는 슬래쉬 (`/`) 기호가 단독으로는 루트 디렉토리를 의미하지만 디렉토리의 구분자로도 사용됩니다. 
> 
> 다만 맥의 경로와 관련한 예제에서 가끔 콜론 (`:`) 기호를 사용하는 경우를 볼 수 있습니다. 이것은 원래 예전의 맥이 디렉토리 구분자로 콜론 기호를 사용했기 때문입니다. [^stackexchange-173529] 지금은 슬래쉬 기호로 통일되었습니다.

#### `~` : 홈 디렉토리

홈 디렉토리 (home directory) 는 다중 사용자 운영 체제에서의 파일 시스템 디렉토리를 말합니다. [^wikipedia-home] 

여기서 다중 사용자라는 말에는 로그인한 사용자마다 별도의 홈 디렉토리가 생긴다는 의미가 담겨 있고, 파일 시스템이라는 말에는 사용자가 만들고 사용하는 파일들을 관리한다는 의미가 담겨 있습니다.

홈 디렉토리는 해당 시스템의 사용자에게 주어진 파일들을 포함합니다. 즉 사용자가 컴퓨터를 사용하면서 만들고 사용하는 파일들은 홈 디렉토리 밑에 저장됩니다.

맥의 경우 터미널에서 홈 디렉토리로 이동하려면 아래와 같은 2가지의 명령 중 하나를 실행하면 됩니다.

```
$ cd $HOME
$ cd ~
```

보통의 경우 편리하므로 두번째 방법을 많이 사용합니다.

macOS 에서 실제 홈 디렉토리는 루트 디렉토리 밑의 **/Users/\<**username**\>** 위치에 존재합니다.

#### `/etc` : 환경 설정 디렉토리

리눅스 시스템에서 **/etc** 폴더는 주로 환경 설정 파일들이 존재하는 곳입니다. 맥에서도 **/etc** 폴더에 환경 설정 파일들이 존재하는 것을 볼 수 있습니다.

대표적으로 배쉬 쉘(bash shell)의 기본 설정 파일인 **profile** 파일과 맥의 기본 경로를 설정하는 파일인 **paths** 파일이 이 디렉토리에 있습니다. [^appletree]  [^elfinlas]

그 외에 아파치(apache) 같은 별도 프로그램들은 **/etc** 폴더의 하위 폴더에 설정 파일들이 존재합니다.

#### `/var` : 임시 파일 디렉토리

자주 변경되는 파일들을 위한 공간입니다. 리눅스 시스템에서는 사용 중에 생성되었다가 삭제되는 데이터를 일시적으로 저장하기 위해 사용합니다. 맥에서도 같은 목적으로 사용하는 디렉토리인 것 같습니다.

예를 들어 **/var/log** 디렉토리에는 시스템 로그 파일들이 저장되어 있는 것을 볼 수 있습니다.

> 폴더 이름은 [Unix filesystem](https://en.wikipedia.org/wiki/Unix_filesystem#Conventional_directory_layout) 이라는 글에 따르면 `variable` 을 의미한다고 합니다. 

### 고찰하기

맥을 사용하기 이전에 맥의 근간이 되는 유닉스(Unix) 시스템을 아직 잘 모르는 상태라서  아직은 자료가 부족하지만 새로운 내용을 알게 되면 계속 업데이트할 예정입니다.

### 변경 사항

* **2017. 02. 17.** 전체 내용을 다시 정리하면서 새로운 참고 자료를 추가하였습니다.
* **2016. 10. 08.** 첫 포스트를 작성했습니다.

### 참고 자료

[^directory-folder]: 맥을 사용하다보면 디렉토리 (directory) 라는 말과 폴더 (folder) 라는 말을 거의 같은 뜻으로 사용하게 됩니다. 그런데 [What is the difference between a directory and folder?](http://www.computerhope.com/issues/ch001320.htm) 라는 글을 보면 실제로 이 둘의 의미는 같지만 , 보통 [CLI](https://en.wikipedia.org/wiki/Command-line_interface) 에서는 디렉토리라는 말을 [GUI](https://en.wikipedia.org/wiki/Graphical_user_interface) 에서는 폴더라는 말을 사용하는 것이 보다 정확한 표현이라고 합니다.

[^mwultong-folder-directory]: [mwultong](http://mwultong.blogspot.com) 님의 [폴더와 디렉토리 차이점; Folder, Directory 차이](http://mwultong.blogspot.com/2007/07/folder-directory.html) 라는 글도 비슷한 내용을 담고 있는데 폴더가 디렉토리보다 조금 더 넓은 의미로 사용된다고 합니다.

[^webdir-101]: [흉내쟁이](http://webdir.tistory.com) 님의 블로그에 있는 [리눅스 디렉토리 구조](http://webdir.tistory.com/101) 라는 글에는 리눅스 파일 시스템의 구조와 각 디렉토리에 대한 설명이 잘 정리되어 있습니다.

[^osxdaily-directory]: 구글 검색에서 찾은 [Mac OS X Directory Structure explained](http://osxdaily.com/2007/03/30/mac-os-x-directory-structure-explained/) 라는 글은 설명은 잘 되어 있는 것 같은데, 자료 자체가 오래된 것이라 지금과는 다른 부분이 조금 있는 것 같습니다. 나중에 관련 내용을 반영할 예정입니다.

[^wikipedia-unix-filesystem]: 위키피디아에 있는 [Unix filesystem](https://en.wikipedia.org/wiki/Unix_filesystem#Conventional_directory_layout) 이라는 글도 아주 좋은 것 같습니다. 나중에 관련 내용을 추려서 정리할 예정입니다.

[^wiki]: 위키피디아의 [Unix-like](https://en.wikipedia.org/wiki/Unix-like) 라는 글을 보면 유닉스-계열-OS 에 대한 계통이 잘 나와있습니다. 리눅스와 macOS 는 결국 하나의 뿌리를 가지고 있음을 알 수 있습니다.

[^wikipedia-Root]: 위키피디아의 [루트 디렉토리](https://ko.wikipedia.org/wiki/루트_디렉토리) 라는 글에는 루트 디렉토리의 의미를 설명하고 있는데 원문인 [Root directory](https://en.wikipedia.org/wiki/Root_directory) 에 훨씬 더 많은 설명이 있습니다. 원문과 번역글의 질의 차이는 위키피디아의 특징이기도 합니다.

[^path]: 위키피디아의 [Path (computing)](https://en.wikipedia.org/wiki/Path_(computing)) 라는 글에는 각각의 운영체제에서 경로를 지정하는 방법을 비교해 놓았습니다. 자료의 표를 보면 macOS 가 따로 없는 것을 알 수 있는데, macOS 는 그냥 맨 처음의 유닉스-계열 (Unix-like) OS 에 포함이 되기 때문입니다.

[^stackexchange-173529]: [When did the colon character : become an allowed character in the filesystem?](http://apple.stackexchange.com/questions/173529/when-did-the-colon-character-become-an-allowed-character-in-the-filesystem) 라는 글타래를 보면 맥 OS X 가 처음 나올 때 디렉토리 구분자의 변경이 있었다고 합니다.

[^wikipedia-home]: 위키피디아의 [Home directory](https://en.wikipedia.org/wiki/Home_directory) 글에는 각각의 운영체제 별로 홈 디렉토리 위치를 표로 보여주고 있습니다.

[^appletree]: miname 님이 [사과나무 이야기 마당](http://appletree.or.kr/forum/index.php)이라는 곳에 배쉬 쉘에 관련된 좋은 원문을 [bash on Mac OS X](http://appletree.or.kr/forum/viewtopic.php?id=13) 라는 글로 번역해서 정리해 두었습니다. 원문은 [bash on Mac OS X](http://www.macdevcenter.com/pub/a/mac/2004/02/24/bash.html) 입니다. 맥에서 사용되는 환경 설정 파일들을 비교 분석한 글인 [Bash: about .bashrc, .bash_profile, .profile, /etc/profile, etc/bash.bashrc and others](http://stefaanlippens.net/bashrc_and_others/) 라는 글도 읽어볼만합니다.

[^elfinlas]: wisseraph 님의 [MHLab Blog](http://elfinlas.tistory.com) 블로그에 쓰신 [Mac에서 Path 설정하기](http://elfinlas.tistory.com/266) 라는 글에는 **/etc/paths** 파일과 **/etc/profile** 파일의 기능에 대해서 설명이 잘 되어 있습니다.
