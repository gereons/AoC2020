//
// Advent of Code 2020 Day 18
//

import AoCTools

private protocol Expr {
    var value: Int { get }
}

final class Day18: AdventOfCodeDay {
    let title: String = "Operation Order"

    let lines: [String]

    init(input: String) {
        lines = input.lines
    }

    enum Precedence {
        case leftToRight
        case addBeforeMult
    }

    func part1() -> Int {
        var results = [Int]()
        for input in lines {
            let result = solve(input, precedence: .leftToRight)
            results.append(result)
        }
        return results.reduce(0, +)
    }

    func part2() -> Int {
        var results = [Int]()
        for input in lines {
            let result = solve(input, precedence: .addBeforeMult)
            results.append(result)
        }
        return results.reduce(0, +)
    }

    // shunting yard implementation
    private func solve(_ input: String, precedence: Precedence) -> Int {
        var numStack = [Int]()
        var opStack = [Character]()
        var expr = input[...]

        func _precedence(_ ch: Character) -> Int {
            switch precedence {
            case .leftToRight: ch == "(" ? 1 : 2
            case .addBeforeMult: ch == "(" ? 1 : ch == "*" ? 2 : 3
            }
        }

        while !expr.isEmpty {
            let ch = expr.popFirst()!
            switch ch {
            case "0"..."9":
                numStack.append(Int(String(ch))!)
            case "(":
                opStack.append(ch)
            case ")":
                while let op = opStack.popLast(), op != "(" {
                    guard let n1 = numStack.popLast(), let n2 = numStack.popLast() else { fatalError() }
                    numStack.append(op == "+" ? n1 + n2 : n1 * n2)
                }
            case "*", "+":
                while !opStack.isEmpty, let topOp = opStack.last, _precedence(ch) <= _precedence(topOp) {
                    let op = opStack.popLast()!
                    guard let n1 = numStack.popLast(), let n2 = numStack.popLast() else { fatalError() }
                    numStack.append(op == "+" ? n1 + n2 : n1 * n2)
                }
                opStack.append(ch)
            default:
                continue
            }
        }
        while !opStack.isEmpty {
            let op = opStack.popLast()!
            guard let n1 = numStack.popLast(), let n2 = numStack.popLast() else { fatalError() }
            numStack.append(op == "+" ? n1 + n2 : n1 * n2)
          }
        guard numStack.count == 1 else { fatalError() }

        return numStack.popLast()!
    }
}
