import Foundation

struct Puzzle8 {
    static let data = """
    nop +0
    acc +1
    jmp +4
    acc +3
    jmp -3
    acc -99
    acc +1
    jmp -4
    acc +6
    """

    static func run() {
        // let data = Self.data.components(separatedBy: "\n")
        let data = readFile(named: "puzzle8.txt")
        let program = createProgram(from: data)

        let lastAcc = runProgram(program)
        print("p8a: last acc value \(lastAcc)")

        let lastAcc2 = runModifiedProgram(program)
        print("p8b: last acc value \(lastAcc2)")
    }

    enum Opcode: String {
        case acc, jmp, nop
    }

    struct Instruction {
        let opcode: Opcode
        let operand: Int
    }

    static func createProgram(from data: [String]) -> [Instruction] {
        var program = [Instruction]()
        for line in data {
            let opcodes = line.components(separatedBy: " ")
            if let cmd = Opcode(rawValue: opcodes[0]), let operand = Int(opcodes[1]) {
                program.append(Instruction(opcode: cmd, operand: operand))
            }
        }
        return program
    }

    static func runProgram(_ program: [Instruction]) -> Int {
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

    static func runProgramToFinish(_ program: [Instruction]) -> Int {
        var visitedLines = Set<Int>()
        var pc = 0
        var accumulator = 0
        while pc < program.count {
            visitedLines.insert(pc)
            let instruction = program[pc]
            print("line \(pc): \(instruction.opcode.rawValue) \(instruction.operand)")
            switch instruction.opcode {
            case .acc:
                accumulator += instruction.operand
                pc += 1
            case .nop:
                pc += 1
            case .jmp:
                let newPc = pc + instruction.operand
                if visitedLines.contains(newPc) {
                    // created a loop, ignore this jmp
                    print("--loop detected")
                    pc += 1
                } else {
                    pc = newPc
                }
            }
        }
        return accumulator
    }

    static func runModifiedProgram(_ program: [Instruction]) -> Int {
        var visitedLines = Set<Int>()
        return compute(program, 0, 0, &visitedLines, true)!
    }

    static func compute(_ program: [Instruction], _ pc: Int, _ acc: Int, _ visited: inout Set<Int>, _ canMutate: Bool) -> Int? {
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
