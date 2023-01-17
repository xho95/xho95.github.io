---
layout: post
pagination: 
  enabled: true
comments: true
title:  "Foundation: NSURLComponents 클래스로 URL 파싱하기"
date:   2016-06-02 17:00:00 +0900
categories: iOS Framework Foundation NSURL
---

Swift로 웹 관련 프로그래밍을 하다보면 url에서 특정 부분을 추출해야할 경우가 생깁니다.

예를 들어서, 아래와 같은 웹페이지 주소가 있다고 가정합시다.

```swift
let url = "http://www.myurl.com?param1=value1&param2=value2"
```

위의 주소에서 param1에 해당하는 값인 value1 만을 뽑아내야 하는 경우가 있을 수 있습니다.

이 경우에 Foundation에 있는 NSURLComponents 클래스와 이 클래스의 속성들을 사용하면 편리합니다. NSURLComponents 클래스를 사용하면 따로 NSURL을 파싱하는 다른 외부 라이브러리를 사용하지 않아도 Swift에서 url을 쉽게 다룰 수 있습니다.[^Alamofire]

### **NSURLComponents** 클래스

NSURLComponents 클래스는 `RFC 3986`에 기초하여 URL을 파싱하고, 구성 요소들로 URL을 만드는 용도로 설계된 클래스입니다.[^NSURLComponents]

애플의 문서에 따르면 NSURL은 예전 RFC를 따르기 때문에 NSURLComponents와는 동작방식이 조금 다르다고 합니다. 하지만, NSURL과 NSURLComponents는 서로 쉽게 변환할 수 있습니다. 보다 자세한 내용은 애플의 [NSURLComponents Class Reference](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSURLComponents_class/) 를 참고하면 됩니다.

#### **queryItems** 속성

NSURLComponents 클래스의 queryItems 속성은 URL 요소들을 name/value 쌍의 배열로 저장합니다. 여기서 name/value 쌍은 NSURLQueryItem 타입입니다.  
이 queryItems 속성을 사용하면 url에서 원하는 부분을 name을 키(key)로 해서 찾을 수 있습니다.

> queryItems가 아니라 query를 사용해서 파싱하는 방법도 있는 것 같습니다만,[^NSURL_query], [^NSURL_query_Parsing] queryItems를 사용하는 것이 더 편한 것 같습니다.[^NSURL_Parsing]

### Sample Code

앞의 url에서 `param1`에 해당하는 `value1`를 리턴하는 함수는 다음과 같습니다.

```swift
import Foundation

func ParsingURL(url: String) -> String {
    let urlComponents = NSURLComponents(string: url)
    let queryItems = urlComponents?.queryItems
    let param = queryItems?.filter({$0.name == "param1"}).first

    let value = param?.value ?? ""

    return value
}
```

위의 코드를 보면 NSURLComponents 클래스를 사용하여 String 형태로 전달된 url을 urlComponents라는 상수에 담고, 이 상수의 queryItems 속성에서 filter를 통하여 param1에 해당하는 값을 추출해 내는 것을 알 수 있습니다.

마지막으로 값의 추출은 항상 성공하는 것은 아니므로 `nil` 인지를 체크하여 `nil` 일 경우 빈 문자열을 반환하도록 합니다.

사용할 때는 아래와 같이 하면 됩니다.

```swift
print(ParsingURL(url2))
```

위의 예제 코드에서 queryItems의 값을 아래와 같이 for-in 범위 반복문으로 출력해보면,

```swift
for item in queryItems! {
    print("[\(item.name) : \(item.value!)]")
}
```

다음과 같은 결과를 얻을 수 있습니다.

```
[param1 : value1]
[param2 : value2]
```

### 고찰 하기

URL을 파싱하기 위한 **RFC** 및 **RFC 3986** 이 무엇인지는 아직 잘 모릅니다. 이 부분은 나중에 따로 내용을 업데이트 할 예정입니다.

Swift 프로그래밍에서는 URL을 다룰 경우에 본문과 같이 Foundation 프레임웍을 직접 사용하기 보다는 Alamofire 같은 외부 라이브러리를 많이 사용하는 것 같습니다. [^Alamofire_RayWenderlich]  [^Alamofire_Tstory] 아직 제가 Alamofire를 직접 사용해 본적은 없지만 상당히 많은 개발자들이 사용하고 있는 것으로 알고 있습니다. 기회가 되면 AAlamofire 사용법에 대해서도 정리하도록 하겠습니다.

### 참고 자료

[^Alamofire]: HTTP 통신 관련하여서 가장 유명한 라이브러리는 [Alamofire](https://github.com/Alamofire/Alamofire)인 것 같습니다. Swift로 만든 오픈 소스 라이브러리이며 GitHub나 CocoaPods을 통해서 설치할 수 있습니다.

[^NSURLComponents]: NSURLComponents 클래스에 대한 설명은 애플의 reference 사이트인 [NSURLComponents Class Reference](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSURLComponents_class/#//apple_ref/occ/instp/NSURLComponents/queryItems) 부분을 참고하시면 됩니다.

[^NSURL_query]: NSURL의 query를 사용해서 url을 파싱하는 방법은 [stackoverflow: Parse NSURL query property](http://stackoverflow.com/questions/3997976/parse-nsurl-query-property) 에 잘 설명되어 있습니다.

[^NSURL_query_Parsing]: [NSURL 파라미터 파싱하기](https://byunsooblog.wordpress.com/2014/03/16/nsurl-파라미터-파싱하기/comment-page-1/)

[^NSURL_Parsing]: [Parse NSURL query property](http://www.sellmyapplication.com/question/parse-nsurl-query-property/) 라는 게시글의 답글을 보다 보면 query를 이용한 경우와 queryItems를 이용한 경우의 다른점이 나오는데, 이를 보고 queryItems를 사용하기로 결정하게 되었습니다.

[^Alamofire_RayWenderlich]: [Alamofire Tutorial: Getting Started](https://www.raywenderlich.com/121540/alamofire-tutorial-getting-started)

[^Alamofire_Tstory]: [Alamofire 사용하기](http://rhammer.tistory.com/115)
