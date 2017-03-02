우분투 (Ubuntu) 에 [MySQL](https://www.mysql.com) 을 설치하는 방법을 정리합니다. [^mysql]

### MySQL 서버 설치

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

#### 처음 실행

아래와 같이 실행하고 비밀번호는 설치 과정에서 입력한대로 입력합니다. 

```
$ mysql -u root -p
```

설치가 잘 되었으면 mysql 프롬프터가 뜹니다.

#### 에러

MySQL 설치 과정에서 발생하는 에러는 아래를 참고합니다.

[Could not get lock /var/lib/dpkg/lock - open (11 Resource temporarily unavailable) 해결 방법(Solution)](http://pwnbit.kr/76)

### MySQL Workbench 설치

**Ubuntu Software** 에서 MySQL Workbench 를 검색해서 설치해 줍니다.

#### root 계정으로 접속하기

첫 화면에서 root 로 접속하는 버튼을 누르고 위에서 만들어준 비밀 번호를 입력합니다.

#### 데이터베이스 스키마 추가하기

_MySQL 에서는 데이터베이스 자체를 스키마라고 표현하는 것 같습니다. 확인이 필요합니다._

데이터베이스 스키마 추가 아이콘을 선택합니다. Default Collation: 은 `utf32 - utf32_general_ci` 를 선택합니다. 그리고 데이터베이스 이름을 추가한 후 Apply 를 선택합니다. 

그러면 적용할 스크립트를 보여줍니다. Apply 를 누르면 스크립트 실행이 성공했다는 화면이 뜹니다. Finish 나 Done 등을 눌러서 화면을 닫으면 새 데이터베이스 스키마가 만들어진 것을 확인할 수 있습니다.

#### 데이터베이스 사용자 만들기

**Users and Privileges** 메뉴를 선택합니다. 그러면 나타나는 화면에서 밑에 있는 Add Account 버튼을 누릅니다. 

**Login** 탭에서 사용자 id 를 입력하고 비밀 번호를 넣어줍니다. Limit to Hosts Matching 값이 `%` 이면 모든 호스트(ip)로부터 접속이 가능하다는 의미가 됩니다.

**Schema Privileges** 탭을 선택합니다. Add Entry 버튼을 누릅니다. 해당 사용자에게 연결을 허락할 데이터베이스 스키마를 지정합니다. Selected schema: 를 선택하고 방금 전에 만든 데이터베이스 스키마를 선택합니다. 지정하고 나서 OK 를 누릅니다. 

#### 권한 설정하기 

해당 데이터베이스 스키마에서 사용가능한 권한들을 넣어줍니다. 
DML, DDL 만 넣으면 되는데 (_블랑코라서?_), 테스트용으로는 Select ALL을 선택하고 Apply 를 눌러줍니다. 

사용자 계정을 만들고 권한을 부여했습니다. 

### 고찰하기 

나중에 우분투에 PostgreSQL 을 설치하는 방법도 정리합니다. 테스트는 장고나 Swift 로 할 수 있을 것입니다.

### 참고 자료

[^mysql]: [MySQL](https://www.mysql.com) 설치 관련 설명은 따로 없는 것 같습니다.

[^moomini-66]: [Ubuntu(우분투) MySQL 설치](http://moomini.tistory.com/66) 여기에 설명이 잘 되어 있는데, mysql-server 의 설치는 이 설명만으로도 충분한 것 같습니다. 아래의 두 자료는 보고 비교해서 정리하면 될 것 같습니다.

[MySQL Workbench(워크벤치) 설치하기](http://moomini.tistory.com/67)

[Ubuntu 14\_04\_LTS: MySQL 설치](http://blog.whoborn.net/2015/06/01/ubuntu-14_04_lts-mysql-설치/)

[ubuntu mysql 설치 및 설정하기](http://jaesu.tistory.com/entry/ubuntu-mysql-설치-및-설정하기)

