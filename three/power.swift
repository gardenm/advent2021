import Foundation

extension String {
    func fromBinaryToInt() -> Int {
        return strtol(self, nil, 2)
    }
}

extension StringProtocol {
    subscript(characterIndex: Int) -> Substring? {
        let start = index(startIndex, offsetBy: characterIndex)
        let end = start

        return self[start...end] as? Substring
    }
}

let fileName = "diagnostic.txt"
let fileText = try! String(contentsOfFile: fileName, encoding: .utf8)
let diags = fileText.components(separatedBy: "\n")
    .filter { !$0.isEmpty }

func bitAtIndex(_ index: Int, in diagnostics: [String], yesValue: String, noValue: String) -> String {
    let ones = diagnostics.filter { $0[index] == "1" }.count
    return ones >= diagnostics.count - ones ? yesValue : noValue 
}

func search(in diagnostics: [String], toIndex: Int, yesValue: String, noValue: String) -> String {
    var result = ""
    for i in 0...toIndex {
        result += bitAtIndex(i, in: diagnostics, yesValue: yesValue, noValue: noValue)
    }
    return result
}

func findGamma(in diagnostics: [String], toIndex index: Int) -> String {
    return search(in: diagnostics, toIndex: index, yesValue: "1", noValue: "0")
}

func findEpsilon(in diagnostics: [String], toIndex index: Int) -> String {
    return search(in: diagnostics, toIndex: index, yesValue: "0", noValue: "1")
}

let gamma = findGamma(in: diags, toIndex: diags[0].count - 1)
let epsilon = findEpsilon(in: diags, toIndex: diags[0].count - 1)

print("gamma: \(gamma)")
print("epsilon: \(epsilon)")
print(gamma.fromBinaryToInt() * epsilon.fromBinaryToInt())

func findRating(in diagnostics: [String], yesValue: String, noValue: String) -> String {
    var candidates = diagnostics
    for i in 0...diagnostics[0].count - 1 where candidates.count > 1 {
        let bit = bitAtIndex(i, in: candidates, yesValue: yesValue, noValue: noValue)

        candidates = candidates.filter { candidate in
            guard let sub = candidate[i] else { return false }
            return String(sub) == bit
        }
    }
    assert(candidates.count == 1)
    return candidates.first ?? ""
}

let scrubber = findRating(in: diags, yesValue: "1", noValue: "0")
let generator = findRating(in: diags, yesValue: "0", noValue: "1")
print(scrubber.fromBinaryToInt() * generator.fromBinaryToInt())
