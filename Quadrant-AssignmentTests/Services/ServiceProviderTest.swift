//
//  ServiceProviderTest.swift
//  Quadrant-AssignmentTests
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import XCTest

@testable import QuadrantAssignment

class ServiceProviderTest: XCTestCase {
    private var sut: ServicesProvider!
    private var networkMock: NetworkServiceSpy!
    
    override func setUpWithError() throws {
        networkMock = NetworkServiceSpy()
        sut = ServicesProvider(networkService: networkMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        networkMock = nil
    }

    func testNetworkServiceShouldExist() throws {
        XCTAssertNotNil(sut.networkService)
    }
}
