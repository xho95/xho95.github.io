먼저 OSI 7 계층에 대한 이해가 필요합니다. 

HTTP 등은 7 계층의 최상단에 존재합니다. HTTP 전송을 꼭 브라우저로만 할 필요는 없습니다. 내 프로그램이 얼마든지 특정 포트로 오는 서비스를 받아서 해석할 수 있습니다.

포트란 무엇인가? TCP / UDP 각각 2^16개로 할당되어 있으며 각 포트마다 하나의 서비스가 물려있습니다. [^luna] IP 가 네트웍 상의 특정 PC 를 찾기 위한 것이라면, 포트는 해당 PC 에서 특정 프로그램을 찾기 위한 것이라고 볼 수 있습니다.

Luna 도 분석하자.

소켓이란 무엇인가? 소켓은 각 포트에 연결하도록 하는 장치라고 할 수 있을 것이다? [^ss-40765344]

리눅스 소켓 프로그래밍 예제는 다음을 참고합니다. [^ss-60722984]

리눅스에서는 콘솔, 소켓, 파일 등을 파일로 간주한다고 합니다. [^smeffect-01] 그래서 파일 디스크립터(descriptor)가 할당되고 파일 입출력 함수를 소켓에도 사용이 가능하다고 합니다. 파일 디스크립터는 윈도우즈에서의 Handle 과 유사한 개념입니다. 

### 소켓 프로그래밍

[뇌를 자극하는 TCP/IP 소켓 프로그래밍](https://books.google.co.kr/books?id=ODCrAwAAQBAJ&pg=PA610&lpg=PA610&dq=was+와+통신하는+프로그램&source=bl&ots=YEtV97lRv7&sig=GQjjmBi33RE50g9vndpEgrWwLWc&hl=en&sa=X&redir_esc=y#v=onepage&q=was%20와%20통신하는%20프로그램&f=false)

[서블릿 소켓통신 문제](http://okky.kr/article/218757)

### 참고 자료

[^ss-40765344]: [소켓프로그래밍 기초요약](https://pt.slideshare.net/ssusereb4897/ss-40765344) 은 윈도우즈를 위한 자료이지만 볼만한 자료입니다.

[^luna]: [Luna](https://github.com/kmansoo/Luna) 를 만든 김만수 부장님의 설명을 참고합니다.

[^ss-60722984]: [리눅스 소켓 프로그래밍 기초](https://pt.slideshare.net/LuckyYoWu/ss-60722984)

[^smeffect-01]: [01. 네트워크 프로그래밍 (TCP/IP 소켓 프로그래밍)](http://smeffect.tistory.com/entry/01-네트워크-프로그래밍-TCPIP-소켓-프로그래밍)