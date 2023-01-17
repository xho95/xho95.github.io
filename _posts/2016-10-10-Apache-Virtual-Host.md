---
layout: post
pagination: 
  enabled: true
comments: true
title:  "Apache : 아파치 가상 호스트 설정하기"
date:   2016-10-10 11:58:00 +0900
categories: macOS Apache WebServer VirtualHosts
---

이 글은 아파치 웹 서버를 설정하는 방법에 대한 시리즈 글의 일부입니다. 관련 목차는 아래와 같습니다.

* [맥에서 아파치 웹 서버 실행하기]({% post_url 2016-10-02-Apache-WebServer %})
* [아파치 가상 호스트 설정하기]()

이번 글에서는 아파치 웹서버에서 가상 호스트를 사용하는 방법을 정리합니다. 기본적으로 [**Jason McCreary's  Blog**](https://jason.pureconcepts.net) 글 [Configuring Apache Virtual Hosts on Mac OS X](http://jason.pureconcepts.net/2014/11/configure-apache-virtualhost-mac-os-x/) 를 중심으로 다른 자료들을 참고해서 정리했습니다. [^pureconcepts]  [^joont]

### 가상 호스트(Virtual Hosts)라는 것은 무엇인가?

[아파치 Virtual Host 공식 문서](http://httpd.apache.org/docs/current/en/vhosts/)에 따르면 가상 호스트(Virtual Hosts)라는 것은 한 대의 기기에서 하나 이상의 웹 사이트를 구동 시키기 위한 기술을 말합니다. [^docs-vhosts]

기본적으로, 맥 OS에서 아파치 환경 설정 파일을 구성하면 **/Library/WebServer/Documents** 위치에 있는 서버 파일들은 브라우저에서 `locahost`로 접속할 수 있습니다. [^Apache-WebServer]

다만, 이것은 하나의 사이트에 대한 설정입니다. 물론 `userdir`을 활성화 한다든지 해서 하위 디렉토리를 만들어서 `localhost/somesite` 같이 여러 사이트를 만든 것처럼 흉내낼 수는 있습니다.

하지만 이것은 어딜 봐도 그다지 좋아 보이진 않습니다. 특히 여러 사이트를 운영한다면 하위 디렉토리가 아니라 `somesite.local` 처럼 독립된 주소로 접근하고 싶을 것입니다.

바로 이럴 때 필요한 것이 가상 호스트입니다. 가상 호스트를 설정하면 여러 사이트 주소를 지원할 수 있기 때문입니다.

### 아파치 가상 호스트 설정하기

#### httpd.conf 파일 수정하기

아파치 환경 설정 파일을 편집합니다. 아파치 환경 설정 파일은 **/private/etc/apache2/** 폴더의 **httpd.conf**입니다. 편집은 아래와 같이 관리자 권한으로 할 수 있습니다.

```
$ cd /private/etc/apache2/
$ sudo vi httpd.conf
```

**httpd.conf** 파일에서 아래와 같이 `Include /private/etc/apache2/extra/httpd-vhosts.conf` 부분의 주석을 해제합니다. [^difference]  

```
...
# Virtual hosts
Include /private/etc/apache2/extra/httpd-vhosts.conf
...
```

그러면 이제 **/private/etc/apache2/extra/** 폴더에 있는 **httpd-vhosts.conf** 파일을 사용할 수 있게 됩니다.

> 참고로 **httpd.conf** 파일에서 **mod\_log\_config** 모듈도 활성화해야 하는데, 이미 활성화되어 있는 것 같습니다.

#### httpd-vhosts.conf 파일 수정하기

**/private/etc/apache2/extra/** 폴더에 있는 **httpd-vhosts.conf** 파일에서 가상 호스트에 대한 설정을 하도록 합니다. 마찬가지로 아래와 같이 편집할 수 있습니다.

```
$ cd /private/etc/apache2/extra
$ sudo vi httpd-vhosts.conf
```

**httpd-vhosts.conf** 파일에 다음과 같은 내용을 추가해 줍니다.

```
<VirtualHost *:80>
    DocumentRoot "/Users/username/user-sites"
    ServerName www.user-domain.com
    ErrorLog "/private/var/log/apache2/www.user-domain.com-error_log"
    CustomLog "/private/var/log/apache2/www.user-domain.com-access_log" common

    <Directory "/Users/username/user-sites">
        Options Indexes MultiViews
        AllowOverride None
        Require all granted        
    </Directory>
</VirtualHost>
```

위와 같이 하면 가상 호스트 설정에 의해서 (로컬 개발환경에서?) 웹 사이트를 `http://www.user-domain.com`과 같이 접근할 수 있습니다.

`Require all granted` 설정은 Apache 2.4 환경에 맞추기 위한 것으로 OS X 요세미티 이후 버전에 해당합니다. 요세미티 이전 버전이면 아파치 2.2 설정에 맞춰야 합니다. [^docs-upgrading]

#### hosts 파일 수정하기

이제 만들어준 사이트에 로컬 접속을 하기 위해서 호스트(hosts) 파일을 수정합니다. 이는 테스트 과정이라고 볼 수 있는데 일단 현재는 도메인 네임(Domain Name)이 없으므로 이 파일에 임시로 도메인 네임을 지정한다고 볼 수 있습니다.

**/private/etc/** 폴더의 **hosts** 파일을 아래와 같이 편집하면 됩니다.

```
$ cd /private/etc/
$ sudo vi hosts
```

**hosts** 파일의 맨 밑에 아래와 같은 내용을 붙여줍니다.

```
127.0.0.1 www.user-domain.com
```

이제 아파치 서버를 재시작하면 `www.user-domain.com`으로 로컬 호스트에 접근할 수 있습니다.

#### 접근 권한 문제 해결하기

하지만 실행하면 아래와 같이 접근 거부(403 Forbidden) 메시지가 뜰 수 있습니다.

```
Forbidden

You don't have permission to access / on this server.
```

실제로 위와 같은 문제를 해결하는 방법은 여러가지가 있습니다.

1. [Configuring Apache Virtual Hosts on Mac OS X](http://jason.pureconcepts.net/2014/11/configure-apache-virtualhost-mac-os-x/) 에서는 해당 디렉토리의 접근권한을 755로 변경하는 방법을 택했습니다.[^uci] 다만 이 방법은 유일한 방법도 아니고, 가장 좋은 방법도 아니며, 단지 가장 쉬운 방법이라고 합니다.

2. [아파치 VIRTUALHOST 설정](http://joont.tistory.com/46) 에서는 이 문제를 **httpd.conf** 파일에 `<Directory>` 태그를 추가해서 해결했습니다.

3. 저는 **httpd-vhosts.conf** 파일의 `<Directory>` 태그에서 접근 권한 설정을 변경해서 해결하는 방법을 택했습니다.

따라서 이 블로그 글을 그대로 따라했을 경우 접근 권한 문제는 발생하지 않는 것이 정상입니다. 하지만, 이 방법이 최선인지는 아직 모르는 상황이라 혹시 문제가 발생하셨다면 댓글로 알려주시면 글을 수정하도록 하겠습니다.

<!--
### mod_wsgi 설치

내용을 추가할 예정입니다.[^modwsgi]  [^jakowicz]  [^mod-wsgi]  [^docs-modwsgi]  [^flask]  [^egloos]  [^novafactory]
-->

### 고찰하기

일단 참고 자료마다 설정하는 값들이 달라서 최선의 설정 방법이 무엇인지는 아직 모릅니다. 아파치 버전 문제에 따른 설정 값 변경도 있는 것 같고, 서버를 설정하는 사람마다 선호하는 방법이 조금씩 다른 것 같습니다.

참고 자료처럼 macOS Sierra에 대한 새로운 자료들도 계속 나오고 있는 것 같습니다. [^sierra-apache]

이 부분은 새롭게 알게 되는  내용이 있으면 정리해서 올릴 예정입니다.

### 참고 자료

[^pureconcepts]: [Configuring Apache Virtual Hosts on Mac OS X](http://jason.pureconcepts.net/2014/11/configure-apache-virtualhost-mac-os-x/) : 맥에서 가상 호스트를 설정하는 방법에 대해서 잘 정리된 글입니다.

[^joont]: [아파치 VIRTUALHOST 설정](http://joont.tistory.com/46) : 아파치의 가상 호스트 설정에 대해서 잘 정리한 글입니다. 다만 윈도우 OS에 대해서 설명을 한 자료입니다.

[^docs-vhosts]: [Apache Virtual Host documentation](http://httpd.apache.org/docs/current/en/vhosts/) :  Virtual Host에 대한 Apache 공식 문서입니다.

[^Apache-WebServer]: [맥에서 아파치 웹 서버 실행하기]({% post_url 2016-10-02-Apache-WebServer %}) : 아파치 웹 서버를 설정하고 실행하는 방법에 대해서 정리했습니다.

[^difference]: 이 부분은 [Configuring Apache Virtual Hosts on Mac OS X](http://jason.pureconcepts.net/2014/11/configure-apache-virtualhost-mac-os-x/) 글과는 조금 다른데, 원문처럼 해도 되지만 다른 자료에서는 이렇게 하는 경우가 많아서 참고 자료와는 다르게 했습니다. 환경 설정에는 다양한 방법이 존재하므로 이 부분은 취향대로 해도 될 것 같습니다. 원문에서는 최대한 원본을 건드리지 않는 방법을 사용한 것 같습니다.

[^docs-upgrading]: [Upgrading to 2.4 from 2.2](http://httpd.apache.org/docs/2.4/upgrading.html#run-time) : 아파치 웹 서버를 2.2 버전에서 2.4 버전으로 업그레이드하는 방법에 대해서 설명한 공식 문서입니다.

[^uci]: [Understanding and Setting UNIX File Permissions](https://www.ics.uci.edu/computing/linux/file-security.php) : Unix 시스템의 파일에 대한 접근 권한을 설정하는 방법을 잘 정리한 글입니다.

[^modwsgi]: [Quick Installation Guide](https://modwsgi.readthedocs.io/en/develop/user-guides/quick-installation-guide.html) : mod_wsgi 설치 방법에 대해 설명한 공식 문서입니다.

[^jakowicz]: [Setting up the Apache WSGI module on OSX 10.9](http://www.jakowicz.com/setting-up-apache-wsgi-module-on-osx-10-9/)

[^mod-wsgi]: [mod_wsgi](https://modwsgi.readthedocs.io/en/develop/)

[^docs-modwsgi]: [How to use Django with Apache and mod_wsgi](https://docs.djangoproject.com/en/1.10/howto/deployment/wsgi/modwsgi/)

[^flask]: [mod_wsgi (아파치)](http://flask-docs-kr.readthedocs.io/ko/latest/deploying/mod_wsgi.html) : Flask 서버의 문서에 Apache 웹서버를 사용하고 있다면, mod_wsgi 를 사용할 것을 고려하라고 하는 글이 있습니다.

[^egloos]: [Django + Apache + mod_wsgi 연동 방법](http://egloos.zum.com/killins/v/3013358)

[^novafactory]: [Python, Flask, WSGI, Apache 설정 삽질 ㅠ on CentOS 6](http://novafactory.net/archives/3074)

[^sierra-apache]: [macOS 10.12 Sierra Apache Setup: MySQL, APC & More...](https://getgrav.org/blog/macos-sierra-apache-mysql-vhost-apc) : macOS Sierra에서 여러 프로그램들을 설정하는 방법에 대해서 정리한 글입니다.
