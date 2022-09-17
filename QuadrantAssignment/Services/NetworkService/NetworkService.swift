//
//  NetworkService.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import Foundation
import Combine

internal class NetworkService: NetworkProtocol {
    let session: URLSession
    var decoder: JSONDecoder
    
    init(session: URLSession,
         decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }
    
    func fetch<T: Codable>(_ apiData: APIDataProtocol) -> AnyPublisher<T, Error> {
        guard let request = apiData.request("GET") else {
            return Fail(error: NetworkServiceError.invalidAPIDataProtocol).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: request)
            .mapError { _ in NetworkServiceError.badRequest }
            .flatMap { data, response -> AnyPublisher<Data, Error> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: NetworkServiceError.noResponseData).eraseToAnyPublisher()
                }

                guard 200..<300 ~= response.statusCode else {
                    return Fail(error: NetworkServiceError.other(message: "\(response.statusCode)"))
                        .eraseToAnyPublisher()
                }
                
                return Just(data)
                    .mapError { _ in NetworkServiceError.unableToDecodeResponseData }
                    .eraseToAnyPublisher()
            }
            .decode(type: T.self, decoder: decoder)
        .eraseToAnyPublisher()
    }
}
