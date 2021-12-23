import Foundation

struct Puzzle22 {

    static let testData = """
        Player 1:
        9
        2
        6
        3
        1

        Player 2:
        5
        8
        4
        7
        10
        """

    static func run() {
        let data = readFile(named: "puzzle22.txt")
        // let data = Self.testData.split(separator: "\n", omittingEmptySubsequences: false).map { String($0) }

        var deck1 = [Int]()
        var deck2 = [Int]()

        var player = 1
        for line in data {
            if line.isEmpty {
                player += 1
                continue
            }
            guard let card = Int(line) else { continue }
            if player == 1 {
                deck1.append(card)
            } else {
                deck2.append(card)
            }
        }

        // part1(deck1, deck2)
        part2(deck1, deck2)
    }

    static func part1(_ deck1: [Int], _ deck2: [Int]) {
        var deck1 = deck1
        var deck2 = deck2

        while !deck1.isEmpty && !deck2.isEmpty {
            let draw1 = deck1.removeFirst()
            let draw2 = deck2.removeFirst()

            if draw1 > draw2 {
                deck1.append(contentsOf: [draw1, draw2])
            } else if draw2 > draw1 {
                deck2.append(contentsOf: [draw2, draw1])
            }
        }

        let d = deck1.isEmpty ? deck2 : deck1
        var score = 0
        for (index, card) in d.enumerated().reversed() {
            score += card * (d.count - index)
        }
        print(score)
    }

    static func part2(_ deck1: [Int], _ deck2: [Int]) {
        let (winner, deck) = playCombat(deck1, deck2)
        print(winner)
        print(deck)
        var score = 0
        for (index, card) in deck.enumerated().reversed() {
            score += card * (deck.count - index)
        }
        print(score)
    }

    struct State: Hashable {
        let hash1: Int
        let hash2: Int

        init(_ deck1: [Int], _ deck2: [Int]) {
            hash1 = deck1.hashValue
            hash2 = deck2.hashValue
        }
    }

    static func playCombat(_ deck1: [Int], _ deck2: [Int]) -> (Int, [Int]) {
        // print(#function, deck1, deck2)
        var deck1 = deck1
        var deck2 = deck2

        var states = Set<State>()
        var round = 1

        while !deck1.isEmpty && !deck2.isEmpty {
            let state = State(deck1, deck2)
            if states.contains(state) {
                // print("dup state, game end, p1 win")
                return (1, deck1)
            }
            states.insert(state)

            let draw1 = deck1.removeFirst()
            let draw2 = deck2.removeFirst()
//            print("round", round)
//            print("deck 1:", deck1, "draw", draw1)
//            print("deck 2:", deck2, "draw", draw2)
            round += 1

            if deck1.count >= draw1 && deck2.count >= draw2 {
                let d1 = deck1[0..<draw1]
                let d2 = deck2[0..<draw2]
                let (winner, _) = playCombat(Array(d1), Array(d2))
                if winner == 1 {
                    deck1.append(contentsOf: [draw1, draw2])
                } else if winner == 2 {
                    deck2.append(contentsOf: [draw2, draw1])
                }
            } else if draw1 > draw2 {
                deck1.append(contentsOf: [draw1, draw2])
            } else if draw2 > draw1 {
                deck2.append(contentsOf: [draw2, draw1])
            } else {
                fatalError()
            }
        }
        if deck1.isEmpty {
            // print("game end, p2 win")
            return (2, deck2)
        } else if deck2.isEmpty {
            // print("game end, p1 win")
            return (1, deck1)
        }
        fatalError()
    }
}
