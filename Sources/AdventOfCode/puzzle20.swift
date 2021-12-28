
import Foundation

struct Puzzle20 {
    enum Corner {
        case top, right, bottom, left
    }

    struct Tile: Equatable {
        let id: Int
        let pixels: [[Bool]]
        let corners: [Corner: [Bool]]

        init(_ id: Int, _ lines: [String]) {
            self.id = id

            var rawPixels = lines.map { line in
                line.map { ch in ch == "#" }
            }

            var corners = [Corner: [Bool]]()
            corners[.top] = rawPixels[0]
            corners[.bottom] = rawPixels.last!

            var left = [Bool]()
            var right = [Bool]()
            for i in 0..<rawPixels.count {
                left.append(rawPixels[i][0])
                right.append(rawPixels[i].last!)
                rawPixels[i].remove(at: 0)
                rawPixels[i].remove(at: rawPixels[i].count - 1)
            }
            corners[.left] = left
            corners[.right] = right

            rawPixels.remove(at: 0)
            rawPixels.remove(at: rawPixels.count - 1)

            self.corners = corners
            self.pixels = rawPixels
        }

        static func ==(_ lhs: Tile, _ rhs: Tile) -> Bool {
            lhs.id == rhs.id
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
        // print(matches)

        var corners = [Int]()
        for (id, match) in matches {
            if match == 4 {
                corners.append(id)
            }
        }
        print("corners:", corners)
        print(corners.reduce(1, *))
    }

    static func matchingCorners(_ tile1: Tile, _ tile2: Tile) -> Int {
        var cnt = 0
        for (_, px1) in tile1.corners {
            for (_, px2) in tile2.corners {
                if matchCorner(px1, px2) {
                    cnt += 1
                }
            }
        }
        return cnt
    }

    static private func matchCorner(_ px1: [Bool], _ px2: [Bool]) -> Bool {
        return px1 == px2 || px1.reversed() == px2
    }
}
