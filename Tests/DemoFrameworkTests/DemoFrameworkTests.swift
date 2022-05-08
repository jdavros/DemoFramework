import XCTest
@testable import DemoFramework

final class DemoFrameworkTests: XCTestCase {
    func test_colorRed_isEqual() {
        let color = DemoFramework.colorFromHexString("FF0000")
        XCTAssertEqual(color, .red)
    }
    
    func test_razeColors_areEqual() {
        let color = DemoFramework.colorFromHexString("006736")
        XCTAssertEqual(color, DemoFramework.razeColor)
    }
}
