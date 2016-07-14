## HTTP로 POST 요청하기

### NSURLSession

NSURLConnection은 deprecated 되었다고 합니다. 따라서 sendAsynchronousRequest는 쓸 수 없으며, 대신 NSURLSession의 dataTaskWithRequest를 사용해야 합니다.[^rhammer]

NSURLSession 및 그 사용법에 대해서는 RayWenderlich 사이트의 예제를 참고하면 좋습니다.[^RayWenderlich] 고무망치님이 블로그에 해당 내용을 한글로 번역해 놓았습니다.[^NSURLSession_rhammer]

### 고찰하기

결국 간단한 프로그래밍이 아니라면 HTTP 통신 프로그래밍을 하려면 Alamofire 같은 외부 라이브러리를 사용하는 것이 좋을지도 모르겠습니다.[^Alamofire]

하지만, 외부 라이브러리를 사용하더라도 처음부터 사용하는 것보다 OS 프레임웍을 이해하고나서 사용하는 것이 좋을 것입니다.

### 참고 자료

[HTTP Request in Swift with POST method](http://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method)

[세련된 HTTP 프레임워크 Alamofire](http://outofbedlam.github.io/swift/2016/02/04/Alamofire/)

[^Alamofire]: [Alamofire 사용하기](http://rhammer.tistory.com/115)

[Objective-C에서 웹서버로 POST 요청](http://soooprmx.com/wp/archives/4909)

[Swift: How to send a POST Request to a PHP Script](http://www.ios-blog.co.uk/tutorials/swift/swift-how-to-send-a-post-request-to-a-php-script/)

[^rhammer]: NSURLSession과 NSURLConnection의 차이점에 대해서는 [NSURLConnection이 deprecated되었기에 우리는..](http://rhammer.tistory.com/100)이라는 [고무망치님의 블로그](http://rhammer.tistory.com) 글에 정리가 잘 되어있다.

[^RayWenderlich]: [NSURLSession Tutorial: Getting Started](https://www.raywenderlich.com/110458/nsurlsession-tutorial-getting-started)

[^NSURLSession_rhammer]: [NSURLSession 사용 가이드](http://rhammer.tistory.com/113)