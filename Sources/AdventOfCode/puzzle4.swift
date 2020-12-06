import Foundation

struct Puzzle4 {
    static let requiredFields = [ "byr", "iyr","eyr","hgt","hcl","ecl","pid" ] // cid is optional
    static func run() {
        let data = readFile(named: "puzzle4.txt")

        let passports = getGroups(data)
        let valid1 = checkFields(passports)
        print("p4a: \(valid1) passports")

        let valid2 = validateFields(passports)
        print("p4b: \(valid2) passports")
    }

    static func checkFields(_ passports: [String]) -> Int {
        var valid = 0
        for passport in passports {
            valid += passportValid(passport) ? 1 : 0
        }

        return valid
    }

    static func validateFields(_ passports: [String]) -> Int {
        var valid = 0
        for passport in passports {
            guard passportValid(passport) else { continue }

            var fieldsValid = 0
            let parts = passport.components(separatedBy: " ")
            for p in parts {
                let p2 = p.components(separatedBy: ":")
                let key = p2[0]
                let value = p2[1]
                switch key {
                case "byr":
                    if let val = Int(value), val >= 1920, val <= 2002 {
                        fieldsValid += 1
                    }
                case "iyr":
                    if let val = Int(value), val >= 2010, val <= 2020 {
                        fieldsValid += 1
                    }
                case "eyr":
                    if let val = Int(value), val >= 2020, val <= 2030 {
                        fieldsValid += 1
                    }
                case "hgt":
                    if value.hasSuffix("cm"), let val = Int(value.dropLast(2)), val >= 150, val <= 193 {
                        fieldsValid += 1
                    } else if value.hasSuffix("in"), let val = Int(value.dropLast(2)), val >= 59, val <= 76 {
                        fieldsValid += 1
                    }
                case "hcl":
                    if value.hasPrefix("#") {
                        let chars = CharacterSet.lowercaseLetters.union(CharacterSet.decimalDigits)
                        fieldsValid += value.dropFirst().rangeOfCharacter(from: chars) != nil ? 1 : 0
                    }
                case "ecl":
                    fieldsValid += ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(value) ? 1 : 0
                case "pid":
                    if value.count == 9, Int64(value) != nil {
                        fieldsValid += 1
                    }
                default:
                    ()
                }
            }
            valid += fieldsValid == 7 ? 1 : 0
        }

        return valid
    }

    static func passportValid(_ passport: String) -> Bool {
        let parts = passport.components(separatedBy: " ")
        var fieldsOk = 0
        for p in parts {
            for rq in requiredFields {
                if p.hasPrefix(rq) {
                    fieldsOk += 1
                }
            }
        }
        return fieldsOk == requiredFields.count
    }
}
