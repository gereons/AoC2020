import Foundation

struct Puzzle6 {
    static func run() {
        let data = readFile(named: "puzzle6.txt")
//        let data = [
//            "abc",
//            "",
//            "a b c",
//            "",
//            "ab ac",
//            "",
//            "a a a a",
//            "",
//            "b"
//        ]

        let answers = getGroups(data)

        // part 1
        let sum = answers.reduce(0) { $0 + getUniqueCount($1) }
        print("p6a: \(sum) answers")

        // part 2
        let sum2 = answers.reduce(0) { $0 + getAgreeingCount($1) }
        print("p6b: \(sum2) answers")
    }

    static func getAgreeingCount(_ str: String) -> Int {
        let people = str.components(separatedBy: " ")

        let answers = people.map { Set($0.map { $0 }) }

        let result = answers.reduce(answers[0]) { $0.intersection($1) }

        return result.count
    }

    static func getUniqueCount(_ str: String) -> Int {
        var set = Set<Character>()

        for ch in str.replacingOccurrences(of: " ", with: "") {
            set.insert(ch)
        }

        return set.count
    }
}
