
import Foundation

struct Puzzle20 {
    struct Corner: Equatable {
        let str: String

        static func ==(_ lhs: Corner, _ rhs: Corner) -> Bool {
            return lhs.str == rhs.str ||
                String(lhs.str.reversed()) == rhs.str ||
                lhs.str == String(rhs.str.reversed())
        }
    }

    struct Corners {
        init(top: String, left: String, bottom: String, right: String) {
            self.top = Corner(str: top)
            self.left = Corner(str: left)
            self.bottom = Corner(str: bottom)
            self.right = Corner(str: right)
        }

        let top: Corner
        let left: Corner
        let bottom: Corner
        let right: Corner

        var all: [Corner] {
            [top, left, bottom, right]
        }

//        func rotate(_ r: Int) -> Corners {
//
//        }
    }

    struct Tile {
        let id: Int
        let corners: Corners

        init(_ id: Int, _ lines: [String]) {
            self.id = id
            let left = String(lines.map { $0.first! })
            let bottom = String(lines.map { $0.last! })
            self.corners = Corners(top: lines[0], left: left, bottom: bottom, right: lines.last!)
        }
    }

    struct Grid {
        var tiles = [[Int]]()
        let size: Int
        let offset: Int

        init(size: Int) {
            self.size = size
            self.offset = size / 2
            for _ in 0..<size {
                tiles.append(Array(repeatElement(0, count: size)))
            }
        }

        subscript(_ x: Int, _ y: Int) -> Int {
            get {
                tiles[y+offset][x+offset]
            }
            set {
                tiles[y+offset][x+offset] = newValue
            }
        }
    }

    static func run() {
        let data = Self.data
        // let data = readFile(named: "puzzle20.txt")
        var tiles = [Int: Tile]()

        var id = -1
        var lines = [String]()
        for line in data {
            if line.hasPrefix("Tile ") {
                id = Int(String(line.dropFirst(5).dropLast()))!
            } else if line.isEmpty {
                let tile = Tile(id, lines)
                tiles[id] = tile
                lines = []
            } else {
                lines.append(line)
            }
        }

        var grid = Grid(size: 10)
        grid[0,0] = tiles.first!.key
        fillGrid(&grid, tiles)
    }

    static func fillGrid(_ grid: inout Grid, _ tiles: [Int: Tile]) {
        for x in 0 ..< grid.size {
            for y in 0 ..< grid.size {
                let id = grid[x,y]
                if id == 0 {
                    continue
                }
                placeNeighbour(atX: x, y: y, id: id)
            }
        }
    }

    static func placeNeighbour(atX x: Int, y: Int, id: Int) {
//        let offsets = [
//                      (0, -1),
//            (-1, 0),           (+1, 0),
//                      (0, +1),
//        ]

    }

    static let data = """
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

    """.components(separatedBy: "\n")
}
