//
//  NetworkProtocol.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import Foundation
import Combine

protocol NetworkProtocol: AnyObject {
    func fetch<T: Codable>(_ apiData: APIDataProtocol) -> AnyPublisher<T, Error>
}
