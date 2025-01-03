//
// Advent of Code 2020 Day 19
//

import AoCTools
import Foundation

final class Day19: AdventOfCodeDay {
    let title: String = "Monster Messages"

    enum RulePart {
        case ref(Int)
        case char(Character)
    }

    struct Rule {
        let r1: [RulePart]
        let r2: [RulePart]

        init(_ str: String) {
            let parts = str.components(separatedBy: " | ")
            self.r1 = Self.parse(parts[0])
            self.r2 = parts.count == 2 ? Self.parse(parts[1]) : []
        }

        private static func parse(_ str: String) -> [RulePart] {
            if str.hasPrefix("\"") {
                let index = str.index(str.startIndex, offsetBy: 1)
                return [.char(str[index])]
            } else {
                let parts = str.components(separatedBy: " ")
                return parts.map { RulePart.ref(Int($0)!) }
            }
        }
    }

    let rules: [Int: Rule]
    let messages: [String]

    init(input: String) {
        var rules = [Int: Rule]()
        var messages = [String]()

        for line in input.lines {
            let parts = line.components(separatedBy: ": ")
            if parts.count == 2 {
                rules[Int(parts[0])!] = Rule(parts[1])
            } else if !parts[0].isEmpty {
                messages.append(parts[0])
            }
        }

        self.rules = rules
        self.messages = messages
    }

    func part1() -> Int {
        evaluateRules(rules: rules)
    }

    func part2() -> Int {
        var rules = self.rules

        let newRules = [
            8: Rule("42 | 42 908"),
            908: Rule("42 | 42 918"),
            918: Rule("42 | 42 928"),
            928: Rule("42 | 42 938"),
            938: Rule("42 | 42 948"),
            948: Rule("42 | 42 958"),
            958: Rule("42 | 42 968"),
            968: Rule("42 | 42 978"),
            978: Rule("42"),
            11: Rule("42 31 | 42 9011 31"),
            9011: Rule("42 31 | 42 9111 31"),
            9111: Rule("42 31 | 42 9211 31"),
            9211: Rule("42 31 | 42 9311 31"),
            9311: Rule("42 31 | 42 9411 31"),
            9411: Rule("42 31 | 42 9511 31"),
            9511: Rule("42 31 | 42 9611 31"),
            9611: Rule("42 31 | 42 9711 31"),
            9711: Rule("42 31 | 42 9811 31"),
            9811: Rule("42 31")
        ]
        for (key, rule) in newRules {
            rules[key] = rule
        }
        return evaluateRules(rules: rules)
    }

    private func evaluateRules(rules: [Int: Rule]) -> Int {
        var count = 0
        let regex = try! NSRegularExpression(pattern: buildRegex(rules, index: 0), options: [])
        for msg in messages {
            let range = NSRange(location: 0, length: msg.count)
            let matches = regex.matches(in: msg, options: [], range: range)
            if !matches.isEmpty && matches[0].range.length == msg.count {
                count += 1
            }
        }
        // print("matching msgs: \(count)")
        return count
    }

    private func buildRegex(_ rules: [Int: Rule], index: Int) -> String {
        let rule = rules[index]!

        var str = ""
        for r in rule.r1 {
            switch r {
            case .char(let ch): str.append(ch)
            case .ref(let idx): str.append(buildRegex(rules, index: idx))
            }
        }

        if !rule.r2.isEmpty {
            var str2 = ""
            for r in rule.r2 {
                switch r {
                case .char(let ch): str2.append(ch)
                case .ref(let idx): str2.append(buildRegex(rules, index: idx))
                }
            }
            str = "(\(str)|\(str2))"
        }
        return str
    }
}
