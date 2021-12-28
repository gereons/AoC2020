
import Foundation

struct Puzzle20 {
    struct Corner: Equatable {
        let str: String

        static func ==(_ lhs: Corner, _ rhs: Corner) -> Bool {
            return
                lhs.str == rhs.str ||
                String(lhs.str.reversed()) == rhs.str ||
                lhs.str == String(rhs.str.reversed())
        }
    }

    struct Corners {
        let top: Corner
        let left: Corner
        let bottom: Corner
        let right: Corner

        init(top: String, left: String, bottom: String, right: String) {
            self.top = Corner(str: top)
            self.left = Corner(str: left)
            self.bottom = Corner(str: bottom)
            self.right = Corner(str: right)
        }

        var all: [Corner] {
            [top, left, bottom, right]
        }
    }

    struct Tile: Equatable {
        let id: Int
        let corners: Corners

        init(_ id: Int, _ lines: [String]) {
            self.id = id
            let left = String(lines.map { $0.first! })
            let right = String(lines.map { $0.last! })
            self.corners = Corners(top: lines[0], left: left, bottom: lines.last!, right: right)
        }

        static func ==(_ lhs: Tile, _ rhs: Tile) -> Bool {
            lhs.id == rhs.id
        }
    }

    class Grid {
        private(set) var tiles = [[Int]]()
        let size: Int

        init(size: Int) {
            self.size = size
            for _ in 0..<size {
                tiles.append(Array(repeatElement(0, count: size)))
            }
        }

        subscript(_ x: Int, _ y: Int) -> Int {
            get {
                tiles[y][x]
            }
            set {
                tiles[y][x] = newValue
            }
        }
    }

    static func run() {
        // let data = Self.data
        let data = readFile(named: "puzzle20.txt")
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
                lines.append(String(line))
            }
        }
        let tile = Tile(id, lines)
        tiles[id] = tile

        part1(tiles)
    }

    static func part1(_ tiles: [Int: Tile]) {
        var matches = [Int: Int]()
        for (id1, t1) in tiles {
            for (id2, t2) in tiles {
                if id1 == id2 { continue }

                let m = matchingCorners(t1, t2)
                matches[t1.id, default: 0] += m
                matches[t2.id, default: 0] += m
            }
        }
        print(matches)

        var r = 1
        for (id, match) in matches {
            if match == 4 {
                print("corner: \(id)")
                r *= id
            }
        }
        print(r)
    }

    static func matchingCorners(_ tile1: Tile, _ tile2: Tile) -> Int {
        var cnt = 0
        for c1 in tile1.corners.all {
            for c2 in tile2.corners.all {
                if c1 == c2 {
                    cnt += 1
                }
            }
        }
        return cnt
    }
}
