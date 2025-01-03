//
// Advent of Code 2020 Day 14 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput1 = """
mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0
"""

fileprivate let testInput2 = """
mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1
"""

@Suite("Day 14 Tests") 
struct Day14Tests {
    @Test("Day 14 Part 1", .tags(.testInput))
    func testDay14_part1() async {
        let day = Day14(input: testInput1)
        #expect(day.part1() == 165)
    }

    @Test("Day 14 Part 1 Solution")
    func testDay14_part1_solution() async {
        let day = Day14(input: Day14.input)
        #expect(day.part1() == 11926135976176)
    }

    @Test("Day 14 Part 2", .tags(.testInput))
    func testDay14_part2() async {
        let day = Day14(input: testInput2)
        #expect(day.part2() == 208)
    }

    @Test("Day 14 Part 2 Solution")
    func testDay14_part2_solution() async {
        let day = Day14(input: Day14.input)
        #expect(day.part2() == 4330547254348)
    }
}
