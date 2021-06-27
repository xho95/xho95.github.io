---
layout: post
comments: true
title:  "Swift 5.5: Document Revision History (문서 개정 이력)"
date:   2020-03-16 10:00:00 +0900
categories: Swift Language Grammar Revision History
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.5)](https://docs.swift.org/swift-book/) 책의 [Document Revision History](https://docs.swift.org/swift-book/RevisionHistory/RevisionHistory.html) 부분[^Revision-History]을 번역하고, 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.5: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Document Revision History (문서 개정 이력)

#### 2021-06-07

* 스위프트 5.5 에서 갱신한 것. 
* '비동기 함수 (asynchronous functions)', '임무 (tasks)', 그리고 '행위자 (actors)' 에 대한 정보를 [Concurrency (동시성)]({% post_url 2021-06-10-Concurrency %}) 장과, [Actor Declaration (행위자 선언)]({% post_url 2020-08-15-Declarations %}#actor-declaration-행위자-선언) 부분, [Asynchronous Functions and Methods (비동기 함수와 메소드)]({% post_url 2020-08-15-Declarations %}#asynchronous-functions-and-methods-비동기-함수와-메소드) 부분, 그리고 [Await Operator (`await` 연산자)]({% post_url 2020-08-19-Expressions %}#await-operator-await-연산자) 부분에 추가함.

#### 2021-04-26

* 스위프트 5.4 에서 갱신한 것.
* '결과 제작자 (result builders)' 에 대한 정보를 가진 [Result Builders (결과 제작자)]({% post_url 2020-05-11-Advanced-Operators %}#result-builders-결과-제작자) 와 [resultBuilder]({% post_url 2020-08-14-Attributes %}#resultbuilder-결과-제작자) 부분을 추가함.
* 함수 호출 시에 '입-출력 매개 변수' 를 '안전하지 않은 (unsafe) 포인터' 로 암시적으로 변환할 수 있는 방법에 대한 정보를 가진 [Implicit Conversion to a Pointer Type (포인터 타입으로의 암시적인 변환)]({% post_url 2020-08-19-Expressions %}#implicit-conversion-to-a-pointer-type-포인터-타입으로의-암시적인-변환) 부분을 추가함.
* [Variadic Parameters (가변 매개 변수)]({% post_url 2020-06-02-Functions %}#variadic-parameters-가변-매개-변수) 와 [Function Declaration (함수 선언)]({% post_url 2020-08-15-Declarations %}#function-declaration-함수-선언) 부분을 갱신했으며, 이제 함수는 '다중 가변 매개 변수' 를 가질 수 있음.
* [Implicit Member Expression (암시적인 멤버 표현식)]({% post_url 2020-08-19-Expressions %}#implicit-member-expression-암시적인-멤버-표현식) 부분을 갱신했으며, 이제 '암시적인 멤버 표현식' 을 서로 연쇄할 수 있음.

#### 2020-09-16

* 스위프트 5.3 에서 갱신한 것.
* '다중 끝자리 클로저 (multiple trailing closures)' 에 대한 정보를 [Trailing Closures (끝자리 클로저)]({% post_url 2020-03-03-Closures %}#trailing-closures-끝자리-클로저) 부분에 추가했으며, 끝자리 클로저를 매개 변수와 일치시키는 방법에 대한 정보는 [Function Call Expression (함수 호출 표현식)]({% post_url 2020-08-19-Expressions %}#function-call-expression-함수-호출-표현식) 부분에 추가함.
* 열거체에 대한 `Comparable` 의 통합된 구현에 대한 정보를 [Adopting a Protocol Using a Synthesized Implementation (통합된 구현을 사용하여 프로토콜 채택하기)]({% post_url 2016-03-03-Protocols %}#adopting-a-protocol-using-a-synthesized-implementation-통합된-구현을-사용하여-프로토콜-채택하기) 부분에 추가함.
* [Contextual Where Clauses (상황별 where 절)]({% post_url 2020-02-29-Generics %}#contextual-where-clauses-상황별-where-절) 부분을 추가했으며 이제 더 많은 곳에서 '일반화된 (generic) `where` 절' 을 작성할 수 있음.
* 옵셔널 값에 대한 '소유하지 않는 참조 (undowned reference)' 의 사용에 대한 정보를 [Unowned Optional References (소유하지 않는 옵셔널 참조)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#unowned-optional-references-소유하지-않는-옵셔널-참조) 부분에 추가함.
* '`@main` 특성 (attribute)' 에 대한 정보를 [main (메인)]({% post_url 2020-08-14-Attributes %}#main-메인) 부분에 추가함.
* `#filePath` 를 [Literal Expression (글자 값 표현식)]({% post_url 2020-08-19-Expressions %}#literal-expression-글자-값-표현식) 부분에 추가했으며, `#file` 에 대한 '논의 (discussion)' 를 갱신함.
* [Escaping Closures (벗어나는 클로저)]({% post_url 2020-03-03-Closures %}#escaping-closures-벗어나는-클로저) 부분을 갱신했으며, 이제 클로저는 더 많은 상황에서 암시적으로 `self` 를 참조할 수 있음.
* [Handling Errors Using Do-Catch ('Do-Catch' 문으로 에러 처리하기)]({% post_url 2020-05-16-Error-Handling %}#handling-errors-using-do-catch-do-catch-문으로-에러-처리하기) 와 [Do Statement ('do' 문)]({% post_url 2020-08-20-Statements %}#do-statement-do-문) 부분을 갱신했으며, 이제 '`catch` 절' 은 '다중 에러 (multiple errors)' 와도 일치하는지 맞춰볼 수 있음.
* `Any` 에 대한 더 많은 정보를 추가했으며 이를 새로 [Any Type ('Any' 타입)]({% post_url 2020-02-20-Types %}#any-type-any-타입) 부분으로 옮김.
* [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 부분을 갱신했으며, 이제 '느긋한 속성 (lazy properties)' 도 관찰자를 가질 수 있음.
* [Protocol Declaration (프로토콜 선언)]({% post_url 2020-08-15-Declarations %}#protocol-declaration-프로토콜-선언) 부분을 갱신했으며, 이제 열거체의 멤버도 '프로토콜 필수 조건 (protocol requirements)' 을 만족할 수 있음.
* 언제 '획득자 (getter)' 가 '관찰자 (observer)' 이전에 호출되는 지를 설명하기 위해 [Stored Variable Observers and Property Observers (저장 변수 관찰자와 저장 속성 관찰자)]({% post_url 2020-08-15-Declarations %}#stored-variable-observers-and-property-observers-저장-변수-관찰자와-저장-속성-관찰자) 부분을 갱신함.
* '원자적인 연산 (atomic operations)' 을 언급하기 위해 [Memory Safety (메모리 안전성)]({% post_url 2020-04-07-Memory-Safety %}) '장 (chapter)' 을 갱신함.

#### 2020-03-24

* 스위프트 5.2 에서 갱신한 것.
* 클로저를 대신하는 '키 경로 (key path)' 전달에 대한 정보를 [Key-Path Expression (키-경로 표현식)]({% post_url 2020-08-19-Expressions %}#key-path-expression-키-경로-표현식) 부분에 추가함.
* 클래스, 구조체, 및 열거체의 인스턴스를 '함수 호출 구문 표현' 에서 사용할 수 있게 하는 '수월한 구문 표현 (syntatic sugar)' 에 대한 정보를 가지고 있는 [Methods with Special Names (특수한 이름을 가진 메소드)]({% post_url 2020-08-15-Declarations %}#methods-with-special-names-특수한-이름을-가진-메소드) 부분을 추가함.
* [Subscript Options (첨자 연산의 옵션들)]({% post_url 2020-03-30-Subscripts %}#subscript-options-첨자-연산의-옵션들) 부분을 갱신했으며, 이제 '첨자 연산'이 '기본 값' 을 가지는 매개 변수를 지원함.
* [Self Type ('Self' 타입)]({% post_url 2020-02-20-Types %}#self-type-self-타입) 부분을 갱신했으며, 이제 `Self` 를 더 많은 상황에서 사용할 수 있음.
* '암시적으로 포장이 풀리는 옵셔널 값' 은 '옵셔널 값' 으로든 '옵셔널-아닌 값' 으로든 사용할 수 있다는 것을 확실히 하기 위해 [Implicitly Unwrapped Optionals (암시적으로 포장이 풀리는 옵셔널)]({% post_url 2016-04-24-The-Basics %}#implicitly-unwrapped-optionals-암시적으로-포장이-풀리는-옵셔널) 부분을 갱신함.

#### 2019-09-10

* 스위프트 5.1 에서 갱신한 것.
* 특정한 '이름 붙인 반환 타입' 을 제공하는 대신, 그 반환 값이 준수하는 프로토콜을 지정하는 함수에 대한 정보를, [Opaque Types (불투명 타입)]({% post_url 2020-02-22-Opaque-Types %}) 장에 추가함.
* '속성 포장 (property wrappers)' 에 대한 정보를 [Property Wrappers (속성 포장)]({% post_url 2020-05-30-Properties %}#property-wrappers-속성-포장) 부분에 추가함.
* 라이브러리 진화에서 '동결된 (frozen)' 열거체와 구조체에 대한 정보를 [frozen (동결된)]({% post_url 2020-08-14-Attributes %}#frozen-동결된) 부분에 추가함.
* `return` 을 생략한 함수에 대한 정보를 가진 [Functions With an Implicit Return (암시적으로 반환하는 함수)]({% post_url 2020-06-02-Functions %}#functions-with-an-implicit-return-암시적으로-반환하는-함수) 와 [Shorthand Getter Declaration (획득자 선언의 줄임 표현)]({% post_url 2020-05-30-Properties %}#shorthand-getter-declaration-획득자-선언의-줄임-표현) 부분을 추가함.
* 타입에서 첨자 연산을 사용하는 것에 대한 정보를 [Type Subscripts (타입 첨자 연산)]({% post_url 2020-03-30-Subscripts %}#type-subscripts-타입-첨자-연산) 부분에 추가함.
* [Enumeration Case Pattern (열거체 case 값 패턴)]({% post_url 2020-08-25-Patterns %}#enumeration-case-pattern-열거체-case-값-패턴) 부분을 갱신했으며, 이제 '열거체 case 값 패턴' 도 옵셔널 값과 일치할 수 있음.
* [Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)]({% post_url 2016-01-23-Initialization %}#memberwise-initializers-for-structure-types-구조체-타입을-위한-멤버-초기자) 부분을 갱신했으며, 이제 기본 값을 가진 매개 변수에 대해서 '멤버 초기자 (memberwise initializers)' 도 매개 변수의 생략을 지원함.
* 실행 시간에 '키 경로 (key path)' 로 찾아 가는 동적 멤버에 대한 정보를 [dynamicMemberLookup (동적으로 멤버 찾아보기)]({% post_url 2020-08-14-Attributes %}#dynamicmemberlookup-동적으로-멤버-찾아보기) 부분에 추가함.
* [Conditional Compilation Block (조건부 컴파일 블럭)]({% post_url 2020-08-20-Statements %}#conditional-compilation-block-조건부-컴파일-블럭) 에 있는 '대상 환경 (target environment)' 목록에 `macCatalyst` 를 추가함.
* [Self Type ('Self' 타입)]({% post_url 2020-02-20-Types %}#self-type-self-타입) 부분을 갱신했으며, 이제 `Self` 는 현재의 클래스, 구조체, 또는 열거체 선언에서 도입한 타입을 참조하기 위해 사용할 수 있음.

#### 2019-03-25

* 스위프트 5.0 에서 갱신한 것.
* [Extended String Delimiters (확장된 문자열 구분자)]({% post_url 2016-05-29-Strings-and-Characters %}#extended-string-delimiters-확장된-문자열-구분자) 부분을 추가했으며 '확장된 문자열 구분자 (extended string delimiters)' 에 대한 정보를 가진 [String Literals (문자열 글자 값)]({% post_url 2020-07-28-Lexical-Structure %}#string-literals-문자열-글자-값) 부분을 갱신함.
* `dynamicCallable` 특성을 사용하여 함수처럼 동적으로 호출하는 인스턴스에 대한 정보를 가진 [dynamicCallable (동적으로 호출 가능한)]({% post_url 2020-08-14-Attributes %}#dynamiccallable-동적으로-호출-가능한) 부분을 추가함.
* 'switch' 문에 있는 미래의 열거체 'case 값' 을 처리하기 위하여 `unknown` 이라는 'switch 문의 case 절' 특성을 사용하는 것에 대한 정보를 가진 [unknown (알려지지 않은)]({% post_url 2020-08-14-Attributes %}#unknown-알려지지-않은) 과 [Switching Over Future Enumeration Cases (미래의 '열거체 case 값' 에 대해 전환 (switching) 하기)]({% post_url 2020-08-20-Statements %}#switching-over-future-enumeration-cases-미래의-열거체-case-값에-대해-전환-switching-하기) 부분을 추가함.
* '자기 식별 키 경로 (identity key path; `\.self`)' 에 대한 정보를 [Key-Path Expression (키-경로 표현식)]({% post_url 2020-08-19-Expressions %}#key-path-expression-키-경로-표현식) 부분에 추가함.
* '플랫폼 조건 (platform conditions)' 에서 '보다 작음 연산자 (less than operator; `<`)' 를 사용하는 것에 대한 정보를 [Conditional Compilation Block (조건부 컴파일 블럭)]({% post_url 2020-08-20-Statements %}#conditional-compilation-block-조건부-컴파일-블럭) 부분에 추가함.

#### 2018-09-17

* 스위프트 4.2 에서 갱신한 것.
* 열거체의 모든 'case 값' 에 접근하는 것에 대한 정보를 [Iterating over Enumeration Cases (열거체 case 값들에 동작 반복시키기)]({% post_url 2020-06-13-Enumerations %}#iterating-over-enumeration-cases-열거체-case-값들에-동작-반복시키기) 부분에 추가함.
* `#error` 와 `#warning` 에 대한 정보를 [Compile-Time Diagnostic Statement (컴파일-시간 진단문)]({% post_url 2020-08-20-Statements %}#compile-time-diagnostic-statement-컴파일-시간-진단문) 부분에 추가함.
* '인라이닝 (inlining)' 에 대한 정보를 [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 부분 밑의 `inlinable` 과 `usableFromInline` 특성에 추가함.
* 실행 시간에 이름으로 찾아 가는 멤버에 대한 정보를 [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 부분 밑의 `dynamicMemberLookup` 특성에 추가함.
* `requires_stored_property_inits` 과 `warn_unqualified_access` 특성에 대한 정보를 [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 부분에 추가함.
* 사용하고 있는 스위프트 컴파일러 버전에 따라 조건부로 코드를 컴파일하는 방법에 대한 정보를 [Conditional Compilation Block (조건부 컴파일 블럭)]({% post_url 2020-08-20-Statements %}#conditional-compilation-block-조건부-컴파일-블럭) 부분에 추가함.
* `#dsohandle` 에 대한 정보를 [Literal Expression (글자 값 표현식)]({% post_url 2020-08-19-Expressions %}#literal-expression-글자-값-표현식) 부분에 추가함.

#### 2018-03-29

* 스위프트 4.1 에서 갱신한 것.
* '같음 비교 연산자 (equivalence operators)' 의 통합된 구현에 대한 정보를 [Equivalence Operators (같음 비교 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#equivalence-operators-같음-비교-연산자) 부분에 추가함.
* '조건부 프로토콜 준수성 (conditional protocol conformance)' 에 대한 정보를 [Declarations (선언)]({% post_url 2020-08-15-Declarations %}) 장의 [Extension Declaration (익스텐션 선언)]({% post_url 2020-08-15-Declarations %}#extension-declaration-익스텐션-선언) 부분과, [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 장의 [Conditionally Conforming to a Protocol (조건에 따라 프로토콜 준수하기)]({% post_url 2016-03-03-Protocols %}#conditionally-conforming-to-a-protocol-조건에-따라-프로토콜-준수하기) 부분에, 추가함.
* '재귀적인 프로토콜 구속 조건 (recursive protocol constraints)' 에 대한 정보를 [Using a Protocol in Its Associated Type's Constraints (자신의 '결합 타입' 구속 조건에서 프로토콜 사용하기)]({% post_url 2020-02-29-Generics %}#using-a-protocol-in-its-associated-types-constraints-자신의-결합-타입-구속-조건에서-프로토콜-사용하기) 부분에 추가함.
* `canImport()` 와 `targetEnvironment()` '플랫폼 조건 (platform conditions)' 에 대한 정보를 [Conditional Compilation Block (조건부 컴파일 블럭)]({% post_url 2020-08-20-Statements %}#conditional-compilation-block-조건부-컴파일-블럭) 에 추가함.

#### 2017-12-04

* 스위프트 4.0.3 에서 갱신한 것.
* [Key-Path Expression (키-경로 표현식)]({% post_url 2020-08-19-Expressions %}#key-path-expression-키-경로-표현식) 부분을 갱신했으며, 이제 '키 경로 (key paths)' 가 '첨자 연산 성분 (subscript components)' 을 지원함.

#### 2017-09-19

* 스위프트 4.0 에서 갱신한 것.
* 메모리에 대한 '독점적인 접근 (exclusive access)' 에 대한 정보를 [Memory Safety (메모리 안전성)]({% post_url 2020-04-07-Memory-Safety %}) 장에 추가함.
* [Associated Types with a Generic Where Clause ('일반화 where 절' 을 가진 결합 타입)]({% post_url 2020-02-29-Generics %}#associated-types-with-a-generic-where-clause-일반화-where-절-을-가진-결합-타입) 부분을 추가했으며, 이제 '일반화 (generic) `where` 절' 을 사용하여 '결합 타입' 을 구속할 수 있음.
* '여러 줄짜리 문자열 글자 값 (multiline string literal)' 에 대한 정보를 [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) 장의 [String Literals (문자열 글자 값)]({% post_url 2016-05-29-Strings-and-Characters %}#string-literals-문자열-글자-값) 부분과, [Lexical Structure (어휘 구조)]({% post_url 2020-07-28-Lexical-Structure %}) 장의 [String Literals (문자열 글자 값)]({% post_url 2020-07-28-Lexical-Structure %}#string-literals-문자열-글자-값) 부분에, 추가함.
* [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 에 있는 `objc` 특성에 대한 논의를 갱신했으며, 이제 이 특성의 추론은 더 적은 곳에서 이뤄짐.
* [Generic Subscripts (일반화 첨자 연산)]({% post_url 2020-02-29-Generics %}#generic-subscripts-일반화-첨자-연산) 부분을 추가했으며, 이제 첨자 연산도 '일반화 (generic)' 가 될 수 있음.
* [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 장의 [Protocol Composition (프로토콜 합성)]({% post_url 2016-03-03-Protocols %}#protocol-composition-프로토콜-합성) 부분과, [Types (타입)]({% post_url 2020-02-20-Types %}) 장의 [Protocol Composition Type (프로토콜 합성 타입)]({% post_url 2020-02-20-Types %}#protocol-composition-type-프로토콜-합성-타입) 부분에 있는 논의를 갱신했으며, 이제 '프로토콜 합성 타입 (protocol composition types)' 은 '상위 클래스 필수 조건 (superclass requirement)' 을 가질 수 있음.
* [Extension Declaration (익스텐션 선언)]({% post_url 2020-08-15-Declarations %}#extension-declaration-익스텐션-선언) 에 있는 '프로토콜 익스텐션 (protocol extensions)' 에 대한 논의를 갱신했으며, 이제 `final` 은 여기서 허용되지 않음.
* '선행 조건문 (preconditions)' 과 '치명적인 에러 (fatal errors)' 에 대한 정보를 [Assertions and Preconditions (단언문과 선행 조건문)]({% post_url 2016-04-24-The-Basics %}#assertions-and-preconditions-단언문과-선행-조건문) 부분에 추가함.

#### 2017-03-27

* 스위프트 3.1 에서 갱신한 것.
* '필수 조건 (requirements)' 을 포함한 '익스텐션 (extensions)' 에 대한 정보가 있는 [Extensions with a Generic Where Clause ('일반화 where 절' 을 가진 익스텐션)]({% post_url 2020-02-29-Generics %}#extensions-with-a-generic-where-clause-일반화-where-절을-가진-익스텐션) 부분을 추가함.
* '범위 (range)' 에 동작을 반복시키는 것에 대한 예제를 [For-In Loops (For-In 반복문)]({% post_url 2020-06-10-Control-Flow %}#for-in-loops-for-in-반복문) 부분에 추가함.
* 실패 가능한 수치 변환에 대한 예제를 [Failable Initializers (실패 가능한 초기자)]({% post_url 2016-01-23-Initialization %}#failable-initializers-실패-가능한-초기자) 부분에 추가함.
* `available` 특성을 스위프트 언어 버전에 사용하는 것에 대하여 [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 부분에 정보를 추가함.
* '인자 이름표 (argument labels)' 는 함수 타입을 작성할 때는 허용되지 않는다는 것에 주목하기 위해 [Function Type (함수 타입)]({% post_url 2020-02-20-Types %}#function-type-함수-타입) 부분에 있는 논의를 갱신함.
* [Conditional Compilation Block (조건부 컴파일 블럭)]({% post_url 2020-08-20-Statements %}#conditional-compilation-block-조건부-컴파일-블럭) 부분에 있는 '스위프트 언어의 버전 번호' 에 대한 논의를 갱신했으며, 이제 선택적인 '땜빵 번호 (patch number)' 를 허용합니다.
* [Function Type (함수 타입)]({% post_url 2020-02-20-Types %}#function-type-함수-타입) 부분에 있는 논의를 갱신했으며, 이제 스위프트는 다중 매개 변수를 취하는 함수와 튜플 타입인 단일 매개 변수를 취하는 함수를 서로 구별함.
* [Expressions (표현식)]({% post_url 2020-08-19-Expressions %}) 장에서 '동적 타입 표현식 (Dynamic Type Expression)' 부분을 제거했으며, 이제 `type(of:)` 는 스위프트 표준 라이브러리 함수임.

#### 2016-10-27

* 스위프트 3.0.1 에서 갱신한 것.
* [Automatic Reference Counting (자동 참조 카운팅)]({% post_url 2020-06-30-Automatic-Reference-Counting %}) 장에 있는 '약한 참조 (weak references)' 와 '소유하지 않는 참조 (unowned references)' 에 대한 논의를 갱신함.
* [Declaration Modifiers (선언 수정자)]({% post_url 2020-08-15-Declarations %}#declaration-modifiers-선언-수정자) 부분에 있는 `unowned`, `unowned(safe)`, 및 `unowned(unsafe)` 선언 수정자에 대한 정보를 추가함.
* `Any` 타입인 값이 예상될 때 옵셔널 값을 사용하는 것에 대하여 [Type Casting for Any and AnyObject ('Any' 와 'AnyObject' 를 위한 타입 변환)]({% post_url 2020-04-01-Type-Casting %}#type-casting-for-any-and-anyobject-any-와-anyobject-를-위한-타입-변환) 에 기록을 추가함.
* '괄호 표현식 (parenthesized expressions)' 과 '튜플 표현식 (tuple expressions)' 에 대한 논의를 구분하기 위하여 [Expressions (표현식)]({% post_url 2020-08-19-Expressions %}) 장을 갱신함.

#### 2016-09-13

* 스위프트 3.0 에서 갱신한 것.
* 모든 매개 변수는 기본적으로 '인자 이름표 (arguement label)' 을 가진다는 것에 주목하기 위해 [Functions (함수)]({% post_url 2020-06-02-Functions %}) 장과 [Function Declaration (함수 선언)]({% post_url 2020-08-15-Declarations %}#function-declaration-함수-선언) 부분에 있는 함수에 대한 논의를 갱신함.
* [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) 장에 있는 연산자에 대한 논의를 갱신했으며, 이제 이를 '전역 함수 (global functions)' 대신 '타입 메소드 (type methods)' 로 구현함.
* `open` 과 `fileprivate` 접근-수준 수정자에 대한 정보를 [Access Control (접근 제어)]({% post_url 2020-04-28-Access-Control %}) 장에 추가함.
* `inout` 이 매개 변수의 이름 앞이 아니라 매개 변수의 타입 앞에 나타남에 주목하기 위해 [Function Declaration (함수 선언)]({% post_url 2020-08-15-Declarations %}#function-declaration-함수-선언) 부분의 논의를 갱신함.
* [Escaping Closures (벗어나는 클로저)]({% post_url 2020-03-03-Closures %}#escaping-closures-벗어나는-클로저) 와 [Autoclosures (자동 클로저)]({% post_url 2020-03-03-Closures %}#autoclosures-자동-클로저) 부분 그리고 [Attributes (특성)]({% post_url 2020-08-14-Attributes %}) 장에 있는 `@noescape` 와 `@autoclosure` 에 대한 논의를 갱신했으며 이제 이들은, '선언 특성' 이 아니라, '타입 특성' 임.
* '연산자 우선 순위 그룹 (operator precedence groups)' 에 대한 정보를 [Advanced Operators (고급 연산자)]({% post_url 2020-05-11-Advanced-Operators %}) 장의 [Precedence for Custom Infix Operators (사용자 중위 연산자에 대한 우선 순위)]({% post_url 2020-05-11-Advanced-Operators %}#precedence-for-custom-infix-operators-사용자-중위-연산자에-대한-우선-순위) 부분과, [Declarations (선언)]({% post_url 2020-08-15-Declarations %}) 장의 [Precedence Group Declaration (우선 순위 그룹 선언)]({% post_url 2020-08-15-Declarations %}#precedence-group-declaration-우선-순위-그룹-선언) 부분에, 추가함.
* 'OS X' 대신 'macOS' 를, `ErrorProtocol` 대신 `Error` 를, 그리고 `StringLiteralConvertible` 대신 `ExpressibleByStringLiteral` 같은 프로토콜 이름을 사용하도록 전체에 걸쳐서 논의를 갱신함.
* [Generics (일반화)]({% post_url 2020-02-29-Generics %}) 장의 [Generic Where Clauses (일반화 'where' 절)]({% post_url 2020-02-29-Generics %}#generic-where-clauses-일반화-where-절) 부분과 [Generic Parameters and Arguments (일반화된 매개 변수와 일반화된 인자)]({% post_url 2017-03-16-Generic-Parameters-and-Arguments %}) 장에 있는 논의를 갱신했으며, 이제 '일반화된 (generic) `where` 절' 은 선언의 끝에 작성함.
* [Escaping Closures (벗어나는 클로저)]({% post_url 2020-03-03-Closures %}#escaping-closures-벗어나는-클로저) 부분에 있는 논의를 갱신했으며, 이제 클로저는 '벗어나지 않는 (nonescaping)' 것이 기본임.
* [The Basics (기초)]({% post_url 2016-04-24-The-Basics %}) 장의 [Optional Binding (옵셔널 연결)]({% post_url 2016-04-24-The-Basics %}#optional-binding-옵셔널-연결) 부분과 [Statements (구문)]({% post_url 2020-08-20-Statements %}) 장의 [While Statement ('while' 문)]({% post_url 2020-08-20-Statements %}#while-statement-while-문) 부분에 있는 논의를 갱신했으며, 이제 `if`, `while`, 그리고 `guard` 문은 `where` 절 없이 쉼표로-구분된 조건 목록을 사용함.
* '다중 유형 (multiple patterns)' 을 가지는 'switch 문 case 절' 에 대한 정보를 [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 장의 [Switch (Switch 문)]({% post_url 2020-06-10-Control-Flow %}#switch-switch-문) 부분과 [Statements (구문)]({% post_url 2020-08-20-Statements %}) 장의 [Switch Statement ('switch' 문)]({% post_url 2020-08-20-Statements %}#switch-statement-switch-문) 부분에 추가함.
* [Function Type (함수 타입)]({% post_url 2020-02-20-Types %}#function-type-함수-타입) 부분에 있는 함수 타입에 대한 논의를 갱신했으며 이제 함수 인자 이름표는 더 이상 함수 타입의 일부가 아님.
* 새로운 구문 표현인 `Protocol1 & Protocol2` 을 사용하기 위해 [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 장의 [Protocol Composition (프로토콜 합성)]({% post_url 2016-03-03-Protocols %}#protocol-composition-프로토콜-합성) 부분과 [Types (타입)]({% post_url 2020-02-20-Types %}) 장의 [Protocol Composition Type (프로토콜 합성 타입)]({% post_url 2020-02-20-Types %}#protocol-composition-type-프로토콜-합성-타입) 부분에 있는 '프로토콜 합성 타입 (protocol composition types)' 에 대한 논의를 갱신함.
* '동적 타입 표현식' 에 대해서 새로운 구문 표현인 `type(of:)` 를 사용하기 위해 '동적 타입 표현식 (Dynamic Type Expression)'[^dynamic-type-expression] 부분에 있는 논의를 갱신함.
* [Line Control Statement (라인 제어문)]({% post_url 2020-08-20-Statements %}#line-control-statement-라인-제어문) 에서 `#sourceLocation(file:line:)` 구문 표현을 사용하기 위해 '라인 제어 구문' 에 대한 논의를 갱신함.
* 새로운 타입인 `Never` 를 사용하기 위해 [Functions that Never Return (절대 반환하지 않는 함수)]({% post_url 2020-08-15-Declarations %}#functions-that-never-return-절대-반환하지-않는-함수) 에 있는 논의를 갱신함.
* '플레이그라운드 글자 값 (playground literals)' 에 대한 정보를 [Literal Expression (글자 값 표현식)]({% post_url 2020-08-19-Expressions %}#literal-expression-글자-값-표현식) 부분에 추가함.
* '벗어나지 않는 클로저 (nonescaping closures)' 만 '입-출력 매개 변수 (in-out parameters)' 를 붙잡을 수 있다는 것에 주목하기 위해 [In-Out Parameters (입-출력 매개 변수)]({% post_url 2020-08-15-Declarations %}#in-out-parameters-입-출력-매개-변수) 부분에 있는 논의를 갱신함
* [Default Parameter Values (기본 매개 변수 값)]({% post_url 2020-06-02-Functions %}#default-parameter-values-기본-매개-변수-값) 부분에 있는 '기본 설정 매개 변수' 에 대한 논의를 갱신했으며, 이제 이들을 함수 호출에서 재정렬할 수 있음.
* [Attributes (특성)]({% post_url 2020-08-14-Attributes %}) 장에서 콜론을 사용하도록 '특성 인자 (attribute arguments)' 를 갱신함.
* '다시 던지는 함수 (rethrowing function)' 의 'catch' 블럭 내에서 에러를 던지는 것에 대한 정보를 [Rethrowing Functions and Methods (다시 던지는 함수와 메소드)]({% post_url 2020-08-15-Declarations %}#rethrowing-functions-and-methods-다시-던지는-함수와-메소드) 부분에 추가함.
* 오브젝티브-C 에 있는 '획득자 (getter)' 와 '설정자 (setter)' 의 '선택자 (selector)' 에 접근하는 것에 대한 정보를 [Selector Expression (선택자 표현식)]({% post_url 2020-08-19-Expressions %}#selector-expression-선택자-표현식) 부분에 추가함.
* '일반화된 타입 별명 (generic type aliases)' 과 프로토콜 내에서 '타입 별명 (type aliases)' 을 사용하는 것에 대해서 [Type Alias Declaration (타입 별명 선언)]({% post_url 2020-08-15-Declarations %}#type-alias-declaration-타입-별명-선언) 부분에 정보를 추가함.
* '매개 변수 타입' 주위에는 괄호가 필수라는 것에 주목하기 위해 [Function Type (함수 타입)]({% post_url 2020-02-20-Types %}#function-type-함수-타입) 부분에 있는 '함수 타입' 에 대한 논의를 갱신함.
* `@IBAction`, `@IBOutlet`, 그리고 `@NSManaged` 특성은 `@objc` 특성을 내포하고 있음에 주목하기 위해 [Attributes (특성)]({% post_url 2020-08-14-Attributes %}) 장을 갱신함
* `@GKInspectable` 특성에 대한 정보를 [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 부분에 추가함.
* '옵셔널 프로토콜 필수 조건 (optional protocol requirements)' 은 오브젝티브-C 와 상호 호환되는 코드에서만 사용된다는 것을 분명하게 하기 위해 [Optional Protocol Requirements (옵셔널 프로토콜 필수 조건)]({% post_url 2016-03-03-Protocols %}#optional-protocol-requirements-옵셔널-프로토콜-필수-조건) 부분에 있는 논의를 갱신함.
* 함수 매개 변수에서 `let` 을 명시적으로 사용하는 것에 대한 논의를 [Function Declaration (함수 선언)]({% post_url 2020-08-15-Declarations %}#function-declaration-함수-선언) 부분에서 제거함.
* `Boolean` 프로토콜에 대한 논의를 [Statements (구문)]({% post_url 2020-08-20-Statements %}) 장에서 제거했으며, 이제 이 프로토콜은 스위프트 표준 라이브러리에서 제거된 것임.
* [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 부분에 있는 `@NSApplicatinMain` 특성에 대한 논의를 올바르게 바로 잡음.

#### 2016-03-21

* 스위프트 2.2 에서 갱신한 것.
* 사용중인 스위프트 버전에 따라 조건부로 코드를 컴파일하는 방법에 대한 정보를 [Conditional Compilation Block (조건부 컴파일 블럭)]({% post_url 2020-08-20-Statements %}#conditional-compilation-block-조건부-컴파일-블럭) 부분에 추가함.
* 이름이 다른 것이라곤 인자 이름뿐인 메소드와 초기자를 구별하는 방법에 대한 정보를 [Explicit Member Expression (명시적인 멤버 표현식)]({% post_url 2020-08-19-Expressions %}#explicit-member-expression-명시적인-멤버-표현식) 부분에 추가함.
* 오브젝티브-C '선택자 (selectors)' 를 위한 `#selector` 구문 표현에 대한 정보를 [Selector Expression (선택자 표현식)]({% post_url 2020-08-19-Expressions %}#selector-expression-선택자-표현식) 부분에 추가함.
* [Associated Types (결합 타입)]({% post_url 2020-02-29-Generics %}#associated-types-결합-타입) 과 [Protocol Associated Type Declaration (프로토콜의 결합 타입 선언)]({% post_url 2020-08-15-Declarations %}#protocol-associated-type-declaration-프로토콜의-결합-타입-선언) 부분에서 `associatedtype` 키워드를 사용하기 위한 '결합 타입 (associated types)' 에 대한 논의를 갱신함.
* [Failable Initializers (실패 가능한 초기자)]({% post_url 2016-01-23-Initialization %}#failable-initializers-실패-가능한-초기자) 부분에서 인스턴스가 온전히 초기화되기 전에 `nil` 을 반환하는 초기자에 대한 정보를 갱신함.
* '튜플 (tuples)' 을 비교하는 것에 대한 정보를 [Comparison Operators (비교 연산자)]({% post_url 2016-04-27-Basic-Operators %}#comparison-operators-비교-연산자) 부분에 추가함.
* 키워드를 외부 매개 변수 이름으로 사용하는 것에 대한 정보를 [Keywords and Punctuation (키워드와 문장 부호)]({% post_url 2020-07-28-Lexical-Structure %}#keywords-and-punctuation-키워드와-문장-부호) 부분에 추가함.
* 열거체와 열거체 'case 값' 이 `@objc` 특성을 사용할 수 있다는 것에 주목하기 위해 [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 부분에 있는 논의를 갱신함.
* '점 (dot)' 을 담고 있는 사용자 정의 연산자에 대한 논의를 가지고 있는 [Operators (연산자)]({% post_url 2020-07-28-Lexical-Structure %}#operators-연산자) 부분을 갱신함.
* [Rethrowing Functions and Methods (다시 던지는 함수와 메소드)]({% post_url 2020-08-15-Declarations %}#rethrowing-functions-and-methods-다시-던지는-함수와-메소드) 부분에 '다시 던지는 함수 (rethrowing functions)' 는 직접 에러를 던질 수 없다는 기록을 추가함.
* [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 부분에 속성을 '입-출력 (in-out) 매개 변수' 로 전달할 때 호출되는 '속성 관찰자 (property observers)' 에 대한 기록을 추가함.
* '에러 처리 (error handling)' 에 대한 부분을 [A Swift Tour (스위프트 둘러보기)]({% post_url 2016-04-17-A-Swift-Tour %}) 장에 추가함.
* 할당 해제 과장을 더 명확하게 보여주기 위해 [Weak References (약한 참조)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#weak-references-약한-참조) 부분에 있는 그림을 갱신함.
* C-언어 스타일의 `for` 반복문과, `++` 접두사 및 접미사 연산자, 그리고 `--` 접두사 및 접미사 연산자에 대한 논의를 제거함.
* '변수인 함수 인자 (variable function arguments)'[^variable-function-arguments] 그리고 '커리 함수 (curried functions)' 를 위한 특수한 구문 표현에 대한 논의를 제거함.

#### 2015-10-20

* 스위프트 2.1 에서 갱신한 것.
* [String Interpolation (문자열 보간법)]({% post_url 2016-05-29-Strings-and-Characters %}#string-interpolation-문자열-보간법) 과 [String Literals (문자열 글자 값)]({% post_url 2020-07-28-Lexical-Structure %}#string-literals-문자열-글자-값) 부분을 갱신했으며 이제 '문자열 보간법' 은 '문자열 글자 값' 을 담을 수 있음.
* `@noescape` 특성에 대한 정보를 가진 [Escaping Closures (벗어나는 클로저)]({% post_url 2020-03-03-Closures %}#escaping-closures-벗어나는-클로저) 부분을 추가함.
* 'tvOS' 에 대한 정보를 가진 [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 과 [Conditional Compilation Block (조건부 컴파일 블럭)]({% post_url 2020-08-20-Statements %}#conditional-compilation-block-조건부-컴파일-블럭) 부분을 갱신함.
* '입-출력 매개 변수 (in-out parameters)' 의 작동 방식에 대한 정보를 [In-Out Parameters (입-출력 매개 변수)]({% post_url 2020-08-15-Declarations %}#in-out-parameters-입-출력-매개-변수) 부분에 추가함.
* '클로저가 붙잡을 목록 (closure capture lists)' 에서 지정한 값을 붙잡는 방법에 대하여 [Capture Lists (붙잡을 목록)]({% post_url 2020-08-19-Expressions %}#capture-lists-붙잡을-목록) 부분에 정보를 추가함.
* '옵셔널 연쇄 (optional chaining)' 를 통한 할당이 작동하는 방법을 분명하게 밝기기 위해 [Accessing Properties Through Optional Chaining (옵셔널 연쇄를 통해 속성에 접근하기)]({% post_url 2020-06-17-Optional-Chaining %}#accessing-properties-through-optional-chaining-옵셔널-연쇄를-통해-속성에-접근하기) 부분을 갱신함.
* [Autoclosures (자동 클로저)]({% post_url 2020-03-03-Closures %}#autoclosures-자동-클로저) 부분에 있는 '자동 클로저 (autoclosures)' 에 대한 논의를 개선함.
* `??` 연산자를 사용하는 것에 대한 예제를 [A Swift Tour (스위프트 둘러보기)]({% post_url 2016-04-17-A-Swift-Tour %}) 장에 추가함.

#### 2015-09-16

* 스위프트 2.0 에서 갱신한 것.
* '에러 처리 (error handling)' 에 대한 정보를 [Error Handling (에러 처리)]({% post_url 2020-05-16-Error-Handling %}) 장과, [Do Statement ('do' 문)]({% post_url 2020-08-20-Statements %}#do-statement-do-문) 부분, [Throw Statement ('throw' 문)]({% post_url 2020-08-20-Statements %}#throw-statement-throw-문) 부분, [Defer Statement ('defer' 문)]({% post_url 2020-08-20-Statements %}#defer-statement-defer-문) 부분, 그리고 [Try Operator ('try' 연산자)]({% post_url 2020-08-19-Expressions %}#try-operator-try-연산자) 부분에 추가함.
* [Representing and Throwing Errors (에러 표현하기와 던지기)]({% post_url 2020-05-16-Error-Handling %}#representing-and-throwing-errors-에러-표현하기와-던지기) 부분을 갱신했으며, 이제 모든 타입이 `ErrorType` 프로토콜을 준수할 수 있음.
* 새롭게 `try?` 키워드에 대한 정보를 [Converting Errors to Optional Values (에러를 '옵셔널 값' 으로 변환하기)]({% post_url 2020-05-16-Error-Handling %}#converting-errors-to-optional-values-에러를-옵셔널-값-으로-변환하기) 부분에 추가함.
* '재귀적인 열거체 (recursive enumerations)' 에 대한 정보를 [Enumerations (열거체)]({% post_url 2020-06-13-Enumerations %}) 장의 [Recursive Enumerations (재귀적인 열거체)]({% post_url 2020-06-13-Enumerations %}#recursive-enumerations-재귀적인-열거체) 부분과 [Declarations (선언)]({% post_url 2020-08-15-Declarations %}) 장의 [Enumerations with Cases of Any Type (어떤 타입이든 되는 'case 값' 을 가진 열거체)]({% post_url 2020-08-15-Declarations %}#enumerations-with-cases-of-any-type-어떤-타입이든-되는-case-값-을-가진-열거체) 부분에 추가함.
* 'API 사용 가능성 (API avaiability)' 에 대한 정보를 [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 장의 [Checking API Availability (API 사용 가능성 검사하기)]({% post_url 2020-06-10-Control-Flow %}#checking-api-availability-api-사용-가능성-검사하기) 부분과 [Statements (구문)]({% post_url 2020-08-20-Statements %}) 장의 [Availability Condition (사용 가능성 조건)]({% post_url 2020-08-20-Statements %}#availability-condition-사용-가능성-조건) 부분에 추가함.
* 새롭게 `guard` 문에 대한 정보를 [Control Flow (제어 흐름)]({% post_url 2020-06-10-Control-Flow %}) 장의 [Early Exit (조기 탈출문)]({% post_url 2020-06-10-Control-Flow %}#early-exit-조기-탈출문) 부분과 [Statements (구문)]({% post_url 2020-08-20-Statements %}) 장의 [Guard Statement ('guard' 문)]({% post_url 2020-08-20-Statements %}#guard-statement-guard-문) 부분에 추가함.
* '프로토콜 익스텐션 (protocol extensions)' 에 대한 정보를 [Protocols (프로토콜; 규약)]({% post_url 2016-03-03-Protocols %}) 장의 [Protocol Extensions (프로토콜 익스텐션; 규약 확장)]({% post_url 2016-03-03-Protocols %}#protocol-extensions-프로토콜-익스텐션-규약-확장) 부분에 추가함.
* '단위 테스트 (unit testing)' 을 위한 '접근 제어 (access control)' 에 대한 정보를 [Access Control (접근 제어)]({% post_url 2020-04-28-Access-Control %}) 장의 [Access Levels for Unit Test Targets (단위 테스트 대상을 위한 접근 수준)]({% post_url 2020-04-28-Access-Control %}#access-levels-for-unit-test-targets-단위-테스트-대상을-위한-접근-수준) 부분에 추가함.
* 새롭게 '옵셔널 패턴 (optional pattern; 옵셔널 유형)' 에 대한 정보를 [Patterns (패턴; 유형)]({% post_url 2020-08-25-Patterns %}) 장의 [Optional Pattern (옵셔널 패턴)]({% post_url 2020-08-25-Patterns %}#optional-pattern-옵셔널-패턴) 부분에 추가함.
* `repeat`-`while` 반복문에 대한 정보를 가지고 [Repeat-While (Repeat-While 문)]({% post_url 2020-06-10-Control-Flow %}#repeat-while-repeat-while-문) 부분을 갱신함.
* [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) 장을 갱신했으며, 이제 `String` 은 더 이상 스위프트 표준 라이브러리의 `CollectionType` 프로토콜을 준수하지 않음.
* 스위프트 표준 라이브러리의 새로운 `print(_:separator:terminator)` 함수에 대한 정보를 [Printing Constants and Variables (상수와 변수 인쇄하기)]({% post_url 2016-04-24-The-Basics %}#printing-constants-and-variables-상수와-변수-인쇄하기) 부분에 추가함.
* `String` 원시 값을 가지는 열거체 'case 값' 의 작동 방식에 대한 정보를 [Enumerations (열거체)]({% post_url 2020-06-13-Enumerations %}) 장의 [Implicitly Assigned Raw Values (암시적으로 할당되는 원시 값)]({% post_url 2020-06-13-Enumerations %}#implicitly-assigned-raw-values-암시적으로-할당되는-원시-값) 부분과 [Declarations (선언)]({% post_url 2020-08-15-Declarations %}) 장의 [Enumerations with Cases of a Raw-Value Type (원시-값 타입의 'case 값' 을 가지는 열거체)]({% post_url 2020-08-15-Declarations %}#enumerations-with-cases-of-a-raw-value-type-원시-값-타입의-case-값-을-가지는-열거체) 부분에 추가함.
* `@autoclosure` 특성에 대한 정보를-그의 `@autoclosure(escaping)` 형식을 포함하여-[Autoclosures (자동 클로저)]({% post_url 2020-03-03-Closures %}#autoclosures-자동-클로저) 부분에 추가함.
* `@available` 과 `@warn_unused_result` 특성에 대한 정보를 가지고 [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 부분을 갱신함.
* `@convention` 특성에 대한 정보를 가지고 [Type Attributes (타입 특성)]({% post_url 2020-08-14-Attributes %}#type-attributes-타입-특성) 부분을 갱신함.
* `where` 절로 '다중 옵셔널 연결 (multiple optional bindings)' 을 사용하는 예제를 [Optional Binding (옵셔널 연결)]({% post_url 2016-04-24-The-Basics %}#optional-binding-옵셔널-연결) 부분에 추가함.
* `+` 연산자를 사용하여 문자열 글자 값을 서로 잇는 것이 컴파일 시간에 이루진다는 것에 대하여 [String Literals (문자열 글자 값)]({% post_url 2020-07-28-Lexical-Structure %}#string-literals-문자열-글자-값) 부분에 정보를 추가함.
* '메타 타입 (metatype)' 값을 비교하고 이를 사용하여 초기자 표현식으로 인스턴스를 생성하는 것에 대하여 [Metatype Type (메타타입 타입)]({% post_url 2020-02-20-Types %}#metatype-type-메타타입-타입) 부분에 정보를 추가함.
* 사용자-정의 단언문이 사용 불가능한 것이 언제인지에 대하여 [Debugging with Assertions (단언문으로 디버깅하기)]({% post_url 2016-04-24-The-Basics %}#debugging-with-assertions-단언문으로-디버깅하기) 부분에 기록을 추가함.
* [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 부분에 있는 `@NSManaged` 특성에 대한 논의를 갱신했으며, 이제 이 특성은 정해진 인스턴스 메소드에 적용할 수 있음.
* [Variadic Parameters (가변 매개 변수)]({% post_url 2020-06-02-Functions %}#variadic-parameters-가변-매개-변수) 부분을 갱신했으며, 이제 '가변 매개 변수' 는 함수 매개 변수 목록의 어떤 위치에서라도 선언할 수 있음.
* 상위 클래스 초기자의 결과를 '강제 포장 풀기 (force-unwrapping)' 하면 '실패하지 않는 초기자 (nonfailable initializer)' 가 '실패 가능한 초기자 (failable initializer)' 로 '위로 위임 (delegate up)' 할 수 있다는 것에 대하여 [Overriding a Failable Initializer (실패 가능한 초기자 재정의하기)]({% post_url 2016-01-23-Initialization %}#overriding-a-failable-initializer-실패-가능한-초기자-재정의하기) 부분에 정보를 추가함.
* '열거체 case 값 (enumeration cases)' 을 함수처럼 사용하는 것에 대한 정보를 [Enumerations with Cases of Any Type (어떤 타입이든 되는 'case 값' 을 가진 열거체)]({% post_url 2020-08-15-Declarations %}#enumerations-with-cases-of-any-type-어떤-타입이든-되는-case-값-을-가진-열거체) 부분에 추가함.
* 초기자를 명시적으로 참조하는 것에 대한 정보를 [Initializer Expression (초기자 표현식)]({% post_url 2020-08-19-Expressions %}#initializer-expression-초기자-표현식) 부분에 추가함.
* '제작 구성 (build configuration)' 과 '라인 제어문 (line control statements)' 에 대한 정보를 [Compiler Control Statements (컴파일러 제어문)]({% post_url 2020-08-20-Statements %}#compiler-control-statements-컴파일러-제어문) 부분에 추가함.
* '메타 타입 (metatype)' 값으로부터 클래스 인스턴스를 생성하는 것에 대하여 [Metatype Type (메타타입 타입)]({% post_url 2020-02-20-Types %}#metatype-type-메타타입-타입) 부분에 기록을 추가함.
* '약한 참조 (weak references)' 는 '캐싱 (caching)' 에 적합하지 않다는 것에 대하여 [Weak References (약한 참조)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#weak-references-약한-참조) 부분에 기록을 추가함.
* '저장 타입 속성 (stored type properties)' 은 '느긋하게 초기화된다 (lazily initialized)' 는 것을 언급하기 위해 [Type Properties (타입 속성)]({% post_url 2020-05-30-Properties %}#type-properties-타입-속성) 부분에 있는 기록을 갱신함.
* 변수와 상수가 클로저에서 붙잡히는 방법을 분명하게 밝히기 위해 [Capturing Values (값 붙잡기)]({% post_url 2020-03-03-Closures %}#capturing-values-값-붙잡기) 부분을 갱신함.
* 언제 `@objc` 특성을 클래스에 적용할 수 있는 지를 설명하기 위해 [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 부분을 갱신함.
* `throw` 문의 실행 성능에 대하여 [Handling Errors (에러 처리하기)]({% post_url 2020-05-16-Error-Handling %}#handling-errors-에러-처리하기) 부분에 기록을 추가함. [Do Statement ('do' 문)]({% post_url 2020-08-20-Statements %}#do-statement-do-문) 부분에 있는 `do` 문에 대하여 비슷한 정보를 추가함.
* 클래스, 구조체, 그리고 열거체에 대한 '저장 타입 속성' 및 '계산 타입 속성' 에 대한 정보를 가지고 [Type Properties (타입 속성)]({% post_url 2020-05-30-Properties %}#type-properties-타입-속성) 부분을 갱신함.
* '이름표 붙인 break 문 (labeled break statements)' 에 대한 정보를 가지고 [Break Statement ('break' 문)]({% post_url 2020-08-20-Statements %}#break-statement-break-문) 부분을 갱신함.
* `willSet` 과 `didSet` 관찰자의 작동 방식을 분명하게 밝히기 위해 [Property Observers (속성 관찰자)]({% post_url 2020-05-30-Properties %}#property-observers-속성-관찰자) 부분에 있는 기록을 갱신함.
* `private` 접근의 영역에 대한 정보를 가지고 [Access Levels (접근 수준)]({% post_url 2020-04-28-Access-Control %}#access-levels-접근-수준) 부분에 기록을 추가함.
* '쓰레기 수집 시스템 (garbage collected systems)' 과 'ARC' 간의 '약한 참조 (weak references)' 에 있는 차이점에 대하여 [Weak References (약한 참조)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#weak-references-약한-참조) 부분에 기록을 추가함.
* '유니코드 크기 값 (Unicode scalars)' 의 더 엄밀한 정의를 가지고 [Special Characters in String Literals (문자열 글자 값에 있는 특수 문자)]({% post_url 2016-05-29-Strings-and-Characters %}#special-characters-in-string-literals-문자열-글자-값에-있는-특수-문자) 부분을 갱신함.

#### 2015-04-08

* 스위프트 1.2 에서 갱신한 것.
* 스위프트는 이제 그 자체의 `Set` '집합체 (collection)' 타입을 가집니다. 더 많은 정보는, [Sets (셋)]({% post_url 2016-06-06-Collection-Types %}#sets-셋-집합) 를 참고하기 바랍니다.
* `@autoclosure` 는 이제, 매개 변수의 타입이 아니라, 매개 변수 선언의 특성입니다. 새로운 매개 변수 선언 특성인 `@noescape` 도 있습니다. 더 많은 정보는, [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 를 참고하기 바랍니다.
* '타입 메소드' 와 '타입 속성' 은 이제 `static` 키워드를 '선언 수정자' 로 사용합니다. 더 많은 정보는 [Type Variable Properties (타입 변수 속성)]({% post_url 2020-08-15-Declarations %}#type-variable-properties-타입-변수-속성) 을 참고하기 바랍니다.
* 스위프트는 이제 `as?` 와 `as!` 라는 '실패 가능한 내림 변환 연산자 (failable downcast operators)' 를 포함합니다. [Checking for Protocol Conformance (프로토콜 준수성 검사하기)]({% post_url 2016-03-03-Protocols %}#checking-for-protocol-conformance-프로토콜-준수성-검사하기) 를 참고하기 바랍니다.
* [String Indices (문자열 색인)]({% post_url 2016-05-29-Strings-and-Characters %}#string-indices-문자열-색인) 에 대하여 새로운 지침 부분을 추가함.
* [Overflow Operators (값 넘침 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#overflow-operators-값-넘침-연산자) 에서 '값 넘침 나누기 (overflow division; `&/`)' 와 '값 넘침 나머지 (overflow remainder; `&%`)' 연산자를 제거함.
* 상수 및 상수 속성 선언과 초기화에 대한 규칙을 갱신함. 더 많은 정보는, [Constant Declaration (상수 선언)]({% post_url 2020-08-15-Declarations %}#constant-declaration-상수-선언) 를 참고 바람.
* '문자열 글자 값 (string literals)' 에 있는 '유니코드 크기 값 (Unicode scalars)' 의 정의를 갱신함. [Special Characters in String Literals (문자열 글자 값에 있는 특수 문자)]({% post_url 2016-05-29-Strings-and-Characters %}#special-characters-in-string-literals-문자열-글자-값에-있는-특수-문자) 를 참고 바람.
* 시작 색인과 끝 색인이 같은 '반-열린 범위 (half-open range)' 는 비어 있을 것이라는 것에 주목하기 위해 [Range Operators (범위 연산자)]({% post_url 2016-04-27-Basic-Operators %}#range-operators-범위-연산자) 를 갱신함.
* 변수를 붙잡는 규칙을 분명히 밝히기 위해 [Closures Are Reference Types (클로저는 참조 타입입니다)]({% post_url 2020-03-03-Closures %}#closures-are-reference-types-클로저는-참조-타입입니다) 를 갱신함.
* 부호 있는 정수와 부호 없는 정수에 대한 '값 넘침' 작동 방식을 분명히 밝히기 위해 [Value Overflow (값 넘침)]({% post_url 2020-05-11-Advanced-Operators %}#value-overflow-값-넘침) 을 갱신함.
* 프로토콜 선언의 '영역 (scope)' 과 '멤버 (members; 구성원)' 을 분명히 밝히기 위해 [Protocol Declaration (프로토콜 선언)]({% post_url 2020-08-15-Declarations %}#protocol-declaration-프로토콜-선언) 을 갱신함.
* '클로저가 붙잡을 목록 (closure capture lists)' 에 있는 '약한 참조 (weak references)' 와 '소유하지 않는 참조 (unowned references)' 에 대한 구문 표현을 분명히 밝히기 위해 [Defining a Capture List (붙잡을 목록 정의하기)]({% post_url 2020-06-30-Automatic-Reference-Counting %}#defining-a-capture-list-붙잡을-목록-정의하기) 을 갱신함.
* 사용자 정의 연산자를 위해 지원되는 문자들, 가령 수학 연산자들, 잡다한 기호들, 그리고 '딩뱃 (dingbats)[^dingbats] 유니코드 블럭들', 에 대한 예제를 명시적으로 언급하기 위해 [Operators (연산자)]({% post_url 2020-07-28-Lexical-Structure %}#operators-연산자) 를 갱신함.
* 이제 지역 함수 영역에서는 상수를 초기화하지 않고도 선언할 수 있습니다. 맨 처음 사용하기 전에 설정 값을 반드시 가져야 합니다. 더 많은 정보는, [Constant Declaration (상수 선언)]({% post_url 2020-08-15-Declarations %}#constant-declaration-상수-선언) 를 참고하기 바랍니다.
* '초기자 (initializer)' 안에서, 상수 속성은 이제 값을 단 한번만 할당할 수 있습니다. 더 많은 정보는, [Assigning Constant Properties During Initialization (초기화하는 동안 상수 속성 할당하기)]({% post_url 2016-01-23-Initialization %}#assigning-constant-properties-during-initialization-초기화하는-동안-상수-속성-할당하기) 를 참고하기 바랍니다.
* '다중 옵셔널 연결 (multiple optional bindings)' 은 이제 쉼표로-구분된 할당 표현식 목록으로써 단일 `if` 문에 나타낼 수 있습니다. 더 많은 정보는, [Optional Binding (옵셔널 연결)]({% post_url 2016-04-24-The-Basics %}#optional-binding-옵셔널-연결) 을 참고하기 바랍니다.
* [Optional-Chaining Expression (옵셔널-연쇄 표현식)]({% post_url 2020-08-19-Expressions %}#optional-chaining-expression-옵셔널-연쇄-표현식) 은 반드시 '접미사 표현식 (postfix expression)' 내에 있어야 합니다.
* '프로토콜 변환 (protocol casts)' 은 더 이상 `@objc` 프로토콜로 제한되지 않습니다.
* 실행 시간에 실패할 수 있는 '타입 변환 (type casts)' 은 이제 `as?` 또는 `as!` 연산자를 사용하며, 실패하지 않는다고 보증한 '타입 변환' 은 `as` 연산자를 사용합니다. 더 많은 정보는, [Type-Casting Operators (타입-변환 연산자)]({% post_url 2020-08-19-Expressions %}#type-casting-operators-타입-변환-연산자) 를 참고하기 바랍니다.

#### 2014-10-16

* 스위프트 1.1 에서 갱신한 것.
* [Failable Initializers (실패 가능한 초기자)]({% post_url 2016-01-23-Initialization %}#failable-initializers-실패-가능한-초기자) 에 온전한 전체 지침을 추가함.
* 프로토콜의 [Failable Initializer Requirements (실패 가능한 초기자 필수 조건)]({% post_url 2016-03-03-Protocols %}#failable-initializer-requirements-실패-가능한-초기자-필수-조건) 에 대한 설명을 추가함.
* `Any` 타입인 상수와 변수는 이제 함수 인스턴스를 가질 수 있음. `switch` 문 내에서 함수 타입을 검사하고 변환하는 방법을 보여주기 위해 [Type Casting for Any and AnyObject ('Any' 와 'AnyObject' 를 위한 타입 변환)]({% post_url 2020-04-01-Type-Casting %}#type-casting-for-any-and-anyobject-any-와-anyobject-를-위한-타입-변환) 에 있는 예제를 갱신함.
* '원시 값 (raw values)' 을 가진 열거체는 이제 `toRaw()` 메소드 대신 `rawValue` 속성을 가지며 `fromRaw()` 메소드 대신 `rawValue` 매개 변수를 받는 '실패 가능한 초기자 (failable initializer)' 를 가집니다. 더 많은 정보는, [Raw Values (원시 값)]({% post_url 2020-06-13-Enumerations %}#raw-values-원시-값) 과 [Enumerations with Cases of a Raw-Value Type (원시-값 타입의 'case 값' 을 가지는 열거체)]({% post_url 2020-08-15-Declarations %}#enumerations-with-cases-of-a-raw-value-type-원시-값-타입의-case-값-을-가지는-열거체) 를 참고하기 바랍니다.
* 초기화를 실패하도록 만들 수 있는, [Failable Initializers (실패 가능한 초기자)]({% post_url 2020-08-15-Declarations %}#failable-initializers-실패-가능한-초기자) 에 대하여 새로운 기준 부분을 추가함.
* 사용자 정의 연산자는 이제 `?` 문자를 가질 수 있음. 개정된 규칙을 설명하기 위해 [Operators (연산자)]({% post_url 2020-07-28-Lexical-Structure %}#operators-연산자) 의 기준을 갱신함. [Custom Operators (사용자 정의 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#custom-operators-사용자-정의-연산자) 에서 유효한 연산자 문자 집합에 대한 중복된 설명을 제거함.

#### 2014-08-18
* 'iOS' 와 'OS X' 앱을 제작하기 위한 '애플 (Apple)' 의 새로운 프로그래밍 언어인, '스위프트 (Swift) 1.0' 을 설명하는 새로운 문서.[^introducing-swift]
* 프로토콜에 있는 [Initializer Requirements (초기자 필수 조건)]({% post_url 2016-03-03-Protocols %}#initializer-requirements-초기자-필수-조건) 에 대하여 새로운 부분을 추가함.
* [Class-Only Protocols (클래스-전용 프로토콜)]({% post_url 2016-03-03-Protocols %}#class-only-protocols-클래스-전용-프로토콜) 에 대하여 새로운 부분을 추가함.
* [Assertions and Preconditions (단언문과 선행 조건문)]({% post_url 2016-04-24-The-Basics %}#assertions-and-preconditions-단언문과-선행-조건문) 는 이제 '문자열 보간법 (string interpolation)' 을 사용할 수 있음. 그와 반대인 기록을 제거함.
* 이제 더 이상 `String` 과 `Character` 값을 '더하기 연산자 (`+`)' 나 '더하기 할당 연산자 (`+=`)' 로 조합할 수 없다는 사실을 반영하기 위해 [Concatenating Strings and Characters (문자열과 문자 이어붙이기)](% post_url 2016-05-29-Strings-and-Characters %}#concatenating-strings-and-characters-문자열과-문자-이어붙이기) 부분을 갱신함. 이러한 연산자들은 이제 `String` 값에만 사용됨. 단일 `Character` 값을 문자열 끝에 덧붙이려면 `String` 타입의 `append(_:)` 메소드를 사용할 것.
* `availability` 특성에 대한 정보를 [Declaration Attributes (선언 특성)]({% post_url 2020-08-14-Attributes %}#declaration-attributes-선언-특성) 부분에 추가함.
* [Optionals (옵셔널)]({% post_url 2016-04-24-The-Basics %}#optionals-옵셔널) 은 이제, '옵셔널 `Bool` 값' 과 작업할 때의 혼동을 피하기 위해, 값을 가지고 있을 때는 `true` 로 그렇지 않을 때는 `false` 라는 식의 암시적인 평가를 더 이상 하지 않음. 옵셔널이 값을 담고 있는지 알아내려면, 그 대신, `nil` 인지를 `==` 및 `!=` 연산자로 명시적으로 검사하기 바람.
* 스위프트는 이제, 옵셔널의 값이 존재하면 포장을 풀고, 옵셔널이 `nil` 이면 '기본 값' 을 반환하는, [Nil-Coalescing Operator (Nil-통합 연산자)]({% post_url 2016-04-27-Basic-Operators %}#nil-coalescing-operator-nil-통합-연산자) (`a ?? b`) 를 가짐.
* '문자열과 문자 비교' 및 '접두사 / 접미사 비교' 는 이제 '확장된 자소 덩어리 (extended grapheme clusters)' 의 '유니코드 값이 법적으로 동등함 (Unicode canonical equivalence)'[^canonical] 에 기초한다는 것을 반영하고 또 증명해 보이기 위해 [Comparing Strings (문자열 비교하기)]({% post_url 2016-05-29-Strings-and-Characters %}#comparing-strings-문자열-비교하기) 부분을 갱신하고 확장함.
* 이제 [Optional Chaining (옵셔널 연쇄)]({% post_url 2020-06-17-Optional-Chaining %}) 를 통하여 속성에 값을 설정하는 것을 시도하거나, 또는 첨자 연산에 할당하거나, 아니면 '변경 (mutating) 메소드' 나 '변경 연산자' 호출할 수 있음. 그에 따라 [Accessing Properties Through Optional Chaining (옵셔널 연쇄를 통해 속성에 접근하기)]({% post_url 2020-06-17-Optional-Chaining %}#accessing-properties-through-optional-chaining-옵셔널-연쇄를-통해-속성에-접근하기) 에 대한 정보를 갱신했으며, 속성의 설정을 성공했음을 검사하는 방법을 보여주기 위해 [Calling Methods Through Optional Chaining (옵셔널 연쇄를 통해 메소드 호출하기)]({% post_url 2020-06-17-Optional-Chaining %}#calling-methods-through-optional-chaining-옵셔널-연쇄를-통해-메소드-호출하기) 에 있는 메소드 호출 성공을 검사하는 예제를 확장함.
* '옵셔널 연쇄 (optional chaining)' 을 통하여 [Accessing Subscripts of Optional Type (옵셔널 타입의 첨자 연산에 접근하기)]({% post_url 2020-06-17-Optional-Chaining %}#accessing-subscripts-of-optional-type-옵셔널-타입의-첨자-연산에-접근하기) 에 대하여 새로운 부분을 추가함.
* 더 이상 `+=` 연산자로 단일 항목을 배열에 덧붙일 수 없음에 주목하기 위해 [Accessing and Modifying an Array (배열 접근하기와 수정하기)]({% post_url 2016-06-06-Collection-Types %}#accessing-and-modifying-an-array-배열-접근하기와-수정하기) 부분을 갱신함. 그 대신, `append(_:)` 메소드를 사용하거나, `+=` 연산자로 '단일-항목의 배열 (single-item array)' 을 덧붙이도록 함.
* [Range Operators (범위 연산자)]({% post_url 2016-04-27-Basic-Operators %}#range-operators-범위-연산자) 인 `a...b` 와 `a..<b` 에서 시작 값인 `a` 는 반드시 끝 값인 `b` 보다 크면 안된다는 것에 대한 기록을 추가함.
* '초기자 재정의 (initializer overrides)' 를 다루는 도입부를 제거하기 위해 [Inheritance (상속)]({% post_url 2020-03-31-Inheritance %}) 장을 재작성함. 이 장은 이제 하위 클래스에서 새로운 '기능성 (functionality)' 을 추가하는 것과, '재정의' 로 기존 '기능성' 을 수정하는 것에 더 집중함. 이 장의 [Overriding Property Getters and Setters (속성의 획득자와 설정자 재정의하기)]({% post_url 2020-03-31-Inheritance %}#overriding-property-getters-and-setters-속성의-획득자와-설정자-재정의하기) 예제는 `description` 속성을 재정의하는 방법을 보여주기 위해 재작성됨. (하위 클래스의 초기자에서 상속한 속성의 '기본 값' 을 수정하는 것에 대한 예제는 [Initialization (초기화)]({% post_url 2016-01-23-Initialization %}) 장으로 옮김.)
* '지명 초기자 (designated initializer)' 의 재정의는 반드시 이제 `override` 수정자로 표시해야 함을 알리기 위해 [Initializer Inheritance and Overriding (초기자 상속과 재정의)]({% post_url 2016-01-23-Initialization %}#initializer-inheritance-and-overriding-초기자-상속과-재정의) 부분을 갱신함.
* 이제 '필수 초기자' 의 모든 하위 클래스 구현 앞에 `required` 수정자를 붙여야 하며, '필수 초기자' 의 '필수 조건 (requirements)' 은 '자동으로 상속된 초기자' 로 만족시킬 수 있음을 알리기 위해, [Required Initializers (필수 초기자)]({% post_url 2016-01-23-Initialization %}#required-initializers-필수-초기자) 부분을 갱신함.
* '중위 (infix)' [Operator Methods (연산자 메소드)]({% post_url 2020-05-11-Advanced-Operators %}#operator-methods-연산자-메소드) 는 이제 더 이상 `@infix` 특성을 필수로 요구하지 않음.
* [Prefix and Postfix Operators (접두사 및 접미사 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#prefix-and-postfix-operators-접두사-및-접미사-연산자) 에 대한 `@prefix` 와 `@postfix` 특성은 `prefix` 와 `postfix` 선언 수정자로 대체되었음.
* 동일한 '피연산자 (operand)' 에 '접두사 (prefix) 연산자' 와 '접미사 (postfix) 연산자' 를 둘 다 적용할 때 [Prefix and Postfix Operators (접두사 연산자와 접미사 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#prefix-and-postfix-operators-접두사-연산자와-접미사-연산자) 가 적용되는 순서에 대한 기록을 추가함.
* [Compound Assignment Operators (복합 할당 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#compound-assignment-operators-복합-할당-연산자) 에 대한 '연산자 함수 (operator functions)' 는 이제 함수를 정의할 때 더 이상 `@assignment` 특성을 사용하지 않습니다.
* [Custom Operators (사용자 정의 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#custom-operators-사용자-정의-연산자) 를 정의할 때 지정하는 수정자의 순서가 바뀌었음. 예를 들어, 이제 `operator prefix` 가 아니라 `prefix operator` 라고 작성함.
* [Declaration Modifiers (선언 수정자)]({% post_url 2020-08-15-Declarations %}#declaration-modifiers-선언-수정자) 에 있는 `dynamic` 선언 수정자에 대한 정보를 추가함.
* '타입 추론 (type inference)' 이 [Literals (글자 값)]({% post_url 2020-07-28-Lexical-Structure %}#literals-글자-값) 과 작업하는 방법에 대한 정보를 추가함.
* '커리 함수 (curried functions)' 에 대한 정보를 추가함.[^curried-functions]
* [Access Control (접근 제어)]({% post_url 2020-04-28-Access-Control %}) 에 대한 새로운 장을 추가함.
* 스위프트의 `Character` 타입은 이제 단일한 '유니코드 확장 자소 덩어리 (Unicode extended grapheme cluster)' 를 나타낸다는 사실을 반영하기 위해 [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) 장을 갱신함. 이는 [Extended Grapheme Clusters (확장된 자소 덩어리)]({% post_url 2016-05-29-Strings-and-Characters %}#extended-grapheme-clusters-확장된-자소-덩어리) 에 대한 새로운 부분과 [Unicode Scalar Values (유니코드 크기 값)]({% post_url 2016-05-29-Strings-and-Characters %}#unicode-scalar-values-유니코드-크기-값) 및 [Comparing Strings (문자열 비교하기)]({% post_url 2016-05-29-Strings-and-Characters %}#comparing-strings-문자열-비교하기) 에 대한 더 많은 정보를 포함함.
* '문자열 글자 값 (string literals)' 안에 있는 '유니코드 크기 값 (Unicode scalars)' 은 이제, 유니코드 '코드 공간 (codespace)' 범위인, '0' 에서 '10FFFF' 사이의 16-진수인 `n` 을 써서, `\u{n}` 처럼 작성된다는 것을 알리기 위해 [String Literals (문자열 글자 값)]({% post_url 2016-05-29-Strings-and-Characters %}#string-literals-문자열-글자-값) 부분을 갱신함.
* `NSString length` 속성은 이제, `utf16count` 가 아니라, `utf16Count`으로써 스위프트 자체의 `Sting` 타입에 대응됨.
* 스위프트의 자체 `String` 타입은 이제 더 이상 `uppercaseString` 이나 `lowercaseString` 속성을 가지지 않음. [Strings and Characters (문자열과 문자)]({% post_url 2016-05-29-Strings-and-Characters %}) 에 있던 관련된 부분을 제거했으며, 다양한 코드 예제를 갱신함.
* [Initializer Parameters Without Argument Labels (인자 이름표가 없는 초기자 매개 변수)]({% post_url 2016-01-23-Initialization %}#initializer-parameters-without-argument-labels-인자-이름표가-없는-초기자-매개-변수) 에 대하여 새로운 부분을 추가함.
* [Required Initializers (필수 초기자)]({% post_url 2016-01-23-Initialization %}#required-initializers-필수-초기자) 에 대하여 새로운 부분을 추가함.
* [Optional Tuple Return Types (옵셔널 튜플 반환 타입)]({% post_url 2020-06-02-Functions %}#optional-tuple-return-types-옵셔널-튜플-반환-타입) 에 대하여 새로운 부분을 추가함.
* 서로 관계가 있는 '여러 개의 변수들' 을 한 개의 '타입 보조 설명 (type annotation)' 으로 된 한 줄에서 정의 할 수 있음을 알리기 위해 [Type Annotations (타입 보조 설명)]({% post_url 2016-04-24-The-Basics %}#type-annotations-타입-보조-설명) 부분을 갱신함.
* `@optional`, `@lazy`, `@final`, 그리고 `@required` 특성은 이제 `optional`, `lazy`, `final`, 그리고 `required` [Declaration Modifiers (선언 수정자)]({% post_url 2020-08-15-Declarations %}#declaration-modifiers-선언-수정자) 임.
* `..<` 를 ("반-닫힌 범위 연산자 (half-closed range operator) 대신") [Half-Open Range Operator (반-열린 범위 연산자)]({% post_url 2016-04-27-Basic-Operators %}#half-open-range-operator-반-열린-범위-연산자) 로 '언급 (refer)' 하도록 전체 책을 갱신함.
* `Dictionary` 는 이제 '불리언 (Boolean)' 속성인 `isEmpty` 를 가진다는 것을 알리기 위해 [Accessing and Modifying a Dictionary (딕셔너리 접근하기와 수정하기)]({% post_url 2016-06-06-Collection-Types %}#accessing-and-modifying-a-dictionary-딕셔너리-접근하기와-수정하기) 부분을 갱신함.
* [Custom Operators (사용자 정의 연산자)]({% post_url 2020-05-11-Advanced-Operators %}#custom-operators-사용자-정의-연산자) 를 정의할 때 사용할 수 있는 전체 문자 목록을 명확히 밝힘.
* `nil` 과 '불리언 (Boolean)' 인 `true` 및 `false` 는 이제 [Literals (글자 값)]({% post_url 2020-07-28-Lexical-Structure %}#literals-글자-값) 임.
* 스위프트의 `Array` 타입은 이제 온전하게 '값 의미 구조 (value semantics)' 를 가짐. 새로운 접근 방식을 반영하기 위해 [Mutability of Collections (집합체의 변경 가능성)](#mutability-of-collections-집합체의-변경-가능성) 과 [Arrays (배열)]({% post_url 2016-06-06-Collection-Types %}#arrays-배열) 에 대한 정보를 갱신함. 또한 '문자열 배열 (strings arrays)' 및 '딕셔너리 (dictionaries)' 에 대한 할당 및 복사 작동 방식도 분명하게 밝힘.
* [Array Type Shorthand Syntax (배열 타입 약칭 구문 표현)]({% post_url 2016-06-06-Collection-Types %}#array-type-shorthand-syntax-배열-타입-약칭-구문-표현) 은 이제 `SomeType[]` 대신 `[SomeType]` 으로 작성됨.
* `[KeyType : ValueType]` 로 작성하는, [Dictionary Type Shorthand Syntax (딕셔너리 타입의 줄임 구문 표현)]({% post_url 2016-06-06-Collection-Types %}#dictionary-type-shorthand-syntax-딕셔너리-타입의-줄임-구문-표현) 에 대하여 새로운 부분을 추가함.
* [Hash Values for Set Types (셋 타입을 위한 해시 값)]({% post_url 2016-06-06-Collection-Types %}#hash-values-for-set-types-셋-타입을-위한-해시-값) 에 대한 새로운 부분을 추가함.
* [Closure Expressions (클로저 표현식)]({% post_url 2020-03-03-Closures %}#closure-expressions-클로저-표현식) 의 예제는 이제, 새롭게 배열의 '값 의미 구조 (value semantics)' 을 반영하기 위해, '전역 `sort(_:_:)` 함수' 대신 '전역 `sorted(_:_:)` 함수' 를 사용함.
* 구조체의 저장 속성이 기본 값을 가지고 있지 않은 경우라도 구조체의 '멤버 초기자 (memberwise initializer)' 가 사용 가능함을 분명히 밝히기 위해 [Memberwise Initializers for Structure Types (구조체 타입을 위한 멤버 초기자)]({% post_url 2016-01-23-Initialization %}#memberwise-initializers-for-structure-types-구조체-타입을-위한-멤버-초기자) 에 대한 정보를 갱신함.
* [Half-Open Range Operator (반-열린 범위 연산자)]({% post_url 2016-04-27-Basic-Operators %}#half-open-range-operator-반-열린-범위-연산자) 를 `..` 대신 `..<` 로 갱신함.
* [Extending a Generic Type (일반화 타입을 확장하기)]({% post_url 2020-02-29-Generics %}#extending-a-generic-type-일반화-타입을-확장하기) 에 대한 예제를 추가함.

### 참고 자료

[^Revision-History]: 이 글에 대한 원문은 [Document Revision History](https://docs.swift.org/swift-book/RevisionHistory/RevisionHistory.html) 에서 확인할 수 있습니다.

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 과 함께 발표 되었다가, 2020-09-16 일에 Apple Event 와 함께 다시 갱신 되었습니다.

[^dynamic-type-expression]: '동적 타입 표현식 (Dynamic Type Expression)' 에 대한 내용은 [2017-03-27](#2017-03-27) 일에 공개한 스위프트 3.1 에서 제거되었기 때문에 링크가 없습니다.

[^variable-function-arguments]: '변수인 함수 인자 (variable function arguments)' 라는 것은 `func someFunction(var argument: String)` 처럼 인자에 `var` 를 붙여서 해당 인자를 변수 처럼 사용하는 것을 말합니다. 스위프트 2.2 부터 사용이 불가능하게 되었습니다.

[^dingbats]: '딩뱃 (dingbats)' 은 조판 시에 사용하는 장식 문자나 공백을 말합니다. 이에 대한 자세한 내용은 위키피디아의 [Dingbat](https://en.wikipedia.org/wiki/Dingbat) 및 [딩뱃](https://ko.wikipedia.org/wiki/딩뱃) 항목을 참고하기 바랍니다.

[^canonical]: 여기서 원문의 'canonical' 을 '표준적인' 이라는 말이 아니라 '법적인' 이라는 말로 옮겼는데, 이는 'canon' 이 원래 '교회 법' 을 의미하는 말이기 때문입니다. '법적으로 동등함' 이 무엇인지에 대해서는 [Comparing Strings (문자열 비교하기)]({% post_url 2016-05-29-Strings-and-Characters %}#comparing-strings-문자열-비교하기) 부분을 참고하기 바랍니다.

[^introducing-swift]: '스위프트 (Swift)' 프로그래밍 언어는 2014년 'WWDC' 에서 2014년 6월 2일에 최초로 발표되었습니다. 2014년 8월 18일은 그 이후 최초로 갱신된 내용입니다.

[^curried-functions]: '커리 함수 (curried functions)' 에 대한 내용은 [2016-03-21](#2016-03-21) 일에 공개한 스위프트 2.2 에서 제거되었기 때문에 링크가 없습니다.
