---
layout: post
comments: true
title:  "macOS: 파일 시스템의 계층 구조 알아보기"
date:   2020-04-20 10:00:00 +0900
categories: macOS File System Directory
---

> 이 글은 macOS 에서 사용하는 파일 시스템의 계층 구조를 정리한 것입니다.
>
> 이는 macOS 에서 개발을 하면서 각 설정 파일들이 어떤 '디렉토리 (directory)'[^directory-and-folder]에 어떤 목적으로 위치하는지 이해하기 위함입니다.

## macOS 의 기본 파일 시스템 구조

macOS 에서 사용하는 파일 시스템의 기본 구조를 확인하려면, 다음과 같이 터미널에서 '루트 디렉토리 (root directory)' 로 이동[^move-to-root-directory]한 후 `ls` 명령을 사용하면 됩니다.

```sh
$ cd /
$ ls
```

그러면 아래와 같은 '디렉토리 (directory)' 들을 확인할 수 있습니다.

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

위의 디렉토리를 보면 이름이 대문자로 시작하는 것이 있고, 소문자를 시작하는 것이 있습니다.

대문자로 시작하는 것은 macOS 에서 '표준 디렉토리 (Standard Directories)'[^standard-directories] 라고 하는 것으로, **maxOS X** 를 사용하는 사용자가 응용 프로그램을 설치하거나 파일을 만들게 되면 위치하는 곳입니다. 이들은 아래와 같이 **Finder** 프로그램을 통해 확인할 수 있습니다.

![macOS standard directories](/assets/macOS/Directory/standard-directories.jpg)

반면, 소문자로 시작하는 '디렉토리' 들은 '숨겨진 시스템 폴더 (hidden system folder)'[^hidden-folder] 이며, 기본적으로 macOS 의 'Finder' 에서 확인할 수 없도록 되어 있습니다.[^finder]

하지만 이 '숨겨진 시스템 폴더' 에 해당하는 '디렉토리' 들이 실제 개발 과정에서 설정하는 파일들이 존재하는 곳이며, 이 글에서 다루게 될 위치입니다.

이 기본 디렉토리들에 대한 설명은, 아래와 같이 터미널에서 `man` 명령을 사용하면 확인 할 수 있습니다.

```sh
$ man hier
```

### macOS 의 파일 및 폴더 권한 정리하기

**macOS 디렉토리**

macOS 에서는 `/home` 디렉토리 대신 `/Users` 디렉토리를 사용한다고 합니다. [What is standard for OS X filesystem? e.g. /opt/ vs. /usr/](https://apple.stackexchange.com/questions/119230/what-is-standard-for-os-x-filesystem-e-g-opt-vs-usr) 글에는 `man hier` 도 설명합니다. 해당 명령을 통해서 macOS 의 기반이 되는 BSD 의 filesystem 에 대한 layout 을 확인할 수 있습니다.

### /cores directory

`/cores` 디렉토리에 대한 설명은 [OS X El-Capitan - /cores directory taking up a lot of space?](https://apple.stackexchange.com/questions/215410/os-x-el-capitan-cores-directory-taking-up-a-lot-of-space) 글에 잘 되어 있습니다.


### File Sytem Programming Guide

[File System Programming Guide - Apple Developer](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/Introduction/Introduction.html)



### 참고 자료

[^directory-and-folder]: 맥을 사용하다보면 '폴더 (folder)' 와 '디렉토리 (directory)' 를 혼용해서 쓸 때가 많습니다. 실제로 이 둘은 거의 같은 의미를 가지고 있긴 합니다. 다만 [Difference between ‘“folder” and “directory”](https://english.stackexchange.com/questions/113606/difference-between-folder-and-directory) 라는 글을 보면, '폴더 (folder)' 는 'GUI 객체' 를 나타내는 논리적인 개념에서 나온 것이고, '디렉토리 (directory)' 는 '파일 시스템 (file system) 의 객체' 에서 나온 개념입니다. 따라서 [GUI](https://en.wikipedia.org/wiki/Graphical_user_interface) 에서는 '폴더 (folder)' 라는 말을, [CLI](https://en.wikipedia.org/wiki/Command-line_interface) 에서는 디렉토리라는 말을 사용하는 것이 일반적입니다.  

[^move-to-root-directory]: 터미널을 처음 실행하면 '홈 디렉토리 (home directory)' 에 위치하게 됩니다. '홈 디렉토리' 는 macOS 의 최상위 디렉토리가 아닙니다. 그러므로 macOS 의 전체 계층 구조를 확인하려면 '루트 디렉토리' 로 이동해야 합니다.

[^standard-directories]: macOS 의 '표준 디렉토리 (Standard Directories)' 는 [File System Basics](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW2) 문서의 [macOS Standard Directories: Where Files Reside](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html#//apple_ref/doc/uid/TP40010672-CH2-SW6) 부분에 잘 설명되어 있습니다.

[^hidden-folder]: 여기서 '숨겨진 시스템 폴더' 라는 말을 사용했는데, 이는 이들 '디렉토리' 들이 'CLI' 기준으로는 '숨겨진 디렉토리' 가 아니지만, 'GUI' 기준으로는 '숨겨진 폴더' 가 된다는 말입니다. 여기서도 '디렉토리' 와 '폴더' 가 완전히 같은 개념은 아니라는 것을 확인할 수 있습니다.

[^finder]: 물론 'Finder' 를 실행 한 후, `command` + `shift` + `G` 메뉴를 통해서 '숨겨진 시스템 폴더' 로도 이동할 수 있긴 합니다.
