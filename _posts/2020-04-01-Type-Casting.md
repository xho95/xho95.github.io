---
layout: post
comments: true
title:  "Type Casting (타입 변환)"
date:   2020-03-31 10:00:00 +0900
categories: Swift Language Grammar Type Casting
---

{% include header_swift_book.md %}

## Type Casting (타입 변환)

_타입 변환 (Type Casting)_[^type-casting-and-type-conversion] 은 인스턴스의 타입을 검사하거나, 그 인스턴스를 클래스 계층 구조 어딘가에 있는 상위 클래스나 하위 클래스로 취급하는 법입니다.

스위프트의 타입 변환은 `is` 와 `as` 연산자로 구현합니다. 이 두 연산자는 단순하고 표현력이 좋은[^expressive] 방식으로 값의 타입을 검사하거나 값을 다른 타입으로 변환합니다.

타입 변환을 써서 타입이 프로토콜을 따르고 있는지 검사할 수도 있는데, 이는 [Checking for Protocol Conformance (프로토콜 준수성 검사하기)]({% link docs/swift-books/swift-programming-language/protocols.md %}#checking-for-protocol-conformance-프로토콜-준수성-검사하기) 에서 설명합니다.

### Defining a Class Hierarchy for Type Casting (타입 변환을 위한 클래스 계층 정의하기)

타입 변환을 클래스 및 하위 클래스의 계층 구조와 사용하면 한 특별한 클래스 인스턴스의 타입을 검사해서 그 인스턴스를 같은 계층 구조 안에 있는 또 다른 클래스로 변환할 수 있습니다. 아래 세 코드 조각은, 타입 변환 예제에서 쓸, 클래스의 계층 구조와 이 클래스들의 인스턴스를 담은 배열을 정의합니다.

첫 번째 조각은 새로운 기초 클래스[^base-class] 인 `MediaItem` 을 정의합니다. 이 클래스는 디지털 미디어 라이브러리 안에 나타난 어떤 종류의 항목에도 기초 기능을 제공합니다. 특히, `String` 타입의 `name` 속성과, `init name` 초기자를 선언합니다. (모든 영화와 노래를 포함한, 모든 미디어 항목엔 이름이 있을거라고 가정합니다.)

```swift
class MediaItem {
  var name: String
  init(name: String) {
    self.name = name
  }
}
```

그 다음 조각은 `MediaItem` 의 두 하위 클래스를 정의합니다. 첫 번째 하위 클래스인, `Movie` 는, 영화나 필름에 대한 추가 정보를 감추고 있습니다. 이는 기초 클래스인 `MediaItem` 위에 `director` 속성과, 그에 해당하는 초기자를 추가합니다. 두 번째 하위 클래스인, `Song` 은, 기초 클래스 위에 `artist` 속성 및 초기자를 추가합니다:

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

마지막 조각은 `library` 라는 상수 배열을 생성하는데, 여기엔 두 개의 `Movie` 인스턴스와 세 개의 `Song` 인스턴스를 담습니다. `library` 배열의 타입은 이를 초기화하고 있는 배열 글자 값의 내용물로 추론됩니다. 스위프트의 타입 검사기는 `Movie` 와 `Song` 의 공통 상위 클래스가 `MediaItem` 이라는 걸 이끌어 낼 수 있어서, `[MediaItem]` 이 `library` 배열의 타입이라고 추론합니다:

```swift
let library = [
  Movie(name: "Casablanca", director: "Michael Curtiz"),
  Song(name: "Blue Suede Shoes", director: "Elvis Presley"),
  Movie(name: "Citizen Kane", director: "Orson Welles"),
  Song(name: "The One And Only", artist: "Chesney Hawkes"),
  Song(name: "Never Gonna Give You Up", artist: "Rick Astley"),  
]
// "library" 의 타입은 [MediaItem] 이라고 추론함
```

`library` 안에 저장된 항목은 속을 보면 여전히 `Movie` 와 `Song` 인스턴스입니다. 하지만, 이 배열의 내용물을 반복하면, 돌려 받는 항목은 `MediaItem` 타입이지, `Movie` 나 `Song` 이 아닙니다. 자신의 본래 타입으로 작업하기 위해선, 타입을 _검사 (check)_ 하거나, 다른 타입으로 _내림 변환 (downcast)_[^downcast] 할 필요가 있는데, 이는 아래에서 설명합니다.

### Checking Type (타입 검사)

_타입 검사 연산자 (type check operator;_ `is`_)_ 를 써서 인스턴스가 특정한 하위 클래스 타입인지 검사합니다. 타입 검사 연산자는 인스턴스가 그 하위 클래스 타입이면 `true` 를 반환하고 그렇지 않으면 `false` 를 반환합니다.

아래 예제에서 정의한 두 개의 변수,`movieCount` 와 `songCount` 는, `library` 배열에 있는 `Movie` 와 `Song` 인스턴스의 개수를 셉니다:

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
// "Media library contains 2 movies and 3 songs" 를 인쇄함
```

이 예제는 `library` 배열에 있는 모든 항목 전체를 반복합니다. 매 통과마다, `for-in` 반복문이 `item` 상수를 배열 안의 그 다음 `MediaItem` 으로 설정합니다.

`item is Movie` 는 현재의 `MediaItem` 이 `Movie` 인스턴스면 `true` 를 반환하고 그렇지 않으면 `false` 를 반환합니다. 이와 비슷하게, `item is Song` 은 항목이 `Song` 인스턴스인지 검사합니다. `for-in` 반복문의 끝에서, `movieCount` 와 `songCount` 값은 각각의 타입마다 `MediaItem` 인스턴스를 얼마나 많이 찾았는지 그 개수를 담고 있습니다.

### Downcasting (내림 변환)

특정 클래스 타입의 상수나 변수는 실제로 그 속을 보면 하위 클래스의 인스턴스를 참조하고 있을 수 있습니다. 이 경우라고 믿는 곳이면, _타입 변환 연산자 (type cast operator;_ `as?` 또는 `as!`_)_ 로 하위 클래스 타입으로 _내림 변환 (downcast)_ 을 해볼 수 있습니다.

내림 변환이 실패할 수 있기 때문에, 타입 변환 연산자엔 서로 다른 두 개의 형식이 있습니다. 조건 형식인, `as?` 는, 내림 변환하려는 타입의 옵셔널 값을 반환합니다. 강제 형식인, `as!` 는, 내림 변환을 시도하는 것과 결과를 강제로-푸는 것을 단 하나의 복합 행동으로 합니다.

조건 형식의 타입 변환 연산자 (`as?`) 는 내림 변환이 성공할지 확신할 수 없을 때 씁니다. 이 형식의 연산자는 항상 옵셔널 값을 반환하며, 내림 변환이 불가능하면 값은 `nil` 이 될 겁니다. 이는 내림 변환이 성공인지 검사할 수 있게 합니다.

강제 형식의 타입 변환 연산자 (`as!`) 는 내림 변환이 항상 성공할 걸 확신할 때만 씁니다. 잘못된 클래스 타입으로 내림 변환하려고 하면 이 형식의 연산자가 실행 시간 에러를 발생시킵니다.

아래 예제는 `library` 안에 있는 각각의 `MediaItem` 을 반복하면서, 각 항목마다 적절한 설명을 인쇄합니다. 이렇게 하려면, 각각의 항목을, `MediaItem` 만으로써가 아니라, 본래의 `Movie` 나 `Song` 으로 접근하는게 필요합니다. 이게 필요한 건 설명에서 `Movie` 나 `Song` 의 `director` 나 `artist` 속성에 접근하기 위해서입니다.

이 예제에선, 배열의 각 항목이 `Movie` 일지, `Song` 일지 모릅니다. 각 항목에서 쓸 실제 클래스를 미리 앞서 알 순 없으므로, 조건 형식의 타입 변환 연산자 (`as?`) 로 매 번 반복문을 통과할 때마다 내림 변환 검사를 하는게 적절합니다:

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

이 예제는 현재 `item` 을 `Movie` 로 내림 변환하려는 걸로 시작합니다. `item` 아 `MediaItem` 인스턴스이기 때문에, `Movie` _인 게 (might)_ 가능하며; 그와 같이, `Song` 이거나, 또는 심지어 기초 (타입인) `MediaItem` 일 수도 있습니다. 이런 불확실함 때문에, `as?` 형식의 타입 변환 연산자는 하위 클래스 타입으로 내림 변환을 시도할 때 _옵셔널 (optional)_ 값을 반환합니다. `item as? Movie` 의 결과는 `Movie?`, 또는 "옵셔널 `Movie`" 타입입니다.

라이브러리 배열의 `Song` 인스턴스에 적용할 땐 `Movie` 로의 내림 변환이 실패합니다. 이에 대처하고자, 위 예제는 옵셔널 연결을 사용하여 실제로 옵셔널 `Movie` 에 값이 담겼는지 검사합니다 (즉, 내림 변환이 성공했는지 알아냅니다.) 이 옵셔널 연결은 "`if let movie = item as? Movie`" 라고 작성하며, 다음 처럼 이해할 수 있습니다:

“`item` 을 `Movie` 로 접근해 봅니다. 이게 성공하면, 반환한 옵셔널 `Movie` 에 저장된 값을 `movie` 라는 새 임시 상수에 설정합니다.”

내림 변환이 성공하면, 그 다음엔 `movie` 의 속성을 사용하여, `director` 이름을 포함한, 그 `Movie` 인스턴스의 설명을 인쇄합니다. 비슷한 원리를 사용하여 `Song` 인스턴스를 검사하며, 라이브러리에서 `Song` 을 찾았을 때마다 (`artist` 이름을 포함한) 적절한 설명을 인쇄합니다.

> 변환 (casting) 이 실제로 인스턴스를 수정하거나 값을 바꾸는 건 아닙니다. 실제 인스턴스는 똑같이 남아 있으며; 단순히 변환된 타입의 인스턴스라고 취급하고 접근하는 것 뿐입니다.

### Type Casting for Any and AnyObject (Any 와 AnyObject 의 타입 변환)

스위프트는 불특정 타입과 작업하기 위한 두 개의 특수 타입을 제공합니다:

* `Any` 는 아예, 함수 타입을 포함한, 어떤 타입의 인스턴스든 나타낼 수 있습니다.
* `AnyObject` 는 어떤 클래스 타입의 인스턴스든 나타낼 수 있습니다.

명시적으로 이들의 동작과 보유 능력이 필요할 때만 `Any` 와 `AnyObject` 를 사용합니다. 작업할 걸로 예상되는 타입을 코드에 지정하는 것이 항상 더 좋습니다.

`Any` 를 사용하여, 함수 타입 및 비-클래스 타입을 포함한, 서로 다른 타입이 섞인 것과 작업하는 예제는 이렇습니다. 예제에서 `things` 라는 배열을 생성하는데, 이는 `Any` 타입의 값을 저장할 수 있습니다:

```swift
var things: [Any] = []

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })
```

`things` 배열은 `Int` 값 두 개, `Double` 값 두 개, `String` 값 한 개, `(Double, Double)` 타입의 튜플, "고스트 버스터즈 (Ghostbusters)"[^ghostbusters] 영화, 및 `String` 값을 취해서 또 다른 `String` 값을 반환하는 클로저 표현식을 담고 있습니다.

`Any` 나 `AnyObject` 타입인지만 아는 상수나 변수의 특정 타입을 발견하기 위해, `switch` 문 case 절에서 `is` 나 `as` 패턴을 사용할 수 있습니다. 아래 예제는 `things` 배열의 항목을 반복하여 `switch` 문으로 각 항목의 타입을 조회합니다. `switch` 문의 여러 case 들은 일치 값을 특정 타입의 상수와 연결하여 값을 인쇄할 수 있게 합니다:

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

> `Any` 타입은, 옵셔널 타입을 포함한, 어떤 타입의 값이든 나타냅니다. `Any` 타입의 값을 예상한 곳에 옵셔널 값을 사용하면 스위프크가 경고를 줍니다. 정말로 옵셔널 값을 `Any` 값으로 사용할 필요가 있으면, 아래 보는 것처럼, `as` 연산자를 사용하여 명시적으로 옵셔널을 `Any` 로 변환할 수 있습니다.

```swift
 let optionalNumber: Int? = 3
things.append(optionalNumber)        // 경고
things.append(optionalNumber as Any) // 경고 없음
```

### 다음 장

[Nested Types (중첩 타입) >]({% link docs/swift-books/swift-programming-language/nested-types.md %})

### 참고 자료

{% include footer_swift_book.md %} 이 장의 원문은 [Type Casting](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html) 에서 볼 수 있습니다.

[^type-casting-and-type-conversion]: 타입 변환은 영어로 'type casting' 과 'type conversion' 둘 다에 적용할 수 있지만, 이 둘은 서로 조금 다릅니다. 'type casting' 과 'type conversion' 의 가장 기본적인 차이점은 'type conversion' 은 컴파일러에 의해 자동으로 이루어지는 반면, 'type casting' 은 개발자가 명시적으로 지정한다는 점입니다. 'type casting' 과 'type conversion' 의 차이점에 대한 정보는, [Difference Between Type Casting and Type Conversion](https://techdifferences.com/difference-between-type-casting-and-type-conversion.html) 항목을 보도록 합니다.

[^expressive]: '표현력이 좋다 (expressive)' 는 건 컴파일러와 개발자 모두 이해하기 쉽게 코드를 작성할 수 있다는 걸 의미합니다. 이에 대한 더 자세한 내용은, **stackoverflow** 의 [What does "expressive" mean when referring to programming languages?](https://stackoverflow.com/questions/638881/what-does-expressive-mean-when-referring-to-programming-languages) 항목을 참고하기 바랍니다.

[^base-class]: 스위프트의 '기초 클래스 (base class)' 는 '상위 클래스 (superclass) 가 없는 클래스' 를 말합니다. 기초 클래스에 대한 더 자세한 정보는, [Inheritance (상속)]({% link docs/swift-books/swift-programming-language/inheritance.md %}) 장에 있는 [Defining a Base Class (기초 클래스 정의하기)]({% link docs/swift-books/swift-programming-language/inheritance.md %}#defining-a-base-class-기초-클래스-정의하기) 부분 및 해당 주석을 보도록 합니다.

[^downcast]: '내림 변환 (downcast)' 은 클래스 계층 구조에서 하위 클래스로 변환하는 것을 말합니다. 내림 변환에 대해서는, 바로 뒤의 [Downcasting (내림 변환)](#downcasting-내림-변환) 절에서 설명합니다.

[^ghostbusters]: '고스트 버스터즈 (Ghostbusters)' 는 1984년에 최초로 개봉한 헐리우드 영화입니다. 이에 대한 더 자세한 정보는, 위키피디아의 [Ghostbusters](https://en.wikipedia.org/wiki/Ghostbusters) 항목과 [고스트버스터즈](https://ko.wikipedia.org/wiki/고스트버스터즈) 항목을 보도록 합니다.
