여기서는 IBM 에서 만든 BlueSocket 을 사용하여 간단한 소켓 통신 프로그램을 만들어 봅니다. 

### 프로젝트 만들기

적당한 폴더를 만듭니다. 

```
$ mkdir BlueSocket-Test
$ cd BlueSocket-Test
```

새 Swift 프로젝트를 만듭니다.

```
$ swift package init --type  executable
``` 

package.swift 파일을 다음과 같이 고칩니다.

```
import PackageDescription

let package = Package(
    name: "EchoServer",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/BlueSocket.git", majorVersion: 0, minor: 10),
    ]
)
```

패키지를 업데이트합니다. 

```
$ swift package update
```

BlueSocket 저장소에 있는 소스 코드를 입력합니다. 

프로젝트를 빌드합니다.

```
$ swift build
```

### 테스트하기

이제 다음과 같이 프로젝트를 실행합니다. 그러면 에코 서버가 동작하는 것을 볼 수 있습니다.

```
$ .build/debug/BlueSocket-Test

Swift Echo Server Sample
Connect with a command line window by entering 'telnet 127.0.0.1 1337'
Listening on port: 1337
``` 

이제 새 터미널 창에서 텔넷을 실행합니다. 

```
$ telnet 127.0.0.1 1337

trying 127.0.0.1...
Connected to 127.0.0.1.
Escape character is '^]'.
Hello, type 'QUIT' to end session
or 'SHUTDOWN' to stop server.
```

그러면 서버와 연결되고 아래와 같이 입력한 내용을 서버에서 다시 되돌려줍니다. 

_그림 넣기_

`SHUTDOWN` 을 입력해서 서버를 종료할 수도 있습니다.


### 참고 자료

[How to let IBM BlueSocket run on a GUI application and support multi connections](http://stackoverflow.com/questions/38653610/how-to-let-ibm-bluesocket-run-on-a-gui-application-and-support-multi-connections) : BlueSocket 관련 질문 답변 글입니다.

[How to let IBM BlueSocket run on a GUI application and support multi connections?](https://forums.developer.apple.com/thread/53272) : 애플 포럼에 같은 질문을 올린 것입니다.

[Using the BlueSocket framework to create an echo server](http://masteringswift.blogspot.kr/2017/01/using-bluesocket-framework-to-create.html) : BlueSocket 을 사용해서 Echo Server 를 만드는 방법을 간단하게 소개하고 있습니다. 

[Using the BlueSocket framework to create an Echo client](http://masteringswift.blogspot.kr/2017/01/using-bluesocket-framework-to-create_14.html) : BlueSocket 을 사용해서 Echo Client 를 만드는 방법을 간단하게 소개하고 있습니다. 

[ibm-swift’s modules](https://swiftmodules.com/ibm-swift)

[Swift Modules](https://swiftmodules.com)