---
layout: post
comments: true
title:  "Swift 5.3: Type Casting (타입 변환)"
date:   2020-03-31 10:00:00 +0900
categories: Swift Language Grammar Type Casting
---

> Apple 에서 공개한 [The Swift Programming Language (Swift 5.3)](https://docs.swift.org/swift-book/) 책의 [Type Casting](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html) 부분[^Type-Casting]을 번역하고, 설명이 필요한 부분은 주석을 달아서 정리한 글입니다. 전체 번역은 [Swift 5.3: Swift Programming Language (스위프트 프로그래밍 언어)]({% post_url 2017-02-28-The-Swift-Programming-Language %}) 에서 확인할 수 있습니다.

## Type Casting (타입 변환)

_타입 변환 (Type Casting)_ 은 인스턴스의 타입을 검사하거나, 해당 인스턴스를 자신의 '클래스 계층 (class hierarchy)' 어딘가의 다른 '상위 클래스' 또는 '하위 클래스' 로 취급하기 위한 방법입니다.

스위프트의 '타입 변환' 은 `is` 와 `as` 연산자로 구현합니다. 이 두 연산자는 값의 타입을 검사하거나 값을 다른 타입으로 변환하는 간단하면서도 이해하기 쉬운 방법을 제공합니다.

타입 변환은, [Checking for Protocol Conformance (프로토콜 준수성 검사하기)]({% post_url 2016-03-03-Protocols %}#checking-for-protocol-conformance-프로토콜-준수성-검사하기) 에서 설명한 것처럼, 타입이 프로토콜을 준수하는지 검사하기 위해 사용할 수도 있습니다.

### Defining a Class Hierarchy for Type Casting (타입 변환을 위한 클래스 계층 정의하기)

'타입 변환 (type casting)'[^type-casting-and-type-conversion] 을 '클래스와 하위 클래스의 계층 (hierarchy)' 과 함께 사용하여 특정 클래스 인스턴스의 타입을 검사하고 해당 인스턴스를 같은 '계층' 내의 다른 클래스로 변환할 수 있습니다. 아래의 세 코드 조각들은, '타입 변환' 예제에서 사용하기 위한, '클래스들의 계층' 과 이 클래스들의 인스턴스를 담은 배열을 정의합니다.

첫 번째 조각은 `MediaItem` 이라는 새로운 '기초 (base) 클래스'[^base-class] 를 정의합니다. 이 클래스는 '디지털 미디어 라이브러리' 의 어떤 항목에든 기초가 되는 기능을 제공합니다. 특별히, 이는 `String` 타입의 `name` 속성과, `init name` 초기자를 선언합니다. (모든 영화와 노래를 포함한, 모든 미디어 항목들은 이름을 가질 것으로 가정합니다.)

```swift
class MediaItem {
  var name: String
  init(name: String) {
    self.name = name
  }
}
```

그 다음 조각은 `MediaItem` 의 두 '하위 클래스' 를 정의합니다. 첫 번째 하위 클래스인, `Movie` 는, 영화나 필름에 대한 추가적인 정보를 '은닉 (encapsulates)' 합니다. 이는 `MediaItem` 기초 클래스 위에, 관련된 초기자를 가진, `director` 속성을 추가합니다. 두 번째 하위 클래스인, `Song` 은, 기초 클래스 위에 `artist` 속성과 초기자를 추가합니다:

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

마지막 조각은, 두 개의 `Movie` 인스턴스와 세 개의 `Song` 인스턴스를 담은, `library` 라는 상수 배열을 생성합니다. `library` 배열의 타입은 배열 '글자 값 (literal)' 내용으로 초기화하는 것으로써 추론합니다. 스위프트의 '타입 검사기 (type checker)' 는 `Movie` 와 `Song` 이 `MediaItem` 이라는 '공통 상위 클래스' 를 가짐을 이끌어 낼 수 있으므로, `library` 배열의 타입을 `[MediaItem]` 이라고 추론합니다:

```swift
let library = [
  Movie(name: "Casablanca", director: "Michael Curtiz"),
  Song(name: "Blue Suede Shoes", director: "Elvis Presley"),
  Movie(name: "Citizen Kane", director: "Orson Welles"),
  Song(name: "The One And Only", artist: "Chesney Hawkes"),
  Song(name: "Never Gonna Give You Up", artist: "Rick Astley"),  
]
// "library" 의 타입은 [MediaItem] 이라고 추론합니다.
```

그 이면을 살펴보면 `library` 에 저장된 항목은 여전히 `Movie` 와 `Song` 인스턴스 입니다. 하지만, 이 배열의 내용에 동작을 반복하면, 되돌려 받는 항목은, `Movie` 나 `Song` 이 아니라, `MediaItem` 타입입니다. 이를 본래 타입으로 작업하기 위해선, 아래 설명한 것처럼, 타입을 _검사 (check)_ 하거나, 다른 타입으로 '_내림 변환 (downcast)_' 할 필요가 있습니다.

### Checking Type (타입 검사하기)

_타입 검사 연산자 (type check operator;_ `is`_)_ 는  인스턴스가 정해진 '하위 클래스' 타입인지를 검사하기 위해 사용합니다. '타입 검사 연산자' 는 인스턴스가 해당 하위 클래스 타입이면 `true` 를 반환하고 그렇지 않으면 `false` 를 반환합니다.

아래 예제는, `library` 배열 내의 `Movie` 와 `Song` 인스턴스 개수를 세는, `movieCount` 와 `songCount` 라는, 두 변수를 정의합니다:

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
// "Media library contains 2 movies and 3 songs" 를 인쇄합니다.
```

이 예제는 `library` 배열에 있는 모든 항목 전체에 걸쳐 동작을 반복합니다. 메 번 지나갈 때마다, `for-in` 반복문은 `item` 상수를 배열의 그 다음 `MediaItem` 으로 설정합니다.

`item is Movie` 는 현재의 `MediaItem` 이 `Movie` 인스턴스면 `true` 를 반환하고 그렇지 않으면 `false` 를 반환합니다. 이와 비슷하게, `item is Song` 은 항목이 `Song` 인스턴스인지 검사합니다. `for-in` 반복문의 끝에서, `movieCount` 와 `songCount` 의 값은 각 타입 별로 찾은 `MediaItem` 인스턴스 개수를 담고 있습니다.

### Downcasting (내림 변환하기)

정해진 클래스 타입의 상수나 변수는 그 이면을 살펴보면 실제로는 하위 클래스의 인스턴스를 참조할 수도 있습니다. 이 경우라고 믿을 경우, _타입 변환 연산자 (type cast operator;_ `as?` 또는 `as!`_)_ 로 하위 클래스 타입으로 _내림 변환 (downcast)_ 을 해 볼 수 있습니다.

'내림 변환' 은 실패할 수 있기 때문에, 타입 변환 연산자는 서로 다른 두 형식이 가집니다. 조건 형식인, `as?` 는, 내림 변환 하려는 타입의 '옵셔널 (optional) 값' 을 반환합니다. 강제 형식인, `as!` 는, '내림 변환' 시도와 결과 '강제-포장 풀기 (force-unwraps)' 를 '단일 복합 동작' 으로 합니다.

'조건 형식의 타입 변환 연산자 (`as?`)' 는 '내림 변환' 이 성공할 것이라는 확신을 할 수 없을 때 사용합니다. 이 형식의 연산자는 항상 '옵셔널 값' 을 반환하는데, 내림 변환이 가능하지 않으면 값은 `nil` 일 것입니다. 이는 '내림 변환' 의 성공 여부를 검사할 수 있게 해줍니다.

'강제 형식의 타입 변환 연산자 (`as!`)' 는 '내림 변환' 이 항상 성공할 것임을 확신할 때에만 사용합니다. 이 형식의 연산자는 올바르지 않은 클래스 타입으로 내림 변환하려고 하면 '실행 시간에 에러' 를 발생시킬 것입니다.

아래 예제는 `library` 에 있는 각 `MediaItem` 마다 동작을 반복하여, 각 항목마다 적절한 설명을 인쇄합니다. 이를 위해, 각 항목을, `MediaItem` 이 아니라, 진짜 `Movie` 나 `Song` 으로 접근할 필요가 있습니다. 이는 설명에서 사용하도록 `Movie` 나 `Song` 의 `director` 또는 `artist` 속성에 접근할 수 있게 하기 위해 필요합니다.

이 예제에서, 배열의 각 항목은 `Movie` 이거나, `Song` 일 수 있습니다. 각 항목에 사용할 실제 클래스를 미리 앞서 알 순 없으므로, 반복문 전체에 걸쳐 매 번 '내림 변환' 을 검사하려면 '조건 형식의 타입 변환 연산자 (`as?`)' 을 사용하는 것이 적절합니다:

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

이 예제는 현재의 `item` 을 `Movie` 로 내림 변환 시도하는 것으로 시작합니다. `item` 이 `MediaItem` 인스턴스이기 때문에, 이는 `Movie` _일 수도 (might)_ 있고; 그와 같이, `Song` 이거나, 심지어 '기초 `MediaItem`' 일 수도 있습니다. 이 불확실성 때문에, `as?` 형식의 타입 변환 연산자는 하위 클래스 타입으로 내림 변환을 시도할 때 _옵셔널 (optional)_ 값을 반환합니다. `item as? Movie` 의 결과는 `Movie?`, 또는 "옵셔널 `Movie`" 타입입니다.

`Movie` 로의 내림 변환은 라이브러리 배열의 `Song` 인스턴스에 적용할 때는 실패합니다. 이를 대처하기 위해, 위 예제는 옵셔널 `Movie` 가 실제로 값을 담고 있는지 검사하기 위해 (즉, 내림 변환이 성공했는지 알아내기 위해) '옵셔널 연결 (optional binding)' 을 사용합니다. 이 '옵셔널 연결' 은 "`if let movie = item as? Movie`" 라고 작성하며, 다음 처럼 이해할 수 있습니다:

“`item` 을 `Movie` 로 접근 해봅니다. 이를 성공하면, `movie` 라는 새로운 임시 상수를 반환한 '옵셔널 `Movie`' 에 저장된 값으로 설정합니다.”

내림 변환이 성공하면, 그런 다음에는, `director` 의 이름을 포함한, `movie` 속성을 해당 `Movie` 인스턴스에 대한 설명을 인쇄하는데 사용합니다. `Song` 인스턴스를 검사하고, 라이브러리에서 `Song` 을 찾을 때마다 (`artist` 이름을 포함한) 적절한 설명을 출력하기 위해, 비슷한 원리를 사용합니다.

> '변환 (casting)' 은 실제로는 인스턴스를 수정하거나 값을 바꾸지 않습니다. 밑에 놓인 실제 인스턴스는 똑같이 남아 있으며; 이는 단순히 변환한 타입의 인스턴스로 취급하고 접근하는 것입니다.

### Type Casting for Any and AnyObject ('Any' 와 'AnyObject' 를 위한 타입 변환)

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

`Any` 나 `AnyObject` 타입만 알고 있는 상태에서 상수나 변수의 '지정된 타입 (specific type)' 을 찾고 싶으면, `switch` 문의 'case 절' 에 `is` 또는 `as` 'pattern (유형)' 을 사용하면 됩니다. 아래 예제는 `things` 배열에 있는 항목들에 동작을 반복 적용시키는데 이 때 `switch` 문으로 각 항목의 타입을 조회합니다. `switch` 문에 있는 여러 개의 'case 절' 들은 해당하는 값을 지정된 타입의 상수에 '연결시켜 (bind)' 그 값을 출력할 수 있도록 합니다:

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

[^swift-update]: 스위프트 5.3 은 2020-06-22 에 WWDC 20 에 맞춰서 발표 되었다가, 2020-09-16 일에 다시 갱신 되었습니다.

[^type-casting-and-type-conversion]: '타입 변환' 은 영어로 'type casting' 과 'type conversion' 둘 다에 적용할 수 있지만, 이 둘은 서로 조금 다릅니다. 'type casting' 과 'type conversion' 의 가장 기본적인 차이점은 'type conversion' 은 컴파일러에 의해 자동으로 이루어지는 반면, 'type casting' 은 개발자가 명시적으로 지정한다는 점입니다. 'type casting' 과 'type conversion' 의 차이점에 대한 정보는, [Difference Between Type Casting and Type Conversion](https://techdifferences.com/difference-between-type-casting-and-type-conversion.html) 라는 글을 참고하기 바랍니다.

[^base-class]: 스위프트의 '기초 클래스 (base class)' 는 '상위 클래스 (superclass)' 를 가지지 않는 클래스를 말합니다. '기초 클래스' 에 대한 더 자세한 정보는, [Inheritance (상속)]({% post_url 2020-03-31-Inheritance %}) 장에 있는 [Defining a Base Class (기초 클래스 정의하기)]({% post_url 2020-03-31-Inheritance %}#defining-a-base-class-기초-클래스-정의하기) 부분 및 해당 주석을 참고하기 바랍니다.
