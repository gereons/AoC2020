import Foundation

public func readFile(named name: String) -> [String] {
    let url = URL(fileURLWithPath: "/Users/gereon/dev/AdventOfCode/Fixtures/\(name)")
    if let data = try? Data(contentsOf: url), let str = String(bytes: data, encoding: .utf8) {
        return str.components(separatedBy: "\n")
    }
    return []
}

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

//Puzzle1.run()
//Puzzle2.run()
//Puzzle3.run()
//Puzzle4.run()
//Puzzle5.run()
//Puzzle6.run()
//Puzzle7.run()
//Puzzle8.run()
//Puzzle9.run()
//Puzzle10.run()
//Puzzle11.run()
//Puzzle12.run()
//Puzzle13.run()
//Puzzle14.run()
//Puzzle15.run()
//Puzzle16.run()
//Puzzle17.run()
//Puzzle18.run()
Puzzle19.run()
