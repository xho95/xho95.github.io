리눅스의 데몬(Demon)에 대해서 알아봅니다.

데몬이라는 것은 유닉스나 리눅스에서 시스템의 기능을 제공하거나 백그라운드에서 실행하는 프로그램을 뜻한다고 합니다. 다른 운영체제에서는 시스템 프로세스라고 한다고 합니다. [^threestory-30]

데몬의 동작 방식은 스탠드얼론 방식과 수퍼 데몬 방식 두가지로 나뉜다고 합니다.

#### chkconfig

_약간 예전 방식의 관리 도구인 것 같습니다. 좀 더 알아봐야 합니다._

데몬 관리 도구는 **chkconfig** 인데, **chkconfig**  는 실행 단계에 따라 데몬의 실행 여부를 설정하는 관리 도구라고 합니다. 

우분투 (ubuntu) 에서 `chkconfig` 명령을 실행하면 없는 명령이라고 합니다. [우분투 chkconfig 대체 프로그램들: update-rc.d 와 sysv-rc-conf](http://www.one2next.com/우분투-chkconfig-대체-프로그램들-update-rc-d-와-sysv-rc-conf/) 라는 글에 따르면 Debian 계열  OS 플랫폼에서 사용하는 시작프로그램 관리 프로그램인 **chkconfig** 이 사라졌다고 합니다. [^one2next-chkconfig] 뭔가 이유가 있을 것 같습니다.

### 참고 자료

[^threestory-30]: [리눅스와 데몬, 악마??](http://threestory.tistory.com/30)

[^one2next-chkconfig]: [우분투 chkconfig 대체 프로그램들: update-rc.d 와 sysv-rc-conf](http://www.one2next.com/우분투-chkconfig-대체-프로그램들-update-rc-d-와-sysv-rc-conf/)