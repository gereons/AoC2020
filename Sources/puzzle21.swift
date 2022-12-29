import Foundation

struct Puzzle21 {
    static let testData = """
    mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
    trh fvjkl sbzzf mxmxvkd (contains dairy)
    sqjhc fvjkl (contains soy)
    sqjhc mxmxvkd sbzzf (contains fish)
    """.components(separatedBy: "\n")


    static func run() {
        // let lines = Self.data
        let lines = Self.rawInput.components(separatedBy: "\n")

        // allergen -> potential ingredient combos
        var dict = [String: [[String]]]()
        var allIngredients = [[String]]()

        for line in lines {
            let parts = line.split(separator: "(")
            let ingredients = parts[0].split(separator: " ").map { String($0) }
            let allergens = parts[1].split(separator: " ").dropFirst().map { String($0.dropLast()) }

            allIngredients.append(ingredients)

            for allergen in allergens {
                dict[allergen, default: []].append(ingredients)
            }
        }

        var identifiedAllergen = Set<String>()
        var identifiedIngredient = Set<String>()
        var canonicalDangerousList = [String: String]()

        while identifiedAllergen.count < dict.count {
            for allergen in dict.keys {
                if identifiedAllergen.contains(allergen) { continue }
                let recipes = dict[allergen]!

                let culprit: String
                if recipes.count == 1 {
                    culprit = recipes[0][0]
                } else {
                    var counter = [String: Int]()
                    for recipe in recipes {
                        for ingredient in recipe {
                            if identifiedIngredient.contains(ingredient) { continue }
                            counter[ingredient, default: 0] += 1
                        }
                    }

                    let occurrences = counter.sorted { $0.value > $1.value }
                    if occurrences[0].value == occurrences[1].value {
                        continue
                    }
                    let max = occurrences[0]
                    culprit = max.key
                }
                print(culprit, "is", allergen)
                identifiedIngredient.insert(culprit)
                identifiedAllergen.insert(allergen)
                canonicalDangerousList[allergen] = culprit
            }
        }

        var count = 0
        allIngredients.forEach {
            $0.forEach {
                if !identifiedIngredient.contains($0) {
                    count += 1
                }
            }
        }
        print(count)

        for key in canonicalDangerousList.keys.sorted() {
            print(canonicalDangerousList[key]!, terminator: ",")
        }
        print()
    }
}
