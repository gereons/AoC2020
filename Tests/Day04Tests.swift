//
// Advent of Code 2020 Day 4 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in
"""

@Suite("Day 4 Tests") 
struct Day04Tests {
    @Test("Day 4 Part 1", .tags(.testInput))
    func testDay04_part1() async {
        let day = Day04(input: testInput)
        #expect(day.part1() == 2)
    }

    @Test("Day 4 Part 1 Solution")
    func testDay04_part1_solution() async {
        let day = Day04(input: Day04.input)
        #expect(day.part1() == 242)
    }

    @Test("Day 4 Part 2", .tags(.testInput))
    func testDay04_part2() async {
        let day = Day04(input: testInput)
        #expect(day.part2() == 2)
    }

    @Test("Day 4 Part 2 Solution")
    func testDay04_part2_solution() async {
        let day = Day04(input: Day04.input)
        #expect(day.part2() == 186)
    }
}
