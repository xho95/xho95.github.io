### 시스템 정보 얻기 

리눅스 시스템은 **/proc** 폴더 밑에 많은 정보를 담고 있다고 합니다. 따라서 여기에서 정보를 읽으면 되는데, 예를 들어 **/proc/cpuinfo** 파일을 `fopen` 으로 열어서 내용을 읽어들이면 된다고 합니다. [^stackoverflow-23323438]

어떤 파일들을 보면 되는 지는 [Reading Linux System Info With C++](http://www.makerdyne.com/blog/reading-linux-system-info-with-c/) 글을 참고하면 좋을 것 같습니다. [^makerdyne--linux-system]

그리고 소스 코드는 [How to get CPU info in C on Linux, such as number of cores?](http://stackoverflow.com/questions/9629850/how-to-get-cpu-info-in-c-on-linux-such-as-number-of-cores) 글을 참고하면 될 것 같습니다. [^stackoverflow-9629850]


### 참고 자료 

[^stackoverflow-9629850]: [How to get CPU info in C on Linux, such as number of cores?](http://stackoverflow.com/questions/9629850/how-to-get-cpu-info-in-c-on-linux-such-as-number-of-cores) : **/proc/cpuinfo** 파일에서 데이터를 가져오는 방법을 설명한 글입니다.

[^stackoverflow-23323438]: [Get Linux system information in C](http://stackoverflow.com/questions/23323438/get-linux-system-information-in-c) : 리눅스 시스템의 **/proc** 폴더에 대해서 설명한 글입니다.

[^makerdyne--linux-system]: [Reading Linux System Info With C++](http://www.makerdyne.com/blog/reading-linux-system-info-with-c/) : 각각의 정보를 불러올 때 어떤 파일을 보면 되는 지를 설명한 글입니다.

[리눅스 명령어: 시스템 사양 확인 - 리눅스 버전, 메모리, 하드, cpu](http://thisstory.tistory.com/entry/리눅스-명령어-시스템-사양-확인-리눅스버전-메모리-하드-cpu)

[UBUNTU CPU 정보 알아보기](http://naleejang.tistory.com/4)

[서버 접속 클라이언트 정보 확인 프로그램](http://180.70.134.169/_blog/BlogTypeView.do?blogid=0TQVW&articleno=138&categoryId=44&regdt=20101216143828)