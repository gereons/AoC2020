//
// Advent of Code 2020 Day 8
//

import AoCTools

final class Day08: AdventOfCodeDay {
    let title = "Handheld Halting"

    let lines: [String]

    init(input: String) {
        lines = input.lines
    }

    func part1() -> Int {
        let program = createProgram(from: lines)

        let lastAcc = runProgram(program)
        // print("p8a: last acc value \(lastAcc)")
        return lastAcc
    }

    func part2() -> Int {
        let program = createProgram(from: lines)

        let lastAcc2 = runModifiedProgram(program)
        // print("p8b: last acc value \(lastAcc2)")
        return lastAcc2
    }

    enum Opcode: String {
        case acc, jmp, nop
    }

    struct Instruction {
        let opcode: Opcode
        let operand: Int
    }

    private func createProgram(from data: [String]) -> [Instruction] {
        var program = [Instruction]()
        for line in data {
            let opcodes = line.components(separatedBy: " ")
            if let cmd = Opcode(rawValue: opcodes[0]), let operand = Int(opcodes[1]) {
                program.append(Instruction(opcode: cmd, operand: operand))
            }
        }
        return program
    }

    private func runProgram(_ program: [Instruction]) -> Int {
        var visitedLines = Set<Int>()
        var pc = 0
        var accumulator = 0
        while !visitedLines.contains(pc) && pc < program.count {
            visitedLines.insert(pc)
            let instruction = program[pc]
            switch instruction.opcode {
            case .acc:
                accumulator += instruction.operand
                pc += 1
            case .nop:
                pc += 1
            case .jmp:
                pc += instruction.operand
            }
        }

        return accumulator
    }

    private func runModifiedProgram(_ program: [Instruction]) -> Int {
        var visitedLines = Set<Int>()
        return compute(program, 0, 0, &visitedLines, true)!
    }

    private func compute(_ program: [Instruction], _ pc: Int, _ acc: Int, _ visited: inout Set<Int>, _ canMutate: Bool) -> Int? {
        if pc >= program.count {
            return acc
        }
        if visited.contains(pc) {
            return nil
        }

        let instruction = program[pc]
        visited.insert(pc)
        switch instruction.opcode {
        case .acc:
            return compute(program, pc + 1, acc + instruction.operand, &visited, canMutate)
        case .nop:
            var potentialResult = compute(program, pc + 1, acc, &visited, canMutate)
            if potentialResult == nil && canMutate {
                potentialResult = compute(program, pc + instruction.operand, acc, &visited, false)
            }
            return potentialResult
        case .jmp:
            var potentialResult = compute(program, pc + instruction.operand, acc, &visited, canMutate)
            if potentialResult == nil && canMutate {
                potentialResult = compute(program, pc + 1, acc, &visited, false)
            }
            return potentialResult
        }
    }
}
