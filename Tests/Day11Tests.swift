//
// Advent of Code 2020 Day 11 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
"""

@Suite("Day 11 Tests") 
struct Day11Tests {
    @Test("Day 11 Part 1", .tags(.testInput))
    func testDay11_part1() async {
        let day = Day11(input: testInput)
        #expect(day.part1() == 37)
    }

    @Test("Day 11 Part 1 Solution")
    func testDay11_part1_solution() async {
        let day = Day11(input: Day11.input)
        #expect(day.part1() == 2406)
    }

    @Test("Day 11 Part 2", .tags(.testInput))
    func testDay11_part2() async {
        let day = Day11(input: testInput)
        #expect(day.part2() == 26)
    }

    @Test("Day 11 Part 2 Solution")
    func testDay11_part2_solution() async {
        let day = Day11(input: Day11.input)
        #expect(day.part2() == 2149)
    }
}
