맥에서 관리자 유저로 설정을 바꾸는 명령이 있는 것 같습니다.[^jason] 터미널에서 아래와 같이 명령을 입력하면 루트 유저로 변경이 되어서 다른 명령을 입력할 때 권한 문제를 피할 수 있다고 합니다.

```
$ sudo su -
```

아무래도 루트 유저로 변경하는 것이니 만큼 조심해서 사용해야 할 것 같습니다.

### 참고 자료

[^jason]: [Installing Apache, PHP, and MySQL on Mac OS X Yosemite](https://jason.pureconcepts.net/2014/11/install-apache-php-mysql-mac-os-x-yosemite/) : 터미널에서 루트 유저로 설정을 변경하는 방법에 대해서 소개가 되고 있습니다.