---
layout: post
title:  "Framework: NSURL 파싱하기"
date:   2016-06-02 17:00:00 +0900
categories: iOS Framework Foundation NSURL
---

여기서는 Swift에서 URL을 파싱하는 방법에 대해서 설명합니다.

Swift에서는 URL을 사용하기 위해 Foundation 프레임웍에 있는 NSURL을 사용합니다.
NSURL을 사용하여 URL을 다루다보면 URL중에서 특정 부분만을 걸러내고 싶을 때가 있습니다.

처음에는 NSURL에 저장된 url 주소를 파싱하는 라이브러리를 찾고 있었는데, NSURLComponents 클래스의 `queryItems` 라는 property를 사용하면 된다는 것을 알게되었습니다.[^NSURLComponents]

#### NSURLComponents class

NSURLComponents 클래스는 `RFC 3986`에 기초하여 URL을 파싱하고, 그것의 구성 요소들로 URL을 만들기 위해 설계된 클래스입니다.[^NSURLComponents] 애플의 문서에 따르면 NSURL은 예전 RFC를 따르기 때문에 NSURLComponents와는 동작방식이 조금 다르다고 합니다. 하지만, NSURL과 NSURLComponents는 서로 쉽게 변환할 수 있다고 합니다. 보다 자세한 내용은 애플의 [NSURLComponents Class Reference](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSURLComponents_class/) 를 참고하면 될 것 같습니다.

#### **queryItems** property

NSURLComponents의 queryItems 속성은 URL 요소들을 이름, 값 쌍의 배열로 저장합니다.  
이중에서 원하는 부분을 이름을 통해서

#### Sample Code

"http://www.myurl.com?param1=value1&param2=value2" 이라는 주소가 있을 경우 `param2`에 해당하는 `value2`를 리턴하는 함수는 다음과 같습니다.

```swift
import Foundation

func ParsingURL(url: String) -> String {
    let urlComponents = NSURLComponents(string: url)
    let queryItems = urlComponents?.queryItems
    let param = queryItems?.filter({$0.name == "param1"}).first

    let value = param?.value ?? ""

    return value
}

let url2 = "http://www.myurl.com?param1=value1&param2=value2"

print(ParsingURL(url2))
```

### 고찰 하기

### 참고 자료

[stackoverflow: Parse NSURL query property](http://stackoverflow.com/questions/3997976/parse-nsurl-query-property)

[^NSURLComponents]: [NSURLComponents Class Reference](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSURLComponents_class/#//apple_ref/occ/instp/NSURLComponents/queryItems)

[Parse NSURL query property](http://www.sellmyapplication.com/question/parse-nsurl-query-property/)

[NSURL 파라미터 파싱하기](https://byunsooblog.wordpress.com/2014/03/16/nsurl-파라미터-파싱하기/comment-page-1/)
