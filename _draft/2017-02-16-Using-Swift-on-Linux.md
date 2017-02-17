여기서는 리눅스에서 Swift 를 사용하기 위한 방법을 정리합니다. 

Swift를 사용하기 위해서는 먼저 컴파일러와 필수 요소들을 설치해야 합니다. 이들은 [Download Swift](https://swift.org/download/#releases) 라는 곳에서 받을 수 있습니다. [^swift-download]

리눅스용 패키지는 **tar** 압축 파일로 되어 있으며 Swift 컴파일러, lldb 그외 기타 관련 도구들을 포함하고 있습니다. **PATH** 만 연결되어 있으면 설치 위치는 상관없습니다. 

### 설치

1. 필수 의존 파일들을 설치합니다. 

	```
	$ sudo apt-get install clang libicu-dev
	```
	
	> 무슨 파일인지는 나중에 정리해 봅니다. 

2. 마지막 바이너리 파일을 다운 받습니다. 

	**swift-\<VERSION\>-\<PLATFORM\>.tar.gz** 파일은 그 자체로 툴체인입니다. **.sig** 파일은 디지털 서명 파일입니다.
	
	> 이 글을 작성하고 있는 시점에서의 최신 파일은 각각 **swift-3.0.2-RELEASE-ubuntu16.04.tar.gz** 와 **swift-3.0.2-RELEASE-ubuntu16.04.tar.gz.sig** 입니다.
	
3. Swift 패키지를 처음으로 다운로드하는 경우 PGP 키를 키링으로 가져오라고 합니다. 근데 뭔가 잘 안되는 것 같습니다. 

	```
	$ gpg --keyserver hkp://pool.sks-keyservers.net \
         --recv-keys \
         '7463 A81A 4B2E EA1B 551F  FBCF D441 C977 412B 37AD' \
         '1BE1 E29A 084C B305 F397  D62A 9F59 7F4D 21A5 6D5F' \
         'A3BA FD35 56A5 9079 C068  94BD 63BC 1CFE 91D3 06C6'
	```
	
	코드가 길어서 복사했는데 왜 에러가 나는지 모르겠습니다. 
	
	이것 보다는 바로 아래에 있는 것이 속이 더 편한 것 같습니다. 
	
	```
	$ wget -q -O - https://swift.org/keys/all-keys.asc | \
	  gpg --import -
	```
	
	한 번에 다 받는 명령 같습니다. 
	
4. [PGP](https://ko.wikipedia.org/wiki/PGP_(소프트웨어)) 서명의 유효 검사를 합니다. [^wikipedia-pgp] [^jinbo-pgp]

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
	
	유효 검사가 잘 안될 때는 같은 문서의 **Active Signing Keys** 부분을 보고 따라하면 된다고 합니다.  
		
5. 압축을 풉니다. 아래와 같이 하면 됩니다.

	```
	$ tar xzf swift-<VERSION>-<PLATFORM>.tar.gz
	```
	
	뭔가 **usr/** 디렉토리를 만든다고 합니다. 이것도 설명을 보고 추가합니다.
	
6. Swift 툴체인 경로를 추가합니다. 아래와 같이 합니다. 

	```
	$ export PATH=/path/to/usr/bin:"${PATH}"
	```
	
	> 위에서 **/path/to/** 부분에는 실제 usr 폴더가 위치하는 경로를 지정합니다.
	>  
	> export 사용법에 대해서 정리할 필요가 있습니다. [^crasy-145] [^blueskywithyou-32]
	>
	> 이렇게만 하면 매번 `export` 를 해줘야할 수도 있습니다. 좀 더 알아봅니다. **.bash_profile** 파일에 경로를 추가하는 방법이 더 좋을 것 같습니다. [^egloos-4448383] [^superad-path]
	
이제 `swift	` 명령으로 REPL 를 실행하거나 Swift 프로젝트를 빌드할 수 있습니다. 

### REPL 사용하기

Swift 문법이라 생략하지만 전체는 한 번 훑어 봤습니다.

#### 시스템 모듈

리눅스에서는 **Glibc** 라는 모듈을 불러올 수 있다고 합니다. [^swift-started]

```
1> import Glibc
```

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

### LLDB 디버거 사용하기

LLDB 디버거를 사용하면 Swift 프로그램을 한줄 한줄 실행하거나, 중지점을 설정하고, 프로그램 상태를 조사하고 변경할 수 있습니다.

예를 들어, 아래와 같이 `factorial(n:)` 함수가 있을 때, 함수 호출 결과를 프린트합니다:

```
func factorial(n: Int) -> Int {
    if n <= 1 { return n }
    return n * factorial(n: n - 1)
}

let number = 4
print("\(number)! is equal to \(factorial(n: number))")
```

위와 같이 **Factorial.swift** 파일을 만들고, `swiftc` 명령을 실행하는데, 파일 이름을 명령줄의 인자로 전달하고, `-g` 옵션을 붙여서 디버그 정보를 생성하도록 합니다. 이렇게 하면 현재 디렉토리에 **Factorial** 이라는 실행 파일이 생깁니다.

```
$ swiftc -g Factorial.swift
$ ls
Factorial.dSYM
Factorial.swift
Factorial*
```

실제로는 `Factorial` 실행 파일만 생겨납니다. 왜 조금 다른지는 모르겠습니다.

**Factorial** 프로그램을 직접 실행하지 말고, 명령줄에서 `lldb` 명령의 인자로 넘겨서 **LLDB** 디버거를 작동합니다.

```
$ lldb Factorial
(lldb) target create "Factorial"
Current executable set to 'Factorial' (x86_64).
```

이렇게 하면 LLDB 명령을 실행하도록 하는 대화형 콘솔이 시작됩니다.

> LLDB 명령에 대해서 더 알고 싶으면 [LLDB Tutorial](http://lldb.llvm.org/tutorial.html) 을 보기 바랍니다.

`breakpoint set` (`b`) 명령을 사용해서 `factorial(n:)` 함수의 두번째 줄에 중지점을 지정합니다. 함수가 실행될 때마다 해당 지점에서 실행이 중지됩니다. 

```
(lldb) b 2
Breakpoint 1: where = Factorial`Factorial.factorial (Swift.Int) -> Swift.Int + 12 at Factorial.swift:2, address = 0x0000000100000e7c
```

`run` (`r`) 명령으로 프로세스를 실행합니다. 프로세스는 `factorial(n:)` 함수의 호출 지점(?)에서 멈출 것입니다.

```
(lldb) r
Process 40246 resuming
Process 40246 stopped
* thread #1: tid = 0x14dfdf, 0x0000000100000e7c Factorial`Factorial.factorial (n=4) -> Swift.Int + 12 at Factorial.swift:2, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x0000000100000e7c Factorial`Factorial.factorial (n=4) -> Swift.Int + 12 at Factorial.swift:2
   1    func factorial(n: Int) -> Int {
-> 2        if n <= 1 { return n }
   3        return n * factorial(n: n - 1)
   4    }
   5
   6    let number = 4
   7    print("\(number)! is equal to \(factorial(n: number))")
```

`print` (`p`) 명령을 사용해서 `n` 매개 변수의 값을 검사할 수 있습니다.

```
(lldb) p n
(Int) $R0 = 4
```

`print` 명령은 Swift 수식도 계산할 수 있습니다.

```
(lldb) p n * n
(Int) $R1 = 16
```

`backtrace` (`bt`) 명령을 사용하면 to show the frames leading to `factorial(n:)` 가 호출되었을 때의 프레임 앞부분(?) 을 볼 수 있습니다.

```
(lldb) bt
* thread #1: tid = 0x14e393, 0x0000000100000e7c Factorial`Factorial.factorial (n=4) -> Swift.Int + 12 at Factorial.swift:2, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
  * frame #0: 0x0000000100000e7c Factorial`Factorial.factorial (n=4) -> Swift.Int + 12 at Factorial.swift:2
    frame #1: 0x0000000100000daf Factorial`main + 287 at Factorial.swift:7
    frame #2: 0x00007fff890be5ad libdyld.dylib`start + 1
    frame #3: 0x00007fff890be5ad libdyld.dylib`start + 1
```

`continue` (`c`) 명령을 사용해서 프로세스를 재실행할 수 있으며 중지점이 다시 나타날 때까지 실행됩니다.

```
(lldb) c
Process 40246 resuming
Process 40246 stopped
* thread #1: tid = 0x14e393, 0x0000000100000e7c Factorial`Factorial.factorial (n=3) -> Swift.Int + 12 at Factorial.swift:2, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x0000000100000e7c Factorial`Factorial.factorial (n=3) -> Swift.Int + 12 at Factorial.swift:2
   1    func factorial(n: Int) -> Int {
-> 2        if n <= 1 { return n }
   3        return n * factorial(n: n - 1)
   4    }
   5
   6    let number = 4
   7    print("\(number)! is equal to \(factorial(n: number))")
```

`print` (`p`) 명령을 다시 사용해서 두번째로 `factorial(n:)` 가 호출되었을 때의 `n` 매개 변수의 값을 조사합니다.

```
(lldb) p n
(Int) $R2 = 3
```

`breakpoint disable` (`br di`) 명령을 사용해서 모든 중지점들을 해제하고 `continue` (`c`) 명령으로 끝까지 프로세스를 실행합니다.

```
(lldb) br di
All breakpoints disabled. (1 breakpoints)
(lldb) c
Process 40246 resuming
4! is equal to 24
Process 40246 exited with status = 0 (0x00000000)
```

이제 Swift REPL, 빌드 시스템, 그리고 디버거까지 살펴봤습니다. 여기에 다음으로 할 것들을 몇가지 제안합니다:

* [Package Manager project page](https://swift.org/package-manager/) 를 살펴보면 Swift의 빌드 시스템과 패키지 관리자에 대해서 더 깊이 이해할 수 있습니다. [^swift-package-manager]
* [Contributing to Swift](https://swift.org/contributing/) 를 읽고 Swift 커뮤니티에 참여할 수 있는 다양한 방법들을 알아보십시오. [^swift-contributing]
* [developer.apple.com/swift](https://developer.apple.com/swift/resources/) 에 가면 비디오, 예제 코드, 그리고 플레이그라운드 파일을 포함하는 추가적인 Swift 학습물들을 만날 수 있습니다. [^developer-resources]

### 참고 자료

[^swift-download]: [Download Swift](https://swift.org/download/#releases) : 리눅스에 Swift 를 사용하기 위해 컴파일러와 필수 요소들을 설치하는 방법을 설명하고 있는 애플 공식 문서입니다.

[^wikipedia-pgp]: [PGP](https://ko.wikipedia.org/wiki/PGP_(소프트웨어)) : PGP 는 컴퓨터 파일을 암호화하고 복호화하는 프로그램의 하나로, GNU 프로젝트의 하나인 GnuPG로도 개발되어 전 세계적으로 광범위하게 사용되고 있다고 합니다.

[^jinbo-pgp]: [공개키 암호화와 PGP에 대한 소개](https://guide.jinbo.net/digital-security/communication-security/introduction-public-key-encryption) : 좋은 내용이지만 원문을 번역하면서 문장이 조금 매끄럽지 않게 된 것 같습니다.

[^crasy-145]: [Swift: Linux에서 Swift 시작해보기](http://crasy.tistory.com/145)

[^blueskywithyou-32]: [리눅스에서 PATH(환경변수) 관련 설정 및 참고 내용](http://blueskywithyou.tistory.com/32)

[^swift-started]: [Getting Started](https://swift.org/getting-started/)

[^swift-package-manager]: [Package Manager project page](https://swift.org/package-manager/)

[^swift-contributing]: [Contributing to Swift](https://swift.org/contributing/)

[^developer-resources]: [developer.apple.com/swift](https://developer.apple.com/swift/resources/)

[^egloos-4448383]: [리눅스 PATH 설정](http://egloos.zum.com/silve2/v/4448383)

[^superad-path]: [리눅스 명령어 PATH 설정하기](http://superad.tistory.com/entry/리눅스-명령어-PATH설정하기) : 조금 더 설명이 자세합니다. 나중에 따로 리눅스 PATH 설정하는 방법과 **~/.bash_profile** 및 **~/.bashrc** 파일들의 차이에 대해서 정리해야겠습니다. 또 **/etc/profile** 및 **/etc/bashrc** 파일도 있습니다. 이들은 전체 사용자를 위한 경로 또는 환경 설정 파일입니다.