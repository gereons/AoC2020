//
// Advent of Code 2020 Day 15
//

import AoCTools

final class Day15: AdventOfCodeDay {
    let title: String = "Rambunctious Recitation"

    let input: [Int]

    init(input: String) {
        self.input = input.integers()
    }

    func part1() -> Int {
        let last = sayNumbers(input, turns: 2020)
        // print("p15a: last number is \(last)")
        return last
    }

    func part2() -> Int {
        let last2 = sayNumbers(input, turns: 30000000)
        // print("p15b: last number is \(last2)")
        return last2
    }

    private func sayNumbers(_ input: [Int], turns: Int) -> Int {
        var spoken = [Int: [Int]]()
        var lastSpoken = input.last!

        for (index, num) in input.enumerated() {
            spoken[num] = [index + 1]
        }

        for turn in input.count + 1 ... turns {
            var say: Int
            let turnsSpoken = spoken[lastSpoken]!
            if turnsSpoken.count == 1 {
                say = 0
            } else {
                say = turnsSpoken[0] - turnsSpoken[1]
            }

            spoken[say, default:[]].insert(turn, at: 0)
            spoken[say] = Array(spoken[say]!.prefix(2))
            lastSpoken = say
        }

        return lastSpoken
    }
}
