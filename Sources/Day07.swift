//
// Advent of Code 2020 Day 7
//

import AoCTools
import Foundation

private struct Bag {
    let color: String
    let count: Int
    let contained: [Bag]
}

final class Day07: AdventOfCodeDay {
    let title: String = "Handy Haversacks"

    private let bags: [Bag]

    init(input: String) {
        bags = Self.createBags(from: input.lines)
    }

    func part1() -> Int {
        let count1 = howManyCanContain(bags, "shiny gold")
        // print("p7a: shiny gold goes into \(count1) bags")
        return count1
    }

    func part2() -> Int {
        let count2 = howManyIn(bags, "shiny gold")
        // print("p7b: shiny gold contains \(count2) bags")
        return count2
    }

    private static func createBags(from data: [String]) -> [Bag] {
        let containerRE = try! NSRegularExpression(pattern: #"(.*) bags contain"#, options: .caseInsensitive)
        let containRE = try! NSRegularExpression(pattern: #"(\d*) (\S* \S*) bag"#, options: .caseInsensitive)
        var bags = [Bag]()
        for rule in data {
            let range = NSRange(location: 0, length: rule.count)
            if let m1 = containerRE.firstMatch(in: rule, options: [], range: range) {
                let color = rule[Range(m1.range(at: 1), in: rule)!]

                var contains = [Bag]()
                let m2 = containRE.matches(in: rule, options: [], range: range)
                for match in m2 {
                    let s1 = rule[Range(match.range(at: 1), in: rule)!]
                    let s2 = rule[Range(match.range(at: 2), in: rule)!]
                    if let num = Int(s1) {
                        contains.append(Bag(color: String(s2), count: num, contained: []))
                    }
                }
                bags.append(Bag(color: String(color), count: 0, contained: contains))
            }
        }
        return bags
    }

    private func howManyCanContain(_ bags: [Bag], _ color: String) -> Int {
        var containerColors = Set<String>()
        howManyCanContain(bags, color, &containerColors)
        return containerColors.count
    }

    private func howManyCanContain(_ bags: [Bag], _ color: String, _ containerColors: inout Set<String>) {
        let containers = bags.filter { $0.contained.first(where: { $0.color == color }) != nil }
        containerColors.formUnion(Set(containers.map { $0.color }))
        for container in containers {
            howManyCanContain(bags, container.color, &containerColors)
        }
    }

    private func howManyIn(_ bags: [Bag], _ color: String) -> Int {
        let contains = bags.filter { $0.color == color }

        var count = contains.reduce(0) { $0 + $1.contained.reduce(0) { $0 + $1.count } }

        for contain in contains {
            for (cnt, color) in contain.contained.map({ ($0.count, $0.color) }) {
                count += cnt * howManyIn(bags, color)
            }
        }

        return count
    }
}
