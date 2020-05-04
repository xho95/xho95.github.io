### Asynchronous Socket

C# 에서 async 를 사용하는 것과 .NET Framework 에서 Asynchronous 방식으로 socket 을 사용하는 것의 차이점은 무엇인지 확인이 필요합니다. [^docs-async] [^docs-network] [^docs-server] [^docs-client]

async 는 socket 의 wrapper 인지 확인이 필요합니다.

닷넷 비동기 프로그래밍 방식은 여러가지가 존재한다고 합니다. [^simpleisbest-1] 참고 자료의 두번째 글에 설명되어있습니다.

첫번째 방법은 닷넷 Framework 에서 Begin 으로 시작하는 비동기 버전의 Method 를 호출하는 것입니다.

비동기 호출을 위해서는 호출 종료를 지속적으로 검사하는 Polling 방식과 호출 완료를 알려주는 Callback 방식을 사용할 수 있습니다. [^simpleisbest-2]

Polling 방식에서는 IAsyncResult 객체를 사용하여 호출 종료를 지속적으로 검사해야 합니다. 따라서 CPU 자원을 소모하는 비효율적인 Code 를 양산합니다.

Callback 방식에도 나름 문제가 있습니다. 효율성은 좋지만 Code 가 직관적이지 않고 예외 처리가 쉽지 않습니다. 참고 자료에 설명이 되어 있습니다.

### Async / await

async keyword 는 compiler 에게 method 내부에 await 가 사용되고 있으므로 code 를 비동기 호출 형태로 바꾸라는 지시를 의미합니다. [^simpleisbest-3]

### WCF Asynchronous Operations

참고 자료에 대한 정리가 필요합니다. [^docs-asynchronous] [^docs-event]

### Test

한쪽에서는 Socket 을 열고 한 쪽에서는 Async 를 사용해도 되지 않을까? Test 가 필요합니다.


### 참고 자료

[마이크로 서비스(통합 이벤트) 간 이벤트 기반 통신 구현](https://docs.microsoft.com/ko-kr/dotnet/standard/microservices-architecture/multi-container-microservice-net-applications/integration-event-based-microservice-communications)

[HidSharp](https://www.nuget.org/packages/HidSharp/)

[MQTT Client Library Encyclopedia – M2Mqtt](https://www.hivemq.com/blog/mqtt-client-library-encyclopedia-m2mqtt)

[로봇제어의 핵심, 연구개발전문기업 커미조아](http://www.comizoa.co.kr)

[EtherCAT S/W Master](http://www.comizoa.co.kr/sub/product_view10.php?it_view=1508487846)

[^docs-async]: [Asynchronous programming with async and await (C#)](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/async/)

[^docs-network]: [Network Programming in the .NET Framework](https://docs.microsoft.com/en-us/dotnet/framework/network-programming/)

[^docs-server]: [Asynchronous Server Socket Example](https://docs.microsoft.com/en-us/dotnet/framework/network-programming/asynchronous-server-socket-example)

[^docs-client]: [Asynchronous Client Socket Example](https://docs.microsoft.com/en-us/dotnet/framework/network-programming/asynchronous-client-socket-example)

[^simpleisbest-1]: [간편한 비동기 프로그래밍:async/await (1)](http://www.simpleisbest.net/post/2013/02/06/About_Async_Await_Keyword_Part_1.aspx)

[^simpleisbest-2]: [간편한 비동기 프로그래밍:async/await (2)](http://www.simpleisbest.net/post/2013/02/12/About_Async_Await_Keyword_Part_2.aspx)

[^simpleisbest-3]: [간편한 비동기 프로그래밍:async/await (3)](http://www.simpleisbest.net/post/2013/02/16/About_Async_Await_Keyword_Part_3.aspx)

[^docs-asynchronous]: [Synchronous and Asynchronous Operations](https://docs.microsoft.com/en-us/dotnet/framework/wcf/synchronous-and-asynchronous-operations)

[^docs-event]: [Event-based Asynchronous Pattern Overview](https://docs.microsoft.com/en-us/dotnet/standard/asynchronous-programming-patterns/event-based-asynchronous-pattern-overview)
