Swift 에서 C 함수를 자기 언어처럼 사용하는 것이 신기해 보일 수 있는데, C++ 에서 C 함수를 사용하는 것처럼 자연스럽게 사용할 수 있는 이유 중의 하나는 Swift 가 태생이 C 계열 언어 (C like Language 또는 [C-family Language](https://en.wikipedia.org/wiki/List_of_C-family_programming_languages)) 이기 때문입니다. [^wikipedia-c-family]

C 계열 언어는 무척 다양한데 프로그래밍 언어로써 가장 유명한 축에 속하는 Java, C++, C#, _JavScript,_ Go, Swift, R 모두 C 계열 언어에 속합니다. [^other-c-family]

그러니 Swift 내에서 C 코드를 사용하는 것이 큰 무리가 없을 것입니다.

뿐만 아니라 지금 현재의 Swift 컴파일러는 C++ 언어로 만들어지고 있습니다. [^swift-cpp] 그렇다보니 C++ 이 그런 것처럼 C 를 해석하는데 큰 무리가 없는 것이 아닐까 추측됩니다.

물론 신생 언어인 Swift 입장에서 사용자 층이 넓으면서 컴파일러 구현이 어렵지 않는 C 를 품으려 했다고도 볼 수 있습니다. 덕분에 Swift 는 나름 임베이드 분야에서도 사용될 수 있지 않을까 생각합니다.

### 참고 자료

[^wikipedia-c-family]: 위키피디아의 [List of C-family programming languages](https://en.wikipedia.org/wiki/List_of_C-family_programming_languages) 라는 글에는 현재까지 개발된 C 계열 언어의 목록이 나와 있습니다.

[^other-c-family]: 그 외에도 웹에서 한 시대를 풍미한 Pearl, PHP, 페이스북에서 만든 Hack, 원래 애플의 주력 언어인 Objective-C 도 C 계열 언어입니다. 현대에 존재하는 모든 프로그래밍 언어는 근본이 함수형 언어가 아닌 이상 C 계열 언어에 속한다고 볼 수 있습니다. _JavaScript 도 C 계열 언어라고 볼 수 있습니다. 이 부분은 좀 더 정리가 필요합니다._

[^swift-cpp]: GitHub 에 있는 Swift 저장소에는 [Frequently Asked Questions about Swift](https://github.com/apple/swift/blob/2c7b0b22831159396fe0e98e5944e64a483c356e/www/FAQ.rst) 라는 FAQ 문서가 있는데, 지금 현재 왜 C++ 로 Swift 를 만드는지에 대한 이유가 나와 있습니다. C# 이 그랬던 것처럼 앞으로 Swift 도 자신의 언어로 직접 컴파일러를 만드는 날이 올 것 입니다.
