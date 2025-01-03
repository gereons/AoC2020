//
// Advent of Code 2020 Day 10 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput1 = """
16
10
15
5
1
11
7
19
6
12
4
"""

fileprivate let testInput2 = """
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
"""

@Suite("Day 10 Tests") 
struct Day10Tests {
    @Test("Day 10 Part 1", .tags(.testInput))
    func testDay10_part1() async {
        let day = Day10(input: testInput1)
        #expect(day.part1() == 35)
    }

    @Test("Day 10 Part 1 Solution")
    func testDay10_part1_solution() async {
        let day = Day10(input: Day10.input)
        #expect(day.part1() == 1885)
    }

    @Test("Day 10 Part 2", .tags(.testInput))
    func testDay10_part2() async {
        let day = Day10(input: testInput2)
        #expect(day.part2() == 19208)
    }

    @Test("Day 10 Part 2 Solution")
    func testDay10_part2_solution() async {
        let day = Day10(input: Day10.input)
        #expect(day.part2() == 2024782584832)
    }
}
