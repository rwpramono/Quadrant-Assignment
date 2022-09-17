//
//  APIDataProtocol.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import Foundation

internal protocol APIDataProtocol {
    var urlComponent: URLComponents { get }
    
    init(path: String, query: [String : String])
    
    func request(_ httpMethod: String) -> URLRequest?
}
