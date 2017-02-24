이 글은 [Swift](https://swift.org) 공식 페이지의 [Package Manager](https://swift.org/package-manager/#conceptual-overview) 글을 정리한 것입니다. [^swift-org] [^swift-package-manager]

## 패키지 관리자 (Package Manager)

Swift 패키지 관리자는 Swift 코드의 배포를 관리하는 도구입니다. 의존성을 가진 파일들을 다운로드, 컴파일, 링크하는 과정을 자동화하기 위해 Swift 빌드 시스템과 통합되었습니다.

패키지 관리자는 Swift 3.0 이상부터 적용됩니다.

### 기본 개념

이 번 장에서는 Swift 패키지 관리자가 어떤 의도로 만들어졌는지 그 기본 개념에 대해서 설명합니다.

#### 모듈 (Modules)

Swift organizes code into modules. Each module specifies a namespace and enforces access controls on which parts of that code can be used outside of the module.

A program may have all of its code in a single module, or it may import other modules as dependencies. Aside from the handful of system-provided modules, such as Darwin on macOS or Glibc on Linux, most dependencies require code to be downloaded and built in order to be used.

When you use a separate module for code that solves a particular problem, that code can be reused in other situations. For example, a module that provides functionality for making network requests can be shared between a photo sharing app and a weather app. Using modules lets you build on top of other developers’ code rather than reimplementing the same functionality yourself.

#### Packages

A package consists of Swift source files and a manifest file. The manifest file, called Package.swift, defines the package’s name and its contents using the PackageDescription module.

A package has one or more targets. Each target specifies a product and may declare one or more dependencies.

#### Products

A target may build either a library or an executable as its product. A library contains a module that can be imported by other Swift code. An executable is a program that can be run by the operating system.

#### Dependencies

A target’s dependencies are modules that are required by code in the package. A dependency consists of a relative or absolute URL to the source of the package and a set of requirements for the version of the package that can be used. The role of the package manager is to reduce coordination costs by automating the process of downloading and building all of the dependencies for a project. This is a recursive process: A dependency can have its own dependencies, each of which can also have dependencies, forming a dependency graph. The package manager downloads and builds everything that is needed to satisfy the entire dependency graph.

> The following section assumes a working knowledge of Swift. If you’re new to the language, you may want consult one of the introductory resources first. We recommend A Swift Tour in The Swift Programming Language.
> 
> If you want to follow along with the code examples, you’ll need to have a working installation of Swift. You can find instructions for how to install Swift in Getting Started.

### Example Usage

In Getting Started, a simple “Hello, world!” program is built with the Swift Package Manager.

To provide a more complete look at what the Swift Package Manager can do, the following example consists of four interdependent packages:

* PlayingCard - Defines PlayingCard, Suit, and Rank types.
* FisherYates - Defines an extension that implements the shuffle() and shuffleInPlace() methods.
* DeckOfPlayingCards - Defines a Deck type that shuffles and deals an array of PlayingCard values.
* Dealer - Defines an executable that creates a DeckOfPlayingCards, shuffles it, and deals the first 10 cards.

> You can build and run the complete example by downloading the source code of the [Dealer project from GitHub](https://github.com/apple/example-package-dealer) and running the following commands:
> 
> ```sh
> $ cd example-package-dealer
> $ swift build
> $ .build/debug/Dealer
> ```

#### Creating a Library Package

We’ll start by creating a module representing a playing card in a standard 52-card deck. The PlayingCard module defines the PlayingCard type, which consists of a Suit enumeration value (Clubs, Diamonds, Hearts, Spades) and a Rank enumeration value (Ace, Two, Three, ..., Jack, Queen, King).

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

By convention, a package includes any source files located in the Sources/ directory.

```sh
example-package-playingcard
├── Sources
│   ├── PlayingCard.swift
│   ├── Rank.swift
│   └── Suit.swift
└── Package.swift
```

Because the PlayingCard module does not produce an executable, it can be described as a library. A library is a package that builds a module which can be imported by other packages. By default, a library module exposes all of the public types and methods declared in source code located in the Sources/ directory.

Run swift build to start the Swift build process. If everything worked correctly, it will compile the Swift module for PlayingCard.

> The complete code for the PlayingCard package can be found at <https://github.com/apple/example-package-playingcard>.

#### Using Build Configuration Statements

The next module you’re going to build is FisherYates. Unlike PlayingCard, this module does not define any new types. Instead, it extends an existing type – specifically the CollectionType and MutableCollectionType protocols – to add the shuffle() method and its mutating counterpart shuffleInPlace().

The implementation of shuffleInPlace() uses the Fisher-Yates algorithm to randomly permute the elements in a collection. Because the Swift Standard Library does not provide a random number generator, this method must call a function imported from a system module. For this function to be compatible with both macOS and Linux, the code uses build configuration statements.

In macOS, the system module is Darwin, which provides the arc4random_uniform(_:) function. In Linux, the system module is Glibc, which provides the random() function:

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

> The complete code for the FisherYates package can be found at <https://github.com/apple/example-package-fisheryates>.

#### Importing Dependencies

The DeckOfPlayingCards package brings the previous two packages together: It defines a Deck type that uses the shuffle() method from FisherYates on an array of PlayingCard values.

To use the FisherYates and PlayingCards modules, the DeckOfPlayingCards package must declare their packages as dependencies in its Package.swift manifest file.

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

[^swift-org]: 애플에서는 Swift 를 오픈 소스로 공개하면서 [Welcome to Swift.org](https://swift.org) 라는 공식 페이지도 만들고 블로그도 운영하면서 Swift 관련 소식들을 알리고 있습니다.

[^swift-package-manager]: [Package Manager](https://swift.org/package-manager/#conceptual-overview)