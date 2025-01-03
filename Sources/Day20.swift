//
// Advent of Code 2020 Day 20
//

import AoCTools

final class Day20: AdventOfCodeDay {
    let title: String = "Jurassic Jigsaw"

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
                    let point = Point(x, y)
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
            if let top = corners[.top] {
                show(top); print()
            }
            for y in minY...maxY {
                let yOffset = 0 - minY
                if let left = corners[.left] {
                    print(left[y+yOffset+1] ? "#" : ".", terminator: "")
                }
                show(pixels.filter { $0.key.y == y }.sorted { $0.key.x < $1.key.x }.map { $0.value })
                // print("        ", terminator: "")
                if let right = corners[.right] {
                    print(right[y+yOffset+1] ? "#" : ".", terminator: "")
                }
                print()
            }
            if let bottom = corners[.bottom] {
                show(bottom); print()
            }
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
                let pt = Point(-point.x, point.y)
                newPixels[pt] = px
            }
            var newCorners = [Corner: [Bool]]()
            newCorners[.top] = corners[.top]?.reversed()
            newCorners[.left] = corners[.right]
            newCorners[.right] = corners[.left]
            newCorners[.bottom] = corners[.bottom]?.reversed()
            return Tile(id, newPixels, newCorners)
        }

        private func rotated(by degrees: Int) -> Tile {
            switch degrees {
            case 0: return self
            case 90:
                var newPixels = [Point: Bool]()
                for (point, px) in self.pixels {
                    let pt = Point(-point.y, point.x)
                    newPixels[pt] = px
                }
                var newCorners = [Corner: [Bool]]()
                newCorners[.top] = corners[.left]?.reversed()
                newCorners[.left] = corners[.bottom]
                newCorners[.bottom] = corners[.right]?.reversed()
                newCorners[.right] = corners[.top]
                return Tile(self.id, newPixels, newCorners)
            default: fatalError()
            }
        }
    }

    final class Grid {
        private(set) var tiles = [Point: Tile]()
        private(set) var availableTiles: [Int: Tile]

        init(tiles: [Int: Tile]) {
            self.availableTiles = tiles
        }

        func start(_ tile: Tile) {
            addToGrid(at: .zero, tile: tile)

            findNeighbor(at: .zero)
        }

        func findNeighbor(at point: Point) {
            let tile = tiles[point]!

            var newPoints = [Point]()
            for corner in Corner.allCases {
                if let tile = findMatch(tile, corner) {
                    // print("\(tile.id) matches at \(corner)")
                    let (dx, dy) = corner.offset
                    let pt = Point(point.x+dx, point.y+dy)
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
            // print("add \(tile.id) at \(point)")
            assert(tiles[point] == nil)
            tiles[point] = tile
            availableTiles[tile.id] = nil
        }

        func combine() -> Tile {
            let minX = tiles.keys.map { $0.x }.min()!
            let maxX = tiles.keys.map { $0.x }.max()!
            let minY = tiles.keys.map { $0.y }.min()!
            let maxY = tiles.keys.map { $0.y }.max()!

            var pixels = [Point: Bool]()

            for (oy, y) in (minY...maxY).enumerated() {
                for (ox, x) in (minX...maxX).enumerated() {
                    let pt = Point(x, y)
                    let tile = tiles[pt]!
                    var sy = oy * 8
                    for ty in tile.minY...tile.maxY {
                        var sx = ox * 8
                        for tx in tile.minX...tile.maxX {
                            pixels[Point(sx, sy)] = tile.pixels[Point(tx, ty)]!
                            sx += 1
                        }
                        sy += 1
                    }
                }
            }

            return Tile(0, pixels, [:])
        }
    }

    let tiles: [Int: Tile]

    init(input: String) {
        var tiles = [Int: Tile]()

        var id = -1
        var lines = [String]()
        for line in input.lines {
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
        if !lines.isEmpty {
            let tile = Tile(id, lines)
            tiles[id] = tile
        }

        self.tiles = tiles
    }

    func part1() -> Int {
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
        // print("corners:", corners)
        return corners.reduce(1, *)
    }

    func part2() -> Int {
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
        // print("corners:", corners)

        let grid = Grid(tiles: tiles)
        grid.start(tiles[corners[0]]!)

        let tile = grid.combine()
        // tile.show()

        for t in tile.permutations() {
            let monsters = findMonsters(in: t)
            if monsters > 0 {
                let roughness = t.pixels.values.filter { $0 }.count
                return roughness - monsters * 15
            }
        }

        return 0
    }

    private func findMonsters(in tile: Tile) -> Int {
        //             1
        //   01234567890123456789
        // -+--------------------
        // 0|                  #
        // 1|#    ##    ##    ###
        // 2| #  #  #  #  #  #
        let monster = [
            Point(0, 1),
            Point(1, 2),
            Point(4, 2),
            Point(5, 1),
            Point(6, 1),
            Point(7, 2),
            Point(10, 2),
            Point(11, 1),
            Point(12, 1),
            Point(13, 2),
            Point(16, 2),
            Point(17, 1),
            Point(18, 0),
            Point(18, 1),
            Point(19, 1),
        ]

        var found = 0
        for y in tile.minY...tile.maxY-2 {
            for x in tile.minX...tile.maxX-19 {
                if detect(monster, at: Point(x, y), in: tile) {
                    // print("found at \(x),\(y)!")
                    found += 1
                }
            }
        }
        return found
    }

    private func detect(_ monster: [Point], at point: Point, in tile: Tile) -> Bool {
        for mp in monster {
            let p = Point(point.x+mp.x, point.y+mp.y)
            if tile.pixels[p] == false {
                return false
            }
        }
        return true
    }

    private func matchingCorners(_ tile1: Tile, _ tile2: Tile) -> Int {
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
