//
// Advent of Code 2020 Day 10
//

import AoCTools

final class Day10: AdventOfCodeDay {
    let title: String = "Adapter Array"

    let data: [Int]

    init(input: String) {
        data = input.lines.map { Int($0)! }
    }

    func part1() -> Int {
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
                fatalError()
            }
            joltage = current
        }

        return diff1 * diff3
    }

    func part2() -> Int {
        let adapters = data.sorted(by: <)

        let joltage = adapters.last! + 3

        let paths = findPathsTo(joltage, [0] + adapters)
        // print("p10b: number of paths = \(paths)")
        return paths
    }

    private func findPathsTo(_ num: Int, _ data: [Int]) -> Int {
        var memo = [Int: Int]()
        return findPathsTo(num, data, &memo)
    }

    private func findPathsTo(_ num: Int, _ data: [Int], _ memo: inout [Int: Int]) -> Int {
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
