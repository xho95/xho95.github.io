---
layout: post
title:  "WebView App 만들기"
date:   2016-05-16 13:30:00 +0900
categories: Project Swift iOS WebView
---


### URL Issues

* Problem : Error Code - **App Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure. Temporary exceptions can be configured via your app's Info.plist file.**

* Solution : [Transport Security has Blocked a cleartext HTTP](http://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http/32560433#32560433) - 이 경로에서 그림에 설명된 자료가 가장 합당한 듯 하다.

* 하지만, 무조건 위의 문제가 발생하는 것은 아닐 수 있다. - 특정 주소를 바로 갈 수 없기 때문일 수 있다(?)

### Status Bar size

* Web View의 top constraint : **Constraint to margins** check 후에 `0`으로 설정

### Tab Bar Item 추가

* 새 View Controller 추가한 후, Relationship Segue를 `view controllers`로 선택하여 연결하면 된다.

* Solution : [Tab Bar Controller Tutorial in iOS8 with Swift](http://www.ioscreator.com/tutorials/tab-bar-controller-tutorial-ios8-swift)

### View Controller Issues

* Problem : Item View Controller 연결 문제 : 웹에서 변동되는 것을 Tab Bar에서 변경 추적이 어렵다.

* Solution : 하나의 Item View Controller만 사용하는 것이 좋을까? - 이 방법은 탭바를 사용하는 의미가 없어진다.

* Solution : [webView에서의 동작캐치하기](http://quua.iptime.org/1859/dev/ios/) - **UIWebViewDelegate** 를 활용하면 된다.
	* UIWebViewDelegate methods
		* webView - shouldStartLoadWithRequest
		* webViewDidStartLoad
		* webViewDidFinishLoad
		* webView - didFailLoadWithError

### Tab Bar Item의 PDF 이미지 사용

* 잘 안되는 것 같다(?) - free image(?)
* Solution : 75x75 고정 이미지를 받아서 사용

### 전화번호 Issues

* Problem : 아이폰은 직접 소유자의 전화번호를 알 수 없다.
* Solution : 사용자로부터 직접 입력을 받도록 하자. - 웹 UI 변경이 필요하다.

### 전화번호 저장

* 최초 사용자로부터 입력받은 전화번호 로컬에 저장
* 매번 앱을 켤 때마다 웹으로 전송해서 로그인 할 수 있는지 테스트해야 한다.

### App installation failed : Error Message
 
* solution : [App installation failed due to application-identifier entitlement](http://stackoverflow.com/questions/32677133/app-installation-failed-due-to-application-identifier-entitlement)


I had this problem with an iPhone app, and fixed it using the following steps.

* With your device connected, and Xcode open, select **Window/Devices**
* In the left tab of the window that pops up, select your problem device
* In the detail panel on the right, remove the offending app from the "Installed Apps" list.

After I did that, my app rebuilt and launched just fine. Since your app is a watchOS app, I'm not sure that you'll have the same result, but it's worth a try.