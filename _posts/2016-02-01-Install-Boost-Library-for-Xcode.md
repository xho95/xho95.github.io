---
layout: post
title:  "Xcode에서 Boost 라이브러리 사용하기"
date:   2016-02-01 17:30:00 +0900
categories: Xcode C++ Boost Install
---

Xcode에서 Boost 라이브러리를 사용하기 위해서는 Boost 라이브러리를 Xcode용으로 빌드하여 설치해야 한다.

이 자료는 [이지형님의 블로그 글](http://warmz.tistory.com/904)을 참고하여 작성된 것이다. 맥에서 Boost 라이브러리를 설치하는 것과 관련하여 가장 잘 정리를 잘 하신 것 같다.[^warmz]


### Boost 라이브러리 다운하기

Boost 라이브러리는 [www.boost.org](http://www.boost.org)에서 다운받을 수 있다. 글을 쓰고 있는 현재 시점에서 최신 빌드 버전은 `1.60.0`이다. [윤훈남님](http://cafe.naver.com/multism)에 따르면 Boost 라이브러리는 [GitHub](https://github.com/boostorg/boost)에서도 다운받을 수 있는 것 같다.[^multism]

다운 받은 라이브러리를 압축을 풀고, 적당한 폴더에 둔다. 예를 들어 `~/Desktop/Boost` 폴더에 옮겼다고 하자.


### Boost 라이브러리 빌드하기

이제 Boost가 있는 폴더로 이동(`$ cd ~/Desktop/Boost`)하여 아래와 같이 `bootstrap.sh` 쉘 파일을 실행한다.

```sh
$ ./bootstrap.sh
```

그리고 나면 `b2`라는 Boost를 설치할 수 있는 설치 파일이 생긴다. 아래와 같이 옵션을 주고 b2를 실행한다.

```sh
$ ./b2 toolset=darwin link=static threading=multi address-model=64 runtime-link=static
```

위에서 `darwin` 은 맥에서 사용하기 위함으로 윈도우즈에서라면 다른 값이 들어가게 된다. 또한 address-model의 경우 시스템이 32비트인지 64비트인지를 check하는 것 같아서 [taromati님의 블로그 글](http://taromati.kr/blog/?p=65)을 참고하여 64로 지정했다.[^taromati]

윤훈남님[^multism]의 말씀으로는 실제 b2 실행과정에서 아래와 같이 `toolset` 값만 지정해줘도 나머지 옵션은 알아서 지정이 된다고 한다. 따라서 아래 처럼 해도 실행 결과는 위와 같을 것이다. 다만 실제로 해보지는 않아서, 혹시라도 이 글을 읽게 되면 참고해서 설치하기 바란다.

```sh
$ ./b2 toolset=darwin
```


### Boost 라이브러리 Xcode에서 사용하기

`b2`를 실행하고 나면 boost 내부에 stage라는 폴더가 생기고, 그 밑의 lib폴더에 라이브러리 파일들이 위치하게 된다. Xcode에서 boost 라이브러리를 사용하기 위해서는 헤더 파일의 경로와 함께 이 라이브러리 파일들의 경로를 프로젝트에서 지정해주면 된다.

빌드후에 터미널 창에서 친철하게도 어떤 경로를 지정해주면 되는지 알려준다. 그 두 경로를 프로젝트 내에서 지정해두면 된다.

예를 들어 `~/Desktop/Boost` 폴더에 설치가 되었다면 아래와 같은 경로가 된다.

```sh
/Users/.../Desktop/Boost/boost_1_60_0  
/Users/.../Desktop/Boost/boost_1_60_0/stage/lib
```

위 두 경로를 각각 **Targets** 의 **Build Setttings > Search Paths > Header Search Paths** 와 **Library Search Paths** 에 할당해 주면 된다.


### Boost 라이브러리 테스트 해보기

아래의 C++ 코드는 `adjacent_filtered` 함수에 대한 예제 코드로 윤훈남님[^multism]의 소개로 [Boost 사이트](http://www.boost.org/doc/libs/1_60_0/libs/range/doc/html/range/reference/adaptors/reference/adjacent_filtered.html)에서 찾은 것이다.

```C++
#include <boost/range/adaptor/adjacent_filtered.hpp>
#include <boost/range/algorithm/copy.hpp>
#include <boost/assign.hpp>
#include <iterator>
#include <functional>
#include <iostream>
#include <vector>

int main(int argc, const char* argv[])
{
    using namespace boost::assign;
    using namespace boost::adaptors;

    std::vector<int> input;
    input += 1,1,2,2,2,3,4,5,6;

    boost::copy(
        input | adjacent_filtered(std::not_equal_to<int>()),
        std::ostream_iterator<int>(std::cout, ","));

    return 0;
}
```

위의 코드를 Xcode에서 실행한 결과는 아래와 같다.

```sh
1,2,3,4,5,6,Program ended with exit code: 0
```

### 참고 자료

[^warmz]: [이지형님의 블로그](http://warmz.tistory.com/904) 몇 군데 둘러봤는데 Boost 라이브러리 설치와 관련해서 가장 깔끔하게 설명한 사이트인 것 같다.

[^multism]: 국내에서 C++관련 스터디를 운영하시는 윤훈남님은 [카페](http://cafe.naver.com/multism)와 [페이스북](https://www.facebook.com/groups/OpenCPP/)을 통해 연락할 수 있다.

[^taromati]: [taromati님의 블로그 글](http://taromati.kr/blog/?p=65) Boost 빌드 및 설치 과정에서 도움을 받았는데, 블로그 글에서 다른 정보를 알 수가 없어서 우선은 이렇게 링크라도 기록해둔다.
