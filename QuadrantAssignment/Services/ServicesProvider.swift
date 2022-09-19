//
//  ServicesProvider.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import Foundation

internal final class ServicesProvider {
    internal var networkService: NetworkProtocol!
    internal var locationService: LocationService!
    internal var preferenceService: PreferenceService!
    
    init(networkService: NetworkProtocol? = nil,
         locationService: LocationService? = nil,
         preferenceService: PreferenceService? = nil) {
        self.networkService = networkService
        self.locationService = locationService
        self.preferenceService = preferenceService
    }
}
