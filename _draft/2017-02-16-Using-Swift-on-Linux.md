여기서는 리눅스에서 Swift 를 사용하기 위한 방법을 정리합니다. 

Swift를 사용하기 위해서는 먼저 컴파일러와 필수 요소들을 설치해야 합니다. 이들은 [Download Swift](https://swift.org/download/#releases) 라는 곳에서 받을 수 있습니다. [^swift-download]

리눅스용 패키지는 **tar** 압축 파일로 되어 있으며 Swift 컴파일러, lldb 그외 기타 관련 도구들을 포함하고 있습니다. **PATH** 만 연결되어 있으면 설치 위치는 상관없습니다. 

### 설치

1. 필수 의존 파일들을 설치합니다. 

	```
	$ sudo apt-get install clang libicu-dev
	```
	
	> 무슨 파일인지는 나중에 정리해 봅니다. 

2. 마지막 바이너리 파일을 다운 받습니다. 

	**swift-\<VERSION\>-\<PLATFORM\>.tar.gz** 파일은 그 자체로 툴체인입니다. **.sig** 파일은 디지털 서명 파일입니다.
	
	> 이 글을 작성하고 있는 시점에서의 최신 파일은 각각 **swift-3.0.2-RELEASE-ubuntu16.04.tar.gz** 와 **swift-3.0.2-RELEASE-ubuntu16.04.tar.gz.sig** 입니다.
	
3. Swift 패키지를 처음으로 다운로드하는 경우 PGP 키를 키링으로 가져오라고 합니다. 근데 뭔가 잘 안되는 것 같습니다. 

	```
	$ gpg --keyserver hkp://pool.sks-keyservers.net \
         --recv-keys \
         '7463 A81A 4B2E EA1B 551F  FBCF D441 C977 412B 37AD' \
         '1BE1 E29A 084C B305 F397  D62A 9F59 7F4D 21A5 6D5F' \
         'A3BA FD35 56A5 9079 C068  94BD 63BC 1CFE 91D3 06C6'
	```
	
	코드가 길어서 복사했는데 왜 에러가 나는지 모르겠습니다. 
	
	이것 보다는 바로 아래에 있는 것이 속이 더 편한 것 같습니다. 
	
	```
	$ wget -q -O - https://swift.org/keys/all-keys.asc | \
	  gpg --import -
	```
	
	한 번에 다 받는 명령 같습니다. 
	
4. PGP 서명의 유효 검사를 합니다.

	먼저 아래 명령을 수행합니다. 뭔가 새로 고침 비슷한 거 같습니다. 
	
	```
	$ gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift
	```
	
	그리고 유효 검사를 합니다. 
	
	```
	$ gpg --verify swift-<VERSION>-<PLATFORM>.tar.gz.sig
...
gpg: Good signature from "Swift Automatic Signing Key #1 <swift-infrastructure@swift.org>"
	```
	
	경고가 뜰 수 있다고 하는데 무시해도 된다고 합니다. 이건 나중에 애플 문서를 보고 내용을 채워 넣어야 합니다. 
	
	유효 검사가 잘 안될 때는 같은 문서의 **Active Signing Keys** 부분을 보고 따라하면 된다고 합니다.  
		
5. 압축을 풉니다. 아래와 같이 하면 됩니다.

	```
	$ tar xzf swift-<VERSION>-<PLATFORM>.tar.gz
	```
	
	뭔가 **usr/** 디렉토리를 만든다고 합니다. 이것도 설명을 보고 추가합니다.
	
6. Swift 툴체인 경로를 추가합니다. 아래와 같이 합니다. 

	```
	$ export PATH=/path/to/usr/bin:"${PATH}"
	```
	
	> export 사용법에 대해서 정리할 필요가 있습니다. 
	
이제 `swift	` 명령으로 REPL 를 실행하거나 Swift 프로젝트를 빌드할 수 있습니다.

하지만 안됩니다. 

대신에 python-swiftclient 패키지에 대한 내용이 나타납니다.

### 참고 자료

[^swift-download]: [Download Swift](https://swift.org/download/#releases) : 리눅스에 Swift 를 사용하기 위해 컴파일러와 필수 요소들을 설치하는 방법을 설명하고 있는 애플 공식 문서입니다.
