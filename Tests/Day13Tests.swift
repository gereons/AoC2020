//
// Advent of Code 2020 Day 13 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
939
7,13,x,x,59,x,31,19
"""

@Suite("Day 13 Tests") 
struct Day13Tests {
    @Test("Day 13 Part 1", .tags(.testInput))
    func testDay13_part1() async {
        let day = Day13(input: testInput)
        #expect(day.part1() == 295)
    }

    @Test("Day 13 Part 1 Solution")
    func testDay13_part1_solution() async {
        let day = Day13(input: Day13.input)
        #expect(day.part1() == 3246)
    }

    @Test("Day 13 Part 2", .tags(.testInput))
    func testDay13_part2() async {
        let day = Day13(input: testInput)
        #expect(day.part2() == 1068781)
    }

    @Test("Day 13 Part 2 Solution")
    func testDay13_part2_solution() async {
        let day = Day13(input: Day13.input)
        #expect(day.part2() == 1010182346291467)
    }
}
