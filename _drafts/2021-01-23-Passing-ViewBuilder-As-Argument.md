
### 에러

```swift
var content: View
```

```
Protocol 'View' can only be used as a generic constraint because it has Self or associated type requirements
```

### 이유

`View` 는 프로토콜이기 때문에 자체로는 인스턴스를 만들 수 없습니다.

위의 에러 설명을 직역하면 `Self` 나 '결합 타입 필수 조건' 을 가지고 있기 때문에 '일반화 구속 조건' 으로만 사용할 수 있습니다.

### 해결 방법

`ViewBuilder` 를 활용하여, `View` 는 '구속 조건' 으로 사용합니다.[^generic-constraint]

```swift
struct BorderedView<Content>: View where Content: View {
  let content: Content

  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  var body: some View {
    VStack {
      self.content
    }
    .border(Color.red, width: 2)
  }
}
```

### 참고 자료

[Pass SwiftUI view as argument to another view](https://programmingwithswift.com/pass-swiftui-view-as-argument-to-another-view/)

[^generic-constraint]: 일반화 구속 조건을 작성할 때는, `<Content: View>` 처럼 할 수도 있지만, 개인적으로는 `<Content> ... where Content: View` 라고 `where` 절을 명시적으로 작성하는 것을 좋아합니다. 
