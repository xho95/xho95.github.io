---
layout: post
comments: true
title:  "Swift 5.2: Functions (함수)"
date:   2020-05-28 10:00:00 +0900
categories: Swift Language Grammar Function
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Functions](https://docs.swift.org/swift-book/LanguageGuide/Properties.html) 부분[^Functions]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Functions (함수)

_함수 (functions)_ 는 지정된 작업을 수행하는 '독립적인 (self-contained)' 코드 조각입니다. 함수는 그것이 뭔지를 식별하도록 이름을 가지며, 작업을 수행할 필요가 있을 때 이 이름을 사용하여 함수를 "호출 (call)" 합니다.

스위프트의 '통합된 함수 구문 표현 (unified function syntax)' 은 충분히 유연하기 때문에, 매개 변수 이름이 없는 간단한 C-스타일 함수에서 부터 각각의 매개 변수 마다 이름과 인자 이름표가 있는 복잡한 오브젝티브-C-스타일의 메소드까지 뭐든지 표현할 수 있습니다. 매개 변수는 함수 호출을 단순화하기 위해 기본 값을 제공 할 수도 있고, 입-출력 매개 변수의 형태로 전달해서, 함수 실행을 완료했을 때 전달된 변수를 수정하도록 할 수도 있습니다.

스위프트의 모든 함수는, 함수의 매개 변수 타입과 반환 타입으로 이루어진, 타입을 가지게 됩니다. 이 타입은 스위프트에 있는 다른 모든 타입처럼 사용할 수 있어서, 함수를 다른 함수의 매개 변수로 전달하거나, 함수에서 함수를 반환하는 것을 쉽게 만들어 줍니다. 함수를 다른 함수 내에서 작성하여 유용한 기능을 '품어진 함수 (nested function)' 영역 범위로 캡슐화할 수도 있습니다.

### Defining and Calling Functions (함수 정의하고 호출하기)

함수를 정의 할 때 함수가 입력으로 사용하는 하나 이상의 명명 된 유형의 값을 매개 변수라고하는 선택적으로 정의 할 수 있습니다. 선택적으로 함수가 완료되면 리턴 유형이라고하는 출력으로 전달할 값 유형을 정의 할 수도 있습니다.

모든 기능에는 기능 이름이 있으며이 기능은 해당 기능이 수행하는 작업을 설명합니다. 함수를 사용하려면 해당 함수의 이름으로 해당 함수를 "호출"하고 함수의 매개 변수 유형과 일치하는 입력 값 (인수)을 전달합니다. 함수의 인수는 항상 함수의 매개 변수 목록과 동일한 순서로 제공되어야합니다.

아래 예의 함수를 인사 (person :)라고합니다. 그 기능이 바로 사람의 이름을 입력으로 받고 해당 사람의 인사말을 반환하기 때문입니다. 이를 위해 하나의 입력 매개 변수 (person이라고하는 문자열 값)와 그 사람에 대한 인사말을 포함하는 String의 반환 유형을 정의합니다.

### Function Parameters and Return Values (함수 매개 변수와 반환 값)

#### Functions Without Parameters (매개 변수가 없는 함수)

#### Functions with Multiple Parameters (여러 매개 변수를 가진 함수)

#### Functions Without Return Values (반환 값이 없는 함수)

#### Functions with Multiple Return Values (여러 반환 값을 가진 함수)

**Optional Tuple Return Types (옵셔널 튜플 반환 타입)**

#### Functions With an Implicit Return (암시적으로 반환하는 함수)

### Function Argument Labels and Parameter Names (함수 인자 이름표와 매개 변수 이름)

#### Specifying Argument Labels (인자 이름표 지정하기)

#### Omitting Argument Labels (인자 이름표 생략하기)

#### Default Parameter Values (기본 설정 매개 변수 값)

#### Variadic Parameters (가변 매개 변수)

#### In-Out Parameters (입-출력 매개 변수)

### Function Types (함수 타입)

#### Using Function Types (함수 타입 사용하기)

#### Function Type as Parameter Types (함수 타입을 매개 변수 타입으로 사용하기)

#### Function Type as Return Types (함수 타입을 반환 타입으로 사용하기)

### Nested Functions (품어진 함수)

### 참고 자료

[^Functions]: 이 글에 대한 원문은 [Functions](https://docs.swift.org/swift-book/LanguageGuide/Functions.html) 에서 확인할 수 있습니다.
