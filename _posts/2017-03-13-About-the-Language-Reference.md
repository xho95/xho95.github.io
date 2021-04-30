---
layout: post
comments: true
title:  "Swift 5.4: About the Language Reference (언어의 기준에 대하여)"
date:   2017-03-13 11:30:00 +0900
categories: Swift Language Grammar About Reference
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.4)](https://docs.swift.org/swift-book/) 책의 [About the Language Reference](https://docs.swift.org/swift-book/ReferenceManual/AboutTheLanguageReference.html#) 부분[^Language-Reference]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.4: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## About the Language Reference (언어의 기준에 대하여)

이제부터 책에서 '스위프트 프로그래밍 언어' 의 공식 문법을 설명합니다. 여기서 설명하는 문법은, '구문 해석기 (parser)' 나 '컴파일러 (compiler)' 를 직접 구현하도록 허용하는 것이라기 보다는, 언어를 좀 더 자세히 이해하도록 돕기 위한 것입니다.

스위프트 언어는, 실제로는 스위프트 표준 라이브러리에서 스위프트 코드 거의 어디에나 있는 많은 공통 타입, 함수, 그리고 연산자들을 정의하기 때문에, 상대적으로 '소규모 (small)' 입니다. 비록 이 타입, 함수, 그리고 연산자들이 그 자체로는 스위프트 언어가 아닐지라도, 이제부터 책의 논의와 코드 예제에서 이를 광범위하게 사용합니다.

### How to Read the Grammar (문법 읽는 방법)

'스위프트 프로그래밍 언어' 의 공식 문법을 설명하는데 사용하는 '표기법' 은 몇몇 '협약 (convention)' 을 따릅니다[^notation]:

* '화살표 (→)' 는 '문법 산출물 (grammar productions)' 을 표시하는데 사용하며 “구성할 수 있다” 라고 이해할 수 있습니다
* '구문 범주 (syntactic categories)' 는 _이탤릭체_ 로 지시하며 '문법 산출 규칙 (grammar production rule)' 양 쪽에 다 나타납니다.[^syntactic-categories]
* '글자 값 (literal)[^literal] 단어' 와 '구두점 (punctuation)' 은 굵은 글씨의 '`constant width` 문장' 으로 지시하며 '문법 산출 규칙' 의 오른-쪽에서만 나타납니다.
* '문법 산출물' 의 대안은 '세로 막대 (`|`)' 로 구분합니다. '대안 산출물' 이 쉽게 이해하기에 너무 길 때는, 이를 여러 '문법 산출 규칙' 으로 끊어서 새로운 줄에 나타냅니다.
* 몇몇 경우에, '표준적인 글꼴 (regular font) 문장' 을 사용하여 '문법 산출 규칙' 의 오른-쪽을 설명합니다.[^regular-font]
* 선택 사항인 '구문 범주' 와 '글자 값' 은, _opt_ 라는, '끝자리 첨자 연산 (trailing subscript)' 으로 표시합니다.

예를 들어, '획득자-설정자 블럭 (getter-setter block)' 문법은 다음 처럼 정의합니다:

> GETTER-SETTER 블럭의 문법
>
> _getter-setter-block_ → **{**­ _getter-clause ­setter-clause <sub>­opt­</sub>­­_ **}**­ \| **{** _­setter-clause ­getter-clause_ **}**­

이 정의는 '획득자-설정자 (getter-setter) 블럭' 은, 중괄호 테두리 안의, '획득자 절' 과 그 뒤의 선택적인 '설정자 절', _또는_, 중괄호 테두리 안의, '설정자 절' 과 그 뒤의 '획득자 절' 로 구성할 수 있음을 지시합니다. 위의 '문법 산출물' 은, 명시적으로 상세하게 설명하고 있는, 다음의 두 '산출물' 들과 '동치' 입니다:

> GETTER-SETTER 블럭의 문법
>
> _getter-setter-block_ → **{**­ ­_getter-clause setter-clause <sub>­opt­</sub>_­ **}**­  
> _getter-setter-block_ → **{**­ _setter-clause ­getter-clause_ **}**­

### 다음 장

[Lexical Structure (어휘 구조) > ]({% post_url 2020-07-28-Lexical-Structure %})

### 참고 자료

[^Language-Reference]: 원문은 [About the Language Reference](https://docs.swift.org/swift-book/ReferenceManual/AboutTheLanguageReference.html#) 에서 확인할 수 있습니다.

[^notation]: '구문 문법' 자체를 번역하는 것은 의미가 없기 때문에, 사실 '구문 표기법' 자체도 큰 의미가 없습니다. 앞으로, 실제 '표기법' 이 나타나는 곳마다, 원문 링크를 달아놓을 것이므로, 해당 '구문 문법' 이 궁금하다면 링크를 통하여 확인하기 바랍니다. 스위프트의 모든 '구문 문법' 을 한 번에 확인하고 싶으면, [Summary of the Grammar (문법 총정리)](https://docs.swift.org/swift-book/ReferenceManual/zzSummaryOfTheGrammar.html#) 내용을 참고하기 바랍니다. 

[^syntactic-categories]: 아래 예제에서, `getter-setter-block` 같이, '이텔릭체' 로 된 모든 것들이 다 '구문 범주' 입니다.

[^literal]: 여기서 '글자 값 (literal)' 이란 `let a = 10` 에서의 `10` 과 같은 값을 말하는 것입니다. '글자 값' 에 대한 더 자세한 정보는, [Literals (글자 값)]({% post_url 2020-07-28-Lexical-Structure %}#literals-글자-값) 부분을 참고하기 바랍니다. 

[^regular-font]: '표준적인 글꼴 (regular font)' 은 '문법' 자체가 아니라 그 문법 요소에 대한 '설명' 에 사용된다는 의미입니다.
