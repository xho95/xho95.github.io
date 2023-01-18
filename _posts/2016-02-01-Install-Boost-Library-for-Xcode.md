---
layout: post
pagination:
  enabled: true
comments: true
title:  "C++: Xcode에서 Boost 라이브러리 사용하기"
date:   2016-02-01 17:30:00 +0900
categories: Xcode C++ Library Boost
---

여기서는 맥의 Xcode 개발 환경에서 [부스트(Boost) 라이브러리](http://www.boost.org) 를 사용하는 방법을 정리합니다. [^boost]

원래 처음에 이 글은 작성할 때는 이지형님의 [Warmz's Dev](http://warmz.tistory.com) 라는 블로그에 있는 글을 많이 참고 했었습니다. 다만 글을 수정하는 과정에서 해당 글을 찾아보니 현재는 글이 삭제된 것 같습니다. [^warmz]

> 맥에서 부스트 라이브러리를 설치하는 방법에 대해서 이 글을 처음 쓰는 당시에는 이지형님의 글이 큰 도움이 되었는데 안타깝습니다. 나중에 원 글을 찾게 되면 꼭 소개하도록 하겠습니다.

Xcode에서 부스트 라이브러리를 사용하기 위해서는 부스트 라이브러리를 Xcode 용으로 빌드해야 합니다. 여기서는 부스트 라이브러리를 다운받아서 맥에서 사용할 수 있도록 빌드하고 Xcode에서 간단하게 테스트하는 것으로 마무리 하도록 하겠습니다.

### 부스트(Boost) 라이브러리 다운하기

부스트 라이브러리는 부스트 공식 홈페이지인 [Boost.org](http://www.boost.org) 에서 다운받을 수 있습니다. 이 글을 수정하고 있는 **2017-01-15** 일 현재 최신 빌드 버전은 `1.63.0`입니다. 부스트 라이브러리는 Boost.org의 GitHub 저장소인 [boostorg/boost](https://github.com/boostorg/boost) 에서도 다운받을 수 있습니다. [^github-boost] [^multism]

다운 받은 라이브러리의 압축을 풀고, 적당한 폴더에 둡니다. 뒤의 설명을 위해 여기서는 `~/Desktop/Boost` 폴더에 옮겼다고 가정합니다.

### 부스트 라이브러리 빌드하기

이제 Boost가 있는 폴더로 이동하여 아래와 같이 `bootstrap.sh` 쉘 파일을 실행합니다.

```sh
$ cd ~/Desktop/Boost
$ ./bootstrap.sh
```

그러면 `b2`라는 Boost를 설치할 수 있는 설치 파일이 생깁니다. 아래와 같이 옵션을 주고 b2를 실행합니다.

```sh
$ ./b2 toolset=darwin link=static threading=multi address-model=64 runtime-link=static
```

위에서 `darwin` 은 맥에서 사용하기 위해 설정하는 값으로, 윈도우즈에서라면 다른 값이 들어가게 됩니다. 또한 `address-model`의 경우 시스템이 32비트인지 64비트인지를 체크하는 것 같아서 64로 지정했습니다. 이 과정에서 [taromati](https://twitter.com/_taromati) 라는 아이디를 사용하는 [이재현](https://twitter.com/_taromati)님의 블로그 글에서 도움을 받았습니다. [^taromati]

실제 `b2` 실행과정에서 아래와 같이 `toolset` 값만 지정해줘도 나머지 옵션은 알아서 지정이 된다고 합니다. [^sim9108]

```sh
$ ./b2 toolset=darwin
```

따라서 위와 같이 해도 실행 결과는 처음과 같을 것입니다.

> 다만 실제로 제가 실습한 것은 아니라서 확실하지는 않습니다. 그냥 설치하실 때 참고하시면 될 것 같습니다.

### Xcode 프로젝트 설정하기

`b2`를 실행하고 나면 부스트 내부에 **stage** 라는 폴더가 생기고, 그 밑의 **lib** 폴더에 라이브러리 파일들이 위치합니다. Xcode에서 부스트 라이브러리를 사용하려면 프로젝트에 이 경로들을 지정하면 됩니다.

> 부스트 라이브러리를 빌드를 하고 나면 어떤 경로를 지정해주면 되는지 친철하게 결과를 터미널 창에 알려줍니다. 그 두 경로를 그대로 프로젝트에 지정하면 됩니다.

예를 들어 `~/Desktop/Boost` 폴더에 설치가 되었다면 아래와 같은 경로가 나타날 것입니다. (참고로 뒤의 숫자는 버전에 따라 달라집니다.)

```sh
/Users/.../Desktop/Boost/boost_1_60_0  
/Users/.../Desktop/Boost/boost_1_60_0/stage/lib
```

위 두 경로를 각각 **Targets** 의 **Build Settings > Search Paths > Header Search Paths** 부분과 **Library Search Paths** 부분에 할당해 줍니다.

### 부스트 라이브러리 테스트하기

아래의 C++ 코드는 [Boost.org](http://www.boost.org) 사이트에 있는 [`adjacent_filtered`](http://www.boost.org/doc/libs/1_60_0/libs/range/doc/html/range/reference/adaptors/reference/adjacent_filtered.html) 에 대한 예제 코드입니다. [^adjacent-filtered]

이 코드를 빌드하기 위해서는 당연히 부스트 라이브러리가 필요합니다.

```cpp
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

앞서 설명한 대로 Xcode 프로젝트를 설정하고 위의 코드를 실행하면 아래와 같은 결과를 출력합니다. 부스트 라이브러리가 잘 설치되었다면 문제없이 컴파일 될 것입니다.

```sh
1,2,3,4,5,6,Program ended with exit code: 0
```

이제 Xcode에서 부스트 라이브러리를 사용할 수 있는 환경을 갖추게 되었습니다.

### 고찰 하기

경로를 지정하는 작업을 꼭 **Targets** 쪽에다 해줘야 하는 것인지, 또 매 프로젝트 마다 일일이 경로를 다시 지정해줘야 하는 것인지 확인이 필요합니다.

> 이 부분에 대해서는 [taromati](https://twitter.com/_taromati) 님께서 직접 댓글을 달아 주셨습니다. **Targets** 에 path 설정은 매번 해야한다고 합니다.

taromati 님의 원 블로그 글에는 시스템 관련 라이브러리들은 프레임웍(framework)을 지정하기도 했는데 이 부분은 iOS 때문에 하는 것으로 macOS 와는 다른 부분이라고 합니다. 

> taromati 님의 블로그가 사라져서 지금은 원 글을 확인할 수가 없는 상태입니다. 간단하게나마 아래에 있는 taromati 님의 댓글을 보시면 좋을 것 같습니다.

### 참고 자료

[^boost]: [Boost.org](http://www.boost.org) : 부스트 라이브러리 공식 홈페이지입니다.

[^warmz]: [Warmz's Dev](http://warmz.tistory.com) : 이지형님의 블로그입니다. 부스트 라이브러리 관련 글이 현재는 없어진 것 같습니다. 아마 블로그를 개편 중인 듯 합니다.

[^github-boost]: [boostorg/boost]([boostorg/boost](https://github.com/boostorg/boost)) : Boost.org의 부스트 라이브러리 관련 GitHub  저장소입니다.

[^multism]: 부스트 라이브러리를 GitHub 저장소에서도 다운받을 수 있다는 사실은 윤훈남님으로부터 알게 되었습니다. [윤훈남](https://www.facebook.com/sim9108?fref=nf) 님은 수원에서 C++ 스터디를 운영하시고 있는데, 네이버 카페인 [멀티즘 연합](http://cafe.naver.com/multism) 과 페이스북 [C++, OpenSource 스터디 모임](https://www.facebook.com/groups/OpenCPP/) 을 통해 연락할 수 있습니다.

[^taromati]: [taromati](https://twitter.com/_taromati) : taromati라는 아이디를 사용하는 이재현(?)님의 트위터 계정인 것 같습니다. 부스트 라이브러리 설치와 관련해서 블로그 글로도 도움을 받고 직접 제 블로그에 답글도 달아주신 고마운 분이신데, 블로그가 사라진 것 같습니다. 마찬가지로 원 글을 찾게 되면 꼭 소개하도록 하겠습니다. 성함은 아이디로 찾아서 이재현님이라고 추측되는데 확실하지는 않아서 이후로는 계속 taromati 님이라고 하도록 하겠습니다.

[^sim9108]: 이 정보도 수원에서 C++ 스터디를 운영하시는 [윤훈남](https://www.facebook.com/sim9108?fref=nf) 님에게서 설명을 듣고 알게된 것입니다. 윤훈남 님에 대해서는 참고 자료 4번을 보시기 바랍니다.

[^adjacent-filtered]: [`adjacent_filtered`](http://www.boost.org/doc/libs/1_60_0/libs/range/doc/html/range/reference/adaptors/reference/adjacent_filtered.html) : 부스트 라이브러리에 추가된 `adjacent_filtered`에 대한 예제 코드 링크입니다. `adjacent_filtered`는 일정 범위의 요소들에 대해 옆 요소의 값이 같으면 걸러내는 필터 역할을 하는 것 같습니다.
