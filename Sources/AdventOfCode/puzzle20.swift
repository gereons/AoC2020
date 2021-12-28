
import Foundation

struct Puzzle20 {
    struct Point: Hashable, CustomStringConvertible {
        let x, y: Int

        var description: String {
            "\(x),\(y)"
        }
    }

    enum Corner: CaseIterable {
        case top, right, bottom, left

        var offset: (dx: Int, dy: Int) {
            switch self {
            case .top: return (0, -1)
            case .left: return (-1, 0)
            case .right: return (1, 0)
            case .bottom: return (0, 1)
            }
        }

        var opposite: Corner {
            switch self {
            case .top: return .bottom
            case .bottom: return .top
            case .left: return .right
            case .right: return .left
            }
        }
    }

    struct Tile: Equatable {
        let id: Int
        let pixels: [Point: Bool]
        let corners: [Corner: [Bool]]
        let minX: Int
        let maxX: Int
        let minY: Int
        let maxY: Int

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
            var pixels = [Point: Bool]()
            for y in 0..<rawPixels.count {
                for x in 0..<rawPixels[y].count {
                    let point = Point(x: x, y: y)
                    pixels[point] = rawPixels[y][x]
                }
            }
            self.minX = 0
            self.maxX = rawPixels[0].count - 1
            self.minY = 0
            self.maxY = rawPixels.count - 1
            self.pixels = pixels
        }

        init(_ id: Int, _ pixels: [Point: Bool], _ corners: [Corner: [Bool]]) {
            self.id = id
            self.pixels = pixels
            self.corners = corners

            self.minX = pixels.keys.map { $0.x }.min()!
            self.maxX = pixels.keys.map { $0.x }.max()!
            self.minY = pixels.keys.map { $0.y }.min()!
            self.maxY = pixels.keys.map { $0.y }.max()!
        }

        static func ==(_ lhs: Tile, _ rhs: Tile) -> Bool {
            lhs.id == rhs.id
        }

        func show() {
            show(corners[.top]!); print()
            for y in minY...maxY {
                let yOffset = 0 - minY
                print(corners[.left]![y+yOffset+1] ? "#" : ".", terminator: "")
                show(pixels.filter { $0.key.y == y }.sorted { $0.key.x < $1.key.x }.map { $0.value })
                // print("        ", terminator: "")
                print(corners[.right]![y+yOffset+1] ? "#" : ".")
            }
            show(corners[.bottom]!); print()
            print()
        }

        private func show(_ line: [Bool]) {
            for x in 0..<line.count {
                let ch = line[x] ? "#" : "."
                print(ch, terminator: "")
            }
        }

        func permutations() -> [Tile] {
            let r90 = self.rotated(by: 90)
            let r180 = r90.rotated(by: 90)
            let r270 = r180.rotated(by: 90)
            return [
                self, self.flipped(),
                r90,  r90.flipped(),
                r180, r180.flipped(),
                r270, r270.flipped()
            ]
        }

        private func flipped() -> Tile {
            var newPixels = [Point: Bool]()
            for (point, px) in self.pixels {
                let pt = Point(x: -point.x, y: point.y)
                newPixels[pt] = px
            }
            var newCorners = [Corner: [Bool]]()
            newCorners[.top] = corners[.top]!.reversed()
            newCorners[.left] = corners[.right]!
            newCorners[.right] = corners[.left]!
            newCorners[.bottom] = corners[.bottom]!.reversed()
            return Tile(id, newPixels, newCorners)
        }

        private func rotated(by degrees: Int) -> Tile {
            switch degrees {
            case 0: return self
            case 90:
                var newPixels = [Point: Bool]()
                for (point, px) in self.pixels {
                    let pt = Point(x: -point.y, y: point.x)
                    newPixels[pt] = px
                }
                var newCorners = [Corner: [Bool]]()
                newCorners[.top] = corners[.left]!.reversed()
                newCorners[.left] = corners[.bottom]!
                newCorners[.bottom] = corners[.right]!.reversed()
                newCorners[.right] = corners[.top]!
                return Tile(self.id, newPixels, newCorners)
            default: fatalError()
            }
        }
    }

    class Grid {
        private(set) var tiles = [Point: Tile]()
        private(set) var availableTiles: [Int: Tile]

        init(tiles: [Int: Tile]) {
            self.availableTiles = tiles
        }

        func start(_ tile: Tile) {
            let point = Point(x: 0, y: 0)
            addToGrid(at: point, tile: tile)

            findNeighbor(at: point)
        }

        func findNeighbor(at point: Point) {
            print(#function, point)
            let tile = tiles[point]!

            var newPoints = [Point]()
            for corner in Corner.allCases {
                if let tile = findMatch(tile, corner) {
                    print("\(tile.id) matches at \(corner)")
                    let (dx, dy) = corner.offset
                    let pt = Point(x: point.x+dx, y: point.y+dy)
                    addToGrid(at: pt, tile: tile)
                    newPoints.append(pt)
                }
            }

            for np in newPoints {
                findNeighbor(at: np)
            }
        }

        func findMatch(_ tile: Tile, _ corner: Corner) -> Tile? {
            for t in availableTiles.values {
                for p in t.permutations() {
                    if p.corners[corner.opposite] == tile.corners[corner] {
                        return p
                    }
                }
            }
            return nil
        }

        func addToGrid(at point: Point, tile: Tile) {
            print("add \(tile.id) at \(point)")
            assert(tiles[point] == nil)
            tiles[point] = tile
            availableTiles[tile.id] = nil
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

//        part1(tiles)
        part2(tiles)
    }

    static func part1(_ tiles: [Int: Tile]) {
        var matches = [Int: Int]()

        let ids = Array(tiles.keys.sorted())
        for i in 0..<ids.count - 1 {
            for j in i+1 ..< ids.count {
                let t1 = tiles[ids[i]]!
                let t2 = tiles[ids[j]]!

                let m = matchingCorners(t1, t2)
                matches[t1.id, default: 0] += m
                matches[t2.id, default: 0] += m
            }
        }
        // print(matches)

        var corners = [Int]()
        for (id, match) in matches {
            assert([8,12,16].contains(match))
            if match == 8 {
                corners.append(id)
            }
        }
        print("corners:", corners)
        print(corners.reduce(1, *))
    }

    static func part2(_ tiles: [Int: Tile]) {
        var matches = [Int: Int]()

        let ids = Array(tiles.keys.sorted())
        for i in 0..<ids.count - 1 {
            for j in i+1 ..< ids.count {
                let t1 = tiles[ids[i]]!
                let t2 = tiles[ids[j]]!

                let m = matchingCorners(t1, t2)
                matches[t1.id, default: 0] += m
                matches[t2.id, default: 0] += m
            }
        }
        // print(matches)

        var corners = [Int]()
        for (id, match) in matches {
            if match == 8 {
                corners.append(id)
            }
        }
        print("corners:", corners)

        let grid = Grid(tiles: tiles)
        grid.start(tiles[corners[0]]!)
        print("done!")
    }

    static func matchingCorners(_ tile1: Tile, _ tile2: Tile) -> Int {
        var cnt = 0
        for c1 in tile1.corners.values {
            for t2 in tile2.permutations() {
                for c2 in t2.corners.values {
                    if c1 == c2 {
                        cnt += 1
                    }
                }
            }
        }
        return cnt
    }
}
