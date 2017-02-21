리눅스에서 `grep` 은 파일에서 특정한 문자열 패턴을 찾는 명령어입니다. 즉 `grep` 을 사용하면 해당 문자열이 들어있는 파일을 찾아서 문자열이 있는 행을 화면에 출력해 줍니다. [^geundi-113]

터미널에서 `$ man grep` 을 입력해서 매뉴얼을 보면 더 많은 정보를 얻을 수 있습니다. 터미널에서 보기가 불편하다면 [grep](http://linuxcommand.org/man_pages/grep1.html) 과 같이 브라우저에서 볼 수 있게 정리한 페이지도 있습니다. [^linuxcommand-grep1]

### 사용 예시

많은 경우에 `grep` 명령은 단독으로 사용되기 보다는 다른 명령과 같이 사용됩니다. 아래에 한가지 예를 나타내었습니다. 

```
$ netstat -nap | grep LISTEN
```

위의 명령은 리눅스의 포트 중에서 현재 **LISTEN** 상태인 포트들을 보여주는 명령입니다. 

원래 `$ netstat -nap` 명령은 현재 열려있는 포트를 확인하는 방법인데, `grep` 명령을 사용해서 열려있는 포트 중에서 **LISTEN** 이라는 문자열을 가진 것들만 따로 뽑도록 한 것입니다. 즉, 여기서는 `grep` 명령이 일종의 필터 역할을 한다고 볼 수 있습니다.  

### SED

grep 과 유사한 SED 명령에 대해서도 알아봅니다. [^linuxstory1-sed]
 
### 참고 자료

[^geundi-113]: [리눅스 grep 명령어](http://geundi.tistory.com/113)

[^linuxcommand-grep1]: [grep](http://linuxcommand.org/man_pages/grep1.html) 

[^linuxstory1-sed]: [SED 명령어 사용법](http://linuxstory1.tistory.com/entry/SED-명령어-사용법)

