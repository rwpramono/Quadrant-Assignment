//
//  NetworkServiceError.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import Foundation

public enum NetworkServiceError: Error, LocalizedError {
    case failed
    case badRequest
    case noResponseData
    case invalidAPIDataProtocol
    case unableToDecodeResponseData
    case other(message: String?)
    
    public var errorDescription: String? {
        switch self {
        case .failed:
            return "API request failed"
        case .badRequest:
            return "Bad request"
        case .noResponseData:
            return "Empty response data"
        case .invalidAPIDataProtocol:
            return "Invalid API Data Protocol"
        case .unableToDecodeResponseData:
            return "Unable to decode response object"
        case .other(message: let message):
            return message
        }
    }
}
