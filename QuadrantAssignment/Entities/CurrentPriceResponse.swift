//
//  CurrentPriceResponse.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 16/09/22.
//

import Foundation

// MARK: - CurrentPriceResponse
struct CurrentPriceResponse: Codable {
    let time: Time
    let disclaimer, chartName: String
    let bpi: Bpi
    
    func saveDailyPriceTrend(dailyPriceTrend: inout [Double]) {
        let newValue = bpi.usd.rateFloat
        guard dailyPriceTrend.count > 12 else {
            dailyPriceTrend.append(newValue)
            return
        }
        
        dailyPriceTrend.removeFirst()
        dailyPriceTrend.insert(newValue, at: 11)
    }
    
    func saveLatestDetailPrice(detailPrice: inout [DetailPriceData],
                               lat: Double = 0,
                               long: Double = 0) {
        let newValue = DetailPriceData(
            timeString: time.updated,
            price: bpi.usd.rate,
            long: long,
            lat: lat
        )
        
        guard detailPrice.count > 5 else {
            detailPrice.append(newValue)
            return
        }
        
        detailPrice.removeFirst()
        detailPrice.insert(newValue, at: 4)
    }
}

// MARK: - Bpi
struct Bpi: Codable {
    let usd, gbp, eur: Eur

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case gbp = "GBP"
        case eur = "EUR"
    }
}

// MARK: - Eur
struct Eur: Codable {
    let code, symbol, rate, eurDescription: String
    let rateFloat: Double

    enum CodingKeys: String, CodingKey {
        case code, symbol, rate
        case eurDescription = "description"
        case rateFloat = "rate_float"
    }
}

// MARK: - Time
struct Time: Codable {
    let updated: String
    let updatedISO: String
    let updateduk: String
}
