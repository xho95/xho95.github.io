---
layout: post
pagination:
  enabled: true
comments: true
title:  "Swift: 리눅스에서 Swift 개발 시작하기"
date:   2017-03-06 10:30:00 +0900
categories: Linux Development Swift REPL Package Ubuntu
---

여기서는 Swift 공식 블로그 글인 [Getting Started](https://swift.org/getting-started/) 글을 번역 정리하면서 리눅스에서 Swift 로 개발하는 방법을 소개하도록 합니다. [^swift-started]

### 들어가며

리눅스에서 Swift 로 개발하기 위해서는 먼저 Swift 툴체인을 설치해야 합니다. Swift 툴체인을 설치하는 과정은 이전에 정리한 [Swift: 리눅스에서 Swift 개발 환경 구축하기]({% post_url 2017-02-16-Developing-Swift-on-Linux %}) 를 참고하면 됩니다.

Swift 개발 환경 구축을 마쳤으면 이제 Swift 개발을 시작해 봅시다.

### REPL 사용하기

[REPL](https://en.wikipedia.org/wiki/Read–eval–print_loop) 은 Read–Eval_(uate)_ –Print Loop 의 약자로 직역하면 읽고-실행하고-출력하는 것을 반복하는 것을 의미합니다. 프로그래밍에서 코드를 작성하면 한 줄씩 실행하면서 결과를 바로 볼 수 있도록 대화형으로 개발이 진행되는 방식을 말합니다. [^repl]

리눅스에서 REPL 을 실행하려면 터미널에서 아래와 같이 `swift` 명령을 입력하면 됩니다.

```
$ swift

Welcome to Apple Swift version 3.0.2 (swiftlang-800.0.63 clang-800.0.42.1). Type :help for assistance.
  1>  
```

그러면 프롬프터가 나타나면서 Swift 를 사용할 수 있습니다. [^exercise] 이것 저것 Swift 를 실습해 보도록 합니다.

REPL 에서 빠져 나올려면 `vi` 편집기에서 빠져나올 때 처럼 프롬프터에서 `:q` 를 입력하면 됩니다.

#### 시스템 모듈

Swift 의 경우 운영 체제별로 시스템 모듈을 불러와서 사용할 수 있도록 하고 있습니다. macOS 의 경우 **Darwin** 이라는 모듈을 사용할 수 있는데, 리눅스에서는 [**Glibc**](https://en.wikipedia.org/wiki/GNU_C_Library) 라는 모듈을 불러올 수 있습니다. [^wikipedia-gnu-c]

```
1> import Glibc
```

이 모듈은 Swift 에서 표준 C 코드를 사용할 수 있도록 하는 것으로 추측하는데, 왜냐면 이 모듈을 불러오면 `fopen` 같은 C 함수들을 사용할 수 있기 때문입니다.

### 패키지 관리자 사용하기

패키지 관리자는 라이브러리를 만들기도 하지만, 실행 파일을 만들 때도 사용됩니다. 그리고 여러 프로젝트 사이에서 코드를 공유하도록 해주기도 합니다.

패키지 관리자 도구에는 `swift package`, `swift build`, `swift test` 가 있습니다.

아래와 같이 해서 패키지 관리자가 실행되는지 확인합니다.

```
$ swift package --help
```

#### 패키지 만들기

프로젝트를 담을 디렉토리를 하나 만들고 해당 디렉토리로 이동합니다. [^example]

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

이제 `swift build` 명령으로 패키지를 빌드할 수 있습니다. 이 명령은 관리 목록 (manifest) 파일에 기록되어 있는 의존 파일들을 찾아서 다운로드 하고 컴파일합니다.

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

> 참고로 에러가 발생할 경우에 디버그 정보는 **debug.yaml** 파일, 즉, **YAML** 양식으로 저장되는 것 같습니다. [^yaml]

### 여러 소스 파일 다루기

**Sources/** 디렉토리에 **Greeter.swift** 라는 새 파일을 만들고 다음과 같이 입력합니다. 코드 편집은 원하는 아무 편집기를 사용해도 상관없습니다. 리눅스의 경우 `vi` 나 `gedit` 를 사용할 수도 있습니다. [^atom]

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

호출하는 함수가 Hello 모듈의 일부이기 때문에 `import` 구문이 필요없습니다. [^access-control] [^command-line]

`swift build` 를 실행해서 새 버전의 Hello 를 실험해 봅니다:

```
$ swift build
$ .build/debug/Hello `whoami`
```

출력 결과를 보면 위에서 인자로 넘긴 `whoami` 부분이 현재 로그인 사용자의 이름으로 대체되는 것을 확인할 수 있습니다.

축하합니다! 이제 리눅스에서 Swift 로 프로젝트를 만들고 실행 파일을 만들 수 있게 되었습니다.

### 관련 자료

* [Swift: 리눅스에서 Swift 개발 환경 구축하기]({% post_url 2017-02-16-Developing-Swift-on-Linux %})

### 참고 자료

[^swift-started]: Swift 공식 블로그에 있는 [Getting Started](https://swift.org/getting-started/) 는 REPL, 패키지 관리자, LLDB 디버거를 사용하는 방법을 설명한 글입니다.

[^repl]: 위키피디아의 [REPL](https://en.wikipedia.org/wiki/Read–eval–print_loop) 을 참고하면 좀 더 자세한 의미를 알 수 있습니다. 리눅스 터미널에서 `swift` 명령을 실행하면 이 REPL 방식으로 개발을 할 수 있습니다.

[^exercise]: 이 글에는 따로 REPL 을 사용하는 방법을 정리하지 않았는데, 이 부분은 Swift 언어를 공부하는 부분에 해당되기 때문에 직접 [Getting Started](https://swift.org/getting-started/) 의 REPL 부분을 보고 코딩을 해보거나 아니면 다른 Swift 책에 있는 예제를 실습해 보도록 합니다.

[^wikipedia-gnu-c]: 위키피디아에 있는 [GNU C Library](https://en.wikipedia.org/wiki/GNU_C_Library) 글에는 Glibc 에 대한 설명과 유래가 나옵니다. 일단 Glibc 는 GNU 프로젝트로 구현된 C 표준 라이브러리임을 알 수 있습니다. 한글 설명은 [GNU C 라이브러리](https://ko.wikipedia.org/wiki/GNU_C_라이브러리) 에 있는데 위키피디아 글 중에서 상당히 번역이 잘 된 글인 것 같습니다.

[^swift-package]: [Package Manager](https://swift.org/package-manager/#conceptual-overview) 는 Swift 의 패키지 관리자에 대한 설명을 한 글입니다. 특히 모듈 빌드 방법, 의존 파일 불러오기, 시스템 라이브러리 연결짓기 등에 대해서 잘 정리되어 있습니다.

[^example]: 이 부분부터는 [Getting Started](https://swift.org/getting-started/) 의 **Creating a Package** 에 있는 예제를 그대로 따라서 진행하도록 합니다.

[^yaml]: [YAML](https://en.wikipedia.org/wiki/YAML) 은 주로 환경 설정 파일에 사용되는 가벼운 형태의 마크업 언어입니다. 다만 YAML 에는 "YAML 은 마크업 언어가 아니다" 라는 뜻이 담겨 있다고 합니다.

[^atom]: 저의 경우 리눅스에서 Swift 로 개발할 때는 Atom 문서 편집기를 사용하는데, 리눅스에서 Atom 문서 편집기로 Swift 를 개발하는 방법에 대해서는 나중에 한 번 정리할 예정입니다.

[^access-control]: 이것은 Swift 언어의 접근 제어 (Access Control) 방식과 관계가 있습니다. Swift 는 접근 제어를 파일 단위로 하는 독특한 성질을 가지고 있는데, Swift 에서는 클래스나 함수에 아무런 접근 제어자가 없으면 기본으로 `internal` 특성을 가집니다. 따라서 같은 프로젝트 내에 있는 파일들에 대한 접근을 할 때는 따로 `import` 가 필요 없습니다.

[^command-line]: 그 외에도 터미널 명령줄에서 인자를 받아들이는 방식이 상당히 인상깊습니다. 이 부분에 대해서는 나중에 다시 정리해 보도록 하겠습니다.
