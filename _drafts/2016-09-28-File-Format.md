### 구조화된 텍스트 파일

#### CSV

구분된 파일(delimited file)의 한 종류입니다. 스프레드 시트와 데이터베이스의 데이터 교환 형식으로 많이 사용됩니다.[^Bill]

csv 파일 파싱을 위한 파이썬 표준 라이브러리에는 `csv`가 있습니다.

#### XML

마크업 형식 파일의 한 가지 종류입니다. XML은 데이터를 구분하기 위해 태크(tag)를 사용합니다. 

아래와 같은 몇 가지 하위 형식이 있습니다.

* RSS : Rich Site Summary
* Atom

XML 파일 파싱을 위한 파이썬 라이브러리는 다음과 같은 것들이 있습니다.

* `xml.etree.ElementTree`
* `xml.dom`
* `xml.sax`

#### HTML

책에서는 9장에서 다룹니다. 나중에 추가할 것입니다.

#### JSON

JSON(JavaScript Object Notation)은 데이터를 교환하는 형식으로 널리 쓰이고 있습니다. JSON은 자바스트립트의 subset(부분집합?)이면서, 유효한 파이썬 구문이기도 합니다.

파이썬에서 JSON 파일을 다루기 위한 모듈은 `json` 하나입니다.

#### YAML

YAML은 'YAML Ain't Markup Language'의 줄임말로, YAML은 마크업 언어가 아니다라는 의미가 됩니다. YAML 파일은 파이썬 언어처럼 들여쓰기를 통해서 파일의 구조를 구분합니다.

파이썬에서는 `yaml`이라는 third-party 라이브러리를 사용해서 파싱합니다.

YAML 파일에 대한 내용는 참고 사이트들을 보시면 됩니다.[^yaml]  [^ansible]  [^doku]

#### INI 

윈도우 설정 파일입니다. 

파싱을 위해서는 표준 라이브러리인 `configparser`를 사용합니다. 

### 이진 데이터 교환 형식

* MsgPack
* Protocol Buffers
* Avro
* Thrift

이진(binary) 데이터 교환 형식은 일반적으로 텍스트 형식보다 간결하고 빠르다고 합니다. 대신에 이진 형식이므로 텍스트 편집기로 편집하기는 힘들다고 합니다. 

구조화된 이진 파일은 왜 여기에 포함되지 않는지 모르겠습니다. 구조화된 이진 파일은 특정 어플리케이션에 종속된 파일이라, 데이터 교환에는 사용되지 않기 때문인 듯 합니다. 

### Serialization

파이썬에서는 이진 형식으로 된 객체를 저장하고 복원할 수 있는 pickle이라는 모듈이 있다고 합니다.  

### 구조화된 이진 파일

#### XLS

마이크로소프트 엑셀 파일입니다. 

파이썬에서는 third-party 패키지인 `xlrd`를 사용하여 xls 파일을 읽고 쓸 수 있습니다.

#### HDF5

Hierachical Data Format은 다차원 혹은 계층적 수치 데이터를 위한 이진 데이터 형식으로 아주 큰 데이터에 대한 빠른 임의 접근이 필요한 과학 분야에서 주로 사용된다고 합니다. 

이 형식을 위한 파이썬 패키지로는 `h5py` 및 `PyTables`가 있습니다. `h5py`는 저수준 인터페이스를 가지고 있으며, `PyTables`는 조금 고수준의 인터페이스로 데이터베이스와 유사하다고 합니다.

### 참고 자료

[^Bill]: [Introducing Python]() 파이썬 입문용으로는 가장 좋은 책이라고 생각합니다. 

[^yaml]: [%YAML 1.2](http://www.yaml.org)

[^ansible]: [http://docs.ansible.com/ansible/YAMLSyntax.html](http://docs.ansible.com/ansible/YAMLSyntax.html) YAML 문법에 대해서 잘 정리되어 있습니다. 

[^doku]: [YAML Tutorial](http://serious-code.net/doku/doku.php?id=kb:yamltutorial) YAML의 기본 문법을 간략하게 소개하고 있습니다.