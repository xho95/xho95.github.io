### Kernel 문제

```
BUG: unable to handle kernel NULL pointer dereference at 0000... 
```

A NULL pointer deference error is from the kernel and it is highly likely to be a kernel bug, there is no need to re-install. It is hard to answer this question as there is not enough information. 

The kernel will emit a lot of debug information that helps kernel developers to determine what is causing this problem. This information appears on the console (you can switch to that using `Ctrl``Alt``F1` and back again using `Ctrl``Alt``F7`, or the command: 

```
dmesg
```

should show the full message. [^askubuntu-218260]

### 참고 자료

[^askubuntu-218260]: [Bug: unable to handle kernel NULL pointer dereference at](http://askubuntu.com/questions/218260/bug-unable-to-handle-kernel-null-pointer-dereference-at)

[Ubuntu 16 Kernel BUG (“Oops: 0000 [#1] SMP”) related to amdgpu [closed]](http://askubuntu.com/questions/767163/ubuntu-16-kernel-bug-oops-0000-1-smp-related-to-amdgpu)

[16.04 won't boot after latest updates](http://askubuntu.com/questions/778832/16-04-wont-boot-after-latest-updates)

[우분투 복구 모드 진입하기](http://mslee89.tistory.com/5)

[Ubuntu 복구 모드(recovery mode) 활용](https://zapary.blogspot.kr/2014/08/ubuntu-recovery-mode.html)