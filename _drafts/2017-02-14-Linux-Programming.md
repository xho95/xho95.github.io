### 개발 환경

[What is a good IDE for C/C++ on Linux](http://xmodulo.com/good-ide-for-c-cpp-linux.html)

[Docker 로 Linux 없이 Linux 환경에서 개발하기](http://www.slideshare.net/iFunFactory/docker-linux-linux-66590915)

[리눅스로 개발 하는 모든 사람들이 꼭 봐야하는 동영상](http://luckyyowu.tistory.com/320)

[Linux 개발환경 - 컴파일러(gcc) & 텍스트에디터(vim) 설치](http://www.morenice.kr/5) : 터미널에서 개발 환경을 구축하는 방법을 설명하고 있습니다.

[Getting Started: Building and Running Clang](https://clang.llvm.org/get_started.html) : 아직 뭔진 모르겠지만 Clang 을 사용하는 방법을 정리한 것 같습니다.

[Build llvm/clang on Linux](https://coderwall.com/p/irronw/build-llvm-clang-on-linux)

#### C++ 

우분투에서 아래와 같은 명령으로 gcc 가 설치되어 있는지 확인할 수 있습니다. 

```
$ which gcc g++
```

결과로 아래와 같이 나타나면 gcc가 설치되어 있는 것입니다. 

```
/usr/bin/gcc
/usr/bin/g++
```

### 개발 도구

QT Creator, Code Block 등도 있습니다. 따로 분리했는데 필요에 따라 다시 합쳐도 좋을 것 같습니다.

#### Atom Editor

[gpp-compiler](https://atom.io/packages/gpp-compiler) 패키지를 설치하면 gcc 를 사용할 수 있는 것 같습니다.

아래와 같이 설명이 되어 있습니다. 

This Atom package allows you to compile and run C++ and C within the editor.

To compile C or C++, press **F5** or right click the file in tree view and click **Compile and Run**.

To compile C or C++ and attach the GNU Debugger, press **F6** or right click the file in tree view and click **Compile and Debug**.

**F5** 와 **F6** 키로 컴파일과 디버깅을 할 수 있도록 하고 있습니다. 

### 시스템 정보 얻기 

리눅스 시스템은 **/proc** 폴더 밑에 많은 정보를 담고 있다고 합니다. 따라서 여기에서 정보를 읽으면 되는데, 예를 들어 **/proc/cpuinfo** 파일을 `fopen` 으로 열어서 내용을 읽어들이면 된다고 합니다. [^stackoverflow-23323438]

어떤 파일들을 보면 되는 지는 [Reading Linux System Info With C++](http://www.makerdyne.com/blog/reading-linux-system-info-with-c/) 글을 참고하면 좋을 것 같습니다. [^makerdyne--linux-system]

그리고 소스 코드는 [How to get CPU info in C on Linux, such as number of cores?](http://stackoverflow.com/questions/9629850/how-to-get-cpu-info-in-c-on-linux-such-as-number-of-cores) 글을 참고하면 될 것 같습니다. [^stackoverflow-9629850]

[How to determine CPU and memory consumption from inside a process?](http://stackoverflow.com/questions/63166/how-to-determine-cpu-and-memory-consumption-from-inside-a-process) 글도 무척 좋은 것 같습니다. [^stackoverflow-63166]

[Welcome to libcpuid's project page!](http://libcpuid.sourceforge.net/index.html) 라는 글을 보면 cpu 정보를 받아오는 라이브러리도 있는 것 같습니다. [^libcpuid]

[Linux Cross Reference](http://lxr.free-electrons.com/source/arch/x86/kernel/cpu/proc.c#L64) 정보에 대해서는 나중에 알아봅니다. [^free-electrons] 그냥 단순히 임베디드 리눅스에서만 되는 것일 수도 있습니다.

### 참고 자료 

[^stackoverflow-9629850]: [How to get CPU info in C on Linux, such as number of cores?](http://stackoverflow.com/questions/9629850/how-to-get-cpu-info-in-c-on-linux-such-as-number-of-cores) : **/proc/cpuinfo** 파일에서 데이터를 가져오는 방법을 설명한 글입니다.

[^stackoverflow-23323438]: [Get Linux system information in C](http://stackoverflow.com/questions/23323438/get-linux-system-information-in-c) : 리눅스 시스템의 **/proc** 폴더에 대해서 설명한 글입니다.

[^makerdyne--linux-system]: [Reading Linux System Info With C++](http://www.makerdyne.com/blog/reading-linux-system-info-with-c/) : 각각의 정보를 불러올 때 어떤 파일을 보면 되는 지를 설명한 글입니다.

[리눅스 명령어: 시스템 사양 확인 - 리눅스 버전, 메모리, 하드, cpu](http://thisstory.tistory.com/entry/리눅스-명령어-시스템-사양-확인-리눅스버전-메모리-하드-cpu)

[UBUNTU CPU 정보 알아보기](http://naleejang.tistory.com/4)

[서버 접속 클라이언트 정보 확인 프로그램](http://180.70.134.169/_blog/BlogTypeView.do?blogid=0TQVW&articleno=138&categoryId=44&regdt=20101216143828)

[What is a good IDE for C/C++ on Linux](http://xmodulo.com/good-ide-for-c-cpp-linux.html)

[^libcpuid]: [Welcome to libcpuid's project page!](http://libcpuid.sourceforge.net/index.html) : libcpuid is a small C library for x86 CPU detection and feature extraction.

[^free-electrons]: [Linux Cross Reference](http://lxr.free-electrons.com/source/arch/x86/kernel/cpu/proc.c#L64) : 이건 아직 잘 모르겠습니다.

[^stackoverflow-63166]: [How to determine CPU and memory consumption from inside a process?](http://stackoverflow.com/questions/63166/how-to-determine-cpu-and-memory-consumption-from-inside-a-process) : 전체적으로 한 번 쭉 볼만한 좋은 자료인 것 같습니다. 운영체제별, 장비별로 데이터를 취득하는 코드가 설명되어 있습니다.


[리눅스 명령어: 시스템 사양 확인  - 리눅스 버전, 메모리, 하드, CPU](http://thisstory.tistory.com/entry/리눅스-명령어-시스템-사양-확인-리눅스버전-메모리-하드-cpu) : 리눅스에서 시스템 사양을 볼 수 있는 명령어들입니다. 

[Ubuntu Mini Remix](http://www.ubuntu-mini-remix.org) : 우분투의 경량화 버전인 것 같습니다.

[임베디드 리눅스 개발환경 1](http://blog.naver.com/PostView.nhn?blogId=r2adne&logNo=120165474017)

[2. 임베디드 시스템 개발 환경의 특징](http://jeongchul.tistory.com/138) : 정리가 잘 된 글입니다.
