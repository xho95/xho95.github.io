---
layout: post
title:  "Swift에서 변수 최적화에 대한 의문"
date:   2016-01-22 15:17:00 +0900
categories: Xcode Swift Variables Optimization
---

Swift라고 해야할 지, Cocoa라고 해야할지 모르겠는데, 여튼 Xcode에서 프로그래밍을 하다 보면, 변수를 사용하는 방식이 C++과는 조금 다르다는 느낌을 받을 때가 있다. 일단은 정리는 차차하기로 하고 우선 여기서는 관련된 의문에 대해서 적어보기로 한다.


### 클래스 범위를 갖는 변수 선언의 최소화

```swift
class ViewController: UIViewController {
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let touchCount = touches.count
    let touch = touches.first
    let tapCount = touch!.tapCount

    print("Touch Count: \(touchCount), Tap Count: \(tapCount)")
  }

  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let touchCount = touches.count
    let touch = touches.first
    let tapCount = touch!.tapCount

    print("Touch Count: \(touchCount), Tap Count: \(tapCount)")
  }
}
```

위의 코드를 보면 touchCount가 각각의 멤버 함수에서 반복됨을 알 수 있다. 이럴 경우 보통의 경우 클래스 영역에서 `var touchCount` 변수를 만들 법도 하지만, Apple에서는 이렇게 변수를 따로 선언해서 사용하는 방식을 별로 좋아하지 않는 것 같다.

아직 정확하게는 모르겠지만 이것은 성능의 최적화와도 관련이 있는 것 같다. 일단 따로 변수를 만들게 되면 매번 값의 바뀔 때마다 값의 복사가 일어나게 되고, `let` 키워드도 사용할 수 없다. 하지만, 각각의 함수내에서 변수를 사용하면 `touchCount`는 해당 함수내에서는 변화가 없으므로 `let`이 되며, 생성과 동시에 값이 초기화되므로 값의 복사가 일어나지 않는다.

아마도 이런 성능상의 최적화를 위해서 따로 변수를 사용하는 것을 최소화하는 방식으로 프로그래밍을 하도록 유도하는 것이 아닐까 추측한다.

물론 여기까지의 내용은 아직은 막연한 나의 추측일 뿐이고, 잘못된 것일 수도 있다.

Ray 사이트에서 node 찾는 응용 사례를 추가하고 관련된 설명을 붙이자!
