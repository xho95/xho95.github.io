git push 를 하다보면 간간히 `-u` 옵션을 붙이는 경우가 있습니다. 이 `-u` 옵션은 `--set-upstream` 의 줄임 표현입니다. [^git-push]

이 옵션은 다음과 같은 의미가 있습니다. 

모든 브랜치 (branch) 가 최신이거나 푸시에 성공하면 업스트림 (upstream; tracking) 참조에 추가하여 인자 없이 `git pull` 이나 다른 명령을 사용할 수 있도록 합니다. [^git-pull] 더 많은 정보는 `git config` 에 있는 `branch.<name>.merge` 에 보면 있습니다. [^git-config]

위의 설명을 보면 최초의 경우에 아래와 같이 -u 옵션을 붙여주면 이후에 pull 받을 때 뒤에 다른 인자를 붙이지 않아도 되는 것 같습니다.

```
$ git push -u origin master

$ git pull		// 이러한 명령이 사용 가능해집니다.
```

IT World 의 기사 글에는 업스트림에 대해 "코드의 최초 창시자 혹은 최종 패치가 이루어지는 버전" 이라는 의미가 있다고 소개하고 있습니다. [^itworld-86157]

### 참고 자료

[^git-push]: [git push](https://git-scm.com/docs/git-push)

[^git-pull]: [git pull](https://git-scm.com/docs/git-pull)

[^git-config]: [git config](https://git-scm.com/docs/git-config)

[^itworld-86157]: [글로벌 칼럼 | 오픈소스 벤처기업이여, 제2의 레드햇이 되려 하지 말라](http://www.itworld.co.kr/news/86157)