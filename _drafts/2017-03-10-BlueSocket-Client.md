이 글은 참고 자료를 정리한 것입니다. [^mastering-blue-client]

이제 클라이언트 프로그램을 만들어 봅니다. 

### 클라이언트 만들기

#### package 업데이트 하기

package.swift 파일을 수정한 다음에 다음과 같이 패키지를 업데이트합니다. 

서버쪽 글도 같이 업데이트를 해줍니다. 

```
$ swift package update
```

#### EchoClient 클래스 만들기

```
#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

import Socket
import Foundation

class EchoClient {

}
```

#### 속성 추가하기

```
let bufferSize = 1024
let port: Int
let server: String
var listenSocket: Socket? = nil
```

bufferSize, 
port, 
server, 
listenSocket, 

#### 초기자와 정리자 추가하기

```
init(port: Int, server: String) {
    self.port = port
    self.server = server
}
   
deinit {
    listenSocket?.close()
}
```

#### 서버 연결 함수 만들기

```
func start() throws {
    let socket = try Socket.create()
    listenSocket = socket
    try socket.connect(to: server, port: Int32(port))
    var dataRead = Data(capacity: bufferSize)
    var cont = true
    repeat {
        print("Enter Text:")
        if let entered = readLine(strippingNewline: true) {
            try socket.write(from: entered)
            if entered.hasPrefix("quit") {
                cont = false
            }
            let bytesRead = try socket.read(into: &dataRead)
            if bytesRead > 0 {
                if let readStr = String(data: dataRead, encoding: .utf8) {
                    print("Received: '\(readStr)'")
                }       
                dataRead.count = 0
            }
        }
    } while cont
}
```

create(),
connect(to:port:),
dataRead,
bufferSize,
readLine(strippingNewline:),
write(from:),
cont,
read(into:),

#### 사용 코드 넣기

```
do {
    var echoClient = EchoClient(port: 3333, server: "127.0.0.1")
    try echoClient.start()
} catch let error {
    print("Error: \(error)")
}
```

다른 컴퓨터라면 해당 컴퓨터의 IP 주소를 넣어 봅니다. 






### 참고 자료

[^mastering-blue-client]: [Using the BlueSocket framework to create an Echo client](http://masteringswift.blogspot.kr/2017/01/using-bluesocket-framework-to-create_14.html)