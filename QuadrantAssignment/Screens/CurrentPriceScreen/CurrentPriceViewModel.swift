//
//  CurrentPriceViewModel.swift
//  Quadrant-Assignment
//
//  Created by Rachmat Wahyu Pramono on 16/09/22.
//

import Combine
import Foundation
import CoreLocation

internal final class CurrentPriceViewModel: ObservableObject {
    private let service: ServicesProvider
    
    private var bindings = Set<AnyCancellable>()
    private var coordinate = CLLocationCoordinate2D()

    @Published internal var dailyPriceTrend: [Double] = []
    @Published internal var detailPriceDatas: [DetailPriceData] = []

    init(service: ServicesProvider) {
        self.service = service
    }
    
    internal func fetchCurrentPrice(_ onComplete: (() -> ())?) {
        let api = CurrentPriceAPI().fetchCurrentPrice
        service.networkService?.fetch(api)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { results in
                    onComplete?()
                },
                receiveValue: { [weak self] (resultData: CurrentPriceResponse) in
                    guard let self = self else { return }
                    self.saveDailyPriceTrend(resultData)
                    self.saveLatestDetailPrice(resultData)
                }
            ).store(in: &bindings)
    }
    
    internal func askLocationPermission() {
        service.locationService.requestPermission()
    }
    
    private func getLocationDetail() {
        service.locationService.updateLocation()
    }
    
    private func saveDailyPriceTrend(_ resultData: CurrentPriceResponse) {
        var dailyPriceTrend = service.preferenceService.dailyPriceTrend
        resultData.saveDailyPriceTrend(dailyPriceTrend: &dailyPriceTrend)
        service.preferenceService.dailyPriceTrend = dailyPriceTrend
        self.dailyPriceTrend = dailyPriceTrend
    }
    
    private func saveLatestDetailPrice(_ resultData: CurrentPriceResponse) {
        var latestDetailPrice = service.preferenceService.latestDetailPrice
        resultData.saveLatestDetailPrice(
            detailPrice: &latestDetailPrice,
            lat: (service.locationService.lastSeenLocation?.coordinate.latitude).ifNil(0),
            long: (service.locationService.lastSeenLocation?.coordinate.longitude).ifNil(0)
        )
        
        service.preferenceService.latestDetailPrice = latestDetailPrice
        detailPriceDatas = latestDetailPrice
    }
}
