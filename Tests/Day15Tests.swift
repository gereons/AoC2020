//
// Advent of Code 2020 Day 15 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
0,3,6
"""

@Suite("Day 15 Tests") 
struct Day15Tests {
    @Test("Day 15 Part 1", .tags(.testInput))
    func testDay15_part1() async {
        let day = Day15(input: testInput)
        #expect(day.part1() == 436)
    }

    @Test("Day 15 Part 1 Solution")
    func testDay15_part1_solution() async {
        let day = Day15(input: Day15.input)
        #expect(day.part1() == 1085)
    }

    @Test("Day 15 Part 2", .tags(.testInput))
    func testDay15_part2() async {
        let day = Day15(input: testInput)
        #expect(day.part2() == 175594)
    }

    @Test("Day 15 Part 2 Solution")
    func testDay15_part2_solution() async {
        let day = Day15(input: Day15.input)
        #expect(day.part2() == 10652)
    }
}
