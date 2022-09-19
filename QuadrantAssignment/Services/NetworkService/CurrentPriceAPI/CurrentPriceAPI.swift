//
//  CurrentPriceAPI.swift
//  QuadrantAssignment
//
//  Created by Rachmat Wahyu Pramono on 19/09/22.
//

import Foundation

internal struct CurrentPriceAPI {
    var fetchCurrentPrice: APIDataProtocol {
        return APIDataV1<CurrentPriceResponse>(path: "bpi/currentprice.json", query: [:])
    }
}
