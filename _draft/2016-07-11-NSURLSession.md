NSURLConnection.sendAsynchronousRequest는 deprecated 되었다고 한다. 
NSURLSession.dataTaskWithRequest를 사용하라고 한다.


UIAlertView도 deprecated 되었다, UIAlertController를 사용해야 한다.

### 고찰하기

결국 Alamofire 같은 것을 사용하는 것이 좋다(?)

### 참고 자료

[HTTP Request in Swift with POST method](http://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method)

[세련된 HTTP 프레임워크 Alamofire](http://outofbedlam.github.io/swift/2016/02/04/Alamofire/)

[Alamofire 사용하기](http://rhammer.tistory.com/115)

[Objective-C에서 웹서버로 POST 요청](http://soooprmx.com/wp/archives/4909)

[Swift: How to send a POST Request to a PHP Script](http://www.ios-blog.co.uk/tutorials/swift/swift-how-to-send-a-post-request-to-a-php-script/)