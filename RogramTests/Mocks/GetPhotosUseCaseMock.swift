//
//  GetPhotosUseCaseMock.swift
//  RogramTests
//
//  Created by Ahmed Buttar on 7/6/24.
//

import Foundation
import Combine

@testable import Rogram

class GetPhotosUseCaseMock: GetPhotosUseCaseful {
    
    func getPhotos() -> AnyPublisher<Photos, any Error> {
        let photos: Photos = [
            .init(id: 1, albumId: 1, title: "djdnwidjnweikdj", url: URL(string: "https://example.com")!, thumbnailUrl: URL(string: "https://example.com")!),
            .init(id: 2, albumId: 1, title: "dwiuehdiewkdnweijd", url: URL(string: "https://example.com")!, thumbnailUrl: URL(string: "https://example.com")!),
            .init(id: 3, albumId: 1, title: "weiuhdnweijdknewjdkn", url: URL(string: "https://example.com")!, thumbnailUrl: URL(string: "https://example.com")!)
        ]
        
        return Just(photos).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
}
