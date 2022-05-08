//
//  Networking.swift
//  DemoFramework
//
//  Created by José Dávalos Rosas on 08/05/22.
//

import Foundation

protocol NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
    func post(with request: URLRequest, completionHandler: @escaping(Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { data, _, error in
            completionHandler(data, error)
        }
        task.resume()
    }
    
    func post(with request: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: request) { data, _, error in
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
            
            /// Calls the live internet to send data to a specific location
            /// - Warning: Make sure that the URL in question can accept a POST route
            /// - Parameters:
            ///     - url: The location you wish to send data to
            ///     - body: The object you wish to send over the network
            ///     - completionHandler: Returns a result object which signifies the status of the request
            public func sendData<T: Codable>(to url: URL, body: T, completionHandler: @escaping (NetworkResult<Data>) -> Void) {
                var request = URLRequest(url: url)
                do {
                    let httpBody = try JSONEncoder().encode(body)
                    request.httpBody = httpBody
                    request.httpMethod = "POST"
                    session.post(with: request) { data, error in
                        let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                        completionHandler(result)
                    }
                } catch let error {
                    completionHandler(.failure(error))
                }
            }
            
            public enum NetworkResult<Value> {
                case success(Value)
                case failure(Error?)
            }
        }
    }
}
