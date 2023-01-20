---
layout: post
comments: true
title:  "About the Language Reference (언어의 기준에 대하여)"
date:   2017-03-13 11:30:00 +0900
categories: Swift Language Grammar About Reference
---

{% include header_swift_book.md %}

## About the Language Reference (언어의 기준에 대하여)

이 부분부터 스위프트 프로그래밍 언어의 공식 문법을 설명합니다. 여기서 설명하는 문법은, 구문 해석기 (parser) 나 컴파일러 (compiler) 를 직접 구현하게 하는 것 보단, 언어를 좀 더 자세히 이해하도록 돕기 위한 것입니다.

스위프트 언어는 상대적으로 소규모 (small) 인데, 스위프트 코드 거의 어디서나 나타나는 수많은 공통 타입과, 함수, 및 연산자들이 실제론 스위프트 표준 라이브러리에 정의되어 있기 때문입니다. 이러한 타입과, 함수, 및 연산자들은 스위프트 언어 그 자체의 일부는 아니긴 하지만, 이제부터의 논의와 코드 예제에서 광범위하게 사용됩니다.

### How to Read the Grammar (문법 읽는 방법)

스위프트 프로그래밍 언어의 공식 문법 설명에 사용하는 표기법은 몇 가지 협약 (conventions) 을 따릅니다[^notation]:

* 문법 생산물 (grammar productions) 은 화살표 (`→`) 로 표시하며 “구성할 수 있다 (can consist of)” 고 읽을 수 있습니다.
* 구문 범주 (syntactic categories) 는 _이탤릭체 (italic)_ 로 지시하며 문법 생산 규칙 (grammar production rule) 양 쪽에 나타납니다.[^syntactic-categories]
* 글자 값 (literal)[^literal] 단어 및 구두점 (punctuation) 은 `constant width` (상수 폭) 굵은 글씨체로 지시하며 문법 생산 규칙 오른-쪽에만 나타납니다.
* 대안으로 생산한 문법은 세로 막대 (`|`) 로 구분합니다. 대안 생산물이 너무 길어 이해하기 쉽지 않을 땐, 이를 여러 개의 문법 생산물로 끊어서 새로운 줄에 둡니다.
* 몇몇 경우에, 표준 글꼴 (regular font) 텍스트를 사용하여 문법 생산 규칙의 오른-쪽 (부분)을 설명합니다.[^regular-font]
* 선택적인 구문 범주와 글자 값은 뒤에 딸린 첨자 (trailing subscript) 인, _opt_ 로, 표시합니다.

한 예로, 획득자-설정자 블럭 (getter-setter block) 의 문법은 다음 처럼 정의합니다:

> GETTER-SETTER 블럭의 문법
>
> _getter-setter-block_ → **{**­ _getter-clause ­setter-clause <sub>­opt­</sub>­­_ **}**­ \| **{** _­setter-clause ­getter-clause_ **}**­

이 정의는 획득자-설정자 블럭이 획득자 절과 그 뒤의 선택적 설정자 절을, 중괄호로 테두리 친 것, _또는_, 설정자 절과 그 뒤의 획득자 절을, 중괄호로 테두리 친 것, 으로 구성할 수 있다는 걸 지시합니다. 위의 문법 생산물은 다음의 두 생산물과 같다고 볼 수 있는데, 여기선 하나씩 명시하여 상세하게 설명합니다:

> GETTER-SETTER 블럭의 문법
>
> _getter-setter-block_ → **{**­ ­_getter-clause setter-clause <sub>­opt­</sub>_­ **}**­  
> _getter-setter-block_ → **{**­ _setter-clause ­getter-clause_ **}**­

### 다음 장

[Lexical Structure (어휘 구조) >]({% link docs/books/swift-programming-language/lexical-structure.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [About the Language Reference](https://docs.swift.org/swift-book/ReferenceManual/AboutTheLanguageReference.html) 에서 볼 수 있습니다.

[^notation]: '구문 문법' 자체를 번역하는 것은 의미가 없기 때문에, 사실 '구문 표기법' 자체도 큰 의미가 없습니다. 앞으로, 실제 '표기법' 이 나타나는 곳마다, 원문 링크를 달아놓을 것이므로, 해당 '구문 문법' 이 궁금하다면 링크를 통하여 확인하기 바랍니다. 스위프트의 모든 '구문 문법' 을 한 번에 확인하고 싶으면, [Summary of the Grammar (문법 총정리)](https://docs.swift.org/swift-book/ReferenceManual/zzSummaryOfTheGrammar.html#) 내용을 보도록 합니다. 

[^syntactic-categories]: 아래 예제에서, `getter-setter-block` 같이, '이텔릭체' 로 된 모든 것들이 다 '구문 범주' 입니다.

[^literal]: 여기서 '글자 값 (literal)' 이란 `let a = 10` 에서의 `10` 과 같은 값을 말합니다. 글자 값에 대한 더 자세한 정보는, [Literals (글자 값)]({% link docs/books/swift-programming-language/lexical-structure.md %}#literals-글자-값) 부분을 보도록 합니다. 

[^regular-font]: '표준 글꼴 (regular font)' 은 문법 그 자체가 아닌 그 문법 요소에 대한 설명에 사용합니다.
