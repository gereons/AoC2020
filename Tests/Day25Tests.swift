//
// Advent of Code 2020 Day 25 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
5764801
17807724
"""

@Suite("Day 25 Tests") 
struct Day25Tests {
    @Test("Day 25 Part 1", .tags(.testInput))
    func testDay25_part1() async {
        let day = Day25(input: testInput)
        #expect(day.part1() == 14897079)
    }

    @Test("Day 25 Part 1 Solution")
    func testDay25_part1_solution() async {
        let day = Day25(input: Day25.input)
        #expect(day.part1() == 1478097)
    }
}
