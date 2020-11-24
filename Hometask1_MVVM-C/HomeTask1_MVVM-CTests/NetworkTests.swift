//
//  NetworkTests.swift
//  HomeTask1_MVVM-CTests
//
//  Created by Alex Mostovnikov on 24/11/20.
//

import XCTest
@testable import HomeTask1_MVVM_C

class NetworkTests: XCTestCase {
    var networkService: NetworkService!
    var expectation: XCTestExpectation!
    let apiURL = URL(string: "https://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new")!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        networkService = NetworkService(urlSession: urlSession)
        expectation = expectation(description: "Expectation")
    }
    
    func testSuccessfulResponse() {
        let testDataString = "Test string"
        let data = testDataString.data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url, url == self.apiURL else {
                throw ResponseError(message: "Wrong response")
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        networkService.fetchStrings { (result) in
            switch result {
            case .success(let data):
                XCTAssertTrue(!data.isEmpty)
                XCTAssertTrue(data == testDataString)
            case .failure(_):
                XCTFail("Error is not expected")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
