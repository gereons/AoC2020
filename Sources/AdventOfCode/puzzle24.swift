import Foundation

struct Puzzle24 {
    struct Point: Hashable {
        // see https://www.redblobgames.com/grids/hexagons/
        let q, r, s: Int
    }

    enum Tile {
        case white, black

        var flipped: Tile {
            switch self {
            case .white: return .black
            case .black: return .white
            }
        }
    }

    enum Direction: CaseIterable {
        case w, nw, ne, e, se, sw

        var offset: (dq: Int, dr: Int, ds: Int) {
            switch self {
            case .w: return (-1, 0, 1)
            case .nw: return (0, -1, 1)
            case .ne: return (1, -1, 0)
            case .e: return (1, 0, -1)
            case .se: return (0, 1, -1)
            case .sw: return (-1, 1, 0)
            }
        }

        static func from(_ str: String) -> [Direction] {
            let chars = str.map { $0 }
            var i = 0
            var dirs = [Direction]()
            while i < chars.count {
                switch chars[i] {
                case "e": dirs.append(.e)
                case "w": dirs.append(.w)
                case "s":
                    switch chars[i+1] {
                    case "e": dirs.append(.se)
                    case "w": dirs.append(.sw)
                    default: fatalError()
                    }
                    i += 1
                case "n":
                    switch chars[i+1] {
                    case "e": dirs.append(.ne)
                    case "w": dirs.append(.nw)
                    default: fatalError()
                    }
                    i += 1
                default: fatalError()
                }
                i += 1
            }
            return dirs
        }
    }

    static func run() {
//        let data = [
//            "sesenwnenenewseeswwswswwnenewsewsw",
//            "neeenesenwnwwswnenewnwwsewnenwseswesw",
//            "seswneswswsenwwnwse",
//            "nwnwneseeswswnenewneswwnewseswneseene",
//            "swweswneswnenwsewnwneneseenw",
//            "eesenwseswswnenwswnwnwsewwnwsene",
//            "sewnenenenesenwsewnenwwwse",
//            "wenwwweseeeweswwwnwwe",
//            "wsweesenenewnwwnwsenewsenwwsesesenwne",
//            "neeswseenwwswnwswswnw",
//            "nenwswwsewswnenenewsenwsenwnesesenew",
//            "enewnwewneswsewnwswenweswnenwsenwsw",
//            "sweneswneswneneenwnewenewwneswswnese",
//            "swwesenesewenwneswnwwneseswwne",
//            "enesenwswwswneneswsenwnewswseenwsese",
//            "wnwnesenesenenwwnenwsewesewsesesew",
//            "nenewswnwewswnenesenwnesewesw",
//            "eneswnwswnwsenenwnwnwwseeswneewsenese",
//            "neswnwewnwnwseenwseesewsenwsweewe",
//            "wseweeenwnesenwwwswnew",
//        ]
        let data = readFile(named: "puzzle24.txt")

        part1(data)
        // part2()
    }

    static func part1(_ data: [String]) {
        var grid = [Point: Tile]()
        for line in data {
            let dirs = Direction.from(line)

            var q = 0
            var r = 0
            var s = 0
            for dir in dirs {
                let (dq, dr, ds) = dir.offset
                q += dq
                r += dr
                s += ds
            }
            let point = Point(q: q, r: r, s: s)
            let t = grid[point, default: .white]
            grid[point] = t.flipped
            // print(point, grid[point]!)
        }

        let black = grid.values.filter { $0 == .black }
        print(black.count)
        part2(grid)
    }

    static func part2(_ grid: [Point: Tile]) {
        var grid = grid
        for _ in 1...100 {
            flipNeighbors(in: &grid)
        }
        let black = grid.values.filter { $0 == .black }
        print(black.count)
    }

    private static func flipNeighbors(in grid: inout [Point: Tile]) {
        let minQ = grid.keys.map { $0.q }.min()!
        let maxQ = grid.keys.map { $0.q }.max()!
        let minR = grid.keys.map { $0.r }.min()!
        let maxR = grid.keys.map { $0.r }.max()!

        var flips = Set<Point>()
        for q in minQ-1...maxQ+1 {
            for r in minR-1...maxR+1 {
                let s = -q-r // because q+r+s==0
                let point = Point(q: q, r: r, s: s)
                let t = grid[point, default: .white]
                let bn = blackNeighbors(of: point, in: grid)
                if (t == .black && (bn == 0 || bn > 2)) || (t == .white && bn == 2) {
                    flips.insert(point)
                }
            }
        }

        var newGrid = grid
        for flip in flips {
            let t = newGrid[flip, default: .white]
            newGrid[flip] = t.flipped
        }

        grid = newGrid
    }

    private static func blackNeighbors(of point: Point, in grid: [Point: Tile]) -> Int {
        var blacks = 0
        for dir in Direction.allCases {
            let (dq, dr, ds) = dir.offset
            let p = Point(q: point.q+dq, r: point.r+dr, s: point.s+ds)
            if grid[p] == .black {
                blacks += 1
            }
        }
        return blacks
    }
}

