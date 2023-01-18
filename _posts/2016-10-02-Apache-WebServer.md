---
layout: post
pagination:
  enabled: true
comments: true
title:  "Apache : macOS 에서 아파치 웹서버 실행하기"
date:   2016-10-02 11:58:00 +0900
categories: macOS Apache WebServer mod_wsgi
---

> 이 글은 macOS 에서 아파치 웹 서버를 실행하고 설정하는 방법에 대한 내용을 정리한 글입니다.
>
> 아파치의 가상 호스트를 설정하는 방법은 [아파치 가상 호스트 설정하기]({% post_url 2016-10-10-Apache-Virtual-Host %}) 를 보도록 합니다.

## macOS 에서 아파치 웹서버 실행하기

이 글은 Yosemite (요세미티) 이후로 변경된 내용을 반영하여 macOS 에서 [아파치 웹서버 (apache)](http://httpd.apache.org)[^apache]를 실행하고 설정하는 방법을 정리한 글입니다.[^references] 해당 내용은 Catalina (카탈리나) 에서도 정상 동작하는 것을 확인하였습니다.

### 아파치 웹 서버 구동하기

macOS 에는 기본적으로 'apache (아파치)' 와 'php' 가 설치되어 있습니다.

따라서 이들을 따로 설치할 필요가 없으며, 필요에 따라 각 기능을 활성화하기 위한 설정만 변경하면 됩니다.

#### 아파치 버전 확인하기

설치된 '아파치' 와 'php' 버전은 다음과 같이 확인할 수 있습니다.

```zsh
$ apachectl -v
$ php -v
```

위 명령을 실행해서 버전 결과가 나온다면 바로 서버를 실행할 수 있습니다.

#### 아파치 실행하기

macOS 에서 아파치를 실행하려면 다음과 같은 명령을 터미널에서 사용합니다.[^launchctl]

```zsh
$ sudo launchctl load -w /System/Library/LaunchDaemons/org.apache.httpd.plist
```

위와 같이하면 비밀번호를 입력하라는 표시가 나오는데 관리자 비밀 번호를 입력하면 됩니다.

### 아파치 실행 확인하기

아파치를 실행한 후 브라우저에서 `localhost` 또는 `127.0.0.1`로 접속하면 아래와 같은 결과를 볼 수 있습니다.

![Apache Result](/assets/Apache/apache-result.jpg)

이는 브라우저가 아파치의 '기본 제공 index 페이지' 를 열었기 때문입니다.

'기본 제공 index 페이지' 는 **/Library/WebServer/Documents** 디렉토리에 존재하며, 해당 위치에 가보면 **index.html.en** 파일이 있음을 확인할 수 있습니다.[^macOS-unix]

아파치는 `DocumentRoot` 로 지정된 디렉토리에서 웹페이지를 불러오는데, 기본적으로는 이 값이 **/Library/WebServer/Documents** 로 지정되어 있습니다.

### 아파치 웹 서버 환경 설정하기

아파치의 기본 설정들을 변경하려면 **/private/etc/apache2** 폴더에 있는 설정 파일들 (**/*.conf**) 을 수정하면 됩니다.[^private-etc]

이 설정 파일들 중에서 가장 기본이 되는 것이 **httpd.conf** 파일입니다.[^configuration-files]

#### DocumentRoot 폴더 변경하기: 권장하지 않음

앞에서 **index.html.en** 파일은 **/Library/WebServer/Documents** 폴더에 있다고 했는데, 이 폴더가 기본적으로 `DocumentRoot` 로 지정된 폴더입니다.

**httpd.conf** 파일에서 다음과 같이 `DocumentRoot` 부분 `Directory` 부분을 변경하면 `DocumentRoot` 의 위치를 바꿀 수 있습니다.

```vi
...
DocumentRoot "/Library/WebServer/Documents"
<Directory "/Library/WebServer/Documents">
...
```

> 참고로 **httpd.conf** 파일을 수정하려면 파일을 관리자 권한으로 열어야 합니다.

다만, `DocumentRoot` 를 옮기는 것을 권장하지는 않습니다. `DocumentRoot` 를 바꾸기 보다는, 다음 처럼 `userdir` 을 활성화하는 것이 바람직합니다.

#### userdir 활성화를 위해 **httpd-userdir.conf** 파일 수정하기

이름에서 보듯이 `userdir` 를 활성화한다는 것은, 브라우저에서 `localhost/~username/` 처럼 자신의 계정으로 된 'URL' 을 사용할 수 있게 한다는 의미입니다.

`userdir` 를 활성화하려면 **/private/etc/apache2/extra** 디렉토리에 있는 **httpd-userdir.conf** 파일을 수정해야 합니다.

해당 디렉토리로 이동하여 아래와 같이 관리자 권한으로 파일을 편집합니다.

```zsh
$ sudo vi httpd-userdir.conf
```

파일의 내용은 아래와 같습니다.

```vi
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

위의 파일 내용을 살펴보면 `userdir` 활성화를 위해 다음과 같은 일들을 해야 함을 알 수 있습니다.

1. **mod\_authz\_core**, **mod\_authz\_host**, **mod\_userdir** 이렇게 3개의 모듈이 필요합니다 : 이 작업은 **httpd.conf** 파일에서 설정합니다.
2. 사용자의 홈 디렉토리에 `UserDir`로 설정된 **Sites** 라는 디렉토리를 추가해야 합니다. 이는 `~user` 요청에 응답하기 위해서입니다.
3. **Sites** 디렉토리에 대해 기본 접근 방식을 지정해야 합니다. : 디렉토리를 `read-only`로 지정하기 위해서는 **/private/etc/apache2/users** 폴더에 자신의 계정명으로 된 **username.conf** 파일을 만들어야 합니다.
4. 그 외에 **httpd.conf** 파일에서 **/private/etc/apache2/extra/httpd-userdir.conf** 파일을 include 하는 코드도 주석을 제거해야 합니다 : 이 파일의 변경 사항을 적용하기 위해서입니다.

일단 이 파일에서 다음처럼 `Include /private/etc/apache2/users/*.conf` 문장의 주석을 제거하고 저장합니다.

```vi
Include /private/etc/apache2/users/*.conf
```

<!--
> `$ sudo vi http-userdir.conf` 명령으로 파일을 수정했다면, vi 에디터에서 `esc` 키를 눌러 제어 모드로 들어간 다음 `:wq` 를 입력해서 파일을 저장하고 닫을 수 있습니다.
-->

#### userdir 활성화를 위해 **httpd.conf** 파일 수정하기

앞의 1번 항목에서 설명한대로 일단 **httpd.conf** 파일에서 **mod\_authz\_core**, **mod\_authz\_host**, **mod\_userdir** 이렇게 3개의 모듈을 활성화해야 합니다.

macOS 요세미티 이후로는 **mod\_authz\_host** 와 **mod\_authz\_core** 모듈은 이미 주석이 제거되어 있으므로, **mod\_userdir** 모듈만 다음과 같이 주석을 제거하여 활성화 합니다.

```vi
LoadModule userdir_module libexec/apache2/mod_userdir.so
```

이 때, 앞의 4번 항목에서 설명한 **httpd-userdir.conf** 파일을 '불러 오는 (include)' 부분의 주석도 같이 제거합니다.

```vi
Include /private/etc/apache2/extra/httpd-userdir.conf
```

#### 홈 디렉토리에 Sites 폴더 만들기

2번 항목에서 설명하 **Sites** 디렉토리를 macOS 의 '홈 디렉토리' 에 만들어 줍니다.[^home-directory]

```zsh
$ cd ~
$ mkdir Sites
```

> Sites 폴더를 macOS 의 'Finder (파인더)' 로 확인하면, 자동으로 '웹 사이트 폴더' 로 인식하는 것을 볼 수 있습니다.

이 폴더에 자신만의 **index.html** 파일을 만들면 첫 화면에 나타나게 됩니다. **index.html** 이 없으면, 아파치에서 기본 제공하는 index 파일이 나타납니다.

#### userdir 활성화를 위해 **username.conf** 파일 생성하기

이제 3번 항목에 해당하는 **Sites** 디렉토리에 대한 접근 방식을 지정하기 위해, **/private/etc/apache2/users** 디렉토리에 **username.conf** 파일을 만들고, 내용은 다음과 같이 해줍니다.

```vi
<Directory "/Users/username/Sites/">
  AddLanguage en .en
  AddHandler perl-script .pl
  PerlHandler ModPerl::Registry
  Options Indexes MultiViews FollowSymLinks ExecCGI
  AllowOverride None
  Require host localhost
</Directory>
```

권한 설정 부분은 아파치 서버 버전에 맞도록 작성해 줍니다.[^setting-apache2]

### 아파치 재시작하기

아파치의 설정을 변경했다면 설정을 완료한 후 아파치를 재시작해야 합니다. 아래와 같은 명령으로 아파치 웹서버를 재시작할 수 있습니다.

```zsh
$ sudo apachectl graceful
```

이제 `localhost/~username` 으로 접속하면 **Sites** 폴더에 있는 **index.html** 이 나타나는 것을 볼 수 있습니다.

### 아파치 종료하기

macOS 에서 실행 중인 아파치를 종료하는 방법은 다음 명령을 사용합니다.[^launchctl-unload]

```zsh
$ sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist
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

### 참고 자료

[^apache]: '아파치 (apache)' 는 전세계에서 가장 많이 사용하고 있는 HTTP 서버이며, macOS 에는 기본 설치되어 있는 HTTP 서버입니다.

[^apple-DOC-3083]: macOS Yosemite 이후로 웹서버 설정 방법이 변경되었다는 내용은 [Setting up a local web server on OS X](https://discussions.apple.com/docs/DOC-3083) 를 보도록 합니다.

[^references]: 이 글의 최초 버전은 [limslee](http://devmac.tistory.com/) 님의 [맥에 웹서버(Apache, PHP) 구동하기 - 요세미티 기준](http://devmac.tistory.com/11) 과 [Apple Communities](https://discussions.apple.com/) 의 [Setting up a local web server on OS X](https://discussions.apple.com/docs/DOC-3083) 를 참고하여 작성하였고, 이 후 macOS Catalina 에서도 정상 동작하는 것을 확인하면서 일부 수정한 것입니다.

[^launchctl]: macOS 에서 `$ sudo apachectl start` 명령으로 아파치를 실행하는 방법은 표준이 아닌 것 같습니다. macOS 에서 '데몬' 을 실행하는 방법에 대한 더 자세한 내용은 [macOS: Daemon (데몬) 실행하고 관리하기]({% post_url 2020-05-18-Running-and-Managing-Daemons-on-Mac %}) 를 보도록 합니다.

[^macOS-unix]: macOS 는 유닉스 계열 (Unix-like) OS로 분류되는데, 유닉스 시스템에서 `/` 는 루트 디렉토리 (root directory) 를 의미합니다. 따라서 루트 디렉토리를 기준으로 이동할 때는 반드시 `/`를 경로의 맨 앞에 붙여줘야 합니다.  

[^private-etc]: macOS 에서 **/private** 은 해당 기기에만 해당하는 정보를 담는 디렉토리이고, **/etc** 는 주로 환경 설정 파일들을 담는 디렉토리입니다. **/etc** 디렉토리는 실제로는 **/private/etc** 디렉토리의 '심볼릭 링크' 입니다. 즉, macOS 에서 **/etc/...** 와 **/private/etc/...** 는 같은 디렉토리입니다. 각각에 대한 더 자세한 정보는 [macOS: 파일 시스템의 유닉스-고유 디렉토리 알아보기]({% post_url 2020-04-29-macOS-UNIX-specific-Directories %}) 를 보도록 합니다.

[^configuration-files]: 아파치의 `httpd.conf` 파일에 대한 더 자세한 정보는 아파치 공식 홈페이지의 [Configuration Files](https://httpd.apache.org/docs/2.4/configuring.html) 문서를 보도록 합니다.

[^setting-apache2]: [Setting up a local web server on OS X](https://discussions.apple.com/docs/DOC-3083) 글과 [맥에 웹서버(Apache, PHP) 구동하기 - 요세미티 기준](http://devmac.tistory.com/11) 글의 설정 방법이 다른데, 일단은 후자의 설정을 따랐습니다. 이 부분은 좀 더 내용을 알게 되면 정리하도록 하겠습니다.

[^home-directory]: macOS 의 홈 디렉토리에 대해서는 [macOS: 파일 시스템의 유닉스-고유 디렉토리 알아보기]({% post_url 2020-04-29-macOS-UNIX-specific-Directories %}) 에 있는 [`~` : macOS 의 홈 디렉토리]({% post_url 2020-04-29-macOS-UNIX-specific-Directories %}#--macos-의-홈-디렉토리) 부분을 보도록 합니다.

[^launchctl-unload]: macOS 에서 `$ sudo apachectl stop` 명령으로 아파치를 종료하는 방법은 표준이 아닌 것 같습니다. macOS 에서 '데몬' 을 종료하는 방법에 대한 더 자세한 내용은 [macOS: Daemon (데몬) 실행하고 관리하기]({% post_url 2020-05-18-Running-and-Managing-Daemons-on-Mac %}) 를 보도록 합니다.

[^webdir-httpd]: [CentOS: Apache(아파치) 설정파일 분석 - httpd.conf](http://webdir.tistory.com/178)
