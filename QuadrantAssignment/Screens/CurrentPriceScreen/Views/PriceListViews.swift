//
//  PriceListViews.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import SwiftUI

struct PriceListViews: View {
    var data: DetailPriceData
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Price: \(data.price)")

                Text("Longitude: \(data.long)")
                
                Text("Latitude: \(data.lat)")

            }
            Spacer()
            Text("Time: \(data.timeString)")
        }
        .padding(.vertical, 8)
    }
}
