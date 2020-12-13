import Foundation

struct Puzzle13 {
    static let data1 = """
    939
    7,13,x,x,59,x,31,19
    """

    static let data2 = """
    1000303
    41,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,541,x,x,x,x,x,x,x,23,x,x,x,x,13,x,x,x,17,x,x,x,x,x,x,x,x,x,x,x,29,x,983,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19
    """

    static func run() {
        let lines = data2.components(separatedBy: "\n")

        let timestamp = Int(lines[0])!
        let ids = lines[1].components(separatedBy: ",").compactMap { Int($0) ?? 1 }

        // part1
        nextDeparture(timestamp, ids)

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
        print("p13b: convergence at \(t)")
    }

    static func nextDeparture(_ timestamp: Int, _ ids: [Int]) {
        var results = [Int: Int]()

        for id in ids {
            if id == 1 { continue }
            // print(timestamp % id)
            let nextDeparture = ((timestamp / id) + 1) * id
            results[nextDeparture] = id
        }

        let next = results.keys.min(by: <)!
        let nextId = results[next]!
        print("p13a: next departure at \(next) \(nextId) -> \((next - timestamp) * nextId)")
    }
}
