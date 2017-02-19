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

리눅스에서 Swift 를 사용하기 위해서는 먼저 컴파일러와 기타 필수 구성 요소들을 내려 받아서 설치해야 합니다. 이들은 [Download Swift](https://swift.org/download/#releases) 에서 내려 받을 수 있습니다.

링크로 들어가보면 여러 버전의 Swift 가 있는데 맨 위의 Releases 에 있는 것을 다운받으면 됩니다. 표에서 **Ubuntu 16.04** 와  **(Signature)** 를 눌러서 2개의 파일을 내려 받습니다. [^swift-releases]

리눅스용 패키지는 tar 압축 파일로 되어 있으며 Swift 컴파일러, lldb 그외 기타 관련 도구들을 포함하고 있습니다.

### 설치

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
	> 경로 설정은 [리눅스 PATH 설정](http://egloos.zum.com/silve2/v/4448383) 등의 글을 참고하여 **~/.bash_profile** 파일에 다음과 같이 설정했습니다. [^egloos-4448383] [^blueskywithyou-32] [^superad-path]
	>
	> ```
	> PATH=$PATH:$HOME/bin:/.../swift/usr/bin
	> ```

설치는 끝났습니다. 이제 `swift` 명령으로 [REPL](https://en.wikipedia.org/wiki/Read–eval–print_loop) 를 실행하거나 Swift 프로젝트를 빌드할 수 있습니다. [^repl]

### REPL 사용하기

리눅스에서 REPL 을 실행하려면 터미널에서 아래와 같이 `swift` 명령을 입력하면 됩니다.

```
$ swift
```

그러면 프롬프터가 나타나면서 Swift 를 사용할 수 있습니다. REPL 로 Swift 언어를 익히는 것은 공식 블로그의 [Getting Started](https://swift.org/getting-started/) 글을 보고 따라하면서 실습하면 됩니다.

#### 시스템 모듈

맥과는 다르게 리눅스에서는 [**Glibc**](https://en.wikipedia.org/wiki/GNU_C_Library) 라는 모듈을 불러올 수 있습니다. [^wikipedia-gnu-c] [^wikipedia-gnu-c-ko] 이 모듈은 Swift 에서 표준 C 코드를 사용할 수 있게 하는 것으로 추측됩니다.

```
1> import Glibc
```

이 모듈을 불러오면 `fopen` 같은 C 함수들을 사용할 수 있습니다.

### 패키지 관리자 사용하기

패키지 관리자는 라이브러리를 만들기도 하지만, 실행 파일을 만들 때도 사용됩니다. 그리고 여러 프로젝트 사이에서 코드를 공유하도록 해주기도 합니다.

패키지 관리자 도구에는 `swift package`, `swift build`, `swift test` 가 있습니다.

아래와 같이 해서 패키지 관리자가 실행되는지 확인합니다.

```
$ swift package --help
```

#### 패키지 만들기

> 이 부분부터는 [Getting Started](https://swift.org/getting-started/) 의 **Creating a Package** 에 있는 예제를 그대로 따라서 진행하도록 합니다.

프로젝트를 담을 디렉토리를 하나 만들고 해당 디렉토리로 이동합니다.

```
$ mkdir Hello
$ cd Hello
```

모든 패키지들은 **Package.swift** 라고 하는 관리 목록(manifest) 파일을 최상위 디렉토리에 가지고 있어야 합니다. 아래와 같이 하면 패키지를 만들 수 있습니다.

```
$ swift package init
```

명령을 실행하고 나면 해당 폴더에 아래와 같은 디렉토리와 파일들이 생깁니다.

```
├── Package.swift
├── Sources
│   └── Hello.swift
└── Tests
    ├── HelloTests
    │   └── HelloTests.swift
    └── LinuxMain.swift
```

이제 `swift build` 명령으로 패키지를 빌드할 수 있습니다. 이 명령은 관리 목록(manifest) 파일에 기록되어 있는 의존 파일들을 찾아서 다운로드 하고 컴파일 합니다.

패키지에 대한 테스트를 실행하려면 `swift test` 를 사용합니다.

#### 실행 파일 만들기

패키지에 **main.swift** 라는 파일을 담고 있으면 실행파일로 간주합니다. 패키지 관리자는 그 파일을 바이너리 실행 파일로 컴파일하게 됩니다.

일단 "Hello" 를 출력하는 `Hello` 실행 파일을 만드는 방법을 알아봅니다.

여기서는 일단 바로 전에 만들었던 `Hello` 디렉토리를 지우고 새로 만듭니다. 아니면 프로젝트나 디렉토리 이름을 다른 이름으로 해도 됩니다. 

새로 만든 `Hello` 디렉토리로 이동합니다.

```
$ mkdir Hello
$ cd Hello
```

패키지 관리자에 아래와 같이 실행 파일 옵션을 줘서 프로젝트를 만듭니다.

```
$ swift package init --type executable
```

생성되는 파일 및 디렉토리는 다음과 같습니다.

```
├── Package.swift
├── Sources
│   └── main.swift
└── Tests
```

아래와 같이 패키지를 컴파일합니다.

```
$ swift build
```

빌드 결과는 **.build** 디렉토리에 생깁니다. 이름에서 숨겨진 디렉토리임을 알 수 있습니다. 아래와 같이 **Hello** 프로그램을 실행합니다.

```
$ .build/debug/Hello
Hello, world!
```

결과로 `Hello, world!` 가 출력되는 것을 볼 수 있습니다.

> 참고로 에러가 발생할 경우에 디버그 정보는 **debug.yaml** 파일, 즉, **YAML** 양식으로 저장되는 것 같습니다.

### 여러 소스 파일 다루기

**Sources/** 디렉토리에 **Greeter.swift** 라는 새 파일을 만들고 다음과 같이 입력합니다. 코드 편집은 원하는 아무 편집기를 사용해도 상관없습니다. 리눅스의 경우 `vi` 나 `gedit` 를 사용할 수도 있습니다.

```
func sayHello(name: String) {
    print("Hello, \(name)!")
}
```

**main.swift** 파일은 아래와 같이 변경합니다:

```
if CommandLine.arguments.count != 2 {
    print("Usage: hello NAME")
} else {
    let name = CommandLine.arguments[1]
    sayHello(name: name)
}
```

호출하는 함수가 Hello 모듈의 일부이기 때문에 `import` 구문이 필요없습니다. [^access-control] 

> 그 외에도 터미널 명령줄에서 인자를 받아들이는 방식이 상당히 인상깊습니다.

`swift build` 를 실행해서 새 버전의 Hello 를 실험해 봅니다:

```
$ swift build
$ .build/debug/Hello `whoami`
```

출력 결과를 보면 위에서 인자로 넘긴 `whoami` 부분이 현재 로그인 사용자의 이름으로 대체되는 것을 확인할 수 있습니다.

### 고찰하기

이제 리눅스에서 Swift 프로젝트를 만들고 소스 코드를 편집해서 빌드할 수 있게 되었습니다. 이어서 리눅스에서 LLDB 디버거를 사용하는 부분과 간단한 Swift 예제 프로그램을 작성한 것도 정리할 예정입니다. 

Swift 패키지 관리자에 대해서 더 알고 싶으면 공식 블로그의 [Swift Package Manager](https://swift.org/package-manager/) 글을 참고 하면 됩니다. [^swift-package]

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

[^repl]: [REPL](https://en.wikipedia.org/wiki/Read–eval–print_loop) 은 Read–Eval–Print Loop 의 약자로 직역하면 읽고-실행하고-출력하는 것을 반복하는 것을 의미합니다. 프로그래밍에서 코드를 작성하면 한 줄씩 실행하면서 결과를 바로 볼 수 있도록 대화형으로 개발이 진행되는 방식을 의미하는 것 같습니다. 리눅스 터미널에서 `swift` 명령을 실행하면 이 REPL 방식으로 개발이 진행됩니다.

[^wikipedia-gnu-c]: 위키피디아에 있는 [GNU C Library](https://en.wikipedia.org/wiki/GNU_C_Library) 글에는 Glibc 에 대한 설명과 유래가 나옵니다. 일단 Glibc 는 GNU 프로젝트로 구현된 C 표준 라이브러리임을 알 수 있습니다.

[^wikipedia-gnu-c-ko]: Glibc 에 대한 한글 설명은 [GNU C 라이브러리](https://ko.wikipedia.org/wiki/GNU_C_라이브러리) 에 있는데 위키피디아 글 중에서 상당히 번역이 잘 된 글인 것 같습니다.

[^swift-package]: [Package Manager](https://swift.org/package-manager/#conceptual-overview) 는 Swift 의 패키지 관리자에 대한 설명을 한 글입니다. 특히 모듈 빌드 방법, 의존 파일 불러오기, 시스템 라이브러리 연결짓기 등에 대해서 잘 정리되어 있습니다.

[^access-control]: 이것은 Swift 언어의 접근 제어(Access Control) 방식과 관련이 있습니다. Swift 는 접근 제어를 파일 단위로 하는 독특한 성질을 가지고 있는데, Swift 에서는 클래스나 함수에 아무런 지시자를 달지 않으면 이들이 기본으로 `Internal` 특성을 가집니다. 따라서 같은 프로젝트 내에 있는 파일들에 대한 접근을 할 때는 따로 import 가 필요없어집니다.