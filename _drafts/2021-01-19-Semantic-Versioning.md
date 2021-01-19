---
layout: post
comments: true
title:  "Package: Semantic Versioning (의미에 따른 버전 붙이기)"
date:   2021-01-19 10:00:00 +0900
categories: Swift Package Semantic Versioning
---

## Semantic Versioning (의미에 따른 버전 붙이기)

스위프트 패키지 관련 WWDC 영상에서 Semantic Versioning 은 계속 반복되어 설명하는 주제입니다.
해당 내용을 한 번은 정리할 필요가 있다고 생각하여 정리합니다.
Semantic Versioning 설명 중에서 WWDC19 의 [Binary Frameworks in Swift](https://developer.apple.com/videos/play/wwdc2019/416/) 영상은 예제와 같이 설명하고 있으므로 해당 영상의 Semantic Versioning 설명을 중심으로 정리합니다.

### Patch Version

Smallest component
Patch Version, Bug fixes

### Minor Version

Middle compenent
Compatible additions : New API, New capabilities

### Major Version

Breaking changes : source, binary, semantic
client have to rebuild

### Practice

```swift
// before
public class Spaceship {
  public init name: String
  private var currentLocation: Location

  public init(name: String) {
    self.name = name
    currentLocation = .launchpad
  }

  public func fly(
    to destination: Location,
    speed: Speed) {
    currentLocation = destination
  }
}

public enum Speed {
case leisurely
case fast
}

public struct Location {
  public var coordinates: Coordinates
}
```


```swift
// after
public class Spaceship {
  public init name: String
  private static var defaultLocation: Location?   // Patch
  private var currentLocation: Location

  public init(name: String) {
    self.name = name
    currentLocation = Spaceship.defaultLocation ?? .launchpad // Patch
  }

  public func doABarrelRoll() { .. }  // Minor

  public func fly(
    to destination: Location,
    speed: Speed,
    stealthily: Bool = false) {   // Major
    currentLocation = destination
  }
}

public enum Speed {
case leisurely
case fast
case ludicrous    // Minor
}

public struct Location: Hashable {  // Minor
  public var coordinates: Coordinates
  public var label: String  // Minor
}
```

#### Add a private variable

#### Add a public

#### Add a new parameter's argument label

#### Vale type changes

#### Add a new stored properties

### Implications for API Design

* Keep your interface small - easy to add, hard to remove!
* Choose names and requirements carefully
* Avoid unnecessary extensiblility (open classes, arbitrary callbacks, etc.)

### 참고 자료

* [Binary Frameworks in Swift](https://developer.apple.com/videos/play/wwdc2019/416/)
* [Semantic Versioning 2.0.0](https://semver.org)
