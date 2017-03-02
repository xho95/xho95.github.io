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