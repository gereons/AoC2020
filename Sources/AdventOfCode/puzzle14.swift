import Foundation
import Algorithms

struct Puzzle14 {
    static let data = """
    mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
    mem[8] = 11
    mem[7] = 101
    mem[8] = 0
    """

    static let data2 = """
    mask = 000000000000000000000000000000X1001X
    mem[42] = 100
    mask = 00000000000000000000000000000000X0XX
    mem[26] = 1
    """

    static func run() {
        let lines = Self.data2.components(separatedBy: "\n")
        // let lines = Array(readFile(named: "puzzle14.txt").dropLast())

        // decoder_v1(lines)

        decoder_v2(lines)
    }

    static func decoder_v2(_ lines: [String]) {
    }

    static func decoder_v1(_ lines: [String]) {
        var andMask: UInt64 = 0
        var orMask: UInt64 = 0

        var memory = [String: UInt64]()

        for line in lines {
            let parts = line.components(separatedBy: " = ")
            if parts[0] == "mask" {
                andMask = UInt64(parts[1].replacingOccurrences(of: "X", with: "1"), radix: 2)!
                orMask = UInt64(parts[1].replacingOccurrences(of: "X", with: "0"), radix: 2)!
                // print(String(andMask, radix: 2))
                // print(String(orMask, radix: 2))
            } else if parts[0].hasPrefix("mem") {
                var value = UInt64(parts[1])!
                // print(value, String(value, radix: 2))
                value &= andMask
                value |= orMask
                memory[parts[0]] = value
                // print(value, String(value, radix: 2))
            } else {
                print("ooops: \(line)")
            }
        }

        print(memory.count)
        print(memory.reduce(Decimal.zero) { $0 + Decimal($1.value) })
    }
}
