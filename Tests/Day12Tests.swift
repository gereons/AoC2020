//
// Advent of Code 2020 Day 12 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
F10
N3
F7
R90
F11
"""

@Suite("Day 12 Tests") 
struct Day12Tests {
    @Test("Day 12 Part 1", .tags(.testInput))
    func testDay12_part1() async {
        let day = Day12(input: testInput)
        #expect(day.part1() == 25)
    }

    @Test("Day 12 Part 1 Solution")
    func testDay12_part1_solution() async {
        let day = Day12(input: Day12.input)
        #expect(day.part1() == 1645)
    }

    @Test("Day 12 Part 2", .tags(.testInput))
    func testDay12_part2() async {
        let day = Day12(input: testInput)
        #expect(day.part2() == 286)
    }

    @Test("Day 12 Part 2 Solution")
    func testDay12_part2_solution() async {
        let day = Day12(input: Day12.input)
        #expect(day.part2() == 35292)
    }
}
