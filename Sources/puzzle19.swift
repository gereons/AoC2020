import Foundation

struct Puzzle19 {

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

    static let data = """
    0: 4 1 5
    1: 2 3 | 3 2
    2: 4 4 | 5 5
    3: 4 5 | 5 4
    4: "a"
    5: "b"

    ababbb
    bababa
    abbbab
    aaabbb
    aaaabbb
    """.components(separatedBy: "\n")

    static func run() {
        var rules = [Int: Rule]()
        var messages = [String]()

        // let data = Self.data
        var data = Self.rawInput.components(separatedBy: "\n")
        // part2 - add rules:
        data.append(contentsOf: [
        "8: 42 | 42 908",
        "908: 42 | 42 918",
        "918: 42 | 42 928",
        "928: 42 | 42 938",
        "938: 42 | 42 948",
        "948: 42 | 42 958",
        "958: 42 | 42 968",
        "968: 42 | 42 978",
        "978: 42",
        "11: 42 31 | 42 9011 31",
        "9011: 42 31 | 42 9111 31",
        "9111: 42 31 | 42 9211 31",
        "9211: 42 31 | 42 9311 31",
        "9311: 42 31 | 42 9411 31",
        "9411: 42 31 | 42 9511 31",
        "9511: 42 31 | 42 9611 31",
        "9611: 42 31 | 42 9711 31",
        "9711: 42 31 | 42 9811 31",
        "9811: 42 31",
        ])

        for line in data {
            let parts = line.components(separatedBy: ": ")
            if parts.count == 2 {
                rules[Int(parts[0])!] = Rule(parts[1])
            } else if !parts[0].isEmpty {
                messages.append(parts[0])
            }
        }

        var count = 0
        let regex = try! NSRegularExpression(pattern: buildRegex(rules, index: 0), options: [])
        for msg in messages {
            let range = NSRange(location: 0, length: msg.count)
            let matches = regex.matches(in: msg, options: [], range: range)
            if !matches.isEmpty && matches[0].range.length == msg.count {
                count += 1
            }
        }
        print("matching msgs: \(count)")
    }

    static func buildRegex(_ rules: [Int: Rule], index: Int) -> String {
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
