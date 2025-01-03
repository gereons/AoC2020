//
// Advent of Code 2020 Day 6
//

import AoCTools

final class Day06: AdventOfCodeDay {
    let title = "Custom Customs"

    let answers: [String]

    init(input: String) {
        let groups = input.lines.grouped(by: \.isEmpty)
        answers = groups.map { $0.joined(separator: " ")}
    }

    func part1() -> Int {
        // part 1
        let sum = answers.reduce(0) { $0 + getUniqueCount($1) }
        // print("p6a: \(sum) answers")
        return sum
    }

    func part2() -> Int {
        // part 2
        let sum2 = answers.reduce(0) { $0 + getAgreeingCount($1) }
        // print("p6b: \(sum2) answers")
        return sum2
    }

    private func getAgreeingCount(_ str: String) -> Int {
        let people = str.components(separatedBy: " ")

        let answers = people.map { Set($0.map { $0 }) }

        let result = answers.reduce(answers[0]) { $0.intersection($1) }

        return result.count
    }

    private func getUniqueCount(_ str: String) -> Int {
        var set = Set<Character>()

        for ch in str.replacingOccurrences(of: " ", with: "") {
            set.insert(ch)
        }

        return set.count
    }
}
