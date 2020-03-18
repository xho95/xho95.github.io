## What's New in Auto Layout

WWDC 2016의 What's New in Auto Layout 영상을 보고 정리한 글입니다.[^236]

### Incrementally Adopting Auto Layout

* must add your own constraints
* can specify autoresizing masks : * **Autoresizing** - new

#### Incremental Adoption

* autosizing masks

#### Demo

* Autoshrink : Minimum Font Size - view 폭 때문에 글자가 사라지는 것을 막는 것 같습니다(?)

### Design and Runtime Constraints

#### Placeholder Constraints

* simulate constraint behavior at design time

#### Disign Time Intrinsic Size

* good for custom controls
* 실행시간에 사이즈를 바꾸려면 아래의 변수를 이용하면 됩니다.

```
override var intrinsicContentSize: CGSize
```

#### Turn Off Ambiguity Per View

* Arbitrary layout defined with runtime constraints
* **Ambiguity** : new

### NSGridView

* maintenance on constraints is complicated

* `NSGridView` : new
* `NSGridCell`

* 그리드 양식을 만들 수 있는 것 같습니다만, 아직은 잘 모르겠습니다. 일단은 macOS 용 API인 것 같습니다. 

* 전체적으로 이 부분은 아직 잘 모르겠습니다. 나중에 다시 정리할 필요가 있습니다. 

#### Demo

* NSGridView를 활용해서 하나의 대화창 UI를 만들고 있습니다. 
* great for arrainging static grid-like UI

### Layout Feedback Loop Debugging

#### Layout Feedback Loop

* upstream `setNeedsLayout()`

#### The Layout Feedback Loop Debugger : new

* example 1 : upstream geometry change
	* 이 부분도 정확하게 무슨 의미인지를 모르겠습니다.
	* 부모-자식 관계에 따라 자동으로 배치가 된다는 것과 관련이 있는 것 같습니다.
	* call stacks where : 호출 관계인지 뭔지 모르겠습니다. 
	
* example 2 : Ambiguous Layout

* 전체적으로 이 부분은 Layout의 밑단에 대한 예기입니다. Layout과 관련한 디버깅을 할 때가 아니면 꼭 봐야하는 것은 아닌 것 같습니다. 

* 기존의 Layout 보다 효율성을 높인 것 같습니다. Layout이 바뀐 부분만 처리를 하도록 하는 개념인 것 같습니다. 

### 참고 자료

[^236]: [WWDC2016 236: What's New in Auto Layout](https://developer.apple.com/videos/play/wwdc2016/236/)

