//
// Advent of Code 2020 Day 11
//

import AoCTools

final class Day11: AdventOfCodeDay {
    let title = "Seating System"

    enum Seat {
        case empty, occupied, floor
    }

    let grid: [[Seat]]

    init(input: String) {
        grid = Self.generateGrid(from: input.lines)
        // showGrid(grid)
    }

    func part1() -> Int {
        var rounds = 0
        var grid = grid
        while populateGrid(&grid) != 0 {
            rounds += 1
            // print("round \(rounds)")
            // showGrid(grid)
        }
        let occupied = countOccupied(grid)
        // print("rounds taken: \(rounds), \(occupied) seats")
        return occupied
    }

    func part2() -> Int {
        var rounds = 0
        var grid = grid
        while populateGrid_2(&grid) != 0 {
            rounds += 1
            // print("round \(rounds)")
            // showGrid(grid)
        }
        let occupied = countOccupied(grid)
        // print("rounds taken: \(rounds), \(occupied) seats")
        return occupied
    }

    private func countOccupied(_ grid: [[Seat]]) -> Int {
        grid.reduce(0) {
            $0 + $1.filter({ $0 == .occupied }).count
        }
    }

    private func populateGrid(_ grid: inout [[Seat]]) -> Int {
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

    private func populateGrid_2(_ grid: inout [[Seat]]) -> Int {
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

    private func numberOfVisibleNeighbours(_ grid: [[Seat]], _ x: Int, _ y: Int) -> Int {
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

    private func firstSeatInDirection(_ grid: [[Seat]], _ x: Int, _ y: Int, _ dX: Int, _ dY: Int) -> Seat {
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

    private func numberOfDirectNeighbours(_ grid: [[Seat]], _ x: Int, _ y: Int) -> Int {
        let testCoordinates = [
            (x-1, y-1), (x, y-1), (x+1, y-1),
            (x-1, y),             (x+1, y),
            (x-1, y+1), (x, y+1), (x+1, y+1)
        ]

        var neigbours = 0
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

    private func showGrid(_ grid: [[Seat]]) {
        for row in grid {
            for seat in row {
                switch seat {
                case .empty: print("L", terminator: "")
                case .occupied: print("#", terminator: "")
                case .floor: print(".", terminator: "")
                }
            }
            // print()
        }
    }

    private static func generateGrid(from lines: [String]) -> [[Seat]] {
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
