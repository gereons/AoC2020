//
// Advent of Code 2020 Day 21
//

import AoCTools

final class Day21: AdventOfCodeDay {
    let title: String = "Allergen Assessment"

    let possibleAllergens: [String: [[String]]]
    let allIngredients: [[String]]

    init(input: String) {
        // allergen -> potential ingredient combos
        var possibleAllergens = [String: [[String]]]()
        var allIngredients = [[String]]()

        for line in input.lines {
            let parts = line.split(separator: "(")
            let ingredients = parts[0].split(separator: " ").map { String($0) }
            let allergens = parts[1].split(separator: " ").dropFirst().map { String($0.dropLast()) }

            allIngredients.append(ingredients)

            for allergen in allergens {
                possibleAllergens[allergen, default: []].append(ingredients)
            }
        }

        self.possibleAllergens = possibleAllergens
        self.allIngredients = allIngredients
    }

    func part1() -> Int {
        findAllergens().0
    }

    func part2() -> String {
        findAllergens().1
    }

    private func findAllergens() -> (Int, String) {
        var identifiedAllergen = Set<String>()
        var identifiedIngredient = [String]()
        var canonicalDangerousList = [String: String]()

        let allergenCandidates = possibleAllergens.keys.sorted()
        while identifiedAllergen.count < possibleAllergens.count {
            for candidate in allergenCandidates {
                if identifiedAllergen.contains(candidate) {
                    continue
                }
                let recipes = possibleAllergens[candidate]!

                let culprit: String
                if recipes.count == 1 {
                    culprit = recipes[0].filter { !identifiedIngredient.contains($0) }.first!
                } else {
                    var counter = [String: Int]()
                    for recipe in recipes {
                        for ingredient in recipe {
                            if identifiedIngredient.contains(ingredient) {
                                continue
                            }
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
                // print(culprit, "is", candidate)
                identifiedIngredient.append(culprit)
                identifiedAllergen.insert(candidate)
                canonicalDangerousList[candidate] = culprit
            }
        }

        var count = 0
        for recipe in allIngredients {
            for ingredient in recipe {
                if !identifiedIngredient.contains(ingredient) {
                    count += 1
                }
            }
        }

        let dangerous = canonicalDangerousList.keys.sorted().map { key in
            canonicalDangerousList[key]!
        }.joined(separator: ",")

        return (count, dangerous)
    }
}
