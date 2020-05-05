---
layout: post
comments: true
title:  "Swift 5.2: Type Casting (타입 변환)"
date:   2020-03-31 10:00:00 +0900
categories: Swift Language Grammar Type Casting
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.2)](https://docs.swift.org/swift-book/) 책의 [Type Casting](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html) 부분[^Type-Casting]을 번역하고 정리한 글입니다.
>
> 현재 전체 중에서 번역 완료된 목록은 [Swift 5.2: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

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

그 다음 코드 조각은 `MediaItem` 의 두 '하위 클래스' 를 정의합니다. 첫 번째 하위 클래스인, `Movie` 는, 영화나 필름에 대한 추가적인 정보를 '캡슐화 (encapsulates)' 합니다. 이는 `MediaItem` 기본 클래스 위에다가 `director` 속성을 추가하고, 그와 연관되는 초기자도 추가합니다. 두 번째 하위 클래스인, `Song` 은, 기본 클래스 위에 `artist` 속성과 초기자를 추가합니다:

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

이 예제는 현재 `item` 을 `Movie` 로 '내림 변환' 하는 것으로 시작합니다. `item` 은 `MediaItem` 인스턴스 이므로, 이것이 `Movie` _일 수 있다 (might)_ 는 것은 가능한 것입니다; 마찬가지로, 이것은 `Song` 일 수 있다는 것도 가능한 것이며, 심지어 기본 `MediaItem` 일 수 있다는 것도 가능한 것입니다. 이러한 불확실성 때문에, `as?` 양식의 타입 변환 연산자는 하위 클래스 타입으로 내림 변환을 시도힌 후 _옵셔널 (optional)_ 값을 반환합니다. `item as? Movie` 의 결과는 타입이 `Movie?`, 또는 "옵셔널 `Movie`" 입니다.

`Movie` 로 '내림 변환' 하는 것을 '라이브러리' 배열의 `Song` 인스턴스에 적용하면 실패할 것입니다. 이에 대처하기 위해, 위의 예제에서는 '옵셔널 바인딩 (optional binding)' 을 사용하여 옵셔널 `Movie` 가 실제로 값을 가지고 있는지를 검사합니다. (이는 곧 '내림 변환' 이 성공했는지를 알아 낸다는 것과 같습니다.) 이 '옵셔널 바인딩' 은 "`if let movie = item as? Movie`" 라고 작성되었는데, 이는 다음과 같이 이해할 수 있습니다:

“`item` 을 `Movie` 인 것으로 접근하기 바랍니다. 이것이 성공했으면, 반환된 옵셔널 `Movie` 에 저장된 값을 `movie` 라는 새로운 임시 상수에 설정하기 바랍니다.”

'내림 변환' 이 성공하면, `movie` 속성으로 `Movie` 인스턴스의 설명을 출력할 수 있게 되며, 이 때 `director` 의 이름도 포함하게 됩니다. 이와 비슷한 원리를 사용하면 `Song` 인스턴스를 검사하여, '라이브러리' 에서 발견한 모든 `Song` 에 대한 적절한 설명을 (`artist` 이름도 포함하여) 출력할 수 있습니다.

> '변환 (casting)' 은 실제로 인스턴스를 수정하거나 그 값을 바꾸는 것이 아닙니다. 실제 인스턴스는 그대로 남아 있습니다; 단지 어떤 인스턴스를 변환한 타입으로 취급하고 접근할 수 있게 하는 것일 뿐입니다.

### Type Casting for Any and AnyObject ('Any' 와 'AnyObject' 에 대한 타입 변환)

스위프트는 '지정되지 않은 타입 (nonspecific type)' 을 다루기 위한 두 개의 특별한 타입을 제공합니다.

* `Any` 는 어떤 타입에 대한 인스턴스라도 전부 나타낼 수 있으며, 여기에는 함수 타입도 포함됩니다.
* `AnyObject` 는 어떤 클래스 타입에 대한 인스턴스라도 나타낼 수 있습니다.

`Any` 와 `AnyObject` 는 이들이 제공하는 동작과 기능이 명시적으로 필요할 때만 사용하기 바랍니다. 코드에서 작업하는 타입을 예상할 수 있는 경우라면 항상 이를 지정하는 것이 더 좋습니다.

다음은 `Any` 를 사용하여 서로 다른 타입을 섞어서 작업하는 예제이며, 여기에는 '함수 타입' 과 '비-클래스 타입' 도 포함됩니다. 이 예제는 `Any` 타입의 값을 저장할 수 있는, `things` 라는 배열을 만듭니다:

```swift
var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })
```

`things` 배열이 가지고 있는 것들은 두 개의 `Int` 값, 두 개의 `Double` 값, 한 개의 `String` 값, 한 개의 `(Double, Double)` 타입인 튜플, "Ghostbusters" 라는 영화, 그리고 한 개의 클로저로 `String` 값을 받아서 또다른 `String` 값을 반환하는 것이 있습니다.

`Any` 나 `AnyObject` 타입만 알고 있는 상태에서 상수나 변수의 '지정된 타입 (specific type)' 을 찾고 싶으면, `switch` 문의 '경우 값 (cases)' 에 `is` 또는 `as` 'pattern (유형)' 을 사용하면 됩니다. 아래 예제는 `things` 배열에 있는 항목들에 동작을 반복 적용시키는데 이 때 `switch` 문으로 각 항목의 타입을 조회합니다. `switch` 문의 여러 개의 '경우 값 (cases)' 들은 해당하는 값을 지정된 타입의 상수에 '연결시켜 (bind)' 그 값을 출력할 수 있도록 합니다:

```swift
for thing in things {
  switch thing {
  case 0 as Int:
    print("zero as an Int")
  case 0 as Double:
    print("zero as a Double")
  case let someInt as Int:
    print("and integer value of \(someInt)")
  case let someDouble as Double where someDouble > 0:
    print("a positive double value of \(someDouble)")
  case is Double:
    print("some other double value that I don't want to print")
  case let someString as String:
    print("a string value of \(someString)")
  case let (x, y) as (Double, Double):
    print("an (x, y) point at \(x), \(y)")
  case let movie as Movie:
    print("a movie called \(movie.name), dir. \(movie.director)")
  case let stringConverter as (String) -> String:
    print(stringConverter("Michael"))
  default:
    print("something else")
  }
}

// zero as an Int
// zero as a Double
// an integer value of 42
// a positive double value of 3.14159
// a string value of "hello"
// an (x, y) point at 3.0, 5.0
// a movie called Ghostbusters, dir. Ivan Reitman
// Hello, Michael
```

> `Any` 타입은 어떤 타입의 값이라도 나타낼 수 있는 것으로, 여기에는 '옵셔널 타입' 도 포함됩니다. `Any` 타입의 값이 필요한 곳에서 '옵셔널 값' 을 사용하면 스위프트가 경고를 띄웁니다. 정말로 '옵셔널 값' 을 `Any` 값의 형태로 사용해야하는 경우라면, `as` 연산자를 사용하여, 아래에 보인 것처럼, 그 '옵셔널' 을 명시적으로 `Any` 로 '변환 (cast)' 해야 합니다.

```swift
 let optionalNumber: Int? = 3
things.append(optionalNumber)        // Warning
things.append(optionalNumber as Any) // No warning
```

### 참고 자료

[^Type-Casting]: 이 글에 대한 원문은 [Type Casting](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html) 에서 확인할 수 있습니다.

[^base-class]: 스위프트에서 '기본 클래스 (base class)' 라는 것은 '상위 클래스 (superclass)' 를 가지지 않는 클래스를 의미합니다. '기본 클래스' 에 대한 더 자세한 설명은 [Inheritance (상속)]({% post_url 2020-03-31-Inheritance %}) 을 참고하기 바랍니다.
