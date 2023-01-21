---
layout: post
comments: true
title:  "Swift: 리눅스에서 Swift 개발 환경 구축하기"
date:   2017-02-19 23:00:00 +0900
categories: Linux Development Swift Package Install
---

보통 [Swift](https://swift.org) 는 맥이나 iOS 앱을 만들기 위해서 사용한다고 생각하기 쉽습니다. [^swift] 하지만 애플에서 2015년 12월 3일에 Swift 를 오픈 소스로 공개하면서 리눅스 (Linux) 배포판도 같이 공개했습니다. [^swift-welcome] [^swift-linux] 즉, Swift 는 리눅스에서 마치 C/C++ 처럼 사용할 수 있는 언어입니다.

여기서는 리눅스에서 Swift 를 사용하기 위한 환경을 구축하는 방법을 정리합니다.

### 들어가며

이 글의 내용은 Swift 공식 블로그에 있는 [Download Swift](https://swift.org/download/#releases) 와 [Getting Started](https://swift.org/getting-started/) 를 실습하면서 정리한 것입니다. [^download-swift] [^swift-started] 그외에 [준P](http://crasy.tistory.com) 님이 쓰신 [Swift: Linux에서 Swift 시작해보기](http://crasy.tistory.com/145) 글도 참고했습니다. [^crasy-145]

리눅스에서 Swift 를 사용하기 위해서는 먼저 컴파일러와 기타 필수 구성 요소들을 내려 받아서 설치해야 합니다. 이들은 Swift 공식 블로그의 [Download Swift](https://swift.org/download/#releases) 페이지에서 내려 받을 수 있습니다.

링크로 들어가보면 여러 버전의 Swift 가 있는데 맨 위의 Releases 에 있는 것을 다운받으면 됩니다. 표에서 **Ubuntu 16.04** 와  **(Signature)** 를 눌러서 2개의 파일을 내려 받습니다. [^swift-releases]

리눅스용 패키지는 tar 압축 파일로 되어 있으며 Swift 컴파일러, lldb 그외 기타 관련 도구들을 포함하고 있습니다.

### Swift 설치하기

1. Swift 를 설치하기 전에 의존되어 있는 필수 구성 요소들을 먼저 설치합니다. 터미널에서 아래와 같이 실행합니다.

	```sh
	$ sudo apt-get install clang libicu-dev
	```

	[clang](https://clang.llvm.org) 과 [libicu-dev](https://packages.debian.org/sid/libicu-dev) 를 설치하는 것을 알 수 있습니다. [^clang] [^libicu-dev]

2. 설치 파일 중에서 가장 최신 버전을 내려 받습니다. [^version] 앞에서 미리 내려 받았으면 넘어갑니다.

	**swift-\<VERSION\>-\<PLATFORM\>.tar.gz** 파일은 그 자체로 툴체인이며, **.sig** 파일은 디지털 서명 파일입니다.

3. Swift 패키지를 처음으로 다운로드하는 경우 [PGP](https://ko.wikipedia.org/wiki/PGP_(소프트웨어)) 키를 키링으로 가져와야 합니다. [^wikipedia-pgp] [^jinbo-pgp]

	Swift 홈페이지에서는 두 가지 방식으로 설명이 되어 있는데 두 방식은 같은 것이라 하나만 하면 됩니다. 두번째 방식이 좀 더 간단한 것 같아서 두번째 방식만 설명합니다. 터미널에서 아래와 같이 실행합니다.

	```sh
	$ wget -q -O - https://swift.org/keys/all-keys.asc | \
	  gpg --import -
	```

	그러면 해당 서버에서 PGP 관련 파일들을 받습니다.

4. PGP 서명의 유효 검사를 수행합니다.

	먼저 아래 명령을 수행합니다. 뭔가 새로 고침 비슷한 것으로 추측됩니다.

	```
	$ gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift
	```

	그리고 이어서 실제 유효 검사를 수행합니다.

	```
	$ gpg --verify swift-<VERSION>-<PLATFORM>.tar.gz.sig
...
gpg: Good signature from "Swift Automatic Signing Key #1 <swift-infrastructure@swift.org>"
	```

	유효 검사 이후에 경고가 뜰 수도 있는데 공식 블로그에서는 무시해도 상관 없다고 설명하고 있습니다.

	> 유효 검사 도중에 에러가 발생할 경우에는 [Download Swift](https://swift.org/download/#releases) 글의 **Active Signing Keys** 부분을 보고 따라하면 해결 된다고 합니다. 이 부분은 문제가 있을 경우에만 실행합니다.

5. 내려 받은 파일을 설치하고자 하는 곳이로 이동한 후에 아래와 같이 압축을 풉니다.

	```
	$ tar xzf swift-<VERSION>-<PLATFORM>.tar.gz
	```

	이렇게 압축을 풀면 사실상 설치가 된 것입니다. 압축을 풀고 나면 하위에 **usr/** 디렉토리가 생긴 것을 볼 수 있습니다.

6. 이제 리눅스에서 Swift 툴체인 경로를 추가합니다. 아래와 같이 실행합니다.

	```
	$ export PATH=/path/to/usr/bin:"${PATH}"
	```

	위의 명령을 실행할 때 **/path/to/** 부분에는 실제 자신의 Swift 가 설치된 디렉토리의 **/usr** 디렉토리가 있는 경로를 지정해야 합니다. 설치하는 사람마다 경로가 다르므로 본인에게 맞는 경로를 넣으면 됩니다.

	> 위와 같이 하면 부팅시마다 매번 `export` 를 해줘야 하는 것 같습니다. 서버라면 재부팅할 일이 없으므로 이대로도 괜찮겠지만 개발 용도로 사용하는 리눅스의 경우 번거로울 수 있습니다.
	>
	> 경로 설정은 [리눅스 PATH 설정](http://egloos.zum.com/silve2/v/4448383) 등의 글을 참고하여 **~/.profile** 파일의 PATH 부분을 다음과 같이 수정했습니다. [^egloos-4448383] [^blueskywithyou-32] [^superad-path] [^linux-bash]
	>
	> ```
	> PATH="$HOME/bin: ... :/path/to/usr/bin:$PATH"
	> ```
	>
	> 다른 설정 방법도 있습니다. [^html5around-swift]

설치는 끝났습니다. 이제 `swift` 명령으로 [REPL](https://en.wikipedia.org/wiki/Read–eval–print_loop) 를 실행하거나 Swift 프로젝트를 빌드할 수 있습니다. [^repl]

### 고찰하기

이제 리눅스에서 Swift 프로젝트를 만들고 소스 코드를 편집해서 빌드할 수 있게 되었습니다. 이어서 리눅스에서 LLDB 디버거를 사용하는 부분과 간단한 Swift 예제 프로그램을 작성한 것도 정리할 예정입니다.

Swift 패키지 관리자에 대해서 더 알고 싶으면 공식 블로그의 [Swift Package Manager](https://swift.org/package-manager/) 글을 참고 하면 됩니다.

### 관련 자료

* [Swift: 리눅스에서 Swift 개발 시작하기]({% post_url 2017-03-06-Getting-Started-Swift-on-Linux %})
* [Swift 3.1: 빠르게 (Swift) 둘러보기]({% link docs/swift-books/swift-programming-language/a-swift-tour.md %})

### 참고 자료

[^swift]: Swift 는 애플에서 공개한 새로운 프로그래밍 언어로 보다 자세한 내용은 공식 블로그인 [Swift.org](https://swift.org) 에서 찾아볼 수 있습니다.

[^swift-welcome]: 2015년 12월 3일에 애플에서 Swift 를 오픈 소스로 공개하면서 Swift 공식 블로그를 만들었습니다. 보다 자세한 내용은 [The Swift.org Blog](https://swift.org/blog/welcome/) 라는 글을 보면 알 수 있습니다.

[^swift-linux]: Swift 를 리눅스로 포팅한 소식은 블로그의 [The Swift Linux Port](https://swift.org/blog/swift-linux-port/) 에 소개하고 있습니다.

[^download-swift]: [Download Swift](https://swift.org/download/#releases) 는 Swift 컴파일러 및 기타 필수 구성 요소를 설치하고 인증하는 방법을 설명하는 글입니다. 원문은 리눅스외에도 애플 플랫폼에 대한 내용도 다루고 있지만, 여기서는 리눅스 관련 내용만 정리합니다.

[^swift-started]: [Getting Started](https://swift.org/getting-started/) 는 Swift 를 설치한 후 REPL, 패키지 관리자, LLDB 디버거를 사용하는 방법을 설명한 글입니다.

[^crasy-145]: 준P 님의 [HELLO_HELL?](http://crasy.tistory.com) 이라는 블로그에는 리눅스에 Swift 를 설치하는 방법이 [Swift: Linux에서 Swift 시작해보기](http://crasy.tistory.com/145) 라는 글로 정리되어 있습니다.

[^swift-releases]: [Download Swift](https://swift.org/download/#releases) 글에서 리눅스 관련 설명을 보면 Swift 는 특정 우분투 버전만 지원하는 것은 아니고 다른 리눅스에서도 사용 가능하다고 합니다. 다만 다운로드 항목에 우분투만 있는 것은 실제 테스트를 한 환경이 우분투라서 그렇다고 합니다. 따라서 다른 리눅스 배포판에서도 설치 가능하지 않을까 생각합니다.

[^clang]: [clang](https://clang.llvm.org) 은 원래 LLVM 에서 사용하는 C/C++ 프론트-엔드입니다. 일단 Swift 컴파일러는 C/C++ 및 Object-C 의 컴파일을 지원하므로 해당 언어의 문맥 처리를 위해 설치를 하는 것이 아닌가 추측합니다. 그리고 지금 시점에서는 아직 Swift 컴파일러도 C++ 로 만들어 지고 있기는 합니다. 관련 내용은 [Frequently Asked Questions about Swift](https://github.com/apple/swift/blob/2c7b0b22831159396fe0e98e5944e64a483c356e/www/FAQ.rst) 글을 참고하시기 바랍니다.  

[^libicu-dev]: [libicu-dev](https://packages.debian.org/sid/libicu-dev) 는 개발 과정에서 유니 코드를 지원하기 위한 데비안-계열 리눅스 패키지입니다. ICU 는 유니코드와 지역화를 지원하는 C++ 및 C 라이브러리로 International Components for Unicode 의 줄임말입니다. 즉, libicu-dev 패키지는 ICU 를 위한 개발 파일들을 담고 있는 패키지입니다.

[^version]: 이 글을 작성하고 있는 시점에서의 최신 파일은 각각 **swift-3.0.2-RELEASE-ubuntu16.04.tar.gz** 와 **swift-3.0.2-RELEASE-ubuntu16.04.tar.gz.sig** 입니다. 2개의 파일 모두 받습니다.

[^wikipedia-pgp]: 위키피디아의 [PGP](https://ko.wikipedia.org/wiki/PGP_(소프트웨어)) 글에 따르면 PGP 는 컴퓨터 파일을 암호화하고 복호화하는 프로그램의 하나로, GNU 프로젝트인 GnuPG 로도 개발되어 전 세계적으로 광범위하게 사용되고 있다고 합니다.

[^jinbo-pgp]: [공개키 암호화와 PGP에 대한 소개](https://guide.jinbo.net/digital-security/communication-security/introduction-public-key-encryption) : 좋은 내용이지만 원문을 번역하면서 문장이 조금 매끄럽지 않게 된 것 같습니다.

[^egloos-4448383]: 양치질 님의 [리눅스 PATH 설정](http://egloos.zum.com/silve2/v/4448383) 이란 글이 제일 간단하게 설명이 되어 있어서 이 방식대로 경로를 설정했습니다.

[^blueskywithyou-32]: Daniel.H.Kim 님의 [리눅스에서 PATH(환경변수) 관련 설정 및 참고 내용](http://blueskywithyou.tistory.com/32) 글에는 리눅스의 export 명령에 대한 설명이 정리되어 있습니다.

[^superad-path]: 카약스님의 [리눅스 명령어 PATH 설정하기](http://superad.tistory.com/entry/리눅스-명령어-PATH설정하기) 라는 글에는 리눅스의 환경 설정 파일에서 **~/.bash_profile** 및 **~/.bashrc** 파일과 **/etc/profile** 및 **/etc/bashrc** 파일에 대한 내용이 있습니다. 나중에 관련 내용들을 정리할 생각입니다.

[^linux-bash]: 이렇게 해도 매번 리눅스를 부팅해서 `$ source .bash_profile` 을 실행해야 하는 것 같습니다. 리눅스 경로 설정 부분은 방법이 워낙 다양해서 최적의 방법을 조금 더 알아보고 정리하도록 할 예정입니다.

[^html5around-swift]: 소화자 님의 [우분투에서 애플 스위프트(Swift) 공부환경 구축하기](http://html5around.com/wordpress/tutorials/ubuntu-swift/) 글에 보면 경로를 **~/.bashrc** 파일에 등록하고 있습니다. 나중에 비교 검토해서 반영할 생각입니다.

[^repl]: [REPL](https://en.wikipedia.org/wiki/Read–eval–print_loop) 은 Read–Eval–Print Loop 의 약자로 직역하면 읽고-실행하고-출력하는 것을 반복하는 것을 의미합니다. 프로그래밍에서 코드를 작성하면 한 줄씩 실행하면서 결과를 바로 볼 수 있도록 대화형으로 개발이 진행되는 방식을 의미합니다.

[우분투(Ubuntu)에 스위프트 설치하기](http://blog.yagom.net/535)
