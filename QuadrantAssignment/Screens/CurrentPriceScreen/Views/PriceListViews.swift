//
//  PriceListViews.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import SwiftUI

struct PriceListViews: View {
    var data: CGFloat
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Price: \(123123.123)")

                Text("Longitude: \(123123.123)")
                
                Text("Latitude: \(123123.123)")

            }
            Spacer()
            Text("Time: \(123123.123)")
        }
        .padding(.vertical, 8)
    }
}
