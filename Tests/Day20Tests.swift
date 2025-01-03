//
// Advent of Code 2020 Day 20 Tests
//

import Testing
@testable import AdventOfCode

fileprivate let testInput = """
Tile 2311:
..##.#..#.
##..#.....
#...##..#.
####.#...#
##.##.###.
##...#.###
.#.#.#..##
..#....#..
###...#.#.
..###..###

Tile 1951:
#.##...##.
#.####...#
.....#..##
#...######
.##.#....#
.###.#####
###.##.##.
.###....#.
..#.#..#.#
#...##.#..

Tile 1171:
####...##.
#..##.#..#
##.#..#.#.
.###.####.
..###.####
.##....##.
.#...####.
#.##.####.
####..#...
.....##...

Tile 1427:
###.##.#..
.#..#.##..
.#.##.#..#
#.#.#.##.#
....#...##
...##..##.
...#.#####
.#.####.#.
..#..###.#
..##.#..#.

Tile 1489:
##.#.#....
..##...#..
.##..##...
..#...#...
#####...#.
#..#.#.#.#
...#.#.#..
##.#...##.
..##.##.##
###.##.#..

Tile 2473:
#....####.
#..#.##...
#.##..#...
######.#.#
.#...#.#.#
.#########
.###.#..#.
########.#
##...##.#.
..###.#.#.

Tile 2971:
..#.#....#
#...###...
#.#.###...
##.##..#..
.#####..##
.#..####.#
#..#.#..#.
..####.###
..#.#.###.
...#.#.#.#

Tile 2729:
...#.#.#.#
####.#....
..#.#.....
....#..#.#
.##..##.#.
.#.####...
####.#.#..
##.####...
##..#.##..
#.##...##.

Tile 3079:
#.#.#####.
.#..######
..#.......
######....
####.#..#.
.#...#.##.
#.#####.##
..#.###...
..#.......
..#.###...
"""

@Suite("Day 20 Tests") 
struct Day20Tests {
    @Test("Day 20 Part 1", .tags(.testInput))
    func testDay20_part1() async {
        let day = Day20(input: testInput)
        #expect(day.part1() == 20899048083289)
    }

    @Test("Day 20 Part 1 Solution")
    func testDay20_part1_solution() async {
        let day = Day20(input: Day20.input)
        #expect(day.part1() == 68781323018729)
    }

    @Test("Day 20 Part 2", .tags(.testInput))
    func testDay20_part2() async {
        let day = Day20(input: testInput)
        #expect(day.part2() == 273)
    }

    @Test("Day 20 Part 2 Solution")
    func testDay20_part2_solution() async {
        let day = Day20(input: Day20.input)
        #expect(day.part2() == 1629)
    }
}