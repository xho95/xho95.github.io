---
layout: post
comments: true
title:  "Concurrency (동시성)"
date:   2021-06-10 11:30:00 +0900
categories: Swift Language Grammar Concurrency
---

{% include header_swift_book.md %}

# {{ page.title }}

스위프트는 비동기 및 병렬 코드를 구조적인 방식으로 작성하는 걸 내장 지원합니다.[^built-in-support] _비동기 코드 (asynchronous code)_ 는 잠시 멈췄다 나중에 다시 할 수 있으나, 한번에 한 조각의 프로그램만 실행합니다. 프로그램 안의 코드를 잠시 멈췄다 다시 하는 건 오래-걸리는 연산인 네트웍 너머로 데이터를 가져오거나 파일 구문의 해석 등을 하는 동안 단-기간 연산인 **UI** 업데이트 같은 것도 계속 진행하도록 해줍니다. _병렬 코드 (parallel code)_ 는 여러 개의 코드 조각을 동시에 실행한다는 걸 의미합니다-예를 들어, 코어 프로세서가 4-개인 컴퓨터는, 각각의 코어마다 하나의 임무를 실시하여, 동시에 네 개의 코드 조각을 실행할 수 있습니다. 병렬 및 비동기 코드를 쓴 프로그램은 한번에 여러 개의 연산을 실시하며; 외부 시스템을 기다리는 연산은 잠시 멈추고, 이 코드를 메모리-안전하게 작성하는 걸 더 쉽도록 합니다.

병렬 및 비동기 코드에서 추가되는 스케줄링[^scheduling] 의 유연함은 복잡도 증가라는 비용이 따라 옵니다. 스위프트는 의도를 표현해서 컴파일-시간 검사를 할 수 있게 하는 방식입니다-예를 들어, 행위자 (actors)[^actors] 를 쓰면 변경 가능한 상태 (mutable state) 에 안전하게 접근할 수 있습니다. 하지만, 느리거나 버그있는 코드에 동시성을 추가한다는게 빨라지거나 올바로 된다는 걸 보증하진 않습니다. 사실, 동시성을 추가하는 건 심지어 코드 디버깅을 더 어렵게 만들지도 모릅니다. 하지만, 동시성이 필요한 코드에 스위프트의 언어-수준 동시성을 사용하는 건 스위프크가 컴파일 시간에 문제를 잡아내도록 도와줄 수 있다는 걸 의미합니다.

이 장 나머지에선 이 일반적으로 흔한 비동기 및 병렬 코드 조합을 가리키는데 _동시성 (concurrency)_ 이란 용어를 사용합니다.

> 전에 동시성 코드를 작성해봤으면, 쓰레드를 쓰는게 익숙할지도 모릅니다. 스위프트의 동시성 모델은 쓰레드 위에서 제작된 것이지만, 우리가 이걸 직접 쓰는 건 아닙니다.[^threads] 스위프트의 비동기 함수는 자신이 실행되고 있는 쓰레드를 포기할 수 있으며, 첫 번째 함수가 차단된 동안 그 쓰레드에서 또 다른 비동기 함수가 실행되도록 해줍니다.
{: .note }

동시성 코드의 작성은 스위프트 언어가 지원하는 걸 쓰지 않고도 가능하지만, 그 코드는 더 읽기 힘든 경우가 많습니다. 예를 들어, 다음 코드는 사진 이름 목록을 내려받고, 그 목록의 첫 번째 사진을 내려받아서, 사용자에게 그 사진을 보여줍니다:

```swift
listPhotos(inGallery: "Summer Vacation") { photoNames in
  let sortedNames = photoNames.sorted()
  let name = sortedNames[0]
  downloadPhoto(named: name) { photo in
    show(photo)
  }
}
```

심지어 이런 단순한 경우라도, 코드에선 연속된 완료 처리자[^completion-handlers] 를 써야 하기 때문에, 중첩 클로저를 쓰게 됩니다. 이런 스타일에선, 코드가 더 복잡해져 중첩이 깊어지면 다루기가 급격히 어려워질 수 있습니다. 

### Defining and Calling Asynchronous Functions (비동기 함수 정의하고 호출하기)

_비동기 함수 (asynchronous function)_ 나 _비동기 메소드 (asynchronous method)_ 는 어느 정도 실행한 도중에 잠시 멈출 수 있는 특수한 종류의 함수 또는 메소드 입니다. 이는 평범한, 동기 함수 및 메소드가, 완료까지 실행되거나, 에러를 던지며, 또는 절대로 반환하지 않는 것과, 대조적입니다. 비동기 함수나 메소드도 여전히 이 세 가지들을 하지만, 뭔가를 기다리는 중간에 일시 정지할 수도 있습니다. 비동기 함수나 메소드 본문 안에서, 이렇게 실행을 잠시 멈출 수 있는 곳 각각을 표시합니다.

함수나 메소드가 비동기라고 지시하려면, `async` 키워드를 선언의 매개 변수 뒤에 쓰면 되는데, `throws` 를 써서 던지는 함수를 표시하는 것과 비슷합니다. 함수나 메소드가 값을 반환하면, `async` 를 반환 화살표 (`->`) 앞에 작성합니다. 예를 들어, 전시관에서 사진 이름을 가져오는 건 이럴지 모릅니다:

```swift
func listPhotos(inGallery name: String) async -> [String] {
    let result = // ... 어떤 비동기 네트워킹 코드 ...
    return result
}
```

함수나 메소드가 비동기면서 던지기까지 하면, `async` 를 `throws` 앞에 씁니다.

비동기 메소드를 호출할 땐, 그 메소드가 반환할 때까지 실행이 잠시 멈춥니다. 호출 앞에 `await` 를 써서 잠시 멈춤 가능 지점[^possible-suspension-point] 을 표시합니다. 이는 던지는 함수를 호출할 때 `try` 를 써서, 에러가 있으면 프로그램 흐름이 바뀔 수 있다고 표시하는 것과, 비슷합니다. 비동기 메소드 안에서, 실행 흐름은 또 다른 비동기 메소드를 호출할 때 _만 (only)_ 잠시 멈춥니다-잠시 멈춤은 절대로 암시적이거나 선점 (preemptive)[^preemptive] 이지 않습니다-이는 모든 잠시 멈춤 가능 지점에 `await` 를 표시한다는 걸 의미합니다.

예를 들어, 아래 코드는 전시관에 있는 모든 사진의 이름을 가져온 다음 첫 번째 사진을 보여줍니다:

```swift
let photoNames = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[0]
let photo = await downloadPhoto(named: name)
show(photo)
```

`listPhotos(inGallery:)` 와 `downloadPhoto(named:)` 함수는 둘 다 네트웍 요청이 필요하기 때문에, 상대적으로 긴 시간이 걸려야 완료할 수 있습니다. 이 둘 다 반환 화살표 앞에 `async` 를 써서 비동기로 만들면 이 코드가 사진이 준비되길 기다리는 동안 앱의 나머지 코드가 계속 실행되도록 해줍니다.

위 예제의 동시적 성질을 이해하는, 한 가지 가능한 실행 순서는 이렇습니다: 

1. 코드가 첫째 줄에서 실행을 시작해서 첫 번째 `await` 까지 실행합니다. `listPhotos(inGallery:)` 함수를 호출하고 그 함수의 반환을 기다리는 동안 실행이 잠시 멈춥니다.
2. 이 코드의 실행을 잠시 멈춘 동안, 같은 프로그램에 있는 다른 동시성 코드를 실행합니다. 예를 들어, 아마 오래-걸리는 백그라운드 임무가 새로운 사진 전시관의 목록을 계속 업데이트할 수도 있을 겁니다. 그 코드도, `await` 로 표시된, 그 다음 잠시 멈춤 지점까지나, 완료 때까지 실행합니다.
3. `listPhotos(inGallery:)` 의 반환 후에, 이 코드는 그 지점에서 계속 실행합니다. 이는 반환된 값을 `photoNames` 에 할당합니다.
4. `sortedNames` 와 `name` 을 정의하는 줄은 표준적인, 동기 코드입니다. 이 줄엔 아무런 `await` 표시도 없기 때문에, 어떤 잠시 멈춤 가능 지점도 없습니다.
5. 그 다음 `await` 표시는 `downloadPhoto(named:)` 함수의 호출에 있습니다. 이 코드는 다시 그 함수의 반환 때까지 실행을 일시 정지하여, 다른 동시성 코드가 실행될 기회를 줍니다.
6. `downloadPhoto(named:)` 의 반환 후에, 그 반환 값은 `photo` 에 할당된 다음 `show(_:)` 의 호출 때 인자로 전달됩니다.

코드에서 `await` 로 표시된 잠시 멈춤 가능 지점은 비동기 함수나 메소드가 반환하길 기다리는 동안 현재 코드 조각이 일시 정지할지도 모른다고 지시합니다. 이를 _쓰레드 넘겨주기 (yielding the thread)_ 라고도 하는데, 그 속을 보면, 스위프트가 현재 쓰레드에 대한 코드 실행을 잠시 멈추고 그 쓰레드에서 다른 코드를 대신 실행하기 때문입니다. `await` 가 있는 코드는 실행을 잠시 멈출 수 있어야 하기 때문에, 프로그램의 특정한 곳에서만 비동기 함수나 메소드를 호출할 수 있습니다:

* 비동기 함수나, 메소드, 또는 속성의 본문 안에 있는 코드
* `@main` 으로 표시된 구조체나, 클래스, 또는 열거체의 정적 `main()` 메소드 안에 있는 코드
* 아래의 [Unstructured Concurrency (구조화 안된 동시성)](#unstructured-concurrency-구조화-안된-동시성) 에서 보듯, 따로 떨어진 자식 임무 (detached child task) 안에 있는 코드

잠시 멈춤 가능 지점 사이에 있는 코드는 순차적으로 실행하며, 다른 동시성 코드로부터 방해받을 가능성이 없습니다. 예를 들어, 아래 코드는 사진을 한 전시관에서 다른 곳으로 이동합니다.

```swift
let firstPhoto = await listPhotos(inGallery: "Summer Vacation")[0]
add(firstPhoto, toGallery: "Road Trip")
// 이 순간, firstPhoto 는 일시적으로 두 전시관 모두에 있습니다.
remove(firstPhoto, fromGallery: "Summer Vacation")
```

`add(_:toGallery:)` 와 `remove(_:fromGallery:)` 호출 사이에 다른 코드를 실행할 방법은 없습니다. 그 시간 중에, 첫 번째 사진은 두 전시관 모두에서 나타나며, 일시적으로 앱의 불변성을 깨뜨립니다. 미래에 이 코드 덩어리에 `await` 가 추가되어선 안된다는 걸 더 명확하게 하기 위해, 코드를 동기 함수로 리팩토링할 수도 있습니다:

```swift
func move(_ photoName: String, from source: String, to destination: String) {
    add(photoName, toGallery: destination)
    remove(photoName, fromGallery: source)
}
// ...
let firstPhoto = await listPhotos(inGallery: "Summer Vacation")[0]
move(firstPhoto, from: "Summer Vacation", to: "Road Trip")
```

위 예제에선, `move(_:from:to:)` 가 동기 함수이기 때문에, 절대로 잠시 멈춤 가능 지점이 담길 수 없다는 걸 보증합니다. 미래에, 이 함수에 동시성 코드를 추가하려고, 잠시 멈춤 가능 지점을 도입하면, 버그가 나타나는 대신 컴파일-시간 에러를 가지게 됩니다.

> [Task.sleep(_:)](https://developer.apple.com/documentation/swift/task/3814836-sleep) 메소드는 단순한 코드 작성으로 동시성이 어떻게 작업하는지 배우고자 할 때 유용합니다. 이 메소드는 아무 것도 하지 않지만, 반환 전에 적어도 주어진 나노 초 만큼을 기다립니다. `sleep(until:tolerance:clock:)` 을 써서 네트웍 연산이 기다리는 걸 모의 실험하는 버전의 `listPhotos(inGallery:)` 함수는 이렇습니다:
>
```swift
func listPhotos(inGallery name: String) async -> [String] {
  await Task.sleep(2 * 1_000_000_000)  // 2초
  return ["IMG001", "IMG99", "IMG0404"]
}
```
{: .note }

### Asynchronous Sequences (비동기 시퀀스)

이전 절에 있는 `listPhotos(inGallery:)` 함수는, 배열의 모든 원소가 준비된 후, 한꺼번에 비동기로 배열 전체를 반환합니다. 또 다른 접근법은 _비동기 시퀀스 (asynchronous sequence)_[^sequence] 를 써서 한번에 집합체 한 원소씩 기다리는 겁니다. 비동기 시퀀스의 반복을 보면 이렇습니다:

```swift
import Foundation

let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
  print(line)
}
```

평범한 `for`-`in` 반복문을 쓰는 대신, 위 예제에선 `for` 뒤에 `await` 를 씁니다. 비동기 함수나 메소드의 호출 때 같이, `await` 를 쓰면 잠시 멈춤 가능 지점을 지시합니다. `for`-`await`-`in` 반복문은, 그 다음 원소를 쓸 수 있을 때까지, 각 회차의 맨 앞에서 실행을 잠시 멈추고 기다릴 수가 있습니다.

자신만의 타입을 `for`-`in` 반복문에서 쓰려면 [Sequence](https://developer.apple.com/documentation/swift/sequence) 프로토콜을 따르게 하면 되는 것과 같이, 자신만의 타입을 `for`-`await`-`in` 반복문에서 쓰려면 [AsyncSequence](https://developer.apple.com/documentation/swift/asyncsequence) 프로토콜을 따르도록 하면 됩니다. 

### Calling Asynchronous Functions in Parallel (비동기 함수를 병렬로 호출하기)

비동기 함수를 `await` 로 호출하면 한번에 한 조각의 코드만 실행합니다. 비동기 코드를 실행하는 동안, 호출한 쪽은 그 다음 줄 코드로 실행을 이동하기 전에 그 코드가 마치길 기다립니다. 예를 들어, 전시관에서 첫 세 개의 사진을 가져오려고, 다음 처럼 `downloadPhoto(named:)` 함수의 호출을 세 번 기다릴 수도 있을 겁니다:

```swift
let firstPhoto = await downloadPhoto(named: photoNames[0])
let secondPhoto = await downloadPhoto(named: photoNames[1])
let thirdPhoto = await downloadPhoto(named: photoNames[2])

let photos = [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

이 접근법에는 중요한 결함이 있는데: 내려받기는 비동기라 진행하는 동안 다른 작업이 발생하게 하지만, `downloadPhoto(named:)` 호출은 한번에 하나만 실행된다는 겁니다. 각각의 사진을 완전히 내려받아야 그 다음 걸 내려받기 시작합니다. 하지만, 이 연산은 기다릴 필요가 없습니다-각각의 사진은 독립적으로, 또는 심지어 동시에, 내려받을 수 있습니다.

비동기 함수를 호출해서 그 주변 코드와 병렬로 실행하게 하려면, 상수를 정의할 때 `async` 를 `let` 앞에 쓴 다음, 그 상수를 사용할 때마다 `await` 를 씁니다.

```swift
async let firstPhoto = downloadPhoto(named: photoNames[0])
async let secondPhoto = downloadPhoto(named: photoNames[1])
async let thirdPhoto = downloadPhoto(named: photoNames[2])

let photos = await [firstPhoto, secondPhoto, thirdPhoto]
show(photos)
```

이 예제에서, 세 개의 `downloadPhoto(named:)` 호출 모두는 이전게 완료되길 기다리지 않고 시작합니다. 시스템 자원을 충분히 쓸 수 있다면, 이를 동시에 실행할 수 있습니다. 이 함수 호출엔 아무데도 `await` 가 표시되지 않았는데 이는 함수의 결과를 기다릴려고 코드를 잠시 멈추지 않기 때문입니다. 그 대신, `photo` 가 정의된 줄까지 계속 실행합니다-그 시점에서는, 프로그램이 이 비동기 호출을 한 결과가 필요하므로, `await` 를 써서 세 장의 사진 내려받기를 모두 끝낼 때까지 실행을 일시 정지합니다.

이 두 접근법 사이의 차이점을 생각해보면 이렇습니다:

* 비동기 함수를 `await` 로 호출하는 건 다음 줄의 코드가 그 함수의 결과에 의존할 때입니다. 이는 순차적으로 실시할 작업을 생성합니다.
* 비동기 함수를 `async`-`let` 으로 호출하는 건 코드가 나중이 돼서야 결과가 필요할 때입니다. 이는 병렬로 실시할 수 있는 작업을 생성합니다.
* `await` 와 `async`-`let` 둘 다 자신이 잠시 멈춘 동안 다른 코드를 실행하는걸 허용합니다.
* 두 경우 모두, 잠시 멈춤 가능 지점을 `await` 로 표시하여, 필요하다면, 비동기 함수가 반환했을 때까지, 실행이 일시 정지될 걸 지시합니다.

같은 코드 안에서 이 접근법 둘 다를 섞을 수도 있습니다.

### Tasks and Task Groups (임무와 임무 그룹)

_임무 (task)_ 는 프로그램 일부에서 비동기로 실행할 수 있는 작업의 단위입니다. 모든 비동기 코드는 어떤 임무의 일부로 실행됩니다. 이전 절에서 설명한 `async`-`let` 구문은 자식 임무를 생성합니다. 임무 그룹을 생성해서 그 그룹에 자식 임무를 추가할 수도 있는데, 이러면 중요도 설정 및 취소 작업을 더 잘 제어할 수 있으며, 동적 개수의 임무도 생성하게 해줍니다.

임무는 계층 구조로 배열됩니다. 임무 그룹 안의 각 임무엔 똑같은 부모 임무가 있으며, 각각의 임무에도 자식 임무가 있을 수 있습니다. 임무와 임무 그룹 사이의 관계를 명시하기 때문에, 이 접근법을 _구조화된 동시성 (structured concurrency)_ 이라고 합니다. 올바로 해야하는 것의 일부는 직접 책임져야 하지만, 임무 사이의 명시적 부모-자식 관계는 스위프트가 취소 전파와 같은 일부 동작을 처리하게 해주며, 일부 에러도 스위프트가 컴파일 시간에 탐지하도록 해줍니다.

```swift
await withTaskGroup(of: Data.self) { taskGroup in
  let photoNames = await listPhotos(inGallery: "Summer Vacation")
  for name in photoNames {
    taskGroup.async { await downloadPhoto(named: name) }
    }
}
```

임무 그룹에 대한 더 많은 정보는, [TaskGroup](https://developer.apple.com/documentation/swift/taskgroup) 를 보기 바랍니다.

#### Unstructured Concurrency (구조화 안된 동시성)

이전 절에서 설명한 동시성에 대한 구조화된 접근법에 더해, 스위프트는 구조화 안된 동시성도 지원합니다. 임무가 임무 그룹의 일부인 것과 달리, _구조화 안된 임무 (unstructured task)_ 엔 부모 임무가 없습니다. 구조화 안된 임무는 프로그램에 필요한 무슨 방식으로든 완전히 유연하게 관리할 수 있지만, 이를 올바르게 하는 것도 완전히 본인 책임입니다. 현재의 행위자 (actor) 에서 실행할 구조화 안된 임무를 생성하려면, [Task.init(priority:operation:)](https://developer.apple.com/documentation/swift/task/3856790-init) 초기자를 호출합니다. 현재 행위자의 일부가 아닌 구조화 안된 임무로, 특히 _따로 떨어진 임무 (detached task)_ 로 더 잘 알려진 걸 생성하려면, [Task.detached(priority:operation:)](https://developer.apple.com/documentation/swift/task/3856786-detached) 클래스 메소드를 호출합니다. 이 두 연산 모두 상호 작용할 수 있는 임무를 반환하여-예를 들어, 그 결과를 기다리거나 취소하게 합니다.

```swift
let newPhoto = // ... 어떤 사진 자료 ...
let handle = async {
  return await add(newPhoto, toGalleryNamed: "Spring Adventures")
}
let result = await handle.get()
```

따로 떨어진 임무를 관리하는 것에 대한 더 많은 정보는, [Task](https://developer.apple.com/documentation/swift/task/) 를 보기 바랍니다.

#### Task Cancellation (임무 취소)

스위프트 동시성은 협동 취소 모델[^cooperative-cancellation-model] 을 사용합니다. 각각의 임무는 자신이 취소됐는지 적절한 실행 시점에 검사하여, 적절한 무슨 방식으로든 취소에 응답합니다. 하고 있던 작업에 따라, 이는 대체로 다음 중 하나를 의미합니다:

* `CancellationError` 같은 에러를 던짐
* `nil` 또는 빈 집합체[^collection] 를 반환함
* 부분적으로 완료된 작업을 반환함

취소를 검사하려면, [Task.checkCancellation()](https://developer.apple.com/documentation/swift/task/3814826-checkcancellation) 을 호출하여, 임무가 취소됐으면 `CancellationError` 를 던지거나, [Task.isCancelled](https://developer.apple.com/documentation/swift/task/3814832-iscancelled) 값을 검사하여 자신만의 코드로 취소를 처리합니다. 예를 들어, 전시관에서 사진을 내려받는 임무라면 부분적으로 내려받은 걸 삭제하고 네트웍 연결은 닫아야 할지도 모릅니다.

취소를 수동으로 퍼뜨리려면, [Task.cancel()](https://developer.apple.com/documentation/swift/task/handle/3814781-cancel) 을 호출합니다.

### Actors (행위자)

임무를 써서 프로그램을 격리된, 동시적 조각들로 다 끊어 놓을 수 있습니다. 임무는 서로 격리되어 있어서, 동시에 실행해도 안전하지만, 일부 정보를 임무 사이에 공유하는게 필요할 때도 있습니다. 행위자는 동시성 코드 사이에 정보를 공유하는 걸 안전하게 해줍니다.

클래스 같이, 행위자도 참조 타입이라서, [Classes Are Reference Types (클래스는 참조 타입입니다)]({% link docs/swift-books/swift-programming-language/structures-and-classes.md %}#classes-are-reference-types-클래스는-참조-타입입니다) 에서 값 타입과 참조 타입을 비교한게 클래스뿐 아니라 행위자에도 적용됩니다. (하지만) 클래스와 달리, 행위자는 자신의 변경 가능한 상태에 한번에 한 임무만 접근을 허용하는데, 이는 여러 개의 임무 코드가 똑같은 행위자 인스턴스와 상호 작용하는 걸 안전하게 합니다. 예를 들어, 온도를 기록하는 행위자는 이렇습니다:

```swift
actor TemperatureLogger {
  let label: String
  var measurements: [Int]
  private(set) var max: Int

  init(label: String, measurement: Int) {
    self.label = label
    self.measurements = [measurement]
    self.max = measurement
  }
}
```

행위자는 `actor` 키워드와, 그 뒤의 한 쌍의 중괄호 안에 있는 정의로 도입합니다.[^actor-definition] `TemperatureLogger` 행위자엔 행위자 밖의 코드에서 접근할 수 있는 속성들이 있고, `max` 속성은 행위자 안의 코드만 최대 값을 업데이트할 수 있게 제약합니다.

행위자의 인스턴스를 생성하는데는 구조체 및 클래스와 똑같은 초기자 구문을 씁니다. 행위자의 속성이나 메소드에 접근할 땐, `await` 를 써서 잠시 멈출 수도 있는 지점을 표시합니다-예를 들면 다음과 같습니다:

```swift
let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
print(await logger.max)
// "25" 를 인쇄함
```

이 예제에선, `logger.max` 로 접근하는게 잠시 멈춤 가능 지점입니다. 행위자는 한번에 한 임무만 변경 가능한 상태에 접근하는 걸 허용하기 때문에, 다른 임무의 코드가 이미 기록자와 상호 작용 중이면, 이 코드를 잠시 멈추고 속성에 접근하는 걸 기다립니다.

이와 대조하여, 행위자 안의 코드는가 행위자의 속성에 접근할 땐 `await` 를 쓰지 않습니다. 예를 들어, `TemperatureLogger` 를 새 온도로 업데이트하는 메소드는 이렇습니다:

```swift
extension TemperatureLogger {
  func update(with measurement: Int) {
    measurements.append(measurement)
    if measurement > max {
      max = measurement
    }
  }
}
```

`update(with:)` 메소드는 이미 행위자에서 실행하고 있는 중이므로[^on-the-actor], `max` 같은 속성에 접근하는데 `await` 를 표시하진 않습니다. 이 메소드는 행위자가 왜 한번에 한 임무만 변경 가능한 상태와 상호 작용하도록 하는지 그 이유도 보여주는데: 행위자의 상태를 업데이트하면 일시적으로 불변성[^invariants] 을 깨뜨립니다. `TemperatureLogger` 행위자는 온도 및 최대 온도를 추적하면서, 새로운 측정 값을 기록할 때 최대 온도를 업데이트합니다. 새 측정 값을 덧붙였으나 `max` 는 업데이트하기 전인, 업데이트 중간엔, 온도 기록 (TemperatureLogger) 이 일시적으로 일관성이 없는 상태입니다. 여러 개의 임무가 동시에 똑같은 인스턴스와 상호 작용하는 걸 막으면 다음 사건과 같은 일련의 문제들을 막아줍니다:

1. 코드에서 `update(with:)` 메소드를 호출합니다. 이는 첫 번째로 `measurement` 배열을 업데이트합니다.
2. 코드에서 `max` 를 업데이트하기 전, 다른 곳의 코드에서 최대 값과 온도 배열을 읽습니다.
3. 코드에서 `max` 를 바꿔서 업데이트를 마칩니다.

이 경우, 다른 곳의 실행 코드는 잘못된 정보를 읽게 되는데 행위자로의 접근이 끼어든게 데이터가 일시적으로 무효인 `update(with:)` 호출 중간이기 때문입니다. 이 문제는 스위프트 행위자를 쓸 땐 막을 수 있으며 이는 자신의 상태에 대해 한번에 하나의 연산만 허용하기 때문이고, 코드를 방해할 수 있는 곳도 `await` 로 표시한 잠시 멈춤 지점뿐이기 때문입니다. `update(with:)` 엔 어떤 잠시 멈춤 지점도 담겨 있지 않기 때문에, 아무 코드도 업데이트 중간에 데이터에 접근할 수 없습니다.

이러한 속성을 행위자 밖에서 접근하려고, 클래스의 인스턴스에서 하듯이 하면, 컴파일-시간 에러를 갖게 됩니다. 예를 들면 다음과 같습니다:

```swift
print(logger.max)  // 에러
```

`logger.max` 에 `await` 를 쓰지않고 접근하면 실패인데 이는 행위자의 속성이 그 행위자의 격리된 지역 상태 (isolated local state) 의 일부이기 때문입니다. 스위프트는 행위자 안의 코드만 행위자의 지역 상태에 접근할 수 있다는 걸 보증합니다. 이 보증을 _행위자 격리 (actor isolation)_ 라고 합니다.

### Sendable Types (보내기 가능한 타입)

임무와 행위자는 프로그램을 동시에 안전하게 실행할 수 있는 조각들로 나누게 해줍니다. 임무나 행위자 인스턴스 안에서, 변경 가능한 상태를 담은 프로그램 부분인, 변수와 속성 같은 걸, _동시성 영역 (concurrency domain)_ 이라 합니다. 어떤 종류의 데이터는 동시성 영역 사이에 공유가 안되는데, 그 데이터가 변경 가능한 상태를 담고 있지만, 접근이 겹치는 걸 보호하진 않기 때문입니다.

한 동시성 영역에서 또 다른 곳으로 공유할 수 있는 타입을 _보내기 가능한 (sendable)_ 타입이라고 합니다. 예를 들어, 이는 행위자의 메소드를 호출할 때 인자로 전달되거나 임무의 결과로 반환될 수 있습니다. 이 장 앞에 있는 예제에선 보내기 가능성을 논의하지 않았는데 그 예제들은 단순한 값 타입을 쓰고 있어서 동시성 영역 사이에 전달된 데이터를 공유하는게 항상 안전하기 때문입니다. 이와 대조하여, 어떤 타입은 동시성 영역을 가로질러 전달하는게 안전하지 않습니다. 예를 들어, 변경 가능한 속성을 담고 있는 클래스가 그 속성으로의 접근을 직렬화하지 않은 경우 그 클래스의 인스턴스를 서로 다른 임무들에 전달할 때 예측 불가능한 잘못된 결과를 만들어 낼 수 있습니다.

보내기 가능한 타입이라고 표시하려면 `Sendable` 프로토콜을 따르도록 선언하면 됩니다. 그 프로토콜엔 어떠한 코드 필수 조건도 없지만, 의미 상의 필수 조건이 있어서 스위프트가 강제합니다. 일반적으로, 타입이 보내기 가능하려면 세 가지 방법이 있습니다:

* 타입이 값 타입이며, 자신의 변경 가능 상태가 보내기 가능한 데이터로 이루어진 경우-예를 들어, 구조체인데 저장 속성이 보내기 가능하거나 열거체인데 결합 값이 보내기 가능한 경우.
* 타입에 어떠한 변경 가능 상태도 없으며, 자신의 변경 불가 상태가 보내기 가능한 데이터로 이루어진 경우-예를 들어, 구조체나 클래스에 읽기-전용 속성만 있는 경우.
* 타입에 변경 가능한 상태의 안전을 보장하는 코드가 있는, `@MainActor` 를 표시한 클래스이거나 속성으로 접근하는 걸 특별한 쓰레드나 큐로 직렬화한 클래스 같은 경우.

의미 상의 필수 조건에 대한 자세한 목록은, [Sendable](https://developer.apple.com/documentation/swift/sendable) 프로토콜 참고 자료를 보기 바랍니다.

어떤 타입은 항상 보내기 가능한데, 보내기 가능한 속성만 있는 구조체와 보내기 가능한 결합 값만 있는 열거체 같은 것입니다. 예를 들면, 다음과 같습니다:

```swift
struct TemperatureReading: Sendable {
  var measurement: Int
}

extension TemperatureLogger {
  func addReading(from reading: TemperatureReading) {
    measurements.append(reading.measurement)
  }
}

let logger = TemperatureLogger(label: "Tea kettle", measurement: 85)
let reading = TemperatureReading(measurement: 45)
await logger.addReading(frome: reading)
```

`TemperatureReading` 이란 구조체엔 보내기 가능한 속성만 있고, 구조체를 `public` 이나 `@usableFromInline` 로 표시하지 않았기 때문에, 암시적으로 보내기 가능합니다. 구조체가 `Sendable` 프로토콜을 암시적으로 따르게 한 버전은 이렇습니다:[^implied]

```swift
struct TemperatureReading {
  var measurement: Int
}
```

### 다음 글

[Type Casting (타입 변환) >]({% link docs/swift-books/swift-programming-language/type-casting.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [Conccurency](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html) 에서 볼 수 있습니다.

[^built-in-support]: 비동기 및 병렬 코드를 구조적인 방식으로 작성하는 걸 '내장 지원한다 (built-in support)' 는 건 다른 프레임웍을 쓰지 않아도 언어 그 자체로 비동기 및 병렬 코드를 작성할 수 있다는 의미입니다.

[^scheduling]: '스케줄링 (scheduling)' 은 임무를 수행하기 위해 자원을 할당하는 행동을 의미합니다. 병렬 및 비동기 코드를 사용하면 쓰레드를 배분하는 등의 행동을 통해 스케쥴링이 유연하게 바뀌게 됩니다. 스케쥴링에 대한 더 자세한 정보는, 위키피디아의 [Scheduling (computing)](https://en.wikipedia.org/wiki/Scheduling_(computing)) 항목 및 [스케줄링 (컴퓨팅)](https://ko.wikipedia.org/wiki/스케줄링_(컴퓨팅)) 항목을 참고하기 바랍니다.

[^threads]: 쓰레드는 스위프트 내부에서 사용되며, 우리는 쓰레드를 써서 제작된 '동시성 (concurrency)' 을 쓰는 것입니다.

[^possible-suspension-point]: '잠시 멈춤 가능 지점 (the possible suspension point)' 는 스위프트가 '쓰레드 넘겨주기 (yielding the thread)' 를 하는 지점입니다. 더 자세한 내용은 본문에서 계속 설명합니다.

[^preemptive]: '선점 (preemptive)' 이란 운영체제가 우선 순위에 따라 프로세스의 **CPU** 자원을 강제로 빼앗을 수 있는 방식을 의미합니다. 스위프트의 동시성은 비선점 방식입니다. 선점에 대한 더 자세한 정보는, 위키피디아의 [Preemption (computing)](https://en.wikipedia.org/wiki/Preemption_(computing)) 항목과 [선점 스케줄링](https://ko.wikipedia.org/wiki/선점_스케줄링) 항목을 참고하기 바랍니다.

[^sequence]: '시퀀스 (sequence)' 는 수학에서의 '수열' 을 의미하며, 자료 구조에서는 '같은 타입의 값들이 순차적으로 붙어서 나열된 구조' 를 의미합니다. 시퀀스에 대한 더 자세한 정보는, 위키피디아의 [Sequential access](https://en.wikipedia.org/wiki/Sequential_access) 항목과 [순차 접근](https://ko.wikipedia.org/wiki/순차_접근) 항목을 보도록 합니다. 

[^cooperative-cancellation-model]: '협동 취소 모델 (cooperative cancellation model)' 은 부모 임무를 취소할 경우 자신의 모든 자식 임무에게 자신이 취소됐음을 알리는 방식을 의미합니다. 이에 대한 더 자세한 내용은, [Alexito's World](https://alejandromp.com) 님의 [The importance of cooperative cancellation](https://alejandromp.com/blog/the-importance-of-cooperative-cancellation/) 항목을 보도록 합니다. 

[^on-the-actor]: `update(with:)` 메소드는 행위자의 멤버이므로, 그 행위자에 대해서 실행되고 있는 중입니다.

[^actor-definition]: 사실 행위자는 클래스와 문법이 똑같아서, 상속만 없다면 `class` 키워드를 `actor` 로 바꾸기만 하면 만들 수 있습니다.

[^invariants]: 프로그래밍 분야에서 '불변성 (invariants)' 은 표현식 값이 프로그램 실행 중에 바뀌지 않는 것을 의미합니다. 상수와는 개념이 다릅니다. 불변성에 대한 더 자세한 정보는 위키피디아의 [Invariants in computer science](https://en.wikipedia.org/wiki/Invariant_(mathematics)#Invariants_in_computer_science) 항목을 참고하기 바랍니다.

[^implied]: `TemperatureReading` 구조체는 따로 명시하지 않아도 `Sendable` 프로토콜을 따른다는 의미입니다.
