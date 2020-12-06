import Foundation

struct Seat {
    let row, column: Int
    var id: Int { row * 8 + column }
}

struct Puzzle5 {
    static func run() {
        let data = readFile(named: "puzzle5.txt")

        let seats = getSeats(data.dropLast())

        let maxId = seats.map { $0.id }.max(by: <)!
        print("p5a: max id \(maxId)")

        let sortedSeats = seats.sorted { $0.id < $1.id }

        for (index, seat) in sortedSeats.dropLast().enumerated() {
            let nextId = sortedSeats[index + 1].id
            if seat.id + 1 != nextId {
                print("p5b: my seat: \(seat.id + 1)")
            }
        }
    }


    static func getSeats(_ data: [String]) -> [Seat] {
        return data.map { getSeat($0) }
    }

    static func getSeat(_ str: String) -> Seat {
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
        let row = start

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

        return Seat(row: row, column: column)
    }
}
