import XCTest
@testable import DemoFramework

final class DemoFrameworkColorTests: XCTestCase {
    func test_colorRed_isEqual() {
        let color = DemoFramework.Color.fromHexString("FF0000")
        XCTAssertEqual(color, .red)
    }
    
    func test_razeColors_areEqual() {
        let color = DemoFramework.Color.fromHexString("006736")
        XCTAssertEqual(color, DemoFramework.Color.razeColor)
    }
    
    func test_secondaryRazeColors_areEqual() {
        let color = DemoFramework.Color.fromHexString("FCFFFD")
        XCTAssertEqual(color, DemoFramework.Color.secondaryRazeColor)
    }
}
