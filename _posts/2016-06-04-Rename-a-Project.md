---
layout: post
comments: true
title:  "Xcode 7: 프로젝트 이름 바꾸기"
date:   2016-06-04 03:30:00 +0900
categories: Xcode Project Rename Scheme
redirect_from: "https://xho95.github.io/xcode/project/rename/scheme/2016/06/03/Rename-a-Project.html"
---

Xcode로 작업을 하다보면 이미 상당히 진행된 프로젝트나 완료된 프로젝트의 이름을 바꿔야 할 경우가 생깁니다.

이때, 기존 코드와는 상관없이 프로젝트 이름만을 변경하거나 더 나아가서 `bundle identifier` 까지 변경하고자 할 수 있는데, [MAR Software Technologies LLC](http://www.marsoftek.com) 라는 곳에서 이런 상황에 대해 좋은 동영상을 만들어서 이를 글로 정리합니다.[^MAR]

> Xcode 프로젝트의 이름을 변경하는 방법은 많이 찾을 수 있는데, 대부분의 자료들이 예전 자료들인 것 같습니다. [^iOS_Tip] [^Xcode_6_3] [^Xcode_6_1] [^iOS_Rename] [^Xcode_4] 이 자료들은 나중에 전체를 정리할 생각입니다.

### 프로젝트 이름 바꾸기

프로젝트의 이름만 바꾸는 것은 쉽습니다.

우선 프로젝트를 선택한 상태에서 오른쪽 **File Inspector** 창의 **Identity and Type** 의 **Name** 에 위치한 값을 원하는 이름으로 바꿔줍니다. 그러면 하나의 창이 뜨는데 바꾸는 것을 선택합니다.

그다음, scheme[^Scheme] 메뉴에서 **Manage scheme...** 을 선택하여 나타나는 대화창에서 scheme에 해당하는 값을 원하는 이름으로 바꿔줍니다.

> 스킴(scheme)은 빌드할 타겟, 빌드할 때 사용할 설정들, 그리고 테스트를 수행할 때의 테스트들의 집합을 정의한 파일입니다. 스킴은 원하는 만큼 많이 만들 수 있지만, 한 번에 한 개만 활성화할 수 있습니다.

이렇게 하면 프로젝트 이름을 바꾸는 것까지 완료됩니다. 여기까지는 애플 공식 문서의 설명과도 같습니다. [^Apple]

다만, 실제로는 프로젝트 이름을 바꾸면서 관련 폴더명이나 더 나아가서 bundle identifier 값도 바꿔주고 싶을 경우가 있습니다. 물론 폴더 이름이나 빌드 세팅 등을 꼭 바꿔야 하는 것은 아니지만, 일관성을 위해서 바꿔주는 것이 좋을 것입니다.

이와 같은 경우에는 이어지는 절에서 설명한 방법대로 진행하면 됩니다. 물론, 가장 좋은 것은 [Video: How to Rename Xcode 7 Project Thoroughly](https://www.youtube.com/watch?v=jRnVjtNLLLk) 동영상을 보면서 따라서 실습해보는 것입니다.

### 폴더 이름 바꾸기

우선 Xcode를 닫고 이름을 바꿔준 프로젝트 파일과 관련된 폴더 이름을 바꾸고자 하는 이름으로 고칩니다. 이때, 프로젝트에 따라 Tests 관련 폴더들도 있을 수 있는데 같이 바꿔줘도 상관없습니다.

그런 후에 프로젝트를 다시 열면 연결된 폴더가 다르기 때문에 에러 창이 뜨면서 찾을 수 없는 파일들이 붉은색으로 강조되어 표시됩니다. 물론 이 상태에서는 프로젝트에 있어야할 파일들을 찾지 못하는 상태이므로 빌드를 할 수 없습니다.

이제 프로젝트와 관련된 폴더들을 변경된 이름의 폴더로 연동하는 작업을 해야 합니다.  

우선, 각 그룹 폴더를 선택한 다음 **File Inspector** 창의 **Identity and Type** 에서 **Location** 에 있는 폴더 모양을 선택합니다. 폴더 그림이 작으므로 주의가 필요합니다.

그러면 폴더를 선택할 수 있는 대화창이 나타나는데, 여기서 위에 이름을 바꿔준 폴더를 새로 선택하면 됩니다. 이전에는 이전의 폴더명으로 되어 있기 때문에 파일들을 찾을 수 없어 경고창이 나타났던 것입니다. 앞에서, Tests 관련 폴더들도 이름을 바꿨으면 같은 방식으로 동일하게 작업해줍니다.

이렇게 하면 폴더 이름까지 바꿨습니다. 하지만, 빌드를 할 경우 실행 파일들이 저장되야할 폴더를 찾지 못하게 될 수 있습니다. 따라서 빌드 과정에 필요한 설정들도 같이 변경해 줘야 합니다.

### 빌드 세팅 바꾸기

프로젝트를 선택하고 프로젝트의 **Build Settings** 에서 `plist`를 검색한다. **Info.plist File** 을 보면 해당 값의 앞에 이전 폴더 이름이 있음을 볼 수 있습니다. 이 값의 앞부분을 새로 바꾼 폴더 이름으로 설정합니다. 이 때, 대표값을 바꾸면 **Debug** 와 **Release** 값들은 자동으로 같이 바뀝니다.

**Product Bundle Identifier** 에서 프로젝트의 이름이 있는 부분도 바꿔주면 됩니다. 단, bundle identifier는 한글은 안되므로 주의가 필요합니다. 또한, bundle identifier의 경우, 앱스토어에 이미 출시한 앱의 경우, bundle Identifier를 바꿀 수 없기 때문에 바꿔줄 수 없습니다.


### 고찰 하기

bundle identifier의 경우 일단 앱스토어에 앱을 한 번 제출하고 나면 바꿀 수 없습니다. 따라서 이후에 프로젝트나 앱 이름을 변경하기 보다는 처음에 이름을 정할 때 신중히 정하는 것이 더 좋을 것입니다.

프로젝트의 이름이 아니라 앱의 이름만 바꿀 수는 없는지, 알아볼 필요가 있습니다. 방법이 있는 것 같습니다.[^asamaru]  [^blogspot]

### 관련 자료

* [Swift: 리눅스에서 Swift 개발 환경 구축하기]({% post_url 2017-02-16-Developing-Swift-on-Linux %})

### 참고 자료

[^MAR]: 파일 이름을 변경하는 많은 자료들이 있는데, [Video: How to Rename Xcode 7 Project Thoroughly](https://www.youtube.com/watch?v=jRnVjtNLLLk) 여기 만큼 확실하게 정리한 곳은 없는 것 같습니다.

[^Scheme]: 스킴(scheme)에 대한 설명은 [Xcode Scheme](https://developer.apple.com/library/ios/featuredarticles/XcodeConcepts/Concept-Schemes.html#//apple_ref/doc/uid/TP40009328-CH8-SW1)에서 볼 수 있습니다. WWDC 2016 동영상 중에서 [Introduction to Xcode](https://developer.apple.com/videos/play/wwdc2016/413/)에도 Xcode의 Scheme에 대한 설명이 잘 나옵니다.

[^Apple]: 프로젝트 이름을 변경하는 방법은 애플에서 공식적으로 [Renaming a Project or App](https://developer.apple.com/library/ios/recipes/xcode_help-project_editor/RenamingaProject/RenamingaProject.html)라는 문서에서 설명하고 있습니다. 다만 여기서는 순수하게 프로젝트 이름만 변경합니다. 폴더 이름이나 빌드 세팅을 변경하는 방법은 설명하지 않습니다.

[^iOS_Tip]: [iOS Dev Tip: The Best Way to Rename a Project in Xcode](http://matthewfecher.com/app-developement/xcode-tips-the-best-way-to-change-a-project-name-in-xcode/)

[^Xcode_6_3]: [XCode 6.3 프로젝트명 변경](http://wookmania.tistory.com/13)

[^Xcode_6_1]: [Xcode 6.1: Renaming Projects](http://www.totem.training/swift-ios-tips-tricks-tutorials-blog/xcode-61-renaming-projects)

[^iOS_Rename]: [iOS 프로젝트 이름 변경](http://xcode5.tistory.com/entry/iOS-프로젝트-이름-변경)

[^Xcode_4]: [XCode4 프로젝트이름 변경하기](http://smok95.tistory.com/227)

[^asamaru]: 프로젝트에서 앱의 이름만 변경하는 것은 [유영재님의 블로그](https://blog.asamaru.net)에 [Xcode 프로젝트 앱 이름 변경](https://blog.asamaru.net/2015/10/08/change-xcode-project-app-name/)이라는 글에 설명이 있습니다. 아직 제가 직접 테스트해보지 않아서 주석을 달았는데, 나중에 정리해서 포스트 글에 넣도록 하겠습니다.

[^blogspot]: [XCode 에서 앱 이름 변경](http://jryeong.blogspot.kr/2014/01/ios-xcode.html)
