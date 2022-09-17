//
//  NetworkServiceTest.swift
//  Quadrant-AssignmentTests
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import XCTest
import Combine

@testable import QuadrantAssignment

class NetworkServiceTest: XCTestCase {
    private var sut: NetworkProtocol!
    private var cancellables: Set<AnyCancellable> = []

    private lazy var session: URLSession = {
        let config: URLSessionConfiguration = .ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }()

    override func setUpWithError() throws {
        sut = NetworkService(session: session, decoder: JSONDecoder())
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    struct Dummy: Codable, Hashable {
        let dummyValue: String
    }

    struct DummyAPI {
        func fetchSomething() -> APIDataProtocol {
            return APIDataV1<Dummy>(path: "dummy", query: ["dummy":"dummy"])
        }
    }
    
    func test_fetch_shouldReturn_invalidDecode() throws {
        var result: Result<Dummy, Error>?
        let dummyAPI = DummyAPI().fetchSomething()
        let expectation = self.expectation(description: "NetworkService.Expectation")
        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: dummyAPI.urlComponent.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let jsonData = Data("{}".utf8)
            return (response, jsonData)
        }

        sut.fetch(dummyAPI)
            .map({ result -> Result<Dummy, Error> in Result.success(result)})
            .catch { error -> AnyPublisher<Result<NetworkServiceTest.Dummy, Error>, Never> in
                return Just(.failure(error)).eraseToAnyPublisher()
            }
            .sink(receiveValue: { value in
                result = value
                expectation.fulfill()
        }).store(in: &cancellables)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
        guard case let .failure(result) = result else {
            XCTFail("test_fetch_shouldReturn_invalidDecode is fail")
            return
        }
        
        XCTAssertNotNil(result)
    }
}
