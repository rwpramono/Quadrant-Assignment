//
//  CurrentPriceContentView.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 16/09/22.
//

import SwiftUI

struct CurrentPriceContentView: View {
    var viewModel: CurrentPriceViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                Text("Price Index")
                    .fontWeight(.bold)
                
                Text("$ 51 200")
                    .font(.system(size: 38, weight: .bold))
            }
            .padding(.top, 48)
            
            
            // Graph View
            LineChartView(data: samplePlot)
                .frame(height: 200)
                .padding(.top, 25)
                .background(Color.white)
                .cornerRadius(18)
            
            ScrollView {
                ForEach(samplePlot, id: \.self) {
                    PriceListViews(data: $0)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(18)
            
            
            Button {
                
            } label: {
                Text("Refresh")
                    .font(.title3.bold())
                    .padding(.vertical)
                    .padding(.horizontal, 100)
                    .background(.white, in: Capsule())
            }
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .top)
        .background(Color(uiColor: .systemGray6))
    }
}
