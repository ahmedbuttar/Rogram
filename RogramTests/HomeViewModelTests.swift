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
        
        let getPhotosUseCaseMock = GetPhotosUseCaseMock()
        let viewModel = HomeViewModel(getPhotosUseCase: getPhotosUseCaseMock)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        
        // just check if they are sorted
        let expectedConnectionCellModels = generateExpectedCellModels()
        
        viewModel.refreshData()
            .sink { snapshot in
                XCTAssertEqual(snapshot.itemIdentifiers, expectedConnectionCellModels)
                
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 5)
    }
    
    func generateExpectedCellModels() -> [PhotosCellModel] {
        let photos: Photos = [
            .init(id: 1, albumId: 1, title: "djdnwidjnweikdj", url: URL(string: "https://example.com")!, thumbnailUrl: URL(string: "https://example.com")!),
            .init(id: 2, albumId: 1, title: "dwiuehdiewkdnweijd", url: URL(string: "https://example.com")!, thumbnailUrl: URL(string: "https://example.com")!),
            .init(id: 3, albumId: 1, title: "weiuhdnweijdknewjdkn", url: URL(string: "https://example.com")!, thumbnailUrl: URL(string: "https://example.com")!)
        ]
        
        return photos.map { .init(identifier: $0.id, title: $0.title, imageUrl: $0.url)}
    }
    
}
