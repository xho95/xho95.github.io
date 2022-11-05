---
layout: post
comments: true
title:  "Swift: Combine 으로 이벤트 받고 처리하기"
date:   2021-03-28 11:30:00 +0900
categories: Swift Framework Combine Event
---

> 이 글은 '애플 개발자 문서' 에 있는 [Receiving and Handling Events with Combine](https://docs.swift.org/swift-book/) 문서를 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 것입니다. 'Combine' 프레임웍에 대해서는, [Combine Framework (프레임웍)]({% post_url 2021-03-27-Combine %}) 문서를 보도록 합니다.[^combine]

## Receiving and Handling Events with Combine ('Combine' 으로 이벤트 받고 처리하기)

'비동기 소스' 에서 온 이벤트를 사용자 정의해서 받기

### Overview (개요)

`Combine` 프레임웍[^combine] 은 앱이 이벤트를 가공할 수 있도록 '선언형 접근 방식'[^declarative] 을 제공합니다. 잠재적으로 여러 개의 '대리자 콜백' 이나 '처리자 클로저' 를 구현하기 보다는, 주어진 이벤트 소스를 위한 '단일 가공 연쇄' 을 생성할 수 있습니다. 연쇄의 각 부분은 이전 단계에서 받은 원소에 서로 별개의 행동을 수행하는 `Combine` 연산자' 입니다.

'텍스트 필드' 의 내용물을 기초로 '표' 나 '집합체 뷰' 를 걸러내야 할 필요가 있는 앱을 고려해 봅니다. `AppKit`[^appkit] 에서, '텍스트 필드' 의 각 '키 입력 (keystroke)' 은 '컴바인' 으로 구독할 수 있는 [Notification](https://developer.apple.com/documentation/foundation/notification) 을 만들어 냅니다. '알림 (notification)' 을 받은 후, 연산자를 사용하여 이벤트 배달 간격과 내용을 바꿀 수 있으며, 최종 결과를 사용하여 앱의 사용자 인터페이스를 갱신합니다.

### Connect a Publisher to a Subscriber (발행자를 구독자에 연결하기)

`Combine` 으로 '텍스트 필드' 의 '알림' 을 받으려면, [NotificationCenter](https://developer.apple.com/documentation/foundation/notificationcenter) 의 '`default` 인스턴스'[^default-instance] 에 접근하여 [publisher(for:object:)](https://developer.apple.com/documentation/foundation/notificationcenter/3329353-publisher) 메소드를 호출합니다. 이 호출은 알림을 받고 싶은 '알림 이름' 과 '소스 객체' 를 취하고, '알림 원소' 를 만드는 '발행자' 를 반환합니다.

```swift
let pub = NotificationCenter.default
  .publisher(for: NSControl.textDidChangeNotification, object: filterField)
```

발행자로부터 이벤트를 받으려면 [Subscriber](https://developer.apple.com/documentation/combine/subscriber) 를 사용합니다. '구독자' 는, 받을 타입을 선언하는, [Input](https://developer.apple.com/documentation/combine/subscriber/input) 이라는, '결합 타입'[^associated-type] 을 정의합니다. '발행자' 도, 만드는 것이 무엇인지를 선언하는, [Output](https://developer.apple.com/documentation/combine/publisher/output) 이라는, 타입을 정의합니다. 발행자와 구독자 둘 다, 자신이 만들고 받는 에러 종류를 지시하는, [Failure](https://developer.apple.com/documentation/combine/publisher/failure) 라는, 타입을 정의합니다. 구독자를 발행자와 연결하려면, [Output](https://developer.apple.com/documentation/combine/publisher/output) 이 [Input](https://developer.apple.com/documentation/combine/subscriber/input) 과 반드시 일치해야 하며, [Failure](https://developer.apple.com/documentation/combine/publisher/failure) 타입들도 반드시 일치해야 합니다.

`Combine` 은, 첨부한 발행자의 '출력 (outout)' 및 '실패 (failure) 타입' 과 자동으로 일치하는, 두 '내장된 구독자' 를 제공합니다:

* [sink(receiveCompletion:receiveValue:)](https://developer.apple.com/documentation/combine/publisher/sink(receivecompletion:receivevalue:)) 는 클로저를 두 개 취합니다. 첫 번째 클로저는, 발행자가 정상적으로 종료했는지 에러를 가지고 실패했는지를 지시하는 열거체인, [Subscribers.Completion](https://developer.apple.com/documentation/combine/subscribers/completion) 를 받을 때 실행합니다. 두 번째 클로저는 발행자로부터 원소를 받을 때 실행합니다.
* [assign(to:on:)](https://developer.apple.com/documentation/combine/publisher/assign(to:on:)) 은, 속성을 지시하는 '키 경로 (key path)' 를 사용하여,  받은 모든 원소를 주어진 객체의 속성에 곧바로 할당합니다.

예를 들어, 'sink' 구독자를 사용하여 발행자가 완료하고, 매 번 원소를 받을 때마다 기록을 남길 수 있습니다:

```swift
let sub = NotificationCenter.default
  .publisher(for: NSControl.textDidChangeNotification, object: filterField)
  .sink(receiveCompletion: { print ($0) },
        receiveValue: { print ($0) })
```

`sink(receiveCompletion:receiveValue:)` 와 `assign(to:on:)` 둘 다 자신의 발행자에 무제한의 원소 개수를 요청하는 구독자 입니다. 원소를 받을 비율을 제어하려면, [Subscriber](https://developer.apple.com/documentation/combine/subscriber) 프로토콜을 구현하여 자신만의 '구독자' 를 생성합니다.

### Change the Output Type with Operators (연산자로 출력 타입 바꾸기)

이전 절에 있는 'sink' 구독자는 `receiveValue` 클로저에서 모든 작업을 수행합니다. 이는 받은 원소로 많은 사용자 정의 작업을 하거나 불러냄 사이에 상태를 상태를 유지할 필요가 있는 경우 짐이 될 수 있습니다. `Combine` 의 장점은 '이벤트 배달' 을 사용자 정의하기 위해 연산자를 조합하는 것에서 비롯합니다.

예를 들어, [NotificationCenter.Publisher.Output](https://developer.apple.com/documentation/foundation/notificationcenter/publisher/output) 는 '텍스트 필드' 의 문자열 값만 필요한 경우에 콜백에서 받기 편리한 타입은 아닙니다. 발행자의 출력은 본질적으로 시간에 따른 일련의 원소들이므로, `Combine` 은 [map(_:)](https://developer.apple.com/documentation/combine/publisher/map(_:)-99evh), [flatMap(maxPublishers:_:)](https://developer.apple.com/documentation/combine/publisher/flatmap(maxpublishers:_:)-3k7z5), 그리고 [reduce(_:_:)](https://developer.apple.com/documentation/combine/publisher/reduce(_:_:)) 같은 '시퀀스-수정 연산자' 를 제안합니다. 이 연산자들의 작동 방식은 스위프트 표준 라이브러리에 있는 이들의 '동치 연산자 (equivalents)' 들과 비슷합니다.

발행자의 출력 타입을 바꾸려면, 다른 타입을 반환하는 클로저를 담은 [map(_:)](https://developer.apple.com/documentation/combine/publisher/map(_:)-99evh) 연산자를 추가합니다. 이 경우, 알림 객체를 [NSTextField](https://developer.apple.com/documentation/appkit/nstextfield) 로 획득한 다음, '필드' 의 [stringValue](https://developer.apple.com/documentation/appkit/nscontrol/1428950-stringvalue) 을 획득할 수 있습니다.

```swift
let sub = NotificationCenter.default
  .publisher(for: NSControl.textDidChangeNotification, object: filterField)
  .map( { ($0.object as! NSTextField).stringValue } )
  .sink(receiveCompletion: { print ($0) },
        receiveValue: { print ($0) })
```

'발행자 연쇄' 가 원하는 타입을 만들어 낸 후에, `sink(receiveCompletion:receiveValue:)` 를 `assign(to:on:)` 로 대체합니다. 다음 예제는 '발행자 연쇄' 로부터 받은 문자열을 취해서 이를 사용자 정의 '뷰 모델 객체'[^view-model] 의 `filterString` 에 할당합니다:

```swift
let sub = NotificationCenter.default
  .publisher(for: NSControl.textDidChangeNotification, object: filterField)
  .map( { ($0.object as! NSTextField).stringValue } )
  .assign(to: \MyViewModel.filterString, on: myViewModel)
```

### Customize Publishers with Operators (연산자로 '발행자' 사용자 정의하기)

다른 경우라면 수동으로 코딩할 필요가 있었을 행동을 연산자를 사용하여 수행하도록 [Publisher](https://developer.apple.com/documentation/combine/publisher) 인스턴스를 확장할 수 있습니다. 다음은 연산자를 사용하여 이 '이벤트-가공 망' 을 개선할 수 있는 세 가지 방식입니다:

* '텍스트 필드' 에 타이핑한 어떤 문자열로 '뷰 모델' 을 갱신하기 보다는, 정해진 길이 이하의 입력을 무시하거나 '영숫자가-아닌' 문자를 거부하기 위해 [filter(_:)](https://developer.apple.com/documentation/combine/publisher/filter(_:)) 연산자를 사용할 수 있을 것입니다.
* '걸러내는 (filtering) 연산' 의 비용이 비싼 경우-예를 들어, 큰 데이터베이스를 조회하는 경우-사용자가 타이핑을 멈출 때까지 기다리길 원할지도 모릅니다. 이를 위해, [debounce(for:scheduler:options:)](https://developer.apple.com/documentation/combine/publisher/debounce(for:scheduler:options:)) 연산자는 '발행자' 가 이벤트를 내보내기 전에 반드시 경과해야 하는 '최소 시간 간격' 을 설정하도록 해줍니다. [RunLoop](https://developer.apple.com/documentation/foundation/runloop) 클래스는 수 초에서 밀리 초 단위로 '지연 시간' 을 지정하도록 하는 편의를 제공합니다.
* 결과가 'UI' 를 갱신하면, [receive(on:options:)](https://developer.apple.com/documentation/combine/publisher/receive(on:options:)) 메소드를 호출하여 '주 쓰레드 (main thread)' 에 '콜백' 을 배달할 수 있습니다. [RunLoop](https://developer.apple.com/documentation/foundation/runloop) 클래스에서 제공하는 [Scheduler](https://developer.apple.com/documentation/combine/scheduler) 인스턴스를 첫 번째 매개 변수로 지정함으로써, 자신의 '구독자' 를 '주 실행 루프' 에서 호출하라고 `Combine` 에게 말합니다.

결과 '발행자' 선언은 다음과 같습니다:

```swift
let sub = NotificationCenter.default
  .publisher(for: NSControl.textDidChangeNotification, object: filterField)
  .map( { ($0.object as! NSTextField).stringValue } )
  .filter( { $0.unicodeScalars.allSatisfy({CharacterSet.alphanumerics.contains($0)}) } )
  .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
  .receive(on: RunLoop.main)
  .assign(to:\MyViewModel.filterString, on: myViewModel)
```

### Cancel Publishing when Desired (원할 때 발행 취소하기)

'발행자' 는 정상적으로 완료하거나 실패할 때까지 원소를 계속 내보냅니다. 더 이상 '발행자' 를 구독하고 싶지 않으면, '구독' 을 취소할 수 있습니다. [sink(receiveCompletion:receiveValue:)](https://developer.apple.com/documentation/combine/publisher/sink(receivecompletion:receivevalue:)) 와 [assign(to:on:)](https://developer.apple.com/documentation/combine/publisher/assign(to:on:)) 로 생성한 '구독자' 둘 다, [cancel()](https://developer.apple.com/documentation/combine/cancellable/cancel()) 메소드를 제공하는, [Cancellable](https://developer.apple.com/documentation/combine/cancellable) 프로토콜을 구현합니다:

```swift
sub?.cancel()
```

사용자 정의 [Subscriber](https://developer.apple.com/documentation/combine/subscriber) 를 생성하는 경우, 처음 구독할 때 '발행자' 가 [Subscription](https://developer.apple.com/documentation/combine/subscription) 객체를 보냅니다. 이 '구독 (subscription)' 을 저장한 다음, '발행' 을 취소하고 싶을 때 이것의 [cancel()](https://developer.apple.com/documentation/combine/cancellable/cancel()) 메소드를 호출합니다. 사용자 정의 '구독자' 를 생성할 때는, [Cancellable](https://developer.apple.com/documentation/combine/cancellable) 프로토콜을 구현해서, 자신의 [cancel()](https://developer.apple.com/documentation/combine/cancellable/cancel()) 구현이 저장된 '구독' 쪽으로 향하게 해야 합니다.  

### 참고 자료

[^combine]: `Combine` 은 애플이 [WWDC 2019](https://developer.apple.com/videos/wwdc2019/) 에서 발표한 프레임웍입니다.

[^declarative]: '선언형 (declarative)' 에 대한 더 자세한 정보는, 위키피디아의 [Declarative programming](https://en.wikipedia.org/wiki/Declarative_programming) 항목과 [선언형 프로그래밍](https://ko.wikipedia.org/wiki/선언형_프로그래밍) 항목을 보도록 합니다.

[^appkit]: `AppKit` 은 'macOS' 의 'UI' 를 구성하기 위한 프레임웍입니다. '앱 킷 (AppKit)' 에 대한 더 자세한 정보는, 애플 개발자 문서의 [AppKit](https://developer.apple.com/documentation/appkit) 을 보도록 합니다.

[^default-instance]: '`default` 인스턴스' 는 `NotificationCenter` 에 정의되어 있는 '전역 변수' 입니다.

[^associated-type]: '결합 타입 (associated type)' 은 프로토콜에서 사용하는 타입에 '자리 표시용 (placeholder) 이름' 을 부여한 것입니다. '결합 타입' 에 대한 더 자세한 정보는, [스위프트 프로그래밍 언어 (Swift Programming Language)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 책의 [Generics (일반화)]({% post_url 2020-02-29-Generics %}) 장에 있는 [Associated Types (결합 타입)]({% post_url 2020-02-29-Generics %}#associated-types-결합-타입) 부분을 보도록 합니다.

[^view-model]: 여기서의 '뷰 모델 객체 (view model object)' 는 'MVVM' 에 있는 '뷰 모델 (View Model)' 을 말하는 것입니다. 스위프트에서 'MVVM' 의 '뷰 모델' 은 항상 '클래스' 로 구현하기 때문에 '뷰 모델 객체' 라는 용어를 사용한 것으로 추측됩니다.
