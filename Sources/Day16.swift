//
// Advent of Code 2020 Day 16
//

import AoCTools

final class Day16: AdventOfCodeDay {
    let title: String = "Ticket Translation"

    struct Rule: Equatable {
        let name: String
        let ranges: [ClosedRange<Int>]

        func matches(_ ticket: [Int]) -> Bool {
            var matches = 0
            for n in ticket {
                for range in ranges {
                    if range.contains(n) {
                        matches += 1
                    }
                }
            }
            // print("\(ticket) in \(ranges) -> \(matches)")
            return matches > 0
        }

        init(_ str: String) {
            // departure location: 42-570 or 579-960
            // wagon: 32-816 or 825-971
            let parts = str.split(separator: ":")
            name = String(parts[0])
            let ints = str.integers()
            ranges = [
                ints[0]...abs(ints[1]),
                ints[2]...abs(ints[3])
            ]

        }
    }

    let rules: [Rule]
    let myTicket: [Int]
    let tickets: [[Int]]

    init(input: String) {
        let groups = input.lines.grouped(by: \.isEmpty)

        rules = groups[0].map { Rule($0) }
        myTicket = groups[1][1].integers()
        tickets = groups[2].dropFirst().map { $0.integers() }
    }

    func part1() -> Int {
        var errors = [Int]()
        for ticket in tickets {
            errors.append(contentsOf: matchTicket(ticket))
        }
        // print("p16a: \(errors) \(errors.reduce(0, +))")
        return errors.reduce(0, +)
    }

    func part2() -> Int {
        let validTickets = tickets.filter { matchTicket($0) == [] }
        // print(validTickets.count)

        var candidateRules = [[Rule]]()
        for _ in 0 ..< myTicket.count {
            candidateRules.append(rules)
        }

        for idx in 0 ..< myTicket.count {
            for ticket in validTickets {
                let num = ticket[idx]

                for rule in rules {
                    var mismatches = 0
                    for range in rule.ranges {
                        if !range.contains(num) {
                            // this rule can't be responsible for column `index`.
                            mismatches += 1
                        }
                    }
                    if mismatches == rule.ranges.count {
                        // print("\(num) does not match \(rule)")
                        candidateRules[idx].removeAll(where: { $0.name == rule.name })
                        if candidateRules[idx].isEmpty {
                            print("oops")
                        }
                    }
                }
            }
        }

        repeat {
            for idx in 0..<candidateRules.count {
                let rules = candidateRules[idx]
                if rules.count == 1 {
                    // remove this rule from all other rows
                    for idx2 in 0 ..< candidateRules.count {
                        if idx2 == idx { continue }
                        candidateRules[idx2].removeAll { $0.name == rules[0].name }
                    }
                }
            }
        } while candidateRules.first(where: { $0.count > 1 } ) != nil

        var result = 1
        for (index, rule) in candidateRules.enumerated() {
            if rule[0].name.hasPrefix("departure") {
                result *= myTicket[index]
            }
        }

        // print("p16b: result \(result)")
        return result
    }

    private func findMatchingRules(_ ticket: [Int]) -> [Rule] {
        var result = [Rule]()
        for rule in rules {
            if rule.matches(ticket) {
                result.append(rule)
            }
        }
        return result
    }

    private func matchTicket(_ ticket: [Int]) -> [Int] {
        var errors = [Int]()
        for number in ticket {
            if violatesAllRules(number) {
                errors.append(number)
            }
        }
        return errors
    }

    private func violatesAllRules(_ n: Int) -> Bool {
        var violations = 0
        for rule in rules {
            if violatesAllPatterns(n, rule) {
                violations += 1
            }
        }
        return violations == rules.count
    }

    private func violatesAllPatterns(_ n: Int, _ rule: Rule) -> Bool {
        var violations = 0
        for range in rule.ranges {
            if !range.contains(n) {
                violations += 1
            }
        }
        return violations == rule.ranges.count
    }
}
