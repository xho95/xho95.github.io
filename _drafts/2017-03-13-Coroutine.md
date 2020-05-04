### 참고 자료 

[What is a coroutine?](http://stackoverflow.com/questions/553704/what-is-a-coroutine)

[Boost.Asio와 C++11. Asio와 코루틴](http://jacking.tistory.com/m/1218)

[코루틴(coroutine) 이해하기](https://gamecodingschool.org/2015/05/16/코루틴coroutine-이해하기/)

[Yielding functions proposal](https://forums.developer.apple.com/thread/18087)

[Mutexes and closure capture in Swift](https://www.cocoawithlove.com/blog/2016/06/02/threads-and-mutexes.html)

나무위키에 있는 [Python](https://namu.wiki/w/Python#rfn-36) 항목의 **멀티스레딩 문제** 부분을 보면 코루틴 (Coroutine) 에 대한 설명이 있습니다. 여기서 코루틴은 이벤트 멀티플렉싱 (event multiplexing) 을 싱글 쓰레드로 처리할 수 있도록 하는 기술로 묘사됩니다. C나 C++ 같은 언어에서 코루틴 지원이 잘 안 되는 이유는, 언어적 차원에서 함수 중간에 실행을 멈추고 다른 함수를 실행할 수 있게 해줘야 하는데 쓰레드 별로 stack이 1개밖에 없는 구조에서는 구현이 어렵기 때문이라고 합니다.

[코루틴의 이해](http://teddy.tistory.com/entry/코루틴의-이해) 라는 글을 보면 코루틴이라는 것은 결국 단일 쓰레드로 멀티 쓰레드를 흉내내는 기술이라고 볼 수 있을 것 같습니다. 