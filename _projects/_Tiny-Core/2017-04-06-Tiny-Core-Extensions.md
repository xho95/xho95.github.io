### 개발 환경 구축

#### 툴체인 설치하기

여러가지 글이 있지만 [Installing GCC extension ?](http://forum.tinycorelinux.net/index.php?topic=8950.0) 글에 설명된 명령을 따르는 것이 가장 편합니다. [^forum-8950]

```
$ tce-load -wi compiletc
```

`compiletc` 는 메타 확장 (meta extension) 으로 C 및 C++ 앱을 개발하는데 필요한 모든 도구를 담고 있다고 합니다. 위의 명령을 실행하면 알아서 의존 파일들을 검사해서, `gcc` 등을 설치합니다.

`tce-load` 명령에 대해서는 [tce-load](http://wiki.tinycorelinux.net/wiki:tce-load) 글을 참고합니다. [^wiki-tce-load]

#### gcc 빌드하기 

[LINUX: gcc 컴파일 옵션](http://egloos.zum.com/sunnmoon/v/1825047) 에 따르면 `-I` 옵션을 사용하면 되는 것 같습니다. [^egloos-1825047] 환경 설정에서 항상 하도록 하는 방법이 있을 것입니다.

`-I` 옵션은 컴파일러가 헤더파일을 탐색할 디렉토리를 지정하는 옵션이라고 합니다.

그리고 C++ 을 컴파일 하려면 `gcc` 가 아니라 `g++` 을 사용해야 합니다. [^stackoverflow-28236870]

#### 라이브러리

[boost](http://forum.tinycorelinux.net/index.php?topic=6298.0) 
[^forum-6298]

### 참고 자료

[^forum-8950]: [Installing GCC extension ?](http://forum.tinycorelinux.net/index.php?topic=8950.0)

[^wiki-tce-load]: [tce-load](http://wiki.tinycorelinux.net/wiki:tce-load)

[^egloos-1825047]: [LINUX: gcc 컴파일 옵션](http://egloos.zum.com/sunnmoon/v/1825047)

[^stackoverflow-28236870]: [undefined reference to 'std::cout'](http://stackoverflow.com/questions/28236870/undefined-reference-to-stdcout)

[^forum-6298]: [boost](http://forum.tinycorelinux.net/index.php?topic=6298.0)

[Creating an Extension](http://wiki.tinycorelinux.net/wiki:creating_extensions)

[Building your own TCL Extension](https://github.com/puppetlabs/Razor-Microkernel/wiki/Building-your-own-TCL-Extension)

[How do I update my extensions?](http://tinycorelinux.net/faq.html#update)

[Making TCZ extension for TinyCore MicroCore Linux](https://www.youtube.com/watch?v=yRm-YRuLFio)

[LLVM/Clang for Tiny Core 5.4](http://forum.tinycorelinux.net/index.php?topic=18569.0)

[how to compile, create and submit Tiny Core tcz extensions...](http://forum.tinycorelinux.net/index.php?topic=18682.0) : 좋은 내용인 것 같지만 글이 너무 깁니다.
