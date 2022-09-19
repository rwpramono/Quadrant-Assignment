//
//  CurrentPriceContentView.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 16/09/22.
//

import SwiftUI

internal struct CurrentPriceContentView: View {
    @StateObject var viewModel: CurrentPriceViewModel
    
    init(viewModel: CurrentPriceViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            VStack(spacing: 10) {
                Text("Bitcoin Price Index")
                    .font(.system(size: 38, weight: .bold))
                Spacer()
            }
            .padding(.top, 48)
            
            LineChartView(data: viewModel.dailyPriceTrend)
                .frame(height: 200)
                .background(Color.white)
                .cornerRadius(18)
            
            ScrollView {
                ForEach(viewModel.detailPriceDatas, id: \.self) {
                    PriceListViews(data: $0)
                    Divider()
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(18)
            
            Button {
                viewModel.fetchCurrentPrice(nil)
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
        .onAppear(perform: {
            viewModel.askLocationPermission()
        })
    }
}
