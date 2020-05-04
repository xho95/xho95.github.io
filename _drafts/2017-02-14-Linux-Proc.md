리눅스의 proc 관련 내용을들 따로 모아 정리합니다. [^egloos-10949008]

#### 가상 파일 시스템 

* **/proc**

	일명 "가상파일시스템" 이라고 하는 곳으로 현재 메모리에 존재하는 모든 작업들이 파일형태로 존재하는 곳이다. 디스크상에 실제 존재하는 것이 아니라 메모리상에 존재하기 때문에 가상파일시스템이라고 부른다. 
	
	실제 운용상태를 정확하게 파악할 수 있는 중요한 정보를 제공하며 여기에 존재하는 파일들 가운데 현재 실행중인 커널(kernel)의 옵션 값을 즉시 변경할 수 있는 파라미터파일들이 있기 때문에 시스템 운용에 있어 매우 중요한 의미를 가진다. 
	
	보다 자세한 내용은 [리눅스 디렉토리 구조](http://webdir.tistory.com/101) 글을 참고합니다. [^webdir-101]
	
#### CPU 정보 구하기

[How to get CPU info in C on Linux, such as number of cores?](http://stackoverflow.com/questions/9629850/how-to-get-cpu-info-in-c-on-linux-such-as-number-of-cores) 글을 참고합니다. [^stackoverflow-9629850]

#### 바이오스 정보를 구하는 방법

[Get Information About Your BIOS / Server Hardware From a Shell Without Opening Chassis (BIOS Decoder)](https://www.cyberciti.biz/tips/querying-dumping-bios-from-linux-command-prompt.html) 글을 참고합니다.[^cyberciti]
	

### 참고 자료

[^egloos-10949008]: [LINUX PROC 관련된 내역 정리된 것](http://egloos.zum.com/powerenter/v/10949008)

[^webdir-101]: [리눅스 디렉토리 구조](http://webdir.tistory.com/101)

[^cyberciti]: [Get Information About Your BIOS / Server Hardware From a Shell Without Opening Chassis (BIOS Decoder)](https://www.cyberciti.biz/tips/querying-dumping-bios-from-linux-command-prompt.html) : 구글에서 `get information about bios on linux` 키워드로 검색한 결과 중의 하나입니다.

[^stackoverflow-9629850]: [How to get CPU info in C on Linux, such as number of cores?](http://stackoverflow.com/questions/9629850/how-to-get-cpu-info-in-c-on-linux-such-as-number-of-cores) : 이 글에 `$ man 5 proc` 이라는 명령이 나오는데 메뉴얼을 띄워주는 명령어인 듯 합니다. 도움이 많이 될 것 같습니다.
