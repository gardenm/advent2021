import Foundation

let fileText = try! String(contentsOfFile: "sonar.txt", encoding: .utf8)
let text = fileText.components(separatedBy: "\n").filter { !$0.isEmpty }.compactMap(Int.init)

var values = Array(repeating: 0, count: text.count-2)

for i in 0...text.count-3 {
    values[i] += text[i] + text[i+1] + text[i+2]
}

print(values)

var count = 0 
for i in 1...values.count-1 {
    if values[i] > values[i-1] {
        count += 1
    }
}
print(count)
