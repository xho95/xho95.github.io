
## `ls`

### 한 요소에 대해서 `ls` 적용하기

폴더 내에 요소가 너무 많아서 보기 힘든 상황에서 `ls` 를 한 요소에 대해서만 적용하고 싶으면, `-d` 옵션을 사용하면 됩니다. 아래에 `/etc` 디렉토리에 대해 `-d` 옵션을 적용한 결과를 보여줍니다:

```sh
$ ls -ld /etc
lrwxr-xr-x@ 1 root  admin  11 Oct  9  2019 /etc -> private/etc
```

위와 같이 `/etc` 에 대한 내용만 보여주는 것을 확인할 수 있습니다. 이렇게 하면 `/etc` 속성을 보려고 일일이 여기저기 뒤질 필요가 없어집니다. 

### 참고 자료

[In bash how do I use ls to list a single folder](https://stackoverflow.com/questions/10504916/in-bash-how-do-i-use-ls-to-list-a-single-folder)
