//
//  Optional+Ext.swift
//  QuadrantAssignment
//
//  Created by Rachmat Wahyu Pramono on 19/09/22.
//

import Foundation

public extension Optional {
    func ifNil(_ then: Wrapped) -> Wrapped {
        switch self {
        case .none: return then
        case let .some(value): return value
        }
    }
}
