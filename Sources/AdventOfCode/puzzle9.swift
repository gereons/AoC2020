import Foundation

struct Puzzle9 {
    static let data = """
    35
    20
    15
    25
    47
    40
    62
    55
    65
    95
    102
    117
    150
    182
    127
    219
    299
    277
    309
    576
    """

    static func run() {
        // let data = Self.data.components(separatedBy: "\n").compactMap { Int($0) }
        let data = readFile(named: "puzzle9.txt").compactMap { Int($0) }

        let weakness = findFirstInvalid(in: data, preambleLength: 25)
        print("p9a: first mismatch \(weakness)")

        let range = findRange(in: data, sum: weakness)
        let min = range.min(by: <)!
        let max = range.max(by: <)!
        print("p9b: range \(min + max)")
    }

    static func findFirstInvalid(in data: [Int], preambleLength: Int) -> Int {
        var candidates = Array(data.prefix(preambleLength))
        for number in data.dropFirst(preambleLength) {
            if isValid(number, candidates) {
                candidates.removeFirst()
                candidates.append(number)
            } else {
                return number
            }
        }

        return 0
    }

    static func findRange(in data: [Int], sum: Int) -> [Int] {
        for start in 0 ..< data.count {
            var len = 2
            var check = 0

            if start + len >= data.count {
                break
            }

            repeat {
                check = data[start..<start+len].reduce(0, +)
                if check == sum {
                    return Array(data[start ..< start+len])
                }
                len += 1
            } while check < sum
        }

        return []
    }

    static func isValid(_ number: Int, _ candidates: [Int]) -> Bool {
        for i in candidates {
            for j in candidates {
                if i != j && i+j == number {
                    return true
                }
            }
        }
        return false
    }
}
