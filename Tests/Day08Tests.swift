//
// Advent of Code 2020 Day 8 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
"""

@Suite("Day 8 Tests") 
struct Day08Tests {
    @Test("Day 8 Part 1", .tags(.testInput))
    func testDay08_part1() async {
        let day = Day08(input: testInput)
        #expect(day.part1() == 5)
    }

    @Test("Day 8 Part 1 Solution")
    func testDay08_part1_solution() async {
        let day = Day08(input: Day08.input)
        #expect(day.part1() == 2080)
    }

    @Test("Day 8 Part 2", .tags(.testInput))
    func testDay08_part2() async {
        let day = Day08(input: testInput)
        #expect(day.part2() == 8)
    }

    @Test("Day 8 Part 2 Solution")
    func testDay08_part2_solution() async {
        let day = Day08(input: Day08.input)
        #expect(day.part2() == 2477)
    }
}
