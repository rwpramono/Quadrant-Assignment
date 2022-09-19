//
//  PreferenceService.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import Foundation

open class PreferenceService {
    let container: UserDefaults
        
    init(container: UserDefaults) {
        self.container = container
    }

    @PreferenceWrapper(key: "daily_price_trend", defaultValue: [0])
    var dailyPriceTrend: [Double]
    
    @PreferenceWrapper(key: "latest_detail_price", defaultValue: [])
    var latestDetailPrice: [DetailPriceData]
}
