---
layout: post
comments: true
title:  "Package: swift-create-xcframework"
date:   2021-01-10 11:30:00 +0900
categories: XCFramework Swift Package
---

> 이 문서는 GitHub Action 의 [swift-create-xcframework](https://github.com/marketplace/actions/swift-create-xcframework) 문서를 번역한 것입니다.

## swift-create-XCFramework

`swift-create-xcframework` 은 아주 간단한 도구입니다.


`swift-create-xcframework` 는 `xcodebuild` 를 포장하며 '스위프트 패키지' 를 위한 다중 프레임웍을 생성하고 이를 단일 'XCFramework' 로 병합하는 과정을 위해 설계된 아주 간단한 도구입니다.

2020년 6월 23일에, '애플 (Apple)' 은 'Binary Targets' 를 지원하는 '엑스코드 (Xcode)' 와 '스위프트 5.3' 을 발표했습니다. [패키지에 바이너리 프레임웍을 포함 (include Binary Frameworks in your packages)](https://developer.apple.com/documentation/swift_packages/distributing_binary_frameworks_as_swift_packages) 하는 간단한 방법을 제공하긴 했지만, 'XCFrameworks' 을 생성하는 간단한 방법 대신, [긴 수동 과정에 대한 문서 (documentation for the long manual process)](https://help.apple.com/xcode/mac/11.4/#/dev544efab96) 일부만을 제공했습니다. `swift-create-xcframework` 는 해당 빈틈을 이어줍니다.

> `swift-create-xcframework` 는 WWDC20 발표 이전에 출시되었으며 '엑스코드 11.4' 이후 버전에서 테스트되었지만, '엑스코드 11.2' 이상에서 작업해야 합니다. 생성된 'XCFramework' 는 '엑스코드 12' 가 없더라도 앱에 수동으로 포함시킬 수 있습니다.

### Usage (사용법)

스위프트 패키지 폴더 내에서 다음을 실행할 수 있습니다:

```bash
$ swift create-xcframework
```

기본적으로 swift-create-xcframework는 Package.swift의 모든 라이브러리 제품 또는 명령 줄에서 지정한 모든 대상에 대해 XCFrameworks를 빌드합니다 (포함하는 모든 종속성에 대해서도 가능).

그런 다음 지정된 모든 대상 또는 제품에 대해 swift-create-xcframework가 다음을 수행합니다.

패키지에 대한 Xcode 프로젝트를 생성합니다 (.build / swift-create-xcframework에서).
지원되는 각 플랫폼 / SDK에 대한 .framework를 빌드합니다.
xcodebuild -create-xcframework를 사용하여 SDK 관련 프레임 워크를 XCFramework에 병합합니다.
선택적으로 GitHub 릴리스를 위해 준비된 zip 파일로 패키지화합니다.
이 프로세스는 공식 문서를 반영합니다.

### 참고 자료
