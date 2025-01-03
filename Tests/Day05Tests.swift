//
// Advent of Code 2020 Day 5 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
FBFBBFFRLR
"""

@Suite("Day 5 Tests") 
struct Day05Tests {
    @Test("Day 5 Part 1", .tags(.testInput))
    func testDay05_part1() async {
        let day = Day05(input: testInput)
        #expect(day.part1() == 357)
    }

    @Test("Day 5 Part 1 Solution")
    func testDay05_part1_solution() async {
        let day = Day05(input: Day05.input)
        #expect(day.part1() == 906)
    }

    @Test("Day 5 Part 2 Solution")
    func testDay05_part2_solution() async {
        let day = Day05(input: Day05.input)
        #expect(day.part2() == 519)
    }
}
