macOS 와 리눅스의 기본 명령인 `ls` 명령에 대해서 정리합니다. [^linuxcommand-ls]

### 페이지별로 출력하기

[리눅스 출력 결과, 화면에 한 페이지씩 스크롤, LINUX UNIX Paging](http://mwultong.blogspot.com/2006/11/linux-unix-paging.html) 글을 참고합니다. [^mwultong-paging]

아래와 같이 파이핑 (piping) 을 사용해서 `less` 명령과 같이 실행합니다. [^wikipedia-less]

```
$ ls -al | less
``` 

상하 화살표키를 누르면 아래위로 스크롤이 됩니다. `PageUp`,  `PageDown` 키를 누르면 한 페이지씩 상하로 이동합니다.

유닉스에는 less 명령이 없을 수도 있는데 이때는 more 명령을 대신 사용하면 됩니다. 다만 more 명령은, less 와 달리 화면을 아래위로 이동하며 볼 수는 없기에 불편합니다. 그냥 Enter키를 칠 때마다 한줄씩 아래로 내려가고, 스페이스키를 누르면 한 페이지씩 내려갑니다.

키보드의 `q` 키를 누르면 다시 프롬프트로 빠져 나옵니다.

### 참고 자료

[^mwultong-paging]: [리눅스 출력 결과, 화면에 한 페이지씩 스크롤, LINUX UNIX Paging](http://mwultong.blogspot.com/2006/11/linux-unix-paging.html)

[^linuxcommand-ls]: LinuxCommand.org 사이트에는 [ls](http://linuxcommand.org/man_pages/ls1.html) 글에 `ls` 명령에 대한 매뉴얼을 정리했습니다.

[^wikipedia-less]: 위키피디아의 [less (Unix)](https://en.wikipedia.org/wiki/Less_(Unix)) 글을 보면 원래 less 는 하나의 프로그램인 것 같습니다.
