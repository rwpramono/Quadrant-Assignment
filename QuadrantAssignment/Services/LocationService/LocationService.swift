//
//  LocationService.swift
//  QuadrantAssignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import Combine
import Foundation
import CoreLocation

public final class LocationService: NSObject, ObservableObject, LocationProtocol {
    private let locationManager: CLLocationManager
    
    @Published private(set) var lastSeenLocation: CLLocation?
    @Published private(set) var currentPlacemark: CLPlacemark?
    @Published private(set) var authorizationStatus: CLAuthorizationStatus

    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        self.authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    public func updateLocation() {
        locationManager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    public func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
    }
}
