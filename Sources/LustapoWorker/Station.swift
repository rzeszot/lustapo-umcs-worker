import Foundation

public struct Station: Decodable {

    public enum Version: String, Decodable {
        case v0 = "0"
        case v2 = "2"
    }

    public let id: String
    public let version: Version = .v0
    public let name: String

}
