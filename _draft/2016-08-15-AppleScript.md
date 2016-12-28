이 파일은 여러 개의 문서로 분리해야 할 것 같습니다. 

AppleScript는 macOS에 내장되어 있는 스크립팅 언어입니다. AppleScript를 사용하여 자동화가 가능합니다. 또한 응용 프로그램을 사용자화하는 것도 가능합니다. AppleScript를 사용하여 스크립트 가능한 응용 프로그램을 제어할 수 있습니다.[^AppleScript-Help]  [^AppleScript]

AppleScript는 Script Editor에서 편집할 수 있는데, Script Editor는 **Applications/Utilities** 폴더에 있습니다.[^Ray]

Yosemite 부터는 AppleScript를 대신해서 JavaScript를 사용하는 것도 가능합니다. 따라서 JavaScript로 운영체제와 앱을 제어하는 것이 가능합니다.[^JXA-Cookbook]

#### AppleScript 시작하기

AppleScript는 맥에서 실행되는 앱에는 모두 적용가능합니다. 

아래는 RayWenderlich 사이트의 예제입니다.

```
tell application "Scriptable Tasks" to quit
```

```
tell application "Scriptable Tasks" to launch
```

```
tell application "Scriptable Tasks" to active
```

사용자가 만든 앱도 제어할 수 있습니다. 물론 그러기 위해서는 사용자의 앱에 미리 설정할 필요가 있습니다.

#### Making Your App Scriptable

The scripting definition file of your app defines what the app can do; it’s a little like an API.

RayWenderlich 사이트의 설명에 따르면 자신의 앱에 AppleScript를 적용하려면 SDEF 파일이 필요한 것 같습니다. 

> SDEF file : a **S**cripting **DEF**inition file을 뜻합니다. 포맷은 XML로 된 것 같습니다. 

* Standard scripting objects and commands, such as window, make, delete, count, open and quit.
* Your own scriptable objects, properties and custom commands.

다만 Swift는 the KVC protocol을 confirm하기 위해서 NSObject를 상속받아야만 할 필요가 있습니다.

scriptable 클래스를 만들려면 클래스 정의 앞에 `@objc(YourClassName)`를 붙여줘야 합니다.

Scriptable classes need object specifiers to help locate a particular object within the application or parent object

finally, the app delegate must have access to the data store so it can return the application’s data to the scripts.

- - -
- 
Swift에서 scriptable 클래스를 만들기 위해서는 3가지(4가지?)가 필요합니다.

1. 클래스가 `NSObject`를 상속받아야 합니다. 
2. 클래스 정의 앞에 `@objc(YourClassName)`를 붙여줘야 합니다.
3. 앱 delegate가 data store에 접근가능하도록 해야 합니다. 그래야만 앱의 데이터를 스크립트에 리턴할 수 있습니다. 
4. object specifiers도 필요하다고 하는데 아직 잘 모르겠습니다.

SDEF 파일의 경우 따로 만들 필요 없이 Apple에서 표준 SDEF 파일이 있습니다. 이름은 CocoaStandard.sdef입니다.

> CocoaStandard.sdef 파일은 바로 찾을 수는 없는데, 숨김 파일이라서 그런 것 같습니다. 위치는 `/System/Library/ScriptingDefinitions/` 입니다.

`ScriptableTasks.sdef` 파일의 주요 구성은 다음과 같습니다. (추가된 부분만)

1. The outermost element is a `suite`. Everything in the SDEF file needs a four-character code. Apple codes are nearly always in lower-case and you will use a few of them for specific purposes.

	```
	<suite name="Scriptable Tasks Suite" code="ScTa" description="Scriptable Tasks suite.">
	```
2. The next section defines the application and must use the code `"capp"`.
3. The application contains elements. In scripting terms, elements are the objects that the app or other objects can contain.
4. The last chunk defines the Task class that the application contains.
5. The first two properties are special. Look at their codes: `"ID "` and `"pnam"`. `"ID "` (note the two spaces after the letters) identifies the unique identifier of the object. `"pnam"` specifies the name property of the object.
6. The remaining two properties use the same name in the object and the script, so you don’t need to specify the `cocoa key`.

```
NSNotificationCenter.defaultCenter().postNotificationName("TasksDataChanged", object: ["newTasksData": tasks])
```

NSNotificationCenter가 무엇인지 알아볼 필요가 있습니다. 

RayWenderlich 사이트 예제 4번이 제대로 동작을 안하는 것 같습니다. `"Feed the cat"`이 중복으로 추가되고 있습니다.

#### 특정 파일 열기 

Numbers 파일을 여는 예제는 다음과 같습니다. 

```
tell application "Numbers" to open ".../.../filename.numbers"
```

보다 자세한 예제는 [iWorks & Automation](https://iworkautomation.com/index.html) 사이트에서 얻을 수 있습니다.[^iWorks_Open]

```applescript
tell application "Numbers"	activate	try		set the chosenDocumentFile to ¬			(choose file of type ¬				{"com.apple.iwork.numbers.numbers", ¬					"com.apple.iwork.numbers.sffnumbers", ¬					"com.microsoft.excel.xls", ¬					"org.openxmlformats.spreadsheetml.sheet"} ¬					default location (path to documents folder) ¬				with prompt "Choose the Numbers document or Excel workbook to open:")		open the chosenDocumentFile	on error errorMessage number errorNumber		if errorNumber is not -128 then			display alert errorNumber message errorMessage		end if	end tryend tell
```

#### 애플릿

응용 프로그램으로 저장된 스크립트를 AppleScript 응용 프로그램 또는 애플릿이라고 합니다. 애플릿은 해당 애플릿을 열 때 스크립트 실행을 시작하는 “on run” 핸들러가 필요합니다.[^Applelet]

다음 예제는 “on run” 핸들러를 보여줍니다.

```
on run
    --first command 
    --second command 
end run
```

#### 드롭릿

드롭릿은 파일이나 폴더를 아이콘에 드래그시 실행되는 AppleScript 스크립트입니다. 드롭릿을 열 때 스크립트 실행을 시작하는 “on open” 핸들러가 필요합니다.[^Droplet]

다음은 “on open” 및 매개변수 목록을 포함한 드롭릿 핸들러의 예제입니다.

```
on open (theItemsDropped)
    --first command 
    --second command 
end open
```

#### AppleScript 카테고리

AppleScript 언어는 다양한 카테고리로 정렬되어 있습니다.

* 모음(Suite): 관련된 용어 그룹. AppleScript 편집기 사전에서 모음은 첫 번째 열에 나타나고 주황색 문자 "S"로 표시됩니다.
* 명령(Command): 동작이나 결과 요청. “이벤트"라고도 하는 명령이 두 번째 열에 나타나고 파란 색 문자 "C"로 표시됩니다(이벤트라고도 함).
* 클래스(Class): 스크립트 가능한 대상체. 클래스 설명은 해당 클래스에 있는 속성 및 요소를 나열합니다. 클래스는 두 번째 열에 나타나며 엷은 자주색 “C”로 표시됩니다.
* 속성(Property): 값을 포함하는 대상체. 속성는 세 번째 열에 나타나며 엷은 자주색 “P”로 표시됩니다.
* 요소(Element): 다른 대상체에 포함된 대상체. 예를 들어 단락에는 여러 단어가 포함될 수 있습니다. 요소는 세 번째 열에 나타나며 주황색 문자 “E”로 표시됩니다.

#### AppleScript 사전 사용하기

응용 프로그램을 조정할 수 있는 명령어와 대상체를 찾으려면 응용 프로그램의 사전을 보십시오. 사전에는 응용 프로그램에서 이해하는 용어 세트가 포함되어 있습니다.[^Dictionary]

사전에 있는 용어는 “모음(Suite)”라고 불리는 관련 용어의 그룹으로 구성되어 있습니다. 명령과 대상체는 볼드체 텍스트입니다.

1. AppleScript 편집기에서 윈도우 > 라이브러리를 선택하십시오.
2. 라이브러리 윈도우에서 응용 프로그램 이름을 이중 클릭하십시오.
3. 모음을 선택하십시오. : 해당 모음의 용어 및 설명이 나타납니다.

#### 응용 프로그램의 위치 지정하기

OS X에서 응용 프로그램은 “패키지”로 묶여 있습니다. 패키지는 응용 프로그램을 구성하는 폴더와 파일을 포함하는 특별한 디렉토리입니다. 이 때문에 “path to”와 “info for” 명령은 응용 프로그램에 대한 다른 결과를 반환할 수 있습니다.[^Path]

응용 프로그램에 대해 “path to” 명령을 사용하는 경우 경로는 주로 “.app”으로 끝납니다. 파일 확장자는 파일 이름의 일부로 Finder에서 표시되지 않지만 스크립트에서 파일을 표시하기 위해 확장자를 사용할 수 있습니다.

응용 프로그램에 대한 정보를 얻기 위해 “info for” 명령을 사용하는 경우 결과의 Finder 속성은 주로 “true”입니다. 확장자 가리기, 이름 확장자 또는 표시된 이름과 같은 결과의 추가 속성을 사용하여 파일과 이름에 대한 더 많은 정보를 얻을 수 있습니다.

#### iCloud에 있는 특정 Numbers 파일 열기

인터넷의 답변을 참고하여 작성했습니다.[^MacScripter]

```
set p2Cloud to (path to library folder from user domain as text) & "Mobile Documents:com~apple~"set fileName to "회원 주소록.numbers"tell application "Numbers"	set appName to its name	open file (p2Cloud & appName & ":Documents:" & fileName)	activateend tell
```

#### List 만들기

새로운 리스트를 만드는 것은 아래와 같습니다.[^WikiBooks] 

```
set myList to {}
```

### Apple Script 사용 예제 

[터미널 명령어를 애플 스크립트로 만들기](http://blackturtle.tistory.com/711692) : 까만 거북이님의 블로그 글

[Mac에서 shell 스크립트를 이용한 이미지 자동 변환](http://ivis.cwnu.ac.kr/tc/dongupak/i/entry/Mac에서-shell-스크립트를-이용한-이미지-자동-변환Mac-OS용-3#_post_222) : 박동규님의 블로그 글

[간단한 shell script 파일 만들기](http://mckstory.tistory.com/entry/간단한-shell-script-파일-만들기)

[맥에서 간단한 배치파일 생성](http://yousungjang.blogspot.kr/2012/11/blog-post_3753.html?m=1)

[바로 실행되는 ShellScript 파일 만들기](http://jungryulchoi.tistory.com/4)

[VIM을 사용하자](http://www.joinc.co.kr/modules/moniwiki/wiki.php/Site/Vim/Documents/UsedVim)

[명령행 작업 좀더 편리하게 하기!](http://redgolems.tistory.com/30)

### AppleScript의 미래

얼마전 AppleScript 개발자가 소속을 옮겼다는 얘기도 들리고, 미래가 밝지만은 않은 것 같습니다. 

### 참고 자료

[^AppleScript-Help]: [AppleScript 도움말](http://help.apple.com/applescript/mac/10.9/#apscrpt1001) Script Editor에 연결되어 있는 도움말인데 설명은 가장 좋은 것 같습니다. 그리고 한글로 번역되어 있습니다. 

[^AppleScript]: [AppleScript: The Language of Automation](http://macosxautomation.com/applescript/index.html) 맥과 iWorks 관련 자동화에 대한 설명이 잘 되어 있는 곳입니다.

[The First Step](http://macosxautomation.com/applescript/firsttutorial/index.html)

[^Ray]: [Making A Mac App Scriptable Tutorial](https://www.raywenderlich.com/133007/making-mac-app-scriptable-tutorial)

[^JXA-Cookbook]: [JavaScript for Automation Cookbook](https://github.com/dtinth/JXA-Cookbook/wiki) GitHub에 공개된 Automation을 JavaScript로 하는 매뉴얼입니다. 

[Introduction to AppleScript Language Guide](https://developer.apple.com/library/prerelease/content/documentation/AppleScript/Conceptual/AppleScriptLangGuide/introduction/ASLR_intro.html) AppleScript 언어 설명서입니다. AppleScript 언어의 전체적인 내용을 볼 수 있습니다. 다만, 영어입니다. 

[^iWorks_Open]: [Opening Documents](https://iworkautomation.com/numbers/document-open.html)

[^Applelet]: [애플릿에 관하여](http://help.apple.com/applescript/mac/10.9/#apscrpt1130)

[^Droplet]: [드롭릿에 관하여](http://help.apple.com/applescript/mac/10.9/#apscrpt1131)

[^Dictionary]: [AppleScript 사전 사용하기](http://help.apple.com/applescript/mac/10.9/#apscrpt5)

[^Path]: [응용 프로그램의 위치 지정하기](http://help.apple.com/applescript/mac/10.9/#apscrpt1031)

[Word Processing - Mailmerge for Pages for Mac](https://www.youtube.com/watch?v=HFM-AWkKFYs)

[^MacScripter]: [tell application "xxxxx" to open "nnnnn" : from iCloud?](http://macscripter.net/viewtopic.php?id=42187)

[^WikiBooks]: [AppleScript Programming](https://en.wikibooks.org/wiki/AppleScript_Programming)

[Multiple Criteria for If statement in AppleScript](http://stackoverflow.com/questions/10522286/multiple-criteria-for-if-statement-in-applescript)

[애플 스크립트를 이용한 이메일 보내기 with 첨부파일](http://creativeworks.tistory.com/entry/애플-스크립트를-이용한-이메일-보내기-with-첨부파일)

[애플스크립트를 이용해 맥 주소록 일괄편집하기](https://mkyojung.wordpress.com/2015/02/14/애플스크립트를-이용해-맥-주소록-일괄편집하기/)

[tell application "xxxxx" to open "nnnnn" : from iCloud?](http://macscripter.net/viewtopic.php?id=42187)

[How do I add Applescript support to my Cocoa application?](http://stackoverflow.com/questions/2479585/how-do-i-add-applescript-support-to-my-cocoa-application)

[Read and write specific cells of an iWork Numbers file stored in iCloud](http://stackoverflow.com/questions/21278833/read-and-write-specific-cells-of-an-iwork-numbers-file-stored-in-icloud)