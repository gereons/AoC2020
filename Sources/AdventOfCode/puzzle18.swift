import Foundation

protocol Expr {
    var value: Int { get }
}

struct Puzzle18 {

    enum TokenType {
        case integer
        case oparen
        case cparen
        case `operator`
    }

    struct Token: CustomStringConvertible {
        let type: TokenType
        let value: Character

        var description: String {
            return String(value)
        }
    }

    struct Tokenizer {
        static func tokenize(code: String) -> [Token] {
            var tokens = [Token]()
            for ch in code {
                switch ch {
                case "(": tokens.append(Token(type: .oparen, value: ch))
                case ")": tokens.append(Token(type: .cparen, value: ch))
                case "+", "*": tokens.append(Token(type: .operator, value: ch))
                case "0"..."9": tokens.append(Token(type: .integer, value: ch))
                default:
                    continue
                }
            }
            return tokens
        }
    }

    class Parser {
        var tokens: [Token]
        init(_ tokens: [Token]) {
            self.tokens = tokens
        }

        func parse() -> Int {
            return expression()
        }

        func expression() -> Int {
            var lhs = factor()
            while nextOpIs("*") {
                consume(.operator)
                let rhs = factor()
                // print("\(lhs) * \(rhs)")
                lhs *= rhs
            }
            return lhs
        }

        func factor() -> Int {
            var lhs = number()
            while nextOpIs("+") {
                consume(.operator)
                let rhs = number()
                // print("\(lhs) + \(rhs)")
                lhs += rhs
            }
            return lhs
        }

        func number() -> Int {
            if peek(.integer) {
                let int = consume(.integer)
                return Int(String(int.value))!
            }

            if peek(.oparen) {
                consume(.oparen)
                let value = expression()
                consume(.cparen)
                return value
            }

            fatalError("not a number")
        }

        private func nextOpIs(_ ch: Character) -> Bool {
            return
                !tokens.isEmpty &&
                peek(.operator) &&
                tokens[0].value == ch
            }

        private func peek(_ expected: TokenType) -> Bool {
            guard !tokens.isEmpty else { return false }
            return tokens[0].type == expected
        }

        @discardableResult
        private func consume(_ expected: TokenType) -> Token {
            if tokens[0].type == expected {
                return tokens.remove(at: 0)
            } else {
                fatalError("expected \(expected), got \(tokens[0].type)")
            }
        }
    }

    static func run() {
        let xdata = [
            "1 + (2 * 3) + (4 * (5 + 6))", // 51
            "2 * 3 + (4 * 5)", //  becomes 46.
            "5 + (8 * 3 + 9 + 3 * 4 * 3)", // becomes 1445.
            "5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))", // becomes 669060.
            "((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2", // becomes 23340.
        ]
        let data = readFile(named: "puzzle18.txt").dropLast()

        var results = [Int]()
        for input in data {
            print(input)
            let tokens = Tokenizer.tokenize(code: input)
            // print(tokens)

            let parser = Parser(tokens)
            let result = parser.parse()
            print(result)
            results.append(result)
        }
        print(results.reduce(0, +))
    }

    /*

    // shunting yard implementation
    static func precedence(_ ch: Character) -> Int {
        // ch == "(" ? 1 : 2
        ch == "(" ? 1 : ch == "*" ? 2 : 3
    }

    static func run() {

        // let input = "1 + (2 * 3) + (4 * (5 + 6))"
        let data = readFile(named: "puzzle18.txt").dropLast()

        var results = [Int]()
        for input in data {
            let result = solve(input)
            results.append(result)
        }
        print(results.reduce(0, +))
    }

    static func solve(_ input: String) -> Int {
        var numStack = [Int]()
        var opStack = [Character]()
        var expr = input[...]
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
                while !opStack.isEmpty, let topOp = opStack.last, precedence(ch) <= precedence(topOp) {
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
    */
}
