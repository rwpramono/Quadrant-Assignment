//
//  NetworkServiceSpy.swift
//  Quadrant-AssignmentTests
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import Combine
import Foundation
@testable import QuadrantAssignment

final class NetworkServiceSpy: NetworkService {
    
    init() {
        let mockDecoder = JSONDecoder()
        let config: URLSessionConfiguration = .ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let mockSession = URLSession(configuration: config)
        super.init(session: mockSession, decoder: mockDecoder)
    }
}
