//: [Previous](@previous)

protocol Summable {
    var sum: Int { get }
}

extension Summable {
    var sum: Int {
        get {
            return 0
        }
    }
}

extension Int: Summable {
    var sum: Int {
        get {
            return self.hashValue
        }
    }
}

extension CollectionType where Generator.Element: Summable {
    var sum: Int {
        let itemsSum = self.map({ $0.sum }).reduce(0, combine: +)
        
        return itemsSum
    }
}

let testInt = [1, 2, 3, 4, 5]

print("\(testInt.sum)")

//: [Next](@next)
