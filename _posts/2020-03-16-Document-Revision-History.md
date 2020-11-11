---
layout: post
comments: true
title:  "Swift 5.3: Document Revision History (문서 개정 이력)"
date:   2020-03-16 10:00:00 +0900
categories: Swift Language Grammar Revision History
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Document Revision History](https://docs.swift.org/swift-book/RevisionHistory/RevisionHistory.html) 부분[^Revision-History]을 번역하고 정리한 글입니다.
>
> 스위프트 5.3 에 대한 내용이 다시 일부 수정되어서,[^swift-update] 추가된 내용 먼저 옮기고 나머지 부분을 옮기도록 합니다. 전체 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Document Revision History (문서 개정 이력)

#### 2020-09-16

* 스위프트 5.3 에서 갱신됨.
* '다중 끝자리 클로저 (multiple trailing closures)' 에 대한 정보를 [Trailing Closures (끝자리 클로저)]({% post_url 2020-03-03-Closures %}#trailing-closures-끝자리-클로저) 부분에 추가했으며, 끝자리 클로저를 매개 변수와 일치시키는 방법에 대한 정보는 [Function Call Expression (함수 호출 표현식)]({% post_url 2020-08-19-Expressions %}#function-call-expression-함수-호출-표현식) 부분에 추가함.
* 열거체에 대한 `Comparable` 의 통합된 구현에 대한 정보를 [Adopting a Protocol Using a Synthesized Implementation (통합된 구현을 사용하여 프로토콜 채택하기)]({% post_url 2016-03-03-Protocols %}#adopting-a-protocol-using-a-synthesized-implementation-통합된-구현을-사용하여-프로토콜-채택하기) 부분에 추가함.
* [Contextual Where Clauses (상황별 where 절)]({% post_url 2020-02-29-Generics %}#contextual-where-clauses-상황별-where-절) 부분을 추가했으며 이제 더 많은 곳에서 '일반화된 (generic) `where` 절' 을 작성할 수 있음.
* 옵셔널 값을 가지는 '무소속 참조 (undowned reference)' 의 사용에 대한 정보를 [Unowned Optional References (무소속 옵셔널 참조)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#unowned-optional-references-무소속-옵셔널-참조) 부분에 추가함.
* '`@main` 특성 (attribute)' 에 대한 정보를 [main (메인)]({% post_url 2020-08-14-Attributes %}#main-메인) 부분에 추가함.
* `#filePath` 를 [Literal Expression (글자 값 표현식)]({% post_url 2020-08-19-Expressions %}#literal-expression-글자-값-표현식) 부분에 추가했으며, `#file` 에 대한 '논의 (discussion)' 를 갱신함.
* [Escaping Closures (벗어나는 클로저)]({% post_url 2020-03-03-Closures %}#escaping-closures-벗어나는-클로저) 부분을 갱신했으며, 이제 클로저는 더 많은 상황에서 암시적으로 `self` 를 참조할 수 있음.
* [Handling Errors Using Do-Catch ('Do-Catch' 구문으로 에러 처리하기)]({% post_url 2020-05-16-Error-Handling %}#handling-errors-using-do-catch-do-catch-구문으로-에러-처리하기) 와 [Do Statement ('do' 구문)]({% post_url 2020-08-20-Statements %}#do-statement-do-구문) 부분을 갱신했으며, 이제 '`catch` 절' 은 '다중 에러 (multiple errors)' 와도 일치할 수 있음.
* `Any` 에 대한 더 많은 정보를 추가했으며 이를 새로운 [Any Type ('Any' 타입)]({% post_url 2020-02-20-Types %}#any-type-any-타입) 부분으로 옮김.
* [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 부분을 갱신했으며, 이제 '느긋한 속성 (lazy properties)' 도 관찰자를 가질 수 있음.
* [Protocol Declaration (프로토콜 선언)]({% post_url 2020-08-15-Declarations %}#protocol-declaration-프로토콜-선언) 부분을 갱신했으며, 이제 열거체의 멤버도 '프로토콜 필수 조건 (protocol requirements)' 을 만족할 수 있음.
* 언제 '획득자 (getter)' 가 '관찰자 (observer)' 이전에 호출되는 지를 설명하기 위해 [Stored Variable Observers and Property Observers (저장 변수 관찰자와 속성 관찰자)]({% post_url 2020-08-15-Declarations %}#stored-variable-observers-and-property-observers-저장-변수-관찰자와-속성-관찰자) 부분을 갱신함.
* '원자적인 연산 (atomic operations)' 을 언급하기 위해 [Memory Safety (메모리 안전성)]({% post_url 2020-04-07-Memory-Safety %}) '장 (chapter)' 을 갱신함.

#### 2020-03-24

* 스위프트 5.2 에서 갱신됨.
* 클로저를 대신하는 '키 경로 (key path)' 전달에 대한 정보를 [Key-Path Expression (키-경로 표현식)]({% post_url 2020-08-19-Expressions %}#key-path-expression-키-경로-표현식) 부분에 추가함.
* 클래스, 구조체, 및 열거체의 인스턴스를 '함수 호출 구문 표현' 에서 사용할 수 있게 하는 '수월한 구문 표현 (syntatic sugar)' 에 대한 정보를 가지고 있는 [Methods with Special Names (특수한 이름을 가진 메소드)](#methods-with-special-names-특수한-이름을-가진-메소드) 부분을 추가함.
* [Subscript Options (첨자 연산의 선택 사항들)]({% post_url 2020-03-30-Subscripts %}#subscript-options-첨자-연산의-선택-사항들) 부분을 갱신했으며, 이제 '첨자 연산'이 '기본 설정 값' 을 가지는 매개 변수를 지원함.
* [Self Type ('Self' 타입)]({% post_url 2020-02-20-Types %}#self-type-Self-타입) 부분을 갱신했으며, 이제 `Self` 를 더 많은 상황에서 사용할 수 있음.
* '암시적으로 포장이 풀리는 옵셔널 값' 은 '옵셔널 값' 으로든 '옵셔널이-아닌 값' 으로든 사용할 수 있다는 것을 확실히 하기 위해 [Implicitly Unwrapped Optionals (암시적으로 포장이 풀리는 옵셔널)]({% post_url 2016-04-24-The-Basics %}#implicitly-unwrapped-optionals-암시적으로-포장이-풀리는-옵셔널) 부분을 갱신함.

### 참고 자료

[^Revision-History]: 이 글에 대한 원문은 [Document Revision History](https://docs.swift.org/swift-book/RevisionHistory/RevisionHistory.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 과 함께 발표 되었다가, 2020-09-16 일에 Apple Event 와 함께 다시 갱신 되었습니다.
