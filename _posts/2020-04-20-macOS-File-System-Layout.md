---
layout: post
pagination:
  enabled: true
comments: true
title:  "macOS: 파일 시스템 (APFS) 의 기본 디렉토리 구조"
date:   2020-04-20 10:00:00 +0900
categories: macOS File-System Directory
---

> 이 글은 macOS 의 파일 시스템에 있는 기본 디렉토리 (directory)[^directory-and-folder] 들을 정리한 글입니다. 이를 통해 macOS 에서 사용하는 각각의 설정 파일들이 어떤 디렉토리에 위치하게 되는지 이해할 수 있습니다.

## macOS 파일 시스템의 기본 디렉토리

macOS 파일 시스템의 기본 디렉토리들을 확인하려면, 다음과 같이 **Terminal** (터미널) 에서 'root 디렉토리' 로 이동[^move-to-root-directory]하여 `ls` 명령을 실행하면 됩니다.

```sh
$ cd /
$ ls -l
```

그러면 아래와 같이 최상단에 위치한 디렉토리들을 볼 수 있습니다.[^tree]

```sh
├── Applications
├── Library
├── Preboot
├── System
├── Users
├── Volumes
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

위의 결과를 보면 macOS 최상단 디렉토리는 이름이 대문자로 시작하는 것과, 소문자로 시작하는 것으로 구분된다는 것을 알 수 있습니다. macOS 에서 이렇게 대문자로 시작하는 디렉토리들은 '표준 디렉토리 (standard directories)' 라고 하며, 소문자로 시작하는 디렉토리들은 '유닉스-고유 디렉토리 (UNIX-specific directories)' 라고 합니다.

### macOS 의 표준 디렉토리

앞서 말한 바와 같이, 대문자로 시작하는 디렉토리들은 '표준 디렉토리 (Standard Directories)'[^standard-directories] 라고 하며, 이들은 아래와 같이 **Finder** (파인더) 에서도 확인할 수 있습니다.

![macOS standard directories](/assets/macOS/File-System/standard-directories.jpg)

이 디렉토리는 **maxOS X** 가 제공하는 앱이나 사용자가 설치한 앱, 그 외 프로그램을 사용하면서 생성한 파일들을 저장하는 곳입니다. 맥 사용자라면 아주 친숙한 폴더들입니다.

> 각각의 디렉토리에 대한 더 자세한 설명은 [macOS Standard Directories: Where Files Reside](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW6) 문서에서 확인할 수 있습니다.

### macOS 의 유닉스-고유 디렉토리

반면, 소문자로 시작하는 디렉토리들은 '유닉스-고유 디렉토리 (UNIX-specific directories)' 라고 하며, 이들은 '숨겨진 시스템 폴더 (hidden system folder)'[^hidden-folder] 이기 때문에, 기본적으로 **Finder** 에서 확인할 수 없습니다.[^finder]

이름에서 알 수 있듯이, 이 디렉토리들은 유닉스 (UNIX) 파일 시스템에서 유래한 것으로, macOS 의 기반인 '**BSD** (Berkeley Software Distribution) 계층' 을 담당합니다. 유닉스 파일 시스템에서 유래한 것이다 보니 디렉토리 이름이 소문자로 시작할 뿐만 아니라 ASCII 문자로 8자 이내로 되어 있습니다.

개발 과정에서 수정하는 설정 파일들은 바로 이 '유닉스-고유 디렉토리' 에 위치하게 됩니다. 각 디렉토리에 대해 간단한 설명은 다음과 같습니다.[^UNIX-specific-directories]

* **/bin** — 필수적인 '명령줄 (command-line)' '실행 파일 (binaries)' 을 담고 있는 곳입니다. 보통 '명령줄' 에서 이 실행 파일 이름을 쳐서 실행하게 됩니다.
* **/dev** — '보조 하드웨어 장비' 와 같은 필수적인 '장치 파일 (device files)' 을 담고 있는 곳입니다.
* **/etc** — 사용자 고유의 설정 파일을 담는 곳입니다.
* **/sbin** — 필수적인 시스템 실행 파일을 담고 있는 곳입니다.
* **/tmp** — 앱이나 시스템에서 생성한 임시 파일들을 담는 곳입니다.
* **/usr** — 필수적이지는 않은 '명령줄 실행 파일' 이나 라이브러리, 헤더 파일, 그리고 기타 자료들을 담는 곳입니다.
* **/var** — 'log (로그)' 파일 및 '변수 값' 을 가지고 있는 파일들을 담는 곳입니다.

maxOS 의 '유닉스-고유 디렉토리' 에 대해서는 [macOS: 파일 시스템의 유닉스-고유 디렉토리 알아보기]({% post_url 2020-04-29-macOS-UNIX-specific-Directories %}) 에서 좀 더 자세히 다루도록 하겠습니다.

### 참고 자료

[^directory-and-folder]: 맥을 사용하다보면 '폴더 (folder)' 와 '디렉토리 (directory)' 를 혼용해서 쓸 때가 많습니다. 실제로 이 둘은 거의 같은 의미를 가지고 있긴 합니다. 다만 [Difference between ‘“folder” and “directory”](https://english.stackexchange.com/questions/113606/difference-between-folder-and-directory) 라는 글을 보면, '폴더 (folder)' 는 'GUI 객체' 를 나타내는 논리적인 개념에서 나온 것이고, '디렉토리 (directory)' 는 '파일 시스템 (file system) 의 객체' 에서 나온 개념입니다. 따라서 [GUI](https://en.wikipedia.org/wiki/Graphical_user_interface) 에서는 '폴더 (folder)' 라는 말을, [CLI](https://en.wikipedia.org/wiki/Command-line_interface) 에서는 디렉토리라는 말을 사용하는 것이 일반적입니다.  

[^move-to-root-directory]: 터미널을 처음 실행하면 '홈 디렉토리 (home directory)' 에 위치하게 됩니다. '홈 디렉토리' 는 macOS 의 최상단 디렉토리가 아닙니다. 그러므로 macOS 의 전체 계층 구조를 확인하려면 '루트 디렉토리' 로 이동해야 합니다.

[^tree]: 단 여기서의 결과는 `ls` 이 아니라, `tree` 명령을 설치해서 사용한 것입니다. '디렉토리 구조' 를 잘 보이기 위해서 그렇게 한 것이며, '디렉토리' 내용은 동일합니다.

[^standard-directories]: macOS 의 '표준 디렉토리 (Standard Directories)' 에 대해서는 [File System Basics](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW2) 문서의 [macOS Standard Directories: Where Files Reside](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW6) 부분에서 설명하고 있습니다.

[^hidden-folder]: 여기서 '숨겨졌다' 는 의미는 **Finder** 를 기준으로 한 것으로, **Terminal** 에서는 확인 가능합니다.

[^finder]: 애플의 공식 문서 인 [File System Basics](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW2) 에 따르면 사용자 경험을 간소화하기 위해, 사용자가 알 필요가 없는 파일이나 디렉토리는 **Finder** 등의 몇몇 사용자 인터페이스에서 숨겨진다고 합니다. 물론 **Finder** 를 실행 한 후, `command` + `shift` + `G` 메뉴를 사용하면, '숨겨진 시스템 폴더' 로 이동할 수는 있습니다. **Finder** 에서 보이지 않는다는 것이지 사용할 수 없는 것은 아니라고 볼 수 있습니다.

[^UNIX-specific-directories]: macOS 의 '유닉스-고유 디렉토리 (UNIX-specific directories)' 에 대해서는 [File System Basics](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW2) 문서의 [Hidden Files and Directories: Simplifying the User Experience](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW7) 부분에서 설명하고 있습니다.
