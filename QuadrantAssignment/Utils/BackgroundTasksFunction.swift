//
//  BackgroundTasksFunction.swift
//  QuadrantAssignment
//
//  Created by Rachmat Wahyu Pramono on 18/09/22.
//

import Combine
import BackgroundTasks

protocol BackgroundTaskProtocol {
    func scheduleAppRefresh()
    func fetchNetwork<T: Codable>(_ apis: APIDataProtocol) -> AnyPublisher<T, Error> 
}

public class BackgroundTask: BackgroundTaskProtocol {
    public let bgFetchRequest = "com.rwpramono.Quadrant.fetchCurrentPrice"
    
    public func scheduleAppRefresh() {
        let fetchRequest = BGAppRefreshTaskRequest(identifier: bgFetchRequest)
        fetchRequest.earliestBeginDate = Date.now.addingTimeInterval(3600)
        try? BGTaskScheduler.shared.submit(fetchRequest)
    }
    
    func fetchNetwork<T: Codable>(_ apis: APIDataProtocol) -> AnyPublisher<T, Error> {
        let jsonDecoder = JSONDecoder()
        let urlSession = URLSession(configuration: .ephemeral)
        let networkService = NetworkService(session: urlSession, decoder: jsonDecoder)
        return networkService.fetch(apis)
    }
}
