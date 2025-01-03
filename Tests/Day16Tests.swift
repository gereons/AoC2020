//
// Advent of Code 2020 Day 16 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12
"""

@Suite("Day 16 Tests") 
struct Day16Tests {
    @Test("Day 16 Part 1", .tags(.testInput))
    func testDay16_part1() async {
        let day = Day16(input: testInput)
        #expect(day.part1() == 71)
    }

    @Test("Day 16 Part 1 Solution")
    func testDay16_part1_solution() async {
        let day = Day16(input: Day16.input)
        #expect(day.part1() == 24980)
    }

    @Test("Day 16 Part 2 Solution")
    func testDay16_part2_solution() async {
        let day = Day16(input: Day16.input)
        #expect(day.part2() == 809376774329)
    }
}
