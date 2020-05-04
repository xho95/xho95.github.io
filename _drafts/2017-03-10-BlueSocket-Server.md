이 글은 참고 자료를 정리한 것입니다. [^mastering-blue-server]

### Berkeley Socket

The Berkeley Socket API 표준으로 여겨지는 것이라고 합니다. 1983년에 만들어졌다고 합니다.

POSIX 사양에 일부로 들어갔다고 합니다. 

현재 소켓 프로그램들의 원형이 되는 것 같습니다. 

클라이언트 서버 아키텍처 기반이라고 합니다. 

서버와 클라이언트는 각각 다음의 역할을 합니다. 

* 서버 : 다른 장비와 선택된 자원을 나누는 장비입니다. 
* 클라이언트 : 나눈 자원을 사용하기 위하여 서버에 연결하는 장비입니다. 

인터넷은 클라이언트 서버 아키텍처의 하나의 예입니다. 

소켓 API 는 두 개의 핵심 프로토콜을 사용합니다. 

* TCP (Transmission Control Protocol) : web pages, e-mail
* UDP (User Datagram Protocol) : streaming video

macOS 의 커널인 Darwin 과 Linux 의 커널은 모두 POSIX 과 호환성을 갖고 있습니다. _좀 더 정확하게 알아봐야 합니다._

### Network Addressing

IP (Internet Protocol) 네트웍 상의 모든 장비는 IP 주소를 갖습니다.

IP 주소는 두 개의 목적을 가집니다. 호스트와 장소를 구별하는 것입니다. 

현재 IPv4, IPv6 두가지가 있습니다. 

각각에 대해서는 다음에 다시 정리합니다. 

IP 가 장비를 구별하기 위한 것이라면 장비 안에 있는 여러 응용 프로그램들을 구별하려면 포트 (Port) 를 사용해야 합니다. 

포트는 하나의 응용 프로그램 또는 프로세스로 특정한 소프트웨어가 만들어서 IP 네트웍에 연결된 장비의 통신 말단으로 제공하는 것입니다.

IP 주소는 연결할 장비를 인식하고, 포트는 연결할 응용 프로그램을 인식합니다.

디바이스는 2^16 = 65,536 개의 포트를 가지고 있으며 이 중에서 앞단의 1,024 개는 공통의 프로토콜로 이미 예약되어 있습니다. 예를 들면 HTTP, HTTPS, SSH, SMTP 등이 그것들입니다. 

### 소켓 서버 만들기

소켓 서버를 표준 라이브러리를 사용해서 직접 만들려면 Darwin 이나 Linux 등 프랫폼마다 조금씩 다른 부분을 고려해야 합니다.

하지만 BSD 소켓 클라이언트와 서버를 만들도록 해주는 프레임웍이 있습니다. 여기서는 IBM 의 BlueSocket 프레임웍을 사용합니다. 

일단 단일 쓰레드 서버를 만들고 나중에 멀티 쓰레드로 확장합니다. _관련 GitHub 저장소 링크를 연결합니다._ 

#### 시작하기

필요한 프레임웍을 import 합니다. 

```swift
#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

import Foundation
import Socket
```

**EchoServer** 클래스를 정의하고 속성을 추가합니다. 

```swift
class EchoServer {
    let bufferSize = 1024
    let port: Int
    var listenSocket: Socket? = nil
    var connected = [Int32: Socket]()
    var acceptNewConnection = true
}
```

각 속성에 대한 설명은 참고 자료를 통해서 정리하도록 합니다. 

이제 초기자와 정리자를 작성합니다. 

```
init(port: Int) {
    self.port = port
}

deinit {
    for socket in connected.values {
        socket.close()
    }
    
    listenSocket?.close()
}            
```

서버를 시작하기 위한 메소드를 추가합니다. 

```
func start() throws {
    let socket = try Socket.create()
    listenSocket = socket
    try socket.listen(on: port)
    print("Listening port: \(socket.listeningPort)")
    repeat {
        let connectedSocket = try socket.acceptClientConnection()
        print("Connection from: \(connectedSocket.remoteHostname)")
        newConnection(socket: connectedSocket)
    } while acceptNewConnection     
}
```

코드 설명도 추가합니다. 일단 try catch 구문을 안쓰는 이유도 있는 것 같습니다. 

create(), 
listen(on:) - bind the server to the port,
acceptClientConnection(),

이제 newConnection(socket:) 함수를 구현합니다. 

```
func newConnection(socket: Socket) {
    connected[socket.socketfd] = socket
    var cont = true
    var dataRead = Data(capacity: bufferSize)
    repeat {
        do {
            let bytes = try socket.read(into: &dataRead)
            if bytes > 0 {
                if let readStr = String(data: dataRead, encoding: .utf8) {
                    print("Received: \(readStr)")
                    try socket.write(from: readStr)
                    if readStr.hasPrefix("quit") {
                        cont = false
                        socket.close()
                    }
                    dataRead.count = 0
                }
            }
        } catch let error {
            print("error: \(error)")
        }
    } while cont
    connected.removeValue(forKey: socket.socketfd)
    socket.close()
}
```

설명을 추가합니다. 

connected[],
dataRead,
bufferSize,

read(into:),
dataRead,
write(from:),
cont,

이제 서버 인스턴스를 만들고 실행하는 코드를 추가합니다. 

```
let server = EchoServer(port: 3333)
    do {
        try server.start()
    } catch let error {
        print("Error: \(error)")
}    
```

이제 빌드하고 다음과 같이 telnet 을 실행해서 테스트를 수행합니다. 

```
$ telnet 127.0.0.1 3333
```

잘 동작하는 것 같습니다. 

서버는 다음과 같습니다. 

```
Listening port: 3333
Connection from: 127.0.0.1
```

클라이언트는 다음과 같습니다.

```
Trying 127.0.0.1...
Connected to 127.0.0.1.
Escape character is '^]'.
```

`quit` 를 입력하면 빠져 나옵니다. 

### Multi-Client Echo Server 만들기

이 글은 두번째 자료를 정리한 것입니다. [^mastering-multi-server]

앞의 서버는 single thread 기반이라 한 장비와만 통신합니다. 이번에는 GCD (libdispatch) 를 사용하여 multi thread server 를 만들도록 합니다. 

#### dispatch 프레임웍 추가하기 

```
import Dispatch
```

#### start() 고치기

별도의 쓰레드를 사용하도록 합니다. 

```
func start() throws {
    let socket = try Socket.create()

    listenSocket = socket
    try socket.listen(on: port)
    print("Listening port: \(socket.listeningPort)")
    let queue = DispatchQueue(label: "clientQueue.hoffman.jon", attributes: .concurrent)
    repeat {
        let connectedSocket = try socket.acceptClientConnection()
        print("Connection from: \(connectedSocket.remoteHostname)")
        queue.async{self.newConnection(socket: connectedSocket)}
    } while acceptNewConnection     
}
```

queue,
queue.async(),

이 두줄의 변화만으로 multi-client server 가 만들어 집니다. 

테스트해봅니다.




### 참고 자료

[^mastering-blue-server]: [Using the BlueSocket framework to create an echo server](http://masteringswift.blogspot.kr/2017/01/using-bluesocket-framework-to-create.html)

[^mastering-multi-server]: [Multi-Client echo server with the BlueSocket framework and libdispatch](http://masteringswift.blogspot.kr/2017/01/multi-client-echo-server-with.html)