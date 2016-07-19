#### Warning: Link

**Warning Message**  

* ld: warning: directory not found for option '-F/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS9.3.sdk/Developer/Library/Frameworks'

**Solution**[^Saltfactory]  [^StackOverflow]  [^Krazyeom]  

* I solved this warning removing the following setting: "$(SDKROOT)/Developer/Library/Frameworks"
* This options is located in **Settings > Build Settings > Search Paths > Framework Search Paths**
* My project continues compiling and working fine, after removing this option.

#### Warning: Link

**Warning Message**  

* warning: All interface orientations must be supported unless the app requires full screen.

#### Warning: Link

**Warning Message**  

* A 83.5x83.5@2x app icon is required for iPad apps targeting iOS 9.0 and later

### 참고 자료

[^Saltfactory]: [Xcode4에서 빌드할때 ld:warning: directory not found for option' 에러 발생할 경우](http://saltfactoryblog.blogspot.kr/2011/04/xcode4-ldwarning-directory-not-found.html)

[^Krazyeom]: [무시하지 말자 ld: warning: directory not found for option](http://www.appilogue.kr/2844538)

[^StackOverflow]: ['warning: directory not found for option' error on build](http://stackoverflow.com/questions/32040038/warning-directory-not-found-for-option-error-on-build)