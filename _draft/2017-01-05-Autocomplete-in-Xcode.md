가끔가다가 Xcode에서 Auto Complete가 잘 안되는 경우가 있습니다. 물론 가끔 발생할 정도로 자주 일어나는 일은 아니지만 한 번 발생하니까 답답하기는 했습니다.

인터넷으로 해결 방법을 찾아봤는데, 왜 되는지는 모르겠지만 stackoverflow의 [Xcode 7.3 autocomplete is so frustrating](http://stackoverflow.com/questions/36169099/xcode-7-3-autocomplete-is-so-frustrating) 답글 중에서 evanflash님과 Hashem Aboonajmi님의 답변대로 하니까 문제가 해결되는 것 같습니다. [^stackoverflow-36169099]

#### 해결 방법

먼저 파인더에서 **Xcode > Preferences > Locations > Derived Data** 폴더로 이동합니다. 

해당 폴더의 주소는 아래와 같습니다. 

```
/Users/yourUserName/Library/Developer/Xcode/DerivedData
```

> 파인더에서 특정 폴더로 바로 이동하는 것은 파인더의 **이동 > 폴더로 이동...** 메뉴를 이용하면 됩니다. 
> 
> 위의 주소를 폴더로 이동... 메뉴의 입력창에 붙여 넣고 yourUserName을 자신의 로그인 사용자 명을 넣으면 파인더가 알아서 진짜 폴더 경로를 인식하는 것을 볼 수 있습니다. 

해당 폴더의 내용을 지웁니다. (일종의 캐시 폴더인 듯 합니다.) 

Xcode를 재시작합니다. 

![Auto-Complte](../assets/Xcode/auto-complete.jpg)

위의 그림과 같이 Autocomplte가 원래대로 잘 되는 것을 볼 수 있습니다. 

> 여타 다른 답변들에 달린 것과 같은 설정 등은 큰 의미가 없는 것 같습니다. 

### 참고 자료

[^stackoverflow-36169099]: [Xcode 7.3 autocomplete is so frustrating](http://stackoverflow.com/questions/36169099/xcode-7-3-autocomplete-is-so-frustrating) : 원래 설명은 evanflash님이 했지만 실제로 따라할 수 있는 설명은 Hashem Aboonajmi님이 해서, 그대로 따라 했습니다.