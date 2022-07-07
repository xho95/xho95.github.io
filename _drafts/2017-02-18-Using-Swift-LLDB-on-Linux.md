여기서는 리눅스에서 LLDB 를 사용하는 방법을 알아봅니다. 말은 복잡해 어려워 보이지만  실제로는 터미널에서 디버거를 실행하는 단순한 작업입니다.

먼저 리눅스에 Swift 툴체인이 설치되어 있다고 가정합니다. Swift 툴체인을 설치하기 위해서는 다른 글을 보도록 합니다.

### LLDB 디버거 사용하기

LLDB 디버거를 사용하면 Swift 프로그램을 한줄 한줄 실행하거나, 중지점을 설정하고, 프로그램 상태를 조사하고 변경할 수 있습니다.

예를 들어, 아래와 같이 `factorial(n:)` 함수가 있을 때, 함수 호출 결과를 프린트합니다:

```
func factorial(n: Int) -> Int {
    if n <= 1 { return n }
    return n * factorial(n: n - 1)
}

let number = 4
print("\(number)! is equal to \(factorial(n: number))")
```

위와 같이 **Factorial.swift** 파일을 만들고, `swiftc` 명령을 실행하는데, 파일 이름을 명령줄의 인자로 전달하고, `-g` 옵션을 붙여서 디버그 정보를 생성하도록 합니다. 이렇게 하면 현재 디렉토리에 **Factorial** 이라는 실행 파일이 생깁니다.

```
$ swiftc -g Factorial.swift
$ ls
Factorial.dSYM
Factorial.swift
Factorial*
```

실제로는 `Factorial` 실행 파일만 생겨납니다. 왜 조금 다른지는 모르겠습니다.

**Factorial** 프로그램을 직접 실행하지 말고, 명령줄에서 `lldb` 명령의 인자로 넘겨서 **LLDB** 디버거를 작동합니다.

```
$ lldb Factorial
(lldb) target create "Factorial"
Current executable set to 'Factorial' (x86_64).
```

이렇게 하면 LLDB 명령을 실행하도록 하는 대화형 콘솔이 시작됩니다.

> LLDB 명령에 대해서 더 알고 싶으면 [LLDB Tutorial](http://lldb.llvm.org/tutorial.html) 을 보기 바랍니다. [^lldb]

`breakpoint set` (`b`) 명령을 사용해서 `factorial(n:)` 함수의 두번째 줄에 중지점을 지정합니다. 함수가 실행될 때마다 해당 지점에서 실행이 중지됩니다. 

```
(lldb) b 2
Breakpoint 1: where = Factorial`Factorial.factorial (Swift.Int) -> Swift.Int + 12 at Factorial.swift:2, address = 0x0000000100000e7c
```

`run` (`r`) 명령으로 프로세스를 실행합니다. 프로세스는 `factorial(n:)` 함수의 호출 지점(?)에서 멈출 것입니다.

```
(lldb) r
Process 40246 resuming
Process 40246 stopped
* thread #1: tid = 0x14dfdf, 0x0000000100000e7c Factorial`Factorial.factorial (n=4) -> Swift.Int + 12 at Factorial.swift:2, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x0000000100000e7c Factorial`Factorial.factorial (n=4) -> Swift.Int + 12 at Factorial.swift:2
   1    func factorial(n: Int) -> Int {
-> 2        if n <= 1 { return n }
   3        return n * factorial(n: n - 1)
   4    }
   5
   6    let number = 4
   7    print("\(number)! is equal to \(factorial(n: number))")
```

`print` (`p`) 명령을 사용해서 `n` 매개 변수의 값을 검사할 수 있습니다.

```
(lldb) p n
(Int) $R0 = 4
```

`print` 명령은 Swift 수식도 계산할 수 있습니다.

```
(lldb) p n * n
(Int) $R1 = 16
```

`backtrace` (`bt`) 명령을 사용하면 to show the frames leading to `factorial(n:)` 가 호출되었을 때의 프레임 앞부분(?) 을 볼 수 있습니다.

```
(lldb) bt
* thread #1: tid = 0x14e393, 0x0000000100000e7c Factorial`Factorial.factorial (n=4) -> Swift.Int + 12 at Factorial.swift:2, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
  * frame #0: 0x0000000100000e7c Factorial`Factorial.factorial (n=4) -> Swift.Int + 12 at Factorial.swift:2
    frame #1: 0x0000000100000daf Factorial`main + 287 at Factorial.swift:7
    frame #2: 0x00007fff890be5ad libdyld.dylib`start + 1
    frame #3: 0x00007fff890be5ad libdyld.dylib`start + 1
```

`continue` (`c`) 명령을 사용해서 프로세스를 재실행할 수 있으며 중지점이 다시 나타날 때까지 실행됩니다.

```
(lldb) c
Process 40246 resuming
Process 40246 stopped
* thread #1: tid = 0x14e393, 0x0000000100000e7c Factorial`Factorial.factorial (n=3) -> Swift.Int + 12 at Factorial.swift:2, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x0000000100000e7c Factorial`Factorial.factorial (n=3) -> Swift.Int + 12 at Factorial.swift:2
   1    func factorial(n: Int) -> Int {
-> 2        if n <= 1 { return n }
   3        return n * factorial(n: n - 1)
   4    }
   5
   6    let number = 4
   7    print("\(number)! is equal to \(factorial(n: number))")
```

`print` (`p`) 명령을 다시 사용해서 두번째로 `factorial(n:)` 가 호출되었을 때의 `n` 매개 변수의 값을 조사합니다.

```
(lldb) p n
(Int) $R2 = 3
```

`breakpoint disable` (`br di`) 명령을 사용해서 모든 중지점들을 해제하고 `continue` (`c`) 명령으로 끝까지 프로세스를 실행합니다.

```
(lldb) br di
All breakpoints disabled. (1 breakpoints)
(lldb) c
Process 40246 resuming
4! is equal to 24
Process 40246 exited with status = 0 (0x00000000)
```

### 참고 자료

[^lldb]: [LLDB Tutorial](http://lldb.llvm.org/tutorial.html)
