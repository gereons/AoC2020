//
// Advent of Code 2020 Day 3
//

import AoCTools

final class Day03: AdventOfCodeDay {
    let title = "Toboggan Trajectory"

    let lines: [String]

    init(input: String) {
        lines = input.lines
    }

    func part1() -> Int {
        countTrees(lines, slope: (3, 1))
    }

    func part2() -> Int {
        let slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
        return slopes.reduce(1) {
            return $0 * countTrees(lines, slope: $1)
        }
    }

    private func countTrees(_ data: [String], slope: (Int, Int)) -> Int {
        let width = data[0].count

        var hPosition = 0
        var vPosition = 0
        var trees = 0

        repeat {
            let isTree = data[vPosition][hPosition % width] == "#"
            trees += isTree ? 1 : 0

            hPosition += slope.0
            vPosition += slope.1
        } while vPosition < data.count

        return trees
    }
}
