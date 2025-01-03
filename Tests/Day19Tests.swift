//
// Advent of Code 2020 Day 19 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
0: 4 1 5
1: 2 3 | 3 2
2: 4 4 | 5 5
3: 4 5 | 5 4
4: "a"
5: "b"

ababbb
bababa
abbbab
aaabbb
aaaabbb
"""

fileprivate let testInput2 = """
42: 9 14 | 10 1
9: 14 27 | 1 26
10: 23 14 | 28 1
1: "a"
11: 42 31
5: 1 14 | 15 1
19: 14 1 | 14 14
12: 24 14 | 19 1
16: 15 1 | 14 14
31: 14 17 | 1 13
6: 14 14 | 1 14
2: 1 24 | 14 4
0: 8 11
13: 14 3 | 1 12
15: 1 | 14
17: 14 2 | 1 7
23: 25 1 | 22 14
28: 16 1
4: 1 1
20: 14 14 | 1 15
3: 5 14 | 16 1
27: 1 6 | 14 18
14: "b"
21: 14 1 | 1 14
25: 1 1 | 1 14
22: 14 14
8: 42
26: 14 22 | 1 20
18: 15 15
7: 14 5 | 1 21
24: 14 1

abbbbbabbbaaaababbaabbbbabababbbabbbbbbabaaaa
bbabbbbaabaabba
babbbbaabbbbbabbbbbbaabaaabaaa
aaabbbbbbaaaabaababaabababbabaaabbababababaaa
bbbbbbbaaaabbbbaaabbabaaa
bbbababbbbaaaaaaaabbababaaababaabab
ababaaaaaabaaab
ababaaaaabbbaba
baabbaaaabbaaaababbaababb
abbbbabbbbaaaababbbbbbaaaababb
aaaaabbaabaaaaababaa
aaaabbaaaabbaaa
aaaabbaabbaaaaaaabbbabbbaaabbaabaaa
babaaabbbaaabaababbaabababaaab
aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba
"""

@Suite("Day 19 Tests") 
struct Day19Tests {
    @Test("Day 19 Part 1", .tags(.testInput))
    func testDay19_part1() async {
        let day = Day19(input: testInput)
        #expect(day.part1() == 2)
    }

    @Test("Day 19 Part 1 Solution")
    func testDay19_part1_solution() async {
        let day = Day19(input: Day19.input)
        #expect(day.part1() == 239)
    }

    @Test("Day 19 Part 2", .tags(.testInput))
    func testDay19_part2() async {
        let day = Day19(input: testInput2)
        #expect(day.part2() == 12)
    }

    @Test("Day 19 Part 2 Solution")
    func testDay19_part2_solution() async {
        let day = Day19(input: Day19.input)
        #expect(day.part2() == 405)
    }
}
