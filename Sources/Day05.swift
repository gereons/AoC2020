//
// Advent of Code 2020 Day 5
//

import AoCTools

private struct Seat {
    let row: Int
    let column: Int

    var id: Int { row * 8 + column }

    init(_ str: String) {
        var start = 0
        var range = 128

        for ch in str.prefix(7) {
            if ch == "F" { // keep front half
                range /= 2
            } else if ch == "B" { // keep back half
                start += range / 2
                range /= 2
            }
        }
        self.row = start

        start = 0
        range = 8
        for ch in str.suffix(3) {
            if ch == "L" { // keep left half
                range /= 2
            } else if ch == "R" { // keep right half
                start += range / 2
                range /= 2
            }
        }
        let column = start

        self.column = column
    }
}

final class Day05: AdventOfCodeDay {
    let title = "Binary Boarding"

    private let seats: [Seat]

    init(input: String) {
        seats = input.lines.map { Seat($0) }
    }

    func part1() -> Int {
        let maxId = seats.map { $0.id }.max(by: <)!
        // print("p5a: max id \(maxId)")
        return maxId
    }

    func part2() -> Int {
        let sortedSeats = seats.sorted { $0.id < $1.id }

        for (index, seat) in sortedSeats.dropLast().enumerated() {
            let nextId = sortedSeats[index + 1].id
            if seat.id + 1 != nextId {
                // print("p5b: my seat: \(seat.id + 1)")
                return seat.id + 1
            }
        }
        fatalError()
    }
}
