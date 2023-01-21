---
layout: post
comments: true
title:  "SwiftUI: MVVM 이해하기"
date:   2020-08-05 19:45:00 +0900
categories: SwiftUI Architecture MVVM Logic
---

> 이 글은 SwiftUI 에서 도입한 MVVM 패턴을 알아보고자 위키피디아의 [Model–view–viewmodel](https://en.wikipedia.org/wiki/Model–view–viewmodel) 과 [모델-뷰-뷰모델](https://ko.wikipedia.org/wiki/모델-뷰-뷰모델) 을 참고하여 정리한 글입니다.
>
> 위키피디아의 [모델-뷰-뷰모델](https://ko.wikipedia.org/wiki/모델-뷰-뷰모델) 부분을 직접 번역하면서 정리한 것인데, 원문이 마이크로소프트 닷넷 위주로 되어 있어서 그 부분은 적당히 잘라내고 SwiftUI 와 관련된 내용을 합쳐서 각색하였습니다.

## SwiftUI: MVVM 이해하기

그동안 스위프트 개발에서 사용한 아키텍처 패턴은 MVC 라고 할 수 있는데, 2019년 애플에서 SwiftUI 를 발표하면서 MVVM 패턴을 새롭게 소개하였습니다.

처음 MVVM 을 봤을 때는 MVC 와 크게 다르지 않다고 느꼈었는데, 이번에 스탠포드 대학교의 [SwiftUI 강의 (cs193p)](https://cs193p.sites.stanford.edu) 를 보면서, MVVM 에서는, 아래 그림 처럼, '로직 (Logic)' 이 '모델 (Model)' 에 위치한다는 것을 알게 되었습니다.

![MVVM](/assets/Swift/Pattern/MVVM-cs193p-2020.png)

* 이미지 출처: [Stanford lecture - cs193p](https://cs193p.sites.stanford.edu)

MVC 패턴에서는 '컨트롤러 (Controller)' 에 '비지니스 로직 (business logic)' 을 두는데, MVVM 에서는 모델에 두는 것을 보고, 그 이유를 알아보고자 MVVM 에 대해서 조금 알아보았지만, 로직의 위치에 대해서 저마다 의견이 달랐습니다.

그러던 중, 위키피디아의 MVVM 항목이 MVVM 에 대해서 가장 잘 설명하고 있다고 느껴서, 해당 항목을 한글로 번역하면서,[^translate] SwiftUI 와 관련된 내용을 추가하여 이 블로그 글을 정리하였습니다.

> 이후의 내용은 위키피디아의 내용을 각색하고 SwiftUI 와 관련된 내용을 합쳐서 재구성한 것입니다.

### MVVM 의 개요

![MVVM](/assets/Swift/Pattern/MVVM-wikipedia.png)

* 이미지 출처: [Wikipedia](https://en.wikipedia.org/wiki/Model–view–viewmodel)

_모델-뷰-뷰 모델 (Model-View-ViewModel; MVVM)_ 은 하나의 소프트웨어 아키텍처 패턴으로-마크업 언어나 GUI 코드로 구현하는-그래픽 사용자 인터페이스인, _뷰 (View)_ 의 개발[^GUI-code]을 비지니스 로직 또는 백-엔드 로직인, _모델 (Model)_ 로 부터 분리해서, 뷰가 어느 특정한 모델 플랫폼에 종속되지 않도록 해줍니다. MVVM 의 _뷰 모델_ 은 값 변환기라고 할 수 있는데, 이는 뷰 모델이 모델에 있는 데이터 객체를 노출 및 변환하는 책임을 지기 때문에 객체의 관리와 표현이 수월해진다는 것을 의미합니다.

이러한 점에서, 뷰 모델은 뷰 보다는 더 모델이라고 할 수 있으며, 뷰 자체의 디스플레이 로직을 제외한 대부분을 처리합니다. 뷰 모델은, '백-엔드 로직에 대한 접근'과 그 주변부의 '뷰에서 지원하는 유즈 케이스 집합' 으로 구성되도록, 중재자 패턴으로 구현할 수도 있습니다.[^mediator]

MVVM 은 [마틴 파울러 (Martin Fowler)](https://martinfowler.com) 의 [프레젠테이션 모델 (Presentation Model)](https://martinfowler.com/eaaDev/PresentationModel.html) 패턴을 변형하여, 마이크로소프트의 아키텍트인 [켄 쿠퍼 (Ken Cooper)](https://www.linkedin.com/in/coopercode/) 와 테드 피터스 (Ted Peters) 에 의해 발명된 것으로써, 마이크로소프트의 [존 구스먼 (John Gossman)](https://www.linkedin.com/in/john-gossman-5664952/) 이 2005년 [자신의 블로그에서 발표](https://docs.microsoft.com/en-us/archive/blogs/johngossman/introduction-to-modelviewviewmodel-pattern-for-building-wpf-apps) 한 것입니다.[^johns-blog]

> 모델-뷰-뷰모델 패턴은 _모델-뷰-바인더 (model-view-binder)_ 라고도 합니다.

### MVVM 의 구성 요소

#### 모델 (Model)

_모델_ 은, 객체-지향 접근법이라 하여 실제 상태를 표현하는 '도메인 모델 (domain model)' 을 참조하거나, 아니면 데이터-중심 접근법이라 하여 모델 내용을 표현하는 '데이터 접근 계층 (data access layer)' 을 참조합니다.

이를 SwiftUI 의 관점에서 보면 도메인 모델은 코드 상의 모델 구조체를 말하는 것이고, 데이터 접근 계층은 SwiftUI 에서 '속성 포장 (proterty wrapper; 프로퍼티 래퍼)'[^property-wrapper] 을 사용하여 DB 에 접근 하는 부분에 해당한다고 볼 수 있습니다.

#### 뷰 (View)

모델-뷰-컨트롤러 (MVC) 와 모델-뷰-프리젠터 (MVP) 패턴에서와 같이, _뷰_ 는 사용자가 화면에서 보는 것들에 대한 구조, 배치, 그리고 외관에 해당합니다. 모델을 표현하여 보여주고 사용자와 뷰의 상호 작용 (클릭, 키보드, 동작 등) 을 수신하며, 뷰와 뷰 모델의 연결을 정의하는 '데이터 연결 (data binding)'-속성, 이벤트 콜백 함수 등-을 통하여 이에 대한 처리를 뷰 모델로 넘깁니다.

SwiftUI 에서는 `@ObservedObject` 라는 '속성 포장' 을 통하여 뷰와 뷰 모델을 '연결 (binding)' 합니다.

#### 뷰 모델 (View Model)

_뷰 모델_ 은 뷰에 대한 '추상화 (abstraction)' 로써 공용 속성과 공용 명령을 노출합니다. MVVM 은 , MVC 의 컨트롤러나 MVP 의 '발표자 (presenter; 프리젠터)' 를 대신하여, _연결자 (binder; 바인더)_ 라는 것을 가지고 있는데, 이는 뷰 모델에서 뷰와 연결된 속성 및 뷰 사이의 통신을 자동화합니다.

MVVM 의 '뷰 모델' 과 MVP 의 '발표자' 사이의 주요한 차이점은 '발표자' 는 뷰에 대한 참조를 가지고 있지만, 뷰 모델은 아니라는 것입니다. 그 대신, 뷰는 뷰 모델에 대한 속성에 직접 '연결된 (binds)' 채로 업데이트를 주고 받습니다.

SwiftUI 에서는 '뷰 모델' 이 `ObservableObject` 라는 프로토콜을 준수함으로써 통신을 자동화합니다. 또한 뷰는 앞서 말한 `@ObservedObject` 로 연결된 '뷰 모델' 과 업데이트를 주고 받을 수 있습니다.

### 연결자 (Binder; 바인더)

MVVM 패턴에서는 '선언적인 데이터 (declarative data)' 와 '명령-연결 (command-binding)' 이 내재되어 있습니다. 바인더는 뷰 모델과 뷰의 동기화를 위한 '획일적인 (boilerplate)' 코드를 작성해야 하는 의무에서 개발자를 해방시켜 줍니다.

SwiftUI 프레임웍은 `ObservableObject` 프로토콜과, `@Published` 및 `@ObservedObject` '속성 포장' 을 통하여 '연결자 (binder)' 를 내부에 통합하고 있다고 볼 수 있습니다.

### 결론

MVVM 패턴은, MVC 가 가지고 있던 기능 요소의 분리라는 장점에, '데이터 연결 (data binding)' 을 통하여 뷰와 뷰 모델의 통신을 자동화할 수 있다는 장점에다가, 프레임웍을 통하여 '획일적인 (boilerplate)' 코드들을 작성할 필요가 없다는 장점을 합친 것입니다.

SwiftUI 프레임웍은 `ObservableObject` 프로토콜 및 `@Published` 와 `@ObservedObject` 라는 '속성 포장' 을 제공하여, 모델과 뷰를 분리하는 MVVM 패턴을 구현하도록 합니다.
개발자는 뷰를 위해 별도의 언어를 익힐 필요 없이 바로 Swift 를 사용하면 되며, 뷰와 뷰 모델은 `@ObservedObject` 를 사용하여 직접 연결됩니다.

뷰와 모델이 분리됨으로써 개발자는 비지니스 로직과 UI 를 나누어서 개발할 수 있으며, 재사용성도 높일 수 있습니다. 혼자서 개발하는 경우라도, UI 는 자주 바뀔 수 있기 때문에, 뷰와 모델을 분리하는 것이 더 생산적일 것입니다. 즉, 모델과 SwiftUI 프레임웍이 가능한 한 많은 작업을 하며,[^business-logic] 뷰를 직접 조작하는 로직은 뷰에서 직접 담당하게 됩니다.

### 참고 자료

[^translate]: 저 이전에 이미 번역된 내용이 있었지만 한 문단만 되어 있기에 전체 내용을 다시 번역했습니다.

[^GUI-code]: 여기서 'GUI 코드로 구현하는 뷰' 라는 것이 'SwiftUI' 관점에서는 `View` 프로토콜을 준수하면서 `var body: some View` 라는 속성을 구현하는 것이라고 볼 수 있습니다.

[^mediator]: **Thinking Different** 님의 [중재자 패턴 (Mediator Pattern)](https://copynull.tistory.com/145) 이라는 글을 보면 중재자 패턴은 M:N 관계를 M:1 관계로 만들어 준다고 하는데, 원문의 내용은 뷰모델이 하나의 모델을 다수의 뷰와 연결시켜 주는 중재자 역할을 하도록 구현할 수 있다는 의미인 것 같습니다.

[^johns-blog]: 원문에서는 분명히 자신의 블로그에 발표했다고 하는데, 링크를 들어가 보면 마이크로소프트의 아카이브로 연결됩니다. 아마도 사내 블로그가 아니었을까 추측합니다.

[^property-wrapper]: '속성 포장 (property wrapper)' 에 대해서는 '스위프트 프로그래밍 언어' 책을 번역한 내용 중에서 [Property Wrappers (속성 포장)]({% link docs/swift-books/swift-programming-language/properties.md %}#property-wrappers-속성-포장) 부분을 보도록 합니다.

[^business-logic]: 모델이 가능한 많은 작업을 한다는 것은 모델이 '비지니스 로직 (business logic)' 을 담당하기 때문이라고 이해할 수 있을 것입니다.
