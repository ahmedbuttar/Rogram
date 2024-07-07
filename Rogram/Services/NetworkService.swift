//
//  NetworkService.swift
//  Rogram
//
//  Created by Ahmed Buttar on 7/6/24.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    
    /// Execute a simple network request
    func request(request: URLRequest) -> AnyPublisher<Response, Error>
}

class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    
    init(sessionConfiguration: URLSessionConfiguration = .default) {
        session = URLSession(configuration: sessionConfiguration)
    }
    
    func request(request: URLRequest) -> AnyPublisher<Response, Error> {
        return Future<Response, Error> { [weak self] promise in
            guard let self = self else { return }
            let dataTask = self.session.dataTask(with: request) { data, response, error in
                if let data = data {
                    promise(.success(Response(data: data)))
                }
                
                if let error = error {
                    promise(.failure(error))
                }
            }
            dataTask.resume()
        }
        .eraseToAnyPublisher()
    }
    
}

