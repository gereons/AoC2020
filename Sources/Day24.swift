//
// Advent of Code 2020 Day 24
//

import AoCTools

fileprivate typealias Point = Hex.Point
fileprivate typealias Direction = Hex.PointyDirection

final class Day24: AdventOfCodeDay {
    let title: String = "Lobby Layout"

    enum Tile {
        case white, black

        var flipped: Tile {
            switch self {
            case .white: return .black
            case .black: return .white
            }
        }
    }

    let data: [String]
    init(input: String) {
        data = input.lines
    }

    func part1() -> Int {
        let grid = makeGrid()
        let black = grid.values.filter { $0 == .black }
        return black.count
    }

    func part2() -> Int {
        var grid = makeGrid()
        for _ in 1...100 {
            flipNeighbors(in: &grid)
        }
        let black = grid.values.filter { $0 == .black }
        return black.count
    }

    private func makeGrid() -> [Point: Tile] {
        var grid = [Point: Tile]()
        for line in data {
            let dirs = Direction.from(line)

            var point = Point.zero
            for dir in dirs {
                point = point + dir.offset
            }
            let t = grid[point, default: .white]
            grid[point] = t.flipped
            // print(point, grid[point]!)
        }
        return grid
    }

    private func flipNeighbors(in grid: inout [Point: Tile]) {
        let minQ = grid.keys.map { $0.q }.min()!
        let maxQ = grid.keys.map { $0.q }.max()!
        let minR = grid.keys.map { $0.r }.min()!
        let maxR = grid.keys.map { $0.r }.max()!

        var flips = Set<Point>()
        for q in minQ-1...maxQ+1 {
            for r in minR-1...maxR+1 {
                let s = -q-r // because q+r+s==0
                let point = Point(q, r, s)
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

    private func blackNeighbors(of point: Point, in grid: [Point: Tile]) -> Int {
        var blacks = 0
        for dir in Direction.allCases {
            if grid[point + dir.offset] == .black {
                blacks += 1
            }
        }
        return blacks
    }
}

extension Direction {
    fileprivate static func from(_ str: String) -> [Direction] {
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
