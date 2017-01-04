### Ceres-Solver

Ceres-Solver를 설치하면 아래와 같은 메시지들이 나옵니다. 

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

그런데, 위의 메시지 중에서 Caveats 부분만 보면 아래와 같습니다. 

```
Python modules have been installed and Homebrew's site-packages is not
in your Python sys.path, so you will not be able to import the modules
this formula installed. If you plan to develop with these modules,
please run:
  mkdir -p /Users/xho95/.local/lib/python3.5/site-packages
  echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> /Users/xho95/.local/lib/python3.5/site-packages/homebrew.pth
```

즉, Caveats 모듈을 Python 개발에서 사용하려면 아래와 같이 설치된 경로를 Python에서 인식할 수 있도록 연결해줘야 하는 것 같습니다. 

```
$ mkdir -p /Users/xho95/.local/lib/python3.5/site-packages

$ echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> /Users/xho95/.local/lib/python3.5/site-packages/homebrew.pth
```

언젠가 기회가 되면 실습해보면 좋을 것 같습니다. 