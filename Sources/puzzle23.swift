import Foundation
import Darwin

struct Puzzle23 {

    class Cup: CustomStringConvertible, Equatable {
        let label: Int
        var next: Cup?

        init(label: Int) {
            self.label = label
            self.next = nil
        }

        var description: String {
            return "\(label)"
        }

        static func == (lhs: Cup, rhs: Cup) -> Bool {
            lhs.label == rhs.label
        }
    }

    class Ring {
        private(set) var current: Cup?
        private var pickedUp: Cup?
        private var pickedUpLabels = [Int]()
        private let maxC: Int

        private var cups = [Int: Cup]()

        init(startAt cup: Cup) {
            self.current = cup

            var maxC = 0
            var cup = current!
            repeat {
                cups[cup.label] = cup
                maxC = max(maxC, cup.label)
                cup = cup.next!
            } while cup != current
            self.maxC = maxC
        }

        func move(_ m: Int) {
            // show(m)
            pickUp()
            moveToDestination()
            current = current?.next
        }

        func show(_ m: Int) {
            print("\n-- move \(m) --")
            var cup = current!
            repeat {
                if cup == current {
                    print("(\(cup.label))", terminator: " ")
                } else {
                    print("\(cup.label)", terminator: " ")
                }
                cup = cup.next!
            } while cup != current
            print()
        }

        func pickUp() {
            let start = current?.next
            self.pickedUp = start
            let end = start?.next?.next

            current?.next = end?.next
            end?.next = nil

            pickedUpLabels = []
            var c = start
            while c != nil {
                pickedUpLabels.append(c!.label)
                c = c?.next
            }
            // print("pickup: ", pickedUpLabels.map { String($0) }.joined(separator: ", "))
        }

        func moveToDestination() {
            var destination = current!.label - 1
            while pickedUpLabels.contains(destination) || destination < 1 {
                destination -= 1
                if destination < 0 {
                    destination = maxC
                }
            }
            // print("destination: ", destination)

            let add = cups[destination]
            let add1 = add?.next

            pickedUp?.next?.next?.next = add1
            add?.next = pickedUp

            pickedUp = nil
        }

        func count(startAt cup: Cup?) -> Int {
            var cnt = 0
            var c = cup
            repeat {
                cnt += 1
                c = c?.next
            } while c != cup
            return cnt
        }
    }

    static func run() {
        part1()
        part2()
    }

    static func part1() {
        // let input = "389125467" // example
        let input = "952438716"

        var head: Cup?
        var prev: Cup?
        for label in input.map({ Int(String($0))! }) {
            let cup = Cup(label: label)
            if head == nil {
                head = cup
            }
            if let p = prev {
                p.next = cup
            }
            prev = cup
        }
        // close the loop
        prev?.next = head!

        let ring = Ring(startAt: head!)
        for i in 1...100 {
            ring.move(i)
        }
        ring.show(0)
    }

    static func part2() {
        // let input = "389125467" // example
        let input = "952438716"

        var head: Cup?
        var prev: Cup?
        var one: Cup?
        var labels = input.map({ Int(String($0))! })
        labels.append(contentsOf: Array(10...1_000_000))
        for label in labels {
            let cup = Cup(label: label)
            if label == 1 {
                one = cup
            }
            if head == nil {
                head = cup
            }
            if let p = prev {
                p.next = cup
            }
            prev = cup
        }
        // close the loop
        prev?.next = head!

        setbuf(stdout, nil)
        let ring = Ring(startAt: head!)
        for i in 1...10_000_000 {
            ring.move(i)
        }

        let l1 = one?.next?.label ?? 0
        let l2 = one?.next?.next?.label ?? 0
        print(l1, l2, l1*l2)
    }
}

