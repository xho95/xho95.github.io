여기서는 [스위프트 (Swift)](https://swift.org) 의 패키지 관리자에 대해서 정리합니다. [^swift-org]

이 글은 Swift 공식 홈페이지에 있는 [Package Manager](https://swift.org/package-manager/#conceptual-overview) 라는 글을 번역하고 기타 다른 내용들을 덧붙여 정리한 것입니다. [^swift-package-manager]

### 들어가며

Swift 패키지 관리자는 Swift 코드의 배포를 관리하는 도구입니다. 빌드 시스템과 통합되어서 의존 모듈를 다운로드하고 컴파일하며 링크하는 과정을 자동으로 수행합니다.  [^dependency]

패키지 관리자는 Swift 3.0 버전 이상부터 적용됩니다.

### 기본 개념

이 번 장에서는 Swift 패키지 관리자가 어떤 의도로 만들어졌는지 그 기본 개념에 대해서 설명합니다.

#### 모듈 (Modules)

Swift 는 코드를 모듈로 정리합니다. 각 모듈은 네임 스페이스를 지정하고 해당 코드의 어떤 부분이 모듈 외부에서 사용할 수 있는지에 대한 접근 제어를 실행합니다.

프로그램은 하나의 모듈만 써서 모든 코드를 담을 수도 있고, 다른 모듈을 의존 모듈로써 덧붙일 수도 있습니다. [^dependency] macOS 의 다윈 (Darwin) 이나 리눅스 (linux) 의 Glibc 같은 몇가지 시스템-제공 모듈을 제외하면, 대부분의 의존 모듈은 코드를 다운받아서 빌드해야 사용할 수 있습니다.

특정 문제를 해결하는 코드를 별도의 모듈로 담으면, 그 코드를 다른 상황에서도 재사용할 수 있습니다. 예를 들어 네크워크 요청을 만드는 모듈이 있다면 이 모듈은 사진 공유 앱과 날씨 앱에서 모두 사용할 수 있습니다. 모듈을 사용하면 똑같은 기능을 직접 다시 구현할 필요없이 다른 개발자가 만든 코드 위에서 개발을 진행할 수 있습니다.

#### 패키지 (Packages)

패키지는 Swift 소스 파일과 목록 (manifest) 파일로 구성됩니다. **Package.swift** 라는 목록 파일은 `PackageDescription` 모듈을 사용하여 패키지의 이름과 그 내용을 정의합니다.

패키지에는 하나 이상의 타겟 (target) 이 있습니다. 각각의 타겟은 하나의 제품을 지정하며 하나 이상의 의존 모듈을 선언할 수 있습니다.

#### 제품 (Products)

타겟은 빌드를 해서 라이브러리 또는 실행 파일의 형태로 제품을 만들 수 있습니다. 라이브러리는 모듈을 담고 있는데, 다른 Swift 코드에서 `import` 로 불러올 수 있습니다. 실행 파일은 운영 체제에 의해서 실행할 수 있는 프로그램입니다.

#### 의존 모듈 (Dependencies)

타겟의 의존 모듈은 패키지에 있는 코드가 필요로 하는 모듈을 말합니다. 의존 관계는 패키지의 소스를 가리키는 상대 및 절대 URL 과 사용될 패키지 버전에 대한 요구 조건 집합으로 구성됩니다. 패키지 매니저의 역할은 프로젝트와 의존 관계에 있는 모든 모듈을 내려 받고 빌드하는 과정을 자동화해서 조정 비용을 줄이는 것입니다. [^coordination] 이것은 재귀적인 프로세스입니다 [^process] : 의존 모듈은 스스로가 의존 모듈을 가질 수 있고, 그들은 또 제각각 의존 모듈을 가질 수 있어서, 의존 관계가 그래프 형태를 띄게 됩니다. 패키지 관리자는 전체 의존 관계 그래프를 만족하는 모든 것들을 내려 받고 필드합니다.

> 이어지는 절에서는 Swift 를 사용할 줄 안다고 가정합니다. Swift 가 처음이라면 먼저 소개 자료를 좀 보고 싶을 수 있습니다. [The Swift Programming Language](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/) [^swift-programming-language] 의 [A Swift Tour](https://developer.apple.com/library/prerelease/content/documentation/Swift/Conceptual/Swift_Programming_Language/GuidedTour.html#//apple_ref/doc/uid/TP40014097-CH2-ID1) 부분을 추천합니다.
> 
> 코드 예제를 따라하고 싶으면 Swift 를 설치해야 합니다. Swift 를 설치하는 방법은 [Getting Started](https://swift.org/getting-started/#installing-swift) 에 나와 있습니다. [^getting-started]

### 사용 예제 (Example Usage)

[Getting Started](https://swift.org/getting-started/#installing-swift) 에서는 Swift 패키지 관리자를 사용해서 간단한 **Hello, world!** 프로그램을 만들어 봤습니다.

Swift 패키지 관리자로 무엇을 더 할 수 있는지 완전히 알아보기 위해 , 이어지는 예제는 서로 의존하고 있는 네 개의 패키지를 사용합니다:

* [PlayingCard](https://github.com/apple/example-package-playingcard) - `PlayingCard`, `Suit`, 그리고 `Rank` 타입을 정의합니다.
* [FisherYates](https://github.com/apple/example-package-fisheryates) - `shuffle()` 과 `shuffleInPlace()` 메소드를 구현하는 extension 을 정의합니다. [^extension]
* [DeckOfPlayingCards](https://github.com/apple/example-package-deckofplayingcards) - `PlayingCard` 값의 배열을 뒤섞거나 거래하는 `Deck` 타입을 정의합니다.
* [Dealer](https://github.com/apple/example-package-dealer) - `DeckOfPlayingCards` 을 생성하고, 뒤섞으며, 처음 10장의 카드를 거래하는 실행 파일을 정의합니다.

> 전체 예제를 빌드하고 실행하려면 GitHub 에 있는 [Dealer 프로젝트](https://github.com/apple/example-package-dealer) 에서 소스 코드를 내려 받아서 아래의 명령을 실행하면 됩니다:
> 
> ```sh
> $ cd example-package-dealer
> $ swift build
> $ .build/debug/Dealer
> ```

#### 라이브러리 패키지 만들기 (Creating a Library Package)

처음은 표준 52장 카드 한 벌 (deck) 에서 한 장의 참여중인 (playing) 카드를 나타내는 모듈을 만드는 것으로 시작합니다. `PlayingCard` 모듈은 `PlayingCard` 타입을 정의하는데, 이 타입은 `Suit` 열거 타입 값 (클럽, 다이아, 하트, 스페이드) 과 `Rank` 열거 타입 값 (에이스, 2, 3, ..., 잭, 퀸, 킹) 으로 구성됩니다. [^card] [^enumeration]

```swift
public enum Rank : Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
}

public enum Suit: String {
    case Spades, Hearts, Diamonds, Clubs
}

public struct PlayingCard {
    let rank: Rank
    let suit: Suit
}
```

규칙에 따라 패키지는 **Sources/** 디렉토리에 있는 모든 소스 파일을 포함합니다.

```sh
example-package-playingcard
├── Sources
│   ├── PlayingCard.swift
│   ├── Rank.swift
│   └── Suit.swift
└── Package.swift
```

`PlayingCard` 모듈은 실행 파일을 생성하지 않으므로 라이브러리라고 할 수 있습니다. 라이브러리는 다른 패키지에서 `import` 로 붙일 수 있는 모듈을 빌드하는 패키지입니다. 기본으로 라이브러리 모듈은 **Sources/** 디렉토리에 있는 소스 코드에서 선언된 모든 `public` 타입과 메소드를 외부에 드러냅니다.

Swift 빌드 프로세스를 시작하려면 `swift build` 를 실행합니다. 모든 것이 올바르면 `PlayingCard` 를 위한 Swift 모듈을 컴파일합니다.

> `PlayingCard` 패키지의 완전한 코드는 <https://github.com/apple/example-package-playingcard> 에서 찾을 수 있습니다.

#### 빌드 설정 구문(Build Configuration Statements) 사용하기

다음에 빌드할 모듈은 `FisherYates` 입니다. `PlayingCard` 와 달리 이 모듈은 새로운 타입을 정의하지 않습니다. 대신에 이미 있는 타입 - 특히 `CollectionType` 과 `MutableCollectionType` 프로토콜 – 을 확장해서 `shuffle()` 메소드와 변형(mutating)을 위한 보완 대책인 `shuffleInPlace()` 을 추가합니다.

`shuffleInPlace()` 의 구현은 피셔 (Fisher) - 예이츠 (Yates) 알고리즘을 사용하여 집합에 있는 요소의 순서를 무작위로 바꿉니다. Swift 표준 라이브러리는 난수 생성기를 제공하지 않기 때문에, 이 메소드는 시스템 모듈에 있는 함수를 사용해서 구현해야 합니다. 이 함수를 macOS 와 리눅스에서 호환되도록 하려면 코드에서 빌드 설정 구문을 사용합니다.

**macOS** 의 시스템 모듈은 다윈 (Darwin) 이며 `arc4random_uniform(_:)` 함수를 제공합니다. 리눅스의 시스템 모듈은 Glibc 이고 `random()` 함수를 제공합니다:

```swift
#if os(Linux)
import Glibc
#else
import Darwin.C
#endif

public extension MutableCollectionType where Index == Int {
    mutating func shuffleInPlace() {
        if count <= 1 { return }

        for i in 0..<count - 1 {
#if os(Linux)
            let j = Int(random() % (count - i)))) + i
#else
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
#endif
            if i == j { continue }
            swap(&self[i], &self[j])
        }
    }
}
```

> `FisherYates` 패키지의 완전한 코드는 <https://github.com/apple/example-package-fisheryates> 에서 찾을 수 있습니다.

#### 의존 모듈 불러넣기 (Importing Dependencies)

The `DeckOfPlayingCards` package brings the previous two packages together: It defines a Deck type that uses the `shuffle()` method from `FisherYates` on an array of `PlayingCard` values.

To use the `FisherYates` and `PlayingCards` modules, the `DeckOfPlayingCards` package must declare their packages as dependencies in its **Package.swift** manifest file.

```swift
import PackageDescription

let package = Package(
    name: "DeckOfPlayingCards",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/apple/example-package-fisheryates.git",
                 majorVersion: 1),
        .Package(url: "https://github.com/apple/example-package-playingcard.git",
                 majorVersion: 1),
    ]
)
```

Each dependency specifies a source URL and version requirements. The source URL is a URL accessible to the current user that resolves to a Git repository. The version requirements, which follow Semantic Versioning (SemVer) conventions, are used to determine which Git tag to check out and use to build the dependency. For of both the FisherYates and PlayingCard dependencies, the most recent version with major version equal to 1 (for example, 1.0.0) will be used.

When the swift build command is run, the Package Manager downloads all of the dependencies, compiles them, and links them to the package module. This allows DeckOfPlayingCards to access the public members of its dependent modules with import statements.

You can see the downloaded sources in the Packages directory at the root of your project, and intermediate build products in the .build directory at the root of your project.

> The complete code for the DeckOfPlayingCards package can be found at <https://github.com/apple/example-package-deckofplayingcards>.

#### Resolving Subdependencies

With everything else in place, now you can build the Dealer module. The Dealer module depends on the DeckOfPlayingCards package, which in turn depends on the PlayingCard and FisherYates packages. However, because the Swift Package Manager automatically resolves subdependencies, you only need to declare the DeckOfPlayingCards package as a dependency.

```swift
import PackageDescription

let package = Package(
    name: "Dealer",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/apple/example-package-deckofplayingcards.git",
                 majorVersion: 1),
    ]
)
```

Swift requires that a source file import the modules for any types that are referenced in code. For the Dealer module’s main.swift file, the Deck type from DeckOfPlayingCards and the PlayingCard type from PlayingCard are referenced. Although the shuffle() method on the Deck type uses the FisherYates module internally, that module does not need to be imported in main.swift.

```swift
import PlayingCard
import DeckOfPlayingCards

let numberOfCards = 10

var deck = Deck.standard52CardDeck()
deck.shuffle()

for _ in 1...numberOfCards {
    guard let card = deck.deal() else {
        print("No More Cards!")
        break
    }

    print(card)
}
```

By convention, a package containing a file named main.swift in its root directory produces an executable.

Running the swift build command starts the Swift build system to produce the Dealer executable, which can be run from the .build/debug directory.

```sh
$ swift build
$ ./.build/debug/Dealer
♠︎6
♢K
♢2
♡8
♠︎7
♣︎10
♣︎5
♢A
♡Q
♡7
```

> The complete code for the Dealer package can be found at <https://github.com/apple/example-package-dealer>.

For more information about using the Swift Package Manager, see the documentation provided in the [Swift Package Manager project on GitHub](https://github.com/apple/swift-package-manager).

### Community Proposal

The initial release of the Swift Package manager is just a starting point, and we invite you to get involved and help build the best tool possible.

To help you get started with the project, we have prepared the following Community Proposal, which provides some context for decisions made in the current implementation, and offers direction for the development of future features. If you are interested in getting involved, this is the first document you should read.

[Read the Swift Package Manager “Community Proposal”](https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageManagerCommunityProposal.md)

### 원문 자료

이 글을 작성하는데 사용된 원문은 Swift 공식 홈페이지에 있는 [Package Manager](https://swift.org/package-manager/#conceptual-overview) 입니다.

### 참고 자료

[^swift-org]: 애플에서는 Swift 를 오픈 소스로 공개하면서 [Welcome to Swift.org](https://swift.org) 라는 공식 페이지도 만들고 블로그도 운영하면서 Swift 관련 소식들을 알리고 있습니다.

[^swift-package-manager]: [Package Manager](https://swift.org/package-manager/#conceptual-overview)

[^dependency]: 'dependency' 라는 단어는 구글 번역에서는 '종속성'으로 번역을 하고 프로그래밍 분야에서는 '의존성'이라는 말로 번역을 많이 합니다. 처음에는 둘 중 하나를 선택하려고 했는데 '의존성'이라고 하면 뭔가 '성질'을 나타내는 것이라 의미가 달라지는 것 같고 '의존물'이라는 용어도 와 닿지가 않아서, 여기서는 의존하고 있다는 의미로 '의존 모듈' 또는 때에 따라서 '의존 코드'라는 말로 옮깁니다. 앞으로 더 적당한 말이 생각나면 바꿀 생각입니다.

[^coordination]: 'coordination cost'를 조정 비용이라고 옮기는데 조정 비용이 무엇인지는 아직 모호합니다.  

[^process]: '과정'이라는 말로 많이 바꿔썼는데 그냥 프로세서라고 하는 것이 무난한 것 같습니다.

[^swift-programming-language]: 애플에서 무료로 제공하는 Swift 언어의 공식 매뉴얼입니다. 문장이 상당히 간결하고 예제도 많이 있어서 Swift 입문자라면 가장 먼저 그리고 꼭 봐야할 책입니다.

[^getting-started]: Swift 공식 블로그에 있는 설치 방법 등을 소개하고 있는 글입니다.

[^extension]: 원래는 'extension' 을 '확장'이라고 직역했었는데, 의미가 헷갈릴 수 있을 것 같아서 '익스텐션'이라고 발음대로 사용할까 고민을 했습니다. 하지만 'extension'은 그 자체로 키워드이기도 해서 그냥 원 글을 살리는 방향으로 가기로 했습니다. 

[^card]: 카드 관련 예제는 The Swift Programming Language 책에도 자주 나오는 예제인데, 예제 자체도 치밀하게 설계되어 설명하고 있음을 알 수 있습니다.

[^enumeration]: 'enumeration' 은 원래 '열거체'로 번역했었는데, 여기서는 '열거 타입'으로 옮깁니다.