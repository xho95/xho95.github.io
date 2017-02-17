Swift 로 소켓(Socket) 프로그래밍을 하는 방법을 정리하고자 합니다. 

일단 아래의 내용은 전체를 한 번 봐둬야 할 것 같습니다. 총 9개의 글타래가 있습니다. [Notes from a Swift developer](http://swiftrien.blogspot.kr) 블로그에 있는 글들입니다.

* [Socket Programming in Swift: Part 1 - getaddrinfo](http://swiftrien.blogspot.kr/2015/10/socket-programming-in-swift-part-1.html) [^swiftrien-socket-1]
* [Socket Programming in Swift: part 2 - socket and setsockopt](http://swiftrien.blogspot.kr/2015/10/socket-programming-in-swift-part-2.html) [^swiftrien-socket-2]
* [Socket Programming in Swift: part 3 - bind & listen](http://swiftrien.blogspot.kr/2015/11/socket-programming-in-swift-part-3-bind.html) [^swiftrien-socket-3]
* [Socket programming in Swift: part 4 - SW design considerations](http://swiftrien.blogspot.kr/2015/11/socket-programming-in-swift-part-4-sw.html)
* [Socket Programming in Swift: part 5 - accept](http://swiftrien.blogspot.kr/2015/11/socket-programming-in-swift-part-4.html)
* [Socket Programming in Swift: Part 6 - select and recv](http://swiftrien.blogspot.kr/2015/11/socket-programming-in-swift-part-5.html)
* [Socket Programming in Swift: Part 7 - Client side considerations](http://swiftrien.blogspot.kr/2016/01/socket-programming-in-swift-part-7.html)
* [Socket Programming in Swift: Part 8 - Server side considerations](http://swiftrien.blogspot.kr/2016/02/socket-programming-in-swift-part-8.html)
* [Socket Programming in Swift: Part 9 - SwifterSockets](http://swiftrien.blogspot.kr/2016/03/socket-programming-in-swift-part-9.html)

### 참고 자료

[Swift Tutorial: Building an iOS Chat App Using Socket.IO](http://www.appcoda.com/socket-io-chat-app/)

[^swiftrien-socket-1]: [Socket Programming in Swift: Part 1 - getaddrinfo](http://swiftrien.blogspot.kr/2015/10/socket-programming-in-swift-part-1.html) : 아주 좋은 내용인 것 같습니다. 나중에 숙지해야할 것 같습니다. 

[^swiftrien-socket-2]: [Socket Programming in Swift: part 2 - socket and setsockopt](http://swiftrien.blogspot.kr/2015/10/socket-programming-in-swift-part-2.html) : 위의 자료의 후반부 내용입니다. 

[^swiftrien-socket-3]: [Socket Programming in Swift: part 3 - bind & listen](http://swiftrien.blogspot.kr/2015/11/socket-programming-in-swift-part-3-bind.html) : 3부입니다.

[Beej's Guide to Network Programming](http://beej.us/guide/bgnet/) : 무료로 볼 수 있는 네트워크 프로그래밍 책입니다. 한글 번역된 것도 두 가지나 있습니다. 

[BeeJ's Guide to Network Programming 번역판](https://wiki.kldp.org/Translations/html/Socket_Programming-KLDP/Socket_Programming-KLDP.html) : kldp 에서 번역한 듯 합니다.

[BeeJ's Guide to Network Programming 번역판](http://keywordteam.net/Socket_Programming-KLDP.html) : 위의 것과 내용이 완전히 같은데 왜 주소가 나뉘어 있는지 모르겠습니다.


