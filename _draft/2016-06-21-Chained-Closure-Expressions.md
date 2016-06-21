WWDC 2016을 보기 시작하고 있습니다.  
너무 많은 동영상을 다 보려면 힘들 것 같아서 비교적 쉬어보이는 동영상부터 보기 시작하고 있습니다.  
맨 처음에는 Getting Started with Swift라는 영상으로 시작했는데, 전체 내용은 딱 the Swift Tour 수준이라 보기에 무난하지만, 그래도 인상적인 부분이 있어서 아주 가벼운 주제로 포스팅을 합니다.  

### 연결된 클로져 표기법

스위프트(Swift)에서 map과 같은 함수들을 사용하다보면 표기법이 약간 애매해지는 경우가 있습니다.  
map 같은 Array의 멤버함수들은 클로져로 된 비교 함수들을 인자로 넘겨 받는데, 괄호의 중복을 막기위해 tailing closure 문법으로 마지막 중괄호를 밖의로 뺄 수가 있습니다.  
문제는 이렇게 하면 map 함수들을 여러번 이어서 호출할 경우 뭔가 표기법이 이상해진다는 점입니다. (map류의 함수들은 sort, 및 reduce 등의 함수들과 연이어서 사용될 가능성이 엄청 높습니다.)

```
let itemsSum = self.map({ $0.sum }).reduce(0, combine: +)
```

위의 코드는 전에 만들었던 코드인데,[^My_Code] 보통 위와 같이 이어서 사용되게 됩니다.  
사실 위의 코드는 아래처럼 써도 되는데, 아래의 코드가 더 이상한 것 같아서 일부러 괄호를 없애지 않았었습니다.

```
let itemsSum = self.map { $0.sum }.reduce(0, combine: +)
```

왜냐면, 중괄호 다음에 연이어서 닷(`.`) 기호가 오는 것이 어색했기 때문입니다.

애플에서도 이 호출 구문이 이상하게 느껴져서인지, 아래와 같이 사용하는 것을 알게 되었습니다. 그리고 그것을 WWDC 2016에서 Dot Notation이라고 하더군요.[^Dot_Notation] 

```
let itemsSum = self
				.map { $0.sum }
				.reduce(0, combine: +)
``` 

크게 중요하지 않는 내용이긴 하지만, 인상적이어서 기록해 둡니다. 뭐랄까 현재는 개발 과정에서 최대한 스타일을 통일하려고 생각하고 있습니다. 

이 포스팅을 하면서 찾아보니까, **The Swift Programming Launguage** 책의 Expressoins 장에서도 사용하고 있는 것을 볼 수 있었습니다.[^Expressions_Chapter] 

### 고찰하기 

Swift 코딩 스타일 가이드는 RayWenderich 사이트에서 잘 정리해서 GitHub에 공개한 글이 있습니다.[^RayWenderich] 

이 글에 있는 내용도 막상 보니까 Closure Expressions 부분에 정리되어 있는 것 같습니다. 물론 어떻게 하든 작성자의 맘이라고 결론 짓기는 했지만요. 역시 누구나 생각하는 것은 비슷한 것 같습니다.

### 참고 자료

[]: 보통 이러한 비교 함수들을 Predicate라고 하는 것 같습니다. (좀더 찾아보자)

[^Dot_Notation]: map 류의 함수들을 위한 닷 표기법은 WWDC 2016의 [Getting Started with Swift](https://developer.apple.com/videos/play/wwdc2016/404/) 영상 후반부에 나옵니다. 

[^My_Code]: 얼마전에 쓴 [Protocol Programming과 관련된 글](http://xho95.github.io/swift/grammar/protocol/constraints/2016/03/03/Adding-Constraints-to-Protocol-Extensions.html)을 쓰면서 만든 예제입니다. [Gist](https://gist.github.com)에도 [ProtocolExtensionConstraints.swift](https://gist.github.com/xho95/3ce1e821852d0debf646)라는 코드로 올렸었습니다.

[^Expressions_Chapter]: 위의 표기법은 The Swift Programming Language 책에서 [Expressions](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/Expressions.html#//apple_ref/doc/uid/TP40014097-CH32-ID383) 장의 Explicit Member Expression 절에 있습니다.

[^RayWenderich]: [The Official raywenderlich.com Swift Style Guide.](https://github.com/raywenderlich/swift-style-guide)