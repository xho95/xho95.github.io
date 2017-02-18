여기서는 리눅스에서 Swift 를 사용하기 위한 방법을 정리합니다. 

Swift를 사용하기 위해서는 먼저 컴파일러와 필수 요소들을 설치해야 합니다. 이들은 [Download Swift](https://swift.org/download/#releases) 라는 곳에서 받을 수 있습니다. [^swift-download]

리눅스용 패키지는 **tar** 압축 파일로 되어 있으며 Swift 컴파일러, lldb 그외 기타 관련 도구들을 포함하고 있습니다. **PATH** 만 연결되어 있으면 설치 위치는 상관없습니다. 

### 설치

1. 필수 의존 파일들을 설치합니다. 

	```
	$ sudo apt-get install clang libicu-dev
	```
	
	**clang** 과 **lib** 를 설치하고 있습니다. 
	
	> 무슨 파일인지는 나중에 정리해 봅니다. 

2. 가장 최근 버전의 설치 파일을 내려 받습니다. 

	**swift-\<VERSION\>-\<PLATFORM\>.tar.gz** 파일은 그 자체로 툴체인입니다. **.sig** 파일은 디지털 서명 파일입니다.
	
	> 이 글을 작성하고 있는 시점에서의 최신 파일은 각각 **swift-3.0.2-RELEASE-ubuntu16.04.tar.gz** 와 **swift-3.0.2-RELEASE-ubuntu16.04.tar.gz.sig** 입니다. 
	>
	> 툴체인이라는 용어의 의미가 무엇인지도 정리합니다.
	
3. Swift 패키지를 처음으로 다운로드하는 경우 [PGP](https://ko.wikipedia.org/wiki/PGP_(소프트웨어)) 키를 키링으로 가져오라고 합니다. [^wikipedia-pgp] [^jinbo-pgp]

	홈페이지에 두 가지 방식으로 설명이 되어 있는데 두번째 방식이 좀 더 깔끔한 것 같습니다. 터미널에서 아래와 같이 해주면 됩니다.
	
	```
	$ wget -q -O - https://swift.org/keys/all-keys.asc | \
	  gpg --import -
	```
	
	그러면 해당 서버에서 PGP 관련 파일들을 받는 것 같습니다.
	
4. PGP 서명의 유효 검사를 합니다.

	먼저 아래 명령을 수행합니다. 뭔가 새로 고침 비슷한 거 같습니다. 
	
	```
	$ gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift
	```
	
	그리고 유효 검사를 합니다. 
	
	```
	$ gpg --verify swift-<VERSION>-<PLATFORM>.tar.gz.sig
...
gpg: Good signature from "Swift Automatic Signing Key #1 <swift-infrastructure@swift.org>"
	```
	
	경고가 뜰 수 있다고 하는데 무시해도 된다고 합니다. 이건 나중에 애플 문서를 보고 내용을 채워 넣어야 합니다. 
	
	유효 검사가 잘 안될 때는 애플 문서의 **Active Signing Keys** 부분을 보고 따라하면 된다고 합니다. 이 과정은 문제가 있을 때만 합니다.  
		
5. 내려 받은 파일의 압축을 풉니다. 아래와 같이 하면 됩니다.

	```
	$ tar xzf swift-<VERSION>-<PLATFORM>.tar.gz
	```
	
	이렇게 압축을 풀면 사실상 설치가 된 것입니다. 하위에 **usr/** 디렉토리를 만든다고 합니다. 이것도 설명을 보고 추가합니다.
	
6. Swift 툴체인 경로를 추가합니다. 아래와 같이 합니다. 

	```
	$ export PATH=/path/to/usr/bin:"${PATH}"
	```
	
	> 위에서 **/path/to/** 부분에는 실제 usr 폴더가 위치하는 경로를 지정합니다.
	>  
	> export 사용법에 대해서 정리할 필요가 있습니다. [^crasy-145] [^blueskywithyou-32]
	>
	> 이렇게만 하면 매번 `export` 를 해줘야할 수도 있습니다. 좀 더 알아봅니다. **.bash_profile** 파일에 경로를 추가하는 방법이 더 좋을 것 같습니다. [^egloos-4448383] [^superad-path] 
	>
	> 저는 **~/.bash_profile** 파일에 아래와 같이 설정했습니다.
	>
	> ```
	> PATH=$PATH:$HOME/bin:/.../swift/usr/bin
	> ```
	>
	> 재부팅 후에도 잘 작동하는지 확인이 필요합니다.
	
이제 `swift	` 명령으로 **REPL** 를 실행하거나 Swift 프로젝트를 빌드할 수 있습니다. 

### REPL 사용하기

Swift 문법이라 생략하지만 전체는 한 번 훑어 봤습니다. 환경이 구성되어 있으면 매뉴얼대로 한 번 작성해 보면 됩니다. 

#### 시스템 모듈

리눅스에서는 **Glibc** 라는 모듈을 불러올 수 있다고 합니다. [^swift-started]

```
1> import Glibc
```

Glibc 에 대해서는 [GNU C Library](https://en.wikipedia.org/wiki/GNU_C_Library) 또는 [GNU C 라이브러리](https://ko.wikipedia.org/wiki/GNU_C_라이브러리) 글을 참고하시기 바랍니다. [^wikipedia-gnu-c] [^wikipedia-gnu-c-ko]

### 패키지 관리자 사용하기 

패키지 관리자는 라이브러리를 만들기도 하지만, 실행 파일을 만들 때도 사용되는 것 같습니다. 다른 프로젝트들 사이에서 코드를 공유하게도 해준다고 합니다.

패키지 관리자 도구는 `swift package`, `swift build` 그리고 `swift test` 입니다.

아래와 같이 해서 패키지 관리자가 실행되는지 확인합니다.

```
$ swift package --help
```

#### 패키지 만들기

특정 폴더로 이동합니다.

```
$ mkdir Hello
$ cd Hello
```

모든 패키지들은 **Package.swift** 라고 하는 관리 목록(manifest) 파일을 최상위 폴더에 가지고 있어야 한다고 합니다. 아래와 같이 해서 패키지를 만들 수 있습니다. 

```
$ swift package init
```

`tree` 명령을 설치하고 실행하면 다음과 같은 구조를 볼 수 있습니다. tree 명령을 설치하는 방법은 다른 글을 참고하시기 바랍니다. `$ sudo apt-get install tree` 을 하면 됩니다.

> 유용한 명령들 설치하기 와 같은 컨셉으로 관련 글들을 묶으면 좋을 것 같습니다.

```
├── Package.swift
├── Sources
│   └── Hello.swift
└── Tests
    ├── HelloTests
    │   └── HelloTests.swift
    └── LinuxMain.swift
```

`swift build` 명령으로 패키지를 빌드할 수 있습니다. 이 명령은 관리 목록(manifest) 파일에 기록되어 있는 의존 파일들을 찾아서 다운로드 하고 컴파일 합니다. 

패키지에 대한 테스트를 실행하려면 `swift test` 를 사용합니다.

#### 실행 파일 만들기

패키지에 **main.swift** 라는 파일을 담고 있으면 실행파일로 간주합니다. 패키지 관리자는 그 파일을 바이너리 실행 파일로 컴파일하게 됩니다.

일단 "Hello" 를 출력하는 `Hello` 실행 파일을 만드는 방법을 알아봅니다.

특정 폴더로 이동합니다.

```
$ mkdir Hello
$ cd Hello
```

패키지 관리자에 아래와 같이 실행 파일 옵션을 줘서 만듭니다.

```
$ swift package init --type executable
```

`tree` 로 확인해 보면 생성되는 파일은 다음과 같습니다. 

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

빌드 결과는 **.build** 디렉토리에 생깁니다. 아래와 같이 해서 **Hello** 프로그램을 실행합니다.

```
$ .build/debug/Hello
Hello, world!
```

> 참고로 에러가 발생할 경우에 디버그 정보는 **debug.yaml** 파일, 즉, **YAML** 양식으로 저장되는 것 같습니다.

### 여러 소스 파일 다루기

**Sources/** 디렉토리에 **Greeter.swift** 라는 새 파일을 만들고 다음과 같이 입력합니다.

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

터미널 명령줄에서 인자를 받아들이는 방식이 상당히 인상깊습니다. 호출하는 함수가 Hello 모듈의 일부이기 때문에 import 구문이 필요없습니다.

`swift build` 를 실행해서 새 버전의 Hello 를 실험해 봅니다:

```
$ swift build
$ .build/debug/Hello `whoami`
```

위의 결과에서 `whoami` 부분은 현재 로그인 사용자의 이름으로 대체됩니다.

> Swift 패키지 관리자에 대해서 더 알고 싶으면, 특히 모듈 빌드 방법, 의존 파일 불러오기, 시스템 라이브러리 연결짓기 등에 대해서 알고 싶으면, 웹사이트의 [Swift Package Manager](https://swift.org/package-manager/) 부분을 보기 바랍니다.

### 참고 자료

[^swift-download]: [Download Swift](https://swift.org/download/#releases) : 리눅스에 Swift 를 사용하기 위해 컴파일러와 필수 요소들을 설치하는 방법을 설명하고 있는 애플 공식 문서입니다.

[^wikipedia-pgp]: [PGP](https://ko.wikipedia.org/wiki/PGP_(소프트웨어)) : PGP 는 컴퓨터 파일을 암호화하고 복호화하는 프로그램의 하나로, GNU 프로젝트의 하나인 GnuPG로도 개발되어 전 세계적으로 광범위하게 사용되고 있다고 합니다.

[^jinbo-pgp]: [공개키 암호화와 PGP에 대한 소개](https://guide.jinbo.net/digital-security/communication-security/introduction-public-key-encryption) : 좋은 내용이지만 원문을 번역하면서 문장이 조금 매끄럽지 않게 된 것 같습니다.

[^crasy-145]: [Swift: Linux에서 Swift 시작해보기](http://crasy.tistory.com/145)

[^blueskywithyou-32]: [리눅스에서 PATH(환경변수) 관련 설정 및 참고 내용](http://blueskywithyou.tistory.com/32)

[^egloos-4448383]: [리눅스 PATH 설정](http://egloos.zum.com/silve2/v/4448383)

[^superad-path]: [리눅스 명령어 PATH 설정하기](http://superad.tistory.com/entry/리눅스-명령어-PATH설정하기) : 조금 더 설명이 자세합니다. 나중에 따로 리눅스 PATH 설정하는 방법과 **~/.bash_profile** 및 **~/.bashrc** 파일들의 차이에 대해서 정리해야겠습니다. 또 **/etc/profile** 및 **/etc/bashrc** 파일도 있습니다. 이들은 전체 사용자를 위한 경로 또는 환경 설정 파일입니다.

[^swift-started]: [Getting Started](https://swift.org/getting-started/)

[^wikipedia-gnu-c]: [GNU C Library](https://en.wikipedia.org/wiki/GNU_C_Library) : Glibc 에 대한 설명입니다.

[^wikipedia-gnu-c-ko]: [GNU C 라이브러리](https://ko.wikipedia.org/wiki/GNU_C_라이브러리) : Glibc 에 대한 한글 설명입니다. 

[^swift-package-manager]: [Package Manager project page](https://swift.org/package-manager/)

[^swift-contributing]: [Contributing to Swift](https://swift.org/contributing/) : Swift 프로젝트에 기여하는 방법을 설명한 글입니다. 

[^developer-resources]: [developer.apple.com/swift](https://developer.apple.com/swift/resources/) : 

