//
// Advent of Code 2020 Day 18 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2
"""

@Suite("Day 18 Tests") 
struct Day18Tests {
    @Test("Day 18 Part 1", .tags(.testInput))
    func testDay18_part1() async {
        let day = Day18(input: testInput)
        #expect(day.part1() == 13632)
    }

    @Test("Day 18 Part 1 Solution")
    func testDay18_part1_solution() async {
        let day = Day18(input: Day18.input)
        #expect(day.part1() == 18213007238947)
    }

    @Test("Day 18 Part 2", .tags(.testInput))
    func testDay18_part2() async {
        let day = Day18(input: testInput)
        #expect(day.part2() == 23340)
    }

    @Test("Day 18 Part 2 Solution")
    func testDay18_part2_solution() async {
        let day = Day18(input: Day18.input)
        #expect(day.part2() == 388966573054664)
    }
}
