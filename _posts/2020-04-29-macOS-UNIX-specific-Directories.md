---
layout: post
pagination:
  enabled: true
comments: true
title:  "macOS: 파일 시스템 (APFS) 의 유닉스-고유 디렉토리 알아보기"
date:   2020-04-29 02:50:00 +0900
categories: macOS File-System UNIX-specific Directory
redirect_from: "/macos/file-system/unix-specific/directory/2020/04/28/macOS-UNIX-specific-Directories.html"
---

> 이 글은 macOS 의 파일 시스템에 있는 '유닉스-고유 디렉토리 (UNIX-specific directories)' 에 대해 정리한 글입니다.
>
> macOS 파일 시스템의 기본적인 디렉토리들에 대해서는 [macOS: 파일 시스템의 기본 디렉토리 구조]({% post_url 2020-04-20-macOS-File-System-Layout %}) 를 보도록 합니다.

## macOS 파일 시스템의 '유닉스-고유 디렉토리 (UNIX-specific directories)'

macOS 의 파일 시스템은 기본적으로 '표준 디렉토리 (standard directories)'[^standard-directories] 와 '유닉스-고유 디렉토리 (UNIX-specific directories)'[^UNIX-specific-directories] 라는 두 가지 종류의 디렉토리로 구성되어 있습니다.

macOS 에 '유닉스-고유 디렉토리' 라는 것이 존재하는 이유는 macOS 의 커널 (kernel) 인 [Darwin](https://en.wikipedia.org/wiki/Darwin_(operating_system)) 이 [BSD (Berkeley Software Distribution)](https://en.wikipedia.org/wiki/Berkeley_Software_Distribution) 라는 '유닉스 (UNIX)' 계열 운영 체제에서 파생되었기 때문입니다.

다음과 같이 **Terminal** 에서 루트 (root) 디렉토리로 이동한 후 `ls` 명령을 실행하면, macOS 의 최상단 계층에 존재하는 디렉토리들을 볼 수 있습니다.

```sh
$ cd /
$ ls
Applications System       bin          etc          private      usr
Library      Users        cores        home         sbin         var
Preboot      Volumes      dev          opt          tmp
```

'유닉스-고유 디렉토리' 는 위 결과 중에서 소문자로 시작하는 디렉토리들을 말하는 것으로 목록을 나열하면 아래와 같습니다. 이들은 '표준 디렉토리' 와는 달리 **Finder** 에서는 보이지 않도록 숨겨져 있습니다.[^finder]

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

### '유닉스-고유 디렉토리 (UNIX-specific directories)' 각각의 역할

maxOS 에 있는 '유닉스-고유 디렉토리' 의 기능을 확인하는 방법 중 가장 간단한 것은 다음과 같이 **Terminal** 에서 `man hier` 명령을 실행하는 것입니다.[^man-hier]

```sh
$ man hier
```

위 명령을 실행하면 macOS 파일 시스템의 '유닉스-고유 디렉토리' 에 대한 설명이 나오는 것을 확인할 수 있습니다. 참고로 '표준 디렉토리' 에 대한 설명은 없으며, '표준 디렉토리' 에 대해 알고 싶으면 [File System Programming Guide](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/Introduction/Introduction.html) 을 보라고 짤막하게 알려줍니다.

해당 설명을 기준으로 각 디렉토리의 역할을 정리하면 다음과 같습니다.[^standard-os-x]

#### `/` : 루트 디렉토리

macOS 에서는 '빗금 (slash; `/`)' 기호가 '_루트 디렉토리 (root directory)_' 를 의미합니다. '루트 디렉토리' 는 파일 시스템에서 계층 구조의 첫번째 또는 최상단 디렉토리를 말합니다. **Terminal** 에서 다음과 같은 명령을 사용하면, 어느 위치에 있든 '루트 디렉토리' 로 이동할 수 있습니다.

```sh
$ cd /
```

'빗금 (slash; `/`)' 기호는 '루트 디렉토리' 를 의미하기도 하지만, 디렉토리를 구분하는 '디렉토리 구분자 (directory separator)' 로도 사용됩니다.[^directory-separator] 즉, `/usr` 디렉토리 밑에 있는 `/usr/bin` 디렉토리로 이동할 때는 다음과 같이 하면 됩니다.

```sh
$ cd /usr/bin
```

#### `/bin` : 실행 파일 디렉토리

'단일 사용자 (single-user)' 환경과 '다중 사용자 (multi-user)' 환경 모두에서 사용하는 주요 '명령줄 실행 파일 (command-line binaries)' 을 저장하는 디렉토리입니다.

macOS 의 각종 **shell** (쉘) 을 포함하여 **mkdir** 같은 실행 파일들이 여기에 존재합니다.

#### `/cores` : 개발 관련 디렉토리

`/cores` 디렉토리에 대한 설명은 `man hier` 명령으로 확인할 수 없습니다. 왜냐면 이 디렉토리는 일반적인 상황에서는 나타나지 않기 때문입니다.

`/cores` 디렉토리는 macOS 에서 개발 및 테스트를 하는 과정에서 충돌이 발생할 경우, 그 당시의 '메모리 상태 (the state of the memory)' 들을 파일로 저장하는 디렉토리라고 합니다.[^cores]

#### `/dev` : 장치 파일 디렉토리

연결된 '보조 하드웨어' 등 '장치 파일 (device files)' 을 담고 있는 디렉토리입니다.

#### `/etc` : 환경 설정 디렉토리

사용자 고유의 환경 설정 파일을 저장하는 디렉토리입니다. 대표적으로 macOS 의 '쉘 (shell)' 기본 설정 파일인 **profile**[^profile] 과 기본 경로 설정 파일인 **paths**[^paths] 등이 여기에 존재합니다.

별도 프로그램에 대한 설정 파일은 `/etc` 의 하위 디렉토리에 저장되는 경우가 많습니다. 예를 들어, **apache** (아파치) 프로그램의 설정 파일은 `/etc/apache2` 디렉토리에 존재합니다.

> macOS 에서 `/etc` 디렉토리는 실제로는 `/private/etc` 디렉토리의 '심볼릭 링크 (symbolic link)' 입니다.[^symbolic-link] 즉, `/etc/apache2` 디렉토리는 `/private/etc/apache2` 디렉토리와 같은 곳입니다.
>
> `/private` 디렉토리에 대해서는 아래의 [`/private` : 개인 사용자 디렉토리](#private--개인-사용자-디렉토리) 에서 따로 설명하도록 합니다.

#### `/home` : 유닉스 시스템의 홈 디렉토리 - macOS 에서는 사용하지 않음

보통 `/home` 디렉토리는 유닉스 파일 시스템에서 기본 '홈 디렉토리 (home directory)' 로 사용되는 곳입니다. 하지만 macOS 에서는 '홈 디렉토리' 로 `/home` 대신 `/Users/username` 디렉토리를 사용합니다.

macOS 의 '홈 디렉토리' 에 대해서는 아래의 [홈 디렉토리](#--macos-의-홈-디렉토리) 에서 따로 설명하도록 합니다.

> 참고로 macOS 에서 `/home` 디렉토리는 실제로는 `/System/Volumes/Data/home` 에 대한 '심볼릭 링크 (symbolic link)'-또는 이와 비슷한 '고정 링크 (firmlink)'-입니다.[^firmlink] 이 중 `/System/Volumes/Data` 디렉토리는 macOS '하이 시에라 (High Sierra)' 부터 도입한 [APFS (Apple File System)](https://en.wikipedia.org/wiki/Apple_File_System) 의 '마운트된 부팅 디스크' 를 의미하는 것 같습니다.[^APFS-boot-directory]

#### `/sbin` : 시스템 실행 파일 디렉토리

'단일 사용자' 환경과 '다중 사용자' 환경 모두에서 기본적인 '시스템 실행 파일' 과 '관리 도구' 들을 저장하는 디렉토리입니다.

macOS 에서는 **ping**, **ifconfig** 와 같은 실행 파일들이 여기에 존재합니다.

#### `/tmp` : 임시 파일 디렉토리

앱이나 시스템에서 생성한 임시 파일들을 저장하는 디렉토리입니다.

> macOS 에서 `/tmp` 디렉토리는 실제로는 `/private/tmp` 디렉토리의 '심볼릭 링크 (symbolic link)' 입니다. 즉, `/tmp/Developer` 디렉토리는 `/private/tmp/Developer` 디렉토리와 같은 곳입니다.
>
> `/private` 디렉토리에 대해서는 아래의 [`/private` : 개인 사용자 디렉토리](#private--개인-사용자-디렉토리) 에서 따로 설명하도록 합니다.

#### `/usr` : 사용자 디렉토리

필수적이지는 않은 대부분의 '사용자 정의 실행 파일', '사용자 정의 도구', 라이브러리, 헤더 파일, 및 기타 자료들을 저장하는 디렉토리입니다.

`/usr` 디렉토리의 하위 디렉토리에는 다음과 같은 것들이 있습니다.

* **/usr/bin** : 공통된 도구, 프로그래밍 도구, 응용 프로그램들을 저장하는 곳입니다.
* **/usr/lib** : 라이브러리를 보관하고 있는 곳입니다.
* **/usr/libexec** : (다른 프로그램에서 실행되는) '시스템 데몬 (system daemons) 및 '시스템 도구 (system utilities)' 를 저장하는 곳입니다.
* **/usr/local** : 운영 체제에 기본으로 포함되지 않는 '실행 파일' 이나 라이브러리 등을 저장하는 곳입니다.
* **/usr/sbin** : (사용자에 의해 실행되는) '시스템 데몬 (system daemons) 및 '시스템 도구 (system utilities)' 를 저장하는 곳입니다.

#### `/var` : 변경 파일 디렉토리

'로그 (log) 파일' 이나 '변수 값' 을 가진 파일과 같이, 운영 체제 사용 중에 자주 생성되고 삭제되는 데이터를 일시적으로 저장하는 디렉토리 입니다.

`/var` 디렉토리의 하위 디렉토리에는 다음과 같은 것들이 있습니다.

* **/var/backups** : 잡다한 백업 파일들을 저장하는 곳입니다.
* **/var/log** : 시스템 로그 파일들을 저장하는 곳입니다.
* **/var/tmp** : 운영 체제 재부팅 중에 사용되는 임시 파일들을 저장하는 곳입니다.

> macOS 에서 `/var` 디렉토리는 실제로는 `/private/var` 디렉토리의 '심볼릭 링크 (symbolic link)' 입니다. 즉, `/var/log` 디렉토리는 `/private/var/log` 디렉토리와 같은 곳입니다.
>
> `/private` 디렉토리에 대해서는 다음의 [`/private` : 개인 사용자 디렉토리](#private--개인-사용자-디렉토리) 에서 설명합니다.

#### `/private` : 개인 사용자 디렉토리

앞서 macOS 의 `/etc`, `/tmp`, `/var` 디렉토리는 각각 실제로 `/private` 디렉토리 내의 하위 디렉토리들의 '심볼릭 링크 (symbolic link)' 라고 했습니다. '심볼릭 링크' 는, 아래와 같이 `ls -l` 명령을 사용했을 때 화살표 (`->`) 표시가 나타나는 것으로 확인할 수 있습니다.

```sh
$ ls -l
lrwxr-xr-x@  1 root  admin    11 Oct  9  2019 etc -> private/etc
...
```

'심볼릭 링크' 는 'GUI' 관점에서는 하나의 '바로 가기' 라고 이해할 수 있으며, 이는 곧 `/etc` 디렉토리의 내용을 수정하는 것은 `/private/etc` 디렉토리의 내용을 수정하는 것과 완전히 동일함을 의미합니다.

macOS 에서 `/private` 디렉토리를 사용하게 된 것은, 현 macOS 의 전신인 **NeXTSTEP** 에서부터 시작되었습니다. 예전에는 컴퓨터의 저장 공간이 부족해서 운영 체제 정보를 네트워크에 분산하기도 했는데, 그 기기에만 해당하는 정보는 `/private` 디렉토리에 저장했다고 합니다.[^private] 이런 과정을 거쳐서 현재의 macOS 에도 `/private` 디렉토리가 남게 된 것으로 추정할 수 있습니다.

### `~` : macOS 의 홈 디렉토리

'홈 (home) 디렉토리' 는 '다중 사용자' 환경에 대한 사용자 파일을 저장하고 관리하는 디렉토리를 말합니다. 여기서 '다중 사용자 환경' 이라는 것은 로그인한 사용자마다 별도의 홈 디렉토리가 생긴다는 것을 의미합니다.

macOS 의 **Terminal** 에서 '홈 디렉토리' 로 이동하려면 아래와 같은 명령을 사용합니다.

```
$ cd ~
```

macOS 에서는 물결 (`~`) 기호가 '홈 디렉토리' 를 의미하며, 어느 디렉토리에서든 위와 같이 하면 '홈 디렉토리' 로 이동합니다.

단, macOS 는 '홈 디렉토리' 로 '유닉스-고유 디렉토리' 인 `/home` 을 사용하지 않고, '표준 디렉토리' 중 하나인 `/Users` 하위의 `/Users/username` 디렉토리를 사용합니다.

이와 같이, `/Users/username` 디렉토리를 '홈 디렉토리' 로 사용하는 이유는, macOS 에서 유닉스 파일 시스템을 도입하기 이전인, **Mac OS 9** 시절부터 이미 `/Users/username` 디렉토리를 사용하고 있었기 때문이라고 합니다.[^macOS-home] 이것은 기존 '맥 운영 체제' 와 '유닉스' 의 서로 다른 파일 시스템을 절충한 것으로 볼 수 있을 것 같습니다.

> 사실 이것이 이 문서를 작성하게 된 동기입니다. macOS 를 사용하다보면 '표준 디렉토리 (standard directories)' 와 '유닉스-고유 디렉토리 (UNIX-specific directories)' 의 개념이 혼동될 때가 있는데 이 개념을 이해하고 정리하고자 이 문서를 작성하게 된 것입니다.

**Terminal** 에서 홈 디렉토리로 이동할 때는, 아래 처럼 '환경 설정 변수' 를 사용할 수도 있습니다.

```
$ cd $HOME
```

이것은, `$HOME` 이라는 '환경 설정 변수' 에 설정된 곳으로 이동하라는 것을 의미하는데, 이 값이 `/Users/username` 이기 때문입니다. `$HOME` 환경 설정 변수를 확인하려면 **Terminal** 에서 다음과 같이 하면 됩니다.[^GUI-environment]

```
$ echo $HOME
/Users/username
```

### 참고 자료

[^standard-directories]: macOS 의 '표준 디렉토리 (Standard Directories)' 에 대해서는 [File System Basics](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW2) 문서의 [macOS Standard Directories: Where Files Reside](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW6) 부분에서 설명하고 있습니다.

[^UNIX-specific-directories]: macOS 의 '유닉스-고유 디렉토리 (UNIX-specific directories)' 에 대해서는 [File System Basics](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW2) 문서의 [Hidden Files and Directories: Simplifying the User Experience](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW7) 부분에서 설명하고 있습니다.

[^finder]: macOS 의 '표준 디렉토리' 와 '유닉스-고유 디렉토리' 의 차이점에 대해서는 [macOS: 파일 시스템의 기본 디렉토리 구조]({% post_url 2020-04-20-macOS-File-System-Layout %}) 문서를 보도록 합니다.

[^man-hier]: 파일 내용이 길 경우 `$ man hier > hier.txt` 와 같이 파일로 옮겨서 따로 확인할 수도 있습니다.

[^standard-os-x]: 여기서 따로 설명하지 않은 `/boot` 등의 디렉토리에 대한 설명은 [What is standard for OS X filesystem? e.g. /opt/ vs. /usr/](https://apple.stackexchange.com/questions/119230/what-is-standard-for-os-x-filesystem-e-g-opt-vs-usr) 라는 글을 보도록 합니다.

[^directory-separator]: 예전에는 macOS 에서 '디렉토리 구분자' 로 콜론 (`:`) 기호를 사용했으며 그래서 예전 자료를 보다 보면 디렉토리를 구분할 때 콜론 (`:`) 을 사용하는 것을 볼 수가 있습니다. 지금은 macOS 에서 '디렉토리 구분자' 는 '빗금 기호 (slash)' 로 완전히 통일되었습니다. '콜론 (`:`) 디렉토리 구분자' 에 대해서는 [When did the colon character : become an allowed character in the filesystem?](https://apple.stackexchange.com/questions/173529/when-did-the-colon-character-become-an-allowed-character-in-the-filesystem) 라는 글을 보도록 합니다.

[^cores]: `/cores` 디렉토리에 대한 더 자세한 정보는 [OS X El-Capitan - /cores directory taking up a lot of space?](https://apple.stackexchange.com/questions/215410/os-x-el-capitan-cores-directory-taking-up-a-lot-of-space) 라는 글을 보도록 합니다.

[^profile]: macOS Catalina 에서부터 기본 쉘이 'bash (배쉬)' 에서 'zsh (z-쉘)' 로 변경되었습니다. 'zsh' 의 기본 설정 파일은 `zprofile` 인데, 이 파일 역시 `/etc` 디렉토리에 있습니다. 직접 `sh` 을 사용하지 않는다면 `profile` 대신, `zprofile` 을 사용할 것입니다.

[^paths]: [wisseraph](http://elfinlas.tistory.com) 님의 [Mac에서 Path 설정하기](http://elfinlas.tistory.com/266) 글에 따르면 `/etc/paths` 는 macOS 에서 가장 기본적인 경로를 설정하는 파일이라고 합니다.

[^symbolic-link]: macOS 에서 특정 디렉토리가 '심볼릭 링크 (symbolic link)' 인지를 확인하는 방법은 [How to know if a folder is a symbolic link?](https://askubuntu.com/questions/1145925/how-to-know-if-a-folder-is-a-symbolic-link) 를 보도록 합니다.

[^firmlink]: 둘 중 어느 것이 정확한 것인지는 아직 찾지 못했지만, 다른 자료들을 보면 '고정 링크 (firmlink)' 로 설명하지는 않아서 '심볼릭 링크 (symbolic link)' 라고 추측하고 있습니다. 애플 **WWDC19** 에서 공개한 [What's New in Apple File Systems](https://developer.apple.com/videos/play/wwdc2019/710/) 영상을 보면 이 두 가지는 서로 비슷하다고 합니다.

[^APFS-boot-directory]: `/Symbolic/Volumes/Data` 디렉토리에 대한 더 자세한 내용은 [What's /System/Volumes/Data?](https://apple.stackexchange.com/questions/367158/whats-system-volumes-data) 및 [macOS Catalina Boot Volume Layout](https://eclecticlight.co/2019/10/08/macos-catalina-boot-volume-layout/) 를 보도록 합니다.

[^private]: 해당 내용에 대한 더 자세한 정보는 [What is the private folder on a Mac computer?](https://www.quora.com/What-is-the-private-folder-on-a-Mac-computer) 를 보도록 합니다.

[^macOS-home]: macOS 에서 `/Users/username` 을 '홈 디렉토리' 로 사용하는 이유에 대한 더 자세한 정보는 [Why are home folders in Mac OS X located in /Users, and not /home?](https://apple.stackexchange.com/questions/50633/why-are-home-folders-in-mac-os-x-located-in-users-and-not-home) 를 보도록 합니다. 해당 글을 보면 유닉스에서 `/home` 디렉토리를 '홈 디렉토리' 로 사용하는 것은 기본 설정이지 필수 사항은 아니기 때문에, '유닉스-고유 디렉토리' 구조에서 홈 디렉토리를 `/Users/username` 로 설정하는 것에는 아무런 문제가 없다고 합니다.

[^GUI-environment]: 'GUI' 에서도 `$HOME` 환경 설정 변수를 확인할 수 있는데, 이 방법에 대한 더 자세한 정보는 [Where do I find my user folder in the OS X folder hierarchy?](https://apple.stackexchange.com/questions/51280/where-do-i-find-my-user-folder-in-the-os-x-folder-hierarchy) 를 보도록 합니다.
