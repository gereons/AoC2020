//
// Advent of Code 2020 Day 1 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
1721
979
366
299
675
1456
"""

@Suite("Day 1 Tests") 
struct Day01Tests {
    @Test("Day 1 Part 1", .tags(.testInput))
    func testDay01_part1() async {
        let day = Day01(input: testInput)
        #expect(day.part1() == 514579)
    }

    @Test("Day 1 Part 1 Solution")
    func testDay01_part1_solution() async {
        let day = Day01(input: Day01.input)
        #expect(day.part1() == 1019571)
    }

    @Test("Day 1 Part 2", .tags(.testInput))
    func testDay01_part2() async {
        let day = Day01(input: testInput)
        #expect(day.part2() == 241861950)
    }

    @Test("Day 1 Part 2 Solution")
    func testDay01_part2_solution() async {
        let day = Day01(input: Day01.input)
        #expect(day.part2() == 100655544)
    }
}
