//
//  HomeViewModelTests.swift
//  RogramTests
//
//  Created by Ahmed Buttar on 7/6/24.
//

import Foundation
import XCTest
import Combine

@testable import Rogram

final class ShowNamesViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        cancellables = []
    }
    
    func testSnapshot() {
        let expectation = self.expectation(description: "should show photos cells")
        
        let photos: Photos = [
            .init(id: 1, albumId: 1, title: "djdnwidjnweikdj", url: URL(string: "https://example.com")!, thumbnailUrl: URL(string: "https://example.com")!),
            .init(id: 2, albumId: 1, title: "dwiuehdiewkdnweijd", url: URL(string: "https://example.com")!, thumbnailUrl: URL(string: "https://example.com")!),
            .init(id: 3, albumId: 1, title: "weiuhdnweijdknewjdkn", url: URL(string: "https://example.com")!, thumbnailUrl: URL(string: "https://example.com")!)
        ]
        
        let getPhotosUseCaseMock = GetPhotosUseCaseMock(with: photos)
        let viewModel = HomeViewModel(getPhotosUseCase: getPhotosUseCaseMock)
        
        let expectedConnectionCellModels: [PhotoCellModel] = photos.map { .init(identifier: $0.id, title: $0.title, imageUrl: $0.url)}
        
        viewModel.refreshData()
            .sink { snapshot in
                XCTAssertEqual(snapshot.itemIdentifiers, expectedConnectionCellModels)
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testGetPhoto() {
        let expectation = self.expectation(description: "should get photo from id")
        
        let photos: Photos = [
            .init(id: 1, albumId: 1, title: "djdnwidjnweikdj", url: URL(string: "https://example.com")!, thumbnailUrl: URL(string: "https://example.com")!),
            .init(id: 2, albumId: 1, title: "dwiuehdiewkdnweijd", url: URL(string: "https://example.com")!, thumbnailUrl: URL(string: "https://example.com")!),
            .init(id: 3, albumId: 1, title: "weiuhdnweijdknewjdkn", url: URL(string: "https://example.com")!, thumbnailUrl: URL(string: "https://example.com")!)
        ]
        
        let getPhotosUseCaseMock = GetPhotosUseCaseMock(with: photos)
        let viewModel = HomeViewModel(getPhotosUseCase: getPhotosUseCaseMock)
        
        viewModel.refreshData()
            .sink { [weak viewModel, photos] snapshot in
                XCTAssertEqual(viewModel?.getPhoto(with: 1), photos[0])
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
}
