### Unicode Problem

Atom 에디터에서 unicode 출력에 문제가 있던 것이 소리소문 없이 해결되었습니다. [^stackoverflow-5141559]

[유니코드와 UTF-8간의 전쟁(?)](http://seorenn.blogspot.kr/2011/05/python-utf-8.html) 는 뭔지는 모르겠지만 읽어볼 만한 글인 것 같습니다. 

### TypeError: a bytes-like object is required, not 'str'

2.x 에 없던 b'abcde' 라는 바이트 스트림 문자열 상수(리터럴)이 존재합니다.
암복호화를 비록하여 아주 많은 함수들이 기존 문자열 대신 이 바이트 스트림을 파라미터 또는 결과값으로 이용합니다.[^egloos]

### Tips

#### Dictionary 에서 List 뽑아 내기

[Python: simplest way to get list of values from dict?](http://stackoverflow.com/questions/16228248/python-simplest-way-to-get-list-of-values-from-dict) 글을 참고하면 됩니다. [^stackoverflow-16228248]

다만, 위의 글은 Error와는 상관이 없으므로 내용을 나중에 Python 활용에서 Dictionary 나 List 쪽으로 옮기도록 합니다. 

### 참고 자료

[^stackoverflow-5141559]: [UnicodeEncodeError: 'ascii' codec can't encode character u'\xef' in position 0: ordinal not in range(128)](http://stackoverflow.com/questions/5141559/unicodeencodeerror-ascii-codec-cant-encode-character-u-xef-in-position-0)

[^seorenn]: [유니코드와 UTF-8간의 전쟁(?)](http://seorenn.blogspot.kr/2011/05/python-utf-8.html)

[^egloos]: [버전2에서 버전3으로 옮겨갈 때 주의점들](http://egloos.zum.com/mcchae/v/11195891)

[^stackoverflow-16228248]: [Python: simplest way to get list of values from dict?](http://stackoverflow.com/questions/16228248/python-simplest-way-to-get-list-of-values-from-dict)