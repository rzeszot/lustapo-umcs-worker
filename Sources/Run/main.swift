import Foundation
import LustapoWorker

struct Output: Encodable {
    let station: String
    let data: Payload
}

extension JSONEncoder.DateEncodingStrategy {
    static var fallback: Self {
        .custom { date, encoder in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)

            let string = formatter.string(from: date)

            var container = encoder.singleValueContainer()
            try container.encode(string)
        }
    }
}

extension Date {
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

func filename(station: Station, date: Date) -> String {
    return [
        date.format("yyyy-MM-dd"),
        "umcs_\(station.id)_\(date.format("yyyy-MM-dd-HH-mm")).json"
    ].joined(separator: "/")
}

func fix(_ data: Data) -> Data? {
    guard let string = String(data: data, encoding: .utf8) else { return nil }
    guard let regexp = try? NSRegularExpression(pattern: "([a-zA-Z][a-zA-Z0-9]+):", options: .anchorsMatchLines) else { return nil }

    let result = NSMutableString(string: string)
    regexp.replaceMatches(in: result, options: .withoutAnchoringBounds, range: NSRange(location: 0, length: string.count), withTemplate: "\"$1\":")

    return result.data(using: String.Encoding.utf8.rawValue)
}

let file = URL(fileURLWithPath: "Data/stations.json")
let stations = try JSONDecoder().decode([Station].self, from: Data(contentsOf: file))

for station in stations {
    do {
        print(" > \(station.name)")

        let url = URL(station: station)
        let data = try Data(contentsOf: url)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.remote)

        let payload = try decoder.decode(Payload.self, from: fix(data)!)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .fallback

        let content = try encoder.encode(Output(station: station.id, data: payload))

        let output = URL(fileURLWithPath: "Data/umcs/\(station.id)/\(filename(station: station, date: payload.date))")
        try FileManager.default.createDirectory(at: output.deletingLastPathComponent(), withIntermediateDirectories: true)


        try content.write(to: output)

    } catch {
        print("error \(error)")
    }
}
