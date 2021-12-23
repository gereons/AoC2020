import Foundation

struct Puzzle14 {
    static let data1 = """
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
        // let lines = Self.data2.components(separatedBy: "\n")
        let lines = readFile(named: "puzzle14.txt")

        decoder_v1(lines) // 11926135976176
        decoder_v2(lines) // 4330547254348
    }

    static func decoder_v2(_ lines: [String]) {
        var orMask: UInt64 = 0
        var floatingBits = [Int]()

        var memory = [UInt64: UInt64]()

        for line in lines {
            let parts = line.split(separator: " ")
            if parts[0] == "mask" {
                let mask = parts[2]
                orMask = UInt64(mask.replacingOccurrences(of: "X", with: "0"), radix: 2)!
                floatingBits = mask.map { $0 }.reversed().enumerated().filter { $0.1 == "X" }.map { $0.0 }
            } else if parts[0].hasPrefix("mem") {
                let tokens = parts[0].split(separator: "[")
                var address = UInt64(tokens[1].dropLast())!
                let value = UInt64(parts[2])!
                address |= orMask

                var result = Set<UInt64>()
                allAddresses(address: address, floatingBits: floatingBits, &result)

                result.forEach {
                    memory[$0] = value
                }
            } else {
                fatalError("ooops: \(line)")
            }
        }

        print(memory.reduce(UInt64(0)) { $0 + $1.value })
    }

    private static func allAddresses(address: UInt64, floatingBits: [Int], _ result: inout Set<UInt64>) {
        guard let bitPosition = floatingBits.last else { return }
        let value: UInt64 = 1 << bitPosition

        // turn off this bit
        let a = address & ~value
        let nextBits = Array(floatingBits.dropLast())
        let a1 = a | value
        result.insert(a1)
        allAddresses(address: a1, floatingBits: nextBits, &result)
        let a2 = a & ~value
        result.insert(a2)
        allAddresses(address: a2, floatingBits: nextBits, &result)
    }

    static func decoder_v1(_ lines: [String]) {
        var andMask: UInt64 = 0
        var orMask: UInt64 = 0

        var memory = [UInt64: UInt64]()

        for line in lines {
            let parts = line.split(separator: " ")
            if parts[0] == "mask" {
                andMask = UInt64(parts[2].replacingOccurrences(of: "X", with: "1"), radix: 2)!
                orMask = UInt64(parts[2].replacingOccurrences(of: "X", with: "0"), radix: 2)!
            } else if parts[0].hasPrefix("mem") {
                let tokens = parts[0].split(separator: "[")
                let address = UInt64(tokens[1].dropLast())!
                var value = UInt64(parts[2])!
                value &= andMask
                value |= orMask
                memory[address] = value
            } else {
                fatalError("ooops: \(line)")
            }
        }

        print(memory.reduce(UInt64(0)) { $0 + $1.value })
    }
}
