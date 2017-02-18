많은 패키지들은 brew 를 통해서 설치할 수 있는데, 만약 brew 가 설치되어 있지 않다면 어떻게 할까요? 이런 경우에 curl 을 사용할 수 있습니다. 

wget 같은 경우 brew 로도 설치할 수 있고 curl 로도 설치할 수 있습니다. 하지만 brew 가 설치되어 있다면 brew 를 사용하는 것이 훨씬 간편합니다. 

즉, curl 이라는 것은 macOS 에서 기본으로 제공하는 낮은 단계의 패키지 설치 도구라고도 볼 수 있습니다. 이에 반하여 brew 등은 적절하게 curl 을 감싸서 보다 상위의 인터페이스를 제공한다고 볼 수 있습니다. 

일종의 가설인데 정확한지는 찾아봐야 합니다.

### `curl` 의 개요 

#### `curl` 의 유래

[cURL](https://en.wikipedia.org/wiki/CURL) 은 원래 "see URL" 을 뜻한다고 합니다. [^curl] 즉 주어진 `url` 을 찾아보라는 의미를 가지고 있습니다. 아마도 발음이 같기 때문에 `curl` 이라고 줄인 것 같습니다.

#### `curl` 의 기능

**HTTP/HTTPS/FTP** 등 여러 가지 프로토콜을 사용하여 데이터를 송수신할 수 있는 명령어입니다. 

### `curl` 사용하기

터미널에서 다음과 같이 사용할 수 있습니다.

```
$ curl www.example.com
```

위에서 `curl` 명령은 인자로 넘어온 URL로 HTTP 요청을 보내는 웹 클라이언트의 역할을 수행합니다. 

`curl` 은 터미널 용 데이터 전송 도구로서 다운로드 / 업로드 모두 가능하며 HTTP/ HTTPS/ FTP/ LDAP/ SCP/ TELNET/ SMTP/ POP3 등 주요한 프로토콜을 지원하며 Linux/Unix 계열 및 Windows 등 대부분의 OS 에서 구동되므로 유용하다고 합니다. [^lesstif]  
	
그외에도 `curl`은 옵션을 지정해서 `wget`을 대신하여 파일을 다운로드 하는 등의 용도로 사용된다고 합니다. [^dezang] 맥에서 사용하는 핵심 패키지 설치 도구인 Homebrew 를 설치할 때도 `curl` 명령어가 사용됩니다. [^curl-homebrew]

#### `wget` 과의 비교

`wget` 은 사실상 `curl` 과 동급의 기능을 하는 것 같습니다. 의미는 웹 서비스로부터 무언가를 받는다는 의미인 것 같습니다. [^wget]

### 고찰하기 

macOS 에서는 Homebrew 가 패키지 설치의 표준처럼 사용되고 있습니다. 따라서 curl 이 하는 많은 역할을 Homebrew 로도 할 수 있습니다. 따라서 curl 을 사용하는 경우는 극히 드문데 지금은 사실상 Homebrew 를 설치하기 위해 사용하는 경우가 유일하다시피 한 것 같습니다.

물론 엄밀히 말하면 두 명령의 역할은 다르기 때문에 다른 쓰임새가 있을 것 같은데, curl 만으로 할 수 있는 기능들이 무엇이 있는지 정리할 필요가 있을 것 같습니다.

### 참고 자료

[^curl]: 위키피디아의 [cURL](https://en.wikipedia.org/wiki/CURL) 라는 글에 `curl` 에 대한 설명이 잘 되어 있습니다. 

[^lesstif]: [curl 설치 및 사용법 - HTTP GET/POST, REST API 연계 등](https://www.lesstif.com/pages/viewpage.action?pageId=14745703) : curl을 설명하는 글 중에서 끝판왕 같은 글입니다.

[^dezang]: [wget 대신 curl 사용하기](http://dezang.net/884)

[^curl-homebrew]: Homebrew 에서 사용되는 curl 에 대한 내용은 제 블로그의 다른 글인 [Homebrew: 설치 및 Sierra 관련 이슈 정리](http://xho95.github.io/macos/sierra/package/homebrew/issues/2017/01/13/Using-Homebrew-and-some-Issues.html) 라는 글에서도 살펴볼 수 있습니다.

[^wget]: [Wget](https://en.wikipedia.org/wiki/Wget) : 
