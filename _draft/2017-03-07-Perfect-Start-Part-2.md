이전에 이어서 나머지 부분을 정리하도록 합니다. 

#### Router 추가하기

**main.swift** 에 다음과 같이 추가합니다. 

```swift
var routes = Routes()

routes.add(method: .get, uri: "/", handler: {
	request, response in
	response.setBody(string: "Hello, Perfect!")
		.completed()
})

server.addRoutes(routes)
``` 

빌드하고 실행해 봅니다. 브라우저에서 `localhost:8080/` 으로 접속하면 다음과 같이 나타나는 것을 볼 수 있습니다. 

```txt
Hello, Perfect!
```

#### JSON API 추가하기

```swift
func returnJSONMessage(message: String, response: HTTPResponse) {
	do {
		try response.setBody(json: ["message": message])
			.setHeader(.contentType, value: "application/json")
			.completed()
	} catch {
		response.setBody(string: "Error handling request: \(error)")
			.completed(status: .internalServerError)
	}
}

routes.add(method: .get, uri: "/hello", handler: {
	request, response in 
	returnJSONMessage(message: "Hello, JSON!", response: response)
})
```

빌드하고 실행해 봅니다. 브라우저에서 `localhost:8080/hello` 로 접속하면 다음과 같이 JSON 결과를 볼 수 있습니다. 

```txt
{"message":"Hello, JSON!"}
```

다른 JSON 추가하기

```swift
routes.add(method: .get, uri: "/hello/there", handler: {
  request, response in
  returnJSONMessage(message: "I'm tired of saying hello!", response: response)
})
```

#### 매개 변수를 받아서 JSON 으로 출력하기

소스는 복사해옵니다. 

```swift
routes.add(method: .get, uri: "/beers/{num_beers}", handler: {
  request, response in
  guard let numBeersString = request.urlVariables["num_beers"], let numBeersInt = Int(numBeersString) else {
    response.completed(status: .badRequest)
    return
  }

  returnJSONMessage(message: "Take one down, pass it around, \(numBeersInt - 1) bottles of beer on the wall...", response: response)
})
```

어쨌든 됩니다. 

#### POST 수행하기

소스는 복사해옵니다.

```
routes.add(method: .post, uri: "post", handler: {
  request, response in
  guard let name = request.param(name: "name") else {
    response.completed(status: .badRequest)
    return
  }

  returnJSONMessage(message: "Hello, \(name)!", response: response)
})
```

리눅스에서 어떻게 테스트할 수 있는지 알아봅니다. 

테스트는 Firefox 에 RESTED 라는 Add on을 설치해서 할 수 있습니다. 

```txt
{
	"message": "Hello, xho95!"
}
```

### 참고 자료

