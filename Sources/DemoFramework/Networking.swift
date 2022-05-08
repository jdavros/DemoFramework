//
//  Networking.swift
//  DemoFramework
//
//  Created by José Dávalos Rosas on 08/05/22.
//

import Foundation

protocol NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { data, _, error in
            completionHandler(data, error)
        }
        task.resume()
    }
}

extension DemoFramework {
    public class Networking {
        public class Manager {
            /// Responsible for handling all networking calls
            /// - Warning: Must create before using any public APIs
            internal var session: NetworkSession = URLSession.shared
            
            public init() {}
            
            /// Calls live internet to retrieve Data from a specific location
            /// - Parameters:
            ///   - url: The location you want to retrieve data from
            ///   - completionHandler: Returns a result object which signifies the status of the request
            public func loadData(from url: URL, completionHandler: @escaping (NetworkResult<Data>) -> Void) {
                session.get(from: url) { data, error in
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    completionHandler(result)
                }
            }
            
            public enum NetworkResult<Value> {
                case success(Value)
                case failure(Error?)
            }
        }
    }
}
