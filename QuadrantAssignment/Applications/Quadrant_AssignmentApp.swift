//
//  Quadrant_AssignmentApp.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 16/09/22.
//

import SwiftUI
import Foundation
import CoreLocation
import BackgroundTasks

@main
struct Quadrant_AssignmentApp: App {
    @UIApplicationDelegateAdaptor fileprivate var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            let jsonDecoder = JSONDecoder()
            let locationManager = CLLocationManager()
            let urlSession = URLSession(configuration: .ephemeral)
            let networkService = NetworkService(session: urlSession, decoder: jsonDecoder)
            let preferenceService = PreferenceService(container: UserDefaults.standard)
            let locationService = LocationService(locationManager: locationManager)
            let service = ServicesProvider(
                networkService: networkService,
                locationService: locationService,
                preferenceService: preferenceService
            )
            let viewModel = CurrentPriceViewModel(service: service)

            CurrentPriceContentView(viewModel: viewModel)
                .environment(\.colorScheme, .light)
                .preferredColorScheme(.light)
        }
    }
}
