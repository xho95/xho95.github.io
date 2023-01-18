---
layout: post
pagination:
  enabled: true
comments: true
title:  "macOS: 특수 문자 입력창에서 유니코드 문자 검색해서 입력하기"
date:   2016-10-08 03:15:00 +0900
categories: macOS Tips Unicode Characters
redirect_from: "/macos/tips/unicode/characters/2016/10/07/macOS-Special-Character.html"
---

맥의 경우 `command (⌘)`+`control(⌃)`+`space` 키를 누르면 특수 문자를 입력할 수 있는 대화창이 나타납니다.[^macnews-1723]  [^macnews-1439]

이 특수 문자 입력창을 이용하면 어떤 유니코드 문자라도 찾아서 입력할 수 있습니다.

다만 원하는 문자를 찾는 과정이 그렇게 쉽지는 않습니다. 특히 프로그래밍을 하다보면 유니코드(unicode) 값 자체는 아는데 해당 문자를 찾기가 힘들어서 입력이 힘든 경우가 있습니다.

이 경우 대화창의 검색 필드를 이용하면 쉽게 유니코드 문자를 찾아서 입력할 수있습니다. 그냥 검색창에서 유니코드 값을 hex 코드의 형태로 입력해서 검색하면 됩니다. hex 코드를 입력하는 방법은 코드 맨 앞에 `0x`를 붙여주기만 하면 됩니다.

참고로 `é` 문자의 hex 코드는 다음과 같습니다.

```
é == 0xe9 == 0xE9
```

> 참고로 특수 문자 입력창에서 유니코드는 알파벳의 대소문자를 구분하지 않고 인식이 되는 것 같습니다.

[Unicode® character table](http://unicode-table.com/en/) 등을 찾아보면 원하는 문자의 유니코드 값을 찾아볼 수도 있습니다.[^unicode-table]

특수 문자 입력 대화창에서 `0xe9`를 입력해서 검색한 결과는 다음과 같습니다.

![맥 특수 문자 입력기](/assets/macOS/special-character.jpg)

검색창에 `0xe9`라 입력하면 각각의 문자도 검색되지만 맨 밑에 해당 문자 코드로 만들 수 있는 글자인 `é`도 같이 검색되는 것을 알 수 있습니다.

이제 `é`를 더블클릭하면 원하는 곳에 문자를 넣을 수 있습니다.

### 참고 자료

[^macnews-1723]: [OS X 매버릭스의 새로운 이모티콘•특수문자 입력 방법 마스터하기](http://macnews.tistory.com/1723) : 국내 맥관련 블로그 중에서 최고라고 불리우는 Back to the Mac 블로그입니다. 맥에서 특수 문자를 입력하는 방법에 대한 모든 정보를 담고 있습니다.

[^macnews-1439]: [맥에서 특수 문자를 입력하는 모든 방법... '하지만 더 편리한 방법이 있다면?'](http://macnews.tistory.com/1439) : 특수 문자 입력을 영문 입력기 상태에서 더욱 편리하게 할 수 있는 방법에 대해서 소개하고 있습니다.

[^unicode-table]: [Unicode® character table](http://unicode-table.com/en/) : 전체 유니 코드 문자를 테이블 방식으로 정리한 곳입니다. 원하는 문자의 유니코드 값을 알 수 있습니다.
