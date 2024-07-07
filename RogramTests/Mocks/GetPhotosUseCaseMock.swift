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
    
    private let photos: Photos
    
    init(with photos: Photos) {
        self.photos = photos
    }
    
    func getPhotos() -> AnyPublisher<Photos, any Error> {
        return Just(photos).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
}
