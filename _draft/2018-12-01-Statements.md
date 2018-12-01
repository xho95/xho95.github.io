---
layout: post
comments: true
title:  "Swift 4.2: 구문 (Statements)"
date:   2018-12-01 19:35:00 +0900
categories: Xcode Swift Grammar Statements
---

스위프트에는 세가지 종류의 구문이 있습니다: 단순 구문, 컴파일러 제어 구문, 그리고 제어 흐름 구문이 그 것입니다. 단순 구문은 가장 일반적이며 표현식 또는 선언문으로 구성됩니다. 컴파일러 제어 구문은 프로그램이 컴파일러의 행동 관점을 변화시키도록 하며 조건 컴파일 블록과 줄 제어 구문을 포함합니다.

제어 흐름 구문은 프로그에서 실행 흐름을 제어하는데 사용됩니다. 스위프트에는 여러 종류의 제어 흐름 구문이 있는데, 반복(loop) 구문, 분기 (branch) 구문, 그리고 제어 이동 구문이 그것입니다. 반복 구문은 코드 블록이 반복해서 실행되도록 하고, 분기 구문은 특정 코드 블럭이 특정 조건을 만족할 때만 실행되도록 하며, 제어 이동 구문은 어떤 코드가 실행될지의 순서를 바꾸는 방법을 제공합니다. 여기에 더해서, 스위프트는 `do` 구문을 제공하여 범위를 지정하고, 에러를 잡아내거나 처리하고, `defer` 구문을 제공하여 현재 범위를 벗어날 때 작업 마무리를 할 수 있도록합니다.

```swift
더 있지만 나중에 추가함
```
### 컴파일 시간 진단 구문

컴파일 시간 진단 구문은 컴파일러가 컴파일 중에 에러나 경고를 발생하도록 합니다. 컴파일 시간 진단 구문은 아래와 같은 형식입니다:

```swift
#error("error message")
#warning("warning message")’
```

첫번째 형식은 에러 메시지를 치명적 에러로 발생하며 컴파일 과정을 종료합니다. 두번째 형식은 경고 메시지를 비치명적 경고로 발생하며 컴파일을 진행하도록 합니다.

> GRAMMAR OF A COMPILE-TIME DIAGNOSTIC STATEMENT
>
> diagnostic-statement → #error ( diagnostic-message )
> diagnostic-statement → #warning ( diagnostic-message )
> diagnostic-message → static-string-literal

### 고찰 하기


### 참고 자료

[Statements]: [The Swift Programming Language (Swift 4.2).](https://itunes.apple.com/kr/book/the-swift-programming-language-swift-4-2/id881256329?mt=11) 링크 수정 필요
