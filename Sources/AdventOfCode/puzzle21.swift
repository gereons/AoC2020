import Foundation

struct Puzzle21 {
    static let data = """
    mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
    trh fvjkl sbzzf mxmxvkd (contains dairy)
    sqjhc fvjkl (contains soy)
    sqjhc mxmxvkd sbzzf (contains fish)
    """.components(separatedBy: "\n")

    static func run() {
        let lines = Self.data

        var xx = [String: [Set<String>]]()

        for line in lines {
            let parts = line.components(separatedBy: " (contains ")
            let ingredients = parts[0].components(separatedBy: " ")
            let allergens = parts[1].dropLast().components(separatedBy: ", ")

            for ing in ingredients {
                xx[ing, default: []].append(Set(allergens))
            }

        }
        print(xx)
    }
}

struct PowerCollection<C : Collection> : Collection {
    typealias Index = [C.Index]
    typealias Element = [C.Element]

    var startIndex, endIndex: Index

    subscript(position: Index) -> [C.Element] {
        return []
    }

    func index(after i: Index) -> Index {
        return i
    }

}

extension Array : Comparable where Element : Comparable {
    public static func < (lhs: [Element], rhs: [Element]) -> Bool {
        return false
    }
}
