import XCTest
@testable import LustapoWorker

final class DateFormatterTests: XCTestCase {

    // MARK: -

    func testDateFormatter() throws {
        let formatter = DateFormatter.remote

        let date = formatter.date(from: "2020-05-14 19:00")

        XCTAssertNotNil(date)
        XCTAssertEqual(date?.timeIntervalSince1970, 1589482800)
    }

    // MARK: -

    static var allTests = [
        ("testDateFormatter", testDateFormatter)
    ]

}
