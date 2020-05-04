맥에서 Mosquitto 설치 및 사용하기

맥 Sierra sbin 폴더와 Mosquitto 와 궁합이 좀 안맞습니다. [^github-4527] Mojave 도 마찬가지입니다.

`/usr/local/sbin is not writable` 이라는 오류가 발생합니다. 이에 대한 설명입니다. [^apple-312330]

`/usr/local/sbin is not writable` 문제의 해결 방법은 제 Blog 에 따로 정리한 것이 있습니다. 원인은 macOS 의 변화로 Homebrew 에서 특정 폴더에 대한 접근 권한이 없어졌기 때문에 발생하는 것입니다.

다만 참고 자료에 따르면 이제 `/usr/local` 폴더는 더 이상 `chown` 이 안됩니다. [^github-3228] `chown` 명령을 실행하면 아래와 같이 권한이 없다고 에러를 발생합니다. [^chown]

```
$ sudo chown -R $(whoami) /usr/local
Password:
chown: /usr/local: Operation not permitted
```

해결 방법은 두 가지 정도 있는 것 같습니다. 다만 두가지의 차이점은 잘 모르겠습니다.

첫번째는 `brew --prefix` 를 활용하는 방법입니다.

```
$ sudo chown -R $(whoami) $(brew --prefix)/*
```

두번째는 수동으로 `sbin` 폴더를 만든뒤 `sbin` 폴더의 권한을 바꿔주는 방법입니다.

```
$ sudo mkdir /usr/local/sbin
$ sudo chown -R `whoami`:admin /usr/local/sbin
```

참고 자료에 따르면 `/usr/local` 자체는 권한 수정이 안되지만, 그 하위 폴더는 권한 수정이 가능하다고 합니다. [^stackoverflow-46459152] 그래서 위의 방법이 통하는 것 같습니다. 그래도 꼼수같다는 느낌은 지울 수 없습니다.

참고로 Mosquitto 는 /usr/local/ 의 /bin 폴더가 아니라 /sbin 폴더에 symbolic link 를 만듭니다. (만드는 것이 symbolic link 인지 확인 필요합니다.) 두 폴더의 차이는 다음과 같습니다. [^taylormcgann]

```
/bin
    This directory contains executable programs which are needed
    in single user mode and to bring the system up or repair it.

/sbin
    Like /bin, this directory holds commands needed to boot the
    system, but which are usually not executed by normal users.    
```

어쨌든 최근 macOS 의 변화 방향으로 볼 때, 앞으로 Homebrew 와 같은 독립 package manager 는 점점 더 설자리가 없어질 것 같습니다. 아울러 macOS 자체 표준 package manager 같은 것이 도입될 것 같다는 생각이 듭니다.

### Mosquitto 사용하기

아래와 같이 `brew services list` 명령을 사용하여 현재 `mosquitto` 가 실행 중인지를 확인할 수 있습니다.

```
$ brew services list
Name       Status  User     Plist
...
mosquitto  started username /.../Library/LaunchAgents/homebrew.mxcl.mosquitto.plist
...
```

일단 http://test.mosquitto.org 에 소개된 방법으로 test 는 잘 되는 것 같습니다. 이건 mosquitto 에서 테스트용으로 제공하는 서버입니다.

```
mosquitto_sub -h test.mosquitto.org -t "#" -v
```

다만, 참고 문헌[^lemonheim-mosquitto] 에 있는 방법대로 `mosquitto_sub` 을 테스트해보면 아래와 같이 오류가 발생합니다.

```
$ mosquitto_sub -h 127.0.0.1 -p 1883 -t topic
Error: Connection refused
```

검색해보면 위 문제는 mosquitto broker service 를 실행해야지만 사용가능한 것 같습니다. [^stackoverflow-52227571] 아래와 같이 하면 될 것 같습니다.

```
$ brew services start mosquitto -d
```  

### mosquitto_pub, mosquitto_sub 사용하기

참고 문헌과 같이 한 terminal 에서 mosquitto_sub 을 시작하고, 다른 terminal 에서 mosquitto_pub 을 시작하면 잘 작동하는 것을 확인할 수 있습니다. [^lemonheim-mosquitto]

```
$ mosquitto_sub -h 127.0.0.1 -p 1883 -t topic
```

```
$ mosquitto_pub -h 127.0.0.1 -p 1883 -t topic -m "test message"
```

아래는 테스트 결과입니다.
mosquitto_pub 으로 Hello, world 를 보내고 mosquitto_sub 에서 받음을 확인할 수 있습니다.

```
$ mosquitto_pub -h 127.0.0.1 -p 1883 -t topic -m "Hello, world"
```

```
xho95s-MacBook-Pro:~ kimminho$ mosquitto_sub -h 127.0.0.1 -p 1883 -t topic
Hello, world
```

### 참고 자료

[Eclipse Mosquitto™](https://mosquitto.org)

[MQTT.org](http://mqtt.org)

[test.mosquitto.org](http://test.mosquitto.org)

[^github-4527]: [Cannot link php71: /usr/local/sbin is not writable](https://github.com/Homebrew/homebrew-php/issues/4527)

[^taylormcgann]: [Difference Between bin and sbin](http://blog.taylormcgann.com/2014/04/11/difference-bin-sbin/) 이 글에는 bin 폴더와 sbin 폴더의 역할에 대한 설명이 잘 되어 있습니다.

[^apple-312330]: [ `brew link unbound` returns `/usr/local/sbin is not writable` error](https://apple.stackexchange.com/questions/312330/brew-link-unbound-returns-usr-local-sbin-is-not-writable-error)

[^github-3228]: [Can't chown /usr/local in High Sierra](https://github.com/Homebrew/brew/issues/3228)

[^chown]: 위 link 의 내용으로 볼 때, `chown` 은 `changing ownership` 의 약자인 것 같습니다. 정확한 정보가 필요합니다.

[^stackoverflow-46459152]: [can't chown /usr/local for homebrew in OSX 10.13 High Sierra](https://stackoverflow.com/questions/46459152/cant-chown-usr-local-for-homebrew-in-osx-10-13-high-sierra)

[^lemonheim-mosquitto]: [MQTT mosquitto 서버 Mac 설치/ 테스트](http://lemonheim.blogspot.com/2017/01/mqtt-mosquitto-mac.html)

[^stackoverflow-52227571]: [Unable to test Mosquitto Server on Mac](https://stackoverflow.com/questions/52227571/unable-to-test-mosquitto-server-on-mac)
