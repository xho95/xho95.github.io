## Git 사용법

본 내용은 ProGit 번역본을 기준으로, 여러 곳의 정보들을 모아서 정리한 것입니다.[^ProGit] ProGit 내용은 전체중에서 가장 기본이 되는 2장의 내용을 참고하였습니다.[^ProGit_Ch2]


### Git 저장소 만들기

#### 기존 프로젝트를 Git 저장소로 만드는 방법

기존 프로젝트를 Git으로 관리하고 싶으면, 해당 프로젝트의 디렉토리에서 `git init`을 실행한다.

```
$ git init
```

위와 같이 하면 `.git`이라는 숨김 디렉토리를 만든다.

#### 다른 서버에 있는 저장소를 Clone하는 방법

다른 프로젝트에 참여하거나 그 프로젝트의 Git 저장소를 복사하고 싶으면, `git clone`을 실행한다. `git clone`을 실행하면 프로젝트 히스토리를 전부 받는다.

```
$ git clone https://github.com/libgit2/libgit2

$ git clone https://github.com/libgit2/libgit2 mylibgit
```

위에서 첫번째 줄은 저장소의 데이터를 현재 디렉토리에 같은 이름의 디렉토리를 만들면서 clone하는 방법이며, 동일한 디렉토리로 두번째 줄은 저장소의 데이터를 다른 디렉토리에 저장할 경우이다.

#### GitHub에서 알려주는 저장소 만드는 방법

**GitHub** 에 저장소를 만들고 나서 저장소를 들어가면, 아래와 같이 기본 설명을 해주는데, 여기에 Git `init`부터 `push`까지의 설명이 사실상 되어 있다.[^GitHub] 


```
$ echo "# GitTest" >> README.md

$ git init

$ git add README.md
$ git commit -m "first commit"

$ git remote add origin https://github.com/modulabs/GitTest.git
$ git push -u origin master
```

위에서 origin에 할당할 저장소는 이미 만들어져 있어야 한다. 나중에 터미널에서 직접 저장소를 만드는 방법을 알아보자. 

### 수정하고 저장소에 저장하기

파일의 라이프 사이클은 참고 자료를 확인한다.[^ProGit_Ch2_2]

* Untracked
* Unmodified
* Modified
* Staged

#### 파일 상태 확인하기

`git status` 명령으로 파일의 상태를 확인할 수 있다.
```
$ git status
```

새로 추가된 파일들은 Untracked 상태인데, 이런 파일들은 Tracked 상태가 되어야만 커밋할 수 있다.

아래와 같이 `git status -s` 명령을 사용하면 파일들의 상태를 간단한 형태로 보여준다.
```bash
$ git status -s

$ git status --short
```

#### 파일을 추가하기

`git add` 명령으로 파일을 Tracked 상태 또는 Staged 상태로 추가할 수 있다.

```
$ git add .
```

`git add` 명령은 해당 파일이 Tracked 상태가 되는데, 이중에서도 커밋이 가능한 Staged 상태로 만든다. add는 프로젝트에 파일을 추가한다는 의미보다는 다음 커밋에 파일을 추가한다고 이해하는 것이 좋다.[^ProGit_Ch2_2]

#### 파일 무시하기

무시하고 싶은 파일들은 `.gitignore` 파일에 파일 패턴을 적으면 된다.

```
$ cat .gitignore
*.[oa]
*~
```
`.gitignore` 파일은 표준 Glob 패턴을 사용한다. Glob 패턴은 정규표현식을 단순하게 만든 것으로 이해하면 된다.

**GitHub**는 다양한 프로젝트에서 사용하는 `.gitignore` 예제를 관리하고 있으므로, 참고하면 좋다.[^GitHubIgnore]

#### 파일 변경 내용을 보기

`git diff` 명령을 사용하여 파일에서 어떤 내용이 변경됐는지를 살펴볼 수 있다. 

```
$ git diff
```

`git diff` 명령은 수정했지만 아직 staged 상태가 아닌 파일을 비교해 볼 수 있다. 이 명령은 워킹 디렉토리에 있는 것과 staging area에 있는 것을 비교한다.

커밋하려고 staging Area에 넣은 파일에서 변경된 부분을 보고 싶으면 `git diff --cached` 옵션을 사용하면 된다. 

```
$ git diff --cached

$ git diff --staged
```

위에서와 같이 `git diff --staged`도 같은 역할을 하는데, `git diff --cached`와 `git diff --staged`의 차이는 무엇인지 아직 잘 모르겠다.

```
$ git difftool --tool-help
```

위의 명령을 사용해서 사용가능한 외부 Diff 도구를 선택해서 쓸 수 있다.

#### 변경 사항 커밋하기

`git commit` 명령을 사용하여 커밋을 수행한다.

```
$ git commit
```

`git commit`은 에디터를 실행하면서 사용자가 커밋 메시지를 입력하게 한다. 명령과 동시에 메시지를 넣어서 커밋하고 싶다면, `git commit -m` 명령을 사용한다.

```
$ git commit -m "my message"
```

#### Staging Area 생략하기

`git commit` 실행할 때, `-a` 옵션을 추가하면 된다.

#### 파일 삭제하기

`git rm` 명령으로 tracked 상태의 파일을 삭제한 후에, 커밋하면 된다.

### Git 명령어

#### Git 기본 명령어들
 
터미널에서 `git --help`를 입력하면 기본 사용법이 나오는데, 이 때 기본 명령어들에 대한 간단한 설명들이 나온다. 

```
$ git --help
```

#### 작업 공간 시작하기

* `clone` : 원격 저장소를 지역 디렉토리에 복제한다.
* `init` : 비어있는 Git 저장소를 만들거나 기존에 있던 것을 초기화한다.

> `git help tutorial`의 결과도 살펴볼 필요가 있습니다.

#### 현재의 변경에서 작업하기

* `add` : 파일 (변경) 내용을 인덱스에 추가합니다.
* `mv` : 파일, 디렉토리, 또는 (연결)링크를 옮기거나 이름을 변경합니다.
* `reset` : 현재 **HEAD** 를 특정한 상태로 재설정합니다.
* `rm` : 파일들을 작업 트리와 인덱스에서 제거합니다.

> `git help everyday`의 결과도 살펴볼 필요가 있습니다.

#### 변경 내력과 상태를 검사하기

* `bisect` : 버그를 알리는 커밋을 찾기 위해 이진 트리를 사용합니다.
* `grep` : 패턴과 들어맞는 라인들을 출력합니다.
* `log` : 커밋 로그들을 보여줍니다.
* `show` : 다양한 타입의 객체들을 보여줍니다.
* `status` : 작업 트리의 상태를 보여줍니다.

> `git help revisions`의 결과도 살펴볼 필요가 있습니다.

#### 변경 내력을 키우고, 표시하고, 비틀기

* `branch` : 브랜치들을 나열하고, 만들고, 또는 지웁니다.
* `checkout` : 브랜치들을 바꾸거나 작업 트리 파일들을 재저장합니다.
* `commit` : 변경 사항들을 저장소에 기록합니다.
* `diff` : 커밋들 또는 커밋과 작업 트리 사이의 변경 사항을 보여줍니다.
* `merge` : 두 개 또는 다수의 개발 변경 내력을 서로 합칩니다.
* `rebase` : Forward-port local commits to the updated upstream head (아직 뭐라고 번역해야할지 모르겠습니다. ㅜㅜ)
* `tag` : GPG로 표기된 태그 객체를 만들고, 나열하고, 지우고, 또는 확인합니다.

#### collaborate

* `fetch` : 다른 저장소에서 객체들과 참조들을 다운로드 합니다.
* `pull` : 다른 저장소나 브랜치에서 fetch를 하고 취합합니다.
* `push` : 원격 참조들을 관련된 객체들을 가지고서 업데이트 합니다.

> `git help workflows`의 결과도 살펴볼 필요가 있습니다.

### 참고 자료

[^ProGit]: [Pro Git Book (한글판 v2.0)](https://git-scm.com/book/ko/v2/)

[^ProGit_Ch2]: [2.1 Git의 기초 - Git 저장소 만들기](https://git-scm.com/book/ko/v2/Git의-기초-Git-저장소-만들기)

[^ProGit_Ch2_2]: [2.2 Git의 기초 - 수정하고 저장소에 저장하기](https://git-scm.com/book/ko/v2/Git의-기초-수정하고-저장소에-저장하기)
[^GitHub]: [GitHub](https://github.com)

[누구나 쉽게 이해할 수 있는 Git 입문](https://backlogtool.com/git-guide/kr/)

[^GitHubIgnore]: [GitHub .ignore](https://github.com/github/gitignore)
