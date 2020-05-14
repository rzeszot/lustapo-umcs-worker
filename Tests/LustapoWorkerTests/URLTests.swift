import XCTest
@testable import LustapoWorker

final class URLTests: XCTestCase {

    // MARK: -

    func testStationURLv0() {
        let url = URL(station: .sample(version: .v0))

        XCTAssertEqual(url.absoluteString, "http://212.182.4.252/data.php?s=123")
    }

    func testStationURLv2() {
        let url = URL(station: .sample(version: .v2))

        XCTAssertEqual(url.absoluteString, "http://212.182.4.252/data2.php?s=123")
    }

    // MARK: -

    func testBaseURLv0() {
        let url = URL(version: .v0)

        XCTAssertEqual(url.absoluteString, "http://212.182.4.252/data.php")
    }

    func testBaseURLv2() {
        let url = URL(version: .v2)

        XCTAssertEqual(url.absoluteString, "http://212.182.4.252/data2.php")
    }

    // MARK: -

    static var allTests = [
        ("testStationURLv0", testStationURLv0),
        ("testStationURLv2", testStationURLv2),
        ("testBaseURLv0", testBaseURLv0),
        ("testBaseURLv2", testBaseURLv2)
    ]

}

private extension Station {
    static func sample(version: Version, name: String = "Test Station") -> Self {
        try! JSONDecoder().decode(Station.self, from: """
            {
                "id": "123",
                "version": "\(version.rawValue)",
                "name": "\(name)"
            }
            """.data(using: .utf8)!)
    }
}
