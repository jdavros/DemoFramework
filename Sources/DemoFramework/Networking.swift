//
//  Networking.swift
//  DemoFramework
//
//  Created by José Dávalos Rosas on 08/05/22.
//

import Foundation

extension DemoFramework {
    public class Networking {
        public class Manager {
            /// Responsible for handling all networking calls
            /// - Warning: Must create before using any public APIs
            private let session = URLSession.shared
            
            public init() {}
            
            public func loadData(from url: URL, completionHandler: @escaping (NetworkResult<Data>) -> Void) {
                let task = session.dataTask(with: url) { data, response, error in
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    completionHandler(result)
                }
                task.resume()
            }
            
            public enum NetworkResult<Value> {
                case success(Value)
                case failure(Error?)
            }
        }
    }
}
