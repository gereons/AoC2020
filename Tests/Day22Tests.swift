//
// Advent of Code 2020 Day 22 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
Player 1:
9
2
6
3
1

Player 2:
5
8
4
7
10
"""

@Suite("Day 22 Tests") 
struct Day22Tests {
    @Test("Day 22 Part 1", .tags(.testInput))
    func testDay22_part1() async {
        let day = Day22(input: testInput)
        #expect(day.part1() == 306)
    }

    @Test("Day 22 Part 1 Solution")
    func testDay22_part1_solution() async {
        let day = Day22(input: Day22.input)
        #expect(day.part1() == 32083)
    }

    @Test("Day 22 Part 2", .tags(.testInput))
    func testDay22_part2() async {
        let day = Day22(input: testInput)
        #expect(day.part2() == 291)
    }

    @Test("Day 22 Part 2 Solution")
    func testDay22_part2_solution() async {
        let day = Day22(input: Day22.input)
        #expect(day.part2() == 35495)
    }
}
