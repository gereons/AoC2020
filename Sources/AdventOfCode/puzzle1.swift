import Foundation

struct Puzzle1 {

    private static var expenses = Set<Int>()

    static func part1() {
        for i in expenses {
            let test = 2020 - i
            if expenses.contains(test) {
                print("p1a: found pair: \(i) \(test) = \(i * test)")
                return
            }
        }
    }

    static func part2() {
        for i in expenses {
            for j in expenses {
                if i == j { continue }
                let test = 2020 - i - j
                if test > 0 && expenses.contains(test) {
                    print("p1b: found triplet: \(i) \(j) \(test) = \(i * j * test)")
                    return
                }
            }
        }
    }

    static func run() {
        let data = readFile(named: "puzzle1.txt")

        expenses = Set(data.compactMap { Int($0) })

        part1()
        part2()
    }
}
