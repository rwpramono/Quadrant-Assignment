//
//  LocationServiceError.swift
//  QuadrantAssignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import Foundation

public enum LocationServiceError: Error, LocalizedError {
    case failed
    
    public var errorDescription: String? {
        switch self {
        case .failed:
            return "Location request failed"
        }
    }
}
