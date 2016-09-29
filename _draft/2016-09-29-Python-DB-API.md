### Placeholder

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
