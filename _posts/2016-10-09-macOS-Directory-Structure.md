---
layout: post
pagination: 
  enabled: true
comments: true
title:  "macOS: 맥의 기본 디렉토리 구조 살펴보기"
date:   2016-10-09 02:50:00 +0900
categories: macOS File-System Directory
redirect_from:
  - /macos/file/system/directory/2016/10/08/macOS-Directory-Structure.html
---

> 이 글은 macOS 의 파일 시스템 중에서 디렉토리 (directory)[^directory-and-folder] 구조에 대한 내용을 정리한 글입니다.

### macOS 의 디렉토리 구조

macOS 는 하이 시에라 (High Sierra)' 부터 [APFS (Apple File System)](https://en.wikipedia.org/wiki/Apple_File_System) 라는 파일 시스템을 도입했습니다. 이로써, macOS 의 파일 시스템은 많은 변모를 하게 되었으며, iOS 등과의 연동성도 좋아지게 되었습니다. 하지만, 파일 시스템에서 사용하는 '기본 디렉토리 구조' 는 크게 변하지 않았습니다. 이는 아마도 기존 시스템 및 사용자와의 호환성을 염두에 두었을 것입니다.

일반적으로 macOS 를 사용하다 보면, 많은 경우 디렉토리를 의식하지 않고 사용하게 됩니다. 예를 들어, 어떤 프로그램을 설치할 경우 대부분의 사용자는 프로그램이 설치되는 위치를 변경하지 않을 것입니다. 그러다 보니 해당 프로그램이 어디에 설치되는지, 어떻게 동작하는지 잘 모르고 사용하는 경우가 많습니다.

하지만 macOS 를 좀 더 잘 사용하기 위해서는, 결국 더 밑부분, 그 중에서도 macOS 의 디렉토리 구조에 대해서 알아둘 필요가 있습니다. 이를 위해, 여기서는 APFS (애플 파일 시스템) 에서 사용하는 기본 디렉토리 구조에 대한 내용을 정리하였습니다.

#### macOS 파일 시스템의 기본 디렉토리

해당 내용은 [macOS: 파일 시스템의 기본 디렉토리 구조]({% post_url 2020-04-20-macOS-File-System-Layout %}) 문서에 별도로 정리하였습니다.

#### macOS: 파일 시스템의 유닉스-고유 디렉토리

해당 내용은 [macOS: 파일 시스템의 기본 디렉토리 구조]({% post_url 2020-04-29-macOS-UNIX-specific-Directories %}) 문서에 별도로 정리하였습니다.

### 참고 자료

[^directory-and-folder]: 맥을 사용하다보면 '폴더 (folder)' 와 '디렉토리 (directory)' 를 혼용해서 쓸 때가 많습니다. 실제로 이 둘은 거의 같은 의미를 가지고 있긴 합니다. 다만 [Difference between ‘“folder” and “directory”](https://english.stackexchange.com/questions/113606/difference-between-folder-and-directory) 라는 글을 보면, '폴더 (folder)' 는 'GUI 객체' 를 나타내는 논리적인 개념에서 나온 것이고, '디렉토리 (directory)' 는 '파일 시스템 (file system) 의 객체' 에서 나온 개념입니다. 따라서 [GUI](https://en.wikipedia.org/wiki/Graphical_user_interface) 에서는 '폴더 (folder)' 라는 말을, [CLI](https://en.wikipedia.org/wiki/Command-line_interface) 에서는 디렉토리라는 말을 사용하는 것이 일반적입니다.  
