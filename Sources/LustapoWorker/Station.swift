import Foundation

public struct Station: Decodable {

    public enum Version: String, Decodable {
        case v0 = "0"
        case v2 = "2"
    }

    public let id: String
    public let version: Version
    public let name: String

    // MARK: - Decodable

    private enum Key: String, CodingKey {
        case id
        case version
        case name
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)

        id = try container.decode(String.self, forKey: .id)
        version = try container.decodeIfPresent(Version.self, forKey: .version) ?? .v0
        name = try container.decode(String.self, forKey: .name)
    }

}
