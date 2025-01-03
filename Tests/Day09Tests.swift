//
// Advent of Code 2020 Day 9 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
"""

@Suite("Day 9 Tests") 
struct Day09Tests {
    @Test("Day 9 Part 1", .tags(.testInput))
    func testDay09_part1() async {
        let day = Day09(input: testInput)
        #expect(day.part1(preambleLength: 5) == 127)
    }

    @Test("Day 9 Part 1 Solution")
    func testDay09_part1_solution() async {
        let day = Day09(input: Day09.input)
        #expect(day.part1() == 144381670)
    }

    @Test("Day 9 Part 2", .tags(.testInput))
    func testDay09_part2() async {
        let day = Day09(input: testInput)
        #expect(day.part2(preambleLength: 5) == 62)
    }

    @Test("Day 9 Part 2 Solution")
    func testDay09_part2_solution() async {
        let day = Day09(input: Day09.input)
        #expect(day.part2() == 20532569)
    }
}
