---
layout: post
title:  "Foundation: NSURL 파싱하기"
date:   2016-06-02 17:00:00 +0900
categories: iOS Framework Foundation NSURL
---

웹 관련 프로그래밍을 하다보면 url에서 특정 부분을 추출해야할 경우가 생깁니다.

예를 들어서, 아래와 같은 웹페이지 주소가 있다고 가정합시다.

```swift
let url = "http://www.myurl.com?param1=value1&param2=value2"
```

위의 주소에서 param1에 해당하는 값(여기서는 value1이 됩니다.)만을 뽑아내야 하는 경우가 있을 수 있습니다.

이 경우에 Foundation에 있는 NSURLComponents 클래스와 이 클래스의 속성들을 사용하면 편리합니다.

NSURLComponents 클래스를 잘 모를 경우에는 NSURL에 저장된 url 주소를 파싱하는 외부 라이브러리를 찾고 있었는데, NSURLComponents 클래스를 사용하면 따로 다른 라이브러리를 사용하지 않아도 Swift에서 url을 쉽게 다룰 수 있음을 발견하게 되었습니다.[^NSURLComponents]

#### **NSURLComponents** class

NSURLComponents 클래스는 `RFC 3986`에 기초하여 URL을 파싱하고, 구성 요소들로 URL을 만드는 용도로 설계된 클래스입니다.

애플의 문서에 따르면 NSURL은 예전 RFC를 따르기 때문에 NSURLComponents와는 동작방식이 조금 다르다고 합니다. 하지만, NSURL과 NSURLComponents는 서로 쉽게 변환할 수 있다고 합니다. 보다 자세한 내용은 애플의 [NSURLComponents Class Reference](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSURLComponents_class/) 를 참고하면 됩니다.

#### **queryItems** property

NSURLComponents 클래스의 queryItems 속성은 URL 요소들을 name/value 쌍의 배열로 저장합니다.  
이 queryItems 속성을 사용하면 url에서 원하는 부분을 name을 키(key)로 해서 찾을 수 있습니다.

#### Sample Code

글의 맨 앞에 나타낸 주소가 있을 경우 `param1`에 해당하는 `value1`를 리턴하는 함수는 다음과 같습니다.

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

마지막으로 값의 추출은 항상 성공하는 것은 아니므로 nil 체크를 통하여 nil일 경우 빈 문자열을 반환하도록 했습니다.

사용할 때는 아래와 같이 하면 됩니다.

```swift
print(ParsingURL(url2))
```


### 고찰 하기

URL을 파싱하기 위한 RFC 및 RFC 3986이 뭔지는 아직 잘 모릅니다. 이 부분은 나중에 기회가 생기면 따로 내용을 업데이트 할 예정입니다.

### 참고 자료

[stackoverflow: Parse NSURL query property](http://stackoverflow.com/questions/3997976/parse-nsurl-query-property)

[^NSURLComponents]: [NSURLComponents Class Reference](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSURLComponents_class/#//apple_ref/occ/instp/NSURLComponents/queryItems)

[Parse NSURL query property](http://www.sellmyapplication.com/question/parse-nsurl-query-property/)

[NSURL 파라미터 파싱하기](https://byunsooblog.wordpress.com/2014/03/16/nsurl-파라미터-파싱하기/comment-page-1/)
