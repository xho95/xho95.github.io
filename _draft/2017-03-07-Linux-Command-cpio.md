cpio 명령어에 대해서 잘 정리된 [Linux cpio Examples: How to Create and Extract cpio Archives (and tar archives)](http://www.thegeekstuff.com/2010/08/cpio-utility) 글을 번역 정리합니다. [^geek-cpio]

옵션에 대해서는 [cpio(1) - Linux man page](https://linux.die.net/man/1/cpio) 글을 참고합니다. [^man-cpio] [^hope-ucpio]

## Linux cpio Examples: How to Create and Extract cpio Archives (and tar archives)

cpio command is used to process archive files (for example, ***.cpio** or ***.tar** files).

cpio stands for “copy in, copy out”.

cpio performs the following three operations.

* Copying files to an archive
* Extracting files from an archive
* Passing files to another directory tree

cpio takes the list of files from the standard input while creating an archive, and sends the output to the standard output.

### 1. Create *.cpio Archive File

You can create a ***.cpio** archive that contains files and directories using `cpio -ov`.

```
$ cd objects

$ ls
file1.o file2.o file3.o

$ ls | cpio -ov > /tmp/object.cpio
```

As seen above, the ls command passes the three object filenames to cpio command and cpio generates the **object.cpio** archive.

### 2. Extract *.cpio Archive File

cpio extract: To extract a given ***.cpio** file, use `cpio -iv` as shown below.

```
$ mkdir output

$ cd output

$ cpio -idv < /tmp/object.cpio
```

### 3. Create *.cpio Archive with Selected Files

The following example creates a ***.cpio** archive only with ***.c** files.

```
$ find . -iname *.c -print | cpio -ov >/tmp/c_files.cpio
```

### 4. Create *.tar Archive File using cpio -F

We already know how to use the [tar command](http://www.thegeekstuff.com/2010/04/unix-tar-command-examples/) effectively. [^geek-tar]

Did you know that you can also use cpio command to create tar files as shown below?

```
$ ls | cpio -ov -H tar -F sample.tar
```

As seen above, instead of redirecting the standard output you can mention the output archive filename with the option `-F`.

### 5. Extract *.tar Archive File using cpio command

You can also extract a tar file using cpio command as shown below.

```
$ cpio -idv -F sample.tar
```

### 6. View the content of *.tar Archive File

To view the content of ***.tar** file, do the following.

```
$ cpio -it -F sample.tar
```

### 7. Create a *.cpio Archive with the Original files that a Symbolic Link Points

cpio archive can be created with the original files that a symbolic link is referring to as shown below.

```
$ ls | cpio -oLv >/tmp/test.cpio
```

### 8. Preserve the File Modification Time while restoring *.cpio

The modification time of the files can be preserved when we are restoring the cpio archive files as shown below.

```
$ ls | cpio -omv >/tmp/test.cpio
```

### 9. Manipulate Linux and Kernel image files using cpio

[How to View, Modify and Recreate initrd.img](http://www.thegeekstuff.com/2009/07/how-to-view-modify-and-recreate-initrd-img/) – As we discussed a while back, we can also use cpio command to manipulate **initrd.img** file. [^geek-initrd]

### 10. Copy Directory Tree from One to Another

cpio allows you to copy one directory contents into another directory without creating an intermediate archive. It reads the file list from the standard input and pass it to the target directory.

The example below copies the files and sub-directories of objects directory into `/mnt/out` directory.

```
$ mkdir /mnt/out

$ cd objects

$ find . -depth | cpio -pmdv /mnt/out
```

In the above example:

* cpio option `-p` makes cpio to use pass through mode. Its like piping `cpio -o` into `cpio -i`.
* cpio option `-d` creates leading directories as needed in the target directory.

### 참고 자료

[^geek-cpio]: [Linux cpio Examples: How to Create and Extract cpio Archives (and tar archives)](http://www.thegeekstuff.com/2010/08/cpio-utility)

[^geek-tar]: [The Ultimate Tar Command Tutorial with 10 Practical Examples](http://www.thegeekstuff.com/2010/04/unix-tar-command-examples/)

[^geek-initrd]: [How to View, Modify and Recreate initrd.img](http://www.thegeekstuff.com/2009/07/how-to-view-modify-and-recreate-initrd-img/)

[^man-cpio]: [cpio(1) - Linux man page](https://linux.die.net/man/1/cpio)

[^hope-ucpio]: [Linux and Unix cpio command](http://www.computerhope.com/unix/ucpio.htm)