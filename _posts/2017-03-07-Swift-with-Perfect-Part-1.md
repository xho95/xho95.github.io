---
layout: post
comments: true
title:  "Swift: 리눅스에서 Perfect 프레임웍으로 서버 개발하기 (Part 1)"
date:   2017-03-07 01:30:00 +0900
categories: Linux Swift Perfect Package Server
redirect_from: "/linux/swift/perfect/package/server/2017/03/06/Swift-with-Perfect-Part-1.html"
---

리눅스에서 Swift 로 프로그램을 개발할 수 있음은 몇 번 말씀드린 적이 있습니다. 하지만 당장 Swift 로 무엇을 할지 고민하던 차에 마침 [Ray Wenderlich](https://www.raywenderlich.com) [^raywenderlich] 라는 곳에서 [Perfect](http://perfect.org/) [^perfect] 프레임웍을 사용하여 Swift 로 서버를 제작하는 방법을 정리한 동영상 강좌를 공개하였습니다.

이에 Ray Wenderlich 에서 공개한 [Server Side Swift with Perfect: Getting Started](https://videos.raywenderlich.com/screencasts/server-side-swift-with-perfect-getting-started) 라는 동영상을 보고 실습한 내용을 정리하도록 합니다. [^ray-perfect]

이를 기초로 리눅스에서 Swift 로 서버를 구현하는 방법을 간단하게나마 살펴볼 수 있을 것입니다.

### 들어가며

Perfect 는 Swift 를 위한 서버 프레임웍으로 HTTP, JSON, REST 등을 지원한다고 합니다. 마치 Swift 를 위한 Node.js 같은 것이라 이해하면 될 것 같습니다.

### 개발 환경 구축하기

일단 리눅스에서 필요한 것들을 설치해둬야 합니다. 당연히 가장 첫 순서는 리눅스에 Swift 를 설치하는 것입니다.

Swift 와 기타 필수 파일들을 따로 설치해도 되며, 귀찮은 분은 아래 목록에서 **설치 과정 한 방에 해결하기** 를 통해서 쉘 스크립트로 한 번에 모든 것을 설치할 수도 있습니다. [^install]

#### Swift 설치하기

리눅스에 Swift 를 설치하는 방법은 [Swift: 리눅스에서 Swift 개발 환경 구축하기]({% post_url 2017-02-16-Developing-Swift-on-Linux %}) 글을 참고하도록 합니다.

#### 리눅스에 필요한 요소들 설치하기

터미널에서 다음과 같은 명령으로 필수 요소들을 설치합니다. 주로 ssl 관련 라이브러리인 것 같습니다.

```sh
$ sudo apt-get install openssl libssl-dev uuid-dev
```

#### 설치 과정 한 방에 해결하기

Perfect 에서는 위에서 따로따로 설치한 것들을 한 방에 설치하도록 해주는 스크립트를 만들어서 공개했습니다.

GitHub 의 [Install Swift 3.0.2 into an Ubuntu 16.04 System](https://github.com/PerfectlySoft/Perfect-Ubuntu) 라는 곳에 가면 우분투에 필요한 것들을 한번에 설치할 수 있는 쉘 스크립트를 제공합니다. [^perfect-ubuntu]

여기에는 Perfect 뿐만 아니라 PostgreSQL, MySQL 등도 같이 설치해 줍니다. 일단 저의 경우 이미 설치된 것들이 있어도 큰 문제없이 설치 과정이 진행된 것 같습니다. [^db]

해당 페이지의 스크립트를 실행하고 나면 마지막에 아래와 같은 메시지가 뜹니다.

```sh
Linking ./.build/release/Perfect-Session-PostgreSQL-Demo
```

여기까지 진행되었으면 설치과정이 끝난 것입니다.

### 시작하기

이제 필요한 것들을 설치했으니 서버 개발을 시작할 차례입니다.

#### Hello-Perfect 프로젝트 시작하기

다시 Ray 아저씨 설명을 따라서 실습해 봅니다. 프로젝트 파일들을 위치할 폴더로 이동해서 아래의 명령으로 프로젝트를 만듭니다. [^swift-package]

```sh
$ mkdir hello-perfect
$ cd hello-perfect
$ swift package init --type executable
```

위에서 `--type executable` 옵션은 프로젝트의 빌드 결과를 실행 파일 형태로 만들도록하는 옵션입니다.

[Server Side Swift with Perfect: Getting Started](https://videos.raywenderlich.com/screencasts/server-side-swift-with-perfect-getting-started) 동영상을 보다 보면 이 시점에서 빌드를 Xcode 로 하고 있는데, 리눅스에는 Xcode 가 없다고 당황하지 말고 터미널에서 다음과 같은 명령으로 빌드하면 됩니다.

```sh
$ swift build
```

리눅스에서 Swift 로 개발하는 방법은 따로 [Swift: 리눅스에서 Swift 개발 시작하기]({% post_url 2017-03-06-Getting-Started-Swift-on-Linux %}) 라는 글로 정리하였으니 참고하시면 됩니다.

그리고 빌드가 끝나면 다음과 같이 실행하여 결과가 출력되는지를 확인합니다.

```sh
$ .build/debug/hello-perfect

Hello, world!
```

터미널에서 위와 같은 결과가 출력되면 빌드가 제대로 된 것입니다. 지금까지는 기본 프로젝트를 만들어서 빌드해 본 것으로 Swift 가 제대로 동작하는지 테스트해 본 것입니다.

이제 진짜로 Perfect 프레임웍을 이용해서 서버를 개발해 보도록 합시다.

#### Perfect 패키지 추가하기

**package.swift** 파일에 다음과 같이 dependencies 를 추가합니다. [^editor]

```swift
import PackageDescription

let package = Package(
    name: "hello-perfect",
    dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2)
	]
)
```

그다음 터미널에서 다음과 같이 패키지를 업데이트 해 줍니다.

```sh
$ swift package update
```

그러면 프로젝트에서 의존하고 있는 파일들을 자동으로 내려받게 됩니다. 맥과 리눅스에서는 설치되는 패키지가 조금 다른 것 같습니다만, 물론 큰 상관은 없습니다.

그리고 패키지 설치가 끝나면 다음과 같이 **main.swift** 파일에 3개의 모듈을 `import` 합니다. 서버 관련 모듈을 불러오는 것을 알 수 있습니다.

```swift
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

print("Hello, world!")
```

앞서와 같이 터미널에서 `swift build` 를 실행해보면 문제없이 빌드되는 것을 알 수 있습니다.

이제 실제 서버에서 보여줄 파일과 서버 동작에 필요한 코딩을 추가합니다.

#### 서버 파일 만들기

다음과 같이 폴더와 파일을 추가합니다. 이 명령은 맥과 리눅스에서 동일합니다.

```sh
$ mkdir webroot
$ touch webroot/hello.txt
```

적당한 문서 편집기로 **hello.txt** 파일의 내용을 아래와 같이 만들어 줍니다.

```txt
Hello, web server!
```

#### 서버 관련 코딩하기

이제 **main.swift** 파일을 다음과 같이 고칩니다.

```swift
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let server = HTTPServer()

server.serverPort = 8080
server.documentRoot = "webroot"

do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
```

터미널에서 프로젝트를 빌드하고 실행합니다. [^directory]

```sh
$ swift build
$ .build/debug/hello-perfect

[INFO] Starting HTTP server on 0.0.0.0:8080
```

서버가 동작하는 것을 볼 수 있습니다. 이제 다음과 같이 브라우저를 실행해서 `localhost:8080/hello.txt` 로 접속하면 아래와 같이 동작하는 것을 볼 수 있습니다.

![Perfect-Hello](/assets/Perfect/perfect-hello.png)

이로써 Perfect 프레임웍을 사용해서 Swift 로 서버 개발을 하는 방법을 간단하게나마 살펴보았습니다.

이어서 Part 2 에서는 Perfect 프레임웍에서 Route 를 추가하고 JSON API 를 만드는 방법을 실습하도록 합니다.

### 관련 자료

* [Swift: 리눅스에서 Perfect 프레임웍으로 서버 개발하기 (Part 2)]({% post_url 2017-03-10-Swift-with-Perfect-Part-2 %})

### 참고 자료

[^raywenderlich]: [Ray Wenderlich](https://www.raywenderlich.com) 는 iOS 를 비롯하여 Swift 강좌 사이트 중에서는 가히 최고봉이라 할 수 있는 사이트입니다. 한국 맥 사용자에게 [백투더맥](http://macnews.tistory.com) 사이트가 필수이듯, [Ray Wenderlich](https://www.raywenderlich.com) 는 Swift 개발자라면 필수인 사이트라고 생각합니다.

[^perfect]: [Perfect](http://perfect.org/) 는 캐나다에서 개발되고 있는 Swift 용 서버 프레임웍이라고 합니다. [Benchmarks for the Top Server-Side Swift Frameworks vs. Node.js](https://medium.com/@rymcol/benchmarks-for-the-top-server-side-swift-frameworks-vs-node-js-24460cfe0beb#.sk9acg3sw) 라는 자료를 보면 거의 종합 점수로는 1등을 달리고 있는 서버 프레임웍입니다. Node.js 를 성능으로 발라버린다고 하는데 거기까진 아직 잘 모르겠습니다.

[^ray-perfect]: 보통 Ray Wenderlich 사이트의 동영상 강좌는 유료인 경우가 많은데 가끔씩 무료인 동영상도 있습니다. [Server Side Swift with Perfect: Getting Started](https://videos.raywenderlich.com/screencasts/server-side-swift-with-perfect-getting-started) 가 그런 경우인 것 같습니다.

[^perfect-ubuntu]: [Install Swift 3.0.2 into an Ubuntu 16.04 System](https://github.com/PerfectlySoft/Perfect-Ubuntu) 에 가면 설명은 영어로 되어 있지만 회색으로 표시된 명령어들만 터미널에서 한 줄씩 실행하면 쉽게 설치할 수 있습니다. 물론 명령어들은 복사 붙여넣기가 가능하므로 타자를 칠 필요도 없습니다. 명령어들이 하는 일은 스크립트 파일을 GitHub 에서 내려 받은 다음 실행하는 것이 전부입니다.

[^install]: 저는 **설치 과정 한 방에 해결하기** 로 설치하기 전에 몇몇 요소들이 이미 설치된 상황이었는데 혹시 맨 처음부터 **설치 과정 한 방에 해결하기** 를 선택했는데 설치가 매끄럽지 않게 된 분이 계시면 댓글 달아 주시면 감사하겠습니다.

[^db]: 여기서는 설치만 하는 것으로 당장 데이터베이스를 가지고 뭔가를 실습하지는 않습니다. 이 과정은 따로 Perfect 홈페이지의 문서를 보고 실습해야할 것 같습니다.

[^swift-package]: Swift 패키지 관리자를 사용해서 프로젝트를 만드는 방법에 대해서는 [Swift: 리눅스에서 Swift 개발 시작하기]({% post_url 2017-03-06-Getting-Started-Swift-on-Linux %}) 글을 참고하도록 합니다.

[^editor]: 리눅스에서 Swift 파일을 편집할 때는 자신이 원하는 아무 편집기를 쓰면되는데 저는 Atom 문서 편집기를 사용합니다. Atom 편집기로 Swift 프로그래밍을 하는 과정은 조만간 정리할 예정입니다.

[^directory]: 동영상에서는 이 과정에서 Xcode 의 경로 설정 작업을 하고 있는데, 리눅스에서는 따로 디렉토리 위치를 바꾸주는 작업은 안해도 되는 것 같습니다. 정확한 이유는 잘 모르겠습니다.
