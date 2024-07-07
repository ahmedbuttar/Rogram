//
//  GetPhotosUseCase.swift
//  Rogram
//
//  Created by Ahmed Buttar on 7/6/24.
//

import Foundation
import Combine

protocol GetPhotosUseCaseful {
    
    /// Execute get photos request
    func getPhotos() -> AnyPublisher<Photos, Error>
}

class GetPhotosUseCase: GetPhotosUseCaseful {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getPhotos() -> AnyPublisher<Photos, Error> {
        return networkService.request(request: buildGetPhotosRequest())
            .tryMap { response in
                try response.jsonResponse()
            }
            .eraseToAnyPublisher()
    }
    
    private func buildGetPhotosRequest() -> URLRequest {
        var components: URLComponents = URLComponents(string: "/album/1/photos")!
        components.scheme = "https"
        components.host = "jsonplaceholder.typicode.com"
        
        let url = components.url
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "GET"
                
        return urlRequest
    }
    
}
