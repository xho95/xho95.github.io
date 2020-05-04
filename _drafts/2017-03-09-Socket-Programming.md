### 소켓 프로그래밍

#### OSI 7 계층

먼저 OSI 7 계층에 대한 이해가 필요합니다. 

HTTP 등은 7 계층의 최상단에 존재합니다. [^koriel-udp] HTTP 전송을 꼭 브라우저로만 할 필요는 없습니다. 내 프로그램이 얼마든지 특정 포트로 오는 서비스를 받아서 해석할 수 있습니다.

#### 소켓 및 포트

포트란 무엇인가? TCP / UDP 각각 2^16개로 할당되어 있으며 각 포트마다 하나의 서비스가 물려있습니다. [^luna] IP 가 네트웍 상의 특정 PC 를 찾기 위한 것이라면, 포트는 해당 PC 에서 특정 프로그램을 찾기 위한 것이라고 볼 수 있습니다.

소켓이란 무엇인가? 소켓은 각 포트에 연결하도록 하는 장치라고 할 수 있을 것이다? [^ss-40765344]

리눅스에서는 콘솔, 소켓, 파일 등을 파일로 간주한다고 합니다. [^smeffect-01] 그래서 파일 디스크립터(descriptor)가 할당되고 파일 입출력 함수를 소켓에도 사용이 가능하다고 합니다. 파일 디스크립터는 윈도우즈에서의 Handle 과 유사한 개념입니다. 

[뇌를 자극하는 TCP/IP 소켓 프로그래밍](https://books.google.co.kr/books?id=ODCrAwAAQBAJ&pg=PA610&lpg=PA610&dq=was+와+통신하는+프로그램&source=bl&ots=YEtV97lRv7&sig=GQjjmBi33RE50g9vndpEgrWwLWc&hl=en&sa=X&redir_esc=y#v=onepage&q=was%20와%20통신하는%20프로그램&f=false)

[서블릿 소켓통신 문제](http://okky.kr/article/218757)

#### 예제 코드

[Sockets Tutorial](http://www.linuxhowtos.org/C_C++/socket.htm) [^linuxhowtos]

리눅스 소켓 프로그래밍 예제는 다음을 참고합니다. [^ss-60722984]

**C++**

[Socket programming examples in C++](https://github.com/zappala/socket-programming-examples-c) [^zappala]

[SOCKETS - SERVER & CLIENT - 2017](http://www.bogotobogo.com/cplusplus/sockets_server_client.php) [^bogotobogo]

[A light-weighted client/server socket class in C++](https://www.codeproject.com/Articles/7108/A-light-weighted-client-server-socket-class-in-C) [^codeproject]

[Simple TCP Client Code [C++ and socket]](http://code.runnable.com/VXjZAA1cltc0LP9r/simple-tcp-client-code-for-c%2B%2B-and-socket) [^runnable]

[Code a simple socket client class in c++](http://www.binarytides.com/code-a-simple-socket-client-class-in-c/) [^binarytides]

**C**

[echoclient.c](http://www.cs.cmu.edu/afs/cs/academic/class/15213-f00/www/class24code/echoclient.c) [^cmu-echoclient]

**netinet / in.h** 헤더 파일은 인터넷 주소와 관련한 함수들을 가지고 있는 것 같습니다. [^netinet]

**netdb.h** 헤더 파일은 네트워크 데이터베이스 기능들이 정의된 곳입니다. [^netdb]

**unistd.h** 헤더 파일은 표준 상수와 타입들이 정의된 곳입니다. [^unistd]


### 고찰하기

Luna 도 분석하자.

### 참고 자료

[^koriel-udp]: [Linux: UDP, TCP 통신 예제](https://koriel.co/blog/Linux-UDP-TCP-통신-예제) : 7계층을 그림으로 잘 설명하고 있는 것 같습니다. 

[^ss-40765344]: [소켓프로그래밍 기초요약](https://pt.slideshare.net/ssusereb4897/ss-40765344) 은 윈도우즈를 위한 자료이지만 볼만한 자료입니다.

[^luna]: [Luna](https://github.com/kmansoo/Luna) 를 만든 김만수 부장님의 설명을 참고합니다.

[^ss-60722984]: [리눅스 소켓 프로그래밍 기초](https://pt.slideshare.net/LuckyYoWu/ss-60722984)

[^smeffect-01]: [01. 네트워크 프로그래밍 (TCP/IP 소켓 프로그래밍)](http://smeffect.tistory.com/entry/01-네트워크-프로그래밍-TCPIP-소켓-프로그래밍)

[^zappala]: [Socket programming examples in C++](https://github.com/zappala/socket-programming-examples-c) : GitHub 저장소 입니다.

[^kukuta-45]: [주소값 변환 하기(inet_aton, inet_ntoa, inet_addr, inet_network)](http://kukuta.tistory.com/45) : inet 과 관련한 함수들에 대한 설명이 있습니다. 

[^bogotobogo]: [SOCKETS - SERVER & CLIENT - 2017](http://www.bogotobogo.com/cplusplus/sockets_server_client.php) : C++ 로 구현한 소켓 프로그래밍 예제입니다. 다른 설명도 잘 되어 있지만 글이 조금 깁니다. 코드 자체가 C++ 인지는 확인이 필요합니다.

[^cmu-echoclient]: [echoclient.c](http://www.cs.cmu.edu/afs/cs/academic/class/15213-f00/www/class24code/echoclient.c) : 카네기 멜론 대학교의 수업 내용에 나오는 샘플 코드인 것 같습니다. C 로 구현한 소켓 클라이언트입니다. [Finding Faces in a Crowd](http://www.cs.cmu.edu/news/finding-faces-crowd) 이런 것도 가르치는 곳입니다. 나중에 정리하도록 합니다.

[^netinet]: [netinet/in.h](http://pubs.opengroup.org/onlinepubs/000095399/basedefs/netinet/in.h.html)

[^netdb]: [netdb.h](http://pubs.opengroup.org/onlinepubs/7908799/xns/netdb.h.html)

[^unistd]: [unistd.h](http://pubs.opengroup.org/onlinepubs/7908799/xsh/unistd.h.html)

[^linuxhowtos]: [Sockets Tutorial](http://www.linuxhowtos.org/C_C++/socket.htm) : 소켓 프로그래밍 코드에 대해서 찬찬히 설명하고 있는 글입니다. 한 번 정도 볼만한 것 같습니다. 

[^codeproject]: [A light-weighted client/server socket class in C++](https://www.codeproject.com/Articles/7108/A-light-weighted-client-server-socket-class-in-C)

[^runnable]: [Simple TCP Client Code [C++ and socket]](http://code.runnable.com/VXjZAA1cltc0LP9r/simple-tcp-client-code-for-c%2B%2B-and-socket)

[^binarytides]: [Code a simple socket client class in c++](http://www.binarytides.com/code-a-simple-socket-client-class-in-c/)