//
// Advent of Code 2020 Day 22
//

import AoCTools

final class Day22: AdventOfCodeDay {
    let title: String = "Crab Combat"

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

    let deck1: [Int]
    let deck2: [Int]

    init(input: String) {
        var deck1 = [Int]()
        var deck2 = [Int]()

        var player = 1
        for line in input.lines {
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
        self.deck1 = deck1
        self.deck2 = deck2
    }

    func part1() -> Int {
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
        return score
    }

    func part2() -> Int {
        let (_, deck) = playCombat(deck1, deck2)
        // print(winner)
        // print(deck)
        var score = 0
        for (index, card) in deck.enumerated().reversed() {
            score += card * (deck.count - index)
        }
        return score
    }

    struct State: Hashable {
        let hash1: Int
        let hash2: Int

        init(_ deck1: [Int], _ deck2: [Int]) {
            hash1 = deck1.hashValue
            hash2 = deck2.hashValue
        }
    }

    private func playCombat(_ deck1: [Int], _ deck2: [Int]) -> (Int, [Int]) {
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
