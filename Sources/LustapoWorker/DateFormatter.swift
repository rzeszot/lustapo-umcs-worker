import Foundation

public extension DateFormatter {
    static var remote: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.locale = Locale(identifier: "pl_PL")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
}
