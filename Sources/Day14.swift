//
// Advent of Code 2020 Day 14
//

import AoCTools

final class Day14: AdventOfCodeDay {
    let title = "Docking Data"

    let lines: [String]

    init(input: String) {
        lines = input.lines
    }

    func part1() -> UInt64 {
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

        return memory.reduce(0) { $0 + $1.value }
    }

    func part2() -> UInt64 {
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

        return memory.reduce(0) { $0 + $1.value }
    }

    private func allAddresses(address: UInt64, floatingBits: [Int], _ result: inout Set<UInt64>) {
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
}
