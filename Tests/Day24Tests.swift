//
// Advent of Code 2020 Day 24 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
sesenwnenenewseeswwswswwnenewsewsw
neeenesenwnwwswnenewnwwsewnenwseswesw
seswneswswsenwwnwse
nwnwneseeswswnenewneswwnewseswneseene
swweswneswnenwsewnwneneseenw
eesenwseswswnenwswnwnwsewwnwsene
sewnenenenesenwsewnenwwwse
wenwwweseeeweswwwnwwe
wsweesenenewnwwnwsenewsenwwsesesenwne
neeswseenwwswnwswswnw
nenwswwsewswnenenewsenwsenwnesesenew
enewnwewneswsewnwswenweswnenwsenwsw
sweneswneswneneenwnewenewwneswswnese
swwesenesewenwneswnwwneseswwne
enesenwswwswneneswsenwnewswseenwsese
wnwnesenesenenwwnenwsewesewsesesew
nenewswnwewswnenesenwnesewesw
eneswnwswnwsenenwnwnwwseeswneewsenese
neswnwewnwnwseenwseesewsenwsweewe
wseweeenwnesenwwwswnew
"""

@Suite("Day 24 Tests") 
struct Day24Tests {
    @Test("Day 24 Part 1", .tags(.testInput))
    func testDay24_part1() async {
        let day = Day24(input: testInput)
        #expect(day.part1() == 10)
    }

    @Test("Day 24 Part 1 Solution")
    func testDay24_part1_solution() async {
        let day = Day24(input: Day24.input)
        #expect(day.part1() == 277)
    }

    @Test("Day 24 Part 2", .tags(.testInput))
    func testDay24_part2() async {
        let day = Day24(input: testInput)
        #expect(day.part2() == 2208)
    }

    @Test("Day 24 Part 2 Solution")
    func testDay24_part2_solution() async {
        let day = Day24(input: Day24.input)
        #expect(day.part2() == 3531)
    }
}
