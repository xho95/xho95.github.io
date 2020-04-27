---
layout: post
comments: true
title:  "macOS: 파일 시스템의 유닉스-고유 디렉토리 알아보기"
date:   2016-10-09 02:50:00 +0900
categories: macOS File-System UNIX-specific Directory
---

> 이 글은 macOS 의 파일 시스템에 있는 '유닉스-고유 디렉토리 (UNIX-specific directories)' 에 대해 정리한 글입니다.
>
> macOS 파일 시스템의 기본적인 디렉토리들에 대해서는 [macOS: 파일 시스템의 기본 디렉토리 구조](http://xho95.github.io/macos/file-system/directory/2020/04/20/macOS-File-System-Layout.html) 를 참고하기 바랍니다.

## macOS 파일 시스템의 '유닉스-고유 디렉토리 (UNIX-specific directories)'

macOS 의 파일 시스템은 기본적으로 '표준 디렉토리 (standard directories)'[^standard-directories] 와 '유닉스-고유 디렉토리 (UNIX-specific directories)'[^UNIX-specific-directories] 라는 두 가지 종류의 디렉토리로 구성되어 있습니다.

macOS 에 '유닉스-고유 디렉토리' 라는 것이 존재하는 이유는 macOS 의 커널 (kernel) 인 [Darwin](https://en.wikipedia.org/wiki/Darwin_(operating_system)) 이 [BSD (Berkeley Software Distribution)](https://en.wikipedia.org/wiki/Berkeley_Software_Distribution) 라는 UNIX 계열 운영 체제에서 파생되었기 때문입니다.

다음과 같이 **Terminal** 에서 루트 (root) 디렉토리로 이동한 후 `ls` 명령을 실행하면, macOS 의 최상위 계층에 존재하는 디렉토리들을 볼 수 있습니다.

```sh
$ cd /
$ ls
Applications System       bin          etc          private      usr
Library      Users        cores        home         sbin         var
Preboot      Volumes      dev          opt          tmp
```

'유닉스-고유 디렉토리' 는 위 결과 중에서 다음과 같이 소문자로 시작하는 디렉토리들을 말하는 것으로, 이들은 **Finder** 에서는 확인할 수 없습니다.[^finder]

```sh
├── bin
├── cores
├── dev
├── etc -> private/etc
├── home -> /System/Volumes/Data/home
├── opt
├── private
├── sbin
├── tmp -> private/tmp
├── usr
└── var -> private/var
```

### 각 유닉스-고유 디렉토리의 역할

maxOS 에 있는 '유닉스-고유 디렉토리' 의 기능을 확인할 수 있는 방법 중 가장 간단한 것은 다음과 같이 **Terminal** 에서 `man hier` 명령을 실행하는 것입니다.[^man-hier]

```sh
$ man hier
```

위 명령은 macOS 파일 시스템의 '유닉스-고유 디렉토리' 에 대한 설명만 나오는 것을 볼 수 있는데, '표준 디렉토리' 에 대해 알고 싶으면 [File System Programming Guide](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/Introduction/Introduction.html) 을 보라고 짤막하게 알려줍니다.

해당 설명을 기준으로 각 디렉토리의 기능을 간단히 정리하면 다음과 같습니다.

#### `/` : 루트 디렉토리

'루트 (root) 디렉토리' 는 파일 시스템에서 계층 구조의 첫번째 또는 최상위 디렉토리를 말합니다. macOS 에서는 어느 위치에서든 **Terminal** 에서 다음과 같은 명령을 사용하여 '루트 디렉토리' 로 이동할 수 있습니다.[^directory-separator]

```sh
$ cd /
```

#### `/bin` : 실행 파일 디렉토리

'단일 사용자 (single-user)' 와 '다중 사용자 (multi-user)' 환경에서 필수적인 '명령줄 실행 파일 (command-line binaries)' 을 저장하는 디렉토리입니다. macOS 의 각종 'shell (쉘)' 프로그램들이 여기에 존재하는 것을 볼 수 있습니다.

#### `/cores` : 디렉토리

`/cores` 디렉토리에 대한 설명은 `man hier` 명령으로 확인할 수 없는데, 대신 [OS X El-Capitan - /cores directory taking up a lot of space?](https://apple.stackexchange.com/questions/215410/os-x-el-capitan-cores-directory-taking-up-a-lot-of-space) 라는 글에서 잘 설명하고 있습니다.

#### `/dev` : 장치 파일 디렉토리

'보조 하드웨어 장비' 가 연결되었을 때 해당 '장치 파일 (device files)' 을 담는 디렉토리입니다. 이름의 유래는 'device' 인 것으로 추측됩니다.

#### `/etc` : 환경 설정 디렉토리

사용자 고유의 환경 설정 파일을 저장하는 디렉토리입니다. 대표적으로 'shell (쉘)' 의 기본 설정 파일인 **profile**[^profile] 과 macOS 의 기본 경로 설정 파일인 **paths**[^paths] 등이 여기에 존재합니다.

macOS 에 있는 별도 프로그램들의 설정 파일들은 `/etc` 디렉토리의 하위 디렉토리에 저장됩니다. 예를 들어, **apache** (아파치) 프로그램의 설정 파일은 `/etc/apache2` 디렉토리에 저장되어 있습니다.

#### `/home` : UNIX 시스템의 홈 디렉토리, macOS 에서는 사용하지 않음

`/home` 디렉토리는 유닉스에서 기본 '홈 디렉토리' 로 사용되는 곳입니다. 하지만 macOS 의 기본 '홈 디렉토리' 는 `/home` 디렉토리가 아닙니다. 대신 `/Users` 디렉토리를 사용합니다. [What is standard for OS X filesystem? e.g. /opt/ vs. /usr/](https://apple.stackexchange.com/questions/119230/what-is-standard-for-os-x-filesystem-e-g-opt-vs-usr)

macOS 의 '홈 디렉토리 (`~`)' 에 대해서는 아래의 [홈 디렉토리](#--macos-의-홈-디렉토리) 에서 다시 설명하도록 합니다.

#### `/sbin` : 시스템 실행 파일 디렉토리

'단일 사용자 (single-user)' 와 '다중 사용자 (multi-user)' 환경에서 필수적인 '시스템 실행 파일' 을 저장하는 디렉토리입니다. macOS 에서는 **ping** 과 같은 프로그램들이 여기에 있습니다.

#### `/tmp` : 임시 파일 디렉토리

앱이나 시스템에서 생성한 임시 파일들을 저장하는 디렉토리입니다.

#### `/usr` : 사용자 디렉토리

* **/usr** — 필수적이지는 않은 '명령줄 실행 파일' 이나 라이브러리, 헤더 파일, 그리고 기타 자료들을 담는 곳입니다. contains the majority of user utilities and applications

#### `/var` : 변경 파일 디렉토리

자주 변경되는 파일들을 위한 공간입니다. 리눅스 시스템에서는 사용 중에 생성되었다가 삭제되는 데이터를 일시적으로 저장하기 위해 사용합니다. 맥에서도 같은 목적으로 사용하는 디렉토리인 것 같습니다.

예를 들어 **/var/log** 디렉토리에는 시스템 로그 파일들이 저장되어 있는 것을 볼 수 있습니다.

> 폴더 이름은 [Unix filesystem](https://en.wikipedia.org/wiki/Unix_filesystem#Conventional_directory_layout) 이라는 글에 따르면 `variable` 을 의미한다고 합니다.

* **/var** — 'log (로그)' 파일 및 '변수 값' 을 가지고 있는 파일들을 담는 곳입니다.

#### `/private` : 개인 사용자 디렉토리

맥에서 `/etc` 디렉토리는 실제 `/private/etc` 디렉토리의 'symbolic link (일종의 바로 가기)' 입니다. [What's the difference between /private/etc/apache2 and /etc/apache2?](https://superuser.com/questions/480135/whats-the-difference-between-private-etc-apache2-and-etc-apache2)

이것은 아래와 같이 `ls -l` 명령을 통해서 확인할 수 있습니다. [How to know if a folder is a symbolic link?](https://askubuntu.com/questions/1145925/how-to-know-if-a-folder-is-a-symbolic-link)

```sh
$ ls -l
...
lrwxr-xr-x@  1 root  admin    11 Oct  9  2019 etc -> private/etc
...
drwxr-xr-x   6 root  wheel   192 Apr 12 17:49 private
...
```

즉, `/etc` 디렉토리의 파일을 수정하는 것은 `/private/etc` 디렉토리에 있는 파일을 수정하는 것과 완전히 동일합니다.

`/private` 디렉토리는 'NextStep' 운영체제의 유산이라는 얘기도 있습니다. [What is the private folder on a Mac computer?](https://www.quora.com/What-is-the-private-folder-on-a-Mac-computer) 글에 따르면 예전에는 컴퓨터의 저장 공간이 부족해서 OS 정보를 네트웍 상에 분산하기도 했으며, `/private` 디렉토리를 써서 해당 기기에 특화된 정보를 저장했다고 합니다. 그래서 `/etc` 가 `/private/etc` 의 '심볼릭 링크' 가 된 것 같습니다. 좀 더 정리가 필요합니다.

macOS 의 기본 디렉토리의 각각의 기능에 대해서는 [What's the “Private” directory in OS X for?](https://apple.stackexchange.com/questions/227846/whats-the-private-directory-in-os-x-for/227869) 에서 간단하게 소개하고 있습니다.

### `~` : macOS 의 홈 디렉토리

**macOS 에서 '홈 디렉토리' 는 특별하다 할 수 있습니다. 일단 '유닉스-고유 디렉토리' 와 달라지는 지점입니다. 이는 UNIX 와 달리 'GUI' 를 지원했기 때문일 수 있습니다. 확인 필요함. 실제로 '유닉스-고유 디렉토리' 를 사용하지 않고 '표준 디렉토리' 를 사용합니다.**

'홈 (home) 디렉토리' 는 다중 사용자 운영 체제에서의 파일 시스템 디렉토리를 말합니다. [^wikipedia-home]

여기서 다중 사용자라는 말에는 로그인한 사용자마다 별도의 홈 디렉토리가 생긴다는 의미가 담겨 있고, 파일 시스템이라는 말에는 사용자가 만들고 사용하는 파일들을 관리한다는 의미가 담겨 있습니다.

홈 디렉토리는 해당 시스템의 사용자에게 주어진 파일들을 포함합니다. 즉 사용자가 컴퓨터를 사용하면서 만들고 사용하는 파일들은 홈 디렉토리 밑에 저장됩니다.

맥의 경우 터미널에서 홈 디렉토리로 이동하려면 아래와 같은 2가지의 명령 중 하나를 실행하면 됩니다.

```
$ cd $HOME
$ cd ~
```

보통의 경우 편리하므로 두번째 방법을 많이 사용합니다. [^another-method]

macOS 에서 실제 홈 디렉토리는 루트 디렉토리 밑의 **/Users/\<** username **\>** 위치에 존재합니다.

### 참고 자료

[^standard-directories]: macOS 의 '표준 디렉토리 (Standard Directories)' 에 대해서는 [File System Basics](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW2) 문서의 [macOS Standard Directories: Where Files Reside](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW6) 부분에서 설명하고 있습니다.

[^UNIX-specific-directories]: macOS 의 '유닉스-고유 디렉토리 (UNIX-specific directories)' 에 대해서는 [File System Basics](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW2) 문서의 [Hidden Files and Directories: Simplifying the User Experience](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW7) 부분에서 설명하고 있습니다.

[^finder]: 이 부분에 대한 더 자세한 내용은 [macOS: 파일 시스템의 기본 디렉토리 구조](http://xho95.github.io/macos/file-system/directory/2020/04/20/macOS-File-System-Layout.html) 를 확인하기 바랍니다.

[^man-hier]: 파일 내용이 길 경우 `$ man hier > hier.txt` 와 같이 파일로 옮겨서 확인할 수도 있습니다.

[^directory-separator]: macOS 에서는 슬래쉬 (`/`) 기호가 루트 디렉토리를 의미하기도 하지만 디렉토리를 구분할 때도 사용됩니다. 예전에는 macOS 에서 디렉토리를 구분할 때 콜론 (`:`) 기호를 사용했으며 그래서 예전 자료를 보면 디렉토리를 구분할 때 콜론 (`:`) 기호를 사용하는 경우가 있습니다. 지금은 '디렉토리 구분자' 가 슬래쉬 기호로 통일되었습니다. '디렉토리 구분자' 에 대해서는 [When did the colon character : become an allowed character in the filesystem?](https://apple.stackexchange.com/questions/173529/when-did-the-colon-character-become-an-allowed-character-in-the-filesystem) 글을 참고하기 바랍니다.

[^profile]: macOS Catalina 에서부터 기본 쉘이 'bash' 에서 'zsh (z 쉘)' 로 변경되었습니다. 'zsh' 의 기본 설정 파일은 `zprofile` 인데, 이 파일 역시 `/etc` 디렉토리에 있습니다. 직접 `sh` 을 사용하지 않는다면 `profile` 대신, `zprofile` 을 사용할 것입니다.

[^paths]: [wisseraph](http://elfinlas.tistory.com) 님의 [Mac에서 Path 설정하기](http://elfinlas.tistory.com/266) 글을 보면 `/etc/paths` 는 가장 기본이 되는 경로를 설정하는 파일임을 알 수 있습니다.
