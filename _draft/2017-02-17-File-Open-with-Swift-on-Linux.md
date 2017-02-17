리눅스에서 Swift 로 파일을 여는 방법에 대한 내용입니다.

[Swift 2.2 Linux - open file for reading](http://stackoverflow.com/questions/34296614/swift-2-2-linux-open-file-for-reading) 글에 다음과 같은 코드가 있습니다. [^stackoverflow-34296614]

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

위의 코드를 참고하여 **/proc/cpuinfo** 파일을 여는 방법은 다음과 같습니다.

원래의 코드는 C 언어로 작성된 것인데 [How to get CPU info in C on Linux, such as number of cores?](http://stackoverflow.com/questions/9629850/how-to-get-cpu-info-in-c-on-linux-such-as-number-of-cores) 글에서 참고했습니다. [^stackoverflow-9629850]

### 참고 자료

[^stackoverflow-34296614]: [Swift 2.2 Linux - open file for reading](http://stackoverflow.com/questions/34296614/swift-2-2-linux-open-file-for-reading)

[^wikipedia-gnu-c]: [GNU C Library](https://en.wikipedia.org/wiki/GNU_C_Library)

[^wikipedia-gnu-c-ko]: [GNU C 라이브러리](https://ko.wikipedia.org/wiki/GNU_C_라이브러리) : 위의 페이지의 한글 버전입니다. 

[^stackoverflow-9629850]: [How to get CPU info in C on Linux, such as number of cores?](http://stackoverflow.com/questions/9629850/how-to-get-cpu-info-in-c-on-linux-such-as-number-of-cores)