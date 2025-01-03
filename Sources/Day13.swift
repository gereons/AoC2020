//
// Advent of Code 2020 Day 13
//

import AoCTools

final class Day13: AdventOfCodeDay {
    let title = "Shuttle Search"

    let timestamp: Int
    let ids: [Int]

    init(input: String) {
        let lines = input.lines

        timestamp = Int(lines[0])!
        ids = lines[1].components(separatedBy: ",").compactMap { Int($0) ?? 1 }
    }

    func part1() -> Int {
        // part1
        nextDeparture(timestamp, ids)
    }

    func part2() -> Int {
        // part2

        var inc = ids.first!
        var index = 1
        var t = inc
        while index < ids.count {
            if (t + index) % ids[index]  == 0 {
                inc *= ids[index]
                index += 1
            } else {
                t += inc
            }
        }
        // print("p13b: convergence at \(t)")
        return t
    }

    private func nextDeparture(_ timestamp: Int, _ ids: [Int]) -> Int {
        var results = [Int: Int]()

        for id in ids {
            if id == 1 { continue }
            // print(timestamp % id)
            let nextDeparture = ((timestamp / id) + 1) * id
            results[nextDeparture] = id
        }

        let next = results.keys.min(by: <)!
        let nextId = results[next]!
        // print("p13a: next departure at \(next) \(nextId) -> \((next - timestamp) * nextId)")
        return (next - timestamp) * nextId
    }
}
