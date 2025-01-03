//
// Advent of Code 2020 Day 2 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
"""

@Suite("Day 2 Tests") 
struct Day02Tests {
    @Test("Day 2 Part 1", .tags(.testInput))
    func testDay02_part1() async {
        let day = Day02(input: testInput)
        #expect(day.part1() == 2)
    }

    @Test("Day 2 Part 1 Solution")
    func testDay02_part1_solution() async {
        let day = Day02(input: Day02.input)
        #expect(day.part1() == 603)
    }

    @Test("Day 2 Part 2", .tags(.testInput))
    func testDay02_part2() async {
        let day = Day02(input: testInput)
        #expect(day.part2() == 1)
    }

    @Test("Day 2 Part 2 Solution")
    func testDay02_part2_solution() async {
        let day = Day02(input: Day02.input)
        #expect(day.part2() == 404)
    }
}
