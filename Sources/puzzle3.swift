import Foundation

extension String {
    func charAt(_ offset: Int) -> String {
        let index = self.index(self.startIndex, offsetBy: offset)
        return String(self[index])
    }
}

extension Array where Element == String {
    func charAt(_ line: Int, _ offset: Int) -> String {
        return self[line].charAt(offset)
    }
}

struct Puzzle3 {
    static func run() {
        let data = Self.rawInput.components(separatedBy: "\n")

        let trees = countTrees(data, slope: (3,1))
        print("p3a: \(trees) trees")

        let slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
        for slope in slopes {
            let trees = countTrees(data, slope: slope)
            print("  p3b: \(trees) trees")
        }

        let trees2 = slopes.reduce(1) {
            return $0 * countTrees(data, slope: $1)
        }
        print("p3b: \(trees2) trees")
    }

    static func countTrees(_ data: [String], slope: (Int, Int)) -> Int {
        let width = data[0].count

        var hPosition = 0
        var vPosition = 0
        var trees = 0

        repeat {
            let isTree = data.charAt(vPosition, hPosition % width) == "#"
            trees += isTree ? 1 : 0

            hPosition += slope.0
            vPosition += slope.1
        } while vPosition < data.count

        return trees
    }
}
