import Foundation

struct Puzzle2 {
    struct Entry {
        let min, max: Int
        let letter, password: String

        var isSledValid: Bool {
            let frequencies = letterFrequencies(password)
            if let occurs = frequencies[letter] {
                return occurs >= min && occurs <= max
            } else {
                return false
            }
        }

        var isTobboganValid: Bool {
            let idx1 = password.index(password.startIndex, offsetBy: min - 1)
            let ch1 = String(password[idx1])
            let idx2 = password.index(password.startIndex, offsetBy: max - 1)
            let ch2 = String(password[idx2])

            return (ch1 == letter) != (ch2 == letter)
        }

        func letterFrequencies(_ str: String) -> [String: Int] {
            let chars = str.map { $0 }
            var freq = [String: Int]()
            for ch in chars {
                freq[String(ch), default: 0] += 1
            }
            return freq
        }
    }

    static func run() {
        let data = readFile(named: "puzzle2.txt")
        var entries = [Entry]()
        let regex = try! NSRegularExpression(pattern: "(\\d*)-(\\d*) (.): (.*)", options: .caseInsensitive)
        for line in data {
            let range = NSRange(location: 0, length: line.count)
            if let match = regex.firstMatch(in: line, options: .anchored, range: range) {
                let min = Int(line[Range(match.range(at: 1), in: line)!])!
                let max = Int(line[Range(match.range(at: 2), in: line)!])!
                let letter = String(line[Range(match.range(at: 3), in: line)!])
                let password = String(line[Range(match.range(at: 4), in: line)!])

                entries.append(Entry(min: min, max: max, letter: letter, password: password))
            }
        }

        print("p2a: valid \(part1(entries))")
        print("p2b: valid \(part2(entries))")
    }

    static func part1(_ entries: [Entry]) -> Int {
        var valid = 0
        for entry in entries {
            if entry.isSledValid {
                valid += 1
            }
        }
        return valid
    }

    static func part2(_ entries: [Entry]) -> Int {
        var valid = 0
        for entry in entries {
            if entry.isTobboganValid {
                valid += 1
            }
        }
        return valid
    }
}
