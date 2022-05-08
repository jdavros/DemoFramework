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
        let session = NetworkSessionMock()
        manager.session = session
        let expectation = expectation(description: "Called for data")
        let data = Data([0, 1, 0, 1])
        session.data = data
        let url = URL(fileURLWithPath: "url")
        
        // Act & Assert
        manager.loadData(from: url) { result in
            expectation.fulfill()
            switch result {
            case let .success(returnedData):
                XCTAssertEqual(data, returnedData, "manager returned unexpected data")
            case let .failure(error):
                XCTFail(error?.localizedDescription ?? "error forming error result")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    class NetworkSessionMock: NetworkSession {
        var data: Data?
        var error: Error?
        
        func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
            completionHandler(data, error)
        }
        
        
    }
}
