//
// Advent of Code 2020 Day 1
//

import AoCTools

final class Day01: AdventOfCodeDay {
    let title = "Report Repair"

    let expenses: Set<Int>

    init(input: String) {
        expenses = Set(input.lines.map { Int($0)! })
    }

    func part1() -> Int {
        for i in expenses {
            let test = 2020 - i
            if expenses.contains(test) {
                // print("p1a: found pair: \(i) \(test) = \(i * test)")
                return i * test
            }
        }
        fatalError()
    }

    func part2() -> Int {
        for i in expenses {
            for j in expenses {
                if i == j {
                    continue
                }
                let test = 2020 - i - j
                if test > 0 && expenses.contains(test) {
                    // print("p1b: found triplet: \(i) \(j) \(test) = \(i * j * test)")
                    return i * j * test
                }
            }
        }
        fatalError()
    }
}
