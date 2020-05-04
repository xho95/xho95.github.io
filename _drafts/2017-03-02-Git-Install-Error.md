```
$ sudo apt-get install git-all
```

위와 같이 하면 `git-daemon-run` 에러가 발생하는 것 같습니다. 

```
E: Sub-process /usr/bin/dgkg returned an error code (1)
```

해결 방법은 일종의 재 설치를 하는 것 같습니다. [^askubuntu-765565] `purge` 명령 또는 옵션에 대해서 좀 알아봐야 할 것 같습니다. 의미는 정화한다는 것인데 삭제와는 뭐가 다른지 확인해 봅니다.

```
$ sudo apt-get purge runit
$ sudo apt-get purge git-all
$ sudo apt-get purge git
$ sudo apt-get autoremove
$ sudo apt update
$ sudo apt install git
```

### 참고 자료

[^askubuntu-765565]: [How to fix processing with runit and git-daemon-run [duplicate]](http://askubuntu.com/questions/765565/how-to-fix-processing-with-runit-and-git-daemon-run)