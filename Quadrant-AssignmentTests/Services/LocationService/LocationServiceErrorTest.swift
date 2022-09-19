//
//  LocationServiceErrorTest.swift
//  QuadrantAssignment
//
//  Created by Rachmat Wahyu Pramono on 19/09/22.
//

import XCTest

@testable import QuadrantAssignment

class LocationServiceErrorTest: XCTestCase {
    
    func test_should_return_location_error_failed() throws {
        let sut = LocationServiceError.failed
        XCTAssertEqual(sut.localizedDescription, "Location request failed")
    }
}
