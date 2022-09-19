//
//  APIDataV1.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import Foundation

public struct APIDataV1<T: Decodable>: APIDataProtocol {
    let tempDomain = "coindesk.com"
    let tempSubDomain = "api"

    var urlComponent: URLComponents

    init(path: String, query: [String : String]) {
        var components: URLComponents = URLComponents()
        components.scheme = "https"
        components.host = "\(tempSubDomain).\(tempDomain)"
        components.path = "/v1/\(path)"
        components.queryItems = query.keys.map { key in
            URLQueryItem(name: key, value: query[key]?.description)
        }

        self.urlComponent = components
    }
        
    func request(_ httpMethod: String) -> URLRequest? {
        guard let url = urlComponent.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod
        urlRequest.allHTTPHeaderFields = [:]
    
        return urlRequest
    }
}
