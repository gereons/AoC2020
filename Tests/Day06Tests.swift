//
// Advent of Code 2020 Day 6 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
abc

a
b
c

ab
ac

a
a
a
a

b
"""

@Suite("Day 6 Tests") 
struct Day06Tests {
    @Test("Day 6 Part 1", .tags(.testInput))
    func testDay06_part1() async {
        let day = Day06(input: testInput)
        #expect(day.part1() == 11)
    }

    @Test("Day 6 Part 1 Solution")
    func testDay06_part1_solution() async {
        let day = Day06(input: Day06.input)
        #expect(day.part1() == 6443)
    }

    @Test("Day 6 Part 2", .tags(.testInput))
    func testDay06_part2() async {
        let day = Day06(input: testInput)
        #expect(day.part2() == 6)
    }

    @Test("Day 6 Part 2 Solution")
    func testDay06_part2_solution() async {
        let day = Day06(input: Day06.input)
        #expect(day.part2() == 3232)
    }
}
