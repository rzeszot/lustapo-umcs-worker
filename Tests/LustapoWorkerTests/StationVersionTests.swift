import XCTest
@testable import LustapoWorker

final class StationVersionTests: XCTestCase {

    func testVersionParsingV0() throws {
        let json = """
                "0"
            """

        let version: Station.Version = try decode(from: json)

        XCTAssertEqual(version, .v0)
    }

    func testVersionParsingV2() throws {
        let json = """
                "2"
            """

        let version: Station.Version = try decode(from: json)

        XCTAssertEqual(version, .v2)
    }

    // MARK: -

    func decode<T: Decodable>(from string: String) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: string.data(using: .utf8)!)
    }

    // MARK: -

    static var allTests = [
        ("testVersionParsingV0", testVersionParsingV0),
        ("testVersionParsingV2", testVersionParsingV2)
    ]

}
