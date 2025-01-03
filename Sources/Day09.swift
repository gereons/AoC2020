//
// Advent of Code 2020 Day 9
//

import AoCTools

final class Day09: AdventOfCodeDay {
    let title = "Encoding Error"

    let data: [Int]
    
    init(input: String) {
        // let data = Self.data.components(separatedBy: "\n").compactMap { Int($0) }
        data = input.lines.compactMap { Int($0) }
    }

    func part1() -> Int {
        part1(preambleLength: 25)
    }

    func part1(preambleLength: Int) -> Int {
        let weakness = findFirstInvalid(in: data, preambleLength: preambleLength)
        // print("p9a: first mismatch \(weakness)")
        return weakness
    }

    func part2() -> Int {
        part2(preambleLength: 25)
    }

    func part2(preambleLength: Int) -> Int {
        let weakness = findFirstInvalid(in: data, preambleLength: preambleLength)
        let range = findRange(in: data, sum: weakness)
        let min = range.min(by: <)!
        let max = range.max(by: <)!
        // print("p9b: range \(min + max)")
        return min + max
    }

    private func findFirstInvalid(in data: [Int], preambleLength: Int) -> Int {
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

    private func findRange(in data: [Int], sum: Int) -> [Int] {
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

    private func isValid(_ number: Int, _ candidates: [Int]) -> Bool {
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
