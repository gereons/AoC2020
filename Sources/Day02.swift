//
// Advent of Code 2020 Day 2
//

import AoCTools
import Foundation

final class Day02: AdventOfCodeDay {
    let title = "Password Philosophy"

    struct Entry {
        let min, max: Int
        let letter: Character
        let password: String

        var isSledValid: Bool {
            let frequencies = letterFrequencies(password)
            if let occurs = frequencies[letter] {
                return occurs >= min && occurs <= max
            } else {
                return false
            }
        }

        var isTobboganValid: Bool {
            let ch1 = password[min - 1]
            let ch2 = password[max - 1]

            return (ch1 == letter) != (ch2 == letter)
        }

        func letterFrequencies(_ str: String) -> [Character: Int] {
            let chars = str.map { $0 }
            var freq = [Character: Int]()
            for ch in chars {
                freq[ch, default: 0] += 1
            }
            return freq
        }
    }

    let entries: [Entry]

    init(input: String) {
        var entries = [Entry]()
        let regex = try! NSRegularExpression(pattern: #"(\d*)-(\d*) (.): (.*)"#, options: .caseInsensitive)
        for line in input.lines {
            let range = NSRange(location: 0, length: line.count)
            if let match = regex.firstMatch(in: line, options: .anchored, range: range) {
                let min = Int(line[Range(match.range(at: 1), in: line)!])!
                let max = Int(line[Range(match.range(at: 2), in: line)!])!
                let letter = String(line[Range(match.range(at: 3), in: line)!])
                let password = String(line[Range(match.range(at: 4), in: line)!])

                entries.append(Entry(min: min, max: max, letter: Character(letter), password: password))
            }
        }

        self.entries = entries
    }

    func part1() -> Int {
        var valid = 0
        for entry in entries {
            if entry.isSledValid {
                valid += 1
            }
        }
        return valid
    }

    func part2() -> Int {
        var valid = 0
        for entry in entries {
            if entry.isTobboganValid {
                valid += 1
            }
        }
        return valid
    }
}
