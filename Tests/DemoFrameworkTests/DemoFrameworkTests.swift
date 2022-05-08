import XCTest
@testable import DemoFramework

final class DemoFrameworkTests: XCTestCase {
    func testColorRedEqual() {
        let color = DemoFramework.colorFromHexString("FF0000")
        XCTAssertEqual(color, .red)
    }
}
