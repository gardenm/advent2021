import Foundation

let fileText = try! String(contentsOfFile: "sonar.txt", encoding: .utf8)
let text = fileText.components(separatedBy: "\n").filter { !$0.isEmpty }.compactMap(Int.init)

var count = 0
for i in 1...text.count-1 {
    if text[i] > text[i-1] {
        count += 1
    }
}
print(count)
