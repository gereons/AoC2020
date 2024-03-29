import Foundation

public func getGroups(_ lines: [String]) -> [String] {
    var groups = [String]()

    var tmp = [String]()
    for line in lines {
        if line.isEmpty {
            groups.append(tmp.joined(separator: " "))
            tmp = []
        } else {
            tmp.append(line)
        }
    }

    if !tmp.isEmpty {
        groups.append(tmp.joined(separator: " "))
    }

    return groups
}

Puzzle1.run()
Puzzle2.run()
Puzzle3.run()
Puzzle4.run()
Puzzle5.run()
Puzzle6.run()
Puzzle7.run()
Puzzle8.run()
Puzzle9.run()
Puzzle10.run()
Puzzle11.run()
Puzzle12.run()
Puzzle13.run()
Puzzle14.run()
Puzzle15.run()
Puzzle16.run()
Puzzle17.run()
Puzzle18.run()
Puzzle19.run()
Puzzle20.run()
Puzzle21.run()
Puzzle22.run()
Puzzle23.run()
Puzzle24.run()
Puzzle25.run()
