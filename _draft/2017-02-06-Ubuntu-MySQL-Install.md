우분투 (Ubuntu) 에 MySQL 을 설치하는 방법을 정리합니다.

나중에 우분투에 PostgreSQL 을 설치하는 방법도 정리합니다. 테스트는 장고나 Swift 로 할 수 있을 것입니다.

### 설치 가능한 버전 확인하기 


### 설치 

설치할 때는 `sudo` 를 넣어야 합니다. 최신 버전에 따라서 명령이 조금 달라질 수 있습니다.

```
$ sudo apt-get install mysql-server-5.7
```

앞에 `sudo` 가 빠지면 Permission denied 에러가 발생합니다.

### 참고 자료


[MySQL](https://www.mysql.com) : 설치 관련 설명은 따로 없는 것 같습니다.

[Ubuntu 14\_04\_LTS: MySQL 설치](http://blog.whoborn.net/2015/06/01/ubuntu-14_04_lts-mysql-설치/)

[ubuntu mysql 설치 및 설정하기](http://jaesu.tistory.com/entry/ubuntu-mysql-설치-및-설정하기)

[Ubuntu(우분투) MySQL 설치](http://moomini.tistory.com/66)

MySQL 설치 과정에서 발생하는 에러는 아래를 참고합니다.

[Could not get lock /var/lib/dpkg/lock - open (11 Resource temporarily unavailable) 해결 방법(Solution)](http://pwnbit.kr/76)

