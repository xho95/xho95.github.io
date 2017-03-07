### Run Commands during Startup or Shutdown

#### bootsync.sh 와 bootlocal.sh

If you want commands executed every time you start the computer, add them to **/opt/bootsync.sh** or **/opt/bootlocal.sh**.

**/opt/bootsync.sh** is run early in the boot process.

**/opt/bootlocal.sh** is run later in the boot process.

Most commands should go in **/opt/bootlocal.sh**, except commands you want executed early in the boot process.

After changing one of these files, if you don't have persistent **/opt**, backup when turning the computer off.

#### shutdown.sh

If you want commands executed before the computer is turned off, add them to **/opt/shutdown.sh**.

After changing this file, if you don't have persistent **/opt**, backup when turning the computer off.

### 참고 자료

[Run Commands during Startup or Shutdown](http://wiki.tinycorelinux.net/wiki:bootlocal.sh_and_shutdown.sh)