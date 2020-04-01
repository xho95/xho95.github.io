---
layout: post
comments: true
title:  "Swift 5.2: Type Casting ()"
date:   2020-03-31 10:00:00 +0900
categories: Swift Language Grammar Type Casting
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Type Casting](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html) 부분[^Type-Casting]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)](http://xho95.github.io/swift/programming/language/grammar/2017/02/27/The-Swift-Programming-Language.html) 에서 확인할 수 있습니다.

## Type Casting (타입 변환)

_타입 변환 (Type Casting)_ 은 한 인스턴스의 타입을 검사하는 방법 또는, 그 인스턴스가 속한 '클래스 계층 (class hierarchy)' 의 어딘가에 있는 다른 '상위 클래스' 나 '하위 클래스' 로 취급하는 방법을 말합니다.

스위프트의 '타입 변환' 은 `is` 와 `as` 연산자로 구현됩니다. 이 두 연산자는 간단하면서도 이해하기 쉬운 방법으로 값의 타입을 검사하거나 값을 다른 타입으로 변환할 수 있도록 해 줍니다.

'타입 변환' 을 사용하면 그 타입이 프로토콜을 준수하고 있는지도 검사할 수 있으며, 이는 [Checking for Protocol Conformance (프로토콜을 준수하는지 검사하기)](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID283) 에서 설명하도록 합니다.

### Defining a Class Hierarchy for Type Casting (타입 변환을 위한 클래스 계층 정의하기)

'타입 변환 (type casting)' 을 '클래스 및 하위 클래스들의 계층 (hierarchy of classes and subclasses)' 과 같이 사용하면 특정한 클래스 인스턴스의 타입을 검사할 수 있으며 그 인스턴스를 같은 계층 내에 있는 다른 클래스로 '변환 (cast)' 할 수도 있습니다. 아래에 있는 세 개의 코드 조각은 '클래스 계층' 및 이 클래스들의 인스턴스를 가질 배열을 정의하는 것으로, 이 후 타입 변환 예제에서 사용할 것입니다.

첫 번째 코드 조각은 `MediaItem` 이라는 새로운 '기본 클래스 (base class)'[^base-class] 를 정의합니다. 이 클래스는 '디지털 미디어 라이브러리 (digital media library)' 에서 표시할 모든 종류의 항목을 위한 '기본 기능' 을 제공합니다. 특히, `String` 타입의 `name` 속성과, `init name` 초기자를 선언하고 있습니다. (이는 모든 미디어 항목들이, 가령 모든 영화와 노래를 포함한 것들이, 이름을 가질 것이라고 가정하고 있는 것입니다.)

```swift
class MediaItem {
  var name: String
  init(name: String) {
    self.name = name
  }
}
```

그 다음 코드 조각은 `MediaItem` 의 두 '하위 클래스' 를 정의합니다. 첫 번째 하위 클래스인, `Movie` 는, 영화나 필름에 대한 추가적인 정보를 은닉합니다. 이는 `MediaItem` 이라는 기본 클래스에 `director` 속성 및 그에 관련된 초기자를 추가하고 있습니다. 두 번째 하위 클래스인, `Song` 은, 기본 클래스에 `artist` 속성과 초기자를 추가합니다:

```swift
class Movie: MediaItem {
  var director: String
  init(name: String, director: String) {
    self.director = director
    super.init(name: name)
  }
}

class Song: MediaItem {
  var artist: String
  init(name: String, artist: String) {
    self.artist = artist
    super.init(name: name)
  }
}
```

마지막 코드 조각은 `library` 라는 상수 배열을 만들고, 여기에 두 개의 `Movie` 인스턴스와 세 개의 `Song` 인스턴스를 담습니다. `library` 배열에 대한 타입 추론은 이를 '배열 글자표현 (array literal)' 의 내용으로 초기화하는 것으로 이루어 집니다. 스위프트의 '타입 검사기 (type checker)' 는 `Movie` 와 `Song` 이 `MediaItem` 이라는 공통의 '상위 클래스' 를 가지고 있음을 파악할 수 있으므로, `library` 배열의 타입으로 `[MediaItem]` 을 추론합니다.

```swift
let library = [
  Movie(name: "Casablanca", director: "Michael Curtiz"),
  Song(name: "Blue Suede Shoes", director: "Elvis Presley"),
  Movie(name: "Citizen Kane", director: "Orson Welles"),
  Song(name: "The One And Only", artist: "Chesney Hawkes"),
  Song(name: "Never Gonna Give You Up", artist: "Rick Astley"),  
]
// "library" 의 타입은 [MediaItem] 으로 추론됩니다.
```

속을 들여다보면 `library` 에 저장된 항목들은 여전히 `Movie` 와 `Song` 인스턴스 입니다. 하지만, 이 배열의 내용에 '동작을 반복 적용시켜 (iterate over)' 보면, 되돌려 받는 항목들은 타입이 `MediaItem` 이지, `Movie` 나 `Song` 이 아닙니다. 이들을 각자의 본래 타입에 맞게 작업하려면, 이들의 타입을 _검사 (check)_ 하거나, 이들을 다른 타입으로 '_내림 변환 (downcast)_' 해야 하며, 이제부터 그 방법을 설명할 것입니다.

### Checking Type (타입 검사하기)

_타입 검사 연산자 (type check operator)_ (`is`) 는 인스턴스가 어던 정해진 '하위 클래스' 타입인지를 검사하는데 사용합니다. '타입 검사 연산자' 는 그 인스턴스가 해당 하위 클래스 타입이면 `true` 를 반환하고 그렇지 않으면 `false` 를 반환합니다.

아래 예제는 두 개의 변수인, `movieCount` 와 `songCount` 를 정의하여, `library` 배열에 있는 `Movie` 와 `Song` 인스턴스의 개수를 헤아립니다:

```swift
var movieCount = 0
var songCount = 0

for item in library {
  if item is Movie {
    movieCount += 1
  } else if item is Song {
    songCount += 1
  }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")
// "Media library contains 2 movies and 3 songs" 를 출력합니다.
```

이 예제는 `library` 배열의 모든 항목을 통과하며 동작을 반복합니다. 한 번 지나갈 때마다, `for-in` 반복문은 `item` 상수에 배열의 그 다음 `MediaItem` 을 설정합니다.

`item is Movie` 는 현재 `MediaItem` 이 `Movie` 인스턴스면 `true` 를 반환하고 그렇지 않으면 `false` 를 반환합니다. 마찬가지로, `item is Song` 는 항목이 `Song` 인스턴스인지를 검사합니다. `for-in` 반복문이 끝나면, `movieCount` 와 `songCount` 의 값은 각 타입 별로 찾은 `MediaItem` 인스턴스의 개수를 가지게 됩니다.

### Downcasting (내림 변환하기)

정해진 클래스 타입의 상수나 변수는 그 속을 들여다보면 실제로는 '하위 클래스' 의 인스턴스를 참조하고 있는 것일 수도 있습니다. 이런 경우에 해당된다면, _타입 변환 연산자 (type cast operator)_ (`as?` 나 `as!`) 를 사용하여 그 하위 클래스 타입으로 '_내림 변환 (downcast)_' 을 시도할 수 있습니다.

'내림 변환 (downcasting)' 은 실패할 수 있기 때문에, 타입 변환 연산자에는 두 개의 다른 양식이 필요합니다. 조건부 양식인, `as?` 는, 내림 변환을 시도할 타입의 '옵셔널 값 (optional value)' 을 반환합니다. 강제 양식인, `as!` 는, '내림 변환 (downcast)' 과 '강제 풀기 (force-unwraps)' 시도를 한 번의 복합 동작으로 처리합니다.

타입 변환 연산자의 조건부 양식 (`as?`) 은 '내림 변환' 이 성공할지 확신할 수 없을 때 사용합니다. 이 양식의 연산자는 항상 '옵셔널 값' 을 반환하며, '내림 변환' 이 불가능할 때는 `nil` 을 반환합니다. 이를 통해 '내림 변환' 이 성공했는지를 검사할 수 있습니다.

타입 변환 연산자의 강제 양식 (`as!`) 은 '내림 변환' 이 항상 성공한다고 확신할 수 있을 때 사용합니다. 이 양식의 연산자는, 잘못된 클래스 타입에 대해 '내림 변환' 을 시도할 경우, '실행 시간에 에러 (runtime error)' 를 발생시킵니다.

아래 예제는 `library` 의 각 `MediaItem` 마다 동작을 반복 적용시켜서, 각 항목에 대한 적절한 설명을 출력합니다. 이렇게 하려면, 각 항목에 접근할 때 `MediaItem` 으로 접근하기만 해서는 안되고, 진짜 `Movie` 나 `Song` 으로 접근하는 것이 필요합니다. 이것은 설명을 제대로 하려면 `Movie` 나 `Song` 에 있는 `director` 나 `artist` 속성에 접근하는 것이 필요하기 때문입니다.

이 예제에서, 배열의 각 항목은 `Movie` 일 수도, `Song` 일 수도 있습니다. 각 항목이 실제로는 어떤 클래스인지 미리 알 순 없으므로, 반복문에서 매번 '내림 변환' 을 검사하려면 '타입 변환 연산자의 조건부 양식' (`as?`) 을 사용하는 것이 적당합니다:

```swift
for item in library {
  if let movie = item as? Movie {
    print("Movie: \(movie.name, dir. \(movie.director)")
  } else if let song = item as? Song {
    print("Song: \(song.name), by \(song.artist)")
  }
}

// Movie: Casablanca, dir. Michael Curtiz
// Song: Blue Suede Shoes, by Elvis Presley
// Movie: Citizen Kane, dir. Orson Welles
// Song: The One And Only, by Chesney Hawkes
// Song: Never Gonna Give You Up, by Rick Astley
```

이 예제는 현재 항목을 영화로 다운 캐스트하여 시작합니다. item은 MediaItem 인스턴스이므로 Movie 일 수 있습니다. 마찬가지로 노래이거나 기본 MediaItem 일 수도 있습니다. 이 불확실성 때문에? 형식 캐스트 연산자 형식은 하위 클래스 형식으로 다운 캐스트하려고 할 때 선택적 값을 반환합니다. 항목의 결과는? 영화는 영화? 또는“선택 영화”유형입니다.

라이브러리 배열의 송 인스턴스에 적용하면 영화로 다운 캐스팅 할 수 없습니다. 이 문제를 해결하기 위해 위의 예에서는 선택적 바인딩을 사용하여 선택적 Movie에 실제로 값이 포함되어 있는지 확인합니다 (즉, 다운 캐스트 성공 여부를 확인합니다).이 선택적 바인딩은 "if movie = item as? 영화”는 다음과 같이 읽을 수 있습니다.

“영화로 항목에 액세스하십시오. 이것이 성공하면, Movie라는 새로운 임시 상수를 반환 된 선택적 Movie에 저장된 값으로 설정하십시오.”

다운 캐스팅이 성공하면 영화의 속성을 사용하여 감독의 이름을 포함하여 해당 영화 인스턴스에 대한 설명을 인쇄합니다. 노래 인스턴스를 확인하고 라이브러리에서 노래가 발견 될 때마다 적절한 설명 (아티스트 이름 포함)을 인쇄하는 데 비슷한 원칙이 사용됩니다.

### Type Casting for Any and AnyObject ('Any' 와 'AnyObject' 에 대한 타입 변환)

### 참고 자료

[^Type-Casting]: 이 글에 대한 원문은 [Type Casting](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html) 에서 확인할 수 있습니다.

[^base-class]: 스위프트에서 '기본 클래스 (base class)' 라는 것은 '상위 클래스 (superclass)' 를 가지지 않는 클래스를 의미합니다. '기본 클래스' 에 대한 더 자세한 설명은 [Inheritance (상속)](http://xho95.github.io/swift/language/grammar/inheritance/2020/03/31/Inheritance.html#fnref:base-class) 을 참고하기 바랍니다.
