---
layout: post
comments: true
title:  "Swift 3.1: 언어의 기호가 가리키는 것에 대하여 (About the Language Reference)"
date:   2017-03-13 11:30:00 +0900
categories: Swift Language Grammar About Reference
---

> 이 글은 Swift 를 공부하기 위해 애플에서 공개한 [The Swift Programming Language (Swift 3.1)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/) 책의 [About the Language Reference](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/AboutTheLanguageReference.html#//apple_ref/doc/uid/TP40014097-CH29-ID345) 부분을 번역하고 주석을 달아서 정리한 글입니다. 현재는 Swift 3.1 버전에 대해서 정리되어 있습니다.

## 언어의 기호가 가리키는 것에 대하여 (About the Language Reference)

[^reference] 이 책의 여기서부터는 스위프트 (Swift) 프로그래밍 언어의 공식 문법을 설명하도록 합니다. 문법을 설명하는 것은 언어를 좀 더 자세히 이해하도록 돕기 위한 것이지 구문 해석기 (parser) 나 컴파일러를 직접 만들 수 있도록 하기 위한 것은 아닙니다.

스위프트 언어는 다른 언어들보다 꽤 단순한데, 이는 모든 스위프트 코드에서 볼 수 있는 여러 공통 타입, 함수, 그리고 연산자들이 실제로는 스위프트 표준 라이브러리에서 정의되기 때문입니다. 비록 이들 타입, 함수, 그리고 연산자들이 스위프트 언어의 일부는 아니지만 여기서는 이들을 다루는 광범위한 논의와 코드 예제를 볼 수 있습니다.

### 문법을 읽는 방법 (How to Read the Grammar)

스위프트 프로그래밍 언어의 공식 문법을 나타내는 표기법은 몇 가지 규칙을 따릅니다:

* 화살표 (→) 는 문법 생성 방법을 표시하며 “로 이루어질 수 있음” 으로 이해할 수 있습니다.
* 문장 구조 (Syntactic) 범주는 이탤릭 체로 표시하며 문법 생성 규칙의 양쪽 모두에 나타날 수 있습니다.
* 리터럴 단어와 마침표는 굵은 글씨에 `상수 폭`글자로 표시하며 문법 생성 규칙의 오른쪽에만 나타납니다.
* 문법 생성 방법에 대안이 있는 경우 세로 막대 (\|) 로 구분합니다. 대안 방법이 너무 길어서 쉽게 읽기 어려울 때는 여러 문법 생성 규칙들을 새로운 줄로 나눠서 나타내도록 합니다.
* 몇몇 경우에는 일반 글꼴 글자를 사용해서 문법 생성 규칙의 오른쪽임을 나타냅니다. [^regular]
* 문장 구조 범주와 리터럴이 선택 요소일 경우에는 마지막에 첨자로 <sub>­opt­</sub> 를 붙여줍니다. [^optional]

예를 들어서 getter-setter 블럭은 다음과 같은 문법으로 정의합니다:

> GETTER-SETTER 블럭의 문법
> 
> _getter-setter-블럭_ → {­ getter-구절 ­setter-구절 <sub>­opt­</sub>­­ }­ \| { ­setter-구절 ­getter-구절 }­

이 정의는 getter-setter 블럭을 구성하려면 getter 구절 다음에 선택 사항으로 setter 구절을 넣고 중괄호로 감싸거나 아니면 setter 구절 다음에 getter 구절을 넣고 중괄호를 감싸면 되는 것을 나타냅니다. 위에 있는 문법 생성 방법은 아래에 있는 두 개의 문법 생성 방법과 동등한 것으로 여기서는 대안 방법을 따로 떼어내어 직접 나타냈습니다.

> GETTER-SETTER 블럭의 문법
> 
> _getter-setter-블럭_ → { ­getter-구절 setter-구절 <sub>­opt­</sub>­ }  
> _getter-setter-블럭_ → {­ setter-구절 ­getter-구절 }­

### 원문 자료

* [About the Language Reference](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/AboutTheLanguageReference.html#//apple_ref/doc/uid/TP40014097-CH29-ID345) : [The Swift Programming Language (Swift 3.1)](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/) 자료입니다.

### 관련 자료

* [Swift: 리눅스에서 Swift 개발 환경 구축하기](http://xho95.github.io/linux/development/swift/package/install/2017/02/19/Developing-Swift-on-Linux.html)

* [Swift 3.1: 빠르게 둘러보기 (A Swift Tour)](http://xho95.github.io/swift/language/grammar/tour/2016/04/17/A-Swift-Tour.html)
* [Swift 3.1: 기초 (The Basics)](http://xho95.github.io/swift/language/grammar/basic/2016/04/24/The-Basics.html)

### 참고 자료

[^reference]: 'reference'는 보통 '참조'라고 옮기지만, 여기서는 [언어의 지시 대상과 내재적 의미](https://books.google.co.kr/books?id=c_PYBAAAQBAJ&pg=PT34&lpg=PT34&dq=Language+Reference+뜻&source=bl&ots=mZtvCKTqYL&sig=06F6Krrmt6yA7jDFYQ-mNgb3loQ&hl=en&sa=X&redir_esc=y#v=onepage&q=Language%20Reference%20뜻&f=false) 라는 글을 참고해서 '기호가 가리키는 것'으로 옮깁니다. 원래의 '가리키다'라는 의미는 유지되는 것 같습니다.

[^regular]: 이 부분은 좀 더 깊은 의미가 있는 것 같습니다. 나중에 더 이해하게 되면 새로 옮겨야할 것 같습니다.

[^optional]: 여기서의 'optional'은 '옵셔널' 타입과는 상관없는 단어입니다.