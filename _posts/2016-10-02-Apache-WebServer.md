---
layout: post
comments: true
title:  "Apache : 맥에서 아파치 웹서버 실행하기"
date:   2016-10-02 11:58:00 +0900
categories: macOS Apache WebServer mod_wsgi
---

이 글은 아파치 웹 서버를 설정하는 방법에 대한 시리즈 글의 일부입니다. 관련 목차는 아래와 같습니다.

* [맥에서 아파치 웹 서버 실행하기]()
* [아파치 가상 호스트 설정하기](http://xho95.github.io/macos/apache/webserver/virtualhosts/2016/10/10/Apache-Virtual-Host.html)

### 들어가며

맥에서 [아파치(apache) 웹서버](http://httpd.apache.org) [^apache]를 실행하는 방법은 인터넷에 자료가 꽤 있습니다. [^projectjo]  [^acronym]  [^superakira] 하지만, 많은 경우 설명이 맥 OS 요세미티(Yosemite) 이전 기준이라 내용이 지금 환경에는 안맞는 경우가 많습니다.

macOS 시에라(Sierra)가 출시된 현 시점에서 아파치 웹서버 관련 참고 자료 중에서는 **limslee**님이 [Develop in Mac](http://devmac.tistory.com/) 블로그에 정리한 [맥에 웹서버(Apache, PHP) 구동하기 - 요세미티 기준](http://devmac.tistory.com/11)이라는 글이 가장 정확하게 설명되어 있는 것 같습니다.[^devmac]

영어로 된 글 중에서는 [Apple Communities](https://discussions.apple.com/)의 [Setting up a local web server on OS X](https://discussions.apple.com/docs/DOC-3083)라는 글도 정리가 잘 된 것 같습니다.[^apple] 이 글에 따르면 macOS 요세미티에서 웹서버 설정에 대한 중요한 변화가 일어났다고 합니다.

### 아파치 웹 서버 구동하기

아파치를 구동하려면 먼저 아파치를 설치해야 하지만, 맥에는 이미 기본적으로 아파치 와 php가 설치되어 있습니다. 따라서 따로 설치 과정은 필요없으며, 사용하려면 각 기능을 활성화 해주면서 필요에 따라 설정만 변경해 주면 됩니다.

#### 아파치 버전 확인하기

아파치와 php가 설치되어 있다면, 각각의 버전은 다음과 같은 명령어로 확인할 수 있습니다.

```
$ apachectl -v
$ php -v
```

위 명령을 실행해서 버전 결과가 나온다면 바로 서버를 실행할 수 있습니다.

#### 아파치 실행하기

아파치를 시작하는 방법은 아래와 같습니다.

```
$ sudo apachectl start
```

아파치를 실행하려면 관리자 권한이 필요하므로 명령의 맨 앞에 `sudo`를 붙여줘야 합니다. 위와 같이 입력하면 비밀번호를 입력하라는 표시가 나오는데 관리자 비밀 번호를 입력하면 됩니다.

#### 아파치 실행 확인하기

아파치를 실행한 후 브라우저에서 `localhost` 또는 `127.0.0.1`로 접속하면 큰 문제가 없다면 브라우저 창에 아래와 같은 결과를 볼 수 있습니다.

```
It works!
```

이것은 브라우저가 기본(default) index 페이지를 열었기 때문입니다. 기본 index 페이지는 **/Library/WebServer/Documents** 폴더에 존재하는데, 이는 default로 해당 폴더가 `DocumentRoot`로 지정되어 있기 때문입니다.

해당 폴더에 가면 **index.html.en** 파일이 있음을 확인할 수 있습니다.

> 맥은  유닉스 계열 (Unix-like) OS로 분류되는데 유닉스 시스템에서 `/`는 루트 디렉토리 (root directory)를 의미합니다. 따라서 루트 디렉토리를 기준으로 이동할 때는 반드시 `/`를 경로의 맨 앞에 붙여줘야 합니다.  

### 아파치 웹 서버 환경 설정하기

아파치의 기본 설정들을 변경하려면 **/private/etc/apache2/** 폴더에 있는 설정 파일들(***.conf**)을 수정하면 됩니다. 이 설정 파일들 중에서 가장 기본이 되는 것이 **httpd.conf** 파일입니다.[^docs-apache]

> 참고로 맥에서 **/etc/** 폴더는 주로 환경 설정 파일들이 존재하는 곳입니다.[^webdir] **/etc/** 폴더에 대해서는 [macOS: 맥의 기본 디렉토리 구조 살펴보기](http://xho95.github.io/macos/file/system/directory/2016/10/08/macOS-Directory-Structure.html) 라는 포스트에서 좀 더 자세하게 설명해 두었습니다.

#### DocumentRoot 폴더 변경하기

앞에서 **index.html.en** 파일은 **/Library/WebServer/Documents/** 폴더에 있다고 했는데, 이 폴더는 기본으로 `DocumentRoot`로 지정되어 있습니다.

기본으로 지정된 `DocumentRoot`의 위치를 변경하려면 **httpd.conf** 파일을 열고 `DocumentRoot` 부분과 바로 밑 줄에 있는 `Directory` 부분을 변경하면 됩니다.

```
...
DocumentRoot "/Library/WebServer/Documents"
<Directory "/Library/WebServer/Documents">
...
```

> 참고로 **httpd.conf** 파일을 수정하려면 파일을 관리자 권한으로 열어야 합니다.

다만, `DocumentRoot`를 옮기는 것은 그다지 추천할 만한 방법이 아닙니다. 따라서 `DocumentRoot`를 바꾸기 보다는 `userdir`을 활성화하는 것이 바람직합니다.

#### userdir 활성화를 위해 **httpd-userdir.conf** 파일 수정하기

`userdir`를 활성화한다는 것은 이름에서 알 수 있듯이 브라우저에서 `localhost/~username/` 처럼 자신의 계정으로 된 URL을 사용할 수 있게 한다는 의미입니다.

`userdir`을 활성화하려면 **/private/etc/apache2/extra/** 폴더에 있는 **httpd-userdir.conf** 파일을 수정해야 합니다.

우선 해당 폴더로 가서 아래와 같은 명령으로 파일을 편집합니다.

```
$ sudo vi httpd-userdir.conf
```

명령을 보면 알겠지만 서버 설정을 변경할 때는 관리자 권한으로만 파일을 편집할 수 있습니다.
파일의 내용은 아래와 같습니다.

```
# Settings for user home directories
#
# Required module: mod_authz_core, mod_authz_host, mod_userdir

#
# UserDir: The name of the directory that is appended onto a user's home
# directory if a ~user request is received.  Note that you must also set
# the default access control for these directories, as in the example below.
#
UserDir Sites

#
# Control access to UserDir directories.  The following is an example
# for a site where these directories are restricted to read-only.
#
Include /private/etc/apache2/users/*.conf
<IfModule bonjour_module>
       RegisterUserSite customized-users
</IfModule>
```

위의 파일 내용을 살펴보면 userdir 활성화를 위해 다음과 같은 일들을 해야 함을 알 수 있습니다.

1. **mod\_authz\_core**, **mod\_authz\_host**, **mod\_userdir** 이렇게 3개의 모듈이 필요합니다 : 이 작업은 **httpd.conf** 파일에서 설정합니다.
2. 사용자의 홈 디렉토리에 `UserDir`로 설정된 **Sites** 라는 디렉토리를 추가해야 합니다. 이는 `~user` 요청에 응답하기 위해서입니다.
3. **Sites** 디렉토리에 대해 기본 접근 방식을 지정해야 합니다. : 디렉토리를 `read-only`로 지정하기 위해서는 **/private/etc/apache2/users/** 폴더에 자신의 계정명으로 된 **username.conf** 파일을 만들어야 합니다.
4. 그 외에 **httpd.conf** 파일에서 **/private/etc/apache2/extra/httpd-userdir.conf** 파일을 include 하는 코드도 주석을 제거해야 합니다 : 이 파일의 변경 사항을 적용하기 위해서입니다.

일단 이 파일에서 `Include /private/etc/apache2/users/*.conf` 문장의 주석을 제거하고 저장합니다.

<!--
> `$ sudo vi http-userdir.conf` 명령으로 파일을 수정했다면, vi 에디터에서 `esc` 키를 눌러 제어 모드로 들어간 다음 `:wq`를 입력해서 파일을 저장하고 닫을 수 있습니다.
-->

#### userdir 활성화를 위해 **httpd.conf** 파일 수정하기

앞에서 설명한대로 일단 **httpd.conf** 파일에서 **mod\_authz\_core**, **mod\_authz\_host**, **mod\_userdir** 이렇게 3개의 모듈을 활성화해야 합니다.

요세미티 이후로는 **mod\_authz\_host** 모듈과 **mod\_authz\_core** 모듈을 `LoadModule`하는 코드는 이미 주석이 제거되어 있는 상태입니다. 즉 이 두 모듈은 이미 활성화되어 있습니다.

따라서 **mod\_userdir** 모듈 부분만 아래와 같이 주석을 제거해서 활성화해 줍니다.

> [Setting up a local web server on OS X](https://discussions.apple.com/docs/DOC-3083) 글을 보면 **mod\_userdir** 모듈 부분은 요세미티 기준으로 166번째 줄에 있다고 합니다.

```
LoadModule userdir_module libexec/apache2/mod_userdir.so
```

이어서, 앞 절에서 말한대로 **httpd-userdir.conf** 파일도 include 해주기 위해 아래와 같이 주석을 제거합니다.

```
Include /private/etc/apache2/extra/httpd-userdir.conf
```

> [Setting up a local web server on OS X](https://discussions.apple.com/docs/DOC-3083) 글을 보면 **httpd-userdir.conf** 파일 부분은 요세미티 기준으로 493번째 줄에 있다고 합니다.


#### userdir 활성화를 위해 **username.conf** 파일 생성하기

**Sites** 디렉토리에 대한 접근 방식을 지정하기 위해 **/private/etc/apache2/users** 폴더에 **username.conf** 파일을 만들어 줍니다. 내용은 다음과 같이 만듭니다.

```
<Directory "/Users/username/Sites/">
  Options Indexes MultiViews
  AllowOverride None
  Require all granted
</Directory>
```

권한 설정 부분은 아파치 서버 버전에 맞도록 작성해 줍니다. 현 시점에서는 2.4 버전에 맞게 설정하면 됩니다.

> [Setting up a local web server on OS X](https://discussions.apple.com/docs/DOC-3083) 글과 [맥에 웹서버(Apache, PHP) 구동하기 - 요세미티 기준](http://devmac.tistory.com/11) 글의 설정 방법이 다른데, 일단은 후자의 설정을 따랐습니다. 이 부분은 좀 더 내용을 알게 되면 정리하도록 하겠습니다.

#### 홈 디렉토리에 Sites 폴더 만들기

마지막으로 홈 디렉토리로 가서 **Sites** 폴더를 만듭니다.

```
$ cd ~
$ mkdir Sites
```

맥의 파인더로 확인하면 자동으로 웹 사이트 폴더로 인식됨을 알 수 있습니다.

이 폴더에 자신만의 **index.html** 파일을 만들면 첫 화면으로 나타나게 됩니다. **index.html**이 없으면 아파치에서 기본 제공되는 파일 index가 열립니다.

#### 아파치 재시작하기

만약 아파치의 설정을 변경했다면 설정을 완료한 후 아파치를 재시작해야 합니다. 아래와 같은 명령으로 아파치 웹 서버를 재시작할 수 있습니다.

```
$ sudo apachectl restart
```

이제 `localhost/~username`으로 접속하면 **Sites** 폴더에 있는 **index.html**이 나타나는 것을 볼 수 있습니다.

#### 아파치 종료하기

실행중인 아파치를 종료하는 방법은 다음과 같습니다.

```
$ sudo apachectl stop
```

<!--
### 아파치 설정 파일의 의미

아파치 설정 파일에 대해서 정리합니다.[^webdir-httpd]

Options에서 Indexes는 DirectoryIndex로 설정한 index.html이나 index.php 파일이 없을 때, 디렉토리 인덱스를 보여주는 역할을 합니다.

MultiViews는 클라이언트 요청에 따라 적절한 페이지를 보여줍니다. 예를 들면, Accept-Language:ko라면 한국어에 맞는 데이터를 전달해 줍니다.

AllowOverride는 All로 설정함으로써 AccessFileName 설정에 따른 아파치 인증을 사용하도록 합니다.

Order allow, deny는 먼저 allow를 평가하고 이어서 deny 패턴을 체크한다는 순서를 정하는 것입니다.

Allow from all은 모든 것으로부터의 접속을 허용한다는 의미입니다. 순서도 allow 먼저 정의되어 있으므로 모든 곳에서 접속이 가능하게 됩니다.
-->

### 고찰하기

아파치 설정을 하다보면 자료에 따라 **/private/etc/apache2/users** 폴더와 **/etc/apache2/users** 폴더가 섞여서 설명되기도 하는데, 실제로는 두 폴더가 차이가 있는지도 잘 모르겠습니다. 아마 맥 OS의 특정 버전부터 **/private/** 부분이 추가된 것 같은데, 이 부분은 좀 더 이해하게 되면 정리하도록 하겠습니다.

### 참고 자료

[^apache]: [Apache HTTP Server Project](http://httpd.apache.org) : 아파치는 전세계에서 가장 많이 사용하고 있는 서버라고 합니다.

[^projectjo]: [Mac 에 Apache 작동 시키기](http://projectjo.tistory.com/entry/Mac-에-Apache-작동-시키기) : 2014년 글이라 현 시점에는 정확하지 않는 것 같습니다.

[^acronym]: [MAC에서 Apache 실행하기](http://blog.acronym.co.kr/531) : 맥에서 아파치를 실행하고 설정하는 방법에 대해서 자세하게 설명하고 있습니다만, 2015년 글이라도 OS X 마운틴 라이언 기준이라 설명이 지금과는 맞지 않습니다.

[^superakira]: [맥에서 기본 Apache 사용하기](http://superakira.tistory.com/entry/맥에서-기본-Apache-사용하기) : 맥에서 아파치를 사용하는 방법에 대해서 간단하게 정리한 글입니다. 설정 방법에서 전체 내용의 일부만 다루고 있습니다.

[^devmac]: [맥에 웹서버(Apache, PHP) 구동하기 - 요세미티 기준](http://devmac.tistory.com/11) : 현 시점에서 한 글로 작성된 아파치 설정 방법 중에서는 가장 정확한 설명을 하고 있는 글입니다. 저도 다른 글을 참고하면서 몇 번 실패하다가 이 글을 따라하면서 설정을 완료할 수 있었습니다.

[^apple]: [Setting up a local web server on OS X](https://discussions.apple.com/docs/DOC-3083) : Yosemite 이후로 바뀐 설정 방법에 대한 설명이 잘 정리된 글입니다.

[^docs-apache]: [Getting Started](http://httpd.apache.org/docs/current/en/getting-started.html) : Apache 공식 문서입니다.

[^webdir]: [리눅스 디렉토리 구조](http://webdir.tistory.com/101) : 리눅스 디렉토리의 구조에 대해서 잘 정리한 글입니다.

[^webdir-httpd]: [CentOS: Apache(아파치) 설정파일 분석 - httpd.conf](http://webdir.tistory.com/178)
