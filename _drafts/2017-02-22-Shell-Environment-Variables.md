[unix / linux: shell (쉘)을 이해하자.](http://blogger.pe.kr/300) 글을 보면 쉘을 이해할 때 환경 변수가 중요함을 강조하고 있습니다. 따라서 새롭게 내용을 추가해야 할 것 같습니다. 블로그 자체가 아주 좋은 것 같습니다.

### 환경 변수 확인하기

**bash** 쉘에서는 `env` 명령으로 환경 변수를 확인할 수 있습니다. [unix / linux: shell (쉘)을 이해하자.](http://blogger.pe.kr/300) 글에 따르면 **bash** 는 Bourne again shell 이라는 의미라고 합니다.

```
$ env
```

### 환경 변수 설정 파일 

[unix / linux: shell (쉘)을 이해하자.](http://blogger.pe.kr/300) 글에 따르면 리눅스 bash 쉘에서는 **/etc/profile** 과 **/etc/bashrc** 두 개의 파일과 사용자 홈 디렉토리의 **.bashrc** 가 환경변수가 설정될 수 있는 파일이라고 합니다.

한편, sh 의 경우 **/etc/profile** 과 사용자 홈 디렉토리의 **.profile** 이라고 합니다.

쉘마다 적용되는 환경 설정 파일에 차이가 있는 것인데 이부부에 대해서 좀 더 알아봐야 겠습니다.

### 참고 자료

[^blogger-300]: [unix / linux: shell (쉘)을 이해하자.](http://blogger.pe.kr/300) 글은 그동안 왜 모르고 지냈는지 신기할 정도로 좋은 글이고 블로그도 좋은 것 같습니다.

