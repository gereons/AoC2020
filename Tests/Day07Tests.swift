//
// Advent of Code 2020 Day 7 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""

@Suite("Day 7 Tests") 
struct Day07Tests {
    @Test("Day 7 Part 1", .tags(.testInput))
    func testDay07_part1() async {
        let day = Day07(input: testInput)
        #expect(day.part1() == 4)
    }

    @Test("Day 7 Part 1 Solution")
    func testDay07_part1_solution() async {
        let day = Day07(input: Day07.input)
        #expect(day.part1() == 121)
    }

    @Test("Day 7 Part 2", .tags(.testInput))
    func testDay07_part2() async {
        let day = Day07(input: testInput)
        #expect(day.part2() == 32)
    }

    @Test("Day 7 Part 2 Solution")
    func testDay07_part2_solution() async {
        let day = Day07(input: Day07.input)
        #expect(day.part2() == 3805)
    }
}
