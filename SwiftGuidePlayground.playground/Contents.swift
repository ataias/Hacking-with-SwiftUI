import UIKit

var str = "Hello, playground"

str.insert("!", at: str.endIndex)

str.insert(contentsOf: " there", at: str.index(before: str.endIndex))

str.remove(at: str.index(before: str.endIndex))
print(str)

let range = str.index(str.endIndex, offsetBy: -6)..<str.endIndex

str.removeSubrange(range)
print(str)

var s = Set<Int>()
s.insert(5)
s.formUnion([1, 2, 3, 4])

s.remove(at: s.index(s.startIndex, offsetBy: 1))
print(s)

let b = Set(s.prefix(2))
let c = Set(s.suffix(2))

func prefix<T: Collection>(c: T, maxLength: Int) {
    c.prefix(maxLength)
}

prefix(c: "asdf", maxLength: 2)

var strings = [
    "act 1 asdf",
    "act 2 ddcc",
    "act 1 2323",
    "act 2 asdf",
    "act 2 cccc"
]

let act1 = strings.filter { $0.hasPrefix("act 1")}
print(act1)

strings.partition(by: { $0.hasPrefix("act 1")})
print(strings)
