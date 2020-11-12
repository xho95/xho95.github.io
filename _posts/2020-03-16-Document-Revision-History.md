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
* 클래스, 구조체, 및 열거체의 인스턴스를 '함수 호출 구문 표현' 에서 사용할 수 있게 하는 '수월한 구문 표현 (syntatic sugar)' 에 대한 정보를 가지고 있는 [Methods with Special Names (특수한 이름을 가진 메소드)]({% post_url 2020-08-15-Declarations %}#methods-with-special-names-특수한-이름을-가진-메소드) 부분을 추가함.
* [Subscript Options (첨자 연산의 선택 사항들)]({% post_url 2020-03-30-Subscripts %}#subscript-options-첨자-연산의-선택-사항들) 부분을 갱신했으며, 이제 '첨자 연산'이 '기본 설정 값' 을 가지는 매개 변수를 지원함.
* [Self Type ('Self' 타입)]({% post_url 2020-02-20-Types %}#self-type-self-타입) 부분을 갱신했으며, 이제 `Self` 를 더 많은 상황에서 사용할 수 있음.
* '암시적으로 포장이 풀리는 옵셔널 값' 은 '옵셔널 값' 으로든 '옵셔널이-아닌 값' 으로든 사용할 수 있다는 것을 확실히 하기 위해 [Implicitly Unwrapped Optionals (암시적으로 포장이 풀리는 옵셔널)]({% post_url 2016-04-24-The-Basics %}#implicitly-unwrapped-optionals-암시적으로-포장이-풀리는-옵셔널) 부분을 갱신함.

#### 2019-09-10

* 스위프트 5.1 에서 갱신됨.
* 지정한 이름 있는 반환 타입을 제공하는 대신, 그 반환 값이 준수하는 프로토콜을 지정하는 함수에 대한 정보를, [Opaque Types (불투명한 타입)]({% post_url 2020-02-22-Opaque-Types %}) '장 (chapter)' 에 추가함.
* '속성 포장 (property wrappers)' 에 대한 정보를 [Property Wrappers (속성 포장)]({% post_url 2020-05-30-Properties %}#property-wrappers-속성-포장) 부분에 추가함.
* 라이브러리 진화에서 '동결된 (frozen)' 열거체와 구조체에 대한 정보를 [frozen (동결된)]({% post_url 2020-08-14-Attributes %}#frozen-동결된) 부분에 추가함.
* `return` 을 생략한 함수에 대한 정보를 가진 [Functions With an Implicit Return (암시적으로 반환하는 함수)]({% post_url 2020-06-02-Functions %}#functions-with-an-implicit-return-암시적으로-반환하는-함수) 와 [Shorthand Getter Declaration (획득자 선언의 약칭 표현)]({% post_url 2020-05-30-Properties %}#shorthand-getter-declaration-획득자-선언의-약칭-표현) 부분을 추가함.
* 타입에서 첨자 연산을 사용하는 것에 대한 정보를 [Type Subscripts (타입 첨자 연산)]({% post_url 2020-03-30-Subscripts %}#type-subscripts-타입-첨자-연산) 부분에 추가함.
* [Enumeration Case Pattern (열거체 case 값 패턴)]({% post_url 2020-08-25-Patterns %}#enumeration-case-pattern-열거체-case-값-패턴) 부분을 갱신했으며, 이제 '열거체 case 값 패턴' 도 옵셔널 값과 일치할 수 있음.
* [Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)]({% post_url 2016-01-23-Initialization %}#memberwise-initializers-for-structure-types-구조체-타입을-위한-멤버-초기자) 부분을 갱신했으며, 이제 기본 설정 값을 가진 매개 변수에 대해서 '멤버 초기자 (memberwise initializers)' 도 매개 변수의 생략을 지원함.
* 실행 시간에 '키 경로 (key path)' 로 찾아 가는 동적 멤버에 대한 정보를 [dynamicMemberLookup (동적으로 멤버 찾아가기)]({% post_url 2020-08-14-Attributes %}#dynamicmemberlookup-동적으로-멤버-찾아가기) 부분에 추가함.
* [Compiler Control Statements (조건부 컴파일 블럭)]({% post_url 2020-08-20-Statements %}#conditional-compilation-block-조건부-컴파일-블럭) 에 있는 '대상 환경 (target environment)' 목록에 `macCatalyst` 를 추가함.
* [Self Type ('Self' 타입)]({% post_url 2020-02-20-Types %}#self-type-self-타입) 부분을 갱신했으며, 이제 `Self` 는 현재의 클래스, 구조체, 또는 열거체 선언에서 도입한 타입을 참조하기 위해 사용할 수 있음.

#### 2019-03-25

* 스위프트 5.0 에서 갱신됨.
* [Extended String Delimiters (확장된 문자열 구분자)]({% post_url 2020-04-14-Structures-and-Classes %}#extended-string-delimiters-확장된-문자열-구분자) 부분을 추가했으며 '확장된 문자열 구분자 (extended string delimiters)' 에 대한 정보를 가진 [String Literals (문자열 글자 값)]({% post_url 2020-07-28-Lexical-Structure %}#string-literals-문자열-글자-값) 부분을 갱신함.
* `dynamicCallable` 특성을 사용하여 함수처럼 동적으로 호출하는 인스턴스에 대한 정보를 가진 [dynamicCallable (동적으로 호출 가능한)]({% post_url 2020-08-14-Attributes %}#dynamiccallable-동적으로-호출-가능한) 부분을 추가함.
* 'switch' 문에 있는 미래의 열거체 'case 값' 을 처리하기 위하여 `unknown` 이라는 'switch 문의 case 절' 특성을 사용하는 것에 대한 정보를 가진 [unknown (알지 못하는)]({% post_url 2020-08-14-Attributes %}#unknown-알지-못하는) 과 [Switching Over Future Enumeration Cases (미래의 열거체 case 값에 대해서도 전환 (switching) 하기)]({% post_url 2020-08-20-Statements %}#switching-over-future-enumeration-cases-미래의-열거체-case-값에-대해서도-전환-switching-하기) 부분을 추가함.
* '자기 식별 키 경로 (identity key path; `\.self`)' 에 대한 정보를 [Key-Path Expression (키-경로 표현식)]({% post_url 2020-08-19-Expressions %}#key-path-expression-키-경로-표현식) 부분에 추가함.
* '플랫폼 조건 (platform conditions)' 에서 '보다 작음 연산자 (less than operator; `<`)' 를 사용하는 것에 대한 정보를 [Conditional Compilation Block (조건부 컴파일 블럭)]({% post_url 2020-08-20-Statements %}#conditional-compilation-block-조건부-컴파일-블럭) 부분에 추가함.

#### 2018-09-17

* 스위프트 4.2 에서 갱신됨.
* 열거체의 모든 'case 값' 에 접근하는 것에 대한 정보를 [Iterating over Enumeration Cases (열거체 case 값에 대해 동작 반복 적용하기)]({% post_url 2020-06-13-Enumerations %}#iterating-over-enumeration-cases-열거체-case-값에-대해-동작-반복-적용하기) 부분에 추가함.
* `#error` 와 `#warning` 에 대한 정보를 [Compile-Time Diagnostic Statement (컴파일-시간 진단문)]({% post_url 2020-08-20-Statements %}#compile-time-diagnostic-statement-컴파일-시간-진단문) 부분에 추가함.
* '인라이닝 (inlining)' 에 대한 정보를 [Declaration Attributes (선언 특성)](#declaration-attributes-선언-특성) 부분 밑의 `inlinable` 과 `usableFromInline` 특성에 추가함.
* 실행 시간에 이름으로 찾아 가는 멤버에 대한 정보를 [Declaration Attributes (선언 특성)](#declaration-attributes-선언-특성) 부분 밑의 `dynamicMemberLookup` 특성에 추가함.
* `requires_stored_property_inits` 과 `warn_unqualified_access` 특성에 대한 정보를 [Declaration Attributes (선언 특성)](#declaration-attributes-선언-특성) 부분에 추가함.
* 사용하고 있는 스위프트 컴파일러 버전에 따라 조건부로 코드를 컴파일하는 방법에 대한 정보를 [Conditional Compilation Block (조건부 컴파일 블럭)]({% post_url 2020-08-20-Statements %}#conditional-compilation-block-조건부-컴파일-블럭) 부분에 추가함.
* `#dsohandle` 에 대한 정보를 [Literal Expression (글자 값 표현식)]({% post_url 2020-08-19-Expressions %}#literal-expression-글자-값-표현식) 부분에 추가함.

#### 2018-03-29

* 스위프트 4.1 에서 갱신됨.
* '같음 비교 연산자 (equivalence operators)' 의 통합된 구현에 대한 정보를 [Equivalence Operators (같음 비교 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#equivalence-operators-같음-비교-연산자) 부분에 추가함.
* '조건부 프로토콜 준수성 (conditional protocol conformance)' 에 대한 정보를 [Declarations (선언)]({% post_url 2020-08-15-Declarations %}) 장의 [Extension Declaration (익스텐션-확장 선언)]({% post_url 2020-08-15-Declarations %}#extension-declaration-익스텐션-확장-선언) 부분과, [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 장의 [Conditionally Conforming to a Protocol (조건에 따라 프로토콜 준수하기)]({% post_url 2016-03-03-Protocols %}#conditionally-conforming-to-a-protocol-조건에-따라-프로토콜-준수하기) 부분에, 추가함.
* '재귀적인 프로토콜 구속 조건 (recursive protocol constraints)' 에 대한 정보를 [Using a Protocol in Its Associated Type's Constraints (프로토콜을 자신에게 결합된 타입의 구속 조건에서 사용하기)]({% post_url 2020-02-29-Generics %}#using-a-protocol-in-its-associated-type-s-Constraints-프로토콜을-자신에게-결합된-타입의-구속-조건에서-사용하기) 부분에 추가함.
* `canImport()` 와 `targetEnvironment()` '플랫폼 조건 (platform conditions)' 에 대한 정보를 [Conditional Compilation Block (조건부 컴파일 블럭)]({% post_url 2020-08-20-Statements %}#conditional-compilation-block-조건부-컴파일-블럭) 에 추가함.

#### 2017-12-04

* 스위프트 4.0.3 에서 갱신됨.
* [Key-Path Expression (키-경로 표현식)]({% post_url 2020-08-19-Expressions %}#key-path-expression-키-경로-표현식) 부분을 갱신했으며, 이제 '키 경로 (key paths)' 가 '첨자 연산 성분 (subscript components)' 을 지원함.

#### 2017-09-19

* 스위프트 4.0 에서 갱신됨.
* 메모리에 대한 '독점적인 접근 (exclusive access)' 에 대한 정보를 [Memory Safety (메모리 안전성)]({% post_url 2020-04-07-Memory-Safety %}) 장에 추가함.
* [Associated Types with a Generic Where Clause (일반화된 (generic) where 절을 가지는 결합된 타입)](#associated-types-with-a-generic-where-clause-일반화된-generic-where-절을-가지는-결합된-타입) 부분을 추가했으며, 이제 '일반화된 (generic) `where` 절' 을 사용하여 '결합된 타입 (associated types)' 을 구속할 수 있음.
* '여러 줄짜리 문자열 글자 값 (multiline string literal)' 에 대한 정보를 [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) 장의 [String Literals (문자열 글자 값)]({% post_url 2016-05-29-Strings-and-Characters %}#string-literals-문자열-글자-값) 부분과, [Lexical Structure (어휘 구조)]({% post_url 2020-07-28-Lexical-Structure %}) 장의 [String Literals (문자열 글자 값)]({% post_url 2020-07-28-Lexical-Structure %}#string-literals-문자열-글자-값) 부분에, 추가함.
* [Declaration Attributes (선언 특성)](#declaration-attributes-선언-특성) 에 있는 `objc` 특성에 대한 논의를 갱신했으며, 이제 이 특성의 추론은 더 적은 곳에서 이뤄짐.
* [Generic Subscripts (일반화된 (generic) 첨자 연산)]({% post_url 2020-02-29-Generics %}#generic-subscripts-일반화된-generic-첨자-연산) 부분을 추가했으며, 이제 첨자 연산도 '일반화 (generic)' 가 될 수 있음.
* [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 장의 [Protocol Composition (프로토콜 합성)]({% post_url 2016-03-03-Protocols %}#protocol-composition-프로토콜-합성) 부분과, [Types (타입)]({% post_url 2020-02-20-Types %}) 장의 [Protocol Composition Type (프로토콜 합성 타입)]({% post_url 2020-02-20-Types %}#protocol-composition-type-프로토콜-합성-타입) 부분에 있는 논의를 갱신했으며, 이제 '프로토콜 합성 타입 (protocol composition types)' 은 '상위 클래스 필수 조건 (superclass requirement)' 을 가질 수 있음.
* [Extension Declaration (익스텐션-확장 선언)]({% post_url 2020-08-15-Declarations %}#extension-declaration-익스텐션-확장-선언) 에 있는 '프로토콜 익스텐션 (protocol extensions)' 에 대한 논의를 갱신했으며, 이제 `final` 은 여기서 허용되지 않음.
* '선행 조건문 (preconditions)' 과 '치명적인 에러 (fatal errors)' 에 대한 정보를 [Assertions and Preconditions (단언문과 선행 조건문)]({% post_url 2016-04-24-The-Basics %}#assertions-and-preconditions-단언문과-선행-조건문) 부분에 추가함.

### 참고 자료

[^Revision-History]: 이 글에 대한 원문은 [Document Revision History](https://docs.swift.org/swift-book/RevisionHistory/RevisionHistory.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 과 함께 발표 되었다가, 2020-09-16 일에 Apple Event 와 함께 다시 갱신 되었습니다.
