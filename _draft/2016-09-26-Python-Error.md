### Unicode Problem

Atom 에디터에서 unicode 출력에 문제가 있던 것이 소리소문 없이 해결되었습니다. 

### TypeError: a bytes-like object is required, not 'str'

2.x 에 없던 b'abcde' 라는 바이트 스트림 문자열 상수(리터럴)이 존재합니다.
암복호화를 비록하여 아주 많은 함수들이 기존 문자열 대신 이 바이트 스트림을 
패러미터 또는 결과값으로 이용합니다.[^egloos]

### 참고 자료

[UnicodeEncodeError: 'ascii' codec can't encode character u'\xef' in position 0: ordinal not in range(128)](http://stackoverflow.com/questions/5141559/unicodeencodeerror-ascii-codec-cant-encode-character-u-xef-in-position-0)

[유니코드와 UTF-8간의 전쟁(?)](http://seorenn.blogspot.kr/2011/05/python-utf-8.html)

[^egloos]: [버전2에서 버전3으로 옮겨갈 때 주의점들](http://egloos.zum.com/mcchae/v/11195891)