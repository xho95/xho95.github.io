우분투 (Ubuntu) 에 [MySQL](https://www.mysql.com) 을 설치하는 방법을 정리합니다. [^mysql]

나중에 우분투에 PostgreSQL 을 설치하는 방법도 정리합니다. 테스트는 장고나 Swift 로 할 수 있을 것입니다.

### MySQL 설치

#### 설치 가능한 버전 확인하기 

다음의 명령을 이용합니다. [^moomini-66]

```
$ sudo apt-cache search mysql-server
```

#### 설치 

설치할 때는 `sudo` 를 넣어야 합니다. 앞서 설치 가능한 버전 확인하기의 결과에 따라 버전이 조금 달라질 수 있습니다.

```
$ sudo apt-get install mysql-server-5.7
```

앞에 `sudo` 가 빠지면 Permission denied 에러가 발생합니다.

#### 에러

MySQL 설치 과정에서 발생하는 에러는 아래를 참고합니다.

[Could not get lock /var/lib/dpkg/lock - open (11 Resource temporarily unavailable) 해결 방법(Solution)](http://pwnbit.kr/76)

### MySQL Workbench 설치

### 참고 자료

[^mysql]: [MySQL](https://www.mysql.com) 설치 관련 설명은 따로 없는 것 같습니다.

[^moomini-66]: [Ubuntu(우분투) MySQL 설치](http://moomini.tistory.com/66) 여기에 설명이 잘 되어 있는데, mysql-server 의 설치는 이 설명만으로도 충분한 것 같습니다. 아래의 두 자료는 보고 비교해서 정리하면 될 것 같습니다.

[MySQL Workbench(워크벤치) 설치하기](http://moomini.tistory.com/67)

[Ubuntu 14\_04\_LTS: MySQL 설치](http://blog.whoborn.net/2015/06/01/ubuntu-14_04_lts-mysql-설치/)

[ubuntu mysql 설치 및 설정하기](http://jaesu.tistory.com/entry/ubuntu-mysql-설치-및-설정하기)

