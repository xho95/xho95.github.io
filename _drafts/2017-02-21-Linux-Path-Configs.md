일단 맥 설정 파일에 내용을 정리하고 다른 부분만 이곳에 정리합니다.

리눅스의 경우 맥과는 조금 다릅니다. 일단 **/etc/paths** 파일이 없는 것 같습니다.

#### ~/.profile 파일 사용하기

위와같은 문제를 해결하는 한가지 방법은 추가할 경로를 **~/.profile** 파일에 추가하는 것입니다. [^askubuntu-627346]

우선 아래와 같이 명령을 실행해서 현재 **~/.profile** 파일이 어떻게 되어 있는지 살펴봅니다.

```
$ cat ~/.profile
```

**.profile** 에 이미 PATH 변수가 있고 값이 할당되어 있다면, 아마 아래와 유사할 것입니다.

```
...
PATH="$HOME/bin:...:$PATH"
```

이제 PATH 변수에 원하는 경로를 추가합니다. **.profile** 을 편집하는 것은 원하는 편집기로 하면 되는데 리눅스에서는 보통 gedit 를 많이 사용하는 것 같습니다. 

다음과 같이 해서 편집하고 저장합니다. 일단 여기서는 앞서 봤던 Swift 경로를 추가하는 것으로 가정했습니다. 

> 물론 `/path/to` 부분은 실제 Swift 가 있는 경로여야 합니다. 저의 경우는 다운 받은 swift 를 홈 디렉토리에 해제해서 `$Home/swift/usr/bin` 입니다. 이 부분은 사용자마다 다르므로 자신의 환경에 맞게 고쳐주면 됩니다. 

```
$ sudo gedit ~/.profile

...
PATH="$HOME/bin:...:/path/to/usr/bin:$PATH"
``` 

**.profile** 파일은 로그인 할 때와 다른 쉘에서 **PATH** 변수를 사용할 수 있게 할 때 사용합니다.

#### ~/.profile 파일을 수정하는 다른 방법

위의 과정은 아래와 같은 방법으로도 똑같이 수행할 수 있습니다.

```
$ echo 'export PATH=$PATH:/path/to/usr/bin' >> ~/.profile
```

이렇게 하면 `/path/to/usr/bin` 경로를 **~/.profile** 파일의 **PATH** 변수에 추가합니다.

이것은 `export` 명령은 PATH 환경 변수를 수정하는 역할을 하고, `echo ... >> ...` 명령은 앞 부분의 내용을 `>>` 로 출력해주는 역할을 합니다. [^crasy-62] 즉 여기서는 `'...'` 부분의 내용이 **~/.profile** 끝에 추가됩니다.

#### ~/.bashrc 파일 사용하기

**~/.profile** 파일 외에도 **~/.bashrc** 파일에 추가해서 경로를 고정으로 추가할 수 있습니다.

방법은 아래와 같습니다.

```
$ echo 'export PATH=$PATH:/path/to/usr/bin' >> ~/.bashrc
```

`export` 및 `echo` 명령은 위에서 설명한 것과 같습니다.

**~/.profile** 과 **~/.bashrc** 파일의 차이에 대해서는 따로 내용을 추가할 예정입니다.

### 참고 자료

[^askubuntu-627346]: [How How to set path in Ubuntu](http://askubuntu.com/questions/627346/how-how-to-set-path-in-ubuntu)

[^swift-download]: [Download Swift](https://swift.org/download/)

[^crasy-62]: [리눅스 명령어: export, echo 명령어 사용하기](http://crasy.tistory.com/62)
