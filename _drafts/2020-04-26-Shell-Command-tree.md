
### `tree` 설치하기

맥에서 `tree` command 는 Homebrew  로 설치할 수 있습니다. 맥에 아직 Homebrew 가 설치되어 있지 않다면 설치 후 진행합니다.

```sh
$ brew install tree
```

#### `tree`

맥에는 따로 `tree` 명령어가 없지만, **Homebrew** 를 이용해서 설치한 후에 사용할 수 있습니다. 이에 대한 내용은 참고 자료에 잘 나와 있습니다.[^eunguru]

`tree` 명령을 사용해서 현재 위치를 기준으로 1 단계 까지만 보이게 하려면 다음과 같이 하면 됩니다.[^michaelsoolee]

```sh
$ tree ./ -L 1
```

마찬가지로 2단계 까지만 보이도록 하려면 아래와 같이 하면 됩니다.

```sh
$ tree ./ -L 2
```

루트 디렉토리를 기준으로 단계를 보이도록 하려면 아래와 같이 합니다.

```sh
$ tree -L 1 --dirsfirst
```

### 참고 자료

[^homebrew]: 맥에서 Homebrew 를 설치하는 방법은 [Homebrew](https://brew.sh) 홈페이지에서 잘 설명하고 있습니다.

[^eunguru]: [Mac OS X tree 명령어 설치, 실행](http://eunguru.tistory.com/150)

[^michaelsoolee]: [Tree command line tool](https://michaelsoolee.com/tree-tool/)
