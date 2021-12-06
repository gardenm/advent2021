import Foundation

enum Command {
    case down(Int)
    case forward(Int)
    case up(Int)

    init?(_ rawValue: String) {
        let terms = rawValue.components(separatedBy: " ")
        guard terms.count == 2,
              let command = terms.first,
              let amountString = terms.last,
              let amount = Int(amountString) else {
              return nil
        }

        switch command {
            case "forward":
                self =  .forward(amount)

            case "down":
                self = .down(amount)
  
            case "up":
                self = .up(amount)

            default:
                return nil
        }
    }

    var isHorizontal: Bool {
        switch self {
            case .forward:
                return true
     
            case .up, .down:
                return false
        }
    }

    var aimDelta: Int {
        switch self {
            case .forward:
                return 0

            case let .up(amount):
                return -amount

            case let .down(amount):
                return amount
        }
    }

    var value: Int {
        switch self {
            case let .forward(amount):
                return amount

            case let .up(amount):
                return -amount

            case let .down(amount):
                return amount
        }
    }
}

let fileText = try! String(contentsOfFile: "steer.txt", encoding: .utf8)
let commands = fileText.components(separatedBy: "\n")
    .filter { !$0.isEmpty }
    .compactMap(Command.init)

let xPosition = commands.filter { $0.isHorizontal }
     .reduce(0) { value, command in 
         value + command.value
     }

let yPosition = commands.filter { !$0.isHorizontal }
     .reduce(0) { value, command in 
         value + command.value 
     }

print(xPosition)
print(yPosition)

print("product: \(xPosition * yPosition)")

var aim = 0
var depth = 0
var horizontal = 0

for command in commands {
    switch command {
        case let .forward(amount):
            horizontal += amount
            depth += aim * amount
  
        case .up, .down:
             aim += command.aimDelta
    }
}

print("final \(horizontal * depth)")
