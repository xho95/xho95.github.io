### 구조화된 텍스트 파일

#### CSV

구분된 파일(delimited file)의 한 종류입니다. 스프레드 시트와 데이터베이스의 데이터 교환 형식으로 많이 사용됩니다. 

csv 파일 파싱을 위한 파이썬 표준 라이브러리에는 `csv`가 있습니다.

#### XML

마크업 형식 파일의 한 가지 종류입니다. XML은 데이터를 구분하기 위해 태크(tag)를 사용합니다. 

아래와 같은 몇 가지 하위 형식이 있습니다.

* RSS : Rich Site Summary
* Atom

XML 파일 파싱을 위한 파이썬 라이브러리는 다음과 같은 것들이 있습니다.

* xml.etree.ElementTree
* xml.dom
* xml.sax

#### HTML

책에서는 9장에서 다룹니다. 나중에 추가할 것입니다.

#### JSON

JSON(JavaScript Object Notation)은 데이터를 교환하는 형식으로 널리 쓰이고 있습니다. JSON은 자바스트립트의 subset(부분집합?)이면서, 유효한 파이썬 구문이기도 합니다.

파이썬에서 JSON 파일을 다루기 위한 모듈은 json 하나입니다.

#### YAML

YAML은 'YAML Ain't Markup Language'의 줄임말로, YAML은 마크업 언어가 아니다라는 의미가 됩니다. YAML 파일은 파이썬 언어처럼 들여쓰기를 통해서 파일의 구조를 구분합니다.

파이썬에서는 yaml이라는 third-party 라이브러리를 사용해서 파싱합니다.

YAML 파일에 대한 내용는 참고 사이트들을 보시면 됩니다.[^yaml]  [^ansible]  [^doku]

### 참고 자료

[Introducing Python]()

[^yaml]: [%YAML 1.2](http://www.yaml.org)

[^ansible]: [http://docs.ansible.com/ansible/YAMLSyntax.html](http://docs.ansible.com/ansible/YAMLSyntax.html) YAML 문법에 대해서 잘 정리되어 있습니다. 

[^doku]: [YAML Tutorial](http://serious-code.net/doku/doku.php?id=kb:yamltutorial) YAML의 기본 문법을 간략하게 소개하고 있습니다.