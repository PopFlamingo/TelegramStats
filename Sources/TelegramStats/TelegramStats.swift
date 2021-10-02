import Foundation
import ArgumentParser
import SwiftProtobuf

@main
struct TelegramStats: ParsableCommand {
    
    static let abstract = "Make statistics about Telegram conversations"
    
    static var configuration: CommandConfiguration = CommandConfiguration(commandName: "TelegramStats", abstract: abstract, subcommands: [WordCount.self, HourActivity.self])
    
    struct WordCount: ParsableCommand {
        static let abstract = "Count the number of occurences of individual words"
        static let discussion = """
        Currently, this command extracts words by simply splitting the messages with a \
        whitespace as a separator, it then normalizes words by lowercasing them.
        """
        
        
        static var configuration: CommandConfiguration = CommandConfiguration(abstract: abstract, discussion: discussion)
        
        
        
        @Argument(help: "The path of the JSON file to parse")
        var filePath: String
        
        @Option(name: .shortAndLong, help: "Limit output to the first n results")
        var limit: Int?
        
        @Option(name: .long, help: "Only include messages from the specified user")
        var from: String?
        
        @Flag(name: .long, help: "Outputs the results in JSON")
        var outputJSON: Bool = false
        
        @Flag(name: .long, help: "Output the least common words first")
        var reverseSort: Bool = false
        
        struct WordCount: Codable {
            var word: String
            var count: Int
        }
        
        mutating func run() throws {
            var words: [String:Int] = [:]
            let fileURL = URL(fileURLWithPath: filePath)
            let fileData = try Data(contentsOf: fileURL)
            var decodingOptions = JSONDecodingOptions()
            decodingOptions.ignoreUnknownFields = true
            let export = try TelegramExport(jsonUTF8Data: fileData, options: decodingOptions)
            for message in export.messages {
                if let from = from, message.from != from {
                    continue
                }
                let text = message.text.stringValue
                for word in text.split(separator: " ") {
                    let lowercased = word.lowercased()
                    if words[lowercased] != nil {
                        words[lowercased]! += 1
                    } else {
                        words[lowercased] = 1
                    }
                }
            }
            
            var wordsArray = Array(words)
            
            wordsArray.sort(by: { $0.key < $1.key })
            
            if reverseSort {
                wordsArray.sort(by: { $0.value < $1.value })
            } else {
                wordsArray.sort(by: { $0.value > $1.value })
            }
            
            
            if let limit = limit {
                wordsArray = Array(wordsArray[..<limit])
            }
            
            if outputJSON {
                var elements = [WordCount]()
                for (word, count) in wordsArray {
                    elements.append(.init(word: word, count: count))
                }
                let jsonEncoder = JSONEncoder()
                jsonEncoder.outputFormatting = .prettyPrinted
                let encodedData = try jsonEncoder.encode(elements)
                print(String(data: encodedData, encoding: .utf8)!)
            } else {
                
                for (word, count) in wordsArray {
                    print("\"\(word)\" ⨉ \(count)")
                }
            }
            
            
        }
    }
    
    
    struct HourActivity: ParsableCommand {
        static let abstract = "Shows a graph with message percentage by hour"
        static let discussion = """
        TBD
        """
        
        
        static var configuration: CommandConfiguration = CommandConfiguration(abstract: abstract, discussion: discussion)
        
        
        
        @Argument(help: "The path of the JSON file to parse")
        var filePath: String
        
        @Option(name: .long, help: "TZ database name for the timezone to convert to (eg: Europe/Paris)")
        var timezone: String?
        
        @Option(name: .long, help: "Only include messages from the specified user")
        var from: String?
        
        @Option(name: .long, help: "Start date in dd/mm/yyyy format")
        var startDate: String?
        
        @Option(name: .long, help: "End date in dd/mm/yyyy format")
        var endDate: String?
        
        @Option(name: .long, help: "Scale the graph by the specified integer")
        var scale: Int = 1
        
        
        
        mutating func run() throws {
            let fileURL = URL(fileURLWithPath: filePath)
            let fileData = try Data(contentsOf: fileURL)
            var decodingOptions = JSONDecodingOptions()
            decodingOptions.ignoreUnknownFields = true
            var counter = [Int](repeating: 0, count: 24)
            let export = try TelegramExport(jsonUTF8Data: fileData, options: decodingOptions)
            let formatter = ISO8601DateFormatter()
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = TimeZone(secondsFromGMT: 0)!
            var total = 0.0
            
            var startDateValue: Date?
            if let startDate = startDate {
                let split = startDate.split(separator: "/").compactMap({ return Int($0) })
                precondition(split.count == 3, "Invalid date format")
                var components = DateComponents()
                components.day = split[0]
                components.month = split[1]
                components.year = split[2]
                guard let validStartDate = calendar.date(from: components) else {
                    fatalError("Invalid date format")
                }
                startDateValue = validStartDate
            }
            
            var endDateValue: Date?
            if let endDate = endDate {
                let split = endDate.split(separator: "/").compactMap({ return Int($0) })
                precondition(split.count == 3, "Invalid date format")
                var components = DateComponents()
                components.day = split[0]
                components.month = split[1]
                components.year = split[2]
                guard let validEndDate = calendar.date(from: components) else {
                    fatalError("Invalid date format")
                }
                endDateValue = validEndDate
            }
            
            for message in export.messages {
                if let from = from, message.from != from {
                    continue
                }
                let date = formatter.date(from: message.date + "Z")!
                
                if let startDateValue = startDateValue, date < startDateValue {
                    continue
                }
                
                if let endDateValue = endDateValue, date > endDateValue {
                    continue
                }
                
                total += 1
                
                let hourComponent: Int
                if let timezoneID = timezone {
                    guard let existingTimezone = TimeZone(identifier: timezoneID) else {
                        fatalError("Invalid timezone code: \(timezoneID)")
                    }
                    
                    let components = calendar.dateComponents(in: existingTimezone, from: date)
                    hourComponent = components.hour!
                } else {
                    hourComponent = calendar.component(.hour, from: date)
                }
                counter[hourComponent] += 1
            }
            
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumIntegerDigits = 2
            for i in 0..<24 {
                let percentage = Int(((Double(counter[i])/total) * 100).rounded()) * scale
                let hourString = numberFormatter.string(from: NSNumber(value: i))!
                let points = [String](repeating: "•", count: percentage).joined()
                print("\(hourString):00 - \(points)")
            }
            
            
        }
    }
    
}
