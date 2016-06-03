---
layout: post
title:  "Xcode: 프로젝트 이름 바꾸기"
date:   2016-06-04 03:30:00 +0900
categories: Xcode Project Rename Scheme
---
### 프로젝트 이름 바꾸기

* 아래 동영상의 내용을 풀어서 정리하자!
* 프로젝트 이름만 바꾸는 것은 쉽다.

* 프로젝트를 선택한 상태에서 오른쪽 File Inspector 창의 **Identity and Type** 의 **Name** 에 위치한 값을 원하는 프로젝트 이름으로 바꾼다.
* 그러면 하나의 창이 뜨는데 바꾸는 것을 선택한다.
* 그다음, scheme 메뉴에서 **Manage scheme...** 을 선택하여 뜨는 창에서 scheme을 바꾼다.
* 여기까시 하면 프로젝트 이름을 바꾸는 것은 된 것이다.

### 빌드 세팅 바꾸기

* 아래 동영상의 내용을 풀어서 정리하자!
* 빌드 세팅까지 바꾸는 것은 조금 복잡하다.

* 빌드 세팅은 꼭 바꿔야 하는 것은 아니지만, 일관성을 위해서 바꿔주는 것이 좋을 것이다.

* 우선 프로젝트 파일과 동일 위치에 있는 폴더 이름을 프로젝트 이름으로 바꾼다.
* 이때, Tests 관련 폴더들도 있으면 바꿔줘도 상관없다.
* 그런 후에 프로젝트를 열면 연결된 폴더가 다르기 때문에 에러 창이 뜨면서 파일들이 빨간색으로 표시된다.
* 이제 각 그룹 폴더를 선택한 다음 **Identity and Type** 의 **Location** 에 있는 폴더 모양을 선택한다.
* 그러면 폴더를 선택할 수 있는 대화창이 나타나는데, 여기서 위에 이름을 바꿔준 폴더를 선택하면 된다.
* Tests 관련 폴더들도 위와 같은 방식으로 동일하게 작업해준다.
* 프로젝트의 **Build Settings** 에서 `plist`를 검색한다. **Info.plist File** 에서 앞부분을 바꾼 프로젝트 이름으로 설정한다.
* 이 때, 대표값을 바꾸면 **Debug** 와 **Release** 값들이 같이 바뀐다.
* **Product Bundle Identifier** 부분도 변경된 프로젝트 이름과 같이 바꿔준다.
* 단, bundle identifier에는 한글은 안되므로 변경된 프로젝트가 한글일 경우 적당한 영어 단어로 바꿔준다.
* 이것도 앱스토어에 이미 출시한 앱의 경우, bundle Identifier를 바꿀 수는 없다.


### 고찰 하기

* bundle identifier의 경우 일단 앱스토어에 앱을 한 번 제출하고 나면 바꿀 수 없다. 따라서 이후에 프로젝트나 앱 이름을 변경하기 보다는 처음에 이름을 정할 때 신중한 것이 더 좋다.

### 참고 자료

#### Xcode 7 - 가장 좋은 자료

* [Video: How to Rename Xcode 7 Project Thoroughly](https://www.youtube.com/watch?v=jRnVjtNLLLk)
* [Website: How to Rename Xcode 7 Project Thoroughly](http://www.marsoftek.com/how-to-rename-xcode-7-project-thoroughly/)

#### older Xcode - 몇 몇 자료는 너무 예전 방식인 듯 하다.

* [Renaming a Project or App](https://developer.apple.com/library/ios/recipes/xcode_help-project_editor/RenamingaProject/RenamingaProject.html)
- [iOS Dev Tip: The Best Way to Rename a Project in Xcode](http://matthewfecher.com/app-developement/xcode-tips-the-best-way-to-change-a-project-name-in-xcode/)
- [XCode 6.3 프로젝트명 변경](http://wookmania.tistory.com/13)
- [Xcode 6.1: Renaming Projects](http://www.totem.training/swift-ios-tips-tricks-tutorials-blog/xcode-61-renaming-projects)
- [iOS 프로젝트 이름 변경](http://xcode5.tistory.com/entry/iOS-프로젝트-이름-변경)
- [XCode4 프로젝트이름 변경하기](http://smok95.tistory.com/227)
