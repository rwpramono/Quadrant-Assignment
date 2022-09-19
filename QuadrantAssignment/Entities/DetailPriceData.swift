//
//  DetailPriceData.swift
//  QuadrantAssignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import Foundation

struct DetailPriceData: Codable, Hashable {
    var timeString: String
    var price: String
    var long: Double
    var lat: Double
}
