AppleScript is an English-like language used to create script files that control the actions of the computer and the applications that run on it. AppleScript is the language of automation for Mac OS X.[^AppleScript]

AppleScript는 Script Editor에서 편집할 수 있는데, Applications/Utilities 폴더에 있습니다.[^Ray]

Yosemite 부터는 AppleScript를 대신해서 JavaScript를 사용해도 되는 것 같습니다. JavaScript for Automation is a new feature in OS X Yosemite. It lets you control applications and the operating system using JavaScript language.[^JXA-Cookbook]

> SDEF file : a **S**cripting **DEF**inition file을 뜻합니다. 포맷은 XML로 된 것 같습니다. 

AppleScript는 맥에서 실행되는 앱에는 모두 적용가능합니다. 아래는 RayWenderlich 사이트의 예제입니다. 사용자가 만든 앱도 제어할 수 있습니다. 

```
tell application "Scriptable Tasks" to quit
```

```
tell application "Scriptable Tasks" to launch
```

```
tell application "Scriptable Tasks" to active
```

#### Making Your App Scriptable

The scripting definition file of your app defines what the app can do; it’s a little like an API.

RayWenderlich 사이트의 설명에 따르면 자신의 앱에 AppleScript를 적용하려면 SDEF 파일이 필요한 것 같습니다. 

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

### 참고 자료

[^AppleScript]: [AppleScript: The Language of Automation](http://macosxautomation.com/applescript/index.html) 맥과 iWorks 관련 자동화에 대한 설명이 잘 되어 있는 곳입니다.

[The First Step](http://macosxautomation.com/applescript/firsttutorial/index.html)

[^Ray]: [Making A Mac App Scriptable Tutorial](https://www.raywenderlich.com/133007/making-mac-app-scriptable-tutorial)

[^JXA-Cookbook]: [JavaScript for Automation Cookbook](https://github.com/dtinth/JXA-Cookbook/wiki) GitHub에 공개된 Automation을 JavaScript로 하는 매뉴얼입니다. 

[Introduction to AppleScript Language Guide](https://developer.apple.com/library/prerelease/content/documentation/AppleScript/Conceptual/AppleScriptLangGuide/introduction/ASLR_intro.html)

[^iWorks_Open]: [Opening Documents](https://iworkautomation.com/numbers/document-open.html)
