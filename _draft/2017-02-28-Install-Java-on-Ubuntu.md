### 자바 설치

이 설명은 [How To Install Java with Apt-Get on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04) 글을 참고해서 작성하였습니다.

먼저 `apt-get` 을 업데이트 해 줍니다.

```
$ sudo apt-get update
```

그다음 다음과 같이 JDK를 설치합니다.

```
$ sudp apt-get install default-jdk
```

JDK 는 JRE 를 포함하고 있으므로 JDK 만 설치하면됩니다. 물론 JRE 가 크기가 작으므로 상황에 따라 JRE 만 설치해도 됩니다. [^digitalocean-java]

그냥 웹 페이지에서 다운 받아도 되는 것 같기는 합니다.

### 참고 자료

[^digitalocean-java]: [How To Install Java with Apt-Get on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04)

