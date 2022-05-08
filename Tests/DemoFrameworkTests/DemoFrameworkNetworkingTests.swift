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
            switch result {
            case let .success(returnedData):
                XCTAssertEqual(data, returnedData, "manager returned unexpected data")
            case let .failure(error):
                XCTFail(error?.localizedDescription ?? "error forming error result")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_sendDataCall() {
        // Arrange
        let session = NetworkSessionMock()
        let manager = DemoFramework.Networking.Manager()
        let sampleObject = MockData(id: 1, name: "Jose")
        let data = try? JSONEncoder().encode(sampleObject)
        session.data = data
        manager.session = session
        let url = URL(fileURLWithPath: "url")
        let expectation = expectation(description: "Wait for send data to be completed.")
        
        manager.sendData(to: url, body: sampleObject) { result in
            switch result {
            case let .success(returnedData):
                let returnedObject = try? JSONDecoder().decode(MockData.self, from: returnedData)
                XCTAssertEqual(returnedObject, sampleObject)
            case let .failure(error):
                XCTFail("Expected success but got \(String(describing: error)) instead.")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    struct MockData: Codable, Equatable {
        var id: Int
        var name: String
    }
    
    class NetworkSessionMock: NetworkSession {
        var data: Data?
        var error: Error?
        
        func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
            completionHandler(data, error)
        }
        
        func post(with request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
            completionHandler(data, error)
        }
    }
}
