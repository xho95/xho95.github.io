---
layout: post
pagination:
  enabled: true
comments: true
title:  "C++: Boost 라이브러리의 Copied 어댑터 정리"
date:   2016-02-24 14:30:00 +0900
categories: Xcode C++ Boost Copied
---

여기서는 Boost 라이브러리 중에서 Copied 라는 어댑터에 대해서 알아본다.


### Operator+=()

std::vector에 대한 operator+=()는 **boost/assign/std/vector.hpp** 에 정의되어 있으며 인자로 std::vector와 객체를 받아서 boost::assign 네임스페이스에 정의되어 있는 push_back 템플릿 함수를 실행한 후 그 결과인 list_inserter를 반환한다.


### push_back()

make_list_inserter()를 호출하여 list_inserter를 생성한다. make_list_inserter()의 동작 방식은 템플릿 메타 프로그래밍 방식을 사용하는 것 같다.


### list_inserter

list_inserter는 std::vector에 담기는 객체의 타입인 V와, V를 담고 있는 call_push_back 함수 객체를 템플릿 인자로 가지는 객체이다. 여기서 call_push_back 함수 객체는 std::vector의 push_back을 호출하는 역할을 한다.

list_inserter는 3가지 방식으로 동작하는데 첫번째 방식은 함수 타입(?)이 전달될 경우 함수를 insert_ 멤버 변수에 넣는다.

두번째 방식은 함수와 객체 인자 타입을 가진 list_inserter가 전달될 경우로 그 list_inserter의 fun_private() 멤버 함수를 호출한 후 반환값을 insert_ 멤버 변수에 넣는다.

마지막으로 list_inserter 객체가 전달되면 그 객체의 inserter_를 inssert_에 넣는다.


### fun_private() 멤버함수

list_inserter의 fun_private() 멤버함수는 list_inserter가 가지고 있는 insert_를 실행하고 그 결과를 반환한다. 여기서 insert_는 call_push_back 함수 객체와 같은 타입을 가지고 있다.


### Range

iterator를 묶어서 하나의 타입(?)으로 만들어 놓은 것으로 보인다. Range를 도입하면 두가지의 장점이 생길 것 같다.

첫째는 iterator와 마찬가지로 임의의 container 자체를 인자로 넘길 수 있게 된다. 즉, Range를 사용하는 알고리즘이나 함수들은 어떠한 임의의 container라도 인자를 받을 수 있을 것이다.

둘째로는 C++에 함수형 언어의 장점을 도입할 있게 된다. iterator 자체를 사용하게 되면 필연적으로 for loop 구문이 등장하게 되는데, 이는 함수형 언어의 장점을 살리지 못하게 만든다. 따라서 함수형 언어의 장점을 도입하려면 iterator를 직접 사용하는 방식보다 container를 직접 받아서 내부적으로 한번씩 해당 container의 item에 대해 재귀 호출을 할 수 있도록 하는 것이 유리할 것이다.

그리고, 이렇게 range를 사용하는 adaptor나 algorithm들은 boost/range 네임스페이스에 정의되어 있는 것 같다.


### ADL

C++ 함수 호출 규칙 관련한 내용인데, 나중에 정리하자.


### 기타

open methods

```cpp
std::ostream_iterator<int> mk(std::cout, ",")); // 반복자 어댑터  
*mk++ = 90; // 90, - adapter pattern : decoration (?)
```

### CONCEPT

템플릿의 특정 타입이 갖춰야 할 요구조건 집합, requirement's set

BOOST_RANGE_CONCEPT_ASSERT

### 고찰 하기

### 참고 자료
