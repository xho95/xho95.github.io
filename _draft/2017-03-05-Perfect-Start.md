Way Renderlich 자료 [Server Side Swift with Perfect: Getting Started](https://videos.raywenderlich.com/screencasts/server-side-swift-with-perfect-getting-started) 를 기준으로 Perfect 프레임웍을 사용해 봅니다. [^ray-perfect]

Perfect 는 HTTP, JSON, REST 등을 지원한다고 합니다. 

### 설치하기 

[Getting Started](http://perfect.org/docs/gettingStarted.html) 글을 참고해서 미리 필요한 것들을 설치합니다. [^perfect-started]

#### Swift 3.0

Swift 3

Swift Toolchain

위의 두 개는 애플 블로그를 통해서 설치할 수 있습니다.

#### Ubuntu Linux 준비물들

```sh
$ sudo apt-get install openssl libssl-dev uuid-dev
```

GitHub 의 [Install Swift 3.0.2 into an Ubuntu 16.04 System](https://github.com/PerfectlySoft/Perfect-Ubuntu) 라는 곳에서는 우분투에 필요한 것들을 한번에 설치할 수 있는 쉘 스크립트를 제공합니다. [^perfect-ubuntu] 여기에는 Perfect 뿐만 아니라 Postgre 도 포함되어 있습니다.

해당 페이지의 스크립트를 실행하고 나면 마지막에 아래와 같은 메시지가 뜹니다.

```sh
Linking ./.build/release/Perfect-Session-PostgreSQL-Demo
```

정작 예제를 어떻게 실행하는지에 대해서는 설명이 없는 것 같습니다. 이건 좀 더 살펴봐야할 것 같습니다. 

### 시작하기

#### Hello-Perfect 프로젝트 시작하기

다시 Ray 아저씨 설명을 따라서 실습해 봅니다. 적당한 폴더로 이동해서 아래의 명령으로 프로젝트를 만듭니다.

```sh
$ mkdir hello-perfect
$ cd hello-perfect
$ swift package init --type executable
```

위에서 `--type executable` 옵션은 프로젝트를 빌드할 때 실행 파일 형태로 만들도록 합니다. 

동영상에서는 Xcode 로 빌드하는 모습이 담겨있는데, 리눅스에서는 다음과 같이 빌드하면 됩니다. 

```sh
$ swift build
```

그리고 빌드가 끝나면 다음과 같이 실행하여 결과를 출력합니다. 

```sh
$ .build/debug/hello-perfect

Hello, world!
```

위와 같이 결과가 출력됩니다. 여기까지는 그냥 순수한 Swift 테스트입니다. 

이제 Perfect 프레임웍을 이용한 실습을 해 봅니다.

#### Perfect 패키지 추가하기

**package.swift** 파일에 다음과 같이 dependencies 를 추가합니다. 

파일을 편집할 때 리눅스에서는 자신이 원하는 에디터로 편집하면 되는데 저는 Atom 문서 편집기를 사용합니다. 

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

macOS 와 리눅스에서는 설치되는 패키지가 조금 다른 것 같습니다. 

그리고 패키지 설치가 끝나면 다음과 같이 **main.swift** 파일에 3개의 모듈을 import 합니다.

```swift
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

print("Hello, world!)
```

앞서와 같이 터미널에서 `swift build` 를 실행해보면 문제없이 빌드되는 것을 알 수 있습니다. 

이제 실제 서버에서 보여줄 파일과 서버 동작에 필요한 코딩을 추가합니다. 

#### 서버 파일 만들기

다음과 같이 폴더와 파일을 추가합니다. 맥과 리눅스에서 동일하게 수행할 수 있습니다.

```sh
$ mkdir webroot
$ touch webroot/hello.txt
```

적당한 문서 편집기로 hello.txt	 파일의 내용을 아래와 같이 만들어 줍니다. 

```txt
Hello, web server!
```

#### 서버 관련 코딩하기

이제 main.swift 파일을 다음과 같이 고칩니다. 

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
	print("Network error thrown: \(err) \(msg))
}
```

터미널에서 프로젝트를 빌드하고 실행합니다. 리눅스에서는 폴더 위치를 바꾸주는 작업은 안해도 되는 것 같습니다. 

```
$ swift build
$ .build/debug/hello-perfect

[INFO] Starting HTTP server on 0.0.0.0:8080
```

그러면 다음과 같이 브라우저에서 동작하는 것을 볼 수 있습니다.

_그림 넣기_

#### Router 추가하기

main.swift 에 다음과 같이 추가합니다. 

```
var routes = Routes()

routes.add(method: .get, uri: "/", handler: {
	request, response in
	response.setBody(string: "Hello, Perfect!")
		.completed()
})

server.addRoutes(routes)
``` 

빌드하고 실행해 봅니다. 브라우저에서 `localhost:8080/` 으로 접속하면 다음과 같이 나타나는 것을 볼 수 있습니다. 

```
Hello, Perfect!
```

#### JSON API 추가하기

```
func returnJSONMessage(message: String, response: HTTPResponse) {
	do {
		try response.setBody(json: ["message": message])
			.setHeader(.contentType, value: "application/json")
			.completed()
	} catch {
		response.setBody(string: "Error handling request: \(error)")
			.completed(status: .internalServerError)
	}
}

routes.add(method: .get, uri: "/hello", handler: {
	request, response in 
	returnJSONMessage(message: "Hello, JSON!", response: response)
})
```

빌드하고 실행해 봅니다. 브라우저에서 `localhost:8080/hello` 로 접속하면 다음과 같이 JSON 결과를 볼 수 있습니다. 

```
{"message":"Hello, JSON!"}
```

#### 매개 변수를 받아서 JSON 으로 출력하기

소스는 복사해옵니다. 

어쨌든 됩니다. 

#### POST 수행하기

소스는 복사해옵니다.

리눅스에서 어떻게 테스트할 수 있는지 알아봅니다. 

테스트는 Firefox 에 RESTED 라는 Add on을 설치해서 할 수 있습니다. 

```
{
	"message": "Hello, xho95!"
}
```




### 참고 자료

[^ray-perfect]: [Server Side Swift with Perfect: Getting Started](https://videos.raywenderlich.com/screencasts/server-side-swift-with-perfect-getting-started)

[^perfect-started]: [Getting Started](http://perfect.org/docs/gettingStarted.html)

[^perfect-ubuntu]: [Install Swift 3.0.2 into an Ubuntu 16.04 System](https://github.com/PerfectlySoft/Perfect-Ubuntu)