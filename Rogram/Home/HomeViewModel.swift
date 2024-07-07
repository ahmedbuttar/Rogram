//
//  HomeViewModel.swift
//  Rogram
//
//  Created by Ahmed Buttar on 7/6/24.
//

import Foundation
import Combine

protocol HomeViewModelProtocol {
    
    /// List of connections visible to user.
    func refreshData() -> AnyPublisher<PhotosSnapshot, Never>
    
    /// Get photo from id
    func getPhoto(with id: Int) -> Photo?
}

class HomeViewModel: HomeViewModelProtocol {
    
    private let getPhotosUseCase: GetPhotosUseCaseful
    
    private var photos: Photos = []
    
    init(getPhotosUseCase: GetPhotosUseCaseful) {
        self.getPhotosUseCase = getPhotosUseCase
    }
    
    func refreshData() -> AnyPublisher<PhotosSnapshot, Never> {
        getPhotosUseCase.getPhotos()
            .catch ({ error -> AnyPublisher<Photos, Never> in
                // Handle error
                return Empty<Photos, Never>().eraseToAnyPublisher()
            })
            .map { [weak self] photos -> PhotosSnapshot in
                self?.photos = photos
                
                var snapshot = PhotosSnapshot()
                
                let section = "photos"
                snapshot.appendSections([section])
                
                let models = photos.map { PhotosCellModel(identifier: $0.id, title: $0.title, imageUrl: $0.thumbnailUrl) }
                snapshot.appendItems(models, toSection: section)
                
                return snapshot
            }
            .eraseToAnyPublisher()
    }
    
    func getPhoto(with id: Int) -> Photo? {
        return photos.filter({ $0.id == id }).first
    }
    
}
