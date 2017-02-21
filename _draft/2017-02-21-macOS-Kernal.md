macOS 의 핵심을 이루는 부분에 대해서 정리합니다.

### 커널 (Kernel)

[커널 (Kernel)](https://en.wikipedia.org/wiki/Kernel_(operating_system)) 은 컴퓨터 운영 체제의 핵심을 이루는 컴퓨터 프로그램을 말하는 것으로 시스템의 모든 부분을 완전히 제어할 수 있습니다. [^wikipedia-kernel] [^linfo-kernel]

#### 다윈 (Darwin)

다윈은 애플이 macOS 에 사용하기 위해 만든 운영 체제이다. [^namu-darwin] [^wikipedia-darwin-ko] 사실 macOS 가 운영 체제인데 다윈을 운영 체제라고 하기 보다는 운영 체제의 커널이다라고 하는게 맞는 거 같습니다.

또한 다윈은 오픈소스라고 합니다. [^macnews-5227]

### POSIX

POSIX는 IEEE가 제정한 유닉스의 애플리케이션 프로그래밍 인터페이스(API) 규격이라고 합니다. 유닉스의 일종인 4.4BSD-Lite Release 2와 FreeBSD에 기반하여 역시 유닉스의 일종인 macOS도 POSIX를 따른다고 합니다. [^namu-posix]

### 참고 자료

[^wikipedia-kernel]: 위키피다아의 [Kernel (operating system)](https://en.wikipedia.org/wiki/Kernel_(operating_system)) 설명입니다.

[^linfo-kernel]: [Kernel Definition](http://www.linfo.org/kernel.html)

[^appletree-54]: [Darwin이란 무엇인가 (그리고 Mac OS X에서는 어떤 힘을 발휘하는가)](http://appletree.or.kr/forum/viewtopic.php?id=54) : 다소 오래된 번역글이지만 지금봐도 꽤 좋은 것 같습니다.

[^namu-darwin]: [다윈](https://namu.wiki/w/다윈) : 나무위키 설명입니다.

[^wikipedia-darwin-ko]: [다윈 (운영 체제)](https://ko.wikipedia.org/wiki/다윈_(운영_체제)) : 위키피디아 설명입니다.

[^macnews-5227]: [애플, macOS 10.12 시에라에 사용된 '다윈(Darwin)' 오픈소스 공개](http://macnews.tistory.com/5227) 글을 보면 애플 오픈 소스 링크가 있는데 지금은 연결이 안됩니다. ㅜㅜ

[^namu-posix]: [POSIX](https://namu.wiki/w/POSIX) : 나무위키 설명입니다.