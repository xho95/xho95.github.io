## Concurrent Programming With GCD in Swift 3

WWDC 2016의 Concurrent Programming With GCD in Swift 3
 영상을 보고 정리한 글입니다.[^2016_720]

### Concurrency

* maintaining code

#### GCD

#### Dispatch Queues and Run Loops

* Asynchronous Execution
* Synchronous Execution

* 뭐라고 하는지 잘 모르겠습니다.

#### Getting Work Off Your Main Thread

```
let queue = DispatchQueue(label: "com.example.imagetransform")

queue.async {
	...
	
	DispatchQueue.main.async {
		...
	}
}
```


#### Getting Back to Your Main Thread


### Controlling Concurrency

GCD를 사용하는 방식에 대한 내용을 먼저 설명합니다.[^2015_718]

#### Structuring Your Application

* Dispatch Group

```
let group = DispatchGroup()
```

#### Synchronizing Between Subsystems

3번째는 동기화 방식에 대한 내용입니다.

dead lock에 주의해야 합니다. 

### Dispatch Inside Subsystems

#### Choosing a Quality of Service

`Qos` : 이게 뭔지도 모르겠습니다.

`.async`를 사용하여 QoS를 하는 것 같습니다. 

#### DispatchWorkItem

async에 사용할 item을 만들어서 async에 넣어줄 수 있습니다.

#### Waiting for Work Items

`.wait`를 사용하여 나중에 실행해야 함을 알릴 수 있는 것 같습니다.

### Shared State 

#### Swift 3 and Syncronization

동기화(?) Swift 3에 속한 것이 아니라는 의미인지 모르겠습니다.

#### Traditional C Locks in Swift

문제가 많아서 사용하지 않는 것 같습니다.

#### Correct Use

클래스로 구현한 `Foundation.Lock`을 사용하는 것 같습니다.

#### Use GCD for Synchronization

`DispatchQueue.sync(execute:)`을 사용하라고 하는 것 같습니다.

이것을 사용하면 예전 방식에 비해 실수할 확률을 줄인다고 합니다.

#### Preconditions

avoid data corruption : new

```
dispatchPrecondition(.onQueue(expectedQueue))

dispatchPrecondition(.notOnQueue(expectedQueue))
```

#### Object Lifecycle

1. settup
2. `activate`
3. `invalidate`
4. single threaded deallocation

#### Observer Pattern

#### Deallocation

* Abandoned memory
* dead lock

* 이 부분도 잘 모르는 내용이 많이 나옵니다. 나중에 다시 확인해 봐야 할 것 같습니다.

#### Explicit Invalidation

### GCD Object Lifecycle

#### Setup

* attributes and target queue

#### Activation : new

```
extension DispathObject {
	func activate()
}
```

#### Cancellation

#### Deallocation Hygiene

### Summary

use the activate / invalidate pattern


### 참고 자료

[^2015_718]: [WWDC 2015: Building Responsive and Efficient Apps with GCD](https://developer.apple.com/videos/play/wwdc2015/718/)

[^2016_720]: [WWDC 2016 720: Concurrent Programming With GCD in Swift 3](https://developer.apple.com/videos/play/wwdc2016/720/)


