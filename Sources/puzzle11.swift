import Foundation

struct Puzzle11 {
    static let data = """
    L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL
    """

    enum Seat {
        case empty, occupied, floor
    }

    static func run() {
        // let lines = Self.data.components(separatedBy: "\n")
        let lines = Self.rawInput.components(separatedBy: "\n")

        var grid = generateGrid(from: lines)
        // showGrid(grid)

        var rounds = 0
        while populateGrid_2(&grid) != 0 {
            rounds += 1
            // print("round \(rounds)")
            // showGrid(grid)
        }
        // let occupied = countOccupied(grid)
        // print("rounds taken: \(rounds), \(occupied) seats")
    }

    static func countOccupied(_ grid: [[Seat]]) -> Int {
        grid.reduce(0) {
            $0 + $1.filter({ $0 == .occupied }).count
        }
    }

    static func populateGrid(_ grid: inout [[Seat]]) -> Int {
        var newGrid = grid

        var changes = 0
        for y in 0 ..< grid.count {
            for x in 0 ..< grid[0].count {
                let neighbours = numberOfDirectNeighbours(grid, x, y)
                let seat = grid[y][x]
                if seat == .empty && neighbours == 0 {
                    newGrid[y][x] = .occupied
                    changes += 1
                }
                if seat == .occupied && neighbours >= 4 {
                    newGrid[y][x] = .empty
                    changes += 1
                }
            }
        }

        grid = newGrid
        return changes
    }

    static func populateGrid_2(_ grid: inout [[Seat]]) -> Int {
        var newGrid = grid

        var changes = 0
        for y in 0 ..< grid.count {
            for x in 0 ..< grid[0].count {
                let neighbours = numberOfVisibleNeighbours(grid, x, y)
                let seat = grid[y][x]
                if seat == .empty && neighbours == 0 {
                    newGrid[y][x] = .occupied
                    changes += 1
                }
                if seat == .occupied && neighbours >= 5 {
                    newGrid[y][x] = .empty
                    changes += 1
                }
            }
        }

        grid = newGrid
        return changes
    }

    static func numberOfVisibleNeighbours(_ grid: [[Seat]], _ x: Int, _ y: Int) -> Int {
        var neigbours = 0

        let testDirections = [
            (-1, -1), (0, -1), (+1, -1),
            (-1, 0),           (+1, 0),
            (-1, +1), (0, +1), (+1, +1)
        ]

        for (dX, dY) in testDirections {
            let seat = firstSeatInDirection(grid, x, y, dX, dY)
            if seat == .occupied {
                neigbours += 1
            }
        }

        return neigbours
    }

    static func firstSeatInDirection(_ grid: [[Seat]], _ x: Int, _ y: Int, _ dX: Int, _ dY: Int) -> Seat {
        var x = x
        var y = y
        repeat {
            x += dX
            y += dY
            let outOfBounds = x < 0 || x >= grid[0].count || y < 0 || y >= grid.count
            if outOfBounds {
                return .floor
            }
            if grid[y][x] != .floor {
                return grid[y][x]
            }
        } while true
    }

    static func numberOfDirectNeighbours(_ grid: [[Seat]], _ x: Int, _ y: Int) -> Int {
        var neigbours = 0

        let testCoordinates = [
            (x-1, y-1), (x, y-1), (x+1, y-1),
            (x-1, y),             (x+1, y),
            (x-1, y+1), (x, y+1), (x+1, y+1)
        ]

        for (testX, testY) in testCoordinates {
            if testX < 0 || testX >= grid[0].count || testY < 0 || testY >= grid.count {
                continue
            }
            if grid[testY][testX] == .occupied {
                neigbours += 1
            }
        }

        return neigbours
    }

    static func showGrid(_ grid: [[Seat]]) {
        for row in grid {
            for seat in row {
                switch seat {
                case .empty: print("L", terminator: "")
                case .occupied: print("#", terminator: "")
                case .floor: print(".", terminator: "")
                }
            }
            print()
        }
    }

    static func generateGrid(from lines: [String]) -> [[Seat]] {
        var result = [[Seat]]()

        for line in lines {
            var seats = [Seat]()
            for ch in line {
                switch ch {
                case ".": seats.append(.floor)
                case "L": seats.append(.empty)
                case "#": seats.append(.occupied)
                default: ()
                }
            }
            result.append(seats)
        }
        return result
    }
}
