---
layout: post
comments: true
title:  "Swift 5.3: About the Language Reference (언어의 기준에 대하여)"
date:   2017-03-13 11:30:00 +0900
categories: Swift Language Grammar About Reference
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [About the Language Reference](https://docs.swift.org/swift-book/ReferenceManual/AboutTheLanguageReference.html#) 부분[^Language-Reference]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다.
>
> 스위프트 5.3 에 대한 내용이 다시 일부 수정되어서,[^swift-update] 추가된 내용 먼저 옮기고 나머지 부분을 옮기도록 합니다. 전체 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## About the Language Reference (언어의 기준에 대하여)

이제부터 책의 나머지 부분은 스위프트 프로그래밍 언어의 공식 문법을 설명합니다. 여기서 문법을 설명하는 것은 언어를 좀 더 자세히 이해하도록 돕기 위한 것이지, 직접 '구문 해석기 (parser)' 나 '컴파일러 (compiler)' 를 만들도록 하기 위함이 아닙니다.

스위프트 언어는 상대적으로 규모가 작은 편인데, 이는 스위프트 코드 어디서나 볼 수 있는 수많은 공통 타입들, 함수들, 그리고 연산자들이 실제로는 스위프트 표준 라이브러리에서 정의되어 있기 때문입니다. 비록 이 타입들, 함수들, 그리고 연산자들이 그 자체로 스위프트 언어의 일부는 아니지만, 이 책의 해설과 코드 예제에서 광범위하게 사용될 것입니다.

### How to Read the Grammar (문법을 읽는 방법)

스위프트 프로그래밍 언어의 공식 문법을 설명할 때 사용하는 표기법 (notation) 은 다음과 같은 몇 가지 협약 (convention) 을 따릅니다:

* '화살표 (→)' 는 '문법 생성 방법 (grammar productions)' 을 표시하는 데 사용하며 “~로 구성될 수 있다” 로 읽을 수 있습니다.
* '구문 표현의 종류 (syntactic categories)'[^syntactic-categories] 는 _이탤릭체_ 로 표시하며 '문법 생성 규칙 (grammar production rule)' 의 양쪽에 나타납니다.
* '글자 값 (literal)'[^literal] 을 나타내는 단어와 '구두점 (punctuation)' 은 굵은 글씨의 `constant width (고정 폭)` 글자로 표시하며 '문법 생성 규칙' 의 오른-쪽에서만 나타납니다.
* '문법 생성 방법' 에 대안이 있는 경우 세로 막대 (\|) 로 구분합니다. 이 대안 방법이 너무 길어서 읽기에 쉽지 않으면, '문법 생성 규칙들' 을 여러 줄로 나눠서 표기합니다.
* 경우에 따라서는, 문법 생성 규칙의 오른-쪽임을 나타내기 위해 '일반 글꼴 글자 (regular font text)'를 사용합니다.[^regular-font]
* '구문 표현의 종류' 와 '글자 값' 이 선택 요소인 경우에는 끝에 첨자로 <sub>­opt­</sub> 를 붙여줍니다. [^optional]

예를 들어서 'getter-setter block' 의 문법은 다음과 같습니다:

> GETTER-SETTER 블럭의 문법
>
> _getter-setter-block_ → **{**­ _getter-clause ­setter-clause <sub>­opt­</sub>­­_ **}**­ \| **{** _­setter-clause ­getter-clause_ **}**­

이 정의는 getter-setter block (블럭) 은 getter clause (구절) 다음에 선택 사항으로 setter 구절을 붙인 후 중괄호로 감싸서 구성하거나, _아니면_ setter 구절 다음에 getter 구절을 붙인 후 중괄호로 감싸면 구성할 수 있음을 나타냅니다. 위에 있는 '문법 생성 방법' 은 아래에 있는 두 개의 '생성 방법' 과 같은 것으로, 아래에는 대안 방법을 명시적으로 분리하여 나타냈습니다:

> GETTER-SETTER 블럭의 문법
>
> _getter-setter-block_ → **{**­ ­_getter-clause setter-clause <sub>­opt­</sub>_­ **}**­  
> _getter-setter-block_ → **{**­ _setter-clause ­getter-clause_ **}**­

### 참고 자료

[^Language-Reference]: 원문은 [About the Language Reference](https://docs.swift.org/swift-book/ReferenceManual/AboutTheLanguageReference.html#) 에서 확인할 수 있습니다.

[^syntactic-categories]: 'category' 는 '부류, 종류, 범주' 등의 의미를 가지고 있는데, 여기서는 'syntactic categories' 를 '구문 표현이 속해있는 범주' 의 의미로서 '구문 표현의 종류' 라고 옮겼습니다. 예를 들어, '`get { return value }` 라는 구문은 종류가 _getter-setter-block_ 이다' 라고 표현할 수 있습니다.

[^literal]: 여기서 '글자 값' 이란 `let a = 10` 일 때의 `10` 과 같이 실제 글자로 표현된 값을 말하는 것으로, 예를 들어, 이 문장에서 `10` 은 글자 `1` 과 `0` 이 붙어 있는 것이 아니라, 숫자 `10` 으로 인식됩니다.

[^regular-font]: '문법 생성 규칙' 의 오른-쪽에 올 수 있는 것과 왼-쪽에 올 수 있는 것, 양-쪽 다에 올 수 있는 것이 있을 것입니다. 이 중에서 '일반 글꼴 글자 (regular font text)' 는 '문법 생성 규칙' 의 오른-쪽에 올 수 있는 내용을 나타낸다고 볼 수 있습니다.

[^optional]: 여기서의 'optional'은 스위프트의 '옵셔널' 타입과는 상관없는 단어입니다.
