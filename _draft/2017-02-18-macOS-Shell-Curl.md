#### `curl`

**HTTP/HTTPS/FTP** 등 여러 가지 프로토콜을 사용하여 데이터를 송수신할 수 있는 명령어입니다. 

터미널에서 다음과 같이 사용할 수 있습니다.

```
$ curl www.example.com
```

위에서 `curl` 명령은 인자로 넘어온 URL로 HTTP 요청을 보내는 웹 클라이언트의 역할을 수행합니다. 

`curl` 은 터미널 용 데이터 전송 도구로서 다운로드 / 업로드 모두 가능하며 HTTP/ HTTPS/ FTP/ LDAP/ SCP/ TELNET/ SMTP/ POP3 등 주요한 프로토콜을 지원하며 Linux/Unix 계열 및 Windows 등 대부분의 OS 에서 구동되므로 유용하다고 합니다. [^lesstif]  
	
그외에도 `curl`은 옵션을 지정해서 `wget`을 대신하여 파일을 다운로드 하는 등의 용도로 사용된다고 합니다. [^dezang] 맥에서 사용하는 핵심 패키지 설치 도구인 Homebrew 를 설치할 때도 `curl` 명령어가 사용됩니다. [^curl-homebrew]

### 참고 자료

[^lesstif]: [curl 설치 및 사용법 - HTTP GET/POST, REST API 연계 등](https://www.lesstif.com/pages/viewpage.action?pageId=14745703) : curl을 설명하는 글 중에서 끝판왕 같은 글입니다.

[^dezang]: [wget 대신 curl 사용하기](http://dezang.net/884)

[^curl-homebrew]: Homebrew 에서 사용되는 curl 에 대한 내용은 제 블로그의 다른 글인 [Homebrew: 설치 및 Sierra 관련 이슈 정리](http://xho95.github.io/macos/sierra/package/homebrew/issues/2017/01/13/Using-Homebrew-and-some-Issues.html) 라는 글에서도 살펴볼 수 있습니다.
