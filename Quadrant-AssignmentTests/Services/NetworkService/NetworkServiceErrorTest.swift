//
//  NetworkServiceErrorTest.swift
//  Quadrant-AssignmentTests
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import XCTest

@testable import QuadrantAssignment

class NetworkServiceErrorTest: XCTestCase {
    
    func test_should_return_network_error_failed() throws {
        let sut = NetworkServiceError.failed
        XCTAssertEqual(sut.localizedDescription, "API request failed")
    }
    
    func test_should_return_network_error_badRequest() throws {
        let sut = NetworkServiceError.badRequest
        XCTAssertEqual(sut.localizedDescription, "Bad request")
    }

    
    func test_should_return_network_error_noResponseData() throws {
        let sut = NetworkServiceError.noResponseData
        XCTAssertEqual(sut.localizedDescription, "Empty response data")
    }

    
    func test_should_return_network_error_invalidAPIDataProtocol() throws {
        let sut = NetworkServiceError.invalidAPIDataProtocol
        XCTAssertEqual(sut.localizedDescription, "Invalid API Data Protocol")
    }

    func test_should_return_network_error_unableToDecodeResponseData() throws {
        let sut = NetworkServiceError.unableToDecodeResponseData
        XCTAssertEqual(sut.localizedDescription, "Unable to decode response object")
    }

    func test_should_return_network_error_otherMessage() throws {
        let mockedMessage = "Status code 599"
        let sut = NetworkServiceError.other(message: mockedMessage)
        XCTAssertEqual(sut.localizedDescription, mockedMessage)
    }
}
