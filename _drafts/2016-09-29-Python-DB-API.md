### DB-API

DB-API는 관계형 데이터베이스를 위한 파이썬 표준 API입니다. 이 API를 사용하면 DB의 종류에는 독립적으로 하나의 프로그램만 작성하면 됩니다. 일종의 ODBC 같은 거라고 봐도 될 것 같습니다.

메인 함수는 다음과 같습니다. 

```
connect()
cursor()
execute(), executemany()
fetchone(), fetchmany(), fetchall()

```

* connect() : 데이터베이스 연결을 만듭니다. 사용자 이름, 비밀번호, 서버 주소 등의 인자를 포함합니다.
* cursor() : 질의(query)를 관리하기 위한 커서 객체를 만듭니다.
* execute() : 데이터베이스에 하나 이상의 SQL 명령을 실행합니다.
* fetch() : 실행 결과를 얻습니다. 

#### Placeholder

플레이스홀더(placeholder)에 대한 내용을 정리해 둘 필요가 있습니다. 

```
curs.execute('''INSERT INTO zoo VALUES("duck", 5, 0.0)''')
curs.execute('''INSERT INTO zoo VALUES("bear", 2, 1000.0)''')

ins = '''INSERT INTO zoo (critter, count, damages) VALUES(?, ?, ?)'''
curs.execute(ins, ('wease1', 1, 2000.0))
```

1. 플레이스홀더를 사용하면 인용부호를 억지로 구겨 넣을 필요가 없습니다. 
2. 플레이스홀더를 사용하면 웹에서 악의적인 SQL 명령을 삽입하는 외부공격(SQL injection)을 막을 수 있습니다.

### SQLAlchemy

파이썬에서 가장 인기 있는 크로스 데이터베이스 라이브러리는 `sqlalchemy`라고 합니다. pip로 설치가 가능하다고 하는데, anaconda로 설치하면 이미 설치가 되어 있는 것 같습니다.[^SQLAlchemy]

일단 크로스 데이터베이스 라이브러리는 DB 마다 다른 SQL을 처리하기 위해 DB_API를 사용하게 되는데, 이를 잘 포장한 것으로 이해하고 있습니다. 나중에 잘못된 부분은 수정하도록 하겠습니다.

SQLAlchemy는 다양한 수준에서 사용할 수 있다고 합니다. 낮은 수준에서는 DB_API 처럼 사용하며, 중간 수준에서는 SQL 표현 언어와 유사한 방법, 그리고 가장 높은 수준에서는 ORM(Object Relational Model)으로 사용한다고 합니다.

그리고 sqlalchemy를 사용하면, 따로 드라이버를 import할 필요없이, sqlalchemy에서 제공하는 최초의 연결 문자열에서 드라이버를 선택한다고 합니다. 

```
dialert + driver : // user : password @ host : port / dbname
```

* dialert : 데이터베이스 타입
* driver : 사용하고자 하는 데이터베이스의 특정 드라이버
* user, password : 데이터베이스 인증 문자열, 사용자와 비밀번호
* host, port : 데이터베이스 서버의 위치 (포트는 데이터베이스 포트가 기본 설정이 아닐때만 입력합니다.)
* dbname : 서버에 연결할 데이터베이스 이름

db | driver
---|---
sqlite | pysqlite
sqlite | -
mysql | mysqlconnector
mysql | pymysql
mysql | oursql
postgresql | psycopg2
postgresql | pypostgresql

#### 엔진 레이어

일단 SQLite에 연결할 경우, 연결 문자열에서 host, port, user, password는 생략 가능합니다.(아직 정확한 것은 아닙니다. 일단은 없어도 되는 것 같습니다.)

dbname을 생략하면, SQLite는 메모리에 데이터베이스를 만든다고 합니다.

dbname이 `/`(슬래쉬)로 시작한다면 이것은 리눅스와 macOS에서 절대 경로 파일 이름입니다. 윈도우에서는 `C://`와 같이 사용할 수 있습니다. 

그리고, 위에서 처럼 SQLite의 경우 driver를 생략할 수 있습니다.

따라서, `sqlite://`라고 간단하게 작성할 수 있습니다. 이것은 `sqlite:///:memory:`라고 명시적으로 적어도 같은 결과라고 합니다.

```
import sqlalchemy as sa

conn = sa.create_engine('sqlite://')
```

`sqlalchemy`의 `execute()`는 `ResultProxy`라는 SQLAlchemy 객체를 반환합니다.

`sqlalchemy`을 엔진 레이어에서 사용하는 것은 DB-API를 직접 사용하는 것과 거의 동일합니다. 

다만, `sqlalchemy`을 엔진 레이어에서 사용하면 코드 앞에서 데이터베이스 driver를 import하지 않아도 된다는 장점이 있으며, 또 connection pooling이 되는 장점이 있습니다.[^ConnectionPooling]

#### SQL 표현 언어 레이어

표현 언어(Expression Language) 레이어에서는 하위 수준인 엔진 레이어 보다 더 다양한 SQL 문을 처리할 수 있고, 중간에서 관계형 데이터베이스 어플리케이션을 쉽게 접근할 수 있도록 해준다고 합니다. 

일단 예제를 봤을 경우에는 DB-API나 low level에서 사용하는 것보다 좋은 점이 잘 나타나지 않는 것 같습니다. 

#### ORM 레이어

ORM(Object-Relational Mapper, Object Relational Model)은 SQL 표현 언어를 사용하지만, 실제 데이터베이스의 메커니즘을 숨긴다. 그리고 ORM 클래스를 정의하여 데이터베이스의 데이터 입출력을 처리한다.

Sessionmaker()가 정확하게 뭘 하는지를 모르겠습니다. 일단 세션에 대해서 알아야 할 것 같습니다. 메모리에 존재하는 것을 실제 데이터베이스에 연결하는 것과 관련이 있는지 알아봐야 할 것 같습니다. 나중에 업데이트 하려고 합니다. 

ORM 이라는 것은 당장 데이터베이스를 만드는 것이 아니라 메모리 상에서 데이터베이스 조작을 한 다음 session을 통해서 물리 공간에 데이터베이스를 만드는 방식일 수 있습니다.(솔직히 아직 잘 모르겠습니다. 테스트 결과 이건 아니었습니다.) 

아니면 실제 데이터베이스가 있을 때, 이 데이터베이스에 접근할 수 있는 하나의 객체를 session이라고 볼 수 있지 않을까 합니다. 

Session 전과 후의 데이터베이스가 조금 다릅니다. 어떤 변화가 있는 것 같습니다. 

#### 접근 레이어에 대한 선택

책에서는 ORM을 간단한 어플리케이션에서 드물게 사용할 것을 권장하고 있습니다. 

일반적으로 어플리케이션이 간단하다면 바로 SQL을 사용할 수도 있고, 데이터셋(dataset) 같이 더 간단한 것을 시도할 수도 있습니다. 데이터셋은 SQLAlchemy 기반으로 SQL, JSON, CSV 저장소에 대한 간단한 ORM을 제공합니다. 

### 참고 자료

[Introducing Python]()

[^SQLAlchemy]: [SQLAlchemy](http://www.sqlalchemy.org)

[^ConnectionPooling]: [Connection Pooling](http://docs.sqlalchemy.org/en/latest/core/pooling.html)