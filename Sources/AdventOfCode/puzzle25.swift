import Foundation

struct Puzzle25 {

    static func run() {
//        let cardPubKey = 5764801
//        let doorPubKey = 17807724

        let cardPubKey = 9232416
        let doorPubKey = 14144084

        var cardLoop = 0
        var doorLoop = 0

        for i in 1 ... 100_000_000 {
            let tx = transform(7, loopSize: i)
            // print(i, tx)
            if cardLoop == 0 {
                if tx == cardPubKey {
                    print("card loop: \(i) \(tx)")
                    cardLoop = i
                }
            }
            if doorLoop == 0 {
                if tx == doorPubKey {
                    print("door loop: \(i) \(tx)")
                    doorLoop = i
                }
            }
            if cardLoop != 0 && doorLoop != 0 {
                break
            }
        }

        print(fullTransform(cardPubKey, loopSize: doorLoop))
        // print(fullTransform(doorPubKey, loopSize: cardLoop))
    }

    private static var txCache = [Int: Int]()

    private static func transform(_ subject: Int, loopSize: Int) -> Int {
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

    private static func fullTransform(_ subject: Int, loopSize: Int) -> Int {
        var v = 1
        for _ in 0..<loopSize {
            v *= subject
            v %= 20201227
        }
        return v
    }
}

