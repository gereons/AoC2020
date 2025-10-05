//
// Advent of Code 2020 Day 25
//

import AoCTools

final class Day25: AdventOfCodeDay, @unchecked Sendable {
    let title: String = "Combo Breaker"

    let cardPubKey: Int
    let doorPubKey: Int

    init(input: String) {
        let lines = input.lines
        cardPubKey = Int(lines[0])!
        doorPubKey = Int(lines[1])!
    }

    func part1() -> Int {
        var cardLoop = 0
        var doorLoop = 0

        for i in 1 ... 100_000_000 {
            let tx = transform(7, loopSize: i)
            // print(i, tx)
            if cardLoop == 0 {
                if tx == cardPubKey {
                    // print("card loop: \(i) \(tx)")
                    cardLoop = i
                }
            }
            if doorLoop == 0 {
                if tx == doorPubKey {
                    // print("door loop: \(i) \(tx)")
                    doorLoop = i
                }
            }
            if cardLoop != 0 && doorLoop != 0 {
                break
            }
        }

        // print(fullTransform(doorPubKey, loopSize: cardLoop))
        return fullTransform(cardPubKey, loopSize: doorLoop)
    }

    func part2() -> Int {
        0
    }

    private var txCache = [Int: Int]()

    private func transform(_ subject: Int, loopSize: Int) -> Int {
        if loopSize == 1 {
            let result = 1 * subject % 20201227
            txCache[loopSize] = result
            return result
        }

        if let cached = txCache[loopSize-1] {
            let result = cached * subject % 20201227
            txCache[loopSize] = result
            return result
        }

        fatalError()
    }

    private func fullTransform(_ subject: Int, loopSize: Int) -> Int {
        var v = 1
        for _ in 0..<loopSize {
            v *= subject
            v %= 20201227
        }
        return v
    }
}

