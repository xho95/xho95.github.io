리눅스에서 Swift 로 파일을 여는 방법에 대한 내용입니다.

[Swift 2.2 Linux - open file for reading](http://stackoverflow.com/questions/34296614/swift-2-2-linux-open-file-for-reading) 글에 다음과 같은 코드가 있습니다. [^stackoverflow-34296614]

https://github.com/Zewo/SQL (???)

```

import Glibc

let path = "./sample.txt"
let BUFSIZE = 1024

let fp = fopen(path, "r")

if fp != nil {
  var buf = [CChar](count:BUFSIZE, repeatedValue:CChar(0))
  
  while fgets(&buf, Int32(BUFSIZE), fp) != nil {
    print(String.fromCString(buf)!, terminator:"")
  }
}
```

위에서 Glibc 를 사용함을 알 수 있습니다. Glibc 에 대해서는 [GNU C Library](https://en.wikipedia.org/wiki/GNU_C_Library) 또는 [GNU C 라이브러리](https://ko.wikipedia.org/wiki/GNU_C_라이브러리) 글을 참고하시기 바랍니다. [^wikipedia-gnu-c] [^wikipedia-gnu-c-ko]

다만 위의 코드는 조금 예전 방식이라 에라가 꽤 나는 것 같습니다. 

`error: argument 'repeated Value' must precede argument 'count'`

> 참고로 Swift 3.0 부터 List 의 초기화 방식이 바뀐 것 같습니다. [Linux Swift 2.2: compiler error during creating Array with a default value](https://forums.developer.apple.com/thread/45218) 글을 참고하시기 바랍니다. [^forums-45218]

`error: 'fromCString' is unavailable: Pease use String.init?(validatingUTF8:) instead. ...`

> [Swift 2 to 3 Migration String.fromCString](http://stackoverflow.com/questions/39745108/swift-2-to-3-migration-string-fromcstring) 글을 참고합니다. [^stackoverflow-39745108]


위의 코드를 참고하여 **/proc/cpuinfo** 파일을 여는 방법은 다음과 같습니다.

```
import Glibc

let path = "/proc/cpuinfo"
let BUFSIZE = 1024

let fp = fopen(path, "r")

if fp != nil {
  var buf = [CChar](repeating: CChar(0), count:BUFSIZE)
  
  while fgets(&buf, Int32(BUFSIZE), fp) != nil {
    print(String(cString: buf), terminator:"")
  }
}
```

원래의 코드는 C 언어로 작성된 것인데 [How to get CPU info in C on Linux, such as number of cores?](http://stackoverflow.com/questions/9629850/how-to-get-cpu-info-in-c-on-linux-such-as-number-of-cores) 글에서 참고했습니다. [^stackoverflow-9629850]

### 참고 자료

[^stackoverflow-34296614]: [Swift 2.2 Linux - open file for reading](http://stackoverflow.com/questions/34296614/swift-2-2-linux-open-file-for-reading)

[^wikipedia-gnu-c]: [GNU C Library](https://en.wikipedia.org/wiki/GNU_C_Library)

[^wikipedia-gnu-c-ko]: [GNU C 라이브러리](https://ko.wikipedia.org/wiki/GNU_C_라이브러리) : 위의 페이지의 한글 버전입니다. 

[^forums-45218]: [Linux Swift 2.2: compiler error during creating Array with a default value](https://forums.developer.apple.com/thread/45218) : Swift 3.0 에서 List 의 호출 방식이 \[\](count:repeatedValue:) 에서 \[\](repeating:count:) 으로 바뀐 것 같습니다. 이 부분은 init 으로 고쳐야할지 정해야 합니다. 

[^stackoverflow-9629850]: [How to get CPU info in C on Linux, such as number of cores?](http://stackoverflow.com/questions/9629850/how-to-get-cpu-info-in-c-on-linux-such-as-number-of-cores)

[^stackoverflow-39745108]: [Swift 2 to 3 Migration String.fromCString](http://stackoverflow.com/questions/39745108/swift-2-to-3-migration-string-fromcstring)