생각해 봤는데, 책의 내용이나 블로그 글을 요약하는 방식보다는 간단한 예제를 만들어 보면서 활용법을 설명하는 방식으로 정리하는 것이 좋을 것 같습니다. 

그리고 전체 내용 이전에 Git 이란 무엇이고, 왜 필요한지를 설명하는 것이 필요할 것 같습니다. Git 을 쓰면 왜 GitHub 를 사용하게 되는지, 그리고 소스를 관리하듯이 블로그를 관리하는 것이 결국 GitHub Pages 가 되는 것을 설명하면 좋을 것입니다. 구글이 왜 Tensorflow 소스를 GitHub 에 공개하는지, 애플이 왜 Swift 소스를 GitHub 에 공개하는지 이해할 수 있을 것입니다.

즉, Git 사용법과 Git 자체의 설명을 따로 분리하면 좋을 것입니다.

본 내용은 ProGit 번역본을 중심으로 하면서 그 외 여러 곳의 Git 관련 정보들을 모아서 정리한 것입니다. ProGit의 경우 온라인과 GitHub에 책을 공유해 놓았으며, 물론 한글로 번역된 자료도 공유되어 있습니다.[^ProGit]  [^progit2-ko] 

이 곳의 내용은 ProGit 내용 중에서 가장 기본이 되는 2장의 내용을 기초로 정리하였습니다.[^ProGit_Ch2]

### Git 설치

Linux에 Git을 설치할 때는 보통 패키지 관리 도구를 사용하여 설치합니다. 예를 들어 Ubuntu 같이 데비안 계열 리눅스라면 다음과 같이 `apt-get` 을 사용하면 됩니다.

```
$ sudo apt-get install git-all
```

맥은 Xcode를 설치하면 Git 이 같이 설치됩니다. 

### Git 저장소 만들기

#### 기존 프로젝트를 Git 저장소로 만드는 방법

기존 프로젝트를 Git으로 관리하고 싶으면, 해당 프로젝트의 디렉토리에서 `git init`을 실행합니다.

```
$ git init
```

위와 같이 하면 `.git`이라는 숨김 디렉토리를 만듭니다.

#### 다른 서버에 있는 저장소를 Clone하는 방법

다른 프로젝트에 참여하거나 그 프로젝트의 Git 저장소를 복사하고 싶으면, `git clone`을 실행한다. `git clone`을 실행하면 프로젝트 히스토리를 전부 받습니다.

```
$ git clone https://github.com/libgit2/libgit2

$ git clone https://github.com/libgit2/libgit2 mylibgit
```

위에서 첫번째 줄은 저장소의 데이터를 현재 디렉토리에 같은 이름의 디렉토리를 만들면서 clone하는 방법이며, 동일한 디렉토리로 두번째 줄은 저장소의 데이터를 다른 디렉토리에 저장할 경우입니다.

#### GitHub에서 알려주는 저장소 만드는 방법

**GitHub** 에 저장소를 만들고 나서 저장소를 들어가면, 아래와 같이 Git에 대한 기본 설명을 해주는데, 여기에 Git `init`부터 `push`까지의 설명이 사실상 되어 있습니다.[^GitHub]

```
$ echo "# GitTest" >> README.md

$ git init

$ git add README.md
$ git commit -m "first commit"

$ git remote add origin https://github.com/modulabs/GitTest.git
$ git push -u origin master
```

위에서 origin에 할당할 저장소는 이미 만들어져 있어야 합니다.

사실 개인이 혼자서 GitHub에 소스를 관리할 경우 따로 branch를 만들 이유가 없다면 위의 명령만으로도 모든 것을 할 수 있습니다. 

### 수정하고 저장소에 저장하기

파일의 라이프 사이클은 참고 자료를 확인합니다.[^ProGit_Ch2_2]

* Untracked
* Unmodified
* Modified
* Staged

staging area에 대한 정확한 이해가 필요할 것 같습니다. - 일단은 staged 파일들이 모여있는 곳이 staging area인 듯 합니다.

#### 파일 상태 확인하기

`git status` 명령으로 파일의 상태를 확인할 수 있다.

```
$ git status
```

새로 추가된 파일들은 Untracked 상태인데, 이런 파일들은 Tracked 상태가 되어야만 커밋할 수 있다.

아래와 같이 `git status -s` 명령을 사용하면 파일들의 상태를 간단한 형태로 보여준다.

```sh
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

**GitHub** 는 다양한 프로젝트에서 사용하는 `.gitignore` 예제를 관리하고 있으므로, 참고하면 좋다.[^GitHubIgnore]

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

`git rm` 명령으로 tracked 상태의 파일을 삭제한 후에, 커밋하면 된다. 파일이 staging area에 있는 것이 아니면 그냥 `rm` 명령으로는 삭제가 되지 않는다.

일단 `git rm` 명령을 실행하면 파일이 삭제되면서 staged 상태가 되며, 이후에 커밋을 하게 되면 파일은 실제로 삭제되면 Git에서 이 파일을 더 이상 추적하지 않는다.

수정한 파일이나 staging area에 있는 파일은 그냥 `git rm`으로는 삭제할 수 없고 `-f` 옵션으로 강제로 삭제해야 한다. (이부분은 나중에 실습해보자.)

staging area에서만 제거하고 워킹 디렉토리에 있는 파일을 남겨두려면 `--cached` 옵션을 사용한다.

```
$ git rm --cached README
```

위와 같이 하면 README 파일을 디스크에는 남겨두면서 Git에서 추적하지 않도록 할 수 있다. 이것은 `.gitignore` 파일에 추가하지 못한 파일이나 대용량 파일 등을 Git에 실수로 추가했을 때 유용하게 사용할 수 있다.[^gitignore_sample]

#### 파일 이름 변경하기

`git mv` 명령을 이용하여 파일 이름을 변경할 수 있다. 사실 이 명령은 파일을 이동하는 명령인데, 파일을 이동하면서 새로운 이름으로 변경해서 이동시킬 수 있기 때문에 사용하는 것 같다.

### 변경 내력 조회하기

#### 커밋 변경 내력 조회하기

`git log` 명령을 사용하여 작업 디렉토리 파일들의 변경 내력을 조회할 수 있다.

`-p` 옵션을 사용하면 각 커밋들 사이의 diff 결과를 볼 수 있다.

```
$ git log -p
```

`-2` 옵션을 사용하면 최근 두 개의 결과만 보여준다.

`--stat` 옵션을 사용하면 각 커밋의 통계 정보를 보여준다.

`--pretty` 옵션을 사용하면 변경 내력을 보여줄때 보여지는 형식을 선택할 수 있다 . `oneline, short, full, fuller` 및 `format` 등의 값을 줄 수 있다. (보다 자세한 사항은 다음에 붙여넣도록 하자.)

```
$ git log --pretty=oneline
```

### 원격 저장소

#### 원격 저장소 확인하기

`git remote` 명령을 사용한다.

`-v` 옵션을 주면 단축 이름과 URL을 함께 볼 수 있다.

```
$ git remote -v
```

#### 원격 저장소 추가히기

`git remote add [name] [url]` 명령을 사용하여 url 원격 저장소를 name 이라는 이름으로 추가한다.

#### 원격 저장소의 내용 가져오기

`git fetch [name]` 명령을 사용하면 현재 작업 디렉토리에는 없지만 원격 저장소에는 있는 데이터를 모두 가져온다. 그러면 원격 저장소의 모든 브랜치를 가져오므로 언제든지 merge 하거나 내용을 살펴볼 수 있다.

저장소를 clone 하면 자동으로 원격 저장소를 `origin`이라는 이름으로 추가한다.

`git fetch`는 원격 저장소의 데이터를 모두 가져오지만, 자동으로 merge 하지는 않는다. 그래서 fetch 이후에는 수동으로 merge를 해야 한다.

`git pull` 명령을 사용하면 원격 저장소 브랜치에서 데이터를 가져오면서 자동으로 지역 브랜치와 merge를 수행한다.

`git clone`의 경우 자동으로 지역의 master 브랜치가 원격 저장소의 master 브랜치를 추적하도록 한다.

#### 원격 저장소에 내용 전달하기

`git push [name] [branch]` 명령을 사용하면 해당 브랜치를 name으로 설정한  upstream 저장소에 push 한다.

```
$ git push origin master
```

위와 같이 하면 master 브랜치를 origin 서버에 push한다.

push는 다른 사람이 push한 후에는 할 수 없다. 먼저 다른 사람이 작업한 것을 가져와서 merge 한 후에 push를 할 수 있다.

#### submodule

submodule : Git 저장소 안에 다른 Git 저장소를 디렉토리로 분리해 넣는 것입니다. - 이부분은 나중에 좀 더 정리해서 추가할 예정입니다.

> submodule을 활용하면 한 branch에서 다른 branch로 바로 merge가 가능한 것 같습니다. [^stackoverflow-3672073]
> 
> ```
> git push self dev:master
> ```
> 
> 위와 같이 `:` 과 관련이 있는 것 같습니다. 

### 참고 자료

[^ProGit]: [Pro Git Book (한글판 v2.0)](https://git-scm.com/book/ko/v2/)

[^progit2-ko]: [progit2-ko](https://github.com/progit/progit2-ko)

[^ProGit_Ch2]: [Pro Git Book / 2.1 Git의 기초 - Git 저장소 만들기](https://git-scm.com/book/ko/v2/Git의-기초-Git-저장소-만들기)

[^GitHub]: [GitHub](https://github.com)

[^ProGit_Ch2_2]: [Pro Git Book / 2.2 Git의 기초 - 수정하고 저장소에 저장하기](https://git-scm.com/book/ko/v2/Git의-기초-수정하고-저장소에-저장하기)

[^GitHubIgnore]: [GitHub .ignore](https://github.com/github/gitignore)

[^gitignore_sample]: [gitignore로 tracking 제외할 수 없는 파일 제외하기](http://kyejusung.com/2016/06/git-gitignore로-tracking-제외할-수-없는-파일-제외하기/)

[^StackOverflow]: [Xcode and Git Source Control : “The working copy XXXXX failed to commit files”](http://stackoverflow.com/questions/14694662/xcode-and-git-source-control-the-working-copy-xxxxx-failed-to-commit-files)

[Xcode4 소스 버전 관리 기능](https://soulpark.wordpress.com/2012/08/23/xcode4_source_control_management/)

[누구나 쉽게 이해할 수 있는 Git 입문](https://backlogtool.com/git-guide/kr/)

[브랜치 통합하기](https://backlogtool.com/git-guide/kr/stepup/stepup1_4.html) : merge와 rebase에 대한 설명이 잘 나와있습니다.

[Git merge master into feature branch](http://stackoverflow.com/questions/16955980/git-merge-master-into-feature-branch) : rebase의 사용 방법에 대해서 잘 설명이 된 답변 글입니다.

[Get changes from master into branch in Git](http://stackoverflow.com/questions/5340724/get-changes-from-master-into-branch-in-git) : master에서 branch로의 merge 방법에 대해서 설명이 된 답글입니다. 

[^stackoverflow-3672073]: [How to merge the current branch into another branch](http://stackoverflow.com/questions/3672073/how-to-merge-the-current-branch-into-another-branch) : 답변 내용이 Submodules 과 관련이 있는 모양입니다. 
