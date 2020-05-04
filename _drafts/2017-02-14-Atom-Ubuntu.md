[Djangogo 3. 우분투에 Atom 설치하기](http://djangogo.tistory.com/entry/Djangogo-3-우분투에-Atom-설치하기) 라는 글에 따르면 우분투 16.04 에서는 브라우저를 통한 설치는 안된다고 합니다만 지금 현재는 가능은 한 것 같습니다. 

다만, 설치된 실행 파일이 어디에 있는지는 모르겠습니다.

> 참고로 다운받을 때 우분투는 *.deb 파일을 받도록 합니다.

아톰 편집기로 C++ 을 개발하려면 [gpp-compiler](https://atom.io/packages/gpp-compiler) 글을 참고합니다.

#### Atom Editor

[gpp-compiler](https://atom.io/packages/gpp-compiler) 패키지를 설치하면 gcc 를 사용할 수 있는 것 같습니다.

아래와 같이 설명이 되어 있습니다. 

This Atom package allows you to compile and run C++ and C within the editor.

To compile C or C++, press **F5** or right click the file in tree view and click **Compile and Run**.

To compile C or C++ and attach the GNU Debugger, press **F6** or right click the file in tree view and click **Compile and Debug**.

**F5** 와 **F6** 키로 컴파일과 디버깅을 할 수 있도록 하고 있습니다. 


#### C++ 

우분투에서 아래와 같은 명령으로 gcc 가 설치되어 있는지 확인할 수 있습니다. 

```
$ which gcc g++
```

결과로 아래와 같이 나타나면 gcc가 설치되어 있는 것입니다. 

```
/usr/bin/gcc
/usr/bin/g++
```

