//
// Advent of Code 2020 Day 21 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
trh fvjkl sbzzf mxmxvkd (contains dairy)
sqjhc fvjkl (contains soy)
sqjhc mxmxvkd sbzzf (contains fish)
"""

@Suite("Day 21 Tests") 
struct Day21Tests {
    @Test("Day 21 Part 1", .tags(.testInput))
    func testDay21_part1() async {
        let day = Day21(input: testInput)
        #expect(day.part1() == 5)
    }

    @Test("Day 21 Part 1 Solution")
    func testDay21_part1_solution() async {
        let day = Day21(input: Day21.input)
        #expect(day.part1() == 1882)
    }

    @Test("Day 21 Part 2", .tags(.testInput))
    func testDay21_part2() async {
        let day = Day21(input: testInput)
        #expect(day.part2() == "mxmxvkd,sqjhc,fvjkl")
    }

    @Test("Day 21 Part 2 Solution")
    func testDay21_part2_solution() async {
        let day = Day21(input: Day21.input)
        #expect(day.part2() == "xgtj,ztdctgq,bdnrnx,cdvjp,jdggtft,mdbq,rmd,lgllb")
    }
}
