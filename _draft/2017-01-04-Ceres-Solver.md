여기서는 [Ceres Solver](http://ceres-solver.org/index.html)에 대한 내용을 정리합니다. 

Ceres-Solver는 OpenCV에서 SfM을 할 때 필요한 것으로 정확하게는 아직 잘 모르겠지만, 이름만 봤을 때는 일종의 수치 계산을 해주는 듯한 인상을 줍니다. 나중에 차차 정리하도록 하겠습니다. 

### Install

설치는 공식 홈페이지의 [Installation](http://ceres-solver.org/installation.html#mac-os-x) 문서에서 Mac OS X 부분을 참고하면 됩니다.  

MacPorts와 Homebrew 두가지 방식으로 설치가 가능합니다.

```
$ brew install ceres-solver
```

위와 같이 Homebrew 명령을 이용하면 의존성을 파악해서 필요한 다른 패키지들도 같이 설치해 줍니다. 

> **설치 과정에서의 문제 해결**
> 
> brew를 이용한 설치 과정에서 아래와 같은 메시지가 나타나면서 설치가 안되는 경우가 있습니다. 
> 
> ```
> Error: The `brew link` step did not complete successfully
> The formula built, but is not symlinked into /usr/local
> Could not symlink share/.../...
> /usr/local/... is not writable.
> ```
> 
> 이것은 `/usr/local/` 폴더 권한을 조정해주면 되는데, 아래와 같이 하면 해결됩니다. 
> 
> ```
> $ sudo chown -R $(whoami) /usr/local
> ```
> 
> 보다 자세한 사항은 [Homebrew](../_draft/2016-10-03-Homebrew.md) 글을 참고하시기 바랍니다. (나중에 포스트로 옮기면 링크를 수정해야 합니다.) 

그런데 아래와 같이 `/usr/local/...`에 설치가 되는데 따라서 따로 CMake로 빌드하고 그런 것들은 아닌 것 같습니다. 

```
==> Installing ceres-solver from homebrew/science
==> Installing dependencies for homebrew/science/ceres-solver: glog, eigen, tbb, metis, suite-sparse
==> Installing homebrew/science/ceres-solver dependency: glog
==> Downloading https://homebrew.bintray.com/bottles/glog-0.3.4_1.sierra.bottle.
######################################################################## 100.0%
==> Pouring glog-0.3.4_1.sierra.bottle.tar.gz
🍺  /usr/local/Cellar/glog/0.3.4_1: 25 files, 428.9K
==> Installing homebrew/science/ceres-solver dependency: eigen
==> Downloading https://homebrew.bintray.com/bottles/eigen-3.3.1.sierra.bottle.t
######################################################################## 100.0%
==> Pouring eigen-3.3.1.sierra.bottle.tar.gz
🍺  /usr/local/Cellar/eigen/3.3.1: 486 files, 6.4M
==> Installing homebrew/science/ceres-solver dependency: tbb
==> Downloading https://homebrew.bintray.com/bottles/tbb-4.4-20161128.sierra.bot
######################################################################## 100.0%
==> Pouring tbb-4.4-20161128.sierra.bottle.tar.gz
==> Caveats
Python modules have been installed and Homebrew's site-packages is not
in your Python sys.path, so you will not be able to import the modules
this formula installed. If you plan to develop with these modules,
please run:
  mkdir -p /Users/xho95/.local/lib/python3.5/site-packages
  echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> /Users/xho95/.local/lib/python3.5/site-packages/homebrew.pth
==> Summary
🍺  /usr/local/Cellar/tbb/4.4-20161128: 119 files, 1.9M
==> Installing homebrew/science/ceres-solver dependency: metis
==> Downloading https://homebrew.bintray.com/bottles-science/metis-5.1.0.sierra.
######################################################################## 100.0%
==> Pouring metis-5.1.0.sierra.bottle.2.tar.gz
🍺  /usr/local/Cellar/metis/5.1.0: 19 files, 12.2M
==> Installing homebrew/science/ceres-solver dependency: suite-sparse
==> Downloading https://homebrew.bintray.com/bottles-science/suite-sparse-4.5.3.
######################################################################## 100.0%
==> Pouring suite-sparse-4.5.3.sierra.bottle.tar.gz
🍺  /usr/local/Cellar/suite-sparse/4.5.3: 345 files, 17.2M
==> Installing homebrew/science/ceres-solver 
==> Downloading https://homebrew.bintray.com/bottles-science/ceres-solver-1.12.0
######################################################################## 100.0%
==> Pouring ceres-solver-1.12.0.sierra.bottle.tar.gz
🍺  /usr/local/Cellar/ceres-solver/1.12.0: 460 files, 15.8M
```

사용법 등은 좀 더 공부해서 정리하도록 할 예정입니다. 

### 참고 자료

[^ceres-solver]: [Ceres Solver](http://ceres-solver.org/index.html) : Ceres Solver 공식 문서 페이지입니다. 

[^installation]: [Installation](http://ceres-solver.org/installation.html#mac-os-x)