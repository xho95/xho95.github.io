## Git 사용법

* 본 내용은 ProGit 번역본을 기준으로, 여러 곳의 정보들을 모아서 정리한 것입니다.[^ProGit] ProGit 내용은 전체중에서 가장 기본이 되는 2장의 내용을 참고하였습니다.[^ProGit_Ch2]


### Git 저장소 만들기

#### 기존 프로젝트를 Git 저장소로 만드는 방법

* 기존 프로젝트를 Git으로 관리하고 싶으면, 해당 프로젝트의 디렉토리에서 `git init`을 실행한다.

```
git init
```

* 위와 같이 하면 `.git`이라는 숨김 디렉토리를 만든다.

#### 다른 서버에 있는 저장소를 Clone하는 방법

* 다른 프로젝트에 참여하거나 그 프로젝트의 Git 저장소를 복사하고 싶으면, `git clone`을 실행한다. `git clone`을 실행하면 프로젝트 히스토리를 전부 받는다.

```
git clone https://github.com
```


#### GitHub에서 알려주는 저장소 만드는 방법

* **GitHub** 에 저장소를 만들고 나서 저장소를 들어가면, 아래와 같이 기본 설명을 해주는데, 여기에 Git `init`부터 `push`까지의 설명이 사실상 되어 있다.[^GitHub] 


```
echo "# GitTest" >> README.md

git init

git add README.md
git commit -m "first commit"

git remote add origin https://github.com/modulabs/GitTest.git
git push -u origin master
```

### Git 명령어

#### Git 기본 명령어들
 
* 터미널에서 `git --help`를 입력하면 기본 사용법이 나오는데, 이 때 기본 명령어들에 대한 간단한 설명들이 나온다. 

```
git --help
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

* [^ProGit]: [Pro Git Book (한글판 v2.0)](https://git-scm.com/book/ko/v2/)
* [^ProGit_Ch2]: [2.1 Git의 기초 - Git 저장소 만들기](https://git-scm.com/book/ko/v2/Git의-기초-Git-저장소-만들기)
* [^GitHub]: [GitHub](https://github.com)
* [누구나 쉽게 이해할 수 있는 Git 입문](https://backlogtool.com/git-guide/kr/)
