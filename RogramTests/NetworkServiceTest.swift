//
//  NetworkServiceTest.swift
//  RogramTests
//
//  Created by Ahmed Buttar on 7/6/24.
//

import Foundation
import Combine
import XCTest

@testable import Rogram

final class NetworkServiceTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func tearDownWithError() throws {
        cancellables = []
        
    }
    
    func testSendRequest() {
        // setup
        let networkServiceExpectation = expectation(description: "Receive no network failure")
        
        let url = URL(string: "https://example.com")!
        let mockData = "Test data".data(using: .utf8)
        MockURLProtocol.mockResponses[url] = mockData
        
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]                
        
        let sut = NetworkService(sessionConfiguration: config)
        let request = URLRequest(url: url)
        
        // exercise
        sut.request(request: request)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { response in 
                XCTAssertEqual(response.data, mockData)
                networkServiceExpectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [networkServiceExpectation], timeout: 2)
    }

    
}

class MockURLProtocol: URLProtocol {
    static var mockResponses: [URL: Data] = [:]
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let url = request.url, let mockResponse = MockURLProtocol.mockResponses[url] {
            self.client?.urlProtocol(self, didLoad: mockResponse)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
