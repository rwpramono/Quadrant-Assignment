//
//  AppDelegate.swift
//  QuadrantAssignment
//
//  Created by Rachmat Wahyu Pramono on 19/09/22.
//

import UIKit
import Combine
import Foundation
import BackgroundTasks

internal class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    private var bindings = Set<AnyCancellable>()

    internal var backgroundTask = BackgroundTask()
    internal var preferenceService = PreferenceService(
        container: UserDefaults.standard
    )
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        registerBackgroundFetch()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        backgroundTask.scheduleAppRefresh()
    }
    
    private func registerBackgroundFetch() {
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: backgroundTask.bgFetchRequest,
            using: nil) { [weak self] task in
                guard let self = self else { return }
                task.expirationHandler = {
                    task.setTaskCompleted(success: false)
                }
                
                task.setTaskCompleted(success: true)
                self.backgroundTask.scheduleAppRefresh()
                self.fetchCurrentPrice()
            }
    }
    
    private func fetchCurrentPrice() {
        let api = CurrentPriceAPI().fetchCurrentPrice
        backgroundTask.fetchNetwork(api)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] (resultData: CurrentPriceResponse) in
                    guard let self = self else { return }

                    var dailyPriceTrend = self.preferenceService.dailyPriceTrend
                    resultData.saveDailyPriceTrend(dailyPriceTrend: &dailyPriceTrend)
                    
                    var latestDetailPrice = self.preferenceService.latestDetailPrice
                    resultData.saveLatestDetailPrice(detailPrice: &latestDetailPrice)
                }
            ).store(in: &bindings)
    }
}
