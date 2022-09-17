//
//  Quadrant_AssignmentApp.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 16/09/22.
//

import SwiftUI
import Foundation

@main
struct Quadrant_AssignmentApp: App {
    
    var body: some Scene {
        WindowGroup {
            let jsonDecoder = JSONDecoder()
            let urlSession = URLSession(configuration: .ephemeral)
            let networkService = NetworkService(session: urlSession, decoder: jsonDecoder)
            let preferenceService = PreferenceService(container: UserDefaults.standard)
            let service = ServicesProvider(networkService: networkService, preferenceService: preferenceService)
            let viewModel = CurrentPriceViewModel(service: service)

            CurrentPriceContentView(viewModel: viewModel)
                .environment(\.colorScheme, .light)
                .preferredColorScheme(.light)
        }
    }
}
