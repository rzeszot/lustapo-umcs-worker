import Foundation

public extension URL {
    internal init(version: Station.Version) {
        let number = version == .v0 ? "" : version.rawValue
        self = URL(string: "http://212.182.4.252/data\(number).php")!
    }

    init(station: Station) {
        var components = URLComponents(url: URL(version: station.version), resolvingAgainstBaseURL: false)!
        components.queryItems = [ URLQueryItem(name: "s", value: station.id) ]
        self = components.url!
    }
}
