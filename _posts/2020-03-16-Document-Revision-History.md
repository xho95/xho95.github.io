---
layout: post
comments: true
title:  "Swift 5.3: Document Revision History (문서 개정 이력)"
date:   2020-03-16 10:00:00 +0900
categories: Swift Language Grammar Revision History
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Document Revision History](https://docs.swift.org/swift-book/RevisionHistory/RevisionHistory.html) 부분[^Revision-History]을 번역하고 정리한 글입니다.
>
> 현재 번역이 진행 중인데, 2020-06-22 에 Swift 5.3 이 발표되어, 이미 번역된 부분과 남은 부분 모두 Swift 5.3 을 기준으로 옮기도록 합니다. 완료된 목록은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있으며, 일부는 Swift 5.2 기준일 수 있습니다.

## Document Revision History (문서 개정 이력)

#### 2020-06-22

* 스위프트 5.3 을 위해 갱신되었습니다.
* [Trailing Closures (끝자리 클로저)]({% post_url 2020-03-03-Closures %}#trailing-closures-끝자리-클로저) 부분에 '다중 끝자리 클로저 (multiple trailing closures)' 에 대한 정보를 추가하였습니다.
* [Adopting a Protocol Using a Synthesized Implementation (통합된 구현을 사용하여 프로토콜 채택하기)]({% post_url 2016-03-03-Protocols %}#adopting-a-protocol-using-a-synthesized-implementation-통합된-구현을-사용하여-프로토콜-채택하기) 부분에 열거체를 위한 `Comparable` 의 통합된 구현에 대한 정보를 추가했습니다.
* [Contextual Where Clauses (상황별 where 절)]({% post_url 2020-02-29-Generics %}#contextual-where-clauses-상황별-where-절) 부분을 추가하였으며 이제 더 많은 곳에서 제네릭 `where` 절을 작성할 수 있습니다.
* 옵셔널 값을 가지는 무소속 참조를 사용하는 것에 대한 정보를 설명하는 [Unowned Optional References (무소속 옵셔널 참조)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#unowned-optional-references-무소속-옵셔널-참조) 부분을 추가하였습니다.
* [main]({% post_url 2020-08-14-Attributes %}#main) 부분에 `@main` 특성에 대한 정보를 추가하였습니다.
* [Literal Expression (글자 값 표현식)]({% post_url 2020-08-19-Expressions %}#literal-expression-글자-값-표현식) 부분에 `#filePath` 를 추가하였으며, `#file` 에 대한 '논의 (discussion)' 를 갱신하였습니다.
* [Escaping Closures (벗어나는 클로저)]({% post_url 2020-03-03-Closures %}#escaping-closures-벗어나는-클로저) 부분을 갱신하였으며, 이제 클로저는 더 많은 상황에서 `self` 를 암시적으로 참조할 수 있습니다.
* [Handling Errors Using Do-Catch ('Do-Catch' 구문으로 에러 처리하기)]({% post_url 2020-05-16-Error-Handling %}#handling-errors-using-do-catch-do-catch-구문으로-에러-처리하기) 와 [Do Statement ('do' 구문)]({% post_url 2020-08-20-Statements %}#do-statement-do-구문) 부분을 갱신하였으며, 이제 `catch` 절은 다중 에러와 '맞춰볼 (match)' 수 있습니다.
* [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 부분을 갱신하였으며, 이제 느긋한 속성은 관찰자를 가질 수 있습니다.
* [Protocol Declaration (프로토콜 선언)]({% post_url 2020-08-15-Declarations %}#protocol-declaration-프로토콜-선언) 부분을 갱신하였으며, 이제 열거체의 멤버는 프로토콜의 필수 조건을 만족할 수 있습니다.
* '획득자 (getter)' 가 관찰자 이전에 호출될 때가 언제인지를 설명하기 위해 [Stored Variable Observers and Property Observers (저장 변수 관찰자와 속성 관찰자)]({% post_url 2020-08-15-Declarations %}#stored-variable-observers-and-property-observers-저장-변수-관찰자와-속성-관찰자) 부분을 갱신하였습니다.

### 참고 자료

[^Revision-History]: 이 글에 대한 원문은 [Document Revision History](https://docs.swift.org/swift-book/RevisionHistory/RevisionHistory.html) 에서 확인할 수 있습니다.
