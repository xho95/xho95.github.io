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

### 참고 자료

[Introducing Python]()
