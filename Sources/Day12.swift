//
// Advent of Code 2020 Day 12
//

import AoCTools
import Foundation

final class Day12: AdventOfCodeDay {
    let title = "Rain Risk"

    struct Point {
        var north: Int
        var east: Int

        mutating func move(direction: Character, speed: Int) {
            switch direction {
            case "N":
                self.north += speed
            case "S":
                self.north -= speed
            case "E":
                self.east += speed
            case "W":
                self.east -= speed
            default:
                ()
            }
        }

        mutating func rotate(degrees: Int) {
            let radians = Double(degrees) * .pi / 180

            let s = sin(radians)
            let c = cos(radians)
            let x = Double(east)
            let y = Double(north)
            let east = x * c - y * s
            let north = x * s + y * c
            self.east = Int(east.rounded())
            self.north = Int(north.rounded())
        }
    }

    struct Ship {
        var position: Point
        var direction: Character

        init(north: Int, east: Int, direction: Character) {
            self.position = Point(north: north, east: east)
            self.direction = direction
        }

        mutating func move(direction: Character, speed: Int) {
            switch direction {
            case "N", "S", "E", "W":
                position.move(direction: direction, speed: speed)
            case "F":
                self.move(direction: self.direction, speed: speed)
            case "R":
                let steps = speed / 90
                self.direction = turn(self.direction, steps)
            case "L":
                let steps = speed / 90
                self.direction = turn(self.direction, -steps)
            default: ()
            }
        }

        func turn(_ start: Character, _ steps: Int) -> Character {
            let sequence = steps > 0 ? "NESWNESW" : "WSENWSEN"

            let index = sequence.firstIndex(of: self.direction)!
            let newIndex = sequence.index(index, offsetBy: abs(steps))
            return sequence[newIndex]
        }


        var manhattan: Int {
            abs(position.north) + abs(position.east)
        }
    }

    let data: [String]

    init(input: String) {
        data = input.lines
    }

    func part1() -> Int {
        // part 1
        var ship = Ship(north: 0, east: 0, direction: "E")

        for line in data {
            let char = line[line.startIndex]
            let value = Int(line.dropFirst())!

            ship.move(direction: char, speed: value)
        }

        // print("p12a: ship is at \(ship.position), distance=\(ship.manhattan)")
        return ship.manhattan
    }

    func part2() -> Int {
        // part 2
        var ship = Ship(north: 0, east: 0, direction: "E")
        var waypoint = Point(north: 1, east: 10)

        for line in data {
            let char = line[line.startIndex]
            let value = Int(line.dropFirst())!

            switch char {
            case "N", "S", "E", "W":
                waypoint.move(direction: char, speed: value)
            case "F":
                ship.position.north += waypoint.north * value
                ship.position.east += waypoint.east * value
            case "R":
                waypoint.rotate(degrees: -value)
            case "L":
                waypoint.rotate(degrees: value)
            default:
                ()
            }

        }
        // print("p12b: ship is at \(ship.position), distance=\(ship.manhattan)")
        return ship.manhattan
    }
}
