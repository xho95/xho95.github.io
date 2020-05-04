`conda`와 `virtualenv`를 동시에 사용할 수 있는지에 대해서는 좀 더 알아봐야 할 것 같습니다.[^egloos]

Python을 위한 패키지들은 다음 곳들을 보면 구할 수 있습니다.[^activestate]  [^github]  [^pypi]

`anaconda`와 `virtualenv`의 충돌을 해결하는 방법에 대한 답변은 다음과 같습니다.[^stackoverflow_38221144]  [^stackoverflow_30308190]

위와 같은 자료가 있는 것을 볼 때, 같이 사용할 수는 있는 것 같습니다. 

[conda에서 파이썬 가상 환경 (virtual environments) 생성하기](http://jkstory-textcube.blogspot.kr/2016/02/conda-virtual-environments.html)라는 글을 보면 `conda`에서 `virtualenv`를 설치하려고 하면 "불안정하다"는 경고 메시지가 뜬다고 합니다. 

일단 물리적으로는 동시에 사용이 가능하지만, 가능하면 `Docker`나 `Virtual Machine`으로 구분해서 개발환경을 설정하는 것이 좋을 것 같습니다. 

### 패키지 검색하기

anaconda에 설치할 수 있는 패키지들은 아래와 같은 방법으로 검색이 가능합니다. 

```
$ anaconda search -t conda python-memcached
```

conda로도 검색이 가능하다고 하는데 아직 두가지 방식의 차이점을 모르겠습니다.

```
$ conda search python-memcached 
```

일단 경험상으로는 anaconda를 사용하는 경우가 더 좋은 결과가 나왔던 것 같습니다.

### 패키지 삭제하기

콘다를 이용하여  `root` 환경에 있는 `python-memcached` 패키지를 삭제하는 방법은 아래와 같습니다. 

```
$ conda remove --name root python-memcached
```

일단은 conda에서는 현재의 설치 환경 이름도 지정해줘야 삭제 가능한 것 같습니다. 

### 참고 자료

[^egloos]: [파이썬 간단한 가상환경 구축하기](http://egloos.zum.com/mataeoh/v/7096538)

[Anaconda 설치하기 - Python을 제대로 활용해보자](http://egloos.zum.com/mataeoh/v/7052271)

[How do I install Python packages in Anaconda?](https://www.quora.com/How-do-I-install-Python-packages-in-Anaconda)

[^activestate]: [Popular Python recipes](http://code.activestate.com/recipes/langs/python/)

[^github]: [Python](https://github.com/Python)

[^pypi]: [PyPI - the Python Package Index](https://pypi.python.org/pypi)

[Mac - virtualenv 설치, 가상환경 numpy, scipy, matplotlib, ipython notebook 설치](http://freeprog.tistory.com/59)

[파이썬 가상환경 설정하고 DJANGO 설치하기](http://www.hubsite.co.kr/archives/102)

[Python VirtualEnv](http://kwonnam.pe.kr/wiki/python/virtualenv)

[^stackoverflow_38221144]: [How to solve the issue of the conflict of anaconda and virtualenv](http://stackoverflow.com/questions/38221144/how-to-solve-the-issue-of-the-conflict-of-anaconda-and-virtualenv) 일단 나중을 위해서 링크를 연결해 둡니다.

[^stackoverflow_30308190]: [deactivate conflict in virtualenvwapper and anaconda](http://stackoverflow.com/questions/30308190/deactivate-conflict-in-virtualenvwapper-and-anaconda)

[PYTHON PACKAGES AND ENVIRONMENTS WITH CONDA](https://www.continuum.io/blog/developer-blog/python-packages-and-environments-conda)

[파이썬 설치](https://www.datascienceschool.net/view-notebook/5e52b7c4b5754f2585844c8d9b26cdb5/) : anaconda를 중심으로 파이썬을 설치하고 사용하는 방법을 설명해 둔 곳입니다.

[conda에서 파이썬 가상 환경 (virtual environments) 생성하기](http://jkstory-textcube.blogspot.kr/2016/02/conda-virtual-environments.html)
