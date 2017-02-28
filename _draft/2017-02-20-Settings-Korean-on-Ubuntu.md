우분투(Ubuntu) 16.04 에서 한글 키보드를 설정하는 방법을 정리합니다. 

[Ubuntu - 16.04 한글 설정](http://hochulshin.com/ubuntu-1604-hangul/) 글을 기준으로 정리합니다. [^hochulshin-hangul]

16.04 가 되면서 예전에 비해서 한글 설정 방법이 엄청 쉬워진 것 같습니다. 기본 입력기도 ibus 에서 fcitx 로 변경되었다고 합니다. [^summaries-389]

### fcitx-hangul 설치

다음과 같이 `fcitx-hangel` 을 설치합니다.

```
$ sudo apt-get install fcitx-hangul
```

**System Settings > Language Support** 를 실행하면 뭔가 더 설치하라고 하는데 설치합니다.

그러면 **Keyboard input method system:** 를 **fcitx** 로 변경할 수 있습니다.

설명대로 재부팅합니다. 말은 조금 더 정리합니다.

### 한영 전환 설정하기

1. **AllSettings > Keyboard** 에서 **Shortcuts** 탭의 **Typing** 메뉴를 선택합니다.
2. Switch to Next source, Switch to Previous sourc, Compose Key, Alternative Characters Key를 모두 `Disabled` 로 선택합니다. `Disabled` 로 선택하기 위해서는 `backspace`를 누르면 됩니다.
3. Compose Key의 `Disabled`를 길게 눌러 `Right Alt`를 선택합니다.
4. Switch to next source는 한영키를 눌러 `Multikey`를 선택한다. 반드시 Compose Key 설정이 먼저되어야 `Multikey`를 선택할 수 있다. 어쩔 수 없이 `Caps Lock` 을 선택합니다.
5. AllSetting 윈도우를 닫고 상단 메뉴바 오른쪽에 입력기를 선택합니다. 키보드 표시가 된 것이 fcitx 입니다. fcitx 아이콘을 눌러서 **Configure Current Input Method** 를 선택합니다.
6. Keyboard-English(US)가 있다면 +를 눌러 Hangul을 추가합니다. 이 때 Only Show Current Language 를 체크 해제해야 합니다. Korean이 아닌 Hangul이여야 합니다.
7. **Global Config** 탭에서 **Trigger Input Method** 는 한/영키를 눌러 Multikey로 설정(왼쪽 오른쪽 모두)하고 **Extrakey for trigger input method**는 Disabled 로 설정한다. (Mac에서는 command key이므로 대신 shift+space를 선택한다.)
8. Global Config 탭에서 **Program > Share State Among Window** 값을 All 로 해줍니다. (이미 All 인 것 같습니다.)

로그 아웃한 후 다시 로그 인 하면 한영 전환이 됩니다.

### 기타

기타 우분투 관련 내용들을 정리할 에정입니다. [^omgubuntu-to-do]

### 고찰하기 

키보드에 따라 한영키를 사용할 수 없는 경우가 있는 것 같습니다. 우분투에서 지원안하는 것인지 확인이 필요한 것 같습니다. 그냥 과감하게 macOS 와 같이 맞추기 위해 대소문자를 포기하고 CapsLock 을 한영 전환키로 지정했습니다.

### 참고 자료

[^summaries-389]: [Linux: Ubuntu 16.04 LTS 설치 후 세팅](http://programmingsummaries.tistory.com/389) : 깔끔하게 잘 정리된 글입니다. 한글 키보드가 ibus 에서 fcitx 로 변경되었다고 합니다. 다행히 Atom 편집기는 영향이 없다고 합니다. 마우스나 터치 패드 방향도 macOS 와 일치시키는 방법이 나옵니다.

[^hochulshin-hangul]: [Ubuntu - 16.04 한글 설정](http://hochulshin.com/ubuntu-1604-hangul/) : 뭔가 엄청나게 간결한데 엄청난 글이 될 것 같습니다. 설명 자체는 이 글이 가장 정확합니다.

[^omgubuntu-to-do]: [16 Things To Do After Installing Ubuntu 16.04 LTS](http://www.omgubuntu.co.uk/2016/04/10-things-to-do-after-installing-ubuntu-16-04-lts) : 우분투를 설치하고 해봄직한 것들을 16가지 소개하고 있습니다. 시간날 때 조금씩 해보면 될 것 같습니다. 다른 것 보다 우분투에 플랫 디자인 비슷한 거 적용해보는 것 정도는 해볼만한 것 같습니다.
