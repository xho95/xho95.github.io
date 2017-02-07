[MySQL](https://www.mysql.com) : 설치 관련 설명은 따로 없는 것 같습니다.

[Ubuntu 14_04_LTS: MySQL 설치](http://blog.whoborn.net/2015/06/01/ubuntu-14_04_lts-mysql-설치/)

[ubuntu mysql 설치 및 설정하기](http://jaesu.tistory.com/entry/ubuntu-mysql-설치-및-설정하기)

[Ubuntu(우분투) MySQL 설치](http://moomini.tistory.com/66)

MySQL 설치 과정에서 발생하는 에러는 아래를 참고합니다.

[Could not get lock /var/lib/dpkg/lock - open (11 Resource temporarily unavailable) 해결 방법(Solution)](http://pwnbit.kr/76)

위의 설명에도 `sudo` 는 빠져있는데, `sudo` 를 넣어야 합니다.

```
$ sudo apt-get install mysql-server-5.7
```

앞에 `sudo` 가 빠지면 Permission denied 에러가 발생합니다.

