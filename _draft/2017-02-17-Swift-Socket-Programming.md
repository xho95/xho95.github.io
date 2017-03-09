Swift 로 소켓(Socket) 프로그래밍을 하는 방법을 정리하고자 합니다. 

일단 소켓 프로그래밍에 대한 내용을 분리하도록 합니다. 

### 프레임웍

[BlueSocket](https://github.com/IBM-Swift/BlueSocket) : IBM 에서 만든 Swift 를 위한 Socket framework 입니다. [^ibm-bluesocket] 설명도 잘 갖춰진 것 같습니다. BlueSocket 에서 SSL/TLS 를 지원하려면 [BlueSSLService](https://github.com/IBM-Swift/BlueSSLService) 가 필요한 것 같습니다. 

[swiftysockets](https://github.com/iachievedit/swiftysockets) : IBM 의 BlueSocket 보다는 조금 오래돼서 지금은 업데이트가 잘 안되고 있는 패키지인 것 같습니다. [^swiftysockets] 개발자가 신경을 안쓰고 있는 분위기 입니다. 

[Socket.IO-Client-Swift](https://github.com/socketio/socket.io-client-swift) [^socket-io-client]

[WebSockets](https://www.perfect.org/docs/webSockets.html) : Perfect.org 에서 만든 패키지인 것 같습니다. [^perfect-websockets] 웹소켓이란 개념은 웹페이지와 서버 사이에 실시간 상호작용을 하기 위한 스펙 (?) 이라고 합니다. [^adrenal-20] 네이버에 있는 글도 보면 좋을 것 같습니다. [^d2-1336]

### 블로그 글

[Multi-Client echo server with the BlueSocket framework and libdispatch](http://masteringswift.blogspot.kr/2017/01/multi-client-echo-server-with.html) [^masteringswift] : IBM 의 BlueSocket 을 사용하는 것과 관련한 블로그 글입니다.

[TCP Sockets with Swift on Linux](http://dev.iachieved.it/iachievedit/tcp-sockets-with-swift-on-linux/)

일단 아래의 내용은 전체를 한 번 봐둬야 할 것 같습니다. 총 9개의 글타래가 있습니다. [Notes from a Swift developer](http://swiftrien.blogspot.kr) 블로그에 있는 글들입니다. [^swiftrien-socket-1]

* [Socket Programming in Swift: Part 1 - getaddrinfo](http://swiftrien.blogspot.kr/2015/10/socket-programming-in-swift-part-1.html)
* [Socket Programming in Swift: part 2 - socket and setsockopt](http://swiftrien.blogspot.kr/2015/10/socket-programming-in-swift-part-2.html)
* [Socket Programming in Swift: part 3 - bind & listen](http://swiftrien.blogspot.kr/2015/11/socket-programming-in-swift-part-3-bind.html)
* [Socket programming in Swift: part 4 - SW design considerations](http://swiftrien.blogspot.kr/2015/11/socket-programming-in-swift-part-4-sw.html)
* [Socket Programming in Swift: part 5 - accept](http://swiftrien.blogspot.kr/2015/11/socket-programming-in-swift-part-4.html)
* [Socket Programming in Swift: Part 6 - select and recv](http://swiftrien.blogspot.kr/2015/11/socket-programming-in-swift-part-5.html)
* [Socket Programming in Swift: Part 7 - Client side considerations](http://swiftrien.blogspot.kr/2016/01/socket-programming-in-swift-part-7.html)
* [Socket Programming in Swift: Part 8 - Server side considerations](http://swiftrien.blogspot.kr/2016/02/socket-programming-in-swift-part-8.html)
* [Socket Programming in Swift: Part 9 - SwifterSockets](http://swiftrien.blogspot.kr/2016/03/socket-programming-in-swift-part-9.html)

### Network 책

[Beej's Guide to Network Programming](http://beej.us/guide/bgnet/) [^beej-guide]

### Chatting

[Swift Tutorial: Building an iOS Chat App Using Socket.IO](http://www.appcoda.com/socket-io-chat-app/) [^appcoda-socket]

### 참고 자료

[^ibm-bluesocket]: [BlueSocket](https://github.com/IBM-Swift/BlueSocket)

[^perfect-websockets]: [WebSockets](https://www.perfect.org/docs/webSockets.html)

[^adrenal-20]: [webSocket 으로 개발하기 전에 알고 있어야 할 것들](http://adrenal.tistory.com/20)

[^d2-1336]: [WebSocket과 Socket.io](http://d2.naver.com/helloworld/1336) : 좋은 글인 것 같습니다.

[^appcoda-socket]: [Swift Tutorial: Building an iOS Chat App Using Socket.IO](http://www.appcoda.com/socket-io-chat-app/)

[^swiftrien-socket-1]: [Socket Programming in Swift: Part 1 - getaddrinfo](http://swiftrien.blogspot.kr/2015/10/socket-programming-in-swift-part-1.html) : 아주 좋은 내용인 것 같습니다. 나중에 숙지해야할 것 같습니다. 이후로 시리즈가 이어집니다.

[^beej-guide]: [Beej's Guide to Network Programming](http://beej.us/guide/bgnet/) : 무료로 볼 수 있는 네트워크 프로그래밍 책입니다. [BeeJ's Guide to Network Programming 번역판](https://wiki.kldp.org/Translations/html/Socket_Programming-KLDP/Socket_Programming-KLDP.html) 은 akldp 에서 번역한 듯 합니다. <http://keywordteam.net/Socket_Programming-KLDP.html> 로도 갈 수 있습니다.

[^swiftysockets]: [swiftysockets](https://github.com/iachievedit/swiftysockets)

[^socket-io-client]: [Socket.IO-Client-Swift](https://github.com/socketio/socket.io-client-swift)

[^masteringswift]: [Multi-Client echo server with the BlueSocket framework and libdispatch](http://masteringswift.blogspot.kr/2017/01/multi-client-echo-server-with.html)

