import XCTest
@testable import Greebler

final class GreeblerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Greebler().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
