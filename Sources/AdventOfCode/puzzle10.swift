
import Foundation

struct Puzzle10 {
    static let data = """
    16
    10
    15
    5
    1
    11
    7
    19
    6
    12
    4
    """

    static let data2 = """
    28
    33
    18
    42
    31
    14
    46
    20
    48
    47
    24
    23
    49
    45
    19
    38
    39
    11
    1
    32
    25
    35
    8
    17
    7
    9
    4
    2
    34
    10
    3
    """

    static func run() {
        // let data = Self.data2.split(separator: "\n").compactMap { Int($0) }
        let data = readFile(named: "puzzle10.txt").compactMap { Int($0) }

        let adapters = data.sorted(by: <)

        var joltage = 0
        var diff1 = 0
        var diff3 = 1

        for i in 0 ..< adapters.count {
            let current = adapters[i]
            if current - joltage == 1 {
                diff1 += 1
            } else if current - joltage == 3 {
                diff3 += 1
            } else {
                print("oops")
            }
            joltage = current
        }
        joltage += 3

        print("p10a: max joltage: \(joltage) 1-diff:\(diff1), 3-diff:\(diff3) = \(diff1*diff3)")

        let paths = findPathsTo(joltage, [0] + adapters)
        print("p10b: number of paths = \(paths)")
    }

    static func findPathsTo(_ num: Int, _ data: [Int]) -> Int {
        var memo = [Int: Int]()
        return findPathsTo(num, data, &memo)
    }

    static func findPathsTo(_ num: Int, _ data: [Int], _ memo: inout [Int: Int]) -> Int {
        if num == 0 {
            return 1
        }
        if let memo = memo[num] {
            return memo
        }

        var runningTotal = 0
        for i in 1...3 {
            if data.contains(num - i) {
                runningTotal += findPathsTo(num - i, data, &memo)
            }
        }
        memo[num] = runningTotal
        return runningTotal
    }
}
