우분투(Ubuntu) 16.04 에서 한글 키보드를 설정하는 방법을 정리합니다. 

우분투의 경우 16.04 가 되면서 예전에 비해서 한글 설정 방법이 엄청 쉬워진 것 같습니다. 기본 입력기도 ibus 에서 [fcitx](https://fcitx-im.org/wiki/Fcitx) 로 변경되었다고 합니다. [^summaries-389] [^fcitx-im] 
 ibus-hangul 에 무슨 문제가 있는 것 같습니다. _fcitx 는 중국에서 만들어 졌다고 합니다. 이부분은 설명을 추가해야 할 것 같습니다._

[Ubuntu - 16.04 한글 설정](http://hochulshin.com/ubuntu-1604-hangul/) 글을 중심으로 기타 다른 자료들을 참고하여 정리하였습니다. [^hochulshin-hangul] [^kjvvv-6328]

### fcitx-hangul 설치하기

먼저 입력기를 설치해 줍니다. 터미널에서 다음 명령으로  `fcitx-hangel` 을 설치합니다.

```
$ sudo apt-get install fcitx-hangul
```

중간에 계속할지를 물을 때는 `y` 키를 입력하면 됩니다. 터미널의 경우 우분투 Search 에서 `terminal` 로 검색하면 실행할 수 있습니다.

_아니면 Ubuntu Software에서 fcitx로 검색해서 설치할 수도 있습니다. 이부분도 확실하지 않으므로 설명을 추가하던지 아니면 터미널 설명만 남기든지 합니다._

설치가 끝나면 **System Settings > Language Support** 를 실행합니다. 그리고 조금 기다리면  뭔가 완전하지 않다는 대화 상자가 나타나는데 이 때 `Install` 을 선택합니다. _그림을 넣습니다._

이 설치까지 끝나면 Language Support 대화 상자에서 **Keyboard input method system:** 를 **fcitx** 로 변경할 수 있습니다. **fcitx** 로 변경해 줍니다. _그림을 넣습니다._

시스템을 재부팅합니다. _꼭 재부팅해야하는지는 아직 잘 모르겠습니다._

### 시스템에서 한영 전환키 설정하기

번호 보다는 그림으로 구분해서 나의 방식으로 다시 정리합니다. 

1. **System Settings > Keyboard** 에서 **Shortcuts** 탭을 누르고 **Typing** 메뉴를 선택합니다.
2. Switch to Next source, Switch to Previous sourc, Compose Key, Alternative Characters Key 의 값을 모두 Disabled 로 만들어 줍니다. Disabled 로 만들려면 마우스로 각각을 선택한 다음에 `backspace` 키를 누르면 됩니다.
3. Compose Key 의 Disabled 를 길게 눌러 `Right Alt`를 선택합니다.
4. Switch to next source 는 한영키를 눌러 `Multikey`를 선택합니다. 반드시 Compose Key 설정이 먼저되어야 `Multikey`를 선택할 수 있습니다. _저의 경우 맥과의 호환을 위해 `caps lock`을 선택합니다. 보조키를 테스트한 후 정리합니다._

### 입력기에서 한영 전환키 설정하기

1. **System Settings** 대화 상자를 닫고 메뉴바 오른쪽에 있는 fcitx 입력기를  선택합니다. 키보드 그림으로 된 것이 fcitx 입니다. fcitx 아이콘을 눌러서 **Configure Current Input Method** 를 선택합니다. 그러면 Input Method Configuration 대화 상자가 나타납니다.
2. `Keyboard-English(US)` 만 있다면 `+` 를 눌러서 `Hangul` 을 추가합니다. 이 과정에서 Add Input Method 대화 상자가 나타나는데, `Hangul` 을 추가하려면 대화 상자 밑에 있는 **Only Show Current Language** 를 체크 해제해야 합니다. 그리고 `Keyboard - Korean` 이 아닌 그냥 `Hangul` 을 선택해야 합니다.
3. 그러면 그림처럼 되는데 이제 **Global Config** 탭을 선택합니다. Trigger Input Method 는 한/영키를 눌러 두 개 모두 `Multikey` 로 설정합니다. Extrakey for trigger input method는 Disabled 로 설정합니다. 
4. Share State Among Window 값은 All 로 해줍니다. (이미 All 인 것 같습니다.)

로그 아웃한 후 다시 로그 인 하면 한영 전환이 됩니다.

### 고찰하기 

키보드에 따라 한영키를 사용할 수 없는 경우가 있는 것 같습니다. 따로 키보드 드라이버 같은 것이 있는지 우분투에서 지원안하는 것인지 확인이 필요한 것 같습니다.

### 참고 자료

[^summaries-389]: [Linux: Ubuntu 16.04 LTS 설치 후 세팅](http://programmingsummaries.tistory.com/389) : 깔끔하게 잘 정리된 글입니다. 한글 키보드가 ibus 에서 fcitx 로 변경되었다고 합니다. 다행히 Atom 편집기는 영향이 없다고 합니다. 마우스나 터치 패드 방향도 macOS 와 일치시키는 방법이 나옵니다.

[^hochulshin-hangul]: [Ubuntu - 16.04 한글 설정](http://hochulshin.com/ubuntu-1604-hangul/) : 뭔가 엄청나게 간결한데 엄청난 글이 될 것 같습니다. 설명 자체는 이 글이 가장 정확합니다.

[^kjvvv-6328]: [우분투 가족 한/영전환키 완벽 해결하기](https://kjvvv.kr/6328)

[^fcitx-im]: [Fcitx](https://fcitx-im.org/wiki/Fcitx)
