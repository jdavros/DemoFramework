//
//  DemoFrameworkNetworkingTests.swift
//  DemoFrameworkTests
//
//  Created by José Dávalos Rosas on 08/05/22.
//

import XCTest
@testable import DemoFramework

final class DemoFrameworkNetworkingTests: XCTestCase {
    func test_loadDataCall() {
        // Arrange
        let manager = DemoFramework.Networking.Manager()
        let expectation = expectation(description: "Called for data")
        guard let url = URL(string: "https://google.com") else {
            return XCTFail("Could not create URL properly")
        }
        
        // Act & Assert
        manager.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case let .success(returnedData):
                XCTAssertNotNil(returnedData, "Response data is nil")
            case let .failure(error):
                XCTFail(error?.localizedDescription ?? "error forming error result")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
