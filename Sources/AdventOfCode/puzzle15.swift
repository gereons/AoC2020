import Foundation

struct Puzzle15 {
    static let input = [1,20,11,6,12,0] // [0,3,6]

    static func run() {
        let last = sayNumbers(input, turns: 2020)
        print("p15a: last number is \(last)")

        let last2 = sayNumbers(input, turns: 30000000)
        print("p15b: last number is \(last2)")
    }

    static func sayNumbers(_ input: [Int], turns: Int) -> Int {
        var spoken = [Int: [Int]]()
        var lastSpoken = input.last!

        for (index, num) in input.enumerated() {
            spoken[num] = [index + 1]
        }

        for turn in input.count + 1 ... turns {
            var say: Int
            let turnsSpoken = spoken[lastSpoken]!
            if turnsSpoken.count == 1 {
                say = 0
            } else {
                say = turnsSpoken[0] - turnsSpoken[1]
            }

            if turn % 1_000_000 == 0 {
                print("turn \(turn), saying \(say)")
            }
            spoken[say, default:[]].insert(turn, at: 0)
            spoken[say] = Array(spoken[say]!.prefix(2))
            lastSpoken = say
        }

        return lastSpoken
    }
}
